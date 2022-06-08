Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70255431BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbiFHNou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240587AbiFHNon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:44:43 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B642E10ED;
        Wed,  8 Jun 2022 06:44:40 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 7728140002;
        Wed,  8 Jun 2022 13:44:37 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        foss+kernel@0leil.net,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v7 2/4] media: ov5675: add device-tree support and support runtime PM
Date:   Wed,  8 Jun 2022 15:44:18 +0200
Message-Id: <20220608134420.1750530-2-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220608134420.1750530-1-foss+kernel@0leil.net>
References: <20220608134420.1750530-1-foss+kernel@0leil.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Until now, this driver only supported ACPI. This adds support for
Device Tree too while enabling clock and regulators in runtime PM.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---

v6:
 - inverted-xmas-tree ordering,
 - space alignment instead of tab after data type for clk and
 reset_gpio,
 - added pm_runtime_set_suspended to remove callback as suggested by
 Tommaso (please cc the mailing list next time too so everyone can
 benefit from your reviews :) ),
 c.f. https://lists.linuxfoundation.org/pipermail/linux-pm/2012-July/034705.html
 - added Reviewed-by,

v5:
 - fixed -Wdeclaration-after-statement for delay_us,

v4:
 - added delays based on clock cycles as specified in datasheet for
 pre-power-off and post-power-on,
 - re-arranged clk handling, shutdown toggling and regulator handling to
 better match power up/down sequence defined in datasheet,
 - added comment on need for regulator being stable before releasing
 shutdown pin,

v3:
 - added linux/mod_devicetable.h include,
 - moved delay for reset pulse right after the regulators are enabled,
 - removed check on is_acpi_node in favor of checks on presence of OF
 properties (e.g. devm_clk_get_optional returns NULL),
 - moved power management out of system suspend/resume into runtime PM
 callbacks,
 - removed ACPI specific comment since it's not specific to this driver,
 - changed devm_clk_get to devm_clk_get_optional,
 - remove OF use of clock-frequency (handled by devm_clk_get_optional
 directly),
 - removed name of clock (only one, so no need for anything explicit)
 when requesting a clock from OF,
 - wrapped lines to 80 chars,

v2:
 - fixed unused-const-variable warning by removing of_match_ptr in
 of_match_table, reported by kernel test robot,
 drivers/media/i2c/ov5675.c | 150 +++++++++++++++++++++++++++++++------
 1 file changed, 129 insertions(+), 21 deletions(-)

diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
index 82ba9f56baec..e671fb24ebb4 100644
--- a/drivers/media/i2c/ov5675.c
+++ b/drivers/media/i2c/ov5675.c
@@ -3,10 +3,14 @@
 
 #include <asm/unaligned.h>
 #include <linux/acpi.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-fwnode.h>
@@ -17,7 +21,7 @@
 
 #define OV5675_LINK_FREQ_450MHZ		450000000ULL
 #define OV5675_SCLK			90000000LL
-#define OV5675_MCLK			19200000
+#define OV5675_XVCLK_19_2		19200000
 #define OV5675_DATA_LANES		2
 #define OV5675_RGB_DEPTH		10
 
@@ -76,6 +80,14 @@
 
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
@@ -484,6 +496,9 @@ struct ov5675 {
 	struct v4l2_subdev sd;
 	struct media_pad pad;
 	struct v4l2_ctrl_handler ctrl_handler;
+	struct clk *xvclk;
+	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data supplies[OV5675_NUM_SUPPLIES];
 
 	/* V4L2 Controls */
 	struct v4l2_ctrl *link_freq;
@@ -944,6 +959,56 @@ static int ov5675_set_stream(struct v4l2_subdev *sd, int enable)
 	return ret;
 }
 
+static int ov5675_power_off(struct device *dev)
+{
+	/* 512 xvclk cycles after the last SCCB transation or MIPI frame end */
+	u32 delay_us = DIV_ROUND_UP(512, OV5675_XVCLK_19_2 / 1000 / 1000);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct ov5675 *ov5675 = to_ov5675(sd);
+
+	usleep_range(delay_us, delay_us * 2);
+
+	clk_disable_unprepare(ov5675->xvclk);
+	gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
+	regulator_bulk_disable(OV5675_NUM_SUPPLIES, ov5675->supplies);
+
+	return 0;
+}
+
+static int ov5675_power_on(struct device *dev)
+{
+	u32 delay_us = DIV_ROUND_UP(8192, OV5675_XVCLK_19_2 / 1000 / 1000);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct ov5675 *ov5675 = to_ov5675(sd);
+	int ret;
+
+	ret = clk_prepare_enable(ov5675->xvclk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable xvclk: %d\n", ret);
+		return ret;
+	}
+
+	gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
+
+	ret = regulator_bulk_enable(OV5675_NUM_SUPPLIES, ov5675->supplies);
+	if (ret) {
+		clk_disable_unprepare(ov5675->xvclk);
+		return ret;
+	}
+
+	/* Reset pulse should be at least 2ms and reset gpio released only once
+	 * regulators are stable.
+	 */
+	usleep_range(2000, 2200);
+
+	gpiod_set_value_cansleep(ov5675->reset_gpio, 0);
+
+	/* 8192 xvclk cycles prior to the first SCCB transation */
+	usleep_range(delay_us, delay_us * 2);
+
+	return 0;
+}
+
 static int __maybe_unused ov5675_suspend(struct device *dev)
 {
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
@@ -1106,32 +1171,60 @@ static const struct v4l2_subdev_internal_ops ov5675_internal_ops = {
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
+	ov5675->xvclk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(ov5675->xvclk))
+		return dev_err_probe(dev, PTR_ERR(ov5675->xvclk),
+				     "failed to get xvclk: %ld\n",
+				     PTR_ERR(ov5675->xvclk));
 
-	if (ret) {
-		dev_err(dev, "can't get clock frequency");
-		return ret;
+	if (ov5675->xvclk) {
+		xvclk_rate = clk_get_rate(ov5675->xvclk);
+	} else {
+		ret = fwnode_property_read_u32(fwnode, "clock-frequency",
+					       &xvclk_rate);
+
+		if (ret) {
+			dev_err(dev, "can't get clock frequency");
+			return ret;
+		}
 	}
 
-	if (mclk != OV5675_MCLK) {
-		dev_err(dev, "external clock %d is not supported", mclk);
+	if (xvclk_rate != OV5675_XVCLK_19_2) {
+		dev_err(dev, "external clock rate %u is unsupported",
+			xvclk_rate);
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
@@ -1186,6 +1279,10 @@ static int ov5675_remove(struct i2c_client *client)
 	pm_runtime_disable(&client->dev);
 	mutex_destroy(&ov5675->mutex);
 
+	if (!pm_runtime_status_suspended(&client->dev))
+		ov5675_power_off(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+
 	return 0;
 }
 
@@ -1195,25 +1292,31 @@ static int ov5675_probe(struct i2c_client *client)
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
 
+	ret = ov5675_power_on(&client->dev);
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
 
@@ -1243,11 +1346,6 @@ static int ov5675_probe(struct i2c_client *client)
 		goto probe_error_media_entity_cleanup;
 	}
 
-	/*
-	 * Device is already turned on by i2c-core with ACPI domain PM.
-	 * Enable runtime PM and turn off the device.
-	 */
-
 	/* Set the device's state to active if it's in D0 state. */
 	if (full_power)
 		pm_runtime_set_active(&client->dev);
@@ -1262,12 +1360,15 @@ static int ov5675_probe(struct i2c_client *client)
 probe_error_v4l2_ctrl_handler_free:
 	v4l2_ctrl_handler_free(ov5675->sd.ctrl_handler);
 	mutex_destroy(&ov5675->mutex);
+probe_power_off:
+	ov5675_power_off(&client->dev);
 
 	return ret;
 }
 
 static const struct dev_pm_ops ov5675_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ov5675_suspend, ov5675_resume)
+	SET_RUNTIME_PM_OPS(ov5675_power_off, ov5675_power_on, NULL)
 };
 
 #ifdef CONFIG_ACPI
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
2.36.1

