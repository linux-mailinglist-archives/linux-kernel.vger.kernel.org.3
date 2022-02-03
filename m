Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117AF4A8830
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352091AbiBCP7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:59:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:17221 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbiBCP7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643903953; x=1675439953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5llCnZ5NOHSTX0eHbDBs0UZwkjIn4HngtUVZ5yJy0Jg=;
  b=cB2Qj0INVjxAvrmne+m5AJ/xNnEtX6gluhmp9zOgKgbRN19fTRK+pwya
   qOAvLWCi0yn2gYFlh1PmcW4IQm7+BKGExwmmKLzx7T3QrRsLU0wNIX9GC
   OXnF2e+1+ZMz3MO+QONYXHV/1s3jaAeOFB+iIIl6cXY93J3r1xXXOpqkf
   ctzV3mcx8yF8Lmpnu9t9GPCQzUZjz0TBngRAt47uaGfFM1qfHR23lI6cE
   4I8jhod+mPMsbGW4Otem8Z2j0VxOEytmr1doGjua/bnhwLabJEiT2KFiM
   AldVBjG/0f519x1+qrCl/d1i1wdFLLWhxnLj/lI0K8uIEIqdXitxinob2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248387172"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="248387172"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 07:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="699353547"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 03 Feb 2022 07:59:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2A87030A; Thu,  3 Feb 2022 17:59:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 3/3] iio: imu: inv_mpu6050: Make use of device properties
Date:   Thu,  3 Feb 2022 17:59:20 +0200
Message-Id: <20220203155920.18586-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203155920.18586-1-andriy.shevchenko@linux.intel.com>
References: <20220203155920.18586-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 8 ++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index ccb06d9af760..55cffb5fa115 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -9,8 +9,8 @@
 #include <linux/iio/iio.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/property.h>
+
 #include "inv_mpu_iio.h"
 
 static const struct regmap_config inv_mpu_regmap_config = {
@@ -51,7 +51,7 @@ static int inv_mpu_i2c_aux_setup(struct iio_dev *indio_dev)
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
-	struct device_node *mux_node;
+	struct fwnode_handle *mux_node;
 	int ret;
 
 	/*
@@ -65,12 +65,12 @@ static int inv_mpu_i2c_aux_setup(struct iio_dev *indio_dev)
 	case INV_MPU9150:
 	case INV_MPU9250:
 	case INV_MPU9255:
-		mux_node = of_get_child_by_name(dev->of_node, "i2c-gate");
+		mux_node = device_get_named_child_node(dev, "i2c-gate");
 		if (mux_node != NULL) {
 			st->magn_disabled = true;
 			dev_warn(dev, "disable internal use of magnetometer\n");
 		}
-		of_node_put(mux_node);
+		fwnode_handle_put(mux_node);
 		break;
 	default:
 		break;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 44b4f74b9256..26a7c2521dc4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -4,7 +4,6 @@
 */
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/regmap.h>
-- 
2.34.1

