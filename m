Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5950957461E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbiGNHsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbiGNHrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:47:24 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77973A49B;
        Thu, 14 Jul 2022 00:47:11 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7CA6B202176;
        Thu, 14 Jul 2022 09:47:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 43515202179;
        Thu, 14 Jul 2022 09:47:10 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 00CB8180327D;
        Thu, 14 Jul 2022 15:47:08 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v15 14/17] PCI: imx6: Do not hide PHY driver callbacks and refine the error handling
Date:   Thu, 14 Jul 2022 15:31:06 +0800
Message-Id: <1657783869-19194-15-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657783869-19194-1-git-send-email-hongxing.zhu@nxp.com>
References: <1657783869-19194-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Move the phy_power_on() to host_init from imx6_pcie_clk_enable().
- Move the phy_init() to host_init from imx6_pcie_deassert_core_reset().

Refine the error handling in imx6_pcie_host_init() accordingly.

Link: https://lore.kernel.org/r/1656645935-1370-15-git-send-email-hongxing.zhu@nxp.com
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 36 +++++++++++++++++----------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ad0933c3dc70..afb4d58fd693 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -639,14 +639,6 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 		goto err_ref_clk;
 	}
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MM:
-		if (phy_power_on(imx6_pcie->phy))
-			dev_err(dev, "unable to power on PHY\n");
-		break;
-	default:
-		break;
-	}
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
 	return 0;
@@ -723,10 +715,6 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		break;
-	case IMX8MM:
-		if (phy_init(imx6_pcie->phy))
-			dev_err(dev, "waiting for phy ready timeout!\n");
-		break;
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 
@@ -762,6 +750,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		usleep_range(200, 500);
 		break;
 	case IMX6Q:		/* Nothing to do */
+	case IMX8MM:
 		break;
 	}
 
@@ -914,16 +903,37 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 
 	imx6_pcie_assert_core_reset(imx6_pcie);
 	imx6_pcie_init_phy(imx6_pcie);
+
+	if (imx6_pcie->phy) {
+		ret = phy_power_on(imx6_pcie->phy);
+		if (ret) {
+			dev_err(dev, "pcie phy power up failed\n");
+			goto err_reg_disable;
+		}
+	}
+
 	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
 	if (ret < 0) {
 		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
-		goto err_reg_disable;
+		goto err_phy_off;
 	}
 
+	if (imx6_pcie->phy) {
+		ret = phy_init(imx6_pcie->phy);
+		if (ret) {
+			dev_err(dev, "waiting for phy ready timeout!\n");
+			goto err_clk_disable;
+		}
+	}
 	imx6_setup_phy_mpll(imx6_pcie);
 
 	return 0;
 
+err_clk_disable:
+	imx6_pcie_clk_disable(imx6_pcie);
+err_phy_off:
+	if (imx6_pcie->phy)
+		phy_power_off(imx6_pcie->phy);
 err_reg_disable:
 	if (imx6_pcie->vpcie)
 		regulator_disable(imx6_pcie->vpcie);
-- 
2.25.1

