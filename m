Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3092A4BF447
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiBVJAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiBVJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:00:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F9813D57C;
        Tue, 22 Feb 2022 00:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645520397; x=1677056397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VHUSriWSk8GyJqXL7DN4Focv9W+osyWzJ9YdqQtFgTA=;
  b=HS8vmaj2yeiJ6XzEZHhB7Qit0BpQjYOx2YL+85EwvxQWNR6dQn4s4z0I
   Nlw05gzA2B3LuJ/xgXgCFV/pekMrELeYY0usnJIjPtexngUZcHLbyYKwq
   QEAIcY++T7pRjwWdlouyow5c9RXU5L6PsscchWW2JO9VDFo2lhachnwf5
   Jl6pqZGLbnb37nTcnQKN353wrIS/+pzUQq6pJy3eh23MH6FZpycvYEJF0
   k/rXTQyaqELJtAuFS1S/+Q6mZtdnPIjMVfox8AP1K7AFsCSWDEWgWf8fs
   LSSlbTEAXjFOMt1YLH0YrrUKOZ1/ZAdV87+KSGYNBWZllXUO8/1YDyeT3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251829061"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251829061"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 00:59:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="507905724"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 22 Feb 2022 00:59:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B23591ED; Tue, 22 Feb 2022 11:00:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 3/8] iio: accel: adxl345: Get rid of name parameter in adxl345_core_probe()
Date:   Tue, 22 Feb 2022 11:00:04 +0200
Message-Id: <20220222090009.2060-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222090009.2060-1-andriy.shevchenko@linux.intel.com>
References: <20220222090009.2060-1-andriy.shevchenko@linux.intel.com>
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

As a preparation to switch to use device properties, get rid of name
parameter in adxl345_core_probe(). Instead, choose it based on the type.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
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
index 4c6efe2eefc1..1e42cf3a2991 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -31,8 +31,7 @@ static int adxl345_i2c_probe(struct i2c_client *client,
 	if (IS_ERR(regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&client->dev, regmap, id->driver_data,
-				  id->name);
+	return adxl345_core_probe(&client->dev, regmap, id->driver_data);
 }
 
 static const struct i2c_device_id adxl345_i2c_id[] = {
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 72550132b1bb..34b7001d519f 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -34,7 +34,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&spi->dev, regmap, id->driver_data, id->name);
+	return adxl345_core_probe(&spi->dev, regmap, id->driver_data);
 }
 
 static const struct spi_device_id adxl345_spi_id[] = {
-- 
2.34.1

