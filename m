Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92844BEDFD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbiBUXdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:33:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbiBUXdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:33:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0521824F3F;
        Mon, 21 Feb 2022 15:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645486354; x=1677022354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3CxaWVSWg/Jzsy7ISknXZRCdZai6a5CjnJSDep75TJQ=;
  b=KC0nIbYcwoU7o41Vecw35plIydVlvCsjpLH4nWZAkkHAg4nxSb01cRfU
   IQl9iELsnN1Lr2JwrbOrbgIG7kkvSYk18R7uTD98VjS8sRFJQBPuZ/JCQ
   xDoLvJzCVL12kVlSIQSFsp9V9/6hUsDDFa06qGwXyOlBMvsWAoaFGrYvY
   pVnrc1pHJgMXazBin5rQNtdmbnu4B/W87I1PeMf1k58UEMOFA4xMtTjP+
   5NcrSmd+jw5kxYIvUJR9WQqVLWFXCDnlfA2y8GhrqLO2m9amzelSNKvRu
   NWNKkonje5LqIeMfZiA9cDT0mSqjXHH6ZAR2hxQ+GnemH1s3yx20GYM5A
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251347122"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="251347122"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="532000686"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2022 15:32:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B894D93; Tue, 22 Feb 2022 01:32:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v1 2/8] iio: accel: adxl345: Set driver_data for OF enumeration
Date:   Tue, 22 Feb 2022 01:32:29 +0200
Message-Id: <20220221233235.86893-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
References: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
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

In order to enable this driver on mode platforms, assign driver_data
field in the OF device ID table.

While at it, make sure that device type is not 0 which may be wrongly
interpreted by device property APIs in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/adxl345.h     | 4 ++--
 drivers/iio/accel/adxl345_i2c.c | 4 ++--
 drivers/iio/accel/adxl345_spi.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index af0fdd02c4f2..5a68d4dac717 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -9,8 +9,8 @@
 #define _ADXL345_H_
 
 enum adxl345_device_type {
-	ADXL345,
-	ADXL375,
+	ADXL345	= 1,
+	ADXL375 = 2,
 };
 
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index d6dd715bf404..478ffc671035 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -44,8 +44,8 @@ static const struct i2c_device_id adxl345_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
 
 static const struct of_device_id adxl345_of_match[] = {
-	{ .compatible = "adi,adxl345" },
-	{ .compatible = "adi,adxl375" },
+	{ .compatible = "adi,adxl345", ADXL345 },
+	{ .compatible = "adi,adxl375", ADXL375 },
 	{ },
 };
 
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 6984b13f32e8..79f9428e39f8 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -45,8 +45,8 @@ static const struct spi_device_id adxl345_spi_id[] = {
 MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
 
 static const struct of_device_id adxl345_of_match[] = {
-	{ .compatible = "adi,adxl345" },
-	{ .compatible = "adi,adxl375" },
+	{ .compatible = "adi,adxl345", ADXL345 },
+	{ .compatible = "adi,adxl375", ADXL375 },
 	{ },
 };
 
-- 
2.34.1

