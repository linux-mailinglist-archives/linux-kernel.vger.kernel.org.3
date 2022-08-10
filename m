Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF9B58EE32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiHJOXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJOXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:23:37 -0400
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1514.securemx.jp [210.130.202.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EF512AB6;
        Wed, 10 Aug 2022 07:23:34 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1514) id 27ADYd3Z001679; Wed, 10 Aug 2022 22:34:39 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 27ADXWxl004400; Wed, 10 Aug 2022 22:33:33 +0900
X-Iguazu-Qid: 34trEV9ARTTNcmBCRU
X-Iguazu-QSIG: v=2; s=0; t=1660138412; q=34trEV9ARTTNcmBCRU; m=BPWWj3hH4qiRBLC9wB96khgbXQB9rriJLb7XqysbH6Q=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1512) id 27ADXVXF000556
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Aug 2022 22:33:31 +0900
X-SA-MID: 43725405
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v3 2/4] media: platform: visconti: Add Toshiba Visconti Video Input Interface driver
Date:   Wed, 10 Aug 2022 22:28:20 +0900
X-TSB-HOP2: ON
Message-Id: <20220810132822.32534-3-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp>
References: <20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
The interface device includes CSI2 Receiver,
frame grabber and image signal processor.

A driver instance provides three /dev/videoX device files;
one for RGB image capture, another one for optional RGB capture
with different parameters and the last one for RAW capture.

The implementation has two kind of C sources:
* viif_*
  The user interface. It registers a media controller framework instance,
  three V4L2 driver instances and corresponding subdriver instances.
  The driver provides streaming (DMA-BUF) interface
  and vendor specific controls to configure the image signal processor.
  Memory blocks are specified with videobuf2 buffer backed by DMA-BUF.

* hwd_viif_*
  The hardware layer.
  It configures hardware registers following a request from viif_*.c
  This layer communicate with the hardware via registers.
  Memory blocks are specified with 32bit-truncated phisical address.

For media controller framework the driver provides two items;

* ISP subdevice: which controls CSI2 receiver and image signal processor.
* Capture device: which controls video DMAC, videobuf2 buffers.

Currently subdevices support only one default network.

Future plan:
* Power management operations will be added,
  once the visconti clock framework driver supports
  the Video Input Interface hardware.
* When the visconti IOMMU driver (currently under review) is accepted,
  the hardware layer will use 32bit IO virtual address mapped
  by the dedicated IOMMU.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
---
Changelog v2:
- Resend v1 because a patch exceeds size limit.

Changelog v3:
- Adapted to media control framework
- Introduced ISP subdevice, capture device
- Remove private IOCTLs and add vendor specific V4L2 controls
- Change function name avoiding camelcase and uppercase letters
---
 drivers/media/platform/Kconfig                |    2 +
 drivers/media/platform/Makefile               |    4 +
 drivers/media/platform/visconti/Kconfig       |    9 +
 drivers/media/platform/visconti/Makefile      |    9 +
 drivers/media/platform/visconti/hwd_viif.c    | 1791 +++++++++++
 drivers/media/platform/visconti/hwd_viif.h    |  701 +++++
 .../media/platform/visconti/hwd_viif_csi2rx.c |  723 +++++
 .../platform/visconti/hwd_viif_internal.h     |  348 ++
 .../media/platform/visconti/hwd_viif_l1isp.c  | 2727 ++++++++++++++++
 .../media/platform/visconti/hwd_viif_reg.h    | 2802 +++++++++++++++++
 drivers/media/platform/visconti/viif.c        |  479 +++
 drivers/media/platform/visconti/viif.h        |  195 ++
 .../media/platform/visconti/viif_capture.c    | 1215 +++++++
 .../media/platform/visconti/viif_controls.c   | 1149 +++++++
 drivers/media/platform/visconti/viif_isp.c    |  852 +++++
 include/uapi/linux/visconti_viif.h            | 1724 ++++++++++
 16 files changed, 14730 insertions(+)
 create mode 100644 drivers/media/platform/visconti/Kconfig
 create mode 100644 drivers/media/platform/visconti/Makefile
 create mode 100644 drivers/media/platform/visconti/hwd_viif.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif.h
 create mode 100644 drivers/media/platform/visconti/hwd_viif_csi2rx.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif_internal.h
 create mode 100644 drivers/media/platform/visconti/hwd_viif_l1isp.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif_reg.h
 create mode 100644 drivers/media/platform/visconti/viif.c
 create mode 100644 drivers/media/platform/visconti/viif.h
 create mode 100644 drivers/media/platform/visconti/viif_capture.c
 create mode 100644 drivers/media/platform/visconti/viif_controls.c
 create mode 100644 drivers/media/platform/visconti/viif_isp.c
 create mode 100644 include/uapi/linux/visconti_viif.h

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index cf4adc64c..0eb1dfc05 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -31,6 +31,8 @@ source "drivers/media/platform/davinci/Kconfig"
 
 source "drivers/media/platform/omap/Kconfig"
 
+source "drivers/media/platform/visconti/Kconfig"
+
 config VIDEO_ASPEED
 	tristate "Aspeed AST2400 and AST2500 Video Engine driver"
 	depends on VIDEO_V4L2
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index a148553ba..4af489811 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -84,6 +84,10 @@ obj-$(CONFIG_VIDEO_QCOM_CAMSS)		+= qcom/camss/
 
 obj-$(CONFIG_VIDEO_QCOM_VENUS)		+= qcom/venus/
 
+obj-$(CONFIG_ARCH_VISCONTI)	+= visconti/
+
 obj-y					+= sunxi/
 
 obj-$(CONFIG_VIDEO_MESON_GE2D)		+= meson/ge2d/
+
+
diff --git a/drivers/media/platform/visconti/Kconfig b/drivers/media/platform/visconti/Kconfig
new file mode 100644
index 000000000..1e4ca386d
--- /dev/null
+++ b/drivers/media/platform/visconti/Kconfig
@@ -0,0 +1,9 @@
+config VIDEO_VISCONTI_VIIF
+	tristate "Visconti Camera Interface driver"
+	depends on VIDEO_V4L2 && MEDIA_CONTROLLER
+	depends on ARCH_VISCONTI
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_FWNODE
+	help
+	  This is V4L2 driver for Toshiba Visconti Camera Interface driver
+
diff --git a/drivers/media/platform/visconti/Makefile b/drivers/media/platform/visconti/Makefile
new file mode 100644
index 000000000..13cf70ce3
--- /dev/null
+++ b/drivers/media/platform/visconti/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Visconti video input device driver
+#
+
+visconti-viif-objs = viif.o viif_capture.o viif_controls.o viif_isp.o
+visconti-viif-objs += hwd_viif_csi2rx.o hwd_viif.o hwd_viif_l1isp.o
+
+obj-$(CONFIG_VIDEO_VISCONTI_VIIF) += visconti-viif.o
diff --git a/drivers/media/platform/visconti/hwd_viif.c b/drivers/media/platform/visconti/hwd_viif.c
new file mode 100644
index 000000000..ac02bc982
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif.c
@@ -0,0 +1,1791 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+
+#include "hwd_viif.h"
+#include "hwd_viif_internal.h"
+
+/* MIPI CSI2 DataType definition */
+#define CSI2_DT_YUV4228B  VISCONTI_CSI2_DT_YUV4228B
+#define CSI2_DT_YUV42210B VISCONTI_CSI2_DT_YUV42210B
+#define CSI2_DT_RGB565	  VISCONTI_CSI2_DT_RGB565
+#define CSI2_DT_RGB888	  VISCONTI_CSI2_DT_RGB888
+#define CSI2_DT_RAW8	  VISCONTI_CSI2_DT_RAW8
+#define CSI2_DT_RAW10	  VISCONTI_CSI2_DT_RAW10
+#define CSI2_DT_RAW12	  VISCONTI_CSI2_DT_RAW12
+#define CSI2_DT_RAW14	  VISCONTI_CSI2_DT_RAW14
+
+static struct hwd_viif_res hwd_VIIF0_res = {
+	.ch = 0,
+	.csi2rx_type = HWD_VIIF_CSI2_TYPE_4_LANES,
+	.sram_size_w_port = 0x200,
+	.sram_size_r_port = 0x200,
+	.sram_start_addr_gamma = 0x640,
+	.run_flag_main = (bool)false,
+};
+
+static struct hwd_viif_res hwd_VIIF1_res = {
+	.ch = 1,
+	.csi2rx_type = HWD_VIIF_CSI2_TYPE_4_LANES,
+	.sram_size_w_port = 0x200,
+	.sram_size_r_port = 0x200,
+	.sram_start_addr_gamma = 0x640,
+	.run_flag_main = (bool)false,
+};
+
+/**
+ * viif_id2res() - resource data for specified module ID
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: Pointer to resource access structure
+ */
+struct hwd_viif_res *viif_id2res(u32 module_id)
+{
+	return (module_id == 0) ? &hwd_VIIF0_res : &hwd_VIIF1_res;
+}
+
+/**
+ * hwd_viif_initialize() - Initialize VIIF HWD layer.
+ *
+ * @csi2host_vaddr: VIIF CSI-2 RX register base address(virtual address)
+ * @capture_vaddr: VIIF capture(system, vdmac, l1isp, l2isp) register base address(virtual address)
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ */
+s32 hwd_viif_initialize(u32 module_id, void *csi2host_vaddr, void *capture_vaddr)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	/* Store virtual address of the register base */
+	res->csi2host_reg = csi2host_vaddr;
+	res->capture_reg = capture_vaddr;
+
+	return 0;
+}
+
+/**
+ * hwd_viif_uninitialize() - De-initialize VIIF HWD layer.
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ */
+s32 hwd_viif_uninitialize(u32 module_id)
+{
+	return 0;
+}
+
+/* Convert the unit of time-period (from sysclk, to num lines in the image) */
+static u32 sysclk_to_numlines(u64 time_in_sysclk, const struct hwd_viif_input_img *img)
+{
+	u64 v1 = time_in_sysclk * (u64)img->pixel_clock;
+	u64 v2 = (u64)img->htotal_size * HWD_VIIF_SYS_CLK;
+
+	return (u32)(v1 / v2);
+}
+
+static u32 lineperiod_in_sysclk(u64 hsize, u64 pixel_clock)
+{
+	return (u32)(hsize * HWD_VIIF_SYS_CLK / pixel_clock);
+}
+
+/**
+ * hwd_viif_main_set_unit() - Set static configuration of MAIN unit(CH0 or CH1)
+ *
+ * @dt_image: DT of image [0x10-0x17, 0x1B, 0x1E, 0x1F, 0x22, 0x24-0x27, 0x2A-0x3F])
+ * @in_img: Pointer to input image information
+ * @color_type: Color type of image [0x0, 0x1E, 0x1F, 0x22, 0x24, 0x2A-0x2D]
+ * @rawpack: RAW pack mode. For more refer @ref hwd_viif_raw_pack_mode
+ * @yuv_conv: YUV422 to YUV444 conversion mode. For more refer @ref hwd_viif_yuv_conversion_mode
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "dt_image" is out of range
+ * - [2] "in_img" is NULL
+ * - [3] member of "in_img" is invalid
+ * - [4] "color_type" is out of range
+ * - [5] "color_type" doesn't meet the condition shown in the below note
+ * - [6] "rawpack" is out of range
+ * - [7] "rawpack" is not HWD_VIIF_RAWPACK_DISABLE when color_type is other than RAW(0x2A-0x2C)
+ * - [8] "yuv_conv" is out of range
+ * - [9] "yuv_conv" is not HWD_VIIF_YUV_CONV_REPEAT
+ *       when color_type is other than YUV422(0x1E or 0x1F)
+ *
+ * Note: valid combination between "dt_image" and "color_type" is
+ * - when "dt_image" is [0x10-0x17, 0x1B, 0x25-0x27, 0x2E-0x3F], "color_type" must be [0x2A-0x2D].
+ * - when "dt_image" is valid value and other than [0x10-0x17, 0x1B, 0x25-0x27, 0x2E-0x3F],
+ *   "color_type" must be "dt_image"
+ */
+s32 hwd_viif_main_set_unit(u32 module_id, u32 dt_image, const struct hwd_viif_input_img *in_img,
+			   u32 color_type, u32 rawpack, u32 yuv_conv)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 total_hact_size = 0U, total_vact_size = 0U;
+	u32 sw_delay0, sw_delay1, hw_delay;
+	u32 val, color, sysclk_num;
+	u32 i;
+
+	/*
+	 * 0x00-0x09: ShortPacket/Undefined
+	 * 0x18-0x1A: YUV420
+	 * 0x1C,0x1D: YUV420 CSPS
+	 * 0x20,0x21,0x23: RGB444, RGB555, RGB666
+	 * 0x28,0x29: RAW6, RAW7
+	 */
+	if (dt_image <= 0x09U || (dt_image >= 0x18U && dt_image <= 0x1AU) || dt_image == 0x1CU ||
+	    dt_image == 0x1DU || dt_image == 0x20U || dt_image == 0x21U || dt_image == 0x23U ||
+	    dt_image == 0x28U || dt_image == 0x29U || dt_image > HWD_VIIF_CSI2_MAX_DT) {
+		return -EINVAL;
+	}
+
+	/*Case: Generic Long Packet, Reserved, User-Defined*/
+	if ((dt_image >= 0x10U && dt_image <= 0x17U) || dt_image == 0x1bU ||
+	    (dt_image >= 0x25U && dt_image <= 0x27U) || dt_image >= 0x2eU) {
+		if (color_type != CSI2_DT_RAW8 && color_type != CSI2_DT_RAW10 &&
+		    color_type != CSI2_DT_RAW12 && color_type != CSI2_DT_RAW14) {
+			return -EINVAL;
+		}
+	} else {
+		/*Case: Otherwise: YUV, RGB, RAW*/
+		/*Constraint: color_type must be dt_image*/
+		if (color_type != dt_image)
+			return -EINVAL;
+	}
+
+	if (!in_img)
+		return -EINVAL;
+	if (rawpack != HWD_VIIF_RAWPACK_DISABLE && rawpack != HWD_VIIF_RAWPACK_MSBFIRST &&
+	    rawpack != HWD_VIIF_RAWPACK_LSBFIRST) {
+		return -EINVAL;
+	}
+	if (color_type != CSI2_DT_RAW8 && color_type != CSI2_DT_RAW10 &&
+	    color_type != CSI2_DT_RAW12 && rawpack != HWD_VIIF_RAWPACK_DISABLE) {
+		return -EINVAL;
+	}
+
+	if (in_img->pixel_clock < HWD_VIIF_MIN_PIXEL_CLOCK ||
+	    in_img->pixel_clock > HWD_VIIF_MAX_PIXEL_CLOCK ||
+	    in_img->htotal_size < HWD_VIIF_MIN_HTOTAL_PIXEL ||
+	    in_img->htotal_size > HWD_VIIF_MAX_HTOTAL_PIXEL ||
+	    in_img->vtotal_size < HWD_VIIF_MIN_VTOTAL_LINE ||
+	    in_img->vtotal_size > HWD_VIIF_MAX_VTOTAL_LINE ||
+	    in_img->vbp_size < HWD_VIIF_MIN_VBP_LINE || in_img->vbp_size > HWD_VIIF_MAX_VBP_LINE ||
+	    ((in_img->hactive_size % 2U) != 0U) || ((in_img->vactive_size % 2U) != 0U)) {
+		return -EINVAL;
+	}
+
+	if (in_img->interpolation_mode != HWD_VIIF_L1_INPUT_INTERPOLATION_LINE &&
+	    in_img->interpolation_mode != HWD_VIIF_L1_INPUT_INTERPOLATION_PIXEL) {
+		return -EINVAL;
+	}
+
+	if (in_img->input_num < HWD_VIIF_L1_INPUT_NUM_MIN ||
+	    in_img->input_num > HWD_VIIF_L1_INPUT_NUM_MAX) {
+		return -EINVAL;
+	}
+
+	if (in_img->hobc_width != 0U && in_img->hobc_width != 16U && in_img->hobc_width != 32U &&
+	    in_img->hobc_width != 64U && in_img->hobc_width != 128U) {
+		return -EINVAL;
+	}
+
+	if (in_img->hobc_margin > 30U || ((in_img->hobc_margin % 2U) != 0U))
+		return -EINVAL;
+
+	if (in_img->hobc_width == 0U && in_img->hobc_margin != 0U)
+		return -EINVAL;
+
+	if (in_img->hobc_width != 0U && in_img->hobc_margin == 0U)
+		return -EINVAL;
+
+	if (color_type == CSI2_DT_RAW8 || color_type == CSI2_DT_RAW10 ||
+	    color_type == CSI2_DT_RAW12 || color_type == CSI2_DT_RAW14) {
+		/* parameter check in case of L1ISP(in case of RAW) */
+		if (in_img->hactive_size < HWD_VIIF_MIN_HACTIVE_PIXEL_W_L1ISP ||
+		    in_img->hactive_size > HWD_VIIF_MAX_HACTIVE_PIXEL_W_L1ISP ||
+		    in_img->vactive_size < HWD_VIIF_MIN_VACTIVE_LINE_W_L1ISP ||
+		    in_img->vactive_size > HWD_VIIF_MAX_VACTIVE_LINE_W_L1ISP ||
+		    ((in_img->hactive_size % 8U) != 0U)) {
+			return -EINVAL;
+		}
+
+		/* check vbp range in case of L1ISP on */
+		/* the constant value "7" is configuration margin */
+		val = sysclk_to_numlines(
+			      HWD_VIIF_TABLE_LOAD_TIME + HWD_VIIF_REGBUF_ACCESS_TIME * 2U, in_img) +
+		      HWD_VIIF_L1_DELAY_W_HDRC + 7U;
+		if (in_img->vbp_size < val)
+			return -EINVAL;
+
+		/* calculate total of horizontal active size and vertical active size */
+		if (rawpack != HWD_VIIF_RAWPACK_DISABLE) {
+			val = (in_img->hactive_size + in_img->hobc_width + in_img->hobc_margin) *
+			      2U;
+		} else {
+			val = in_img->hactive_size + in_img->hobc_width + in_img->hobc_margin;
+		}
+		if (in_img->interpolation_mode == HWD_VIIF_L1_INPUT_INTERPOLATION_LINE) {
+			total_hact_size = val;
+			total_vact_size = in_img->vactive_size * in_img->input_num;
+		} else {
+			total_hact_size = val * in_img->input_num;
+			total_vact_size = in_img->vactive_size;
+		}
+	} else {
+		/* OTHER input than RAW(L1ISP is off) */
+		if (in_img->hactive_size < HWD_VIIF_MIN_HACTIVE_PIXEL_WO_L1ISP ||
+		    in_img->hactive_size > HWD_VIIF_MAX_HACTIVE_PIXEL_WO_L1ISP ||
+		    in_img->vactive_size < HWD_VIIF_MIN_VACTIVE_LINE_WO_L1ISP ||
+		    in_img->vactive_size > HWD_VIIF_MAX_VACTIVE_LINE_WO_L1ISP ||
+		    in_img->interpolation_mode != HWD_VIIF_L1_INPUT_INTERPOLATION_LINE ||
+		    in_img->input_num != HWD_VIIF_L1_INPUT_NUM_MIN || in_img->hobc_width != 0U) {
+			return -EINVAL;
+		}
+
+		/* check vbp range in case of L1ISP off */
+		/* the constant value "16" is configuration margin */
+		val = sysclk_to_numlines(HWD_VIIF_TABLE_LOAD_TIME + HWD_VIIF_REGBUF_ACCESS_TIME,
+					 in_img) +
+		      16U;
+		if (in_img->vbp_size < val)
+			return -EINVAL;
+
+		total_hact_size = in_img->hactive_size;
+		total_vact_size = in_img->vactive_size;
+	}
+
+	if (in_img->htotal_size <= total_hact_size ||
+	    (in_img->vtotal_size <= (in_img->vbp_size + total_vact_size))) {
+		return -EINVAL;
+	}
+
+	if (yuv_conv != HWD_VIIF_YUV_CONV_REPEAT && yuv_conv != HWD_VIIF_YUV_CONV_INTERPOLATION)
+		return -EINVAL;
+
+	if (color_type != CSI2_DT_YUV4228B && color_type != CSI2_DT_YUV42210B &&
+	    yuv_conv != HWD_VIIF_YUV_CONV_REPEAT) {
+		return -EINVAL;
+	}
+
+	/* Set DT and color type of image data */
+	writel((color_type << 8U) | dt_image, &res->capture_reg->sys.IPORTM_MAIN_DT);
+	writel(0x00, &res->capture_reg->sys.IPORTM_OTHER);
+	res->dt_image_main_w_isp = dt_image;
+
+	/* Set back porch*/
+	writel((in_img->vbp_size << 16U) | HWD_VIIF_HBP_SYSCLK,
+	       &res->capture_reg->sys.BACK_PORCH_M);
+
+	/* single pulse of vsync is input to DPGM */
+	writel(HWD_VIIF_DPGM_VSYNC_PULSE, &res->capture_reg->sys.DPGM_VSYNC_SOURCE);
+
+	/* image data will be input */
+	/* set preprocess type before L2ISP based on color_type. */
+	if (color_type == CSI2_DT_YUV4228B || color_type == CSI2_DT_YUV42210B) {
+		/* YUV422 */
+		color = 3U;
+	} else if (color_type == CSI2_DT_RGB565 || color_type == CSI2_DT_RGB888) {
+		/* RGB */
+		color = 0U;
+	} else {
+		/* RGB or YUV444 from L1ISP */
+		color = 1U;
+	}
+	writel(color << 4U, &res->capture_reg->sys.PREPROCCESS_FMTM);
+
+	/* set Total size and valid size information of image data */
+	sysclk_num = lineperiod_in_sysclk(in_img->htotal_size, in_img->pixel_clock);
+	sysclk_num &= GENMASK(15, 0);
+	writel((in_img->vtotal_size << 16U) | sysclk_num, &res->capture_reg->sys.TOTALSIZE_M);
+	writel((total_vact_size << 16U) | total_hact_size, &res->capture_reg->sys.VALSIZE_M);
+
+	/* set image size information to L2ISP */
+	writel(in_img->vactive_size, &res->capture_reg->l2isp.L2_SENSOR_CROP_VSIZE);
+	writel(in_img->hactive_size, &res->capture_reg->l2isp.L2_SENSOR_CROP_HSIZE);
+
+	/* RAW input case */
+	if (color_type >= CSI2_DT_RAW8) {
+		val = (in_img->interpolation_mode << 3U) | (in_img->input_num);
+		writel(val, &res->capture_reg->l1isp.L1_IBUF_INPUT_ORDER);
+		writel(in_img->vactive_size, &res->capture_reg->l1isp.L1_SYSM_HEIGHT);
+		writel(in_img->hactive_size, &res->capture_reg->l1isp.L1_SYSM_WIDTH);
+		val = (in_img->hobc_margin << 8U) | in_img->hobc_width;
+		writel(val, &res->capture_reg->l1isp.L1_HOBC_MARGIN);
+	}
+
+	/* Set rawpack */
+	writel(rawpack, &res->capture_reg->sys.IPORTM_MAIN_RAW);
+
+	/* Set yuv_conv */
+	writel(yuv_conv, &res->capture_reg->sys.PREPROCCESS_C24M);
+
+	/* Set vsync delay */
+	hw_delay = in_img->vbp_size - sysclk_to_numlines(HWD_VIIF_TABLE_LOAD_TIME, in_img) + 4U;
+	hw_delay = min(hw_delay, 255U);
+
+	sw_delay0 = hw_delay - sysclk_to_numlines(HWD_VIIF_REGBUF_ACCESS_TIME, in_img) + 2U;
+
+	if (color_type == CSI2_DT_RAW8 || color_type == CSI2_DT_RAW10 ||
+	    color_type == CSI2_DT_RAW12 || color_type == CSI2_DT_RAW14) {
+		sw_delay1 = sysclk_to_numlines(HWD_VIIF_REGBUF_ACCESS_TIME, in_img) +
+			    HWD_VIIF_L1_DELAY_WO_HDRC + 1U;
+	} else {
+		sw_delay1 = 10U;
+	}
+	writel(sw_delay0 << 16U, &res->capture_reg->sys.INT_M0_LINE);
+	writel((sw_delay1 << 16U) | hw_delay, &res->capture_reg->sys.INT_M1_LINE);
+
+	/* M2_LINE is the same condition as M1_LINE */
+	writel((sw_delay1 << 16U) | hw_delay, &res->capture_reg->sys.INT_M2_LINE);
+
+	/* Update internal information of pixel clock, htotal_size, information of L2 ROI */
+	res->pixel_clock = in_img->pixel_clock;
+	res->htotal_size = in_img->htotal_size;
+	res->l2_roi_path_info.roi_num = 0;
+	for (i = 0; i < HWD_VIIF_MAX_POST_NUM; i++) {
+		res->l2_roi_path_info.post_enable_flag[i] = false;
+		res->l2_roi_path_info.post_crop_x[i] = 0;
+		res->l2_roi_path_info.post_crop_y[i] = 0;
+		res->l2_roi_path_info.post_crop_w[i] = 0;
+		res->l2_roi_path_info.post_crop_h[i] = 0;
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_main_mask_vlatch() - Control Vlatch mask of MAIN unit
+ *
+ * @enable: or disable Vlatch mask of MAIN unit. For more refer @ref hwd_viif_enable_flag.
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - "enable" is out of range
+ */
+s32 hwd_viif_main_mask_vlatch(u32 module_id, u32 enable)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (enable != HWD_VIIF_ENABLE && enable != HWD_VIIF_DISABLE)
+		return -EINVAL;
+
+	if (res->ch != 0U && res->ch != 1U)
+		return -EINVAL;
+
+	if (enable == HWD_VIIF_ENABLE)
+		enable |= HWD_VIIF_ISP_VLATCH_MASK;
+
+	/* Control Vlatch mask */
+	writel(enable, &res->capture_reg->sys.IPORTM0_LD);
+	writel(enable, &res->capture_reg->sys.IPORTM1_LD);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_main_status_err_set_irq_mask() - Set mask condition for STATUS error of MAIN unit
+ *
+ * @mask: STATUS error mask condition
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_viif_main_status_err_set_irq_mask(u32 module_id, u32 mask)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	writel(mask, &res->capture_reg->sys.INT_M_MASK);
+}
+
+/**
+ * hwd_viif_main_vsync_set_irq_mask() - Set mask condition for Vsync of MAIN unit
+ *
+ * @mask: Vsync mask condition
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_viif_main_vsync_set_irq_mask(u32 module_id, u32 mask)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	writel(mask, &res->capture_reg->sys.INT_M_SYNC_MASK);
+}
+
+#define VDM_BIT_W00 BIT(0)
+#define VDM_BIT_W01 BIT(1)
+#define VDM_BIT_W02 BIT(2)
+#define VDM_BIT_W03 BIT(3)
+#define VDM_BIT_W04 BIT(4)
+#define VDM_BIT_W05 BIT(5)
+#define VDM_BIT_R00 BIT(0)
+#define VDM_BIT_R01 BIT(1)
+#define VDM_BIT_R02 BIT(2)
+
+#define VDM_ABORT_MASK_SUB_W  (VDM_BIT_W03 | VDM_BIT_W04 | VDM_BIT_W05)
+#define VDM_ABORT_MASK_MAIN_W (VDM_BIT_W00 | VDM_BIT_W01 | VDM_BIT_W02)
+#define VDM_ABORT_MASK_MAIN_R (VDM_BIT_R00 | VDM_BIT_R01 | VDM_BIT_R02)
+
+/**
+ * hwd_viif_sub_set_unit() - Set static configuration of SUB unit
+ *
+ * @dt_image: DT of image [0x1E, 0x1F, 0x22, 0x24, 0x2A-0x2D]
+ * @in_img: Pointer to input image information
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "dt_image" is out of range
+ * - [2] "in_img" is NULL
+ * - [3] member of "in_img" is invalid
+ */
+s32 hwd_viif_sub_set_unit(u32 module_id, u32 dt_image, const struct hwd_viif_input_img *in_img)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 sysclk_num, temp_delay;
+
+	if (dt_image < 0x2aU || dt_image > 0x2dU)
+		return -EINVAL;
+
+	if (!in_img)
+		return -EINVAL;
+
+	if (in_img->hactive_size != 0U ||
+	    in_img->interpolation_mode != HWD_VIIF_L1_INPUT_INTERPOLATION_LINE ||
+	    in_img->input_num != HWD_VIIF_L1_INPUT_NUM_MIN || in_img->hobc_width != 0U ||
+	    in_img->hobc_margin != 0U) {
+		return -EINVAL;
+	}
+
+	if (in_img->pixel_clock < HWD_VIIF_MIN_PIXEL_CLOCK ||
+	    in_img->pixel_clock > HWD_VIIF_MAX_PIXEL_CLOCK ||
+	    in_img->htotal_size < HWD_VIIF_MIN_HTOTAL_PIXEL ||
+	    in_img->htotal_size > HWD_VIIF_MAX_HTOTAL_PIXEL ||
+	    in_img->vtotal_size < HWD_VIIF_MIN_VTOTAL_LINE ||
+	    in_img->vtotal_size > HWD_VIIF_MAX_VTOTAL_LINE ||
+	    in_img->vbp_size < HWD_VIIF_MIN_VBP_LINE || in_img->vbp_size > HWD_VIIF_MAX_VBP_LINE ||
+	    in_img->vactive_size < HWD_VIIF_MIN_VACTIVE_LINE_WO_L1ISP ||
+	    in_img->vactive_size > HWD_VIIF_MAX_VACTIVE_LINE_WO_L1ISP ||
+	    ((in_img->vactive_size % 2U) != 0U)) {
+		return -EINVAL;
+	}
+
+	if (in_img->vtotal_size <= (in_img->vbp_size + in_img->vactive_size))
+		return -EINVAL;
+
+	/* Set DT of image data and DT of long packet data*/
+	writel(dt_image, &res->capture_reg->sys.IPORTS_MAIN_DT);
+	writel(0x00, &res->capture_reg->sys.IPORTS_OTHER);
+
+	/* Set line size and delay value of delayed Vsync */
+	sysclk_num = lineperiod_in_sysclk(in_img->htotal_size, in_img->pixel_clock);
+	writel(sysclk_num & GENMASK(15, 0), &res->capture_reg->sys.INT_SA0_LINE);
+	temp_delay = in_img->vbp_size - 4U;
+	if (temp_delay > 255U) {
+		/* Replace the value with HW max spec */
+		temp_delay = 255U;
+	}
+	writel(temp_delay, &res->capture_reg->sys.INT_SA1_LINE);
+
+	return 0;
+}
+
+#define VDMAC_SRAM_BASE_ADDR_W03 0x440U
+
+/**
+ * hwd_viif_sub_set_img_transmission() - Set image transfer condition of SUB unit
+ *
+ * @img: Pointer to output image information
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] Member of "img" is invalid
+ */
+s32 hwd_viif_sub_set_img_transmission(u32 module_id, const struct hwd_viif_img *img)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	struct hwd_viif_vdm_write_port_reg *wport3;
+	u32 img_start_addr, img_end_addr;
+	u32 data_width, pitch, height;
+	u32 k, port_control;
+
+	/* disable VDMAC when img is NULL */
+	if (!img) {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTS_IMGEN);
+		port_control = ~((u32)1U << 3U) & readl(&res->capture_reg->vdm.VDM_W_ENABLE);
+		writel(port_control, &res->capture_reg->vdm.VDM_W_ENABLE);
+		return 0;
+	}
+
+	if (((img->width % 2U) != 0U) || ((img->height % 2U) != 0U))
+		return -EINVAL;
+
+	if (img->width < HWD_VIIF_MIN_OUTPUT_IMG_WIDTH ||
+	    img->height < HWD_VIIF_MIN_OUTPUT_IMG_HEIGHT ||
+	    img->width > HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_SUB ||
+	    img->height > HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_SUB) {
+		return -EINVAL;
+	}
+
+	img_start_addr = (u32)img->pixelmap[0].pmap_paddr;
+	pitch = img->pixelmap[0].pitch;
+	height = img->height;
+
+	switch (img->format) {
+	case HWD_VIIF_ONE_COLOR_8:
+		data_width = 0U;
+		img_end_addr = img_start_addr + img->width - 1U;
+		k = 1;
+		break;
+	case HWD_VIIF_ONE_COLOR_16:
+		data_width = 1U;
+		img_end_addr = img_start_addr + (img->width * 2U) - 1U;
+		k = 2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if ((img_start_addr % 4U) != 0U)
+		return -EINVAL;
+
+	if ((pitch < (img->width * k)) || pitch > HWD_VIIF_MAX_PITCH || ((pitch % 4U) != 0U))
+		return -EINVAL;
+
+	wport3 = &res->capture_reg->vdm.w_port[3];
+	writel(VDMAC_SRAM_BASE_ADDR_W03, &wport3->VDM_W_SRAM_BASE);
+	writel(res->sram_size_w_port, &wport3->VDM_W_SRAM_SIZE);
+	writel(img_start_addr, &wport3->VDM_W_STADR);
+	writel(img_end_addr, &wport3->VDM_W_ENDADR);
+	writel(height, &wport3->VDM_W_HEIGHT);
+	writel(pitch, &wport3->VDM_W_PITCH);
+	writel(data_width << 8U, &wport3->VDM_W_CFG0);
+	port_control = BIT(3) | readl(&res->capture_reg->vdm.VDM_W_ENABLE);
+	writel(port_control, &res->capture_reg->vdm.VDM_W_ENABLE);
+	writel(HWD_VIIF_ENABLE, &res->capture_reg->sys.IPORTS_IMGEN);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_sub_status_err_set_irq_mask() -
+ *  Set mask condition for STATUS error of SUB unit or VOIF loopback
+ *
+ * @mask: STATUS error mask condition
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_viif_sub_status_err_set_irq_mask(u32 module_id, u32 mask)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	writel(mask, &res->capture_reg->sys.INT_S_MASK);
+}
+
+/**
+ * hwd_viif_sub_vsync_set_irq_mask() - Set mask condition for Vsync of SUB unit or VOIF loopback
+ *
+ * @mask: Vsync mask condition
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_viif_sub_vsync_set_irq_mask(u32 module_id, const u32 mask)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	writel(mask, &res->capture_reg->sys.INT_S_SYNC_MASK);
+}
+
+/**
+ * hwd_viif_isp_set_regbuf_auto_transmission() - Set register buffer auto transmission
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_viif_isp_set_regbuf_auto_transmission(u32 module_id)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val;
+
+	/* Set parameters for auto read transmission of register buffer */
+
+	if (res->dt_image_main_w_isp != 0x0U) {
+		/*
+		 * configuration is done
+		 * only when dt_image is not 0, means image data is input to ISP.
+		 */
+		writel(0x0, &res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF);
+		writel(0x0, &res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF);
+		writel(HWD_VIIF_L1_CRGBF_R_START_ADDR_LIMIT,
+		       &res->capture_reg->l1isp.L1_CRGBF_TRN_RBADDR);
+		writel(HWD_VIIF_L1_CRGBF_R_END_ADDR_LIMIT,
+		       &res->capture_reg->l1isp.L1_CRGBF_TRN_READDR);
+		writel(HWD_VIIF_L2_CRGBF_R_START_ADDR_LIMIT,
+		       &res->capture_reg->l2isp.L2_CRGBF_TRN_RBADDR);
+		writel(HWD_VIIF_L2_CRGBF_R_END_ADDR_LIMIT,
+		       &res->capture_reg->l2isp.L2_CRGBF_TRN_READDR);
+		val = BIT(16);
+		writel(val, &res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF);
+		writel(val, &res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF);
+	}
+}
+
+/**
+ * hwd_viif_isp_disable_regbuf_auto_transmission() - Disable register buffer auto transmission
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_viif_isp_disable_regbuf_auto_transmission(u32 module_id)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (res->dt_image_main_w_isp != 0x0U) {
+		writel(0x0, &res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF);
+		writel(0x0, &res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF);
+	}
+}
+
+/**
+ * hwd_viif_isp_guard_start() - stop register auto update
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ *
+ * This function call stops update of some hardware registers
+ * while the manual setup of VIIF, L1ISP registers is in progress.
+ *
+ * * regbuf control: load/store HW register (settings, status) values to backup SRAM.
+ * * vlatch control: copy timer-counter register value to status register.
+ */
+void hwd_viif_isp_guard_start(u32 module_id)
+{
+	hwd_viif_isp_disable_regbuf_auto_transmission(module_id);
+	ndelay(500);
+	hwd_viif_main_mask_vlatch(module_id, HWD_VIIF_ENABLE);
+}
+
+/**
+ * hwd_viif_isp_guard_start() - restart register auto update
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ *
+ * see also hwd_viif_isp_guard_start().
+ */
+void hwd_viif_isp_guard_end(u32 module_id)
+{
+	hwd_viif_main_mask_vlatch(module_id, HWD_VIIF_DISABLE);
+	hwd_viif_isp_set_regbuf_auto_transmission(module_id);
+}
+
+#define L2_STATUS_REPORT_MASK 0x1eU
+
+/**
+ * hwd_viif_isp_get_info() - Get processing information of L1ISP and L2ISP
+ *
+ * @l1_info: L1ISP processing information
+ * @l2_transfer_status: status of L2ISP transmission
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_viif_isp_get_info(u32 module_id, struct hwd_viif_l1_info *l1_info, u32 *l2_transfer_status)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val, l2_status;
+	int i, j;
+
+	if (l1_info) {
+		/* change register buffer to regbuf0 where driver gets information */
+		writel(HWD_VIIF_ISP_REGBUF_MODE_BUFFER, &res->capture_reg->l1isp.L1_CRGBF_ACC_CONF);
+
+		/* get AWB info */
+		l1_info->awb_ave_u = readl(&res->capture_reg->l1isp.L1_AWHB_AVE_USIG);
+		l1_info->awb_ave_v = readl(&res->capture_reg->l1isp.L1_AWHB_AVE_VSIG);
+		l1_info->awb_accumulated_pixel = readl(&res->capture_reg->l1isp.L1_AWHB_NUM_UVON);
+		l1_info->awb_gain_r = readl(&res->capture_reg->l1isp.L1_AWHB_AWBGAINR);
+		l1_info->awb_gain_g = readl(&res->capture_reg->l1isp.L1_AWHB_AWBGAING);
+		l1_info->awb_gain_b = readl(&res->capture_reg->l1isp.L1_AWHB_AWBGAINB);
+		val = readl(&res->capture_reg->l1isp.L1_AWHB_R_CTR_STOP);
+		l1_info->awb_status_u = (FIELD_GET(BIT(1), val) != 0);
+		l1_info->awb_status_v = (FIELD_GET(BIT(0), val) != 0);
+
+		/* get average luminance info */
+		l1_info->avg_lum_weight = readl(&res->capture_reg->l1isp.L1_AEXP_RESULT_AVE);
+		val = readl(&res->capture_reg->l1isp.L1_AEXP_SATUR_BLACK_PIXNUM);
+		l1_info->avg_satur_pixnum = FIELD_GET(GENMASK(31, 16), val);
+		l1_info->avg_black_pixnum = FIELD_GET(GENMASK(15, 0), val);
+		for (i = 0; i < 8; i++) {
+			for (j = 0; j < 8; j++) {
+				l1_info->avg_lum_block[i][j] =
+					readl(&res->capture_reg->l1isp.L1_AEXP_AVE[i][j]);
+			}
+		}
+		l1_info->avg_lum_four_line_lum[0] =
+			readl(&res->capture_reg->l1isp.L1_AEXP_AVE4LINES0);
+		l1_info->avg_lum_four_line_lum[1] =
+			readl(&res->capture_reg->l1isp.L1_AEXP_AVE4LINES1);
+		l1_info->avg_lum_four_line_lum[2] =
+			readl(&res->capture_reg->l1isp.L1_AEXP_AVE4LINES2);
+		l1_info->avg_lum_four_line_lum[3] =
+			readl(&res->capture_reg->l1isp.L1_AEXP_AVE4LINES3);
+
+		/* revert to register access from register buffer access */
+		writel(HWD_VIIF_ISP_REGBUF_MODE_BYPASS, &res->capture_reg->l1isp.L1_CRGBF_ACC_CONF);
+	}
+
+	if (l2_transfer_status) {
+		/* get L2ISP abort information */
+		l2_status = readl(&res->capture_reg->l2isp.L2_CRGBF_ISP_INT);
+		writel(l2_status, &res->capture_reg->l2isp.L2_CRGBF_ISP_INT);
+		*l2_transfer_status = l2_status & L2_STATUS_REPORT_MASK;
+	}
+}
+
+/**
+ * hwd_viif_isp_set_regbuf_irq_mask() - Set mask condition for ISP register buffer
+ *
+ * @mask_l1: Pointer to mask configuration for L1ISP register buffer interruption
+ * @mask_l2: Pointer to mask configuration for L2ISP register buffer interruption
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_viif_isp_set_regbuf_irq_mask(u32 module_id, const u32 *mask_l1, const u32 *mask_l2)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	writel(*mask_l1, &res->capture_reg->l1isp.L1_CRGBF_INT_MASK);
+	writel(*mask_l2, &res->capture_reg->l2isp.L2_CRGBF_INT_MASK);
+}
+
+/**
+ * hwd_viif_l2_set_input_csc() - Set input CSC parameters of L2ISP
+ *
+ * @param: Pointer to input csc parameters of L2ISP
+ * @is_l1_rgb: input information of L2ISP
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] Member of "param" is invalid
+ */
+s32 hwd_viif_l2_set_input_csc(u32 module_id, const struct hwd_viif_csc_param *param, bool is_l1_rgb)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	struct hwd_viif_csc_param hwd_param;
+	u32 enable = HWD_VIIF_ENABLE;
+	bool csc_enable_flag = true;
+	u32 i, val;
+
+	if (param) {
+		if (param->r_cr_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+		    param->g_y_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+		    param->b_cb_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+		    param->r_cr_out_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+		    param->g_y_out_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+		    param->b_cb_out_offset > HWD_VIIF_CSC_MAX_OFFSET) {
+			return -EINVAL;
+		}
+
+		for (i = 0; i < HWD_VIIF_CSC_MAX_COEF_NUM; i++) {
+			if (param->coef[i] > HWD_VIIF_CSC_MAX_COEF_VALUE)
+				return -EINVAL;
+		}
+
+		if (is_l1_rgb) {
+			/* translated parameters are used */
+			hwd_param.r_cr_in_offset = param->b_cb_in_offset;
+			hwd_param.g_y_in_offset = param->r_cr_in_offset;
+			hwd_param.b_cb_in_offset = param->g_y_in_offset;
+			hwd_param.r_cr_out_offset = param->r_cr_out_offset;
+			hwd_param.g_y_out_offset = param->g_y_out_offset;
+			hwd_param.b_cb_out_offset = param->b_cb_out_offset;
+			hwd_param.coef[0] = param->coef[2];
+			hwd_param.coef[1] = param->coef[0];
+			hwd_param.coef[2] = param->coef[1];
+			hwd_param.coef[3] = param->coef[5];
+			hwd_param.coef[4] = param->coef[3];
+			hwd_param.coef[5] = param->coef[4];
+			hwd_param.coef[6] = param->coef[8];
+			hwd_param.coef[7] = param->coef[6];
+			hwd_param.coef[8] = param->coef[7];
+		} else {
+			/* original parameters are used */
+			hwd_param.r_cr_in_offset = param->r_cr_in_offset;
+			hwd_param.g_y_in_offset = param->g_y_in_offset;
+			hwd_param.b_cb_in_offset = param->b_cb_in_offset;
+			hwd_param.r_cr_out_offset = param->r_cr_out_offset;
+			hwd_param.g_y_out_offset = param->g_y_out_offset;
+			hwd_param.b_cb_out_offset = param->b_cb_out_offset;
+			hwd_param.coef[0] = param->coef[0];
+			hwd_param.coef[1] = param->coef[1];
+			hwd_param.coef[2] = param->coef[2];
+			hwd_param.coef[3] = param->coef[3];
+			hwd_param.coef[4] = param->coef[4];
+			hwd_param.coef[5] = param->coef[5];
+			hwd_param.coef[6] = param->coef[6];
+			hwd_param.coef[7] = param->coef[7];
+			hwd_param.coef[8] = param->coef[8];
+		}
+	} else {
+		if (is_l1_rgb) {
+			/* fixed parameters are used */
+			hwd_param.r_cr_in_offset = 0U;
+			hwd_param.g_y_in_offset = 0U;
+			hwd_param.b_cb_in_offset = 0U;
+			hwd_param.r_cr_out_offset = 0U;
+			hwd_param.g_y_out_offset = 0U;
+			hwd_param.b_cb_out_offset = 0U;
+			hwd_param.coef[0] = 0U;
+			hwd_param.coef[1] = 0x1000U;
+			hwd_param.coef[2] = 0U;
+			hwd_param.coef[3] = 0U;
+			hwd_param.coef[4] = 0U;
+			hwd_param.coef[5] = 0x1000U;
+			hwd_param.coef[6] = 0x1000U;
+			hwd_param.coef[7] = 0U;
+			hwd_param.coef[8] = 0U;
+		} else {
+			/* csc is disabled */
+			enable = HWD_VIIF_DISABLE;
+			csc_enable_flag = false;
+		}
+	}
+
+	if (csc_enable_flag) {
+		writel(hwd_param.g_y_in_offset,
+		       &res->capture_reg->sys.l2isp_input_csc.MTB_YG_OFFSETI);
+		writel(hwd_param.coef[0], &res->capture_reg->sys.l2isp_input_csc.MTB_YG1);
+		val = (hwd_param.coef[1] << HWD_VIIF_MTB_CB_YG_COEF_OFFSET) |
+		      (hwd_param.coef[2] << HWD_VIIF_MTB_CR_YG_COEF_OFFSET);
+		writel(val, &res->capture_reg->sys.l2isp_input_csc.MTB_YG2);
+		writel(hwd_param.g_y_out_offset,
+		       &res->capture_reg->sys.l2isp_input_csc.MTB_YG_OFFSETO);
+		writel(hwd_param.b_cb_in_offset,
+		       &res->capture_reg->sys.l2isp_input_csc.MTB_CB_OFFSETI);
+		writel(hwd_param.coef[3], &res->capture_reg->sys.l2isp_input_csc.MTB_CB1);
+		val = (hwd_param.coef[4] << HWD_VIIF_MTB_CB_CB_COEF_OFFSET) |
+		      (hwd_param.coef[5] << HWD_VIIF_MTB_CR_CB_COEF_OFFSET);
+		writel(val, &res->capture_reg->sys.l2isp_input_csc.MTB_CB2);
+		writel(hwd_param.b_cb_out_offset,
+		       &res->capture_reg->sys.l2isp_input_csc.MTB_CB_OFFSETO);
+		writel(hwd_param.r_cr_in_offset,
+		       &res->capture_reg->sys.l2isp_input_csc.MTB_CR_OFFSETI);
+		writel(hwd_param.coef[6], &res->capture_reg->sys.l2isp_input_csc.MTB_CR1);
+		val = (hwd_param.coef[7] << HWD_VIIF_MTB_CB_CR_COEF_OFFSET) |
+		      (hwd_param.coef[8] << HWD_VIIF_MTB_CR_CR_COEF_OFFSET);
+		writel(val, &res->capture_reg->sys.l2isp_input_csc.MTB_CR2);
+		writel(hwd_param.r_cr_out_offset,
+		       &res->capture_reg->sys.l2isp_input_csc.MTB_CR_OFFSETO);
+	}
+
+	writel(enable, &res->capture_reg->sys.l2isp_input_csc.MTB);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l2_set_undist() - Set undistortion parameters of L2ISP
+ *
+ * @param: Pointer to undistortion parameters of L2ISP
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "param" is NULL
+ * - [2] Member of "param" is invalid
+ */
+s32 hwd_viif_l2_set_undist(u32 module_id, const struct viif_l2_undist *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 grid_num_h, grid_num_v;
+	u32 i, val;
+
+	if (!param)
+		return -EINVAL;
+
+	if (param->through_mode != HWD_VIIF_ENABLE && param->through_mode != HWD_VIIF_DISABLE)
+		return -EINVAL;
+
+	if (param->roi_mode[0] != HWD_VIIF_L2_UNDIST_POLY &&
+	    param->roi_mode[0] != HWD_VIIF_L2_UNDIST_GRID &&
+	    param->roi_mode[0] != HWD_VIIF_L2_UNDIST_POLY_TO_GRID &&
+	    param->roi_mode[0] != HWD_VIIF_L2_UNDIST_GRID_TO_POLY) {
+		return -EINVAL;
+	}
+	if (param->roi_mode[1] != HWD_VIIF_L2_UNDIST_POLY &&
+	    param->roi_mode[1] != HWD_VIIF_L2_UNDIST_GRID &&
+	    param->roi_mode[1] != HWD_VIIF_L2_UNDIST_POLY_TO_GRID &&
+	    param->roi_mode[1] != HWD_VIIF_L2_UNDIST_GRID_TO_POLY) {
+		return -EINVAL;
+	}
+	if (param->roi_write_area_delta[0] >= HWD_VIIF_L2_UNDIST_MAX_ROI_WRITE_AREA_DELTA ||
+	    param->roi_write_area_delta[1] >= HWD_VIIF_L2_UNDIST_MAX_ROI_WRITE_AREA_DELTA ||
+	    param->sensor_crop_ofs_h < HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_H ||
+	    param->sensor_crop_ofs_h > HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_H ||
+	    param->sensor_crop_ofs_v < HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_V ||
+	    param->sensor_crop_ofs_v > HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_V ||
+	    param->norm_scale > HWD_VIIF_L2_UNDIST_MAX_NORM_SCALE ||
+	    param->valid_r_norm2_poly >= HWD_VIIF_L2_UNDIST_MAX_VALID_R_NORM2 ||
+	    param->valid_r_norm2_grid >= HWD_VIIF_L2_UNDIST_MAX_VALID_R_NORM2) {
+		return -EINVAL;
+	}
+
+	for (i = 0; i < HWD_VIIF_L2_UNDIST_POLY_NUM; i++) {
+		if (param->poly_write_g_coef[i] < HWD_VIIF_L2_UNDIST_MIN_POLY_COEF ||
+		    param->poly_write_g_coef[i] > HWD_VIIF_L2_UNDIST_MAX_POLY_COEF ||
+		    param->poly_read_b_coef[i] < HWD_VIIF_L2_UNDIST_MIN_POLY_COEF ||
+		    param->poly_read_b_coef[i] > HWD_VIIF_L2_UNDIST_MAX_POLY_COEF ||
+		    param->poly_read_g_coef[i] < HWD_VIIF_L2_UNDIST_MIN_POLY_COEF ||
+		    param->poly_read_g_coef[i] > HWD_VIIF_L2_UNDIST_MAX_POLY_COEF ||
+		    param->poly_read_r_coef[i] < HWD_VIIF_L2_UNDIST_MIN_POLY_COEF ||
+		    param->poly_read_r_coef[i] > HWD_VIIF_L2_UNDIST_MAX_POLY_COEF) {
+			return -EINVAL;
+		}
+	}
+
+	if (param->grid_node_num_h < HWD_VIIF_L2_UNDIST_MIN_GRID_NUM ||
+	    param->grid_node_num_h > HWD_VIIF_L2_UNDIST_MAX_GRID_NUM ||
+	    param->grid_node_num_v < HWD_VIIF_L2_UNDIST_MIN_GRID_NUM ||
+	    param->grid_node_num_v > HWD_VIIF_L2_UNDIST_MAX_GRID_NUM) {
+		return -EINVAL;
+	}
+
+	grid_num_h = param->grid_node_num_h;
+	grid_num_v = param->grid_node_num_v;
+	if ((grid_num_h % 2U) != 0U)
+		grid_num_h += 1U;
+
+	if ((grid_num_v % 2U) != 0U)
+		grid_num_v += 1U;
+
+	if ((grid_num_v * grid_num_h) > HWD_VIIF_L2_UNDIST_MAX_GRID_TOTAL_NUM ||
+	    param->grid_patch_hsize_inv >= HWD_VIIF_L2_UNDIST_MAX_GRID_PATCH_SIZE_INV ||
+	    param->grid_patch_vsize_inv >= HWD_VIIF_L2_UNDIST_MAX_GRID_PATCH_SIZE_INV) {
+		return -EINVAL;
+	}
+
+	val = readl(&res->capture_reg->l2isp.L2_SENSOR_CROP_HSIZE) & GENMASK(12, 0);
+	if (((param->sensor_crop_ofs_h / 2) + ((s16)val)) > 4095)
+		return -EINVAL;
+
+	val = readl(&res->capture_reg->l2isp.L2_SENSOR_CROP_VSIZE) & GENMASK(11, 0);
+	if (((param->sensor_crop_ofs_v / 2) + ((s16)val)) > 2047)
+		return -EINVAL;
+
+	/* set parameters related to L2ISP UNDIST */
+	if (param->through_mode == HWD_VIIF_ENABLE) {
+		/* Enable through mode */
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l2isp.L2_MODE);
+	} else {
+		val = (param->roi_mode[0] << 1U) | (param->roi_mode[1] << 3U);
+		writel(val, &res->capture_reg->l2isp.L2_MODE);
+		val = (u32)param->sensor_crop_ofs_h & GENMASK(13, 0);
+		writel(val, &res->capture_reg->l2isp.L2_SENSOR_CROP_OFS_H);
+		val = (u32)param->sensor_crop_ofs_v & GENMASK(12, 0);
+		writel(val, &res->capture_reg->l2isp.L2_SENSOR_CROP_OFS_V);
+		writel(param->norm_scale, &res->capture_reg->l2isp.L2_NORM_SCALE);
+		writel(param->valid_r_norm2_poly, &res->capture_reg->l2isp.L2_VALID_R_NORM2_POLY);
+		writel(param->valid_r_norm2_grid, &res->capture_reg->l2isp.L2_VALID_R_NORM2_GRID);
+		writel(param->roi_write_area_delta[0],
+		       &res->capture_reg->l2isp.L2_ROI_WRITE_AREA_DELTA[0]);
+		writel(param->roi_write_area_delta[1],
+		       &res->capture_reg->l2isp.L2_ROI_WRITE_AREA_DELTA[1]);
+
+		for (i = 0; i < HWD_VIIF_L2_UNDIST_POLY_NUM; i++) {
+			val = (u32)param->poly_write_g_coef[i];
+			writel(val, &res->capture_reg->l2isp.L2_POLY10_WRITE_G_COEF[i]);
+			val = (u32)param->poly_read_b_coef[i];
+			writel(val, &res->capture_reg->l2isp.L2_POLY10_READ_B_COEF[i]);
+			val = (u32)param->poly_read_g_coef[i];
+			writel(val, &res->capture_reg->l2isp.L2_POLY10_READ_G_COEF[i]);
+			val = (u32)param->poly_read_r_coef[i];
+			writel(val, &res->capture_reg->l2isp.L2_POLY10_READ_R_COEF[i]);
+		}
+		writel(param->grid_node_num_h, &res->capture_reg->l2isp.L2_GRID_NODE_NUM_H);
+		writel(param->grid_node_num_v, &res->capture_reg->l2isp.L2_GRID_NODE_NUM_V);
+		writel(param->grid_patch_hsize_inv,
+		       &res->capture_reg->l2isp.L2_GRID_PATCH_HSIZE_INV);
+		writel(param->grid_patch_vsize_inv,
+		       &res->capture_reg->l2isp.L2_GRID_PATCH_VSIZE_INV);
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l2_set_undist_table_transmission() -
+ *  Configure L2ISP transferring grid table for undistortion.
+ *
+ * @write_g: grid table address for G-WRITE(physical address)
+ * @read_b: grid table address for B-READ(physical address)
+ * @read_g: grid table address for G-READ(physical address)
+ * @read_r: grid table address for R-READ(physical address)
+ * @size: of each table [1024..8192] [byte]
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "write_g", "read_b", "read_g" or "read_r" is not 4byte alignment
+ * - "size" is out of range
+ * - "size" is not 0 when all table addresses are 0
+ */
+s32 hwd_viif_l2_set_undist_table_transmission(u32 module_id, uintptr_t write_g, uintptr_t read_b,
+					      uintptr_t read_g, uintptr_t read_r, u32 size)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val = 0U;
+
+	if (((write_g % HWD_VIIF_L2_VDM_ALIGN) != 0U) || ((read_b % HWD_VIIF_L2_VDM_ALIGN) != 0U) ||
+	    ((read_g % HWD_VIIF_L2_VDM_ALIGN) != 0U) || ((read_r % HWD_VIIF_L2_VDM_ALIGN) != 0U)) {
+		return -EINVAL;
+	}
+
+	if ((size != 0U && size < HWD_VIIF_L2_UNDIST_MIN_TABLE_SIZE) ||
+	    size > HWD_VIIF_L2_UNDIST_MAX_TABLE_SIZE) {
+		return -EINVAL;
+	}
+
+	if ((size % 4U) != 0U)
+		return -EINVAL;
+
+	if (write_g == 0U && read_b == 0U && read_g == 0U && read_r == 0U && size != 0U)
+		return -EINVAL;
+
+	if ((write_g != 0U || read_b != 0U || read_g != 0U || read_r != 0U) && size == 0U)
+		return -EINVAL;
+
+	/* read_b: t_port[8], read_g: t_port[9], read_r: t_port[10], write_g: t_port[11] */
+	if (read_b != 0U) {
+		writel((u32)read_b, &res->capture_reg->vdm.t_port[8].VDM_T_STADR);
+		writel(size, &res->capture_reg->vdm.t_port[8].VDM_T_SIZE);
+		val |= BIT(8);
+	}
+	if (read_g != 0U) {
+		writel((u32)read_g, &res->capture_reg->vdm.t_port[9].VDM_T_STADR);
+		writel(size, &res->capture_reg->vdm.t_port[9].VDM_T_SIZE);
+		val |= BIT(9);
+	}
+	if (read_r != 0U) {
+		writel((u32)read_r, &res->capture_reg->vdm.t_port[10].VDM_T_STADR);
+		writel(size, &res->capture_reg->vdm.t_port[10].VDM_T_SIZE);
+		val |= BIT(10);
+	}
+	if (write_g != 0U) {
+		writel((u32)write_g, &res->capture_reg->vdm.t_port[11].VDM_T_STADR);
+		writel(size, &res->capture_reg->vdm.t_port[11].VDM_T_SIZE);
+		val |= BIT(11);
+	}
+
+	if (val != 0U) {
+		/*
+		 * Set SRAM base address and size.
+		 * t_group[1] is used only to transfer UNDIST table
+		 */
+		writel(HWD_VIIF_VDM_CFG_PARAM, &res->capture_reg->vdm.t_group[1].VDM_T_CFG);
+		writel(HWD_VIIF_L2_VDM_GRID_SRAM_BASE,
+		       &res->capture_reg->vdm.t_group[1].VDM_T_SRAM_BASE);
+		writel(HWD_VIIF_L2_VDM_GRID_SRAM_SIZE,
+		       &res->capture_reg->vdm.t_group[1].VDM_T_SRAM_SIZE);
+	}
+
+	val |= (readl(&res->capture_reg->vdm.VDM_T_ENABLE) & ~((u32)0xfU << 8U));
+	writel(val, &res->capture_reg->vdm.VDM_T_ENABLE);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l2_set_roi_num_1() - Set ROI path condition when ROI num is 1
+ */
+static void hwd_viif_l2_set_roi_num_1(struct hwd_viif_res *res)
+{
+	struct hwd_viif_l2_roi_path_info *info = &res->l2_roi_path_info;
+	u32 val, x_min, x_max, y_min, y_max;
+	u32 i, x, y, w, h;
+
+	/* ROI0 is input to POST0 and POST1 */
+	if (info->post_enable_flag[0]) {
+		/* POST0 is enabled */
+		x_min = info->post_crop_x[0];
+		x_max = info->post_crop_x[0] + info->post_crop_w[0];
+		y_min = info->post_crop_y[0];
+		y_max = info->post_crop_y[0] + info->post_crop_h[0];
+		if (info->post_enable_flag[1]) {
+			/* POST1 is enabled */
+			x_min = min(x_min, info->post_crop_x[1]);
+			val = info->post_crop_x[1] + info->post_crop_w[1];
+			x_max = max(x_max, val);
+			y_min = min(y_min, info->post_crop_y[1]);
+			val = info->post_crop_y[1] + info->post_crop_h[1];
+			y_max = max(y_max, val);
+		}
+		x = x_min;
+		y = y_min;
+		w = x_max - x_min;
+		h = y_max - y_min;
+	} else if (info->post_enable_flag[1]) {
+		/* POST0 is disabled and POST1 is enabled */
+		x = info->post_crop_x[1];
+		w = info->post_crop_w[1];
+		y = info->post_crop_y[1];
+		h = info->post_crop_h[1];
+	} else {
+		/* All POSTs are disabled */
+		x = 0;
+		y = 0;
+		w = HWD_VIIF_CROP_MIN_W;
+		h = HWD_VIIF_CROP_MIN_H;
+	}
+	writel(x, &res->capture_reg->l2isp.roi[0].L2_ROI_OUT_OFS_H);
+	writel(y, &res->capture_reg->l2isp.roi[0].L2_ROI_OUT_OFS_V);
+	writel(w, &res->capture_reg->l2isp.roi[0].L2_ROI_OUT_HSIZE);
+	writel(h, &res->capture_reg->l2isp.roi[0].L2_ROI_OUT_VSIZE);
+
+	for (i = 0; i < HWD_VIIF_MAX_POST_NUM; i++) {
+		if (info->post_enable_flag[i])
+			writel(0, &res->capture_reg->l2isp.L2_ROI_TO_POST[i]);
+		else
+			writel(HWD_VIIF_L2_ROI_NONE, &res->capture_reg->l2isp.L2_ROI_TO_POST[i]);
+	}
+}
+
+/**
+ * hwd_viif_l2_set_roi_num_2() - Set ROI path condition when ROI num is 2
+ */
+static void hwd_viif_l2_set_roi_num_2(struct hwd_viif_res *res)
+{
+	struct hwd_viif_l2_roi_path_info *info = &res->l2_roi_path_info;
+	u32 i;
+
+	for (i = 0; i < HWD_VIIF_L2_ROI_MAX_NUM; i++) {
+		/* ROI-n is the same as CROP area of POST-n */
+		if (info->post_enable_flag[i]) {
+			writel(info->post_crop_x[i],
+			       &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_H);
+			writel(info->post_crop_y[i],
+			       &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_V);
+			writel(info->post_crop_w[i],
+			       &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_HSIZE);
+			writel(info->post_crop_h[i],
+			       &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_VSIZE);
+			writel(i, &res->capture_reg->l2isp.L2_ROI_TO_POST[i]);
+		} else {
+			writel(0, &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_H);
+			writel(0, &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_V);
+			writel(HWD_VIIF_CROP_MIN_W,
+			       &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_HSIZE);
+			writel(HWD_VIIF_CROP_MIN_H,
+			       &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_VSIZE);
+			writel(HWD_VIIF_L2_ROI_NONE, &res->capture_reg->l2isp.L2_ROI_TO_POST[i]);
+		}
+	}
+}
+
+/**
+ * hwd_viif_l2_set_roi_path() - Set ROI path condition
+ */
+static void hwd_viif_l2_set_roi_path(struct hwd_viif_res *res)
+{
+	if (res->l2_roi_path_info.roi_num == 1U)
+		hwd_viif_l2_set_roi_num_1(res);
+	else
+		hwd_viif_l2_set_roi_num_2(res);
+}
+
+/**
+ * hwd_viif_l2_set_roi() - Set ROI parameters of L2ISP
+ *
+ * @param: Pointer to ROI parameters of L2ISP
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "param" is NULL
+ * - [2] Member of "param" is invalid
+ *
+ * see also: #hwd_viif_l2_set_roi_path
+ */
+s32 hwd_viif_l2_set_roi(u32 module_id, const struct viif_l2_roi_config *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val;
+	int i;
+
+	if (!param)
+		return -EINVAL;
+
+	if (param->roi_num < 1 || param->roi_num > 2)
+		return -EINVAL;
+
+	for (i = 0; i < 2; i++) {
+		if (param->roi_scale[i] < HWD_VIIF_L2_ROI_MIN_SCALE ||
+		    param->roi_scale[i] > HWD_VIIF_L2_ROI_MAX_SCALE ||
+		    param->roi_scale_inv[i] < HWD_VIIF_L2_ROI_MIN_SCALE_INV ||
+		    param->roi_scale_inv[i] > HWD_VIIF_L2_ROI_MAX_SCALE_INV ||
+		    param->corrected_wo_scale_hsize[i] <
+			    HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_HSIZE ||
+		    param->corrected_wo_scale_hsize[i] >
+			    HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_HSIZE ||
+		    param->corrected_wo_scale_vsize[i] <
+			    HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_VSIZE ||
+		    param->corrected_wo_scale_vsize[i] >
+			    HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_VSIZE ||
+		    param->corrected_hsize[i] < HWD_VIIF_L2_ROI_MIN_CORRECTED_HSIZE ||
+		    param->corrected_hsize[i] > HWD_VIIF_L2_ROI_MAX_CORRECTED_HSIZE ||
+		    param->corrected_vsize[i] < HWD_VIIF_L2_ROI_MIN_CORRECTED_VSIZE ||
+		    param->corrected_vsize[i] > HWD_VIIF_L2_ROI_MAX_CORRECTED_VSIZE) {
+			return -EINVAL;
+		}
+	}
+
+	/* Set the number of ROI and update resource info with roi_num */
+	writel(param->roi_num, &res->capture_reg->l2isp.L2_ROI_NUM);
+	res->l2_roi_path_info.roi_num = param->roi_num;
+
+	/* Update ROI area and input to each POST */
+	hwd_viif_l2_set_roi_path(res);
+
+	/* Set the remaining parameters */
+	for (i = 0; i < 2; i++) {
+		writel(param->roi_scale[i], &res->capture_reg->l2isp.roi[i].L2_ROI_SCALE);
+		writel(param->roi_scale_inv[i], &res->capture_reg->l2isp.roi[i].L2_ROI_SCALE_INV);
+		val = (param->corrected_wo_scale_hsize[i] << 13U) | param->corrected_hsize[i];
+		writel(val, &res->capture_reg->l2isp.roi[i].L2_ROI_CORRECTED_HSIZE);
+		val = (param->corrected_wo_scale_vsize[i] << 12U) | param->corrected_vsize[i];
+		writel(val, &res->capture_reg->l2isp.roi[i].L2_ROI_CORRECTED_VSIZE);
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l2_set_gamma() - Set Gamma correction parameters of L2ISP
+ *
+ * @post_id: POST ID [0..1]
+ * @enable: or disable gamma correction of L2ISP. For more refer @ref hwd_viif_enable_flag.
+ * @vsplit: changing line position from 1st table to 2nd table [0..4094]
+ * @mode: Gamma correction mode. For more refer @ref hwd_viif_gamma_table_mode.
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "post_id", "enable", "vsplit"  or "mode" is out of range
+ * - [2] "vsplit" is not 0 when "enable" is HWD_VIIF_DISABLE
+ * - [3] "mode" is not HWD_VIIF_GAMMA_COMPRESSED when enable is HWD_VIIF_DISABLE
+ *
+ * see also: #hwd_viif_l2_set_gamma
+ */
+s32 hwd_viif_l2_set_gamma(u32 module_id, u32 post_id, u32 enable, u32 vsplit, u32 mode)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val;
+
+	if (post_id >= HWD_VIIF_MAX_POST_NUM ||
+	    (enable != HWD_VIIF_ENABLE && enable != HWD_VIIF_DISABLE) ||
+	    vsplit > HWD_VIIF_GAMMA_MAX_VSPLIT ||
+	    (mode != HWD_VIIF_GAMMA_COMPRESSED && mode != HWD_VIIF_GAMMA_LINEAR) ||
+	    (enable == HWD_VIIF_DISABLE && vsplit != 0x0U) ||
+	    (enable == HWD_VIIF_DISABLE && mode != HWD_VIIF_GAMMA_COMPRESSED)) {
+		return -EINVAL;
+	}
+
+	/* Set gamma parameters of L2ISP */
+	val = (vsplit << 16U) | (mode << 4U) | enable;
+	writel(val, &res->capture_reg->l2isp.post[post_id].L2_POST_GAMMA_M);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l2_set_gamma_table_transmission() - Configure L2ISP transferring gamma table.
+ *
+ * @post_id: POST ID [0..1]
+ * @gamma_table: Pointer to gamma table information
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "post_id" is out of range
+ * - [2] Member of "gamma_table" is invalid
+ */
+s32 hwd_viif_l2_set_gamma_table_transmission(u32 module_id, u32 post_id,
+					     const struct hwd_viif_l2_gamma_table *gamma_table)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 vdm_enable = 0U;
+	u32 i, base_addr;
+
+	if (post_id >= HWD_VIIF_MAX_POST_NUM)
+		return -EINVAL;
+
+	for (i = 0; i < 6U; i++) {
+		if ((gamma_table->table[i] % HWD_VIIF_L2_VDM_ALIGN) != 0U)
+			return -EINVAL;
+	}
+
+	/* table[0]: LUT0-G/Y: t_port[12 + post_id * 6] */
+	/* table[1]: LUT1-G/Y: t_port[13 + post_id * 6] */
+	/* table[2]: LUT0-B/U: t_port[14 + post_id * 6] */
+	/* table[3]: LUT1-B/U: t_port[15 + post_id * 6] */
+	/* table[4]: LUT0-R/V: t_port[16 + post_id * 6] */
+	/* table[5]: LUT1-R/V: t_port[17 + post_id * 6] */
+	for (i = 0; i < 6U; i++) {
+		if (gamma_table->table[i] != 0U) {
+			int idx = 12U + i + post_id * 6U;
+
+			writel((u32)gamma_table->table[i],
+			       &res->capture_reg->vdm.t_port[idx].VDM_T_STADR);
+			writel(HWD_VIIF_L2_VDM_GAMMA_TABLE_SIZE,
+			       &res->capture_reg->vdm.t_port[idx].VDM_T_SIZE);
+			vdm_enable |= BIT(i);
+		}
+	}
+	if (vdm_enable != 0U) {
+		/* t_group[2..3] is used only to transfer GAMMA table */
+		/* [2]: POST0, [3]: POST1 */
+		writel(HWD_VIIF_VDM_CFG_PARAM,
+		       &res->capture_reg->vdm.t_group[(post_id + 2U)].VDM_T_CFG);
+		base_addr = HWD_VIIF_L2_VDM_GAMMA_SRAM_BASE +
+			    (HWD_VIIF_L2_VDM_GAMMA_SRAM_SIZE * post_id);
+		writel(base_addr, &res->capture_reg->vdm.t_group[(post_id + 2U)].VDM_T_SRAM_BASE);
+		writel(HWD_VIIF_L2_VDM_GAMMA_SRAM_SIZE,
+		       &res->capture_reg->vdm.t_group[(post_id + 2U)].VDM_T_SRAM_SIZE);
+		vdm_enable = vdm_enable << (12U + (post_id * 6U));
+	}
+	vdm_enable |= (readl(&res->capture_reg->vdm.VDM_T_ENABLE) &
+		       ~((u32)0x3fU << (12U + (post_id * 6U))));
+	writel(vdm_enable, &res->capture_reg->vdm.VDM_T_ENABLE);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l2_set_output_csc() - Set output CSC parameters of L2ISP
+ *
+ * @post_id: POST ID [0..1]
+ * @param: Pointer to output csc parameters of L2ISP
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "post_id" is out of range
+ * - [2] Member of "param" is invalid
+ */
+s32 hwd_viif_l2_set_output_csc(u32 module_id, u32 post_id, const struct hwd_viif_csc_param *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	struct hwd_viif_l2isp_post_reg *reg_l2isp_post;
+	u32 i, val;
+
+	if (post_id >= HWD_VIIF_MAX_POST_NUM)
+		return -EINVAL;
+
+	/* disable csc matrix when param is NULL */
+	if (!param) {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l2isp.post[post_id].csc.MTB);
+		return 0;
+	}
+
+	/* param is specified: go further check */
+	if (param->r_cr_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+	    param->g_y_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+	    param->b_cb_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+	    param->r_cr_out_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+	    param->g_y_out_offset > HWD_VIIF_CSC_MAX_OFFSET ||
+	    param->b_cb_out_offset > HWD_VIIF_CSC_MAX_OFFSET) {
+		return -EINVAL;
+	}
+
+	for (i = 0; i < HWD_VIIF_CSC_MAX_COEF_NUM; i++) {
+		if (param->coef[i] > HWD_VIIF_CSC_MAX_COEF_VALUE)
+			return -EINVAL;
+	}
+
+	reg_l2isp_post = &res->capture_reg->l2isp.post[post_id];
+
+	writel(param->g_y_in_offset, &reg_l2isp_post->csc.MTB_YG_OFFSETI);
+	writel(param->coef[0], &reg_l2isp_post->csc.MTB_YG1);
+	val = (param->coef[1] << HWD_VIIF_MTB_CB_YG_COEF_OFFSET) |
+	      (param->coef[2] << HWD_VIIF_MTB_CR_YG_COEF_OFFSET);
+	writel(val, &reg_l2isp_post->csc.MTB_YG2);
+	writel(param->g_y_out_offset, &reg_l2isp_post->csc.MTB_YG_OFFSETO);
+	writel(param->b_cb_in_offset, &reg_l2isp_post->csc.MTB_CB_OFFSETI);
+	writel(param->coef[3], &reg_l2isp_post->csc.MTB_CB1);
+	val = (param->coef[4] << HWD_VIIF_MTB_CB_CB_COEF_OFFSET) |
+	      (param->coef[5] << HWD_VIIF_MTB_CR_CB_COEF_OFFSET);
+	writel(val, &reg_l2isp_post->csc.MTB_CB2);
+	writel(param->b_cb_out_offset, &reg_l2isp_post->csc.MTB_CB_OFFSETO);
+	writel(param->r_cr_in_offset, &reg_l2isp_post->csc.MTB_CR_OFFSETI);
+	writel(param->coef[6], &reg_l2isp_post->csc.MTB_CR1);
+	val = (param->coef[7] << HWD_VIIF_MTB_CB_CR_COEF_OFFSET) |
+	      (param->coef[8] << HWD_VIIF_MTB_CR_CR_COEF_OFFSET);
+	writel(val, &reg_l2isp_post->csc.MTB_CR2);
+	writel(param->r_cr_out_offset, &reg_l2isp_post->csc.MTB_CR_OFFSETO);
+	writel(HWD_VIIF_ENABLE, &reg_l2isp_post->csc.MTB);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l2_set_img_transmission() - Set image transfer condition of L2ISP
+ *
+ * @post_id: POST ID [0..1]
+ * @enable: or disable image transfer of MAIN unit. For more refer @ref hwd_viif_enable_flag.
+ * @src: Pointer to crop area information
+ * @out_process: Pointer to output process information
+ * @img: Pointer to output image information
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "post_id" or "enable" is out of range
+ * - [2] "src" or "out_process" is NULL when "enable" is HWD_VIIF_ENABLE
+ * - [3] "src" or "out_process" is not NULL when "enable" is HWD_VIIF_DISABLE
+ * - [4] Member of "src" is out of range
+ * - [5] "w" of "src" is not equal to 2 * "width" of "image"
+ *   when "half_scal" of "out_process" is HWD_VIIF_ENABLE
+ * - [6] "h" of "src" is not equal to 2 * "height" of "image"
+ *   when "half_scal" of "out_process" is HWD_VIIF_ENABLE
+ * - [7] "w" of "src" is not equal to "width" of "image"
+ *   when "half_scal" of "out_process" is HWD_VIIF_DISABLE
+ * - [8] "h" of "src" is not equal to "height" of "image"
+ *   when "half_scal" of "out_process" is HWD_VIIF_DISABLE
+ * - [9] Member of "out_process" is invalid
+ * - [10] "alpha" of "out_process" is not 0 when "format" of "img" is not HWD_VIIF_ARGB8888_PACKED
+ * - [11] "format" of "img" is not HWD_VIIF_ONE_COLOR_8 or HWD_VIIF_ONE_COLOR_16
+ *   when "select_color" of "out_process"
+ *   is HWD_VIIF_COLOR_Y_G, HWD_VIIF_COLOR_U_B or HWD_VIIF_COLOR_V_R
+ * - [12] Member of "img" is invalid
+ *
+ * see also: #hwd_viif_l2_set_roi_path
+ */
+s32 hwd_viif_l2_set_img_transmission(u32 module_id, u32 post_id, u32 enable,
+				     const struct hwd_viif_img_area *src,
+				     const struct hwd_viif_out_process *out_process,
+				     const struct hwd_viif_img *img)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 pitch[HWD_VIIF_MAX_PLANE_NUM], img_start_addr[HWD_VIIF_MAX_PLANE_NUM];
+	u32 i, val, loop, k, r[HWD_VIIF_MAX_PLANE_NUM];
+	s32 ret = 0;
+
+	/* pitch alignment for planar or one color format */
+	u32 pitch_align = 128U;
+
+	if (post_id >= HWD_VIIF_MAX_POST_NUM ||
+	    (enable != HWD_VIIF_ENABLE && enable != HWD_VIIF_DISABLE) ||
+	    (enable == HWD_VIIF_ENABLE && (!src || !out_process)) ||
+	    (enable == HWD_VIIF_DISABLE && (src || out_process))) {
+		return -EINVAL;
+	}
+
+	/* DISABLE: no DMA transmission setup, set minimum crop rectangle */
+	if (enable == HWD_VIIF_DISABLE) {
+		res->l2_roi_path_info.post_enable_flag[post_id] = false;
+		res->l2_roi_path_info.post_crop_x[post_id] = 0U;
+		res->l2_roi_path_info.post_crop_y[post_id] = 0U;
+		res->l2_roi_path_info.post_crop_w[post_id] = HWD_VIIF_CROP_MIN_W;
+		res->l2_roi_path_info.post_crop_h[post_id] = HWD_VIIF_CROP_MIN_H;
+		hwd_viif_l2_set_roi_path(res);
+
+		return 0;
+	}
+
+	/* further parameter check for ENABLE */
+	if (out_process->half_scale != HWD_VIIF_ENABLE &&
+	    out_process->half_scale != HWD_VIIF_DISABLE) {
+		return -EINVAL;
+	}
+
+	if (out_process->select_color != HWD_VIIF_COLOR_Y_G &&
+	    out_process->select_color != HWD_VIIF_COLOR_U_B &&
+	    out_process->select_color != HWD_VIIF_COLOR_V_R &&
+	    out_process->select_color != HWD_VIIF_COLOR_YUV_RGB) {
+		return -EINVAL;
+	}
+
+	if (img->format != HWD_VIIF_ARGB8888_PACKED && out_process->alpha != 0U)
+		return -EINVAL;
+
+	if (((img->width % 2U) != 0U) || ((img->height % 2U) != 0U) ||
+	    img->width < HWD_VIIF_MIN_OUTPUT_IMG_WIDTH ||
+	    img->height < HWD_VIIF_MIN_OUTPUT_IMG_HEIGHT ||
+	    img->width > HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_ISP ||
+	    img->height > HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP) {
+		return -EINVAL;
+	}
+
+	if (src->x > HWD_VIIF_CROP_MAX_X_ISP || src->y > HWD_VIIF_CROP_MAX_Y_ISP ||
+	    src->w < HWD_VIIF_CROP_MIN_W || src->w > HWD_VIIF_CROP_MAX_W_ISP ||
+	    src->h < HWD_VIIF_CROP_MIN_H || src->h > HWD_VIIF_CROP_MAX_H_ISP) {
+		return -EINVAL;
+	}
+
+	if (out_process->half_scale == HWD_VIIF_ENABLE) {
+		if ((src->w != (img->width * 2U)) || (src->h != (img->height * 2U)))
+			return -EINVAL;
+	} else {
+		if (src->w != img->width || src->h != img->height)
+			return -EINVAL;
+	}
+
+	if (out_process->select_color == HWD_VIIF_COLOR_Y_G ||
+	    out_process->select_color == HWD_VIIF_COLOR_U_B ||
+	    out_process->select_color == HWD_VIIF_COLOR_V_R) {
+		if (img->format != HWD_VIIF_ONE_COLOR_8 && img->format != HWD_VIIF_ONE_COLOR_16)
+			return -EINVAL;
+	}
+
+	/* build DMAC parameter */
+	switch (img->format) {
+	case HWD_VIIF_YCBCR422_8_PACKED:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		loop = 1U;
+		k = 2U;
+		r[0] = 1U;
+		pitch_align = 256U;
+		break;
+	case HWD_VIIF_RGB888_PACKED:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		loop = 1U;
+		k = 3U;
+		r[0] = 1U;
+		pitch_align = 384U;
+		break;
+	case HWD_VIIF_ARGB8888_PACKED:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		loop = 1U;
+		k = 4U;
+		r[0] = 1U;
+		pitch_align = 512U;
+		break;
+	case HWD_VIIF_ONE_COLOR_8:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		loop = 1U;
+		k = 1U;
+		r[0] = 1U;
+		break;
+	case HWD_VIIF_ONE_COLOR_16:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		loop = 1U;
+		k = 2U;
+		r[0] = 1U;
+		break;
+	case HWD_VIIF_YCBCR422_8_PLANAR:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
+		img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		pitch[1] = img->pixelmap[1].pitch;
+		pitch[2] = img->pixelmap[2].pitch;
+		loop = HWD_VIIF_MAX_PLANE_NUM;
+		k = 1U;
+		r[0] = 1U;
+		r[1] = 2U;
+		r[2] = 2U;
+		break;
+	case HWD_VIIF_RGB888_YCBCR444_8_PLANAR:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
+		img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		pitch[1] = img->pixelmap[1].pitch;
+		pitch[2] = img->pixelmap[2].pitch;
+		loop = HWD_VIIF_MAX_PLANE_NUM;
+		k = 1U;
+		r[0] = 1U;
+		r[1] = 1U;
+		r[2] = 1U;
+		break;
+	case HWD_VIIF_YCBCR422_16_PLANAR:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
+		img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		pitch[1] = img->pixelmap[1].pitch;
+		pitch[2] = img->pixelmap[2].pitch;
+		loop = HWD_VIIF_MAX_PLANE_NUM;
+		k = 2U;
+		r[0] = 1U;
+		r[1] = 2U;
+		r[2] = 2U;
+		break;
+	case HWD_VIIF_RGB161616_YCBCR444_16_PLANAR:
+		img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
+		img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
+		img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
+		pitch[0] = img->pixelmap[0].pitch;
+		pitch[1] = img->pixelmap[1].pitch;
+		pitch[2] = img->pixelmap[2].pitch;
+		loop = HWD_VIIF_MAX_PLANE_NUM;
+		k = 2U;
+		r[0] = 1U;
+		r[1] = 1U;
+		r[2] = 1U;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < loop; i++) {
+		val = max(((img->width * k) / r[i]), 128U);
+		if (pitch[i] < val || pitch[i] > HWD_VIIF_MAX_PITCH_ISP ||
+		    ((pitch[i] % pitch_align) != 0U) || ((img_start_addr[i] % 4U) != 0U)) {
+			return -EINVAL;
+		}
+	}
+
+	writel(img_start_addr[0], &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_STADR_G);
+	writel(pitch[0], &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_PITCH_G);
+	if (loop == HWD_VIIF_MAX_PLANE_NUM) {
+		writel(img_start_addr[1],
+		       &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_STADR_B);
+		writel(img_start_addr[2],
+		       &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_STADR_R);
+		writel(pitch[1], &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_PITCH_B);
+		writel(pitch[2], &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_PITCH_R);
+	}
+
+	/* Set CROP */
+	val = (src->y << 16U) | src->x;
+	writel(val, &res->capture_reg->l2isp.post[post_id].L2_POST_CAP_OFFSET);
+	val = (src->h << 16U) | src->w;
+	writel(val, &res->capture_reg->l2isp.post[post_id].L2_POST_CAP_SIZE);
+
+	/* Set output process */
+	writel(out_process->half_scale,
+	       &res->capture_reg->l2isp.post[post_id].L2_POST_HALF_SCALE_EN);
+	writel(out_process->select_color, &res->capture_reg->l2isp.post[post_id].L2_POST_C_SELECT);
+	writel((u32)out_process->alpha, &res->capture_reg->l2isp.post[post_id].L2_POST_OPORTALP);
+	writel(img->format, &res->capture_reg->l2isp.post[post_id].L2_POST_OPORTFMT);
+
+	/* Update ROI area and input to each POST */
+	res->l2_roi_path_info.post_enable_flag[post_id] = true;
+	res->l2_roi_path_info.post_crop_x[post_id] = src->x;
+	res->l2_roi_path_info.post_crop_y[post_id] = src->y;
+	res->l2_roi_path_info.post_crop_w[post_id] = src->w;
+	res->l2_roi_path_info.post_crop_h[post_id] = src->h;
+	hwd_viif_l2_set_roi_path(res);
+
+	return ret;
+}
+
+/**
+ * hwd_viif_l2_set_irq_mask() - Set mask condition for L2ISP
+ *
+ * @mask: L2ISP mask condition
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_viif_l2_set_irq_mask(u32 module_id, u32 mask)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	writel(mask, &res->capture_reg->l2isp.L2_CRGBF_ISP_INT_MASK);
+}
+
+/**
+ * hwd_viif_csi2rx_err_irq_handler() - CSI-2 RX error interruption handler
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: event information of CSI-2 RX error interruption
+ */
+u32 hwd_viif_csi2rx_err_irq_handler(u32 module_id)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	return readl(&res->csi2host_reg->CSI2RX_INT_ST_MAIN);
+}
+
+/**
+ * hwd_viif_status_err_irq_handler() - STATUS error interruption handler
+ *
+ * @event_main: information of STATUS error interruption of MAIN unit
+ * @event_sub: information of STATUS error interruption of SUB unit(CH0 and CH1)
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_viif_status_err_irq_handler(u32 module_id, u32 *event_main, u32 *event_sub)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val, mask;
+
+	*event_main = HWD_VIIF_NO_EVENT;
+	*event_sub = HWD_VIIF_NO_EVENT;
+
+	val = readl(&res->capture_reg->sys.INT_M_STATUS);
+	mask = readl(&res->capture_reg->sys.INT_M_MASK);
+	val = val & ~mask;
+	if (val != HWD_VIIF_NO_EVENT) {
+		writel(val, &res->capture_reg->sys.INT_M_STATUS);
+		*event_main = val;
+	}
+
+	val = readl(&res->capture_reg->sys.INT_S_STATUS);
+	mask = readl(&res->capture_reg->sys.INT_S_MASK);
+	val = val & ~mask;
+	if (val != HWD_VIIF_NO_EVENT) {
+		writel(val, &res->capture_reg->sys.INT_S_STATUS);
+		*event_sub = val;
+	}
+}
+
+/**
+ * hwd_viif_vsync_irq_handler() - Vsync interruption handler
+ *
+ * @event_main: information of Vsync interruption of MAIN unit
+ * @event_sub: information of Vsync interruption of SUB unit(CH0 and CH1)
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_viif_vsync_irq_handler(u32 module_id, u32 *event_main, u32 *event_sub)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val, mask;
+
+	*event_main = HWD_VIIF_NO_EVENT;
+	*event_sub = HWD_VIIF_NO_EVENT;
+
+	val = readl(&res->capture_reg->sys.INT_M_SYNC);
+	mask = readl(&res->capture_reg->sys.INT_M_SYNC_MASK);
+	val = val & ~mask;
+	if (val != HWD_VIIF_NO_EVENT) {
+		writel(val, &res->capture_reg->sys.INT_M_SYNC);
+		*event_main = val;
+	}
+
+	val = readl(&res->capture_reg->sys.INT_S_SYNC);
+	mask = readl(&res->capture_reg->sys.INT_S_SYNC_MASK);
+	val = val & ~mask;
+	if (val != HWD_VIIF_NO_EVENT) {
+		writel(val, &res->capture_reg->sys.INT_S_SYNC);
+		*event_sub = val;
+	}
+}
+
+/**
+ * hwd_viif_isp_regbuf_irq_handler() - ISP register buffer interruption handler
+ *
+ * @event_l1: information of register buffer interruption of L1ISP
+ * @event_l2: information of register buffer interruption of L2ISP
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_viif_isp_regbuf_irq_handler(u32 module_id, u32 *event_l1, u32 *event_l2)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val;
+
+	*event_l1 = HWD_VIIF_NO_EVENT;
+	*event_l2 = HWD_VIIF_NO_EVENT;
+
+	val = readl(&res->capture_reg->l1isp.L1_CRGBF_INT_MASKED_STAT);
+	if (val != HWD_VIIF_NO_EVENT) {
+		*event_l1 = val;
+		writel(val, &res->capture_reg->l1isp.L1_CRGBF_INT_STAT);
+	}
+
+	val = readl(&res->capture_reg->l2isp.L2_CRGBF_INT_MASKED_STAT);
+	if (val != HWD_VIIF_NO_EVENT) {
+		*event_l2 = val;
+		writel(val, &res->capture_reg->l2isp.L2_CRGBF_INT_STAT);
+	}
+}
diff --git a/drivers/media/platform/visconti/hwd_viif.h b/drivers/media/platform/visconti/hwd_viif.h
new file mode 100644
index 000000000..d613a0a43
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif.h
@@ -0,0 +1,701 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef HWD_VIIF_H
+#define HWD_VIIF_H
+
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include <linux/visconti_viif.h>
+
+/* MIPI CSI2 Data Types */
+#define VISCONTI_CSI2_DT_YUV4228B  0x1E
+#define VISCONTI_CSI2_DT_YUV42210B 0x1F
+#define VISCONTI_CSI2_DT_RGB565	   0x22
+#define VISCONTI_CSI2_DT_RGB888	   0x24
+#define VISCONTI_CSI2_DT_RAW8	   0x2A
+#define VISCONTI_CSI2_DT_RAW10	   0x2B
+#define VISCONTI_CSI2_DT_RAW12	   0x2C
+#define VISCONTI_CSI2_DT_RAW14	   0x2D
+
+/* hwd_viif_enable_flag */
+#define HWD_VIIF_DISABLE (0U)
+#define HWD_VIIF_ENABLE	 (1U)
+
+/* hwd_viif_memory_sync_type */
+#define HWD_VIIF_MEM_SYNC_INTERNAL (0U)
+#define HWD_VIIF_MEM_SYNC_CSI2	   (1U)
+
+/* hwd_viif_color_format */
+#define HWD_VIIF_YCBCR422_8_PACKED	      (0U)
+#define HWD_VIIF_RGB888_PACKED		      (1U)
+#define HWD_VIIF_ARGB8888_PACKED	      (3U)
+#define HWD_VIIF_YCBCR422_8_PLANAR	      (8U)
+#define HWD_VIIF_RGB888_YCBCR444_8_PLANAR     (9U)
+#define HWD_VIIF_ONE_COLOR_8		      (11U)
+#define HWD_VIIF_YCBCR422_16_PLANAR	      (12U)
+#define HWD_VIIF_RGB161616_YCBCR444_16_PLANAR (13U)
+#define HWD_VIIF_ONE_COLOR_16		      (15U)
+
+/* hwd_viif_raw_pack_mode */
+#define HWD_VIIF_RAWPACK_DISABLE  (0U)
+#define HWD_VIIF_RAWPACK_MSBFIRST (2U)
+#define HWD_VIIF_RAWPACK_LSBFIRST (3U)
+
+/* hwd_viif_yuv_conversion_mode */
+#define HWD_VIIF_YUV_CONV_REPEAT	(0U)
+#define HWD_VIIF_YUV_CONV_INTERPOLATION (1U)
+
+/* hwd_viif_gamma_table_mode */
+#define HWD_VIIF_GAMMA_COMPRESSED (0U)
+#define HWD_VIIF_GAMMA_LINEAR	  (1U)
+
+/* hwd_viif_output_color_mode */
+#define HWD_VIIF_COLOR_Y_G     (0U)
+#define HWD_VIIF_COLOR_U_B     (1U)
+#define HWD_VIIF_COLOR_V_R     (2U)
+#define HWD_VIIF_COLOR_YUV_RGB (4U)
+
+/* hwd_viif_hw_params */
+#define HWD_VIIF_MAX_CH	       (6U)
+#define HWD_VIIF_MAX_PLANE_NUM (3U)
+
+/**
+ * enum hwd_viif_csi2_dphy - D-PHY Lane assignment
+ *
+ * specifies which line(L0-L3) is assigned to D0-D3
+ */
+enum hwd_viif_csi2_dphy {
+	HWD_VIIF_CSI2_DPHY_L0L1L2L3 = 0U,
+	HWD_VIIF_CSI2_DPHY_L0L3L1L2 = 1U,
+	HWD_VIIF_CSI2_DPHY_L0L2L3L1 = 2U,
+	HWD_VIIF_CSI2_DPHY_L0L1L3L2 = 4U,
+	HWD_VIIF_CSI2_DPHY_L0L3L2L1 = 5U,
+	HWD_VIIF_CSI2_DPHY_L0L2L1L3 = 6U
+};
+
+/* hwd_viif_csi2rx_input_mode */
+#define HWD_VIIF_CSI2_INPUT_OWN	  (0U)
+#define HWD_VIIF_CSI2_INPUT_OTHER (1U)
+
+/* hwd_viif_csi2rx_cal_status */
+#define HWD_VIIF_CSI2_CAL_NOT_DONE (0U)
+#define HWD_VIIF_CSI2_CAL_SUCCESS  (1U)
+#define HWD_VIIF_CSI2_CAL_FAIL	   (2U)
+
+/* hwd_viif_csi2rx_not_capture */
+#define HWD_VIIF_CSI2_NOT_CAPTURE (-1) /**< csi2 not capture */
+
+/* hwd_viif_l1_input_mode */
+#define HWD_VIIF_L1_INPUT_HDR		  (0U)
+#define HWD_VIIF_L1_INPUT_PWL		  (1U)
+#define HWD_VIIF_L1_INPUT_SDR		  (2U)
+#define HWD_VIIF_L1_INPUT_HDR_IMG_CORRECT (3U)
+#define HWD_VIIF_L1_INPUT_PWL_IMG_CORRECT (4U)
+
+/* hwd_viif_l1_raw_color_filter_mode */
+#define HWD_VIIF_L1_RAW_GR_R_B_GB (0U)
+#define HWD_VIIF_L1_RAW_R_GR_GB_B (1U)
+#define HWD_VIIF_L1_RAW_B_GB_GR_R (2U)
+#define HWD_VIIF_L1_RAW_GB_B_R_GR (3U)
+
+/* hwd_viif_l1_input_interpolation_mode */
+#define HWD_VIIF_L1_INPUT_INTERPOLATION_LINE  (0U)
+#define HWD_VIIF_L1_INPUT_INTERPOLATION_PIXEL (1U)
+
+/* hwd_viif_l1_img_sens */
+#define HWD_VIIF_L1_IMG_SENSITIVITY_HIGH       (0U)
+#define HWD_VIIF_L1_IMG_SENSITIVITY_MIDDLE_LED (1U)
+#define HWD_VIIF_L1_IMG_SENSITIVITY_LOW	       (2U)
+
+/* hwd_viif_l1_dpc */
+#define HWD_VIIF_L1_DPC_1PIXEL (0U)
+#define HWD_VIIF_L1_DPC_2PIXEL (1U)
+
+/* hwd_viif_l1_rcnr_hry_type */
+#define HWD_VIIF_L1_RCNR_LOW_RESOLUTION	       (0U)
+#define HWD_VIIF_L1_RCNR_MIDDLE_RESOLUTION     (1U)
+#define HWD_VIIF_L1_RCNR_HIGH_RESOLUTION       (2U)
+#define HWD_VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION (3U)
+
+/* hwd_viif_l1_rcnr_msf_blend_ratio */
+#define HWD_VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 (0U)
+#define HWD_VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 (1U)
+#define HWD_VIIF_L1_MSF_BLEND_RATIO_2_DIV_64 (2U)
+
+/* hwd_viif_l1_hdrs */
+#define HWD_VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE (0U)
+#define HWD_VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE	   (1U)
+
+/* hwd_viif_l1_lsc_para_mag */
+#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH (0U)
+#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH (1U)
+#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_SECOND (2U)
+#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FIRST  (3U)
+
+/* hwd_viif_l1_lsc_grid_mag */
+#define HWD_VIIF_L1_GRID_COEF_GAIN_X1 (0U)
+#define HWD_VIIF_L1_GRID_COEF_GAIN_X2 (1U)
+
+/* hwd_viif_l1_demosaic */
+#define HWD_VIIF_L1_DEMOSAIC_ACPI (0U)
+#define HWD_VIIF_L1_DEMOSAIC_DMG  (1U)
+
+/* hwd_viif_l1_awb_restart_cond */
+/* macros for L1ISP condition to restart auto white balance */
+#define HWD_VIIF_L1_AWB_RESTART_NO	 (0U)
+#define HWD_VIIF_L1_AWB_RESTART_128FRAME (1U)
+#define HWD_VIIF_L1_AWB_RESTART_64FRAME	 (2U)
+#define HWD_VIIF_L1_AWB_RESTART_32FRAME	 (3U)
+#define HWD_VIIF_L1_AWB_RESTART_16FRAME	 (4U)
+#define HWD_VIIF_L1_AWB_RESTART_8FRAME	 (5U)
+#define HWD_VIIF_L1_AWB_RESTART_4FRAME	 (6U)
+#define HWD_VIIF_L1_AWB_RESTART_2FRAME	 (7U)
+
+/* hwd_viif_l1_awb_mag */
+#define HWD_VIIF_L1_AWB_ONE_SECOND (0U)
+#define HWD_VIIF_L1_AWB_X1	   (1U)
+#define HWD_VIIF_L1_AWB_X2	   (2U)
+#define HWD_VIIF_L1_AWB_X4	   (3U)
+
+/* hwd_viif_l1_awb_area_mode */
+#define HWD_VIIF_L1_AWB_AREA_MODE0 (0U)
+#define HWD_VIIF_L1_AWB_AREA_MODE1 (1U)
+#define HWD_VIIF_L1_AWB_AREA_MODE2 (2U)
+#define HWD_VIIF_L1_AWB_AREA_MODE3 (3U)
+
+/* hwd_viif_l1_hdrc_tone_type */
+#define HWD_VIIF_L1_HDRC_TONE_USER   (0U)
+#define HWD_VIIF_L1_HDRC_TONE_PRESET (1U)
+
+/* hwd_viif_l1_bin_mode */
+#define HWD_VIIF_L1_HIST_BIN_MODE_LINEAR (0U)
+#define HWD_VIIF_L1_HIST_BIN_MODE_LOG	 (1U)
+
+/* hwd_viif_l2_undist_mode */
+#define HWD_VIIF_L2_UNDIST_POLY		(0U)
+#define HWD_VIIF_L2_UNDIST_GRID		(1U)
+#define HWD_VIIF_L2_UNDIST_POLY_TO_GRID (2U)
+#define HWD_VIIF_L2_UNDIST_GRID_TO_POLY (3U)
+
+/**
+ * struct hwd_viif_csi2rx_line_err_target
+ *
+ * Virtual Channel and Data Type pair for CSI2RX line error monitor
+ *
+ * When 0 is set to dt, line error detection is disabled.
+ *
+ * * VC can be 0 .. 3
+ * * DT can be 0 or 0x10 .. 0x3F
+ */
+#define VISCONTI_CSI2_ERROR_MONITORS_NUM 8
+struct hwd_viif_csi2rx_line_err_target {
+	u32 vc[VISCONTI_CSI2_ERROR_MONITORS_NUM];
+	u32 dt[VISCONTI_CSI2_ERROR_MONITORS_NUM];
+};
+
+/**
+ * struct hwd_viif_csi2rx_irq_mask
+ * @mask: mask setting for CSI2RX error interruption
+ *
+ * * mask[0]: D-PHY fatal error
+ * * mask[1]: Packet fatal error
+ * * mask[2]: Frame fatal error
+ * * mask[3]: D-PHY error
+ * * mask[4]: Packet error
+ * * mask[5]: Line error
+ */
+#define VISCONTI_CSI2RX_IRQ_MASKS_NUM	      6
+#define VISCONTI_CSI2RX_IRQ_MASK_DPHY_FATAL   0
+#define VISCONTI_CSI2RX_IRQ_MASK_PACKET_FATAL 1
+#define VISCONTI_CSI2RX_IRQ_MASK_FRAME_FATAL  2
+#define VISCONTI_CSI2RX_IRQ_MASK_DPHY_ERROR   3
+#define VISCONTI_CSI2RX_IRQ_MASK_PACKET_ERROR 4
+#define VISCONTI_CSI2RX_IRQ_MASK_LINE_ERROR   5
+struct hwd_viif_csi2rx_irq_mask {
+	u32 mask[VISCONTI_CSI2RX_IRQ_MASKS_NUM];
+};
+
+/**
+ * struct hwd_viif_csi2rx_packet - CSI2 packet information
+ * @word_count: word count included in one packet[byte] [0..16384]
+ * @packet_num: the number of packet included in one packet [0..8192]
+ *
+ * each element means as below.
+ * * [0]: embedded data of MAIN unit
+ * * [1]: long packet data of MAIN unit
+ * * [2]: embedded data of SUB unit
+ * * [3]: long packet data of SUB unit
+ *
+ * Regarding word_count of long packet data,
+ * word count of odd line needs to be set in case of DT = 0x18, 0x19, 0x1C or 0x1D.
+ */
+#define VISCONTI_CSI2RX_PACKET_TYPES_NUM      4
+#define VISCONTI_CSI2RX_PACKET_TYPE_EMB_MAIN  0
+#define VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN 1
+#define VISCONTI_CSI2RX_PACKET_TYPE_EMB_SUB   2
+#define VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB  3
+struct hwd_viif_csi2rx_packet {
+	u32 word_count[VISCONTI_CSI2RX_PACKET_TYPES_NUM];
+	u32 packet_num[VISCONTI_CSI2RX_PACKET_TYPES_NUM];
+};
+
+/**
+ * struct hwd_viif_pixelmap - pixelmap information
+ * @pmap_paddr: start address of pixel data(physical address). 4byte alignment.
+ * @pitch: pitch size of pixel map[byte]
+ *
+ * Condition of pitch in case of L2ISP output is as below.
+ * * max: 32704[byte]
+ * * min: the larger value of (active width of image * k / r) and 128[byte]
+ * * alignment: 64[byte]
+ *
+ * Condition of pitch in the other cases is as below.
+ * * max: 65536[byte]
+ * * min: active width of image * k / r[byte]
+ * * alignment: 4[byte]
+ *
+ * k is the size of 1 pixel and the value is as below.
+ * * HWD_VIIF_YCBCR422_8_PACKED: 2
+ * * HWD_VIIF_RGB888_PACKED: 3
+ * * HWD_VIIF_ARGB8888_PACKED: 4
+ * * HWD_VIIF_YCBCR422_8_PLANAR: 1
+ * * HWD_VIIF_RGB888_YCBCR444_8_PLANAR: 1
+ * * HWD_VIIF_ONE_COLOR_8: 1
+ * * HWD_VIIF_YCBCR422_16_PLANAR: 2
+ * * HWD_VIIF_RGB161616_YCBCR444_16_PLANAR: 2
+ * * HWD_VIIF_ONE_COLOR_16: 2
+ *
+ * r is the correction factor for Cb or Cr of YCbCr422 planar and the value is as below.
+ * * YCbCr422 Cb-planar: 2
+ * * YCbCr422 Cr-planar: 2
+ * * others: 1
+ *
+ */
+struct hwd_viif_pixelmap {
+	uintptr_t pmap_paddr;
+	u32 pitch;
+};
+
+/**
+ * struct hwd_viif_img - image information
+ * @width: active width of image[pixel]
+ * * [128..5760](output from L2ISP)
+ * * [128..4096](input to MAIN unit(memory input))
+ * * [128..4096](output from SUB unit)
+ * * The value should be even.
+ *
+ * @height: active height of image[line]
+ * * [128..3240](output from L2ISP)
+ * * [128..2160](input to MAIN unit(memory input))
+ * * [128..2160](output from SUB unit)
+ * * The value should be even.
+ *
+ * @format: hwd_viif_color_format "color format"
+ * * Below color formats are supported for input and output of MAIN unit
+ * * HWD_VIIF_YCBCR422_8_PACKED
+ * * HWD_VIIF_RGB888_PACKED
+ * * HWD_VIIF_ARGB8888_PACKED
+ * * HWD_VIIF_YCBCR422_8_PLANAR
+ * * HWD_VIIF_RGB888_YCBCR444_8_PLANAR
+ * * HWD_VIIF_ONE_COLOR_8
+ * * HWD_VIIF_YCBCR422_16_PLANAR
+ * * HWD_VIIF_RGB161616_YCBCR444_16_PLANAR
+ * * HWD_VIIF_ONE_COLOR_16
+ * * Below color formats are supported for output of SUB unit
+ * * HWD_VIIF_ONE_COLOR_8
+ * * HWD_VIIF_ONE_COLOR_16
+ *
+ * @pixelmap: pixelmap information
+ * * [0]: Y/G-planar, packed/Y/RAW
+ * * [1]: Cb/B-planar
+ * * [2]: Cr/R-planar
+ */
+struct hwd_viif_img {
+	u32 width;
+	u32 height;
+	u32 format;
+	struct hwd_viif_pixelmap pixelmap[3];
+};
+
+/**
+ * struct hwd_viif_input_img - input image information
+ * @pixel_clock: pixel clock [3375..600000] [kHz]. 0 needs to be set for long packet data.
+ * @htotal_size: horizontal total size
+ * * [143..65535] [pixel] for image data
+ * * [239..109225] [ns] for long packet data
+ * @hactive_size: horizontal active size [pixel]
+ * * [128..4096] without L1ISP
+ * * [640..3840] with L1ISP
+ * * The value should be even. In addition, the value should be a multiple of 8 with L1ISP
+ * * 0 needs to be set for the configuration of long packet data or SUB unit output.
+ * @vtotal_size: vertical total size [line]
+ * * [144..16383] for image data
+ * * 0 needs to be set for the configuration of long packet data.
+ * @vbp_size: vertical back porch size
+ * * [5..4095] [line] for image data
+ * * [5..4095] [the number of packet] for long packet data
+ * @vactive_size: vertical active size [line]
+ * * [128..2160] without L1ISP
+ * * [480..2160] with L1ISP
+ * * The value should be even.
+ * * 0 needs to be set for the configuration of long packet data.
+ * @interpolation_mode: input image interpolation mode for hwd_viif_l1_input_interpolation_mode
+ * * HWD_VIIF_L1_INPUT_INTERPOLATION_LINE needs to be set in the below cases.
+ * * image data(without L1ISP) or long packet data
+ * * image data or long packet data of SUB unit
+ * @input_num: the number of input images [1..3]
+ * * 1 needs to be set in the below cases.
+ * * image data(without L1ISP) or long packet data
+ * * image data or long packet data of SUB unit
+ * @hobc_width: the number of horizontal optical black pixels [0,16,32,64 or 128]
+ * * 0 needs to be set in the below cases.
+ * * in case of hobc_margin = 0
+ * * image data(without L1ISP) or long packet data
+ * * image data or long packet data of SUB unit
+ * @hobc_margin: the number of horizontal optical black margin[0..30] (even number)
+ * * 0 needs to be set in the below cases.
+ * * in case of hobc_width = 0
+ * * image data(without L1ISP) or long packet data
+ * * image data or long packet data of SUB unit
+ *
+ * Below conditions need to be satisfied.
+ * * interpolation_mode is HWD_VIIF_L1_INPUT_INTERPOLATION_LINE:
+ *   (htotal_size > (hactive_size + hobc_width + hobc_margin)) &&
+ *   (vtotal_size > (vbp_size + vactive_size * input_num))
+ * * interpolation_mode is HWD_VIIF_L1_INPUT_INTERPOLATION_PIXEL:
+ *   (htotal_size > ((hactive_size + hobc_width + hobc_margin) * input_num)) &&
+ *   (vtotal_size > (vbp_size + vactive_size))
+ * * L1ISP is used:
+ *   vbp_size >= (54720[cycle] / 500000[kHz]) * (pixel_clock / htotal_size) + 38 + ISST time
+ * * L1ISP is not used:
+ *   vbp_size >= (39360[cycle] / 500000[kHz]) * (pixel_clock / htotal_size) + 16 + ISST time
+ *
+ * Note: L1ISP is used when RAW data is input to MAIN unit
+ */
+struct hwd_viif_input_img {
+	u32 pixel_clock;
+	u32 htotal_size;
+	u32 hactive_size;
+	u32 vtotal_size;
+	u32 vbp_size;
+	u32 vactive_size;
+	u32 interpolation_mode;
+	u32 input_num;
+	u32 hobc_width;
+	u32 hobc_margin;
+};
+
+/**
+ * struct hwd_viif_csc_param - color conversion information
+ * @r_cr_in_offset: input offset of R/Cr[pix value] [0x0..0x1FFFF]
+ * @g_y_in_offset: input offset of G/Y[pix value] [0x0..0x1FFFF]
+ * @b_cb_in_offset: input offset of B/Cb[pix value] [0x0..0x1FFFF]
+ * @coef: coefficient of matrix [0x0..0xFFFF]
+ * * [0] : c00(YG_YG), [1] : c01(UB_YG), [2] : c02(VR_YG),
+ * * [3] : c10(YG_UB), [4] : c11(UB_UB), [5] : c12(VR_UB),
+ * * [6] : c20(YG_VR), [7] : c21(UB_VR), [8] : c22(VR_VR)
+ * @r_cr_out_offset: output offset of R/Cr[pix value] [0x0..0x1FFFF]
+ * @g_y_out_offset: output offset of G/Y[pix value] [0x0..0x1FFFF]
+ * @b_cb_out_offset: output offset of B/Cb[pix value] [0x0..0x1FFFF]
+ */
+struct hwd_viif_csc_param {
+	u32 r_cr_in_offset;
+	u32 g_y_in_offset;
+	u32 b_cb_in_offset;
+	u32 coef[9];
+	u32 r_cr_out_offset;
+	u32 g_y_out_offset;
+	u32 b_cb_out_offset;
+};
+
+/**
+ * struct hwd_viif_img_area - image area definition
+ * @x: x position [0..8062] [pixel]
+ * @y: y position [0..3966] [line]
+ * @w: image width [128..8190] [pixel]
+ * @h: image height [128..4094] [line]
+ */
+struct hwd_viif_img_area {
+	u32 x;
+	u32 y;
+	u32 w;
+	u32 h;
+};
+
+/**
+ * struct hwd_viif_out_process - configuration of output process of MAIN unit and L2ISP
+ * @half_scale: hwd_viif_enable_flag "enable or disable half scale"
+ * @select_color: hwd_viif_output_color_mode "select output color"
+ * @alpha: alpha value used in case of ARGB8888 output [0..255]
+ */
+struct hwd_viif_out_process {
+	u32 half_scale;
+	u32 select_color;
+	u8 alpha;
+};
+
+/**
+ * struct hwd_viif_l1_lsc - HWD L1ISP lens shading correction parameters
+ * @lssc_parabola_param: parabola shading correction parameter
+ * * NULL: disable parabola shading correction
+ * * not NULL: enable parabola shading correction
+ * @lssc_grid_param: grid shading correction parameter
+ * * NULL: disable grid shading correction
+ * * not NULL: enable grid shading correction
+ * @lssc_pwhb_r_gain_max: maximum R gain of preset white balance correction
+ * @lssc_pwhb_r_gain_min: minimum R gain of preset white balance correction
+ * @lssc_pwhb_gr_gain_max: maximum Gr gain of preset white balance correction
+ * @lssc_pwhb_gr_gain_min: minimum Gr gain of preset white balance correction
+ * @lssc_pwhb_gb_gain_max: maximum Gb gain of preset white balance correction
+ * @lssc_pwhb_gb_gain_min: minimum Gb gain of preset white balance correction
+ * @lssc_pwhb_b_gain_max: maximum B gain of preset white balance correction
+ * @lssc_pwhb_b_gain_min: minimum B gain of preset white balance correction
+ *
+ * Range and accuracy of lssc_pwhb_xxx_gain_xxx are as below.
+ * - range: [0x0..0x7FF]
+ * - accuracy : 1/256
+ */
+struct hwd_viif_l1_lsc {
+	struct viif_l1_lsc_parabola_param *lssc_parabola_param;
+	struct viif_l1_lsc_grid_param *lssc_grid_param;
+	u32 lssc_pwhb_r_gain_max;
+	u32 lssc_pwhb_r_gain_min;
+	u32 lssc_pwhb_gr_gain_max;
+	u32 lssc_pwhb_gr_gain_min;
+	u32 lssc_pwhb_gb_gain_max;
+	u32 lssc_pwhb_gb_gain_min;
+	u32 lssc_pwhb_b_gain_max;
+	u32 lssc_pwhb_b_gain_min;
+};
+
+/**
+ * struct hwd_viif_l1_img_quality_adjustment - HWD L1ISP image quality adjustment parameters
+ * @coef_cb: Cb coefficient [0x0..0xffff] accuracy: 1/65536
+ * @coef_cr: Cr coefficient [0x0..0xffff] accuracy: 1/65536
+ * @brightness: brightness value [-32768..32767] (0 means off.)
+ * @linear_contrast: linear contrast value [0x0..0xff] accuracy: 1/128 (128 means off.)
+ * @*nonlinear_contrast: pointer to nonlinear contrast parameter
+ * @*lum_noise_reduction: pointer to luminance noise reduction parameter
+ * @*edge_enhancement: pointer to edge enhancement parameter
+ * @*uv_suppression: pointer to UV suppression parameter
+ * @*coring_suppression: pointer to coring suppression parameter
+ * @*edge_suppression: pointer to edge enhancement parameter
+ * @*color_level: pointer to color level adjustment parameter
+ * @color_noise_reduction_enable: enable/disable color noise reduction @ref hwd_viif_enable_flag
+ */
+struct hwd_viif_l1_img_quality_adjustment {
+	u16 coef_cb;
+	u16 coef_cr;
+	s16 brightness;
+	u8 linear_contrast;
+	struct viif_l1_nonlinear_contrast *nonlinear_contrast;
+	struct viif_l1_lum_noise_reduction *lum_noise_reduction;
+	struct viif_l1_edge_enhancement *edge_enhancement;
+	struct viif_l1_uv_suppression *uv_suppression;
+	struct viif_l1_coring_suppression *coring_suppression;
+	struct viif_l1_edge_suppression *edge_suppression;
+	struct viif_l1_color_level *color_level;
+	u32 color_noise_reduction_enable;
+};
+
+/**
+ * struct hwd_viif_l1_info - HWD L1ISP processing information
+ * @context_id: context id
+ * @ag_cont_hobc_high: analog gain for high sensitivity image of OBCC
+ * @ag_cont_hobc_middle_led: analog gain for middle sensitivity or led image of OBCC
+ * @ag_cont_hobc_low: analog gain for low sensitivity image of OBCC
+ * @ag_cont_abpc_high: analog gain for high sensitivity image of ABPC
+ * @ag_cont_abpc_middle_led: analog gain for middle sensitivity or led image of ABPC
+ * @ag_cont_abpc_low: analog gain for low sensitivity image of ABPC
+ * @ag_cont_rcnr_high: analog gain for high sensitivity image of RCNR
+ * @ag_cont_rcnr_middle_led: analog gain for middle sensitivity or led image of RCNR
+ * @ag_cont_rcnr_low: analog gain for low sensitivity image of RCNR
+ * @ag_cont_lssc: analog gain for LSSC
+ * @ag_cont_mpro: analog gain for color matrix correction
+ * @ag_cont_vpro: analog gain for image quality adjustment
+ * @dpc_defect_num_h:
+ *     the number of dynamically corrected defective pixel(high sensitivity image)
+ * @dpc_defect_num_m:
+ *     the number of dynamically corrected defective pixel(middle sensitivity or led image)
+ * @dpc_defect_num_l:
+ *     the number of dynamically corrected defective pixel(low sensitivity image)
+ * @hdrc_tnp_fb_smth_max: the maximum value of luminance information after smoothing filter at HDRC
+ * @avg_lum_weight: weighted average luminance value at average luminance generation
+ * @avg_lum_block[8][8]:
+ *     average luminance of each block [y][x]:
+ *     y means vertical position and x means horizontal position.
+ * @avg_lum_four_line_lum[4]:
+ *     4-lines average luminance. avg_lum_four_line_lum[n] corresponds to aexp_ave4linesy[n]
+ * @avg_satur_pixnum: the number of saturated pixel at average luminance generation
+ * @avg_black_pixnum: the number of black pixel at average luminance generation
+ * @awb_ave_u: average U at AWHB [pixel]
+ * @awb_ave_v: average V at AWHB [pixel]
+ * @awb_accumulated_pixel: the number of accumulated pixel at AWHB
+ * @awb_gain_r: R gain applied in the next frame at AWHB
+ * @awb_gain_g: G gain applied in the next frame at AWHB
+ * @awb_gain_b: B gain applied in the next frame at AWHB
+ * @awb_status_u: status of U convergence at AWHB (true: converged, false: not converged)
+ * @awb_status_v: status of V convergence at AWHB (true: converged, false: not converged)
+ */
+struct hwd_viif_l1_info {
+	u32 context_id;
+	u8 ag_cont_hobc_high;
+	u8 ag_cont_hobc_middle_led;
+	u8 ag_cont_hobc_low;
+	u8 ag_cont_abpc_high;
+	u8 ag_cont_abpc_middle_led;
+	u8 ag_cont_abpc_low;
+	u8 ag_cont_rcnr_high;
+	u8 ag_cont_rcnr_middle_led;
+	u8 ag_cont_rcnr_low;
+	u8 ag_cont_lssc;
+	u8 ag_cont_mpro;
+	u8 ag_cont_vpro;
+	u32 dpc_defect_num_h;
+	u32 dpc_defect_num_m;
+	u32 dpc_defect_num_l;
+	u32 hdrc_tnp_fb_smth_max;
+	u32 avg_lum_weight;
+	u32 avg_lum_block[8][8];
+	u32 avg_lum_four_line_lum[4];
+	u16 avg_satur_pixnum;
+	u16 avg_black_pixnum;
+	u32 awb_ave_u;
+	u32 awb_ave_v;
+	u32 awb_accumulated_pixel;
+	u32 awb_gain_r;
+	u32 awb_gain_g;
+	u32 awb_gain_b;
+	bool awb_status_u;
+	bool awb_status_v;
+};
+
+/**
+ * struct hwd_viif_l2_gamma_table - HWD L2ISP Gamma table physical address
+ * @table[6]: table address(physical address) 4byte alignment
+ *
+ * relation between element and table is as below.
+ * * [0]: G/Y(1st table)
+ * * [1]: G/Y(2nd table)
+ * * [2]: B/U(1st table)
+ * * [3]: B/U(2nd table)
+ * * [4]: R/V(1st table)
+ * * [5]: R/V(2nd table)
+ *
+ * when 0 is set to table address, table transfer is disabled.
+ */
+struct hwd_viif_l2_gamma_table {
+	uintptr_t table[6];
+};
+
+/* VIIF common */
+s32 hwd_viif_initialize(u32 module_id, void *csi2host_vaddr, void *capture_vaddr);
+s32 hwd_viif_uninitialize(u32 module_id);
+u32 hwd_viif_csi2rx_err_irq_handler(u32 module_id);
+void hwd_viif_status_err_irq_handler(u32 module_id, u32 *event_main, u32 *event_sub);
+void hwd_viif_vsync_irq_handler(u32 module_id, u32 *event_main, u32 *event_sub);
+void hwd_viif_isp_regbuf_irq_handler(u32 module_id, u32 *event_l1, u32 *event_l2);
+
+/* control MAIN unit */
+s32 hwd_viif_main_set_unit(u32 module_id, u32 dt_image, const struct hwd_viif_input_img *in_img,
+			   u32 color_type, u32 rawpack, u32 yuv_conv);
+s32 hwd_viif_main_mask_vlatch(u32 module_id, u32 enable);
+void hwd_viif_main_status_err_set_irq_mask(u32 module_id, u32 mask);
+void hwd_viif_main_vsync_set_irq_mask(u32 module_id, u32 mask);
+
+/* conrol SUB unit */
+s32 hwd_viif_sub_set_unit(u32 module_id, u32 dt_image, const struct hwd_viif_input_img *in_img);
+s32 hwd_viif_sub_set_img_transmission(u32 module_id, const struct hwd_viif_img *img);
+void hwd_viif_sub_status_err_set_irq_mask(u32 module_id, u32 mask);
+void hwd_viif_sub_vsync_set_irq_mask(u32 module_id, u32 mask);
+
+/* control MIPI CSI2 Receiver unit */
+s32 hwd_viif_csi2rx_initialize(u32 module_id, u32 num_lane, u32 lane_assign, u32 dphy_rate,
+			       u32 rext_calibration,
+			       const struct hwd_viif_csi2rx_line_err_target *err_target,
+			       u32 input_mode, const struct hwd_viif_csi2rx_irq_mask *mask);
+s32 hwd_viif_csi2rx_uninitialize(u32 module_id);
+s32 hwd_viif_csi2rx_start(u32 module_id, s32 vc_main, s32 vc_sub,
+			  const struct hwd_viif_csi2rx_packet *packet, u32 voif_through);
+s32 hwd_viif_csi2rx_stop(u32 module_id);
+s32 hwd_viif_csi2rx_get_calibration_status(
+	u32 module_id, struct viif_csi2rx_dphy_calibration_status *calibration_status);
+s32 hwd_viif_csi2rx_get_err_status(u32 module_id, u32 *err_phy_fatal, u32 *err_pkt_fatal,
+				   u32 *err_frame_fatal, u32 *err_phy, u32 *err_pkt, u32 *err_line);
+
+/* control L1 Image Signal Processor */
+void hwd_viif_isp_set_regbuf_auto_transmission(u32 module_id);
+void hwd_viif_isp_disable_regbuf_auto_transmission(u32 module_id);
+void hwd_viif_isp_get_info(u32 module_id, struct hwd_viif_l1_info *l1_info,
+			   u32 *l2_transfer_status);
+void hwd_viif_isp_set_regbuf_irq_mask(u32 module_id, const u32 *mask_l1, const u32 *mask_l2);
+
+s32 hwd_viif_l1_set_input_mode(u32 module_id, u32 mode, u32 depth, u32 raw_color_filter);
+s32 hwd_viif_l1_set_rgb_to_y_coef(u32 module_id, u16 coef_r, u16 coef_g, u16 coef_b);
+s32 hwd_viif_l1_set_ag_mode(u32 module_id, const struct viif_l1_ag_mode_config *param);
+s32 hwd_viif_l1_set_ag(u32 module_id, u16 gain_h, u16 gain_m, u16 gain_l);
+s32 hwd_viif_l1_set_hdre(u32 module_id, const struct viif_l1_hdre_config *param);
+s32 hwd_viif_l1_set_img_extraction(u32 module_id, u32 input_black_gr, u32 input_black_r,
+				   u32 input_black_b, u32 input_black_gb);
+s32 hwd_viif_l1_set_dpc(u32 module_id, const struct viif_l1_dpc *param_h,
+			const struct viif_l1_dpc *param_m, const struct viif_l1_dpc *param_l);
+s32 hwd_viif_l1_set_dpc_table_transmission(u32 module_id, uintptr_t table_h, uintptr_t table_m,
+					   uintptr_t table_l);
+s32 hwd_viif_l1_set_preset_white_balance(u32 module_id, u32 dstmaxval,
+					 const struct viif_l1_preset_wb *param_h,
+					 const struct viif_l1_preset_wb *param_m,
+					 const struct viif_l1_preset_wb *param_l);
+s32 hwd_viif_l1_set_raw_color_noise_reduction(
+	u32 module_id, const struct viif_l1_raw_color_noise_reduction *param_h,
+	const struct viif_l1_raw_color_noise_reduction *param_m,
+	const struct viif_l1_raw_color_noise_reduction *param_l);
+s32 hwd_viif_l1_set_hdrs(u32 module_id, const struct viif_l1_hdrs_config *param);
+s32 hwd_viif_l1_set_black_level_correction(
+	u32 module_id, const struct viif_l1_black_level_correction_config *param);
+s32 hwd_viif_l1_set_lsc(u32 module_id, const struct hwd_viif_l1_lsc *param);
+s32 hwd_viif_l1_set_lsc_table_transmission(u32 module_id, uintptr_t table_gr, uintptr_t table_r,
+					   uintptr_t table_b, uintptr_t table_gb);
+s32 hwd_viif_l1_set_main_process(u32 module_id, u32 demosaic_mode, u32 damp_lsbsel,
+				 const struct viif_l1_color_matrix_correction *color_matrix,
+				 u32 dst_maxval);
+s32 hwd_viif_l1_set_awb(u32 module_id, const struct viif_l1_awb *param, u32 awhb_wbmrg,
+			u32 awhb_wbmgg, u32 awhb_wbmbg);
+s32 hwd_viif_l1_lock_awb_gain(u32 module_id, u32 enable);
+s32 hwd_viif_l1_set_hdrc(u32 module_id, const struct viif_l1_hdrc *param, u32 hdrc_thr_sft_amt);
+s32 hwd_viif_l1_set_hdrc_ltm(u32 module_id, const struct viif_l1_hdrc_ltm_config *param);
+s32 hwd_viif_l1_set_gamma(u32 module_id, const struct viif_l1_gamma *param);
+s32 hwd_viif_l1_set_img_quality_adjustment(u32 module_id,
+					   const struct hwd_viif_l1_img_quality_adjustment *param);
+s32 hwd_viif_l1_set_avg_lum_generation(u32 module_id,
+				       const struct viif_l1_avg_lum_generation_config *param);
+void hwd_viif_l1_set_irq_mask(u32 module_id, u32 mask);
+
+/* control L2 Image Signal Processor */
+s32 hwd_viif_l2_set_input_csc(u32 module_id, const struct hwd_viif_csc_param *param,
+			      bool is_l1_rgb);
+s32 hwd_viif_l2_set_undist(u32 module_id, const struct viif_l2_undist *param);
+s32 hwd_viif_l2_set_undist_table_transmission(u32 module_id, uintptr_t write_g, uintptr_t read_b,
+					      uintptr_t read_g, uintptr_t read_r, u32 size);
+s32 hwd_viif_l2_set_roi(u32 module_id, const struct viif_l2_roi_config *param);
+s32 hwd_viif_l2_set_gamma(u32 module_id, u32 post_id, u32 enable, u32 vsplit, u32 mode);
+s32 hwd_viif_l2_set_gamma_table_transmission(u32 module_id, u32 post_id,
+					     const struct hwd_viif_l2_gamma_table *gamma_table);
+s32 hwd_viif_l2_set_output_csc(u32 module_id, u32 post_id, const struct hwd_viif_csc_param *param);
+s32 hwd_viif_l2_set_img_transmission(u32 module_id, u32 post_id, u32 enable,
+				     const struct hwd_viif_img_area *src,
+				     const struct hwd_viif_out_process *out_process,
+				     const struct hwd_viif_img *img);
+void hwd_viif_l2_set_irq_mask(u32 module_id, u32 mask);
+
+struct hwd_viif_res *viif_id2res(u32 module_id);
+
+void hwd_viif_isp_guard_start(u32 module_id);
+void hwd_viif_isp_guard_end(u32 module_id);
+
+#endif /* HWD_VIIF_H */
diff --git a/drivers/media/platform/visconti/hwd_viif_csi2rx.c b/drivers/media/platform/visconti/hwd_viif_csi2rx.c
new file mode 100644
index 000000000..9c97b916b
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif_csi2rx.c
@@ -0,0 +1,723 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/timekeeping.h>
+#include "hwd_viif.h"
+#include "hwd_viif_internal.h"
+
+#define CSI2_DT_YUV4208	  0x18
+#define CSI2_DT_YUV42010  0x19
+#define CSI2_DT_YUV4208L  0x1A
+#define CSI2_DT_YUV4208C  0x1C
+#define CSI2_DT_YUV42010C 0x1D
+#define CSI2_DT_YUV4228B  VISCONTI_CSI2_DT_YUV4228B
+#define CSI2_DT_YUV42210B VISCONTI_CSI2_DT_YUV42210B
+#define CSI2_DT_RGB444	  0x20
+#define CSI2_DT_RGB555	  0x21
+#define CSI2_DT_RGB565	  VISCONTI_CSI2_DT_RGB565
+#define CSI2_DT_RGB666	  0x23
+#define CSI2_DT_RGB888	  VISCONTI_CSI2_DT_RGB888
+#define CSI2_DT_RAW8	  VISCONTI_CSI2_DT_RAW8
+#define CSI2_DT_RAW10	  VISCONTI_CSI2_DT_RAW10
+#define CSI2_DT_RAW12	  VISCONTI_CSI2_DT_RAW12
+#define CSI2_DT_RAW14	  VISCONTI_CSI2_DT_RAW14
+
+#define ROUNDUP_BY_4(val) (((val) + 3U) & 0xfffffffcU)
+
+#define TESTCTRL0_PHY_TESTCLK_1	     0x2
+#define TESTCTRL0_PHY_TESTCLK_0	     0x0
+#define TESTCTRL1_PHY_TESTEN	     0x10000
+#define TESTCTRL1_PHY_TESTDOUT_SHIFT 8U
+
+/**
+ * hwd_viif_csi2rx_write_dphy_param() - Write CSI2RX DPHY params
+ *
+ * @test_mode: test code address
+ * @test_in: test code data
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+static void hwd_viif_csi2rx_write_dphy_param(u32 test_mode, u8 test_in, struct hwd_viif_res *res)
+{
+	/* select MSB address register */
+	writel(TESTCTRL1_PHY_TESTEN, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+
+	/* set MSB address of test_mode */
+	writel(FIELD_GET(0xF00, test_mode), &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+
+	/* select and set LSB address register */
+	writel(TESTCTRL1_PHY_TESTEN | FIELD_GET(0xFF, test_mode),
+	       &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+
+	/* set the test code data */
+	writel((u32)test_in, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+}
+
+/**
+ * hwd_viif_csi2rx_read_dphy_param() - Read CSI2RX DPHY params
+ *
+ * @test_mode: test code address
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: test code data
+ */
+static u8 hwd_viif_csi2rx_read_dphy_param(u32 test_mode, struct hwd_viif_res *res)
+{
+	u32 read_data;
+
+	/* select MSB address register */
+	writel(TESTCTRL1_PHY_TESTEN, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+
+	/* set MSB address of test_mode */
+	writel(FIELD_GET(0xF00, test_mode), &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+
+	/* select and set LSB address register */
+	writel(TESTCTRL1_PHY_TESTEN | FIELD_GET(0xFF, test_mode),
+	       &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+	writel(TESTCTRL0_PHY_TESTCLK_0, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+
+	/* read the test code data */
+	read_data = readl(&res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+	return (u8)(read_data >> TESTCTRL1_PHY_TESTDOUT_SHIFT);
+}
+
+/**
+ * enum dphy_testcode - DPHY registers via the local communication path
+ */
+enum dphy_testcode {
+	DIG_RDWR_RX_SYS_0 = 0x001,
+	DIG_RDWR_RX_SYS_1 = 0x002,
+	DIG_RDWR_RX_SYS_3 = 0x004,
+	DIG_RDWR_RX_SYS_7 = 0x008,
+	DIG_RDWR_RX_RX_STARTUP_OVR_2 = 0x0E2,
+	DIG_RDWR_RX_RX_STARTUP_OVR_3 = 0x0E3,
+	DIG_RDWR_RX_RX_STARTUP_OVR_4 = 0x0E4,
+	DIG_RDWR_RX_RX_STARTUP_OVR_5 = 0x0E5,
+	DIG_RDWR_RX_CB_2 = 0x1AC,
+	DIG_RD_RX_TERM_CAL_0 = 0x220,
+	DIG_RD_RX_TERM_CAL_1 = 0x221,
+	DIG_RD_RX_TERM_CAL_2 = 0x222,
+	DIG_RDWR_RX_CLKLANE_LANE_6 = 0x307,
+	DIG_RD_RX_CLKLANE_OFFSET_CAL_0 = 0x39D,
+	DIG_RD_RX_LANE0_OFFSET_CAL_0 = 0x59F,
+	DIG_RD_RX_LANE0_DDL_0 = 0x5E0,
+	DIG_RD_RX_LANE1_OFFSET_CAL_0 = 0x79F,
+	DIG_RD_RX_LANE1_DDL_0 = 0x7E0,
+	DIG_RD_RX_LANE2_OFFSET_CAL_0 = 0x99F,
+	DIG_RD_RX_LANE2_DDL_0 = 0x9E0,
+	DIG_RD_RX_LANE3_OFFSET_CAL_0 = 0xB9F,
+	DIG_RD_RX_LANE3_DDL_0 = 0xBE0,
+};
+
+#define SYS_0_HSFREQRANGE_OVR  BIT(5)
+#define SYS_7_RESERVED	       FIELD_PREP(0x1F, 0x0C)
+#define SYS_7_DESKEW_POL       BIT(5)
+#define STARTUP_OVR_4_CNTVAL   FIELD_PREP(0x70, 0x01)
+#define STARTUP_OVR_4_DDL_EN   BIT(0)
+#define STARTUP_OVR_5_BYPASS   BIT(0)
+#define CB_2_LPRX_BIAS	       BIT(6)
+#define CB_2_RESERVED	       FIELD_PREP(0x3F, 0x0B)
+#define CLKLANE_RXHS_PULL_LONG BIT(7)
+
+static const struct hwd_viif_dphy_hs_info dphy_hs_info[] = {
+	{ 80, 0x0, 0x1cc },   { 85, 0x10, 0x1cc },   { 95, 0x20, 0x1cc },   { 105, 0x30, 0x1cc },
+	{ 115, 0x1, 0x1cc },  { 125, 0x11, 0x1cc },  { 135, 0x21, 0x1cc },  { 145, 0x31, 0x1cc },
+	{ 155, 0x2, 0x1cc },  { 165, 0x12, 0x1cc },  { 175, 0x22, 0x1cc },  { 185, 0x32, 0x1cc },
+	{ 198, 0x3, 0x1cc },  { 213, 0x13, 0x1cc },  { 228, 0x23, 0x1cc },  { 243, 0x33, 0x1cc },
+	{ 263, 0x4, 0x1cc },  { 288, 0x14, 0x1cc },  { 313, 0x25, 0x1cc },  { 338, 0x35, 0x1cc },
+	{ 375, 0x5, 0x1cc },  { 425, 0x16, 0x1cc },  { 475, 0x26, 0x1cc },  { 525, 0x37, 0x1cc },
+	{ 575, 0x7, 0x1cc },  { 625, 0x18, 0x1cc },  { 675, 0x28, 0x1cc },  { 725, 0x39, 0x1cc },
+	{ 775, 0x9, 0x1cc },  { 825, 0x19, 0x1cc },  { 875, 0x29, 0x1cc },  { 925, 0x3a, 0x1cc },
+	{ 975, 0xa, 0x1cc },  { 1025, 0x1a, 0x1cc }, { 1075, 0x2a, 0x1cc }, { 1125, 0x3b, 0x1cc },
+	{ 1175, 0xb, 0x1cc }, { 1225, 0x1b, 0x1cc }, { 1275, 0x2b, 0x1cc }, { 1325, 0x3c, 0x1cc },
+	{ 1375, 0xc, 0x1cc }, { 1425, 0x1c, 0x1cc }, { 1475, 0x2c, 0x1cc }
+};
+
+/**
+ * hwd_viif_csi2rx_get_dphy_hs_transfer_info() - Get DPHY HS info from table
+ *
+ * @dphy_rate: DPHY clock in MHz
+ * @hsfreqrange: HS Frequency Range
+ * @osc_freq_target: OSC Frequency Target
+ * Return: None
+ */
+static void hwd_viif_csi2rx_get_dphy_hs_transfer_info(u32 dphy_rate, u32 *hsfreqrange,
+						      u32 *osc_freq_target,
+						      struct hwd_viif_res *res)
+{
+	int table_size = ARRAY_SIZE(dphy_hs_info);
+	int i;
+
+	for (i = 1; i < table_size; i++) {
+		if (dphy_rate < dphy_hs_info[i].rate) {
+			*hsfreqrange = dphy_hs_info[i - 1].hsfreqrange;
+			*osc_freq_target = dphy_hs_info[i - 1].osc_freq_target;
+			return;
+		}
+	}
+
+	/* not found; return the largest entry */
+	*hsfreqrange = dphy_hs_info[table_size - 1].hsfreqrange;
+	*osc_freq_target = dphy_hs_info[table_size - 1].osc_freq_target;
+}
+
+/**
+ * hwd_viif_csi2rx_set_dphy_rate() - Set D-PHY rate
+ *
+ * @dphy_rate: D-PHY rate of 1 Lane[Mbps] [80..1500]
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+static void hwd_viif_csi2rx_set_dphy_rate(u32 dphy_rate, struct hwd_viif_res *res)
+{
+	u32 hsfreqrange, osc_freq_target;
+
+	hwd_viif_csi2rx_get_dphy_hs_transfer_info(dphy_rate, &hsfreqrange, &osc_freq_target, res);
+
+	hwd_viif_csi2rx_write_dphy_param(DIG_RDWR_RX_SYS_1, (u8)hsfreqrange, res);
+	hwd_viif_csi2rx_write_dphy_param(DIG_RDWR_RX_SYS_0, SYS_0_HSFREQRANGE_OVR, res);
+	hwd_viif_csi2rx_write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_5, STARTUP_OVR_5_BYPASS, res);
+	hwd_viif_csi2rx_write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_4, STARTUP_OVR_4_CNTVAL, res);
+	hwd_viif_csi2rx_write_dphy_param(DIG_RDWR_RX_CB_2, CB_2_LPRX_BIAS | CB_2_RESERVED, res);
+	hwd_viif_csi2rx_write_dphy_param(DIG_RDWR_RX_SYS_7, SYS_7_DESKEW_POL | SYS_7_RESERVED, res);
+	hwd_viif_csi2rx_write_dphy_param(DIG_RDWR_RX_CLKLANE_LANE_6, CLKLANE_RXHS_PULL_LONG, res);
+	hwd_viif_csi2rx_write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_2,
+					 FIELD_GET(0xff, osc_freq_target), res);
+	hwd_viif_csi2rx_write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_3,
+					 FIELD_GET(0xf00, osc_freq_target), res);
+	hwd_viif_csi2rx_write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_4,
+					 STARTUP_OVR_4_CNTVAL | STARTUP_OVR_4_DDL_EN, res);
+
+	writel(HWD_VIIF_DPHY_CFG_CLK_25M, &res->capture_reg->sys.DPHY_FREQRANGE);
+}
+
+/**
+ * hwd_viif_csi2rx_check_dphy_calibration_status() - Check D-PHY calibration status
+ *
+ * @test_mode: test code related to calibration information
+ * @shift_val_err: shift value related to error information
+ * @shift_val_done: shift value related to done information
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: HWD_VIIF_CSI2_CAL_NOT_DONE calibration is not done(out of target or not completed)
+ * Return: HWD_VIIF_CSI2_CAL_FAIL calibration was failed
+ * Return: HWD_VIIF_CSI2_CAL_SUCCESS calibration was succeeded
+ */
+static u32 hwd_viif_csi2rx_check_dphy_calibration_status(u32 test_mode, u32 shift_val_err,
+							 u32 shift_val_done,
+							 struct hwd_viif_res *res)
+{
+	u32 read_data = (u32)hwd_viif_csi2rx_read_dphy_param(test_mode, res);
+
+	if (!(read_data & BIT(shift_val_done)))
+		return HWD_VIIF_CSI2_CAL_NOT_DONE;
+
+	/* error check is not required for termination calibration with REXT(0x221) */
+	if (test_mode == DIG_RD_RX_TERM_CAL_1)
+		return HWD_VIIF_CSI2_CAL_SUCCESS;
+
+	/* done with error */
+	if (read_data & BIT(shift_val_err))
+		return HWD_VIIF_CSI2_CAL_FAIL;
+
+	return HWD_VIIF_CSI2_CAL_SUCCESS;
+}
+
+/**
+ * hwd_viif_csi2rx_initialize() - Initialize CSI-2 RX driver
+ *
+ * @num_lane: [1..4](VIIF CH0-CH1)
+ * @lane_assign: lane connection. For more refer @ref hwd_viif_dphy_lane_assignment
+ * @dphy_rate: D-PHY rate of 1 Lane[Mbps] [80..1500]
+ * @rext_calibration: enable or disable rext calibration.
+ *                    For more refer @ref hwd_viif_csi2rx_cal_status
+ * @err_target: Pointer to configuration for Line error detection.
+ * @input_mode: CSI-2 input mode of VIIF CH1. For more refer @ref hwd_viif_csi2rx_input_mode
+ * @mask: MASK of CSI-2 RX error interruption
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "num_lane", "lane_assign", "dphy_rate", "rext_calibration" or "input_mode" is out of range
+ * - [2] "err_target" is NULL
+ * - [3] member of "err_target" is invalid
+ */
+s32 hwd_viif_csi2rx_initialize(u32 module_id, u32 num_lane, u32 lane_assign, u32 dphy_rate,
+			       u32 rext_calibration,
+			       const struct hwd_viif_csi2rx_line_err_target *err_target,
+			       u32 input_mode, const struct hwd_viif_csi2rx_irq_mask *mask)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 i, val;
+
+	if (res->csi2rx_type == HWD_VIIF_CSI2_TYPE_4_LANES) {
+		if (num_lane == 0U || num_lane > 4U || lane_assign > HWD_VIIF_CSI2_DPHY_L0L2L1L3)
+			return -EINVAL;
+	} else {
+		if ((num_lane != 1U && num_lane != 2U) ||
+		    lane_assign != HWD_VIIF_CSI2_DPHY_L0L1L2L3) {
+			return -EINVAL;
+		}
+	}
+
+	if (dphy_rate < HWD_VIIF_DPHY_MIN_DATA_RATE || dphy_rate > HWD_VIIF_DPHY_MAX_DATA_RATE ||
+	    (rext_calibration != HWD_VIIF_ENABLE && rext_calibration != HWD_VIIF_DISABLE) ||
+	    input_mode > HWD_VIIF_CSI2_INPUT_OTHER ||
+	    (res->ch != 1U && input_mode != HWD_VIIF_CSI2_INPUT_OWN) || !err_target) {
+		return -EINVAL;
+	}
+
+	for (i = 0; i < 8U; i++) {
+		if (err_target->vc[i] > HWD_VIIF_CSI2_MAX_VC ||
+		    err_target->dt[i] > HWD_VIIF_CSI2_MAX_DT ||
+		    (err_target->dt[i] < HWD_VIIF_CSI2_MIN_DT && err_target->dt[i] != 0U)) {
+			return -EINVAL;
+		}
+	}
+
+	if (input_mode == HWD_VIIF_CSI2_INPUT_OWN) {
+		/* 1st phase of initialization */
+		writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_RESETN);
+		writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_RSTZ);
+		writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ);
+		writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+		ndelay(15U);
+		writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+
+		/* Configure D-PHY frequency range */
+		hwd_viif_csi2rx_set_dphy_rate(dphy_rate, res);
+
+		/* 2nd phase of initialization */
+		writel((num_lane - 1U), &res->csi2host_reg->CSI2RX_NLANES);
+		ndelay(5U);
+
+		/* configuration not to use rext */
+		if (rext_calibration == HWD_VIIF_DISABLE) {
+			hwd_viif_csi2rx_write_dphy_param(0x004, 0x10, res);
+			ndelay(5U);
+		}
+
+		/* Release D-PHY from Reset */
+		writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ);
+		ndelay(5U);
+		writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_PHY_RSTZ);
+
+		/* configuration of line error target */
+		val = (err_target->vc[3] << 30U) | (err_target->dt[3] << 24U) |
+		      (err_target->vc[2] << 22U) | (err_target->dt[2] << 16U) |
+		      (err_target->vc[1] << 14U) | (err_target->dt[1] << 8U) |
+		      (err_target->vc[0] << 6U) | (err_target->dt[0]);
+		writel(val, &res->csi2host_reg->CSI2RX_DATA_IDS_1);
+		if (res->csi2rx_type == HWD_VIIF_CSI2_TYPE_4_LANES) {
+			val = (err_target->vc[7] << 30U) | (err_target->dt[7] << 24U) |
+			      (err_target->vc[6] << 22U) | (err_target->dt[6] << 16U) |
+			      (err_target->vc[5] << 14U) | (err_target->dt[5] << 8U) |
+			      (err_target->vc[4] << 6U) | (err_target->dt[4]);
+			writel(val, &res->csi2host_reg->CSI2RX_DATA_IDS_2);
+		}
+
+		/* configuration of mask */
+		writel(mask->mask[0], &res->csi2host_reg->CSI2RX_INT_MSK_PHY_FATAL);
+		writel(mask->mask[1], &res->csi2host_reg->CSI2RX_INT_MSK_PKT_FATAL);
+		writel(mask->mask[2], &res->csi2host_reg->CSI2RX_INT_MSK_FRAME_FATAL);
+		writel(mask->mask[3], &res->csi2host_reg->CSI2RX_INT_MSK_PHY);
+		writel(mask->mask[4], &res->csi2host_reg->CSI2RX_INT_MSK_PKT);
+		writel(mask->mask[5], &res->csi2host_reg->CSI2RX_INT_MSK_LINE);
+
+		/* configuration of lane assignment */
+		writel(lane_assign, &res->capture_reg->sys.DPHY_LANE);
+
+		res->other_csi2_flag = false;
+	} else {
+		/* configuration of csi2 port */
+		writel(input_mode, &res->capture_reg->sys.CSI2SELECT);
+
+		res->other_csi2_flag = true;
+	}
+	return 0;
+}
+
+/**
+ * hwd_viif_csi2rx_uninitialize() - Uninitialize CSI-2 RX driver
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ */
+s32 hwd_viif_csi2rx_uninitialize(u32 module_id)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (!res->other_csi2_flag) {
+		/* CSI2RX can be uninitialized because it has been enabled. */
+		writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ);
+		writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_PHY_RSTZ);
+		writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
+		writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_RESETN);
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_csi2rx_start() - Start CSI-2 input
+ *
+ * @vc_main: control CSI-2 input of MAIN unit.
+ *           enable with configured VC: 0, 1, 2 or 3, keep disabling:
+ * @vc_sub: control CSI-2 input of SUB unit.
+ *          enable with configured VC: 0, 1, 2 or 3, keep disabling:
+ * @packet: Pointer to packet information of embedded data and long packet data
+ * @voif_through: enable or disable VOIF through output. For more refer @ref drv_VIIF_enable_flag
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * HWD_VIIF_CSI2_NOT_CAPTURE
+ * HWD_VIIF_CSI2_NOT_CAPTURE
+ * - [1] "vc_main", "vc_sub" or "voif_through" is out of range
+ * - [2] member of "packet" is invalid
+ * - [3] "voif_through" is not HWD_VIIF_DISABLE in case of CH other than CH1
+ */
+s32 hwd_viif_csi2rx_start(u32 module_id, s32 vc_main, s32 vc_sub,
+			  const struct hwd_viif_csi2rx_packet *packet, u32 voif_through)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val, i, pitch, height, dt, start_addr, end_addr;
+	u32 enable_vc0 = HWD_VIIF_DISABLE;
+	u32 enable_vc1 = HWD_VIIF_DISABLE;
+
+	if (vc_main > 3 || vc_main < HWD_VIIF_CSI2_NOT_CAPTURE || vc_sub > 3 ||
+	    vc_sub < HWD_VIIF_CSI2_NOT_CAPTURE) {
+		return -EINVAL;
+	}
+
+	if (res->ch >= 2U && vc_sub != HWD_VIIF_CSI2_NOT_CAPTURE)
+		return -EINVAL;
+
+	for (i = 0; i < 4U; i++) {
+		if (packet->word_count[i] > HWD_VIIF_CSI2_MAX_WORD_COUNT ||
+		    packet->packet_num[i] > HWD_VIIF_CSI2_MAX_PACKET_NUM) {
+			return -EINVAL;
+		}
+
+		if ((i == 2U || i == 3U) && res->ch >= 2U)
+			if (packet->word_count[i] != 0U || packet->packet_num[i] != 0U)
+				return -EINVAL;
+	}
+
+	if (voif_through != HWD_VIIF_ENABLE && voif_through != HWD_VIIF_DISABLE)
+		return -EINVAL;
+
+	if (res->ch != 1U && voif_through == HWD_VIIF_ENABLE)
+		return -EINVAL;
+
+	writel(HWD_VIIF_INPUT_CSI2, &res->capture_reg->sys.IPORTM);
+
+	if (vc_main != HWD_VIIF_CSI2_NOT_CAPTURE) {
+		writel((u32)vc_main, &res->capture_reg->sys.VCID0SELECT);
+		enable_vc0 = HWD_VIIF_ENABLE;
+	}
+	if (vc_sub != HWD_VIIF_CSI2_NOT_CAPTURE) {
+		writel((u32)vc_sub, &res->capture_reg->sys.VCID1SELECT);
+		enable_vc1 = HWD_VIIF_ENABLE;
+	}
+
+	if (res->ch == 0U || res->ch == 1U) {
+		/* emb of MAIN unit: word_count[0], packet_num[0] and w_port[1](= w01) */
+		pitch = ROUNDUP_BY_4(packet->word_count[0]);
+		writel(pitch, &res->capture_reg->vdm.w_port[1].VDM_W_PITCH);
+		writel(packet->packet_num[0], &res->capture_reg->vdm.w_port[1].VDM_W_HEIGHT);
+		start_addr = readl(&res->capture_reg->vdm.w_port[1].VDM_W_STADR);
+		end_addr = start_addr + pitch - 1U;
+		writel(end_addr, &res->capture_reg->vdm.w_port[1].VDM_W_ENDADR);
+
+		/* long packet of MAIN unit: word_count[1], packet_num[1] and w_port[0](= w00) */
+		dt = readl(&res->capture_reg->sys.IPORTM_OTHER);
+		if (dt == CSI2_DT_YUV4208 || dt == CSI2_DT_YUV4208 || dt == CSI2_DT_YUV4208C ||
+		    dt == CSI2_DT_YUV42010C) {
+			pitch = ROUNDUP_BY_4(packet->word_count[1]) +
+				ROUNDUP_BY_4(packet->word_count[1] * 2U);
+			height = packet->packet_num[1] >> 1U;
+		} else {
+			pitch = ROUNDUP_BY_4(packet->word_count[1]);
+			height = packet->packet_num[1];
+		}
+		writel(pitch, &res->capture_reg->vdm.w_port[0].VDM_W_PITCH);
+		writel(height, &res->capture_reg->vdm.w_port[0].VDM_W_HEIGHT);
+		start_addr = readl(&res->capture_reg->vdm.w_port[0].VDM_W_STADR);
+		end_addr = start_addr + pitch - 1U;
+		writel(end_addr, &res->capture_reg->vdm.w_port[0].VDM_W_ENDADR);
+
+		/* emb of SUB unit: word_count[2], packet_num[2] and w_port[5](= w05) */
+		pitch = ROUNDUP_BY_4(packet->word_count[2]);
+		writel(pitch, &res->capture_reg->vdm.w_port[5].VDM_W_PITCH);
+		writel(packet->packet_num[2], &res->capture_reg->vdm.w_port[5].VDM_W_HEIGHT);
+		start_addr = readl(&res->capture_reg->vdm.w_port[5].VDM_W_STADR);
+		end_addr = start_addr + pitch - 1U;
+		writel(end_addr, &res->capture_reg->vdm.w_port[5].VDM_W_ENDADR);
+
+		/* long packet of SUB unit: word_count[3], packet_num[3] and w_port[4](= w04) */
+		dt = readl(&res->capture_reg->sys.IPORTS_OTHER);
+		if (dt == CSI2_DT_YUV4208 || dt == CSI2_DT_YUV42010 || dt == CSI2_DT_YUV4208C ||
+		    dt == CSI2_DT_YUV42010C) {
+			pitch = ROUNDUP_BY_4(packet->word_count[3]) +
+				ROUNDUP_BY_4(packet->word_count[3] * 2U);
+			height = packet->packet_num[3] >> 1U;
+		} else {
+			pitch = ROUNDUP_BY_4(packet->word_count[3]);
+			height = packet->packet_num[3];
+		}
+		writel(pitch, &res->capture_reg->vdm.w_port[4].VDM_W_PITCH);
+		writel(height, &res->capture_reg->vdm.w_port[4].VDM_W_HEIGHT);
+		start_addr = readl(&res->capture_reg->vdm.w_port[4].VDM_W_STADR);
+		end_addr = start_addr + pitch - 1U;
+		writel(end_addr, &res->capture_reg->vdm.w_port[4].VDM_W_ENDADR);
+	} else {
+		/* emb of MAIN unit: word_count[0], packet_num[0] and w_port[4](= w04) */
+		pitch = ROUNDUP_BY_4(packet->word_count[0]);
+		writel(pitch, &res->capture_reg->vdm.w_port[4].VDM_W_PITCH);
+		writel(packet->packet_num[0], &res->capture_reg->vdm.w_port[4].VDM_W_HEIGHT);
+		start_addr = readl(&res->capture_reg->vdm.w_port[4].VDM_W_STADR);
+		end_addr = start_addr + pitch - 1U;
+		writel(end_addr, &res->capture_reg->vdm.w_port[4].VDM_W_ENDADR);
+
+		/* long packet of MAIN unit: word_count[1], packet_num[1] and w_port[3](= w03) */
+		dt = readl(&res->capture_reg->sys.IPORTM_OTHER);
+		if (dt == CSI2_DT_YUV4208 || dt == CSI2_DT_YUV42010 || dt == CSI2_DT_YUV4208C ||
+		    dt == CSI2_DT_YUV42010C) {
+			pitch = ROUNDUP_BY_4(packet->word_count[1]) +
+				ROUNDUP_BY_4(packet->word_count[1] * 2U);
+			height = packet->packet_num[1] >> 1U;
+		} else {
+			pitch = ROUNDUP_BY_4(packet->word_count[1]);
+			height = packet->packet_num[1];
+		}
+		writel(pitch, &res->capture_reg->vdm.w_port[3].VDM_W_PITCH);
+		writel(height, &res->capture_reg->vdm.w_port[3].VDM_W_HEIGHT);
+		start_addr = readl(&res->capture_reg->vdm.w_port[3].VDM_W_STADR);
+		end_addr = start_addr + pitch - 1U;
+		writel(end_addr, &res->capture_reg->vdm.w_port[3].VDM_W_ENDADR);
+
+		/* Set CSI2 sync to Memory input mode for test data usecase */
+		writel(HWD_VIIF_MEM_SYNC_CSI2, &res->capture_reg->sys.IPORTI_M_SYNCMODE);
+	}
+
+	if (voif_through == HWD_VIIF_ENABLE) {
+		/* Enable VOIF through input */
+		writel(voif_through, &res->capture_reg->sys.CSI2THROUGHEN);
+	}
+
+	/* Control VC port enable */
+	val = enable_vc0 | (enable_vc1 << 4U);
+	writel(val, &res->capture_reg->sys.VCPORTEN);
+
+	if (enable_vc0 == HWD_VIIF_ENABLE) {
+		/* Update flag information for run status of MAIN unit */
+		res->run_flag_main = true;
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_csi2rx_stop() - Stop CSI-2 input
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -ETIMEDOUT Driver timeout error
+ */
+s32 hwd_viif_csi2rx_stop(u32 module_id)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 status_r, status_w, status_t, l2_status;
+	u64 timeout_ns, cur_ns;
+	bool run_flag = true;
+	s32 ret = 0;
+
+	if (res->ch != 0U && res->ch != 1U)
+		return -1;
+
+	/* Disable auto transmission of register buffer */
+	writel(0, &res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF);
+	writel(0, &res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF);
+
+	/* Wait for completion of register buffer transmission */
+	udelay(HWD_VIIF_WAIT_ISP_REGBF_TRNS_COMPLETE_TIME);
+
+	if (res->ch == 1U) {
+		/* Disable VOIF through input */
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.CSI2THROUGHEN);
+	}
+
+	/* Stop all VCs, long packet input and emb data input of MAIN unit */
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.VCPORTEN);
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTM_OTHEREN);
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTM_EMBEN);
+
+	/* Stop image data input, long packet input and emb data input of SUB unit */
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTS_OTHEREN);
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTS_EMBEN);
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTS_IMGEN);
+
+	/* Stop VDMAC for all table ports, input ports and write ports */
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->vdm.VDM_T_ENABLE);
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->vdm.VDM_R_ENABLE);
+	writel(HWD_VIIF_DISABLE, &res->capture_reg->vdm.VDM_W_ENABLE);
+
+	/* Stop all groups(g00, g01 and g02) of VDMAC */
+	writel(0x7, &res->capture_reg->vdm.VDM_ABORTSET);
+
+	timeout_ns = ktime_get_ns() + HWD_VIIF_WAIT_ABORT_COMPLETE_TIME * 1000;
+
+	do {
+		/* Get VDMAC transfer status  */
+		status_r = readl(&res->capture_reg->vdm.VDM_R_RUN);
+		status_w = readl(&res->capture_reg->vdm.VDM_W_RUN);
+		status_t = readl(&res->capture_reg->vdm.VDM_T_RUN);
+
+		l2_status = readl(&res->capture_reg->l2isp.L2_BUS_L2_STATUS);
+
+		if (status_r == 0U && status_w == 0U && status_t == 0U && l2_status == 0U)
+			run_flag = false;
+
+		cur_ns = ktime_get_ns();
+
+		if (cur_ns > timeout_ns) {
+			ret = -ETIMEDOUT;
+			run_flag = false;
+		}
+	} while (run_flag);
+
+	if (ret == 0) {
+		/* Clear run flag of MAIN unit */
+		res->run_flag_main = false;
+	}
+
+	return ret;
+}
+
+/**
+ * hwd_viif_csi2rx_get_calibration_status() - Get CSI-2 RX calibration status
+ *
+ * @calibration_status: Pointer to D-PHY calibration status information
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "calibration_status" is NULL
+ */
+s32 hwd_viif_csi2rx_get_calibration_status(
+	u32 module_id, struct viif_csi2rx_dphy_calibration_status *calibration_status)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (!calibration_status)
+		return -EINVAL;
+
+	/* arg0; test register, arg1: error bit, arg2: done bit */
+	/* 0x221: termination calibration with REXT */
+	calibration_status->term_cal_with_rext =
+		hwd_viif_csi2rx_check_dphy_calibration_status(DIG_RD_RX_TERM_CAL_1, 0, 7, res);
+	/* 0x39D: clock lane offset calibration */
+	calibration_status->clock_lane_offset_cal = hwd_viif_csi2rx_check_dphy_calibration_status(
+		DIG_RD_RX_CLKLANE_OFFSET_CAL_0, 4, 0, res);
+	/* 0x59F: data lane0 offset calibration */
+	calibration_status->data_lane0_offset_cal = hwd_viif_csi2rx_check_dphy_calibration_status(
+		DIG_RD_RX_LANE0_OFFSET_CAL_0, 2, 1, res);
+	/* 0x79F: data lane1 offset calibration */
+	calibration_status->data_lane1_offset_cal = hwd_viif_csi2rx_check_dphy_calibration_status(
+		DIG_RD_RX_LANE1_OFFSET_CAL_0, 2, 1, res);
+	/* 0x5E0: data lane0 DDL(Digital Delay Line) calibration */
+	calibration_status->data_lane0_ddl_tuning_cal =
+		hwd_viif_csi2rx_check_dphy_calibration_status(DIG_RD_RX_LANE0_DDL_0, 1, 2, res);
+	/* 0x7E0: data lane1 DDL calibration */
+	calibration_status->data_lane1_ddl_tuning_cal =
+		hwd_viif_csi2rx_check_dphy_calibration_status(DIG_RD_RX_LANE1_DDL_0, 1, 2, res);
+
+	if (res->csi2rx_type == HWD_VIIF_CSI2_TYPE_4_LANES) {
+		/* 0x99F: data lane2 offset calibration */
+		calibration_status->data_lane2_offset_cal =
+			hwd_viif_csi2rx_check_dphy_calibration_status(DIG_RD_RX_LANE2_OFFSET_CAL_0,
+								      2, 1, res);
+		/* 0xB9F: data lane3 offset calibration */
+		calibration_status->data_lane3_offset_cal =
+			hwd_viif_csi2rx_check_dphy_calibration_status(DIG_RD_RX_LANE3_OFFSET_CAL_0,
+								      2, 1, res);
+		/* 0x9E0: data lane2 DDL calibration */
+		calibration_status->data_lane2_ddl_tuning_cal =
+			hwd_viif_csi2rx_check_dphy_calibration_status(DIG_RD_RX_LANE2_DDL_0, 1, 2,
+								      res);
+		/* 0xBE0: data lane3 DDL calibration */
+		calibration_status->data_lane3_ddl_tuning_cal =
+			hwd_viif_csi2rx_check_dphy_calibration_status(DIG_RD_RX_LANE3_DDL_0, 1, 2,
+								      res);
+	} else {
+		calibration_status->data_lane2_offset_cal = HWD_VIIF_CSI2_CAL_NOT_DONE;
+		calibration_status->data_lane3_offset_cal = HWD_VIIF_CSI2_CAL_NOT_DONE;
+		calibration_status->data_lane2_ddl_tuning_cal = HWD_VIIF_CSI2_CAL_NOT_DONE;
+		calibration_status->data_lane3_ddl_tuning_cal = HWD_VIIF_CSI2_CAL_NOT_DONE;
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_csi2rx_get_err_status() - Get CSI-2 RX error status
+ *
+ * @err_phy_fatal: Pointer to D-PHY fatal error information
+ * @err_pkt_fatal: Pointer to Packet fatal error information
+ * @err_frame_fatal: Pointer to Frame fatal error information
+ * @err_phy: Pointer to D-PHY error information
+ * @err_pkt: Pointer to Packet error information
+ * @err_line: Pointer to Line error information
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error,
+ *         when "err_phy_fatal", "err_pkt_fatal", "err_frame_fatal",
+ *         "err_phy", "err_pkt" or "err_line" is NULL
+ */
+s32 hwd_viif_csi2rx_get_err_status(u32 module_id, u32 *err_phy_fatal, u32 *err_pkt_fatal,
+				   u32 *err_frame_fatal, u32 *err_phy, u32 *err_pkt, u32 *err_line)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (!err_phy_fatal || !err_pkt_fatal || !err_frame_fatal || !err_phy || !err_pkt ||
+	    !err_line) {
+		return -EINVAL;
+	}
+	*err_phy_fatal = readl(&res->csi2host_reg->CSI2RX_INT_ST_PHY_FATAL);
+	*err_pkt_fatal = readl(&res->csi2host_reg->CSI2RX_INT_ST_PKT_FATAL);
+	*err_frame_fatal = readl(&res->csi2host_reg->CSI2RX_INT_ST_FRAME_FATAL);
+	*err_phy = readl(&res->csi2host_reg->CSI2RX_INT_ST_PHY);
+	*err_pkt = readl(&res->csi2host_reg->CSI2RX_INT_ST_PKT);
+	*err_line = readl(&res->csi2host_reg->CSI2RX_INT_ST_LINE);
+
+	return 0;
+}
diff --git a/drivers/media/platform/visconti/hwd_viif_internal.h b/drivers/media/platform/visconti/hwd_viif_internal.h
new file mode 100644
index 000000000..5c9a314fb
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif_internal.h
@@ -0,0 +1,348 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef HWD_VIIF_INTERNAL_H
+#define HWD_VIIF_INTERNAL_H
+
+#include "hwd_viif_reg.h"
+
+#define HWD_VIIF_CSI2_TYPE_4_LANES	    (0U)
+#define HWD_VIIF_CSI2_TYPE_2_LANES	    (1U)
+#define HWD_VIIF_CSI2_MAX_VC		    (3U)
+#define HWD_VIIF_CSI2_MIN_DT		    (0x10U)
+#define HWD_VIIF_CSI2_MAX_DT		    (0x3fU)
+#define HWD_VIIF_CSI2_MAX_WORD_COUNT	    (16384U)
+#define HWD_VIIF_CSI2_MAX_PACKET_NUM	    (8192U)
+#define HWD_VIIF_DPHY_MIN_DATA_RATE	    (80U)
+#define HWD_VIIF_DPHY_MAX_DATA_RATE	    (1500U)
+#define HWD_VIIF_DPHY_CFG_CLK_25M	    (32U)
+#define HWD_VIIF_DPHY_TRANSFER_HS_TABLE_NUM (43U)
+
+/* maximum horizontal/vertical position/dimension of CROP with ISP */
+#define HWD_VIIF_CROP_MAX_X_ISP (8062U)
+#define HWD_VIIF_CROP_MAX_Y_ISP (3966U)
+#define HWD_VIIF_CROP_MAX_W_ISP (8190U)
+#define HWD_VIIF_CROP_MAX_H_ISP (4094U)
+
+/* maximum horizontal/vertical position/dimension of CROP without ISP */
+#define HWD_VIIF_CROP_MAX_X (1920U)
+#define HWD_VIIF_CROP_MAX_Y (1408U)
+#define HWD_VIIF_CROP_MIN_W (128U)
+#define HWD_VIIF_CROP_MAX_W (2048U)
+#define HWD_VIIF_CROP_MIN_H (128U)
+#define HWD_VIIF_CROP_MAX_H (1536U)
+
+/* pixel clock: [kHz] */
+#define HWD_VIIF_MIN_PIXEL_CLOCK (3375U)
+#define HWD_VIIF_MAX_PIXEL_CLOCK (600000U)
+
+/* picture size: [pixel], [ns] */
+#define HWD_VIIF_MIN_HTOTAL_PIXEL (143U)
+#define HWD_VIIF_MIN_HTOTAL_NSEC  (239U)
+#define HWD_VIIF_MAX_HTOTAL_PIXEL (65535U)
+#define HWD_VIIF_MAX_HTOTAL_NSEC  (109225U)
+
+/* horizontal back porch size: [system clock] */
+#define HWD_VIIF_HBP_SYSCLK (10U)
+
+/* active picture size: [pixel] */
+#define HWD_VIIF_MIN_HACTIVE_PIXEL_WO_L1ISP (128U)
+#define HWD_VIIF_MAX_HACTIVE_PIXEL_WO_L1ISP (4096U)
+#define HWD_VIIF_MIN_HACTIVE_PIXEL_W_L1ISP  (640U)
+#define HWD_VIIF_MAX_HACTIVE_PIXEL_W_L1ISP  (3840U)
+
+/* picture vertical size: [line], [packet] */
+#define HWD_VIIF_MIN_VTOTAL_LINE	   (144U)
+#define HWD_VIIF_MAX_VTOTAL_LINE	   (16383U)
+#define HWD_VIIF_MIN_VBP_LINE		   (5U)
+#define HWD_VIIF_MAX_VBP_LINE		   (4095U)
+#define HWD_VIIF_MIN_VBP_PACKET		   (5U)
+#define HWD_VIIF_MAX_VBP_PACKET		   (4095U)
+#define HWD_VIIF_MIN_VACTIVE_LINE_WO_L1ISP (128U)
+#define HWD_VIIF_MAX_VACTIVE_LINE_WO_L1ISP (2160U)
+#define HWD_VIIF_MIN_VACTIVE_LINE_W_L1ISP  (480U)
+#define HWD_VIIF_MAX_VACTIVE_LINE_W_L1ISP  (2160U)
+
+/* image source select */
+#define HWD_VIIF_INPUT_CSI2 (0U)
+
+#define HWD_VIIF_CSC_MAX_OFFSET	       (0x0001FFFFU)
+#define HWD_VIIF_CSC_MAX_COEF_VALUE    (0x0000FFFFU)
+#define HWD_VIIF_CSC_MAX_COEF_NUM      (9U)
+#define HWD_VIIF_GAMMA_MAX_VSPLIT      (4094U)
+#define HWD_VIIF_MTB_CB_YG_COEF_OFFSET (16U)
+#define HWD_VIIF_MTB_CR_YG_COEF_OFFSET (0U)
+#define HWD_VIIF_MTB_CB_CB_COEF_OFFSET (16U)
+#define HWD_VIIF_MTB_CR_CB_COEF_OFFSET (0U)
+#define HWD_VIIF_MTB_CB_CR_COEF_OFFSET (16U)
+#define HWD_VIIF_MTB_CR_CR_COEF_OFFSET (0U)
+#define HWD_VIIF_MAX_PITCH_ISP	       (32704U)
+#define HWD_VIIF_MAX_PITCH	       (65536U)
+
+/* size of minimum/maximum input image */
+#define HWD_VIIF_MIN_INPUT_IMG_WIDTH	  (128U)
+#define HWD_VIIF_MAX_INPUT_IMG_WIDTH_ISP  (4096U)
+#define HWD_VIIF_MAX_INPUT_IMG_WIDTH	  (2048U)
+#define HWD_VIIF_MIN_INPUT_IMG_HEIGHT	  (128U)
+#define HWD_VIIF_MAX_INPUT_IMG_HEIGHT_ISP (2160U)
+#define HWD_VIIF_MAX_INPUT_IMG_HEIGHT	  (1536U)
+#define HWD_VIIF_MAX_INPUT_LINE_SIZE	  (16384U)
+
+/* size of minimum/maximum output image */
+#define HWD_VIIF_MIN_OUTPUT_IMG_WIDTH	  (128U)
+#define HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_ISP (5760U)
+#define HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_SUB (4096U)
+
+#define HWD_VIIF_MIN_OUTPUT_IMG_HEIGHT	   (128U)
+#define HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP (3240U)
+#define HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_SUB (2160U)
+
+#define HWD_VIIF_NO_EVENT (0x0U)
+
+/* System clock: [kHz] */
+#define HWD_VIIF_SYS_CLK (500000UL)
+
+/*
+ * wait time for force abort to complete(max 1line time = 1228.8[us]
+ * when width = 4096, RAW24, 80Mbps
+ */
+#define HWD_VIIF_WAIT_ABORT_COMPLETE_TIME (1229U)
+
+/*
+ * complete time of register buffer transfer.
+ * actual time is about 30us in case of L1ISP
+ */
+#define HWD_VIIF_WAIT_ISP_REGBF_TRNS_COMPLETE_TIME (39U)
+
+/* internal operation latencies: [system clock]*/
+#define HWD_VIIF_TABLE_LOAD_TIME    (24000UL)
+#define HWD_VIIF_REGBUF_ACCESS_TIME (15360UL)
+
+/* offset of Vsync delay: [line] */
+#define HWD_VIIF_L1_DELAY_W_HDRC  (31U)
+#define HWD_VIIF_L1_DELAY_WO_HDRC (11U)
+
+/* data width is 32bit */
+#define HWD_VIIF_VDM_CFG_PARAM (0x00000210U)
+
+/* vsync mode is pulse */
+#define HWD_VIIF_DPGM_VSYNC_PULSE (1U)
+
+/* Vlatch mask bit for L1ISP and L2ISP */
+#define HWD_VIIF_ISP_VLATCH_MASK (2U)
+
+/* Register buffer */
+#define HWD_VIIF_ISP_MAX_CONTEXT_NUM	(4U)
+#define HWD_VIIF_ISP_REGBUF_MODE_BYPASS (0U)
+#define HWD_VIIF_ISP_REGBUF_MODE_BUFFER (1U)
+#define HWD_VIIF_ISP_REGBUF_READ	(1U)
+
+/* constants for L1 ISP*/
+#define HWD_VIIF_L1_INPUT_MODE_NUM			 (5U)
+#define HWD_VIIF_L1_INPUT_DEPTH_MIN			 (8U)
+#define HWD_VIIF_L1_INPUT_DEPTH_MAX			 (24U)
+#define HWD_VIIF_L1_INPUT_DEPTH_SDR_MAX			 (12U)
+#define HWD_VIIF_L1_INPUT_DEPTH_PWL_MAX			 (14U)
+#define HWD_VIIF_L1_RAW_MODE_NUM			 (4U)
+#define HWD_VIIF_L1_INPUT_NUM_MIN			 (1U)
+#define HWD_VIIF_L1_INPUT_NUM_MAX			 (3U)
+#define HWD_VIIF_L1_AG_ID_NUM				 (4U)
+#define HWD_VIIF_L1_SENSITIVITY_IMAGE_NUM		 (3U)
+#define HWD_VIIF_L1_HDRE_MAX_KNEEPOINT_VAL		 (0x3fffU)
+#define HWD_VIIF_L1_HDRE_MAX_HDRE_SIG_VAL		 (0xffffffU)
+#define HWD_VIIF_L1_HDRE_MAX_OUT_PIXEL_RATIO		 (0x400000U)
+#define HWD_VIIF_L1_HDRE_MAX_OUT_PIXEL_VAL		 (0xffffffU)
+#define HWD_VIIF_L1_OBCC_MAX_AG_VAL			 (511U)
+#define HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL	 (0xffffffU)
+#define HWD_VIIF_L1_DPC_MAX_RATIO_LIMIT_VAL		 (1023U)
+#define HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL		 (1U)
+#define HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL		 (31U)
+#define HWD_VIIF_L1_VDM_ALIGN				 (0x8U) /* port interface width is 64bit */
+#define HWD_VIIF_L1_VDM_CFG_PARAM			 (0x00000310U) /* data width is 64bit */
+#define HWD_VIIF_L1_VDM_SRAM_BASE			 (0x00000600U)
+#define HWD_VIIF_L1_VDM_SRAM_SIZE			 (0x00000020U)
+#define HWD_VIIF_L1_VDM_DPC_TABLE_SIZE			 (0x2000U)
+#define HWD_VIIF_L1_VDM_LSC_TABLE_SIZE			 (0x600U)
+#define HWD_VIIF_L1_PWHB_MAX_OUT_PIXEL_VAL		 (4095U)
+#define HWD_VIIF_L1_PWHB_MAX_GAIN_VAL			 (0x80000U)
+#define HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL	 (63U)
+#define HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL (31U)
+#define HWD_VIIF_L1_RCNR_MAX_ADJUSTMENT_GAIN_VAL	 (3U)
+#define HWD_VIIF_L1_RCNR_MAX_ZERO_CLIP_VAL		 (256U)
+#define HWD_VIIF_L1_RCNR_MAX_BLEND_VAL			 (16U)
+#define HWD_VIIF_L1_RCNR_MAX_BLACK_LEVEL_VAL		 (64U)
+#define HWD_VIIF_L1_RCNR_MIN_0DIV_GUARD_VAL		 (4U)
+#define HWD_VIIF_L1_RCNR_MAX_0DIV_GUARD_VAL		 (16U)
+#define HWD_VIIF_L1_RCNR_MAX_CALC_MSF_NOISE_MULTI_VAL	 (32U)
+#define HWD_VIIF_L1_RCNR_MAX_GEN_LUMA_SIG_BLEND_VAL	 (2U)
+#define HWD_VIIF_L1_RCNR_MAX_UP_LIMIT_GRGB_SENS_RATIO	 (15U)
+#define HWD_VIIF_L1_HDRS_MIN_BLEND_RATIO		 (0x400U)
+#define HWD_VIIF_L1_HDRS_MAX_BLEND_RATIO		 (0x400000U)
+#define HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL		 (0x400000U)
+#define HWD_VIIF_L1_HDRS_MAX_DST_MAX_VAL		 (0xffffffU)
+#define HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL		 (4095U)
+#define HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL			 (0xffffffU)
+#define HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL		 (0x100000U)
+#define HWD_VIIF_L1_BLACK_LEVEL_MAX_DST_VAL		 (0xffffffU)
+#define HWD_VIIF_LSC_MIN_GAIN				 (-4096)
+#define HWD_VIIF_LSC_MAX_GAIN				 (4096)
+#define HWD_VIIF_LSC_GRID_MIN_COORDINATE		 (1U)
+#define HWD_VIIF_LSC_PWB_MAX_COEF_VAL			 (0x800U)
+#define HWD_VIIF_DAMP_MAX_LSBSEL			 (15U)
+#define HWD_VIIF_MAIN_PROCESS_MAX_OUT_PIXEL_VAL		 (0xffffffU)
+#define HWD_VIIF_AWB_MIN_GAIN				 (64U)
+#define HWD_VIIF_AWB_MAX_GAIN				 (1024U)
+#define HWD_VIIF_AWB_GATE_LOWER				 (-127)
+#define HWD_VIIF_AWB_GATE_UPPER				 (127)
+#define HWD_VIIF_AWB_UNSIGNED_GATE_UPPER		 (127U)
+#define HWD_VIIF_AWB_MAX_UV_CONVERGENCE_SPEED		 (15U)
+#define HWD_VIIF_AWB_MAX_UV_CONVERGENCE_LEVEL		 (31U)
+#define HWD_VIIF_AWB_INTEGRATION_STOP_TH		 (1023U)
+#define HWD_VIIF_L1_HDRC_MAX_THROUGH_SHIFT_VAL		 (8U)
+#define HWD_VIIF_L1_HDRC_MIN_INPUT_DATA_WIDTH		 (10U)
+#define HWD_VIIF_L1_HDRC_MAX_INPUT_DATA_WIDTH		 (24U)
+#define HWD_VIIF_L1_HDRC_MAX_PT_SLOPE			 (13U)
+#define HWD_VIIF_L1_HDRC_MAX_BLEND_RATIO		 (256U)
+#define HWD_VIIF_L1_HDRC_MAX_FLARE_VAL			 (0xffffffU)
+#define HWD_VIIF_L1_HDRC_MAX_BLEND_LUMA			 (16U)
+#define HWD_VIIF_L1_HDRC_MAX_LTM_TONE_BLEND_RATIO	 (0x400000U)
+#define HWD_VIIF_L1_HDRC_MAX_LTM_MAGNIFICATION		 (0x4000U)
+#define HWD_VIIF_L1_HDRC_RATIO_OFFSET			 (10U)
+#define HWD_VIIF_L1_GAMMA_MAX_VAL			 (8191U)
+#define HWD_VIIF_L1_SUPPRESSION_MAX_VAL			 (0x4000U)
+#define HWD_VIIF_L1_EDGE_SUPPRESSION_MAX_LIMIT		 (15U)
+#define HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN		 (0x1000U)
+#define HWD_VIIF_L1_AEXP_MAX_WEIGHT			 (3U)
+#define HWD_VIIF_L1_AEXP_MAX_BLOCK_TH			 (256U)
+#define HWD_VIIF_L1_AEXP_MAX_SATURATION_PIXEL_TH	 (0xffffffU)
+#define HWD_VIIF_L1_AEXP_MIN_BLOCK_WIDTH		 (64U)
+#define HWD_VIIF_L1_AEXP_MIN_BLOCK_HEIGHT		 (64U)
+#define HWD_VIIF_L1_HIST_COLOR_RGBY			 (2U)
+#define HWD_VIIF_L1_HIST_MAX_BLOCK_NUM			 (8U)
+#define HWD_VIIF_L1_HIST_MAX_STEP			 (15U)
+#define HWD_VIIF_L1_HIST_MAX_BIN_SHIFT			 (31U)
+#define HWD_VIIF_L1_HIST_MAX_COEF			 (65536U)
+#define HWD_VIIF_L1_HIST_MIN_ADD_B_COEF			 (-65536)
+#define HWD_VIIF_L1_HIST_MIN_ADD_A_COEF			 (-16777216)
+#define HWD_VIIF_L1_HIST_MAX_ADD_A_COEF			 (16777216)
+#define HWD_VIIF_L1_HIST_VDM_SIZE			 (4096U)
+#define HWD_VIIF_L1_HIST_VDM_SRAM_BASE			 (0x00000400U)
+#define HWD_VIIF_L1_HIST_VDM_SRAM_SIZE			 (0x00000040U)
+#define HWD_VIIF_L1_CRGBF_R_START_ADDR_LIMIT		 (0x0200U)
+#define HWD_VIIF_L1_CRGBF_R_END_ADDR_LIMIT		 (0x10BFU)
+#define HWD_VIIF_L1_COEF_MIN				 (256U)
+#define HWD_VIIF_L1_COEF_MAX				 (65024U)
+
+/* constants for L2 ISP */
+#define HWD_VIIF_L2_VDM_ALIGN			     (0x4U)
+#define HWD_VIIF_L2_VDM_GRID_SRAM_BASE		     (0x00000620U)
+#define HWD_VIIF_L2_VDM_GRID_SRAM_SIZE		     (0x00000020U)
+#define HWD_VIIF_L2_VDM_GAMMA_SRAM_BASE		     (0x00000640U)
+#define HWD_VIIF_L2_VDM_GAMMA_SRAM_SIZE		     (0x00000020U)
+#define HWD_VIIF_L2_VDM_GAMMA_TABLE_SIZE	     (0x00000200U)
+#define HWD_VIIF_L2_UNDIST_POLY_NUM		     (11U)
+#define HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_H     (-4296)
+#define HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_H     (4296)
+#define HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_V     (-2360)
+#define HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_V     (2360)
+#define HWD_VIIF_L2_UNDIST_MAX_NORM_SCALE	     (1677721U)
+#define HWD_VIIF_L2_UNDIST_MAX_VALID_R_NORM2	     (0x4000000U)
+#define HWD_VIIF_L2_UNDIST_MAX_ROI_WRITE_AREA_DELTA  (0x800U)
+#define HWD_VIIF_L2_UNDIST_MIN_POLY_COEF	     (-2147352576)
+#define HWD_VIIF_L2_UNDIST_MAX_POLY_COEF	     (2147352576)
+#define HWD_VIIF_L2_UNDIST_MIN_GRID_NUM		     (16U)
+#define HWD_VIIF_L2_UNDIST_MAX_GRID_NUM		     (64U)
+#define HWD_VIIF_L2_UNDIST_MAX_GRID_TOTAL_NUM	     (2048U)
+#define HWD_VIIF_L2_UNDIST_MAX_GRID_PATCH_SIZE_INV   (0x800000U)
+#define HWD_VIIF_L2_UNDIST_MIN_TABLE_SIZE	     (0x400U)
+#define HWD_VIIF_L2_UNDIST_MAX_TABLE_SIZE	     (0x2000U)
+#define HWD_VIIF_L2_ROI_MIN_NUM			     (1U)
+#define HWD_VIIF_L2_ROI_MAX_NUM			     (2U)
+#define HWD_VIIF_L2_ROI_MIN_SCALE		     (32768U)
+#define HWD_VIIF_L2_ROI_MAX_SCALE		     (131072U)
+#define HWD_VIIF_L2_ROI_MIN_SCALE_INV		     (32768U)
+#define HWD_VIIF_L2_ROI_MAX_SCALE_INV		     (131072U)
+#define HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_HSIZE (128U)
+#define HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_HSIZE (8190U)
+#define HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_VSIZE (128U)
+#define HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_VSIZE (4094U)
+#define HWD_VIIF_L2_ROI_MIN_CORRECTED_HSIZE	     (128U)
+#define HWD_VIIF_L2_ROI_MAX_CORRECTED_HSIZE	     (8190U)
+#define HWD_VIIF_L2_ROI_MIN_CORRECTED_VSIZE	     (128U)
+#define HWD_VIIF_L2_ROI_MAX_CORRECTED_VSIZE	     (4094U)
+#define HWD_VIIF_L2_CRGBF_R_START_ADDR_LIMIT	     (0x1CU)
+#define HWD_VIIF_L2_CRGBF_R_END_ADDR_LIMIT	     (0x1FU)
+#define HWD_VIIF_L2_ROI_NONE			     (3U)
+#define HWD_VIIF_MAX_POST_NUM			     (2U)
+#define HWD_VIIF_L2_INPUT_OTHER_CH		     (0x50U)
+
+/**
+ * struct hwd_viif_l2_roi_path_info - L2ISP ROI path control information
+ *
+ * @roi_num: the number of ROIs which are used.
+ * @post_enable_flag: flag to show which of POST is enabled.
+ * @post_crop_x: CROP x of each L2ISP POST
+ * @post_crop_y: CROP y of each L2ISP POST
+ * @post_crop_w: CROP w of each L2ISP POST
+ * @post_crop_h: CROP h of each L2ISP POST
+ */
+struct hwd_viif_l2_roi_path_info {
+	u32 roi_num;
+	bool post_enable_flag[HWD_VIIF_MAX_POST_NUM];
+	u32 post_crop_x[HWD_VIIF_MAX_POST_NUM];
+	u32 post_crop_y[HWD_VIIF_MAX_POST_NUM];
+	u32 post_crop_w[HWD_VIIF_MAX_POST_NUM];
+	u32 post_crop_h[HWD_VIIF_MAX_POST_NUM];
+};
+
+/**
+ * struct hwd_viif_res - driver internal resource structure
+ *
+ * @ch: channel ID
+ * @csi2rx_type: type of CSI-2 RX
+ * @sram_size_w_port: vdmac sram size of write port
+ * @sram_size_r_port: vdmac sram size of read port
+ * @sram_start_addr_gamma: start address of vdmac sram for gamma table
+ * @pixel_clock: pixel clock
+ * @htotal_size: horizontal total size
+ * @dt_image_main_w_isp: Data type of image data for ISP path
+ * @csi2host_reg: pointer to register access structure of CSI-2 RX host controller
+ * @capture_reg: pointer to register access structure of capture unit
+ * @l2_roi_path_info: ROI path information of L2ISP
+ * @run_flag_main: run flag of MAIN unit(true: run, false: not run)
+ * @other_csi2_flag: flag to indicate that packet is input from other channel
+ */
+struct hwd_viif_res {
+	const u32 ch;
+	const u32 csi2rx_type;
+	const u32 sram_size_w_port;
+	const u32 sram_size_r_port;
+	const u32 sram_start_addr_gamma;
+	u32 pixel_clock;
+	u32 htotal_size;
+	u32 dt_image_main_w_isp;
+	struct hwd_viif_csi2host_reg *csi2host_reg;
+	struct hwd_viif_capture_reg *capture_reg;
+	struct hwd_viif_l2_roi_path_info l2_roi_path_info;
+	bool run_flag_main;
+	bool other_csi2_flag;
+};
+
+/**
+ * struct hwd_viif_dphy_hs_info - dphy hs information
+ *
+ * @rate: Data rate [Mbps]
+ * @hsfreqrange: IP operating frequency(hsfreqrange)
+ * @osc_freq_target: DDL target oscillation frequency(osc_freq_target)
+ */
+struct hwd_viif_dphy_hs_info {
+	u32 rate;
+	u32 hsfreqrange;
+	u32 osc_freq_target;
+};
+
+#endif /* HWD_VIIF_INTERNAL_H */
diff --git a/drivers/media/platform/visconti/hwd_viif_l1isp.c b/drivers/media/platform/visconti/hwd_viif_l1isp.c
new file mode 100644
index 000000000..c6cd08776
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif_l1isp.c
@@ -0,0 +1,2727 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/io.h>
+#include "hwd_viif.h"
+#include "hwd_viif_internal.h"
+
+/**
+ * hwd_viif_l1_set_input_mode() - Configure L1ISP input mode.
+ *
+ * @mode: L1ISP preprocessing mode @ref hwd_viif_l1_input_mode
+ * @depth: input color depth (even only)
+ * - [8..24] in case of mode = #HWD_VIIF_L1_INPUT_HDR or #HWD_VIIF_L1_INPUT_HDR_IMG_CORRECT
+ * - [8..14] in case of mode = #HWD_VIIF_L1_INPUT_PWL or #HWD_VIIF_L1_INPUT_PWL_IMG_CORRECT
+ * - [8..12] in case of mode = #HWD_VIIF_L1_INPUT_SDR
+ * @raw_color_filter: RAW color filter array @ref hwd_viif_l1_raw_color_filter_mode
+ * @interpolation_order: interpolation order for input image
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "mode" is out of range
+ * - "depth" is out of range
+ * - "raw_color_filter" is out of range
+ * - "interpolation_order" is NULL in case of "mode" == #HWD_VIIF_L1_INPUT_SDR
+ * - "interpolation_order" is not NULL in case of "mode" != #HWD_VIIF_L1_INPUT_SDR
+ *
+ * Note that if 'mode' is not HWD_VIIF_L1_INPUT_SDR, NULL shall be set to 'interpolation_order'.
+ */
+s32 hwd_viif_l1_set_input_mode(u32 module_id, u32 mode, u32 depth, u32 raw_color_filter)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 depth_max;
+
+	if (mode >= HWD_VIIF_L1_INPUT_MODE_NUM || mode == HWD_VIIF_L1_INPUT_SDR)
+		return -EINVAL;
+
+	if (mode == HWD_VIIF_L1_INPUT_PWL || mode == HWD_VIIF_L1_INPUT_PWL_IMG_CORRECT)
+		depth_max = HWD_VIIF_L1_INPUT_DEPTH_PWL_MAX;
+	else
+		depth_max = HWD_VIIF_L1_INPUT_DEPTH_MAX;
+
+	if (depth < HWD_VIIF_L1_INPUT_DEPTH_MIN || depth > depth_max || ((depth % 2U) != 0U) ||
+	    raw_color_filter >= HWD_VIIF_L1_RAW_MODE_NUM) {
+		return -EINVAL;
+	}
+
+	writel(mode, &res->capture_reg->l1isp.L1_SYSM_INPUT_MODE);
+	writel(depth, &res->capture_reg->l1isp.L1_IBUF_DEPTH);
+	writel(raw_color_filter, &res->capture_reg->l1isp.L1_SYSM_START_COLOR);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_rgb_to_y_coef() - Configure L1ISP RGB coefficients to calculate Y.
+ *
+ * @coef_r: R coefficient to calculate Y [256..65024] accuracy: 1/65536
+ * @coef_g: G coefficient to calculate Y [256..65024] accuracy: 1/65536
+ * @coef_b: B coefficient to calculate Y [256..65024] accuracy: 1/65536
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "coef_r" is out of range
+ * - "coef_g" is out of range
+ * - "coef_b" is out of range
+ *
+ * Note that it is possible that coef_r/g/b has rounding error when the value is set to HW register
+ */
+s32 hwd_viif_l1_set_rgb_to_y_coef(u32 module_id, u16 coef_r, u16 coef_g, u16 coef_b)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (coef_r < HWD_VIIF_L1_COEF_MIN || coef_r > HWD_VIIF_L1_COEF_MAX ||
+	    coef_g < HWD_VIIF_L1_COEF_MIN || coef_g > HWD_VIIF_L1_COEF_MAX ||
+	    coef_b < HWD_VIIF_L1_COEF_MIN || coef_b > HWD_VIIF_L1_COEF_MAX) {
+		return -EINVAL;
+	}
+
+	writel((u32)coef_r, &res->capture_reg->l1isp.L1_SYSM_YCOEF_R);
+	writel((u32)coef_g, &res->capture_reg->l1isp.L1_SYSM_YCOEF_G);
+	writel((u32)coef_b, &res->capture_reg->l1isp.L1_SYSM_YCOEF_B);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_ag_mode() - Configure L1ISP AG mode.
+ *
+ * @param: pointer to struct hwd_viif_l1_ag_mode
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param" is NULL
+ * - each member of "param" is invalid
+ */
+s32 hwd_viif_l1_set_ag_mode(u32 module_id, const struct viif_l1_ag_mode_config *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	u32 val;
+
+	if (!param || param->sysm_ag_psel_hobc_high >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_hobc_middle_led >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_hobc_low >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_abpc_high >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_abpc_middle_led >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_abpc_low >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_rcnr_high >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_rcnr_middle_led >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_psel_rcnr_low >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_ssel_lssc >= HWD_VIIF_L1_SENSITIVITY_IMAGE_NUM ||
+	    param->sysm_ag_psel_lssc >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_ssel_mpro >= HWD_VIIF_L1_SENSITIVITY_IMAGE_NUM ||
+	    param->sysm_ag_psel_mpro >= HWD_VIIF_L1_AG_ID_NUM ||
+	    param->sysm_ag_ssel_vpro >= HWD_VIIF_L1_SENSITIVITY_IMAGE_NUM ||
+	    param->sysm_ag_psel_vpro >= HWD_VIIF_L1_AG_ID_NUM ||
+	    (param->sysm_ag_cont_hobc_en_high != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_hobc_en_high != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_hobc_en_middle_led != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_hobc_en_middle_led != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_hobc_en_low != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_hobc_en_low != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_rcnr_en_high != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_rcnr_en_high != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_rcnr_en_middle_led != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_rcnr_en_middle_led != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_rcnr_en_low != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_rcnr_en_low != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_lssc_en != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_lssc_en != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_mpro_en != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_mpro_en != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_vpro_en != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_vpro_en != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_abpc_en_middle_led != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_abpc_en_middle_led != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_abpc_en_high != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_abpc_en_high != HWD_VIIF_DISABLE) ||
+	    (param->sysm_ag_cont_abpc_en_low != HWD_VIIF_ENABLE &&
+	     param->sysm_ag_cont_abpc_en_low != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+
+	/* SYSM_AG_PARAM */
+	val = ((u32)param->sysm_ag_grad[0] << 16U) | ((u32)param->sysm_ag_ofst[0]);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_PARAM_A);
+	val = ((u32)param->sysm_ag_grad[1] << 16U) | ((u32)param->sysm_ag_ofst[1]);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_PARAM_B);
+	val = ((u32)param->sysm_ag_grad[2] << 16U) | ((u32)param->sysm_ag_ofst[2]);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_PARAM_C);
+	val = ((u32)param->sysm_ag_grad[3] << 16U) | ((u32)param->sysm_ag_ofst[3]);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_PARAM_D);
+
+	/* SYSM_AG_SEL */
+	val = ((u32)param->sysm_ag_psel_hobc_high << 6U) |
+	      ((u32)param->sysm_ag_psel_hobc_middle_led << 4U) |
+	      ((u32)param->sysm_ag_psel_hobc_low << 2U);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_SEL_HOBC);
+
+	val = ((u32)param->sysm_ag_psel_abpc_high << 6U) |
+	      ((u32)param->sysm_ag_psel_abpc_middle_led << 4U) |
+	      ((u32)param->sysm_ag_psel_abpc_low << 2U);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_SEL_ABPC);
+
+	val = ((u32)param->sysm_ag_psel_rcnr_high << 6U) |
+	      ((u32)param->sysm_ag_psel_rcnr_middle_led << 4U) |
+	      ((u32)param->sysm_ag_psel_rcnr_low << 2U);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_SEL_RCNR);
+
+	val = ((u32)param->sysm_ag_ssel_lssc << 2U) | ((u32)param->sysm_ag_psel_lssc);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_SEL_LSSC);
+
+	val = ((u32)param->sysm_ag_ssel_mpro << 2U) | ((u32)param->sysm_ag_psel_mpro);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_SEL_MPRO);
+
+	val = ((u32)param->sysm_ag_ssel_vpro << 2U) | ((u32)param->sysm_ag_psel_vpro);
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_SEL_VPRO);
+
+	/* SYSM_AG_CONT */
+	val = (param->sysm_ag_cont_hobc_en_middle_led << 24U) |
+	      ((u32)(param->sysm_ag_cont_hobc_test_middle_led) << 16U) |
+	      (param->sysm_ag_cont_hobc_en_high << 8U) | (u32)param->sysm_ag_cont_hobc_test_high;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_HOBC01_EN);
+	val = (param->sysm_ag_cont_hobc_en_low << 8U) | (u32)param->sysm_ag_cont_hobc_test_low;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_HOBC2_EN);
+
+	val = (param->sysm_ag_cont_abpc_en_middle_led << 24U) |
+	      ((u32)(param->sysm_ag_cont_abpc_test_middle_led) << 16U) |
+	      (param->sysm_ag_cont_abpc_en_high << 8U) | (u32)param->sysm_ag_cont_abpc_test_high;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_ABPC01_EN);
+	val = (param->sysm_ag_cont_abpc_en_low << 8U) | (u32)param->sysm_ag_cont_abpc_test_low;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_ABPC2_EN);
+
+	val = (param->sysm_ag_cont_rcnr_en_middle_led << 24U) |
+	      ((u32)(param->sysm_ag_cont_rcnr_test_middle_led) << 16U) |
+	      (param->sysm_ag_cont_rcnr_en_high << 8U) | (u32)param->sysm_ag_cont_rcnr_test_high;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_RCNR01_EN);
+	val = (param->sysm_ag_cont_rcnr_en_low << 8U) | (u32)param->sysm_ag_cont_rcnr_test_low;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_RCNR2_EN);
+
+	val = (param->sysm_ag_cont_lssc_en << 8U) | (u32)param->sysm_ag_cont_lssc_test;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_LSSC_EN);
+
+	val = (param->sysm_ag_cont_mpro_en << 8U) | (u32)param->sysm_ag_cont_mpro_test;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_MPRO_EN);
+
+	val = (param->sysm_ag_cont_vpro_en << 8U) | (u32)param->sysm_ag_cont_vpro_test;
+	writel(val, &res->capture_reg->l1isp.L1_SYSM_AG_CONT_VPRO_EN);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_ag() - Configure L1ISP analog gain.
+ *
+ * @gain_h: analog gain value for high sensitivity image [0..65535]
+ * @gain_m: analog gain value for middle sensitivity or led image [0..65535]
+ * @gain_l: analog gain value for low sensitivity image [0..65535]
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ */
+s32 hwd_viif_l1_set_ag(u32 module_id, u16 gain_h, u16 gain_m, u16 gain_l)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	writel((u32)gain_h, &res->capture_reg->l1isp.L1_SYSM_AG_H);
+	writel((u32)gain_m, &res->capture_reg->l1isp.L1_SYSM_AG_M);
+	writel((u32)gain_l, &res->capture_reg->l1isp.L1_SYSM_AG_L);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_hdre() - Configure L1ISP HDR extension parameters.
+ *
+ * @param: pointer to struct hwd_viif_l1_hdre
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param" is NULL
+ * - each member of "param" is invalid
+ */
+s32 hwd_viif_l1_set_hdre(u32 module_id, const struct viif_l1_hdre_config *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 idx;
+
+	if (!param)
+		return -EINVAL;
+
+	for (idx = 0; idx < 16U; idx++) {
+		if (param->hdre_src_point[idx] > HWD_VIIF_L1_HDRE_MAX_KNEEPOINT_VAL)
+			return -EINVAL;
+	}
+
+	for (idx = 0; idx < 17U; idx++) {
+		if (param->hdre_dst_base[idx] > HWD_VIIF_L1_HDRE_MAX_HDRE_SIG_VAL ||
+		    param->hdre_ratio[idx] >= HWD_VIIF_L1_HDRE_MAX_OUT_PIXEL_RATIO) {
+			return -EINVAL;
+		}
+	}
+
+	if (param->hdre_dst_max_val > HWD_VIIF_L1_HDRE_MAX_OUT_PIXEL_VAL)
+		return -EINVAL;
+
+	writel(param->hdre_src_point[0], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT00);
+	writel(param->hdre_src_point[1], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT01);
+	writel(param->hdre_src_point[2], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT02);
+	writel(param->hdre_src_point[3], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT03);
+	writel(param->hdre_src_point[4], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT04);
+	writel(param->hdre_src_point[5], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT05);
+	writel(param->hdre_src_point[6], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT06);
+	writel(param->hdre_src_point[7], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT07);
+	writel(param->hdre_src_point[8], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT08);
+	writel(param->hdre_src_point[9], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT09);
+	writel(param->hdre_src_point[10], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT10);
+	writel(param->hdre_src_point[11], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT11);
+	writel(param->hdre_src_point[12], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT12);
+	writel(param->hdre_src_point[13], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT13);
+	writel(param->hdre_src_point[14], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT14);
+	writel(param->hdre_src_point[15], &res->capture_reg->l1isp.L1_HDRE_SRCPOINT15);
+
+	writel(0, &res->capture_reg->l1isp.L1_HDRE_SRCBASE00);
+	writel(param->hdre_src_point[0], &res->capture_reg->l1isp.L1_HDRE_SRCBASE01);
+	writel(param->hdre_src_point[1], &res->capture_reg->l1isp.L1_HDRE_SRCBASE02);
+	writel(param->hdre_src_point[2], &res->capture_reg->l1isp.L1_HDRE_SRCBASE03);
+	writel(param->hdre_src_point[3], &res->capture_reg->l1isp.L1_HDRE_SRCBASE04);
+	writel(param->hdre_src_point[4], &res->capture_reg->l1isp.L1_HDRE_SRCBASE05);
+	writel(param->hdre_src_point[5], &res->capture_reg->l1isp.L1_HDRE_SRCBASE06);
+	writel(param->hdre_src_point[6], &res->capture_reg->l1isp.L1_HDRE_SRCBASE07);
+	writel(param->hdre_src_point[7], &res->capture_reg->l1isp.L1_HDRE_SRCBASE08);
+	writel(param->hdre_src_point[8], &res->capture_reg->l1isp.L1_HDRE_SRCBASE09);
+	writel(param->hdre_src_point[9], &res->capture_reg->l1isp.L1_HDRE_SRCBASE10);
+	writel(param->hdre_src_point[10], &res->capture_reg->l1isp.L1_HDRE_SRCBASE11);
+	writel(param->hdre_src_point[11], &res->capture_reg->l1isp.L1_HDRE_SRCBASE12);
+	writel(param->hdre_src_point[12], &res->capture_reg->l1isp.L1_HDRE_SRCBASE13);
+	writel(param->hdre_src_point[13], &res->capture_reg->l1isp.L1_HDRE_SRCBASE14);
+	writel(param->hdre_src_point[14], &res->capture_reg->l1isp.L1_HDRE_SRCBASE15);
+	writel(param->hdre_src_point[15], &res->capture_reg->l1isp.L1_HDRE_SRCBASE16);
+
+	writel(param->hdre_dst_base[0], &res->capture_reg->l1isp.L1_HDRE_DSTBASE00);
+	writel(param->hdre_dst_base[1], &res->capture_reg->l1isp.L1_HDRE_DSTBASE01);
+	writel(param->hdre_dst_base[2], &res->capture_reg->l1isp.L1_HDRE_DSTBASE02);
+	writel(param->hdre_dst_base[3], &res->capture_reg->l1isp.L1_HDRE_DSTBASE03);
+	writel(param->hdre_dst_base[4], &res->capture_reg->l1isp.L1_HDRE_DSTBASE04);
+	writel(param->hdre_dst_base[5], &res->capture_reg->l1isp.L1_HDRE_DSTBASE05);
+	writel(param->hdre_dst_base[6], &res->capture_reg->l1isp.L1_HDRE_DSTBASE06);
+	writel(param->hdre_dst_base[7], &res->capture_reg->l1isp.L1_HDRE_DSTBASE07);
+	writel(param->hdre_dst_base[8], &res->capture_reg->l1isp.L1_HDRE_DSTBASE08);
+	writel(param->hdre_dst_base[9], &res->capture_reg->l1isp.L1_HDRE_DSTBASE09);
+	writel(param->hdre_dst_base[10], &res->capture_reg->l1isp.L1_HDRE_DSTBASE10);
+	writel(param->hdre_dst_base[11], &res->capture_reg->l1isp.L1_HDRE_DSTBASE11);
+	writel(param->hdre_dst_base[12], &res->capture_reg->l1isp.L1_HDRE_DSTBASE12);
+	writel(param->hdre_dst_base[13], &res->capture_reg->l1isp.L1_HDRE_DSTBASE13);
+	writel(param->hdre_dst_base[14], &res->capture_reg->l1isp.L1_HDRE_DSTBASE14);
+	writel(param->hdre_dst_base[15], &res->capture_reg->l1isp.L1_HDRE_DSTBASE15);
+	writel(param->hdre_dst_base[16], &res->capture_reg->l1isp.L1_HDRE_DSTBASE16);
+
+	writel(param->hdre_ratio[0], &res->capture_reg->l1isp.L1_HDRE_RATIO00);
+	writel(param->hdre_ratio[1], &res->capture_reg->l1isp.L1_HDRE_RATIO01);
+	writel(param->hdre_ratio[2], &res->capture_reg->l1isp.L1_HDRE_RATIO02);
+	writel(param->hdre_ratio[3], &res->capture_reg->l1isp.L1_HDRE_RATIO03);
+	writel(param->hdre_ratio[4], &res->capture_reg->l1isp.L1_HDRE_RATIO04);
+	writel(param->hdre_ratio[5], &res->capture_reg->l1isp.L1_HDRE_RATIO05);
+	writel(param->hdre_ratio[6], &res->capture_reg->l1isp.L1_HDRE_RATIO06);
+	writel(param->hdre_ratio[7], &res->capture_reg->l1isp.L1_HDRE_RATIO07);
+	writel(param->hdre_ratio[8], &res->capture_reg->l1isp.L1_HDRE_RATIO08);
+	writel(param->hdre_ratio[9], &res->capture_reg->l1isp.L1_HDRE_RATIO09);
+	writel(param->hdre_ratio[10], &res->capture_reg->l1isp.L1_HDRE_RATIO10);
+	writel(param->hdre_ratio[11], &res->capture_reg->l1isp.L1_HDRE_RATIO11);
+	writel(param->hdre_ratio[12], &res->capture_reg->l1isp.L1_HDRE_RATIO12);
+	writel(param->hdre_ratio[13], &res->capture_reg->l1isp.L1_HDRE_RATIO13);
+	writel(param->hdre_ratio[14], &res->capture_reg->l1isp.L1_HDRE_RATIO14);
+	writel(param->hdre_ratio[15], &res->capture_reg->l1isp.L1_HDRE_RATIO15);
+	writel(param->hdre_ratio[16], &res->capture_reg->l1isp.L1_HDRE_RATIO16);
+
+	writel(param->hdre_dst_max_val, &res->capture_reg->l1isp.L1_HDRE_DSTMAXVAL);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_img_extraction() - Configure L1ISP image extraction parameters.
+ *
+ * @input_black_gr: black level of Gr input pixel [0x0..0xffffff]
+ * @input_black_r: black level of R input pixel [0x0..0xffffff]
+ * @input_black_b: black level of B input pixel [0x0..0xffffff]
+ * @input_black_gb: black level of Gb input pixel [0x0..0xffffff]
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "input_black_gr" is out of range
+ * - "input_black_r" is out of range
+ * - "input_black_b" is out of range
+ * - "input_black_gb" is out of range
+ */
+s32 hwd_viif_l1_set_img_extraction(u32 module_id, u32 input_black_gr, u32 input_black_r,
+				   u32 input_black_b, u32 input_black_gb)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (input_black_gr > HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL ||
+	    input_black_r > HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL ||
+	    input_black_b > HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL ||
+	    input_black_gb > HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL) {
+		return -EINVAL;
+	}
+
+	writel(input_black_gr, &res->capture_reg->l1isp.L1_SLIC_SRCBLACKLEVEL_GR);
+	writel(input_black_r, &res->capture_reg->l1isp.L1_SLIC_SRCBLACKLEVEL_R);
+	writel(input_black_b, &res->capture_reg->l1isp.L1_SLIC_SRCBLACKLEVEL_B);
+	writel(input_black_gb, &res->capture_reg->l1isp.L1_SLIC_SRCBLACKLEVEL_GB);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_dpc() - Configure L1ISP defect pixel correction parameters.
+ *
+ * @param_h: pointer to defect pixel correction parameters for high sensitivity image
+ * @param_m: pointer to defect pixel correction parameters for middle sensitivity or led image
+ * @param_l: pointer to defect pixel correction parameters for low sensitivity image
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param_h", "param_m" and "param_l" are NULL
+ * - each member of "param_h" is invalid
+ * - each member of "param_m" is invalid
+ * - each member of "param_l" is invalid
+ */
+s32 hwd_viif_l1_set_dpc(u32 module_id, const struct viif_l1_dpc *param_h,
+			const struct viif_l1_dpc *param_m, const struct viif_l1_dpc *param_l)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	const struct viif_l1_dpc *param;
+	u32 idx;
+	u32 val;
+
+	if (!param_h && !param_m && !param_l)
+		return -EINVAL;
+
+	for (idx = 0U; idx < 3U; idx++) {
+		if (idx == 0U)
+			param = param_h;
+		else if (idx == 1U)
+			param = param_m;
+		else
+			param = param_l;
+
+		if (!param)
+			continue;
+
+		if ((param->abpc_sta_en != HWD_VIIF_ENABLE &&
+		     param->abpc_sta_en != HWD_VIIF_DISABLE) ||
+		    (param->abpc_dyn_en != HWD_VIIF_ENABLE &&
+		     param->abpc_dyn_en != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if (param->abpc_dyn_en != HWD_VIIF_ENABLE)
+			continue;
+
+		if ((param->abpc_dyn_mode != HWD_VIIF_L1_DPC_1PIXEL &&
+		     param->abpc_dyn_mode != HWD_VIIF_L1_DPC_2PIXEL) ||
+		    param->abpc_ratio_limit > HWD_VIIF_L1_DPC_MAX_RATIO_LIMIT_VAL ||
+		    param->abpc_dark_limit > HWD_VIIF_L1_DPC_MAX_RATIO_LIMIT_VAL ||
+		    param->abpc_sn_coef_w_ag_min < HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_w_ag_min > HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_w_ag_mid < HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_w_ag_mid > HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_w_ag_max < HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_w_ag_max > HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_b_ag_min < HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_b_ag_min > HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_b_ag_mid < HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_b_ag_mid > HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_b_ag_max < HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_b_ag_max > HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL ||
+		    param->abpc_sn_coef_w_th_min >= param->abpc_sn_coef_w_th_max ||
+		    param->abpc_sn_coef_b_th_min >= param->abpc_sn_coef_b_th_max) {
+			return -EINVAL;
+		}
+	}
+
+	val = 0;
+	if (param_h)
+		val |= param_h->abpc_sta_en << 24U;
+
+	if (param_m)
+		val |= param_m->abpc_sta_en << 16U;
+
+	if (param_l)
+		val |= param_l->abpc_sta_en << 8U;
+
+	writel(val, &res->capture_reg->l1isp.L1_ABPC012_STA_EN);
+
+	val = 0;
+	if (param_h)
+		val |= param_h->abpc_dyn_en << 24U;
+
+	if (param_m)
+		val |= param_m->abpc_dyn_en << 16U;
+
+	if (param_l)
+		val |= param_l->abpc_dyn_en << 8U;
+
+	writel(val, &res->capture_reg->l1isp.L1_ABPC012_DYN_EN);
+
+	val = 0;
+	if (param_h)
+		val |= param_h->abpc_dyn_mode << 24U;
+
+	if (param_m)
+		val |= param_m->abpc_dyn_mode << 16U;
+
+	if (param_l)
+		val |= param_l->abpc_dyn_mode << 8U;
+
+	writel(val, &res->capture_reg->l1isp.L1_ABPC012_DYN_MODE);
+
+	if (param_h) {
+		writel(param_h->abpc_ratio_limit, &res->capture_reg->l1isp.L1_ABPC0_RATIO_LIMIT);
+		writel(param_h->abpc_dark_limit, &res->capture_reg->l1isp.L1_ABPC0_DARK_LIMIT);
+		writel(param_h->abpc_sn_coef_w_ag_min,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_AG_MIN);
+		writel(param_h->abpc_sn_coef_w_ag_mid,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_AG_MID);
+		writel(param_h->abpc_sn_coef_w_ag_max,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_AG_MAX);
+		writel(param_h->abpc_sn_coef_b_ag_min,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_AG_MIN);
+		writel(param_h->abpc_sn_coef_b_ag_mid,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_AG_MID);
+		writel(param_h->abpc_sn_coef_b_ag_max,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_AG_MAX);
+		writel((u32)param_h->abpc_sn_coef_w_th_min,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_TH_MIN);
+		writel((u32)param_h->abpc_sn_coef_w_th_max,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_TH_MAX);
+		writel((u32)param_h->abpc_sn_coef_b_th_min,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_TH_MIN);
+		writel((u32)param_h->abpc_sn_coef_b_th_max,
+		       &res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_TH_MAX);
+	}
+
+	if (param_m) {
+		writel(param_m->abpc_ratio_limit, &res->capture_reg->l1isp.L1_ABPC1_RATIO_LIMIT);
+		writel(param_m->abpc_dark_limit, &res->capture_reg->l1isp.L1_ABPC1_DARK_LIMIT);
+		writel(param_m->abpc_sn_coef_w_ag_min,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_AG_MIN);
+		writel(param_m->abpc_sn_coef_w_ag_mid,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_AG_MID);
+		writel(param_m->abpc_sn_coef_w_ag_max,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_AG_MAX);
+		writel(param_m->abpc_sn_coef_b_ag_min,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_AG_MIN);
+		writel(param_m->abpc_sn_coef_b_ag_mid,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_AG_MID);
+		writel(param_m->abpc_sn_coef_b_ag_max,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_AG_MAX);
+		writel((u32)param_m->abpc_sn_coef_w_th_min,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_TH_MIN);
+		writel((u32)param_m->abpc_sn_coef_w_th_max,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_TH_MAX);
+		writel((u32)param_m->abpc_sn_coef_b_th_min,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_TH_MIN);
+		writel((u32)param_m->abpc_sn_coef_b_th_max,
+		       &res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_TH_MAX);
+	}
+
+	if (param_l) {
+		writel(param_l->abpc_ratio_limit, &res->capture_reg->l1isp.L1_ABPC2_RATIO_LIMIT);
+		writel(param_l->abpc_dark_limit, &res->capture_reg->l1isp.L1_ABPC2_DARK_LIMIT);
+		writel(param_l->abpc_sn_coef_w_ag_min,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_AG_MIN);
+		writel(param_l->abpc_sn_coef_w_ag_mid,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_AG_MID);
+		writel(param_l->abpc_sn_coef_w_ag_max,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_AG_MAX);
+		writel(param_l->abpc_sn_coef_b_ag_min,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_AG_MIN);
+		writel(param_l->abpc_sn_coef_b_ag_mid,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_AG_MID);
+		writel(param_l->abpc_sn_coef_b_ag_max,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_AG_MAX);
+		writel((u32)param_l->abpc_sn_coef_w_th_min,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_TH_MIN);
+		writel((u32)param_l->abpc_sn_coef_w_th_max,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_TH_MAX);
+		writel((u32)param_l->abpc_sn_coef_b_th_min,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_TH_MIN);
+		writel((u32)param_l->abpc_sn_coef_b_th_max,
+		       &res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_TH_MAX);
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_dpc_table_transmission() -
+ *  Configure L1ISP transferring defect pixel correction table.
+ *
+ * @table_h: defect pixel correction table for high sensitivity image(physical address)
+ * @table_m: defect pixel correction table for middle sensitivity or led image(physical address)
+ * @table_l: defect pixel correction table for low sensitivity image(physical address)
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "table_h", "table_m" or "table_l" is not 8byte alignment
+ *
+ * Note that when 0 is set to table address, table transfer of the table is disabled.
+ */
+s32 hwd_viif_l1_set_dpc_table_transmission(u32 module_id, uintptr_t table_h, uintptr_t table_m,
+					   uintptr_t table_l)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val = 0x0U;
+
+	if (((table_h % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_m % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_l % HWD_VIIF_L1_VDM_ALIGN) != 0U)) {
+		return -EINVAL;
+	}
+
+	/* VDM common settings */
+
+	writel(HWD_VIIF_L1_VDM_CFG_PARAM, &res->capture_reg->vdm.t_group[0].VDM_T_CFG);
+	writel(HWD_VIIF_L1_VDM_SRAM_BASE, &res->capture_reg->vdm.t_group[0].VDM_T_SRAM_BASE);
+	writel(HWD_VIIF_L1_VDM_SRAM_SIZE, &res->capture_reg->vdm.t_group[0].VDM_T_SRAM_SIZE);
+
+	if (table_h != 0U) {
+		writel((u32)table_h, &res->capture_reg->vdm.t_port[0].VDM_T_STADR);
+		writel(HWD_VIIF_L1_VDM_DPC_TABLE_SIZE, &res->capture_reg->vdm.t_port[0].VDM_T_SIZE);
+		val |= 0x1U;
+	}
+
+	if (table_m != 0U) {
+		writel((u32)table_m, &res->capture_reg->vdm.t_port[1].VDM_T_STADR);
+		writel(HWD_VIIF_L1_VDM_DPC_TABLE_SIZE, &res->capture_reg->vdm.t_port[1].VDM_T_SIZE);
+		val |= 0x2U;
+	}
+
+	if (table_l != 0U) {
+		writel((u32)table_l, &res->capture_reg->vdm.t_port[2].VDM_T_STADR);
+		writel(HWD_VIIF_L1_VDM_DPC_TABLE_SIZE, &res->capture_reg->vdm.t_port[2].VDM_T_SIZE);
+		val |= 0x4U;
+	}
+
+	val |= (readl(&res->capture_reg->vdm.VDM_T_ENABLE) & 0xfffffff8U);
+	writel(val, &res->capture_reg->vdm.VDM_T_ENABLE);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_preset_white_balance() - Configure L1ISP preset white balance parameters.
+ *
+ * @dstmaxval: maximum output pixel value [0..4095]
+ * @param_h: pointer to preset white balance parameters for high sensitivity image
+ * @param_m: pointer to preset white balance parameters for middle sensitivity or led image
+ * @param_l: pointer to preset white balance parameters for low sensitivity image
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "dstmaxval" is out of range
+ * - "param_h", "param_m", and "param_l" are NULL
+ * - each parameter of "param_h" is out of range
+ * - each parameter of "param_m" is out of range
+ * - each parameter of "param_l" is out of range
+ * Note that when NULL is set to "param_{h/m/l}", the corresponding parameters are not set to HW.
+ */
+s32 hwd_viif_l1_set_preset_white_balance(u32 module_id, u32 dstmaxval,
+					 const struct viif_l1_preset_wb *param_h,
+					 const struct viif_l1_preset_wb *param_m,
+					 const struct viif_l1_preset_wb *param_l)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (dstmaxval > HWD_VIIF_L1_PWHB_MAX_OUT_PIXEL_VAL || (!param_h && !param_m && !param_l))
+		return -EINVAL;
+
+	if (param_h) {
+		if (param_h->gain_gr >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_h->gain_r >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_h->gain_b >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_h->gain_gb >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL) {
+			return -EINVAL;
+		}
+	}
+
+	if (param_m) {
+		if (param_m->gain_gr >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_m->gain_r >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_m->gain_b >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_m->gain_gb >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL) {
+			return -EINVAL;
+		}
+	}
+
+	if (param_l) {
+		if (param_l->gain_gr >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_l->gain_r >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_l->gain_b >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL ||
+		    param_l->gain_gb >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL) {
+			return -EINVAL;
+		}
+	}
+
+	writel(dstmaxval, &res->capture_reg->l1isp.L1_PWHB_DSTMAXVAL);
+
+	if (param_h) {
+		writel(param_h->gain_gr, &res->capture_reg->l1isp.L1_PWHB_H_GR);
+		writel(param_h->gain_r, &res->capture_reg->l1isp.L1_PWHB_HR);
+		writel(param_h->gain_b, &res->capture_reg->l1isp.L1_PWHB_HB);
+		writel(param_h->gain_gb, &res->capture_reg->l1isp.L1_PWHB_H_GB);
+	}
+
+	if (param_m) {
+		writel(param_m->gain_gr, &res->capture_reg->l1isp.L1_PWHB_M_GR);
+		writel(param_m->gain_r, &res->capture_reg->l1isp.L1_PWHB_MR);
+		writel(param_m->gain_b, &res->capture_reg->l1isp.L1_PWHB_MB);
+		writel(param_m->gain_gb, &res->capture_reg->l1isp.L1_PWHB_M_GB);
+	}
+
+	if (param_l) {
+		writel(param_l->gain_gr, &res->capture_reg->l1isp.L1_PWHB_L_GR);
+		writel(param_l->gain_r, &res->capture_reg->l1isp.L1_PWHB_LR);
+		writel(param_l->gain_b, &res->capture_reg->l1isp.L1_PWHB_LB);
+		writel(param_l->gain_gb, &res->capture_reg->l1isp.L1_PWHB_L_GB);
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_raw_color_noise_reduction() -
+ *  Configure L1ISP raw color noise reduction parameters.
+ *
+ * @param_h: pointer to raw color noise reduction parameters for high sensitivity image
+ * @param_m: pointer to raw color noise reduction parameters for middle sensitivity or led image
+ * @param_l: pointer to raw color noise reduction parameters for low sensitivity image
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param_h", "param_m", and "param_l" are NULL
+ * - each parameter of "param_h" is out of range
+ * - each parameter of "param_m" is out of range
+ * - each parameter of "param_l" is out of range
+ * Note that when NULL is set to "param_{h/m/l}", the corresponding parameters are not set to HW.
+ */
+s32 hwd_viif_l1_set_raw_color_noise_reduction(
+	u32 module_id, const struct viif_l1_raw_color_noise_reduction *param_h,
+	const struct viif_l1_raw_color_noise_reduction *param_m,
+	const struct viif_l1_raw_color_noise_reduction *param_l)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	const struct viif_l1_raw_color_noise_reduction *param;
+	u32 idx;
+
+	if (!param_h && !param_m && !param_l)
+		return -EINVAL;
+
+	for (idx = 0; idx < 3U; idx++) {
+		if (idx == 0U)
+			param = param_h;
+		else if (idx == 1U)
+			param = param_m;
+		else
+			param = param_l;
+
+		if (!param)
+			continue;
+
+		if (param->rcnr_sw != HWD_VIIF_ENABLE && param->rcnr_sw != HWD_VIIF_DISABLE)
+			return -EINVAL;
+
+		if (param->rcnr_cnf_dark_ag0 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL ||
+		    param->rcnr_cnf_dark_ag1 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL ||
+		    param->rcnr_cnf_dark_ag2 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL ||
+		    param->rcnr_cnf_ratio_ag0 > HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL ||
+		    param->rcnr_cnf_ratio_ag1 > HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL ||
+		    param->rcnr_cnf_ratio_ag2 > HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL ||
+		    param->rcnr_cnf_clip_gain_r > HWD_VIIF_L1_RCNR_MAX_ADJUSTMENT_GAIN_VAL ||
+		    param->rcnr_cnf_clip_gain_g > HWD_VIIF_L1_RCNR_MAX_ADJUSTMENT_GAIN_VAL ||
+		    param->rcnr_cnf_clip_gain_b > HWD_VIIF_L1_RCNR_MAX_ADJUSTMENT_GAIN_VAL ||
+		    param->rcnr_a1l_dark_ag0 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL ||
+		    param->rcnr_a1l_dark_ag1 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL ||
+		    param->rcnr_a1l_dark_ag2 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL ||
+		    param->rcnr_a1l_ratio_ag0 > HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL ||
+		    param->rcnr_a1l_ratio_ag1 > HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL ||
+		    param->rcnr_a1l_ratio_ag2 > HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL ||
+		    param->rcnr_inf_zero_clip > HWD_VIIF_L1_RCNR_MAX_ZERO_CLIP_VAL ||
+		    param->rcnr_merge_d2blend_ag0 > HWD_VIIF_L1_RCNR_MAX_BLEND_VAL ||
+		    param->rcnr_merge_d2blend_ag1 > HWD_VIIF_L1_RCNR_MAX_BLEND_VAL ||
+		    param->rcnr_merge_d2blend_ag2 > HWD_VIIF_L1_RCNR_MAX_BLEND_VAL ||
+		    param->rcnr_merge_black > HWD_VIIF_L1_RCNR_MAX_BLACK_LEVEL_VAL ||
+		    param->rcnr_merge_mindiv < HWD_VIIF_L1_RCNR_MIN_0DIV_GUARD_VAL ||
+		    param->rcnr_merge_mindiv > HWD_VIIF_L1_RCNR_MAX_0DIV_GUARD_VAL) {
+			return -EINVAL;
+		}
+
+		switch (param->rcnr_hry_type) {
+		case HWD_VIIF_L1_RCNR_LOW_RESOLUTION:
+		case HWD_VIIF_L1_RCNR_MIDDLE_RESOLUTION:
+		case HWD_VIIF_L1_RCNR_HIGH_RESOLUTION:
+		case HWD_VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (param->rcnr_anf_blend_ag0 != HWD_VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 &&
+		    param->rcnr_anf_blend_ag0 != HWD_VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 &&
+		    param->rcnr_anf_blend_ag0 != HWD_VIIF_L1_MSF_BLEND_RATIO_2_DIV_64) {
+			return -EINVAL;
+		}
+		if (param->rcnr_anf_blend_ag1 != HWD_VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 &&
+		    param->rcnr_anf_blend_ag1 != HWD_VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 &&
+		    param->rcnr_anf_blend_ag1 != HWD_VIIF_L1_MSF_BLEND_RATIO_2_DIV_64) {
+			return -EINVAL;
+		}
+		if (param->rcnr_anf_blend_ag2 != HWD_VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 &&
+		    param->rcnr_anf_blend_ag2 != HWD_VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 &&
+		    param->rcnr_anf_blend_ag2 != HWD_VIIF_L1_MSF_BLEND_RATIO_2_DIV_64) {
+			return -EINVAL;
+		}
+
+		if (param->rcnr_lpf_threshold >= HWD_VIIF_L1_RCNR_MAX_CALC_MSF_NOISE_MULTI_VAL ||
+		    param->rcnr_merge_hlblend_ag0 > HWD_VIIF_L1_RCNR_MAX_GEN_LUMA_SIG_BLEND_VAL ||
+		    param->rcnr_merge_hlblend_ag1 > HWD_VIIF_L1_RCNR_MAX_GEN_LUMA_SIG_BLEND_VAL ||
+		    param->rcnr_merge_hlblend_ag2 > HWD_VIIF_L1_RCNR_MAX_GEN_LUMA_SIG_BLEND_VAL ||
+		    (param->rcnr_gnr_sw != HWD_VIIF_DISABLE &&
+		     param->rcnr_gnr_sw != HWD_VIIF_ENABLE)) {
+			return -EINVAL;
+		}
+
+		if (param->rcnr_gnr_sw == HWD_VIIF_ENABLE) {
+			if (param->rcnr_gnr_ratio > HWD_VIIF_L1_RCNR_MAX_UP_LIMIT_GRGB_SENS_RATIO)
+				return -EINVAL;
+			if (param->rcnr_gnr_wide_en != HWD_VIIF_DISABLE &&
+			    param->rcnr_gnr_wide_en != HWD_VIIF_ENABLE) {
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (param_h) {
+		writel(param_h->rcnr_sw, &res->capture_reg->l1isp.L1_RCNR0_SW);
+
+		writel(param_h->rcnr_cnf_dark_ag0, &res->capture_reg->l1isp.L1_RCNR0_CNF_DARK_AG0);
+		writel(param_h->rcnr_cnf_dark_ag1, &res->capture_reg->l1isp.L1_RCNR0_CNF_DARK_AG1);
+		writel(param_h->rcnr_cnf_dark_ag2, &res->capture_reg->l1isp.L1_RCNR0_CNF_DARK_AG2);
+
+		writel(param_h->rcnr_cnf_ratio_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR0_CNF_RATIO_AG0);
+		writel(param_h->rcnr_cnf_ratio_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR0_CNF_RATIO_AG1);
+		writel(param_h->rcnr_cnf_ratio_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR0_CNF_RATIO_AG2);
+
+		writel(param_h->rcnr_cnf_clip_gain_r,
+		       &res->capture_reg->l1isp.L1_RCNR0_CNF_CLIP_GAIN_R);
+		writel(param_h->rcnr_cnf_clip_gain_g,
+		       &res->capture_reg->l1isp.L1_RCNR0_CNF_CLIP_GAIN_G);
+		writel(param_h->rcnr_cnf_clip_gain_b,
+		       &res->capture_reg->l1isp.L1_RCNR0_CNF_CLIP_GAIN_B);
+
+		writel(param_h->rcnr_a1l_dark_ag0, &res->capture_reg->l1isp.L1_RCNR0_A1L_DARK_AG0);
+		writel(param_h->rcnr_a1l_dark_ag1, &res->capture_reg->l1isp.L1_RCNR0_A1L_DARK_AG1);
+		writel(param_h->rcnr_a1l_dark_ag2, &res->capture_reg->l1isp.L1_RCNR0_A1L_DARK_AG2);
+
+		writel(param_h->rcnr_a1l_ratio_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR0_A1L_RATIO_AG0);
+		writel(param_h->rcnr_a1l_ratio_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR0_A1L_RATIO_AG1);
+		writel(param_h->rcnr_a1l_ratio_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR0_A1L_RATIO_AG2);
+
+		writel(param_h->rcnr_inf_zero_clip,
+		       &res->capture_reg->l1isp.L1_RCNR0_INF_ZERO_CLIP);
+
+		writel(param_h->rcnr_merge_d2blend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR0_MERGE_D2BLEND_AG0);
+		writel(param_h->rcnr_merge_d2blend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR0_MERGE_D2BLEND_AG1);
+		writel(param_h->rcnr_merge_d2blend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR0_MERGE_D2BLEND_AG2);
+		writel(param_h->rcnr_merge_black, &res->capture_reg->l1isp.L1_RCNR0_MERGE_BLACK);
+		writel(param_h->rcnr_merge_mindiv, &res->capture_reg->l1isp.L1_RCNR0_MERGE_MINDIV);
+
+		writel(param_h->rcnr_hry_type, &res->capture_reg->l1isp.L1_RCNR0_HRY_TYPE);
+
+		writel(param_h->rcnr_anf_blend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR0_ANF_BLEND_AG0);
+		writel(param_h->rcnr_anf_blend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR0_ANF_BLEND_AG1);
+		writel(param_h->rcnr_anf_blend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR0_ANF_BLEND_AG2);
+
+		writel(param_h->rcnr_lpf_threshold,
+		       &res->capture_reg->l1isp.L1_RCNR0_LPF_THRESHOLD);
+
+		writel(param_h->rcnr_merge_hlblend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR0_MERGE_HLBLEND_AG0);
+		writel(param_h->rcnr_merge_hlblend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR0_MERGE_HLBLEND_AG1);
+		writel(param_h->rcnr_merge_hlblend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR0_MERGE_HLBLEND_AG2);
+
+		writel(param_h->rcnr_gnr_sw, &res->capture_reg->l1isp.L1_RCNR0_GNR_SW);
+
+		if (param_h->rcnr_gnr_sw == HWD_VIIF_ENABLE) {
+			writel(param_h->rcnr_gnr_ratio,
+			       &res->capture_reg->l1isp.L1_RCNR0_GNR_RATIO);
+			writel(param_h->rcnr_gnr_wide_en,
+			       &res->capture_reg->l1isp.L1_RCNR0_GNR_WIDE_EN);
+		}
+	}
+
+	if (param_m) {
+		writel(param_m->rcnr_sw, &res->capture_reg->l1isp.L1_RCNR1_SW);
+
+		writel(param_m->rcnr_cnf_dark_ag0, &res->capture_reg->l1isp.L1_RCNR1_CNF_DARK_AG0);
+		writel(param_m->rcnr_cnf_dark_ag1, &res->capture_reg->l1isp.L1_RCNR1_CNF_DARK_AG1);
+		writel(param_m->rcnr_cnf_dark_ag2, &res->capture_reg->l1isp.L1_RCNR1_CNF_DARK_AG2);
+
+		writel(param_m->rcnr_cnf_ratio_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR1_CNF_RATIO_AG0);
+		writel(param_m->rcnr_cnf_ratio_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR1_CNF_RATIO_AG1);
+		writel(param_m->rcnr_cnf_ratio_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR1_CNF_RATIO_AG2);
+
+		writel(param_m->rcnr_cnf_clip_gain_r,
+		       &res->capture_reg->l1isp.L1_RCNR1_CNF_CLIP_GAIN_R);
+		writel(param_m->rcnr_cnf_clip_gain_g,
+		       &res->capture_reg->l1isp.L1_RCNR1_CNF_CLIP_GAIN_G);
+		writel(param_m->rcnr_cnf_clip_gain_b,
+		       &res->capture_reg->l1isp.L1_RCNR1_CNF_CLIP_GAIN_B);
+
+		writel(param_m->rcnr_a1l_dark_ag0, &res->capture_reg->l1isp.L1_RCNR1_A1L_DARK_AG0);
+		writel(param_m->rcnr_a1l_dark_ag1, &res->capture_reg->l1isp.L1_RCNR1_A1L_DARK_AG1);
+		writel(param_m->rcnr_a1l_dark_ag2, &res->capture_reg->l1isp.L1_RCNR1_A1L_DARK_AG2);
+
+		writel(param_m->rcnr_a1l_ratio_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR1_A1L_RATIO_AG0);
+		writel(param_m->rcnr_a1l_ratio_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR1_A1L_RATIO_AG1);
+		writel(param_m->rcnr_a1l_ratio_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR1_A1L_RATIO_AG2);
+
+		writel(param_m->rcnr_inf_zero_clip,
+		       &res->capture_reg->l1isp.L1_RCNR1_INF_ZERO_CLIP);
+
+		writel(param_m->rcnr_merge_d2blend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR1_MERGE_D2BLEND_AG0);
+		writel(param_m->rcnr_merge_d2blend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR1_MERGE_D2BLEND_AG1);
+		writel(param_m->rcnr_merge_d2blend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR1_MERGE_D2BLEND_AG2);
+		writel(param_m->rcnr_merge_black, &res->capture_reg->l1isp.L1_RCNR1_MERGE_BLACK);
+		writel(param_m->rcnr_merge_mindiv, &res->capture_reg->l1isp.L1_RCNR1_MERGE_MINDIV);
+
+		writel(param_m->rcnr_hry_type, &res->capture_reg->l1isp.L1_RCNR1_HRY_TYPE);
+
+		writel(param_m->rcnr_anf_blend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR1_ANF_BLEND_AG0);
+		writel(param_m->rcnr_anf_blend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR1_ANF_BLEND_AG1);
+		writel(param_m->rcnr_anf_blend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR1_ANF_BLEND_AG2);
+
+		writel(param_m->rcnr_lpf_threshold,
+		       &res->capture_reg->l1isp.L1_RCNR1_LPF_THRESHOLD);
+
+		writel(param_m->rcnr_merge_hlblend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR1_MERGE_HLBLEND_AG0);
+		writel(param_m->rcnr_merge_hlblend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR1_MERGE_HLBLEND_AG1);
+		writel(param_m->rcnr_merge_hlblend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR1_MERGE_HLBLEND_AG2);
+
+		writel(param_m->rcnr_gnr_sw, &res->capture_reg->l1isp.L1_RCNR1_GNR_SW);
+
+		if (param_m->rcnr_gnr_sw == HWD_VIIF_ENABLE) {
+			writel(param_m->rcnr_gnr_ratio,
+			       &res->capture_reg->l1isp.L1_RCNR1_GNR_RATIO);
+			writel(param_m->rcnr_gnr_wide_en,
+			       &res->capture_reg->l1isp.L1_RCNR1_GNR_WIDE_EN);
+		}
+	}
+
+	if (param_l) {
+		writel(param_l->rcnr_sw, &res->capture_reg->l1isp.L1_RCNR2_SW);
+
+		writel(param_l->rcnr_cnf_dark_ag0, &res->capture_reg->l1isp.L1_RCNR2_CNF_DARK_AG0);
+		writel(param_l->rcnr_cnf_dark_ag1, &res->capture_reg->l1isp.L1_RCNR2_CNF_DARK_AG1);
+		writel(param_l->rcnr_cnf_dark_ag2, &res->capture_reg->l1isp.L1_RCNR2_CNF_DARK_AG2);
+
+		writel(param_l->rcnr_cnf_ratio_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR2_CNF_RATIO_AG0);
+		writel(param_l->rcnr_cnf_ratio_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR2_CNF_RATIO_AG1);
+		writel(param_l->rcnr_cnf_ratio_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR2_CNF_RATIO_AG2);
+
+		writel(param_l->rcnr_cnf_clip_gain_r,
+		       &res->capture_reg->l1isp.L1_RCNR2_CNF_CLIP_GAIN_R);
+		writel(param_l->rcnr_cnf_clip_gain_g,
+		       &res->capture_reg->l1isp.L1_RCNR2_CNF_CLIP_GAIN_G);
+		writel(param_l->rcnr_cnf_clip_gain_b,
+		       &res->capture_reg->l1isp.L1_RCNR2_CNF_CLIP_GAIN_B);
+
+		writel(param_l->rcnr_a1l_dark_ag0, &res->capture_reg->l1isp.L1_RCNR2_A1L_DARK_AG0);
+		writel(param_l->rcnr_a1l_dark_ag1, &res->capture_reg->l1isp.L1_RCNR2_A1L_DARK_AG1);
+		writel(param_l->rcnr_a1l_dark_ag2, &res->capture_reg->l1isp.L1_RCNR2_A1L_DARK_AG2);
+
+		writel(param_l->rcnr_a1l_ratio_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR2_A1L_RATIO_AG0);
+		writel(param_l->rcnr_a1l_ratio_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR2_A1L_RATIO_AG1);
+		writel(param_l->rcnr_a1l_ratio_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR2_A1L_RATIO_AG2);
+
+		writel(param_l->rcnr_inf_zero_clip,
+		       &res->capture_reg->l1isp.L1_RCNR2_INF_ZERO_CLIP);
+
+		writel(param_l->rcnr_merge_d2blend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR2_MERGE_D2BLEND_AG0);
+		writel(param_l->rcnr_merge_d2blend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR2_MERGE_D2BLEND_AG1);
+		writel(param_l->rcnr_merge_d2blend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR2_MERGE_D2BLEND_AG2);
+		writel(param_l->rcnr_merge_black, &res->capture_reg->l1isp.L1_RCNR2_MERGE_BLACK);
+		writel(param_l->rcnr_merge_mindiv, &res->capture_reg->l1isp.L1_RCNR2_MERGE_MINDIV);
+
+		writel(param_l->rcnr_hry_type, &res->capture_reg->l1isp.L1_RCNR2_HRY_TYPE);
+
+		writel(param_l->rcnr_anf_blend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR2_ANF_BLEND_AG0);
+		writel(param_l->rcnr_anf_blend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR2_ANF_BLEND_AG1);
+		writel(param_l->rcnr_anf_blend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR2_ANF_BLEND_AG2);
+
+		writel(param_l->rcnr_lpf_threshold,
+		       &res->capture_reg->l1isp.L1_RCNR2_LPF_THRESHOLD);
+
+		writel(param_l->rcnr_merge_hlblend_ag0,
+		       &res->capture_reg->l1isp.L1_RCNR2_MERGE_HLBLEND_AG0);
+		writel(param_l->rcnr_merge_hlblend_ag1,
+		       &res->capture_reg->l1isp.L1_RCNR2_MERGE_HLBLEND_AG1);
+		writel(param_l->rcnr_merge_hlblend_ag2,
+		       &res->capture_reg->l1isp.L1_RCNR2_MERGE_HLBLEND_AG2);
+
+		writel(param_l->rcnr_gnr_sw, &res->capture_reg->l1isp.L1_RCNR2_GNR_SW);
+
+		if (param_l->rcnr_gnr_sw == HWD_VIIF_ENABLE) {
+			writel(param_l->rcnr_gnr_ratio,
+			       &res->capture_reg->l1isp.L1_RCNR2_GNR_RATIO);
+			writel(param_l->rcnr_gnr_wide_en,
+			       &res->capture_reg->l1isp.L1_RCNR2_GNR_WIDE_EN);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_hdrs() - Configure L1ISP HDR synthesis parameters.
+ *
+ * @param: pointer to HDR synthesis parameters
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param" is NULL
+ * - each parameter of "param" is out of range
+ */
+s32 hwd_viif_l1_set_hdrs(u32 module_id, const struct viif_l1_hdrs_config *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (!param ||
+	    (param->hdrs_hdr_mode != HWD_VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE &&
+	     param->hdrs_hdr_mode != HWD_VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE) ||
+	    param->hdrs_hdr_ratio_m < HWD_VIIF_L1_HDRS_MIN_BLEND_RATIO ||
+	    param->hdrs_hdr_ratio_m > HWD_VIIF_L1_HDRS_MAX_BLEND_RATIO ||
+	    param->hdrs_hdr_ratio_l < HWD_VIIF_L1_HDRS_MIN_BLEND_RATIO ||
+	    param->hdrs_hdr_ratio_l > HWD_VIIF_L1_HDRS_MAX_BLEND_RATIO ||
+	    param->hdrs_hdr_ratio_e < HWD_VIIF_L1_HDRS_MIN_BLEND_RATIO ||
+	    param->hdrs_hdr_ratio_e > HWD_VIIF_L1_HDRS_MAX_BLEND_RATIO ||
+	    param->hdrs_dg_h >= HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL ||
+	    param->hdrs_dg_m >= HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL ||
+	    param->hdrs_dg_l >= HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL ||
+	    param->hdrs_dg_e >= HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL ||
+	    param->hdrs_blendend_h > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL ||
+	    param->hdrs_blendend_m > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL ||
+	    param->hdrs_blendend_e > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL ||
+	    param->hdrs_blendbeg_h > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL ||
+	    param->hdrs_blendbeg_m > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL ||
+	    param->hdrs_blendbeg_e > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL ||
+	    (param->hdrs_led_mode_on != HWD_VIIF_ENABLE &&
+	     param->hdrs_led_mode_on != HWD_VIIF_DISABLE) ||
+	    param->hdrs_dst_max_val > HWD_VIIF_L1_HDRS_MAX_DST_MAX_VAL) {
+		return -EINVAL;
+	}
+
+	writel(param->hdrs_hdr_mode, &res->capture_reg->l1isp.L1_HDRS_HDRMODE);
+
+	writel(param->hdrs_hdr_ratio_m, &res->capture_reg->l1isp.L1_HDRS_HDRRATIO_M);
+	writel(param->hdrs_hdr_ratio_l, &res->capture_reg->l1isp.L1_HDRS_HDRRATIO_L);
+	writel(param->hdrs_hdr_ratio_e, &res->capture_reg->l1isp.L1_HDRS_HDRRATIO_E);
+
+	writel(param->hdrs_dg_h, &res->capture_reg->l1isp.L1_HDRS_DG_H);
+	writel(param->hdrs_dg_m, &res->capture_reg->l1isp.L1_HDRS_DG_M);
+	writel(param->hdrs_dg_l, &res->capture_reg->l1isp.L1_HDRS_DG_L);
+	writel(param->hdrs_dg_e, &res->capture_reg->l1isp.L1_HDRS_DG_E);
+
+	writel(param->hdrs_blendend_h, &res->capture_reg->l1isp.L1_HDRS_BLENDEND_H);
+	writel(param->hdrs_blendend_m, &res->capture_reg->l1isp.L1_HDRS_BLENDEND_M);
+	writel(param->hdrs_blendend_e, &res->capture_reg->l1isp.L1_HDRS_BLENDEND_E);
+
+	writel(param->hdrs_blendbeg_h, &res->capture_reg->l1isp.L1_HDRS_BLENDBEG_H);
+	writel(param->hdrs_blendbeg_m, &res->capture_reg->l1isp.L1_HDRS_BLENDBEG_M);
+	writel(param->hdrs_blendbeg_e, &res->capture_reg->l1isp.L1_HDRS_BLENDBEG_E);
+
+	writel(param->hdrs_led_mode_on, &res->capture_reg->l1isp.L1_HDRS_LEDMODE_ON);
+	writel(param->hdrs_dst_max_val, &res->capture_reg->l1isp.L1_HDRS_DSTMAXVAL);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_black_level_correction() - Configure L1ISP black level correction parameters.
+ *
+ * @param: pointer to black level correction parameters
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param" is NULL
+ * - each parameter of "param" is out of range
+ */
+s32 hwd_viif_l1_set_black_level_correction(
+	u32 module_id, const struct viif_l1_black_level_correction_config *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (!param || param->srcblacklevel_gr > HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL ||
+	    param->srcblacklevel_r > HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL ||
+	    param->srcblacklevel_b > HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL ||
+	    param->srcblacklevel_gb > HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL ||
+	    param->mulval_gr >= HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL ||
+	    param->mulval_r >= HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL ||
+	    param->mulval_b >= HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL ||
+	    param->mulval_gb >= HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL ||
+	    param->dstmaxval > HWD_VIIF_L1_BLACK_LEVEL_MAX_DST_VAL) {
+		return -EINVAL;
+	}
+
+	writel(param->srcblacklevel_gr, &res->capture_reg->l1isp.L1_BLVC_SRCBLACKLEVEL_GR);
+	writel(param->srcblacklevel_r, &res->capture_reg->l1isp.L1_BLVC_SRCBLACKLEVEL_R);
+	writel(param->srcblacklevel_b, &res->capture_reg->l1isp.L1_BLVC_SRCBLACKLEVEL_B);
+	writel(param->srcblacklevel_gb, &res->capture_reg->l1isp.L1_BLVC_SRCBLACKLEVELGB);
+
+	writel(param->mulval_gr, &res->capture_reg->l1isp.L1_BLVC_MULTVAL_GR);
+	writel(param->mulval_r, &res->capture_reg->l1isp.L1_BLVC_MULTVAL_R);
+	writel(param->mulval_b, &res->capture_reg->l1isp.L1_BLVC_MULTVAL_B);
+	writel(param->mulval_gb, &res->capture_reg->l1isp.L1_BLVC_MULTVAL_GB);
+
+	writel(param->dstmaxval, &res->capture_reg->l1isp.L1_BLVC_DSTMAXVAL);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_lsc() - Configure L1ISP lens shading correction parameters.
+ *
+ * @param: pointer to lens shading correction parameters
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ * @note when NULL is set to "param"
+ */
+s32 hwd_viif_l1_set_lsc(u32 module_id, const struct hwd_viif_l1_lsc *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 sysm_width, sysm_height;
+	u32 grid_h_size = 0U;
+	u32 grid_v_size = 0U;
+	s32 ret = 0;
+	u32 idx;
+	u32 val;
+	u32 tmp;
+
+	if (!param) {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_LSSC_EN);
+		return 0;
+	}
+
+	sysm_width = readl(&res->capture_reg->l1isp.L1_SYSM_WIDTH);
+	sysm_height = readl(&res->capture_reg->l1isp.L1_SYSM_HEIGHT);
+
+	if (param->lssc_parabola_param) {
+		if (param->lssc_parabola_param->lssc_para_h_center >= sysm_width ||
+		    param->lssc_parabola_param->lssc_para_v_center >= sysm_height ||
+		    param->lssc_parabola_param->lssc_para_h_gain >= HWD_VIIF_LSC_MAX_GAIN ||
+		    param->lssc_parabola_param->lssc_para_v_gain >= HWD_VIIF_LSC_MAX_GAIN) {
+			return -EINVAL;
+		}
+
+		switch (param->lssc_parabola_param->lssc_para_mgsel2) {
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH:
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH:
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_SECOND:
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FIRST:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		switch (param->lssc_parabola_param->lssc_para_mgsel4) {
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH:
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH:
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_SECOND:
+		case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FIRST:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		for (idx = 0U; idx < 8U; idx++) {
+			const struct viif_l1_lsc_parabola_ag_param *ag_param;
+
+			switch (idx) {
+			case 0U:
+				ag_param = &param->lssc_parabola_param->r_2d;
+				break;
+			case 1U:
+				ag_param = &param->lssc_parabola_param->r_4d;
+				break;
+			case 2U:
+				ag_param = &param->lssc_parabola_param->gr_2d;
+				break;
+			case 3U:
+				ag_param = &param->lssc_parabola_param->gr_4d;
+				break;
+			case 4U:
+				ag_param = &param->lssc_parabola_param->gb_2d;
+				break;
+			case 5U:
+				ag_param = &param->lssc_parabola_param->gb_4d;
+				break;
+			case 6U:
+				ag_param = &param->lssc_parabola_param->b_2d;
+				break;
+			default:
+				ag_param = &param->lssc_parabola_param->b_4d;
+				break;
+			}
+
+			if (!ag_param || ag_param->lssc_paracoef_h_l_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_h_l_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_h_l_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_h_l_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_h_l_min > ag_param->lssc_paracoef_h_l_max ||
+			    ag_param->lssc_paracoef_h_r_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_h_r_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_h_r_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_h_r_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_h_r_min > ag_param->lssc_paracoef_h_r_max ||
+			    ag_param->lssc_paracoef_v_u_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_v_u_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_v_u_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_v_u_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_v_u_min > ag_param->lssc_paracoef_v_u_max ||
+			    ag_param->lssc_paracoef_v_d_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_v_d_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_v_d_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_v_d_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_v_d_min > ag_param->lssc_paracoef_v_d_max ||
+			    ag_param->lssc_paracoef_hv_lu_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_lu_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_lu_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_lu_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_lu_min > ag_param->lssc_paracoef_hv_lu_max ||
+			    ag_param->lssc_paracoef_hv_ru_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_ru_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_ru_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_ru_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_ru_min > ag_param->lssc_paracoef_hv_ru_max ||
+			    ag_param->lssc_paracoef_hv_ld_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_ld_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_ld_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_ld_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_ld_min > ag_param->lssc_paracoef_hv_ld_max ||
+			    ag_param->lssc_paracoef_hv_rd_max < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_rd_max >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_rd_min < HWD_VIIF_LSC_MIN_GAIN ||
+			    ag_param->lssc_paracoef_hv_rd_min >= HWD_VIIF_LSC_MAX_GAIN ||
+			    ag_param->lssc_paracoef_hv_rd_min > ag_param->lssc_paracoef_hv_rd_max) {
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (param->lssc_grid_param) {
+		switch (param->lssc_grid_param->lssc_grid_h_size) {
+		case 32U:
+			grid_h_size = 5U;
+			break;
+		case 64U:
+			grid_h_size = 6U;
+			break;
+		case 128U:
+			grid_h_size = 7U;
+			break;
+		case 256U:
+			grid_h_size = 8U;
+			break;
+		case 512U:
+			grid_h_size = 9U;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+
+		if (ret != 0)
+			return ret;
+
+		switch (param->lssc_grid_param->lssc_grid_v_size) {
+		case 32U:
+			grid_v_size = 5U;
+			break;
+		case 64U:
+			grid_v_size = 6U;
+			break;
+		case 128U:
+			grid_v_size = 7U;
+			break;
+		case 256U:
+			grid_v_size = 8U;
+			break;
+		case 512U:
+			grid_v_size = 9U;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+
+		if (ret != 0)
+			return ret;
+
+		if (param->lssc_grid_param->lssc_grid_h_center < HWD_VIIF_LSC_GRID_MIN_COORDINATE ||
+		    param->lssc_grid_param->lssc_grid_h_center >
+			    param->lssc_grid_param->lssc_grid_h_size) {
+			return -EINVAL;
+		}
+
+		if (sysm_width > (param->lssc_grid_param->lssc_grid_h_center +
+				  (param->lssc_grid_param->lssc_grid_h_size * 31U))) {
+			return -EINVAL;
+		}
+
+		if (param->lssc_grid_param->lssc_grid_v_center < HWD_VIIF_LSC_GRID_MIN_COORDINATE ||
+		    param->lssc_grid_param->lssc_grid_v_center >
+			    param->lssc_grid_param->lssc_grid_v_size) {
+			return -EINVAL;
+		}
+
+		if (sysm_height > (param->lssc_grid_param->lssc_grid_v_center +
+				   (param->lssc_grid_param->lssc_grid_v_size * 23U))) {
+			return -EINVAL;
+		}
+
+		if (param->lssc_grid_param->lssc_grid_mgsel != HWD_VIIF_L1_GRID_COEF_GAIN_X1 &&
+		    param->lssc_grid_param->lssc_grid_mgsel != HWD_VIIF_L1_GRID_COEF_GAIN_X2) {
+			return -EINVAL;
+		}
+	}
+
+	if (param->lssc_pwhb_r_gain_max >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_r_gain_min >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_r_gain_min > param->lssc_pwhb_r_gain_max ||
+	    param->lssc_pwhb_gr_gain_max >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_gr_gain_min >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_gr_gain_min > param->lssc_pwhb_gr_gain_max ||
+	    param->lssc_pwhb_gb_gain_max >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_gb_gain_min >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_gb_gain_min > param->lssc_pwhb_gb_gain_max ||
+	    param->lssc_pwhb_b_gain_max >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_b_gain_min >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL ||
+	    param->lssc_pwhb_b_gain_min > param->lssc_pwhb_b_gain_max) {
+		return -EINVAL;
+	}
+
+	/* parabola shading */
+	if (param->lssc_parabola_param) {
+		struct viif_l1_lsc_parabola_ag_param *r_2d;
+		struct viif_l1_lsc_parabola_ag_param *r_4d;
+		struct viif_l1_lsc_parabola_ag_param *gr_2d;
+		struct viif_l1_lsc_parabola_ag_param *gr_4d;
+		struct viif_l1_lsc_parabola_ag_param *gb_2d;
+		struct viif_l1_lsc_parabola_ag_param *gb_4d;
+		struct viif_l1_lsc_parabola_ag_param *b_2d;
+		struct viif_l1_lsc_parabola_ag_param *b_4d;
+
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_LSSC_PARA_EN);
+
+		writel(param->lssc_parabola_param->lssc_para_h_center,
+		       &res->capture_reg->l1isp.L1_LSSC_PARA_H_CENTER);
+		writel(param->lssc_parabola_param->lssc_para_v_center,
+		       &res->capture_reg->l1isp.L1_LSSC_PARA_V_CENTER);
+
+		writel(param->lssc_parabola_param->lssc_para_h_gain,
+		       &res->capture_reg->l1isp.L1_LSSC_PARA_H_GAIN);
+		writel(param->lssc_parabola_param->lssc_para_v_gain,
+		       &res->capture_reg->l1isp.L1_LSSC_PARA_V_GAIN);
+
+		writel(param->lssc_parabola_param->lssc_para_mgsel2,
+		       &res->capture_reg->l1isp.L1_LSSC_PARA_MGSEL2);
+		writel(param->lssc_parabola_param->lssc_para_mgsel4,
+		       &res->capture_reg->l1isp.L1_LSSC_PARA_MGSEL4);
+
+		/* R 2D */
+		r_2d = &param->lssc_parabola_param->r_2d;
+		tmp = (u32)r_2d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_H_L);
+
+		tmp = (u32)r_2d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_H_R);
+
+		tmp = (u32)r_2d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_V_U);
+
+		tmp = (u32)r_2d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_V_D);
+
+		tmp = (u32)r_2d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_HV_LU);
+
+		tmp = (u32)r_2d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_HV_RU);
+
+		tmp = (u32)r_2d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_HV_LD);
+
+		tmp = (u32)r_2d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_2d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_HV_RD);
+
+		/* R 4D */
+		r_4d = &param->lssc_parabola_param->r_4d;
+		tmp = (u32)r_4d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_H_L);
+
+		tmp = (u32)r_4d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_H_R);
+
+		tmp = (u32)r_4d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_V_U);
+
+		tmp = (u32)r_4d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_V_D);
+
+		tmp = (u32)r_4d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_HV_LU);
+
+		tmp = (u32)r_4d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_HV_RU);
+
+		tmp = (u32)r_4d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_HV_LD);
+
+		tmp = (u32)r_4d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(r_4d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_HV_RD);
+
+		/* GR 2D */
+		gr_2d = &param->lssc_parabola_param->gr_2d;
+		tmp = (u32)gr_2d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_H_L);
+
+		tmp = (u32)gr_2d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_H_R);
+
+		tmp = (u32)gr_2d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_V_U);
+
+		tmp = (u32)gr_2d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_V_D);
+
+		tmp = (u32)gr_2d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_HV_LU);
+
+		tmp = (u32)gr_2d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_HV_RU);
+
+		tmp = (u32)gr_2d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_HV_LD);
+
+		tmp = (u32)gr_2d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_2d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_HV_RD);
+
+		/* GR 4D */
+		gr_4d = &param->lssc_parabola_param->gr_4d;
+		tmp = (u32)gr_4d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_H_L);
+
+		tmp = (u32)gr_4d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_H_R);
+
+		tmp = (u32)gr_4d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_V_U);
+
+		tmp = (u32)gr_4d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_V_D);
+
+		tmp = (u32)gr_4d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_HV_LU);
+
+		tmp = (u32)gr_4d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_HV_RU);
+
+		tmp = (u32)gr_4d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_HV_LD);
+
+		tmp = (u32)gr_4d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gr_4d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_HV_RD);
+
+		/* GB 2D */
+		gb_2d = &param->lssc_parabola_param->gb_2d;
+		tmp = (u32)gb_2d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_H_L);
+
+		tmp = (u32)gb_2d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_H_R);
+
+		tmp = (u32)gb_2d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_V_U);
+
+		tmp = (u32)gb_2d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_V_D);
+
+		tmp = (u32)gb_2d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_HV_LU);
+
+		tmp = (u32)gb_2d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_HV_RU);
+
+		tmp = (u32)gb_2d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_HV_LD);
+
+		tmp = (u32)gb_2d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_2d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_HV_RD);
+
+		/* GB 4D */
+		gb_4d = &param->lssc_parabola_param->gb_4d;
+		tmp = (u32)gb_4d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_H_L);
+
+		tmp = (u32)gb_4d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_H_R);
+
+		tmp = (u32)gb_4d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_V_U);
+
+		tmp = (u32)gb_4d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_V_D);
+
+		tmp = (u32)gb_4d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_HV_LU);
+
+		tmp = (u32)gb_4d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_HV_RU);
+
+		tmp = (u32)gb_4d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_HV_LD);
+
+		tmp = (u32)gb_4d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(gb_4d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_HV_RD);
+
+		/* B 2D */
+		b_2d = &param->lssc_parabola_param->b_2d;
+		tmp = (u32)b_2d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_H_L);
+
+		tmp = (u32)b_2d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_H_R);
+
+		tmp = (u32)b_2d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_V_U);
+
+		tmp = (u32)b_2d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_V_D);
+
+		tmp = (u32)b_2d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_HV_LU);
+
+		tmp = (u32)b_2d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_HV_RU);
+
+		tmp = (u32)b_2d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_HV_LD);
+
+		tmp = (u32)b_2d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_2d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_HV_RD);
+
+		/* B 4D */
+		b_4d = &param->lssc_parabola_param->b_4d;
+		tmp = (u32)b_4d->lssc_paracoef_h_l_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_h_l_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_H_L);
+
+		tmp = (u32)b_4d->lssc_paracoef_h_r_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_h_r_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_H_R);
+
+		tmp = (u32)b_4d->lssc_paracoef_v_u_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_v_u_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_V_U);
+
+		tmp = (u32)b_4d->lssc_paracoef_v_d_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_v_d_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_V_D);
+
+		tmp = (u32)b_4d->lssc_paracoef_hv_lu_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_hv_lu_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_HV_LU);
+
+		tmp = (u32)b_4d->lssc_paracoef_hv_ru_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_hv_ru_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_HV_RU);
+
+		tmp = (u32)b_4d->lssc_paracoef_hv_ld_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_hv_ld_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_HV_LD);
+
+		tmp = (u32)b_4d->lssc_paracoef_hv_rd_max & 0x1fffU;
+		val = (tmp << 16U) | (u32)(b_4d->lssc_paracoef_hv_rd_min & 0x1fffU);
+		writel(val, &res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_HV_RD);
+
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_LSSC_PARA_EN);
+	}
+
+	/* grid shading */
+	if (param->lssc_grid_param) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_LSSC_GRID_EN);
+		writel(grid_h_size, &res->capture_reg->l1isp.L1_LSSC_GRID_H_SIZE);
+		writel(grid_v_size, &res->capture_reg->l1isp.L1_LSSC_GRID_V_SIZE);
+		writel(param->lssc_grid_param->lssc_grid_h_center,
+		       &res->capture_reg->l1isp.L1_LSSC_GRID_H_CENTER);
+		writel(param->lssc_grid_param->lssc_grid_v_center,
+		       &res->capture_reg->l1isp.L1_LSSC_GRID_V_CENTER);
+		writel(param->lssc_grid_param->lssc_grid_mgsel,
+		       &res->capture_reg->l1isp.L1_LSSC_GRID_MGSEL);
+
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_LSSC_GRID_EN);
+	}
+
+	/* preset white balance */
+	val = (param->lssc_pwhb_r_gain_max << 16U) | (param->lssc_pwhb_r_gain_min);
+	writel(val, &res->capture_reg->l1isp.L1_LSSC_PWHB_R_GAIN);
+
+	val = (param->lssc_pwhb_gr_gain_max << 16U) | (param->lssc_pwhb_gr_gain_min);
+	writel(val, &res->capture_reg->l1isp.L1_LSSC_PWHB_GR_GAIN);
+
+	val = (param->lssc_pwhb_gb_gain_max << 16U) | (param->lssc_pwhb_gb_gain_min);
+	writel(val, &res->capture_reg->l1isp.L1_LSSC_PWHB_GB_GAIN);
+
+	val = (param->lssc_pwhb_b_gain_max << 16U) | (param->lssc_pwhb_b_gain_min);
+	writel(val, &res->capture_reg->l1isp.L1_LSSC_PWHB_B_GAIN);
+
+	writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_LSSC_EN);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_lsc_table_transmission() - Configure L1ISP transferring lens shading grid table.
+ *
+ * @table_gr: grid shading table for Gr(physical address)
+ * @table_r: grid shading table for R(physical address)
+ * @table_b: grid shading table for B(physical address)
+ * @table_gb: grid shading table for Gb(physical address)
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "table_h", "table_m" or "table_l" is not 8byte alignment
+ *
+ * Note that when 0 is set to table address, table transfer of the table is disabled.
+ */
+s32 hwd_viif_l1_set_lsc_table_transmission(u32 module_id, uintptr_t table_gr, uintptr_t table_r,
+					   uintptr_t table_b, uintptr_t table_gb)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val = 0x0U;
+
+	if (((table_gr % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_r % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_b % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_gb % HWD_VIIF_L1_VDM_ALIGN) != 0U)) {
+		return -EINVAL;
+	}
+	/* VDM common settings */
+	writel(HWD_VIIF_L1_VDM_CFG_PARAM, &res->capture_reg->vdm.t_group[0].VDM_T_CFG);
+	writel(HWD_VIIF_L1_VDM_SRAM_BASE, &res->capture_reg->vdm.t_group[0].VDM_T_SRAM_BASE);
+	writel(HWD_VIIF_L1_VDM_SRAM_SIZE, &res->capture_reg->vdm.t_group[0].VDM_T_SRAM_SIZE);
+
+	if (table_gr != 0U) {
+		writel((u32)table_gr, &res->capture_reg->vdm.t_port[4].VDM_T_STADR);
+		writel(HWD_VIIF_L1_VDM_LSC_TABLE_SIZE, &res->capture_reg->vdm.t_port[4].VDM_T_SIZE);
+		val |= 0x10U;
+	}
+
+	if (table_r != 0U) {
+		writel((u32)table_r, &res->capture_reg->vdm.t_port[5].VDM_T_STADR);
+		writel(HWD_VIIF_L1_VDM_LSC_TABLE_SIZE, &res->capture_reg->vdm.t_port[5].VDM_T_SIZE);
+		val |= 0x20U;
+	}
+
+	if (table_b != 0U) {
+		writel((u32)table_b, &res->capture_reg->vdm.t_port[6].VDM_T_STADR);
+		writel(HWD_VIIF_L1_VDM_LSC_TABLE_SIZE, &res->capture_reg->vdm.t_port[6].VDM_T_SIZE);
+		val |= 0x40U;
+	}
+
+	if (table_gb != 0U) {
+		writel((u32)table_gb, &res->capture_reg->vdm.t_port[7].VDM_T_STADR);
+		writel(HWD_VIIF_L1_VDM_LSC_TABLE_SIZE, &res->capture_reg->vdm.t_port[7].VDM_T_SIZE);
+		val |= 0x80U;
+	}
+
+	val |= (readl(&res->capture_reg->vdm.VDM_T_ENABLE) & 0xffffff0fU);
+	writel(val, &res->capture_reg->vdm.VDM_T_ENABLE);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_main_process() - Configure L1ISP main process.
+ *
+ * @demosaic_mode: demosaic mode @ref hwd_viif_l1_demosaic
+ * @damp_lsbsel: output pixel clip range for auto white balance [0..15]
+ * @color_matrix: pointer to color matrix correction parameters
+ * @dst_maxval: output pixel maximum value [0x0..0xffffff]
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * main process means digital amp, demosaic, and color matrix correction
+ *             NULL means disabling color matrix correction
+ * - "demosaic_mode" is neither HWD_VIIF_L1_DEMOSAIC_ACPI nor HWD_VIIF_L1_DEMOSAIC_DMG
+ * - "damp_lsbsel" is out of range
+ * - each parameter of "color_matrix" is out of range
+ * - "dst_maxval" is out of range
+ */
+s32 hwd_viif_l1_set_main_process(u32 module_id, u32 demosaic_mode, u32 damp_lsbsel,
+				 const struct viif_l1_color_matrix_correction *color_matrix,
+				 u32 dst_maxval)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val;
+
+	if (demosaic_mode != HWD_VIIF_L1_DEMOSAIC_ACPI &&
+	    demosaic_mode != HWD_VIIF_L1_DEMOSAIC_DMG) {
+		return -EINVAL;
+	}
+
+	if (damp_lsbsel > HWD_VIIF_DAMP_MAX_LSBSEL)
+		return -EINVAL;
+
+	if (color_matrix) {
+		if (color_matrix->coef_rmg_min > color_matrix->coef_rmg_max ||
+		    color_matrix->coef_rmb_min > color_matrix->coef_rmb_max ||
+		    color_matrix->coef_gmr_min > color_matrix->coef_gmr_max ||
+		    color_matrix->coef_gmb_min > color_matrix->coef_gmb_max ||
+		    color_matrix->coef_bmr_min > color_matrix->coef_bmr_max ||
+		    color_matrix->coef_bmg_min > color_matrix->coef_bmg_max ||
+		    (u32)color_matrix->dst_minval > dst_maxval)
+			return -EINVAL;
+	}
+
+	if (dst_maxval > HWD_VIIF_MAIN_PROCESS_MAX_OUT_PIXEL_VAL)
+		return -EINVAL;
+
+	val = damp_lsbsel << 4U;
+	writel(val, &res->capture_reg->l1isp.L1_MPRO_CONF);
+
+	writel(demosaic_mode, &res->capture_reg->l1isp.L1_MPRO_LCS_MODE);
+
+	if (color_matrix) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_MPRO_SW);
+
+		val = (u32)color_matrix->coef_rmg_min & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_RMG_MIN);
+
+		val = (u32)color_matrix->coef_rmg_max & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_RMG_MAX);
+
+		val = (u32)color_matrix->coef_rmb_min & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_RMB_MIN);
+
+		val = (u32)color_matrix->coef_rmb_max & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_RMB_MAX);
+
+		val = (u32)color_matrix->coef_gmr_min & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_GMR_MIN);
+
+		val = (u32)color_matrix->coef_gmr_max & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_GMR_MAX);
+
+		val = (u32)color_matrix->coef_gmb_min & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_GMB_MIN);
+
+		val = (u32)color_matrix->coef_gmb_max & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_GMB_MAX);
+
+		val = (u32)color_matrix->coef_bmr_min & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_BMR_MIN);
+
+		val = (u32)color_matrix->coef_bmr_max & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_BMR_MAX);
+
+		val = (u32)color_matrix->coef_bmg_min & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_BMG_MIN);
+
+		val = (u32)color_matrix->coef_bmg_max & 0xffffU;
+		writel(val, &res->capture_reg->l1isp.L1_MPRO_LM0_BMG_MAX);
+
+		writel((u32)color_matrix->dst_minval, &res->capture_reg->l1isp.L1_MPRO_DST_MINVAL);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_MPRO_SW);
+	}
+
+	writel(dst_maxval, &res->capture_reg->l1isp.L1_MPRO_DST_MAXVAL);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_awb() - Configure L1ISP auto white balance parameters.
+ *
+ * @param: pointer to auto white balance parameters; NULL means disabling auto white balance
+ * @awhb_wbmrg: R gain of white balance adjustment [0x40..0x3FF] accuracy: 1/256
+ * @awhb_wbmgg: G gain of white balance adjustment [0x40..0x3FF] accuracy: 1/256
+ * @awhb_wbmbg: B gain of white balance adjustment [0x40..0x3FF] accuracy: 1/256
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL
+ * - each parameter of "param" is out of range
+ * - awhb_wbm*g is out of range
+ */
+s32 hwd_viif_l1_set_awb(u32 module_id, const struct viif_l1_awb *param, u32 awhb_wbmrg,
+			u32 awhb_wbmgg, u32 awhb_wbmbg)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val, ygate_data;
+
+	if (awhb_wbmrg < HWD_VIIF_AWB_MIN_GAIN || awhb_wbmrg >= HWD_VIIF_AWB_MAX_GAIN ||
+	    awhb_wbmgg < HWD_VIIF_AWB_MIN_GAIN || awhb_wbmgg >= HWD_VIIF_AWB_MAX_GAIN ||
+	    awhb_wbmbg < HWD_VIIF_AWB_MIN_GAIN || awhb_wbmbg >= HWD_VIIF_AWB_MAX_GAIN) {
+		return -EINVAL;
+	}
+
+	if (param) {
+		if (param->awhb_ygate_sel != HWD_VIIF_ENABLE &&
+		    param->awhb_ygate_sel != HWD_VIIF_DISABLE) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_ygate_data != 64U && param->awhb_ygate_data != 128U &&
+		    param->awhb_ygate_data != 256U && param->awhb_ygate_data != 512U) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_cgrange != HWD_VIIF_L1_AWB_ONE_SECOND &&
+		    param->awhb_cgrange != HWD_VIIF_L1_AWB_X1 &&
+		    param->awhb_cgrange != HWD_VIIF_L1_AWB_X2 &&
+		    param->awhb_cgrange != HWD_VIIF_L1_AWB_X4) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_ygatesw != HWD_VIIF_ENABLE &&
+		    param->awhb_ygatesw != HWD_VIIF_DISABLE) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_hexsw != HWD_VIIF_ENABLE && param->awhb_hexsw != HWD_VIIF_DISABLE)
+			return -EINVAL;
+
+		if (param->awhb_areamode != HWD_VIIF_L1_AWB_AREA_MODE0 &&
+		    param->awhb_areamode != HWD_VIIF_L1_AWB_AREA_MODE1 &&
+		    param->awhb_areamode != HWD_VIIF_L1_AWB_AREA_MODE2 &&
+		    param->awhb_areamode != HWD_VIIF_L1_AWB_AREA_MODE3) {
+			return -EINVAL;
+		}
+
+		val = readl(&res->capture_reg->l1isp.L1_SYSM_WIDTH);
+		if (param->awhb_area_hsize < 1U || (param->awhb_area_hsize > ((val - 8U) / 8U)) ||
+		    param->awhb_area_hofs > (val - 9U)) {
+			return -EINVAL;
+		}
+
+		val = readl(&res->capture_reg->l1isp.L1_SYSM_HEIGHT);
+		if (param->awhb_area_vsize < 1U || (param->awhb_area_vsize > ((val - 4U) / 8U)) ||
+		    param->awhb_area_vofs > (val - 5U)) {
+			return -EINVAL;
+		}
+
+		if ((param->awhb_sq_sw[0] != HWD_VIIF_ENABLE &&
+		     param->awhb_sq_sw[0] != HWD_VIIF_DISABLE) ||
+		    (param->awhb_sq_sw[1] != HWD_VIIF_ENABLE &&
+		     param->awhb_sq_sw[1] != HWD_VIIF_DISABLE) ||
+		    (param->awhb_sq_sw[2] != HWD_VIIF_ENABLE &&
+		     param->awhb_sq_sw[2] != HWD_VIIF_DISABLE) ||
+		    (param->awhb_sq_pol[0] != HWD_VIIF_ENABLE &&
+		     param->awhb_sq_pol[0] != HWD_VIIF_DISABLE) ||
+		    (param->awhb_sq_pol[1] != HWD_VIIF_ENABLE &&
+		     param->awhb_sq_pol[1] != HWD_VIIF_DISABLE) ||
+		    (param->awhb_sq_pol[2] != HWD_VIIF_ENABLE &&
+		     param->awhb_sq_pol[2] != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_bycut0p > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_bycut0n > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_rycut0p > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_rycut0n > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_rbcut0h < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_rbcut0h > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_rbcut0l < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_rbcut0l > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_bycut_h[0] < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_bycut_h[0] > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_bycut_h[1] < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_bycut_h[1] > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_bycut_h[2] < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_bycut_h[2] > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_bycut_l[0] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_bycut_l[1] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_bycut_l[2] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_rycut_h[0] < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_rycut_h[0] > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_rycut_h[1] < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_rycut_h[1] > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_rycut_h[2] < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_rycut_h[2] > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_rycut_l[0] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_rycut_l[1] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_rycut_l[2] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER ||
+		    param->awhb_awbsftu < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_awbsftu > HWD_VIIF_AWB_GATE_UPPER ||
+		    param->awhb_awbsftv < HWD_VIIF_AWB_GATE_LOWER ||
+		    param->awhb_awbsftv > HWD_VIIF_AWB_GATE_UPPER ||
+		    (param->awhb_awbhuecor != HWD_VIIF_ENABLE &&
+		     param->awhb_awbhuecor != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_awbspd > HWD_VIIF_AWB_MAX_UV_CONVERGENCE_SPEED ||
+		    param->awhb_awbulv > HWD_VIIF_AWB_MAX_UV_CONVERGENCE_LEVEL ||
+		    param->awhb_awbvlv > HWD_VIIF_AWB_MAX_UV_CONVERGENCE_LEVEL ||
+		    param->awhb_awbondot > HWD_VIIF_AWB_INTEGRATION_STOP_TH) {
+			return -EINVAL;
+		}
+
+		switch (param->awhb_awbfztim) {
+		case HWD_VIIF_L1_AWB_RESTART_NO:
+		case HWD_VIIF_L1_AWB_RESTART_128FRAME:
+		case HWD_VIIF_L1_AWB_RESTART_64FRAME:
+		case HWD_VIIF_L1_AWB_RESTART_32FRAME:
+		case HWD_VIIF_L1_AWB_RESTART_16FRAME:
+		case HWD_VIIF_L1_AWB_RESTART_8FRAME:
+		case HWD_VIIF_L1_AWB_RESTART_4FRAME:
+		case HWD_VIIF_L1_AWB_RESTART_2FRAME:
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	writel(awhb_wbmrg, &res->capture_reg->l1isp.L1_AWHB_WBMRG);
+	writel(awhb_wbmgg, &res->capture_reg->l1isp.L1_AWHB_WBMGG);
+	writel(awhb_wbmbg, &res->capture_reg->l1isp.L1_AWHB_WBMBG);
+
+	val = readl(&res->capture_reg->l1isp.L1_AWHB_SW) & 0xffffff7fU;
+
+	if (param) {
+		val |= (HWD_VIIF_ENABLE << 7U);
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_SW);
+
+		if (param->awhb_ygate_data == 64U)
+			ygate_data = 0U;
+		else if (param->awhb_ygate_data == 128U)
+			ygate_data = 1U;
+		else if (param->awhb_ygate_data == 256U)
+			ygate_data = 2U;
+		else
+			ygate_data = 3U;
+
+		val = (param->awhb_ygate_sel << 7U) | (ygate_data << 5U) | (param->awhb_cgrange);
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_GATE_CONF0);
+
+		val = (param->awhb_ygatesw << 5U) | (param->awhb_hexsw << 4U) |
+		      (param->awhb_areamode);
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_GATE_CONF1);
+
+		writel(param->awhb_area_hsize, &res->capture_reg->l1isp.L1_AWHB_AREA_HSIZE);
+		writel(param->awhb_area_vsize, &res->capture_reg->l1isp.L1_AWHB_AREA_VSIZE);
+		writel(param->awhb_area_hofs, &res->capture_reg->l1isp.L1_AWHB_AREA_HOFS);
+		writel(param->awhb_area_vofs, &res->capture_reg->l1isp.L1_AWHB_AREA_VOFS);
+
+		writel(param->awhb_area_maskh, &res->capture_reg->l1isp.L1_AWHB_AREA_MASKH);
+		writel(param->awhb_area_maskl, &res->capture_reg->l1isp.L1_AWHB_AREA_MASKL);
+
+		val = (param->awhb_sq_sw[0] << 7U) | (param->awhb_sq_pol[0] << 6U) |
+		      (param->awhb_sq_sw[1] << 5U) | (param->awhb_sq_pol[1] << 4U) |
+		      (param->awhb_sq_sw[2] << 3U) | (param->awhb_sq_pol[2] << 2U);
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_SQ_CONF);
+
+		writel((u32)param->awhb_ygateh, &res->capture_reg->l1isp.L1_AWHB_YGATEH);
+		writel((u32)param->awhb_ygatel, &res->capture_reg->l1isp.L1_AWHB_YGATEL);
+
+		writel(param->awhb_bycut0p, &res->capture_reg->l1isp.L1_AWHB_BYCUT0P);
+		writel(param->awhb_bycut0n, &res->capture_reg->l1isp.L1_AWHB_BYCUT0N);
+		writel(param->awhb_rycut0p, &res->capture_reg->l1isp.L1_AWHB_RYCUT0P);
+		writel(param->awhb_rycut0n, &res->capture_reg->l1isp.L1_AWHB_RYCUT0N);
+
+		val = (u32)param->awhb_rbcut0h & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_RBCUT0H);
+		val = (u32)param->awhb_rbcut0l & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_RBCUT0L);
+
+		val = (u32)param->awhb_bycut_h[0] & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_BYCUT1H);
+		writel(param->awhb_bycut_l[0], &res->capture_reg->l1isp.L1_AWHB_BYCUT1L);
+		val = (u32)param->awhb_bycut_h[1] & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_BYCUT2H);
+		writel(param->awhb_bycut_l[1], &res->capture_reg->l1isp.L1_AWHB_BYCUT2L);
+		val = (u32)param->awhb_bycut_h[2] & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_BYCUT3H);
+		writel(param->awhb_bycut_l[2], &res->capture_reg->l1isp.L1_AWHB_BYCUT3L);
+
+		val = (u32)param->awhb_rycut_h[0] & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_RYCUT1H);
+		writel(param->awhb_rycut_l[0], &res->capture_reg->l1isp.L1_AWHB_RYCUT1L);
+		val = (u32)param->awhb_rycut_h[1] & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_RYCUT2H);
+		writel(param->awhb_rycut_l[1], &res->capture_reg->l1isp.L1_AWHB_RYCUT2L);
+		val = (u32)param->awhb_rycut_h[2] & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_RYCUT3H);
+		writel(param->awhb_rycut_l[2], &res->capture_reg->l1isp.L1_AWHB_RYCUT3L);
+
+		val = (u32)param->awhb_awbsftu & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_AWBSFTU);
+		val = (u32)param->awhb_awbsftv & 0xffU;
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_AWBSFTV);
+
+		val = (param->awhb_awbhuecor << 4U) | (param->awhb_awbspd);
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_AWBSPD);
+
+		writel(param->awhb_awbulv, &res->capture_reg->l1isp.L1_AWHB_AWBULV);
+		writel(param->awhb_awbvlv, &res->capture_reg->l1isp.L1_AWHB_AWBVLV);
+		writel((u32)param->awhb_awbwait, &res->capture_reg->l1isp.L1_AWHB_AWBWAIT);
+
+		writel(param->awhb_awbondot, &res->capture_reg->l1isp.L1_AWHB_AWBONDOT);
+		writel(param->awhb_awbfztim, &res->capture_reg->l1isp.L1_AWHB_AWBFZTIM);
+
+		writel((u32)param->awhb_wbgrmax, &res->capture_reg->l1isp.L1_AWHB_WBGRMAX);
+		writel((u32)param->awhb_wbgbmax, &res->capture_reg->l1isp.L1_AWHB_WBGBMAX);
+		writel((u32)param->awhb_wbgrmin, &res->capture_reg->l1isp.L1_AWHB_WBGRMIN);
+		writel((u32)param->awhb_wbgbmin, &res->capture_reg->l1isp.L1_AWHB_WBGBMIN);
+
+	} else {
+		/* disable awb */
+		writel(val, &res->capture_reg->l1isp.L1_AWHB_SW);
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_lock_awb_gain() - Configure L1ISP lock auto white balance gain.
+ *
+ * @enable: enable/disable lock AWB gain
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "enable" is neither HWD_VIIF_ENABLE nor HWD_VIIF_DISABLE
+ */
+s32 hwd_viif_l1_lock_awb_gain(u32 module_id, u32 enable)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val;
+
+	if (enable != HWD_VIIF_ENABLE && enable != HWD_VIIF_DISABLE)
+		return -EINVAL;
+
+	val = readl(&res->capture_reg->l1isp.L1_AWHB_SW) & 0xffffffdfU;
+	val |= (enable << 5U);
+	writel(val, &res->capture_reg->l1isp.L1_AWHB_SW);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_hdrc() - Configure L1ISP HDR compression parameters.
+ *
+ * @param: pointer to HDR compression parameters
+ * @hdrc_thr_sft_amt: shift value in case of through mode [0..8]
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ * - hdrc_thr_sft_amt is out of range when param is NULL
+ * - hdrc_thr_sft_amt is not 0 when param is not NULL
+ */
+s32 hwd_viif_l1_set_hdrc(u32 module_id, const struct viif_l1_hdrc *param, u32 hdrc_thr_sft_amt)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val, sw_delay1;
+
+	if (!param) {
+		if (hdrc_thr_sft_amt > HWD_VIIF_L1_HDRC_MAX_THROUGH_SHIFT_VAL)
+			return -EINVAL;
+
+		writel(hdrc_thr_sft_amt, &res->capture_reg->l1isp.L1_HDRC_THR_SFT_AMT);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_HDRC_EN);
+
+		return 0;
+	}
+
+	if (hdrc_thr_sft_amt != 0U || param->hdrc_ratio < HWD_VIIF_L1_HDRC_MIN_INPUT_DATA_WIDTH ||
+	    param->hdrc_ratio > HWD_VIIF_L1_HDRC_MAX_INPUT_DATA_WIDTH ||
+	    param->hdrc_pt_ratio > HWD_VIIF_L1_HDRC_MAX_PT_SLOPE ||
+	    param->hdrc_pt_blend > HWD_VIIF_L1_HDRC_MAX_BLEND_RATIO ||
+	    param->hdrc_pt_blend2 > HWD_VIIF_L1_HDRC_MAX_BLEND_RATIO ||
+	    (param->hdrc_pt_blend + param->hdrc_pt_blend2) > HWD_VIIF_L1_HDRC_MAX_BLEND_RATIO ||
+	    (param->hdrc_tn_type != HWD_VIIF_L1_HDRC_TONE_USER &&
+	     param->hdrc_tn_type != HWD_VIIF_L1_HDRC_TONE_PRESET) ||
+	    param->hdrc_flr_val > HWD_VIIF_L1_HDRC_MAX_FLARE_VAL ||
+	    (param->hdrc_flr_adp != HWD_VIIF_ENABLE && param->hdrc_flr_adp != HWD_VIIF_DISABLE) ||
+	    (param->hdrc_ybr_off != HWD_VIIF_ENABLE && param->hdrc_ybr_off != HWD_VIIF_DISABLE) ||
+	    param->hdrc_orgy_blend > HWD_VIIF_L1_HDRC_MAX_BLEND_LUMA) {
+		return -EINVAL;
+	}
+
+	writel((param->hdrc_ratio - HWD_VIIF_L1_HDRC_RATIO_OFFSET),
+	       &res->capture_reg->l1isp.L1_HDRC_RATIO);
+	writel(param->hdrc_pt_ratio, &res->capture_reg->l1isp.L1_HDRC_PT_RATIO);
+
+	writel(param->hdrc_pt_blend, &res->capture_reg->l1isp.L1_HDRC_PT_BLEND);
+	writel(param->hdrc_pt_blend2, &res->capture_reg->l1isp.L1_HDRC_PT_BLEND2);
+
+	writel(param->hdrc_pt_sat, &res->capture_reg->l1isp.L1_HDRC_PT_SAT);
+	writel(param->hdrc_tn_type, &res->capture_reg->l1isp.L1_HDRC_TN_TYPE);
+
+	writel(param->hdrc_utn_tbl[0], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL0);
+	writel(param->hdrc_utn_tbl[1], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL1);
+	writel(param->hdrc_utn_tbl[2], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL2);
+	writel(param->hdrc_utn_tbl[3], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL3);
+	writel(param->hdrc_utn_tbl[4], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL4);
+	writel(param->hdrc_utn_tbl[5], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL5);
+	writel(param->hdrc_utn_tbl[6], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL6);
+	writel(param->hdrc_utn_tbl[7], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL7);
+	writel(param->hdrc_utn_tbl[8], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL8);
+	writel(param->hdrc_utn_tbl[9], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL9);
+	writel(param->hdrc_utn_tbl[10], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL10);
+	writel(param->hdrc_utn_tbl[11], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL11);
+	writel(param->hdrc_utn_tbl[12], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL12);
+	writel(param->hdrc_utn_tbl[13], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL13);
+	writel(param->hdrc_utn_tbl[14], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL14);
+	writel(param->hdrc_utn_tbl[15], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL15);
+	writel(param->hdrc_utn_tbl[16], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL16);
+	writel(param->hdrc_utn_tbl[17], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL17);
+	writel(param->hdrc_utn_tbl[18], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL18);
+	writel(param->hdrc_utn_tbl[19], &res->capture_reg->l1isp.L1_HDRC_UTN_TBL19);
+
+	writel(param->hdrc_flr_val, &res->capture_reg->l1isp.L1_HDRC_FLR_VAL);
+	writel(param->hdrc_flr_adp, &res->capture_reg->l1isp.L1_HDRC_FLR_ADP);
+
+	writel(param->hdrc_ybr_off, &res->capture_reg->l1isp.L1_HDRC_YBR_OFF);
+	writel(param->hdrc_orgy_blend, &res->capture_reg->l1isp.L1_HDRC_ORGY_BLEND);
+
+	val = ((readl(&res->capture_reg->l1isp.L1_SYSM_HEIGHT)) % 64U) / 2U;
+	writel(val, &res->capture_reg->l1isp.L1_HDRC_MAR_TOP);
+	val = ((readl(&res->capture_reg->l1isp.L1_SYSM_WIDTH)) % 64U) / 2U;
+	writel(val, &res->capture_reg->l1isp.L1_HDRC_MAR_LEFT);
+
+	writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_HDRC_EN);
+
+	/* update of sw_delay1 must be done when MAIN unit is NOT running. */
+	if (!res->run_flag_main) {
+		sw_delay1 = (u32)((HWD_VIIF_REGBUF_ACCESS_TIME * (u64)res->pixel_clock) /
+				  ((u64)res->htotal_size * HWD_VIIF_SYS_CLK)) +
+			    HWD_VIIF_L1_DELAY_W_HDRC + 1U;
+		val = readl(&res->capture_reg->sys.INT_M1_LINE) & 0xffffU;
+		val |= (sw_delay1 << 16U);
+		writel(val, &res->capture_reg->sys.INT_M1_LINE);
+		/* M2_LINE is the same condition as M1_LINE */
+		writel(val, &res->capture_reg->sys.INT_M2_LINE);
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_hdrc_ltm() - Configure L1ISP HDR compression local tone mapping parameters.
+ *
+ * @param: pointer to HDR compression local tone mapping parameters
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL
+ * - "param" is NULL
+ * - each parameter of "param" is out of range
+ */
+s32 hwd_viif_l1_set_hdrc_ltm(u32 module_id, const struct viif_l1_hdrc_ltm_config *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val;
+	u32 idx;
+
+	if (!param || param->tnp_max >= HWD_VIIF_L1_HDRC_MAX_LTM_TONE_BLEND_RATIO ||
+	    param->tnp_mag >= HWD_VIIF_L1_HDRC_MAX_LTM_MAGNIFICATION) {
+		return -EINVAL;
+	}
+
+	val = (u32)param->tnp_fil[0];
+	for (idx = 1; idx < 5U; idx++)
+		val += (u32)param->tnp_fil[idx] * 2U;
+
+	if (val != 1024U)
+		return -EINVAL;
+
+	writel(param->tnp_max, &res->capture_reg->l1isp.L1_HDRC_TNP_MAX);
+
+	writel(param->tnp_mag, &res->capture_reg->l1isp.L1_HDRC_TNP_MAG);
+
+	writel((u32)param->tnp_fil[0], &res->capture_reg->l1isp.L1_HDRC_TNP_FIL0);
+	writel((u32)param->tnp_fil[1], &res->capture_reg->l1isp.L1_HDRC_TNP_FIL1);
+	writel((u32)param->tnp_fil[2], &res->capture_reg->l1isp.L1_HDRC_TNP_FIL2);
+	writel((u32)param->tnp_fil[3], &res->capture_reg->l1isp.L1_HDRC_TNP_FIL3);
+	writel((u32)param->tnp_fil[4], &res->capture_reg->l1isp.L1_HDRC_TNP_FIL4);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_gamma() - Configure L1ISP gamma correction parameters.
+ *
+ * @param: pointer to gamma correction parameters
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ */
+s32 hwd_viif_l1_set_gamma(u32 module_id, const struct viif_l1_gamma *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 idx;
+
+	if (!param) {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_PGC_SW);
+		return 0;
+	}
+
+	for (idx = 0; idx < 44U; idx++) {
+		if (param->gam_p[idx] > HWD_VIIF_L1_GAMMA_MAX_VAL)
+			return -EINVAL;
+	}
+
+	writel(param->gam_p[0], &res->capture_reg->l1isp.L1_VPRO_GAM01P);
+	writel(param->gam_p[1], &res->capture_reg->l1isp.L1_VPRO_GAM02P);
+	writel(param->gam_p[2], &res->capture_reg->l1isp.L1_VPRO_GAM03P);
+	writel(param->gam_p[3], &res->capture_reg->l1isp.L1_VPRO_GAM04P);
+	writel(param->gam_p[4], &res->capture_reg->l1isp.L1_VPRO_GAM05P);
+	writel(param->gam_p[5], &res->capture_reg->l1isp.L1_VPRO_GAM06P);
+	writel(param->gam_p[6], &res->capture_reg->l1isp.L1_VPRO_GAM07P);
+	writel(param->gam_p[7], &res->capture_reg->l1isp.L1_VPRO_GAM08P);
+	writel(param->gam_p[8], &res->capture_reg->l1isp.L1_VPRO_GAM09P);
+	writel(param->gam_p[9], &res->capture_reg->l1isp.L1_VPRO_GAM10P);
+	writel(param->gam_p[10], &res->capture_reg->l1isp.L1_VPRO_GAM11P);
+	writel(param->gam_p[11], &res->capture_reg->l1isp.L1_VPRO_GAM12P);
+	writel(param->gam_p[12], &res->capture_reg->l1isp.L1_VPRO_GAM13P);
+	writel(param->gam_p[13], &res->capture_reg->l1isp.L1_VPRO_GAM14P);
+	writel(param->gam_p[14], &res->capture_reg->l1isp.L1_VPRO_GAM15P);
+	writel(param->gam_p[15], &res->capture_reg->l1isp.L1_VPRO_GAM16P);
+	writel(param->gam_p[16], &res->capture_reg->l1isp.L1_VPRO_GAM17P);
+	writel(param->gam_p[17], &res->capture_reg->l1isp.L1_VPRO_GAM18P);
+	writel(param->gam_p[18], &res->capture_reg->l1isp.L1_VPRO_GAM19P);
+	writel(param->gam_p[19], &res->capture_reg->l1isp.L1_VPRO_GAM20P);
+	writel(param->gam_p[20], &res->capture_reg->l1isp.L1_VPRO_GAM21P);
+	writel(param->gam_p[21], &res->capture_reg->l1isp.L1_VPRO_GAM22P);
+	writel(param->gam_p[22], &res->capture_reg->l1isp.L1_VPRO_GAM23P);
+	writel(param->gam_p[23], &res->capture_reg->l1isp.L1_VPRO_GAM24P);
+	writel(param->gam_p[24], &res->capture_reg->l1isp.L1_VPRO_GAM25P);
+	writel(param->gam_p[25], &res->capture_reg->l1isp.L1_VPRO_GAM26P);
+	writel(param->gam_p[26], &res->capture_reg->l1isp.L1_VPRO_GAM27P);
+	writel(param->gam_p[27], &res->capture_reg->l1isp.L1_VPRO_GAM28P);
+	writel(param->gam_p[28], &res->capture_reg->l1isp.L1_VPRO_GAM29P);
+	writel(param->gam_p[29], &res->capture_reg->l1isp.L1_VPRO_GAM30P);
+	writel(param->gam_p[30], &res->capture_reg->l1isp.L1_VPRO_GAM31P);
+	writel(param->gam_p[31], &res->capture_reg->l1isp.L1_VPRO_GAM32P);
+	writel(param->gam_p[32], &res->capture_reg->l1isp.L1_VPRO_GAM33P);
+	writel(param->gam_p[33], &res->capture_reg->l1isp.L1_VPRO_GAM34P);
+	writel(param->gam_p[34], &res->capture_reg->l1isp.L1_VPRO_GAM35P);
+	writel(param->gam_p[35], &res->capture_reg->l1isp.L1_VPRO_GAM36P);
+	writel(param->gam_p[36], &res->capture_reg->l1isp.L1_VPRO_GAM37P);
+	writel(param->gam_p[37], &res->capture_reg->l1isp.L1_VPRO_GAM38P);
+	writel(param->gam_p[38], &res->capture_reg->l1isp.L1_VPRO_GAM39P);
+	writel(param->gam_p[39], &res->capture_reg->l1isp.L1_VPRO_GAM40P);
+	writel(param->gam_p[40], &res->capture_reg->l1isp.L1_VPRO_GAM41P);
+	writel(param->gam_p[41], &res->capture_reg->l1isp.L1_VPRO_GAM42P);
+	writel(param->gam_p[42], &res->capture_reg->l1isp.L1_VPRO_GAM43P);
+	writel(param->gam_p[43], &res->capture_reg->l1isp.L1_VPRO_GAM44P);
+	writel(param->blkadj, &res->capture_reg->l1isp.L1_VPRO_BLKADJ);
+	writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_PGC_SW);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_img_quality_adjustment() - Configure L1ISP image quality adjustment.
+ *
+ * @param: pointer to image quality adjustment parameters; NULL means disabling
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ */
+s32 hwd_viif_l1_set_img_quality_adjustment(u32 module_id,
+					   const struct hwd_viif_l1_img_quality_adjustment *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 val;
+
+	if (!param) {
+		/* disable all features when param is absent */
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_YUVC_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_BRIGHT_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_LCNT_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_NLCNT_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_YNR_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_ETE_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_CSUP_UVSUP_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_SW);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_SW);
+		writel(1024U, &res->capture_reg->l1isp.L1_VPRO_CB_GAIN);
+		writel(1024U, &res->capture_reg->l1isp.L1_VPRO_CR_GAIN);
+		writel(1024U, &res->capture_reg->l1isp.L1_VPRO_CBR_MGAIN_MIN);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CB_P_GAIN_MAX);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CB_M_GAIN_MAX);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CR_P_GAIN_MAX);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CR_M_GAIN_MAX);
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_CNR_SW);
+
+		return 0;
+	}
+
+	if (param->lum_noise_reduction) {
+		if (param->lum_noise_reduction->gain_min > param->lum_noise_reduction->gain_max ||
+		    param->lum_noise_reduction->lim_min > param->lum_noise_reduction->lim_max) {
+			return -EINVAL;
+		}
+	}
+
+	if (param->edge_enhancement) {
+		if (param->edge_enhancement->gain_min > param->edge_enhancement->gain_max ||
+		    param->edge_enhancement->lim_min > param->edge_enhancement->lim_max ||
+		    param->edge_enhancement->coring_min > param->edge_enhancement->coring_max) {
+			return -EINVAL;
+		}
+	}
+
+	if (param->uv_suppression) {
+		if (param->uv_suppression->bk_mp >= HWD_VIIF_L1_SUPPRESSION_MAX_VAL ||
+		    param->uv_suppression->black >= HWD_VIIF_L1_SUPPRESSION_MAX_VAL ||
+		    param->uv_suppression->wh_mp >= HWD_VIIF_L1_SUPPRESSION_MAX_VAL ||
+		    param->uv_suppression->white >= HWD_VIIF_L1_SUPPRESSION_MAX_VAL ||
+		    param->uv_suppression->bk_slv >= param->uv_suppression->wh_slv)
+			return -EINVAL;
+	}
+
+	if (param->coring_suppression) {
+		if (param->coring_suppression->gain_min > param->coring_suppression->gain_max ||
+		    param->coring_suppression->lv_min > param->coring_suppression->lv_max)
+			return -EINVAL;
+	}
+
+	if (param->edge_suppression) {
+		if (param->edge_suppression->lim > HWD_VIIF_L1_EDGE_SUPPRESSION_MAX_LIMIT)
+			return -EINVAL;
+	}
+
+	if (param->color_level) {
+		if (param->color_level->cb_gain >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN ||
+		    param->color_level->cr_gain >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN ||
+		    param->color_level->cbr_mgain_min >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN ||
+		    param->color_level->cbp_gain_max >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN ||
+		    param->color_level->cbm_gain_max >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN ||
+		    param->color_level->crp_gain_max >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN ||
+		    param->color_level->crm_gain_max >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN) {
+			return -EINVAL;
+		}
+	}
+
+	if (param->color_noise_reduction_enable != HWD_VIIF_ENABLE &&
+	    param->color_noise_reduction_enable != HWD_VIIF_DISABLE) {
+		return -EINVAL;
+	}
+
+	/* RGB to YUV */
+	writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_YUVC_SW);
+	writel((u32)param->coef_cb, &res->capture_reg->l1isp.L1_VPRO_CB_MAT);
+	writel((u32)param->coef_cr, &res->capture_reg->l1isp.L1_VPRO_CR_MAT);
+
+	/* brightness */
+	val = (u32)param->brightness & 0xffffU;
+	if (val != 0U) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_BRIGHT_SW);
+		writel(val, &res->capture_reg->l1isp.L1_VPRO_BRIGHT);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_BRIGHT_SW);
+	}
+
+	/* linear contrast */
+	if ((u32)param->linear_contrast != 128U) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_LCNT_SW);
+		writel((u32)param->linear_contrast, &res->capture_reg->l1isp.L1_VPRO_LCONT_LEV);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_LCNT_SW);
+	}
+
+	/* nonlinear contrast */
+	if (param->nonlinear_contrast) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_NLCNT_SW);
+		writel((u32)param->nonlinear_contrast->blk_knee,
+		       &res->capture_reg->l1isp.L1_VPRO_BLK_KNEE);
+		writel((u32)param->nonlinear_contrast->wht_knee,
+		       &res->capture_reg->l1isp.L1_VPRO_WHT_KNEE);
+
+		writel((u32)param->nonlinear_contrast->blk_cont[0],
+		       &res->capture_reg->l1isp.L1_VPRO_BLK_CONT0);
+		writel((u32)param->nonlinear_contrast->blk_cont[1],
+		       &res->capture_reg->l1isp.L1_VPRO_BLK_CONT1);
+		writel((u32)param->nonlinear_contrast->blk_cont[2],
+		       &res->capture_reg->l1isp.L1_VPRO_BLK_CONT2);
+
+		writel((u32)param->nonlinear_contrast->wht_cont[0],
+		       &res->capture_reg->l1isp.L1_VPRO_WHT_CONT0);
+		writel((u32)param->nonlinear_contrast->wht_cont[1],
+		       &res->capture_reg->l1isp.L1_VPRO_WHT_CONT1);
+		writel((u32)param->nonlinear_contrast->wht_cont[2],
+		       &res->capture_reg->l1isp.L1_VPRO_WHT_CONT2);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_NLCNT_SW);
+	}
+
+	/* luminance noise reduction */
+	if (param->lum_noise_reduction) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_YNR_SW);
+		writel((u32)param->lum_noise_reduction->gain_min,
+		       &res->capture_reg->l1isp.L1_VPRO_YNR_GAIN_MIN);
+		writel((u32)param->lum_noise_reduction->gain_max,
+		       &res->capture_reg->l1isp.L1_VPRO_YNR_GAIN_MAX);
+		writel((u32)param->lum_noise_reduction->lim_min,
+		       &res->capture_reg->l1isp.L1_VPRO_YNR_LIM_MIN);
+		writel((u32)param->lum_noise_reduction->lim_max,
+		       &res->capture_reg->l1isp.L1_VPRO_YNR_LIM_MAX);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_YNR_SW);
+	}
+
+	/* edge enhancement */
+	if (param->edge_enhancement) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_ETE_SW);
+		writel((u32)param->edge_enhancement->gain_min,
+		       &res->capture_reg->l1isp.L1_VPRO_ETE_GAIN_MIN);
+		writel((u32)param->edge_enhancement->gain_max,
+		       &res->capture_reg->l1isp.L1_VPRO_ETE_GAIN_MAX);
+		writel((u32)param->edge_enhancement->lim_min,
+		       &res->capture_reg->l1isp.L1_VPRO_ETE_LIM_MIN);
+		writel((u32)param->edge_enhancement->lim_max,
+		       &res->capture_reg->l1isp.L1_VPRO_ETE_LIM_MAX);
+		writel((u32)param->edge_enhancement->coring_min,
+		       &res->capture_reg->l1isp.L1_VPRO_ETE_CORING_MIN);
+		writel((u32)param->edge_enhancement->coring_max,
+		       &res->capture_reg->l1isp.L1_VPRO_ETE_CORING_MAX);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_ETE_SW);
+	}
+
+	/* UV suppression */
+	if (param->uv_suppression) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_CSUP_UVSUP_SW);
+		writel((u32)param->uv_suppression->bk_slv,
+		       &res->capture_reg->l1isp.L1_VPRO_CSUP_BK_SLV);
+		writel(param->uv_suppression->bk_mp, &res->capture_reg->l1isp.L1_VPRO_CSUP_BK_MP);
+		writel(param->uv_suppression->black, &res->capture_reg->l1isp.L1_VPRO_CSUP_BLACK);
+
+		writel((u32)param->uv_suppression->wh_slv,
+		       &res->capture_reg->l1isp.L1_VPRO_CSUP_WH_SLV);
+		writel(param->uv_suppression->wh_mp, &res->capture_reg->l1isp.L1_VPRO_CSUP_WH_MP);
+		writel(param->uv_suppression->white, &res->capture_reg->l1isp.L1_VPRO_CSUP_WHITE);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_CSUP_UVSUP_SW);
+	}
+
+	/* coring suppression */
+	if (param->coring_suppression) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_SW);
+		writel((u32)param->coring_suppression->lv_min,
+		       &res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_LV_MIN);
+		writel((u32)param->coring_suppression->lv_max,
+		       &res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_LV_MAX);
+		writel((u32)param->coring_suppression->gain_min,
+		       &res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_GAIN_MIN);
+		writel((u32)param->coring_suppression->gain_max,
+		       &res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_GAIN_MAX);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_SW);
+	}
+
+	/* edge suppression */
+	if (param->edge_suppression) {
+		writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_SW);
+		writel((u32)param->edge_suppression->gain,
+		       &res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_GAIN);
+		writel((u32)param->edge_suppression->lim,
+		       &res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_LIM);
+	} else {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_SW);
+	}
+
+	/* color level */
+	if (param->color_level) {
+		writel(param->color_level->cb_gain, &res->capture_reg->l1isp.L1_VPRO_CB_GAIN);
+		writel(param->color_level->cr_gain, &res->capture_reg->l1isp.L1_VPRO_CR_GAIN);
+		writel(param->color_level->cbr_mgain_min,
+		       &res->capture_reg->l1isp.L1_VPRO_CBR_MGAIN_MIN);
+		writel(param->color_level->cbp_gain_max,
+		       &res->capture_reg->l1isp.L1_VPRO_CB_P_GAIN_MAX);
+		writel(param->color_level->cbm_gain_max,
+		       &res->capture_reg->l1isp.L1_VPRO_CB_M_GAIN_MAX);
+		writel(param->color_level->crp_gain_max,
+		       &res->capture_reg->l1isp.L1_VPRO_CR_P_GAIN_MAX);
+		writel(param->color_level->crm_gain_max,
+		       &res->capture_reg->l1isp.L1_VPRO_CR_M_GAIN_MAX);
+	} else {
+		/* disable */
+		writel(1024U, &res->capture_reg->l1isp.L1_VPRO_CB_GAIN);
+		writel(1024U, &res->capture_reg->l1isp.L1_VPRO_CR_GAIN);
+		writel(1024U, &res->capture_reg->l1isp.L1_VPRO_CBR_MGAIN_MIN);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CB_P_GAIN_MAX);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CB_M_GAIN_MAX);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CR_P_GAIN_MAX);
+		writel(0U, &res->capture_reg->l1isp.L1_VPRO_CR_M_GAIN_MAX);
+	}
+
+	/* color noise reduction */
+	writel(param->color_noise_reduction_enable, &res->capture_reg->l1isp.L1_VPRO_CNR_SW);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_avg_lum_generation() - Configure L1ISP average luminance generation parameters.
+ *
+ * @param: pointer to auto exposure parameters
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ */
+s32 hwd_viif_l1_set_avg_lum_generation(u32 module_id,
+				       const struct viif_l1_avg_lum_generation_config *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	u32 idx, j;
+	u32 val;
+
+	if (!param) {
+		writel(HWD_VIIF_DISABLE, &res->capture_reg->l1isp.L1_AEXP_ON);
+		return 0;
+	}
+
+	val = readl(&res->capture_reg->l1isp.L1_SYSM_WIDTH);
+	if (param->aexp_start_x > (val - 1U))
+		return -EINVAL;
+
+	if (param->aexp_block_width < HWD_VIIF_L1_AEXP_MIN_BLOCK_WIDTH ||
+	    param->aexp_block_width > val) {
+		return -EINVAL;
+	}
+	if (param->aexp_block_width % 64U)
+		return -EINVAL;
+
+	val = readl(&res->capture_reg->l1isp.L1_SYSM_HEIGHT);
+	if (param->aexp_start_y > (val - 1U))
+		return -EINVAL;
+
+	if (param->aexp_block_height < HWD_VIIF_L1_AEXP_MIN_BLOCK_HEIGHT ||
+	    param->aexp_block_height > val) {
+		return -EINVAL;
+	}
+	if (param->aexp_block_height % 64U)
+		return -EINVAL;
+
+	for (idx = 0; idx < 8U; idx++) {
+		for (j = 0; j < 8U; j++) {
+			if (param->aexp_weight[idx][j] > HWD_VIIF_L1_AEXP_MAX_WEIGHT)
+				return -EINVAL;
+		}
+	}
+
+	if (param->aexp_satur_ratio > HWD_VIIF_L1_AEXP_MAX_BLOCK_TH ||
+	    param->aexp_black_ratio > HWD_VIIF_L1_AEXP_MAX_BLOCK_TH ||
+	    param->aexp_satur_level > HWD_VIIF_L1_AEXP_MAX_SATURATION_PIXEL_TH) {
+		return -EINVAL;
+	}
+
+	for (idx = 0; idx < 4U; idx++) {
+		if (param->aexp_ave4linesy[idx] > (val - 4U))
+			return -EINVAL;
+	}
+
+	writel(HWD_VIIF_ENABLE, &res->capture_reg->l1isp.L1_AEXP_ON);
+	writel(param->aexp_start_x, &res->capture_reg->l1isp.L1_AEXP_START_X);
+	writel(param->aexp_start_y, &res->capture_reg->l1isp.L1_AEXP_START_Y);
+	writel(param->aexp_block_width, &res->capture_reg->l1isp.L1_AEXP_BLOCK_WIDTH);
+	writel(param->aexp_block_height, &res->capture_reg->l1isp.L1_AEXP_BLOCK_HEIGHT);
+
+	val = (param->aexp_weight[0][0] << 14U) | (param->aexp_weight[0][1] << 12U) |
+	      (param->aexp_weight[0][2] << 10U) | (param->aexp_weight[0][3] << 8U) |
+	      (param->aexp_weight[0][4] << 6U) | (param->aexp_weight[0][5] << 4U) |
+	      (param->aexp_weight[0][6] << 2U) | (param->aexp_weight[0][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_0);
+
+	val = (param->aexp_weight[1][0] << 14U) | (param->aexp_weight[1][1] << 12U) |
+	      (param->aexp_weight[1][2] << 10U) | (param->aexp_weight[1][3] << 8U) |
+	      (param->aexp_weight[1][4] << 6U) | (param->aexp_weight[1][5] << 4U) |
+	      (param->aexp_weight[1][6] << 2U) | (param->aexp_weight[1][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_1);
+
+	val = (param->aexp_weight[2][0] << 14U) | (param->aexp_weight[2][1] << 12U) |
+	      (param->aexp_weight[2][2] << 10U) | (param->aexp_weight[2][3] << 8U) |
+	      (param->aexp_weight[2][4] << 6U) | (param->aexp_weight[2][5] << 4U) |
+	      (param->aexp_weight[2][6] << 2U) | (param->aexp_weight[2][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_2);
+
+	val = (param->aexp_weight[3][0] << 14U) | (param->aexp_weight[3][1] << 12U) |
+	      (param->aexp_weight[3][2] << 10U) | (param->aexp_weight[3][3] << 8U) |
+	      (param->aexp_weight[3][4] << 6U) | (param->aexp_weight[3][5] << 4U) |
+	      (param->aexp_weight[3][6] << 2U) | (param->aexp_weight[3][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_3);
+
+	val = (param->aexp_weight[4][0] << 14U) | (param->aexp_weight[4][1] << 12U) |
+	      (param->aexp_weight[4][2] << 10U) | (param->aexp_weight[4][3] << 8U) |
+	      (param->aexp_weight[4][4] << 6U) | (param->aexp_weight[4][5] << 4U) |
+	      (param->aexp_weight[4][6] << 2U) | (param->aexp_weight[4][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_4);
+
+	val = (param->aexp_weight[5][0] << 14U) | (param->aexp_weight[5][1] << 12U) |
+	      (param->aexp_weight[5][2] << 10U) | (param->aexp_weight[5][3] << 8U) |
+	      (param->aexp_weight[5][4] << 6U) | (param->aexp_weight[5][5] << 4U) |
+	      (param->aexp_weight[5][6] << 2U) | (param->aexp_weight[5][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_5);
+
+	val = (param->aexp_weight[6][0] << 14U) | (param->aexp_weight[6][1] << 12U) |
+	      (param->aexp_weight[6][2] << 10U) | (param->aexp_weight[6][3] << 8U) |
+	      (param->aexp_weight[6][4] << 6U) | (param->aexp_weight[6][5] << 4U) |
+	      (param->aexp_weight[6][6] << 2U) | (param->aexp_weight[6][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_6);
+
+	val = (param->aexp_weight[7][0] << 14U) | (param->aexp_weight[7][1] << 12U) |
+	      (param->aexp_weight[7][2] << 10U) | (param->aexp_weight[7][3] << 8U) |
+	      (param->aexp_weight[7][4] << 6U) | (param->aexp_weight[7][5] << 4U) |
+	      (param->aexp_weight[7][6] << 2U) | (param->aexp_weight[7][7]);
+	writel(val, &res->capture_reg->l1isp.L1_AEXP_WEIGHT_7);
+
+	writel(param->aexp_satur_ratio, &res->capture_reg->l1isp.L1_AEXP_SATUR_RATIO);
+	writel(param->aexp_black_ratio, &res->capture_reg->l1isp.L1_AEXP_BLACK_RATIO);
+	writel(param->aexp_satur_level, &res->capture_reg->l1isp.L1_AEXP_SATUR_LEVEL);
+
+	writel(param->aexp_ave4linesy[0], &res->capture_reg->l1isp.L1_AEXP_AVE4LINESY0);
+	writel(param->aexp_ave4linesy[1], &res->capture_reg->l1isp.L1_AEXP_AVE4LINESY1);
+	writel(param->aexp_ave4linesy[2], &res->capture_reg->l1isp.L1_AEXP_AVE4LINESY2);
+	writel(param->aexp_ave4linesy[3], &res->capture_reg->l1isp.L1_AEXP_AVE4LINESY3);
+
+	return 0;
+}
+
+/**
+ * hwd_viif_l1_set_irq_mask() - Set L1ISP interruption mask.
+ *
+ * @mask: mask setting
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_viif_l1_set_irq_mask(u32 module_id, u32 mask)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	writel(mask, &res->capture_reg->l1isp.L1_CRGBF_ISP_INT_MASK);
+}
diff --git a/drivers/media/platform/visconti/hwd_viif_reg.h b/drivers/media/platform/visconti/hwd_viif_reg.h
new file mode 100644
index 000000000..b7f43c5fe
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif_reg.h
@@ -0,0 +1,2802 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef HWD_VIIF_REG_H
+#define HWD_VIIF_REG_H
+
+/**
+ * struct hwd_viif_csi2host_reg - Registers for VIIF CSI2HOST control
+ */
+struct hwd_viif_csi2host_reg {
+	u32 RESERVED_A_1;
+	u32 CSI2RX_NLANES;
+	u32 CSI2RX_RESETN;
+	u32 CSI2RX_INT_ST_MAIN;
+	u32 CSI2RX_DATA_IDS_1;
+	u32 CSI2RX_DATA_IDS_2;
+	u32 RESERVED_B_1[10];
+	u32 CSI2RX_PHY_SHUTDOWNZ;
+	u32 CSI2RX_PHY_RSTZ;
+	u32 CSI2RX_PHY_RX;
+	u32 CSI2RX_PHY_STOPSTATE;
+	u32 CSI2RX_PHY_TESTCTRL0;
+	u32 CSI2RX_PHY_TESTCTRL1;
+	u32 RESERVED_B_2[34];
+	u32 CSI2RX_INT_ST_PHY_FATAL;
+	u32 CSI2RX_INT_MSK_PHY_FATAL;
+	u32 CSI2RX_INT_FORCE_PHY_FATAL;
+	u32 RESERVED_B_3[1];
+	u32 CSI2RX_INT_ST_PKT_FATAL;
+	u32 CSI2RX_INT_MSK_PKT_FATAL;
+	u32 CSI2RX_INT_FORCE_PKT_FATAL;
+	u32 RESERVED_B_4[1];
+	u32 CSI2RX_INT_ST_FRAME_FATAL;
+	u32 CSI2RX_INT_MSK_FRAME_FATAL;
+	u32 CSI2RX_INT_FORCE_FRAME_FATAL;
+	u32 RESERVED_B_5[1];
+	u32 CSI2RX_INT_ST_PHY;
+	u32 CSI2RX_INT_MSK_PHY;
+	u32 CSI2RX_INT_FORCE_PHY;
+	u32 RESERVED_B_6[1];
+	u32 CSI2RX_INT_ST_PKT;
+	u32 CSI2RX_INT_MSK_PKT;
+	u32 CSI2RX_INT_FORCE_PKT;
+	u32 RESERVED_B_7[1];
+	u32 CSI2RX_INT_ST_LINE;
+	u32 CSI2RX_INT_MSK_LINE;
+	u32 CSI2RX_INT_FORCE_LINE;
+	u32 RESERVED_B_8[113];
+	u32 RESERVED_A_2;
+	u32 RESERVED_A_3;
+	u32 RESERVED_A_4;
+	u32 RESERVED_A_5;
+	u32 RESERVED_A_6;
+	u32 RESERVED_B_9[58];
+	u32 RESERVED_A_7;
+};
+
+/**
+ * struct hwd_viif_csc_reg - Registers for VIIF system control
+ */
+struct hwd_viif_csc_reg {
+	u32 MTB;
+	u32 RESERVED_B_16[3];
+	u32 MTB_YG_OFFSETI;
+	u32 MTB_YG1;
+	u32 MTB_YG2;
+	u32 MTB_YG_OFFSETO;
+	u32 MTB_CB_OFFSETI;
+	u32 MTB_CB1;
+	u32 MTB_CB2;
+	u32 MTB_CB_OFFSETO;
+	u32 MTB_CR_OFFSETI;
+	u32 MTB_CR1;
+	u32 MTB_CR2;
+	u32 MTB_CR_OFFSETO;
+};
+
+struct hwd_viif_system_reg {
+	u32 IPORTM0_LD;
+	u32 IPORTM1_LD;
+	u32 RESERVED_B_1[6];
+	u32 IPORTS0_LD;
+	u32 RESERVED_A_1;
+	u32 RESERVED_B_2[2];
+	u32 VCID0SELECT;
+	u32 VCID1SELECT;
+	u32 RESERVED_A_2;
+	u32 VCPORTEN;
+	u32 CSI2SELECT;
+	u32 CSI2THROUGHEN;
+	u32 RESERVED_B_3[2];
+	u32 IPORTM_TEST;
+	u32 IPORTM;
+	u32 IPORTM_MAIN_DT;
+	u32 IPORTM_MAIN_RAW;
+	u32 IPORTM_OTHER;
+	u32 IPORTM_OTHEREN;
+	u32 IPORTM_EMBEN;
+	u32 RESERVED_B_4[2];
+	u32 IPORTS;
+	u32 IPORTS_MAIN_DT;
+	u32 IPORTS_MAIN_RAW;
+	u32 IPORTS_OTHER;
+	u32 IPORTS_OTHEREN;
+	u32 IPORTS_EMBEN;
+	u32 IPORTS_IMGEN;
+	u32 RESERVED_A_3;
+	u32 RESERVED_A_4;
+	u32 RESERVED_B_5[2];
+	u32 IPORTI_M_SYNCEN;
+	u32 IPORTI_M_SYNCMODE;
+	u32 IPORTI_M_PIXFMT;
+	u32 RESERVED_B_6[5];
+	u32 TOTALSIZE_M;
+	u32 VALSIZE_M;
+	u32 BACK_PORCH_M;
+	u32 RESERVED_B_7[5];
+	u32 MAINIMG_PKTSIZE;
+	u32 MAINIMG_HEIGHT;
+	u32 MAINOTHER_PKTSIZE;
+	u32 MAINOTHER_HEIGHT;
+	u32 MAINEMBTOP_SIZE;
+	u32 MAINEMBBOT_SIZE;
+	u32 RESERVED_B_8[2];
+	u32 SUBIMG_PKTSIZE;
+	u32 SUBIMG_HEIGHT;
+	u32 SUBOTHER_PKTSIZE;
+	u32 SUBOTHER_HEIGHT;
+	u32 SUBEMBTOP_SIZE;
+	u32 SUBEMBBOT_SIZE;
+	u32 RESERVED_A_5;
+	u32 RESERVED_A_6;
+	u32 TESTAREA_M_START;
+	u32 TESTAREA_M_SIZE;
+	u32 RESERVED_B_9[2];
+	u32 INT_M_SYNC;
+	u32 INT_M_SYNC_MASK;
+	u32 INT_S_SYNC;
+	u32 INT_S_SYNC_MASK;
+	u32 INT_M0_LINE;
+	u32 INT_M1_LINE;
+	u32 INT_M2_LINE;
+	u32 RESERVED_B_10[5];
+	u32 INT_SA0_LINE;
+	u32 INT_SA1_LINE;
+	u32 RESERVED_B_11[2];
+	u32 RESERVED_A_9;
+	u32 RESERVED_A_10;
+	u32 RESERVED_B_12[2];
+	u32 INT_M_STATUS;
+	u32 INT_M_MASK;
+	u32 INT_S_STATUS;
+	u32 INT_S_MASK;
+	u32 RESERVED_B_13[28];
+	u32 MAIN_TEST_DEN;
+	u32 RESERVED_B_14[3];
+	u32 PREPROCCESS_FMTM;
+	u32 PREPROCCESS_C24M;
+	u32 FRAMEPACK_M;
+	u32 RESERVED_B_15[1];
+	struct hwd_viif_csc_reg l2isp_input_csc;
+	u32 COM0_CK_ENABLE;
+	u32 RESERVED_A_13;
+	u32 RESERVED_A_14;
+	u32 RESERVED_B_17[1];
+	u32 COM0EN;
+	u32 RESERVED_A_16;
+	u32 RESERVED_A_17;
+	u32 RESERVED_B_18[33];
+	u32 COM0_CAP_OFFSET;
+	u32 COM0_CAP_SIZE;
+	u32 RESERVED_B_19[18];
+	u32 GAMMA_M;
+	u32 RESERVED_B_20[3];
+	u32 COM0_C_SELECT;
+	u32 RESERVED_B_21[3];
+	struct hwd_viif_csc_reg com0_csc;
+	u32 COM0_OPORTALP;
+	u32 COM0_OPORTFMT;
+	u32 RESERVED_B_23[2];
+	u32 RESERVED_A_37;
+	u32 RESERVED_A_38;
+	u32 RESERVED_A_39;
+	u32 RESERVED_B_24[1];
+	u32 RESERVED_A_40;
+	u32 RESERVED_A_41;
+	u32 RESERVED_A_42;
+	u32 RESERVED_B_25[1];
+	u32 RESERVED_A_43;
+	u32 RESERVED_A_44;
+	u32 RESERVED_A_45;
+	u32 RESERVED_B_26[1];
+	u32 RESERVED_A_46;
+	u32 RESERVED_B_27[3];
+	u32 RESERVED_A_47;
+	u32 RESERVED_A_48;
+	u32 RESERVED_B_28[18];
+	u32 RESERVED_A_49;
+	u32 RESERVED_B_29[3];
+	u32 RESERVED_A_50;
+	u32 RESERVED_B_30[3];
+	u32 RESERVED_A_51;
+	u32 RESERVED_B_31[3];
+	u32 RESERVED_A_52;
+	u32 RESERVED_A_53;
+	u32 RESERVED_A_54;
+	u32 RESERVED_A_55;
+	u32 RESERVED_A_56;
+	u32 RESERVED_A_57;
+	u32 RESERVED_A_58;
+	u32 RESERVED_A_59;
+	u32 RESERVED_A_60;
+	u32 RESERVED_A_61;
+	u32 RESERVED_A_62;
+	u32 RESERVED_A_63;
+	u32 RESERVED_A_64;
+	u32 RESERVED_A_65;
+	u32 RESERVED_B_32[2];
+	u32 RESERVED_A_66;
+	u32 RESERVED_A_67;
+	u32 RESERVED_A_68;
+	u32 RESERVED_B_33[1];
+	u32 RESERVED_A_69;
+	u32 RESERVED_A_70;
+	u32 RESERVED_A_71;
+	u32 RESERVED_B_34[1];
+	u32 RESERVED_A_72;
+	u32 RESERVED_A_73;
+	u32 RESERVED_A_74;
+	u32 RESERVED_B_35[1];
+	u32 RESERVED_A_75;
+	u32 RESERVED_B_36[3];
+	u32 RESERVED_A_76;
+	u32 RESERVED_A_77;
+	u32 RESERVED_B_37[18];
+	u32 RESERVED_A_78;
+	u32 RESERVED_B_38[3];
+	u32 RESERVED_A_79;
+	u32 RESERVED_B_39[3];
+	u32 RESERVED_A_80;
+	u32 RESERVED_B_40[3];
+	u32 RESERVED_A_81;
+	u32 RESERVED_A_82;
+	u32 RESERVED_A_83;
+	u32 RESERVED_A_84;
+	u32 RESERVED_A_85;
+	u32 RESERVED_A_86;
+	u32 RESERVED_A_87;
+	u32 RESERVED_A_88;
+	u32 RESERVED_A_89;
+	u32 RESERVED_A_90;
+	u32 RESERVED_A_91;
+	u32 RESERVED_A_92;
+	u32 RESERVED_A_93;
+	u32 RESERVED_A_94;
+	u32 RESERVED_B_41[2];
+	u32 RESERVED_A_95;
+	u32 RESERVED_A_96;
+	u32 RESERVED_A_97;
+	u32 RESERVED_B_42[1];
+	u32 RESERVED_A_98;
+	u32 RESERVED_A_99;
+	u32 RESERVED_A_100;
+	u32 RESERVED_B_43[1];
+	u32 RESERVED_A_101;
+	u32 RESERVED_A_102;
+	u32 RESERVED_A_103;
+	u32 RESERVED_B_44[1];
+	u32 RESERVED_A_104;
+	u32 RESERVED_B_45[3];
+	u32 FN_M0;
+	u32 FN_M1;
+	u32 FN_M2;
+	u32 RESERVED_B_46[5];
+	u32 FN_SA0;
+	u32 FN_SA1;
+	u32 RESERVED_B_47[2];
+	u32 RESERVED_A_105;
+	u32 RESERVED_A_106;
+	u32 RESERVED_B_48[18];
+	u32 LBIST_STAT;
+	u32 MEM_ECC_DCLS_ALARM;
+	u32 RESERVED_B_49[30];
+	u32 DPHY_FREQRANGE;
+	u32 RESERVED_B_50[3];
+	u32 DPHY_LANE;
+	u32 RESERVED_B_51[59];
+	u32 INT_SOURCE;
+	u32 DPGM_VSYNC_SOURCE;
+	u32 RESERVED_B_52[23];
+	u32 RESERVED_A_107;
+	u32 RESERVED_A_108;
+	u32 RESERVED_B_53[6];
+	u32 RESERVED_A_109;
+	u32 RESERVED_A_110;
+	u32 RESERVED_A_111;
+	u32 RESERVED_B_54[1];
+	u32 RESERVED_A_112;
+	u32 RESERVED_B_55[35];
+	u32 RESERVED_A_113;
+	u32 RESERVED_B_56[54];
+	u32 RESERVED_A_114;
+	u32 RESERVED_B_57[3];
+	u32 RESERVED_A_115;
+	u32 RESERVED_A_116;
+	u32 RESERVED_A_117;
+	u32 RESERVED_B_58[1];
+	u32 RESERVED_A_118;
+	u32 RESERVED_B_59[3];
+	u32 RESERVED_A_119;
+	u32 RESERVED_A_120;
+	u32 RESERVED_A_121;
+	u32 RESERVED_A_122;
+	u32 RESERVED_A_123;
+	u32 RESERVED_A_124;
+	u32 RESERVED_A_125;
+	u32 RESERVED_A_126;
+	u32 RESERVED_A_127;
+	u32 RESERVED_A_128;
+	u32 RESERVED_A_129;
+	u32 RESERVED_A_130;
+	u32 RESERVED_B_60[4];
+	u32 RESERVED_A_131;
+	u32 RESERVED_A_132;
+	u32 RESERVED_A_133;
+	u32 RESERVED_B_61[33];
+	u32 RESERVED_A_134;
+	u32 RESERVED_A_135;
+	u32 RESERVED_B_62[18];
+	u32 RESERVED_A_136;
+	u32 RESERVED_B_63[3];
+	u32 RESERVED_A_137;
+	u32 RESERVED_B_64[3];
+	u32 RESERVED_A_138;
+	u32 RESERVED_B_65[3];
+	u32 RESERVED_A_139;
+	u32 RESERVED_A_140;
+	u32 RESERVED_A_141;
+	u32 RESERVED_A_142;
+	u32 RESERVED_A_143;
+	u32 RESERVED_A_144;
+	u32 RESERVED_A_145;
+	u32 RESERVED_A_146;
+	u32 RESERVED_A_147;
+	u32 RESERVED_A_148;
+	u32 RESERVED_A_149;
+	u32 RESERVED_A_150;
+	u32 RESERVED_A_151;
+	u32 RESERVED_A_152;
+	u32 RESERVED_B_66[2];
+	u32 RESERVED_A_153;
+	u32 RESERVED_A_154;
+	u32 RESERVED_A_155;
+	u32 RESERVED_B_67[1];
+	u32 RESERVED_A_156;
+	u32 RESERVED_A_157;
+	u32 RESERVED_A_158;
+	u32 RESERVED_B_68[1];
+	u32 RESERVED_A_159;
+	u32 RESERVED_A_160;
+	u32 RESERVED_A_161;
+	u32 RESERVED_B_69[1];
+	u32 RESERVED_A_162;
+	u32 RESERVED_B_70[3];
+	u32 RESERVED_A_163;
+	u32 RESERVED_A_164;
+	u32 RESERVED_B_71[18];
+	u32 RESERVED_A_165;
+	u32 RESERVED_B_72[3];
+	u32 RESERVED_A_166;
+	u32 RESERVED_B_73[3];
+	u32 RESERVED_A_167;
+	u32 RESERVED_B_74[3];
+	u32 RESERVED_A_168;
+	u32 RESERVED_A_169;
+	u32 RESERVED_A_170;
+	u32 RESERVED_A_171;
+	u32 RESERVED_A_172;
+	u32 RESERVED_A_173;
+	u32 RESERVED_A_174;
+	u32 RESERVED_A_175;
+	u32 RESERVED_A_176;
+	u32 RESERVED_A_177;
+	u32 RESERVED_A_178;
+	u32 RESERVED_A_179;
+	u32 RESERVED_A_180;
+	u32 RESERVED_A_181;
+	u32 RESERVED_B_75[2];
+	u32 RESERVED_A_182;
+	u32 RESERVED_A_183;
+	u32 RESERVED_A_184;
+	u32 RESERVED_B_76[1];
+	u32 RESERVED_A_185;
+	u32 RESERVED_A_186;
+	u32 RESERVED_A_187;
+	u32 RESERVED_B_77[1];
+	u32 RESERVED_A_188;
+	u32 RESERVED_A_189;
+	u32 RESERVED_A_190;
+	u32 RESERVED_B_78[1];
+	u32 RESERVED_A_191;
+	u32 RESERVED_B_79[3];
+	u32 RESERVED_A_192;
+	u32 RESERVED_A_193;
+	u32 RESERVED_B_80[18];
+	u32 RESERVED_A_194;
+	u32 RESERVED_B_81[3];
+	u32 RESERVED_A_195;
+	u32 RESERVED_B_82[3];
+	u32 RESERVED_A_196;
+	u32 RESERVED_B_83[3];
+	u32 RESERVED_A_197;
+	u32 RESERVED_A_198;
+	u32 RESERVED_A_199;
+	u32 RESERVED_A_200;
+	u32 RESERVED_A_201;
+	u32 RESERVED_A_202;
+	u32 RESERVED_A_203;
+	u32 RESERVED_A_204;
+	u32 RESERVED_A_205;
+	u32 RESERVED_A_206;
+	u32 RESERVED_A_207;
+	u32 RESERVED_A_208;
+	u32 RESERVED_A_209;
+	u32 RESERVED_A_210;
+	u32 RESERVED_B_84[2];
+	u32 RESERVED_A_211;
+	u32 RESERVED_A_212;
+	u32 RESERVED_A_213;
+	u32 RESERVED_B_85[1];
+	u32 RESERVED_A_214;
+	u32 RESERVED_A_215;
+	u32 RESERVED_A_216;
+	u32 RESERVED_B_86[1];
+	u32 RESERVED_A_217;
+	u32 RESERVED_A_218;
+	u32 RESERVED_A_219;
+	u32 RESERVED_B_87[1];
+	u32 RESERVED_A_220;
+	u32 RESERVED_B_88[130];
+	u32 RESERVED_A_221;
+};
+
+/**
+ * struct hwd_viif_vdm_table_group_reg - Registers for VIIF vdm control
+ */
+struct hwd_viif_vdm_table_group_reg {
+	u32 VDM_T_CFG;
+	u32 VDM_T_SRAM_BASE;
+	u32 VDM_T_SRAM_SIZE;
+	u32 RESERVED_A_4;
+};
+
+struct hwd_viif_vdm_table_port_reg {
+	u32 VDM_T_STADR;
+	u32 VDM_T_SIZE;
+};
+
+struct hwd_viif_vdm_read_port_reg {
+	u32 VDM_R_STADR;
+	u32 VDM_R_ENDADR;
+	u32 VDM_R_HEIGHT;
+	u32 VDM_R_PITCH;
+	u32 VDM_R_CFG0;
+	u32 RESERVED_A_11;
+	u32 VDM_R_SRAM_BASE;
+	u32 VDM_R_SRAM_SIZE;
+	u32 RESERVED_A_12;
+	u32 RESERVED_B_5[7];
+};
+
+struct hwd_viif_vdm_write_port_reg {
+	u32 VDM_W_STADR;
+	u32 VDM_W_ENDADR;
+	u32 VDM_W_HEIGHT;
+	u32 VDM_W_PITCH;
+	u32 VDM_W_CFG0;
+	u32 RESERVED_A_17;
+	u32 VDM_W_SRAM_BASE;
+	u32 VDM_W_SRAM_SIZE;
+	u32 RESERVED_A_18;
+	u32 RESERVED_B_8[7];
+};
+
+struct hwd_viif_vdm_write_port_buf_reg {
+	u32 VDM_W_STADR_BUF;
+	u32 RESERVED_A_120;
+	u32 RESERVED_A_121;
+	u32 RESERVED_A_122;
+	u32 RESERVED_A_123;
+	u32 RESERVED_A_124;
+	u32 RESERVED_B_20[2];
+};
+
+struct hwd_viif_vdm_reg {
+	u32 RESERVED_A_1;
+	u32 RESERVED_A_2;
+	u32 RESERVED_B_1[4];
+	u32 RESERVED_A_3;
+	u32 VDM_CFG;
+	u32 VDM_INT_MASK;
+	u32 RESERVED_B_2[3];
+	u32 VDM_R_ENABLE;
+	u32 VDM_W_ENABLE;
+	u32 VDM_T_ENABLE;
+	u32 VDM_ABORTSET;
+	struct hwd_viif_vdm_table_group_reg t_group[4];
+	u32 RESERVED_A_8;
+	u32 RESERVED_A_9;
+	u32 RESERVED_A_10;
+	u32 RESERVED_A_11;
+	u32 RESERVED_B_3[28];
+	struct hwd_viif_vdm_table_port_reg t_port[24];
+	u32 RESERVED_A_14;
+	u32 RESERVED_A_15;
+	u32 RESERVED_A_16;
+	u32 RESERVED_A_17;
+	u32 RESERVED_A_18;
+	u32 RESERVED_A_19;
+	u32 RESERVED_A_20;
+	u32 RESERVED_A_21;
+	u32 RESERVED_A_22;
+	u32 RESERVED_A_23;
+	u32 RESERVED_A_24;
+	u32 RESERVED_A_25;
+	u32 RESERVED_B_4[4];
+	struct hwd_viif_vdm_read_port_reg r_port[3];
+	u32 RESERVED_B_7[16];
+	struct hwd_viif_vdm_write_port_reg w_port[6];
+	u32 RESERVED_A_29;
+	u32 RESERVED_A_30;
+	u32 RESERVED_A_31;
+	u32 RESERVED_A_32;
+	u32 RESERVED_A_33;
+	u32 RESERVED_A_34;
+	u32 RESERVED_A_35;
+	u32 RESERVED_A_36;
+	u32 RESERVED_A_37;
+	u32 RESERVED_B_14[215];
+	u32 RESERVED_A_38;
+	u32 RESERVED_A_39;
+	u32 RESERVED_A_40;
+	u32 RESERVED_B_15[61];
+	u32 RESERVED_A_41;
+	u32 RESERVED_A_42;
+	u32 RESERVED_A_43;
+	u32 RESERVED_A_44;
+	u32 RESERVED_A_45;
+	u32 RESERVED_A_46;
+	u32 RESERVED_A_47;
+	u32 RESERVED_A_48;
+	u32 RESERVED_A_49;
+	u32 RESERVED_A_50;
+	u32 RESERVED_A_51;
+	u32 RESERVED_A_52;
+	u32 RESERVED_A_53;
+	u32 RESERVED_A_54;
+	u32 RESERVED_A_55;
+	u32 RESERVED_A_56;
+	u32 RESERVED_A_57;
+	u32 RESERVED_A_58;
+	u32 RESERVED_A_59;
+	u32 RESERVED_A_60;
+	u32 RESERVED_A_61;
+	u32 RESERVED_A_62;
+	u32 RESERVED_A_63;
+	u32 RESERVED_A_64;
+	u32 RESERVED_A_65;
+	u32 RESERVED_A_66;
+	u32 RESERVED_A_67;
+	u32 RESERVED_A_68;
+	u32 RESERVED_A_69;
+	u32 RESERVED_A_70;
+	u32 RESERVED_A_71;
+	u32 RESERVED_A_72;
+	u32 RESERVED_A_73;
+	u32 RESERVED_A_74;
+	u32 RESERVED_A_75;
+	u32 RESERVED_A_76;
+	u32 RESERVED_A_77;
+	u32 RESERVED_A_78;
+	u32 RESERVED_A_79;
+	u32 RESERVED_A_80;
+	u32 RESERVED_A_81;
+	u32 RESERVED_A_82;
+	u32 RESERVED_A_83;
+	u32 RESERVED_A_84;
+	u32 RESERVED_A_85;
+	u32 RESERVED_A_86;
+	u32 RESERVED_A_87;
+	u32 RESERVED_A_88;
+	u32 RESERVED_A_89;
+	u32 RESERVED_A_90;
+	u32 RESERVED_A_91;
+	u32 RESERVED_A_92;
+	u32 RESERVED_A_93;
+	u32 RESERVED_A_94;
+	u32 RESERVED_A_95;
+	u32 RESERVED_A_96;
+	u32 RESERVED_A_97;
+	u32 RESERVED_A_98;
+	u32 RESERVED_A_99;
+	u32 RESERVED_A_100;
+	u32 RESERVED_B_16[4];
+	u32 RESERVED_A_101;
+	u32 RESERVED_A_102;
+	u32 RESERVED_A_103;
+	u32 RESERVED_A_104;
+	u32 RESERVED_A_105;
+	u32 RESERVED_A_106;
+	u32 RESERVED_B_17[2];
+	u32 RESERVED_A_107;
+	u32 RESERVED_A_108;
+	u32 RESERVED_A_109;
+	u32 RESERVED_A_110;
+	u32 RESERVED_A_111;
+	u32 RESERVED_A_112;
+	u32 RESERVED_B_18[2];
+	u32 RESERVED_A_113;
+	u32 RESERVED_A_114;
+	u32 RESERVED_A_115;
+	u32 RESERVED_A_116;
+	u32 RESERVED_A_117;
+	u32 RESERVED_A_118;
+	u32 RESERVED_B_19[42];
+	struct hwd_viif_vdm_write_port_buf_reg w_port_buf[6];
+	u32 RESERVED_A_155;
+	u32 RESERVED_A_156;
+	u32 RESERVED_A_157;
+	u32 RESERVED_A_158;
+	u32 RESERVED_A_159;
+	u32 RESERVED_A_160;
+	u32 RESERVED_B_26[138];
+	u32 RESERVED_A_161;
+	u32 VDM_INT;
+	u32 RESERVED_A_162;
+	u32 RESERVED_A_163;
+	u32 VDM_R_STOP;
+	u32 VDM_W_STOP;
+	u32 VDM_R_RUN;
+	u32 VDM_W_RUN;
+	u32 VDM_T_RUN;
+	u32 RESERVED_B_27[7];
+	u32 RESERVED_A_164;
+	u32 RESERVED_A_165;
+	u32 RESERVED_A_166;
+	u32 RESERVED_A_167;
+	u32 RESERVED_B_28[12];
+	u32 RESERVED_A_168;
+	u32 RESERVED_A_169;
+	u32 RESERVED_A_170;
+	u32 RESERVED_A_171;
+	u32 RESERVED_A_172;
+	u32 RESERVED_B_29[27];
+	u32 RESERVED_A_173;
+	u32 RESERVED_A_174;
+	u32 RESERVED_A_175;
+	u32 RESERVED_A_176;
+	u32 RESERVED_A_177;
+	u32 RESERVED_A_178;
+	u32 RESERVED_B_30[10];
+	u32 RESERVED_A_179;
+	u32 RESERVED_A_180;
+	u32 RESERVED_A_181;
+	u32 RESERVED_A_182;
+	u32 RESERVED_A_183;
+	u32 RESERVED_A_184;
+	u32 RESERVED_A_185;
+	u32 RESERVED_A_186;
+	u32 RESERVED_A_187;
+	u32 RESERVED_A_188;
+	u32 RESERVED_A_189;
+	u32 RESERVED_A_190;
+	u32 RESERVED_A_191;
+	u32 RESERVED_A_192;
+	u32 RESERVED_B_31[33];
+	u32 RESERVED_A_193;
+};
+
+/**
+ * struct hwd_viif_l1isp_reg - Registers for VIIF L1ISP control
+ */
+struct hwd_viif_l1isp_reg {
+	u32 L1_SYSM_WIDTH;
+	u32 L1_SYSM_HEIGHT;
+	u32 L1_SYSM_START_COLOR;
+	u32 L1_SYSM_INPUT_MODE;
+	u32 RESERVED_A_1;
+	u32 L1_SYSM_YCOEF_R;
+	u32 L1_SYSM_YCOEF_G;
+	u32 L1_SYSM_YCOEF_B;
+	u32 L1_SYSM_INT_STAT;
+	u32 L1_SYSM_INT_MASKED_STAT;
+	u32 L1_SYSM_INT_MASK;
+	u32 RESERVED_A_2;
+	u32 RESERVED_A_3;
+	u32 RESERVED_A_4;
+	u32 RESERVED_B_1[2];
+	u32 L1_SYSM_AG_H;
+	u32 L1_SYSM_AG_M;
+	u32 L1_SYSM_AG_L;
+	u32 L1_SYSM_AG_PARAM_A;
+	u32 L1_SYSM_AG_PARAM_B;
+	u32 L1_SYSM_AG_PARAM_C;
+	u32 L1_SYSM_AG_PARAM_D;
+	u32 L1_SYSM_AG_SEL_HOBC;
+	u32 L1_SYSM_AG_SEL_ABPC;
+	u32 L1_SYSM_AG_SEL_RCNR;
+	u32 L1_SYSM_AG_SEL_LSSC;
+	u32 L1_SYSM_AG_SEL_MPRO;
+	u32 L1_SYSM_AG_SEL_VPRO;
+	u32 L1_SYSM_AG_CONT_HOBC01_EN;
+	u32 L1_SYSM_AG_CONT_HOBC2_EN;
+	u32 L1_SYSM_AG_CONT_ABPC01_EN;
+	u32 L1_SYSM_AG_CONT_ABPC2_EN;
+	u32 L1_SYSM_AG_CONT_RCNR01_EN;
+	u32 L1_SYSM_AG_CONT_RCNR2_EN;
+	u32 L1_SYSM_AG_CONT_LSSC_EN;
+	u32 L1_SYSM_AG_CONT_MPRO_EN;
+	u32 L1_SYSM_AG_CONT_VPRO_EN;
+	u32 L1_SYSM_CTXT;
+	u32 L1_SYSM_MAN_CTXT;
+	u32 RESERVED_A_5;
+	u32 RESERVED_B_2[7];
+	u32 RESERVED_A_6;
+	u32 L1_HDRE_SRCPOINT00;
+	u32 L1_HDRE_SRCPOINT01;
+	u32 L1_HDRE_SRCPOINT02;
+	u32 L1_HDRE_SRCPOINT03;
+	u32 L1_HDRE_SRCPOINT04;
+	u32 L1_HDRE_SRCPOINT05;
+	u32 L1_HDRE_SRCPOINT06;
+	u32 L1_HDRE_SRCPOINT07;
+	u32 L1_HDRE_SRCPOINT08;
+	u32 L1_HDRE_SRCPOINT09;
+	u32 L1_HDRE_SRCPOINT10;
+	u32 L1_HDRE_SRCPOINT11;
+	u32 L1_HDRE_SRCPOINT12;
+	u32 L1_HDRE_SRCPOINT13;
+	u32 L1_HDRE_SRCPOINT14;
+	u32 L1_HDRE_SRCPOINT15;
+	u32 L1_HDRE_SRCBASE00;
+	u32 L1_HDRE_SRCBASE01;
+	u32 L1_HDRE_SRCBASE02;
+	u32 L1_HDRE_SRCBASE03;
+	u32 L1_HDRE_SRCBASE04;
+	u32 L1_HDRE_SRCBASE05;
+	u32 L1_HDRE_SRCBASE06;
+	u32 L1_HDRE_SRCBASE07;
+	u32 L1_HDRE_SRCBASE08;
+	u32 L1_HDRE_SRCBASE09;
+	u32 L1_HDRE_SRCBASE10;
+	u32 L1_HDRE_SRCBASE11;
+	u32 L1_HDRE_SRCBASE12;
+	u32 L1_HDRE_SRCBASE13;
+	u32 L1_HDRE_SRCBASE14;
+	u32 L1_HDRE_SRCBASE15;
+	u32 L1_HDRE_SRCBASE16;
+	u32 L1_HDRE_RATIO00;
+	u32 L1_HDRE_RATIO01;
+	u32 L1_HDRE_RATIO02;
+	u32 L1_HDRE_RATIO03;
+	u32 L1_HDRE_RATIO04;
+	u32 L1_HDRE_RATIO05;
+	u32 L1_HDRE_RATIO06;
+	u32 L1_HDRE_RATIO07;
+	u32 L1_HDRE_RATIO08;
+	u32 L1_HDRE_RATIO09;
+	u32 L1_HDRE_RATIO10;
+	u32 L1_HDRE_RATIO11;
+	u32 L1_HDRE_RATIO12;
+	u32 L1_HDRE_RATIO13;
+	u32 L1_HDRE_RATIO14;
+	u32 L1_HDRE_RATIO15;
+	u32 L1_HDRE_RATIO16;
+	u32 L1_HDRE_DSTBASE00;
+	u32 L1_HDRE_DSTBASE01;
+	u32 L1_HDRE_DSTBASE02;
+	u32 L1_HDRE_DSTBASE03;
+	u32 L1_HDRE_DSTBASE04;
+	u32 L1_HDRE_DSTBASE05;
+	u32 L1_HDRE_DSTBASE06;
+	u32 L1_HDRE_DSTBASE07;
+	u32 L1_HDRE_DSTBASE08;
+	u32 L1_HDRE_DSTBASE09;
+	u32 L1_HDRE_DSTBASE10;
+	u32 L1_HDRE_DSTBASE11;
+	u32 L1_HDRE_DSTBASE12;
+	u32 L1_HDRE_DSTBASE13;
+	u32 L1_HDRE_DSTBASE14;
+	u32 L1_HDRE_DSTBASE15;
+	u32 L1_HDRE_DSTBASE16;
+	u32 L1_HDRE_DSTMAXVAL;
+	u32 RESERVED_B_3[11];
+	u32 L1_AEXP_ON;
+	u32 L1_AEXP_RESULT_AVE;
+	u32 RESERVED_A_7;
+	u32 L1_AEXP_FORCE_INTERRUPT_Y;
+	u32 L1_AEXP_START_X;
+	u32 L1_AEXP_START_Y;
+	u32 L1_AEXP_BLOCK_WIDTH;
+	u32 L1_AEXP_BLOCK_HEIGHT;
+	u32 L1_AEXP_WEIGHT_0;
+	u32 L1_AEXP_WEIGHT_1;
+	u32 L1_AEXP_WEIGHT_2;
+	u32 L1_AEXP_WEIGHT_3;
+	u32 L1_AEXP_WEIGHT_4;
+	u32 L1_AEXP_WEIGHT_5;
+	u32 L1_AEXP_WEIGHT_6;
+	u32 L1_AEXP_WEIGHT_7;
+	u32 L1_AEXP_SATUR_RATIO;
+	u32 L1_AEXP_BLACK_RATIO;
+	u32 L1_AEXP_SATUR_LEVEL;
+	u32 RESERVED_A_8;
+	/* [y][x] */
+	u32 L1_AEXP_AVE[8][8];
+	u32 L1_AEXP_SATUR_BLACK_PIXNUM;
+	u32 L1_AEXP_AVE4LINESY0;
+	u32 L1_AEXP_AVE4LINESY1;
+	u32 L1_AEXP_AVE4LINESY2;
+	u32 L1_AEXP_AVE4LINESY3;
+	u32 L1_AEXP_AVE4LINES0;
+	u32 L1_AEXP_AVE4LINES1;
+	u32 L1_AEXP_AVE4LINES2;
+	u32 L1_AEXP_AVE4LINES3;
+	u32 RESERVED_B_4[3];
+	u32 L1_IBUF_DEPTH;
+	u32 L1_IBUF_INPUT_ORDER;
+	u32 RESERVED_B_5[2];
+	u32 L1_SLIC_SRCBLACKLEVEL_GR;
+	u32 L1_SLIC_SRCBLACKLEVEL_R;
+	u32 L1_SLIC_SRCBLACKLEVEL_B;
+	u32 L1_SLIC_SRCBLACKLEVEL_GB;
+	u32 RESERVED_A_9;
+	u32 RESERVED_A_10;
+	u32 RESERVED_A_11;
+	u32 RESERVED_A_12;
+	u32 RESERVED_A_13;
+	u32 RESERVED_B_6[19];
+	u32 RESERVED_A_14;
+	u32 RESERVED_A_15;
+	u32 L1_ABPC012_AG_CONT;
+	u32 L1_ABPC012_STA_EN;
+	u32 L1_ABPC012_DYN_EN;
+	u32 L1_ABPC012_DYN_MODE;
+	u32 RESERVED_A_16;
+	u32 RESERVED_A_17;
+	u32 RESERVED_A_18;
+	u32 L1_ABPC0_RATIO_LIMIT;
+	u32 RESERVED_A_19;
+	u32 L1_ABPC0_DARK_LIMIT;
+	u32 L1_ABPC0_SN_COEF_W_AG_MIN;
+	u32 L1_ABPC0_SN_COEF_W_AG_MID;
+	u32 L1_ABPC0_SN_COEF_W_AG_MAX;
+	u32 L1_ABPC0_SN_COEF_W_TH_MIN;
+	u32 L1_ABPC0_SN_COEF_W_TH_MAX;
+	u32 L1_ABPC0_SN_COEF_B_AG_MIN;
+	u32 L1_ABPC0_SN_COEF_B_AG_MID;
+	u32 L1_ABPC0_SN_COEF_B_AG_MAX;
+	u32 L1_ABPC0_SN_COEF_B_TH_MIN;
+	u32 L1_ABPC0_SN_COEF_B_TH_MAX;
+	u32 RESERVED_A_20;
+	u32 L1_ABPC0_DETECT;
+	u32 L1_ABPC1_RATIO_LIMIT;
+	u32 RESERVED_A_21;
+	u32 L1_ABPC1_DARK_LIMIT;
+	u32 L1_ABPC1_SN_COEF_W_AG_MIN;
+	u32 L1_ABPC1_SN_COEF_W_AG_MID;
+	u32 L1_ABPC1_SN_COEF_W_AG_MAX;
+	u32 L1_ABPC1_SN_COEF_W_TH_MIN;
+	u32 L1_ABPC1_SN_COEF_W_TH_MAX;
+	u32 L1_ABPC1_SN_COEF_B_AG_MIN;
+	u32 L1_ABPC1_SN_COEF_B_AG_MID;
+	u32 L1_ABPC1_SN_COEF_B_AG_MAX;
+	u32 L1_ABPC1_SN_COEF_B_TH_MIN;
+	u32 L1_ABPC1_SN_COEF_B_TH_MAX;
+	u32 RESERVED_A_22;
+	u32 L1_ABPC1_DETECT;
+	u32 L1_ABPC2_RATIO_LIMIT;
+	u32 RESERVED_A_23;
+	u32 L1_ABPC2_DARK_LIMIT;
+	u32 L1_ABPC2_SN_COEF_W_AG_MIN;
+	u32 L1_ABPC2_SN_COEF_W_AG_MID;
+	u32 L1_ABPC2_SN_COEF_W_AG_MAX;
+	u32 L1_ABPC2_SN_COEF_W_TH_MIN;
+	u32 L1_ABPC2_SN_COEF_W_TH_MAX;
+	u32 L1_ABPC2_SN_COEF_B_AG_MIN;
+	u32 L1_ABPC2_SN_COEF_B_AG_MID;
+	u32 L1_ABPC2_SN_COEF_B_AG_MAX;
+	u32 L1_ABPC2_SN_COEF_B_TH_MIN;
+	u32 L1_ABPC2_SN_COEF_B_TH_MAX;
+	u32 RESERVED_A_24;
+	u32 L1_ABPC2_DETECT;
+	u32 RESERVED_B_7[42];
+	u32 RESERVED_A_25;
+	u32 L1_PWHB_H_GR;
+	u32 L1_PWHB_HR;
+	u32 L1_PWHB_HB;
+	u32 L1_PWHB_H_GB;
+	u32 L1_PWHB_M_GR;
+	u32 L1_PWHB_MR;
+	u32 L1_PWHB_MB;
+	u32 L1_PWHB_M_GB;
+	u32 L1_PWHB_L_GR;
+	u32 L1_PWHB_LR;
+	u32 L1_PWHB_LB;
+	u32 L1_PWHB_L_GB;
+	u32 L1_PWHB_DSTMAXVAL;
+	u32 RESERVED_B_8[18];
+	u32 L1_RCNR0_AG_CONT;
+	u32 RESERVED_A_26;
+	u32 L1_RCNR0_SW;
+	u32 L1_RCNR0_CNF_DARK_AG0;
+	u32 L1_RCNR0_CNF_DARK_AG1;
+	u32 L1_RCNR0_CNF_DARK_AG2;
+	u32 L1_RCNR0_CNF_RATIO_AG0;
+	u32 L1_RCNR0_CNF_RATIO_AG1;
+	u32 L1_RCNR0_CNF_RATIO_AG2;
+	u32 L1_RCNR0_CNF_CLIP_GAIN_R;
+	u32 L1_RCNR0_CNF_CLIP_GAIN_G;
+	u32 L1_RCNR0_CNF_CLIP_GAIN_B;
+	u32 L1_RCNR0_A1L_DARK_AG0;
+	u32 L1_RCNR0_A1L_DARK_AG1;
+	u32 L1_RCNR0_A1L_DARK_AG2;
+	u32 L1_RCNR0_A1L_RATIO_AG0;
+	u32 L1_RCNR0_A1L_RATIO_AG1;
+	u32 L1_RCNR0_A1L_RATIO_AG2;
+	u32 L1_RCNR0_INF_ZERO_CLIP;
+	u32 RESERVED_A_27;
+	u32 L1_RCNR0_MERGE_D2BLEND_AG0;
+	u32 L1_RCNR0_MERGE_D2BLEND_AG1;
+	u32 L1_RCNR0_MERGE_D2BLEND_AG2;
+	u32 L1_RCNR0_MERGE_BLACK;
+	u32 L1_RCNR0_MERGE_MINDIV;
+	u32 L1_RCNR0_HRY_TYPE;
+	u32 L1_RCNR0_ANF_BLEND_AG0;
+	u32 L1_RCNR0_ANF_BLEND_AG1;
+	u32 L1_RCNR0_ANF_BLEND_AG2;
+	u32 RESERVED_A_28;
+	u32 L1_RCNR0_LPF_THRESHOLD;
+	u32 L1_RCNR0_MERGE_HLBLEND_AG0;
+	u32 L1_RCNR0_MERGE_HLBLEND_AG1;
+	u32 L1_RCNR0_MERGE_HLBLEND_AG2;
+	u32 L1_RCNR0_GNR_SW;
+	u32 L1_RCNR0_GNR_RATIO;
+	u32 L1_RCNR0_GNR_WIDE_EN;
+	u32 L1_RCNR1_AG_CONT;
+	u32 RESERVED_A_29;
+	u32 L1_RCNR1_SW;
+	u32 L1_RCNR1_CNF_DARK_AG0;
+	u32 L1_RCNR1_CNF_DARK_AG1;
+	u32 L1_RCNR1_CNF_DARK_AG2;
+	u32 L1_RCNR1_CNF_RATIO_AG0;
+	u32 L1_RCNR1_CNF_RATIO_AG1;
+	u32 L1_RCNR1_CNF_RATIO_AG2;
+	u32 L1_RCNR1_CNF_CLIP_GAIN_R;
+	u32 L1_RCNR1_CNF_CLIP_GAIN_G;
+	u32 L1_RCNR1_CNF_CLIP_GAIN_B;
+	u32 L1_RCNR1_A1L_DARK_AG0;
+	u32 L1_RCNR1_A1L_DARK_AG1;
+	u32 L1_RCNR1_A1L_DARK_AG2;
+	u32 L1_RCNR1_A1L_RATIO_AG0;
+	u32 L1_RCNR1_A1L_RATIO_AG1;
+	u32 L1_RCNR1_A1L_RATIO_AG2;
+	u32 L1_RCNR1_INF_ZERO_CLIP;
+	u32 RESERVED_A_30;
+	u32 L1_RCNR1_MERGE_D2BLEND_AG0;
+	u32 L1_RCNR1_MERGE_D2BLEND_AG1;
+	u32 L1_RCNR1_MERGE_D2BLEND_AG2;
+	u32 L1_RCNR1_MERGE_BLACK;
+	u32 L1_RCNR1_MERGE_MINDIV;
+	u32 L1_RCNR1_HRY_TYPE;
+	u32 L1_RCNR1_ANF_BLEND_AG0;
+	u32 L1_RCNR1_ANF_BLEND_AG1;
+	u32 L1_RCNR1_ANF_BLEND_AG2;
+	u32 RESERVED_A_31;
+	u32 L1_RCNR1_LPF_THRESHOLD;
+	u32 L1_RCNR1_MERGE_HLBLEND_AG0;
+	u32 L1_RCNR1_MERGE_HLBLEND_AG1;
+	u32 L1_RCNR1_MERGE_HLBLEND_AG2;
+	u32 L1_RCNR1_GNR_SW;
+	u32 L1_RCNR1_GNR_RATIO;
+	u32 L1_RCNR1_GNR_WIDE_EN;
+	u32 L1_RCNR2_AG_CONT;
+	u32 RESERVED_A_32;
+	u32 L1_RCNR2_SW;
+	u32 L1_RCNR2_CNF_DARK_AG0;
+	u32 L1_RCNR2_CNF_DARK_AG1;
+	u32 L1_RCNR2_CNF_DARK_AG2;
+	u32 L1_RCNR2_CNF_RATIO_AG0;
+	u32 L1_RCNR2_CNF_RATIO_AG1;
+	u32 L1_RCNR2_CNF_RATIO_AG2;
+	u32 L1_RCNR2_CNF_CLIP_GAIN_R;
+	u32 L1_RCNR2_CNF_CLIP_GAIN_G;
+	u32 L1_RCNR2_CNF_CLIP_GAIN_B;
+	u32 L1_RCNR2_A1L_DARK_AG0;
+	u32 L1_RCNR2_A1L_DARK_AG1;
+	u32 L1_RCNR2_A1L_DARK_AG2;
+	u32 L1_RCNR2_A1L_RATIO_AG0;
+	u32 L1_RCNR2_A1L_RATIO_AG1;
+	u32 L1_RCNR2_A1L_RATIO_AG2;
+	u32 L1_RCNR2_INF_ZERO_CLIP;
+	u32 RESERVED_A_33;
+	u32 L1_RCNR2_MERGE_D2BLEND_AG0;
+	u32 L1_RCNR2_MERGE_D2BLEND_AG1;
+	u32 L1_RCNR2_MERGE_D2BLEND_AG2;
+	u32 L1_RCNR2_MERGE_BLACK;
+	u32 L1_RCNR2_MERGE_MINDIV;
+	u32 L1_RCNR2_HRY_TYPE;
+	u32 L1_RCNR2_ANF_BLEND_AG0;
+	u32 L1_RCNR2_ANF_BLEND_AG1;
+	u32 L1_RCNR2_ANF_BLEND_AG2;
+	u32 RESERVED_A_34;
+	u32 L1_RCNR2_LPF_THRESHOLD;
+	u32 L1_RCNR2_MERGE_HLBLEND_AG0;
+	u32 L1_RCNR2_MERGE_HLBLEND_AG1;
+	u32 L1_RCNR2_MERGE_HLBLEND_AG2;
+	u32 L1_RCNR2_GNR_SW;
+	u32 L1_RCNR2_GNR_RATIO;
+	u32 L1_RCNR2_GNR_WIDE_EN;
+	u32 RESERVED_B_9[49];
+	u32 RESERVED_A_35;
+	u32 L1_HDRS_HDRRATIO_M;
+	u32 L1_HDRS_HDRRATIO_L;
+	u32 L1_HDRS_HDRRATIO_E;
+	u32 RESERVED_A_36;
+	u32 RESERVED_A_37;
+	u32 L1_HDRS_BLENDEND_H;
+	u32 L1_HDRS_BLENDEND_M;
+	u32 L1_HDRS_BLENDEND_E;
+	u32 L1_HDRS_BLENDBEG_H;
+	u32 L1_HDRS_BLENDBEG_M;
+	u32 L1_HDRS_BLENDBEG_E;
+	u32 RESERVED_A_38;
+	u32 RESERVED_A_39;
+	u32 RESERVED_A_40;
+	u32 RESERVED_A_41;
+	u32 RESERVED_A_42;
+	u32 RESERVED_A_43;
+	u32 L1_HDRS_DG_H;
+	u32 L1_HDRS_DG_M;
+	u32 L1_HDRS_DG_L;
+	u32 L1_HDRS_DG_E;
+	u32 L1_HDRS_LEDMODE_ON;
+	u32 L1_HDRS_HDRMODE;
+	u32 RESERVED_A_44;
+	u32 RESERVED_A_45;
+	u32 RESERVED_A_46;
+	u32 L1_HDRS_DSTMAXVAL;
+	u32 RESERVED_B_10[4];
+	u32 L1_BLVC_SRCBLACKLEVEL_GR;
+	u32 L1_BLVC_SRCBLACKLEVEL_R;
+	u32 L1_BLVC_SRCBLACKLEVEL_B;
+	u32 L1_BLVC_SRCBLACKLEVELGB;
+	u32 L1_BLVC_MULTVAL_GR;
+	u32 L1_BLVC_MULTVAL_R;
+	u32 L1_BLVC_MULTVAL_B;
+	u32 L1_BLVC_MULTVAL_GB;
+	u32 L1_BLVC_DSTMAXVAL;
+	u32 RESERVED_A_47;
+	u32 RESERVED_A_48;
+	u32 RESERVED_A_49;
+	u32 RESERVED_A_50;
+	u32 RESERVED_A_51;
+	u32 RESERVED_A_52;
+	u32 RESERVED_B_11[17];
+	u32 L1_LSSC_EN;
+	u32 L1_LSSC_AG_CONT;
+	u32 RESERVED_A_53;
+	u32 RESERVED_A_54;
+	u32 L1_LSSC_PWHB_R_GAIN;
+	u32 L1_LSSC_PWHB_GR_GAIN;
+	u32 L1_LSSC_PWHB_GB_GAIN;
+	u32 L1_LSSC_PWHB_B_GAIN;
+	u32 L1_LSSC_PARA_EN;
+	u32 L1_LSSC_PARA_H_CENTER;
+	u32 L1_LSSC_PARA_V_CENTER;
+	u32 L1_LSSC_PARA_H_GAIN;
+	u32 L1_LSSC_PARA_V_GAIN;
+	u32 L1_LSSC_PARA_MGSEL2;
+	u32 L1_LSSC_PARA_MGSEL4;
+	u32 L1_LSSC_PARA_R_COEF_2D_H_L;
+	u32 L1_LSSC_PARA_R_COEF_2D_H_R;
+	u32 L1_LSSC_PARA_R_COEF_2D_V_U;
+	u32 L1_LSSC_PARA_R_COEF_2D_V_D;
+	u32 L1_LSSC_PARA_R_COEF_2D_HV_LU;
+	u32 L1_LSSC_PARA_R_COEF_2D_HV_RU;
+	u32 L1_LSSC_PARA_R_COEF_2D_HV_LD;
+	u32 L1_LSSC_PARA_R_COEF_2D_HV_RD;
+	u32 L1_LSSC_PARA_R_COEF_4D_H_L;
+	u32 L1_LSSC_PARA_R_COEF_4D_H_R;
+	u32 L1_LSSC_PARA_R_COEF_4D_V_U;
+	u32 L1_LSSC_PARA_R_COEF_4D_V_D;
+	u32 L1_LSSC_PARA_R_COEF_4D_HV_LU;
+	u32 L1_LSSC_PARA_R_COEF_4D_HV_RU;
+	u32 L1_LSSC_PARA_R_COEF_4D_HV_LD;
+	u32 L1_LSSC_PARA_R_COEF_4D_HV_RD;
+	u32 L1_LSSC_PARA_GR_COEF_2D_H_L;
+	u32 L1_LSSC_PARA_GR_COEF_2D_H_R;
+	u32 L1_LSSC_PARA_GR_COEF_2D_V_U;
+	u32 L1_LSSC_PARA_GR_COEF_2D_V_D;
+	u32 L1_LSSC_PARA_GR_COEF_2D_HV_LU;
+	u32 L1_LSSC_PARA_GR_COEF_2D_HV_RU;
+	u32 L1_LSSC_PARA_GR_COEF_2D_HV_LD;
+	u32 L1_LSSC_PARA_GR_COEF_2D_HV_RD;
+	u32 L1_LSSC_PARA_GR_COEF_4D_H_L;
+	u32 L1_LSSC_PARA_GR_COEF_4D_H_R;
+	u32 L1_LSSC_PARA_GR_COEF_4D_V_U;
+	u32 L1_LSSC_PARA_GR_COEF_4D_V_D;
+	u32 L1_LSSC_PARA_GR_COEF_4D_HV_LU;
+	u32 L1_LSSC_PARA_GR_COEF_4D_HV_RU;
+	u32 L1_LSSC_PARA_GR_COEF_4D_HV_LD;
+	u32 L1_LSSC_PARA_GR_COEF_4D_HV_RD;
+	u32 L1_LSSC_PARA_GB_COEF_2D_H_L;
+	u32 L1_LSSC_PARA_GB_COEF_2D_H_R;
+	u32 L1_LSSC_PARA_GB_COEF_2D_V_U;
+	u32 L1_LSSC_PARA_GB_COEF_2D_V_D;
+	u32 L1_LSSC_PARA_GB_COEF_2D_HV_LU;
+	u32 L1_LSSC_PARA_GB_COEF_2D_HV_RU;
+	u32 L1_LSSC_PARA_GB_COEF_2D_HV_LD;
+	u32 L1_LSSC_PARA_GB_COEF_2D_HV_RD;
+	u32 L1_LSSC_PARA_GB_COEF_4D_H_L;
+	u32 L1_LSSC_PARA_GB_COEF_4D_H_R;
+	u32 L1_LSSC_PARA_GB_COEF_4D_V_U;
+	u32 L1_LSSC_PARA_GB_COEF_4D_V_D;
+	u32 L1_LSSC_PARA_GB_COEF_4D_HV_LU;
+	u32 L1_LSSC_PARA_GB_COEF_4D_HV_RU;
+	u32 L1_LSSC_PARA_GB_COEF_4D_HV_LD;
+	u32 L1_LSSC_PARA_GB_COEF_4D_HV_RD;
+	u32 L1_LSSC_PARA_B_COEF_2D_H_L;
+	u32 L1_LSSC_PARA_B_COEF_2D_H_R;
+	u32 L1_LSSC_PARA_B_COEF_2D_V_U;
+	u32 L1_LSSC_PARA_B_COEF_2D_V_D;
+	u32 L1_LSSC_PARA_B_COEF_2D_HV_LU;
+	u32 L1_LSSC_PARA_B_COEF_2D_HV_RU;
+	u32 L1_LSSC_PARA_B_COEF_2D_HV_LD;
+	u32 L1_LSSC_PARA_B_COEF_2D_HV_RD;
+	u32 L1_LSSC_PARA_B_COEF_4D_H_L;
+	u32 L1_LSSC_PARA_B_COEF_4D_H_R;
+	u32 L1_LSSC_PARA_B_COEF_4D_V_U;
+	u32 L1_LSSC_PARA_B_COEF_4D_V_D;
+	u32 L1_LSSC_PARA_B_COEF_4D_HV_LU;
+	u32 L1_LSSC_PARA_B_COEF_4D_HV_RU;
+	u32 L1_LSSC_PARA_B_COEF_4D_HV_LD;
+	u32 L1_LSSC_PARA_B_COEF_4D_HV_RD;
+	u32 L1_LSSC_GRID_EN;
+	u32 L1_LSSC_GRID_H_CENTER;
+	u32 L1_LSSC_GRID_V_CENTER;
+	u32 L1_LSSC_GRID_H_SIZE;
+	u32 L1_LSSC_GRID_V_SIZE;
+	u32 L1_LSSC_GRID_MGSEL;
+	u32 RESERVED_B_12[11];
+	u32 L1_MPRO_SW;
+	u32 L1_MPRO_CONF;
+	u32 RESERVED_A_55;
+	u32 L1_MPRO_DST_MINVAL;
+	u32 L1_MPRO_DST_MAXVAL;
+	u32 L1_MPRO_AG_CONT;
+	u32 RESERVED_A_56;
+	u32 RESERVED_A_57;
+	u32 L1_MPRO_LM0_RMG_MIN;
+	u32 L1_MPRO_LM0_RMB_MIN;
+	u32 L1_MPRO_LM0_GMR_MIN;
+	u32 L1_MPRO_LM0_GMB_MIN;
+	u32 L1_MPRO_LM0_BMR_MIN;
+	u32 L1_MPRO_LM0_BMG_MIN;
+	u32 L1_MPRO_LM0_RMG_MAX;
+	u32 L1_MPRO_LM0_RMB_MAX;
+	u32 L1_MPRO_LM0_GMR_MAX;
+	u32 L1_MPRO_LM0_GMB_MAX;
+	u32 L1_MPRO_LM0_BMR_MAX;
+	u32 L1_MPRO_LM0_BMG_MAX;
+	u32 RESERVED_A_58;
+	u32 RESERVED_A_59;
+	u32 RESERVED_A_60;
+	u32 RESERVED_A_61;
+	u32 RESERVED_A_62;
+	u32 RESERVED_A_63;
+	u32 RESERVED_A_64;
+	u32 RESERVED_A_65;
+	u32 RESERVED_A_66;
+	u32 RESERVED_A_67;
+	u32 RESERVED_A_68;
+	u32 RESERVED_A_69;
+	u32 RESERVED_A_70;
+	u32 RESERVED_A_71;
+	u32 RESERVED_A_72;
+	u32 RESERVED_A_73;
+	u32 RESERVED_A_74;
+	u32 RESERVED_A_75;
+	u32 RESERVED_A_76;
+	u32 RESERVED_A_77;
+	u32 RESERVED_A_78;
+	u32 RESERVED_A_79;
+	u32 RESERVED_A_80;
+	u32 RESERVED_A_81;
+	u32 RESERVED_A_82;
+	u32 RESERVED_A_83;
+	u32 RESERVED_A_84;
+	u32 RESERVED_A_85;
+	u32 RESERVED_A_86;
+	u32 RESERVED_A_87;
+	u32 RESERVED_A_88;
+	u32 RESERVED_A_89;
+	u32 RESERVED_A_90;
+	u32 RESERVED_A_91;
+	u32 RESERVED_A_92;
+	u32 RESERVED_A_93;
+	u32 RESERVED_A_94;
+	u32 RESERVED_A_95;
+	u32 RESERVED_A_96;
+	u32 RESERVED_B_13[1];
+	u32 L1_MPRO_LCS_MODE;
+	u32 RESERVED_A_97;
+	u32 RESERVED_A_98;
+	u32 RESERVED_A_99;
+	u32 RESERVED_A_100;
+	u32 RESERVED_A_101;
+	u32 RESERVED_A_102;
+	u32 RESERVED_A_103;
+	u32 RESERVED_A_104;
+	u32 RESERVED_A_105;
+	u32 RESERVED_A_106;
+	u32 RESERVED_A_107;
+	u32 RESERVED_A_108;
+	u32 RESERVED_A_109;
+	u32 RESERVED_A_110;
+	u32 RESERVED_A_111;
+	u32 RESERVED_A_112;
+	u32 RESERVED_A_113;
+	u32 RESERVED_A_114;
+	u32 RESERVED_A_115;
+	u32 RESERVED_A_116;
+	u32 RESERVED_A_117;
+	u32 RESERVED_A_118;
+	u32 RESERVED_A_119;
+	u32 RESERVED_A_120;
+	u32 RESERVED_A_121;
+	u32 RESERVED_A_122;
+	u32 RESERVED_A_123;
+	u32 RESERVED_A_124;
+	u32 RESERVED_A_125;
+	u32 RESERVED_B_14[70];
+	u32 L1_VPRO_PGC_SW;
+	u32 RESERVED_A_126;
+	u32 L1_VPRO_YUVC_SW;
+	u32 L1_VPRO_YNR_SW;
+	u32 L1_VPRO_ETE_SW;
+	u32 L1_VPRO_CSUP_UVSUP_SW;
+	u32 L1_VPRO_CSUP_CORING_SW;
+	u32 L1_VPRO_BRIGHT_SW;
+	u32 L1_VPRO_LCNT_SW;
+	u32 L1_VPRO_NLCNT_SW;
+	u32 RESERVED_A_127;
+	u32 L1_VPRO_EDGE_SUP_SW;
+	u32 L1_VPRO_CNR_SW;
+	u32 L1_VPRO_AG_CONT;
+	u32 L1_VPRO_BLKADJ;
+	u32 L1_VPRO_GAM01P;
+	u32 L1_VPRO_GAM02P;
+	u32 L1_VPRO_GAM03P;
+	u32 L1_VPRO_GAM04P;
+	u32 L1_VPRO_GAM05P;
+	u32 L1_VPRO_GAM06P;
+	u32 L1_VPRO_GAM07P;
+	u32 L1_VPRO_GAM08P;
+	u32 L1_VPRO_GAM09P;
+	u32 L1_VPRO_GAM10P;
+	u32 L1_VPRO_GAM11P;
+	u32 L1_VPRO_GAM12P;
+	u32 L1_VPRO_GAM13P;
+	u32 L1_VPRO_GAM14P;
+	u32 L1_VPRO_GAM15P;
+	u32 L1_VPRO_GAM16P;
+	u32 L1_VPRO_GAM17P;
+	u32 L1_VPRO_GAM18P;
+	u32 L1_VPRO_GAM19P;
+	u32 L1_VPRO_GAM20P;
+	u32 L1_VPRO_GAM21P;
+	u32 L1_VPRO_GAM22P;
+	u32 L1_VPRO_GAM23P;
+	u32 L1_VPRO_GAM24P;
+	u32 L1_VPRO_GAM25P;
+	u32 L1_VPRO_GAM26P;
+	u32 L1_VPRO_GAM27P;
+	u32 L1_VPRO_GAM28P;
+	u32 L1_VPRO_GAM29P;
+	u32 L1_VPRO_GAM30P;
+	u32 L1_VPRO_GAM31P;
+	u32 L1_VPRO_GAM32P;
+	u32 L1_VPRO_GAM33P;
+	u32 L1_VPRO_GAM34P;
+	u32 L1_VPRO_GAM35P;
+	u32 L1_VPRO_GAM36P;
+	u32 L1_VPRO_GAM37P;
+	u32 L1_VPRO_GAM38P;
+	u32 L1_VPRO_GAM39P;
+	u32 L1_VPRO_GAM40P;
+	u32 L1_VPRO_GAM41P;
+	u32 L1_VPRO_GAM42P;
+	u32 L1_VPRO_GAM43P;
+	u32 L1_VPRO_GAM44P;
+	u32 L1_VPRO_CB_MAT;
+	u32 L1_VPRO_CR_MAT;
+	u32 L1_VPRO_BRIGHT;
+	u32 L1_VPRO_LCONT_LEV;
+	u32 L1_VPRO_BLK_KNEE;
+	u32 L1_VPRO_WHT_KNEE;
+	u32 L1_VPRO_BLK_CONT0;
+	u32 L1_VPRO_BLK_CONT1;
+	u32 L1_VPRO_BLK_CONT2;
+	u32 L1_VPRO_WHT_CONT0;
+	u32 L1_VPRO_WHT_CONT1;
+	u32 L1_VPRO_WHT_CONT2;
+	u32 RESERVED_A_128;
+	u32 RESERVED_A_129;
+	u32 RESERVED_A_130;
+	u32 RESERVED_A_131;
+	u32 RESERVED_A_132;
+	u32 RESERVED_A_133;
+	u32 L1_VPRO_YNR_GAIN_MIN;
+	u32 L1_VPRO_YNR_GAIN_MAX;
+	u32 L1_VPRO_YNR_LIM_MIN;
+	u32 L1_VPRO_YNR_LIM_MAX;
+	u32 L1_VPRO_ETE_GAIN_MIN;
+	u32 L1_VPRO_ETE_GAIN_MAX;
+	u32 L1_VPRO_ETE_LIM_MIN;
+	u32 L1_VPRO_ETE_LIM_MAX;
+	u32 L1_VPRO_ETE_CORING_MIN;
+	u32 L1_VPRO_ETE_CORING_MAX;
+	u32 L1_VPRO_CB_GAIN;
+	u32 L1_VPRO_CR_GAIN;
+	u32 L1_VPRO_CBR_MGAIN_MIN;
+	u32 L1_VPRO_CB_P_GAIN_MAX;
+	u32 L1_VPRO_CB_M_GAIN_MAX;
+	u32 L1_VPRO_CR_P_GAIN_MAX;
+	u32 L1_VPRO_CR_M_GAIN_MAX;
+	u32 L1_VPRO_CSUP_CORING_LV_MIN;
+	u32 L1_VPRO_CSUP_CORING_LV_MAX;
+	u32 L1_VPRO_CSUP_CORING_GAIN_MIN;
+	u32 L1_VPRO_CSUP_CORING_GAIN_MAX;
+	u32 L1_VPRO_CSUP_BK_SLV;
+	u32 L1_VPRO_CSUP_BK_MP;
+	u32 L1_VPRO_CSUP_BLACK;
+	u32 L1_VPRO_CSUP_WH_SLV;
+	u32 L1_VPRO_CSUP_WH_MP;
+	u32 L1_VPRO_CSUP_WHITE;
+	u32 L1_VPRO_EDGE_SUP_GAIN;
+	u32 L1_VPRO_EDGE_SUP_LIM;
+	u32 RESERVED_B_15[22];
+	u32 L1_AWHB_SW;
+	u32 RESERVED_A_134;
+	u32 L1_AWHB_WBMRG;
+	u32 L1_AWHB_WBMGG;
+	u32 L1_AWHB_WBMBG;
+	u32 L1_AWHB_GATE_CONF0;
+	u32 L1_AWHB_GATE_CONF1;
+	u32 L1_AWHB_AREA_HSIZE;
+	u32 L1_AWHB_AREA_VSIZE;
+	u32 L1_AWHB_AREA_HOFS;
+	u32 L1_AWHB_AREA_VOFS;
+	u32 L1_AWHB_AREA_MASKH;
+	u32 L1_AWHB_AREA_MASKL;
+	u32 L1_AWHB_SQ_CONF;
+	u32 L1_AWHB_YGATEH;
+	u32 L1_AWHB_YGATEL;
+	u32 RESERVED_A_135;
+	u32 RESERVED_A_136;
+	u32 L1_AWHB_BYCUT0P;
+	u32 L1_AWHB_BYCUT0N;
+	u32 L1_AWHB_RYCUT0P;
+	u32 L1_AWHB_RYCUT0N;
+	u32 L1_AWHB_RBCUT0H;
+	u32 L1_AWHB_RBCUT0L;
+	u32 RESERVED_A_137;
+	u32 RESERVED_A_138;
+	u32 RESERVED_A_139;
+	u32 RESERVED_A_140;
+	u32 RESERVED_A_141;
+	u32 RESERVED_A_142;
+	u32 L1_AWHB_BYCUT1H;
+	u32 L1_AWHB_BYCUT1L;
+	u32 L1_AWHB_RYCUT1H;
+	u32 L1_AWHB_RYCUT1L;
+	u32 L1_AWHB_BYCUT2H;
+	u32 L1_AWHB_BYCUT2L;
+	u32 L1_AWHB_RYCUT2H;
+	u32 L1_AWHB_RYCUT2L;
+	u32 L1_AWHB_BYCUT3H;
+	u32 L1_AWHB_BYCUT3L;
+	u32 L1_AWHB_RYCUT3H;
+	u32 L1_AWHB_RYCUT3L;
+	u32 L1_AWHB_AWBSFTU;
+	u32 L1_AWHB_AWBSFTV;
+	u32 L1_AWHB_AWBSPD;
+	u32 L1_AWHB_AWBULV;
+	u32 L1_AWHB_AWBVLV;
+	u32 L1_AWHB_AWBWAIT;
+	u32 L1_AWHB_AWBONDOT;
+	u32 L1_AWHB_AWBFZTIM;
+	u32 L1_AWHB_WBGRMAX;
+	u32 L1_AWHB_WBGRMIN;
+	u32 L1_AWHB_WBGBMAX;
+	u32 L1_AWHB_WBGBMIN;
+	u32 RESERVED_A_143;
+	u32 RESERVED_A_144;
+	u32 RESERVED_A_145;
+	u32 RESERVED_A_146;
+	u32 RESERVED_A_147;
+	u32 RESERVED_A_148;
+	u32 RESERVED_A_149;
+	u32 RESERVED_A_150;
+	u32 RESERVED_A_151;
+	u32 RESERVED_A_152;
+	u32 RESERVED_A_153;
+	u32 RESERVED_A_154;
+	u32 RESERVED_A_155;
+	u32 L1_AWHB_AVE_USIG;
+	u32 L1_AWHB_AVE_VSIG;
+	u32 L1_AWHB_NUM_UVON;
+	u32 L1_AWHB_AWBGAINR;
+	u32 L1_AWHB_AWBGAING;
+	u32 L1_AWHB_AWBGAINB;
+	u32 RESERVED_A_156;
+	u32 RESERVED_A_157;
+	u32 RESERVED_A_158;
+	u32 L1_AWHB_R_CTR_STOP;
+	u32 RESERVED_A_159;
+	u32 RESERVED_B_16[2];
+	u32 L1_HOBC_EN;
+	u32 L1_HOBC_MARGIN;
+	u32 L1_HOBC01_AG_CONT;
+	u32 L1_HOBC2_AG_CONT;
+	u32 L1_HOBC0_LOB_REFLV_GR;
+	u32 L1_HOBC0_LOB_WIDTH_GR;
+	u32 L1_HOBC0_LOB_REFLV_R;
+	u32 L1_HOBC0_LOB_WIDTH_R;
+	u32 L1_HOBC0_LOB_REFLV_B;
+	u32 L1_HOBC0_LOB_WIDTH_B;
+	u32 L1_HOBC0_LOB_REFLV_GB;
+	u32 L1_HOBC0_LOB_WIDTH_GB;
+	u32 L1_HOBC1_LOB_REFLV_GR;
+	u32 L1_HOBC1_LOB_WIDTH_GR;
+	u32 L1_HOBC1_LOB_REFLV_R;
+	u32 L1_HOBC1_LOB_WIDTH_R;
+	u32 L1_HOBC1_LOB_REFLV_B;
+	u32 L1_HOBC1_LOB_WIDTH_B;
+	u32 L1_HOBC1_LOB_REFLV_GB;
+	u32 L1_HOBC1_LOB_WIDTH_GB;
+	u32 L1_HOBC2_LOB_REFLV_GR;
+	u32 L1_HOBC2_LOB_WIDTH_GR;
+	u32 L1_HOBC2_LOB_REFLV_R;
+	u32 L1_HOBC2_LOB_WIDTH_R;
+	u32 L1_HOBC2_LOB_REFLV_B;
+	u32 L1_HOBC2_LOB_WIDTH_B;
+	u32 L1_HOBC2_LOB_REFLV_GB;
+	u32 L1_HOBC2_LOB_WIDTH_GB;
+	u32 L1_HOBC0_SRC_BLKLV_GR;
+	u32 L1_HOBC0_SRC_BLKLV_R;
+	u32 L1_HOBC0_SRC_BLKLV_B;
+	u32 L1_HOBC0_SRC_BLKLV_GB;
+	u32 L1_HOBC1_SRC_BLKLV_GR;
+	u32 L1_HOBC1_SRC_BLKLV_R;
+	u32 L1_HOBC1_SRC_BLKLV_B;
+	u32 L1_HOBC1_SRC_BLKLV_GB;
+	u32 L1_HOBC2_SRC_BLKLV_GR;
+	u32 L1_HOBC2_SRC_BLKLV_R;
+	u32 L1_HOBC2_SRC_BLKLV_B;
+	u32 L1_HOBC2_SRC_BLKLV_GB;
+	u32 RESERVED_A_160;
+	u32 RESERVED_A_161;
+	u32 RESERVED_A_162;
+	u32 RESERVED_A_163;
+	u32 RESERVED_A_164;
+	u32 RESERVED_A_165;
+	u32 L1_HOBC_MAX_VAL;
+	u32 RESERVED_B_17[33];
+	u32 L1_HDRC_EN;
+	u32 L1_HDRC_THR_SFT_AMT;
+	u32 RESERVED_A_166;
+	u32 L1_HDRC_RATIO;
+	u32 RESERVED_A_167;
+	u32 RESERVED_A_168;
+	u32 RESERVED_A_169;
+	u32 L1_HDRC_PT_RATIO;
+	u32 L1_HDRC_PT_BLEND;
+	u32 L1_HDRC_PT_BLEND2;
+	u32 L1_HDRC_PT_SAT;
+	u32 L1_HDRC_TN_TYPE;
+	u32 L1_HDRC_TNP_MAX;
+	u32 L1_HDRC_TNP_MAG;
+	u32 L1_HDRC_TNP_FB_SMTH_MAX0;
+	u32 L1_HDRC_TNP_FB_SMTH_MAX1;
+	u32 L1_HDRC_TNP_FB_SMTH_MAX2;
+	u32 L1_HDRC_TNP_FB_SMTH_MAX3;
+	u32 L1_HDRC_TNP_FIL0;
+	u32 L1_HDRC_TNP_FIL1;
+	u32 L1_HDRC_TNP_FIL2;
+	u32 L1_HDRC_TNP_FIL3;
+	u32 L1_HDRC_TNP_FIL4;
+	u32 L1_HDRC_UTN_TBL0;
+	u32 L1_HDRC_UTN_TBL1;
+	u32 L1_HDRC_UTN_TBL2;
+	u32 L1_HDRC_UTN_TBL3;
+	u32 L1_HDRC_UTN_TBL4;
+	u32 L1_HDRC_UTN_TBL5;
+	u32 L1_HDRC_UTN_TBL6;
+	u32 L1_HDRC_UTN_TBL7;
+	u32 L1_HDRC_UTN_TBL8;
+	u32 L1_HDRC_UTN_TBL9;
+	u32 L1_HDRC_UTN_TBL10;
+	u32 L1_HDRC_UTN_TBL11;
+	u32 L1_HDRC_UTN_TBL12;
+	u32 L1_HDRC_UTN_TBL13;
+	u32 L1_HDRC_UTN_TBL14;
+	u32 L1_HDRC_UTN_TBL15;
+	u32 L1_HDRC_UTN_TBL16;
+	u32 L1_HDRC_UTN_TBL17;
+	u32 L1_HDRC_UTN_TBL18;
+	u32 L1_HDRC_UTN_TBL19;
+	u32 L1_HDRC_FLR_VAL;
+	u32 L1_HDRC_FLR_ADP;
+	u32 RESERVED_A_170;
+	u32 RESERVED_A_171;
+	u32 RESERVED_A_172;
+	u32 RESERVED_A_173;
+	u32 RESERVED_A_174;
+	u32 RESERVED_A_175;
+	u32 RESERVED_A_176;
+	u32 RESERVED_A_177;
+	u32 RESERVED_A_178;
+	u32 RESERVED_A_179;
+	u32 RESERVED_A_180;
+	u32 RESERVED_A_181;
+	u32 RESERVED_A_182;
+	u32 RESERVED_A_183;
+	u32 L1_HDRC_YBR_OFF;
+	u32 L1_HDRC_ORGY_BLEND;
+	u32 RESERVED_A_184;
+	u32 RESERVED_A_185;
+	u32 RESERVED_A_186;
+	u32 L1_HDRC_MAR_TOP;
+	u32 L1_HDRC_MAR_LEFT;
+	u32 RESERVED_A_187;
+	u32 RESERVED_A_188;
+	u32 RESERVED_B_18[28];
+	u32 L1_HIST_EN;
+	u32 L1_HIST_MODE;
+	u32 L1_HIST_BLOCK_OFST;
+	u32 L1_HIST_BLOCK_SIZE;
+	u32 L1_HIST_BLOCK_NUM;
+	u32 L1_HIST_BLOCK_STEP;
+	u32 L1_HIST_LINEAR_SFT;
+	u32 L1_HIST_MULT_A_R;
+	u32 L1_HIST_ADD_A_R;
+	u32 L1_HIST_MULT_B_R;
+	u32 L1_HIST_ADD_B_R;
+	u32 L1_HIST_MULT_A_G;
+	u32 L1_HIST_ADD_A_G;
+	u32 L1_HIST_MULT_B_G;
+	u32 L1_HIST_ADD_B_G;
+	u32 L1_HIST_MULT_A_B;
+	u32 L1_HIST_ADD_A_B;
+	u32 L1_HIST_MULT_B_B;
+	u32 L1_HIST_ADD_B_B;
+	u32 L1_HIST_MULT_A_Y;
+	u32 L1_HIST_ADD_A_Y;
+	u32 L1_HIST_MULT_B_Y;
+	u32 L1_HIST_ADD_B_Y;
+	u32 RESERVED_B_19[201];
+	u32 L1_CRGBF_ACC_CONF;
+	u32 L1_CRGBF_TRN_M_RUN;
+	u32 L1_CRGBF_TRN_M_CONF;
+	u32 L1_CRGBF_TRN_A_CONF;
+	u32 L1_CRGBF_TRN_STAT_CLR;
+	u32 L1_CRGBF_TRN_STAT;
+	u32 L1_CRGBF_INT_STAT;
+	u32 L1_CRGBF_INT_MASK;
+	u32 L1_CRGBF_INT_MASKED_STAT;
+	u32 L1_CRGBF_TRN_WBADDR;
+	u32 L1_CRGBF_TRN_WEADDR;
+	u32 L1_CRGBF_TRN_RBADDR;
+	u32 L1_CRGBF_TRN_READDR;
+	u32 L1_CRGBF_ISP_INT;
+	u32 L1_CRGBF_ISP_INT_MASK;
+	u32 L1_CRGBF_ISP_INT_MASKED_STAT;
+	u32 RESERVED_A_189;
+	u32 RESERVED_B_20[47];
+	u32 L1_VLATCH_SYSM_WIDTH;
+	u32 L1_VLATCH_SYSM_HEIGHT;
+	u32 L1_VLATCH_SYSM_START_COLOR;
+	u32 L1_VLATCH_SYSM_INPUT_MODE;
+	u32 RESERVED_A_190;
+	u32 L1_VLATCH_SYSM_YCOEF_R;
+	u32 L1_VLATCH_SYSM_YCOEF_G;
+	u32 L1_VLATCH_SYSM_YCOEF_B;
+	u32 RESERVED_A_191;
+	u32 RESERVED_A_192;
+	u32 RESERVED_A_193;
+	u32 RESERVED_A_194;
+	u32 RESERVED_A_195;
+	u32 RESERVED_A_196;
+	u32 RESERVED_B_21[2];
+	u32 L1_VLATCH_SYSM_AG_H;
+	u32 L1_VLATCH_SYSM_AG_M;
+	u32 L1_VLATCH_SYSM_AG_L;
+	u32 L1_VLATCH_SYSM_AG_PARAM_A;
+	u32 L1_VLATCH_SYSM_AG_PARAM_B;
+	u32 L1_VLATCH_SYSM_AG_PARAM_C;
+	u32 L1_VLATCH_SYSM_AG_PARAM_D;
+	u32 L1_VLATCH_SYSM_AG_SEL_HOBC;
+	u32 L1_VLATCH_SYSM_AG_SEL_ABPC;
+	u32 L1_VLATCH_SYSM_AG_SEL_RCNR;
+	u32 L1_VLATCH_SYSM_AG_SEL_LSSC;
+	u32 L1_VLATCH_SYSM_AG_SEL_MPRO;
+	u32 L1_VLATCH_SYSM_AG_SEL_VPRO;
+	u32 L1_VLATCH_SYSM_AG_CONT_HOBC01_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_HOBC2_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_ABPC01_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_ABPC2_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_RCNR01_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_RCNR2_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_LSSC_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_MPRO_EN;
+	u32 L1_VLATCH_SYSM_AG_CONT_VPRO_EN;
+	u32 RESERVED_A_197;
+	u32 L1_VLATCH_SYSM_MAN_CTXT;
+	u32 RESERVED_A_198;
+	u32 RESERVED_B_22[7];
+	u32 RESERVED_A_199;
+	u32 L1_VLATCH_HDRE_SRCPOINT00;
+	u32 L1_VLATCH_HDRE_SRCPOINT01;
+	u32 L1_VLATCH_HDRE_SRCPOINT02;
+	u32 L1_VLATCH_HDRE_SRCPOINT03;
+	u32 L1_VLATCH_HDRE_SRCPOINT04;
+	u32 L1_VLATCH_HDRE_SRCPOINT05;
+	u32 L1_VLATCH_HDRE_SRCPOINT06;
+	u32 L1_VLATCH_HDRE_SRCPOINT07;
+	u32 L1_VLATCH_HDRE_SRCPOINT08;
+	u32 L1_VLATCH_HDRE_SRCPOINT09;
+	u32 L1_VLATCH_HDRE_SRCPOINT10;
+	u32 L1_VLATCH_HDRE_SRCPOINT11;
+	u32 L1_VLATCH_HDRE_SRCPOINT12;
+	u32 L1_VLATCH_HDRE_SRCPOINT13;
+	u32 L1_VLATCH_HDRE_SRCPOINT14;
+	u32 L1_VLATCH_HDRE_SRCPOINT15;
+	u32 L1_VLATCH_HDRE_SRCBASE00;
+	u32 L1_VLATCH_HDRE_SRCBASE01;
+	u32 L1_VLATCH_HDRE_SRCBASE02;
+	u32 L1_VLATCH_HDRE_SRCBASE03;
+	u32 L1_VLATCH_HDRE_SRCBASE04;
+	u32 L1_VLATCH_HDRE_SRCBASE05;
+	u32 L1_VLATCH_HDRE_SRCBASE06;
+	u32 L1_VLATCH_HDRE_SRCBASE07;
+	u32 L1_VLATCH_HDRE_SRCBASE08;
+	u32 L1_VLATCH_HDRE_SRCBASE09;
+	u32 L1_VLATCH_HDRE_SRCBASE10;
+	u32 L1_VLATCH_HDRE_SRCBASE11;
+	u32 L1_VLATCH_HDRE_SRCBASE12;
+	u32 L1_VLATCH_HDRE_SRCBASE13;
+	u32 L1_VLATCH_HDRE_SRCBASE14;
+	u32 L1_VLATCH_HDRE_SRCBASE15;
+	u32 L1_VLATCH_HDRE_SRCBASE16;
+	u32 L1_VLATCH_HDRE_RATIO00;
+	u32 L1_VLATCH_HDRE_RATIO01;
+	u32 L1_VLATCH_HDRE_RATIO02;
+	u32 L1_VLATCH_HDRE_RATIO03;
+	u32 L1_VLATCH_HDRE_RATIO04;
+	u32 L1_VLATCH_HDRE_RATIO05;
+	u32 L1_VLATCH_HDRE_RATIO06;
+	u32 L1_VLATCH_HDRE_RATIO07;
+	u32 L1_VLATCH_HDRE_RATIO08;
+	u32 L1_VLATCH_HDRE_RATIO09;
+	u32 L1_VLATCH_HDRE_RATIO10;
+	u32 L1_VLATCH_HDRE_RATIO11;
+	u32 L1_VLATCH_HDRE_RATIO12;
+	u32 L1_VLATCH_HDRE_RATIO13;
+	u32 L1_VLATCH_HDRE_RATIO14;
+	u32 L1_VLATCH_HDRE_RATIO15;
+	u32 L1_VLATCH_HDRE_RATIO16;
+	u32 L1_VLATCH_HDRE_DSTBASE00;
+	u32 L1_VLATCH_HDRE_DSTBASE01;
+	u32 L1_VLATCH_HDRE_DSTBASE02;
+	u32 L1_VLATCH_HDRE_DSTBASE03;
+	u32 L1_VLATCH_HDRE_DSTBASE04;
+	u32 L1_VLATCH_HDRE_DSTBASE05;
+	u32 L1_VLATCH_HDRE_DSTBASE06;
+	u32 L1_VLATCH_HDRE_DSTBASE07;
+	u32 L1_VLATCH_HDRE_DSTBASE08;
+	u32 L1_VLATCH_HDRE_DSTBASE09;
+	u32 L1_VLATCH_HDRE_DSTBASE10;
+	u32 L1_VLATCH_HDRE_DSTBASE11;
+	u32 L1_VLATCH_HDRE_DSTBASE12;
+	u32 L1_VLATCH_HDRE_DSTBASE13;
+	u32 L1_VLATCH_HDRE_DSTBASE14;
+	u32 L1_VLATCH_HDRE_DSTBASE15;
+	u32 L1_VLATCH_HDRE_DSTBASE16;
+	u32 L1_VLATCH_HDRE_DSTMAXVAL;
+	u32 RESERVED_B_23[11];
+	u32 L1_VLATCH_AEXP_ON;
+	u32 RESERVED_A_200;
+	u32 RESERVED_A_201;
+	u32 L1_VLATCH_AEXP_FORCE_INTERRUPT_Y;
+	u32 L1_VLATCH_AEXP_START_X;
+	u32 L1_VLATCH_AEXP_START_Y;
+	u32 L1_VLATCH_AEXP_BLOCK_WIDTH;
+	u32 L1_VLATCH_AEXP_BLOCK_HEIGHT;
+	u32 L1_VLATCH_AEXP_WEIGHT_0;
+	u32 L1_VLATCH_AEXP_WEIGHT_1;
+	u32 L1_VLATCH_AEXP_WEIGHT_2;
+	u32 L1_VLATCH_AEXP_WEIGHT_3;
+	u32 L1_VLATCH_AEXP_WEIGHT_4;
+	u32 L1_VLATCH_AEXP_WEIGHT_5;
+	u32 L1_VLATCH_AEXP_WEIGHT_6;
+	u32 L1_VLATCH_AEXP_WEIGHT_7;
+	u32 L1_VLATCH_AEXP_SATUR_RATIO;
+	u32 L1_VLATCH_AEXP_BLACK_RATIO;
+	u32 L1_VLATCH_AEXP_SATUR_LEVEL;
+	u32 RESERVED_A_202;
+	u32 RESERVED_A_203;
+	u32 RESERVED_A_204;
+	u32 RESERVED_A_205;
+	u32 RESERVED_A_206;
+	u32 RESERVED_A_207;
+	u32 RESERVED_A_208;
+	u32 RESERVED_A_209;
+	u32 RESERVED_A_210;
+	u32 RESERVED_A_211;
+	u32 RESERVED_A_212;
+	u32 RESERVED_A_213;
+	u32 RESERVED_A_214;
+	u32 RESERVED_A_215;
+	u32 RESERVED_A_216;
+	u32 RESERVED_A_217;
+	u32 RESERVED_A_218;
+	u32 RESERVED_A_219;
+	u32 RESERVED_A_220;
+	u32 RESERVED_A_221;
+	u32 RESERVED_A_222;
+	u32 RESERVED_A_223;
+	u32 RESERVED_A_224;
+	u32 RESERVED_A_225;
+	u32 RESERVED_A_226;
+	u32 RESERVED_A_227;
+	u32 RESERVED_A_228;
+	u32 RESERVED_A_229;
+	u32 RESERVED_A_230;
+	u32 RESERVED_A_231;
+	u32 RESERVED_A_232;
+	u32 RESERVED_A_233;
+	u32 RESERVED_A_234;
+	u32 RESERVED_A_235;
+	u32 RESERVED_A_236;
+	u32 RESERVED_A_237;
+	u32 RESERVED_A_238;
+	u32 RESERVED_A_239;
+	u32 RESERVED_A_240;
+	u32 RESERVED_A_241;
+	u32 RESERVED_A_242;
+	u32 RESERVED_A_243;
+	u32 RESERVED_A_244;
+	u32 RESERVED_A_245;
+	u32 RESERVED_A_246;
+	u32 RESERVED_A_247;
+	u32 RESERVED_A_248;
+	u32 RESERVED_A_249;
+	u32 RESERVED_A_250;
+	u32 RESERVED_A_251;
+	u32 RESERVED_A_252;
+	u32 RESERVED_A_253;
+	u32 RESERVED_A_254;
+	u32 RESERVED_A_255;
+	u32 RESERVED_A_256;
+	u32 RESERVED_A_257;
+	u32 RESERVED_A_258;
+	u32 RESERVED_A_259;
+	u32 RESERVED_A_260;
+	u32 RESERVED_A_261;
+	u32 RESERVED_A_262;
+	u32 RESERVED_A_263;
+	u32 RESERVED_A_264;
+	u32 RESERVED_A_265;
+	u32 RESERVED_A_266;
+	u32 RESERVED_A_267;
+	u32 L1_VLATCH_AEXP_AVE4LINESY0;
+	u32 L1_VLATCH_AEXP_AVE4LINESY1;
+	u32 L1_VLATCH_AEXP_AVE4LINESY2;
+	u32 L1_VLATCH_AEXP_AVE4LINESY3;
+	u32 RESERVED_A_268;
+	u32 RESERVED_A_269;
+	u32 RESERVED_A_270;
+	u32 RESERVED_A_271;
+	u32 RESERVED_B_24[3];
+	u32 L1_VLATCH_IBUF_DEPTH;
+	u32 L1_VLATCH_IBUF_INPUT_ORDER;
+	u32 RESERVED_B_25[2];
+	u32 L1_VLATCH_SLIC_SRCBLACKLEVEL_GR;
+	u32 L1_VLATCH_SLIC_SRCBLACKLEVEL_R;
+	u32 L1_VLATCH_SLIC_SRCBLACKLEVEL_B;
+	u32 L1_VLATCH_SLIC_SRCBLACKLEVEL_GB;
+	u32 RESERVED_A_272;
+	u32 RESERVED_A_273;
+	u32 RESERVED_A_274;
+	u32 RESERVED_A_275;
+	u32 RESERVED_A_276;
+	u32 RESERVED_B_26[19];
+	u32 RESERVED_A_277;
+	u32 RESERVED_A_278;
+	u32 RESERVED_A_279;
+	u32 L1_VLATCH_ABPC012_STA_EN;
+	u32 L1_VLATCH_ABPC012_DYN_EN;
+	u32 L1_VLATCH_ABPC012_DYN_MODE;
+	u32 RESERVED_A_280;
+	u32 RESERVED_A_281;
+	u32 RESERVED_A_282;
+	u32 L1_VLATCH_ABPC0_RATIO_LIMIT;
+	u32 RESERVED_A_283;
+	u32 L1_VLATCH_ABPC0_DARK_LIMIT;
+	u32 L1_VLATCH_ABPC0_SN_COEF_W_AG_MIN;
+	u32 L1_VLATCH_ABPC0_SN_COEF_W_AG_MID;
+	u32 L1_VLATCH_ABPC0_SN_COEF_W_AG_MAX;
+	u32 L1_VLATCH_ABPC0_SN_COEF_W_TH_MIN;
+	u32 L1_VLATCH_ABPC0_SN_COEF_W_TH_MAX;
+	u32 L1_VLATCH_ABPC0_SN_COEF_B_AG_MIN;
+	u32 L1_VLATCH_ABPC0_SN_COEF_B_AG_MID;
+	u32 L1_VLATCH_ABPC0_SN_COEF_B_AG_MAX;
+	u32 L1_VLATCH_ABPC0_SN_COEF_B_TH_MIN;
+	u32 L1_VLATCH_ABPC0_SN_COEF_B_TH_MAX;
+	u32 RESERVED_A_284;
+	u32 RESERVED_A_285;
+	u32 L1_VLATCH_ABPC1_RATIO_LIMIT;
+	u32 RESERVED_A_286;
+	u32 L1_VLATCH_ABPC1_DARK_LIMIT;
+	u32 L1_VLATCH_ABPC1_SN_COEF_W_AG_MIN;
+	u32 L1_VLATCH_ABPC1_SN_COEF_W_AG_MID;
+	u32 L1_VLATCH_ABPC1_SN_COEF_W_AG_MAX;
+	u32 L1_VLATCH_ABPC1_SN_COEF_W_TH_MIN;
+	u32 L1_VLATCH_ABPC1_SN_COEF_W_TH_MAX;
+	u32 L1_VLATCH_ABPC1_SN_COEF_B_AG_MIN;
+	u32 L1_VLATCH_ABPC1_SN_COEF_B_AG_MID;
+	u32 L1_VLATCH_ABPC1_SN_COEF_B_AG_MAX;
+	u32 L1_VLATCH_ABPC1_SN_COEF_B_TH_MIN;
+	u32 L1_VLATCH_ABPC1_SN_COEF_B_TH_MAX;
+	u32 RESERVED_A_287;
+	u32 RESERVED_A_288;
+	u32 L1_VLATCH_ABPC2_RATIO_LIMIT;
+	u32 RESERVED_A_289;
+	u32 L1_VLATCH_ABPC2_DARK_LIMIT;
+	u32 L1_VLATCH_ABPC2_SN_COEF_W_AG_MIN;
+	u32 L1_VLATCH_ABPC2_SN_COEF_W_AG_MID;
+	u32 L1_VLATCH_ABPC2_SN_COEF_W_AG_MAX;
+	u32 L1_VLATCH_ABPC2_SN_COEF_W_TH_MIN;
+	u32 L1_VLATCH_ABPC2_SN_COEF_W_TH_MAX;
+	u32 L1_VLATCH_ABPC2_SN_COEF_B_AG_MIN;
+	u32 L1_VLATCH_ABPC2_SN_COEF_B_AG_MID;
+	u32 L1_VLATCH_ABPC2_SN_COEF_B_AG_MAX;
+	u32 L1_VLATCH_ABPC2_SN_COEF_B_TH_MIN;
+	u32 L1_VLATCH_ABPC2_SN_COEF_B_TH_MAX;
+	u32 RESERVED_A_290;
+	u32 RESERVED_A_291;
+	u32 RESERVED_B_27[42];
+	u32 RESERVED_A_292;
+	u32 L1_VLATCH_PWHB_H_GR;
+	u32 L1_VLATCH_PWHB_HR;
+	u32 L1_VLATCH_PWHB_HB;
+	u32 L1_VLATCH_PWHB_H_GB;
+	u32 L1_VLATCH_PWHB_M_GR;
+	u32 L1_VLATCH_PWHB_MR;
+	u32 L1_VLATCH_PWHB_MB;
+	u32 L1_VLATCH_PWHB_M_GB;
+	u32 L1_VLATCH_PWHB_L_GR;
+	u32 L1_VLATCH_PWHB_LR;
+	u32 L1_VLATCH_PWHB_LB;
+	u32 L1_VLATCH_PWHB_L_GB;
+	u32 L1_VLATCH_PWHB_DSTMAXVAL;
+	u32 RESERVED_B_28[18];
+	u32 RESERVED_A_293;
+	u32 RESERVED_A_294;
+	u32 L1_VLATCH_RCNR0_SW;
+	u32 L1_VLATCH_RCNR0_CNF_DARK_AG0;
+	u32 L1_VLATCH_RCNR0_CNF_DARK_AG1;
+	u32 L1_VLATCH_RCNR0_CNF_DARK_AG2;
+	u32 L1_VLATCH_RCNR0_CNF_RATIO_AG0;
+	u32 L1_VLATCH_RCNR0_CNF_RATIO_AG1;
+	u32 L1_VLATCH_RCNR0_CNF_RATIO_AG2;
+	u32 L1_VLATCH_RCNR0_CNF_CLIP_GAIN_R;
+	u32 L1_VLATCH_RCNR0_CNF_CLIP_GAIN_G;
+	u32 L1_VLATCH_RCNR0_CNF_CLIP_GAIN_B;
+	u32 L1_VLATCH_RCNR0_A1L_DARK_AG0;
+	u32 L1_VLATCH_RCNR0_A1L_DARK_AG1;
+	u32 L1_VLATCH_RCNR0_A1L_DARK_AG2;
+	u32 L1_VLATCH_RCNR0_A1L_RATIO_AG0;
+	u32 L1_VLATCH_RCNR0_A1L_RATIO_AG1;
+	u32 L1_VLATCH_RCNR0_A1L_RATIO_AG2;
+	u32 L1_VLATCH_RCNR0_INF_ZERO_CLIP;
+	u32 RESERVED_A_295;
+	u32 L1_VLATCH_RCNR0_MERGE_D2BLEND_AG0;
+	u32 L1_VLATCH_RCNR0_MERGE_D2BLEND_AG1;
+	u32 L1_VLATCH_RCNR0_MERGE_D2BLEND_AG2;
+	u32 L1_VLATCH_RCNR0_MERGE_BLACK;
+	u32 L1_VLATCH_RCNR0_MERGE_MINDIV;
+	u32 L1_VLATCH_RCNR0_HRY_TYPE;
+	u32 L1_VLATCH_RCNR0_ANF_BLEND_AG0;
+	u32 L1_VLATCH_RCNR0_ANF_BLEND_AG1;
+	u32 L1_VLATCH_RCNR0_ANF_BLEND_AG2;
+	u32 RESERVED_A_296;
+	u32 L1_VLATCH_RCNR0_LPF_THRESHOLD;
+	u32 L1_VLATCH_RCNR0_MERGE_HLBLEND_AG0;
+	u32 L1_VLATCH_RCNR0_MERGE_HLBLEND_AG1;
+	u32 L1_VLATCH_RCNR0_MERGE_HLBLEND_AG2;
+	u32 L1_VLATCH_RCNR0_GNR_SW;
+	u32 L1_VLATCH_RCNR0_GNR_RATIO;
+	u32 L1_VLATCH_RCNR0_GNR_WIDE_EN;
+	u32 RESERVED_A_297;
+	u32 RESERVED_A_298;
+	u32 L1_VLATCH_RCNR1_SW;
+	u32 L1_VLATCH_RCNR1_CNF_DARK_AG0;
+	u32 L1_VLATCH_RCNR1_CNF_DARK_AG1;
+	u32 L1_VLATCH_RCNR1_CNF_DARK_AG2;
+	u32 L1_VLATCH_RCNR1_CNF_RATIO_AG0;
+	u32 L1_VLATCH_RCNR1_CNF_RATIO_AG1;
+	u32 L1_VLATCH_RCNR1_CNF_RATIO_AG2;
+	u32 L1_VLATCH_RCNR1_CNF_CLIP_GAIN_R;
+	u32 L1_VLATCH_RCNR1_CNF_CLIP_GAIN_G;
+	u32 L1_VLATCH_RCNR1_CNF_CLIP_GAIN_B;
+	u32 L1_VLATCH_RCNR1_A1L_DARK_AG0;
+	u32 L1_VLATCH_RCNR1_A1L_DARK_AG1;
+	u32 L1_VLATCH_RCNR1_A1L_DARK_AG2;
+	u32 L1_VLATCH_RCNR1_A1L_RATIO_AG0;
+	u32 L1_VLATCH_RCNR1_A1L_RATIO_AG1;
+	u32 L1_VLATCH_RCNR1_A1L_RATIO_AG2;
+	u32 L1_VLATCH_RCNR1_INF_ZERO_CLIP;
+	u32 RESERVED_A_299;
+	u32 L1_VLATCH_RCNR1_MERGE_D2BLEND_AG0;
+	u32 L1_VLATCH_RCNR1_MERGE_D2BLEND_AG1;
+	u32 L1_VLATCH_RCNR1_MERGE_D2BLEND_AG2;
+	u32 L1_VLATCH_RCNR1_MERGE_BLACK;
+	u32 L1_VLATCH_RCNR1_MERGE_MINDIV;
+	u32 L1_VLATCH_RCNR1_HRY_TYPE;
+	u32 L1_VLATCH_RCNR1_ANF_BLEND_AG0;
+	u32 L1_VLATCH_RCNR1_ANF_BLEND_AG1;
+	u32 L1_VLATCH_RCNR1_ANF_BLEND_AG2;
+	u32 RESERVED_A_300;
+	u32 L1_VLATCH_RCNR1_LPF_THRESHOLD;
+	u32 L1_VLATCH_RCNR1_MERGE_HLBLEND_AG0;
+	u32 L1_VLATCH_RCNR1_MERGE_HLBLEND_AG1;
+	u32 L1_VLATCH_RCNR1_MERGE_HLBLEND_AG2;
+	u32 L1_VLATCH_RCNR1_GNR_SW;
+	u32 L1_VLATCH_RCNR1_GNR_RATIO;
+	u32 L1_VLATCH_RCNR1_GNR_WIDE_EN;
+	u32 RESERVED_A_301;
+	u32 RESERVED_A_302;
+	u32 L1_VLATCH_RCNR2_SW;
+	u32 L1_VLATCH_RCNR2_CNF_DARK_AG0;
+	u32 L1_VLATCH_RCNR2_CNF_DARK_AG1;
+	u32 L1_VLATCH_RCNR2_CNF_DARK_AG2;
+	u32 L1_VLATCH_RCNR2_CNF_RATIO_AG0;
+	u32 L1_VLATCH_RCNR2_CNF_RATIO_AG1;
+	u32 L1_VLATCH_RCNR2_CNF_RATIO_AG2;
+	u32 L1_VLATCH_RCNR2_CNF_CLIP_GAIN_R;
+	u32 L1_VLATCH_RCNR2_CNF_CLIP_GAIN_G;
+	u32 L1_VLATCH_RCNR2_CNF_CLIP_GAIN_B;
+	u32 L1_VLATCH_RCNR2_A1L_DARK_AG0;
+	u32 L1_VLATCH_RCNR2_A1L_DARK_AG1;
+	u32 L1_VLATCH_RCNR2_A1L_DARK_AG2;
+	u32 L1_VLATCH_RCNR2_A1L_RATIO_AG0;
+	u32 L1_VLATCH_RCNR2_A1L_RATIO_AG1;
+	u32 L1_VLATCH_RCNR2_A1L_RATIO_AG2;
+	u32 L1_VLATCH_RCNR2_INF_ZERO_CLIP;
+	u32 RESERVED_A_303;
+	u32 L1_VLATCH_RCNR2_MERGE_D2BLEND_AG0;
+	u32 L1_VLATCH_RCNR2_MERGE_D2BLEND_AG1;
+	u32 L1_VLATCH_RCNR2_MERGE_D2BLEND_AG2;
+	u32 L1_VLATCH_RCNR2_MERGE_BLACK;
+	u32 L1_VLATCH_RCNR2_MERGE_MINDIV;
+	u32 L1_VLATCH_RCNR2_HRY_TYPE;
+	u32 L1_VLATCH_RCNR2_ANF_BLEND_AG0;
+	u32 L1_VLATCH_RCNR2_ANF_BLEND_AG1;
+	u32 L1_VLATCH_RCNR2_ANF_BLEND_AG2;
+	u32 RESERVED_A_304;
+	u32 L1_VLATCH_RCNR2_LPF_THRESHOLD;
+	u32 L1_VLATCH_RCNR2_MERGE_HLBLEND_AG0;
+	u32 L1_VLATCH_RCNR2_MERGE_HLBLEND_AG1;
+	u32 L1_VLATCH_RCNR2_MERGE_HLBLEND_AG2;
+	u32 L1_VLATCH_RCNR2_GNR_SW;
+	u32 L1_VLATCH_RCNR2_GNR_RATIO;
+	u32 L1_VLATCH_RCNR2_GNR_WIDE_EN;
+	u32 RESERVED_B_29[49];
+	u32 RESERVED_A_305;
+	u32 L1_VLATCH_HDRS_HDRRATIO_M;
+	u32 L1_VLATCH_HDRS_HDRRATIO_L;
+	u32 L1_VLATCH_HDRS_HDRRATIO_E;
+	u32 RESERVED_A_306;
+	u32 RESERVED_A_307;
+	u32 L1_VLATCH_HDRS_BLENDEND_H;
+	u32 L1_VLATCH_HDRS_BLENDEND_M;
+	u32 L1_VLATCH_HDRS_BLENDEND_E;
+	u32 L1_VLATCH_HDRS_BLENDBEG_H;
+	u32 L1_VLATCH_HDRS_BLENDBEG_M;
+	u32 L1_VLATCH_HDRS_BLENDBEG_E;
+	u32 RESERVED_A_308;
+	u32 RESERVED_A_309;
+	u32 RESERVED_A_310;
+	u32 RESERVED_A_311;
+	u32 RESERVED_A_312;
+	u32 RESERVED_A_313;
+	u32 L1_VLATCH_HDRS_DgH;
+	u32 L1_VLATCH_HDRS_DgM;
+	u32 L1_VLATCH_HDRS_DgL;
+	u32 L1_VLATCH_HDRS_DgE;
+	u32 L1_VLATCH_HDRS_LEDMODE_ON;
+	u32 L1_VLATCH_HDRS_HDRMODE;
+	u32 RESERVED_A_314;
+	u32 RESERVED_A_315;
+	u32 RESERVED_A_316;
+	u32 L1_VLATCH_HDRS_DSTMAXVAL;
+	u32 RESERVED_B_30[4];
+	u32 L1_VLATCH_BLVC_SRCBLACKLEVEL_GR;
+	u32 L1_VLATCH_BLVC_SRCBLACKLEVEL_R;
+	u32 L1_VLATCH_BLVC_SRCBLACKLEVEL_B;
+	u32 L1_VLATCH_BLVC_SRCBLACKLEVEL_GB;
+	u32 L1_VLATCH_BLVC_MULTVAL_GR;
+	u32 L1_VLATCH_BLVC_MULTVALR;
+	u32 L1_VLATCH_BLVC_MULTVALB;
+	u32 L1_VLATCH_BLVC_MULTVAL_GB;
+	u32 L1_VLATCH_BLVC_DSTMAXVAL;
+	u32 RESERVED_A_317;
+	u32 RESERVED_A_318;
+	u32 RESERVED_A_319;
+	u32 RESERVED_A_320;
+	u32 RESERVED_A_321;
+	u32 RESERVED_A_322;
+	u32 RESERVED_B_31[17];
+	u32 L1_VLATCH_LSSC_EN;
+	u32 RESERVED_A_323;
+	u32 RESERVED_A_324;
+	u32 RESERVED_A_325;
+	u32 L1_VLATCH_LSSC_PWHB_R_GAIN;
+	u32 L1_VLATCH_LSSC_PWHB_GR_GAIN;
+	u32 L1_VLATCH_LSSC_PWHB_GB_GAIN;
+	u32 L1_VLATCH_LSSC_PWHB_B_GAIN;
+	u32 L1_VLATCH_LSSC_PARA_EN;
+	u32 L1_VLATCH_LSSC_PARA_H_CENTER;
+	u32 L1_VLATCH_LSSC_PARA_V_CENTER;
+	u32 L1_VLATCH_LSSC_PARA_H_GAIN;
+	u32 L1_VLATCH_LSSC_PARA_V_GAIN;
+	u32 L1_VLATCH_LSSC_PARA_MGSEL2;
+	u32 L1_VLATCH_LSSC_PARA_MGSEL4;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_2D_HV_RD;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_R_COEF_4D_HV_RD;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_2D_HV_RD;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_GR_COEF_4D_HV_RD;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_2D_HV_RD;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_GB_COEF_4D_HV_RD;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_2D_HV_RD;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_H_L;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_H_R;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_V_U;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_V_D;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_HV_LU;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_HV_RU;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_HV_LD;
+	u32 L1_VLATCH_LSSC_PARA_B_COEF_4D_HV_RD;
+	u32 L1_VLATCH_LSSC_GRID_EN;
+	u32 L1_VLATCH_LSSC_GRID_H_CENTER;
+	u32 L1_VLATCH_LSSC_GRID_V_CENTER;
+	u32 L1_VLATCH_LSSC_GRID_H_SIZE;
+	u32 L1_VLATCH_LSSC_GRID_V_SIZE;
+	u32 L1_VLATCH_LSSC_GRID_MGSEL;
+	u32 RESERVED_B_32[11];
+	u32 L1_VLATCH_MPRO_SW;
+	u32 L1_VLATCH_MPRO_CONF;
+	u32 RESERVED_A_326;
+	u32 L1_VLATCH_MPRO_DST_MINVAL;
+	u32 L1_VLATCH_MPRO_DST_MAXVAL;
+	u32 RESERVED_A_327;
+	u32 RESERVED_A_328;
+	u32 RESERVED_A_329;
+	u32 L1_VLATCH_MPRO_LM0_RMG_MIN;
+	u32 L1_VLATCH_MPRO_LM0_RMB_MIN;
+	u32 L1_VLATCH_MPRO_LM0_GMR_MIN;
+	u32 L1_VLATCH_MPRO_LM0_GMB_MIN;
+	u32 L1_VLATCH_MPRO_LM0_BMR_MIN;
+	u32 L1_VLATCH_MPRO_LM0_BMG_MIN;
+	u32 L1_VLATCH_MPRO_LM0_RMG_MAX;
+	u32 L1_VLATCH_MPRO_LM0_RMB_MAX;
+	u32 L1_VLATCH_MPRO_LM0_GMR_MAX;
+	u32 L1_VLATCH_MPRO_LM0_GMB_MAX;
+	u32 L1_VLATCH_MPRO_LM0_BMR_MAX;
+	u32 L1_VLATCH_MPRO_LM0_BMG_MAX;
+	u32 RESERVED_A_330;
+	u32 RESERVED_A_331;
+	u32 RESERVED_A_332;
+	u32 RESERVED_A_333;
+	u32 RESERVED_A_334;
+	u32 RESERVED_A_335;
+	u32 RESERVED_A_336;
+	u32 RESERVED_A_337;
+	u32 RESERVED_A_338;
+	u32 RESERVED_A_339;
+	u32 RESERVED_A_340;
+	u32 RESERVED_A_341;
+	u32 RESERVED_A_342;
+	u32 RESERVED_A_343;
+	u32 RESERVED_A_344;
+	u32 RESERVED_A_345;
+	u32 RESERVED_A_346;
+	u32 RESERVED_A_347;
+	u32 RESERVED_A_348;
+	u32 RESERVED_A_349;
+	u32 RESERVED_A_350;
+	u32 RESERVED_A_351;
+	u32 RESERVED_A_352;
+	u32 RESERVED_A_353;
+	u32 RESERVED_A_354;
+	u32 RESERVED_A_355;
+	u32 RESERVED_A_356;
+	u32 RESERVED_A_357;
+	u32 RESERVED_A_358;
+	u32 RESERVED_A_359;
+	u32 RESERVED_A_360;
+	u32 RESERVED_A_361;
+	u32 RESERVED_A_362;
+	u32 RESERVED_A_363;
+	u32 RESERVED_A_364;
+	u32 RESERVED_A_365;
+	u32 RESERVED_A_366;
+	u32 RESERVED_A_367;
+	u32 RESERVED_A_368;
+	u32 RESERVED_B_33[1];
+	u32 L1_VLATCH_MPRO_LCS_MODE;
+	u32 RESERVED_A_369;
+	u32 RESERVED_A_370;
+	u32 RESERVED_A_371;
+	u32 RESERVED_A_372;
+	u32 RESERVED_A_373;
+	u32 RESERVED_A_374;
+	u32 RESERVED_A_375;
+	u32 RESERVED_A_376;
+	u32 RESERVED_A_377;
+	u32 RESERVED_A_378;
+	u32 RESERVED_A_379;
+	u32 RESERVED_A_380;
+	u32 RESERVED_A_381;
+	u32 RESERVED_A_382;
+	u32 RESERVED_A_383;
+	u32 RESERVED_A_384;
+	u32 RESERVED_A_385;
+	u32 RESERVED_A_386;
+	u32 RESERVED_A_387;
+	u32 RESERVED_A_388;
+	u32 RESERVED_A_389;
+	u32 RESERVED_A_390;
+	u32 RESERVED_A_391;
+	u32 RESERVED_A_392;
+	u32 RESERVED_A_393;
+	u32 RESERVED_A_394;
+	u32 RESERVED_A_395;
+	u32 RESERVED_A_396;
+	u32 RESERVED_A_397;
+	u32 RESERVED_B_34[70];
+	u32 L1_VLATCH_VPRO_PGC_SW;
+	u32 RESERVED_A_398;
+	u32 L1_VLATCH_VPRO_YUVC_SW;
+	u32 L1_VLATCH_VPRO_YNR_SW;
+	u32 L1_VLATCH_VPRO_ETE_SW;
+	u32 L1_VLATCH_VPRO_CSUP_UVSUP_SW;
+	u32 L1_VLATCH_VPRO_CSUP_CORING_SW;
+	u32 L1_VLATCH_VPRO_BRIGHT_SW;
+	u32 L1_VLATCH_VPRO_LCNT_SW;
+	u32 L1_VLATCH_VPRO_NLCNT_SW;
+	u32 RESERVED_A_399;
+	u32 L1_VLATCH_VPRO_EDGE_SUP_SW;
+	u32 L1_VLATCH_VPRO_CNR_SW;
+	u32 RESERVED_A_400;
+	u32 L1_VLATCH_VPRO_BLKADJ;
+	u32 L1_VLATCH_VPRO_GAM01P;
+	u32 L1_VLATCH_VPRO_GAM02P;
+	u32 L1_VLATCH_VPRO_GAM03P;
+	u32 L1_VLATCH_VPRO_GAM04P;
+	u32 L1_VLATCH_VPRO_GAM05P;
+	u32 L1_VLATCH_VPRO_GAM06P;
+	u32 L1_VLATCH_VPRO_GAM07P;
+	u32 L1_VLATCH_VPRO_GAM08P;
+	u32 L1_VLATCH_VPRO_GAM09P;
+	u32 L1_VLATCH_VPRO_GAM10P;
+	u32 L1_VLATCH_VPRO_GAM11P;
+	u32 L1_VLATCH_VPRO_GAM12P;
+	u32 L1_VLATCH_VPRO_GAM13P;
+	u32 L1_VLATCH_VPRO_GAM14P;
+	u32 L1_VLATCH_VPRO_GAM15P;
+	u32 L1_VLATCH_VPRO_GAM16P;
+	u32 L1_VLATCH_VPRO_GAM17P;
+	u32 L1_VLATCH_VPRO_GAM18P;
+	u32 L1_VLATCH_VPRO_GAM19P;
+	u32 L1_VLATCH_VPRO_GAM20P;
+	u32 L1_VLATCH_VPRO_GAM21P;
+	u32 L1_VLATCH_VPRO_GAM22P;
+	u32 L1_VLATCH_VPRO_GAM23P;
+	u32 L1_VLATCH_VPRO_GAM24P;
+	u32 L1_VLATCH_VPRO_GAM25P;
+	u32 L1_VLATCH_VPRO_GAM26P;
+	u32 L1_VLATCH_VPRO_GAM27P;
+	u32 L1_VLATCH_VPRO_GAM28P;
+	u32 L1_VLATCH_VPRO_GAM29P;
+	u32 L1_VLATCH_VPRO_GAM30P;
+	u32 L1_VLATCH_VPRO_GAM31P;
+	u32 L1_VLATCH_VPRO_GAM32P;
+	u32 L1_VLATCH_VPRO_GAM33P;
+	u32 L1_VLATCH_VPRO_GAM34P;
+	u32 L1_VLATCH_VPRO_GAM35P;
+	u32 L1_VLATCH_VPRO_GAM36P;
+	u32 L1_VLATCH_VPRO_GAM37P;
+	u32 L1_VLATCH_VPRO_GAM38P;
+	u32 L1_VLATCH_VPRO_GAM39P;
+	u32 L1_VLATCH_VPRO_GAM40P;
+	u32 L1_VLATCH_VPRO_GAM41P;
+	u32 L1_VLATCH_VPRO_GAM42P;
+	u32 L1_VLATCH_VPRO_GAM43P;
+	u32 L1_VLATCH_VPRO_GAM44P;
+	u32 L1_VLATCH_VPRO_CB_MAT;
+	u32 L1_VLATCH_VPRO_CR_MAT;
+	u32 L1_VLATCH_VPRO_BRIGHT;
+	u32 L1_VLATCH_VPRO_LCONT_LEV;
+	u32 L1_VLATCH_VPRO_BLK_KNEE;
+	u32 L1_VLATCH_VPRO_WHT_KNEE;
+	u32 L1_VLATCH_VPRO_BLK_CONT0;
+	u32 L1_VLATCH_VPRO_BLK_CONT1;
+	u32 L1_VLATCH_VPRO_BLK_CONT2;
+	u32 L1_VLATCH_VPRO_WHT_CONT0;
+	u32 L1_VLATCH_VPRO_WHT_CONT1;
+	u32 L1_VLATCH_VPRO_WHT_CONT2;
+	u32 RESERVED_A_401;
+	u32 RESERVED_A_402;
+	u32 RESERVED_A_403;
+	u32 RESERVED_A_404;
+	u32 RESERVED_A_405;
+	u32 RESERVED_A_406;
+	u32 L1_VLATCH_VPRO_YNR_GAIN_MIN;
+	u32 L1_VLATCH_VPRO_YNR_GAIN_MAX;
+	u32 L1_VLATCH_VPRO_YNR_LIM_MIN;
+	u32 L1_VLATCH_VPRO_YNR_LIM_MAX;
+	u32 L1_VLATCH_VPRO_ETE_GAIN_MIN;
+	u32 L1_VLATCH_VPRO_ETE_GAIN_MAX;
+	u32 L1_VLATCH_VPRO_ETE_LIM_MIN;
+	u32 L1_VLATCH_VPRO_ETE_LIM_MAX;
+	u32 L1_VLATCH_VPRO_ETE_CORING_MIN;
+	u32 L1_VLATCH_VPRO_ETE_CORING_MAX;
+	u32 L1_VLATCH_VPRO_CB_GAIN;
+	u32 L1_VLATCH_VPRO_CR_GAIN;
+	u32 L1_VLATCH_VPRO_CBR_MGAIN_MIN;
+	u32 L1_VLATCH_VPRO_CbP_GAIN_MAX;
+	u32 L1_VLATCH_VPRO_CbM_GAIN_MAX;
+	u32 L1_VLATCH_VPRO_CrP_GAIN_MAX;
+	u32 L1_VLATCH_VPRO_CrM_GAIN_MAX;
+	u32 L1_VLATCH_VPRO_CSUP_CORING_LV_MIN;
+	u32 L1_VLATCH_VPRO_CSUP_CORING_LV_MAX;
+	u32 L1_VLATCH_VPRO_CSUP_CORING_GAIN_MIN;
+	u32 L1_VLATCH_VPRO_CSUP_CORING_GAIN_MAX;
+	u32 L1_VLATCH_VPRO_CSUP_BK_SLV;
+	u32 L1_VLATCH_VPRO_CSUP_BK_MP;
+	u32 L1_VLATCH_VPRO_CSUP_BLACK;
+	u32 L1_VLATCH_VPRO_CSUP_WH_SLV;
+	u32 L1_VLATCH_VPRO_CSUP_WH_MP;
+	u32 L1_VLATCH_VPRO_CSUP_WHITE;
+	u32 L1_VLATCH_VPRO_EDGE_SUP_GAIN;
+	u32 L1_VLATCH_VPRO_EDGE_SUP_LIM;
+	u32 RESERVED_B_35[22];
+	u32 L1_VLATCH_AWHB_SW;
+	u32 RESERVED_A_407;
+	u32 L1_VLATCH_AWHB_WBMRG;
+	u32 L1_VLATCH_AWHB_WBMGG;
+	u32 L1_VLATCH_AWHB_WBMBG;
+	u32 L1_VLATCH_AWHB_GATE_CONF0;
+	u32 L1_VLATCH_AWHB_GATE_CONF1;
+	u32 L1_VLATCH_AWHB_AREA_HSIZE;
+	u32 L1_VLATCH_AWHB_AREA_VSIZE;
+	u32 L1_VLATCH_AWHB_AREA_HOFS;
+	u32 L1_VLATCH_AWHB_AREA_VOFS;
+	u32 L1_VLATCH_AWHB_AREA_MASKH;
+	u32 L1_VLATCH_AWHB_AREA_MASKL;
+	u32 L1_VLATCH_AWHB_SQ_CONF;
+	u32 L1_VLATCH_AWHB_YGATEH;
+	u32 L1_VLATCH_AWHB_YGATEL;
+	u32 RESERVED_A_408;
+	u32 RESERVED_A_409;
+	u32 L1_VLATCH_AWHB_BYCUT0P;
+	u32 L1_VLATCH_AWHB_BYCUT0N;
+	u32 L1_VLATCH_AWHB_RYCUT0P;
+	u32 L1_VLATCH_AWHB_RYCUT0N;
+	u32 L1_VLATCH_AWHB_RBCUT0H;
+	u32 L1_VLATCH_AWHB_RBCUT0L;
+	u32 RESERVED_A_410;
+	u32 RESERVED_A_411;
+	u32 RESERVED_A_412;
+	u32 RESERVED_A_413;
+	u32 RESERVED_A_414;
+	u32 RESERVED_A_415;
+	u32 L1_VLATCH_AWHB_BYCUT1H;
+	u32 L1_VLATCH_AWHB_BYCUT1L;
+	u32 L1_VLATCH_AWHB_RYCUT1H;
+	u32 L1_VLATCH_AWHB_RYCUT1L;
+	u32 L1_VLATCH_AWHB_BYCUT2H;
+	u32 L1_VLATCH_AWHB_BYCUT2L;
+	u32 L1_VLATCH_AWHB_RYCUT2H;
+	u32 L1_VLATCH_AWHB_RYCUT2L;
+	u32 L1_VLATCH_AWHB_BYCUT3H;
+	u32 L1_VLATCH_AWHB_BYCUT3L;
+	u32 L1_VLATCH_AWHB_RYCUT3H;
+	u32 L1_VLATCH_AWHB_RYCUT3L;
+	u32 L1_VLATCH_AWHB_AWBSFTU;
+	u32 L1_VLATCH_AWHB_AWBSFTV;
+	u32 L1_VLATCH_AWHB_AWBSPD;
+	u32 L1_VLATCH_AWHB_AWBULV;
+	u32 L1_VLATCH_AWHB_AWBVLV;
+	u32 L1_VLATCH_AWHB_AWBWAIT;
+	u32 L1_VLATCH_AWHB_AWBONDOT;
+	u32 L1_VLATCH_AWHB_AWBFZTIM;
+	u32 L1_VLATCH_AWHB_WBGRMAX;
+	u32 L1_VLATCH_AWHB_WBGRMIN;
+	u32 L1_VLATCH_AWHB_WBGBMAX;
+	u32 L1_VLATCH_AWHB_WBGBMIN;
+	u32 RESERVED_A_416;
+	u32 RESERVED_A_417;
+	u32 RESERVED_A_418;
+	u32 RESERVED_A_419;
+	u32 RESERVED_A_420;
+	u32 RESERVED_A_421;
+	u32 RESERVED_A_422;
+	u32 RESERVED_A_423;
+	u32 RESERVED_A_424;
+	u32 RESERVED_A_425;
+	u32 RESERVED_A_426;
+	u32 RESERVED_A_427;
+	u32 RESERVED_A_428;
+	u32 RESERVED_A_429;
+	u32 RESERVED_A_430;
+	u32 RESERVED_A_431;
+	u32 RESERVED_A_432;
+	u32 RESERVED_A_433;
+	u32 RESERVED_A_434;
+	u32 RESERVED_A_435;
+	u32 RESERVED_A_436;
+	u32 RESERVED_A_437;
+	u32 RESERVED_A_438;
+	u32 RESERVED_A_439;
+	u32 RESERVED_B_36[2];
+	u32 L1_VLATCH_HOBC_EN;
+	u32 L1_VLATCH_HOBC_MARGIN;
+	u32 RESERVED_A_440;
+	u32 RESERVED_A_441;
+	u32 L1_VLATCH_HOBC0_LOB_REFLV_GR;
+	u32 L1_VLATCH_HOBC0_LOB_WIDTH_GR;
+	u32 L1_VLATCH_HOBC0_LOB_REFLV_R;
+	u32 L1_VLATCH_HOBC0_LOB_WIDTH_R;
+	u32 L1_VLATCH_HOBC0_LOB_REFLV_B;
+	u32 L1_VLATCH_HOBC0_LOB_WIDTH_B;
+	u32 L1_VLATCH_HOBC0_LOB_REFLV_GB;
+	u32 L1_VLATCH_HOBC0_LOB_WIDTH_GB;
+	u32 L1_VLATCH_HOBC1_LOB_REFLV_GR;
+	u32 L1_VLATCH_HOBC1_LOB_WIDTH_GR;
+	u32 L1_VLATCH_HOBC1_LOB_REFLV_R;
+	u32 L1_VLATCH_HOBC1_LOB_WIDTH_R;
+	u32 L1_VLATCH_HOBC1_LOB_REFLV_B;
+	u32 L1_VLATCH_HOBC1_LOB_WIDTH_B;
+	u32 L1_VLATCH_HOBC1_LOB_REFLV_GB;
+	u32 L1_VLATCH_HOBC1_LOB_WIDTH_GB;
+	u32 L1_VLATCH_HOBC2_LOB_REFLV_GR;
+	u32 L1_VLATCH_HOBC2_LOB_WIDTH_GR;
+	u32 L1_VLATCH_HOBC2_LOB_REFLV_R;
+	u32 L1_VLATCH_HOBC2_LOB_WIDTH_R;
+	u32 L1_VLATCH_HOBC2_LOB_REFLV_B;
+	u32 L1_VLATCH_HOBC2_LOB_WIDTH_B;
+	u32 L1_VLATCH_HOBC2_LOB_REFLV_GB;
+	u32 L1_VLATCH_HOBC2_LOB_WIDTH_GB;
+	u32 L1_VLATCH_HOBC0_SRC_BLKLV_GR;
+	u32 L1_VLATCH_HOBC0_SRC_BLKLV_R;
+	u32 L1_VLATCH_HOBC0_SRC_BLKLV_B;
+	u32 L1_VLATCH_HOBC0_SRC_BLKLV_GB;
+	u32 L1_VLATCH_HOBC1_SRC_BLKLV_GR;
+	u32 L1_VLATCH_HOBC1_SRC_BLKLV_R;
+	u32 L1_VLATCH_HOBC1_SRC_BLKLV_B;
+	u32 L1_VLATCH_HOBC1_SRC_BLKLV_GB;
+	u32 L1_VLATCH_HOBC2_SRC_BLKLV_GR;
+	u32 L1_VLATCH_HOBC2_SRC_BLKLV_R;
+	u32 L1_VLATCH_HOBC2_SRC_BLKLV_B;
+	u32 L1_VLATCH_HOBC2_SRC_BLKLV_GB;
+	u32 RESERVED_A_442;
+	u32 RESERVED_A_443;
+	u32 RESERVED_A_444;
+	u32 RESERVED_A_445;
+	u32 RESERVED_A_446;
+	u32 RESERVED_A_447;
+	u32 L1_VLATCH_HOBC_MAX_VAL;
+	u32 RESERVED_B_37[33];
+	u32 L1_VLATCH_HDRC_EN;
+	u32 L1_VLATCH_HDRC_THR_SFT_AMT;
+	u32 RESERVED_A_448;
+	u32 L1_VLATCH_HDRC_RATIO;
+	u32 RESERVED_A_449;
+	u32 RESERVED_A_450;
+	u32 RESERVED_A_451;
+	u32 L1_VLATCH_HDRC_PT_RATIO;
+	u32 L1_VLATCH_HDRC_PT_BLEND;
+	u32 L1_VLATCH_HDRC_PT_BLEND2;
+	u32 L1_VLATCH_HDRC_PT_SAT;
+	u32 L1_VLATCH_HDRC_TN_TYPE;
+	u32 L1_VLATCH_HDRC_TNP_MAX;
+	u32 L1_VLATCH_HDRC_TNP_MAG;
+	u32 RESERVED_A_452;
+	u32 RESERVED_A_453;
+	u32 RESERVED_A_454;
+	u32 RESERVED_A_455;
+	u32 L1_VLATCH_HDRC_TNP_FIL0;
+	u32 L1_VLATCH_HDRC_TNP_FIL1;
+	u32 L1_VLATCH_HDRC_TNP_FIL2;
+	u32 L1_VLATCH_HDRC_TNP_FIL3;
+	u32 L1_VLATCH_HDRC_TNP_FIL4;
+	u32 L1_VLATCH_HDRC_UTN_TBL0;
+	u32 L1_VLATCH_HDRC_UTN_TBL1;
+	u32 L1_VLATCH_HDRC_UTN_TBL2;
+	u32 L1_VLATCH_HDRC_UTN_TBL3;
+	u32 L1_VLATCH_HDRC_UTN_TBL4;
+	u32 L1_VLATCH_HDRC_UTN_TBL5;
+	u32 L1_VLATCH_HDRC_UTN_TBL6;
+	u32 L1_VLATCH_HDRC_UTN_TBL7;
+	u32 L1_VLATCH_HDRC_UTN_TBL8;
+	u32 L1_VLATCH_HDRC_UTN_TBL9;
+	u32 L1_VLATCH_HDRC_UTN_TBL10;
+	u32 L1_VLATCH_HDRC_UTN_TBL11;
+	u32 L1_VLATCH_HDRC_UTN_TBL12;
+	u32 L1_VLATCH_HDRC_UTN_TBL13;
+	u32 L1_VLATCH_HDRC_UTN_TBL14;
+	u32 L1_VLATCH_HDRC_UTN_TBL15;
+	u32 L1_VLATCH_HDRC_UTN_TBL16;
+	u32 L1_VLATCH_HDRC_UTN_TBL17;
+	u32 L1_VLATCH_HDRC_UTN_TBL18;
+	u32 L1_VLATCH_HDRC_UTN_TBL19;
+	u32 L1_VLATCH_HDRC_FLR_VAL;
+	u32 L1_VLATCH_HDRC_FLR_ADP;
+	u32 RESERVED_A_456;
+	u32 RESERVED_A_457;
+	u32 RESERVED_A_458;
+	u32 RESERVED_A_459;
+	u32 RESERVED_A_460;
+	u32 RESERVED_A_461;
+	u32 RESERVED_A_462;
+	u32 RESERVED_A_463;
+	u32 RESERVED_A_464;
+	u32 RESERVED_A_465;
+	u32 RESERVED_A_466;
+	u32 RESERVED_A_467;
+	u32 RESERVED_A_468;
+	u32 RESERVED_A_469;
+	u32 L1_VLATCH_HDRC_YBR_OFF;
+	u32 L1_VLATCH_HDRC_ORGY_BLEND;
+	u32 RESERVED_A_470;
+	u32 RESERVED_A_471;
+	u32 RESERVED_A_472;
+	u32 L1_VLATCH_HDRC_MAR_TOP;
+	u32 L1_VLATCH_HDRC_MAR_LEFT;
+	u32 RESERVED_A_473;
+	u32 RESERVED_A_474;
+	u32 RESERVED_B_38[28];
+	u32 L1_VLATCH_HIST_EN;
+	u32 L1_VLATCH_HIST_MODE;
+	u32 L1_VLATCH_HIST_BLOCK_OFST;
+	u32 L1_VLATCH_HIST_BLOCK_SIZE;
+	u32 L1_VLATCH_HIST_BLOCK_NUM;
+	u32 L1_VLATCH_HIST_BLOCK_STEP;
+	u32 L1_VLATCH_HIST_LINEAR_SFT;
+	u32 L1_VLATCH_HIST_MULT_A_R;
+	u32 L1_VLATCH_HIST_ADD_A_R;
+	u32 L1_VLATCH_HIST_MULT_B_R;
+	u32 L1_VLATCH_HIST_ADD_B_R;
+	u32 L1_VLATCH_HIST_MULT_A_G;
+	u32 L1_VLATCH_HIST_ADD_A_G;
+	u32 L1_VLATCH_HIST_MULT_B_G;
+	u32 L1_VLATCH_HIST_ADD_B_G;
+	u32 L1_VLATCH_HIST_MULT_A_B;
+	u32 L1_VLATCH_HIST_ADD_A_B;
+	u32 L1_VLATCH_HIST_MULT_B_B;
+	u32 L1_VLATCH_HIST_ADD_B_B;
+	u32 L1_VLATCH_HIST_MULT_A_Y;
+	u32 L1_VLATCH_HIST_ADD_A_Y;
+	u32 L1_VLATCH_HIST_MULT_B_Y;
+	u32 L1_VLATCH_HIST_ADD_B_Y;
+	u32 RESERVED_B_39[265];
+};
+
+/**
+ * struct hwd_viif_l2isp_stadr_buf_reg - Registers for L2ISP control
+ */
+struct hwd_viif_l2isp_stadr_buf_reg {
+	u32 L2_POST_OUT_STADR_B_BUF;
+	u32 L2_POST_OUT_STADR_G_BUF;
+	u32 L2_POST_OUT_STADR_R_BUF;
+};
+
+struct hwd_viif_l2isp_roi_reg {
+	u32 L2_ROI_SCALE;
+	u32 L2_ROI_SCALE_INV;
+	u32 L2_ROI_CORRECTED_HSIZE;
+	u32 L2_ROI_CORRECTED_VSIZE;
+	u32 L2_ROI_OUT_OFS_H;
+	u32 L2_ROI_OUT_OFS_V;
+	u32 L2_ROI_OUT_HSIZE;
+	u32 L2_ROI_OUT_VSIZE;
+};
+
+struct hwd_viif_l2isp_post_reg {
+	u32 L2_POST_CAP_OFFSET;
+	u32 L2_POST_CAP_SIZE;
+	u32 L2_POST_HALF_SCALE_EN;
+	u32 RESERVED_B_47[17];
+	u32 L2_POST_GAMMA_M;
+	u32 RESERVED_B_48[3];
+	u32 L2_POST_C_SELECT;
+	u32 RESERVED_B_49[3];
+	struct hwd_viif_csc_reg csc;
+	u32 L2_POST_OPORTALP;
+	u32 L2_POST_OPORTFMT;
+	u32 L2_POST_OUT_STADR_B;
+	u32 L2_POST_OUT_STADR_G;
+	u32 L2_POST_OUT_STADR_R;
+	u32 L2_POST_OUT_PITCH_B;
+	u32 L2_POST_OUT_PITCH_G;
+	u32 L2_POST_OUT_PITCH_R;
+	u32 L2_POST_DUMMY_READ_EN;
+	u32 RESERVED_B_51[11];
+};
+
+struct hwd_viif_l2isp_reg {
+	u32 L2_SENSOR_CROP_OFS_H;
+	u32 L2_SENSOR_CROP_OFS_V;
+	u32 L2_SENSOR_CROP_HSIZE;
+	u32 L2_SENSOR_CROP_VSIZE;
+	u32 RESERVED_A_475;
+	u32 L2_L2_STATUS;
+	u32 L2_BUS_L2_STATUS;
+	/* [0]: POST0, [1]: POST1 */
+	struct hwd_viif_l2isp_stadr_buf_reg stadr_buf[2];
+	u32 RESERVED_B_40[3];
+	u32 L2_ROI_NUM;
+	/* [0]: POST0, [1]: POST1 */
+	u32 L2_ROI_TO_POST[2];
+	u32 RESERVED_B_41;
+	/* [0]: ROI0, [1]: ROI1 */
+	struct hwd_viif_l2isp_roi_reg roi[2];
+	u32 RESERVED_B_42[8];
+	u32 L2_VALID_R_NORM2_POLY;
+	u32 L2_VALID_R_NORM2_GRID;
+	u32 RESERVED_A_476;
+	u32 RESERVED_B_43[17];
+	u32 L2_MODE;
+	u32 L2_NORM_SCALE;
+	u32 RESERVED_B_44;
+	/* [0]: ROI0, [1]: ROI1 */
+	u32 L2_ROI_WRITE_AREA_DELTA[2];
+	u32 RESERVED_B_45;
+	u32 L2_GRID_NODE_NUM_H;
+	u32 L2_GRID_NODE_NUM_V;
+	u32 L2_GRID_PATCH_HSIZE_INV;
+	u32 L2_GRID_PATCH_VSIZE_INV;
+	u32 L2_POLY10_WRITE_G_COEF[11];
+	u32 L2_POLY10_READ_B_COEF[11];
+	u32 L2_POLY10_READ_G_COEF[11];
+	u32 L2_POLY10_READ_R_COEF[11];
+	u32 RESERVED_B_46[10];
+	/* [0]: POST0, [1]: POST1 */
+	struct hwd_viif_l2isp_post_reg post[2];
+	u32 RESERVED_B_56[192];
+	u32 L2_CRGBF_ACC_CONF;
+	u32 L2_CRGBF_TRN_M_RUN;
+	u32 L2_CRGBF_TRN_M_CONF;
+	u32 L2_CRGBF_TRN_A_CONF;
+	u32 L2_CRGBF_TRN_STAT_CLR;
+	u32 L2_CRGBF_TRN_STAT;
+	u32 L2_CRGBF_INT_STAT;
+	u32 L2_CRGBF_INT_MASK;
+	u32 L2_CRGBF_INT_MASKED_STAT;
+	u32 L2_CRGBF_TRN_WBADDR;
+	u32 L2_CRGBF_TRN_WEADDR;
+	u32 L2_CRGBF_TRN_RBADDR;
+	u32 L2_CRGBF_TRN_READDR;
+	u32 L2_CRGBF_ISP_INT;
+	u32 L2_CRGBF_ISP_INT_MASK;
+	u32 L2_CRGBF_ISP_INT_MASKED_STAT;
+	u32 RESERVED_A_477;
+	u32 RESERVED_B_57[47];
+	u32 L2_SENSOR_CROP_OFS_H_BUF;
+	u32 L2_SENSOR_CROP_OFS_V_BUF;
+	u32 L2_SENSOR_CROP_HSIZE_BUF;
+	u32 L2_SENSOR_CROP_VSIZE_BUF;
+	u32 RESERVED_A_478;
+	u32 RESERVED_B_58[11];
+	u32 L2_ROI_NUM_BUF;
+	u32 L2_ROI_TO_POST0_BUF;
+	u32 L2_ROI_TO_POST1_BUF;
+	u32 RESERVED_B_59;
+	u32 L2_ROI0_SCALE_BUF;
+	u32 L2_ROI0_SCALE_INV_BUF;
+	u32 L2_ROI0_CORRECTED_HSIZE_BUF;
+	u32 L2_ROI0_CORRECTED_VSIZE_BUF;
+	u32 L2_ROI0_OUT_OFS_H_BUF;
+	u32 L2_ROI0_OUT_OFS_V_BUF;
+	u32 L2_ROI0_OUT_HSIZE_BUF;
+	u32 L2_ROI0_OUT_VSIZE_BUF;
+	u32 L2_ROI1_SCALE_BUF;
+	u32 L2_ROI1_SCALE_INV_BUF;
+	u32 L2_ROI1_CORRECTED_HSIZE_BUF;
+	u32 L2_ROI1_CORRECTED_VSIZE_BUF;
+	u32 L2_ROI1_OUT_OFS_H_BUF;
+	u32 L2_ROI1_OUT_OFS_V_BUF;
+	u32 L2_ROI1_OUT_HSIZE_BUF;
+	u32 L2_ROI1_OUT_VSIZE_BUF;
+	u32 RESERVED_B_60[8];
+	u32 L2_VALID_R_NORM2_POLY_BUF;
+	u32 L2_VALID_R_NORM2_GRID_BUF;
+	u32 RESERVED_A_479;
+	u32 RESERVED_B_61[17];
+	u32 L2_MODE_BUF;
+	u32 L2_NORM_SCALE_BUF;
+	u32 RESERVED_B_62;
+	u32 L2_ROI0_WRITE_AREA_DELTA_BUF;
+	u32 L2_ROI1_WRITE_AREA_DELTA_BUF;
+	u32 RESERVED_B_63;
+	u32 L2_GRID_NODE_NUM_H_BUF;
+	u32 L2_GRID_NODE_NUM_V_BUF;
+	u32 L2_GRID_PATCH_HSIZE_INV_BUF;
+	u32 L2_GRID_PATCH_VSIZE_INV_BUF;
+	u32 L2_POLY10_WRITE_G_COEF00_BUF;
+	u32 L2_POLY10_WRITE_G_COEF01_BUF;
+	u32 L2_POLY10_WRITE_G_COEF02_BUF;
+	u32 L2_POLY10_WRITE_G_COEF03_BUF;
+	u32 L2_POLY10_WRITE_G_COEF04_BUF;
+	u32 L2_POLY10_WRITE_G_COEF05_BUF;
+	u32 L2_POLY10_WRITE_G_COEF06_BUF;
+	u32 L2_POLY10_WRITE_G_COEF07_BUF;
+	u32 L2_POLY10_WRITE_G_COEF08_BUF;
+	u32 L2_POLY10_WRITE_G_COEF09_BUF;
+	u32 L2_POLY10_WRITE_G_COEF10_BUF;
+	u32 L2_POLY10_READ_B_COEF00_BUF;
+	u32 L2_POLY10_READ_B_COEF01_BUF;
+	u32 L2_POLY10_READ_B_COEF02_BUF;
+	u32 L2_POLY10_READ_B_COEF03_BUF;
+	u32 L2_POLY10_READ_B_COEF04_BUF;
+	u32 L2_POLY10_READ_B_COEF05_BUF;
+	u32 L2_POLY10_READ_B_COEF06_BUF;
+	u32 L2_POLY10_READ_B_COEF07_BUF;
+	u32 L2_POLY10_READ_B_COEF08_BUF;
+	u32 L2_POLY10_READ_B_COEF09_BUF;
+	u32 L2_POLY10_READ_B_COEF10_BUF;
+	u32 L2_POLY10_READ_G_COEF00_BUF;
+	u32 L2_POLY10_READ_G_COEF01_BUF;
+	u32 L2_POLY10_READ_G_COEF02_BUF;
+	u32 L2_POLY10_READ_G_COEF03_BUF;
+	u32 L2_POLY10_READ_G_COEF04_BUF;
+	u32 L2_POLY10_READ_G_COEF05_BUF;
+	u32 L2_POLY10_READ_G_COEF06_BUF;
+	u32 L2_POLY10_READ_G_COEF07_BUF;
+	u32 L2_POLY10_READ_G_COEF08_BUF;
+	u32 L2_POLY10_READ_G_COEF09_BUF;
+	u32 L2_POLY10_READ_G_COEF10_BUF;
+	u32 L2_POLY10_READ_R_COEF00_BUF;
+	u32 L2_POLY10_READ_R_COEF01_BUF;
+	u32 L2_POLY10_READ_R_COEF02_BUF;
+	u32 L2_POLY10_READ_R_COEF03_BUF;
+	u32 L2_POLY10_READ_R_COEF04_BUF;
+	u32 L2_POLY10_READ_R_COEF05_BUF;
+	u32 L2_POLY10_READ_R_COEF06_BUF;
+	u32 L2_POLY10_READ_R_COEF07_BUF;
+	u32 L2_POLY10_READ_R_COEF08_BUF;
+	u32 L2_POLY10_READ_R_COEF09_BUF;
+	u32 L2_POLY10_READ_R_COEF10_BUF;
+	u32 RESERVED_B_64[10];
+	u32 L2_POST0_CAP_OFFSET_BUF;
+	u32 L2_POST0_CAP_SIZE_BUF;
+	u32 L2_POST0_HALF_SCALE_EN_BUF;
+	u32 RESERVED_B_65[17];
+	u32 L2_POST0_GAMMA_M_BUF;
+	u32 RESERVED_B_66[3];
+	u32 L2_POST0_C_SELECT_BUF;
+	u32 RESERVED_B_67[3];
+	u32 L2_POST0_MTB_BUF;
+	u32 RESERVED_B_68[3];
+	u32 L2_POST0_MTB_YG_OFFSETI_BUF;
+	u32 L2_POST0_MTB_YG1_BUF;
+	u32 L2_POST0_MTB_YG2_BUF;
+	u32 L2_POST0_MTB_YG_OFFSETO_BUF;
+	u32 L2_POST0_MTB_CB_OFFSETI_BUF;
+	u32 L2_POST0_MTB_CB1_BUF;
+	u32 L2_POST0_MTB_CB2_BUF;
+	u32 L2_POST0_MTB_CB_OFFSETO_BUF;
+	u32 L2_POST0_MTB_CR_OFFSETI_BUF;
+	u32 L2_POST0_MTB_CR1_BUF;
+	u32 L2_POST0_MTB_CR2_BUF;
+	u32 L2_POST0_MTB_CR_OFFSETO_BUF;
+	u32 L2_POST0_OPORTALP_BUF;
+	u32 L2_POST0_OPORTFMT_BUF;
+	u32 RESERVED_B_69[3];
+	u32 L2_POST0_OUT_PITCH_B_BUF;
+	u32 L2_POST0_OUT_PITCH_G_BUF;
+	u32 L2_POST0_OUT_PITCH_R_BUF;
+	u32 L2_POST0_DUMMY_READ_EN_BUF;
+	u32 RESERVED_B_70[11];
+	u32 L2_POST1_CAP_OFFSET_BUF;
+	u32 L2_POST1_CAP_SIZE_BUF;
+	u32 L2_POST1_HALF_SCALE_EN_BUF;
+	u32 RESERVED_B_71[17];
+	u32 L2_POST1_GAMMA_M_BUF;
+	u32 RESERVED_B_72[3];
+	u32 L2_POST1_C_SELECT_BUF;
+	u32 RESERVED_B_73[3];
+	u32 L2_POST1_MTB_BUF;
+	u32 RESERVED_B_74[3];
+	u32 L2_POST1_MTB_YG_OFFSETI_BUF;
+	u32 L2_POST1_MTB_YG1_BUF;
+	u32 L2_POST1_MTB_YG2_BUF;
+	u32 L2_POST1_MTB_YG_OFFSETO_BUF;
+	u32 L2_POST1_MTB_CB_OFFSETI_BUF;
+	u32 L2_POST1_MTB_CB1_BUF;
+	u32 L2_POST1_MTB_CB2_BUF;
+	u32 L2_POST1_MTB_CB_OFFSETO_BUF;
+	u32 L2_POST1_MTB_CR_OFFSETI_BUF;
+	u32 L2_POST1_MTB_CR1_BUF;
+	u32 L2_POST1_MTB_CR2_BUF;
+	u32 L2_POST1_MTB_CR_OFFSETO_BUF;
+	u32 L2_POST1_OPORTALP_BUF;
+	u32 L2_POST1_OPORTFMT_BUF;
+	u32 RESERVED_B_75[3];
+	u32 L2_POST1_OUT_PITCH_B_BUF;
+	u32 L2_POST1_OUT_PITCH_G_BUF;
+	u32 L2_POST1_OUT_PITCH_R_BUF;
+	u32 L2_POST1_DUMMY_READ_EN_BUF;
+	u32 RESERVED_B_76[64];
+};
+
+/**
+ * struct hwd_viif_capture_reg - Registers for VIIF CAPTURE control
+ */
+struct hwd_viif_capture_reg {
+	struct hwd_viif_system_reg sys;
+	struct hwd_viif_vdm_reg vdm;
+	struct hwd_viif_l1isp_reg l1isp;
+	struct hwd_viif_l2isp_reg l2isp;
+};
+
+#endif /* HWD_VIIF_REG_H */
diff --git a/drivers/media/platform/visconti/viif.c b/drivers/media/platform/visconti/viif.c
new file mode 100644
index 000000000..0b1540439
--- /dev/null
+++ b/drivers/media/platform/visconti/viif.c
@@ -0,0 +1,479 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <media/v4l2-fwnode.h>
+
+#include "viif.h"
+
+void visconti_viif_hw_on(struct viif_device *viif_dev)
+{
+	hwd_viif_initialize(viif_dev->ch, viif_dev->csi2host_reg, viif_dev->capture_reg);
+}
+
+void visconti_viif_hw_off(struct viif_device *viif_dev)
+{
+	/* Uninitialize HWD driver */
+	hwd_viif_uninitialize(viif_dev->ch);
+}
+
+static inline struct viif_device *v4l2_to_viif(struct v4l2_device *v4l2_dev)
+{
+	return container_of(v4l2_dev, struct viif_device, v4l2_dev);
+}
+
+static struct viif_subdev *to_viif_subdev(struct v4l2_async_subdev *asd)
+{
+	return container_of(asd, struct viif_subdev, asd);
+}
+
+#define MASK_SYNC_M_DELAY2 BIT(2)
+#define MASK_SYNC_S_DELAY  BIT(1)
+#define MASK_M_DELAY_INT   BIT(24)
+
+static void viif_vsync_irq_handler_w_isp(struct viif_device *viif_dev)
+{
+	u32 event_main, event_sub, status_err, l2_transfer_status;
+	u64 ts;
+
+	ts = ktime_get_ns();
+	hwd_viif_vsync_irq_handler(viif_dev->ch, &event_main, &event_sub);
+
+	/* Delayed Vsync of MAIN unit */
+	if (event_main & MASK_SYNC_M_DELAY2) {
+		/* unmask timeout error of gamma table */
+		hwd_viif_main_status_err_set_irq_mask(viif_dev->ch, MASK_M_DELAY_INT);
+		viif_dev->masked_gamma_path = 0;
+
+		/* Get abort status of L2ISP */
+		hwd_viif_isp_guard_start(viif_dev->ch);
+		hwd_viif_isp_get_info(viif_dev->ch, NULL, &l2_transfer_status);
+		hwd_viif_isp_guard_end(viif_dev->ch);
+
+		status_err = viif_dev->status_err;
+		viif_dev->status_err = 0;
+
+		visconti_viif_capture_switch_buffer(&viif_dev->cap_dev0, status_err,
+						    l2_transfer_status, ts);
+		visconti_viif_capture_switch_buffer(&viif_dev->cap_dev1, status_err,
+						    l2_transfer_status, ts);
+	}
+
+	/* Delayed Vsync of SUB unit */
+	if (event_sub & MASK_SYNC_S_DELAY)
+		visconti_viif_capture_switch_buffer(&viif_dev->cap_dev2, 0, 0, ts);
+}
+
+#define MASK_M_GAMMATBL_TIMEOUT 0x0700U
+
+static void viif_status_err_irq_handler(struct viif_device *viif_dev)
+{
+	u32 event_main, event_sub, val, mask;
+
+	hwd_viif_status_err_irq_handler(viif_dev->ch, &event_main, &event_sub);
+
+	if (event_main) {
+		/* mask for gamma table time out error which will be unmasked in the next Vsync */
+		val = FIELD_GET(MASK_M_GAMMATBL_TIMEOUT, event_main);
+		if (val) {
+			viif_dev->masked_gamma_path |= val;
+			mask = MASK_M_DELAY_INT |
+			       FIELD_PREP(MASK_M_GAMMATBL_TIMEOUT, viif_dev->masked_gamma_path);
+			hwd_viif_main_status_err_set_irq_mask(viif_dev->ch, mask);
+		}
+
+		viif_dev->status_err = event_main;
+	}
+	viif_dev->reported_err_main |= event_main;
+	viif_dev->reported_err_sub |= event_sub;
+	dev_err(viif_dev->dev, "MAIN/SUB error 0x%x 0x%x.\n", event_main, event_sub);
+}
+
+static void viif_csi2rx_err_irq_handler(struct viif_device *viif_dev)
+{
+	u32 event;
+
+	event = hwd_viif_csi2rx_err_irq_handler(viif_dev->ch);
+	viif_dev->reported_err_csi2rx |= event;
+	dev_err(viif_dev->dev, "CSI2RX error 0x%x.\n", event);
+}
+
+static irqreturn_t visconti_viif_irq(int irq, void *dev_id)
+{
+	struct viif_device *viif_dev = dev_id;
+	int irq_type = irq - viif_dev->irq[0];
+
+	spin_lock(&viif_dev->lock);
+
+	switch (irq_type) {
+	case 0:
+		viif_vsync_irq_handler_w_isp(viif_dev);
+		break;
+	case 1:
+		viif_status_err_irq_handler(viif_dev);
+		break;
+	case 2:
+		viif_csi2rx_err_irq_handler(viif_dev);
+		break;
+	}
+
+	spin_unlock(&viif_dev->lock);
+
+	return IRQ_HANDLED;
+}
+
+/* ----- Async Notifier Operations----- */
+static int visconti_viif_notify_bound(struct v4l2_async_notifier *notifier,
+				      struct v4l2_subdev *v4l2_sd, struct v4l2_async_subdev *asd)
+{
+	struct v4l2_device *v4l2_dev = notifier->v4l2_dev;
+	struct viif_device *viif_dev = v4l2_to_viif(v4l2_dev);
+	struct viif_subdev *viif_sd = to_viif_subdev(asd);
+
+	viif_sd->v4l2_sd = v4l2_sd;
+	viif_dev->num_sd++;
+
+	return 0;
+}
+
+static void visconti_viif_create_links(struct viif_device *viif_dev)
+{
+	unsigned int source_pad;
+	int ret;
+
+	/* camera subdev pad0 -> isp suddev pad0 */
+	ret = media_entity_get_fwnode_pad(&viif_dev->sd->v4l2_sd->entity,
+					  viif_dev->sd->v4l2_sd->fwnode, MEDIA_PAD_FL_SOURCE);
+	if (ret < 0) {
+		dev_err(viif_dev->dev, "failed to find source pad\n");
+		return;
+	}
+	source_pad = ret;
+
+	ret = media_create_pad_link(&viif_dev->sd->v4l2_sd->entity, source_pad,
+				    &viif_dev->isp_subdev.sd.entity, VIIF_ISP_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret)
+		dev_err(viif_dev->dev, "failed create_pad_link (camera:src -> isp:sink)\n");
+
+	ret = media_create_pad_link(&viif_dev->isp_subdev.sd.entity, VIIF_ISP_PAD_SRC_PATH0,
+				    &viif_dev->cap_dev0.vdev.entity, VIIF_CAPTURE_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret)
+		dev_err(viif_dev->dev, "failed create_pad_link (isp:src -> capture0:sink)\n");
+
+	ret = media_create_pad_link(&viif_dev->isp_subdev.sd.entity, VIIF_ISP_PAD_SRC_PATH1,
+				    &viif_dev->cap_dev1.vdev.entity, VIIF_CAPTURE_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret)
+		dev_err(viif_dev->dev, "failed create_pad_link (isp:src -> capture1:sink)\n");
+
+	ret = media_create_pad_link(&viif_dev->isp_subdev.sd.entity, VIIF_ISP_PAD_SRC_PATH2,
+				    &viif_dev->cap_dev2.vdev.entity, VIIF_CAPTURE_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret)
+		dev_err(viif_dev->dev, "failed create_pad_link (isp:src -> capture2:sink)\n");
+}
+
+static void visconti_viif_notify_unbind(struct v4l2_async_notifier *notifier,
+					struct v4l2_subdev *subdev, struct v4l2_async_subdev *asd)
+{
+	struct v4l2_device *v4l2_dev = notifier->v4l2_dev;
+	struct viif_subdev *viif_sd = to_viif_subdev(asd);
+
+	v4l2_dev->ctrl_handler = NULL;
+	viif_sd->v4l2_sd = NULL;
+}
+
+static int visconti_viif_notify_complete(struct v4l2_async_notifier *notifier)
+{
+	struct v4l2_device *v4l2_dev = notifier->v4l2_dev;
+	struct viif_device *viif_dev = v4l2_to_viif(v4l2_dev);
+	int ret;
+
+	ret = v4l2_device_register_subdev_nodes(v4l2_dev);
+	if (ret < 0) {
+		dev_err(v4l2_dev->dev, "Failed to register subdev nodes\n");
+		return ret;
+	}
+
+	/* Make sure at least one sensor is primary and use it to initialize */
+	if (!viif_dev->sd) {
+		viif_dev->sd = &viif_dev->subdevs[0];
+		viif_dev->sd_index = 0;
+	}
+
+	/* TODO: might need to check if subdev's mbus code is valid for this driver */
+
+	ret = visconti_viif_capture_register_ctrl_handlers(viif_dev);
+	if (ret)
+		return ret;
+
+	visconti_viif_create_links(viif_dev);
+
+	return 0;
+}
+
+static const struct v4l2_async_notifier_operations viif_notify_ops = {
+	.bound = visconti_viif_notify_bound,
+	.unbind = visconti_viif_notify_unbind,
+	.complete = visconti_viif_notify_complete,
+};
+
+/* ----- Probe and Remove ----- */
+static int visconti_viif_init_async_subdevs(struct viif_device *viif_dev, unsigned int n_sd)
+{
+	/* Reserve memory for 'n_sd' viif_subdev descriptors. */
+	viif_dev->subdevs =
+		devm_kcalloc(viif_dev->dev, n_sd, sizeof(*viif_dev->subdevs), GFP_KERNEL);
+	if (!viif_dev->subdevs)
+		return -ENOMEM;
+
+	/* Reserve memory for 'n_sd' pointers to async_subdevices.
+	 * viif_dev->asds members will point to &viif_dev.asd
+	 */
+	viif_dev->asds = devm_kcalloc(viif_dev->dev, n_sd, sizeof(*viif_dev->asds), GFP_KERNEL);
+	if (!viif_dev->asds)
+		return -ENOMEM;
+
+	viif_dev->sd = NULL;
+	viif_dev->sd_index = 0;
+	viif_dev->num_sd = 0;
+
+	return 0;
+}
+
+static int visconti_viif_parse_dt(struct viif_device *viif_dev)
+{
+	struct device_node *of = viif_dev->dev->of_node;
+	struct v4l2_fwnode_endpoint fw_ep;
+	struct viif_subdev *viif_sd;
+	struct device_node *ep;
+	unsigned int i;
+	int num_ep;
+	int ret;
+
+	memset(&fw_ep, 0, sizeof(struct v4l2_fwnode_endpoint));
+
+	num_ep = of_graph_get_endpoint_count(of);
+	if (!num_ep)
+		return -ENODEV;
+
+	ret = visconti_viif_init_async_subdevs(viif_dev, num_ep);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num_ep; i++) {
+		ep = of_graph_get_endpoint_by_regs(of, 0, i);
+		if (!ep) {
+			dev_err(viif_dev->dev, "No subdevice connected on endpoint %u.\n", i);
+			ret = -ENODEV;
+			goto error_put_node;
+		}
+
+		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &fw_ep);
+		if (ret) {
+			dev_err(viif_dev->dev, "Unable to parse endpoint #%u.\n", i);
+			goto error_put_node;
+		}
+
+		if (fw_ep.bus_type != V4L2_MBUS_CSI2_DPHY ||
+		    fw_ep.bus.mipi_csi2.num_data_lanes == 0) {
+			dev_err(viif_dev->dev, "missing CSI-2 properties in endpoint\n");
+			ret = -EINVAL;
+			goto error_put_node;
+		}
+
+		/* Setup the ceu subdevice and the async subdevice. */
+		viif_sd = &viif_dev->subdevs[i];
+		INIT_LIST_HEAD(&viif_sd->asd.list);
+
+		viif_sd->mbus_flags = fw_ep.bus.mipi_csi2.flags;
+		viif_sd->num_lane = fw_ep.bus.mipi_csi2.num_data_lanes;
+		viif_sd->asd.match_type = V4L2_ASYNC_MATCH_FWNODE;
+		viif_sd->asd.match.fwnode =
+			fwnode_graph_get_remote_port_parent(of_fwnode_handle(ep));
+
+		viif_dev->asds[i] = &viif_sd->asd;
+		of_node_put(ep);
+	}
+
+	return num_ep;
+
+error_put_node:
+	of_node_put(ep);
+	return ret;
+}
+
+static const struct of_device_id visconti_viif_of_table[] = {
+	{
+		.compatible = "toshiba,visconti-viif",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, visconti_viif_of_table);
+
+#define NUM_IRQS       3
+#define IRQ_ID_STR     "viif"
+#define MEDIA_MODEL    "visconti_viif"
+#define MEDIA_BUS_INFO "platform:visconti_viif"
+
+static int visconti_viif_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id;
+	struct device *dev = &pdev->dev;
+	struct viif_device *viif_dev;
+	dma_addr_t table_paddr;
+	int ret, i, num_sd;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
+	if (ret)
+		return ret;
+
+	viif_dev = devm_kzalloc(dev, sizeof(*viif_dev), GFP_KERNEL);
+	if (!viif_dev)
+		return -ENOMEM;
+
+	viif_dev->is_powered = 0;
+
+	platform_set_drvdata(pdev, viif_dev);
+	viif_dev->dev = dev;
+
+	INIT_LIST_HEAD(&viif_dev->cap_dev0.capture);
+	INIT_LIST_HEAD(&viif_dev->cap_dev1.capture);
+	INIT_LIST_HEAD(&viif_dev->cap_dev2.capture);
+	spin_lock_init(&viif_dev->lock);
+	mutex_init(&viif_dev->mlock);
+
+	viif_dev->capture_reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(viif_dev->capture_reg))
+		return PTR_ERR(viif_dev->capture_reg);
+
+	viif_dev->csi2host_reg = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(viif_dev->csi2host_reg))
+		return PTR_ERR(viif_dev->csi2host_reg);
+
+	device_property_read_u32(dev, "index", &viif_dev->ch);
+
+	for (i = 0; i < NUM_IRQS; i++) {
+		ret = platform_get_irq(pdev, i);
+		if (ret < 0) {
+			dev_err(dev, "failed to acquire irq resource\n");
+			return ret;
+		}
+		viif_dev->irq[i] = ret;
+		ret = devm_request_irq(dev, viif_dev->irq[i], visconti_viif_irq, 0, IRQ_ID_STR,
+				       viif_dev);
+		if (ret) {
+			dev_err(dev, "irq request failed\n");
+			return ret;
+		}
+	}
+
+	viif_dev->table_vaddr =
+		dma_alloc_wc(dev, sizeof(struct viif_table_area), &table_paddr, GFP_KERNEL);
+	if (!viif_dev->table_vaddr) {
+		dev_err(dev, "dma_alloc_wc failed\n");
+		return -ENOMEM;
+	}
+	viif_dev->table_paddr = (struct viif_table_area *)table_paddr;
+
+	/* build media_dev */
+	viif_dev->media_dev.hw_revision = 0;
+	strscpy(viif_dev->media_dev.model, MEDIA_MODEL, sizeof(viif_dev->media_dev.model));
+	viif_dev->media_dev.dev = dev;
+	strscpy(viif_dev->media_dev.bus_info, MEDIA_BUS_INFO, sizeof(viif_dev->media_dev.bus_info));
+	media_device_init(&viif_dev->media_dev);
+
+	/* build v4l2_dev */
+	viif_dev->v4l2_dev.mdev = &viif_dev->media_dev;
+	ret = v4l2_device_register(dev, &viif_dev->v4l2_dev);
+	if (ret)
+		goto error_dma_free;
+
+	ret = media_device_register(&viif_dev->media_dev);
+	if (ret) {
+		dev_err(dev, "Failed to register media device: %d\n", ret);
+		goto error_v4l2_unregister;
+	}
+
+	ret = visconti_viif_isp_register(viif_dev);
+	if (ret) {
+		dev_err(dev, "failed to register isp sub node: %d\n", ret);
+		goto error_media_unregister;
+	}
+	ret = visconti_viif_capture_register(viif_dev);
+	if (ret) {
+		dev_err(dev, "failed to register capture node: %d\n", ret);
+		goto error_media_unregister;
+	}
+
+	/* check device type */
+	of_id = of_match_device(visconti_viif_of_table, dev);
+
+	num_sd = visconti_viif_parse_dt(viif_dev);
+	if (ret < 0) {
+		ret = num_sd;
+		goto error_media_unregister;
+	}
+
+	viif_dev->notifier.v4l2_dev = &viif_dev->v4l2_dev;
+	v4l2_async_nf_init(&viif_dev->notifier);
+	for (i = 0; i < num_sd; i++)
+		__v4l2_async_nf_add_subdev(&viif_dev->notifier, viif_dev->asds[i]);
+	viif_dev->notifier.ops = &viif_notify_ops;
+	ret = v4l2_async_nf_register(&viif_dev->v4l2_dev, &viif_dev->notifier);
+	if (ret)
+		goto error_media_unregister;
+
+	return 0;
+
+error_media_unregister:
+	media_device_unregister(&viif_dev->media_dev);
+error_v4l2_unregister:
+	v4l2_device_unregister(&viif_dev->v4l2_dev);
+error_dma_free:
+	dma_free_wc(&pdev->dev, sizeof(struct viif_table_area), viif_dev->table_vaddr,
+		    (dma_addr_t)viif_dev->table_paddr);
+	return ret;
+}
+
+static int visconti_viif_remove(struct platform_device *pdev)
+{
+	struct viif_device *viif_dev = platform_get_drvdata(pdev);
+
+	visconti_viif_isp_unregister(viif_dev);
+	visconti_viif_capture_unregister(viif_dev);
+	v4l2_async_nf_unregister(&viif_dev->notifier);
+	media_device_unregister(&viif_dev->media_dev);
+	v4l2_device_unregister(&viif_dev->v4l2_dev);
+	dma_free_wc(&pdev->dev, sizeof(struct viif_table_area), viif_dev->table_vaddr,
+		    (dma_addr_t)viif_dev->table_paddr);
+
+	return 0;
+}
+
+static struct platform_driver visconti_viif_driver = {
+	.probe = visconti_viif_probe,
+	.remove = visconti_viif_remove,
+	.driver = {
+			.name = "visconti_viif",
+			.of_match_table = visconti_viif_of_table,
+		},
+};
+
+module_platform_driver(visconti_viif_driver);
+
+MODULE_AUTHOR("Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>");
+MODULE_DESCRIPTION("Toshiba Visconti Video Input driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/media/platform/visconti/viif.h b/drivers/media/platform/visconti/viif.h
new file mode 100644
index 000000000..0d9f017bd
--- /dev/null
+++ b/drivers/media/platform/visconti/viif.h
@@ -0,0 +1,195 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef VIIF_H
+#define VIIF_H
+
+#include <linux/visconti_viif.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mediabus.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/videobuf2-dma-contig.h>
+
+#include "hwd_viif.h"
+
+#define VIIF_ISP_REGBUF_0 0
+#define VIIF_L2ISP_POST_0 0
+#define VIIF_L2ISP_POST_1 1
+
+#define VIIF_CAPTURE_PAD_SINK  0
+#define VIIF_ISP_PAD_SINK      0
+#define VIIF_ISP_PAD_SRC_PATH0 1
+#define VIIF_ISP_PAD_SRC_PATH1 2
+#define VIIF_ISP_PAD_SRC_PATH2 3
+#define VIIF_ISP_PAD_NUM 4
+
+#define CAPTURE_PATH_MAIN_POST0 0
+#define CAPTURE_PATH_MAIN_POST1 1
+#define CAPTURE_PATH_SUB	2
+
+#define VIIF_DPC_TABLE_BYTES 8192
+#define VIIF_LSC_TABLE_BYTES 1536
+#define VIIF_UNDIST_TABLE_BYTES 8192
+#define VIIF_L2_GAMMA_TABLE_BYTES 512
+
+#define VIIF_HW_AVAILABLE_IRQS 4
+
+struct viif_fmt {
+	u32 fourcc;
+	u8 bpp[3];
+	u8 num_planes;
+	u32 colorspace;
+	u32 pitch_align;
+};
+
+struct viif_subdev {
+	struct v4l2_subdev *v4l2_sd;
+	struct v4l2_async_subdev asd;
+
+	/* per-subdevice mbus configuration options */
+	unsigned int mbus_flags;
+	unsigned int mbus_code;
+	unsigned int num_lane;
+};
+
+struct viif_table_area {
+	/* viif_l1_dpc_config */
+	u32 dpc_table_h[VIIF_DPC_TABLE_BYTES / sizeof(u32)];
+	u32 dpc_table_m[VIIF_DPC_TABLE_BYTES / sizeof(u32)];
+	u32 dpc_table_l[VIIF_DPC_TABLE_BYTES / sizeof(u32)];
+	/* viif_l1_lsc_config */
+	u16 lsc_table_gr[VIIF_LSC_TABLE_BYTES / sizeof(u16)];
+	u16 lsc_table_r[VIIF_LSC_TABLE_BYTES / sizeof(u16)];
+	u16 lsc_table_b[VIIF_LSC_TABLE_BYTES / sizeof(u16)];
+	u16 lsc_table_gb[VIIF_LSC_TABLE_BYTES / sizeof(u16)];
+	/* viif_l2_undist_config */
+	u32 undist_write_g[VIIF_UNDIST_TABLE_BYTES / sizeof(u32)];
+	u32 undist_read_b[VIIF_UNDIST_TABLE_BYTES / sizeof(u32)];
+	u32 undist_read_g[VIIF_UNDIST_TABLE_BYTES / sizeof(u32)];
+	u32 undist_read_r[VIIF_UNDIST_TABLE_BYTES / sizeof(u32)];
+	/* viif_l2_gamma_config */
+	u16 l2_gamma_table[2][6][VIIF_L2_GAMMA_TABLE_BYTES / sizeof(u16)];
+};
+
+/* capture device node information */
+struct cap_dev {
+	u32 pathid; /* 0 ... MAIN POST0, 1 ... MAIN POST1, 2 ... SUB */
+	struct video_device vdev;
+	struct media_pad capture_pad;
+	struct v4l2_ctrl_handler ctrl_handler;
+
+	/* vb2 queue, capture buffer list and active buffer pointer */
+	struct vb2_queue vb2_vq;
+	struct list_head capture;
+	struct vb2_v4l2_buffer *active;
+	struct vb2_v4l2_buffer *dma_active;
+	struct vb2_v4l2_buffer *last_active;
+	int buf_cnt;
+	unsigned int sequence;
+
+	/* currently configured field and pixel format */
+	enum v4l2_field field;
+	struct v4l2_pix_format_mplane v4l2_pix;
+	unsigned int out_format;
+	struct hwd_viif_img_area img_area;
+	struct hwd_viif_out_process out_process;
+
+	struct viif_device *viif_dev;
+};
+
+struct isp_subdev {
+	struct v4l2_subdev sd;
+	struct media_pad pads[VIIF_ISP_PAD_NUM];
+	struct v4l2_subdev_pad_config pad_cfg[VIIF_ISP_PAD_NUM];
+	struct mutex ops_lock; /* serialize V4L2 API */
+	struct viif_device *viif_dev;
+	struct v4l2_ctrl_handler ctrl_handler;
+};
+
+struct viif_device {
+	struct device *dev;
+	struct v4l2_device v4l2_dev;
+	struct media_device media_dev;
+	struct media_pipeline pipe;
+	unsigned int ch;
+	u32 masked_gamma_path;
+	struct hwd_viif_func *func;
+
+	struct viif_subdev *subdevs;
+	struct v4l2_async_subdev **asds;
+	/* async subdev notification helpers */
+	struct v4l2_async_notifier notifier;
+
+	/* the subdevice currently in use */
+	struct viif_subdev *sd;
+	unsigned int sd_index;
+	unsigned int num_sd;
+
+	/* sub device node information */
+	struct cap_dev cap_dev0;
+	struct cap_dev cap_dev1;
+	struct cap_dev cap_dev2;
+	struct isp_subdev isp_subdev;
+
+	/* lock - lock access to capture buffer queue and active buffer */
+	spinlock_t lock;
+
+	/* mlock - lock access to vb2_queue and video_device intance */
+	struct mutex mlock;
+
+	void __iomem *capture_reg;
+	void __iomem *csi2host_reg;
+	unsigned int irq[VIIF_HW_AVAILABLE_IRQS];
+
+	/* Un-cache table area */
+	struct viif_table_area *table_vaddr;
+	struct viif_table_area *table_paddr;
+
+	/* Rawpack mode */
+	u32 rawpack_mode;
+
+	/* Error flag checked at delayed vsync handler  */
+	u32 status_err;
+
+	/* Error flag checked at compound control GET_REPORTED_ERRORS  */
+	u32 reported_err_main;
+	u32 reported_err_sub;
+	u32 reported_err_csi2rx;
+
+	/* Lifecycle: at least one fd for cap_dev is opened */
+	int is_powered;
+};
+
+/* viif.c */
+void visconti_viif_hw_on(struct viif_device *viif_dev);
+void visconti_viif_hw_off(struct viif_device *viif_dev);
+
+/* viif_capture.c */
+int visconti_viif_capture_register(struct viif_device *viif_dev);
+void visconti_viif_capture_unregister(struct viif_device *viif_dev);
+int visconti_viif_capture_register_ctrl_handlers(struct viif_device *viif_dev);
+void visconti_viif_capture_switch_buffer(struct cap_dev *cap_dev, u32 status_err,
+					 u32 l2_transfer_status, u64 timestamp);
+
+/* viif_isp.c */
+int visconti_viif_isp_register(struct viif_device *viif_dev);
+void visconti_viif_isp_unregister(struct viif_device *viif_dev);
+int visconti_viif_isp_main_set_unit(struct viif_device *viif_dev);
+int visconti_viif_isp_sub_set_unit(struct viif_device *viif_dev);
+void visconti_viif_isp_set_compose_rect(struct viif_device *viif_dev,
+					struct viif_l2_roi_config *roi);
+
+/* viif_controls.c */
+int visconti_viif_isp_init_controls(struct viif_device *viif_dev);
+
+#endif /* VIIF_H */
diff --git a/drivers/media/platform/visconti/viif_capture.c b/drivers/media/platform/visconti/viif_capture.c
new file mode 100644
index 000000000..aa04e95a8
--- /dev/null
+++ b/drivers/media/platform/visconti/viif_capture.c
@@ -0,0 +1,1215 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-subdev.h>
+
+#include "viif.h"
+
+#define VIIF_CROP_MAX_X_ISP (8062U)
+#define VIIF_CROP_MAX_Y_ISP (3966U)
+#define VIIF_CROP_MIN_W	    (128U)
+#define VIIF_CROP_MAX_W_ISP (8190U)
+#define VIIF_CROP_MIN_H	    (128U)
+#define VIIF_CROP_MAX_H_ISP (4094U)
+
+struct viif_buffer {
+	struct vb2_v4l2_buffer vb;
+	struct list_head queue;
+};
+
+static inline struct viif_buffer *vb2_to_viif(struct vb2_v4l2_buffer *vbuf)
+{
+	return container_of(vbuf, struct viif_buffer, vb);
+}
+
+static inline struct cap_dev *video_drvdata_to_capdev(struct file *file)
+{
+	return (struct cap_dev *)video_drvdata(file);
+}
+
+static inline struct cap_dev *vb2queue_to_capdev(struct vb2_queue *vq)
+{
+	return (struct cap_dev *)vb2_get_drv_priv(vq);
+}
+
+/* ----- ISRs and VB2 Operations ----- */
+static int viif_set_img(struct cap_dev *cap_dev, struct vb2_buffer *vb)
+{
+	struct v4l2_pix_format_mplane *pix = &cap_dev->v4l2_pix;
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct hwd_viif_img next_out_img;
+	dma_addr_t phys_addr;
+	int i, ret = 0;
+
+	next_out_img.width = pix->width;
+	next_out_img.height = pix->height;
+	next_out_img.format = cap_dev->out_format;
+
+	for (i = 0; i < pix->num_planes; i++) {
+		next_out_img.pixelmap[i].pitch = pix->plane_fmt[i].bytesperline;
+		phys_addr = vb2_dma_contig_plane_dma_addr(vb, i);
+
+		/*
+		 * TODO: add address mapping here if IOMMU driver get available
+		 * address mapping:
+		 * - DDR0: (CPU)0x0_8000_0000-0x0_FFFF_FFFF -> (HW)0x8000_0000-0xFFFF_FFFF
+		 * - DDR1: (CPU)0x8_8000_0000-0x8_FFFF_FFFF -> (HW)0x0000_0000-0x7FFF_FFFF
+		 */
+		next_out_img.pixelmap[i].pmap_paddr = phys_addr;
+	}
+
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		hwd_viif_isp_guard_start(viif_dev->ch);
+		ret = hwd_viif_l2_set_img_transmission(viif_dev->ch, VIIF_L2ISP_POST_0,
+						       HWD_VIIF_ENABLE, &cap_dev->img_area,
+						       &cap_dev->out_process, &next_out_img);
+		hwd_viif_isp_guard_end(viif_dev->ch);
+		if (ret)
+			dev_err(viif_dev->dev, "set img error. %d\n", ret);
+	} else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1) {
+		hwd_viif_isp_guard_start(viif_dev->ch);
+		ret = hwd_viif_l2_set_img_transmission(viif_dev->ch, VIIF_L2ISP_POST_1,
+						       HWD_VIIF_ENABLE, &cap_dev->img_area,
+						       &cap_dev->out_process, &next_out_img);
+		hwd_viif_isp_guard_end(viif_dev->ch);
+		if (ret)
+			dev_err(viif_dev->dev, "set img error. %d\n", ret);
+	} else if (cap_dev->pathid == CAPTURE_PATH_SUB) {
+		hwd_viif_isp_guard_start(viif_dev->ch);
+		ret = hwd_viif_sub_set_img_transmission(viif_dev->ch, &next_out_img);
+		hwd_viif_isp_guard_end(viif_dev->ch);
+		if (ret)
+			dev_err(viif_dev->dev, "set img error. %d\n", ret);
+	}
+
+	return ret;
+}
+
+void visconti_viif_capture_switch_buffer(struct cap_dev *cap_dev, u32 status_err,
+					 u32 l2_transfer_status, u64 timestamp)
+{
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct vb2_v4l2_buffer *vbuf;
+	enum vb2_buffer_state state;
+	struct viif_buffer *buf;
+
+	vbuf = cap_dev->dma_active;
+	if (!vbuf)
+		goto next;
+
+	cap_dev->buf_cnt--;
+	vbuf->vb2_buf.timestamp = timestamp;
+	vbuf->sequence = cap_dev->sequence++;
+	vbuf->field = cap_dev->field;
+	if (status_err || l2_transfer_status)
+		state = VB2_BUF_STATE_ERROR;
+	else
+		state = VB2_BUF_STATE_DONE;
+
+	vb2_buffer_done(&vbuf->vb2_buf, state);
+	cap_dev->dma_active = NULL;
+
+next:
+	vbuf = cap_dev->active;
+	if (!vbuf)
+		return;
+
+	if (cap_dev->last_active) {
+		cap_dev->dma_active = cap_dev->last_active;
+		cap_dev->last_active = NULL;
+	} else if (!cap_dev->dma_active) {
+		cap_dev->dma_active = vbuf;
+		buf = vb2_to_viif(vbuf);
+		list_del_init(&buf->queue);
+	}
+
+	if (!list_empty(&cap_dev->capture)) {
+		buf = list_entry(cap_dev->capture.next, struct viif_buffer, queue);
+		cap_dev->active = &buf->vb;
+		viif_set_img(cap_dev, &buf->vb.vb2_buf);
+	} else {
+		dev_dbg(viif_dev->dev, "no queue\n");
+		cap_dev->last_active = cap_dev->dma_active;
+		cap_dev->dma_active = NULL;
+		cap_dev->active = NULL;
+	}
+}
+
+/* --- Capture buffer control --- */
+static int viif_vb2_setup(struct vb2_queue *vq, unsigned int *count, unsigned int *num_planes,
+			  unsigned int sizes[], struct device *alloc_devs[])
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vq);
+	struct v4l2_pix_format_mplane *pix = &cap_dev->v4l2_pix;
+	unsigned int i;
+
+	/* num_planes is set: just check plane sizes. */
+	if (*num_planes) {
+		for (i = 0; i < pix->num_planes; i++)
+			if (sizes[i] < pix->plane_fmt[i].sizeimage)
+				return -EINVAL;
+
+		return 0;
+	}
+
+	/* num_planes not set: called from REQBUFS, just set plane sizes. */
+	*num_planes = pix->num_planes;
+	for (i = 0; i < pix->num_planes; i++)
+		sizes[i] = pix->plane_fmt[i].sizeimage;
+
+	cap_dev->buf_cnt = 0;
+
+	return 0;
+}
+
+static void viif_vb2_queue(struct vb2_buffer *vb)
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct viif_buffer *buf = vb2_to_viif(vbuf);
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	list_add_tail(&buf->queue, &cap_dev->capture);
+	cap_dev->buf_cnt++;
+
+	if (!cap_dev->active) {
+		cap_dev->active = vbuf;
+		if (!cap_dev->last_active)
+			viif_set_img(cap_dev, vb);
+	}
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+}
+
+static int viif_vb2_prepare(struct vb2_buffer *vb)
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vb->vb2_queue);
+	struct v4l2_pix_format_mplane *pix = &cap_dev->v4l2_pix;
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	unsigned int i;
+
+	for (i = 0; i < pix->num_planes; i++) {
+		if (vb2_plane_size(vb, i) < pix->plane_fmt[i].sizeimage) {
+			dev_err(viif_dev->dev, "Plane size too small (%lu < %u)\n",
+				vb2_plane_size(vb, i), pix->plane_fmt[i].sizeimage);
+			return -EINVAL;
+		}
+
+		vb2_set_plane_payload(vb, i, pix->plane_fmt[i].sizeimage);
+	}
+	return 0;
+}
+
+static int viif_start_streaming(struct vb2_queue *vq, unsigned int count)
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vq);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+
+	/* note that pipe is shared among paths; see pipe.streaming_count member variable */
+	ret = media_pipeline_start(&cap_dev->vdev.entity, &viif_dev->pipe);
+	if (ret)
+		dev_err(viif_dev->dev, "start pipeline failed %d\n", ret);
+
+	if (cap_dev->pathid == 0) {
+		/* CSI2RX start */
+		ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, video, s_stream, 1);
+		if (ret) {
+			dev_err(viif_dev->dev, "Start isp subdevice stream failed. %d\n", ret);
+			spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+			return ret;
+		}
+	}
+
+	/* buffer control */
+	cap_dev->sequence = 0;
+
+	/* finish critical section: some sensor driver (including imx219) calls schedule() */
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	/* Camera (CSI2 source) start streaming */
+	if (cap_dev->pathid == 0) {
+		ret = v4l2_subdev_call(viif_sd->v4l2_sd, video, s_stream, 1);
+		if (ret) {
+			dev_err(viif_dev->dev, "Start subdev stream failed. %d\n", ret);
+			(void)v4l2_subdev_call(&viif_dev->isp_subdev.sd, video, s_stream, 0);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void viif_stop_streaming(struct vb2_queue *vq)
+{
+	struct cap_dev *cap_dev = vb2queue_to_capdev(vq);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct viif_buffer *buf;
+	unsigned long irqflags;
+	int ret;
+
+	if (cap_dev->pathid == 0) {
+		ret = v4l2_subdev_call(viif_sd->v4l2_sd, video, s_stream, 0);
+		if (ret)
+			dev_err(viif_dev->dev, "Stop subdev stream failed. %d\n", ret);
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+
+	if (cap_dev->pathid == 0) {
+		ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, video, s_stream, 0);
+		if (ret)
+			dev_err(viif_dev->dev, "Stop isp subdevice stream failed %d\n", ret);
+	}
+
+	/* buffer control */
+	cap_dev->active = NULL;
+	if (cap_dev->dma_active) {
+		vb2_buffer_done(&cap_dev->dma_active->vb2_buf, VB2_BUF_STATE_ERROR);
+		cap_dev->buf_cnt--;
+		cap_dev->dma_active = NULL;
+	}
+	if (cap_dev->last_active) {
+		vb2_buffer_done(&cap_dev->last_active->vb2_buf, VB2_BUF_STATE_ERROR);
+		cap_dev->buf_cnt--;
+		cap_dev->last_active = NULL;
+	}
+
+	/* Release all queued buffers. */
+	list_for_each_entry(buf, &cap_dev->capture, queue) {
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+		cap_dev->buf_cnt--;
+	}
+	INIT_LIST_HEAD(&cap_dev->capture);
+	if (cap_dev->buf_cnt)
+		dev_err(viif_dev->dev, "Buffer count error %d\n", cap_dev->buf_cnt);
+
+	media_pipeline_stop(&cap_dev->vdev.entity);
+
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+}
+
+static const struct vb2_ops viif_vb2_ops = {
+	.queue_setup = viif_vb2_setup,
+	.buf_queue = viif_vb2_queue,
+	.buf_prepare = viif_vb2_prepare,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish,
+	.start_streaming = viif_start_streaming,
+	.stop_streaming = viif_stop_streaming,
+};
+
+/* --- VIIF hardware settings --- */
+/* L2ISP output csc setting for YUV to RGB(ITU-R BT.709) */
+static const struct hwd_viif_csc_param viif_csc_yuv2rgb = {
+	.r_cr_in_offset = 0x18000,
+	.g_y_in_offset = 0x1f000,
+	.b_cb_in_offset = 0x18000,
+	.coef = {
+			[0] = 0x1000,
+			[1] = 0xfd12,
+			[2] = 0xf8ad,
+			[3] = 0x1000,
+			[4] = 0x1d07,
+			[5] = 0x0000,
+			[6] = 0x1000,
+			[7] = 0x0000,
+			[8] = 0x18a2,
+		},
+	.r_cr_out_offset = 0x1000,
+	.g_y_out_offset = 0x1000,
+	.b_cb_out_offset = 0x1000,
+};
+
+/* L2ISP output csc setting for RGB to YUV(ITU-R BT.709) */
+static const struct hwd_viif_csc_param viif_csc_rgb2yuv = {
+	.r_cr_in_offset = 0x1f000,
+	.g_y_in_offset = 0x1f000,
+	.b_cb_in_offset = 0x1f000,
+	.coef = {
+			[0] = 0x0b71,
+			[1] = 0x0128,
+			[2] = 0x0367,
+			[3] = 0xf9b1,
+			[4] = 0x082f,
+			[5] = 0xfe20,
+			[6] = 0xf891,
+			[7] = 0xff40,
+			[8] = 0x082f,
+		},
+	.r_cr_out_offset = 0x8000,
+	.g_y_out_offset = 0x1000,
+	.b_cb_out_offset = 0x8000,
+};
+
+static int viif_l2_set_format(struct cap_dev *cap_dev)
+{
+	struct v4l2_pix_format_mplane *pix = &cap_dev->v4l2_pix;
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	const struct hwd_viif_csc_param *csc_param = NULL;
+	struct v4l2_subdev_selection sel = {
+		.target = V4L2_SEL_TGT_CROP,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	struct v4l2_subdev_format fmt = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	bool inp_is_rgb = false;
+	bool out_is_rgb = false;
+	u32 postid;
+	int ret;
+
+	/* check path id */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		sel.pad = VIIF_ISP_PAD_SRC_PATH0;
+		fmt.pad = VIIF_ISP_PAD_SRC_PATH0;
+		postid = VIIF_L2ISP_POST_0;
+	} else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1) {
+		sel.pad = VIIF_ISP_PAD_SRC_PATH1;
+		fmt.pad = VIIF_ISP_PAD_SRC_PATH1;
+		postid = VIIF_L2ISP_POST_1;
+	} else {
+		return -EINVAL;
+	}
+
+	cap_dev->out_process.half_scale = HWD_VIIF_DISABLE;
+	cap_dev->out_process.select_color = HWD_VIIF_COLOR_YUV_RGB;
+	cap_dev->out_process.alpha = 0;
+
+	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_selection, NULL, &sel);
+	if (ret) {
+		cap_dev->img_area.x = 0;
+		cap_dev->img_area.y = 0;
+		cap_dev->img_area.w = pix->width;
+		cap_dev->img_area.h = pix->height;
+	} else {
+		cap_dev->img_area.x = sel.r.left;
+		cap_dev->img_area.y = sel.r.top;
+		cap_dev->img_area.w = sel.r.width;
+		cap_dev->img_area.h = sel.r.height;
+	}
+
+	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_fmt, NULL, &fmt);
+	if (!ret)
+		inp_is_rgb = (fmt.format.code == MEDIA_BUS_FMT_RGB888_1X24);
+
+	switch (pix->pixelformat) {
+	case V4L2_PIX_FMT_RGB24:
+		cap_dev->out_format = HWD_VIIF_RGB888_PACKED;
+		out_is_rgb = true;
+		break;
+	case V4L2_PIX_FMT_ABGR32:
+		cap_dev->out_format = HWD_VIIF_ARGB8888_PACKED;
+		cap_dev->out_process.alpha = 0xff;
+		out_is_rgb = true;
+		break;
+	case V4L2_PIX_FMT_YUV422M:
+		cap_dev->out_format = HWD_VIIF_YCBCR422_8_PLANAR;
+		break;
+	case V4L2_PIX_FMT_YUV444M:
+		cap_dev->out_format = HWD_VIIF_RGB888_YCBCR444_8_PLANAR;
+		break;
+	case V4L2_PIX_FMT_Y16:
+		cap_dev->out_format = HWD_VIIF_ONE_COLOR_16;
+		cap_dev->out_process.select_color = HWD_VIIF_COLOR_Y_G;
+		break;
+	}
+
+	if (!inp_is_rgb && out_is_rgb)
+		csc_param = &viif_csc_yuv2rgb; /* YUV -> RGB */
+	else if (inp_is_rgb && !out_is_rgb)
+		csc_param = &viif_csc_rgb2yuv; /* RGB -> YUV */
+
+	return hwd_viif_l2_set_output_csc(viif_dev->ch, postid, csc_param);
+}
+
+/* --- IOCTL Operations --- */
+static const struct viif_fmt viif_fmt_list[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_RGB24,
+		.bpp = { 24, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 384,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_ABGR32,
+		.bpp = { 32, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 512,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_YUV422M,
+		.bpp = { 8, 4, 4 },
+		.num_planes = 3,
+		.colorspace = V4L2_COLORSPACE_REC709,
+		.pitch_align = 128,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_YUV444M,
+		.bpp = { 8, 8, 8 },
+		.num_planes = 3,
+		.colorspace = V4L2_COLORSPACE_REC709,
+		.pitch_align = 128,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_Y16,
+		.bpp = { 16, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_REC709,
+		.pitch_align = 128,
+	},
+};
+
+static const struct viif_fmt viif_rawfmt_list[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_SRGGB10,
+		.bpp = { 16, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 256,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_SRGGB12,
+		.bpp = { 16, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 256,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_SRGGB14,
+		.bpp = { 16, 0, 0 },
+		.num_planes = 1,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.pitch_align = 256,
+	},
+};
+
+static const struct viif_fmt *get_viif_fmt_from_fourcc(unsigned int fourcc)
+{
+	const struct viif_fmt *fmt = &viif_fmt_list[0];
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(viif_fmt_list); i++, fmt++)
+		if (fmt->fourcc == fourcc)
+			return fmt;
+
+	return NULL;
+}
+
+static void viif_update_plane_sizes(struct v4l2_plane_pix_format *plane, unsigned int bpl,
+				    unsigned int szimage)
+{
+	memset(plane, 0, sizeof(*plane));
+
+	plane->sizeimage = szimage;
+	plane->bytesperline = bpl;
+}
+
+static void viif_calc_plane_sizes(const struct viif_fmt *viif_fmt,
+				  struct v4l2_pix_format_mplane *pix)
+{
+	unsigned int i, bpl, szimage;
+
+	for (i = 0; i < viif_fmt->num_planes; i++) {
+		bpl = pix->width * viif_fmt->bpp[i] / 8;
+		/* round up ptch */
+		bpl = (bpl + (viif_fmt->pitch_align - 1)) / viif_fmt->pitch_align;
+		bpl *= viif_fmt->pitch_align;
+		szimage = pix->height * bpl;
+		viif_update_plane_sizes(&pix->plane_fmt[i], bpl, szimage);
+	}
+	pix->num_planes = viif_fmt->num_planes;
+}
+
+static int viif_querycap(struct file *file, void *priv, struct v4l2_capability *cap)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+
+	strscpy(cap->card, "Toshiba VIIF", sizeof(cap->card));
+	strscpy(cap->driver, "viif", sizeof(cap->driver));
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:toshiba-viif-%s",
+		 dev_name(viif_dev->dev));
+	return 0;
+}
+
+static int viif_enum_rawfmt(struct cap_dev *cap_dev, struct v4l2_fmtdesc *f)
+{
+	if (f->index >= ARRAY_SIZE(viif_rawfmt_list))
+		return -EINVAL;
+
+	f->pixelformat = viif_rawfmt_list[f->index].fourcc;
+
+	return 0;
+}
+
+static int viif_enum_fmt_vid_cap(struct file *file, void *priv, struct v4l2_fmtdesc *f)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	const struct viif_fmt *fmt;
+
+	if (cap_dev->pathid == 2)
+		return viif_enum_rawfmt(cap_dev, f);
+
+	if (f->index >= ARRAY_SIZE(viif_fmt_list))
+		return -EINVAL;
+
+	fmt = &viif_fmt_list[f->index];
+	f->pixelformat = fmt->fourcc;
+
+	return 0;
+}
+
+/* size of minimum/maximum output image */
+#define VIIF_MIN_OUTPUT_IMG_WIDTH     (128U)
+#define VIIF_MAX_OUTPUT_IMG_WIDTH_ISP (5760U)
+#define VIIF_MAX_OUTPUT_IMG_WIDTH_SUB (4096U)
+
+#define VIIF_MIN_OUTPUT_IMG_HEIGHT     (128U)
+#define VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP (3240U)
+#define VIIF_MAX_OUTPUT_IMG_HEIGHT_SUB (2160U)
+
+static int viif_try_fmt(struct cap_dev *cap_dev, struct v4l2_format *v4l2_fmt)
+{
+	struct v4l2_pix_format_mplane *pix = &v4l2_fmt->fmt.pix_mp;
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	const struct viif_fmt *viif_fmt;
+	int ret;
+
+	/* check path id */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0)
+		format.pad = VIIF_ISP_PAD_SRC_PATH0;
+	else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1)
+		format.pad = VIIF_ISP_PAD_SRC_PATH1;
+	else
+		format.pad = VIIF_ISP_PAD_SRC_PATH2;
+
+	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_fmt, NULL, &format);
+	if (ret)
+		return -EINVAL;
+
+	/* fourcc check */
+	if (cap_dev->pathid == CAPTURE_PATH_SUB) {
+		switch (format.format.code) {
+		case MEDIA_BUS_FMT_SRGGB10_1X10:
+		case MEDIA_BUS_FMT_SGRBG10_1X10:
+		case MEDIA_BUS_FMT_SGBRG10_1X10:
+		case MEDIA_BUS_FMT_SBGGR10_1X10:
+			viif_fmt = &viif_rawfmt_list[0]; /*V4L2_PIX_FMT_SRGGB10*/
+			pix->pixelformat = viif_fmt->fourcc;
+			break;
+		case MEDIA_BUS_FMT_SRGGB12_1X12:
+		case MEDIA_BUS_FMT_SGRBG12_1X12:
+		case MEDIA_BUS_FMT_SGBRG12_1X12:
+		case MEDIA_BUS_FMT_SBGGR12_1X12:
+			viif_fmt = &viif_rawfmt_list[1]; /*V4L2_PIX_FMT_SRGGB12*/
+			pix->pixelformat = viif_fmt->fourcc;
+			break;
+		case MEDIA_BUS_FMT_SRGGB14_1X14:
+		case MEDIA_BUS_FMT_SGRBG14_1X14:
+		case MEDIA_BUS_FMT_SGBRG14_1X14:
+		case MEDIA_BUS_FMT_SBGGR14_1X14:
+			viif_fmt = &viif_rawfmt_list[2]; /*V4L2_PIX_FMT_SRGGB14*/
+			pix->pixelformat = viif_fmt->fourcc;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		viif_fmt = get_viif_fmt_from_fourcc(pix->pixelformat);
+		if (!viif_fmt)
+			return -EINVAL;
+	}
+
+	/* min/max width, height check */
+	if (pix->width < VIIF_MIN_OUTPUT_IMG_WIDTH)
+		pix->width = VIIF_MIN_OUTPUT_IMG_WIDTH;
+
+	if (pix->width > VIIF_MAX_OUTPUT_IMG_WIDTH_ISP)
+		pix->width = VIIF_MAX_OUTPUT_IMG_WIDTH_ISP;
+
+	if (pix->height < VIIF_MIN_OUTPUT_IMG_HEIGHT)
+		pix->height = VIIF_MIN_OUTPUT_IMG_HEIGHT;
+
+	if (pix->height > VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP)
+		pix->height = VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP;
+
+	/* consistency with isp::pad::src::fmt */
+	if (pix->width != format.format.width)
+		return -EINVAL;
+	if (pix->height != format.format.height)
+		return -EINVAL;
+
+	/* update derived parameters, such as bpp */
+	viif_calc_plane_sizes(viif_fmt, pix);
+
+	return 0;
+}
+
+static int viif_try_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+
+	return viif_try_fmt(cap_dev, f);
+}
+
+static int viif_s_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	int ret = 0;
+
+	if (vb2_is_streaming(&cap_dev->vb2_vq))
+		return -EBUSY;
+
+	if (f->type != cap_dev->vb2_vq.type)
+		return -EINVAL;
+
+	ret = viif_try_fmt(cap_dev, f);
+	if (ret)
+		return ret;
+
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0) {
+		/* TODO: this function should be called from viif_isp_s_stream()?? */
+		ret = visconti_viif_isp_main_set_unit(viif_dev);
+		if (ret)
+			return ret;
+	}
+
+	cap_dev->v4l2_pix = f->fmt.pix_mp;
+	cap_dev->field = V4L2_FIELD_NONE;
+
+	if (cap_dev->pathid == CAPTURE_PATH_SUB) {
+		cap_dev->out_format = HWD_VIIF_ONE_COLOR_16;
+		ret = visconti_viif_isp_sub_set_unit(viif_dev);
+	} else {
+		ret = viif_l2_set_format(cap_dev);
+	}
+
+	return ret;
+}
+
+static int viif_g_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+
+	f->fmt.pix_mp = cap_dev->v4l2_pix;
+
+	return 0;
+}
+
+static int viif_enum_input(struct file *file, void *priv, struct v4l2_input *inp)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd;
+	struct v4l2_subdev *v4l2_sd;
+	int ret;
+
+	if (inp->index >= viif_dev->num_sd)
+		return -EINVAL;
+
+	viif_sd = &viif_dev->subdevs[inp->index];
+	v4l2_sd = viif_sd->v4l2_sd;
+
+	ret = v4l2_subdev_call(v4l2_sd, video, g_input_status, &inp->status);
+	if (ret < 0 && ret != -ENOIOCTLCMD && ret != -ENODEV)
+		return ret;
+	inp->type = V4L2_INPUT_TYPE_CAMERA;
+	inp->std = 0;
+	if (v4l2_subdev_has_op(v4l2_sd, pad, dv_timings_cap))
+		inp->capabilities = V4L2_IN_CAP_DV_TIMINGS;
+	else
+		inp->capabilities = V4L2_IN_CAP_STD;
+	snprintf(inp->name, sizeof(inp->name), "Camera%u: %s", inp->index, viif_sd->v4l2_sd->name);
+
+	return 0;
+}
+
+static int viif_g_input(struct file *file, void *priv, unsigned int *i)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+
+	*i = viif_dev->sd_index;
+
+	return 0;
+}
+
+static int viif_s_input(struct file *file, void *priv, unsigned int i)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+
+	if (i >= viif_dev->num_sd)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int viif_g_selection(struct file *file, void *priv, struct v4l2_selection *s)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct v4l2_subdev_selection sel = {
+		.target = V4L2_SEL_TGT_CROP,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	int ret;
+
+	/* check path id */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0)
+		sel.pad = VIIF_ISP_PAD_SRC_PATH0;
+	else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1)
+		sel.pad = VIIF_ISP_PAD_SRC_PATH1;
+	else
+		return -EINVAL;
+
+	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_selection, NULL, &sel);
+	s->r = sel.r;
+
+	return ret;
+}
+
+static int viif_s_selection(struct file *file, void *priv, struct v4l2_selection *s)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct v4l2_subdev_selection sel = {
+		.target = V4L2_SEL_TGT_CROP,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.r = s->r,
+	};
+	int ret;
+
+	/* check path id */
+	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0)
+		sel.pad = VIIF_ISP_PAD_SRC_PATH0;
+	else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1)
+		sel.pad = VIIF_ISP_PAD_SRC_PATH1;
+	else
+		return -EINVAL;
+
+	if (s->r.left > VIIF_CROP_MAX_X_ISP || s->r.top > VIIF_CROP_MAX_Y_ISP ||
+	    s->r.width < VIIF_CROP_MIN_W || s->r.width > VIIF_CROP_MAX_W_ISP ||
+	    s->r.height < VIIF_CROP_MIN_H || s->r.height > VIIF_CROP_MAX_H_ISP) {
+		return -EINVAL;
+	}
+
+	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, set_selection, NULL, &sel);
+	s->r = sel.r;
+
+	return ret;
+}
+
+static int viif_dv_timings_cap(struct file *file, void *priv_fh, struct v4l2_dv_timings_cap *cap)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, dv_timings_cap, cap);
+}
+
+static int viif_enum_dv_timings(struct file *file, void *priv_fh,
+				struct v4l2_enum_dv_timings *timings)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, enum_dv_timings, timings);
+}
+
+static int viif_g_dv_timings(struct file *file, void *priv_fh, struct v4l2_dv_timings *timings)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, video, g_dv_timings, timings);
+}
+
+static int viif_s_dv_timings(struct file *file, void *priv_fh, struct v4l2_dv_timings *timings)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, video, s_dv_timings, timings);
+}
+
+static int viif_query_dv_timings(struct file *file, void *priv_fh, struct v4l2_dv_timings *timings)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, video, query_dv_timings, timings);
+}
+
+static int viif_g_edid(struct file *file, void *fh, struct v4l2_edid *edid)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_edid, edid);
+}
+
+static int viif_s_edid(struct file *file, void *fh, struct v4l2_edid *edid)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, set_edid, edid);
+}
+
+static int viif_g_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+
+	return v4l2_g_parm_cap(video_devdata(file), viif_dev->sd->v4l2_sd, a);
+}
+
+static int viif_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+
+	return v4l2_s_parm_cap(video_devdata(file), viif_dev->sd->v4l2_sd, a);
+}
+
+static int viif_enum_framesizes(struct file *file, void *fh, struct v4l2_frmsizeenum *fsize)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct v4l2_subdev *v4l2_sd = viif_sd->v4l2_sd;
+	struct v4l2_subdev_frame_size_enum fse = {
+		.code = viif_sd->mbus_code,
+		.index = fsize->index,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	int ret;
+
+	ret = v4l2_subdev_call(v4l2_sd, pad, enum_frame_size, NULL, &fse);
+	if (ret)
+		return ret;
+
+	fsize->type = V4L2_FRMSIZE_TYPE_DISCRETE;
+	fsize->discrete.width = fse.max_width;
+	fsize->discrete.height = fse.max_height;
+
+	return 0;
+}
+
+static int viif_enum_frameintervals(struct file *file, void *fh, struct v4l2_frmivalenum *fival)
+{
+	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct v4l2_subdev *v4l2_sd = viif_sd->v4l2_sd;
+	struct v4l2_subdev_frame_interval_enum fie = {
+		.code = viif_sd->mbus_code,
+		.index = fival->index,
+		.width = fival->width,
+		.height = fival->height,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	int ret;
+
+	ret = v4l2_subdev_call(v4l2_sd, pad, enum_frame_interval, NULL, &fie);
+	if (ret)
+		return ret;
+
+	fival->type = V4L2_FRMIVAL_TYPE_DISCRETE;
+	fival->discrete = fie.interval;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops viif_ioctl_ops = {
+	.vidioc_querycap = viif_querycap,
+
+	.vidioc_enum_fmt_vid_cap = viif_enum_fmt_vid_cap,
+	.vidioc_try_fmt_vid_cap_mplane = viif_try_fmt_vid_cap,
+	.vidioc_s_fmt_vid_cap_mplane = viif_s_fmt_vid_cap,
+	.vidioc_g_fmt_vid_cap_mplane = viif_g_fmt_vid_cap,
+
+	.vidioc_enum_input = viif_enum_input,
+	.vidioc_g_input = viif_g_input,
+	.vidioc_s_input = viif_s_input,
+
+	.vidioc_g_selection = viif_g_selection,
+	.vidioc_s_selection = viif_s_selection,
+
+	.vidioc_dv_timings_cap = viif_dv_timings_cap,
+	.vidioc_enum_dv_timings = viif_enum_dv_timings,
+	.vidioc_g_dv_timings = viif_g_dv_timings,
+	.vidioc_s_dv_timings = viif_s_dv_timings,
+	.vidioc_query_dv_timings = viif_query_dv_timings,
+
+	.vidioc_g_edid = viif_g_edid,
+	.vidioc_s_edid = viif_s_edid,
+
+	.vidioc_g_parm = viif_g_parm,
+	.vidioc_s_parm = viif_s_parm,
+
+	.vidioc_enum_framesizes = viif_enum_framesizes,
+	.vidioc_enum_frameintervals = viif_enum_frameintervals,
+
+	.vidioc_reqbufs = vb2_ioctl_reqbufs,
+	.vidioc_querybuf = vb2_ioctl_querybuf,
+	.vidioc_qbuf = vb2_ioctl_qbuf,
+	.vidioc_expbuf = vb2_ioctl_expbuf,
+	.vidioc_dqbuf = vb2_ioctl_dqbuf,
+	.vidioc_create_bufs = vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
+	.vidioc_streamon = vb2_ioctl_streamon,
+	.vidioc_streamoff = vb2_ioctl_streamoff,
+
+	.vidioc_log_status = v4l2_ctrl_log_status,
+	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
+};
+
+/* --- File Operations --- */
+static int viif_capture_open(struct file *file)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	int ret;
+
+	ret = v4l2_fh_open(file);
+	if (ret)
+		return ret;
+
+	/* PATH0 only */
+	if (cap_dev->pathid > 0)
+		return 0;
+
+	viif_dev->rawpack_mode = HWD_VIIF_RAWPACK_DISABLE;
+
+	viif_dev->is_powered = 1;
+
+	mutex_lock(&viif_dev->mlock);
+
+	/* Initialize HWD driver */
+	visconti_viif_hw_on(viif_dev);
+
+	/* VSYNC mask setting of MAIN unit */
+	hwd_viif_main_vsync_set_irq_mask(viif_dev->ch, 0x00050003);
+
+	/* STATUS error mask setting(unmask) of MAIN unit */
+	hwd_viif_main_status_err_set_irq_mask(viif_dev->ch, 0x01000000);
+
+	/* VSYNC mask settings of SUB unit */
+	hwd_viif_sub_vsync_set_irq_mask(viif_dev->ch, 0x00030001);
+
+	/* STATUS error mask setting(unmask) of SUB unit */
+	hwd_viif_sub_status_err_set_irq_mask(viif_dev->ch, 0x11010000);
+
+	mutex_unlock(&viif_dev->mlock);
+
+	return ret;
+}
+
+static int viif_capture_release(struct file *file)
+{
+	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	int ret;
+
+	ret = vb2_fop_release(file);
+	if (ret)
+		return ret;
+
+	/* PATH0 only */
+	if (cap_dev->pathid > 0)
+		return 0;
+
+	mutex_lock(&viif_dev->mlock);
+	visconti_viif_hw_off(viif_dev);
+	mutex_unlock(&viif_dev->mlock);
+
+	viif_dev->is_powered = 0;
+
+	return 0;
+}
+
+static const struct v4l2_file_operations viif_fops = {
+	.owner = THIS_MODULE,
+	.open = viif_capture_open,
+	.release = viif_capture_release,
+	.unlocked_ioctl = video_ioctl2,
+	.mmap = vb2_fop_mmap,
+	.poll = vb2_fop_poll,
+};
+
+/* ----- media control callbacks ----- */
+static int viif_capture_link_validate(struct media_link *link)
+{
+	/* TODO: add link validation at start-stream */
+	return 0;
+}
+
+static const struct media_entity_operations viif_media_ops = {
+	.link_validate = viif_capture_link_validate,
+};
+
+/* ----- attach ctrl callbacck handler ----- */
+int visconti_viif_capture_register_ctrl_handlers(struct viif_device *viif_dev)
+{
+	int ret;
+
+	/* wire cap_dev 0 */
+	ret = v4l2_ctrl_add_handler(&viif_dev->cap_dev0.ctrl_handler,
+				    viif_dev->sd->v4l2_sd->ctrl_handler, NULL, true);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to add sensor ctrl_handler");
+		return ret;
+	}
+	ret = v4l2_ctrl_add_handler(&viif_dev->cap_dev0.ctrl_handler,
+				    &viif_dev->isp_subdev.ctrl_handler, NULL, true);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to add isp subdev ctrl_handler");
+		return ret;
+	}
+
+	/* wire cap_dev 1 */
+	ret = v4l2_ctrl_add_handler(&viif_dev->cap_dev1.ctrl_handler,
+				    viif_dev->sd->v4l2_sd->ctrl_handler, NULL, true);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to add sensor ctrl_handler");
+		return ret;
+	}
+	ret = v4l2_ctrl_add_handler(&viif_dev->cap_dev1.ctrl_handler,
+				    &viif_dev->isp_subdev.ctrl_handler, NULL, true);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to add isp subdev ctrl_handler");
+		return ret;
+	}
+
+	/* no need to wire cap_dev 2 */
+
+	return 0;
+}
+
+/* ----- register/remove capture device node ----- */
+static int visconti_viif_capture_register_node(struct cap_dev *cap_dev)
+{
+	struct viif_device *viif_dev = cap_dev->viif_dev;
+	struct v4l2_device *v4l2_dev = &viif_dev->v4l2_dev;
+	struct video_device *vdev = &cap_dev->vdev;
+	struct vb2_queue *q = &cap_dev->vb2_vq;
+	static const char *const node_name[] = {
+		"viif_capture_post0",
+		"viif_capture_post1",
+		"viif_capture_sub",
+	};
+	int ret;
+
+	/* Initialize vb2 queue. */
+	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	q->io_modes = VB2_DMABUF;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->ops = &viif_vb2_ops;
+	q->mem_ops = &vb2_dma_contig_memops;
+	q->drv_priv = cap_dev;
+	q->buf_struct_size = sizeof(struct viif_buffer);
+	q->min_buffers_needed = 2;
+	q->lock = &viif_dev->mlock;
+	q->dev = viif_dev->v4l2_dev.dev;
+
+	ret = vb2_queue_init(q);
+	if (ret)
+		return ret;
+
+	/* Register the video device. */
+	strscpy(vdev->name, node_name[cap_dev->pathid], sizeof(vdev->name));
+	vdev->v4l2_dev = v4l2_dev;
+	vdev->lock = &viif_dev->mlock;
+	vdev->queue = &cap_dev->vb2_vq;
+	vdev->ctrl_handler = NULL;
+	vdev->fops = &viif_fops;
+	vdev->ioctl_ops = &viif_ioctl_ops;
+	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE | V4L2_CAP_STREAMING;
+	vdev->device_caps |= V4L2_CAP_IO_MC;
+	vdev->entity.ops = &viif_media_ops;
+	vdev->release = video_device_release_empty;
+	video_set_drvdata(vdev, cap_dev);
+	vdev->vfl_dir = VFL_DIR_RX;
+	cap_dev->capture_pad.flags = MEDIA_PAD_FL_SINK;
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	if (ret < 0) {
+		dev_err(v4l2_dev->dev, "video_register_device failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = media_entity_pads_init(&vdev->entity, 1, &cap_dev->capture_pad);
+	if (ret) {
+		video_unregister_device(vdev);
+		return ret;
+	}
+
+	ret = v4l2_ctrl_handler_init(&cap_dev->ctrl_handler, 30);
+	if (ret)
+		return -ENOMEM;
+
+	cap_dev->vdev.ctrl_handler = &cap_dev->ctrl_handler;
+
+	return 0;
+}
+
+int visconti_viif_capture_register(struct viif_device *viif_dev)
+{
+	struct cap_dev *cap_dev;
+	int ret;
+
+	{
+		cap_dev = &viif_dev->cap_dev0;
+		cap_dev->pathid = 0;
+		cap_dev->viif_dev = viif_dev;
+		ret = visconti_viif_capture_register_node(cap_dev);
+		if (ret)
+			return ret;
+	}
+	{
+		cap_dev = &viif_dev->cap_dev1;
+		cap_dev->pathid = 1;
+		cap_dev->viif_dev = viif_dev;
+		ret = visconti_viif_capture_register_node(cap_dev);
+		if (ret)
+			return ret;
+	}
+	{
+		cap_dev = &viif_dev->cap_dev2;
+		cap_dev->pathid = 2;
+		cap_dev->viif_dev = viif_dev;
+		ret = visconti_viif_capture_register_node(cap_dev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void visconti_viif_capture_unregister_node(struct cap_dev *cap_dev)
+{
+	media_entity_cleanup(&cap_dev->vdev.entity);
+	v4l2_ctrl_handler_free(&cap_dev->ctrl_handler);
+	vb2_video_unregister_device(&cap_dev->vdev);
+}
+
+void visconti_viif_capture_unregister(struct viif_device *viif_dev)
+{
+	visconti_viif_capture_unregister_node(&viif_dev->cap_dev0);
+	visconti_viif_capture_unregister_node(&viif_dev->cap_dev1);
+	visconti_viif_capture_unregister_node(&viif_dev->cap_dev2);
+}
diff --git a/drivers/media/platform/visconti/viif_controls.c b/drivers/media/platform/visconti/viif_controls.c
new file mode 100644
index 000000000..184088bbd
--- /dev/null
+++ b/drivers/media/platform/visconti/viif_controls.c
@@ -0,0 +1,1149 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <linux/delay.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-subdev.h>
+
+#include "viif.h"
+
+static int viif_main_set_rawpack_mode(struct viif_device *viif_dev, u32 *rawpack)
+{
+	if (vb2_is_streaming(&viif_dev->cap_dev0.vb2_vq))
+		return -EBUSY;
+
+	if (*rawpack == VIIF_RAWPACK_DISABLE) {
+		viif_dev->rawpack_mode = HWD_VIIF_RAWPACK_DISABLE;
+		return 0;
+	}
+	if (*rawpack == VIIF_RAWPACK_MSBFIRST) {
+		viif_dev->rawpack_mode = HWD_VIIF_RAWPACK_MSBFIRST;
+		return 0;
+	}
+	if (*rawpack == VIIF_RAWPACK_LSBFIRST) {
+		viif_dev->rawpack_mode = HWD_VIIF_RAWPACK_LSBFIRST;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int viif_l1_set_input_mode(struct viif_device *viif_dev,
+				  struct viif_l1_input_mode_config *input_mode)
+{
+	u32 mode, raw_color_filter;
+	unsigned long irqflags;
+	int ret;
+
+	/* SDR input is not supported */
+	if (input_mode->mode == VIIF_L1_INPUT_HDR)
+		mode = HWD_VIIF_L1_INPUT_HDR;
+	else if (input_mode->mode == VIIF_L1_INPUT_PWL)
+		mode = HWD_VIIF_L1_INPUT_PWL;
+	else if (input_mode->mode == VIIF_L1_INPUT_HDR_IMG_CORRECT)
+		mode = HWD_VIIF_L1_INPUT_HDR_IMG_CORRECT;
+	else if (input_mode->mode == VIIF_L1_INPUT_PWL_IMG_CORRECT)
+		mode = HWD_VIIF_L1_INPUT_PWL_IMG_CORRECT;
+	else
+		return -EINVAL;
+
+	if (input_mode->raw_color_filter == VIIF_L1_RAW_GR_R_B_GB)
+		raw_color_filter = HWD_VIIF_L1_RAW_GR_R_B_GB;
+	else if (input_mode->raw_color_filter == VIIF_L1_RAW_R_GR_GB_B)
+		raw_color_filter = HWD_VIIF_L1_RAW_R_GR_GB_B;
+	else if (input_mode->raw_color_filter == VIIF_L1_RAW_B_GB_GR_R)
+		raw_color_filter = HWD_VIIF_L1_RAW_B_GB_GR_R;
+	else if (input_mode->raw_color_filter == VIIF_L1_RAW_GB_B_R_GR)
+		raw_color_filter = HWD_VIIF_L1_RAW_GB_B_R_GR;
+	else
+		return -EINVAL;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_input_mode(viif_dev->ch, mode, input_mode->depth, raw_color_filter);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_rgb_to_y_coef(struct viif_device *viif_dev,
+				     struct viif_l1_rgb_to_y_coef_config *l1_rgb_to_y_coef)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_rgb_to_y_coef(viif_dev->ch, l1_rgb_to_y_coef->coef_r,
+					    l1_rgb_to_y_coef->coef_g, l1_rgb_to_y_coef->coef_b);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_ag_mode(struct viif_device *viif_dev,
+			       struct viif_l1_ag_mode_config *l1_ag_mode)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_ag_mode(viif_dev->ch, l1_ag_mode);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_ag(struct viif_device *viif_dev, struct viif_l1_ag_config *l1_ag)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_ag(viif_dev->ch, l1_ag->gain_h, l1_ag->gain_m, l1_ag->gain_l);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_hdre(struct viif_device *viif_dev, struct viif_l1_hdre_config *l1_hdre)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_hdre(viif_dev->ch, l1_hdre);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_img_extraction(struct viif_device *viif_dev,
+				      struct viif_l1_img_extraction_config *img_extract)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_img_extraction(viif_dev->ch, img_extract->input_black_gr,
+					     img_extract->input_black_r, img_extract->input_black_b,
+					     img_extract->input_black_gb);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+#define VISCONTI_VIIF_DPC_TABLE_SIZE 8192
+static int viif_l1_set_dpc(struct viif_device *viif_dev, struct viif_l1_dpc_config *l1_dpc)
+{
+	uintptr_t table_h_paddr = 0;
+	uintptr_t table_m_paddr = 0;
+	uintptr_t table_l_paddr = 0;
+	unsigned long irqflags;
+	int ret;
+
+	if (l1_dpc->table_h_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->dpc_table_h,
+				   u64_to_user_ptr(l1_dpc->table_h_addr),
+				   VISCONTI_VIIF_DPC_TABLE_SIZE))
+			return -EFAULT;
+		table_h_paddr = (uintptr_t)viif_dev->table_paddr->dpc_table_h;
+	}
+	if (l1_dpc->table_m_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->dpc_table_m,
+				   u64_to_user_ptr(l1_dpc->table_m_addr),
+				   VISCONTI_VIIF_DPC_TABLE_SIZE))
+			return -EFAULT;
+		table_m_paddr = (uintptr_t)viif_dev->table_paddr->dpc_table_m;
+	}
+	if (l1_dpc->table_l_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->dpc_table_l,
+				   u64_to_user_ptr(l1_dpc->table_l_addr),
+				   VISCONTI_VIIF_DPC_TABLE_SIZE))
+			return -EFAULT;
+		table_l_paddr = (uintptr_t)viif_dev->table_paddr->dpc_table_l;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_dpc_table_transmission(viif_dev->ch, table_h_paddr, table_m_paddr,
+						     table_l_paddr);
+	if (ret)
+		goto err;
+
+	ret = hwd_viif_l1_set_dpc(viif_dev->ch, &l1_dpc->param_h, &l1_dpc->param_m,
+				  &l1_dpc->param_l);
+
+err:
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+	return ret;
+}
+
+static int
+viif_l1_set_preset_white_balance(struct viif_device *viif_dev,
+				 struct viif_l1_preset_white_balance_config *l1_preset_wb)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_preset_white_balance(viif_dev->ch, l1_preset_wb->dstmaxval,
+						   &l1_preset_wb->param_h, &l1_preset_wb->param_m,
+						   &l1_preset_wb->param_l);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int
+viif_l1_set_raw_color_noise_reduction(struct viif_device *viif_dev,
+				      struct viif_l1_raw_color_noise_reduction_config *raw_color)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_raw_color_noise_reduction(viif_dev->ch, &raw_color->param_h,
+							&raw_color->param_m, &raw_color->param_l);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_hdrs(struct viif_device *viif_dev, struct viif_l1_hdrs_config *hdrs)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_hdrs(viif_dev->ch, hdrs);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_black_level_correction(struct viif_device *viif_dev,
+					      struct viif_l1_black_level_correction_config *blc)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_black_level_correction(viif_dev->ch, blc);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+#define VISCONTI_VIIF_LSC_TABLE_BYTES 1536
+
+static int viif_l1_set_lsc(struct viif_device *viif_dev, struct viif_l1_lsc_config *l1_lsc)
+{
+	struct viif_l1_lsc_parabola_param lsc_para;
+	struct viif_l1_lsc_grid_param lsc_grid;
+	struct hwd_viif_l1_lsc hwd_params;
+	struct viif_l1_lsc lsc_params;
+	uintptr_t table_gr_paddr = 0;
+	uintptr_t table_gb_paddr = 0;
+	uintptr_t table_r_paddr = 0;
+	uintptr_t table_b_paddr = 0;
+	unsigned long irqflags;
+	int ret;
+
+	if (!l1_lsc->param_addr) {
+		spin_lock_irqsave(&viif_dev->lock, irqflags);
+		hwd_viif_isp_guard_start(viif_dev->ch);
+		ret = hwd_viif_l1_set_lsc(viif_dev->ch, NULL);
+		hwd_viif_isp_guard_end(viif_dev->ch);
+		spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+		return ret;
+	}
+
+	if (l1_lsc->table_gr_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->lsc_table_gr,
+				   u64_to_user_ptr(l1_lsc->table_gr_addr),
+				   VISCONTI_VIIF_LSC_TABLE_BYTES))
+			return -EFAULT;
+		table_gr_paddr = (uintptr_t)viif_dev->table_paddr->lsc_table_gr;
+	}
+	if (l1_lsc->table_r_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->lsc_table_r,
+				   u64_to_user_ptr(l1_lsc->table_r_addr),
+				   VISCONTI_VIIF_LSC_TABLE_BYTES))
+			return -EFAULT;
+		table_r_paddr = (uintptr_t)viif_dev->table_paddr->lsc_table_r;
+	}
+	if (l1_lsc->table_b_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->lsc_table_b,
+				   u64_to_user_ptr(l1_lsc->table_b_addr),
+				   VISCONTI_VIIF_LSC_TABLE_BYTES))
+			return -EFAULT;
+		table_b_paddr = (uintptr_t)viif_dev->table_paddr->lsc_table_b;
+	}
+	if (l1_lsc->table_gb_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->lsc_table_gb,
+				   u64_to_user_ptr(l1_lsc->table_gb_addr),
+				   VISCONTI_VIIF_LSC_TABLE_BYTES))
+			return -EFAULT;
+		table_gb_paddr = (uintptr_t)viif_dev->table_paddr->lsc_table_gb;
+	}
+
+	if (copy_from_user(&lsc_params, u64_to_user_ptr(l1_lsc->param_addr),
+			   sizeof(struct viif_l1_lsc)))
+		return -EFAULT;
+
+	hwd_params.lssc_parabola_param = NULL;
+	hwd_params.lssc_grid_param = NULL;
+
+	if (lsc_params.lssc_parabola_param_addr) {
+		if (copy_from_user(&lsc_para, u64_to_user_ptr(lsc_params.lssc_parabola_param_addr),
+				   sizeof(struct viif_l1_lsc_parabola_param)))
+			return -EFAULT;
+		hwd_params.lssc_parabola_param = &lsc_para;
+	}
+
+	if (lsc_params.lssc_grid_param_addr) {
+		if (copy_from_user(&lsc_grid, u64_to_user_ptr(lsc_params.lssc_grid_param_addr),
+				   sizeof(struct viif_l1_lsc_grid_param)))
+			return -EFAULT;
+		hwd_params.lssc_grid_param = &lsc_grid;
+	}
+
+	hwd_params.lssc_pwhb_r_gain_max = lsc_params.lssc_pwhb_r_gain_max;
+	hwd_params.lssc_pwhb_r_gain_min = lsc_params.lssc_pwhb_r_gain_min;
+	hwd_params.lssc_pwhb_gr_gain_max = lsc_params.lssc_pwhb_gr_gain_max;
+	hwd_params.lssc_pwhb_gr_gain_min = lsc_params.lssc_pwhb_gr_gain_min;
+	hwd_params.lssc_pwhb_gb_gain_max = lsc_params.lssc_pwhb_gb_gain_max;
+	hwd_params.lssc_pwhb_gb_gain_min = lsc_params.lssc_pwhb_gb_gain_min;
+	hwd_params.lssc_pwhb_b_gain_max = lsc_params.lssc_pwhb_b_gain_max;
+	hwd_params.lssc_pwhb_b_gain_min = lsc_params.lssc_pwhb_b_gain_min;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_lsc_table_transmission(viif_dev->ch, table_gr_paddr, table_r_paddr,
+						     table_b_paddr, table_gb_paddr);
+	if (ret)
+		goto err;
+
+	ret = hwd_viif_l1_set_lsc(viif_dev->ch, &hwd_params);
+err:
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_main_process(struct viif_device *viif_dev,
+				    struct viif_l1_main_process_config *mpro)
+{
+	struct viif_l1_color_matrix_correction color_matrix;
+	unsigned long irqflags;
+	int ret;
+
+	if (mpro->param_addr) {
+		if (copy_from_user(&color_matrix, u64_to_user_ptr(mpro->param_addr),
+				   sizeof(struct viif_l1_color_matrix_correction)))
+			return -EFAULT;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_main_process(viif_dev->ch, mpro->demosaic_mode, mpro->damp_lsbsel,
+					   mpro->param_addr ? &color_matrix : NULL,
+					   mpro->dst_maxval);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_awb(struct viif_device *viif_dev, struct viif_l1_awb_config *l1_awb)
+{
+	struct viif_l1_awb param;
+	unsigned long irqflags;
+	int ret;
+
+	if (l1_awb->param_addr) {
+		if (copy_from_user(&param, u64_to_user_ptr(l1_awb->param_addr),
+				   sizeof(struct viif_l1_awb)))
+			return -EFAULT;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_awb(viif_dev->ch, l1_awb->param_addr ? &param : NULL,
+				  l1_awb->awhb_wbmrg, l1_awb->awhb_wbmgg, l1_awb->awhb_wbmbg);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_lock_awb_gain(struct viif_device *viif_dev, u32 *enable)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_lock_awb_gain(viif_dev->ch, *enable);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_hdrc(struct viif_device *viif_dev, struct viif_l1_hdrc_config *hdrc)
+{
+	struct viif_l1_hdrc param;
+	unsigned long irqflags;
+	int ret;
+
+	if (hdrc->param_addr) {
+		if (copy_from_user(&param, u64_to_user_ptr(hdrc->param_addr),
+				   sizeof(struct viif_l1_hdrc)))
+			return -EFAULT;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_hdrc(viif_dev->ch, hdrc->param_addr ? &param : NULL,
+				   hdrc->hdrc_thr_sft_amt);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_hdrc_ltm(struct viif_device *viif_dev,
+				struct viif_l1_hdrc_ltm_config *l1_hdrc_ltm)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_hdrc_ltm(viif_dev->ch, l1_hdrc_ltm);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_gamma(struct viif_device *viif_dev, struct viif_l1_gamma_config *l1_gamma)
+{
+	struct viif_l1_gamma param;
+	unsigned long irqflags;
+	int ret;
+
+	if (l1_gamma->param_addr) {
+		if (copy_from_user(&param, u64_to_user_ptr(l1_gamma->param_addr),
+				   sizeof(struct viif_l1_gamma)))
+			return -EFAULT;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_gamma(viif_dev->ch, l1_gamma->param_addr ? &param : NULL);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int
+viif_l1_set_img_quality_adjustment(struct viif_device *viif_dev,
+				   struct viif_l1_img_quality_adjustment_config *img_quality)
+{
+	struct hwd_viif_l1_img_quality_adjustment hwd_img_quality;
+	struct viif_l1_lum_noise_reduction lum_noise;
+	struct viif_l1_nonlinear_contrast nonlinear;
+	struct viif_l1_coring_suppression coring;
+	struct viif_l1_edge_enhancement edge_enh;
+	struct viif_l1_edge_suppression edge_sup;
+	struct viif_l1_uv_suppression uv;
+	struct viif_l1_color_level color;
+	unsigned long irqflags;
+	int ret;
+
+	hwd_img_quality.coef_cb = img_quality->coef_cb;
+	hwd_img_quality.coef_cr = img_quality->coef_cr;
+	hwd_img_quality.brightness = img_quality->brightness;
+	hwd_img_quality.linear_contrast = img_quality->linear_contrast;
+
+	if (img_quality->nonlinear_contrast_addr) {
+		if (copy_from_user(&nonlinear,
+				   u64_to_user_ptr(img_quality->nonlinear_contrast_addr),
+				   sizeof(struct viif_l1_nonlinear_contrast)))
+			return -EFAULT;
+		hwd_img_quality.nonlinear_contrast = &nonlinear;
+	} else {
+		hwd_img_quality.nonlinear_contrast = NULL;
+	}
+	if (img_quality->lum_noise_reduction_addr) {
+		if (copy_from_user(&lum_noise,
+				   u64_to_user_ptr(img_quality->lum_noise_reduction_addr),
+				   sizeof(struct viif_l1_lum_noise_reduction)))
+			return -EFAULT;
+		hwd_img_quality.lum_noise_reduction = &lum_noise;
+	} else {
+		hwd_img_quality.lum_noise_reduction = NULL;
+	}
+	if (img_quality->edge_enhancement_addr) {
+		if (copy_from_user(&edge_enh, u64_to_user_ptr(img_quality->edge_enhancement_addr),
+				   sizeof(struct viif_l1_edge_enhancement)))
+			return -EFAULT;
+		hwd_img_quality.edge_enhancement = &edge_enh;
+	} else {
+		hwd_img_quality.edge_enhancement = NULL;
+	}
+	if (img_quality->uv_suppression_addr) {
+		if (copy_from_user(&uv, u64_to_user_ptr(img_quality->uv_suppression_addr),
+				   sizeof(struct viif_l1_uv_suppression)))
+			return -EFAULT;
+		hwd_img_quality.uv_suppression = &uv;
+	} else {
+		hwd_img_quality.uv_suppression = NULL;
+	}
+	if (img_quality->coring_suppression_addr) {
+		if (copy_from_user(&coring, u64_to_user_ptr(img_quality->coring_suppression_addr),
+				   sizeof(struct viif_l1_coring_suppression)))
+			return -EFAULT;
+		hwd_img_quality.coring_suppression = &coring;
+	} else {
+		hwd_img_quality.coring_suppression = NULL;
+	}
+	if (img_quality->edge_suppression_addr) {
+		if (copy_from_user(&edge_sup, u64_to_user_ptr(img_quality->edge_suppression_addr),
+				   sizeof(struct viif_l1_edge_suppression)))
+			return -EFAULT;
+		hwd_img_quality.edge_suppression = &edge_sup;
+	} else {
+		hwd_img_quality.edge_suppression = NULL;
+	}
+	if (img_quality->color_level_addr) {
+		if (copy_from_user(&color, u64_to_user_ptr(img_quality->color_level_addr),
+				   sizeof(struct viif_l1_color_level)))
+			return -EFAULT;
+		hwd_img_quality.color_level = &color;
+	} else {
+		hwd_img_quality.color_level = NULL;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_img_quality_adjustment(viif_dev->ch, &hwd_img_quality);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_avg_lum_generation(struct viif_device *viif_dev,
+					  struct viif_l1_avg_lum_generation_config *l1_avg_lum)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l1_set_avg_lum_generation(viif_dev->ch, l1_avg_lum);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+#define VISCONTI_VIIF_DPC_TABLE_SIZE_MIN 1024
+#define VISCONTI_VIIF_DPC_TABLE_SIZE_MAX 8192
+static int viif_l2_set_undist(struct viif_device *viif_dev, struct viif_l2_undist_config *undist)
+{
+	uintptr_t table_write_g_paddr = 0;
+	uintptr_t table_read_b_paddr = 0;
+	uintptr_t table_read_g_paddr = 0;
+	uintptr_t table_read_r_paddr = 0;
+	unsigned long irqflags;
+	int ret;
+
+	if ((undist->size && undist->size < VISCONTI_VIIF_DPC_TABLE_SIZE_MIN) ||
+	    undist->size > VISCONTI_VIIF_DPC_TABLE_SIZE_MAX)
+		return -EINVAL;
+
+	if (undist->write_g_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->undist_write_g,
+				   u64_to_user_ptr(undist->write_g_addr), undist->size))
+			return -EFAULT;
+		table_write_g_paddr = (uintptr_t)viif_dev->table_paddr->undist_write_g;
+	}
+	if (undist->read_b_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->undist_read_b,
+				   u64_to_user_ptr(undist->read_b_addr), undist->size))
+			return -EFAULT;
+		table_read_b_paddr = (uintptr_t)viif_dev->table_paddr->undist_read_b;
+	}
+	if (undist->read_g_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->undist_read_g,
+				   u64_to_user_ptr(undist->read_g_addr), undist->size))
+			return -EFAULT;
+		table_read_g_paddr = (uintptr_t)viif_dev->table_paddr->undist_read_g;
+	}
+	if (undist->read_r_addr) {
+		if (copy_from_user(viif_dev->table_vaddr->undist_read_r,
+				   u64_to_user_ptr(undist->read_r_addr), undist->size))
+			return -EFAULT;
+		table_read_r_paddr = (uintptr_t)viif_dev->table_paddr->undist_read_r;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l2_set_undist_table_transmission(viif_dev->ch, table_write_g_paddr,
+							table_read_b_paddr, table_read_g_paddr,
+							table_read_r_paddr, undist->size);
+	if (ret) {
+		dev_err(viif_dev->dev, "l2_set_undist_table_transmission error. %d\n", ret);
+		goto err;
+	}
+
+	ret = hwd_viif_l2_set_undist(viif_dev->ch, &undist->param);
+
+err:
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+	return ret;
+}
+
+static int viif_l2_set_roi(struct viif_device *viif_dev, struct viif_l2_roi_config *roi)
+{
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l2_set_roi(viif_dev->ch, roi);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+	return ret;
+}
+
+static int viif_l2_set_roi_wrap(struct viif_device *viif_dev, struct viif_l2_roi_config *roi)
+{
+	int ret;
+
+	ret = viif_l2_set_roi(viif_dev, roi);
+	if (!ret)
+		visconti_viif_isp_set_compose_rect(viif_dev, roi);
+
+	return ret;
+}
+
+#define VISCONTI_VIIF_GANMMA_TABLE_SIZE 512
+static int viif_l2_set_gamma(struct viif_device *viif_dev, struct viif_l2_gamma_config *l2_gamma)
+{
+	struct hwd_viif_l2_gamma_table hwd_table = { 0 };
+	int pathid = l2_gamma->pathid;
+	unsigned long irqflags;
+	int postid;
+	int ret;
+	u32 i;
+
+	if (pathid == CAPTURE_PATH_MAIN_POST0)
+		postid = VIIF_L2ISP_POST_0;
+	else if (pathid == CAPTURE_PATH_MAIN_POST1)
+		postid = VIIF_L2ISP_POST_1;
+	else
+		return -EINVAL;
+
+	for (i = 0; i < 6; i++) {
+		if (l2_gamma->table_addr[i]) {
+			if (copy_from_user(viif_dev->table_vaddr->l2_gamma_table[pathid][i],
+					   u64_to_user_ptr(l2_gamma->table_addr[i]),
+					   VISCONTI_VIIF_GANMMA_TABLE_SIZE))
+				return -EFAULT;
+			hwd_table.table[i] =
+				(uintptr_t)viif_dev->table_paddr->l2_gamma_table[pathid][i];
+		}
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	ret = hwd_viif_l2_set_gamma_table_transmission(viif_dev->ch, postid, &hwd_table);
+	if (ret)
+		goto err;
+
+	ret = hwd_viif_l2_set_gamma(viif_dev->ch, postid, l2_gamma->enable, l2_gamma->vsplit,
+				    l2_gamma->mode);
+err:
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+	return ret;
+}
+
+static int
+viif_csi2rx_get_calibration_status(struct viif_device *viif_dev,
+				   struct viif_csi2rx_dphy_calibration_status *calibration_status)
+{
+	int ret;
+
+	if (!vb2_is_streaming(&viif_dev->cap_dev0.vb2_vq))
+		return -EIO;
+
+	ret = hwd_viif_csi2rx_get_calibration_status(viif_dev->ch, calibration_status);
+
+	return ret;
+}
+
+static int viif_csi2rx_get_err_status(struct viif_device *viif_dev,
+				      struct viif_csi2rx_err_status *csi_err)
+{
+	int ret;
+
+	if (!vb2_is_streaming(&viif_dev->cap_dev0.vb2_vq))
+		return -EIO;
+
+	ret = hwd_viif_csi2rx_get_err_status(viif_dev->ch, &csi_err->err_phy_fatal,
+					     &csi_err->err_pkt_fatal, &csi_err->err_frame_fatal,
+					     &csi_err->err_phy, &csi_err->err_pkt,
+					     &csi_err->err_line);
+
+	return ret;
+}
+
+static int viif_isp_get_last_capture_status(struct viif_device *viif_dev,
+					    struct viif_isp_capture_status *status)
+{
+	struct hwd_viif_l1_info l1_info;
+	unsigned long irqflags;
+	int i, j;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	hwd_viif_isp_guard_start(viif_dev->ch);
+	hwd_viif_isp_get_info(viif_dev->ch, &l1_info, NULL);
+	hwd_viif_isp_guard_end(viif_dev->ch);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	status->l1_info.avg_lum_weight = l1_info.avg_lum_weight;
+	for (i = 0; i < 8; i++) {
+		for (j = 0; j < 8; j++)
+			status->l1_info.avg_lum_block[i][j] = l1_info.avg_lum_block[i][j];
+	}
+	for (i = 0; i < 4; i++)
+		status->l1_info.avg_lum_four_line_lum[i] = l1_info.avg_lum_four_line_lum[i];
+
+	status->l1_info.avg_satur_pixnum = l1_info.avg_satur_pixnum;
+	status->l1_info.avg_black_pixnum = l1_info.avg_black_pixnum;
+	status->l1_info.awb_ave_u = l1_info.awb_ave_u;
+	status->l1_info.awb_ave_v = l1_info.awb_ave_v;
+	status->l1_info.awb_accumulated_pixel = l1_info.awb_accumulated_pixel;
+	status->l1_info.awb_gain_r = l1_info.awb_gain_r;
+	status->l1_info.awb_gain_g = l1_info.awb_gain_g;
+	status->l1_info.awb_gain_b = l1_info.awb_gain_b;
+	status->l1_info.awb_status_u = l1_info.awb_status_u;
+	status->l1_info.awb_status_v = l1_info.awb_status_v;
+
+	return 0;
+}
+
+static int viif_isp_get_reported_errors(struct viif_device *viif_dev,
+					struct viif_reported_errors *status)
+{
+	status->main = viif_dev->reported_err_main;
+	status->sub = viif_dev->reported_err_sub;
+	status->csi2rx = viif_dev->reported_err_csi2rx;
+	viif_dev->reported_err_main = 0;
+	viif_dev->reported_err_sub = 0;
+	viif_dev->reported_err_csi2rx = 0;
+
+	return 0;
+}
+
+/* ===== v4l2 subdevice control handlers ===== */
+#define COMPOUND_TYPE_SAMPLE01 0x0280
+
+static int visconti_viif_isp_set_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct viif_device *viif_dev = ctrl->priv;
+
+	pr_info("isp_set_ctrl: %s", ctrl->name);
+	if (!viif_dev->is_powered) {
+		pr_info("warning: visconti viif HW is not powered");
+		return 0;
+	}
+
+	switch (ctrl->id) {
+	case V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE:
+		return viif_main_set_rawpack_mode(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE:
+		return viif_l1_set_input_mode(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF:
+		return viif_l1_set_rgb_to_y_coef(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE:
+		return viif_l1_set_ag_mode(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG:
+		return viif_l1_set_ag(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE:
+		return viif_l1_set_hdre(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION:
+		return viif_l1_set_img_extraction(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC:
+		return viif_l1_set_dpc(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE:
+		return viif_l1_set_preset_white_balance(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION:
+		return viif_l1_set_raw_color_noise_reduction(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS:
+		return viif_l1_set_hdrs(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION:
+		return viif_l1_set_black_level_correction(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC:
+		return viif_l1_set_lsc(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS:
+		return viif_l1_set_main_process(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB:
+		return viif_l1_set_awb(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN:
+		return viif_l1_lock_awb_gain(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC:
+		return viif_l1_set_hdrc(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM:
+		return viif_l1_set_hdrc_ltm(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA:
+		return viif_l1_set_gamma(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT:
+		return viif_l1_set_img_quality_adjustment(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION:
+		return viif_l1_set_avg_lum_generation(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST:
+		return viif_l2_set_undist(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI:
+		return viif_l2_set_roi_wrap(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA:
+		return viif_l2_set_gamma(viif_dev, ctrl->p_new.p);
+	default:
+		pr_info("unknown_ctrl: id=%08X val=%d", ctrl->id, ctrl->val);
+		break;
+	}
+	return 0;
+}
+
+static int visconti_viif_isp_get_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct viif_device *viif_dev = ctrl->priv;
+
+	pr_info("isp_get_ctrl: %s", ctrl->name);
+	if (!viif_dev->is_powered) {
+		pr_info("warning: visconti viif HW is not powered");
+		return 0;
+	}
+
+	switch (ctrl->id) {
+	case V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS:
+		return viif_csi2rx_get_calibration_status(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS:
+		return viif_csi2rx_get_err_status(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS:
+		return viif_isp_get_last_capture_status(viif_dev, ctrl->p_new.p);
+	case V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS:
+		return viif_isp_get_reported_errors(viif_dev, ctrl->p_new.p);
+	default:
+		pr_info("unknown_ctrl: id=%08X val=%d", ctrl->id, ctrl->val);
+		break;
+	}
+	return 0;
+}
+
+/* ===== register v4l2 subdevice controls ===== */
+static bool visconti_viif_isp_custom_ctrl_equal(const struct v4l2_ctrl *ctrl, u32 idx,
+						union v4l2_ctrl_ptr ptr1, union v4l2_ctrl_ptr ptr2)
+{
+	return !memcmp(ptr1.p_const, ptr2.p_const, ctrl->elem_size);
+}
+
+static void visconti_viif_isp_custom_ctrl_init(const struct v4l2_ctrl *ctrl, u32 idx,
+					       union v4l2_ctrl_ptr ptr)
+{
+	if (ctrl->p_def.p_const)
+		memcpy(ptr.p, ctrl->p_def.p_const, ctrl->elem_size);
+	else
+		memset(ptr.p, 0, ctrl->elem_size);
+}
+
+static void visconti_viif_isp_custom_ctrl_log(const struct v4l2_ctrl *ctrl)
+{
+}
+
+static int visconti_viif_isp_custom_ctrl_validate(const struct v4l2_ctrl *ctrl, u32 idx,
+						  union v4l2_ctrl_ptr ptr)
+{
+	pr_info("std_validate: %s", ctrl->name);
+	return 0;
+}
+
+static const struct v4l2_ctrl_type_ops custom_type_ops = {
+	.equal = visconti_viif_isp_custom_ctrl_equal,
+	.init = visconti_viif_isp_custom_ctrl_init,
+	.log = visconti_viif_isp_custom_ctrl_log,
+	.validate = visconti_viif_isp_custom_ctrl_validate,
+};
+
+static const struct v4l2_ctrl_ops visconti_viif_isp_ctrl_ops = {
+	.g_volatile_ctrl = visconti_viif_isp_get_ctrl,
+	.s_ctrl = visconti_viif_isp_set_ctrl,
+};
+
+/* ----- control handler ----- */
+#define CTRL_CONFIG_DEFAULT_ENTRY                                                                  \
+	.ops = &visconti_viif_isp_ctrl_ops, .type_ops = &custom_type_ops,                          \
+	.type = COMPOUND_TYPE_SAMPLE01, .flags = V4L2_CTRL_FLAG_EXECUTE_ON_WRITE
+
+#define CTRL_CONFIG_RDONLY_ENTRY                                                                   \
+	.ops = &visconti_viif_isp_ctrl_ops, .type_ops = &custom_type_ops,                          \
+	.type = COMPOUND_TYPE_SAMPLE01, .flags = V4L2_CTRL_FLAG_VOLATILE
+
+static const struct v4l2_ctrl_config visconti_viif_isp_ctrl_config[] = {
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE,
+		.name = "rawpack_mode",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(u32),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE,
+		.name = "l1_input_mode",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_input_mode_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF,
+		.name = "l1_rgb_to_y_coef",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_rgb_to_y_coef_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE,
+		.name = "l1_ag_mode",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_ag_mode_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG,
+		.name = "l1_ag",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_ag_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE,
+		.name = "l1_hdre",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_hdre_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION,
+		.name = "l1_img_extraction",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_img_extraction_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC,
+		.name = "l1_dpc",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_dpc_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE,
+		.name = "l1_preset_white_balance",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_preset_white_balance_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION,
+		.name = "l1_raw_color_noise_reduction",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_raw_color_noise_reduction_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS,
+		.name = "l1_set_hdrs",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_hdrs_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION,
+		.name = "l1_black_level_correction",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_black_level_correction_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC,
+		.name = "l1_lsc",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_lsc_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS,
+		.name = "l1_main_process",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_main_process_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB,
+		.name = "l1_awb",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_awb_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN,
+		.name = "l1_lock_awb_gain",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(u32),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC,
+		.name = "l1_hdrc",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_hdrc_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM,
+		.name = "l1_hdrc_ltm",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_hdrc_ltm_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA,
+		.name = "l1_gamma",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_gamma_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT,
+		.name = "l1_img_quality_adjustment",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_img_quality_adjustment_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION,
+		.name = "l1_avg_lum",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l1_avg_lum_generation_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST,
+		.name = "l2_undist",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l2_undist_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI,
+		.name = "l2_roi",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l2_roi_config),
+	},
+	{
+		CTRL_CONFIG_DEFAULT_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA,
+		.name = "l2_gamma",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_l2_gamma_config),
+	},
+	{
+		CTRL_CONFIG_RDONLY_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS,
+		.name = "csi2rx_calibration_status",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_csi2rx_dphy_calibration_status),
+	},
+	{
+		CTRL_CONFIG_RDONLY_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS,
+		.name = "csi2rx_err_status",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_csi2rx_err_status),
+	},
+	{
+		CTRL_CONFIG_RDONLY_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS,
+		.name = "last_capture_status",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_isp_capture_status),
+	},
+	{
+		CTRL_CONFIG_RDONLY_ENTRY,
+		.id = V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS,
+		.name = "reported errors",
+		.p_def = { .p_const = NULL },
+		.elem_size = sizeof(struct viif_reported_errors),
+	},
+};
+
+int visconti_viif_isp_init_controls(struct viif_device *viif_dev)
+{
+	struct v4l2_ctrl_handler *ctrl_handler = &viif_dev->isp_subdev.ctrl_handler;
+	int ret;
+	int i;
+
+	ret = v4l2_ctrl_handler_init(ctrl_handler, 10);
+	if (ret) {
+		dev_err(viif_dev->dev, "failed on v4l2_ctrl_handler_init");
+		return ret;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(visconti_viif_isp_ctrl_config); i++) {
+		struct v4l2_ctrl *ctrl;
+
+		ctrl = v4l2_ctrl_new_custom(ctrl_handler, &visconti_viif_isp_ctrl_config[i],
+					    viif_dev);
+		if (!ctrl) {
+			dev_err(viif_dev->dev, "failed to add ctrl crop: %d", ctrl_handler->error);
+			return ctrl_handler->error;
+		}
+	}
+
+	viif_dev->isp_subdev.sd.ctrl_handler = &viif_dev->isp_subdev.ctrl_handler;
+	return 0;
+}
diff --git a/drivers/media/platform/visconti/viif_isp.c b/drivers/media/platform/visconti/viif_isp.c
new file mode 100644
index 000000000..6ef21f60b
--- /dev/null
+++ b/drivers/media/platform/visconti/viif_isp.c
@@ -0,0 +1,852 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#include <media/v4l2-common.h>
+#include <media/v4l2-subdev.h>
+
+#include "viif.h"
+
+/* ----- supported MBUS formats ----- */
+struct visconti_mbus_format {
+	unsigned int code;
+	unsigned int bpp;
+	int rgb_out;
+} static visconti_mbus_formats[] = {
+	{ .code = MEDIA_BUS_FMT_RGB888_1X24, .bpp = 24, .rgb_out = 1 },
+	{ .code = MEDIA_BUS_FMT_UYVY8_1X16, .bpp = 16, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_UYVY10_1X20, .bpp = 20, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_RGB565_1X16, .bpp = 16, .rgb_out = 1 },
+	{ .code = MEDIA_BUS_FMT_SBGGR8_1X8, .bpp = 8, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGBRG8_1X8, .bpp = 8, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGRBG8_1X8, .bpp = 8, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SRGGB8_1X8, .bpp = 8, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SRGGB10_1X10, .bpp = 10, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGRBG10_1X10, .bpp = 10, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGBRG10_1X10, .bpp = 10, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SBGGR10_1X10, .bpp = 10, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SRGGB12_1X12, .bpp = 12, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGRBG12_1X12, .bpp = 12, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGBRG12_1X12, .bpp = 12, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SBGGR12_1X12, .bpp = 12, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SRGGB14_1X14, .bpp = 14, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGRBG14_1X14, .bpp = 14, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SGBRG14_1X14, .bpp = 14, .rgb_out = 0 },
+	{ .code = MEDIA_BUS_FMT_SBGGR14_1X14, .bpp = 14, .rgb_out = 0 },
+};
+
+static int viif_get_mbus_rgb_out(unsigned int mbus_code)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(visconti_mbus_formats); i++)
+		if (visconti_mbus_formats[i].code == mbus_code)
+			return visconti_mbus_formats[i].rgb_out;
+
+	/* YUV intermediate code by default */
+	return 0;
+}
+
+static unsigned int viif_get_mbus_bpp(unsigned int mbus_code)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(visconti_mbus_formats); i++)
+		if (visconti_mbus_formats[i].code == mbus_code)
+			return visconti_mbus_formats[i].bpp;
+
+	/* default bpp value */
+	return 24;
+}
+
+static bool viif_is_valid_mbus_code(unsigned int mbus_code)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(visconti_mbus_formats); i++)
+		if (visconti_mbus_formats[i].code == mbus_code)
+			return true;
+	return false;
+}
+
+/* ----- handling main processing path ----- */
+static int viif_get_dv_timings(struct viif_device *viif_dev, struct v4l2_dv_timings *timings)
+{
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct v4l2_subdev_pad_config pad_cfg;
+	struct v4l2_subdev_state pad_state = {
+		.pads = &pad_cfg,
+	};
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad = 0,
+	};
+	struct v4l2_ctrl *ctrl;
+	int ret;
+
+	/* some video I/F support dv_timings query */
+	ret = v4l2_subdev_call(viif_sd->v4l2_sd, video, g_dv_timings, timings);
+	if (ret == 0)
+		return 0;
+
+	/* others: call some discrete APIs */
+	ret = v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_fmt, &pad_state, &format);
+	if (ret != 0)
+		return ret;
+
+	timings->bt.width = format.format.width;
+	timings->bt.height = format.format.height;
+
+	ctrl = v4l2_ctrl_find(viif_sd->v4l2_sd->ctrl_handler, V4L2_CID_HBLANK);
+	if (!ctrl) {
+		dev_err(viif_dev->dev, "subdev: V4L2_CID_VBLANK error.\n");
+		return -EINVAL;
+	}
+	timings->bt.hsync = v4l2_ctrl_g_ctrl(ctrl);
+
+	ctrl = v4l2_ctrl_find(viif_sd->v4l2_sd->ctrl_handler, V4L2_CID_VBLANK);
+	if (!ctrl) {
+		dev_err(viif_dev->dev, "subdev: V4L2_CID_VBLANK error.\n");
+		return -EINVAL;
+	}
+	timings->bt.vsync = v4l2_ctrl_g_ctrl(ctrl);
+
+	ctrl = v4l2_ctrl_find(viif_sd->v4l2_sd->ctrl_handler, V4L2_CID_PIXEL_RATE);
+	if (!ctrl) {
+		dev_err(viif_dev->dev, "subdev: V4L2_CID_PIXEL_RATE error.\n");
+		return -EINVAL;
+	}
+	timings->bt.pixelclock = v4l2_ctrl_g_ctrl_int64(ctrl);
+
+	return 0;
+}
+
+/*TODO: should be moved below visconti_viif_isp_s_stream()?? */
+int visconti_viif_isp_main_set_unit(struct viif_device *viif_dev)
+{
+	unsigned int dt_image, color_type, rawpack, yuv_conv;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct hwd_viif_input_img in_img_main;
+	struct viif_l2_undist undist = { 0 };
+	struct v4l2_dv_timings timings;
+	struct v4l2_subdev_format fmt = {
+		.pad = 0,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	int mag_hactive = 1;
+	int ret = 0;
+
+	ret = viif_get_dv_timings(viif_dev, &timings);
+	if (ret) {
+		dev_err(viif_dev->dev, "could not get timing information of subdev");
+		return -EINVAL;
+	}
+
+	ret = v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_fmt, NULL, &fmt);
+	if (ret) {
+		dev_err(viif_dev->dev, "could not get pad information of subdev");
+		return -EINVAL;
+	}
+
+	switch (fmt.format.code) {
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		dt_image = VISCONTI_CSI2_DT_RGB888;
+		break;
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+		dt_image = VISCONTI_CSI2_DT_YUV4228B;
+		break;
+	case MEDIA_BUS_FMT_UYVY10_1X20:
+		dt_image = VISCONTI_CSI2_DT_YUV42210B;
+		break;
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		dt_image = VISCONTI_CSI2_DT_RGB565;
+		break;
+	case MEDIA_BUS_FMT_SBGGR8_1X8:
+	case MEDIA_BUS_FMT_SGBRG8_1X8:
+	case MEDIA_BUS_FMT_SGRBG8_1X8:
+	case MEDIA_BUS_FMT_SRGGB8_1X8:
+		dt_image = VISCONTI_CSI2_DT_RAW8;
+		break;
+	case MEDIA_BUS_FMT_SRGGB10_1X10:
+	case MEDIA_BUS_FMT_SGRBG10_1X10:
+	case MEDIA_BUS_FMT_SGBRG10_1X10:
+	case MEDIA_BUS_FMT_SBGGR10_1X10:
+		dt_image = VISCONTI_CSI2_DT_RAW10;
+		break;
+	case MEDIA_BUS_FMT_SRGGB12_1X12:
+	case MEDIA_BUS_FMT_SGRBG12_1X12:
+	case MEDIA_BUS_FMT_SGBRG12_1X12:
+	case MEDIA_BUS_FMT_SBGGR12_1X12:
+		dt_image = VISCONTI_CSI2_DT_RAW12;
+		break;
+	case MEDIA_BUS_FMT_SRGGB14_1X14:
+	case MEDIA_BUS_FMT_SGRBG14_1X14:
+	case MEDIA_BUS_FMT_SGBRG14_1X14:
+	case MEDIA_BUS_FMT_SBGGR14_1X14:
+		dt_image = VISCONTI_CSI2_DT_RAW14;
+		break;
+	default:
+		dt_image = VISCONTI_CSI2_DT_RGB888;
+		break;
+	}
+
+	color_type = dt_image;
+
+	if (color_type == VISCONTI_CSI2_DT_RAW8 || color_type == VISCONTI_CSI2_DT_RAW10 ||
+	    color_type == VISCONTI_CSI2_DT_RAW12) {
+		rawpack = viif_dev->rawpack_mode;
+		if (rawpack != HWD_VIIF_RAWPACK_DISABLE)
+			mag_hactive = 2;
+	} else {
+		rawpack = HWD_VIIF_RAWPACK_DISABLE;
+	}
+
+	if (color_type == VISCONTI_CSI2_DT_YUV4228B || color_type == VISCONTI_CSI2_DT_YUV42210B)
+		yuv_conv = HWD_VIIF_YUV_CONV_INTERPOLATION;
+	else
+		yuv_conv = HWD_VIIF_YUV_CONV_REPEAT;
+
+	in_img_main.hactive_size = timings.bt.width;
+	in_img_main.vactive_size = timings.bt.height;
+	in_img_main.htotal_size = timings.bt.width * mag_hactive + timings.bt.hsync;
+	in_img_main.vtotal_size = timings.bt.height + timings.bt.vsync;
+	in_img_main.pixel_clock = timings.bt.pixelclock / 1000;
+	in_img_main.vbp_size = timings.bt.vsync - 5;
+
+	in_img_main.interpolation_mode = HWD_VIIF_L1_INPUT_INTERPOLATION_LINE;
+	in_img_main.input_num = 1;
+	in_img_main.hobc_width = 0;
+	in_img_main.hobc_margin = 0;
+
+	/* configuration of MAIN unit */
+	ret = hwd_viif_main_set_unit(viif_dev->ch, dt_image, &in_img_main, color_type, rawpack,
+				     yuv_conv);
+	if (ret) {
+		dev_err(viif_dev->dev, "main_set_unit error. %d\n", ret);
+		return ret;
+	}
+
+	/* Enable regbuf */
+	hwd_viif_isp_set_regbuf_auto_transmission(viif_dev->ch);
+
+	/* L2 UNDIST Enable through mode as default  */
+	undist.through_mode = HWD_VIIF_ENABLE;
+	undist.sensor_crop_ofs_h = 1 - in_img_main.hactive_size;
+	undist.sensor_crop_ofs_v = 1 - in_img_main.vactive_size;
+	undist.grid_node_num_h = 16;
+	undist.grid_node_num_v = 16;
+	ret = hwd_viif_l2_set_undist(viif_dev->ch, &undist);
+	if (ret)
+		dev_err(viif_dev->dev, "l2_set_undist error. %d\n", ret);
+	return ret;
+}
+
+static unsigned int dt_image_from_mbus_code(unsigned int mbus_code)
+{
+	switch (mbus_code) {
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		return VISCONTI_CSI2_DT_RGB888;
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+		return VISCONTI_CSI2_DT_YUV4228B;
+	case MEDIA_BUS_FMT_UYVY10_1X20:
+		return VISCONTI_CSI2_DT_YUV42210B;
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		return VISCONTI_CSI2_DT_RGB565;
+	case MEDIA_BUS_FMT_SBGGR8_1X8:
+	case MEDIA_BUS_FMT_SGBRG8_1X8:
+	case MEDIA_BUS_FMT_SGRBG8_1X8:
+	case MEDIA_BUS_FMT_SRGGB8_1X8:
+		return VISCONTI_CSI2_DT_RAW8;
+	case MEDIA_BUS_FMT_SRGGB10_1X10:
+	case MEDIA_BUS_FMT_SGRBG10_1X10:
+	case MEDIA_BUS_FMT_SGBRG10_1X10:
+	case MEDIA_BUS_FMT_SBGGR10_1X10:
+		return VISCONTI_CSI2_DT_RAW10;
+	case MEDIA_BUS_FMT_SRGGB12_1X12:
+	case MEDIA_BUS_FMT_SGRBG12_1X12:
+	case MEDIA_BUS_FMT_SGBRG12_1X12:
+	case MEDIA_BUS_FMT_SBGGR12_1X12:
+		return VISCONTI_CSI2_DT_RAW12;
+	case MEDIA_BUS_FMT_SRGGB14_1X14:
+	case MEDIA_BUS_FMT_SGRBG14_1X14:
+	case MEDIA_BUS_FMT_SGBRG14_1X14:
+	case MEDIA_BUS_FMT_SBGGR14_1X14:
+		return VISCONTI_CSI2_DT_RAW14;
+	default:
+		return VISCONTI_CSI2_DT_RGB888;
+	}
+}
+
+int visconti_viif_isp_sub_set_unit(struct viif_device *viif_dev)
+{
+	struct hwd_viif_input_img in_img_sub;
+	struct v4l2_dv_timings timings;
+	struct v4l2_subdev_format fmt = {
+		.pad = 0,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	unsigned int dt_image;
+	int ret;
+
+	ret = viif_get_dv_timings(viif_dev, &timings);
+	if (ret)
+		return -EINVAL;
+
+	ret = v4l2_subdev_call(viif_dev->sd->v4l2_sd, pad, get_fmt, NULL, &fmt);
+	if (ret) {
+		dev_err(viif_dev->dev, "could not get pad information of subdev");
+		return -EINVAL;
+	}
+
+	dt_image = dt_image_from_mbus_code(fmt.format.code);
+
+	in_img_sub.hactive_size = 0;
+	in_img_sub.vactive_size = timings.bt.height;
+	in_img_sub.htotal_size = timings.bt.width + timings.bt.hsync;
+	in_img_sub.vtotal_size = timings.bt.height + timings.bt.vsync;
+	in_img_sub.pixel_clock = timings.bt.pixelclock / 1000;
+	in_img_sub.vbp_size = timings.bt.vsync - 5;
+	in_img_sub.interpolation_mode = HWD_VIIF_L1_INPUT_INTERPOLATION_LINE;
+	in_img_sub.input_num = 1;
+	in_img_sub.hobc_width = 0;
+	in_img_sub.hobc_margin = 0;
+
+	ret = hwd_viif_sub_set_unit(viif_dev->ch, dt_image, &in_img_sub);
+	if (ret)
+		dev_err(viif_dev->dev, "sub_set_unit error. %d\n", ret);
+
+	return ret;
+};
+
+/* ----- handling CSI2RX hardware ----- */
+static int viif_csi2rx_initialize(struct viif_device *viif_dev)
+{
+	struct hwd_viif_csi2rx_line_err_target err_target = { 0 };
+	struct hwd_viif_csi2rx_irq_mask csi2rx_mask;
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct v4l2_mbus_config cfg = { 0 };
+	struct v4l2_subdev_format fmt = {
+		.pad = 0,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	struct v4l2_dv_timings timings;
+	int num_lane, dphy_rate;
+	int ret;
+
+	ret = v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_mbus_config, 0, &cfg);
+	if (ret) {
+		dev_dbg(viif_dev->dev, "subdev: g_mbus_config error. %d\n", ret);
+		num_lane = viif_sd->num_lane;
+	} else {
+		switch (cfg.flags & V4L2_MBUS_CSI2_LANES) {
+		case V4L2_MBUS_CSI2_1_LANE:
+			num_lane = 1;
+			break;
+		case V4L2_MBUS_CSI2_2_LANE:
+			num_lane = 2;
+			break;
+		case V4L2_MBUS_CSI2_3_LANE:
+			num_lane = 3;
+			break;
+		case V4L2_MBUS_CSI2_4_LANE:
+			num_lane = 4;
+			break;
+		default:
+			num_lane = 4;
+			break;
+		}
+	}
+
+	ret = v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_fmt, 0, &fmt);
+	if (ret)
+		return -EINVAL;
+
+	ret = viif_get_dv_timings(viif_dev, &timings);
+	if (ret)
+		return -EINVAL;
+
+	dphy_rate = (timings.bt.pixelclock / 1000) * viif_get_mbus_bpp(fmt.format.code) / num_lane;
+	dphy_rate = dphy_rate / 1000;
+
+	/* check error for CH0: all supported DTs */
+	err_target.dt[0] = VISCONTI_CSI2_DT_RGB565;
+	err_target.dt[1] = VISCONTI_CSI2_DT_YUV4228B;
+	err_target.dt[2] = VISCONTI_CSI2_DT_YUV42210B;
+	err_target.dt[3] = VISCONTI_CSI2_DT_RGB888;
+	err_target.dt[4] = VISCONTI_CSI2_DT_RAW8;
+	err_target.dt[5] = VISCONTI_CSI2_DT_RAW10;
+	err_target.dt[6] = VISCONTI_CSI2_DT_RAW12;
+	err_target.dt[7] = VISCONTI_CSI2_DT_RAW14;
+
+	/* Define errors to be masked */
+	csi2rx_mask.mask[0] = 0x0000000F; /*check all for PHY_FATAL*/
+	csi2rx_mask.mask[1] = 0x0001000F; /*check all for PKT_FATAL*/
+	csi2rx_mask.mask[2] = 0x000F0F0F; /*check all for FRAME_FATAL*/
+	csi2rx_mask.mask[3] = 0x000F000F; /*check all for PHY*/
+	csi2rx_mask.mask[4] = 0x000F000F; /*check all for PKT*/
+	csi2rx_mask.mask[5] = 0x00FF00FF; /*check all for LINE*/
+
+	return hwd_viif_csi2rx_initialize(viif_dev->ch, num_lane, HWD_VIIF_CSI2_DPHY_L0L1L2L3,
+					  dphy_rate, HWD_VIIF_ENABLE, &err_target,
+					  HWD_VIIF_CSI2_INPUT_OWN, &csi2rx_mask);
+}
+
+static int viif_csi2rx_start(struct viif_device *viif_dev)
+{
+	struct hwd_viif_csi2rx_packet packet = { 0 };
+	u32 vc_main = 0;
+	u32 vc_sub = 0;
+
+	viif_dev->masked_gamma_path = 0U;
+
+	return hwd_viif_csi2rx_start(viif_dev->ch, vc_main, vc_sub, &packet, HWD_VIIF_DISABLE);
+}
+
+static int viif_csi2rx_stop(struct viif_device *viif_dev)
+{
+	s32 ret;
+
+	ret = hwd_viif_csi2rx_stop(viif_dev->ch);
+	if (ret)
+		dev_err(viif_dev->dev, "csi2rx_stop error. %d\n", ret);
+
+	hwd_viif_csi2rx_uninitialize(viif_dev->ch);
+
+	return ret;
+}
+
+/* ----- subdevice video operations ----- */
+static int visconti_viif_isp_s_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	int ret;
+
+	if (enable) {
+		ret = viif_csi2rx_initialize(viif_dev);
+		if (ret)
+			return ret;
+		return viif_csi2rx_start(viif_dev);
+	} else {
+		return viif_csi2rx_stop(viif_dev);
+	}
+}
+
+/* ----- subdevice pad operations ----- */
+static int visconti_viif_isp_enum_mbus_code(struct v4l2_subdev *sd,
+					    struct v4l2_subdev_state *sd_state,
+					    struct v4l2_subdev_mbus_code_enum *code)
+{
+	if (code->pad == 0) {
+		/* sink */
+		if (code->index > ARRAY_SIZE(visconti_mbus_formats) - 1)
+			return -EINVAL;
+		code->code = visconti_mbus_formats[code->index].code;
+		return 0;
+	}
+
+	/* source */
+	if (code->index > 0)
+		return -EINVAL;
+	code->code = MEDIA_BUS_FMT_YUV8_1X24;
+	return 0;
+}
+
+static struct v4l2_mbus_framefmt *visconti_viif_isp_get_pad_fmt(struct v4l2_subdev *sd,
+								struct v4l2_subdev_state *sd_state,
+								unsigned int pad, u32 which)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_subdev_state state = {
+		.pads = viif_dev->isp_subdev.pad_cfg,
+	};
+
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state, pad);
+	else
+		return v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, &state, pad);
+}
+
+static struct v4l2_rect *visconti_viif_isp_get_pad_crop(struct v4l2_subdev *sd,
+							struct v4l2_subdev_state *sd_state,
+							unsigned int pad, u32 which)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_subdev_state state = {
+		.pads = viif_dev->isp_subdev.pad_cfg,
+	};
+
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd, sd_state, pad);
+	else
+		return v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd, &state, pad);
+}
+
+static struct v4l2_rect *visconti_viif_isp_get_pad_compose(struct v4l2_subdev *sd,
+							   struct v4l2_subdev_state *sd_state,
+							   unsigned int pad, u32 which)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_subdev_state state = {
+		.pads = viif_dev->isp_subdev.pad_cfg,
+	};
+
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_compose(&viif_dev->isp_subdev.sd, sd_state, pad);
+	else
+		return v4l2_subdev_get_try_compose(&viif_dev->isp_subdev.sd, &state, pad);
+}
+
+static int visconti_viif_isp_get_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *sd_state,
+				     struct v4l2_subdev_format *fmt)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+
+	mutex_lock(&viif_dev->isp_subdev.ops_lock);
+	fmt->format = *visconti_viif_isp_get_pad_fmt(sd, sd_state, fmt->pad, fmt->which);
+	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
+
+	return 0;
+}
+
+static void visconti_viif_isp_set_sink_fmt(struct v4l2_subdev *sd,
+					   struct v4l2_subdev_state *sd_state,
+					   struct v4l2_mbus_framefmt *format, u32 which)
+{
+	struct v4l2_mbus_framefmt *sink_fmt, *src0_fmt, *src1_fmt, *src2_fmt;
+
+	sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SINK, which);
+	src0_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SRC_PATH0, which);
+	src1_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SRC_PATH1, which);
+	src2_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SRC_PATH2, which);
+
+	/* update mbus code only if it's available */
+	if (viif_is_valid_mbus_code(format->code))
+		sink_fmt->code = format->code;
+
+	/* sink::mbus_code is derived from src::mbus_code */
+	if (viif_get_mbus_rgb_out(sink_fmt->code)) {
+		src0_fmt->code = MEDIA_BUS_FMT_RGB888_1X24;
+		src1_fmt->code = MEDIA_BUS_FMT_RGB888_1X24;
+	} else {
+		src0_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+		src1_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+	}
+
+	/* SRC2 (RAW output) follows SINK format */
+	src2_fmt->code = format->code;
+	src2_fmt->width = format->width;
+	src2_fmt->height = format->height;
+
+	/* size check */
+	sink_fmt->width = format->width;
+	sink_fmt->height = format->height;
+
+	*format = *sink_fmt;
+}
+
+static void visconti_viif_isp_set_src_fmt(struct v4l2_subdev *sd,
+					  struct v4l2_subdev_state *sd_state,
+					  struct v4l2_mbus_framefmt *format, unsigned int pad,
+					  u32 which)
+{
+	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
+	struct v4l2_rect *src_crop;
+
+	sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SINK,
+						 V4L2_SUBDEV_FORMAT_ACTIVE);
+	src_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, pad, which);
+	src_crop = visconti_viif_isp_get_pad_crop(sd, sd_state, pad, which);
+
+	/* sink::mbus_code is derived from src::mbus_code */
+	if (viif_get_mbus_rgb_out(sink_fmt->code))
+		src_fmt->code = MEDIA_BUS_FMT_RGB888_1X24;
+	else
+		src_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+
+	/*size check*/
+	src_fmt->width = format->width;
+	src_fmt->height = format->height;
+
+	/*update crop*/
+	src_crop->width = format->width;
+	src_crop->height = format->height;
+
+	*format = *src_fmt;
+}
+
+static void visconti_viif_isp_set_src_fmt_rawpath(struct v4l2_subdev *sd,
+						  struct v4l2_subdev_state *sd_state,
+						  struct v4l2_mbus_framefmt *format,
+						  unsigned int pad, u32 which)
+{
+	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
+
+	sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SINK,
+						 V4L2_SUBDEV_FORMAT_ACTIVE);
+	src_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, pad, which);
+
+	/* RAWPATH SRC pad has just the same configuration as SINK pad */
+	src_fmt->code = sink_fmt->code;
+	src_fmt->width = sink_fmt->width;
+	src_fmt->height = sink_fmt->height;
+
+	*format = *src_fmt;
+}
+
+static int visconti_viif_isp_set_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *sd_state,
+				     struct v4l2_subdev_format *fmt)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+
+	mutex_lock(&viif_dev->isp_subdev.ops_lock);
+
+	if (fmt->pad == VIIF_ISP_PAD_SINK)
+		visconti_viif_isp_set_sink_fmt(sd, sd_state, &fmt->format, fmt->which);
+	else if (fmt->pad == VIIF_ISP_PAD_SRC_PATH2)
+		visconti_viif_isp_set_src_fmt_rawpath(sd, sd_state, &fmt->format, fmt->pad,
+						      fmt->which);
+	else
+		visconti_viif_isp_set_src_fmt(sd, sd_state, &fmt->format, fmt->pad, fmt->which);
+
+	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
+
+	return 0;
+}
+
+#define VISCONTI_VIIF_ISP_DEFAULT_WIDTH 1920
+#define VISCONTI_VIIF_ISP_DEFAULT_HEIGHT 1080
+#define VISCONTI_VIIF_MAX_COMPOSED_WIDTH 8190
+#define VISCONTI_VIIF_MAX_COMPOSED_HEIGHT 4094
+
+static int visconti_viif_isp_init_config(struct v4l2_subdev *sd, struct v4l2_subdev_state *sd_state)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
+	struct v4l2_rect *src_crop, *sink_compose;
+
+	sink_fmt =
+		v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state, VIIF_ISP_PAD_SINK);
+	sink_fmt->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	sink_fmt->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+	sink_fmt->field = V4L2_FIELD_NONE;
+	sink_fmt->code = MEDIA_BUS_FMT_SRGGB10_1X10;
+
+	sink_compose =
+		v4l2_subdev_get_try_compose(&viif_dev->isp_subdev.sd, sd_state, VIIF_ISP_PAD_SINK);
+	sink_compose->top = 0;
+	sink_compose->left = 0;
+	sink_compose->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	sink_compose->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+
+	src_fmt = v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state,
+					     VIIF_ISP_PAD_SRC_PATH0);
+	src_fmt->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_fmt->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+	src_fmt->field = V4L2_FIELD_NONE;
+	src_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+
+	src_crop = v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd, sd_state,
+					    VIIF_ISP_PAD_SRC_PATH0);
+	src_crop->top = 0;
+	src_crop->left = 0;
+	src_crop->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_crop->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+
+	src_fmt = v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state,
+					     VIIF_ISP_PAD_SRC_PATH1);
+	src_fmt->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_fmt->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+	src_fmt->field = V4L2_FIELD_NONE;
+	src_fmt->code = MEDIA_BUS_FMT_YUV8_1X24;
+
+	src_crop = v4l2_subdev_get_try_crop(&viif_dev->isp_subdev.sd, sd_state,
+					    VIIF_ISP_PAD_SRC_PATH1);
+	src_crop->top = 0;
+	src_crop->left = 0;
+	src_crop->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_crop->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+
+	src_fmt = v4l2_subdev_get_try_format(&viif_dev->isp_subdev.sd, sd_state,
+					     VIIF_ISP_PAD_SRC_PATH2);
+	src_fmt->width = VISCONTI_VIIF_ISP_DEFAULT_WIDTH;
+	src_fmt->height = VISCONTI_VIIF_ISP_DEFAULT_HEIGHT;
+	src_fmt->field = V4L2_FIELD_NONE;
+	src_fmt->code = MEDIA_BUS_FMT_SRGGB10_1X10;
+
+	return 0;
+}
+
+static int visconti_viif_isp_get_selection(struct v4l2_subdev *sd,
+					   struct v4l2_subdev_state *sd_state,
+					   struct v4l2_subdev_selection *sel)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_mbus_framefmt *sink_fmt;
+	int ret = -EINVAL;
+
+	mutex_lock(&viif_dev->isp_subdev.ops_lock);
+	if (sel->pad == VIIF_ISP_PAD_SINK) {
+		/* SINK PAD */
+		switch (sel->target) {
+		case V4L2_SEL_TGT_CROP:
+			sink_fmt = visconti_viif_isp_get_pad_fmt(sd, sd_state, VIIF_ISP_PAD_SINK,
+								 sel->which);
+			sel->r.top = 0;
+			sel->r.left = 0;
+			sel->r.width = sink_fmt->width;
+			sel->r.height = sink_fmt->height;
+			ret = 0;
+			break;
+		case V4L2_SEL_TGT_COMPOSE:
+			sel->r = *visconti_viif_isp_get_pad_compose(sd, sd_state, VIIF_ISP_PAD_SINK,
+								    sel->which);
+			ret = 0;
+			break;
+		case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+			/* fixed value */
+			sel->r.top = 0;
+			sel->r.left = 0;
+			sel->r.width = VISCONTI_VIIF_MAX_COMPOSED_WIDTH;
+			sel->r.height = VISCONTI_VIIF_MAX_COMPOSED_HEIGHT;
+			ret = 0;
+			break;
+		}
+	} else if ((sel->pad == VIIF_ISP_PAD_SRC_PATH0) || (sel->pad == VIIF_ISP_PAD_SRC_PATH1)) {
+		/* SRC PAD */
+		switch (sel->target) {
+		case V4L2_SEL_TGT_CROP:
+			sel->r =
+				*visconti_viif_isp_get_pad_crop(sd, sd_state, sel->pad, sel->which);
+			ret = 0;
+			break;
+		}
+	}
+	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
+
+	return ret;
+}
+
+static int visconti_viif_isp_set_selection(struct v4l2_subdev *sd,
+					   struct v4l2_subdev_state *sd_state,
+					   struct v4l2_subdev_selection *sel)
+{
+	struct viif_device *viif_dev = ((struct isp_subdev *)sd)->viif_dev;
+	struct v4l2_mbus_framefmt *sink_fmt;
+	struct v4l2_rect *rect;
+	int ret = -EINVAL;
+
+	mutex_lock(&viif_dev->isp_subdev.ops_lock);
+	/* only source::selection::crop is writable */
+	if (sel->pad == VIIF_ISP_PAD_SRC_PATH0 || sel->pad == VIIF_ISP_PAD_SRC_PATH1) {
+		switch (sel->target) {
+		case V4L2_SEL_TGT_CROP: {
+			/* TODO: validation */
+			rect = visconti_viif_isp_get_pad_crop(sd, sd_state, sel->pad, sel->which);
+			*rect = sel->r;
+			sink_fmt =
+				visconti_viif_isp_get_pad_fmt(sd, sd_state, sel->pad, sel->which);
+			sink_fmt->width = sel->r.width;
+			sink_fmt->height = sel->r.height;
+			ret = 0;
+			break;
+		}
+		}
+	}
+	mutex_unlock(&viif_dev->isp_subdev.ops_lock);
+
+	return ret;
+}
+
+void visconti_viif_isp_set_compose_rect(struct viif_device *viif_dev,
+					struct viif_l2_roi_config *roi)
+{
+	struct v4l2_rect *rect;
+
+	rect = visconti_viif_isp_get_pad_compose(&viif_dev->isp_subdev.sd, NULL, VIIF_ISP_PAD_SINK,
+						 V4L2_SUBDEV_FORMAT_ACTIVE);
+	rect->top = 0;
+	rect->left = 0;
+	rect->width = roi->corrected_hsize[0];
+	rect->height = roi->corrected_vsize[0];
+}
+
+static const struct media_entity_operations visconti_viif_isp_media_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+static const struct v4l2_subdev_pad_ops visconti_viif_isp_pad_ops = {
+	.enum_mbus_code = visconti_viif_isp_enum_mbus_code,
+	.get_selection = visconti_viif_isp_get_selection,
+	.set_selection = visconti_viif_isp_set_selection,
+	.init_cfg = visconti_viif_isp_init_config,
+	.get_fmt = visconti_viif_isp_get_fmt,
+	.set_fmt = visconti_viif_isp_set_fmt,
+	.link_validate = v4l2_subdev_link_validate_default,
+};
+
+static const struct v4l2_subdev_video_ops visconti_viif_isp_video_ops = {
+	.s_stream = visconti_viif_isp_s_stream,
+};
+
+static const struct v4l2_subdev_ops visconti_viif_isp_ops = {
+	.video = &visconti_viif_isp_video_ops,
+	.pad = &visconti_viif_isp_pad_ops,
+};
+
+/* ----- register/remove isp subdevice node ----- */
+int visconti_viif_isp_register(struct viif_device *viif_dev)
+{
+	struct v4l2_subdev_state state = {
+		.pads = viif_dev->isp_subdev.pad_cfg,
+	};
+	struct media_pad *pads = viif_dev->isp_subdev.pads;
+	struct v4l2_subdev *sd = &viif_dev->isp_subdev.sd;
+	int ret;
+
+	viif_dev->isp_subdev.viif_dev = viif_dev;
+
+	v4l2_subdev_init(sd, &visconti_viif_isp_ops);
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	sd->entity.ops = &visconti_viif_isp_media_ops;
+	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_SCALER;
+	sd->owner = THIS_MODULE;
+	strscpy(sd->name, "visconti-viif:isp", sizeof(sd->name));
+
+	pads[0].flags = MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
+	pads[1].flags = MEDIA_PAD_FL_SOURCE | MEDIA_PAD_FL_MUST_CONNECT;
+	pads[2].flags = MEDIA_PAD_FL_SOURCE | MEDIA_PAD_FL_MUST_CONNECT;
+	pads[3].flags = MEDIA_PAD_FL_SOURCE | MEDIA_PAD_FL_MUST_CONNECT;
+
+	mutex_init(&viif_dev->isp_subdev.ops_lock);
+
+	visconti_viif_isp_init_controls(viif_dev);
+
+	ret = media_entity_pads_init(&sd->entity, 4, pads);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed on media_entity_pads_init\n");
+		return ret;
+	}
+
+	ret = v4l2_device_register_subdev(&viif_dev->v4l2_dev, sd);
+	if (ret) {
+		dev_err(viif_dev->dev, "Failed to resize ISP subdev\n");
+		goto err_cleanup_media_entity;
+	}
+
+	visconti_viif_isp_init_config(sd, &state);
+
+	return 0;
+
+err_cleanup_media_entity:
+	media_entity_cleanup(&sd->entity);
+	return ret;
+}
+
+void visconti_viif_isp_unregister(struct viif_device *viif_dev)
+{
+	v4l2_device_unregister_subdev(&viif_dev->isp_subdev.sd);
+	media_entity_cleanup(&viif_dev->isp_subdev.sd.entity);
+}
diff --git a/include/uapi/linux/visconti_viif.h b/include/uapi/linux/visconti_viif.h
new file mode 100644
index 000000000..f92278425
--- /dev/null
+++ b/include/uapi/linux/visconti_viif.h
@@ -0,0 +1,1724 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Toshiba Visconti Video Capture Support
+ *
+ * (C) Copyright 2022 TOSHIBA CORPORATION
+ * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
+ */
+
+#ifndef __UAPI_VISCONTI_VIIF_H_
+#define __UAPI_VISCONTI_VIIF_H_
+
+#include <linux/types.h>
+#include <linux/videodev2.h>
+
+/* Visconti specific compound controls */
+#define V4L2_CID_VISCONTI_VIIF_BASE			       (V4L2_CID_USER_BASE + 0x1000)
+#define V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE	       (V4L2_CID_VISCONTI_VIIF_BASE + 1)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE	       (V4L2_CID_VISCONTI_VIIF_BASE + 2)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF	       (V4L2_CID_VISCONTI_VIIF_BASE + 3)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE	       (V4L2_CID_VISCONTI_VIIF_BASE + 4)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG		       (V4L2_CID_VISCONTI_VIIF_BASE + 5)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE		       (V4L2_CID_VISCONTI_VIIF_BASE + 6)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION       (V4L2_CID_VISCONTI_VIIF_BASE + 7)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC		       (V4L2_CID_VISCONTI_VIIF_BASE + 8)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE (V4L2_CID_VISCONTI_VIIF_BASE + 9)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION                                \
+	(V4L2_CID_VISCONTI_VIIF_BASE + 10)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS			 (V4L2_CID_VISCONTI_VIIF_BASE + 11)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION (V4L2_CID_VISCONTI_VIIF_BASE + 12)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC			 (V4L2_CID_VISCONTI_VIIF_BASE + 13)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS		 (V4L2_CID_VISCONTI_VIIF_BASE + 14)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB			 (V4L2_CID_VISCONTI_VIIF_BASE + 15)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_LOCK_AWB_GAIN		 (V4L2_CID_VISCONTI_VIIF_BASE + 16)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC			 (V4L2_CID_VISCONTI_VIIF_BASE + 17)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM		 (V4L2_CID_VISCONTI_VIIF_BASE + 18)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_GAMMA			 (V4L2_CID_VISCONTI_VIIF_BASE + 19)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT (V4L2_CID_VISCONTI_VIIF_BASE + 20)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION	 (V4L2_CID_VISCONTI_VIIF_BASE + 21)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST		 (V4L2_CID_VISCONTI_VIIF_BASE + 22)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI			 (V4L2_CID_VISCONTI_VIIF_BASE + 23)
+#define V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA			 (V4L2_CID_VISCONTI_VIIF_BASE + 24)
+#define V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS	 (V4L2_CID_VISCONTI_VIIF_BASE + 25)
+#define V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS		 (V4L2_CID_VISCONTI_VIIF_BASE + 26)
+#define V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS		 (V4L2_CID_VISCONTI_VIIF_BASE + 27)
+#define V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS		 (V4L2_CID_VISCONTI_VIIF_BASE + 28)
+
+/* Enable/Disable flag */
+#define VIIF_DISABLE (0U)
+#define VIIF_ENABLE  (1U)
+
+/**
+ * enum viif_rawpack_mode - RAW pack mode for ioctl(VIDIOC_VIIF_MAIN_SET_RAWPACK_MODE)
+ *
+ * @VIIF_RAWPACK_DISABLE: RAW pack disable
+ * @VIIF_RAWPACK_MSBFIRST: RAW pack enable (MSB First)
+ * @VIIF_RAWPACK_LSBFIRST: RAW pack enable (LSB First)
+ */
+enum viif_rawpack_mode {
+	VIIF_RAWPACK_DISABLE = 0,
+	VIIF_RAWPACK_MSBFIRST = 2,
+	VIIF_RAWPACK_LSBFIRST = 3,
+};
+
+/**
+ * enum viif_l1_input - L1ISP preprocessing mode
+ *
+ * @VIIF_L1_INPUT_HDR: bypass(HDR input)
+ * @VIIF_L1_INPUT_PWL: HDRE(PWL input)
+ * @VIIF_L1_INPUT_HDR_IMG_CORRECT: SLIC-ABPC-PWHB-RCNR-HDRS
+ * @VIIF_L1_INPUT_PWL_IMG_CORRECT: HDRE-SLIC-ABPC-PWHB-RCNR-HDRS
+ */
+enum viif_l1_input {
+	VIIF_L1_INPUT_HDR = 0,
+	VIIF_L1_INPUT_PWL = 1,
+	VIIF_L1_INPUT_HDR_IMG_CORRECT = 3,
+	VIIF_L1_INPUT_PWL_IMG_CORRECT = 4,
+};
+
+/**
+ * enum viif_l1_raw - L1ISP RAW color filter mode
+ *
+ * @VIIF_L1_RAW_GR_R_B_GB: Gr-R-B-Gb
+ * @VIIF_L1_RAW_R_GR_GB_B: R-Gr-Gb-B
+ * @VIIF_L1_RAW_B_GB_GR_R: B-Gb-Gr-R
+ * @VIIF_L1_RAW_GB_B_R_GR: Gb-B-R-Gr
+ */
+enum viif_l1_raw {
+	VIIF_L1_RAW_GR_R_B_GB = 0,
+	VIIF_L1_RAW_R_GR_GB_B = 1,
+	VIIF_L1_RAW_B_GB_GR_R = 2,
+	VIIF_L1_RAW_GB_B_R_GR = 3,
+};
+
+/**
+ * struct viif_l1_input_mode_config - L1ISP INPUT MODE parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_INPUT_MODE`
+ * @mode: &enum viif_l1_input value.
+ * @depth: Color depth (even only). Range for each L1ISP pre-processing mode is:
+ *
+ *  * VIIF_L1_INPUT_HDR/HDR_IMG_CORRECT: Range: [8..24].
+ *  * VIIF_L1_INPUT_PWL/PWL_IMG_CORRECT: Range: [8..14].
+ * @raw_color_filter: &enum viif_l1_raw value.
+ */
+struct viif_l1_input_mode_config {
+	__u32 mode;
+	__u32 depth;
+	__u32 raw_color_filter;
+};
+
+/**
+ * struct viif_l1_rgb_to_y_coef_config - L1ISP coefficient for calculating
+ * Y from RGB parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RGB_TO_Y_COEF`
+ * @coef_r: R co-efficient [256..65024] accuracy: 1/65536
+ * @coef_g: R co-efficient [256..65024] accuracy: 1/65536
+ * @coef_b: R co-efficient [256..65024] accuracy: 1/65536
+ */
+struct viif_l1_rgb_to_y_coef_config {
+	__u16 coef_r;
+	__u16 coef_g;
+	__u16 coef_b;
+};
+
+/**
+ * enum viif_l1_img_sensitivity_mode - L1ISP image sensitivity
+ *
+ * @VIIF_L1_IMG_SENSITIVITY_HIGH: high sensitivity
+ * @VIIF_L1_IMG_SENSITIVITY_MIDDLE_LED: middle sensitivity or led
+ * @VIIF_L1_IMG_SENSITIVITY_LOW: low sensitivity
+ */
+enum viif_l1_img_sensitivity_mode {
+	VIIF_L1_IMG_SENSITIVITY_HIGH = 0,
+	VIIF_L1_IMG_SENSITIVITY_MIDDLE_LED = 1,
+	VIIF_L1_IMG_SENSITIVITY_LOW = 2,
+};
+
+/**
+ * struct viif_l1_ag_mode_config - L1ISP AG mode parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG_MODE`
+ * @sysm_ag_grad: Analog gain slope [0..255] (element is id)
+ * @sysm_ag_ofst: Analog gain offset [0..65535] (element is id)
+ * @sysm_ag_cont_hobc_en_high: 1:enable/0:disable to control analog gain
+ *                             for high sensitivity image of OBCC
+ * @sysm_ag_psel_hobc_high: Analog gain id for high sensitivity image of OBCC [0..3]
+ * @sysm_ag_cont_hobc_en_middle_led: 1:enable/0:disable to control analog gain
+ *                                   for middle sensitivity or LED image of OBCC
+ * @sysm_ag_psel_hobc_middle_led: Analog gain id for middle sensitivity
+ *                                or LED image of OBCC [0..3]
+ * @sysm_ag_cont_hobc_en_low: 1:enable/0:disable to control analog gain
+ *                            for low sensitivity image of OBCC
+ * @sysm_ag_psel_hobc_low: Analog gain id for low sensitivity image of OBCC [0..3]
+ * @sysm_ag_cont_abpc_en_high: 1:enable/0:disable to control analog gain
+ *                             for high sensitivity image of ABPC
+ * @sysm_ag_psel_abpc_high: Analog gain id for high sensitivity image of ABPC [0..3]
+ * @sysm_ag_cont_abpc_en_middle_led: 1:enable/0:disable to control analog gain
+ *                                   for middle sensitivity or LED image of ABPC
+ * @sysm_ag_psel_abpc_middle_led: Analog gain id for middle sensitivity
+ *                                or LED image of ABPC [0..3]
+ * @sysm_ag_cont_abpc_en_low: 1:enable/0:disable to control analog gain
+ *                            for low sensitivity image of ABPC
+ * @sysm_ag_psel_abpc_low: Analog gain id for low sensitivity image of ABPC [0..3]
+ * @sysm_ag_cont_rcnr_en_high: 1:enable/0:disable to control analog gain
+ *                             for high sensitivity image of RCNR
+ * @sysm_ag_psel_rcnr_high: Analog gain id for high sensitivity image of RCNR [0..3]
+ * @sysm_ag_cont_rcnr_en_middle_led: 1:enable/0:disable to control analog gain
+ *                                   for middle sensitivity or LED image of RCNR
+ * @sysm_ag_psel_rcnr_middle_led: Analog gain id for middle sensitivity
+ *                                or LED image of RCNR [0..3]
+ * @sysm_ag_cont_rcnr_en_low: 1:enable/0:disable to control analog gain
+ *                            for low sensitivity image of RCNR
+ * @sysm_ag_psel_rcnr_low: Analog gain id for low sensitivity image of RCNR [0..3]
+ * @sysm_ag_cont_lssc_en: 1:enable/0:disable to control analog gain for LSC
+ * @sysm_ag_ssel_lssc: &enum viif_l1_img_sensitivity_mode value. Sensitive image used for LSC.
+ * @sysm_ag_psel_lssc: Analog gain id for LSC [0..3]
+ * @sysm_ag_cont_mpro_en: 1:enable/0:disable to control analog gain for color matrix
+ * @sysm_ag_ssel_mpro: &enum viif_l1_img_sensitivity_mode value.
+ *                     Sensitive image used for color matrix.
+ * @sysm_ag_psel_mpro:Aanalog gain id for color matrix [0..3]
+ * @sysm_ag_cont_vpro_en: 1:enable/0:disable to control analog gain for image adjustment
+ * @sysm_ag_ssel_vpro: &enum viif_l1_img_sensitivity_mode value.
+ *                     Sensitive image used for image adjustment.
+ * @sysm_ag_psel_vpro: Analog gain id for image adjustment [0..3]
+ * @sysm_ag_cont_hobc_test_high: Manual analog gain for high sensitivity image
+ *                               of OBCC [0..255]
+ * @sysm_ag_cont_hobc_test_middle_led: Manual analog gain for middle sensitivity
+ *                                     or led image of OBCC [0..255]
+ * @sysm_ag_cont_hobc_test_low: Manual analog gain for low sensitivity image
+ *                              of OBCC [0..255]
+ * @sysm_ag_cont_abpc_test_high: Manual analog gain for high sensitivity image
+ *                               of ABPC [0..255]
+ * @sysm_ag_cont_abpc_test_middle_led: Manual analog gain for middle sensitivity
+ *                                     or led image of ABPC [0..255]
+ * @sysm_ag_cont_abpc_test_low: Manual analog gain for low sensitivity image
+ *                              of ABPC [0..255]
+ * @sysm_ag_cont_rcnr_test_high: Manual analog gain for high sensitivity image
+ *                               of RCNR [0..255]
+ * @sysm_ag_cont_rcnr_test_middle_led: Manual analog gain for middle sensitivity
+ *                                     or led image of RCNR [0..255]
+ * @sysm_ag_cont_rcnr_test_low: Manual analog gain for low sensitivity image
+ *                              of RCNR [0..255]
+ * @sysm_ag_cont_lssc_test: Manual analog gain for LSSC [0..255]
+ * @sysm_ag_cont_mpro_test: Manual analog gain for color matrix [0..255]
+ * @sysm_ag_cont_vpro_test: Manual analog gain for image adjustment [0..255]
+ *
+ * Operation setting of L1ISP analog gain function.
+ * Analog gain control is disabled if following settings are done.
+ * "sysm_ag_cont_*_en = DRV_VIIF_DISABLE" and "sysm_ag_cont_*_test = 0"
+ * In case "VIIF_L1_INPUT_HDR" or "VIIF_L1_INPUT_PWL" is set to "mode" which is
+ * an &struct viif_l1_input_mode_config, analog gain control needs to be disabled.
+ * Even if this condition is not satisfied, this driver doesn't return error.
+ *
+ * The value set in sysm_ag_psel_xxx indicates analog gain system to be used and
+ * corresponds to the element number of sysm_ag_grad and sysm_ag_ofst.
+ * For example, if sysm_ag_psel_hobc_high is set to 2, then values set in
+ * sysm_ag_grad[2] and sysm_ag_ofst[2] are used for high sensitivity images
+ * in OBCC processing.
+ */
+struct viif_l1_ag_mode_config {
+	__u8 sysm_ag_grad[4];
+	__u16 sysm_ag_ofst[4];
+	__u32 sysm_ag_cont_hobc_en_high;
+	__u32 sysm_ag_psel_hobc_high;
+	__u32 sysm_ag_cont_hobc_en_middle_led;
+	__u32 sysm_ag_psel_hobc_middle_led;
+	__u32 sysm_ag_cont_hobc_en_low;
+	__u32 sysm_ag_psel_hobc_low;
+	__u32 sysm_ag_cont_abpc_en_high;
+	__u32 sysm_ag_psel_abpc_high;
+	__u32 sysm_ag_cont_abpc_en_middle_led;
+	__u32 sysm_ag_psel_abpc_middle_led;
+	__u32 sysm_ag_cont_abpc_en_low;
+	__u32 sysm_ag_psel_abpc_low;
+	__u32 sysm_ag_cont_rcnr_en_high;
+	__u32 sysm_ag_psel_rcnr_high;
+	__u32 sysm_ag_cont_rcnr_en_middle_led;
+	__u32 sysm_ag_psel_rcnr_middle_led;
+	__u32 sysm_ag_cont_rcnr_en_low;
+	__u32 sysm_ag_psel_rcnr_low;
+	__u32 sysm_ag_cont_lssc_en;
+	__u32 sysm_ag_ssel_lssc;
+	__u32 sysm_ag_psel_lssc;
+	__u32 sysm_ag_cont_mpro_en;
+	__u32 sysm_ag_ssel_mpro;
+	__u32 sysm_ag_psel_mpro;
+	__u32 sysm_ag_cont_vpro_en;
+	__u32 sysm_ag_ssel_vpro;
+	__u32 sysm_ag_psel_vpro;
+	__u8 sysm_ag_cont_hobc_test_high;
+	__u8 sysm_ag_cont_hobc_test_middle_led;
+	__u8 sysm_ag_cont_hobc_test_low;
+	__u8 sysm_ag_cont_abpc_test_high;
+	__u8 sysm_ag_cont_abpc_test_middle_led;
+	__u8 sysm_ag_cont_abpc_test_low;
+	__u8 sysm_ag_cont_rcnr_test_high;
+	__u8 sysm_ag_cont_rcnr_test_middle_led;
+	__u8 sysm_ag_cont_rcnr_test_low;
+	__u8 sysm_ag_cont_lssc_test;
+	__u8 sysm_ag_cont_mpro_test;
+	__u8 sysm_ag_cont_vpro_test;
+};
+
+/**
+ * struct viif_l1_ag_config - L1ISP AG parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AG`
+ * @gain_h: Analog gain for high sensitive image [0..65535]
+ * @gain_m: Analog gain for middle sensitive image or LED image [0..65535]
+ * @gain_l: Analog gain for low sensitive image [0..65535]
+ */
+struct viif_l1_ag_config {
+	__u16 gain_h;
+	__u16 gain_m;
+	__u16 gain_l;
+};
+
+/**
+ * struct viif_l1_hdre_config - L1ISP HDRE parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRE`
+ * @hdre_src_point: Knee point N value of PWL compressed signal [0..0x3FFF]
+ * @hdre_dst_base: Offset value of HDR signal in Knee area M [0..0xFFFFFF]
+ * @hdre_ratio: Slope of output pixel value in Knee area M
+ *              [0..0x3FFFFF], accuracy: 1/64
+ * @hdre_dst_max_val: Maximum value of output pixel [0..0xFFFFFF]
+ */
+struct viif_l1_hdre_config {
+	__u32 hdre_src_point[16];
+	__u32 hdre_dst_base[17];
+	__u32 hdre_ratio[17];
+	__u32 hdre_dst_max_val;
+};
+
+/**
+ * struct viif_l1_img_extraction_config -  L1ISP image extraction parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_EXTRACTION`
+ * @input_black_gr: Black level of input pixel (Gr) [0..0xFFFFFF]
+ * @input_black_r: Black level of input pixel (R) [0..0xFFFFFF]
+ * @input_black_b: Black level of input pixel (B) [0..0xFFFFFF]
+ * @input_black_gb: Black level of input pixel (Gb) [0..0xFFFFFF]
+ */
+struct viif_l1_img_extraction_config {
+	__u32 input_black_gr;
+	__u32 input_black_r;
+	__u32 input_black_b;
+	__u32 input_black_gb;
+};
+
+/**
+ * enum viif_l1_dpc_mode - L1ISP defect pixel correction mode
+ * @VIIF_L1_DPC_1PIXEL: 1 pixel correction mode
+ * @VIIF_L1_DPC_2PIXEL: 2 pixel correction mode
+ */
+enum viif_l1_dpc_mode {
+	VIIF_L1_DPC_1PIXEL = 0,
+	VIIF_L1_DPC_2PIXEL = 1,
+};
+
+/**
+ * struct viif_l1_dpc - L1ISP defect pixel correction parameters
+ * for &struct viif_l1_dpc_config
+ * @abpc_sta_en: 1:enable/0:disable setting of Static DPC
+ * @abpc_dyn_en: 1:enable/0:disable setting of Dynamic DPC
+ * @abpc_dyn_mode: &enume viif_l1_dpc_mode value. Sets dynamic DPC mode.
+ * @abpc_ratio_limit: Variation adjustment of dynamic DPC [0..1023]
+ * @abpc_dark_limit: White defect judgment limit of dark area [0..1023]
+ * @abpc_sn_coef_w_ag_min: Luminance difference adjustment of white DPC
+ *                         (undere lower threshold) [1..31]
+ * @abpc_sn_coef_w_ag_mid: Luminance difference adjustment of white DPC
+ *                         (between lower and upper threshold) [1..31]
+ * @abpc_sn_coef_w_ag_max: Luminance difference adjustment of white DPC
+ *                         (over upper threshold) [1..31]
+ * @abpc_sn_coef_b_ag_min: Luminance difference adjustment of black DPC
+ *                         (undere lower threshold) [1..31]
+ * @abpc_sn_coef_b_ag_mid: Luminance difference adjustment of black DPC
+ *                         (between lower and upper threshold) [1..31]
+ * @abpc_sn_coef_b_ag_max: Luminance difference adjustment of black DPC
+ *                         (over upper threshold) [1..31]
+ * @abpc_sn_coef_w_th_min: Luminance difference adjustment of white DPC
+ *                         analog gain lower threshold [0..255]
+ * @abpc_sn_coef_w_th_max: Luminance difference adjustment of white DPC
+ *                         analog gain upper threshold [0..255]
+ * @abpc_sn_coef_b_th_min: Luminance difference adjustment of black DPC
+ *                         analog gain lower threshold [0..255]
+ * @abpc_sn_coef_b_th_max: Luminance difference adjustment of black DPC
+ *                         analog gain upper threshold [0..255]
+ *
+ * Parameters should meet the following conditions.
+ * "abpc_sn_coef_w_th_min < abpc_sn_coef_w_th_max" and
+ * "abpc_sn_coef_b_th_min < abpc_sn_coef_b_th_max"
+ */
+struct viif_l1_dpc {
+	__u32 abpc_sta_en;
+	__u32 abpc_dyn_en;
+	__u32 abpc_dyn_mode;
+	__u32 abpc_ratio_limit;
+	__u32 abpc_dark_limit;
+	__u32 abpc_sn_coef_w_ag_min;
+	__u32 abpc_sn_coef_w_ag_mid;
+	__u32 abpc_sn_coef_w_ag_max;
+	__u32 abpc_sn_coef_b_ag_min;
+	__u32 abpc_sn_coef_b_ag_mid;
+	__u32 abpc_sn_coef_b_ag_max;
+	__u8 abpc_sn_coef_w_th_min;
+	__u8 abpc_sn_coef_w_th_max;
+	__u8 abpc_sn_coef_b_th_min;
+	__u8 abpc_sn_coef_b_th_max;
+};
+
+/**
+ * struct viif_l1_dpc_config - L1ISP defect pixel correction parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_DPC`
+ * @param_h: DPC parameter for high sensitive image. Refer to &struct viif_l1_dpc
+ * @param_m: DPC parameter for middle sensitive image. Refer to &struct viif_l1_dpc
+ * @param_l: DPC parameter for low sensitive image. Refer to &struct viif_l1_dpc
+ * @table_h_addr: DPC table address for high sensitive image.
+ *                The table size is sizeof(u32) * 2048.
+ *                Set zero to disable this table.
+ * @table_m_addr: DPC table address for middle sensitive image or LED image.
+ *                The table size is sizeof(u32) * 2048.
+ *                Set zero to disable this table.
+ * @table_l_addr: DPC table address for low sensitive image.
+ *                The table size is sizeof(u32) * 2048.
+ *                Set zero to disable this table.
+ *
+ * The size of each table is fixed at 8192 Byte.
+ * Application should make sure that the table data is based on HW specification
+ * since this driver does not check the DPC table.
+ */
+struct viif_l1_dpc_config {
+	struct viif_l1_dpc param_h;
+	struct viif_l1_dpc param_m;
+	struct viif_l1_dpc param_l;
+	__u64 table_h_addr;
+	__u64 table_m_addr;
+	__u64 table_l_addr;
+};
+
+/**
+ * struct viif_l1_preset_wb - L1ISP  preset white balance parameters
+ * for &struct viif_l1_preset_white_balance_config
+ * @gain_gr: Gr gain [0..524287], accuracy 1/16384
+ * @gain_r: R gain [0..524287], accuracy 1/16384
+ * @gain_b: B gain [0..524287], accuracy 1/16384
+ * @gain_gb: Gb gain [0..524287], accuracy 1/16384
+ */
+struct viif_l1_preset_wb {
+	__u32 gain_gr;
+	__u32 gain_r;
+	__u32 gain_b;
+	__u32 gain_gb;
+};
+
+/**
+ * struct viif_l1_preset_white_balance_config - L1ISP  preset white balance
+ * parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_PRESET_WHITE_BALANCE`
+ * @dstmaxval: Maximum value of output pixel [pixel] [0..4095]
+ * @param_h: Preset white balance parameter for high sensitive image.
+ *           Refer to &struct viif_l1_preset_wb
+ * @param_m: Preset white balance parameters for middle sensitive image or LED image.
+ *           Refer to &struct viif_l1_preset_wb
+ * @param_l: Preset white balance parameters for low sensitive image.
+ *           Refer to &struct viif_l1_preset_wb
+ */
+struct viif_l1_preset_white_balance_config {
+	__u32 dstmaxval;
+	struct viif_l1_preset_wb param_h;
+	struct viif_l1_preset_wb param_m;
+	struct viif_l1_preset_wb param_l;
+};
+
+/**
+ * enum viif_l1_rcnr_type - L1ISP high resolution luminance filter type
+ *
+ * @VIIF_L1_RCNR_LOW_RESOLUTION: low resolution
+ * @VIIF_L1_RCNR_MIDDLE_RESOLUTION: middle resolution
+ * @VIIF_L1_RCNR_HIGH_RESOLUTION: high resolution
+ * @VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION: ultra high resolution
+ */
+enum viif_l1_rcnr_type {
+	VIIF_L1_RCNR_LOW_RESOLUTION = 0,
+	VIIF_L1_RCNR_MIDDLE_RESOLUTION = 1,
+	VIIF_L1_RCNR_HIGH_RESOLUTION = 2,
+	VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION = 3,
+};
+
+/**
+ * enum viif_l1_msf_blend_ratio - L1ISP MSF blend ratio
+ *
+ * @VIIF_L1_MSF_BLEND_RATIO_0_DIV_64: 0/64
+ * @VIIF_L1_MSF_BLEND_RATIO_1_DIV_64: 1/64
+ * @VIIF_L1_MSF_BLEND_RATIO_2_DIV_64: 2/64
+ */
+enum viif_l1_msf_blend_ratio {
+	VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 = 0,
+	VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 = 1,
+	VIIF_L1_MSF_BLEND_RATIO_2_DIV_64 = 2,
+};
+
+/**
+ * struct viif_l1_raw_color_noise_reduction - L1ISP RCNR parameters
+ * for &struct viif_l1_raw_color_noise_reduction_config
+ * @rcnr_sw: 1:Enable/0:Disable setting of RAW color noise reduction
+ * @rcnr_cnf_dark_ag0: Maximum value of LSF dark noise adjustment[0..63]
+ * @rcnr_cnf_dark_ag1: Middle value of LSF dark noise adjustment [0..63]
+ * @rcnr_cnf_dark_ag2: Minimum value of LSF dark noise adjustment [0..63]
+ * @rcnr_cnf_ratio_ag0: Maximum value of LSF luminance interlocking noise adjustment [0..31]
+ * @rcnr_cnf_ratio_ag1: Middle value of LSF luminance interlocking noise adjustment [0..31]
+ * @rcnr_cnf_ratio_ag2: Minimum value of LSF luminance interlocking noise adjustment [0..31]
+ * @rcnr_cnf_clip_gain_r: LSF color correction limit adjustment gain R [0..3]
+ * @rcnr_cnf_clip_gain_g: LSF color correction limit adjustment gain G [0..3]
+ * @rcnr_cnf_clip_gain_b: LSF color correction limit adjustment gain B [0..3]
+ * @rcnr_a1l_dark_ag0: Maximum value of MSF dark noise adjustment [0..63]
+ * @rcnr_a1l_dark_ag1: Middle value of MSF dark noise adjustment [0..63]
+ * @rcnr_a1l_dark_ag2: Minimum value of MSF dark noise adjustment [0..63]
+ * @rcnr_a1l_ratio_ag0: Maximum value of MSF luminance interlocking noise adjustment [0..31]
+ * @rcnr_a1l_ratio_ag1: Middle value of MSF luminance interlocking noise adjustment [0..31]
+ * @rcnr_a1l_ratio_ag2: Minimum value of MSF luminance interlocking noise adjustment [0..31]
+ * @rcnr_inf_zero_clip: Input stage zero clip setting [0..256]
+ * @rcnr_merge_d2blend_ag0: Maximum value of filter results and input blend ratio [0..16]
+ * @rcnr_merge_d2blend_ag1: Middle value of filter results and input blend ratio [0..16]
+ * @rcnr_merge_d2blend_ag2: Minimum value of filter results and input blend ratio [0..16]
+ * @rcnr_merge_black: Black level minimum value [0..64]
+ * @rcnr_merge_mindiv: 0 div guard value of inverse arithmetic unit [4..16]
+ * @rcnr_hry_type: &enum viif_l1_rcnr_type value. Filter type for HSF filter process.
+ * @rcnr_anf_blend_ag0: &enum viif_l1_msf_blend_ratio value.
+ *                      Maximum value of MSF result blend ratio in write back data to line memory.
+ * @rcnr_anf_blend_ag1: &enum viif_l1_msf_blend_ratio value.
+ *                      Middle value of MSF result blend ratio in write back data to line memory.
+ * @rcnr_anf_blend_ag2: &enum viif_l1_msf_blend_ratio value.
+ *                      Minimum value of MSF result blend ratio in write back data to line memory.
+ * @rcnr_lpf_threshold: Multiplier value for calculating dark noise / luminance
+ *                      interlock noise of MSF [0..31], accuracy: 1/8
+ * @rcnr_merge_hlblend_ag0: Maximum value of luminance signal generation blend [0..2]
+ * @rcnr_merge_hlblend_ag1: Middle value of luminance signal generation blend [0..2]
+ * @rcnr_merge_hlblend_ag2: Minimum value of luminance signal generation blend [0..2]
+ * @rcnr_gnr_sw: 1:Enable/0:Disable setting of Gr/Gb sensitivity ratio
+ *               correction function switching
+ * @rcnr_gnr_ratio: Upper limit of Gr/Gb sensitivity ratio correction factor [0..15]
+ * @rcnr_gnr_wide_en: 1:Enable/0:Disable setting of the function to double
+ *                    correction upper limit ratio of rcnr_gnr_ratio
+ */
+struct viif_l1_raw_color_noise_reduction {
+	__u32 rcnr_sw;
+	__u32 rcnr_cnf_dark_ag0;
+	__u32 rcnr_cnf_dark_ag1;
+	__u32 rcnr_cnf_dark_ag2;
+	__u32 rcnr_cnf_ratio_ag0;
+	__u32 rcnr_cnf_ratio_ag1;
+	__u32 rcnr_cnf_ratio_ag2;
+	__u32 rcnr_cnf_clip_gain_r;
+	__u32 rcnr_cnf_clip_gain_g;
+	__u32 rcnr_cnf_clip_gain_b;
+	__u32 rcnr_a1l_dark_ag0;
+	__u32 rcnr_a1l_dark_ag1;
+	__u32 rcnr_a1l_dark_ag2;
+	__u32 rcnr_a1l_ratio_ag0;
+	__u32 rcnr_a1l_ratio_ag1;
+	__u32 rcnr_a1l_ratio_ag2;
+	__u32 rcnr_inf_zero_clip;
+	__u32 rcnr_merge_d2blend_ag0;
+	__u32 rcnr_merge_d2blend_ag1;
+	__u32 rcnr_merge_d2blend_ag2;
+	__u32 rcnr_merge_black;
+	__u32 rcnr_merge_mindiv;
+	__u32 rcnr_hry_type;
+	__u32 rcnr_anf_blend_ag0;
+	__u32 rcnr_anf_blend_ag1;
+	__u32 rcnr_anf_blend_ag2;
+	__u32 rcnr_lpf_threshold;
+	__u32 rcnr_merge_hlblend_ag0;
+	__u32 rcnr_merge_hlblend_ag1;
+	__u32 rcnr_merge_hlblend_ag2;
+	__u32 rcnr_gnr_sw;
+	__u32 rcnr_gnr_ratio;
+	__u32 rcnr_gnr_wide_en;
+};
+
+/**
+ * struct viif_l1_raw_color_noise_reduction_config - L1ISP RCNR parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_RAW_COLOR_NOISE_REDUCTION`
+ * @param_h: RAW color noise reduction parameter for high sensitive image.
+ *           Refer to &struct viif_l1_raw_color_noise_reduction
+ * @param_m: RAW color noise reduction parameter for middle sensitive image or LED image.
+ *           Refer to &struct viif_l1_raw_color_noise_reduction
+ * @param_l: RAW color noise reduction parameter for low sensitive image.
+ *           Refer to &struct viif_l1_raw_color_noise_reduction
+ */
+struct viif_l1_raw_color_noise_reduction_config {
+	struct viif_l1_raw_color_noise_reduction param_h;
+	struct viif_l1_raw_color_noise_reduction param_m;
+	struct viif_l1_raw_color_noise_reduction param_l;
+};
+
+/**
+ * enum viif_l1_hdrs_middle_img_mode - L1ISP HDR setting
+ *
+ * @VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE: not use middle image
+ * @VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE: use middle image
+ */
+enum viif_l1_hdrs_middle_img_mode {
+	VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE = 0,
+	VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE = 1,
+};
+
+/**
+ * struct viif_l1_hdrs_config - L1ISP HDRS parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRS`
+ * @hdrs_hdr_mode: &enum viif_l1_hdrs_middle_img_mode value.
+ *                 Use/No use settings of middle sensitivity image in HDRS.
+ * @hdrs_hdr_ratio_m: Magnification ratio of middle sensitivity image for high
+ *                    sensitivity image [0x400..0x400000] accuracy: 1/1024
+ * @hdrs_hdr_ratio_l: Magnification ratio of low sensitivity image for high
+ *                    sensitivity image [0x400..0x400000], accuracy: 1/1024
+ * @hdrs_hdr_ratio_e: Magnification ratio of LED image for high sensitivity image
+ *                    [0x400..0x400000], accuracy: 1/1024
+ * @hdrs_dg_h: High sensitivity image digital gain [0..0x3FFFFF], accuracy: 1/1024
+ * @hdrs_dg_m: Middle sensitivity image digital gain [0..0x3FFFFF], accuracy: 1/1024
+ * @hdrs_dg_l: Low sensitivity image digital gain [0..0x3FFFFF], accuracy: 1/1024
+ * @hdrs_dg_e: LED image digital gain [0..0x3FFFFF], accuracy: 1/1024
+ * @hdrs_blendend_h: Maximum luminance used for blend high sensitivity image [0..4095]
+ * @hdrs_blendend_m: Maximum luminance used for blend middle sensitivity image [0..4095]
+ * @hdrs_blendend_e: Maximum luminance used for blend LED image [0..4095]
+ * @hdrs_blendbeg_h: Minimum luminance used for blend high sensitivity image [0..4095]
+ * @hdrs_blendbeg_m: Minimum luminance used for blend middle sensitivity image [0..4095]
+ * @hdrs_blendbeg_e: Minimum luminance used for blend LED image [0..4095]
+ * @hdrs_led_mode_on: 1:Enable/0:Disable settings of LED mode
+ * @hdrs_dst_max_val: Maximum value of output pixel [0..0xFFFFFF]
+ *
+ * parameter error needs to be returned in the below condition.
+ * (hdrs_hdr_mode == VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE) && (hdrs_led_mode_on == 1)
+ */
+struct viif_l1_hdrs_config {
+	__u32 hdrs_hdr_mode;
+	__u32 hdrs_hdr_ratio_m;
+	__u32 hdrs_hdr_ratio_l;
+	__u32 hdrs_hdr_ratio_e;
+	__u32 hdrs_dg_h;
+	__u32 hdrs_dg_m;
+	__u32 hdrs_dg_l;
+	__u32 hdrs_dg_e;
+	__u32 hdrs_blendend_h;
+	__u32 hdrs_blendend_m;
+	__u32 hdrs_blendend_e;
+	__u32 hdrs_blendbeg_h;
+	__u32 hdrs_blendbeg_m;
+	__u32 hdrs_blendbeg_e;
+	__u32 hdrs_led_mode_on;
+	__u32 hdrs_dst_max_val;
+};
+
+/**
+ * struct viif_l1_black_level_correction_config -  L1ISP image level conversion
+ * parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_BLACK_LEVEL_CORRECTION`
+ * @srcblacklevel_gr: Black level of Gr input pixel [pixel] [0..0xFFFFFF]
+ * @srcblacklevel_r: Black level of R input pixel [pixel] [0..0xFFFFFF]
+ * @srcblacklevel_b: Black level of B input pixel [pixel] [0..0xFFFFFF]
+ * @srcblacklevel_gb: Black level of Gb input pixel [pixel] [0..0xFFFFFF]
+ * @mulval_gr: Gr gain [0..0xFFFFF], accuracy: 1/256
+ * @mulval_r: R gain [0..0xFFFFF], accuracy: 1/256
+ * @mulval_b: B gain [0..0xFFFFF], accuracy: 1/256
+ * @mulval_gb: Gb gain [0..0xFFFFF], accuracy: 1/256
+ * @dstmaxval: Maximum value of output pixel [pixel] [0..0xFFFFFF]
+ */
+struct viif_l1_black_level_correction_config {
+	__u32 srcblacklevel_gr;
+	__u32 srcblacklevel_r;
+	__u32 srcblacklevel_b;
+	__u32 srcblacklevel_gb;
+	__u32 mulval_gr;
+	__u32 mulval_r;
+	__u32 mulval_b;
+	__u32 mulval_gb;
+	__u32 dstmaxval;
+};
+
+/**
+ * enum viif_l1_para_coef_gain - L1ISP parabola shading correction coefficient ratio
+ *
+ * @VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH: 1/8
+ * @VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH: 1/4
+ * @VIIF_L1_PARA_COEF_GAIN_ONE_SECOND: 1/2
+ * @VIIF_L1_PARA_COEF_GAIN_ONE_FIRST: 1/1
+ */
+enum viif_l1_para_coef_gain {
+	VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH = 0, /* 1/8 */
+	VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH = 1, /* 1/4 */
+	VIIF_L1_PARA_COEF_GAIN_ONE_SECOND = 2, /* 1/2 */
+	VIIF_L1_PARA_COEF_GAIN_ONE_FIRST = 3, /* 1/1 */
+};
+
+/**
+ * enum viif_l1_grid_coef_gain - L1ISP grid shading correction coefficient ratio
+ *
+ * @VIIF_L1_GRID_COEF_GAIN_X1: x1
+ * @VIIF_L1_GRID_COEF_GAIN_X2: x2
+ */
+enum viif_l1_grid_coef_gain {
+	VIIF_L1_GRID_COEF_GAIN_X1 = 0,
+	VIIF_L1_GRID_COEF_GAIN_X2 = 1,
+};
+
+/**
+ * struct viif_l1_lsc_parabola_ag_param - L2ISP parabola shading parameters
+ * for &struct viif_l1_lsc_parabola_param
+ * @lssc_paracoef_h_l_max: Parabola coefficient left maximum gain value
+ * @lssc_paracoef_h_l_min: Parabola coefficient left minimum gain value
+ * @lssc_paracoef_h_r_max: Parabola coefficient right maximum gain value
+ * @lssc_paracoef_h_r_min: Parabola coefficient right minimum gain value
+ * @lssc_paracoef_v_u_max: Parabola coefficient upper maximum gain value
+ * @lssc_paracoef_v_u_min: Parabola coefficient upper minimum gain value
+ * @lssc_paracoef_v_d_max: Parabola coefficient lower maximum gain value
+ * @lssc_paracoef_v_d_min: Parabola coefficient lower minimum gain value
+ * @lssc_paracoef_hv_lu_max: Parabola coefficient upper left gain maximum value
+ * @lssc_paracoef_hv_lu_min: Parabola coefficient upper left gain minimum value
+ * @lssc_paracoef_hv_ru_max: Parabola coefficient upper right gain maximum value
+ * @lssc_paracoef_hv_ru_min: Parabola coefficient upper right minimum gain value
+ * @lssc_paracoef_hv_ld_max: Parabola coefficient lower left gain maximum value
+ * @lssc_paracoef_hv_ld_min: Parabola coefficient lower left gain minimum value
+ * @lssc_paracoef_hv_rd_max: Parabola coefficient lower right gain maximum value
+ * @lssc_paracoef_hv_rd_min: Parabola coefficient lower right minimum gain value
+ *
+ * The range and accuracy of each coefficient are as
+ * "range: [-4096..4095], accuracy: 1/256 "
+ *
+ * Each coefficient should meet the following conditions.
+ * "lssc_paracoef_xx_xx_min <= lssc_paracoef_xx_xx_max"
+ */
+struct viif_l1_lsc_parabola_ag_param {
+	__s16 lssc_paracoef_h_l_max;
+	__s16 lssc_paracoef_h_l_min;
+	__s16 lssc_paracoef_h_r_max;
+	__s16 lssc_paracoef_h_r_min;
+	__s16 lssc_paracoef_v_u_max;
+	__s16 lssc_paracoef_v_u_min;
+	__s16 lssc_paracoef_v_d_max;
+	__s16 lssc_paracoef_v_d_min;
+	__s16 lssc_paracoef_hv_lu_max;
+	__s16 lssc_paracoef_hv_lu_min;
+	__s16 lssc_paracoef_hv_ru_max;
+	__s16 lssc_paracoef_hv_ru_min;
+	__s16 lssc_paracoef_hv_ld_max;
+	__s16 lssc_paracoef_hv_ld_min;
+	__s16 lssc_paracoef_hv_rd_max;
+	__s16 lssc_paracoef_hv_rd_min;
+};
+
+/**
+ * struct viif_l1_lsc_parabola_param - L2ISP parabola shading parameters
+ * for &struct viif_l1_lsc
+ * @lssc_para_h_center: Horizontal coordinate of central optical axis [pixel]
+ *                      [0..(Input image width - 1)]
+ * @lssc_para_v_center: Vertical coordinate of central optical axis [line]
+ *                      [0..(Input image height - 1)]
+ * @lssc_para_h_gain: Horizontal distance gain with the optical axis
+ *                    [0..4095], accuracy: 1/256
+ * @lssc_para_v_gain: Vertical distance gain with the optical axis
+ *                    [0..4095], accuracy: 1/256
+ * @lssc_para_mgsel2: &enum viif_l1_para_coef_gain value.
+ *                    Parabola 2D correction coefficient gain magnification ratio.
+ * @lssc_para_mgsel4: &enum viif_l1_para_coef_gain value.
+ *                    Parabola 4D correction coefficient gain magnification ratio.
+ * @r_2d: 2D parabola coefficient for R.
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @r_4d: 4D parabola coefficient for R.
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @gr_2d: 2D parabola coefficient for Gr
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @gr_4d: 4D parabola coefficient for Gr
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @gb_2d: 2D parabola coefficient for Gb
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @gb_4d: 4D parabola coefficient for Gb
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @b_2d: 2D parabola coefficient for B
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ * @b_4d: 4D parabola coefficient for B
+ *        Refer to &struct viif_l1_lsc_parabola_ag_param
+ */
+struct viif_l1_lsc_parabola_param {
+	__u32 lssc_para_h_center;
+	__u32 lssc_para_v_center;
+	__u32 lssc_para_h_gain;
+	__u32 lssc_para_v_gain;
+	__u32 lssc_para_mgsel2;
+	__u32 lssc_para_mgsel4;
+	struct viif_l1_lsc_parabola_ag_param r_2d;
+	struct viif_l1_lsc_parabola_ag_param r_4d;
+	struct viif_l1_lsc_parabola_ag_param gr_2d;
+	struct viif_l1_lsc_parabola_ag_param gr_4d;
+	struct viif_l1_lsc_parabola_ag_param gb_2d;
+	struct viif_l1_lsc_parabola_ag_param gb_4d;
+	struct viif_l1_lsc_parabola_ag_param b_2d;
+	struct viif_l1_lsc_parabola_ag_param b_4d;
+};
+
+/**
+ * struct viif_l1_lsc_grid_param - L2ISP grid shading parameters
+ * for &struct viif_l1_lsc
+ * @lssc_grid_h_size: Grid horizontal direction pixel count [32, 64, 128, 256, 512]
+ * @lssc_grid_v_size: Grid vertical direction pixel count [32, 64, 128, 256, 512]
+ * @lssc_grid_h_center: Horizontal coordinates of grid (1, 1) [pixel] [1..lssc_grid_h_size]
+ *                      Should meet the following condition.
+ *                      "Input image width <= lssc_grid_h_center + lssc_grid_h_size * 31"
+ * @lssc_grid_v_center: Vertical coordinates of grid (1, 1) [line] [1..lssc_grid_v_size]
+ *                      Should meet the following condition.
+ *                      "Input image height <= lssc_grid_v_center + lssc_grid_v_size * 23"
+ * @lssc_grid_mgsel: &enum viif_l1_grid_coef_gain value.
+ *                   Grid correction coefficient gain value magnification ratio.
+ */
+struct viif_l1_lsc_grid_param {
+	__u32 lssc_grid_h_size;
+	__u32 lssc_grid_v_size;
+	__u32 lssc_grid_h_center;
+	__u32 lssc_grid_v_center;
+	__u32 lssc_grid_mgsel;
+};
+
+/**
+ * struct viif_l1_lsc - L2ISP LSC parameters for &struct viif_l1_lsc_config
+ * @lssc_parabola_param_addr: Address of a &struct viif_l1_lsc_parabola_param instance.
+ *                            Set 0 to disable parabola shading correction.
+ * @lssc_grid_param_addr: Address of a &struct viif_l1_lsc_grid_param instance,
+ *                        Set 0 to disable grid shading correction.
+ * @lssc_pwhb_r_gain_max: PWB R correction processing coefficient maximum value
+ * @lssc_pwhb_r_gain_min: PWB R correction processing coefficient minimum value
+ * @lssc_pwhb_gr_gain_max: PWB Gr correction processing coefficient maximum value
+ * @lssc_pwhb_gr_gain_min: PWB Gr correction processing coefficient minimum value
+ * @lssc_pwhb_gb_gain_max: PWB Gb correction processing coefficient maximum value
+ * @lssc_pwhb_gb_gain_min: PWB Gb correction processing coefficient minimum value
+ * @lssc_pwhb_b_gain_max: PWB B correction processing coefficient maximum value
+ * @lssc_pwhb_b_gain_min: PWB B correction processing coefficient minimum value
+ *
+ * The range and accuracy of preset white balance (PWB) correction process
+ * coefficient (lssc_pwhb_{r/gr/gb/b}_gain_{max/min}) are as below.
+ * "range: [0..2047], accuracy: 1/256"
+ *
+ * PWB correction process coefficient
+ * (lssc_pwhb_{r/gr/gb/b}_gain_{max/min}) should meet the following conditions.
+ * "lssc_pwhb_{r/gr/gb/b}_gain_min <= lssc_pwhb_{r/gr/gb/b}_gain_max"
+ */
+struct viif_l1_lsc {
+	__u64 lssc_parabola_param_addr;
+	__u64 lssc_grid_param_addr;
+	__u32 lssc_pwhb_r_gain_max;
+	__u32 lssc_pwhb_r_gain_min;
+	__u32 lssc_pwhb_gr_gain_max;
+	__u32 lssc_pwhb_gr_gain_min;
+	__u32 lssc_pwhb_gb_gain_max;
+	__u32 lssc_pwhb_gb_gain_min;
+	__u32 lssc_pwhb_b_gain_max;
+	__u32 lssc_pwhb_b_gain_min;
+};
+
+/**
+ * struct viif_l1_lsc_config - L2ISP LSC parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_LSC`
+ * @param_addr: Address of a &struct viif_l1_lsc instance.
+ *              Set 0 to disable LSC operation.
+ * @table_gr_addr: Address of the grid table for LSC of Gr component.
+ *                 The table size is sizeof(u16) * 768.
+ *                 Set 0 to disable this table.
+ * @table_r_addr:  Address of the grid table for LSC of R component.
+ *                 The table size is sizeof(u16) * 768.
+ *                 Set 0 to disable this table.
+ * @table_b_addr:  Address of the grid table for LSC of B component.
+ *                 The table size is sizeof(u16) * 768.
+ *                 Set 0 to disable this table.
+ * @table_gb_addr: Address of the grid table for LSC of Gb component.
+ *                 The table size is sizeof(u16) * 768.
+ *                 Set 0 to disable this table.
+ *
+ * The size of each table is fixed to 1,536 Bytes.
+ * Application should make sure that the table data is based on HW specification
+ * since this driver does not check the grid table.
+ */
+struct viif_l1_lsc_config {
+	__u64 param_addr;
+	__u64 table_gr_addr;
+	__u64 table_r_addr;
+	__u64 table_b_addr;
+	__u64 table_gb_addr;
+};
+
+/**
+ * enum viif_l1_demosaic_mode - L1ISP demosaic modeenum viif_l1_demosaic_mode
+ *
+ * @VIIF_L1_DEMOSAIC_ACPI: Toshiba ACPI algorithm
+ * @VIIF_L1_DEMOSAIC_DMG: DMG algorithm
+ */
+enum viif_l1_demosaic_mode {
+	VIIF_L1_DEMOSAIC_ACPI = 0,
+	VIIF_L1_DEMOSAIC_DMG = 1,
+};
+
+/**
+ * struct viif_l1_color_matrix_correction - L1ISP color matrix correction
+ * parameters for &struct viif_l1_main_process_config
+ * @coef_rmg_min: (R-G) Minimum coefficient
+ * @coef_rmg_max: (R-G) Maximum coefficient
+ * @coef_rmb_min: (R-B) Minimum coefficient
+ * @coef_rmb_max: (R-B) Maximum coefficient
+ * @coef_gmr_min: (G-R) Minimum coefficient
+ * @coef_gmr_max: (G-R) Maximum coefficient
+ * @coef_gmb_min: (G-B) Minimum coefficient
+ * @coef_gmb_max: (G-B) Maximum coefficient
+ * @coef_bmr_min: (B-R) Minimum coefficient
+ * @coef_bmr_max: (B-R) Maximum coefficient
+ * @coef_bmg_min: (B-G) Minimum coefficient
+ * @coef_bmg_max: (B-G) Maximum coefficient
+ * @dst_minval: Minimum value of output pixel [0..0xFFFF] [pixel]
+ *
+ * The range and accuracy of each coefficient are as
+ * "range: [-32768..32767], accuracy: 1/ 4096"
+ *
+ * Also, each coefficient should meet "coef_xxx_min <= coef_xxx_max" condition
+ */
+struct viif_l1_color_matrix_correction {
+	__s16 coef_rmg_min;
+	__s16 coef_rmg_max;
+	__s16 coef_rmb_min;
+	__s16 coef_rmb_max;
+	__s16 coef_gmr_min;
+	__s16 coef_gmr_max;
+	__s16 coef_gmb_min;
+	__s16 coef_gmb_max;
+	__s16 coef_bmr_min;
+	__s16 coef_bmr_max;
+	__s16 coef_bmg_min;
+	__s16 coef_bmg_max;
+	__u16 dst_minval;
+};
+
+/**
+ * struct viif_l1_main_process_config - L1ISP Main process operating parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_MAIN_PROCESS`
+ * @demosaic_mode: &enum viif_l1_demosaic_mode value. Sets demosaic mode.
+ * @damp_lsbsel: Clipping range of output pixel value to AWB adjustment function [0..15]
+ * @param_addr: Address to a &struct viif_l1_color_matrix_correction instance.
+ *              Set 0 to disable color matrix correction.
+ * @dst_maxval: Maximum value of output pixel [0..0xFFFFFF].
+ *              Applicable to output of each process (digital amplifier,
+ *              demosaicing and color matrix correction) in L1ISP Main process.
+ */
+struct viif_l1_main_process_config {
+	__u32 demosaic_mode;
+	__u32 damp_lsbsel;
+	__u64 param_addr;
+	__u32 dst_maxval;
+};
+
+/**
+ * enum viif_l1_awb_mag - L1ISP signal magnification before AWB adjustment
+ *
+ * @VIIF_L1_AWB_ONE_SECOND: x 1/2
+ * @VIIF_L1_AWB_X1: 1 times
+ * @VIIF_L1_AWB_X2: 2 times
+ * @VIIF_L1_AWB_X4: 4 times
+ */
+enum viif_l1_awb_mag {
+	VIIF_L1_AWB_ONE_SECOND = 0,
+	VIIF_L1_AWB_X1 = 1,
+	VIIF_L1_AWB_X2 = 2,
+	VIIF_L1_AWB_X4 = 3,
+};
+
+/**
+ * enum viif_l1_awb_area_mode - L1ISP AWB detection target area
+ *
+ * @VIIF_L1_AWB_AREA_MODE0: only center area
+ * @VIIF_L1_AWB_AREA_MODE1: center area when uv is in square gate
+ * @VIIF_L1_AWB_AREA_MODE2: all area except center area
+ * @VIIF_L1_AWB_AREA_MODE3: all area
+ */
+enum viif_l1_awb_area_mode {
+	VIIF_L1_AWB_AREA_MODE0 = 0,
+	VIIF_L1_AWB_AREA_MODE1 = 1,
+	VIIF_L1_AWB_AREA_MODE2 = 2,
+	VIIF_L1_AWB_AREA_MODE3 = 3,
+};
+
+/**
+ * enum viif_l1_awb_restart_cond - L1ISP AWB adjustment restart conditions
+ *
+ * @VIIF_L1_AWB_RESTART_NO: no restart
+ * @VIIF_L1_AWB_RESTART_128FRAME: restart after 128 frame
+ * @VIIF_L1_AWB_RESTART_64FRAME: restart after 64 frame
+ * @VIIF_L1_AWB_RESTART_32FRAME: restart after 32 frame
+ * @VIIF_L1_AWB_RESTART_16FRAME: restart after 16 frame
+ * @VIIF_L1_AWB_RESTART_8FRAME: restart after 8 frame
+ * @VIIF_L1_AWB_RESTART_4FRAME: restart after 4 frame
+ * @VIIF_L1_AWB_RESTART_2FRAME: restart after 2 frame
+ */
+enum viif_l1_awb_restart_cond {
+	VIIF_L1_AWB_RESTART_NO = 0,
+	VIIF_L1_AWB_RESTART_128FRAME = 1,
+	VIIF_L1_AWB_RESTART_64FRAME = 2,
+	VIIF_L1_AWB_RESTART_32FRAME = 3,
+	VIIF_L1_AWB_RESTART_16FRAME = 4,
+	VIIF_L1_AWB_RESTART_8FRAME = 5,
+	VIIF_L1_AWB_RESTART_4FRAME = 6,
+	VIIF_L1_AWB_RESTART_2FRAME = 7,
+};
+
+/**
+ * struct viif_l1_awb - L1ISP AWB adjustment parameters
+ * for &struct viif_l1_awb_config
+ * @awhb_ygate_sel: 1:Enable/0:Disable to fix Y value at YUV conversion
+ * @awhb_ygate_data: Y value in case Y value is fixed [64, 128, 256, 512]
+ * @awhb_cgrange: &enum viif_l1_awb_mag value.
+ *                Signal output magnification ratio before AWB adjustment.
+ * @awhb_ygatesw: 1:Enable/0:Disable settings of luminance gate
+ * @awhb_hexsw: 1:Enable/0:Disable settings of hexa-gate
+ * @awhb_areamode: &enum viif_l1_awb_area_mode value.
+ *                 Final selection of accumulation area for detection target area.
+ * @awhb_area_hsize: Horizontal size per block in central area [pixel]
+ *                   [1..(Input image width -8)/8]
+ * @awhb_area_vsize: Vertical size per block in central area [line]
+ *                   [1..(Input image height -4)/8]
+ * @awhb_area_hofs: Horizontal offset of block [0] in central area [pixel]
+ *                  [0..(Input image width -9)]
+ * @awhb_area_vofs: Vertical offset of block [0] in central area [line]
+ *                  [0..(Input image height -5)]
+ * @awhb_area_maskh: Setting 1:Enable/0:Disable( of accumulated selection.
+ *                   Each bit implies the following.
+ *                   [31:0] = {
+ *                   (7, 3),(6, 3),(5, 3),(4, 3),(3, 3),(2, 3),(1, 3),(0, 3),
+ *                   (7, 2),(6, 2),(5, 2),(4, 2),(3, 2),(2, 2),(1, 2),(0, 2),
+ *                   (7, 1),(6, 1),(5, 1),(4, 1),(3, 1),(2, 1),(1, 1),(0, 1),
+ *                   (7, 0),(6, 0),(5, 0),(4, 0),(3, 0),(2, 0),(1, 0),(0, 0)}
+ * @awhb_area_maskl: Setting 1:Enable/0:Disable of accumulated selection.
+ *                   Each bit implies the following.
+ *                   [31:0] = {
+ *                   (7, 7),(6, 7),(5, 7),(4, 7),(3, 7),(2, 7),(1, 7),(0, 7),
+ *                   (7, 6),(6, 6),(5, 6),(4, 6),(3, 6),(2, 6),(1, 6),(0, 6),
+ *                   (7, 5),(6, 5),(5, 5),(4, 5),(3, 5),(2, 5),(1, 5),(0, 5),
+ *                   (7, 4),(6, 4),(5, 4),(4, 4),(3, 4),(2, 4),(1, 4),(0, 4)}
+ * @awhb_sq_sw: 1:Enable/0:Disable each square gate
+ * @awhb_sq_pol: 1:Enable/0:Disable to add accumulated gate for each square gate
+ * @awhb_bycut0p: U upper end value [pixel] [0..127]
+ * @awhb_bycut0n: U lower end value [pixel] [0..127]
+ * @awhb_rycut0p: V upper end value [pixel] [0..127]
+ * @awhb_rycut0n: V lower end value [pixel] [0..127]
+ * @awhb_rbcut0h: V-axis intercept upper end [pixel] [-127..127]
+ * @awhb_rbcut0l: V-axis intercept lower end [pixel] [-127..127]
+ * @awhb_bycut_h: U direction center value of each square gate [-127..127]
+ * @awhb_bycut_l: U direction width of each square gate [0..127]
+ * @awhb_rycut_h: V direction center value of each square gate [-127..127]
+ * @awhb_rycut_l: V direction width of each square gate [0..127]
+ * @awhb_awbsftu: U gain offset [-127..127]
+ * @awhb_awbsftv: V gain offset [-127..127]
+ * @awhb_awbhuecor: 1:Enable/0:Disable setting of color correlation retention function
+ * @awhb_awbspd: UV convergence speed [0..15] [times] (0 means "stop")
+ * @awhb_awbulv: U convergence point level [0..31]
+ * @awhb_awbvlv: V convergence point level [0..31]
+ * @awhb_awbondot: Accumulation operation stop pixel count threshold [pixel] [0..1023]
+ * @awhb_awbfztim: &enum viif_l1_awb_restart_cond value. Condition to restart AWB process.
+ * @awhb_wbgrmax: B gain adjustment range (Width from center to upper limit)
+ *                [0..255], accuracy: 1/64
+ * @awhb_wbgbmax: R gain adjustment range (Width from center to upper limit)
+ *                [0..255], accuracy: 1/64
+ * @awhb_wbgrmin: B gain adjustment range (Width from center to lower limit)
+ *                [0..255], accuracy: 1/64
+ * @awhb_wbgbmin: R gain adjustment range (Width from center to lower limit)
+ *                [0..255], accuracy: 1/64
+ * @awhb_ygateh: Luminance gate maximum value [pixel] [0..255]
+ * @awhb_ygatel: Luminance gate minimum value [pixel] [0..255]
+ * @awhb_awbwait: Number of restart frames after UV convergence freeze [0..255]
+ */
+struct viif_l1_awb {
+	__u32 awhb_ygate_sel;
+	__u32 awhb_ygate_data;
+	__u32 awhb_cgrange;
+	__u32 awhb_ygatesw;
+	__u32 awhb_hexsw;
+	__u32 awhb_areamode;
+	__u32 awhb_area_hsize;
+	__u32 awhb_area_vsize;
+	__u32 awhb_area_hofs;
+	__u32 awhb_area_vofs;
+	__u32 awhb_area_maskh;
+	__u32 awhb_area_maskl;
+	__u32 awhb_sq_sw[3];
+	__u32 awhb_sq_pol[3];
+	__u32 awhb_bycut0p;
+	__u32 awhb_bycut0n;
+	__u32 awhb_rycut0p;
+	__u32 awhb_rycut0n;
+	__s32 awhb_rbcut0h;
+	__s32 awhb_rbcut0l;
+	__s32 awhb_bycut_h[3];
+	__u32 awhb_bycut_l[3];
+	__s32 awhb_rycut_h[3];
+	__u32 awhb_rycut_l[3];
+	__s32 awhb_awbsftu;
+	__s32 awhb_awbsftv;
+	__u32 awhb_awbhuecor;
+	__u32 awhb_awbspd;
+	__u32 awhb_awbulv;
+	__u32 awhb_awbvlv;
+	__u32 awhb_awbondot;
+	__u32 awhb_awbfztim;
+	__u8 awhb_wbgrmax;
+	__u8 awhb_wbgbmax;
+	__u8 awhb_wbgrmin;
+	__u8 awhb_wbgbmin;
+	__u8 awhb_ygateh;
+	__u8 awhb_ygatel;
+	__u8 awhb_awbwait;
+};
+
+/**
+ * struct viif_l1_awb_config - L1ISP AWB parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AWB`
+ * @param_addr: Address to a &struct viif_l1_awb instance.
+ *              Set 0 to disable AWB adjustment.
+ * @awhb_wbmrg: White balance adjustment R gain [64..1023], accuracy: 1/256
+ * @awhb_wbmgg: White balance adjustment G gain [64..1023], accuracy: 1/256
+ * @awhb_wbmbg: White balance adjustment B gain [64..1023], accuracy: 1/256
+ */
+struct viif_l1_awb_config {
+	__u64 param_addr;
+	__u32 awhb_wbmrg;
+	__u32 awhb_wbmgg;
+	__u32 awhb_wbmbg;
+};
+
+/**
+ * enum viif_l1_hdrc_tone_type - L1ISP HDRC tone type
+ *
+ * @VIIF_L1_HDRC_TONE_USER: User Tone
+ * @VIIF_L1_HDRC_TONE_PRESET: Preset Tone
+ */
+enum viif_l1_hdrc_tone_type {
+	VIIF_L1_HDRC_TONE_USER = 0,
+	VIIF_L1_HDRC_TONE_PRESET = 1,
+};
+
+/**
+ * struct viif_l1_hdrc - L1ISP HDRC parameters for &struct viif_l1_hdrc_config
+ * @hdrc_ratio: Data width of input image [bit] [10..24]
+ * @hdrc_pt_ratio: Preset Tone curve slope [0..13]
+ * @hdrc_pt_blend: Preset Tone0 curve blend ratio [0..256], accuracy: 1/256
+ * @hdrc_pt_blend2: Preset Tone2 curve blend ratio [0..256], accuracy: 1/256
+ * @hdrc_tn_type: &enum viif_l1_hdrc_tone_type value. L1ISP HDRC tone type.
+ * @hdrc_utn_tbl: HDRC value of User Tone curve [0..0xFFFF]
+ * @hdrc_flr_val: Constant flare value [0..0xFFFFFF]
+ * @hdrc_flr_adp: 1:Enable/0:Disable setting of dynamic flare measurement
+ * @hdrc_ybr_off: 1:Enable(function OFF) / 0:Disable(function ON) settings
+ *                of bilateral luminance filter function OFF
+ * @hdrc_orgy_blend: Blend settings of luminance correction data after HDRC
+ *                   and data before luminance correction [0..16].
+ *                   (0:Luminance correction 100%, 8:Luminance correction 50%,
+ *                   16:Luminance correction 0%)
+ * @hdrc_pt_sat: Preset Tone saturation value [0..0xFFFF]
+ *
+ * Parameter error needs to be returned in
+ * "hdrc_pt_blend + hdrc_pt_blend2 > 256" condition.
+ *
+ * In case application enables dynamic flare control, input image height should
+ * satisfy the following condition. Even if this condition is not satisfied,
+ * this driver doesn't return error in case other conditions for each parameter
+ * are satisfied. "Input image height % 64 != 18, 20, 22, 24, 26"
+ *
+ * hdrc_utn_tbl should satisfy the following condition. Even if this condition
+ * is not satisfied, this driver doesn't return error in case other conditions
+ * for each parameter are satisfied. "hdrc_utn_tbl[N] <= hdrc_utn_tbl[N+1]"
+ */
+struct viif_l1_hdrc {
+	__u32 hdrc_ratio;
+	__u32 hdrc_pt_ratio;
+	__u32 hdrc_pt_blend;
+	__u32 hdrc_pt_blend2;
+	__u32 hdrc_tn_type;
+	__u16 hdrc_utn_tbl[20];
+	__u32 hdrc_flr_val;
+	__u32 hdrc_flr_adp;
+	__u32 hdrc_ybr_off;
+	__u32 hdrc_orgy_blend;
+	__u16 hdrc_pt_sat;
+};
+
+/**
+ * struct viif_l1_hdrc_config - L1ISP HDRC parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC`
+ * @param_addr: Address to a &struct viif_l1_hdrc instance.
+ *              Set 0 to disable HDR compression.
+ * @hdrc_thr_sft_amt: Amount of right shift in through mode (HDRC disabled) [0..8].
+ *                    Should set 0 if HDRC is enabled
+ */
+struct viif_l1_hdrc_config {
+	__u64 param_addr;
+	__u32 hdrc_thr_sft_amt;
+};
+
+/**
+ * struct viif_l1_hdrc_ltm_config - L1ISP HDRC LTM parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_HDRC_LTM`
+ * @tnp_max: Tone blend rate maximum value of LTM function
+ *           [0..4194303], accuracy: 1/64. In case of 0, LTM function is OFF
+ * @tnp_mag: Intensity adjustment of LTM function [0..16383], accuracy: 1/64
+ * @tnp_fil: Smoothing filter coefficient [0..255].
+ *           [0]: coef0, [1]: coef1, [2]: coef2, [3]: coef3, [4]: coef4
+ *           EINVAL needs to be returned in the below condition.
+ *           "(coef1 + coef2 + coef3 + coef4) * 2 + coef0 != 1024"
+ */
+struct viif_l1_hdrc_ltm_config {
+	__u32 tnp_max;
+	__u32 tnp_mag;
+	__u8 tnp_fil[5];
+};
+
+/**
+ * struct viif_l1_gamma - L1ISP gamma correction parameters
+ * for &struct viif_l1_gamma_config
+ * @gam_p: Luminance value after gamma correction [0..8191]
+ * @blkadj: Black level adjustment value after gamma correction [0..65535]
+ */
+struct viif_l1_gamma {
+	__u16 gam_p[44];
+	__u16 blkadj;
+};
+
+/**
+ * struct viif_l1_gamma_config - L1ISP gamma correction parameters
+ * @param_addr: Address to a &struct viif_l1_gamma instance.
+ *              Set 0 to disable gamma correction at l1 ISP.
+ */
+struct viif_l1_gamma_config {
+	__u64 param_addr;
+};
+
+/**
+ * struct viif_l1_nonlinear_contrast -  L1ISP non-linear contrast parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @blk_knee: Black side peak luminance value [0..0xFFFF]
+ * @wht_knee: White side peak luminance value[0..0xFFFF]
+ * @blk_cont: Black side slope [0..255], accuracy: 1/256
+ *            [0]:the value at AG minimum, [1]:the value at AG less than 128,
+ *            [2]:the value at AG equal to or more than 128
+ * @wht_cont: White side slope [0..255], accuracy: 1/256
+ *            [0]:the value at AG minimum, [1]:the value at AG less than 128,
+ *            [2]:the value at AG equal to or more than 128
+ */
+struct viif_l1_nonlinear_contrast {
+	__u16 blk_knee;
+	__u16 wht_knee;
+	__u8 blk_cont[3];
+	__u8 wht_cont[3];
+};
+
+/**
+ * struct viif_l1_lum_noise_reduction -  L1ISP luminance noise reduction
+ * parameters for &struct viif_l1_img_quality_adjustment_config
+ * @gain_min: Minimum value of extracted noise gain [0..0xFFFF], accuracy: 1/256
+ * @gain_max: Maximum value of extracted noise gain [0..0xFFFF], accuracy: 1/256
+ * @lim_min: Minimum value of extracted noise limit [0..0xFFFF]
+ * @lim_max: Maximum value of extracted noise limit [0..0xFFFF]
+ *
+ * Parameter error needs to be returned in the below conditions.
+ * "gain_min > gain_max" or "lim_min > lim_max"
+ */
+struct viif_l1_lum_noise_reduction {
+	__u16 gain_min;
+	__u16 gain_max;
+	__u16 lim_min;
+	__u16 lim_max;
+};
+
+/**
+ * struct viif_l1_edge_enhancement -  L1ISP edge enhancement parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @gain_min: Extracted edge gain minimum value [0..0xFFFF], accuracy: 1/256
+ * @gain_max: Extracted edge gain maximum value [0..0xFFFF], accuracy: 1/256
+ * @lim_min: Extracted edge limit minimum value [0..0xFFFF]
+ * @lim_max: Extracted edge limit maximum value [0..0xFFFF]
+ * @coring_min: Extracted edge coring threshold minimum value [0..0xFFFF]
+ * @coring_max: Extracted edge coring threshold maximum value [0..0xFFFF]
+ *
+ * Parameter error needs to be returned in the below conditions.
+ * "gain_min > gain_max" or "lim_min > lim_max" or "coring_min > coring_max"
+ */
+struct viif_l1_edge_enhancement {
+	__u16 gain_min;
+	__u16 gain_max;
+	__u16 lim_min;
+	__u16 lim_max;
+	__u16 coring_min;
+	__u16 coring_max;
+};
+
+/**
+ * struct viif_l1_uv_suppression -  L1ISP UV suppression parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @bk_mp: Black side slope [0..0x3FFF], accuracy: 1/16384
+ * @black: Minimum black side gain [0..0x3FFF], accuracy: 1/16384
+ * @wh_mp: White side slope [0..0x3FFF], accuracy: 1/16384
+ * @white: Minimum white side gain [0..0x3FFF], accuracy: 1/16384
+ * @bk_slv: Black side intercept [0..0xFFFF]
+ * @wh_slv: White side intercept [0..0xFFFF]
+ *
+ * parameter error needs to be returned in "bk_slv >= wh_slv" condition.
+ */
+struct viif_l1_uv_suppression {
+	__u32 bk_mp;
+	__u32 black;
+	__u32 wh_mp;
+	__u32 white;
+	__u16 bk_slv;
+	__u16 wh_slv;
+};
+
+/**
+ * struct viif_l1_coring_suppression -  L1ISP coring suppression parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @lv_min: Minimum coring threshold [0..0xFFFF]
+ * @lv_max: Maximum coring threshold [0..0xFFFF]
+ * @gain_min: Minimum gain [0..0xFFFF], accuracy: 1/65536
+ * @gain_max: Maximum gain [0..0xFFFF], accuracy: 1/65536
+ *
+ * Parameter error needs to be returned in the below condition.
+ * "lv_min > lv_max" or "gain_min > gain_max"
+ */
+struct viif_l1_coring_suppression {
+	__u16 lv_min;
+	__u16 lv_max;
+	__u16 gain_min;
+	__u16 gain_max;
+};
+
+/**
+ * struct viif_l1_edge_suppression -  L1ISP edge suppression parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @gain: Gain of edge color suppression [0..0xFFFF], accuracy: 1/256
+ * @lim: Limiter threshold of edge color suppression [0..15]
+ */
+struct viif_l1_edge_suppression {
+	__u16 gain;
+	__u32 lim;
+};
+
+/**
+ * struct viif_l1_color_level -  L1ISP color level parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @cb_gain: U component gain [0..0xFFF], accuracy: 1/2048
+ * @cr_gain: V component gain [0..0xFFF], accuracy: 1/2048
+ * @cbr_mgain_min: UV component gain [0..0xFFF], accuracy: 1/2048
+ * @cbp_gain_max: Positive U component gain [0..0xFFF], accuracy: 1/2048
+ * @cbm_gain_max: Negative V component gain [0..0xFFF], accuracy: 1/2048
+ * @crp_gain_max: Positive U component gain [0..0xFFF], accuracy: 1/2048
+ * @crm_gain_max: Negative V component gain [0..0xFFF], accuracy: 1/2048
+ */
+struct viif_l1_color_level {
+	__u32 cb_gain;
+	__u32 cr_gain;
+	__u32 cbr_mgain_min;
+	__u32 cbp_gain_max;
+	__u32 cbm_gain_max;
+	__u32 crp_gain_max;
+	__u32 crm_gain_max;
+};
+
+/**
+ * struct viif_l1_img_quality_adjustment_config -  L1ISP image quality
+ * adjustment parameters for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_IMG_QUALITY_ADJUSTMENT`
+ * @coef_cb: Cb coefficient used in RGB to YUV conversion
+ *           [0..0xFFFF], accuracy: 1/65536
+ * @coef_cr: Cr coefficient used in RGB to YUV conversion
+ *           [0..0xFFFF], accuracy: 1/65536
+ * @brightness: Brightness value [-32768..32767] (0 means off)
+ * @linear_contrast: Linear contrast adjustment value
+ *                   [0..0xFF], accuracy: 1/128 (128 means off)
+ * @nonlinear_contrast_addr: Address to a &struct viif_l1_nonlinear_contrast instance.
+ *                           Set 0 to disable nonlinear contrast adjustment.
+ * @lum_noise_reduction_addr: Address to a &struct viif_l1_lum_noise_reduction instance.
+ *                            Set 0 to disable luminance noise reduction.
+ * @edge_enhancement_addr: Address to a &struct viif_l1_edge_enhancement instance.
+ *                         Set 0 to disable edge enhancement,
+ * @uv_suppression_addr: Address to a &struct viif_l1_uv_suppression instance.
+ *                       Set 0 to disable chroma suppression.
+ * @coring_suppression_addr: Address to a &struct viif_l1_coring_suppression instance.
+ *                           Set 0 to disable coring suppression.
+ * @edge_suppression_addr: Address to a &struct viif_l1_edge_suppression instance.
+ *                         Set 0 to disable chroma edge suppression.
+ * @color_level_addr: Address to a &struct viif_l1_color_level instance.
+ *                    Set 0 to disable color level adjustment.
+ * @color_noise_reduction_enable: 1:Enable/0:disable setting of
+ *                                color component noise reduction processing
+ */
+struct viif_l1_img_quality_adjustment_config {
+	__u16 coef_cb;
+	__u16 coef_cr;
+	__s16 brightness;
+	__u8 linear_contrast;
+	__u64 nonlinear_contrast_addr;
+	__u64 lum_noise_reduction_addr;
+	__u64 edge_enhancement_addr;
+	__u64 uv_suppression_addr;
+	__u64 coring_suppression_addr;
+	__u64 edge_suppression_addr;
+	__u64 color_level_addr;
+	__u32 color_noise_reduction_enable;
+};
+
+/**
+ * struct viif_l1_avg_lum_generation_config - L1ISP average luminance generation configuration
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L1_SET_AVG_LUM_GENERATION`
+ * @aexp_start_x: horizontal position of block[0] [0.."width of input image - 1"] [pixel]
+ * @aexp_start_y: vertical position of block[0] [0.."height of input image - 1"] [line]
+ * @aexp_block_width: width of one block(needs to be multiple of 64)
+ *                    [64.."width of input image"] [pixel]
+ * @aexp_block_height: height of one block(needs to be multiple of 64)
+ *                     [64.."height of input image"] [line]
+ * @aexp_weight: weight of each block [0..3]  [y][x]:
+ *               y means vertical position and x means horizontal position
+ * @aexp_satur_ratio: threshold to judge whether saturated block or not [0..256]
+ * @aexp_black_ratio: threshold to judge whether black block or not [0..256]
+ * @aexp_satur_level: threshold to judge whether saturated pixel or not [0x0..0xffffff]
+ * @aexp_ave4linesy: vertical position of the initial line
+ *                   for 4-lines average luminance [0.."height of input image - 4"] [line]
+ */
+struct viif_l1_avg_lum_generation_config {
+	__u32 aexp_start_x;
+	__u32 aexp_start_y;
+	__u32 aexp_block_width;
+	__u32 aexp_block_height;
+	__u32 aexp_weight[8][8];
+	__u32 aexp_satur_ratio;
+	__u32 aexp_black_ratio;
+	__u32 aexp_satur_level;
+	__u32 aexp_ave4linesy[4];
+};
+
+/**
+ * enum viif_l2_undist_mode - L2ISP undistortion mode
+ * @VIIF_L2_UNDIST_POLY: polynomial mode
+ * @VIIF_L2_UNDIST_GRID: grid table mode
+ * @VIIF_L2_UNDIST_POLY_TO_GRID: polynomial, then grid table mode
+ * @VIIF_L2_UNDIST_GRID_TO_POLY: grid table, then polynomial mode
+ */
+enum viif_l2_undist_mode {
+	VIIF_L2_UNDIST_POLY = 0,
+	VIIF_L2_UNDIST_GRID = 1,
+	VIIF_L2_UNDIST_POLY_TO_GRID = 2,
+	VIIF_L2_UNDIST_GRID_TO_POLY = 3,
+};
+
+/**
+ * struct viif_l2_undist - L2ISP UNDIST parameters
+ * for &struct viif_l2_undist_config
+ * @through_mode: 1:enable or 0:disable through mode of undistortion
+ * @roi_mode: &enum viif_l2_undist_mode value. Sets L2ISP undistortion mode.
+ * @sensor_crop_ofs_h: Horizontal start position of sensor crop area[pixel]
+ *                     [-4296..4296], accuracy: 1/2
+ * @sensor_crop_ofs_v: Vertical start position of sensor crop area[line]
+ *                     [-2360..2360], accuracy: 1/2
+ * @norm_scale: Normalization coefficient for distance from center
+ *              [0..1677721], accuracy: 1/33554432
+ * @valid_r_norm2_poly: Setting target area for polynomial correction
+ *                      [0..0x3FFFFFF], accuracy: 1/33554432
+ * @valid_r_norm2_grid: Setting target area for grid table correction
+ *                      [0..0x3FFFFFF], accuracy: 1/33554432
+ * @roi_write_area_delta: Error adjustment value of forward function and
+ *                        inverse function for pixel position calculation
+ *                        [0..0x7FF], accuracy: 1/1024
+ * @poly_write_g_coef: 10th-order polynomial coefficient for G write pixel position calculation
+ *                     [-2147352576..2147352576], accuracy: 1/131072
+ * @poly_read_b_coef: 10th-order polynomial coefficient for B read pixel position calculation
+ *                    [-2147352576..2147352576], accuracy: 1/131072
+ * @poly_read_g_coef: 10th-order polynomial coefficient for G read pixel position calculation
+ *                    [-2147352576..2147352576], accuracy: 1/131072
+ * @poly_read_r_coef: 10th-order polynomial coefficient for R read pixel position calculation
+ *                    [-2147352576..2147352576], accuracy: 1/131072
+ * @grid_node_num_h: Number of horizontal grids [16..64]
+ * @grid_node_num_v: Number of vertical grids [16..64]
+ * @grid_patch_hsize_inv: Inverse pixel size between horizontal grids
+ *                        [0..0x7FFFFF], accuracy: 1/8388608
+ * @grid_patch_vsize_inv: Inverse pixel size between vertical grids
+ *                        [0..0x7FFFFF], accuracy: 1/8388608
+ */
+struct viif_l2_undist {
+	__u32 through_mode;
+	__u32 roi_mode[2];
+	__s32 sensor_crop_ofs_h;
+	__s32 sensor_crop_ofs_v;
+	__u32 norm_scale;
+	__u32 valid_r_norm2_poly;
+	__u32 valid_r_norm2_grid;
+	__u32 roi_write_area_delta[2];
+	__s32 poly_write_g_coef[11];
+	__s32 poly_read_b_coef[11];
+	__s32 poly_read_g_coef[11];
+	__s32 poly_read_r_coef[11];
+	__u32 grid_node_num_h;
+	__u32 grid_node_num_v;
+	__u32 grid_patch_hsize_inv;
+	__u32 grid_patch_vsize_inv;
+};
+
+/**
+ * struct viif_l2_undist_config - L2ISP UNDIST parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_UNDIST`
+ * @param: &struct viif_l2_undist
+ * @write_g_addr: Address to write-G grid table.
+ *                Table size is specified by member size.
+ *                Set 0 to disable this table.
+ * @read_b_addr: Address to read-B grid table.
+ *               Table size is specified by member size.
+ *               Set 0 to disable this table.
+ * @read_g_addr: Address to read-G grid table.
+ *               Table size is specified by member size.
+ *               Set 0 to disable this table.
+ * @read_r_addr: Address to read-R grid table.
+ *               Table size is specified by member size.
+ *               Set 0 to disable this table.
+ * @size: Table size [byte]. Range: [1024..8192] or 0.
+ *        The value should be "grid_node_num_h * grid_node_num_v * 4".
+ *        See also &struct viif_l2_undist.
+ *        Set 0 if NULL is set for all tables.
+ *        Set valid size value if at least one table is valid.
+ *
+ * Application should make sure that the table data is based on HW specification
+ * since this driver does not check the contents of specified grid table.
+ */
+struct viif_l2_undist_config {
+	struct viif_l2_undist param;
+	__u64 write_g_addr;
+	__u64 read_b_addr;
+	__u64 read_g_addr;
+	__u64 read_r_addr;
+	__u32 size;
+};
+
+/**
+ * struct viif_l2_roi_config - L2ISP ROI parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_ROI`
+ * @roi_num:
+ *     1 when only capture path0 is activated,
+ *     2 when both capture path 0 and path 1 are activated.
+ * @roi_scale: Scale value for each ROI [32768..131072], accuracy: 1/65536
+ * @roi_scale_inv: Inverse scale value for each ROI [32768..131072], accuracy: 1/65536
+ * @corrected_wo_scale_hsize: Corrected image width for each ROI [pixel] [128..8190]
+ * @corrected_wo_scale_vsize: Corrected image height for each ROI [line] [128..4094]
+ * @corrected_hsize: Corrected and scaled image width for each ROI [pixel] [128..8190]
+ * @corrected_vsize: Corrected and scaled image height for each ROI [line] [128..4094]
+ */
+struct viif_l2_roi_config {
+	__u32 roi_num;
+	__u32 roi_scale[2];
+	__u32 roi_scale_inv[2];
+	__u32 corrected_wo_scale_hsize[2];
+	__u32 corrected_wo_scale_vsize[2];
+	__u32 corrected_hsize[2];
+	__u32 corrected_vsize[2];
+};
+
+/** enum viif_gamma_mode - Gamma correction mode
+ *
+ * @VIIF_GAMMA_COMPRESSED: compressed table mode
+ * @VIIF_GAMMA_LINEAR: linear table mode
+ */
+enum viif_gamma_mode {
+	VIIF_GAMMA_COMPRESSED = 0,
+	VIIF_GAMMA_LINEAR = 1,
+};
+
+/**
+ * struct viif_l2_gamma_config - L2ISP gamma correction parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_ISP_L2_SET_GAMMA`
+ * @pathid: 0 for Capture Path 0, 1 for Capture Path 1.
+ * @enable: 1:Enable, 0:Disable settings of L2ISP gamma correction control
+ * @vsplit: Line switching position of first table and second table [line] [0..4094].
+ *          Should set 0 in case 0 is set to @enable
+ * @mode: &enum viif_gamma_mode value.
+ *        Should set VIIF_GAMMA_COMPRESSED when 0 is set to @enable
+ * @table_addr: Address to gamma table for L2ISP gamma.
+ *              The table has 6 channels;
+ *              [0]: G/Y(1st table), [1]: G/Y(2nd table), [2]: B/U(1st table)
+ *              [3]: B/U(2nd table), [4]: R/V(1st table), [5]: R/V(2nd table)
+ *              Each channel of the table is __u16 typed and 512 bytes.
+ */
+struct viif_l2_gamma_config {
+	__u32 pathid;
+	__u32 enable;
+	__u32 vsplit;
+	__u32 mode;
+	__u64 table_addr[6];
+};
+
+/**
+ * enum viif_csi2_cal_status - CSI2RX calibration status
+ *
+ * @VIIF_CSI2_CAL_NOT_DONE: Calibration not complete
+ * @VIIF_CSI2_CAL_SUCCESS: Calibration success
+ * @VIIF_CSI2_CAL_FAIL: Calibration failed
+ */
+enum viif_csi2_cal_status {
+	VIIF_CSI2_CAL_NOT_DONE = 0,
+	VIIF_CSI2_CAL_SUCCESS = 1,
+	VIIF_CSI2_CAL_FAIL = 2,
+};
+
+/**
+ * struct viif_csi2rx_dphy_calibration_status - CSI2-RX D-PHY Calibration
+ * information for :ref:`V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS`
+ * @term_cal_with_rext: Result of termination calibration with rext
+ * @clock_lane_offset_cal: Result of offset calibration of clock lane
+ * @data_lane0_offset_cal: Result of offset calibration of data lane0
+ * @data_lane1_offset_cal: Result of offset calibration of data lane1
+ * @data_lane2_offset_cal: Result of offset calibration of data lane2
+ * @data_lane3_offset_cal: Result of offset calibration of data lane3
+ * @data_lane0_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane0
+ * @data_lane1_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane1
+ * @data_lane2_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane2
+ * @data_lane3_ddl_tuning_cal: Result of digital delay line tuning calibration of data lane3
+ *
+ * Values for each member is typed &enum viif_csi2_cal_status.
+ */
+struct viif_csi2rx_dphy_calibration_status {
+	__u32 term_cal_with_rext;
+	__u32 clock_lane_offset_cal;
+	__u32 data_lane0_offset_cal;
+	__u32 data_lane1_offset_cal;
+	__u32 data_lane2_offset_cal;
+	__u32 data_lane3_offset_cal;
+	__u32 data_lane0_ddl_tuning_cal;
+	__u32 data_lane1_ddl_tuning_cal;
+	__u32 data_lane2_ddl_tuning_cal;
+	__u32 data_lane3_ddl_tuning_cal;
+};
+
+/**
+ * struct viif_csi2rx_err_status - CSI2RX Error status parameters
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS`
+ * @err_phy_fatal: D-PHY FATAL error.
+ *
+ *  * bit[3]: Start of transmission error on DATA Lane3.
+ *  * bit[2]: Start of transmission error on DATA Lane2.
+ *  * bit[1]: Start of transmission error on DATA Lane1.
+ *  * bit[0]: Start of transmission error on DATA Lane0.
+ * @err_pkt_fatal: Packet FATAL error.
+ *
+ *  * bit[16]: Header ECC contains 2 errors, unrecoverable.
+ *  * bit[3]: Checksum error detected on virtual channel 3.
+ *  * bit[2]: Checksum error detected on virtual channel 2.
+ *  * bit[1]: Checksum error detected on virtual channel 1.
+ *  * bit[0]: Checksum error detected on virtual channel 0.
+ * @err_frame_fatal: Frame FATAL error.
+ *
+ *  * bit[19]: Last received Frame, in virtual channel 3, has at least one CRC error.
+ *  * bit[18]: Last received Frame, in virtual channel 2, has at least one CRC error.
+ *  * bit[17]: Last received Frame, in virtual channel 1, has at least one CRC error.
+ *  * bit[16]: Last received Frame, in virtual channel 0, has at least one CRC error.
+ *  * bit[11]: Incorrect Frame Sequence detected in virtual channel 3.
+ *  * bit[10]: Incorrect Frame Sequence detected in virtual channel 2.
+ *  * bit[9]: Incorrect Frame Sequence detected in virtual channel 1.
+ *  * bit[8]: Incorrect Frame Sequence detected in virtual channel 0.
+ *  * bit[3]: Error matching Frame Start with Frame End for virtual channel 3.
+ *  * bit[2]: Error matching Frame Start with Frame End for virtual channel 2.
+ *  * bit[1]: Error matching Frame Start with Frame End for virtual channel 1.
+ *  * bit[0]: Error matching Frame Start with Frame End for virtual channel 0.
+ * @err_phy: D-PHY error.
+ *
+ *  * bit[19]: Escape Entry Error on Data Lane 3.
+ *  * bit[18]: Escape Entry Error on Data Lane 2.
+ *  * bit[17]: Escape Entry Error on Data Lane 1.
+ *  * bit[16]: Escape Entry Error on Data Lane 0.
+ *  * bit[3]: Start of Transmission Error on Data Lane 3 (synchronization can still be achieved).
+ *  * bit[2]: Start of Transmission Error on Data Lane 2 (synchronization can still be achieved).
+ *  * bit[1]: Start of Transmission Error on Data Lane 1 (synchronization can still be achieved).
+ *  * bit[0]: Start of Transmission Error on Data Lane 0 (synchronization can still be achieved).
+ * @err_pkt: Packet error.
+ *
+ *  * bit[19]: Header Error detected and corrected on virtual channel 3.
+ *  * bit[18]: Header Error detected and corrected on virtual channel 2.
+ *  * bit[17]: Header Error detected and corrected on virtual channel 1.
+ *  * bit[16]: Header Error detected and corrected on virtual channel 0.
+ *  * bit[3]: Unrecognized or unimplemented data type detected in virtual channel 3.
+ *  * bit[2]: Unrecognized or unimplemented data type detected in virtual channel 2.
+ *  * bit[1]: Unrecognized or unimplemented data type detected in virtual channel 1.
+ *  * bit[0]: Unrecognized or unimplemented data type detected in virtual channel 0.
+ * @err_line: Line error.
+ *
+ *  * bit[23]: Error in the sequence of lines for vc7 and dt7.
+ *  * bit[22]: Error in the sequence of lines for vc6 and dt6.
+ *  * bit[21]: Error in the sequence of lines for vc5 and dt5.
+ *  * bit[20]: Error in the sequence of lines for vc4 and dt4.
+ *  * bit[19]: Error in the sequence of lines for vc3 and dt3.
+ *  * bit[18]: Error in the sequence of lines for vc2 and dt2.
+ *  * bit[17]: Error in the sequence of lines for vc1 and dt1.
+ *  * bit[16]: Error in the sequence of lines for vc0 and dt0.
+ *  * bit[7]: Error matching Line Start with Line End for vc7 and dt7.
+ *  * bit[6]: Error matching Line Start with Line End for vc6 and dt6.
+ *  * bit[5]: Error matching Line Start with Line End for vc5 and dt5.
+ *  * bit[4]: Error matching Line Start with Line End for vc4 and dt4.
+ *  * bit[3]: Error matching Line Start with Line End for vc3 and dt3.
+ *  * bit[2]: Error matching Line Start with Line End for vc2 and dt2.
+ *  * bit[1]: Error matching Line Start with Line End for vc1 and dt1.
+ *  * bit[0]: Error matching Line Start with Line End for vc0 and dt0.
+ */
+struct viif_csi2rx_err_status {
+	__u32 err_phy_fatal;
+	__u32 err_pkt_fatal;
+	__u32 err_frame_fatal;
+	__u32 err_phy;
+	__u32 err_pkt;
+	__u32 err_line;
+};
+
+/**
+ * struct viif_l1_info - L1ISP AWB information
+ * for &struct viif_isp_capture_status
+ * @avg_lum_weight: weighted average luminance value at average luminance generation
+ * @avg_lum_block: average luminance of each block [y][x]:
+ *                 y means vertical position and x means horizontal position
+ * @avg_lum_four_line_lum: 4-lines average luminance.
+ *                         avg_lum_four_line_lum[n] corresponds to aexp_ave4linesy[n]
+ * @avg_satur_pixnum: the number of saturated pixel at average luminance generation
+ * @avg_black_pixnum: the number of black pixel at average luminance generation
+ * @awb_ave_u: U average value of AWB adjustment [pixel]
+ * @awb_ave_v: V average value of AWB adjustment [pixel]
+ * @awb_accumulated_pixel: Accumulated pixel count of AWB adjustment
+ * @awb_gain_r: R gain used in the next frame of AWB adjustment
+ * @awb_gain_g: G gain used in the next frame of AWB adjustment
+ * @awb_gain_b: B gain used in the next frame of AWB adjustment
+ * @awb_status_u: boolean value of U convergence state of AWB adjustment
+ *                (0: not-converged, 1: converged)
+ * @awb_status_v: boolean value of V convergence state of AWB adjustment
+ *                (0: not-converged, 1: converged)
+ */
+struct viif_l1_info {
+	__u32 avg_lum_weight;
+	__u32 avg_lum_block[8][8];
+	__u32 avg_lum_four_line_lum[4];
+	__u32 avg_satur_pixnum;
+	__u32 avg_black_pixnum;
+	__u32 awb_ave_u;
+	__u32 awb_ave_v;
+	__u32 awb_accumulated_pixel;
+	__u32 awb_gain_r;
+	__u32 awb_gain_g;
+	__u32 awb_gain_b;
+	__u8 awb_status_u;
+	__u8 awb_status_v;
+};
+
+/**
+ * struct viif_isp_capture_status - L1ISP capture information
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS`
+ * @l1_info: L1ISP AWB information. Refer to &struct viif_l1_info
+ */
+struct viif_isp_capture_status {
+	struct viif_l1_info l1_info;
+};
+
+/**
+ * struct viif_reported_errors - Errors since last call
+ * for :ref:`V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS`
+ * @main: error flag value for capture device 0 and 1
+ * @sub: error flag value for capture device 2
+ * @csi2rx: error flag value for CSI2 receiver
+ */
+struct viif_reported_errors {
+	__u32 main;
+	__u32 sub;
+	__u32 csi2rx;
+};
+
+#endif /* __UAPI_VISCONTI_VIIF_H_ */
-- 
2.17.1


