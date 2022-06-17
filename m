Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC14C54F328
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381251AbiFQIg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381109AbiFQIgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:36:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9CA6929A;
        Fri, 17 Jun 2022 01:36:05 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:faf2:1a12:f903:cc5e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9C021660194A;
        Fri, 17 Jun 2022 09:36:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655454964;
        bh=GI550Rl/+5Wa4DYb/aiaQ579q6tll8Po/ZFyH0E+y6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aQzP/yN+G5qRZ7+D9qOYqCporuv14Xsd6u29CNyQ34Wn/pY7zDEkdbQWFNznqO7F5
         vJNVrFesqwSRAne425IrhVhi26GxEmDas8Ss+5k2ujGiXWsgTV+fEI0lG5N7Flw0IN
         oy3rK91whSRxOwbdp9D/GT24NYPjNZzH1MnrXExTJbfk10Jhpb3Kcvu4yJulwXKW4V
         91g1njWgKa4gQZbkEh2ekWqL2j4wkWAaw0qKfaYQ1zRyN++DfGYUooe5JCwXSnJS8z
         7rQoj/EWs0TtD6Q8zwkaNXiRbYu0wQQZpPScZn8O1gCPpH5JmEm7y7b0JUPKZYffKd
         WLO70A1nA5o5g==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v9 15/17] media: uapi: HEVC: fix padding in v4l2 control structures
Date:   Fri, 17 Jun 2022 10:35:43 +0200
Message-Id: <20220617083545.133920-16-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220617083545.133920-1-benjamin.gaignard@collabora.com>
References: <20220617083545.133920-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix padding where needed to remove holes and stay aligned on cache boundaries

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 9:
- Fix commit message
- Remove useless padding at the end of hevc structures

 .../media/v4l/ext-ctrls-codec.rst             |  6 ++---
 drivers/media/v4l2-core/v4l2-ctrls-core.c     | 15 -------------
 include/media/hevc-ctrls.h                    | 22 ++++++++++++-------
 3 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 8df8d7fdfe70..889e2bcffde6 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -3509,9 +3509,6 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     * - __u8
       - ``num_active_dpb_entries``
       - The number of entries in ``dpb``.
-    * - struct :c:type:`v4l2_hevc_dpb_entry`
-      - ``dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
-      - The decoded picture buffer, for meta-data about reference frames.
     * - __u8
       - ``num_poc_st_curr_before``
       - The number of reference pictures in the short-term set that come before
@@ -3535,6 +3532,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
       - ``poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
       - PocLtCurr as described in section 8.3.2 "Decoding process for reference
         picture set": provides the index of the long term references in DPB array.
+    * - struct :c:type:`v4l2_hevc_dpb_entry`
+      - ``dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
+      - The decoded picture buffer, for meta-data about reference frames.
     * - __u64
       - ``flags``
       - See :ref:`Decode Parameters Flags <hevc_decode_params_flags>`
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index c5c5407584ff..1f85828d6694 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -536,7 +536,6 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 	struct v4l2_ctrl_h264_decode_params *p_h264_dec_params;
 	struct v4l2_ctrl_hevc_sps *p_hevc_sps;
 	struct v4l2_ctrl_hevc_pps *p_hevc_pps;
-	struct v4l2_ctrl_hevc_slice_params *p_hevc_slice_params;
 	struct v4l2_ctrl_hdr10_mastering_display *p_hdr10_mastering;
 	struct v4l2_ctrl_hevc_decode_params *p_hevc_decode_params;
 	struct v4l2_area *area;
@@ -814,8 +813,6 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 			p_hevc_pps->pps_beta_offset_div2 = 0;
 			p_hevc_pps->pps_tc_offset_div2 = 0;
 		}
-
-		zero_padding(*p_hevc_pps);
 		break;
 
 	case V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS:
@@ -824,21 +821,9 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 		if (p_hevc_decode_params->num_active_dpb_entries >
 		    V4L2_HEVC_DPB_ENTRIES_NUM_MAX)
 			return -EINVAL;
-
-		for (i = 0; i < p_hevc_decode_params->num_active_dpb_entries;
-		     i++) {
-			struct v4l2_hevc_dpb_entry *dpb_entry =
-				&p_hevc_decode_params->dpb[i];
-
-			zero_padding(*dpb_entry);
-		}
 		break;
 
 	case V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS:
-		p_hevc_slice_params = p;
-
-		zero_padding(p_hevc_slice_params->pred_weight_table);
-		zero_padding(*p_hevc_slice_params);
 		break;
 
 	case V4L2_CTRL_TYPE_HDR10_CLL_INFO:
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
index 9239e8b649e0..7358cbfc3e4d 100644
--- a/include/media/hevc-ctrls.h
+++ b/include/media/hevc-ctrls.h
@@ -105,6 +105,7 @@ enum v4l2_stateless_hevc_start_code {
  * @chroma_format_idc: specifies the chroma sampling
  * @sps_max_sub_layers_minus1: this value plus 1 specifies the maximum number
  *                             of temporal sub-layers
+ * @reserved: padding field. Should be zeroed by applications.
  * @flags: see V4L2_HEVC_SPS_FLAG_{}
  */
 struct v4l2_ctrl_hevc_sps {
@@ -133,6 +134,7 @@ struct v4l2_ctrl_hevc_sps {
 	__u8	chroma_format_idc;
 	__u8	sps_max_sub_layers_minus1;
 
+	__u8	reserved[6];
 	__u64	flags;
 };
 
@@ -192,6 +194,7 @@ struct v4l2_ctrl_hevc_sps {
  *			divided by 2
  * @log2_parallel_merge_level_minus2: this value plus 2 specifies the value of
  *                                    the variable Log2ParMrgLevel
+ * @reserved: padding field. Should be zeroed by applications.
  * @flags: see V4L2_HEVC_PPS_FLAG_{}
  */
 struct v4l2_ctrl_hevc_pps {
@@ -210,8 +213,7 @@ struct v4l2_ctrl_hevc_pps {
 	__s8	pps_beta_offset_div2;
 	__s8	pps_tc_offset_div2;
 	__u8	log2_parallel_merge_level_minus2;
-
-	__u8	padding[4];
+	__u8	reserved;
 	__u64	flags;
 };
 
@@ -239,14 +241,15 @@ struct v4l2_ctrl_hevc_pps {
  * @timestamp: timestamp of the V4L2 capture buffer to use as reference.
  * @flags: long term flag for the reference frame
  * @field_pic: whether the reference is a field picture or a frame.
+ * @reserved: padding field. Should be zeroed by applications.
  * @pic_order_cnt_val: the picture order count of the reference.
  */
 struct v4l2_hevc_dpb_entry {
 	__u64	timestamp;
 	__u8	flags;
 	__u8	field_pic;
+	__u16	reserved;
 	__s32	pic_order_cnt_val;
-	__u8	padding[2];
 };
 
 /**
@@ -285,8 +288,6 @@ struct v4l2_hevc_pred_weight_table {
 	__s8	delta_chroma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
 	__s8	chroma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
 
-	__u8	padding[6];
-
 	__u8	luma_log2_weight_denom;
 	__s8	delta_chroma_log2_weight_denom;
 };
@@ -339,6 +340,7 @@ struct v4l2_hevc_pred_weight_table {
  * @slice_tc_offset_div2: specify the deblocking parameter offsets for tC divided by 2
  * @pic_struct: indicates whether a picture should be displayed as a frame or as one or
  *		more fields
+ * @reserved0: padding field. Should be zeroed by applications.
  * @slice_segment_addr: specifies the address of the first coding tree block in
  *			the slice segment
  * @ref_idx_l0: the list of L0 reference elements as indices in the DPB
@@ -349,6 +351,7 @@ struct v4l2_hevc_pred_weight_table {
  *				picture include in the SPS
  * @pred_weight_table: the prediction weight coefficients for inter-picture
  *		       prediction
+ * @reserved1: padding field. Should be zeroed by applications.
  * @flags: see V4L2_HEVC_SLICE_PARAMS_FLAG_{}
  */
 struct v4l2_ctrl_hevc_slice_params {
@@ -379,17 +382,18 @@ struct v4l2_ctrl_hevc_slice_params {
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture timing SEI message */
 	__u8	pic_struct;
 
+	__u8	reserved0[3];
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
 	__u32	slice_segment_addr;
 	__u8	ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u16	short_term_ref_pic_set_size;
 	__u16	long_term_ref_pic_set_size;
-	__u8	padding;
 
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Weighted prediction parameter */
 	struct v4l2_hevc_pred_weight_table pred_weight_table;
 
+	__u8	reserved1[2];
 	__u64	flags;
 };
 
@@ -406,7 +410,6 @@ struct v4l2_ctrl_hevc_slice_params {
  * @long_term_ref_pic_set_size: specifies the size of long-term reference
  *				pictures set include in the SPS of the first slice
  * @num_active_dpb_entries: the number of entries in dpb
- * @dpb: the decoded picture buffer, for meta-data about reference frames
  * @num_poc_st_curr_before: the number of reference pictures in the short-term
  *			    set that come before the current frame
  * @num_poc_st_curr_after: the number of reference pictures in the short-term
@@ -417,6 +420,8 @@ struct v4l2_ctrl_hevc_slice_params {
  * @poc_st_curr_after: provides the index of the short term after references
  *		       in DPB array
  * @poc_lt_curr: provides the index of the long term references in DPB array
+ * @reserved: padding field. Should be zeroed by applications.
+ * @dpb: the decoded picture buffer, for meta-data about reference frames
  * @flags: see V4L2_HEVC_DECODE_PARAM_FLAG_{}
  */
 struct v4l2_ctrl_hevc_decode_params {
@@ -424,13 +429,14 @@ struct v4l2_ctrl_hevc_decode_params {
 	__u16	short_term_ref_pic_set_size;
 	__u16	long_term_ref_pic_set_size;
 	__u8	num_active_dpb_entries;
-	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	num_poc_st_curr_before;
 	__u8	num_poc_st_curr_after;
 	__u8	num_poc_lt_curr;
 	__u8	poc_st_curr_before[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	poc_st_curr_after[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__u8	reserved[4];
+	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u64	flags;
 };
 
-- 
2.32.0

