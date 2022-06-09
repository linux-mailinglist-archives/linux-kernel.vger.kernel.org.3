Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5065544AC8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbiFILnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244028AbiFILmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:42:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25EB1DF112
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h23so35837688ejj.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDp4i9fK6ZlNgpwtecp/EcLoXznY+8QAd3GbFyU5H28=;
        b=GqO4nqAq5vON4VyW/I8XiGjnAvDTvOEmxbTGcEuwgRNwxDUoh+YDDMxRp9e9fj5dIV
         4TyZkU0ItY8LecYZvkhgh0PZcGCiNRn2wBE1z+vbHWtVpqhhgNDHojzJb/3AQVg/JWK2
         1hH1p4YgKymYTcmUALO7O6P8oiPawE/xguvEU8kafLz/ycxGcSuCOrA34Ddi9yYsEY5e
         pvD52rLNHJ5xmgIPud28EcrqoQ2yhhNVI4VbizndnoII0wBau1rdJTfeQgBErfcm1Fct
         T7ERyqI4/tk1uPJmJDxmRmsdhrPafwr0GJEFzqluA8GPcyyftFvgZSJa8NwqNLee+bQX
         d1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDp4i9fK6ZlNgpwtecp/EcLoXznY+8QAd3GbFyU5H28=;
        b=iRVAO7BWUILRPsMkrJggmCI2725WDthremJl/d0GobJc5/2D9OANxpxr2r3an+hRQb
         eEH+aTqeSvj3WUepNALgS4G/fipWnR2kWjKMFxZGDL0/r6Gza8+mz9V6j5sIB2eev//f
         ChaXd0C5w+dYlBpIQ6xKh7J91D3Q6FKkv0Ez2aSxbltgcdKt77HNCFSRS8dsjHwmMPhx
         2t0jtXmOJuO5Gnke3scE119GaSoMlQ2xU1AfOJCymSodI9/2Mj0WaOeMZT0Z5HqcApy3
         w0iGyqijIvgaBpMdIteAIJcbUoMXLq05hOkxjjxa8T4QtHYhxUAeub+I8x4rXWHrAnNV
         kFtw==
X-Gm-Message-State: AOAM532u3iZUd/mnSbyf/bT1LmniZ0OPR0jexK6NtAI0zV8oJWvkIP/L
        GlUBEYChFdTuJwRdFTwLLIQoDw==
X-Google-Smtp-Source: ABdhPJwdOJJnQY+KyvjJJDp1BkJ69H0dYCgysCMAgOU2vZcTBzDQVuwXv7e60fCPy1rxWS2umbbfjg==
X-Received: by 2002:a17:906:b788:b0:711:fc54:e55e with SMTP id dt8-20020a170906b78800b00711fc54e55emr5527011ejb.270.1654774845260;
        Thu, 09 Jun 2022 04:40:45 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906058a00b007101f6f0720sm7760844ejn.120.2022.06.09.04.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 39/48] ARM: dts: omap: correct gpio-keys properties
Date:   Thu,  9 Jun 2022 13:40:26 +0200
Message-Id: <20220609114026.380682-10-krzysztof.kozlowski@linaro.org>
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

gpio-keys children do not use unit addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/am335x-evm.dts                  | 2 --
 arch/arm/boot/dts/am335x-guardian.dts             | 2 --
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi | 4 +---
 arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi | 4 +---
 arch/arm/boot/dts/am335x-pcm-953.dtsi             | 4 ++--
 arch/arm/boot/dts/am335x-pepper.dts               | 8 +++-----
 arch/arm/boot/dts/am437x-idk-evm.dts              | 4 +---
 7 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 730898310641..25c6ac9913d2 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -94,8 +94,6 @@ &gpio1 26 GPIO_ACTIVE_HIGH		/* Bank1, pin26 */
 
 	gpio_keys: volume-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 
 		switch-9 {
diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 1a7e187b1953..f6356266564c 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -33,8 +33,6 @@ guardian_buttons: gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&guardian_button_pins>;
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		select-button {
 			label = "guardian-select-button";
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
index 92a0e98ec231..7b40ca9483ca 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
@@ -166,10 +166,8 @@ &mmc2 {
 &buttons {
 	pinctrl-names = "default";
 	pinctrl-0 = <&push_button_pins>;
-	#address-cells = <1>;
-	#size-cells = <0>;
 
-	button@0 {
+	button-0 {
 		label = "push_button";
 		linux,code = <0x100>;
 		gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi b/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
index e7e439a0630a..e0364adb8393 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
@@ -378,10 +378,8 @@ &mmc3 {
 &buttons {
 	pinctrl-names = "default";
 	pinctrl-0 = <&push_button_pins>;
-	#address-cells = <1>;
-	#size-cells = <0>;
 
-	button@0 {
+	button-0 {
 		label = "push_button";
 		linux,code = <0x100>;
 		gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/am335x-pcm-953.dtsi b/arch/arm/boot/dts/am335x-pcm-953.dtsi
index 124026fa0d09..dae448040a97 100644
--- a/arch/arm/boot/dts/am335x-pcm-953.dtsi
+++ b/arch/arm/boot/dts/am335x-pcm-953.dtsi
@@ -54,14 +54,14 @@ user_buttons: user_buttons {
 		pinctrl-names = "default";
 		pinctrl-0 = <&user_buttons_pins>;
 
-		button@0 {
+		button-0 {
 			label = "home";
 			linux,code = <KEY_HOME>;
 			gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
 			wakeup-source;
 		};
 
-		button@1 {
+		button-1 {
 			label = "menu";
 			linux,code = <KEY_MENU>;
 			gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index b5e88e627bc1..8691eec33b61 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -596,24 +596,22 @@ led1 {
 &buttons {
 	pinctrl-names = "default";
 	pinctrl-0 = <&user_buttons_pins>;
-	#address-cells = <1>;
-	#size-cells = <0>;
 
-	button0 {
+	button-0 {
 		label = "home";
 		linux,code = <KEY_HOME>;
 		gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
 		wakeup-source;
 	};
 
-	button1 {
+	button-1 {
 		label = "menu";
 		linux,code = <KEY_MENU>;
 		gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
 		wakeup-source;
 	};
 
-	buttons2 {
+	button-2 {
 		label = "power";
 		linux,code = <KEY_POWER>;
 		gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index d46cd721f27e..123a95f87554 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -102,10 +102,8 @@ gpio_keys: gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_pins_default>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		switch0 {
+		switch-0 {
 			label = "power-button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
-- 
2.34.1

