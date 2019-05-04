-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Май 04 2019 г., 03:01
-- Версия сервера: 10.1.37-MariaDB
-- Версия PHP: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `komraz8`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `login` ()  NO SQL
BEGIN
select User_account.Login,
User_account.Password, 
Post.Title,
Staff.ID_staff,
Staff.Full_name
FROM User_account,Staff, Post
WHERE User_account.ID_staff = Staff.ID_staff and Staff.ID_post = Post.ID_post;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_lease_contract` ()  NO SQL
BEGIN
select Contract.Number_of_contract,
Contract.Date,
Contract.Amount,
Rental_object.Address,
Type_contract.Title,
Kind_of_contract.Title,
Contract.ID_staff,
Contract.ID_rental_object,
Contract.ID_search_object,
Rental_object.Square,
Rental_object.Description,
Rental_object.Year_built,
Rental_object.Wall_material,
Rental_object.Floor,
Rental_object.Number_of_floors,
Contract.ID_type_contract

FROM Contract, Rental_object,Type_contract,Kind_of_contract
WHERE Contract.ID_rental_object = Rental_object.ID_rental_object AND Contract.ID_type_contract = Type_contract.ID_type_contract and Kind_of_contract.ID_kind_of_contract = Type_contract.ID_kind_of_contract;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_payments_receipt_contract` ()  NO SQL
BEGIN 
select 
Payment_receipt.ID_payment_receipt,
Payment_receipt.Amount,
Payment_receipt.Date_of_payment,
Payment_receipt.ID_client,
Type_of_payment_document.Title
FROM Payment_receipt, Type_of_payment_document
WHERE Payment_receipt.ID_type_of_payment = Type_of_payment_document.ID_type_of_payment; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_payments_service` ()  NO SQL
BEGIN
select Contract.Number_of_contract,
Contract.Date,
Contract.Amount,
Rental_object.Address,
Type_contract.Title,
Status_ob.title,
Rental_object.Description, 
Staff.full_name,
Payment_period.title

FROM Contract, Rental_object,Type_contract, Status_ob, Staff, Payment_period
WHERE Contract.ID_rental_object = Rental_object.ID_rental_object AND Contract.ID_type_contract = Type_contract.ID_type_contract AND Contract.ID_status_ob = Status_ob.ID_status 
and Contract.ID_rental_object = Rental_object.Id_rental_object and Contract.Id_staff = Staff.Id_staff
and Contract.Id_payment_period = Payment_period.Id_payment_period
;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_rental_object` ()  NO SQL
BEGIN
select Rental_object.ID_rental_object,
Rental_object.Square,
Rental_object.Description,
Rental_object.Year_built,
Rental_object.Wall_material,
Rental_object.Floor,
Rental_object.Number_of_floors,
Rental_object.Prise,
Lease_term.Title,
Object_type.Title,
Object_state.Title,
Rental_object.Address,
Rental_object.ID_client,
Status_ob.title,
Rental_object.ID_rental_object,
Rental_object.ID_staff,
Rental_object.ID_agent,
Staff.Full_name
FROM Rental_object, Lease_term, Object_type, Object_state,Status_ob,Staff
WHERE Rental_object.ID_lease_term = Lease_term.ID_lease_term AND Rental_object.ID_object_type = Object_type.ID_object_type and Rental_object.ID_object_state = Object_state.ID_object_state AND Status_ob.ID_status = Rental_object.ID_status and Staff.ID_staff = Rental_object.ID_agent;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_search_object` ()  NO SQL
BEGIN
select Search_object.Area,
Search_object.Square,
Search_object.Min_price,
Search_object.Max_price,
Search_object.Wall_material,
Search_object.Floor,
Search_object.Number_of_floor,
Object_type.Title,
Search_object.ID_search_object,
Search_object.ID_client,
Status_ob.title,
Search_object.ID_staff
FROM Search_object, Object_type,Status_ob
WHERE Search_object.ID_object_type = Object_type.ID_object_type AND Status_ob.ID_status = Search_object.ID_status;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_service_contract` ()  NO SQL
BEGIN
select Contract.Number_of_contract,
Contract.Date,
Contract.Amount,
Type_contract.Title,
Kind_of_contract.Title
FROM Contract,Type_contract,Kind_of_contract
WHERE Contract.ID_type_contract = Type_contract.ID_type_contract and Type_contract.ID_kind_of_contract = Kind_of_contract.ID_kind_of_contract;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_type_contract` ()  NO SQL
BEGIN
select Type_contract.Title,
Kind_of_contract.Title
FROM Type_contract, Kind_of_contract
WHERE Type_contract.ID_kind_of_contract = Kind_of_contract.ID_kind_of_contract;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_type_contract_of_rent` ()  NO SQL
BEGIN
select Type_contract.ID_type_contract,
Type_contract.Title
FROM Type_contract
WHERE Type_contract.ID_kind_of_contract = 1;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `Client`
--

CREATE TABLE `Client` (
  `ID_client` int(11) NOT NULL,
  `Passport_data` int(11) DEFAULT NULL,
  `TIN` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Client`
--

INSERT INTO `Client` (`ID_client`, `Passport_data`, `TIN`) VALUES
(1, 423432, NULL),
(2, NULL, '32423432'),
(3, 12323132, NULL),
(4, NULL, '342324342'),
(5, 234324, NULL),
(6, 32423432, NULL),
(7, 234324234, NULL),
(8, 324432432, NULL),
(9, NULL, '4243423342'),
(10, NULL, '35345453543435543');

-- --------------------------------------------------------

--
-- Структура таблицы `Contract`
--

CREATE TABLE `Contract` (
  `Number_of_contract` int(11) NOT NULL,
  `Date` date DEFAULT NULL,
  `ID_rental_object` int(11) DEFAULT NULL,
  `ID_staff` int(11) DEFAULT NULL,
  `ID_type_contract` int(11) DEFAULT NULL,
  `Amount` double DEFAULT NULL,
  `ID_payment_period` int(11) DEFAULT NULL,
  `ID_search_object` int(11) DEFAULT NULL,
  `ID_status_ob` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Contract`
--

INSERT INTO `Contract` (`Number_of_contract`, `Date`, `ID_rental_object`, `ID_staff`, `ID_type_contract`, `Amount`, `ID_payment_period`, `ID_search_object`, `ID_status_ob`) VALUES
(3, '2018-11-14', 2, 1, 1, 5000, 8, 1, 1),
(4, '2018-12-05', 2, 4, 2, 5000, 8, 4, 4),
(6, '2019-02-06', 2, 1, 3, 10000, 4, 1, 3),
(7, '2018-09-05', 22, 4, 4, 15000, 4, 4, 2),
(8, '2019-05-03', 1, 6, 2, 10000, 4, NULL, 1),
(9, '2019-05-08', 19, 1, 2, 15000, 6, NULL, 4),
(10, '2019-05-02', NULL, 2, 1, 5000, 8, 2, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `ContractClient`
--

CREATE TABLE `ContractClient` (
  `ID_Client_contract` int(11) NOT NULL,
  `Number_of_contract` int(11) DEFAULT NULL,
  `ID_client` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ContractClient`
--

INSERT INTO `ContractClient` (`ID_Client_contract`, `Number_of_contract`, `ID_client`) VALUES
(1, 3, 1),
(2, 3, 2),
(3, 4, 1),
(4, 4, 6);

-- --------------------------------------------------------

--
-- Структура таблицы `Kind_of_contract`
--

CREATE TABLE `Kind_of_contract` (
  `ID_kind_of_contract` int(11) NOT NULL,
  `Title` char(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Kind_of_contract`
--

INSERT INTO `Kind_of_contract` (`ID_kind_of_contract`, `Title`) VALUES
(1, 'Договор оказания возмездных услуг'),
(2, 'Договор аренды');

-- --------------------------------------------------------

--
-- Структура таблицы `Lease_term`
--

CREATE TABLE `Lease_term` (
  `ID_lease_term` int(11) NOT NULL,
  `Title` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Lease_term`
--

INSERT INTO `Lease_term` (`ID_lease_term`, `Title`) VALUES
(1, 'Длительный срок'),
(2, 'Посуточно'),
(3, 'Почасовоя');

-- --------------------------------------------------------

--
-- Структура таблицы `Legal_entity`
--

CREATE TABLE `Legal_entity` (
  `TIN` char(20) NOT NULL,
  `Title` char(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Legal_entity`
--

INSERT INTO `Legal_entity` (`TIN`, `Title`) VALUES
('32423432', 'ООО \"Прорыв\"'),
('342324342', 'ООО \"Додон\"'),
('35345453543435543', 'ООО \"Ромашка\"'),
('4243423342', 'АО \"Огонь\"');

-- --------------------------------------------------------

--
-- Структура таблицы `Natural_person`
--

CREATE TABLE `Natural_person` (
  `Passport_data` int(11) NOT NULL,
  `Surname` char(200) DEFAULT NULL,
  `Name` char(200) DEFAULT NULL,
  `Patronymic` char(200) DEFAULT NULL,
  `Gender` char(1) DEFAULT NULL,
  `Date_of_birth` date DEFAULT NULL,
  `Citizenship` char(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Natural_person`
--

INSERT INTO `Natural_person` (`Passport_data`, `Surname`, `Name`, `Patronymic`, `Gender`, `Date_of_birth`, `Citizenship`) VALUES
(234324, 'Дмитриев', 'Ермак', 'Созонович', 'М', '1987-07-17', 'Казахстан'),
(423432, 'Большаков', 'Болеслав', 'Ефимович', 'М', '1987-01-04', 'РФ'),
(12323132, 'Гусев', 'Евдоким', 'Павлович', 'М', '1998-02-12', 'РФ'),
(32423432, 'Карпов', 'Мирослав', 'Евсеевич', 'М', '1967-10-11', 'РФ'),
(234324234, 'Сафонов', 'Савелий', 'Никитевич', 'М', '1978-07-26', 'РФ'),
(324432432, 'Третьяков', 'Бронислав', 'Лаврентьевич', 'М', '1957-10-10', 'РФ');

-- --------------------------------------------------------

--
-- Структура таблицы `Object_Category`
--

CREATE TABLE `Object_Category` (
  `ID_object_category` int(11) NOT NULL,
  `Title` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Object_Category`
--

INSERT INTO `Object_Category` (`ID_object_category`, `Title`) VALUES
(1, 'Жилая'),
(2, 'Комерческая'),
(3, 'Гаражи');

-- --------------------------------------------------------

--
-- Структура таблицы `Object_state`
--

CREATE TABLE `Object_state` (
  `ID_object_state` int(11) NOT NULL,
  `Title` char(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Object_state`
--

INSERT INTO `Object_state` (`ID_object_state`, `Title`) VALUES
(1, 'Типовой'),
(2, 'Без ремонта'),
(3, 'Евроремонт'),
(4, 'Дизайнерский');

-- --------------------------------------------------------

--
-- Структура таблицы `Object_type`
--

CREATE TABLE `Object_type` (
  `ID_object_type` int(11) NOT NULL,
  `Title` char(20) DEFAULT NULL,
  `ID_object_category` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Object_type`
--

INSERT INTO `Object_type` (`ID_object_type`, `Title`, `ID_object_category`) VALUES
(1, 'Хрущевка', 1),
(2, 'Старый фонд', 1),
(3, 'Элитное', 1),
(4, 'Малосемейка', 1),
(5, 'Гостинка', 1),
(6, 'Офис', 2),
(7, 'Торговые помещения', 2),
(8, 'Склад', 2),
(9, 'Свободного назначени', 2),
(10, 'Ракушка', 3),
(11, 'Кооперативный', 3),
(12, 'Железный', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `Payment_period`
--

CREATE TABLE `Payment_period` (
  `ID_payment_period` int(11) NOT NULL,
  `Title` char(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Payment_period`
--

INSERT INTO `Payment_period` (`ID_payment_period`, `Title`) VALUES
(1, 'Ежедневная'),
(2, '1 неделя'),
(3, '2 недели'),
(4, 'Ежемесячно'),
(5, '3 месяца'),
(6, '6 месяцев'),
(7, '1 год'),
(8, 'Полная предоплата'),
(10, 'После выполнения договора');

-- --------------------------------------------------------

--
-- Структура таблицы `Payment_receipt`
--

CREATE TABLE `Payment_receipt` (
  `ID_payment_receipt` int(11) NOT NULL,
  `Amount` double DEFAULT NULL,
  `Date_of_payment` date DEFAULT NULL,
  `ID_client` int(11) DEFAULT NULL,
  `ID_type_of_payment` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Payment_receipt`
--

INSERT INTO `Payment_receipt` (`ID_payment_receipt`, `Amount`, `Date_of_payment`, `ID_client`, `ID_type_of_payment`) VALUES
(1, 13000, '2019-02-26', 4, 2),
(2, 25000, '2019-02-10', 3, 1),
(3, 70000, '2019-01-14', 2, 2),
(4, 150000, '2019-01-24', 10, 1),
(5, 23000, '2019-02-06', 6, 1),
(6, 17000, '2019-02-21', 8, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `Post`
--

CREATE TABLE `Post` (
  `ID_post` int(11) NOT NULL,
  `Title` char(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Post`
--

INSERT INTO `Post` (`ID_post`, `Title`) VALUES
(1, 'Агент'),
(2, 'Сотрудник отдела недвижимости'),
(3, 'Сотрудник отдела аналитики'),
(4, 'Администратор системы');

-- --------------------------------------------------------

--
-- Структура таблицы `Recommend_price_policy`
--

CREATE TABLE `Recommend_price_policy` (
  `ID_recommend_price_policy` int(11) NOT NULL,
  `Start_date` date DEFAULT NULL,
  `End_date` date DEFAULT NULL,
  `ID_type_of_service` int(11) DEFAULT NULL,
  `Amount` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Recommend_price_policy`
--

INSERT INTO `Recommend_price_policy` (`ID_recommend_price_policy`, `Start_date`, `End_date`, `ID_type_of_service`, `Amount`) VALUES
(1, '2019-02-01', '2019-03-15', 2, 3200),
(2, '2019-03-10', '2019-04-14', 2, 15000),
(3, '2019-03-24', '2019-04-21', 1, 13000),
(4, '2019-02-28', '2019-03-14', 1, 17000);

-- --------------------------------------------------------

--
-- Структура таблицы `Rental_object`
--

CREATE TABLE `Rental_object` (
  `ID_rental_object` int(11) NOT NULL,
  `Square` float DEFAULT NULL,
  `Description` char(100) DEFAULT NULL,
  `Year_built` year(4) DEFAULT NULL,
  `Wall_material` char(100) DEFAULT NULL,
  `Floor` int(11) DEFAULT NULL,
  `Number_of_floors` int(11) DEFAULT NULL,
  `Prise` int(11) DEFAULT NULL,
  `ID_lease_term` int(11) DEFAULT NULL,
  `ID_object_type` int(11) DEFAULT NULL,
  `ID_object_state` int(11) DEFAULT NULL,
  `ID_client` int(11) DEFAULT NULL,
  `Address` char(200) DEFAULT NULL,
  `ID_status` int(11) NOT NULL,
  `ID_staff` int(11) NOT NULL,
  `ID_agent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Rental_object`
--

INSERT INTO `Rental_object` (`ID_rental_object`, `Square`, `Description`, `Year_built`, `Wall_material`, `Floor`, `Number_of_floors`, `Prise`, `ID_lease_term`, `ID_object_type`, `ID_object_state`, `ID_client`, `Address`, `ID_status`, `ID_staff`, `ID_agent`) VALUES
(1, 31, 'хор.сост,тихий двор,рядом 42школа,ВУЗы', 1967, 'Панельный', 5, 5, 1000, 2, 1, 1, 1, 'г.Барнаул, Строителей, 39', 1, 2, 1),
(2, 33, 'Окна пластик,,новая металл дверь ,мебель вся,хорошее сост.', 1974, 'Панельный', 1, 9, 1400, 2, 1, 2, 4, 'г.Барнаул, Строителей, 40', 1, 2, 1),
(3, 65, 'Описание отсутствует', 1980, 'Кирпич', 1, 9, 10000, 1, 3, 4, 10, 'г. Барнаул, ул Попова 57', 3, 5, 4),
(7, 45, 'Описание отсутствует', 1979, 'Кирпич', 1, 5, 600, 3, 7, 4, 10, 'г. Барнаул, ул Матросова 12', 2, 5, 4),
(14, 68, 'Описание отсутствует', 1982, 'Кирпич', 4, 9, 1000, 2, 5, 3, 3, 'г. Барнаул, пр-т. Ленина 112', 2, 5, 4),
(18, 52, 'Описание отсутствует', 1998, 'Монолит', 3, 9, 15000, 1, 2, 1, 1, 'г. Барнаул, пр-т Красноармейский 64', 3, 2, 1),
(19, 31, 'Описание отсутствует', 1990, 'Монолит', 1, 9, 1000, 2, 1, 3, 3, 'г.Барнаул, пр-т Социалистический 68', 3, 2, 1),
(20, 71, 'Описание отсутствует', 1959, 'Кирпич', 1, 5, 3000, 2, 3, 4, 5, 'г. Барнаул, пр-т Калинина 54', 3, 5, 4),
(22, 54, '', 2003, 'Панельный', 0, 12, 1500, 2, 1, 1, 3, 'г. Барнаул, ул. Балтийская 12', 1, 2, 1),
(23, 79, 'dsadas', 2004, 'Кирпич', 5, 9, 3000, 3, 9, 4, 7, 'г. Барнаул, Взлетная 18', 4, 2, 1),
(31, 123, 'Проверка', 1980, 'Кирпич', 1, 2, 100000, 1, 7, 3, 8, 'Проверка', 4, 2, 1),
(32, 1, 'Вышли', 1980, 'Вышли', 12, 2, 121, 1, 5, 4, 6, 'Вышли', 4, 2, 4),
(33, 123, '1', 1980, 'Зашли', 1, 1, 1, 1, 6, 4, 3, 'Зашли', 4, 2, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `Sales_plan`
--

CREATE TABLE `Sales_plan` (
  `ID_sales_plan` int(11) NOT NULL,
  `Start_date` date DEFAULT NULL,
  `End_date` date DEFAULT NULL,
  `Amount` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Sales_plan`
--

INSERT INTO `Sales_plan` (`ID_sales_plan`, `Start_date`, `End_date`, `Amount`) VALUES
(1, '2019-01-01', '2019-04-01', 1000000),
(2, '2019-04-01', '2019-07-01', 1300000),
(3, '2019-01-01', '2019-07-01', 2300000),
(4, '2019-03-01', '2019-04-01', 230000);

-- --------------------------------------------------------

--
-- Структура таблицы `Search_object`
--

CREATE TABLE `Search_object` (
  `ID_search_object` int(11) NOT NULL,
  `Area` char(30) DEFAULT NULL,
  `Square` float DEFAULT NULL,
  `Min_price` int(11) DEFAULT NULL,
  `Max_price` int(11) DEFAULT NULL,
  `Wall_material` char(20) DEFAULT NULL,
  `Floor` int(11) DEFAULT NULL,
  `Number_of_floor` char(20) DEFAULT NULL,
  `ID_client` int(11) DEFAULT NULL,
  `ID_object_type` int(11) DEFAULT NULL,
  `ID_status` int(11) NOT NULL,
  `ID_staff` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Search_object`
--

INSERT INTO `Search_object` (`ID_search_object`, `Area`, `Square`, `Min_price`, `Max_price`, `Wall_material`, `Floor`, `Number_of_floor`, `ID_client`, `ID_object_type`, `ID_status`, `ID_staff`) VALUES
(1, 'Барнаул, Центральный', 33, 90000, 12000, 'Кирпичный', 2, '6', 10, 12, 2, 2),
(2, 'Барнаул, Индустриальный', 45, 14000, 10000, 'Кирпичный', 4, '5', 7, 1, 2, 5),
(4, 'г. Барнаул, Ленинский район', 50, 1200, 1000, 'Кирпич', 3, '9', 8, 5, 2, 2),
(5, 'г. Барнаул, Октябрьский район', 30, 11000, 8000, 'Панельный', 1, '5', 10, 12, 4, 5),
(6, 'г. Барнаул, Октябрьский район', 45, 15000, 10000, 'Панельный', 4, '9', 10, 4, 2, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `Staff`
--

CREATE TABLE `Staff` (
  `ID_staff` int(11) NOT NULL,
  `Full_name` char(100) DEFAULT NULL,
  `ID_post` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Staff`
--

INSERT INTO `Staff` (`ID_staff`, `Full_name`, `ID_post`) VALUES
(1, 'Семёнова Наталья Андреевна', 1),
(2, 'Кирсанов Андрей Николаевич', 2),
(3, 'Свиридов Олег Петрович', 3),
(4, 'Фокин Казимир Куприянович', 1),
(5, 'Колесников Нинель Аристархович', 2),
(6, 'Борисов Гордей Иосифович', 4);

-- --------------------------------------------------------

--
-- Структура таблицы `Staff_pricing_policy`
--

CREATE TABLE `Staff_pricing_policy` (
  `ID_staff_pricing_policy` int(11) NOT NULL,
  `ID_recommend_price_policy` int(11) DEFAULT NULL,
  `ID_staff` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Staff_pricing_policy`
--

INSERT INTO `Staff_pricing_policy` (`ID_staff_pricing_policy`, `ID_recommend_price_policy`, `ID_staff`) VALUES
(1, 2, 3),
(2, 3, 3),
(3, 1, 3),
(4, 4, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `Staff_sales_plan`
--

CREATE TABLE `Staff_sales_plan` (
  `ID_staff_sales_plan` int(11) NOT NULL,
  `ID_staff` int(11) DEFAULT NULL,
  `ID_sales_plan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Staff_sales_plan`
--

INSERT INTO `Staff_sales_plan` (`ID_staff_sales_plan`, `ID_staff`, `ID_sales_plan`) VALUES
(1, 1, 2),
(2, 3, 1),
(3, 1, 1),
(4, 3, 3),
(5, 1, 4),
(6, 3, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `Staff_sales_plan_temp`
--

CREATE TABLE `Staff_sales_plan_temp` (
  `ID_plan_temp` int(11) NOT NULL,
  `Rental_plan` int(11) NOT NULL,
  `Search_plan` int(11) NOT NULL,
  `ID_staff` int(11) NOT NULL,
  `Rantal_complete` int(11) NOT NULL,
  `Search_complete` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Staff_sales_plan_temp`
--

INSERT INTO `Staff_sales_plan_temp` (`ID_plan_temp`, `Rental_plan`, `Search_plan`, `ID_staff`, `Rantal_complete`, `Search_complete`) VALUES
(1, 4, 4, 2, 0, 0),
(2, 5, 4, 5, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `Status_ob`
--

CREATE TABLE `Status_ob` (
  `ID_status` int(11) NOT NULL,
  `title` char(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Status_ob`
--

INSERT INTO `Status_ob` (`ID_status`, `title`) VALUES
(1, 'Архив'),
(2, 'Актуальное'),
(3, 'Сдается'),
(4, 'Ожидает оплаты');

-- --------------------------------------------------------

--
-- Структура таблицы `Type_contract`
--

CREATE TABLE `Type_contract` (
  `ID_type_contract` int(11) NOT NULL,
  `Title` char(20) DEFAULT NULL,
  `ID_kind_of_contract` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Type_contract`
--

INSERT INTO `Type_contract` (`ID_type_contract`, `Title`, `ID_kind_of_contract`) VALUES
(1, 'Поиск объекта аренды', 1),
(2, 'Поиск арендаторов', 1),
(3, 'Жилой недвижимости', 2),
(4, 'Коммерческой недвижи', 2),
(5, 'Гараж', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `Type_of_payment_document`
--

CREATE TABLE `Type_of_payment_document` (
  `ID_type_of_payment` int(11) NOT NULL,
  `Title` char(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Type_of_payment_document`
--

INSERT INTO `Type_of_payment_document` (`ID_type_of_payment`, `Title`) VALUES
(1, 'Электронный'),
(2, 'Квитанция');

-- --------------------------------------------------------

--
-- Структура таблицы `Type_of_service`
--

CREATE TABLE `Type_of_service` (
  `ID_type_of_service` int(11) NOT NULL,
  `Title` char(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Type_of_service`
--

INSERT INTO `Type_of_service` (`ID_type_of_service`, `Title`) VALUES
(1, 'Поиск арендаторов'),
(2, 'Поиск объекта аренды');

-- --------------------------------------------------------

--
-- Структура таблицы `User_account`
--

CREATE TABLE `User_account` (
  `ID_user_account` int(11) NOT NULL,
  `Login` char(200) DEFAULT NULL,
  `Password` char(200) DEFAULT NULL,
  `ID_staff` int(11) DEFAULT NULL,
  `ID_client` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `User_account`
--

INSERT INTO `User_account` (`ID_user_account`, `Login`, `Password`, `ID_staff`, `ID_client`) VALUES
(1, '1', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', 1, NULL),
(2, '2', 'd4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35', 2, NULL),
(3, '3', '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', 3, NULL),
(4, '4', '4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a', NULL, 1),
(5, '5', 'ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d', NULL, 3),
(6, '6', 'e7f6c011776e8db7cd330b54174fd76f7d0216b612387a5ffcfb81e6f0919683', NULL, 5),
(7, '7', '7902699be42c8a8e46fbbb4501726517e86b22c56a189f7625a6da49081b2451', NULL, 6),
(8, '8', '2c624232cdd221771294dfbb310aca000a0df6ac8b66b696d90ef06fdefb64a3', NULL, 7),
(9, '9', '19581e27de7ced00ff1ce50b2047e7a567c76b1cbaebabe5ef03f7c3017bb5b7', NULL, 8),
(10, '10', '4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5', NULL, 2),
(11, '11', '4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8', NULL, 4),
(12, '12', '6b51d431df5d7f141cbececcf79edf3dd861c3b4069f0b11661a3eefacbba918', NULL, 9),
(13, '13', '3fdba35f04dc8c462986c992bcf875546257113072a909c162f7e470e581e278', NULL, 10),
(14, '14', '8527a891e224136950ff32ca212b45bc93f69fbb801c3b1ebedac52775f99e61', 4, NULL),
(15, '15', 'e629fa6598d732768f7c726b4b621285f9c3b85303900aa912017db7617d8bdb', 5, NULL),
(16, '16', 'b17ef6d19c7a5b1ee83b907c595526dcb1eb06db8227d650d5dda0a9f4ce8cd9', 6, NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Client`
--
ALTER TABLE `Client`
  ADD PRIMARY KEY (`ID_client`),
  ADD KEY `IX_Relationship40` (`Passport_data`),
  ADD KEY `IX_Relationship41` (`TIN`);

--
-- Индексы таблицы `Contract`
--
ALTER TABLE `Contract`
  ADD PRIMARY KEY (`Number_of_contract`),
  ADD KEY `IX_Relationship8` (`ID_rental_object`),
  ADD KEY `IX_Relationship10` (`ID_staff`),
  ADD KEY `IX_Relationship32` (`ID_type_contract`),
  ADD KEY `IX_Relationship47` (`ID_payment_period`),
  ADD KEY `IX_Relationship55` (`ID_search_object`),
  ADD KEY `ID_status_ob` (`ID_status_ob`);

--
-- Индексы таблицы `ContractClient`
--
ALTER TABLE `ContractClient`
  ADD PRIMARY KEY (`ID_Client_contract`),
  ADD KEY `IX_Relationship56` (`Number_of_contract`),
  ADD KEY `IX_Relationship57` (`ID_client`);

--
-- Индексы таблицы `Kind_of_contract`
--
ALTER TABLE `Kind_of_contract`
  ADD PRIMARY KEY (`ID_kind_of_contract`);

--
-- Индексы таблицы `Lease_term`
--
ALTER TABLE `Lease_term`
  ADD PRIMARY KEY (`ID_lease_term`);

--
-- Индексы таблицы `Legal_entity`
--
ALTER TABLE `Legal_entity`
  ADD PRIMARY KEY (`TIN`);

--
-- Индексы таблицы `Natural_person`
--
ALTER TABLE `Natural_person`
  ADD PRIMARY KEY (`Passport_data`);

--
-- Индексы таблицы `Object_Category`
--
ALTER TABLE `Object_Category`
  ADD PRIMARY KEY (`ID_object_category`);

--
-- Индексы таблицы `Object_state`
--
ALTER TABLE `Object_state`
  ADD PRIMARY KEY (`ID_object_state`);

--
-- Индексы таблицы `Object_type`
--
ALTER TABLE `Object_type`
  ADD PRIMARY KEY (`ID_object_type`),
  ADD KEY `IX_Relationship53` (`ID_object_category`);

--
-- Индексы таблицы `Payment_period`
--
ALTER TABLE `Payment_period`
  ADD PRIMARY KEY (`ID_payment_period`);

--
-- Индексы таблицы `Payment_receipt`
--
ALTER TABLE `Payment_receipt`
  ADD PRIMARY KEY (`ID_payment_receipt`),
  ADD KEY `IX_Relationship51` (`ID_client`),
  ADD KEY `IX_Relationship58` (`ID_type_of_payment`);

--
-- Индексы таблицы `Post`
--
ALTER TABLE `Post`
  ADD PRIMARY KEY (`ID_post`);

--
-- Индексы таблицы `Recommend_price_policy`
--
ALTER TABLE `Recommend_price_policy`
  ADD PRIMARY KEY (`ID_recommend_price_policy`),
  ADD KEY `IX_Relationship22` (`ID_type_of_service`);

--
-- Индексы таблицы `Rental_object`
--
ALTER TABLE `Rental_object`
  ADD PRIMARY KEY (`ID_rental_object`),
  ADD KEY `IX_Relationship6` (`ID_lease_term`),
  ADD KEY `IX_Relationship7` (`ID_object_type`),
  ADD KEY `IX_Relationship36` (`ID_object_state`),
  ADD KEY `IX_Relationship43` (`ID_client`),
  ADD KEY `ID_status` (`ID_status`),
  ADD KEY `ID_staff` (`ID_staff`),
  ADD KEY `ID_agent` (`ID_agent`);

--
-- Индексы таблицы `Sales_plan`
--
ALTER TABLE `Sales_plan`
  ADD PRIMARY KEY (`ID_sales_plan`);

--
-- Индексы таблицы `Search_object`
--
ALTER TABLE `Search_object`
  ADD PRIMARY KEY (`ID_search_object`),
  ADD KEY `IX_Relationship42` (`ID_client`),
  ADD KEY `IX_Relationship50` (`ID_object_type`),
  ADD KEY `ID_status` (`ID_status`),
  ADD KEY `ID_staff` (`ID_staff`);

--
-- Индексы таблицы `Staff`
--
ALTER TABLE `Staff`
  ADD PRIMARY KEY (`ID_staff`),
  ADD KEY `IX_Relationship15` (`ID_post`);

--
-- Индексы таблицы `Staff_pricing_policy`
--
ALTER TABLE `Staff_pricing_policy`
  ADD PRIMARY KEY (`ID_staff_pricing_policy`),
  ADD KEY `IX_Relationship27` (`ID_recommend_price_policy`),
  ADD KEY `IX_Relationship28` (`ID_staff`);

--
-- Индексы таблицы `Staff_sales_plan`
--
ALTER TABLE `Staff_sales_plan`
  ADD PRIMARY KEY (`ID_staff_sales_plan`),
  ADD KEY `IX_Relationship25` (`ID_staff`),
  ADD KEY `IX_Relationship26` (`ID_sales_plan`);

--
-- Индексы таблицы `Staff_sales_plan_temp`
--
ALTER TABLE `Staff_sales_plan_temp`
  ADD PRIMARY KEY (`ID_plan_temp`),
  ADD KEY `ID_staff` (`ID_staff`);

--
-- Индексы таблицы `Status_ob`
--
ALTER TABLE `Status_ob`
  ADD PRIMARY KEY (`ID_status`);

--
-- Индексы таблицы `Type_contract`
--
ALTER TABLE `Type_contract`
  ADD PRIMARY KEY (`ID_type_contract`),
  ADD KEY `IX_Relationship52` (`ID_kind_of_contract`);

--
-- Индексы таблицы `Type_of_payment_document`
--
ALTER TABLE `Type_of_payment_document`
  ADD PRIMARY KEY (`ID_type_of_payment`);

--
-- Индексы таблицы `Type_of_service`
--
ALTER TABLE `Type_of_service`
  ADD PRIMARY KEY (`ID_type_of_service`);

--
-- Индексы таблицы `User_account`
--
ALTER TABLE `User_account`
  ADD PRIMARY KEY (`ID_user_account`),
  ADD KEY `IX_Relationship2` (`ID_staff`),
  ADD KEY `IX_Relationship45` (`ID_client`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Client`
--
ALTER TABLE `Client`
  MODIFY `ID_client` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `Contract`
--
ALTER TABLE `Contract`
  MODIFY `Number_of_contract` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `ContractClient`
--
ALTER TABLE `ContractClient`
  MODIFY `ID_Client_contract` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `Kind_of_contract`
--
ALTER TABLE `Kind_of_contract`
  MODIFY `ID_kind_of_contract` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `Lease_term`
--
ALTER TABLE `Lease_term`
  MODIFY `ID_lease_term` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `Natural_person`
--
ALTER TABLE `Natural_person`
  MODIFY `Passport_data` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=324432433;

--
-- AUTO_INCREMENT для таблицы `Object_Category`
--
ALTER TABLE `Object_Category`
  MODIFY `ID_object_category` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `Object_state`
--
ALTER TABLE `Object_state`
  MODIFY `ID_object_state` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `Object_type`
--
ALTER TABLE `Object_type`
  MODIFY `ID_object_type` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `Payment_period`
--
ALTER TABLE `Payment_period`
  MODIFY `ID_payment_period` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `Payment_receipt`
--
ALTER TABLE `Payment_receipt`
  MODIFY `ID_payment_receipt` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `Post`
--
ALTER TABLE `Post`
  MODIFY `ID_post` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `Recommend_price_policy`
--
ALTER TABLE `Recommend_price_policy`
  MODIFY `ID_recommend_price_policy` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `Rental_object`
--
ALTER TABLE `Rental_object`
  MODIFY `ID_rental_object` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT для таблицы `Sales_plan`
--
ALTER TABLE `Sales_plan`
  MODIFY `ID_sales_plan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `Search_object`
--
ALTER TABLE `Search_object`
  MODIFY `ID_search_object` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `Staff`
--
ALTER TABLE `Staff`
  MODIFY `ID_staff` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `Staff_pricing_policy`
--
ALTER TABLE `Staff_pricing_policy`
  MODIFY `ID_staff_pricing_policy` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `Staff_sales_plan`
--
ALTER TABLE `Staff_sales_plan`
  MODIFY `ID_staff_sales_plan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `Status_ob`
--
ALTER TABLE `Status_ob`
  MODIFY `ID_status` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `Type_contract`
--
ALTER TABLE `Type_contract`
  MODIFY `ID_type_contract` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `Type_of_payment_document`
--
ALTER TABLE `Type_of_payment_document`
  MODIFY `ID_type_of_payment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `Type_of_service`
--
ALTER TABLE `Type_of_service`
  MODIFY `ID_type_of_service` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `User_account`
--
ALTER TABLE `User_account`
  MODIFY `ID_user_account` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Client`
--
ALTER TABLE `Client`
  ADD CONSTRAINT `Relationship40` FOREIGN KEY (`Passport_data`) REFERENCES `Natural_person` (`Passport_data`),
  ADD CONSTRAINT `Relationship41` FOREIGN KEY (`TIN`) REFERENCES `Legal_entity` (`TIN`);

--
-- Ограничения внешнего ключа таблицы `Contract`
--
ALTER TABLE `Contract`
  ADD CONSTRAINT `Contract_ibfk_1` FOREIGN KEY (`ID_status_ob`) REFERENCES `Status_ob` (`ID_status`),
  ADD CONSTRAINT `R10` FOREIGN KEY (`ID_staff`) REFERENCES `Staff` (`ID_staff`),
  ADD CONSTRAINT `R32` FOREIGN KEY (`ID_type_contract`) REFERENCES `Type_contract` (`ID_type_contract`),
  ADD CONSTRAINT `R8` FOREIGN KEY (`ID_rental_object`) REFERENCES `Rental_object` (`ID_rental_object`),
  ADD CONSTRAINT `Relationship47` FOREIGN KEY (`ID_payment_period`) REFERENCES `Payment_period` (`ID_payment_period`),
  ADD CONSTRAINT `Relationship55` FOREIGN KEY (`ID_search_object`) REFERENCES `Search_object` (`ID_search_object`);

--
-- Ограничения внешнего ключа таблицы `ContractClient`
--
ALTER TABLE `ContractClient`
  ADD CONSTRAINT `Relationship56` FOREIGN KEY (`Number_of_contract`) REFERENCES `Contract` (`Number_of_contract`),
  ADD CONSTRAINT `Relationship57` FOREIGN KEY (`ID_client`) REFERENCES `Client` (`ID_client`);

--
-- Ограничения внешнего ключа таблицы `Object_type`
--
ALTER TABLE `Object_type`
  ADD CONSTRAINT `Relationship53` FOREIGN KEY (`ID_object_category`) REFERENCES `Object_Category` (`ID_object_category`);

--
-- Ограничения внешнего ключа таблицы `Payment_receipt`
--
ALTER TABLE `Payment_receipt`
  ADD CONSTRAINT `Relationship51` FOREIGN KEY (`ID_client`) REFERENCES `Client` (`ID_client`),
  ADD CONSTRAINT `Relationship58` FOREIGN KEY (`ID_type_of_payment`) REFERENCES `Type_of_payment_document` (`ID_type_of_payment`);

--
-- Ограничения внешнего ключа таблицы `Recommend_price_policy`
--
ALTER TABLE `Recommend_price_policy`
  ADD CONSTRAINT `Relationship22` FOREIGN KEY (`ID_type_of_service`) REFERENCES `Type_of_service` (`ID_type_of_service`);

--
-- Ограничения внешнего ключа таблицы `Rental_object`
--
ALTER TABLE `Rental_object`
  ADD CONSTRAINT `R6` FOREIGN KEY (`ID_lease_term`) REFERENCES `Lease_term` (`ID_lease_term`),
  ADD CONSTRAINT `R7` FOREIGN KEY (`ID_object_type`) REFERENCES `Object_type` (`ID_object_type`),
  ADD CONSTRAINT `Relationship36` FOREIGN KEY (`ID_object_state`) REFERENCES `Object_state` (`ID_object_state`),
  ADD CONSTRAINT `Relationship43` FOREIGN KEY (`ID_client`) REFERENCES `Client` (`ID_client`),
  ADD CONSTRAINT `Rental_object_ibfk_1` FOREIGN KEY (`ID_status`) REFERENCES `Status_ob` (`ID_status`),
  ADD CONSTRAINT `Rental_object_ibfk_2` FOREIGN KEY (`ID_staff`) REFERENCES `Staff` (`ID_staff`),
  ADD CONSTRAINT `Rental_object_ibfk_3` FOREIGN KEY (`ID_agent`) REFERENCES `Staff` (`ID_staff`);

--
-- Ограничения внешнего ключа таблицы `Search_object`
--
ALTER TABLE `Search_object`
  ADD CONSTRAINT `Relationship42` FOREIGN KEY (`ID_client`) REFERENCES `Client` (`ID_client`),
  ADD CONSTRAINT `Relationship50` FOREIGN KEY (`ID_object_type`) REFERENCES `Object_type` (`ID_object_type`),
  ADD CONSTRAINT `Search_object_ibfk_1` FOREIGN KEY (`ID_status`) REFERENCES `Status_ob` (`ID_status`),
  ADD CONSTRAINT `Search_object_ibfk_2` FOREIGN KEY (`ID_staff`) REFERENCES `Staff` (`ID_staff`);

--
-- Ограничения внешнего ключа таблицы `Staff`
--
ALTER TABLE `Staff`
  ADD CONSTRAINT `R15` FOREIGN KEY (`ID_post`) REFERENCES `Post` (`ID_post`);

--
-- Ограничения внешнего ключа таблицы `Staff_pricing_policy`
--
ALTER TABLE `Staff_pricing_policy`
  ADD CONSTRAINT `R27` FOREIGN KEY (`ID_recommend_price_policy`) REFERENCES `Recommend_price_policy` (`ID_recommend_price_policy`),
  ADD CONSTRAINT `R28` FOREIGN KEY (`ID_staff`) REFERENCES `Staff` (`ID_staff`);

--
-- Ограничения внешнего ключа таблицы `Staff_sales_plan`
--
ALTER TABLE `Staff_sales_plan`
  ADD CONSTRAINT `R25` FOREIGN KEY (`ID_staff`) REFERENCES `Staff` (`ID_staff`),
  ADD CONSTRAINT `R26` FOREIGN KEY (`ID_sales_plan`) REFERENCES `Sales_plan` (`ID_sales_plan`);

--
-- Ограничения внешнего ключа таблицы `Staff_sales_plan_temp`
--
ALTER TABLE `Staff_sales_plan_temp`
  ADD CONSTRAINT `Staff_sales_plan_temp_ibfk_1` FOREIGN KEY (`ID_staff`) REFERENCES `Staff` (`ID_staff`);

--
-- Ограничения внешнего ключа таблицы `Type_contract`
--
ALTER TABLE `Type_contract`
  ADD CONSTRAINT `Relationship52` FOREIGN KEY (`ID_kind_of_contract`) REFERENCES `Kind_of_contract` (`ID_kind_of_contract`);

--
-- Ограничения внешнего ключа таблицы `User_account`
--
ALTER TABLE `User_account`
  ADD CONSTRAINT `R45` FOREIGN KEY (`ID_client`) REFERENCES `Client` (`ID_client`),
  ADD CONSTRAINT `Relationship2` FOREIGN KEY (`ID_staff`) REFERENCES `Staff` (`ID_staff`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
