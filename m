Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE254D686
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356353AbiFPAzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350145AbiFPAzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:55:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065EE580ED
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:38 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i64so100288pfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9cRkNbphtR1nWH7ufUYuqXLWJ3+nF8HvpiRBxYWxPQ=;
        b=tkmIXw8S+k2c1x0Z8p2fkhSsgK0peNeFvgYkUZVUbu5RtEBex46lXIf0HKW6KNOylf
         rUetQ2rNwWUAd44EAXVgDEadyBYaaJH/+W2wws4iXr+E8a6JlRbCZ+8k1Bb6YQs+dnX7
         id6Mioo1lPjVuzzNY2nslYBygaxWvtpXNzUbpiMHDzDuBVV/UL0Yxk6kulap4njidxnk
         nOMYL3P92a2zYS8o4YIl/5+ywbhC+oXAKuXL9R3gtKQgHFmgKTula0kNSxZiO9Qp88E6
         qrqiklAypz47DRoiMUu3RosDCn2TFv7BgtfIaHM0kdGxeTRY86D7VT9F3Y1otVqUksqD
         S+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9cRkNbphtR1nWH7ufUYuqXLWJ3+nF8HvpiRBxYWxPQ=;
        b=idMINOQ7EesA/UYyLMjeey1hHrIfpbnAPETcvIJ2wTSCwfR2wRECDLSs1VUu8sjdaG
         gmCrVI9vTf7hTrFqKQukhlKYKdHGFHA8OMBunx6MwnfrMVLtPZ4EYh7Xq29RPjY1KnMW
         nkUfwszcwSmztDWYHBHZTjjRJ3Lv0RL9UxSrJR2F3SpM4KlPN+4zra8T5DuhaRyFvg/a
         VZvZ4bd4lo24Yzr5O1Q3gC8/OKSWMxsTw5wH+btjk9QMyvLO6Y2JLWblipTTiscXzlPm
         i/P1n2ANMJGy7aTjlCly0wDbsIpW+GJk8yGlFG0gXJi+7C43zhMK6lKIH0lLOAwePDf4
         HyWQ==
X-Gm-Message-State: AJIora+ywzYJLx7qiMGGL7MCLQ0SMY5LOjZnETinK0NXw64412WSsRE7
        sNhuMSE6xxIBgkXycNXzrb+7USU3SAdomw==
X-Google-Smtp-Source: AGRyM1tpbUG7VBpi2KBjuHGMrdDhp+WlAIB47W+NtptWCExSUXTuflyBSiZqqcb1A36kEESZAQWFLw==
X-Received: by 2002:a63:5c56:0:b0:3fc:824d:fc57 with SMTP id n22-20020a635c56000000b003fc824dfc57mr2168194pgm.561.1655340875257;
        Wed, 15 Jun 2022 17:54:35 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 27/40] ARM: dts: rockchip: align gpio-key node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:20 -0700
Message-Id: <20220616005333.18491-27-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/rk3066a-bqcurie2.dts          | 4 ++--
 arch/arm/boot/dts/rk3066a-rayeager.dts          | 2 +-
 arch/arm/boot/dts/rk3188-bqedison2qc.dts        | 4 ++--
 arch/arm/boot/dts/rk3188-px3-evb.dts            | 2 +-
 arch/arm/boot/dts/rk3188-radxarock.dts          | 2 +-
 arch/arm/boot/dts/rk3229-evb.dts                | 2 +-
 arch/arm/boot/dts/rk3288-evb.dtsi               | 2 +-
 arch/arm/boot/dts/rk3288-firefly-reload.dts     | 2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi           | 2 +-
 arch/arm/boot/dts/rk3288-phycore-rdk.dts        | 4 ++--
 arch/arm/boot/dts/rk3288-popmetal.dts           | 2 +-
 arch/arm/boot/dts/rk3288-r89.dts                | 2 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts       | 2 +-
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 2 +-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts      | 4 ++--
 arch/arm/boot/dts/rk3288-veyron-pinky.dts       | 2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi            | 2 +-
 17 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index 390aa33cd55a..962b4d1291db 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -48,7 +48,7 @@ gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
 
-		power {
+		key-power {
 			gpios = <&gpio6 RK_PA2 GPIO_ACTIVE_LOW>; /* GPIO6_A2 */
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
@@ -56,7 +56,7 @@ power {
 			wakeup-source;
 			debounce-interval = <100>;
 		};
-		volume-down {
+		key-volume-down {
 			gpios = <&gpio4 RK_PC5 GPIO_ACTIVE_LOW>; /* GPIO4_C5 */
 			linux,code = <KEY_VOLUMEDOWN>;
 			label = "GPIO Key Vol-";
diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
index 12b2e59aebc4..dbbc5170094e 100644
--- a/arch/arm/boot/dts/rk3066a-rayeager.dts
+++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
@@ -32,7 +32,7 @@ ir: ir-receiver {
 	keys: gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			wakeup-source;
 			gpios = <&gpio6 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
diff --git a/arch/arm/boot/dts/rk3188-bqedison2qc.dts b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
index 35b7a5798eee..9312be362a7a 100644
--- a/arch/arm/boot/dts/rk3188-bqedison2qc.dts
+++ b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
@@ -37,7 +37,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key &usb_int>;
 
-		power {
+		key-power {
 			gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
@@ -46,7 +46,7 @@ power {
 			wakeup-source;
 		};
 
-		wake_on_usb: wake-on-usb {
+		wake_on_usb: key-wake-on-usb {
 			label = "Wake-on-USB";
 			gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm/boot/dts/rk3188-px3-evb.dts b/arch/arm/boot/dts/rk3188-px3-evb.dts
index fc478ac4e781..0a1ae689b162 100644
--- a/arch/arm/boot/dts/rk3188-px3-evb.dts
+++ b/arch/arm/boot/dts/rk3188-px3-evb.dts
@@ -29,7 +29,7 @@ gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
 
-		power {
+		key-power {
 			gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 36c0945f43b2..a9ed3cd2c2da 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -24,7 +24,7 @@ gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
 
-		power {
+		key-power {
 			gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
index 797476e8bef1..5c3d08e3eea3 100644
--- a/arch/arm/boot/dts/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -107,7 +107,7 @@ vdd_log: vdd-log-regulator {
 		regulator-boot-on;
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index c4ca73b40d4a..399d6b9c5fd4 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -118,7 +118,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwrbtn>;
 
-		power {
+		key-power {
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rk3288-firefly-reload.dts
index 9a4a9749c405..a5a0826341e6 100644
--- a/arch/arm/boot/dts/rk3288-firefly-reload.dts
+++ b/arch/arm/boot/dts/rk3288-firefly-reload.dts
@@ -27,7 +27,7 @@ button-recovery {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			wakeup-source;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 7fb582302b32..052afe5543e2 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -49,7 +49,7 @@ ir: ir-receiver {
 	keys: gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			wakeup-source;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
diff --git a/arch/arm/boot/dts/rk3288-phycore-rdk.dts b/arch/arm/boot/dts/rk3288-phycore-rdk.dts
index 1e33859de484..1a5156951492 100644
--- a/arch/arm/boot/dts/rk3288-phycore-rdk.dts
+++ b/arch/arm/boot/dts/rk3288-phycore-rdk.dts
@@ -20,14 +20,14 @@ user_buttons: user-buttons {
 		pinctrl-names = "default";
 		pinctrl-0 = <&user_button_pins>;
 
-		button@0 {
+		button-0 {
 			label = "home";
 			linux,code = <KEY_HOME>;
 			gpios = <&gpio8 0 GPIO_ACTIVE_HIGH>;
 			wakeup-source;
 		};
 
-		button@1 {
+		button-1 {
 			label = "menu";
 			linux,code = <KEY_MENU>;
 			gpios = <&gpio8 3 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index 8c7376d64bc4..fd90f3b8fc32 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -30,7 +30,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwrbtn>;
 
-		power {
+		key-power {
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
diff --git a/arch/arm/boot/dts/rk3288-r89.dts b/arch/arm/boot/dts/rk3288-r89.dts
index 55467bc30fa6..633e5a032463 100644
--- a/arch/arm/boot/dts/rk3288-r89.dts
+++ b/arch/arm/boot/dts/rk3288-r89.dts
@@ -31,7 +31,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwrbtn>;
 
-		power {
+		key-power {
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index c4d1d142d8c6..80e0f07c8e87 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -28,7 +28,7 @@ button-recovery {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index 05112c25176d..700bb548d6b2 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -32,7 +32,7 @@ lid_switch: lid-switch {
 		pinctrl-names = "default";
 		pinctrl-0 = <&ap_lid_int_l>;
 
-		lid {
+		switch-lid {
 			label = "Lid";
 			gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
 			wakeup-source;
diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index 82fc6fba9999..dcdcc55c4098 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -21,14 +21,14 @@ volume_buttons: volume-buttons {
 		pinctrl-names = "default";
 		pinctrl-0 = <&volum_down_l &volum_up_l>;
 
-		volum_down {
+		key-volum-down {
 			label = "Volum_down";
 			gpios = <&gpio5 RK_PB3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
 			debounce-interval = <100>;
 		};
 
-		volum_up {
+		key-volum-up {
 			label = "Volum_up";
 			gpios = <&gpio5 RK_PB2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm/boot/dts/rk3288-veyron-pinky.dts b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
index 4e9fdb0f722d..e2a4e6232eb5 100644
--- a/arch/arm/boot/dts/rk3288-veyron-pinky.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
@@ -45,7 +45,7 @@ &edp {
 &lid_switch {
 	pinctrl-0 = <&pwr_key_h &ap_lid_int_l>;
 
-	power {
+	key-power {
 		gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
 	};
 };
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 54a6838d73f5..e406c8c7c7e5 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -29,7 +29,7 @@ power_button: power-button {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key_l>;
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-- 
2.34.1

