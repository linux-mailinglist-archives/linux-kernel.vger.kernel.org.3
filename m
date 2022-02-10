Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150B74B0F77
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbiBJN5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:57:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242513AbiBJN5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:57:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31061BF5;
        Thu, 10 Feb 2022 05:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644501433; x=1676037433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OFP1NltEDOTkFZpR5z2865Gx8le09uqHZgXyYOTV2S4=;
  b=captqA7NfiTaSUeYOqjU1bXEluI1uDcuFnafc+vB35D23AwoMhX0yPUe
   h2m0V9l/wI2tNMNpv5ejunl+Ow/brKzpcnNJC04EeQXl1eVSNJ4tEnpjY
   /+L6QPu1ZN/p2aZ5jOB9N2wePeoceYVJB3Mwml+yNFzL/q+/fBaWLJOkL
   lj2NzA3yCLkjcE9TqLuudAHgQ4q1+FFtvMDz9YiTsRbdDfeZ2WT7GnGls
   WVNFACV/5+3hEbosvkbHPSLjIUECYN15LiJ7pHpLMZVEwfGEtse3pKl0Z
   p5woW2/XbAcR9wvtWa880wU8u+OPtOC0CQk0pO2hkHJgRlmShaNrvFbgL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="233054007"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="233054007"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 05:57:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="773875261"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2022 05:57:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 20FC9366; Thu, 10 Feb 2022 15:57:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: ssp_sensors: Make use of device properties
Date:   Thu, 10 Feb 2022 15:57:24 +0200
Message-Id: <20220210135724.26660-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index eafaf4529df5..c1abd20ff808 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -7,9 +7,10 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/property.h>
+
 #include "ssp.h"
 
 #define SSP_WDT_TIME			10000
@@ -425,7 +426,6 @@ int ssp_queue_ssp_refresh_task(struct ssp_data *data, unsigned int delay)
 				  msecs_to_jiffies(delay));
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id ssp_of_match[] = {
 	{
 		.compatible	= "samsung,sensorhub-rinato",
@@ -441,8 +441,6 @@ MODULE_DEVICE_TABLE(of, ssp_of_match);
 static struct ssp_data *ssp_parse_dt(struct device *dev)
 {
 	struct ssp_data *data;
-	struct device_node *node = dev->of_node;
-	const struct of_device_id *match;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -461,22 +459,12 @@ static struct ssp_data *ssp_parse_dt(struct device *dev)
 	if (IS_ERR(data->mcu_reset_gpiod))
 		return NULL;
 
-	match = of_match_node(ssp_of_match, node);
-	if (!match)
-		return NULL;
-
-	data->sensorhub_info = match->data;
+	data->sensorhub_info = device_get_match_data(dev);
 
 	dev_set_drvdata(dev, data);
 
 	return data;
 }
-#else
-static struct ssp_data *ssp_parse_dt(struct device *pdev)
-{
-	return NULL;
-}
-#endif
 
 /**
  * ssp_register_consumer() - registers iio consumer in ssp framework
@@ -670,7 +658,7 @@ static struct spi_driver ssp_driver = {
 	.remove = ssp_remove,
 	.driver = {
 		.pm = &ssp_pm_ops,
-		.of_match_table = of_match_ptr(ssp_of_match),
+		.of_match_table = ssp_of_match,
 		.name = "sensorhub"
 	},
 };
-- 
2.34.1

