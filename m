Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4905A4BEE47
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbiBUXdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:33:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiBUXdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:33:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA125581;
        Mon, 21 Feb 2022 15:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645486354; x=1677022354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=imNLxLyCLC6kS5S2zcR0GoVYN1GbzR0z62gzwSxoDIg=;
  b=R3PVY5XJ0gdl624ET/uyNaY7nzQQKJscCCWD05P1Klrw6s0FIOief+ma
   X/OtXlnOadavC1Y+8Ou79LjrcGHim6YVZO2O77x6UVAcaqFVBHQRKS4KG
   0KEo8Czbc8T4HwvRw9bwBrQUxKI8SSh8vhw2bnORc+G/8y3GJFNQYs9RO
   3VhtYbQHkaaavx5uKoASI0w9vBAU6QBdvyJ8RsicylFeyBqdrCMMaFNtD
   isSUg+MVk30jD3esFBcAJPh9nNfIJ5TNlauHINvVRuisZIV8+/lxe/w5G
   3KVhLX0wv0QDMaQIYbaMtDdlozovIiUEv0uMUPovCYspiVDHQMYo3xDCj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251347123"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="251347123"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="627497017"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2022 15:32:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C36EB1D6; Tue, 22 Feb 2022 01:32:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v1 3/8] iio: accel: adxl345: Get rid of name parameter in adxl345_core_probe()
Date:   Tue, 22 Feb 2022 01:32:30 +0200
Message-Id: <20220221233235.86893-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
References: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
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

As a preparation to switch to use device properties, get rid of name
parameter in adxl345_core_probe(). Instead, choose it based on the type.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/adxl345.h      |  3 +--
 drivers/iio/accel/adxl345_core.c | 15 +++++++++++++--
 drivers/iio/accel/adxl345_i2c.c  |  3 +--
 drivers/iio/accel/adxl345_spi.c  |  2 +-
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 5a68d4dac717..9b0d4f487c43 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -13,7 +13,6 @@ enum adxl345_device_type {
 	ADXL375 = 2,
 };
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap,
-		       enum adxl345_device_type type, const char *name);
+int adxl345_core_probe(struct device *dev, struct regmap *regmap, enum adxl345_device_type type);
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 078e1029e49d..0f34c349aa1e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -213,14 +213,25 @@ static void adxl345_powerdown(void *regmap)
 	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
 }
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap,
-		       enum adxl345_device_type type, const char *name)
+int adxl345_core_probe(struct device *dev, struct regmap *regmap, enum adxl345_device_type type)
 {
 	struct adxl345_data *data;
 	struct iio_dev *indio_dev;
+	const char *name;
 	u32 regval;
 	int ret;
 
+	switch (type) {
+	case ADXL345:
+		name = "adxl345";
+		break;
+	case ADXL375:
+		name = "adxl375";
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Error reading device ID\n");
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 478ffc671035..2da1f73e6f03 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -31,8 +31,7 @@ static int adxl345_i2c_probe(struct i2c_client *client,
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&client->dev, regmap, id->driver_data,
-				  id->name);
+	return adxl345_core_probe(&client->dev, regmap, id->driver_data);
 }
 
 static const struct i2c_device_id adxl345_i2c_id[] = {
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 79f9428e39f8..28f8d15cd257 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -33,7 +33,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&spi->dev, regmap, id->driver_data, id->name);
+	return adxl345_core_probe(&spi->dev, regmap, id->driver_data);
 }
 
 static const struct spi_device_id adxl345_spi_id[] = {
-- 
2.34.1

