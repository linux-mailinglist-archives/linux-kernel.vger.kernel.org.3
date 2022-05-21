Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CB052F8F4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 07:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354599AbiEUFkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 01:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354537AbiEUFj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 01:39:59 -0400
X-Greylist: delayed 461 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 May 2022 22:39:55 PDT
Received: from bigfoot-server-node4.server.classfun.cn (unknown [124.72.161.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F81617EC35;
        Fri, 20 May 2022 22:39:54 -0700 (PDT)
Received: by bigfoot-server-node4.server.classfun.cn (Postfix, from userid 0)
        id 952D62129A; Sat, 21 May 2022 13:32:11 +0800 (CST)
From:   Junhao Xie <bigfoot@classfun.cn>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, angelogioacchino.delregno@somainline.org,
        konrad.dybcio@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bigfoot@classfun.cn
Subject: [PATCH 1/2] drm: panel: Add samsung fhd-ea8076 panel driver
Date:   Sat, 21 May 2022 13:31:55 +0800
Message-Id: <20220521053156.1374185-1-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Samsung Full HD EA8076 panel with a resolution of 2340x1080@60Hz

Xiaomi MIX 3 smartphone uses this panel

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 .../display/panel/panel-simple-dsi.yaml       |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-samsung-fhd-ea8076.c  | 339 ++++++++++++++++++
 4 files changed, 352 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-fhd-ea8076.c

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index 2c00813f5d20..baa0e8f6de3c 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -57,6 +57,8 @@ properties:
       - samsung,sofef00
         # Shangai Top Display Optoelectronics 7" TL070WSH30 1024x600 TFT LCD panel
       - tdo,tl070wsh30
+        # Samsung ea8076 1080x2340 FullHD AMOLED panel
+      - samsung,fhd-ea8076
 
   reg:
     maxItems: 1
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index ddf5f38e8731..1e533576f691 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -526,6 +526,16 @@ config DRM_PANEL_SAMSUNG_SOFEF00
 
 	  The panels are 2280x1080@60Hz and 2340x1080@60Hz respectively
 
+config DRM_PANEL_SAMSUNG_FHD_EA8076
+	tristate "Samsung EA8076 DSI cmd mode panels"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	select VIDEOMODE_HELPERS
+	help
+	  Say Y or M here if you want to enable support for the Samsung AMOLED
+	  2340x1080 command mode panel found in the Xiaomi MIX3 smartphone.
+
 config DRM_PANEL_SEIKO_43WVF1G
 	tristate "Seiko 43WVF1G panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 5740911f637c..bacc1196f32a 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI) += panel-samsung-s6e63m0-dsi.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01) += panel-samsung-s6e88a0-ams452ef01.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0) += panel-samsung-s6e8aa0.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_SOFEF00) += panel-samsung-sofef00.o
+obj-$(CONFIG_DRM_PANEL_SAMSUNG_FHD_EA8076) += panel-samsung-fhd-ea8076.o
 obj-$(CONFIG_DRM_PANEL_SEIKO_43WVF1G) += panel-seiko-43wvf1g.o
 obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) += panel-sharp-lq101r1sx01.o
 obj-$(CONFIG_DRM_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
diff --git a/drivers/gpu/drm/panel/panel-samsung-fhd-ea8076.c b/drivers/gpu/drm/panel/panel-samsung-fhd-ea8076.c
new file mode 100644
index 000000000000..f793b025bd6d
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-samsung-fhd-ea8076.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022 Junhao Xie <bigfoot@classfun.cn>
+ * Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree:
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/swab.h>
+#include <linux/backlight.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+struct fhd_ea8076_panel {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct regulator *supply;
+	struct gpio_desc *reset_gpio;
+	bool prepared;
+};
+
+static inline
+struct fhd_ea8076_panel *to_fhd_ea8076_panel(struct drm_panel *panel)
+{
+	return container_of(panel, struct fhd_ea8076_panel, panel);
+}
+
+#define dsi_dcs_write_seq(dsi, seq...) do {				\
+		static const u8 d[] = { seq };				\
+		int ret;						\
+		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
+		if (ret < 0)						\
+			return ret;					\
+	} while (0)
+
+static void fhd_ea8076_panel_reset(struct fhd_ea8076_panel *ctx)
+{
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(1000, 2000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(10000, 11000);
+}
+
+static int fhd_ea8076_panel_on(struct fhd_ea8076_panel *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
+		return ret;
+	}
+	usleep_range(10000, 11000);
+
+	dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
+
+	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set tear on: %d\n", ret);
+		return ret;
+	}
+
+	dsi_dcs_write_seq(dsi, 0xb7, 0x01, 0x4b);
+	dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
+
+	ret = mipi_dsi_dcs_set_page_address(dsi, 0x0000, 0x0923);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set page address: %d\n", ret);
+		return ret;
+	}
+
+	dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
+	dsi_dcs_write_seq(dsi, 0xb0, 0x07);
+	dsi_dcs_write_seq(dsi, 0xd9, 0x88, 0x2e);
+	dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
+	dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
+	dsi_dcs_write_seq(dsi, 0xfc, 0x5a, 0x5a);
+	dsi_dcs_write_seq(dsi, 0xe9,
+			  0x11, 0x55, 0xa6, 0x75, 0xa3, 0xb8, 0xbb, 0x2a, 0x00,
+			  0x1a, 0xb8);
+	dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
+	dsi_dcs_write_seq(dsi, 0xfc, 0xa5, 0xa5);
+	dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
+	dsi_dcs_write_seq(dsi, 0xb0, 0x09);
+	dsi_dcs_write_seq(dsi, 0xd8, 0x00);
+	dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
+	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
+	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
+	msleep(67);
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set display on: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int fhd_ea8076_panel_off(struct fhd_ea8076_panel *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_off(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set display off: %d\n", ret);
+		return ret;
+	}
+	usleep_range(17000, 18000);
+
+	dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
+	dsi_dcs_write_seq(dsi, 0xb0, 0x4f);
+	dsi_dcs_write_seq(dsi, 0xb9, 0x58);
+	dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
+	usleep_range(17000, 18000);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
+		return ret;
+	}
+	msleep(120);
+
+	return 0;
+}
+
+static int fhd_ea8076_panel_prepare(struct drm_panel *panel)
+{
+	struct fhd_ea8076_panel *ctx = to_fhd_ea8076_panel(panel);
+	struct device *dev = &ctx->dsi->dev;
+	int ret;
+
+	if (ctx->prepared)
+		return 0;
+
+	ret = regulator_enable(ctx->supply);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable regulator: %d\n", ret);
+		return ret;
+	}
+
+	fhd_ea8076_panel_reset(ctx);
+
+	ret = fhd_ea8076_panel_on(ctx);
+	if (ret < 0) {
+		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+		return ret;
+	}
+
+	ctx->prepared = true;
+	return 0;
+}
+
+static int fhd_ea8076_panel_unprepare(struct drm_panel *panel)
+{
+	struct fhd_ea8076_panel *ctx = to_fhd_ea8076_panel(panel);
+	struct device *dev = &ctx->dsi->dev;
+	int ret;
+
+	if (!ctx->prepared)
+		return 0;
+
+	ret = fhd_ea8076_panel_off(ctx);
+	if (ret < 0)
+		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
+
+	regulator_disable(ctx->supply);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+
+	ctx->prepared = false;
+	return 0;
+}
+
+static const struct drm_display_mode fhd_ea8076_panel_mode = {
+	.clock = (1080 + 64 + 20 + 64) * (2340 + 64 + 20 + 64) * 60 / 1000,
+	.hdisplay = 1080,
+	.hsync_start = 1080 + 64,
+	.hsync_end = 1080 + 64 + 20,
+	.htotal = 1080 + 64 + 20 + 64,
+	.vdisplay = 2340,
+	.vsync_start = 2340 + 64,
+	.vsync_end = 2340 + 64 + 20,
+	.vtotal = 2340 + 64 + 20 + 64,
+	.width_mm = 68,
+	.height_mm = 147,
+};
+
+static int fhd_ea8076_panel_get_modes(struct drm_panel *panel,
+					struct drm_connector *connector)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, &fhd_ea8076_panel_mode);
+	if (!mode)
+		return -ENOMEM;
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	connector->display_info.width_mm = mode->width_mm;
+	connector->display_info.height_mm = mode->height_mm;
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static const struct drm_panel_funcs fhd_ea8076_panel_funcs = {
+	.prepare = fhd_ea8076_panel_prepare,
+	.unprepare = fhd_ea8076_panel_unprepare,
+	.get_modes = fhd_ea8076_panel_get_modes,
+};
+
+static int fhd_ea8076_panel_bl_update_status(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	int err;
+	u16 brightness;
+
+	brightness = (u16)backlight_get_brightness(bl);
+	// This panel needs the high and low bytes swapped for the brightness value
+	brightness = __swab16(brightness);
+
+	err = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static const struct backlight_ops fhd_ea8076_panel_bl_ops = {
+	.update_status = fhd_ea8076_panel_bl_update_status,
+};
+
+static struct backlight_device *
+fhd_ea8076_panel_create_backlight(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	const struct backlight_properties props = {
+		.type = BACKLIGHT_PLATFORM,
+		.brightness = 1024,
+		.max_brightness = 2047,
+	};
+
+	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
+					      &fhd_ea8076_panel_bl_ops, &props);
+}
+
+static int fhd_ea8076_panel_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct fhd_ea8076_panel *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->supply = devm_regulator_get(dev, "vddio");
+	if (IS_ERR(ctx->supply))
+		return dev_err_probe(dev, PTR_ERR(ctx->supply),
+				     "Failed to get vddio regulator\n");
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get reset-gpios\n");
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM;
+
+	drm_panel_init(&ctx->panel, dev, &fhd_ea8076_panel_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+
+	ctx->panel.backlight = fhd_ea8076_panel_create_backlight(dsi);
+	if (IS_ERR(ctx->panel.backlight))
+		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
+				     "Failed to create backlight\n");
+
+	drm_panel_add(&ctx->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int fhd_ea8076_panel_remove(struct mipi_dsi_device *dsi)
+{
+	struct fhd_ea8076_panel *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&ctx->panel);
+
+	return 0;
+}
+
+static const struct of_device_id fhd_ea8076_panel_of_match[] = {
+	{ .compatible = "samsung,fhd-ea8076" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, fhd_ea8076_panel_of_match);
+
+static struct mipi_dsi_driver fhd_ea8076_panel_driver = {
+	.probe = fhd_ea8076_panel_probe,
+	.remove = fhd_ea8076_panel_remove,
+	.driver = {
+		.name = "panel-samsung-fhd-ea8076",
+		.of_match_table = fhd_ea8076_panel_of_match,
+	},
+};
+module_mipi_dsi_driver(fhd_ea8076_panel_driver);
+
+MODULE_AUTHOR("Junhao Xie <bigfoot@classfun.cn>");
+MODULE_DESCRIPTION("DRM driver for Samsung EA8076 FullHD AMOLED DSI Panel");
+MODULE_LICENSE("GPL v2");
-- 
2.30.2

