Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A06C4C4C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243684AbiBYRZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243650AbiBYRYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:24:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D619F1A8CB9;
        Fri, 25 Feb 2022 09:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645809849; x=1677345849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HPhdfzrSAl7OfPLUbSJxD2n3AF3pztaWdjWo8tOY16E=;
  b=RJKp4lWh6x4tweTP6+DxyZOA2Pfhxe1u+gs5NKIdXiOlGtAkRDEufG4s
   VNQgnaTFVuCjSlX7cxTd2EXXgy2Pba4uwmxiGbX2ingMTr0GE09uLfidF
   9nxbrFilvX8y2awiU5hWfUeIAIfVOue1T/0r33KVP3b3E1m3eFvde6lg1
   tpMfMRkm/VkxJSCKY2hS4tr2glt09FvfoBJAzowlAvIVOCng0MM9Fxwj1
   XGIlB8I1/6DWg5nnsfr/4Ydh7nUTnW3ertthTo33CBESGWq+YQOZ3hxMI
   KZBpIqplN3qxqVkVZ4HKk+GrBUOizuEgSCyQjGWQ/jHDHAObeK/GY/Ia/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232513161"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="232513161"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:24:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="549342167"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2022 09:24:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8F2E1772; Fri, 25 Feb 2022 19:24:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 09/11] spi: pxa2xx-pci: Extract pxa2xx_spi_pci_clk_register()
Date:   Fri, 25 Feb 2022 19:23:48 +0200
Message-Id: <20220225172350.69797-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
References: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract pxa2xx_spi_pci_clk_register() from ->probe() in order to reuse it
later on for getting rid of max_clk_rate temporary storage.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index c041a9288d0c..2dbe08034ad0 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -65,6 +65,24 @@ static struct dw_dma_slave lpt1_rx_param = { .src_id = 1 };
 static struct dw_dma_slave lpt0_tx_param = { .dst_id = 2 };
 static struct dw_dma_slave lpt0_rx_param = { .src_id = 3 };
 
+static void pxa2xx_spi_pci_clk_unregister(void *clk)
+{
+	clk_unregister(clk);
+}
+
+static int pxa2xx_spi_pci_clk_register(struct pci_dev *dev, struct ssp_device *ssp,
+				       unsigned long rate)
+{
+	char buf[40];
+
+	snprintf(buf, sizeof(buf), "pxa2xx-spi.%d", ssp->port_id);
+	ssp->clk = clk_register_fixed_rate(&dev->dev, buf, NULL, 0, rate);
+	if (IS_ERR(ssp->clk))
+		return PTR_ERR(ssp->clk);
+
+	return devm_add_action_or_reset(&dev->dev, pxa2xx_spi_pci_clk_unregister, ssp->clk);
+}
+
 static bool lpss_dma_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma_slave *dws = param;
@@ -246,7 +264,6 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	struct pxa2xx_spi_controller spi_pdata;
 	struct ssp_device *ssp;
 	struct pxa_spi_info *c;
-	char buf[40];
 
 	ret = pcim_enable_device(dev);
 	if (ret)
@@ -283,11 +300,9 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 		return ret;
 	ssp->irq = pci_irq_vector(dev, 0);
 
-	snprintf(buf, sizeof(buf), "pxa2xx-spi.%d", ssp->port_id);
-	ssp->clk = clk_register_fixed_rate(&dev->dev, buf, NULL, 0,
-					   c->max_clk_rate);
-	if (IS_ERR(ssp->clk))
-		return PTR_ERR(ssp->clk);
+	ret = pxa2xx_spi_pci_clk_register(dev, ssp, c->max_clk_rate);
+	if (ret)
+		return ret;
 
 	memset(&pi, 0, sizeof(pi));
 	pi.fwnode = dev_fwnode(&dev->dev);
@@ -298,10 +313,8 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	pi.size_data = sizeof(spi_pdata);
 
 	pdev = platform_device_register_full(&pi);
-	if (IS_ERR(pdev)) {
-		clk_unregister(ssp->clk);
+	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
-	}
 
 	pci_set_drvdata(dev, pdev);
 
@@ -311,12 +324,8 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
 {
 	struct platform_device *pdev = pci_get_drvdata(dev);
-	struct pxa2xx_spi_controller *spi_pdata;
-
-	spi_pdata = dev_get_platdata(&pdev->dev);
 
 	platform_device_unregister(pdev);
-	clk_unregister(spi_pdata->ssp.clk);
 }
 
 static const struct pci_device_id pxa2xx_spi_pci_devices[] = {
-- 
2.34.1

