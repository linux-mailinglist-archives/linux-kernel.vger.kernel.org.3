Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FDB56B945
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiGHMG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbiGHMGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:06:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE9C87340;
        Fri,  8 Jul 2022 05:06:09 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:3cab:61a1:2b1f:896b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CC99D66019DD;
        Fri,  8 Jul 2022 13:06:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657281968;
        bh=C5Btgw3+c5EvnhMNonf2NhctTzpNaqRXUw4T2X+a+KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgTnMOKc5gcpG4y3guHP5QXUY5uBCIiDnBS7OPVsQNV/iWMs1klAXdMo1IPEfPf9E
         ia4ic2MrrCYx0mCUtyTWxy0E4oiEH69yHngg/RovDPYGaLKAR/0AFkB3qYr+KgGb50
         qFqkxhK6hOmmmsPFgd0j1rFASk5iuKJ9jLji5+WSydyLw8ON7xpirzGcf+1BSKNKUl
         wl1NLlVkaYgZOcaap2TIZMo57e7pdhEivMO0SVWdxkDlqS/EGx7Aw2NIMKBcpHusJD
         ZyFecXf/8mACkO6HRVww0Z/lpiTjo9h1v2OXL1igz/5QSH+6VBsCXKnKUZQEF18P1U
         ssrc0MZEwi/uw==
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
Subject: [PATCH v12 04/17] media: uapi: HEVC: Add missing fields in HEVC controls
Date:   Fri,  8 Jul 2022 14:05:41 +0200
Message-Id: <20220708120554.495495-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220708120554.495495-1-benjamin.gaignard@collabora.com>
References: <20220708120554.495495-1-benjamin.gaignard@collabora.com>
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

Complete the HEVC controls with missing fields from H.265 specifications.
Even if these fields aren't used by the current mainlined drivers
they will be required for (at least) the rkvdec driver.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../media/v4l/ext-ctrls-codec.rst             | 32 +++++++++++++++++++
 include/media/hevc-ctrls.h                    |  8 ++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 6183f43f4d73..cff742142a55 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2683,6 +2683,16 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     :stub-columns: 0
     :widths:       1 1 2
 
+    * - __u8
+      - ``video_parameter_set_id``
+      - Specifies the value of the vps_video_parameter_set_id of the active VPS
+        as described in section "7.4.3.2.1 General sequence parameter set RBSP semantics"
+        of H.265 specifications.
+    * - __u8
+      - ``seq_parameter_set_id``
+      - Provides an identifier for the SPS for reference by other syntax elements
+        as described in section "7.4.3.2.1 General sequence parameter set RBSP semantics"
+        of H.265 specifications.
     * - __u16
       - ``pic_width_in_luma_samples``
       -
@@ -2822,6 +2832,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     :stub-columns: 0
     :widths:       1 1 2
 
+    * - __u8
+      - ``pic_parameter_set_id``
+      - Identifies the PPS for reference by other syntax elements.
     * - __u8
       - ``num_extra_slice_header_bits``
       -
@@ -3048,6 +3061,15 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     * - __u8
       - ``ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
       - The list of L1 reference elements as indices in the DPB.
+    * - __u16
+      - ``short_term_ref_pic_set_size``
+      - Specifies the size, in bits, of the short-term reference picture set, described as st_ref_pic_set()
+        in the specification, included in the slice header or SPS (section 7.3.6.1).
+    * - __u16
+      - ``long_term_ref_pic_set_size``
+      - Specifies the size, in bits, of the long-term reference picture set include in the slice header
+        or SPS. It is the number of bits in the conditional block if(long_term_ref_pics_present_flag)
+        in section 7.3.6.1 of the specification.
     * - __u8
       - ``padding``
       - Applications and drivers must set this to zero.
@@ -3385,6 +3407,16 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
       - ``pic_order_cnt_val``
       - PicOrderCntVal as described in section 8.3.1 "Decoding process
         for picture order count" of the specification.
+    * - __u16
+      - ``short_term_ref_pic_set_size``
+      - Specifies the size, in bits, of the short-term reference picture set, of the first slice
+        described as st_ref_pic_set() in the specification, included in the slice header
+        or SPS (section 7.3.6.1).
+    * - __u16
+      - ``long_term_ref_pic_set_size``
+      - Specifies the size, in bits, of the long-term reference picture set, of the first slice
+        included in the slice header or SPS. It is the number of bits in the conditional block
+        if(long_term_ref_pics_present_flag) in section 7.3.6.1 of the specification.
     * - __u8
       - ``num_active_dpb_entries``
       - The number of entries in ``dpb``.
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
index 01ccda48d8c5..752a8d10782c 100644
--- a/include/media/hevc-ctrls.h
+++ b/include/media/hevc-ctrls.h
@@ -58,6 +58,8 @@ enum v4l2_mpeg_video_hevc_start_code {
 /* The controls are not stable at the moment and will likely be reworked. */
 struct v4l2_ctrl_hevc_sps {
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Sequence parameter set */
+	__u8	video_parameter_set_id;
+	__u8	seq_parameter_set_id;
 	__u16	pic_width_in_luma_samples;
 	__u16	pic_height_in_luma_samples;
 	__u8	bit_depth_luma_minus8;
@@ -108,6 +110,7 @@ struct v4l2_ctrl_hevc_sps {
 
 struct v4l2_ctrl_hevc_pps {
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture parameter set */
+	__u8	pic_parameter_set_id;
 	__u8	num_extra_slice_header_bits;
 	__u8	num_ref_idx_l0_default_active_minus1;
 	__u8	num_ref_idx_l1_default_active_minus1;
@@ -199,7 +202,8 @@ struct v4l2_ctrl_hevc_slice_params {
 	__u32	slice_segment_addr;
 	__u8	ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-
+	__u16	short_term_ref_pic_set_size;
+	__u16	long_term_ref_pic_set_size;
 	__u8	padding;
 
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Weighted prediction parameter */
@@ -214,6 +218,8 @@ struct v4l2_ctrl_hevc_slice_params {
 
 struct v4l2_ctrl_hevc_decode_params {
 	__s32	pic_order_cnt_val;
+	__u16	short_term_ref_pic_set_size;
+	__u16	long_term_ref_pic_set_size;
 	__u8	num_active_dpb_entries;
 	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	num_poc_st_curr_before;
-- 
2.32.0

