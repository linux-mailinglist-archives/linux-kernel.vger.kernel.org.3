Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C65047D477
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbhLVP5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:57:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:50990 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343765AbhLVP5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640188655; x=1671724655;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cH+SPBYsfFuuHbv9XNShzanFxeXA/W1PKBHvRD1wzMs=;
  b=KdhtgZKh1i0GJ2x0JZtom70seKxhK3Jy5q4Nx86Y2r12HKCiQlvnLUfH
   xEmtqskHMqtHttz82GFZxUDrwwsVujsoYz8nqmqLHd9HpS9Q770e+PUZ1
   qPfz2IVl1YcsUnrpDkCugZjEUopmSnnEA7Hq2DZN2mtvQWJY2zP+9R/cO
   w0kXT9awdKE3w0tMjLEryJQ7PYYtPHWQ1jQW5RYsLywLxAu2wa+8YhaUN
   HidvHkvGDYPzIyEWUevPlXTT1eqvEZvmdsynFRL6kTerHlPTvT7MLVu5P
   jDD0qu8fpsc2SIshMGHWuUT5ZFvWSWOc4cwy/lpRphEhVKFNwWcxXOWlf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="227495764"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="227495764"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 07:57:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="570608655"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 22 Dec 2021 07:57:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0AA33FE; Wed, 22 Dec 2021 17:57:40 +0200 (EET)
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
Subject: [PATCH v2 1/3] spi: dln2: Propagate firmware node
Date:   Wed, 22 Dec 2021 17:57:37 +0200
Message-Id: <20211222155739.7699-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate firmware node by using a specific API call, i.e. device_set_node().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: included property.h to avoid compilation error (Mark)
 drivers/spi/spi-dln2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index 3ff63ab82f4f..0a1fb2bc9e54 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/mfd/dln2.h>
 #include <linux/spi/spi.h>
 #include <linux/pm_runtime.h>
@@ -688,6 +689,8 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
+	device_set_node(&master->dev, dev_fwnode(dev));
+
 	platform_set_drvdata(pdev, master);
 
 	dln2 = spi_master_get_devdata(master);
@@ -699,7 +702,6 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	}
 
 	dln2->master = master;
-	dln2->master->dev.of_node = dev->of_node;
 	dln2->pdev = pdev;
 	dln2->port = pdata->port;
 	/* cs/mode can never be 0xff, so the first transfer will set them */
-- 
2.34.1

