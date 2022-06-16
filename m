Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E76654D664
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357103AbiFPA4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351393AbiFPAzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:55:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14F2579A0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:41 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h192so12918545pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0gTpvOOXwkw3+IlVKkOUqXd78sazfuzXwnJRU7GhmB0=;
        b=zSqHKEKGG5rVCuMyeDfOy2KoC6gZIDOb0Eiv2eR1rSishY+5d2ox8I4PT4h/v7fXjo
         Ys5fKYqi52vJGiA2trAiZ+A8pRA2sIzGj7aTMj9G2SCO8nuKUDNycYVCtZCiFww01dm9
         G6zcdCWIZFZerv/FXIHILTeyQpJBPdqRUWquBDALm0zZgkPHgQTE5lwd+MHK4X0B9yBQ
         P4SMWT2AVPVla03jZyAJQGDxUd6l/Lvk1RV9aSL3xd0dNKPFK/ypHX1oOGWDWOFOoBQe
         Tk3la9lEN48aqvaCepXzWhGwKingN7yut5Dp8ChkwjNrilgdy4Oozzeffa6by4298PJP
         6wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0gTpvOOXwkw3+IlVKkOUqXd78sazfuzXwnJRU7GhmB0=;
        b=VJZmx40eT1QzWa781qYJf8FSPBrRA0ALw5C9OZ+5JVPMIiyLOqQ5ioyF+Qba3fNAVr
         jPCP9Hct6KpqjJJEr4jqLJWHxj2pLiZ/NBJgEyFua17ntwikLTiUKno7a97GkP3X6s+X
         Ovda67UL9Hji0My9TQPcofXgtJxwK38dLw0F2PGxAsSbCEEwzu2AnDBWP39vaVRBM5H+
         iLDfngXR/+QeZrI/jVXCIVl+/xyVz7XQrqpy+SUBnB2OQG/WwefMY6M6Y8tuh7qqEWmy
         3Mg59RO5kF2nBCsfeVqonUSb7Y+o5Le0amx0+NO0KDf7fy0FgEEmdFZxBaJgE8f7lkfE
         mcpA==
X-Gm-Message-State: AJIora/Al8xmwf2ccZRhnxhneHQRXppFBppIKyTXV8GiKj3Yfb0c4iw/
        S8XebP9cxdwCPrwYPC2/rVI/Ag==
X-Google-Smtp-Source: AGRyM1t/rFXgd2Xwr2juPBbmkmESEaIYaiDPxYmFcyxDFt7JZawlwu70dI9zBMCQG85n1cAOR3P7lw==
X-Received: by 2002:a63:3184:0:b0:3fc:5893:c866 with SMTP id x126-20020a633184000000b003fc5893c866mr2217869pgx.56.1655340881501;
        Wed, 15 Jun 2022 17:54:41 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:41 -0700 (PDT)
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
Subject: [PATCH v3 32/40] ARM: dts: omap: align gpio-key node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:25 -0700
Message-Id: <20220616005333.18491-32-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/am335x-evm.dts     |  6 +++---
 arch/arm/boot/dts/am335x-shc.dts     |  6 +++---
 arch/arm/boot/dts/am3517-evm-ui.dtsi | 20 ++++++++++----------
 arch/arm/boot/dts/am3517-evm.dts     | 18 +++++++++---------
 arch/arm/boot/dts/am437x-idk-evm.dts |  2 +-
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index b9745a2f0e4d..730898310641 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -92,20 +92,20 @@ &gpio1 26 GPIO_ACTIVE_HIGH		/* Bank1, pin26 */
 				0x0201006c>;	/* DOWN */
 	};
 
-	gpio_keys: volume_keys0 {
+	gpio_keys: volume-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		autorepeat;
 
-		switch9 {
+		switch-9 {
 			label = "volume-up";
 			linux,code = <115>;
 			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
 			wakeup-source;
 		};
 
-		switch10 {
+		switch-10 {
 			label = "volume-down";
 			linux,code = <114>;
 			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index 6b9877560741..c497200f9cb0 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -36,10 +36,10 @@ cpu@0 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		back_button {
+		back-button {
 			label = "Back Button";
 			gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_BACK>;
@@ -47,7 +47,7 @@ back_button {
 			wakeup-source;
 		};
 
-		front_button {
+		front-button {
 			label = "Front Button";
 			gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_FRONT>;
diff --git a/arch/arm/boot/dts/am3517-evm-ui.dtsi b/arch/arm/boot/dts/am3517-evm-ui.dtsi
index 7d8f32bf70db..5a1c3eec12db 100644
--- a/arch/arm/boot/dts/am3517-evm-ui.dtsi
+++ b/arch/arm/boot/dts/am3517-evm-ui.dtsi
@@ -70,61 +70,61 @@ expander-keys {
 		compatible = "gpio-keys-polled";
 		poll-interval = <100>;
 
-		record {
+		key-record {
 			label = "Record";
 			/* linux,code = <BTN_0>; */
 			gpios = <&tca6416_2 15 GPIO_ACTIVE_LOW>;
 		};
 
-		play {
+		key-play {
 			label = "Play";
 			linux,code = <KEY_PLAY>;
 			gpios = <&tca6416_2 14 GPIO_ACTIVE_LOW>;
 		};
 
-		Stop {
+		key-stop {
 			label = "Stop";
 			linux,code = <KEY_STOP>;
 			gpios = <&tca6416_2 13 GPIO_ACTIVE_LOW>;
 		};
 
-		fwd {
+		key-fwd {
 			label = "FWD";
 			linux,code = <KEY_FASTFORWARD>;
 			gpios = <&tca6416_2 12 GPIO_ACTIVE_LOW>;
 		};
 
-		rwd {
+		key-rwd {
 			label = "RWD";
 			linux,code = <KEY_REWIND>;
 			gpios = <&tca6416_2 11 GPIO_ACTIVE_LOW>;
 		};
 
-		shift {
+		key-shift {
 			label = "Shift";
 			linux,code = <KEY_LEFTSHIFT>;
 			gpios = <&tca6416_2 10 GPIO_ACTIVE_LOW>;
 		};
 
-		Mode {
+		key-mode {
 			label = "Mode";
 			linux,code = <BTN_MODE>;
 			gpios = <&tca6416_2 9 GPIO_ACTIVE_LOW>;
 		};
 
-		Menu {
+		key-menu {
 			label = "Menu";
 			linux,code = <KEY_MENU>;
 			gpios = <&tca6416_2 8 GPIO_ACTIVE_LOW>;
 		};
 
-		Up {
+		key-up {
 			label = "Up";
 			linux,code = <KEY_UP>;
 			gpios = <&tca6416_2 7 GPIO_ACTIVE_LOW>;
 		};
 
-		Down {
+		key-down {
 			label = "Down";
 			linux,code = <KEY_DOWN>;
 			gpios = <&tca6416_2 6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index c8b80f156ec9..35b653014f2b 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -37,55 +37,55 @@ gpio-keys {
 		compatible = "gpio-keys-polled";
 		poll-interval = <100>;
 
-		user_pb {
+		button-user {
 			label = "User Push Button";
 			linux,code = <BTN_0>;
 			gpios = <&tca6416 5 GPIO_ACTIVE_LOW>;
 		};
 
-		user_sw_1 {
+		switch-1 {
 			label = "User Switch 1";
 			linux,code = <BTN_1>;
 			gpios = <&tca6416 8 GPIO_ACTIVE_LOW>;
 		};
 
-		user_sw_2 {
+		switch-2 {
 			label = "User Switch 2";
 			linux,code = <BTN_2>;
 			gpios = <&tca6416 9 GPIO_ACTIVE_LOW>;
 		};
 
-		user_sw_3 {
+		switch-3 {
 			label = "User Switch 3";
 			linux,code = <BTN_3>;
 			gpios = <&tca6416 10 GPIO_ACTIVE_LOW>;
 		};
 
-		user_sw_4 {
+		switch-4 {
 			label = "User Switch 4";
 			linux,code = <BTN_4>;
 			gpios = <&tca6416 11 GPIO_ACTIVE_LOW>;
 		};
 
-		user_sw_5 {
+		switch-5 {
 			label = "User Switch 5";
 			linux,code = <BTN_5>;
 			gpios = <&tca6416 12 GPIO_ACTIVE_LOW>;
 		};
 
-		user_sw_6 {
+		switch-6 {
 			label = "User Switch 6";
 			linux,code = <BTN_6>;
 			gpios = <&tca6416 13 GPIO_ACTIVE_LOW>;
 		};
 
-		user_sw_7 {
+		switch-7 {
 			label = "User Switch 7";
 			linux,code = <BTN_7>;
 			gpios = <&tca6416 14 GPIO_ACTIVE_LOW>;
 		};
 
-		user_sw_8 {
+		switch-8 {
 			label = "User Switch 8";
 			linux,code = <BTN_8>;
 			gpios = <&tca6416 15 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index 5a74b83145cf..d46cd721f27e 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -98,7 +98,7 @@ v1_5d: fixed-regulator-v1_5d{
 		vin-supply = <&v1_5dreg>;
 	};
 
-	gpio_keys: gpio_keys {
+	gpio_keys: gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_pins_default>;
-- 
2.34.1

