Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A9C544A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbiFILlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243934AbiFILkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:40:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BED71DC87A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:39:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g25so402072ejh.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2YK4aOGXPvdxAtfO12AsDPl7t0FDoxm/SkPBiepibHg=;
        b=KMKQLQRumm6Q1e4E0PdHcDRh7TwDSA+IQPd1WQn2OTLPVNjN/a/e2P9GZ5NnASc4wy
         pmncb7He1aYMyvjeBcVdaiWbe6lwgJ5JPUAu2xqL71L9tnuhXEUGL37te2hvEJh9skbC
         abNCDn+8ds/53UjZUxMOSSKt6WvSHpq+y3Lbz+MT8FK8Nkgesl5mp/tI2YVm8XsBpYeQ
         IeehNW8uxrHgTk4Jw18cVrFBlcX+/l9fMMmHeyrObLnBNV1iEY4nr4wUIphbDw8Gxu54
         sLnTMfwhbO1C7068nBEzmt65s/WU7QUZwMwDzcLcvr2xSM1dwWbfw/si7S4apmjkajXx
         2e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2YK4aOGXPvdxAtfO12AsDPl7t0FDoxm/SkPBiepibHg=;
        b=KCHC9YGP2cMtz4vBNM3COTqpwtxfnBLCz7u/fymO16vba22K2K7779Ww29qNzmhXKc
         qD+hfUp+d0xbLfsqkgimkZYnXvsWzviTGjGendunIv0qUnhn+v47SzepNx6HBqZjUxtL
         io1ik6O8Oe4fnCei76VptRkoZ+WIqKT4nubYt+RdWU1jdU0C2GydSlVNRAq3/bebb7Uf
         X3MfjyYL2DqolL7fykp7IvdRjs7LVwlUqJz7ZIkXEt/LYnFH+hfqJNdtzXjeTpsQNv8V
         tIjKYUD/lS62nHZNRk8Zi+CkcHTipUBVe+nC01QIyDOHyDU8pBnxojzFz+a35+qSviBy
         KiBQ==
X-Gm-Message-State: AOAM530Vw7vSlg98oN7yoGfiJQS1KSQ2xIr52s9TZKnk4uaCzwE7t5RH
        ci5QxYTbrcSSa+mZC41raYRZ3w==
X-Google-Smtp-Source: ABdhPJx5qRAtf6/b/UlizFXqZYzrhENUs1tTXLTbzStSAmy5hf5tWbtLYY44EPGdoAi3Q3v6pDzzFw==
X-Received: by 2002:a17:906:4fd5:b0:6ff:2b0d:6031 with SMTP id i21-20020a1709064fd500b006ff2b0d6031mr35659008ejw.607.1654774787962;
        Thu, 09 Jun 2022 04:39:47 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906528a00b0070a80f03a44sm9460415ejm.119.2022.06.09.04.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:39:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 13/48] arm64: dts: freescale: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:39:32 +0200
Message-Id: <20220609113938.380466-4-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts       | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts | 6 +++---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi   | 8 ++++----
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts    | 8 ++++----
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts    | 8 ++++----
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts    | 6 +++---
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi          | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts | 6 +++---
 arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts    | 8 ++++----
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi          | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts   | 6 +++---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi         | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts         | 2 +-
 .../arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/mba8mx.dtsi                 | 6 +++---
 15 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
index d3f03dcbb8c3..aa38f5379558 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
@@ -35,14 +35,14 @@ buttons {
 		 * external power off (e.g ATX Power Button)
 		 * asserted
 		 */
-		powerdn {
+		button-powerdn {
 			label = "External Power Down";
 			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 		};
 
 		/* Rear Panel 'ADMIN' button (GPIO_H) */
-		admin {
+		button-admin {
 			label = "ADMIN button";
 			gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_WPS_BUTTON>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
index ac1fe1530ac7..d643381417f1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
@@ -36,19 +36,19 @@ reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		back {
+		key-back {
 			label = "Back";
 			gpios = <&pca9534 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_BACK>;
 		};
 
-		home {
+		key-home {
 			label = "Home";
 			gpios = <&pca9534 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 		};
 
-		menu {
+		key-menu {
 			label = "Menu";
 			gpios = <&pca9534 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_MENU>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
index 00f86cada30d..5bcd3b77fe83 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
@@ -16,13 +16,13 @@ memory@40000000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -36,14 +36,14 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index 24737e89038a..35fb929e7bcc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -38,13 +38,13 @@ memory@40000000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -58,14 +58,14 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index 407ab4592b4c..79107e287d92 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -42,13 +42,13 @@ can20m: can20m {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -62,14 +62,14 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
index a7dae9bd4c11..a65761a53f23 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
@@ -33,13 +33,13 @@ memory@40000000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -53,7 +53,7 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index eafa88d980b3..a8c329cb4c28 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -43,7 +43,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		wakeup {
+		key-wakeup {
 			debounce-interval = <10>;
 			/* Verdin CTRL_WAKE1_MICO# (SODIMM 252) */
 			gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
index f61c48776cf3..3ed7021a487c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
@@ -26,19 +26,19 @@ reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		back {
+		key-back {
 			label = "Back";
 			gpios = <&pca9534 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_BACK>;
 		};
 
-		home {
+		key-home {
 			label = "Home";
 			gpios = <&pca9534 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 		};
 
-		menu {
+		key-menu {
 			label = "Menu";
 			gpios = <&pca9534 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_MENU>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index 367a232675aa..636f8602b979 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -39,13 +39,13 @@ can20m: can20m {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -59,14 +59,14 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index fb17e329cd37..8c38f89df0ad 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -49,7 +49,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		wakeup {
+		button-wakeup {
 			debounce-interval = <10>;
 			/* Verdin CTRL_WAKE1_MICO# (SODIMM 252) */
 			gpios = <&gpio4 0 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index b86f188a440d..6445c6b90b5b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -36,21 +36,21 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		btn1 {
+		button-1 {
 			label = "VOL_UP";
 			gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
 			wakeup-source;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
-		btn2 {
+		button-2 {
 			label = "VOL_DOWN";
 			gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
 			wakeup-source;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
-		wwan-wake {
+		button-3 {
 			label = "WWAN_WAKE";
 			gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio3>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 587e55aaa57b..9eec8a7eecfc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -37,7 +37,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_keys>;
 
-		vol-down {
+		key-vol-down {
 			label = "VOL_DOWN";
 			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
@@ -45,7 +45,7 @@ vol-down {
 			wakeup-source;
 		};
 
-		vol-up {
+		key-vol-up {
 			label = "VOL_UP";
 			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
index f70fb32b96b0..54c739f293b8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
@@ -26,7 +26,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		power {
+		button-power {
 			label = "Power Button";
 			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
index 144fc9e82da7..c11fd1078bdb 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
@@ -16,7 +16,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpiokeys>;
 
-		wakeup {
+		key-wakeup {
 			label = "Wake-Up";
 			gpios = <&lsio_gpio3 10 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
index c2f0f1a1566c..aab1aee49893 100644
--- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
@@ -26,21 +26,21 @@ gpio-keys {
 		pinctrl-0 = <&pinctrl_gpiobutton>;
 		autorepeat;
 
-		switch1 {
+		switch-1 {
 			label = "switch1";
 			linux,code = <BTN_0>;
 			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 			wakeup-source;
 		};
 
-		btn2: switch2 {
+		btn2: switch-2 {
 			label = "switch2";
 			linux,code = <BTN_1>;
 			gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
 			wakeup-source;
 		};
 
-		switch3 {
+		switch-3 {
 			label = "switch3";
 			linux,code = <BTN_2>;
 			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
-- 
2.34.1

