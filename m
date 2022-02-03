Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFBB4A8837
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352077AbiBCP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:59:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:17221 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352065AbiBCP7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643903953; x=1675439953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=blShqSweU5XjV7bGSXH3IJnrLW5XAVyCdMK90nDfDh0=;
  b=fCFJUampY1D1YSFPuptU6Nyz8UtgepXH4pilvbYA1kzyNqqTx6KMIQWT
   4x3fx4Hy04F3iPmjVN1A4z6pajGOV3rSTk7JHHwgSkCaCTY+uReTfNTq3
   2gQMjOJJEll+IvpbCbwiIvTgyEZ53KE35hlbot8mykOaKw4PWj85usCRv
   CknQbz0WncG9HBVg13ykDDP2xSqjgKpaFzHDo+ytVk363o9NlIV3RwWvq
   L25Dp13/4KgjkA643IcZHsBJeiuJmY5qAghB9grJlA9Hnve56a/Qfwwu8
   WsO6FWpAJ8O4kpFRxChDKmC0TawAm9z5L3miIvVAn4Mh1P8scPWvG5itb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248387170"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="248387170"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 07:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="699353546"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 03 Feb 2022 07:59:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 217A042; Thu,  3 Feb 2022 17:59:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 2/3] iio: imu: inv_mpu6050: Check ACPI companion directly
Date:   Thu,  3 Feb 2022 17:59:19 +0200
Message-Id: <20220203155920.18586-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203155920.18586-1-andriy.shevchenko@linux.intel.com>
References: <20220203155920.18586-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of checking for ACPI handle followed by extracting a companion
device, do the latter first and use it for checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index f8f0cf716bc6..9b4298095d3f 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -127,15 +127,14 @@ static int inv_mpu_process_acpi_config(struct i2c_client *client,
 int inv_mpu_acpi_create_mux_client(struct i2c_client *client)
 {
 	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(&client->dev));
+	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
 
 	st->mux_client = NULL;
-	if (ACPI_HANDLE(&client->dev)) {
+	if (adev) {
 		struct i2c_board_info info;
 		struct i2c_client *mux_client;
-		struct acpi_device *adev;
 		int ret = -1;
 
-		adev = ACPI_COMPANION(&client->dev);
 		memset(&info, 0, sizeof(info));
 
 		dmi_check_system(inv_mpu_dev_list);
-- 
2.34.1

