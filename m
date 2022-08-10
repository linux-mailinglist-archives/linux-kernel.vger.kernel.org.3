Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91B58EAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiHJLKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiHJLKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:10:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F43417A96
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:10:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z6so13295689lfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/jFMrqK/gFjo9utwNvvS8CKEH3Q/IPlq73x1Lk1uAuU=;
        b=S8bQ/C7VdxKroX2vYzhPTsMlvjMaH9qR5/1XBZstTLS42bwjzduTdo9/XXBmf9EqSX
         iYIWh1v4iCNVMWIubcGp3KgsBT0kDZ7tR1B/jtafLWHqpIqzYAD30NihV0v0jlIW5v86
         vcImNxGDN6jZhcWOavRlqbDtr4UinO8z1HmPeH6ao9ZAH1cC/6ZNlrZz5CJP50fCU4nH
         CATm1TMGuEyHKEoP/WyQ9okavbqkHkR/+BxkaMsaa7EhvNCUafFtXno9bBtrNeWcLRGy
         8OK5De6U1Ec1AaI69jPWU0UTzWDfbxZQssXHxP2t13bcJSUJzO8hyicD2BnYN0RS/PMo
         Z9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/jFMrqK/gFjo9utwNvvS8CKEH3Q/IPlq73x1Lk1uAuU=;
        b=MNv1L0VtoLVtDHlgPVv+hoHxu50HM9viHcoNWZ/oHH83ZhwvzhArpG+omi0H0kwR2P
         gtHRcXv4LRpnf2+qLnHQqUADsNaryqWl9/pDB/3lW0j/ussBznKl9yz7BxTjh8XZW0gW
         RdmxY0bCMoaMFMOEwNmxLqoe88zb3KqNKMKDetUMn8ZdCoPKIKdbsKVLj6m3q4Lw0Zed
         bUXz4/dnnzfWOwiRlFhXe6XIja1CIKfs7TGZn08biGwe+Q7azcVuVE8gQJvlvcQMaVDB
         ECMzYcKNn5T8WSbhSUIFChLbiiJfYPmNQIM9Xrds68PNwsVHfxK+P7dqYQj5gaJvz53D
         WDfw==
X-Gm-Message-State: ACgBeo1JTVQWYL8RgyW2WGfb5fxfx/tUwSgzcWeVQ5XhdM1RoDhc/0Tp
        AcUQyDIqqr8IqOhx0TmTdSeBxw==
X-Google-Smtp-Source: AA6agR4yVCDlkMVV4t1Wg5iEfDK830LiY+ZO1wLbVchqusDK88/Porj+iDW9LwCWXzwlRLGYrIycbw==
X-Received: by 2002:a19:740c:0:b0:48b:374:987a with SMTP id v12-20020a19740c000000b0048b0374987amr9736830lfe.690.1660129814837;
        Wed, 10 Aug 2022 04:10:14 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id u17-20020ac243d1000000b0048b0975ac7asm301425lfl.151.2022.08.10.04.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:10:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ARM: dts: imx: align gpio-keys node names with dtschema
Date:   Wed, 10 Aug 2022 14:10:08 +0300
Message-Id: <20220810111008.280850-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220810111008.280850-1-krzysztof.kozlowski@linaro.org>
References: <20220810111008.280850-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/imx23-xfi3.dts              |  6 ++--
 .../dts/imx25-eukrea-mbimxsd25-baseboard.dts  |  4 +--
 arch/arm/boot/dts/imx28-cfa10049.dts          |  4 +--
 .../arm/boot/dts/imx28-duckbill-2-enocean.dts |  2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi  |  8 ++---
 .../dts/imx35-eukrea-mbimxsd35-baseboard.dts  |  4 +--
 arch/arm/boot/dts/imx50-kobo-aura.dts         |  6 ++--
 arch/arm/boot/dts/imx51-babbage.dts           |  2 +-
 arch/arm/boot/dts/imx53-ard.dts               | 10 +++---
 arch/arm/boot/dts/imx53-qsb-common.dtsi       |  6 ++--
 arch/arm/boot/dts/imx53-smd.dts               |  4 +--
 arch/arm/boot/dts/imx53-tx53.dtsi             |  2 +-
 arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi |  8 ++---
 arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi         |  2 +-
 arch/arm/boot/dts/imx6dl-prtmvt.dts           | 32 +++++++++----------
 arch/arm/boot/dts/imx6dl-prtvt7.dts           | 30 ++++++++---------
 arch/arm/boot/dts/imx6dl-victgo.dts           |  4 +--
 arch/arm/boot/dts/imx6q-novena.dts            |  2 +-
 arch/arm/boot/dts/imx6q-pistachio.dts         |  2 +-
 arch/arm/boot/dts/imx6q-utilite-pro.dts       |  2 +-
 .../arm/boot/dts/imx6q-var-dt6customboard.dts |  6 ++--
 arch/arm/boot/dts/imx7d-sdb.dts               |  4 +--
 22 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-xfi3.dts b/arch/arm/boot/dts/imx23-xfi3.dts
index a6213c590f94..b1d8210f3ecc 100644
--- a/arch/arm/boot/dts/imx23-xfi3.dts
+++ b/arch/arm/boot/dts/imx23-xfi3.dts
@@ -158,19 +158,19 @@ backlight {
 		default-brightness-level = <6>;
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&key_pins_a>;
 
-		voldown {
+		key-voldown {
 			label = "volume-down";
 			linux,code = <114>;
 			gpios = <&gpio2 7 0>;
 			debounce-interval = <20>;
 		};
 
-		volup {
+		key-volup {
 			label = "volume-up";
 			linux,code = <115>;
 			gpios = <&gpio2 8 0>;
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
index 3f38c2e60a74..c7207ea437c4 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
@@ -13,12 +13,12 @@ / {
 	model = "Eukrea MBIMXSD25";
 	compatible = "eukrea,mbimxsd25-baseboard", "eukrea,cpuimx25", "fsl,imx25";
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpiokeys>;
 
-		bp1 {
+		button {
 			label = "BP1";
 			gpios = <&gpio3 18 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_MISC>;
diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index ff1b450c0717..9ef0d567ea48 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -388,12 +388,12 @@ dac0: dh2228@2 {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&rotary_btn_pins_cfa10049>;
 
-		rotary_button {
+		rotary-button {
 			label = "rotary_button";
 			gpios = <&gpio3 26 1>;
 			debounce-interval = <10>;
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts b/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
index bacb846f99e3..73f521c46c1e 100644
--- a/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
+++ b/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
@@ -204,7 +204,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&enocean_button>;
 
-		enocean {
+		key-enocean {
 			label = "EnOcean";
 			linux,code = <KEY_NEW>;
 			gpios = <&gpio3 3 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi b/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
index 3280fddaaf0d..b285a946e2c2 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
@@ -19,12 +19,12 @@ backlight {
 		default-brightness-level = <10>;
 	};
 
-	button-sw3 {
+	gpio-keys-0 {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_button_sw3_pins_mbmx28lc>;
 
-		sw3 {
+		switch-sw3 {
 			label = "SW3";
 			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_MISC>;
@@ -32,12 +32,12 @@ sw3 {
 		};
 	};
 
-	button-sw4 {
+	gpio-keys-1 {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_button_sw4_pins_mbmx28lc>;
 
-		sw4 {
+		switch-sw4 {
 			label = "SW4";
 			gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_MISC>;
diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
index b1c11170ac25..7f4f812b0811 100644
--- a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
@@ -13,12 +13,12 @@ / {
 	model = "Eukrea CPUIMX35";
 	compatible = "eukrea,mbimxsd35-baseboard", "eukrea,cpuimx35", "fsl,imx35";
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_bp1>;
 
-		bp1 {
+		button {
 			label = "BP1";
 			gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_MISC>;
diff --git a/arch/arm/boot/dts/imx50-kobo-aura.dts b/arch/arm/boot/dts/imx50-kobo-aura.dts
index 82ce8c43be86..51bf6117fb12 100644
--- a/arch/arm/boot/dts/imx50-kobo-aura.dts
+++ b/arch/arm/boot/dts/imx50-kobo-aura.dts
@@ -38,20 +38,20 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpiokeys>;
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 		};
 
-		hallsensor {
+		event-hallsensor {
 			label = "Hallsensor";
 			gpios = <&gpio5 15 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_RESERVED>;
 			linux,input-type = <EV_SW>;
 		};
 
-		frontlight {
+		event-frontlight {
 			label = "Frontlight";
 			gpios = <&gpio4 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_DISPLAYTOGGLE>;
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 552196d8a60a..a1f9c6a72275 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -154,7 +154,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index 6208fbb2e741..23a7492e2929 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -61,34 +61,34 @@ reg_3p3v: regulator@0 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		home {
+		key-home {
 			label = "Home";
 			gpios = <&gpio5 10 0>;
 			linux,code = <KEY_HOME>;
 			wakeup-source;
 		};
 
-		back {
+		key-back {
 			label = "Back";
 			gpios = <&gpio5 11 0>;
 			linux,code = <KEY_BACK>;
 			wakeup-source;
 		};
 
-		program {
+		key-program {
 			label = "Program";
 			gpios = <&gpio5 12 0>;
 			linux,code = <KEY_PROGRAM >;
 			wakeup-source;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio5 13 0>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio4 0 0>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index d6a87c0c2934..50fef8dd3675 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -45,20 +45,20 @@ display_out: endpoint {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 			wakeup-source;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 9be44e807188..f8d17967a67e 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -19,13 +19,13 @@ memory@70000000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio2 14 0>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio2 15 0>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 8712e9851465..892dd1a4bac3 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -81,7 +81,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_key>;
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
 			linux,code = <116>; /* KEY_POWER */
diff --git a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
index d9de9b4f0c52..d477a937b47a 100644
--- a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
+++ b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
@@ -6,7 +6,7 @@ / {
 	keyboard {
 		compatible = "gpio-keys";
 
-		btn0 {
+		button-0 {
 			gpios = <&pcf8575 0 GPIO_ACTIVE_LOW>;
 			label = "btn0";
 			linux,code = <KEY_WAKEUP>;
@@ -14,7 +14,7 @@ btn0 {
 			wakeup-source;
 		};
 
-		btn1 {
+		button-1 {
 			gpios = <&pcf8575 1 GPIO_ACTIVE_LOW>;
 			label = "btn1";
 			linux,code = <KEY_WAKEUP>;
@@ -22,7 +22,7 @@ btn1 {
 			wakeup-source;
 		};
 
-		btn2 {
+		button-2 {
 			gpios = <&pcf8575 2 GPIO_ACTIVE_LOW>;
 			label = "btn2";
 			linux,code = <KEY_WAKEUP>;
@@ -30,7 +30,7 @@ btn2 {
 			wakeup-source;
 		};
 
-		btn3 {
+		button-3 {
 			gpios = <&pcf8575 3 GPIO_ACTIVE_LOW>;
 			label = "btn3";
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi b/arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi
index ec5b66453156..337db29b0010 100644
--- a/arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi
+++ b/arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi
@@ -188,7 +188,7 @@ power-button {
 	rotary-encoder-key {
 		compatible = "gpio-keys";
 
-		rotary-encoder-press {
+		rotary-encoder-event {
 			label = "rotary-encoder press";
 			gpios = <&tca6424a 0 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_ENTER>;
diff --git a/arch/arm/boot/dts/imx6dl-prtmvt.dts b/arch/arm/boot/dts/imx6dl-prtmvt.dts
index a35a1c66e770..1f8cddd83ccb 100644
--- a/arch/arm/boot/dts/imx6dl-prtmvt.dts
+++ b/arch/arm/boot/dts/imx6dl-prtmvt.dts
@@ -51,98 +51,98 @@ gpio-keys {
 		pinctrl-0 = <&pinctrl_gpiokeys>;
 		autorepeat;
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			wakeup-source;
 		};
 
-		f1 {
+		key-f1 {
 			label = "GPIO Key F1";
 			linux,code = <KEY_F1>;
 			gpios = <&gpio_pca 0 GPIO_ACTIVE_LOW>;
 		};
 
-		f2 {
+		key-f2 {
 			label = "GPIO Key F2";
 			linux,code = <KEY_F2>;
 			gpios = <&gpio_pca 1 GPIO_ACTIVE_LOW>;
 		};
 
-		f3 {
+		key-f3 {
 			label = "GPIO Key F3";
 			linux,code = <KEY_F3>;
 			gpios = <&gpio_pca 2 GPIO_ACTIVE_LOW>;
 		};
 
-		f4 {
+		key-f4 {
 			label = "GPIO Key F4";
 			linux,code = <KEY_F4>;
 			gpios = <&gpio_pca 3 GPIO_ACTIVE_LOW>;
 		};
 
-		f5 {
+		key-f5 {
 			label = "GPIO Key F5";
 			linux,code = <KEY_F5>;
 			gpios = <&gpio_pca 4 GPIO_ACTIVE_LOW>;
 		};
 
-		cycle {
+		key-cycle {
 			label = "GPIO Key CYCLE";
 			linux,code = <KEY_CYCLEWINDOWS>;
 			gpios = <&gpio_pca 5 GPIO_ACTIVE_LOW>;
 		};
 
-		esc {
+		key-esc {
 			label = "GPIO Key ESC";
 			linux,code = <KEY_ESC>;
 			gpios = <&gpio_pca 6 GPIO_ACTIVE_LOW>;
 		};
 
-		up {
+		key-up {
 			label = "GPIO Key UP";
 			linux,code = <KEY_UP>;
 			gpios = <&gpio_pca 7 GPIO_ACTIVE_LOW>;
 		};
 
-		down {
+		key-down {
 			label = "GPIO Key DOWN";
 			linux,code = <KEY_DOWN>;
 			gpios = <&gpio_pca 8 GPIO_ACTIVE_LOW>;
 		};
 
-		ok {
+		key-ok {
 			label = "GPIO Key OK";
 			linux,code = <KEY_OK>;
 			gpios = <&gpio_pca 9 GPIO_ACTIVE_LOW>;
 		};
 
-		f6 {
+		key-f6 {
 			label = "GPIO Key F6";
 			linux,code = <KEY_F6>;
 			gpios = <&gpio_pca 10 GPIO_ACTIVE_LOW>;
 		};
 
-		f7 {
+		key-f7 {
 			label = "GPIO Key F7";
 			linux,code = <KEY_F7>;
 			gpios = <&gpio_pca 11 GPIO_ACTIVE_LOW>;
 		};
 
-		f8 {
+		key-f8 {
 			label = "GPIO Key F8";
 			linux,code = <KEY_F8>;
 			gpios = <&gpio_pca 12 GPIO_ACTIVE_LOW>;
 		};
 
-		f9 {
+		key-f9 {
 			label = "GPIO Key F9";
 			linux,code = <KEY_F9>;
 			gpios = <&gpio_pca 13 GPIO_ACTIVE_LOW>;
 		};
 
-		f10 {
+		key-f10 {
 			label = "GPIO Key F10";
 			linux,code = <KEY_F10>;
 			gpios = <&gpio_pca 14 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/imx6dl-prtvt7.dts b/arch/arm/boot/dts/imx6dl-prtvt7.dts
index 0a0b7acddfb2..a1eb53851794 100644
--- a/arch/arm/boot/dts/imx6dl-prtvt7.dts
+++ b/arch/arm/boot/dts/imx6dl-prtvt7.dts
@@ -62,91 +62,91 @@ keys {
 		compatible = "gpio-keys";
 		autorepeat;
 
-		esc {
+		key-esc {
 			label = "GPIO Key ESC";
 			linux,code = <KEY_ESC>;
 			gpios = <&gpio_pca 0 GPIO_ACTIVE_LOW>;
 		};
 
-		up {
+		key-up {
 			label = "GPIO Key UP";
 			linux,code = <KEY_UP>;
 			gpios = <&gpio_pca 1 GPIO_ACTIVE_LOW>;
 		};
 
-		down {
+		key-down {
 			label = "GPIO Key DOWN";
 			linux,code = <KEY_DOWN>;
 			gpios = <&gpio_pca 4 GPIO_ACTIVE_LOW>;
 		};
 
-		enter {
+		key-enter {
 			label = "GPIO Key Enter";
 			linux,code = <KEY_ENTER>;
 			gpios = <&gpio_pca 3 GPIO_ACTIVE_LOW>;
 		};
 
-		cycle {
+		key-cycle {
 			label = "GPIO Key CYCLE";
 			linux,code = <KEY_CYCLEWINDOWS>;
 			gpios = <&gpio_pca 2 GPIO_ACTIVE_LOW>;
 		};
 
-		f1 {
+		key-f1 {
 			label = "GPIO Key F1";
 			linux,code = <KEY_F1>;
 			gpios = <&gpio_pca 14 GPIO_ACTIVE_LOW>;
 		};
 
-		f2 {
+		key-f2 {
 			label = "GPIO Key F2";
 			linux,code = <KEY_F2>;
 			gpios = <&gpio_pca 13 GPIO_ACTIVE_LOW>;
 		};
 
-		f3 {
+		key-f3 {
 			label = "GPIO Key F3";
 			linux,code = <KEY_F3>;
 			gpios = <&gpio_pca 12 GPIO_ACTIVE_LOW>;
 		};
 
-		f4 {
+		key-f4 {
 			label = "GPIO Key F4";
 			linux,code = <KEY_F4>;
 			gpios = <&gpio_pca 11 GPIO_ACTIVE_LOW>;
 		};
 
-		f5 {
+		key-f5 {
 			label = "GPIO Key F5";
 			linux,code = <KEY_F5>;
 			gpios = <&gpio_pca 10 GPIO_ACTIVE_LOW>;
 		};
 
-		f6 {
+		key-f6 {
 			label = "GPIO Key F6";
 			linux,code = <KEY_F6>;
 			gpios = <&gpio_pca 5 GPIO_ACTIVE_LOW>;
 		};
 
-		f7 {
+		key-f7 {
 			label = "GPIO Key F7";
 			linux,code = <KEY_F7>;
 			gpios = <&gpio_pca 6 GPIO_ACTIVE_LOW>;
 		};
 
-		f8 {
+		key-f8 {
 			label = "GPIO Key F8";
 			linux,code = <KEY_F8>;
 			gpios = <&gpio_pca 7 GPIO_ACTIVE_LOW>;
 		};
 
-		f9 {
+		key-f9 {
 			label = "GPIO Key F9";
 			linux,code = <KEY_F9>;
 			gpios = <&gpio_pca 8 GPIO_ACTIVE_LOW>;
 		};
 
-		f10 {
+		key-f10 {
 			label = "GPIO Key F10";
 			linux,code = <KEY_F10>;
 			gpios = <&gpio_pca 9 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/imx6dl-victgo.dts b/arch/arm/boot/dts/imx6dl-victgo.dts
index 779b52858a25..72df1dba83be 100644
--- a/arch/arm/boot/dts/imx6dl-victgo.dts
+++ b/arch/arm/boot/dts/imx6dl-victgo.dts
@@ -18,14 +18,14 @@ gpio-keys {
 		pinctrl-0 = <&pinctrl_gpiokeys>;
 		autorepeat;
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			wakeup-source;
 		};
 
-		enter {
+		key-enter {
 			label = "Rotary Key";
 			gpios = <&gpio2 05 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_ENTER>;
diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index f8a8dd3e069f..ee8c0bd3ecfd 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -86,7 +86,7 @@ user-button {
 			linux,code = <KEY_POWER>;
 		};
 
-		lid {
+		lid-event {
 			label = "Lid";
 			gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
 			linux,input-type = <5>;	/* EV_SW */
diff --git a/arch/arm/boot/dts/imx6q-pistachio.dts b/arch/arm/boot/dts/imx6q-pistachio.dts
index 7a33e54cc0f1..bad8d831e64e 100644
--- a/arch/arm/boot/dts/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/imx6q-pistachio.dts
@@ -100,7 +100,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
 			wakeup-source;
diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/imx6q-utilite-pro.dts
index d16ff2083d62..ad59b23ef27a 100644
--- a/arch/arm/boot/dts/imx6q-utilite-pro.dts
+++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
@@ -89,7 +89,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/imx6q-var-dt6customboard.dts b/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
index 63550351340d..2290c1237634 100644
--- a/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
+++ b/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
@@ -28,7 +28,7 @@ gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
 
-		back {
+		key-back {
 			gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_BACK>;
 			label = "Key Back";
@@ -37,7 +37,7 @@ back {
 			wakeup-source;
 		};
 
-		home {
+		key-home {
 			gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 			label = "Key Home";
@@ -46,7 +46,7 @@ home {
 			wakeup-source;
 		};
 
-		menu {
+		key-menu {
 			gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_MENU>;
 			label = "Key Menu";
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 7eadd7617943..04c2dd5ea5cf 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -24,14 +24,14 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 			wakeup-source;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
-- 
2.34.1

