Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6861450059D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 07:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbiDNFoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 01:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbiDNFnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 01:43:42 -0400
Received: from mo-csw.securemx.jp (mo-csw1114.securemx.jp [210.130.202.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3EF496B8;
        Wed, 13 Apr 2022 22:41:13 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 23E5egp0014849; Thu, 14 Apr 2022 14:40:42 +0900
X-Iguazu-Qid: 2wHHJRDF5vS1drAwFO
X-Iguazu-QSIG: v=2; s=0; t=1649914841; q=2wHHJRDF5vS1drAwFO; m=1ysb7eWv8v1ZugETDcm2w0fnIttru34aiNUZWvABPv4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1111) id 23E5eftr022609
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Apr 2022 14:40:41 +0900
X-SA-MID: 36015027
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v2 4/5] media: platform: visconti: Add Toshiba VIIF image signal processor driver
Date:   Thu, 14 Apr 2022 14:35:27 +0900
X-TSB-HOP2: ON
Message-Id: <20220414053528.31460-5-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220414053528.31460-1-yuji2.ishikawa@toshiba.co.jp>
References: <20220414053528.31460-1-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
Functions in this commit are drivers for the integrated Image Signal Processor.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
v1 -> v2:
  - moved image signal processor driver to this patch, apart from drivers for CSI2 receiver and frame grabber
---
 drivers/media/platform/visconti/Makefile      |    2 +-
 drivers/media/platform/visconti/hwd_viif.h    |  942 ++++
 .../media/platform/visconti/hwd_viif_l1isp.c  | 3769 +++++++++++++++++
 drivers/media/platform/visconti/viif.c        |  554 +++
 include/uapi/linux/visconti_viif.h            | 1327 ++++++
 5 files changed, 6593 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/platform/visconti/hwd_viif_l1isp.c

diff --git a/drivers/media/platform/visconti/Makefile b/drivers/media/platform/visconti/Makefile
index 6463f33f0..3a9e04d0b 100644
--- a/drivers/media/platform/visconti/Makefile
+++ b/drivers/media/platform/visconti/Makefile
@@ -4,6 +4,6 @@
 #
 
 visconti-viif-objs = viif.o
-visconti-viif-objs += hwd_viif_csi2rx.o hwd_viif.o
+visconti-viif-objs += hwd_viif_csi2rx.o hwd_viif.o hwd_viif_l1isp.o
 
 obj-$(CONFIG_VIDEO_VISCONTI_VIIF) += visconti-viif.o
diff --git a/drivers/media/platform/visconti/hwd_viif.h b/drivers/media/platform/visconti/hwd_viif.h
index 86d2be9f7..c0cc83473 100644
--- a/drivers/media/platform/visconti/hwd_viif.h
+++ b/drivers/media/platform/visconti/hwd_viif.h
@@ -546,6 +546,883 @@ struct hwd_viif_isp_regbuf_status {
 	bool write_err;
 };
 
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
 /**
  * struct hwd_viif_l1_info - HWD L1ISP processing information
  * @context_id: context id
@@ -806,6 +1683,71 @@ void hwd_VIIF_isp_set_regbuf_irq_mask(uint32_t module_id, const uint32_t *mask_l
 				      const uint32_t *mask_l2);
 void hwd_VIIF_isp_disable_isst(uint32_t module_id);
 
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
 /* control L2 Image Signal Processor */
 int32_t hwd_VIIF_l2_set_input_path(uint32_t module_id, bool is_other_ch);
 int32_t hwd_VIIF_l2_set_input_csc(uint32_t module_id, const struct hwd_viif_csc_param *param,
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
diff --git a/drivers/media/platform/visconti/viif.c b/drivers/media/platform/visconti/viif.c
index 1869f0267..2012d406a 100644
--- a/drivers/media/platform/visconti/viif.c
+++ b/drivers/media/platform/visconti/viif.c
@@ -505,6 +505,503 @@ static int viif_main_set_rawpack_mode(struct viif_device *viif_dev, uint32_t *ra
 	return 0;
 }
 
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
 #define VISCONTI_VIIF_DPC_TABLE_SIZE_MIN 1024
 #define VISCONTI_VIIF_DPC_TABLE_SIZE_MAX 8192
 static int viif_l2_set_undist(struct viif_device *viif_dev, struct viif_l2_undist_config *undist)
@@ -736,6 +1233,63 @@ static long viif_ioctl_default(struct file *file, void *fh, bool valid_prio, uns
 	case VIDIOC_VIIF_MAIN_SET_RAWPACK_MODE:
 		ret = viif_main_set_rawpack_mode(viif_dev, arg);
 		break;
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
 	case VIDIOC_VIIF_L2_SET_UNDIST:
 		ret = viif_l2_set_undist(viif_dev, arg);
 		break;
diff --git a/include/uapi/linux/visconti_viif.h b/include/uapi/linux/visconti_viif.h
index a235b4d7c..14e6b176c 100644
--- a/include/uapi/linux/visconti_viif.h
+++ b/include/uapi/linux/visconti_viif.h
@@ -14,6 +14,48 @@
 /* Private IPCTLs */
 #define VIDIOC_VIIF_MAIN_SET_RAWPACK_MODE                                      \
 	_IOW('V', BASE_VIDIOC_PRIVATE + 1, uint32_t)
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
 #define VIDIOC_VIIF_L2_SET_UNDIST                                              \
 	_IOW('V', BASE_VIDIOC_PRIVATE + 21, struct viif_l2_undist_config)
 #define VIDIOC_VIIF_L2_SET_ROI                                                 \
@@ -49,6 +91,1291 @@ enum viif_rawpack_mode {
 	VIIF_RAWPACK_LSBFIRST = 3,
 };
 
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
 /* L2ISP undistortion mode */
 enum viif_l2_undist_mode {
 	VIIF_L2_UNDIST_POLY = 0, /* polynomial mode */
-- 
2.17.1


