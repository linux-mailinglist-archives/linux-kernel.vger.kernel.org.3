Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8A85A452B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiH2Id3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiH2IdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:33:08 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63A857E20;
        Mon, 29 Aug 2022 01:33:04 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7E0491A2CA6;
        Mon, 29 Aug 2022 10:33:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C32821A2CC0;
        Mon, 29 Aug 2022 10:33:01 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C5A0E1820F59;
        Mon, 29 Aug 2022 16:32:59 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4 6/6] PCI: imx6: Add iMX8MP PCIe support
Date:   Mon, 29 Aug 2022 16:15:17 +0800
Message-Id: <1661760917-9558-7-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1661760917-9558-1-git-send-email-hongxing.zhu@nxp.com>
References: <1661760917-9558-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8MP PCIe support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Tested-by: Marek Vasut <marex@denx.de>
Tested-by: Richard Leitner <richard.leitner@skidata.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6e5debdbc55b..786f5737ca6a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -51,6 +51,7 @@ enum imx6_pcie_variants {
 	IMX7D,
 	IMX8MQ,
 	IMX8MM,
+	IMX8MP,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -150,7 +151,8 @@ struct imx6_pcie {
 static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 {
 	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
-		imx6_pcie->drvdata->variant != IMX8MM);
+		imx6_pcie->drvdata->variant != IMX8MM &&
+		imx6_pcie->drvdata->variant != IMX8MP);
 	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
@@ -301,6 +303,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MM:
+	case IMX8MP:
 		/*
 		 * The PHY initialization had been done in the PHY
 		 * driver, break here directly.
@@ -558,6 +561,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX8MM:
 	case IMX8MQ:
+	case IMX8MP:
 		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
 		if (ret) {
 			dev_err(dev, "unable to enable pcie_aux clock\n");
@@ -602,6 +606,7 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX8MM:
 	case IMX8MQ:
+	case IMX8MP:
 		clk_disable_unprepare(imx6_pcie->pcie_aux);
 		break;
 	default:
@@ -669,6 +674,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		fallthrough;
 	case IMX8MM:
+	case IMX8MP:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
 	case IMX6SX:
@@ -744,6 +750,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX6Q:		/* Nothing to do */
 	case IMX8MM:
+	case IMX8MP:
 		break;
 	}
 
@@ -793,6 +800,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 	case IMX7D:
 	case IMX8MQ:
 	case IMX8MM:
+	case IMX8MP:
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -812,6 +820,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 	case IMX7D:
 	case IMX8MQ:
 	case IMX8MM:
+	case IMX8MP:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -1179,6 +1188,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		}
 		break;
 	case IMX8MM:
+	case IMX8MP:
 		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
 		if (IS_ERR(imx6_pcie->pcie_aux))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
@@ -1320,6 +1330,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 	},
+	[IMX8MP] = {
+		.variant = IMX8MP,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1329,6 +1343,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
+	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
 	{},
 };
 
-- 
2.25.1

