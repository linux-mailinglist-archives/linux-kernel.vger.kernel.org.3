Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FE454C7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbiFOLwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347341AbiFOLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:51:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD21652E68;
        Wed, 15 Jun 2022 04:51:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z7so15701525edm.13;
        Wed, 15 Jun 2022 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10+32VK54gywmC65FQtK3Ns/iYunGgukoywkV4SGwPk=;
        b=XRkloq/aNSv5Cur3xtsLJhUYE3sNt+0TfUjF+uWz37Q35+0ZTU4pt4PZWmNmHgwYYl
         Ke36uyaLAWlqoBkScu4BwL+emLrjw79HtOd3RkeFYXso9mTHy0zBh6ECH6uYBgoAivP/
         2CHI6lXRJBhmh0HELzaNN6aFsg1bJG0nLGf5m9hm81juPBdPyls22L2XvB2gdQihhe/p
         Q6J9bIQwKRBgkbfultGT9J5IwYIASuCgzGDTg3bH0Pg9dwUQQnSSDI53t7wUBg0VD2iQ
         AiurgI55T4HC3/ts6+XbtHu8zDkhsGUKUyqnYS73LFmC2HDB8tVOdEArZ39j+6lbLISL
         cAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10+32VK54gywmC65FQtK3Ns/iYunGgukoywkV4SGwPk=;
        b=PYZfJ9YynAfgFMqoTqYPaJNQI0Goe+zlOh/i5oVNjLh9lptLQGRxkrV2AcyEOVcijf
         xrYiUzJ0GsHLd/RlI2mYxWga+XNyW1Z99YpArsnOFK20ZyL2kb/Kt0GTklrurK1bED7k
         /rhPbqODaYr6NYqNurUjv6ddyGlH1TSyAvMYoAujrqB800iudzXjPWGyRG4tHh6cGzM6
         TDbXgKH7SnTSUoB6x+zQ0fxckDJZT/iCJ0czeDO1/d0u8lq6e1aV81BRUS/aKXlW732n
         UKFftIPo9U1eIvpe/mgmtxNBw7drfU2aDgj3DHUa9iD2HgiSU2R5iLq/6kXbTMVHvI4Y
         i30w==
X-Gm-Message-State: AOAM533eBlkPSVlylz4kXdE8ipRu/ixBtdlcXTuuK9nZO7Ylsh2CfZAW
        XQ93tZym+GdmBTOcbBMYUXA=
X-Google-Smtp-Source: AGRyM1uqiNsX2pOsZ2hcCnWRAYX/se5jYeXmEkFwwwRhGQFYY9AaYhGT6SHO8Lfx6tWNJWCCr0rgtg==
X-Received: by 2002:a05:6402:1941:b0:413:2555:53e3 with SMTP id f1-20020a056402194100b00413255553e3mr12460981edz.164.1655293865434;
        Wed, 15 Jun 2022 04:51:05 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:51:05 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/18] ARM: dts: imx6q-apalis: Cleanup
Date:   Wed, 15 Jun 2022 13:50:06 +0200
Message-Id: <20220615115006.45672-19-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220615115006.45672-1-max.oss.09@gmail.com>
References: <20220615115006.45672-1-max.oss.09@gmail.com>
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

Changes in v2:
- Moved cleanup for things added in earlier commits of the series to
  the those commit rather than cleaning up later.
- Added reviewed-by tags
- Fixed '-' vs. '_' in node name as pointed out by Fabio
- Added "adv,force-bt656-4" property as suggested by Fabio.
- Added commit "ARM: dts: imx6q-apalis: move gpio-keys to SoM dtsi"
  and followed that in the commit adding the Ixora V1.2.
- Rebased on top of imx/dt, 5.19-rc1

 arch/arm/boot/dts/imx6q-apalis-eval.dts  |  20 +--
 arch/arm/boot/dts/imx6q-apalis-ixora.dts |  15 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi    | 217 ++++++++++++-----------
 3 files changed, 126 insertions(+), 126 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 19aaffd71f3d..fa160a389870 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -32,21 +32,21 @@
 
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
 
@@ -110,11 +110,11 @@
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
 
@@ -163,8 +163,8 @@
 
 /* SD1 */
 &usdhc2 {
+	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2 &pinctrl_sd_cd>;
-	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index a9daf1bb970f..ce39c6a3f640 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -32,28 +32,27 @@
 
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
@@ -115,11 +114,11 @@
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
 
@@ -163,9 +162,9 @@
 
 /* SD1 */
 &usdhc2 {
+	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2 &pinctrl_sd_cd>;
-	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 1144e4d106f0..7c17b91f0965 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -103,18 +103,18 @@
 
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
@@ -139,63 +139,63 @@
 
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
@@ -509,104 +509,105 @@
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
@@ -615,15 +616,15 @@
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
@@ -653,9 +654,9 @@
 
 		stmpe_adc: stmpe_adc {
 			compatible = "st,stmpe-adc";
+			#io-channel-cells = <1>;
 			/* forbid to use ADC channels 3-0 (touch) */
 			st,norequest-mask = <0x0F>;
-			#io-channel-cells = <1>;
 		};
 	};
 };
@@ -793,73 +794,73 @@
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
 
@@ -876,49 +877,49 @@
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
@@ -1011,7 +1012,7 @@
 		>;
 	};
 
-	pinctrl_gpio_bl_on: gpioblon {
+	pinctrl_gpio_bl_on: gpioblongrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_DA13__GPIO3_IO13 0x1b0b0
 		>;
@@ -1156,7 +1157,7 @@
 		>;
 	};
 
-	pinctrl_mmc_cd: gpiommccdgrp {
+	pinctrl_mmc_cd: mmccdgrp {
 		fsl,pins = <
 			 /* MMC1 CD */
 			MX6QDL_PAD_DI0_PIN4__GPIO4_IO20 0x000b0
@@ -1187,35 +1188,35 @@
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
@@ -1235,13 +1236,22 @@
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
@@ -1259,15 +1269,6 @@
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
@@ -1321,7 +1322,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_4bit: usdhc1grp_4bit {
+	pinctrl_usdhc1_4bit: usdhc1-4bitgrp {
 		fsl,pins = <
 			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17071
 			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10071
@@ -1332,7 +1333,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_8bit: usdhc1grp_8bit {
+	pinctrl_usdhc1_8bit: usdhc1-8bitgrp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_D0__SD1_DATA4 0x17071
 			MX6QDL_PAD_NANDF_D1__SD1_DATA5 0x17071
-- 
2.20.1

