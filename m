Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58524FF415
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiDMJql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiDMJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:46:31 -0400
Received: from mo-csw.securemx.jp (mo-csw1116.securemx.jp [210.130.202.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46EB56752;
        Wed, 13 Apr 2022 02:44:07 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 23D9hdP1002456; Wed, 13 Apr 2022 18:43:39 +0900
X-Iguazu-Qid: 2wHHDhtSA8H2ikQfeU
X-Iguazu-QSIG: v=2; s=0; t=1649843018; q=2wHHDhtSA8H2ikQfeU; m=zqhsEXndUyRF0iZzC0QIxJbdtxaSx6s/nbeeMyIUVx0=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1111) id 23D9hbJr011385
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Apr 2022 18:43:38 +0900
X-SA-MID: 2335260
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH 2/5] media: platform: visconti: Add Toshiba Visconti Video Input Interface driver headers
Date:   Wed, 13 Apr 2022 18:42:00 +0900
X-TSB-HOP2: ON
Message-Id: <20220413094203.25714-3-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220413094203.25714-1-yuji2.ishikawa@toshiba.co.jp>
References: <20220413094203.25714-1-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to Video Input Interface on Toshiba Visconti Video Input Interface driver.
The Video Input Interface includes CSI2 receiver, frame grabber and image signal processor.
Headers in this commit provide definitions of data-structure and hardware registers.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/media/platform/visconti/hwd_viif.h    |  834 +++++
 .../platform/visconti/hwd_viif_internal.h     |  361 +++
 .../media/platform/visconti/hwd_viif_reg.h    | 2802 +++++++++++++++++
 drivers/media/platform/visconti/viif.h        |  134 +
 include/uapi/linux/visconti_viif.h            |  356 +++
 5 files changed, 4487 insertions(+)
 create mode 100644 drivers/media/platform/visconti/hwd_viif.h
 create mode 100644 drivers/media/platform/visconti/hwd_viif_internal.h
 create mode 100644 drivers/media/platform/visconti/hwd_viif_reg.h
 create mode 100644 drivers/media/platform/visconti/viif.h
 create mode 100644 include/uapi/linux/visconti_viif.h

diff --git a/drivers/media/platform/visconti/hwd_viif.h b/drivers/media/platform/visconti/hwd_viif.h
new file mode 100644
index 000000000..86d2be9f7
--- /dev/null
+++ b/drivers/media/platform/visconti/hwd_viif.h
@@ -0,0 +1,834 @@
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
index 000000000..a235b4d7c
--- /dev/null
+++ b/include/uapi/linux/visconti_viif.h
@@ -0,0 +1,356 @@
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


