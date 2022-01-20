Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7620494C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiATLPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:15:51 -0500
Received: from comms.puri.sm ([159.203.221.185]:45242 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230345AbiATLPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:15:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id B5734DF770;
        Thu, 20 Jan 2022 03:15:29 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bkfp2F8h1pmr; Thu, 20 Jan 2022 03:15:29 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm, mchehab@kernel.org, broonie@kernel.org,
        sakari.ailus@linux.intel.com
Cc:     kernel@puri.sm, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        Angus Ainslie <angus@akkea.ca>
Subject: [PATCH v4] media: i2c: dw9714: add optional regulator support
Date:   Thu, 20 Jan 2022 12:14:53 +0100
Message-Id: <20220120111453.2244905-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angus Ainslie <angus@akkea.ca>

Allow the dw9714 to control a regulator and adjust suspend() and resume()
to support both runtime and system pm.

Signed-off-by: Angus Ainslie <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---

v4: (thank you Sakari)
 * ensure suspend / power off in module remove()

v3: (thank you Mark and Sakari)
 * use regulator_get() instead of regulator_get_optional()
https://lore.kernel.org/linux-media/20211129120754.1766570-1-martin.kepplinger@puri.sm/

v2: (thank you Mark)
 * simplify the regulator_get_optional() error path
 * fix regulator usage during probe()
https://lore.kernel.org/linux-media/20211126090107.1243558-1-martin.kepplinger@puri.sm/

v1:
https://lore.kernel.org/linux-media/20211125080922.978583-1-martin.kepplinger@puri.sm/

 drivers/media/i2c/dw9714.c | 42 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/dw9714.c b/drivers/media/i2c/dw9714.c
index 3863dfeb8293..cd7008ad8f2f 100644
--- a/drivers/media/i2c/dw9714.c
+++ b/drivers/media/i2c/dw9714.c
@@ -5,6 +5,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-event.h>
@@ -36,6 +37,7 @@ struct dw9714_device {
 	struct v4l2_ctrl_handler ctrls_vcm;
 	struct v4l2_subdev sd;
 	u16 current_val;
+	struct regulator *vcc;
 };
 
 static inline struct dw9714_device *to_dw9714_vcm(struct v4l2_ctrl *ctrl)
@@ -145,6 +147,16 @@ static int dw9714_probe(struct i2c_client *client)
 	if (dw9714_dev == NULL)
 		return -ENOMEM;
 
+	dw9714_dev->vcc = devm_regulator_get(&client->dev, "vcc");
+	if (IS_ERR(dw9714_dev->vcc))
+		return PTR_ERR(dw9714_dev->vcc);
+
+	rval = regulator_enable(dw9714_dev->vcc);
+	if (rval < 0) {
+		dev_err(&client->dev, "failed to enable vcc: %d\n", rval);
+		return rval;
+	}
+
 	v4l2_i2c_subdev_init(&dw9714_dev->sd, client, &dw9714_ops);
 	dw9714_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
 				V4L2_SUBDEV_FL_HAS_EVENTS;
@@ -181,8 +193,18 @@ static int dw9714_remove(struct i2c_client *client)
 {
 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
 	struct dw9714_device *dw9714_dev = sd_to_dw9714_vcm(sd);
+	int ret;
 
 	pm_runtime_disable(&client->dev);
+	if (!pm_runtime_status_suspended(&client->dev)) {
+		ret = regulator_disable(dw9714_dev->vcc);
+		if (ret) {
+			dev_err(&client->dev,
+				"Failed to disable vcc: %d\n", ret);
+			return ret;
+		}
+	}
+	pm_runtime_set_suspended(&client->dev);
 	dw9714_subdev_cleanup(dw9714_dev);
 
 	return 0;
@@ -200,6 +222,9 @@ static int __maybe_unused dw9714_vcm_suspend(struct device *dev)
 	struct dw9714_device *dw9714_dev = sd_to_dw9714_vcm(sd);
 	int ret, val;
 
+	if (pm_runtime_suspended(&client->dev))
+		return 0;
+
 	for (val = dw9714_dev->current_val & ~(DW9714_CTRL_STEPS - 1);
 	     val >= 0; val -= DW9714_CTRL_STEPS) {
 		ret = dw9714_i2c_write(client,
@@ -208,7 +233,12 @@ static int __maybe_unused dw9714_vcm_suspend(struct device *dev)
 			dev_err_once(dev, "%s I2C failure: %d", __func__, ret);
 		usleep_range(DW9714_CTRL_DELAY_US, DW9714_CTRL_DELAY_US + 10);
 	}
-	return 0;
+
+	ret = regulator_disable(dw9714_dev->vcc);
+	if (ret)
+		dev_err(dev, "Failed to disable vcc: %d\n", ret);
+
+	return ret;
 }
 
 /*
@@ -224,6 +254,16 @@ static int  __maybe_unused dw9714_vcm_resume(struct device *dev)
 	struct dw9714_device *dw9714_dev = sd_to_dw9714_vcm(sd);
 	int ret, val;
 
+	if (pm_runtime_suspended(&client->dev))
+		return 0;
+
+	ret = regulator_enable(dw9714_dev->vcc);
+	if (ret) {
+		dev_err(dev, "Failed to enable vcc: %d\n", ret);
+		return ret;
+	}
+	usleep_range(1000, 2000);
+
 	for (val = dw9714_dev->current_val % DW9714_CTRL_STEPS;
 	     val < dw9714_dev->current_val + DW9714_CTRL_STEPS - 1;
 	     val += DW9714_CTRL_STEPS) {
-- 
2.30.2

