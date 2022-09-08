Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9055B22A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiIHPmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiIHPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:42:41 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7B3F913E;
        Thu,  8 Sep 2022 08:42:39 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1oWJfi-00GV34-9t; Thu, 08 Sep 2022 15:42:30 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jun Li <jun.li@nxp.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: imx8mp-venice-gw74xx: add USB DR support
Date:   Thu,  8 Sep 2022 08:42:27 -0700
Message-Id: <20220908154227.4099410-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for USB DR on USB1 interface. Host/Device detection is done
using the usb-role-switch connector with a GPIO as USB1_OTG_ID is not
connected internally.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../dts/freescale/imx8mp-venice-gw74xx.dts    | 30 +++++++++++++++----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index 9fb492a8b045..e0fe356b662d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -598,20 +598,35 @@ &uart4 {
 };
 
 /* USB1 - Type C front panel */
-&usb3_phy0 {
+&usb3_0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb1>;
+	fsl,over-current-active-low;
 	status = "okay";
 };
 
-&usb3_0 {
-	fsl,over-current-active-low;
+&usb3_phy0 {
 	status = "okay";
 };
 
 &usb_dwc3_0 {
-	dr_mode = "host";
+	/* dual role is implemented but not a full featured OTG */
+	adp-disable;
+	hnp-disable;
+	srp-disable;
+	dr_mode = "otg";
+	usb-role-switch;
+	role-switch-default-mode = "peripheral";
 	status = "okay";
+
+	connector {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbcon1>;
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		type = "micro";
+		label = "Type-C";
+		id-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 /* USB2 - USB3.0 Hub */
@@ -870,7 +885,12 @@ MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX	0x140
 	pinctrl_usb1: usb1grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_GPIO1_IO13__USB1_OTG_OC	0x140
-			MX8MP_IOMUXC_GPIO1_IO10__USB1_OTG_ID	0x140
+		>;
+	};
+
+	pinctrl_usbcon1: usb1congrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10	0x140
 		>;
 	};
 
-- 
2.25.1

