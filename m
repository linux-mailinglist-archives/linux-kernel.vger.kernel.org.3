Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCC4469E93
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389460AbhLFPkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:40:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:4144 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1386075AbhLFP0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:26:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="237275625"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="237275625"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 07:15:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="579399542"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Dec 2021 07:15:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 31B91144; Mon,  6 Dec 2021 17:15:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Piel <eric.piel@tremplin-utc.net>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v1 1/1] platform/x86: hp_accel: Use SIMPLE_DEV_PM_OPS() for PM ops
Date:   Mon,  6 Dec 2021 17:15:21 +0200
Message-Id: <20211206151521.22578-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit 34570a898eef ("platform/x86: hp_accel: Remove
_INI method call") there is no need to have separate methods for
resume and restore, hence we may fold them together and use
SIMPLE_DEV_PM_OPS() for PM ops.

While at it, switch to use __maybe_unused attribute.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/hp_accel.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
index 435a91fe2568..e9f852f7c27f 100644
--- a/drivers/platform/x86/hp_accel.c
+++ b/drivers/platform/x86/hp_accel.c
@@ -355,39 +355,20 @@ static int lis3lv02d_remove(struct platform_device *device)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int lis3lv02d_suspend(struct device *dev)
+static int __maybe_unused lis3lv02d_suspend(struct device *dev)
 {
 	/* make sure the device is off when we suspend */
 	lis3lv02d_poweroff(&lis3_dev);
 	return 0;
 }
 
-static int lis3lv02d_resume(struct device *dev)
+static int __maybe_unused lis3lv02d_resume(struct device *dev)
 {
 	lis3lv02d_poweron(&lis3_dev);
 	return 0;
 }
 
-static int lis3lv02d_restore(struct device *dev)
-{
-	lis3lv02d_poweron(&lis3_dev);
-	return 0;
-}
-
-static const struct dev_pm_ops hp_accel_pm = {
-	.suspend = lis3lv02d_suspend,
-	.resume = lis3lv02d_resume,
-	.freeze = lis3lv02d_suspend,
-	.thaw = lis3lv02d_resume,
-	.poweroff = lis3lv02d_suspend,
-	.restore = lis3lv02d_restore,
-};
-
-#define HP_ACCEL_PM (&hp_accel_pm)
-#else
-#define HP_ACCEL_PM NULL
-#endif
+static SIMPLE_DEV_PM_OPS(hp_accel_pm, lis3lv02d_suspend, lis3lv02d_resume);
 
 /* For the HP MDPS aka 3D Driveguard */
 static struct platform_driver lis3lv02d_driver = {
@@ -395,7 +376,7 @@ static struct platform_driver lis3lv02d_driver = {
 	.remove	= lis3lv02d_remove,
 	.driver	= {
 		.name	= "hp_accel",
-		.pm	= HP_ACCEL_PM,
+		.pm	= &hp_accel_pm,
 		.acpi_match_table = lis3lv02d_device_ids,
 	},
 };
-- 
2.33.0

