Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21F14C4C0E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbiBYRYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243559AbiBYRYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:24:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C9B180234;
        Fri, 25 Feb 2022 09:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645809847; x=1677345847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lqhdKS9GRMf41xyQKxd6Fw1EG6mYJYGwBKVaXDm5bkQ=;
  b=X2MFHQnjTGiLigdqJNvoWwOn3JhuXNgp6vuUbR0N4RDnRlYLs+KF6eKy
   3RZYzoCMy37Q2ZoUZPidlfDZg3XVpBV+TSdF70+JljwUXEnnf03uJsyFk
   HkbRRRUnJ5qsbjiKdEhEIjk+UBxWJvL9J1JX6l4OKBU3GJ9/lX4TDbbcR
   4MZw9FVbcsJKlQxvI2RK+0tp6Zibi1eHQLXo93AGxvTEwwtmZ2w5pLJme
   o1OscUdKVL9DhqX+5DZg1X+zQIkyQZzLjVtJDUV9KiNqFsZZ7zPI0OIok
   horSQUpqy51ZoOfLOQZ8lRK05rQaN5GmSkA2+EfWJPGVuAFl0LIY0FfI6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232513152"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="232513152"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:24:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="549342141"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2022 09:24:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5E6A3439; Fri, 25 Feb 2022 19:24:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 05/11] spi: pxa2xx-pci: Move dma_burst_size assignment to ->setup()
Date:   Fri, 25 Feb 2022 19:23:44 +0200
Message-Id: <20220225172350.69797-5-andriy.shevchenko@linux.intel.com>
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

Instead of using conditional, move dma_burst_size to the corresponding
->setup() function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 87629da3e544..c2cbb002784a 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -38,7 +38,7 @@ struct pxa_spi_info {
 	void *tx_param;
 	void *rx_param;
 
-	int dma_burst_size;
+	unsigned int dma_burst_size;
 
 	int (*setup)(struct pci_dev *pdev, struct pxa_spi_info *c);
 };
@@ -111,6 +111,7 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	}
 
 	c->dma_filter = lpss_dma_filter;
+	c->dma_burst_size = 1;
 	return 0;
 }
 
@@ -265,7 +266,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	spi_pdata.tx_param = c->tx_param;
 	spi_pdata.rx_param = c->rx_param;
 	spi_pdata.enable_dma = c->rx_param && c->tx_param;
-	spi_pdata.dma_burst_size = c->dma_burst_size ? c->dma_burst_size : 1;
+	spi_pdata.dma_burst_size = c->dma_burst_size;
 
 	ssp = &spi_pdata.ssp;
 	ssp->dev = &dev->dev;
-- 
2.34.1

