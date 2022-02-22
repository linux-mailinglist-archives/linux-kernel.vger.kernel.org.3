Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BE14BF449
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiBVJAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiBVJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:00:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A876B13D569;
        Tue, 22 Feb 2022 00:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645520396; x=1677056396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/CoOJYrIQXjl83nUCkZjGK7NC6sCc0jBYnDOtkCGkic=;
  b=fPYPeQjWczrGB+Yh9mR8PKa6V/WUH9N7/UZpOyWGevSARhvvDvWyJn5K
   8zBmk/1k/dw5qYgC3wxCXzISJtliyFoLHniqbG88Xdk8+5YZZhgYRP5Nz
   4AwTre8KOLMnrURTfluurrc9I9a+RABLN5fEDgXH5Ks3Xn9GOBOIaFvW8
   IN5+TJayf++Xqhy66WzHCbm0iZujprEOU+8XDdpZtC/T+3Xu7MSOKy2qd
   2g9LOVvH7TG3H664cz1qf/4Hw6oTvHLSo1S49BI6axgkzksuKms8mOiAo
   dI03tTTFNfa43h8lQaoq9fd+TGFgxY9iUchG6Bfw5BlDxwugZWG7WTicx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="338076726"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="338076726"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 00:59:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="591229128"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 22 Feb 2022 00:59:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C88B340D; Tue, 22 Feb 2022 11:00:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 5/8] iio: accel: adxl345: Add ACPI HID table
Date:   Tue, 22 Feb 2022 11:00:06 +0200
Message-Id: <20220222090009.2060-5-andriy.shevchenko@linux.intel.com>
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

x86 boards may use ACPI HID "ADS0345" for adxl345 device.

Analog replied:
"ADS034X is not a valid PNP ID. ADS0345 would be.
I'm not aware that this ID is already taken.
Feel free to submit a mainline Linux input mailing list patch."

So add an ACPI match table for that accordingly.

Since ACPI device may not match to any I2C ID, use the name and type
directly from ACPI ID table in absence of I2C ID.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/iio/accel/adxl345_i2c.c | 7 +++++++
 drivers/iio/accel/adxl345_spi.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 861d8477d799..11ecff0e0405 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -47,10 +47,17 @@ static const struct of_device_id adxl345_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
+static const struct acpi_device_id adxl345_acpi_match[] = {
+	{ "ADS0345", ADXL345 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
+
 static struct i2c_driver adxl345_i2c_driver = {
 	.driver = {
 		.name	= "adxl345_i2c",
 		.of_match_table = adxl345_of_match,
+		.acpi_match_table = adxl345_acpi_match,
 	},
 	.probe_new	= adxl345_i2c_probe,
 	.id_table	= adxl345_i2c_id,
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index ee4c50c8a95b..850ac616d65e 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -52,10 +52,17 @@ static const struct of_device_id adxl345_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
+static const struct acpi_device_id adxl345_acpi_match[] = {
+	{ "ADS0345", ADXL345 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
+
 static struct spi_driver adxl345_spi_driver = {
 	.driver = {
 		.name	= "adxl345_spi",
 		.of_match_table = adxl345_of_match,
+		.acpi_match_table = adxl345_acpi_match,
 	},
 	.probe		= adxl345_spi_probe,
 	.id_table	= adxl345_spi_id,
-- 
2.34.1

