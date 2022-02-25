Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FB44C4BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbiBYRZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243652AbiBYRYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:24:42 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593A21A905F;
        Fri, 25 Feb 2022 09:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645809850; x=1677345850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qmwBHU+f3phTivZz5IyHDg/PoreojVxnpGLGwuG4yLk=;
  b=mvBy5q6jiCBdrT2o41kUZul0ce17a00Isr32rbyS3HiC+z6Ufly3BvUC
   PxzMRkQv55B333nyMZ8oo8PoAwOsMc/rjmDRzrs5NTWLkgi2TyJDR0k6b
   KzYCIvwLPqpMxW4QDjXfFd3UcoLMi6zL4kJ0FefooTSjAaWX/O9NhdEBa
   DkzgNCAG6B1xXmsPTF83UNY5YG7/EFjd/6DdRpOc3ksIIgWqfNa3W2sZK
   hlPVXsy4YajP/BShAr/nUFwiFedAktby5EG60Zk+/B/EURsSIVSDgFotG
   3NoRDsrRqg7Yf++I4zCYkNyKxm8NMS2l65q9F6ErZtC94BGiuQXG1li9W
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="313259073"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="313259073"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:24:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="544119492"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 25 Feb 2022 09:24:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9AEC87F2; Fri, 25 Feb 2022 19:24:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 10/11] spi: pxa2xx-pci: Drop temporary storage use for a handful of members
Date:   Fri, 25 Feb 2022 19:23:49 +0200
Message-Id: <20220225172350.69797-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
References: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using temporary storage, assign the values directly
to the corresponding struct pxa2xx_spi_controller members.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 110 ++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 61 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 2dbe08034ad0..3c5d14affa95 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -28,19 +28,7 @@
 #define PCI_DEVICE_ID_INTEL_LPT1_1		0x9ce6
 
 struct pxa_spi_info {
-	enum pxa_ssp_type type;
-	unsigned int port_id;
-	unsigned int num_chipselect;
-	unsigned long max_clk_rate;
-
-	/* DMA channel request parameters */
-	bool (*dma_filter)(struct dma_chan *chan, void *param);
-	void *tx_param;
-	void *rx_param;
-
-	unsigned int dma_burst_size;
-
-	int (*setup)(struct pci_dev *pdev, struct pxa_spi_info *c);
+	int (*setup)(struct pci_dev *pdev, struct pxa2xx_spi_controller *c);
 };
 
 static struct dw_dma_slave byt_tx_param = { .dst_id = 0 };
@@ -99,48 +87,49 @@ static void lpss_dma_put_device(void *dma_dev)
 	pci_dev_put(dma_dev);
 }
 
-static int lpss_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
+static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 {
+	struct ssp_device *ssp = &c->ssp;
 	struct dw_dma_slave *tx, *rx;
 	struct pci_dev *dma_dev;
 	int ret;
 
 	switch (dev->device) {
 	case PCI_DEVICE_ID_INTEL_BYT:
-		c->type = LPSS_BYT_SSP;
-		c->port_id = 0;
+		ssp->type = LPSS_BYT_SSP;
+		ssp->port_id = 0;
 		c->tx_param = &byt_tx_param;
 		c->rx_param = &byt_rx_param;
 		break;
 	case PCI_DEVICE_ID_INTEL_BSW0:
-		c->type = LPSS_BSW_SSP;
-		c->port_id = 0;
+		ssp->type = LPSS_BSW_SSP;
+		ssp->port_id = 0;
 		c->tx_param = &bsw0_tx_param;
 		c->rx_param = &bsw0_rx_param;
 		break;
 	case PCI_DEVICE_ID_INTEL_BSW1:
-		c->type = LPSS_BSW_SSP;
-		c->port_id = 1;
+		ssp->type = LPSS_BSW_SSP;
+		ssp->port_id = 1;
 		c->tx_param = &bsw1_tx_param;
 		c->rx_param = &bsw1_rx_param;
 		break;
 	case PCI_DEVICE_ID_INTEL_BSW2:
-		c->type = LPSS_BSW_SSP;
-		c->port_id = 2;
+		ssp->type = LPSS_BSW_SSP;
+		ssp->port_id = 2;
 		c->tx_param = &bsw2_tx_param;
 		c->rx_param = &bsw2_rx_param;
 		break;
 	case PCI_DEVICE_ID_INTEL_LPT0_0:
 	case PCI_DEVICE_ID_INTEL_LPT1_0:
-		c->type = LPSS_LPT_SSP;
-		c->port_id = 0;
+		ssp->type = LPSS_LPT_SSP;
+		ssp->port_id = 0;
 		c->tx_param = &lpt0_tx_param;
 		c->rx_param = &lpt0_rx_param;
 		break;
 	case PCI_DEVICE_ID_INTEL_LPT0_1:
 	case PCI_DEVICE_ID_INTEL_LPT1_1:
-		c->type = LPSS_LPT_SSP;
-		c->port_id = 1;
+		ssp->type = LPSS_LPT_SSP;
+		ssp->port_id = 1;
 		c->tx_param = &lpt1_tx_param;
 		c->rx_param = &lpt1_rx_param;
 		break;
@@ -149,7 +138,10 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	}
 
 	c->num_chipselect = 1;
-	c->max_clk_rate = 50000000;
+
+	ret = pxa2xx_spi_pci_clk_register(dev, ssp, 50000000);
+	if (ret)
+		return ret;
 
 	dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	ret = devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, dma_dev);
@@ -168,6 +160,7 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 
 	c->dma_filter = lpss_dma_filter;
 	c->dma_burst_size = 1;
+	c->enable_dma = 1;
 	return 0;
 }
 
@@ -175,41 +168,45 @@ static struct pxa_spi_info lpss_info_config = {
 	.setup = lpss_spi_setup,
 };
 
-static int ce4100_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
+static int ce4100_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 {
-	c->type = PXA25x_SSP;
-	c->port_id = dev->devfn;
+	struct ssp_device *ssp = &c->ssp;
+
+	ssp->type = PXA25x_SSP;
+	ssp->port_id = dev->devfn;
 	c->num_chipselect = dev->devfn;
-	c->max_clk_rate = 3686400;
 
-	return 0;
+	return pxa2xx_spi_pci_clk_register(dev, ssp, 3686400);
 }
 
 static struct pxa_spi_info ce4100_info_config = {
 	.setup = ce4100_spi_setup,
 };
 
-static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
+static int mrfld_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 {
+	struct ssp_device *ssp = &c->ssp;
 	struct dw_dma_slave *tx, *rx;
 	struct pci_dev *dma_dev;
 	int ret;
 
+	ssp->type = MRFLD_SSP;
+
 	switch (PCI_FUNC(dev->devfn)) {
 	case 0:
-		c->port_id = 3;
+		ssp->port_id = 3;
 		c->num_chipselect = 1;
 		c->tx_param = &mrfld3_tx_param;
 		c->rx_param = &mrfld3_rx_param;
 		break;
 	case 1:
-		c->port_id = 5;
+		ssp->port_id = 5;
 		c->num_chipselect = 4;
 		c->tx_param = &mrfld5_tx_param;
 		c->rx_param = &mrfld5_rx_param;
 		break;
 	case 2:
-		c->port_id = 6;
+		ssp->port_id = 6;
 		c->num_chipselect = 1;
 		c->tx_param = &mrfld6_tx_param;
 		c->rx_param = &mrfld6_rx_param;
@@ -218,8 +215,9 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 		return -ENODEV;
 	}
 
-	c->type = MRFLD_SSP;
-	c->max_clk_rate = 25000000;
+	ret = pxa2xx_spi_pci_clk_register(dev, ssp, 25000000);
+	if (ret)
+		return ret;
 
 	dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(21, 0));
 	ret = devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, dma_dev);
@@ -234,6 +232,7 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 
 	c->dma_filter = lpss_dma_filter;
 	c->dma_burst_size = 8;
+	c->enable_dma = 1;
 	return 0;
 }
 
@@ -241,14 +240,15 @@ static struct pxa_spi_info mrfld_info_config = {
 	.setup = mrfld_spi_setup,
 };
 
-static int qrk_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
+static int qrk_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 {
-	c->type = QUARK_X1000_SSP;
-	c->port_id = dev->devfn;
+	struct ssp_device *ssp = &c->ssp;
+
+	ssp->type = QUARK_X1000_SSP;
+	ssp->port_id = dev->devfn;
 	c->num_chipselect = 1;
-	c->max_clk_rate = 50000000;
 
-	return 0;
+	return pxa2xx_spi_pci_clk_register(dev, ssp, 50000000);
 }
 
 static struct pxa_spi_info qrk_info_config = {
@@ -262,8 +262,8 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	int ret;
 	struct platform_device *pdev;
 	struct pxa2xx_spi_controller spi_pdata;
+	struct pxa_spi_info *info;
 	struct ssp_device *ssp;
-	struct pxa_spi_info *c;
 
 	ret = pcim_enable_device(dev);
 	if (ret)
@@ -273,25 +273,17 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	if (ret)
 		return ret;
 
-	c = (struct pxa_spi_info *)ent->driver_data;
-	ret = c->setup(dev, c);
-	if (ret)
-		return ret;
-
 	memset(&spi_pdata, 0, sizeof(spi_pdata));
-	spi_pdata.num_chipselect = c->num_chipselect;
-	spi_pdata.dma_filter = c->dma_filter;
-	spi_pdata.tx_param = c->tx_param;
-	spi_pdata.rx_param = c->rx_param;
-	spi_pdata.enable_dma = c->rx_param && c->tx_param;
-	spi_pdata.dma_burst_size = c->dma_burst_size;
 
 	ssp = &spi_pdata.ssp;
 	ssp->dev = &dev->dev;
 	ssp->phys_base = pci_resource_start(dev, 0);
 	ssp->mmio_base = pcim_iomap_table(dev)[0];
-	ssp->type = c->type;
-	ssp->port_id = c->port_id;
+
+	info = (struct pxa_spi_info *)ent->driver_data;
+	ret = info->setup(dev, &spi_pdata);
+	if (ret)
+		return ret;
 
 	pci_set_master(dev);
 
@@ -300,10 +292,6 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 		return ret;
 	ssp->irq = pci_irq_vector(dev, 0);
 
-	ret = pxa2xx_spi_pci_clk_register(dev, ssp, c->max_clk_rate);
-	if (ret)
-		return ret;
-
 	memset(&pi, 0, sizeof(pi));
 	pi.fwnode = dev_fwnode(&dev->dev);
 	pi.parent = &dev->dev;
-- 
2.34.1

