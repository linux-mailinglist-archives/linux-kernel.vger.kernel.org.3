Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65BF475788
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbhLOLMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:12:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:63314 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237049AbhLOLMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639566739; x=1671102739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=b3BZukaP2MFDjvcBAuPIdYvzAH8qFopuf9TzlXx7JzY=;
  b=ZJH9qCIpc/4puXgnRSrU1hnkyh1nyTeyixKPxfNzLWUo2MQ/voq70ZBx
   YzyOk9fyt8+QQEJPfYW7veLwXKdjfL0Z55B6DuRkfZz6PSwfzOC8IiGq7
   x94yzPEjAIQYX2l21yvUtE1vy+LF+VOlS59IYDXZfE9jOzLZP3lqcbVer
   iyYYy2RlWh8Oa6+nFB4g3kyuZNMRAQD2DaL8P+fYiEtnJTCQrsZCtFnkf
   yJ5Z3qmrhNmdGmUTDt9AxawOb+ccLkX8UueyCCiQw8uYW34kW//CyVmCB
   E3hDErkKYaTXF02zlWfdbkCUW3Lyh2tCM+qvuX5FxjdusRqkRwVFoQJA1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="239424563"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="239424563"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 03:12:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="661891567"
Received: from ipu5-build.bj.intel.com ([10.238.232.188])
  by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2021 03:12:16 -0800
From:   Bingbu Cao <bingbu.cao@intel.com>
To:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        rafael@kernel.org
Cc:     shawnx.tu@intel.com, chiranjeevi.rapolu@intel.com,
        tfiga@chromium.org, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org, bingbu.cao@linux.intel.com
Subject: [PATCH v2 3/6] media: ov2740: support device probe in non-zero ACPI D state
Date:   Wed, 15 Dec 2021 19:09:00 +0800
Message-Id: <1639566543-8561-4-git-send-email-bingbu.cao@intel.com>
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
 drivers/media/i2c/ov2740.c | 69 ++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c
index 934c9d65cb09..bab720c7c1de 100644
--- a/drivers/media/i2c/ov2740.c
+++ b/drivers/media/i2c/ov2740.c
@@ -345,6 +345,9 @@ struct ov2740 {
 
 	/* NVM data inforamtion */
 	struct nvm_data *nvm;
+
+	/* True if the device has been identified */
+	bool identified;
 };
 
 static inline struct ov2740 *to_ov2740(struct v4l2_subdev *subdev)
@@ -440,6 +443,30 @@ static int ov2740_write_reg_list(struct ov2740 *ov2740,
 	return 0;
 }
 
+static int ov2740_identify_module(struct ov2740 *ov2740)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&ov2740->sd);
+	int ret;
+	u32 val;
+
+	if (ov2740->identified)
+		return 0;
+
+	ret = ov2740_read_reg(ov2740, OV2740_REG_CHIP_ID, 3, &val);
+	if (ret)
+		return ret;
+
+	if (val != OV2740_CHIP_ID) {
+		dev_err(&client->dev, "chip id mismatch: %x!=%x",
+			OV2740_CHIP_ID, val);
+		return -ENXIO;
+	}
+
+	ov2740->identified = true;
+
+	return 0;
+}
+
 static int ov2740_update_digital_gain(struct ov2740 *ov2740, u32 d_gain)
 {
 	int ret = 0;
@@ -724,6 +751,10 @@ static int ov2740_start_streaming(struct ov2740 *ov2740)
 	int link_freq_index;
 	int ret = 0;
 
+	ret = ov2740_identify_module(ov2740);
+	if (ret)
+		return ret;
+
 	ov2740_load_otp_data(nvm);
 
 	link_freq_index = ov2740->cur_mode->link_freq_index;
@@ -956,25 +987,6 @@ static const struct v4l2_subdev_internal_ops ov2740_internal_ops = {
 	.open = ov2740_open,
 };
 
-static int ov2740_identify_module(struct ov2740 *ov2740)
-{
-	struct i2c_client *client = v4l2_get_subdevdata(&ov2740->sd);
-	int ret;
-	u32 val;
-
-	ret = ov2740_read_reg(ov2740, OV2740_REG_CHIP_ID, 3, &val);
-	if (ret)
-		return ret;
-
-	if (val != OV2740_CHIP_ID) {
-		dev_err(&client->dev, "chip id mismatch: %x!=%x",
-			OV2740_CHIP_ID, val);
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
 static int ov2740_check_hwcfg(struct device *dev)
 {
 	struct fwnode_handle *ep;
@@ -1137,6 +1149,7 @@ static int ov2740_probe(struct i2c_client *client)
 {
 	struct ov2740 *ov2740;
 	int ret = 0;
+	bool full_power;
 
 	ret = ov2740_check_hwcfg(&client->dev);
 	if (ret) {
@@ -1149,6 +1162,15 @@ static int ov2740_probe(struct i2c_client *client)
 	if (!ov2740)
 		return -ENOMEM;
 
+	full_power = acpi_dev_state_d0(&client->dev);
+	if (full_power) {
+		ret = ov2740_identify_module(ov2740);
+		if (ret) {
+			dev_err(&client->dev, "failed to find sensor: %d", ret);
+			return ret;
+		}
+	}
+
 	v4l2_i2c_subdev_init(&ov2740->sd, client, &ov2740_subdev_ops);
 	ret = ov2740_identify_module(ov2740);
 	if (ret) {
@@ -1186,11 +1208,9 @@ static int ov2740_probe(struct i2c_client *client)
 	if (ret)
 		dev_warn(&client->dev, "register nvmem failed, ret %d\n", ret);
 
-	/*
-	 * Device is already turned on by i2c-core with ACPI domain PM.
-	 * Enable runtime PM and turn off the device.
-	 */
-	pm_runtime_set_active(&client->dev);
+	/* Set the device's state to active if it's in D0 state. */
+	if (full_power)
+		pm_runtime_set_active(&client->dev);
 	pm_runtime_enable(&client->dev);
 	pm_runtime_idle(&client->dev);
 
@@ -1225,6 +1245,7 @@ static struct i2c_driver ov2740_i2c_driver = {
 	},
 	.probe_new = ov2740_probe,
 	.remove = ov2740_remove,
+	.flags = I2C_DRV_ACPI_WAIVE_D0_PROBE,
 };
 
 module_i2c_driver(ov2740_i2c_driver);
-- 
2.7.4

