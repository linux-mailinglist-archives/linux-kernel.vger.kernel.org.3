Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9865A7FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiHaOQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiHaOP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:15:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E5D54C93;
        Wed, 31 Aug 2022 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661955321; x=1693491321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L9mlAn2BFWn3JIKG5JcPjAbTHy4uCrPCXYYV2cWUXdk=;
  b=l/B0P/Gy3eM3cTo/03Vt5WiaclCZK3igVmL/838vIY4qx5eckazw4Eo9
   GlfS/f3EdNGyNHV5PKEo3X4fHCYvfXa4ffWEZwHIglUc7KNPLpVDksLTP
   p1HZDW561mU3bPWnn00crHtwvvvBf6HzCu6NnQA0utpR0Qj4u86Oxhba8
   Lyfz3cgLTm8wHBGZslce+PGzp7FCYneRdQatiEhC81jXuyN6bZrYUgHo/
   GmAl5ERIAn6BxYnWglX/WLTLpqLUfXU+bxox1MMU5V9aYtYOYTvMK+L7w
   pqOIsAK3JUEpjB6JnNT6w1AD4LIPptT/DtI4ZC87yf3D9BZPGgXvOJL8d
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="321594753"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="321594753"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:15:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="787873718"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 31 Aug 2022 07:15:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BFF7C1C3; Wed, 31 Aug 2022 17:15:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/3] iio: magnetometer: yamaha-yas530: Use dev_err_probe()
Date:   Wed, 31 Aug 2022 17:15:30 +0300
Message-Id: <20220831141530.80572-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831141530.80572-1-andriy.shevchenko@linux.intel.com>
References: <20220831141530.80572-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify error message format by using dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/iio/magnetometer/yamaha-yas530.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index a6e34d5f3e85..801c760feb4d 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -1415,10 +1415,8 @@ static int yas5xx_probe(struct i2c_client *i2c,
 		return dev_err_probe(dev, ret, "cannot get regulators\n");
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(yas5xx->regs), yas5xx->regs);
-	if (ret) {
-		dev_err(dev, "cannot enable regulators\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot enable regulators\n");
 
 	/* See comment in runtime resume callback */
 	usleep_range(31000, 40000);
@@ -1426,15 +1424,13 @@ static int yas5xx_probe(struct i2c_client *i2c,
 	/* This will take the device out of reset if need be */
 	yas5xx->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(yas5xx->reset)) {
-		ret = dev_err_probe(dev, PTR_ERR(yas5xx->reset),
-				    "failed to get reset line\n");
+		ret = dev_err_probe(dev, PTR_ERR(yas5xx->reset), "failed to get reset line\n");
 		goto reg_off;
 	}
 
 	yas5xx->map = devm_regmap_init_i2c(i2c, &yas5xx_regmap_config);
 	if (IS_ERR(yas5xx->map)) {
-		dev_err(dev, "failed to allocate register map\n");
-		ret = PTR_ERR(yas5xx->map);
+		ret = dev_err_probe(dev, PTR_ERR(yas5xx->map), "failed to allocate register map\n");
 		goto assert_reset;
 	}
 
@@ -1484,13 +1480,13 @@ static int yas5xx_probe(struct i2c_client *i2c,
 					 yas5xx_handle_trigger,
 					 NULL);
 	if (ret) {
-		dev_err(dev, "triggered buffer setup failed\n");
+		dev_err_probe(dev, ret, "triggered buffer setup failed\n");
 		goto assert_reset;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(dev, "device register failed\n");
+		dev_err_probe(dev, ret, "device register failed\n");
 		goto cleanup_buffer;
 	}
 
-- 
2.35.1

