Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D8F49A89A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319667AbiAYDJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1312179AbiAYCl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:41:56 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B89CC047CEC;
        Mon, 24 Jan 2022 18:10:47 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id h4so1396530qtm.2;
        Mon, 24 Jan 2022 18:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gtqOgETo9WpBYGhrwsSAf8wEM8H5JsUH4gMyIhTeIqw=;
        b=Lna3Lss9eRfNHmRcA0tWTbI6F1yCyZ7LWCIZjTDSM6uxWW0/OLF/FDPsCrI2Aevuio
         3SE9CpD4649hU6we2Qe1pSnWi0Nv5lJPM5ESJT1Yb4fTsC96Y7KTLeTcN6SvsT+iKa3I
         HcjWKrmGv2wvqv44oxNYcmuKkfMyAlqUQOyouhYgzijsjdUUIgqA0DO3p0ZnOWtja+CH
         1vP4pWV3a9pwwkARhkwfPy6R9xa0ja9GFMDD7Rml7sxvsBumq4LKeY8TaBW8pvdHHh8I
         wdptwa+WZwde53eMEpHn9h7+nKRF9e2tJOiC7tqSMOl5x7+lEvYOgA2uyWrRsjB5T7gc
         ZsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gtqOgETo9WpBYGhrwsSAf8wEM8H5JsUH4gMyIhTeIqw=;
        b=atDNppmqSW4iPBBqJ+oafFtPHmI/TEHuyTZVTH4a/M3DQxXn9GABH9VMtN9uLnRdd6
         tTz8p/WPXf0zP5PR0JR5OlnbTFVZFcCbY7LejmE7/AesMh4poH/hvQ7jOBqjdQfN1A2e
         NJ3jQIR6t+h+Eh2toaxHwl0gmaQkgEEzKoeVWPTC680Ohiy5HuEcjaEYovYG1xa1VLXF
         9jiOmDU4n1Wt2sWMAhsiscdJDULnPnQ0c50wt4RjezrbvgCFzbvDBlbcNfSAYx5YXuMx
         Byg5ahQSdxQ5WH5DCbGaKJRRKXq+d7af02kOgpYgGIYx1PvkyA0httVZWZst4nIxp3bZ
         0DxA==
X-Gm-Message-State: AOAM532VnjLxZilrSUD/TwIClNVh6M4AxGmjJ8Xt4wo/klyiO+PNGsQg
        ntbSXyQMy7EwG1sR75CCxgU=
X-Google-Smtp-Source: ABdhPJxiIYX4t2C4CKLZ3hXQS/a9rzWH5NmFpe/yLJ5Dec1izMkrZUZxK/wH58hmBNJdd9pu/2Q4Rg==
X-Received: by 2002:a05:622a:44e:: with SMTP id o14mr15202415qtx.669.1643076646360;
        Mon, 24 Jan 2022 18:10:46 -0800 (PST)
Received: from Dell-Inspiron-15.dartmouth.edu ([129.170.195.217])
        by smtp.gmail.com with ESMTPSA id m190sm8024845qkf.58.2022.01.24.18.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 18:10:45 -0800 (PST)
From:   Ben Wolsieffer <benwolsieffer@gmail.com>
Cc:     Ben Wolsieffer <benwolsieffer@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] ARM: dts: qcom: basic HP TouchPad support
Date:   Mon, 24 Jan 2022 21:07:05 -0500
Message-Id: <9f19df2a0017b71547445ac34df221e827c45bd0.1643075547.git.benwolsieffer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643075547.git.benwolsieffer@gmail.com>
References: <cover.1643075547.git.benwolsieffer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the Dragonboard device tree to support the most basic hardware on
the HP TouchPad. The headphone UART port and eMMC are supported.

Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8060-tenderloin.dts | 549 ++----------------
 1 file changed, 45 insertions(+), 504 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8060-tenderloin.dts b/arch/arm/boot/dts/qcom-apq8060-tenderloin.dts
index 996e73aa0b0b..e294f3920b9f 100644
--- a/arch/arm/boot/dts/qcom-apq8060-tenderloin.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-tenderloin.dts
@@ -14,6 +14,8 @@ aliases {
 	};
 
 	chosen {
+		/* Bootloader passes console=tty1, which overrides stdout-path */
+		bootargs = "console=ttyMSM0,115200 earlycon";
 		stdout-path = "serial0:115200n8";
 	};
 
@@ -30,67 +32,18 @@ vph: regulator-fixed {
 			regulator-always-on;
 			regulator-boot-on;
 		};
-
-		/* GPIO controlled ethernet power regulator */
-		dragon_veth: xc622a331mrg {
-			compatible = "regulator-fixed";
-			regulator-name = "XC6222A331MR-G";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			vin-supply = <&vph>;
-			gpio = <&pm8058_gpio 40 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-			pinctrl-names = "default";
-			pinctrl-0 = <&dragon_veth_gpios>;
-			regulator-always-on;
-		};
-
-		/* VDDvario fixed regulator */
-		dragon_vario: nds332p {
-			compatible = "regulator-fixed";
-			regulator-name = "NDS332P";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			vin-supply = <&pm8058_s3>;
-		};
-
-		/* This is a levelshifter for SDCC5 */
-		dragon_vio_txb: txb0104rgyr {
-			compatible = "regulator-fixed";
-			regulator-name = "Dragon SDCC levelshifter";
-			vin-supply = <&pm8058_l14>;
-			regulator-always-on;
-		};
-	};
-
-	/*
-	 * Capella CM3605 light and proximity sensor mounted directly
-	 * on the sensor board.
-	 */
-	cm3605 {
-		compatible = "capella,cm3605";
-		vdd-supply = <&pm8058_l14>; // 2.85V
-		aset-gpios = <&pm8058_gpio 35 GPIO_ACTIVE_LOW>;
-		capella,aset-resistance-ohms = <100000>;
-		/* Trig on both edges - getting close or far away */
-		interrupts-extended = <&pm8058_gpio 34 IRQ_TYPE_EDGE_BOTH>;
-		/* MPP05 analog input to the XOADC */
-		io-channels = <&xoadc 0x00 0x05>;
-		io-channel-names = "aout";
-		pinctrl-names = "default";
-		pinctrl-0 = <&dragon_cm3605_gpios>, <&dragon_cm3605_mpps>;
 	};
 
 	soc {
 		pinctrl@800000 {
-			/* eMMMC pins, all 8 data lines connected */
-			dragon_sdcc1_pins: sdcc1 {
+			/* eMMC pins, all 8 data lines connected */
+			emmc_pins: sdcc1 {
 				mux {
 					pins = "gpio159", "gpio160", "gpio161",
 					     "gpio162", "gpio163", "gpio164",
 					     "gpio165", "gpio166", "gpio167",
 					     "gpio168";
-					     function = "sdc1";
+					function = "sdc1";
 				};
 				clk {
 					pins = "gpio167"; /* SDC1 CLK */
@@ -111,54 +64,7 @@ data {
 				};
 			};
 
-			/*
-			 * The SDCC3 pins are hardcoded (non-muxable) but need some pin
-			 * configuration.
-			 */
-			dragon_sdcc3_pins: sdcc3 {
-				clk {
-					pins = "sdc3_clk";
-					drive-strength = <8>;
-					bias-disable;
-				};
-				cmd {
-					pins = "sdc3_cmd";
-					drive-strength = <8>;
-					bias-pull-up;
-				};
-				data {
-					pins = "sdc3_data";
-					drive-strength = <8>;
-					bias-pull-up;
-				};
-			};
-
-			/* Second SD card slot pins */
-			dragon_sdcc5_pins: sdcc5 {
-				mux {
-					pins = "gpio95", "gpio96", "gpio97",
-					    "gpio98", "gpio99", "gpio100";
-					function = "sdc5";
-				};
-				clk {
-					pins = "gpio97"; /* SDC5 CLK */
-					drive-strength = <16>;
-					bias-disable;
-				};
-				cmd {
-					pins = "gpio95"; /* SDC5 CMD */
-					drive-strength = <10>;
-					bias-pull-up;
-				};
-				data {
-					/* SDC5 D0 to D3 */
-					pins = "gpio96", "gpio98", "gpio99", "gpio100";
-					drive-strength = <10>;
-					bias-pull-up;
-				};
-			};
-
-			dragon_gsbi8_i2c_pins: gsbi8_i2c {
+			gsbi8_i2c_pins: gsbi8_i2c {
 				mux {
 					pins = "gpio64", "gpio65";
 					function = "gsbi8";
@@ -171,205 +77,33 @@ pinconf {
 				};
 			};
 
-			dragon_gsbi12_i2c_pins: gsbi12_i2c {
-				mux {
-					pins = "gpio115", "gpio116";
-					function = "gsbi12";
-				};
-				pinconf {
-					pins = "gpio115", "gpio116";
-					drive-strength = <16>;
-					/* These have external pull-up 4.7kOhm to 1.8V */
-					bias-disable;
-				};
-			};
-
-			/* Primary serial port uart 0 pins */
-			dragon_gsbi12_serial_pins: gsbi12_serial {
+			/* Headphone UART pins */
+			headphone_uart_pins: gsbi12_serial {
 				mux {
 					pins = "gpio117", "gpio118";
 					function = "gsbi12";
 				};
-				tx {
-					pins = "gpio117";
-					drive-strength = <8>;
-					bias-disable;
-				};
 				rx {
-					pins = "gpio118";
+					pins = "gpio117";
 					drive-strength = <2>;
 					bias-pull-up;
 				};
-			};
-
-			dragon_ebi2_pins: ebi2 {
-				/*
-				 * Pins used by EBI2 on the Dragonboard, actually only
-				 * CS2 is used by a real peripheral. CS0 is just
-				 * routed to a test point.
-				 */
-				mux0 {
-					pins =
-					    /* "gpio39", CS1A_N this is not good to mux */
-					    "gpio40", /* CS2A_N */
-					    "gpio134"; /* CS0_N testpoint TP29 */
-					function = "ebi2cs";
-				};
-				mux1 {
-					pins =
-					    /* EBI2_ADDR_7 downto EBI2_ADDR_0 address bus */
-					    "gpio123", "gpio124", "gpio125", "gpio126",
-					    "gpio127", "gpio128", "gpio129", "gpio130",
-					    /* EBI2_DATA_15 downto EBI2_DATA_0 data bus */
-					    "gpio135", "gpio136", "gpio137", "gpio138",
-					    "gpio139", "gpio140", "gpio141", "gpio142",
-					    "gpio143", "gpio144", "gpio145", "gpio146",
-					    "gpio147", "gpio148", "gpio149", "gpio150",
-					    "gpio151", /* EBI2_OE_N */
-					    "gpio153", /* EBI2_ADV */
-					    "gpio157"; /* EBI2_WE_N */
-					function = "ebi2";
+				tx {
+					pins = "gpio118";
+					drive-strength = <8>;
+					bias-disable;
 				};
-			};
-
-			/* Interrupt line for the KXSD9 accelerometer */
-			dragon_kxsd9_gpios: kxsd9 {
-				irq {
-					pins = "gpio57"; /* IRQ line */
-					bias-pull-up;
+				/* Connect headphone jack to UART rather than audio */
+				enable {
+					pins = "gpio58";
+					function = "gpio";
+					output-high;
 				};
 			};
 		};
 
 		qcom,ssbi@500000 {
 			pmic@0 {
-				keypad@148 {
-					linux,keymap = <
-					MATRIX_KEY(0, 0, KEY_MENU)
-					MATRIX_KEY(0, 2, KEY_1)
-					MATRIX_KEY(0, 3, KEY_4)
-					MATRIX_KEY(0, 4, KEY_7)
-					MATRIX_KEY(1, 0, KEY_UP)
-					MATRIX_KEY(1, 1, KEY_LEFT)
-					MATRIX_KEY(1, 2, KEY_DOWN)
-					MATRIX_KEY(1, 3, KEY_5)
-					MATRIX_KEY(1, 3, KEY_8)
-					MATRIX_KEY(2, 0, KEY_HOME)
-					MATRIX_KEY(2, 1, KEY_REPLY)
-					MATRIX_KEY(2, 2, KEY_2)
-					MATRIX_KEY(2, 3, KEY_6)
-					MATRIX_KEY(3, 0, KEY_VOLUMEUP)
-					MATRIX_KEY(3, 1, KEY_RIGHT)
-					MATRIX_KEY(3, 2, KEY_3)
-					MATRIX_KEY(3, 3, KEY_9)
-					MATRIX_KEY(3, 4, KEY_SWITCHVIDEOMODE)
-					MATRIX_KEY(4, 0, KEY_VOLUMEDOWN)
-					MATRIX_KEY(4, 1, KEY_BACK)
-					MATRIX_KEY(4, 2, KEY_CAMERA)
-					MATRIX_KEY(4, 3, KEY_KBDILLUMTOGGLE)
-					>;
-					keypad,num-rows = <6>;
-					keypad,num-columns = <5>;
-				};
-
-				gpio@150 {
-					dragon_ethernet_gpios: ethernet-gpios {
-						pinconf {
-							pins = "gpio7";
-							function = "normal";
-							input-enable;
-							bias-disable;
-							power-source = <PM8058_GPIO_S3>;
-						};
-					};
-					dragon_bmp085_gpios: bmp085-gpios {
-						pinconf {
-							pins = "gpio16";
-							function = "normal";
-							input-enable;
-							bias-disable;
-							power-source = <PM8058_GPIO_S3>;
-						};
-					};
-					dragon_mpu3050_gpios: mpu3050-gpios {
-						pinconf {
-							pins = "gpio17";
-							function = "normal";
-							input-enable;
-							bias-disable;
-							power-source = <PM8058_GPIO_S3>;
-						};
-					};
-					dragon_sdcc3_gpios: sdcc3-gpios {
-						pinconf {
-							pins = "gpio22";
-							function = "normal";
-							input-enable;
-							bias-disable;
-							power-source = <PM8058_GPIO_S3>;
-						};
-					};
-					dragon_sdcc5_gpios: sdcc5-gpios {
-						pinconf {
-							pins = "gpio26";
-							function = "normal";
-							input-enable;
-							bias-pull-up;
-							qcom,pull-up-strength = <PMIC_GPIO_PULL_UP_30>;
-							power-source = <PM8058_GPIO_S3>;
-						};
-					};
-					dragon_ak8975_gpios: ak8975-gpios {
-						pinconf {
-							pins = "gpio33";
-							function = "normal";
-							input-enable;
-							bias-disable;
-							power-source = <PM8058_GPIO_S3>;
-						};
-					};
-					dragon_cm3605_gpios: cm3605-gpios {
-						/* Pin 34 connected to the proxy IRQ */
-						pinconf_gpio34 {
-							pins = "gpio34";
-							function = "normal";
-							input-enable;
-							bias-disable;
-							power-source = <PM8058_GPIO_S3>;
-						};
-						/* Pin 35 connected to ASET */
-						pinconf_gpio35 {
-							pins = "gpio35";
-							function = "normal";
-							output-high;
-							bias-disable;
-							power-source = <PM8058_GPIO_S3>;
-						};
-					};
-					dragon_veth_gpios: veth-gpios {
-						pinconf {
-							pins = "gpio40";
-							function = "normal";
-							bias-disable;
-							drive-push-pull;
-						};
-					};
-				};
-
-				mpps@50 {
-					dragon_cm3605_mpps: cm3605-mpps-state {
-						pinconf {
-							pins = "mpp5";
-							function = "analog";
-							input-enable;
-							bias-high-impedance;
-							/* Let's use channel 5 */
-							qcom,amux-route = <PMIC_MPP_AMUX_ROUTE_CH5>;
-							power-source = <PM8058_GPIO_S3>;
-						};
-					};
-				};
-
 				xoadc@197 {
 					/* Reference voltage 2.2 V */
 					xoadc-ref-supply = <&pm8058_l18>;
@@ -396,46 +130,6 @@ mpp9@9 {
 						reg = <0x00 0x09>;
 					};
 				};
-
-				led@48 {
-					/*
-					 * The keypad LED @0x48 is routed to
-					 * the sensor board where it is
-					 * connected to an infrared LED
-					 * SFH4650 (60mW, @850nm) next to the
-					 * ambient light and proximity sensor
-					 * Capella Microsystems CM3605.
-					 */
-					compatible = "qcom,pm8058-keypad-led";
-					reg = <0x48>;
-					label = "pm8058:infrared:proximitysensor";
-					default-state = "off";
-					linux,default-trigger = "cm3605";
-				};
-				led@131 {
-					compatible = "qcom,pm8058-led";
-					reg = <0x131>;
-					label = "pm8058:red";
-					default-state = "off";
-				};
-				led@132 {
-					/*
-					 * This is actually green too on my
-					 * board, but documented as yellow.
-					 */
-					compatible = "qcom,pm8058-led";
-					reg = <0x132>;
-					label = "pm8058:yellow";
-					default-state = "off";
-					linux,default-trigger = "mmc0";
-				};
-				led@133 {
-					compatible = "qcom,pm8058-led";
-					reg = <0x133>;
-					label = "pm8058:green";
-					default-state = "on";
-					linux,default-trigger = "heartbeat";
-				};
 			};
 		};
 
@@ -446,151 +140,18 @@ gsbi@19800000 {
 			i2c@19880000 {
 				status = "okay";
 				pinctrl-names = "default";
-				pinctrl-0 = <&dragon_gsbi8_i2c_pins>;
-
-				eeprom@52 {
-					/* A 16KiB Platform ID EEPROM on the CPU carrier board */
-					compatible = "atmel,24c128";
-					reg = <0x52>;
-					vcc-supply = <&pm8058_s3>;
-					pagesize = <64>;
-				};
-				wm8903: wm8903@1a {
-					/* This Woolfson Micro device has an unrouted interrupt line */
-					compatible = "wlf,wm8903";
-					reg = <0x1a>;
-
-					AVDD-supply = <&pm8058_l16>;
-					CPVDD-supply = <&pm8058_l16>;
-					DBVDD-supply = <&pm8058_s3>;
-					DCVDD-supply = <&pm8058_l0>;
-
-					gpio-controller;
-					#gpio-cells = <2>;
-
-					micdet-cfg = <0>;
-					micdet-delay = <100>;
-					gpio-cfg = <0xffffffff 0xffffffff 0 0xffffffff 0xffffffff>;
-				};
+				pinctrl-0 = <&gsbi8_i2c_pins>;
 			};
 		};
 
 		gsbi@19c00000 {
 			status = "okay";
-			qcom,mode = <GSBI_PROT_I2C_UART>;
+			qcom,mode = <GSBI_PROT_UART_W_FC>;
 
 			serial@19c40000 {
 				status = "okay";
 				pinctrl-names = "default";
-				pinctrl-0 = <&dragon_gsbi12_serial_pins>;
-			};
-
-			i2c@19c80000 {
-				status = "okay";
-				pinctrl-names = "default";
-				pinctrl-0 = <&dragon_gsbi12_i2c_pins>;
-
-				ak8975@c {
-					compatible = "asahi-kasei,ak8975";
-					reg = <0x0c>;
-					interrupt-parent = <&pm8058_gpio>;
-					interrupts = <33 IRQ_TYPE_EDGE_RISING>;
-					pinctrl-names = "default";
-					pinctrl-0 = <&dragon_ak8975_gpios>;
-					vid-supply = <&pm8058_lvs0>; // 1.8V
-					vdd-supply = <&pm8058_l14>; // 2.85V
-				};
-				bmp085@77 {
-					compatible = "bosch,bmp085";
-					reg = <0x77>;
-					interrupt-parent = <&pm8058_gpio>;
-					interrupts = <16 IRQ_TYPE_EDGE_RISING>;
-					reset-gpios = <&tlmm 86 GPIO_ACTIVE_LOW>;
-					pinctrl-names = "default";
-					pinctrl-0 = <&dragon_bmp085_gpios>;
-					vddd-supply = <&pm8058_lvs0>; // 1.8V
-					vdda-supply = <&pm8058_l14>; // 2.85V
-				};
-				mpu3050@68 {
-					compatible = "invensense,mpu3050";
-					reg = <0x68>;
-					/*
-					 * GPIO17 is pulled high by a 10k
-					 * resistor to VLOGIC so needs to be
-					 * active low/falling edge.
-					 */
-					interrupts-extended = <&pm8058_gpio 17 IRQ_TYPE_EDGE_FALLING>;
-					pinctrl-names = "default";
-					pinctrl-0 = <&dragon_mpu3050_gpios>;
-					vlogic-supply = <&pm8058_lvs0>; // 1.8V
-					vdd-supply = <&pm8058_l14>; // 2.85V
-
-					/*
-					 * The MPU-3050 acts as a hub for the
-					 * accelerometer.
-					 */
-					i2c-gate {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						kxsd9@18 {
-							compatible = "kionix,kxsd9";
-							reg = <0x18>;
-							interrupt-parent = <&tlmm>;
-							interrupts = <57 IRQ_TYPE_EDGE_FALLING>;
-							pinctrl-names = "default";
-							pinctrl-0 = <&dragon_kxsd9_gpios>;
-							iovdd-supply = <&pm8058_lvs0>; // 1.8V
-							vdd-supply = <&pm8058_l14>; // 2.85V
-						};
-					};
-				};
-			};
-		};
-
-		external-bus@1a100000 {
-			/* The EBI2 will instantiate first, then populate its children */
-			status = "okay";
-			pinctrl-names = "default";
-			pinctrl-0 = <&dragon_ebi2_pins>;
-
-			/*
-			 * An on-board SMSC LAN9221 chip for "debug ethernet",
-			 * which is actually just an ordinary ethernet on the
-			 * EBI2. This has a 25MHz chrystal next to it, so no
-			 * clocking is needed.
-			 */
-			ethernet@2,0 {
-				compatible = "smsc,lan9221", "smsc,lan9115";
-				reg = <2 0x0 0x100>;
-				/*
-				 * The second interrupt is the PME interrupt
-				 * for network wakeup, connected to the TLMM.
-				 */
-				interrupts-extended = <&pm8058_gpio 7 IRQ_TYPE_EDGE_FALLING>,
-						    <&tlmm 29 IRQ_TYPE_EDGE_RISING>;
-				reset-gpios = <&tlmm 30 GPIO_ACTIVE_LOW>;
-				vdd33a-supply = <&dragon_veth>;
-				vddvario-supply = <&dragon_vario>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&dragon_ethernet_gpios>;
-				phy-mode = "mii";
-				reg-io-width = <2>;
-				smsc,force-external-phy;
-				smsc,irq-push-pull;
-
-				/*
-				 * SLOW chipselect config
-				 * Delay 9 cycles (140ns@64MHz) between SMSC
-				 * LAN9221 Ethernet controller reads and writes
-				 * on CS2.
-				 */
-				qcom,xmem-recovery-cycles = <0>;
-				qcom,xmem-write-hold-cycles = <3>;
-				qcom,xmem-write-delta-cycles = <31>;
-				qcom,xmem-read-delta-cycles = <28>;
-				qcom,xmem-write-wait-cycles = <9>;
-				qcom,xmem-read-wait-cycles = <9>;
+				pinctrl-0 = <&headphone_uart_pins>;
 			};
 		};
 
@@ -758,13 +319,13 @@ l9 {
 					bias-pull-down;
 				};
 				l10 {
-					regulator-min-microvolt = <2600000>;
-					regulator-max-microvolt = <2600000>;
+					regulator-min-microvolt = <3050000>;
+					regulator-max-microvolt = <3050000>;
 					bias-pull-down;
 				};
 				l11 {
-					regulator-min-microvolt = <1500000>;
-					regulator-max-microvolt = <1500000>;
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
 					bias-pull-down;
 				};
 				l12 {
@@ -790,10 +351,13 @@ l16 {
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 					bias-pull-down;
-					regulator-always-on;
+					/*
+					 * RPM driver can't handle always-on regulators that are
+					 * supplied by regulators initialized after them.
+					 */
+					// regulator-always-on;
 				};
 				l17 {
-					// 1.5V according to schematic
 					regulator-min-microvolt = <2600000>;
 					regulator-max-microvolt = <2600000>;
 					bias-pull-down;
@@ -804,8 +368,8 @@ l18 {
 					bias-pull-down;
 				};
 				l19 {
-					regulator-min-microvolt = <2500000>;
-					regulator-max-microvolt = <2500000>;
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
 					bias-pull-down;
 				};
 				l20 {
@@ -814,14 +378,16 @@ l20 {
 					bias-pull-down;
 				};
 				l21 {
-					// 1.1 V according to schematic
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
 					bias-pull-down;
-					regulator-always-on;
+					/*
+					 * RPM driver can't handle always-on regulators that are
+					 * supplied by regulators initialized after them.
+					 */
+					// regulator-always-on;
 				};
 				l22 {
-					// 1.2 V according to schematic
 					regulator-min-microvolt = <1150000>;
 					regulator-max-microvolt = <1150000>;
 					bias-pull-down;
@@ -845,7 +411,7 @@ l25 {
 				};
 
 				s0 {
-					// regulator-min-microvolt = <500000>;
+					// regulator-min-microvolt = <800000>;
 					// regulator-max-microvolt = <1325000>;
 					regulator-min-microvolt = <1100000>;
 					regulator-max-microvolt = <1100000>;
@@ -853,8 +419,8 @@ s0 {
 					bias-pull-down;
 				};
 				s1 {
-					// regulator-min-microvolt = <500000>;
-					// regulator-max-microvolt = <1250000>;
+					// regulator-min-microvolt = <800000>;
+					// regulator-max-microvolt = <1325000>;
 					regulator-min-microvolt = <1100000>;
 					regulator-max-microvolt = <1100000>;
 					qcom,switch-mode-frequency = <1600000>;
@@ -871,15 +437,15 @@ s3 {
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 					qcom,switch-mode-frequency = <1600000>;
-					regulator-always-on;
 					bias-pull-down;
+					regulator-always-on;
 				};
 				s4 {
 					regulator-min-microvolt = <2200000>;
 					regulator-max-microvolt = <2200000>;
 					qcom,switch-mode-frequency = <1600000>;
-					regulator-always-on;
 					bias-pull-down;
+					regulator-always-on;
 				};
 
 				/* LVS0 and LVS1 are just switches */
@@ -897,41 +463,16 @@ ncp {
 				};
 			};
 		};
+
 		amba {
-			/* Internal 3.69 GiB eMMC */
+			/* Internal 16/32 GiB eMMC */
 			mmc@12400000 {
 				status = "okay";
 				pinctrl-names = "default";
-				pinctrl-0 = <&dragon_sdcc1_pins>;
+				pinctrl-0 = <&emmc_pins>;
 				vmmc-supply = <&pm8901_l5>;
 				vqmmc-supply = <&pm8901_lvs0>;
 			};
-
-			/* External micro SD card, directly connected, pulled up to 2.85 V */
-			mmc@12180000 {
-				status = "okay";
-				/* Enable SSBI GPIO 22 as input, use for card detect */
-				pinctrl-names = "default";
-				pinctrl-0 = <&dragon_sdcc3_pins>, <&dragon_sdcc3_gpios>;
-				cd-gpios = <&pm8058_gpio 22 GPIO_ACTIVE_LOW>;
-				wp-gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
-				vmmc-supply = <&pm8058_l14>;
-			};
-
-			/*
-			 * Second external micro SD card, using two TXB104RGYR levelshifters
-			 * to lift from 1.8 V to 2.85 V
-			 */
-			mmc@12200000 {
-				status = "okay";
-				/* Enable SSBI GPIO 26 as input, use for card detect */
-				pinctrl-names = "default";
-				pinctrl-0 = <&dragon_sdcc5_pins>, <&dragon_sdcc5_gpios>;
-				cd-gpios = <&pm8058_gpio 26 GPIO_ACTIVE_LOW>;
-				wp-gpios = <&tlmm 106 GPIO_ACTIVE_HIGH>;
-				vmmc-supply = <&pm8058_l14>;
-				vqmmc-supply = <&dragon_vio_txb>;
-			};
 		};
 	};
 };
-- 
2.34.1

