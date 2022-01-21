Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE3E495BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379502AbiAUISd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:18:33 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:48760 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379431AbiAUISZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:18:25 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:d916:876:fa52:7241])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7BE341228;
        Fri, 21 Jan 2022 09:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642753100;
        bh=OvoqwCNVrNzELEwlKNrd7OHf4CjgmH4JBx9UHqCHiS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s9TWCeZwHV7ef+34dQcDAG2Zmk1g5gISSLEzzWw561ugBS9GFNiZlUSiNaqJPqxuO
         LJHoMtdXuvS97ClvVVQjvfPavxuQeQ9brjDasOpX9azNLWiDZK3hc1jZrPLmvs7dBW
         wAi06SOkja+ZDFlEJOT9B1tNOyueNEXS+l7oax5s=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com
Subject: [RFC PATCH v2 4/7] media: bcm2835-unicam: Add support for for CCP2/CSI2 camera interface
Date:   Fri, 21 Jan 2022 09:18:07 +0100
Message-Id: <20220121081810.155500-5-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the Unicam camera receiver block on BCM283x processors.
It is represented as two video device nodes: unicam-image and
unicam-embedded which are connected to an internal subdev (named
unicam-subdev) in order to manage streams routing.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>

---
in v2: Remove the unicam_{info,debug,error} macros and use
dev_dbg/dev_err instead.
---
 MAINTAINERS                                   |    1 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    2 +
 drivers/media/platform/bcm2835/Kconfig        |   21 +
 drivers/media/platform/bcm2835/Makefile       |    3 +
 .../media/platform/bcm2835/bcm2835-unicam.c   | 2678 +++++++++++++++++
 .../media/platform/bcm2835/vc4-regs-unicam.h  |  253 ++
 7 files changed, 2959 insertions(+)
 create mode 100644 drivers/media/platform/bcm2835/Kconfig
 create mode 100644 drivers/media/platform/bcm2835/Makefile
 create mode 100644 drivers/media/platform/bcm2835/bcm2835-unicam.c
 create mode 100644 drivers/media/platform/bcm2835/vc4-regs-unicam.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 07f238fd5ff9..b17bb533e007 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3684,6 +3684,7 @@ M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
+F:	drivers/media/platform/bcm2835/
 
 BROADCOM BCM47XX MIPS ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 9fbdba0fd1e7..033b0358fbb8 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -170,6 +170,7 @@ source "drivers/media/platform/am437x/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 source "drivers/media/platform/rcar-vin/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
+source "drivers/media/platform/bcm2835/Kconfig"
 source "drivers/media/platform/sunxi/Kconfig"
 
 config VIDEO_TI_CAL
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 19bcbced7382..689e64857db1 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -85,6 +85,8 @@ obj-$(CONFIG_VIDEO_QCOM_CAMSS)		+= qcom/camss/
 
 obj-$(CONFIG_VIDEO_QCOM_VENUS)		+= qcom/venus/
 
+obj-y					+= bcm2835/
+
 obj-y					+= sunxi/
 
 obj-$(CONFIG_VIDEO_MESON_GE2D)		+= meson/ge2d/
diff --git a/drivers/media/platform/bcm2835/Kconfig b/drivers/media/platform/bcm2835/Kconfig
new file mode 100644
index 000000000000..bd1370199650
--- /dev/null
+++ b/drivers/media/platform/bcm2835/Kconfig
@@ -0,0 +1,21 @@
+# Broadcom VideoCore4 V4L2 camera support
+
+config VIDEO_BCM2835_UNICAM
+	tristate "Broadcom BCM283x/BCM271x Unicam video capture driver"
+	depends on VIDEO_V4L2
+	depends on ARCH_BCM2835 || COMPILE_TEST
+	select VIDEO_V4L2_SUBDEV_API
+	select MEDIA_CONTROLLER
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_FWNODE
+	help
+	  Say Y here to enable support for the BCM283x/BCM271x CSI-2 receiver.
+	  This is a V4L2 driver that controls the CSI-2 receiver directly,
+	  independently from the VC4 firmware.
+	  This driver is mutually exclusive with the use of bcm2835-camera. The
+	  firmware will disable all access to the peripheral from within the
+	  firmware if it finds a DT node using it, and bcm2835-camera will
+	  therefore fail to probe.
+
+	  To compile this driver as a module, choose M here. The module will be
+	  called bcm2835-unicam.
diff --git a/drivers/media/platform/bcm2835/Makefile b/drivers/media/platform/bcm2835/Makefile
new file mode 100644
index 000000000000..a98aba03598a
--- /dev/null
+++ b/drivers/media/platform/bcm2835/Makefile
@@ -0,0 +1,3 @@
+# Makefile for BCM2835 Unicam driver
+
+obj-$(CONFIG_VIDEO_BCM2835_UNICAM) += bcm2835-unicam.o
diff --git a/drivers/media/platform/bcm2835/bcm2835-unicam.c b/drivers/media/platform/bcm2835/bcm2835-unicam.c
new file mode 100644
index 000000000000..7636496be00a
--- /dev/null
+++ b/drivers/media/platform/bcm2835/bcm2835-unicam.c
@@ -0,0 +1,2678 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * BCM283x / BCM271x Unicam Capture Driver
+ *
+ * Copyright (C) 2017-2020 - Raspberry Pi (Trading) Ltd.
+ *
+ * Dave Stevenson <dave.stevenson@raspberrypi.com>
+ *
+ * Based on TI am437x driver by
+ *   Benoit Parrot <bparrot@ti.com>
+ *   Lad, Prabhakar <prabhakar.csengg@gmail.com>
+ *
+ * and TI CAL camera interface driver by
+ *    Benoit Parrot <bparrot@ti.com>
+ *
+ *
+ * There are two camera drivers in the kernel for BCM283x - this one
+ * and bcm2835-camera (currently in staging).
+ *
+ * This driver directly controls the Unicam peripheral - there is no
+ * involvement with the VideoCore firmware. Unicam receives CSI-2 or
+ * CCP2 data and writes it into SDRAM.
+ * The only potential processing options are to repack Bayer data into an
+ * alternate format, and applying windowing.
+ * The repacking does not shift the data, so can repack V4L2_PIX_FMT_Sxxxx10P
+ * to V4L2_PIX_FMT_Sxxxx10, or V4L2_PIX_FMT_Sxxxx12P to V4L2_PIX_FMT_Sxxxx12,
+ * but not generically up to V4L2_PIX_FMT_Sxxxx16. The driver will add both
+ * formats where the relevant formats are defined, and will automatically
+ * configure the repacking as required.
+ * Support for windowing may be added later.
+ *
+ * It should be possible to connect this driver to any sensor with a
+ * suitable output interface and V4L2 subdevice driver.
+ *
+ * bcm2835-camera uses the VideoCore firmware to control the sensor,
+ * Unicam, ISP, and all tuner control loops. Fully processed frames are
+ * delivered to the driver by the firmware. It only has sensor drivers
+ * for Omnivision OV5647, and Sony IMX219 sensors.
+ *
+ * The two drivers are mutually exclusive for the same Unicam instance.
+ * The VideoCore firmware checks the device tree configuration during boot.
+ * If it finds device tree nodes called csi0 or csi1 it will block the
+ * firmware from accessing the peripheral, and bcm2835-camera will
+ * not be able to stream data.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_graph.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/videodev2.h>
+
+#include <media/v4l2-common.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-dv-timings.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-fwnode.h>
+#include <media/videobuf2-dma-contig.h>
+
+#include <media/v4l2-async.h>
+#define v4l2_async_nf_add_subdev __v4l2_async_nf_add_subdev
+
+#include "vc4-regs-unicam.h"
+
+#define UNICAM_MODULE_NAME	"unicam"
+#define UNICAM_VERSION		"0.1.0"
+
+static int debug;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Debug level 0-3");
+
+/*
+ * Unicam must request a minimum of 250Mhz from the VPU clock.
+ * Otherwise the input FIFOs overrun and cause image corruption.
+ */
+#define MIN_VPU_CLOCK_RATE (250 * 1000 * 1000)
+/*
+ * To protect against a dodgy sensor driver never returning an error from
+ * enum_mbus_code, set a maximum index value to be used.
+ */
+#define MAX_ENUM_MBUS_CODE	128
+
+/*
+ * Stride is a 16 bit register, but also has to be a multiple of 32.
+ */
+#define BPL_ALIGNMENT		32
+#define MAX_BYTESPERLINE	((1 << 16) - BPL_ALIGNMENT)
+/*
+ * Max width is therefore determined by the max stride divided by
+ * the number of bits per pixel. Take 32bpp as a
+ * worst case.
+ * No imposed limit on the height, so adopt a square image for want
+ * of anything better.
+ */
+#define MAX_WIDTH		(MAX_BYTESPERLINE / 4)
+#define MAX_HEIGHT		MAX_WIDTH
+/* Define a nominal minimum image size */
+#define MIN_WIDTH		16
+#define MIN_HEIGHT		16
+/* Default size of the embedded buffer */
+#define UNICAM_EMBEDDED_SIZE	16384
+
+/*
+ * Size of the dummy buffer. Can be any size really, but the DMA
+ * allocation works in units of page sizes.
+ */
+#define DUMMY_BUF_SIZE		(PAGE_SIZE)
+
+#define UNICAM_SD_PAD_SINK		0
+#define UNICAM_SD_PAD_FIRST_SOURCE	1
+#define UNICAM_SD_NUM_SOURCE_PADS	2
+#define UNICAM_SD_NUM_PADS		(1 + UNICAM_SD_NUM_SOURCE_PADS)
+
+static inline bool unicam_sd_pad_is_sink(u32 pad)
+{
+	/* Camera RX has 1 sink pad, and N source pads */
+	return pad == 0;
+}
+
+static inline bool unicam_sd_pad_is_source(u32 pad)
+{
+	/* Camera RX has 1 sink pad, and N source pads */
+	return pad >= UNICAM_SD_PAD_FIRST_SOURCE &&
+	       pad <= UNICAM_SD_NUM_SOURCE_PADS;
+}
+
+enum node_types {
+	IMAGE_NODE,
+	METADATA_NODE,
+	MAX_NODES
+};
+
+#define MASK_CS_DEFAULT		BIT(V4L2_COLORSPACE_DEFAULT)
+#define MASK_CS_SMPTE170M	BIT(V4L2_COLORSPACE_SMPTE170M)
+#define MASK_CS_SMPTE240M	BIT(V4L2_COLORSPACE_SMPTE240M)
+#define MASK_CS_REC709		BIT(V4L2_COLORSPACE_REC709)
+#define MASK_CS_BT878		BIT(V4L2_COLORSPACE_BT878)
+#define MASK_CS_470_M		BIT(V4L2_COLORSPACE_470_SYSTEM_M)
+#define MASK_CS_470_BG		BIT(V4L2_COLORSPACE_470_SYSTEM_BG)
+#define MASK_CS_JPEG		BIT(V4L2_COLORSPACE_JPEG)
+#define MASK_CS_SRGB		BIT(V4L2_COLORSPACE_SRGB)
+#define MASK_CS_OPRGB		BIT(V4L2_COLORSPACE_OPRGB)
+#define MASK_CS_BT2020		BIT(V4L2_COLORSPACE_BT2020)
+#define MASK_CS_RAW		BIT(V4L2_COLORSPACE_RAW)
+#define MASK_CS_DCI_P3		BIT(V4L2_COLORSPACE_DCI_P3)
+
+#define MAX_COLORSPACE		32
+
+/*
+ * struct unicam_fmt - Unicam media bus format information
+ * @pixelformat: V4L2 pixel format FCC identifier. 0 if n/a.
+ * @repacked_fourcc: V4L2 pixel format FCC identifier if the data is expanded
+ * out to 16bpp. 0 if n/a.
+ * @code: V4L2 media bus format code.
+ * @depth: Bits per pixel as delivered from the source.
+ * @csi_dt: CSI data type.
+ * @valid_colorspaces: Bitmask of valid colorspaces so that the Media Controller
+ *		centric try_fmt can validate the colorspace and pass
+ *		v4l2-compliance.
+ * @check_variants: Flag to denote that there are multiple mediabus formats
+ *		still in the list that could match this V4L2 format.
+ * @mc_skip: Media Controller shouldn't list this format via ENUM_FMT as it is
+ *		a duplicate of an earlier format.
+ * @metadata_fmt: This format only applies to the metadata pad.
+ */
+struct unicam_fmt {
+	u32	fourcc;
+	u32	repacked_fourcc;
+	u32	code;
+	u8	depth;
+	u8	csi_dt;
+	u32	valid_colorspaces;
+	u8	check_variants:1;
+	u8	mc_skip:1;
+	u8	metadata_fmt:1;
+};
+
+static const struct unicam_fmt formats[] = {
+	/* YUV Formats */
+	{
+		.fourcc		= V4L2_PIX_FMT_YUYV,
+		.code		= MEDIA_BUS_FMT_YUYV8_2X8,
+		.depth		= 16,
+		.csi_dt		= 0x1e,
+		.check_variants = 1,
+		.valid_colorspaces = MASK_CS_SMPTE170M | MASK_CS_REC709 |
+				     MASK_CS_JPEG,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_UYVY,
+		.code		= MEDIA_BUS_FMT_UYVY8_2X8,
+		.depth		= 16,
+		.csi_dt		= 0x1e,
+		.check_variants = 1,
+		.valid_colorspaces = MASK_CS_SMPTE170M | MASK_CS_REC709 |
+				     MASK_CS_JPEG,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_YVYU,
+		.code		= MEDIA_BUS_FMT_YVYU8_2X8,
+		.depth		= 16,
+		.csi_dt		= 0x1e,
+		.check_variants = 1,
+		.valid_colorspaces = MASK_CS_SMPTE170M | MASK_CS_REC709 |
+				     MASK_CS_JPEG,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_VYUY,
+		.code		= MEDIA_BUS_FMT_VYUY8_2X8,
+		.depth		= 16,
+		.csi_dt		= 0x1e,
+		.check_variants = 1,
+		.valid_colorspaces = MASK_CS_SMPTE170M | MASK_CS_REC709 |
+				     MASK_CS_JPEG,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_YUYV,
+		.code		= MEDIA_BUS_FMT_YUYV8_1X16,
+		.depth		= 16,
+		.csi_dt		= 0x1e,
+		.mc_skip	= 1,
+		.valid_colorspaces = MASK_CS_SMPTE170M | MASK_CS_REC709 |
+				     MASK_CS_JPEG,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_UYVY,
+		.code		= MEDIA_BUS_FMT_UYVY8_1X16,
+		.depth		= 16,
+		.csi_dt		= 0x1e,
+		.mc_skip	= 1,
+		.valid_colorspaces = MASK_CS_SMPTE170M | MASK_CS_REC709 |
+				     MASK_CS_JPEG,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_YVYU,
+		.code		= MEDIA_BUS_FMT_YVYU8_1X16,
+		.depth		= 16,
+		.csi_dt		= 0x1e,
+		.mc_skip	= 1,
+		.valid_colorspaces = MASK_CS_SMPTE170M | MASK_CS_REC709 |
+				     MASK_CS_JPEG,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_VYUY,
+		.code		= MEDIA_BUS_FMT_VYUY8_1X16,
+		.depth		= 16,
+		.csi_dt		= 0x1e,
+		.mc_skip	= 1,
+		.valid_colorspaces = MASK_CS_SMPTE170M | MASK_CS_REC709 |
+				     MASK_CS_JPEG,
+	}, {
+	/* RGB Formats */
+		.fourcc		= V4L2_PIX_FMT_RGB565, /* gggbbbbb rrrrrggg */
+		.code		= MEDIA_BUS_FMT_RGB565_2X8_LE,
+		.depth		= 16,
+		.csi_dt		= 0x22,
+		.valid_colorspaces = MASK_CS_SRGB,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_RGB565X, /* rrrrrggg gggbbbbb */
+		.code		= MEDIA_BUS_FMT_RGB565_2X8_BE,
+		.depth		= 16,
+		.csi_dt		= 0x22,
+		.valid_colorspaces = MASK_CS_SRGB,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_RGB555, /* gggbbbbb arrrrrgg */
+		.code		= MEDIA_BUS_FMT_RGB555_2X8_PADHI_LE,
+		.depth		= 16,
+		.csi_dt		= 0x21,
+		.valid_colorspaces = MASK_CS_SRGB,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_RGB555X, /* arrrrrgg gggbbbbb */
+		.code		= MEDIA_BUS_FMT_RGB555_2X8_PADHI_BE,
+		.depth		= 16,
+		.csi_dt		= 0x21,
+		.valid_colorspaces = MASK_CS_SRGB,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_RGB24, /* rgb */
+		.code		= MEDIA_BUS_FMT_RGB888_1X24,
+		.depth		= 24,
+		.csi_dt		= 0x24,
+		.valid_colorspaces = MASK_CS_SRGB,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_BGR24, /* bgr */
+		.code		= MEDIA_BUS_FMT_BGR888_1X24,
+		.depth		= 24,
+		.csi_dt		= 0x24,
+		.valid_colorspaces = MASK_CS_SRGB,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_RGB32, /* argb */
+		.code		= MEDIA_BUS_FMT_ARGB8888_1X32,
+		.depth		= 32,
+		.csi_dt		= 0x0,
+		.valid_colorspaces = MASK_CS_SRGB,
+	}, {
+	/* Bayer Formats */
+		.fourcc		= V4L2_PIX_FMT_SBGGR8,
+		.code		= MEDIA_BUS_FMT_SBGGR8_1X8,
+		.depth		= 8,
+		.csi_dt		= 0x2a,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGBRG8,
+		.code		= MEDIA_BUS_FMT_SGBRG8_1X8,
+		.depth		= 8,
+		.csi_dt		= 0x2a,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGRBG8,
+		.code		= MEDIA_BUS_FMT_SGRBG8_1X8,
+		.depth		= 8,
+		.csi_dt		= 0x2a,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SRGGB8,
+		.code		= MEDIA_BUS_FMT_SRGGB8_1X8,
+		.depth		= 8,
+		.csi_dt		= 0x2a,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SBGGR10P,
+		.repacked_fourcc = V4L2_PIX_FMT_SBGGR10,
+		.code		= MEDIA_BUS_FMT_SBGGR10_1X10,
+		.depth		= 10,
+		.csi_dt		= 0x2b,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGBRG10P,
+		.repacked_fourcc = V4L2_PIX_FMT_SGBRG10,
+		.code		= MEDIA_BUS_FMT_SGBRG10_1X10,
+		.depth		= 10,
+		.csi_dt		= 0x2b,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGRBG10P,
+		.repacked_fourcc = V4L2_PIX_FMT_SGRBG10,
+		.code		= MEDIA_BUS_FMT_SGRBG10_1X10,
+		.depth		= 10,
+		.csi_dt		= 0x2b,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SRGGB10P,
+		.repacked_fourcc = V4L2_PIX_FMT_SRGGB10,
+		.code		= MEDIA_BUS_FMT_SRGGB10_1X10,
+		.depth		= 10,
+		.csi_dt		= 0x2b,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SBGGR12P,
+		.repacked_fourcc = V4L2_PIX_FMT_SBGGR12,
+		.code		= MEDIA_BUS_FMT_SBGGR12_1X12,
+		.depth		= 12,
+		.csi_dt		= 0x2c,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGBRG12P,
+		.repacked_fourcc = V4L2_PIX_FMT_SGBRG12,
+		.code		= MEDIA_BUS_FMT_SGBRG12_1X12,
+		.depth		= 12,
+		.csi_dt		= 0x2c,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGRBG12P,
+		.repacked_fourcc = V4L2_PIX_FMT_SGRBG12,
+		.code		= MEDIA_BUS_FMT_SGRBG12_1X12,
+		.depth		= 12,
+		.csi_dt		= 0x2c,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SRGGB12P,
+		.repacked_fourcc = V4L2_PIX_FMT_SRGGB12,
+		.code		= MEDIA_BUS_FMT_SRGGB12_1X12,
+		.depth		= 12,
+		.csi_dt		= 0x2c,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SBGGR14P,
+		.repacked_fourcc = V4L2_PIX_FMT_SBGGR14,
+		.code		= MEDIA_BUS_FMT_SBGGR14_1X14,
+		.depth		= 14,
+		.csi_dt		= 0x2d,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGBRG14P,
+		.repacked_fourcc = V4L2_PIX_FMT_SGBRG14,
+		.code		= MEDIA_BUS_FMT_SGBRG14_1X14,
+		.depth		= 14,
+		.csi_dt		= 0x2d,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGRBG14P,
+		.repacked_fourcc = V4L2_PIX_FMT_SGRBG14,
+		.code		= MEDIA_BUS_FMT_SGRBG14_1X14,
+		.depth		= 14,
+		.csi_dt		= 0x2d,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SRGGB14P,
+		.repacked_fourcc = V4L2_PIX_FMT_SRGGB14,
+		.code		= MEDIA_BUS_FMT_SRGGB14_1X14,
+		.depth		= 14,
+		.csi_dt		= 0x2d,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+	/*
+	 * 16 bit Bayer formats could be supported, but there is no CSI2
+	 * data_type defined for raw 16, and no sensors that produce it at
+	 * present.
+	 */
+
+	/* Greyscale formats */
+		.fourcc		= V4L2_PIX_FMT_GREY,
+		.code		= MEDIA_BUS_FMT_Y8_1X8,
+		.depth		= 8,
+		.csi_dt		= 0x2a,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_Y10P,
+		.repacked_fourcc = V4L2_PIX_FMT_Y10,
+		.code		= MEDIA_BUS_FMT_Y10_1X10,
+		.depth		= 10,
+		.csi_dt		= 0x2b,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_Y12P,
+		.repacked_fourcc = V4L2_PIX_FMT_Y12,
+		.code		= MEDIA_BUS_FMT_Y12_1X12,
+		.depth		= 12,
+		.csi_dt		= 0x2c,
+		.valid_colorspaces = MASK_CS_RAW,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_Y14P,
+		.repacked_fourcc = V4L2_PIX_FMT_Y14,
+		.code		= MEDIA_BUS_FMT_Y14_1X14,
+		.depth		= 14,
+		.csi_dt		= 0x2d,
+		.valid_colorspaces = MASK_CS_RAW,
+	},
+	/* Embedded data format */
+	{
+		.fourcc		= V4L2_META_FMT_8,
+		.code		= MEDIA_BUS_FMT_METADATA_8,
+		.depth		= 8,
+		.metadata_fmt	= 1,
+	}
+};
+
+struct unicam_buffer {
+	struct vb2_v4l2_buffer vb;
+	struct list_head list;
+};
+
+static inline struct unicam_buffer *to_unicam_buffer(struct vb2_buffer *vb)
+{
+	return container_of(vb, struct unicam_buffer, vb.vb2_buf);
+}
+
+struct unicam_node {
+	bool registered;
+	int open;
+	bool streaming;
+	unsigned int node_id;
+	/* Source pad id on the sensor for this node */
+	unsigned int src_pad_id;
+	/* Pointer pointing to current v4l2_buffer */
+	struct unicam_buffer *cur_frm;
+	/* Pointer pointing to next v4l2_buffer */
+	struct unicam_buffer *next_frm;
+	/* video capture */
+	const struct unicam_fmt *fmt;
+	/* Used to store current pixel format */
+	struct v4l2_format v_fmt;
+	/* Used to store current mbus frame format */
+	struct v4l2_mbus_framefmt m_fmt;
+	/* Buffer queue used in video-buf */
+	struct vb2_queue buffer_queue;
+	/* Queue of filled frames */
+	struct list_head dma_queue;
+	/* IRQ lock for DMA queue */
+	spinlock_t dma_queue_lock;
+	/* lock used to access this structure */
+	struct mutex lock;
+	/* Identifies video device for this channel */
+	struct video_device video_dev;
+	/* Pointer to the parent handle */
+	struct unicam_device *dev;
+	struct media_pad pad;
+	unsigned int embedded_lines;
+	struct media_pipeline pipe;
+	/*
+	 * Dummy buffer intended to be used by unicam
+	 * if we have no other queued buffers to swap to.
+	 */
+	void *dummy_buf_cpu_addr;
+	dma_addr_t dummy_buf_dma_addr;
+};
+
+struct unicam_device {
+	struct kref kref;
+
+	/* V4l2 specific parameters */
+	struct v4l2_async_subdev asd;
+
+	/* peripheral base address */
+	void __iomem *base;
+	/* clock gating base address */
+	void __iomem *clk_gate_base;
+	/* lp clock handle */
+	struct clk *clock;
+	/* vpu clock handle */
+	struct clk *vpu_clock;
+	/* vpu clock request */
+	struct clk_request *vpu_req;
+	/* clock status for error handling */
+	bool clocks_enabled;
+	/* V4l2 device */
+	struct v4l2_device v4l2_dev;
+	struct media_device mdev;
+
+	/* parent device */
+	struct platform_device *pdev;
+	/* subdevice async Notifier */
+	struct v4l2_async_notifier notifier;
+	unsigned int sequence;
+
+	/* ptr to  sub device */
+	struct v4l2_subdev *sensor;
+	/* Pad config for the sensor */
+	struct v4l2_subdev_state *sensor_state;
+
+	/* Internal subdev */
+	struct v4l2_subdev sd;
+	struct media_pad pads[UNICAM_SD_NUM_PADS];
+
+	bool streaming;
+
+	enum v4l2_mbus_type bus_type;
+	/*
+	 * Stores bus.mipi_csi2.flags for CSI2 sensors, or
+	 * bus.mipi_csi1.strobe for CCP2.
+	 */
+	unsigned int bus_flags;
+	unsigned int max_data_lanes;
+	unsigned int active_data_lanes;
+	bool sensor_embedded_data;
+
+	struct unicam_node node[MAX_NODES];
+	struct v4l2_ctrl_handler ctrl_handler;
+
+	bool mc_api;
+};
+
+static inline struct unicam_device *
+to_unicam_device(struct v4l2_device *v4l2_dev)
+{
+	return container_of(v4l2_dev, struct unicam_device, v4l2_dev);
+}
+
+static inline struct unicam_device *
+sd_to_unicam_device(struct v4l2_subdev *sd)
+{
+	return container_of(sd, struct unicam_device, sd);
+}
+
+static inline bool is_metadata_node(struct unicam_node *node)
+{
+	return node->video_dev.device_caps & V4L2_CAP_META_CAPTURE;
+}
+
+static inline bool is_image_node(struct unicam_node *node)
+{
+	return node->video_dev.device_caps & V4L2_CAP_VIDEO_CAPTURE;
+}
+
+/* Hardware access */
+static inline void clk_write(struct unicam_device *dev, u32 val)
+{
+	writel(val | 0x5a000000, dev->clk_gate_base);
+}
+
+static inline u32 reg_read(struct unicam_device *dev, u32 offset)
+{
+	return readl(dev->base + offset);
+}
+
+static inline void reg_write(struct unicam_device *dev, u32 offset, u32 val)
+{
+	writel(val, dev->base + offset);
+}
+
+static inline int get_field(u32 value, u32 mask)
+{
+	return (value & mask) >> __ffs(mask);
+}
+
+static inline void set_field(u32 *valp, u32 field, u32 mask)
+{
+	u32 val = *valp;
+
+	val &= ~mask;
+	val |= (field << __ffs(mask)) & mask;
+	*valp = val;
+}
+
+static inline u32 reg_read_field(struct unicam_device *dev, u32 offset,
+				 u32 mask)
+{
+	return get_field(reg_read(dev, offset), mask);
+}
+
+static inline void reg_write_field(struct unicam_device *dev, u32 offset,
+				   u32 field, u32 mask)
+{
+	u32 val = reg_read(dev, offset);
+
+	set_field(&val, field, mask);
+	reg_write(dev, offset, val);
+}
+
+/* Power management functions */
+static inline int unicam_runtime_get(struct unicam_device *dev)
+{
+	return pm_runtime_get_sync(&dev->pdev->dev);
+}
+
+static inline void unicam_runtime_put(struct unicam_device *dev)
+{
+	pm_runtime_put_sync(&dev->pdev->dev);
+}
+
+/* Format setup functions */
+static const struct unicam_fmt *find_format_by_code(u32 code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(formats); i++) {
+		if (formats[i].code == code)
+			return &formats[i];
+	}
+
+	return NULL;
+}
+
+static const struct unicam_fmt *find_format_by_fourcc(u32 fourcc)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(formats); ++i) {
+		if (formats[i].fourcc == fourcc)
+			return &formats[i];
+	}
+
+	return NULL;
+}
+
+static unsigned int bytes_per_line(u32 width, const struct unicam_fmt *fmt,
+				   u32 v4l2_fourcc)
+{
+	if (v4l2_fourcc == fmt->repacked_fourcc)
+		/* Repacking always goes to 16bpp */
+		return ALIGN(width << 1, BPL_ALIGNMENT);
+	else
+		return ALIGN((width * fmt->depth) >> 3, BPL_ALIGNMENT);
+}
+
+static int unicam_calc_format_size_bpl(struct unicam_device *dev,
+				       const struct unicam_fmt *fmt,
+				       struct v4l2_format *f)
+{
+	unsigned int min_bytesperline;
+
+	v4l_bound_align_image(&f->fmt.pix.width, MIN_WIDTH, MAX_WIDTH, 2,
+			      &f->fmt.pix.height, MIN_HEIGHT, MAX_HEIGHT, 0,
+			      0);
+
+	min_bytesperline = bytes_per_line(f->fmt.pix.width, fmt,
+					  f->fmt.pix.pixelformat);
+
+	if (f->fmt.pix.bytesperline > min_bytesperline &&
+	    f->fmt.pix.bytesperline <= MAX_BYTESPERLINE)
+		f->fmt.pix.bytesperline = ALIGN(f->fmt.pix.bytesperline,
+						BPL_ALIGNMENT);
+	else
+		f->fmt.pix.bytesperline = min_bytesperline;
+
+	f->fmt.pix.sizeimage = f->fmt.pix.height * f->fmt.pix.bytesperline;
+
+	dev_dbg(dev->v4l2_dev.dev, "%s: fourcc: %08X size: %dx%d bpl:%d img_size:%d\n",
+		__func__,
+		f->fmt.pix.pixelformat,
+		f->fmt.pix.width, f->fmt.pix.height,
+		f->fmt.pix.bytesperline, f->fmt.pix.sizeimage);
+
+	return 0;
+}
+
+static void unicam_wr_dma_addr(struct unicam_device *dev, dma_addr_t dmaaddr,
+			       unsigned int buffer_size, int node_id)
+{
+	dma_addr_t endaddr = dmaaddr + buffer_size;
+
+	if (node_id == IMAGE_NODE) {
+		reg_write(dev, UNICAM_IBSA0, dmaaddr);
+		reg_write(dev, UNICAM_IBEA0, endaddr);
+	} else {
+		reg_write(dev, UNICAM_DBSA0, dmaaddr);
+		reg_write(dev, UNICAM_DBEA0, endaddr);
+	}
+}
+
+static unsigned int unicam_get_lines_done(struct unicam_device *dev)
+{
+	dma_addr_t start_addr, cur_addr;
+	unsigned int stride = dev->node[IMAGE_NODE].v_fmt.fmt.pix.bytesperline;
+	struct unicam_buffer *frm = dev->node[IMAGE_NODE].cur_frm;
+
+	if (!frm)
+		return 0;
+
+	start_addr = vb2_dma_contig_plane_dma_addr(&frm->vb.vb2_buf, 0);
+	cur_addr = reg_read(dev, UNICAM_IBWP);
+	return (unsigned int)(cur_addr - start_addr) / stride;
+}
+
+static void unicam_schedule_next_buffer(struct unicam_node *node)
+{
+	struct unicam_device *dev = node->dev;
+	struct unicam_buffer *buf;
+	unsigned int size;
+	dma_addr_t addr;
+
+	buf = list_first_entry(&node->dma_queue, struct unicam_buffer, list);
+	node->next_frm = buf;
+	list_del(&buf->list);
+
+	addr = vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
+	if (is_image_node(node)) {
+		size = node->v_fmt.fmt.pix.sizeimage;
+		unicam_wr_dma_addr(dev, addr, size, IMAGE_NODE);
+	} else {
+		size = node->v_fmt.fmt.meta.buffersize;
+		unicam_wr_dma_addr(dev, addr, size, METADATA_NODE);
+	}
+}
+
+static void unicam_schedule_dummy_buffer(struct unicam_node *node)
+{
+	struct unicam_device *dev = node->dev;
+	int node_id = is_image_node(node) ? IMAGE_NODE : METADATA_NODE;
+
+	dev_dbg(dev->v4l2_dev.dev, "Scheduling dummy buffer for node %d\n", node_id);
+
+	unicam_wr_dma_addr(dev, node->dummy_buf_dma_addr, DUMMY_BUF_SIZE,
+			   node_id);
+	node->next_frm = NULL;
+}
+
+static void unicam_process_buffer_complete(struct unicam_node *node,
+					   unsigned int sequence)
+{
+	node->cur_frm->vb.field = node->m_fmt.field;
+	node->cur_frm->vb.sequence = sequence;
+
+	vb2_buffer_done(&node->cur_frm->vb.vb2_buf, VB2_BUF_STATE_DONE);
+}
+
+static void unicam_queue_event_sof(struct unicam_device *unicam)
+{
+	struct v4l2_event event = {
+		.type = V4L2_EVENT_FRAME_SYNC,
+		.u.frame_sync.frame_sequence = unicam->sequence,
+	};
+
+	v4l2_event_queue(&unicam->node[IMAGE_NODE].video_dev, &event);
+}
+
+/*
+ * unicam_isr : ISR handler for unicam capture
+ * @irq: irq number
+ * @dev_id: dev_id ptr
+ *
+ * It changes status of the captured buffer, takes next buffer from the queue
+ * and sets its address in unicam registers
+ */
+static irqreturn_t unicam_isr(int irq, void *dev)
+{
+	struct unicam_device *unicam = dev;
+	unsigned int lines_done = unicam_get_lines_done(dev);
+	unsigned int sequence = unicam->sequence;
+	unsigned int i;
+	u32 ista, sta;
+	bool fe;
+	u64 ts;
+
+	sta = reg_read(unicam, UNICAM_STA);
+	/* Write value back to clear the interrupts */
+	reg_write(unicam, UNICAM_STA, sta);
+
+	ista = reg_read(unicam, UNICAM_ISTA);
+	/* Write value back to clear the interrupts */
+	reg_write(unicam, UNICAM_ISTA, ista);
+
+	dev_dbg(unicam->v4l2_dev.dev, "ISR: ISTA: 0x%X, STA: 0x%X, sequence %d, lines done %d",
+		ista, sta, sequence, lines_done);
+
+	if (!(sta & (UNICAM_IS | UNICAM_PI0)))
+		return IRQ_HANDLED;
+
+	/*
+	 * Look for either the Frame End interrupt or the Packet Capture status
+	 * to signal a frame end.
+	 */
+	fe = (ista & UNICAM_FEI || sta & UNICAM_PI0);
+
+	/*
+	 * We must run the frame end handler first. If we have a valid next_frm
+	 * and we get a simultaneout FE + FS interrupt, running the FS handler
+	 * first would null out the next_frm ptr and we would have lost the
+	 * buffer forever.
+	 */
+	if (fe) {
+		/*
+		 * Ensure we have swapped buffers already as we can't
+		 * stop the peripheral. If no buffer is available, use a
+		 * dummy buffer to dump out frames until we get a new buffer
+		 * to use.
+		 */
+		for (i = 0; i < ARRAY_SIZE(unicam->node); i++) {
+			if (!unicam->node[i].streaming)
+				continue;
+
+			/*
+			 * If cur_frm == next_frm, it means we have not had
+			 * a chance to swap buffers, likely due to having
+			 * multiple interrupts occurring simultaneously (like FE
+			 * + FS + LS). In this case, we cannot signal the buffer
+			 * as complete, as the HW will reuse that buffer.
+			 */
+			if (unicam->node[i].cur_frm &&
+			    unicam->node[i].cur_frm != unicam->node[i].next_frm)
+				unicam_process_buffer_complete(&unicam->node[i],
+							       sequence);
+			unicam->node[i].cur_frm = unicam->node[i].next_frm;
+		}
+		unicam->sequence++;
+	}
+
+	if (ista & UNICAM_FSI) {
+		/*
+		 * Timestamp is to be when the first data byte was captured,
+		 * aka frame start.
+		 */
+		ts = ktime_get_ns();
+		for (i = 0; i < ARRAY_SIZE(unicam->node); i++) {
+			if (!unicam->node[i].streaming)
+				continue;
+
+			if (unicam->node[i].cur_frm)
+				unicam->node[i].cur_frm->vb.vb2_buf.timestamp =
+								ts;
+			else
+				dev_dbg(unicam->v4l2_dev.dev, "ISR: [%d] Dropping frame, buffer not available at FS\n",
+					i);
+			/*
+			 * Set the next frame output to go to a dummy frame
+			 * if we have not managed to obtain another frame
+			 * from the queue.
+			 */
+			unicam_schedule_dummy_buffer(&unicam->node[i]);
+		}
+
+		unicam_queue_event_sof(unicam);
+	}
+
+	/*
+	 * Cannot swap buffer at frame end, there may be a race condition
+	 * where the HW does not actually swap it if the new frame has
+	 * already started.
+	 */
+	if (ista & (UNICAM_FSI | UNICAM_LCI) && !fe) {
+		for (i = 0; i < ARRAY_SIZE(unicam->node); i++) {
+			if (!unicam->node[i].streaming)
+				continue;
+
+			spin_lock(&unicam->node[i].dma_queue_lock);
+			if (!list_empty(&unicam->node[i].dma_queue) &&
+			    !unicam->node[i].next_frm)
+				unicam_schedule_next_buffer(&unicam->node[i]);
+			spin_unlock(&unicam->node[i].dma_queue_lock);
+		}
+	}
+
+	if (reg_read(unicam, UNICAM_ICTL) & UNICAM_FCM) {
+		/* Switch out of trigger mode if selected */
+		reg_write_field(unicam, UNICAM_ICTL, 1, UNICAM_TFC);
+		reg_write_field(unicam, UNICAM_ICTL, 0, UNICAM_FCM);
+	}
+	return IRQ_HANDLED;
+}
+
+/* V4L2 Common IOCTLs */
+static int unicam_querycap(struct file *file, void *priv,
+			   struct v4l2_capability *cap)
+{
+	struct unicam_node *node = video_drvdata(file);
+	struct unicam_device *dev = node->dev;
+
+	strscpy(cap->driver, UNICAM_MODULE_NAME, sizeof(cap->driver));
+	strscpy(cap->card, UNICAM_MODULE_NAME, sizeof(cap->card));
+
+	snprintf(cap->bus_info, sizeof(cap->bus_info),
+		 "platform:%s", dev_name(&dev->pdev->dev));
+
+	cap->capabilities |= V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_META_CAPTURE;
+
+	return 0;
+}
+
+static int unicam_log_status(struct file *file, void *fh)
+{
+	struct unicam_node *node = video_drvdata(file);
+	struct unicam_device *dev = node->dev;
+	u32 reg;
+
+	/* status for sub devices */
+	v4l2_device_call_all(&dev->v4l2_dev, 0, core, log_status);
+
+	dev_info(dev->v4l2_dev.dev, "-----Receiver status-----\n");
+	dev_info(dev->v4l2_dev.dev, "V4L2 width/height:   %ux%u\n",
+		 node->v_fmt.fmt.pix.width, node->v_fmt.fmt.pix.height);
+	dev_info(dev->v4l2_dev.dev, "Mediabus format:     %08x\n", node->fmt->code);
+	dev_info(dev->v4l2_dev.dev, "V4L2 format:         %08x\n",
+		 node->v_fmt.fmt.pix.pixelformat);
+	reg = reg_read(dev, UNICAM_IPIPE);
+	dev_info(dev->v4l2_dev.dev, "Unpacking/packing:   %u / %u\n",
+		 get_field(reg, UNICAM_PUM_MASK),
+		 get_field(reg, UNICAM_PPM_MASK));
+	dev_info(dev->v4l2_dev.dev, "----Live data----\n");
+	dev_info(dev->v4l2_dev.dev, "Programmed stride:   %4u\n",
+		 reg_read(dev, UNICAM_IBLS));
+	dev_info(dev->v4l2_dev.dev, "Detected resolution: %ux%u\n",
+		 reg_read(dev, UNICAM_IHSTA),
+		 reg_read(dev, UNICAM_IVSTA));
+	dev_info(dev->v4l2_dev.dev, "Write pointer:       %08x\n",
+		 reg_read(dev, UNICAM_IBWP));
+
+	return 0;
+}
+
+static int unicam_subscribe_event(struct v4l2_fh *fh,
+				  const struct v4l2_event_subscription *sub)
+{
+	switch (sub->type) {
+	case V4L2_EVENT_FRAME_SYNC:
+		return v4l2_event_subscribe(fh, sub, 2, NULL);
+	case V4L2_EVENT_SOURCE_CHANGE:
+		return v4l2_event_subscribe(fh, sub, 4, NULL);
+	}
+
+	return v4l2_ctrl_subscribe_event(fh, sub);
+}
+
+static void unicam_notify(struct v4l2_subdev *sd,
+			  unsigned int notification, void *arg)
+{
+	struct unicam_device *dev = to_unicam_device(sd->v4l2_dev);
+
+	switch (notification) {
+	case V4L2_DEVICE_NOTIFY_EVENT:
+		v4l2_event_queue(&dev->node[IMAGE_NODE].video_dev, arg);
+		break;
+	default:
+		break;
+	}
+}
+
+/* V4L2 Media Controller Centric IOCTLs */
+
+static int unicam_mc_enum_fmt_vid_cap(struct file *file, void  *priv,
+				      struct v4l2_fmtdesc *f)
+{
+	int i, j;
+
+	for (i = 0, j = 0; i < ARRAY_SIZE(formats); i++) {
+		if (f->mbus_code && formats[i].code != f->mbus_code)
+			continue;
+		if (formats[i].mc_skip || formats[i].metadata_fmt)
+			continue;
+
+		if (formats[i].fourcc) {
+			if (j == f->index) {
+				f->pixelformat = formats[i].fourcc;
+				f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+				return 0;
+			}
+			j++;
+		}
+		if (formats[i].repacked_fourcc) {
+			if (j == f->index) {
+				f->pixelformat = formats[i].repacked_fourcc;
+				f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+				return 0;
+			}
+			j++;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int unicam_mc_g_fmt_vid_cap(struct file *file, void *priv,
+				   struct v4l2_format *f)
+{
+	struct unicam_node *node = video_drvdata(file);
+
+	if (!is_image_node(node))
+		return -EINVAL;
+
+	*f = node->v_fmt;
+
+	return 0;
+}
+
+static void unicam_mc_try_fmt(struct unicam_node *node, struct v4l2_format *f,
+			      const struct unicam_fmt **ret_fmt)
+{
+	struct v4l2_pix_format *v4l2_format = &f->fmt.pix;
+	struct unicam_device *dev = node->dev;
+	const struct unicam_fmt *fmt;
+	int is_rgb;
+
+	/*
+	 * Default to the first format if the requested pixel format code isn't
+	 * supported.
+	 */
+	fmt = find_format_by_fourcc(v4l2_format->pixelformat);
+	if (!fmt) {
+		fmt = &formats[0];
+		v4l2_format->pixelformat = fmt->fourcc;
+	}
+
+	unicam_calc_format_size_bpl(dev, fmt, f);
+
+	if (v4l2_format->field == V4L2_FIELD_ANY)
+		v4l2_format->field = V4L2_FIELD_NONE;
+
+	if (v4l2_format->colorspace >= MAX_COLORSPACE ||
+	    !(fmt->valid_colorspaces & (1 << v4l2_format->colorspace))) {
+		v4l2_format->colorspace = __ffs(fmt->valid_colorspaces);
+
+		v4l2_format->xfer_func =
+			V4L2_MAP_XFER_FUNC_DEFAULT(v4l2_format->colorspace);
+		v4l2_format->ycbcr_enc =
+			V4L2_MAP_YCBCR_ENC_DEFAULT(v4l2_format->colorspace);
+		is_rgb = v4l2_format->colorspace == V4L2_COLORSPACE_SRGB;
+		v4l2_format->quantization =
+			V4L2_MAP_QUANTIZATION_DEFAULT(is_rgb,
+						      v4l2_format->colorspace,
+						      v4l2_format->ycbcr_enc);
+	}
+
+	if (ret_fmt)
+		*ret_fmt = fmt;
+
+	dev_dbg(dev->v4l2_dev.dev, "%s: %08x %ux%u (bytesperline %u sizeimage %u)\n",
+		__func__, v4l2_format->pixelformat,
+		v4l2_format->width, v4l2_format->height,
+		v4l2_format->bytesperline, v4l2_format->sizeimage);
+}
+
+static int unicam_mc_try_fmt_vid_cap(struct file *file, void *priv,
+				     struct v4l2_format *f)
+{
+	struct unicam_node *node = video_drvdata(file);
+
+	unicam_mc_try_fmt(node, f, NULL);
+	return 0;
+}
+
+static int unicam_mc_s_fmt_vid_cap(struct file *file, void *priv,
+				   struct v4l2_format *f)
+{
+	struct unicam_node *node = video_drvdata(file);
+	struct unicam_device *dev = node->dev;
+	const struct unicam_fmt *fmt;
+
+	if (vb2_is_busy(&node->buffer_queue)) {
+		dev_dbg(dev->v4l2_dev.dev, "%s device busy\n", __func__);
+		return -EBUSY;
+	}
+
+	unicam_mc_try_fmt(node, f, &fmt);
+
+	node->v_fmt = *f;
+	node->fmt = fmt;
+
+	return 0;
+}
+
+static int unicam_mc_enum_framesizes(struct file *file, void *fh,
+				     struct v4l2_frmsizeenum *fsize)
+{
+	struct unicam_node *node = video_drvdata(file);
+	struct unicam_device *dev = node->dev;
+
+	if (fsize->index > 0)
+		return -EINVAL;
+
+	if (!find_format_by_fourcc(fsize->pixel_format)) {
+		dev_dbg(dev->v4l2_dev.dev, "Invalid pixel format 0x%08x\n",
+			fsize->pixel_format);
+		return -EINVAL;
+	}
+
+	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
+	fsize->stepwise.min_width = MIN_WIDTH;
+	fsize->stepwise.max_width = MAX_WIDTH;
+	fsize->stepwise.step_width = 1;
+	fsize->stepwise.min_height = MIN_HEIGHT;
+	fsize->stepwise.max_height = MAX_HEIGHT;
+	fsize->stepwise.step_height = 1;
+
+	return 0;
+}
+
+static int unicam_mc_enum_fmt_meta_cap(struct file *file, void  *priv,
+				       struct v4l2_fmtdesc *f)
+{
+	struct unicam_node *node = video_drvdata(file);
+	int i, j;
+
+	if (!is_metadata_node(node))
+		return -EINVAL;
+
+	for (i = 0, j = 0; i < ARRAY_SIZE(formats); i++) {
+		if (f->mbus_code && formats[i].code != f->mbus_code)
+			continue;
+		if (!formats[i].metadata_fmt)
+			continue;
+
+		if (formats[i].fourcc) {
+			if (j == f->index) {
+				f->pixelformat = formats[i].fourcc;
+				f->type = V4L2_BUF_TYPE_META_CAPTURE;
+				return 0;
+			}
+			j++;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int unicam_mc_g_fmt_meta_cap(struct file *file, void *priv,
+				    struct v4l2_format *f)
+{
+	struct unicam_node *node = video_drvdata(file);
+
+	if (!is_metadata_node(node))
+		return -EINVAL;
+
+	*f = node->v_fmt;
+
+	return 0;
+}
+
+static int unicam_mc_try_fmt_meta_cap(struct file *file, void *priv,
+				      struct v4l2_format *f)
+{
+	struct unicam_node *node = video_drvdata(file);
+
+	if (!is_metadata_node(node))
+		return -EINVAL;
+
+	f->fmt.meta.dataformat = V4L2_META_FMT_8;
+
+	return 0;
+}
+
+static int unicam_mc_s_fmt_meta_cap(struct file *file, void *priv,
+				    struct v4l2_format *f)
+{
+	struct unicam_node *node = video_drvdata(file);
+
+	if (!is_metadata_node(node))
+		return -EINVAL;
+
+	unicam_mc_try_fmt_meta_cap(file, priv, f);
+
+	node->v_fmt = *f;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops unicam_mc_ioctl_ops = {
+	.vidioc_querycap      = unicam_querycap,
+	.vidioc_enum_fmt_vid_cap  = unicam_mc_enum_fmt_vid_cap,
+	.vidioc_g_fmt_vid_cap     = unicam_mc_g_fmt_vid_cap,
+	.vidioc_try_fmt_vid_cap   = unicam_mc_try_fmt_vid_cap,
+	.vidioc_s_fmt_vid_cap     = unicam_mc_s_fmt_vid_cap,
+
+	.vidioc_enum_fmt_meta_cap	= unicam_mc_enum_fmt_meta_cap,
+	.vidioc_g_fmt_meta_cap		= unicam_mc_g_fmt_meta_cap,
+	.vidioc_try_fmt_meta_cap	= unicam_mc_try_fmt_meta_cap,
+	.vidioc_s_fmt_meta_cap		= unicam_mc_s_fmt_meta_cap,
+
+	.vidioc_enum_framesizes   = unicam_mc_enum_framesizes,
+	.vidioc_reqbufs       = vb2_ioctl_reqbufs,
+	.vidioc_create_bufs   = vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf   = vb2_ioctl_prepare_buf,
+	.vidioc_querybuf      = vb2_ioctl_querybuf,
+	.vidioc_qbuf          = vb2_ioctl_qbuf,
+	.vidioc_dqbuf         = vb2_ioctl_dqbuf,
+	.vidioc_expbuf        = vb2_ioctl_expbuf,
+	.vidioc_streamon      = vb2_ioctl_streamon,
+	.vidioc_streamoff     = vb2_ioctl_streamoff,
+
+	.vidioc_log_status		= unicam_log_status,
+	.vidioc_subscribe_event		= unicam_subscribe_event,
+	.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
+};
+
+static const struct media_entity_operations unicam_mc_entity_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+	.has_route = v4l2_subdev_has_route,
+};
+
+/* videobuf2 Operations */
+
+static int unicam_queue_setup(struct vb2_queue *vq,
+			      unsigned int *nbuffers,
+			      unsigned int *nplanes,
+			      unsigned int sizes[],
+			      struct device *alloc_devs[])
+{
+	struct unicam_node *node = vb2_get_drv_priv(vq);
+	struct unicam_device *dev = node->dev;
+	unsigned int size = is_image_node(node) ?
+				node->v_fmt.fmt.pix.sizeimage :
+				node->v_fmt.fmt.meta.buffersize;
+
+	if (vq->num_buffers + *nbuffers < 3)
+		*nbuffers = 3 - vq->num_buffers;
+
+	if (*nplanes) {
+		if (sizes[0] < size) {
+			dev_err(dev->v4l2_dev.dev, "sizes[0] %i < size %u\n", sizes[0],
+				size);
+			return -EINVAL;
+		}
+		size = sizes[0];
+	}
+
+	*nplanes = 1;
+	sizes[0] = size;
+
+	return 0;
+}
+
+static int unicam_buffer_prepare(struct vb2_buffer *vb)
+{
+	struct unicam_node *node = vb2_get_drv_priv(vb->vb2_queue);
+	struct unicam_device *dev = node->dev;
+	struct unicam_buffer *buf = to_unicam_buffer(vb);
+	unsigned long size;
+
+	if (WARN_ON(!node->fmt))
+		return -EINVAL;
+
+	size = is_image_node(node) ? node->v_fmt.fmt.pix.sizeimage :
+				     node->v_fmt.fmt.meta.buffersize;
+	if (vb2_plane_size(vb, 0) < size) {
+		dev_err(dev->v4l2_dev.dev, "data will not fit into plane (%lu < %lu)\n",
+			vb2_plane_size(vb, 0), size);
+		return -EINVAL;
+	}
+
+	vb2_set_plane_payload(&buf->vb.vb2_buf, 0, size);
+	return 0;
+}
+
+static void unicam_buffer_queue(struct vb2_buffer *vb)
+{
+	struct unicam_node *node = vb2_get_drv_priv(vb->vb2_queue);
+	struct unicam_buffer *buf = to_unicam_buffer(vb);
+	unsigned long flags;
+
+	spin_lock_irqsave(&node->dma_queue_lock, flags);
+	list_add_tail(&buf->list, &node->dma_queue);
+	spin_unlock_irqrestore(&node->dma_queue_lock, flags);
+}
+
+static void unicam_set_packing_config(struct unicam_device *dev)
+{
+	u32 pack, unpack;
+	u32 val;
+
+	if (dev->node[IMAGE_NODE].v_fmt.fmt.pix.pixelformat ==
+	    dev->node[IMAGE_NODE].fmt->fourcc) {
+		unpack = UNICAM_PUM_NONE;
+		pack = UNICAM_PPM_NONE;
+	} else {
+		switch (dev->node[IMAGE_NODE].fmt->depth) {
+		case 8:
+			unpack = UNICAM_PUM_UNPACK8;
+			break;
+		case 10:
+			unpack = UNICAM_PUM_UNPACK10;
+			break;
+		case 12:
+			unpack = UNICAM_PUM_UNPACK12;
+			break;
+		case 14:
+			unpack = UNICAM_PUM_UNPACK14;
+			break;
+		case 16:
+			unpack = UNICAM_PUM_UNPACK16;
+			break;
+		default:
+			unpack = UNICAM_PUM_NONE;
+			break;
+		}
+
+		/* Repacking is always to 16bpp */
+		pack = UNICAM_PPM_PACK16;
+	}
+
+	val = 0;
+	set_field(&val, unpack, UNICAM_PUM_MASK);
+	set_field(&val, pack, UNICAM_PPM_MASK);
+	reg_write(dev, UNICAM_IPIPE, val);
+}
+
+static void unicam_cfg_image_id(struct unicam_device *dev)
+{
+	if (dev->bus_type == V4L2_MBUS_CSI2_DPHY) {
+		/* CSI2 mode, hardcode VC 0 for now. */
+		reg_write(dev, UNICAM_IDI0,
+			  (0 << 6) | dev->node[IMAGE_NODE].fmt->csi_dt);
+	} else {
+		/* CCP2 mode */
+		reg_write(dev, UNICAM_IDI0,
+			  0x80 | dev->node[IMAGE_NODE].fmt->csi_dt);
+	}
+}
+
+static void unicam_enable_ed(struct unicam_device *dev)
+{
+	u32 val = reg_read(dev, UNICAM_DCS);
+
+	set_field(&val, 2, UNICAM_EDL_MASK);
+	/* Do not wrap at the end of the embedded data buffer */
+	set_field(&val, 0, UNICAM_DBOB);
+
+	reg_write(dev, UNICAM_DCS, val);
+}
+
+static void unicam_start_rx(struct unicam_device *dev, dma_addr_t *addr)
+{
+	int line_int_freq = dev->node[IMAGE_NODE].v_fmt.fmt.pix.height >> 2;
+	unsigned int size, i;
+	u32 val;
+
+	if (line_int_freq < 128)
+		line_int_freq = 128;
+
+	/* Enable lane clocks */
+	val = 1;
+	for (i = 0; i < dev->active_data_lanes; i++)
+		val = val << 2 | 1;
+	clk_write(dev, val);
+
+	/* Basic init */
+	reg_write(dev, UNICAM_CTRL, UNICAM_MEM);
+
+	/* Enable analogue control, and leave in reset. */
+	val = UNICAM_AR;
+	set_field(&val, 7, UNICAM_CTATADJ_MASK);
+	set_field(&val, 7, UNICAM_PTATADJ_MASK);
+	reg_write(dev, UNICAM_ANA, val);
+	usleep_range(1000, 2000);
+
+	/* Come out of reset */
+	reg_write_field(dev, UNICAM_ANA, 0, UNICAM_AR);
+
+	/* Peripheral reset */
+	reg_write_field(dev, UNICAM_CTRL, 1, UNICAM_CPR);
+	reg_write_field(dev, UNICAM_CTRL, 0, UNICAM_CPR);
+
+	reg_write_field(dev, UNICAM_CTRL, 0, UNICAM_CPE);
+
+	/* Enable Rx control. */
+	val = reg_read(dev, UNICAM_CTRL);
+	if (dev->bus_type == V4L2_MBUS_CSI2_DPHY) {
+		set_field(&val, UNICAM_CPM_CSI2, UNICAM_CPM_MASK);
+		set_field(&val, UNICAM_DCM_STROBE, UNICAM_DCM_MASK);
+	} else {
+		set_field(&val, UNICAM_CPM_CCP2, UNICAM_CPM_MASK);
+		set_field(&val, dev->bus_flags, UNICAM_DCM_MASK);
+	}
+	/* Packet framer timeout */
+	set_field(&val, 0xf, UNICAM_PFT_MASK);
+	set_field(&val, 128, UNICAM_OET_MASK);
+	reg_write(dev, UNICAM_CTRL, val);
+
+	reg_write(dev, UNICAM_IHWIN, 0);
+	reg_write(dev, UNICAM_IVWIN, 0);
+
+	/* AXI bus access QoS setup */
+	val = reg_read(dev, UNICAM_PRI);
+	set_field(&val, 0, UNICAM_BL_MASK);
+	set_field(&val, 0, UNICAM_BS_MASK);
+	set_field(&val, 0xe, UNICAM_PP_MASK);
+	set_field(&val, 8, UNICAM_NP_MASK);
+	set_field(&val, 2, UNICAM_PT_MASK);
+	set_field(&val, 1, UNICAM_PE);
+	reg_write(dev, UNICAM_PRI, val);
+
+	reg_write_field(dev, UNICAM_ANA, 0, UNICAM_DDL);
+
+	/* Always start in trigger frame capture mode (UNICAM_FCM set) */
+	val = UNICAM_FSIE | UNICAM_FEIE | UNICAM_FCM | UNICAM_IBOB;
+	set_field(&val, line_int_freq, UNICAM_LCIE_MASK);
+	reg_write(dev, UNICAM_ICTL, val);
+	reg_write(dev, UNICAM_STA, UNICAM_STA_MASK_ALL);
+	reg_write(dev, UNICAM_ISTA, UNICAM_ISTA_MASK_ALL);
+
+	/* tclk_term_en */
+	reg_write_field(dev, UNICAM_CLT, 2, UNICAM_CLT1_MASK);
+	/* tclk_settle */
+	reg_write_field(dev, UNICAM_CLT, 6, UNICAM_CLT2_MASK);
+	/* td_term_en */
+	reg_write_field(dev, UNICAM_DLT, 2, UNICAM_DLT1_MASK);
+	/* ths_settle */
+	reg_write_field(dev, UNICAM_DLT, 6, UNICAM_DLT2_MASK);
+	/* trx_enable */
+	reg_write_field(dev, UNICAM_DLT, 0, UNICAM_DLT3_MASK);
+
+	reg_write_field(dev, UNICAM_CTRL, 0, UNICAM_SOE);
+
+	/* Packet compare setup - required to avoid missing frame ends */
+	val = 0;
+	set_field(&val, 1, UNICAM_PCE);
+	set_field(&val, 1, UNICAM_GI);
+	set_field(&val, 1, UNICAM_CPH);
+	set_field(&val, 0, UNICAM_PCVC_MASK);
+	set_field(&val, 1, UNICAM_PCDT_MASK);
+	reg_write(dev, UNICAM_CMP0, val);
+
+	/* Enable clock lane and set up terminations */
+	val = 0;
+	if (dev->bus_type == V4L2_MBUS_CSI2_DPHY) {
+		/* CSI2 */
+		set_field(&val, 1, UNICAM_CLE);
+		set_field(&val, 1, UNICAM_CLLPE);
+		if (dev->bus_flags & V4L2_MBUS_CSI2_CONTINUOUS_CLOCK) {
+			set_field(&val, 1, UNICAM_CLTRE);
+			set_field(&val, 1, UNICAM_CLHSE);
+		}
+	} else {
+		/* CCP2 */
+		set_field(&val, 1, UNICAM_CLE);
+		set_field(&val, 1, UNICAM_CLHSE);
+		set_field(&val, 1, UNICAM_CLTRE);
+	}
+	reg_write(dev, UNICAM_CLK, val);
+
+	/*
+	 * Enable required data lanes with appropriate terminations.
+	 * The same value needs to be written to UNICAM_DATn registers for
+	 * the active lanes, and 0 for inactive ones.
+	 */
+	val = 0;
+	if (dev->bus_type == V4L2_MBUS_CSI2_DPHY) {
+		/* CSI2 */
+		set_field(&val, 1, UNICAM_DLE);
+		set_field(&val, 1, UNICAM_DLLPE);
+		if (dev->bus_flags & V4L2_MBUS_CSI2_CONTINUOUS_CLOCK) {
+			set_field(&val, 1, UNICAM_DLTRE);
+			set_field(&val, 1, UNICAM_DLHSE);
+		}
+	} else {
+		/* CCP2 */
+		set_field(&val, 1, UNICAM_DLE);
+		set_field(&val, 1, UNICAM_DLHSE);
+		set_field(&val, 1, UNICAM_DLTRE);
+	}
+	reg_write(dev, UNICAM_DAT0, val);
+
+	if (dev->active_data_lanes == 1)
+		val = 0;
+	reg_write(dev, UNICAM_DAT1, val);
+
+	if (dev->max_data_lanes > 2) {
+		/*
+		 * Registers UNICAM_DAT2 and UNICAM_DAT3 only valid if the
+		 * instance supports more than 2 data lanes.
+		 */
+		if (dev->active_data_lanes == 2)
+			val = 0;
+		reg_write(dev, UNICAM_DAT2, val);
+
+		if (dev->active_data_lanes == 3)
+			val = 0;
+		reg_write(dev, UNICAM_DAT3, val);
+	}
+
+	reg_write(dev, UNICAM_IBLS,
+		  dev->node[IMAGE_NODE].v_fmt.fmt.pix.bytesperline);
+	size = dev->node[IMAGE_NODE].v_fmt.fmt.pix.sizeimage;
+	unicam_wr_dma_addr(dev, addr[IMAGE_NODE], size, IMAGE_NODE);
+	unicam_set_packing_config(dev);
+	unicam_cfg_image_id(dev);
+
+	val = reg_read(dev, UNICAM_MISC);
+	set_field(&val, 1, UNICAM_FL0);
+	set_field(&val, 1, UNICAM_FL1);
+	reg_write(dev, UNICAM_MISC, val);
+
+	if (dev->node[METADATA_NODE].streaming && dev->sensor_embedded_data) {
+		dev_dbg(dev->v4l2_dev.dev, "enable metadata dma\n");
+		size = dev->node[METADATA_NODE].v_fmt.fmt.meta.buffersize;
+		unicam_enable_ed(dev);
+		unicam_wr_dma_addr(dev, addr[METADATA_NODE], size, METADATA_NODE);
+	}
+
+	/* Enable peripheral */
+	reg_write_field(dev, UNICAM_CTRL, 1, UNICAM_CPE);
+
+	/* Load image pointers */
+	reg_write_field(dev, UNICAM_ICTL, 1, UNICAM_LIP_MASK);
+
+	/* Load embedded data buffer pointers if needed */
+	if (dev->node[METADATA_NODE].streaming && dev->sensor_embedded_data)
+		reg_write_field(dev, UNICAM_DCS, 1, UNICAM_LDP);
+
+	/*
+	 * Enable trigger only for the first frame to
+	 * sync correctly to the FS from the source.
+	 */
+	reg_write_field(dev, UNICAM_ICTL, 1, UNICAM_TFC);
+}
+
+static void unicam_disable(struct unicam_device *dev)
+{
+	/* Analogue lane control disable */
+	reg_write_field(dev, UNICAM_ANA, 1, UNICAM_DDL);
+
+	/* Stop the output engine */
+	reg_write_field(dev, UNICAM_CTRL, 1, UNICAM_SOE);
+
+	/* Disable the data lanes. */
+	reg_write(dev, UNICAM_DAT0, 0);
+	reg_write(dev, UNICAM_DAT1, 0);
+
+	if (dev->max_data_lanes > 2) {
+		reg_write(dev, UNICAM_DAT2, 0);
+		reg_write(dev, UNICAM_DAT3, 0);
+	}
+
+	/* Peripheral reset */
+	reg_write_field(dev, UNICAM_CTRL, 1, UNICAM_CPR);
+	usleep_range(50, 100);
+	reg_write_field(dev, UNICAM_CTRL, 0, UNICAM_CPR);
+
+	/* Disable peripheral */
+	reg_write_field(dev, UNICAM_CTRL, 0, UNICAM_CPE);
+
+	/* Clear ED setup */
+	reg_write(dev, UNICAM_DCS, 0);
+
+	/* Disable all lane clocks */
+	clk_write(dev, 0);
+}
+
+static void unicam_return_buffers(struct unicam_node *node,
+				  enum vb2_buffer_state state)
+{
+	struct unicam_buffer *buf, *tmp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&node->dma_queue_lock, flags);
+	list_for_each_entry_safe(buf, tmp, &node->dma_queue, list) {
+		list_del(&buf->list);
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+	}
+
+	if (node->cur_frm)
+		vb2_buffer_done(&node->cur_frm->vb.vb2_buf,
+				state);
+	if (node->next_frm && node->cur_frm != node->next_frm)
+		vb2_buffer_done(&node->next_frm->vb.vb2_buf,
+				state);
+
+	node->cur_frm = NULL;
+	node->next_frm = NULL;
+	spin_unlock_irqrestore(&node->dma_queue_lock, flags);
+}
+
+static int unicam_video_check_format(struct unicam_node *node)
+{
+	const struct v4l2_mbus_framefmt *format;
+	struct media_pad *remote_pad;
+	struct v4l2_subdev_state *state;
+	int ret = 0;
+
+	remote_pad = media_entity_remote_pad(&node->pad);
+	if (!remote_pad)
+		return -ENODEV;
+
+	state = v4l2_subdev_lock_active_state(node->dev->sensor);
+
+	format = v4l2_state_get_stream_format(state,
+					      remote_pad->index, 0);
+	if (!format) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (node->fmt->code != format->code ||
+	    node->v_fmt.fmt.pix.height != format->height ||
+	    node->v_fmt.fmt.pix.width != format->width ||
+	    node->v_fmt.fmt.pix.field != format->field) {
+		ret = -EPIPE;
+		goto out;
+	}
+
+out:
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
+}
+
+static int unicam_start_streaming(struct vb2_queue *vq, unsigned int count)
+{
+	struct unicam_node *node = vb2_get_drv_priv(vq);
+	struct unicam_device *dev = node->dev;
+	dma_addr_t buffer_addr[MAX_NODES] = { 0 };
+	struct unicam_buffer *buf;
+	unsigned long flags;
+	unsigned int i;
+	int ret;
+
+	node->streaming = true;
+
+	dev->sequence = 0;
+	ret = unicam_runtime_get(dev);
+	if (ret < 0) {
+		dev_dbg(dev->v4l2_dev.dev, "unicam_runtime_get failed\n");
+		goto err_streaming;
+	}
+
+	ret = media_pipeline_start(node->video_dev.entity.pads, &node->pipe);
+	if (ret < 0) {
+		dev_err(dev->v4l2_dev.dev, "Failed to start media pipeline: %d\n", ret);
+		goto err_pm_put;
+	}
+
+	dev->active_data_lanes = dev->max_data_lanes;
+
+	unicam_video_check_format(node);
+
+	dev_dbg(dev->v4l2_dev.dev, "Running with %u data lanes\n",
+		dev->active_data_lanes);
+
+	ret = clk_set_min_rate(dev->vpu_clock, MIN_VPU_CLOCK_RATE);
+	if (ret) {
+		dev_err(dev->v4l2_dev.dev, "failed to set up VPU clock\n");
+		goto error_pipeline;
+	}
+
+	ret = clk_prepare_enable(dev->vpu_clock);
+	if (ret) {
+		dev_err(dev->v4l2_dev.dev, "Failed to enable VPU clock: %d\n", ret);
+		goto error_pipeline;
+	}
+
+	ret = clk_set_rate(dev->clock, 100 * 1000 * 1000);
+	if (ret) {
+		dev_err(dev->v4l2_dev.dev, "failed to set up CSI clock\n");
+		goto err_vpu_clock;
+	}
+
+	ret = clk_prepare_enable(dev->clock);
+	if (ret) {
+		dev_err(dev->v4l2_dev.dev, "Failed to enable CSI clock: %d\n", ret);
+		goto err_vpu_clock;
+	}
+
+	dev_dbg(dev->v4l2_dev.dev, "node %s\n", node->video_dev.name);
+
+	spin_lock_irqsave(&node->dma_queue_lock, flags);
+	buf = list_first_entry(&node->dma_queue,
+			       struct unicam_buffer, list);
+	node->cur_frm = buf;
+	node->next_frm = buf;
+	list_del(&buf->list);
+	spin_unlock_irqrestore(&node->dma_queue_lock, flags);
+
+	buffer_addr[i] =
+		vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
+
+	unicam_start_rx(dev, buffer_addr);
+
+	ret = v4l2_subdev_call(&dev->sd, video, s_stream, 1);
+	if (ret < 0) {
+		dev_err(dev->v4l2_dev.dev, "stream on failed in subdev\n");
+		goto err_disable_unicam;
+	}
+
+	dev->clocks_enabled = true;
+	return 0;
+
+err_disable_unicam:
+	unicam_disable(dev);
+	clk_disable_unprepare(dev->clock);
+err_vpu_clock:
+	if (clk_set_min_rate(dev->vpu_clock, 0))
+		dev_err(dev->v4l2_dev.dev, "failed to reset the VPU clock\n");
+	clk_disable_unprepare(dev->vpu_clock);
+error_pipeline:
+	media_pipeline_stop(node->video_dev.entity.pads);
+err_pm_put:
+	unicam_runtime_put(dev);
+err_streaming:
+	unicam_return_buffers(node, VB2_BUF_STATE_QUEUED);
+	node->streaming = false;
+
+	return ret;
+}
+
+static void unicam_stop_streaming(struct vb2_queue *vq)
+{
+	struct unicam_node *node = vb2_get_drv_priv(vq);
+	struct unicam_device *dev = node->dev;
+
+	node->streaming = false;
+	/*
+	 * Stop streaming the sensor and disable the peripheral.
+	 * We cannot continue streaming embedded data with the
+	 * image pad disabled.
+	 */
+	if (v4l2_subdev_call(&dev->sd, video, s_stream, 0) < 0)
+		dev_err(dev->v4l2_dev.dev, "stream off failed in subdev\n");
+
+	unicam_disable(dev);
+
+	media_pipeline_stop(node->video_dev.entity.pads);
+
+	if (dev->clocks_enabled) {
+		if (clk_set_min_rate(dev->vpu_clock, 0))
+			dev_err(dev->v4l2_dev.dev, "failed to reset the VPU clock\n");
+		clk_disable_unprepare(dev->vpu_clock);
+		clk_disable_unprepare(dev->clock);
+		dev->clocks_enabled = false;
+	}
+	unicam_runtime_put(dev);
+
+	if (is_metadata_node(node)) {
+		/*
+		 * Allow the hardware to spin in the dummy buffer.
+		 * This is only really needed if the embedded data pad is
+		 * disabled before the image pad.
+		 */
+		unicam_wr_dma_addr(dev, node->dummy_buf_dma_addr,
+				   DUMMY_BUF_SIZE, METADATA_NODE);
+	}
+
+	/* Clear all queued buffers for the node */
+	unicam_return_buffers(node, VB2_BUF_STATE_ERROR);
+}
+
+static const struct vb2_ops unicam_video_qops = {
+	.wait_prepare		= vb2_ops_wait_prepare,
+	.wait_finish		= vb2_ops_wait_finish,
+	.queue_setup		= unicam_queue_setup,
+	.buf_prepare		= unicam_buffer_prepare,
+	.buf_queue		= unicam_buffer_queue,
+	.start_streaming	= unicam_start_streaming,
+	.stop_streaming		= unicam_stop_streaming,
+};
+
+/* unicam capture driver file operations */
+static const struct v4l2_file_operations unicam_fops = {
+	.owner		= THIS_MODULE,
+	.open           = v4l2_fh_open,
+	.release        = vb2_fop_release,
+	.poll		= vb2_fop_poll,
+	.unlocked_ioctl = video_ioctl2, /* V4L2 ioctl handler */
+	.mmap           = vb2_fop_mmap,
+};
+
+static int
+unicam_async_bound(struct v4l2_async_notifier *notifier,
+		   struct v4l2_subdev *subdev,
+		   struct v4l2_async_subdev *asd)
+{
+	struct unicam_device *unicam = to_unicam_device(notifier->v4l2_dev);
+
+	if (unicam->sensor) {
+		dev_info(unicam->v4l2_dev.dev, "subdev %s (Already set!!)",
+			 subdev->name);
+		return 0;
+	}
+
+	unicam->sensor = subdev;
+	dev_dbg(unicam->v4l2_dev.dev, "Using sensor %s for capture\n", subdev->name);
+
+	return 0;
+}
+
+static void unicam_release(struct kref *kref)
+{
+	struct unicam_device *unicam =
+		container_of(kref, struct unicam_device, kref);
+
+	v4l2_ctrl_handler_free(&unicam->ctrl_handler);
+	media_device_cleanup(&unicam->mdev);
+
+	if (unicam->sensor_state)
+		__v4l2_subdev_state_free(unicam->sensor_state);
+
+	kfree(unicam);
+}
+
+static void unicam_put(struct unicam_device *unicam)
+{
+	kref_put(&unicam->kref, unicam_release);
+}
+
+static void unicam_get(struct unicam_device *unicam)
+{
+	kref_get(&unicam->kref);
+}
+
+static void unicam_node_release(struct video_device *vdev)
+{
+	struct unicam_node *node = video_get_drvdata(vdev);
+
+	unicam_put(node->dev);
+}
+
+static void unicam_mc_set_default_format(struct unicam_node *node)
+{
+	dev_dbg(node->dev->v4l2_dev.dev, "Set default format for %s node\n",
+		node->node_id == IMAGE_NODE ? "image" : "metadata");
+
+	if (is_image_node(node)) {
+		struct v4l2_pix_format *pix_fmt = &node->v_fmt.fmt.pix;
+
+		pix_fmt->width = 640;
+		pix_fmt->height = 480;
+		pix_fmt->field = V4L2_FIELD_NONE;
+		pix_fmt->colorspace = V4L2_COLORSPACE_SRGB;
+		pix_fmt->ycbcr_enc = V4L2_YCBCR_ENC_601;
+		pix_fmt->quantization = V4L2_QUANTIZATION_LIM_RANGE;
+		pix_fmt->xfer_func = V4L2_XFER_FUNC_SRGB;
+		pix_fmt->pixelformat = formats[0].fourcc;
+		unicam_calc_format_size_bpl(node->dev, &formats[0],
+					    &node->v_fmt);
+		node->v_fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+
+		node->fmt = &formats[0];
+	} else {
+		const struct unicam_fmt *fmt;
+
+		/* Fix this node format as embedded data. */
+		fmt = find_format_by_code(MEDIA_BUS_FMT_METADATA_8);
+		node->v_fmt.fmt.meta.dataformat = fmt->fourcc;
+		node->fmt = fmt;
+		node->v_fmt.fmt.meta.buffersize = UNICAM_EMBEDDED_SIZE;
+		node->embedded_lines = 1;
+		node->v_fmt.type = V4L2_BUF_TYPE_META_CAPTURE;
+	}
+}
+
+static int register_node(struct unicam_device *unicam, struct unicam_node *node,
+			 enum v4l2_buf_type type)
+{
+	struct video_device *vdev;
+	struct vb2_queue *q;
+	int ret;
+
+	node->dev = unicam;
+	node->node_id = type == V4L2_BUF_TYPE_VIDEO_CAPTURE ?
+				IMAGE_NODE :
+				METADATA_NODE;
+
+	spin_lock_init(&node->dma_queue_lock);
+	mutex_init(&node->lock);
+
+	vdev = &node->video_dev;
+	/*
+	 * If the sensor subdevice has any controls, associate the node
+	 *  with the ctrl handler to allow access from userland.
+	 */
+	if (!list_empty(&unicam->ctrl_handler.ctrls))
+		vdev->ctrl_handler = &unicam->ctrl_handler;
+
+	q = &node->buffer_queue;
+	q->type = type;
+	q->io_modes = VB2_MMAP | VB2_DMABUF | VB2_READ;
+	q->drv_priv = node;
+	q->ops = &unicam_video_qops;
+	q->mem_ops = &vb2_dma_contig_memops;
+	q->buf_struct_size = sizeof(struct unicam_buffer);
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->lock = &node->lock;
+	q->min_buffers_needed = 1;
+	q->dev = &unicam->pdev->dev;
+
+	ret = vb2_queue_init(q);
+	if (ret) {
+		dev_err(unicam->v4l2_dev.dev, "vb2_queue_init() failed\n");
+		return ret;
+	}
+
+	INIT_LIST_HEAD(&node->dma_queue);
+
+	vdev->release = unicam_node_release;
+	vdev->fops = &unicam_fops;
+	vdev->ioctl_ops = &unicam_mc_ioctl_ops;
+	vdev->v4l2_dev = &unicam->v4l2_dev;
+	vdev->vfl_dir = VFL_DIR_RX;
+	vdev->queue = q;
+	vdev->lock = &node->lock;
+	vdev->device_caps = (type == V4L2_BUF_TYPE_VIDEO_CAPTURE) ?
+				V4L2_CAP_VIDEO_CAPTURE : V4L2_CAP_META_CAPTURE;
+	vdev->device_caps |= V4L2_CAP_READWRITE | V4L2_CAP_STREAMING | V4L2_CAP_IO_MC;
+	vdev->entity.ops = &unicam_mc_entity_ops;
+
+	/* Define the device names */
+	snprintf(vdev->name, sizeof(vdev->name), "%s-%s", UNICAM_MODULE_NAME,
+		 type == V4L2_BUF_TYPE_VIDEO_CAPTURE ? "image" : "embedded");
+
+	video_set_drvdata(vdev, node);
+	if (type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		vdev->entity.flags |= MEDIA_ENT_FL_DEFAULT;
+	node->pad.flags = MEDIA_PAD_FL_SINK;
+	media_entity_pads_init(&vdev->entity, 1, &node->pad);
+
+	node->dummy_buf_cpu_addr = dma_alloc_coherent(&unicam->pdev->dev,
+						      DUMMY_BUF_SIZE,
+						      &node->dummy_buf_dma_addr,
+						      GFP_KERNEL);
+	if (!node->dummy_buf_cpu_addr) {
+		dev_err(unicam->v4l2_dev.dev, "Unable to allocate dummy buffer.\n");
+		return -ENOMEM;
+	}
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	if (ret) {
+		dev_err(unicam->v4l2_dev.dev, "Unable to register video device %s\n",
+			vdev->name);
+		return ret;
+	}
+
+	/*
+	 * Acquire a reference to unicam, which will be released when the video
+	 * device will be unregistered and userspace will have closed all open
+	 * file handles.
+	 */
+	unicam_get(unicam);
+	node->registered = true;
+
+	ret = media_create_pad_link(&unicam->sd.entity,
+				    node->src_pad_id,
+				    &node->video_dev.entity,
+				    0,
+				    MEDIA_LNK_FL_ENABLED |
+				    MEDIA_LNK_FL_IMMUTABLE);
+	if (ret)
+		dev_err(unicam->v4l2_dev.dev, "Unable to create pad link for %s",
+			unicam->sensor->name);
+
+	unicam_mc_set_default_format(node);
+
+	return ret;
+}
+
+static void unregister_nodes(struct unicam_device *unicam)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(unicam->node); i++) {
+		struct unicam_node *node = &unicam->node[i];
+
+		if (node->dummy_buf_cpu_addr) {
+			dma_free_coherent(&unicam->pdev->dev, DUMMY_BUF_SIZE,
+					  node->dummy_buf_cpu_addr,
+					  node->dummy_buf_dma_addr);
+		}
+
+		if (node->registered) {
+			node->registered = false;
+			video_unregister_device(&node->video_dev);
+		}
+	}
+}
+
+static int unicam_async_complete(struct v4l2_async_notifier *notifier)
+{
+	struct unicam_device *unicam = to_unicam_device(notifier->v4l2_dev);
+	unsigned int i, source_pads = 0;
+	int ret;
+	static struct lock_class_key key;
+
+	unicam->v4l2_dev.notify = unicam_notify;
+
+	unicam->sensor_state = __v4l2_subdev_state_alloc(unicam->sensor,
+							 "unicam:state->lock",
+							 &key);
+	if (!unicam->sensor_state)
+		return -ENOMEM;
+
+	for (i = 0; i < unicam->sd.entity.num_pads; i++) {
+		if (unicam->sd.entity.pads[i].flags & MEDIA_PAD_FL_SOURCE) {
+			if (source_pads < MAX_NODES) {
+				unicam->node[source_pads].src_pad_id = i;
+				dev_dbg(unicam->v4l2_dev.dev, "source pad %u is index %u\n",
+					source_pads, i);
+			}
+			source_pads++;
+		}
+	}
+	if (!source_pads) {
+		dev_err(unicam->v4l2_dev.dev, "No source pads on sensor.\n");
+		goto unregister;
+	}
+
+	ret = register_node(unicam, &unicam->node[IMAGE_NODE],
+			    V4L2_BUF_TYPE_VIDEO_CAPTURE);
+	if (ret) {
+		dev_err(unicam->v4l2_dev.dev, "Unable to register image video device.\n");
+		goto unregister;
+	}
+
+	/* \todo: check before :-) */
+	unicam->sensor_embedded_data = true;
+
+	ret = register_node(unicam, &unicam->node[METADATA_NODE],
+			    V4L2_BUF_TYPE_META_CAPTURE);
+	if (ret) {
+		dev_err(unicam->v4l2_dev.dev, "Unable to register metadata video device.\n");
+		goto unregister;
+	}
+
+	ret = media_create_pad_link(&unicam->sensor->entity,
+				    0,
+				    &unicam->sd.entity,
+				    UNICAM_SD_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED |
+				    MEDIA_LNK_FL_IMMUTABLE);
+	if (ret)
+		dev_err(unicam->v4l2_dev.dev, "Unable to create pad link for %s",
+			unicam->sensor->name);
+
+	ret = v4l2_device_register_subdev_nodes(&unicam->v4l2_dev);
+	if (ret) {
+		dev_err(unicam->v4l2_dev.dev, "Unable to register subdev nodes.\n");
+		goto unregister;
+	}
+
+	/*
+	 * Release the initial reference, all references are now owned by the
+	 * video devices.
+	 */
+	unicam_put(unicam);
+	return 0;
+
+unregister:
+	unregister_nodes(unicam);
+	unicam_put(unicam);
+
+	return ret;
+}
+
+static const struct v4l2_async_notifier_operations unicam_async_ops = {
+	.bound = unicam_async_bound,
+	.complete = unicam_async_complete,
+};
+
+static int of_unicam_connect_subdevs(struct unicam_device *dev)
+{
+	struct platform_device *pdev = dev->pdev;
+	struct v4l2_fwnode_endpoint ep = { };
+	struct device_node *ep_node;
+	struct device_node *sensor_node;
+	unsigned int lane;
+	int ret = -EINVAL;
+
+	if (of_property_read_u32(pdev->dev.of_node, "num-data-lanes",
+				 &dev->max_data_lanes) < 0) {
+		dev_err(dev->v4l2_dev.dev, "number of data lanes not set\n");
+		return -EINVAL;
+	}
+
+	/* Get the local endpoint and remote device. */
+	ep_node = of_graph_get_next_endpoint(pdev->dev.of_node, NULL);
+	if (!ep_node) {
+		dev_dbg(dev->v4l2_dev.dev, "can't get next endpoint\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev->v4l2_dev.dev, "ep_node is %pOF\n", ep_node);
+
+	sensor_node = of_graph_get_remote_port_parent(ep_node);
+	if (!sensor_node) {
+		dev_dbg(dev->v4l2_dev.dev, "can't get remote parent\n");
+		goto cleanup_exit;
+	}
+
+	dev_dbg(dev->v4l2_dev.dev, "found subdevice %pOF\n", sensor_node);
+
+	/* Parse the local endpoint and validate its configuration. */
+	v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep_node), &ep);
+
+	dev_dbg(dev->v4l2_dev.dev, "parsed local endpoint, bus_type %u\n",
+		ep.bus_type);
+
+	dev->bus_type = ep.bus_type;
+
+	switch (ep.bus_type) {
+	case V4L2_MBUS_CSI2_DPHY:
+		switch (ep.bus.mipi_csi2.num_data_lanes) {
+		case 1:
+		case 2:
+		case 4:
+			break;
+
+		default:
+			dev_err(dev->v4l2_dev.dev, "subdevice %pOF: %u data lanes not supported\n",
+				sensor_node,
+				ep.bus.mipi_csi2.num_data_lanes);
+			goto cleanup_exit;
+		}
+
+		for (lane = 0; lane < ep.bus.mipi_csi2.num_data_lanes; lane++) {
+			if (ep.bus.mipi_csi2.data_lanes[lane] != lane + 1) {
+				dev_err(dev->v4l2_dev.dev, "subdevice %pOF: data lanes reordering not supported\n",
+					sensor_node);
+				goto cleanup_exit;
+			}
+		}
+
+		if (ep.bus.mipi_csi2.num_data_lanes > dev->max_data_lanes) {
+			dev_err(dev->v4l2_dev.dev, "subdevice requires %u data lanes when %u are supported\n",
+				ep.bus.mipi_csi2.num_data_lanes,
+				dev->max_data_lanes);
+		}
+
+		dev->max_data_lanes = ep.bus.mipi_csi2.num_data_lanes;
+		dev->bus_flags = ep.bus.mipi_csi2.flags;
+
+		break;
+
+	case V4L2_MBUS_CCP2:
+		if (ep.bus.mipi_csi1.clock_lane != 0 ||
+		    ep.bus.mipi_csi1.data_lane != 1) {
+			dev_err(dev->v4l2_dev.dev, "subdevice %pOF: unsupported lanes configuration\n",
+				sensor_node);
+			goto cleanup_exit;
+		}
+
+		dev->max_data_lanes = 1;
+		dev->bus_flags = ep.bus.mipi_csi1.strobe;
+		break;
+
+	default:
+		/* Unsupported bus type */
+		dev_err(dev->v4l2_dev.dev, "subdevice %pOF: unsupported bus type %u\n",
+			sensor_node, ep.bus_type);
+		goto cleanup_exit;
+	}
+
+	dev_dbg(dev->v4l2_dev.dev, "subdevice %pOF: %s bus, %u data lanes, flags=0x%08x\n",
+		sensor_node,
+		dev->bus_type == V4L2_MBUS_CSI2_DPHY ? "CSI-2" : "CCP2",
+		dev->max_data_lanes, dev->bus_flags);
+
+	/* Initialize and register the async notifier. */
+	v4l2_async_nf_init(&dev->notifier);
+	dev->notifier.ops = &unicam_async_ops;
+
+	dev->asd.match_type = V4L2_ASYNC_MATCH_FWNODE;
+	dev->asd.match.fwnode = fwnode_graph_get_remote_endpoint(of_fwnode_handle(ep_node));
+	ret = v4l2_async_nf_add_subdev(&dev->notifier, &dev->asd);
+	if (ret) {
+		dev_err(dev->v4l2_dev.dev, "Error adding subdevice: %d\n", ret);
+		goto cleanup_exit;
+	}
+
+	ret = v4l2_async_nf_register(&dev->v4l2_dev, &dev->notifier);
+	if (ret) {
+		dev_err(dev->v4l2_dev.dev, "Error registering async notifier: %d\n", ret);
+		ret = -EINVAL;
+	}
+
+cleanup_exit:
+	of_node_put(sensor_node);
+	of_node_put(ep_node);
+
+	return ret;
+}
+
+static int bcm2835_media_dev_init(struct unicam_device *unicam,
+				  struct platform_device *pdev)
+{
+	int ret = 0;
+
+	unicam->mdev.dev = &pdev->dev;
+	strscpy(unicam->mdev.model, UNICAM_MODULE_NAME,
+		sizeof(unicam->mdev.model));
+	strscpy(unicam->mdev.serial, "", sizeof(unicam->mdev.serial));
+	snprintf(unicam->mdev.bus_info, sizeof(unicam->mdev.bus_info),
+		 "platform:%s", dev_name(&pdev->dev));
+	unicam->mdev.hw_revision = 0;
+
+	media_device_init(&unicam->mdev);
+
+	unicam->v4l2_dev.mdev = &unicam->mdev;
+
+	ret = v4l2_device_register(&pdev->dev, &unicam->v4l2_dev);
+
+	return ret;
+}
+
+/* Internal subdev */
+
+static int _unicam_subdev_set_routing(struct v4l2_subdev *sd,
+				      struct v4l2_subdev_state *state,
+				      struct v4l2_subdev_krouting *routing)
+{
+	static const struct v4l2_mbus_framefmt format = {
+		.width = 640,
+		.height = 480,
+		.code = MEDIA_BUS_FMT_UYVY8_2X8,
+		.field = V4L2_FIELD_NONE,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.ycbcr_enc = V4L2_YCBCR_ENC_601,
+		.quantization = V4L2_QUANTIZATION_LIM_RANGE,
+		.xfer_func = V4L2_XFER_FUNC_SRGB,
+		.flags = 0,
+	};
+	int ret;
+
+	ret = v4l2_subdev_routing_validate_1_to_1(routing);
+	if (ret)
+		return ret;
+
+	v4l2_subdev_lock_state(state);
+
+	ret = v4l2_subdev_set_routing_with_fmt(sd, state, routing, &format);
+
+	v4l2_subdev_unlock_state(state);
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int unicam_subdev_set_routing(struct v4l2_subdev *sd,
+				     struct v4l2_subdev_state *state,
+				     enum v4l2_subdev_format_whence which,
+				     struct v4l2_subdev_krouting *routing)
+{
+	struct unicam_device *unicam = sd_to_unicam_device(sd);
+
+	if (which == V4L2_SUBDEV_FORMAT_ACTIVE && unicam->streaming)
+		return -EBUSY;
+
+	return _unicam_subdev_set_routing(sd, state, routing);
+}
+
+static int unicam_subdev_init_cfg(struct v4l2_subdev *sd,
+				  struct v4l2_subdev_state *state)
+{
+	struct v4l2_subdev_route routes[] = {
+		{
+			.sink_pad = 0,
+			.sink_stream = 0,
+			.source_pad = 1,
+			.source_stream = 0,
+			.flags = V4L2_SUBDEV_ROUTE_FL_ACTIVE,
+		},
+	};
+
+	struct v4l2_subdev_krouting routing = {
+		.num_routes = ARRAY_SIZE(routes),
+		.routes = routes,
+	};
+
+	/* Initialize routing to single route to the fist source pad */
+	return _unicam_subdev_set_routing(sd, state, &routing);
+}
+
+static int unicam_subdev_enum_mbus_code(struct v4l2_subdev *sd,
+					struct v4l2_subdev_state *state,
+					struct v4l2_subdev_mbus_code_enum *code)
+{
+	int ret = 0;
+
+	v4l2_subdev_lock_state(state);
+
+	/* No transcoding, source and sink codes must match. */
+	if (unicam_sd_pad_is_source(code->pad)) {
+		struct v4l2_mbus_framefmt *fmt;
+
+		if (code->index > 0) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		fmt = v4l2_subdev_state_get_opposite_stream_format(state,
+								   code->pad,
+								   code->stream);
+		if (!fmt) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		code->code = fmt->code;
+	} else {
+		if (code->index >= ARRAY_SIZE(formats)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		code->code = formats[code->index].code;
+	}
+
+out:
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
+}
+
+static int unicam_subdev_start_streaming(struct unicam_device *unicam)
+{
+	const struct v4l2_subdev_krouting *routing;
+	struct v4l2_subdev_state *state;
+	int ret = 0;
+
+	state = v4l2_subdev_lock_active_state(&unicam->sd);
+
+	routing = &state->routing;
+
+	v4l2_subdev_unlock_state(state);
+
+	unicam->streaming = true;
+
+	ret = v4l2_subdev_call(unicam->sensor, video, s_stream, 1);
+	if (ret) {
+		v4l2_subdev_call(unicam->sensor, video, s_stream, 0);
+		unicam->streaming = false;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int unicam_subdev_stop_streaming(struct unicam_device *unicam)
+{
+	v4l2_subdev_call(unicam->sensor, video, s_stream, 0);
+
+	unicam->streaming = false;
+
+	return 0;
+}
+
+static int unicam_subdev_s_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct unicam_device *unicam = sd_to_unicam_device(sd);
+
+	if (enable)
+		return unicam_subdev_start_streaming(unicam);
+	else
+		return unicam_subdev_stop_streaming(unicam);
+	return 0;
+}
+
+static int unicam_subdev_set_pad_format(struct v4l2_subdev *sd,
+					struct v4l2_subdev_state *state,
+					struct v4l2_subdev_format *format)
+{
+	struct unicam_device *unicam = sd_to_unicam_device(sd);
+	struct v4l2_mbus_framefmt *fmt;
+	int ret = 0;
+
+	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE && unicam->streaming)
+		return -EBUSY;
+
+	/* No transcoding, source and sink formats must match. */
+	if (unicam_sd_pad_is_source(format->pad))
+		return v4l2_subdev_get_fmt(sd, state, format);
+
+	// TODO: implement fmt validation
+
+	v4l2_subdev_lock_state(state);
+
+	fmt = v4l2_state_get_stream_format(state, format->pad, format->stream);
+	if (!fmt) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	*fmt = format->format;
+
+	fmt = v4l2_subdev_state_get_opposite_stream_format(state, format->pad,
+							   format->stream);
+	if (!fmt) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	*fmt = format->format;
+
+out:
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
+}
+
+static int unicam_subdev_enum_frame_size(struct v4l2_subdev *sd,
+					 struct v4l2_subdev_state *state,
+					 struct v4l2_subdev_frame_size_enum *fse)
+{
+	const struct unicam_fmt *fmtinfo;
+	int ret = 0;
+
+	if (fse->index > 0)
+		return -EINVAL;
+
+	v4l2_subdev_lock_state(state);
+
+	/* No transcoding, source and sink formats must match. */
+	if (unicam_sd_pad_is_source(fse->pad)) {
+		struct v4l2_mbus_framefmt *fmt;
+
+		fmt = v4l2_subdev_state_get_opposite_stream_format(state,
+								   fse->pad,
+								   fse->stream);
+
+		if (!fmt) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (fse->code != fmt->code) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		fse->min_width = fmt->width;
+		fse->max_width = fmt->width;
+		fse->min_height = fmt->height;
+		fse->max_height = fmt->height;
+	} else {
+		fmtinfo = find_format_by_code(fse->code);
+		if (!fmtinfo) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		fse->min_width = MIN_WIDTH * 8 / ALIGN(fmtinfo->depth, 8);
+		fse->max_width = MAX_WIDTH * 8 / ALIGN(fmtinfo->depth, 8);
+		fse->min_height = MIN_HEIGHT;
+		fse->max_height = MAX_HEIGHT;
+	}
+
+out:
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
+}
+
+static const struct v4l2_subdev_video_ops unicam_subdev_video_ops = {
+	.s_stream	= unicam_subdev_s_stream,
+};
+
+static const struct v4l2_subdev_pad_ops unicam_subdev_pad_ops = {
+	.init_cfg		= unicam_subdev_init_cfg,
+	.enum_mbus_code		= unicam_subdev_enum_mbus_code,
+	.get_fmt		= v4l2_subdev_get_fmt,
+	.set_fmt		= unicam_subdev_set_pad_format,
+	.set_routing		= unicam_subdev_set_routing,
+	.enum_frame_size	= unicam_subdev_enum_frame_size,
+};
+
+static const struct v4l2_subdev_ops unicam_subdev_ops = {
+	.video		= &unicam_subdev_video_ops,
+	.pad		= &unicam_subdev_pad_ops,
+};
+
+static struct media_entity_operations unicam_subdev_media_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+	.has_route = v4l2_subdev_has_route,
+};
+
+static int unicam_probe(struct platform_device *pdev)
+{
+	struct unicam_device *unicam;
+	int ret = 0;
+	int i;
+
+	unicam = kzalloc(sizeof(*unicam), GFP_KERNEL);
+	if (!unicam)
+		return -ENOMEM;
+
+	kref_init(&unicam->kref);
+	unicam->pdev = pdev;
+
+	unicam->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(unicam->base)) {
+		dev_err(unicam->v4l2_dev.dev, "Failed to get main io block\n");
+		ret = PTR_ERR(unicam->base);
+		goto err_unicam_put;
+	}
+
+	unicam->clk_gate_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(unicam->clk_gate_base)) {
+		dev_err(unicam->v4l2_dev.dev, "Failed to get 2nd io block\n");
+		ret = PTR_ERR(unicam->clk_gate_base);
+		goto err_unicam_put;
+	}
+
+	unicam->clock = devm_clk_get(&pdev->dev, "lp");
+	if (IS_ERR(unicam->clock)) {
+		dev_err(unicam->v4l2_dev.dev, "Failed to get lp clock\n");
+		ret = PTR_ERR(unicam->clock);
+		goto err_unicam_put;
+	}
+
+	unicam->vpu_clock = devm_clk_get(&pdev->dev, "vpu");
+	if (IS_ERR(unicam->vpu_clock)) {
+		dev_err(unicam->v4l2_dev.dev, "Failed to get vpu clock\n");
+		ret = PTR_ERR(unicam->vpu_clock);
+		goto err_unicam_put;
+	}
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret <= 0) {
+		dev_err(&pdev->dev, "No IRQ resource\n");
+		ret = -EINVAL;
+		goto err_unicam_put;
+	}
+
+	ret = devm_request_irq(&pdev->dev, ret, unicam_isr, 0,
+			       "unicam_capture0", unicam);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to request interrupt\n");
+		ret = -EINVAL;
+		goto err_unicam_put;
+	}
+
+	ret = bcm2835_media_dev_init(unicam, pdev);
+	if (ret) {
+		dev_err(unicam->v4l2_dev.dev,
+			"Unable to register v4l2 device.\n");
+		goto err_unicam_put;
+	}
+
+	ret = media_device_register(&unicam->mdev);
+	if (ret < 0) {
+		dev_err(unicam->v4l2_dev.dev,
+			"Unable to register media-controller device.\n");
+		goto err_v4l2_unregister;
+	}
+
+	/* Reserve space for the controls */
+	ret = v4l2_ctrl_handler_init(&unicam->ctrl_handler, 16);
+	if (ret < 0)
+		goto err_media_unregister;
+
+	/* set the driver data in platform device */
+	platform_set_drvdata(pdev, unicam);
+
+	dev_dbg(unicam->v4l2_dev.dev, "Initialize internal subdev");
+	v4l2_subdev_init(&unicam->sd, &unicam_subdev_ops);
+	v4l2_set_subdevdata(&unicam->sd, unicam);
+	unicam->sd.entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
+	unicam->sd.dev = &pdev->dev;
+	unicam->sd.owner = THIS_MODULE;
+	unicam->sd.flags = V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_MULTIPLEXED;
+	snprintf(unicam->sd.name, sizeof(unicam->sd.name), "unicam-subdev");
+
+	unicam->pads[UNICAM_SD_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+
+	for (i = UNICAM_SD_PAD_FIRST_SOURCE; i < UNICAM_SD_NUM_PADS; ++i)
+		unicam->pads[i].flags = MEDIA_PAD_FL_SOURCE;
+	unicam->sd.entity.ops = &unicam_subdev_media_ops;
+	ret = media_entity_pads_init(&unicam->sd.entity,
+				     ARRAY_SIZE(unicam->pads), unicam->pads);
+	if (ret) {
+		dev_err(unicam->v4l2_dev.dev, "Could not init media controller for subdev");
+		goto err_subdev_unregister;
+	}
+
+	ret = v4l2_subdev_init_finalize(&unicam->sd);
+	if (ret) {
+		dev_err(unicam->v4l2_dev.dev, "Could not finalize init for subdev");
+		goto err_entity_cleanup;
+	}
+
+	ret = v4l2_device_register_subdev(&unicam->v4l2_dev, &unicam->sd);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register internal subdev\n");
+		goto err_subdev_unregister;
+	}
+
+	ret = of_unicam_connect_subdevs(unicam);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to connect subdevs\n");
+		goto err_subdev_unregister;
+	}
+
+	/* Enable the block power domain */
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+
+err_subdev_unregister:
+	v4l2_subdev_cleanup(&unicam->sd);
+err_entity_cleanup:
+	media_entity_cleanup(&unicam->sd.entity);
+err_media_unregister:
+	media_device_unregister(&unicam->mdev);
+err_v4l2_unregister:
+	v4l2_device_unregister(&unicam->v4l2_dev);
+err_unicam_put:
+	unicam_put(unicam);
+
+	return ret;
+}
+
+static int unicam_remove(struct platform_device *pdev)
+{
+	struct unicam_device *unicam = platform_get_drvdata(pdev);
+
+	v4l2_async_nf_unregister(&unicam->notifier);
+	v4l2_device_unregister(&unicam->v4l2_dev);
+	media_device_unregister(&unicam->mdev);
+	unregister_nodes(unicam);
+
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id unicam_of_match[] = {
+	{ .compatible = "brcm,bcm2835-unicam", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, unicam_of_match);
+
+static struct platform_driver unicam_driver = {
+	.probe		= unicam_probe,
+	.remove		= unicam_remove,
+	.driver = {
+		.name	= UNICAM_MODULE_NAME,
+		.of_match_table = of_match_ptr(unicam_of_match),
+	},
+};
+
+module_platform_driver(unicam_driver);
+
+MODULE_AUTHOR("Dave Stevenson <dave.stevenson@raspberrypi.com>");
+MODULE_DESCRIPTION("BCM2835 Unicam driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(UNICAM_VERSION);
diff --git a/drivers/media/platform/bcm2835/vc4-regs-unicam.h b/drivers/media/platform/bcm2835/vc4-regs-unicam.h
new file mode 100644
index 000000000000..ae059a171d0f
--- /dev/null
+++ b/drivers/media/platform/bcm2835/vc4-regs-unicam.h
@@ -0,0 +1,253 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Copyright (C) 2017-2020 Raspberry Pi Trading.
+ * Dave Stevenson <dave.stevenson@raspberrypi.com>
+ */
+
+#ifndef VC4_REGS_UNICAM_H
+#define VC4_REGS_UNICAM_H
+
+/*
+ * The following values are taken from files found within the code drop
+ * made by Broadcom for the BCM21553 Graphics Driver, predominantly in
+ * brcm_usrlib/dag/vmcsx/vcinclude/hardware_vc4.h.
+ * They have been modified to be only the register offset.
+ */
+#define UNICAM_CTRL	0x000
+#define UNICAM_STA	0x004
+#define UNICAM_ANA	0x008
+#define UNICAM_PRI	0x00c
+#define UNICAM_CLK	0x010
+#define UNICAM_CLT	0x014
+#define UNICAM_DAT0	0x018
+#define UNICAM_DAT1	0x01c
+#define UNICAM_DAT2	0x020
+#define UNICAM_DAT3	0x024
+#define UNICAM_DLT	0x028
+#define UNICAM_CMP0	0x02c
+#define UNICAM_CMP1	0x030
+#define UNICAM_CAP0	0x034
+#define UNICAM_CAP1	0x038
+#define UNICAM_ICTL	0x100
+#define UNICAM_ISTA	0x104
+#define UNICAM_IDI0	0x108
+#define UNICAM_IPIPE	0x10c
+#define UNICAM_IBSA0	0x110
+#define UNICAM_IBEA0	0x114
+#define UNICAM_IBLS	0x118
+#define UNICAM_IBWP	0x11c
+#define UNICAM_IHWIN	0x120
+#define UNICAM_IHSTA	0x124
+#define UNICAM_IVWIN	0x128
+#define UNICAM_IVSTA	0x12c
+#define UNICAM_ICC	0x130
+#define UNICAM_ICS	0x134
+#define UNICAM_IDC	0x138
+#define UNICAM_IDPO	0x13c
+#define UNICAM_IDCA	0x140
+#define UNICAM_IDCD	0x144
+#define UNICAM_IDS	0x148
+#define UNICAM_DCS	0x200
+#define UNICAM_DBSA0	0x204
+#define UNICAM_DBEA0	0x208
+#define UNICAM_DBWP	0x20c
+#define UNICAM_DBCTL	0x300
+#define UNICAM_IBSA1	0x304
+#define UNICAM_IBEA1	0x308
+#define UNICAM_IDI1	0x30c
+#define UNICAM_DBSA1	0x310
+#define UNICAM_DBEA1	0x314
+#define UNICAM_MISC	0x400
+
+/*
+ * The following bitmasks are from the kernel released by Broadcom
+ * for Android - https://android.googlesource.com/kernel/bcm/
+ * The Rhea, Hawaii, and Java chips all contain the same VideoCore4
+ * Unicam block as BCM2835, as defined in eg
+ * arch/arm/mach-rhea/include/mach/rdb_A0/brcm_rdb_cam.h and similar.
+ * Values reworked to use the kernel BIT and GENMASK macros.
+ *
+ * Some of the bit mnenomics have been amended to match the datasheet.
+ */
+/* UNICAM_CTRL Register */
+#define UNICAM_CPE		BIT(0)
+#define UNICAM_MEM		BIT(1)
+#define UNICAM_CPR		BIT(2)
+#define UNICAM_CPM_MASK		GENMASK(3, 3)
+#define UNICAM_CPM_CSI2		0
+#define UNICAM_CPM_CCP2		1
+#define UNICAM_SOE		BIT(4)
+#define UNICAM_DCM_MASK		GENMASK(5, 5)
+#define UNICAM_DCM_STROBE	0
+#define UNICAM_DCM_DATA		1
+#define UNICAM_SLS		BIT(6)
+#define UNICAM_PFT_MASK		GENMASK(11, 8)
+#define UNICAM_OET_MASK		GENMASK(20, 12)
+
+/* UNICAM_STA Register */
+#define UNICAM_SYN		BIT(0)
+#define UNICAM_CS		BIT(1)
+#define UNICAM_SBE		BIT(2)
+#define UNICAM_PBE		BIT(3)
+#define UNICAM_HOE		BIT(4)
+#define UNICAM_PLE		BIT(5)
+#define UNICAM_SSC		BIT(6)
+#define UNICAM_CRCE		BIT(7)
+#define UNICAM_OES		BIT(8)
+#define UNICAM_IFO		BIT(9)
+#define UNICAM_OFO		BIT(10)
+#define UNICAM_BFO		BIT(11)
+#define UNICAM_DL		BIT(12)
+#define UNICAM_PS		BIT(13)
+#define UNICAM_IS		BIT(14)
+#define UNICAM_PI0		BIT(15)
+#define UNICAM_PI1		BIT(16)
+#define UNICAM_FSI_S		BIT(17)
+#define UNICAM_FEI_S		BIT(18)
+#define UNICAM_LCI_S		BIT(19)
+#define UNICAM_BUF0_RDY		BIT(20)
+#define UNICAM_BUF0_NO		BIT(21)
+#define UNICAM_BUF1_RDY		BIT(22)
+#define UNICAM_BUF1_NO		BIT(23)
+#define UNICAM_DI		BIT(24)
+
+#define UNICAM_STA_MASK_ALL \
+		(UNICAM_DL + \
+		UNICAM_SBE + \
+		UNICAM_PBE + \
+		UNICAM_HOE + \
+		UNICAM_PLE + \
+		UNICAM_SSC + \
+		UNICAM_CRCE + \
+		UNICAM_IFO + \
+		UNICAM_OFO + \
+		UNICAM_PS + \
+		UNICAM_PI0 + \
+		UNICAM_PI1)
+
+/* UNICAM_ANA Register */
+#define UNICAM_APD		BIT(0)
+#define UNICAM_BPD		BIT(1)
+#define UNICAM_AR		BIT(2)
+#define UNICAM_DDL		BIT(3)
+#define UNICAM_CTATADJ_MASK	GENMASK(7, 4)
+#define UNICAM_PTATADJ_MASK	GENMASK(11, 8)
+
+/* UNICAM_PRI Register */
+#define UNICAM_PE		BIT(0)
+#define UNICAM_PT_MASK		GENMASK(2, 1)
+#define UNICAM_NP_MASK		GENMASK(7, 4)
+#define UNICAM_PP_MASK		GENMASK(11, 8)
+#define UNICAM_BS_MASK		GENMASK(15, 12)
+#define UNICAM_BL_MASK		GENMASK(17, 16)
+
+/* UNICAM_CLK Register */
+#define UNICAM_CLE		BIT(0)
+#define UNICAM_CLPD		BIT(1)
+#define UNICAM_CLLPE		BIT(2)
+#define UNICAM_CLHSE		BIT(3)
+#define UNICAM_CLTRE		BIT(4)
+#define UNICAM_CLAC_MASK	GENMASK(8, 5)
+#define UNICAM_CLSTE		BIT(29)
+
+/* UNICAM_CLT Register */
+#define UNICAM_CLT1_MASK	GENMASK(7, 0)
+#define UNICAM_CLT2_MASK	GENMASK(15, 8)
+
+/* UNICAM_DATn Registers */
+#define UNICAM_DLE		BIT(0)
+#define UNICAM_DLPD		BIT(1)
+#define UNICAM_DLLPE		BIT(2)
+#define UNICAM_DLHSE		BIT(3)
+#define UNICAM_DLTRE		BIT(4)
+#define UNICAM_DLSM		BIT(5)
+#define UNICAM_DLFO		BIT(28)
+#define UNICAM_DLSTE		BIT(29)
+
+#define UNICAM_DAT_MASK_ALL (UNICAM_DLSTE + UNICAM_DLFO)
+
+/* UNICAM_DLT Register */
+#define UNICAM_DLT1_MASK	GENMASK(7, 0)
+#define UNICAM_DLT2_MASK	GENMASK(15, 8)
+#define UNICAM_DLT3_MASK	GENMASK(23, 16)
+
+/* UNICAM_ICTL Register */
+#define UNICAM_FSIE		BIT(0)
+#define UNICAM_FEIE		BIT(1)
+#define UNICAM_IBOB		BIT(2)
+#define UNICAM_FCM		BIT(3)
+#define UNICAM_TFC		BIT(4)
+#define UNICAM_LIP_MASK		GENMASK(6, 5)
+#define UNICAM_LCIE_MASK	GENMASK(28, 16)
+
+/* UNICAM_IDI0/1 Register */
+#define UNICAM_ID0_MASK		GENMASK(7, 0)
+#define UNICAM_ID1_MASK		GENMASK(15, 8)
+#define UNICAM_ID2_MASK		GENMASK(23, 16)
+#define UNICAM_ID3_MASK		GENMASK(31, 24)
+
+/* UNICAM_ISTA Register */
+#define UNICAM_FSI		BIT(0)
+#define UNICAM_FEI		BIT(1)
+#define UNICAM_LCI		BIT(2)
+
+#define UNICAM_ISTA_MASK_ALL (UNICAM_FSI + UNICAM_FEI + UNICAM_LCI)
+
+/* UNICAM_IPIPE Register */
+#define UNICAM_PUM_MASK		GENMASK(2, 0)
+		/* Unpacking modes */
+		#define UNICAM_PUM_NONE		0
+		#define UNICAM_PUM_UNPACK6	1
+		#define UNICAM_PUM_UNPACK7	2
+		#define UNICAM_PUM_UNPACK8	3
+		#define UNICAM_PUM_UNPACK10	4
+		#define UNICAM_PUM_UNPACK12	5
+		#define UNICAM_PUM_UNPACK14	6
+		#define UNICAM_PUM_UNPACK16	7
+#define UNICAM_DDM_MASK		GENMASK(6, 3)
+#define UNICAM_PPM_MASK		GENMASK(9, 7)
+		/* Packing modes */
+		#define UNICAM_PPM_NONE		0
+		#define UNICAM_PPM_PACK8	1
+		#define UNICAM_PPM_PACK10	2
+		#define UNICAM_PPM_PACK12	3
+		#define UNICAM_PPM_PACK14	4
+		#define UNICAM_PPM_PACK16	5
+#define UNICAM_DEM_MASK		GENMASK(11, 10)
+#define UNICAM_DEBL_MASK	GENMASK(14, 12)
+#define UNICAM_ICM_MASK		GENMASK(16, 15)
+#define UNICAM_IDM_MASK		GENMASK(17, 17)
+
+/* UNICAM_ICC Register */
+#define UNICAM_ICFL_MASK	GENMASK(4, 0)
+#define UNICAM_ICFH_MASK	GENMASK(9, 5)
+#define UNICAM_ICST_MASK	GENMASK(12, 10)
+#define UNICAM_ICLT_MASK	GENMASK(15, 13)
+#define UNICAM_ICLL_MASK	GENMASK(31, 16)
+
+/* UNICAM_DCS Register */
+#define UNICAM_DIE		BIT(0)
+#define UNICAM_DIM		BIT(1)
+#define UNICAM_DBOB		BIT(3)
+#define UNICAM_FDE		BIT(4)
+#define UNICAM_LDP		BIT(5)
+#define UNICAM_EDL_MASK		GENMASK(15, 8)
+
+/* UNICAM_DBCTL Register */
+#define UNICAM_DBEN		BIT(0)
+#define UNICAM_BUF0_IE		BIT(1)
+#define UNICAM_BUF1_IE		BIT(2)
+
+/* UNICAM_CMP[0,1] register */
+#define UNICAM_PCE		BIT(31)
+#define UNICAM_GI		BIT(9)
+#define UNICAM_CPH		BIT(8)
+#define UNICAM_PCVC_MASK	GENMASK(7, 6)
+#define UNICAM_PCDT_MASK	GENMASK(5, 0)
+
+/* UNICAM_MISC register */
+#define UNICAM_FL0		BIT(6)
+#define UNICAM_FL1		BIT(9)
+
+#endif
-- 
2.32.0

