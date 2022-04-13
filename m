Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D239B4FFD9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiDMSQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbiDMSQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:16:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8B249CA0;
        Wed, 13 Apr 2022 11:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649873646; x=1681409646;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LKXPiucc8uZOA3E6YOnjgAM657MLMJqYgDo4nDQ7TIw=;
  b=cODhUS2zWFSuKz4fp61/y8gsE4nT04IqsuizVDft83IE0f8c1K26P7kG
   1lHB0c2NVmj6IfU3A1wn6xhjpPr7Lqwtj7yxDgBk1xhZtI9ZRdV46kRUD
   RDBMrOWV715eHpMrkpHdd50frwILG/0KNNzF4fhW4ietNe4iSWQJsH9Am
   B+RvM7lXMVngMbhAsw5UqPpCPqga1VjprzhBH1uPiD1eCNfvdv1yeqcUC
   Q2ekDoV+Iz/+4UcozPbyEb4JywpjWUABuyEv9BVZ9OkjLiLF+gpzJj82p
   UigMh/jfYj0i9aPTzaOIklHjSlcJTbTHJC80ZLeJ0yAXCyqJh7gJnDh7D
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="242674696"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="242674696"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:14:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="527046358"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 13 Apr 2022 11:14:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4B0CB12C; Wed, 13 Apr 2022 21:14:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: light: tsl2772: Make use of device properties
Date:   Wed, 13 Apr 2022 21:14:02 +0300
Message-Id: <20220413181402.19582-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
 drivers/iio/light/tsl2772.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 729f14d9f2a4..dd9051f1cc1a 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -15,7 +15,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/slab.h>
+
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -549,10 +551,10 @@ static int tsl2772_get_prox(struct iio_dev *indio_dev)
 
 static int tsl2772_read_prox_led_current(struct tsl2772_chip *chip)
 {
-	struct device_node *of_node = chip->client->dev.of_node;
+	struct device *dev = &chip->client->dev;
 	int ret, tmp, i;
 
-	ret = of_property_read_u32(of_node, "led-max-microamp", &tmp);
+	ret = device_property_read_u32(dev, "led-max-microamp", &tmp);
 	if (ret < 0)
 		return ret;
 
@@ -563,20 +565,18 @@ static int tsl2772_read_prox_led_current(struct tsl2772_chip *chip)
 		}
 	}
 
-	dev_err(&chip->client->dev, "Invalid value %d for led-max-microamp\n",
-		tmp);
+	dev_err(dev, "Invalid value %d for led-max-microamp\n", tmp);
 
 	return -EINVAL;
-
 }
 
 static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
 {
-	struct device_node *of_node = chip->client->dev.of_node;
+	struct device *dev = &chip->client->dev;
 	int i, ret, num_leds, prox_diode_mask;
 	u32 leds[TSL2772_MAX_PROX_LEDS];
 
-	ret = of_property_count_u32_elems(of_node, "amstaos,proximity-diodes");
+	ret = device_property_count_u32(dev, "amstaos,proximity-diodes");
 	if (ret < 0)
 		return ret;
 
@@ -584,12 +584,9 @@ static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
 	if (num_leds > TSL2772_MAX_PROX_LEDS)
 		num_leds = TSL2772_MAX_PROX_LEDS;
 
-	ret = of_property_read_u32_array(of_node, "amstaos,proximity-diodes",
-					 leds, num_leds);
+	ret = device_property_read_u32_array(dev, "amstaos,proximity-diodes", leds, num_leds);
 	if (ret < 0) {
-		dev_err(&chip->client->dev,
-			"Invalid value for amstaos,proximity-diodes: %d.\n",
-			ret);
+		dev_err(dev, "Invalid value for amstaos,proximity-diodes: %d.\n", ret);
 		return ret;
 	}
 
@@ -600,9 +597,7 @@ static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
 		else if (leds[i] == 1)
 			prox_diode_mask |= TSL2772_DIODE1;
 		else {
-			dev_err(&chip->client->dev,
-				"Invalid value %d in amstaos,proximity-diodes.\n",
-				leds[i]);
+			dev_err(dev, "Invalid value %d in amstaos,proximity-diodes.\n", leds[i]);
 			return -EINVAL;
 		}
 	}
-- 
2.35.1

