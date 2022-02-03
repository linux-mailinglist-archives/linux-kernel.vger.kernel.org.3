Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8DD4A8889
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352194AbiBCQ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:27:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:65493 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234500AbiBCQ1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643905635; x=1675441635;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J04TgQrgQo+RUYfQTdaDuYPqbczBPf69h8/g5tvPcrY=;
  b=KcWmlBApp3OQSGKX8lg47vx8G50Ir/kDI4ayMedCAtq6d9vpjKtMHYhu
   HNk4E1Cb30RHpCsRU9hznp4Un7XBqD3YYnn2h/zXd8wzwK2hP1SHT+DdL
   pI3JrTgZTIMvV5JqkUZWCyQAuCAH2VA6Fxy5DJwmKPa+MA2X29n3u8mzS
   ry7AHZzLLophBZIr3x8j7rRVYORgSdrRrXYsL11a4iM3poqULCiKg1BjW
   8SgeDozmsKttEqtbKqJ8JSI3CEjqVsrCqHZ6Cmictd/QW74f3bzYqJTPW
   Bfwthg75YKTwXYHoGICOShCJtJP6nblNqVkVDxM5X9E9f4q8MlsPYI6N/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248132588"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="248132588"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 08:27:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="599958201"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2022 08:27:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1786D18D; Thu,  3 Feb 2022 18:27:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/1] iio: chemical: atlas-ezo-sensor: Make use of device properties
Date:   Thu,  3 Feb 2022 18:27:25 +0200
Message-Id: <20220203162725.63979-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed castings and qualifiers (LKP)
 drivers/iio/chemical/atlas-ezo-sensor.c | 44 +++++++++++--------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index b1bacfe3c3ce..3f3ea479b474 100644
--- a/drivers/iio/chemical/atlas-ezo-sensor.c
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -6,25 +6,21 @@
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
 #define ATLAS_INT_TIME_IN_MS		950
 #define ATLAS_INT_HUM_TIME_IN_MS	350
 
-enum {
-	ATLAS_CO2_EZO,
-	ATLAS_O2_EZO,
-	ATLAS_HUM_EZO,
-};
-
 struct atlas_ezo_device {
 	const struct iio_chan_spec *channels;
 	int num_channels;
@@ -33,7 +29,7 @@ struct atlas_ezo_device {
 
 struct atlas_ezo_data {
 	struct i2c_client *client;
-	struct atlas_ezo_device *chip;
+	const struct atlas_ezo_device *chip;
 
 	/* lock to avoid multiple concurrent read calls */
 	struct mutex lock;
@@ -81,17 +77,17 @@ static const struct iio_chan_spec atlas_hum_ezo_channels[] = {
 };
 
 static struct atlas_ezo_device atlas_ezo_devices[] = {
-	[ATLAS_CO2_EZO] = {
+	[0] = {
 		.channels = atlas_co2_ezo_channels,
 		.num_channels = 1,
 		.delay = ATLAS_INT_TIME_IN_MS,
 	},
-	[ATLAS_O2_EZO] = {
+	[1] = {
 		.channels = atlas_o2_ezo_channels,
 		.num_channels = 1,
 		.delay = ATLAS_INT_TIME_IN_MS,
 	},
-	[ATLAS_HUM_EZO] = {
+	[2] = {
 		.channels = atlas_hum_ezo_channels,
 		.num_channels = 1,
 		.delay = ATLAS_INT_HUM_TIME_IN_MS,
@@ -184,17 +180,17 @@ static const struct iio_info atlas_info = {
 };
 
 static const struct i2c_device_id atlas_ezo_id[] = {
-	{ "atlas-co2-ezo", ATLAS_CO2_EZO },
-	{ "atlas-o2-ezo", ATLAS_O2_EZO },
-	{ "atlas-hum-ezo", ATLAS_HUM_EZO },
+	{ "atlas-co2-ezo", (kernel_ulong_t)&atlas_ezo_devices[0] },
+	{ "atlas-o2-ezo", (kernel_ulong_t)&atlas_ezo_devices[1] },
+	{ "atlas-hum-ezo", (kernel_ulong_t)&atlas_ezo_devices[2] },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
 
 static const struct of_device_id atlas_ezo_dt_ids[] = {
-	{ .compatible = "atlas,co2-ezo", .data = (void *)ATLAS_CO2_EZO, },
-	{ .compatible = "atlas,o2-ezo", .data = (void *)ATLAS_O2_EZO, },
-	{ .compatible = "atlas,hum-ezo", .data = (void *)ATLAS_HUM_EZO, },
+	{ .compatible = "atlas,co2-ezo", .data = &atlas_ezo_devices[0], },
+	{ .compatible = "atlas,o2-ezo", .data = &atlas_ezo_devices[1], },
+	{ .compatible = "atlas,hum-ezo", .data = &atlas_ezo_devices[2], },
 	{}
 };
 MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
@@ -202,20 +198,20 @@ MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
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

