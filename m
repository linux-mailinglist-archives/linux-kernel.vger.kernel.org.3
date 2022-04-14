Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8B65009D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbiDNJb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbiDNJbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:31:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4486F4B9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:28:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m14so6080567wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBu9bKNpcsjBxVmcDi5TeRQJe5h4mzqRMvKt6Hs6yfk=;
        b=Vewj5Dz7RSg+PeiaWemyvRfbGJIw6goI02YIUIlexhdopKGfuz5QFxWlU/cRgzOEMQ
         xe4qzReYV1rdCqIdlEwfz8aURRc2+/ASmpJOzJV5zpHGv3JwVlzxiTjxTrcd9QzSqdv8
         Zrr/R2ylnxbeTnZ3QFqDHi8umJN4S7DQCp8Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBu9bKNpcsjBxVmcDi5TeRQJe5h4mzqRMvKt6Hs6yfk=;
        b=ZdanKig/byIfjevp0pAzjB20pE6yjOt1vkdwIEKOMVPM5RRp1oO1ZhftKtYq4aFNVB
         eLsbBI5SiUbbwEzCWSg+oArXJeG6OJ7B/Jtxmf1z+zH26pIbSP7XpiPoQAqgc+8wNPHF
         jqIgrUrzFz0RoIk/ZqGndtWCWSm3E959JwQVrp+iuwUmaYaLCB1wYtO+AkcCJB4P4bwQ
         Ygox3Yl57IWSsefJvax4zu2Y/VgWTfCKfaRL9NUZyEDZhfxQl0IcCq84NgeYT8/VWPnn
         EKV2S8FHWw/9MhScOXT+ZjEA8iTHAyEB5HSjiDyuEZs5GGvt78O2WZWPNlRv4p8GwuhE
         tUSA==
X-Gm-Message-State: AOAM531EEFtn0+7DLoHbyPyIBjYNqM7V88k/uYUXPA4irbCy8pUo7Vh4
        kb9d+0SUxjilHO4mPlFg0MPHSA==
X-Google-Smtp-Source: ABdhPJzkPWbyQ3uEjfLiHNYske8Ws1jqaNiWmEv6M26tsYDiZ4KBw96HdYn2xvcVVHlNlUsXbquqjA==
X-Received: by 2002:a05:6000:1445:b0:204:1ca1:67b0 with SMTP id v5-20020a056000144500b002041ca167b0mr1376719wrx.507.1649928516912;
        Thu, 14 Apr 2022 02:28:36 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id bg8-20020a05600c3c8800b0038e4c5967besm1698099wmb.3.2022.04.14.02.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 02:28:36 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>
Subject: [PATCH v4 4/4] arm64: dts: address cros-ec-pwm channels by type
Date:   Thu, 14 Apr 2022 09:28:31 +0000
Message-Id: <20220414092831.3717684-5-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220414092831.3717684-1-fabiobaltieri@chromium.org>
References: <20220414092831.3717684-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update various cros-ec-pwm board definitions to address the keyboard and
screen backlight PWM channels by type rather than channel number. This
makes the instance independent by the actual hardware configuration,
relying on the EC firmware to pick the right channel, and allows
dropping few dtsi overrides as a consequence.

Changed the node label used to cros_ec_pwm_type to avoid ambiguity about
the pwm cell meaning.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
---
 .../dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts    | 4 ++--
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi   | 4 ++--
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi           | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi      | 4 ----
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi             | 9 +++++----
 .../boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts      | 7 ++++---
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi           | 7 ++++---
 arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi           | 4 ++--
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi               | 7 ++++---
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts          | 4 ----
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi  | 5 +++--
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts        | 4 ----
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi             | 1 +
 13 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
index dec11a4eb59e..e2554a313deb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
@@ -15,13 +15,13 @@ pwmleds {
 		compatible = "pwm-leds";
 		keyboard_backlight: keyboard-backlight {
 			label = "cros_ec::kbd_backlight";
-			pwms = <&cros_ec_pwm 0>;
+			pwms = <&cros_ec_pwm_type CROS_EC_PWM_DT_KB_LIGHT>;
 			max-brightness = <1023>;
 		};
 	};
 };
 
-&cros_ec_pwm {
+&cros_ec_pwm_type {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index 8f7bf33f607d..8474bd3af6eb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -92,8 +92,8 @@ volume_up {
 };
 
 &cros_ec {
-	cros_ec_pwm: ec-pwm {
-		compatible = "google,cros-ec-pwm";
+	cros_ec_pwm_type: ec-pwm {
+		compatible = "google,cros-ec-pwm-type";
 		#pwm-cells = <1>;
 		status = "disabled";
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 0f9480f91261..ff54687ab8bf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/mfd/cros_ec.h>
 #include "mt8183.dtsi"
 #include "mt6358.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index c81805ef2250..aea7c66d95e0 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -77,10 +77,6 @@ &ap_spi_fp {
 	status = "okay";
 };
 
-&backlight {
-	pwms = <&cros_ec_pwm 0>;
-};
-
 &camcc {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 732e1181af48..6552e0025f84 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/mfd/cros_ec.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/sound/sc7180-lpass.h>
 
@@ -316,7 +317,7 @@ backlight: backlight {
 		num-interpolated-steps = <64>;
 		default-brightness-level = <951>;
 
-		pwms = <&cros_ec_pwm 1>;
+		pwms = <&cros_ec_pwm_type CROS_EC_PWM_DT_DISPLAY_LIGHT>;
 		enable-gpios = <&tlmm 12 GPIO_ACTIVE_HIGH>;
 		power-supply = <&ppvar_sys>;
 		pinctrl-names = "default";
@@ -354,7 +355,7 @@ pwmleds {
 		keyboard_backlight: keyboard-backlight {
 			status = "disabled";
 			label = "cros_ec::kbd_backlight";
-			pwms = <&cros_ec_pwm 0>;
+			pwms = <&cros_ec_pwm_type CROS_EC_PWM_DT_KB_LIGHT>;
 			max-brightness = <1023>;
 		};
 	};
@@ -637,8 +638,8 @@ cros_ec: ec@0 {
 		pinctrl-0 = <&ap_ec_int_l>;
 		spi-max-frequency = <3000000>;
 
-		cros_ec_pwm: pwm {
-			compatible = "google,cros-ec-pwm";
+		cros_ec_pwm_type: pwm {
+			compatible = "google,cros-ec-pwm-type";
 			#pwm-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
index 1779d96c30f6..628ef990433b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/mfd/cros_ec.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
@@ -336,7 +337,7 @@ pwmleds {
 		keyboard_backlight: keyboard-backlight {
 			status = "disabled";
 			label = "cros_ec::kbd_backlight";
-			pwms = <&cros_ec_pwm 0>;
+			pwms = <&cros_ec_pwm_type CROS_EC_PWM_DT_KB_LIGHT>;
 			max-brightness = <1023>;
 		};
 	};
@@ -705,8 +706,8 @@ cros_ec: ec@0 {
 		pinctrl-0 = <&ap_ec_int_l>;
 		spi-max-frequency = <3000000>;
 
-		cros_ec_pwm: pwm {
-			compatible = "google,cros-ec-pwm";
+		cros_ec_pwm_type: pwm {
+			compatible = "google,cros-ec-pwm-type";
 			#pwm-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index dc17f2079695..eb4b0e17adec 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -15,6 +15,7 @@
 
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/mfd/cros_ec.h>
 
 #include "sc7280-qcard.dtsi"
 #include "sc7280-chrome-common.dtsi"
@@ -288,7 +289,7 @@ pwmleds {
 		keyboard_backlight: keyboard-backlight {
 			status = "disabled";
 			label = "cros_ec::kbd_backlight";
-			pwms = <&cros_ec_pwm 0>;
+			pwms = <&cros_ec_pwm_type CROS_EC_PWM_DT_KB_LIGHT>;
 			max-brightness = <1023>;
 		};
 	};
@@ -421,8 +422,8 @@ cros_ec: ec@0 {
 		pinctrl-0 = <&ap_ec_int_l>;
 		spi-max-frequency = <3000000>;
 
-		cros_ec_pwm: pwm {
-			compatible = "google,cros-ec-pwm";
+		cros_ec_pwm_type: pwm {
+			compatible = "google,cros-ec-pwm-type";
 			#pwm-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
index a7c346aa3b02..a797f09e1328 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
@@ -20,8 +20,8 @@ cros_ec: ec@0 {
 		pinctrl-0 = <&ap_ec_int_l>;
 		spi-max-frequency = <3000000>;
 
-		cros_ec_pwm: pwm {
-			compatible = "google,cros-ec-pwm";
+		cros_ec_pwm_type: pwm {
+			compatible = "google,cros-ec-pwm-type";
 			#pwm-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index e7e4cc5936aa..a57951a50cd6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/mfd/cros_ec.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sdm845.dtsi"
 
@@ -27,7 +28,7 @@ chosen {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&cros_ec_pwm 0>;
+		pwms = <&cros_ec_pwm_type CROS_EC_PWM_DT_DISPLAY_LIGHT>;
 		enable-gpios = <&tlmm 37 GPIO_ACTIVE_HIGH>;
 		power-supply = <&ppvar_sys>;
 		pinctrl-names = "default";
@@ -708,8 +709,8 @@ cros_ec: ec@0 {
 		pinctrl-0 = <&ec_ap_int_l>;
 		spi-max-frequency = <3000000>;
 
-		cros_ec_pwm: pwm {
-			compatible = "google,cros-ec-pwm";
+		cros_ec_pwm_type: pwm {
+			compatible = "google,cros-ec-pwm-type";
 			#pwm-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
index 31ebb4e5fd33..5a076c2564f6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
@@ -55,10 +55,6 @@ trackpad: trackpad@15 {
 	};
 };
 
-&backlight {
-	pwms = <&cros_ec_pwm 0>;
-};
-
 &cpu_alert0 {
 	temperature = <65000>;
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 3355fb90fa54..28eda361dfe1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -198,6 +198,7 @@ backlight: backlight {
 		power-supply = <&pp3300_disp>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
+		pwms = <&cros_ec_pwm_type CROS_EC_PWM_DT_DISPLAY_LIGHT>;
 		pwm-delay-us = <10000>;
 	};
 
@@ -462,8 +463,8 @@ ap_i2c_tp: &i2c5 {
 };
 
 &cros_ec {
-	cros_ec_pwm: pwm {
-		compatible = "google,cros-ec-pwm";
+	cros_ec_pwm_type: pwm {
+		compatible = "google,cros-ec-pwm-type";
 		#pwm-cells = <1>;
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 6863689df06f..e959a33af34b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -84,10 +84,6 @@ thermistor_ppvar_litcpu: thermistor-ppvar-litcpu {
 	};
 };
 
-&backlight {
-	pwms = <&cros_ec_pwm 1>;
-};
-
 &gpio_keys {
 	pinctrl-names = "default";
 	pinctrl-0 = <&bt_host_wake_l>, <&cpu1_pen_eject>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 162f08bca0d4..181159e9982d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/mfd/cros_ec.h>
 #include "rk3399.dtsi"
 #include "rk3399-op1-opp.dtsi"
 
-- 
2.35.1.1178.g4f1659d476-goog

