Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5130500F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 15:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbiDNNZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244229AbiDNNWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:22:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F0F92D33;
        Thu, 14 Apr 2022 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649942289; x=1681478289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NMZ03U0eg6eBQhOA9m78Pt/d+FZJvd2t8GerBvBRu4c=;
  b=KiyqWrO5+g01GBkMpftI1Hk8ZyjV3BiAXCFbnHXr09R25bCfB7PUdXYe
   JOLnSr2BwmYe05KNZ+T+U6Hbu/2BuD/DSxh508/++mrs2a9ICA79fSg23
   PkOtpYgalWZi4R1VCI5N/uFe4AbYyD6Btgn/h6SpRZy0VjHPbvnQwOgCC
   mrGrPUHzZjWI4vdRmuL4ySmHnfGS/tR8P3ajZ6FbyJBX3z7zla3Z3m47+
   OeNBObbmc9+52u1h48ufp+g4CxTKmRgULR+EgEFc5nArsbPx9m/l9uRhL
   nztiuolg4h4RhWBQXyD5PYwkHMoqOk6p5HVGPH4fjBsoizs4loEYUn4/t
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="260522554"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="260522554"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 06:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="591188379"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2022 06:18:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2D62B144; Thu, 14 Apr 2022 16:18:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/1] iio: imu: bmi160: Make use of device properties
Date:   Thu, 14 Apr 2022 16:18:04 +0300
Message-Id: <20220414131804.25227-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

While at it, reuse temporary device pointer in the same function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed subject to use proper part number in it
 drivers/iio/imu/bmi160/bmi160_core.c | 27 ++++++---------------------
 drivers/iio/imu/bmi160/bmi160_i2c.c  | 13 ++++++-------
 drivers/iio/imu/bmi160/bmi160_spi.c  | 18 +++++++++++-------
 3 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 01336105792e..e7aec56ea136 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -11,10 +11,9 @@
  */
 #include <linux/module.h>
 #include <linux/regmap.h>
-#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
-#include <linux/of_irq.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
@@ -525,17 +524,6 @@ static const struct iio_info bmi160_info = {
 	.attrs = &bmi160_attrs_group,
 };
 
-static const char *bmi160_match_acpi_device(struct device *dev)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-
-	return dev_name(dev);
-}
-
 static int bmi160_write_conf_reg(struct regmap *regmap, unsigned int reg,
 				 unsigned int mask, unsigned int bits,
 				 unsigned int write_usleep)
@@ -647,18 +635,18 @@ int bmi160_enable_irq(struct regmap *regmap, bool enable)
 }
 EXPORT_SYMBOL(bmi160_enable_irq);
 
-static int bmi160_get_irq(struct device_node *of_node, enum bmi160_int_pin *pin)
+static int bmi160_get_irq(struct fwnode_handle *fwnode, enum bmi160_int_pin *pin)
 {
 	int irq;
 
 	/* Use INT1 if possible, otherwise fall back to INT2. */
-	irq = of_irq_get_byname(of_node, "INT1");
+	irq = fwnode_irq_get_byname(fwnode, "INT1");
 	if (irq > 0) {
 		*pin = BMI160_PIN_INT1;
 		return irq;
 	}
 
-	irq = of_irq_get_byname(of_node, "INT2");
+	irq = fwnode_irq_get_byname(fwnode, "INT2");
 	if (irq > 0)
 		*pin = BMI160_PIN_INT2;
 
@@ -688,7 +676,7 @@ static int bmi160_config_device_irq(struct iio_dev *indio_dev, int irq_type,
 		return -EINVAL;
 	}
 
-	open_drain = of_property_read_bool(dev->of_node, "drive-open-drain");
+	open_drain = device_property_read_bool(dev, "drive-open-drain");
 
 	return bmi160_config_pin(data->regmap, pin, open_drain, irq_mask,
 				 BMI160_NORMAL_WRITE_USLEEP);
@@ -872,9 +860,6 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
-	if (!name && ACPI_HANDLE(dev))
-		name = bmi160_match_acpi_device(dev);
-
 	indio_dev->channels = bmi160_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bmi160_channels);
 	indio_dev->name = name;
@@ -887,7 +872,7 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
-	irq = bmi160_get_irq(dev->of_node, &int_pin);
+	irq = bmi160_get_irq(dev_fwnode(dev), &int_pin);
 	if (irq > 0) {
 		ret = bmi160_setup_irq(indio_dev, irq, int_pin);
 		if (ret)
diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index 26398614eddf..02f149d37b17 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -8,10 +8,9 @@
  *      - 0x68 if SDO is pulled to GND
  *      - 0x69 if SDO is pulled to VDDIO
  */
-#include <linux/acpi.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/regmap.h>
 
 #include "bmi160.h"
@@ -20,7 +19,7 @@ static int bmi160_i2c_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
 	struct regmap *regmap;
-	const char *name = NULL;
+	const char *name;
 
 	regmap = devm_regmap_init_i2c(client, &bmi160_regmap_config);
 	if (IS_ERR(regmap)) {
@@ -31,6 +30,8 @@ static int bmi160_i2c_probe(struct i2c_client *client,
 
 	if (id)
 		name = id->name;
+	else
+		name = dev_name(&client->dev);
 
 	return bmi160_core_probe(&client->dev, regmap, name, false);
 }
@@ -47,19 +48,17 @@ static const struct acpi_device_id bmi160_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
 
-#ifdef CONFIG_OF
 static const struct of_device_id bmi160_of_match[] = {
 	{ .compatible = "bosch,bmi160" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bmi160_of_match);
-#endif
 
 static struct i2c_driver bmi160_i2c_driver = {
 	.driver = {
 		.name			= "bmi160_i2c",
-		.acpi_match_table	= ACPI_PTR(bmi160_acpi_match),
-		.of_match_table		= of_match_ptr(bmi160_of_match),
+		.acpi_match_table	= bmi160_acpi_match,
+		.of_match_table		= bmi160_of_match,
 	},
 	.probe		= bmi160_i2c_probe,
 	.id_table	= bmi160_i2c_id,
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index 61389b41c6d9..24f7d75c7903 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -5,9 +5,8 @@
  * Copyright (c) 2016, Intel Corporation.
  *
  */
-#include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
@@ -17,6 +16,7 @@ static int bmi160_spi_probe(struct spi_device *spi)
 {
 	struct regmap *regmap;
 	const struct spi_device_id *id = spi_get_device_id(spi);
+	const char *name;
 
 	regmap = devm_regmap_init_spi(spi, &bmi160_regmap_config);
 	if (IS_ERR(regmap)) {
@@ -24,7 +24,13 @@ static int bmi160_spi_probe(struct spi_device *spi)
 			regmap);
 		return PTR_ERR(regmap);
 	}
-	return bmi160_core_probe(&spi->dev, regmap, id->name, true);
+
+	if (id)
+		name = id->name;
+	else
+		name = dev_name(&spi->dev);
+
+	return bmi160_core_probe(&spi->dev, regmap, name, true);
 }
 
 static const struct spi_device_id bmi160_spi_id[] = {
@@ -39,20 +45,18 @@ static const struct acpi_device_id bmi160_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
 
-#ifdef CONFIG_OF
 static const struct of_device_id bmi160_of_match[] = {
 	{ .compatible = "bosch,bmi160" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bmi160_of_match);
-#endif
 
 static struct spi_driver bmi160_spi_driver = {
 	.probe		= bmi160_spi_probe,
 	.id_table	= bmi160_spi_id,
 	.driver = {
-		.acpi_match_table	= ACPI_PTR(bmi160_acpi_match),
-		.of_match_table		= of_match_ptr(bmi160_of_match),
+		.acpi_match_table	= bmi160_acpi_match,
+		.of_match_table		= bmi160_of_match,
 		.name			= "bmi160_spi",
 	},
 };
-- 
2.35.1

