Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288C04C4C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbiBYRZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243651AbiBYRYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:24:42 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749C31A9066;
        Fri, 25 Feb 2022 09:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645809850; x=1677345850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=06HzJRtf8GKOGCOPDdefguWvxa54PWV3K7sE7WnIl0M=;
  b=O3mglHx0zqTYrQtxDZ/u3+IRGyTn5zUuRxhOUWe6nS9Qyj6RAwSg+ijk
   5v2LnNL6M9C9HOxTYqU1CAJykLWNCHDy5qwGvHZRBmOx+BJUnLxRo/dN+
   Urjvlsk0JQT6TqdZ+A/Oe5XkMeD/Gx7Xc+pwanHvgHr+QvPdeD16M1Fbt
   203u9BkN1blyvrP4bUWo0+fe6yhwFLphG3I9F3Bf5oBK78+8CRanwH9AB
   dMgbXoVZrMqB/CKKXila69OqT8AK0dHiTpV0LdRp5vQiesO+vMz4Tp09q
   VdAODG4175YvPQ18bmr2hqyU9eGC8j5HLtJcwrJW5Lfrw1ls2ZevhN43p
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252271011"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="252271011"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:24:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="628910898"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Feb 2022 09:24:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 83979763; Fri, 25 Feb 2022 19:24:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 08/11] spi: pxa2xx-pci: Drop unneeded checks in lpss_spi_setup()
Date:   Fri, 25 Feb 2022 19:23:47 +0200
Message-Id: <20220225172350.69797-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
References: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the LPSS devices are using DMA and set the parameters up,
hence no need to test for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index a0f24e811e9f..c041a9288d0c 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -83,6 +83,7 @@ static void lpss_dma_put_device(void *dma_dev)
 
 static int lpss_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 {
+	struct dw_dma_slave *tx, *rx;
 	struct pci_dev *dma_dev;
 	int ret;
 
@@ -137,21 +138,15 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	if (ret)
 		return ret;
 
-	if (c->tx_param) {
-		struct dw_dma_slave *slave = c->tx_param;
-
-		slave->dma_dev = &dma_dev->dev;
-		slave->m_master = 0;
-		slave->p_master = 1;
-	}
-
-	if (c->rx_param) {
-		struct dw_dma_slave *slave = c->rx_param;
+	tx = c->tx_param;
+	tx->dma_dev = &dma_dev->dev;
+	tx->m_master = 0;
+	tx->p_master = 1;
 
-		slave->dma_dev = &dma_dev->dev;
-		slave->m_master = 0;
-		slave->p_master = 1;
-	}
+	rx = c->rx_param;
+	rx->dma_dev = &dma_dev->dev;
+	rx->m_master = 0;
+	rx->p_master = 1;
 
 	c->dma_filter = lpss_dma_filter;
 	c->dma_burst_size = 1;
-- 
2.34.1

