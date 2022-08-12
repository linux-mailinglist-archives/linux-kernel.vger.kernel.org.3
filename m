Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052D05914F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239542AbiHLRgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbiHLRfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:35:41 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BE5883FA;
        Fri, 12 Aug 2022 10:35:39 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1oMYZJ-00FqKk-9A; Fri, 12 Aug 2022 17:35:33 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 6/6] arm64: dts: imx8mp-venice-gw74xx: add WiFi/BT module support
Date:   Fri, 12 Aug 2022 10:35:26 -0700
Message-Id: <20220812173526.15537-6-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812173526.15537-1-tharvey@gateworks.com>
References: <20220812173526.15537-1-tharvey@gateworks.com>
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

The GW74xx supports an on-board Laird Connectivity Sterling LWB5+ module
which uses a Cypress CYW4373W chip to provide 1x1 802.11 a/b/g/n/ac +
Bluetooth 5.2.

Add the proper device-tree nodes for it.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../dts/freescale/imx8mp-venice-gw74xx.dts    | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index bfc480aaf54d..47866d4e5444 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -135,10 +135,10 @@ reg_wifi_en: regulator-wifi-en {
 		compatible = "regulator-fixed";
 		regulator-name = "wl";
 		gpio = <&gpio3 9 GPIO_ACTIVE_HIGH>;
-		startup-delay-us = <100>;
+		startup-delay-us = <70000>;
 		enable-active-high;
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 	};
 };
 
@@ -577,6 +577,21 @@ &uart2 {
 	status = "okay";
 };
 
+/* bluetooth HCI */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>, <&pinctrl_uart3_gpio>;
+	cts-gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
+	rts-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4330-bt";
+		shutdown-gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4>;
@@ -617,6 +632,23 @@ &usb_dwc3_1 {
 	status = "okay";
 };
 
+/* SDIO WiFi */
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <4>;
+	non-removable;
+	vmmc-supply = <&reg_wifi_en>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	wifi@0 {
+		compatible = "cypress,cyw4373-fmac";
+		reg = <0>;
+	};
+};
+
 /* eMMC */
 &usdhc3 {
 	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
-- 
2.25.1

