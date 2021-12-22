Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C847D475
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbhLVP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:57:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:57485 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241565AbhLVP5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640188655; x=1671724655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c8MHpZlakBmGhw/kiklG6Aj8OrG1EIX3toDrKadSm1Y=;
  b=NcHKakso1aKTVyECzBI6OKFcyQsEncxDQ2sfTjLex8rgRsv1wKisiV/u
   rkVCYVNVHtlSTHrdSe8ntf7m6bfPw0C8BRPkvgqEQM3yEi6FbjMvG8n69
   Keg739U6vgRTJh4NBBoejVHsjBUh8/13OzgcrE6BwIu1JPIfPlw5SY2GZ
   8vVFgAdU68n5AJkgA1snBPDVGfNBtFNJpzQVzGim3QR0k2/8r5CFnUQQy
   PogYS3TjvTrm8aexBKVpn4phWAFkHSYX3n0AGzfBh78JslT9xnNI7P9D+
   Y9UxGgvfYgL1+tGay3HSf6bK5BNrKfwhxLeJcaNIfCKidppt7Wf50icK0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="238183697"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="238183697"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 07:57:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="613877969"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Dec 2021 07:57:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 162E081; Wed, 22 Dec 2021 17:57:41 +0200 (EET)
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
Subject: [PATCH v2 2/3] spi: dw: Propagate firmware node
Date:   Wed, 22 Dec 2021 17:57:38 +0200
Message-Id: <20211222155739.7699-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211222155739.7699-1-andriy.shevchenko@linux.intel.com>
References: <20211222155739.7699-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate firmware node by using a specific API call, i.e. device_set_node().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
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

