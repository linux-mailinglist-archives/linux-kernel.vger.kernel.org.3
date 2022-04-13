Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1394FF411
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiDMJrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiDMJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:46:43 -0400
Received: from mo-csw.securemx.jp (mo-csw1515.securemx.jp [210.130.202.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D02526AFE;
        Wed, 13 Apr 2022 02:44:19 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 23D9hp9D031478; Wed, 13 Apr 2022 18:43:52 +0900
X-Iguazu-Qid: 34trQigfs8YGgvCmgd
X-Iguazu-QSIG: v=2; s=0; t=1649843031; q=34trQigfs8YGgvCmgd; m=3v23uzbb4lYWfgQSRQkIBAXk2WvcKfMvvjzYZucPEsw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1512) id 23D9hpdP003746
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Apr 2022 18:43:51 +0900
X-SA-MID: 35962691
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH 3/5] media: platform: visconti: Add Toshiba Visconti Video Input Interface driver body
Date:   Wed, 13 Apr 2022 18:42:01 +0900
X-TSB-HOP2: ON
Message-Id: <20220413094203.25714-4-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220413094203.25714-1-yuji2.ishikawa@toshiba.co.jp>
References: <20220413094203.25714-1-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to Video Input Interface on Toshiba Visconti Video Input Interface driver.
Functions in this commit are drivers for CSI2 receiver and frame grabber.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/media/platform/Kconfig                |    2 +
 drivers/media/platform/Makefile               |    4 +
 drivers/media/platform/visconti/Kconfig       |    9 +
 drivers/media/platform/visconti/Makefile      |    9 +
 drivers/media/platform/visconti/hwd_viif.c    | 2233 +++++++++++++++++
 .../media/platform/visconti/hwd_viif_csi2rx.c |  767 ++++++
 drivers/media/platform/visconti/viif.c        | 1830 ++++++++++++++
 7 files changed, 4854 insertions(+)
 create mode 100644 drivers/media/platform/visconti/Kconfig
 create mode 100644 drivers/media/platform/visconti/Makefile
 create mode 100644 drivers/media/platform/visconti/hwd_viif.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif_csi2rx.c
 create mode 100644 drivers/media/platform/visconti/viif.c

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
index 000000000..6463f33f0
--- /dev/null
+++ b/drivers/media/platform/visconti/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Visconti video input device driver
+#
+
+visconti-viif-objs = viif.o
+visconti-viif-objs += hwd_viif_csi2rx.o hwd_viif.o
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
diff --git a/drivers/media/platform/visconti/viif.c b/drivers/media/platform/visconti/viif.c
new file mode 100644
index 000000000..1869f0267
--- /dev/null
+++ b/drivers/media/platform/visconti/viif.c
@@ -0,0 +1,1830 @@
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
-- 
2.17.1


