Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB74536426
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353499AbiE0OdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 10:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353373AbiE0OcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 10:32:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197D15622D;
        Fri, 27 May 2022 07:32:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id 2D01A1F462CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653661920;
        bh=u1oYFY91lKCaG1IS2p75wfBvd3Ndu0vMqfec7fE7nLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZGvJ+R++MxVyrOEEZsg7OTvu4bp5HttwwzZ3ecgomG4i9oU6c7ECJZLunxuWt1CF
         vYGLK6PSTjnyHB81hgcUGMnfDuvqOLxgxFAQFzmMP6guZSaC3rf5r7u7Vxskg+4E/m
         tVI0dabYMgQpyrZpxUrYcT72bfi9ehEKMLDWLwgud7wRIgTjeY0/g+RqmIMPCTJqb1
         NUL/2A/KyuswrSgXCNf9ZzEsaMvzeWN8Nbq6VprSv4XO2SBB3d6Ve8mYmIaEqY0bOh
         ieIRIKdw004kPhdm5fXOvKPE3fFJijE86bHRMlsKkfYZ22DIygsVZ6hlgure53eA/J
         4/gPgSztWqLkQ==
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
Subject: [PATCH v6 15/17] media: uapi: HEVC: fix padding in v4l2 control structures
Date:   Fri, 27 May 2022 16:31:32 +0200
Message-Id: <20220527143134.3360174-16-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220527143134.3360174-1-benjamin.gaignard@collabora.com>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix padding where needed to remove holes and stay align on cache boundaries

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/v4l/ext-ctrls-codec.rst             |  6 +++---
 drivers/media/v4l2-core/v4l2-ctrls-core.c     |  9 ---------
 include/media/hevc-ctrls.h                    | 19 ++++++++++++-------
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 05228e280f66..48a8825a001b 100644
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
index c5c5407584ff..fb68786c498b 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -824,20 +824,11 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
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
 		p_hevc_slice_params = p;
 
-		zero_padding(p_hevc_slice_params->pred_weight_table);
 		zero_padding(*p_hevc_slice_params);
 		break;
 
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
index efc0412ac41e..9abca1a75bd4 100644
--- a/include/media/hevc-ctrls.h
+++ b/include/media/hevc-ctrls.h
@@ -133,7 +133,9 @@ struct v4l2_ctrl_hevc_sps {
 	__u8	chroma_format_idc;
 	__u8	sps_max_sub_layers_minus1;
 
+	__u8	reserved[6];
 	__u64	flags;
+	__u8	padding[24];
 };
 
 #define V4L2_HEVC_PPS_FLAG_DEPENDENT_SLICE_SEGMENT_ENABLED	(1ULL << 0)
@@ -210,9 +212,10 @@ struct v4l2_ctrl_hevc_pps {
 	__s8	pps_beta_offset_div2;
 	__s8	pps_tc_offset_div2;
 	__u8	log2_parallel_merge_level_minus2;
+	__u8	reserved[9];
 
-	__u8	padding[4];
 	__u64	flags;
+	__u8	padding[56];
 };
 
 #define V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE	0x01
@@ -245,8 +248,8 @@ struct v4l2_hevc_dpb_entry {
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
@@ -381,18 +382,20 @@ struct v4l2_ctrl_hevc_slice_params {
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
+	__u8	padding[40];
 };
 
 #define V4L2_HEVC_DECODE_PARAM_FLAG_IRAP_PIC		0x1
@@ -408,7 +411,6 @@ struct v4l2_ctrl_hevc_slice_params {
  * @long_term_ref_pic_set_size: specifies the size of long-term reference
  *				pictures set include in the SPS of the first slice
  * @num_active_dpb_entries: the number of entries in dpb
- * @dpb: the decoded picture buffer, for meta-data about reference frames
  * @num_poc_st_curr_before: the number of reference pictures in the short-term
  *			    set that come before the current frame
  * @num_poc_st_curr_after: the number of reference pictures in the short-term
@@ -419,6 +421,7 @@ struct v4l2_ctrl_hevc_slice_params {
  * @poc_st_curr_after: provides the index of the short term after references
  *		       in DPB array
  * @poc_lt_curr: provides the index of the long term references in DPB array
+ * @dpb: the decoded picture buffer, for meta-data about reference frames
  * @flags: see V4L2_HEVC_DECODE_PARAM_FLAG_{}
  */
 struct v4l2_ctrl_hevc_decode_params {
@@ -426,14 +429,16 @@ struct v4l2_ctrl_hevc_decode_params {
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
+	__u8	padding[56];
 };
 
 /**
-- 
2.32.0

