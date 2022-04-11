Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50434FC08B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347861AbiDKP0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347931AbiDKPZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:25:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16343BF94;
        Mon, 11 Apr 2022 08:22:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s28so7631799wrb.5;
        Mon, 11 Apr 2022 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CZsi69FltIyPUraeseWE4UFes31YusQplCC4NibVevo=;
        b=Mp1uYvE0LL2thk5K2+ACHRiO9gxQchPX5/KcLlLno4wyHdUFZn39p1cED1L0rBt1t5
         MXOH2sCMjFl3TceWo+fp8iGJMW5lywjExmoI4W59ZK4VfcNy0L7YZFkLRvyc+mB4m3mK
         +M89cbi1BPAN9TDW549XlFz5+W+uipXixA5bVVcX7T0RvNpOI87VOE5t8IO8TJk6kEz+
         sNgGElDTMFWatfnLhh9ZneudkbOKJZPjH8oluh+Vo9At0Wp5xttNIcUj4uxRqodNTsRN
         ljvfU3v8ImIpLq2zZc70D7w3Od8Qmrt0YE4W6CS07K4IPvY8Lp5RKTvhlPUKYjeQ7oV+
         K53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CZsi69FltIyPUraeseWE4UFes31YusQplCC4NibVevo=;
        b=LFhqUArAyLR3CgSIyPhRbUbowVZYQsHSikno0gQV0DywEg9Ea611xNFts7IYpex2JF
         XFfLh7OFj4RWxjQjTD3fwaKetVDJP66gxYrG4gAyNZjO+9T5AzW6ThhJq0jjg1Uh7fcp
         QiFg4htsS3aUOH8E/ZIsscZLjGdCQ0WoREB3IA+ZEn4LA0KMFAtCJFsOzVgz+BYAEd0m
         khPSJNvXEcX9f7xY4bbZb9QNURIwDd5ZMJHo8A3i+mTJQel56gIZNmLff7qBRBHRZm9x
         fzYuyQfBMDL2FQx09eoalRD+5v4v9z0zlUsiurbihzNlXTBsi+feeFbW6TMCfNrfBzaS
         aN1Q==
X-Gm-Message-State: AOAM533TYH+oqac6rV5TpNGcj+SSQN3EAjKdbJZVBhegxLF5xzT1jaUE
        nzv2zxifA4VWHzNK4dWYWeOONbhq9n8=
X-Google-Smtp-Source: ABdhPJzBbHbd9/9Bau29KM9MQifjpjMo1Chsgipo6j58GbqbM+QOnaOIVCnkqIbMM1NhZvNRcTW8EA==
X-Received: by 2002:adf:8066:0:b0:206:1563:8b2b with SMTP id 93-20020adf8066000000b0020615638b2bmr25705535wrk.582.1649690577099;
        Mon, 11 Apr 2022 08:22:57 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm5209374wmj.29.2022.04.11.08.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:22:56 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/14] ARM: dts: imx6dl-colibri: Cleanup
Date:   Mon, 11 Apr 2022 17:22:30 +0200
Message-Id: <20220411152234.12678-11-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220411152234.12678-1-max.oss.09@gmail.com>
References: <20220411152234.12678-1-max.oss.09@gmail.com>
MIME-Version: 1.0
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

From: Max Krummenacher <max.krummenacher@toradex.com>

- Sort pinctrl nodes alphabetically
- End all pinctrl node names in grp and avoid using dashes
- Change pinctrl_usbc_id_1's node name to not use underscores
- Change the pmic's node name to pmic@8 per binding requirement
- Add sound-dai-cells to the codec node per binding requirement

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts |   2 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi       | 340 ++++++++++---------
 2 files changed, 172 insertions(+), 170 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index dff2d35e693b..7272edd85a49 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -46,10 +46,10 @@
 
 	mcp251x0: mcp251x@0 {
 		compatible = "microchip,mcp2515";
-		reg = <0>;
 		clocks = <&clk16m>;
 		interrupt-parent = <&gpio3>;
 		interrupts = <27 0x2>;
+		reg = <0>;
 		spi-max-frequency = <10000000>;
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 1c49fd3e6286..1c3c34bbfe98 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -104,36 +104,36 @@
 
 	reg_usb_host_vbus: regulator-usb-host-vbus {
 		compatible = "regulator-fixed";
+		gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>; /* USBH_PEN */
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_regulator_usbh_pwr>;
-		regulator-name = "usb_host_vbus";
-		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>; /* USBH_PEN */
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "usb_host_vbus";
 		status = "disabled";
 	};
 
 	sound {
 		compatible = "fsl,imx-audio-sgtl5000";
-		model = "imx6dl-colibri-sgtl5000";
-		ssi-controller = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"Headphone Jack", "HP_OUT",
 			"LINE_IN", "Line In Jack",
 			"MIC_IN", "Mic Jack",
 			"Mic Jack", "Mic Bias";
+		model = "imx6dl-colibri-sgtl5000";
 		mux-int-port = <1>;
 		mux-ext-port = <5>;
+		ssi-controller = <&ssi1>;
 	};
 
 	/* Optional S/PDIF in on SODIMM 88 and out on SODIMM 90, 137 or 168 */
 	sound_spdif: sound-spdif {
 		compatible = "fsl,imx-audio-spdif";
-		model = "imx-spdif";
 		spdif-controller = <&spdif>;
 		spdif-in;
 		spdif-out;
+		model = "imx-spdif";
 		status = "disabled";
 	};
 };
@@ -171,10 +171,10 @@
 };
 
 &fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rmii";
 	phy-handle = <&ethphy>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
 	status = "okay";
 
 	mdio {
@@ -425,61 +425,61 @@
 	sda-gpios = <&gpio3 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
-	pmic: pfuze100@8 {
+	pmic: pmic@8 {
 		compatible = "fsl,pfuze100";
 		fsl,pmic-stby-poweroff;
 		reg = <0x08>;
 
 		regulators {
 			sw1a_reg: sw1ab {
-				regulator-min-microvolt = <300000>;
-				regulator-max-microvolt = <1875000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1875000>;
+				regulator-min-microvolt = <300000>;
 				regulator-ramp-delay = <6250>;
 			};
 
 			sw1c_reg: sw1c {
-				regulator-min-microvolt = <300000>;
-				regulator-max-microvolt = <1875000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1875000>;
+				regulator-min-microvolt = <300000>;
 				regulator-ramp-delay = <6250>;
 			};
 
 			sw3a_reg: sw3a {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1975000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1975000>;
+				regulator-min-microvolt = <400000>;
 			};
 
 			swbst_reg: swbst {
-				regulator-min-microvolt = <5000000>;
-				regulator-max-microvolt = <5150000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <5150000>;
+				regulator-min-microvolt = <5000000>;
 			};
 
 			snvs_reg: vsnvs {
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3000000>;
+				regulator-min-microvolt = <1000000>;
 			};
 
 			vref_reg: vrefddr {
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
 			};
 
 			/* vgen1: unused */
 
 			vgen2_reg: vgen2 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1550000>;
+				regulator-min-microvolt = <800000>;
 			};
 
 			/*
@@ -487,57 +487,58 @@
 			 * the i.MX 6 NVCC_SD1.
 			 */
 			vgen3_reg: vgen3 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
 			};
 
 			vgen4_reg: vgen4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
 			};
 
 			vgen5_reg: vgen5 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
 			};
 
 			vgen6_reg: vgen6 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
 			};
 		};
 	};
 
 	codec: sgtl5000@a {
 		compatible = "fsl,sgtl5000";
-		reg = <0x0a>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
+		lrclk-strength = <3>;
+		reg = <0x0a>;
+		#sound-dai-cells = <0>;
 		VDDA-supply = <&reg_module_3v3_audio>;
 		VDDIO-supply = <&reg_module_3v3>;
 		VDDD-supply = <&vgen4_reg>;
-		lrclk-strength = <3>;
 	};
 
 	/* STMPE811 touch screen controller */
 	stmpe811@41 {
 		compatible = "st,stmpe811";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_touch_int>;
-		reg = <0x41>;
+		blocks = <0x5>;
 		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-parent = <&gpio6>;
 		interrupt-controller;
 		id = <0>;
-		blocks = <0x5>;
 		irq-trigger = <0x1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch_int>;
+		reg = <0x41>;
 		/* 3.25 MHz ADC clock speed */
 		st,adc-freq = <1>;
 		/* 12-bit ADC */
@@ -643,27 +644,27 @@
 
 /* Colibri UART_A */
 &uart1 {
+	fsl,dte-mode;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_dte &pinctrl_uart1_ctrl>;
-	fsl,dte-mode;
 	uart-has-rtscts;
 	status = "disabled";
 };
 
 /* Colibri UART_B */
 &uart2 {
+	fsl,dte-mode;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2_dte>;
-	fsl,dte-mode;
 	uart-has-rtscts;
 	status = "disabled";
 };
 
 /* Colibri UART_C */
 &uart3 {
+	fsl,dte-mode;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3_dte>;
-	fsl,dte-mode;
 	status = "disabled";
 };
 
@@ -675,27 +676,27 @@
 
 /* Colibri MMC */
 &usdhc1 {
+	cd-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>; /* MMCD */
+	bus-width = <4>;
+	no-1-8-v;
+	disable-wp;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_mmc_cd>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_mmc_cd>;
 	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_mmc_cd>;
-	cd-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>; /* MMCD */
-	disable-wp;
 	vmmc-supply = <&reg_module_3v3>;
 	vqmmc-supply = <&vgen3_reg>;
-	bus-width = <4>;
-	no-1-8-v;
 	status = "disabled";
 };
 
 /* eMMC */
 &usdhc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	vqmmc-supply = <&reg_module_3v3>;
 	bus-width = <8>;
 	no-1-8-v;
 	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	vqmmc-supply = <&reg_module_3v3>;
 	status = "okay";
 };
 
@@ -737,12 +738,12 @@
 
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
+			/* SGTL5000 sys_mclk */
+			MX6QDL_PAD_GPIO_0__CCM_CLKO1	0x000b0
 			MX6QDL_PAD_KEY_COL0__AUD5_TXC	0x130b0
 			MX6QDL_PAD_KEY_ROW0__AUD5_TXD	0x130b0
 			MX6QDL_PAD_KEY_COL1__AUD5_TXFS	0x130b0
 			MX6QDL_PAD_KEY_ROW1__AUD5_RXD	0x130b0
-			/* SGTL5000 sys_mclk */
-			MX6QDL_PAD_GPIO_0__CCM_CLKO1	0x000b0
 		>;
 	};
 
@@ -779,26 +780,26 @@
 
 	pinctrl_ecspi4: ecspi4grp {
 		fsl,pins = <
+			/* SPI CS */
+			MX6QDL_PAD_EIM_A25__GPIO5_IO02	0x000b1
 			MX6QDL_PAD_EIM_D22__ECSPI4_MISO	0x100b1
 			MX6QDL_PAD_EIM_D28__ECSPI4_MOSI	0x100b1
 			MX6QDL_PAD_EIM_D21__ECSPI4_SCLK 0x100b1
-			/* SPI CS */
-			MX6QDL_PAD_EIM_A25__GPIO5_IO02	0x000b1
 		>;
 	};
 
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
+			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
 			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
 			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+			MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER	0x1b0b0
 			MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x1b0b0
 			MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x1b0b0
-			MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER	0x1b0b0
 			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0
 			MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x1b0b0
 			MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x1b0b0
-			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
-			MX6QDL_PAD_GPIO_16__ENET_REF_CLK     ((1<<30) | 0x1b0b0)
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	((1<<30) | 0x1b0b0)
 		>;
 	};
 
@@ -835,13 +836,13 @@
 		>;
 	};
 
-	pinctrl_gpio_bl_on: gpioblon {
+	pinctrl_gpio_bl_on: gpioblongrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D26__GPIO3_IO26		0x1b0b0
 		>;
 	};
 
-	pinctrl_gpio_keys: gpiokeys {
+	pinctrl_gpio_keys: gpiokeysgrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_A16__GPIO2_IO22		0x130b0
 		>;
@@ -856,15 +857,15 @@
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_EB2__I2C2_SCL 0x4001b8b1
 			MX6QDL_PAD_EIM_D16__I2C2_SDA 0x4001b8b1
+			MX6QDL_PAD_EIM_EB2__I2C2_SCL 0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c2_gpio: i2c2gpiogrp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_EB2__GPIO2_IO30 0x4001b8b1
 			MX6QDL_PAD_EIM_D16__GPIO3_IO16 0x4001b8b1
+			MX6QDL_PAD_EIM_EB2__GPIO2_IO30 0x4001b8b1
 		>;
 	};
 
@@ -896,8 +897,8 @@
 			MX6QDL_PAD_EIM_EB3__IPU1_CSI1_HSYNC	0xb0b1
 			MX6QDL_PAD_EIM_D29__IPU1_CSI1_VSYNC	0xb0b1
 			/* Disable PWM pins on camera interface */
-			MX6QDL_PAD_SD4_DAT1__GPIO2_IO09		0x40
 			MX6QDL_PAD_GPIO_1__GPIO1_IO01		0x40
+			MX6QDL_PAD_SD4_DAT1__GPIO2_IO09		0x40
 		>;
 	};
 
@@ -937,14 +938,14 @@
 		>;
 	};
 
-	pinctrl_mic_gnd: gpiomicgnd {
+	pinctrl_mic_gnd: micgndgrp {
 		fsl,pins = <
 			/* Controls Mic GND, PU or '1' pull Mic GND to GND */
 			MX6QDL_PAD_RGMII_TD1__GPIO6_IO21 0x1b0b0
 		>;
 	};
 
-	pinctrl_mmc_cd: gpiommccd {
+	pinctrl_mmc_cd: mmccdgrp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_D5__GPIO2_IO05	0x1b0b1
 		>;
@@ -958,15 +959,15 @@
 
 	pinctrl_pwm2: pwm2grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_1__PWM2_OUT	0x1b0b1
 			MX6QDL_PAD_EIM_A21__GPIO2_IO17	0x00040
+			MX6QDL_PAD_GPIO_1__PWM2_OUT	0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm3: pwm3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_DAT1__PWM3_OUT	0x1b0b1
 			MX6QDL_PAD_EIM_A22__GPIO2_IO16	0x00040
+			MX6QDL_PAD_SD4_DAT1__PWM3_OUT	0x1b0b1
 		>;
 	};
 
@@ -983,13 +984,6 @@
 		>;
 	};
 
-	pinctrl_usbh_oc_1: usbhoc1grp {
-		fsl,pins = <
-			/* USBH_OC */
-			MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x1b0b0
-		>;
-	};
-
 	pinctrl_spdif: spdifgrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x1b0b0
@@ -1032,9 +1026,9 @@
 	pinctrl_uart2_dte: uart2dtegrp {
 		fsl,pins = <
 			MX6QDL_PAD_SD4_DAT4__UART2_TX_DATA	0x1b0b1
-			MX6QDL_PAD_SD4_DAT7__UART2_RX_DATA	0x1b0b1
-			MX6QDL_PAD_SD4_DAT6__UART2_RTS_B	0x1b0b1
 			MX6QDL_PAD_SD4_DAT5__UART2_CTS_B	0x1b0b1
+			MX6QDL_PAD_SD4_DAT6__UART2_RTS_B	0x1b0b1
+			MX6QDL_PAD_SD4_DAT7__UART2_RX_DATA	0x1b0b1
 		>;
 	};
 
@@ -1049,20 +1043,27 @@
 		fsl,pins = <
 			/* USBC_DET */
 			MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x1b0b0
-			/* USBC_DET_EN */
-			MX6QDL_PAD_RGMII_TX_CTL__GPIO6_IO26	0x0f058
 			/* USBC_DET_OVERWRITE */
 			MX6QDL_PAD_RGMII_RXC__GPIO6_IO30	0x0f058
+			/* USBC_DET_EN */
+			MX6QDL_PAD_RGMII_TX_CTL__GPIO6_IO26	0x0f058
 		>;
 	};
 
-	pinctrl_usbc_id_1: usbc_id-1 {
+	pinctrl_usbc_id_1: usbcid1grp {
 		fsl,pins = <
 			/* USBC_ID */
 			MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x1b0b0
 		>;
 	};
 
+	pinctrl_usbh_oc_1: usbhoc1grp {
+		fsl,pins = <
+			/* USBH_OC */
+			MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x1b0b0
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD1_CMD__SD1_CMD	0x17071
@@ -1074,7 +1075,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
 		fsl,pins = <
 			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170b1
 			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100b1
@@ -1085,7 +1086,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 		fsl,pins = <
 			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170f1
 			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100f1
@@ -1134,135 +1135,136 @@
 		>;
 	};
 
-	pinctrl_weim_sram: weimsramgrp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_OE__EIM_OE_B		0xb0b1
-			MX6QDL_PAD_EIM_RW__EIM_RW		0xb0b1
-			/* Data */
-			MX6QDL_PAD_CSI0_DATA_EN__EIM_DATA00	0x1b0b0
-			MX6QDL_PAD_CSI0_VSYNC__EIM_DATA01	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT4__EIM_DATA02	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT5__EIM_DATA03	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT6__EIM_DATA04	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT7__EIM_DATA05	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT8__EIM_DATA06	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT9__EIM_DATA07	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT12__EIM_DATA08	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT13__EIM_DATA09	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT14__EIM_DATA10	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT15__EIM_DATA11	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT16__EIM_DATA12	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT17__EIM_DATA13	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT18__EIM_DATA14	0x1b0b0
-			MX6QDL_PAD_CSI0_DAT19__EIM_DATA15	0x1b0b0
-			/* Address */
-			MX6QDL_PAD_EIM_DA15__EIM_AD15		0xb0b1
-			MX6QDL_PAD_EIM_DA14__EIM_AD14		0xb0b1
-			MX6QDL_PAD_EIM_DA13__EIM_AD13		0xb0b1
-			MX6QDL_PAD_EIM_DA12__EIM_AD12		0xb0b1
-			MX6QDL_PAD_EIM_DA11__EIM_AD11		0xb0b1
-			MX6QDL_PAD_EIM_DA10__EIM_AD10		0xb0b1
-			MX6QDL_PAD_EIM_DA9__EIM_AD09		0xb0b1
-			MX6QDL_PAD_EIM_DA8__EIM_AD08		0xb0b1
-			MX6QDL_PAD_EIM_DA7__EIM_AD07		0xb0b1
-			MX6QDL_PAD_EIM_DA6__EIM_AD06		0xb0b1
-			MX6QDL_PAD_EIM_DA5__EIM_AD05		0xb0b1
-			MX6QDL_PAD_EIM_DA4__EIM_AD04		0xb0b1
-			MX6QDL_PAD_EIM_DA3__EIM_AD03		0xb0b1
-			MX6QDL_PAD_EIM_DA2__EIM_AD02		0xb0b1
-			MX6QDL_PAD_EIM_DA1__EIM_AD01		0xb0b1
-			MX6QDL_PAD_EIM_DA0__EIM_AD00		0xb0b1
-		>;
-	};
-
-	pinctrl_weim_rdnwr: weimrdnwr {
-		fsl,pins = <
-			MX6QDL_PAD_SD2_CLK__GPIO1_IO10		0x0040
-			MX6QDL_PAD_RGMII_TD3__GPIO6_IO23	0x130b0
-		>;
-	};
-
-	pinctrl_weim_npwe: weimnpwe {
-		fsl,pins = <
-			MX6QDL_PAD_SD2_DAT3__GPIO1_IO12		0x0040
-			MX6QDL_PAD_RGMII_TD2__GPIO6_IO22	0x130b0
-		>;
-	};
-
 	/* ADDRESS[16:18] [25] used as GPIO */
-	pinctrl_weim_gpio_1: weimgpio-1 {
+	pinctrl_weim_gpio_1: weimgpio1grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0
-			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11		0x1b0b0
-			MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x1b0b0
 			MX6QDL_PAD_DISP0_DAT23__GPIO5_IO17	0x1b0b0
 			MX6QDL_PAD_DISP0_DAT22__GPIO5_IO16	0x1b0b0
 			MX6QDL_PAD_DISP0_DAT21__GPIO5_IO15	0x1b0b0
 			MX6QDL_PAD_DISP0_DAT20__GPIO5_IO14	0x1b0b0
 			MX6QDL_PAD_DISP0_DAT19__GPIO5_IO13	0x1b0b0
 			MX6QDL_PAD_DISP0_DAT18__GPIO5_IO12	0x1b0b0
+			MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x1b0b0
+			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0
+			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11		0x1b0b0
 			MX6QDL_PAD_NANDF_D1__GPIO2_IO01		0x1b0b0
 		>;
 	};
 
 	/* ADDRESS[19:24] used as GPIO */
-	pinctrl_weim_gpio_2: weimgpio-2 {
+	pinctrl_weim_gpio_2: weimgpio2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11		0x1b0b0
-			MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x1b0b0
-			MX6QDL_PAD_DISP0_DAT23__GPIO5_IO17	0x1b0b0
-			MX6QDL_PAD_DISP0_DAT22__GPIO5_IO16	0x1b0b0
-			MX6QDL_PAD_DISP0_DAT21__GPIO5_IO15	0x1b0b0
-			MX6QDL_PAD_DISP0_DAT20__GPIO5_IO14	0x1b0b0
-			MX6QDL_PAD_DISP0_DAT19__GPIO5_IO13	0x1b0b0
 			MX6QDL_PAD_DISP0_DAT18__GPIO5_IO12	0x1b0b0
+			MX6QDL_PAD_DISP0_DAT19__GPIO5_IO13	0x1b0b0
+			MX6QDL_PAD_DISP0_DAT20__GPIO5_IO14	0x1b0b0
+			MX6QDL_PAD_DISP0_DAT21__GPIO5_IO15	0x1b0b0
+			MX6QDL_PAD_DISP0_DAT22__GPIO5_IO16	0x1b0b0
+			MX6QDL_PAD_DISP0_DAT23__GPIO5_IO17	0x1b0b0
+			MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x1b0b0
+			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11		0x1b0b0
 			MX6QDL_PAD_NANDF_D1__GPIO2_IO01		0x1b0b0
 		>;
 	};
 
 	/* DATA[16:31] used as GPIO */
-	pinctrl_weim_gpio_3: weimgpio-3 {
+	pinctrl_weim_gpio_3: weimgpio3grp {
 		fsl,pins = <
+			MX6QDL_PAD_CSI0_MCLK__GPIO5_IO19	0x1b0b0
+			MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18	0x1b0b0
 			MX6QDL_PAD_EIM_LBA__GPIO2_IO27		0x1b0b0
 			MX6QDL_PAD_EIM_BCLK__GPIO6_IO31		0x1b0b0
-			MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x1b0b0
-			MX6QDL_PAD_NANDF_CS1__GPIO6_IO14	0x1b0b0
-			MX6QDL_PAD_NANDF_RB0__GPIO6_IO10	0x1b0b0
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1b0b0
+			MX6QDL_PAD_GPIO_5__GPIO1_IO05		0x1b0b0
+			MX6QDL_PAD_GPIO_19__GPIO4_IO05		0x1b0b0
 			MX6QDL_PAD_NANDF_ALE__GPIO6_IO08	0x1b0b0
-			MX6QDL_PAD_NANDF_WP_B__GPIO6_IO09	0x1b0b0
 			MX6QDL_PAD_NANDF_CS0__GPIO6_IO11	0x1b0b0
+			MX6QDL_PAD_NANDF_CS1__GPIO6_IO14	0x1b0b0
+			MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x1b0b0
 			MX6QDL_PAD_NANDF_CLE__GPIO6_IO07	0x1b0b0
-			MX6QDL_PAD_GPIO_19__GPIO4_IO05		0x1b0b0
-			MX6QDL_PAD_CSI0_MCLK__GPIO5_IO19	0x1b0b0
-			MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18	0x1b0b0
-			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1b0b0
-			MX6QDL_PAD_GPIO_5__GPIO1_IO05		0x1b0b0
-			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0
+			MX6QDL_PAD_NANDF_RB0__GPIO6_IO10	0x1b0b0
+			MX6QDL_PAD_NANDF_WP_B__GPIO6_IO09	0x1b0b0
 		>;
 	};
 
 	/* DQM[0:3] used as GPIO */
-	pinctrl_weim_gpio_4: weimgpio-4 {
+	pinctrl_weim_gpio_4: weimgpio4grp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_EB0__GPIO2_IO28		0x1b0b0
 			MX6QDL_PAD_EIM_EB1__GPIO2_IO29		0x1b0b0
-			MX6QDL_PAD_SD2_DAT2__GPIO1_IO13		0x1b0b0
 			MX6QDL_PAD_NANDF_D0__GPIO2_IO00		0x1b0b0
+			MX6QDL_PAD_SD2_DAT2__GPIO1_IO13		0x1b0b0
 		>;
 	};
 
 	/* RDY used as GPIO */
-	pinctrl_weim_gpio_5: weimgpio-5 {
+	pinctrl_weim_gpio_5: weimgpio5grp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_WAIT__GPIO5_IO00		0x1b0b0
 		>;
 	};
 
 	/* ADDRESS[16] DATA[30] used as GPIO */
-	pinctrl_weim_gpio_6: weimgpio-6 {
+	pinctrl_weim_gpio_6: weimgpio6grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0
 			MX6QDL_PAD_KEY_COL4__GPIO4_IO14		0x1b0b0
+			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0
+		>;
+	};
+
+	pinctrl_weim_npwe: weimnpwegrp {
+		fsl,pins = <
+			MX6QDL_PAD_RGMII_TD2__GPIO6_IO22	0x130b0
+			MX6QDL_PAD_SD2_DAT3__GPIO1_IO12		0x0040
+		>;
+	};
+
+	pinctrl_weim_sram: weimsramgrp {
+		fsl,pins = <
+			/* Data */
+			MX6QDL_PAD_CSI0_DAT4__EIM_DATA02	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT5__EIM_DATA03	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT6__EIM_DATA04	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT7__EIM_DATA05	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT8__EIM_DATA06	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT9__EIM_DATA07	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT12__EIM_DATA08	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT13__EIM_DATA09	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT14__EIM_DATA10	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT15__EIM_DATA11	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT16__EIM_DATA12	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT17__EIM_DATA13	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT18__EIM_DATA14	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT19__EIM_DATA15	0x1b0b0
+			MX6QDL_PAD_CSI0_DATA_EN__EIM_DATA00	0x1b0b0
+			MX6QDL_PAD_CSI0_VSYNC__EIM_DATA01	0x1b0b0
+			/* Address */
+			MX6QDL_PAD_EIM_DA0__EIM_AD00		0xb0b1
+			MX6QDL_PAD_EIM_DA1__EIM_AD01		0xb0b1
+			MX6QDL_PAD_EIM_DA2__EIM_AD02		0xb0b1
+			MX6QDL_PAD_EIM_DA3__EIM_AD03		0xb0b1
+			MX6QDL_PAD_EIM_DA4__EIM_AD04		0xb0b1
+			MX6QDL_PAD_EIM_DA5__EIM_AD05		0xb0b1
+			MX6QDL_PAD_EIM_DA6__EIM_AD06		0xb0b1
+			MX6QDL_PAD_EIM_DA7__EIM_AD07		0xb0b1
+			MX6QDL_PAD_EIM_DA8__EIM_AD08		0xb0b1
+			MX6QDL_PAD_EIM_DA9__EIM_AD09		0xb0b1
+			MX6QDL_PAD_EIM_DA10__EIM_AD10		0xb0b1
+			MX6QDL_PAD_EIM_DA11__EIM_AD11		0xb0b1
+			MX6QDL_PAD_EIM_DA12__EIM_AD12		0xb0b1
+			MX6QDL_PAD_EIM_DA13__EIM_AD13		0xb0b1
+			MX6QDL_PAD_EIM_DA14__EIM_AD14		0xb0b1
+			MX6QDL_PAD_EIM_DA15__EIM_AD15		0xb0b1
+			/* Ctrl */
+			MX6QDL_PAD_EIM_OE__EIM_OE_B		0xb0b1
+			MX6QDL_PAD_EIM_RW__EIM_RW		0xb0b1
+		>;
+	};
+
+	pinctrl_weim_rdnwr: weimrdnwrgrp {
+		fsl,pins = <
+			MX6QDL_PAD_RGMII_TD3__GPIO6_IO23	0x130b0
+			MX6QDL_PAD_SD2_CLK__GPIO1_IO10		0x0040
 		>;
 	};
 };
-- 
2.20.1

