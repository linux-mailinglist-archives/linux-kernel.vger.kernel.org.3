Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB35A4AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 13:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiH2Loz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 07:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiH2LoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:44:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599CE861D9;
        Mon, 29 Aug 2022 04:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661772497; x=1693308497;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ktD+MPSTkvtZ2p7zqOjOliH/f+SyytDdfafxmL8w04Y=;
  b=bbcRocCU4+jjG224BVz7Gp7O0HRvVWi7nA5TSBLxv7CVkJ4oZqGgnrSM
   VH1tC9WEhh507wPduZ87AtwFzNJnR0LuFcskSOKCzY1+9CfpRWLB1O+ii
   oiWTxLBFn6ID+BJoh9cEBDwZy1rhdRnJ+f78ogvJLIB/nLC6SMUDdNZJa
   FkE0jHpULtiZSbVpm/wmjPE89eGeBnUzJnMxaEZtEAmBfHWTVd/tSLzf0
   HxwxmVb1vtT7PMCo/cX3mi6PzrC6ND46cq8tznlq/+r/HszSnP0ibaaJ3
   2TiPA2qMMXYRIMAJt1jU7aALPG8gQRXwFDmxxyLAiFxa9UrnME7lK3MBz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="294879419"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="294879419"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 04:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="562188843"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 29 Aug 2022 04:23:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 63062AD; Mon, 29 Aug 2022 14:24:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/4] iio: magnetometer: yamaha-yas530: Use pointers as driver data
Date:   Mon, 29 Aug 2022 14:24:04 +0300
Message-Id: <20220829112407.74917-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Unify ID tables to use pointers for driver data. It will allow
to simplify the driver later on.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 026f71e524f3..03e0525e6364 100644
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
@@ -1437,8 +1438,8 @@ static int yas5xx_probe(struct i2c_client *i2c,
 		goto assert_reset;
 	}
 
-	yas5xx->chip_info = &yas5xx_chip_info_tbl[id->driver_data];
-	ci = yas5xx->chip_info;
+	ci = device_get_match_data(dev);
+	yas5xx->chip_info = ci;
 
 	ret = regmap_read(yas5xx->map, YAS5XX_DEVICE_ID, &id_check);
 	if (ret)
@@ -1583,19 +1584,19 @@ static DEFINE_RUNTIME_DEV_PM_OPS(yas5xx_dev_pm_ops, yas5xx_runtime_suspend,
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

