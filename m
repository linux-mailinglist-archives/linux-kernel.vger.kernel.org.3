Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496894A83CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbiBCMZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:25:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:8724 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236515AbiBCMZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643891134; x=1675427134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LY0KW2YQrt72oJ/2CZtjatYPnoDORyO/zDu9bAN3WF4=;
  b=XIR4Y+Q8OqJ4SwX+EcA4MsbQZl2Wkv5wS63SbRee4/Yov6boRgdEyLcY
   Aq2MY14lPqueUeejbJkSGKrruBqTrY9vndT62GK/n7EBZs1x0IJNRSsRN
   dRF9mh8UBQ77KQERraXE6hbGsD+YryBGto9vvfr+7f6INRGYqWrZMszlB
   2byLKHNVf73LW5kWB3tT1sPA79axnoC65+udsT7iF6Ee52QkDtKEc8PwU
   viAl0Ncx7e0wfcqdCwPhwyjU5YLoIMyhc3bHxhlyhCfhkgtZNtUQtnbnx
   e0WmjSg+lYKV3U6SCtlJtWOVLHS2kVNeA75o0XrYjewOcqaZ6XRavdHNE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272628424"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="272628424"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 04:25:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="483224262"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 03 Feb 2022 04:25:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 59A4118D; Thu,  3 Feb 2022 14:25:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: chemical: atlas-ezo-sensor: Make use of device properties
Date:   Thu,  3 Feb 2022 14:25:43 +0200
Message-Id: <20220203122543.75814-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/chemical/atlas-ezo-sensor.c | 41 ++++++++++---------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index b1bacfe3c3ce..dbec0499ec1e 100644
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
+	{ "atlas-co2-ezo", &atlas_ezo_devices[0] },
+	{ "atlas-o2-ezo", &atlas_ezo_devices[1] },
+	{ "atlas-hum-ezo", &atlas_ezo_devices[2] },
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
@@ -202,20 +198,17 @@ MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
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
-	else
-		chip = &atlas_ezo_devices[(unsigned long)of_id->data];
+	chip = device_get_match_data(&client->dev);
+	if (!chip)
+		chip = (const struct atlas_ezo_device *)id->driver_data;
 
 	indio_dev->info = &atlas_info;
 	indio_dev->name = ATLAS_EZO_DRV_NAME;
-- 
2.34.1

