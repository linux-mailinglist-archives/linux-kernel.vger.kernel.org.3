Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4C25A4C52
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiH2MtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiH2Msx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:48:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39776F5AE;
        Mon, 29 Aug 2022 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661776513; x=1693312513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GJ0K59ZzthNg5OEpBKqjZmJfFMlJGaO+wv9wOAwOKKw=;
  b=jVUl9lf3ZWdHNCSnB+rmj9L9jh54MUnoTTBOOXSCR1O0a/dQyHL/FOjH
   wP/qe9mgNE9tLnCTLe+Q6SfhCfkDYSOe+fl43XFqz23x1OL+lq5lccF1J
   jvi4GHuuEed1XV3A3cbvMO1uN0GQActa8E0tKvA/49dmXYeCeXri4EuKY
   /BDWz8YbblBvdeNLXXimIOUxYv8NQvFSUlKzeZbgqYjekNlyal2sLUA22
   MEJ9WigOxgHAEtPPu64fEZYBorlRMnAeArAi3+gKj+ZL1ih9T5JsErCGY
   V9KyEbwDhuMSB0M+bWVH/4ESt47e1rxv2HICg7ZthzRdwK/jW0yTjBDyO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="295647023"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="295647023"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 04:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="614187631"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2022 04:23:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7772719D; Mon, 29 Aug 2022 14:24:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 3/4] iio: magnetometer: yamaha-yas530: Switch to new style i2c-driver probe function
Date:   Mon, 29 Aug 2022 14:24:06 +0300
Message-Id: <20220829112407.74917-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829112407.74917-1-andriy.shevchenko@linux.intel.com>
References: <20220829112407.74917-1-andriy.shevchenko@linux.intel.com>
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

Switch to the new style i2c-driver probe_new probe function.
Note we do not have any old style board files using this but
user still has a possibility to instantiate device from sysfs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 8cfe1ef9c5b4..bacd2b783113 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -168,6 +168,7 @@ struct yas5xx;
 /**
  * struct yas5xx_chip_info - device-specific data and function pointers
  * @devid: device ID number
+ * @product_label: product label used in Linux
  * @product_name: product name of the YAS variant
  * @version_names: version letters or namings
  * @volatile_reg: device-specific volatile registers
@@ -189,6 +190,7 @@ struct yas5xx;
  */
 struct yas5xx_chip_info {
 	unsigned int devid;
+	const char *product_label;
 	const char *product_name;
 	const char *version_names[2];
 	const int *volatile_reg;
@@ -1324,6 +1326,7 @@ static int yas537_power_on(struct yas5xx *yas5xx)
 static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 	[yas530] = {
 		.devid = YAS530_DEVICE_ID,
+		.product_label = "yas530",
 		.product_name = "YAS530 MS-3E",
 		.version_names = { "A", "B" },
 		.volatile_reg = yas530_volatile_reg,
@@ -1339,6 +1342,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 	},
 	[yas532] = {
 		.devid = YAS532_DEVICE_ID,
+		.product_label = "yas532",
 		.product_name = "YAS532 MS-3R",
 		.version_names = { "AB", "AC" },
 		.volatile_reg = yas530_volatile_reg,
@@ -1354,6 +1358,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 	},
 	[yas533] = {
 		.devid = YAS532_DEVICE_ID,
+		.product_label = "yas533",
 		.product_name = "YAS533 MS-3F",
 		.version_names = { "AB", "AC" },
 		.volatile_reg = yas530_volatile_reg,
@@ -1369,6 +1374,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 	},
 	[yas537] = {
 		.devid = YAS537_DEVICE_ID,
+		.product_label = "yas537",
 		.product_name = "YAS537 MS-3T",
 		.version_names = { "v0", "v1" }, /* version naming unknown */
 		.volatile_reg = yas537_volatile_reg,
@@ -1384,8 +1390,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 	},
 };
 
-static int yas5xx_probe(struct i2c_client *i2c,
-			const struct i2c_device_id *id)
+static int yas5xx_probe(struct i2c_client *i2c)
 {
 	struct iio_dev *indio_dev;
 	struct device *dev = &i2c->dev;
@@ -1448,7 +1453,7 @@ static int yas5xx_probe(struct i2c_client *i2c,
 	if (id_check != ci->devid) {
 		ret = dev_err_probe(dev, -ENODEV,
 				    "device ID %02x doesn't match %s\n",
-				    id_check, id->name);
+				    id_check, ci->product_label);
 		goto assert_reset;
 	}
 
@@ -1474,7 +1479,7 @@ static int yas5xx_probe(struct i2c_client *i2c,
 	indio_dev->info = &yas5xx_info;
 	indio_dev->available_scan_masks = yas5xx_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->name = id->name;
+	indio_dev->name = ci->product_label;
 	indio_dev->channels = yas5xx_channels;
 	indio_dev->num_channels = ARRAY_SIZE(yas5xx_channels);
 
@@ -1607,7 +1612,7 @@ static struct i2c_driver yas5xx_driver = {
 		.of_match_table = yas5xx_of_match,
 		.pm = pm_ptr(&yas5xx_dev_pm_ops),
 	},
-	.probe	  = yas5xx_probe,
+	.probe_new = yas5xx_probe,
 	.remove	  = yas5xx_remove,
 	.id_table = yas5xx_id,
 };
-- 
2.35.1

