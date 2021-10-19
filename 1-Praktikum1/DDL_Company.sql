-- BERASUMSI DISINI SUDAH CREATE DATABASE COMPANY

USE COMPANY
GO

DROP TABLE IF EXISTS [DEPENDENT]
DROP TABLE IF EXISTS WORKS_ON
DROP TABLE IF EXISTS PROJECT
DROP TABLE IF EXISTS DEPT_LOCATIONS

IF (OBJECT_ID('FK_MGRSSNDEPT', 'F') IS NOT NULL)
BEGIN
ALTER TABLE DEPARTMENT DROP CONSTRAINT FK_MGRSSNDEPT
END

IF (OBJECT_ID('FK_DNOEMPLY', 'F') IS NOT NULL)
BEGIN
ALTER TABLE EMPLOYEE DROP CONSTRAINT FK_DNOEMPLY
END

DROP TABLE IF EXISTS DEPARTMENT
DROP TABLE IF EXISTS EMPLOYEE

CREATE TABLE EMPLOYEE (
    FNAME VARCHAR (30) NOT NULL,
    MINIT VARCHAR (30) NOT NULL,
    LNAME VARCHAR (30) NOT NULL,
    SSN INT PRIMARY KEY,
    BDATE DATE NOT NULL,
    ADDRESS VARCHAR (30) NOT NULL,
    SEX CHAR NOT NULL,
    SALARY INT NOT NULL,
    SUPERSSN INT,
    DNO SMALLINT
);

CREATE TABLE DEPARTMENT (
    DNAME VARCHAR (30) NOT NULL,
    DNUMBER SMALLINT PRIMARY KEY,
    MGRSSN INT NOT NULL,
    MGRSTARTDATE VARCHAR (10) NOT NULL
    CONSTRAINT FK_MGRSSNDEPT FOREIGN KEY (MGRSSN) 
        REFERENCES EMPLOYEE (SSN) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE DEPT_LOCATIONS (
    DNUMBER SMALLINT,
    DLOCATION VARCHAR (30),
    PRIMARY KEY (DNUMBER, DLOCATION),
    FOREIGN KEY (DNUMBER) REFERENCES DEPARTMENT (DNUMBER) ON DELETE NO ACTION ON UPDATE NO ACTION

);

CREATE TABLE PROJECT (
    PNAME VARCHAR (50) NOT NULL,
    PNUMBER INT PRIMARY KEY,
    PLOCATION VARCHAR (30) NOT NULL,
    DNUM SMALLINT,
    FOREIGN KEY (DNUM) REFERENCES DEPARTMENT (DNUMBER) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE WORKS_ON (
    ESSN INT,
    PNO INT,
    PRIMARY KEY (ESSN, PNO),
    [HOURS] SMALLINT NOT NULL,
    FOREIGN KEY (ESSN) REFERENCES EMPLOYEE (SSN) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (PNO) REFERENCES PROJECT (PNUMBER) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE [DEPENDENT] (
    ESSN INT,
    DEPENDENT_NAME VARCHAR (50),
    PRIMARY KEY (ESSN, DEPENDENT_NAME),
    SEX CHAR NOT NULL,
    BDATE VARCHAR (10) NOT NULL,
    RELATIONSHIP VARCHAR (10) NOT NULL,
    FOREIGN KEY (ESSN) REFERENCES EMPLOYEE (SSN)
);

ALTER TABLE EMPLOYEE
    ADD CONSTRAINT FK_DNOEMPLY FOREIGN KEY (DNO)
        REFERENCES DEPARTMENT (DNUMBER) ON DELETE NO ACTION ON UPDATE NO ACTION;


INSERT INTO
    EMPLOYEE (
        FNAME, MINIT, LNAME, 
        SSN, BDATE, ADDRESS, SEX, SALARY, 
        SUPERSSN, DNO
    )
VALUES
    ('Cahaya', 'Citra', 'Anisa', 2991, '1983-10-10', 'Surakarta', 'F', 3000000, 1760, NULL),
    ('Setiawan', 'Putri', 'Rahman', 9521, '1958-08-24', 'Sragen', 'F', 3250000, NULL, NULL),
    ('Buana', 'Mega', 'Fatimah', 1546, '1988-09-14', 'Boyolali', 'F', 2750000, 9521, NULL),
    ('Agus', 'Ilham', 'Ahmad', 1760, '1986-12-21', 'Sukoharjo', 'M', 3125000, NULL, NULL),
    ('Hasan', 'Jusuf', 'Akbar', 9936, '1980-05-18', 'Karanganyar', 'M', 2850000, 1760, NULL);

INSERT INTO
    DEPARTMENT (DNAME, DNUMBER, MGRSSN, MGRSTARTDATE)
VALUES
    ('Produksi', 1, 9521, '2019-01-01'),
    ('Pemasaran', 2, 1760, '2019-07-01');

UPDATE EMPLOYEE
    SET DNO = 1
    WHERE SSN = 2991
UPDATE EMPLOYEE
    SET DNO = 1
    WHERE SSN = 9521
UPDATE EMPLOYEE
    SET DNO = 2
    WHERE SSN = 1546
UPDATE EMPLOYEE
    SET DNO = 2
    WHERE SSN = 1760
UPDATE EMPLOYEE
    SET DNO = 1
    WHERE SSN = 9936

INSERT INTO
    DEPT_LOCATIONS (DNUMBER, DLOCATION)
VALUES
    (1, 'Karanganyar'),
    (2, 'Surakarta');

INSERT INTO
    PROJECT (PNAME, PNUMBER, PLOCATION, DNUM)
VALUES
    ('Produksi Tahu', 11, 'Papahan', 1),
    ('Produksi Tempe', 12, 'Jaten', 1),
    ('Iklan Baliho', 21, 'Jebres', 2);

INSERT INTO 
    WORKS_ON (ESSN, PNO, [HOURS])
VALUES
    (2991, 21, 30),
    (9521, 11, 45),
    (1546, 12, 40),
    (1760, 21, 35),
    (9936, 21, 30);

INSERT INTO
    [DEPENDENT] (ESSN, DEPENDENT_NAME, SEX, BDATE, RELATIONSHIP)
VALUES
    (9521, 'Oona Byrne', 'F', '1990-12-01', 'Friend'),
    (1760, 'Chaz Sobel', 'F', '1991-07-02', 'Friend');
