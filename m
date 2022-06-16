Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A655C54E355
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377689AbiFPOY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377680AbiFPOYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:24:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360D834BBD;
        Thu, 16 Jun 2022 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655389493; x=1686925493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hE6chBrBrGD7pj5GeBUGyoLBvmW45blq2Czih28Qh54=;
  b=RgQjah8OMeTODBKoQ/2gDCFC9eA7bB4s6irayevqsgYpUcSGheDxmeFW
   SOMQ7hx7whHxDTsKRPLDsg7a33hYDLaLSDJBpa03KA3Gl1sxv82MYL1a6
   iowjitl9Kv1S8+mEZP1PCeBOFB1HIM7PPRp43kWauEoWsXQCrygJJIldZ
   awy5Iqq/X0VucMPtIgBtFdc9HOte1+EA5uFq/Sc4hmCWQmKPPNHcJs7Lm
   kJVd1W6IFSF4+WdGaIb2oS8dyyqtATS1nQKYd2LdrK+0LmN8IODucoK+w
   5+bRAUDUrroG78Q7lUotQcr8gq5myNp4oB9G79EN4vuvPFHLiTJrimlZi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="259721301"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="259721301"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 07:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="583653276"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2022 07:24:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 27E6A1C2; Thu, 16 Jun 2022 17:24:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: accel: mma7660: Drop wrong use of ACPI_PTR()
Date:   Thu, 16 Jun 2022 17:24:51 +0300
Message-Id: <20220616142451.10322-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI_PTR() is more harmful than helpful. For example, in this case
if CONFIG_ACPI=n, the ID table left unused which is not what we want.

Instead of making linker to drop a section, drop ACPI_PTR().

As a side effect this makes driver ACPI and OF clean.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/mma7660.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 112a5a33c29f..794f2f383303 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -7,8 +7,8 @@
  * IIO driver for Freescale MMA7660FC; 7-bit I2C address: 0x4c.
  */
 
-#include <linux/acpi.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -255,7 +255,7 @@ static const struct of_device_id mma7660_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mma7660_of_match);
 
-static const struct acpi_device_id __maybe_unused mma7660_acpi_id[] = {
+static const struct acpi_device_id mma7660_acpi_id[] = {
 	{"MMA7660", 0},
 	{}
 };
@@ -267,7 +267,7 @@ static struct i2c_driver mma7660_driver = {
 		.name = "mma7660",
 		.pm = pm_sleep_ptr(&mma7660_pm_ops),
 		.of_match_table = mma7660_of_match,
-		.acpi_match_table = ACPI_PTR(mma7660_acpi_id),
+		.acpi_match_table = mma7660_acpi_id,
 	},
 	.probe		= mma7660_probe,
 	.remove		= mma7660_remove,
-- 
2.35.1

