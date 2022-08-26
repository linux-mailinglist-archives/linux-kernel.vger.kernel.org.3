Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D45A2F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345365AbiHZSq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344227AbiHZSpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:45:54 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5017EEC70;
        Fri, 26 Aug 2022 11:42:16 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5930D40002;
        Fri, 26 Aug 2022 18:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661539328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5bUAIvf8ZZnmlKKdqj943qT8lEIX/gFbjtvtgBIYr8=;
        b=Cyh6sgahftocwK0WiBEdTAVRoCPusPBNz5/zuuafhm+TmTnZd5KM6VI7Sot+ydZF/XMRB7
        pHedy911CbIiaWI4febQFZ89Yld+r2QMsmEl9GLWO32nDvlWvt5M0SAsCSO6fz94l4B7PD
        V7Avnn9raDqavlUK4zj6eSQWvDie7hvdqD1jmsJsu/24lYeL8OpfIC2gtOy2ZpctPuPpWq
        Rhy7OAu/ugogh8H1R0r/wkkiI0sc1jIV7GwcM+FiRCsJmYDEgCMcPhHM5IxrCd3qKWefDl
        R7eaKEPiJlRNQOX4QaviI9XZe+dOsS4FuzVJ9w6Hh2nQcAhltqcEfBAKK161TA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v6 3/6] staging: media: Add support for the Allwinner A31 ISP
Date:   Fri, 26 Aug 2022 20:41:41 +0200
Message-Id: <20220826184144.605605-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826184144.605605-1-paul.kocialkowski@bootlin.com>
References: <20220826184144.605605-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Allwinner platforms come with an Image Signal Processor, which
supports various features in order to enhance and transform data
received by image sensors into good-looking pictures. In most cases,
the data is raw bayer, which gets internally converted to RGB and
finally YUV, which is what the hardware produces.

This driver supports ISPs that are similar to the A31 ISP, which was
the first standalone ISP found in Allwinner platforms. Simpler ISP
blocks were found in the A10 and A20, where they are tied to a CSI
controller. Newer generations of Allwinner SoCs (starting with the
H6, H616, etc) come with a new camera subsystem and revised ISP.
Even though these previous and next-generation ISPs are somewhat
similar to the A31 ISP, they have enough significant differences to
be out of the scope of this driver.

While the ISP supports many features, including 3A and many
enhancement blocks, this implementation is limited to the following:
- V3s (V3/S3) platform support;
- Bayer media bus formats as input;
- Semi-planar YUV (NV12/NV21) as output;
- Debayering with per-component gain and offset configuration;
- 2D noise filtering with configurable coefficients.

Since many features are missing from the associated uAPI, the driver
is aimed to integrate staging until all features are properly
described.

On the technical side, it uses the v4l2 and media controller APIs,
with a video node for capture, a processor subdev and a video node
for parameters submission. A specific uAPI structure and associated
v4l2 meta format are used to configure parameters of the supported
modules.

One particular thing about the hardware is that configuration for
module registers needs to be stored in a DMA buffer and gets copied
to actual registers by the hardware at the next vsync, when instructed
by a flag. This is handled by the "state" mechanism in the driver.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/staging/media/sunxi/Kconfig           |   1 +
 drivers/staging/media/sunxi/Makefile          |   1 +
 drivers/staging/media/sunxi/sun6i-isp/Kconfig |  15 +
 .../staging/media/sunxi/sun6i-isp/Makefile    |   4 +
 .../staging/media/sunxi/sun6i-isp/TODO.txt    |   6 +
 .../staging/media/sunxi/sun6i-isp/sun6i_isp.c | 555 +++++++++++++
 .../staging/media/sunxi/sun6i-isp/sun6i_isp.h |  90 +++
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.c | 742 ++++++++++++++++++
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.h |  78 ++
 .../media/sunxi/sun6i-isp/sun6i_isp_params.c  | 566 +++++++++++++
 .../media/sunxi/sun6i-isp/sun6i_isp_params.h  |  52 ++
 .../media/sunxi/sun6i-isp/sun6i_isp_proc.c    | 577 ++++++++++++++
 .../media/sunxi/sun6i-isp/sun6i_isp_proc.h    |  66 ++
 .../media/sunxi/sun6i-isp/sun6i_isp_reg.h     | 275 +++++++
 .../sunxi/sun6i-isp/uapi/sun6i-isp-config.h   |  43 +
 15 files changed, 3071 insertions(+)
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Kconfig
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Makefile
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/TODO.txt
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_reg.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/uapi/sun6i-isp-config.h

diff --git a/drivers/staging/media/sunxi/Kconfig b/drivers/staging/media/sunxi/Kconfig
index 4549a135741f..62a486aba88b 100644
--- a/drivers/staging/media/sunxi/Kconfig
+++ b/drivers/staging/media/sunxi/Kconfig
@@ -12,5 +12,6 @@ config VIDEO_SUNXI
 if VIDEO_SUNXI
 
 source "drivers/staging/media/sunxi/cedrus/Kconfig"
+source "drivers/staging/media/sunxi/sun6i-isp/Kconfig"
 
 endif
diff --git a/drivers/staging/media/sunxi/Makefile b/drivers/staging/media/sunxi/Makefile
index b87140b0e15f..3d20b2f0e644 100644
--- a/drivers/staging/media/sunxi/Makefile
+++ b/drivers/staging/media/sunxi/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_VIDEO_SUNXI_CEDRUS)	+= cedrus/
+obj-$(CONFIG_VIDEO_SUN6I_ISP)		+= sun6i-isp/
diff --git a/drivers/staging/media/sunxi/sun6i-isp/Kconfig b/drivers/staging/media/sunxi/sun6i-isp/Kconfig
new file mode 100644
index 000000000000..68dcae9cd7d7
--- /dev/null
+++ b/drivers/staging/media/sunxi/sun6i-isp/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_SUN6I_ISP
+	tristate "Allwinner A31 Image Signal Processor (ISP) Driver"
+	depends on V4L_PLATFORM_DRIVERS && VIDEO_DEV
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on PM && COMMON_CLK && HAS_DMA
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_VMALLOC
+	select V4L2_FWNODE
+	select REGMAP_MMIO
+	help
+	   Support for the Allwinner A31 Image Signal Processor (ISP), also
+	   found on other platforms such as the A80, A83T or V3/V3s.
diff --git a/drivers/staging/media/sunxi/sun6i-isp/Makefile b/drivers/staging/media/sunxi/sun6i-isp/Makefile
new file mode 100644
index 000000000000..da1034785144
--- /dev/null
+++ b/drivers/staging/media/sunxi/sun6i-isp/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+sun6i-isp-y += sun6i_isp.o sun6i_isp_proc.o sun6i_isp_capture.o sun6i_isp_params.o
+
+obj-$(CONFIG_VIDEO_SUN6I_ISP) += sun6i-isp.o
diff --git a/drivers/staging/media/sunxi/sun6i-isp/TODO.txt b/drivers/staging/media/sunxi/sun6i-isp/TODO.txt
new file mode 100644
index 000000000000..1e3236edc1ab
--- /dev/null
+++ b/drivers/staging/media/sunxi/sun6i-isp/TODO.txt
@@ -0,0 +1,6 @@
+Unstaging requirements:
+- Add uAPI support and documentation for the configuration of all the hardware
+  modules and description of the statistics data structures;
+- Add support for statistics reporting;
+- Add userspace support in libcamera which demonstrates the ability to receive
+  statistics and adapt hardware modules configuration accordingly;
diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c
new file mode 100644
index 000000000000..7b7947509b69
--- /dev/null
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c
@@ -0,0 +1,555 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-mc.h>
+
+#include "sun6i_isp.h"
+#include "sun6i_isp_capture.h"
+#include "sun6i_isp_params.h"
+#include "sun6i_isp_proc.h"
+#include "sun6i_isp_reg.h"
+
+/* Helpers */
+
+u32 sun6i_isp_load_read(struct sun6i_isp_device *isp_dev, u32 offset)
+{
+	u32 *data = (u32 *)(isp_dev->tables.load.data + offset);
+
+	return *data;
+}
+
+void sun6i_isp_load_write(struct sun6i_isp_device *isp_dev, u32 offset,
+			  u32 value)
+{
+	u32 *data = (u32 *)(isp_dev->tables.load.data + offset);
+
+	*data = value;
+}
+
+/* State */
+
+/*
+ * The ISP works with a load buffer, which gets copied to the actual registers
+ * by the hardware before processing a frame when a specific flag is set.
+ * This is represented by tracking the ISP state in the different parts of
+ * the code with explicit sync points:
+ * - state update: to update the load buffer for the next frame if necessary;
+ * - state complete: to indicate that the state update was applied.
+ */
+
+static void sun6i_isp_state_ready(struct sun6i_isp_device *isp_dev)
+{
+	struct regmap *regmap = isp_dev->regmap;
+	u32 value;
+
+	regmap_read(regmap, SUN6I_ISP_FE_CTRL_REG, &value);
+	value |= SUN6I_ISP_FE_CTRL_PARA_READY;
+	regmap_write(regmap, SUN6I_ISP_FE_CTRL_REG, value);
+}
+
+static void sun6i_isp_state_complete(struct sun6i_isp_device *isp_dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&isp_dev->state_lock, flags);
+
+	sun6i_isp_capture_state_complete(isp_dev);
+	sun6i_isp_params_state_complete(isp_dev);
+
+	spin_unlock_irqrestore(&isp_dev->state_lock, flags);
+}
+
+void sun6i_isp_state_update(struct sun6i_isp_device *isp_dev, bool ready_hold)
+{
+	bool update = false;
+	unsigned long flags;
+
+	spin_lock_irqsave(&isp_dev->state_lock, flags);
+
+	sun6i_isp_capture_state_update(isp_dev, &update);
+	sun6i_isp_params_state_update(isp_dev, &update);
+
+	if (update && !ready_hold)
+		sun6i_isp_state_ready(isp_dev);
+
+	spin_unlock_irqrestore(&isp_dev->state_lock, flags);
+}
+
+/* Tables */
+
+static int sun6i_isp_table_setup(struct sun6i_isp_device *isp_dev,
+				 struct sun6i_isp_table *table)
+{
+	table->data = dma_alloc_coherent(isp_dev->dev, table->size,
+					 &table->address, GFP_KERNEL);
+	if (!table->data)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void sun6i_isp_table_cleanup(struct sun6i_isp_device *isp_dev,
+				    struct sun6i_isp_table *table)
+{
+	dma_free_coherent(isp_dev->dev, table->size, table->data,
+			  table->address);
+}
+
+void sun6i_isp_tables_configure(struct sun6i_isp_device *isp_dev)
+{
+	struct regmap *regmap = isp_dev->regmap;
+
+	regmap_write(regmap, SUN6I_ISP_REG_LOAD_ADDR_REG,
+		     SUN6I_ISP_ADDR_VALUE(isp_dev->tables.load.address));
+
+	regmap_write(regmap, SUN6I_ISP_REG_SAVE_ADDR_REG,
+		     SUN6I_ISP_ADDR_VALUE(isp_dev->tables.save.address));
+
+	regmap_write(regmap, SUN6I_ISP_LUT_TABLE_ADDR_REG,
+		     SUN6I_ISP_ADDR_VALUE(isp_dev->tables.lut.address));
+
+	regmap_write(regmap, SUN6I_ISP_DRC_TABLE_ADDR_REG,
+		     SUN6I_ISP_ADDR_VALUE(isp_dev->tables.drc.address));
+
+	regmap_write(regmap, SUN6I_ISP_STATS_ADDR_REG,
+		     SUN6I_ISP_ADDR_VALUE(isp_dev->tables.stats.address));
+}
+
+static int sun6i_isp_tables_setup(struct sun6i_isp_device *isp_dev,
+				  const struct sun6i_isp_variant *variant)
+{
+	struct sun6i_isp_tables *tables = &isp_dev->tables;
+	int ret;
+
+	tables->load.size = variant->table_load_save_size;
+	ret = sun6i_isp_table_setup(isp_dev, &tables->load);
+	if (ret)
+		return ret;
+
+	tables->save.size = variant->table_load_save_size;
+	ret = sun6i_isp_table_setup(isp_dev, &tables->save);
+	if (ret)
+		return ret;
+
+	tables->lut.size = variant->table_lut_size;
+	ret = sun6i_isp_table_setup(isp_dev, &tables->lut);
+	if (ret)
+		return ret;
+
+	tables->drc.size = variant->table_drc_size;
+	ret = sun6i_isp_table_setup(isp_dev, &tables->drc);
+	if (ret)
+		return ret;
+
+	tables->stats.size = variant->table_stats_size;
+	ret = sun6i_isp_table_setup(isp_dev, &tables->stats);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void sun6i_isp_tables_cleanup(struct sun6i_isp_device *isp_dev)
+{
+	struct sun6i_isp_tables *tables = &isp_dev->tables;
+
+	sun6i_isp_table_cleanup(isp_dev, &tables->stats);
+	sun6i_isp_table_cleanup(isp_dev, &tables->drc);
+	sun6i_isp_table_cleanup(isp_dev, &tables->lut);
+	sun6i_isp_table_cleanup(isp_dev, &tables->save);
+	sun6i_isp_table_cleanup(isp_dev, &tables->load);
+}
+
+/* Media */
+
+static const struct media_device_ops sun6i_isp_media_ops = {
+	.link_notify = v4l2_pipeline_link_notify,
+};
+
+/* V4L2 */
+
+static int sun6i_isp_v4l2_setup(struct sun6i_isp_device *isp_dev)
+{
+	struct sun6i_isp_v4l2 *v4l2 = &isp_dev->v4l2;
+	struct v4l2_device *v4l2_dev = &v4l2->v4l2_dev;
+	struct media_device *media_dev = &v4l2->media_dev;
+	struct device *dev = isp_dev->dev;
+	int ret;
+
+	/* Media Device */
+
+	strscpy(media_dev->model, SUN6I_ISP_DESCRIPTION,
+		sizeof(media_dev->model));
+	media_dev->ops = &sun6i_isp_media_ops;
+	media_dev->hw_revision = 0;
+	media_dev->dev = dev;
+
+	media_device_init(media_dev);
+
+	ret = media_device_register(media_dev);
+	if (ret) {
+		dev_err(dev, "failed to register media device\n");
+		return ret;
+	}
+
+	/* V4L2 Device */
+
+	v4l2_dev->mdev = media_dev;
+
+	ret = v4l2_device_register(dev, v4l2_dev);
+	if (ret) {
+		dev_err(dev, "failed to register v4l2 device\n");
+		goto error_media;
+	}
+
+	return 0;
+
+error_media:
+	media_device_unregister(media_dev);
+	media_device_cleanup(media_dev);
+
+	return ret;
+}
+
+static void sun6i_isp_v4l2_cleanup(struct sun6i_isp_device *isp_dev)
+{
+	struct sun6i_isp_v4l2 *v4l2 = &isp_dev->v4l2;
+
+	media_device_unregister(&v4l2->media_dev);
+	v4l2_device_unregister(&v4l2->v4l2_dev);
+	media_device_cleanup(&v4l2->media_dev);
+}
+
+/* Platform */
+
+static irqreturn_t sun6i_isp_interrupt(int irq, void *private)
+{
+	struct sun6i_isp_device *isp_dev = private;
+	struct regmap *regmap = isp_dev->regmap;
+	u32 status = 0, enable = 0;
+
+	regmap_read(regmap, SUN6I_ISP_FE_INT_STA_REG, &status);
+	regmap_read(regmap, SUN6I_ISP_FE_INT_EN_REG, &enable);
+
+	if (!status)
+		return IRQ_NONE;
+	else if (!(status & enable))
+		goto complete;
+
+	/*
+	 * The ISP working cycle starts with a params-load, which makes the
+	 * state from the load buffer active. Then it starts processing the
+	 * frame and gives a finish interrupt. Soon after that, the next state
+	 * coming from the load buffer will be applied for the next frame,
+	 * giving a params-load as well.
+	 *
+	 * Because both frame finish and params-load are received almost
+	 * at the same time (one ISR call), handle them in chronology order.
+	 */
+
+	if (status & SUN6I_ISP_FE_INT_STA_FINISH)
+		sun6i_isp_capture_finish(isp_dev);
+
+	if (status & SUN6I_ISP_FE_INT_STA_PARA_LOAD) {
+		sun6i_isp_state_complete(isp_dev);
+		sun6i_isp_state_update(isp_dev, false);
+	}
+
+complete:
+	regmap_write(regmap, SUN6I_ISP_FE_INT_STA_REG, status);
+
+	return IRQ_HANDLED;
+}
+
+static int sun6i_isp_suspend(struct device *dev)
+{
+	struct sun6i_isp_device *isp_dev = dev_get_drvdata(dev);
+
+	reset_control_assert(isp_dev->reset);
+	clk_disable_unprepare(isp_dev->clock_ram);
+	clk_disable_unprepare(isp_dev->clock_mod);
+
+	return 0;
+}
+
+static int sun6i_isp_resume(struct device *dev)
+{
+	struct sun6i_isp_device *isp_dev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(isp_dev->reset);
+	if (ret) {
+		dev_err(dev, "failed to deassert reset\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(isp_dev->clock_mod);
+	if (ret) {
+		dev_err(dev, "failed to enable module clock\n");
+		goto error_reset;
+	}
+
+	ret = clk_prepare_enable(isp_dev->clock_ram);
+	if (ret) {
+		dev_err(dev, "failed to enable ram clock\n");
+		goto error_clock_mod;
+	}
+
+	return 0;
+
+error_clock_mod:
+	clk_disable_unprepare(isp_dev->clock_mod);
+
+error_reset:
+	reset_control_assert(isp_dev->reset);
+
+	return ret;
+}
+
+static const struct dev_pm_ops sun6i_isp_pm_ops = {
+	.runtime_suspend	= sun6i_isp_suspend,
+	.runtime_resume		= sun6i_isp_resume,
+};
+
+static const struct regmap_config sun6i_isp_regmap_config = {
+	.reg_bits       = 32,
+	.reg_stride     = 4,
+	.val_bits       = 32,
+	.max_register	= 0x400,
+};
+
+static int sun6i_isp_resources_setup(struct sun6i_isp_device *isp_dev,
+				     struct platform_device *platform_dev)
+{
+	struct device *dev = isp_dev->dev;
+	void __iomem *io_base;
+	int irq;
+	int ret;
+
+	/* Registers */
+
+	io_base = devm_platform_ioremap_resource(platform_dev, 0);
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
+
+	isp_dev->regmap = devm_regmap_init_mmio_clk(dev, "bus", io_base,
+						    &sun6i_isp_regmap_config);
+	if (IS_ERR(isp_dev->regmap)) {
+		dev_err(dev, "failed to init register map\n");
+		return PTR_ERR(isp_dev->regmap);
+	}
+
+	/* Clocks */
+
+	isp_dev->clock_mod = devm_clk_get(dev, "mod");
+	if (IS_ERR(isp_dev->clock_mod)) {
+		dev_err(dev, "failed to acquire module clock\n");
+		return PTR_ERR(isp_dev->clock_mod);
+	}
+
+	isp_dev->clock_ram = devm_clk_get(dev, "ram");
+	if (IS_ERR(isp_dev->clock_ram)) {
+		dev_err(dev, "failed to acquire ram clock\n");
+		return PTR_ERR(isp_dev->clock_ram);
+	}
+
+	ret = clk_set_rate_exclusive(isp_dev->clock_mod, 297000000);
+	if (ret) {
+		dev_err(dev, "failed to set mod clock rate\n");
+		return ret;
+	}
+
+	/* Reset */
+
+	isp_dev->reset = devm_reset_control_get_shared(dev, NULL);
+	if (IS_ERR(isp_dev->reset)) {
+		dev_err(dev, "failed to acquire reset\n");
+		ret = PTR_ERR(isp_dev->reset);
+		goto error_clock_rate_exclusive;
+	}
+
+	/* Interrupt */
+
+	irq = platform_get_irq(platform_dev, 0);
+	if (irq < 0) {
+		dev_err(dev, "failed to get interrupt\n");
+		ret = -ENXIO;
+		goto error_clock_rate_exclusive;
+	}
+
+	ret = devm_request_irq(dev, irq, sun6i_isp_interrupt, IRQF_SHARED,
+			       SUN6I_ISP_NAME, isp_dev);
+	if (ret) {
+		dev_err(dev, "failed to request interrupt\n");
+		goto error_clock_rate_exclusive;
+	}
+
+	/* Runtime PM */
+
+	pm_runtime_enable(dev);
+
+	return 0;
+
+error_clock_rate_exclusive:
+	clk_rate_exclusive_put(isp_dev->clock_mod);
+
+	return ret;
+}
+
+static void sun6i_isp_resources_cleanup(struct sun6i_isp_device *isp_dev)
+{
+	struct device *dev = isp_dev->dev;
+
+	pm_runtime_disable(dev);
+	clk_rate_exclusive_put(isp_dev->clock_mod);
+}
+
+static int sun6i_isp_probe(struct platform_device *platform_dev)
+{
+	struct sun6i_isp_device *isp_dev;
+	struct device *dev = &platform_dev->dev;
+	const struct sun6i_isp_variant *variant;
+	int ret;
+
+	variant = of_device_get_match_data(dev);
+	if (!variant)
+		return -EINVAL;
+
+	isp_dev = devm_kzalloc(dev, sizeof(*isp_dev), GFP_KERNEL);
+	if (!isp_dev)
+		return -ENOMEM;
+
+	isp_dev->dev = dev;
+	platform_set_drvdata(platform_dev, isp_dev);
+
+	spin_lock_init(&isp_dev->state_lock);
+
+	ret = sun6i_isp_resources_setup(isp_dev, platform_dev);
+	if (ret)
+		return ret;
+
+	ret = sun6i_isp_tables_setup(isp_dev, variant);
+	if (ret) {
+		dev_err(dev, "failed to setup tables\n");
+		goto error_resources;
+	}
+
+	ret = sun6i_isp_v4l2_setup(isp_dev);
+	if (ret) {
+		dev_err(dev, "failed to setup v4l2\n");
+		goto error_tables;
+	}
+
+	ret = sun6i_isp_proc_setup(isp_dev);
+	if (ret) {
+		dev_err(dev, "failed to setup proc\n");
+		goto error_v4l2;
+	}
+
+	ret = sun6i_isp_capture_setup(isp_dev);
+	if (ret) {
+		dev_err(dev, "failed to setup capture\n");
+		goto error_proc;
+	}
+
+	ret = sun6i_isp_params_setup(isp_dev);
+	if (ret) {
+		dev_err(dev, "failed to setup params\n");
+		goto error_capture;
+	}
+
+	return 0;
+
+error_capture:
+	sun6i_isp_capture_cleanup(isp_dev);
+
+error_proc:
+	sun6i_isp_proc_cleanup(isp_dev);
+
+error_v4l2:
+	sun6i_isp_v4l2_cleanup(isp_dev);
+
+error_tables:
+	sun6i_isp_tables_cleanup(isp_dev);
+
+error_resources:
+	sun6i_isp_resources_cleanup(isp_dev);
+
+	return ret;
+}
+
+static int sun6i_isp_remove(struct platform_device *platform_dev)
+{
+	struct sun6i_isp_device *isp_dev = platform_get_drvdata(platform_dev);
+
+	sun6i_isp_params_cleanup(isp_dev);
+	sun6i_isp_capture_cleanup(isp_dev);
+	sun6i_isp_proc_cleanup(isp_dev);
+	sun6i_isp_v4l2_cleanup(isp_dev);
+	sun6i_isp_tables_cleanup(isp_dev);
+	sun6i_isp_resources_cleanup(isp_dev);
+
+	return 0;
+}
+
+/*
+ * History of sun6i-isp:
+ * - sun4i-a10-isp: initial ISP tied to the CSI0 controller,
+ *   apparently unused in software implementations;
+ * - sun6i-a31-isp: separate ISP loosely based on sun4i-a10-isp,
+ *   adding extra modules and features;
+ * - sun9i-a80-isp: based on sun6i-a31-isp with some register offset changes
+ *   and new modules like saturation and cnr;
+ * - sun8i-a23-isp/sun8i-h3-isp: based on sun9i-a80-isp with most modules
+ *   related to raw removed;
+ * - sun8i-a83t-isp: based on sun9i-a80-isp with some register offset changes
+ * - sun8i-v3s-isp: based on sun8i-a83t-isp with a new disc module;
+ */
+
+static const struct sun6i_isp_variant sun8i_v3s_isp_variant = {
+	.table_load_save_size	= 0x1000,
+	.table_lut_size		= 0xe00,
+	.table_drc_size		= 0x600,
+	.table_stats_size	= 0x2100,
+};
+
+static const struct of_device_id sun6i_isp_of_match[] = {
+	{
+		.compatible	= "allwinner,sun8i-v3s-isp",
+		.data		= &sun8i_v3s_isp_variant,
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, sun6i_isp_of_match);
+
+static struct platform_driver sun6i_isp_platform_driver = {
+	.probe	= sun6i_isp_probe,
+	.remove	= sun6i_isp_remove,
+	.driver	= {
+		.name		= SUN6I_ISP_NAME,
+		.of_match_table	= of_match_ptr(sun6i_isp_of_match),
+		.pm		= &sun6i_isp_pm_ops,
+	},
+};
+
+module_platform_driver(sun6i_isp_platform_driver);
+
+MODULE_DESCRIPTION("Allwinner A31 Image Signal Processor driver");
+MODULE_AUTHOR("Paul Kocialkowski <paul.kocialkowski@bootlin.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.h b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.h
new file mode 100644
index 000000000000..0e5f188319ff
--- /dev/null
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#ifndef _SUN6I_ISP_H_
+#define _SUN6I_ISP_H_
+
+#include <media/v4l2-device.h>
+#include <media/videobuf2-v4l2.h>
+
+#include "sun6i_isp_capture.h"
+#include "sun6i_isp_params.h"
+#include "sun6i_isp_proc.h"
+
+#define SUN6I_ISP_NAME			"sun6i-isp"
+#define SUN6I_ISP_DESCRIPTION		"Allwinner A31 ISP Device"
+
+enum sun6i_isp_port {
+	SUN6I_ISP_PORT_CSI0	= 0,
+	SUN6I_ISP_PORT_CSI1	= 1,
+};
+
+struct sun6i_isp_buffer {
+	struct vb2_v4l2_buffer	v4l2_buffer;
+	struct list_head	list;
+};
+
+struct sun6i_isp_v4l2 {
+	struct v4l2_device		v4l2_dev;
+	struct media_device		media_dev;
+};
+
+struct sun6i_isp_table {
+	void		*data;
+	dma_addr_t	address;
+	unsigned int	size;
+};
+
+struct sun6i_isp_tables {
+	struct sun6i_isp_table	load;
+	struct sun6i_isp_table	save;
+
+	struct sun6i_isp_table	lut;
+	struct sun6i_isp_table	drc;
+	struct sun6i_isp_table	stats;
+};
+
+struct sun6i_isp_device {
+	struct device			*dev;
+
+	struct sun6i_isp_tables		tables;
+
+	struct sun6i_isp_v4l2		v4l2;
+	struct sun6i_isp_proc		proc;
+	struct sun6i_isp_capture	capture;
+	struct sun6i_isp_params		params;
+
+	struct regmap			*regmap;
+	struct clk			*clock_mod;
+	struct clk			*clock_ram;
+	struct reset_control		*reset;
+
+	spinlock_t			state_lock; /* State helpers lock. */
+};
+
+struct sun6i_isp_variant {
+	unsigned int	table_load_save_size;
+	unsigned int	table_lut_size;
+	unsigned int	table_drc_size;
+	unsigned int	table_stats_size;
+};
+
+/* Helpers */
+
+u32 sun6i_isp_load_read(struct sun6i_isp_device *isp_dev, u32 offset);
+void sun6i_isp_load_write(struct sun6i_isp_device *isp_dev, u32 offset,
+			  u32 value);
+u32 sun6i_isp_address_value(dma_addr_t address);
+
+/* State */
+
+void sun6i_isp_state_update(struct sun6i_isp_device *isp_dev, bool ready_hold);
+
+/* Tables */
+
+void sun6i_isp_tables_configure(struct sun6i_isp_device *isp_dev);
+
+#endif
diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
new file mode 100644
index 000000000000..c15b7126ed2c
--- /dev/null
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
@@ -0,0 +1,742 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mc.h>
+#include <media/videobuf2-dma-contig.h>
+#include <media/videobuf2-v4l2.h>
+
+#include "sun6i_isp.h"
+#include "sun6i_isp_capture.h"
+#include "sun6i_isp_proc.h"
+#include "sun6i_isp_reg.h"
+
+/* Helpers */
+
+void sun6i_isp_capture_dimensions(struct sun6i_isp_device *isp_dev,
+				  unsigned int *width, unsigned int *height)
+{
+	if (width)
+		*width = isp_dev->capture.format.fmt.pix.width;
+	if (height)
+		*height = isp_dev->capture.format.fmt.pix.height;
+}
+
+void sun6i_isp_capture_format(struct sun6i_isp_device *isp_dev,
+			      u32 *pixelformat)
+{
+	if (pixelformat)
+		*pixelformat = isp_dev->capture.format.fmt.pix.pixelformat;
+}
+
+/* Format */
+
+static const struct sun6i_isp_capture_format sun6i_isp_capture_formats[] = {
+	{
+		.pixelformat		= V4L2_PIX_FMT_NV12,
+		.output_format		= SUN6I_ISP_OUTPUT_FMT_YUV420SP,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_NV21,
+		.output_format		= SUN6I_ISP_OUTPUT_FMT_YVU420SP,
+	},
+};
+
+const struct sun6i_isp_capture_format *
+sun6i_isp_capture_format_find(u32 pixelformat)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sun6i_isp_capture_formats); i++)
+		if (sun6i_isp_capture_formats[i].pixelformat == pixelformat)
+			return &sun6i_isp_capture_formats[i];
+
+	return NULL;
+}
+
+/* Capture */
+
+static void
+sun6i_isp_capture_buffer_configure(struct sun6i_isp_device *isp_dev,
+				   struct sun6i_isp_buffer *isp_buffer)
+{
+	const struct v4l2_format_info *info;
+	struct vb2_buffer *vb2_buffer;
+	unsigned int width, height;
+	unsigned int width_aligned;
+	dma_addr_t address;
+	u32 pixelformat;
+
+	vb2_buffer = &isp_buffer->v4l2_buffer.vb2_buf;
+	address = vb2_dma_contig_plane_dma_addr(vb2_buffer, 0);
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_Y_ADDR0_REG,
+			     SUN6I_ISP_ADDR_VALUE(address));
+
+	sun6i_isp_capture_dimensions(isp_dev, &width, &height);
+	sun6i_isp_capture_format(isp_dev, &pixelformat);
+
+	info = v4l2_format_info(pixelformat);
+	if (WARN_ON(!info))
+		return;
+
+	/* Stride needs to be aligned to 4. */
+	width_aligned = ALIGN(width, 2);
+
+	if (info->comp_planes > 1) {
+		address += info->bpp[0] * width_aligned * height;
+
+		sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_U_ADDR0_REG,
+				     SUN6I_ISP_ADDR_VALUE(address));
+	}
+
+	if (info->comp_planes > 2) {
+		address += info->bpp[1] *
+			   DIV_ROUND_UP(width_aligned, info->hdiv) *
+			   DIV_ROUND_UP(height, info->vdiv);
+
+		sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_V_ADDR0_REG,
+				     SUN6I_ISP_ADDR_VALUE(address));
+	}
+}
+
+void sun6i_isp_capture_configure(struct sun6i_isp_device *isp_dev)
+{
+	unsigned int width, height;
+	unsigned int stride_luma, stride_chroma = 0;
+	unsigned int stride_luma_div4, stride_chroma_div4;
+	const struct sun6i_isp_capture_format *format;
+	const struct v4l2_format_info *info;
+	u32 pixelformat;
+
+	sun6i_isp_capture_dimensions(isp_dev, &width, &height);
+	sun6i_isp_capture_format(isp_dev, &pixelformat);
+
+	format = sun6i_isp_capture_format_find(pixelformat);
+	if (WARN_ON(!format))
+		return;
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_SIZE_CFG_REG,
+			     SUN6I_ISP_MCH_SIZE_CFG_WIDTH(width) |
+			     SUN6I_ISP_MCH_SIZE_CFG_HEIGHT(height));
+
+	info = v4l2_format_info(pixelformat);
+	if (WARN_ON(!info))
+		return;
+
+	stride_luma = width * info->bpp[0];
+	stride_luma_div4 = DIV_ROUND_UP(stride_luma, 4);
+
+	if (info->comp_planes > 1) {
+		stride_chroma = width * info->bpp[1] / info->hdiv;
+		stride_chroma_div4 = DIV_ROUND_UP(stride_chroma, 4);
+	}
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_CFG_REG,
+			     SUN6I_ISP_MCH_CFG_EN |
+			     SUN6I_ISP_MCH_CFG_OUTPUT_FMT(format->output_format) |
+			     SUN6I_ISP_MCH_CFG_STRIDE_Y_DIV4(stride_luma_div4) |
+			     SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4(stride_chroma_div4));
+}
+
+/* State */
+
+static void sun6i_isp_capture_state_cleanup(struct sun6i_isp_device *isp_dev,
+					    bool error)
+{
+	struct sun6i_isp_capture_state *state = &isp_dev->capture.state;
+	struct sun6i_isp_buffer **isp_buffer_states[] = {
+		&state->pending, &state->current, &state->complete,
+	};
+	struct sun6i_isp_buffer *isp_buffer;
+	struct vb2_buffer *vb2_buffer;
+	unsigned long flags;
+	unsigned int i;
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	for (i = 0; i < ARRAY_SIZE(isp_buffer_states); i++) {
+		isp_buffer = *isp_buffer_states[i];
+		if (!isp_buffer)
+			continue;
+
+		vb2_buffer = &isp_buffer->v4l2_buffer.vb2_buf;
+		vb2_buffer_done(vb2_buffer, error ? VB2_BUF_STATE_ERROR :
+				VB2_BUF_STATE_QUEUED);
+
+		*isp_buffer_states[i] = NULL;
+	}
+
+	list_for_each_entry(isp_buffer, &state->queue, list) {
+		vb2_buffer = &isp_buffer->v4l2_buffer.vb2_buf;
+		vb2_buffer_done(vb2_buffer, error ? VB2_BUF_STATE_ERROR :
+				VB2_BUF_STATE_QUEUED);
+	}
+
+	INIT_LIST_HEAD(&state->queue);
+
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+
+void sun6i_isp_capture_state_update(struct sun6i_isp_device *isp_dev,
+				    bool *update)
+{
+	struct sun6i_isp_capture_state *state = &isp_dev->capture.state;
+	struct sun6i_isp_buffer *isp_buffer;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	if (list_empty(&state->queue))
+		goto complete;
+
+	if (state->pending)
+		goto complete;
+
+	isp_buffer = list_first_entry(&state->queue, struct sun6i_isp_buffer,
+				      list);
+
+	sun6i_isp_capture_buffer_configure(isp_dev, isp_buffer);
+
+	list_del(&isp_buffer->list);
+
+	state->pending = isp_buffer;
+
+	if (update)
+		*update = true;
+
+complete:
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+
+void sun6i_isp_capture_state_complete(struct sun6i_isp_device *isp_dev)
+{
+	struct sun6i_isp_capture_state *state = &isp_dev->capture.state;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	if (!state->pending)
+		goto complete;
+
+	state->complete = state->current;
+	state->current = state->pending;
+	state->pending = NULL;
+
+	if (state->complete) {
+		struct sun6i_isp_buffer *isp_buffer = state->complete;
+		struct vb2_buffer *vb2_buffer =
+			&isp_buffer->v4l2_buffer.vb2_buf;
+
+		vb2_buffer->timestamp = ktime_get_ns();
+		isp_buffer->v4l2_buffer.sequence = state->sequence;
+
+		vb2_buffer_done(vb2_buffer, VB2_BUF_STATE_DONE);
+
+		state->complete = NULL;
+	}
+
+complete:
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+
+void sun6i_isp_capture_finish(struct sun6i_isp_device *isp_dev)
+{
+	struct sun6i_isp_capture_state *state = &isp_dev->capture.state;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state->lock, flags);
+	state->sequence++;
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+
+/* Queue */
+
+static int sun6i_isp_capture_queue_setup(struct vb2_queue *queue,
+					 unsigned int *buffers_count,
+					 unsigned int *planes_count,
+					 unsigned int sizes[],
+					 struct device *alloc_devs[])
+{
+	struct sun6i_isp_device *isp_dev = vb2_get_drv_priv(queue);
+	unsigned int size = isp_dev->capture.format.fmt.pix.sizeimage;
+
+	if (*planes_count)
+		return sizes[0] < size ? -EINVAL : 0;
+
+	*planes_count = 1;
+	sizes[0] = size;
+
+	return 0;
+}
+
+static int sun6i_isp_capture_buffer_prepare(struct vb2_buffer *vb2_buffer)
+{
+	struct sun6i_isp_device *isp_dev =
+		vb2_get_drv_priv(vb2_buffer->vb2_queue);
+	struct v4l2_device *v4l2_dev = &isp_dev->v4l2.v4l2_dev;
+	unsigned int size = isp_dev->capture.format.fmt.pix.sizeimage;
+
+	if (vb2_plane_size(vb2_buffer, 0) < size) {
+		v4l2_err(v4l2_dev, "buffer too small (%lu < %u)\n",
+			 vb2_plane_size(vb2_buffer, 0), size);
+		return -EINVAL;
+	}
+
+	vb2_set_plane_payload(vb2_buffer, 0, size);
+
+	return 0;
+}
+
+static void sun6i_isp_capture_buffer_queue(struct vb2_buffer *vb2_buffer)
+{
+	struct sun6i_isp_device *isp_dev =
+		vb2_get_drv_priv(vb2_buffer->vb2_queue);
+	struct sun6i_isp_capture_state *state = &isp_dev->capture.state;
+	struct vb2_v4l2_buffer *v4l2_buffer = to_vb2_v4l2_buffer(vb2_buffer);
+	struct sun6i_isp_buffer *isp_buffer =
+		container_of(v4l2_buffer, struct sun6i_isp_buffer, v4l2_buffer);
+	unsigned long flags;
+
+	spin_lock_irqsave(&state->lock, flags);
+	list_add_tail(&isp_buffer->list, &state->queue);
+	spin_unlock_irqrestore(&state->lock, flags);
+
+	/* Update the state to schedule our buffer as soon as possible. */
+	if (state->streaming)
+		sun6i_isp_state_update(isp_dev, false);
+}
+
+static int sun6i_isp_capture_start_streaming(struct vb2_queue *queue,
+					     unsigned int count)
+{
+	struct sun6i_isp_device *isp_dev = vb2_get_drv_priv(queue);
+	struct sun6i_isp_capture_state *state = &isp_dev->capture.state;
+	struct video_device *video_dev = &isp_dev->capture.video_dev;
+	struct v4l2_subdev *subdev = &isp_dev->proc.subdev;
+	int ret;
+
+	state->sequence = 0;
+
+	ret = media_pipeline_start(&video_dev->entity, &video_dev->pipe);
+	if (ret < 0)
+		goto error_state;
+
+	state->streaming = true;
+
+	ret = v4l2_subdev_call(subdev, video, s_stream, 1);
+	if (ret && ret != -ENOIOCTLCMD)
+		goto error_streaming;
+
+	return 0;
+
+error_streaming:
+	state->streaming = false;
+
+	media_pipeline_stop(&video_dev->entity);
+
+error_state:
+	sun6i_isp_capture_state_cleanup(isp_dev, false);
+
+	return ret;
+}
+
+static void sun6i_isp_capture_stop_streaming(struct vb2_queue *queue)
+{
+	struct sun6i_isp_device *isp_dev = vb2_get_drv_priv(queue);
+	struct sun6i_isp_capture_state *state = &isp_dev->capture.state;
+	struct video_device *video_dev = &isp_dev->capture.video_dev;
+	struct v4l2_subdev *subdev = &isp_dev->proc.subdev;
+
+	v4l2_subdev_call(subdev, video, s_stream, 0);
+
+	state->streaming = false;
+
+	media_pipeline_stop(&video_dev->entity);
+
+	sun6i_isp_capture_state_cleanup(isp_dev, true);
+}
+
+static const struct vb2_ops sun6i_isp_capture_queue_ops = {
+	.queue_setup		= sun6i_isp_capture_queue_setup,
+	.buf_prepare		= sun6i_isp_capture_buffer_prepare,
+	.buf_queue		= sun6i_isp_capture_buffer_queue,
+	.start_streaming	= sun6i_isp_capture_start_streaming,
+	.stop_streaming		= sun6i_isp_capture_stop_streaming,
+	.wait_prepare		= vb2_ops_wait_prepare,
+	.wait_finish		= vb2_ops_wait_finish,
+};
+
+/* Video Device */
+
+static void sun6i_isp_capture_format_prepare(struct v4l2_format *format)
+{
+	struct v4l2_pix_format *pix_format = &format->fmt.pix;
+	const struct v4l2_format_info *info;
+	unsigned int width, height;
+	unsigned int width_aligned;
+	unsigned int i;
+
+	v4l_bound_align_image(&pix_format->width, SUN6I_ISP_CAPTURE_WIDTH_MIN,
+			      SUN6I_ISP_CAPTURE_WIDTH_MAX, 1,
+			      &pix_format->height, SUN6I_ISP_CAPTURE_HEIGHT_MIN,
+			      SUN6I_ISP_CAPTURE_HEIGHT_MAX, 1, 0);
+
+	if (!sun6i_isp_capture_format_find(pix_format->pixelformat))
+		pix_format->pixelformat =
+			sun6i_isp_capture_formats[0].pixelformat;
+
+	info = v4l2_format_info(pix_format->pixelformat);
+	if (WARN_ON(!info))
+		return;
+
+	width = pix_format->width;
+	height = pix_format->height;
+
+	/* Stride needs to be aligned to 4. */
+	width_aligned = ALIGN(width, 2);
+
+	pix_format->bytesperline = width_aligned * info->bpp[0];
+	pix_format->sizeimage = 0;
+
+	for (i = 0; i < info->comp_planes; i++) {
+		unsigned int hdiv = (i == 0) ? 1 : info->hdiv;
+		unsigned int vdiv = (i == 0) ? 1 : info->vdiv;
+
+		pix_format->sizeimage += info->bpp[i] *
+					 DIV_ROUND_UP(width_aligned, hdiv) *
+					 DIV_ROUND_UP(height, vdiv);
+	}
+
+	pix_format->field = V4L2_FIELD_NONE;
+
+	pix_format->colorspace = V4L2_COLORSPACE_RAW;
+	pix_format->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	pix_format->quantization = V4L2_QUANTIZATION_DEFAULT;
+	pix_format->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+}
+
+static int sun6i_isp_capture_querycap(struct file *file, void *private,
+				      struct v4l2_capability *capability)
+{
+	struct sun6i_isp_device *isp_dev = video_drvdata(file);
+	struct video_device *video_dev = &isp_dev->capture.video_dev;
+
+	strscpy(capability->driver, SUN6I_ISP_NAME, sizeof(capability->driver));
+	strscpy(capability->card, video_dev->name, sizeof(capability->card));
+	snprintf(capability->bus_info, sizeof(capability->bus_info),
+		 "platform:%s", dev_name(isp_dev->dev));
+
+	return 0;
+}
+
+static int sun6i_isp_capture_enum_fmt(struct file *file, void *private,
+				      struct v4l2_fmtdesc *fmtdesc)
+{
+	u32 index = fmtdesc->index;
+
+	if (index >= ARRAY_SIZE(sun6i_isp_capture_formats))
+		return -EINVAL;
+
+	fmtdesc->pixelformat = sun6i_isp_capture_formats[index].pixelformat;
+
+	return 0;
+}
+
+static int sun6i_isp_capture_g_fmt(struct file *file, void *private,
+				   struct v4l2_format *format)
+{
+	struct sun6i_isp_device *isp_dev = video_drvdata(file);
+
+	*format = isp_dev->capture.format;
+
+	return 0;
+}
+
+static int sun6i_isp_capture_s_fmt(struct file *file, void *private,
+				   struct v4l2_format *format)
+{
+	struct sun6i_isp_device *isp_dev = video_drvdata(file);
+
+	if (vb2_is_busy(&isp_dev->capture.queue))
+		return -EBUSY;
+
+	sun6i_isp_capture_format_prepare(format);
+
+	isp_dev->capture.format = *format;
+
+	return 0;
+}
+
+static int sun6i_isp_capture_try_fmt(struct file *file, void *private,
+				     struct v4l2_format *format)
+{
+	sun6i_isp_capture_format_prepare(format);
+
+	return 0;
+}
+
+static int sun6i_isp_capture_enum_input(struct file *file, void *private,
+					struct v4l2_input *input)
+{
+	if (input->index != 0)
+		return -EINVAL;
+
+	input->type = V4L2_INPUT_TYPE_CAMERA;
+	strscpy(input->name, "Camera", sizeof(input->name));
+
+	return 0;
+}
+
+static int sun6i_isp_capture_g_input(struct file *file, void *private,
+				     unsigned int *index)
+{
+	*index = 0;
+
+	return 0;
+}
+
+static int sun6i_isp_capture_s_input(struct file *file, void *private,
+				     unsigned int index)
+{
+	if (index != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops sun6i_isp_capture_ioctl_ops = {
+	.vidioc_querycap		= sun6i_isp_capture_querycap,
+
+	.vidioc_enum_fmt_vid_cap	= sun6i_isp_capture_enum_fmt,
+	.vidioc_g_fmt_vid_cap		= sun6i_isp_capture_g_fmt,
+	.vidioc_s_fmt_vid_cap		= sun6i_isp_capture_s_fmt,
+	.vidioc_try_fmt_vid_cap		= sun6i_isp_capture_try_fmt,
+
+	.vidioc_enum_input		= sun6i_isp_capture_enum_input,
+	.vidioc_g_input			= sun6i_isp_capture_g_input,
+	.vidioc_s_input			= sun6i_isp_capture_s_input,
+
+	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf		= vb2_ioctl_prepare_buf,
+	.vidioc_reqbufs			= vb2_ioctl_reqbufs,
+	.vidioc_querybuf		= vb2_ioctl_querybuf,
+	.vidioc_expbuf			= vb2_ioctl_expbuf,
+	.vidioc_qbuf			= vb2_ioctl_qbuf,
+	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
+	.vidioc_streamon		= vb2_ioctl_streamon,
+	.vidioc_streamoff		= vb2_ioctl_streamoff,
+};
+
+static int sun6i_isp_capture_open(struct file *file)
+{
+	struct sun6i_isp_device *isp_dev = video_drvdata(file);
+	struct video_device *video_dev = &isp_dev->capture.video_dev;
+	struct mutex *lock = &isp_dev->capture.lock;
+	int ret;
+
+	if (mutex_lock_interruptible(lock))
+		return -ERESTARTSYS;
+
+	ret = v4l2_pipeline_pm_get(&video_dev->entity);
+	if (ret)
+		goto error_mutex;
+
+	ret = v4l2_fh_open(file);
+	if (ret)
+		goto error_pipeline;
+
+	mutex_unlock(lock);
+
+	return 0;
+
+error_pipeline:
+	v4l2_pipeline_pm_put(&video_dev->entity);
+
+error_mutex:
+	mutex_unlock(lock);
+
+	return ret;
+}
+
+static int sun6i_isp_capture_release(struct file *file)
+{
+	struct sun6i_isp_device *isp_dev = video_drvdata(file);
+	struct video_device *video_dev = &isp_dev->capture.video_dev;
+	struct mutex *lock = &isp_dev->capture.lock;
+
+	mutex_lock(lock);
+
+	_vb2_fop_release(file, NULL);
+	v4l2_pipeline_pm_put(&video_dev->entity);
+
+	mutex_unlock(lock);
+
+	return 0;
+}
+
+static const struct v4l2_file_operations sun6i_isp_capture_fops = {
+	.owner		= THIS_MODULE,
+	.open		= sun6i_isp_capture_open,
+	.release	= sun6i_isp_capture_release,
+	.unlocked_ioctl	= video_ioctl2,
+	.poll		= vb2_fop_poll,
+	.mmap		= vb2_fop_mmap,
+};
+
+/* Media Entity */
+
+static int sun6i_isp_capture_link_validate(struct media_link *link)
+{
+	struct video_device *video_dev =
+		media_entity_to_video_device(link->sink->entity);
+	struct sun6i_isp_device *isp_dev = video_get_drvdata(video_dev);
+	struct v4l2_device *v4l2_dev = &isp_dev->v4l2.v4l2_dev;
+	unsigned int capture_width, capture_height;
+	unsigned int proc_width, proc_height;
+
+	sun6i_isp_capture_dimensions(isp_dev, &capture_width, &capture_height);
+	sun6i_isp_proc_dimensions(isp_dev, &proc_width, &proc_height);
+
+	/* No cropping/scaling is supported (yet). */
+	if (capture_width != proc_width || capture_height != proc_height) {
+		v4l2_err(v4l2_dev,
+			 "invalid input/output dimensions: %ux%u/%ux%u\n",
+			 proc_width, proc_height, capture_width,
+			 capture_height);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct media_entity_operations sun6i_isp_capture_entity_ops = {
+	.link_validate	= sun6i_isp_capture_link_validate,
+};
+
+/* Capture */
+
+int sun6i_isp_capture_setup(struct sun6i_isp_device *isp_dev)
+{
+	struct sun6i_isp_capture *capture = &isp_dev->capture;
+	struct sun6i_isp_capture_state *state = &capture->state;
+	struct v4l2_device *v4l2_dev = &isp_dev->v4l2.v4l2_dev;
+	struct v4l2_subdev *proc_subdev = &isp_dev->proc.subdev;
+	struct video_device *video_dev = &capture->video_dev;
+	struct vb2_queue *queue = &capture->queue;
+	struct media_pad *pad = &capture->pad;
+	struct v4l2_format *format = &capture->format;
+	struct v4l2_pix_format *pix_format = &format->fmt.pix;
+	int ret;
+
+	/* State */
+
+	INIT_LIST_HEAD(&state->queue);
+	spin_lock_init(&state->lock);
+
+	/* Media Entity */
+
+	video_dev->entity.ops = &sun6i_isp_capture_entity_ops;
+
+	/* Media Pads */
+
+	pad->flags = MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
+
+	ret = media_entity_pads_init(&video_dev->entity, 1, pad);
+	if (ret)
+		goto error_mutex;
+
+	/* Queue */
+
+	mutex_init(&capture->lock);
+
+	queue->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	queue->io_modes = VB2_MMAP | VB2_DMABUF;
+	queue->buf_struct_size = sizeof(struct sun6i_isp_buffer);
+	queue->ops = &sun6i_isp_capture_queue_ops;
+	queue->mem_ops = &vb2_dma_contig_memops;
+	queue->min_buffers_needed = 2;
+	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	queue->lock = &capture->lock;
+	queue->dev = isp_dev->dev;
+	queue->drv_priv = isp_dev;
+
+	ret = vb2_queue_init(queue);
+	if (ret) {
+		v4l2_err(v4l2_dev, "failed to initialize vb2 queue: %d\n", ret);
+		goto error_media_entity;
+	}
+
+	/* V4L2 Format */
+
+	format->type = queue->type;
+	pix_format->pixelformat = sun6i_isp_capture_formats[0].pixelformat;
+	pix_format->width = 1280;
+	pix_format->height = 720;
+
+	sun6i_isp_capture_format_prepare(format);
+
+	/* Video Device */
+
+	strscpy(video_dev->name, SUN6I_ISP_CAPTURE_NAME,
+		sizeof(video_dev->name));
+	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+	video_dev->vfl_dir = VFL_DIR_RX;
+	video_dev->release = video_device_release_empty;
+	video_dev->fops = &sun6i_isp_capture_fops;
+	video_dev->ioctl_ops = &sun6i_isp_capture_ioctl_ops;
+	video_dev->v4l2_dev = v4l2_dev;
+	video_dev->queue = queue;
+	video_dev->lock = &capture->lock;
+
+	video_set_drvdata(video_dev, isp_dev);
+
+	ret = video_register_device(video_dev, VFL_TYPE_VIDEO, -1);
+	if (ret) {
+		v4l2_err(v4l2_dev, "failed to register video device: %d\n",
+			 ret);
+		goto error_media_entity;
+	}
+
+	/* Media Pad Link */
+
+	ret = media_create_pad_link(&proc_subdev->entity,
+				    SUN6I_ISP_PROC_PAD_SOURCE,
+				    &video_dev->entity, 0,
+				    MEDIA_LNK_FL_ENABLED |
+				    MEDIA_LNK_FL_IMMUTABLE);
+	if (ret < 0) {
+		v4l2_err(v4l2_dev, "failed to create %s:%u -> %s:%u link\n",
+			 proc_subdev->entity.name, SUN6I_ISP_PROC_PAD_SOURCE,
+			 video_dev->entity.name, 0);
+		goto error_video_device;
+	}
+
+	return 0;
+
+error_video_device:
+	vb2_video_unregister_device(video_dev);
+
+error_media_entity:
+	media_entity_cleanup(&video_dev->entity);
+
+error_mutex:
+	mutex_destroy(&capture->lock);
+
+	return ret;
+}
+
+void sun6i_isp_capture_cleanup(struct sun6i_isp_device *isp_dev)
+{
+	struct sun6i_isp_capture *capture = &isp_dev->capture;
+	struct video_device *video_dev = &capture->video_dev;
+
+	vb2_video_unregister_device(video_dev);
+	media_entity_cleanup(&video_dev->entity);
+	mutex_destroy(&capture->lock);
+}
diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.h b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.h
new file mode 100644
index 000000000000..0e3e4fa7a0f4
--- /dev/null
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#ifndef _SUN6I_ISP_CAPTURE_H_
+#define _SUN6I_ISP_CAPTURE_H_
+
+#include <media/v4l2-device.h>
+
+#define SUN6I_ISP_CAPTURE_NAME		"sun6i-isp-capture"
+
+#define SUN6I_ISP_CAPTURE_WIDTH_MIN	16
+#define SUN6I_ISP_CAPTURE_WIDTH_MAX	3264
+#define SUN6I_ISP_CAPTURE_HEIGHT_MIN	16
+#define SUN6I_ISP_CAPTURE_HEIGHT_MAX	2448
+
+struct sun6i_isp_device;
+
+struct sun6i_isp_capture_format {
+	u32	pixelformat;
+	u8	output_format;
+};
+
+#undef current
+struct sun6i_isp_capture_state {
+	struct list_head		queue;
+	spinlock_t			lock; /* Queue and buffers lock. */
+
+	struct sun6i_isp_buffer		*pending;
+	struct sun6i_isp_buffer		*current;
+	struct sun6i_isp_buffer		*complete;
+
+	unsigned int			sequence;
+	bool				streaming;
+};
+
+struct sun6i_isp_capture {
+	struct sun6i_isp_capture_state	state;
+
+	struct video_device		video_dev;
+	struct vb2_queue		queue;
+	struct mutex			lock; /* Queue lock. */
+	struct media_pad		pad;
+
+	struct v4l2_format		format;
+};
+
+/* Helpers */
+
+void sun6i_isp_capture_dimensions(struct sun6i_isp_device *isp_dev,
+				  unsigned int *width, unsigned int *height);
+void sun6i_isp_capture_format(struct sun6i_isp_device *isp_dev,
+			      u32 *pixelformat);
+
+/* Format */
+
+const struct sun6i_isp_capture_format *
+sun6i_isp_capture_format_find(u32 pixelformat);
+
+/* Capture */
+
+void sun6i_isp_capture_configure(struct sun6i_isp_device *isp_dev);
+
+/* State */
+
+void sun6i_isp_capture_state_update(struct sun6i_isp_device *isp_dev,
+				    bool *update);
+void sun6i_isp_capture_state_complete(struct sun6i_isp_device *isp_dev);
+void sun6i_isp_capture_finish(struct sun6i_isp_device *isp_dev);
+
+/* Capture */
+
+int sun6i_isp_capture_setup(struct sun6i_isp_device *isp_dev);
+void sun6i_isp_capture_cleanup(struct sun6i_isp_device *isp_dev);
+
+#endif
diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
new file mode 100644
index 000000000000..8039e311cb1c
--- /dev/null
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mc.h>
+#include <media/videobuf2-vmalloc.h>
+#include <media/videobuf2-v4l2.h>
+
+#include "sun6i_isp.h"
+#include "sun6i_isp_params.h"
+#include "sun6i_isp_reg.h"
+#include "uapi/sun6i-isp-config.h"
+
+/* Params */
+
+static const struct sun6i_isp_params_config sun6i_isp_params_config_default = {
+	.modules_used = SUN6I_ISP_MODULE_BAYER,
+
+	.bayer = {
+		.offset_r	= 32,
+		.offset_gr	= 32,
+		.offset_gb	= 32,
+		.offset_b	= 32,
+
+		.gain_r		= 256,
+		.gain_gr	= 256,
+		.gain_gb	= 256,
+		.gain_b		= 256,
+
+	},
+
+	.bdnf = {
+		.in_dis_min		= 8,
+		.in_dis_max		= 16,
+
+		.coefficients_g		= { 15, 4, 1 },
+		.coefficients_rb	= { 15, 4 },
+	},
+};
+
+static void sun6i_isp_params_configure_ob(struct sun6i_isp_device *isp_dev)
+{
+	unsigned int width, height;
+
+	sun6i_isp_proc_dimensions(isp_dev, &width, &height);
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_OB_SIZE_REG,
+			     SUN6I_ISP_OB_SIZE_WIDTH(width) |
+			     SUN6I_ISP_OB_SIZE_HEIGHT(height));
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_OB_VALID_REG,
+			     SUN6I_ISP_OB_VALID_WIDTH(width) |
+			     SUN6I_ISP_OB_VALID_HEIGHT(height));
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_OB_SRC0_VALID_START_REG,
+			     SUN6I_ISP_OB_SRC0_VALID_START_HORZ(0) |
+			     SUN6I_ISP_OB_SRC0_VALID_START_VERT(0));
+}
+
+static void sun6i_isp_params_configure_ae(struct sun6i_isp_device *isp_dev)
+{
+	/* These are default values that need to be set to get an output. */
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_AE_CFG_REG,
+			     SUN6I_ISP_AE_CFG_LOW_BRI_TH(0xff) |
+			     SUN6I_ISP_AE_CFG_HORZ_NUM(8) |
+			     SUN6I_ISP_AE_CFG_HIGH_BRI_TH(0xf00) |
+			     SUN6I_ISP_AE_CFG_VERT_NUM(8));
+}
+
+static void
+sun6i_isp_params_configure_bayer(struct sun6i_isp_device *isp_dev,
+				 const struct sun6i_isp_params_config *config)
+{
+	const struct sun6i_isp_params_config_bayer *bayer = &config->bayer;
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_BAYER_OFFSET0_REG,
+			     SUN6I_ISP_BAYER_OFFSET0_R(bayer->offset_r) |
+			     SUN6I_ISP_BAYER_OFFSET0_GR(bayer->offset_gr));
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_BAYER_OFFSET1_REG,
+			     SUN6I_ISP_BAYER_OFFSET1_GB(bayer->offset_gb) |
+			     SUN6I_ISP_BAYER_OFFSET1_B(bayer->offset_b));
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_BAYER_GAIN0_REG,
+			     SUN6I_ISP_BAYER_GAIN0_R(bayer->gain_r) |
+			     SUN6I_ISP_BAYER_GAIN0_GR(bayer->gain_gr));
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_BAYER_GAIN1_REG,
+			     SUN6I_ISP_BAYER_GAIN1_GB(bayer->gain_gb) |
+			     SUN6I_ISP_BAYER_GAIN1_B(bayer->gain_b));
+}
+
+static void sun6i_isp_params_configure_wb(struct sun6i_isp_device *isp_dev)
+{
+	/* These are default values that need to be set to get an output. */
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_WB_GAIN0_REG,
+			     SUN6I_ISP_WB_GAIN0_R(256) |
+			     SUN6I_ISP_WB_GAIN0_GR(256));
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_WB_GAIN1_REG,
+			     SUN6I_ISP_WB_GAIN1_GB(256) |
+			     SUN6I_ISP_WB_GAIN1_B(256));
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_WB_CFG_REG,
+			     SUN6I_ISP_WB_CFG_CLIP(0xfff));
+}
+
+static void sun6i_isp_params_configure_base(struct sun6i_isp_device *isp_dev)
+{
+	sun6i_isp_params_configure_ae(isp_dev);
+	sun6i_isp_params_configure_ob(isp_dev);
+	sun6i_isp_params_configure_wb(isp_dev);
+}
+
+static void
+sun6i_isp_params_configure_bdnf(struct sun6i_isp_device *isp_dev,
+				const struct sun6i_isp_params_config *config)
+{
+	const struct sun6i_isp_params_config_bdnf *bdnf = &config->bdnf;
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_BDNF_CFG_REG,
+			     SUN6I_ISP_BDNF_CFG_IN_DIS_MIN(bdnf->in_dis_min) |
+			     SUN6I_ISP_BDNF_CFG_IN_DIS_MAX(bdnf->in_dis_max));
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_BDNF_COEF_RB_REG,
+			     SUN6I_ISP_BDNF_COEF_RB(0, bdnf->coefficients_rb[0]) |
+			     SUN6I_ISP_BDNF_COEF_RB(1, bdnf->coefficients_rb[1]) |
+			     SUN6I_ISP_BDNF_COEF_RB(2, bdnf->coefficients_rb[2]) |
+			     SUN6I_ISP_BDNF_COEF_RB(3, bdnf->coefficients_rb[3]) |
+			     SUN6I_ISP_BDNF_COEF_RB(4, bdnf->coefficients_rb[4]));
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_BDNF_COEF_G_REG,
+			     SUN6I_ISP_BDNF_COEF_G(0, bdnf->coefficients_g[0]) |
+			     SUN6I_ISP_BDNF_COEF_G(1, bdnf->coefficients_g[1]) |
+			     SUN6I_ISP_BDNF_COEF_G(2, bdnf->coefficients_g[2]) |
+			     SUN6I_ISP_BDNF_COEF_G(3, bdnf->coefficients_g[3]) |
+			     SUN6I_ISP_BDNF_COEF_G(4, bdnf->coefficients_g[4]) |
+			     SUN6I_ISP_BDNF_COEF_G(5, bdnf->coefficients_g[5]) |
+			     SUN6I_ISP_BDNF_COEF_G(6, bdnf->coefficients_g[6]));
+}
+
+static void
+sun6i_isp_params_configure_modules(struct sun6i_isp_device *isp_dev,
+				   const struct sun6i_isp_params_config *config)
+{
+	u32 value;
+
+	if (config->modules_used & SUN6I_ISP_MODULE_BDNF)
+		sun6i_isp_params_configure_bdnf(isp_dev, config);
+
+	if (config->modules_used & SUN6I_ISP_MODULE_BAYER)
+		sun6i_isp_params_configure_bayer(isp_dev, config);
+
+	value = sun6i_isp_load_read(isp_dev, SUN6I_ISP_MODULE_EN_REG);
+	/* Clear all modules but keep input configuration. */
+	value &= SUN6I_ISP_MODULE_EN_SRC0 | SUN6I_ISP_MODULE_EN_SRC1;
+
+	if (config->modules_used & SUN6I_ISP_MODULE_BDNF)
+		value |= SUN6I_ISP_MODULE_EN_BDNF;
+
+	/* Bayer stage is always enabled. */
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MODULE_EN_REG, value);
+}
+
+void sun6i_isp_params_configure(struct sun6i_isp_device *isp_dev)
+{
+	struct sun6i_isp_params_state *state = &isp_dev->params.state;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	sun6i_isp_params_configure_base(isp_dev);
+
+	/* Default config is only applied at the very first stream start. */
+	if (state->configured)
+		goto complete;
+
+	 sun6i_isp_params_configure_modules(isp_dev,
+					    &sun6i_isp_params_config_default);
+
+	state->configured = true;
+
+complete:
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+
+/* State */
+
+static void sun6i_isp_params_state_cleanup(struct sun6i_isp_device *isp_dev,
+					   bool error)
+{
+	struct sun6i_isp_params_state *state = &isp_dev->params.state;
+	struct sun6i_isp_buffer *isp_buffer;
+	struct vb2_buffer *vb2_buffer;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	if (state->pending) {
+		vb2_buffer = &state->pending->v4l2_buffer.vb2_buf;
+		vb2_buffer_done(vb2_buffer, error ? VB2_BUF_STATE_ERROR :
+				VB2_BUF_STATE_QUEUED);
+	}
+
+	list_for_each_entry(isp_buffer, &state->queue, list) {
+		vb2_buffer = &isp_buffer->v4l2_buffer.vb2_buf;
+		vb2_buffer_done(vb2_buffer, error ? VB2_BUF_STATE_ERROR :
+				VB2_BUF_STATE_QUEUED);
+	}
+
+	INIT_LIST_HEAD(&state->queue);
+
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+
+void sun6i_isp_params_state_update(struct sun6i_isp_device *isp_dev,
+				   bool *update)
+{
+	struct sun6i_isp_params_state *state = &isp_dev->params.state;
+	struct sun6i_isp_buffer *isp_buffer;
+	struct vb2_buffer *vb2_buffer;
+	const struct sun6i_isp_params_config *config;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	if (list_empty(&state->queue))
+		goto complete;
+
+	if (state->pending)
+		goto complete;
+
+	isp_buffer = list_first_entry(&state->queue, struct sun6i_isp_buffer,
+				      list);
+
+	vb2_buffer = &isp_buffer->v4l2_buffer.vb2_buf;
+	config = vb2_plane_vaddr(vb2_buffer, 0);
+
+	sun6i_isp_params_configure_modules(isp_dev, config);
+
+	list_del(&isp_buffer->list);
+
+	state->pending = isp_buffer;
+
+	if (update)
+		*update = true;
+
+complete:
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+
+void sun6i_isp_params_state_complete(struct sun6i_isp_device *isp_dev)
+{
+	struct sun6i_isp_params_state *state = &isp_dev->params.state;
+	struct sun6i_isp_buffer *isp_buffer;
+	struct vb2_buffer *vb2_buffer;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	if (!state->pending)
+		goto complete;
+
+	isp_buffer = state->pending;
+	vb2_buffer = &isp_buffer->v4l2_buffer.vb2_buf;
+
+	vb2_buffer->timestamp = ktime_get_ns();
+
+	/* Parameters will be applied starting from the next frame. */
+	isp_buffer->v4l2_buffer.sequence = isp_dev->capture.state.sequence + 1;
+
+	vb2_buffer_done(vb2_buffer, VB2_BUF_STATE_DONE);
+
+	state->pending = NULL;
+
+complete:
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+
+/* Queue */
+
+static int sun6i_isp_params_queue_setup(struct vb2_queue *queue,
+					unsigned int *buffers_count,
+					unsigned int *planes_count,
+					unsigned int sizes[],
+					struct device *alloc_devs[])
+{
+	struct sun6i_isp_device *isp_dev = vb2_get_drv_priv(queue);
+	unsigned int size = isp_dev->params.format.fmt.meta.buffersize;
+
+	if (*planes_count)
+		return sizes[0] < size ? -EINVAL : 0;
+
+	*planes_count = 1;
+	sizes[0] = size;
+
+	return 0;
+}
+
+static int sun6i_isp_params_buffer_prepare(struct vb2_buffer *vb2_buffer)
+{
+	struct sun6i_isp_device *isp_dev =
+		vb2_get_drv_priv(vb2_buffer->vb2_queue);
+	struct v4l2_device *v4l2_dev = &isp_dev->v4l2.v4l2_dev;
+	unsigned int size = isp_dev->params.format.fmt.meta.buffersize;
+
+	if (vb2_plane_size(vb2_buffer, 0) < size) {
+		v4l2_err(v4l2_dev, "buffer too small (%lu < %u)\n",
+			 vb2_plane_size(vb2_buffer, 0), size);
+		return -EINVAL;
+	}
+
+	vb2_set_plane_payload(vb2_buffer, 0, size);
+
+	return 0;
+}
+
+static void sun6i_isp_params_buffer_queue(struct vb2_buffer *vb2_buffer)
+{
+	struct sun6i_isp_device *isp_dev =
+		vb2_get_drv_priv(vb2_buffer->vb2_queue);
+	struct sun6i_isp_params_state *state = &isp_dev->params.state;
+	struct vb2_v4l2_buffer *v4l2_buffer = to_vb2_v4l2_buffer(vb2_buffer);
+	struct sun6i_isp_buffer *isp_buffer =
+		container_of(v4l2_buffer, struct sun6i_isp_buffer, v4l2_buffer);
+	bool capture_streaming = isp_dev->capture.state.streaming;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state->lock, flags);
+	list_add_tail(&isp_buffer->list, &state->queue);
+	spin_unlock_irqrestore(&state->lock, flags);
+
+	if (state->streaming && capture_streaming)
+		sun6i_isp_state_update(isp_dev, false);
+}
+
+static int sun6i_isp_params_start_streaming(struct vb2_queue *queue,
+					    unsigned int count)
+{
+	struct sun6i_isp_device *isp_dev = vb2_get_drv_priv(queue);
+	struct sun6i_isp_params_state *state = &isp_dev->params.state;
+	bool capture_streaming = isp_dev->capture.state.streaming;
+
+	state->streaming = true;
+
+	/*
+	 * Update the state as soon as possible if capture is streaming,
+	 * otherwise it will be applied when capture starts streaming.
+	 */
+
+	if (capture_streaming)
+		sun6i_isp_state_update(isp_dev, false);
+
+	return 0;
+}
+
+static void sun6i_isp_params_stop_streaming(struct vb2_queue *queue)
+{
+	struct sun6i_isp_device *isp_dev = vb2_get_drv_priv(queue);
+	struct sun6i_isp_params_state *state = &isp_dev->params.state;
+
+	state->streaming = false;
+	sun6i_isp_params_state_cleanup(isp_dev, true);
+}
+
+static const struct vb2_ops sun6i_isp_params_queue_ops = {
+	.queue_setup		= sun6i_isp_params_queue_setup,
+	.buf_prepare		= sun6i_isp_params_buffer_prepare,
+	.buf_queue		= sun6i_isp_params_buffer_queue,
+	.start_streaming	= sun6i_isp_params_start_streaming,
+	.stop_streaming		= sun6i_isp_params_stop_streaming,
+	.wait_prepare		= vb2_ops_wait_prepare,
+	.wait_finish		= vb2_ops_wait_finish,
+};
+
+/* Video Device */
+
+static int sun6i_isp_params_querycap(struct file *file, void *private,
+				     struct v4l2_capability *capability)
+{
+	struct sun6i_isp_device *isp_dev = video_drvdata(file);
+	struct video_device *video_dev = &isp_dev->params.video_dev;
+
+	strscpy(capability->driver, SUN6I_ISP_NAME, sizeof(capability->driver));
+	strscpy(capability->card, video_dev->name, sizeof(capability->card));
+	snprintf(capability->bus_info, sizeof(capability->bus_info),
+		 "platform:%s", dev_name(isp_dev->dev));
+
+	return 0;
+}
+
+static int sun6i_isp_params_enum_fmt(struct file *file, void *private,
+				     struct v4l2_fmtdesc *fmtdesc)
+{
+	struct sun6i_isp_device *isp_dev = video_drvdata(file);
+	struct v4l2_meta_format *params_format =
+		&isp_dev->params.format.fmt.meta;
+
+	if (fmtdesc->index > 0)
+		return -EINVAL;
+
+	fmtdesc->pixelformat = params_format->dataformat;
+
+	return 0;
+}
+
+static int sun6i_isp_params_g_fmt(struct file *file, void *private,
+				  struct v4l2_format *format)
+{
+	struct sun6i_isp_device *isp_dev = video_drvdata(file);
+
+	*format = isp_dev->params.format;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops sun6i_isp_params_ioctl_ops = {
+	.vidioc_querycap		= sun6i_isp_params_querycap,
+
+	.vidioc_enum_fmt_meta_out	= sun6i_isp_params_enum_fmt,
+	.vidioc_g_fmt_meta_out		= sun6i_isp_params_g_fmt,
+	.vidioc_s_fmt_meta_out		= sun6i_isp_params_g_fmt,
+	.vidioc_try_fmt_meta_out	= sun6i_isp_params_g_fmt,
+
+	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf		= vb2_ioctl_prepare_buf,
+	.vidioc_reqbufs			= vb2_ioctl_reqbufs,
+	.vidioc_querybuf		= vb2_ioctl_querybuf,
+	.vidioc_expbuf			= vb2_ioctl_expbuf,
+	.vidioc_qbuf			= vb2_ioctl_qbuf,
+	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
+	.vidioc_streamon		= vb2_ioctl_streamon,
+	.vidioc_streamoff		= vb2_ioctl_streamoff,
+};
+
+static const struct v4l2_file_operations sun6i_isp_params_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= video_ioctl2,
+	.open		= v4l2_fh_open,
+	.release	= vb2_fop_release,
+	.mmap		= vb2_fop_mmap,
+	.poll		= vb2_fop_poll,
+};
+
+/* Params */
+
+int sun6i_isp_params_setup(struct sun6i_isp_device *isp_dev)
+{
+	struct sun6i_isp_params *params = &isp_dev->params;
+	struct sun6i_isp_params_state *state = &params->state;
+	struct v4l2_device *v4l2_dev = &isp_dev->v4l2.v4l2_dev;
+	struct v4l2_subdev *proc_subdev = &isp_dev->proc.subdev;
+	struct video_device *video_dev = &params->video_dev;
+	struct vb2_queue *queue = &isp_dev->params.queue;
+	struct media_pad *pad = &isp_dev->params.pad;
+	struct v4l2_format *format = &isp_dev->params.format;
+	struct v4l2_meta_format *params_format = &format->fmt.meta;
+	int ret;
+
+	/* State */
+
+	INIT_LIST_HEAD(&state->queue);
+	spin_lock_init(&state->lock);
+
+	/* Media Pads */
+
+	pad->flags = MEDIA_PAD_FL_SOURCE | MEDIA_PAD_FL_MUST_CONNECT;
+
+	ret = media_entity_pads_init(&video_dev->entity, 1, pad);
+	if (ret)
+		goto error_mutex;
+
+	/* Queue */
+
+	mutex_init(&params->lock);
+
+	queue->type = V4L2_BUF_TYPE_META_OUTPUT;
+	queue->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
+	queue->buf_struct_size = sizeof(struct sun6i_isp_buffer);
+	queue->ops = &sun6i_isp_params_queue_ops;
+	queue->mem_ops = &vb2_vmalloc_memops;
+	queue->min_buffers_needed = 1;
+	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	queue->lock = &params->lock;
+	queue->dev = isp_dev->dev;
+	queue->drv_priv = isp_dev;
+
+	ret = vb2_queue_init(queue);
+	if (ret) {
+		v4l2_err(v4l2_dev, "failed to initialize vb2 queue: %d\n", ret);
+		goto error_media_entity;
+	}
+
+	/* V4L2 Format */
+
+	format->type = queue->type;
+	params_format->dataformat = V4L2_META_FMT_SUN6I_ISP_PARAMS;
+	params_format->buffersize = sizeof(struct sun6i_isp_params_config);
+
+	/* Video Device */
+
+	strscpy(video_dev->name, SUN6I_ISP_PARAMS_NAME,
+		sizeof(video_dev->name));
+	video_dev->device_caps = V4L2_CAP_META_OUTPUT | V4L2_CAP_STREAMING;
+	video_dev->vfl_dir = VFL_DIR_TX;
+	video_dev->release = video_device_release_empty;
+	video_dev->fops = &sun6i_isp_params_fops;
+	video_dev->ioctl_ops = &sun6i_isp_params_ioctl_ops;
+	video_dev->v4l2_dev = v4l2_dev;
+	video_dev->queue = queue;
+	video_dev->lock = &params->lock;
+
+	video_set_drvdata(video_dev, isp_dev);
+
+	ret = video_register_device(video_dev, VFL_TYPE_VIDEO, -1);
+	if (ret) {
+		v4l2_err(v4l2_dev, "failed to register video device: %d\n",
+			 ret);
+		goto error_media_entity;
+	}
+
+	/* Media Pad Link */
+
+	ret = media_create_pad_link(&video_dev->entity, 0,
+				    &proc_subdev->entity,
+				    SUN6I_ISP_PROC_PAD_SINK_PARAMS,
+				    MEDIA_LNK_FL_ENABLED |
+				    MEDIA_LNK_FL_IMMUTABLE);
+	if (ret < 0) {
+		v4l2_err(v4l2_dev, "failed to create %s:%u -> %s:%u link\n",
+			 video_dev->entity.name, 0, proc_subdev->entity.name,
+			 SUN6I_ISP_PROC_PAD_SINK_PARAMS);
+		goto error_video_device;
+	}
+
+	return 0;
+
+error_video_device:
+	vb2_video_unregister_device(video_dev);
+
+error_media_entity:
+	media_entity_cleanup(&video_dev->entity);
+
+error_mutex:
+	mutex_destroy(&params->lock);
+
+	return ret;
+}
+
+void sun6i_isp_params_cleanup(struct sun6i_isp_device *isp_dev)
+{
+	struct sun6i_isp_params *params = &isp_dev->params;
+	struct video_device *video_dev = &params->video_dev;
+
+	vb2_video_unregister_device(video_dev);
+	media_entity_cleanup(&video_dev->entity);
+	mutex_destroy(&params->lock);
+}
diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.h b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.h
new file mode 100644
index 000000000000..50f10f879c42
--- /dev/null
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#ifndef _SUN6I_ISP_PARAMS_H_
+#define _SUN6I_ISP_PARAMS_H_
+
+#include <media/v4l2-device.h>
+
+#define SUN6I_ISP_PARAMS_NAME		"sun6i-isp-params"
+
+struct sun6i_isp_device;
+
+struct sun6i_isp_params_state {
+	struct list_head		queue; /* Queue and buffers lock. */
+	spinlock_t			lock;
+
+	struct sun6i_isp_buffer		*pending;
+
+	bool				configured;
+	bool				streaming;
+};
+
+struct sun6i_isp_params {
+	struct sun6i_isp_params_state	state;
+
+	struct video_device		video_dev;
+	struct vb2_queue		queue;
+	struct mutex			lock; /* Queue lock. */
+	struct media_pad		pad;
+
+	struct v4l2_format		format;
+};
+
+/* Params */
+
+void sun6i_isp_params_configure(struct sun6i_isp_device *isp_dev);
+
+/* State */
+
+void sun6i_isp_params_state_update(struct sun6i_isp_device *isp_dev,
+				   bool *update);
+void sun6i_isp_params_state_complete(struct sun6i_isp_device *isp_dev);
+
+/* Params */
+
+int sun6i_isp_params_setup(struct sun6i_isp_device *isp_dev);
+void sun6i_isp_params_cleanup(struct sun6i_isp_device *isp_dev);
+
+#endif
diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
new file mode 100644
index 000000000000..d69d2be0add2
--- /dev/null
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
@@ -0,0 +1,577 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
+
+#include "sun6i_isp.h"
+#include "sun6i_isp_capture.h"
+#include "sun6i_isp_params.h"
+#include "sun6i_isp_proc.h"
+#include "sun6i_isp_reg.h"
+
+/* Helpers */
+
+void sun6i_isp_proc_dimensions(struct sun6i_isp_device *isp_dev,
+			       unsigned int *width, unsigned int *height)
+{
+	if (width)
+		*width = isp_dev->proc.mbus_format.width;
+	if (height)
+		*height = isp_dev->proc.mbus_format.height;
+}
+
+/* Format */
+
+static const struct sun6i_isp_proc_format sun6i_isp_proc_formats[] = {
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR8_1X8,
+		.input_format	= SUN6I_ISP_INPUT_FMT_RAW_BGGR,
+	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG8_1X8,
+		.input_format	= SUN6I_ISP_INPUT_FMT_RAW_GBRG,
+	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG8_1X8,
+		.input_format	= SUN6I_ISP_INPUT_FMT_RAW_GRBG,
+	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB8_1X8,
+		.input_format	= SUN6I_ISP_INPUT_FMT_RAW_RGGB,
+	},
+
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
+		.input_format	= SUN6I_ISP_INPUT_FMT_RAW_BGGR,
+	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG10_1X10,
+		.input_format	= SUN6I_ISP_INPUT_FMT_RAW_GBRG,
+	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG10_1X10,
+		.input_format	= SUN6I_ISP_INPUT_FMT_RAW_GRBG,
+	},
+	{
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB10_1X10,
+		.input_format	= SUN6I_ISP_INPUT_FMT_RAW_RGGB,
+	},
+};
+
+const struct sun6i_isp_proc_format *sun6i_isp_proc_format_find(u32 mbus_code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sun6i_isp_proc_formats); i++)
+		if (sun6i_isp_proc_formats[i].mbus_code == mbus_code)
+			return &sun6i_isp_proc_formats[i];
+
+	return NULL;
+}
+
+/* Processor */
+
+static void sun6i_isp_proc_irq_enable(struct sun6i_isp_device *isp_dev)
+{
+	struct regmap *regmap = isp_dev->regmap;
+
+	regmap_write(regmap, SUN6I_ISP_FE_INT_EN_REG,
+		     SUN6I_ISP_FE_INT_EN_FINISH |
+		     SUN6I_ISP_FE_INT_EN_START |
+		     SUN6I_ISP_FE_INT_EN_PARA_SAVE |
+		     SUN6I_ISP_FE_INT_EN_PARA_LOAD |
+		     SUN6I_ISP_FE_INT_EN_SRC0_FIFO |
+		     SUN6I_ISP_FE_INT_EN_ROT_FINISH);
+}
+
+static void sun6i_isp_proc_irq_disable(struct sun6i_isp_device *isp_dev)
+{
+	struct regmap *regmap = isp_dev->regmap;
+
+	regmap_write(regmap, SUN6I_ISP_FE_INT_EN_REG, 0);
+}
+
+static void sun6i_isp_proc_irq_clear(struct sun6i_isp_device *isp_dev)
+{
+	struct regmap *regmap = isp_dev->regmap;
+
+	regmap_write(regmap, SUN6I_ISP_FE_INT_EN_REG, 0);
+	regmap_write(regmap, SUN6I_ISP_FE_INT_STA_REG,
+		     SUN6I_ISP_FE_INT_STA_CLEAR);
+}
+
+static void sun6i_isp_proc_enable(struct sun6i_isp_device *isp_dev,
+				  struct sun6i_isp_proc_source *source)
+{
+	struct sun6i_isp_proc *proc = &isp_dev->proc;
+	struct regmap *regmap = isp_dev->regmap;
+	u8 mode;
+
+	/* Frontend */
+
+	if (source == &proc->source_csi0)
+		mode = SUN6I_ISP_SRC_MODE_CSI(0);
+	else
+		mode = SUN6I_ISP_SRC_MODE_CSI(1);
+
+	regmap_write(regmap, SUN6I_ISP_FE_CFG_REG,
+		     SUN6I_ISP_FE_CFG_EN | SUN6I_ISP_FE_CFG_SRC0_MODE(mode));
+
+	regmap_write(regmap, SUN6I_ISP_FE_CTRL_REG,
+		     SUN6I_ISP_FE_CTRL_VCAP_EN | SUN6I_ISP_FE_CTRL_PARA_READY);
+}
+
+static void sun6i_isp_proc_disable(struct sun6i_isp_device *isp_dev)
+{
+	struct regmap *regmap = isp_dev->regmap;
+
+	/* Frontend */
+
+	regmap_write(regmap, SUN6I_ISP_FE_CTRL_REG, 0);
+	regmap_write(regmap, SUN6I_ISP_FE_CFG_REG, 0);
+}
+
+static void sun6i_isp_proc_configure(struct sun6i_isp_device *isp_dev)
+{
+	struct v4l2_mbus_framefmt *mbus_format = &isp_dev->proc.mbus_format;
+	const struct sun6i_isp_proc_format *format;
+	u32 value;
+
+	/* Module */
+
+	value = sun6i_isp_load_read(isp_dev, SUN6I_ISP_MODULE_EN_REG);
+	value |= SUN6I_ISP_MODULE_EN_SRC0;
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MODULE_EN_REG, value);
+
+	/* Input */
+
+	format = sun6i_isp_proc_format_find(mbus_format->code);
+	if (WARN_ON(!format))
+		return;
+
+	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MODE_REG,
+			     SUN6I_ISP_MODE_INPUT_FMT(format->input_format) |
+			     SUN6I_ISP_MODE_INPUT_YUV_SEQ(format->input_yuv_seq) |
+			     SUN6I_ISP_MODE_SHARP(1) |
+			     SUN6I_ISP_MODE_HIST(2));
+}
+
+/* V4L2 Subdev */
+
+static int sun6i_isp_proc_s_stream(struct v4l2_subdev *subdev, int on)
+{
+	struct sun6i_isp_device *isp_dev = v4l2_get_subdevdata(subdev);
+	struct sun6i_isp_proc *proc = &isp_dev->proc;
+	struct media_pad *local_pad = &proc->pads[SUN6I_ISP_PROC_PAD_SINK_CSI];
+	struct device *dev = isp_dev->dev;
+	struct sun6i_isp_proc_source *source;
+	struct v4l2_subdev *source_subdev;
+	struct media_pad *remote_pad;
+	/* Initialize to 0 to use both in disable label (ret != 0) and off. */
+	int ret = 0;
+
+	/* Source */
+
+	remote_pad = media_pad_remote_pad_unique(local_pad);
+	if (IS_ERR(remote_pad)) {
+		dev_err(dev,
+			"zero or more than a single source connected to the bridge\n");
+		return PTR_ERR(remote_pad);
+	}
+
+	source_subdev = media_entity_to_v4l2_subdev(remote_pad->entity);
+
+	if (source_subdev == proc->source_csi0.subdev)
+		source = &proc->source_csi0;
+	else
+		source = &proc->source_csi1;
+
+	if (!on) {
+		sun6i_isp_proc_irq_disable(isp_dev);
+		v4l2_subdev_call(source_subdev, video, s_stream, 0);
+		goto disable;
+	}
+
+	/* PM */
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	/* Clear */
+
+	sun6i_isp_proc_irq_clear(isp_dev);
+
+	/* Configure */
+
+	sun6i_isp_tables_configure(isp_dev);
+	sun6i_isp_params_configure(isp_dev);
+	sun6i_isp_proc_configure(isp_dev);
+	sun6i_isp_capture_configure(isp_dev);
+
+	/* State Update */
+
+	sun6i_isp_state_update(isp_dev, true);
+
+	/* Enable */
+
+	sun6i_isp_proc_irq_enable(isp_dev);
+	sun6i_isp_proc_enable(isp_dev, source);
+
+	ret = v4l2_subdev_call(source_subdev, video, s_stream, 1);
+	if (ret && ret != -ENOIOCTLCMD) {
+		sun6i_isp_proc_irq_disable(isp_dev);
+		goto disable;
+	}
+
+	return 0;
+
+disable:
+	sun6i_isp_proc_disable(isp_dev);
+
+	pm_runtime_put(dev);
+
+	return ret;
+}
+
+static const struct v4l2_subdev_video_ops sun6i_isp_proc_video_ops = {
+	.s_stream	= sun6i_isp_proc_s_stream,
+};
+
+static void
+sun6i_isp_proc_mbus_format_prepare(struct v4l2_mbus_framefmt *mbus_format)
+{
+	if (!sun6i_isp_proc_format_find(mbus_format->code))
+		mbus_format->code = sun6i_isp_proc_formats[0].mbus_code;
+
+	mbus_format->field = V4L2_FIELD_NONE;
+	mbus_format->colorspace = V4L2_COLORSPACE_RAW;
+	mbus_format->quantization = V4L2_QUANTIZATION_DEFAULT;
+	mbus_format->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+}
+
+static int sun6i_isp_proc_init_cfg(struct v4l2_subdev *subdev,
+				   struct v4l2_subdev_state *state)
+{
+	struct sun6i_isp_device *isp_dev = v4l2_get_subdevdata(subdev);
+	unsigned int pad = SUN6I_ISP_PROC_PAD_SINK_CSI;
+	struct v4l2_mbus_framefmt *mbus_format =
+		v4l2_subdev_get_try_format(subdev, state, pad);
+	struct mutex *lock = &isp_dev->proc.lock;
+
+	mutex_lock(lock);
+
+	mbus_format->code = sun6i_isp_proc_formats[0].mbus_code;
+	mbus_format->width = 1280;
+	mbus_format->height = 720;
+
+	sun6i_isp_proc_mbus_format_prepare(mbus_format);
+
+	mutex_unlock(lock);
+
+	return 0;
+}
+
+static int
+sun6i_isp_proc_enum_mbus_code(struct v4l2_subdev *subdev,
+			      struct v4l2_subdev_state *state,
+			      struct v4l2_subdev_mbus_code_enum *code_enum)
+{
+	if (code_enum->index >= ARRAY_SIZE(sun6i_isp_proc_formats))
+		return -EINVAL;
+
+	code_enum->code = sun6i_isp_proc_formats[code_enum->index].mbus_code;
+
+	return 0;
+}
+
+static int sun6i_isp_proc_get_fmt(struct v4l2_subdev *subdev,
+				  struct v4l2_subdev_state *state,
+				  struct v4l2_subdev_format *format)
+{
+	struct sun6i_isp_device *isp_dev = v4l2_get_subdevdata(subdev);
+	struct v4l2_mbus_framefmt *mbus_format = &format->format;
+	struct mutex *lock = &isp_dev->proc.lock;
+
+	mutex_lock(lock);
+
+	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
+		*mbus_format = *v4l2_subdev_get_try_format(subdev, state,
+							   format->pad);
+	else
+		*mbus_format = isp_dev->proc.mbus_format;
+
+	mutex_unlock(lock);
+
+	return 0;
+}
+
+static int sun6i_isp_proc_set_fmt(struct v4l2_subdev *subdev,
+				  struct v4l2_subdev_state *state,
+				  struct v4l2_subdev_format *format)
+{
+	struct sun6i_isp_device *isp_dev = v4l2_get_subdevdata(subdev);
+	struct v4l2_mbus_framefmt *mbus_format = &format->format;
+	struct mutex *lock = &isp_dev->proc.lock;
+
+	mutex_lock(lock);
+
+	sun6i_isp_proc_mbus_format_prepare(mbus_format);
+
+	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
+		*v4l2_subdev_get_try_format(subdev, state, format->pad) =
+			*mbus_format;
+	else
+		isp_dev->proc.mbus_format = *mbus_format;
+
+	mutex_unlock(lock);
+
+	return 0;
+}
+
+static const struct v4l2_subdev_pad_ops sun6i_isp_proc_pad_ops = {
+	.init_cfg	= sun6i_isp_proc_init_cfg,
+	.enum_mbus_code	= sun6i_isp_proc_enum_mbus_code,
+	.get_fmt	= sun6i_isp_proc_get_fmt,
+	.set_fmt	= sun6i_isp_proc_set_fmt,
+};
+
+const struct v4l2_subdev_ops sun6i_isp_proc_subdev_ops = {
+	.video	= &sun6i_isp_proc_video_ops,
+	.pad	= &sun6i_isp_proc_pad_ops,
+};
+
+/* Media Entity */
+
+static const struct media_entity_operations sun6i_isp_proc_entity_ops = {
+	.link_validate	= v4l2_subdev_link_validate,
+};
+
+/* V4L2 Async */
+
+static int sun6i_isp_proc_link(struct sun6i_isp_device *isp_dev,
+			       int sink_pad_index,
+			       struct v4l2_subdev *remote_subdev, bool enabled)
+{
+	struct device *dev = isp_dev->dev;
+	struct v4l2_subdev *subdev = &isp_dev->proc.subdev;
+	struct media_entity *sink_entity = &subdev->entity;
+	struct media_entity *source_entity = &remote_subdev->entity;
+	int source_pad_index;
+	int ret;
+
+	/* Get the first remote source pad. */
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
+				    enabled ? MEDIA_LNK_FL_ENABLED : 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to create %s:%u -> %s:%u link\n",
+			source_entity->name, source_pad_index,
+			sink_entity->name, sink_pad_index);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sun6i_isp_proc_notifier_bound(struct v4l2_async_notifier *notifier,
+					 struct v4l2_subdev *remote_subdev,
+					 struct v4l2_async_subdev *async_subdev)
+{
+	struct sun6i_isp_device *isp_dev =
+		container_of(notifier, struct sun6i_isp_device, proc.notifier);
+	struct sun6i_isp_proc_async_subdev *proc_async_subdev =
+		container_of(async_subdev, struct sun6i_isp_proc_async_subdev,
+			     async_subdev);
+	struct sun6i_isp_proc *proc = &isp_dev->proc;
+	struct sun6i_isp_proc_source *source = proc_async_subdev->source;
+	bool enabled;
+
+	switch (source->endpoint.base.port) {
+	case SUN6I_ISP_PORT_CSI0:
+		source = &proc->source_csi0;
+		enabled = true;
+		break;
+	case SUN6I_ISP_PORT_CSI1:
+		source = &proc->source_csi1;
+		enabled = !proc->source_csi0.expected;
+		break;
+	default:
+		break;
+	}
+
+	source->subdev = remote_subdev;
+
+	return sun6i_isp_proc_link(isp_dev, SUN6I_ISP_PROC_PAD_SINK_CSI,
+				   remote_subdev, enabled);
+}
+
+static int
+sun6i_isp_proc_notifier_complete(struct v4l2_async_notifier *notifier)
+{
+	struct sun6i_isp_device *isp_dev =
+		container_of(notifier, struct sun6i_isp_device, proc.notifier);
+	struct v4l2_device *v4l2_dev = &isp_dev->v4l2.v4l2_dev;
+	int ret;
+
+	ret = v4l2_device_register_subdev_nodes(v4l2_dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct v4l2_async_notifier_operations
+sun6i_isp_proc_notifier_ops = {
+	.bound		= sun6i_isp_proc_notifier_bound,
+	.complete	= sun6i_isp_proc_notifier_complete,
+};
+
+/* Processor */
+
+static int sun6i_isp_proc_source_setup(struct sun6i_isp_device *isp_dev,
+				       struct sun6i_isp_proc_source *source,
+				       u32 port)
+{
+	struct device *dev = isp_dev->dev;
+	struct v4l2_async_notifier *notifier = &isp_dev->proc.notifier;
+	struct v4l2_fwnode_endpoint *endpoint = &source->endpoint;
+	struct sun6i_isp_proc_async_subdev *proc_async_subdev;
+	struct fwnode_handle *handle = NULL;
+	int ret;
+
+	handle = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), port, 0, 0);
+	if (!handle)
+		return -ENODEV;
+
+	ret = v4l2_fwnode_endpoint_parse(handle, endpoint);
+	if (ret)
+		goto complete;
+
+	proc_async_subdev =
+		v4l2_async_nf_add_fwnode_remote(notifier, handle,
+						struct
+						sun6i_isp_proc_async_subdev);
+	if (IS_ERR(proc_async_subdev)) {
+		ret = PTR_ERR(proc_async_subdev);
+		goto complete;
+	}
+
+	proc_async_subdev->source = source;
+
+	source->expected = true;
+
+complete:
+	fwnode_handle_put(handle);
+
+	return ret;
+}
+
+int sun6i_isp_proc_setup(struct sun6i_isp_device *isp_dev)
+{
+	struct device *dev = isp_dev->dev;
+	struct sun6i_isp_proc *proc = &isp_dev->proc;
+	struct v4l2_device *v4l2_dev = &isp_dev->v4l2.v4l2_dev;
+	struct v4l2_async_notifier *notifier = &proc->notifier;
+	struct v4l2_subdev *subdev = &proc->subdev;
+	struct media_pad *pads = proc->pads;
+	int ret;
+
+	mutex_init(&proc->lock);
+
+	/* V4L2 Subdev */
+
+	v4l2_subdev_init(subdev, &sun6i_isp_proc_subdev_ops);
+	strscpy(subdev->name, SUN6I_ISP_PROC_NAME, sizeof(subdev->name));
+	subdev->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	subdev->owner = THIS_MODULE;
+	subdev->dev = dev;
+
+	v4l2_set_subdevdata(subdev, isp_dev);
+
+	/* Media Entity */
+
+	subdev->entity.function = MEDIA_ENT_F_PROC_VIDEO_ISP;
+	subdev->entity.ops = &sun6i_isp_proc_entity_ops;
+
+	/* Media Pads */
+
+	pads[SUN6I_ISP_PROC_PAD_SINK_CSI].flags = MEDIA_PAD_FL_SINK |
+						  MEDIA_PAD_FL_MUST_CONNECT;
+	pads[SUN6I_ISP_PROC_PAD_SINK_PARAMS].flags = MEDIA_PAD_FL_SINK |
+						     MEDIA_PAD_FL_MUST_CONNECT;
+	pads[SUN6I_ISP_PROC_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
+
+	ret = media_entity_pads_init(&subdev->entity, SUN6I_ISP_PROC_PAD_COUNT,
+				     pads);
+	if (ret)
+		return ret;
+
+	/* V4L2 Subdev */
+
+	ret = v4l2_device_register_subdev(v4l2_dev, subdev);
+	if (ret < 0) {
+		v4l2_err(v4l2_dev, "failed to register v4l2 subdev: %d\n", ret);
+		goto error_media_entity;
+	}
+
+	/* V4L2 Async */
+
+	v4l2_async_nf_init(notifier);
+	notifier->ops = &sun6i_isp_proc_notifier_ops;
+
+	sun6i_isp_proc_source_setup(isp_dev, &proc->source_csi0,
+				    SUN6I_ISP_PORT_CSI0);
+	sun6i_isp_proc_source_setup(isp_dev, &proc->source_csi1,
+				    SUN6I_ISP_PORT_CSI1);
+
+	ret = v4l2_async_nf_register(v4l2_dev, notifier);
+	if (ret) {
+		v4l2_err(v4l2_dev,
+			 "failed to register v4l2 async notifier: %d\n", ret);
+		goto error_v4l2_async_notifier;
+	}
+
+	return 0;
+
+error_v4l2_async_notifier:
+	v4l2_async_nf_cleanup(notifier);
+
+	v4l2_device_unregister_subdev(subdev);
+
+error_media_entity:
+	media_entity_cleanup(&subdev->entity);
+
+	return ret;
+}
+
+void sun6i_isp_proc_cleanup(struct sun6i_isp_device *isp_dev)
+{
+	struct v4l2_async_notifier *notifier = &isp_dev->proc.notifier;
+	struct v4l2_subdev *subdev = &isp_dev->proc.subdev;
+
+	v4l2_async_nf_unregister(notifier);
+	v4l2_async_nf_cleanup(notifier);
+
+	v4l2_device_unregister_subdev(subdev);
+	media_entity_cleanup(&subdev->entity);
+}
diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.h b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.h
new file mode 100644
index 000000000000..c5c274e21ad5
--- /dev/null
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#ifndef _SUN6I_ISP_PROC_H_
+#define _SUN6I_ISP_PROC_H_
+
+#include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
+
+#define SUN6I_ISP_PROC_NAME		"sun6i-isp-proc"
+
+enum sun6i_isp_proc_pad {
+	SUN6I_ISP_PROC_PAD_SINK_CSI	= 0,
+	SUN6I_ISP_PROC_PAD_SINK_PARAMS	= 1,
+	SUN6I_ISP_PROC_PAD_SOURCE	= 2,
+	SUN6I_ISP_PROC_PAD_COUNT	= 3,
+};
+
+struct sun6i_isp_device;
+
+struct sun6i_isp_proc_format {
+	u32	mbus_code;
+	u8	input_format;
+	u8	input_yuv_seq;
+};
+
+struct sun6i_isp_proc_source {
+	struct v4l2_subdev		*subdev;
+	struct v4l2_fwnode_endpoint	endpoint;
+	bool				expected;
+};
+
+struct sun6i_isp_proc_async_subdev {
+	struct v4l2_async_subdev	async_subdev;
+	struct sun6i_isp_proc_source	*source;
+};
+
+struct sun6i_isp_proc {
+	struct v4l2_subdev		subdev;
+	struct media_pad		pads[3];
+	struct v4l2_async_notifier	notifier;
+	struct v4l2_mbus_framefmt	mbus_format;
+	struct mutex			lock; /* Mbus format lock. */
+
+	struct sun6i_isp_proc_source	source_csi0;
+	struct sun6i_isp_proc_source	source_csi1;
+};
+
+/* Helpers */
+
+void sun6i_isp_proc_dimensions(struct sun6i_isp_device *isp_dev,
+			       unsigned int *width, unsigned int *height);
+
+/* Format */
+
+const struct sun6i_isp_proc_format *sun6i_isp_proc_format_find(u32 mbus_code);
+
+/* Proc */
+
+int sun6i_isp_proc_setup(struct sun6i_isp_device *isp_dev);
+void sun6i_isp_proc_cleanup(struct sun6i_isp_device *isp_dev);
+
+#endif
diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_reg.h b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_reg.h
new file mode 100644
index 000000000000..83b9cdab2134
--- /dev/null
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_reg.h
@@ -0,0 +1,275 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#ifndef _SUN6I_ISP_REG_H_
+#define _SUN6I_ISP_REG_H_
+
+#include <linux/kernel.h>
+
+#define SUN6I_ISP_ADDR_VALUE(a)			((a) >> 2)
+
+/* Frontend */
+
+#define SUN6I_ISP_SRC_MODE_DRAM			0
+#define SUN6I_ISP_SRC_MODE_CSI(n)		(1 + (n))
+
+#define SUN6I_ISP_FE_CFG_REG			0x0
+#define SUN6I_ISP_FE_CFG_EN			BIT(0)
+#define SUN6I_ISP_FE_CFG_SRC0_MODE(v)		(((v) << 8) & GENMASK(9, 8))
+#define SUN6I_ISP_FE_CFG_SRC1_MODE(v)		(((v) << 16) & GENMASK(17, 16))
+
+#define SUN6I_ISP_FE_CTRL_REG			0x4
+#define SUN6I_ISP_FE_CTRL_SCAP_EN		BIT(0)
+#define SUN6I_ISP_FE_CTRL_VCAP_EN		BIT(1)
+#define SUN6I_ISP_FE_CTRL_PARA_READY		BIT(2)
+#define SUN6I_ISP_FE_CTRL_LUT_UPDATE		BIT(3)
+#define SUN6I_ISP_FE_CTRL_LENS_UPDATE		BIT(4)
+#define SUN6I_ISP_FE_CTRL_GAMMA_UPDATE		BIT(5)
+#define SUN6I_ISP_FE_CTRL_DRC_UPDATE		BIT(6)
+#define SUN6I_ISP_FE_CTRL_DISC_UPDATE		BIT(7)
+#define SUN6I_ISP_FE_CTRL_OUTPUT_SPEED_CTRL(v)	(((v) << 16) & GENMASK(17, 16))
+#define SUN6I_ISP_FE_CTRL_VCAP_READ_START	BIT(31)
+
+#define SUN6I_ISP_FE_INT_EN_REG			0x8
+#define SUN6I_ISP_FE_INT_EN_FINISH		BIT(0)
+#define SUN6I_ISP_FE_INT_EN_START		BIT(1)
+#define SUN6I_ISP_FE_INT_EN_PARA_SAVE		BIT(2)
+#define SUN6I_ISP_FE_INT_EN_PARA_LOAD		BIT(3)
+#define SUN6I_ISP_FE_INT_EN_SRC0_FIFO		BIT(4)
+#define SUN6I_ISP_FE_INT_EN_SRC1_FIFO		BIT(5)
+#define SUN6I_ISP_FE_INT_EN_ROT_FINISH		BIT(6)
+#define SUN6I_ISP_FE_INT_EN_LINE_NUM_START	BIT(7)
+
+#define SUN6I_ISP_FE_INT_STA_REG		0xc
+#define SUN6I_ISP_FE_INT_STA_CLEAR		0xff
+#define SUN6I_ISP_FE_INT_STA_FINISH		BIT(0)
+#define SUN6I_ISP_FE_INT_STA_START		BIT(1)
+#define SUN6I_ISP_FE_INT_STA_PARA_SAVE		BIT(2)
+#define SUN6I_ISP_FE_INT_STA_PARA_LOAD		BIT(3)
+#define SUN6I_ISP_FE_INT_STA_SRC0_FIFO		BIT(4)
+#define SUN6I_ISP_FE_INT_STA_SRC1_FIFO		BIT(5)
+#define SUN6I_ISP_FE_INT_STA_ROT_FINISH		BIT(6)
+#define SUN6I_ISP_FE_INT_STA_LINE_NUM_START	BIT(7)
+
+/* Only since sun9i-a80-isp. */
+#define SUN6I_ISP_FE_INT_LINE_NUM_REG		0x18
+#define SUN6I_ISP_FE_ROT_OF_CFG_REG		0x1c
+
+/* Buffers/tables */
+
+#define SUN6I_ISP_REG_LOAD_ADDR_REG		0x20
+#define SUN6I_ISP_REG_SAVE_ADDR_REG		0x24
+
+#define SUN6I_ISP_LUT_TABLE_ADDR_REG		0x28
+#define SUN6I_ISP_DRC_TABLE_ADDR_REG		0x2c
+#define SUN6I_ISP_STATS_ADDR_REG		0x30
+
+/* SRAM */
+
+#define SUN6I_ISP_SRAM_RW_OFFSET_REG		0x38
+#define SUN6I_ISP_SRAM_RW_DATA_REG		0x3c
+
+/* Global */
+
+#define SUN6I_ISP_MODULE_EN_REG			0x40
+#define SUN6I_ISP_MODULE_EN_AE			BIT(0)
+#define SUN6I_ISP_MODULE_EN_OBC			BIT(1)
+#define SUN6I_ISP_MODULE_EN_DPC_LUT		BIT(2)
+#define SUN6I_ISP_MODULE_EN_DPC_OTF		BIT(3)
+#define SUN6I_ISP_MODULE_EN_BDNF		BIT(4)
+#define SUN6I_ISP_MODULE_EN_AWB			BIT(6)
+#define SUN6I_ISP_MODULE_EN_WB			BIT(7)
+#define SUN6I_ISP_MODULE_EN_LSC			BIT(8)
+#define SUN6I_ISP_MODULE_EN_BGC			BIT(9)
+#define SUN6I_ISP_MODULE_EN_SAP			BIT(10)
+#define SUN6I_ISP_MODULE_EN_AF			BIT(11)
+#define SUN6I_ISP_MODULE_EN_RGB2RGB		BIT(12)
+#define SUN6I_ISP_MODULE_EN_RGB_DRC		BIT(13)
+#define SUN6I_ISP_MODULE_EN_TDNF		BIT(15)
+#define SUN6I_ISP_MODULE_EN_AFS			BIT(16)
+#define SUN6I_ISP_MODULE_EN_HIST		BIT(17)
+#define SUN6I_ISP_MODULE_EN_YUV_GAIN_OFFSET	BIT(18)
+#define SUN6I_ISP_MODULE_EN_YUV_DRC		BIT(19)
+#define SUN6I_ISP_MODULE_EN_TG			BIT(20)
+#define SUN6I_ISP_MODULE_EN_ROT			BIT(21)
+#define SUN6I_ISP_MODULE_EN_CONTRAST		BIT(22)
+#define SUN6I_ISP_MODULE_EN_SATU		BIT(24)
+#define SUN6I_ISP_MODULE_EN_SRC1		BIT(30)
+#define SUN6I_ISP_MODULE_EN_SRC0		BIT(31)
+
+#define SUN6I_ISP_MODE_REG			0x44
+#define SUN6I_ISP_MODE_INPUT_FMT(v)		((v) & GENMASK(2, 0))
+#define SUN6I_ISP_MODE_INPUT_YUV_SEQ(v)		(((v) << 3) & GENMASK(4, 3))
+#define SUN6I_ISP_MODE_OTF_DPC(v)		(((v) << 16) & BIT(16))
+#define SUN6I_ISP_MODE_SHARP(v)			(((v) << 17) & BIT(17))
+#define SUN6I_ISP_MODE_HIST(v)			(((v) << 20) & GENMASK(21, 20))
+
+#define SUN6I_ISP_INPUT_FMT_YUV420		0
+#define SUN6I_ISP_INPUT_FMT_YUV422		1
+#define SUN6I_ISP_INPUT_FMT_RAW_BGGR		4
+#define SUN6I_ISP_INPUT_FMT_RAW_RGGB		5
+#define SUN6I_ISP_INPUT_FMT_RAW_GBRG		6
+#define SUN6I_ISP_INPUT_FMT_RAW_GRBG		7
+
+#define SUN6I_ISP_INPUT_YUV_SEQ_YUYV		0
+#define SUN6I_ISP_INPUT_YUV_SEQ_YVYU		1
+#define SUN6I_ISP_INPUT_YUV_SEQ_UYVY		2
+#define SUN6I_ISP_INPUT_YUV_SEQ_VYUY		3
+
+#define SUN6I_ISP_IN_CFG_REG			0x48
+#define SUN6I_ISP_IN_CFG_STRIDE_DIV16(v)	((v) & GENMASK(10, 0))
+
+#define SUN6I_ISP_IN_LUMA_RGB_ADDR0_REG		0x4c
+#define SUN6I_ISP_IN_CHROMA_ADDR0_REG		0x50
+#define SUN6I_ISP_IN_LUMA_RGB_ADDR1_REG		0x54
+#define SUN6I_ISP_IN_CHROMA_ADDR1_REG		0x58
+
+/* AE */
+
+#define SUN6I_ISP_AE_CFG_REG			0x60
+#define SUN6I_ISP_AE_CFG_LOW_BRI_TH(v)		((v) & GENMASK(11, 0))
+#define SUN6I_ISP_AE_CFG_HORZ_NUM(v)		(((v) << 12) & GENMASK(15, 12))
+#define SUN6I_ISP_AE_CFG_HIGH_BRI_TH(v)		(((v) << 16) & GENMASK(27, 16))
+#define SUN6I_ISP_AE_CFG_VERT_NUM(v)		(((v) << 28) & GENMASK(31, 28))
+
+#define SUN6I_ISP_AE_SIZE_REG			0x64
+#define SUN6I_ISP_AE_SIZE_WIDTH(v)		((v) & GENMASK(10, 0))
+#define SUN6I_ISP_AE_SIZE_HEIGHT(v)		(((v) << 16) & GENMASK(26, 16))
+
+#define SUN6I_ISP_AE_POS_REG			0x68
+#define SUN6I_ISP_AE_POS_HORZ_START(v)		((v) & GENMASK(10, 0))
+#define SUN6I_ISP_AE_POS_VERT_START(v)		(((v) << 16) & GENMASK(26, 16))
+
+/* OB */
+
+#define SUN6I_ISP_OB_SIZE_REG			0x78
+#define SUN6I_ISP_OB_SIZE_WIDTH(v)		((v) & GENMASK(13, 0))
+#define SUN6I_ISP_OB_SIZE_HEIGHT(v)		(((v) << 16) & GENMASK(29, 16))
+
+#define SUN6I_ISP_OB_VALID_REG			0x7c
+#define SUN6I_ISP_OB_VALID_WIDTH(v)		((v) & GENMASK(12, 0))
+#define SUN6I_ISP_OB_VALID_HEIGHT(v)		(((v) << 16) & GENMASK(28, 16))
+
+#define SUN6I_ISP_OB_SRC0_VALID_START_REG	0x80
+#define SUN6I_ISP_OB_SRC0_VALID_START_HORZ(v)	((v) & GENMASK(11, 0))
+#define SUN6I_ISP_OB_SRC0_VALID_START_VERT(v)	(((v) << 16) & GENMASK(27, 16))
+
+#define SUN6I_ISP_OB_SRC1_VALID_START_REG	0x84
+#define SUN6I_ISP_OB_SRC1_VALID_START_HORZ(v)	((v) & GENMASK(11, 0))
+#define SUN6I_ISP_OB_SRC1_VALID_START_VERT(v)	(((v) << 16) & GENMASK(27, 16))
+
+#define SUN6I_ISP_OB_SPRITE_REG			0x88
+#define SUN6I_ISP_OB_SPRITE_WIDTH(v)		((v) & GENMASK(12, 0))
+#define SUN6I_ISP_OB_SPRITE_HEIGHT(v)		(((v) << 16) & GENMASK(28, 16))
+
+#define SUN6I_ISP_OB_SPRITE_START_REG		0x8c
+#define SUN6I_ISP_OB_SPRITE_START_HORZ(v)	((v) & GENMASK(11, 0))
+#define SUN6I_ISP_OB_SPRITE_START_VERT(v)	(((v) << 16) & GENMASK(27, 16))
+
+#define SUN6I_ISP_OB_CFG_REG			0x90
+#define SUN6I_ISP_OB_HORZ_POS_REG		0x94
+#define SUN6I_ISP_OB_VERT_PARA_REG		0x98
+#define SUN6I_ISP_OB_OFFSET_FIXED_REG		0x9c
+
+/* BDNF */
+
+#define SUN6I_ISP_BDNF_CFG_REG			0xcc
+#define SUN6I_ISP_BDNF_CFG_IN_DIS_MIN(v)	((v) & GENMASK(7, 0))
+#define SUN6I_ISP_BDNF_CFG_IN_DIS_MAX(v)	(((v) << 16) & GENMASK(23, 16))
+
+#define SUN6I_ISP_BDNF_COEF_RB_REG		0xd0
+#define SUN6I_ISP_BDNF_COEF_RB(i, v)		(((v) << (4 * (i))) & \
+						 GENMASK(4 * (i) + 3, 4 * (i)))
+
+#define SUN6I_ISP_BDNF_COEF_G_REG		0xd4
+#define SUN6I_ISP_BDNF_COEF_G(i, v)		(((v) << (4 * (i))) & \
+						 GENMASK(4 * (i) + 3, 4 * (i)))
+
+/* Bayer */
+
+#define SUN6I_ISP_BAYER_OFFSET0_REG		0xe0
+#define SUN6I_ISP_BAYER_OFFSET0_R(v)		((v) & GENMASK(12, 0))
+#define SUN6I_ISP_BAYER_OFFSET0_GR(v)		(((v) << 16) & GENMASK(28, 16))
+
+#define SUN6I_ISP_BAYER_OFFSET1_REG		0xe4
+#define SUN6I_ISP_BAYER_OFFSET1_GB(v)		((v) & GENMASK(12, 0))
+#define SUN6I_ISP_BAYER_OFFSET1_B(v)		(((v) << 16) & GENMASK(28, 16))
+
+#define SUN6I_ISP_BAYER_GAIN0_REG		0xe8
+#define SUN6I_ISP_BAYER_GAIN0_R(v)		((v) & GENMASK(11, 0))
+#define SUN6I_ISP_BAYER_GAIN0_GR(v)		(((v) << 16) & GENMASK(27, 16))
+
+#define SUN6I_ISP_BAYER_GAIN1_REG		0xec
+#define SUN6I_ISP_BAYER_GAIN1_GB(v)		((v) & GENMASK(11, 0))
+#define SUN6I_ISP_BAYER_GAIN1_B(v)		(((v) << 16) & GENMASK(27, 16))
+
+/* WB */
+
+#define SUN6I_ISP_WB_GAIN0_REG			0x140
+#define SUN6I_ISP_WB_GAIN0_R(v)			((v) & GENMASK(11, 0))
+#define SUN6I_ISP_WB_GAIN0_GR(v)		(((v) << 16) & GENMASK(27, 16))
+
+#define SUN6I_ISP_WB_GAIN1_REG			0x144
+#define SUN6I_ISP_WB_GAIN1_GB(v)		((v) & GENMASK(11, 0))
+#define SUN6I_ISP_WB_GAIN1_B(v)			(((v) << 16) & GENMASK(27, 16))
+
+#define SUN6I_ISP_WB_CFG_REG			0x148
+#define SUN6I_ISP_WB_CFG_CLIP(v)		((v) & GENMASK(11, 0))
+
+/* Global */
+
+#define SUN6I_ISP_MCH_SIZE_CFG_REG		0x1e0
+#define SUN6I_ISP_MCH_SIZE_CFG_WIDTH(v)		((v) & GENMASK(12, 0))
+#define SUN6I_ISP_MCH_SIZE_CFG_HEIGHT(v)	(((v) << 16) & GENMASK(28, 16))
+
+#define SUN6I_ISP_MCH_SCALE_CFG_REG		0x1e4
+#define SUN6I_ISP_MCH_SCALE_CFG_X_RATIO(v)	((v) & GENMASK(11, 0))
+#define SUN6I_ISP_MCH_SCALE_CFG_Y_RATIO(v)	(((v) << 16) & GENMASK(27, 16))
+#define SUN6I_ISP_MCH_SCALE_CFG_WEIGHT_SHIFT(v)	(((v) << 28) & GENMASK(31, 28))
+
+#define SUN6I_ISP_SCH_SIZE_CFG_REG		0x1e8
+#define SUN6I_ISP_SCH_SIZE_CFG_WIDTH(v)		((v) & GENMASK(12, 0))
+#define SUN6I_ISP_SCH_SIZE_CFG_HEIGHT(v)	(((v) << 16) & GENMASK(28, 16))
+
+#define SUN6I_ISP_SCH_SCALE_CFG_REG		0x1ec
+#define SUN6I_ISP_SCH_SCALE_CFG_X_RATIO(v)	((v) & GENMASK(11, 0))
+#define SUN6I_ISP_SCH_SCALE_CFG_Y_RATIO(v)	(((v) << 16) & GENMASK(27, 16))
+#define SUN6I_ISP_SCH_SCALE_CFG_WEIGHT_SHIFT(v)	(((v) << 28) & GENMASK(31, 28))
+
+#define SUN6I_ISP_MCH_CFG_REG			0x1f0
+#define SUN6I_ISP_MCH_CFG_EN			BIT(0)
+#define SUN6I_ISP_MCH_CFG_SCALE_EN		BIT(1)
+#define SUN6I_ISP_MCH_CFG_OUTPUT_FMT(v)		(((v) << 2) & GENMASK(4, 2))
+#define SUN6I_ISP_MCH_CFG_MIRROR_EN		BIT(5)
+#define SUN6I_ISP_MCH_CFG_FLIP_EN		BIT(6)
+#define SUN6I_ISP_MCH_CFG_STRIDE_Y_DIV4(v)	(((v) << 8) & GENMASK(18, 8))
+#define SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4(v)	(((v) << 20) & GENMASK(30, 20))
+
+#define SUN6I_ISP_OUTPUT_FMT_YUV420SP		0
+#define SUN6I_ISP_OUTPUT_FMT_YUV422SP		1
+#define SUN6I_ISP_OUTPUT_FMT_YVU420SP		2
+#define SUN6I_ISP_OUTPUT_FMT_YVU422SP		3
+#define SUN6I_ISP_OUTPUT_FMT_YUV420P		4
+#define SUN6I_ISP_OUTPUT_FMT_YUV422P		5
+#define SUN6I_ISP_OUTPUT_FMT_YVU420P		6
+#define SUN6I_ISP_OUTPUT_FMT_YVU422P		7
+
+#define SUN6I_ISP_SCH_CFG_REG			0x1f4
+
+#define SUN6I_ISP_MCH_Y_ADDR0_REG		0x1f8
+#define SUN6I_ISP_MCH_U_ADDR0_REG		0x1fc
+#define SUN6I_ISP_MCH_V_ADDR0_REG		0x200
+#define SUN6I_ISP_MCH_Y_ADDR1_REG		0x204
+#define SUN6I_ISP_MCH_U_ADDR1_REG		0x208
+#define SUN6I_ISP_MCH_V_ADDR1_REG		0x20c
+#define SUN6I_ISP_SCH_Y_ADDR0_REG		0x210
+#define SUN6I_ISP_SCH_U_ADDR0_REG		0x214
+#define SUN6I_ISP_SCH_V_ADDR0_REG		0x218
+#define SUN6I_ISP_SCH_Y_ADDR1_REG		0x21c
+#define SUN6I_ISP_SCH_U_ADDR1_REG		0x220
+#define SUN6I_ISP_SCH_V_ADDR1_REG		0x224
+
+#endif
diff --git a/drivers/staging/media/sunxi/sun6i-isp/uapi/sun6i-isp-config.h b/drivers/staging/media/sunxi/sun6i-isp/uapi/sun6i-isp-config.h
new file mode 100644
index 000000000000..19c24c5fd322
--- /dev/null
+++ b/drivers/staging/media/sunxi/sun6i-isp/uapi/sun6i-isp-config.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR MIT) */
+/*
+ * Allwinner A31 ISP Configuration
+ */
+
+#ifndef _UAPI_SUN6I_ISP_CONFIG_H
+#define _UAPI_SUN6I_ISP_CONFIG_H
+
+#include <linux/types.h>
+
+#define V4L2_META_FMT_SUN6I_ISP_PARAMS v4l2_fourcc('S', '6', 'I', 'P') /* Allwinner A31 ISP Parameters */
+
+#define SUN6I_ISP_MODULE_BAYER			(1U << 0)
+#define SUN6I_ISP_MODULE_BDNF			(1U << 1)
+
+struct sun6i_isp_params_config_bayer {
+	__u16	offset_r;
+	__u16	offset_gr;
+	__u16	offset_gb;
+	__u16	offset_b;
+
+	__u16	gain_r;
+	__u16	gain_gr;
+	__u16	gain_gb;
+	__u16	gain_b;
+};
+
+struct sun6i_isp_params_config_bdnf {
+	__u8	in_dis_min;
+	__u8	in_dis_max;
+
+	__u8	coefficients_g[7];
+	__u8	coefficients_rb[5];
+};
+
+struct sun6i_isp_params_config {
+	__u32					modules_used;
+
+	struct sun6i_isp_params_config_bayer	bayer;
+	struct sun6i_isp_params_config_bdnf	bdnf;
+};
+
+#endif /* _UAPI_SUN6I_ISP_CONFIG_H */
-- 
2.37.1

