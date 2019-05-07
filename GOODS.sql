CREATE DATABASE  IF NOT EXISTS `GOODS`;
USE `GOODS`;

DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
   `Name` varchar(50) NOT NULL COMMENT 'Country name',
   `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
     PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP VIEW IF EXISTS country_index;
CREATE VIEW country_index AS
SELECT id,Name FROM country;



DROP TABLE IF EXISTS `manufactur`;
CREATE TABLE `manufactur` (
   `Name` varchar(50) NOT NULL COMMENT 'Manuf. name',
   `country_id` int(10) UNSIGNED NOT NULL,
   FOREIGN KEY(country_id) REFERENCES country(id),
   `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
     PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP VIEW IF EXISTS manufactur_index;
CREATE VIEW manufactur_index AS
SELECT id,Name,
(SELECT name FROM `country` WHERE country.id=manufactur.country_id) as country_name,country_id
 FROM manufactur;


DROP VIEW IF EXISTS countrymanufactur_country;

CREATE VIEW countrymanufactur_country AS 
SELECT 
Tparent.id AS country_id, Tparent.Name AS country_Name 
FROM `manufactur` Tchild 
INNER JOIN `country` Tparent 
ON country_id=Tparent.id;

/*-------   ---    ------*/
DROP VIEW IF EXISTS countrymanufactur_country_index;

CREATE VIEW countrymanufactur_country_index AS 
SELECT id,Name,(SELECT name FROM `country` WHERE country.id=manufactur.country_id) as country_name FROM `manufactur`;






DROP PROCEDURE if exists `getCountryName`;

DELIMITER $$
CREATE PROCEDURE `getCountryName`
(IN `idParam` INT(10))
begin
select name from country where country.id=idParam;
end
$$DELIMITER ;



DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
   `name` varchar(50) NOT NULL COMMENT 'Good name',
   `photo` MEDIUMTEXT NOT NULL COMMENT 'Good photo',
   `price` varchar(5) NOT NULL COMMENT 'Price',
   `onstock` varchar(5) NOT NULL COMMENT 'Count on stock',
   `manufactur_id` int(10) UNSIGNED NOT NULL,
   FOREIGN KEY(manufactur_id) REFERENCES manufactur(id),
   `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
     PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP VIEW IF EXISTS goods_index;
CREATE VIEW goods_index AS
SELECT id,name,photo,price,onstock,
(SELECT name FROM `manufactur` WHERE manufactur.id=goods.manufactur_id) as manufactur_name,manufactur_id
 FROM goods;


DROP VIEW IF EXISTS manufacturgoods_manufactur;

CREATE VIEW manufacturgoods_manufactur AS 
SELECT 
Tparent.id AS manufactur_id, Tparent.Name AS manufactur_Name 
FROM `goods` Tchild 
INNER JOIN `manufactur` Tparent 
ON manufactur_id=Tparent.id;

/*-------   ---    ------*/
DROP VIEW IF EXISTS manufacturgoods_manufactur_index;

CREATE VIEW manufacturgoods_manufactur_index AS 
SELECT id,name, photo, price, onstock,(SELECT name FROM `manufactur` WHERE manufactur.id=goods.manufactur_id) as manufactur_name FROM `goods`;






DROP PROCEDURE if exists `getManufacturName`;

DELIMITER $$
CREATE PROCEDURE `getManufacturName`
(IN `idParam` INT(10))
begin
select name from manufactur where manufactur.id=idParam;
end
$$DELIMITER ;





