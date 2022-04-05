Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9411D4F51D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1847381AbiDFCR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345974AbiDEUWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 16:22:01 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99976D4EC;
        Tue,  5 Apr 2022 13:04:45 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1nbpPp-00CFKI-Ep; Tue, 05 Apr 2022 20:04:37 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] imx8mm-venice-gw7902: move UART gpio config into hog group
Date:   Tue,  5 Apr 2022 13:04:35 -0700
Message-Id: <20220405200435.18797-1-tharvey@gateworks.com>
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
 .../boot/dts/freescale/imx8mm-venice-gw7902.dts    | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index edf0c7aaaef0..49e15a671b67 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -641,7 +641,7 @@
 /* RS232/RS485/RS422 selectable */
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>, <&pinctrl_uart1_gpio>;
+	pinctrl-0 = <&pinctrl_uart1>;
 	rts-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
 	cts-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
 	status = "okay";
@@ -742,6 +742,10 @@
 			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0x40000041 /* MIPI_GPIO2 */
 			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4		0x40000041 /* MIPI_GPIO3/PWM2 */
 			MX8MM_IOMUXC_SPDIF_TX_GPIO5_IO3		0x40000041 /* MIPI_GPIO4/PWM3 */
+			MX8MM_IOMUXC_SAI2_TXD0_GPIO4_IO26	0x40000110 /* UART1_HALF */
+			MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25	0x40000110 /* UART1_TERM */
+			MX8MM_IOMUXC_SAI2_RXD0_GPIO4_IO23	0x40000110 /* UART1_RS485 */
+
 		>;
 	};
 
@@ -886,14 +890,6 @@
 		>;
 	};
 
-	pinctrl_uart1_gpio: uart1gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI2_TXD0_GPIO4_IO26	0x40000110 /* HALF */
-			MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25	0x40000110 /* TERM */
-			MX8MM_IOMUXC_SAI2_RXD0_GPIO4_IO23	0x40000110 /* RS485 */
-		>;
-	};
-
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-- 
2.17.1

