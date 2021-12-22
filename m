Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B8A47D33B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245509AbhLVNyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:54:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:8328 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234159AbhLVNyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640181275; x=1671717275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOlE0op07TW7PsmipAIfJuclyE2ZSoUR1iE05LtVWZA=;
  b=Zy3OGWFg+fe8U6xD6XXseq5wVKJkaguylkCeYX48AvuN/zN/XPrxZSAj
   CS5f6dgbsTOnb+cCsPSezTp9RAQl1yPYkFv83RFEA2CT8TdKzPpuHqli8
   lCCMwhzmIM+Bmmb8qHWhOm8pcoZNrfQeBTCNYdCPUSSovlOGwF06iHlgb
   wmjnYpBKReAiQuE7zTPCg+oddmtpO+9LyYFCcklpuZkl7aF1opoC3qIpd
   YHHwLYW50oj5xfWA80SsN14n3MkyO/+tz8sexGOT5E1buanEg8oKT5woY
   XaoioGgpyiGHs5V/5EF5toEvm8lmhkVexMKCSpjnFJK7oGTJle9AB/4ku
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="221297938"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="221297938"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 05:54:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="617140993"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 22 Dec 2021 05:54:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6DB3F2D2; Wed, 22 Dec 2021 15:54:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 2/3] spi: dw: Propagate firmware node
Date:   Wed, 22 Dec 2021 15:54:22 +0200
Message-Id: <20211222135423.62487-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211222135423.62487-1-andriy.shevchenko@linux.intel.com>
References: <20211222135423.62487-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate firmware node by using a specific API call, i.e. device_set_node().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 934cc7a922e8..ecea471ff42c 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -895,6 +895,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	if (!master)
 		return -ENOMEM;
 
+	device_set_node(&master->dev, dev_fwnode(dev));
+
 	dws->master = master;
 	dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
 
@@ -931,8 +933,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	if (dws->mem_ops.exec_op)
 		master->mem_ops = &dws->mem_ops;
 	master->max_speed_hz = dws->max_freq;
-	master->dev.of_node = dev->of_node;
-	master->dev.fwnode = dev->fwnode;
 	master->flags = SPI_MASTER_GPIO_SS;
 	master->auto_runtime_pm = true;
 
-- 
2.34.1

