Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78C74A882F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352064AbiBCP7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:59:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:14238 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbiBCP7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643903951; x=1675439951;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r3LklpumRSCVRPZ1iWKibE5YvEFhUlEi5fqm7ahAhq4=;
  b=FrSXgMvraotO1tc/SjEpM1PP8aQQ/V58Fc9mLfoSn8q8zY1FsF0xxElr
   s+rIE/9XeQD+w7iWo9Tz760Nz1rqeKZpK+3AoIX9DqKciqMcwxHnDd/QH
   klraeQAdBfP06pBuLHfdkWvgdzCwAN0CVdR3BEP7+6NZOifaHFtToP2qB
   sJzJGIxiLetSeLiyA4dE1pqEyzWj0f20VE2OWnp3CUHgolOcz9YbF/zrD
   GAO8qB81zbOLl6s3ONyT04TI1as+KKLBoxjb1r63cKG5BsBwU+FEuDETB
   6t/ER+8Pvb/H3L2iWfDiFB0Y4o5kjEsx9s7qYE4eFE8Gowz61zsItTg6n
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="311477491"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="311477491"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 07:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="676807120"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2022 07:59:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1482E18D; Thu,  3 Feb 2022 17:59:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/3] iio: imu: inv_mpu6050: Drop wrong use of ACPI_PTR()
Date:   Thu,  3 Feb 2022 17:59:18 +0200
Message-Id: <20220203155920.18586-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI_PTR() is more harmful than helpful. For example, in this case
if CONFIG_ACPI=n, the ID table left unused which is not what we want.

Instead of adding ifdeffery or attribute here and there, drop ACPI_PTR().

Fixes: 3b3870646642 ("iio: imu: inv_mpu6050: Mark acpi match table as maybe unused")
Fixes: fd64df16f40e ("iio: imu: inv_mpu6050: Add SPI support for MPU6000")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 7 +++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index fe03707ec2d3..ccb06d9af760 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -3,11 +3,11 @@
 * Copyright (C) 2012 Invensense, Inc.
 */
 
-#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/property.h>
@@ -249,11 +249,10 @@ static const struct of_device_id inv_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, inv_of_match);
 
-static const struct acpi_device_id __maybe_unused inv_acpi_match[] = {
+static const struct acpi_device_id inv_acpi_match[] = {
 	{"INVN6500", INV_MPU6500},
 	{ },
 };
-
 MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
 
 static struct i2c_driver inv_mpu_driver = {
@@ -262,7 +261,7 @@ static struct i2c_driver inv_mpu_driver = {
 	.id_table	=	inv_mpu_id,
 	.driver = {
 		.of_match_table = inv_of_match,
-		.acpi_match_table = ACPI_PTR(inv_acpi_match),
+		.acpi_match_table = inv_acpi_match,
 		.name	=	"inv-mpu6050-i2c",
 		.pm     =       &inv_mpu_pmops,
 	},
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 6800356b25fb..44b4f74b9256 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -2,8 +2,8 @@
 /*
 * Copyright (C) 2015 Intel Corporation Inc.
 */
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/property.h>
 #include <linux/spi/spi.h>
@@ -148,7 +148,7 @@ static struct spi_driver inv_mpu_driver = {
 	.id_table	=	inv_mpu_id,
 	.driver = {
 		.of_match_table = inv_of_match,
-		.acpi_match_table = ACPI_PTR(inv_acpi_match),
+		.acpi_match_table = inv_acpi_match,
 		.name	=	"inv-mpu6000-spi",
 		.pm     =       &inv_mpu_pmops,
 	},
-- 
2.34.1

