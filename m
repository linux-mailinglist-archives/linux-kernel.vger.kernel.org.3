Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A6858455C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiG1SBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiG1SBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:01:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E9970E5F;
        Thu, 28 Jul 2022 11:01:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v3so2315602wrp.0;
        Thu, 28 Jul 2022 11:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugG0AkDTwXcDf7jBLOwWXze+C4ZynRnQwUWaQUR23Ys=;
        b=b/I4rsfa8kUBcAm8R78E29ui4/MMKpjt9jVqTyV2b7BLIwreSmyDNdawoWsmrDfYkS
         dwJPXxX2+UD8F+1GyrfzAQcJ6clzAY2aZDFq0gltcENbLihToJsBtghvbWob9xmnNziU
         C84lj0ZiqVPXAsfruESW8hee7hrNK75gpox3z9Rq6bCmqATenken2lJeAwovcFpK4oyT
         rcTbkxKHuHVVTe2TjQtve8OmGlfMAjeJykPa6b03fMhsA4Xju9+Sn+fNuhCOenuHDXUO
         lCTjgMLDD57X+xYhwOQkUZaz/ODzM5t8tk9nxhEK5EOD4nqBRA0naZ1YDqvR2ff90U0F
         E1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugG0AkDTwXcDf7jBLOwWXze+C4ZynRnQwUWaQUR23Ys=;
        b=LbAq6vLH7zQ3HurhN3ePl2GdH9jnMCOi5qJCUqeNa2cH40LICa4a2MRgS9Pf9C3FSA
         erd4qsMfNhpruPNIodCsr7I4ZMFntEYTt9ETfW/MziiwDTv8KHqg/lvO/lIrpyQCKqh7
         91IkKaZiENpic4h19BGTt5T2fhZgH+LjUqSCt7xqhS1LDBMdbik9FoGkX4TeaMBMe5Zh
         7Q++Ge4xmgE4x1Pu18x7aRE3pTwZNABx3USQl2aLJgiZG/kmt2vrSjCs7F5wHkzCyhWD
         9YrNOmIxIVrEL8cUUrBp8MRnRPlUkm31EuchlCEoE2aWQzyl67GvG/94bSQ1PhN9N+Rb
         phtw==
X-Gm-Message-State: ACgBeo2kxswCRjknY2ycC+sUtBESIP3uRIBPBrfkISDJaAWWMalq5dAf
        uqxd3UVxlsRah6cGzTS3xIM=
X-Google-Smtp-Source: AA6agR6wkLpMPC1SPg1uZ+xP94dDmp9Ft06Wg4y3tbnEre1LHV+fGClqpmw1g49LZRrUuUIlhUobSQ==
X-Received: by 2002:a5d:4dcc:0:b0:21e:e644:6af8 with SMTP id f12-20020a5d4dcc000000b0021ee6446af8mr69181wru.219.1659031304843;
        Thu, 28 Jul 2022 11:01:44 -0700 (PDT)
Received: from localhost.localdomain ([105.235.128.60])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003a2d6f26babsm2154340wms.3.2022.07.28.11.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 11:01:44 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8996-xiaomi-*: Add LEDs
Date:   Thu, 28 Jul 2022 19:01:20 +0100
Message-Id: <20220728180120.97968-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add LEDs found on the Xiaomi MSM8996 devices. The devices share
a status RGB LED mounted on the front, as well as a PWM-driven
IR LED for remote control (sometimes known as an IR blaster).
The Mi Note 2 has an additional pair of white LEDs used as backlights
for the touchkeys driven by the PM8994 LPG block.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  | 54 +++++++++++++++++++
 .../boot/dts/qcom/msm8996-xiaomi-scorpio.dts  | 30 +++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 627649979891..ef9a8aa9c2b9 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -58,6 +58,14 @@ key-dome {
 		};
 	};
 
+	irled {
+		compatible = "pwm-ir-tx";
+		pwms = <&pm8994_lpg 1 1000000>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&irled_default>;
+	};
+
 	reserved-memory {
 		memory@88800000 {
 			reg = <0x0 0x88800000 0x0 0x1400000>;
@@ -297,6 +305,41 @@ &pm8994_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
+&pm8994_lpg {
+	status = "okay";
+
+	qcom,power-source = <1>;
+};
+
+&pmi8994_lpg {
+	status = "okay";
+
+	qcom,power-source = <1>;
+
+	multi-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+
+		led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_RED>;
+		};
+	};
+};
+
 &slpi_pil {
 	status = "okay";
 
@@ -608,6 +651,17 @@ vdd_gfx: s2 {
 };
 
 &pm8994_gpios {
+	irled_default: irled-default {
+		pinconf {
+			pins = "gpio5";
+			function = PMIC_GPIO_FUNC_FUNC1;
+			output-low;
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+			power-source = <PM8994_GPIO_S4>;
+			bias-disable;
+		};
+	};
+
 	wlan_en_default: wlan-en-state {
 		pins = "gpio8";
 		function = PMIC_GPIO_FUNC_NORMAL;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
index 30a9e4bed4af..0b47a659cc38 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
@@ -116,6 +116,25 @@ &mss_pil {
 			"qcom/msm8996/scorpio/modem.mbn";
 };
 
+&pm8994_lpg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&keypad_default>;
+
+	led@3 {
+		reg = <3>;
+		color = <LED_COLOR_ID_WHITE>;
+		function = LED_FUNCTION_KBD_BACKLIGHT;
+		function-enumerator = <1>;
+	};
+
+	led@6 {
+		reg = <6>;
+		color = <LED_COLOR_ID_WHITE>;
+		function = LED_FUNCTION_KBD_BACKLIGHT;
+		function-enumerator = <0>;
+	};
+};
+
 &q6asmdai {
 	dai@0 {
 		reg = <0>;
@@ -258,6 +277,17 @@ &pm8994_gpios {
 		"PMIC_SLB",		/* GPIO_20 */
 		"UIM_BATT_ALARM",	/* GPIO_21 */
 		"NC";			/* GPIO_22 */
+
+	keypad_default: keypad-default {
+		pinconf {
+			pins = "gpio7", "gpio10";
+			function = PMIC_GPIO_FUNC_FUNC1;
+			output-low;
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+			power-source = <PM8994_GPIO_S4>;
+			bias-disable;
+		};
+	};
 };
 
 &pm8994_mpps {
-- 
2.37.1

