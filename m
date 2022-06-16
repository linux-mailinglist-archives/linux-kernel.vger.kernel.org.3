Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594C254D66D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350785AbiFPAyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349324AbiFPAy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:54:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFC45716C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 184so12881646pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aDdUYcaJHmIBCldrTbWwdCdoUkU/OwtFBvf5ALsJlDY=;
        b=sXjKbVui6NwZmetIhbeiXzS+pohkADDQqHLI33bI+hYRGyOSW15MdL+KkeCsL/5dup
         Ah03DT/5dOhsmLTcBm18DCd7yBNUjH63HiHo790xtmAmCjP3IqP6wq7s1cMUkpnFLk6Z
         2pRab6425y+YPWCtbderylI/TepxyH+HXdcKel8FC8mZo77M4hj6iz5UXS67K/1KHPMq
         E7bmhEIIFQf8AlRzxddshhzI6jcfiRN3sqMcZgZV05YXCs0NGbFG2EvKiIg6oh130s8r
         /U8YrvINkaY+FVvbDUeGlaz112WejTOl3EfwDiZ4pLn+GqeqkOIrp8XmH0k9teGnIZyT
         xDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aDdUYcaJHmIBCldrTbWwdCdoUkU/OwtFBvf5ALsJlDY=;
        b=gsWGb0CVCWxvtAl7H83rpuDel4DALvodYTzkHZz2ZYz9GOHSdME6ikLzRhLOpiWAix
         q4QBFfuwg+sSIfYO+ZZfi+YK2ctn0D35+TRpiP3e9OMjUIVkDYUilNFxhhK13zjljY+f
         lzZp5I+gGxtXA0GjwoIsUl0OkJb/Z8/jDdP7rB3fkWyDnceZquKxlqevS+Q2QlVsyMAA
         m8IozINQPVxuMbu2QurJW8nZWJi79x8aHx3MZ0U2TnDzVzCMESQO/RPiulIdoHHBjBOV
         OEdNGx3l+d4PM/BYLprR6c1LnX9UVyQdQ1VcdkfJ9wOkC9cJ7A6+GUKY/AkC9v3Fp7xy
         2TDg==
X-Gm-Message-State: AJIora8F/B8ywE1ueYlndYhU/ROvu0S1UgDEoTZkKDPyF6+RloKVhlH9
        YBiuV7A0EsGNntXjGRMcZcE87g==
X-Google-Smtp-Source: AGRyM1sHDKDmy13z/kXZYWW+OKEwHF4YAqYGfULqML6sr34BLrtQZlBch9JibluSXyhsfOrJZG/pVQ==
X-Received: by 2002:a63:1d46:0:b0:3fd:df71:dac0 with SMTP id d6-20020a631d46000000b003fddf71dac0mr2219635pgm.258.1655340852795;
        Wed, 15 Jun 2022 17:54:12 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 13/40] ARM: dts: marvell: align gpio-key node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:06 -0700
Message-Id: <20220616005333.18491-13-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/armada-370-c200-v2.dts                 | 8 ++++----
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi       | 6 +++---
 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi | 6 +++---
 arch/arm/boot/dts/armada-381-netgear-gs110emx.dts        | 2 +-
 arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi           | 4 ++--
 arch/arm/boot/dts/armada-385-linksys.dtsi                | 4 ++--
 arch/arm/boot/dts/armada-388-clearfog-base.dts           | 2 +-
 arch/arm/boot/dts/armada-388-clearfog.dts                | 2 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts                | 4 ++--
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts            | 6 +++---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts         | 4 ++--
 11 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-c200-v2.dts b/arch/arm/boot/dts/armada-370-c200-v2.dts
index 1a4a09bdde63..84d40e1d70ef 100644
--- a/arch/arm/boot/dts/armada-370-c200-v2.dts
+++ b/arch/arm/boot/dts/armada-370-c200-v2.dts
@@ -75,25 +75,25 @@ keys {
 		pinctrl-0 = <&pmx_buttons>;
 		pinctrl-names = "default";
 
-		power {
+		button-power {
 			label = "Power Button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio0 10 GPIO_ACTIVE_HIGH>;
 		};
 
-		reset {
+		button-reset {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 		};
 
-		usb1 {
+		button-usb1 {
 			label = "USB1 Button";
 			linux,code = <BTN_0>;
 			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
 		};
 
-		usb2 {
+		button-usb2 {
 			label = "USB2 Button";
 			linux,code = <BTN_1>;
 			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index b52634ecf1d9..cf7bffdd1c21 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -111,19 +111,19 @@ gpio-keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		power {
+		button-power {
 			label = "Power button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
 			debounce-interval = <100>;
 		};
-		backup {
+		button-backup {
 			label = "Backup button";
 			linux,code = <KEY_OPTION>;
 			gpios = <&gpio0 31 GPIO_ACTIVE_LOW>;
 			debounce-interval = <100>;
 		};
-		reset {
+		button-reset {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index 0abac5ffe45a..6c33e3ba4ffb 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -86,19 +86,19 @@ gpio-keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		power {
+		button-power {
 			label = "Power button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
 			debounce-interval = <100>;
 		};
-		reset {
+		button-reset {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
 			debounce-interval = <100>;
 		};
-		button {
+		button-usb {
 			label = "USB VBUS error";
 			linux,code = <KEY_UNKNOWN>;
 			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-381-netgear-gs110emx.dts b/arch/arm/boot/dts/armada-381-netgear-gs110emx.dts
index 396172067f6a..095df5567c93 100644
--- a/arch/arm/boot/dts/armada-381-netgear-gs110emx.dts
+++ b/arch/arm/boot/dts/armada-381-netgear-gs110emx.dts
@@ -24,7 +24,7 @@ gpio-keys {
 		pinctrl-0 = <&front_button_pins>;
 		pinctrl-names = "default";
 
-		factory_default {
+		key-factory-default {
 			label = "Factory Default";
 			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_RESTART>;
diff --git a/arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi b/arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi
index 10ad46f29393..d1452a04e904 100644
--- a/arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi
+++ b/arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi
@@ -256,14 +256,14 @@ gpio-keys {
 		pinctrl-0 = <&cf_gtr_rear_button_pins &cf_gtr_front_button_pins>;
 		pinctrl-names = "default";
 
-		button_0 {
+		button-0 {
 			label = "Rear Button";
 			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 			linux,can-disable;
 			linux,code = <BTN_0>;
 		};
 
-		button_1 {
+		button-1 {
 			label = "Front Button";
 			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
 			linux,can-disable;
diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index fb9c8a0b241c..116aca5e688f 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -53,13 +53,13 @@ gpio_keys: gpio-keys {
 		pinctrl-0 = <&gpio_keys_pins>;
 		pinctrl-names = "default";
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
 		};
 
-		reset {
+		button-reset {
 			label = "Factory Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-388-clearfog-base.dts b/arch/arm/boot/dts/armada-388-clearfog-base.dts
index 53b4bd35522a..f7daa3bc707e 100644
--- a/arch/arm/boot/dts/armada-388-clearfog-base.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog-base.dts
@@ -19,7 +19,7 @@ gpio-keys {
 		pinctrl-0 = <&rear_button_pins>;
 		pinctrl-names = "default";
 
-		button_0 {
+		button-0 {
 			/* The rear SW3 button */
 			label = "Rear Button";
 			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index 4140a5303b48..95299167dcf5 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -35,7 +35,7 @@ gpio-keys {
 		pinctrl-0 = <&rear_button_pins>;
 		pinctrl-names = "default";
 
-		button_0 {
+		button-0 {
 			/* The rear SW3 button */
 			label = "Rear Button";
 			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index 3e77b4337802..86a0ad9bd5cc 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -69,14 +69,14 @@ ethernet@74000 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		pinctrl-0 = <&keys_pin>;
 		pinctrl-names = "default";
 
-		reset {
+		button-reset {
 			label = "Factory Reset Button";
 			linux,code = <KEY_SETUP>;
 			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 36932e3b781a..51b2eb8bb4fd 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -172,20 +172,20 @@ bm-bppi {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		pinctrl-0 = <&keys_pin>;
 		pinctrl-names = "default";
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
 		};
 
-		reset {
+		button-reset {
 			label = "Factory Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 0efcc166dabf..ff698d6ebb87 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -97,12 +97,12 @@ green_led {
 				};
 			};
 
-			gpio_keys {
+			gpio-keys {
 				compatible = "gpio-keys";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				init {
+				button-init {
 					label = "Init Button";
 					linux,code = <KEY_POWER>;
 					gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-- 
2.34.1

