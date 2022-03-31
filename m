Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4284EDA16
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbiCaNA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbiCaNAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:00:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9633EBAB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:58:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r9-20020a1c4409000000b0038ccb70e239so803422wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aw43ShyWTbUOanwO78IeqdFbuMs79zsCXNAFn6cnNUM=;
        b=VOYyqlHVDP1xMHK2KF+JHMxE/Lb8UZ9nEDnDfj+kS6qvnqSx/1c2n0j0oboBWyb54T
         GqIZTEJ2UF2cyu9V+Ae4WQt3npQFXI/x9CwodL5bn0WRn4FRS4Gsz7fruMCeokUqo0wZ
         gzjCoarEqmOTIVVIdEwAzcTL/Io7b5lMXqDrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aw43ShyWTbUOanwO78IeqdFbuMs79zsCXNAFn6cnNUM=;
        b=0kQoFJzUYJtkw6OxcOFHRiVe+MHgtRqm8VZ90yzuCE5uh80E2SssYSsYhWN7CQUjES
         qalRYyly5qQYIz5qhRlVQRL74X+27QwpdnSJLakP5pINKZ0zmp3QmIeEzNEvHn5dqL5j
         fMO5EAKVuXfD6iGxYlUNIA46/rN9PmLkxL9OIQi/TDD9WCspdLkrdcL81l+/FBDDgl9M
         fsp4sXLrPBKKv0OJkkBNOOJgruN7erOJC+ZQO0Ip1eh7L6E3+CG9k8/sxxxfzstL6zuO
         +9xe5SRyZkAoq422LvbFUEvWV/8YqyUg+8X0b/sBpyN142i3PZYCPzmg4nQ4OLbJua7P
         Gnpw==
X-Gm-Message-State: AOAM530hQt4nur7N6zdExwcL1t0C9TEYuYi1KhdPJb+lZWtpYz7SRQOh
        nAKnKCqJ40whJXD7WMe4O3hlYQ==
X-Google-Smtp-Source: ABdhPJwBNx9zCzQDcWS+m0Z1PQADM7edu7bYTDURpz+AdSt3EYCH77a34WW0LFsLI414BhpW3lWz4w==
X-Received: by 2002:a05:600c:4f94:b0:38d:ed0:8468 with SMTP id n20-20020a05600c4f9400b0038d0ed08468mr4703460wmq.164.1648731505251;
        Thu, 31 Mar 2022 05:58:25 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038c9249ffdesm8230695wmq.9.2022.03.31.05.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:58:24 -0700 (PDT)
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
Subject: [PATCH v2 4/4] arm64: dts: address cros-ec-pwm channels by type
Date:   Thu, 31 Mar 2022 12:58:18 +0000
Message-Id: <20220331125818.3776912-5-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
In-Reply-To: <20220331125818.3776912-1-fabiobaltieri@chromium.org>
References: <20220331125818.3776912-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 .../dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts     | 4 ++--
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi    | 3 ++-
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi            | 1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi       | 4 ----
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi              | 8 +++++---
 .../arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts | 6 ++++--
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi            | 6 ++++--
 arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi            | 3 ++-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi                | 6 ++++--
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts           | 4 ----
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi   | 4 +++-
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts         | 4 ----
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi              | 1 +
 13 files changed, 28 insertions(+), 26 deletions(-)

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
index 8f7bf33f607d..f70c549bae93 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -92,10 +92,11 @@ volume_up {
 };
 
 &cros_ec {
-	cros_ec_pwm: ec-pwm {
+	cros_ec_pwm_type: ec-pwm {
 		compatible = "google,cros-ec-pwm";
 		#pwm-cells = <1>;
 		status = "disabled";
+		google,use-pwm-type;
 	};
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
index 732e1181af48..56f398b05b7b 100644
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
@@ -637,9 +638,10 @@ cros_ec: ec@0 {
 		pinctrl-0 = <&ap_ec_int_l>;
 		spi-max-frequency = <3000000>;
 
-		cros_ec_pwm: pwm {
+		cros_ec_pwm_type: pwm {
 			compatible = "google,cros-ec-pwm";
 			#pwm-cells = <1>;
+			google,use-pwm-type;
 		};
 
 		i2c_tunnel: i2c-tunnel {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
index 1779d96c30f6..cc11de91cc2c 100644
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
@@ -705,9 +706,10 @@ cros_ec: ec@0 {
 		pinctrl-0 = <&ap_ec_int_l>;
 		spi-max-frequency = <3000000>;
 
-		cros_ec_pwm: pwm {
+		cros_ec_pwm_type: pwm {
 			compatible = "google,cros-ec-pwm";
 			#pwm-cells = <1>;
+			google,use-pwm-type;
 		};
 
 		i2c_tunnel: i2c-tunnel {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index dc17f2079695..e5a041226db6 100644
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
@@ -421,9 +422,10 @@ cros_ec: ec@0 {
 		pinctrl-0 = <&ap_ec_int_l>;
 		spi-max-frequency = <3000000>;
 
-		cros_ec_pwm: pwm {
+		cros_ec_pwm_type: pwm {
 			compatible = "google,cros-ec-pwm";
 			#pwm-cells = <1>;
+			google,use-pwm-type;
 		};
 
 		i2c_tunnel: i2c-tunnel {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
index a7c346aa3b02..a8c189328ae3 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
@@ -20,9 +20,10 @@ cros_ec: ec@0 {
 		pinctrl-0 = <&ap_ec_int_l>;
 		spi-max-frequency = <3000000>;
 
-		cros_ec_pwm: pwm {
+		cros_ec_pwm_type: pwm {
 			compatible = "google,cros-ec-pwm";
 			#pwm-cells = <1>;
+			google,use-pwm-type;
 		};
 
 		i2c_tunnel: i2c-tunnel {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index e7e4cc5936aa..600b8ea69a5d 100644
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
@@ -708,9 +709,10 @@ cros_ec: ec@0 {
 		pinctrl-0 = <&ec_ap_int_l>;
 		spi-max-frequency = <3000000>;
 
-		cros_ec_pwm: pwm {
+		cros_ec_pwm_type: pwm {
 			compatible = "google,cros-ec-pwm";
 			#pwm-cells = <1>;
+			google,use-pwm-type;
 		};
 
 		i2c_tunnel: i2c-tunnel {
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
index 3355fb90fa54..fece0176a3d2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -198,6 +198,7 @@ backlight: backlight {
 		power-supply = <&pp3300_disp>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
+		pwms = <&cros_ec_pwm_type CROS_EC_PWM_DT_DISPLAY_LIGHT>;
 		pwm-delay-us = <10000>;
 	};
 
@@ -462,9 +463,10 @@ ap_i2c_tp: &i2c5 {
 };
 
 &cros_ec {
-	cros_ec_pwm: pwm {
+	cros_ec_pwm_type: pwm {
 		compatible = "google,cros-ec-pwm";
 		#pwm-cells = <1>;
+		google,use-pwm-type;
 	};
 
 	usbc_extcon1: extcon1 {
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
2.35.1.1021.g381101b075-goog

