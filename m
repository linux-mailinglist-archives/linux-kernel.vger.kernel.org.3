Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E6D5699F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiGGFkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiGGFkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:40:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F857313B4;
        Wed,  6 Jul 2022 22:40:38 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id e16so4455710pfm.11;
        Wed, 06 Jul 2022 22:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mV53F5dAh4wt82gopBpGlNxRdxWHShgiLzI7GB9p2jU=;
        b=MS5Rw8YnS9NErjm4X5mTDnaYNHIrzOoFzq8i1E5L26Abp2YZt+Fe4dswKmrpp5A2xv
         Ys4Y1IDv6a3SCPfDWgOs/ctZfS+UtI2JLqlDxmSMTEQlG/+B+boZr8d0h7x40fLR9FFr
         yUBiAUxHNOfJc9/0gEozCr5uO1LTQFzINGjAbTkzuFzsoHvgyaZ3l+AnNdRiKneTTN+H
         w6fIrH5JBJJJHm+oZ3OHtBnK2DAg/ib83UvRwbw7EsIBuKfijla609t6oT3sVZCD9HzO
         fOHd79pP9RQxNguiuK5xtmY3kG29DFH/UQZVNYaVGJ745HpOBRmS0FRfCUWiX5sUGL6K
         0MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mV53F5dAh4wt82gopBpGlNxRdxWHShgiLzI7GB9p2jU=;
        b=DvcXX9iEChcz5bXSRaKkvYSTfwlfzQOVdylSw4ug25H11jaL4i9rvrs3pRjI8TUUdu
         A76Fx8acn1Bh0ec5tmF9IStTQBV599XgYSp75LB/DjVeDPUKlxUrLJTHVRNWaMBX4Jem
         SwEeVuSESqhCkfLFQtYtmb125L/IRveFWhBXpa1x4h5W/2R80CFcXAfiJ3Gb5bf0Afqe
         6Lx8u1IJJPcZDMdnvlb0bHF+1BxOsi04YH3F+gE3DcrMhF/Wk3P1hlTgtLE8c+dWhiL4
         ZOLFoe0tgZ6kQc77xRDs/p7Hga7yL26D3vloWPY9XhP49K2z4YzkTgqqLHys37R5ZSMI
         je1w==
X-Gm-Message-State: AJIora9F404AHu5M+WqdojSGHg1BD34jc6BpgbEbeb01TlZP8FBD/Y3I
        nHYh9SnzfXCM/tt9mH7Sz6U=
X-Google-Smtp-Source: AGRyM1vFVlMovBd05f59eR+vqkVlYheKFvoJMWhJJ/c5eDVvwUIBynVOfgUxHRh3HTOwRqG4A74nUA==
X-Received: by 2002:a17:90a:d997:b0:1ef:83d6:fc31 with SMTP id d23-20020a17090ad99700b001ef83d6fc31mr3004564pjv.22.1657172437579;
        Wed, 06 Jul 2022 22:40:37 -0700 (PDT)
Received: from debian.moxa.com ([123.51.145.104])
        by smtp.gmail.com with ESMTPSA id c128-20020a624e86000000b005286a4ca9c8sm6678411pfb.211.2022.07.06.22.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 22:40:36 -0700 (PDT)
From:   Jimmy Chen <u7702045@gmail.com>
X-Google-Original-From: Jimmy Chen <jimmy.chen@moxa.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Jimmy Chen <jimmy.chen@moxa.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: imx7d: add dts for UC-8210/8220 hardware
Date:   Thu,  7 Jul 2022 13:39:53 +0800
Message-Id: <20220707053954.22168-1-jimmy.chen@moxa.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 2 models hardware dts provided by MOXA company

Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
---
 arch/arm/boot/dts/Makefile               |   2 +
 arch/arm/boot/dts/imx7d-moxa-uc-8210.dts | 862 +++++++++++++++++++++++
 arch/arm/boot/dts/imx7d-moxa-uc-8220.dts |  22 +
 3 files changed, 886 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-moxa-uc-8210.dts
 create mode 100644 arch/arm/boot/dts/imx7d-moxa-uc-8220.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5112f493f494..37db3b60ba43 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -755,6 +755,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-remarkable2.dtb \
 	imx7d-sbc-imx7.dtb \
 	imx7d-sdb.dtb \
+	imx7d-moxa-uc-8210.dtb \
+	imx7d-moxa-uc-8220.dtb \
 	imx7d-sdb-reva.dtb \
 	imx7d-sdb-sht11.dtb \
 	imx7d-smegw01.dtb \
diff --git a/arch/arm/boot/dts/imx7d-moxa-uc-8210.dts b/arch/arm/boot/dts/imx7d-moxa-uc-8210.dts
new file mode 100644
index 000000000000..fc5a0c7ff295
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-moxa-uc-8210.dts
@@ -0,0 +1,862 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/* Copyright (C) MOXA Inc. All rights reserved.
+ * Authors: TungYu TY Yang <TungyuTY.Yang@moxa.com>
+ */
+
+/dts-v1/;
+
+#include "imx7d.dtsi"
+
+/ {
+	model = "Moxa UC-8210";
+	compatible = "moxa,uc-8210", "fsl,imx7d";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_vref_1v8: regulator-vref-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vref-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_wl: regulator-wl {
+		compatible = "regulator-fixed";
+		gpio = <&gpio4 20 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-name = "wl_reg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <100>;
+	};
+
+	reg_sd1_vmmc: regulator-sd1-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_SD1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <200000>;
+		off-on-delay = <20000>;
+		enable-active-high;
+	};
+
+	reg_can2_3v3: regulator-can2-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-3v3";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan2_reg>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 14 GPIO_ACTIVE_LOW>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		signal-led-1-1 {
+			label = "UC8200:YELLOW:SGN1-1";
+			gpios = <&i2cgpio2 4 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		signal-led-1-2 {
+			label = "UC8200:YELLOW:SGN1-2";
+			gpios = <&i2cgpio2 5 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		signal-led-1-3 {
+			label = "UC8200:YELLOW:SGN1-3";
+			gpios = <&i2cgpio2 12 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		signal-led-2-1 {
+			label = "UC8200:YELLOW:SGN2-1";
+			gpios = <&i2cgpio2 13 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		signal-led-2-2 {
+			label = "UC8200:YELLOW:SGN2-2";
+			gpios = <&i2cgpio2 14 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		signal-led-2-3 {
+			label = "UC8200:YELLOW:SGN2-3";
+			gpios = <&i2cgpio2 15 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		user-led-1-1 {
+			label = "UC8200:YELLOW:USR";
+			gpios = <&i2cgpio1 9 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		user-led-1-2 {
+			label = "UC8200:GREEN:USR";
+			gpios = <&i2cgpio1 10 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	buttons: gpio-keys {
+		compatible = "gpio-keys";
+
+		button {
+			label = "Reset key";
+			gpios = <&gpio5 11 1>;
+			linux,code = <0x100>;
+			default-state = "on";
+		};
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&adc2 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&sw1a_reg>;
+};
+
+&cpu1 {
+	cpu-supply = <&sw1a_reg>;
+};
+
+&ecspi1 {
+	fsl,spi-num-chipselects = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	cs-gpios = <&gpio4 19 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	tpm-spi-tis@0 {
+		compatible = "tcg,tpm_tis-spi";
+		reg = <0>;
+		spi-max-frequency = <500000>;
+	};
+};
+
+&ecspi3 {
+	fsl,spi-num-chipselects = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
+			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
+	assigned-clock-rates = <0>, <100000000>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+	fsl,num-tx-queues=<1>;
+	fsl,num-rx-queues=<1>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+		};
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <2>;
+		};
+	};
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2>;
+	assigned-clocks = <&clks IMX7D_ENET2_TIME_ROOT_SRC>,
+			  <&clks IMX7D_ENET2_TIME_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
+	assigned-clock-rates = <0>, <100000000>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy1>;
+	fsl,num-tx-queues=<1>;
+	fsl,num-rx-queues=<1>;
+	fsl,magic-packet;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can2_3v3>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic: pfuze3000@8 {
+		compatible = "fsl,pfuze3000";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1a {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1475000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			/* use sw1c_reg to align with pfuze100/pfuze200 */
+			sw1c_reg: sw1b {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1475000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1650000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vldo1 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vldo2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen3_reg: vccsd {
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: v33 {
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vldo3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vldo4 {
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	/* UART SIM RESET */
+	i2cgpio1: gpio@20 {
+		compatible = "nxp,pca9535";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	rtc@68 {
+		compatible = "dallas,ds1374";
+		reg = <0x68>;
+	};
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	/* TPM LED DIO */
+	i2cgpio2: gpio@20 {
+		compatible = "nxp,pca9535";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+};
+
+&reg_1p0d {
+	vin-supply = <&sw2_reg>;
+};
+
+&reg_1p2 {
+	vin-supply = <&sw2_reg>;
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	status = "okay";
+};
+
+&usbotg1 {
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
+	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&reg_sd1_vmmc>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	wakeup-source;
+	keep-power-in-suspend;
+	non-removable;
+	fsl,tuning-step = <2>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
+	assigned-clock-rates = <400000000>;
+	bus-width = <8>;
+	fsl,tuning-step = <2>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi1_1>;
+	status = "okay";
+
+	flash0: mx25l12805d@0 {
+		compatible = "mxicy,mx25l12805d", "jedec,spi-nor";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* reg : The partition's offset and size within the mtd bank. */
+			partitions@0 {
+				label = "mlo";
+				reg = <0x0 0x100000>;
+			};
+
+			partitions@1 {
+				label = "u-boot 1";
+				reg = <0x100000 0x100000>;
+			};
+
+			partitions@2 {
+				label = "u-boot 2";
+				reg = <0x200000 0x100000>;
+			};
+
+			partitions@3 {
+				label = "u-boot env 1";
+				reg = <0x300000 0x20000>;
+			};
+
+			partitions@4 {
+				label = "u-boot env 2";
+				reg = <0x320000 0x20000>;
+			};
+
+			partitions@5 {
+				label = "syslog";
+				reg = <0x500000 0x100000>;
+			};
+
+			partitions@6 {
+				label = "storage";
+				reg = <0x600000 0x200000>;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	imx7d-sdb {
+		pinctrl_ecspi1: ecspi1grp {
+			fsl,pins = <
+				MX7D_PAD_ECSPI1_MISO__ECSPI1_MISO	0x2
+				MX7D_PAD_ECSPI1_MOSI__ECSPI1_MOSI	0x2
+				MX7D_PAD_ECSPI1_SCLK__ECSPI1_SCLK	0x2
+				MX7D_PAD_ECSPI1_SS0__GPIO4_IO19		0x2
+			>;
+		};
+
+		pinctrl_ecspi3: ecspi3grp {
+			fsl,pins = <
+				MX7D_PAD_SAI2_TX_SYNC__ECSPI3_MISO	0x2
+				MX7D_PAD_SAI2_TX_BCLK__ECSPI3_MOSI	0x2
+				MX7D_PAD_SAI2_RX_DATA__ECSPI3_SCLK	0x2
+				MX7D_PAD_SD2_CD_B__GPIO5_IO9		0x80000000
+			>;
+		};
+
+		pinctrl_enet1: enet1grp {
+			fsl,pins = <
+				MX7D_PAD_GPIO1_IO10__ENET1_MDIO			0x3
+				MX7D_PAD_GPIO1_IO11__ENET1_MDC			0x3
+				MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC	0x1
+				MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x1
+				MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x1
+				MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2	0x1
+				MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3	0x1
+				MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x1
+				MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC	0x1
+				MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x1
+				MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x1
+				MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
+				MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
+				MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
+			>;
+		};
+
+		pinctrl_enet2: enet2grp {
+			fsl,pins = <
+				MX7D_PAD_EPDC_GDSP__ENET2_RGMII_TXC		0x1
+				MX7D_PAD_EPDC_SDCE2__ENET2_RGMII_TD0		0x1
+				MX7D_PAD_EPDC_SDCE3__ENET2_RGMII_TD1		0x1
+				MX7D_PAD_EPDC_GDCLK__ENET2_RGMII_TD2		0x1
+				MX7D_PAD_EPDC_GDOE__ENET2_RGMII_TD3		0x1
+				MX7D_PAD_EPDC_GDRL__ENET2_RGMII_TX_CTL		0x1
+				MX7D_PAD_EPDC_SDCE1__ENET2_RGMII_RXC		0x1
+				MX7D_PAD_EPDC_SDCLK__ENET2_RGMII_RD0		0x1
+				MX7D_PAD_EPDC_SDLE__ENET2_RGMII_RD1		0x1
+				MX7D_PAD_EPDC_SDOE__ENET2_RGMII_RD2		0x1
+				MX7D_PAD_EPDC_SDSHR__ENET2_RGMII_RD3		0x1
+				MX7D_PAD_EPDC_SDCE0__ENET2_RGMII_RX_CTL		0x1
+			>;
+		};
+
+		pinctrl_flexcan2: flexcan2grp {
+			fsl,pins = <
+				MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x59
+				MX7D_PAD_GPIO1_IO15__FLEXCAN2_TX	0x59
+			>;
+		};
+
+		pinctrl_flexcan2_reg: flexcan2reggrp {
+			fsl,pins = <
+				MX7D_PAD_EPDC_DATA14__GPIO2_IO14	0x59	/* CAN_STBY */
+			>;
+		};
+
+		pinctrl_gpio_keys: gpio-keysgrp {
+			fsl,pins = <
+				MX7D_PAD_SD2_RESET_B__GPIO5_IO11	0x59
+				MX7D_PAD_SD2_WP__GPIO5_IO10		0x59
+			>;
+		};
+
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x15	/*LTE_PWR_EN*/
+				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34	/* bt reg on */
+				MX7D_PAD_ECSPI2_SCLK__GPIO4_IO20	0x59	/* WL_REG_ON */
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
+				MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
+				MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
+			>;
+		};
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX7D_PAD_I2C3_SDA__I2C3_SDA		0x4000007f
+				MX7D_PAD_I2C3_SCL__I2C3_SCL		0x4000007f
+			>;
+		};
+
+		pinctrl_i2c4: i2c4grp {
+			fsl,pins = <
+				MX7D_PAD_SAI1_RX_BCLK__I2C4_SDA		0x4000007f
+				MX7D_PAD_SAI1_RX_SYNC__I2C4_SCL		0x4000007f
+			>;
+		};
+
+		pinctrl_lcdif: lcdifgrp {
+			fsl,pins = <
+				MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
+				MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
+				MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
+				MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
+				MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
+				MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
+				MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
+				MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
+				MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
+				MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
+				MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
+				MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
+				MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
+				MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
+				MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
+				MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
+				MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79
+				MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
+				MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
+				MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
+				MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
+				MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
+				MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79
+				MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
+				MX7D_PAD_LCD_CLK__LCD_CLK		0x79
+				MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
+				MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
+				MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
+				MX7D_PAD_LCD_RESET__LCD_RESET		0x79
+			>;
+		};
+
+		pinctrl_sai1: sai1grp {
+			fsl,pins = <
+				MX7D_PAD_SAI1_MCLK__SAI1_MCLK           0x1f
+				MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK     0x1f
+				MX7D_PAD_ENET1_CRS__SAI1_TX_SYNC	0x1f
+				MX7D_PAD_ENET1_COL__SAI1_TX_DATA0	0x30
+				MX7D_PAD_ENET1_TX_CLK__SAI1_RX_DATA0	0x1f
+			>;
+		};
+
+		pinctrl_sai2: sai2grp {
+			fsl,pins = <
+				MX7D_PAD_SAI2_TX_BCLK__SAI2_TX_BCLK     0x1f
+				MX7D_PAD_SAI2_TX_SYNC__SAI2_TX_SYNC     0x1f
+				MX7D_PAD_SAI2_TX_DATA__SAI2_TX_DATA0    0x30
+				MX7D_PAD_SAI2_RX_DATA__SAI2_RX_DATA0    0x1f
+			>;
+		};
+
+		pinctrl_sai3: sai3grp {
+			fsl,pins = <
+				MX7D_PAD_UART3_TX_DATA__SAI3_TX_BCLK   0x1f
+				MX7D_PAD_UART3_CTS_B__SAI3_TX_SYNC     0x1f
+				MX7D_PAD_UART3_RTS_B__SAI3_TX_DATA0    0x30
+			>;
+		};
+
+		pinctrl_spi4: spi4grp {
+			fsl,pins = <
+				MX7D_PAD_GPIO1_IO09__GPIO1_IO9	0x59
+				MX7D_PAD_GPIO1_IO12__GPIO1_IO12	0x59
+				MX7D_PAD_GPIO1_IO13__GPIO1_IO13	0x59
+			>;
+		};
+
+		pinctrl_tsc2046_pendown: tsc2046_pendown {
+			fsl,pins = <
+				MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x59
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
+				MX7D_PAD_UART1_RX_DATA__UART1_DCE_RX	0x79
+			>;
+		};
+
+		pinctrl_uart5: uart5grp {
+			fsl,pins = <
+				MX7D_PAD_SAI1_TX_BCLK__UART5_DCE_TX	0x79
+				MX7D_PAD_SAI1_RX_DATA__UART5_DCE_RX	0x79
+				MX7D_PAD_SAI1_TX_SYNC__UART5_DCE_CTS	0x79
+				MX7D_PAD_SAI1_TX_DATA__UART5_DCE_RTS	0x79
+			>;
+		};
+
+		pinctrl_usdhc1: usdhc1grp {
+			fsl,pins = <
+				MX7D_PAD_SD1_CMD__SD1_CMD		0x59
+				MX7D_PAD_SD1_CLK__SD1_CLK		0x19
+				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
+				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
+				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
+				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
+			>;
+		};
+
+		pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+			fsl,pins = <
+				MX7D_PAD_SD1_CMD__SD1_CMD		0x5a
+				MX7D_PAD_SD1_CLK__SD1_CLK		0x1a
+				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5a
+				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5a
+				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5a
+				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5a
+			>;
+		};
+
+		pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {
+			fsl,pins = <
+				MX7D_PAD_SD1_CMD__SD1_CMD		0x5b
+				MX7D_PAD_SD1_CLK__SD1_CLK		0x1b
+				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5b
+				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5b
+				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5b
+				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5b
+			>;
+		};
+
+		pinctrl_usdhc1_gpio: usdhc1_gpiogrp {
+			fsl,pins = <
+				MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x59 /* CD */
+				MX7D_PAD_SD1_WP__GPIO5_IO1		0x59 /* WP */
+				MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0x59 /* vmmc */
+				MX7D_PAD_GPIO1_IO08__SD1_VSELECT	0x59 /* VSELECT */
+			>;
+		};
+
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX7D_PAD_SD2_CMD__SD2_CMD		0x59
+				MX7D_PAD_SD2_CLK__SD2_CLK		0x19
+				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x59
+				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x59
+				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x59
+				MX7D_PAD_SD2_DATA3__SD2_DATA3		0x59
+			>;
+		};
+
+		pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+			fsl,pins = <
+				MX7D_PAD_SD2_CMD__SD2_CMD		0x5a
+				MX7D_PAD_SD2_CLK__SD2_CLK		0x1a
+				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5a
+				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x5a
+				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x5a
+				MX7D_PAD_SD2_DATA3__SD2_DATA3		0x5a
+			>;
+		};
+
+		pinctrl_usdhc2_200mhz: usdhc2grp_200mhz {
+			fsl,pins = <
+				MX7D_PAD_SD2_CMD__SD2_CMD		0x5b
+				MX7D_PAD_SD2_CLK__SD2_CLK		0x1b
+				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5b
+				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x5b
+				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x5b
+				MX7D_PAD_SD2_DATA3__SD2_DATA3		0x5b
+			>;
+		};
+
+
+		pinctrl_usdhc3: usdhc3grp {
+			fsl,pins = <
+				MX7D_PAD_SD3_CMD__SD3_CMD		0x59
+				MX7D_PAD_SD3_CLK__SD3_CLK		0x19
+				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
+				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
+				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
+				MX7D_PAD_SD3_DATA3__SD3_DATA3		0x59
+				MX7D_PAD_SD3_DATA4__SD3_DATA4		0x59
+				MX7D_PAD_SD3_DATA5__SD3_DATA5		0x59
+				MX7D_PAD_SD3_DATA6__SD3_DATA6		0x59
+				MX7D_PAD_SD3_DATA7__SD3_DATA7		0x59
+				MX7D_PAD_SD3_STROBE__SD3_STROBE		0x19
+			>;
+		};
+
+		pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+			fsl,pins = <
+				MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
+				MX7D_PAD_SD3_CLK__SD3_CLK		0x1a
+				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5a
+				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5a
+				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5a
+				MX7D_PAD_SD3_DATA3__SD3_DATA3		0x5a
+				MX7D_PAD_SD3_DATA4__SD3_DATA4		0x5a
+				MX7D_PAD_SD3_DATA5__SD3_DATA5		0x5a
+				MX7D_PAD_SD3_DATA6__SD3_DATA6		0x5a
+				MX7D_PAD_SD3_DATA7__SD3_DATA7		0x5a
+				MX7D_PAD_SD3_STROBE__SD3_STROBE		0x1a
+			>;
+		};
+
+		pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
+			fsl,pins = <
+				MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
+				MX7D_PAD_SD3_CLK__SD3_CLK		0x1b
+				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5b
+				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5b
+				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5b
+				MX7D_PAD_SD3_DATA3__SD3_DATA3		0x5b
+				MX7D_PAD_SD3_DATA4__SD3_DATA4		0x5b
+				MX7D_PAD_SD3_DATA5__SD3_DATA5		0x5b
+				MX7D_PAD_SD3_DATA6__SD3_DATA6		0x5b
+				MX7D_PAD_SD3_DATA7__SD3_DATA7		0x5b
+				MX7D_PAD_SD3_STROBE__SD3_STROBE		0x1b
+			>;
+		};
+	};
+
+	qspi {
+		pinctrl_qspi1_1: qspi1grp_1 {
+			fsl,pins = <
+				MX7D_PAD_EPDC_DATA00__QSPI_A_DATA0 0x51
+				MX7D_PAD_EPDC_DATA01__QSPI_A_DATA1 0x51
+				MX7D_PAD_EPDC_DATA02__QSPI_A_DATA2 0x51
+				MX7D_PAD_EPDC_DATA03__QSPI_A_DATA3 0x51
+				MX7D_PAD_EPDC_DATA05__QSPI_A_SCLK 0x51
+				MX7D_PAD_EPDC_DATA06__QSPI_A_SS0_B 0x51
+			>;
+		};
+	};
+};
+
+&iomuxc_lpsr {
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B		0x74
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx7d-moxa-uc-8220.dts b/arch/arm/boot/dts/imx7d-moxa-uc-8220.dts
new file mode 100644
index 000000000000..e66accceeb82
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-moxa-uc-8220.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/* Copyright (C) MOXA Inc. All rights reserved.
+ * Authors: Fero JD Zhou (周俊達) <FeroJD.Zhou@moxa.com>
+ *	    Harry YJ Jhou (周亞諄) <HarryYJ.Jhou@moxa.com>
+ */
+
+#include "imx7d-moxa-uc-8210.dts"
+
+/ {
+	model = "Moxa UC-8220";
+	compatible = "moxa,uc-8220", "fsl,imx7d";
+};
+
+&pcie_phy{
+	status = "okay";
+};
+
+&pcie {
+	reset-gpio = <&i2cgpio1 14 GPIO_ACTIVE_LOW>;
+	/delete-property/ fsl,max-link-speed;
+	status = "okay";
+};
-- 
2.20.1

