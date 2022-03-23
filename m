Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA424E53DF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbiCWODx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241629AbiCWODt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:03:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244737EA2A;
        Wed, 23 Mar 2022 07:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648044140; x=1679580140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6JzlOM0Zp9+nJWpyflWqezPxav66g3ZVKXHPUjsbyW8=;
  b=J9x4eMkEvFxCiYjNs22Y4oOHlQeEc0E1PX55Fa35vyrF4jZEsfAu+jFG
   4B3KgIe1z5nYpdrvFNsgXFPmLZYEBnLkF0xAxHq5aod01exlJDh/Q8/86
   mPgv2ucYVyHL+si1+w31qYsQ50SlNF7PmQs5itQ55M1aQgmgNe+SNuntu
   3z4FEoDCxXZ+3fg7VlRq0vmd6vpWGCBaOwcKGqyQI+7df6tNxv5woYyhG
   cgXEaTP3GTatoAsKoQAO61k+IVpBASxH97zlofuTZgKup5MWbdJhwd6wh
   KCCV3vslh6vNQFOTLlLYb0X4gH9U1Ok2tzp93CzhhFSZOFtqd/kFW4odP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="258304809"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="258304809"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 07:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="785796352"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2022 07:01:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 09864252; Wed, 23 Mar 2022 16:02:18 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 4/4] spidev: Replace OF specific code by device property API
Date:   Wed, 23 Mar 2022 16:02:15 +0200
Message-Id: <20220323140215.2568-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
References: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling the OF specific APIs, use device property ones.

It also prevents misusing PRP0001 in ACPI when trying to instantiate
spidev directly. We only support special SPI test devices there.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spidev.c | 45 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 13dea81b21be..ffa124665cf3 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -20,8 +20,6 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spidev.h>
@@ -695,20 +693,31 @@ static const struct spi_device_id spidev_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
 
-#ifdef CONFIG_OF
+/*
+ * spidev should never be referenced in DT without a specific compatible string,
+ * it is a Linux implementation thing rather than a description of the hardware.
+ */
+static int spidev_of_check(struct device *dev)
+{
+	if (device_property_match_string(dev, "compatible", "spidev") < 0)
+		return 0;
+
+	dev_err(dev, "spidev listed directly in DT is not supported\n");
+	return -EINVAL;
+}
+
 static const struct of_device_id spidev_dt_ids[] = {
-	{ .compatible = "rohm,dh2228fv" },
-	{ .compatible = "lineartechnology,ltc2488" },
-	{ .compatible = "semtech,sx1301" },
-	{ .compatible = "lwn,bk4" },
-	{ .compatible = "dh,dhcom-board" },
-	{ .compatible = "menlo,m53cpld" },
-	{ .compatible = "cisco,spi-petra" },
-	{ .compatible = "micron,spi-authenta" },
+	{ .compatible = "rohm,dh2228fv", .data = &spidev_of_check },
+	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
+	{ .compatible = "semtech,sx1301", .data = &spidev_of_check },
+	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
+	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
+	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
+	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
+	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-#endif
 
 /* Dummy SPI devices not to be used in production systems */
 static int spidev_acpi_check(struct device *dev)
@@ -740,16 +749,6 @@ static int spidev_probe(struct spi_device *spi)
 	int			status;
 	unsigned long		minor;
 
-	/*
-	 * spidev should never be referenced in DT without a specific
-	 * compatible string, it is a Linux implementation thing
-	 * rather than a description of the hardware.
-	 */
-	if (spi->dev.of_node && of_device_is_compatible(spi->dev.of_node, "spidev")) {
-		dev_err(&spi->dev, "spidev listed directly in DT is not supported\n");
-		return -EINVAL;
-	}
-
 	match = device_get_match_data(&spi->dev);
 	if (match) {
 		status = match(&spi->dev);
@@ -824,7 +823,7 @@ static void spidev_remove(struct spi_device *spi)
 static struct spi_driver spidev_spi_driver = {
 	.driver = {
 		.name =		"spidev",
-		.of_match_table = of_match_ptr(spidev_dt_ids),
+		.of_match_table = spidev_dt_ids,
 		.acpi_match_table = spidev_acpi_ids,
 	},
 	.probe =	spidev_probe,
-- 
2.35.1

