Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A605F4FFB51
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiDMQcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiDMQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:32:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9763540E77;
        Wed, 13 Apr 2022 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649867413; x=1681403413;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qDkbU8XSNk1eujhrIWUtPP6zepSDfhWBReA8xRFeVB8=;
  b=dxcFuf8zG5CI9waPPbK/mqPOqdcYDiEAqN8oHs5PK4gCzEwlgOcxVVQB
   l9idX0amCIk3cZweIuvDJ0OENVMRlPpAnFm8VNaPyf5JAiRdUi6Rov8gv
   qUmrU9mTU/J+Y7a3hr58M6Jp53ycT/dY54eoYT13jBj5dx/vfJMurBGzD
   TEOQw1aOg7hPzgohBDIDXVORUCDmLRNjZd9g7GVhEXu1nGtPpn6LGn+bn
   ZV1VyvmXjSeF8CPtVRvkt+jwqugOMA8ybCqRYea/t3ogqR4+WMRoRZQ4Q
   AGFglmLKIZ4AJS88ujsKXT1y/deCN3QgmR2KagV/obk6cPCMko+/hpsks
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="243299923"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="243299923"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="724965935"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2022 09:30:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 260B412C; Wed, 13 Apr 2022 19:30:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: gyro: mpu3050: Make use of device properties
Date:   Wed, 13 Apr 2022 19:30:04 +0300
Message-Id: <20220413163004.84789-1-andriy.shevchenko@linux.intel.com>
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

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

While at it, reuse temporary device pointer in the same function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/gyro/mpu3050-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index ea387efab62d..a2dafdb64692 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/random.h>
 #include <linux/slab.h>
 
@@ -1050,6 +1051,7 @@ static const struct iio_trigger_ops mpu3050_trigger_ops = {
 static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 {
 	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
+	struct device *dev = mpu3050->dev;
 	unsigned long irq_trig;
 	int ret;
 
@@ -1061,8 +1063,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 		return -ENOMEM;
 
 	/* Check if IRQ is open drain */
-	if (of_property_read_bool(mpu3050->dev->of_node, "drive-open-drain"))
-		mpu3050->irq_opendrain = true;
+	mpu3050->irq_opendrain = device_property_read_bool(dev, "drive-open-drain");
 
 	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
 	/*
@@ -1118,13 +1119,12 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 				   mpu3050->trig->name,
 				   mpu3050->trig);
 	if (ret) {
-		dev_err(mpu3050->dev,
-			"can't get IRQ %d, error %d\n", irq, ret);
+		dev_err(dev, "can't get IRQ %d, error %d\n", irq, ret);
 		return ret;
 	}
 
 	mpu3050->irq = irq;
-	mpu3050->trig->dev.parent = mpu3050->dev;
+	mpu3050->trig->dev.parent = dev;
 	mpu3050->trig->ops = &mpu3050_trigger_ops;
 	iio_trigger_set_drvdata(mpu3050->trig, indio_dev);
 
-- 
2.35.1

