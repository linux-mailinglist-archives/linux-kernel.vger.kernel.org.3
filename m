Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2032347578F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbhLOLMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:12:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:63314 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241982AbhLOLM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639566747; x=1671102747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9l7vz7S6sHBPOubcfHs4L+ETl/DmVqg9c1nE2ISAZVA=;
  b=PzvIZCLSuLC+hzy+cjEf1d0JtmXwtiiRBzn6zhNa6Jbx4wqefZye3ZbR
   Uj23gq1iZymMZUJetHEAFjPKVOWehGOYv+KA7wYHVMzlDtfz9RR5b8KNB
   S7qdNFFIjQJIfNU6uGQOZS0m7kRirsro/WzG0NvOWheGUNwJpsiTReAV7
   XsZmFqvArsJNc4q3MNa2Bi73i5u9nZdH5wtcLTyAEorgOCkUTjxR9x9Dd
   lPKQQlSx+OYZqBmbMTd/O00vpwztDFkajnKV0MrJnuUbaxxRA3hrQf+9/
   brXjzZqJmM7xM6bPXLV66je7gwZ4wTPynCwMvb4/e5ARBLeYDeu23Fqmm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="239424584"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="239424584"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 03:12:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="661891592"
Received: from ipu5-build.bj.intel.com ([10.238.232.188])
  by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2021 03:12:24 -0800
From:   Bingbu Cao <bingbu.cao@intel.com>
To:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        rafael@kernel.org
Cc:     shawnx.tu@intel.com, chiranjeevi.rapolu@intel.com,
        tfiga@chromium.org, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org, bingbu.cao@linux.intel.com
Subject: [PATCH v2 6/6] media: hi556: Support device probe in non-zero ACPI D state
Date:   Wed, 15 Dec 2021 19:09:03 +0800
Message-Id: <1639566543-8561-7-git-send-email-bingbu.cao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639566543-8561-1-git-send-email-bingbu.cao@intel.com>
References: <1639566543-8561-1-git-send-email-bingbu.cao@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tell ACPI device PM code that the driver supports the device being in
non-zero ACPI D state when the driver's probe function is entered.

Also do identification on the first access of the device, whether in probe
or when starting streaming.

Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Kao, Arec <arec.kao@intel.com>
---
 drivers/media/i2c/hi556.c | 70 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/media/i2c/hi556.c b/drivers/media/i2c/hi556.c
index 8db1cbedc1fd..055d1aa8410e 100644
--- a/drivers/media/i2c/hi556.c
+++ b/drivers/media/i2c/hi556.c
@@ -495,6 +495,9 @@ struct hi556 {
 
 	/* Streaming on/off */
 	bool streaming;
+
+	/* True if the device has been identified */
+	bool identified;
 };
 
 static u64 to_pixel_rate(u32 f_index)
@@ -757,12 +760,41 @@ static void hi556_assign_pad_format(const struct hi556_mode *mode,
 	fmt->field = V4L2_FIELD_NONE;
 }
 
+static int hi556_identify_module(struct hi556 *hi556)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&hi556->sd);
+	int ret;
+	u32 val;
+
+	if (hi556->identified)
+		return 0;
+
+	ret = hi556_read_reg(hi556, HI556_REG_CHIP_ID,
+			     HI556_REG_VALUE_16BIT, &val);
+	if (ret)
+		return ret;
+
+	if (val != HI556_CHIP_ID) {
+		dev_err(&client->dev, "chip id mismatch: %x!=%x",
+			HI556_CHIP_ID, val);
+		return -ENXIO;
+	}
+
+	hi556->identified = true;
+
+	return 0;
+}
+
 static int hi556_start_streaming(struct hi556 *hi556)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&hi556->sd);
 	const struct hi556_reg_list *reg_list;
 	int link_freq_index, ret;
 
+	ret = hi556_identify_module(hi556);
+	if (ret)
+		return ret;
+
 	link_freq_index = hi556->cur_mode->link_freq_index;
 	reg_list = &link_freq_configs[link_freq_index].reg_list;
 	ret = hi556_write_reg_list(hi556, reg_list);
@@ -1001,26 +1033,6 @@ static const struct v4l2_subdev_internal_ops hi556_internal_ops = {
 	.open = hi556_open,
 };
 
-static int hi556_identify_module(struct hi556 *hi556)
-{
-	struct i2c_client *client = v4l2_get_subdevdata(&hi556->sd);
-	int ret;
-	u32 val;
-
-	ret = hi556_read_reg(hi556, HI556_REG_CHIP_ID,
-			     HI556_REG_VALUE_16BIT, &val);
-	if (ret)
-		return ret;
-
-	if (val != HI556_CHIP_ID) {
-		dev_err(&client->dev, "chip id mismatch: %x!=%x",
-			HI556_CHIP_ID, val);
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
 static int hi556_check_hwcfg(struct device *dev)
 {
 	struct fwnode_handle *ep;
@@ -1106,6 +1118,7 @@ static int hi556_remove(struct i2c_client *client)
 static int hi556_probe(struct i2c_client *client)
 {
 	struct hi556 *hi556;
+	bool full_power;
 	int ret;
 
 	ret = hi556_check_hwcfg(&client->dev);
@@ -1120,10 +1133,14 @@ static int hi556_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	v4l2_i2c_subdev_init(&hi556->sd, client, &hi556_subdev_ops);
-	ret = hi556_identify_module(hi556);
-	if (ret) {
-		dev_err(&client->dev, "failed to find sensor: %d", ret);
-		return ret;
+
+	full_power = acpi_dev_state_d0(&client->dev);
+	if (full_power) {
+		ret = hi556_identify_module(hi556);
+		if (ret) {
+			dev_err(&client->dev, "failed to find sensor: %d", ret);
+			return ret;
+		}
 	}
 
 	mutex_init(&hi556->mutex);
@@ -1152,7 +1169,9 @@ static int hi556_probe(struct i2c_client *client)
 		goto probe_error_media_entity_cleanup;
 	}
 
-	pm_runtime_set_active(&client->dev);
+	/* Set the device's state to active if it's in D0 state. */
+	if (full_power)
+		pm_runtime_set_active(&client->dev);
 	pm_runtime_enable(&client->dev);
 	pm_runtime_idle(&client->dev);
 
@@ -1189,6 +1208,7 @@ static struct i2c_driver hi556_i2c_driver = {
 	},
 	.probe_new = hi556_probe,
 	.remove = hi556_remove,
+	.flags = I2C_DRV_ACPI_WAIVE_D0_PROBE,
 };
 
 module_i2c_driver(hi556_i2c_driver);
-- 
2.7.4

