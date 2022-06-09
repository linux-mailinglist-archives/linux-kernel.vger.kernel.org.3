Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3094544A73
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242425AbiFILjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242223AbiFILjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:39:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560421A4A1A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:39:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 25so30535041edw.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUF7mJgyuOeQm7yqPJz+0uBUgSwvVQUVFwelZsrvov4=;
        b=NfadNQ/aFI7ofL8KwsplXAbQ0IPQd2DFyEVUrjhsA9GQfZK6w/oUk+3P1MwvQXGMG7
         bIHvscTaV2Nm6AMfDzRwZo72/bsAT+H0lsqff2N83hg2YACYFhNQEVDe0pkLF/+6QjSU
         mEH2gUVulT7Rv5LqWWXoPsYdcx0kY16/dq4J8kOV2KTJA7wPGAIaqY9+7ROuv5AY1Wsj
         jQE82QLEwmBfUmIMoppyE/UfN0jsCeckfzfXCdyz0ruxvLkQq1epCliJfeegz89RKSgg
         OVtd4ku/IsQQPeXL6uKjBtAcl+Nlzu8hHeRFCkdvycnSedrsQua1t8Yp9GZNQcj1iOHz
         bv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUF7mJgyuOeQm7yqPJz+0uBUgSwvVQUVFwelZsrvov4=;
        b=S/3yOumXWoWOJ32XHhhjfZuSvabNzKH3YydAlfX29cQZaAxheTbx3VppQCH+nMS62x
         4HuRekjCMTMWYIUT2i12YXqo4+tMOSF8hLjyWkZreZZbaOO6YZlszXiG9fC17bxY4Kzz
         a1Ak/4jFBxkJVYDHef0W5pLpmxSPy7Mv20ChnDnFbo1GR4lwZG5WvZqkI4zHaa5yuY08
         2SGTfRxN5mb+IZs1kwWN94Soe5KCDioDNjwbZsHA1etY+OvJ96GBF1NTqe+xed2Kxt5z
         ws6rFHajkfp3R3tIFtyy7dfUKq89KwKVmi1qwkn4kSiWB4Zu9HGhJeY93yBnuNoJ50Hm
         25tQ==
X-Gm-Message-State: AOAM533NhK3Yo0kWueGm7xWEC/F6g5t20smvSrKqayk/vz5N/hdB9D8V
        8+GYW5k4Xqqk7h3yR3Pm4yV9FZLB8tnN4Q==
X-Google-Smtp-Source: ABdhPJySnk1BDvd+UM+Ls8V8oJAH25W7D+a4xvsv+LPQaccuAQ/WgwM0D3Z5KNt/NbVt7CUYm6lDkA==
X-Received: by 2002:a05:6402:2381:b0:42d:c8fe:d7fe with SMTP id j1-20020a056402238100b0042dc8fed7femr43984477eda.248.1654774767620;
        Thu, 09 Jun 2022 04:39:27 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7d54e000000b0042e21f8c412sm11898495edr.42.2022.06.09.04.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:39:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 06/48] ARM: dts: allwinner: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:39:08 +0200
Message-Id: <20220609113911.380368-5-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts  | 40 +++++++++----------
 arch/arm/boot/dts/sun4i-a10-pcduino.dts       |  6 +--
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts      |  6 +--
 .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    |  4 +-
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts     |  4 +-
 .../boot/dts/sun8i-h3-mapleboard-mp130.dts    |  6 +--
 arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts    |  4 +-
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi        |  4 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts     |  6 +--
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts  |  4 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts   |  4 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts    |  4 +-
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi |  4 +-
 .../boot/dts/sunxi-libretech-all-h3-cc.dtsi   |  4 +-
 14 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
index 0a562b2cc5bc..62e7aa587f89 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
@@ -63,7 +63,7 @@ gpio-keys {
 		compatible = "gpio-keys-polled";
 		poll-interval = <20>;
 
-		left-joystick-left {
+		event-left-joystick-left {
 			label = "Left Joystick Left";
 			linux,code = <ABS_X>;
 			linux,input-type = <EV_ABS>;
@@ -71,7 +71,7 @@ left-joystick-left {
 			gpios = <&pio 0 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA6 */
 		};
 
-		left-joystick-right {
+		event-left-joystick-right {
 			label = "Left Joystick Right";
 			linux,code = <ABS_X>;
 			linux,input-type = <EV_ABS>;
@@ -79,7 +79,7 @@ left-joystick-right {
 			gpios = <&pio 0 5 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA5 */
 		};
 
-		left-joystick-up {
+		event-left-joystick-up {
 			label = "Left Joystick Up";
 			linux,code = <ABS_Y>;
 			linux,input-type = <EV_ABS>;
@@ -87,7 +87,7 @@ left-joystick-up {
 			gpios = <&pio 0 8 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA8 */
 		};
 
-		left-joystick-down {
+		event-left-joystick-down {
 			label = "Left Joystick Down";
 			linux,code = <ABS_Y>;
 			linux,input-type = <EV_ABS>;
@@ -95,7 +95,7 @@ left-joystick-down {
 			gpios = <&pio 0 9 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA9 */
 		};
 
-		right-joystick-left {
+		event-right-joystick-left {
 			label = "Right Joystick Left";
 			linux,code = <ABS_Z>;
 			linux,input-type = <EV_ABS>;
@@ -103,7 +103,7 @@ right-joystick-left {
 			gpios = <&pio 0 1 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA1 */
 		};
 
-		right-joystick-right {
+		event-right-joystick-right {
 			label = "Right Joystick Right";
 			linux,code = <ABS_Z>;
 			linux,input-type = <EV_ABS>;
@@ -111,7 +111,7 @@ right-joystick-right {
 			gpios = <&pio 0 0 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA0 */
 		};
 
-		right-joystick-up {
+		event-right-joystick-up {
 			label = "Right Joystick Up";
 			linux,code = <ABS_RZ>;
 			linux,input-type = <EV_ABS>;
@@ -119,7 +119,7 @@ right-joystick-up {
 			gpios = <&pio 0 3 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA3 */
 		};
 
-		right-joystick-down {
+		event-right-joystick-down {
 			label = "Right Joystick Down";
 			linux,code = <ABS_RZ>;
 			linux,input-type = <EV_ABS>;
@@ -127,7 +127,7 @@ right-joystick-down {
 			gpios = <&pio 0 4 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA4 */
 		};
 
-		dpad-left {
+		event-dpad-left {
 			label = "DPad Left";
 			linux,code = <ABS_HAT0X>;
 			linux,input-type = <EV_ABS>;
@@ -135,7 +135,7 @@ dpad-left {
 			gpios = <&pio 7 23 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PH23 */
 		};
 
-		dpad-right {
+		event-dpad-right {
 			label = "DPad Right";
 			linux,code = <ABS_HAT0X>;
 			linux,input-type = <EV_ABS>;
@@ -143,7 +143,7 @@ dpad-right {
 			gpios = <&pio 7 24 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PH24 */
 		};
 
-		dpad-up {
+		event-dpad-up {
 			label = "DPad Up";
 			linux,code = <ABS_HAT0Y>;
 			linux,input-type = <EV_ABS>;
@@ -151,7 +151,7 @@ dpad-up {
 			gpios = <&pio 7 25 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PH25 */
 		};
 
-		dpad-down {
+		event-dpad-down {
 			label = "DPad Down";
 			linux,code = <ABS_HAT0Y>;
 			linux,input-type = <EV_ABS>;
@@ -159,49 +159,49 @@ dpad-down {
 			gpios = <&pio 7 26 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PH26 */
 		};
 
-		x {
+		event-x {
 			label = "Button X";
 			linux,code = <BTN_X>;
 			gpios = <&pio 0 16 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA16 */
 		};
 
-		y {
+		event-y {
 			label = "Button Y";
 			linux,code = <BTN_Y>;
 			gpios = <&pio 0 14 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA14 */
 		};
 
-		a {
+		event-a {
 			label = "Button A";
 			linux,code = <BTN_A>;
 			gpios = <&pio 0 17 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA17 */
 		};
 
-		b {
+		event-b {
 			label = "Button B";
 			linux,code = <BTN_B>;
 			gpios = <&pio 0 15 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA15 */
 		};
 
-		select {
+		event-select {
 			label = "Select Button";
 			linux,code = <BTN_SELECT>;
 			gpios = <&pio 0 11 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA11 */
 		};
 
-		start {
+		event-start {
 			label = "Start Button";
 			linux,code = <BTN_START>;
 			gpios = <&pio 0 12 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA12 */
 		};
 
-		top-left {
+		event-top-left {
 			label = "Top Left Button";
 			linux,code = <BTN_TL>;
 			gpios = <&pio 7 22 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PH22 */
 		};
 
-		top-right {
+		event-top-right {
 			label = "Top Right Button";
 			linux,code = <BTN_TR>;
 			gpios = <&pio 0 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA13 */
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index 1ac82376baef..a332d61fd561 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -77,19 +77,19 @@ led-1 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		back {
+		key-back {
 			label = "Key Back";
 			linux,code = <KEY_BACK>;
 			gpios = <&pio 7 17 GPIO_ACTIVE_LOW>;
 		};
 
-		home {
+		key-home {
 			label = "Key Home";
 			linux,code = <KEY_HOME>;
 			gpios = <&pio 7 18 GPIO_ACTIVE_LOW>;
 		};
 
-		menu {
+		key-menu {
 			label = "Key Menu";
 			linux,code = <KEY_MENU>;
 			gpios = <&pio 7 19 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index 4f8d55d3ba79..928b86a95f34 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -78,19 +78,19 @@ led-1 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		back {
+		key-back {
 			label = "Key Back";
 			linux,code = <KEY_BACK>;
 			gpios = <&pio 7 17 GPIO_ACTIVE_LOW>;
 		};
 
-		home {
+		key-home {
 			label = "Key Home";
 			linux,code = <KEY_HOME>;
 			gpios = <&pio 7 18 GPIO_ACTIVE_LOW>;
 		};
 
-		menu {
+		key-menu {
 			label = "Key Menu";
 			linux,code = <KEY_MENU>;
 			gpios = <&pio 7 19 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index d5c7b7984d85..335ab583b1cd 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -47,10 +47,10 @@ pwr_led {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		sw4 {
+		switch-4 {
 			label = "power";
 			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index cd9f655e4f92..8167d473f2fd 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -93,10 +93,10 @@ led-1 {
 		};
 	};
 
-	r-gpio-keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "power";
 			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts b/arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts
index ff0a7a952e0c..f5c8ccc5b872 100644
--- a/arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts
+++ b/arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts
@@ -39,16 +39,16 @@ status_led {
 		};
 	};
 
-	r_gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "power";
 			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>; /* PL3 */
 		};
 
-		user {
+		key-user {
 			label = "user";
 			linux,code = <BTN_0>;
 			gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
index 8e7dfcffe1fb..71d617d25a56 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
@@ -37,10 +37,10 @@ led-1 {
 		};
 	};
 
-	r_gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		k1 {
+		key-0 {
 			label = "k1";
 			linux,code = <BTN_0>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>; /* PL3 */
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
index a9f749f49beb..cf8413fba6c1 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
@@ -73,10 +73,10 @@ led-1 {
 		};
 	};
 
-	r_gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		k1 {
+		key-0 {
 			label = "k1";
 			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 9daffd90c12f..f1f9dbead32a 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -88,16 +88,16 @@ pwr_led {
 		};
 	};
 
-	r_gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		sw2 {
+		switch-2 {
 			label = "sw2";
 			linux,code = <BTN_1>;
 			gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>;
 		};
 
-		sw4 {
+		switch-4 {
 			label = "sw4";
 			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
index 6f9c97add54e..305b34a321f5 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
@@ -87,10 +87,10 @@ status_led {
 		};
 	};
 
-	r_gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		sw4 {
+		switch-4 {
 			label = "sw4";
 			linux,code = <BTN_0>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 4759ba3f2986..59f6f6d5e7ca 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -86,10 +86,10 @@ status_led {
 		};
 	};
 
-	r_gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		sw4 {
+		switch-4 {
 			label = "sw4";
 			linux,code = <BTN_0>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 90f75fa85e68..b96e015f54ee 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -86,10 +86,10 @@ status_led {
 		};
 	};
 
-	r_gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		sw4 {
+		switch-4 {
 			label = "sw4";
 			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
index d03f5853ef7b..d1d960a1ba48 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
@@ -77,10 +77,10 @@ pwr_led {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		sw4 {
+		switch-4 {
 			label = "power";
 			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi b/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
index 9e14fe5fdcde..89731bb34c6b 100644
--- a/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
+++ b/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
@@ -42,10 +42,10 @@ status_led {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "power";
 			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
-- 
2.34.1

