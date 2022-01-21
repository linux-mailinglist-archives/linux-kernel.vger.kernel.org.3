Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9447749579C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiAUBGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:06:22 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:19483 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235635AbiAUBGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:06:18 -0500
X-IronPort-AV: E=Sophos;i="5.88,303,1635174000"; 
   d="scan'208";a="107750945"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Jan 2022 10:06:17 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id C84404177B49;
        Fri, 21 Jan 2022 10:06:13 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH v2 4/4] media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver
Date:   Fri, 21 Jan 2022 01:05:43 +0000
Message-Id: <20220121010543.31385-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MIPI CSI-2 receiver driver for Renesas RZ/G2L. The MIPI
CSI-2 is part of the CRU module found on RZ/G2L family.

Based on a patch in the BSP by Hien Huynh
<hien.huynh.px@renesas.com>

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi Laurent,

The CSI subdev uses multistream and subdev state patches. Only pending thing
is the driver implements multiple pads for VC's (which should be only one)
Im working on the ov5645 sensor to use multistream to support VC's.
For the next non-RFC version I'll implement as single pad for all VC's.

Cheers,
Prabhakar

v1->v2
* new patch (split up as new driver compared to v1)
---
 .../media/platform/renesas/rzg2l-cru/Kconfig  |  13 +
 .../media/platform/renesas/rzg2l-cru/Makefile |   1 +
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 928 ++++++++++++++++++
 3 files changed, 942 insertions(+)
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c

diff --git a/drivers/media/platform/renesas/rzg2l-cru/Kconfig b/drivers/media/platform/renesas/rzg2l-cru/Kconfig
index 310baa4d4c14..91a9617b44ec 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/Kconfig
+++ b/drivers/media/platform/renesas/rzg2l-cru/Kconfig
@@ -1,4 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
+config VIDEO_RZG2L_CSI2
+	tristate "RZ/G2L MIPI CSI-2 Receiver"
+	depends on VIDEO_V4L2 && OF
+	depends on ARCH_RENESAS || COMPILE_TEST
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select RESET_CONTROLLER
+	select V4L2_FWNODE
+	help
+	  Support for Renesas RZ/G2L MIPI CSI-2 Receiver driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rzg2l-csi2.
 
 config VIDEO_RZG2L_CRU
 	tristate "RZ/G2L Camera Receiving Unit (CRU) Driver"
diff --git a/drivers/media/platform/renesas/rzg2l-cru/Makefile b/drivers/media/platform/renesas/rzg2l-cru/Makefile
index 8c307075f131..8cb4f4550df9 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/Makefile
+++ b/drivers/media/platform/renesas/rzg2l-cru/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 rzg2l-cru-objs = rzg2l-core.o rzg2l-dma.o rzg2l-v4l2.o
 
+obj-$(CONFIG_VIDEO_RZG2L_CSI2) += rzg2l-csi2.o
 obj-$(CONFIG_VIDEO_RZG2L_CRU) += rzg2l-cru.o
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
new file mode 100644
index 000000000000..ae27c9504c50
--- /dev/null
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -0,0 +1,928 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Renesas RZ/G2L MIPI CSI-2 Receiver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/sys_soc.h>
+#include <linux/units.h>
+
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-mc.h>
+#include <media/v4l2-subdev.h>
+
+/* LINK registers */
+/* Module Configuration Register */
+#define CSI2nMCG			0x0
+#define CSI2nMCG_SDLN			GENMASK(11, 8)
+
+/* Module Control Register 0 */
+#define CSI2nMCT0			0x10
+#define CSI2nMCT0_VDLN(x)		((x) << 0)
+
+/* Module Control Register 2 */
+#define CSI2nMCT2			0x18
+#define CSI2nMCT2_FRRSKW(x)		((x) << 16)
+#define CSI2nMCT2_FRRCLK(x)		((x) << 0)
+
+/* Module Control Register 3 */
+#define CSI2nMCT3			0x1c
+#define CSI2nMCT3_RXEN			BIT(0)
+
+/* Reset Control Register */
+#define CSI2nRTCT			0x28
+#define CSI2nRTCT_VSRST			BIT(0)
+
+/* Reset Status Register */
+#define CSI2nRTST			0x2c
+#define CSI2nRTST_VSRSTS		BIT(0)
+
+/* Receive Data Type Enable Low Register */
+#define CSI2nDTEL			0x60
+
+/* Receive Data Type Enable High Register */
+#define CSI2nDTEH			0x64
+
+/* DPHY registers */
+/* D-PHY Control Register 0 */
+#define CSIDPHYCTRL0			0x400
+#define CSIDPHYCTRL0_EN_LDO1200		BIT(1)
+#define CSIDPHYCTRL0_EN_BGR		BIT(0)
+
+/* D-PHY Timing Register 0 */
+#define CSIDPHYTIM0			0x404
+#define CSIDPHYTIM0_TCLK_MISS(x)	((x) << 24)
+#define CSIDPHYTIM0_T_INIT(x)		((x) << 0)
+
+/* D-PHY Timing Register 1 */
+#define CSIDPHYTIM1			0x408
+#define CSIDPHYTIM1_THS_PREPARE(x)	((x) << 24)
+#define CSIDPHYTIM1_TCLK_PREPARE(x)	((x) << 16)
+#define CSIDPHYTIM1_THS_SETTLE(x)	((x) << 8)
+
+#define VSRSTS_TIMEOUT_MS		100
+#define VSRSTS_RETRIES			20
+
+struct timings {
+	u32 t_init;
+	u32 tclk_miss;
+	u32 tclk_settle;
+	u32 ths_settle;
+	u32 tclk_prepare;
+	u32 ths_prepare;
+};
+
+enum dphy_timings {
+	TRANSMISSION_RATE_80_MBPS = 0,
+	TRANSMISSION_RATE_125_MBPS,
+	TRANSMISSION_RATE_250_MBPS,
+	TRANSMISSION_RATE_360_MBPS,
+	TRANSMISSION_RATE_360_PLUS_MBPS,
+};
+
+static const struct timings global_timings[] = {
+	[TRANSMISSION_RATE_80_MBPS] = {
+		.t_init = 79801,
+		.tclk_miss = 4,
+		.tclk_settle = 23,
+		.ths_settle = 31,
+		.tclk_prepare = 10,
+		.ths_prepare = 19,
+	},
+	[TRANSMISSION_RATE_125_MBPS] = {
+		.t_init = 79801,
+		.tclk_miss = 4,
+		.tclk_settle = 23,
+		.ths_settle = 28,
+		.tclk_prepare = 10,
+		.ths_prepare = 19,
+	},
+	[TRANSMISSION_RATE_250_MBPS] = {
+		.t_init = 79801,
+		.tclk_miss = 4,
+		.tclk_settle = 23,
+		.ths_settle = 22,
+		.tclk_prepare = 10,
+		.ths_prepare = 16,
+	},
+	[TRANSMISSION_RATE_360_MBPS] = {
+		.t_init = 79801,
+		.tclk_miss = 4,
+		.tclk_settle = 18,
+		.ths_settle = 19,
+		.tclk_prepare = 10,
+		.ths_prepare = 10,
+	},
+	[TRANSMISSION_RATE_360_PLUS_MBPS] = {
+		.t_init = 79801,
+		.tclk_miss = 4,
+		.tclk_settle = 18,
+		.ths_settle = 18,
+		.tclk_prepare = 10,
+		.ths_prepare = 10,
+	},
+};
+
+struct rzg2l_csi2_format {
+	u32 code;
+	unsigned int datatype;
+	unsigned int bpp;
+};
+
+static const struct rzg2l_csi2_format rzg2l_csi2_formats[] = {
+	{ .code = MEDIA_BUS_FMT_UYVY8_2X8,	.datatype = 0x1e, .bpp = 16 },
+};
+
+static const struct rzg2l_csi2_format *rzg2l_csi2_code_to_fmt(unsigned int code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(rzg2l_csi2_formats); i++)
+		if (rzg2l_csi2_formats[i].code == code)
+			return &rzg2l_csi2_formats[i];
+
+	return NULL;
+}
+
+static const struct rzg2l_csi2_format *rzg2l_csi2_datatype_to_fmt(unsigned int dt)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(rzg2l_csi2_formats); i++)
+		if (rzg2l_csi2_formats[i].datatype == dt)
+			return &rzg2l_csi2_formats[i];
+
+	return NULL;
+}
+
+enum rzg2l_csi2_pads {
+	RZG2L_CSI2_SINK = 0,
+	RZG2L_CSI2_SOURCE_VC0,
+	RZG2L_CSI2_SOURCE_VC1,
+	RZG2L_CSI2_SOURCE_VC2,
+	RZG2L_CSI2_SOURCE_VC3,
+	NR_OF_RZG2L_CSI2_PAD,
+};
+
+struct rzg2l_csi2 {
+	struct device *dev;
+	void __iomem *base;
+	struct reset_control *rstc;
+	unsigned long vclk_rate;
+
+	struct v4l2_subdev subdev;
+	struct media_pad pads[NR_OF_RZG2L_CSI2_PAD];
+
+	struct v4l2_async_notifier notifier;
+	struct v4l2_async_subdev asd;
+	struct v4l2_subdev *remote;
+
+	struct mutex lock;
+	int stream_count;
+
+	unsigned short lanes;
+
+	unsigned long hsfreq;
+};
+
+static inline struct rzg2l_csi2 *sd_to_csi2(struct v4l2_subdev *sd)
+{
+	return container_of(sd, struct rzg2l_csi2, subdev);
+}
+
+static inline struct rzg2l_csi2 *notifier_to_csi2(struct v4l2_async_notifier *n)
+{
+	return container_of(n, struct rzg2l_csi2, notifier);
+}
+
+static u32 rzg2l_csi2_read(struct rzg2l_csi2 *csi2, unsigned int reg)
+{
+	return ioread32(csi2->base + reg);
+}
+
+static void rzg2l_csi2_write(struct rzg2l_csi2 *csi2, unsigned int reg,
+			     u32 data)
+{
+	iowrite32(data, csi2->base + reg);
+}
+
+static void rzg2l_csi2_set(struct rzg2l_csi2 *csi2, unsigned int reg, u32 set)
+{
+	rzg2l_csi2_write(csi2, reg, rzg2l_csi2_read(csi2, reg) | set);
+}
+
+static void rzg2l_csi2_clr(struct rzg2l_csi2 *csi2, unsigned int reg, u32 clr)
+{
+	rzg2l_csi2_write(csi2, reg, rzg2l_csi2_read(csi2, reg) & ~clr);
+}
+
+/* -----------------------------------------------------------------------------
+ * DPHY setting
+ */
+
+static int rzg2l_csi2_dphy_setting(struct rzg2l_csi2 *csi2, bool on)
+{
+	int ret = 0;
+
+	if (on) {
+		struct timings dphy_timing;
+		u32 dphytim0, dphytim1;
+
+		/* Release reset state */
+		ret = reset_control_deassert(csi2->rstc);
+		if (ret)
+			return ret;
+
+		/* Wait until the power stabilizes */
+		mdelay(1);
+
+		/* Set DPHY timing parameters */
+		if (csi2->hsfreq <= 80)
+			dphy_timing = global_timings[TRANSMISSION_RATE_80_MBPS];
+		else if (csi2->hsfreq > 80 && csi2->hsfreq <= 125)
+			dphy_timing = global_timings[TRANSMISSION_RATE_125_MBPS];
+		else if (csi2->hsfreq > 125 && csi2->hsfreq <= 250)
+			dphy_timing = global_timings[TRANSMISSION_RATE_250_MBPS];
+		else if (csi2->hsfreq > 250 && csi2->hsfreq <= 360)
+			dphy_timing = global_timings[TRANSMISSION_RATE_360_MBPS];
+		else if (csi2->hsfreq > 360 && csi2->hsfreq <= 1500)
+			dphy_timing = global_timings[TRANSMISSION_RATE_360_PLUS_MBPS];
+		else
+			return -EINVAL;
+
+		dphytim0 = CSIDPHYTIM0_TCLK_MISS(dphy_timing.tclk_miss) |
+			   CSIDPHYTIM0_T_INIT(dphy_timing.t_init);
+		dphytim1 = CSIDPHYTIM1_THS_PREPARE(dphy_timing.ths_prepare) |
+			   CSIDPHYTIM1_TCLK_PREPARE(dphy_timing.tclk_prepare) |
+			   CSIDPHYTIM1_THS_SETTLE(dphy_timing.ths_settle) |
+			   CSIDPHYTIM1_THS_SETTLE(dphy_timing.tclk_settle);
+
+		rzg2l_csi2_write(csi2, CSIDPHYTIM0, dphytim0);
+		rzg2l_csi2_write(csi2, CSIDPHYTIM1, dphytim1);
+
+		/* Set the EN_BGR bit */
+		rzg2l_csi2_set(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_BGR);
+
+		/* Delay 20us to be stable */
+		usleep_range(20, 40);
+
+		/* Set the EN_LDO1200 bit */
+		rzg2l_csi2_set(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_LDO1200);
+
+		/* Delay 10us to be stable */
+		usleep_range(10, 20);
+	} else {
+		/* Cancel the EN_LDO1200 register setting */
+		rzg2l_csi2_clr(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_LDO1200);
+
+		/* Cancel the EN_BGR register setting */
+		rzg2l_csi2_clr(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_BGR);
+
+		/* Set reset state */
+		reset_control_assert(csi2->rstc);
+	}
+
+	return ret;
+}
+
+static int rzg2l_csi2_calc_mbps(struct rzg2l_csi2 *csi2,
+				struct v4l2_mbus_frame_desc *fd,
+				unsigned int lanes)
+{
+	const struct v4l2_mbus_frame_desc_entry_csi2 *csi2_desc;
+	const struct rzg2l_csi2_format *format;
+	struct v4l2_subdev *source;
+	struct v4l2_ctrl *ctrl;
+	unsigned int i;
+	u64 mbps;
+
+	if (!csi2->remote)
+		return -ENODEV;
+
+	source = csi2->remote;
+
+	/* Read the pixel rate control from remote. */
+	ctrl = v4l2_ctrl_find(source->ctrl_handler, V4L2_CID_PIXEL_RATE);
+	if (!ctrl) {
+		dev_err(csi2->dev, "no pixel rate control in subdev %s\n",
+			source->name);
+		return -EINVAL;
+	}
+
+	/* Verify that all remote streams send the same datatype. */
+	csi2_desc = NULL;
+	for (i = 0; i < fd->num_entries; i++) {
+		struct v4l2_mbus_frame_desc_entry_csi2 *stream_desc;
+
+		stream_desc = &fd->entry[i].bus.csi2;
+		if (!csi2_desc)
+			csi2_desc = stream_desc;
+
+		if (csi2_desc->dt != stream_desc->dt) {
+			dev_err(csi2->dev,
+				"Remote streams with different DT: %u - %u\n",
+				csi2_desc->dt, stream_desc->dt);
+			return -EINVAL;
+		}
+	}
+	format = rzg2l_csi2_datatype_to_fmt(csi2_desc->dt);
+	if (!format)
+		return -EINVAL;
+
+	/*
+	 * Calculate hsfreq in Mbps
+	 * hsfreq = (pixel_rate * bits_per_sample) / number_of_lanes
+	 */
+	mbps = v4l2_ctrl_g_ctrl_int64(ctrl) * format->bpp;
+	do_div(mbps, csi2->lanes * 1000000);
+
+	return mbps;
+}
+
+static void rzg2l_csi2_stop(struct rzg2l_csi2 *csi2)
+{
+	unsigned int timeout = VSRSTS_RETRIES;
+
+	/* Stop DPHY reception */
+	rzg2l_csi2_dphy_setting(csi2, 0);
+
+	/* Stop LINK reception */
+	rzg2l_csi2_clr(csi2, CSI2nMCT3, CSI2nMCT3_RXEN);
+
+	/* Request a software reset of the LINK Video Pixel Interface */
+	rzg2l_csi2_write(csi2, CSI2nRTCT, CSI2nRTCT_VSRST);
+
+	while (timeout--) {
+		/* Make sure that the execution status is not during a reset */
+		if (!(rzg2l_csi2_read(csi2, CSI2nRTST) & CSI2nRTST_VSRSTS))
+			break;
+		msleep(VSRSTS_TIMEOUT_MS);
+	};
+	if (!timeout)
+		dev_err(csi2->dev, "CSI2nRTCT_VSRST bit is not cleared\n");
+}
+
+static int rzg2l_csi2_get_remote_frame_desc(struct rzg2l_csi2 *csi2,
+					    struct v4l2_mbus_frame_desc *fd)
+{
+	struct media_pad *pad;
+	int ret;
+
+	if (!csi2->remote)
+		return -ENODEV;
+
+	pad = media_entity_remote_pad(&csi2->pads[RZG2L_CSI2_SINK]);
+	if (!pad)
+		return -ENODEV;
+
+	ret = v4l2_subdev_call(csi2->remote, pad, get_frame_desc,
+			       pad->index, fd);
+	if (ret)
+		return ret;
+
+	if (fd->type != V4L2_MBUS_FRAME_DESC_TYPE_CSI2) {
+		dev_err(csi2->dev, "Frame desc do not describe CSI-2 link");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rzg2l_csi2_start(struct rzg2l_csi2 *csi2)
+{
+	unsigned long vclk_rate = csi2->vclk_rate / HZ_PER_MHZ;
+	u32 frrskw, frrclk, frrskw_coeff, frrclk_coeff;
+	struct v4l2_mbus_frame_desc fd;
+	int lanes, mbps, ret;
+
+	/* Get information about multiplexed link. */
+	ret = rzg2l_csi2_get_remote_frame_desc(csi2, &fd);
+	if (ret)
+		return ret;
+
+	/* Checking the maximum lanes support for CSI-2 module */
+	lanes = (rzg2l_csi2_read(csi2, CSI2nMCG) & CSI2nMCG_SDLN) >> 8;
+	if (lanes < csi2->lanes) {
+		dev_err(csi2->dev,
+			"Failed to support %d data lanes\n", csi2->lanes);
+		return -EINVAL;
+	}
+
+	mbps = rzg2l_csi2_calc_mbps(csi2, &fd, lanes);
+	if (mbps < 0)
+		return mbps;
+
+	csi2->hsfreq = mbps;
+
+	/* Initialize DPHY */
+	ret = rzg2l_csi2_dphy_setting(csi2, 1);
+	if (ret) {
+		rzg2l_csi2_dphy_setting(csi2, 0);
+		return ret;
+	}
+
+	rzg2l_csi2_write(csi2, CSI2nMCT0, CSI2nMCT0_VDLN(csi2->lanes));
+
+	frrskw_coeff = 3 * vclk_rate * 8;
+	frrclk_coeff = frrskw_coeff / 2;
+	frrskw = DIV_ROUND_UP(frrskw_coeff, csi2->hsfreq);
+	frrclk = DIV_ROUND_UP(frrclk_coeff, csi2->hsfreq);
+	rzg2l_csi2_write(csi2, CSI2nMCT2,
+			 CSI2nMCT2_FRRSKW(frrskw) | CSI2nMCT2_FRRCLK(frrclk));
+
+	/* Select data type. */
+	rzg2l_csi2_write(csi2, CSI2nDTEL, 0xf778ff0f);
+	rzg2l_csi2_write(csi2, CSI2nDTEH, 0x00ffff1f);
+
+	/* Enable LINK reception */
+	rzg2l_csi2_set(csi2, CSI2nMCT3, CSI2nMCT3_RXEN);
+
+	return 0;
+}
+
+static int rzg2l_csi2_s_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct rzg2l_csi2 *csi2 = sd_to_csi2(sd);
+	int ret = 0;
+
+	mutex_lock(&csi2->lock);
+
+	if (!csi2->remote) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (enable && !csi2->stream_count) {
+		pm_runtime_get_sync(csi2->dev);
+
+		ret = rzg2l_csi2_start(csi2);
+		if (ret) {
+			pm_runtime_put(csi2->dev);
+			goto out;
+		}
+
+		ret = v4l2_subdev_call(csi2->remote, video, s_stream, 1);
+		if (ret) {
+			rzg2l_csi2_stop(csi2);
+			pm_runtime_put(csi2->dev);
+			goto out;
+		}
+	} else if (!enable && csi2->stream_count == 1) {
+		v4l2_subdev_call(csi2->remote, video, s_stream, 0);
+		rzg2l_csi2_stop(csi2);
+		pm_runtime_put(csi2->dev);
+	}
+
+	csi2->stream_count += enable ? 1 : -1;
+out:
+	mutex_unlock(&csi2->lock);
+
+	return ret;
+}
+
+static int rzg2l_csi2_get_frame_desc(struct v4l2_subdev *sd, unsigned int pad,
+				     struct v4l2_mbus_frame_desc *fd)
+{
+	struct v4l2_subdev_state *state;
+	struct v4l2_subdev_route *route;
+	int ret = 0;
+
+	if (pad < RZG2L_CSI2_SOURCE_VC0 || pad > RZG2L_CSI2_SOURCE_VC3)
+		return -EINVAL;
+
+	state = v4l2_subdev_lock_active_state(sd);
+
+	memset(fd, 0, sizeof(*fd));
+
+	for_each_active_route(&state->routing, route) {
+		const struct rzg2l_csi2_format *csi2_fmt;
+		struct v4l2_mbus_framefmt *fmt;
+
+		if (route->source_pad != pad)
+			continue;
+
+		fmt = v4l2_state_get_stream_format(state, pad,
+						   route->source_stream);
+		if (!fmt) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		csi2_fmt = rzg2l_csi2_code_to_fmt(fmt->code);
+
+		/* Only one stream per 'channel' is allowed. */
+		fd->entry[0].pixelcode = fmt->code;
+		fd->entry[0].length = fmt->width * fmt->height * csi2_fmt->bpp / 8;
+		fd->entry[0].flags = V4L2_MBUS_FRAME_DESC_FL_LEN_MAX;
+
+		/*
+		 * The sink stream id corresponds to the CSI-2 Virtual Channel
+		 * which is output on the channel identified by the current
+		 * source pad.
+		 */
+		fd->entry[0].bus.csi2.vc = route->sink_stream;
+		fd->entry[0].bus.csi2.dt = csi2_fmt->datatype;
+
+		fd->num_entries = 1;
+
+		break;
+	}
+
+	fd->type = V4L2_MBUS_FRAME_DESC_TYPE_CSI2;
+
+out:
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
+}
+
+static int _rzg2l_csi2_set_routing(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_state *state,
+				   struct v4l2_subdev_krouting *routing)
+{
+	int ret;
+
+	ret = v4l2_subdev_routing_validate_1_to_1(routing);
+	if (ret)
+		return ret;
+
+	v4l2_subdev_lock_state(state);
+
+	ret = v4l2_subdev_set_routing(sd, state, routing);
+
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
+}
+
+static int rzg2l_csi2_set_routing(struct v4l2_subdev *sd,
+				  struct v4l2_subdev_state *state,
+				  enum v4l2_subdev_format_whence which,
+				  struct v4l2_subdev_krouting *routing)
+{
+	return _rzg2l_csi2_set_routing(sd, state, routing);
+}
+
+static int rzg2l_csi2_init_config(struct v4l2_subdev *sd,
+				  struct v4l2_subdev_state *state)
+{
+	/* One route for each virtual channel. Route 0 enabled by default. */
+	struct v4l2_subdev_route routes[] = {
+		{
+			.sink_pad = RZG2L_CSI2_SINK,
+			.sink_stream = 0,
+			.source_pad = RZG2L_CSI2_SOURCE_VC0,
+			.source_stream = 0,
+			.flags = V4L2_SUBDEV_ROUTE_FL_ACTIVE,
+		},
+		{
+			.sink_pad = RZG2L_CSI2_SINK,
+			.sink_stream = 1,
+			.source_pad = RZG2L_CSI2_SOURCE_VC1,
+			.source_stream = 0,
+			.flags = 0,
+		},
+		{
+			.sink_pad = RZG2L_CSI2_SINK,
+			.sink_stream = 2,
+			.source_pad = RZG2L_CSI2_SOURCE_VC2,
+			.source_stream = 2,
+			.flags = 0,
+		},
+		{
+			.sink_pad = RZG2L_CSI2_SINK,
+			.sink_stream = 3,
+			.source_pad = RZG2L_CSI2_SOURCE_VC3,
+			.source_stream = 0,
+			.flags = 0,
+		},
+	};
+	struct v4l2_subdev_krouting routing = {
+		.num_routes = ARRAY_SIZE(routes),
+		.routes = routes,
+	};
+
+	return _rzg2l_csi2_set_routing(sd, state, &routing);
+}
+
+static int rzg2l_csi2_set_format(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *state,
+				 struct v4l2_subdev_format *format)
+{
+	struct v4l2_mbus_framefmt *fmt;
+	int ret = 0;
+
+	if (!rzg2l_csi2_code_to_fmt(format->format.code))
+		format->format.code = rzg2l_csi2_formats[0].code;
+
+	/*
+	 * Format is propagated from sink streams to source streams, so
+	 * disallow setting format on the source pads.
+	 */
+	if (format->pad > RZG2L_CSI2_SINK)
+		return -EINVAL;
+
+	v4l2_subdev_lock_state(state);
+
+	fmt = v4l2_state_get_stream_format(state, format->pad,
+					   format->stream);
+	if (!fmt) {
+		ret = -EINVAL;
+		goto out;
+	}
+	*fmt = format->format;
+
+	/* Propagate format to the other end of the route. */
+	fmt = v4l2_subdev_state_get_opposite_stream_format(state, format->pad,
+							   format->stream);
+	if (!fmt) {
+		ret = -EINVAL;
+		goto out;
+	}
+	*fmt = format->format;
+
+out:
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
+}
+
+static const struct v4l2_subdev_video_ops rzg2l_csi2_video_ops = {
+	.s_stream = rzg2l_csi2_s_stream,
+};
+
+static const struct v4l2_subdev_pad_ops rzg2l_csi2_pad_ops = {
+	.init_cfg = rzg2l_csi2_init_config,
+	.set_fmt = rzg2l_csi2_set_format,
+	.get_fmt = v4l2_subdev_get_fmt,
+	.get_frame_desc = rzg2l_csi2_get_frame_desc,
+	.set_routing = rzg2l_csi2_set_routing,
+};
+
+static const struct v4l2_subdev_ops rzg2l_csi2_subdev_ops = {
+	.video	= &rzg2l_csi2_video_ops,
+	.pad	= &rzg2l_csi2_pad_ops,
+};
+
+/* -----------------------------------------------------------------------------
+ * Async handling and registration of subdevices and links.
+ */
+
+static int rzg2l_csi2_notify_bound(struct v4l2_async_notifier *notifier,
+				   struct v4l2_subdev *subdev,
+				   struct v4l2_async_subdev *asd)
+{
+	struct rzg2l_csi2 *csi2 = notifier_to_csi2(notifier);
+	int pad;
+
+	if (!v4l2_subdev_has_op(subdev, pad, get_frame_desc)) {
+		dev_err(csi2->dev,
+			"Subdev %s bound failed: missing get_frame_desc()\n",
+			subdev->name);
+		return -EINVAL;
+	}
+
+	pad = media_entity_get_fwnode_pad(&subdev->entity, asd->match.fwnode,
+					  MEDIA_PAD_FL_SOURCE);
+	if (pad < 0) {
+		dev_err(csi2->dev, "Failed to find pad for %s\n", subdev->name);
+		return pad;
+	}
+
+	csi2->remote = subdev;
+
+	dev_dbg(csi2->dev, "Bound %s pad: %d\n", subdev->name, pad);
+
+	return media_create_pad_link(&subdev->entity, pad,
+				     &csi2->subdev.entity, 0,
+				     MEDIA_LNK_FL_ENABLED |
+				     MEDIA_LNK_FL_IMMUTABLE);
+}
+
+static void rzg2l_csi2_notify_unbind(struct v4l2_async_notifier *notifier,
+				     struct v4l2_subdev *subdev,
+				     struct v4l2_async_subdev *asd)
+{
+	struct rzg2l_csi2 *csi2 = notifier_to_csi2(notifier);
+
+	csi2->remote = NULL;
+
+	dev_dbg(csi2->dev, "Unbind %s\n", subdev->name);
+}
+
+static const struct v4l2_async_notifier_operations rzg2l_csi2_notify_ops = {
+	.bound = rzg2l_csi2_notify_bound,
+	.unbind = rzg2l_csi2_notify_unbind,
+};
+
+static int rzg2l_csi2_parse_v4l2(struct rzg2l_csi2 *csi2,
+				 struct v4l2_fwnode_endpoint *vep)
+{
+	/* Only port 0 endpoint 0 is valid. */
+	if (vep->base.port || vep->base.id)
+		return -ENOTCONN;
+
+	if (vep->bus_type != V4L2_MBUS_CSI2_DPHY) {
+		dev_err(csi2->dev, "Unsupported bus: %u\n", vep->bus_type);
+		return -EINVAL;
+	}
+
+	csi2->lanes = vep->bus.mipi_csi2.num_data_lanes;
+	if (csi2->lanes != 1 && csi2->lanes != 2 && csi2->lanes != 4) {
+		dev_err(csi2->dev, "Unsupported number of data-lanes: %u\n",
+			csi2->lanes);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rzg2l_csi2_parse_dt(struct rzg2l_csi2 *csi2)
+{
+	struct v4l2_fwnode_endpoint v4l2_ep = {
+		.bus_type = V4L2_MBUS_CSI2_DPHY
+	};
+	struct v4l2_async_subdev *asd;
+	struct fwnode_handle *fwnode;
+	struct fwnode_handle *ep;
+	int ret;
+
+	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(csi2->dev), 0, 0, 0);
+	if (!ep) {
+		dev_err(csi2->dev, "Not connected to subdevice\n");
+		return -EINVAL;
+	}
+
+	ret = v4l2_fwnode_endpoint_parse(ep, &v4l2_ep);
+	if (ret) {
+		dev_err(csi2->dev, "Could not parse v4l2 endpoint\n");
+		fwnode_handle_put(ep);
+		return -EINVAL;
+	}
+
+	ret = rzg2l_csi2_parse_v4l2(csi2, &v4l2_ep);
+	if (ret) {
+		fwnode_handle_put(ep);
+		return ret;
+	}
+
+	fwnode = fwnode_graph_get_remote_endpoint(ep);
+	fwnode_handle_put(ep);
+
+	dev_dbg(csi2->dev, "Found '%pOF'\n", to_of_node(fwnode));
+
+	v4l2_async_nf_init(&csi2->notifier);
+	csi2->notifier.ops = &rzg2l_csi2_notify_ops;
+
+	asd = v4l2_async_nf_add_fwnode(&csi2->notifier, fwnode,
+				       struct v4l2_async_subdev);
+	fwnode_handle_put(fwnode);
+	if (IS_ERR(asd))
+		return PTR_ERR(asd);
+
+	ret = v4l2_async_subdev_nf_register(&csi2->subdev, &csi2->notifier);
+	if (ret)
+		v4l2_async_nf_cleanup(&csi2->notifier);
+
+	return ret;
+}
+
+/* -----------------------------------------------------------------------------
+ * Platform Device Driver.
+ */
+
+static const struct media_entity_operations rzg2l_csi2_entity_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+static int rzg2l_csi2_probe(struct platform_device *pdev)
+{
+	struct rzg2l_csi2 *csi2;
+	struct clk *vclk;
+	unsigned int i;
+	int ret;
+
+	csi2 = devm_kzalloc(&pdev->dev, sizeof(*csi2), GFP_KERNEL);
+	if (!csi2)
+		return -ENOMEM;
+
+	csi2->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(csi2->base))
+		return PTR_ERR(csi2->base);
+
+	csi2->rstc = devm_reset_control_get(&pdev->dev, "cmn-rstb");
+	if (IS_ERR(csi2->rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(csi2->rstc),
+				     "failed to get cpg cmn-rstb\n");
+
+	vclk = devm_clk_get(&pdev->dev, "vclk");
+	if (IS_ERR(vclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(vclk),
+				     "failed to get vclk clock\n");
+
+	csi2->vclk_rate = clk_get_rate(vclk);
+	devm_clk_put(&pdev->dev, vclk);
+
+	csi2->dev = &pdev->dev;
+	mutex_init(&csi2->lock);
+	csi2->stream_count = 0;
+
+	platform_set_drvdata(pdev, csi2);
+
+	ret = rzg2l_csi2_parse_dt(csi2);
+	if (ret)
+		goto error_mutex;
+
+	csi2->subdev.owner = THIS_MODULE;
+	csi2->subdev.dev = &pdev->dev;
+	v4l2_subdev_init(&csi2->subdev, &rzg2l_csi2_subdev_ops);
+	v4l2_set_subdevdata(&csi2->subdev, &pdev->dev);
+	snprintf(csi2->subdev.name, V4L2_SUBDEV_NAME_SIZE, "%s %s",
+		 KBUILD_MODNAME, dev_name(&pdev->dev));
+	csi2->subdev.flags = V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_MULTIPLEXED;
+
+	csi2->subdev.entity.function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
+	csi2->subdev.entity.ops = &rzg2l_csi2_entity_ops;
+
+	csi2->pads[RZG2L_CSI2_SINK].flags = MEDIA_PAD_FL_SINK;
+	for (i = RZG2L_CSI2_SOURCE_VC0; i < NR_OF_RZG2L_CSI2_PAD; i++)
+		csi2->pads[i].flags = MEDIA_PAD_FL_SOURCE;
+
+	ret = media_entity_pads_init(&csi2->subdev.entity, NR_OF_RZG2L_CSI2_PAD, csi2->pads);
+	if (ret)
+		goto error_async;
+
+	pm_runtime_enable(&pdev->dev);
+
+	ret = v4l2_subdev_init_finalize(&csi2->subdev);
+	if (ret < 0)
+		goto error_pm;
+
+	ret = v4l2_async_register_subdev(&csi2->subdev);
+	if (ret < 0)
+		goto error_subdev;
+
+	dev_info(csi2->dev, "%d lanes found\n", csi2->lanes);
+
+	return 0;
+
+error_subdev:
+	v4l2_subdev_cleanup(&csi2->subdev);
+error_pm:
+	pm_runtime_disable(&pdev->dev);
+error_async:
+	v4l2_async_nf_unregister(&csi2->notifier);
+	v4l2_async_nf_cleanup(&csi2->notifier);
+error_mutex:
+	mutex_destroy(&csi2->lock);
+
+	return ret;
+}
+
+static const struct of_device_id rzg2l_csi2_of_table[] = {
+	{ .compatible = "renesas,rzg2l-csi2", },
+	{ /* sentinel */ }
+};
+
+static int rzg2l_csi2_remove(struct platform_device *pdev)
+{
+	struct rzg2l_csi2 *csi2 = platform_get_drvdata(pdev);
+
+	v4l2_async_nf_unregister(&csi2->notifier);
+	v4l2_async_nf_cleanup(&csi2->notifier);
+	v4l2_async_unregister_subdev(&csi2->subdev);
+	v4l2_subdev_cleanup(&csi2->subdev);
+
+	pm_runtime_disable(&pdev->dev);
+	mutex_destroy(&csi2->lock);
+
+	return 0;
+}
+
+static struct platform_driver rzg2l_csi2_pdrv = {
+	.remove	= rzg2l_csi2_remove,
+	.probe	= rzg2l_csi2_probe,
+	.driver	= {
+		.name = "rzg2l-csi2",
+		.of_match_table = rzg2l_csi2_of_table,
+	},
+};
+
+module_platform_driver(rzg2l_csi2_pdrv);
+
+MODULE_DESCRIPTION("Renesas RZG2L MIPI CSI2 receiver driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

