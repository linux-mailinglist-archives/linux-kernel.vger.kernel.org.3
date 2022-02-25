Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A9B4C4C05
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243658AbiBYRY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243566AbiBYRYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:24:39 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6350C198EFE;
        Fri, 25 Feb 2022 09:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645809847; x=1677345847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bvuz28srH0KtaXNEuCHq8ysOIlE/l6cGxL8C5KzYJbI=;
  b=S/70IP0KmiEc5E0UM68fUi+HwYSx6QsD7WCksi5KshrY0QLTj8G//LAH
   ASTJbGBVppQkxmufmqeOjzun77pjJAhwGxoo7z+EX65GXz7dH/cNLpMEe
   6/ZqmlfyArLKDPk54g5uUXp5sSi6INhczZgeOWt4J+xwmk23CbzyPtS5Q
   L2QgrBbfPGYS748m5YKkUNjKWA7qrHAnS+CwD3rjkWoJArshe5TSGaGQg
   W0zYW7uUt6CX3nhOM0BYofLhRlB7lSsrdYWpFZ8hSOlnf1xqAyTjVOR2O
   xdeLFwycd7bJkZfSDHazfoUDfdd8wm/DRaiRXl9HLli4QH6jmyZMGt4p1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="313259064"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="313259064"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:24:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="544119483"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 25 Feb 2022 09:24:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6CE6B50E; Fri, 25 Feb 2022 19:24:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 06/11] spi: pxa2xx-pci: Move max_clk_rate assignment to ->setup()
Date:   Fri, 25 Feb 2022 19:23:45 +0200
Message-Id: <20220225172350.69797-6-andriy.shevchenko@linux.intel.com>
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

Move max_clk_rate to the corresponding ->setup() function to unify
with the rest.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index c2cbb002784a..5ac1487c9b3f 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -153,6 +153,8 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 		return -ENODEV;
 	}
 
+	c->max_clk_rate = 25000000;
+
 	dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(21, 0));
 	ret = devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, dma_dev);
 	if (ret)
@@ -213,7 +215,6 @@ static struct pxa_spi_info spi_info_configs[] = {
 	},
 	[PORT_MRFLD] = {
 		.type = MRFLD_SSP,
-		.max_clk_rate = 25000000,
 		.setup = mrfld_spi_setup,
 	},
 	[PORT_QUARK_X1000] = {
-- 
2.34.1

