Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC69B4CB1DB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245370AbiCBWJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245109AbiCBWI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:08:57 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB703654BF;
        Wed,  2 Mar 2022 14:08:09 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8A9F1E000D;
        Wed,  2 Mar 2022 22:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646258888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdcL0mFvCKoJputia1RYoasYlEVwHtGSiUvmh9D3v1U=;
        b=GLlegKe3M82P52hB4AlOuDTdlchQIE7G92QeNuD4+xLxusGH7UT0EbVjUIteGbPuPwLs6n
        s79e66ngDhPhWj85JxO3YOYlX5X0vMyz0UPTdmArxjILwkpVR4nF9NqiBYZdJgl518ON4u
        a+BJPwMtnraaiufWAnhk0bHNU/v+Utwguns5wYPcP0u7mlXS83R3yGpM6pnFb0wcra9ghJ
        jO9CQNRJifCrM3I6IXPij4TanQ+CkMrqUnAKsfZwiYUO1uvO1YQi0bOzdjRCFcoUDBmagZ
        oZ6QXoo8D8JqfCFyLT7ICWhP4UtVRbJ+W8M2YJXqZq7TZTHvGsJTTmG41bYCvg==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 8/9] media: sunxi: Add support for the A83T MIPI CSI-2 controller
Date:   Wed,  2 Mar 2022 23:07:38 +0100
Message-Id: <20220302220739.144303-9-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302220739.144303-1-paul.kocialkowski@bootlin.com>
References: <20220302220739.144303-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A83T supports MIPI CSI-2 with a composite controller, covering
both the protocol logic and the D-PHY implementation. This controller
seems to be found on the A83T only and probably was abandoned since.

This implementation splits the protocol and D-PHY registers and
uses the PHY framework internally. The D-PHY is not registered as a
standalone PHY driver since it cannot be used with any other
controller.

There are a few notable points about the controller:
- The initialisation sequence involes writing specific magic init
  values that do not seem to make any particular sense given the
  concerned register fields;
- Interrupts appear to be hitting regardless of the interrupt mask
  registers, which can cause a serious flood when transmission errors
  occur.

Only 8-bit and 10-bit Bayer formats are currently supported.
While up to 4 internal channels to the CSI controller exist, only one
is currently supported by this implementation.

This work is based on the first version of the driver submitted by
Kévin L'hôpital, which was adapted to mainline from the Allwinner BSP.
This version integrates MIPI CSI-2 support as a standalone V4L2 subdev
instead of merging it in the sun6i-csi driver.

It was tested on a Banana Pi M3 board with an OV8865 sensor in a 4-lane
configuration.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/media/platform/sunxi/Kconfig          |   1 +
 drivers/media/platform/sunxi/Makefile         |   1 +
 .../sunxi/sun8i-a83t-mipi-csi2/Kconfig        |  11 +
 .../sunxi/sun8i-a83t-mipi-csi2/Makefile       |   4 +
 .../sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c    |  72 ++
 .../sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.h    |  39 +
 .../sun8i_a83t_mipi_csi2.c                    | 833 ++++++++++++++++++
 .../sun8i_a83t_mipi_csi2.h                    |  56 ++
 .../sun8i_a83t_mipi_csi2_reg.h                | 151 ++++
 9 files changed, 1168 insertions(+)
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Makefile
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.h
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.h
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2_reg.h

diff --git a/drivers/media/platform/sunxi/Kconfig b/drivers/media/platform/sunxi/Kconfig
index 9684e07454ad..db4c07be7e4c 100644
--- a/drivers/media/platform/sunxi/Kconfig
+++ b/drivers/media/platform/sunxi/Kconfig
@@ -3,3 +3,4 @@
 source "drivers/media/platform/sunxi/sun4i-csi/Kconfig"
 source "drivers/media/platform/sunxi/sun6i-csi/Kconfig"
 source "drivers/media/platform/sunxi/sun6i-mipi-csi2/Kconfig"
+source "drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig"
diff --git a/drivers/media/platform/sunxi/Makefile b/drivers/media/platform/sunxi/Makefile
index 887a7cae8fca..9aa01cb01883 100644
--- a/drivers/media/platform/sunxi/Makefile
+++ b/drivers/media/platform/sunxi/Makefile
@@ -3,5 +3,6 @@
 obj-y		+= sun4i-csi/
 obj-y		+= sun6i-csi/
 obj-y		+= sun6i-mipi-csi2/
+obj-y		+= sun8i-a83t-mipi-csi2/
 obj-y		+= sun8i-di/
 obj-y		+= sun8i-rotate/
diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
new file mode 100644
index 000000000000..60e7a9c41065
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_SUN8I_A83T_MIPI_CSI2
+	tristate "Allwinner A83T MIPI CSI-2 Controller and D-PHY Driver"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on PM && COMMON_CLK && VIDEO_V4L2
+	select REGMAP_MMIO
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	   Support for the Allwinner A83T MIPI CSI-2 Controller and D-PHY.
diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Makefile b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Makefile
new file mode 100644
index 000000000000..1427d15a879a
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+sun8i-a83t-mipi-csi2-y += sun8i_a83t_mipi_csi2.o sun8i_a83t_dphy.o
+
+obj-$(CONFIG_VIDEO_SUN8I_A83T_MIPI_CSI2) += sun8i-a83t-mipi-csi2.o
diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
new file mode 100644
index 000000000000..15cec91ee38c
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+
+#include "sun8i_a83t_dphy.h"
+#include "sun8i_a83t_mipi_csi2.h"
+
+static int sun8i_a83t_dphy_configure(struct phy *dphy,
+				     union phy_configure_opts *opts)
+{
+	return phy_mipi_dphy_config_validate(&opts->mipi_dphy);
+}
+
+static int sun8i_a83t_dphy_power_on(struct phy *dphy)
+{
+	struct sun8i_a83t_mipi_csi2_device *csi2_dev = phy_get_drvdata(dphy);
+	struct regmap *regmap = csi2_dev->regmap;
+
+	regmap_write(regmap, SUN8I_A83T_DPHY_CTRL_REG,
+		     SUN8I_A83T_DPHY_CTRL_RESET_N |
+		     SUN8I_A83T_DPHY_CTRL_SHUTDOWN_N);
+
+	regmap_write(regmap, SUN8I_A83T_DPHY_ANA0_REG,
+		     SUN8I_A83T_DPHY_ANA0_REXT_EN |
+		     SUN8I_A83T_DPHY_ANA0_RINT(2) |
+		     SUN8I_A83T_DPHY_ANA0_SNK(2));
+
+	return 0;
+};
+
+static int sun8i_a83t_dphy_power_off(struct phy *dphy)
+{
+	struct sun8i_a83t_mipi_csi2_device *csi2_dev = phy_get_drvdata(dphy);
+	struct regmap *regmap = csi2_dev->regmap;
+
+	regmap_write(regmap, SUN8I_A83T_DPHY_CTRL_REG, 0);
+
+	return 0;
+};
+
+static const struct phy_ops sun8i_a83t_dphy_ops = {
+	.configure	= sun8i_a83t_dphy_configure,
+	.power_on	= sun8i_a83t_dphy_power_on,
+	.power_off	= sun8i_a83t_dphy_power_off,
+};
+
+int sun8i_a83t_dphy_register(struct sun8i_a83t_mipi_csi2_device *csi2_dev)
+{
+	struct device *dev = csi2_dev->dev;
+	struct phy_provider *phy_provider;
+
+	csi2_dev->dphy = devm_phy_create(dev, NULL, &sun8i_a83t_dphy_ops);
+	if (IS_ERR(csi2_dev->dphy)) {
+		dev_err(dev, "failed to create D-PHY\n");
+		return PTR_ERR(csi2_dev->dphy);
+	}
+
+	phy_set_drvdata(csi2_dev->dphy, csi2_dev);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider)) {
+		dev_err(dev, "failed to register D-PHY provider\n");
+		return PTR_ERR(phy_provider);
+	}
+
+	return 0;
+}
diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.h b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.h
new file mode 100644
index 000000000000..18779060fd32
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2020 Kévin L'hôpital <kevin.lhopital@bootlin.com>
+ * Copyright 2020-2021 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#ifndef _SUN8I_A83T_DPHY_H_
+#define _SUN8I_A83T_DPHY_H_
+
+#include "sun8i_a83t_mipi_csi2.h"
+
+#define SUN8I_A83T_DPHY_CTRL_REG		0x10
+#define SUN8I_A83T_DPHY_CTRL_INIT_VALUE		0xb8df698e
+#define SUN8I_A83T_DPHY_CTRL_RESET_N		BIT(31)
+#define SUN8I_A83T_DPHY_CTRL_SHUTDOWN_N		BIT(15)
+#define SUN8I_A83T_DPHY_CTRL_DEBUG		BIT(8)
+#define SUN8I_A83T_DPHY_STATUS_REG		0x14
+#define SUN8I_A83T_DPHY_STATUS_CLK_STOP		BIT(10)
+#define SUN8I_A83T_DPHY_STATUS_CLK_ULPS		BIT(9)
+#define SUN8I_A83T_DPHY_STATUS_HSCLK		BIT(8)
+#define SUN8I_A83T_DPHY_STATUS_D3_STOP		BIT(7)
+#define SUN8I_A83T_DPHY_STATUS_D2_STOP		BIT(6)
+#define SUN8I_A83T_DPHY_STATUS_D1_STOP		BIT(5)
+#define SUN8I_A83T_DPHY_STATUS_D0_STOP		BIT(4)
+#define SUN8I_A83T_DPHY_STATUS_D3_ULPS		BIT(3)
+#define SUN8I_A83T_DPHY_STATUS_D2_ULPS		BIT(2)
+#define SUN8I_A83T_DPHY_STATUS_D1_ULPS		BIT(1)
+#define SUN8I_A83T_DPHY_STATUS_D0_ULPS		BIT(0)
+
+#define SUN8I_A83T_DPHY_ANA0_REG		0x30
+#define SUN8I_A83T_DPHY_ANA0_REXT_EN		BIT(31)
+#define SUN8I_A83T_DPHY_ANA0_REXT		BIT(30)
+#define SUN8I_A83T_DPHY_ANA0_RINT(v)		(((v) << 28) & GENMASK(29, 28))
+#define SUN8I_A83T_DPHY_ANA0_SNK(v)		(((v) << 20) & GENMASK(22, 20))
+
+int sun8i_a83t_dphy_register(struct sun8i_a83t_mipi_csi2_device *csi2_dev);
+
+#endif
diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
new file mode 100644
index 000000000000..4a6cab86f522
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
@@ -0,0 +1,833 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 Kévin L'hôpital <kevin.lhopital@bootlin.com>
+ * Copyright 2020-2021 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <media/mipi-csi2.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
+
+#include "sun8i_a83t_dphy.h"
+#include "sun8i_a83t_mipi_csi2.h"
+#include "sun8i_a83t_mipi_csi2_reg.h"
+
+/* Format */
+
+static const struct sun8i_a83t_mipi_csi2_format
+sun8i_a83t_mipi_csi2_formats[] = {
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR8_1X8,
+		.data_type	= MIPI_CSI2_DT_RAW8,
+		.bpp		= 8,
+	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG8_1X8,
+		.data_type	= MIPI_CSI2_DT_RAW8,
+		.bpp		= 8,
+	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG8_1X8,
+		.data_type	= MIPI_CSI2_DT_RAW8,
+		.bpp		= 8,
+	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB8_1X8,
+		.data_type	= MIPI_CSI2_DT_RAW8,
+		.bpp		= 8,
+	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
+		.data_type	= MIPI_CSI2_DT_RAW10,
+		.bpp		= 10,
+	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG10_1X10,
+		.data_type	= MIPI_CSI2_DT_RAW10,
+		.bpp		= 10,
+	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG10_1X10,
+		.data_type	= MIPI_CSI2_DT_RAW10,
+		.bpp		= 10,
+	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB10_1X10,
+		.data_type	= MIPI_CSI2_DT_RAW10,
+		.bpp		= 10,
+	},
+};
+
+static const struct sun8i_a83t_mipi_csi2_format *
+sun8i_a83t_mipi_csi2_format_find(u32 mbus_code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sun8i_a83t_mipi_csi2_formats); i++)
+		if (sun8i_a83t_mipi_csi2_formats[i].mbus_code == mbus_code)
+			return &sun8i_a83t_mipi_csi2_formats[i];
+
+	return NULL;
+}
+
+/* Controller */
+
+static void
+sun8i_a83t_mipi_csi2_init(struct sun8i_a83t_mipi_csi2_device *csi2_dev)
+{
+	struct regmap *regmap = csi2_dev->regmap;
+
+	/*
+	 * The Allwinner BSP sets various magic values on a bunch of registers.
+	 * This is apparently a necessary initialization process that will cause
+	 * the capture to fail with unsolicited interrupts hitting if skipped.
+	 *
+	 * Most of the registers are set to proper values later, except for the
+	 * two reserved registers. They are said to hold a "hardware lock"
+	 * value, without more information available.
+	 */
+
+	regmap_write(regmap, SUN8I_A83T_MIPI_CSI2_CTRL_REG, 0);
+	regmap_write(regmap, SUN8I_A83T_MIPI_CSI2_CTRL_REG,
+		     SUN8I_A83T_MIPI_CSI2_CTRL_INIT_VALUE);
+
+	regmap_write(regmap, SUN8I_A83T_MIPI_CSI2_RX_PKT_NUM_REG, 0);
+	regmap_write(regmap, SUN8I_A83T_MIPI_CSI2_RX_PKT_NUM_REG,
+		     SUN8I_A83T_MIPI_CSI2_RX_PKT_NUM_INIT_VALUE);
+
+	regmap_write(regmap, SUN8I_A83T_DPHY_CTRL_REG, 0);
+	regmap_write(regmap, SUN8I_A83T_DPHY_CTRL_REG,
+		     SUN8I_A83T_DPHY_CTRL_INIT_VALUE);
+
+	regmap_write(regmap, SUN8I_A83T_MIPI_CSI2_RSVD1_REG, 0);
+	regmap_write(regmap, SUN8I_A83T_MIPI_CSI2_RSVD1_REG,
+		     SUN8I_A83T_MIPI_CSI2_RSVD1_HW_LOCK_VALUE);
+
+	regmap_write(regmap, SUN8I_A83T_MIPI_CSI2_RSVD2_REG, 0);
+	regmap_write(regmap, SUN8I_A83T_MIPI_CSI2_RSVD2_REG,
+		     SUN8I_A83T_MIPI_CSI2_RSVD2_HW_LOCK_VALUE);
+
+	regmap_write(regmap, SUN8I_A83T_MIPI_CSI2_CFG_REG, 0);
+	regmap_write(regmap, SUN8I_A83T_MIPI_CSI2_CFG_REG,
+		     SUN8I_A83T_MIPI_CSI2_CFG_INIT_VALUE);
+}
+
+static void
+sun8i_a83t_mipi_csi2_enable(struct sun8i_a83t_mipi_csi2_device *csi2_dev)
+{
+	struct regmap *regmap = csi2_dev->regmap;
+
+	regmap_update_bits(regmap, SUN8I_A83T_MIPI_CSI2_CFG_REG,
+			   SUN8I_A83T_MIPI_CSI2_CFG_SYNC_EN,
+			   SUN8I_A83T_MIPI_CSI2_CFG_SYNC_EN);
+}
+
+static void
+sun8i_a83t_mipi_csi2_disable(struct sun8i_a83t_mipi_csi2_device *csi2_dev)
+{
+	struct regmap *regmap = csi2_dev->regmap;
+
+	regmap_update_bits(regmap, SUN8I_A83T_MIPI_CSI2_CFG_REG,
+			   SUN8I_A83T_MIPI_CSI2_CFG_SYNC_EN, 0);
+
+	regmap_write(regmap, SUN8I_A83T_MIPI_CSI2_CTRL_REG, 0);
+}
+
+static void
+sun8i_a83t_mipi_csi2_configure(struct sun8i_a83t_mipi_csi2_device *csi2_dev)
+{
+	struct regmap *regmap = csi2_dev->regmap;
+	unsigned int lanes_count =
+		csi2_dev->bridge.endpoint.bus.mipi_csi2.num_data_lanes;
+	struct v4l2_mbus_framefmt *mbus_format = &csi2_dev->bridge.mbus_format;
+	const struct sun8i_a83t_mipi_csi2_format *format;
+	struct device *dev = csi2_dev->dev;
+	u32 version = 0;
+
+	format = sun8i_a83t_mipi_csi2_format_find(mbus_format->code);
+	if (WARN_ON(!format))
+		return;
+
+	regmap_write(regmap, SUN8I_A83T_MIPI_CSI2_CTRL_REG,
+		     SUN8I_A83T_MIPI_CSI2_CTRL_RESET_N);
+
+	regmap_read(regmap, SUN8I_A83T_MIPI_CSI2_VERSION_REG, &version);
+
+	dev_dbg(dev, "A83T MIPI CSI-2 version: %04x\n", version);
+
+	regmap_write(regmap, SUN8I_A83T_MIPI_CSI2_CFG_REG,
+		     SUN8I_A83T_MIPI_CSI2_CFG_UNPKT_EN |
+		     SUN8I_A83T_MIPI_CSI2_CFG_SYNC_DLY_CYCLE(8) |
+		     SUN8I_A83T_MIPI_CSI2_CFG_N_CHANNEL(1) |
+		     SUN8I_A83T_MIPI_CSI2_CFG_N_LANE(lanes_count));
+
+	/*
+	 * Only a single virtual channel (index 0) is currently supported.
+	 * While the registers do mention multiple physical channels being
+	 * available (which can be configured to match a specific virtual
+	 * channel or data type), it's unclear whether channels > 0 are actually
+	 * connected and available and the reference source code only makes use
+	 * of channel 0.
+	 *
+	 * Using extra channels would also require matching channels to be
+	 * available on the CSI (and ISP) side, which is also unsure although
+	 * some CSI implementations are said to support multiple channels for
+	 * BT656 time-sharing.
+	 *
+	 * We still configure virtual channel numbers to ensure that virtual
+	 * channel 0 only goes to channel 0.
+	 */
+
+	regmap_write(regmap, SUN8I_A83T_MIPI_CSI2_VCDT0_REG,
+		     SUN8I_A83T_MIPI_CSI2_VCDT0_CH_VC(3, 3) |
+		     SUN8I_A83T_MIPI_CSI2_VCDT0_CH_VC(2, 2) |
+		     SUN8I_A83T_MIPI_CSI2_VCDT0_CH_VC(1, 1) |
+		     SUN8I_A83T_MIPI_CSI2_VCDT0_CH_VC(0, 0) |
+		     SUN8I_A83T_MIPI_CSI2_VCDT0_CH_DT(0, format->data_type));
+}
+
+/* V4L2 Subdev */
+
+static int sun8i_a83t_mipi_csi2_s_stream(struct v4l2_subdev *subdev, int on)
+{
+	struct sun8i_a83t_mipi_csi2_device *csi2_dev =
+		v4l2_get_subdevdata(subdev);
+	struct v4l2_subdev *source_subdev = csi2_dev->bridge.source_subdev;
+	union phy_configure_opts dphy_opts = { 0 };
+	struct phy_configure_opts_mipi_dphy *dphy_cfg = &dphy_opts.mipi_dphy;
+	struct v4l2_mbus_framefmt *mbus_format = &csi2_dev->bridge.mbus_format;
+	const struct sun8i_a83t_mipi_csi2_format *format;
+	struct phy *dphy = csi2_dev->dphy;
+	struct device *dev = csi2_dev->dev;
+	struct v4l2_ctrl *ctrl;
+	unsigned int lanes_count =
+		csi2_dev->bridge.endpoint.bus.mipi_csi2.num_data_lanes;
+	unsigned long pixel_rate;
+	/* Initialize to 0 to use both in disable label (ret != 0) and off. */
+	int ret = 0;
+
+	if (!source_subdev)
+		return -ENODEV;
+
+	if (!on) {
+		v4l2_subdev_call(source_subdev, video, s_stream, 0);
+		goto disable;
+	}
+
+	/* Runtime PM */
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	/* Sensor pixel rate */
+
+	ctrl = v4l2_ctrl_find(source_subdev->ctrl_handler, V4L2_CID_PIXEL_RATE);
+	if (!ctrl) {
+		dev_err(dev, "missing sensor pixel rate\n");
+		ret = -ENODEV;
+		goto error_pm;
+	}
+
+	pixel_rate = (unsigned long)v4l2_ctrl_g_ctrl_int64(ctrl);
+	if (!pixel_rate) {
+		dev_err(dev, "missing (zero) sensor pixel rate\n");
+		ret = -ENODEV;
+		goto error_pm;
+	}
+
+	/* D-PHY */
+
+	if (!lanes_count) {
+		dev_err(dev, "missing (zero) MIPI CSI-2 lanes count\n");
+		ret = -ENODEV;
+		goto error_pm;
+	}
+
+	format = sun8i_a83t_mipi_csi2_format_find(mbus_format->code);
+	if (WARN_ON(!format)) {
+		ret = -ENODEV;
+		goto error_pm;
+	}
+
+	phy_mipi_dphy_get_default_config(pixel_rate, format->bpp, lanes_count,
+					 dphy_cfg);
+
+	/*
+	 * Note that our hardware is using DDR, which is not taken in account by
+	 * phy_mipi_dphy_get_default_config when calculating hs_clk_rate from
+	 * the pixel rate, lanes count and bpp.
+	 *
+	 * The resulting clock rate is basically the symbol rate over the whole
+	 * link. The actual clock rate is calculated with division by two since
+	 * DDR samples both on rising and falling edges.
+	 */
+
+	dev_dbg(dev, "A83T MIPI CSI-2 config:\n");
+	dev_dbg(dev, "%ld pixels/s, %u bits/pixel, %u lanes, %lu Hz clock\n",
+		pixel_rate, format->bpp, lanes_count,
+		dphy_cfg->hs_clk_rate / 2);
+
+	ret = phy_reset(dphy);
+	if (ret) {
+		dev_err(dev, "failed to reset MIPI D-PHY\n");
+		goto error_pm;
+	}
+
+	ret = phy_configure(dphy, &dphy_opts);
+	if (ret) {
+		dev_err(dev, "failed to configure MIPI D-PHY\n");
+		goto error_pm;
+	}
+
+	/* Controller */
+
+	sun8i_a83t_mipi_csi2_configure(csi2_dev);
+	sun8i_a83t_mipi_csi2_enable(csi2_dev);
+
+	/* D-PHY */
+
+	ret = phy_power_on(dphy);
+	if (ret) {
+		dev_err(dev, "failed to power on MIPI D-PHY\n");
+		goto error_pm;
+	}
+
+	/* Source */
+
+	ret = v4l2_subdev_call(source_subdev, video, s_stream, 1);
+	if (ret && ret != -ENOIOCTLCMD)
+		goto disable;
+
+	return 0;
+
+disable:
+	phy_power_off(dphy);
+	sun8i_a83t_mipi_csi2_disable(csi2_dev);
+
+error_pm:
+	pm_runtime_put(dev);
+
+	return ret;
+}
+
+static const struct v4l2_subdev_video_ops
+sun8i_a83t_mipi_csi2_video_ops = {
+	.s_stream	= sun8i_a83t_mipi_csi2_s_stream,
+};
+
+static void
+sun8i_a83t_mipi_csi2_mbus_format_prepare(struct v4l2_mbus_framefmt *mbus_format)
+{
+	if (!sun8i_a83t_mipi_csi2_format_find(mbus_format->code))
+		mbus_format->code = sun8i_a83t_mipi_csi2_formats[0].mbus_code;
+
+	mbus_format->field = V4L2_FIELD_NONE;
+	mbus_format->colorspace = V4L2_COLORSPACE_RAW;
+	mbus_format->quantization = V4L2_QUANTIZATION_DEFAULT;
+	mbus_format->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+}
+
+static int sun8i_a83t_mipi_csi2_init_cfg(struct v4l2_subdev *subdev,
+					 struct v4l2_subdev_state *state)
+{
+	struct sun8i_a83t_mipi_csi2_device *csi2_dev =
+		v4l2_get_subdevdata(subdev);
+	unsigned int pad = SUN8I_A83T_MIPI_CSI2_PAD_SINK;
+	struct v4l2_mbus_framefmt *mbus_format =
+		v4l2_subdev_get_try_format(subdev, state, pad);
+	struct mutex *lock = &csi2_dev->bridge.lock;
+
+	mutex_lock(lock);
+
+	mbus_format->code = sun8i_a83t_mipi_csi2_formats[0].mbus_code;
+	mbus_format->width = 640;
+	mbus_format->height = 480;
+
+	sun8i_a83t_mipi_csi2_mbus_format_prepare(mbus_format);
+
+	mutex_unlock(lock);
+
+	return 0;
+}
+
+static int
+sun8i_a83t_mipi_csi2_enum_mbus_code(struct v4l2_subdev *subdev,
+				    struct v4l2_subdev_state *state,
+				    struct v4l2_subdev_mbus_code_enum *code_enum)
+{
+	if (code_enum->index >= ARRAY_SIZE(sun8i_a83t_mipi_csi2_formats))
+		return -EINVAL;
+
+	code_enum->code =
+		sun8i_a83t_mipi_csi2_formats[code_enum->index].mbus_code;
+
+	return 0;
+}
+
+static int sun8i_a83t_mipi_csi2_get_fmt(struct v4l2_subdev *subdev,
+					struct v4l2_subdev_state *state,
+					struct v4l2_subdev_format *format)
+{
+	struct sun8i_a83t_mipi_csi2_device *csi2_dev =
+		v4l2_get_subdevdata(subdev);
+	struct v4l2_mbus_framefmt *mbus_format = &format->format;
+	struct mutex *lock = &csi2_dev->bridge.lock;
+
+	mutex_lock(lock);
+
+	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
+		*mbus_format = *v4l2_subdev_get_try_format(subdev, state,
+							   format->pad);
+	else
+		*mbus_format = csi2_dev->bridge.mbus_format;
+
+	mutex_unlock(lock);
+
+	return 0;
+}
+
+static int sun8i_a83t_mipi_csi2_set_fmt(struct v4l2_subdev *subdev,
+					struct v4l2_subdev_state *state,
+					struct v4l2_subdev_format *format)
+{
+	struct sun8i_a83t_mipi_csi2_device *csi2_dev =
+		v4l2_get_subdevdata(subdev);
+	struct v4l2_mbus_framefmt *mbus_format = &format->format;
+	struct mutex *lock = &csi2_dev->bridge.lock;
+
+	mutex_lock(lock);
+
+	sun8i_a83t_mipi_csi2_mbus_format_prepare(mbus_format);
+
+	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
+		*v4l2_subdev_get_try_format(subdev, state, format->pad) =
+			*mbus_format;
+	else
+		csi2_dev->bridge.mbus_format = *mbus_format;
+
+	mutex_unlock(lock);
+
+	return 0;
+}
+
+static const struct v4l2_subdev_pad_ops sun8i_a83t_mipi_csi2_pad_ops = {
+	.init_cfg	= sun8i_a83t_mipi_csi2_init_cfg,
+	.enum_mbus_code	= sun8i_a83t_mipi_csi2_enum_mbus_code,
+	.get_fmt	= sun8i_a83t_mipi_csi2_get_fmt,
+	.set_fmt	= sun8i_a83t_mipi_csi2_set_fmt,
+};
+
+static const struct v4l2_subdev_ops sun8i_a83t_mipi_csi2_subdev_ops = {
+	.video	= &sun8i_a83t_mipi_csi2_video_ops,
+	.pad	= &sun8i_a83t_mipi_csi2_pad_ops,
+};
+
+/* Media Entity */
+
+static const struct media_entity_operations sun8i_a83t_mipi_csi2_entity_ops = {
+	.link_validate	= v4l2_subdev_link_validate,
+};
+
+/* V4L2 Async */
+
+static int
+sun8i_a83t_mipi_csi2_notifier_bound(struct v4l2_async_notifier *notifier,
+				    struct v4l2_subdev *remote_subdev,
+				    struct v4l2_async_subdev *async_subdev)
+{
+	struct v4l2_subdev *subdev = notifier->sd;
+	struct sun8i_a83t_mipi_csi2_device *csi2_dev =
+		container_of(notifier, struct sun8i_a83t_mipi_csi2_device,
+			     bridge.notifier);
+	struct media_entity *sink_entity = &subdev->entity;
+	struct media_entity *source_entity = &remote_subdev->entity;
+	struct device *dev = csi2_dev->dev;
+	int sink_pad_index = 0;
+	int source_pad_index;
+	int ret;
+
+	ret = media_entity_get_fwnode_pad(source_entity, remote_subdev->fwnode,
+					  MEDIA_PAD_FL_SOURCE);
+	if (ret < 0) {
+		dev_err(dev, "missing source pad in external entity %s\n",
+			source_entity->name);
+		return -EINVAL;
+	}
+
+	source_pad_index = ret;
+
+	dev_dbg(dev, "creating %s:%u -> %s:%u link\n", source_entity->name,
+		source_pad_index, sink_entity->name, sink_pad_index);
+
+	ret = media_create_pad_link(source_entity, source_pad_index,
+				    sink_entity, sink_pad_index,
+				    MEDIA_LNK_FL_ENABLED |
+				    MEDIA_LNK_FL_IMMUTABLE);
+	if (ret) {
+		dev_err(dev, "failed to create %s:%u -> %s:%u link\n",
+			source_entity->name, source_pad_index,
+			sink_entity->name, sink_pad_index);
+		return ret;
+	}
+
+	csi2_dev->bridge.source_subdev = remote_subdev;
+
+	return 0;
+}
+
+static const struct v4l2_async_notifier_operations
+sun8i_a83t_mipi_csi2_notifier_ops = {
+	.bound	= sun8i_a83t_mipi_csi2_notifier_bound,
+};
+
+/* Bridge */
+
+static int
+sun8i_a83t_mipi_csi2_bridge_source_setup(struct sun8i_a83t_mipi_csi2_device *csi2_dev)
+{
+	struct v4l2_async_notifier *notifier = &csi2_dev->bridge.notifier;
+	struct v4l2_fwnode_endpoint *endpoint = &csi2_dev->bridge.endpoint;
+	struct v4l2_async_subdev *subdev_async;
+	struct fwnode_handle *handle;
+	struct device *dev = csi2_dev->dev;
+	int ret;
+
+	handle = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
+						 FWNODE_GRAPH_ENDPOINT_NEXT);
+	if (!handle)
+		return -ENODEV;
+
+	endpoint->bus_type = V4L2_MBUS_CSI2_DPHY;
+
+	ret = v4l2_fwnode_endpoint_parse(handle, endpoint);
+	if (ret)
+		goto complete;
+
+	subdev_async = v4l2_async_nf_add_fwnode_remote(notifier, handle,
+		struct v4l2_async_subdev);
+	if (IS_ERR(subdev_async))
+		ret = PTR_ERR(subdev_async);
+
+complete:
+	fwnode_handle_put(handle);
+
+	return ret;
+}
+
+static int
+sun8i_a83t_mipi_csi2_bridge_setup(struct sun8i_a83t_mipi_csi2_device *csi2_dev)
+{
+	struct sun8i_a83t_mipi_csi2_bridge *bridge = &csi2_dev->bridge;
+	struct v4l2_subdev *subdev = &bridge->subdev;
+	struct v4l2_async_notifier *notifier = &bridge->notifier;
+	struct media_pad *pads = bridge->pads;
+	struct device *dev = csi2_dev->dev;
+	int ret;
+
+	mutex_init(&bridge->lock);
+
+	/* V4L2 Subdev */
+
+	v4l2_subdev_init(subdev, &sun8i_a83t_mipi_csi2_subdev_ops);
+	strscpy(subdev->name, SUN8I_A83T_MIPI_CSI2_NAME, sizeof(subdev->name));
+	subdev->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	subdev->owner = THIS_MODULE;
+	subdev->dev = dev;
+
+	v4l2_set_subdevdata(subdev, csi2_dev);
+
+	/* Media Entity */
+
+	subdev->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
+	subdev->entity.ops = &sun8i_a83t_mipi_csi2_entity_ops;
+
+	/* Media Pads */
+
+	pads[SUN8I_A83T_MIPI_CSI2_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+	pads[SUN8I_A83T_MIPI_CSI2_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
+
+	ret = media_entity_pads_init(&subdev->entity,
+				     SUN8I_A83T_MIPI_CSI2_PAD_COUNT, pads);
+	if (ret)
+		return ret;
+
+	/* V4L2 Async */
+
+	v4l2_async_nf_init(notifier);
+	notifier->ops = &sun8i_a83t_mipi_csi2_notifier_ops;
+
+	ret = sun8i_a83t_mipi_csi2_bridge_source_setup(csi2_dev);
+	if (ret)
+		goto error_v4l2_notifier_cleanup;
+
+	ret = v4l2_async_subdev_nf_register(subdev, notifier);
+	if (ret < 0)
+		goto error_v4l2_notifier_cleanup;
+
+	/* V4L2 Subdev */
+
+	ret = v4l2_async_register_subdev(subdev);
+	if (ret < 0)
+		goto error_v4l2_notifier_unregister;
+
+	return 0;
+
+error_v4l2_notifier_unregister:
+	v4l2_async_nf_unregister(notifier);
+
+error_v4l2_notifier_cleanup:
+	v4l2_async_nf_cleanup(notifier);
+
+	media_entity_cleanup(&subdev->entity);
+
+	return ret;
+}
+
+static void
+sun8i_a83t_mipi_csi2_bridge_cleanup(struct sun8i_a83t_mipi_csi2_device *csi2_dev)
+{
+	struct v4l2_subdev *subdev = &csi2_dev->bridge.subdev;
+	struct v4l2_async_notifier *notifier = &csi2_dev->bridge.notifier;
+
+	v4l2_async_unregister_subdev(subdev);
+	v4l2_async_nf_unregister(notifier);
+	v4l2_async_nf_cleanup(notifier);
+	media_entity_cleanup(&subdev->entity);
+}
+
+/* Platform */
+
+static int sun8i_a83t_mipi_csi2_suspend(struct device *dev)
+{
+	struct sun8i_a83t_mipi_csi2_device *csi2_dev = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(csi2_dev->clk_misc);
+	clk_disable_unprepare(csi2_dev->clk_mipi);
+	clk_disable_unprepare(csi2_dev->clk_mod);
+	clk_disable_unprepare(csi2_dev->clk_bus);
+	reset_control_assert(csi2_dev->reset);
+
+	return 0;
+}
+
+static int sun8i_a83t_mipi_csi2_resume(struct device *dev)
+{
+	struct sun8i_a83t_mipi_csi2_device *csi2_dev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(csi2_dev->reset);
+	if (ret) {
+		dev_err(dev, "failed to deassert reset\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(csi2_dev->clk_bus);
+	if (ret) {
+		dev_err(dev, "failed to enable bus clock\n");
+		goto error_reset;
+	}
+
+	ret = clk_prepare_enable(csi2_dev->clk_mod);
+	if (ret) {
+		dev_err(dev, "failed to enable module clock\n");
+		goto error_clk_bus;
+	}
+
+	ret = clk_prepare_enable(csi2_dev->clk_mipi);
+	if (ret) {
+		dev_err(dev, "failed to enable MIPI clock\n");
+		goto error_clk_mod;
+	}
+
+	ret = clk_prepare_enable(csi2_dev->clk_misc);
+	if (ret) {
+		dev_err(dev, "failed to enable CSI misc clock\n");
+		goto error_clk_mipi;
+	}
+
+	sun8i_a83t_mipi_csi2_init(csi2_dev);
+
+	return 0;
+
+error_clk_mipi:
+	clk_disable_unprepare(csi2_dev->clk_mipi);
+
+error_clk_mod:
+	clk_disable_unprepare(csi2_dev->clk_mod);
+
+error_clk_bus:
+	clk_disable_unprepare(csi2_dev->clk_bus);
+
+error_reset:
+	reset_control_assert(csi2_dev->reset);
+
+	return ret;
+}
+
+static const struct dev_pm_ops sun8i_a83t_mipi_csi2_pm_ops = {
+	SET_RUNTIME_PM_OPS(sun8i_a83t_mipi_csi2_suspend,
+			   sun8i_a83t_mipi_csi2_resume, NULL)
+};
+
+static const struct regmap_config sun8i_a83t_mipi_csi2_regmap_config = {
+	.reg_bits       = 32,
+	.reg_stride     = 4,
+	.val_bits       = 32,
+	.max_register	= 0x120,
+};
+
+static int
+sun8i_a83t_mipi_csi2_resources_setup(struct sun8i_a83t_mipi_csi2_device *csi2_dev,
+				     struct platform_device *platform_dev)
+{
+	struct device *dev = csi2_dev->dev;
+	struct resource *res;
+	void __iomem *io_base;
+	int ret;
+
+	/* Registers */
+
+	res = platform_get_resource(platform_dev, IORESOURCE_MEM, 0);
+	io_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
+
+	csi2_dev->regmap =
+		devm_regmap_init_mmio(dev, io_base,
+				      &sun8i_a83t_mipi_csi2_regmap_config);
+	if (IS_ERR(csi2_dev->regmap)) {
+		dev_err(dev, "failed to init register map\n");
+		return PTR_ERR(csi2_dev->regmap);
+	}
+
+	/* Clocks */
+
+	csi2_dev->clk_bus = devm_clk_get(dev, "bus");
+	if (IS_ERR(csi2_dev->clk_bus)) {
+		dev_err(dev, "failed to acquire bus clock\n");
+		return PTR_ERR(csi2_dev->clk_bus);
+	}
+
+	csi2_dev->clk_mod = devm_clk_get(dev, "mod");
+	if (IS_ERR(csi2_dev->clk_mod)) {
+		dev_err(dev, "failed to acquire mod clock\n");
+		return PTR_ERR(csi2_dev->clk_mod);
+	}
+
+	ret = clk_set_rate_exclusive(csi2_dev->clk_mod, 297000000);
+	if (ret) {
+		dev_err(dev, "failed to set mod clock rate\n");
+		return ret;
+	}
+
+	csi2_dev->clk_mipi = devm_clk_get(dev, "mipi");
+	if (IS_ERR(csi2_dev->clk_mipi)) {
+		dev_err(dev, "failed to acquire mipi clock\n");
+		return PTR_ERR(csi2_dev->clk_mipi);
+	}
+
+	csi2_dev->clk_misc = devm_clk_get(dev, "misc");
+	if (IS_ERR(csi2_dev->clk_misc)) {
+		dev_err(dev, "failed to acquire misc clock\n");
+		return PTR_ERR(csi2_dev->clk_misc);
+	}
+
+	/* Reset */
+
+	csi2_dev->reset = devm_reset_control_get_shared(dev, NULL);
+	if (IS_ERR(csi2_dev->reset)) {
+		dev_err(dev, "failed to get reset controller\n");
+		return PTR_ERR(csi2_dev->reset);
+	}
+
+	/* D-PHY */
+
+	ret = sun8i_a83t_dphy_register(csi2_dev);
+	if (ret) {
+		dev_err(dev, "failed to initialize MIPI D-PHY\n");
+		return ret;
+	}
+
+	/* Runtime PM */
+
+	pm_runtime_enable(dev);
+	pm_runtime_set_suspended(dev);
+
+	return 0;
+}
+
+static void
+sun8i_a83t_mipi_csi2_resources_cleanup(struct sun8i_a83t_mipi_csi2_device *csi2_dev)
+{
+	pm_runtime_disable(csi2_dev->dev);
+	phy_exit(csi2_dev->dphy);
+	clk_rate_exclusive_put(csi2_dev->clk_mod);
+}
+
+static int sun8i_a83t_mipi_csi2_probe(struct platform_device *platform_dev)
+{
+	struct sun8i_a83t_mipi_csi2_device *csi2_dev;
+	struct device *dev = &platform_dev->dev;
+	int ret;
+
+	csi2_dev = devm_kzalloc(dev, sizeof(*csi2_dev), GFP_KERNEL);
+	if (!csi2_dev)
+		return -ENOMEM;
+
+	csi2_dev->dev = dev;
+	platform_set_drvdata(platform_dev, csi2_dev);
+
+	ret = sun8i_a83t_mipi_csi2_resources_setup(csi2_dev, platform_dev);
+	if (ret)
+		return ret;
+
+	ret = sun8i_a83t_mipi_csi2_bridge_setup(csi2_dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int sun8i_a83t_mipi_csi2_remove(struct platform_device *platform_dev)
+{
+	struct sun8i_a83t_mipi_csi2_device *csi2_dev =
+		platform_get_drvdata(platform_dev);
+
+	sun8i_a83t_mipi_csi2_bridge_cleanup(csi2_dev);
+	sun8i_a83t_mipi_csi2_resources_cleanup(csi2_dev);
+
+	return 0;
+}
+
+static const struct of_device_id sun8i_a83t_mipi_csi2_of_match[] = {
+	{ .compatible = "allwinner,sun8i-a83t-mipi-csi2" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sun8i_a83t_mipi_csi2_of_match);
+
+static struct platform_driver sun8i_a83t_mipi_csi2_platform_driver = {
+	.probe = sun8i_a83t_mipi_csi2_probe,
+	.remove = sun8i_a83t_mipi_csi2_remove,
+	.driver = {
+		.name = SUN8I_A83T_MIPI_CSI2_NAME,
+		.of_match_table = of_match_ptr(sun8i_a83t_mipi_csi2_of_match),
+		.pm = &sun8i_a83t_mipi_csi2_pm_ops,
+	},
+};
+module_platform_driver(sun8i_a83t_mipi_csi2_platform_driver);
+
+MODULE_DESCRIPTION("Allwinner A83T MIPI CSI-2 and D-PHY Controller Driver");
+MODULE_AUTHOR("Paul Kocialkowski <paul.kocialkowski@bootlin.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.h b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.h
new file mode 100644
index 000000000000..fc817981ab83
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2020 Kévin L'hôpital <kevin.lhopital@bootlin.com>
+ * Copyright 2020 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#ifndef _SUN8I_A83T_MIPI_CSI2_H_
+#define _SUN8I_A83T_MIPI_CSI2_H_
+
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
+
+#define SUN8I_A83T_MIPI_CSI2_NAME	"sun8i-a83t-mipi-csi2"
+
+enum sun8i_a83t_mipi_csi2_pad {
+	SUN8I_A83T_MIPI_CSI2_PAD_SINK	= 0,
+	SUN8I_A83T_MIPI_CSI2_PAD_SOURCE	= 1,
+	SUN8I_A83T_MIPI_CSI2_PAD_COUNT	= 2,
+};
+
+struct sun8i_a83t_mipi_csi2_format {
+	u32	mbus_code;
+	u8	data_type;
+	u32	bpp;
+};
+
+struct sun8i_a83t_mipi_csi2_bridge {
+	struct v4l2_subdev		subdev;
+	struct media_pad		pads[SUN8I_A83T_MIPI_CSI2_PAD_COUNT];
+	struct v4l2_fwnode_endpoint	endpoint;
+	struct v4l2_async_notifier	notifier;
+	struct v4l2_mbus_framefmt	mbus_format;
+	struct mutex			lock; /* Mbus format lock. */
+
+	struct v4l2_subdev		*source_subdev;
+};
+
+struct sun8i_a83t_mipi_csi2_device {
+	struct device				*dev;
+
+	struct regmap				*regmap;
+	struct clk				*clk_bus;
+	struct clk				*clk_mod;
+	struct clk				*clk_mipi;
+	struct clk				*clk_misc;
+	struct reset_control			*reset;
+	struct phy				*dphy;
+
+	struct sun8i_a83t_mipi_csi2_bridge	bridge;
+};
+
+#endif
diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2_reg.h b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2_reg.h
new file mode 100644
index 000000000000..c828ad19e3d5
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2_reg.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2020 Kévin L'hôpital <kevin.lhopital@bootlin.com>
+ * Copyright 2020-2021 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#ifndef _SUN8I_A83T_MIPI_CSI2_REG_H_
+#define _SUN8I_A83T_MIPI_CSI2_REG_H_
+
+#define SUN8I_A83T_MIPI_CSI2_VERSION_REG			0x0
+#define SUN8I_A83T_MIPI_CSI2_CTRL_REG				0x4
+#define SUN8I_A83T_MIPI_CSI2_CTRL_INIT_VALUE			0xb8c39bec
+#define SUN8I_A83T_MIPI_CSI2_CTRL_RESET_N			BIT(31)
+#define SUN8I_A83T_MIPI_CSI2_RX_PKT_NUM_REG			0x8
+#define SUN8I_A83T_MIPI_CSI2_RX_PKT_NUM_INIT_VALUE		0xb8d257f8
+#define SUN8I_A83T_MIPI_CSI2_RSVD0_REG				0xc
+
+#define SUN8I_A83T_MIPI_CSI2_RSVD1_REG				0x18
+#define SUN8I_A83T_MIPI_CSI2_RSVD1_HW_LOCK_VALUE		0xb8c8a30c
+#define SUN8I_A83T_MIPI_CSI2_RSVD2_REG				0x1c
+#define SUN8I_A83T_MIPI_CSI2_RSVD2_HW_LOCK_VALUE		0xb8df8ad7
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_REG			0x20
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_ECC_ERR_DBL		BIT(28)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_LINE_CKSM_ERR_VC3		BIT(27)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_LINE_CKSM_ERR_VC2		BIT(26)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_LINE_CKSM_ERR_VC1		BIT(25)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_LINE_CKSM_ERR_VC0		BIT(24)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_LINE_SEQ_ERR_DT3		BIT(23)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_LINE_SEQ_ERR_DT2		BIT(22)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_LINE_SEQ_ERR_DT1		BIT(21)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_LINE_SEQ_ERR_DT0		BIT(20)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_LS_LE_ERR_DT3		BIT(19)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_LS_LE_ERR_DT2		BIT(18)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_LS_LE_ERR_DT1		BIT(17)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_LS_LE_ERR_DT0		BIT(16)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_CRC_ERR_VC3		BIT(15)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_CRC_ERR_VC2		BIT(14)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_CRC_ERR_VC1		BIT(13)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_CRC_ERR_VC0		BIT(12)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_FRM_SEQ_ERR_VC3		BIT(11)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_FRM_SEQ_ERR_VC2		BIT(10)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_FRM_SEQ_ERR_VC1		BIT(9)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_FRM_SEQ_ERR_VC0		BIT(8)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_FS_FE_ERR_VC3		BIT(7)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_FS_FE_ERR_VC2		BIT(6)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_FS_FE_ERR_VC1		BIT(5)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_FS_FE_ERR_VC0		BIT(4)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_SOT_SYNC_ERR_3		BIT(3)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_SOT_SYNC_ERR_2		BIT(2)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_SOT_SYNC_ERR_1		BIT(1)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA0_SOT_SYNC_ERR_0		BIT(0)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_REG			0x24
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_LINE_SEQ_ERR_DT7		BIT(23)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_LINE_SEQ_ERR_DT6		BIT(22)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_LINE_SEQ_ERR_DT5		BIT(21)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_LINE_SEQ_ERR_DT4		BIT(20)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_LS_LE_ERR_DT7		BIT(19)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_LS_LE_ERR_DT6		BIT(18)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_LS_LE_ERR_DT5		BIT(17)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_LS_LE_ERR_DT4		BIT(16)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_DT_ERR_VC3		BIT(15)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_DT_ERR_VC2		BIT(14)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_DT_ERR_VC1		BIT(13)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_DT_ERR_VC0		BIT(12)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_ECC_ERR1_VC3		BIT(11)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_ECC_ERR1_VC2		BIT(10)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_ECC_ERR1_VC1		BIT(9)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_ECC_ERR1_VC0		BIT(8)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_SOT_ERR_3			BIT(7)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_SOT_ERR_2			BIT(6)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_SOT_ERR_1			BIT(5)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_SOT_ERR_0			BIT(4)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_ESC_ENTRY_ERR_3		BIT(3)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_ESC_ENTRY_ERR_2		BIT(2)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_ESC_ENTRY_ERR_1		BIT(1)
+#define SUN8I_A83T_MIPI_CSI2_INT_STA1_ESC_ENTRY_ERR_0		BIT(0)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_REG			0x28
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_ECC_ERR_DBL		BIT(28)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_CKSM_ERR_VC3		BIT(27)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_CKSM_ERR_VC2		BIT(26)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_CKSM_ERR_VC1		BIT(25)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_CKSM_ERR_VC0		BIT(24)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_LINE_SEQ_ERR_DT3		BIT(23)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_LINE_SEQ_ERR_DT2		BIT(22)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_LINE_SEQ_ERR_DT1		BIT(21)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_LINE_SEQ_ERR_DT0		BIT(20)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_LS_LE_ERR_DT3		BIT(19)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_LS_LE_ERR_DT2		BIT(18)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_LS_LE_ERR_DT1		BIT(17)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_LS_LE_ERR_DT0		BIT(16)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_CRC_ERR_VC3		BIT(15)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_CRC_ERR_VC2		BIT(14)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_CRC_ERR_VC1		BIT(13)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_CRC_ERR_VC0		BIT(12)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_FRM_SEQ_ERR_VC3		BIT(11)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_FRM_SEQ_ERR_VC2		BIT(10)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_FRM_SEQ_ERR_VC1		BIT(9)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_FRM_SEQ_ERR_VC0		BIT(8)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_FS_FE_ERR_VC3		BIT(7)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_FS_FE_ERR_VC2		BIT(6)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_FS_FE_ERR_VC1		BIT(5)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_FS_FE_ERR_VC0		BIT(4)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_SOT_SYNC_ERR_3		BIT(3)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_SOT_SYNC_ERR_2		BIT(2)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_SOT_SYNC_ERR_1		BIT(1)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK0_SOT_SYNC_ERR_0		BIT(0)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_REG			0x2c
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_DT_ERR_VC3		BIT(15)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_DT_ERR_VC2		BIT(14)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_DT_ERR_VC1		BIT(13)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_DT_ERR_VC0		BIT(12)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_ECC_ERR1_VC3		BIT(11)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_ECC_ERR1_VC2		BIT(10)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_ECC_ERR1_VC1		BIT(9)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_ECC_ERR1_VC0		BIT(8)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_SOT_ERR_3			BIT(7)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_SOT_ERR_2			BIT(6)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_SOT_ERR_1			BIT(5)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_SOT_ERR_0			BIT(4)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_ESC_ENTRY_ERR_3		BIT(3)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_ESC_ENTRY_ERR_2		BIT(2)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_ESC_ENTRY_ERR_1		BIT(1)
+#define SUN8I_A83T_MIPI_CSI2_INT_MSK1_ESC_ENTRY_ERR_0		BIT(0)
+
+#define SUN8I_A83T_MIPI_CSI2_CFG_REG				0x100
+#define SUN8I_A83T_MIPI_CSI2_CFG_INIT_VALUE			0xb8c64f24
+#define SUN8I_A83T_MIPI_CSI2_CFG_SYNC_EN			BIT(31)
+#define SUN8I_A83T_MIPI_CSI2_CFG_BYPASS_ECC_EN			BIT(29)
+#define SUN8I_A83T_MIPI_CSI2_CFG_UNPKT_EN			BIT(28)
+#define SUN8I_A83T_MIPI_CSI2_CFG_NONE_UNPKT_RX_MODE		BIT(27)
+#define SUN8I_A83T_MIPI_CSI2_CFG_YC_SWAB			BIT(26)
+#define SUN8I_A83T_MIPI_CSI2_CFG_N_BYTE				BIT(24)
+#define SUN8I_A83T_MIPI_CSI2_CFG_SYNC_DLY_CYCLE(v)		(((v) << 18) & \
+								 GENMASK(22, 18))
+#define SUN8I_A83T_MIPI_CSI2_CFG_N_CHANNEL(v)			((((v) - 1) << 16) & \
+								 GENMASK(17, 16))
+#define SUN8I_A83T_MIPI_CSI2_CFG_N_LANE(v)			((((v) - 1) << 4) & \
+								 GENMASK(5, 4))
+#define SUN8I_A83T_MIPI_CSI2_VCDT0_REG				0x104
+#define SUN8I_A83T_MIPI_CSI2_VCDT0_CH_VC(ch, vc)		(((vc) & GENMASK(1, 0)) << \
+								 ((ch) * 8 + 6))
+#define SUN8I_A83T_MIPI_CSI2_VCDT0_CH_DT(ch, t)			(((t) & GENMASK(5, 0)) << \
+								 ((ch) * 8))
+#define SUN8I_A83T_MIPI_CSI2_VCDT1_REG				0x108
+#define SUN8I_A83T_MIPI_CSI2_VCDT1_CH_VC(ch, vc)		(((vc) & GENMASK(1, 0)) << \
+								 (((ch) - 4) * 8 + 6))
+#define SUN8I_A83T_MIPI_CSI2_VCDT1_CH_DT(ch, t)			(((t) & GENMASK(5, 0)) << \
+								 (((ch) - 4) * 8))
+
+#endif
-- 
2.35.1

