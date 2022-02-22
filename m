Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E988B4BF443
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiBVJAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiBVJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:00:21 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AE713D568;
        Tue, 22 Feb 2022 00:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645520396; x=1677056396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tuqRcRyw9c0tVwEZaLya9J85oZG+2E1rNuWZVStKrGE=;
  b=hiiJ/7JcjRpihaK8yeWVicqHlkgolk8dtmJqd9ZR9o3sdY/KiG31PEfZ
   Z+E6y3BrDIAfrSXPJdENKPF0hzTPr99A0TXF1WZxTJYIUvdFfikS2hmS6
   RiYmHQqAxsh3evpy4RwRc+ZoT8+rZplUQ992KVFBjCpkM81KHHF7grEGi
   HBC0uvlZ9pfQoHB0fdRlmLILwZJagLIgi4c4Y0gOcqFjR/vrZrb3Z0jKg
   dPv20mnsq6/9mIEolbYQmiivlQXk/xJ3eS66w0EVIkFvy1Ay80Kd0es/8
   YwtCS6M3EUEfE7WmdW43ugTWTBw9MiwsNfTGA0T1wiNR3kUjY48D4Veef
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251829059"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251829059"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 00:59:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="532145469"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 22 Feb 2022 00:59:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 97A93142; Tue, 22 Feb 2022 11:00:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 1/8] iio: accel: adxl345: Convert to use dev_err_probe()
Date:   Tue, 22 Feb 2022 11:00:02 +0200
Message-Id: <20220222090009.2060-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

It's fine to call dev_err_probe() in ->probe() when error code is known.
Convert the driver to use dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed typo (LKP), shorten one line to satisfy checkpatch
 drivers/iio/accel/adxl345_core.c | 26 +++++++++-----------------
 drivers/iio/accel/adxl345_i2c.c  |  7 ++-----
 drivers/iio/accel/adxl345_spi.c  | 15 +++++----------
 3 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index ef2240e356e0..078e1029e49d 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -222,16 +222,12 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	int ret;
 
 	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
-	if (ret < 0) {
-		dev_err(dev, "Error reading device ID: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Error reading device ID\n");
 
-	if (regval != ADXL345_DEVID) {
-		dev_err(dev, "Invalid device ID: %x, expected %x\n",
-			regval, ADXL345_DEVID);
-		return -ENODEV;
-	}
+	if (regval != ADXL345_DEVID)
+		return dev_err_probe(dev, -ENODEV, "Invalid device ID: %x, expected %x\n",
+				     regval, ADXL345_DEVID);
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -245,10 +241,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
 			   data->data_range);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set data range: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to set data range\n");
 
 	indio_dev->name = name;
 	indio_dev->info = &adxl345_info;
@@ -259,10 +253,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	/* Enable measurement mode */
 	ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
 			   ADXL345_POWER_CTL_MEASURE);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable measurement mode: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
 
 	ret = devm_add_action_or_reset(dev, adxl345_powerdown, data->regmap);
 	if (ret < 0)
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 7bc8324c4f07..e3205dce91b8 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -28,11 +28,8 @@ static int adxl345_i2c_probe(struct i2c_client *client,
 		return -ENODEV;
 
 	regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
 	return adxl345_core_probe(&client->dev, regmap, id->driver_data,
 				  id->name);
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index c752562c5d3b..9223302fdd46 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -26,18 +26,13 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	struct regmap *regmap;
 
 	/* Bail out if max_speed_hz exceeds 5 MHz */
-	if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ) {
-		dev_err(&spi->dev, "SPI CLK, %d Hz exceeds 5 MHz\n",
-			spi->max_speed_hz);
-		return -EINVAL;
-	}
+	if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ)
+		return dev_err_probe(&spi->dev, -EINVAL, "SPI CLK, %d Hz exceeds 5 MHz\n",
+				     spi->max_speed_hz);
 
 	regmap = devm_regmap_init_spi(spi, &adxl345_spi_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
 	return adxl345_core_probe(&spi->dev, regmap, id->driver_data, id->name);
 }
-- 
2.34.1

