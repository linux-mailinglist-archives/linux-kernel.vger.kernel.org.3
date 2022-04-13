Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FEE4FFC47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbiDMRXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiDMRXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:23:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8494E62BE5;
        Wed, 13 Apr 2022 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649870486; x=1681406486;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wg9FsEmQwnZBXMrOYDH5tWUBw/2avAOrNH6ZhkaMiwk=;
  b=m42hV/3YyWNx27KzPn0npI7s8Ng9g8av+vuX4px3FXlWbYJAhgNkApAR
   60zw2xj/IJ6HR0TcK+pLdltqaxdZNhspYQNqyRNT16/Aj4jI7NygJkfKV
   pxweE8d0eg+g2zwa7ZNqADwbeWNoLu3QbfqsxE2K5f526gW0Kgvy5exXz
   xKU08BvpLCcwZa0CYFz5q1VcxaX1zCtUgmueEvAOw1DrNK9RjLC+SwBl3
   pIU60BcB/rrpTnombDdoSBillqO+ZrunFrSE/eZ75ACR3gneh33KDT6RY
   0xiTi5axGcqZncHNtxYyOm+8z3IQhthtg6V/3kCiKRhyDI38iUw2sKrKX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="261572801"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="261572801"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 10:21:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="508059116"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Apr 2022 10:21:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 057F712C; Wed, 13 Apr 2022 20:21:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: imu: mpu3050: Make use of device properties
Date:   Wed, 13 Apr 2022 20:21:22 +0300
Message-Id: <20220413172122.85629-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

While at it, reuse temporary device pointer in the same function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

