Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A404E53E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiCWOEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244635AbiCWOEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:04:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E370D7EA18;
        Wed, 23 Mar 2022 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648044156; x=1679580156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VfQvSnfBEM1D70TX51wsgIozq39RVuCScR8TXh6ANO0=;
  b=gKgSb8FrLrpC+0ZLvw5XTd5VDb+rgTt0HZNUThFwG+yqK6IjBcIF/knB
   rPKFjJW3Ty+0IjsxVzo6mja8abd/ybQELW6EIpmS12CSZFWpQ7WU664/M
   6rBzLqrW64I1FdzKrwxdvAOycurOAHAPVKCWl6CwsfxRTlQUDYAHh9/mR
   dj01xC9hB3KJUco24YmGL6T+EYH9hd3Wxmtjw5Ht1xfeRPlF9SSYrvsQq
   lP4qybv7jYd207E6+GEgAjPjKF3vJxx2nZMZSkEFeNu3JXPql5Rn1+T1Z
   Zw08GYE1Vn+MwjeIe/COIHQgqjRT3u1qN+yGS0Kkm7oC65TTnQMbGopyy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="256938318"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="256938318"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 07:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="825321754"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 23 Mar 2022 07:01:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F40B92A6; Wed, 23 Mar 2022 16:02:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/4] spidev: Replace ACPI specific code by device_get_match_data()
Date:   Wed, 23 Mar 2022 16:02:14 +0200
Message-Id: <20220323140215.2568-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
References: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling the ACPI specific APIs, use device_get_match_data().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spidev.c | 47 ++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 125da8d0e719..13dea81b21be 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -8,19 +8,20 @@
  */
 
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/ioctl.h>
 #include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/errno.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/acpi.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spidev.h>
@@ -709,10 +710,12 @@ static const struct of_device_id spidev_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
 #endif
 
-#ifdef CONFIG_ACPI
-
 /* Dummy SPI devices not to be used in production systems */
-#define SPIDEV_ACPI_DUMMY	1
+static int spidev_acpi_check(struct device *dev)
+{
+	dev_warn(dev, "do not use this driver in production systems!\n");
+	return 0;
+}
 
 static const struct acpi_device_id spidev_acpi_ids[] = {
 	/*
@@ -721,35 +724,18 @@ static const struct acpi_device_id spidev_acpi_ids[] = {
 	 * description of the connected peripheral and they should also use
 	 * a proper driver instead of poking directly to the SPI bus.
 	 */
-	{ "SPT0001", SPIDEV_ACPI_DUMMY },
-	{ "SPT0002", SPIDEV_ACPI_DUMMY },
-	{ "SPT0003", SPIDEV_ACPI_DUMMY },
+	{ "SPT0001", (kernel_ulong_t)&spidev_acpi_check },
+	{ "SPT0002", (kernel_ulong_t)&spidev_acpi_check },
+	{ "SPT0003", (kernel_ulong_t)&spidev_acpi_check },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, spidev_acpi_ids);
 
-static void spidev_probe_acpi(struct spi_device *spi)
-{
-	const struct acpi_device_id *id;
-
-	if (!has_acpi_companion(&spi->dev))
-		return;
-
-	id = acpi_match_device(spidev_acpi_ids, &spi->dev);
-	if (WARN_ON(!id))
-		return;
-
-	if (id->driver_data == SPIDEV_ACPI_DUMMY)
-		dev_warn(&spi->dev, "do not use this driver in production systems!\n");
-}
-#else
-static inline void spidev_probe_acpi(struct spi_device *spi) {}
-#endif
-
 /*-------------------------------------------------------------------------*/
 
 static int spidev_probe(struct spi_device *spi)
 {
+	int (*match)(struct device *dev);
 	struct spidev_data	*spidev;
 	int			status;
 	unsigned long		minor;
@@ -764,7 +750,12 @@ static int spidev_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	spidev_probe_acpi(spi);
+	match = device_get_match_data(&spi->dev);
+	if (match) {
+		status = match(&spi->dev);
+		if (status)
+			return status;
+	}
 
 	/* Allocate driver data */
 	spidev = kzalloc(sizeof(*spidev), GFP_KERNEL);
@@ -834,7 +825,7 @@ static struct spi_driver spidev_spi_driver = {
 	.driver = {
 		.name =		"spidev",
 		.of_match_table = of_match_ptr(spidev_dt_ids),
-		.acpi_match_table = ACPI_PTR(spidev_acpi_ids),
+		.acpi_match_table = spidev_acpi_ids,
 	},
 	.probe =	spidev_probe,
 	.remove =	spidev_remove,
-- 
2.35.1

