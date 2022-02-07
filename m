Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851CC4ABF65
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448568AbiBGNMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446786AbiBGMnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:43:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2986C0401C5;
        Mon,  7 Feb 2022 04:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644237713; x=1675773713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lthWInRe5rhsFpXyr44BcVGfaJiVQJ2UlxjwGFZbtNQ=;
  b=XNT1fQWLr+sI4RLUBAZFk7TEsWNaxnqTUHTM6CDA0eikp5DVR4TXz8C6
   0KYyIA21g5orVtrrSIJXtjl67VKM4FmnhZLNkOaY1N/t7qJJzOjYt5Zqg
   jVoVZuekv02AX6M9zcjR4aIu5PRfukjefwqZSGCUxWkNz+i5QnY6SZtMr
   9uYJlHvQKgryMZ+6hGm5zIMhwKBvyXJRE1KnPWxTOciPGleMB88vlWeZj
   4VeOTdfsRppYtHeTaeVp6viKzNCwP9x15+vMgPgBZTwB2mWs9+lomG+Vo
   CDqBJmnZ7alB+DqcY365jE6cO0lUqSCD93KdmeIgg03JTMSq9n/8c0lhY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="229354774"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="229354774"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 04:41:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="536203226"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 07 Feb 2022 04:41:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E71F53ED; Mon,  7 Feb 2022 14:42:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 1/1] iio: chemical: atlas-ezo-sensor: Make use of device properties
Date:   Mon,  7 Feb 2022 14:42:04 +0200
Message-Id: <20220207124204.11658-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: reincarnated enum (Jonathan)
 drivers/iio/chemical/atlas-ezo-sensor.c | 32 +++++++++++++------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index b1bacfe3c3ce..bbcf5a59c1f4 100644
--- a/drivers/iio/chemical/atlas-ezo-sensor.c
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -6,13 +6,15 @@
  * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  */
 
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/of_device.h>
+
 #include <linux/iio/iio.h>
 
 #define ATLAS_EZO_DRV_NAME		"atlas-ezo-sensor"
@@ -33,7 +35,7 @@ struct atlas_ezo_device {
 
 struct atlas_ezo_data {
 	struct i2c_client *client;
-	struct atlas_ezo_device *chip;
+	const struct atlas_ezo_device *chip;
 
 	/* lock to avoid multiple concurrent read calls */
 	struct mutex lock;
@@ -184,17 +186,17 @@ static const struct iio_info atlas_info = {
 };
 
 static const struct i2c_device_id atlas_ezo_id[] = {
-	{ "atlas-co2-ezo", ATLAS_CO2_EZO },
-	{ "atlas-o2-ezo", ATLAS_O2_EZO },
-	{ "atlas-hum-ezo", ATLAS_HUM_EZO },
+	{ "atlas-co2-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_CO2_EZO] },
+	{ "atlas-o2-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_O2_EZO] },
+	{ "atlas-hum-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_HUM_EZO] },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
 
 static const struct of_device_id atlas_ezo_dt_ids[] = {
-	{ .compatible = "atlas,co2-ezo", .data = (void *)ATLAS_CO2_EZO, },
-	{ .compatible = "atlas,o2-ezo", .data = (void *)ATLAS_O2_EZO, },
-	{ .compatible = "atlas,hum-ezo", .data = (void *)ATLAS_HUM_EZO, },
+	{ .compatible = "atlas,co2-ezo", .data = &atlas_ezo_devices[ATLAS_CO2_EZO], },
+	{ .compatible = "atlas,o2-ezo", .data = &atlas_ezo_devices[ATLAS_O2_EZO], },
+	{ .compatible = "atlas,hum-ezo", .data = &atlas_ezo_devices[ATLAS_HUM_EZO], },
 	{}
 };
 MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
@@ -202,20 +204,20 @@ MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
 static int atlas_ezo_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
+	const struct atlas_ezo_device *chip;
 	struct atlas_ezo_data *data;
-	struct atlas_ezo_device *chip;
-	const struct of_device_id *of_id;
 	struct iio_dev *indio_dev;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
-	of_id = of_match_device(atlas_ezo_dt_ids, &client->dev);
-	if (!of_id)
-		chip = &atlas_ezo_devices[id->driver_data];
+	if (dev_fwnode(&client->dev))
+		chip = device_get_match_data(&client->dev);
 	else
-		chip = &atlas_ezo_devices[(unsigned long)of_id->data];
+		chip = (const struct atlas_ezo_device *)id->driver_data;
+	if (!chip)
+		return -EINVAL;
 
 	indio_dev->info = &atlas_info;
 	indio_dev->name = ATLAS_EZO_DRV_NAME;
-- 
2.34.1

