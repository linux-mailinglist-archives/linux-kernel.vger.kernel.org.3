Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482E3571196
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 06:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiGLEzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 00:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGLEzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:55:38 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B034B85F95;
        Mon, 11 Jul 2022 21:55:35 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f11so5701709pgj.7;
        Mon, 11 Jul 2022 21:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77BUSe2BkrJUgvgUa+mDPJmO1iOtAHRgAhKgQ/Q+1Xg=;
        b=kYPw7JJdDkYTIcgyAXE7tOFEHJqnp4vD3CGyhIeFaXyStFFB6oQyG6pvz0+S0xf0uC
         sRfjnEBlg+BPfMvtX372P7XdZQ8ofZpKCR30GzmnPY3UoZ01UPrX+9rXmC/fw5ybgRmt
         rLwuGSRX2RPjSmDytA1wQVM4kk2Jo4gl+a0p8HHdEeCzrFTdsHKk+a8Lac5TOGB3gCFL
         v7XxloPvtxtcwhMYFWl0Osuh8pwZtPRTTVyTRLAENtQgEGSIyiFTxfo1g0JRoVCpUwit
         I/cY5u3Ed9Enpg5T3VmSp/9FD9ReoigzZ6gdHwHAUQ8K219W8IduodlttgKUqGdwX5U+
         08FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77BUSe2BkrJUgvgUa+mDPJmO1iOtAHRgAhKgQ/Q+1Xg=;
        b=D990rDqwJOYHiTpIVaB8E9XnMoKf3VAiNk+U51wejpdk43o5ZCd83JXDH8CDDLUd+P
         51IFshuLeBihvwFl2TRX9Dt6NHFQ1sJX4HGd1DTuyjEmussg6ceFGMLZuSuBhLvQVu4D
         uHSQiiDaFj+z1nQ8f6kvYX7OudDvHVo78ZbQKuHjbriDPTryiH+LnGqrAeXEdozOrBEd
         YbT5DA9YytAT4kJ9FpDsZePZw0chhoRAiaH0FCJn78m35rVaglku7EDtagfEa7nU4f5d
         9hIud4nlt5UGEwez0BcksNHHG0DVbiy+Duy0Y1U3llDv5inLH3k0UQlz2D1YLhqXvW8H
         ZCKA==
X-Gm-Message-State: AJIora9/aqBfW3v2z1ZFSBHu2fgXIrOWICAgaFpCHiyhiVzO+/3XedoC
        NeB+fEemnJSDFjfize9F6jY=
X-Google-Smtp-Source: AGRyM1sQf+oXA3S+ukzsL4R87qHBPz3J0rydgsyZmKMuaVCqv9OKWGoudVYBFLDIyZWLM/C7xz/wWw==
X-Received: by 2002:a05:6a00:170a:b0:52a:d3d4:3852 with SMTP id h10-20020a056a00170a00b0052ad3d43852mr7727970pfc.19.1657601735091;
        Mon, 11 Jul 2022 21:55:35 -0700 (PDT)
Received: from debian.moxa.com ([123.51.145.104])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b0016be0d5483asm5664677plh.252.2022.07.11.21.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 21:55:34 -0700 (PDT)
From:   Jimmy Chen <u7702045@gmail.com>
X-Google-Original-From: Jimmy Chen <jimmy.chen@moxa.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Jimmy Chen <jimmy.chen@moxa.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ARM: dts: imx7d: fixed dts for UC-8210/8220 hardware
Date:   Tue, 12 Jul 2022 12:55:04 +0800
Message-Id: <20220712045505.4500-3-jimmy.chen@moxa.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220712045505.4500-1-jimmy.chen@moxa.com>
References: <20220712045505.4500-1-jimmy.chen@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix compatible string reference to fsl.yaml
change regulator node name
replace underscore to dash
replace node name
remove 'status' attribute from node
add board compatible and model to ixm7d-moxa-uc-8210.dts
rearrange 82XX alphabet order in Makefile

Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
---
 arch/arm/boot/dts/Makefile               |  4 +--
 arch/arm/boot/dts/imx7d-moxa-uc-8210.dts | 46 +++++++++++-------------
 arch/arm/boot/dts/imx7d-moxa-uc-8220.dts |  9 +++--
 3 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37db3b60ba43..c9c57626876c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -747,6 +747,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-flex-concentrator-mfg.dtb \
 	imx7d-mba7.dtb \
 	imx7d-meerkat96.dtb \
+	imx7d-moxa-uc-8210.dtb \
+	imx7d-moxa-uc-8220.dtb \
 	imx7d-nitrogen7.dtb \
 	imx7d-pico-dwarf.dtb \
 	imx7d-pico-hobbit.dtb \
@@ -755,8 +757,6 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-remarkable2.dtb \
 	imx7d-sbc-imx7.dtb \
 	imx7d-sdb.dtb \
-	imx7d-moxa-uc-8210.dtb \
-	imx7d-moxa-uc-8220.dtb \
 	imx7d-sdb-reva.dtb \
 	imx7d-sdb-sht11.dtb \
 	imx7d-smegw01.dtb \
diff --git a/arch/arm/boot/dts/imx7d-moxa-uc-8210.dts b/arch/arm/boot/dts/imx7d-moxa-uc-8210.dts
index 9ec62d8b510d..fc5a0c7ff295 100644
--- a/arch/arm/boot/dts/imx7d-moxa-uc-8210.dts
+++ b/arch/arm/boot/dts/imx7d-moxa-uc-8210.dts
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+ OR MIT
- * Copyright (C) 2022 MOXA Inc. - https://www.moxa.com/
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/* Copyright (C) MOXA Inc. All rights reserved.
  * Authors: TungYu TY Yang <TungyuTY.Yang@moxa.com>
  */
 
@@ -9,7 +9,7 @@
 
 / {
 	model = "Moxa UC-8210";
-	compatible = "moxa,uc-8210", "fsl,imx7d-sdb", "fsl,imx7d";
+	compatible = "moxa,uc-8210", "fsl,imx7d";
 
 	chosen {
 		stdout-path = &uart1;
@@ -56,7 +56,7 @@
 		startup-delay-us = <100>;
 	};
 
-	reg_sd1_vmmc: regulator@5 {
+	reg_sd1_vmmc: regulator-sd1-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_SD1";
 		regulator-min-microvolt = <3300000>;
@@ -79,58 +79,58 @@
 
 	leds {
 		compatible = "gpio-leds";
-		signal_led_1_1 {
+		signal-led-1-1 {
 			label = "UC8200:YELLOW:SGN1-1";
 			gpios = <&i2cgpio2 4 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		signal_led_1_2 {
+		signal-led-1-2 {
 			label = "UC8200:YELLOW:SGN1-2";
 			gpios = <&i2cgpio2 5 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		signal_led_1_3 {
+		signal-led-1-3 {
 			label = "UC8200:YELLOW:SGN1-3";
 			gpios = <&i2cgpio2 12 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		signal_led_2_1 {
+		signal-led-2-1 {
 			label = "UC8200:YELLOW:SGN2-1";
 			gpios = <&i2cgpio2 13 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		signal_led_2_2 {
+		signal-led-2-2 {
 			label = "UC8200:YELLOW:SGN2-2";
 			gpios = <&i2cgpio2 14 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		signal_led_2_3 {
+		signal-led-2-3 {
 			label = "UC8200:YELLOW:SGN2-3";
 			gpios = <&i2cgpio2 15 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		user_led_1_1 {
+		user-led-1-1 {
 			label = "UC8200:YELLOW:USR";
 			gpios = <&i2cgpio1 9 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-		user_led_1_2 {
+		user-led-1-2 {
 			label = "UC8200:GREEN:USR";
 			gpios = <&i2cgpio1 10 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 	};
 
-	buttons: push_button {
+	buttons: gpio-keys {
 		compatible = "gpio-keys";
 
-		push_button0 {
+		button {
 			label = "Reset key";
 			gpios = <&gpio5 11 1>;
 			linux,code = <0x100>;
@@ -164,7 +164,7 @@
 	cs-gpios = <&gpio4 19 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 
-	tpm_spi_tis@0{
+	tpm-spi-tis@0 {
 		compatible = "tcg,tpm_tis-spi";
 		reg = <0>;
 		spi-max-frequency = <500000>;
@@ -344,7 +344,6 @@
 	rtc@68 {
 		compatible = "dallas,ds1374";
 		reg = <0x68>;
-		status = "okay";
 	};
 };
 
@@ -395,9 +394,6 @@
 	pinctrl-0 = <&pinctrl_uart5>;
 	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
 	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
-	/* for DTE mode, add below change */
-	/* fsl,dte-mode; */
-	/* pinctrl-0 = <&pinctrl_uart5dte>; */
 	status = "okay";
 };
 
@@ -465,7 +461,7 @@
 	status = "okay";
 
 	flash0: mx25l12805d@0 {
-		compatible = "macronix,mx25l12805d";
+		compatible = "mxicy,mx25l12805d", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 		partitions {
@@ -584,7 +580,7 @@
 			>;
 		};
 
-		pinctrl_gpio_keys: gpio_keysgrp {
+		pinctrl_gpio_keys: gpio-keysgrp {
 			fsl,pins = <
 				MX7D_PAD_SD2_RESET_B__GPIO5_IO11	0x59
 				MX7D_PAD_SD2_WP__GPIO5_IO10		0x59
@@ -729,7 +725,7 @@
 			>;
 		};
 
-		pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
+		pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
 			fsl,pins = <
 				MX7D_PAD_SD1_CMD__SD1_CMD		0x5a
 				MX7D_PAD_SD1_CLK__SD1_CLK		0x1a
@@ -771,7 +767,7 @@
 			>;
 		};
 
-		pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {
+		pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 			fsl,pins = <
 				MX7D_PAD_SD2_CMD__SD2_CMD		0x5a
 				MX7D_PAD_SD2_CLK__SD2_CLK		0x1a
@@ -810,7 +806,7 @@
 			>;
 		};
 
-		pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
+		pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
 			fsl,pins = <
 				MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
 				MX7D_PAD_SD3_CLK__SD3_CLK		0x1a
@@ -863,6 +859,4 @@
 			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B		0x74
 		>;
 	};
-
-
 };
diff --git a/arch/arm/boot/dts/imx7d-moxa-uc-8220.dts b/arch/arm/boot/dts/imx7d-moxa-uc-8220.dts
index 6a41cd9e13c6..e66accceeb82 100644
--- a/arch/arm/boot/dts/imx7d-moxa-uc-8220.dts
+++ b/arch/arm/boot/dts/imx7d-moxa-uc-8220.dts
@@ -1,11 +1,16 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Copyright (C) 2019 MOXA Inc. - https://www.moxa.com/
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/* Copyright (C) MOXA Inc. All rights reserved.
  * Authors: Fero JD Zhou (周俊達) <FeroJD.Zhou@moxa.com>
  *	    Harry YJ Jhou (周亞諄) <HarryYJ.Jhou@moxa.com>
  */
 
 #include "imx7d-moxa-uc-8210.dts"
 
+/ {
+	model = "Moxa UC-8220";
+	compatible = "moxa,uc-8220", "fsl,imx7d";
+};
+
 &pcie_phy{
 	status = "okay";
 };
-- 
2.20.1

