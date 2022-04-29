Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B09515086
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378946AbiD2QRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378926AbiD2QRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:17:13 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA76D76E6;
        Fri, 29 Apr 2022 09:13:54 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1nkTFg-00Csxl-29; Fri, 29 Apr 2022 16:13:52 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2] arm64: dts: imx8mm-venice-gw7902: fix pcie bindings
Date:   Fri, 29 Apr 2022 09:13:47 -0700
Message-Id: <20220429161347.7947-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the pcie bindings to the correct dt bindings:
 pcie_phy:
  - use pcie0_refclk
  - add required clock-names
 pcie:
  - remove pcie_phy clock as it comes from phy driver

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
 - update commit log
 - add required clock-names to pcie_phy node
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index edf0c7aaaef0..7848509b3e2b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -595,7 +595,8 @@
 &pcie_phy {
 	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
 	fsl,clkreq-unsupported;
-	clocks = <&clk IMX8MM_CLK_DUMMY>;
+	clocks = <&pcie0_refclk>;
+	clock-names = "ref";
 	status = "okay";
 };
 
@@ -604,8 +605,8 @@
 	pinctrl-0 = <&pinctrl_pcie0>;
 	reset-gpio = <&gpio4 5 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
-		 <&clk IMX8MM_CLK_DUMMY>, <&pcie0_refclk>;
-	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
+		 <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_aux", "pcie_bus";
 	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
 			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
 	assigned-clock-rates = <10000000>, <250000000>;
-- 
2.17.1

