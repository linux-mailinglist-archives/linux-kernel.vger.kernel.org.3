Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23958544AB0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244377AbiFILmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243863AbiFILlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:41:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB1F1E7AE7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z7so30791207edm.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9cRkNbphtR1nWH7ufUYuqXLWJ3+nF8HvpiRBxYWxPQ=;
        b=Wuq0/BHsPLIr/5Ukyh4HMF66nh/FiGUekeKvObsoVs7Qb0w1TuxXwbERuQXfwQxHAW
         F+JIvSYa52Y9UY3Kov+BhzyQ0RWKDWbJR+vR/ADpTG2SBauITTIfNjZgzfUMp9VMktz7
         aBPeIYLFD0626XLTy5NHSF67TdPkMOIC2iXDU4UBbcwUfJSJZsYcgwodoaD0NB0SxczN
         a0wNfn33SMYWyw22pxSMa85DmMqlDST5SH0cCpKyak4yDeUWgZKpOTh6kXtq/+MXrGwP
         8fDglro7U/yFjGJFUq20O+3KuFXq7WnDTnAjGbSG5vUupqoF78D+nP2cXBI0GAWBiieS
         qf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9cRkNbphtR1nWH7ufUYuqXLWJ3+nF8HvpiRBxYWxPQ=;
        b=cRYfPMhRz8Yw/gvASJ1DmvPxgTHBn+bj4H/k/dtYxD4ViAuXJsoydNqXSVr8KlcLmP
         AYgyFrhcA/X/1qTNHiIoflgWRcd27CEWF7UaB64ZzoYGvMAPUQb/bAn+DhDSrGfw3yzt
         bW+GInflwHO+6XVKPjuFBQLgGe9lNqWHB2IyvOpy1b6hj9ot4QwWJ6iBJ8GkJaPyq5Iv
         BFS/1WEF6hZZZ/a38SPeOYjpgmJNLOC22yFkdfpRMGaMFv7lleGnqGDJSDvRXnLXs6La
         vn45+IMli+4bHp3nfWq2nfGZfDnKZ8mJ2zGdWBu5qfMTL7FFy9geZgKz/usWLmjjqgks
         jmmA==
X-Gm-Message-State: AOAM5309dS9rHQB0Wa7v5Vz6N4BD2xLTcA9cL6vkSKlctcqfVnOk3vel
        mVgLUtgWmIVA/rra+wFeav3uxA==
X-Google-Smtp-Source: ABdhPJweoCef6ndPmg5OlH9g2n6WcifhyDC5cWD984Vj3N6rLqYKkgQ4StlfX1DLfm725ZXe2wZSAg==
X-Received: by 2002:a05:6402:2995:b0:42a:843f:ac82 with SMTP id eq21-20020a056402299500b0042a843fac82mr44359675edb.370.1654774836842;
        Thu, 09 Jun 2022 04:40:36 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906058a00b007101f6f0720sm7760844ejn.120.2022.06.09.04.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 33/48] ARM: dts: rockchip: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:40:20 +0200
Message-Id: <20220609114026.380682-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

