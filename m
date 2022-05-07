Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA48551E9A7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245241AbiEGTxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384847AbiEGTxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:53:16 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3602F17072
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 12:49:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bd25-20020a05600c1f1900b0039485220e16so404170wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZAfSc4wE3fwKKrfjIt0E1rVR+ZrbGoTkCLyxGSJ+dxg=;
        b=aBTHXtEYG3w+tAJtRJLXnKinUN5boaz+lOPGbrgfPyeipeh82tde86dIpeP3OE7m21
         HKYgzd8ZiN/AsxeBlq3TdxK8Cl/Yl1LcrDpPSaDlJj6kUPV6O8q0kVi7ajiKJ9oaC2zU
         Q4RNkC5uubCGB67KmBFRTC39jIrVZa7KaTD+bp+hbIFBt+Eg5qu7zofwFS2EqYLZwtgZ
         gsiihtBX/mF9bLCbhie5oX7Bx+MHQr8PL6xQYyYUlLU3GEwu0iCJtYjjEJ1RhOw5Oj6u
         EGSFUTqPnExPPZtXu4YrWQlYEmNesj11TkPKR3k7zXuBejF/ek86VOjdbOSOMti+UlQJ
         9yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZAfSc4wE3fwKKrfjIt0E1rVR+ZrbGoTkCLyxGSJ+dxg=;
        b=Ubz58OuXSA8uVKhZ1Lb6Rw73x/A14LfxPaW11xuFsOCb+VuXzAFZ8a9aQI6I+6NP3e
         51eIso3L76E16y3ZF95TLzOfdVYla/u0TcD7Ht+6PPQbH0R7dlSXFa3fVVGzyc8Gx2/p
         5v0AYLJa+Qak3zEC4V5xZ44buKDx8YfgHjaJ/zxrgJGvlokmeRNKZ8I26ns6vdACBP62
         uccevc3HFyjogrp48U9E9CqoVYOG/D6XtsAavBIX9UwXTkhXIc1vWupuXmJKtXTxM8Mm
         0ZmnZQy98gkRr0tNe9nKGNmBxkFmC4zzTjSdybKyq5MN55qYriKRJAREURYKxe/DW1vE
         LCEw==
X-Gm-Message-State: AOAM532BWQaO2+o1Lam2qYggzMIiE2/MhZBrC/P4wIDnnrCUIDGbM8it
        scFMnPxU0Tqy1qDZ3yOY7bb5Cw==
X-Google-Smtp-Source: ABdhPJxG8mbvkSt+LYrvpdkl0M5MFIni7iKuWMMbiLwEqwgIdHLrIA8j3XigeWlVtftkx4lK3Uy+dw==
X-Received: by 2002:a1c:721a:0:b0:394:7a5:a1f3 with SMTP id n26-20020a1c721a000000b0039407a5a1f3mr15453793wmc.104.1651952965531;
        Sat, 07 May 2022 12:49:25 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c1c0600b003942a244ec4sm8535027wms.9.2022.05.07.12.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 12:49:25 -0700 (PDT)
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
Subject: [PATCH 05/11] arm64: dts: qcom: align PMIC GPIO pin configuration with DT schema
Date:   Sat,  7 May 2022 21:49:07 +0200
Message-Id: <20220507194913.261121-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220507194913.261121-1-krzysztof.kozlowski@linaro.org>
References: <20220507194913.261121-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects PMIC GPIO pin configuration nodes to be named with
'-state' suffix.  Optional children should be either 'pinconf' or
followed with '-pins' suffix.  This fixes dtbs_check warnings like:

  sdm845-xiaomi-beryllium.dtb: gpios@c000: 'vol-up-active' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 10 +--
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts   | 16 ++---
 .../qcom/msm8916-samsung-a2015-common.dtsi    |  2 +-
 .../dts/qcom/msm8994-msft-lumia-octagon.dtsi  | 10 +--
 .../dts/qcom/msm8996-sony-xperia-tone.dtsi    | 70 +++++++++----------
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |  8 +--
 .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   |  2 +-
 .../boot/dts/qcom/msm8998-fxtec-pro1.dts      |  6 +-
 .../dts/qcom/msm8998-oneplus-cheeseburger.dts |  2 +-
 .../boot/dts/qcom/msm8998-oneplus-common.dtsi |  2 +-
 .../msm8998-sony-xperia-yoshino-maple.dts     |  2 +-
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 12 ++--
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi      |  4 +-
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  2 +-
 arch/arm64/boot/dts/qcom/sc7180-idp.dts       |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  4 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  6 +-
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  4 +-
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  2 +-
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |  2 +-
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  2 +-
 22 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 7c1eab605c15..79254841715b 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -773,7 +773,7 @@ &pm8916_gpios {
 		"USB_HUB_RESET_N_PM",
 		"USB_SW_SEL_PM";
 
-	usb_hub_reset_pm: usb-hub-reset-pm {
+	usb_hub_reset_pm: usb-hub-reset-pm-state {
 		pins = "gpio3";
 		function = PMIC_GPIO_FUNC_NORMAL;
 
@@ -781,14 +781,14 @@ usb_hub_reset_pm: usb-hub-reset-pm {
 		output-high;
 	};
 
-	usb_hub_reset_pm_device: usb-hub-reset-pm-device {
+	usb_hub_reset_pm_device: usb-hub-reset-pm-device-state {
 		pins = "gpio3";
 		function = PMIC_GPIO_FUNC_NORMAL;
 
 		output-low;
 	};
 
-	usb_sw_sel_pm: usb-sw-sel-pm {
+	usb_sw_sel_pm: usb-sw-sel-pm-state {
 		pins = "gpio4";
 		function = PMIC_GPIO_FUNC_NORMAL;
 
@@ -797,7 +797,7 @@ usb_sw_sel_pm: usb-sw-sel-pm {
 		output-high;
 	};
 
-	usb_sw_sel_pm_device: usb-sw-sel-pm-device {
+	usb_sw_sel_pm_device: usb-sw-sel-pm-device-state {
 		pins = "gpio4";
 		function = PMIC_GPIO_FUNC_NORMAL;
 
@@ -806,7 +806,7 @@ usb_sw_sel_pm_device: usb-sw-sel-pm-device {
 		output-low;
 	};
 
-	pm8916_gpios_leds: pm8916-gpios-leds {
+	pm8916_gpios_leds: pm8916-gpios-leds-state {
 		pins = "gpio1", "gpio2";
 		function = PMIC_GPIO_FUNC_NORMAL;
 
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 49afbb1a066a..e0e965f4dd2f 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -555,7 +555,7 @@ &pm8994_gpios {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ls_exp_gpio_f &bt_en_gpios>;
 
-	ls_exp_gpio_f: pm8994_gpio5 {
+	ls_exp_gpio_f: pm8994-gpio5-state {
 		pinconf {
 			pins = "gpio5";
 			output-low;
@@ -563,7 +563,7 @@ pinconf {
 		};
 	};
 
-	bt_en_gpios: bt_en_gpios {
+	bt_en_gpios: bt-en-pios-state {
 		pinconf {
 			pins = "gpio19";
 			function = PMIC_GPIO_FUNC_NORMAL;
@@ -574,7 +574,7 @@ pinconf {
 		};
 	};
 
-	wlan_en_gpios: wlan_en_gpios {
+	wlan_en_gpios: wlan-en-gpios-state {
 		pinconf {
 			pins = "gpio8";
 			function = PMIC_GPIO_FUNC_NORMAL;
@@ -585,7 +585,7 @@ pinconf {
 		};
 	};
 
-	audio_mclk: clk_div1 {
+	audio_mclk: clk-div1-state {
 		pinconf {
 			pins = "gpio15";
 			function = "func1";
@@ -593,7 +593,7 @@ pinconf {
 		};
 	};
 
-	volume_up_gpio: pm8996_gpio2 {
+	volume_up_gpio: pm8996-gpio2-state {
 		pinconf {
 			pins = "gpio2";
 			function = "normal";
@@ -605,7 +605,7 @@ pinconf {
 		};
 	};
 
-	divclk4_pin_a: divclk4 {
+	divclk4_pin_a: divclk4-state {
 		pinconf {
 			pins = "gpio18";
 			function = PMIC_GPIO_FUNC_FUNC2;
@@ -615,7 +615,7 @@ pinconf {
 		};
 	};
 
-	usb3_vbus_det_gpio: pm8996_gpio22 {
+	usb3_vbus_det_gpio: pm8996-gpio22-state {
 		pinconf {
 			pins = "gpio22";
 			function = PMIC_GPIO_FUNC_NORMAL;
@@ -671,7 +671,7 @@ &pmi8994_gpios {
 		"NC",
 		"NC";
 
-	usb2_vbus_det_gpio: pmi8996_gpio6 {
+	usb2_vbus_det_gpio: pmi8996-gpio6-state {
 		pinconf {
 			pins = "gpio6";
 			function = PMIC_GPIO_FUNC_NORMAL;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 9b4b7de7cec2..636a3b6ba7dc 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -463,7 +463,7 @@ tsp_en_default: tsp-en-default {
 };
 
 &pm8916_gpios {
-	nfc_clk_req: nfc-clk-req {
+	nfc_clk_req: nfc-clk-req-state {
 		pins = "gpio2";
 		function = "func1";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
index cc038f9b641f..9161b9e1bda1 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
@@ -470,7 +470,7 @@ qca6174_bt: bluetooth {
 };
 
 &pm8994_gpios {
-	bt_en_gpios: bt_en_gpios {
+	bt_en_gpios: bt-en-gpios-state {
 		pinconf {
 			pins = "gpio19";
 			function = PMIC_GPIO_FUNC_NORMAL;
@@ -481,7 +481,7 @@ pinconf {
 		};
 	};
 
-	divclk4_pin_a: divclk4 {
+	divclk4_pin_a: divclk4-state {
 		pinconf {
 			pins = "gpio18";
 			function = PMIC_GPIO_FUNC_FUNC2;
@@ -519,19 +519,19 @@ &pmi8994_gpios {
 	 * TODO: remove once a driver is available
 	 * TODO: add VBUS GPIO 5
 	 */
-	hd3ss460_pol: pol_low {
+	hd3ss460_pol: pol-low-state {
 		pins = "gpio8";
 		drive-strength = <3>;
 		bias-pull-down;
 	};
 
-	hd3ss460_amsel: amsel_high {
+	hd3ss460_amsel: amsel-high-state {
 		pins = "gpio9";
 		drive-strength = <1>;
 		bias-pull-up;
 	};
 
-	hd3ss460_en: en_high {
+	hd3ss460_en: en-high-state {
 		pins = "gpio10";
 		drive-strength = <1>;
 		bias-pull-up;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index ca3c633f5a45..d0cacb7d8c2a 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -247,14 +247,14 @@ &pm8994_gpios {
 	 * probably a reason for it, and just to be on the safe side, we follow suit.
 	 */
 	pm8994_gpios_defaults: pm8994-gpios-default-state {
-		pm8994-gpio1-nc {
+		pm8994-gpio1-nc-pins {
 			pins = "gpio1";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
 			bias-high-impedance;
 		};
 
-		vol-down-n {
+		vol-down-n-pins {
 			pins = "gpio2";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -264,7 +264,7 @@ vol-down-n {
 			power-source = <PM8994_GPIO_S4>;
 		};
 
-		vol-up-n {
+		vol-up-n-pins {
 			pins = "gpio3";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -273,7 +273,7 @@ vol-up-n {
 			power-source = <PM8994_GPIO_S4>;
 		};
 
-		camera-snapshot-n {
+		camera-snapshot-n-pins {
 			pins = "gpio4";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -283,7 +283,7 @@ camera-snapshot-n {
 			power-source = <PM8994_GPIO_S4>;
 		};
 
-		camera-focus-n {
+		camera-focus-n-pins {
 			pins = "gpio5";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -293,7 +293,7 @@ camera-focus-n {
 			power-source = <PM8994_GPIO_S4>;
 		};
 
-		pm8994-gpio6-nc {
+		pm8994-gpio6-nc-pins {
 			pins = "gpio6";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -301,7 +301,7 @@ pm8994-gpio6-nc {
 			power-source = <PM8994_GPIO_VPH>;
 		};
 
-		nfc-download {
+		nfc-download-pins {
 			pins = "gpio7";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			output-low;
@@ -311,7 +311,7 @@ nfc-download {
 			power-source = <PM8994_GPIO_S4>;
 		};
 
-		pm8994-gpio8-nc {
+		pm8994-gpio8-nc-pins {
 			pins = "gpio8";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			output-low;
@@ -321,7 +321,7 @@ pm8994-gpio8-nc {
 			power-source = <PM8994_GPIO_VPH>;
 		};
 
-		pm8994-gpio9-nc {
+		pm8994-gpio9-nc-pins {
 			pins = "gpio9";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			output-high;
@@ -331,7 +331,7 @@ pm8994-gpio9-nc {
 			power-source = <PM8994_GPIO_VPH>;
 		};
 
-		nfc-clock {
+		nfc-clock-pins {
 			pins = "gpio10";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			input-enable;
@@ -341,7 +341,7 @@ nfc-clock {
 			power-source = <PM8994_GPIO_S4>;
 		};
 
-		pm8994-gpio11-nc {
+		pm8994-gpio11-nc-pins {
 			pins = "gpio11";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -349,7 +349,7 @@ pm8994-gpio11-nc {
 			power-source = <PM8994_GPIO_VPH>;
 		};
 
-		pm8994-gpio12-nc {
+		pm8994-gpio12-nc-pins {
 			pins = "gpio12";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -357,7 +357,7 @@ pm8994-gpio12-nc {
 			power-source = <PM8994_GPIO_VPH>;
 		};
 
-		ear-enable {
+		ear-enable-pins {
 			pins = "gpio13";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			output-high;
@@ -367,7 +367,7 @@ ear-enable {
 			power-source = <PM8994_GPIO_S4>;
 		};
 
-		pm8994-gpio14-nc {
+		pm8994-gpio14-nc-pins {
 			pins = "gpio14";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -377,7 +377,7 @@ pm8994-gpio14-nc {
 			power-source = <PM8994_GPIO_VPH>;
 		};
 
-		pm-divclk1-gpio {
+		pm-divclk1-gpio-pins {
 			pins = "gpio15";
 			function = "func1";
 			output-high;
@@ -387,13 +387,13 @@ pm-divclk1-gpio {
 			power-source = <PM8994_GPIO_VPH>;
 		};
 
-		pmi-clk-gpio {
+		pmi-clk-gpio-pins {
 			pins = "gpio16";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
 		};
 
-		pm8994-gpio17-nc {
+		pm8994-gpio17-nc-pins {
 			pins = "gpio17";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -401,7 +401,7 @@ pm8994-gpio17-nc {
 			power-source = <PM8994_GPIO_VPH>;
 		};
 
-		rome-sleep {
+		rome-sleep-pins {
 			pins = "gpio18";
 			function = PMIC_GPIO_FUNC_FUNC2;
 			output-low;
@@ -411,7 +411,7 @@ rome-sleep {
 			power-source = <PM8994_GPIO_S4>;
 		};
 
-		pm8994-gpio19-nc {
+		pm8994-gpio19-nc-pins {
 			pins = "gpio19";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			output-low;
@@ -421,7 +421,7 @@ pm8994-gpio19-nc {
 			power-source = <PM8994_GPIO_VPH>;
 		};
 
-		pm8994-gpio22-nc {
+		pm8994-gpio22-nc-pins {
 			pins = "gpio22";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -446,34 +446,34 @@ &pm8994_mpps {
 		"RF_ID";
 
 	pm8994_mpps_defaults: pm8994-mpps-default-state {
-		lcd-id_adc-mpp {
+		lcd-id_adc-mpp-pins {
 			pins = "mpp2";
 			function = "analog";
 			input-enable;
 			qcom,amux-route = <PMIC_MPP_AMUX_ROUTE_CH6>;
 		};
 
-		pm-mpp4-nc {
+		pm-mpp4-nc-pins {
 			pins = "mpp4";
 			function = "digital";
 			bias-high-impedance;
 			power-source = <PM8994_GPIO_VPH>;
 		};
 
-		flash-therm-mpp {
+		flash-therm-mpp-pins {
 			pins = "mpp5";
 			function = "analog";
 			input-enable;
 			qcom,amux-route = <PMIC_MPP_AMUX_ROUTE_CH5>;
 		};
 
-		mpp6-nc {
+		mpp6-nc-pins {
 			pins = "mpp6";
 			function = "digital";
 			bias-high-impedance;
 		};
 
-		rf-id-mpp {
+		rf-id-mpp-pins {
 			pins = "mpp8";
 			function = "analog";
 			input-enable;
@@ -504,7 +504,7 @@ &pmi8994_gpios {
 		"NC";
 
 	pmi8994_gpios_defaults: pmi8994-gpios-default-state {
-		vib-ldo-en-gpio {
+		vib-ldo-en-gpio-pins {
 			pins = "gpio1";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -513,7 +513,7 @@ vib-ldo-en-gpio {
 			power-source = <PM8994_GPIO_S4>;
 		};
 
-		pmi-gpio2-nc {
+		pmi-gpio2-nc-pins {
 			pins = "gpio2";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -523,7 +523,7 @@ pmi-gpio2-nc {
 			power-source = <PM8994_GPIO_VPH>;
 		};
 
-		pmi-gpio3-nc {
+		pmi-gpio3-nc-pins {
 			pins = "gpio3";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -533,7 +533,7 @@ pmi-gpio3-nc {
 			power-source = <PM8994_GPIO_VPH>;
 		};
 
-		pmi-gpio4-nc {
+		pmi-gpio4-nc-pins {
 			pins = "gpio4";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -542,7 +542,7 @@ pmi-gpio4-nc {
 			power-source = <PM8994_GPIO_S4>;
 		};
 
-		pmi-gpio5-nc {
+		pmi-gpio5-nc-pins {
 			pins = "gpio5";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -551,7 +551,7 @@ pmi-gpio5-nc {
 			power-source = <PM8994_GPIO_S4>;
 		};
 
-		pmi-gpio6-nc {
+		pmi-gpio6-nc-pins {
 			pins = "gpio6";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -560,7 +560,7 @@ pmi-gpio6-nc {
 			power-source = <PM8994_GPIO_S4>;
 		};
 
-		pmi-gpio7-nc {
+		pmi-gpio7-nc-pins {
 			pins = "gpio7";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -569,7 +569,7 @@ pmi-gpio7-nc {
 			power-source = <PM8994_GPIO_S4>;
 		};
 
-		pmi-gpio8-nc {
+		pmi-gpio8-nc-pins {
 			pins = "gpio8";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
@@ -578,13 +578,13 @@ pmi-gpio8-nc {
 			power-source = <PM8994_GPIO_S4>;
 		};
 
-		usb-switch-sel {
+		usb-switch-sel-pins {
 			pins = "gpio9";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			drive-push-pull;
 		};
 
-		pmi-gpio10-nc {
+		pmi-gpio10-nc-pins {
 			pins = "gpio10";
 			function = PMIC_GPIO_FUNC_NORMAL;
 			output-low;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index a7090befc16f..259d2fcc6e7e 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -608,7 +608,7 @@ vdd_gfx: s2 {
 };
 
 &pm8994_gpios {
-	wlan_en_default: wlan-en-default {
+	wlan_en_default: wlan-en-state {
 		pins = "gpio8";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		output-low;
@@ -617,7 +617,7 @@ wlan_en_default: wlan-en-default {
 		bias-disable;
 	};
 
-	rome_enable_default: rome-enable-default {
+	rome_enable_default: rome-enable-state {
 		pins = "gpio9";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		output-high;
@@ -625,7 +625,7 @@ rome_enable_default: rome-enable-default {
 		power-source = <PM8994_GPIO_VPH>;
 	};
 
-	divclk1_default: divclk1_default {
+	divclk1_default: divclk1-state {
 		pins = "gpio15";
 		function = PMIC_GPIO_FUNC_FUNC1;
 		bias-disable;
@@ -633,7 +633,7 @@ divclk1_default: divclk1_default {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
 	};
 
-	divclk4_pin_a: divclk4 {
+	divclk4_pin_a: divclk4-state {
 		pins = "gpio18";
 		function = PMIC_GPIO_FUNC_FUNC2;
 		bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index 22978d06f85b..ec68c03868db 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -257,7 +257,7 @@ &pm8994_gpios {
 		"UIM_BATT_ALARM",	/* GPIO_21 */
 		"NC";			/* GPIO_22 */
 
-	divclk2_pin_a: divclk2 {
+	divclk2_pin_a: divclk2-state {
 		pins = "gpio16";
 		function = PMIC_GPIO_FUNC_FUNC2;
 		bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
index dc5b9b274df3..71566ecf1311 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
@@ -214,7 +214,7 @@ &mmss_smmu {
 };
 
 &pm8998_gpio {
-	vol_up_pin_a: vol-up-active {
+	vol_up_pin_a: vol-up-active-state {
 		pins = "gpio6";
 		function = "normal";
 		bias-pull-up;
@@ -222,7 +222,7 @@ vol_up_pin_a: vol-up-active {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
 
-	cam_focus_pin_a: cam-focus-btn-active {
+	cam_focus_pin_a: cam-focus-btn-active-state {
 		pins = "gpio7";
 		function = "normal";
 		bias-pull-up;
@@ -230,7 +230,7 @@ cam_focus_pin_a: cam-focus-btn-active {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
 
-	cam_snapshot_pin_a: cam-snapshot-btn-active {
+	cam_snapshot_pin_a: cam-snapshot-btn-active-state {
 		pins = "gpio8";
 		function = "normal";
 		bias-pull-up;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
index 9563eb62db88..ef2a88a64d32 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
@@ -32,7 +32,7 @@ button-backlight {
 };
 
 &pmi8998_gpio {
-	button_backlight_default: button-backlight-default {
+	button_backlight_default: button-backlight-state {
 		pinconf {
 			pins = "gpio5";
 			function = "normal";
diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
index dbaea360bffc..e49eafee0ece 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
@@ -263,7 +263,7 @@ pm8005_s1: s1 { /* VDD_GFX supply */
 };
 
 &pm8998_gpio {
-	vol_keys_default: vol-keys-default {
+	vol_keys_default: vol-keys-state {
 		pinconf {
 			pins = "gpio5", "gpio6";
 			function = "normal";
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
index 978495a8a6b9..20fe0394a3c1 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
@@ -38,7 +38,7 @@ &lab {
 };
 
 &pmi8998_gpio {
-	disp_dvdd_en: disp-dvdd-en-active {
+	disp_dvdd_en: disp-dvdd-en-active-state {
 		pins = "gpio10";
 		function = "normal";
 		bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index 47488a1aecae..3e85e690605c 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -295,7 +295,7 @@ pm8005_s1: s1 {
 };
 
 &pm8998_gpio {
-	vol_down_pin_a: vol-down-active {
+	vol_down_pin_a: vol-down-active-state {
 		pins = "gpio5";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-pull-up;
@@ -303,7 +303,7 @@ vol_down_pin_a: vol-down-active {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
 
-	cam_focus_pin_a: cam-focus-btn-active {
+	cam_focus_pin_a: cam-focus-btn-active-state {
 		pins = "gpio7";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-pull-up;
@@ -311,7 +311,7 @@ cam_focus_pin_a: cam-focus-btn-active {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
 
-	cam_snapshot_pin_a: cam-snapshot-btn-active {
+	cam_snapshot_pin_a: cam-snapshot-btn-active-state {
 		pins = "gpio8";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-pull-up;
@@ -319,7 +319,7 @@ cam_snapshot_pin_a: cam-snapshot-btn-active {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
 
-	audio_mclk_pin: audio-mclk-pin-active {
+	audio_mclk_pin: audio-mclk-pin-active-state {
 		pins = "gpio13";
 		function = "func2";
 		power-source = <0>;
@@ -327,7 +327,7 @@ audio_mclk_pin: audio-mclk-pin-active {
 };
 
 &pmi8998_gpio {
-	cam_vio_default: cam-vio-active {
+	cam_vio_default: cam-vio-active-state {
 		pins = "gpio1";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-disable;
@@ -337,7 +337,7 @@ cam_vio_default: cam-vio-active {
 		power-source = <1>;
 	};
 
-	vib_default: vib-en {
+	vib_default: vib-en-state {
 		pins = "gpio5";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 2f3104a84417..1721ebe5759b 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -304,7 +304,7 @@ pinconf {
 };
 
 &pms405_gpios {
-	usb_vbus_boost_pin: usb-vbus-boost-pin {
+	usb_vbus_boost_pin: usb-vbus-boost-state {
 		pinconf {
 			pins = "gpio3";
 			function = PMIC_GPIO_FUNC_NORMAL;
@@ -312,7 +312,7 @@ pinconf {
 			power-source = <1>;
 		};
 	};
-	usb3_vbus_pin: usb3-vbus-pin {
+	usb3_vbus_pin: usb3-vbus-state {
 		pinconf {
 			pins = "gpio12";
 			function = PMIC_GPIO_FUNC_NORMAL;
diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 0e63f707b911..9549341f98fb 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -796,7 +796,7 @@ &pm8150l_gpios {
 		"NC",
 		"PM3003A_MODE";
 
-	lt9611_rst_pin: lt9611-rst-pin {
+	lt9611_rst_pin: lt9611-rst-state {
 		pins = "gpio5";
 		function = "normal";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index acdb36f4479f..33ada24ec917 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -467,7 +467,7 @@ wifi-firmware {
 /* PINCTRL - additions to nodes defined in sc7180.dtsi */
 
 &pm6150l_gpio {
-	disp_pins: disp-pins {
+	disp_pins: disp-state {
 		pinconf {
 			pins = "gpio3";
 			function = PMIC_GPIO_FUNC_FUNC1;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 6a14259b93c4..e87e53e115cc 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -368,7 +368,7 @@ &dp_hot_plug_det {
 };
 
 &pm7325_gpios {
-	key_vol_up_default: key-vol-up-default {
+	key_vol_up_default: key-vol-up-state {
 		pins = "gpio6";
 		function = "normal";
 		input-enable;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index b833ba1e8f4a..1db90bd9a79f 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -457,7 +457,7 @@ &sdc1_rclk {
  */
 
 &pm8350c_gpios {
-	pmic_edp_bl_en: pmic-edp-bl-en {
+	pmic_edp_bl_en: pmic-edp-bl-en-state {
 		pins = "gpio7";
 		function = "normal";
 		bias-disable;
@@ -467,7 +467,7 @@ pmic_edp_bl_en: pmic-edp-bl-en {
 		output-low;
 	};
 
-	pmic_edp_bl_pwm: pmic-edp-bl-pwm {
+	pmic_edp_bl_pwm: pmic-edp-bl-pwm-state {
 		pins = "gpio8";
 		function = "func1";
 		bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 194ebeb3259c..96a434245ed9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -569,7 +569,7 @@ &pm8998_gpio {
 		"OPTION2",
 		"PM845_SLB";
 
-	cam0_dvdd_1v2_en_default: cam0-dvdd-1v2-en {
+	cam0_dvdd_1v2_en_default: cam0-dvdd-1v2-en-state {
 		pins = "gpio12";
 		function = "normal";
 
@@ -578,7 +578,7 @@ cam0_dvdd_1v2_en_default: cam0-dvdd-1v2-en {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
 	};
 
-	cam0_avdd_2v8_en_default: cam0-avdd-2v8-en {
+	cam0_avdd_2v8_en_default: cam0-avdd-2v8-en-state {
 		pins = "gpio10";
 		function = "normal";
 
@@ -587,7 +587,7 @@ cam0_avdd_2v8_en_default: cam0-avdd-2v8-en {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
 	};
 
-	vol_up_pin_a: vol-up-active {
+	vol_up_pin_a: vol-up-active-state {
 		pins = "gpio6";
 		function = "normal";
 		input-enable;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 07b729f9fec5..c9d05e94040c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -440,7 +440,7 @@ &mss_pil {
 };
 
 &pm8998_gpio {
-	volume_down_gpio: pm8998_gpio5 {
+	volume_down_gpio: pm8998-gpio5-state {
 		pinconf {
 			pins = "gpio5";
 			function = "normal";
@@ -450,7 +450,7 @@ pinconf {
 		};
 	};
 
-	volume_up_gpio: pm8998_gpio6 {
+	volume_up_gpio: pm8998-gpio6-state {
 		pinconf {
 			pins = "gpio6";
 			function = "normal";
diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 103cc40816fd..100702883987 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -508,7 +508,7 @@ &mss_pil {
 };
 
 &pm8998_gpio {
-	volume_up_gpio: pm8998_gpio6 {
+	volume_up_gpio: pm8998-gpio6-state {
 		pinconf {
 			pins = "gpio6";
 			function = "normal";
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index d88dc07205f7..b5a6cdccec67 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -306,7 +306,7 @@ &ipa {
 };
 
 &pm8998_gpio {
-	vol_up_pin_a: vol-up-active {
+	vol_up_pin_a: vol-up-active-state {
 		pins = "gpio6";
 		function = "normal";
 		input-enable;
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 61925216f5e3..14cc2c87a96b 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -339,7 +339,7 @@ &pm6150l_wled {
 };
 
 &pm6350_gpios {
-	gpio_keys_pin: gpio-keys-pin {
+	gpio_keys_pin: gpio-keys-state {
 		pins = "gpio2";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-pull-up;
-- 
2.32.0

