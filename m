Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B629851E9C1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447027AbiEGTy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446951AbiEGTxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:53:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98224183A4
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 12:49:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so6207057wmz.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 12:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wyj6xD82FTxOXwZIvygzQEnopa8dgcXcHz1VsA1BLaA=;
        b=AU3qwGOaefZK19Rt4OSE0U94Wn5V9nPcn0mMgt69iMCb7rWF1WXFZIVFiQB5tlWbDJ
         gBjsDME+ppAfBdVlMf1kka2OLjPUaNCjbtzwMXZxyieKlJHwvhz1nMWYYqPyMXTOy7fo
         eZENeZCqxg9j2Wf9hpfyFvedrUEhXXS6+qNph2sMoMdgQAUzIglzieyguwjl+qHxQAvG
         t5PSzx+m043JkyxmJ44unLd32rWENTezg1EQp1VI1wi7SrcCttgh0EHRAGbpK6euR1Cz
         wJu2/mh2dZYUUwNBj0mOSvlsOJGSueKHDsFLmtMyGdjH2BkYRb4GhqzPS35xcgrd7Sze
         HDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wyj6xD82FTxOXwZIvygzQEnopa8dgcXcHz1VsA1BLaA=;
        b=dHDiDwaBmxyVsGSdd9AYRcWdg+erMCCKKAoTzZef5USVDh9z4GxDZ2aKGDeJ6HnMyi
         ZitFiVXrwMunmCW606bcEHZu69vKmR0dhnMUHGOlx920t1Vqt4BtZVmdeuPVSnfrI0Pj
         48mpke0mQNc/7ekIqFOJWfc+B0YiUpfKgJ+/qDVZwWDmOXmFDGNYHYvhCjVcTUsTle5d
         0um5b10ZUYstIJfExN0iFHaw3sWyCbUM6c8eaudLvgUun+lQ7lYf+VArgNCTlVfXA/r9
         P2+2Zg/SV8Q0vsQBVthz1IVyvdpaVeSYHeGjuyIbjHKweI4isAGzKjeVnegjwq9OXrFJ
         stRg==
X-Gm-Message-State: AOAM533OGAlfXzWtS9GsU8as8i4KPq9DD1SCWlz7Ke74n9jWgp7wVSXu
        mGxw1jWeZWZm8Dz2fwmtnGyjvg==
X-Google-Smtp-Source: ABdhPJxDiEKUM1rQ4NYkbTGHFDGJCYPC6DME308pYP4y5Wrw0170aPiTWHv5vKf43ZVrMTqjbfKUUg==
X-Received: by 2002:a05:600c:3849:b0:394:5d8c:2e7f with SMTP id s9-20020a05600c384900b003945d8c2e7fmr9366455wmr.12.1651952970158;
        Sat, 07 May 2022 12:49:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c1c0600b003942a244ec4sm8535027wms.9.2022.05.07.12.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 12:49:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Luca Weiss <luca@z3ntu.xyz>, David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 09/11] ARM: dts: qcom: align PMIC GPIO pin configuration with DT schema
Date:   Sat,  7 May 2022 21:49:11 +0200
Message-Id: <20220507194913.261121-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220507194913.261121-1-krzysztof.kozlowski@linaro.org>
References: <20220507194913.261121-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects PMIC GPIO pin configuration nodes to be named with
'-state' suffix.  Optional children should be either 'pinconf' or
followed with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../arm/boot/dts/qcom-apq8060-dragonboard.dts | 20 +++++++++----------
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts   |  4 ++--
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts    |  8 ++++----
 .../qcom-apq8064-sony-xperia-lagan-yuga.dts   |  2 +-
 arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi    |  2 +-
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    |  8 ++++----
 .../dts/qcom-msm8974-sony-xperia-rhine.dtsi   |  2 +-
 .../dts/qcom-msm8974pro-fairphone-fp2.dts     |  2 +-
 .../boot/dts/qcom-msm8974pro-samsung-klte.dts | 14 ++++++-------
 ...-msm8974pro-sony-xperia-shinano-castor.dts | 10 +++++-----
 arch/arm/boot/dts/qcom-pm8941.dtsi            |  2 +-
 11 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 138d6478ac84..a104acbfee05 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -273,7 +273,7 @@ MATRIX_KEY(4, 3, KEY_KBDILLUMTOGGLE)
 				};
 
 				gpio@150 {
-					dragon_ethernet_gpios: ethernet-gpios {
+					dragon_ethernet_gpios: ethernet-state {
 						pinconf {
 							pins = "gpio7";
 							function = "normal";
@@ -282,7 +282,7 @@ pinconf {
 							power-source = <PM8058_GPIO_S3>;
 						};
 					};
-					dragon_bmp085_gpios: bmp085-gpios {
+					dragon_bmp085_gpios: bmp085-state {
 						pinconf {
 							pins = "gpio16";
 							function = "normal";
@@ -291,7 +291,7 @@ pinconf {
 							power-source = <PM8058_GPIO_S3>;
 						};
 					};
-					dragon_mpu3050_gpios: mpu3050-gpios {
+					dragon_mpu3050_gpios: mpu3050-state {
 						pinconf {
 							pins = "gpio17";
 							function = "normal";
@@ -300,7 +300,7 @@ pinconf {
 							power-source = <PM8058_GPIO_S3>;
 						};
 					};
-					dragon_sdcc3_gpios: sdcc3-gpios {
+					dragon_sdcc3_gpios: sdcc3-state {
 						pinconf {
 							pins = "gpio22";
 							function = "normal";
@@ -309,7 +309,7 @@ pinconf {
 							power-source = <PM8058_GPIO_S3>;
 						};
 					};
-					dragon_sdcc5_gpios: sdcc5-gpios {
+					dragon_sdcc5_gpios: sdcc5-state {
 						pinconf {
 							pins = "gpio26";
 							function = "normal";
@@ -319,7 +319,7 @@ pinconf {
 							power-source = <PM8058_GPIO_S3>;
 						};
 					};
-					dragon_ak8975_gpios: ak8975-gpios {
+					dragon_ak8975_gpios: ak8975-state {
 						pinconf {
 							pins = "gpio33";
 							function = "normal";
@@ -328,9 +328,9 @@ pinconf {
 							power-source = <PM8058_GPIO_S3>;
 						};
 					};
-					dragon_cm3605_gpios: cm3605-gpios {
+					dragon_cm3605_gpios: cm3605-state {
 						/* Pin 34 connected to the proxy IRQ */
-						pinconf_gpio34 {
+						gpio34-pins {
 							pins = "gpio34";
 							function = "normal";
 							input-enable;
@@ -338,7 +338,7 @@ pinconf_gpio34 {
 							power-source = <PM8058_GPIO_S3>;
 						};
 						/* Pin 35 connected to ASET */
-						pinconf_gpio35 {
+						gpio35-pins {
 							pins = "gpio35";
 							function = "normal";
 							output-high;
@@ -346,7 +346,7 @@ pinconf_gpio35 {
 							power-source = <PM8058_GPIO_S3>;
 						};
 					};
-					dragon_veth_gpios: veth-gpios {
+					dragon_veth_gpios: veth-state {
 						pinconf {
 							pins = "gpio40";
 							function = "normal";
diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index e068a8d0adf0..7e57a0750320 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -196,8 +196,8 @@ v3p3_fixed: v3p3 {
 		qcom,ssbi@500000 {
 			pmic@0 {
 				gpio@150 {
-					wlan_default_gpios: wlan-gpios {
-						pios {
+					wlan_default_gpios: wlan-gpios-state {
+						pinconf {
 							pins = "gpio43";
 							function = "normal";
 							bias-disable;
diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 2638b380be20..77e841243646 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -291,8 +291,8 @@ pci@1b500000 {
 		qcom,ssbi@500000 {
 			pmic@0 {
 				gpio@150 {
-					wlan_default_gpios: wlan-gpios {
-						pios {
+					wlan_default_gpios: wlan-gpios-state {
+						pinconf {
 							pins = "gpio43";
 							function = "normal";
 							bias-disable;
@@ -300,8 +300,8 @@ pios {
 						};
 					};
 
-					notify_led: nled {
-						pios {
+					notify_led: nled-state {
+						pinconf {
 							pins = "gpio18";
 							function = "normal";
 							bias-disable;
diff --git a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts
index 0cee62c7b8b0..3cf79cc5b539 100644
--- a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts
@@ -334,7 +334,7 @@ ncp {
 		qcom,ssbi@500000 {
 			pmic@0 {
 				gpio@150 {
-					gpio_keys_pin_a: gpio-keys-pin-active {
+					gpio_keys_pin_a: gpio-keys-active-state {
 						pins = "gpio3", "gpio4", "gpio29", "gpio35";
 						function = "normal";
 
diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi b/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
index 10ad929759ed..49de1821ac3a 100644
--- a/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
@@ -114,7 +114,7 @@ pins {
 };
 
 &pmicgpio {
-	usb_vbus_5v_pins: usb_vbus_5v_pins {
+	usb_vbus_5v_pins: usb-vbus-5v-state {
 		pins = "gpio4";
 		function = "normal";
 		output-high;
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 9493886a5c0d..4d8fc8689d24 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -272,7 +272,7 @@ phy@a {
 };
 
 &pm8941_gpios {
-	gpio_keys_pin_a: gpio-keys-active {
+	gpio_keys_pin_a: gpio-keys-active-state {
 		pins = "gpio2", "gpio3";
 		function = "normal";
 
@@ -280,7 +280,7 @@ gpio_keys_pin_a: gpio-keys-active {
 		power-source = <PM8941_GPIO_S3>;
 	};
 
-	fuelgauge_pin: fuelgauge-int {
+	fuelgauge_pin: fuelgauge-int-state {
 		pins = "gpio9";
 		function = "normal";
 
@@ -289,7 +289,7 @@ fuelgauge_pin: fuelgauge-int {
 		power-source = <PM8941_GPIO_S3>;
 	};
 
-	wlan_sleep_clk_pin: wl-sleep-clk {
+	wlan_sleep_clk_pin: wl-sleep-clk-state {
 		pins = "gpio16";
 		function = "func2";
 
@@ -297,7 +297,7 @@ wlan_sleep_clk_pin: wl-sleep-clk {
 		power-source = <PM8941_GPIO_S3>;
 	};
 
-	wlan_regulator_pin: wl-reg-active {
+	wlan_regulator_pin: wl-reg-active-state {
 		pins = "gpio17";
 		function = "normal";
 
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index 1d21de46f85c..a4fec2d0d158 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -163,7 +163,7 @@ &pm8941_coincell {
 };
 
 &pm8941_gpios {
-	gpio_keys_pin_a: gpio-keys-active {
+	gpio_keys_pin_a: gpio-keys-active-state {
 		pins = "gpio2", "gpio3", "gpio4", "gpio5";
 		function = "normal";
 
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
index 26fc2002e5c3..7bfea4a96896 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
@@ -95,7 +95,7 @@ phy@a {
 };
 
 &pm8941_gpios {
-	gpio_keys_pin_a: gpio-keys-active {
+	gpio_keys_pin_a: gpio-keys-active-state {
 		pins = "gpio1", "gpio2", "gpio5";
 		function = "normal";
 
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
index d6b2300a8223..90f7a399f40b 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
@@ -398,7 +398,7 @@ phy@a {
 };
 
 &pma8084_gpios {
-	gpio_keys_pin_a: gpio-keys-active {
+	gpio_keys_pin_a: gpio-keys-active-state {
 		pins = "gpio2", "gpio3", "gpio5";
 		function = "normal";
 
@@ -406,7 +406,7 @@ gpio_keys_pin_a: gpio-keys-active {
 		power-source = <PMA8084_GPIO_S4>;
 	};
 
-	touchkey_pin: touchkey-int-pin {
+	touchkey_pin: touchkey-int-state {
 		pins = "gpio6";
 		function = "normal";
 		bias-disable;
@@ -414,7 +414,7 @@ touchkey_pin: touchkey-int-pin {
 		power-source = <PMA8084_GPIO_S4>;
 	};
 
-	touch_pin: touchscreen-int-pin {
+	touch_pin: touchscreen-int-state {
 		pins = "gpio8";
 		function = "normal";
 		bias-disable;
@@ -422,7 +422,7 @@ touch_pin: touchscreen-int-pin {
 		power-source = <PMA8084_GPIO_S4>;
 	};
 
-	panel_en_pin: panel-en-pin {
+	panel_en_pin: panel-en-state {
 		pins = "gpio14";
 		function = "normal";
 		bias-pull-up;
@@ -430,7 +430,7 @@ panel_en_pin: panel-en-pin {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
 	};
 
-	wlan_sleep_clk_pin: wlan-sleep-clk-pin {
+	wlan_sleep_clk_pin: wlan-sleep-clk-state {
 		pins = "gpio16";
 		function = "func2";
 
@@ -439,7 +439,7 @@ wlan_sleep_clk_pin: wlan-sleep-clk-pin {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
 	};
 
-	panel_rst_pin: panel-rst-pin {
+	panel_rst_pin: panel-rst-state {
 		pins = "gpio17";
 		function = "normal";
 		bias-disable;
@@ -447,7 +447,7 @@ panel_rst_pin: panel-rst-pin {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
 	};
 
-	fuelgauge_pin: fuelgauge-int-pin {
+	fuelgauge_pin: fuelgauge-int-state {
 		pins = "gpio21";
 		function = "normal";
 		bias-disable;
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 9bd8faea61a5..e9bcd3b4ebb3 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -244,7 +244,7 @@ &pm8941_coincell {
 };
 
 &pm8941_gpios {
-	gpio_keys_pin_a: gpio-keys-active {
+	gpio_keys_pin_a: gpio-keys-active-state {
 		pins = "gpio2", "gpio5";
 		function = "normal";
 
@@ -252,7 +252,7 @@ gpio_keys_pin_a: gpio-keys-active {
 		power-source = <PM8941_GPIO_S3>;
 	};
 
-	bt_reg_on_pin: bt-reg-on {
+	bt_reg_on_pin: bt-reg-on-state {
 		pins = "gpio16";
 		function = "normal";
 
@@ -260,7 +260,7 @@ bt_reg_on_pin: bt-reg-on {
 		power-source = <PM8941_GPIO_S3>;
 	};
 
-	wlan_sleep_clk_pin: wl-sleep-clk {
+	wlan_sleep_clk_pin: wl-sleep-clk-state {
 		pins = "gpio17";
 		function = "func2";
 
@@ -268,7 +268,7 @@ wlan_sleep_clk_pin: wl-sleep-clk {
 		power-source = <PM8941_GPIO_S3>;
 	};
 
-	wlan_regulator_pin: wl-reg-active {
+	wlan_regulator_pin: wl-reg-active-state {
 		pins = "gpio18";
 		function = "normal";
 
@@ -276,7 +276,7 @@ wlan_regulator_pin: wl-reg-active {
 		power-source = <PM8941_GPIO_S3>;
 	};
 
-	lcd_dcdc_en_pin_a: lcd-dcdc-en-active {
+	lcd_dcdc_en_pin_a: lcd-dcdc-en-active-state {
 		pins = "gpio20";
 		function = "normal";
 
diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index cdd2bdb77b32..a68634397938 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -68,7 +68,7 @@ pm8941_gpios: gpios@c000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-			boost_bypass_n_pin: boost-bypass {
+			boost_bypass_n_pin: boost-bypass-state {
 				pins = "gpio21";
 				function = "normal";
 			};
-- 
2.32.0

