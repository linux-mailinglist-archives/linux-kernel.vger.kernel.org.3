Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694A74BF44B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiBVJA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiBVJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:00:21 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C395213D571;
        Tue, 22 Feb 2022 00:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645520396; x=1677056396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o4envaYLqs+z52hQ8wGkddicuVsNghNQMBwQHZvdqsc=;
  b=kirNRBmpUF936yYvRy8At21xiu036F8hgeKj2aFRnnbbZmJFvJWFiUB9
   /lvtT32dhSM1IEvk7OdvNyxFzbJsDUCsE4ZjeYscWJcqWmz/f1HEeg1Pb
   pyIbcfpzU6in4hDcp/nJnVFbMP9wzppChOeaJANBpFR/TBFBpvdYRgOhH
   pRyEnSssH85mAGiWBJhe68KY2GcN/eTx+kS694Lhc46Q+RVvwD9qri5PH
   32pjAsJs4RckPL/7JAZzhE71GUIJg2qZUYvAGMEZmW9BBY9zrzoWON4Ii
   AsiSBQfCAcEkDs5+R0SdZmAl2WJuLoOXzcxklbmW2u2EfUO7sKK5buHk3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="314907081"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="314907081"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 00:59:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="778977598"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 22 Feb 2022 00:59:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9F1D412C; Tue, 22 Feb 2022 11:00:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 2/8] iio: accel: adxl345: Set driver_data for OF enumeration
Date:   Tue, 22 Feb 2022 11:00:03 +0200
Message-Id: <20220222090009.2060-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222090009.2060-1-andriy.shevchenko@linux.intel.com>
References: <20220222090009.2060-1-andriy.shevchenko@linux.intel.com>
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

In order to enable this driver on mode platforms, assign driver_data
field in the OF device ID table.

While at it, make sure that device type is not 0 which may be wrongly
interpreted by device property APIs in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: used proper casting for the supplied data (LKP)
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
index e3205dce91b8..4c6efe2eefc1 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -44,8 +44,8 @@ static const struct i2c_device_id adxl345_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
 
 static const struct of_device_id adxl345_of_match[] = {
-	{ .compatible = "adi,adxl345" },
-	{ .compatible = "adi,adxl375" },
+	{ .compatible = "adi,adxl345", .data = (const void *)ADXL345 },
+	{ .compatible = "adi,adxl375", .data = (const void *)ADXL375 },
 	{ },
 };
 
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 9223302fdd46..72550132b1bb 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -46,8 +46,8 @@ static const struct spi_device_id adxl345_spi_id[] = {
 MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
 
 static const struct of_device_id adxl345_of_match[] = {
-	{ .compatible = "adi,adxl345" },
-	{ .compatible = "adi,adxl375" },
+	{ .compatible = "adi,adxl345", .data = (const void *)ADXL345 },
+	{ .compatible = "adi,adxl375", .data = (const void *)ADXL375 },
 	{ },
 };
 
-- 
2.34.1

