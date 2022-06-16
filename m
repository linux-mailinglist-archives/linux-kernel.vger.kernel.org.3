Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F13B54D696
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357286AbiFPA4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350802AbiFPA4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:56:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ED25908F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id g8so10626plt.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x2vx4evi+M796k3AjUjdVhS8f0B1ALhDXOlSQG5ZWMo=;
        b=ImTBj1eSxqhIfPDX4xuG52iL1mjR92ZMNIwBHuQQsfril1H/d+yG3fE5qEyv4Itk4g
         GhbjEmQ8rRkfr1qumfeGXXSIhmon6ePn+JK2dfcCGhzmhKy66E3EFNhKzp194ZD4YCfR
         4rHq31cKlqR6ygcgEDWHvYn+wtkzrTWqW3EYDCbqY67ffoywQgpjtEi5RGbJ5EuOSwKu
         nJ2Hav3eT1YpfYTjztKTtllAGefBXFnbmtQuHwv0a28Hsclv+Jkn7raE0g3RdgrtyJf/
         RRrvoqGHQUrYQqtvWZjb3KG+vOMjxQ5DrhTCiMFbx00fULMbOJ8y2Un9v/o6dQDOmOj7
         KBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x2vx4evi+M796k3AjUjdVhS8f0B1ALhDXOlSQG5ZWMo=;
        b=7t110KeCjrHtahfeAoKe3BAWNAtS1w+8M5UAnaxBG7wKLHh/ikvC83uzE6voyyfRDK
         qafNF0st8Hnsr/9drjdYEqGmkNUSmIML0u8BQeWoeWFLEyC5s2XRV/lYFWlhTHWZ9adk
         UfzqEvFV99qk375Zan4aX2uijAi/VU5aAp6NINcX9RM8H6CoaJbis0sY4qEmc1/dy6e8
         k4Vdr2ZWeTLtAg9BRnGxMLu+61eDgBPubvG2WYG8oMxIPLihkiXEWnzbGMawz9usWs3B
         F92f3IoaRZKnSpP/uUooTNYThBqlLI2eydoIXiu/L18Q2+HpytIMZJ/7TLG8/wYeJdZ9
         NVLQ==
X-Gm-Message-State: AJIora8rGgBqN9OfkCKXgB0qgrpAE85auXh/q4d7kWFOV8qZBjVLSM34
        m7bS4LIDPP9Lh+NDRnbAmDmfzQ==
X-Google-Smtp-Source: AGRyM1sijBtdLomXuhegpBhlXUqCI4uYDyV9rtoEKU5TJFUgHVwVEnoVV6WFxugikO6XkbqCLsJv1Q==
X-Received: by 2002:a17:902:a618:b0:168:9ef0:fb82 with SMTP id u24-20020a170902a61800b001689ef0fb82mr2388223plq.144.1655340890769;
        Wed, 15 Jun 2022 17:54:50 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Peter Rosin <peda@axentia.se>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 38/40] ARM: dts: at91: align gpio-key node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:31 -0700
Message-Id: <20220616005333.18491-38-krzysztof.kozlowski@linaro.org>
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

Changes since v2:
1. at91-sam9x60ek.dts, at91-sama5d27_wlsom1_ek.dts,
   at91-sama5d2_icp.dts: different names according to discussion.
---
 arch/arm/boot/dts/at91-foxg20.dts                |  4 ++--
 arch/arm/boot/dts/at91-gatwick.dts               |  2 +-
 arch/arm/boot/dts/at91-kizbox.dts                |  6 +++---
 arch/arm/boot/dts/at91-kizbox2-common.dtsi       |  8 ++++----
 arch/arm/boot/dts/at91-kizbox3-hs.dts            | 12 ++++++------
 arch/arm/boot/dts/at91-kizboxmini-common.dtsi    |  4 ++--
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts      |  2 +-
 arch/arm/boot/dts/at91-qil_a9260.dts             |  2 +-
 arch/arm/boot/dts/at91-sam9x60ek.dts             |  4 ++--
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts      |  4 ++--
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts    |  4 ++--
 arch/arm/boot/dts/at91-sama5d2_icp.dts           |  4 ++--
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts        |  4 ++--
 arch/arm/boot/dts/at91-sama5d2_xplained.dts      |  4 ++--
 arch/arm/boot/dts/at91-sama5d3_xplained.dts      |  4 ++--
 arch/arm/boot/dts/at91-sama5d4_xplained.dts      |  4 ++--
 arch/arm/boot/dts/at91-sama5d4ek.dts             |  4 ++--
 arch/arm/boot/dts/at91-sama7g5ek.dts             |  4 ++--
 arch/arm/boot/dts/at91-wb45n.dts                 |  2 +-
 arch/arm/boot/dts/at91-wb50n.dts                 |  2 +-
 arch/arm/boot/dts/at91sam9260ek.dts              |  6 +++---
 arch/arm/boot/dts/at91sam9261ek.dts              | 10 +++++-----
 arch/arm/boot/dts/at91sam9263ek.dts              |  6 +++---
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi      |  6 +++---
 .../dts/at91sam9g25-gardena-smart-gateway.dts    |  2 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts           | 16 ++++++++--------
 arch/arm/boot/dts/at91sam9n12ek.dts              |  4 ++--
 arch/arm/boot/dts/at91sam9rlek.dts               |  6 +++---
 28 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/arch/arm/boot/dts/at91-foxg20.dts b/arch/arm/boot/dts/at91-foxg20.dts
index 7edf057047f8..9dfd5de808d1 100644
--- a/arch/arm/boot/dts/at91-foxg20.dts
+++ b/arch/arm/boot/dts/at91-foxg20.dts
@@ -155,10 +155,10 @@ user_led {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		btn {
+		button {
 			label = "Button";
 			gpios = <&pioC 4 GPIO_ACTIVE_LOW>;
 			linux,code = <0x103>;
diff --git a/arch/arm/boot/dts/at91-gatwick.dts b/arch/arm/boot/dts/at91-gatwick.dts
index 5a81cab5fc3a..2c718cf84d7b 100644
--- a/arch/arm/boot/dts/at91-gatwick.dts
+++ b/arch/arm/boot/dts/at91-gatwick.dts
@@ -13,7 +13,7 @@ / {
 	model = "Laird Workgroup Bridge 50N - Project Gatwick";
 	compatible = "laird,gatwick", "laird,wb50n", "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
 
diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index 3b8812fcd854..87e972eb2ba6 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -28,19 +28,19 @@ main_xtal {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		reset {
+		button-reset {
 			label = "PB_RST";
 			gpios = <&pioB 30 GPIO_ACTIVE_HIGH>;
 			linux,code = <0x100>;
 			wakeup-source;
 		};
 
-		user {
+		button-user {
 			label = "PB_USER";
 			gpios = <&pioB 31 GPIO_ACTIVE_HIGH>;
 			linux,code = <0x101>;
diff --git a/arch/arm/boot/dts/at91-kizbox2-common.dtsi b/arch/arm/boot/dts/at91-kizbox2-common.dtsi
index c08834ddf07b..ed7146e23147 100644
--- a/arch/arm/boot/dts/at91-kizbox2-common.dtsi
+++ b/arch/arm/boot/dts/at91-kizbox2-common.dtsi
@@ -31,26 +31,26 @@ main_xtal {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		prog {
+		button-prog {
 			label = "PB_PROG";
 			gpios = <&pioE 27 GPIO_ACTIVE_LOW>;
 			linux,code = <0x102>;
 			wakeup-source;
 		};
 
-		reset {
+		button-reset {
 			label = "PB_RST";
 			gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
 			linux,code = <0x100>;
 			wakeup-source;
 		};
 
-		user {
+		button-user {
 			label = "PB_USER";
 			gpios = <&pioE 31 GPIO_ACTIVE_HIGH>;
 			linux,code = <0x101>;
diff --git a/arch/arm/boot/dts/at91-kizbox3-hs.dts b/arch/arm/boot/dts/at91-kizbox3-hs.dts
index 2799b2a1f4d2..f76e2e0b41ae 100644
--- a/arch/arm/boot/dts/at91-kizbox3-hs.dts
+++ b/arch/arm/boot/dts/at91-kizbox3-hs.dts
@@ -55,7 +55,7 @@ led-6 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default" , "default", "default",
 				"default", "default" ;
@@ -68,35 +68,35 @@ &pinctrl_pio_io_reset
 			     &pinctrl_pio_zbe_rst>;
 		pinctrl-4 = <&pinctrl_pio_input>;
 
-		SW1 {
+		switch-1 {
 			label = "SW1";
 			gpios = <&pioA PIN_PA29 GPIO_ACTIVE_LOW>;
 			linux,code = <0x101>;
 			wakeup-source;
 		};
 
-		SW2 {
+		switch-2 {
 			label = "SW2";
 			gpios = <&pioA PIN_PA18 GPIO_ACTIVE_LOW>;
 			linux,code = <0x102>;
 			wakeup-source;
 		};
 
-		SW3 {
+		switch-3 {
 			label = "SW3";
 			gpios = <&pioA PIN_PA22 GPIO_ACTIVE_LOW>;
 			linux,code = <0x103>;
 			wakeup-source;
 		};
 
-		SW7 {
+		switch-7 {
 			label = "SW7";
 			gpios = <&pioA PIN_PA26 GPIO_ACTIVE_LOW>;
 			linux,code = <0x107>;
 			wakeup-source;
 		};
 
-		SW8 {
+		switch-8 {
 			label = "SW8";
 			gpios = <&pioA PIN_PA24 GPIO_ACTIVE_LOW>;
 			linux,code = <0x108>;
diff --git a/arch/arm/boot/dts/at91-kizboxmini-common.dtsi b/arch/arm/boot/dts/at91-kizboxmini-common.dtsi
index 9c622892c692..8fb08e6fad7a 100644
--- a/arch/arm/boot/dts/at91-kizboxmini-common.dtsi
+++ b/arch/arm/boot/dts/at91-kizboxmini-common.dtsi
@@ -39,14 +39,14 @@ gpio_keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		prog {
+		key-prog {
 			label = "PB_PROG";
 			gpios = <&pioC 17 GPIO_ACTIVE_LOW>;
 			linux,code = <0x102>;
 			wakeup-source;
 		};
 
-		reset {
+		key-reset {
 			label = "PB_RST";
 			gpios = <&pioC 16 GPIO_ACTIVE_LOW>;
 			linux,code = <0x100>;
diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index 4f123477e631..f71377c9b757 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -18,7 +18,7 @@ / {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wakeup {
+		key-wakeup {
 			label = "Wakeup";
 			linux,code = <10>;
 			wakeup-source;
diff --git a/arch/arm/boot/dts/at91-qil_a9260.dts b/arch/arm/boot/dts/at91-qil_a9260.dts
index 969d990767fc..d09b3d15a828 100644
--- a/arch/arm/boot/dts/at91-qil_a9260.dts
+++ b/arch/arm/boot/dts/at91-qil_a9260.dts
@@ -201,7 +201,7 @@ gpio_keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		user_pb {
+		button-user {
 			label = "user_pb";
 			gpios = <&pioB 10 GPIO_ACTIVE_LOW>;
 			linux,code = <28>;
diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index 7719ea3d4933..838353a42097 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -76,13 +76,13 @@ vdd2_3v3: regulator-fixed-vdd2_3v3@3 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
 		status = "okay";
 
-		sw1 {
+		button-1 {
 			label = "SW1";
 			gpios = <&pioD 18 GPIO_ACTIVE_LOW>;
 			linux,code=<KEY_PROG1>;
diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 08f0d4b995ff..96c9290007a8 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -478,13 +478,13 @@ can1: can@fc050000 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
 
-		pb4 {
+		button {
 			label = "USER";
 			gpios = <&pioA PIN_PA29 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_PROG1>;
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
index 5e8755f22784..b55e8fb113b1 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
@@ -26,14 +26,14 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
 		status = "okay";
 
-		sw4 {
+		button-1 {
 			label = "USER BUTTON";
 			gpios = <&pioA PIN_PB2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_PROG1>;
diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
index 806eb1d911d7..38f0e1ae6ae6 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -42,14 +42,14 @@ main_xtal {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
 		status = "okay";
 
-		sw4 {
+		button-1 {
 			label = "USER_PB1";
 			gpios = <&pioA PIN_PD0 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_PROG1>;
diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index 8ed58af01391..544c64549459 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -394,13 +394,13 @@ pinctrl_usba_vbus: usba_vbus {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
 
-		bp1 {
+		button-1 {
 			label = "PB_USER";
 			gpios = <&pioA PIN_PA10 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_PROG1>;
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index cdfe891f9a9e..6799c2f475b2 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -703,13 +703,13 @@ can1: can@fc050000 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
 
-		bp1 {
+		button {
 			label = "PB_USER";
 			gpios = <&pioA PIN_PB9 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_PROG1>;
diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index a49c2966b41e..1f42a6a981bf 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -372,13 +372,13 @@ vcc_mmc0_reg: fixedregulator_mmc0 {
 		regulator-always-on;
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio>;
 
-		bp3 {
+		button {
 			label = "PB_USER";
 			gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_PROG1>;
diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index e519d2747936..f122f302f8e0 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -242,13 +242,13 @@ rootfs@800000 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio>;
 
-		pb_user1 {
+		button {
 			label = "pb_user1";
 			gpios = <&pioE 8 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_PROG1>;
diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index 7017f626f362..fce4e93c6bee 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -269,13 +269,13 @@ rootfs@800000 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio>;
 
-		pb_user1 {
+		button {
 			label = "pb_user1";
 			gpios = <&pioE 13 GPIO_ACTIVE_HIGH>;
 			linux,code = <0x100>;
diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 103544620fd7..de44da2e4aae 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -45,13 +45,13 @@ main_xtal {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
 
-		bp1 {
+		button {
 			label = "PB_USER";
 			gpios = <&pioA PIN_PA12 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_PROG1>;
diff --git a/arch/arm/boot/dts/at91-wb45n.dts b/arch/arm/boot/dts/at91-wb45n.dts
index 54d130c92185..3e46b29412d1 100644
--- a/arch/arm/boot/dts/at91-wb45n.dts
+++ b/arch/arm/boot/dts/at91-wb45n.dts
@@ -12,7 +12,7 @@ / {
 	model = "Laird Workgroup Bridge 45N - Atmel AT91SAM (dt)";
 	compatible = "laird,wb45n", "laird,wbxx", "atmel,at91sam9x5", "atmel,at91sam9";
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/at91-wb50n.dts b/arch/arm/boot/dts/at91-wb50n.dts
index 89f0f717f7ed..e2195bd3e4b4 100644
--- a/arch/arm/boot/dts/at91-wb50n.dts
+++ b/arch/arm/boot/dts/at91-wb50n.dts
@@ -13,7 +13,7 @@ / {
 	model = "Laird Workgroup Bridge 50N - Atmel SAMA5D";
 	compatible = "laird,wb50n", "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/at91sam9260ek.dts b/arch/arm/boot/dts/at91sam9260ek.dts
index 6381088ba24f..bb72f050a4fe 100644
--- a/arch/arm/boot/dts/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/at91sam9260ek.dts
@@ -144,17 +144,17 @@ nand0: nand@40000000 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		btn3 {
+		button-3 {
 			label = "Button 3";
 			gpios = <&pioA 30 GPIO_ACTIVE_LOW>;
 			linux,code = <0x103>;
 			wakeup-source;
 		};
 
-		btn4 {
+		button-4 {
 			label = "Button 4";
 			gpios = <&pioA 31 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_PROG1>;
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index 6fb4fe49cf1c..88869ca874d1 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -211,31 +211,31 @@ ds1 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		button_0 {
+		button-0 {
 			label = "button_0";
 			gpios = <&pioA 27 GPIO_ACTIVE_LOW>;
 			linux,code = <256>;
 			wakeup-source;
 		};
 
-		button_1 {
+		button-1 {
 			label = "button_1";
 			gpios = <&pioA 26 GPIO_ACTIVE_LOW>;
 			linux,code = <257>;
 			wakeup-source;
 		};
 
-		button_2 {
+		button-2 {
 			label = "button_2";
 			gpios = <&pioA 25 GPIO_ACTIVE_LOW>;
 			linux,code = <258>;
 			wakeup-source;
 		};
 
-		button_3 {
+		button-3 {
 			label = "button_3";
 			gpios = <&pioA 24 GPIO_ACTIVE_LOW>;
 			linux,code = <259>;
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index e732565913a4..ce8baff6a9f4 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -232,17 +232,17 @@ d2 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		left_click {
+		button-left-click {
 			label = "left_click";
 			gpios = <&pioC 5 GPIO_ACTIVE_LOW>;
 			linux,code = <272>;
 			wakeup-source;
 		};
 
-		right_click {
+		button-right-click {
 			label = "right_click";
 			gpios = <&pioC 4 GPIO_ACTIVE_LOW>;
 			linux,code = <273>;
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 85c17dd1c8d5..60d61291f344 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -234,17 +234,17 @@ wm8731: wm8731@1b {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		btn3 {
+		button-3 {
 			label = "Button 3";
 			gpios = <&pioA 30 GPIO_ACTIVE_LOW>;
 			linux,code = <0x103>;
 			wakeup-source;
 		};
 
-		btn4 {
+		button-4 {
 			label = "Button 4";
 			gpios = <&pioA 31 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_PROG1>;
diff --git a/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts b/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts
index 7da70aeeb528..92f2c05c873f 100644
--- a/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts
+++ b/arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts
@@ -23,7 +23,7 @@ aliases {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user_btn1 {
+		button {
 			label = "USER_BTN1";
 			gpios = <&pioA 24 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_PROG1>;
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index e5db198a87a8..7f45e81ca165 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -343,48 +343,48 @@ led-3 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		left_click {
+		button-left-click {
 			label = "left_click";
 			gpios = <&pioB 6 GPIO_ACTIVE_LOW>;
 			linux,code = <272>;
 			wakeup-source;
 		};
 
-		right_click {
+		button-right-click {
 			label = "right_click";
 			gpios = <&pioB 7 GPIO_ACTIVE_LOW>;
 			linux,code = <273>;
 			wakeup-source;
 		};
 
-		left {
+		button-left {
 			label = "Joystick Left";
 			gpios = <&pioB 14 GPIO_ACTIVE_LOW>;
 			linux,code = <105>;
 		};
 
-		right {
+		button-right {
 			label = "Joystick Right";
 			gpios = <&pioB 15 GPIO_ACTIVE_LOW>;
 			linux,code = <106>;
 		};
 
-		up {
+		button-up {
 			label = "Joystick Up";
 			gpios = <&pioB 16 GPIO_ACTIVE_LOW>;
 			linux,code = <103>;
 		};
 
-		down {
+		button-down {
 			label = "Joystick Down";
 			gpios = <&pioB 17 GPIO_ACTIVE_LOW>;
 			linux,code = <108>;
 		};
 
-		enter {
+		button-enter {
 			label = "Joystick Press";
 			gpios = <&pioB 18 GPIO_ACTIVE_LOW>;
 			linux,code = <28>;
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index c905d7bfc771..4c644d4c6be7 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -226,10 +226,10 @@ d10 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		enter {
+		button-enter {
 			label = "Enter";
 			gpios = <&pioB 3 GPIO_ACTIVE_LOW>;
 			linux,code = <28>;
diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
index ddaadfec6751..a57351270551 100644
--- a/arch/arm/boot/dts/at91sam9rlek.dts
+++ b/arch/arm/boot/dts/at91sam9rlek.dts
@@ -248,17 +248,17 @@ led-3 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		right_click {
+		button-right-click {
 			label = "right_click";
 			gpios = <&pioB 0 GPIO_ACTIVE_LOW>;
 			linux,code = <273>;
 			wakeup-source;
 		};
 
-		left_click {
+		button-left-click {
 			label = "left_click";
 			gpios = <&pioB 1 GPIO_ACTIVE_LOW>;
 			linux,code = <272>;
-- 
2.34.1

