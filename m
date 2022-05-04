Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CA351A1B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351057AbiEDOHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349009AbiEDOHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:07:53 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F69928998;
        Wed,  4 May 2022 07:04:16 -0700 (PDT)
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id E971BC5C9D;
        Wed,  4 May 2022 13:56:00 +0000 (UTC)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id AEE04E0013;
        Wed,  4 May 2022 13:55:54 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH v2 2/3] media: ov5675: add device-tree support
Date:   Wed,  4 May 2022 15:55:42 +0200
Message-Id: <20220504135543.59522-2-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504135543.59522-1-foss+kernel@0leil.net>
References: <20220504135543.59522-1-foss+kernel@0leil.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Until now, this driver only supported ACPI. This adds support for
Device Tree too.

This is heavily inspired by device tree support addition to OV8856
driver. The differentiation between ACPI and DT mode is done through an
is_acpi_node check.

Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---

v2:
 - fixed unused-const-variable warning by removing of_match_ptr in
 of_match_table, reported by kernel test robot,

 drivers/media/i2c/ov5675.c | 134 +++++++++++++++++++++++++++++++++----
 1 file changed, 121 insertions(+), 13 deletions(-)

diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
index 82ba9f56baec..ccbc8dc506ff 100644
--- a/drivers/media/i2c/ov5675.c
+++ b/drivers/media/i2c/ov5675.c
@@ -3,10 +3,13 @@
 
 #include <asm/unaligned.h>
 #include <linux/acpi.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-fwnode.h>
@@ -17,7 +20,7 @@
 
 #define OV5675_LINK_FREQ_450MHZ		450000000ULL
 #define OV5675_SCLK			90000000LL
-#define OV5675_MCLK			19200000
+#define OV5675_XVCLK_19_2		19200000
 #define OV5675_DATA_LANES		2
 #define OV5675_RGB_DEPTH		10
 
@@ -76,6 +79,14 @@
 
 #define to_ov5675(_sd)			container_of(_sd, struct ov5675, sd)
 
+static const char * const ov5675_supply_names[] = {
+	"avdd",		/* Analog power */
+	"dovdd",	/* Digital I/O power */
+	"dvdd",		/* Digital core power */
+};
+
+#define OV5675_NUM_SUPPLIES	ARRAY_SIZE(ov5675_supply_names)
+
 enum {
 	OV5675_LINK_FREQ_900MBPS,
 };
@@ -484,6 +495,9 @@ struct ov5675 {
 	struct v4l2_subdev sd;
 	struct media_pad pad;
 	struct v4l2_ctrl_handler ctrl_handler;
+	struct clk		*xvclk;
+	struct gpio_desc	*reset_gpio;
+	struct regulator_bulk_data supplies[OV5675_NUM_SUPPLIES];
 
 	/* V4L2 Controls */
 	struct v4l2_ctrl *link_freq;
@@ -944,6 +958,52 @@ static int ov5675_set_stream(struct v4l2_subdev *sd, int enable)
 	return ret;
 }
 
+static void __ov5675_power_off(struct ov5675 *ov5675)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&ov5675->sd);
+
+	if (is_acpi_node(dev_fwnode(&client->dev)))
+		return;
+
+	gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
+	usleep_range(1000, 1200);
+
+	regulator_bulk_disable(OV5675_NUM_SUPPLIES, ov5675->supplies);
+	clk_disable_unprepare(ov5675->xvclk);
+}
+
+static int __ov5675_power_on(struct ov5675 *ov5675)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&ov5675->sd);
+	int ret;
+
+	if (is_acpi_node(dev_fwnode(&client->dev)))
+		return 0;
+
+	ret = clk_prepare_enable(ov5675->xvclk);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to enable xvclk: %d\n", ret);
+		return ret;
+	}
+
+	gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
+
+	/* Reset pulse should be at least 2ms */
+	usleep_range(2000, 2200);
+
+	ret = regulator_bulk_enable(OV5675_NUM_SUPPLIES, ov5675->supplies);
+	if (ret) {
+		clk_disable_unprepare(ov5675->xvclk);
+		return ret;
+	}
+
+	gpiod_set_value_cansleep(ov5675->reset_gpio, 0);
+
+	usleep_range(1000, 1200);
+
+	return 0;
+}
+
 static int __maybe_unused ov5675_suspend(struct device *dev)
 {
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
@@ -953,6 +1013,7 @@ static int __maybe_unused ov5675_suspend(struct device *dev)
 	if (ov5675->streaming)
 		ov5675_stop_streaming(ov5675);
 
+	__ov5675_power_off(ov5675);
 	mutex_unlock(&ov5675->mutex);
 
 	return 0;
@@ -965,6 +1026,8 @@ static int __maybe_unused ov5675_resume(struct device *dev)
 	int ret;
 
 	mutex_lock(&ov5675->mutex);
+
+	__ov5675_power_on(ov5675);
 	if (ov5675->streaming) {
 		ret = ov5675_start_streaming(ov5675);
 		if (ret) {
@@ -1106,32 +1169,60 @@ static const struct v4l2_subdev_internal_ops ov5675_internal_ops = {
 	.open = ov5675_open,
 };
 
-static int ov5675_check_hwcfg(struct device *dev)
+static int ov5675_get_hwcfg(struct ov5675 *ov5675, struct device *dev)
 {
 	struct fwnode_handle *ep;
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct v4l2_fwnode_endpoint bus_cfg = {
 		.bus_type = V4L2_MBUS_CSI2_DPHY
 	};
-	u32 mclk;
+	u32 xvclk_rate;
 	int ret;
 	unsigned int i, j;
 
 	if (!fwnode)
 		return -ENXIO;
 
-	ret = fwnode_property_read_u32(fwnode, "clock-frequency", &mclk);
+	ret = fwnode_property_read_u32(fwnode, "clock-frequency", &xvclk_rate);
 
 	if (ret) {
 		dev_err(dev, "can't get clock frequency");
 		return ret;
 	}
 
-	if (mclk != OV5675_MCLK) {
-		dev_err(dev, "external clock %d is not supported", mclk);
+	if (!is_acpi_node(fwnode)) {
+		ov5675->xvclk = devm_clk_get(dev, "xvclk");
+		if (IS_ERR(ov5675->xvclk)) {
+			ret = PTR_ERR(ov5675->xvclk);
+			dev_err(dev, "failed to get xvclk: %d\n", ret);
+			return ret;
+		}
+
+		clk_set_rate(ov5675->xvclk, xvclk_rate);
+		xvclk_rate = clk_get_rate(ov5675->xvclk);
+	}
+
+	if (xvclk_rate != OV5675_XVCLK_19_2) {
+		dev_err(dev, "external clock rate %u is unsupported", xvclk_rate);
 		return -EINVAL;
 	}
 
+	ov5675->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						     GPIOD_OUT_HIGH);
+	if (IS_ERR(ov5675->reset_gpio)) {
+		ret = PTR_ERR(ov5675->reset_gpio);
+		dev_err(dev, "failed to get reset-gpios: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < OV5675_NUM_SUPPLIES; i++)
+		ov5675->supplies[i].supply = ov5675_supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, OV5675_NUM_SUPPLIES,
+				      ov5675->supplies);
+	if (ret)
+		return ret;
+
 	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
 	if (!ep)
 		return -ENXIO;
@@ -1186,6 +1277,8 @@ static int ov5675_remove(struct i2c_client *client)
 	pm_runtime_disable(&client->dev);
 	mutex_destroy(&ov5675->mutex);
 
+	__ov5675_power_off(ov5675);
+
 	return 0;
 }
 
@@ -1195,25 +1288,31 @@ static int ov5675_probe(struct i2c_client *client)
 	bool full_power;
 	int ret;
 
-	ret = ov5675_check_hwcfg(&client->dev);
+	ov5675 = devm_kzalloc(&client->dev, sizeof(*ov5675), GFP_KERNEL);
+	if (!ov5675)
+		return -ENOMEM;
+
+	ret = ov5675_get_hwcfg(ov5675, &client->dev);
 	if (ret) {
-		dev_err(&client->dev, "failed to check HW configuration: %d",
+		dev_err(&client->dev, "failed to get HW configuration: %d",
 			ret);
 		return ret;
 	}
 
-	ov5675 = devm_kzalloc(&client->dev, sizeof(*ov5675), GFP_KERNEL);
-	if (!ov5675)
-		return -ENOMEM;
-
 	v4l2_i2c_subdev_init(&ov5675->sd, client, &ov5675_subdev_ops);
 
+	ret = __ov5675_power_on(ov5675);
+	if (ret) {
+		dev_err(&client->dev, "failed to power on: %d\n", ret);
+		return ret;
+	}
+
 	full_power = acpi_dev_state_d0(&client->dev);
 	if (full_power) {
 		ret = ov5675_identify_module(ov5675);
 		if (ret) {
 			dev_err(&client->dev, "failed to find sensor: %d", ret);
-			return ret;
+			goto probe_power_off;
 		}
 	}
 
@@ -1262,6 +1361,8 @@ static int ov5675_probe(struct i2c_client *client)
 probe_error_v4l2_ctrl_handler_free:
 	v4l2_ctrl_handler_free(ov5675->sd.ctrl_handler);
 	mutex_destroy(&ov5675->mutex);
+probe_power_off:
+	__ov5675_power_off(ov5675);
 
 	return ret;
 }
@@ -1279,11 +1380,18 @@ static const struct acpi_device_id ov5675_acpi_ids[] = {
 MODULE_DEVICE_TABLE(acpi, ov5675_acpi_ids);
 #endif
 
+static const struct of_device_id ov5675_of_match[] = {
+	{ .compatible = "ovti,ov5675", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ov5675_of_match);
+
 static struct i2c_driver ov5675_i2c_driver = {
 	.driver = {
 		.name = "ov5675",
 		.pm = &ov5675_pm_ops,
 		.acpi_match_table = ACPI_PTR(ov5675_acpi_ids),
+		.of_match_table = ov5675_of_match,
 	},
 	.probe_new = ov5675_probe,
 	.remove = ov5675_remove,
-- 
2.35.1

