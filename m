Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410D54BEDFE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbiBUXdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:33:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbiBUXdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:33:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E72125582;
        Mon, 21 Feb 2022 15:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645486354; x=1677022354;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wFraGabFhN4wKBeOKdJ+VgSXtoJa/BMVGLZwHRhGg/o=;
  b=gOmTaSGlULycdn2y0Y+nKy8fb8kzJrntc2zSY9zLYC7vJ4otc4uyg43V
   5K3hG1zvFEaR+vEPHgh6khBpWoeQEHU5hP/SVirEDTbxvYBChZ5fSXKnR
   /A+a3ZnnI9jt0U5mpPvx/2kU6P7GYpgENhO9DOFgQxsC8N9q+V5HNV40v
   nIxmrlG62C78wb93foN1yq8Ni2Igcm4i5DEu3Ghrx81MFOYLVikazfdoo
   0EX1r4PsSAJMrt3qU98a7S/Gh2wo7N6OKdGgs/y/9kA6JZw0sAnbI68+s
   5/7NkjYOd1KE9NORWuFMSne1DDDn+b7MyqOGTiySqYpe1L72QMJLBrBUt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251347124"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="251347124"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="573233108"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 21 Feb 2022 15:32:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AC83112C; Tue, 22 Feb 2022 01:32:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v1 1/8] iio: accel: adxl345: Convert to use dev_err_probe()
Date:   Tue, 22 Feb 2022 01:32:28 +0200
Message-Id: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's fine to call dev_err_probe() in ->probe() when error code is known.
Convert the driver to use dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/adxl345_core.c | 26 +++++++++-----------------
 drivers/iio/accel/adxl345_i2c.c  |  7 ++-----
 drivers/iio/accel/adxl345_spi.c  | 14 ++++----------
 3 files changed, 15 insertions(+), 32 deletions(-)

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
index 7bc8324c4f07..d6dd715bf404 100644
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
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
 	return adxl345_core_probe(&client->dev, regmap, id->driver_data,
 				  id->name);
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index c752562c5d3b..6984b13f32e8 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -26,18 +26,12 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	struct regmap *regmap;
 
 	/* Bail out if max_speed_hz exceeds 5 MHz */
-	if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ) {
-		dev_err(&spi->dev, "SPI CLK, %d Hz exceeds 5 MHz\n",
-			spi->max_speed_hz);
-		return -EINVAL;
-	}
+	if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ)
+		return dev_err_probe(&spi->dev, -EINVAL, "SPI CLK, %d Hz exceeds 5 MHz\n", spi->max_speed_hz);
 
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

