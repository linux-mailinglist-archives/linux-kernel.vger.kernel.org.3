Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B244F51D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiDFCVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345558AbiDEUV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 16:21:56 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1F64DF72;
        Tue,  5 Apr 2022 13:04:18 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1nbpPN-00CFJx-G5; Tue, 05 Apr 2022 20:04:09 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] imx8mm-venice-gw7901: move UART gpio config into hog group
Date:   Tue,  5 Apr 2022 13:04:07 -0700
Message-Id: <20220405200407.18698-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move UART related GPIO into hog group so that they still are pinmuxed
even if the uart driver is not probed.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../dts/freescale/imx8mm-venice-gw7901.dts    | 44 +++++++------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index 7e7231046215..ee78c189c556 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -710,7 +710,7 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>, <&pinctrl_uart1_gpio>;
+	pinctrl-0 = <&pinctrl_uart1>;
 	rts-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
 	cts-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 	dtr-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
@@ -728,7 +728,7 @@
 
 &uart3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>, <&pinctrl_uart3_gpio>;
+	pinctrl-0 = <&pinctrl_uart3>;
 	cts-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
 	rts-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
 	status = "okay";
@@ -736,7 +736,7 @@
 
 &uart4 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>, <&pinctrl_uart4_gpio>;
+	pinctrl-0 = <&pinctrl_uart4>;
 	cts-gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
 	rts-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
 	status = "okay";
@@ -807,6 +807,18 @@
 			MX8MM_IOMUXC_SAI3_RXD_GPIO4_IO30	0x40000041 /* SIM2DET# */
 			MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29	0x40000041 /* SIM1DET# */
 			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0x40000041 /* SIM2SEL */
+			MX8MM_IOMUXC_SAI3_TXFS_GPIO4_IO31	0x40000041 /* WDIS# */
+			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0	0x40000041 /* UART1_RS422# */
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x40000041 /* UART1_RS485# */
+			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5	0x40000041 /* UART1_RS232# */
+			MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6	0x40000110 /* UART3_RS232# */
+			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7	0x40000110 /* UART3_RS422# */
+			MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8	0x40000110 /* UART3_RS485# */
+
+			MX8MM_IOMUXC_ECSPI2_SCLK_GPIO5_IO10	0x40000041 /* UART4_RS232# */
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0x40000041 /* UART4_RS422# */
+			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27	0x40000041 /* UART4_RS485# */
+
 		>;
 	};
 
@@ -874,7 +886,6 @@
 
 	pinctrl_pcie0: pciegrp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_TXFS_GPIO4_IO31	0x40000041 /* WDIS# */
 			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2	0x41
 		>;
 	};
@@ -932,14 +943,6 @@
 		>;
 	};
 
-	pinctrl_uart1_gpio: uart1gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0	0x40000041 /* RS422# */
-			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x40000041 /* RS485# */
-			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5	0x40000041 /* RS232# */
-		>;
-	};
-
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
@@ -956,14 +959,6 @@
 		>;
 	};
 
-	pinctrl_uart3_gpio: uart3gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6	0x40000110 /* RS232# */
-			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7	0x40000110 /* RS422# */
-			MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8	0x40000110 /* RS485# */
-		>;
-	};
-
 	pinctrl_uart4: uart4grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX	0x140
@@ -973,15 +968,6 @@
 		>;
 	};
 
-	pinctrl_uart4_gpio: uart4gpiogrp {
-		fsl,pins = <
-
-			MX8MM_IOMUXC_ECSPI2_SCLK_GPIO5_IO10	0x40000041 /* RS232# */
-			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0x40000041 /* RS422# */
-			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27	0x40000041 /* RS485# */
-		>;
-	};
-
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
-- 
2.17.1

