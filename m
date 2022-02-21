Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E812A4BEE2A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbiBUXdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:33:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbiBUXcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:32:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678C324F33;
        Mon, 21 Feb 2022 15:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645486349; x=1677022349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PJymbTaSO09XOMHXwdDAoahjL89w8zWaJcq+um8AFW4=;
  b=e0yFP9kk0sPDyflRjbHheIwRWXTZnL+fg/UdJoPT4igJnKlWb2ot4Mwu
   FNGhl4IwaBUkYRnPqCfLIXy8D74w6r7LXm6HoFxxn7rpRl3oPzB/3LpAe
   mkybvi690J3OhkGq1L3sZ/2QLXZU6eayJ2l8FIKkxEOXDJpN2sR7tg+Lu
   /Sgp48ZORs3OYOZw9T+awmQJOgaJkLYTUJPUhX2YXrNuwgW/zYzrUXVFG
   N6YFJKQvkWFVmFsAwYMf+yydz+pYRAh8GKKe6MjhnZewAOqci/0Z5IbM+
   SunsTueT94U5abbLSHn2DQovkHoO6ronCvRBOzPQ7gWvAsbkJJds+3uAI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="232200044"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="232200044"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="776116177"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2022 15:32:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CC28E1ED; Tue, 22 Feb 2022 01:32:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v1 4/8] iio: accel: adxl345: Make use of device properties
Date:   Tue, 22 Feb 2022 01:32:31 +0200
Message-Id: <20220221233235.86893-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
References: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/accel/adxl345.h      |  2 +-
 drivers/iio/accel/adxl345_core.c |  5 ++++-
 drivers/iio/accel/adxl345_i2c.c  | 11 ++++-------
 drivers/iio/accel/adxl345_spi.c  |  3 +--
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 9b0d4f487c43..d7e67cb08538 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -13,6 +13,6 @@ enum adxl345_device_type {
 	ADXL375 = 2,
 };
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap, enum adxl345_device_type type);
+int adxl345_core_probe(struct device *dev, struct regmap *regmap);
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 0f34c349aa1e..315a408115b3 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
@@ -213,14 +214,16 @@ static void adxl345_powerdown(void *regmap)
 	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
 }
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap, enum adxl345_device_type type)
+int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 {
+	enum adxl345_device_type type;
 	struct adxl345_data *data;
 	struct iio_dev *indio_dev;
 	const char *name;
 	u32 regval;
 	int ret;
 
+	type = (uintptr_t)device_get_match_data(dev);
 	switch (type) {
 	case ADXL345:
 		name = "adxl345";
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 2da1f73e6f03..581196e72291 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -19,19 +19,16 @@ static const struct regmap_config adxl345_i2c_regmap_config = {
 	.val_bits = 8,
 };
 
-static int adxl345_i2c_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static int adxl345_i2c_probe(struct i2c_client *client)
 {
+	enum adxl345_device_type type;
 	struct regmap *regmap;
 
-	if (!id)
-		return -ENODEV;
-
 	regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&client->dev, regmap, id->driver_data);
+	return adxl345_core_probe(&client->dev, regmap);
 }
 
 static const struct i2c_device_id adxl345_i2c_id[] = {
@@ -55,7 +52,7 @@ static struct i2c_driver adxl345_i2c_driver = {
 		.name	= "adxl345_i2c",
 		.of_match_table = adxl345_of_match,
 	},
-	.probe		= adxl345_i2c_probe,
+	.probe_new	= adxl345_i2c_probe,
 	.id_table	= adxl345_i2c_id,
 };
 
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 28f8d15cd257..1ea9933a909e 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -22,7 +22,6 @@ static const struct regmap_config adxl345_spi_regmap_config = {
 
 static int adxl345_spi_probe(struct spi_device *spi)
 {
-	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct regmap *regmap;
 
 	/* Bail out if max_speed_hz exceeds 5 MHz */
@@ -33,7 +32,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&spi->dev, regmap, id->driver_data);
+	return adxl345_core_probe(&spi->dev, regmap);
 }
 
 static const struct spi_device_id adxl345_spi_id[] = {
-- 
2.34.1

