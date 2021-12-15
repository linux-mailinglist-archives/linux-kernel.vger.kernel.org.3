Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB70D47578E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbhLOLMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:12:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:63314 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242000AbhLOLMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639566744; x=1671102744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=pqyUJZNA695XA2/jLm5NMQB5lQ3C4KIqTxok8z0ABUA=;
  b=WNjNeGcnAKoJrS3CyOu6nlh1JwJVjm6ITnuPtaed0rkPDrRaPeB8ZG1t
   /kN7iMs7L3Ise2pvV+ROY6hl8usAaHMcrp230K1tOTEi8T1cEUoeTceFp
   fajyZtHfvTfrWpN+2LrQxU3HKIL6tJYTvsEGH0IhMjIFo19NpKwwroj4t
   EBnZHqWPishiEqV/RruAdFEsleepIjpC8gQuIcMr7xV3jOUlpym+PFbuw
   OxCzTvYlRZrMNgJIExHPBqjMsYKzfq8XkVcNXEm9PfYTcXq0L+XmrZZdR
   +ICM3RM4etXZvuZCFGLl+UAN5/1aaq9KGPNG0pKkOI0ffEN0DZ4E6ljLn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="239424577"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="239424577"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 03:12:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="661891586"
Received: from ipu5-build.bj.intel.com ([10.238.232.188])
  by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2021 03:12:21 -0800
From:   Bingbu Cao <bingbu.cao@intel.com>
To:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        rafael@kernel.org
Cc:     shawnx.tu@intel.com, chiranjeevi.rapolu@intel.com,
        tfiga@chromium.org, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org, bingbu.cao@linux.intel.com
Subject: [PATCH v2 5/6] media: ov5675: Support device probe in non-zero ACPI D state
Date:   Wed, 15 Dec 2021 19:09:02 +0800
Message-Id: <1639566543-8561-6-git-send-email-bingbu.cao@intel.com>
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
---
 drivers/media/i2c/ov5675.c | 71 ++++++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
index da5850b7ad07..00925850fa7c 100644
--- a/drivers/media/i2c/ov5675.c
+++ b/drivers/media/i2c/ov5675.c
@@ -493,6 +493,9 @@ struct ov5675 {
 
 	/* Streaming on/off */
 	bool streaming;
+
+	/* True if the device has been identified */
+	bool identified;
 };
 
 static u64 to_pixel_rate(u32 f_index)
@@ -808,12 +811,41 @@ static void ov5675_update_pad_format(const struct ov5675_mode *mode,
 	fmt->field = V4L2_FIELD_NONE;
 }
 
+static int ov5675_identify_module(struct ov5675 *ov5675)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&ov5675->sd);
+	int ret;
+	u32 val;
+
+	if (ov5675->identified)
+		return 0;
+
+	ret = ov5675_read_reg(ov5675, OV5675_REG_CHIP_ID,
+			      OV5675_REG_VALUE_24BIT, &val);
+	if (ret)
+		return ret;
+
+	if (val != OV5675_CHIP_ID) {
+		dev_err(&client->dev, "chip id mismatch: %x!=%x",
+			OV5675_CHIP_ID, val);
+		return -ENXIO;
+	}
+
+	ov5675->identified = true;
+
+	return 0;
+}
+
 static int ov5675_start_streaming(struct ov5675 *ov5675)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&ov5675->sd);
 	const struct ov5675_reg_list *reg_list;
 	int link_freq_index, ret;
 
+	ret = ov5675_identify_module(ov5675);
+	if (ret)
+		return ret;
+
 	link_freq_index = ov5675->cur_mode->link_freq_index;
 	reg_list = &link_freq_configs[link_freq_index].reg_list;
 	ret = ov5675_write_reg_list(ov5675, reg_list);
@@ -1048,26 +1080,6 @@ static const struct v4l2_subdev_internal_ops ov5675_internal_ops = {
 	.open = ov5675_open,
 };
 
-static int ov5675_identify_module(struct ov5675 *ov5675)
-{
-	struct i2c_client *client = v4l2_get_subdevdata(&ov5675->sd);
-	int ret;
-	u32 val;
-
-	ret = ov5675_read_reg(ov5675, OV5675_REG_CHIP_ID,
-			      OV5675_REG_VALUE_24BIT, &val);
-	if (ret)
-		return ret;
-
-	if (val != OV5675_CHIP_ID) {
-		dev_err(&client->dev, "chip id mismatch: %x!=%x",
-			OV5675_CHIP_ID, val);
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
 static int ov5675_check_hwcfg(struct device *dev)
 {
 	struct fwnode_handle *ep;
@@ -1154,6 +1166,7 @@ static int ov5675_remove(struct i2c_client *client)
 static int ov5675_probe(struct i2c_client *client)
 {
 	struct ov5675 *ov5675;
+	bool full_power;
 	int ret;
 
 	ret = ov5675_check_hwcfg(&client->dev);
@@ -1168,10 +1181,14 @@ static int ov5675_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	v4l2_i2c_subdev_init(&ov5675->sd, client, &ov5675_subdev_ops);
-	ret = ov5675_identify_module(ov5675);
-	if (ret) {
-		dev_err(&client->dev, "failed to find sensor: %d", ret);
-		return ret;
+
+	full_power = acpi_dev_state_d0(&client->dev);
+	if (full_power) {
+		ret = ov5675_identify_module(ov5675);
+		if (ret) {
+			dev_err(&client->dev, "failed to find sensor: %d", ret);
+			return ret;
+		}
 	}
 
 	mutex_init(&ov5675->mutex);
@@ -1204,7 +1221,10 @@ static int ov5675_probe(struct i2c_client *client)
 	 * Device is already turned on by i2c-core with ACPI domain PM.
 	 * Enable runtime PM and turn off the device.
 	 */
-	pm_runtime_set_active(&client->dev);
+
+	/* Set the device's state to active if it's in D0 state. */
+	if (full_power)
+		pm_runtime_set_active(&client->dev);
 	pm_runtime_enable(&client->dev);
 	pm_runtime_idle(&client->dev);
 
@@ -1241,6 +1261,7 @@ static struct i2c_driver ov5675_i2c_driver = {
 	},
 	.probe_new = ov5675_probe,
 	.remove = ov5675_remove,
+	.flags = I2C_DRV_ACPI_WAIVE_D0_PROBE,
 };
 
 module_i2c_driver(ov5675_i2c_driver);
-- 
2.7.4

