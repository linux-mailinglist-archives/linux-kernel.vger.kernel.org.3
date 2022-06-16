Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5106654D670
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355999AbiFPA4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349862AbiFPAzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:55:19 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C6B58398
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:43 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d129so12901642pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDp4i9fK6ZlNgpwtecp/EcLoXznY+8QAd3GbFyU5H28=;
        b=sQFWVugTKfxkM3FYLe8fA9qt8IbPmRaJCz6KfPIj9CmpsllvH84Mg3v8tQ6IhPc3SS
         zc8Dtc4c8u9Hl8Ow22OSqpjd6wyCAFkRjyHiiad8/aYi69QpE0IqQMfVlD7xaj4b9VBa
         0l/ZkdJPB4EwB+KCvM1bl4Okes4z29IqbXC4kMKu3a8fLCrsslykIIB/f5nooNIkZjXl
         suYIwd3Vtj0XIgpo2TLLQlZ5886Y8K+MYCh4WfzVO/hOl9Dku/MMeLqYhkzBVG1HR/F4
         ocsmZWX0x9onjWimnY8ko3zyqpSSv89tr2whubCAiby6jnXK83QOFnbVwDH6ljEDQIYv
         z0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDp4i9fK6ZlNgpwtecp/EcLoXznY+8QAd3GbFyU5H28=;
        b=vrtGXpWc5xo2wi6o3kt/mFjeTyJlGmBMoca2xI1HjFySuCdcDb9IjU4gU0ytPJPJCD
         /0Rd+x2o67z7T5lp5K6E8xZh5rsS4/kQRKEOUQ2YIybwKpF7A7dhEn6PX2s5RQVlP/lD
         Q7RPmy1xZZvOHaNlCh/uJb4muV6j8xfw1ggs7+Hu1K3f1covSmaF5OPwUrN8sHi9o0QB
         rrWsIThoDf/IlXt7QTR7t8jPcmyf5MP341KhsPoaPJh0BUkIqEqLnLWF8+pOX+uCJqlA
         BYXxXMOnguIZRNQaDIYz+G3qYFWV40sWseuCfF1WCl6sN0iIo7F58pdfc47NPskq0VpN
         J42g==
X-Gm-Message-State: AJIora/tJamZ5C1AqgTr78KZmn0JyxBlCJ0huRa3+08EXAOn44ReWM6F
        IE3mrkXFbayFj4CCeehxRQhlBQ==
X-Google-Smtp-Source: AGRyM1v6FOhhaKzh+JdhBC9cu610BDMkWk1LO+sEVJbXFRIOwm8ZKRuSwp9M2dzz1kigPNKkrweZEA==
X-Received: by 2002:a63:1566:0:b0:405:3aa3:23de with SMTP id 38-20020a631566000000b004053aa323demr2137255pgv.528.1655340882982;
        Wed, 15 Jun 2022 17:54:42 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 33/40] ARM: dts: omap: correct gpio-keys properties
Date:   Wed, 15 Jun 2022 17:53:26 -0700
Message-Id: <20220616005333.18491-33-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
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

