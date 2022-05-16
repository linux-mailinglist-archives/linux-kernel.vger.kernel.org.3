Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD605283C2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243456AbiEPMBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243366AbiEPMAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:00:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC616175AD;
        Mon, 16 May 2022 04:59:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i40so2959659eda.7;
        Mon, 16 May 2022 04:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8v3zC+bcVZmBX8bpVu6ShxZSvB7w6D1hvShbIHcKXX8=;
        b=iwv6B2A9Yc5HYYGnzu0TdMiPeTA/tI/mlOqma9m8t/aG3YLMUSi2e8SNXNXE1/BZOV
         oPa8lW9o6hjACb5+giJqyASnlGBnn1opye8Rrjhrv+nNN2LUvXX0OnNteELE/oFAOtPK
         G8o1iEOgIsLE8/AfZTEvDet1esikgr2ysCnofUtbIWL2qp0PoCuofm88vAU93dHngCMQ
         fyvVHSEUSjxoTIOz0OncmidZmm1O8IwrUXL1yB7dmU9+7GvOmC7pdMhWXmwageWBfgPh
         yqdYAMeEqvdZ/3WIryMuCBh5cCSsJRzJfayuJrEhVmc/+di87ZS/yfj+VMlGCdPlOa3c
         VAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8v3zC+bcVZmBX8bpVu6ShxZSvB7w6D1hvShbIHcKXX8=;
        b=B1H936o07KIdRg6qkU74FYfDVdFlQ9RpWJGYkKfkpYUCi7dzcR93ojfXfonmAL1JlI
         RcbICogPE09vAuIAK5HrQZgfT3hkE/6GgpfT52Nzd3Q7tKy9AhxjiaK7sHX5Ay/cEE7I
         hLqNNVyz1304T/WeXEIZMP4IO4t6rzzGdDCRaFd0WGSxmMAGvPL3ouTnv0OTnFoQ2pPM
         8JKCuieJ8OykZAtwnNojAMLIpyljlEDdRLuSAufRFeGMztKNhxrZuGTfPARDGDfs+OqG
         8LfFOKCn2xrGMpa+dv/zaPEogg4C1VpLMQvbRDclOKlzeVu+p+128DhgTx/RG6TSKtKM
         4zmA==
X-Gm-Message-State: AOAM531Tcd7cRTmaIVTWSfkDkBxceLBnIC1gLOwO+mjDgvM1GIEjOwRm
        BhdN43U5XzkBxWP9La1gdqy91/LtE/Y=
X-Google-Smtp-Source: ABdhPJxKX86h4Ns8le0iLrkZPm5IIbaDY1DcGfkoDOXZ1aATJzOtvau51LfII5C11wT0ADcnHhsgig==
X-Received: by 2002:a05:6402:26d3:b0:427:c590:ae2 with SMTP id x19-20020a05640226d300b00427c5900ae2mr12978421edd.242.1652702384025;
        Mon, 16 May 2022 04:59:44 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:43 -0700 (PDT)
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
Subject: [PATCH v1 17/17] ARM: dts: imx6q-apalis: Cleanup
Date:   Mon, 16 May 2022 13:58:45 +0200
Message-Id: <20220516115846.58328-18-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220516115846.58328-1-max.oss.09@gmail.com>
References: <20220516115846.58328-1-max.oss.09@gmail.com>
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

- Sort nodes and properties alphabetical
- End all pinctrl node names in grp and avoid using dashes
- Change the pmic's node name to pmic@8 per binding requirement
- Add sound-dai-cells to the codec node per binding requirement

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 arch/arm/boot/dts/imx6q-apalis-eval.dts  |  24 +--
 arch/arm/boot/dts/imx6q-apalis-ixora.dts |  19 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi    | 221 ++++++++++++-----------
 3 files changed, 132 insertions(+), 132 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 5c4d9a4ec586..b3e169239a19 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -36,31 +36,31 @@
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
 		wakeup {
-			label = "Wake-Up";
+			debounce-interval = <10>;
 			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+			label = "Wake-Up";
 			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
 			wakeup-source;
 		};
 	};
 
 	reg_pcie_switch: regulator-pcie-switch {
 		compatible = "regulator-fixed";
-		regulator-name = "pcie_switch";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
+		enable-active-high;
 		gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "pcie_switch";
 		startup-delay-us = <100000>;
-		enable-active-high;
 		status = "okay";
 	};
 
 	reg_3v3_sw: regulator-3v3-sw {
 		compatible = "regulator-fixed";
-		regulator-name = "3.3V_SW";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3.3V_SW";
 	};
 };
 
@@ -124,11 +124,11 @@
 	status = "okay";
 };
 
-&reg_usb_otg_vbus {
+&reg_usb_host_vbus {
 	status = "okay";
 };
 
-&reg_usb_host_vbus {
+&reg_usb_otg_vbus {
 	status = "okay";
 };
 
@@ -177,8 +177,8 @@
 
 /* SD1 */
 &usdhc2 {
+	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2 &pinctrl_sd_cd>;
-	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 97ddf4621bdf..8a12585ab062 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -36,38 +36,37 @@
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
 		wakeup {
-			label = "Wake-Up";
+			debounce-interval = <10>;
 			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+			label = "Wake-Up";
 			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
 			wakeup-source;
 		};
 	};
 
 	leds {
 		compatible = "gpio-leds";
-
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_leds_ixora>;
 
 		led4-green {
-			label = "LED_4_GREEN";
 			gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
+			label = "LED_4_GREEN";
 		};
 
 		led4-red {
-			label = "LED_4_RED";
 			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
+			label = "LED_4_RED";
 		};
 
 		led5-green {
-			label = "LED_5_GREEN";
 			gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+			label = "LED_5_GREEN";
 		};
 
 		led5-red {
-			label = "LED_5_RED";
 			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+			label = "LED_5_RED";
 		};
 	};
 };
@@ -129,11 +128,11 @@
 	status = "okay";
 };
 
-&reg_usb_otg_vbus {
+&reg_usb_host_vbus {
 	status = "okay";
 };
 
-&reg_usb_host_vbus {
+&reg_usb_otg_vbus {
 	status = "okay";
 };
 
@@ -177,9 +176,9 @@
 
 /* SD1 */
 &usdhc2 {
+	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2 &pinctrl_sd_cd>;
-	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 62d9d907432c..7a1feaa5bc23 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -89,18 +89,18 @@
 
 	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "+V3.3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3";
 	};
 
 	reg_module_3v3_audio: regulator-module-3v3-audio {
 		compatible = "regulator-fixed";
-		regulator-name = "+V3.3_AUDIO";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_AUDIO";
 	};
 
 	reg_ov5640_1v8_d_o_vdd: regulator-ov5640-1v8-d-o-vdd {
@@ -125,63 +125,63 @@
 
 	reg_usb_otg_vbus: regulator-usb-otg-vbus {
 		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_regulator_usbotg_pwr>;
-		regulator-name = "usb_otg_vbus";
-		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "usb_otg_vbus";
 		status = "disabled";
 	};
 
 	/* on module USB hub */
 	reg_usb_host_vbus_hub: regulator-usb-host-vbus-hub {
 		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio3 28 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_regulator_usbhub_pwr>;
-		regulator-name = "usb_host_vbus_hub";
-		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio3 28 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "usb_host_vbus_hub";
 		startup-delay-us = <2000>;
-		enable-active-high;
 		status = "okay";
 	};
 
 	reg_usb_host_vbus: regulator-usb-host-vbus {
 		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio =  <&gpio1 0 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_regulator_usbh_pwr>;
-		regulator-name = "usb_host_vbus";
-		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		gpio =  <&gpio1 0 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "usb_host_vbus";
 		vin-supply = <&reg_usb_host_vbus_hub>;
 		status = "disabled";
 	};
 
 	sound {
 		compatible = "fsl,imx-audio-sgtl5000";
-		model = "imx6q-apalis-sgtl5000";
-		ssi-controller = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
 			"LINE_IN", "Line In Jack",
 			"MIC_IN", "Mic Jack",
 			"Mic Jack", "Mic Bias",
 			"Headphone Jack", "HP_OUT";
-		mux-int-port = <1>;
+		model = "imx6q-apalis-sgtl5000";
 		mux-ext-port = <4>;
+		mux-int-port = <1>;
+		ssi-controller = <&ssi1>;
 	};
 
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
@@ -495,104 +495,105 @@
 	sda-gpios = <&gpio4 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
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
 
 			vgen1_reg: vgen1 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1550000>;
+				regulator-min-microvolt = <800000>;
 			};
 
 			vgen2_reg: vgen2 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1550000>;
+				regulator-min-microvolt = <800000>;
 			};
 
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
+		#sound-dai-cells = <0>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_sgtl5000>;
-		clocks = <&clks IMX6QDL_CLK_CKO>;
+		reg = <0x0a>;
 		VDDA-supply = <&reg_module_3v3_audio>;
 		VDDIO-supply = <&reg_module_3v3>;
 		VDDD-supply = <&vgen4_reg>;
@@ -601,15 +602,15 @@
 	/* STMPE811 touch screen controller */
 	stmpe811@41 {
 		compatible = "st,stmpe811";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_touch_int>;
-		reg = <0x41>;
+		blocks = <0x5>;
+		id = <0>;
 		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-parent = <&gpio4>;
 		interrupt-controller;
-		id = <0>;
-		blocks = <0x5>;
+		interrupt-parent = <&gpio4>;
 		irq-trigger = <0x1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch_int>;
+		reg = <0x41>;
 		/* 3.25 MHz ADC clock speed */
 		st,adc-freq = <1>;
 		/* 12-bit ADC */
@@ -639,9 +640,9 @@
 
 		stmpe_adc: stmpe_adc {
 			compatible = "st,stmpe-adc";
+			#io-channel-cells = <1>;
 			/* forbid to use ADC channels 3-0 (touch) */
 			st,norequest-mask = <0x0F>;
-			#io-channel-cells = <1>;
 		};
 	};
 };
@@ -661,9 +662,9 @@
 
 	adv_7280: adv7280@21 {
 		compatible = "adi,adv7280";
-		reg = <0x21>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ipu1_csi0>;
+		reg = <0x21>;
 		status = "disabled";
 
 		port {
@@ -679,8 +680,8 @@
 		AVDD-supply = <&reg_ov5640_2v8_a_vdd>;
 		DOVDD-supply = <&reg_ov5640_1v8_d_o_vdd>;
 		DVDD-supply = <&reg_ov5640_1v8_d_o_vdd>;
-		clocks = <&clks IMX6QDL_CLK_CKO2>;
 		clock-names = "xclk";
+		clocks = <&clks IMX6QDL_CLK_CKO2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_cam_mclk>;
 		/* These GPIOs are muxed with the iomuxc node */
@@ -778,73 +779,73 @@
 };
 
 &uart1 {
+	fsl,dte-mode;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_dte &pinctrl_uart1_ctrl>;
-	fsl,dte-mode;
 	uart-has-rtscts;
 	status = "disabled";
 };
 
 &uart2 {
+	fsl,dte-mode;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2_dte>;
-	fsl,dte-mode;
 	uart-has-rtscts;
 	status = "disabled";
 };
 
 &uart4 {
+	fsl,dte-mode;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4_dte>;
-	fsl,dte-mode;
 	status = "disabled";
 };
 
 &uart5 {
+	fsl,dte-mode;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart5_dte>;
-	fsl,dte-mode;
 	status = "disabled";
 };
 
 &usbotg {
+	disable-over-current;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbotg>;
-	disable-over-current;
 	status = "disabled";
 };
 
 /* MMC1 */
 &usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1_4bit &pinctrl_usdhc1_8bit &pinctrl_mmc_cd>;
-	cd-gpios = <&gpio4 20 GPIO_ACTIVE_LOW>;
-	vqmmc-supply = <&reg_module_3v3>;
 	bus-width = <8>;
+	cd-gpios = <&gpio4 20 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	no-1-8-v;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1_4bit &pinctrl_usdhc1_8bit &pinctrl_mmc_cd>;
+	vqmmc-supply = <&reg_module_3v3>;
 	status = "disabled";
 };
 
 /* SD1 */
 &usdhc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	vqmmc-supply = <&reg_module_3v3>;
 	bus-width = <4>;
 	disable-wp;
 	no-1-8-v;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	vqmmc-supply = <&reg_module_3v3>;
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
 
@@ -861,49 +862,49 @@
 		     &pinctrl_apalis_gpio7 &pinctrl_apalis_gpio8
 		    >;
 
-	pinctrl_apalis_gpio1: gpio2io04grp {
+	pinctrl_apalis_gpio1: apalisgpio1grp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_D4__GPIO2_IO04 0x130b0
 		>;
 	};
 
-	pinctrl_apalis_gpio2: gpio2io05grp {
+	pinctrl_apalis_gpio2: apalisgpio2grp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_D5__GPIO2_IO05 0x130b0
 		>;
 	};
 
-	pinctrl_apalis_gpio3: gpio2io06grp {
+	pinctrl_apalis_gpio3: apalisgpio3grp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_D6__GPIO2_IO06 0x130b0
 		>;
 	};
 
-	pinctrl_apalis_gpio4: gpio2io07grp {
+	pinctrl_apalis_gpio4: apalisgpio4grp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_D7__GPIO2_IO07 0x130b0
 		>;
 	};
 
-	pinctrl_apalis_gpio5: gpio6io10grp {
+	pinctrl_apalis_gpio5: apalisgpio5grp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_RB0__GPIO6_IO10 0x130b0
 		>;
 	};
 
-	pinctrl_apalis_gpio6: gpio6io09grp {
+	pinctrl_apalis_gpio6: apalisgpio6grp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_WP_B__GPIO6_IO09 0x130b0
 		>;
 	};
 
-	pinctrl_apalis_gpio7: gpio1io02grp {
+	pinctrl_apalis_gpio7: apalisgpio7grp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x130b0
 		>;
 	};
 
-	pinctrl_apalis_gpio8: gpio1io06grp {
+	pinctrl_apalis_gpio8: apalisgpio8grp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_6__GPIO1_IO06 0x130b0
 		>;
@@ -996,7 +997,7 @@
 		>;
 	};
 
-	pinctrl_gpio_bl_on: gpioblon {
+	pinctrl_gpio_bl_on: gpioblongrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_DA13__GPIO3_IO13 0x1b0b0
 		>;
@@ -1141,7 +1142,7 @@
 		>;
 	};
 
-	pinctrl_mmc_cd: gpiommccdgrp {
+	pinctrl_mmc_cd: mmccdgrp {
 		fsl,pins = <
 			 /* MMC1 CD */
 			MX6QDL_PAD_DI0_PIN4__GPIO4_IO20 0x000b0
@@ -1172,35 +1173,35 @@
 		>;
 	};
 
-	pinctrl_regulator_usbh_pwr: gpioregusbhpwrgrp {
+	pinctrl_regulator_usbh_pwr: regusbhpwrgrp {
 		fsl,pins = <
 			/* USBH_EN */
 			MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x0f058
 		>;
 	};
 
-	pinctrl_regulator_usbhub_pwr: gpioregusbhubpwrgrp {
+	pinctrl_regulator_usbhub_pwr: regusbhubpwrgrp {
 		fsl,pins = <
 			/* USBH_HUB_EN */
 			MX6QDL_PAD_EIM_D28__GPIO3_IO28 0x0f058
 		>;
 	};
 
-	pinctrl_regulator_usbotg_pwr: gpioregusbotgpwrgrp {
+	pinctrl_regulator_usbotg_pwr: regusbotgpwrgrp {
 		fsl,pins = <
 			/* USBO1 power en */
 			MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x0f058
 		>;
 	};
 
-	pinctrl_reset_moci: gpioresetmocigrp {
+	pinctrl_reset_moci: resetmocigrp {
 		fsl,pins = <
 			/* RESET_MOCI control */
 			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 0x0f058
 		>;
 	};
 
-	pinctrl_sd_cd: gpiosdcdgrp {
+	pinctrl_sd_cd: sdcdgrp {
 		fsl,pins = <
 			/* SD1 CD */
 			MX6QDL_PAD_NANDF_CS1__GPIO6_IO14 0x000b0
@@ -1220,13 +1221,22 @@
 		>;
 	};
 
-	pinctrl_touch_int: gpiotouchintgrp {
+	pinctrl_touch_int: touchintgrp {
 		fsl,pins = <
 			/* STMPE811 interrupt */
 			MX6QDL_PAD_KEY_COL2__GPIO4_IO10 0x1b0b0
 		>;
 	};
 
+	/* Additional DTR, DSR, DCD */
+	pinctrl_uart1_ctrl: uart1ctrlgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D23__UART1_DCD_B 0x1b0b0
+			MX6QDL_PAD_EIM_D24__UART1_DTR_B 0x1b0b0
+			MX6QDL_PAD_EIM_D25__UART1_DSR_B 0x1b0b0
+		>;
+	};
+
 	pinctrl_uart1_dce: uart1dcegrp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b1
@@ -1244,15 +1254,6 @@
 		>;
 	};
 
-	/* Additional DTR, DSR, DCD */
-	pinctrl_uart1_ctrl: uart1ctrlgrp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D23__UART1_DCD_B 0x1b0b0
-			MX6QDL_PAD_EIM_D24__UART1_DTR_B 0x1b0b0
-			MX6QDL_PAD_EIM_D25__UART1_DSR_B 0x1b0b0
-		>;
-	};
-
 	pinctrl_uart2_dce: uart2dcegrp {
 		fsl,pins = <
 			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
@@ -1306,7 +1307,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_4bit: usdhc1grp_4bit {
+	pinctrl_usdhc1_4bit: usdhc1-4bitgrp {
 		fsl,pins = <
 			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17071
 			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10071
@@ -1317,7 +1318,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_8bit: usdhc1grp_8bit {
+	pinctrl_usdhc1_8bit: usdhc1-8bitgrp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_D0__SD1_DATA4 0x17071
 			MX6QDL_PAD_NANDF_D1__SD1_DATA5 0x17071
-- 
2.20.1

