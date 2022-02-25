Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D347F4C4B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243349AbiBYQrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243226AbiBYQqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:46:52 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFF222D649;
        Fri, 25 Feb 2022 08:46:19 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:947c:7c9e:f96:1bc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 211561F460CB;
        Fri, 25 Feb 2022 16:46:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645807578;
        bh=kH8okO8n3ee4fr5ZA7+ZFHXsk8zJplGNoezCVj/7AKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gS3k/mqxZMpvK0Egp9zjZIju9+wk8QJob37SvBb8vo2RV5gu1SZyP5qYumlvsF1xp
         D+vAhhQkqA9vYjdOG7Zyp0jiSf34ZGKAKjh1ndG0ha39UJy4HTQB1gj+2HoHnXU3nk
         7MiVoTDrGTnrvmbSttfknrkzpWGiwarMkFBtrjfvOoXoE/gBxIi+zne/2U0pxxkuH8
         TumdY8YhIRK8A8RJnL5YtcmUuMxZGBlnhnvp8K2XNFf6OBHsQD+UGQfs3Qvg5GL48K
         t7zuG/QRbKlVKwP8Qhs5Qf0FAOoG/Rj1xGVukrfR8d6ePvLiji/rngw2OL2Ao+rYyE
         m29wKxfms/Lew==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, nicolas@ndufresne.ca
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 13/14] media: uapi: HEVC: fix padding in v4l2 control structures
Date:   Fri, 25 Feb 2022 17:45:59 +0100
Message-Id: <20220225164600.1044663-14-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225164600.1044663-1-benjamin.gaignard@collabora.com>
References: <20220225164600.1044663-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix padding where needed to remove holes and stay align on cache boundaries

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../userspace-api/media/v4l/ext-ctrls-codec.rst   |  6 +++---
 drivers/media/v4l2-core/v4l2-ctrls-core.c         |  1 -
 include/media/hevc-ctrls.h                        | 15 +++++++++------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 71f7dc1c1ccd..00fa815cb5f8 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -3423,9 +3423,6 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     * - __u8
       - ``num_active_dpb_entries``
       - The number of entries in ``dpb``.
-    * - struct :c:type:`v4l2_hevc_dpb_entry`
-      - ``dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
-      - The decoded picture buffer, for meta-data about reference frames.
     * - __u8
       - ``num_poc_st_curr_before``
       - The number of reference pictures in the short-term set that come before
@@ -3449,6 +3446,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
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
index 694de414f545..eb1de4f699d0 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -819,7 +819,6 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 	case V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS:
 		p_hevc_slice_params = p;
 
-		zero_padding(p_hevc_slice_params->pred_weight_table);
 		zero_padding(*p_hevc_slice_params);
 		break;
 
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
index f29298c8c2f8..6bffcb2c8a1d 100644
--- a/include/media/hevc-ctrls.h
+++ b/include/media/hevc-ctrls.h
@@ -133,7 +133,9 @@ struct v4l2_ctrl_hevc_sps {
 	__u8	chroma_format_idc;
 	__u8	sps_max_sub_layers_minus1;
 
+	__u8	padding[6];
 	__u64	flags;
+	__u8	reserved[24];
 };
 
 #define V4L2_HEVC_PPS_FLAG_DEPENDENT_SLICE_SEGMENT_ENABLED	(1ULL << 0)
@@ -210,9 +212,10 @@ struct v4l2_ctrl_hevc_pps {
 	__s8	pps_beta_offset_div2;
 	__s8	pps_tc_offset_div2;
 	__u8	log2_parallel_merge_level_minus2;
+	__u8	padding[9];
 
-	__u8	padding[4];
 	__u64	flags;
+	__u8	reserved[56];
 };
 
 #define V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE	0x01
@@ -271,8 +274,6 @@ struct v4l2_hevc_pred_weight_table {
 	__s8	delta_chroma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
 	__s8	chroma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
 
-	__u8	padding[6];
-
 	__u8	luma_log2_weight_denom;
 	__s8	delta_chroma_log2_weight_denom;
 };
@@ -363,18 +364,20 @@ struct v4l2_ctrl_hevc_slice_params {
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture timing SEI message */
 	__u8	pic_struct;
 
+	__u8	reserved;
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
 	__u32	slice_segment_addr;
 	__u8	ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u16	short_term_ref_pic_set_size;
 	__u16	long_term_ref_pic_set_size;
-	__u8	padding;
 
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Weighted prediction parameter */
 	struct v4l2_hevc_pred_weight_table pred_weight_table;
 
+	__u16	reserved1;
 	__u64	flags;
+	__u8	padding[48];
 };
 
 #define V4L2_HEVC_DECODE_PARAM_FLAG_IRAP_PIC		0x1
@@ -386,7 +389,6 @@ struct v4l2_ctrl_hevc_slice_params {
  *
  * @pic_order_cnt_val: picture order count
  * @num_active_dpb_entries: the number of entries in dpb
- * @dpb: the decoded picture buffer, for meta-data about reference frames
  * @num_poc_st_curr_before: the number of reference pictures in the short-term
  * 			    set that come before the current frame
  * @num_poc_st_curr_after: the number of reference pictures in the short-term
@@ -397,18 +399,19 @@ struct v4l2_ctrl_hevc_slice_params {
  * @poc_st_curr_after: provides the index of the short term after references
  * 		       in DPB array
  * @poc_lt_curr: provides the index of the long term references in DPB array
+ * @dpb: the decoded picture buffer, for meta-data about reference frames
  * @flags: see V4L2_HEVC_DECODE_PARAM_FLAG_{}
  */
 struct v4l2_ctrl_hevc_decode_params {
 	__s32	pic_order_cnt_val;
 	__u8	num_active_dpb_entries;
-	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	num_poc_st_curr_before;
 	__u8	num_poc_st_curr_after;
 	__u8	num_poc_lt_curr;
 	__u8	poc_st_curr_before[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	poc_st_curr_after[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u64	flags;
 };
 
-- 
2.32.0

