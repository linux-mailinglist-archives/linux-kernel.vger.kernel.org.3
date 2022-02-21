Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481324BEE38
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbiBUXdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:33:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbiBUXdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:33:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D387024F30;
        Mon, 21 Feb 2022 15:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645486354; x=1677022354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ucMLf3pkDEmoMNa91otBFIj2FeCBNpbBJ2ibqq+S768=;
  b=F+U7UU1Mho0rlEazZJeWDiVu51gnRFW38wqhzXNnQQtZ387IWMGRMnDP
   xKbnQELXTP+Qo5JQnsAzkktnovS8gAesFZS5GxKZI6lek6CrwRbhjABtj
   vemO7lDQtmZOc6X+NxHv7lqRkywnZd7p+g1MzQxyWKByXakm+8Y158O8r
   /XHP5PgYvoNl8NV8d0FKC7iwsmr1mFhWf7h1wvXkDxoQuMT7oNQnHh/SS
   1tWsrFvOFJ7AAEuMTkfyJyCIPqqQq0/60qalzaLMlwlc21OSblRXkUCqd
   vgk5zI377z4ewmHRBwZEASBvpX0deWEmDctlaZNgDgyfeTvAgsMmkQdOO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251347125"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="251347125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="636805060"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2022 15:32:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D56B42FC; Tue, 22 Feb 2022 01:32:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 5/8] iio: accel: adxl345: Add ACPI HID table
Date:   Tue, 22 Feb 2022 01:32:32 +0200
Message-Id: <20220221233235.86893-5-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/accel/adxl345_i2c.c | 7 +++++++
 drivers/iio/accel/adxl345_spi.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 581196e72291..3216345e87bf 100644
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
index 1ea9933a909e..784e41965f00 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -51,10 +51,17 @@ static const struct of_device_id adxl345_of_match[] = {
 
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

