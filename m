Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3164FED2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 04:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiDMCwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 22:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiDMCwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 22:52:40 -0400
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1514.securemx.jp [210.130.202.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DAF50474;
        Tue, 12 Apr 2022 19:50:20 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1514) id 23D2csUQ003710; Wed, 13 Apr 2022 11:38:54 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 23D2c9Qc011339; Wed, 13 Apr 2022 11:38:09 +0900
X-Iguazu-Qid: 34trDs1hq0JERxbtvy
X-Iguazu-QSIG: v=2; s=0; t=1649817488; q=34trDs1hq0JERxbtvy; m=EMbBsPJxUhUuICnpyUd8iCxtMX8Ad7vet62KsFMSKN0=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1513) id 23D2c8cB009887
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Apr 2022 11:38:08 +0900
X-SA-MID: 2294325
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH 2/3] media: platform: visconti: Add Toshiba Visconti Video Input Interface driver
Date:   Wed, 13 Apr 2022 11:32:33 +0900
X-TSB-HOP2: ON
Message-Id: <20220413023234.19526-3-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220413023234.19526-1-yuji2.ishikawa@toshiba.co.jp>
References: <20220413023234.19526-1-yuji2.ishikawa@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
The Video Input Interface includes CSI2 receiver, frame grabber and image signal processor.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/media/platform/Kconfig                |    2 +
 drivers/media/platform/Makefile               |    4 +
 drivers/media/platform/visconti/Kconfig       |    9 +
 drivers/media/platform/visconti/Makefile      |    9 +
 drivers/media/platform/visconti/hwd_viif.c    | 2233 ++++++++++
 drivers/media/platform/visconti/hwd_viif.h    | 1776 ++++++++
 .../media/platform/visconti/hwd_viif_csi2rx.c |  767 ++++
 .../platform/visconti/hwd_viif_internal.h     |  361 ++
 .../media/platform/visconti/hwd_viif_l1isp.c  | 3769 +++++++++++++++++
 .../media/platform/visconti/hwd_viif_reg.h    | 2802 ++++++++++++
 drivers/media/platform/visconti/viif.c        | 2384 +++++++++++
 drivers/media/platform/visconti/viif.h        |  134 +
 include/uapi/linux/visconti_viif.h            | 1683 ++++++++
 13 files changed, 15933 insertions(+)
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
index 000000000..446c809d4
--- /dev/null
+++ b/drivers/media/platform/visconti/Kconfig
@@ -0,0 +1,9 @@
+config VIDEO_VISCONTI_VIIF
+	bool "Visconti Camera Interface driver"
+	depends on VIDEO_V4L2 && MEDIA_CONTROLLER
+	depends on ARCH_VISCONTI
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_FWNODE
+	help
+	  This is V4L2 driver for Toshiba Visconti Camera Interface driver
+
diff --git a/drivers/media/platform/visconti/Makefile b/drivers/media/platform/visconti/Makefile
new file mode 100644
index 000000000..3a9e04d0b
--- /dev/null
+++ b/drivers/media/platform/visconti/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Visconti video input device driver
+#
+
+visconti-viif-objs = viif.o
+visconti-viif-objs += hwd_viif_csi2rx.o hwd_viif.o hwd_viif_l1isp.o
+
+obj-$(CONFIG_VIDEO_VISCONTI_VIIF) += visconti-viif.o
diff --git a/drivers/media/platform/visconti/hwd_viif.c b/drivers/media/platform/visconti/hwd_viif.c
new file mode 100644
index 000000000..518a86d56
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif.c
@@ -0,0 +1,2233 @@
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
+static struct hwd_viif_res hwd_VIIF0_res = {
+	.ch = 0,
+	.csi2rx_type = HWD_VIIF_CSI2_TYPE_4_LANES,
+	.sram_size_w_port = 0x200,
+	.sram_size_r_port = 0x200,
+	.sram_start_addr_gamma = 0x640,
+	.interpolation_mode = HWD_VIIF_L1_INPUT_INTERPOLATION_LINE,
+	.input_num = 1U,
+	.hobc_size = 0U,
+	.rawpack = HWD_VIIF_RAWPACK_DISABLE,
+	.l2_input = 0U,
+	.color_type = 0U,
+	.run_flag_main = (bool)false,
+};
+
+static struct hwd_viif_res hwd_VIIF1_res = {
+	.ch = 1,
+	.csi2rx_type = HWD_VIIF_CSI2_TYPE_4_LANES,
+	.sram_size_w_port = 0x200,
+	.sram_size_r_port = 0x200,
+	.sram_start_addr_gamma = 0x640,
+	.interpolation_mode = HWD_VIIF_L1_INPUT_INTERPOLATION_LINE,
+	.input_num = 1U,
+	.hobc_size = 0U,
+	.rawpack = HWD_VIIF_RAWPACK_DISABLE,
+	.l2_input = 0U,
+	.color_type = 0U,
+	.run_flag_main = (bool)false,
+};
+
+/**
+ * viif_id2res() - resource data for specified module ID
+ * 
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: Pointer to resource access structure
+ */
+struct hwd_viif_res *viif_id2res(uint32_t module_id)
+{
+	return (module_id == 0) ? &hwd_VIIF0_res : &hwd_VIIF1_res;
+}
+
+/**
+ * hwd_VIIF_initialize() - Initialize VIIF HWD layer.
+ *
+ * @csi2host_vaddr: VIIF CSI-2 RX register base address(virtual address)
+ * @capture_vaddr: VIIF capture(system, vdmac, l1isp, l2isp) register base address(virtual address)
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ */
+int32_t hwd_VIIF_initialize(uint32_t module_id, void *csi2host_vaddr, void *capture_vaddr)
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
+ * hwd_VIIF_uninitialize() - De-initialize VIIF HWD layer.
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ */
+int32_t hwd_VIIF_uninitialize(uint32_t module_id)
+{
+	return 0;
+}
+
+/**
+ * hwd_VIIF_force_stop() - Stop memory input or CSI2 input
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -ETIMEDOUT Driver timeout error
+ */
+int32_t hwd_VIIF_force_stop(uint32_t module_id)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	int32_t ret = 0;
+	uint32_t val;
+
+	if ((res->ch != 0U) && (res->ch != 1U))
+		return -EINVAL;
+
+	/* Disable auto transmission of register buffer */
+	writel(0, &(res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF));
+	writel(0, &(res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF));
+
+	/* Wait for completion of register buffer transmission */
+	udelay(HWD_VIIF_WAIT_ISP_REGBF_TRNS_COMPLETE_TIME);
+
+	if (res->ch == 1U) {
+		/* Disable VOIF through input */
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.CSI2THROUGHEN));
+	}
+
+	/* Stop internal input */
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.IPORTI_M_SYNCEN));
+
+	/* Stop all VCs, long packet input and emb data input of MAIN unit */
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.VCPORTEN));
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.IPORTM_OTHEREN));
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.IPORTM_EMBEN));
+
+	/* Stop image data input, long packet input and emb data input of SUB unit */
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.IPORTS_OTHEREN));
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.IPORTS_EMBEN));
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.IPORTS_IMGEN));
+
+	/* Stop VDMAC for all table ports, input ports and write ports */
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->vdm.VDM_T_ENABLE));
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->vdm.VDM_R_ENABLE));
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->vdm.VDM_W_ENABLE));
+
+	/* abort all groups of VDMAC */
+	/* g00, g01 and g01 */
+	val = 0x7U;
+	writel(val, &(res->capture_reg->vdm.VDM_ABORTSET));
+
+	/* Clear run flag of MAIN unit */
+	res->run_flag_main = false;
+
+	return ret;
+}
+
+#define VIIF_M_STATUS_DELAY_INT_FLAG BIT(24)
+#define VIIF_S_STATUS_DELAY_INT_FLAG BIT(24)
+
+/**
+ * hwd_VIIF_get_failure_status() - Get failure information of delayed vsync generating circuit and ecc circuit
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * @is_vsync_failure_main: vsync failure information of MAIN unit
+ * @is_vsync_failure_sub: vsync failure information of SUB unit(CH0/CH1) or VOIF loopback unit(CH2)
+ * @ecc_failure: failure information of ECC(CH0/CH1)
+ * Return: -EINVAL Parameter error
+ * - "is_vsync_failure_main", "is_vsync_failure_sub" or "ecc_failure" is NULL
+ */
+int32_t hwd_VIIF_get_failure_status(uint32_t module_id, bool *is_vsync_failure_main,
+				    bool *is_vsync_failure_sub, uint32_t *ecc_failure)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if ((is_vsync_failure_main == NULL) || (is_vsync_failure_sub == NULL) ||
+	    (ecc_failure == NULL)) {
+		return -EINVAL;
+	}
+
+	*is_vsync_failure_main = false;
+	*is_vsync_failure_sub = false;
+	*ecc_failure = 0U;
+
+	if ((readl(&res->capture_reg->sys.INT_M_STATUS) & VIIF_M_STATUS_DELAY_INT_FLAG))
+		*is_vsync_failure_main = true;
+
+	if ((readl(&res->capture_reg->sys.INT_S_STATUS) & VIIF_S_STATUS_DELAY_INT_FLAG))
+		*is_vsync_failure_sub = true;
+
+	if (res->ch != 2U)
+		*ecc_failure = readl(&res->capture_reg->sys.MEM_ECC_DCLS_ALARM);
+
+	return 0;
+}
+
+/* Convert the unit of time-period (from sysclk, to num lines in the image) */
+#define SYSCLK_TO_NUMLINES(time_in_sysclk, img)                                                    \
+	((uint32_t)(((time_in_sysclk) * (uint64_t)(img)->pixel_clock) /                            \
+		    ((uint64_t)(img)->htotal_size * (HWD_VIIF_SYS_CLK))))
+
+#define LINEPERIOD_IN_SYSCLK(hsize, pixel_clock)                                                   \
+	((uint32_t)((uint64_t)(hsize)*HWD_VIIF_SYS_CLK / (uint64_t)(pixel_clock)))
+
+/**
+ * hwd_VIIF_main_set_unit_w_isp() - Set static configuration of MAIN unit(CH0 or CH1)
+ *
+ * @dt_image: DT of image [0x0, 0x10-0x17, 0x1B, 0x1E, 0x1F, 0x22, 0x24-0x27, 0x2A-0x3F])
+ * @dt_long_packet: DT of long packet data [0x0, 0x10-0x3F]
+ * @in_img: Pointer to input image information
+ * @color_type: Color type of image [0x0, 0x1E, 0x1F, 0x22, 0x24, 0x2A-0x2D]
+ * @rawpack: RAW pack mode. For more refer @ref hwd_VIIF_raw_pack_mode
+ * @yuv_conv: YUV422 to YUV444 conversion mode. For more refer @ref hwd_VIIF_yuv_conversion_mode
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "dt_image" is out of range
+ * - [2] "dt_long_packet" is out of range
+ * - [3] Both "dt_image" and "dt_long_packet" are 0x0
+ * - [4] "in_img" is NULL
+ * - [5] member of "in_img" is invalid
+ * - [6] "color_type" is out of range
+ * - [7] "color_type" doesn't meet the condition shown in the below note
+ * - [8] "rawpack" is out of range
+ * - [9] "rawpack" is not HWD_VIIF_RAWPACK_DISABLE when color_type is other than RAW(0x2A-0x2C)
+ * - [10] "yuv_conv" is out of range
+ * - [11] "yuv_conv" is not HWD_VIIF_YUV_CONV_REPEAT when color_type is other than YUV422(0x1E or 0x1F)
+ *
+ * Note: valid combination between "dt_image" and "color_type" is
+ * - when "dt_image" is [0x10-0x17, 0x1B, 0x25-0x27, 0x2E-0x3F], "color_type" must be [0x2A-0x2D].
+ * - when "dt_image" is valid value and other than [0x10-0x17, 0x1B, 0x25-0x27, 0x2E-0x3F], "color_type" must be "dt_image"
+ */
+int32_t hwd_VIIF_main_set_unit_w_isp(uint32_t module_id, uint32_t dt_image, uint32_t dt_long_packet,
+				     const struct hwd_viif_input_img *in_img, uint32_t color_type,
+				     uint32_t rawpack, uint32_t yuv_conv)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val, color, sysclk_num;
+	uint32_t sw_delay0, sw_delay1, hw_delay;
+	uint32_t total_hact_size = 0U, total_vact_size = 0U;
+
+	/* 0x00-0x09: ShortPacket/Undefined */
+	if ((dt_image > 0U) && (dt_image < 0x10U))
+		return -EINVAL;
+
+	/* 0x18-0x1A: YUV420 */
+	if ((dt_image > 0x17U) && (dt_image < 0x1bU))
+		return -EINVAL;
+
+	/*  0x1C-0x1D: YUV420 CSPS */
+	if ((dt_image > 0x1bU) && (dt_image < 0x1eU))
+		return -EINVAL;
+
+	/* 0x20,0x21,0x23: RGB444, RGB555, RGB666 */
+	if ((dt_image > 0x1fU) && (dt_image < 0x22U))
+		return -EINVAL;
+
+	if (dt_image == 0x23U)
+		return -EINVAL;
+
+	/* 0x28-0x29: RAW6, RAW7 */
+	if ((dt_image > 0x27U) && (dt_image < 0x2aU))
+		return -EINVAL;
+
+	/* 0x2E-: not supported */
+	if (dt_image > HWD_VIIF_CSI2_MAX_DT)
+		return -EINVAL;
+
+	if (
+		/*Case: Generic Long Packet, Reserved, User-Defined*/
+		((dt_image >= 0x10U) && (dt_image <= 0x17U)) || (dt_image == 0x1bU) ||
+		((dt_image >= 0x25U) && (dt_image <= 0x27U)) || (dt_image >= 0x2eU)) {
+		if ((color_type != CSI2_DT_RAW8) && (color_type != CSI2_DT_RAW10) &&
+		    (color_type != CSI2_DT_RAW12) && (color_type != CSI2_DT_RAW14)) {
+			return -EINVAL;
+		}
+	} else {
+		/*Case: Otherwise: YUV, RGB, RAW*/
+		/*Constraint: color_type must be dt_image*/
+		if (color_type != dt_image)
+			return -EINVAL;
+	}
+	if (((dt_long_packet > 0x0U) && (dt_long_packet < 0x10U)) ||
+	    (dt_long_packet > HWD_VIIF_CSI2_MAX_DT)) {
+		return -EINVAL;
+	}
+	if ((dt_image == 0U) && (dt_long_packet == 0U))
+		return -EINVAL;
+
+	if (in_img == NULL)
+		return -EINVAL;
+	if ((rawpack != HWD_VIIF_RAWPACK_DISABLE) && (rawpack != HWD_VIIF_RAWPACK_MSBFIRST) &&
+	    (rawpack != HWD_VIIF_RAWPACK_LSBFIRST)) {
+		return -EINVAL;
+	}
+	if ((color_type != CSI2_DT_RAW8) && (color_type != CSI2_DT_RAW10) &&
+	    (color_type != CSI2_DT_RAW12) && (rawpack != HWD_VIIF_RAWPACK_DISABLE)) {
+		return -EINVAL;
+	}
+
+	if (dt_image == 0U) {
+		/* only long packet data */
+		if ((in_img->pixel_clock != 0U) ||
+		    (in_img->htotal_size < HWD_VIIF_MIN_HTOTAL_NSEC) ||
+		    (in_img->htotal_size > HWD_VIIF_MAX_HTOTAL_NSEC) ||
+		    (in_img->vbp_size < HWD_VIIF_MIN_VBP_PACKET) ||
+		    (in_img->vbp_size > HWD_VIIF_MAX_VBP_PACKET) || (in_img->hactive_size != 0U) ||
+		    (in_img->vtotal_size != 0U) || (in_img->vactive_size != 0U) ||
+		    (in_img->interpolation_mode != HWD_VIIF_L1_INPUT_INTERPOLATION_LINE) ||
+		    (in_img->input_num != HWD_VIIF_L1_INPUT_NUM_MIN) ||
+		    (in_img->hobc_width != 0U) || (in_img->hobc_margin != 0U)) {
+			return -EINVAL;
+		}
+	} else {
+		/* image data will be input */
+		if ((in_img->pixel_clock < HWD_VIIF_MIN_PIXEL_CLOCK) ||
+		    (in_img->pixel_clock > HWD_VIIF_MAX_PIXEL_CLOCK) ||
+		    (in_img->htotal_size < HWD_VIIF_MIN_HTOTAL_PIXEL) ||
+		    (in_img->htotal_size > HWD_VIIF_MAX_HTOTAL_PIXEL) ||
+		    (in_img->vtotal_size < HWD_VIIF_MIN_VTOTAL_LINE) ||
+		    (in_img->vtotal_size > HWD_VIIF_MAX_VTOTAL_LINE) ||
+		    (in_img->vbp_size < HWD_VIIF_MIN_VBP_LINE) ||
+		    (in_img->vbp_size > HWD_VIIF_MAX_VBP_LINE) ||
+		    ((in_img->hactive_size % 2U) != 0U) || ((in_img->vactive_size % 2U) != 0U)) {
+			return -EINVAL;
+		}
+
+		if ((in_img->interpolation_mode != HWD_VIIF_L1_INPUT_INTERPOLATION_LINE) &&
+		    (in_img->interpolation_mode != HWD_VIIF_L1_INPUT_INTERPOLATION_PIXEL)) {
+			return -EINVAL;
+		}
+
+		if ((in_img->input_num < HWD_VIIF_L1_INPUT_NUM_MIN) ||
+		    (in_img->input_num > HWD_VIIF_L1_INPUT_NUM_MAX)) {
+			return -EINVAL;
+		}
+
+		if ((in_img->hobc_width != 0U) && (in_img->hobc_width != 16U) &&
+		    (in_img->hobc_width != 32U) && (in_img->hobc_width != 64U) &&
+		    (in_img->hobc_width != 128U)) {
+			return -EINVAL;
+		}
+
+		if ((in_img->hobc_margin > 30U) || ((in_img->hobc_margin % 2U) != 0U))
+			return -EINVAL;
+
+		if ((in_img->hobc_width == 0U) && (in_img->hobc_margin != 0U))
+			return -EINVAL;
+
+		if ((in_img->hobc_width != 0U) && (in_img->hobc_margin == 0U))
+			return -EINVAL;
+
+		if ((color_type == CSI2_DT_RAW8) || (color_type == CSI2_DT_RAW10) ||
+		    (color_type == CSI2_DT_RAW12) || (color_type == CSI2_DT_RAW14)) {
+			/* parameter check in case of L1ISP(in case of RAW) */
+			if ((in_img->hactive_size < HWD_VIIF_MIN_HACTIVE_PIXEL_W_L1ISP) ||
+			    (in_img->hactive_size > HWD_VIIF_MAX_HACTIVE_PIXEL_W_L1ISP) ||
+			    (in_img->vactive_size < HWD_VIIF_MIN_VACTIVE_LINE_W_L1ISP) ||
+			    (in_img->vactive_size > HWD_VIIF_MAX_VACTIVE_LINE_W_L1ISP) ||
+			    ((in_img->hactive_size % 8U) != 0U)) {
+				return -EINVAL;
+			}
+
+			/* check vbp range in case of L1ISP on */
+			/* the constant value "7" is configuration margin */
+			val = SYSCLK_TO_NUMLINES(HWD_VIIF_TABLE_LOAD_TIME +
+							 HWD_VIIF_REGBUF_ACCESS_TIME * 2U,
+						 in_img) +
+			      HWD_VIIF_L1_DELAY_W_HDRC + 7U;
+			if (in_img->vbp_size < val)
+				return -EINVAL;
+
+			/* calculate total of horizontal active size and vertical active size */
+			if (rawpack != HWD_VIIF_RAWPACK_DISABLE) {
+				val = (in_img->hactive_size + in_img->hobc_width +
+				       in_img->hobc_margin) *
+				      2U;
+			} else {
+				val = in_img->hactive_size + in_img->hobc_width +
+				      in_img->hobc_margin;
+			}
+			if (in_img->interpolation_mode == HWD_VIIF_L1_INPUT_INTERPOLATION_LINE) {
+				total_hact_size = val;
+				total_vact_size = in_img->vactive_size * in_img->input_num;
+			} else {
+				total_hact_size = val * in_img->input_num;
+				total_vact_size = in_img->vactive_size;
+			}
+		} else {
+			/* OTHER input than RAW(L1ISP is off) */
+			if ((in_img->hactive_size < HWD_VIIF_MIN_HACTIVE_PIXEL_WO_L1ISP) ||
+			    (in_img->hactive_size > HWD_VIIF_MAX_HACTIVE_PIXEL_WO_L1ISP) ||
+			    (in_img->vactive_size < HWD_VIIF_MIN_VACTIVE_LINE_WO_L1ISP) ||
+			    (in_img->vactive_size > HWD_VIIF_MAX_VACTIVE_LINE_WO_L1ISP) ||
+			    (in_img->interpolation_mode != HWD_VIIF_L1_INPUT_INTERPOLATION_LINE) ||
+			    (in_img->input_num != HWD_VIIF_L1_INPUT_NUM_MIN) ||
+			    (in_img->hobc_width != 0U)) {
+				return -EINVAL;
+			}
+
+			/* check vbp range in case of L1ISP off */
+			/* the constant value "16" is configuration margin */
+			val = SYSCLK_TO_NUMLINES(HWD_VIIF_TABLE_LOAD_TIME +
+							 HWD_VIIF_REGBUF_ACCESS_TIME,
+						 in_img) +
+			      16U;
+			if (in_img->vbp_size < val)
+				return -EINVAL;
+
+			total_hact_size = in_img->hactive_size;
+			total_vact_size = in_img->vactive_size;
+		}
+
+		if ((in_img->htotal_size <= total_hact_size) ||
+		    (in_img->vtotal_size <= (in_img->vbp_size + total_vact_size))) {
+			return -EINVAL;
+		}
+	}
+	if ((yuv_conv != HWD_VIIF_YUV_CONV_REPEAT) &&
+	    (yuv_conv != HWD_VIIF_YUV_CONV_INTERPOLATION)) {
+		return -EINVAL;
+	}
+
+	if ((color_type != CSI2_DT_YUV4228B) && (color_type != CSI2_DT_YUV42210B) &&
+	    (yuv_conv != HWD_VIIF_YUV_CONV_REPEAT)) {
+		return -EINVAL;
+	}
+
+	/* Set DT and color type of image data and DT of longpacket data */
+	writel((color_type << 8U) | dt_image, &(res->capture_reg->sys.IPORTM_MAIN_DT));
+	writel(dt_long_packet, &(res->capture_reg->sys.IPORTM_OTHER));
+	res->color_type = color_type;
+	res->dt_image_main_w_isp = dt_image;
+
+	/* Set back porch*/
+	writel((in_img->vbp_size << 16U) | HWD_VIIF_HBP_SYSCLK,
+	       &(res->capture_reg->sys.BACK_PORCH_M));
+
+	/* single pulse of vsync is input to DPGM */
+	writel(HWD_VIIF_DPGM_VSYNC_PULSE, &(res->capture_reg->sys.DPGM_VSYNC_SOURCE));
+	if (dt_image == 0x0U) {
+		uint32_t temp_delay;
+		/* only long packet data */
+		/* Set Total size information and delay value for delayed Vsync in case of only long packet data */
+		sysclk_num = LINEPERIOD_IN_SYSCLK(in_img->htotal_size, 1000000U);
+		sysclk_num &= GENMASK(15, 0);
+		writel((in_img->vtotal_size << 16U) | sysclk_num,
+		       &(res->capture_reg->sys.TOTALSIZE_M));
+		temp_delay = in_img->vbp_size - 4U;
+		temp_delay = min(temp_delay, 255U);
+		writel(temp_delay, &(res->capture_reg->sys.INT_M1_LINE));
+	} else {
+		uint32_t i, j;
+		/* image data will be input */
+		/* set preprocess type before L2ISP based on color_type. */
+		if ((color_type == CSI2_DT_YUV4228B) || (color_type == CSI2_DT_YUV42210B)) {
+			/* YUV422 */
+			color = 3U;
+		} else if ((color_type == CSI2_DT_RGB565) || (color_type == CSI2_DT_RGB888)) {
+			/* RGB */
+			color = 0U;
+		} else {
+			/* RGB or YUV444 from L1ISP */
+			color = 1U;
+		}
+		res->l2_input = (color << 4U);
+		writel(res->l2_input, &(res->capture_reg->sys.PREPROCCESS_FMTM));
+
+		/* set Total size and valid size information of image data */
+		sysclk_num = LINEPERIOD_IN_SYSCLK(in_img->htotal_size, in_img->pixel_clock);
+		sysclk_num &= GENMASK(15, 0);
+		writel((in_img->vtotal_size << 16U) | sysclk_num,
+		       &(res->capture_reg->sys.TOTALSIZE_M));
+		writel((total_vact_size << 16U) | total_hact_size,
+		       &(res->capture_reg->sys.VALSIZE_M));
+
+		/* set image size information to L2ISP */
+		writel(in_img->vactive_size, &(res->capture_reg->l2isp.L2_SENSOR_CROP_VSIZE));
+		writel(in_img->hactive_size, &(res->capture_reg->l2isp.L2_SENSOR_CROP_HSIZE));
+
+		/* RAW input case */
+		if (color_type >= CSI2_DT_RAW8) {
+			val = (in_img->interpolation_mode << 3U) | (in_img->input_num);
+			writel(val, &(res->capture_reg->l1isp.L1_IBUF_INPUT_ORDER));
+			res->interpolation_mode = in_img->interpolation_mode;
+			res->input_num = in_img->input_num;
+			writel(in_img->vactive_size, &(res->capture_reg->l1isp.L1_SYSM_HEIGHT));
+			writel(in_img->hactive_size, &(res->capture_reg->l1isp.L1_SYSM_WIDTH));
+			val = (in_img->hobc_margin << 8U) | in_img->hobc_width;
+			writel(val, &(res->capture_reg->l1isp.L1_HOBC_MARGIN));
+			res->hobc_size = in_img->hobc_margin + in_img->hobc_width;
+		}
+
+		/* Set rawpack */
+		writel(rawpack, &(res->capture_reg->sys.IPORTM_MAIN_RAW));
+		res->rawpack = rawpack;
+
+		/* Set yuv_conv */
+		writel(yuv_conv, &(res->capture_reg->sys.PREPROCCESS_C24M));
+
+		/* Set vsync delay */
+		hw_delay = in_img->vbp_size - SYSCLK_TO_NUMLINES(HWD_VIIF_TABLE_LOAD_TIME, in_img) +
+			   4U;
+		hw_delay = min(hw_delay, 255U);
+
+		sw_delay0 = hw_delay - SYSCLK_TO_NUMLINES(HWD_VIIF_REGBUF_ACCESS_TIME, in_img) + 2U;
+
+		if ((color_type == CSI2_DT_RAW8) || (color_type == CSI2_DT_RAW10) ||
+		    (color_type == CSI2_DT_RAW12) || (color_type == CSI2_DT_RAW14)) {
+			sw_delay1 = SYSCLK_TO_NUMLINES(HWD_VIIF_REGBUF_ACCESS_TIME, in_img) +
+				    HWD_VIIF_L1_DELAY_WO_HDRC + 1U;
+		} else {
+			sw_delay1 = 10U;
+		}
+		writel(sw_delay0 << 16U, &(res->capture_reg->sys.INT_M0_LINE));
+		writel((sw_delay1 << 16U) | hw_delay, &(res->capture_reg->sys.INT_M1_LINE));
+
+		/* M2_LINE is the same condition as M1_LINE */
+		writel((sw_delay1 << 16U) | hw_delay, &(res->capture_reg->sys.INT_M2_LINE));
+
+		/* Update internal information of pixel clock, htotal_size, information of L2 ROI */
+		res->pixel_clock = in_img->pixel_clock;
+		res->htotal_size = in_img->htotal_size;
+		for (i = 0; i < HWD_VIIF_ISP_MAX_REGBUF_NUM; i++) {
+			res->l2_roi_path_info[i].roi_num = 0;
+			for (j = 0; j < HWD_VIIF_MAX_POST_NUM; j++) {
+				res->l2_roi_path_info[i].post_enable_flag[j] = false;
+				res->l2_roi_path_info[i].post_crop_x[j] = 0;
+				res->l2_roi_path_info[i].post_crop_y[j] = 0;
+				res->l2_roi_path_info[i].post_crop_w[j] = 0;
+				res->l2_roi_path_info[i].post_crop_h[j] = 0;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_main_set_unit() - Set static configuration of MAIN unit
+ *
+ * @dt_image: DT of image
+ * - [0x0, 0x10-0x17, 0x1B, 0x1E, 0x1F, 0x22, 0x24-0x27, 0x2A-0x2D, 0x2E-0x3F](CH0 and CH1)
+ * @dt_long_packet: DT of long packet data [0x0, 0x10-0x3F]
+ * @in_img: Pointer to input image information
+ * @color_type: Color type of image [0x0, 0x1E, 0x1F, 0x22, 0x24, 0x2A-0x2D]
+ * @rawpack: RAW pack mode. For more refer @ref hwd_VIIF_raw_pack_mode
+ * @yuv_conv: YUV422 to YUV444 conversion mode. For more refer @ref hwd_VIIF_yuv_conversion_mode
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] #hwd_VIIF_main_set_unit_w_isp returns parameter error(CH0 or CH1)
+ */
+int32_t hwd_VIIF_main_set_unit(uint32_t module_id, uint32_t dt_image, uint32_t dt_long_packet,
+			       const struct hwd_viif_input_img *in_img, uint32_t color_type,
+			       uint32_t rawpack, uint32_t yuv_conv)
+{
+	return hwd_VIIF_main_set_unit_w_isp(module_id, dt_image, dt_long_packet, in_img, color_type,
+					    rawpack, yuv_conv);
+}
+
+/**
+ * hwd_VIIF_main_mask_vlatch() - Control Vlatch mask of MAIN unit
+ *
+ * @enable: or disable Vlatch mask of MAIN unit. For more refer @ref hwd_VIIF_enable_flag.
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - "enable" is out of range
+ */
+int32_t hwd_VIIF_main_mask_vlatch(uint32_t module_id, uint32_t enable)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	if ((enable != HWD_VIIF_ENABLE) && (enable != HWD_VIIF_DISABLE))
+		return -EINVAL;
+
+	if ((res->ch != 0U) && (res->ch != 1U))
+		return -EINVAL;
+
+	if (enable == HWD_VIIF_ENABLE)
+		enable |= HWD_VIIF_ISP_VLATCH_MASK;
+
+	/* Control Vlatch mask */
+	writel(enable, &(res->capture_reg->sys.IPORTM0_LD));
+	writel(enable, &(res->capture_reg->sys.IPORTM1_LD));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_main_status_err_set_irq_mask() - Set mask condition for STATUS error of MAIN unit
+ *
+ * @mask: Pointer to STATUS error mask condition
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_VIIF_main_status_err_set_irq_mask(uint32_t module_id, const uint32_t *mask)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	writel(*mask, &(res->capture_reg->sys.INT_M_MASK));
+}
+
+/**
+ * hwd_VIIF_main_vsync_set_irq_mask() - Set mask condition for Vsync of MAIN unit
+ *
+ * @mask: Pointer to Vsync mask condition
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_VIIF_main_vsync_set_irq_mask(uint32_t module_id, const uint32_t *mask)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	writel(*mask, &(res->capture_reg->sys.INT_M_SYNC_MASK));
+}
+
+/**
+ * hwd_VIIF_main_get_next_frame_info() - Get next frame information of MAIN unit
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * @count0: count incremented by Vsync
+ * @count1: count incremented by delay_sync1
+ * @count2: count incremented by delay_sync2
+ * @hist_paddr: output address of L1ISP histogram data(physical address)
+ * @addr_info: output address of vdmac
+ * Return: None
+ */
+void hwd_VIIF_main_get_next_frame_info(uint32_t module_id, uint32_t *count0, uint32_t *count1,
+				       uint32_t *count2, uint32_t *hist_paddr,
+				       struct hwd_viif_main_transfer_addr_info *addr_info)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	if ((res->ch != 0U) && (res->ch != 1U))
+		return;
+
+	*count0 = readl(&res->capture_reg->sys.FN_M0);
+	*count1 = readl(&res->capture_reg->sys.FN_M1);
+	*count2 = readl(&res->capture_reg->sys.FN_M2);
+	addr_info->img_g_y_paddr = 0;
+	addr_info->img_b_u_paddr = 0;
+	addr_info->img_r_v_paddr = 0;
+	addr_info->long_packet_paddr = readl(&res->capture_reg->vdm.w_port_buf[0].VDM_W_STADR_BUF);
+	addr_info->emb_paddr = readl(&res->capture_reg->vdm.w_port_buf[1].VDM_W_STADR_BUF);
+	*hist_paddr = readl(&res->capture_reg->vdm.w_port_buf[2].VDM_W_STADR_BUF);
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
+ * hwd_VIIF_main_get_previous_frame_info() - Get and clear previous frame information of MAIN unit
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * @abort_r: abort information of read port
+ * @abort_w: abort information of write port
+ * @packet_info: CSI-2 packet information
+ * Return: None
+ */
+void hwd_VIIF_main_get_previous_frame_info(uint32_t module_id, uint32_t *abort_r, uint32_t *abort_w,
+					   struct hwd_viif_csi2rx_capture_info *packet_info)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val;
+
+	if ((res->ch != 0U) && (res->ch != 1U))
+		return;
+
+	*abort_r = readl(&res->capture_reg->vdm.VDM_R_STOP) & VDM_ABORT_MASK_MAIN_R;
+	writel(*abort_r, &(res->capture_reg->vdm.VDM_R_STOP));
+	*abort_w = readl(&res->capture_reg->vdm.VDM_W_STOP) & VDM_ABORT_MASK_MAIN_W;
+	writel(*abort_w, &(res->capture_reg->vdm.VDM_W_STOP));
+
+	val = readl(&res->capture_reg->sys.MAINIMG_PKTSIZE);
+	packet_info->img_size_1st = val & GENMASK(15, 0);
+	packet_info->img_size_2nd = val >> 16U;
+	packet_info->img_num = readl(&res->capture_reg->sys.MAINIMG_HEIGHT);
+	val = readl(&res->capture_reg->sys.MAINEMBTOP_SIZE);
+	packet_info->emb_top_size = val & GENMASK(15, 0);
+	packet_info->emb_top_num = val >> 16U;
+	val = readl(&res->capture_reg->sys.MAINEMBBOT_SIZE);
+	packet_info->emb_bottom_size = val & GENMASK(15, 0);
+	packet_info->emb_bottom_num = val >> 16U;
+	val = readl(&res->capture_reg->sys.MAINOTHER_PKTSIZE);
+	packet_info->long_packet_size_1st = val & GENMASK(15, 0);
+	packet_info->long_packet_size_2nd = val >> 16U;
+	packet_info->long_packet_num = readl(&res->capture_reg->sys.MAINOTHER_HEIGHT);
+}
+
+/**
+ * hwd_VIIF_sub_set_unit() - Set static configuration of SUB unit
+ *
+ * @dt_image: DT of image [0x0, 0x1E, 0x1F, 0x22, 0x24, 0x2A-0x2D]
+ * @dt_long_packet: DT of long packet data [0x0, 0x10-0x3F]
+ * @in_img: Pointer to input image information
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "dt_image" is out of range
+ * - [2] "dt_long_packet" is out of range
+ * - [3] Both "dt_image" and "dt_long_packet" are 0x0
+ * - [4] "in_img" is NULL
+ * - [5] member of "in_img" is invalid
+ */
+int32_t hwd_VIIF_sub_set_unit(uint32_t module_id, uint32_t dt_image, uint32_t dt_long_packet,
+			      const struct hwd_viif_input_img *in_img)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t sysclk_num, temp_delay;
+
+	if (((dt_image > 0U) && (dt_image < 0x2aU)) || (dt_image > 0x2dU))
+		return -EINVAL;
+
+	if (((dt_long_packet > 0x0U) && (dt_long_packet < 0x10U)) ||
+	    (dt_long_packet > HWD_VIIF_CSI2_MAX_DT)) {
+		return -EINVAL;
+	}
+
+	if ((dt_image == 0U) && (dt_long_packet == 0U))
+		return -EINVAL;
+
+	if (in_img == NULL)
+		return -EINVAL;
+
+	if ((in_img->hactive_size != 0U) ||
+	    (in_img->interpolation_mode != HWD_VIIF_L1_INPUT_INTERPOLATION_LINE) ||
+	    (in_img->input_num != HWD_VIIF_L1_INPUT_NUM_MIN) || (in_img->hobc_width != 0U) ||
+	    (in_img->hobc_margin != 0U)) {
+		return -EINVAL;
+	}
+
+	if (dt_image == 0U) {
+		/* only long packet data */
+		if ((in_img->pixel_clock != 0U) ||
+		    (in_img->htotal_size < HWD_VIIF_MIN_HTOTAL_NSEC) ||
+		    (in_img->htotal_size > HWD_VIIF_MAX_HTOTAL_NSEC) ||
+		    (in_img->vbp_size < HWD_VIIF_MIN_VBP_PACKET) ||
+		    (in_img->vbp_size > HWD_VIIF_MAX_VBP_PACKET) || (in_img->vtotal_size != 0U) ||
+		    (in_img->vactive_size != 0U)) {
+			return -EINVAL;
+		}
+	} else {
+		/* image data will be input */
+		if ((in_img->pixel_clock < HWD_VIIF_MIN_PIXEL_CLOCK) ||
+		    (in_img->pixel_clock > HWD_VIIF_MAX_PIXEL_CLOCK) ||
+		    (in_img->htotal_size < HWD_VIIF_MIN_HTOTAL_PIXEL) ||
+		    (in_img->htotal_size > HWD_VIIF_MAX_HTOTAL_PIXEL) ||
+		    (in_img->vtotal_size < HWD_VIIF_MIN_VTOTAL_LINE) ||
+		    (in_img->vtotal_size > HWD_VIIF_MAX_VTOTAL_LINE) ||
+		    (in_img->vbp_size < HWD_VIIF_MIN_VBP_LINE) ||
+		    (in_img->vbp_size > HWD_VIIF_MAX_VBP_LINE) ||
+		    (in_img->vactive_size < HWD_VIIF_MIN_VACTIVE_LINE_WO_L1ISP) ||
+		    (in_img->vactive_size > HWD_VIIF_MAX_VACTIVE_LINE_WO_L1ISP) ||
+		    ((in_img->vactive_size % 2U) != 0U)) {
+			return -EINVAL;
+		}
+
+		if (in_img->vtotal_size <= (in_img->vbp_size + in_img->vactive_size))
+			return -EINVAL;
+	}
+
+	/* Set DT of image data and DT of long packet data*/
+	writel(dt_image, &(res->capture_reg->sys.IPORTS_MAIN_DT));
+	writel(dt_long_packet, &(res->capture_reg->sys.IPORTS_OTHER));
+
+	if (dt_image == 0x0U)
+		sysclk_num = LINEPERIOD_IN_SYSCLK(in_img->htotal_size, 1000000U);
+	else
+		sysclk_num = LINEPERIOD_IN_SYSCLK(in_img->htotal_size, in_img->pixel_clock);
+
+	/* Set line size and delay value of delayed Vsync */
+	writel(sysclk_num & GENMASK(15, 0), &(res->capture_reg->sys.INT_SA0_LINE));
+	temp_delay = in_img->vbp_size - 4U;
+	if (temp_delay > 255U) {
+		/* Replace the value with HW max spec */
+		temp_delay = 255U;
+	}
+	writel(temp_delay, &(res->capture_reg->sys.INT_SA1_LINE));
+
+	return 0;
+}
+
+#define VDMAC_SRAM_BASE_ADDR_W03 0x440U
+
+/**
+ * hwd_VIIF_sub_set_img_transmission() - Set image transfer condition of SUB unit
+ *
+ * @img: Pointer to output image information
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] Member of "img" is invalid
+ */
+int32_t hwd_VIIF_sub_set_img_transmission(uint32_t module_id, const struct hwd_viif_img *img)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t data_width, pitch, height, img_start_addr, img_end_addr;
+	uint32_t k, port_control;
+
+	if (img != NULL) {
+		if ((((img->width) % 2U) != 0U) || (((img->height) % 2U) != 0U))
+			return -EINVAL;
+
+		if ((img->width < HWD_VIIF_MIN_OUTPUT_IMG_WIDTH) ||
+		    (img->height < HWD_VIIF_MIN_OUTPUT_IMG_HEIGHT) ||
+		    (img->width > HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_SUB) ||
+		    (img->height > HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_SUB)) {
+			return -EINVAL;
+		}
+
+		img_start_addr = (uint32_t)img->pixelmap[0].pmap_paddr;
+		pitch = img->pixelmap[0].pitch;
+		height = img->height;
+
+		switch (img->format) {
+		case HWD_VIIF_ONE_COLOR_8:
+			data_width = 0U;
+			img_end_addr = img_start_addr + img->width - 1U;
+			k = 1;
+			break;
+		case HWD_VIIF_ONE_COLOR_16:
+			data_width = 1U;
+			img_end_addr = img_start_addr + (img->width * 2U) - 1U;
+			k = 2;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if ((img_start_addr % 4U) != 0U)
+			return -EINVAL;
+
+		if ((pitch < (img->width * k)) || (pitch > HWD_VIIF_MAX_PITCH) ||
+		    ((pitch % 4U) != 0U)) {
+			return -EINVAL;
+		}
+
+		writel(VDMAC_SRAM_BASE_ADDR_W03,
+		       &(res->capture_reg->vdm.w_port[3].VDM_W_SRAM_BASE));
+		writel(res->sram_size_w_port, &(res->capture_reg->vdm.w_port[3].VDM_W_SRAM_SIZE));
+		writel(img_start_addr, &(res->capture_reg->vdm.w_port[3].VDM_W_STADR));
+		writel(img_end_addr, &(res->capture_reg->vdm.w_port[3].VDM_W_ENDADR));
+		writel(height, &(res->capture_reg->vdm.w_port[3].VDM_W_HEIGHT));
+		writel(pitch, &(res->capture_reg->vdm.w_port[3].VDM_W_PITCH));
+		writel(data_width << 8U, &(res->capture_reg->vdm.w_port[3].VDM_W_CFG0));
+		port_control = ((uint32_t)1U << 3U) | readl(&res->capture_reg->vdm.VDM_W_ENABLE);
+		writel(port_control, &(res->capture_reg->vdm.VDM_W_ENABLE));
+		writel(HWD_VIIF_ENABLE, &(res->capture_reg->sys.IPORTS_IMGEN));
+	} else {
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.IPORTS_IMGEN));
+		port_control = ~((uint32_t)1U << 3U) & readl(&res->capture_reg->vdm.VDM_W_ENABLE);
+		writel(port_control, &(res->capture_reg->vdm.VDM_W_ENABLE));
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_sub_mask_vlatch() - Control Vlatch mask of SUB unit or VOIF loopback
+ *
+ * @enable: or disable Vlatch mask of SUB unit. For more refer @ref hwd_VIIF_enable_flag.
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - "enable" is out of range
+ */
+int32_t hwd_VIIF_sub_mask_vlatch(uint32_t module_id, uint32_t enable)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if ((enable != HWD_VIIF_ENABLE) && (enable != HWD_VIIF_DISABLE))
+		return -EINVAL;
+
+	/* Control Vlach mask */
+	writel(enable, &(res->capture_reg->sys.IPORTS0_LD));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_sub_status_err_set_irq_mask() - Set mask condition for STATUS error of SUB unit or VOIF loopback
+ *
+ * @mask: Pointer to STATUS error mask condition
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_VIIF_sub_status_err_set_irq_mask(uint32_t module_id, const uint32_t *mask)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	writel(*mask, &(res->capture_reg->sys.INT_S_MASK));
+}
+
+/**
+ * hwd_VIIF_sub_vsync_set_irq_mask() - Set mask condition for Vsync of SUB unit or VOIF loopback
+ *
+ * @mask: Pointer to Vsync mask condition
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_VIIF_sub_vsync_set_irq_mask(uint32_t module_id, const uint32_t *mask)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	writel(*mask, &(res->capture_reg->sys.INT_S_SYNC_MASK));
+}
+
+/**
+ * hwd_VIIF_sub_get_next_frame_info() - Get next frame information of SUB unit
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * @count0: count incremented by Vsync
+ * @count1: count incremented by delay_sync1
+ * @img_paddr: output address of image data(physical address)
+ * @emb_paddr: output address of embedded data(physical address)
+ * @long_packet_paddr: output address of long packet data(physical address)
+ * Return: None
+ */
+void hwd_VIIF_sub_get_next_frame_info(uint32_t module_id, uint32_t *count0, uint32_t *count1,
+				      uint32_t *img_paddr, uint32_t *emb_paddr,
+				      uint32_t *long_packet_paddr)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	*count0 = readl(&res->capture_reg->sys.FN_SA0);
+	*count1 = readl(&res->capture_reg->sys.FN_SA1);
+	*img_paddr = readl(&res->capture_reg->vdm.w_port_buf[3].VDM_W_STADR_BUF);
+	*emb_paddr = readl(&res->capture_reg->vdm.w_port_buf[5].VDM_W_STADR_BUF);
+	*long_packet_paddr = readl(&res->capture_reg->vdm.w_port_buf[4].VDM_W_STADR_BUF);
+}
+
+/**
+ * hwd_VIIF_sub_get_previous_frame_info() - Get and clear previous frame information of SUB unit
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * @abort_w: abort information of write port
+ * @packet_info: CSI-2 packet information
+ * Return: None
+ */
+void hwd_VIIF_sub_get_previous_frame_info(uint32_t module_id, uint32_t *abort_w,
+					  struct hwd_viif_csi2rx_capture_info *packet_info)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val;
+
+	val = VDM_ABORT_MASK_SUB_W & readl(&res->capture_reg->vdm.VDM_W_STOP);
+	*abort_w = val;
+	writel(val, &(res->capture_reg->vdm.VDM_W_STOP));
+	val = readl(&res->capture_reg->sys.SUBIMG_PKTSIZE);
+	packet_info->img_size_1st = val & GENMASK(15, 0);
+	packet_info->img_size_2nd = val >> 16U;
+	packet_info->img_num = readl(&res->capture_reg->sys.SUBIMG_HEIGHT);
+	val = readl(&res->capture_reg->sys.SUBEMBTOP_SIZE);
+	packet_info->emb_top_size = val & GENMASK(15, 0);
+	packet_info->emb_top_num = val >> 16U;
+	val = readl(&res->capture_reg->sys.SUBEMBBOT_SIZE);
+	packet_info->emb_bottom_size = val & GENMASK(15, 0);
+	packet_info->emb_bottom_num = val >> 16U;
+	val = readl(&res->capture_reg->sys.SUBOTHER_PKTSIZE);
+	packet_info->long_packet_size_1st = val & GENMASK(15, 0);
+	packet_info->long_packet_size_2nd = val >> 16U;
+	packet_info->long_packet_num = readl(&res->capture_reg->sys.SUBOTHER_HEIGHT);
+}
+
+/**
+ * hwd_VIIF_isp_set_regbuf_auto_transmission() - Set register buffer auto transmission
+ *
+ * @regbuf_id_read: register buffer ID for read transmission [0..3]
+ * @regbuf_id_write: register buffer ID for write transmission [0..3]
+ * @context_id: context ID [0..3]
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_VIIF_isp_set_regbuf_auto_transmission(uint32_t module_id, uint32_t regbuf_id_read,
+					       uint32_t regbuf_id_write, uint32_t context_id)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val;
+
+	(void)regbuf_id_read;
+	(void)regbuf_id_write;
+	(void)context_id;
+
+	/* Set parameters for auto read transmission of register buffer */
+
+	if (res->dt_image_main_w_isp != 0x0U) {
+		/* configuration is done only when dt_image is not 0, means image data is input to ISP. */
+		writel(0x0, &(res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF));
+		writel(0x0, &(res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF));
+		writel(HWD_VIIF_L1_CRGBF_R_START_ADDR_LIMIT,
+		       &(res->capture_reg->l1isp.L1_CRGBF_TRN_RBADDR));
+		writel(HWD_VIIF_L1_CRGBF_R_END_ADDR_LIMIT,
+		       &(res->capture_reg->l1isp.L1_CRGBF_TRN_READDR));
+		writel(HWD_VIIF_L2_CRGBF_R_START_ADDR_LIMIT,
+		       &(res->capture_reg->l2isp.L2_CRGBF_TRN_RBADDR));
+		writel(HWD_VIIF_L2_CRGBF_R_END_ADDR_LIMIT,
+		       &(res->capture_reg->l2isp.L2_CRGBF_TRN_READDR));
+		val = BIT(16);
+		writel(val, &(res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF));
+		writel(val, &(res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF));
+	}
+}
+
+/**
+ * hwd_VIIF_isp_disable_regbuf_auto_transmission() - Disable register buffer auto transmission
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_VIIF_isp_disable_regbuf_auto_transmission(uint32_t module_id)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (res->dt_image_main_w_isp != 0x0U) {
+		writel(0x0, &(res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF));
+		writel(0x0, &(res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF));
+	}
+}
+
+#define L2_STATUS_REPORT_MASK 0x1eU
+
+/**
+ * hwd_VIIF_isp_get_info() - Get processing information of L1ISP and L2ISP
+ *
+ * @regbuf_id: register buffer ID [0..3]
+ * @regbuf_id_info: Latest register buffer ID
+ * @l1_info: L1ISP processing information
+ * @l2_addr_info: output address information of L2ISP
+ * @l2_transfer_status: status of L2ISP transmission
+ * @l1_regbuf_status: register buffer status of L1ISP
+ * @l2_regbuf_status: register buffer status of L2ISP
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_VIIF_isp_get_info(uint32_t module_id, uint32_t regbuf_id, uint32_t *regbuf_id_info,
+			   struct hwd_viif_l1_info *l1_info,
+			   struct hwd_viif_l2_transfer_addr_info *l2_addr_info,
+			   uint32_t *l2_transfer_status,
+			   struct hwd_viif_isp_regbuf_status *l1_regbuf_status,
+			   struct hwd_viif_isp_regbuf_status *l2_regbuf_status)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val, l2_status;
+
+	if (l1_info != NULL) {
+		/* change register buffer to regbuf0 where driver gets information */
+		writel(HWD_VIIF_ISP_REGBUF_MODE_BUFFER,
+		       &(res->capture_reg->l1isp.L1_CRGBF_ACC_CONF));
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
+		/* revert to register access from register buffer access */
+		writel(HWD_VIIF_ISP_REGBUF_MODE_BYPASS,
+		       &(res->capture_reg->l1isp.L1_CRGBF_ACC_CONF));
+	}
+
+	if (l2_transfer_status != NULL) {
+		/* get L2ISP abort information */
+		l2_status = readl(&res->capture_reg->l2isp.L2_CRGBF_ISP_INT);
+		writel(l2_status, &(res->capture_reg->l2isp.L2_CRGBF_ISP_INT));
+		*l2_transfer_status = l2_status & L2_STATUS_REPORT_MASK;
+	}
+}
+
+/**
+ * hwd_VIIF_isp_set_regbuf_irq_mask() - Set mask condition for ISP register buffer
+ *
+ * @mask_l1: Pointer to mask configuration for L1ISP register buffer interruption
+ * @mask_l2: Pointer to mask configuration for L2ISP register buffer interruption
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_VIIF_isp_set_regbuf_irq_mask(uint32_t module_id, const uint32_t *mask_l1,
+				      const uint32_t *mask_l2)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	writel(*mask_l1, &(res->capture_reg->l1isp.L1_CRGBF_INT_MASK));
+	writel(*mask_l2, &(res->capture_reg->l2isp.L2_CRGBF_INT_MASK));
+}
+
+/**
+ * hwd_VIIF_l2_set_input_path() - Set input path of L2ISP
+ *
+ * @is_other_ch: input path of L2ISP
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ */
+int32_t hwd_VIIF_l2_set_input_path(uint32_t module_id, bool is_other_ch)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t input;
+
+	if (is_other_ch)
+		input = HWD_VIIF_L2_INPUT_OTHER_CH;
+	else
+		input = res->l2_input;
+
+	writel(input, &(res->capture_reg->sys.PREPROCCESS_FMTM));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l2_set_input_csc() - Set input CSC parameters of L2ISP
+ *
+ * @param: Pointer to input csc parameters of L2ISP
+ * @is_l1_rgb: input information of L2ISP
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] Member of "param" is invalid
+ */
+int32_t hwd_VIIF_l2_set_input_csc(uint32_t module_id, const struct hwd_viif_csc_param *param,
+				  bool is_l1_rgb)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t i, val;
+	uint32_t enable = HWD_VIIF_ENABLE;
+	struct hwd_viif_csc_param hwd_param;
+	bool csc_enable_flag = true;
+
+	if (param != NULL) {
+		if (param->r_cr_in_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->g_y_in_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->b_cb_in_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->r_cr_out_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->g_y_out_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->b_cb_out_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
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
+		       &(res->capture_reg->sys.l2isp_input_csc.MTB_YG_OFFSETI));
+		writel(hwd_param.coef[0], &(res->capture_reg->sys.l2isp_input_csc.MTB_YG1));
+		val = (hwd_param.coef[1] << HWD_VIIF_MTB_CB_YG_COEF_OFFSET) |
+		      (hwd_param.coef[2] << HWD_VIIF_MTB_CR_YG_COEF_OFFSET);
+		writel(val, &(res->capture_reg->sys.l2isp_input_csc.MTB_YG2));
+		writel(hwd_param.g_y_out_offset,
+		       &(res->capture_reg->sys.l2isp_input_csc.MTB_YG_OFFSETO));
+		writel(hwd_param.b_cb_in_offset,
+		       &(res->capture_reg->sys.l2isp_input_csc.MTB_CB_OFFSETI));
+		writel(hwd_param.coef[3], &(res->capture_reg->sys.l2isp_input_csc.MTB_CB1));
+		val = (hwd_param.coef[4] << HWD_VIIF_MTB_CB_CB_COEF_OFFSET) |
+		      (hwd_param.coef[5] << HWD_VIIF_MTB_CR_CB_COEF_OFFSET);
+		writel(val, &(res->capture_reg->sys.l2isp_input_csc.MTB_CB2));
+		writel(hwd_param.b_cb_out_offset,
+		       &(res->capture_reg->sys.l2isp_input_csc.MTB_CB_OFFSETO));
+		writel(hwd_param.r_cr_in_offset,
+		       &(res->capture_reg->sys.l2isp_input_csc.MTB_CR_OFFSETI));
+		writel(hwd_param.coef[6], &(res->capture_reg->sys.l2isp_input_csc.MTB_CR1));
+		val = (hwd_param.coef[7] << HWD_VIIF_MTB_CB_CR_COEF_OFFSET) |
+		      (hwd_param.coef[8] << HWD_VIIF_MTB_CR_CR_COEF_OFFSET);
+		writel(val, &(res->capture_reg->sys.l2isp_input_csc.MTB_CR2));
+		writel(hwd_param.r_cr_out_offset,
+		       &(res->capture_reg->sys.l2isp_input_csc.MTB_CR_OFFSETO));
+	}
+
+	writel(enable, &(res->capture_reg->sys.l2isp_input_csc.MTB));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l2_set_undist() - Set undistortion parameters of L2ISP
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @param: Pointer to undistortion parameters of L2ISP
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "param" is NULL
+ * - [2] Member of "param" is invalid
+ */
+int32_t hwd_VIIF_l2_set_undist(uint32_t module_id, uint32_t regbuf_id,
+			       const struct hwd_viif_l2_undist *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t i, val;
+	uint32_t grid_num_h, grid_num_v;
+
+	if (param == NULL)
+		return -EINVAL;
+
+	if ((param->through_mode != HWD_VIIF_ENABLE) && (param->through_mode != HWD_VIIF_DISABLE))
+		return -EINVAL;
+
+	if ((param->roi_mode != HWD_VIIF_L2_UNDIST_POLY) &&
+	    (param->roi_mode != HWD_VIIF_L2_UNDIST_GRID) &&
+	    (param->roi_mode != HWD_VIIF_L2_UNDIST_POLY_TO_GRID) &&
+	    (param->roi_mode != HWD_VIIF_L2_UNDIST_GRID_TO_POLY)) {
+		return -EINVAL;
+	}
+	if (param->roi_write_area_delta >= HWD_VIIF_L2_UNDIST_MAX_ROI_WRITE_AREA_DELTA)
+		return -EINVAL;
+
+	if ((param->sensor_crop_ofs_h < HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_H) ||
+	    (param->sensor_crop_ofs_h > HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_H)) {
+		return -EINVAL;
+	}
+
+	if ((param->sensor_crop_ofs_v < HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_V) ||
+	    (param->sensor_crop_ofs_v > HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_V)) {
+		return -EINVAL;
+	}
+
+	if (param->norm_scale > HWD_VIIF_L2_UNDIST_MAX_NORM_SCALE)
+		return -EINVAL;
+
+	if (param->valid_r_norm2_poly >= HWD_VIIF_L2_UNDIST_MAX_VALID_R_NORM2)
+		return -EINVAL;
+
+	if (param->valid_r_norm2_grid >= HWD_VIIF_L2_UNDIST_MAX_VALID_R_NORM2)
+		return -EINVAL;
+
+	for (i = 0; i < HWD_VIIF_L2_UNDIST_POLY_NUM; i++) {
+		if ((param->poly_write_g_coef[i] < HWD_VIIF_L2_UNDIST_MIN_POLY_COEF) ||
+		    (param->poly_write_g_coef[i] > HWD_VIIF_L2_UNDIST_MAX_POLY_COEF)) {
+			return -EINVAL;
+		}
+		if ((param->poly_read_b_coef[i] < HWD_VIIF_L2_UNDIST_MIN_POLY_COEF) ||
+		    (param->poly_read_b_coef[i] > HWD_VIIF_L2_UNDIST_MAX_POLY_COEF)) {
+			return -EINVAL;
+		}
+		if ((param->poly_read_g_coef[i] < HWD_VIIF_L2_UNDIST_MIN_POLY_COEF) ||
+		    (param->poly_read_g_coef[i] > HWD_VIIF_L2_UNDIST_MAX_POLY_COEF)) {
+			return -EINVAL;
+		}
+		if ((param->poly_read_r_coef[i] < HWD_VIIF_L2_UNDIST_MIN_POLY_COEF) ||
+		    (param->poly_read_r_coef[i] > HWD_VIIF_L2_UNDIST_MAX_POLY_COEF)) {
+			return -EINVAL;
+		}
+	}
+
+	if ((param->grid_node_num_h < HWD_VIIF_L2_UNDIST_MIN_GRID_NUM) ||
+	    (param->grid_node_num_h > HWD_VIIF_L2_UNDIST_MAX_GRID_NUM)) {
+		return -EINVAL;
+	}
+
+	if ((param->grid_node_num_v < HWD_VIIF_L2_UNDIST_MIN_GRID_NUM) ||
+	    (param->grid_node_num_v > HWD_VIIF_L2_UNDIST_MAX_GRID_NUM)) {
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
+	if ((grid_num_v * grid_num_h) > HWD_VIIF_L2_UNDIST_MAX_GRID_TOTAL_NUM)
+		return -EINVAL;
+
+	if (param->grid_patch_hsize_inv >= HWD_VIIF_L2_UNDIST_MAX_GRID_PATCH_SIZE_INV)
+		return -EINVAL;
+
+	if (param->grid_patch_vsize_inv >= HWD_VIIF_L2_UNDIST_MAX_GRID_PATCH_SIZE_INV)
+		return -EINVAL;
+
+	val = readl(&res->capture_reg->l2isp.L2_SENSOR_CROP_HSIZE) & GENMASK(12, 0);
+	if (((param->sensor_crop_ofs_h / 2) + ((int16_t)val)) > 4095)
+		return -EINVAL;
+
+	val = readl(&res->capture_reg->l2isp.L2_SENSOR_CROP_VSIZE) & GENMASK(11, 0);
+	if (((param->sensor_crop_ofs_v / 2) + ((int16_t)val)) > 2047)
+		return -EINVAL;
+
+	/* set parameters related to L2ISP UNDIST */
+	if (param->through_mode == HWD_VIIF_ENABLE) {
+		/* Enable through mode */
+		writel(HWD_VIIF_ENABLE, &(res->capture_reg->l2isp.L2_MODE));
+	} else {
+		val = (param->roi_mode << 1U);
+		writel(val, &(res->capture_reg->l2isp.L2_MODE));
+		val = (uint32_t)param->sensor_crop_ofs_h & GENMASK(13, 0);
+		writel(val, &(res->capture_reg->l2isp.L2_SENSOR_CROP_OFS_H));
+		val = (uint32_t)param->sensor_crop_ofs_v & GENMASK(12, 0);
+		writel(val, &(res->capture_reg->l2isp.L2_SENSOR_CROP_OFS_V));
+		writel(param->norm_scale, &(res->capture_reg->l2isp.L2_NORM_SCALE));
+		writel(param->valid_r_norm2_poly, &(res->capture_reg->l2isp.L2_VALID_R_NORM2_POLY));
+		writel(param->valid_r_norm2_grid, &(res->capture_reg->l2isp.L2_VALID_R_NORM2_GRID));
+		writel(param->roi_write_area_delta,
+		       &(res->capture_reg->l2isp.L2_ROI_WRITE_AREA_DELTA[0]));
+		for (i = 0; i < HWD_VIIF_L2_UNDIST_POLY_NUM; i++) {
+			val = (uint32_t)param->poly_write_g_coef[i];
+			writel(val, &(res->capture_reg->l2isp.L2_POLY10_WRITE_G_COEF[i]));
+			val = (uint32_t)param->poly_read_b_coef[i];
+			writel(val, &(res->capture_reg->l2isp.L2_POLY10_READ_B_COEF[i]));
+			val = (uint32_t)param->poly_read_g_coef[i];
+			writel(val, &(res->capture_reg->l2isp.L2_POLY10_READ_G_COEF[i]));
+			val = (uint32_t)param->poly_read_r_coef[i];
+			writel(val, &(res->capture_reg->l2isp.L2_POLY10_READ_R_COEF[i]));
+		}
+		writel(param->grid_node_num_h, &(res->capture_reg->l2isp.L2_GRID_NODE_NUM_H));
+		writel(param->grid_node_num_v, &(res->capture_reg->l2isp.L2_GRID_NODE_NUM_V));
+		writel(param->grid_patch_hsize_inv,
+		       &(res->capture_reg->l2isp.L2_GRID_PATCH_HSIZE_INV));
+		writel(param->grid_patch_vsize_inv,
+		       &(res->capture_reg->l2isp.L2_GRID_PATCH_VSIZE_INV));
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l2_set_undist_table_transmission() - Configure L2ISP transferring grid table for undistortion.
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
+int32_t hwd_VIIF_l2_set_undist_table_transmission(uint32_t module_id, uintptr_t write_g,
+						  uintptr_t read_b, uintptr_t read_g,
+						  uintptr_t read_r, uint32_t size)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val = 0U;
+
+	if (((write_g % HWD_VIIF_L2_VDM_ALIGN) != 0U) || ((read_b % HWD_VIIF_L2_VDM_ALIGN) != 0U) ||
+	    ((read_g % HWD_VIIF_L2_VDM_ALIGN) != 0U) || ((read_r % HWD_VIIF_L2_VDM_ALIGN) != 0U)) {
+		return -EINVAL;
+	}
+
+	if (((size != 0U) && (size < HWD_VIIF_L2_UNDIST_MIN_TABLE_SIZE)) ||
+	    (size > HWD_VIIF_L2_UNDIST_MAX_TABLE_SIZE)) {
+		return -EINVAL;
+	}
+
+	if ((size % 4U) != 0U)
+		return -EINVAL;
+
+	if ((write_g == 0U) && (read_b == 0U) && (read_g == 0U) && (read_r == 0U) && (size != 0U))
+		return -EINVAL;
+
+	if (((write_g != 0U) || (read_b != 0U) || (read_g != 0U) || (read_r != 0U)) &&
+	    (size == 0U)) {
+		return -EINVAL;
+	}
+
+	/* read_b: t_port[8], read_g: t_port[9], read_r: t_port[10], write_g: t_port[11] */
+	if (read_b != 0U) {
+		writel((uint32_t)read_b, &(res->capture_reg->vdm.t_port[8].VDM_T_STADR));
+		writel(size, &(res->capture_reg->vdm.t_port[8].VDM_T_SIZE));
+		val |= BIT(8);
+	}
+	if (read_g != 0U) {
+		writel((uint32_t)read_g, &(res->capture_reg->vdm.t_port[9].VDM_T_STADR));
+		writel(size, &(res->capture_reg->vdm.t_port[9].VDM_T_SIZE));
+		val |= BIT(9);
+	}
+	if (read_r != 0U) {
+		writel((uint32_t)read_r, &(res->capture_reg->vdm.t_port[10].VDM_T_STADR));
+		writel(size, &(res->capture_reg->vdm.t_port[10].VDM_T_SIZE));
+		val |= BIT(10);
+	}
+	if (write_g != 0U) {
+		writel((uint32_t)write_g, &(res->capture_reg->vdm.t_port[11].VDM_T_STADR));
+		writel(size, &(res->capture_reg->vdm.t_port[11].VDM_T_SIZE));
+		val |= BIT(11);
+	}
+
+	if (val != 0U) {
+		/* Set SRAM base address and size. t_group[1] is used only to transfer UNDIST table */
+		writel(HWD_VIIF_VDM_CFG_PARAM, &(res->capture_reg->vdm.t_group[1].VDM_T_CFG));
+		writel(HWD_VIIF_L2_VDM_GRID_SRAM_BASE,
+		       &(res->capture_reg->vdm.t_group[1].VDM_T_SRAM_BASE));
+		writel(HWD_VIIF_L2_VDM_GRID_SRAM_SIZE,
+		       &(res->capture_reg->vdm.t_group[1].VDM_T_SRAM_SIZE));
+	}
+
+	val |= (readl(&res->capture_reg->vdm.VDM_T_ENABLE) & ~((uint32_t)0xfU << 8U));
+	writel(val, &(res->capture_reg->vdm.VDM_T_ENABLE));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l2_set_roi_num_1() - Set ROI path condition when ROI num is 1
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ */
+static void hwd_VIIF_l2_set_roi_num_1(uint32_t regbuf_id, struct hwd_viif_res *res)
+{
+	uint32_t val, x_min, x_max, y_min, y_max;
+	uint32_t i, x, y, w, h;
+
+	/* ROI0 is input to POST0 and POST1 */
+	if (res->l2_roi_path_info[regbuf_id].post_enable_flag[0]) {
+		/* POST0 is enabled */
+		x_min = res->l2_roi_path_info[regbuf_id].post_crop_x[0];
+		x_max = res->l2_roi_path_info[regbuf_id].post_crop_x[0] +
+			res->l2_roi_path_info[regbuf_id].post_crop_w[0];
+		y_min = res->l2_roi_path_info[regbuf_id].post_crop_y[0];
+		y_max = res->l2_roi_path_info[regbuf_id].post_crop_y[0] +
+			res->l2_roi_path_info[regbuf_id].post_crop_h[0];
+		if (res->l2_roi_path_info[regbuf_id].post_enable_flag[1]) {
+			/* POST1 is enabled */
+			x_min = min(x_min, res->l2_roi_path_info[regbuf_id].post_crop_x[1]);
+			val = res->l2_roi_path_info[regbuf_id].post_crop_x[1] +
+			      res->l2_roi_path_info[regbuf_id].post_crop_w[1];
+			x_max = max(x_max, val);
+			y_min = min(y_min, res->l2_roi_path_info[regbuf_id].post_crop_y[1]);
+			val = res->l2_roi_path_info[regbuf_id].post_crop_y[1] +
+			      res->l2_roi_path_info[regbuf_id].post_crop_h[1];
+			y_max = max(y_max, val);
+		}
+		x = x_min;
+		y = y_min;
+		w = x_max - x_min;
+		h = y_max - y_min;
+	} else if (res->l2_roi_path_info[regbuf_id].post_enable_flag[1]) {
+		/* POST0 is disabled and POST1 is enabled */
+		x = res->l2_roi_path_info[regbuf_id].post_crop_x[1];
+		w = res->l2_roi_path_info[regbuf_id].post_crop_w[1];
+		y = res->l2_roi_path_info[regbuf_id].post_crop_y[1];
+		h = res->l2_roi_path_info[regbuf_id].post_crop_h[1];
+	} else {
+		/* All POSTs are disabled */
+		x = 0;
+		y = 0;
+		w = HWD_VIIF_CROP_MIN_W;
+		h = HWD_VIIF_CROP_MIN_H;
+	}
+	writel(x, &(res->capture_reg->l2isp.roi[0].L2_ROI_OUT_OFS_H));
+	writel(y, &(res->capture_reg->l2isp.roi[0].L2_ROI_OUT_OFS_V));
+	writel(w, &(res->capture_reg->l2isp.roi[0].L2_ROI_OUT_HSIZE));
+	writel(h, &(res->capture_reg->l2isp.roi[0].L2_ROI_OUT_VSIZE));
+
+	for (i = 0; i < HWD_VIIF_MAX_POST_NUM; i++) {
+		if (res->l2_roi_path_info[regbuf_id].post_enable_flag[i])
+			writel(0, &(res->capture_reg->l2isp.L2_ROI_TO_POST[i]));
+		else
+			writel(HWD_VIIF_L2_ROI_NONE, &(res->capture_reg->l2isp.L2_ROI_TO_POST[i]));
+	}
+}
+
+/**
+ * hwd_VIIF_l2_set_roi_num_2() - Set ROI path condition when ROI num is 2
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ */
+static void hwd_VIIF_l2_set_roi_num_2(uint32_t regbuf_id, struct hwd_viif_res *res)
+{
+	uint32_t i;
+
+	for (i = 0; i < HWD_VIIF_L2_ROI_MAX_NUM; i++) {
+		/* ROI-n is the same as CROP area of POST-n */
+		if (res->l2_roi_path_info[regbuf_id].post_enable_flag[i]) {
+			writel(res->l2_roi_path_info[regbuf_id].post_crop_x[i],
+			       &(res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_H));
+			writel(res->l2_roi_path_info[regbuf_id].post_crop_y[i],
+			       &(res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_V));
+			writel(res->l2_roi_path_info[regbuf_id].post_crop_w[i],
+			       &(res->capture_reg->l2isp.roi[i].L2_ROI_OUT_HSIZE));
+			writel(res->l2_roi_path_info[regbuf_id].post_crop_h[i],
+			       &(res->capture_reg->l2isp.roi[i].L2_ROI_OUT_VSIZE));
+			writel(i, &(res->capture_reg->l2isp.L2_ROI_TO_POST[i]));
+		} else {
+			writel(0, &(res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_H));
+			writel(0, &(res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_V));
+			writel(HWD_VIIF_CROP_MIN_W,
+			       &(res->capture_reg->l2isp.roi[i].L2_ROI_OUT_HSIZE));
+			writel(HWD_VIIF_CROP_MIN_H,
+			       &(res->capture_reg->l2isp.roi[i].L2_ROI_OUT_VSIZE));
+			writel(HWD_VIIF_L2_ROI_NONE, &(res->capture_reg->l2isp.L2_ROI_TO_POST[i]));
+		}
+	}
+}
+
+/**
+ * hwd_VIIF_l2_set_roi_path() - Set ROI path condition
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ */
+static void hwd_VIIF_l2_set_roi_path(uint32_t regbuf_id, struct hwd_viif_res *res)
+{
+	if (res->l2_roi_path_info[regbuf_id].roi_num == 1U)
+		hwd_VIIF_l2_set_roi_num_1(regbuf_id, res);
+	else
+		hwd_VIIF_l2_set_roi_num_2(regbuf_id, res);
+}
+
+/**
+ * hwd_VIIF_l2_set_roi() - Set ROI parameters of L2ISP
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @param: Pointer to ROI parameters of L2ISP
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "param" is NULL
+ * - [2] Member of "param" is invalid
+ *
+ * see also: #hwd_VIIF_l2_set_roi_path
+ */
+int32_t hwd_VIIF_l2_set_roi(uint32_t module_id, uint32_t regbuf_id,
+			    const struct hwd_viif_l2_roi *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val;
+
+	if (param == NULL)
+		return -EINVAL;
+
+	if ((param->roi_scale < HWD_VIIF_L2_ROI_MIN_SCALE) ||
+	    (param->roi_scale > HWD_VIIF_L2_ROI_MAX_SCALE)) {
+		return -EINVAL;
+	}
+	if ((param->roi_scale_inv < HWD_VIIF_L2_ROI_MIN_SCALE_INV) ||
+	    (param->roi_scale_inv > HWD_VIIF_L2_ROI_MAX_SCALE_INV)) {
+		return -EINVAL;
+	}
+	if ((param->corrected_wo_scale_hsize < HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_HSIZE) ||
+	    (param->corrected_wo_scale_hsize > HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_HSIZE)) {
+		return -EINVAL;
+	}
+	if ((param->corrected_wo_scale_vsize < HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_VSIZE) ||
+	    (param->corrected_wo_scale_vsize > HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_VSIZE)) {
+		return -EINVAL;
+	}
+	if ((param->corrected_hsize < HWD_VIIF_L2_ROI_MIN_CORRECTED_HSIZE) ||
+	    (param->corrected_hsize > HWD_VIIF_L2_ROI_MAX_CORRECTED_HSIZE)) {
+		return -EINVAL;
+	}
+	if ((param->corrected_vsize < HWD_VIIF_L2_ROI_MIN_CORRECTED_VSIZE) ||
+	    (param->corrected_vsize > HWD_VIIF_L2_ROI_MAX_CORRECTED_VSIZE)) {
+		return -EINVAL;
+	}
+
+	/* Set the number of ROI and update resource info with roi_num */
+	writel(1, &(res->capture_reg->l2isp.L2_ROI_NUM));
+	res->l2_roi_path_info[regbuf_id].roi_num = 1;
+
+	/* Update ROI area and input to each POST */
+	hwd_VIIF_l2_set_roi_path(regbuf_id, res);
+
+	/* Set the remaining parameters */
+	writel(param->roi_scale, &(res->capture_reg->l2isp.roi[0].L2_ROI_SCALE));
+	writel(param->roi_scale_inv, &(res->capture_reg->l2isp.roi[0].L2_ROI_SCALE_INV));
+	val = (param->corrected_wo_scale_hsize << 13U) | param->corrected_hsize;
+	writel(val, &(res->capture_reg->l2isp.roi[0].L2_ROI_CORRECTED_HSIZE));
+	val = (param->corrected_wo_scale_vsize << 12U) | param->corrected_vsize;
+	writel(val, &(res->capture_reg->l2isp.roi[0].L2_ROI_CORRECTED_VSIZE));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l2_set_gamma() - Set Gamma correction parameters of L2ISP
+ *
+ * @post_id: POST ID [0..1]
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @enable: or disable gamma correction of L2ISP. For more refer @ref hwd_VIIF_enable_flag.
+ * @vsplit: changing line position from 1st table to 2nd table [0..4094]
+ * @mode: Gamma correction mode. For more refer @ref hwd_VIIF_gamma_table_mode.
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "post_id", "enable", "vsplit"  or "mode" is out of range
+ * - [2] "vsplit" is not 0 when "enable" is HWD_VIIF_DISABLE
+ * - [3] "mode" is not HWD_VIIF_GAMMA_COMPRESSED when enable is HWD_VIIF_DISABLE
+ *
+ * see also: #hwd_VIIF_l2_set_gamma
+ */
+int32_t hwd_VIIF_l2_set_gamma(uint32_t module_id, uint32_t post_id, uint32_t regbuf_id,
+			      uint32_t enable, uint32_t vsplit, uint32_t mode)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val;
+
+	if (post_id >= HWD_VIIF_MAX_POST_NUM)
+		return -EINVAL;
+
+	if ((enable != HWD_VIIF_ENABLE) && (enable != HWD_VIIF_DISABLE))
+		return -EINVAL;
+
+	if (vsplit > HWD_VIIF_GAMMA_MAX_VSPLIT)
+		return -EINVAL;
+
+	if ((mode != HWD_VIIF_GAMMA_COMPRESSED) && (mode != HWD_VIIF_GAMMA_LINEAR))
+		return -EINVAL;
+
+	if ((enable == HWD_VIIF_DISABLE) && (vsplit != 0x0U))
+		return -EINVAL;
+
+	if ((enable == HWD_VIIF_DISABLE) && (mode != HWD_VIIF_GAMMA_COMPRESSED))
+		return -EINVAL;
+
+	/* Set gamma parameters of L2ISP */
+	val = (vsplit << 16U) | (mode << 4U) | enable;
+	writel(val, &(res->capture_reg->l2isp.post[post_id].L2_POST_GAMMA_M));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l2_set_gamma_table_transmission() - Configure L2ISP transferring gamma table.
+ *
+ * @post_id: POST ID [0..1]
+ * @gamma_table: Pointer to gamma table information
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "post_id" is out of range
+ * - [2] Member of "gamma_table" is invalid
+ */
+int32_t hwd_VIIF_l2_set_gamma_table_transmission(uint32_t module_id, uint32_t post_id,
+						 const struct hwd_viif_l2_gamma_table *gamma_table)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t i, base_addr;
+	uint32_t vdm_enable = 0U;
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
+			writel((uint32_t)gamma_table->table[i],
+			       &(res->capture_reg->vdm.t_port[(12U + i + (post_id * 6U))]
+					 .VDM_T_STADR));
+			writel(HWD_VIIF_L2_VDM_GAMMA_TABLE_SIZE,
+			       &(res->capture_reg->vdm.t_port[(12U + i + (post_id * 6U))]
+					 .VDM_T_SIZE));
+			vdm_enable |= BIT(i);
+		}
+	}
+	if (vdm_enable != 0U) {
+		/* t_group[2..3] is used only to transfer GAMMA table */
+		/* [2]: POST0, [3]: POST1 */
+		writel(HWD_VIIF_VDM_CFG_PARAM,
+		       &(res->capture_reg->vdm.t_group[(post_id + 2U)].VDM_T_CFG));
+		base_addr = HWD_VIIF_L2_VDM_GAMMA_SRAM_BASE +
+			    (HWD_VIIF_L2_VDM_GAMMA_SRAM_SIZE * post_id);
+		writel(base_addr, &(res->capture_reg->vdm.t_group[(post_id + 2U)].VDM_T_SRAM_BASE));
+		writel(HWD_VIIF_L2_VDM_GAMMA_SRAM_SIZE,
+		       &(res->capture_reg->vdm.t_group[(post_id + 2U)].VDM_T_SRAM_SIZE));
+		vdm_enable = vdm_enable << (12U + (post_id * 6U));
+	}
+	vdm_enable |= (readl(&res->capture_reg->vdm.VDM_T_ENABLE) &
+		       ~((uint32_t)0x3fU << (12U + (post_id * 6U))));
+	writel(vdm_enable, &(res->capture_reg->vdm.VDM_T_ENABLE));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l2_set_output_csc() - Set output CSC parameters of L2ISP
+ *
+ * @post_id: POST ID [0..1]
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @param: Pointer to output csc parameters of L2ISP
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "post_id" is out of range
+ * - [2] Member of "param" is invalid
+ */
+int32_t hwd_VIIF_l2_set_output_csc(uint32_t module_id, uint32_t post_id, uint32_t regbuf_id,
+				   const struct hwd_viif_csc_param *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t i, val;
+	uint32_t enable = HWD_VIIF_DISABLE;
+
+	if (post_id >= HWD_VIIF_MAX_POST_NUM)
+		return -EINVAL;
+
+	if (param != NULL) {
+		if (param->r_cr_in_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->g_y_in_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->b_cb_in_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->r_cr_out_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->g_y_out_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->b_cb_out_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		for (i = 0; i < HWD_VIIF_CSC_MAX_COEF_NUM; i++) {
+			if (param->coef[i] > HWD_VIIF_CSC_MAX_COEF_VALUE)
+				return -EINVAL;
+		}
+
+		writel(param->g_y_in_offset,
+		       &(res->capture_reg->l2isp.post[post_id].csc.MTB_YG_OFFSETI));
+		writel(param->coef[0], &(res->capture_reg->l2isp.post[post_id].csc.MTB_YG1));
+		val = (param->coef[1] << HWD_VIIF_MTB_CB_YG_COEF_OFFSET) |
+		      (param->coef[2] << HWD_VIIF_MTB_CR_YG_COEF_OFFSET);
+		writel(val, &(res->capture_reg->l2isp.post[post_id].csc.MTB_YG2));
+		writel(param->g_y_out_offset,
+		       &(res->capture_reg->l2isp.post[post_id].csc.MTB_YG_OFFSETO));
+		writel(param->b_cb_in_offset,
+		       &(res->capture_reg->l2isp.post[post_id].csc.MTB_CB_OFFSETI));
+		writel(param->coef[3], &(res->capture_reg->l2isp.post[post_id].csc.MTB_CB1));
+		val = (param->coef[4] << HWD_VIIF_MTB_CB_CB_COEF_OFFSET) |
+		      (param->coef[5] << HWD_VIIF_MTB_CR_CB_COEF_OFFSET);
+		writel(val, &(res->capture_reg->l2isp.post[post_id].csc.MTB_CB2));
+		writel(param->b_cb_out_offset,
+		       &(res->capture_reg->l2isp.post[post_id].csc.MTB_CB_OFFSETO));
+		writel(param->r_cr_in_offset,
+		       &(res->capture_reg->l2isp.post[post_id].csc.MTB_CR_OFFSETI));
+		writel(param->coef[6], &(res->capture_reg->l2isp.post[post_id].csc.MTB_CR1));
+		val = (param->coef[7] << HWD_VIIF_MTB_CB_CR_COEF_OFFSET) |
+		      (param->coef[8] << HWD_VIIF_MTB_CR_CR_COEF_OFFSET);
+		writel(val, &(res->capture_reg->l2isp.post[post_id].csc.MTB_CR2));
+		writel(param->r_cr_out_offset,
+		       &(res->capture_reg->l2isp.post[post_id].csc.MTB_CR_OFFSETO));
+		enable = HWD_VIIF_ENABLE;
+	}
+	writel(enable, &(res->capture_reg->l2isp.post[post_id].csc.MTB));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l2_set_img_transmission() - Set image transfer condition of L2ISP
+ *
+ * @post_id: POST ID [0..1]
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @enable: or disable image transfer of MAIN unit. For more refer @ref hwd_VIIF_enable_flag.
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
+ * - [5] "w" of "src" is not equal to 2 * "width" of "image" when "half_scal" of "out_process" is HWD_VIIF_ENABLE
+ * - [6] "h" of "src" is not equal to 2 * "height" of "image" when "half_scal" of "out_process" is HWD_VIIF_ENABLE
+ * - [7] "w" of "src" is not equal to "width" of "image" when "half_scal" of "out_process" is HWD_VIIF_DISABLE
+ * - [8] "h" of "src" is not equal to "height" of "image" when "half_scal" of "out_process" is HWD_VIIF_DISABLE
+ * - [9] Member of "out_process" is invalid
+ * - [10] "alpha" of "out_process" is not 0 when "format" of "img" is not HWD_VIIF_ARGB8888_PACKED
+ * - [11] "format" of "img" is not HWD_VIIF_ONE_COLOR_8 or HWD_VIIF_ONE_COLOR_16 when "select_color" of "out_process"
+ * is HWD_VIIF_COLOR_Y_G, HWD_VIIF_COLOR_U_B or HWD_VIIF_COLOR_V_R
+ * - [12] Member of "img" is invalid
+ *
+ * see also: #hwd_VIIF_l2_set_roi_path
+ */
+int32_t hwd_VIIF_l2_set_img_transmission(uint32_t module_id, uint32_t post_id, uint32_t regbuf_id,
+					 uint32_t enable, const struct hwd_viif_img_area *src,
+					 const struct hwd_viif_out_process *out_process,
+					 const struct hwd_viif_img *img)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	int32_t ret = 0;
+	uint32_t pitch[HWD_VIIF_MAX_PLANE_NUM], img_start_addr[HWD_VIIF_MAX_PLANE_NUM];
+	uint32_t i, val, loop, k, r[HWD_VIIF_MAX_PLANE_NUM];
+
+	/* pitch alignment for planar or one color format */
+	uint32_t pitch_align = 128U;
+
+	if (post_id >= HWD_VIIF_MAX_POST_NUM)
+		return -EINVAL;
+
+	if ((enable != HWD_VIIF_ENABLE) && (enable != HWD_VIIF_DISABLE))
+		return -EINVAL;
+
+	if ((enable == HWD_VIIF_ENABLE) && ((src == NULL) || (out_process == NULL)))
+		return -EINVAL;
+
+	if ((enable == HWD_VIIF_DISABLE) && ((src != NULL) || (out_process != NULL)))
+		return -EINVAL;
+
+	if (enable == HWD_VIIF_ENABLE) {
+		if ((out_process->half_scale != HWD_VIIF_ENABLE) &&
+		    (out_process->half_scale != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if ((out_process->select_color != HWD_VIIF_COLOR_Y_G) &&
+		    (out_process->select_color != HWD_VIIF_COLOR_U_B) &&
+		    (out_process->select_color != HWD_VIIF_COLOR_V_R) &&
+		    (out_process->select_color != HWD_VIIF_COLOR_YUV_RGB)) {
+			return -EINVAL;
+		}
+
+		if ((img->format != HWD_VIIF_ARGB8888_PACKED) && (out_process->alpha != 0U))
+			return -EINVAL;
+
+		if (((img->width % 2U) != 0U) || ((img->height % 2U) != 0U) ||
+		    (img->width < HWD_VIIF_MIN_OUTPUT_IMG_WIDTH) ||
+		    (img->height < HWD_VIIF_MIN_OUTPUT_IMG_HEIGHT) ||
+		    (img->width > HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_ISP) ||
+		    (img->height > HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP)) {
+			return -EINVAL;
+		}
+
+		if ((src->x > HWD_VIIF_CROP_MAX_X_ISP) || (src->y > HWD_VIIF_CROP_MAX_Y_ISP) ||
+		    (src->w < HWD_VIIF_CROP_MIN_W) || (src->w > HWD_VIIF_CROP_MAX_W_ISP) ||
+		    (src->h < HWD_VIIF_CROP_MIN_H) || (src->h > HWD_VIIF_CROP_MAX_H_ISP)) {
+			return -EINVAL;
+		}
+
+		if (out_process->half_scale == HWD_VIIF_ENABLE) {
+			if ((src->w != (img->width * 2U)) || (src->h != (img->height * 2U)))
+				return -EINVAL;
+		} else {
+			if ((src->w != img->width) || (src->h != img->height))
+				return -EINVAL;
+		}
+
+		if ((out_process->select_color == HWD_VIIF_COLOR_Y_G) ||
+		    (out_process->select_color == HWD_VIIF_COLOR_U_B) ||
+		    (out_process->select_color == HWD_VIIF_COLOR_V_R)) {
+			if ((img->format != HWD_VIIF_ONE_COLOR_8) &&
+			    (img->format != HWD_VIIF_ONE_COLOR_16)) {
+				return -EINVAL;
+			}
+		}
+
+		switch (img->format) {
+		case HWD_VIIF_YCBCR422_8_PACKED:
+			img_start_addr[0] = (uint32_t)img->pixelmap[0].pmap_paddr;
+			pitch[0] = img->pixelmap[0].pitch;
+			loop = 1U;
+			k = 2U;
+			r[0] = 1U;
+			pitch_align = 256U;
+			break;
+		case HWD_VIIF_RGB888_PACKED:
+			img_start_addr[0] = (uint32_t)img->pixelmap[0].pmap_paddr;
+			pitch[0] = img->pixelmap[0].pitch;
+			loop = 1U;
+			k = 3U;
+			r[0] = 1U;
+			pitch_align = 384U;
+			break;
+		case HWD_VIIF_ARGB8888_PACKED:
+			img_start_addr[0] = (uint32_t)img->pixelmap[0].pmap_paddr;
+			pitch[0] = img->pixelmap[0].pitch;
+			loop = 1U;
+			k = 4U;
+			r[0] = 1U;
+			pitch_align = 512U;
+			break;
+		case HWD_VIIF_ONE_COLOR_8:
+			img_start_addr[0] = (uint32_t)img->pixelmap[0].pmap_paddr;
+			pitch[0] = img->pixelmap[0].pitch;
+			loop = 1U;
+			k = 1U;
+			r[0] = 1U;
+			break;
+		case HWD_VIIF_ONE_COLOR_16:
+			img_start_addr[0] = (uint32_t)img->pixelmap[0].pmap_paddr;
+			pitch[0] = img->pixelmap[0].pitch;
+			loop = 1U;
+			k = 2U;
+			r[0] = 1U;
+			break;
+		case HWD_VIIF_YCBCR422_8_PLANAR:
+			img_start_addr[0] = (uint32_t)img->pixelmap[0].pmap_paddr;
+			img_start_addr[1] = (uint32_t)img->pixelmap[1].pmap_paddr;
+			img_start_addr[2] = (uint32_t)img->pixelmap[2].pmap_paddr;
+			pitch[0] = img->pixelmap[0].pitch;
+			pitch[1] = img->pixelmap[1].pitch;
+			pitch[2] = img->pixelmap[2].pitch;
+			loop = HWD_VIIF_MAX_PLANE_NUM;
+			k = 1U;
+			r[0] = 1U;
+			r[1] = 2U;
+			r[2] = 2U;
+			break;
+		case HWD_VIIF_RGB888_YCBCR444_8_PLANAR:
+			img_start_addr[0] = (uint32_t)img->pixelmap[0].pmap_paddr;
+			img_start_addr[1] = (uint32_t)img->pixelmap[1].pmap_paddr;
+			img_start_addr[2] = (uint32_t)img->pixelmap[2].pmap_paddr;
+			pitch[0] = img->pixelmap[0].pitch;
+			pitch[1] = img->pixelmap[1].pitch;
+			pitch[2] = img->pixelmap[2].pitch;
+			loop = HWD_VIIF_MAX_PLANE_NUM;
+			k = 1U;
+			r[0] = 1U;
+			r[1] = 1U;
+			r[2] = 1U;
+			loop = HWD_VIIF_MAX_PLANE_NUM;
+			break;
+		case HWD_VIIF_YCBCR422_16_PLANAR:
+			img_start_addr[0] = (uint32_t)img->pixelmap[0].pmap_paddr;
+			img_start_addr[1] = (uint32_t)img->pixelmap[1].pmap_paddr;
+			img_start_addr[2] = (uint32_t)img->pixelmap[2].pmap_paddr;
+			pitch[0] = img->pixelmap[0].pitch;
+			pitch[1] = img->pixelmap[1].pitch;
+			pitch[2] = img->pixelmap[2].pitch;
+			loop = HWD_VIIF_MAX_PLANE_NUM;
+			k = 2U;
+			r[0] = 1U;
+			r[1] = 2U;
+			r[2] = 2U;
+			break;
+		case HWD_VIIF_RGB161616_YCBCR444_16_PLANAR:
+			img_start_addr[0] = (uint32_t)img->pixelmap[0].pmap_paddr;
+			img_start_addr[1] = (uint32_t)img->pixelmap[1].pmap_paddr;
+			img_start_addr[2] = (uint32_t)img->pixelmap[2].pmap_paddr;
+			pitch[0] = img->pixelmap[0].pitch;
+			pitch[1] = img->pixelmap[1].pitch;
+			pitch[2] = img->pixelmap[2].pitch;
+			loop = HWD_VIIF_MAX_PLANE_NUM;
+			k = 2U;
+			r[0] = 1U;
+			r[1] = 1U;
+			r[2] = 1U;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+
+		if (ret == 0) {
+			for (i = 0; i < loop; i++) {
+				val = max(((img->width * k) / r[i]), 128U);
+				if ((pitch[i] < val) || (pitch[i] > HWD_VIIF_MAX_PITCH_ISP) ||
+				    ((pitch[i] % pitch_align) != 0U) ||
+				    ((img_start_addr[i] % 4U) != 0U)) {
+					ret = -EINVAL;
+				}
+				if (ret == -EINVAL)
+					break;
+			}
+
+			if (ret == 0) {
+				writel(img_start_addr[0],
+				       &(res->capture_reg->l2isp.post[post_id].L2_POST_OUT_STADR_G));
+				writel(pitch[0],
+				       &(res->capture_reg->l2isp.post[post_id].L2_POST_OUT_PITCH_G));
+				if (loop == HWD_VIIF_MAX_PLANE_NUM) {
+					writel(img_start_addr[1],
+					       &(res->capture_reg->l2isp.post[post_id]
+							 .L2_POST_OUT_STADR_B));
+					writel(img_start_addr[2],
+					       &(res->capture_reg->l2isp.post[post_id]
+							 .L2_POST_OUT_STADR_R));
+					writel(pitch[1], &(res->capture_reg->l2isp.post[post_id]
+								   .L2_POST_OUT_PITCH_B));
+					writel(pitch[2], &(res->capture_reg->l2isp.post[post_id]
+								   .L2_POST_OUT_PITCH_R));
+				}
+
+				/* Set CROP */
+				val = (src->y << 16U) | src->x;
+				writel(val,
+				       &(res->capture_reg->l2isp.post[post_id].L2_POST_CAP_OFFSET));
+				val = (src->h << 16U) | src->w;
+				writel(val,
+				       &(res->capture_reg->l2isp.post[post_id].L2_POST_CAP_SIZE));
+
+				/* Set output process */
+				writel(out_process->half_scale,
+				       &(res->capture_reg->l2isp.post[post_id]
+						 .L2_POST_HALF_SCALE_EN));
+				writel(out_process->select_color,
+				       &(res->capture_reg->l2isp.post[post_id].L2_POST_C_SELECT));
+				writel((uint32_t)out_process->alpha,
+				       &(res->capture_reg->l2isp.post[post_id].L2_POST_OPORTALP));
+				writel(img->format,
+				       &(res->capture_reg->l2isp.post[post_id].L2_POST_OPORTFMT));
+
+				/* Update ROI area and input to each POST */
+				res->l2_roi_path_info[regbuf_id].post_enable_flag[post_id] = true;
+				res->l2_roi_path_info[regbuf_id].post_crop_x[post_id] = src->x;
+				res->l2_roi_path_info[regbuf_id].post_crop_y[post_id] = src->y;
+				res->l2_roi_path_info[regbuf_id].post_crop_w[post_id] = src->w;
+				res->l2_roi_path_info[regbuf_id].post_crop_h[post_id] = src->h;
+				hwd_VIIF_l2_set_roi_path(regbuf_id, res);
+			}
+		}
+	} else {
+		/* Update ROI area and input to each POST */
+		res->l2_roi_path_info[regbuf_id].post_enable_flag[post_id] = false;
+		res->l2_roi_path_info[regbuf_id].post_crop_x[post_id] = 0U;
+		res->l2_roi_path_info[regbuf_id].post_crop_y[post_id] = 0U;
+		res->l2_roi_path_info[regbuf_id].post_crop_w[post_id] = HWD_VIIF_CROP_MIN_W;
+		res->l2_roi_path_info[regbuf_id].post_crop_h[post_id] = HWD_VIIF_CROP_MIN_H;
+		hwd_VIIF_l2_set_roi_path(regbuf_id, res);
+	}
+
+	return ret;
+}
+
+/**
+ * hwd_VIIF_l2_set_irq_mask() - Set mask condition for L2ISP
+ *
+ * @mask: Pointer to L2ISP mask condition
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_VIIF_l2_set_irq_mask(uint32_t module_id, const uint32_t *mask)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	writel(*mask, &(res->capture_reg->l2isp.L2_CRGBF_ISP_INT_MASK));
+}
+
+/**
+ * hwd_VIIF_csi2rx_err_irq_handler() - CSI-2 RX error interruption handler
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: event information of CSI-2 RX error interruption
+ */
+uint32_t hwd_VIIF_csi2rx_err_irq_handler(uint32_t module_id)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	return readl(&res->csi2host_reg->CSI2RX_INT_ST_MAIN);
+}
+
+/**
+ * hwd_VIIF_status_err_irq_handler() - STATUS error interruption handler
+ *
+ * @event_main: information of STATUS error interruption of MAIN unit
+ * @event_sub: information of STATUS error interruption of SUB unit(CH0 and CH1) or VOIF loopback(CH2)
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_VIIF_status_err_irq_handler(uint32_t module_id, uint32_t *event_main, uint32_t *event_sub)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val, mask;
+
+	*event_main = HWD_VIIF_NO_EVENT;
+	*event_sub = HWD_VIIF_NO_EVENT;
+
+	val = readl(&res->capture_reg->sys.INT_M_STATUS);
+	mask = readl(&res->capture_reg->sys.INT_M_MASK);
+	val = val & ~mask;
+	if (val != HWD_VIIF_NO_EVENT) {
+		writel(val, &(res->capture_reg->sys.INT_M_STATUS));
+		*event_main = val;
+	}
+
+	val = readl(&res->capture_reg->sys.INT_S_STATUS);
+	mask = readl(&res->capture_reg->sys.INT_S_MASK);
+	val = val & ~mask;
+	if (val != HWD_VIIF_NO_EVENT) {
+		writel(val, &(res->capture_reg->sys.INT_S_STATUS));
+		*event_sub = val;
+	}
+}
+
+/**
+ * hwd_VIIF_vsync_irq_handler() - Vsync interruption handler
+ *
+ * @event_main: information of Vsync interruption of MAIN unit
+ * @event_sub: information of Vsync interruption of SUB unit(CH0 and CH1)
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_VIIF_vsync_irq_handler(uint32_t module_id, uint32_t *event_main, uint32_t *event_sub)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val, mask;
+
+	*event_main = HWD_VIIF_NO_EVENT;
+	*event_sub = HWD_VIIF_NO_EVENT;
+
+	val = readl(&res->capture_reg->sys.INT_M_SYNC);
+	mask = readl(&res->capture_reg->sys.INT_M_SYNC_MASK);
+	val = val & ~mask;
+	if (val != HWD_VIIF_NO_EVENT) {
+		writel(val, &(res->capture_reg->sys.INT_M_SYNC));
+		*event_main = val;
+	}
+
+	val = readl(&res->capture_reg->sys.INT_S_SYNC);
+	mask = readl(&res->capture_reg->sys.INT_S_SYNC_MASK);
+	val = val & ~mask;
+	if (val != HWD_VIIF_NO_EVENT) {
+		writel(val, &(res->capture_reg->sys.INT_S_SYNC));
+		*event_sub = val;
+	}
+}
+
+/**
+ * hwd_VIIF_isp_regbuf_irq_handler() - ISP register buffer interruption handler
+ *
+ * @event_l1: information of register buffer interruption of L1ISP
+ * @event_l2: information of register buffer interruption of L2ISP
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_VIIF_isp_regbuf_irq_handler(uint32_t module_id, uint32_t *event_l1, uint32_t *event_l2)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val;
+
+	*event_l1 = HWD_VIIF_NO_EVENT;
+	*event_l2 = HWD_VIIF_NO_EVENT;
+
+	val = readl(&res->capture_reg->l1isp.L1_CRGBF_INT_MASKED_STAT);
+	if (val != HWD_VIIF_NO_EVENT) {
+		*event_l1 = val;
+		writel(val, &(res->capture_reg->l1isp.L1_CRGBF_INT_STAT));
+	}
+
+	val = readl(&res->capture_reg->l2isp.L2_CRGBF_INT_MASKED_STAT);
+	if (val != HWD_VIIF_NO_EVENT) {
+		*event_l2 = val;
+		writel(val, &(res->capture_reg->l2isp.L2_CRGBF_INT_STAT));
+	}
+}
diff --git a/drivers/media/platform/visconti/hwd_viif.h b/drivers/media/platform/visconti/hwd_viif.h
new file mode 100644
index 000000000..c0cc83473
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif.h
@@ -0,0 +1,1776 @@
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
+enum hwd_power_ctrl {
+	HWD_POWER_OFF = 0, /**< Power off */
+	HWD_POWER_ON /**< Power on  */
+};
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
+/* hwd_VIIF_enable_flag */
+#define HWD_VIIF_DISABLE (0U)
+#define HWD_VIIF_ENABLE	 (1U)
+
+/* hwd_VIIF_memory_sync_type */
+#define HWD_VIIF_MEM_SYNC_INTERNAL (0U)
+#define HWD_VIIF_MEM_SYNC_CSI2	   (1U)
+
+/* hwd_VIIF_color_format */
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
+/* hwd_VIIF_raw_pack_mode */
+#define HWD_VIIF_RAWPACK_DISABLE  (0U)
+#define HWD_VIIF_RAWPACK_MSBFIRST (2U)
+#define HWD_VIIF_RAWPACK_LSBFIRST (3U)
+
+/* hwd_VIIF_yuv_conversion_mode */
+#define HWD_VIIF_YUV_CONV_REPEAT	(0U)
+#define HWD_VIIF_YUV_CONV_INTERPOLATION (1U)
+
+/* hwd_VIIF_gamma_table_mode */
+#define HWD_VIIF_GAMMA_COMPRESSED (0U)
+#define HWD_VIIF_GAMMA_LINEAR	  (1U)
+
+/* hwd_VIIF_output_color_mode */
+#define HWD_VIIF_COLOR_Y_G     (0U)
+#define HWD_VIIF_COLOR_U_B     (1U)
+#define HWD_VIIF_COLOR_V_R     (2U)
+#define HWD_VIIF_COLOR_YUV_RGB (4U)
+
+/* hwd_VIIF_hw_params */
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
+/* hwd_VIIF_csi2rx_input_mode */
+#define HWD_VIIF_CSI2_INPUT_OWN	  (0U)
+#define HWD_VIIF_CSI2_INPUT_OTHER (1U)
+
+/* hwd_VIIF_csi2rx_cal_status */
+#define HWD_VIIF_CSI2_CAL_NOT_DONE (0U)
+#define HWD_VIIF_CSI2_CAL_SUCCESS  (1U)
+#define HWD_VIIF_CSI2_CAL_FAIL	   (2U)
+
+/* hwd_VIIF_csi2rx_not_capture */
+#define HWD_VIIF_CSI2_NOT_CAPTURE (-1) /**< csi2 not capture */
+
+/* hwd_VIIF_l1_input_mode */
+#define HWD_VIIF_L1_INPUT_HDR		  (0U)
+#define HWD_VIIF_L1_INPUT_PWL		  (1U)
+#define HWD_VIIF_L1_INPUT_SDR		  (2U)
+#define HWD_VIIF_L1_INPUT_HDR_IMG_CORRECT (3U)
+#define HWD_VIIF_L1_INPUT_PWL_IMG_CORRECT (4U)
+
+/* hwd_VIIF_l1_raw_color_filter_mode */
+#define HWD_VIIF_L1_RAW_GR_R_B_GB (0U)
+#define HWD_VIIF_L1_RAW_R_GR_GB_B (1U)
+#define HWD_VIIF_L1_RAW_B_GB_GR_R (2U)
+#define HWD_VIIF_L1_RAW_GB_B_R_GR (3U)
+
+/* hwd_VIIF_l1_input_interpolation_mode */
+#define HWD_VIIF_L1_INPUT_INTERPOLATION_LINE  (0U)
+#define HWD_VIIF_L1_INPUT_INTERPOLATION_PIXEL (1U)
+
+/* hwd_VIIF_l1_img_sens */
+#define HWD_VIIF_L1_IMG_SENSITIVITY_HIGH       (0U)
+#define HWD_VIIF_L1_IMG_SENSITIVITY_MIDDLE_LED (1U)
+#define HWD_VIIF_L1_IMG_SENSITIVITY_LOW	       (2U)
+
+/* hwd_VIIF_l1_dpc */
+#define HWD_VIIF_L1_DPC_1PIXEL (0U)
+#define HWD_VIIF_L1_DPC_2PIXEL (1U)
+
+/* hwd_VIIF_l1_rcnr_hry_type */
+#define HWD_VIIF_L1_RCNR_LOW_RESOLUTION	       (0U)
+#define HWD_VIIF_L1_RCNR_MIDDLE_RESOLUTION     (1U)
+#define HWD_VIIF_L1_RCNR_HIGH_RESOLUTION       (2U)
+#define HWD_VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION (3U)
+
+/* hwd_VIIF_l1_rcnr_msf_blend_ratio */
+#define HWD_VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 (0U)
+#define HWD_VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 (1U)
+#define HWD_VIIF_L1_MSF_BLEND_RATIO_2_DIV_64 (2U)
+
+/* hwd_VIIF_l1_hdrs */
+#define HWD_VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE (0U)
+#define HWD_VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE	   (1U)
+
+/* hwd_VIIF_l1_lsc_para_mag */
+#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH (0U)
+#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH (1U)
+#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_SECOND (2U)
+#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FIRST  (3U)
+
+/* hwd_VIIF_l1_lsc_grid_mag */
+#define HWD_VIIF_L1_GRID_COEF_GAIN_X1 (0U)
+#define HWD_VIIF_L1_GRID_COEF_GAIN_X2 (1U)
+
+/* hwd_VIIF_l1_demosaic */
+#define HWD_VIIF_L1_DEMOSAIC_ACPI (0U)
+#define HWD_VIIF_L1_DEMOSAIC_DMG  (1U)
+
+/* hwd_VIIF_l1_awb_restart_cond */
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
+/* hwd_VIIF_l1_awb_mag */
+#define HWD_VIIF_L1_AWB_ONE_SECOND (0U)
+#define HWD_VIIF_L1_AWB_X1	   (1U)
+#define HWD_VIIF_L1_AWB_X2	   (2U)
+#define HWD_VIIF_L1_AWB_X4	   (3U)
+
+/* hwd_VIIF_l1_awb_area_mode */
+#define HWD_VIIF_L1_AWB_AREA_MODE0 (0U)
+#define HWD_VIIF_L1_AWB_AREA_MODE1 (1U)
+#define HWD_VIIF_L1_AWB_AREA_MODE2 (2U)
+#define HWD_VIIF_L1_AWB_AREA_MODE3 (3U)
+
+/* hwd_VIIF_l1_hdrc_tone_type */
+#define HWD_VIIF_L1_HDRC_TONE_USER   (0U)
+#define HWD_VIIF_L1_HDRC_TONE_PRESET (1U)
+
+/* hwd_VIIF_l1_bin_mode */
+#define HWD_VIIF_L1_HIST_BIN_MODE_LINEAR (0U)
+#define HWD_VIIF_L1_HIST_BIN_MODE_LOG	 (1U)
+
+/* hwd_VIIF_l2_undist_mode */
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
+	uint32_t vc[VISCONTI_CSI2_ERROR_MONITORS_NUM];
+	uint32_t dt[VISCONTI_CSI2_ERROR_MONITORS_NUM];
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
+	uint32_t mask[VISCONTI_CSI2RX_IRQ_MASKS_NUM];
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
+ * Regarding word_count of long packet data, word count of odd line needs to be set in case of DT = 0x18, 0x19, 0x1C or 0x1D.
+ */
+#define VISCONTI_CSI2RX_PACKET_TYPES_NUM      4
+#define VISCONTI_CSI2RX_PACKET_TYPE_EMB_MAIN  0
+#define VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN 1
+#define VISCONTI_CSI2RX_PACKET_TYPE_EMB_SUB   2
+#define VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB  3
+struct hwd_viif_csi2rx_packet {
+	uint32_t word_count[VISCONTI_CSI2RX_PACKET_TYPES_NUM];
+	uint32_t packet_num[VISCONTI_CSI2RX_PACKET_TYPES_NUM];
+};
+
+/**
+ * struct hwd_viif_csi2rx_dphy_calibration_status - CSI2 DPHY calibration status
+ * 
+ * @term_cal_with_rext: result of termination calibration with rext
+ * @clock_lane_offset_cal: result of offset calibration of clock lane
+ * @data_lane0_offset_cal: result of offset calibration of data lane0
+ * @data_lane1_offset_cal: result of offset calibration of data lane1
+ * @data_lane2_offset_cal: result of offset calibration of data lane2
+ * @data_lane3_offset_cal: result of offset calibration of data lane3
+ * @data_lane0_ddl_tuning_cal: result of digital delay line tuning calibration of data lane0
+ * @data_lane1_ddl_tuning_cal: result of digital delay line tuning calibration of data lane1
+ * @data_lane2_ddl_tuning_cal: result of digital delay line tuning calibration of data lane2
+ * @data_lane3_ddl_tuning_cal: result of digital delay line tuning calibration of data lane3
+ */
+struct hwd_viif_csi2rx_dphy_calibration_status {
+	uint32_t term_cal_with_rext;
+	uint32_t clock_lane_offset_cal;
+	uint32_t data_lane0_offset_cal;
+	uint32_t data_lane1_offset_cal;
+	uint32_t data_lane2_offset_cal;
+	uint32_t data_lane3_offset_cal;
+	uint32_t data_lane0_ddl_tuning_cal;
+	uint32_t data_lane1_ddl_tuning_cal;
+	uint32_t data_lane2_ddl_tuning_cal;
+	uint32_t data_lane3_ddl_tuning_cal;
+};
+
+/**
+ * struct hwd_viif_csi2rx_capture_info - CSI2 captured packet information
+ * @img_size_1st: 1st packet size of image data[byte]
+ * @img_size_2nd: 2nd packet size of image data[byte]
+ * @img_num: the number of packet of image data
+ * @emb_top_size:  packet size of embedded data just after FS packet[byte]
+ * @emb_top_num: the number of packet just after FS packet
+ * @emb_bottom_size: packet size of embedded data just after FE packet[byte]
+ * @emb_bottom_num: the number of packet just after FE packet
+ * @long_packet_size_1st: 1st packet size of long packet data[byte]
+ * @long_packet_size_2nd: 2nd packet size of long packet data[byte]
+ * @long_packet_num: the number of packet of long packet data
+ */
+struct hwd_viif_csi2rx_capture_info {
+	uint32_t img_size_1st;
+	uint32_t img_size_2nd;
+	uint32_t img_num;
+	uint32_t emb_top_size;
+	uint32_t emb_top_num;
+	uint32_t emb_bottom_size;
+	uint32_t emb_bottom_num;
+	uint32_t long_packet_size_1st;
+	uint32_t long_packet_size_2nd;
+	uint32_t long_packet_num;
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
+	uint32_t pitch;
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
+ * @format: hwd_VIIF_color_format "color format"
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
+	uint32_t width;
+	uint32_t height;
+	uint32_t format;
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
+ * @interpolation_mode: input image interpolation mode for hwd_VIIF_l1_input_interpolation_mode
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
+ * * interpolation_mode is HWD_VIIF_L1_INPUT_INTERPOLATION_LINE: (htotal_size > (hactive_size + hobc_width + hobc_margin)) &&
+ * (vtotal_size > (vbp_size + vactive_size * input_num))
+ * * interpolation_mode is HWD_VIIF_L1_INPUT_INTERPOLATION_PIXEL: (htotal_size > ((hactive_size + hobc_width + hobc_margin) *
+ * input_num)) && (vtotal_size > (vbp_size + vactive_size))
+ * * L1ISP is used: vbp_size >= (54720[cycle] / 500000[kHz]) * (pixel_clock / htotal_size) + 38 + ISST time
+ * * L1ISP is not used: vbp_size >= (39360[cycle] / 500000[kHz]) * (pixel_clock / htotal_size) + 16 + ISST time
+ *
+ * Note: L1ISP is used when RAW data is input to MAIN unit
+ */
+struct hwd_viif_input_img {
+	uint32_t pixel_clock;
+	uint32_t htotal_size;
+	uint32_t hactive_size;
+	uint32_t vtotal_size;
+	uint32_t vbp_size;
+	uint32_t vactive_size;
+	uint32_t interpolation_mode;
+	uint32_t input_num;
+	uint32_t hobc_width;
+	uint32_t hobc_margin;
+};
+
+/**
+ * struct hwd_viif_main_gamma - configuration of gamma of MAIN unit
+ * @mode: hwd_VIIF_gamma_table_mode
+ * @table: table address(physical address)
+ * * [0]: G/Y
+ * * [1]: B/U
+ * * [2]: R/V
+ *
+ * * When 0 is set, the table transfer is disabled.
+ * * Each table address needs to be 4 byte alignment.
+ */
+struct hwd_viif_main_gamma {
+	uint32_t mode;
+	uintptr_t table[3];
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
+	uint32_t r_cr_in_offset;
+	uint32_t g_y_in_offset;
+	uint32_t b_cb_in_offset;
+	uint32_t coef[9];
+	uint32_t r_cr_out_offset;
+	uint32_t g_y_out_offset;
+	uint32_t b_cb_out_offset;
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
+	uint32_t x;
+	uint32_t y;
+	uint32_t w;
+	uint32_t h;
+};
+
+/**
+ * struct hwd_viif_out_process - configuration of output process of MAIN unit and L2ISP
+ * @half_scale: hwd_VIIF_enable_flag "enable or disable half scale"
+ * @select_color: hwd_VIIF_output_color_mode "select output color"
+ * @alpha: alpha value used in case of ARGB8888 output [0..255]
+ */
+struct hwd_viif_out_process {
+	uint32_t half_scale;
+	uint32_t select_color;
+	uint8_t alpha;
+};
+
+/**
+ * struct hwd_viif_main_transfer_addr_info - vdmac address information of MAIN unit
+ * @img_g_y_paddr: output address of image data(G/Y/packed) which VIIF HW holds(physical address)
+ * @img_b_u_paddr: output address of image data(B/U) which VIIF HW holds(physical address)
+ * @img_r_v_paddr: output address of image data(R/V) which VIIF HW holds(physical address)
+ * @emb_paddr: output address of embedded data which VIIF HW holds(physical address)
+ * @long_packet_paddr: output address of long packet data which VIIF HW holds(physical address)
+ *
+ * 0 needs to be returned in the below parameters.
+ * * img_g_y_paddr
+ * * img_b_u_paddr
+ * * img_r_v_paddr
+ */
+struct hwd_viif_main_transfer_addr_info {
+	uint32_t img_g_y_paddr;
+	uint32_t img_b_u_paddr;
+	uint32_t img_r_v_paddr;
+	uint32_t emb_paddr;
+	uint32_t long_packet_paddr;
+};
+
+/**
+ * struct hwd_viif_isp_regbuf_status - HWD ISP register buffer status
+ * @last_trans:  last transfer type(0:init state, 1:write, 2:read
+ * @isp_abort:  true: abort occurred, false: abort not occurred
+ * @read_end: true: read completed, false: read not completed
+ * @write_end:  true: write completed, false: write not completed
+ * @read_err: true: read error occurred, false: read error not occurred
+ * @write_err: true: write error occurred, false: write error not occurred
+ */
+struct hwd_viif_isp_regbuf_status {
+	uint32_t last_trans;
+	bool isp_abort;
+	bool read_end;
+	bool write_end;
+	bool read_err;
+	bool write_err;
+};
+
+/**
+ * struct hwd_viif_l1_raw_input_order - HWD L1ISP RAW input mode parameters
+ * @input_order_high; high sensitivity image position [0..input_num] For input_num, refer to #drv_VIIF_open
+ * @input_order_middle; middle sensitivity image or LED image position [0..input_num] For input_num, refer to #drv_VIIF_open
+ * @input_order_low; low sensitivity image position [0..input_num] For input_num, refer to #drv_VIIF_open
+ *
+ * When input_num is set, the corresponding image is not input.
+ */
+struct hwd_viif_l1_raw_input_order {
+	uint32_t input_order_high;
+	uint32_t input_order_middle;
+	uint32_t input_order_low;
+};
+
+/**
+ * struct hwd_viif_l1_ag_mode - HWD L1ISP AG mode parameters
+ * @sysm_ag_grad[4]: analog gain slope [0..255] (element is id)
+ * @sysm_ag_ofst[4]: analog gain offset [0..65535] (element is id)
+ * @sysm_ag_cont_hobc_en_high: enable/disable to control analog gain for high sensitivity image of OBCC @ref hwd_VIIF_enable_flag
+ * @sysm_ag_psel_hobc_high: analog gain id for high sensitivity image of OBCC [0..3]
+ * @sysm_ag_cont_hobc_en_middle_led: enable/disable to control analog gain for middle sensitivity or led image of OBCC @ref hwd_VIIF_enable_flag
+ * @sysm_ag_psel_hobc_middle_led: analog gain id for middle sensitivity or led image of OBCC [0..3]
+ * @sysm_ag_cont_hobc_en_low: enable/disable to control analog gain for low sensitivity image of OBCC @ref hwd_VIIF_enable_flag
+ * @sysm_ag_psel_hobc_low: analog gain id for low sensitivity image of OBCC [0..3]
+ * @sysm_ag_cont_abpc_en_high: enable/disable to control analog gain for high sensitivity image of ABPC @ref hwd_VIIF_enable_flag
+ * @sysm_ag_psel_abpc_high: analog gain id for high sensitivity image of ABPC [0..3]
+ * @sysm_ag_cont_abpc_en_middle_led: enable/disable to control analog gain for middle sensitivity or led image of ABPC @ref hwd_VIIF_enable_flag
+ * @sysm_ag_psel_abpc_middle_led: analog gain id for middle sensitivity or led image of ABPC [0..3]
+ * @sysm_ag_cont_abpc_en_low: enable/disable to control analog gain for low sensitivity image of ABPC @ref hwd_VIIF_enable_flag
+ * @sysm_ag_psel_abpc_low: analog gain id for low sensitivity image of ABPC [0..3]
+ * @sysm_ag_cont_rcnr_en_high: enable/disable to control analog gain for high sensitivity image of RCNR @ref hwd_VIIF_enable_flag
+ * @sysm_ag_psel_rcnr_high: analog gain id for high sensitivity image of RCNR [0..3]
+ * @sysm_ag_cont_rcnr_en_middle_led: enable/disable to control analog gain for middle sensitivity or led image of RCNR @ref hwd_VIIF_enable_flag
+ * @sysm_ag_psel_rcnr_middle_led: analog gain id for middle sensitivity or led image of RCNR [0..3]
+ * @sysm_ag_cont_rcnr_en_low: enable/disable to control analog gain for low sensitivity image of RCNR @ref hwd_VIIF_enable_flag
+ * @sysm_ag_psel_rcnr_low: analog gain id for low sensitivity image of RCNR [0..3]
+ * @sysm_ag_cont_lssc_en: enable/disable to control analog gain for LSSC @ref hwd_VIIF_enable_flag
+ * @sysm_ag_ssel_lssc: sensitive image used for LSSC @ref hwd_VIIF_l1_img_sens
+ * @sysm_ag_psel_lssc: analog gain id for LSSC [0..3]
+ * @sysm_ag_cont_mpro_en: enable/disable to control analog gain for color matrix @ref hwd_VIIF_enable_flag
+ * @sysm_ag_ssel_mpro: sensitive image used for color matrix @ref hwd_VIIF_l1_img_sens
+ * @sysm_ag_psel_mpro: analog gain id for color matrix [0..3]
+ * @sysm_ag_cont_vpro_en: enable/disable to control analog gain for image adjustment @ref hwd_VIIF_enable_flag
+ * @sysm_ag_ssel_vpro: sensitive image used for image adjustment @ref hwd_VIIF_l1_img_sens
+ * @sysm_ag_psel_vpro: analog gain id for image adjustment [0..3]
+ * @sysm_ag_cont_hobc_test_high: manual analog gain for high sensitivity image of OBCC [0..255]
+ * @sysm_ag_cont_hobc_test_middle_led: manual analog gain for middle sensitivity or led image of OBCC [0..255]
+ * @sysm_ag_cont_hobc_test_low: manual analog gain for low sensitivity image of OBCC [0..255]
+ * @sysm_ag_cont_abpc_test_high: manual analog gain for high sensitivity image of ABPC [0..255]
+ * @sysm_ag_cont_abpc_test_middle_led: manual analog gain for middle sensitivity or led image of ABPC [0..255]
+ * @sysm_ag_cont_abpc_test_low: manual analog gain for low sensitivity image of ABPC [0..255]
+ * @sysm_ag_cont_rcnr_test_high: manual analog gain for high sensitivity image of RCNR [0..255]
+ * @sysm_ag_cont_rcnr_test_middle_led: manual analog gain for middle sensitivity or led image of RCNR [0..255]
+ * @sysm_ag_cont_rcnr_test_low: manual analog gain for low sensitivity image of RCNR [0..255]
+ * @sysm_ag_cont_lssc_test: manual analog gain for LSSC [0..255]
+ * @sysm_ag_cont_mpro_test: manual analog gain for color matrix [0..255]
+ * @sysm_ag_cont_vpro_test: manual analog gain for image adjustment [0..255]
+ */
+struct hwd_viif_l1_ag_mode {
+	uint8_t sysm_ag_grad[4];
+	uint16_t sysm_ag_ofst[4];
+	uint32_t sysm_ag_cont_hobc_en_high;
+	uint32_t sysm_ag_psel_hobc_high;
+	uint32_t sysm_ag_cont_hobc_en_middle_led;
+	uint32_t sysm_ag_psel_hobc_middle_led;
+	uint32_t sysm_ag_cont_hobc_en_low;
+	uint32_t sysm_ag_psel_hobc_low;
+	uint32_t sysm_ag_cont_abpc_en_high;
+	uint32_t sysm_ag_psel_abpc_high;
+	uint32_t sysm_ag_cont_abpc_en_middle_led;
+	uint32_t sysm_ag_psel_abpc_middle_led;
+	uint32_t sysm_ag_cont_abpc_en_low;
+	uint32_t sysm_ag_psel_abpc_low;
+	uint32_t sysm_ag_cont_rcnr_en_high;
+	uint32_t sysm_ag_psel_rcnr_high;
+	uint32_t sysm_ag_cont_rcnr_en_middle_led;
+	uint32_t sysm_ag_psel_rcnr_middle_led;
+	uint32_t sysm_ag_cont_rcnr_en_low;
+	uint32_t sysm_ag_psel_rcnr_low;
+	uint32_t sysm_ag_cont_lssc_en;
+	uint32_t sysm_ag_ssel_lssc;
+	uint32_t sysm_ag_psel_lssc;
+	uint32_t sysm_ag_cont_mpro_en;
+	uint32_t sysm_ag_ssel_mpro;
+	uint32_t sysm_ag_psel_mpro;
+	uint32_t sysm_ag_cont_vpro_en;
+	uint32_t sysm_ag_ssel_vpro;
+	uint32_t sysm_ag_psel_vpro;
+	uint8_t sysm_ag_cont_hobc_test_high;
+	uint8_t sysm_ag_cont_hobc_test_middle_led;
+	uint8_t sysm_ag_cont_hobc_test_low;
+	uint8_t sysm_ag_cont_abpc_test_high;
+	uint8_t sysm_ag_cont_abpc_test_middle_led;
+	uint8_t sysm_ag_cont_abpc_test_low;
+	uint8_t sysm_ag_cont_rcnr_test_high;
+	uint8_t sysm_ag_cont_rcnr_test_middle_led;
+	uint8_t sysm_ag_cont_rcnr_test_low;
+	uint8_t sysm_ag_cont_lssc_test;
+	uint8_t sysm_ag_cont_mpro_test;
+	uint8_t sysm_ag_cont_vpro_test;
+};
+
+/**
+ * struct hwd_viif_l1_hdre - HWD L1ISP HDR extension parameters
+ * @hdre_src_point: the number of knee points, N of PWL compression signal [0x0..0x3fff]
+ * @hdre_dst_base: the offset value of HDR signal of the knee area, M [0x0..0xffffff]
+ * @hdre_ratio: output pixel ratio at the area M [0x0..0x3FFFFF] accuracy: 1/64
+ * @hdre_dst_max_val: the maximum value of output pixel [0x0..0xffffff]
+ */
+struct hwd_viif_l1_hdre {
+	uint32_t hdre_src_point[16];
+	uint32_t hdre_dst_base[17];
+	uint32_t hdre_ratio[17];
+	uint32_t hdre_dst_max_val;
+};
+
+/**
+ * struct hwd_viif_l1_dpc - HWD L1ISP defect pixel correction parameters
+ *
+ * @abpc_sta_en: enable/disable static defect pixel correction @ref hwd_VIIF_enable_flag
+ * @abpc_dyn_en: enable/disable dynamic defect pixel correction @ref hwd_VIIF_enable_flag
+ * @abpc_dyn_mode: enable/disable dynamic defect pixel correction @ref hwd_VIIF_l1_dpc
+ * @abpc_ratio_limit: ratio limit for defect pixel correction [0..1023]
+ * @abpc_dark_limit: ratio limit for white defect pixel correction in dark area [0..1023]
+ * @abpc_sn_coef_w_ag_min: luminance difference adjustment value for white defect pixel correction(under lower threshold) [1..31]
+ * @abpc_sn_coef_w_ag_mid: luminance difference adjustment value for white defect pixel correction(between lower and upper threshold) [1..31]
+ * @abpc_sn_coef_w_ag_max: luminance difference adjustment value for white defect pixel correction(over upper threshold) [1..31]
+ * @abpc_sn_coef_b_ag_min: luminance difference adjustment value for black defect pixel correction(under lower threshold) [1..31]
+ * @abpc_sn_coef_b_ag_mid: luminance difference adjustment value for black defect pixel correction(between lower and upper threshold) [1..31]
+ * @abpc_sn_coef_b_ag_max: luminance difference adjustment value for black defect pixel correction(over upper threshold) [1..31]
+ * @abpc_sn_coef_w_th_min: analog gain lower threshold for luminance difference adjustment for white defect pixel correction [0..255]
+ * @abpc_sn_coef_w_th_max: analog gain upper threshold for luminance difference adjustment for white defect pixel correction [0..255]
+ * @abpc_sn_coef_b_th_min: analog gain lower threshold for luminance difference adjustment for black defect pixel correction [0..255]
+ * @abpc_sn_coef_b_th_max: analog gain upper threshold for luminance difference adjustment for black defect pixel correction [0..255]
+ *
+ * it is necessary to keep the following relation for each parameters
+ * - *_th_min < *_th_max
+ */
+struct hwd_viif_l1_dpc {
+	uint32_t abpc_sta_en;
+	uint32_t abpc_dyn_en;
+	uint32_t abpc_dyn_mode;
+	uint32_t abpc_ratio_limit;
+	uint32_t abpc_dark_limit;
+	uint32_t abpc_sn_coef_w_ag_min;
+	uint32_t abpc_sn_coef_w_ag_mid;
+	uint32_t abpc_sn_coef_w_ag_max;
+	uint32_t abpc_sn_coef_b_ag_min;
+	uint32_t abpc_sn_coef_b_ag_mid;
+	uint32_t abpc_sn_coef_b_ag_max;
+	uint8_t abpc_sn_coef_w_th_min;
+	uint8_t abpc_sn_coef_w_th_max;
+	uint8_t abpc_sn_coef_b_th_min;
+	uint8_t abpc_sn_coef_b_th_max;
+};
+
+/**
+ * struct hwd_viif_l1_preset_white_balance - HWD L1ISP preset white balance parameters
+ * @gain_gr;  Gr gain value [0..0x7FFFF]
+ * @gain_r; R gain value [0..0x7FFFF]
+ * @gain_b; B gain value [0..0x7FFFF]
+ * @gain_gb;  Gb gain value [0..0x7FFFF]
+ * 
+ * accuracy of each parameter is 1/16384
+ */
+struct hwd_viif_l1_preset_white_balance {
+	uint32_t gain_gr;
+	uint32_t gain_r;
+	uint32_t gain_b;
+	uint32_t gain_gb;
+};
+
+/**
+ * struct hwd_viif_l1_raw_color_noise_reduction - HWD L1ISP raw color noise reduction parameters
+ * @rcnr_sw: enable/disable raw color noise reduction @ref hwd_VIIF_enable_flag
+ * @rcnr_cnf_dark_ag0: maximum value for LSF noise reduction in dark [0..63]
+ * @rcnr_cnf_dark_ag1: middle value for LSF noise reduction in dark [0..63]
+ * @rcnr_cnf_dark_ag2: minimum value for LSF noise reduction in dark [0..63]
+ * @rcnr_cnf_ratio_ag0: maximum value for LSF luminance linkage noise reduction [0..31]
+ * @rcnr_cnf_ratio_ag1: middle value for LSF luminance linkage noise reduction [0..31]
+ * @rcnr_cnf_ratio_ag2: minimum value for LSF luminance linkage noise reduction [0..31]
+ * @rcnr_cnf_clip_gain_r: R gain value to adjust correction width of LSF [0..3]
+ * @rcnr_cnf_clip_gain_g: G gain value to adjust correction width of LSF [0..3]
+ * @rcnr_cnf_clip_gain_b: B gain value to adjust correction width of LSF [0..3]
+ * @rcnr_a1l_dark_ag0: maximum value for MSF noise reduction in dark [0..63]
+ * @rcnr_a1l_dark_ag1: middle value for MSF noise reduction in dark [0..63]
+ * @rcnr_a1l_dark_ag2: minimum value for MSF noise reduction in dark [0..63]
+ * @rcnr_a1l_ratio_ag0: maximum value for MSF luminance linkage noise reduction [0..31]
+ * @rcnr_a1l_ratio_ag1: middle value for MSF luminance linkage noise reduction [0..31]
+ * @rcnr_a1l_ratio_ag2: minimum value for MSF luminance linkage noise reduction [0..31]
+ * @rcnr_inf_zero_clip: clip value [0..256]
+ * @rcnr_merge_d2blend_ag0: maximum blend ratio for input data and filtered input data [0..16]
+ * @rcnr_merge_d2blend_ag1: middle blend ratio for input data and filtered input data [0..16]
+ * @rcnr_merge_d2blend_ag2: minimum blend ratio for input data and filtered input data [0..16]
+ * @rcnr_merge_black: minimum black level value [0..64]
+ * @rcnr_merge_mindiv: 0div guard value for inverse operator [4..16]
+ * @rcnr_hry_type: HSF filter type @ref hwd_VIIF_l1_rcnr_hry_type
+ * @rcnr_anf_blend_ag0: maximum blend ratio for MSF result for write back data to line memory @ref hwd_VIIF_l1_rcnr_msf_blend_ratio
+ * @rcnr_anf_blend_ag1: middle blend ratio for MSF result for write back data to line memory @ref hwd_VIIF_l1_rcnr_msf_blend_ratio
+ * @rcnr_anf_blend_ag2: minimum blend ratio for MSF result for write back data to line memory @ref hwd_VIIF_l1_rcnr_msf_blend_ratio
+ * @rcnr_lpf_threshold: multiplication value at calculating MSF noise [0x0..0x1F] accuracy: 1/8
+ * @rcnr_merge_hlblend_ag0: maximum value of generating luminance signal blend [0..2]
+ * @rcnr_merge_hlblend_ag1: middle value of generating luminance signal blend [0..2]
+ * @rcnr_merge_hlblend_ag2: minimum value of generating luminance signal blend [0..2]
+ * @rcnr_gnr_sw: enable/disable Gr/Gb sensitivity ratio correction
+ * @rcnr_gnr_ratio: upper limit ratio of Gr/Gb sensitivity ratio
+ * @rcnr_gnr_wide_en: enable/disable that upper limit ratio of Gr/Gb is double @ref hwd_VIIF_enable_flag
+ */
+struct hwd_viif_l1_raw_color_noise_reduction {
+	uint32_t rcnr_sw;
+	uint32_t rcnr_cnf_dark_ag0;
+	uint32_t rcnr_cnf_dark_ag1;
+	uint32_t rcnr_cnf_dark_ag2;
+	uint32_t rcnr_cnf_ratio_ag0;
+	uint32_t rcnr_cnf_ratio_ag1;
+	uint32_t rcnr_cnf_ratio_ag2;
+	uint32_t rcnr_cnf_clip_gain_r;
+	uint32_t rcnr_cnf_clip_gain_g;
+	uint32_t rcnr_cnf_clip_gain_b;
+	uint32_t rcnr_a1l_dark_ag0;
+	uint32_t rcnr_a1l_dark_ag1;
+	uint32_t rcnr_a1l_dark_ag2;
+	uint32_t rcnr_a1l_ratio_ag0;
+	uint32_t rcnr_a1l_ratio_ag1;
+	uint32_t rcnr_a1l_ratio_ag2;
+	uint32_t rcnr_inf_zero_clip;
+	uint32_t rcnr_merge_d2blend_ag0;
+	uint32_t rcnr_merge_d2blend_ag1;
+	uint32_t rcnr_merge_d2blend_ag2;
+	uint32_t rcnr_merge_black;
+	uint32_t rcnr_merge_mindiv;
+	uint32_t rcnr_hry_type;
+	uint32_t rcnr_anf_blend_ag0;
+	uint32_t rcnr_anf_blend_ag1;
+	uint32_t rcnr_anf_blend_ag2;
+	uint32_t rcnr_lpf_threshold;
+	uint32_t rcnr_merge_hlblend_ag0;
+	uint32_t rcnr_merge_hlblend_ag1;
+	uint32_t rcnr_merge_hlblend_ag2;
+	uint32_t rcnr_gnr_sw;
+	uint32_t rcnr_gnr_ratio;
+	uint32_t rcnr_gnr_wide_en;
+};
+
+/**
+ * struct hwd_viif_l1_hdrs - HWD L1ISP HDR synthesis parameters
+ * @hdrs_hdr_mode: use or not use middle sensitivity image @ref hwd_VIIF_l1_hdrs
+ * @hdrs_hdr_ratio_m: ratio of mid sensitivity image to high sensitivity image [0x400..0x400000] accuracy: 1/1024
+ * @hdrs_hdr_ratio_l: ratio of low sensitivity image to high sensitivity image [0x400..0x400000] accuracy: 1/1024
+ * @hdrs_hdr_ratio_e: ratio of led image to high sensitivity image [0x400..0x400000] accuracy: 1/1024
+ * @hdrs_dg_h: digital gain of high sensitivity image [0x0..0x3FFFFF] accuracy: 1/1024
+ * @hdrs_dg_m: digital gain of middle sensitivity image [0x0..0x3FFFFF] accuracy: 1/1024
+ * @hdrs_dg_l: digital gain of low sensitivity image [0x0..0x3FFFFF] accuracy: 1/1024
+ * @hdrs_dg_e: digital gain of led image [0x0..0x3FFFFF] accuracy: 1/1024
+ * @hdrs_blendend_h: maximum luminance used for blend of high sensitivity image [0..4095]
+ * @hdrs_blendend_m: maximum luminance used for blend of middle sensitivity image [0..4095]
+ * @hdrs_blendend_e: maximum luminance used for blend of led image [0..4095]
+ * @hdrs_blendbeg_h: minimum luminance used for blend of high sensitivity image [0..4095]
+ * @hdrs_blendbeg_m: minimum luminance used for blend of middle sensitivity image [0..4095]
+ * @hdrs_blendbeg_e: minimum luminance used for blend of led image [0..4095]
+ * @hdrs_led_mode_on: enable/disable LED mode @ref hwd_VIIF_enable_flag
+ * @hdrs_dst_max_val: the maximum value of output pixel [0x0..0xffffff]
+ *
+ * -EINVAL needs to be returned in the below condition.
+ * - (hdrs_hdr_mode == DRV_VIIF_ENABLE) && (hdrs_led_mode_on == DRV_VIIF_ENABLE)
+ */
+struct hwd_viif_l1_hdrs {
+	uint32_t hdrs_hdr_mode;
+	uint32_t hdrs_hdr_ratio_m;
+	uint32_t hdrs_hdr_ratio_l;
+	uint32_t hdrs_hdr_ratio_e;
+	uint32_t hdrs_dg_h;
+	uint32_t hdrs_dg_m;
+	uint32_t hdrs_dg_l;
+	uint32_t hdrs_dg_e;
+	uint32_t hdrs_blendend_h;
+	uint32_t hdrs_blendend_m;
+	uint32_t hdrs_blendend_e;
+	uint32_t hdrs_blendbeg_h;
+	uint32_t hdrs_blendbeg_m;
+	uint32_t hdrs_blendbeg_e;
+	uint32_t hdrs_led_mode_on;
+	uint32_t hdrs_dst_max_val;
+};
+
+/**
+ * struct hwd_viif_l1_black_level_correction - HWD L1ISP black level correction parameters
+ * @srcblacklevel_gr: black level of Gr input [0x0..0xffffff] [pixel]
+ * @srcblacklevel_r: black level of R input [0x0..0xffffff] [pixel]
+ * @srcblacklevel_b: black level of B input [0x0..0xffffff] [pixel]
+ * @srcblacklevel_gb: black level of Gb input [0x0..0xffffff] [pixel]
+ * @mulval_gr: Gr gain [0x0..0xfffff] accuracy: 1/256
+ * @mulval_r: R gain [0x0..0xfffff] accuracy: 1/256
+ * @mulval_b: B gain [0x0..0xfffff] accuracy: 1/256
+ * @mulval_gb: Gb gain [0x0..0xfffff] accuracy: 1/256
+ * @dstmaxval: the maximum value of output pixel [0x0..0xffffff]
+ */
+struct hwd_viif_l1_black_level_correction {
+	uint32_t srcblacklevel_gr;
+	uint32_t srcblacklevel_r;
+	uint32_t srcblacklevel_b;
+	uint32_t srcblacklevel_gb;
+	uint32_t mulval_gr;
+	uint32_t mulval_r;
+	uint32_t mulval_b;
+	uint32_t mulval_gb;
+	uint32_t dstmaxval;
+};
+
+/**
+ * struct hwd_viif_l1_lsc_parabola_ag_param - HWD L1ISP parabola shading analog gain parameters
+ * @lssc_paracoef_h_l_max: maximum gain for the left side of parabola coefficient
+ * @lssc_paracoef_h_l_min: minimum gain for the left side of parabola coefficient
+ * @lssc_paracoef_h_r_max: maximum gain for the right side of parabola coefficient
+ * @lssc_paracoef_h_r_min: minimum gain for the right side of parabola coefficient
+ * @lssc_paracoef_v_u_max: maximum gain for the upper side of parabola coefficient
+ * @lssc_paracoef_v_u_min: minimum gain for the upper side of parabola coefficient
+ * @lssc_paracoef_v_d_max: maximum gain for the lower side of parabola coefficient
+ * @lssc_paracoef_v_d_min: minimum gain for the lower side of parabola coefficient
+ * @lssc_paracoef_hv_lu_max: maximum gain for the upper left side of parabola coefficient
+ * @lssc_paracoef_hv_lu_min: minimum gain for the upper left side of parabola coefficient
+ * @lssc_paracoef_hv_ru_max: maximum gain for the upper right side of parabola coefficient
+ * @lssc_paracoef_hv_ru_min: minimum gain for the upper right side of parabola coefficient
+ * @lssc_paracoef_hv_ld_max: maximum gain for the lower left side of parabola coefficient
+ * @lssc_paracoef_hv_ld_min: minimum gain for the lower left side of parabola coefficient
+ * @lssc_paracoef_hv_rd_max: maximum gain for the lower right side of parabola coefficient
+ * @lssc_paracoef_hv_rd_min: minimum gain for the lower right side of parabola coefficient
+ *
+ * range and accuracy of each parameter is as below.
+ * * range: -4096 <= lssc_paracoef_* < 4096
+ * * accuracy: 1/256
+ */
+struct hwd_viif_l1_lsc_parabola_ag_param {
+	int16_t lssc_paracoef_h_l_max;
+	int16_t lssc_paracoef_h_l_min;
+	int16_t lssc_paracoef_h_r_max;
+	int16_t lssc_paracoef_h_r_min;
+	int16_t lssc_paracoef_v_u_max;
+	int16_t lssc_paracoef_v_u_min;
+	int16_t lssc_paracoef_v_d_max;
+	int16_t lssc_paracoef_v_d_min;
+	int16_t lssc_paracoef_hv_lu_max;
+	int16_t lssc_paracoef_hv_lu_min;
+	int16_t lssc_paracoef_hv_ru_max;
+	int16_t lssc_paracoef_hv_ru_min;
+	int16_t lssc_paracoef_hv_ld_max;
+	int16_t lssc_paracoef_hv_ld_min;
+	int16_t lssc_paracoef_hv_rd_max;
+	int16_t lssc_paracoef_hv_rd_min;
+};
+
+/**
+ * struct hwd_viif_l1_lsc_parabola_param - HWD L1ISP parabola shading parameters
+ * @lssc_para_h_center: horizontal position of optical axis center (0 <= lssc_para_h_center < "width of input image") [pixel]
+ * @lssc_para_v_center: vertical position of optical axis center (0 <= lssc_para_v_center < "height of input image") [line]
+ * @lssc_para_h_gain: gain for horizontal distance from optical axis (0 <= lssc_para_h_gain < 4096) accuracy: 1/256
+ * @lssc_para_v_gain: gain for vertical distance from optical axis (0 <= lssc_para_h_gain < 4096) accuracy: 1/256
+ * @lssc_para_mgsel2: gain ratio of coefficient of the 2nd degree parabola correction @ref hwd_VIIF_l1_lsc_grid_mag
+ * @lssc_para_mgsel4: gain ratio of coefficient of the 4th degree parabola correction @ref hwd_VIIF_l1_lsc_grid_mag
+ * @*r_2d: coefficient of the 2nd degree parabola correction for R
+ * @*r_4d: coefficient of the 4th degree parabola correction for R
+ * @*gr_2d: coefficient of the 2nd degree parabola correction for Gr
+ * @*gr_4d: coefficient of the 4th degree parabola correction for Gr
+ * @*gb_2d: coefficient of the 2nd degree parabola correction for Gb
+ * @*gb_4d: coefficient of the 4th degree parabola correction for Gb
+ * @*b_2d: coefficient of the 2nd degree parabola correction for B
+ * @*b_4d: coefficient of the 4th degree parabola correction for B
+ *
+ * EINVAL needs to be returned in below condition.
+ * * NULL is set to {r/gr/gb/b}_{2/4}d
+ */
+struct hwd_viif_l1_lsc_parabola_param {
+	uint32_t lssc_para_h_center;
+	uint32_t lssc_para_v_center;
+	uint32_t lssc_para_h_gain;
+	uint32_t lssc_para_v_gain;
+	uint32_t lssc_para_mgsel2;
+	uint32_t lssc_para_mgsel4;
+	struct hwd_viif_l1_lsc_parabola_ag_param *r_2d;
+	struct hwd_viif_l1_lsc_parabola_ag_param *r_4d;
+	struct hwd_viif_l1_lsc_parabola_ag_param *gr_2d;
+	struct hwd_viif_l1_lsc_parabola_ag_param *gr_4d;
+	struct hwd_viif_l1_lsc_parabola_ag_param *gb_2d;
+	struct hwd_viif_l1_lsc_parabola_ag_param *gb_4d;
+	struct hwd_viif_l1_lsc_parabola_ag_param *b_2d;
+	struct hwd_viif_l1_lsc_parabola_ag_param *b_4d;
+};
+
+/**
+ * @brief HWD L1ISP grid shading parameters
+ * @lssc_grid_h_size: horizontal grid size (32, 64, 128, 256 or 512) [pixel]
+ * @lssc_grid_v_size: vertical grid size (32, 64, 128, 256 or 512) [pixel]
+ * @lssc_grid_h_center: horizontal position of grid(1,1) [1..lssc_grid_h_size] [pixel]
+ * * "width of input image" <= lssc_grid_h_center + lssc_grid_h_size * 31 [pixel]
+ * @lssc_grid_v_center: vertical position of grid(1,1) [1..lssc_grid_v_size] [line]
+ * * "height of input image" <= lssc_grid_v_center + lssc_grid_v_size * 23 [line]
+ * @lssc_grid_mgsel: gain ratio of coefficient of grid correction @ref hwd_VIIF_l1_lsc_grid_mag
+ */
+struct hwd_viif_l1_lsc_grid_param {
+	uint32_t lssc_grid_h_size;
+	uint32_t lssc_grid_v_size;
+	uint32_t lssc_grid_h_center;
+	uint32_t lssc_grid_v_center;
+	uint32_t lssc_grid_mgsel;
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
+	struct hwd_viif_l1_lsc_parabola_param *lssc_parabola_param;
+	struct hwd_viif_l1_lsc_grid_param *lssc_grid_param;
+	uint32_t lssc_pwhb_r_gain_max;
+	uint32_t lssc_pwhb_r_gain_min;
+	uint32_t lssc_pwhb_gr_gain_max;
+	uint32_t lssc_pwhb_gr_gain_min;
+	uint32_t lssc_pwhb_gb_gain_max;
+	uint32_t lssc_pwhb_gb_gain_min;
+	uint32_t lssc_pwhb_b_gain_max;
+	uint32_t lssc_pwhb_b_gain_min;
+};
+
+/**
+ * struct hwd_viif_l1_color_matrix_correction - HWD L1ISP color matrix correction parameters
+ * @coef_rmg_min: minimum gain of (R-G) [-32768..32767] accuracy: 1/4096
+ * @coef_rmg_max: maximum gain of (R-G) [-32768..32767] accuracy: 1/4096
+ * @coef_rmb_min: minimum gain of (R-B) [-32768..32767] accuracy: 1/4096
+ * @coef_rmb_max: maximum gain of (R-B) [-32768..32767] accuracy: 1/4096
+ * @coef_gmr_min: minimum gain of (G-R) [-32768..32767] accuracy: 1/4096
+ * @coef_gmr_max: maximum gain of (G-R) [-32768..32767] accuracy: 1/4096
+ * @coef_gmb_min: minimum gain of (G-B) [-32768..32767] accuracy: 1/4096
+ * @coef_gmb_max: maximum gain of (G-B) [-32768..32767] accuracy: 1/4096
+ * @coef_bmr_min: minimum gain of (B-R) [-32768..32767] accuracy: 1/4096
+ * @coef_bmr_max: maximum gain of (B-R) [-32768..32767] accuracy: 1/4096
+ * @coef_bmg_min: minimum gain of (B-G) [-32768..32767] accuracy: 1/4096
+ * @coef_bmg_max: maximum gain of (B-G) [-32768..32767] accuracy: 1/4096
+ * @dst_minval: the minimum output pixel [0x0..0xffff] [pixel]
+ */
+struct hwd_viif_l1_color_matrix_correction {
+	int16_t coef_rmg_min;
+	int16_t coef_rmg_max;
+	int16_t coef_rmb_min;
+	int16_t coef_rmb_max;
+	int16_t coef_gmr_min;
+	int16_t coef_gmr_max;
+	int16_t coef_gmb_min;
+	int16_t coef_gmb_max;
+	int16_t coef_bmr_min;
+	int16_t coef_bmr_max;
+	int16_t coef_bmg_min;
+	int16_t coef_bmg_max;
+	uint16_t dst_minval;
+};
+
+/**
+ * struct hwd_viif_l1_awb - HWD L1ISP auto white balance parameters
+ * @awhb_ygate_sel: enable/disable to use fixed Y value at RGB to YUV conversion @ref hwd_VIIF_enable_flag
+ * @awhb_ygate_data: Y value in case of awhb_ygate_sel = HWD_VIIF_ENABLE [64, 128, 256 or 512]
+ * @awhb_cgrange: magnification of output signal before auto white balance adjustment @ref hwd_VIIF_l1_awb_mag
+ * @awhb_ygatesw: enable/disable Y-gate @ref hwd_VIIF_enable_flag
+ * @awhb_hexsw: enable/disable Hexa-gate @ref hwd_VIIF_enable_flag
+ * @awhb_areamode: area mode for auto white balance @ref hwd_VIIF_l1_awb_area_mode
+ * @awhb_area_hsize: horizontal size of one block of central area [1..(width of input image - 8)/8] [pixel]
+ * @awhb_area_vsize: vertical size of one block of central area [1..(height of input image - 4)/8] [line]
+ * @awhb_area_hofs: horizontal offset of block[0] of central area [0..(width of input image - 9)] [pixel]
+ * @awhb_area_vofs: vertical offset of block[0] of central area [0..(height of input image - 5)] [line]
+ * @awhb_area_maskh: selection of target block(upper side). Corresponding bit means including(1) or not including(0).
+ * * The relation between each bit and block is as below.
+ * * [31 :0] = {
+ * * (7, 3),(6, 3),(5, 3),(4, 3),(3, 3),(2, 3),(1, 3),(0, 3),
+ * * (7, 2),(6, 2),(5, 2),(4, 2),(3, 2),(2, 2),(1, 2),(0, 2),
+ * * (7, 1),(6, 1),(5, 1),(4, 1),(3, 1),(2, 1),(1, 1),(0, 1),
+ * * (7, 0),(6, 0),(5, 0),(4, 0),(3, 0),(2, 0),(1, 0),(0, 0)}
+ * @awhb_area_maskl: selection of target block(lower side). Corresponding bit means including(1) or not including(0).
+ * * The relation between each bit and block is as below.
+ * * [31:0] = {
+ * * (7, 7),(6, 7),(5, 7),(4, 7),(3, 7),(2, 7),(1, 7),(0, 7),
+ * * (7, 6),(6, 6),(5, 6),(4, 6),(3, 6),(2, 6),(1, 6),(0, 6),
+ * * (7, 5),(6, 5),(5, 5),(4, 5),(3, 5),(2, 5),(1, 5),(0, 5),
+ * * (7, 4),(6, 4),(5, 4),(4, 4),(3, 4),(2, 4),(1, 4),(0, 4)}
+ * @awhb_sq_sw[3]: enable/disable each square gate @ref hwd_VIIF_enable_flag
+ * @awhb_sq_pol[3]: enable/disable to add accumulated gate for each square gate @ref hwd_VIIF_enable_flag
+ * @awhb_bycut0p: upper U value of hexa-gate [0..127] [pixel]
+ * @awhb_bycut0n: lower U value of hexa-gate [0..127] [pixel]
+ * @awhb_rycut0p: upper V value of hexa-gate [0..127] [pixel]
+ * @awhb_rycut0n: lower V value of hexa-gate [0..127] [pixel]
+ * @awhb_rbcut0h: upper intercept on V axis of hexa-gate [-127..127] [pixel]
+ * @awhb_rbcut0l: lower intercept on V axis of hexa-gate [-127..127] [pixel]
+ * @awhb_bycut_h[3]: center value of each square gate in the U direction [-127..127]
+ * @awhb_bycut_l[3]: width of each square gate in the U direction [0..127]
+ * @awhb_rycut_h[3]: center value of each square gate in the V direction [-127..127]
+ * @awhb_rycut_l[3]: width of each square gate in the V direction [0..127]
+ * @awhb_awbsftu: offset of U gain [-127..127]
+ * @awhb_awbsftv: offset of V gain [-127..127]
+ * @awhb_awbhuecor: enable/disable to hold color correlation @ref hwd_VIIF_enable_flag
+ * @awhb_awbspd: UV convergence speed [0..15] [times] (0 means "stop")
+ * @awhb_awbulv: convergence level of U [0..31]
+ * @awhb_awbvlv: convergence level of V [0..31]
+ * @awhb_awbondot: threshold to stop accumulation [0..1023] [pixel]
+ * @awhb_awbfztim: condition to restart auto white balance @ref hwd_VIIF_l1_awb_restart_cond
+ * @awhb_wbgrmax: adjustment range of R gain(upper side) [0..255] accuracy: 1/64
+ * @awhb_wbgbmax: adjustment range of B gain(upper side) [0..255] accuracy: 1/64
+ * @awhb_wbgrmin: adjustment range of R gain(lower side) [0..255] accuracy: 1/64
+ * @awhb_wbgbmin: adjustment range of B gain(lower side) [0..255] accuracy: 1/64
+ * @awhb_ygateh: the maximum value of Y-gate [0..255] [pixel]
+ * @awhb_ygatel: the minimum value of Y-gate [0..255] [pixel]
+ * @awhb_awbwait: the number of frame to restart auto white balance after completion of UV convergence [0..255]
+ */
+struct hwd_viif_l1_awb {
+	uint32_t awhb_ygate_sel;
+	uint32_t awhb_ygate_data;
+	uint32_t awhb_cgrange;
+	uint32_t awhb_ygatesw;
+	uint32_t awhb_hexsw;
+	uint32_t awhb_areamode;
+	uint32_t awhb_area_hsize;
+	uint32_t awhb_area_vsize;
+	uint32_t awhb_area_hofs;
+	uint32_t awhb_area_vofs;
+	uint32_t awhb_area_maskh;
+	uint32_t awhb_area_maskl;
+	uint32_t awhb_sq_sw[3];
+	uint32_t awhb_sq_pol[3];
+	uint32_t awhb_bycut0p;
+	uint32_t awhb_bycut0n;
+	uint32_t awhb_rycut0p;
+	uint32_t awhb_rycut0n;
+	int32_t awhb_rbcut0h;
+	int32_t awhb_rbcut0l;
+	int32_t awhb_bycut_h[3];
+	uint32_t awhb_bycut_l[3];
+	int32_t awhb_rycut_h[3];
+	uint32_t awhb_rycut_l[3];
+	int32_t awhb_awbsftu;
+	int32_t awhb_awbsftv;
+	uint32_t awhb_awbhuecor;
+	uint32_t awhb_awbspd;
+	uint32_t awhb_awbulv;
+	uint32_t awhb_awbvlv;
+	uint32_t awhb_awbondot;
+	uint32_t awhb_awbfztim;
+	uint8_t awhb_wbgrmax;
+	uint8_t awhb_wbgbmax;
+	uint8_t awhb_wbgrmin;
+	uint8_t awhb_wbgbmin;
+	uint8_t awhb_ygateh;
+	uint8_t awhb_ygatel;
+	uint8_t awhb_awbwait;
+};
+
+/**
+ * struct hwd_viif_l1_hdrc - HWD L1ISP HDR compression parameters
+ * @hdrc_ratio: input image data width [10..24]
+ * @hdrc_pt_ratio: slope of Preset Tone curve [0..13]
+ * @hdrc_pt_blend: blend ratio of Preset Tone0 curve [0..256] accuracy: 1/256
+ * @hdrc_pt_blend2: blend ratio of Preset Tone2 curve [0..256] accuracy: 1/256
+ * @hdrc_tn_type: tone curve type @ref hwd_VIIF_l1_hdrc_tone_type
+ * @hdrc_utn_tbl[20]: User Tone curve value after HDRC [0x0..0xffff]
+ * @hdrc_flr_val: constant flare value [0x0..0xffffff]
+ * @hdrc_flr_adp: enable/disable adaptive constant flare @ref hwd_VIIF_enable_flag
+ * @hdrc_ybr_off: enable/disable bilateral luminance filter off @ref hwd_VIIF_enable_flag
+ * * HWD_VIIF_ENABLE: filter off
+ * * HWD_VIIF_DISABLE: filter on
+ * @hdrc_orgy_blend: blend setting for corrected luminance data after HDRC and original luminance data [0..16]
+ * * 0: corrected luminance data 100%
+ * * 8: corrected luminance data 50%
+ * * 16: corrected luminance data 0%
+ * @hdrc_pt_sat: saturation value for Preset Tone [0x0..0xffff]
+ *
+ * -EINVAL needs to be returned in the below condition.
+ * - hdrc_pt_blend + hdrc_pt_blend2 > 256
+ */
+struct hwd_viif_l1_hdrc {
+	uint32_t hdrc_ratio;
+	uint32_t hdrc_pt_ratio;
+	uint32_t hdrc_pt_blend;
+	uint32_t hdrc_pt_blend2;
+	uint32_t hdrc_tn_type;
+	uint16_t hdrc_utn_tbl[20];
+	uint32_t hdrc_flr_val;
+	uint32_t hdrc_flr_adp;
+	uint32_t hdrc_ybr_off;
+	uint32_t hdrc_orgy_blend;
+	uint16_t hdrc_pt_sat;
+};
+
+/**
+ * struct hwd_viif_l1_hdrc_ltm - HWD L1ISP HDR compression local tone mapping parameters
+ * @tnp_max: the maximum tone blend ratio of LTM [0x0..0x3FFFFF] accuracy: 1/64
+ * * 0 means LTM off.
+ * @tnp_mag: strength adjustment of LTM [0x0..0x3FFF] accuracy: 1/64
+ * @tnp_fil[5]: coefficient of smoothing filter
+ *
+ * -EINVAL needs to be returned in the below condition.
+ * * (coef1 + coef2 + coef3 + coef4) * 2 + coef0 != 1024
+ * * Here, [0]: coef0, [1]: coef1, [2]: coef2, [3]: coef3, [4]: coef4
+ */
+struct hwd_viif_l1_hdrc_ltm {
+	uint32_t tnp_max;
+	uint32_t tnp_mag;
+	uint8_t tnp_fil[5];
+};
+
+/**
+ * struct hwd_viif_l1_gamma - HWD L1ISP gamma correction parameters
+ * @gam_p[44]: luminance value after gamma correction [0..8191]
+ * @blkadj: adjustment black level after gamma correction [0..65535]
+ */
+struct hwd_viif_l1_gamma {
+	uint16_t gam_p[44];
+	uint16_t blkadj;
+};
+
+/**
+ * struct hwd_viif_l1_nonlinear_contrast - HWD L1ISP nonlinear contrast parameters
+ * @blk_knee: top luminance value in black area after nonlinear contrast adjustment [0x0..0xffff]
+ * @wht_knee: top luminance value in white area after nonlinear contrast adjustment [0x0..0xffff]
+ * @blk_cont[3]: slope in black area after nonlinear contrast adjustment [0..255] accuracy: 1/256
+ * * [0]: the value at AG minimum
+ * * [1]: the value at AG less than 128
+ * * [2]: the value at AG equal to or more than 128
+ * @wht_cont[3]: slope in white area after nonlinear contrast adjustment [0..255] accuracy: 1/256
+ * * [0]: the value at AG minimum
+ * * [1]: the value at AG less than 128
+ * * [2]: the value at AG equal to or more than 128
+ */
+struct hwd_viif_l1_nonlinear_contrast {
+	uint16_t blk_knee; /**< top luminance value in black area after nonlinear contrast adjustment [0x0..0xffff] */
+	uint16_t wht_knee; /**< top luminance value in white area after nonlinear contrast adjustment [0x0..0xffff] */
+	uint8_t blk_cont[3];
+	uint8_t wht_cont[3];
+};
+
+/**
+ * struct hwd_viif_l1_lum_noise_reduction - HWD L1ISP luminance noise reduction parameters
+ * @gain_min: the minimum gain for extracted noise [0x0..0xffff] accuracy: 1/256
+ * @gain_max: the maximum gain for extracted noise [0x0..0xffff] accuracy: 1/256
+ * @lim_min: the minimum limit value for extracted noise [0x0..0xffff]
+ * @lim_max: the maximum limit value for extracted noise [0x0..0xffff]
+ *
+ * -EINVAL needs to be returned in the below conditions.
+ * * gain_min > gain_max
+ * * lim_min > lim_max
+ */
+struct hwd_viif_l1_lum_noise_reduction {
+	uint16_t gain_min;
+	uint16_t gain_max;
+	uint16_t lim_min;
+	uint16_t lim_max;
+};
+
+/**
+ * struct hwd_viif_l1_edge_enhancement - HWD L1ISP edge enhancement parameters
+ * @gain_min: the minimum gain for extracted edge [0x0..0xffff] accuracy: 1/256
+ * @gain_max: the maximum gain for extracted edge [0x0..0xffff] accuracy: 1/256
+ * @lim_min: the minimum limit value for extracted edge [0x0..0xffff]
+ * @lim_max: the maximum limit value for extracted edge [0x0..0xffff]
+ * @coring_min: the minimum coring threshold for extracted edge [0x0..0xffff]
+ * @coring_max: the maximum coring threshold for extracted edge [0x0..0xffff]
+ *
+ * -EINVAL needs to be returned in the below conditions.
+ * * gain_min > gain_max
+ * * lim_min > lim_max
+ * * coring_min > coring_max
+ */
+struct hwd_viif_l1_edge_enhancement {
+	uint16_t gain_min;
+	uint16_t gain_max;
+	uint16_t lim_min;
+	uint16_t lim_max;
+	uint16_t coring_min;
+	uint16_t coring_max;
+};
+
+/**
+ * struct hwd_viif_l1_uv_suppression - HWD L1ISP UV suppression parameters
+ * @bk_mp: slope of black [0x0..0x3fff] accuracy: 1/16384
+ * @black: the minimum black gain [0x0..0x3fff]  accuracy: 1/16384
+ * @wh_mp: slope of white [0x0..0x3fff]  accuracy: 1/16384
+ * @white: the minimum white gain [0x0..0x3fff]  accuracy: 1/16384
+ * @bk_slv: intercept of black [0x0..0xffff]
+ * @wh_slv: intercept of white [0x0..0xffff]
+ *
+ * -EINVAL needs to be returned in the below condition.
+ * * bk_slv >= wh_slv
+ */
+struct hwd_viif_l1_uv_suppression {
+	uint32_t bk_mp;
+	uint32_t black;
+	uint32_t wh_mp;
+	uint32_t white;
+	uint16_t bk_slv;
+	uint16_t wh_slv;
+};
+
+/**
+ * struct hwd_viif_l1_coring_suppression - HWD L1ISP coring suppression parameters
+ * @lv_min: the minimum coring threshold [0x0..0xffff]
+ * @lv_max: the maximum coring threshold [0x0..0xffff]
+ * @gain_min: the minimum gain [0x0..0xffff] accuracy: 1/65536
+ * @gain_max: the maximum gain [0x0..0xffff] accuracy: 1/65536
+ *
+ * -EINVAL needs to be returned in the below condition.
+ * * lv_min > lv_max
+ * * gain_min > gain_max
+ */
+struct hwd_viif_l1_coring_suppression {
+	uint16_t lv_min;
+	uint16_t lv_max;
+	uint16_t gain_min;
+	uint16_t gain_max;
+};
+
+/**
+ * struct hwd_viif_l1_edge_suppression - HWD L1ISP edge suppression parameters
+ * @gain: gain [0x0..0xffff] accuracy: 1/256
+ * @lim: limit threshold [0..15]
+ */
+struct hwd_viif_l1_edge_suppression {
+	uint16_t gain;
+	uint32_t lim;
+};
+
+/**
+ * struct hwd_viif_l1_color_level - HWD L1ISP color level parameters
+ * @cb_gain: U gain
+ * @cr_gain: V gain
+ * @cbr_mgain_min: UV common gain
+ * @cbp_gain_max: U plus gain
+ * @cbm_gain_max: U minus gain
+ * @crp_gain_max: V plus gain
+ * @crm_gain_max: V minus gain
+ *
+ * Range and accuracy of each parameter are as below.
+ * * range: [0x0..0xfff]
+ * * accuracy: 1/2048
+ */
+struct hwd_viif_l1_color_level {
+	uint32_t cb_gain;
+	uint32_t cr_gain;
+	uint32_t cbr_mgain_min;
+	uint32_t cbp_gain_max;
+	uint32_t cbm_gain_max;
+	uint32_t crp_gain_max;
+	uint32_t crm_gain_max;
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
+ * @color_noise_reduction_enable: enable/disable color noise reduction @ref hwd_VIIF_enable_flag
+ */
+struct hwd_viif_l1_img_quality_adjustment {
+	uint16_t coef_cb;
+	uint16_t coef_cr;
+	int16_t brightness;
+	uint8_t linear_contrast;
+	struct hwd_viif_l1_nonlinear_contrast *nonlinear_contrast;
+	struct hwd_viif_l1_lum_noise_reduction *lum_noise_reduction;
+	struct hwd_viif_l1_edge_enhancement *edge_enhancement;
+	struct hwd_viif_l1_uv_suppression *uv_suppression;
+	struct hwd_viif_l1_coring_suppression *coring_suppression;
+	struct hwd_viif_l1_edge_suppression *edge_suppression;
+	struct hwd_viif_l1_color_level *color_level;
+	uint32_t color_noise_reduction_enable;
+};
+
+/**
+ * struct hwd_viif_l1_avg_lum_generation - HWD L1ISP average luminance generation parameters
+ * @aexp_start_x: horizontal position of block[0] [0.."width of input image - 1"] [pixel]
+ * @aexp_start_y: vertical position of block[0] [0.."height of input image - 1"] [line]
+ * @aexp_block_width: width of one block(needs to be multiple of 64) [64.."width of input image"] [pixel]
+ * @aexp_block_height: height of one block(needs to be multiple of 64) [64.."height of input image"] [line]
+ * @aexp_weight[8][8]: weight of each block [0..3]  [y][x]: y means vertical position and x means horizontal position.
+ * @aexp_satur_ratio: threshold to judge whether saturated block or not [0..256]
+ * @aexp_black_ratio: threshold to judge whether black block or not [0..256]
+ * @aexp_satur_level: threshold to judge whether saturated pixel or not [0x0..0xffffff]
+ * @aexp_ave4linesy[4]: vertical position of the initial line for 4-lines average luminance [0.."height of input image - 4"] [line]
+ */
+struct hwd_viif_l1_avg_lum_generation {
+	uint32_t aexp_start_x;
+	uint32_t aexp_start_y;
+	uint32_t aexp_block_width;
+	uint32_t aexp_block_height;
+	uint32_t aexp_weight[8][8];
+	uint32_t aexp_satur_ratio;
+	uint32_t aexp_black_ratio;
+	uint32_t aexp_satur_level;
+	uint32_t aexp_ave4linesy[4];
+};
+
+/**
+ * struct hwd_viif_l1_histogram - HWD L1ISP histogram parameters
+ * @hist_bin_mode: bin mode @ref hwd_VIIF_l1_bin_mode
+ * @hist_block_v_ofst: vertical position of block[0] [0.."height of input image - 1"] [line]
+ * @hist_block_h_ofst: horizontal position of block[0] [0.."width of input image - 1"] [pixel]
+ * @hist_block_height: height of one block [1.."height of input image"] [line]
+ * @hist_block_width: width of one block [1.."width of input image"] [pixel]
+ * @hist_block_v_num: the number of block in the vertical direction [1..8]
+ * @hist_block_h_num: the number of block in the horizontal direction [1..8]
+ * @hist_block_v_step: vertical line spacing [0..15] [line]
+ * @hist_block_h_step: horizontal pixel spacing [0..15] [pixel]
+ * @hist_linear_sft: bin shift value in case of linear mode [0..31]
+ * @hist_mult_a_r: bin multiplier coefficient(MULT_A) for R [0x0..0xFFFF] accuracy: 1/256
+ * @hist_add_a_r: bin additional value(ADD_A) for R [-16777216..16777215] accuracy: 1/256
+ * @hist_mult_b_r: bin multiplier coefficient(MULT_B) for R [0x0..0xFFFF] accuracy: 1/256
+ * @hist_add_b_r: bin additional value(ADD_B) for R [-65536..65535] accuracy: 1/256
+ * @hist_mult_a_g: bin multiplier coefficient(MULT_A) for G [0x0..0xFFFF] accuracy: 1/256
+ * @hist_add_a_g: bin additional value(ADD_A) for G [-16777216..16777215] accuracy: 1/256
+ * @hist_mult_b_g: bin multiplier coefficient(MULT_B) for G [0x0..0xFFFF] accuracy: 1/256
+ * @hist_add_b_g: bin additional value(ADD_B) for G [-65536..65535] accuracy: 1/256
+ * @hist_mult_a_b: bin multiplier coefficient(MULT_A) for B [0x0..0xFFFF] accuracy: 1/256
+ * @hist_add_a_b: bin additional value(ADD_A) for B [-16777216..16777215] accuracy: 1/256
+ * @hist_mult_b_b: bin multiplier coefficient(MULT_B) for B [0x0..0xFFFF] accuracy: 1/256
+ * @hist_add_b_b: bin additional value(ADD_B) for B [-65536..65535] accuracy: 1/256
+ * @hist_mult_a_y: bin multiplier coefficient(MULT_A) for Y [0x0..0xFFFF] accuracy: 1/256
+ * @hist_add_a_y: bin additional value(ADD_A) for Y [-16777216..16777215] accuracy: 1/256
+ * @hist_mult_b_y: bin multiplier coefficient(MULT_B) for Y [0x0..0xFFFF] accuracy: 1/256
+ * @hist_add_b_y: bin additional value(ADD_B) for Y [-65536..65535] accuracy: 1/256
+ */
+struct hwd_viif_l1_histogram {
+	uint32_t hist_bin_mode;
+	uint32_t hist_block_v_ofst;
+	uint32_t hist_block_h_ofst;
+	uint32_t hist_block_height;
+	uint32_t hist_block_width;
+	uint32_t hist_block_v_num;
+	uint32_t hist_block_h_num;
+	uint32_t hist_block_v_step;
+	uint32_t hist_block_h_step;
+	uint32_t hist_linear_sft;
+	uint16_t hist_mult_a_r;
+	int32_t hist_add_a_r;
+	uint16_t hist_mult_b_r;
+	int32_t hist_add_b_r;
+	uint16_t hist_mult_a_g;
+	int32_t hist_add_a_g;
+	uint16_t hist_mult_b_g;
+	int32_t hist_add_b_g;
+	uint16_t hist_mult_a_b;
+	int32_t hist_add_a_b;
+	uint16_t hist_mult_b_b;
+	int32_t hist_add_b_b;
+	uint16_t hist_mult_a_y;
+	int32_t hist_add_a_y;
+	uint16_t hist_mult_b_y;
+	int32_t hist_add_b_y;
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
+ * @dpc_defect_num_h: the number of dynamically corrected defective pixel(high sensitivity image)
+ * @dpc_defect_num_m: the number of dynamically corrected defective pixel(middle sensitivity or led image)
+ * @dpc_defect_num_l: the number of dynamically corrected defective pixel(low sensitivity image)
+ * @hdrc_tnp_fb_smth_max: the maximum value of luminance information after smoothing filter at HDRC
+ * @avg_lum_weight: weighted average luminance value at average luminance generation
+ * @avg_lum_block[8][8]: average luminance of each block [y][x]: y means vertical position and x means horizontal position.
+ * @avg_lum_four_line_lum[4]: 4-lines average luminance. avg_lum_four_line_lum[n] corresponds to aexp_ave4linesy[n]
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
+	uint32_t context_id;
+	uint8_t ag_cont_hobc_high;
+	uint8_t ag_cont_hobc_middle_led;
+	uint8_t ag_cont_hobc_low;
+	uint8_t ag_cont_abpc_high;
+	uint8_t ag_cont_abpc_middle_led;
+	uint8_t ag_cont_abpc_low;
+	uint8_t ag_cont_rcnr_high;
+	uint8_t ag_cont_rcnr_middle_led;
+	uint8_t ag_cont_rcnr_low;
+	uint8_t ag_cont_lssc;
+	uint8_t ag_cont_mpro;
+	uint8_t ag_cont_vpro;
+	uint32_t dpc_defect_num_h;
+	uint32_t dpc_defect_num_m;
+	uint32_t dpc_defect_num_l;
+	uint32_t hdrc_tnp_fb_smth_max;
+	uint32_t avg_lum_weight;
+	uint32_t avg_lum_block[8][8];
+	uint32_t avg_lum_four_line_lum[4];
+	uint16_t avg_satur_pixnum;
+	uint16_t avg_black_pixnum;
+	uint32_t awb_ave_u;
+	uint32_t awb_ave_v;
+	uint32_t awb_accumulated_pixel;
+	uint32_t awb_gain_r;
+	uint32_t awb_gain_g;
+	uint32_t awb_gain_b;
+	bool awb_status_u;
+	bool awb_status_v;
+};
+
+/**
+ * struct hwd_viif_l2_undist - HWD L2ISP undistortion correction parameters
+ * @through_mode: enable or disable through mode of undistortion @ref hwd_VIIF_enable_flag
+ * @roi_mode: undistortion mode @ref hwd_VIIF_l2_undist_mode, ROI0
+ * @sensor_crop_ofs_h: horizontal start position of sensor crop area [pixel]
+ * * Range and accuracy are as below
+ * * range: -4296 <= sensor_crop_ofs_h <= 4296
+ * * accuracy: 0.5
+ * @sensor_crop_ofs_v: vertical start position of sensor crop area [line]
+ * * Range and accuracy are as below
+ * * range: -2360 <= sensor_crop_ofs_h <= 2360
+ * * accuracy: 0.5
+ * @norm_scale: coefficient to normalize the distance from center [0..1677721] accuracy: 1/33554432
+ * @valid_r_norm2_poly: normalization parameter for polynomial correction [0x0..0x3FFFFFF] accuracy: 1/33554432
+ * @valid_r_norm2_grid: normalization parameter for grid table correction [0x0..0x3FFFFFF] accuracy: 1/33554432
+ * @roi_write_area_delta: parameter to adjust potential area of Write-pixel [0x0..0x7FF] accuracy: 1/1024.
+ * @poly_write_g_coef[11]: polynomial coefficients to calculate the position to write G pixel
+ * * Range and accuracy are as below.
+ * * range: [-2147352576..2147352576]
+ * * accuracy: 1/131072
+ * @poly_read_b_coef[11]: polynomial coefficients to calculate the position to read B pixel
+ * * Range and accuracy are as below.
+ * * range: [-2147352576..2147352576]
+ * * accuracy: 1/131072
+ * @poly_read_g_coef[11]: polynomial coefficients to calculate the position to read G pixel
+ * * Range and accuracy are as below.
+ * * range: [-2147352576..2147352576]
+ * * accuracy: 1/131072
+ * @poly_read_r_coef[11]: polynomial coefficients to calculate the position to read R pixel
+ * * Range and accuracy are as below.
+ * * range: [-2147352576..2147352576]
+ * * accuracy: 1/131072
+ * @grid_node_num_h: the number of horizontal grid [16..64]
+ * @grid_node_num_v: the number of vertical grid [16..64]
+ * @grid_patch_hsize_inv: inverse of grid width [0x0..0x7FFFFF] accuracy: 1/8388608
+ * @grid_patch_vsize_inv: inverse of grid height [0x0..0x7FFFFF] accuracy: 1/8388608
+ *
+ * -EINVAL needs to be returned in the below condition.
+ * * hactive_size + sensor_crop_ofs_h > 4095
+ * * vactive_size + sensor_crop_ofs_v > 2047
+ * * grid_node_num_h * grid_node_num_v <= 2048 when grid_node_num_h and grid_node_num_v are even
+ * * grid_node_num_h * (grid_node_num_v + 1) <= 2048 when grid_node_num_h is even and grid_node_num_v is odd
+ * * (grid_node_num_h + 1) * grid_node_num_v <= 2048 when grid_node_num_h is odd and grid_node_num_v is even
+ * * (grid_node_num_h + 1) * (grid_node_num_v + 1) <= 2048 when grid_node_num_h and grid_node_num_v are odd
+ *
+ * Regarding hactive_size and vactive_size, refer to struct hwd_viif_input_img
+ */
+struct hwd_viif_l2_undist {
+	uint32_t through_mode;
+	uint32_t roi_mode;
+	int32_t sensor_crop_ofs_h;
+	int32_t sensor_crop_ofs_v;
+	uint32_t norm_scale;
+	uint32_t valid_r_norm2_poly;
+	uint32_t valid_r_norm2_grid;
+	uint32_t roi_write_area_delta;
+	int32_t poly_write_g_coef[11];
+	int32_t poly_read_b_coef[11];
+	int32_t poly_read_g_coef[11];
+	int32_t poly_read_r_coef[11];
+	uint32_t grid_node_num_h;
+	uint32_t grid_node_num_v;
+	uint32_t grid_patch_hsize_inv;
+	uint32_t grid_patch_vsize_inv;
+};
+
+/**
+ * struct hwd_viif_l2_roi - HWD L2ISP ROI parameters
+ * @roi_scale: scale of each ROI [32768..131072] accuracy: 1/65536
+ * @roi_scale_inv: inverse of scale of each ROI [32768..131072] accuracy: 1/65536
+ * @corrected_wo_scale_hsize: ROI width after undistortion [128..8190]
+ * @corrected_wo_scale_vsize: ROI height after undistortion [128..4094]
+ * @corrected_hsize: ROI width after undistortion and scaling [128..8190]
+ * @corrected_vsize: ROI height after undistortion and scaling [128..4094]
+ *
+ * the relation between element and ROI is as below.
+ * * [0]: ROI0
+ * * [1]: ROI1
+ */
+struct hwd_viif_l2_roi {
+	uint32_t roi_scale;
+	uint32_t roi_scale_inv;
+	uint32_t corrected_wo_scale_hsize;
+	uint32_t corrected_wo_scale_vsize;
+	uint32_t corrected_hsize;
+	uint32_t corrected_vsize;
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
+/**
+ * struct hwd_viif_l2_transfer_addr_info - HWD L2ISP image data output address
+ * @post0_paddr[3]: output address of POST0 which VIIF HW holds(physical address)
+ * @post1_paddr[3]: output address of POST1 which VIIF HW holds(physical address)
+ *
+ * relation between element and address is as below.
+ * * [0]: image data(G-planar/Y-planar/Packed)
+ * * [1]: image data(B-planar/U-planar)
+ * * [2]: image data(R-planar/V-planar)
+ */
+struct hwd_viif_l2_transfer_addr_info {
+	uint32_t post0_paddr[3];
+	uint32_t post1_paddr[3];
+};
+
+/* VIIF common */
+int32_t hwd_VIIF_initialize(uint32_t module_id, void *csi2host_vaddr, void *capture_vaddr);
+int32_t hwd_VIIF_uninitialize(uint32_t module_id);
+int32_t hwd_VIIF_force_stop(uint32_t module_id);
+int32_t hwd_VIIF_get_failure_status(uint32_t module_id, bool *is_vsync_failure_main,
+				    bool *is_vsync_failure_sub, uint32_t *ecc_failure);
+uint32_t hwd_VIIF_csi2rx_err_irq_handler(uint32_t module_id);
+void hwd_VIIF_status_err_irq_handler(uint32_t module_id, uint32_t *event_main, uint32_t *event_sub);
+void hwd_VIIF_vsync_irq_handler(uint32_t module_id, uint32_t *event_main, uint32_t *event_sub);
+void hwd_VIIF_isp_regbuf_irq_handler(uint32_t module_id, uint32_t *event_l1, uint32_t *event_l2);
+
+/* control MAIN unit */
+int32_t hwd_VIIF_main_set_unit(uint32_t module_id, uint32_t dt_image, uint32_t dt_long_packet,
+			       const struct hwd_viif_input_img *in_img, uint32_t color_type,
+			       uint32_t rawpack, uint32_t yuv_conv);
+int32_t hwd_VIIF_main_set_emb_transmission(uint32_t module_id, uintptr_t buf);
+int32_t hwd_VIIF_main_set_long_packet_transmission(uint32_t module_id, uintptr_t buf);
+int32_t hwd_VIIF_main_mask_vlatch(uint32_t module_id, uint32_t enable);
+void hwd_VIIF_main_status_err_set_irq_mask(uint32_t module_id, const uint32_t *mask);
+void hwd_VIIF_main_vsync_set_irq_mask(uint32_t module_id, const uint32_t *mask);
+void hwd_VIIF_main_get_next_frame_info(uint32_t module_id, uint32_t *count0, uint32_t *count1,
+				       uint32_t *count2, uint32_t *hist_paddr,
+				       struct hwd_viif_main_transfer_addr_info *addr_info);
+void hwd_VIIF_main_get_previous_frame_info(uint32_t module_id, uint32_t *abort_r, uint32_t *abort_w,
+					   struct hwd_viif_csi2rx_capture_info *packet_info);
+int32_t hwd_VIIF_main_set_unit_w_isp(uint32_t module_id, uint32_t dt_image, uint32_t dt_long_packet,
+				     const struct hwd_viif_input_img *in_img, uint32_t color_type,
+				     uint32_t rawpack, uint32_t yuv_conv);
+
+/* conrol SUB unit */
+int32_t hwd_VIIF_sub_set_unit(uint32_t module_id, uint32_t dt_image, uint32_t dt_long_packet,
+			      const struct hwd_viif_input_img *in_img);
+int32_t hwd_VIIF_sub_set_img_transmission(uint32_t module_id, const struct hwd_viif_img *img);
+int32_t hwd_VIIF_sub_mask_vlatch(uint32_t module_id, uint32_t enable);
+void hwd_VIIF_sub_status_err_set_irq_mask(uint32_t module_id, const uint32_t *mask);
+void hwd_VIIF_sub_vsync_set_irq_mask(uint32_t module_id, const uint32_t *mask);
+void hwd_VIIF_sub_get_next_frame_info(uint32_t module_id, uint32_t *count0, uint32_t *count1,
+				      uint32_t *img_paddr, uint32_t *emb_paddr,
+				      uint32_t *long_packet_paddr);
+void hwd_VIIF_sub_get_previous_frame_info(uint32_t module_id, uint32_t *abort_w,
+					  struct hwd_viif_csi2rx_capture_info *packet_info);
+
+/* control MIPI CSI2 Receiver unit */
+int32_t hwd_VIIF_csi2rx_initialize(uint32_t module_id, uint32_t num_lane, uint32_t lane_assign,
+				   uint32_t dphy_rate, uint32_t rext_calibration,
+				   const struct hwd_viif_csi2rx_line_err_target *err_target,
+				   uint32_t input_mode,
+				   const struct hwd_viif_csi2rx_irq_mask *mask);
+int32_t hwd_VIIF_csi2rx_uninitialize(uint32_t module_id);
+int32_t hwd_VIIF_csi2rx_start(uint32_t module_id, int32_t vc_main, int32_t vc_sub,
+			      const struct hwd_viif_csi2rx_packet *packet, uint32_t voif_through);
+int32_t hwd_VIIF_csi2rx_stop(uint32_t module_id);
+int32_t hwd_VIIF_csi2rx_get_dphy_status(uint32_t module_id, uint32_t *ulps, uint32_t *stop);
+int32_t hwd_VIIF_csi2rx_get_calibration_status(
+	uint32_t module_id, struct hwd_viif_csi2rx_dphy_calibration_status *calibration_status);
+int32_t hwd_VIIF_csi2rx_get_err_status(uint32_t module_id, uint32_t *err_phy_fatal,
+				       uint32_t *err_pkt_fatal, uint32_t *err_frame_fatal,
+				       uint32_t *err_phy, uint32_t *err_pkt, uint32_t *err_line);
+
+/* control L1 Image Signal Processor */
+void hwd_VIIF_isp_set_regbuf_auto_transmission(uint32_t module_id, uint32_t regbuf_id_read,
+					       uint32_t regbuf_id_write, uint32_t context_id);
+void hwd_VIIF_isp_disable_regbuf_auto_transmission(uint32_t module_id);
+void hwd_VIIF_isp_get_info(uint32_t module_id, uint32_t regbuf_id, uint32_t *regbuf_id_info,
+			   struct hwd_viif_l1_info *l1_info,
+			   struct hwd_viif_l2_transfer_addr_info *l2_addr_info,
+			   uint32_t *l2_transfer_status,
+			   struct hwd_viif_isp_regbuf_status *l1_regbuf_status,
+			   struct hwd_viif_isp_regbuf_status *l2_regbuf_status);
+void hwd_VIIF_isp_set_regbuf_irq_mask(uint32_t module_id, const uint32_t *mask_l1,
+				      const uint32_t *mask_l2);
+void hwd_VIIF_isp_disable_isst(uint32_t module_id);
+
+int32_t hwd_VIIF_l1_set_input_mode(uint32_t module_id, uint32_t mode, uint32_t depth,
+				   uint32_t raw_color_filter,
+				   const struct hwd_viif_l1_raw_input_order *interpolation_order);
+int32_t hwd_VIIF_l1_set_rgb_to_y_coef(uint32_t module_id, uint32_t regbuf_id, uint16_t coef_r,
+				      uint16_t coef_g, uint16_t coef_b);
+int32_t hwd_VIIF_l1_set_ag_mode(uint32_t module_id, uint32_t regbuf_id,
+				const struct hwd_viif_l1_ag_mode *param);
+int32_t hwd_VIIF_l1_set_ag(uint32_t module_id, uint32_t regbuf_id, uint16_t gain_h, uint16_t gain_m,
+			   uint16_t gain_l);
+int32_t hwd_VIIF_l1_set_hdre(uint32_t module_id, uint32_t regbuf_id,
+			     const struct hwd_viif_l1_hdre *param);
+int32_t hwd_VIIF_l1_set_img_extraction(uint32_t module_id, uint32_t regbuf_id,
+				       uint32_t input_black_gr, uint32_t input_black_r,
+				       uint32_t input_black_b, uint32_t input_black_gb);
+int32_t hwd_VIIF_l1_set_dpc(uint32_t module_id, uint32_t regbuf_id,
+			    const struct hwd_viif_l1_dpc *param_h,
+			    const struct hwd_viif_l1_dpc *param_m,
+			    const struct hwd_viif_l1_dpc *param_l);
+int32_t hwd_VIIF_l1_set_dpc_table_transmission(uint32_t module_id, uintptr_t table_h,
+					       uintptr_t table_m, uintptr_t table_l);
+int32_t
+hwd_VIIF_l1_set_preset_white_balance(uint32_t module_id, uint32_t regbuf_id, uint32_t dstmaxval,
+				     const struct hwd_viif_l1_preset_white_balance *param_h,
+				     const struct hwd_viif_l1_preset_white_balance *param_m,
+				     const struct hwd_viif_l1_preset_white_balance *param_l);
+int32_t hwd_VIIF_l1_set_raw_color_noise_reduction(
+	uint32_t module_id, uint32_t regbuf_id,
+	const struct hwd_viif_l1_raw_color_noise_reduction *param_h,
+	const struct hwd_viif_l1_raw_color_noise_reduction *param_m,
+	const struct hwd_viif_l1_raw_color_noise_reduction *param_l);
+int32_t hwd_VIIF_l1_set_hdrs(uint32_t module_id, uint32_t regbuf_id,
+			     const struct hwd_viif_l1_hdrs *param);
+int32_t
+hwd_VIIF_l1_set_black_level_correction(uint32_t module_id, uint32_t regbuf_id,
+				       const struct hwd_viif_l1_black_level_correction *param);
+int32_t hwd_VIIF_l1_set_lsc(uint32_t module_id, uint32_t regbuf_id,
+			    const struct hwd_viif_l1_lsc *param);
+int32_t hwd_VIIF_l1_set_lsc_table_transmission(uint32_t module_id, uintptr_t table_gr,
+					       uintptr_t table_r, uintptr_t table_b,
+					       uintptr_t table_gb);
+int32_t hwd_VIIF_l1_set_main_process(uint32_t module_id, uint32_t regbuf_id, uint32_t demosaic_mode,
+				     uint32_t damp_lsbsel,
+				     const struct hwd_viif_l1_color_matrix_correction *color_matrix,
+				     uint32_t dst_maxval);
+int32_t hwd_VIIF_l1_set_awb(uint32_t module_id, uint32_t regbuf_id,
+			    const struct hwd_viif_l1_awb *param, uint32_t awhb_wbmrg,
+			    uint32_t awhb_wbmgg, uint32_t awhb_wbmbg);
+int32_t hwd_VIIF_l1_lock_awb_gain(uint32_t module_id, uint32_t regbuf_id, uint32_t enable);
+int32_t hwd_VIIF_l1_set_hdrc(uint32_t module_id, uint32_t regbuf_id,
+			     const struct hwd_viif_l1_hdrc *param, uint32_t hdrc_thr_sft_amt);
+int32_t hwd_VIIF_l1_set_hdrc_ltm(uint32_t module_id, uint32_t regbuf_id,
+				 const struct hwd_viif_l1_hdrc_ltm *param);
+int32_t hwd_VIIF_l1_set_gamma(uint32_t module_id, uint32_t regbuf_id,
+			      const struct hwd_viif_l1_gamma *param);
+int32_t
+hwd_VIIF_l1_set_img_quality_adjustment(uint32_t module_id, uint32_t regbuf_id,
+				       const struct hwd_viif_l1_img_quality_adjustment *param);
+int32_t hwd_VIIF_l1_set_avg_lum_generation(uint32_t module_id, uint32_t regbuf_id,
+					   const struct hwd_viif_l1_avg_lum_generation *param);
+int32_t hwd_VIIF_l1_set_histogram(uint32_t module_id, uint32_t regbuf_id,
+				  const struct hwd_viif_l1_histogram *param);
+int32_t hwd_VIIF_l1_set_histogram_transmission(uint32_t module_id, uintptr_t buf,
+					       uint32_t block_v_num);
+void hwd_VIIF_l1_set_irq_mask(uint32_t module_id, const uint32_t *mask);
+
+/* control L2 Image Signal Processor */
+int32_t hwd_VIIF_l2_set_input_path(uint32_t module_id, bool is_other_ch);
+int32_t hwd_VIIF_l2_set_input_csc(uint32_t module_id, const struct hwd_viif_csc_param *param,
+				  bool is_l1_rgb);
+int32_t hwd_VIIF_l2_set_undist(uint32_t module_id, uint32_t regbuf_id,
+			       const struct hwd_viif_l2_undist *param);
+int32_t hwd_VIIF_l2_set_undist_table_transmission(uint32_t module_id, uintptr_t write_g,
+						  uintptr_t read_b, uintptr_t read_g,
+						  uintptr_t read_r, uint32_t size);
+int32_t hwd_VIIF_l2_set_roi(uint32_t module_id, uint32_t regbuf_id,
+			    const struct hwd_viif_l2_roi *param);
+int32_t hwd_VIIF_l2_set_gamma(uint32_t module_id, uint32_t post_id, uint32_t regbuf_id,
+			      uint32_t enable, uint32_t vsplit, uint32_t mode);
+int32_t hwd_VIIF_l2_set_gamma_table_transmission(uint32_t module_id, uint32_t post_id,
+						 const struct hwd_viif_l2_gamma_table *gamma_table);
+int32_t hwd_VIIF_l2_set_output_csc(uint32_t module_id, uint32_t post_id, uint32_t regbuf_id,
+				   const struct hwd_viif_csc_param *param);
+int32_t hwd_VIIF_l2_set_img_transmission(uint32_t module_id, uint32_t post_id, uint32_t regbuf_id,
+					 uint32_t enable, const struct hwd_viif_img_area *src,
+					 const struct hwd_viif_out_process *out_process,
+					 const struct hwd_viif_img *img);
+void hwd_VIIF_l2_set_irq_mask(uint32_t module_id, const uint32_t *mask);
+
+struct hwd_viif_res *viif_id2res(uint32_t module_id);
+
+#endif /* HWD_VIIF_H */
diff --git a/drivers/media/platform/visconti/hwd_viif_csi2rx.c b/drivers/media/platform/visconti/hwd_viif_csi2rx.c
new file mode 100644
index 000000000..c95665ee9
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif_csi2rx.c
@@ -0,0 +1,767 @@
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
+ * hwd_VIIF_csi2rx_write_dphy_param() - Write CSI2RX DPHY params
+ *
+ * @test_mode: test code address
+ * @test_in: test code data
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+static void hwd_VIIF_csi2rx_write_dphy_param(uint32_t test_mode, uint8_t test_in,
+					     struct hwd_viif_res *res)
+{
+	/* select MSB address register */
+	writel(TESTCTRL1_PHY_TESTEN, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL1));
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+	writel(TESTCTRL0_PHY_TESTCLK_0, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+
+	/* set MSB address of test_mode */
+	writel(FIELD_GET(0xF00, test_mode), &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL1));
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+	writel(TESTCTRL0_PHY_TESTCLK_0, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+
+	/* select and set LSB address register */
+	writel(TESTCTRL1_PHY_TESTEN | FIELD_GET(0xFF, test_mode),
+	       &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL1));
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+	writel(TESTCTRL0_PHY_TESTCLK_0, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+
+	/* set the test code data */
+	writel((uint32_t)test_in, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL1));
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+	writel(TESTCTRL0_PHY_TESTCLK_0, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+}
+
+/**
+ * hwd_VIIF_csi2rx_read_dphy_param() - Read CSI2RX DPHY params
+ *
+ * @test_mode: test code address
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: test code data
+ */
+static uint8_t hwd_VIIF_csi2rx_read_dphy_param(uint32_t test_mode, struct hwd_viif_res *res)
+{
+	uint32_t read_data;
+
+	/* select MSB address register */
+	writel(TESTCTRL1_PHY_TESTEN, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL1));
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+	writel(TESTCTRL0_PHY_TESTCLK_0, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+
+	/* set MSB address of test_mode */
+	writel(FIELD_GET(0xF00, test_mode), &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL1));
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+	writel(TESTCTRL0_PHY_TESTCLK_0, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+
+	/* select and set LSB address register */
+	writel(TESTCTRL1_PHY_TESTEN | FIELD_GET(0xFF, test_mode),
+	       &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL1));
+
+	/* rise and clear the testclk */
+	writel(TESTCTRL0_PHY_TESTCLK_1, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+	writel(TESTCTRL0_PHY_TESTCLK_0, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+
+	/* read the test code data */
+	read_data = readl(&res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
+	return (uint8_t)(read_data >> TESTCTRL1_PHY_TESTDOUT_SHIFT);
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
+ * hwd_VIIF_csi2rx_get_dphy_hs_transfer_info() - Get DPHY HS info from table
+ *
+ * @dphy_rate: DPHY clock in MHz
+ * @hsfreqrange: HS Frequency Range
+ * @osc_freq_target: OSC Frequency Target
+ * Return: None
+ */
+static void hwd_VIIF_csi2rx_get_dphy_hs_transfer_info(uint32_t dphy_rate, uint32_t *hsfreqrange,
+						      uint32_t *osc_freq_target,
+						      struct hwd_viif_res *res)
+{
+	int i;
+	int table_size = sizeof(dphy_hs_info) / sizeof(dphy_hs_info[0]);
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
+ * hwd_VIIF_csi2rx_set_dphy_rate() - Set D-PHY rate
+ *
+ * @dphy_rate: D-PHY rate of 1 Lane[Mbps] [80..1500]
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+static void hwd_VIIF_csi2rx_set_dphy_rate(uint32_t dphy_rate, struct hwd_viif_res *res)
+{
+	uint32_t hsfreqrange, osc_freq_target;
+
+	hwd_VIIF_csi2rx_get_dphy_hs_transfer_info(dphy_rate, &hsfreqrange, &osc_freq_target, res);
+
+	hwd_VIIF_csi2rx_write_dphy_param(DIG_RDWR_RX_SYS_1, (uint8_t)hsfreqrange, res);
+	hwd_VIIF_csi2rx_write_dphy_param(DIG_RDWR_RX_SYS_0, SYS_0_HSFREQRANGE_OVR, res);
+	hwd_VIIF_csi2rx_write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_5, STARTUP_OVR_5_BYPASS, res);
+	hwd_VIIF_csi2rx_write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_4, STARTUP_OVR_4_CNTVAL, res);
+	hwd_VIIF_csi2rx_write_dphy_param(DIG_RDWR_RX_CB_2, CB_2_LPRX_BIAS | CB_2_RESERVED, res);
+	hwd_VIIF_csi2rx_write_dphy_param(DIG_RDWR_RX_SYS_7, SYS_7_DESKEW_POL | SYS_7_RESERVED, res);
+	hwd_VIIF_csi2rx_write_dphy_param(DIG_RDWR_RX_CLKLANE_LANE_6, CLKLANE_RXHS_PULL_LONG, res);
+	hwd_VIIF_csi2rx_write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_2,
+					 FIELD_GET(0xff, osc_freq_target), res);
+	hwd_VIIF_csi2rx_write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_3,
+					 FIELD_GET(0xf00, osc_freq_target), res);
+	hwd_VIIF_csi2rx_write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_4,
+					 STARTUP_OVR_4_CNTVAL | STARTUP_OVR_4_DDL_EN, res);
+
+	writel(HWD_VIIF_DPHY_CFG_CLK_25M, &(res->capture_reg->sys.DPHY_FREQRANGE));
+}
+
+/**
+ * hwd_VIIF_csi2rx_check_dphy_calibration_status() - Check D-PHY calibration status
+ *
+ * @test_mode: test code related to calibration information
+ * @shift_val_err: shift value related to error information
+ * @shift_val_done: shift value related to done information
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: HWD_VIIF_CSI2_CAL_NOT_DONE calibration is not done(out of target or not completed)
+ * Return: HWD_VIIF_CSI2_CAL_FAIL calibration was failed
+ * Return: HWD_VIIF_CSI2_CAL_SUCCESS calibration was succeeded
+ */
+static uint32_t hwd_VIIF_csi2rx_check_dphy_calibration_status(uint32_t test_mode,
+							      uint32_t shift_val_err,
+							      uint32_t shift_val_done,
+							      struct hwd_viif_res *res)
+{
+	uint32_t read_data;
+	uint32_t ret = HWD_VIIF_CSI2_CAL_NOT_DONE;
+
+	read_data = (uint32_t)hwd_VIIF_csi2rx_read_dphy_param(test_mode, res);
+
+	if (read_data & BIT(shift_val_done)) {
+		ret = HWD_VIIF_CSI2_CAL_SUCCESS;
+
+		/* error check is not required for termination calibration with REXT(0x221) */
+		if (test_mode == DIG_RD_RX_TERM_CAL_1)
+			return ret;
+
+		/* done with error */
+		if (read_data & BIT(shift_val_err))
+			ret = HWD_VIIF_CSI2_CAL_FAIL;
+	}
+
+	return ret;
+}
+
+/**
+ * hwd_VIIF_csi2rx_initialize() - Initialize CSI-2 RX driver
+ *
+ * @num_lane: [1..4](VIIF CH0-CH1)
+ * @lane_assign: lane connection. For more refer @ref hwd_VIIF_dphy_lane_assignment
+ * @dphy_rate: D-PHY rate of 1 Lane[Mbps] [80..1500]
+ * @rext_calibration: enable or disable rext calibration. For more refer @ref hwd_VIIF_csi2rx_cal_status
+ * @err_target: Pointer to configuration for Line error detection.
+ * @input_mode: CSI-2 input mode of VIIF CH1. For more refer @ref hwd_VIIF_csi2rx_input_mode
+ * @mask: MASK of CSI-2 RX error interruption
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "num_lane", "lane_assign", "dphy_rate", "rext_calibration" or "input_mode" is out of range
+ * - [2] "err_target" is NULL
+ * - [3] member of "err_target" is invalid
+ */
+int32_t hwd_VIIF_csi2rx_initialize(uint32_t module_id, uint32_t num_lane, uint32_t lane_assign,
+				   uint32_t dphy_rate, uint32_t rext_calibration,
+				   const struct hwd_viif_csi2rx_line_err_target *err_target,
+				   uint32_t input_mode, const struct hwd_viif_csi2rx_irq_mask *mask)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t i, val;
+
+	if (res->csi2rx_type == HWD_VIIF_CSI2_TYPE_4_LANES) {
+		if ((num_lane == 0U) || (num_lane > 4U) ||
+		    (lane_assign > HWD_VIIF_CSI2_DPHY_L0L2L1L3)) {
+			return -EINVAL;
+		}
+	} else {
+		if (((num_lane != 1U) && (num_lane != 2U)) ||
+		    (lane_assign != HWD_VIIF_CSI2_DPHY_L0L1L2L3)) {
+			return -EINVAL;
+		}
+	}
+
+	if (dphy_rate < HWD_VIIF_DPHY_MIN_DATA_RATE)
+		return -EINVAL;
+
+	if (dphy_rate > HWD_VIIF_DPHY_MAX_DATA_RATE)
+		return -EINVAL;
+
+	if ((rext_calibration != HWD_VIIF_ENABLE) && (rext_calibration != HWD_VIIF_DISABLE))
+		return -EINVAL;
+
+	if (input_mode > HWD_VIIF_CSI2_INPUT_OTHER)
+		return -EINVAL;
+
+	if ((res->ch != 1U) && (input_mode != HWD_VIIF_CSI2_INPUT_OWN))
+		return -EINVAL;
+
+	if (err_target == NULL)
+		return -EINVAL;
+
+	for (i = 0; i < 8U; i++) {
+		if (err_target->vc[i] > HWD_VIIF_CSI2_MAX_VC)
+			return -EINVAL;
+
+		if (err_target->dt[i] > HWD_VIIF_CSI2_MAX_DT)
+			return -EINVAL;
+
+		if ((err_target->dt[i] < HWD_VIIF_CSI2_MIN_DT) && (err_target->dt[i] != 0U))
+			return -EINVAL;
+	}
+
+	if (input_mode == HWD_VIIF_CSI2_INPUT_OWN) {
+		/* 1st phase of initialization */
+		writel(HWD_VIIF_ENABLE, &(res->csi2host_reg->CSI2RX_RESETN));
+		writel(HWD_VIIF_DISABLE, &(res->csi2host_reg->CSI2RX_PHY_RSTZ));
+		writel(HWD_VIIF_DISABLE, &(res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ));
+		writel(HWD_VIIF_ENABLE, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+		ndelay(15U);
+		writel(HWD_VIIF_DISABLE, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+
+		/* Configure D-PHY frequency range */
+		hwd_VIIF_csi2rx_set_dphy_rate(dphy_rate, res);
+
+		/* 2nd phase of initialization */
+		writel((num_lane - 1U), &(res->csi2host_reg->CSI2RX_NLANES));
+		ndelay(5U);
+
+		/* configuration not to use rext */
+		if (rext_calibration == HWD_VIIF_DISABLE) {
+			hwd_VIIF_csi2rx_write_dphy_param(0x004, 0x10, res);
+			ndelay(5U);
+		}
+
+		/* Release D-PHY from Reset */
+		writel(HWD_VIIF_ENABLE, &(res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ));
+		ndelay(5U);
+		writel(HWD_VIIF_ENABLE, &(res->csi2host_reg->CSI2RX_PHY_RSTZ));
+
+		/* configuration of line error target */
+		val = (err_target->vc[3] << 30U) | (err_target->dt[3] << 24U) |
+		      (err_target->vc[2] << 22U) | (err_target->dt[2] << 16U) |
+		      (err_target->vc[1] << 14U) | (err_target->dt[1] << 8U) |
+		      (err_target->vc[0] << 6U) | (err_target->dt[0]);
+		writel(val, &(res->csi2host_reg->CSI2RX_DATA_IDS_1));
+		if (res->csi2rx_type == HWD_VIIF_CSI2_TYPE_4_LANES) {
+			val = (err_target->vc[7] << 30U) | (err_target->dt[7] << 24U) |
+			      (err_target->vc[6] << 22U) | (err_target->dt[6] << 16U) |
+			      (err_target->vc[5] << 14U) | (err_target->dt[5] << 8U) |
+			      (err_target->vc[4] << 6U) | (err_target->dt[4]);
+			writel(val, &(res->csi2host_reg->CSI2RX_DATA_IDS_2));
+		}
+
+		/* configuration of mask */
+		writel(mask->mask[0], &(res->csi2host_reg->CSI2RX_INT_MSK_PHY_FATAL));
+		writel(mask->mask[1], &(res->csi2host_reg->CSI2RX_INT_MSK_PKT_FATAL));
+		writel(mask->mask[2], &(res->csi2host_reg->CSI2RX_INT_MSK_FRAME_FATAL));
+		writel(mask->mask[3], &(res->csi2host_reg->CSI2RX_INT_MSK_PHY));
+		writel(mask->mask[4], &(res->csi2host_reg->CSI2RX_INT_MSK_PKT));
+		writel(mask->mask[5], &(res->csi2host_reg->CSI2RX_INT_MSK_LINE));
+
+		/* configuration of lane assignment */
+		writel(lane_assign, &(res->capture_reg->sys.DPHY_LANE));
+
+		res->other_csi2_flag = false;
+	} else {
+		/* configuration of csi2 port */
+		writel(input_mode, &(res->capture_reg->sys.CSI2SELECT));
+
+		res->other_csi2_flag = true;
+	}
+	return 0;
+}
+
+/**
+ * hwd_VIIF_csi2rx_uninitialize() - Uninitialize CSI-2 RX driver
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ */
+int32_t hwd_VIIF_csi2rx_uninitialize(uint32_t module_id)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (res->other_csi2_flag == false) {
+		/* CSI2RX can be uninitialized because it has been enabled. */
+		writel(HWD_VIIF_DISABLE, &(res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ));
+		writel(HWD_VIIF_DISABLE, &(res->csi2host_reg->CSI2RX_PHY_RSTZ));
+		writel(HWD_VIIF_ENABLE, &(res->csi2host_reg->CSI2RX_PHY_TESTCTRL0));
+		writel(HWD_VIIF_DISABLE, &(res->csi2host_reg->CSI2RX_RESETN));
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_csi2rx_start() - Start CSI-2 input
+ *
+ * @vc_main: control CSI-2 input of MAIN unit. enable with configured VC: 0, 1, 2 or 3, keep disabling:
+ * @vc_sub: control CSI-2 input of SUB unit. enable with configured VC: 0, 1, 2 or 3, keep disabling:
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
+int32_t hwd_VIIF_csi2rx_start(uint32_t module_id, int32_t vc_main, int32_t vc_sub,
+			      const struct hwd_viif_csi2rx_packet *packet, uint32_t voif_through)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val, i, pitch, height, dt, start_addr, end_addr;
+	uint32_t enable_vc0 = HWD_VIIF_DISABLE, enable_vc1 = HWD_VIIF_DISABLE;
+
+	if ((vc_main > 3) || (vc_main < HWD_VIIF_CSI2_NOT_CAPTURE) || (vc_sub > 3) ||
+	    (vc_sub < HWD_VIIF_CSI2_NOT_CAPTURE)) {
+		return -EINVAL;
+	}
+
+	if ((res->ch >= 2U) && (vc_sub != HWD_VIIF_CSI2_NOT_CAPTURE))
+		return -EINVAL;
+
+	for (i = 0; i < 4U; i++) {
+		if ((packet->word_count[i] > HWD_VIIF_CSI2_MAX_WORD_COUNT) ||
+		    (packet->packet_num[i] > HWD_VIIF_CSI2_MAX_PACKET_NUM)) {
+			return -EINVAL;
+		}
+
+		if (((i == 2U) || (i == 3U)) && (res->ch >= 2U))
+			if ((packet->word_count[i] != 0U) || (packet->packet_num[i] != 0U))
+				return -EINVAL;
+	}
+
+	if ((voif_through != HWD_VIIF_ENABLE) && (voif_through != HWD_VIIF_DISABLE))
+		return -EINVAL;
+
+	if ((res->ch != 1U) && (voif_through == HWD_VIIF_ENABLE))
+		return -EINVAL;
+
+	writel(HWD_VIIF_INPUT_CSI2, &(res->capture_reg->sys.IPORTM));
+
+	if (vc_main != HWD_VIIF_CSI2_NOT_CAPTURE) {
+		writel((uint32_t)vc_main, &(res->capture_reg->sys.VCID0SELECT));
+		enable_vc0 = HWD_VIIF_ENABLE;
+	}
+	if (vc_sub != HWD_VIIF_CSI2_NOT_CAPTURE) {
+		writel((uint32_t)vc_sub, &(res->capture_reg->sys.VCID1SELECT));
+		enable_vc1 = HWD_VIIF_ENABLE;
+	}
+
+	if ((res->ch == 0U) || (res->ch == 1U)) {
+		/* emb of MAIN unit: word_count[0], packet_num[0] and w_port[1](= w01) */
+		pitch = ROUNDUP_BY_4(packet->word_count[0]);
+		writel(pitch, &(res->capture_reg->vdm.w_port[1].VDM_W_PITCH));
+		writel(packet->packet_num[0], &(res->capture_reg->vdm.w_port[1].VDM_W_HEIGHT));
+		start_addr = readl(&res->capture_reg->vdm.w_port[1].VDM_W_STADR);
+		end_addr = start_addr + pitch - 1U;
+		writel(end_addr, &(res->capture_reg->vdm.w_port[1].VDM_W_ENDADR));
+
+		/* long packet of MAIN unit: word_count[1], packet_num[1] and w_port[0](= w00) */
+		dt = readl(&res->capture_reg->sys.IPORTM_OTHER);
+		if ((dt == CSI2_DT_YUV4208) || (dt == CSI2_DT_YUV4208) ||
+		    (dt == CSI2_DT_YUV4208C) || (dt == CSI2_DT_YUV42010C)) {
+			pitch = ROUNDUP_BY_4(packet->word_count[1]) +
+				ROUNDUP_BY_4(packet->word_count[1] * 2U);
+			height = packet->packet_num[1] >> 1U;
+		} else {
+			pitch = ROUNDUP_BY_4(packet->word_count[1]);
+			height = packet->packet_num[1];
+		}
+		writel(pitch, &(res->capture_reg->vdm.w_port[0].VDM_W_PITCH));
+		writel(height, &(res->capture_reg->vdm.w_port[0].VDM_W_HEIGHT));
+		start_addr = readl(&res->capture_reg->vdm.w_port[0].VDM_W_STADR);
+		end_addr = start_addr + pitch - 1U;
+		writel(end_addr, &(res->capture_reg->vdm.w_port[0].VDM_W_ENDADR));
+
+		/* emb of SUB unit: word_count[2], packet_num[2] and w_port[5](= w05) */
+		pitch = ROUNDUP_BY_4(packet->word_count[2]);
+		writel(pitch, &(res->capture_reg->vdm.w_port[5].VDM_W_PITCH));
+		writel(packet->packet_num[2], &(res->capture_reg->vdm.w_port[5].VDM_W_HEIGHT));
+		start_addr = readl(&res->capture_reg->vdm.w_port[5].VDM_W_STADR);
+		end_addr = start_addr + pitch - 1U;
+		writel(end_addr, &(res->capture_reg->vdm.w_port[5].VDM_W_ENDADR));
+
+		/* long packet of SUB unit: word_count[3], packet_num[3] and w_port[4](= w04) */
+		dt = readl(&res->capture_reg->sys.IPORTS_OTHER);
+		if ((dt == CSI2_DT_YUV4208) || (dt == CSI2_DT_YUV42010) ||
+		    (dt == CSI2_DT_YUV4208C) || (dt == CSI2_DT_YUV42010C)) {
+			pitch = ROUNDUP_BY_4(packet->word_count[3]) +
+				ROUNDUP_BY_4(packet->word_count[3] * 2U);
+			height = packet->packet_num[3] >> 1U;
+		} else {
+			pitch = ROUNDUP_BY_4(packet->word_count[3]);
+			height = packet->packet_num[3];
+		}
+		writel(pitch, &(res->capture_reg->vdm.w_port[4].VDM_W_PITCH));
+		writel(height, &(res->capture_reg->vdm.w_port[4].VDM_W_HEIGHT));
+		start_addr = readl(&res->capture_reg->vdm.w_port[4].VDM_W_STADR);
+		end_addr = start_addr + pitch - 1U;
+		writel(end_addr, &(res->capture_reg->vdm.w_port[4].VDM_W_ENDADR));
+	} else {
+		/* emb of MAIN unit: word_count[0], packet_num[0] and w_port[4](= w04) */
+		pitch = ROUNDUP_BY_4(packet->word_count[0]);
+		writel(pitch, &(res->capture_reg->vdm.w_port[4].VDM_W_PITCH));
+		writel(packet->packet_num[0], &(res->capture_reg->vdm.w_port[4].VDM_W_HEIGHT));
+		start_addr = readl(&res->capture_reg->vdm.w_port[4].VDM_W_STADR);
+		end_addr = start_addr + pitch - 1U;
+		writel(end_addr, &(res->capture_reg->vdm.w_port[4].VDM_W_ENDADR));
+
+		/* long packet of MAIN unit: word_count[1], packet_num[1] and w_port[3](= w03) */
+		dt = readl(&res->capture_reg->sys.IPORTM_OTHER);
+		if ((dt == CSI2_DT_YUV4208) || (dt == CSI2_DT_YUV42010) ||
+		    (dt == CSI2_DT_YUV4208C) || (dt == CSI2_DT_YUV42010C)) {
+			pitch = ROUNDUP_BY_4(packet->word_count[1]) +
+				ROUNDUP_BY_4(packet->word_count[1] * 2U);
+			height = packet->packet_num[1] >> 1U;
+		} else {
+			pitch = ROUNDUP_BY_4(packet->word_count[1]);
+			height = packet->packet_num[1];
+		}
+		writel(pitch, &(res->capture_reg->vdm.w_port[3].VDM_W_PITCH));
+		writel(height, &(res->capture_reg->vdm.w_port[3].VDM_W_HEIGHT));
+		start_addr = readl(&res->capture_reg->vdm.w_port[3].VDM_W_STADR);
+		end_addr = start_addr + pitch - 1U;
+		writel(end_addr, &(res->capture_reg->vdm.w_port[3].VDM_W_ENDADR));
+
+		/* Set CSI2 sync to Memory input mode for test data usecase */
+		writel(HWD_VIIF_MEM_SYNC_CSI2, &(res->capture_reg->sys.IPORTI_M_SYNCMODE));
+	}
+
+	if (voif_through == HWD_VIIF_ENABLE) {
+		/* Enable VOIF through input */
+		writel(voif_through, &(res->capture_reg->sys.CSI2THROUGHEN));
+	}
+
+	/* Control VC port enable */
+	val = enable_vc0 | (enable_vc1 << 4U);
+	writel(val, &(res->capture_reg->sys.VCPORTEN));
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
+ * hwd_VIIF_csi2rx_stop() - Stop CSI-2 input
+ *
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -ETIMEDOUT Driver timeout error
+ */
+int32_t hwd_VIIF_csi2rx_stop(uint32_t module_id)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t status_r, status_w, status_t, l2_status;
+	uint64_t timeout_ns, cur_ns;
+	bool run_flag = true;
+	int32_t ret = 0;
+
+	if ((res->ch != 0U) && (res->ch != 1U))
+		return -1;
+
+	/* Disable auto transmission of register buffer */
+	writel(0, &(res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF));
+	writel(0, &(res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF));
+
+	/* Wait for completion of register buffer transmission */
+	udelay(HWD_VIIF_WAIT_ISP_REGBF_TRNS_COMPLETE_TIME);
+
+	if (res->ch == 1U) {
+		/* Disable VOIF through input */
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.CSI2THROUGHEN));
+	}
+
+	/* Stop all VCs, long packet input and emb data input of MAIN unit */
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.VCPORTEN));
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.IPORTM_OTHEREN));
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.IPORTM_EMBEN));
+
+	/* Stop image data input, long packet input and emb data input of SUB unit */
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.IPORTS_OTHEREN));
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.IPORTS_EMBEN));
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->sys.IPORTS_IMGEN));
+
+	/* Stop VDMAC for all table ports, input ports and write ports */
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->vdm.VDM_T_ENABLE));
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->vdm.VDM_R_ENABLE));
+	writel(HWD_VIIF_DISABLE, &(res->capture_reg->vdm.VDM_W_ENABLE));
+
+	/* Stop all groups(g00, g01 and g02) of VDMAC */
+	writel(0x7, &(res->capture_reg->vdm.VDM_ABORTSET));
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
+		if ((status_r == 0U) && (status_w == 0U) && (status_t == 0U) && (l2_status == 0U))
+			run_flag = false;
+
+		cur_ns = ktime_get_ns();
+
+		if (cur_ns > timeout_ns) {
+			ret = -ETIMEDOUT;
+			run_flag = false;
+		}
+	} while (run_flag == true);
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
+ * hwd_VIIF_csi2rx_get_dphy_status() - Get CSI-2 RX D-PHY status
+ *
+ * @ulps: Pointer to ULPS information
+ * @stop: Pointer to STOP status information
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "ulps" or "stop" is NULL
+ */
+int32_t hwd_VIIF_csi2rx_get_dphy_status(uint32_t module_id, uint32_t *ulps, uint32_t *stop)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (ulps == NULL)
+		return -EINVAL;
+
+	if (stop == NULL)
+		return -EINVAL;
+
+	*ulps = readl(&res->csi2host_reg->CSI2RX_PHY_RX);
+	*stop = readl(&res->csi2host_reg->CSI2RX_PHY_STOPSTATE);
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_csi2rx_get_calibration_status() - Get CSI-2 RX calibration status
+ *
+ * @calibration_status: Pointer to D-PHY calibration status information
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "calibration_status" is NULL
+ */
+int32_t hwd_VIIF_csi2rx_get_calibration_status(
+	uint32_t module_id, struct hwd_viif_csi2rx_dphy_calibration_status *calibration_status)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (calibration_status == NULL)
+		return -EINVAL;
+
+	/* arg0; test register, arg1: error bit, arg2: done bit */
+	/* 0x221: termination calibration with REXT */
+	calibration_status->term_cal_with_rext =
+		hwd_VIIF_csi2rx_check_dphy_calibration_status(DIG_RD_RX_TERM_CAL_1, 0, 7, res);
+	/* 0x39D: clock lane offset calibration */
+	calibration_status->clock_lane_offset_cal = hwd_VIIF_csi2rx_check_dphy_calibration_status(
+		DIG_RD_RX_CLKLANE_OFFSET_CAL_0, 4, 0, res);
+	/* 0x59F: data lane0 offset calibration */
+	calibration_status->data_lane0_offset_cal = hwd_VIIF_csi2rx_check_dphy_calibration_status(
+		DIG_RD_RX_LANE0_OFFSET_CAL_0, 2, 1, res);
+	/* 0x79F: data lane1 offset calibration */
+	calibration_status->data_lane1_offset_cal = hwd_VIIF_csi2rx_check_dphy_calibration_status(
+		DIG_RD_RX_LANE1_OFFSET_CAL_0, 2, 1, res);
+	/* 0x5E0: data lane0 DDL(Digital Delay Line) calibration */
+	calibration_status->data_lane0_ddl_tuning_cal =
+		hwd_VIIF_csi2rx_check_dphy_calibration_status(DIG_RD_RX_LANE0_DDL_0, 1, 2, res);
+	/* 0x7E0: data lane1 DDL calibration */
+	calibration_status->data_lane1_ddl_tuning_cal =
+		hwd_VIIF_csi2rx_check_dphy_calibration_status(DIG_RD_RX_LANE1_DDL_0, 1, 2, res);
+
+	if (res->csi2rx_type == HWD_VIIF_CSI2_TYPE_4_LANES) {
+		/* 0x99F: data lane2 offset calibration */
+		calibration_status->data_lane2_offset_cal =
+			hwd_VIIF_csi2rx_check_dphy_calibration_status(DIG_RD_RX_LANE2_OFFSET_CAL_0,
+								      2, 1, res);
+		/* 0xB9F: data lane3 offset calibration */
+		calibration_status->data_lane3_offset_cal =
+			hwd_VIIF_csi2rx_check_dphy_calibration_status(DIG_RD_RX_LANE3_OFFSET_CAL_0,
+								      2, 1, res);
+		/* 0x9E0: data lane2 DDL calibration */
+		calibration_status->data_lane2_ddl_tuning_cal =
+			hwd_VIIF_csi2rx_check_dphy_calibration_status(DIG_RD_RX_LANE2_DDL_0, 1, 2,
+								      res);
+		/* 0xBE0: data lane3 DDL calibration */
+		calibration_status->data_lane3_ddl_tuning_cal =
+			hwd_VIIF_csi2rx_check_dphy_calibration_status(DIG_RD_RX_LANE3_DDL_0, 1, 2,
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
+ * hwd_VIIF_csi2rx_get_err_status() - Get CSI-2 RX error status
+ *
+ * @err_phy_fatal: Pointer to D-PHY fatal error information
+ * @err_pkt_fatal: Pointer to Packet fatal error information
+ * @err_frame_fatal: Pointer to Frame fatal error information
+ * @err_phy: Pointer to D-PHY error information
+ * @err_pkt: Pointer to Packet error information
+ * @err_line: Pointer to Line error information
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 Operation completes successfully
+ * Return: -EINVAL Parameter error
+ * - [1] "err_phy_fatal", "err_pkt_fatal", "err_frame_fatal", "err_phy", "err_pkt" or "err_line" is NULL
+ */
+int32_t hwd_VIIF_csi2rx_get_err_status(uint32_t module_id, uint32_t *err_phy_fatal,
+				       uint32_t *err_pkt_fatal, uint32_t *err_frame_fatal,
+				       uint32_t *err_phy, uint32_t *err_pkt, uint32_t *err_line)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if ((err_phy_fatal == NULL) || (err_pkt_fatal == NULL) || (err_frame_fatal == NULL) ||
+	    (err_phy == NULL) || (err_pkt == NULL) || (err_line == NULL)) {
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
index 000000000..567af65f8
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif_internal.h
@@ -0,0 +1,361 @@
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
+#define HWD_VIIF_ISP_MAX_REGBUF_NUM	(4U)
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
+#define HWD_VIIF_LSC_MAX_GAIN				 (4096U)
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
+#define HWD_VIIF_L1_CRGBF_R_START_ADDR_LIMIT		 (0x108CU)
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
+	uint32_t roi_num;
+	bool post_enable_flag[HWD_VIIF_MAX_POST_NUM];
+	uint32_t post_crop_x[HWD_VIIF_MAX_POST_NUM];
+	uint32_t post_crop_y[HWD_VIIF_MAX_POST_NUM];
+	uint32_t post_crop_w[HWD_VIIF_MAX_POST_NUM];
+	uint32_t post_crop_h[HWD_VIIF_MAX_POST_NUM];
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
+ * @interpolation_mode: input image interpolation mode @ref hwd_VIIF_l1_input_interpolation_mode 
+ * @input_num: the number of input images [1..3] 
+ * @hobc_size: sum of hobc_width and hobc_margin 
+ * @rawpack: RAW pack mode. For more refer @ref hwd_VIIF_raw_pack_mode 
+ * @color_type: Color type of MAIN unit 
+ * @l2_input: Input path of L2ISP 
+ * @dt_image_main_w_isp: Data type of image data for ISP path 
+ * @csi2host_reg: pointer to register access structure of CSI-2 RX host controller 
+ * @capture_reg: pointer to register access structure of capture unit 
+ * @l2_roi_path_info: ROI path information of L2ISP 
+ * @run_flag_main: run flag of MAIN unit(true: run, false: not run) 
+ * @other_csi2_flag: flag to indicate that packet is input from other channel 
+ */
+struct hwd_viif_res {
+	const uint32_t ch;
+	const uint32_t csi2rx_type;
+	const uint32_t sram_size_w_port;
+	const uint32_t sram_size_r_port;
+	const uint32_t sram_start_addr_gamma;
+	uint32_t pixel_clock;
+	uint32_t htotal_size;
+	uint32_t interpolation_mode;
+	uint32_t input_num;
+	uint32_t hobc_size;
+	uint32_t rawpack;
+	uint32_t color_type;
+	uint32_t l2_input;
+	uint32_t dt_image_main_w_isp;
+	struct hwd_viif_csi2host_reg *csi2host_reg;
+	struct hwd_viif_capture_reg *capture_reg;
+	struct hwd_viif_l2_roi_path_info l2_roi_path_info[HWD_VIIF_ISP_MAX_REGBUF_NUM];
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
+	uint32_t rate;
+	uint32_t hsfreqrange;
+	uint32_t osc_freq_target;
+};
+
+#endif /* HWD_VIIF_INTERNAL_H */
diff --git a/drivers/media/platform/visconti/hwd_viif_l1isp.c b/drivers/media/platform/visconti/hwd_viif_l1isp.c
new file mode 100644
index 000000000..495133720
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif_l1isp.c
@@ -0,0 +1,3769 @@
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
+ * hwd_VIIF_l1_set_input_mode() - Configure L1ISP input mode.
+ *
+ * @mode: L1ISP preprocessing mode @ref hwd_VIIF_l1_input_mode
+ * @depth: input color depth (even only)
+ * - [8..24] in case of mode = #HWD_VIIF_L1_INPUT_HDR or #HWD_VIIF_L1_INPUT_HDR_IMG_CORRECT
+ * - [8..14] in case of mode = #HWD_VIIF_L1_INPUT_PWL or #HWD_VIIF_L1_INPUT_PWL_IMG_CORRECT
+ * - [8..12] in case of mode = #HWD_VIIF_L1_INPUT_SDR
+ * @raw_color_filter: RAW color filter array @ref hwd_VIIF_l1_raw_color_filter_mode
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
+int32_t hwd_VIIF_l1_set_input_mode(uint32_t module_id, uint32_t mode, uint32_t depth,
+				   uint32_t raw_color_filter,
+				   const struct hwd_viif_l1_raw_input_order *interpolation_order)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val, input_num, depth_max;
+
+	if (mode >= HWD_VIIF_L1_INPUT_MODE_NUM)
+		return -EINVAL;
+
+	if (mode == HWD_VIIF_L1_INPUT_SDR) {
+		depth_max = HWD_VIIF_L1_INPUT_DEPTH_SDR_MAX;
+	} else if ((mode == HWD_VIIF_L1_INPUT_PWL) || (mode == HWD_VIIF_L1_INPUT_PWL_IMG_CORRECT)) {
+		depth_max = HWD_VIIF_L1_INPUT_DEPTH_PWL_MAX;
+	} else {
+		depth_max = HWD_VIIF_L1_INPUT_DEPTH_MAX;
+	}
+
+	if ((depth < HWD_VIIF_L1_INPUT_DEPTH_MIN) || (depth > depth_max))
+		return -EINVAL;
+
+	if ((depth % 2U) != 0U)
+		return -EINVAL;
+
+	if (raw_color_filter >= HWD_VIIF_L1_RAW_MODE_NUM)
+		return -EINVAL;
+
+	if ((mode != HWD_VIIF_L1_INPUT_SDR) && (interpolation_order != NULL))
+		return -EINVAL;
+
+	if (mode == HWD_VIIF_L1_INPUT_SDR) {
+		if (interpolation_order == NULL)
+			return -EINVAL;
+
+		/* check the range of high sensitivity and order of other images (middle, low) */
+		input_num = readl(&res->capture_reg->l1isp.L1_IBUF_INPUT_ORDER) & 0x3U;
+		if (interpolation_order->input_order_high > input_num) {
+			return -EINVAL;
+		} else if (interpolation_order->input_order_high ==
+			   interpolation_order->input_order_middle) {
+			return -EINVAL;
+		} else if (interpolation_order->input_order_high ==
+			   interpolation_order->input_order_low) {
+			return -EINVAL;
+		}
+
+		/* check the range of middle sensitivity and order of other image (low) */
+		if (interpolation_order->input_order_middle > input_num) {
+			return -EINVAL;
+		} else if (interpolation_order->input_order_middle ==
+			   interpolation_order->input_order_low) {
+			return -EINVAL;
+		}
+
+		/* check the range of low sensitivity */
+		if (interpolation_order->input_order_low > input_num)
+			return -EINVAL;
+	}
+
+	writel(mode, &(res->capture_reg->l1isp.L1_SYSM_INPUT_MODE));
+	writel(depth, &(res->capture_reg->l1isp.L1_IBUF_DEPTH));
+	writel(raw_color_filter, &(res->capture_reg->l1isp.L1_SYSM_START_COLOR));
+	if (mode == HWD_VIIF_L1_INPUT_SDR) {
+		val = readl(&res->capture_reg->l1isp.L1_IBUF_INPUT_ORDER) & 0xffff81ffU;
+		val |= (interpolation_order->input_order_high << 13U) |
+		       (interpolation_order->input_order_middle << 11U) |
+		       (interpolation_order->input_order_low << 9U);
+		writel(val, &(res->capture_reg->l1isp.L1_IBUF_INPUT_ORDER));
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_rgb_to_y_coef() - Configure L1ISP RGB coefficients to calculate Y.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
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
+int32_t hwd_VIIF_l1_set_rgb_to_y_coef(uint32_t module_id, uint32_t regbuf_id, uint16_t coef_r,
+				      uint16_t coef_g, uint16_t coef_b)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if ((coef_r < HWD_VIIF_L1_COEF_MIN) || (coef_r > HWD_VIIF_L1_COEF_MAX)) {
+		return -EINVAL;
+	}
+	if ((coef_g < HWD_VIIF_L1_COEF_MIN) || (coef_g > HWD_VIIF_L1_COEF_MAX)) {
+		return -EINVAL;
+	}
+	if ((coef_b < HWD_VIIF_L1_COEF_MIN) || (coef_b > HWD_VIIF_L1_COEF_MAX)) {
+		return -EINVAL;
+	}
+
+	writel((uint32_t)coef_r, &(res->capture_reg->l1isp.L1_SYSM_YCOEF_R));
+	writel((uint32_t)coef_g, &(res->capture_reg->l1isp.L1_SYSM_YCOEF_G));
+	writel((uint32_t)coef_b, &(res->capture_reg->l1isp.L1_SYSM_YCOEF_B));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_ag_mode() - Configure L1ISP AG mode.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @param: pointer to struct hwd_viif_l1_ag_mode
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param" is NULL
+ * - each member of "param" is invalid
+ */
+int32_t hwd_VIIF_l1_set_ag_mode(uint32_t module_id, uint32_t regbuf_id,
+				const struct hwd_viif_l1_ag_mode *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	uint32_t val;
+
+	if (param == NULL)
+		return -EINVAL;
+
+	if (param->sysm_ag_psel_hobc_high >= HWD_VIIF_L1_AG_ID_NUM)
+		return -EINVAL;
+
+	if (param->sysm_ag_psel_hobc_middle_led >= HWD_VIIF_L1_AG_ID_NUM)
+		return -EINVAL;
+
+	if (param->sysm_ag_psel_hobc_low >= HWD_VIIF_L1_AG_ID_NUM)
+		return -EINVAL;
+
+	if (param->sysm_ag_psel_abpc_high >= HWD_VIIF_L1_AG_ID_NUM)
+		return -EINVAL;
+
+	if (param->sysm_ag_psel_abpc_middle_led >= HWD_VIIF_L1_AG_ID_NUM)
+		return -EINVAL;
+
+	if (param->sysm_ag_psel_abpc_low >= HWD_VIIF_L1_AG_ID_NUM)
+		return -EINVAL;
+
+	if (param->sysm_ag_psel_rcnr_high >= HWD_VIIF_L1_AG_ID_NUM)
+		return -EINVAL;
+
+	if (param->sysm_ag_psel_rcnr_middle_led >= HWD_VIIF_L1_AG_ID_NUM)
+		return -EINVAL;
+
+	if (param->sysm_ag_psel_rcnr_low >= HWD_VIIF_L1_AG_ID_NUM)
+		return -EINVAL;
+
+	if (param->sysm_ag_ssel_lssc >= HWD_VIIF_L1_SENSITIVITY_IMAGE_NUM)
+		return -EINVAL;
+
+	if (param->sysm_ag_psel_lssc >= HWD_VIIF_L1_AG_ID_NUM)
+		return -EINVAL;
+
+	if (param->sysm_ag_ssel_mpro >= HWD_VIIF_L1_SENSITIVITY_IMAGE_NUM)
+		return -EINVAL;
+
+	if (param->sysm_ag_psel_mpro >= HWD_VIIF_L1_AG_ID_NUM)
+		return -EINVAL;
+
+	if (param->sysm_ag_ssel_vpro >= HWD_VIIF_L1_SENSITIVITY_IMAGE_NUM)
+		return -EINVAL;
+
+	if (param->sysm_ag_psel_vpro >= HWD_VIIF_L1_AG_ID_NUM)
+		return -EINVAL;
+
+	if ((param->sysm_ag_cont_hobc_en_high != HWD_VIIF_ENABLE) &&
+	    (param->sysm_ag_cont_hobc_en_high != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+	if ((param->sysm_ag_cont_hobc_en_middle_led != HWD_VIIF_ENABLE) &&
+	    (param->sysm_ag_cont_hobc_en_middle_led != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+	if ((param->sysm_ag_cont_hobc_en_low != HWD_VIIF_ENABLE) &&
+	    (param->sysm_ag_cont_hobc_en_low != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+
+	if ((param->sysm_ag_cont_rcnr_en_high != HWD_VIIF_ENABLE) &&
+	    (param->sysm_ag_cont_rcnr_en_high != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+	if ((param->sysm_ag_cont_rcnr_en_middle_led != HWD_VIIF_ENABLE) &&
+	    (param->sysm_ag_cont_rcnr_en_middle_led != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+	if ((param->sysm_ag_cont_rcnr_en_low != HWD_VIIF_ENABLE) &&
+	    (param->sysm_ag_cont_rcnr_en_low != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+
+	if ((param->sysm_ag_cont_lssc_en != HWD_VIIF_ENABLE) &&
+	    (param->sysm_ag_cont_lssc_en != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+
+	if ((param->sysm_ag_cont_mpro_en != HWD_VIIF_ENABLE) &&
+	    (param->sysm_ag_cont_mpro_en != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+
+	if ((param->sysm_ag_cont_vpro_en != HWD_VIIF_ENABLE) &&
+	    (param->sysm_ag_cont_vpro_en != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+
+	if ((param->sysm_ag_cont_abpc_en_middle_led != HWD_VIIF_ENABLE) &&
+	    (param->sysm_ag_cont_abpc_en_middle_led != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+
+	if ((param->sysm_ag_cont_abpc_en_high != HWD_VIIF_ENABLE) &&
+	    (param->sysm_ag_cont_abpc_en_high != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+
+	if ((param->sysm_ag_cont_abpc_en_low != HWD_VIIF_ENABLE) &&
+	    (param->sysm_ag_cont_abpc_en_low != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+
+	/* SYSM_AG_PARAM */
+	val = ((uint32_t)param->sysm_ag_grad[0] << 16U) | ((uint32_t)param->sysm_ag_ofst[0]);
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_PARAM_A));
+	val = ((uint32_t)param->sysm_ag_grad[1] << 16U) | ((uint32_t)param->sysm_ag_ofst[1]);
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_PARAM_B));
+	val = ((uint32_t)param->sysm_ag_grad[2] << 16U) | ((uint32_t)param->sysm_ag_ofst[2]);
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_PARAM_C));
+	val = ((uint32_t)param->sysm_ag_grad[3] << 16U) | ((uint32_t)param->sysm_ag_ofst[3]);
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_PARAM_D));
+
+	/* SYSM_AG_SEL */
+	val = ((uint32_t)param->sysm_ag_psel_hobc_high << 6U) |
+	      ((uint32_t)param->sysm_ag_psel_hobc_middle_led << 4U) |
+	      ((uint32_t)param->sysm_ag_psel_hobc_low << 2U);
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_SEL_HOBC));
+
+	val = ((uint32_t)param->sysm_ag_psel_abpc_high << 6U) |
+	      ((uint32_t)param->sysm_ag_psel_abpc_middle_led << 4U) |
+	      ((uint32_t)param->sysm_ag_psel_abpc_low << 2U);
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_SEL_ABPC));
+
+	val = ((uint32_t)param->sysm_ag_psel_rcnr_high << 6U) |
+	      ((uint32_t)param->sysm_ag_psel_rcnr_middle_led << 4U) |
+	      ((uint32_t)param->sysm_ag_psel_rcnr_low << 2U);
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_SEL_RCNR));
+
+	val = ((uint32_t)param->sysm_ag_ssel_lssc << 2U) | ((uint32_t)param->sysm_ag_psel_lssc);
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_SEL_LSSC));
+
+	val = ((uint32_t)param->sysm_ag_ssel_mpro << 2U) | ((uint32_t)param->sysm_ag_psel_mpro);
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_SEL_MPRO));
+
+	val = ((uint32_t)param->sysm_ag_ssel_vpro << 2U) | ((uint32_t)param->sysm_ag_psel_vpro);
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_SEL_VPRO));
+
+	/* SYSM_AG_CONT */
+	val = (param->sysm_ag_cont_hobc_en_middle_led << 24U) |
+	      ((uint32_t)(param->sysm_ag_cont_hobc_test_middle_led) << 16U) |
+	      (param->sysm_ag_cont_hobc_en_high << 8U) |
+	      (uint32_t)param->sysm_ag_cont_hobc_test_high;
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_CONT_HOBC01_EN));
+	val = (param->sysm_ag_cont_hobc_en_low << 8U) | (uint32_t)param->sysm_ag_cont_hobc_test_low;
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_CONT_HOBC2_EN));
+
+	val = (param->sysm_ag_cont_abpc_en_middle_led << 24U) |
+	      ((uint32_t)(param->sysm_ag_cont_abpc_test_middle_led) << 16U) |
+	      (param->sysm_ag_cont_abpc_en_high << 8U) |
+	      (uint32_t)param->sysm_ag_cont_abpc_test_high;
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_CONT_ABPC01_EN));
+	val = (param->sysm_ag_cont_abpc_en_low << 8U) | (uint32_t)param->sysm_ag_cont_abpc_test_low;
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_CONT_ABPC2_EN));
+
+	val = (param->sysm_ag_cont_rcnr_en_middle_led << 24U) |
+	      ((uint32_t)(param->sysm_ag_cont_rcnr_test_middle_led) << 16U) |
+	      (param->sysm_ag_cont_rcnr_en_high << 8U) |
+	      (uint32_t)param->sysm_ag_cont_rcnr_test_high;
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_CONT_RCNR01_EN));
+	val = (param->sysm_ag_cont_rcnr_en_low << 8U) | (uint32_t)param->sysm_ag_cont_rcnr_test_low;
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_CONT_RCNR2_EN));
+
+	val = (param->sysm_ag_cont_lssc_en << 8U) | (uint32_t)param->sysm_ag_cont_lssc_test;
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_CONT_LSSC_EN));
+
+	val = (param->sysm_ag_cont_mpro_en << 8U) | (uint32_t)param->sysm_ag_cont_mpro_test;
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_CONT_MPRO_EN));
+
+	val = (param->sysm_ag_cont_vpro_en << 8U) | (uint32_t)param->sysm_ag_cont_vpro_test;
+	writel(val, &(res->capture_reg->l1isp.L1_SYSM_AG_CONT_VPRO_EN));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_ag() - Configure L1ISP analog gain.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @gain_h: analog gain value for high sensitivity image [0..65535]
+ * @gain_m: analog gain value for middle sensitivity or led image [0..65535]
+ * @gain_l: analog gain value for low sensitivity image [0..65535]
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ */
+int32_t hwd_VIIF_l1_set_ag(uint32_t module_id, uint32_t regbuf_id, uint16_t gain_h, uint16_t gain_m,
+			   uint16_t gain_l)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	writel((uint32_t)gain_h, &(res->capture_reg->l1isp.L1_SYSM_AG_H));
+	writel((uint32_t)gain_m, &(res->capture_reg->l1isp.L1_SYSM_AG_M));
+	writel((uint32_t)gain_l, &(res->capture_reg->l1isp.L1_SYSM_AG_L));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_hdre() - Configure L1ISP HDR extension parameters.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @param: pointer to struct hwd_viif_l1_hdre
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param" is NULL
+ * - each member of "param" is invalid
+ */
+int32_t hwd_VIIF_l1_set_hdre(uint32_t module_id, uint32_t regbuf_id,
+			     const struct hwd_viif_l1_hdre *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t idx;
+
+	if (param == NULL)
+		return -EINVAL;
+
+	for (idx = 0; idx < 16U; idx++) {
+		if (param->hdre_src_point[idx] > HWD_VIIF_L1_HDRE_MAX_KNEEPOINT_VAL) {
+			return -EINVAL;
+		}
+	}
+
+	for (idx = 0; idx < 17U; idx++) {
+		if (param->hdre_dst_base[idx] > HWD_VIIF_L1_HDRE_MAX_HDRE_SIG_VAL) {
+			return -EINVAL;
+		}
+		if (param->hdre_ratio[idx] >= HWD_VIIF_L1_HDRE_MAX_OUT_PIXEL_RATIO) {
+			return -EINVAL;
+		}
+	}
+
+	if (param->hdre_dst_max_val > HWD_VIIF_L1_HDRE_MAX_OUT_PIXEL_VAL)
+		return -EINVAL;
+
+	writel(param->hdre_src_point[0], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint00));
+	writel(param->hdre_src_point[1], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint01));
+	writel(param->hdre_src_point[2], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint02));
+	writel(param->hdre_src_point[3], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint03));
+	writel(param->hdre_src_point[4], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint04));
+	writel(param->hdre_src_point[5], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint05));
+	writel(param->hdre_src_point[6], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint06));
+	writel(param->hdre_src_point[7], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint07));
+	writel(param->hdre_src_point[8], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint08));
+	writel(param->hdre_src_point[9], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint09));
+	writel(param->hdre_src_point[10], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint10));
+	writel(param->hdre_src_point[11], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint11));
+	writel(param->hdre_src_point[12], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint12));
+	writel(param->hdre_src_point[13], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint13));
+	writel(param->hdre_src_point[14], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint14));
+	writel(param->hdre_src_point[15], &(res->capture_reg->l1isp.L1_HDRE_SrcPoint15));
+
+	writel(0, &(res->capture_reg->l1isp.L1_HDRE_SrcBase00));
+	writel(param->hdre_src_point[0], &(res->capture_reg->l1isp.L1_HDRE_SrcBase01));
+	writel(param->hdre_src_point[1], &(res->capture_reg->l1isp.L1_HDRE_SrcBase02));
+	writel(param->hdre_src_point[2], &(res->capture_reg->l1isp.L1_HDRE_SrcBase03));
+	writel(param->hdre_src_point[3], &(res->capture_reg->l1isp.L1_HDRE_SrcBase04));
+	writel(param->hdre_src_point[4], &(res->capture_reg->l1isp.L1_HDRE_SrcBase05));
+	writel(param->hdre_src_point[5], &(res->capture_reg->l1isp.L1_HDRE_SrcBase06));
+	writel(param->hdre_src_point[6], &(res->capture_reg->l1isp.L1_HDRE_SrcBase07));
+	writel(param->hdre_src_point[7], &(res->capture_reg->l1isp.L1_HDRE_SrcBase08));
+	writel(param->hdre_src_point[8], &(res->capture_reg->l1isp.L1_HDRE_SrcBase09));
+	writel(param->hdre_src_point[9], &(res->capture_reg->l1isp.L1_HDRE_SrcBase10));
+	writel(param->hdre_src_point[10], &(res->capture_reg->l1isp.L1_HDRE_SrcBase11));
+	writel(param->hdre_src_point[11], &(res->capture_reg->l1isp.L1_HDRE_SrcBase12));
+	writel(param->hdre_src_point[12], &(res->capture_reg->l1isp.L1_HDRE_SrcBase13));
+	writel(param->hdre_src_point[13], &(res->capture_reg->l1isp.L1_HDRE_SrcBase14));
+	writel(param->hdre_src_point[14], &(res->capture_reg->l1isp.L1_HDRE_SrcBase15));
+	writel(param->hdre_src_point[15], &(res->capture_reg->l1isp.L1_HDRE_SrcBase16));
+
+	writel(param->hdre_dst_base[0], &(res->capture_reg->l1isp.L1_HDRE_DstBase00));
+	writel(param->hdre_dst_base[1], &(res->capture_reg->l1isp.L1_HDRE_DstBase01));
+	writel(param->hdre_dst_base[2], &(res->capture_reg->l1isp.L1_HDRE_DstBase02));
+	writel(param->hdre_dst_base[3], &(res->capture_reg->l1isp.L1_HDRE_DstBase03));
+	writel(param->hdre_dst_base[4], &(res->capture_reg->l1isp.L1_HDRE_DstBase04));
+	writel(param->hdre_dst_base[5], &(res->capture_reg->l1isp.L1_HDRE_DstBase05));
+	writel(param->hdre_dst_base[6], &(res->capture_reg->l1isp.L1_HDRE_DstBase06));
+	writel(param->hdre_dst_base[7], &(res->capture_reg->l1isp.L1_HDRE_DstBase07));
+	writel(param->hdre_dst_base[8], &(res->capture_reg->l1isp.L1_HDRE_DstBase08));
+	writel(param->hdre_dst_base[9], &(res->capture_reg->l1isp.L1_HDRE_DstBase09));
+	writel(param->hdre_dst_base[10], &(res->capture_reg->l1isp.L1_HDRE_DstBase10));
+	writel(param->hdre_dst_base[11], &(res->capture_reg->l1isp.L1_HDRE_DstBase11));
+	writel(param->hdre_dst_base[12], &(res->capture_reg->l1isp.L1_HDRE_DstBase12));
+	writel(param->hdre_dst_base[13], &(res->capture_reg->l1isp.L1_HDRE_DstBase13));
+	writel(param->hdre_dst_base[14], &(res->capture_reg->l1isp.L1_HDRE_DstBase14));
+	writel(param->hdre_dst_base[15], &(res->capture_reg->l1isp.L1_HDRE_DstBase15));
+	writel(param->hdre_dst_base[16], &(res->capture_reg->l1isp.L1_HDRE_DstBase16));
+
+	writel(param->hdre_ratio[0], &(res->capture_reg->l1isp.L1_HDRE_Ratio00));
+	writel(param->hdre_ratio[1], &(res->capture_reg->l1isp.L1_HDRE_Ratio01));
+	writel(param->hdre_ratio[2], &(res->capture_reg->l1isp.L1_HDRE_Ratio02));
+	writel(param->hdre_ratio[3], &(res->capture_reg->l1isp.L1_HDRE_Ratio03));
+	writel(param->hdre_ratio[4], &(res->capture_reg->l1isp.L1_HDRE_Ratio04));
+	writel(param->hdre_ratio[5], &(res->capture_reg->l1isp.L1_HDRE_Ratio05));
+	writel(param->hdre_ratio[6], &(res->capture_reg->l1isp.L1_HDRE_Ratio06));
+	writel(param->hdre_ratio[7], &(res->capture_reg->l1isp.L1_HDRE_Ratio07));
+	writel(param->hdre_ratio[8], &(res->capture_reg->l1isp.L1_HDRE_Ratio08));
+	writel(param->hdre_ratio[9], &(res->capture_reg->l1isp.L1_HDRE_Ratio09));
+	writel(param->hdre_ratio[10], &(res->capture_reg->l1isp.L1_HDRE_Ratio10));
+	writel(param->hdre_ratio[11], &(res->capture_reg->l1isp.L1_HDRE_Ratio11));
+	writel(param->hdre_ratio[12], &(res->capture_reg->l1isp.L1_HDRE_Ratio12));
+	writel(param->hdre_ratio[13], &(res->capture_reg->l1isp.L1_HDRE_Ratio13));
+	writel(param->hdre_ratio[14], &(res->capture_reg->l1isp.L1_HDRE_Ratio14));
+	writel(param->hdre_ratio[15], &(res->capture_reg->l1isp.L1_HDRE_Ratio15));
+	writel(param->hdre_ratio[16], &(res->capture_reg->l1isp.L1_HDRE_Ratio16));
+
+	writel(param->hdre_dst_max_val, &(res->capture_reg->l1isp.L1_HDRE_DstMaxval));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_img_extraction() - Configure L1ISP image extraction parameters.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
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
+int32_t hwd_VIIF_l1_set_img_extraction(uint32_t module_id, uint32_t regbuf_id,
+				       uint32_t input_black_gr, uint32_t input_black_r,
+				       uint32_t input_black_b, uint32_t input_black_gb)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (input_black_gr > HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL)
+		return -EINVAL;
+
+	if (input_black_r > HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL)
+		return -EINVAL;
+
+	if (input_black_b > HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL)
+		return -EINVAL;
+
+	if (input_black_gb > HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL)
+		return -EINVAL;
+
+	writel(input_black_gr, &(res->capture_reg->l1isp.L1_SLIC_SrcBlackLevelGr));
+	writel(input_black_r, &(res->capture_reg->l1isp.L1_SLIC_SrcBlackLevelR));
+	writel(input_black_b, &(res->capture_reg->l1isp.L1_SLIC_SrcBlackLevelB));
+	writel(input_black_gb, &(res->capture_reg->l1isp.L1_SLIC_SrcBlackLevelGb));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_dpc() - Configure L1ISP defect pixel correction parameters.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
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
+int32_t hwd_VIIF_l1_set_dpc(uint32_t module_id, uint32_t regbuf_id,
+			    const struct hwd_viif_l1_dpc *param_h,
+			    const struct hwd_viif_l1_dpc *param_m,
+			    const struct hwd_viif_l1_dpc *param_l)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	const struct hwd_viif_l1_dpc *param;
+	uint32_t idx;
+	uint32_t val;
+
+	if ((param_h == NULL) && (param_m == NULL) && (param_l == NULL))
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
+		if (param != NULL) {
+			if ((param->abpc_sta_en != HWD_VIIF_ENABLE) &&
+			    (param->abpc_sta_en != HWD_VIIF_DISABLE)) {
+				return -EINVAL;
+			}
+
+			if ((param->abpc_dyn_en != HWD_VIIF_ENABLE) &&
+			    (param->abpc_dyn_en != HWD_VIIF_DISABLE)) {
+				return -EINVAL;
+			}
+
+			if (param->abpc_dyn_en == HWD_VIIF_ENABLE) {
+				if ((param->abpc_dyn_mode != HWD_VIIF_L1_DPC_1PIXEL) &&
+				    (param->abpc_dyn_mode != HWD_VIIF_L1_DPC_2PIXEL)) {
+					return -EINVAL;
+				}
+				if (param->abpc_ratio_limit > HWD_VIIF_L1_DPC_MAX_RATIO_LIMIT_VAL) {
+					return -EINVAL;
+				}
+				if (param->abpc_dark_limit > HWD_VIIF_L1_DPC_MAX_RATIO_LIMIT_VAL) {
+					return -EINVAL;
+				}
+				if ((param->abpc_sn_coef_w_ag_min <
+				     HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL) ||
+				    (param->abpc_sn_coef_w_ag_min >
+				     HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL)) {
+					return -EINVAL;
+				}
+				if ((param->abpc_sn_coef_w_ag_mid <
+				     HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL) ||
+				    (param->abpc_sn_coef_w_ag_mid >
+				     HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL)) {
+					return -EINVAL;
+				}
+				if ((param->abpc_sn_coef_w_ag_max <
+				     HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL) ||
+				    (param->abpc_sn_coef_w_ag_max >
+				     HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL)) {
+					return -EINVAL;
+				}
+				if ((param->abpc_sn_coef_b_ag_min <
+				     HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL) ||
+				    (param->abpc_sn_coef_b_ag_min >
+				     HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL)) {
+					return -EINVAL;
+				}
+				if ((param->abpc_sn_coef_b_ag_mid <
+				     HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL) ||
+				    (param->abpc_sn_coef_b_ag_mid >
+				     HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL)) {
+					return -EINVAL;
+				}
+				if ((param->abpc_sn_coef_b_ag_max <
+				     HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL) ||
+				    (param->abpc_sn_coef_b_ag_max >
+				     HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL)) {
+					return -EINVAL;
+				}
+				if (param->abpc_sn_coef_w_th_min >= param->abpc_sn_coef_w_th_max) {
+					return -EINVAL;
+				}
+				if (param->abpc_sn_coef_b_th_min >= param->abpc_sn_coef_b_th_max) {
+					return -EINVAL;
+				}
+			}
+		}
+	}
+
+	val = 0;
+	if (param_h != NULL)
+		val |= param_h->abpc_sta_en << 24U;
+
+	if (param_m != NULL)
+		val |= param_m->abpc_sta_en << 16U;
+
+	if (param_l != NULL)
+		val |= param_l->abpc_sta_en << 8U;
+
+	writel(val, &(res->capture_reg->l1isp.L1_ABPC012_STA_EN));
+
+	val = 0;
+	if (param_h != NULL)
+		val |= param_h->abpc_dyn_en << 24U;
+
+	if (param_m != NULL)
+		val |= param_m->abpc_dyn_en << 16U;
+
+	if (param_l != NULL)
+		val |= param_l->abpc_dyn_en << 8U;
+
+	writel(val, &(res->capture_reg->l1isp.L1_ABPC012_DYN_EN));
+
+	val = 0;
+	if (param_h != NULL)
+		val |= param_h->abpc_dyn_mode << 24U;
+
+	if (param_m != NULL)
+		val |= param_m->abpc_dyn_mode << 16U;
+
+	if (param_l != NULL)
+		val |= param_l->abpc_dyn_mode << 8U;
+
+	writel(val, &(res->capture_reg->l1isp.L1_ABPC012_DYN_MODE));
+
+	if (param_h != NULL) {
+		writel(param_h->abpc_ratio_limit, &(res->capture_reg->l1isp.L1_ABPC0_RATIO_LIMIT));
+		writel(param_h->abpc_dark_limit, &(res->capture_reg->l1isp.L1_ABPC0_DARK_LIMIT));
+		writel(param_h->abpc_sn_coef_w_ag_min,
+		       &(res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_AG_MIN));
+		writel(param_h->abpc_sn_coef_w_ag_mid,
+		       &(res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_AG_MID));
+		writel(param_h->abpc_sn_coef_w_ag_max,
+		       &(res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_AG_MAX));
+		writel(param_h->abpc_sn_coef_b_ag_min,
+		       &(res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_AG_MIN));
+		writel(param_h->abpc_sn_coef_b_ag_mid,
+		       &(res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_AG_MID));
+		writel(param_h->abpc_sn_coef_b_ag_max,
+		       &(res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_AG_MAX));
+		writel((uint32_t)param_h->abpc_sn_coef_w_th_min,
+		       &(res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_TH_MIN));
+		writel((uint32_t)param_h->abpc_sn_coef_w_th_max,
+		       &(res->capture_reg->l1isp.L1_ABPC0_SN_COEF_W_TH_MAX));
+		writel((uint32_t)param_h->abpc_sn_coef_b_th_min,
+		       &(res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_TH_MIN));
+		writel((uint32_t)param_h->abpc_sn_coef_b_th_max,
+		       &(res->capture_reg->l1isp.L1_ABPC0_SN_COEF_B_TH_MAX));
+	}
+
+	if (param_m != NULL) {
+		writel(param_m->abpc_ratio_limit, &(res->capture_reg->l1isp.L1_ABPC1_RATIO_LIMIT));
+		writel(param_m->abpc_dark_limit, &(res->capture_reg->l1isp.L1_ABPC1_DARK_LIMIT));
+		writel(param_m->abpc_sn_coef_w_ag_min,
+		       &(res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_AG_MIN));
+		writel(param_m->abpc_sn_coef_w_ag_mid,
+		       &(res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_AG_MID));
+		writel(param_m->abpc_sn_coef_w_ag_max,
+		       &(res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_AG_MAX));
+		writel(param_m->abpc_sn_coef_b_ag_min,
+		       &(res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_AG_MIN));
+		writel(param_m->abpc_sn_coef_b_ag_mid,
+		       &(res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_AG_MID));
+		writel(param_m->abpc_sn_coef_b_ag_max,
+		       &(res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_AG_MAX));
+		writel((uint32_t)param_m->abpc_sn_coef_w_th_min,
+		       &(res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_TH_MIN));
+		writel((uint32_t)param_m->abpc_sn_coef_w_th_max,
+		       &(res->capture_reg->l1isp.L1_ABPC1_SN_COEF_W_TH_MAX));
+		writel((uint32_t)param_m->abpc_sn_coef_b_th_min,
+		       &(res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_TH_MIN));
+		writel((uint32_t)param_m->abpc_sn_coef_b_th_max,
+		       &(res->capture_reg->l1isp.L1_ABPC1_SN_COEF_B_TH_MAX));
+	}
+
+	if (param_l != NULL) {
+		writel(param_l->abpc_ratio_limit, &(res->capture_reg->l1isp.L1_ABPC2_RATIO_LIMIT));
+		writel(param_l->abpc_dark_limit, &(res->capture_reg->l1isp.L1_ABPC2_DARK_LIMIT));
+		writel(param_l->abpc_sn_coef_w_ag_min,
+		       &(res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_AG_MIN));
+		writel(param_l->abpc_sn_coef_w_ag_mid,
+		       &(res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_AG_MID));
+		writel(param_l->abpc_sn_coef_w_ag_max,
+		       &(res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_AG_MAX));
+		writel(param_l->abpc_sn_coef_b_ag_min,
+		       &(res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_AG_MIN));
+		writel(param_l->abpc_sn_coef_b_ag_mid,
+		       &(res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_AG_MID));
+		writel(param_l->abpc_sn_coef_b_ag_max,
+		       &(res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_AG_MAX));
+		writel((uint32_t)param_l->abpc_sn_coef_w_th_min,
+		       &(res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_TH_MIN));
+		writel((uint32_t)param_l->abpc_sn_coef_w_th_max,
+		       &(res->capture_reg->l1isp.L1_ABPC2_SN_COEF_W_TH_MAX));
+		writel((uint32_t)param_l->abpc_sn_coef_b_th_min,
+		       &(res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_TH_MIN));
+		writel((uint32_t)param_l->abpc_sn_coef_b_th_max,
+		       &(res->capture_reg->l1isp.L1_ABPC2_SN_COEF_B_TH_MAX));
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_dpc_table_transmission() - Configure L1ISP transferring defect pixel correction table.
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
+int32_t hwd_VIIF_l1_set_dpc_table_transmission(uint32_t module_id, uintptr_t table_h,
+					       uintptr_t table_m, uintptr_t table_l)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val = 0x0U;
+
+	if (((table_h % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_m % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_l % HWD_VIIF_L1_VDM_ALIGN) != 0U)) {
+		return -EINVAL;
+	}
+
+	/* VDM common settings */
+
+	writel(HWD_VIIF_L1_VDM_CFG_PARAM, &(res->capture_reg->vdm.t_group[0].VDM_T_CFG));
+	writel(HWD_VIIF_L1_VDM_SRAM_BASE, &(res->capture_reg->vdm.t_group[0].VDM_T_SRAM_BASE));
+	writel(HWD_VIIF_L1_VDM_SRAM_SIZE, &(res->capture_reg->vdm.t_group[0].VDM_T_SRAM_SIZE));
+
+	if (table_h != 0U) {
+		writel((uint32_t)table_h, &(res->capture_reg->vdm.t_port[0].VDM_T_STADR));
+		writel(HWD_VIIF_L1_VDM_DPC_TABLE_SIZE,
+		       &(res->capture_reg->vdm.t_port[0].VDM_T_SIZE));
+		val |= 0x1U;
+	}
+
+	if (table_m != 0U) {
+		writel((uint32_t)table_m, &(res->capture_reg->vdm.t_port[1].VDM_T_STADR));
+		writel(HWD_VIIF_L1_VDM_DPC_TABLE_SIZE,
+		       &(res->capture_reg->vdm.t_port[1].VDM_T_SIZE));
+		val |= 0x2U;
+	}
+
+	if (table_l != 0U) {
+		writel((uint32_t)table_l, &(res->capture_reg->vdm.t_port[2].VDM_T_STADR));
+		writel(HWD_VIIF_L1_VDM_DPC_TABLE_SIZE,
+		       &(res->capture_reg->vdm.t_port[2].VDM_T_SIZE));
+		val |= 0x4U;
+	}
+
+	val |= (readl(&res->capture_reg->vdm.VDM_T_ENABLE) & 0xfffffff8U);
+	writel(val, &(res->capture_reg->vdm.VDM_T_ENABLE));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_preset_white_balance() - Configure L1ISP preset white balance parameters.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
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
+int32_t hwd_VIIF_l1_set_preset_white_balance(uint32_t module_id, uint32_t regbuf_id,
+					     uint32_t dstmaxval,
+					     const struct hwd_viif_l1_preset_white_balance *param_h,
+					     const struct hwd_viif_l1_preset_white_balance *param_m,
+					     const struct hwd_viif_l1_preset_white_balance *param_l)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (dstmaxval > HWD_VIIF_L1_PWHB_MAX_OUT_PIXEL_VAL)
+		return -EINVAL;
+
+	if ((param_h == NULL) && (param_m == NULL) && (param_l == NULL))
+		return -EINVAL;
+
+	if (param_h != NULL) {
+		if (param_h->gain_gr >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL)
+			return -EINVAL;
+
+		if (param_h->gain_r >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL)
+			return -EINVAL;
+
+		if (param_h->gain_b >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL)
+			return -EINVAL;
+
+		if (param_h->gain_gb >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL)
+			return -EINVAL;
+	}
+
+	if (param_m != NULL) {
+		if (param_m->gain_gr >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL)
+			return -EINVAL;
+
+		if (param_m->gain_r >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL)
+			return -EINVAL;
+
+		if (param_m->gain_b >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL)
+			return -EINVAL;
+
+		if (param_m->gain_gb >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL)
+			return -EINVAL;
+	}
+
+	if (param_l != NULL) {
+		if (param_l->gain_gr >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL)
+			return -EINVAL;
+
+		if (param_l->gain_r >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL)
+			return -EINVAL;
+
+		if (param_l->gain_b >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL)
+			return -EINVAL;
+
+		if (param_l->gain_gb >= HWD_VIIF_L1_PWHB_MAX_GAIN_VAL)
+			return -EINVAL;
+	}
+
+	writel(dstmaxval, &(res->capture_reg->l1isp.L1_PWHB_DstMaxval));
+
+	if (param_h != NULL) {
+		writel(param_h->gain_gr, &(res->capture_reg->l1isp.L1_PWHB_HGr));
+		writel(param_h->gain_r, &(res->capture_reg->l1isp.L1_PWHB_HR));
+		writel(param_h->gain_b, &(res->capture_reg->l1isp.L1_PWHB_HB));
+		writel(param_h->gain_gb, &(res->capture_reg->l1isp.L1_PWHB_HGb));
+	}
+
+	if (param_m != NULL) {
+		writel(param_m->gain_gr, &(res->capture_reg->l1isp.L1_PWHB_MGr));
+		writel(param_m->gain_r, &(res->capture_reg->l1isp.L1_PWHB_MR));
+		writel(param_m->gain_b, &(res->capture_reg->l1isp.L1_PWHB_MB));
+		writel(param_m->gain_gb, &(res->capture_reg->l1isp.L1_PWHB_MGb));
+	}
+
+	if (param_l != NULL) {
+		writel(param_l->gain_gr, &(res->capture_reg->l1isp.L1_PWHB_LGr));
+		writel(param_l->gain_r, &(res->capture_reg->l1isp.L1_PWHB_LR));
+		writel(param_l->gain_b, &(res->capture_reg->l1isp.L1_PWHB_LB));
+		writel(param_l->gain_gb, &(res->capture_reg->l1isp.L1_PWHB_LGb));
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_raw_color_noise_reduction() - Configure L1ISP raw color noise reduction parameters.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
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
+int32_t hwd_VIIF_l1_set_raw_color_noise_reduction(
+	uint32_t module_id, uint32_t regbuf_id,
+	const struct hwd_viif_l1_raw_color_noise_reduction *param_h,
+	const struct hwd_viif_l1_raw_color_noise_reduction *param_m,
+	const struct hwd_viif_l1_raw_color_noise_reduction *param_l)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	int32_t ret = 0;
+	const struct hwd_viif_l1_raw_color_noise_reduction *param;
+	uint32_t idx;
+
+	if ((param_h == NULL) && (param_m == NULL) && (param_l == NULL))
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
+		if (param != NULL) {
+			if ((param->rcnr_sw != HWD_VIIF_ENABLE) &&
+			    (param->rcnr_sw != HWD_VIIF_DISABLE)) {
+				return -EINVAL;
+			}
+
+			if (param->rcnr_cnf_dark_ag0 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL) {
+				return -EINVAL;
+			}
+			if (param->rcnr_cnf_dark_ag1 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL) {
+				return -EINVAL;
+			}
+			if (param->rcnr_cnf_dark_ag2 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL) {
+				return -EINVAL;
+			}
+
+			if (param->rcnr_cnf_ratio_ag0 >
+			    HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL) {
+				return -EINVAL;
+			}
+			if (param->rcnr_cnf_ratio_ag1 >
+			    HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL) {
+				return -EINVAL;
+			}
+			if (param->rcnr_cnf_ratio_ag2 >
+			    HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL) {
+				return -EINVAL;
+			}
+
+			if (param->rcnr_cnf_clip_gain_r >
+			    HWD_VIIF_L1_RCNR_MAX_ADJUSTMENT_GAIN_VAL) {
+				return -EINVAL;
+			}
+			if (param->rcnr_cnf_clip_gain_g >
+			    HWD_VIIF_L1_RCNR_MAX_ADJUSTMENT_GAIN_VAL) {
+				return -EINVAL;
+			}
+			if (param->rcnr_cnf_clip_gain_b >
+			    HWD_VIIF_L1_RCNR_MAX_ADJUSTMENT_GAIN_VAL) {
+				return -EINVAL;
+			}
+
+			if (param->rcnr_a1l_dark_ag0 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL) {
+				return -EINVAL;
+			}
+			if (param->rcnr_a1l_dark_ag1 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL) {
+				return -EINVAL;
+			}
+			if (param->rcnr_a1l_dark_ag2 > HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL) {
+				return -EINVAL;
+			}
+
+			if (param->rcnr_a1l_ratio_ag0 >
+			    HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL) {
+				return -EINVAL;
+			}
+			if (param->rcnr_a1l_ratio_ag1 >
+			    HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL) {
+				return -EINVAL;
+			}
+			if (param->rcnr_a1l_ratio_ag2 >
+			    HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL) {
+				return -EINVAL;
+			}
+
+			if (param->rcnr_inf_zero_clip > HWD_VIIF_L1_RCNR_MAX_ZERO_CLIP_VAL) {
+				return -EINVAL;
+			}
+
+			if (param->rcnr_merge_d2blend_ag0 > HWD_VIIF_L1_RCNR_MAX_BLEND_VAL) {
+				return -EINVAL;
+			}
+			if (param->rcnr_merge_d2blend_ag1 > HWD_VIIF_L1_RCNR_MAX_BLEND_VAL) {
+				return -EINVAL;
+			}
+			if (param->rcnr_merge_d2blend_ag2 > HWD_VIIF_L1_RCNR_MAX_BLEND_VAL) {
+				return -EINVAL;
+			}
+
+			if (param->rcnr_merge_black > HWD_VIIF_L1_RCNR_MAX_BLACK_LEVEL_VAL) {
+				return -EINVAL;
+			}
+
+			if ((param->rcnr_merge_mindiv < HWD_VIIF_L1_RCNR_MIN_0DIV_GUARD_VAL) ||
+			    (param->rcnr_merge_mindiv > HWD_VIIF_L1_RCNR_MAX_0DIV_GUARD_VAL)) {
+				return -EINVAL;
+			}
+
+			switch (param->rcnr_hry_type) {
+			case HWD_VIIF_L1_RCNR_LOW_RESOLUTION:
+			case HWD_VIIF_L1_RCNR_MIDDLE_RESOLUTION:
+			case HWD_VIIF_L1_RCNR_HIGH_RESOLUTION:
+			case HWD_VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION:
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
+
+			if (ret != 0)
+				return ret;
+
+			if ((param->rcnr_anf_blend_ag0 != HWD_VIIF_L1_MSF_BLEND_RATIO_0_DIV_64) &&
+			    (param->rcnr_anf_blend_ag0 != HWD_VIIF_L1_MSF_BLEND_RATIO_1_DIV_64) &&
+			    (param->rcnr_anf_blend_ag0 != HWD_VIIF_L1_MSF_BLEND_RATIO_2_DIV_64)) {
+				return -EINVAL;
+			}
+			if ((param->rcnr_anf_blend_ag1 != HWD_VIIF_L1_MSF_BLEND_RATIO_0_DIV_64) &&
+			    (param->rcnr_anf_blend_ag1 != HWD_VIIF_L1_MSF_BLEND_RATIO_1_DIV_64) &&
+			    (param->rcnr_anf_blend_ag1 != HWD_VIIF_L1_MSF_BLEND_RATIO_2_DIV_64)) {
+				return -EINVAL;
+			}
+			if ((param->rcnr_anf_blend_ag2 != HWD_VIIF_L1_MSF_BLEND_RATIO_0_DIV_64) &&
+			    (param->rcnr_anf_blend_ag2 != HWD_VIIF_L1_MSF_BLEND_RATIO_1_DIV_64) &&
+			    (param->rcnr_anf_blend_ag2 != HWD_VIIF_L1_MSF_BLEND_RATIO_2_DIV_64)) {
+				return -EINVAL;
+			}
+
+			if (param->rcnr_lpf_threshold >=
+			    HWD_VIIF_L1_RCNR_MAX_CALC_MSF_NOISE_MULTI_VAL) {
+				return -EINVAL;
+			}
+
+			if (param->rcnr_merge_hlblend_ag0 >
+			    HWD_VIIF_L1_RCNR_MAX_GEN_LUMA_SIG_BLEND_VAL) {
+				return -EINVAL;
+			}
+			if (param->rcnr_merge_hlblend_ag1 >
+			    HWD_VIIF_L1_RCNR_MAX_GEN_LUMA_SIG_BLEND_VAL) {
+				return -EINVAL;
+			}
+			if (param->rcnr_merge_hlblend_ag2 >
+			    HWD_VIIF_L1_RCNR_MAX_GEN_LUMA_SIG_BLEND_VAL) {
+				return -EINVAL;
+			}
+
+			if ((param->rcnr_gnr_sw != HWD_VIIF_DISABLE) &&
+			    (param->rcnr_gnr_sw != HWD_VIIF_ENABLE)) {
+				return -EINVAL;
+			}
+
+			if (param->rcnr_gnr_sw == HWD_VIIF_ENABLE) {
+				if (param->rcnr_gnr_ratio >
+				    HWD_VIIF_L1_RCNR_MAX_UP_LIMIT_GRGB_SENS_RATIO) {
+					return -EINVAL;
+				}
+				if ((param->rcnr_gnr_wide_en != HWD_VIIF_DISABLE) &&
+				    (param->rcnr_gnr_wide_en != HWD_VIIF_ENABLE)) {
+					return -EINVAL;
+				}
+			}
+		}
+	}
+
+	if (param_h != NULL) {
+		writel(param_h->rcnr_sw, &(res->capture_reg->l1isp.L1_RCNR0_SW));
+
+		writel(param_h->rcnr_cnf_dark_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR0_CNF_DARK_AG0));
+		writel(param_h->rcnr_cnf_dark_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR0_CNF_DARK_AG1));
+		writel(param_h->rcnr_cnf_dark_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR0_CNF_DARK_AG2));
+
+		writel(param_h->rcnr_cnf_ratio_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR0_CNF_RATIO_AG0));
+		writel(param_h->rcnr_cnf_ratio_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR0_CNF_RATIO_AG1));
+		writel(param_h->rcnr_cnf_ratio_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR0_CNF_RATIO_AG2));
+
+		writel(param_h->rcnr_cnf_clip_gain_r,
+		       &(res->capture_reg->l1isp.L1_RCNR0_CNF_CLIP_GAIN_R));
+		writel(param_h->rcnr_cnf_clip_gain_g,
+		       &(res->capture_reg->l1isp.L1_RCNR0_CNF_CLIP_GAIN_G));
+		writel(param_h->rcnr_cnf_clip_gain_b,
+		       &(res->capture_reg->l1isp.L1_RCNR0_CNF_CLIP_GAIN_B));
+
+		writel(param_h->rcnr_a1l_dark_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR0_A1L_DARK_AG0));
+		writel(param_h->rcnr_a1l_dark_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR0_A1L_DARK_AG1));
+		writel(param_h->rcnr_a1l_dark_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR0_A1L_DARK_AG2));
+
+		writel(param_h->rcnr_a1l_ratio_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR0_A1L_RATIO_AG0));
+		writel(param_h->rcnr_a1l_ratio_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR0_A1L_RATIO_AG1));
+		writel(param_h->rcnr_a1l_ratio_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR0_A1L_RATIO_AG2));
+
+		writel(param_h->rcnr_inf_zero_clip,
+		       &(res->capture_reg->l1isp.L1_RCNR0_INF_ZERO_CLIP));
+
+		writel(param_h->rcnr_merge_d2blend_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR0_MERGE_D2BLEND_AG0));
+		writel(param_h->rcnr_merge_d2blend_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR0_MERGE_D2BLEND_AG1));
+		writel(param_h->rcnr_merge_d2blend_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR0_MERGE_D2BLEND_AG2));
+		writel(param_h->rcnr_merge_black, &(res->capture_reg->l1isp.L1_RCNR0_MERGE_BLACK));
+		writel(param_h->rcnr_merge_mindiv,
+		       &(res->capture_reg->l1isp.L1_RCNR0_MERGE_MINDIV));
+
+		writel(param_h->rcnr_hry_type, &(res->capture_reg->l1isp.L1_RCNR0_HRY_TYPE));
+
+		writel(param_h->rcnr_anf_blend_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR0_ANF_BLEND_AG0));
+		writel(param_h->rcnr_anf_blend_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR0_ANF_BLEND_AG1));
+		writel(param_h->rcnr_anf_blend_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR0_ANF_BLEND_AG2));
+
+		writel(param_h->rcnr_lpf_threshold,
+		       &(res->capture_reg->l1isp.L1_RCNR0_LPF_THRESHOLD));
+
+		writel(param_h->rcnr_merge_hlblend_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR0_MERGE_HLBLEND_AG0));
+		writel(param_h->rcnr_merge_hlblend_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR0_MERGE_HLBLEND_AG1));
+		writel(param_h->rcnr_merge_hlblend_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR0_MERGE_HLBLEND_AG2));
+
+		writel(param_h->rcnr_gnr_sw, &(res->capture_reg->l1isp.L1_RCNR0_GNR_SW));
+
+		if (param_h->rcnr_gnr_sw == HWD_VIIF_ENABLE) {
+			writel(param_h->rcnr_gnr_ratio,
+			       &(res->capture_reg->l1isp.L1_RCNR0_GNR_RATIO));
+			writel(param_h->rcnr_gnr_wide_en,
+			       &(res->capture_reg->l1isp.L1_RCNR0_GNR_WIDE_EN));
+		}
+	}
+
+	if (param_m != NULL) {
+		writel(param_m->rcnr_sw, &(res->capture_reg->l1isp.L1_RCNR1_SW));
+
+		writel(param_m->rcnr_cnf_dark_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR1_CNF_DARK_AG0));
+		writel(param_m->rcnr_cnf_dark_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR1_CNF_DARK_AG1));
+		writel(param_m->rcnr_cnf_dark_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR1_CNF_DARK_AG2));
+
+		writel(param_m->rcnr_cnf_ratio_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR1_CNF_RATIO_AG0));
+		writel(param_m->rcnr_cnf_ratio_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR1_CNF_RATIO_AG1));
+		writel(param_m->rcnr_cnf_ratio_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR1_CNF_RATIO_AG2));
+
+		writel(param_m->rcnr_cnf_clip_gain_r,
+		       &(res->capture_reg->l1isp.L1_RCNR1_CNF_CLIP_GAIN_R));
+		writel(param_m->rcnr_cnf_clip_gain_g,
+		       &(res->capture_reg->l1isp.L1_RCNR1_CNF_CLIP_GAIN_G));
+		writel(param_m->rcnr_cnf_clip_gain_b,
+		       &(res->capture_reg->l1isp.L1_RCNR1_CNF_CLIP_GAIN_B));
+
+		writel(param_m->rcnr_a1l_dark_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR1_A1L_DARK_AG0));
+		writel(param_m->rcnr_a1l_dark_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR1_A1L_DARK_AG1));
+		writel(param_m->rcnr_a1l_dark_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR1_A1L_DARK_AG2));
+
+		writel(param_m->rcnr_a1l_ratio_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR1_A1L_RATIO_AG0));
+		writel(param_m->rcnr_a1l_ratio_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR1_A1L_RATIO_AG1));
+		writel(param_m->rcnr_a1l_ratio_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR1_A1L_RATIO_AG2));
+
+		writel(param_m->rcnr_inf_zero_clip,
+		       &(res->capture_reg->l1isp.L1_RCNR1_INF_ZERO_CLIP));
+
+		writel(param_m->rcnr_merge_d2blend_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR1_MERGE_D2BLEND_AG0));
+		writel(param_m->rcnr_merge_d2blend_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR1_MERGE_D2BLEND_AG1));
+		writel(param_m->rcnr_merge_d2blend_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR1_MERGE_D2BLEND_AG2));
+		writel(param_m->rcnr_merge_black, &(res->capture_reg->l1isp.L1_RCNR1_MERGE_BLACK));
+		writel(param_m->rcnr_merge_mindiv,
+		       &(res->capture_reg->l1isp.L1_RCNR1_MERGE_MINDIV));
+
+		writel(param_m->rcnr_hry_type, &(res->capture_reg->l1isp.L1_RCNR1_HRY_TYPE));
+
+		writel(param_m->rcnr_anf_blend_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR1_ANF_BLEND_AG0));
+		writel(param_m->rcnr_anf_blend_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR1_ANF_BLEND_AG1));
+		writel(param_m->rcnr_anf_blend_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR1_ANF_BLEND_AG2));
+
+		writel(param_m->rcnr_lpf_threshold,
+		       &(res->capture_reg->l1isp.L1_RCNR1_LPF_THRESHOLD));
+
+		writel(param_m->rcnr_merge_hlblend_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR1_MERGE_HLBLEND_AG0));
+		writel(param_m->rcnr_merge_hlblend_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR1_MERGE_HLBLEND_AG1));
+		writel(param_m->rcnr_merge_hlblend_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR1_MERGE_HLBLEND_AG2));
+
+		writel(param_m->rcnr_gnr_sw, &(res->capture_reg->l1isp.L1_RCNR1_GNR_SW));
+
+		if (param_m->rcnr_gnr_sw == HWD_VIIF_ENABLE) {
+			writel(param_m->rcnr_gnr_ratio,
+			       &(res->capture_reg->l1isp.L1_RCNR1_GNR_RATIO));
+			writel(param_m->rcnr_gnr_wide_en,
+			       &(res->capture_reg->l1isp.L1_RCNR1_GNR_WIDE_EN));
+		}
+	}
+
+	if (param_l != NULL) {
+		writel(param_l->rcnr_sw, &(res->capture_reg->l1isp.L1_RCNR2_SW));
+
+		writel(param_l->rcnr_cnf_dark_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR2_CNF_DARK_AG0));
+		writel(param_l->rcnr_cnf_dark_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR2_CNF_DARK_AG1));
+		writel(param_l->rcnr_cnf_dark_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR2_CNF_DARK_AG2));
+
+		writel(param_l->rcnr_cnf_ratio_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR2_CNF_RATIO_AG0));
+		writel(param_l->rcnr_cnf_ratio_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR2_CNF_RATIO_AG1));
+		writel(param_l->rcnr_cnf_ratio_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR2_CNF_RATIO_AG2));
+
+		writel(param_l->rcnr_cnf_clip_gain_r,
+		       &(res->capture_reg->l1isp.L1_RCNR2_CNF_CLIP_GAIN_R));
+		writel(param_l->rcnr_cnf_clip_gain_g,
+		       &(res->capture_reg->l1isp.L1_RCNR2_CNF_CLIP_GAIN_G));
+		writel(param_l->rcnr_cnf_clip_gain_b,
+		       &(res->capture_reg->l1isp.L1_RCNR2_CNF_CLIP_GAIN_B));
+
+		writel(param_l->rcnr_a1l_dark_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR2_A1L_DARK_AG0));
+		writel(param_l->rcnr_a1l_dark_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR2_A1L_DARK_AG1));
+		writel(param_l->rcnr_a1l_dark_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR2_A1L_DARK_AG2));
+
+		writel(param_l->rcnr_a1l_ratio_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR2_A1L_RATIO_AG0));
+		writel(param_l->rcnr_a1l_ratio_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR2_A1L_RATIO_AG1));
+		writel(param_l->rcnr_a1l_ratio_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR2_A1L_RATIO_AG2));
+
+		writel(param_l->rcnr_inf_zero_clip,
+		       &(res->capture_reg->l1isp.L1_RCNR2_INF_ZERO_CLIP));
+
+		writel(param_l->rcnr_merge_d2blend_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR2_MERGE_D2BLEND_AG0));
+		writel(param_l->rcnr_merge_d2blend_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR2_MERGE_D2BLEND_AG1));
+		writel(param_l->rcnr_merge_d2blend_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR2_MERGE_D2BLEND_AG2));
+		writel(param_l->rcnr_merge_black, &(res->capture_reg->l1isp.L1_RCNR2_MERGE_BLACK));
+		writel(param_l->rcnr_merge_mindiv,
+		       &(res->capture_reg->l1isp.L1_RCNR2_MERGE_MINDIV));
+
+		writel(param_l->rcnr_hry_type, &(res->capture_reg->l1isp.L1_RCNR2_HRY_TYPE));
+
+		writel(param_l->rcnr_anf_blend_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR2_ANF_BLEND_AG0));
+		writel(param_l->rcnr_anf_blend_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR2_ANF_BLEND_AG1));
+		writel(param_l->rcnr_anf_blend_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR2_ANF_BLEND_AG2));
+
+		writel(param_l->rcnr_lpf_threshold,
+		       &(res->capture_reg->l1isp.L1_RCNR2_LPF_THRESHOLD));
+
+		writel(param_l->rcnr_merge_hlblend_ag0,
+		       &(res->capture_reg->l1isp.L1_RCNR2_MERGE_HLBLEND_AG0));
+		writel(param_l->rcnr_merge_hlblend_ag1,
+		       &(res->capture_reg->l1isp.L1_RCNR2_MERGE_HLBLEND_AG1));
+		writel(param_l->rcnr_merge_hlblend_ag2,
+		       &(res->capture_reg->l1isp.L1_RCNR2_MERGE_HLBLEND_AG2));
+
+		writel(param_l->rcnr_gnr_sw, &(res->capture_reg->l1isp.L1_RCNR2_GNR_SW));
+
+		if (param_l->rcnr_gnr_sw == HWD_VIIF_ENABLE) {
+			writel(param_l->rcnr_gnr_ratio,
+			       &(res->capture_reg->l1isp.L1_RCNR2_GNR_RATIO));
+			writel(param_l->rcnr_gnr_wide_en,
+			       &(res->capture_reg->l1isp.L1_RCNR2_GNR_WIDE_EN));
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_hdrs() - Configure L1ISP HDR synthesis parameters.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @param: pointer to HDR synthesis parameters
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param" is NULL
+ * - each parameter of "param" is out of range
+ */
+int32_t hwd_VIIF_l1_set_hdrs(uint32_t module_id, uint32_t regbuf_id,
+			     const struct hwd_viif_l1_hdrs *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+
+	if (param == NULL)
+		return -EINVAL;
+
+	if ((param->hdrs_hdr_mode != HWD_VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE) &&
+	    (param->hdrs_hdr_mode != HWD_VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE)) {
+		return -EINVAL;
+	}
+
+	if ((param->hdrs_hdr_ratio_m < HWD_VIIF_L1_HDRS_MIN_BLEND_RATIO) ||
+	    (param->hdrs_hdr_ratio_m > HWD_VIIF_L1_HDRS_MAX_BLEND_RATIO)) {
+		return -EINVAL;
+	}
+	if ((param->hdrs_hdr_ratio_l < HWD_VIIF_L1_HDRS_MIN_BLEND_RATIO) ||
+	    (param->hdrs_hdr_ratio_l > HWD_VIIF_L1_HDRS_MAX_BLEND_RATIO)) {
+		return -EINVAL;
+	}
+	if ((param->hdrs_hdr_ratio_e < HWD_VIIF_L1_HDRS_MIN_BLEND_RATIO) ||
+	    (param->hdrs_hdr_ratio_e > HWD_VIIF_L1_HDRS_MAX_BLEND_RATIO)) {
+		return -EINVAL;
+	}
+
+	if (param->hdrs_dg_h >= HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL)
+		return -EINVAL;
+
+	if (param->hdrs_dg_m >= HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL)
+		return -EINVAL;
+
+	if (param->hdrs_dg_l >= HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL)
+		return -EINVAL;
+
+	if (param->hdrs_dg_e >= HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL)
+		return -EINVAL;
+
+	if (param->hdrs_blendend_h > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL)
+		return -EINVAL;
+
+	if (param->hdrs_blendend_m > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL)
+		return -EINVAL;
+
+	if (param->hdrs_blendend_e > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL)
+		return -EINVAL;
+
+	if (param->hdrs_blendbeg_h > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL)
+		return -EINVAL;
+
+	if (param->hdrs_blendbeg_m > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL)
+		return -EINVAL;
+
+	if (param->hdrs_blendbeg_e > HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL)
+		return -EINVAL;
+
+	if ((param->hdrs_led_mode_on != HWD_VIIF_ENABLE) &&
+	    (param->hdrs_led_mode_on != HWD_VIIF_DISABLE)) {
+		return -EINVAL;
+	}
+
+	if (param->hdrs_dst_max_val > HWD_VIIF_L1_HDRS_MAX_DST_MAX_VAL)
+		return -EINVAL;
+
+	writel(param->hdrs_hdr_mode, &(res->capture_reg->l1isp.L1_HDRS_HdrMode));
+
+	writel(param->hdrs_hdr_ratio_m, &(res->capture_reg->l1isp.L1_HDRS_HdrRatioM));
+	writel(param->hdrs_hdr_ratio_l, &(res->capture_reg->l1isp.L1_HDRS_HdrRatioL));
+	writel(param->hdrs_hdr_ratio_e, &(res->capture_reg->l1isp.L1_HDRS_HdrRatioE));
+
+	writel(param->hdrs_dg_h, &(res->capture_reg->l1isp.L1_HDRS_DgH));
+	writel(param->hdrs_dg_m, &(res->capture_reg->l1isp.L1_HDRS_DgM));
+	writel(param->hdrs_dg_l, &(res->capture_reg->l1isp.L1_HDRS_DgL));
+	writel(param->hdrs_dg_e, &(res->capture_reg->l1isp.L1_HDRS_DgE));
+
+	writel(param->hdrs_blendend_h, &(res->capture_reg->l1isp.L1_HDRS_BlendEndH));
+	writel(param->hdrs_blendend_m, &(res->capture_reg->l1isp.L1_HDRS_BlendEndM));
+	writel(param->hdrs_blendend_e, &(res->capture_reg->l1isp.L1_HDRS_BlendEndE));
+
+	writel(param->hdrs_blendbeg_h, &(res->capture_reg->l1isp.L1_HDRS_BlendBegH));
+	writel(param->hdrs_blendbeg_m, &(res->capture_reg->l1isp.L1_HDRS_BlendBegM));
+	writel(param->hdrs_blendbeg_e, &(res->capture_reg->l1isp.L1_HDRS_BlendBegE));
+
+	writel(param->hdrs_led_mode_on, &(res->capture_reg->l1isp.L1_HDRS_LedModeOn));
+	writel(param->hdrs_dst_max_val, &(res->capture_reg->l1isp.L1_HDRS_DstMaxval));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_black_level_correction() - Configure L1ISP black level correction parameters.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @param: pointer to black level correction parameters
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "param" is NULL
+ * - each parameter of "param" is out of range
+ */
+int32_t
+hwd_VIIF_l1_set_black_level_correction(uint32_t module_id, uint32_t regbuf_id,
+				       const struct hwd_viif_l1_black_level_correction *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	if (param == NULL)
+		return -EINVAL;
+
+	if (param->srcblacklevel_gr > HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL)
+		return -EINVAL;
+
+	if (param->srcblacklevel_r > HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL)
+		return -EINVAL;
+
+	if (param->srcblacklevel_b > HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL)
+		return -EINVAL;
+
+	if (param->srcblacklevel_gb > HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL)
+		return -EINVAL;
+
+	if (param->mulval_gr >= HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL)
+		return -EINVAL;
+
+	if (param->mulval_r >= HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL)
+		return -EINVAL;
+
+	if (param->mulval_b >= HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL)
+		return -EINVAL;
+
+	if (param->mulval_gb >= HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL)
+		return -EINVAL;
+
+	if (param->dstmaxval > HWD_VIIF_L1_BLACK_LEVEL_MAX_DST_VAL)
+		return -EINVAL;
+
+	writel(param->srcblacklevel_gr, &(res->capture_reg->l1isp.L1_BLVC_SrcBlackLevelGr));
+	writel(param->srcblacklevel_r, &(res->capture_reg->l1isp.L1_BLVC_SrcBlackLevelR));
+	writel(param->srcblacklevel_b, &(res->capture_reg->l1isp.L1_BLVC_SrcBlackLevelB));
+	writel(param->srcblacklevel_gb, &(res->capture_reg->l1isp.L1_BLVC_SrcBlackLevelGb));
+
+	writel(param->mulval_gr, &(res->capture_reg->l1isp.L1_BLVC_MultValGr));
+	writel(param->mulval_r, &(res->capture_reg->l1isp.L1_BLVC_MultValR));
+	writel(param->mulval_b, &(res->capture_reg->l1isp.L1_BLVC_MultValB));
+	writel(param->mulval_gb, &(res->capture_reg->l1isp.L1_BLVC_MultValGb));
+
+	writel(param->dstmaxval, &(res->capture_reg->l1isp.L1_BLVC_DstMaxval));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_lsc() - Configure L1ISP lens shading correction parameters.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @param: pointer to lens shading correction parameters
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ * @note when NULL is set to "param"
+ */
+int32_t hwd_VIIF_l1_set_lsc(uint32_t module_id, uint32_t regbuf_id,
+			    const struct hwd_viif_l1_lsc *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	int32_t ret = 0;
+	uint32_t idx;
+	const struct hwd_viif_l1_lsc_parabola_ag_param *ag_param;
+	uint32_t val;
+	uint32_t tmp;
+	uint32_t sysm_width, sysm_height;
+	uint32_t grid_h_size = 0U;
+	uint32_t grid_v_size = 0U;
+
+	if (param != NULL) {
+		sysm_width = readl(&res->capture_reg->l1isp.L1_SYSM_WIDTH);
+		sysm_height = readl(&res->capture_reg->l1isp.L1_SYSM_HEIGHT);
+
+		if (param->lssc_parabola_param != NULL) {
+			if (param->lssc_parabola_param->lssc_para_h_center >= sysm_width) {
+				return -EINVAL;
+			}
+
+			if (param->lssc_parabola_param->lssc_para_v_center >= sysm_height) {
+				return -EINVAL;
+			}
+
+			if (param->lssc_parabola_param->lssc_para_h_gain >= HWD_VIIF_LSC_MAX_GAIN) {
+				return -EINVAL;
+			}
+			if (param->lssc_parabola_param->lssc_para_v_gain >= HWD_VIIF_LSC_MAX_GAIN) {
+				return -EINVAL;
+			}
+
+			switch (param->lssc_parabola_param->lssc_para_mgsel2) {
+			case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH:
+			case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH:
+			case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_SECOND:
+			case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FIRST:
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
+
+			if (ret != 0)
+				return ret;
+
+			switch (param->lssc_parabola_param->lssc_para_mgsel4) {
+			case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH:
+			case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH:
+			case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_SECOND:
+			case HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FIRST:
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
+
+			if (ret != 0)
+				return ret;
+
+			for (idx = 0U; idx < 8U; idx++) {
+				switch (idx) {
+				case 0U:
+					ag_param = param->lssc_parabola_param->r_2d;
+					break;
+				case 1U:
+					ag_param = param->lssc_parabola_param->r_4d;
+					break;
+				case 2U:
+					ag_param = param->lssc_parabola_param->gr_2d;
+					break;
+				case 3U:
+					ag_param = param->lssc_parabola_param->gr_4d;
+					break;
+				case 4U:
+					ag_param = param->lssc_parabola_param->gb_2d;
+					break;
+				case 5U:
+					ag_param = param->lssc_parabola_param->gb_4d;
+					break;
+				case 6U:
+					ag_param = param->lssc_parabola_param->b_2d;
+					break;
+				default:
+					ag_param = param->lssc_parabola_param->b_4d;
+					break;
+				}
+
+				if (ag_param == NULL)
+					return -EINVAL;
+
+				if ((ag_param->lssc_paracoef_h_l_max < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_h_l_max >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if ((ag_param->lssc_paracoef_h_l_min < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_h_l_min >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if (ag_param->lssc_paracoef_h_l_min >
+				    ag_param->lssc_paracoef_h_l_max) {
+					return -EINVAL;
+				}
+
+				if ((ag_param->lssc_paracoef_h_r_max < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_h_r_max >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if ((ag_param->lssc_paracoef_h_r_min < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_h_r_min >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if (ag_param->lssc_paracoef_h_r_min >
+				    ag_param->lssc_paracoef_h_r_max) {
+					return -EINVAL;
+				}
+
+				if ((ag_param->lssc_paracoef_v_u_max < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_v_u_max >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if ((ag_param->lssc_paracoef_v_u_min < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_v_u_min >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if (ag_param->lssc_paracoef_v_u_min >
+				    ag_param->lssc_paracoef_v_u_max) {
+					return -EINVAL;
+				}
+
+				if ((ag_param->lssc_paracoef_v_d_max < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_v_d_max >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if ((ag_param->lssc_paracoef_v_d_min < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_v_d_min >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if (ag_param->lssc_paracoef_v_d_min >
+				    ag_param->lssc_paracoef_v_d_max) {
+					return -EINVAL;
+				}
+
+				if ((ag_param->lssc_paracoef_hv_lu_max < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_hv_lu_max >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if ((ag_param->lssc_paracoef_hv_lu_min < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_hv_lu_min >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if (ag_param->lssc_paracoef_hv_lu_min >
+				    ag_param->lssc_paracoef_hv_lu_max) {
+					return -EINVAL;
+				}
+
+				if ((ag_param->lssc_paracoef_hv_ru_max < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_hv_ru_max >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if ((ag_param->lssc_paracoef_hv_ru_min < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_hv_ru_min >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if (ag_param->lssc_paracoef_hv_ru_min >
+				    ag_param->lssc_paracoef_hv_ru_max) {
+					return -EINVAL;
+				}
+
+				if ((ag_param->lssc_paracoef_hv_ld_max < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_hv_ld_max >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if ((ag_param->lssc_paracoef_hv_ld_min < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_hv_ld_min >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if (ag_param->lssc_paracoef_hv_ld_min >
+				    ag_param->lssc_paracoef_hv_ld_max) {
+					return -EINVAL;
+				}
+
+				if ((ag_param->lssc_paracoef_hv_rd_max < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_hv_rd_max >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if ((ag_param->lssc_paracoef_hv_rd_min < HWD_VIIF_LSC_MIN_GAIN) ||
+				    (ag_param->lssc_paracoef_hv_rd_min >= HWD_VIIF_LSC_MAX_GAIN)) {
+					return -EINVAL;
+				}
+				if (ag_param->lssc_paracoef_hv_rd_min >
+				    ag_param->lssc_paracoef_hv_rd_max) {
+					return -EINVAL;
+				}
+			}
+		}
+
+		if (param->lssc_grid_param != NULL) {
+			switch (param->lssc_grid_param->lssc_grid_h_size) {
+			case 32U:
+				grid_h_size = 5U;
+				break;
+			case 64U:
+				grid_h_size = 6U;
+				break;
+			case 128U:
+				grid_h_size = 7U;
+				break;
+			case 256U:
+				grid_h_size = 8U;
+				break;
+			case 512U:
+				grid_h_size = 9U;
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
+
+			if (ret != 0)
+				return ret;
+
+			switch (param->lssc_grid_param->lssc_grid_v_size) {
+			case 32U:
+				grid_v_size = 5U;
+				break;
+			case 64U:
+				grid_v_size = 6U;
+				break;
+			case 128U:
+				grid_v_size = 7U;
+				break;
+			case 256U:
+				grid_v_size = 8U;
+				break;
+			case 512U:
+				grid_v_size = 9U;
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
+
+			if (ret != 0)
+				return ret;
+
+			if ((param->lssc_grid_param->lssc_grid_h_center <
+			     HWD_VIIF_LSC_GRID_MIN_COORDINATE) ||
+			    (param->lssc_grid_param->lssc_grid_h_center >
+			     param->lssc_grid_param->lssc_grid_h_size)) {
+				return -EINVAL;
+			}
+
+			if (sysm_width > (param->lssc_grid_param->lssc_grid_h_center +
+					  (param->lssc_grid_param->lssc_grid_h_size * 31U))) {
+				return -EINVAL;
+			}
+
+			if ((param->lssc_grid_param->lssc_grid_v_center <
+			     HWD_VIIF_LSC_GRID_MIN_COORDINATE) ||
+			    (param->lssc_grid_param->lssc_grid_v_center >
+			     param->lssc_grid_param->lssc_grid_v_size)) {
+				return -EINVAL;
+			}
+
+			if (sysm_height > (param->lssc_grid_param->lssc_grid_v_center +
+					   (param->lssc_grid_param->lssc_grid_v_size * 23U))) {
+				return -EINVAL;
+			}
+
+			if ((param->lssc_grid_param->lssc_grid_mgsel !=
+			     HWD_VIIF_L1_GRID_COEF_GAIN_X1) &&
+			    (param->lssc_grid_param->lssc_grid_mgsel !=
+			     HWD_VIIF_L1_GRID_COEF_GAIN_X2)) {
+				return -EINVAL;
+			}
+		}
+
+		if (param->lssc_pwhb_r_gain_max >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL) {
+			return -EINVAL;
+		}
+		if (param->lssc_pwhb_r_gain_min >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL) {
+			return -EINVAL;
+		}
+		if (param->lssc_pwhb_r_gain_min > param->lssc_pwhb_r_gain_max)
+			return -EINVAL;
+
+		if (param->lssc_pwhb_gr_gain_max >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL) {
+			return -EINVAL;
+		}
+		if (param->lssc_pwhb_gr_gain_min >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL) {
+			return -EINVAL;
+		}
+		if (param->lssc_pwhb_gr_gain_min > param->lssc_pwhb_gr_gain_max) {
+			return -EINVAL;
+		}
+
+		if (param->lssc_pwhb_gb_gain_max >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL) {
+			return -EINVAL;
+		}
+		if (param->lssc_pwhb_gb_gain_min >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL) {
+			return -EINVAL;
+		}
+		if (param->lssc_pwhb_gb_gain_min > param->lssc_pwhb_gb_gain_max) {
+			return -EINVAL;
+		}
+
+		if (param->lssc_pwhb_b_gain_max >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL) {
+			return -EINVAL;
+		}
+		if (param->lssc_pwhb_b_gain_min >= HWD_VIIF_LSC_PWB_MAX_COEF_VAL) {
+			return -EINVAL;
+		}
+		if (param->lssc_pwhb_b_gain_min > param->lssc_pwhb_b_gain_max)
+			return -EINVAL;
+	}
+
+	if (param != NULL) {
+		/* parabola shading */
+		if (param->lssc_parabola_param != NULL) {
+			writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_LSSC_PARA_EN));
+
+			writel(param->lssc_parabola_param->lssc_para_h_center,
+			       &(res->capture_reg->l1isp.L1_LSSC_PARA_H_CENTER));
+			writel(param->lssc_parabola_param->lssc_para_v_center,
+			       &(res->capture_reg->l1isp.L1_LSSC_PARA_V_CENTER));
+
+			writel(param->lssc_parabola_param->lssc_para_h_gain,
+			       &(res->capture_reg->l1isp.L1_LSSC_PARA_H_GAIN));
+			writel(param->lssc_parabola_param->lssc_para_v_gain,
+			       &(res->capture_reg->l1isp.L1_LSSC_PARA_V_GAIN));
+
+			writel(param->lssc_parabola_param->lssc_para_mgsel2,
+			       &(res->capture_reg->l1isp.L1_LSSC_PARA_MGSEL2));
+			writel(param->lssc_parabola_param->lssc_para_mgsel4,
+			       &(res->capture_reg->l1isp.L1_LSSC_PARA_MGSEL4));
+
+			/* R 2D */
+			tmp = (uint32_t)param->lssc_parabola_param->r_2d->lssc_paracoef_h_l_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_2d->lssc_paracoef_h_l_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_H_L));
+
+			tmp = (uint32_t)param->lssc_parabola_param->r_2d->lssc_paracoef_h_r_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_2d->lssc_paracoef_h_r_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_H_R));
+
+			tmp = (uint32_t)param->lssc_parabola_param->r_2d->lssc_paracoef_v_u_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_2d->lssc_paracoef_v_u_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_V_U));
+
+			tmp = (uint32_t)param->lssc_parabola_param->r_2d->lssc_paracoef_v_d_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_2d->lssc_paracoef_v_d_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_V_D));
+
+			tmp = (uint32_t)param->lssc_parabola_param->r_2d->lssc_paracoef_hv_lu_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_2d->lssc_paracoef_hv_lu_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_HV_LU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->r_2d->lssc_paracoef_hv_ru_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_2d->lssc_paracoef_hv_ru_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_HV_RU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->r_2d->lssc_paracoef_hv_ld_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_2d->lssc_paracoef_hv_ld_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_HV_LD));
+
+			tmp = (uint32_t)param->lssc_parabola_param->r_2d->lssc_paracoef_hv_rd_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_2d->lssc_paracoef_hv_rd_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_2D_HV_RD));
+
+			/* R 4D */
+			tmp = (uint32_t)param->lssc_parabola_param->r_4d->lssc_paracoef_h_l_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_4d->lssc_paracoef_h_l_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_H_L));
+
+			tmp = (uint32_t)param->lssc_parabola_param->r_4d->lssc_paracoef_h_r_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_4d->lssc_paracoef_h_r_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_H_R));
+
+			tmp = (uint32_t)param->lssc_parabola_param->r_4d->lssc_paracoef_v_u_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_4d->lssc_paracoef_v_u_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_V_U));
+
+			tmp = (uint32_t)param->lssc_parabola_param->r_4d->lssc_paracoef_v_d_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_4d->lssc_paracoef_v_d_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_V_D));
+
+			tmp = (uint32_t)param->lssc_parabola_param->r_4d->lssc_paracoef_hv_lu_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_4d->lssc_paracoef_hv_lu_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_HV_LU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->r_4d->lssc_paracoef_hv_ru_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_4d->lssc_paracoef_hv_ru_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_HV_RU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->r_4d->lssc_paracoef_hv_ld_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_4d->lssc_paracoef_hv_ld_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_HV_LD));
+
+			tmp = (uint32_t)param->lssc_parabola_param->r_4d->lssc_paracoef_hv_rd_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->r_4d->lssc_paracoef_hv_rd_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_R_COEF_4D_HV_RD));
+
+			/* GR 2D */
+			tmp = (uint32_t)param->lssc_parabola_param->gr_2d->lssc_paracoef_h_l_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gr_2d->lssc_paracoef_h_l_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_H_L));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gr_2d->lssc_paracoef_h_r_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gr_2d->lssc_paracoef_h_r_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_H_R));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gr_2d->lssc_paracoef_v_u_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gr_2d->lssc_paracoef_v_u_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_V_U));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gr_2d->lssc_paracoef_v_d_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gr_2d->lssc_paracoef_v_d_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_V_D));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gr_2d->lssc_paracoef_hv_lu_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gr_2d->lssc_paracoef_hv_lu_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_HV_LU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gr_2d->lssc_paracoef_hv_ru_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gr_2d->lssc_paracoef_hv_ru_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_HV_RU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gr_2d->lssc_paracoef_hv_ld_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gr_2d->lssc_paracoef_hv_ld_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_HV_LD));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gr_2d->lssc_paracoef_hv_rd_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gr_2d->lssc_paracoef_hv_rd_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_2D_HV_RD));
+
+			/* GR 4D */
+			tmp = (uint32_t)param->lssc_parabola_param->gr_4d->lssc_paracoef_h_l_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gr_4d->lssc_paracoef_h_l_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_H_L));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gr_4d->lssc_paracoef_h_r_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gr_4d->lssc_paracoef_h_r_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_H_R));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gr_4d->lssc_paracoef_v_u_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gr_4d->lssc_paracoef_v_u_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_V_U));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gr_4d->lssc_paracoef_v_d_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gr_4d->lssc_paracoef_v_d_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_V_D));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gr_4d->lssc_paracoef_hv_lu_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gr_4d->lssc_paracoef_hv_lu_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_HV_LU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gr_4d->lssc_paracoef_hv_ru_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gr_4d->lssc_paracoef_hv_ru_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_HV_RU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gr_4d->lssc_paracoef_hv_ld_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gr_4d->lssc_paracoef_hv_ld_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_HV_LD));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gr_4d->lssc_paracoef_hv_rd_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gr_4d->lssc_paracoef_hv_rd_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GR_COEF_4D_HV_RD));
+
+			/* GB 2D */
+			tmp = (uint32_t)param->lssc_parabola_param->gb_2d->lssc_paracoef_h_l_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gb_2d->lssc_paracoef_h_l_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_H_L));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gb_2d->lssc_paracoef_h_r_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gb_2d->lssc_paracoef_h_r_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_H_R));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gb_2d->lssc_paracoef_v_u_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gb_2d->lssc_paracoef_v_u_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_V_U));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gb_2d->lssc_paracoef_v_d_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gb_2d->lssc_paracoef_v_d_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_V_D));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gb_2d->lssc_paracoef_hv_lu_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gb_2d->lssc_paracoef_hv_lu_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_HV_LU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gb_2d->lssc_paracoef_hv_ru_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gb_2d->lssc_paracoef_hv_ru_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_HV_RU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gb_2d->lssc_paracoef_hv_ld_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gb_2d->lssc_paracoef_hv_ld_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_HV_LD));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gb_2d->lssc_paracoef_hv_rd_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gb_2d->lssc_paracoef_hv_rd_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_2D_HV_RD));
+
+			/* GB 4D */
+			tmp = (uint32_t)param->lssc_parabola_param->gb_4d->lssc_paracoef_h_l_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gb_4d->lssc_paracoef_h_l_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_H_L));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gb_4d->lssc_paracoef_h_r_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gb_4d->lssc_paracoef_h_r_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_H_R));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gb_4d->lssc_paracoef_v_u_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gb_4d->lssc_paracoef_v_u_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_V_U));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gb_4d->lssc_paracoef_v_d_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->gb_4d->lssc_paracoef_v_d_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_V_D));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gb_4d->lssc_paracoef_hv_lu_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gb_4d->lssc_paracoef_hv_lu_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_HV_LU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gb_4d->lssc_paracoef_hv_ru_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gb_4d->lssc_paracoef_hv_ru_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_HV_RU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gb_4d->lssc_paracoef_hv_ld_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gb_4d->lssc_paracoef_hv_ld_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_HV_LD));
+
+			tmp = (uint32_t)param->lssc_parabola_param->gb_4d->lssc_paracoef_hv_rd_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(
+				      param->lssc_parabola_param->gb_4d->lssc_paracoef_hv_rd_min &
+				      0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_GB_COEF_4D_HV_RD));
+
+			/* B 2D */
+			tmp = (uint32_t)param->lssc_parabola_param->b_2d->lssc_paracoef_h_l_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_2d->lssc_paracoef_h_l_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_H_L));
+
+			tmp = (uint32_t)param->lssc_parabola_param->b_2d->lssc_paracoef_h_r_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_2d->lssc_paracoef_h_r_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_H_R));
+
+			tmp = (uint32_t)param->lssc_parabola_param->b_2d->lssc_paracoef_v_u_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_2d->lssc_paracoef_v_u_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_V_U));
+
+			tmp = (uint32_t)param->lssc_parabola_param->b_2d->lssc_paracoef_v_d_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_2d->lssc_paracoef_v_d_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_V_D));
+
+			tmp = (uint32_t)param->lssc_parabola_param->b_2d->lssc_paracoef_hv_lu_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_2d->lssc_paracoef_hv_lu_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_HV_LU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->b_2d->lssc_paracoef_hv_ru_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_2d->lssc_paracoef_hv_ru_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_HV_RU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->b_2d->lssc_paracoef_hv_ld_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_2d->lssc_paracoef_hv_ld_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_HV_LD));
+
+			tmp = (uint32_t)param->lssc_parabola_param->b_2d->lssc_paracoef_hv_rd_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_2d->lssc_paracoef_hv_rd_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_2D_HV_RD));
+
+			/* B 4D */
+			tmp = (uint32_t)param->lssc_parabola_param->b_4d->lssc_paracoef_h_l_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_4d->lssc_paracoef_h_l_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_H_L));
+
+			tmp = (uint32_t)param->lssc_parabola_param->b_4d->lssc_paracoef_h_r_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_4d->lssc_paracoef_h_r_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_H_R));
+
+			tmp = (uint32_t)param->lssc_parabola_param->b_4d->lssc_paracoef_v_u_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_4d->lssc_paracoef_v_u_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_V_U));
+
+			tmp = (uint32_t)param->lssc_parabola_param->b_4d->lssc_paracoef_v_d_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_4d->lssc_paracoef_v_d_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_V_D));
+
+			tmp = (uint32_t)param->lssc_parabola_param->b_4d->lssc_paracoef_hv_lu_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_4d->lssc_paracoef_hv_lu_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_HV_LU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->b_4d->lssc_paracoef_hv_ru_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_4d->lssc_paracoef_hv_ru_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_HV_RU));
+
+			tmp = (uint32_t)param->lssc_parabola_param->b_4d->lssc_paracoef_hv_ld_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_4d->lssc_paracoef_hv_ld_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_HV_LD));
+
+			tmp = (uint32_t)param->lssc_parabola_param->b_4d->lssc_paracoef_hv_rd_max &
+			      0x1fffU;
+			val = (tmp << 16U) |
+			      (uint32_t)(param->lssc_parabola_param->b_4d->lssc_paracoef_hv_rd_min &
+					 0x1fffU);
+			writel(val, &(res->capture_reg->l1isp.L1_LSSC_PARA_B_COEF_4D_HV_RD));
+
+		} else {
+			writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_LSSC_PARA_EN));
+		}
+
+		/* grid shading */
+		if (param->lssc_grid_param != NULL) {
+			writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_LSSC_GRID_EN));
+			writel(grid_h_size, &(res->capture_reg->l1isp.L1_LSSC_GRID_H_SIZE));
+			writel(grid_v_size, &(res->capture_reg->l1isp.L1_LSSC_GRID_V_SIZE));
+			writel(param->lssc_grid_param->lssc_grid_h_center,
+			       &(res->capture_reg->l1isp.L1_LSSC_GRID_H_CENTER));
+			writel(param->lssc_grid_param->lssc_grid_v_center,
+			       &(res->capture_reg->l1isp.L1_LSSC_GRID_V_CENTER));
+			writel(param->lssc_grid_param->lssc_grid_mgsel,
+			       &(res->capture_reg->l1isp.L1_LSSC_GRID_MGSEL));
+
+		} else {
+			writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_LSSC_GRID_EN));
+		}
+
+		/* preset white balance */
+		val = (param->lssc_pwhb_r_gain_max << 16U) | (param->lssc_pwhb_r_gain_min);
+		writel(val, &(res->capture_reg->l1isp.L1_LSSC_PWHB_R_GAIN));
+
+		val = (param->lssc_pwhb_gr_gain_max << 16U) | (param->lssc_pwhb_gr_gain_min);
+		writel(val, &(res->capture_reg->l1isp.L1_LSSC_PWHB_GR_GAIN));
+
+		val = (param->lssc_pwhb_gb_gain_max << 16U) | (param->lssc_pwhb_gb_gain_min);
+		writel(val, &(res->capture_reg->l1isp.L1_LSSC_PWHB_GB_GAIN));
+
+		val = (param->lssc_pwhb_b_gain_max << 16U) | (param->lssc_pwhb_b_gain_min);
+		writel(val, &(res->capture_reg->l1isp.L1_LSSC_PWHB_B_GAIN));
+
+		writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_LSSC_EN));
+	} else {
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_LSSC_EN));
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_lsc_table_transmission() - Configure L1ISP transferring lens shading grid table.
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
+int32_t hwd_VIIF_l1_set_lsc_table_transmission(uint32_t module_id, uintptr_t table_gr,
+					       uintptr_t table_r, uintptr_t table_b,
+					       uintptr_t table_gb)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val = 0x0U;
+
+	if (((table_gr % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_r % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_b % HWD_VIIF_L1_VDM_ALIGN) != 0U) ||
+	    ((table_gb % HWD_VIIF_L1_VDM_ALIGN) != 0U)) {
+		return -EINVAL;
+	}
+	/* VDM common settings */
+	writel(HWD_VIIF_L1_VDM_CFG_PARAM, &(res->capture_reg->vdm.t_group[0].VDM_T_CFG));
+	writel(HWD_VIIF_L1_VDM_SRAM_BASE, &(res->capture_reg->vdm.t_group[0].VDM_T_SRAM_BASE));
+	writel(HWD_VIIF_L1_VDM_SRAM_SIZE, &(res->capture_reg->vdm.t_group[0].VDM_T_SRAM_SIZE));
+
+	if (table_gr != 0U) {
+		writel((uint32_t)table_gr, &(res->capture_reg->vdm.t_port[4].VDM_T_STADR));
+		writel(HWD_VIIF_L1_VDM_LSC_TABLE_SIZE,
+		       &(res->capture_reg->vdm.t_port[4].VDM_T_SIZE));
+		val |= 0x10U;
+	}
+
+	if (table_r != 0U) {
+		writel((uint32_t)table_r, &(res->capture_reg->vdm.t_port[5].VDM_T_STADR));
+		writel(HWD_VIIF_L1_VDM_LSC_TABLE_SIZE,
+		       &(res->capture_reg->vdm.t_port[5].VDM_T_SIZE));
+		val |= 0x20U;
+	}
+
+	if (table_b != 0U) {
+		writel((uint32_t)table_b, &(res->capture_reg->vdm.t_port[6].VDM_T_STADR));
+		writel(HWD_VIIF_L1_VDM_LSC_TABLE_SIZE,
+		       &(res->capture_reg->vdm.t_port[6].VDM_T_SIZE));
+		val |= 0x40U;
+	}
+
+	if (table_gb != 0U) {
+		writel((uint32_t)table_gb, &(res->capture_reg->vdm.t_port[7].VDM_T_STADR));
+		writel(HWD_VIIF_L1_VDM_LSC_TABLE_SIZE,
+		       &(res->capture_reg->vdm.t_port[7].VDM_T_SIZE));
+		val |= 0x80U;
+	}
+
+	val |= (readl(&res->capture_reg->vdm.VDM_T_ENABLE) & 0xffffff0fU);
+	writel(val, &(res->capture_reg->vdm.VDM_T_ENABLE));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_main_process() - Configure L1ISP main process.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @demosaic_mode: demosaic mode @ref hwd_VIIF_l1_demosaic
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
+int32_t hwd_VIIF_l1_set_main_process(uint32_t module_id, uint32_t regbuf_id, uint32_t demosaic_mode,
+				     uint32_t damp_lsbsel,
+				     const struct hwd_viif_l1_color_matrix_correction *color_matrix,
+				     uint32_t dst_maxval)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val;
+
+	if ((demosaic_mode != HWD_VIIF_L1_DEMOSAIC_ACPI) &&
+	    (demosaic_mode != HWD_VIIF_L1_DEMOSAIC_DMG)) {
+		return -EINVAL;
+	}
+
+	if (damp_lsbsel > HWD_VIIF_DAMP_MAX_LSBSEL)
+		return -EINVAL;
+
+	if (color_matrix != NULL) {
+		if (color_matrix->coef_rmg_min > color_matrix->coef_rmg_max)
+			return -EINVAL;
+
+		if (color_matrix->coef_rmb_min > color_matrix->coef_rmb_max)
+			return -EINVAL;
+
+		if (color_matrix->coef_gmr_min > color_matrix->coef_gmr_max)
+			return -EINVAL;
+
+		if (color_matrix->coef_gmb_min > color_matrix->coef_gmb_max)
+			return -EINVAL;
+
+		if (color_matrix->coef_bmr_min > color_matrix->coef_bmr_max)
+			return -EINVAL;
+
+		if (color_matrix->coef_bmg_min > color_matrix->coef_bmg_max)
+			return -EINVAL;
+
+		if ((uint32_t)color_matrix->dst_minval > dst_maxval)
+			return -EINVAL;
+	}
+
+	if (dst_maxval > HWD_VIIF_MAIN_PROCESS_MAX_OUT_PIXEL_VAL)
+		return -EINVAL;
+
+	val = damp_lsbsel << 4U;
+	writel(val, &(res->capture_reg->l1isp.L1_MPRO_CONF));
+
+	writel(demosaic_mode, &(res->capture_reg->l1isp.L1_MPRO_LCS_MODE));
+
+	if (color_matrix != NULL) {
+		writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_MPRO_SW));
+
+		val = (uint32_t)color_matrix->coef_rmg_min & 0xffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_MPRO_LM0_RMG_MIN));
+
+		val = (uint32_t)color_matrix->coef_rmg_max & 0xffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_MPRO_LM0_RMG_MAX));
+
+		val = (uint32_t)color_matrix->coef_rmb_min & 0xffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_MPRO_LM0_RMB_MIN));
+
+		val = (uint32_t)color_matrix->coef_rmb_max & 0xffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_MPRO_LM0_RMB_MAX));
+
+		val = (uint32_t)color_matrix->coef_gmr_min & 0xffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_MPRO_LM0_GMR_MIN));
+
+		val = (uint32_t)color_matrix->coef_gmr_max & 0xffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_MPRO_LM0_GMR_MAX));
+
+		val = (uint32_t)color_matrix->coef_gmb_min & 0xffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_MPRO_LM0_GMB_MIN));
+
+		val = (uint32_t)color_matrix->coef_gmb_max & 0xffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_MPRO_LM0_GMB_MAX));
+
+		val = (uint32_t)color_matrix->coef_bmr_min & 0xffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_MPRO_LM0_BMR_MIN));
+
+		val = (uint32_t)color_matrix->coef_bmr_max & 0xffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_MPRO_LM0_BMR_MAX));
+
+		val = (uint32_t)color_matrix->coef_bmg_min & 0xffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_MPRO_LM0_BMG_MIN));
+
+		val = (uint32_t)color_matrix->coef_bmg_max & 0xffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_MPRO_LM0_BMG_MAX));
+
+		writel((uint32_t)color_matrix->dst_minval,
+		       &(res->capture_reg->l1isp.L1_MPRO_DST_MINVAL));
+	} else {
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_MPRO_SW));
+	}
+
+	writel(dst_maxval, &(res->capture_reg->l1isp.L1_MPRO_DST_MAXVAL));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_awb() - Configure L1ISP auto white balance parameters.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
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
+int32_t hwd_VIIF_l1_set_awb(uint32_t module_id, uint32_t regbuf_id,
+			    const struct hwd_viif_l1_awb *param, uint32_t awhb_wbmrg,
+			    uint32_t awhb_wbmgg, uint32_t awhb_wbmbg)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	int32_t ret = 0;
+	uint32_t val, ygate_data;
+
+	if ((awhb_wbmrg < HWD_VIIF_AWB_MIN_GAIN) || (awhb_wbmrg >= HWD_VIIF_AWB_MAX_GAIN)) {
+		return -EINVAL;
+	}
+	if ((awhb_wbmgg < HWD_VIIF_AWB_MIN_GAIN) || (awhb_wbmgg >= HWD_VIIF_AWB_MAX_GAIN)) {
+		return -EINVAL;
+	}
+	if ((awhb_wbmbg < HWD_VIIF_AWB_MIN_GAIN) || (awhb_wbmbg >= HWD_VIIF_AWB_MAX_GAIN)) {
+		return -EINVAL;
+	}
+
+	if (param != NULL) {
+		if ((param->awhb_ygate_sel != HWD_VIIF_ENABLE) &&
+		    (param->awhb_ygate_sel != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if ((param->awhb_ygate_data != 64U) && (param->awhb_ygate_data != 128U) &&
+		    (param->awhb_ygate_data != 256U) && (param->awhb_ygate_data != 512U)) {
+			return -EINVAL;
+		}
+
+		if ((param->awhb_cgrange != HWD_VIIF_L1_AWB_ONE_SECOND) &&
+		    (param->awhb_cgrange != HWD_VIIF_L1_AWB_X1) &&
+		    (param->awhb_cgrange != HWD_VIIF_L1_AWB_X2) &&
+		    (param->awhb_cgrange != HWD_VIIF_L1_AWB_X4)) {
+			return -EINVAL;
+		}
+
+		if ((param->awhb_ygatesw != HWD_VIIF_ENABLE) &&
+		    (param->awhb_ygatesw != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if ((param->awhb_hexsw != HWD_VIIF_ENABLE) &&
+		    (param->awhb_hexsw != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if ((param->awhb_areamode != HWD_VIIF_L1_AWB_AREA_MODE0) &&
+		    (param->awhb_areamode != HWD_VIIF_L1_AWB_AREA_MODE1) &&
+		    (param->awhb_areamode != HWD_VIIF_L1_AWB_AREA_MODE2) &&
+		    (param->awhb_areamode != HWD_VIIF_L1_AWB_AREA_MODE3)) {
+			return -EINVAL;
+		}
+
+		val = readl(&res->capture_reg->l1isp.L1_SYSM_WIDTH);
+		if ((param->awhb_area_hsize < 1U) || (param->awhb_area_hsize > ((val - 8U) / 8U))) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_area_hofs > (val - 9U))
+			return -EINVAL;
+
+		val = readl(&res->capture_reg->l1isp.L1_SYSM_HEIGHT);
+		if ((param->awhb_area_vsize < 1U) || (param->awhb_area_vsize > ((val - 4U) / 8U))) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_area_vofs > (val - 5U))
+			return -EINVAL;
+
+		if ((param->awhb_sq_sw[0] != HWD_VIIF_ENABLE) &&
+		    (param->awhb_sq_sw[0] != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+		if ((param->awhb_sq_sw[1] != HWD_VIIF_ENABLE) &&
+		    (param->awhb_sq_sw[1] != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+		if ((param->awhb_sq_sw[2] != HWD_VIIF_ENABLE) &&
+		    (param->awhb_sq_sw[2] != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if ((param->awhb_sq_pol[0] != HWD_VIIF_ENABLE) &&
+		    (param->awhb_sq_pol[0] != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+		if ((param->awhb_sq_pol[1] != HWD_VIIF_ENABLE) &&
+		    (param->awhb_sq_pol[1] != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+		if ((param->awhb_sq_pol[2] != HWD_VIIF_ENABLE) &&
+		    (param->awhb_sq_pol[2] != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_bycut0p > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER)
+			return -EINVAL;
+
+		if (param->awhb_bycut0n > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER)
+			return -EINVAL;
+
+		if (param->awhb_rycut0p > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER)
+			return -EINVAL;
+
+		if (param->awhb_rycut0n > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER)
+			return -EINVAL;
+
+		if ((param->awhb_rbcut0h < HWD_VIIF_AWB_GATE_LOWER) ||
+		    (param->awhb_rbcut0h > HWD_VIIF_AWB_GATE_UPPER)) {
+			return -EINVAL;
+		}
+		if ((param->awhb_rbcut0l < HWD_VIIF_AWB_GATE_LOWER) ||
+		    (param->awhb_rbcut0l > HWD_VIIF_AWB_GATE_UPPER)) {
+			return -EINVAL;
+		}
+
+		if ((param->awhb_bycut_h[0] < HWD_VIIF_AWB_GATE_LOWER) ||
+		    (param->awhb_bycut_h[0] > HWD_VIIF_AWB_GATE_UPPER)) {
+			return -EINVAL;
+		}
+		if ((param->awhb_bycut_h[1] < HWD_VIIF_AWB_GATE_LOWER) ||
+		    (param->awhb_bycut_h[1] > HWD_VIIF_AWB_GATE_UPPER)) {
+			return -EINVAL;
+		}
+		if ((param->awhb_bycut_h[2] < HWD_VIIF_AWB_GATE_LOWER) ||
+		    (param->awhb_bycut_h[2] > HWD_VIIF_AWB_GATE_UPPER)) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_bycut_l[0] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER)
+			return -EINVAL;
+
+		if (param->awhb_bycut_l[1] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER)
+			return -EINVAL;
+
+		if (param->awhb_bycut_l[2] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER)
+			return -EINVAL;
+
+		if ((param->awhb_rycut_h[0] < HWD_VIIF_AWB_GATE_LOWER) ||
+		    (param->awhb_rycut_h[0] > HWD_VIIF_AWB_GATE_UPPER)) {
+			return -EINVAL;
+		}
+		if ((param->awhb_rycut_h[1] < HWD_VIIF_AWB_GATE_LOWER) ||
+		    (param->awhb_rycut_h[1] > HWD_VIIF_AWB_GATE_UPPER)) {
+			return -EINVAL;
+		}
+		if ((param->awhb_rycut_h[2] < HWD_VIIF_AWB_GATE_LOWER) ||
+		    (param->awhb_rycut_h[2] > HWD_VIIF_AWB_GATE_UPPER)) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_rycut_l[0] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER)
+			return -EINVAL;
+
+		if (param->awhb_rycut_l[1] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER)
+			return -EINVAL;
+
+		if (param->awhb_rycut_l[2] > HWD_VIIF_AWB_UNSIGNED_GATE_UPPER)
+			return -EINVAL;
+
+		if ((param->awhb_awbsftu < HWD_VIIF_AWB_GATE_LOWER) ||
+		    (param->awhb_awbsftu > HWD_VIIF_AWB_GATE_UPPER)) {
+			return -EINVAL;
+		}
+		if ((param->awhb_awbsftv < HWD_VIIF_AWB_GATE_LOWER) ||
+		    (param->awhb_awbsftv > HWD_VIIF_AWB_GATE_UPPER)) {
+			return -EINVAL;
+		}
+
+		if ((param->awhb_awbhuecor != HWD_VIIF_ENABLE) &&
+		    (param->awhb_awbhuecor != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_awbspd > HWD_VIIF_AWB_MAX_UV_CONVERGENCE_SPEED) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_awbulv > HWD_VIIF_AWB_MAX_UV_CONVERGENCE_LEVEL) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_awbvlv > HWD_VIIF_AWB_MAX_UV_CONVERGENCE_LEVEL) {
+			return -EINVAL;
+		}
+
+		if (param->awhb_awbondot > HWD_VIIF_AWB_INTEGRATION_STOP_TH)
+			return -EINVAL;
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
+			ret = -EINVAL;
+			break;
+		}
+
+		if (ret != 0)
+			return ret;
+	}
+
+	writel(awhb_wbmrg, &(res->capture_reg->l1isp.L1_AWHB_WBMRG));
+	writel(awhb_wbmgg, &(res->capture_reg->l1isp.L1_AWHB_WBMGG));
+	writel(awhb_wbmbg, &(res->capture_reg->l1isp.L1_AWHB_WBMBG));
+
+	val = readl(&res->capture_reg->l1isp.L1_AWHB_SW) & 0xffffff7fU;
+
+	if (param != NULL) {
+		val |= (HWD_VIIF_ENABLE << 7U);
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_SW));
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
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_GATE_CONF0));
+
+		val = (param->awhb_ygatesw << 5U) | (param->awhb_hexsw << 4U) |
+		      (param->awhb_areamode);
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_GATE_CONF1));
+
+		writel(param->awhb_area_hsize, &(res->capture_reg->l1isp.L1_AWHB_AREA_HSIZE));
+		writel(param->awhb_area_vsize, &(res->capture_reg->l1isp.L1_AWHB_AREA_VSIZE));
+		writel(param->awhb_area_hofs, &(res->capture_reg->l1isp.L1_AWHB_AREA_HOFS));
+		writel(param->awhb_area_vofs, &(res->capture_reg->l1isp.L1_AWHB_AREA_VOFS));
+
+		writel(param->awhb_area_maskh, &(res->capture_reg->l1isp.L1_AWHB_AREA_MASKH));
+		writel(param->awhb_area_maskl, &(res->capture_reg->l1isp.L1_AWHB_AREA_MASKL));
+
+		val = (param->awhb_sq_sw[0] << 7U) | (param->awhb_sq_pol[0] << 6U) |
+		      (param->awhb_sq_sw[1] << 5U) | (param->awhb_sq_pol[1] << 4U) |
+		      (param->awhb_sq_sw[2] << 3U) | (param->awhb_sq_pol[2] << 2U);
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_SQ_CONF));
+
+		writel((uint32_t)param->awhb_ygateh, &(res->capture_reg->l1isp.L1_AWHB_YGATEH));
+		writel((uint32_t)param->awhb_ygatel, &(res->capture_reg->l1isp.L1_AWHB_YGATEL));
+
+		writel(param->awhb_bycut0p, &(res->capture_reg->l1isp.L1_AWHB_BYCUT0P));
+		writel(param->awhb_bycut0n, &(res->capture_reg->l1isp.L1_AWHB_BYCUT0N));
+		writel(param->awhb_rycut0p, &(res->capture_reg->l1isp.L1_AWHB_RYCUT0P));
+		writel(param->awhb_rycut0n, &(res->capture_reg->l1isp.L1_AWHB_RYCUT0N));
+
+		val = (uint32_t)param->awhb_rbcut0h & 0xffU;
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_RBCUT0H));
+		val = (uint32_t)param->awhb_rbcut0l & 0xffU;
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_RBCUT0L));
+
+		val = (uint32_t)param->awhb_bycut_h[0] & 0xffU;
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_BYCUT1H));
+		writel(param->awhb_bycut_l[0], &(res->capture_reg->l1isp.L1_AWHB_BYCUT1L));
+		val = (uint32_t)param->awhb_bycut_h[1] & 0xffU;
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_BYCUT2H));
+		writel(param->awhb_bycut_l[1], &(res->capture_reg->l1isp.L1_AWHB_BYCUT2L));
+		val = (uint32_t)param->awhb_bycut_h[2] & 0xffU;
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_BYCUT3H));
+		writel(param->awhb_bycut_l[2], &(res->capture_reg->l1isp.L1_AWHB_BYCUT3L));
+
+		val = (uint32_t)param->awhb_rycut_h[0] & 0xffU;
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_RYCUT1H));
+		writel(param->awhb_rycut_l[0], &(res->capture_reg->l1isp.L1_AWHB_RYCUT1L));
+		val = (uint32_t)param->awhb_rycut_h[1] & 0xffU;
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_RYCUT2H));
+		writel(param->awhb_rycut_l[1], &(res->capture_reg->l1isp.L1_AWHB_RYCUT2L));
+		val = (uint32_t)param->awhb_rycut_h[2] & 0xffU;
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_RYCUT3H));
+		writel(param->awhb_rycut_l[2], &(res->capture_reg->l1isp.L1_AWHB_RYCUT3L));
+
+		val = (uint32_t)param->awhb_awbsftu & 0xffU;
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_AWBSFTU));
+		val = (uint32_t)param->awhb_awbsftv & 0xffU;
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_AWBSFTV));
+
+		val = (param->awhb_awbhuecor << 4U) | (param->awhb_awbspd);
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_AWBSPD));
+
+		writel(param->awhb_awbulv, &(res->capture_reg->l1isp.L1_AWHB_AWBULV));
+		writel(param->awhb_awbvlv, &(res->capture_reg->l1isp.L1_AWHB_AWBVLV));
+		writel((uint32_t)param->awhb_awbwait, &(res->capture_reg->l1isp.L1_AWHB_AWBWAIT));
+
+		writel(param->awhb_awbondot, &(res->capture_reg->l1isp.L1_AWHB_AWBONDOT));
+		writel(param->awhb_awbfztim, &(res->capture_reg->l1isp.L1_AWHB_AWBFZTIM));
+
+		writel((uint32_t)param->awhb_wbgrmax, &(res->capture_reg->l1isp.L1_AWHB_WBGRMAX));
+		writel((uint32_t)param->awhb_wbgbmax, &(res->capture_reg->l1isp.L1_AWHB_WBGBMAX));
+		writel((uint32_t)param->awhb_wbgrmin, &(res->capture_reg->l1isp.L1_AWHB_WBGRMIN));
+		writel((uint32_t)param->awhb_wbgbmin, &(res->capture_reg->l1isp.L1_AWHB_WBGBMIN));
+
+	} else {
+		/* disable awb */
+		writel(val, &(res->capture_reg->l1isp.L1_AWHB_SW));
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_lock_awb_gain() - Configure L1ISP lock auto white balance gain.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @enable: enable/disable lock AWB gain
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "enable" is neither HWD_VIIF_ENABLE nor HWD_VIIF_DISABLE
+ */
+int32_t hwd_VIIF_l1_lock_awb_gain(uint32_t module_id, uint32_t regbuf_id, uint32_t enable)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val;
+
+	if ((enable != HWD_VIIF_ENABLE) && (enable != HWD_VIIF_DISABLE))
+		return -EINVAL;
+
+	val = readl(&res->capture_reg->l1isp.L1_AWHB_SW) & 0xffffffdfU;
+	val |= (enable << 5U);
+	writel(val, &(res->capture_reg->l1isp.L1_AWHB_SW));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_hdrc() - Configure L1ISP HDR compression parameters.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @param: pointer to HDR compression parameters
+ * @hdrc_thr_sft_amt: shift value in case of through mode [0..8]
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ * - hdrc_thr_sft_amt is out of range when param is NULL
+ * - hdrc_thr_sft_amt is not 0 when param is not NULL
+ */
+int32_t hwd_VIIF_l1_set_hdrc(uint32_t module_id, uint32_t regbuf_id,
+			     const struct hwd_viif_l1_hdrc *param, uint32_t hdrc_thr_sft_amt)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val, sw_delay1;
+
+	if (param != NULL) {
+		if (hdrc_thr_sft_amt != 0U)
+			return -EINVAL;
+
+		if ((param->hdrc_ratio < HWD_VIIF_L1_HDRC_MIN_INPUT_DATA_WIDTH) ||
+		    (param->hdrc_ratio > HWD_VIIF_L1_HDRC_MAX_INPUT_DATA_WIDTH)) {
+			return -EINVAL;
+		}
+
+		if (param->hdrc_pt_ratio > HWD_VIIF_L1_HDRC_MAX_PT_SLOPE)
+			return -EINVAL;
+
+		if (param->hdrc_pt_blend > HWD_VIIF_L1_HDRC_MAX_BLEND_RATIO)
+			return -EINVAL;
+
+		if (param->hdrc_pt_blend2 > HWD_VIIF_L1_HDRC_MAX_BLEND_RATIO)
+			return -EINVAL;
+
+		if ((param->hdrc_pt_blend + param->hdrc_pt_blend2) >
+		    HWD_VIIF_L1_HDRC_MAX_BLEND_RATIO) {
+			return -EINVAL;
+		}
+
+		if ((param->hdrc_tn_type != HWD_VIIF_L1_HDRC_TONE_USER) &&
+		    (param->hdrc_tn_type != HWD_VIIF_L1_HDRC_TONE_PRESET)) {
+			return -EINVAL;
+		}
+
+		if (param->hdrc_flr_val > HWD_VIIF_L1_HDRC_MAX_FLARE_VAL)
+			return -EINVAL;
+
+		if ((param->hdrc_flr_adp != HWD_VIIF_ENABLE) &&
+		    (param->hdrc_flr_adp != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if ((param->hdrc_ybr_off != HWD_VIIF_ENABLE) &&
+		    (param->hdrc_ybr_off != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		if (param->hdrc_orgy_blend > HWD_VIIF_L1_HDRC_MAX_BLEND_LUMA)
+			return -EINVAL;
+
+	} else {
+		if (hdrc_thr_sft_amt > HWD_VIIF_L1_HDRC_MAX_THROUGH_SHIFT_VAL)
+			return -EINVAL;
+	}
+
+	if (param != NULL) {
+		writel((param->hdrc_ratio - HWD_VIIF_L1_HDRC_RATIO_OFFSET),
+		       &(res->capture_reg->l1isp.L1_HDRC_RATIO));
+		writel(param->hdrc_pt_ratio, &(res->capture_reg->l1isp.L1_HDRC_PT_RATIO));
+
+		writel(param->hdrc_pt_blend, &(res->capture_reg->l1isp.L1_HDRC_PT_BLEND));
+		writel(param->hdrc_pt_blend2, &(res->capture_reg->l1isp.L1_HDRC_PT_BLEND2));
+
+		writel(param->hdrc_pt_sat, &(res->capture_reg->l1isp.L1_HDRC_PT_SAT));
+		writel(param->hdrc_tn_type, &(res->capture_reg->l1isp.L1_HDRC_TN_TYPE));
+
+		writel(param->hdrc_utn_tbl[0], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL0));
+		writel(param->hdrc_utn_tbl[1], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL1));
+		writel(param->hdrc_utn_tbl[2], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL2));
+		writel(param->hdrc_utn_tbl[3], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL3));
+		writel(param->hdrc_utn_tbl[4], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL4));
+		writel(param->hdrc_utn_tbl[5], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL5));
+		writel(param->hdrc_utn_tbl[6], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL6));
+		writel(param->hdrc_utn_tbl[7], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL7));
+		writel(param->hdrc_utn_tbl[8], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL8));
+		writel(param->hdrc_utn_tbl[9], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL9));
+		writel(param->hdrc_utn_tbl[10], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL10));
+		writel(param->hdrc_utn_tbl[11], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL11));
+		writel(param->hdrc_utn_tbl[12], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL12));
+		writel(param->hdrc_utn_tbl[13], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL13));
+		writel(param->hdrc_utn_tbl[14], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL14));
+		writel(param->hdrc_utn_tbl[15], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL15));
+		writel(param->hdrc_utn_tbl[16], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL16));
+		writel(param->hdrc_utn_tbl[17], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL17));
+		writel(param->hdrc_utn_tbl[18], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL18));
+		writel(param->hdrc_utn_tbl[19], &(res->capture_reg->l1isp.L1_HDRC_UTN_TBL19));
+
+		writel(param->hdrc_flr_val, &(res->capture_reg->l1isp.L1_HDRC_FLR_VAL));
+		writel(param->hdrc_flr_adp, &(res->capture_reg->l1isp.L1_HDRC_FLR_ADP));
+
+		writel(param->hdrc_ybr_off, &(res->capture_reg->l1isp.L1_HDRC_YBR_OFF));
+		writel(param->hdrc_orgy_blend, &(res->capture_reg->l1isp.L1_HDRC_ORGY_BLEND));
+
+		val = ((readl(&res->capture_reg->l1isp.L1_SYSM_HEIGHT)) % 64U) / 2U;
+		writel(val, &(res->capture_reg->l1isp.L1_HDRC_MAR_TOP));
+		val = ((readl(&res->capture_reg->l1isp.L1_SYSM_WIDTH)) % 64U) / 2U;
+		writel(val, &(res->capture_reg->l1isp.L1_HDRC_MAR_LEFT));
+
+		writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_HDRC_EN));
+
+		/* update of sw_delay1 must be done when MAIN unit is NOT running. */
+		if (res->run_flag_main == false) {
+			sw_delay1 = (uint32_t)((HWD_VIIF_REGBUF_ACCESS_TIME *
+						(uint64_t)res->pixel_clock) /
+					       ((uint64_t)res->htotal_size * HWD_VIIF_SYS_CLK)) +
+				    HWD_VIIF_L1_DELAY_W_HDRC + 1U;
+			val = readl(&res->capture_reg->sys.INT_M1_LINE) & 0xffffU;
+			val |= (sw_delay1 << 16U);
+			writel(val, &(res->capture_reg->sys.INT_M1_LINE));
+			/* M2_LINE is the same condition as M1_LINE */
+			writel(val, &(res->capture_reg->sys.INT_M2_LINE));
+		}
+	} else {
+		writel(hdrc_thr_sft_amt, &(res->capture_reg->l1isp.L1_HDRC_THR_SFT_AMT));
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_HDRC_EN));
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_hdrc_ltm() - Configure L1ISP HDR compression local tone mapping parameters.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @param: pointer to HDR compression local tone mapping parameters
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL
+ * - "param" is NULL
+ * - each parameter of "param" is out of range
+ */
+int32_t hwd_VIIF_l1_set_hdrc_ltm(uint32_t module_id, uint32_t regbuf_id,
+				 const struct hwd_viif_l1_hdrc_ltm *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val;
+	uint32_t idx;
+
+	if (param == NULL)
+		return -EINVAL;
+
+	if (param->tnp_max >= HWD_VIIF_L1_HDRC_MAX_LTM_TONE_BLEND_RATIO)
+		return -EINVAL;
+
+	if (param->tnp_mag >= HWD_VIIF_L1_HDRC_MAX_LTM_MAGNIFICATION)
+		return -EINVAL;
+
+	val = (uint32_t)param->tnp_fil[0];
+	for (idx = 1; idx < 5U; idx++)
+		val += (uint32_t)param->tnp_fil[idx] * 2U;
+
+	if (val != 1024U)
+		return -EINVAL;
+
+	writel(param->tnp_max, &(res->capture_reg->l1isp.L1_HDRC_TNP_MAX));
+
+	writel(param->tnp_mag, &(res->capture_reg->l1isp.L1_HDRC_TNP_MAG));
+
+	writel((uint32_t)param->tnp_fil[0], &(res->capture_reg->l1isp.L1_HDRC_TNP_FIL0));
+	writel((uint32_t)param->tnp_fil[1], &(res->capture_reg->l1isp.L1_HDRC_TNP_FIL1));
+	writel((uint32_t)param->tnp_fil[2], &(res->capture_reg->l1isp.L1_HDRC_TNP_FIL2));
+	writel((uint32_t)param->tnp_fil[3], &(res->capture_reg->l1isp.L1_HDRC_TNP_FIL3));
+	writel((uint32_t)param->tnp_fil[4], &(res->capture_reg->l1isp.L1_HDRC_TNP_FIL4));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_gamma() - Configure L1ISP gamma correction parameters.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @param: pointer to gamma correction parameters
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ */
+int32_t hwd_VIIF_l1_set_gamma(uint32_t module_id, uint32_t regbuf_id,
+			      const struct hwd_viif_l1_gamma *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t idx;
+
+	if (param != NULL) {
+		for (idx = 0; idx < 44U; idx++) {
+			if (param->gam_p[idx] > HWD_VIIF_L1_GAMMA_MAX_VAL)
+				return -EINVAL;
+		}
+	}
+
+	if (param != NULL) {
+		writel(param->gam_p[0], &(res->capture_reg->l1isp.L1_VPRO_GAM01P));
+		writel(param->gam_p[1], &(res->capture_reg->l1isp.L1_VPRO_GAM02P));
+		writel(param->gam_p[2], &(res->capture_reg->l1isp.L1_VPRO_GAM03P));
+		writel(param->gam_p[3], &(res->capture_reg->l1isp.L1_VPRO_GAM04P));
+		writel(param->gam_p[4], &(res->capture_reg->l1isp.L1_VPRO_GAM05P));
+		writel(param->gam_p[5], &(res->capture_reg->l1isp.L1_VPRO_GAM06P));
+		writel(param->gam_p[6], &(res->capture_reg->l1isp.L1_VPRO_GAM07P));
+		writel(param->gam_p[7], &(res->capture_reg->l1isp.L1_VPRO_GAM08P));
+		writel(param->gam_p[8], &(res->capture_reg->l1isp.L1_VPRO_GAM09P));
+		writel(param->gam_p[9], &(res->capture_reg->l1isp.L1_VPRO_GAM10P));
+		writel(param->gam_p[10], &(res->capture_reg->l1isp.L1_VPRO_GAM11P));
+		writel(param->gam_p[11], &(res->capture_reg->l1isp.L1_VPRO_GAM12P));
+		writel(param->gam_p[12], &(res->capture_reg->l1isp.L1_VPRO_GAM13P));
+		writel(param->gam_p[13], &(res->capture_reg->l1isp.L1_VPRO_GAM14P));
+		writel(param->gam_p[14], &(res->capture_reg->l1isp.L1_VPRO_GAM15P));
+		writel(param->gam_p[15], &(res->capture_reg->l1isp.L1_VPRO_GAM16P));
+		writel(param->gam_p[16], &(res->capture_reg->l1isp.L1_VPRO_GAM17P));
+		writel(param->gam_p[17], &(res->capture_reg->l1isp.L1_VPRO_GAM18P));
+		writel(param->gam_p[18], &(res->capture_reg->l1isp.L1_VPRO_GAM19P));
+		writel(param->gam_p[19], &(res->capture_reg->l1isp.L1_VPRO_GAM20P));
+		writel(param->gam_p[20], &(res->capture_reg->l1isp.L1_VPRO_GAM21P));
+		writel(param->gam_p[21], &(res->capture_reg->l1isp.L1_VPRO_GAM22P));
+		writel(param->gam_p[22], &(res->capture_reg->l1isp.L1_VPRO_GAM23P));
+		writel(param->gam_p[23], &(res->capture_reg->l1isp.L1_VPRO_GAM24P));
+		writel(param->gam_p[24], &(res->capture_reg->l1isp.L1_VPRO_GAM25P));
+		writel(param->gam_p[25], &(res->capture_reg->l1isp.L1_VPRO_GAM26P));
+		writel(param->gam_p[26], &(res->capture_reg->l1isp.L1_VPRO_GAM27P));
+		writel(param->gam_p[27], &(res->capture_reg->l1isp.L1_VPRO_GAM28P));
+		writel(param->gam_p[28], &(res->capture_reg->l1isp.L1_VPRO_GAM29P));
+		writel(param->gam_p[29], &(res->capture_reg->l1isp.L1_VPRO_GAM30P));
+		writel(param->gam_p[30], &(res->capture_reg->l1isp.L1_VPRO_GAM31P));
+		writel(param->gam_p[31], &(res->capture_reg->l1isp.L1_VPRO_GAM32P));
+		writel(param->gam_p[32], &(res->capture_reg->l1isp.L1_VPRO_GAM33P));
+		writel(param->gam_p[33], &(res->capture_reg->l1isp.L1_VPRO_GAM34P));
+		writel(param->gam_p[34], &(res->capture_reg->l1isp.L1_VPRO_GAM35P));
+		writel(param->gam_p[35], &(res->capture_reg->l1isp.L1_VPRO_GAM36P));
+		writel(param->gam_p[36], &(res->capture_reg->l1isp.L1_VPRO_GAM37P));
+		writel(param->gam_p[37], &(res->capture_reg->l1isp.L1_VPRO_GAM38P));
+		writel(param->gam_p[38], &(res->capture_reg->l1isp.L1_VPRO_GAM39P));
+		writel(param->gam_p[39], &(res->capture_reg->l1isp.L1_VPRO_GAM40P));
+		writel(param->gam_p[40], &(res->capture_reg->l1isp.L1_VPRO_GAM41P));
+		writel(param->gam_p[41], &(res->capture_reg->l1isp.L1_VPRO_GAM42P));
+		writel(param->gam_p[42], &(res->capture_reg->l1isp.L1_VPRO_GAM43P));
+		writel(param->gam_p[43], &(res->capture_reg->l1isp.L1_VPRO_GAM44P));
+		writel(param->blkadj, &(res->capture_reg->l1isp.L1_VPRO_BLKADJ));
+		writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_VPRO_PGC_SW));
+	} else {
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_PGC_SW));
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_img_quality_adjustment() - Configure L1ISP image quality adjustment.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @param: pointer to image quality adjustment parameters; NULL means disabling
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ */
+int32_t
+hwd_VIIF_l1_set_img_quality_adjustment(uint32_t module_id, uint32_t regbuf_id,
+				       const struct hwd_viif_l1_img_quality_adjustment *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val;
+
+	if (param != NULL) {
+		if (param->lum_noise_reduction != NULL) {
+			if (param->lum_noise_reduction->gain_min >
+			    param->lum_noise_reduction->gain_max) {
+				return -EINVAL;
+			}
+			if (param->lum_noise_reduction->lim_min >
+			    param->lum_noise_reduction->lim_max) {
+				return -EINVAL;
+			}
+		}
+
+		if (param->edge_enhancement != NULL) {
+			if (param->edge_enhancement->gain_min > param->edge_enhancement->gain_max) {
+				return -EINVAL;
+			}
+			if (param->edge_enhancement->lim_min > param->edge_enhancement->lim_max) {
+				return -EINVAL;
+			}
+			if (param->edge_enhancement->coring_min >
+			    param->edge_enhancement->coring_max) {
+				return -EINVAL;
+			}
+		}
+
+		if (param->uv_suppression != NULL) {
+			if (param->uv_suppression->bk_mp >= HWD_VIIF_L1_SUPPRESSION_MAX_VAL) {
+				return -EINVAL;
+			}
+			if (param->uv_suppression->black >= HWD_VIIF_L1_SUPPRESSION_MAX_VAL) {
+				return -EINVAL;
+			}
+			if (param->uv_suppression->wh_mp >= HWD_VIIF_L1_SUPPRESSION_MAX_VAL) {
+				return -EINVAL;
+			}
+			if (param->uv_suppression->white >= HWD_VIIF_L1_SUPPRESSION_MAX_VAL) {
+				return -EINVAL;
+			}
+			if (param->uv_suppression->bk_slv >= param->uv_suppression->wh_slv) {
+				return -EINVAL;
+			}
+		}
+
+		if (param->coring_suppression != NULL) {
+			if (param->coring_suppression->gain_min >
+			    param->coring_suppression->gain_max) {
+				return -EINVAL;
+			}
+			if (param->coring_suppression->lv_min > param->coring_suppression->lv_max) {
+				return -EINVAL;
+			}
+		}
+
+		if (param->edge_suppression != NULL) {
+			if (param->edge_suppression->lim > HWD_VIIF_L1_EDGE_SUPPRESSION_MAX_LIMIT) {
+				return -EINVAL;
+			}
+		}
+
+		if (param->color_level != NULL) {
+			if (param->color_level->cb_gain >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN) {
+				return -EINVAL;
+			}
+			if (param->color_level->cr_gain >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN) {
+				return -EINVAL;
+			}
+			if (param->color_level->cbr_mgain_min >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN) {
+				return -EINVAL;
+			}
+			if (param->color_level->cbp_gain_max >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN) {
+				return -EINVAL;
+			}
+			if (param->color_level->cbm_gain_max >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN) {
+				return -EINVAL;
+			}
+			if (param->color_level->crp_gain_max >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN) {
+				return -EINVAL;
+			}
+			if (param->color_level->crm_gain_max >= HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN) {
+				return -EINVAL;
+			}
+		}
+
+		if ((param->color_noise_reduction_enable != HWD_VIIF_ENABLE) &&
+		    (param->color_noise_reduction_enable != HWD_VIIF_DISABLE)) {
+			return -EINVAL;
+		}
+
+		/* RGB to YUV */
+		writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_VPRO_YUVC_SW));
+		writel((uint32_t)param->coef_cb, &(res->capture_reg->l1isp.L1_VPRO_Cb_MAT));
+		writel((uint32_t)param->coef_cr, &(res->capture_reg->l1isp.L1_VPRO_Cr_MAT));
+
+		/* brightness */
+		val = (uint32_t)param->brightness & 0xffffU;
+		if (val != 0U) {
+			writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_VPRO_BRIGHT_SW));
+			writel(val, &(res->capture_reg->l1isp.L1_VPRO_BRIGHT));
+		} else {
+			writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_BRIGHT_SW));
+		}
+
+		/* linear contrast */
+		if ((uint32_t)param->linear_contrast != 128U) {
+			writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_VPRO_LCNT_SW));
+			writel((uint32_t)param->linear_contrast,
+			       &(res->capture_reg->l1isp.L1_VPRO_LCONT_LEV));
+		} else {
+			writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_LCNT_SW));
+		}
+
+		/* nonlinear contrast */
+		if (param->nonlinear_contrast != NULL) {
+			writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_VPRO_NLCNT_SW));
+			writel((uint32_t)param->nonlinear_contrast->blk_knee,
+			       &(res->capture_reg->l1isp.L1_VPRO_BLK_KNEE));
+			writel((uint32_t)param->nonlinear_contrast->wht_knee,
+			       &(res->capture_reg->l1isp.L1_VPRO_WHT_KNEE));
+
+			writel((uint32_t)param->nonlinear_contrast->blk_cont[0],
+			       &(res->capture_reg->l1isp.L1_VPRO_BLK_CONT0));
+			writel((uint32_t)param->nonlinear_contrast->blk_cont[1],
+			       &(res->capture_reg->l1isp.L1_VPRO_BLK_CONT1));
+			writel((uint32_t)param->nonlinear_contrast->blk_cont[2],
+			       &(res->capture_reg->l1isp.L1_VPRO_BLK_CONT2));
+
+			writel((uint32_t)param->nonlinear_contrast->wht_cont[0],
+			       &(res->capture_reg->l1isp.L1_VPRO_WHT_CONT0));
+			writel((uint32_t)param->nonlinear_contrast->wht_cont[1],
+			       &(res->capture_reg->l1isp.L1_VPRO_WHT_CONT1));
+			writel((uint32_t)param->nonlinear_contrast->wht_cont[2],
+			       &(res->capture_reg->l1isp.L1_VPRO_WHT_CONT2));
+		} else {
+			writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_NLCNT_SW));
+		}
+
+		/* luminance noise reduction */
+		if (param->lum_noise_reduction != NULL) {
+			writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_VPRO_YNR_SW));
+			writel((uint32_t)param->lum_noise_reduction->gain_min,
+			       &(res->capture_reg->l1isp.L1_VPRO_YNR_GAIN_MIN));
+			writel((uint32_t)param->lum_noise_reduction->gain_max,
+			       &(res->capture_reg->l1isp.L1_VPRO_YNR_GAIN_MAX));
+			writel((uint32_t)param->lum_noise_reduction->lim_min,
+			       &(res->capture_reg->l1isp.L1_VPRO_YNR_LIM_MIN));
+			writel((uint32_t)param->lum_noise_reduction->lim_max,
+			       &(res->capture_reg->l1isp.L1_VPRO_YNR_LIM_MAX));
+		} else {
+			writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_YNR_SW));
+		}
+
+		/* edge enhancement */
+		if (param->edge_enhancement != NULL) {
+			writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_VPRO_ETE_SW));
+			writel((uint32_t)param->edge_enhancement->gain_min,
+			       &(res->capture_reg->l1isp.L1_VPRO_ETE_GAIN_MIN));
+			writel((uint32_t)param->edge_enhancement->gain_max,
+			       &(res->capture_reg->l1isp.L1_VPRO_ETE_GAIN_MAX));
+			writel((uint32_t)param->edge_enhancement->lim_min,
+			       &(res->capture_reg->l1isp.L1_VPRO_ETE_LIM_MIN));
+			writel((uint32_t)param->edge_enhancement->lim_max,
+			       &(res->capture_reg->l1isp.L1_VPRO_ETE_LIM_MAX));
+			writel((uint32_t)param->edge_enhancement->coring_min,
+			       &(res->capture_reg->l1isp.L1_VPRO_ETE_CORING_MIN));
+			writel((uint32_t)param->edge_enhancement->coring_max,
+			       &(res->capture_reg->l1isp.L1_VPRO_ETE_CORING_MAX));
+		} else {
+			writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_ETE_SW));
+		}
+
+		/* UV suppression */
+		if (param->uv_suppression != NULL) {
+			writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_VPRO_CSUP_UVSUP_SW));
+			writel((uint32_t)param->uv_suppression->bk_slv,
+			       &(res->capture_reg->l1isp.L1_VPRO_CSUP_BK_SLV));
+			writel(param->uv_suppression->bk_mp,
+			       &(res->capture_reg->l1isp.L1_VPRO_CSUP_BK_MP));
+			writel(param->uv_suppression->black,
+			       &(res->capture_reg->l1isp.L1_VPRO_CSUP_BLACK));
+
+			writel((uint32_t)param->uv_suppression->wh_slv,
+			       &(res->capture_reg->l1isp.L1_VPRO_CSUP_WH_SLV));
+			writel(param->uv_suppression->wh_mp,
+			       &(res->capture_reg->l1isp.L1_VPRO_CSUP_WH_MP));
+			writel(param->uv_suppression->white,
+			       &(res->capture_reg->l1isp.L1_VPRO_CSUP_WHITE));
+		} else {
+			writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_CSUP_UVSUP_SW));
+		}
+
+		/* coring suppression */
+		if (param->coring_suppression != NULL) {
+			writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_SW));
+			writel((uint32_t)param->coring_suppression->lv_min,
+			       &(res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_LV_MIN));
+			writel((uint32_t)param->coring_suppression->lv_max,
+			       &(res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_LV_MAX));
+			writel((uint32_t)param->coring_suppression->gain_min,
+			       &(res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_GAIN_MIN));
+			writel((uint32_t)param->coring_suppression->gain_max,
+			       &(res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_GAIN_MAX));
+		} else {
+			writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_SW));
+		}
+
+		/* edge suppression */
+		if (param->edge_suppression != NULL) {
+			writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_SW));
+			writel((uint32_t)param->edge_suppression->gain,
+			       &(res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_GAIN));
+			writel((uint32_t)param->edge_suppression->lim,
+			       &(res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_LIM));
+		} else {
+			writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_SW));
+		}
+
+		/* color level */
+		if (param->color_level != NULL) {
+			writel(param->color_level->cb_gain,
+			       &(res->capture_reg->l1isp.L1_VPRO_Cb_GAIN));
+			writel(param->color_level->cr_gain,
+			       &(res->capture_reg->l1isp.L1_VPRO_Cr_GAIN));
+			writel(param->color_level->cbr_mgain_min,
+			       &(res->capture_reg->l1isp.L1_VPRO_Cbr_MGAIN_MIN));
+			writel(param->color_level->cbp_gain_max,
+			       &(res->capture_reg->l1isp.L1_VPRO_CbP_GAIN_MAX));
+			writel(param->color_level->cbm_gain_max,
+			       &(res->capture_reg->l1isp.L1_VPRO_CbM_GAIN_MAX));
+			writel(param->color_level->crp_gain_max,
+			       &(res->capture_reg->l1isp.L1_VPRO_CrP_GAIN_MAX));
+			writel(param->color_level->crm_gain_max,
+			       &(res->capture_reg->l1isp.L1_VPRO_CrM_GAIN_MAX));
+		} else {
+			/* disable */
+			writel(1024U, &(res->capture_reg->l1isp.L1_VPRO_Cb_GAIN));
+			writel(1024U, &(res->capture_reg->l1isp.L1_VPRO_Cr_GAIN));
+			writel(1024U, &(res->capture_reg->l1isp.L1_VPRO_Cbr_MGAIN_MIN));
+			writel(0U, &(res->capture_reg->l1isp.L1_VPRO_CbP_GAIN_MAX));
+			writel(0U, &(res->capture_reg->l1isp.L1_VPRO_CbM_GAIN_MAX));
+			writel(0U, &(res->capture_reg->l1isp.L1_VPRO_CrP_GAIN_MAX));
+			writel(0U, &(res->capture_reg->l1isp.L1_VPRO_CrM_GAIN_MAX));
+		}
+
+		/* color noise reduction */
+		writel(param->color_noise_reduction_enable,
+		       &(res->capture_reg->l1isp.L1_VPRO_CNR_SW));
+
+	} else {
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_YUVC_SW));
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_BRIGHT_SW));
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_LCNT_SW));
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_NLCNT_SW));
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_YNR_SW));
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_ETE_SW));
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_CSUP_UVSUP_SW));
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_CSUP_CORING_SW));
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_EDGE_SUP_SW));
+		writel(1024U, &(res->capture_reg->l1isp.L1_VPRO_Cb_GAIN));
+		writel(1024U, &(res->capture_reg->l1isp.L1_VPRO_Cr_GAIN));
+		writel(1024U, &(res->capture_reg->l1isp.L1_VPRO_Cbr_MGAIN_MIN));
+		writel(0U, &(res->capture_reg->l1isp.L1_VPRO_CbP_GAIN_MAX));
+		writel(0U, &(res->capture_reg->l1isp.L1_VPRO_CbM_GAIN_MAX));
+		writel(0U, &(res->capture_reg->l1isp.L1_VPRO_CrP_GAIN_MAX));
+		writel(0U, &(res->capture_reg->l1isp.L1_VPRO_CrM_GAIN_MAX));
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_VPRO_CNR_SW));
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_avg_lum_generation() - Configure L1ISP average luminance generation parameters.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @param: pointer to auto exposure parameters
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ */
+int32_t hwd_VIIF_l1_set_avg_lum_generation(uint32_t module_id, uint32_t regbuf_id,
+					   const struct hwd_viif_l1_avg_lum_generation *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val;
+	uint32_t idx, j;
+
+	if (param != NULL) {
+		val = readl(&res->capture_reg->l1isp.L1_SYSM_WIDTH);
+		if (param->aexp_start_x > (val - 1U))
+			return -EINVAL;
+
+		if ((param->aexp_block_width < HWD_VIIF_L1_AEXP_MIN_BLOCK_WIDTH) ||
+		    (param->aexp_block_width > val)) {
+			return -EINVAL;
+		}
+		if ((param->aexp_block_width % 64U) != 0U)
+			return -EINVAL;
+
+		val = readl(&res->capture_reg->l1isp.L1_SYSM_HEIGHT);
+		if (param->aexp_start_y > (val - 1U))
+			return -EINVAL;
+
+		if ((param->aexp_block_height < HWD_VIIF_L1_AEXP_MIN_BLOCK_HEIGHT) ||
+		    (param->aexp_block_height > val)) {
+			return -EINVAL;
+		}
+		if ((param->aexp_block_height % 64U) != 0U)
+			return -EINVAL;
+
+		for (idx = 0; idx < 8U; idx++) {
+			for (j = 0; j < 8U; j++) {
+				if (param->aexp_weight[idx][j] > HWD_VIIF_L1_AEXP_MAX_WEIGHT) {
+					return -EINVAL;
+				}
+			}
+		}
+
+		if (param->aexp_satur_ratio > HWD_VIIF_L1_AEXP_MAX_BLOCK_TH)
+			return -EINVAL;
+
+		if (param->aexp_black_ratio > HWD_VIIF_L1_AEXP_MAX_BLOCK_TH)
+			return -EINVAL;
+
+		if (param->aexp_satur_level > HWD_VIIF_L1_AEXP_MAX_SATURATION_PIXEL_TH) {
+			return -EINVAL;
+		}
+
+		for (idx = 0; idx < 4U; idx++) {
+			if (param->aexp_ave4linesy[idx] > (val - 4U))
+				return -EINVAL;
+		}
+	}
+
+	if (param != NULL) {
+		writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_AEXP_ON));
+		writel(param->aexp_start_x, &(res->capture_reg->l1isp.L1_AEXP_START_X));
+		writel(param->aexp_start_y, &(res->capture_reg->l1isp.L1_AEXP_START_Y));
+		writel(param->aexp_block_width, &(res->capture_reg->l1isp.L1_AEXP_BLOCK_WIDTH));
+		writel(param->aexp_block_height, &(res->capture_reg->l1isp.L1_AEXP_BLOCK_HEIGHT));
+
+		val = (param->aexp_weight[0][0] << 14U) | (param->aexp_weight[0][1] << 12U) |
+		      (param->aexp_weight[0][2] << 10U) | (param->aexp_weight[0][3] << 8U) |
+		      (param->aexp_weight[0][4] << 6U) | (param->aexp_weight[0][5] << 4U) |
+		      (param->aexp_weight[0][6] << 2U) | (param->aexp_weight[0][7]);
+		writel(val, &(res->capture_reg->l1isp.L1_AEXP_WEIGHT_0));
+
+		val = (param->aexp_weight[1][0] << 14U) | (param->aexp_weight[1][1] << 12U) |
+		      (param->aexp_weight[1][2] << 10U) | (param->aexp_weight[1][3] << 8U) |
+		      (param->aexp_weight[1][4] << 6U) | (param->aexp_weight[1][5] << 4U) |
+		      (param->aexp_weight[1][6] << 2U) | (param->aexp_weight[1][7]);
+		writel(val, &(res->capture_reg->l1isp.L1_AEXP_WEIGHT_1));
+
+		val = (param->aexp_weight[2][0] << 14U) | (param->aexp_weight[2][1] << 12U) |
+		      (param->aexp_weight[2][2] << 10U) | (param->aexp_weight[2][3] << 8U) |
+		      (param->aexp_weight[2][4] << 6U) | (param->aexp_weight[2][5] << 4U) |
+		      (param->aexp_weight[2][6] << 2U) | (param->aexp_weight[2][7]);
+		writel(val, &(res->capture_reg->l1isp.L1_AEXP_WEIGHT_2));
+
+		val = (param->aexp_weight[3][0] << 14U) | (param->aexp_weight[3][1] << 12U) |
+		      (param->aexp_weight[3][2] << 10U) | (param->aexp_weight[3][3] << 8U) |
+		      (param->aexp_weight[3][4] << 6U) | (param->aexp_weight[3][5] << 4U) |
+		      (param->aexp_weight[3][6] << 2U) | (param->aexp_weight[3][7]);
+		writel(val, &(res->capture_reg->l1isp.L1_AEXP_WEIGHT_3));
+
+		val = (param->aexp_weight[4][0] << 14U) | (param->aexp_weight[4][1] << 12U) |
+		      (param->aexp_weight[4][2] << 10U) | (param->aexp_weight[4][3] << 8U) |
+		      (param->aexp_weight[4][4] << 6U) | (param->aexp_weight[4][5] << 4U) |
+		      (param->aexp_weight[4][6] << 2U) | (param->aexp_weight[4][7]);
+		writel(val, &(res->capture_reg->l1isp.L1_AEXP_WEIGHT_4));
+
+		val = (param->aexp_weight[5][0] << 14U) | (param->aexp_weight[5][1] << 12U) |
+		      (param->aexp_weight[5][2] << 10U) | (param->aexp_weight[5][3] << 8U) |
+		      (param->aexp_weight[5][4] << 6U) | (param->aexp_weight[5][5] << 4U) |
+		      (param->aexp_weight[5][6] << 2U) | (param->aexp_weight[5][7]);
+		writel(val, &(res->capture_reg->l1isp.L1_AEXP_WEIGHT_5));
+
+		val = (param->aexp_weight[6][0] << 14U) | (param->aexp_weight[6][1] << 12U) |
+		      (param->aexp_weight[6][2] << 10U) | (param->aexp_weight[6][3] << 8U) |
+		      (param->aexp_weight[6][4] << 6U) | (param->aexp_weight[6][5] << 4U) |
+		      (param->aexp_weight[6][6] << 2U) | (param->aexp_weight[6][7]);
+		writel(val, &(res->capture_reg->l1isp.L1_AEXP_WEIGHT_6));
+
+		val = (param->aexp_weight[7][0] << 14U) | (param->aexp_weight[7][1] << 12U) |
+		      (param->aexp_weight[7][2] << 10U) | (param->aexp_weight[7][3] << 8U) |
+		      (param->aexp_weight[7][4] << 6U) | (param->aexp_weight[7][5] << 4U) |
+		      (param->aexp_weight[7][6] << 2U) | (param->aexp_weight[7][7]);
+		writel(val, &(res->capture_reg->l1isp.L1_AEXP_WEIGHT_7));
+
+		writel(param->aexp_satur_ratio, &(res->capture_reg->l1isp.L1_AEXP_SATUR_RATIO));
+		writel(param->aexp_black_ratio, &(res->capture_reg->l1isp.L1_AEXP_BLACK_RATIO));
+		writel(param->aexp_satur_level, &(res->capture_reg->l1isp.L1_AEXP_SATUR_LEVEL));
+
+		writel(param->aexp_ave4linesy[0], &(res->capture_reg->l1isp.L1_AEXP_AVE4LINESY0));
+		writel(param->aexp_ave4linesy[1], &(res->capture_reg->l1isp.L1_AEXP_AVE4LINESY1));
+		writel(param->aexp_ave4linesy[2], &(res->capture_reg->l1isp.L1_AEXP_AVE4LINESY2));
+		writel(param->aexp_ave4linesy[3], &(res->capture_reg->l1isp.L1_AEXP_AVE4LINESY3));
+
+	} else {
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_AEXP_ON));
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_histogram() - Configure L1ISP histogram parameters.
+ *
+ * @regbuf_id: ISP register buffer ID [0..3]
+ * @param: pointer to gamma correction parameters
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - each parameter of "param" is out of range
+ */
+int32_t hwd_VIIF_l1_set_histogram(uint32_t module_id, uint32_t regbuf_id,
+				  const struct hwd_viif_l1_histogram *param)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val;
+
+	if (param != NULL) {
+		if ((param->hist_bin_mode != HWD_VIIF_L1_HIST_BIN_MODE_LINEAR) &&
+		    (param->hist_bin_mode != HWD_VIIF_L1_HIST_BIN_MODE_LOG)) {
+			return -EINVAL;
+		}
+
+		val = readl(&res->capture_reg->l1isp.L1_SYSM_HEIGHT);
+		if (param->hist_block_v_ofst > (val - 1U))
+			return -EINVAL;
+
+		if ((param->hist_block_height == 0U) || (param->hist_block_height > val)) {
+			return -EINVAL;
+		}
+
+		val = readl(&res->capture_reg->l1isp.L1_SYSM_WIDTH);
+		if (param->hist_block_h_ofst > (val - 1U))
+			return -EINVAL;
+
+		if ((param->hist_block_width == 0U) || (param->hist_block_width > val)) {
+			return -EINVAL;
+		}
+
+		if ((param->hist_block_v_num == 0U) ||
+		    (param->hist_block_v_num > HWD_VIIF_L1_HIST_MAX_BLOCK_NUM)) {
+			return -EINVAL;
+		}
+		if ((param->hist_block_h_num == 0U) ||
+		    (param->hist_block_h_num > HWD_VIIF_L1_HIST_MAX_BLOCK_NUM)) {
+			return -EINVAL;
+		}
+
+		if (param->hist_block_v_step > HWD_VIIF_L1_HIST_MAX_STEP)
+			return -EINVAL;
+
+		if (param->hist_block_h_step > HWD_VIIF_L1_HIST_MAX_STEP)
+			return -EINVAL;
+
+		if (param->hist_linear_sft > HWD_VIIF_L1_HIST_MAX_BIN_SHIFT)
+			return -EINVAL;
+
+		if ((param->hist_add_a_r < HWD_VIIF_L1_HIST_MIN_ADD_A_COEF) ||
+		    (param->hist_add_a_r >= HWD_VIIF_L1_HIST_MAX_ADD_A_COEF)) {
+			return -EINVAL;
+		}
+		if ((param->hist_add_b_r < HWD_VIIF_L1_HIST_MIN_ADD_B_COEF) ||
+		    (param->hist_add_b_r >= HWD_VIIF_L1_HIST_MAX_COEF)) {
+			return -EINVAL;
+		}
+
+		if ((param->hist_add_a_g < HWD_VIIF_L1_HIST_MIN_ADD_A_COEF) ||
+		    (param->hist_add_a_g >= HWD_VIIF_L1_HIST_MAX_ADD_A_COEF)) {
+			return -EINVAL;
+		}
+		if ((param->hist_add_b_g < HWD_VIIF_L1_HIST_MIN_ADD_B_COEF) ||
+		    (param->hist_add_b_g >= HWD_VIIF_L1_HIST_MAX_COEF)) {
+			return -EINVAL;
+		}
+
+		if ((param->hist_add_a_b < HWD_VIIF_L1_HIST_MIN_ADD_A_COEF) ||
+		    (param->hist_add_a_b >= HWD_VIIF_L1_HIST_MAX_ADD_A_COEF)) {
+			return -EINVAL;
+		}
+		if ((param->hist_add_b_b < HWD_VIIF_L1_HIST_MIN_ADD_B_COEF) ||
+		    (param->hist_add_b_b >= HWD_VIIF_L1_HIST_MAX_COEF)) {
+			return -EINVAL;
+		}
+
+		if ((param->hist_add_a_y < HWD_VIIF_L1_HIST_MIN_ADD_A_COEF) ||
+		    (param->hist_add_a_y >= HWD_VIIF_L1_HIST_MAX_ADD_A_COEF)) {
+			return -EINVAL;
+		}
+		if ((param->hist_add_b_y < HWD_VIIF_L1_HIST_MIN_ADD_B_COEF) ||
+		    (param->hist_add_b_y >= HWD_VIIF_L1_HIST_MAX_COEF)) {
+			return -EINVAL;
+		}
+	}
+
+	if (param != NULL) {
+		val = ((uint32_t)HWD_VIIF_L1_HIST_COLOR_RGBY << 8U) | (param->hist_bin_mode);
+		writel(val, &(res->capture_reg->l1isp.L1_HIST_MODE));
+
+		val = (param->hist_block_v_ofst << 16U) | (param->hist_block_h_ofst);
+		writel(val, &(res->capture_reg->l1isp.L1_HIST_BLOCK_OFST));
+
+		val = (param->hist_block_height << 16U) | (param->hist_block_width);
+		writel(val, &(res->capture_reg->l1isp.L1_HIST_BLOCK_SIZE));
+
+		val = (param->hist_block_v_num << 16U) | (param->hist_block_h_num);
+		writel(val, &(res->capture_reg->l1isp.L1_HIST_BLOCK_NUM));
+
+		val = (param->hist_block_v_step << 16U) | (param->hist_block_h_step);
+		writel(val, &(res->capture_reg->l1isp.L1_HIST_BLOCK_STEP));
+
+		writel(param->hist_linear_sft, &(res->capture_reg->l1isp.L1_HIST_LINEAR_SFT));
+
+		/* R */
+		writel((uint32_t)param->hist_mult_a_r, &(res->capture_reg->l1isp.L1_HIST_MULT_A_R));
+		val = (uint32_t)param->hist_add_a_r & 0x1ffffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_HIST_ADD_A_R));
+		writel((uint32_t)param->hist_mult_b_r, &(res->capture_reg->l1isp.L1_HIST_MULT_B_R));
+		val = (uint32_t)param->hist_add_b_r & 0x1ffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_HIST_ADD_B_R));
+
+		/* G */
+		writel((uint32_t)param->hist_mult_a_g, &(res->capture_reg->l1isp.L1_HIST_MULT_A_G));
+		val = (uint32_t)param->hist_add_a_g & 0x1ffffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_HIST_ADD_A_G));
+		writel((uint32_t)param->hist_mult_b_g, &(res->capture_reg->l1isp.L1_HIST_MULT_B_G));
+		val = (uint32_t)param->hist_add_b_g & 0x1ffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_HIST_ADD_B_G));
+
+		/* B */
+		writel((uint32_t)param->hist_mult_a_b, &(res->capture_reg->l1isp.L1_HIST_MULT_A_B));
+		val = (uint32_t)param->hist_add_a_b & 0x1ffffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_HIST_ADD_A_B));
+		writel((uint32_t)param->hist_mult_b_b, &(res->capture_reg->l1isp.L1_HIST_MULT_B_B));
+		val = (uint32_t)param->hist_add_b_b & 0x1ffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_HIST_ADD_B_B));
+
+		/* Y */
+		writel((uint32_t)param->hist_mult_a_y, &(res->capture_reg->l1isp.L1_HIST_MULT_A_Y));
+		val = (uint32_t)param->hist_add_a_y & 0x1ffffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_HIST_ADD_A_Y));
+		writel((uint32_t)param->hist_mult_b_y, &(res->capture_reg->l1isp.L1_HIST_MULT_B_Y));
+		val = (uint32_t)param->hist_add_b_y & 0x1ffffU;
+		writel(val, &(res->capture_reg->l1isp.L1_HIST_ADD_B_Y));
+
+		writel(HWD_VIIF_ENABLE, &(res->capture_reg->l1isp.L1_HIST_EN));
+
+	} else {
+		writel(HWD_VIIF_DISABLE, &(res->capture_reg->l1isp.L1_HIST_EN));
+	}
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_histogram_transmission() - Configure L1ISP transferring histogram data.
+ *
+ * @buf: buffer address to store histogram data
+ * @block_v_num: the number of vertical block[1..8]
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: 0 operation completed successfully
+ * Return: -EINVAL Parameter error
+ * - "buf" is not 8byte alignment
+ * - "block_v_num" is out of range
+ */
+int32_t hwd_VIIF_l1_set_histogram_transmission(uint32_t module_id, uintptr_t buf,
+					       uint32_t block_v_num)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	uint32_t val = 0x0U;
+	uint32_t end_addr;
+
+	if ((block_v_num == 0U) || (block_v_num > HWD_VIIF_L1_HIST_MAX_BLOCK_NUM)) {
+		return -EINVAL;
+	}
+
+	if (buf != 0U) {
+		if ((buf % HWD_VIIF_L1_VDM_ALIGN) != 0U)
+			return -EINVAL;
+
+		/* VDM common settings */
+		writel(HWD_VIIF_L1_VDM_CFG_PARAM, &(res->capture_reg->vdm.w_port[2].VDM_W_CFG0));
+		writel(HWD_VIIF_L1_HIST_VDM_SRAM_BASE,
+		       &(res->capture_reg->vdm.w_port[2].VDM_W_SRAM_BASE));
+		writel(HWD_VIIF_L1_HIST_VDM_SRAM_SIZE,
+		       &(res->capture_reg->vdm.w_port[2].VDM_W_SRAM_SIZE));
+
+		writel((uint32_t)buf, &(res->capture_reg->vdm.w_port[2].VDM_W_STADR));
+		end_addr = (uint32_t)buf + HWD_VIIF_L1_HIST_VDM_SIZE - 1U;
+		writel(end_addr, &(res->capture_reg->vdm.w_port[2].VDM_W_ENDADR));
+
+		writel((block_v_num * 4U), &(res->capture_reg->vdm.w_port[2].VDM_W_HEIGHT));
+		writel(HWD_VIIF_L1_HIST_VDM_SIZE, &(res->capture_reg->vdm.w_port[2].VDM_W_PITCH));
+
+		val = 0x4U;
+	}
+
+	val |= (readl(&res->capture_reg->vdm.VDM_W_ENABLE) & 0xfffffffbU);
+	writel(val, &(res->capture_reg->vdm.VDM_W_ENABLE));
+
+	return 0;
+}
+
+/**
+ * hwd_VIIF_l1_set_irq_mask() - Set L1ISP interruption mask.
+ *
+ * @mask: pointer to mask setting
+ * @module_id: ID of each VIIF module; must be 0 or 1
+ * Return: None
+ */
+void hwd_VIIF_l1_set_irq_mask(uint32_t module_id, const uint32_t *mask)
+{
+	struct hwd_viif_res *res = viif_id2res(module_id);
+	writel(*mask, &(res->capture_reg->l1isp.L1_CRGBF_ISP_INT_MASK));
+}
diff --git a/drivers/media/platform/visconti/hwd_viif_reg.h b/drivers/media/platform/visconti/hwd_viif_reg.h
new file mode 100644
index 000000000..d6bc12024
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
+	uint32_t RESERVED_A_1;
+	uint32_t CSI2RX_NLANES;
+	uint32_t CSI2RX_RESETN;
+	uint32_t CSI2RX_INT_ST_MAIN;
+	uint32_t CSI2RX_DATA_IDS_1;
+	uint32_t CSI2RX_DATA_IDS_2;
+	uint32_t RESERVED_B_1[10];
+	uint32_t CSI2RX_PHY_SHUTDOWNZ;
+	uint32_t CSI2RX_PHY_RSTZ;
+	uint32_t CSI2RX_PHY_RX;
+	uint32_t CSI2RX_PHY_STOPSTATE;
+	uint32_t CSI2RX_PHY_TESTCTRL0;
+	uint32_t CSI2RX_PHY_TESTCTRL1;
+	uint32_t RESERVED_B_2[34];
+	uint32_t CSI2RX_INT_ST_PHY_FATAL;
+	uint32_t CSI2RX_INT_MSK_PHY_FATAL;
+	uint32_t CSI2RX_INT_FORCE_PHY_FATAL;
+	uint32_t RESERVED_B_3[1];
+	uint32_t CSI2RX_INT_ST_PKT_FATAL;
+	uint32_t CSI2RX_INT_MSK_PKT_FATAL;
+	uint32_t CSI2RX_INT_FORCE_PKT_FATAL;
+	uint32_t RESERVED_B_4[1];
+	uint32_t CSI2RX_INT_ST_FRAME_FATAL;
+	uint32_t CSI2RX_INT_MSK_FRAME_FATAL;
+	uint32_t CSI2RX_INT_FORCE_FRAME_FATAL;
+	uint32_t RESERVED_B_5[1];
+	uint32_t CSI2RX_INT_ST_PHY;
+	uint32_t CSI2RX_INT_MSK_PHY;
+	uint32_t CSI2RX_INT_FORCE_PHY;
+	uint32_t RESERVED_B_6[1];
+	uint32_t CSI2RX_INT_ST_PKT;
+	uint32_t CSI2RX_INT_MSK_PKT;
+	uint32_t CSI2RX_INT_FORCE_PKT;
+	uint32_t RESERVED_B_7[1];
+	uint32_t CSI2RX_INT_ST_LINE;
+	uint32_t CSI2RX_INT_MSK_LINE;
+	uint32_t CSI2RX_INT_FORCE_LINE;
+	uint32_t RESERVED_B_8[113];
+	uint32_t RESERVED_A_2;
+	uint32_t RESERVED_A_3;
+	uint32_t RESERVED_A_4;
+	uint32_t RESERVED_A_5;
+	uint32_t RESERVED_A_6;
+	uint32_t RESERVED_B_9[58];
+	uint32_t RESERVED_A_7;
+};
+
+/**
+ * struct hwd_viif_csc_reg - Registers for VIIF system control
+ */
+struct hwd_viif_csc_reg {
+	uint32_t MTB;
+	uint32_t RESERVED_B_16[3];
+	uint32_t MTB_YG_OFFSETI;
+	uint32_t MTB_YG1;
+	uint32_t MTB_YG2;
+	uint32_t MTB_YG_OFFSETO;
+	uint32_t MTB_CB_OFFSETI;
+	uint32_t MTB_CB1;
+	uint32_t MTB_CB2;
+	uint32_t MTB_CB_OFFSETO;
+	uint32_t MTB_CR_OFFSETI;
+	uint32_t MTB_CR1;
+	uint32_t MTB_CR2;
+	uint32_t MTB_CR_OFFSETO;
+};
+
+struct hwd_viif_system_reg {
+	uint32_t IPORTM0_LD;
+	uint32_t IPORTM1_LD;
+	uint32_t RESERVED_B_1[6];
+	uint32_t IPORTS0_LD;
+	uint32_t RESERVED_A_1;
+	uint32_t RESERVED_B_2[2];
+	uint32_t VCID0SELECT;
+	uint32_t VCID1SELECT;
+	uint32_t RESERVED_A_2;
+	uint32_t VCPORTEN;
+	uint32_t CSI2SELECT;
+	uint32_t CSI2THROUGHEN;
+	uint32_t RESERVED_B_3[2];
+	uint32_t IPORTM_TEST;
+	uint32_t IPORTM;
+	uint32_t IPORTM_MAIN_DT;
+	uint32_t IPORTM_MAIN_RAW;
+	uint32_t IPORTM_OTHER;
+	uint32_t IPORTM_OTHEREN;
+	uint32_t IPORTM_EMBEN;
+	uint32_t RESERVED_B_4[2];
+	uint32_t IPORTS;
+	uint32_t IPORTS_MAIN_DT;
+	uint32_t IPORTS_MAIN_RAW;
+	uint32_t IPORTS_OTHER;
+	uint32_t IPORTS_OTHEREN;
+	uint32_t IPORTS_EMBEN;
+	uint32_t IPORTS_IMGEN;
+	uint32_t RESERVED_A_3;
+	uint32_t RESERVED_A_4;
+	uint32_t RESERVED_B_5[2];
+	uint32_t IPORTI_M_SYNCEN;
+	uint32_t IPORTI_M_SYNCMODE;
+	uint32_t IPORTI_M_PIXFMT;
+	uint32_t RESERVED_B_6[5];
+	uint32_t TOTALSIZE_M;
+	uint32_t VALSIZE_M;
+	uint32_t BACK_PORCH_M;
+	uint32_t RESERVED_B_7[5];
+	uint32_t MAINIMG_PKTSIZE;
+	uint32_t MAINIMG_HEIGHT;
+	uint32_t MAINOTHER_PKTSIZE;
+	uint32_t MAINOTHER_HEIGHT;
+	uint32_t MAINEMBTOP_SIZE;
+	uint32_t MAINEMBBOT_SIZE;
+	uint32_t RESERVED_B_8[2];
+	uint32_t SUBIMG_PKTSIZE;
+	uint32_t SUBIMG_HEIGHT;
+	uint32_t SUBOTHER_PKTSIZE;
+	uint32_t SUBOTHER_HEIGHT;
+	uint32_t SUBEMBTOP_SIZE;
+	uint32_t SUBEMBBOT_SIZE;
+	uint32_t RESERVED_A_5;
+	uint32_t RESERVED_A_6;
+	uint32_t TESTAREA_M_START;
+	uint32_t TESTAREA_M_SIZE;
+	uint32_t RESERVED_B_9[2];
+	uint32_t INT_M_SYNC;
+	uint32_t INT_M_SYNC_MASK;
+	uint32_t INT_S_SYNC;
+	uint32_t INT_S_SYNC_MASK;
+	uint32_t INT_M0_LINE;
+	uint32_t INT_M1_LINE;
+	uint32_t INT_M2_LINE;
+	uint32_t RESERVED_B_10[5];
+	uint32_t INT_SA0_LINE;
+	uint32_t INT_SA1_LINE;
+	uint32_t RESERVED_B_11[2];
+	uint32_t RESERVED_A_9;
+	uint32_t RESERVED_A_10;
+	uint32_t RESERVED_B_12[2];
+	uint32_t INT_M_STATUS;
+	uint32_t INT_M_MASK;
+	uint32_t INT_S_STATUS;
+	uint32_t INT_S_MASK;
+	uint32_t RESERVED_B_13[28];
+	uint32_t MAIN_TEST_DEN;
+	uint32_t RESERVED_B_14[3];
+	uint32_t PREPROCCESS_FMTM;
+	uint32_t PREPROCCESS_C24M;
+	uint32_t FRAMEPACK_M;
+	uint32_t RESERVED_B_15[1];
+	struct hwd_viif_csc_reg l2isp_input_csc;
+	uint32_t COM0_CK_ENABLE;
+	uint32_t RESERVED_A_13;
+	uint32_t RESERVED_A_14;
+	uint32_t RESERVED_B_17[1];
+	uint32_t COM0EN;
+	uint32_t RESERVED_A_16;
+	uint32_t RESERVED_A_17;
+	uint32_t RESERVED_B_18[33];
+	uint32_t COM0_CAP_OFFSET;
+	uint32_t COM0_CAP_SIZE;
+	uint32_t RESERVED_B_19[18];
+	uint32_t GAMMA_M;
+	uint32_t RESERVED_B_20[3];
+	uint32_t COM0_C_SELECT;
+	uint32_t RESERVED_B_21[3];
+	struct hwd_viif_csc_reg com0_csc;
+	uint32_t COM0_OPORTALP;
+	uint32_t COM0_OPORTFMT;
+	uint32_t RESERVED_B_23[2];
+	uint32_t RESERVED_A_37;
+	uint32_t RESERVED_A_38;
+	uint32_t RESERVED_A_39;
+	uint32_t RESERVED_B_24[1];
+	uint32_t RESERVED_A_40;
+	uint32_t RESERVED_A_41;
+	uint32_t RESERVED_A_42;
+	uint32_t RESERVED_B_25[1];
+	uint32_t RESERVED_A_43;
+	uint32_t RESERVED_A_44;
+	uint32_t RESERVED_A_45;
+	uint32_t RESERVED_B_26[1];
+	uint32_t RESERVED_A_46;
+	uint32_t RESERVED_B_27[3];
+	uint32_t RESERVED_A_47;
+	uint32_t RESERVED_A_48;
+	uint32_t RESERVED_B_28[18];
+	uint32_t RESERVED_A_49;
+	uint32_t RESERVED_B_29[3];
+	uint32_t RESERVED_A_50;
+	uint32_t RESERVED_B_30[3];
+	uint32_t RESERVED_A_51;
+	uint32_t RESERVED_B_31[3];
+	uint32_t RESERVED_A_52;
+	uint32_t RESERVED_A_53;
+	uint32_t RESERVED_A_54;
+	uint32_t RESERVED_A_55;
+	uint32_t RESERVED_A_56;
+	uint32_t RESERVED_A_57;
+	uint32_t RESERVED_A_58;
+	uint32_t RESERVED_A_59;
+	uint32_t RESERVED_A_60;
+	uint32_t RESERVED_A_61;
+	uint32_t RESERVED_A_62;
+	uint32_t RESERVED_A_63;
+	uint32_t RESERVED_A_64;
+	uint32_t RESERVED_A_65;
+	uint32_t RESERVED_B_32[2];
+	uint32_t RESERVED_A_66;
+	uint32_t RESERVED_A_67;
+	uint32_t RESERVED_A_68;
+	uint32_t RESERVED_B_33[1];
+	uint32_t RESERVED_A_69;
+	uint32_t RESERVED_A_70;
+	uint32_t RESERVED_A_71;
+	uint32_t RESERVED_B_34[1];
+	uint32_t RESERVED_A_72;
+	uint32_t RESERVED_A_73;
+	uint32_t RESERVED_A_74;
+	uint32_t RESERVED_B_35[1];
+	uint32_t RESERVED_A_75;
+	uint32_t RESERVED_B_36[3];
+	uint32_t RESERVED_A_76;
+	uint32_t RESERVED_A_77;
+	uint32_t RESERVED_B_37[18];
+	uint32_t RESERVED_A_78;
+	uint32_t RESERVED_B_38[3];
+	uint32_t RESERVED_A_79;
+	uint32_t RESERVED_B_39[3];
+	uint32_t RESERVED_A_80;
+	uint32_t RESERVED_B_40[3];
+	uint32_t RESERVED_A_81;
+	uint32_t RESERVED_A_82;
+	uint32_t RESERVED_A_83;
+	uint32_t RESERVED_A_84;
+	uint32_t RESERVED_A_85;
+	uint32_t RESERVED_A_86;
+	uint32_t RESERVED_A_87;
+	uint32_t RESERVED_A_88;
+	uint32_t RESERVED_A_89;
+	uint32_t RESERVED_A_90;
+	uint32_t RESERVED_A_91;
+	uint32_t RESERVED_A_92;
+	uint32_t RESERVED_A_93;
+	uint32_t RESERVED_A_94;
+	uint32_t RESERVED_B_41[2];
+	uint32_t RESERVED_A_95;
+	uint32_t RESERVED_A_96;
+	uint32_t RESERVED_A_97;
+	uint32_t RESERVED_B_42[1];
+	uint32_t RESERVED_A_98;
+	uint32_t RESERVED_A_99;
+	uint32_t RESERVED_A_100;
+	uint32_t RESERVED_B_43[1];
+	uint32_t RESERVED_A_101;
+	uint32_t RESERVED_A_102;
+	uint32_t RESERVED_A_103;
+	uint32_t RESERVED_B_44[1];
+	uint32_t RESERVED_A_104;
+	uint32_t RESERVED_B_45[3];
+	uint32_t FN_M0;
+	uint32_t FN_M1;
+	uint32_t FN_M2;
+	uint32_t RESERVED_B_46[5];
+	uint32_t FN_SA0;
+	uint32_t FN_SA1;
+	uint32_t RESERVED_B_47[2];
+	uint32_t RESERVED_A_105;
+	uint32_t RESERVED_A_106;
+	uint32_t RESERVED_B_48[18];
+	uint32_t LBIST_STAT;
+	uint32_t MEM_ECC_DCLS_ALARM;
+	uint32_t RESERVED_B_49[30];
+	uint32_t DPHY_FREQRANGE;
+	uint32_t RESERVED_B_50[3];
+	uint32_t DPHY_LANE;
+	uint32_t RESERVED_B_51[59];
+	uint32_t INT_SOURCE;
+	uint32_t DPGM_VSYNC_SOURCE;
+	uint32_t RESERVED_B_52[23];
+	uint32_t RESERVED_A_107;
+	uint32_t RESERVED_A_108;
+	uint32_t RESERVED_B_53[6];
+	uint32_t RESERVED_A_109;
+	uint32_t RESERVED_A_110;
+	uint32_t RESERVED_A_111;
+	uint32_t RESERVED_B_54[1];
+	uint32_t RESERVED_A_112;
+	uint32_t RESERVED_B_55[35];
+	uint32_t RESERVED_A_113;
+	uint32_t RESERVED_B_56[54];
+	uint32_t RESERVED_A_114;
+	uint32_t RESERVED_B_57[3];
+	uint32_t RESERVED_A_115;
+	uint32_t RESERVED_A_116;
+	uint32_t RESERVED_A_117;
+	uint32_t RESERVED_B_58[1];
+	uint32_t RESERVED_A_118;
+	uint32_t RESERVED_B_59[3];
+	uint32_t RESERVED_A_119;
+	uint32_t RESERVED_A_120;
+	uint32_t RESERVED_A_121;
+	uint32_t RESERVED_A_122;
+	uint32_t RESERVED_A_123;
+	uint32_t RESERVED_A_124;
+	uint32_t RESERVED_A_125;
+	uint32_t RESERVED_A_126;
+	uint32_t RESERVED_A_127;
+	uint32_t RESERVED_A_128;
+	uint32_t RESERVED_A_129;
+	uint32_t RESERVED_A_130;
+	uint32_t RESERVED_B_60[4];
+	uint32_t RESERVED_A_131;
+	uint32_t RESERVED_A_132;
+	uint32_t RESERVED_A_133;
+	uint32_t RESERVED_B_61[33];
+	uint32_t RESERVED_A_134;
+	uint32_t RESERVED_A_135;
+	uint32_t RESERVED_B_62[18];
+	uint32_t RESERVED_A_136;
+	uint32_t RESERVED_B_63[3];
+	uint32_t RESERVED_A_137;
+	uint32_t RESERVED_B_64[3];
+	uint32_t RESERVED_A_138;
+	uint32_t RESERVED_B_65[3];
+	uint32_t RESERVED_A_139;
+	uint32_t RESERVED_A_140;
+	uint32_t RESERVED_A_141;
+	uint32_t RESERVED_A_142;
+	uint32_t RESERVED_A_143;
+	uint32_t RESERVED_A_144;
+	uint32_t RESERVED_A_145;
+	uint32_t RESERVED_A_146;
+	uint32_t RESERVED_A_147;
+	uint32_t RESERVED_A_148;
+	uint32_t RESERVED_A_149;
+	uint32_t RESERVED_A_150;
+	uint32_t RESERVED_A_151;
+	uint32_t RESERVED_A_152;
+	uint32_t RESERVED_B_66[2];
+	uint32_t RESERVED_A_153;
+	uint32_t RESERVED_A_154;
+	uint32_t RESERVED_A_155;
+	uint32_t RESERVED_B_67[1];
+	uint32_t RESERVED_A_156;
+	uint32_t RESERVED_A_157;
+	uint32_t RESERVED_A_158;
+	uint32_t RESERVED_B_68[1];
+	uint32_t RESERVED_A_159;
+	uint32_t RESERVED_A_160;
+	uint32_t RESERVED_A_161;
+	uint32_t RESERVED_B_69[1];
+	uint32_t RESERVED_A_162;
+	uint32_t RESERVED_B_70[3];
+	uint32_t RESERVED_A_163;
+	uint32_t RESERVED_A_164;
+	uint32_t RESERVED_B_71[18];
+	uint32_t RESERVED_A_165;
+	uint32_t RESERVED_B_72[3];
+	uint32_t RESERVED_A_166;
+	uint32_t RESERVED_B_73[3];
+	uint32_t RESERVED_A_167;
+	uint32_t RESERVED_B_74[3];
+	uint32_t RESERVED_A_168;
+	uint32_t RESERVED_A_169;
+	uint32_t RESERVED_A_170;
+	uint32_t RESERVED_A_171;
+	uint32_t RESERVED_A_172;
+	uint32_t RESERVED_A_173;
+	uint32_t RESERVED_A_174;
+	uint32_t RESERVED_A_175;
+	uint32_t RESERVED_A_176;
+	uint32_t RESERVED_A_177;
+	uint32_t RESERVED_A_178;
+	uint32_t RESERVED_A_179;
+	uint32_t RESERVED_A_180;
+	uint32_t RESERVED_A_181;
+	uint32_t RESERVED_B_75[2];
+	uint32_t RESERVED_A_182;
+	uint32_t RESERVED_A_183;
+	uint32_t RESERVED_A_184;
+	uint32_t RESERVED_B_76[1];
+	uint32_t RESERVED_A_185;
+	uint32_t RESERVED_A_186;
+	uint32_t RESERVED_A_187;
+	uint32_t RESERVED_B_77[1];
+	uint32_t RESERVED_A_188;
+	uint32_t RESERVED_A_189;
+	uint32_t RESERVED_A_190;
+	uint32_t RESERVED_B_78[1];
+	uint32_t RESERVED_A_191;
+	uint32_t RESERVED_B_79[3];
+	uint32_t RESERVED_A_192;
+	uint32_t RESERVED_A_193;
+	uint32_t RESERVED_B_80[18];
+	uint32_t RESERVED_A_194;
+	uint32_t RESERVED_B_81[3];
+	uint32_t RESERVED_A_195;
+	uint32_t RESERVED_B_82[3];
+	uint32_t RESERVED_A_196;
+	uint32_t RESERVED_B_83[3];
+	uint32_t RESERVED_A_197;
+	uint32_t RESERVED_A_198;
+	uint32_t RESERVED_A_199;
+	uint32_t RESERVED_A_200;
+	uint32_t RESERVED_A_201;
+	uint32_t RESERVED_A_202;
+	uint32_t RESERVED_A_203;
+	uint32_t RESERVED_A_204;
+	uint32_t RESERVED_A_205;
+	uint32_t RESERVED_A_206;
+	uint32_t RESERVED_A_207;
+	uint32_t RESERVED_A_208;
+	uint32_t RESERVED_A_209;
+	uint32_t RESERVED_A_210;
+	uint32_t RESERVED_B_84[2];
+	uint32_t RESERVED_A_211;
+	uint32_t RESERVED_A_212;
+	uint32_t RESERVED_A_213;
+	uint32_t RESERVED_B_85[1];
+	uint32_t RESERVED_A_214;
+	uint32_t RESERVED_A_215;
+	uint32_t RESERVED_A_216;
+	uint32_t RESERVED_B_86[1];
+	uint32_t RESERVED_A_217;
+	uint32_t RESERVED_A_218;
+	uint32_t RESERVED_A_219;
+	uint32_t RESERVED_B_87[1];
+	uint32_t RESERVED_A_220;
+	uint32_t RESERVED_B_88[130];
+	uint32_t RESERVED_A_221;
+};
+
+/**
+ * struct hwd_viif_vdm_table_group_reg - Registers for VIIF vdm control
+ */
+struct hwd_viif_vdm_table_group_reg {
+	uint32_t VDM_T_CFG;
+	uint32_t VDM_T_SRAM_BASE;
+	uint32_t VDM_T_SRAM_SIZE;
+	uint32_t RESERVED_A_4;
+};
+
+struct hwd_viif_vdm_table_port_reg {
+	uint32_t VDM_T_STADR;
+	uint32_t VDM_T_SIZE;
+};
+
+struct hwd_viif_vdm_read_port_reg {
+	uint32_t VDM_R_STADR;
+	uint32_t VDM_R_ENDADR;
+	uint32_t VDM_R_HEIGHT;
+	uint32_t VDM_R_PITCH;
+	uint32_t VDM_R_CFG0;
+	uint32_t RESERVED_A_11;
+	uint32_t VDM_R_SRAM_BASE;
+	uint32_t VDM_R_SRAM_SIZE;
+	uint32_t RESERVED_A_12;
+	uint32_t RESERVED_B_5[7];
+};
+
+struct hwd_viif_vdm_write_port_reg {
+	uint32_t VDM_W_STADR;
+	uint32_t VDM_W_ENDADR;
+	uint32_t VDM_W_HEIGHT;
+	uint32_t VDM_W_PITCH;
+	uint32_t VDM_W_CFG0;
+	uint32_t RESERVED_A_17;
+	uint32_t VDM_W_SRAM_BASE;
+	uint32_t VDM_W_SRAM_SIZE;
+	uint32_t RESERVED_A_18;
+	uint32_t RESERVED_B_8[7];
+};
+
+struct hwd_viif_vdm_write_port_buf_reg {
+	uint32_t VDM_W_STADR_BUF;
+	uint32_t RESERVED_A_120;
+	uint32_t RESERVED_A_121;
+	uint32_t RESERVED_A_122;
+	uint32_t RESERVED_A_123;
+	uint32_t RESERVED_A_124;
+	uint32_t RESERVED_B_20[2];
+};
+
+struct hwd_viif_vdm_reg {
+	uint32_t RESERVED_A_1;
+	uint32_t RESERVED_A_2;
+	uint32_t RESERVED_B_1[4];
+	uint32_t RESERVED_A_3;
+	uint32_t VDM_CFG;
+	uint32_t VDM_INT_MASK;
+	uint32_t RESERVED_B_2[3];
+	uint32_t VDM_R_ENABLE;
+	uint32_t VDM_W_ENABLE;
+	uint32_t VDM_T_ENABLE;
+	uint32_t VDM_ABORTSET;
+	struct hwd_viif_vdm_table_group_reg t_group[4];
+	uint32_t RESERVED_A_8;
+	uint32_t RESERVED_A_9;
+	uint32_t RESERVED_A_10;
+	uint32_t RESERVED_A_11;
+	uint32_t RESERVED_B_3[28];
+	struct hwd_viif_vdm_table_port_reg t_port[24];
+	uint32_t RESERVED_A_14;
+	uint32_t RESERVED_A_15;
+	uint32_t RESERVED_A_16;
+	uint32_t RESERVED_A_17;
+	uint32_t RESERVED_A_18;
+	uint32_t RESERVED_A_19;
+	uint32_t RESERVED_A_20;
+	uint32_t RESERVED_A_21;
+	uint32_t RESERVED_A_22;
+	uint32_t RESERVED_A_23;
+	uint32_t RESERVED_A_24;
+	uint32_t RESERVED_A_25;
+	uint32_t RESERVED_B_4[4];
+	struct hwd_viif_vdm_read_port_reg r_port[3];
+	uint32_t RESERVED_B_7[16];
+	struct hwd_viif_vdm_write_port_reg w_port[6];
+	uint32_t RESERVED_A_29;
+	uint32_t RESERVED_A_30;
+	uint32_t RESERVED_A_31;
+	uint32_t RESERVED_A_32;
+	uint32_t RESERVED_A_33;
+	uint32_t RESERVED_A_34;
+	uint32_t RESERVED_A_35;
+	uint32_t RESERVED_A_36;
+	uint32_t RESERVED_A_37;
+	uint32_t RESERVED_B_14[215];
+	uint32_t RESERVED_A_38;
+	uint32_t RESERVED_A_39;
+	uint32_t RESERVED_A_40;
+	uint32_t RESERVED_B_15[61];
+	uint32_t RESERVED_A_41;
+	uint32_t RESERVED_A_42;
+	uint32_t RESERVED_A_43;
+	uint32_t RESERVED_A_44;
+	uint32_t RESERVED_A_45;
+	uint32_t RESERVED_A_46;
+	uint32_t RESERVED_A_47;
+	uint32_t RESERVED_A_48;
+	uint32_t RESERVED_A_49;
+	uint32_t RESERVED_A_50;
+	uint32_t RESERVED_A_51;
+	uint32_t RESERVED_A_52;
+	uint32_t RESERVED_A_53;
+	uint32_t RESERVED_A_54;
+	uint32_t RESERVED_A_55;
+	uint32_t RESERVED_A_56;
+	uint32_t RESERVED_A_57;
+	uint32_t RESERVED_A_58;
+	uint32_t RESERVED_A_59;
+	uint32_t RESERVED_A_60;
+	uint32_t RESERVED_A_61;
+	uint32_t RESERVED_A_62;
+	uint32_t RESERVED_A_63;
+	uint32_t RESERVED_A_64;
+	uint32_t RESERVED_A_65;
+	uint32_t RESERVED_A_66;
+	uint32_t RESERVED_A_67;
+	uint32_t RESERVED_A_68;
+	uint32_t RESERVED_A_69;
+	uint32_t RESERVED_A_70;
+	uint32_t RESERVED_A_71;
+	uint32_t RESERVED_A_72;
+	uint32_t RESERVED_A_73;
+	uint32_t RESERVED_A_74;
+	uint32_t RESERVED_A_75;
+	uint32_t RESERVED_A_76;
+	uint32_t RESERVED_A_77;
+	uint32_t RESERVED_A_78;
+	uint32_t RESERVED_A_79;
+	uint32_t RESERVED_A_80;
+	uint32_t RESERVED_A_81;
+	uint32_t RESERVED_A_82;
+	uint32_t RESERVED_A_83;
+	uint32_t RESERVED_A_84;
+	uint32_t RESERVED_A_85;
+	uint32_t RESERVED_A_86;
+	uint32_t RESERVED_A_87;
+	uint32_t RESERVED_A_88;
+	uint32_t RESERVED_A_89;
+	uint32_t RESERVED_A_90;
+	uint32_t RESERVED_A_91;
+	uint32_t RESERVED_A_92;
+	uint32_t RESERVED_A_93;
+	uint32_t RESERVED_A_94;
+	uint32_t RESERVED_A_95;
+	uint32_t RESERVED_A_96;
+	uint32_t RESERVED_A_97;
+	uint32_t RESERVED_A_98;
+	uint32_t RESERVED_A_99;
+	uint32_t RESERVED_A_100;
+	uint32_t RESERVED_B_16[4];
+	uint32_t RESERVED_A_101;
+	uint32_t RESERVED_A_102;
+	uint32_t RESERVED_A_103;
+	uint32_t RESERVED_A_104;
+	uint32_t RESERVED_A_105;
+	uint32_t RESERVED_A_106;
+	uint32_t RESERVED_B_17[2];
+	uint32_t RESERVED_A_107;
+	uint32_t RESERVED_A_108;
+	uint32_t RESERVED_A_109;
+	uint32_t RESERVED_A_110;
+	uint32_t RESERVED_A_111;
+	uint32_t RESERVED_A_112;
+	uint32_t RESERVED_B_18[2];
+	uint32_t RESERVED_A_113;
+	uint32_t RESERVED_A_114;
+	uint32_t RESERVED_A_115;
+	uint32_t RESERVED_A_116;
+	uint32_t RESERVED_A_117;
+	uint32_t RESERVED_A_118;
+	uint32_t RESERVED_B_19[42];
+	struct hwd_viif_vdm_write_port_buf_reg w_port_buf[6];
+	uint32_t RESERVED_A_155;
+	uint32_t RESERVED_A_156;
+	uint32_t RESERVED_A_157;
+	uint32_t RESERVED_A_158;
+	uint32_t RESERVED_A_159;
+	uint32_t RESERVED_A_160;
+	uint32_t RESERVED_B_26[138];
+	uint32_t RESERVED_A_161;
+	uint32_t VDM_INT;
+	uint32_t RESERVED_A_162;
+	uint32_t RESERVED_A_163;
+	uint32_t VDM_R_STOP;
+	uint32_t VDM_W_STOP;
+	uint32_t VDM_R_RUN;
+	uint32_t VDM_W_RUN;
+	uint32_t VDM_T_RUN;
+	uint32_t RESERVED_B_27[7];
+	uint32_t RESERVED_A_164;
+	uint32_t RESERVED_A_165;
+	uint32_t RESERVED_A_166;
+	uint32_t RESERVED_A_167;
+	uint32_t RESERVED_B_28[12];
+	uint32_t RESERVED_A_168;
+	uint32_t RESERVED_A_169;
+	uint32_t RESERVED_A_170;
+	uint32_t RESERVED_A_171;
+	uint32_t RESERVED_A_172;
+	uint32_t RESERVED_B_29[27];
+	uint32_t RESERVED_A_173;
+	uint32_t RESERVED_A_174;
+	uint32_t RESERVED_A_175;
+	uint32_t RESERVED_A_176;
+	uint32_t RESERVED_A_177;
+	uint32_t RESERVED_A_178;
+	uint32_t RESERVED_B_30[10];
+	uint32_t RESERVED_A_179;
+	uint32_t RESERVED_A_180;
+	uint32_t RESERVED_A_181;
+	uint32_t RESERVED_A_182;
+	uint32_t RESERVED_A_183;
+	uint32_t RESERVED_A_184;
+	uint32_t RESERVED_A_185;
+	uint32_t RESERVED_A_186;
+	uint32_t RESERVED_A_187;
+	uint32_t RESERVED_A_188;
+	uint32_t RESERVED_A_189;
+	uint32_t RESERVED_A_190;
+	uint32_t RESERVED_A_191;
+	uint32_t RESERVED_A_192;
+	uint32_t RESERVED_B_31[33];
+	uint32_t RESERVED_A_193;
+};
+
+/**
+ * struct hwd_viif_l1isp_reg - Registers for VIIF L1ISP control
+ */
+struct hwd_viif_l1isp_reg {
+	uint32_t L1_SYSM_WIDTH;
+	uint32_t L1_SYSM_HEIGHT;
+	uint32_t L1_SYSM_START_COLOR;
+	uint32_t L1_SYSM_INPUT_MODE;
+	uint32_t RESERVED_A_1;
+	uint32_t L1_SYSM_YCOEF_R;
+	uint32_t L1_SYSM_YCOEF_G;
+	uint32_t L1_SYSM_YCOEF_B;
+	uint32_t L1_SYSM_INT_STAT;
+	uint32_t L1_SYSM_INT_MASKED_STAT;
+	uint32_t L1_SYSM_INT_MASK;
+	uint32_t RESERVED_A_2;
+	uint32_t RESERVED_A_3;
+	uint32_t RESERVED_A_4;
+	uint32_t RESERVED_B_1[2];
+	uint32_t L1_SYSM_AG_H;
+	uint32_t L1_SYSM_AG_M;
+	uint32_t L1_SYSM_AG_L;
+	uint32_t L1_SYSM_AG_PARAM_A;
+	uint32_t L1_SYSM_AG_PARAM_B;
+	uint32_t L1_SYSM_AG_PARAM_C;
+	uint32_t L1_SYSM_AG_PARAM_D;
+	uint32_t L1_SYSM_AG_SEL_HOBC;
+	uint32_t L1_SYSM_AG_SEL_ABPC;
+	uint32_t L1_SYSM_AG_SEL_RCNR;
+	uint32_t L1_SYSM_AG_SEL_LSSC;
+	uint32_t L1_SYSM_AG_SEL_MPRO;
+	uint32_t L1_SYSM_AG_SEL_VPRO;
+	uint32_t L1_SYSM_AG_CONT_HOBC01_EN;
+	uint32_t L1_SYSM_AG_CONT_HOBC2_EN;
+	uint32_t L1_SYSM_AG_CONT_ABPC01_EN;
+	uint32_t L1_SYSM_AG_CONT_ABPC2_EN;
+	uint32_t L1_SYSM_AG_CONT_RCNR01_EN;
+	uint32_t L1_SYSM_AG_CONT_RCNR2_EN;
+	uint32_t L1_SYSM_AG_CONT_LSSC_EN;
+	uint32_t L1_SYSM_AG_CONT_MPRO_EN;
+	uint32_t L1_SYSM_AG_CONT_VPRO_EN;
+	uint32_t L1_SYSM_CTXT;
+	uint32_t L1_SYSM_MAN_CTXT;
+	uint32_t RESERVED_A_5;
+	uint32_t RESERVED_B_2[7];
+	uint32_t RESERVED_A_6;
+	uint32_t L1_HDRE_SrcPoint00;
+	uint32_t L1_HDRE_SrcPoint01;
+	uint32_t L1_HDRE_SrcPoint02;
+	uint32_t L1_HDRE_SrcPoint03;
+	uint32_t L1_HDRE_SrcPoint04;
+	uint32_t L1_HDRE_SrcPoint05;
+	uint32_t L1_HDRE_SrcPoint06;
+	uint32_t L1_HDRE_SrcPoint07;
+	uint32_t L1_HDRE_SrcPoint08;
+	uint32_t L1_HDRE_SrcPoint09;
+	uint32_t L1_HDRE_SrcPoint10;
+	uint32_t L1_HDRE_SrcPoint11;
+	uint32_t L1_HDRE_SrcPoint12;
+	uint32_t L1_HDRE_SrcPoint13;
+	uint32_t L1_HDRE_SrcPoint14;
+	uint32_t L1_HDRE_SrcPoint15;
+	uint32_t L1_HDRE_SrcBase00;
+	uint32_t L1_HDRE_SrcBase01;
+	uint32_t L1_HDRE_SrcBase02;
+	uint32_t L1_HDRE_SrcBase03;
+	uint32_t L1_HDRE_SrcBase04;
+	uint32_t L1_HDRE_SrcBase05;
+	uint32_t L1_HDRE_SrcBase06;
+	uint32_t L1_HDRE_SrcBase07;
+	uint32_t L1_HDRE_SrcBase08;
+	uint32_t L1_HDRE_SrcBase09;
+	uint32_t L1_HDRE_SrcBase10;
+	uint32_t L1_HDRE_SrcBase11;
+	uint32_t L1_HDRE_SrcBase12;
+	uint32_t L1_HDRE_SrcBase13;
+	uint32_t L1_HDRE_SrcBase14;
+	uint32_t L1_HDRE_SrcBase15;
+	uint32_t L1_HDRE_SrcBase16;
+	uint32_t L1_HDRE_Ratio00;
+	uint32_t L1_HDRE_Ratio01;
+	uint32_t L1_HDRE_Ratio02;
+	uint32_t L1_HDRE_Ratio03;
+	uint32_t L1_HDRE_Ratio04;
+	uint32_t L1_HDRE_Ratio05;
+	uint32_t L1_HDRE_Ratio06;
+	uint32_t L1_HDRE_Ratio07;
+	uint32_t L1_HDRE_Ratio08;
+	uint32_t L1_HDRE_Ratio09;
+	uint32_t L1_HDRE_Ratio10;
+	uint32_t L1_HDRE_Ratio11;
+	uint32_t L1_HDRE_Ratio12;
+	uint32_t L1_HDRE_Ratio13;
+	uint32_t L1_HDRE_Ratio14;
+	uint32_t L1_HDRE_Ratio15;
+	uint32_t L1_HDRE_Ratio16;
+	uint32_t L1_HDRE_DstBase00;
+	uint32_t L1_HDRE_DstBase01;
+	uint32_t L1_HDRE_DstBase02;
+	uint32_t L1_HDRE_DstBase03;
+	uint32_t L1_HDRE_DstBase04;
+	uint32_t L1_HDRE_DstBase05;
+	uint32_t L1_HDRE_DstBase06;
+	uint32_t L1_HDRE_DstBase07;
+	uint32_t L1_HDRE_DstBase08;
+	uint32_t L1_HDRE_DstBase09;
+	uint32_t L1_HDRE_DstBase10;
+	uint32_t L1_HDRE_DstBase11;
+	uint32_t L1_HDRE_DstBase12;
+	uint32_t L1_HDRE_DstBase13;
+	uint32_t L1_HDRE_DstBase14;
+	uint32_t L1_HDRE_DstBase15;
+	uint32_t L1_HDRE_DstBase16;
+	uint32_t L1_HDRE_DstMaxval;
+	uint32_t RESERVED_B_3[11];
+	uint32_t L1_AEXP_ON;
+	uint32_t L1_AEXP_RESULT_AVE;
+	uint32_t RESERVED_A_7;
+	uint32_t L1_AEXP_FORCE_INTERRUPT_Y;
+	uint32_t L1_AEXP_START_X;
+	uint32_t L1_AEXP_START_Y;
+	uint32_t L1_AEXP_BLOCK_WIDTH;
+	uint32_t L1_AEXP_BLOCK_HEIGHT;
+	uint32_t L1_AEXP_WEIGHT_0;
+	uint32_t L1_AEXP_WEIGHT_1;
+	uint32_t L1_AEXP_WEIGHT_2;
+	uint32_t L1_AEXP_WEIGHT_3;
+	uint32_t L1_AEXP_WEIGHT_4;
+	uint32_t L1_AEXP_WEIGHT_5;
+	uint32_t L1_AEXP_WEIGHT_6;
+	uint32_t L1_AEXP_WEIGHT_7;
+	uint32_t L1_AEXP_SATUR_RATIO;
+	uint32_t L1_AEXP_BLACK_RATIO;
+	uint32_t L1_AEXP_SATUR_LEVEL;
+	uint32_t RESERVED_A_8;
+	/* [y][x] */
+	uint32_t L1_AEXP_AVE[8][8];
+	uint32_t L1_AEXP_SATUR_BLACK_PIXNUM;
+	uint32_t L1_AEXP_AVE4LINESY0;
+	uint32_t L1_AEXP_AVE4LINESY1;
+	uint32_t L1_AEXP_AVE4LINESY2;
+	uint32_t L1_AEXP_AVE4LINESY3;
+	uint32_t L1_AEXP_AVE4LINES0;
+	uint32_t L1_AEXP_AVE4LINES1;
+	uint32_t L1_AEXP_AVE4LINES2;
+	uint32_t L1_AEXP_AVE4LINES3;
+	uint32_t RESERVED_B_4[3];
+	uint32_t L1_IBUF_DEPTH;
+	uint32_t L1_IBUF_INPUT_ORDER;
+	uint32_t RESERVED_B_5[2];
+	uint32_t L1_SLIC_SrcBlackLevelGr;
+	uint32_t L1_SLIC_SrcBlackLevelR;
+	uint32_t L1_SLIC_SrcBlackLevelB;
+	uint32_t L1_SLIC_SrcBlackLevelGb;
+	uint32_t RESERVED_A_9;
+	uint32_t RESERVED_A_10;
+	uint32_t RESERVED_A_11;
+	uint32_t RESERVED_A_12;
+	uint32_t RESERVED_A_13;
+	uint32_t RESERVED_B_6[19];
+	uint32_t RESERVED_A_14;
+	uint32_t RESERVED_A_15;
+	uint32_t L1_ABPC012_AG_CONT;
+	uint32_t L1_ABPC012_STA_EN;
+	uint32_t L1_ABPC012_DYN_EN;
+	uint32_t L1_ABPC012_DYN_MODE;
+	uint32_t RESERVED_A_16;
+	uint32_t RESERVED_A_17;
+	uint32_t RESERVED_A_18;
+	uint32_t L1_ABPC0_RATIO_LIMIT;
+	uint32_t RESERVED_A_19;
+	uint32_t L1_ABPC0_DARK_LIMIT;
+	uint32_t L1_ABPC0_SN_COEF_W_AG_MIN;
+	uint32_t L1_ABPC0_SN_COEF_W_AG_MID;
+	uint32_t L1_ABPC0_SN_COEF_W_AG_MAX;
+	uint32_t L1_ABPC0_SN_COEF_W_TH_MIN;
+	uint32_t L1_ABPC0_SN_COEF_W_TH_MAX;
+	uint32_t L1_ABPC0_SN_COEF_B_AG_MIN;
+	uint32_t L1_ABPC0_SN_COEF_B_AG_MID;
+	uint32_t L1_ABPC0_SN_COEF_B_AG_MAX;
+	uint32_t L1_ABPC0_SN_COEF_B_TH_MIN;
+	uint32_t L1_ABPC0_SN_COEF_B_TH_MAX;
+	uint32_t RESERVED_A_20;
+	uint32_t L1_ABPC0_DETECT;
+	uint32_t L1_ABPC1_RATIO_LIMIT;
+	uint32_t RESERVED_A_21;
+	uint32_t L1_ABPC1_DARK_LIMIT;
+	uint32_t L1_ABPC1_SN_COEF_W_AG_MIN;
+	uint32_t L1_ABPC1_SN_COEF_W_AG_MID;
+	uint32_t L1_ABPC1_SN_COEF_W_AG_MAX;
+	uint32_t L1_ABPC1_SN_COEF_W_TH_MIN;
+	uint32_t L1_ABPC1_SN_COEF_W_TH_MAX;
+	uint32_t L1_ABPC1_SN_COEF_B_AG_MIN;
+	uint32_t L1_ABPC1_SN_COEF_B_AG_MID;
+	uint32_t L1_ABPC1_SN_COEF_B_AG_MAX;
+	uint32_t L1_ABPC1_SN_COEF_B_TH_MIN;
+	uint32_t L1_ABPC1_SN_COEF_B_TH_MAX;
+	uint32_t RESERVED_A_22;
+	uint32_t L1_ABPC1_DETECT;
+	uint32_t L1_ABPC2_RATIO_LIMIT;
+	uint32_t RESERVED_A_23;
+	uint32_t L1_ABPC2_DARK_LIMIT;
+	uint32_t L1_ABPC2_SN_COEF_W_AG_MIN;
+	uint32_t L1_ABPC2_SN_COEF_W_AG_MID;
+	uint32_t L1_ABPC2_SN_COEF_W_AG_MAX;
+	uint32_t L1_ABPC2_SN_COEF_W_TH_MIN;
+	uint32_t L1_ABPC2_SN_COEF_W_TH_MAX;
+	uint32_t L1_ABPC2_SN_COEF_B_AG_MIN;
+	uint32_t L1_ABPC2_SN_COEF_B_AG_MID;
+	uint32_t L1_ABPC2_SN_COEF_B_AG_MAX;
+	uint32_t L1_ABPC2_SN_COEF_B_TH_MIN;
+	uint32_t L1_ABPC2_SN_COEF_B_TH_MAX;
+	uint32_t RESERVED_A_24;
+	uint32_t L1_ABPC2_DETECT;
+	uint32_t RESERVED_B_7[42];
+	uint32_t RESERVED_A_25;
+	uint32_t L1_PWHB_HGr;
+	uint32_t L1_PWHB_HR;
+	uint32_t L1_PWHB_HB;
+	uint32_t L1_PWHB_HGb;
+	uint32_t L1_PWHB_MGr;
+	uint32_t L1_PWHB_MR;
+	uint32_t L1_PWHB_MB;
+	uint32_t L1_PWHB_MGb;
+	uint32_t L1_PWHB_LGr;
+	uint32_t L1_PWHB_LR;
+	uint32_t L1_PWHB_LB;
+	uint32_t L1_PWHB_LGb;
+	uint32_t L1_PWHB_DstMaxval;
+	uint32_t RESERVED_B_8[18];
+	uint32_t L1_RCNR0_AG_CONT;
+	uint32_t RESERVED_A_26;
+	uint32_t L1_RCNR0_SW;
+	uint32_t L1_RCNR0_CNF_DARK_AG0;
+	uint32_t L1_RCNR0_CNF_DARK_AG1;
+	uint32_t L1_RCNR0_CNF_DARK_AG2;
+	uint32_t L1_RCNR0_CNF_RATIO_AG0;
+	uint32_t L1_RCNR0_CNF_RATIO_AG1;
+	uint32_t L1_RCNR0_CNF_RATIO_AG2;
+	uint32_t L1_RCNR0_CNF_CLIP_GAIN_R;
+	uint32_t L1_RCNR0_CNF_CLIP_GAIN_G;
+	uint32_t L1_RCNR0_CNF_CLIP_GAIN_B;
+	uint32_t L1_RCNR0_A1L_DARK_AG0;
+	uint32_t L1_RCNR0_A1L_DARK_AG1;
+	uint32_t L1_RCNR0_A1L_DARK_AG2;
+	uint32_t L1_RCNR0_A1L_RATIO_AG0;
+	uint32_t L1_RCNR0_A1L_RATIO_AG1;
+	uint32_t L1_RCNR0_A1L_RATIO_AG2;
+	uint32_t L1_RCNR0_INF_ZERO_CLIP;
+	uint32_t RESERVED_A_27;
+	uint32_t L1_RCNR0_MERGE_D2BLEND_AG0;
+	uint32_t L1_RCNR0_MERGE_D2BLEND_AG1;
+	uint32_t L1_RCNR0_MERGE_D2BLEND_AG2;
+	uint32_t L1_RCNR0_MERGE_BLACK;
+	uint32_t L1_RCNR0_MERGE_MINDIV;
+	uint32_t L1_RCNR0_HRY_TYPE;
+	uint32_t L1_RCNR0_ANF_BLEND_AG0;
+	uint32_t L1_RCNR0_ANF_BLEND_AG1;
+	uint32_t L1_RCNR0_ANF_BLEND_AG2;
+	uint32_t RESERVED_A_28;
+	uint32_t L1_RCNR0_LPF_THRESHOLD;
+	uint32_t L1_RCNR0_MERGE_HLBLEND_AG0;
+	uint32_t L1_RCNR0_MERGE_HLBLEND_AG1;
+	uint32_t L1_RCNR0_MERGE_HLBLEND_AG2;
+	uint32_t L1_RCNR0_GNR_SW;
+	uint32_t L1_RCNR0_GNR_RATIO;
+	uint32_t L1_RCNR0_GNR_WIDE_EN;
+	uint32_t L1_RCNR1_AG_CONT;
+	uint32_t RESERVED_A_29;
+	uint32_t L1_RCNR1_SW;
+	uint32_t L1_RCNR1_CNF_DARK_AG0;
+	uint32_t L1_RCNR1_CNF_DARK_AG1;
+	uint32_t L1_RCNR1_CNF_DARK_AG2;
+	uint32_t L1_RCNR1_CNF_RATIO_AG0;
+	uint32_t L1_RCNR1_CNF_RATIO_AG1;
+	uint32_t L1_RCNR1_CNF_RATIO_AG2;
+	uint32_t L1_RCNR1_CNF_CLIP_GAIN_R;
+	uint32_t L1_RCNR1_CNF_CLIP_GAIN_G;
+	uint32_t L1_RCNR1_CNF_CLIP_GAIN_B;
+	uint32_t L1_RCNR1_A1L_DARK_AG0;
+	uint32_t L1_RCNR1_A1L_DARK_AG1;
+	uint32_t L1_RCNR1_A1L_DARK_AG2;
+	uint32_t L1_RCNR1_A1L_RATIO_AG0;
+	uint32_t L1_RCNR1_A1L_RATIO_AG1;
+	uint32_t L1_RCNR1_A1L_RATIO_AG2;
+	uint32_t L1_RCNR1_INF_ZERO_CLIP;
+	uint32_t RESERVED_A_30;
+	uint32_t L1_RCNR1_MERGE_D2BLEND_AG0;
+	uint32_t L1_RCNR1_MERGE_D2BLEND_AG1;
+	uint32_t L1_RCNR1_MERGE_D2BLEND_AG2;
+	uint32_t L1_RCNR1_MERGE_BLACK;
+	uint32_t L1_RCNR1_MERGE_MINDIV;
+	uint32_t L1_RCNR1_HRY_TYPE;
+	uint32_t L1_RCNR1_ANF_BLEND_AG0;
+	uint32_t L1_RCNR1_ANF_BLEND_AG1;
+	uint32_t L1_RCNR1_ANF_BLEND_AG2;
+	uint32_t RESERVED_A_31;
+	uint32_t L1_RCNR1_LPF_THRESHOLD;
+	uint32_t L1_RCNR1_MERGE_HLBLEND_AG0;
+	uint32_t L1_RCNR1_MERGE_HLBLEND_AG1;
+	uint32_t L1_RCNR1_MERGE_HLBLEND_AG2;
+	uint32_t L1_RCNR1_GNR_SW;
+	uint32_t L1_RCNR1_GNR_RATIO;
+	uint32_t L1_RCNR1_GNR_WIDE_EN;
+	uint32_t L1_RCNR2_AG_CONT;
+	uint32_t RESERVED_A_32;
+	uint32_t L1_RCNR2_SW;
+	uint32_t L1_RCNR2_CNF_DARK_AG0;
+	uint32_t L1_RCNR2_CNF_DARK_AG1;
+	uint32_t L1_RCNR2_CNF_DARK_AG2;
+	uint32_t L1_RCNR2_CNF_RATIO_AG0;
+	uint32_t L1_RCNR2_CNF_RATIO_AG1;
+	uint32_t L1_RCNR2_CNF_RATIO_AG2;
+	uint32_t L1_RCNR2_CNF_CLIP_GAIN_R;
+	uint32_t L1_RCNR2_CNF_CLIP_GAIN_G;
+	uint32_t L1_RCNR2_CNF_CLIP_GAIN_B;
+	uint32_t L1_RCNR2_A1L_DARK_AG0;
+	uint32_t L1_RCNR2_A1L_DARK_AG1;
+	uint32_t L1_RCNR2_A1L_DARK_AG2;
+	uint32_t L1_RCNR2_A1L_RATIO_AG0;
+	uint32_t L1_RCNR2_A1L_RATIO_AG1;
+	uint32_t L1_RCNR2_A1L_RATIO_AG2;
+	uint32_t L1_RCNR2_INF_ZERO_CLIP;
+	uint32_t RESERVED_A_33;
+	uint32_t L1_RCNR2_MERGE_D2BLEND_AG0;
+	uint32_t L1_RCNR2_MERGE_D2BLEND_AG1;
+	uint32_t L1_RCNR2_MERGE_D2BLEND_AG2;
+	uint32_t L1_RCNR2_MERGE_BLACK;
+	uint32_t L1_RCNR2_MERGE_MINDIV;
+	uint32_t L1_RCNR2_HRY_TYPE;
+	uint32_t L1_RCNR2_ANF_BLEND_AG0;
+	uint32_t L1_RCNR2_ANF_BLEND_AG1;
+	uint32_t L1_RCNR2_ANF_BLEND_AG2;
+	uint32_t RESERVED_A_34;
+	uint32_t L1_RCNR2_LPF_THRESHOLD;
+	uint32_t L1_RCNR2_MERGE_HLBLEND_AG0;
+	uint32_t L1_RCNR2_MERGE_HLBLEND_AG1;
+	uint32_t L1_RCNR2_MERGE_HLBLEND_AG2;
+	uint32_t L1_RCNR2_GNR_SW;
+	uint32_t L1_RCNR2_GNR_RATIO;
+	uint32_t L1_RCNR2_GNR_WIDE_EN;
+	uint32_t RESERVED_B_9[49];
+	uint32_t RESERVED_A_35;
+	uint32_t L1_HDRS_HdrRatioM;
+	uint32_t L1_HDRS_HdrRatioL;
+	uint32_t L1_HDRS_HdrRatioE;
+	uint32_t RESERVED_A_36;
+	uint32_t RESERVED_A_37;
+	uint32_t L1_HDRS_BlendEndH;
+	uint32_t L1_HDRS_BlendEndM;
+	uint32_t L1_HDRS_BlendEndE;
+	uint32_t L1_HDRS_BlendBegH;
+	uint32_t L1_HDRS_BlendBegM;
+	uint32_t L1_HDRS_BlendBegE;
+	uint32_t RESERVED_A_38;
+	uint32_t RESERVED_A_39;
+	uint32_t RESERVED_A_40;
+	uint32_t RESERVED_A_41;
+	uint32_t RESERVED_A_42;
+	uint32_t RESERVED_A_43;
+	uint32_t L1_HDRS_DgH;
+	uint32_t L1_HDRS_DgM;
+	uint32_t L1_HDRS_DgL;
+	uint32_t L1_HDRS_DgE;
+	uint32_t L1_HDRS_LedModeOn;
+	uint32_t L1_HDRS_HdrMode;
+	uint32_t RESERVED_A_44;
+	uint32_t RESERVED_A_45;
+	uint32_t RESERVED_A_46;
+	uint32_t L1_HDRS_DstMaxval;
+	uint32_t RESERVED_B_10[4];
+	uint32_t L1_BLVC_SrcBlackLevelGr;
+	uint32_t L1_BLVC_SrcBlackLevelR;
+	uint32_t L1_BLVC_SrcBlackLevelB;
+	uint32_t L1_BLVC_SrcBlackLevelGb;
+	uint32_t L1_BLVC_MultValGr;
+	uint32_t L1_BLVC_MultValR;
+	uint32_t L1_BLVC_MultValB;
+	uint32_t L1_BLVC_MultValGb;
+	uint32_t L1_BLVC_DstMaxval;
+	uint32_t RESERVED_A_47;
+	uint32_t RESERVED_A_48;
+	uint32_t RESERVED_A_49;
+	uint32_t RESERVED_A_50;
+	uint32_t RESERVED_A_51;
+	uint32_t RESERVED_A_52;
+	uint32_t RESERVED_B_11[17];
+	uint32_t L1_LSSC_EN;
+	uint32_t L1_LSSC_AG_CONT;
+	uint32_t RESERVED_A_53;
+	uint32_t RESERVED_A_54;
+	uint32_t L1_LSSC_PWHB_R_GAIN;
+	uint32_t L1_LSSC_PWHB_GR_GAIN;
+	uint32_t L1_LSSC_PWHB_GB_GAIN;
+	uint32_t L1_LSSC_PWHB_B_GAIN;
+	uint32_t L1_LSSC_PARA_EN;
+	uint32_t L1_LSSC_PARA_H_CENTER;
+	uint32_t L1_LSSC_PARA_V_CENTER;
+	uint32_t L1_LSSC_PARA_H_GAIN;
+	uint32_t L1_LSSC_PARA_V_GAIN;
+	uint32_t L1_LSSC_PARA_MGSEL2;
+	uint32_t L1_LSSC_PARA_MGSEL4;
+	uint32_t L1_LSSC_PARA_R_COEF_2D_H_L;
+	uint32_t L1_LSSC_PARA_R_COEF_2D_H_R;
+	uint32_t L1_LSSC_PARA_R_COEF_2D_V_U;
+	uint32_t L1_LSSC_PARA_R_COEF_2D_V_D;
+	uint32_t L1_LSSC_PARA_R_COEF_2D_HV_LU;
+	uint32_t L1_LSSC_PARA_R_COEF_2D_HV_RU;
+	uint32_t L1_LSSC_PARA_R_COEF_2D_HV_LD;
+	uint32_t L1_LSSC_PARA_R_COEF_2D_HV_RD;
+	uint32_t L1_LSSC_PARA_R_COEF_4D_H_L;
+	uint32_t L1_LSSC_PARA_R_COEF_4D_H_R;
+	uint32_t L1_LSSC_PARA_R_COEF_4D_V_U;
+	uint32_t L1_LSSC_PARA_R_COEF_4D_V_D;
+	uint32_t L1_LSSC_PARA_R_COEF_4D_HV_LU;
+	uint32_t L1_LSSC_PARA_R_COEF_4D_HV_RU;
+	uint32_t L1_LSSC_PARA_R_COEF_4D_HV_LD;
+	uint32_t L1_LSSC_PARA_R_COEF_4D_HV_RD;
+	uint32_t L1_LSSC_PARA_GR_COEF_2D_H_L;
+	uint32_t L1_LSSC_PARA_GR_COEF_2D_H_R;
+	uint32_t L1_LSSC_PARA_GR_COEF_2D_V_U;
+	uint32_t L1_LSSC_PARA_GR_COEF_2D_V_D;
+	uint32_t L1_LSSC_PARA_GR_COEF_2D_HV_LU;
+	uint32_t L1_LSSC_PARA_GR_COEF_2D_HV_RU;
+	uint32_t L1_LSSC_PARA_GR_COEF_2D_HV_LD;
+	uint32_t L1_LSSC_PARA_GR_COEF_2D_HV_RD;
+	uint32_t L1_LSSC_PARA_GR_COEF_4D_H_L;
+	uint32_t L1_LSSC_PARA_GR_COEF_4D_H_R;
+	uint32_t L1_LSSC_PARA_GR_COEF_4D_V_U;
+	uint32_t L1_LSSC_PARA_GR_COEF_4D_V_D;
+	uint32_t L1_LSSC_PARA_GR_COEF_4D_HV_LU;
+	uint32_t L1_LSSC_PARA_GR_COEF_4D_HV_RU;
+	uint32_t L1_LSSC_PARA_GR_COEF_4D_HV_LD;
+	uint32_t L1_LSSC_PARA_GR_COEF_4D_HV_RD;
+	uint32_t L1_LSSC_PARA_GB_COEF_2D_H_L;
+	uint32_t L1_LSSC_PARA_GB_COEF_2D_H_R;
+	uint32_t L1_LSSC_PARA_GB_COEF_2D_V_U;
+	uint32_t L1_LSSC_PARA_GB_COEF_2D_V_D;
+	uint32_t L1_LSSC_PARA_GB_COEF_2D_HV_LU;
+	uint32_t L1_LSSC_PARA_GB_COEF_2D_HV_RU;
+	uint32_t L1_LSSC_PARA_GB_COEF_2D_HV_LD;
+	uint32_t L1_LSSC_PARA_GB_COEF_2D_HV_RD;
+	uint32_t L1_LSSC_PARA_GB_COEF_4D_H_L;
+	uint32_t L1_LSSC_PARA_GB_COEF_4D_H_R;
+	uint32_t L1_LSSC_PARA_GB_COEF_4D_V_U;
+	uint32_t L1_LSSC_PARA_GB_COEF_4D_V_D;
+	uint32_t L1_LSSC_PARA_GB_COEF_4D_HV_LU;
+	uint32_t L1_LSSC_PARA_GB_COEF_4D_HV_RU;
+	uint32_t L1_LSSC_PARA_GB_COEF_4D_HV_LD;
+	uint32_t L1_LSSC_PARA_GB_COEF_4D_HV_RD;
+	uint32_t L1_LSSC_PARA_B_COEF_2D_H_L;
+	uint32_t L1_LSSC_PARA_B_COEF_2D_H_R;
+	uint32_t L1_LSSC_PARA_B_COEF_2D_V_U;
+	uint32_t L1_LSSC_PARA_B_COEF_2D_V_D;
+	uint32_t L1_LSSC_PARA_B_COEF_2D_HV_LU;
+	uint32_t L1_LSSC_PARA_B_COEF_2D_HV_RU;
+	uint32_t L1_LSSC_PARA_B_COEF_2D_HV_LD;
+	uint32_t L1_LSSC_PARA_B_COEF_2D_HV_RD;
+	uint32_t L1_LSSC_PARA_B_COEF_4D_H_L;
+	uint32_t L1_LSSC_PARA_B_COEF_4D_H_R;
+	uint32_t L1_LSSC_PARA_B_COEF_4D_V_U;
+	uint32_t L1_LSSC_PARA_B_COEF_4D_V_D;
+	uint32_t L1_LSSC_PARA_B_COEF_4D_HV_LU;
+	uint32_t L1_LSSC_PARA_B_COEF_4D_HV_RU;
+	uint32_t L1_LSSC_PARA_B_COEF_4D_HV_LD;
+	uint32_t L1_LSSC_PARA_B_COEF_4D_HV_RD;
+	uint32_t L1_LSSC_GRID_EN;
+	uint32_t L1_LSSC_GRID_H_CENTER;
+	uint32_t L1_LSSC_GRID_V_CENTER;
+	uint32_t L1_LSSC_GRID_H_SIZE;
+	uint32_t L1_LSSC_GRID_V_SIZE;
+	uint32_t L1_LSSC_GRID_MGSEL;
+	uint32_t RESERVED_B_12[11];
+	uint32_t L1_MPRO_SW;
+	uint32_t L1_MPRO_CONF;
+	uint32_t RESERVED_A_55;
+	uint32_t L1_MPRO_DST_MINVAL;
+	uint32_t L1_MPRO_DST_MAXVAL;
+	uint32_t L1_MPRO_AG_CONT;
+	uint32_t RESERVED_A_56;
+	uint32_t RESERVED_A_57;
+	uint32_t L1_MPRO_LM0_RMG_MIN;
+	uint32_t L1_MPRO_LM0_RMB_MIN;
+	uint32_t L1_MPRO_LM0_GMR_MIN;
+	uint32_t L1_MPRO_LM0_GMB_MIN;
+	uint32_t L1_MPRO_LM0_BMR_MIN;
+	uint32_t L1_MPRO_LM0_BMG_MIN;
+	uint32_t L1_MPRO_LM0_RMG_MAX;
+	uint32_t L1_MPRO_LM0_RMB_MAX;
+	uint32_t L1_MPRO_LM0_GMR_MAX;
+	uint32_t L1_MPRO_LM0_GMB_MAX;
+	uint32_t L1_MPRO_LM0_BMR_MAX;
+	uint32_t L1_MPRO_LM0_BMG_MAX;
+	uint32_t RESERVED_A_58;
+	uint32_t RESERVED_A_59;
+	uint32_t RESERVED_A_60;
+	uint32_t RESERVED_A_61;
+	uint32_t RESERVED_A_62;
+	uint32_t RESERVED_A_63;
+	uint32_t RESERVED_A_64;
+	uint32_t RESERVED_A_65;
+	uint32_t RESERVED_A_66;
+	uint32_t RESERVED_A_67;
+	uint32_t RESERVED_A_68;
+	uint32_t RESERVED_A_69;
+	uint32_t RESERVED_A_70;
+	uint32_t RESERVED_A_71;
+	uint32_t RESERVED_A_72;
+	uint32_t RESERVED_A_73;
+	uint32_t RESERVED_A_74;
+	uint32_t RESERVED_A_75;
+	uint32_t RESERVED_A_76;
+	uint32_t RESERVED_A_77;
+	uint32_t RESERVED_A_78;
+	uint32_t RESERVED_A_79;
+	uint32_t RESERVED_A_80;
+	uint32_t RESERVED_A_81;
+	uint32_t RESERVED_A_82;
+	uint32_t RESERVED_A_83;
+	uint32_t RESERVED_A_84;
+	uint32_t RESERVED_A_85;
+	uint32_t RESERVED_A_86;
+	uint32_t RESERVED_A_87;
+	uint32_t RESERVED_A_88;
+	uint32_t RESERVED_A_89;
+	uint32_t RESERVED_A_90;
+	uint32_t RESERVED_A_91;
+	uint32_t RESERVED_A_92;
+	uint32_t RESERVED_A_93;
+	uint32_t RESERVED_A_94;
+	uint32_t RESERVED_A_95;
+	uint32_t RESERVED_A_96;
+	uint32_t RESERVED_B_13[1];
+	uint32_t L1_MPRO_LCS_MODE;
+	uint32_t RESERVED_A_97;
+	uint32_t RESERVED_A_98;
+	uint32_t RESERVED_A_99;
+	uint32_t RESERVED_A_100;
+	uint32_t RESERVED_A_101;
+	uint32_t RESERVED_A_102;
+	uint32_t RESERVED_A_103;
+	uint32_t RESERVED_A_104;
+	uint32_t RESERVED_A_105;
+	uint32_t RESERVED_A_106;
+	uint32_t RESERVED_A_107;
+	uint32_t RESERVED_A_108;
+	uint32_t RESERVED_A_109;
+	uint32_t RESERVED_A_110;
+	uint32_t RESERVED_A_111;
+	uint32_t RESERVED_A_112;
+	uint32_t RESERVED_A_113;
+	uint32_t RESERVED_A_114;
+	uint32_t RESERVED_A_115;
+	uint32_t RESERVED_A_116;
+	uint32_t RESERVED_A_117;
+	uint32_t RESERVED_A_118;
+	uint32_t RESERVED_A_119;
+	uint32_t RESERVED_A_120;
+	uint32_t RESERVED_A_121;
+	uint32_t RESERVED_A_122;
+	uint32_t RESERVED_A_123;
+	uint32_t RESERVED_A_124;
+	uint32_t RESERVED_A_125;
+	uint32_t RESERVED_B_14[70];
+	uint32_t L1_VPRO_PGC_SW;
+	uint32_t RESERVED_A_126;
+	uint32_t L1_VPRO_YUVC_SW;
+	uint32_t L1_VPRO_YNR_SW;
+	uint32_t L1_VPRO_ETE_SW;
+	uint32_t L1_VPRO_CSUP_UVSUP_SW;
+	uint32_t L1_VPRO_CSUP_CORING_SW;
+	uint32_t L1_VPRO_BRIGHT_SW;
+	uint32_t L1_VPRO_LCNT_SW;
+	uint32_t L1_VPRO_NLCNT_SW;
+	uint32_t RESERVED_A_127;
+	uint32_t L1_VPRO_EDGE_SUP_SW;
+	uint32_t L1_VPRO_CNR_SW;
+	uint32_t L1_VPRO_AG_CONT;
+	uint32_t L1_VPRO_BLKADJ;
+	uint32_t L1_VPRO_GAM01P;
+	uint32_t L1_VPRO_GAM02P;
+	uint32_t L1_VPRO_GAM03P;
+	uint32_t L1_VPRO_GAM04P;
+	uint32_t L1_VPRO_GAM05P;
+	uint32_t L1_VPRO_GAM06P;
+	uint32_t L1_VPRO_GAM07P;
+	uint32_t L1_VPRO_GAM08P;
+	uint32_t L1_VPRO_GAM09P;
+	uint32_t L1_VPRO_GAM10P;
+	uint32_t L1_VPRO_GAM11P;
+	uint32_t L1_VPRO_GAM12P;
+	uint32_t L1_VPRO_GAM13P;
+	uint32_t L1_VPRO_GAM14P;
+	uint32_t L1_VPRO_GAM15P;
+	uint32_t L1_VPRO_GAM16P;
+	uint32_t L1_VPRO_GAM17P;
+	uint32_t L1_VPRO_GAM18P;
+	uint32_t L1_VPRO_GAM19P;
+	uint32_t L1_VPRO_GAM20P;
+	uint32_t L1_VPRO_GAM21P;
+	uint32_t L1_VPRO_GAM22P;
+	uint32_t L1_VPRO_GAM23P;
+	uint32_t L1_VPRO_GAM24P;
+	uint32_t L1_VPRO_GAM25P;
+	uint32_t L1_VPRO_GAM26P;
+	uint32_t L1_VPRO_GAM27P;
+	uint32_t L1_VPRO_GAM28P;
+	uint32_t L1_VPRO_GAM29P;
+	uint32_t L1_VPRO_GAM30P;
+	uint32_t L1_VPRO_GAM31P;
+	uint32_t L1_VPRO_GAM32P;
+	uint32_t L1_VPRO_GAM33P;
+	uint32_t L1_VPRO_GAM34P;
+	uint32_t L1_VPRO_GAM35P;
+	uint32_t L1_VPRO_GAM36P;
+	uint32_t L1_VPRO_GAM37P;
+	uint32_t L1_VPRO_GAM38P;
+	uint32_t L1_VPRO_GAM39P;
+	uint32_t L1_VPRO_GAM40P;
+	uint32_t L1_VPRO_GAM41P;
+	uint32_t L1_VPRO_GAM42P;
+	uint32_t L1_VPRO_GAM43P;
+	uint32_t L1_VPRO_GAM44P;
+	uint32_t L1_VPRO_Cb_MAT;
+	uint32_t L1_VPRO_Cr_MAT;
+	uint32_t L1_VPRO_BRIGHT;
+	uint32_t L1_VPRO_LCONT_LEV;
+	uint32_t L1_VPRO_BLK_KNEE;
+	uint32_t L1_VPRO_WHT_KNEE;
+	uint32_t L1_VPRO_BLK_CONT0;
+	uint32_t L1_VPRO_BLK_CONT1;
+	uint32_t L1_VPRO_BLK_CONT2;
+	uint32_t L1_VPRO_WHT_CONT0;
+	uint32_t L1_VPRO_WHT_CONT1;
+	uint32_t L1_VPRO_WHT_CONT2;
+	uint32_t RESERVED_A_128;
+	uint32_t RESERVED_A_129;
+	uint32_t RESERVED_A_130;
+	uint32_t RESERVED_A_131;
+	uint32_t RESERVED_A_132;
+	uint32_t RESERVED_A_133;
+	uint32_t L1_VPRO_YNR_GAIN_MIN;
+	uint32_t L1_VPRO_YNR_GAIN_MAX;
+	uint32_t L1_VPRO_YNR_LIM_MIN;
+	uint32_t L1_VPRO_YNR_LIM_MAX;
+	uint32_t L1_VPRO_ETE_GAIN_MIN;
+	uint32_t L1_VPRO_ETE_GAIN_MAX;
+	uint32_t L1_VPRO_ETE_LIM_MIN;
+	uint32_t L1_VPRO_ETE_LIM_MAX;
+	uint32_t L1_VPRO_ETE_CORING_MIN;
+	uint32_t L1_VPRO_ETE_CORING_MAX;
+	uint32_t L1_VPRO_Cb_GAIN;
+	uint32_t L1_VPRO_Cr_GAIN;
+	uint32_t L1_VPRO_Cbr_MGAIN_MIN;
+	uint32_t L1_VPRO_CbP_GAIN_MAX;
+	uint32_t L1_VPRO_CbM_GAIN_MAX;
+	uint32_t L1_VPRO_CrP_GAIN_MAX;
+	uint32_t L1_VPRO_CrM_GAIN_MAX;
+	uint32_t L1_VPRO_CSUP_CORING_LV_MIN;
+	uint32_t L1_VPRO_CSUP_CORING_LV_MAX;
+	uint32_t L1_VPRO_CSUP_CORING_GAIN_MIN;
+	uint32_t L1_VPRO_CSUP_CORING_GAIN_MAX;
+	uint32_t L1_VPRO_CSUP_BK_SLV;
+	uint32_t L1_VPRO_CSUP_BK_MP;
+	uint32_t L1_VPRO_CSUP_BLACK;
+	uint32_t L1_VPRO_CSUP_WH_SLV;
+	uint32_t L1_VPRO_CSUP_WH_MP;
+	uint32_t L1_VPRO_CSUP_WHITE;
+	uint32_t L1_VPRO_EDGE_SUP_GAIN;
+	uint32_t L1_VPRO_EDGE_SUP_LIM;
+	uint32_t RESERVED_B_15[22];
+	uint32_t L1_AWHB_SW;
+	uint32_t RESERVED_A_134;
+	uint32_t L1_AWHB_WBMRG;
+	uint32_t L1_AWHB_WBMGG;
+	uint32_t L1_AWHB_WBMBG;
+	uint32_t L1_AWHB_GATE_CONF0;
+	uint32_t L1_AWHB_GATE_CONF1;
+	uint32_t L1_AWHB_AREA_HSIZE;
+	uint32_t L1_AWHB_AREA_VSIZE;
+	uint32_t L1_AWHB_AREA_HOFS;
+	uint32_t L1_AWHB_AREA_VOFS;
+	uint32_t L1_AWHB_AREA_MASKH;
+	uint32_t L1_AWHB_AREA_MASKL;
+	uint32_t L1_AWHB_SQ_CONF;
+	uint32_t L1_AWHB_YGATEH;
+	uint32_t L1_AWHB_YGATEL;
+	uint32_t RESERVED_A_135;
+	uint32_t RESERVED_A_136;
+	uint32_t L1_AWHB_BYCUT0P;
+	uint32_t L1_AWHB_BYCUT0N;
+	uint32_t L1_AWHB_RYCUT0P;
+	uint32_t L1_AWHB_RYCUT0N;
+	uint32_t L1_AWHB_RBCUT0H;
+	uint32_t L1_AWHB_RBCUT0L;
+	uint32_t RESERVED_A_137;
+	uint32_t RESERVED_A_138;
+	uint32_t RESERVED_A_139;
+	uint32_t RESERVED_A_140;
+	uint32_t RESERVED_A_141;
+	uint32_t RESERVED_A_142;
+	uint32_t L1_AWHB_BYCUT1H;
+	uint32_t L1_AWHB_BYCUT1L;
+	uint32_t L1_AWHB_RYCUT1H;
+	uint32_t L1_AWHB_RYCUT1L;
+	uint32_t L1_AWHB_BYCUT2H;
+	uint32_t L1_AWHB_BYCUT2L;
+	uint32_t L1_AWHB_RYCUT2H;
+	uint32_t L1_AWHB_RYCUT2L;
+	uint32_t L1_AWHB_BYCUT3H;
+	uint32_t L1_AWHB_BYCUT3L;
+	uint32_t L1_AWHB_RYCUT3H;
+	uint32_t L1_AWHB_RYCUT3L;
+	uint32_t L1_AWHB_AWBSFTU;
+	uint32_t L1_AWHB_AWBSFTV;
+	uint32_t L1_AWHB_AWBSPD;
+	uint32_t L1_AWHB_AWBULV;
+	uint32_t L1_AWHB_AWBVLV;
+	uint32_t L1_AWHB_AWBWAIT;
+	uint32_t L1_AWHB_AWBONDOT;
+	uint32_t L1_AWHB_AWBFZTIM;
+	uint32_t L1_AWHB_WBGRMAX;
+	uint32_t L1_AWHB_WBGRMIN;
+	uint32_t L1_AWHB_WBGBMAX;
+	uint32_t L1_AWHB_WBGBMIN;
+	uint32_t RESERVED_A_143;
+	uint32_t RESERVED_A_144;
+	uint32_t RESERVED_A_145;
+	uint32_t RESERVED_A_146;
+	uint32_t RESERVED_A_147;
+	uint32_t RESERVED_A_148;
+	uint32_t RESERVED_A_149;
+	uint32_t RESERVED_A_150;
+	uint32_t RESERVED_A_151;
+	uint32_t RESERVED_A_152;
+	uint32_t RESERVED_A_153;
+	uint32_t RESERVED_A_154;
+	uint32_t RESERVED_A_155;
+	uint32_t L1_AWHB_AVE_USIG;
+	uint32_t L1_AWHB_AVE_VSIG;
+	uint32_t L1_AWHB_NUM_UVON;
+	uint32_t L1_AWHB_AWBGAINR;
+	uint32_t L1_AWHB_AWBGAING;
+	uint32_t L1_AWHB_AWBGAINB;
+	uint32_t RESERVED_A_156;
+	uint32_t RESERVED_A_157;
+	uint32_t RESERVED_A_158;
+	uint32_t L1_AWHB_R_CTR_STOP;
+	uint32_t RESERVED_A_159;
+	uint32_t RESERVED_B_16[2];
+	uint32_t L1_HOBC_EN;
+	uint32_t L1_HOBC_MARGIN;
+	uint32_t L1_HOBC01_AG_CONT;
+	uint32_t L1_HOBC2_AG_CONT;
+	uint32_t L1_HOBC0_LOB_REFLV_GR;
+	uint32_t L1_HOBC0_LOB_WIDTH_GR;
+	uint32_t L1_HOBC0_LOB_REFLV_R;
+	uint32_t L1_HOBC0_LOB_WIDTH_R;
+	uint32_t L1_HOBC0_LOB_REFLV_B;
+	uint32_t L1_HOBC0_LOB_WIDTH_B;
+	uint32_t L1_HOBC0_LOB_REFLV_GB;
+	uint32_t L1_HOBC0_LOB_WIDTH_GB;
+	uint32_t L1_HOBC1_LOB_REFLV_GR;
+	uint32_t L1_HOBC1_LOB_WIDTH_GR;
+	uint32_t L1_HOBC1_LOB_REFLV_R;
+	uint32_t L1_HOBC1_LOB_WIDTH_R;
+	uint32_t L1_HOBC1_LOB_REFLV_B;
+	uint32_t L1_HOBC1_LOB_WIDTH_B;
+	uint32_t L1_HOBC1_LOB_REFLV_GB;
+	uint32_t L1_HOBC1_LOB_WIDTH_GB;
+	uint32_t L1_HOBC2_LOB_REFLV_GR;
+	uint32_t L1_HOBC2_LOB_WIDTH_GR;
+	uint32_t L1_HOBC2_LOB_REFLV_R;
+	uint32_t L1_HOBC2_LOB_WIDTH_R;
+	uint32_t L1_HOBC2_LOB_REFLV_B;
+	uint32_t L1_HOBC2_LOB_WIDTH_B;
+	uint32_t L1_HOBC2_LOB_REFLV_GB;
+	uint32_t L1_HOBC2_LOB_WIDTH_GB;
+	uint32_t L1_HOBC0_SRC_BLKLV_GR;
+	uint32_t L1_HOBC0_SRC_BLKLV_R;
+	uint32_t L1_HOBC0_SRC_BLKLV_B;
+	uint32_t L1_HOBC0_SRC_BLKLV_GB;
+	uint32_t L1_HOBC1_SRC_BLKLV_GR;
+	uint32_t L1_HOBC1_SRC_BLKLV_R;
+	uint32_t L1_HOBC1_SRC_BLKLV_B;
+	uint32_t L1_HOBC1_SRC_BLKLV_GB;
+	uint32_t L1_HOBC2_SRC_BLKLV_GR;
+	uint32_t L1_HOBC2_SRC_BLKLV_R;
+	uint32_t L1_HOBC2_SRC_BLKLV_B;
+	uint32_t L1_HOBC2_SRC_BLKLV_GB;
+	uint32_t RESERVED_A_160;
+	uint32_t RESERVED_A_161;
+	uint32_t RESERVED_A_162;
+	uint32_t RESERVED_A_163;
+	uint32_t RESERVED_A_164;
+	uint32_t RESERVED_A_165;
+	uint32_t L1_HOBC_MAX_VAL;
+	uint32_t RESERVED_B_17[33];
+	uint32_t L1_HDRC_EN;
+	uint32_t L1_HDRC_THR_SFT_AMT;
+	uint32_t RESERVED_A_166;
+	uint32_t L1_HDRC_RATIO;
+	uint32_t RESERVED_A_167;
+	uint32_t RESERVED_A_168;
+	uint32_t RESERVED_A_169;
+	uint32_t L1_HDRC_PT_RATIO;
+	uint32_t L1_HDRC_PT_BLEND;
+	uint32_t L1_HDRC_PT_BLEND2;
+	uint32_t L1_HDRC_PT_SAT;
+	uint32_t L1_HDRC_TN_TYPE;
+	uint32_t L1_HDRC_TNP_MAX;
+	uint32_t L1_HDRC_TNP_MAG;
+	uint32_t L1_HDRC_TNP_FB_SMTH_MAX0;
+	uint32_t L1_HDRC_TNP_FB_SMTH_MAX1;
+	uint32_t L1_HDRC_TNP_FB_SMTH_MAX2;
+	uint32_t L1_HDRC_TNP_FB_SMTH_MAX3;
+	uint32_t L1_HDRC_TNP_FIL0;
+	uint32_t L1_HDRC_TNP_FIL1;
+	uint32_t L1_HDRC_TNP_FIL2;
+	uint32_t L1_HDRC_TNP_FIL3;
+	uint32_t L1_HDRC_TNP_FIL4;
+	uint32_t L1_HDRC_UTN_TBL0;
+	uint32_t L1_HDRC_UTN_TBL1;
+	uint32_t L1_HDRC_UTN_TBL2;
+	uint32_t L1_HDRC_UTN_TBL3;
+	uint32_t L1_HDRC_UTN_TBL4;
+	uint32_t L1_HDRC_UTN_TBL5;
+	uint32_t L1_HDRC_UTN_TBL6;
+	uint32_t L1_HDRC_UTN_TBL7;
+	uint32_t L1_HDRC_UTN_TBL8;
+	uint32_t L1_HDRC_UTN_TBL9;
+	uint32_t L1_HDRC_UTN_TBL10;
+	uint32_t L1_HDRC_UTN_TBL11;
+	uint32_t L1_HDRC_UTN_TBL12;
+	uint32_t L1_HDRC_UTN_TBL13;
+	uint32_t L1_HDRC_UTN_TBL14;
+	uint32_t L1_HDRC_UTN_TBL15;
+	uint32_t L1_HDRC_UTN_TBL16;
+	uint32_t L1_HDRC_UTN_TBL17;
+	uint32_t L1_HDRC_UTN_TBL18;
+	uint32_t L1_HDRC_UTN_TBL19;
+	uint32_t L1_HDRC_FLR_VAL;
+	uint32_t L1_HDRC_FLR_ADP;
+	uint32_t RESERVED_A_170;
+	uint32_t RESERVED_A_171;
+	uint32_t RESERVED_A_172;
+	uint32_t RESERVED_A_173;
+	uint32_t RESERVED_A_174;
+	uint32_t RESERVED_A_175;
+	uint32_t RESERVED_A_176;
+	uint32_t RESERVED_A_177;
+	uint32_t RESERVED_A_178;
+	uint32_t RESERVED_A_179;
+	uint32_t RESERVED_A_180;
+	uint32_t RESERVED_A_181;
+	uint32_t RESERVED_A_182;
+	uint32_t RESERVED_A_183;
+	uint32_t L1_HDRC_YBR_OFF;
+	uint32_t L1_HDRC_ORGY_BLEND;
+	uint32_t RESERVED_A_184;
+	uint32_t RESERVED_A_185;
+	uint32_t RESERVED_A_186;
+	uint32_t L1_HDRC_MAR_TOP;
+	uint32_t L1_HDRC_MAR_LEFT;
+	uint32_t RESERVED_A_187;
+	uint32_t RESERVED_A_188;
+	uint32_t RESERVED_B_18[28];
+	uint32_t L1_HIST_EN;
+	uint32_t L1_HIST_MODE;
+	uint32_t L1_HIST_BLOCK_OFST;
+	uint32_t L1_HIST_BLOCK_SIZE;
+	uint32_t L1_HIST_BLOCK_NUM;
+	uint32_t L1_HIST_BLOCK_STEP;
+	uint32_t L1_HIST_LINEAR_SFT;
+	uint32_t L1_HIST_MULT_A_R;
+	uint32_t L1_HIST_ADD_A_R;
+	uint32_t L1_HIST_MULT_B_R;
+	uint32_t L1_HIST_ADD_B_R;
+	uint32_t L1_HIST_MULT_A_G;
+	uint32_t L1_HIST_ADD_A_G;
+	uint32_t L1_HIST_MULT_B_G;
+	uint32_t L1_HIST_ADD_B_G;
+	uint32_t L1_HIST_MULT_A_B;
+	uint32_t L1_HIST_ADD_A_B;
+	uint32_t L1_HIST_MULT_B_B;
+	uint32_t L1_HIST_ADD_B_B;
+	uint32_t L1_HIST_MULT_A_Y;
+	uint32_t L1_HIST_ADD_A_Y;
+	uint32_t L1_HIST_MULT_B_Y;
+	uint32_t L1_HIST_ADD_B_Y;
+	uint32_t RESERVED_B_19[201];
+	uint32_t L1_CRGBF_ACC_CONF;
+	uint32_t L1_CRGBF_TRN_M_RUN;
+	uint32_t L1_CRGBF_TRN_M_CONF;
+	uint32_t L1_CRGBF_TRN_A_CONF;
+	uint32_t L1_CRGBF_TRN_STAT_CLR;
+	uint32_t L1_CRGBF_TRN_STAT;
+	uint32_t L1_CRGBF_INT_STAT;
+	uint32_t L1_CRGBF_INT_MASK;
+	uint32_t L1_CRGBF_INT_MASKED_STAT;
+	uint32_t L1_CRGBF_TRN_WBADDR;
+	uint32_t L1_CRGBF_TRN_WEADDR;
+	uint32_t L1_CRGBF_TRN_RBADDR;
+	uint32_t L1_CRGBF_TRN_READDR;
+	uint32_t L1_CRGBF_ISP_INT;
+	uint32_t L1_CRGBF_ISP_INT_MASK;
+	uint32_t L1_CRGBF_ISP_INT_MASKED_STAT;
+	uint32_t RESERVED_A_189;
+	uint32_t RESERVED_B_20[47];
+	uint32_t L1_VLATCH_SYSM_WIDTH;
+	uint32_t L1_VLATCH_SYSM_HEIGHT;
+	uint32_t L1_VLATCH_SYSM_START_COLOR;
+	uint32_t L1_VLATCH_SYSM_INPUT_MODE;
+	uint32_t RESERVED_A_190;
+	uint32_t L1_VLATCH_SYSM_YCOEF_R;
+	uint32_t L1_VLATCH_SYSM_YCOEF_G;
+	uint32_t L1_VLATCH_SYSM_YCOEF_B;
+	uint32_t RESERVED_A_191;
+	uint32_t RESERVED_A_192;
+	uint32_t RESERVED_A_193;
+	uint32_t RESERVED_A_194;
+	uint32_t RESERVED_A_195;
+	uint32_t RESERVED_A_196;
+	uint32_t RESERVED_B_21[2];
+	uint32_t L1_VLATCH_SYSM_AG_H;
+	uint32_t L1_VLATCH_SYSM_AG_M;
+	uint32_t L1_VLATCH_SYSM_AG_L;
+	uint32_t L1_VLATCH_SYSM_AG_PARAM_A;
+	uint32_t L1_VLATCH_SYSM_AG_PARAM_B;
+	uint32_t L1_VLATCH_SYSM_AG_PARAM_C;
+	uint32_t L1_VLATCH_SYSM_AG_PARAM_D;
+	uint32_t L1_VLATCH_SYSM_AG_SEL_HOBC;
+	uint32_t L1_VLATCH_SYSM_AG_SEL_ABPC;
+	uint32_t L1_VLATCH_SYSM_AG_SEL_RCNR;
+	uint32_t L1_VLATCH_SYSM_AG_SEL_LSSC;
+	uint32_t L1_VLATCH_SYSM_AG_SEL_MPRO;
+	uint32_t L1_VLATCH_SYSM_AG_SEL_VPRO;
+	uint32_t L1_VLATCH_SYSM_AG_CONT_HOBC01_EN;
+	uint32_t L1_VLATCH_SYSM_AG_CONT_HOBC2_EN;
+	uint32_t L1_VLATCH_SYSM_AG_CONT_ABPC01_EN;
+	uint32_t L1_VLATCH_SYSM_AG_CONT_ABPC2_EN;
+	uint32_t L1_VLATCH_SYSM_AG_CONT_RCNR01_EN;
+	uint32_t L1_VLATCH_SYSM_AG_CONT_RCNR2_EN;
+	uint32_t L1_VLATCH_SYSM_AG_CONT_LSSC_EN;
+	uint32_t L1_VLATCH_SYSM_AG_CONT_MPRO_EN;
+	uint32_t L1_VLATCH_SYSM_AG_CONT_VPRO_EN;
+	uint32_t RESERVED_A_197;
+	uint32_t L1_VLATCH_SYSM_MAN_CTXT;
+	uint32_t RESERVED_A_198;
+	uint32_t RESERVED_B_22[7];
+	uint32_t RESERVED_A_199;
+	uint32_t L1_VLATCH_HDRE_SrcPoint00;
+	uint32_t L1_VLATCH_HDRE_SrcPoint01;
+	uint32_t L1_VLATCH_HDRE_SrcPoint02;
+	uint32_t L1_VLATCH_HDRE_SrcPoint03;
+	uint32_t L1_VLATCH_HDRE_SrcPoint04;
+	uint32_t L1_VLATCH_HDRE_SrcPoint05;
+	uint32_t L1_VLATCH_HDRE_SrcPoint06;
+	uint32_t L1_VLATCH_HDRE_SrcPoint07;
+	uint32_t L1_VLATCH_HDRE_SrcPoint08;
+	uint32_t L1_VLATCH_HDRE_SrcPoint09;
+	uint32_t L1_VLATCH_HDRE_SrcPoint10;
+	uint32_t L1_VLATCH_HDRE_SrcPoint11;
+	uint32_t L1_VLATCH_HDRE_SrcPoint12;
+	uint32_t L1_VLATCH_HDRE_SrcPoint13;
+	uint32_t L1_VLATCH_HDRE_SrcPoint14;
+	uint32_t L1_VLATCH_HDRE_SrcPoint15;
+	uint32_t L1_VLATCH_HDRE_SrcBase00;
+	uint32_t L1_VLATCH_HDRE_SrcBase01;
+	uint32_t L1_VLATCH_HDRE_SrcBase02;
+	uint32_t L1_VLATCH_HDRE_SrcBase03;
+	uint32_t L1_VLATCH_HDRE_SrcBase04;
+	uint32_t L1_VLATCH_HDRE_SrcBase05;
+	uint32_t L1_VLATCH_HDRE_SrcBase06;
+	uint32_t L1_VLATCH_HDRE_SrcBase07;
+	uint32_t L1_VLATCH_HDRE_SrcBase08;
+	uint32_t L1_VLATCH_HDRE_SrcBase09;
+	uint32_t L1_VLATCH_HDRE_SrcBase10;
+	uint32_t L1_VLATCH_HDRE_SrcBase11;
+	uint32_t L1_VLATCH_HDRE_SrcBase12;
+	uint32_t L1_VLATCH_HDRE_SrcBase13;
+	uint32_t L1_VLATCH_HDRE_SrcBase14;
+	uint32_t L1_VLATCH_HDRE_SrcBase15;
+	uint32_t L1_VLATCH_HDRE_SrcBase16;
+	uint32_t L1_VLATCH_HDRE_Ratio00;
+	uint32_t L1_VLATCH_HDRE_Ratio01;
+	uint32_t L1_VLATCH_HDRE_Ratio02;
+	uint32_t L1_VLATCH_HDRE_Ratio03;
+	uint32_t L1_VLATCH_HDRE_Ratio04;
+	uint32_t L1_VLATCH_HDRE_Ratio05;
+	uint32_t L1_VLATCH_HDRE_Ratio06;
+	uint32_t L1_VLATCH_HDRE_Ratio07;
+	uint32_t L1_VLATCH_HDRE_Ratio08;
+	uint32_t L1_VLATCH_HDRE_Ratio09;
+	uint32_t L1_VLATCH_HDRE_Ratio10;
+	uint32_t L1_VLATCH_HDRE_Ratio11;
+	uint32_t L1_VLATCH_HDRE_Ratio12;
+	uint32_t L1_VLATCH_HDRE_Ratio13;
+	uint32_t L1_VLATCH_HDRE_Ratio14;
+	uint32_t L1_VLATCH_HDRE_Ratio15;
+	uint32_t L1_VLATCH_HDRE_Ratio16;
+	uint32_t L1_VLATCH_HDRE_DstBase00;
+	uint32_t L1_VLATCH_HDRE_DstBase01;
+	uint32_t L1_VLATCH_HDRE_DstBase02;
+	uint32_t L1_VLATCH_HDRE_DstBase03;
+	uint32_t L1_VLATCH_HDRE_DstBase04;
+	uint32_t L1_VLATCH_HDRE_DstBase05;
+	uint32_t L1_VLATCH_HDRE_DstBase06;
+	uint32_t L1_VLATCH_HDRE_DstBase07;
+	uint32_t L1_VLATCH_HDRE_DstBase08;
+	uint32_t L1_VLATCH_HDRE_DstBase09;
+	uint32_t L1_VLATCH_HDRE_DstBase10;
+	uint32_t L1_VLATCH_HDRE_DstBase11;
+	uint32_t L1_VLATCH_HDRE_DstBase12;
+	uint32_t L1_VLATCH_HDRE_DstBase13;
+	uint32_t L1_VLATCH_HDRE_DstBase14;
+	uint32_t L1_VLATCH_HDRE_DstBase15;
+	uint32_t L1_VLATCH_HDRE_DstBase16;
+	uint32_t L1_VLATCH_HDRE_DstMaxval;
+	uint32_t RESERVED_B_23[11];
+	uint32_t L1_VLATCH_AEXP_ON;
+	uint32_t RESERVED_A_200;
+	uint32_t RESERVED_A_201;
+	uint32_t L1_VLATCH_AEXP_FORCE_INTERRUPT_Y;
+	uint32_t L1_VLATCH_AEXP_START_X;
+	uint32_t L1_VLATCH_AEXP_START_Y;
+	uint32_t L1_VLATCH_AEXP_BLOCK_WIDTH;
+	uint32_t L1_VLATCH_AEXP_BLOCK_HEIGHT;
+	uint32_t L1_VLATCH_AEXP_WEIGHT_0;
+	uint32_t L1_VLATCH_AEXP_WEIGHT_1;
+	uint32_t L1_VLATCH_AEXP_WEIGHT_2;
+	uint32_t L1_VLATCH_AEXP_WEIGHT_3;
+	uint32_t L1_VLATCH_AEXP_WEIGHT_4;
+	uint32_t L1_VLATCH_AEXP_WEIGHT_5;
+	uint32_t L1_VLATCH_AEXP_WEIGHT_6;
+	uint32_t L1_VLATCH_AEXP_WEIGHT_7;
+	uint32_t L1_VLATCH_AEXP_SATUR_RATIO;
+	uint32_t L1_VLATCH_AEXP_BLACK_RATIO;
+	uint32_t L1_VLATCH_AEXP_SATUR_LEVEL;
+	uint32_t RESERVED_A_202;
+	uint32_t RESERVED_A_203;
+	uint32_t RESERVED_A_204;
+	uint32_t RESERVED_A_205;
+	uint32_t RESERVED_A_206;
+	uint32_t RESERVED_A_207;
+	uint32_t RESERVED_A_208;
+	uint32_t RESERVED_A_209;
+	uint32_t RESERVED_A_210;
+	uint32_t RESERVED_A_211;
+	uint32_t RESERVED_A_212;
+	uint32_t RESERVED_A_213;
+	uint32_t RESERVED_A_214;
+	uint32_t RESERVED_A_215;
+	uint32_t RESERVED_A_216;
+	uint32_t RESERVED_A_217;
+	uint32_t RESERVED_A_218;
+	uint32_t RESERVED_A_219;
+	uint32_t RESERVED_A_220;
+	uint32_t RESERVED_A_221;
+	uint32_t RESERVED_A_222;
+	uint32_t RESERVED_A_223;
+	uint32_t RESERVED_A_224;
+	uint32_t RESERVED_A_225;
+	uint32_t RESERVED_A_226;
+	uint32_t RESERVED_A_227;
+	uint32_t RESERVED_A_228;
+	uint32_t RESERVED_A_229;
+	uint32_t RESERVED_A_230;
+	uint32_t RESERVED_A_231;
+	uint32_t RESERVED_A_232;
+	uint32_t RESERVED_A_233;
+	uint32_t RESERVED_A_234;
+	uint32_t RESERVED_A_235;
+	uint32_t RESERVED_A_236;
+	uint32_t RESERVED_A_237;
+	uint32_t RESERVED_A_238;
+	uint32_t RESERVED_A_239;
+	uint32_t RESERVED_A_240;
+	uint32_t RESERVED_A_241;
+	uint32_t RESERVED_A_242;
+	uint32_t RESERVED_A_243;
+	uint32_t RESERVED_A_244;
+	uint32_t RESERVED_A_245;
+	uint32_t RESERVED_A_246;
+	uint32_t RESERVED_A_247;
+	uint32_t RESERVED_A_248;
+	uint32_t RESERVED_A_249;
+	uint32_t RESERVED_A_250;
+	uint32_t RESERVED_A_251;
+	uint32_t RESERVED_A_252;
+	uint32_t RESERVED_A_253;
+	uint32_t RESERVED_A_254;
+	uint32_t RESERVED_A_255;
+	uint32_t RESERVED_A_256;
+	uint32_t RESERVED_A_257;
+	uint32_t RESERVED_A_258;
+	uint32_t RESERVED_A_259;
+	uint32_t RESERVED_A_260;
+	uint32_t RESERVED_A_261;
+	uint32_t RESERVED_A_262;
+	uint32_t RESERVED_A_263;
+	uint32_t RESERVED_A_264;
+	uint32_t RESERVED_A_265;
+	uint32_t RESERVED_A_266;
+	uint32_t RESERVED_A_267;
+	uint32_t L1_VLATCH_AEXP_AVE4LINESY0;
+	uint32_t L1_VLATCH_AEXP_AVE4LINESY1;
+	uint32_t L1_VLATCH_AEXP_AVE4LINESY2;
+	uint32_t L1_VLATCH_AEXP_AVE4LINESY3;
+	uint32_t RESERVED_A_268;
+	uint32_t RESERVED_A_269;
+	uint32_t RESERVED_A_270;
+	uint32_t RESERVED_A_271;
+	uint32_t RESERVED_B_24[3];
+	uint32_t L1_VLATCH_IBUF_DEPTH;
+	uint32_t L1_VLATCH_IBUF_INPUT_ORDER;
+	uint32_t RESERVED_B_25[2];
+	uint32_t L1_VLATCH_SLIC_SrcBlackLevelGr;
+	uint32_t L1_VLATCH_SLIC_SrcBlackLevelR;
+	uint32_t L1_VLATCH_SLIC_SrcBlackLevelB;
+	uint32_t L1_VLATCH_SLIC_SrcBlackLevelGb;
+	uint32_t RESERVED_A_272;
+	uint32_t RESERVED_A_273;
+	uint32_t RESERVED_A_274;
+	uint32_t RESERVED_A_275;
+	uint32_t RESERVED_A_276;
+	uint32_t RESERVED_B_26[19];
+	uint32_t RESERVED_A_277;
+	uint32_t RESERVED_A_278;
+	uint32_t RESERVED_A_279;
+	uint32_t L1_VLATCH_ABPC012_STA_EN;
+	uint32_t L1_VLATCH_ABPC012_DYN_EN;
+	uint32_t L1_VLATCH_ABPC012_DYN_MODE;
+	uint32_t RESERVED_A_280;
+	uint32_t RESERVED_A_281;
+	uint32_t RESERVED_A_282;
+	uint32_t L1_VLATCH_ABPC0_RATIO_LIMIT;
+	uint32_t RESERVED_A_283;
+	uint32_t L1_VLATCH_ABPC0_DARK_LIMIT;
+	uint32_t L1_VLATCH_ABPC0_SN_COEF_W_AG_MIN;
+	uint32_t L1_VLATCH_ABPC0_SN_COEF_W_AG_MID;
+	uint32_t L1_VLATCH_ABPC0_SN_COEF_W_AG_MAX;
+	uint32_t L1_VLATCH_ABPC0_SN_COEF_W_TH_MIN;
+	uint32_t L1_VLATCH_ABPC0_SN_COEF_W_TH_MAX;
+	uint32_t L1_VLATCH_ABPC0_SN_COEF_B_AG_MIN;
+	uint32_t L1_VLATCH_ABPC0_SN_COEF_B_AG_MID;
+	uint32_t L1_VLATCH_ABPC0_SN_COEF_B_AG_MAX;
+	uint32_t L1_VLATCH_ABPC0_SN_COEF_B_TH_MIN;
+	uint32_t L1_VLATCH_ABPC0_SN_COEF_B_TH_MAX;
+	uint32_t RESERVED_A_284;
+	uint32_t RESERVED_A_285;
+	uint32_t L1_VLATCH_ABPC1_RATIO_LIMIT;
+	uint32_t RESERVED_A_286;
+	uint32_t L1_VLATCH_ABPC1_DARK_LIMIT;
+	uint32_t L1_VLATCH_ABPC1_SN_COEF_W_AG_MIN;
+	uint32_t L1_VLATCH_ABPC1_SN_COEF_W_AG_MID;
+	uint32_t L1_VLATCH_ABPC1_SN_COEF_W_AG_MAX;
+	uint32_t L1_VLATCH_ABPC1_SN_COEF_W_TH_MIN;
+	uint32_t L1_VLATCH_ABPC1_SN_COEF_W_TH_MAX;
+	uint32_t L1_VLATCH_ABPC1_SN_COEF_B_AG_MIN;
+	uint32_t L1_VLATCH_ABPC1_SN_COEF_B_AG_MID;
+	uint32_t L1_VLATCH_ABPC1_SN_COEF_B_AG_MAX;
+	uint32_t L1_VLATCH_ABPC1_SN_COEF_B_TH_MIN;
+	uint32_t L1_VLATCH_ABPC1_SN_COEF_B_TH_MAX;
+	uint32_t RESERVED_A_287;
+	uint32_t RESERVED_A_288;
+	uint32_t L1_VLATCH_ABPC2_RATIO_LIMIT;
+	uint32_t RESERVED_A_289;
+	uint32_t L1_VLATCH_ABPC2_DARK_LIMIT;
+	uint32_t L1_VLATCH_ABPC2_SN_COEF_W_AG_MIN;
+	uint32_t L1_VLATCH_ABPC2_SN_COEF_W_AG_MID;
+	uint32_t L1_VLATCH_ABPC2_SN_COEF_W_AG_MAX;
+	uint32_t L1_VLATCH_ABPC2_SN_COEF_W_TH_MIN;
+	uint32_t L1_VLATCH_ABPC2_SN_COEF_W_TH_MAX;
+	uint32_t L1_VLATCH_ABPC2_SN_COEF_B_AG_MIN;
+	uint32_t L1_VLATCH_ABPC2_SN_COEF_B_AG_MID;
+	uint32_t L1_VLATCH_ABPC2_SN_COEF_B_AG_MAX;
+	uint32_t L1_VLATCH_ABPC2_SN_COEF_B_TH_MIN;
+	uint32_t L1_VLATCH_ABPC2_SN_COEF_B_TH_MAX;
+	uint32_t RESERVED_A_290;
+	uint32_t RESERVED_A_291;
+	uint32_t RESERVED_B_27[42];
+	uint32_t RESERVED_A_292;
+	uint32_t L1_VLATCH_PWHB_HGr;
+	uint32_t L1_VLATCH_PWHB_HR;
+	uint32_t L1_VLATCH_PWHB_HB;
+	uint32_t L1_VLATCH_PWHB_HGb;
+	uint32_t L1_VLATCH_PWHB_MGr;
+	uint32_t L1_VLATCH_PWHB_MR;
+	uint32_t L1_VLATCH_PWHB_MB;
+	uint32_t L1_VLATCH_PWHB_MGb;
+	uint32_t L1_VLATCH_PWHB_LGr;
+	uint32_t L1_VLATCH_PWHB_LR;
+	uint32_t L1_VLATCH_PWHB_LB;
+	uint32_t L1_VLATCH_PWHB_LGb;
+	uint32_t L1_VLATCH_PWHB_DstMaxval;
+	uint32_t RESERVED_B_28[18];
+	uint32_t RESERVED_A_293;
+	uint32_t RESERVED_A_294;
+	uint32_t L1_VLATCH_RCNR0_SW;
+	uint32_t L1_VLATCH_RCNR0_CNF_DARK_AG0;
+	uint32_t L1_VLATCH_RCNR0_CNF_DARK_AG1;
+	uint32_t L1_VLATCH_RCNR0_CNF_DARK_AG2;
+	uint32_t L1_VLATCH_RCNR0_CNF_RATIO_AG0;
+	uint32_t L1_VLATCH_RCNR0_CNF_RATIO_AG1;
+	uint32_t L1_VLATCH_RCNR0_CNF_RATIO_AG2;
+	uint32_t L1_VLATCH_RCNR0_CNF_CLIP_GAIN_R;
+	uint32_t L1_VLATCH_RCNR0_CNF_CLIP_GAIN_G;
+	uint32_t L1_VLATCH_RCNR0_CNF_CLIP_GAIN_B;
+	uint32_t L1_VLATCH_RCNR0_A1L_DARK_AG0;
+	uint32_t L1_VLATCH_RCNR0_A1L_DARK_AG1;
+	uint32_t L1_VLATCH_RCNR0_A1L_DARK_AG2;
+	uint32_t L1_VLATCH_RCNR0_A1L_RATIO_AG0;
+	uint32_t L1_VLATCH_RCNR0_A1L_RATIO_AG1;
+	uint32_t L1_VLATCH_RCNR0_A1L_RATIO_AG2;
+	uint32_t L1_VLATCH_RCNR0_INF_ZERO_CLIP;
+	uint32_t RESERVED_A_295;
+	uint32_t L1_VLATCH_RCNR0_MERGE_D2BLEND_AG0;
+	uint32_t L1_VLATCH_RCNR0_MERGE_D2BLEND_AG1;
+	uint32_t L1_VLATCH_RCNR0_MERGE_D2BLEND_AG2;
+	uint32_t L1_VLATCH_RCNR0_MERGE_BLACK;
+	uint32_t L1_VLATCH_RCNR0_MERGE_MINDIV;
+	uint32_t L1_VLATCH_RCNR0_HRY_TYPE;
+	uint32_t L1_VLATCH_RCNR0_ANF_BLEND_AG0;
+	uint32_t L1_VLATCH_RCNR0_ANF_BLEND_AG1;
+	uint32_t L1_VLATCH_RCNR0_ANF_BLEND_AG2;
+	uint32_t RESERVED_A_296;
+	uint32_t L1_VLATCH_RCNR0_LPF_THRESHOLD;
+	uint32_t L1_VLATCH_RCNR0_MERGE_HLBLEND_AG0;
+	uint32_t L1_VLATCH_RCNR0_MERGE_HLBLEND_AG1;
+	uint32_t L1_VLATCH_RCNR0_MERGE_HLBLEND_AG2;
+	uint32_t L1_VLATCH_RCNR0_GNR_SW;
+	uint32_t L1_VLATCH_RCNR0_GNR_RATIO;
+	uint32_t L1_VLATCH_RCNR0_GNR_WIDE_EN;
+	uint32_t RESERVED_A_297;
+	uint32_t RESERVED_A_298;
+	uint32_t L1_VLATCH_RCNR1_SW;
+	uint32_t L1_VLATCH_RCNR1_CNF_DARK_AG0;
+	uint32_t L1_VLATCH_RCNR1_CNF_DARK_AG1;
+	uint32_t L1_VLATCH_RCNR1_CNF_DARK_AG2;
+	uint32_t L1_VLATCH_RCNR1_CNF_RATIO_AG0;
+	uint32_t L1_VLATCH_RCNR1_CNF_RATIO_AG1;
+	uint32_t L1_VLATCH_RCNR1_CNF_RATIO_AG2;
+	uint32_t L1_VLATCH_RCNR1_CNF_CLIP_GAIN_R;
+	uint32_t L1_VLATCH_RCNR1_CNF_CLIP_GAIN_G;
+	uint32_t L1_VLATCH_RCNR1_CNF_CLIP_GAIN_B;
+	uint32_t L1_VLATCH_RCNR1_A1L_DARK_AG0;
+	uint32_t L1_VLATCH_RCNR1_A1L_DARK_AG1;
+	uint32_t L1_VLATCH_RCNR1_A1L_DARK_AG2;
+	uint32_t L1_VLATCH_RCNR1_A1L_RATIO_AG0;
+	uint32_t L1_VLATCH_RCNR1_A1L_RATIO_AG1;
+	uint32_t L1_VLATCH_RCNR1_A1L_RATIO_AG2;
+	uint32_t L1_VLATCH_RCNR1_INF_ZERO_CLIP;
+	uint32_t RESERVED_A_299;
+	uint32_t L1_VLATCH_RCNR1_MERGE_D2BLEND_AG0;
+	uint32_t L1_VLATCH_RCNR1_MERGE_D2BLEND_AG1;
+	uint32_t L1_VLATCH_RCNR1_MERGE_D2BLEND_AG2;
+	uint32_t L1_VLATCH_RCNR1_MERGE_BLACK;
+	uint32_t L1_VLATCH_RCNR1_MERGE_MINDIV;
+	uint32_t L1_VLATCH_RCNR1_HRY_TYPE;
+	uint32_t L1_VLATCH_RCNR1_ANF_BLEND_AG0;
+	uint32_t L1_VLATCH_RCNR1_ANF_BLEND_AG1;
+	uint32_t L1_VLATCH_RCNR1_ANF_BLEND_AG2;
+	uint32_t RESERVED_A_300;
+	uint32_t L1_VLATCH_RCNR1_LPF_THRESHOLD;
+	uint32_t L1_VLATCH_RCNR1_MERGE_HLBLEND_AG0;
+	uint32_t L1_VLATCH_RCNR1_MERGE_HLBLEND_AG1;
+	uint32_t L1_VLATCH_RCNR1_MERGE_HLBLEND_AG2;
+	uint32_t L1_VLATCH_RCNR1_GNR_SW;
+	uint32_t L1_VLATCH_RCNR1_GNR_RATIO;
+	uint32_t L1_VLATCH_RCNR1_GNR_WIDE_EN;
+	uint32_t RESERVED_A_301;
+	uint32_t RESERVED_A_302;
+	uint32_t L1_VLATCH_RCNR2_SW;
+	uint32_t L1_VLATCH_RCNR2_CNF_DARK_AG0;
+	uint32_t L1_VLATCH_RCNR2_CNF_DARK_AG1;
+	uint32_t L1_VLATCH_RCNR2_CNF_DARK_AG2;
+	uint32_t L1_VLATCH_RCNR2_CNF_RATIO_AG0;
+	uint32_t L1_VLATCH_RCNR2_CNF_RATIO_AG1;
+	uint32_t L1_VLATCH_RCNR2_CNF_RATIO_AG2;
+	uint32_t L1_VLATCH_RCNR2_CNF_CLIP_GAIN_R;
+	uint32_t L1_VLATCH_RCNR2_CNF_CLIP_GAIN_G;
+	uint32_t L1_VLATCH_RCNR2_CNF_CLIP_GAIN_B;
+	uint32_t L1_VLATCH_RCNR2_A1L_DARK_AG0;
+	uint32_t L1_VLATCH_RCNR2_A1L_DARK_AG1;
+	uint32_t L1_VLATCH_RCNR2_A1L_DARK_AG2;
+	uint32_t L1_VLATCH_RCNR2_A1L_RATIO_AG0;
+	uint32_t L1_VLATCH_RCNR2_A1L_RATIO_AG1;
+	uint32_t L1_VLATCH_RCNR2_A1L_RATIO_AG2;
+	uint32_t L1_VLATCH_RCNR2_INF_ZERO_CLIP;
+	uint32_t RESERVED_A_303;
+	uint32_t L1_VLATCH_RCNR2_MERGE_D2BLEND_AG0;
+	uint32_t L1_VLATCH_RCNR2_MERGE_D2BLEND_AG1;
+	uint32_t L1_VLATCH_RCNR2_MERGE_D2BLEND_AG2;
+	uint32_t L1_VLATCH_RCNR2_MERGE_BLACK;
+	uint32_t L1_VLATCH_RCNR2_MERGE_MINDIV;
+	uint32_t L1_VLATCH_RCNR2_HRY_TYPE;
+	uint32_t L1_VLATCH_RCNR2_ANF_BLEND_AG0;
+	uint32_t L1_VLATCH_RCNR2_ANF_BLEND_AG1;
+	uint32_t L1_VLATCH_RCNR2_ANF_BLEND_AG2;
+	uint32_t RESERVED_A_304;
+	uint32_t L1_VLATCH_RCNR2_LPF_THRESHOLD;
+	uint32_t L1_VLATCH_RCNR2_MERGE_HLBLEND_AG0;
+	uint32_t L1_VLATCH_RCNR2_MERGE_HLBLEND_AG1;
+	uint32_t L1_VLATCH_RCNR2_MERGE_HLBLEND_AG2;
+	uint32_t L1_VLATCH_RCNR2_GNR_SW;
+	uint32_t L1_VLATCH_RCNR2_GNR_RATIO;
+	uint32_t L1_VLATCH_RCNR2_GNR_WIDE_EN;
+	uint32_t RESERVED_B_29[49];
+	uint32_t RESERVED_A_305;
+	uint32_t L1_VLATCH_HDRS_HdrRatioM;
+	uint32_t L1_VLATCH_HDRS_HdrRatioL;
+	uint32_t L1_VLATCH_HDRS_HdrRatioE;
+	uint32_t RESERVED_A_306;
+	uint32_t RESERVED_A_307;
+	uint32_t L1_VLATCH_HDRS_BlendEndH;
+	uint32_t L1_VLATCH_HDRS_BlendEndM;
+	uint32_t L1_VLATCH_HDRS_BlendEndE;
+	uint32_t L1_VLATCH_HDRS_BlendBegH;
+	uint32_t L1_VLATCH_HDRS_BlendBegM;
+	uint32_t L1_VLATCH_HDRS_BlendBegE;
+	uint32_t RESERVED_A_308;
+	uint32_t RESERVED_A_309;
+	uint32_t RESERVED_A_310;
+	uint32_t RESERVED_A_311;
+	uint32_t RESERVED_A_312;
+	uint32_t RESERVED_A_313;
+	uint32_t L1_VLATCH_HDRS_DgH;
+	uint32_t L1_VLATCH_HDRS_DgM;
+	uint32_t L1_VLATCH_HDRS_DgL;
+	uint32_t L1_VLATCH_HDRS_DgE;
+	uint32_t L1_VLATCH_HDRS_LedModeOn;
+	uint32_t L1_VLATCH_HDRS_HdrMode;
+	uint32_t RESERVED_A_314;
+	uint32_t RESERVED_A_315;
+	uint32_t RESERVED_A_316;
+	uint32_t L1_VLATCH_HDRS_DstMaxval;
+	uint32_t RESERVED_B_30[4];
+	uint32_t L1_VLATCH_BLVC_SrcBlackLevelGr;
+	uint32_t L1_VLATCH_BLVC_SrcBlackLevelR;
+	uint32_t L1_VLATCH_BLVC_SrcBlackLevelB;
+	uint32_t L1_VLATCH_BLVC_SrcBlackLevelGb;
+	uint32_t L1_VLATCH_BLVC_MultValGr;
+	uint32_t L1_VLATCH_BLVC_MultValR;
+	uint32_t L1_VLATCH_BLVC_MultValB;
+	uint32_t L1_VLATCH_BLVC_MultValGb;
+	uint32_t L1_VLATCH_BLVC_DstMaxval;
+	uint32_t RESERVED_A_317;
+	uint32_t RESERVED_A_318;
+	uint32_t RESERVED_A_319;
+	uint32_t RESERVED_A_320;
+	uint32_t RESERVED_A_321;
+	uint32_t RESERVED_A_322;
+	uint32_t RESERVED_B_31[17];
+	uint32_t L1_VLATCH_LSSC_EN;
+	uint32_t RESERVED_A_323;
+	uint32_t RESERVED_A_324;
+	uint32_t RESERVED_A_325;
+	uint32_t L1_VLATCH_LSSC_PWHB_R_GAIN;
+	uint32_t L1_VLATCH_LSSC_PWHB_GR_GAIN;
+	uint32_t L1_VLATCH_LSSC_PWHB_GB_GAIN;
+	uint32_t L1_VLATCH_LSSC_PWHB_B_GAIN;
+	uint32_t L1_VLATCH_LSSC_PARA_EN;
+	uint32_t L1_VLATCH_LSSC_PARA_H_CENTER;
+	uint32_t L1_VLATCH_LSSC_PARA_V_CENTER;
+	uint32_t L1_VLATCH_LSSC_PARA_H_GAIN;
+	uint32_t L1_VLATCH_LSSC_PARA_V_GAIN;
+	uint32_t L1_VLATCH_LSSC_PARA_MGSEL2;
+	uint32_t L1_VLATCH_LSSC_PARA_MGSEL4;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_2D_H_L;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_2D_H_R;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_2D_V_U;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_2D_V_D;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_2D_HV_LU;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_2D_HV_RU;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_2D_HV_LD;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_2D_HV_RD;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_4D_H_L;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_4D_H_R;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_4D_V_U;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_4D_V_D;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_4D_HV_LU;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_4D_HV_RU;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_4D_HV_LD;
+	uint32_t L1_VLATCH_LSSC_PARA_R_COEF_4D_HV_RD;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_2D_H_L;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_2D_H_R;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_2D_V_U;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_2D_V_D;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_2D_HV_LU;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_2D_HV_RU;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_2D_HV_LD;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_2D_HV_RD;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_4D_H_L;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_4D_H_R;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_4D_V_U;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_4D_V_D;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_4D_HV_LU;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_4D_HV_RU;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_4D_HV_LD;
+	uint32_t L1_VLATCH_LSSC_PARA_GR_COEF_4D_HV_RD;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_2D_H_L;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_2D_H_R;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_2D_V_U;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_2D_V_D;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_2D_HV_LU;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_2D_HV_RU;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_2D_HV_LD;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_2D_HV_RD;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_4D_H_L;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_4D_H_R;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_4D_V_U;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_4D_V_D;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_4D_HV_LU;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_4D_HV_RU;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_4D_HV_LD;
+	uint32_t L1_VLATCH_LSSC_PARA_GB_COEF_4D_HV_RD;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_2D_H_L;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_2D_H_R;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_2D_V_U;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_2D_V_D;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_2D_HV_LU;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_2D_HV_RU;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_2D_HV_LD;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_2D_HV_RD;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_4D_H_L;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_4D_H_R;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_4D_V_U;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_4D_V_D;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_4D_HV_LU;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_4D_HV_RU;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_4D_HV_LD;
+	uint32_t L1_VLATCH_LSSC_PARA_B_COEF_4D_HV_RD;
+	uint32_t L1_VLATCH_LSSC_GRID_EN;
+	uint32_t L1_VLATCH_LSSC_GRID_H_CENTER;
+	uint32_t L1_VLATCH_LSSC_GRID_V_CENTER;
+	uint32_t L1_VLATCH_LSSC_GRID_H_SIZE;
+	uint32_t L1_VLATCH_LSSC_GRID_V_SIZE;
+	uint32_t L1_VLATCH_LSSC_GRID_MGSEL;
+	uint32_t RESERVED_B_32[11];
+	uint32_t L1_VLATCH_MPRO_SW;
+	uint32_t L1_VLATCH_MPRO_CONF;
+	uint32_t RESERVED_A_326;
+	uint32_t L1_VLATCH_MPRO_DST_MINVAL;
+	uint32_t L1_VLATCH_MPRO_DST_MAXVAL;
+	uint32_t RESERVED_A_327;
+	uint32_t RESERVED_A_328;
+	uint32_t RESERVED_A_329;
+	uint32_t L1_VLATCH_MPRO_LM0_RMG_MIN;
+	uint32_t L1_VLATCH_MPRO_LM0_RMB_MIN;
+	uint32_t L1_VLATCH_MPRO_LM0_GMR_MIN;
+	uint32_t L1_VLATCH_MPRO_LM0_GMB_MIN;
+	uint32_t L1_VLATCH_MPRO_LM0_BMR_MIN;
+	uint32_t L1_VLATCH_MPRO_LM0_BMG_MIN;
+	uint32_t L1_VLATCH_MPRO_LM0_RMG_MAX;
+	uint32_t L1_VLATCH_MPRO_LM0_RMB_MAX;
+	uint32_t L1_VLATCH_MPRO_LM0_GMR_MAX;
+	uint32_t L1_VLATCH_MPRO_LM0_GMB_MAX;
+	uint32_t L1_VLATCH_MPRO_LM0_BMR_MAX;
+	uint32_t L1_VLATCH_MPRO_LM0_BMG_MAX;
+	uint32_t RESERVED_A_330;
+	uint32_t RESERVED_A_331;
+	uint32_t RESERVED_A_332;
+	uint32_t RESERVED_A_333;
+	uint32_t RESERVED_A_334;
+	uint32_t RESERVED_A_335;
+	uint32_t RESERVED_A_336;
+	uint32_t RESERVED_A_337;
+	uint32_t RESERVED_A_338;
+	uint32_t RESERVED_A_339;
+	uint32_t RESERVED_A_340;
+	uint32_t RESERVED_A_341;
+	uint32_t RESERVED_A_342;
+	uint32_t RESERVED_A_343;
+	uint32_t RESERVED_A_344;
+	uint32_t RESERVED_A_345;
+	uint32_t RESERVED_A_346;
+	uint32_t RESERVED_A_347;
+	uint32_t RESERVED_A_348;
+	uint32_t RESERVED_A_349;
+	uint32_t RESERVED_A_350;
+	uint32_t RESERVED_A_351;
+	uint32_t RESERVED_A_352;
+	uint32_t RESERVED_A_353;
+	uint32_t RESERVED_A_354;
+	uint32_t RESERVED_A_355;
+	uint32_t RESERVED_A_356;
+	uint32_t RESERVED_A_357;
+	uint32_t RESERVED_A_358;
+	uint32_t RESERVED_A_359;
+	uint32_t RESERVED_A_360;
+	uint32_t RESERVED_A_361;
+	uint32_t RESERVED_A_362;
+	uint32_t RESERVED_A_363;
+	uint32_t RESERVED_A_364;
+	uint32_t RESERVED_A_365;
+	uint32_t RESERVED_A_366;
+	uint32_t RESERVED_A_367;
+	uint32_t RESERVED_A_368;
+	uint32_t RESERVED_B_33[1];
+	uint32_t L1_VLATCH_MPRO_LCS_MODE;
+	uint32_t RESERVED_A_369;
+	uint32_t RESERVED_A_370;
+	uint32_t RESERVED_A_371;
+	uint32_t RESERVED_A_372;
+	uint32_t RESERVED_A_373;
+	uint32_t RESERVED_A_374;
+	uint32_t RESERVED_A_375;
+	uint32_t RESERVED_A_376;
+	uint32_t RESERVED_A_377;
+	uint32_t RESERVED_A_378;
+	uint32_t RESERVED_A_379;
+	uint32_t RESERVED_A_380;
+	uint32_t RESERVED_A_381;
+	uint32_t RESERVED_A_382;
+	uint32_t RESERVED_A_383;
+	uint32_t RESERVED_A_384;
+	uint32_t RESERVED_A_385;
+	uint32_t RESERVED_A_386;
+	uint32_t RESERVED_A_387;
+	uint32_t RESERVED_A_388;
+	uint32_t RESERVED_A_389;
+	uint32_t RESERVED_A_390;
+	uint32_t RESERVED_A_391;
+	uint32_t RESERVED_A_392;
+	uint32_t RESERVED_A_393;
+	uint32_t RESERVED_A_394;
+	uint32_t RESERVED_A_395;
+	uint32_t RESERVED_A_396;
+	uint32_t RESERVED_A_397;
+	uint32_t RESERVED_B_34[70];
+	uint32_t L1_VLATCH_VPRO_PGC_SW;
+	uint32_t RESERVED_A_398;
+	uint32_t L1_VLATCH_VPRO_YUVC_SW;
+	uint32_t L1_VLATCH_VPRO_YNR_SW;
+	uint32_t L1_VLATCH_VPRO_ETE_SW;
+	uint32_t L1_VLATCH_VPRO_CSUP_UVSUP_SW;
+	uint32_t L1_VLATCH_VPRO_CSUP_CORING_SW;
+	uint32_t L1_VLATCH_VPRO_BRIGHT_SW;
+	uint32_t L1_VLATCH_VPRO_LCNT_SW;
+	uint32_t L1_VLATCH_VPRO_NLCNT_SW;
+	uint32_t RESERVED_A_399;
+	uint32_t L1_VLATCH_VPRO_EDGE_SUP_SW;
+	uint32_t L1_VLATCH_VPRO_CNR_SW;
+	uint32_t RESERVED_A_400;
+	uint32_t L1_VLATCH_VPRO_BLKADJ;
+	uint32_t L1_VLATCH_VPRO_GAM01P;
+	uint32_t L1_VLATCH_VPRO_GAM02P;
+	uint32_t L1_VLATCH_VPRO_GAM03P;
+	uint32_t L1_VLATCH_VPRO_GAM04P;
+	uint32_t L1_VLATCH_VPRO_GAM05P;
+	uint32_t L1_VLATCH_VPRO_GAM06P;
+	uint32_t L1_VLATCH_VPRO_GAM07P;
+	uint32_t L1_VLATCH_VPRO_GAM08P;
+	uint32_t L1_VLATCH_VPRO_GAM09P;
+	uint32_t L1_VLATCH_VPRO_GAM10P;
+	uint32_t L1_VLATCH_VPRO_GAM11P;
+	uint32_t L1_VLATCH_VPRO_GAM12P;
+	uint32_t L1_VLATCH_VPRO_GAM13P;
+	uint32_t L1_VLATCH_VPRO_GAM14P;
+	uint32_t L1_VLATCH_VPRO_GAM15P;
+	uint32_t L1_VLATCH_VPRO_GAM16P;
+	uint32_t L1_VLATCH_VPRO_GAM17P;
+	uint32_t L1_VLATCH_VPRO_GAM18P;
+	uint32_t L1_VLATCH_VPRO_GAM19P;
+	uint32_t L1_VLATCH_VPRO_GAM20P;
+	uint32_t L1_VLATCH_VPRO_GAM21P;
+	uint32_t L1_VLATCH_VPRO_GAM22P;
+	uint32_t L1_VLATCH_VPRO_GAM23P;
+	uint32_t L1_VLATCH_VPRO_GAM24P;
+	uint32_t L1_VLATCH_VPRO_GAM25P;
+	uint32_t L1_VLATCH_VPRO_GAM26P;
+	uint32_t L1_VLATCH_VPRO_GAM27P;
+	uint32_t L1_VLATCH_VPRO_GAM28P;
+	uint32_t L1_VLATCH_VPRO_GAM29P;
+	uint32_t L1_VLATCH_VPRO_GAM30P;
+	uint32_t L1_VLATCH_VPRO_GAM31P;
+	uint32_t L1_VLATCH_VPRO_GAM32P;
+	uint32_t L1_VLATCH_VPRO_GAM33P;
+	uint32_t L1_VLATCH_VPRO_GAM34P;
+	uint32_t L1_VLATCH_VPRO_GAM35P;
+	uint32_t L1_VLATCH_VPRO_GAM36P;
+	uint32_t L1_VLATCH_VPRO_GAM37P;
+	uint32_t L1_VLATCH_VPRO_GAM38P;
+	uint32_t L1_VLATCH_VPRO_GAM39P;
+	uint32_t L1_VLATCH_VPRO_GAM40P;
+	uint32_t L1_VLATCH_VPRO_GAM41P;
+	uint32_t L1_VLATCH_VPRO_GAM42P;
+	uint32_t L1_VLATCH_VPRO_GAM43P;
+	uint32_t L1_VLATCH_VPRO_GAM44P;
+	uint32_t L1_VLATCH_VPRO_Cb_MAT;
+	uint32_t L1_VLATCH_VPRO_Cr_MAT;
+	uint32_t L1_VLATCH_VPRO_BRIGHT;
+	uint32_t L1_VLATCH_VPRO_LCONT_LEV;
+	uint32_t L1_VLATCH_VPRO_BLK_KNEE;
+	uint32_t L1_VLATCH_VPRO_WHT_KNEE;
+	uint32_t L1_VLATCH_VPRO_BLK_CONT0;
+	uint32_t L1_VLATCH_VPRO_BLK_CONT1;
+	uint32_t L1_VLATCH_VPRO_BLK_CONT2;
+	uint32_t L1_VLATCH_VPRO_WHT_CONT0;
+	uint32_t L1_VLATCH_VPRO_WHT_CONT1;
+	uint32_t L1_VLATCH_VPRO_WHT_CONT2;
+	uint32_t RESERVED_A_401;
+	uint32_t RESERVED_A_402;
+	uint32_t RESERVED_A_403;
+	uint32_t RESERVED_A_404;
+	uint32_t RESERVED_A_405;
+	uint32_t RESERVED_A_406;
+	uint32_t L1_VLATCH_VPRO_YNR_GAIN_MIN;
+	uint32_t L1_VLATCH_VPRO_YNR_GAIN_MAX;
+	uint32_t L1_VLATCH_VPRO_YNR_LIM_MIN;
+	uint32_t L1_VLATCH_VPRO_YNR_LIM_MAX;
+	uint32_t L1_VLATCH_VPRO_ETE_GAIN_MIN;
+	uint32_t L1_VLATCH_VPRO_ETE_GAIN_MAX;
+	uint32_t L1_VLATCH_VPRO_ETE_LIM_MIN;
+	uint32_t L1_VLATCH_VPRO_ETE_LIM_MAX;
+	uint32_t L1_VLATCH_VPRO_ETE_CORING_MIN;
+	uint32_t L1_VLATCH_VPRO_ETE_CORING_MAX;
+	uint32_t L1_VLATCH_VPRO_Cb_GAIN;
+	uint32_t L1_VLATCH_VPRO_Cr_GAIN;
+	uint32_t L1_VLATCH_VPRO_Cbr_MGAIN_MIN;
+	uint32_t L1_VLATCH_VPRO_CbP_GAIN_MAX;
+	uint32_t L1_VLATCH_VPRO_CbM_GAIN_MAX;
+	uint32_t L1_VLATCH_VPRO_CrP_GAIN_MAX;
+	uint32_t L1_VLATCH_VPRO_CrM_GAIN_MAX;
+	uint32_t L1_VLATCH_VPRO_CSUP_CORING_LV_MIN;
+	uint32_t L1_VLATCH_VPRO_CSUP_CORING_LV_MAX;
+	uint32_t L1_VLATCH_VPRO_CSUP_CORING_GAIN_MIN;
+	uint32_t L1_VLATCH_VPRO_CSUP_CORING_GAIN_MAX;
+	uint32_t L1_VLATCH_VPRO_CSUP_BK_SLV;
+	uint32_t L1_VLATCH_VPRO_CSUP_BK_MP;
+	uint32_t L1_VLATCH_VPRO_CSUP_BLACK;
+	uint32_t L1_VLATCH_VPRO_CSUP_WH_SLV;
+	uint32_t L1_VLATCH_VPRO_CSUP_WH_MP;
+	uint32_t L1_VLATCH_VPRO_CSUP_WHITE;
+	uint32_t L1_VLATCH_VPRO_EDGE_SUP_GAIN;
+	uint32_t L1_VLATCH_VPRO_EDGE_SUP_LIM;
+	uint32_t RESERVED_B_35[22];
+	uint32_t L1_VLATCH_AWHB_SW;
+	uint32_t RESERVED_A_407;
+	uint32_t L1_VLATCH_AWHB_WBMRG;
+	uint32_t L1_VLATCH_AWHB_WBMGG;
+	uint32_t L1_VLATCH_AWHB_WBMBG;
+	uint32_t L1_VLATCH_AWHB_GATE_CONF0;
+	uint32_t L1_VLATCH_AWHB_GATE_CONF1;
+	uint32_t L1_VLATCH_AWHB_AREA_HSIZE;
+	uint32_t L1_VLATCH_AWHB_AREA_VSIZE;
+	uint32_t L1_VLATCH_AWHB_AREA_HOFS;
+	uint32_t L1_VLATCH_AWHB_AREA_VOFS;
+	uint32_t L1_VLATCH_AWHB_AREA_MASKH;
+	uint32_t L1_VLATCH_AWHB_AREA_MASKL;
+	uint32_t L1_VLATCH_AWHB_SQ_CONF;
+	uint32_t L1_VLATCH_AWHB_YGATEH;
+	uint32_t L1_VLATCH_AWHB_YGATEL;
+	uint32_t RESERVED_A_408;
+	uint32_t RESERVED_A_409;
+	uint32_t L1_VLATCH_AWHB_BYCUT0P;
+	uint32_t L1_VLATCH_AWHB_BYCUT0N;
+	uint32_t L1_VLATCH_AWHB_RYCUT0P;
+	uint32_t L1_VLATCH_AWHB_RYCUT0N;
+	uint32_t L1_VLATCH_AWHB_RBCUT0H;
+	uint32_t L1_VLATCH_AWHB_RBCUT0L;
+	uint32_t RESERVED_A_410;
+	uint32_t RESERVED_A_411;
+	uint32_t RESERVED_A_412;
+	uint32_t RESERVED_A_413;
+	uint32_t RESERVED_A_414;
+	uint32_t RESERVED_A_415;
+	uint32_t L1_VLATCH_AWHB_BYCUT1H;
+	uint32_t L1_VLATCH_AWHB_BYCUT1L;
+	uint32_t L1_VLATCH_AWHB_RYCUT1H;
+	uint32_t L1_VLATCH_AWHB_RYCUT1L;
+	uint32_t L1_VLATCH_AWHB_BYCUT2H;
+	uint32_t L1_VLATCH_AWHB_BYCUT2L;
+	uint32_t L1_VLATCH_AWHB_RYCUT2H;
+	uint32_t L1_VLATCH_AWHB_RYCUT2L;
+	uint32_t L1_VLATCH_AWHB_BYCUT3H;
+	uint32_t L1_VLATCH_AWHB_BYCUT3L;
+	uint32_t L1_VLATCH_AWHB_RYCUT3H;
+	uint32_t L1_VLATCH_AWHB_RYCUT3L;
+	uint32_t L1_VLATCH_AWHB_AWBSFTU;
+	uint32_t L1_VLATCH_AWHB_AWBSFTV;
+	uint32_t L1_VLATCH_AWHB_AWBSPD;
+	uint32_t L1_VLATCH_AWHB_AWBULV;
+	uint32_t L1_VLATCH_AWHB_AWBVLV;
+	uint32_t L1_VLATCH_AWHB_AWBWAIT;
+	uint32_t L1_VLATCH_AWHB_AWBONDOT;
+	uint32_t L1_VLATCH_AWHB_AWBFZTIM;
+	uint32_t L1_VLATCH_AWHB_WBGRMAX;
+	uint32_t L1_VLATCH_AWHB_WBGRMIN;
+	uint32_t L1_VLATCH_AWHB_WBGBMAX;
+	uint32_t L1_VLATCH_AWHB_WBGBMIN;
+	uint32_t RESERVED_A_416;
+	uint32_t RESERVED_A_417;
+	uint32_t RESERVED_A_418;
+	uint32_t RESERVED_A_419;
+	uint32_t RESERVED_A_420;
+	uint32_t RESERVED_A_421;
+	uint32_t RESERVED_A_422;
+	uint32_t RESERVED_A_423;
+	uint32_t RESERVED_A_424;
+	uint32_t RESERVED_A_425;
+	uint32_t RESERVED_A_426;
+	uint32_t RESERVED_A_427;
+	uint32_t RESERVED_A_428;
+	uint32_t RESERVED_A_429;
+	uint32_t RESERVED_A_430;
+	uint32_t RESERVED_A_431;
+	uint32_t RESERVED_A_432;
+	uint32_t RESERVED_A_433;
+	uint32_t RESERVED_A_434;
+	uint32_t RESERVED_A_435;
+	uint32_t RESERVED_A_436;
+	uint32_t RESERVED_A_437;
+	uint32_t RESERVED_A_438;
+	uint32_t RESERVED_A_439;
+	uint32_t RESERVED_B_36[2];
+	uint32_t L1_VLATCH_HOBC_EN;
+	uint32_t L1_VLATCH_HOBC_MARGIN;
+	uint32_t RESERVED_A_440;
+	uint32_t RESERVED_A_441;
+	uint32_t L1_VLATCH_HOBC0_LOB_REFLV_GR;
+	uint32_t L1_VLATCH_HOBC0_LOB_WIDTH_GR;
+	uint32_t L1_VLATCH_HOBC0_LOB_REFLV_R;
+	uint32_t L1_VLATCH_HOBC0_LOB_WIDTH_R;
+	uint32_t L1_VLATCH_HOBC0_LOB_REFLV_B;
+	uint32_t L1_VLATCH_HOBC0_LOB_WIDTH_B;
+	uint32_t L1_VLATCH_HOBC0_LOB_REFLV_GB;
+	uint32_t L1_VLATCH_HOBC0_LOB_WIDTH_GB;
+	uint32_t L1_VLATCH_HOBC1_LOB_REFLV_GR;
+	uint32_t L1_VLATCH_HOBC1_LOB_WIDTH_GR;
+	uint32_t L1_VLATCH_HOBC1_LOB_REFLV_R;
+	uint32_t L1_VLATCH_HOBC1_LOB_WIDTH_R;
+	uint32_t L1_VLATCH_HOBC1_LOB_REFLV_B;
+	uint32_t L1_VLATCH_HOBC1_LOB_WIDTH_B;
+	uint32_t L1_VLATCH_HOBC1_LOB_REFLV_GB;
+	uint32_t L1_VLATCH_HOBC1_LOB_WIDTH_GB;
+	uint32_t L1_VLATCH_HOBC2_LOB_REFLV_GR;
+	uint32_t L1_VLATCH_HOBC2_LOB_WIDTH_GR;
+	uint32_t L1_VLATCH_HOBC2_LOB_REFLV_R;
+	uint32_t L1_VLATCH_HOBC2_LOB_WIDTH_R;
+	uint32_t L1_VLATCH_HOBC2_LOB_REFLV_B;
+	uint32_t L1_VLATCH_HOBC2_LOB_WIDTH_B;
+	uint32_t L1_VLATCH_HOBC2_LOB_REFLV_GB;
+	uint32_t L1_VLATCH_HOBC2_LOB_WIDTH_GB;
+	uint32_t L1_VLATCH_HOBC0_SRC_BLKLV_GR;
+	uint32_t L1_VLATCH_HOBC0_SRC_BLKLV_R;
+	uint32_t L1_VLATCH_HOBC0_SRC_BLKLV_B;
+	uint32_t L1_VLATCH_HOBC0_SRC_BLKLV_GB;
+	uint32_t L1_VLATCH_HOBC1_SRC_BLKLV_GR;
+	uint32_t L1_VLATCH_HOBC1_SRC_BLKLV_R;
+	uint32_t L1_VLATCH_HOBC1_SRC_BLKLV_B;
+	uint32_t L1_VLATCH_HOBC1_SRC_BLKLV_GB;
+	uint32_t L1_VLATCH_HOBC2_SRC_BLKLV_GR;
+	uint32_t L1_VLATCH_HOBC2_SRC_BLKLV_R;
+	uint32_t L1_VLATCH_HOBC2_SRC_BLKLV_B;
+	uint32_t L1_VLATCH_HOBC2_SRC_BLKLV_GB;
+	uint32_t RESERVED_A_442;
+	uint32_t RESERVED_A_443;
+	uint32_t RESERVED_A_444;
+	uint32_t RESERVED_A_445;
+	uint32_t RESERVED_A_446;
+	uint32_t RESERVED_A_447;
+	uint32_t L1_VLATCH_HOBC_MAX_VAL;
+	uint32_t RESERVED_B_37[33];
+	uint32_t L1_VLATCH_HDRC_EN;
+	uint32_t L1_VLATCH_HDRC_THR_SFT_AMT;
+	uint32_t RESERVED_A_448;
+	uint32_t L1_VLATCH_HDRC_RATIO;
+	uint32_t RESERVED_A_449;
+	uint32_t RESERVED_A_450;
+	uint32_t RESERVED_A_451;
+	uint32_t L1_VLATCH_HDRC_PT_RATIO;
+	uint32_t L1_VLATCH_HDRC_PT_BLEND;
+	uint32_t L1_VLATCH_HDRC_PT_BLEND2;
+	uint32_t L1_VLATCH_HDRC_PT_SAT;
+	uint32_t L1_VLATCH_HDRC_TN_TYPE;
+	uint32_t L1_VLATCH_HDRC_TNP_MAX;
+	uint32_t L1_VLATCH_HDRC_TNP_MAG;
+	uint32_t RESERVED_A_452;
+	uint32_t RESERVED_A_453;
+	uint32_t RESERVED_A_454;
+	uint32_t RESERVED_A_455;
+	uint32_t L1_VLATCH_HDRC_TNP_FIL0;
+	uint32_t L1_VLATCH_HDRC_TNP_FIL1;
+	uint32_t L1_VLATCH_HDRC_TNP_FIL2;
+	uint32_t L1_VLATCH_HDRC_TNP_FIL3;
+	uint32_t L1_VLATCH_HDRC_TNP_FIL4;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL0;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL1;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL2;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL3;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL4;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL5;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL6;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL7;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL8;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL9;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL10;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL11;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL12;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL13;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL14;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL15;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL16;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL17;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL18;
+	uint32_t L1_VLATCH_HDRC_UTN_TBL19;
+	uint32_t L1_VLATCH_HDRC_FLR_VAL;
+	uint32_t L1_VLATCH_HDRC_FLR_ADP;
+	uint32_t RESERVED_A_456;
+	uint32_t RESERVED_A_457;
+	uint32_t RESERVED_A_458;
+	uint32_t RESERVED_A_459;
+	uint32_t RESERVED_A_460;
+	uint32_t RESERVED_A_461;
+	uint32_t RESERVED_A_462;
+	uint32_t RESERVED_A_463;
+	uint32_t RESERVED_A_464;
+	uint32_t RESERVED_A_465;
+	uint32_t RESERVED_A_466;
+	uint32_t RESERVED_A_467;
+	uint32_t RESERVED_A_468;
+	uint32_t RESERVED_A_469;
+	uint32_t L1_VLATCH_HDRC_YBR_OFF;
+	uint32_t L1_VLATCH_HDRC_ORGY_BLEND;
+	uint32_t RESERVED_A_470;
+	uint32_t RESERVED_A_471;
+	uint32_t RESERVED_A_472;
+	uint32_t L1_VLATCH_HDRC_MAR_TOP;
+	uint32_t L1_VLATCH_HDRC_MAR_LEFT;
+	uint32_t RESERVED_A_473;
+	uint32_t RESERVED_A_474;
+	uint32_t RESERVED_B_38[28];
+	uint32_t L1_VLATCH_HIST_EN;
+	uint32_t L1_VLATCH_HIST_MODE;
+	uint32_t L1_VLATCH_HIST_BLOCK_OFST;
+	uint32_t L1_VLATCH_HIST_BLOCK_SIZE;
+	uint32_t L1_VLATCH_HIST_BLOCK_NUM;
+	uint32_t L1_VLATCH_HIST_BLOCK_STEP;
+	uint32_t L1_VLATCH_HIST_LINEAR_SFT;
+	uint32_t L1_VLATCH_HIST_MULT_A_R;
+	uint32_t L1_VLATCH_HIST_ADD_A_R;
+	uint32_t L1_VLATCH_HIST_MULT_B_R;
+	uint32_t L1_VLATCH_HIST_ADD_B_R;
+	uint32_t L1_VLATCH_HIST_MULT_A_G;
+	uint32_t L1_VLATCH_HIST_ADD_A_G;
+	uint32_t L1_VLATCH_HIST_MULT_B_G;
+	uint32_t L1_VLATCH_HIST_ADD_B_G;
+	uint32_t L1_VLATCH_HIST_MULT_A_B;
+	uint32_t L1_VLATCH_HIST_ADD_A_B;
+	uint32_t L1_VLATCH_HIST_MULT_B_B;
+	uint32_t L1_VLATCH_HIST_ADD_B_B;
+	uint32_t L1_VLATCH_HIST_MULT_A_Y;
+	uint32_t L1_VLATCH_HIST_ADD_A_Y;
+	uint32_t L1_VLATCH_HIST_MULT_B_Y;
+	uint32_t L1_VLATCH_HIST_ADD_B_Y;
+	uint32_t RESERVED_B_39[265];
+};
+
+/**
+ * struct hwd_viif_l2isp_stadr_buf_reg - Registers for L2ISP control
+ */
+struct hwd_viif_l2isp_stadr_buf_reg {
+	uint32_t L2_POST_OUT_STADR_B_BUF;
+	uint32_t L2_POST_OUT_STADR_G_BUF;
+	uint32_t L2_POST_OUT_STADR_R_BUF;
+};
+
+struct hwd_viif_l2isp_roi_reg {
+	uint32_t L2_ROI_SCALE;
+	uint32_t L2_ROI_SCALE_INV;
+	uint32_t L2_ROI_CORRECTED_HSIZE;
+	uint32_t L2_ROI_CORRECTED_VSIZE;
+	uint32_t L2_ROI_OUT_OFS_H;
+	uint32_t L2_ROI_OUT_OFS_V;
+	uint32_t L2_ROI_OUT_HSIZE;
+	uint32_t L2_ROI_OUT_VSIZE;
+};
+
+struct hwd_viif_l2isp_post_reg {
+	uint32_t L2_POST_CAP_OFFSET;
+	uint32_t L2_POST_CAP_SIZE;
+	uint32_t L2_POST_HALF_SCALE_EN;
+	uint32_t RESERVED_B_47[17];
+	uint32_t L2_POST_GAMMA_M;
+	uint32_t RESERVED_B_48[3];
+	uint32_t L2_POST_C_SELECT;
+	uint32_t RESERVED_B_49[3];
+	struct hwd_viif_csc_reg csc;
+	uint32_t L2_POST_OPORTALP;
+	uint32_t L2_POST_OPORTFMT;
+	uint32_t L2_POST_OUT_STADR_B;
+	uint32_t L2_POST_OUT_STADR_G;
+	uint32_t L2_POST_OUT_STADR_R;
+	uint32_t L2_POST_OUT_PITCH_B;
+	uint32_t L2_POST_OUT_PITCH_G;
+	uint32_t L2_POST_OUT_PITCH_R;
+	uint32_t L2_POST_DUMMY_READ_EN;
+	uint32_t RESERVED_B_51[11];
+};
+
+struct hwd_viif_l2isp_reg {
+	uint32_t L2_SENSOR_CROP_OFS_H;
+	uint32_t L2_SENSOR_CROP_OFS_V;
+	uint32_t L2_SENSOR_CROP_HSIZE;
+	uint32_t L2_SENSOR_CROP_VSIZE;
+	uint32_t RESERVED_A_475;
+	uint32_t L2_L2_STATUS;
+	uint32_t L2_BUS_L2_STATUS;
+	/* [0]: POST0, [1]: POST1 */
+	struct hwd_viif_l2isp_stadr_buf_reg stadr_buf[2];
+	uint32_t RESERVED_B_40[3];
+	uint32_t L2_ROI_NUM;
+	/* [0]: POST0, [1]: POST1 */
+	uint32_t L2_ROI_TO_POST[2];
+	uint32_t RESERVED_B_41;
+	/* [0]: ROI0, [1]: ROI1 */
+	struct hwd_viif_l2isp_roi_reg roi[2];
+	uint32_t RESERVED_B_42[8];
+	uint32_t L2_VALID_R_NORM2_POLY;
+	uint32_t L2_VALID_R_NORM2_GRID;
+	uint32_t RESERVED_A_476;
+	uint32_t RESERVED_B_43[17];
+	uint32_t L2_MODE;
+	uint32_t L2_NORM_SCALE;
+	uint32_t RESERVED_B_44;
+	/* [0]: ROI0, [1]: ROI1 */
+	uint32_t L2_ROI_WRITE_AREA_DELTA[2];
+	uint32_t RESERVED_B_45;
+	uint32_t L2_GRID_NODE_NUM_H;
+	uint32_t L2_GRID_NODE_NUM_V;
+	uint32_t L2_GRID_PATCH_HSIZE_INV;
+	uint32_t L2_GRID_PATCH_VSIZE_INV;
+	uint32_t L2_POLY10_WRITE_G_COEF[11];
+	uint32_t L2_POLY10_READ_B_COEF[11];
+	uint32_t L2_POLY10_READ_G_COEF[11];
+	uint32_t L2_POLY10_READ_R_COEF[11];
+	uint32_t RESERVED_B_46[10];
+	/* [0]: POST0, [1]: POST1 */
+	struct hwd_viif_l2isp_post_reg post[2];
+	uint32_t RESERVED_B_56[192];
+	uint32_t L2_CRGBF_ACC_CONF;
+	uint32_t L2_CRGBF_TRN_M_RUN;
+	uint32_t L2_CRGBF_TRN_M_CONF;
+	uint32_t L2_CRGBF_TRN_A_CONF;
+	uint32_t L2_CRGBF_TRN_STAT_CLR;
+	uint32_t L2_CRGBF_TRN_STAT;
+	uint32_t L2_CRGBF_INT_STAT;
+	uint32_t L2_CRGBF_INT_MASK;
+	uint32_t L2_CRGBF_INT_MASKED_STAT;
+	uint32_t L2_CRGBF_TRN_WBADDR;
+	uint32_t L2_CRGBF_TRN_WEADDR;
+	uint32_t L2_CRGBF_TRN_RBADDR;
+	uint32_t L2_CRGBF_TRN_READDR;
+	uint32_t L2_CRGBF_ISP_INT;
+	uint32_t L2_CRGBF_ISP_INT_MASK;
+	uint32_t L2_CRGBF_ISP_INT_MASKED_STAT;
+	uint32_t RESERVED_A_477;
+	uint32_t RESERVED_B_57[47];
+	uint32_t L2_SENSOR_CROP_OFS_H_BUF;
+	uint32_t L2_SENSOR_CROP_OFS_V_BUF;
+	uint32_t L2_SENSOR_CROP_HSIZE_BUF;
+	uint32_t L2_SENSOR_CROP_VSIZE_BUF;
+	uint32_t RESERVED_A_478;
+	uint32_t RESERVED_B_58[11];
+	uint32_t L2_ROI_NUM_BUF;
+	uint32_t L2_ROI_TO_POST0_BUF;
+	uint32_t L2_ROI_TO_POST1_BUF;
+	uint32_t RESERVED_B_59;
+	uint32_t L2_ROI0_SCALE_BUF;
+	uint32_t L2_ROI0_SCALE_INV_BUF;
+	uint32_t L2_ROI0_CORRECTED_HSIZE_BUF;
+	uint32_t L2_ROI0_CORRECTED_VSIZE_BUF;
+	uint32_t L2_ROI0_OUT_OFS_H_BUF;
+	uint32_t L2_ROI0_OUT_OFS_V_BUF;
+	uint32_t L2_ROI0_OUT_HSIZE_BUF;
+	uint32_t L2_ROI0_OUT_VSIZE_BUF;
+	uint32_t L2_ROI1_SCALE_BUF;
+	uint32_t L2_ROI1_SCALE_INV_BUF;
+	uint32_t L2_ROI1_CORRECTED_HSIZE_BUF;
+	uint32_t L2_ROI1_CORRECTED_VSIZE_BUF;
+	uint32_t L2_ROI1_OUT_OFS_H_BUF;
+	uint32_t L2_ROI1_OUT_OFS_V_BUF;
+	uint32_t L2_ROI1_OUT_HSIZE_BUF;
+	uint32_t L2_ROI1_OUT_VSIZE_BUF;
+	uint32_t RESERVED_B_60[8];
+	uint32_t L2_VALID_R_NORM2_POLY_BUF;
+	uint32_t L2_VALID_R_NORM2_GRID_BUF;
+	uint32_t RESERVED_A_479;
+	uint32_t RESERVED_B_61[17];
+	uint32_t L2_MODE_BUF;
+	uint32_t L2_NORM_SCALE_BUF;
+	uint32_t RESERVED_B_62;
+	uint32_t L2_ROI0_WRITE_AREA_DELTA_BUF;
+	uint32_t L2_ROI1_WRITE_AREA_DELTA_BUF;
+	uint32_t RESERVED_B_63;
+	uint32_t L2_GRID_NODE_NUM_H_BUF;
+	uint32_t L2_GRID_NODE_NUM_V_BUF;
+	uint32_t L2_GRID_PATCH_HSIZE_INV_BUF;
+	uint32_t L2_GRID_PATCH_VSIZE_INV_BUF;
+	uint32_t L2_POLY10_WRITE_G_COEF00_BUF;
+	uint32_t L2_POLY10_WRITE_G_COEF01_BUF;
+	uint32_t L2_POLY10_WRITE_G_COEF02_BUF;
+	uint32_t L2_POLY10_WRITE_G_COEF03_BUF;
+	uint32_t L2_POLY10_WRITE_G_COEF04_BUF;
+	uint32_t L2_POLY10_WRITE_G_COEF05_BUF;
+	uint32_t L2_POLY10_WRITE_G_COEF06_BUF;
+	uint32_t L2_POLY10_WRITE_G_COEF07_BUF;
+	uint32_t L2_POLY10_WRITE_G_COEF08_BUF;
+	uint32_t L2_POLY10_WRITE_G_COEF09_BUF;
+	uint32_t L2_POLY10_WRITE_G_COEF10_BUF;
+	uint32_t L2_POLY10_READ_B_COEF00_BUF;
+	uint32_t L2_POLY10_READ_B_COEF01_BUF;
+	uint32_t L2_POLY10_READ_B_COEF02_BUF;
+	uint32_t L2_POLY10_READ_B_COEF03_BUF;
+	uint32_t L2_POLY10_READ_B_COEF04_BUF;
+	uint32_t L2_POLY10_READ_B_COEF05_BUF;
+	uint32_t L2_POLY10_READ_B_COEF06_BUF;
+	uint32_t L2_POLY10_READ_B_COEF07_BUF;
+	uint32_t L2_POLY10_READ_B_COEF08_BUF;
+	uint32_t L2_POLY10_READ_B_COEF09_BUF;
+	uint32_t L2_POLY10_READ_B_COEF10_BUF;
+	uint32_t L2_POLY10_READ_G_COEF00_BUF;
+	uint32_t L2_POLY10_READ_G_COEF01_BUF;
+	uint32_t L2_POLY10_READ_G_COEF02_BUF;
+	uint32_t L2_POLY10_READ_G_COEF03_BUF;
+	uint32_t L2_POLY10_READ_G_COEF04_BUF;
+	uint32_t L2_POLY10_READ_G_COEF05_BUF;
+	uint32_t L2_POLY10_READ_G_COEF06_BUF;
+	uint32_t L2_POLY10_READ_G_COEF07_BUF;
+	uint32_t L2_POLY10_READ_G_COEF08_BUF;
+	uint32_t L2_POLY10_READ_G_COEF09_BUF;
+	uint32_t L2_POLY10_READ_G_COEF10_BUF;
+	uint32_t L2_POLY10_READ_R_COEF00_BUF;
+	uint32_t L2_POLY10_READ_R_COEF01_BUF;
+	uint32_t L2_POLY10_READ_R_COEF02_BUF;
+	uint32_t L2_POLY10_READ_R_COEF03_BUF;
+	uint32_t L2_POLY10_READ_R_COEF04_BUF;
+	uint32_t L2_POLY10_READ_R_COEF05_BUF;
+	uint32_t L2_POLY10_READ_R_COEF06_BUF;
+	uint32_t L2_POLY10_READ_R_COEF07_BUF;
+	uint32_t L2_POLY10_READ_R_COEF08_BUF;
+	uint32_t L2_POLY10_READ_R_COEF09_BUF;
+	uint32_t L2_POLY10_READ_R_COEF10_BUF;
+	uint32_t RESERVED_B_64[10];
+	uint32_t L2_POST0_CAP_OFFSET_BUF;
+	uint32_t L2_POST0_CAP_SIZE_BUF;
+	uint32_t L2_POST0_HALF_SCALE_EN_BUF;
+	uint32_t RESERVED_B_65[17];
+	uint32_t L2_POST0_GAMMA_M_BUF;
+	uint32_t RESERVED_B_66[3];
+	uint32_t L2_POST0_C_SELECT_BUF;
+	uint32_t RESERVED_B_67[3];
+	uint32_t L2_POST0_MTB_BUF;
+	uint32_t RESERVED_B_68[3];
+	uint32_t L2_POST0_MTB_YG_OFFSETI_BUF;
+	uint32_t L2_POST0_MTB_YG1_BUF;
+	uint32_t L2_POST0_MTB_YG2_BUF;
+	uint32_t L2_POST0_MTB_YG_OFFSETO_BUF;
+	uint32_t L2_POST0_MTB_CB_OFFSETI_BUF;
+	uint32_t L2_POST0_MTB_CB1_BUF;
+	uint32_t L2_POST0_MTB_CB2_BUF;
+	uint32_t L2_POST0_MTB_CB_OFFSETO_BUF;
+	uint32_t L2_POST0_MTB_CR_OFFSETI_BUF;
+	uint32_t L2_POST0_MTB_CR1_BUF;
+	uint32_t L2_POST0_MTB_CR2_BUF;
+	uint32_t L2_POST0_MTB_CR_OFFSETO_BUF;
+	uint32_t L2_POST0_OPORTALP_BUF;
+	uint32_t L2_POST0_OPORTFMT_BUF;
+	uint32_t RESERVED_B_69[3];
+	uint32_t L2_POST0_OUT_PITCH_B_BUF;
+	uint32_t L2_POST0_OUT_PITCH_G_BUF;
+	uint32_t L2_POST0_OUT_PITCH_R_BUF;
+	uint32_t L2_POST0_DUMMY_READ_EN_BUF;
+	uint32_t RESERVED_B_70[11];
+	uint32_t L2_POST1_CAP_OFFSET_BUF;
+	uint32_t L2_POST1_CAP_SIZE_BUF;
+	uint32_t L2_POST1_HALF_SCALE_EN_BUF;
+	uint32_t RESERVED_B_71[17];
+	uint32_t L2_POST1_GAMMA_M_BUF;
+	uint32_t RESERVED_B_72[3];
+	uint32_t L2_POST1_C_SELECT_BUF;
+	uint32_t RESERVED_B_73[3];
+	uint32_t L2_POST1_MTB_BUF;
+	uint32_t RESERVED_B_74[3];
+	uint32_t L2_POST1_MTB_YG_OFFSETI_BUF;
+	uint32_t L2_POST1_MTB_YG1_BUF;
+	uint32_t L2_POST1_MTB_YG2_BUF;
+	uint32_t L2_POST1_MTB_YG_OFFSETO_BUF;
+	uint32_t L2_POST1_MTB_CB_OFFSETI_BUF;
+	uint32_t L2_POST1_MTB_CB1_BUF;
+	uint32_t L2_POST1_MTB_CB2_BUF;
+	uint32_t L2_POST1_MTB_CB_OFFSETO_BUF;
+	uint32_t L2_POST1_MTB_CR_OFFSETI_BUF;
+	uint32_t L2_POST1_MTB_CR1_BUF;
+	uint32_t L2_POST1_MTB_CR2_BUF;
+	uint32_t L2_POST1_MTB_CR_OFFSETO_BUF;
+	uint32_t L2_POST1_OPORTALP_BUF;
+	uint32_t L2_POST1_OPORTFMT_BUF;
+	uint32_t RESERVED_B_75[3];
+	uint32_t L2_POST1_OUT_PITCH_B_BUF;
+	uint32_t L2_POST1_OUT_PITCH_G_BUF;
+	uint32_t L2_POST1_OUT_PITCH_R_BUF;
+	uint32_t L2_POST1_DUMMY_READ_EN_BUF;
+	uint32_t RESERVED_B_76[64];
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
index 000000000..2012d406a
--- /dev/null
+++ b/drivers/media/platform/visconti/viif.c
@@ -0,0 +1,2384 @@
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
+#define DRIVER_NAME "viif"
+
+#define VIIF_CROP_MAX_X_ISP (8062U)
+#define VIIF_CROP_MAX_Y_ISP (3966U)
+#define VIIF_CROP_MIN_W	    (128U)
+#define VIIF_CROP_MAX_W_ISP (8190U)
+#define VIIF_CROP_MIN_H	    (128U)
+#define VIIF_CROP_MAX_H_ISP (4094U)
+
+#define VIIF_ISP_GUARD_START(viif_dev)                                                             \
+	do {                                                                                       \
+		hwd_VIIF_isp_disable_regbuf_auto_transmission(viif_dev->ch);                       \
+		ndelay(500);                                                                       \
+		hwd_VIIF_main_mask_vlatch(viif_dev->ch, HWD_VIIF_ENABLE);                          \
+	} while (0)
+
+#define VIIF_ISP_GUARD_END(viif_dev)                                                               \
+	do {                                                                                       \
+		hwd_VIIF_main_mask_vlatch(viif_dev->ch, HWD_VIIF_DISABLE);                         \
+		hwd_VIIF_isp_set_regbuf_auto_transmission(viif_dev->ch, VIIF_ISP_REGBUF_0,         \
+							  VIIF_ISP_REGBUF_0, 0);                   \
+	} while (0)
+
+struct viif_buffer {
+	struct vb2_v4l2_buffer vb;
+	struct list_head queue;
+};
+
+void viif_hw_on(struct viif_device *viif_dev)
+{
+	hwd_VIIF_initialize(viif_dev->ch, viif_dev->csi2host_reg, viif_dev->capture_reg);
+}
+
+void viif_hw_off(struct viif_device *viif_dev)
+{
+	/* Uninitialize HWD driver */
+	hwd_VIIF_uninitialize(viif_dev->ch);
+}
+
+static inline struct viif_buffer *vb2_to_viif(struct vb2_v4l2_buffer *vbuf)
+{
+	return container_of(vbuf, struct viif_buffer, vb);
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
+static int viif_get_dv_timings(struct viif_device *viif_dev, struct v4l2_dv_timings *timings)
+{
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct v4l2_ctrl *ctrl;
+	int ret;
+	struct v4l2_subdev_pad_config pad_cfg;
+	struct v4l2_subdev_state pad_state = {
+		.pads = &pad_cfg,
+	};
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad = 0,
+	};
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
+static int viif_main_set_unit(struct viif_device *viif_dev)
+{
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct v4l2_dv_timings timings;
+	unsigned int dt_image, color_type, rawpack, yuv_conv;
+	struct hwd_viif_input_img in_img_main;
+	int ret = 0;
+	int mag_hactive = 1;
+	struct hwd_viif_l2_undist undist = { 0 };
+
+	ret = viif_get_dv_timings(viif_dev, &timings);
+	if (ret) {
+		dev_err(viif_dev->dev, "could not get timing information of subdev");
+		return -EINVAL;
+	}
+
+	viif_dev->mbus_is_rgb = false;
+
+	switch (viif_sd->mbus_code) {
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		dt_image = VISCONTI_CSI2_DT_RGB888;
+		viif_dev->mbus_is_rgb = true;
+		break;
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+		dt_image = VISCONTI_CSI2_DT_YUV4228B;
+		break;
+	case MEDIA_BUS_FMT_UYVY10_1X20:
+		dt_image = VISCONTI_CSI2_DT_YUV42210B;
+		break;
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		dt_image = VISCONTI_CSI2_DT_RGB565;
+		viif_dev->mbus_is_rgb = true;
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
+	if ((color_type == VISCONTI_CSI2_DT_RAW8) || (color_type == VISCONTI_CSI2_DT_RAW10) ||
+	    (color_type == VISCONTI_CSI2_DT_RAW12)) {
+		rawpack = viif_dev->rawpack_mode;
+		if (rawpack != HWD_VIIF_RAWPACK_DISABLE)
+			mag_hactive = 2;
+	} else
+		rawpack = HWD_VIIF_RAWPACK_DISABLE;
+
+	if ((color_type == VISCONTI_CSI2_DT_YUV4228B) || (color_type == VISCONTI_CSI2_DT_YUV42210B))
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
+	viif_dev->pixel_clock = in_img_main.pixel_clock;
+
+	in_img_main.interpolation_mode = HWD_VIIF_L1_INPUT_INTERPOLATION_LINE;
+	in_img_main.input_num = 1;
+	in_img_main.hobc_width = 0;
+	in_img_main.hobc_margin = 0;
+
+	/* configuration of MAIN unit */
+	ret = hwd_VIIF_main_set_unit(viif_dev->ch, dt_image, 0, &in_img_main, color_type, rawpack,
+				     yuv_conv);
+	if (ret) {
+		dev_err(viif_dev->dev, "main_set_unit error. %d\n", ret);
+		return ret;
+	}
+
+	/* Enable regbuf */
+	hwd_VIIF_isp_set_regbuf_auto_transmission(viif_dev->ch, VIIF_ISP_REGBUF_0,
+						  VIIF_ISP_REGBUF_0, 0);
+
+	/* L2 UNDIST Enable through mode as default  */
+	undist.through_mode = HWD_VIIF_ENABLE;
+	undist.sensor_crop_ofs_h = 1 - in_img_main.hactive_size;
+	undist.sensor_crop_ofs_v = 1 - in_img_main.vactive_size;
+	undist.grid_node_num_h = 16;
+	undist.grid_node_num_v = 16;
+	ret = hwd_VIIF_l2_set_undist(viif_dev->ch, VIIF_ISP_REGBUF_0, &undist);
+	if (ret)
+		dev_err(viif_dev->dev, "l2_set_undist error. %d\n", ret);
+	return ret;
+}
+
+struct visconti_mbus_format {
+	unsigned int code;
+	unsigned int bpp;
+} static visconti_mbus_formats[] = {
+	{ .code = MEDIA_BUS_FMT_RGB888_1X24, .bpp = 24 },
+	{ .code = MEDIA_BUS_FMT_UYVY8_1X16, .bpp = 16 },
+	{ .code = MEDIA_BUS_FMT_UYVY10_1X20, .bpp = 20 },
+	{ .code = MEDIA_BUS_FMT_RGB565_1X16, .bpp = 16 },
+	{ .code = MEDIA_BUS_FMT_SBGGR8_1X8, .bpp = 8 },
+	{ .code = MEDIA_BUS_FMT_SGBRG8_1X8, .bpp = 8 },
+	{ .code = MEDIA_BUS_FMT_SGRBG8_1X8, .bpp = 8 },
+	{ .code = MEDIA_BUS_FMT_SRGGB8_1X8, .bpp = 8 },
+	{ .code = MEDIA_BUS_FMT_SRGGB10_1X10, .bpp = 10 },
+	{ .code = MEDIA_BUS_FMT_SGRBG10_1X10, .bpp = 10 },
+	{ .code = MEDIA_BUS_FMT_SGBRG10_1X10, .bpp = 10 },
+	{ .code = MEDIA_BUS_FMT_SBGGR10_1X10, .bpp = 10 },
+	{ .code = MEDIA_BUS_FMT_SRGGB12_1X12, .bpp = 12 },
+	{ .code = MEDIA_BUS_FMT_SGRBG12_1X12, .bpp = 12 },
+	{ .code = MEDIA_BUS_FMT_SGBRG12_1X12, .bpp = 12 },
+	{ .code = MEDIA_BUS_FMT_SBGGR12_1X12, .bpp = 12 },
+	{ .code = MEDIA_BUS_FMT_SRGGB14_1X14, .bpp = 14 },
+	{ .code = MEDIA_BUS_FMT_SGRBG14_1X14, .bpp = 14 },
+	{ .code = MEDIA_BUS_FMT_SGBRG14_1X14, .bpp = 14 },
+	{ .code = MEDIA_BUS_FMT_SBGGR14_1X14, .bpp = 14 },
+};
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
+static int viif_init_mbus_code(struct viif_device *viif_dev)
+{
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct v4l2_subdev *v4l2_sd = viif_sd->v4l2_sd;
+	struct device *dev = viif_dev->dev;
+
+	struct v4l2_subdev_mbus_code_enum code = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.index = 0,
+	};
+
+	while (!v4l2_subdev_call(v4l2_sd, pad, enum_mbus_code, NULL, &code)) {
+		if (viif_is_valid_mbus_code(code.code)) {
+			viif_sd->mbus_code = code.code;
+			viif_sd->bpp = viif_get_mbus_bpp(viif_sd->mbus_code);
+			dev_err(dev, "Found media bus: code=0x%x bpp=%d\n", viif_sd->mbus_code,
+				viif_sd->bpp);
+			break;
+		}
+		code.index++;
+	}
+	if (!viif_sd->mbus_code) {
+		dev_err(dev, "Unsupported media bus format for %s\n", v4l2_sd->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
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
+static int viif_l2_set_format(struct viif_device *viif_dev)
+{
+	struct v4l2_pix_format_mplane *pix = &viif_dev->v4l2_pix;
+	const struct hwd_viif_csc_param *csc_param = NULL;
+	bool out_is_rgb = false;
+
+	viif_dev->out_process.half_scale = HWD_VIIF_DISABLE;
+	viif_dev->out_process.select_color = HWD_VIIF_COLOR_YUV_RGB;
+	viif_dev->out_process.alpha = 0;
+
+	if (viif_dev->l2_crop_set_flag) {
+		viif_dev->img_area.x = viif_dev->l2_crop_param.x;
+		viif_dev->img_area.y = viif_dev->l2_crop_param.y;
+		viif_dev->img_area.w = viif_dev->l2_crop_param.w;
+		viif_dev->img_area.h = viif_dev->l2_crop_param.h;
+	} else {
+		viif_dev->img_area.x = 0;
+		viif_dev->img_area.y = 0;
+		viif_dev->img_area.w = pix->width;
+		viif_dev->img_area.h = pix->height;
+	}
+
+	switch (pix->pixelformat) {
+	case V4L2_PIX_FMT_RGB24:
+		viif_dev->out_format = HWD_VIIF_RGB888_PACKED;
+		out_is_rgb = true;
+		break;
+	case V4L2_PIX_FMT_ABGR32:
+		viif_dev->out_format = HWD_VIIF_ARGB8888_PACKED;
+		viif_dev->out_process.alpha = 0xff;
+		out_is_rgb = true;
+		break;
+	case V4L2_PIX_FMT_YUV422M:
+		viif_dev->out_format = HWD_VIIF_YCBCR422_8_PLANAR;
+		break;
+	case V4L2_PIX_FMT_YUV444M:
+		viif_dev->out_format = HWD_VIIF_RGB888_YCBCR444_8_PLANAR;
+		break;
+	case V4L2_PIX_FMT_Y16:
+		viif_dev->out_format = HWD_VIIF_ONE_COLOR_16;
+		viif_dev->out_process.select_color = HWD_VIIF_COLOR_Y_G;
+		break;
+	}
+
+	if (!viif_dev->mbus_is_rgb && out_is_rgb)
+		csc_param = &viif_csc_yuv2rgb; /* YUV -> RGB */
+	else if (viif_dev->mbus_is_rgb && !out_is_rgb)
+		csc_param = &viif_csc_rgb2yuv; /* RGB -> YUV */
+
+	return hwd_VIIF_l2_set_output_csc(viif_dev->ch, VIIF_L2ISP_POST_0, VIIF_ISP_REGBUF_0,
+					  csc_param);
+}
+
+/* -----CSI2RX----- */
+static int viif_csi2rx_initialize(struct viif_device *viif_dev)
+{
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct hwd_viif_csi2rx_line_err_target err_target = { 0 };
+	struct hwd_viif_csi2rx_irq_mask csi2rx_mask;
+	struct v4l2_mbus_config cfg = { 0 };
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
+	dphy_rate = viif_dev->pixel_clock * viif_sd->bpp / num_lane;
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
+	return hwd_VIIF_csi2rx_initialize(viif_dev->ch, num_lane, HWD_VIIF_CSI2_DPHY_L0L1L2L3,
+					  dphy_rate, HWD_VIIF_ENABLE, &err_target,
+					  HWD_VIIF_CSI2_INPUT_OWN, &csi2rx_mask);
+}
+
+static int viif_csi2rx_start(struct viif_device *viif_dev)
+{
+	uint32_t vc_main = 0;
+	struct hwd_viif_csi2rx_packet packet = { 0 };
+
+	viif_dev->masked_gamma_path = 0U;
+
+	return hwd_VIIF_csi2rx_start(viif_dev->ch, vc_main, HWD_VIIF_CSI2_NOT_CAPTURE, &packet,
+				     HWD_VIIF_DISABLE);
+}
+
+static int viif_csi2rx_stop(struct viif_device *viif_dev)
+{
+	int32_t ret;
+
+	ret = hwd_VIIF_csi2rx_stop(viif_dev->ch);
+	if (ret)
+		dev_err(viif_dev->dev, "csi2rx_stop error. %d\n", ret);
+
+	hwd_VIIF_csi2rx_uninitialize(viif_dev->ch);
+
+	return ret;
+}
+
+/* ----- Private IOCTLs----- */
+static int viif_main_set_rawpack_mode(struct viif_device *viif_dev, uint32_t *rawpack)
+{
+	if (vb2_is_streaming(&viif_dev->vb2_vq))
+		return -EBUSY;
+
+	if ((*rawpack != VIIF_RAWPACK_DISABLE) && (*rawpack != VIIF_RAWPACK_MSBFIRST) &&
+	    (*rawpack != VIIF_RAWPACK_LSBFIRST))
+		return -EINVAL;
+
+	viif_dev->rawpack_mode = *rawpack;
+	return 0;
+}
+
+static int viif_l1_set_input_mode(struct viif_device *viif_dev,
+				  struct viif_l1_input_mode_config *input_mode)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	/* SDR input is not supported */
+	ret = hwd_VIIF_l1_set_input_mode(viif_dev->ch, input_mode->mode, input_mode->depth,
+					 input_mode->raw_color_filter, NULL);
+	VIIF_ISP_GUARD_END(viif_dev);
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
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_rgb_to_y_coef(viif_dev->ch, VIIF_ISP_REGBUF_0,
+					    l1_rgb_to_y_coef->coef_r, l1_rgb_to_y_coef->coef_g,
+					    l1_rgb_to_y_coef->coef_b);
+	VIIF_ISP_GUARD_END(viif_dev);
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
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_ag_mode(viif_dev->ch, VIIF_ISP_REGBUF_0,
+				      (struct hwd_viif_l1_ag_mode *)l1_ag_mode);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_ag(struct viif_device *viif_dev, struct viif_l1_ag_config *l1_ag)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_ag(viif_dev->ch, VIIF_ISP_REGBUF_0, l1_ag->gain_h, l1_ag->gain_m,
+				 l1_ag->gain_l);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_hdre(struct viif_device *viif_dev, struct viif_l1_hdre_config *l1_hdre)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_hdre(viif_dev->ch, VIIF_ISP_REGBUF_0,
+				   (struct hwd_viif_l1_hdre *)l1_hdre);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_img_extraction(struct viif_device *viif_dev,
+				      struct viif_l1_img_extraction_config *img_extract)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_img_extraction(viif_dev->ch, VIIF_ISP_REGBUF_0,
+					     img_extract->input_black_gr,
+					     img_extract->input_black_r, img_extract->input_black_b,
+					     img_extract->input_black_gb);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+#define VISCONTI_VIIF_DPC_TABLE_SIZE 8192
+static int viif_l1_set_dpc(struct viif_device *viif_dev, struct viif_l1_dpc_config *l1_dpc)
+{
+	int ret;
+	unsigned long irqflags;
+	uintptr_t table_h_paddr = 0;
+	uintptr_t table_m_paddr = 0;
+	uintptr_t table_l_paddr = 0;
+
+	if (l1_dpc->table_h) {
+		if (copy_from_user(viif_dev->table_vaddr->dpc_table_h,
+				   (void __user *)l1_dpc->table_h, VISCONTI_VIIF_DPC_TABLE_SIZE))
+			return -EFAULT;
+		table_h_paddr = (uintptr_t)viif_dev->table_paddr->dpc_table_h;
+	}
+	if (l1_dpc->table_m) {
+		if (copy_from_user(viif_dev->table_vaddr->dpc_table_m,
+				   (void __user *)l1_dpc->table_m, VISCONTI_VIIF_DPC_TABLE_SIZE))
+			return -EFAULT;
+		table_m_paddr = (uintptr_t)viif_dev->table_paddr->dpc_table_m;
+	}
+	if (l1_dpc->table_l) {
+		if (copy_from_user(viif_dev->table_vaddr->dpc_table_l,
+				   (void __user *)l1_dpc->table_l, VISCONTI_VIIF_DPC_TABLE_SIZE))
+			return -EFAULT;
+		table_l_paddr = (uintptr_t)viif_dev->table_paddr->dpc_table_l;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_dpc_table_transmission(viif_dev->ch, table_h_paddr, table_m_paddr,
+						     table_l_paddr);
+	if (ret)
+		goto err;
+
+	ret = hwd_VIIF_l1_set_dpc(viif_dev->ch, VIIF_ISP_REGBUF_0,
+				  (struct hwd_viif_l1_dpc *)&l1_dpc->param_h,
+				  (struct hwd_viif_l1_dpc *)&l1_dpc->param_m,
+				  (struct hwd_viif_l1_dpc *)&l1_dpc->param_l);
+err:
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+	return ret;
+}
+
+static int
+viif_l1_set_preset_white_balance(struct viif_device *viif_dev,
+				 struct viif_l1_preset_white_balance_config *l1_preset_wb)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_preset_white_balance(
+		viif_dev->ch, VIIF_ISP_REGBUF_0, l1_preset_wb->dstmaxval,
+		(struct hwd_viif_l1_preset_white_balance *)&l1_preset_wb->param_h,
+		(struct hwd_viif_l1_preset_white_balance *)&l1_preset_wb->param_m,
+		(struct hwd_viif_l1_preset_white_balance *)&l1_preset_wb->param_l);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int
+viif_l1_set_raw_color_noise_reduction(struct viif_device *viif_dev,
+				      struct viif_l1_raw_color_noise_reduction_config *raw_color)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_raw_color_noise_reduction(
+		viif_dev->ch, VIIF_ISP_REGBUF_0,
+		(struct hwd_viif_l1_raw_color_noise_reduction *)&raw_color->param_h,
+		(struct hwd_viif_l1_raw_color_noise_reduction *)&raw_color->param_m,
+		(struct hwd_viif_l1_raw_color_noise_reduction *)&raw_color->param_l);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_hdrs(struct viif_device *viif_dev, struct viif_l1_hdrs_config *hdrs)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_hdrs(viif_dev->ch, VIIF_ISP_REGBUF_0,
+				   (struct hwd_viif_l1_hdrs *)hdrs);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_black_level_correction(struct viif_device *viif_dev,
+					      struct viif_l1_black_level_correction_config *blc)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_black_level_correction(
+		viif_dev->ch, VIIF_ISP_REGBUF_0, (struct hwd_viif_l1_black_level_correction *)blc);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_lsc(struct viif_device *viif_dev, struct viif_l1_lsc_config *l1_lsc)
+{
+	int ret;
+	unsigned long irqflags;
+	struct viif_l1_lsc_parabola_param lsc_para;
+	struct hwd_viif_l1_lsc hwd_lsc;
+	struct hwd_viif_l1_lsc_parabola_param hwd_lsc_para;
+	struct hwd_viif_l1_lsc_grid_param hwd_lsc_grid;
+	uintptr_t table_gr_paddr = 0;
+	uintptr_t table_r_paddr = 0;
+	uintptr_t table_b_paddr = 0;
+	uintptr_t table_gb_paddr = 0;
+
+	if (!l1_lsc->param) {
+		spin_lock_irqsave(&viif_dev->lock, irqflags);
+		VIIF_ISP_GUARD_START(viif_dev);
+		ret = hwd_VIIF_l1_set_lsc(viif_dev->ch, VIIF_ISP_REGBUF_0, NULL);
+		VIIF_ISP_GUARD_END(viif_dev);
+		spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+		return ret;
+	}
+
+	if (l1_lsc->table_gr) {
+		if (copy_from_user(viif_dev->table_vaddr->lsc_table_gr,
+				   (void __user *)l1_lsc->table_gr, 1536))
+			return -EFAULT;
+		table_gr_paddr = (uintptr_t)viif_dev->table_paddr->lsc_table_gr;
+	}
+	if (l1_lsc->table_r) {
+		if (copy_from_user(viif_dev->table_vaddr->lsc_table_r,
+				   (void __user *)l1_lsc->table_r, 1536))
+			return -EFAULT;
+		table_r_paddr = (uintptr_t)viif_dev->table_paddr->lsc_table_r;
+	}
+	if (l1_lsc->table_b) {
+		if (copy_from_user(viif_dev->table_vaddr->lsc_table_b,
+				   (void __user *)l1_lsc->table_b, 1536))
+			return -EFAULT;
+		table_b_paddr = (uintptr_t)viif_dev->table_paddr->lsc_table_b;
+	}
+	if (l1_lsc->table_gb) {
+		if (copy_from_user(viif_dev->table_vaddr->lsc_table_gb,
+				   (void __user *)l1_lsc->table_gb, 1536))
+			return -EFAULT;
+		table_gb_paddr = (uintptr_t)viif_dev->table_paddr->lsc_table_gb;
+	}
+
+	if (copy_from_user(&hwd_lsc, (void __user *)l1_lsc->param, sizeof(struct hwd_viif_l1_lsc)))
+		return -EFAULT;
+
+	if (hwd_lsc.lssc_parabola_param) {
+		if (copy_from_user(&lsc_para, (void __user *)hwd_lsc.lssc_parabola_param,
+				   sizeof(struct viif_l1_lsc_parabola_param)))
+			return -EFAULT;
+
+		hwd_lsc_para.lssc_para_h_center = lsc_para.lssc_para_h_center;
+		hwd_lsc_para.lssc_para_v_center = lsc_para.lssc_para_v_center;
+		hwd_lsc_para.lssc_para_h_gain = lsc_para.lssc_para_h_gain;
+		hwd_lsc_para.lssc_para_v_gain = lsc_para.lssc_para_v_gain;
+		hwd_lsc_para.lssc_para_mgsel2 = lsc_para.lssc_para_mgsel2;
+		hwd_lsc_para.lssc_para_mgsel4 = lsc_para.lssc_para_mgsel4;
+		hwd_lsc_para.r_2d = (struct hwd_viif_l1_lsc_parabola_ag_param *)&lsc_para.r_2d;
+		hwd_lsc_para.r_4d = (struct hwd_viif_l1_lsc_parabola_ag_param *)&lsc_para.r_4d;
+		hwd_lsc_para.gr_2d = (struct hwd_viif_l1_lsc_parabola_ag_param *)&lsc_para.gr_2d;
+		hwd_lsc_para.gr_4d = (struct hwd_viif_l1_lsc_parabola_ag_param *)&lsc_para.gr_4d;
+		hwd_lsc_para.gb_2d = (struct hwd_viif_l1_lsc_parabola_ag_param *)&lsc_para.gb_2d;
+		hwd_lsc_para.gb_4d = (struct hwd_viif_l1_lsc_parabola_ag_param *)&lsc_para.gb_4d;
+		hwd_lsc_para.b_2d = (struct hwd_viif_l1_lsc_parabola_ag_param *)&lsc_para.b_2d;
+		hwd_lsc_para.b_4d = (struct hwd_viif_l1_lsc_parabola_ag_param *)&lsc_para.b_4d;
+
+		hwd_lsc.lssc_parabola_param = &hwd_lsc_para;
+	}
+
+	if (hwd_lsc.lssc_grid_param) {
+		if (copy_from_user(&hwd_lsc_grid, (void __user *)hwd_lsc.lssc_grid_param,
+				   sizeof(struct hwd_viif_l1_lsc_grid_param)))
+			return -EFAULT;
+
+		hwd_lsc.lssc_grid_param = &hwd_lsc_grid;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_lsc_table_transmission(viif_dev->ch, table_gr_paddr, table_r_paddr,
+						     table_b_paddr, table_gb_paddr);
+	if (ret)
+		goto err;
+
+	ret = hwd_VIIF_l1_set_lsc(viif_dev->ch, VIIF_ISP_REGBUF_0, &hwd_lsc);
+err:
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+	return ret;
+}
+
+static int viif_l1_set_main_process(struct viif_device *viif_dev,
+				    struct viif_l1_main_process_config *mpro)
+{
+	struct hwd_viif_l1_color_matrix_correction color_matrix;
+	int ret;
+	unsigned long irqflags;
+
+	if (mpro->param) {
+		if (copy_from_user(&color_matrix, (void __user *)mpro->param,
+				   sizeof(struct hwd_viif_l1_color_matrix_correction)))
+			return -EFAULT;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_main_process(viif_dev->ch, VIIF_ISP_REGBUF_0, mpro->demosaic_mode,
+					   mpro->damp_lsbsel, mpro->param ? &color_matrix : NULL,
+					   mpro->dst_maxval);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_awb(struct viif_device *viif_dev, struct viif_l1_awb_config *l1_awb)
+{
+	struct hwd_viif_l1_awb param;
+	int ret;
+	unsigned long irqflags;
+
+	if (l1_awb->param) {
+		if (copy_from_user(&param, (void __user *)l1_awb->param,
+				   sizeof(struct hwd_viif_l1_awb)))
+			return -EFAULT;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_awb(viif_dev->ch, VIIF_ISP_REGBUF_0, l1_awb->param ? &param : NULL,
+				  l1_awb->awhb_wbmrg, l1_awb->awhb_wbmgg, l1_awb->awhb_wbmbg);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_lock_awb_gain(struct viif_device *viif_dev, uint32_t *enable)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_lock_awb_gain(viif_dev->ch, VIIF_ISP_REGBUF_0, *enable);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_hdrc(struct viif_device *viif_dev, struct viif_l1_hdrc_config *hdrc)
+{
+	struct hwd_viif_l1_hdrc param;
+	int ret;
+	unsigned long irqflags;
+
+	if (hdrc->param) {
+		if (copy_from_user(&param, (void __user *)hdrc->param,
+				   sizeof(struct hwd_viif_l1_hdrc)))
+			return -EFAULT;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_hdrc(viif_dev->ch, VIIF_ISP_REGBUF_0, hdrc->param ? &param : NULL,
+				   hdrc->hdrc_thr_sft_amt);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_hdrc_ltm(struct viif_device *viif_dev,
+				struct viif_l1_hdrc_ltm_config *l1_hdrc_ltm)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_hdrc_ltm(viif_dev->ch, VIIF_ISP_REGBUF_0,
+				       (struct hwd_viif_l1_hdrc_ltm *)l1_hdrc_ltm);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int viif_l1_set_gamma(struct viif_device *viif_dev, struct viif_l1_gamma_config *l1_gamma)
+{
+	struct hwd_viif_l1_gamma param;
+	int ret;
+	unsigned long irqflags;
+
+	if (l1_gamma->param) {
+		if (copy_from_user(&param, (void __user *)l1_gamma->param,
+				   sizeof(struct hwd_viif_l1_gamma)))
+			return -EFAULT;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_gamma(viif_dev->ch, VIIF_ISP_REGBUF_0,
+				    l1_gamma->param ? &param : NULL);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+static int
+viif_l1_set_img_quality_adjustment(struct viif_device *viif_dev,
+				   struct viif_l1_img_quality_adjustment_config *img_quality)
+{
+	struct viif_l1_nonlinear_contrast nonlinear;
+	struct viif_l1_lum_noise_reduction lum_noise;
+	struct viif_l1_edge_enhancement edge_enh;
+	struct viif_l1_uv_suppression uv;
+	struct viif_l1_coring_suppression coring;
+	struct viif_l1_edge_suppression edge_sup;
+	struct viif_l1_color_level color;
+	int ret;
+	unsigned long irqflags;
+
+	if (img_quality->nonlinear_contrast) {
+		if (copy_from_user(&nonlinear, (void __user *)img_quality->nonlinear_contrast,
+				   sizeof(struct viif_l1_nonlinear_contrast)))
+			return -EFAULT;
+		img_quality->nonlinear_contrast = &nonlinear;
+	}
+	if (img_quality->lum_noise_reduction) {
+		if (copy_from_user(&lum_noise, (void __user *)img_quality->lum_noise_reduction,
+				   sizeof(struct viif_l1_lum_noise_reduction)))
+			return -EFAULT;
+		img_quality->lum_noise_reduction = &lum_noise;
+	}
+	if (img_quality->edge_enhancement) {
+		if (copy_from_user(&edge_enh, (void __user *)img_quality->edge_enhancement,
+				   sizeof(struct viif_l1_edge_enhancement)))
+			return -EFAULT;
+		img_quality->edge_enhancement = &edge_enh;
+	}
+	if (img_quality->uv_suppression) {
+		if (copy_from_user(&uv, (void __user *)img_quality->uv_suppression,
+				   sizeof(struct viif_l1_uv_suppression)))
+			return -EFAULT;
+		img_quality->uv_suppression = &uv;
+	}
+	if (img_quality->coring_suppression) {
+		if (copy_from_user(&coring, (void __user *)img_quality->coring_suppression,
+				   sizeof(struct viif_l1_coring_suppression)))
+			return -EFAULT;
+		img_quality->coring_suppression = &coring;
+	}
+	if (img_quality->edge_suppression) {
+		if (copy_from_user(&edge_sup, (void __user *)img_quality->edge_suppression,
+				   sizeof(struct viif_l1_edge_suppression)))
+			return -EFAULT;
+		img_quality->edge_suppression = &edge_sup;
+	}
+	if (img_quality->color_level) {
+		if (copy_from_user(&color, (void __user *)img_quality->color_level,
+				   sizeof(struct viif_l1_color_level)))
+			return -EFAULT;
+		img_quality->color_level = &color;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l1_set_img_quality_adjustment(
+		viif_dev->ch, VIIF_ISP_REGBUF_0,
+		(struct hwd_viif_l1_img_quality_adjustment *)img_quality);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+}
+
+#define VISCONTI_VIIF_DPC_TABLE_SIZE_MIN 1024
+#define VISCONTI_VIIF_DPC_TABLE_SIZE_MAX 8192
+static int viif_l2_set_undist(struct viif_device *viif_dev, struct viif_l2_undist_config *undist)
+{
+	int ret;
+	unsigned long irqflags;
+	uintptr_t table_write_g_paddr = 0;
+	uintptr_t table_read_b_paddr = 0;
+	uintptr_t table_read_g_paddr = 0;
+	uintptr_t table_read_r_paddr = 0;
+
+	if ((undist->size && (undist->size < VISCONTI_VIIF_DPC_TABLE_SIZE_MIN)) ||
+	    (undist->size > VISCONTI_VIIF_DPC_TABLE_SIZE_MAX))
+		return -EINVAL;
+
+	if (undist->write_g) {
+		if (copy_from_user(viif_dev->table_vaddr->undist_write_g,
+				   (void __user *)undist->write_g, undist->size))
+			return -EFAULT;
+		table_write_g_paddr = (uintptr_t)viif_dev->table_paddr->undist_write_g;
+	}
+	if (undist->read_b) {
+		if (copy_from_user(viif_dev->table_vaddr->undist_read_b,
+				   (void __user *)undist->read_b, undist->size))
+			return -EFAULT;
+		table_read_b_paddr = (uintptr_t)viif_dev->table_paddr->undist_read_b;
+	}
+	if (undist->read_g) {
+		if (copy_from_user(viif_dev->table_vaddr->undist_read_g,
+				   (void __user *)undist->read_g, undist->size))
+			return -EFAULT;
+		table_read_g_paddr = (uintptr_t)viif_dev->table_paddr->undist_read_g;
+	}
+	if (undist->read_r) {
+		if (copy_from_user(viif_dev->table_vaddr->undist_read_r,
+				   (void __user *)undist->read_r, undist->size))
+			return -EFAULT;
+		table_read_r_paddr = (uintptr_t)viif_dev->table_paddr->undist_read_r;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l2_set_undist_table_transmission(viif_dev->ch, table_write_g_paddr,
+							table_read_b_paddr, table_read_g_paddr,
+							table_read_r_paddr, undist->size);
+	if (ret) {
+		dev_err(viif_dev->dev, "l2_set_undist_table_transmission error. %d\n", ret);
+		goto err;
+	}
+
+	ret = hwd_VIIF_l2_set_undist(viif_dev->ch, VIIF_ISP_REGBUF_0,
+				     (struct hwd_viif_l2_undist *)&undist->param);
+err:
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+	return ret;
+}
+
+static int viif_l2_set_roi(struct viif_device *viif_dev, struct viif_l2_roi_config *roi)
+{
+	int ret;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l2_set_roi(viif_dev->ch, VIIF_ISP_REGBUF_0, (struct hwd_viif_l2_roi *)roi);
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+	return ret;
+}
+
+#define VISCONTI_VIIF_GANMMA_TABLE_SIZE 512
+static int viif_l2_set_gamma(struct viif_device *viif_dev, struct viif_l2_gamma_config *l2_gamma)
+{
+	int ret;
+	unsigned long irqflags;
+	struct hwd_viif_l2_gamma_table hwd_table = { 0 };
+	uint32_t i;
+
+	for (i = 0; i < 6; i++) {
+		if (l2_gamma->table[i]) {
+			if (copy_from_user(viif_dev->table_vaddr->l2_gamma_table[i],
+					   (void __user *)l2_gamma->table[i],
+					   VISCONTI_VIIF_GANMMA_TABLE_SIZE))
+				return -EFAULT;
+			hwd_table.table[i] = (uintptr_t)viif_dev->table_paddr->l2_gamma_table[i];
+		}
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l2_set_gamma_table_transmission(viif_dev->ch, VIIF_L2ISP_POST_0, &hwd_table);
+	if (ret)
+		goto err;
+
+	ret = hwd_VIIF_l2_set_gamma(viif_dev->ch, VIIF_L2ISP_POST_0, VIIF_ISP_REGBUF_0,
+				    l2_gamma->enable, l2_gamma->vsplit, l2_gamma->mode);
+err:
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+	return ret;
+}
+
+static int viif_l2_set_crop(struct viif_device *viif_dev, struct viif_l2_crop_config *l2_crop)
+{
+	if ((l2_crop->x > VIIF_CROP_MAX_X_ISP) || (l2_crop->y > VIIF_CROP_MAX_Y_ISP) ||
+	    (l2_crop->w < VIIF_CROP_MIN_W) || (l2_crop->w > VIIF_CROP_MAX_W_ISP) ||
+	    (l2_crop->h < VIIF_CROP_MIN_H) || (l2_crop->h > VIIF_CROP_MAX_H_ISP)) {
+		return -EINVAL;
+	}
+
+	if (viif_dev->l2_crop_set_flag) {
+		if ((l2_crop->w != viif_dev->l2_crop_param.w) ||
+		    (l2_crop->h != viif_dev->l2_crop_param.h))
+			return -EINVAL;
+	}
+
+	viif_dev->l2_crop_param.x = l2_crop->x;
+	viif_dev->l2_crop_param.y = l2_crop->y;
+	viif_dev->l2_crop_param.w = l2_crop->w;
+	viif_dev->l2_crop_param.h = l2_crop->h;
+
+	viif_dev->l2_crop_set_flag = true;
+
+	return 0;
+}
+
+static int viif_csi2rx_set_mbus_fmt(struct viif_device *viif_dev, uint32_t *mbus_code)
+{
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct v4l2_subdev *v4l2_sd = viif_sd->v4l2_sd;
+	struct v4l2_subdev_pad_config pad_cfg;
+	struct v4l2_subdev_state pad_state = {
+		.pads = &pad_cfg,
+	};
+	struct v4l2_subdev_format format = {
+		.pad = 0,
+	};
+	int ret = -EINVAL;
+
+	if (vb2_is_streaming(&viif_dev->vb2_vq))
+		return -EBUSY;
+
+	if (viif_is_valid_mbus_code(*mbus_code)) {
+		ret = v4l2_subdev_call(v4l2_sd, pad, get_fmt, &pad_state, &format);
+		if (ret) {
+			dev_err(viif_dev->dev, "subdev: get_fmt error. %d\n", ret);
+			return ret;
+		}
+
+		format.format.code = *mbus_code;
+		format.which = V4L2_SUBDEV_FORMAT_TRY;
+
+		ret = v4l2_subdev_call(v4l2_sd, pad, set_fmt, &pad_state, &format);
+		if (ret) {
+			dev_err(viif_dev->dev, "subdev: set_fmt(TRY) error. %d\n", ret);
+			return ret;
+		}
+
+		viif_sd->mbus_code = *mbus_code;
+		viif_sd->bpp = viif_get_mbus_bpp(*mbus_code);
+	}
+	return ret;
+}
+
+static int
+viif_csi2rx_get_calibration_status(struct viif_device *viif_dev,
+				   struct viif_csi2rx_dphy_calibration_status *calibration_status)
+{
+	int ret;
+
+	if (!vb2_is_streaming(&viif_dev->vb2_vq))
+		return -EIO;
+
+	ret = hwd_VIIF_csi2rx_get_calibration_status(
+		viif_dev->ch, (struct hwd_viif_csi2rx_dphy_calibration_status *)calibration_status);
+
+	return ret;
+}
+
+static int viif_csi2rx_get_err_status(struct viif_device *viif_dev,
+				      struct viif_csi2rx_err_status *csi_err)
+{
+	int ret;
+
+	if (!vb2_is_streaming(&viif_dev->vb2_vq))
+		return -EIO;
+
+	ret = hwd_VIIF_csi2rx_get_err_status(viif_dev->ch, &csi_err->err_phy_fatal,
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
+	unsigned long irqflags;
+	struct hwd_viif_l1_info l1_info;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	VIIF_ISP_GUARD_START(viif_dev);
+	hwd_VIIF_isp_get_info(viif_dev->ch, VIIF_ISP_REGBUF_0, NULL, &l1_info, NULL, NULL, NULL,
+			      NULL);
+	status->l1_info.awb_ave_u = l1_info.awb_ave_u;
+	status->l1_info.awb_ave_v = l1_info.awb_ave_v;
+	status->l1_info.awb_accumulated_pixel = l1_info.awb_accumulated_pixel;
+	status->l1_info.awb_gain_r = l1_info.awb_gain_r;
+	status->l1_info.awb_gain_g = l1_info.awb_gain_g;
+	status->l1_info.awb_gain_b = l1_info.awb_gain_b;
+	status->l1_info.awb_status_u = l1_info.awb_status_u;
+	status->l1_info.awb_status_v = l1_info.awb_status_v;
+
+	VIIF_ISP_GUARD_END(viif_dev);
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return 0;
+}
+
+static long viif_ioctl_default(struct file *file, void *fh, bool valid_prio, unsigned int cmd,
+			       void *arg)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+	int ret;
+
+	switch (cmd) {
+	case VIDIOC_VIIF_MAIN_SET_RAWPACK_MODE:
+		ret = viif_main_set_rawpack_mode(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_INPUT_MODE:
+		ret = viif_l1_set_input_mode(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_RGB_TO_Y_COEF:
+		ret = viif_l1_set_rgb_to_y_coef(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_AG_MODE:
+		ret = viif_l1_set_ag_mode(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_AG:
+		ret = viif_l1_set_ag(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_HDRE:
+		ret = viif_l1_set_hdre(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_IMG_EXTRACTION:
+		ret = viif_l1_set_img_extraction(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_DPC:
+		ret = viif_l1_set_dpc(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_PRESET_WHITE_BALANCE:
+		ret = viif_l1_set_preset_white_balance(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_RAW_COLOR_NOISE_REDUCTION:
+		ret = viif_l1_set_raw_color_noise_reduction(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_HDRS:
+		ret = viif_l1_set_hdrs(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_BLACK_LEVEL_CORRECTION:
+		ret = viif_l1_set_black_level_correction(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_LSC:
+		ret = viif_l1_set_lsc(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_MAIN_PROCESS:
+		ret = viif_l1_set_main_process(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_AWB:
+		ret = viif_l1_set_awb(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_LOCK_AWB_GAIN:
+		ret = viif_l1_lock_awb_gain(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_HDRC:
+		ret = viif_l1_set_hdrc(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_HDRC_LTM:
+		ret = viif_l1_set_hdrc_ltm(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_GAMMA:
+		ret = viif_l1_set_gamma(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L1_SET_IMG_QUALITY_ADJUSTMENT:
+		ret = viif_l1_set_img_quality_adjustment(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L2_SET_UNDIST:
+		ret = viif_l2_set_undist(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L2_SET_ROI:
+		ret = viif_l2_set_roi(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L2_SET_GAMMA:
+		ret = viif_l2_set_gamma(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_L2_SET_CROP:
+		ret = viif_l2_set_crop(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_CSI2RX_SET_MBUS_FMT:
+		ret = viif_csi2rx_set_mbus_fmt(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_CSI2RX_GET_CALIBRATION_STATUS:
+		ret = viif_csi2rx_get_calibration_status(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_CSI2RX_GET_ERR_STATUS:
+		ret = viif_csi2rx_get_err_status(viif_dev, arg);
+		break;
+	case VIDIOC_VIIF_ISP_GET_LAST_CAPTURE_STATUS:
+		ret = viif_isp_get_last_capture_status(viif_dev, arg);
+		break;
+	default:
+		ret = -ENOTTY;
+		break;
+	}
+	return ret;
+}
+
+/* ----- ISRs and VB2 Operations ----- */
+static int viif_set_img(struct viif_device *viif_dev, struct vb2_buffer *vb)
+{
+	struct v4l2_pix_format_mplane *pix = &viif_dev->v4l2_pix;
+	struct hwd_viif_img next_out_img;
+	dma_addr_t phys_addr;
+	int i, ret = 0;
+
+	next_out_img.width = pix->width;
+	next_out_img.height = pix->height;
+	next_out_img.format = viif_dev->out_format;
+
+	for (i = 0; i < pix->num_planes; i++) {
+		next_out_img.pixelmap[i].pitch = pix->plane_fmt[i].bytesperline;
+		phys_addr = vb2_dma_contig_plane_dma_addr(vb, i);
+		/* address mapping:
+		 * - DDR0: (CPU)0x0_8000_0000-0x0_FFFF_FFFF -> (HW)0x8000_0000-0xFFFF_FFFF
+		 * - DDR1: (CPU)0x8_8000_0000-0x8_FFFF_FFFF -> (HW)0x0000_0000-0x7FFF_FFFF
+		 */
+		next_out_img.pixelmap[i].pmap_paddr = (phys_addr & 0x800000000UL) ?
+							      (phys_addr & 0x7fffffff) :
+							      (phys_addr & 0xffffffff);
+	}
+	VIIF_ISP_GUARD_START(viif_dev);
+	ret = hwd_VIIF_l2_set_img_transmission(viif_dev->ch, VIIF_L2ISP_POST_0, VIIF_ISP_REGBUF_0,
+					       HWD_VIIF_ENABLE, &viif_dev->img_area,
+					       &viif_dev->out_process, &next_out_img);
+	VIIF_ISP_GUARD_END(viif_dev);
+	if (ret)
+		dev_err(viif_dev->dev, "set img error. %d\n", ret);
+
+	return ret;
+}
+
+#define VIIF_SYNC_M_EVENT_DELAY2_SHIFT 2U
+#define MAIN_DELAY_INT_ERR_MASK	       0x01000000U
+
+static void viif_vsync_irq_handler_w_isp(struct viif_device *viif_dev)
+{
+	uint32_t event_main, event_sub, mask, status_err, l2_transfer_status;
+	struct vb2_v4l2_buffer *vbuf;
+	struct viif_buffer *buf;
+	enum vb2_buffer_state state;
+
+	hwd_VIIF_vsync_irq_handler(viif_dev->ch, &event_main, &event_sub);
+
+	/* Delayed Vsync of MAIN unit */
+	if (((event_main >> VIIF_SYNC_M_EVENT_DELAY2_SHIFT) & 0x1U) == 0x1U) {
+		/* unmask timeout error of gamma table */
+		mask = MAIN_DELAY_INT_ERR_MASK;
+		hwd_VIIF_main_status_err_set_irq_mask(viif_dev->ch, &mask);
+		viif_dev->masked_gamma_path = 0;
+
+		/* Get abort status of L2ISP */
+		VIIF_ISP_GUARD_START(viif_dev);
+		hwd_VIIF_isp_get_info(viif_dev->ch, VIIF_ISP_REGBUF_0, NULL, NULL, NULL,
+				      &l2_transfer_status, NULL, NULL);
+		VIIF_ISP_GUARD_END(viif_dev);
+
+		status_err = viif_dev->status_err;
+		viif_dev->status_err = 0;
+
+		vbuf = viif_dev->dma_active;
+		if (!vbuf)
+			goto next;
+
+		viif_dev->buf_cnt--;
+		vbuf->vb2_buf.timestamp = ktime_get_ns();
+		vbuf->sequence = viif_dev->sequence++;
+		vbuf->field = viif_dev->field;
+		if (status_err || l2_transfer_status)
+			state = VB2_BUF_STATE_ERROR;
+		else
+			state = VB2_BUF_STATE_DONE;
+
+		vb2_buffer_done(&vbuf->vb2_buf, state);
+		viif_dev->dma_active = NULL;
+
+	next:
+		vbuf = viif_dev->active;
+		if (!vbuf)
+			return;
+
+		if (viif_dev->last_active) {
+			viif_dev->dma_active = viif_dev->last_active;
+			viif_dev->last_active = NULL;
+		} else if (!viif_dev->dma_active) {
+			viif_dev->dma_active = vbuf;
+			buf = vb2_to_viif(vbuf);
+			list_del_init(&buf->queue);
+		}
+
+		if (!list_empty(&viif_dev->capture)) {
+			buf = list_entry(viif_dev->capture.next, struct viif_buffer, queue);
+			viif_dev->active = &buf->vb;
+			viif_set_img(viif_dev, &buf->vb.vb2_buf);
+		} else {
+			dev_dbg(viif_dev->dev, "no queue\n");
+			viif_dev->last_active = viif_dev->dma_active;
+			viif_dev->dma_active = NULL;
+			viif_dev->active = NULL;
+		}
+	}
+}
+
+#define VIIF_ERR_M_EVENT_GAMMATBL_SHIFT 8U
+#define VIIF_ERR_M_EVENT_GAMMATBL_MASK	0x7U
+
+static void viif_status_err_irq_handler(struct viif_device *viif_dev)
+{
+	uint32_t event_main, event_sub, val, mask;
+
+	hwd_VIIF_status_err_irq_handler(viif_dev->ch, &event_main, &event_sub);
+
+	if (event_main != 0U) {
+		/* mask for gamma table time out error which will be unmasked in the next Vsync */
+		val = (event_main >> VIIF_ERR_M_EVENT_GAMMATBL_SHIFT) &
+		      VIIF_ERR_M_EVENT_GAMMATBL_MASK;
+		if (val != 0U) {
+			viif_dev->masked_gamma_path |= val;
+			mask = MAIN_DELAY_INT_ERR_MASK |
+			       (viif_dev->masked_gamma_path << VIIF_ERR_M_EVENT_GAMMATBL_SHIFT);
+			hwd_VIIF_main_status_err_set_irq_mask(viif_dev->ch, &mask);
+		}
+
+		viif_dev->status_err = event_main;
+	}
+	dev_err(viif_dev->dev, "Status error 0x%x.\n", event_main);
+}
+
+static void viif_csi2rx_err_irq_handler(struct viif_device *viif_dev)
+{
+	uint32_t event;
+
+	event = hwd_VIIF_csi2rx_err_irq_handler(viif_dev->ch);
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
+static int viif_vb2_setup(struct vb2_queue *vq, unsigned int *count, unsigned int *num_planes,
+			  unsigned int sizes[], struct device *alloc_devs[])
+{
+	struct viif_device *viif_dev = vb2_get_drv_priv(vq);
+	struct v4l2_pix_format_mplane *pix = &viif_dev->v4l2_pix;
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
+	viif_dev->buf_cnt = 0;
+
+	return 0;
+}
+
+static void viif_vb2_queue(struct vb2_buffer *vb)
+{
+	struct viif_device *viif_dev = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct viif_buffer *buf = vb2_to_viif(vbuf);
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	list_add_tail(&buf->queue, &viif_dev->capture);
+	viif_dev->buf_cnt++;
+
+	if (!viif_dev->active) {
+		viif_dev->active = vbuf;
+		if (!viif_dev->last_active)
+			viif_set_img(viif_dev, vb);
+	}
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+}
+
+static int viif_vb2_prepare(struct vb2_buffer *vb)
+{
+	struct viif_device *viif_dev = vb2_get_drv_priv(vb->vb2_queue);
+	struct v4l2_pix_format_mplane *pix = &viif_dev->v4l2_pix;
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
+	struct viif_device *viif_dev = vb2_get_drv_priv(vq);
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	int ret;
+	unsigned long irqflags;
+
+	/* CSI2RX Init */
+	ret = viif_csi2rx_initialize(viif_dev);
+	if (ret)
+		return ret;
+
+	/* CSI2RX start streaming */
+	ret = v4l2_subdev_call(viif_sd->v4l2_sd, video, s_stream, 1);
+	if (ret) {
+		dev_err(viif_dev->dev, "Start subdev stream failed. %d\n", ret);
+		goto err;
+	}
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+
+	viif_csi2rx_start(viif_dev);
+	viif_dev->sequence = 0;
+
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	return ret;
+err:
+	hwd_VIIF_csi2rx_uninitialize(viif_dev->ch);
+	return ret;
+}
+
+static void viif_stop_streaming(struct vb2_queue *vq)
+{
+	struct viif_device *viif_dev = vb2_get_drv_priv(vq);
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct viif_buffer *buf;
+	unsigned long irqflags;
+	int ret;
+
+	spin_lock_irqsave(&viif_dev->lock, irqflags);
+	(void)viif_csi2rx_stop(viif_dev);
+
+	viif_dev->active = NULL;
+	if (viif_dev->dma_active) {
+		vb2_buffer_done(&viif_dev->dma_active->vb2_buf, VB2_BUF_STATE_ERROR);
+		viif_dev->buf_cnt--;
+		viif_dev->dma_active = NULL;
+	}
+	if (viif_dev->last_active) {
+		vb2_buffer_done(&viif_dev->last_active->vb2_buf, VB2_BUF_STATE_ERROR);
+		viif_dev->buf_cnt--;
+		viif_dev->last_active = NULL;
+	}
+
+	/* Release all queued buffers. */
+	list_for_each_entry (buf, &viif_dev->capture, queue) {
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+		viif_dev->buf_cnt--;
+	}
+	INIT_LIST_HEAD(&viif_dev->capture);
+	if (viif_dev->buf_cnt)
+		dev_err(viif_dev->dev, "Buffer count error %d\n", viif_dev->buf_cnt);
+
+	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
+
+	ret = v4l2_subdev_call(viif_sd->v4l2_sd, video, s_stream, 0);
+	if (ret)
+		dev_err(viif_dev->dev, "Stop subdev stream failed. %d\n", ret);
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
+/* --- Video Device IOCTLs --- */
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
+int viif_querycap(struct file *file, void *priv, struct v4l2_capability *cap)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+
+	strscpy(cap->card, "Toshiba VIIF", sizeof(cap->card));
+	strscpy(cap->driver, DRIVER_NAME, sizeof(cap->driver));
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:toshiba-viif-%s",
+		 dev_name(viif_dev->dev));
+	return 0;
+}
+
+static int viif_enum_fmt_vid_cap(struct file *file, void *priv, struct v4l2_fmtdesc *f)
+{
+	const struct viif_fmt *fmt;
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
+static int viif_try_fmt(struct viif_device *viif_dev, struct v4l2_format *v4l2_fmt)
+{
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct v4l2_pix_format_mplane *pix = &v4l2_fmt->fmt.pix_mp;
+	struct v4l2_subdev *v4l2_sd = viif_sd->v4l2_sd;
+	struct v4l2_subdev_pad_config pad_cfg;
+	struct v4l2_subdev_state pad_state = {
+		.pads = &pad_cfg,
+	};
+	const struct viif_fmt *viif_fmt;
+	int ret;
+
+	struct v4l2_subdev_format sd_format = {
+		.which = V4L2_SUBDEV_FORMAT_TRY,
+	};
+
+	viif_fmt = get_viif_fmt_from_fourcc(pix->pixelformat);
+	if (!viif_fmt)
+		return -EINVAL;
+
+	if (viif_dev->l2_crop_set_flag) {
+		if ((pix->width != viif_dev->l2_crop_param.w) ||
+		    (pix->height != viif_dev->l2_crop_param.h))
+			return -EINVAL;
+	} else {
+		sd_format.format.code = viif_sd->mbus_code;
+		v4l2_fill_mbus_format_mplane(&sd_format.format, pix);
+		ret = v4l2_subdev_call(v4l2_sd, pad, set_fmt, &pad_state, &sd_format);
+		if (ret) {
+			dev_err(viif_dev->dev, "subdev: set_fmt(TRY) error. %d\n", ret);
+			return ret;
+		}
+		v4l2_fill_pix_format_mplane(pix, &sd_format.format);
+	}
+
+	viif_calc_plane_sizes(viif_fmt, pix);
+
+	return 0;
+}
+
+static int viif_try_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+
+	return viif_try_fmt(viif_dev, f);
+}
+
+static int viif_s_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+	struct viif_subdev *viif_sd = viif_dev->sd;
+	struct v4l2_subdev *v4l2_sd = viif_sd->v4l2_sd;
+	int ret = 0;
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+
+	if (vb2_is_streaming(&viif_dev->vb2_vq))
+		return -EBUSY;
+
+	if (f->type != viif_dev->vb2_vq.type)
+		return -EINVAL;
+
+	ret = viif_try_fmt(viif_dev, f);
+	if (ret)
+		return ret;
+
+	if (!viif_dev->l2_crop_set_flag) {
+		format.format.code = viif_sd->mbus_code;
+		v4l2_fill_mbus_format_mplane(&format.format, &f->fmt.pix_mp);
+		ret = v4l2_subdev_call(v4l2_sd, pad, set_fmt, NULL, &format);
+		if (ret) {
+			dev_err(viif_dev->dev, "subdev: set_fmt(ACTIVE) error. %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = viif_main_set_unit(viif_dev);
+	if (ret)
+		return ret;
+
+	viif_dev->v4l2_pix = f->fmt.pix_mp;
+	viif_dev->field = V4L2_FIELD_NONE;
+
+	return viif_l2_set_format(viif_dev);
+}
+
+static int viif_g_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+
+	f->fmt.pix_mp = viif_dev->v4l2_pix;
+
+	return 0;
+}
+
+static int viif_enum_input(struct file *file, void *priv, struct v4l2_input *inp)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
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
+	struct viif_device *viif_dev = video_drvdata(file);
+
+	*i = viif_dev->sd_index;
+
+	return 0;
+}
+
+static int viif_s_input(struct file *file, void *priv, unsigned int i)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+
+	if (i >= viif_dev->num_sd)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int viif_dv_timings_cap(struct file *file, void *priv_fh, struct v4l2_dv_timings_cap *cap)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, dv_timings_cap, cap);
+}
+
+static int viif_enum_dv_timings(struct file *file, void *priv_fh,
+				struct v4l2_enum_dv_timings *timings)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, enum_dv_timings, timings);
+}
+
+static int viif_g_dv_timings(struct file *file, void *priv_fh, struct v4l2_dv_timings *timings)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, video, g_dv_timings, timings);
+}
+
+static int viif_s_dv_timings(struct file *file, void *priv_fh, struct v4l2_dv_timings *timings)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, video, s_dv_timings, timings);
+}
+
+static int viif_query_dv_timings(struct file *file, void *priv_fh, struct v4l2_dv_timings *timings)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, video, query_dv_timings, timings);
+}
+
+static int viif_g_edid(struct file *file, void *fh, struct v4l2_edid *edid)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, get_edid, edid);
+}
+
+static int viif_s_edid(struct file *file, void *fh, struct v4l2_edid *edid)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+	struct viif_subdev *viif_sd = viif_dev->sd;
+
+	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, set_edid, edid);
+}
+
+static int viif_g_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+
+	return v4l2_g_parm_cap(video_devdata(file), viif_dev->sd->v4l2_sd, a);
+}
+
+static int viif_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+
+	return v4l2_s_parm_cap(video_devdata(file), viif_dev->sd->v4l2_sd, a);
+}
+
+static int viif_enum_framesizes(struct file *file, void *fh, struct v4l2_frmsizeenum *fsize)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
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
+	struct viif_device *viif_dev = video_drvdata(file);
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
+	.vidioc_default = viif_ioctl_default,
+	.vidioc_log_status = v4l2_ctrl_log_status,
+	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
+};
+
+/* --- File Operations --- */
+static int viif_open(struct file *file)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+	int ret, mask;
+
+	ret = v4l2_fh_open(file);
+	if (ret)
+		return ret;
+
+	viif_dev->rawpack_mode = HWD_VIIF_RAWPACK_DISABLE;
+	viif_dev->l2_crop_set_flag = false;
+	memset(&viif_dev->l2_crop_param, 0, sizeof(struct viif_l2_crop_config));
+
+	mutex_lock(&viif_dev->mlock);
+
+	/* Initialize HWD driver */
+	viif_hw_on(viif_dev);
+
+	/* VSYNC mask setting of MAIN unit */
+	mask = 0x00050003;
+	hwd_VIIF_main_vsync_set_irq_mask(viif_dev->ch, &mask);
+
+	/* STATUS error mask setting(unmask) of MAIN unit */
+	mask = 0x01000000;
+	hwd_VIIF_main_status_err_set_irq_mask(viif_dev->ch, &mask);
+
+	mutex_unlock(&viif_dev->mlock);
+
+	return ret;
+}
+
+static int viif_release(struct file *file)
+{
+	struct viif_device *viif_dev = video_drvdata(file);
+	int ret;
+
+	ret = vb2_fop_release(file);
+	if (ret)
+		return ret;
+
+	mutex_lock(&viif_dev->mlock);
+	viif_hw_off(viif_dev);
+	mutex_unlock(&viif_dev->mlock);
+
+	return 0;
+}
+
+static const struct v4l2_file_operations viif_fops = {
+	.owner = THIS_MODULE,
+	.open = viif_open,
+	.release = viif_release,
+	.unlocked_ioctl = video_ioctl2,
+	.mmap = vb2_fop_mmap,
+	.poll = vb2_fop_poll,
+};
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
+static int visconti_viif_notify_complete(struct v4l2_async_notifier *notifier)
+{
+	struct v4l2_device *v4l2_dev = notifier->v4l2_dev;
+	struct viif_device *viif_dev = v4l2_to_viif(v4l2_dev);
+	struct video_device *vdev = &viif_dev->vdev;
+	struct vb2_queue *q = &viif_dev->vb2_vq;
+	struct v4l2_subdev *v4l2_sd;
+	int ret;
+
+	ret = v4l2_device_register_subdev_nodes(v4l2_dev);
+	if (ret < 0) {
+		dev_err(v4l2_dev->dev, "Failed to register subdev nodes\n");
+		return ret;
+	}
+
+	/* Initialize vb2 queue. */
+	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	q->io_modes = VB2_DMABUF;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->ops = &viif_vb2_ops;
+	q->mem_ops = &vb2_dma_contig_memops;
+	q->drv_priv = viif_dev;
+	q->buf_struct_size = sizeof(struct viif_buffer);
+	q->min_buffers_needed = 2;
+	q->lock = &viif_dev->mlock;
+	q->dev = viif_dev->v4l2_dev.dev;
+
+	ret = vb2_queue_init(q);
+	if (ret)
+		return ret;
+
+	/* Make sure at least one sensor is primary and use it to initialize */
+	if (!viif_dev->sd) {
+		viif_dev->sd = &viif_dev->subdevs[0];
+		viif_dev->sd_index = 0;
+	}
+
+	v4l2_sd = viif_dev->sd->v4l2_sd;
+
+	ret = viif_init_mbus_code(viif_dev);
+	if (ret)
+		return ret;
+
+	/* Register the video device. */
+	strscpy(vdev->name, DRIVER_NAME, sizeof(vdev->name));
+	vdev->v4l2_dev = v4l2_dev;
+	vdev->lock = &viif_dev->mlock;
+	vdev->queue = &viif_dev->vb2_vq;
+	vdev->ctrl_handler = v4l2_sd->ctrl_handler;
+	vdev->fops = &viif_fops;
+	vdev->ioctl_ops = &viif_ioctl_ops;
+	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE | V4L2_CAP_STREAMING;
+	vdev->release = video_device_release_empty;
+	video_set_drvdata(vdev, viif_dev);
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	if (ret < 0) {
+		dev_err(v4l2_dev->dev, "video_register_device failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct v4l2_async_notifier_operations viif_notify_ops = {
+	.bound = visconti_viif_notify_bound,
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
+		.data = (void *)VIIF_DEV_CSI,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, visconti_viif_of_table);
+
+static int visconti_viif_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct viif_device *viif_dev;
+	int ret, i, num_sd;
+	dma_addr_t table_paddr;
+	const struct of_device_id *of_id;
+
+	//ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
+	//if (ret)
+	//	return ret;
+
+	viif_dev = devm_kzalloc(dev, sizeof(*viif_dev), GFP_KERNEL);
+	if (!viif_dev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, viif_dev);
+	viif_dev->dev = dev;
+
+	INIT_LIST_HEAD(&viif_dev->capture);
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
+	for (i = 0; i < 3; i++) {
+		viif_dev->irq[i] = ret = platform_get_irq(pdev, i);
+		if (ret < 0) {
+			dev_err(dev, "failed to acquire irq resource\n");
+			return ret;
+		}
+		ret = devm_request_irq(dev, viif_dev->irq[i], visconti_viif_irq, 0, "viif",
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
+	ret = v4l2_device_register(dev, &viif_dev->v4l2_dev);
+	if (ret)
+		goto error_dma_free;
+
+	/* check device type */
+	of_id = of_match_device(visconti_viif_of_table, dev);
+	viif_dev->dev_type = (enum viif_dev_type)of_id->data;
+
+	num_sd = visconti_viif_parse_dt(viif_dev);
+	if (ret < 0) {
+		ret = num_sd;
+		goto error_v4l2_unregister;
+	}
+
+	viif_dev->notifier.v4l2_dev = &viif_dev->v4l2_dev;
+	v4l2_async_nf_init(&viif_dev->notifier);
+	for (i = 0; i < num_sd; i++) {
+		__v4l2_async_nf_add_subdev(&viif_dev->notifier, viif_dev->asds[i]);
+	}
+	//viif_dev->notifier.subdevs = viif_dev->asds;
+	//viif_dev->notifier.num_subdevs = num_sd;
+	viif_dev->notifier.ops = &viif_notify_ops;
+	ret = v4l2_async_nf_register(&viif_dev->v4l2_dev, &viif_dev->notifier);
+	if (ret)
+		goto error_v4l2_unregister;
+
+	return 0;
+
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
+	v4l2_async_nf_unregister(&viif_dev->notifier);
+	v4l2_device_unregister(&viif_dev->v4l2_dev);
+	video_unregister_device(&viif_dev->vdev);
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
index 000000000..ef1b7ae16
--- /dev/null
+++ b/drivers/media/platform/visconti/viif.h
@@ -0,0 +1,134 @@
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
+
+enum viif_dev_type {
+	VIIF_DEV_CSI,
+	VIIF_DEV_M2M,
+};
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
+	unsigned int bpp;
+	unsigned int num_lane;
+};
+
+struct viif_table_area {
+	/* viif_l1_dpc_config */
+	uint32_t dpc_table_h[8192 / 4];
+	uint32_t dpc_table_m[8192 / 4];
+	uint32_t dpc_table_l[8192 / 4];
+	/* viif_l1_lsc_config */
+	uint16_t lsc_table_gr[1536 / 2];
+	uint16_t lsc_table_r[1536 / 2];
+	uint16_t lsc_table_b[1536 / 2];
+	uint16_t lsc_table_gb[1536 / 2];
+	/* viif_l2_undist_config */
+	uint32_t undist_write_g[8192 / 4];
+	uint32_t undist_read_b[8192 / 4];
+	uint32_t undist_read_g[8192 / 4];
+	uint32_t undist_read_r[8192 / 4];
+	/* viif_l2_gamma_config */
+	uint16_t l2_gamma_table[6][512 / 2];
+};
+
+/* --- m2m structgure --- */
+struct viif_device {
+	struct device *dev;
+	struct video_device vdev;
+	struct v4l2_device v4l2_dev;
+	unsigned int ch;
+	enum viif_dev_type dev_type;
+	uint32_t masked_gamma_path;
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
+	/* vb2 queue, capture buffer list and active buffer pointer */
+	struct vb2_queue vb2_vq;
+	struct list_head capture;
+	struct vb2_v4l2_buffer *active;
+	struct vb2_v4l2_buffer *dma_active;
+	struct vb2_v4l2_buffer *last_active;
+	int buf_cnt;
+	unsigned int sequence;
+
+	/* lock - lock access to capture buffer queue and active buffer */
+	spinlock_t lock;
+
+	struct mutex mlock;
+
+	void __iomem *capture_reg; /* vaddr of CSI2HOST register */
+	void __iomem *csi2host_reg; /* vaddr of CAPTURE register */
+	unsigned int irq[4];
+
+	/* currently configured field and pixel format */
+	enum v4l2_field field;
+	struct v4l2_pix_format_mplane v4l2_pix;
+	bool mbus_is_rgb;
+	unsigned int out_format;
+	struct hwd_viif_img_area img_area;
+	struct hwd_viif_out_process out_process;
+
+	uint32_t pixel_clock;
+
+	/* L2 Crop setting */
+	struct viif_l2_crop_config l2_crop_param;
+	bool l2_crop_set_flag;
+
+	/* Un-cache table area */
+	struct viif_table_area *table_vaddr;
+	struct viif_table_area *table_paddr;
+
+	/* Rawpack mode */
+	uint32_t rawpack_mode;
+
+	/* Status error info */
+	uint32_t status_err;
+};
+
+#endif /* VIIF_H */
diff --git a/include/uapi/linux/visconti_viif.h b/include/uapi/linux/visconti_viif.h
new file mode 100644
index 000000000..14e6b176c
--- /dev/null
+++ b/include/uapi/linux/visconti_viif.h
@@ -0,0 +1,1683 @@
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
+/* Private IPCTLs */
+#define VIDIOC_VIIF_MAIN_SET_RAWPACK_MODE                                      \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 1, uint32_t)
+#define VIDIOC_VIIF_L1_SET_INPUT_MODE                                          \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 2, struct viif_l1_input_mode_config)
+#define VIDIOC_VIIF_L1_SET_RGB_TO_Y_COEF                                       \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 3, struct viif_l1_rgb_to_y_coef_config)
+#define VIDIOC_VIIF_L1_SET_AG_MODE                                             \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 4, struct viif_l1_ag_mode_config)
+#define VIDIOC_VIIF_L1_SET_AG                                                  \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 5, struct viif_l1_ag_config)
+#define VIDIOC_VIIF_L1_SET_HDRE                                                \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 6, struct viif_l1_hdre_config)
+#define VIDIOC_VIIF_L1_SET_IMG_EXTRACTION                                      \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 7, struct viif_l1_img_extraction_config)
+#define VIDIOC_VIIF_L1_SET_DPC                                                 \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 8, struct viif_l1_dpc_config)
+#define VIDIOC_VIIF_L1_SET_PRESET_WHITE_BALANCE                                \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 9,                                     \
+	     struct viif_l1_preset_white_balance_config)
+#define VIDIOC_VIIF_L1_SET_RAW_COLOR_NOISE_REDUCTION                           \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 10,                                    \
+	     struct viif_l1_raw_color_noise_reduction_config)
+#define VIDIOC_VIIF_L1_SET_HDRS                                                \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 11, struct viif_l1_hdrs_config)
+#define VIDIOC_VIIF_L1_SET_BLACK_LEVEL_CORRECTION                              \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 12,                                    \
+	     struct viif_l1_black_level_correction_config)
+#define VIDIOC_VIIF_L1_SET_LSC                                                 \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 13, struct viif_l1_lsc_config)
+#define VIDIOC_VIIF_L1_SET_MAIN_PROCESS                                        \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 14, struct viif_l1_main_process_config)
+#define VIDIOC_VIIF_L1_SET_AWB                                                 \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 15, struct viif_l1_awb_config)
+#define VIDIOC_VIIF_L1_LOCK_AWB_GAIN                                           \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 16, uint32_t)
+#define VIDIOC_VIIF_L1_SET_HDRC                                                \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 17, struct viif_l1_hdrc_config)
+#define VIDIOC_VIIF_L1_SET_HDRC_LTM                                            \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 18, struct viif_l1_hdrc_ltm_config)
+#define VIDIOC_VIIF_L1_SET_GAMMA                                               \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 19, struct viif_l1_gamma_config)
+#define VIDIOC_VIIF_L1_SET_IMG_QUALITY_ADJUSTMENT                              \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 20,                                    \
+	     struct viif_l1_img_quality_adjustment_config)
+#define VIDIOC_VIIF_L2_SET_UNDIST                                              \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 21, struct viif_l2_undist_config)
+#define VIDIOC_VIIF_L2_SET_ROI                                                 \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 22, struct viif_l2_roi_config)
+#define VIDIOC_VIIF_L2_SET_GAMMA                                               \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 23, struct viif_l2_gamma_config)
+#define VIDIOC_VIIF_L2_SET_CROP                                                \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 24, struct viif_l2_crop_config)
+#define VIDIOC_VIIF_CSI2RX_SET_MBUS_FMT                                        \
+	_IOW('V', BASE_VIDIOC_PRIVATE + 25, uint32_t)
+#define VIDIOC_VIIF_CSI2RX_GET_CALIBRATION_STATUS                              \
+	_IOR('V', BASE_VIDIOC_PRIVATE + 26,                                    \
+	     struct viif_csi2rx_dphy_calibration_status)
+#define VIDIOC_VIIF_CSI2RX_GET_ERR_STATUS                                      \
+	_IOR('V', BASE_VIDIOC_PRIVATE + 27, struct viif_csi2rx_err_status)
+#define VIDIOC_VIIF_ISP_GET_LAST_CAPTURE_STATUS                                \
+	_IOR('V', BASE_VIDIOC_PRIVATE + 28, struct viif_isp_capture_status)
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
+ * for :ref:`VIDIOC_VIIF_L1_SET_INPUT_MODE`
+ * @mode: :ref:`L1ISP pre-processing mode <L1ISP_preprocessing_mode>`
+ * @depth: Color depth (even only). Range for each L1ISP pre-processing mode is as below:
+ * - VIIF_L1_INPUT_HDR/HDR_IMG_CORRECT: Range: [8..24].
+ * - VIIF_L1_INPUT_PWL/PWL_IMG_CORRECT: Range: [8..14].
+ * @raw_color_filter: :ref:`RAW color filter mode <L1ISP_RAW_color_filter_mode>`
+ */
+struct viif_l1_input_mode_config {
+	uint32_t mode;
+	uint32_t depth;
+	uint32_t raw_color_filter;
+};
+
+/**
+ * struct viif_l1_rgb_to_y_coef_config - L1ISP coefficient for calculating
+ * Y from RGB parameters for :ref:`VIDIOC_VIIF_L1_SET_RGB_TO_Y_COEF`
+ * @coef_r: R co-efficient [256..65024] accuracy: 1/65536
+ * @coef_g: R co-efficient [256..65024] accuracy: 1/65536
+ * @coef_b: R co-efficient [256..65024] accuracy: 1/65536
+ */
+struct viif_l1_rgb_to_y_coef_config {
+	uint16_t coef_r;
+	uint16_t coef_g;
+	uint16_t coef_b;
+};
+
+/** enum viif_l1_img_sensitivity_mode - L1ISP image sensitivity
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
+ * for :ref:`VIDIOC_VIIF_L1_SET_AG_MODE`
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
+ * @sysm_ag_ssel_lssc: Sensitive image used for LSC.
+ *                     Refer to :ref:`L1ISP_image_sensitivity`
+ * @sysm_ag_psel_lssc: Analog gain id for LSC [0..3]
+ * @sysm_ag_cont_mpro_en: 1:enable/0:disable to control analog gain for color matrix
+ * @sysm_ag_ssel_mpro: Sensitive image used for color matrix.
+ *                     Refer to :ref:`L1ISP_image_sensitivity`
+ * @sysm_ag_psel_mpro:Aanalog gain id for color matrix [0..3]
+ * @sysm_ag_cont_vpro_en: 1:enable/0:disable to control analog gain for image adjustment
+ * @sysm_ag_ssel_vpro: Sensitive image used for image adjustment.
+ *                     Refer to :ref:`L1ISP_image_sensitivity`
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
+	uint8_t sysm_ag_grad[4];
+	uint16_t sysm_ag_ofst[4];
+	uint32_t sysm_ag_cont_hobc_en_high;
+	uint32_t sysm_ag_psel_hobc_high;
+	uint32_t sysm_ag_cont_hobc_en_middle_led;
+	uint32_t sysm_ag_psel_hobc_middle_led;
+	uint32_t sysm_ag_cont_hobc_en_low;
+	uint32_t sysm_ag_psel_hobc_low;
+	uint32_t sysm_ag_cont_abpc_en_high;
+	uint32_t sysm_ag_psel_abpc_high;
+	uint32_t sysm_ag_cont_abpc_en_middle_led;
+	uint32_t sysm_ag_psel_abpc_middle_led;
+	uint32_t sysm_ag_cont_abpc_en_low;
+	uint32_t sysm_ag_psel_abpc_low;
+	uint32_t sysm_ag_cont_rcnr_en_high;
+	uint32_t sysm_ag_psel_rcnr_high;
+	uint32_t sysm_ag_cont_rcnr_en_middle_led;
+	uint32_t sysm_ag_psel_rcnr_middle_led;
+	uint32_t sysm_ag_cont_rcnr_en_low;
+	uint32_t sysm_ag_psel_rcnr_low;
+	uint32_t sysm_ag_cont_lssc_en;
+	uint32_t sysm_ag_ssel_lssc;
+	uint32_t sysm_ag_psel_lssc;
+	uint32_t sysm_ag_cont_mpro_en;
+	uint32_t sysm_ag_ssel_mpro;
+	uint32_t sysm_ag_psel_mpro;
+	uint32_t sysm_ag_cont_vpro_en;
+	uint32_t sysm_ag_ssel_vpro;
+	uint32_t sysm_ag_psel_vpro;
+	uint8_t sysm_ag_cont_hobc_test_high;
+	uint8_t sysm_ag_cont_hobc_test_middle_led;
+	uint8_t sysm_ag_cont_hobc_test_low;
+	uint8_t sysm_ag_cont_abpc_test_high;
+	uint8_t sysm_ag_cont_abpc_test_middle_led;
+	uint8_t sysm_ag_cont_abpc_test_low;
+	uint8_t sysm_ag_cont_rcnr_test_high;
+	uint8_t sysm_ag_cont_rcnr_test_middle_led;
+	uint8_t sysm_ag_cont_rcnr_test_low;
+	uint8_t sysm_ag_cont_lssc_test;
+	uint8_t sysm_ag_cont_mpro_test;
+	uint8_t sysm_ag_cont_vpro_test;
+};
+
+/**
+ * struct viif_l1_ag_config - L1ISP AG parameters
+ * for :ref:`VIDIOC_VIIF_L1_SET_AG`
+ * @gain_h: Analog gain for high sensitive image [0..65535]
+ * @gain_m: Analog gain for middle sensitive image or LED image [0..65535]
+ * @gain_l: Analog gain for low sensitive image [0..65535]
+ */
+struct viif_l1_ag_config {
+	uint16_t gain_h;
+	uint16_t gain_m;
+	uint16_t gain_l;
+};
+
+/**
+ * struct viif_l1_hdre_config - L1ISP HDRE parameters
+ * for :ref:`VIDIOC_VIIF_L1_SET_HDRE`
+ * @hdre_src_point: Knee point N value of PWL compressed signal [0..0x3FFF]
+ * @hdre_dst_base: Offset value of HDR signal in Knee area M [0..0xFFFFFF]
+ * @hdre_ratio: Slope of output pixel value in Knee area M
+ *              [0..0x3FFFFF], accuracy: 1/64
+ * @hdre_dst_max_val: Maximum value of output pixel [0..0xFFFFFF]
+ */
+struct viif_l1_hdre_config {
+	uint32_t hdre_src_point[16];
+	uint32_t hdre_dst_base[17];
+	uint32_t hdre_ratio[17];
+	uint32_t hdre_dst_max_val;
+};
+
+/**
+ * struct viif_l1_img_extraction_config -  L1ISP image extraction parameters
+ * for :ref:`VIDIOC_VIIF_L1_SET_IMG_EXTRACTION`
+ * @input_black_gr: Black level of input pixel (Gr) [0..0xFFFFFF]
+ * @input_black_r: Black level of input pixel (R) [0..0xFFFFFF]
+ * @input_black_b: Black level of input pixel (B) [0..0xFFFFFF]
+ * @input_black_gb: Black level of input pixel (Gb) [0..0xFFFFFF]
+ */
+struct viif_l1_img_extraction_config {
+	uint32_t input_black_gr;
+	uint32_t input_black_r;
+	uint32_t input_black_b;
+	uint32_t input_black_gb;
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
+ * @abpc_dyn_mode: :ref:`Dynamic DPC mode <L1ISP_dynamic_defect_pixel_correction_mode>`
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
+	uint32_t abpc_sta_en;
+	uint32_t abpc_dyn_en;
+	uint32_t abpc_dyn_mode;
+	uint32_t abpc_ratio_limit;
+	uint32_t abpc_dark_limit;
+	uint32_t abpc_sn_coef_w_ag_min;
+	uint32_t abpc_sn_coef_w_ag_mid;
+	uint32_t abpc_sn_coef_w_ag_max;
+	uint32_t abpc_sn_coef_b_ag_min;
+	uint32_t abpc_sn_coef_b_ag_mid;
+	uint32_t abpc_sn_coef_b_ag_max;
+	uint8_t abpc_sn_coef_w_th_min;
+	uint8_t abpc_sn_coef_w_th_max;
+	uint8_t abpc_sn_coef_b_th_min;
+	uint8_t abpc_sn_coef_b_th_max;
+};
+/**
+ * struct viif_l1_dpc - L1ISP defect pixel correction parameters
+ * for :ref:`VIDIOC_VIIF_L1_SET_DPC`
+ * @param_h: DPC parameter for high sensitive image. Refer to &struct viif_l1_dpc
+ * @param_m: DPC parameter for middle sensitive image. Refer to &struct viif_l1_dpc
+ * @param_l: DPC parameter for low sensitive image. Refer to &struct viif_l1_dpc
+ * @table_h: DPC table address for high sensitive image.
+ *           Table is not transferred if a NULL pointer is set
+ * @table_m: DPC table address for middle sensitive image or LED image
+ *           Table is not transferred if a NULL pointer is set
+ * @table_l: DPC table address for low sensitive image
+ *           Table is not transferred if a NULL pointer is set
+ *
+ * The size of each table is fixed at 8192 Byte.
+ * Application should make sure that the table data is based on HW specification
+ * since this driver does not check the DPC table.
+ */
+struct viif_l1_dpc_config {
+	struct viif_l1_dpc param_h;
+	struct viif_l1_dpc param_m;
+	struct viif_l1_dpc param_l;
+	uint32_t *table_h;
+	uint32_t *table_m;
+	uint32_t *table_l;
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
+	uint32_t gain_gr;
+	uint32_t gain_r;
+	uint32_t gain_b;
+	uint32_t gain_gb;
+};
+/**
+ * struct viif_l1_preset_white_balance_config - L1ISP  preset white balance
+ * parameters for :ref:`VIDIOC_VIIF_L1_SET_PRESET_WHITE_BALANCE`
+ * @dstmaxval: Maximum value of output pixel [pixel] [0..4095]
+ * @param_h: Preset white balance parameter for high sensitive image.
+ *           Refer to &struct viif_l1_preset_wb
+ * @param_m: Preset white balance parameters for middle sensitive image or LED image.
+ *           Refer to &struct viif_l1_preset_wb
+ * @param_l: Preset white balance parameters for low sensitive image.
+ *           Refer to &struct viif_l1_preset_wb
+ */
+struct viif_l1_preset_white_balance_config {
+	uint32_t dstmaxval;
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
+ * @rcnr_hry_type: Filter type for HSF filter process.
+ *                 Refer to :ref:`L1ISP_high_resolution_luminance_filter_type`
+ * @rcnr_anf_blend_ag0: Maximum value of MSF result blend ratio in write back data to line memory.
+ *                      Refer to :ref:`L1ISP_MSF_blend_ratio`
+ * @rcnr_anf_blend_ag1: Middle value of MSF result blend ratio in write back data to line memory.
+ *                      Refer to :ref:`L1ISP_MSF_blend_ratio`
+ * @rcnr_anf_blend_ag2: Minimum value of MSF result blend ratio in write back data to line memory.
+ *                      Refer to :ref:`L1ISP_MSF_blend_ratio`
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
+	uint32_t rcnr_sw;
+	uint32_t rcnr_cnf_dark_ag0;
+	uint32_t rcnr_cnf_dark_ag1;
+	uint32_t rcnr_cnf_dark_ag2;
+	uint32_t rcnr_cnf_ratio_ag0;
+	uint32_t rcnr_cnf_ratio_ag1;
+	uint32_t rcnr_cnf_ratio_ag2;
+	uint32_t rcnr_cnf_clip_gain_r;
+	uint32_t rcnr_cnf_clip_gain_g;
+	uint32_t rcnr_cnf_clip_gain_b;
+	uint32_t rcnr_a1l_dark_ag0;
+	uint32_t rcnr_a1l_dark_ag1;
+	uint32_t rcnr_a1l_dark_ag2;
+	uint32_t rcnr_a1l_ratio_ag0;
+	uint32_t rcnr_a1l_ratio_ag1;
+	uint32_t rcnr_a1l_ratio_ag2;
+	uint32_t rcnr_inf_zero_clip;
+	uint32_t rcnr_merge_d2blend_ag0;
+	uint32_t rcnr_merge_d2blend_ag1;
+	uint32_t rcnr_merge_d2blend_ag2;
+	uint32_t rcnr_merge_black;
+	uint32_t rcnr_merge_mindiv;
+	uint32_t rcnr_hry_type;
+	uint32_t rcnr_anf_blend_ag0;
+	uint32_t rcnr_anf_blend_ag1;
+	uint32_t rcnr_anf_blend_ag2;
+	uint32_t rcnr_lpf_threshold;
+	uint32_t rcnr_merge_hlblend_ag0;
+	uint32_t rcnr_merge_hlblend_ag1;
+	uint32_t rcnr_merge_hlblend_ag2;
+	uint32_t rcnr_gnr_sw;
+	uint32_t rcnr_gnr_ratio;
+	uint32_t rcnr_gnr_wide_en;
+};
+/**
+ * struct viif_l1_raw_color_noise_reduction_config - L1ISP RCNR parameters
+ * for :ref:`VIDIOC_VIIF_L1_SET_RAW_COLOR_NOISE_REDUCTION`
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
+ * for :ref:`VIDIOC_VIIF_L1_SET_HDRS`
+ * @hdrs_hdr_mode: Use/No use settings of middle sensitivity image in HDRS.
+ *                 :ref:`L1ISP HDR setting <L1ISP_HDR_setting>`
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
+	uint32_t hdrs_hdr_mode;
+	uint32_t hdrs_hdr_ratio_m;
+	uint32_t hdrs_hdr_ratio_l;
+	uint32_t hdrs_hdr_ratio_e;
+	uint32_t hdrs_dg_h;
+	uint32_t hdrs_dg_m;
+	uint32_t hdrs_dg_l;
+	uint32_t hdrs_dg_e;
+	uint32_t hdrs_blendend_h;
+	uint32_t hdrs_blendend_m;
+	uint32_t hdrs_blendend_e;
+	uint32_t hdrs_blendbeg_h;
+	uint32_t hdrs_blendbeg_m;
+	uint32_t hdrs_blendbeg_e;
+	uint32_t hdrs_led_mode_on;
+	uint32_t hdrs_dst_max_val;
+};
+
+/**
+ * struct viif_l1_black_level_correction_config -  L1ISP image level conversion
+ * parameters for :ref:`VIDIOC_VIIF_L1_SET_BLACK_LEVEL_CORRECTION`
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
+	uint32_t srcblacklevel_gr;
+	uint32_t srcblacklevel_r;
+	uint32_t srcblacklevel_b;
+	uint32_t srcblacklevel_gb;
+	uint32_t mulval_gr;
+	uint32_t mulval_r;
+	uint32_t mulval_b;
+	uint32_t mulval_gb;
+	uint32_t dstmaxval;
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
+	int16_t lssc_paracoef_h_l_max;
+	int16_t lssc_paracoef_h_l_min;
+	int16_t lssc_paracoef_h_r_max;
+	int16_t lssc_paracoef_h_r_min;
+	int16_t lssc_paracoef_v_u_max;
+	int16_t lssc_paracoef_v_u_min;
+	int16_t lssc_paracoef_v_d_max;
+	int16_t lssc_paracoef_v_d_min;
+	int16_t lssc_paracoef_hv_lu_max;
+	int16_t lssc_paracoef_hv_lu_min;
+	int16_t lssc_paracoef_hv_ru_max;
+	int16_t lssc_paracoef_hv_ru_min;
+	int16_t lssc_paracoef_hv_ld_max;
+	int16_t lssc_paracoef_hv_ld_min;
+	int16_t lssc_paracoef_hv_rd_max;
+	int16_t lssc_paracoef_hv_rd_min;
+};
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
+ * @lssc_para_mgsel2: Parabola 2D correction coefficient gain magnification ratio.
+ *                    Refer to :ref:`L1ISP_parabola_shading_correction_ratio`
+ * @lssc_para_mgsel4: Parabola 4D correction coefficient gain magnification ratio.
+ *                    Refer to :ref:`L1ISP_parabola_shading_correction_ratio`
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
+	uint32_t lssc_para_h_center;
+	uint32_t lssc_para_v_center;
+	uint32_t lssc_para_h_gain;
+	uint32_t lssc_para_v_gain;
+	uint32_t lssc_para_mgsel2;
+	uint32_t lssc_para_mgsel4;
+	struct viif_l1_lsc_parabola_ag_param r_2d;
+	struct viif_l1_lsc_parabola_ag_param r_4d;
+	struct viif_l1_lsc_parabola_ag_param gr_2d;
+	struct viif_l1_lsc_parabola_ag_param gr_4d;
+	struct viif_l1_lsc_parabola_ag_param gb_2d;
+	struct viif_l1_lsc_parabola_ag_param gb_4d;
+	struct viif_l1_lsc_parabola_ag_param b_2d;
+	struct viif_l1_lsc_parabola_ag_param b_4d;
+};
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
+ * @lssc_grid_mgsel: Grid correction coefficient gain value magnification ratio.
+ *                   Refer to :ref:`L1ISP_grid_shading_correction_coefficient_ratio`
+ */
+struct viif_l1_lsc_grid_param {
+	uint32_t lssc_grid_h_size;
+	uint32_t lssc_grid_v_size;
+	uint32_t lssc_grid_h_center;
+	uint32_t lssc_grid_v_center;
+	uint32_t lssc_grid_mgsel;
+};
+/**
+ * struct viif_l1_lsc - L2ISP LSC parameters for &struct viif_l1_lsc_config
+ * @lssc_parabola_param: Pointer to parabola shading correction parameter.
+ *                       Refer to &struct viif_l1_lsc_parabola_param.
+ *                       "NULL: Disable parabola shading correction",
+ *                       "Other: Enable parabola shading correction"
+ * @lssc_grid_param: Pointer to grid shading correction parameter
+ *                   Refer to &struct viif_l1_lsc_grid_param.
+ *                   "NULL: Disable grid shading correction",
+ *                   "Other: Enable grid shading correction"
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
+	struct viif_l1_lsc_parabola_param *lssc_parabola_param;
+	struct viif_l1_lsc_grid_param *lssc_grid_param;
+	uint32_t lssc_pwhb_r_gain_max;
+	uint32_t lssc_pwhb_r_gain_min;
+	uint32_t lssc_pwhb_gr_gain_max;
+	uint32_t lssc_pwhb_gr_gain_min;
+	uint32_t lssc_pwhb_gb_gain_max;
+	uint32_t lssc_pwhb_gb_gain_min;
+	uint32_t lssc_pwhb_b_gain_max;
+	uint32_t lssc_pwhb_b_gain_min;
+};
+/**
+ * struct viif_l1_lsc_config - L2ISP LSC parameters
+ * for :ref:`VIDIOC_VIIF_L1_SET_LSC`
+ * @param: Pointer to LSC parameter. Refer to &struct viif_l1_lsc
+ *         "NULL: Disable LSC", "Other: Enable LSC"
+ * @table_gr: Grid table address for LSC of Gr.
+ *            Table is not transferred if a NULL pointer is set
+ * @table_r: Grid table address for LSC of R.
+ *           Table is not transferred if a NULL pointer is set
+ * @table_b: Grid table address for LSC of B.
+ *           Table is not transferred if a NULL pointer is set
+ * @table_gb: Grid table address for LSC of Gb.
+ *            Table is not transferred if a NULL pointer is set
+ *
+ * The size of each table is fixed to 1,536 Bytes.
+ * Application should make sure that the table data is based on HW specification
+ * since this driver does not check the grid table.
+ */
+struct viif_l1_lsc_config {
+	struct viif_l1_lsc *param;
+	uint16_t *table_gr;
+	uint16_t *table_r;
+	uint16_t *table_b;
+	uint16_t *table_gb;
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
+	int16_t coef_rmg_min;
+	int16_t coef_rmg_max;
+	int16_t coef_rmb_min;
+	int16_t coef_rmb_max;
+	int16_t coef_gmr_min;
+	int16_t coef_gmr_max;
+	int16_t coef_gmb_min;
+	int16_t coef_gmb_max;
+	int16_t coef_bmr_min;
+	int16_t coef_bmr_max;
+	int16_t coef_bmg_min;
+	int16_t coef_bmg_max;
+	uint16_t dst_minval;
+};
+/**
+ * struct viif_l1_main_process_config - L1ISP Main process operating parameters
+ * for :ref:`VIDIOC_VIIF_L1_SET_MAIN_PROCESS`
+ * @demosaic_mode: :ref:`Demosaic mode <L1ISP_demosaic_mode>`
+ * @damp_lsbsel: Clipping range of output pixel value to AWB adjustment function [0..15]
+ * @param: Pointer to color matrix correction parameter.
+ *         Refer to &struct viif_l1_color_matrix_correction.
+ *         "NULL: Disable color matrix correction",
+ *         "Other:  Enable color matrix correction"
+ * @dst_maxval: Maximum value of output pixel [0..0xFFFFFF].
+ *              Applicable to output of each process (digital amplifier,
+ *              demosaicing and color matrix correction) in L1ISP Main process.
+ */
+struct viif_l1_main_process_config {
+	uint32_t demosaic_mode;
+	uint32_t damp_lsbsel;
+	struct viif_l1_color_matrix_correction *param;
+	uint32_t dst_maxval;
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
+ * @VIIF_L1_AWB_RESTART_128FRAME: restart after 128 frame
+ * @VIIF_L1_AWB_RESTART_64FRAME: restart after 64 frame
+ * @VIIF_L1_AWB_RESTART_32FRAME: restart after 32 frame
+ * @VIIF_L1_AWB_RESTART_16FRAME: restart after 16 frame
+ * @VIIF_L1_AWB_RESTART_8FRAME: restart after 8 frame
+ * @VIIF_L1_AWB_RESTART_4FRAME: restart after 4 frame
+ * @VIIF_L1_AWB_RESTART_2FRAME: restart after 2 frame
+ */
+enum viif_l1_awb_restart_cond {
+	VIIF_L1_AWB_RESTART_NO = 0, /* not restart */
+	VIIF_L1_AWB_RESTART_128FRAME = 1, /* restart after 128 frame */
+	VIIF_L1_AWB_RESTART_64FRAME = 2, /* restart after 64 frame */
+	VIIF_L1_AWB_RESTART_32FRAME = 3, /* restart after 32 frame */
+	VIIF_L1_AWB_RESTART_16FRAME = 4, /* restart after 16 frame */
+	VIIF_L1_AWB_RESTART_8FRAME = 5, /* restart after 8 frame */
+	VIIF_L1_AWB_RESTART_4FRAME = 6, /* restart after 4 frame */
+	VIIF_L1_AWB_RESTART_2FRAME = 7, /* restart after 2 frame */
+};
+
+/**
+ * struct viif_l1_awb - L1ISP AWB adjustment parameters
+ * for &struct viif_l1_awb_config
+ * @awhb_ygate_sel: 1:Enable/0:Disable to fix Y value at YUV conversion
+ * @awhb_ygate_data: Y value in case Y value is fixed [64, 128, 256, 512]
+ * @awhb_cgrange: Signal output magnification ratio before AWB adjustment.
+ *                Refer to :ref:`L1ISP_signal_magnification_before_AWB_adjustment`
+ * @awhb_ygatesw: 1:Enable/0:Disable settings of luminance gate
+ * @awhb_hexsw: 1:Enable/0:Disable settings of hexa-gate
+ * @awhb_areamode: Final selection of accumulation area for detection target area.
+ *                 Refer to :ref:`L1ISP_AWB_detection_target_area`
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
+ * @awhb_awbfztim: Condition to restart AWB process.
+ *                 Refer to :ref:`L1ISP_AWB_adjustment_restart_conditions`
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
+	uint32_t awhb_ygate_sel;
+	uint32_t awhb_ygate_data;
+	uint32_t awhb_cgrange;
+	uint32_t awhb_ygatesw;
+	uint32_t awhb_hexsw;
+	uint32_t awhb_areamode;
+	uint32_t awhb_area_hsize;
+	uint32_t awhb_area_vsize;
+	uint32_t awhb_area_hofs;
+	uint32_t awhb_area_vofs;
+	uint32_t awhb_area_maskh;
+	uint32_t awhb_area_maskl;
+	uint32_t awhb_sq_sw[3];
+	uint32_t awhb_sq_pol[3];
+	uint32_t awhb_bycut0p;
+	uint32_t awhb_bycut0n;
+	uint32_t awhb_rycut0p;
+	uint32_t awhb_rycut0n;
+	int32_t awhb_rbcut0h;
+	int32_t awhb_rbcut0l;
+	int32_t awhb_bycut_h[3];
+	uint32_t awhb_bycut_l[3];
+	int32_t awhb_rycut_h[3];
+	uint32_t awhb_rycut_l[3];
+	int32_t awhb_awbsftu;
+	int32_t awhb_awbsftv;
+	uint32_t awhb_awbhuecor;
+	uint32_t awhb_awbspd;
+	uint32_t awhb_awbulv;
+	uint32_t awhb_awbvlv;
+	uint32_t awhb_awbondot;
+	uint32_t awhb_awbfztim;
+	uint8_t awhb_wbgrmax;
+	uint8_t awhb_wbgbmax;
+	uint8_t awhb_wbgrmin;
+	uint8_t awhb_wbgbmin;
+	uint8_t awhb_ygateh;
+	uint8_t awhb_ygatel;
+	uint8_t awhb_awbwait;
+};
+/**
+ * struct viif_l1_awb_config - L1ISP AWB parameters
+ * for :ref:`VIDIOC_VIIF_L1_SET_AWB`
+ * @param: Pointer to AWB adjustment parameter. Refer to &struct viif_l1_awb
+ *         "NULL: Disable AWB adjustment", "Other: Enable AWB adjustment"
+ * @awhb_wbmrg: White balance adjustment R gain [64..1023], accuracy: 1/256
+ * @awhb_wbmgg: White balance adjustment G gain [64..1023], accuracy: 1/256
+ * @awhb_wbmbg: White balance adjustment B gain [64..1023], accuracy: 1/256
+ */
+struct viif_l1_awb_config {
+	struct viif_l1_awb *param;
+	uint32_t awhb_wbmrg;
+	uint32_t awhb_wbmgg;
+	uint32_t awhb_wbmbg;
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
+ * @hdrc_tn_type: :ref:`L1ISP HDRC tone type <L1ISP_HDRC_tone_type>`
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
+	uint32_t hdrc_ratio;
+	uint32_t hdrc_pt_ratio;
+	uint32_t hdrc_pt_blend;
+	uint32_t hdrc_pt_blend2;
+	uint32_t hdrc_tn_type;
+	uint16_t hdrc_utn_tbl[20];
+	uint32_t hdrc_flr_val;
+	uint32_t hdrc_flr_adp;
+	uint32_t hdrc_ybr_off;
+	uint32_t hdrc_orgy_blend;
+	uint16_t hdrc_pt_sat;
+};
+/**
+ * struct viif_l1_hdrc_config - L1ISP HDRC parameters
+ * for :ref:`VIDIOC_VIIF_L1_SET_HDRC`
+ * @param: Pointer to HDRC parameter. Refer to &struct viif_l1_hdrc.
+ *         "NULL: Disable HDRC", "Other: Enable HDRC"
+ * @hdrc_thr_sft_amt: Amount of right shift in through mode (HDRC disabled) [0..8].
+ *                    Should set 0 in case to enable HDRC
+ */
+struct viif_l1_hdrc_config {
+	struct viif_l1_hdrc *param;
+	uint32_t hdrc_thr_sft_amt;
+};
+
+/**
+ * struct viif_l1_hdrc_ltm_config - L1ISP HDRC LTM parameters
+ * for :ref:`VIDIOC_VIIF_L1_SET_HDRC_LTM`
+ * @tnp_max: Tone blend rate maximum value of LTM function
+ *           [0..4194303], accuracy: 1/64. In case of 0, LTM function is OFF
+ * @tnp_mag: Intensity adjustment of LTM function [0..16383], accuracy: 1/64
+ * @tnp_fil: Smoothing filter coefficient [0..255].
+ *           [0]: coef0, [1]: coef1, [2]: coef2, [3]: coef3, [4]: coef4
+ *           EINVAL needs to be returned in the below condition.
+ *           "(coef1 + coef2 + coef3 + coef4) * 2 + coef0 != 1024"
+ */
+struct viif_l1_hdrc_ltm_config {
+	uint32_t tnp_max;
+	uint32_t tnp_mag;
+	uint8_t tnp_fil[5];
+};
+
+/**
+ * struct viif_l1_gamma - L1ISP gamma correction parameters
+ * for &struct viif_l1_gamma_config
+ * @gam_p: Luminance value after gamma correction [0..8191]
+ * @blkadj: Black level adjustment value after gamma correction [0..65535]
+ */
+struct viif_l1_gamma {
+	uint16_t gam_p[44];
+	uint16_t blkadj;
+};
+/**
+ * struct viif_l1_gamma_config - L1ISP gamma correction parameters
+ * @param: Pointer to gamma correction parameter. Refer to &struct viif_l1_gamma
+ *         "NULL: Disable gamma correction", "Other: Enable gamma correction"
+ */
+struct viif_l1_gamma_config {
+	struct viif_l1_gamma *param;
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
+	uint16_t blk_knee;
+	uint16_t wht_knee;
+	uint8_t blk_cont[3];
+	uint8_t wht_cont[3];
+};
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
+	uint16_t gain_min;
+	uint16_t gain_max;
+	uint16_t lim_min;
+	uint16_t lim_max;
+};
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
+	uint16_t gain_min;
+	uint16_t gain_max;
+	uint16_t lim_min;
+	uint16_t lim_max;
+	uint16_t coring_min;
+	uint16_t coring_max;
+};
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
+	uint32_t bk_mp;
+	uint32_t black;
+	uint32_t wh_mp;
+	uint32_t white;
+	uint16_t bk_slv;
+	uint16_t wh_slv;
+};
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
+	uint16_t lv_min;
+	uint16_t lv_max;
+	uint16_t gain_min;
+	uint16_t gain_max;
+};
+/**
+ * struct viif_l1_edge_suppression -  L1ISP edge suppression parameters
+ * for &struct viif_l1_img_quality_adjustment_config
+ * @gain: Gain of edge color suppression [0..0xFFFF], accuracy: 1/256
+ * @lim: Limiter threshold of edge color suppression [0..15]
+ */
+struct viif_l1_edge_suppression {
+	uint16_t gain;
+	uint32_t lim;
+};
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
+	uint32_t cb_gain;
+	uint32_t cr_gain;
+	uint32_t cbr_mgain_min;
+	uint32_t cbp_gain_max;
+	uint32_t cbm_gain_max;
+	uint32_t crp_gain_max;
+	uint32_t crm_gain_max;
+};
+/**
+ * struct viif_l1_img_quality_adjustment_config -  L1ISP image quality
+ * adjustment parameters for :ref:`VIDIOC_VIIF_L1_SET_IMG_QUALITY_ADJUSTMENT`
+ * @coef_cb: Cb coefficient used in RGB to YUV conversion
+ *           [0..0xFFFF], accuracy: 1/65536
+ * @coef_cr: Cr coefficient used in RGB to YUV conversion
+ *           [0..0xFFFF], accuracy: 1/65536
+ * @brightness: Brightness value [-32768..32767] (0 means off)
+ * @linear_contrast: Linear contrast adjustment value
+ *                   [0..0xFF], accuracy: 1/128 (128 means off)
+ * @nonlinear_contrast: Pointer to nonlinear contrast adjustment parameter.
+ *                      Refer to &struct viif_l1_nonlinear_contrast.
+ *                      "NULL: Disable function", "Other: Enable function"
+ * @lum_noise_reduction: Pointer to luminance noise reduction parameter.
+ *                       Refer to &struct viif_l1_lum_noise_reduction.
+ *                       "NULL: Disable function", "Other: Enable function"
+ * @edge_enhancement: Pointer to edge enhancement processing parameter.
+ *                    Refer to &struct viif_l1_edge_enhancement.
+ *                    "NULL: Disable function", "Other: Enable function"
+ * @uv_suppression: Pointer to low / high luminance color suppression processing parameter.
+ *                  Refer to &struct viif_l1_uv_suppression.
+ *                  "NULL: Disable function", "Other: Enable function"
+ * @coring_suppression: Pointer to low chroma coring suppression processing parameter.
+ *                      Refer to &struct viif_l1_coring_suppression.
+ *                      "NULL: Disable function", "Other: Enable function"
+ * @edge_suppression: Pointer to edge color suppression processing parameter.
+ *                    Refer to &struct viif_l1_edge_suppression.
+ *                    "NULL: Disable function", "Other: Enable function"
+ * @color_level: Pointer to color level adjustment parameter.
+ *               Refer to &struct viif_l1_color_level.
+ *               "NULL: Disable function", "Other: Enable function"
+ * @color_noise_reduction_enable: 1:Enable/0:disable setting of
+ *                                color component noise reduction processing
+ */
+struct viif_l1_img_quality_adjustment_config {
+	uint16_t coef_cb;
+	uint16_t coef_cr;
+	int16_t brightness;
+	uint8_t linear_contrast;
+	struct viif_l1_nonlinear_contrast *nonlinear_contrast;
+	struct viif_l1_lum_noise_reduction *lum_noise_reduction;
+	struct viif_l1_edge_enhancement *edge_enhancement;
+	struct viif_l1_uv_suppression *uv_suppression;
+	struct viif_l1_coring_suppression *coring_suppression;
+	struct viif_l1_edge_suppression *edge_suppression;
+	struct viif_l1_color_level *color_level;
+	uint32_t color_noise_reduction_enable;
+};
+
+/* L2ISP undistortion mode */
+enum viif_l2_undist_mode {
+	VIIF_L2_UNDIST_POLY = 0, /* polynomial mode */
+	VIIF_L2_UNDIST_GRID = 1, /* grid table mode */
+	VIIF_L2_UNDIST_POLY_TO_GRID = 2, /* polynomial, then grid table mode */
+	VIIF_L2_UNDIST_GRID_TO_POLY = 3, /* grid table, then polynomial mode */
+};
+
+/**
+ * struct viif_l2_undist - L2ISP UNDIST parameters
+ * for &struct viif_l2_undist_config
+ * @through_mode: 1:enable or 0:disable through mode of undistortion
+ * @roi_mode: :ref:`L2ISP undistortion mode <L2ISP_undistortion_mode>`
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
+	uint32_t through_mode;
+	uint32_t roi_mode;
+	int32_t sensor_crop_ofs_h;
+	int32_t sensor_crop_ofs_v;
+	uint32_t norm_scale;
+	uint32_t valid_r_norm2_poly;
+	uint32_t valid_r_norm2_grid;
+	uint32_t roi_write_area_delta;
+	int32_t poly_write_g_coef[11];
+	int32_t poly_read_b_coef[11];
+	int32_t poly_read_g_coef[11];
+	int32_t poly_read_r_coef[11];
+	uint32_t grid_node_num_h;
+	uint32_t grid_node_num_v;
+	uint32_t grid_patch_hsize_inv;
+	uint32_t grid_patch_vsize_inv;
+};
+/**
+ * struct viif_l2_undist_config - L2ISP UNDIST parameters
+ * for :ref:`VIDIOC_VIIF_L2_SET_UNDIST`
+ * @param: &struct viif_l2_undist
+ * @write_g: Write for G Grid table address.
+ *           Table is not transferred if a NULL pointer is set
+ * @read_b: Read for B Grid table address.
+ *          Table is not transferred if a NULL pointer is set
+ * @read_g: Read for G Grid table address.
+ *          Table is not transferred if a NULL pointer is set
+ * @read_r: Read for R Grid table address.
+ *          Table is not transferred if a NULL pointer is set
+ * @size: Table size [byte]. Range: [1024..8192] or 0.
+ *        Should be set to "grid_node_num_h * grid_node_num_v * 4".
+ *        Refer to &struct viif_l2_undist.
+ *        Should set 0 in case NULL is set for all tables.
+ *        Should set size other than 0 in case If other is set in more than one table.
+ *
+ * Application should make sure that the table data is based on HW specification
+ * since this driver does not check the contents of specified grid table.
+ */
+struct viif_l2_undist_config {
+	struct viif_l2_undist param;
+	uint32_t *write_g;
+	uint32_t *read_b;
+	uint32_t *read_g;
+	uint32_t *read_r;
+	uint32_t size;
+};
+
+/**
+ * struct viif_l2_roi_config - L2ISP ROI parameters
+ * for :ref:`VIDIOC_VIIF_L2_SET_ROI`
+ * @roi_scale: Scale value for each ROI [32768..131072], accuracy: 1/65536
+ * @roi_scale_inv: Inverse scale value for each ROI [32768..131072], accuracy: 1/65536
+ * @corrected_wo_scale_hsize: Corrected image width for each ROI [pixel] [128..8190]
+ * @corrected_wo_scale_vsize: Corrected image height for each ROI [line] [128..4094]
+ * @corrected_hsize: Corrected and scaled image width for each ROI [pixel] [128..8190]
+ * @corrected_vsize: Corrected and scaled image height for each ROI [line] [128..4094]
+ */
+struct viif_l2_roi_config {
+	uint32_t roi_scale;
+	uint32_t roi_scale_inv;
+	uint32_t corrected_wo_scale_hsize;
+	uint32_t corrected_wo_scale_vsize;
+	uint32_t corrected_hsize;
+	uint32_t corrected_vsize;
+};
+
+/** enum viif_gamma_mode - Gamma correction mode
+ *
+ * @VIIF_GAMMA_COMPRESSED: compressed table mode
+ * @VIIF_GAMMA_LINEAR: liner table mode
+ */
+enum viif_gamma_mode {
+	VIIF_GAMMA_COMPRESSED = 0,
+	VIIF_GAMMA_LINEAR = 1,
+};
+
+/**
+ * struct viif_l2_gamma_config - L2ISP gamma correction parameters
+ * for :ref:`VIDIOC_VIIF_L2_SET_GAMMA`
+ * @enable: 1:Enable, 0:Disable settings of L2ISP gamma correction control
+ * @vsplit: Line switching position of first table and second table [line] [0..4094].
+ *          Should set 0 in case 0 is set to @enable
+ * @mode: :ref:`Gamma correction mode <Gamma_correction_mode>`.
+ *        Should set VIIF_GAMMA_COMPRESSED in case 0 is set to @enable
+ * @table: Table address.
+ *         Gamma table is not transferred if a NULL pointer is set to table.
+ *         The size of each table is fixed to 512 bytes.
+ *         [0]: G/Y(1st table), [1]: G/Y(2nd table), [2]: B/U(1st table)
+ *         [3]: B/U(2nd table), [4]: R/V(1st table), [5]: R/V(2nd table)
+ */
+struct viif_l2_gamma_config {
+	uint32_t enable;
+	uint32_t vsplit;
+	uint32_t mode;
+	uint16_t *table[6];
+};
+
+/**
+ * struct viif_l2_crop_config - L2ISP Cropping parameters
+ * for :ref:`VIDIOC_VIIF_L2_SET_CROP`
+ * @x: X coordinate position
+ *     (with the upper left corner of the image as the origin)[pixel] [0..8062]
+ * @y: Y coordinate position
+ *     (with the upper left corner of the image as the origin)[Line] [0..3966]
+ * @w: Image width[pixel] [128..8190]
+ * @h: Image height[pixel] [128..4094]
+ */
+struct viif_l2_crop_config {
+	uint32_t x;
+	uint32_t y;
+	uint32_t w;
+	uint32_t h;
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
+ * information for :ref:`VIDIOC_VIIF_CSI2RX_GET_CALIBRATION_STATUS`
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
+ * Refer to :ref:`CSI2-RX calibration status <CSI2RX_calibration_status>`
+ * for the definitions of each member
+ */
+struct viif_csi2rx_dphy_calibration_status {
+	uint32_t term_cal_with_rext;
+	uint32_t clock_lane_offset_cal;
+	uint32_t data_lane0_offset_cal;
+	uint32_t data_lane1_offset_cal;
+	uint32_t data_lane2_offset_cal;
+	uint32_t data_lane3_offset_cal;
+	uint32_t data_lane0_ddl_tuning_cal;
+	uint32_t data_lane1_ddl_tuning_cal;
+	uint32_t data_lane2_ddl_tuning_cal;
+	uint32_t data_lane3_ddl_tuning_cal;
+};
+
+/**
+ * struct viif_csi2rx_err_status - CSI2RX Error status parameters
+ * for :ref:`VIDIOC_VIIF_CSI2RX_GET_ERR_STATUS`
+ * @err_phy_fatal: D-PHY FATAL error.
+ *                 bit[3]: Start of transmission error on DATA Lane3.
+ *                 bit[2]: Start of transmission error on DATA Lane2.
+ *                 bit[1]: Start of transmission error on DATA Lane1.
+ *                 bit[0]: Start of transmission error on DATA Lane0.
+ * @err_pkt_fatal: Packet FATAL error.
+ *                 bit[16]: Header ECC contains 2 errors, unrecoverable.
+ *                 bit[3]: Checksum error detected on virtual channel 3.
+ *                 bit[2]: Checksum error detected on virtual channel 2.
+ *                 bit[1]: Checksum error detected on virtual channel 1.
+ *                 bit[0]: Checksum error detected on virtual channel 0.
+ * @err_frame_fatal: Frame FATAL error.
+ *                   bit[19]: Last received Frame, in virtual channel 3, has at least one CRC error.
+ *                   bit[18]: Last received Frame, in virtual channel 2, has at least one CRC error.
+ *                   bit[17]: Last received Frame, in virtual channel 1, has at least one CRC error.
+ *                   bit[16]: Last received Frame, in virtual channel 0, has at least one CRC error.
+ *                   bit[11]: Incorrect Frame Sequence detected in virtual channel 3.
+ *                   bit[10]: Incorrect Frame Sequence detected in virtual channel 2.
+ *                   bit[9]: Incorrect Frame Sequence detected in virtual channel 1.
+ *                   bit[8]: Incorrect Frame Sequence detected in virtual channel 0.
+ *                   bit[3]: Error matching Frame Start with Frame End for virtual channel 3.
+ *                   bit[2]: Error matching Frame Start with Frame End for virtual channel 2.
+ *                   bit[1]: Error matching Frame Start with Frame End for virtual channel 1.
+ *                   bit[0]: Error matching Frame Start with Frame End for virtual channel 0.
+ * @err_phy: D-PHY error.
+ *           bit[19]: Escape Entry Error on Data Lane 3.
+ *           bit[18]: Escape Entry Error on Data Lane 2.
+ *           bit[17]: Escape Entry Error on Data Lane 1.
+ *           bit[16]: Escape Entry Error on Data Lane 0.
+ *           bit[3]: Start of Transmission Error on Data Lane 3 (synchronization can still be achieved).
+ *           bit[2]: Start of Transmission Error on Data Lane 2 (synchronization can still be achieved).
+ *           bit[1]: Start of Transmission Error on Data Lane 1 (synchronization can still be achieved).
+ *           bit[0]: Start of Transmission Error on Data Lane 0 (synchronization can still be achieved).
+ * @err_pkt: Packet error.
+ *           bit[19]: Header Error detected and corrected on virtual channel 3.
+ *           bit[18]: Header Error detected and corrected on virtual channel 2.
+ *           bit[17]: Header Error detected and corrected on virtual channel 1.
+ *           bit[16]: Header Error detected and corrected on virtual channel 0.
+ *           bit[3]: Unrecognized or unimplemented data type detected in virtual channel 3.
+ *           bit[2]: Unrecognized or unimplemented data type detected in virtual channel 2.
+ *           bit[1]: Unrecognized or unimplemented data type detected in virtual channel 1.
+ *           bit[0]: Unrecognized or unimplemented data type detected in virtual channel 0.
+ * @err_line: Line error.
+ *            bit[23]: Error in the sequence of lines for vc7 and dt7.
+ *            bit[22]: Error in the sequence of lines for vc6 and dt6.
+ *            bit[21]: Error in the sequence of lines for vc5 and dt5.
+ *            bit[20]: Error in the sequence of lines for vc4 and dt4.
+ *            bit[19]: Error in the sequence of lines for vc3 and dt3.
+ *            bit[18]: Error in the sequence of lines for vc2 and dt2.
+ *            bit[17]: Error in the sequence of lines for vc1 and dt1.
+ *            bit[16]: Error in the sequence of lines for vc0 and dt0.
+ *            bit[7]: Error matching Line Start with Line End for vc7 and dt7.
+ *            bit[6]: Error matching Line Start with Line End for vc6 and dt6.
+ *            bit[5]: Error matching Line Start with Line End for vc5 and dt5.
+ *            bit[4]: Error matching Line Start with Line End for vc4 and dt4.
+ *            bit[3]: Error matching Line Start with Line End for vc3 and dt3.
+ *            bit[2]: Error matching Line Start with Line End for vc2 and dt2.
+ *            bit[1]: Error matching Line Start with Line End for vc1 and dt1.
+ *            bit[0]: Error matching Line Start with Line End for vc0 and dt0.
+ */
+struct viif_csi2rx_err_status {
+	uint32_t err_phy_fatal;
+	uint32_t err_pkt_fatal;
+	uint32_t err_frame_fatal;
+	uint32_t err_phy;
+	uint32_t err_pkt;
+	uint32_t err_line;
+};
+
+/**
+ * struct viif_l1_info - L1ISP AWB information
+ * for &struct viif_isp_capture_status
+ * @awb_ave_u: U average value of AWB adjustment [pixel]
+ * @awb_ave_v: V average value of AWB adjustment [pixel]
+ * @awb_accumulated_pixel: Accumulated pixel count of AWB adjustment
+ * @awb_gain_r: R gain used in the next frame of AWB adjustment
+ * @awb_gain_g: G gain used in the next frame of AWB adjustment
+ * @awb_gain_b: B gain used in the next frame of AWB adjustment
+ * @awb_status_u: U convergence state of AWB adjustment
+ *                (true: converged, false: not-converged)
+ * @awb_status_v: V convergence state of AWB adjustment
+ *                (true: converged, false: not-converged)
+ */
+struct viif_l1_info {
+	uint32_t awb_ave_u;
+	uint32_t awb_ave_v;
+	uint32_t awb_accumulated_pixel;
+	uint32_t awb_gain_r;
+	uint32_t awb_gain_g;
+	uint32_t awb_gain_b;
+	bool awb_status_u;
+	bool awb_status_v;
+};
+/**
+ * struct viif_isp_capture_status - L1ISP capture information
+ * for :ref:`VIDIOC_VIIF_ISP_GET_LAST_CAPTURE_STATUS`
+ * @l1_info: L1ISP AWB information. Refer to &struct viif_l1_info
+ */
+struct viif_isp_capture_status {
+	struct viif_l1_info l1_info;
+};
+
+#endif /* __UAPI_VISCONTI_VIIF_H_ */
-- 
2.17.1


