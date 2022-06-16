Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D6654D672
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350912AbiFPAzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350827AbiFPAyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:54:49 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1699C580EC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:32 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h192so12918545pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VIMCTR1frvgpFCy/vc70wP9R+xYc4n9eebnCO6KFjK8=;
        b=y+Bxfq08WOaYThdVhgYolyJaWlaGxLy4qMMds1bdhBPTxUCc9xLXz5xeMIden2601Y
         3HtiVFzLvAPtOnMIlTNzfg9DKJZMSDNdBdDu0YlKuHqSNYPbYRybUPzhL3/z8KjiRDrn
         56ACr/ghc2YFUbs4Eht7vrTfnRk+qTw5O4Jd7NmYZTKrET2qfxT/xb8ieSzSOsIbsGlO
         VP+aKEDK3jTaX4qKe9x9b3/MANx8QkHcKhvHNDF16G7wTSts97CrPiXaSyCPwrCIQHp7
         6h8iMeUHILVdnkCwhpFm+7VNKD/+A6G9vmZD6RHVBuWhIWm7Ks44zpolIrjh5OmoDWra
         r5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VIMCTR1frvgpFCy/vc70wP9R+xYc4n9eebnCO6KFjK8=;
        b=c0H+nLwh6CoBztNqSFVCYvXns8YkufuW7Kofk2pa7/+pxfP/pvIEns5ti01EcnuyiC
         +tA40Lh98I8IMkXAUhsoAE2y6pezOGPxF5DTRk9Uo7/JeS9KCUy7Qro4fdhG6xoKJ5eI
         G8EG+DUY9AKsxhlnDce1cpFlRvWCrqCWavYJh98o7ZDFRquc2RwiI8s7nKCWKPv5nkiT
         b5Wg13vZbdCB7IoA9zw1ullBYPagylGxS0SVdf0o/NYt6xBX9iPQ6Tfuj8wXuRdyZ2xw
         +07kn7d/yiaN+lDlAclq0deDLManA9v41x7tj2nq0qVORoOVMMW7DyPKSOOlyh/SttF0
         Vngw==
X-Gm-Message-State: AJIora+NmyV8sPSU8+Qf7BsHI0V/vkjizahrIe9T41wkmGj3Yx6FEOyZ
        usqZZvY2gzFJkRK0cIrq2ljPgw==
X-Google-Smtp-Source: AGRyM1vwOc/dWt2kPEMzNVwZ2dJyFCYvWdzs2BG+Ys7RzoWigxYjI1adQN123ziNlVcdY4Do7Q92Pw==
X-Received: by 2002:a63:c5:0:b0:3fe:26a0:7abe with SMTP id 188-20020a6300c5000000b003fe26a07abemr2258759pga.152.1655340871718;
        Wed, 15 Jun 2022 17:54:31 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 25/40] ARM: dts: qcom: align gpio-key node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:18 -0700
Message-Id: <20220616005333.18491-25-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts        | 4 ++--
 arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts | 8 ++++----
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi             | 2 +-
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts                 | 4 ++--
 arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi                  | 6 +++---
 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts  | 4 ++--
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi     | 8 ++++----
 arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts       | 6 +++---
 arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts        | 6 +++---
 .../dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts    | 8 ++++----
 10 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
index ca9f73528196..549f3ef53b2d 100644
--- a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
@@ -44,12 +44,12 @@ ext_3p3v: regulator-fixed@1 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		volume_up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&pm8921_gpio 4 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
-		volume_down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&pm8921_gpio 38 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts
index 0cee62c7b8b0..13826462fee5 100644
--- a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts
@@ -23,28 +23,28 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_pin_a>;
 
-		camera-focus {
+		key-camera-focus {
 			label = "camera_focus";
 			gpios = <&pm8921_gpio 3 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
 			linux,code = <KEY_CAMERA_FOCUS>;
 		};
 
-		camera-snapshot {
+		key-camera-snapshot {
 			label = "camera_snapshot";
 			gpios = <&pm8921_gpio 4 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
 			linux,code = <KEY_CAMERA>;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "volume_down";
 			gpios = <&pm8921_gpio 29 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "volume_up";
 			gpios = <&pm8921_gpio 35 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
index 1f3b1ce82108..af9a26fb5d4a 100644
--- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
@@ -11,7 +11,7 @@ / {
 	keys {
 		compatible = "gpio-keys";
 
-		reset {
+		key-reset {
 			label = "reset";
 			gpios = <&tlmm 63 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_RESTART>;
diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
index 596d129d4a95..760151b52add 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
@@ -187,12 +187,12 @@ partition@0 {
 			};
 		};
 
-		gpio_keys {
+		gpio-keys {
 			compatible = "gpio-keys";
 			pinctrl-0 = <&buttons_pins>;
 			pinctrl-names = "default";
 
-			button@1 {
+			button {
 				label = "reset";
 				linux,code = <KEY_RESTART>;
 				gpios = <&qcom_pinmux 66 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
index 5c802b99e15f..ccebb7d56113 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
@@ -65,19 +65,19 @@ sata@29000000 {
 			status = "okay";
 		};
 
-		gpio_keys {
+		gpio-keys {
 			compatible = "gpio-keys";
 			pinctrl-0 = <&buttons_pins>;
 			pinctrl-names = "default";
 
-			button@1 {
+			button-1 {
 				label = "reset";
 				linux,code = <KEY_RESTART>;
 				gpios = <&qcom_pinmux 54 GPIO_ACTIVE_LOW>;
 				linux,input-type = <1>;
 				debounce-interval = <60>;
 			};
-			button@2 {
+			button-2 {
 				label = "wps";
 				linux,code = <KEY_WPS_BUTTON>;
 				gpios = <&qcom_pinmux 65 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 9493886a5c0d..72e82033252e 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -24,14 +24,14 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_pin_a>;
 
-		volume-up {
+		key-volume-up {
 			label = "volume_up";
 			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "volume_down";
 			gpios = <&pm8941_gpios 3 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index 1d21de46f85c..e0152f118495 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -20,28 +20,28 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_pin_a>;
 
-		volume-down {
+		key-volume-down {
 			label = "volume_down";
 			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
-		camera-snapshot {
+		key-camera-snapshot {
 			label = "camera_snapshot";
 			gpios = <&pm8941_gpios 3 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
 			linux,code = <KEY_CAMERA>;
 		};
 
-		camera-focus {
+		key-camera-focus {
 			label = "camera_focus";
 			gpios = <&pm8941_gpios 4 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
 			linux,code = <KEY_CAMERA_FOCUS>;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "volume_up";
 			gpios = <&pm8941_gpios 5 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
index 58cb2ce1e4df..92857283a675 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
@@ -25,7 +25,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_pin_a>;
 
-		camera-snapshot {
+		key-camera-snapshot {
 			label = "camera_snapshot";
 			gpios = <&pm8941_gpios 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_CAMERA>;
@@ -33,7 +33,7 @@ camera-snapshot {
 			debounce-interval = <15>;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "volume_down";
 			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
@@ -41,7 +41,7 @@ volume-down {
 			debounce-interval = <15>;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "volume_up";
 			gpios = <&pm8941_gpios 5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
index d6b2300a8223..1ed40c14f9d3 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
@@ -25,7 +25,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_pin_a>;
 
-		volume-down {
+		key-volume-down {
 			label = "volume_down";
 			gpios = <&pma8084_gpios 2 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
@@ -33,7 +33,7 @@ volume-down {
 			debounce-interval = <15>;
 		};
 
-		home-key {
+		key-home {
 			label = "home_key";
 			gpios = <&pma8084_gpios 3 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
@@ -42,7 +42,7 @@ home-key {
 			debounce-interval = <15>;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "volume_up";
 			gpios = <&pma8084_gpios 5 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 9bd8faea61a5..e409c12edc81 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -24,28 +24,28 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_pin_a>;
 
-		volume-down {
+		key-volume-down {
 			label = "volume_down";
 			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
-		camera-snapshot {
+		key-camera-snapshot {
 			label = "camera_snapshot";
 			gpios = <&pm8941_gpios 3 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
 			linux,code = <KEY_CAMERA>;
 		};
 
-		camera-focus {
+		key-camera-focus {
 			label = "camera_focus";
 			gpios = <&pm8941_gpios 4 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
 			linux,code = <KEY_CAMERA_FOCUS>;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "volume_up";
 			gpios = <&pm8941_gpios 5 GPIO_ACTIVE_LOW>;
 			linux,input-type = <1>;
-- 
2.34.1

