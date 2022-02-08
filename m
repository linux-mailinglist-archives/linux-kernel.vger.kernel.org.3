Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA164AD010
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 05:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346711AbiBHEC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 23:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344948AbiBHECq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:02:46 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E708CC0401E9;
        Mon,  7 Feb 2022 20:02:45 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 537991A0C1F;
        Tue,  8 Feb 2022 04:56:57 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E41EF1A0C34;
        Tue,  8 Feb 2022 04:56:56 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5C7BE183AD6D;
        Tue,  8 Feb 2022 11:56:55 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com, festevam@gmail.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v6 1/8] PCI: imx6: Encapsulate the clock enable into one standalone function
Date:   Tue,  8 Feb 2022 11:25:28 +0800
Message-Id: <1644290735-3797-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
References: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No function changes, just encapsulate the i.MX PCIe clocks enable
operations into one standalone function

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-imx6.c | 79 ++++++++++++++++-----------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5fd33e4536af..5582ee1b420a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -481,38 +481,16 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	return ret;
 }
 
-static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
-{
-	u32 val;
-	struct device *dev = imx6_pcie->pci->dev;
-
-	if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
-				     IOMUXC_GPR22, val,
-				     val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED,
-				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
-				     PHY_PLL_LOCK_WAIT_TIMEOUT))
-		dev_err(dev, "PCIe PLL lock timeout\n");
-}
-
-static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
+static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
 	int ret;
 
-	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
-		ret = regulator_enable(imx6_pcie->vpcie);
-		if (ret) {
-			dev_err(dev, "failed to enable vpcie regulator: %d\n",
-				ret);
-			return;
-		}
-	}
-
 	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
 	if (ret) {
 		dev_err(dev, "unable to enable pcie_phy clock\n");
-		goto err_pcie_phy;
+		return ret;
 	}
 
 	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
@@ -543,6 +521,51 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
+	return 0;
+
+err_ref_clk:
+	clk_disable_unprepare(imx6_pcie->pcie);
+err_pcie:
+	clk_disable_unprepare(imx6_pcie->pcie_bus);
+err_pcie_bus:
+	clk_disable_unprepare(imx6_pcie->pcie_phy);
+
+	return ret;
+}
+
+static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
+{
+	u32 val;
+	struct device *dev = imx6_pcie->pci->dev;
+
+	if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
+				     IOMUXC_GPR22, val,
+				     val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED,
+				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
+				     PHY_PLL_LOCK_WAIT_TIMEOUT))
+		dev_err(dev, "PCIe PLL lock timeout\n");
+}
+
+static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
+{
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct device *dev = pci->dev;
+	int ret;
+
+	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
+		ret = regulator_enable(imx6_pcie->vpcie);
+		if (ret) {
+			dev_err(dev, "failed to enable vpcie regulator: %d\n",
+				ret);
+			return;
+		}
+	}
+
+	ret = imx6_pcie_clk_enable(imx6_pcie);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie clocks\n");
+		goto err_clks;
+	}
 
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
@@ -601,13 +624,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 	return;
 
-err_ref_clk:
-	clk_disable_unprepare(imx6_pcie->pcie);
-err_pcie:
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
-err_pcie_bus:
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
-err_pcie_phy:
+err_clks:
 	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
 		ret = regulator_disable(imx6_pcie->vpcie);
 		if (ret)
-- 
2.25.1

