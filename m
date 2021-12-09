Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683B246EA1D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbhLIOky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:40:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:10188 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238714AbhLIOkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:40:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="218801789"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="218801789"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:37:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="462152976"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 09 Dec 2021 06:37:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7890915C; Thu,  9 Dec 2021 16:37:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v1 2/3] ata: sata_dwc_460ex: Use temporary variable for struct device
Date:   Thu,  9 Dec 2021 16:35:18 +0200
Message-Id: <20211209143519.60498-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209143519.60498-1-andriy.shevchenko@linux.intel.com>
References: <20211209143519.60498-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 37 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 513bee589d12..5421f74c0199 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -215,9 +215,10 @@ static int sata_dwc_dma_get_channel_old(struct sata_dwc_device_port *hsdevp)
 {
 	struct sata_dwc_device *hsdev = hsdevp->hsdev;
 	struct dw_dma_slave *dws = &sata_dwc_dma_dws;
+	struct device *dev = hsdev->dev;
 	dma_cap_mask_t mask;
 
-	dws->dma_dev = hsdev->dev;
+	dws->dma_dev = dev;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -225,8 +226,7 @@ static int sata_dwc_dma_get_channel_old(struct sata_dwc_device_port *hsdevp)
 	/* Acquire DMA channel */
 	hsdevp->chan = dma_request_channel(mask, sata_dwc_dma_filter, hsdevp);
 	if (!hsdevp->chan) {
-		dev_err(hsdev->dev, "%s: dma channel unavailable\n",
-			 __func__);
+		dev_err(dev, "%s: dma channel unavailable\n", __func__);
 		return -EAGAIN;
 	}
 
@@ -236,19 +236,20 @@ static int sata_dwc_dma_get_channel_old(struct sata_dwc_device_port *hsdevp)
 static int sata_dwc_dma_init_old(struct platform_device *pdev,
 				 struct sata_dwc_device *hsdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 
-	hsdev->dma = devm_kzalloc(&pdev->dev, sizeof(*hsdev->dma), GFP_KERNEL);
+	hsdev->dma = devm_kzalloc(dev, sizeof(*hsdev->dma), GFP_KERNEL);
 	if (!hsdev->dma)
 		return -ENOMEM;
 
-	hsdev->dma->dev = &pdev->dev;
+	hsdev->dma->dev = dev;
 	hsdev->dma->id = pdev->id;
 
 	/* Get SATA DMA interrupt number */
 	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
 	if (hsdev->dma->irq == NO_IRQ) {
-		dev_err(&pdev->dev, "no SATA DMA irq\n");
+		dev_err(dev, "no SATA DMA irq\n");
 		return -ENODEV;
 	}
 
@@ -1205,6 +1206,8 @@ static const struct ata_port_info sata_dwc_port_info[] = {
 
 static int sata_dwc_probe(struct platform_device *ofdev)
 {
+	struct device *dev = &ofdev->dev;
+	struct device_node *np = dev->of_node;
 	struct sata_dwc_device *hsdev;
 	u32 idr, versionr;
 	char *ver = (char *)&versionr;
@@ -1214,12 +1217,11 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	struct ata_host *host;
 	struct ata_port_info pi = sata_dwc_port_info[0];
 	const struct ata_port_info *ppi[] = { &pi, NULL };
-	struct device_node *np = ofdev->dev.of_node;
 	struct resource *res;
 
 	/* Allocate DWC SATA device */
-	host = ata_host_alloc_pinfo(&ofdev->dev, ppi, SATA_DWC_MAX_PORTS);
-	hsdev = devm_kzalloc(&ofdev->dev, sizeof(*hsdev), GFP_KERNEL);
+	host = ata_host_alloc_pinfo(dev, ppi, SATA_DWC_MAX_PORTS);
+	hsdev = devm_kzalloc(dev, sizeof(*hsdev), GFP_KERNEL);
 	if (!host || !hsdev)
 		return -ENOMEM;
 
@@ -1229,7 +1231,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	base = devm_platform_get_and_ioremap_resource(ofdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
-	dev_dbg(&ofdev->dev, "ioremap done for SATA register address\n");
+	dev_dbg(dev, "ioremap done for SATA register address\n");
 
 	/* Synopsys DWC SATA specific Registers */
 	hsdev->sata_dwc_regs = base + SATA_DWC_REG_OFFSET;
@@ -1243,11 +1245,10 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Read the ID and Version Registers */
 	idr = sata_dwc_readl(&hsdev->sata_dwc_regs->idr);
 	versionr = sata_dwc_readl(&hsdev->sata_dwc_regs->versionr);
-	dev_notice(&ofdev->dev, "id %d, controller version %c.%c%c\n",
-		   idr, ver[0], ver[1], ver[2]);
+	dev_notice(dev, "id %d, controller version %c.%c%c\n", idr, ver[0], ver[1], ver[2]);
 
 	/* Save dev for later use in dev_xxx() routines */
-	hsdev->dev = &ofdev->dev;
+	hsdev->dev = dev;
 
 	/* Enable SATA Interrupts */
 	sata_dwc_enable_interrupts(hsdev);
@@ -1255,7 +1256,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Get SATA interrupt number */
 	irq = irq_of_parse_and_map(np, 0);
 	if (irq == NO_IRQ) {
-		dev_err(&ofdev->dev, "no SATA DMA irq\n");
+		dev_err(dev, "no SATA DMA irq\n");
 		return -ENODEV;
 	}
 
@@ -1267,7 +1268,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	}
 #endif
 
-	hsdev->phy = devm_phy_optional_get(hsdev->dev, "sata-phy");
+	hsdev->phy = devm_phy_optional_get(dev, "sata-phy");
 	if (IS_ERR(hsdev->phy))
 		return PTR_ERR(hsdev->phy);
 
@@ -1282,7 +1283,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	 */
 	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
 	if (err)
-		dev_err(&ofdev->dev, "failed to activate host");
+		dev_err(dev, "failed to activate host");
 
 	return 0;
 
@@ -1306,7 +1307,7 @@ static int sata_dwc_remove(struct platform_device *ofdev)
 	sata_dwc_dma_exit_old(hsdev);
 #endif
 
-	dev_dbg(&ofdev->dev, "done\n");
+	dev_dbg(dev, "done\n");
 	return 0;
 }
 
-- 
2.33.0

