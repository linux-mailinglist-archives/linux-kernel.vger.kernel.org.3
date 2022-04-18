Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F9504A46
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 02:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiDRAzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 20:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiDRAzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 20:55:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1CC13E3F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 17:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650243158; x=1681779158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b1gami6NL0UDyA6SSt0bS4l0fdA/2IRgmFFDRIKqqxw=;
  b=Ojk+KPhhpxEFhyw4Jq9vBS9F1a/jeTjA9hRQTXoqQzGWoyKvt56FBY7O
   qpRkfbbUWlqY0JdkvseVMdLTOEjoLX3mcQjFjGBuUUXe2Q5F+o8v5DCa1
   dJF04qJ+x8/v1dNVViQjHK/2DfMYQCHNGSXdUupdIa9TbQdUXC49gdlvs
   lOHiYk8DQUeQJBO2+OCX//nw/31mjgYJkB/WCodJoeX3Qqoo8O3MuL1uL
   W+v8Khnpg3mPPGO3LUPmwiuFufb+3d/Beb6zXd2x+rnmSYAs7u8JRaa9h
   3fqxXaRDzSu2Sux8NWUnbp6+uFXOyj5gGGtRNtlYDeywo2xrDntQOke8/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="245313213"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="245313213"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 17:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="701651283"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2022 17:52:36 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v8 03/11] amba: Stop sharing platform_dma_configure()
Date:   Mon, 18 Apr 2022 08:49:52 +0800
Message-Id: <20220418005000.897664-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418005000.897664-1-baolu.lu@linux.intel.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop sharing platform_dma_configure() helper as they are about to have
their own bus dma_configure callbacks.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/platform_device.h |  2 --
 drivers/amba/bus.c              | 19 ++++++++++++++++++-
 drivers/base/platform.c         |  3 +--
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7c96f169d274..17fde717df68 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -328,8 +328,6 @@ extern int platform_pm_restore(struct device *dev);
 #define platform_pm_restore		NULL
 #endif
 
-extern int platform_dma_configure(struct device *dev);
-
 #ifdef CONFIG_PM_SLEEP
 #define USE_PLATFORM_PM_SLEEP_OPS \
 	.suspend = platform_pm_suspend, \
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d3bd14aaabf6..76b52bd2c2a4 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -20,6 +20,8 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/of_irq.h>
+#include <linux/of_device.h>
+#include <linux/acpi.h>
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
@@ -273,6 +275,21 @@ static void amba_shutdown(struct device *dev)
 		drv->shutdown(to_amba_device(dev));
 }
 
+static int amba_dma_configure(struct device *dev)
+{
+	enum dev_dma_attr attr;
+	int ret = 0;
+
+	if (dev->of_node) {
+		ret = of_dma_configure(dev, dev->of_node, true);
+	} else if (has_acpi_companion(dev)) {
+		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
+		ret = acpi_dma_configure(dev, attr);
+	}
+
+	return ret;
+}
+
 #ifdef CONFIG_PM
 /*
  * Hooks to provide runtime PM of the pclk (bus clock).  It is safe to
@@ -341,7 +358,7 @@ struct bus_type amba_bustype = {
 	.probe		= amba_probe,
 	.remove		= amba_remove,
 	.shutdown	= amba_shutdown,
-	.dma_configure	= platform_dma_configure,
+	.dma_configure	= amba_dma_configure,
 	.pm		= &amba_pm,
 };
 EXPORT_SYMBOL_GPL(amba_bustype);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8cc272fd5c99..d7915734d931 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1454,8 +1454,7 @@ static void platform_shutdown(struct device *_dev)
 		drv->shutdown(dev);
 }
 
-
-int platform_dma_configure(struct device *dev)
+static int platform_dma_configure(struct device *dev)
 {
 	enum dev_dma_attr attr;
 	int ret = 0;
-- 
2.25.1

