Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C08C475789
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbhLOLM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:12:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:63314 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234438AbhLOLMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639566741; x=1671102741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Z1lFsYlZv4n937462Dsck0ZQm1xRcuffqO61eFtiITU=;
  b=gykct4P3cyg1Z5Q3FntHv+OiEZ4pl308lczYY51nonGoyF1wbjTJBMGG
   HgmvgPwOS/8qOWexGnT2DfrOdDJ+zNAAGIKQ7APu9AAlT95I2piSG4pBG
   1D7Vfol5B+L3aZwkb5WuqJ/U1L/GawMOKisqfg+uxu9LPRVuwRxcE3zA3
   9fQI48Eyese64jeZ92214l0gRre32WG8TzdXLl0q+E9Z33mXNobKHoHO1
   LK+ybHyECpWDmDuxzvI1R13qpYX+qAt1d0a06+8lB3Bn44ZT+r9+cozN/
   wzY78xsh7ySU5g8lGVX8Gm3kb+JFZwxZ3XtGrJ9I3xh7PYhoYR7PFND7p
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="239424570"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="239424570"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 03:12:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="661891577"
Received: from ipu5-build.bj.intel.com ([10.238.232.188])
  by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2021 03:12:19 -0800
From:   Bingbu Cao <bingbu.cao@intel.com>
To:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        rafael@kernel.org
Cc:     shawnx.tu@intel.com, chiranjeevi.rapolu@intel.com,
        tfiga@chromium.org, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org, bingbu.cao@linux.intel.com
Subject: [PATCH v2 4/6] media: imx208: Support device probe in non-zero ACPI D state
Date:   Wed, 15 Dec 2021 19:09:01 +0800
Message-Id: <1639566543-8561-5-git-send-email-bingbu.cao@intel.com>
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
 drivers/media/i2c/imx208.c | 82 ++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 29 deletions(-)

diff --git a/drivers/media/i2c/imx208.c b/drivers/media/i2c/imx208.c
index 6f3d9c1b5879..b9516b2f1c15 100644
--- a/drivers/media/i2c/imx208.c
+++ b/drivers/media/i2c/imx208.c
@@ -296,6 +296,9 @@ struct imx208 {
 	/* OTP data */
 	bool otp_read;
 	char otp_data[IMX208_OTP_SIZE];
+
+	/* True if the device has been identified */
+	bool identified;
 };
 
 static inline struct imx208 *to_imx208(struct v4l2_subdev *_sd)
@@ -619,6 +622,34 @@ static int imx208_set_pad_format(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static int imx208_identify_module(struct imx208 *imx208)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&imx208->sd);
+	int ret;
+	u32 val;
+
+	if (imx208->identified)
+		return 0;
+
+	ret = imx208_read_reg(imx208, IMX208_REG_CHIP_ID,
+			      2, &val);
+	if (ret) {
+		dev_err(&client->dev, "failed to read chip id %x\n",
+			IMX208_CHIP_ID);
+		return ret;
+	}
+
+	if (val != IMX208_CHIP_ID) {
+		dev_err(&client->dev, "chip id mismatch: %x!=%x\n",
+			IMX208_CHIP_ID, val);
+		return -EIO;
+	}
+
+	imx208->identified = true;
+
+	return 0;
+}
+
 /* Start streaming */
 static int imx208_start_streaming(struct imx208 *imx208)
 {
@@ -626,6 +657,10 @@ static int imx208_start_streaming(struct imx208 *imx208)
 	const struct imx208_reg_list *reg_list;
 	int ret, link_freq_index;
 
+	ret = imx208_identify_module(imx208);
+	if (ret)
+		return ret;
+
 	/* Setup PLL */
 	link_freq_index = imx208->cur_mode->link_freq_index;
 	reg_list = &link_freq_configs[link_freq_index].reg_list;
@@ -752,29 +787,6 @@ static int __maybe_unused imx208_resume(struct device *dev)
 }
 
 /* Verify chip ID */
-static int imx208_identify_module(struct imx208 *imx208)
-{
-	struct i2c_client *client = v4l2_get_subdevdata(&imx208->sd);
-	int ret;
-	u32 val;
-
-	ret = imx208_read_reg(imx208, IMX208_REG_CHIP_ID,
-			      2, &val);
-	if (ret) {
-		dev_err(&client->dev, "failed to read chip id %x\n",
-			IMX208_CHIP_ID);
-		return ret;
-	}
-
-	if (val != IMX208_CHIP_ID) {
-		dev_err(&client->dev, "chip id mismatch: %x!=%x\n",
-			IMX208_CHIP_ID, val);
-		return -EIO;
-	}
-
-	return 0;
-}
-
 static const struct v4l2_subdev_video_ops imx208_video_ops = {
 	.s_stream = imx208_set_stream,
 };
@@ -813,6 +825,10 @@ static int imx208_read_otp(struct imx208 *imx208)
 		goto out_unlock;
 	}
 
+	ret = imx208_identify_module(imx208);
+	if (ret)
+		goto out_pm_put;
+
 	/* Write register address */
 	msgs[0].addr = client->addr;
 	msgs[0].flags = 0;
@@ -831,6 +847,7 @@ static int imx208_read_otp(struct imx208 *imx208)
 		ret = 0;
 	}
 
+out_pm_put:
 	pm_runtime_put(&client->dev);
 
 out_unlock:
@@ -961,6 +978,7 @@ static int imx208_probe(struct i2c_client *client)
 {
 	struct imx208 *imx208;
 	int ret;
+	bool full_power;
 	u32 val = 0;
 
 	device_property_read_u32(&client->dev, "clock-frequency", &val);
@@ -978,11 +996,14 @@ static int imx208_probe(struct i2c_client *client)
 	/* Initialize subdev */
 	v4l2_i2c_subdev_init(&imx208->sd, client, &imx208_subdev_ops);
 
-	/* Check module identity */
-	ret = imx208_identify_module(imx208);
-	if (ret) {
-		dev_err(&client->dev, "failed to find sensor: %d", ret);
-		goto error_probe;
+	full_power = acpi_dev_state_d0(&client->dev);
+	if (full_power) {
+		/* Check module identity */
+		ret = imx208_identify_module(imx208);
+		if (ret) {
+			dev_err(&client->dev, "failed to find sensor: %d", ret);
+			goto error_probe;
+		}
 	}
 
 	/* Set default mode to max resolution */
@@ -1017,7 +1038,9 @@ static int imx208_probe(struct i2c_client *client)
 		goto error_async_subdev;
 	}
 
-	pm_runtime_set_active(&client->dev);
+	/* Set the device's state to active if it's in D0 state. */
+	if (full_power)
+		pm_runtime_set_active(&client->dev);
 	pm_runtime_enable(&client->dev);
 	pm_runtime_idle(&client->dev);
 
@@ -1077,6 +1100,7 @@ static struct i2c_driver imx208_i2c_driver = {
 	},
 	.probe_new = imx208_probe,
 	.remove = imx208_remove,
+	.flags = I2C_DRV_ACPI_WAIVE_D0_PROBE,
 };
 
 module_i2c_driver(imx208_i2c_driver);
-- 
2.7.4

