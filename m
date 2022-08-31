Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674D05A7FED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiHaORC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiHaOQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:16:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF37213E39;
        Wed, 31 Aug 2022 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661955370; x=1693491370;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3z0W0t1tvmSgzUHxrVOKoN4a/HoQR38NwihBSGthIa0=;
  b=MwIMuZvX8ItROqCyc0vm8Bdi5hah+ircZe4AvTJSS3MI0k1DKirirI6s
   lemDYW/yi7pZwtdxf5CYnKyGDVJ20dfNDqro8ecXeRjg7U4NvPmTS5n64
   LG08n9TAq2cenHUNyH3/D//X97uEiYJb8QRkKPWdQFugrpsdkjjPZs5aR
   a1Up6G94JiP3ikttr1v9D8eEx9sTQHuU/E/r48JUQjL2e7tpYDqN4vtjJ
   hWGSEh/fmEZ6Q0de0K3eFFgqB+q8n3tVbiMVrSMelJTM0YCdcV4GldpGx
   HHO7DxXuZb7ceGYkVQ+oV2MbiTkuhSNu75CV3vjBadzy/19gnB7K+iRdF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275858245"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="275858245"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:15:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="614980982"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 31 Aug 2022 07:15:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AF371174; Wed, 31 Aug 2022 17:15:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/3] iio: magnetometer: yamaha-yas530: Use pointers as driver data
Date:   Wed, 31 Aug 2022 17:15:28 +0300
Message-Id: <20220831141530.80572-1-andriy.shevchenko@linux.intel.com>
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

Unify ID tables to use pointers for driver data. It will allow
to simplify the driver later on.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: left ID fallback in place (Jonathan)
 drivers/iio/magnetometer/yamaha-yas530.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 026f71e524f3..58f527cfde07 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -32,6 +32,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/random.h>
@@ -1437,8 +1438,10 @@ static int yas5xx_probe(struct i2c_client *i2c,
 		goto assert_reset;
 	}
 
-	yas5xx->chip_info = &yas5xx_chip_info_tbl[id->driver_data];
-	ci = yas5xx->chip_info;
+	ci = device_get_match_data(dev);
+	if (!ci)
+		ci = (const struct yas5xx_chip_info *)id->driver_data;
+	yas5xx->chip_info = ci;
 
 	ret = regmap_read(yas5xx->map, YAS5XX_DEVICE_ID, &id_check);
 	if (ret)
@@ -1583,19 +1586,19 @@ static DEFINE_RUNTIME_DEV_PM_OPS(yas5xx_dev_pm_ops, yas5xx_runtime_suspend,
 				 yas5xx_runtime_resume, NULL);
 
 static const struct i2c_device_id yas5xx_id[] = {
-	{"yas530", yas530 },
-	{"yas532", yas532 },
-	{"yas533", yas533 },
-	{"yas537", yas537 },
+	{"yas530", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas530] },
+	{"yas532", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas532] },
+	{"yas533", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas533] },
+	{"yas537", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas537] },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, yas5xx_id);
 
 static const struct of_device_id yas5xx_of_match[] = {
-	{ .compatible = "yamaha,yas530", },
-	{ .compatible = "yamaha,yas532", },
-	{ .compatible = "yamaha,yas533", },
-	{ .compatible = "yamaha,yas537", },
+	{ .compatible = "yamaha,yas530", &yas5xx_chip_info_tbl[yas530] },
+	{ .compatible = "yamaha,yas532", &yas5xx_chip_info_tbl[yas532] },
+	{ .compatible = "yamaha,yas533", &yas5xx_chip_info_tbl[yas533] },
+	{ .compatible = "yamaha,yas537", &yas5xx_chip_info_tbl[yas537] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, yas5xx_of_match);
-- 
2.35.1

