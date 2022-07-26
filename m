Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E8C5812C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiGZMGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbiGZMF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:05:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82F814008;
        Tue, 26 Jul 2022 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658837155; x=1690373155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IUSEatphJXrxHtFATG8DqV4oMhLluYvQE60yRglB11c=;
  b=Ylpe4xrJ2Y1aRdS1iHvguK5GOO8nhco7acZOMn8/AQ01jolQ2EbHDs2Y
   a0Jtp2BQ8iV4KeyZHWJZRj+TGZUk2KX7a9HC4FFrp8PbjU4a31kZWxsfY
   VdwqfJpJL+zcBnD+mbFshdCHmICUpOFZRFsvE/TOWvxnCDyYNQxIN7XKz
   WfJHMTuRmACvkeicv8/2CBqfOiYmlqZvT3m9quyB3c/8uxjc4n4Ku+gPE
   Z0+TMupC/Px+e4+9tW2gUQ24u4/uGukYxl+3MLMSuH5TBYpiULa6b4q3y
   S4O4mh1lWzRSGsvZjQBKm4OfnJVS24c6PXFkLZdOK3ABDZsz7Ow2wLIWE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="270971289"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="270971289"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 05:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="702871733"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2022 05:05:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 64AC511C; Tue, 26 Jul 2022 15:06:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v1 3/8] media: ov2740: Switch from __maybe_unused to pm_sleep_ptr() etc
Date:   Tue, 26 Jul 2022 15:05:51 +0300
Message-Id: <20220726120556.2881-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less heavier for builds
than the use of __maybe_unused attributes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/ov2740.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c
index 81c0ab220339..9420258c6073 100644
--- a/drivers/media/i2c/ov2740.c
+++ b/drivers/media/i2c/ov2740.c
@@ -838,7 +838,7 @@ static int ov2740_set_stream(struct v4l2_subdev *sd, int enable)
 	return ret;
 }
 
-static int __maybe_unused ov2740_suspend(struct device *dev)
+static int ov2740_suspend(struct device *dev)
 {
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ov2740 *ov2740 = to_ov2740(sd);
@@ -852,7 +852,7 @@ static int __maybe_unused ov2740_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused ov2740_resume(struct device *dev)
+static int ov2740_resume(struct device *dev)
 {
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ov2740 *ov2740 = to_ov2740(sd);
@@ -1229,9 +1229,7 @@ static int ov2740_probe(struct i2c_client *client)
 	return ret;
 }
 
-static const struct dev_pm_ops ov2740_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ov2740_suspend, ov2740_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(ov2740_pm_ops, ov2740_suspend, ov2740_resume);
 
 static const struct acpi_device_id ov2740_acpi_ids[] = {
 	{"INT3474"},
@@ -1243,7 +1241,7 @@ MODULE_DEVICE_TABLE(acpi, ov2740_acpi_ids);
 static struct i2c_driver ov2740_i2c_driver = {
 	.driver = {
 		.name = "ov2740",
-		.pm = &ov2740_pm_ops,
+		.pm = pm_sleep_ptr(&ov2740_pm_ops),
 		.acpi_match_table = ov2740_acpi_ids,
 	},
 	.probe_new = ov2740_probe,
-- 
2.35.1

