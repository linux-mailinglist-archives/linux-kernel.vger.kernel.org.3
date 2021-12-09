Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D08C46EA1B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbhLIOkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:40:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:56674 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232389AbhLIOku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:40:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="235621908"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="235621908"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:37:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="463253605"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2021 06:37:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 69107329; Thu,  9 Dec 2021 16:37:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v1 1/3] ata: sata_dwc_460ex: Use devm_platform_*ioremap_resource() APIs
Date:   Thu,  9 Dec 2021 16:35:17 +0200
Message-Id: <20211209143519.60498-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() and
devm_platform_ioremap_resource() APIs instead of their
open coded analogues.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 338c2e50f759..513bee589d12 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -237,7 +237,6 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 				 struct sata_dwc_device *hsdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct resource *res;
 
 	hsdev->dma = devm_kzalloc(&pdev->dev, sizeof(*hsdev->dma), GFP_KERNEL);
 	if (!hsdev->dma)
@@ -254,8 +253,7 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 	}
 
 	/* Get physical SATA DMA register base address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	hsdev->dma->regs = devm_ioremap_resource(&pdev->dev, res);
+	hsdev->dma->regs = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(hsdev->dma->regs))
 		return PTR_ERR(hsdev->dma->regs);
 
@@ -1228,8 +1226,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	host->private_data = hsdev;
 
 	/* Ioremap SATA registers */
-	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&ofdev->dev, res);
+	base = devm_platform_get_and_ioremap_resource(ofdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 	dev_dbg(&ofdev->dev, "ioremap done for SATA register address\n");
-- 
2.33.0

