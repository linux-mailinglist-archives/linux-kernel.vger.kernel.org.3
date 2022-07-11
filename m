Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0700A5629B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 05:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiGADkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 23:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiGADkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 23:40:20 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B222B64D74;
        Thu, 30 Jun 2022 20:40:19 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 64848201153;
        Fri,  1 Jul 2022 05:40:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 03FAC20113B;
        Fri,  1 Jul 2022 05:40:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 67D781820F59;
        Fri,  1 Jul 2022 11:40:16 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v14 03/17] PCI: imx6: Move imx6_pcie_enable_ref_clk() earlier
Date:   Fri,  1 Jul 2022 11:25:21 +0800
Message-Id: <1656645935-1370-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Move imx6_pcie_enable_ref_clk() earlier so it's not in the middle between
imx6_pcie_assert_core_reset() and imx6_pcie_deassert_core_reset().  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 96 +++++++++++++--------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e63eb6380020..a6d2b907d42b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -520,54 +520,6 @@ static int imx6_pcie_attach_pd(struct device *dev)
 	return 0;
 }
 
-static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
-{
-	struct device *dev = imx6_pcie->pci->dev;
-
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX7D:
-	case IMX8MQ:
-		reset_control_assert(imx6_pcie->pciephy_reset);
-		fallthrough;
-	case IMX8MM:
-		reset_control_assert(imx6_pcie->apps_reset);
-		break;
-	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
-		/* Force PCIe PHY reset */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
-		break;
-	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_SW_RST,
-				   IMX6Q_GPR1_PCIE_SW_RST);
-		break;
-	case IMX6Q:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
-		break;
-	}
-
-	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
-		int ret = regulator_disable(imx6_pcie->vpcie);
-
-		if (ret)
-			dev_err(dev, "failed to disable vpcie regulator: %d\n",
-				ret);
-	}
-
-	/* Some boards don't have PCIe reset GPIO. */
-	if (gpio_is_valid(imx6_pcie->reset_gpio))
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
-					imx6_pcie->gpio_active_high);
-}
-
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -628,6 +580,54 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	return ret;
 }
 
+static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
+{
+	struct device *dev = imx6_pcie->pci->dev;
+
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX7D:
+	case IMX8MQ:
+		reset_control_assert(imx6_pcie->pciephy_reset);
+		fallthrough;
+	case IMX8MM:
+		reset_control_assert(imx6_pcie->apps_reset);
+		break;
+	case IMX6SX:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
+		/* Force PCIe PHY reset */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
+				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
+		break;
+	case IMX6QP:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_SW_RST,
+				   IMX6Q_GPR1_PCIE_SW_RST);
+		break;
+	case IMX6Q:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
+		break;
+	}
+
+	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
+		int ret = regulator_disable(imx6_pcie->vpcie);
+
+		if (ret)
+			dev_err(dev, "failed to disable vpcie regulator: %d\n",
+				ret);
+	}
+
+	/* Some boards don't have PCIe reset GPIO. */
+	if (gpio_is_valid(imx6_pcie->reset_gpio))
+		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
+					imx6_pcie->gpio_active_high);
+}
+
 static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-- 
2.25.1

