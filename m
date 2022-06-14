Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABCE54AB10
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353335AbiFNHuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354832AbiFNHuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:50:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953C43EB99;
        Tue, 14 Jun 2022 00:49:59 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4a7b:8d3a:acaa:ec46])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DAA1F66016AF;
        Tue, 14 Jun 2022 08:49:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655192998;
        bh=pjNKQqJt+fujWp4j47KE/erfcCEMJ6ylcH5fLNYA0qE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ggJtl62OO92tSpb7U3nJhD+Q4TGYNlPbY0qmSok58NJuh/J3FWX6kRX9rSC4ItRdn
         E6Qj/9R8TvqEjF62zSVvuZ5FrGnu0kWdPoH092d4OUEX4ldYM/IrtIpCRNot0k/Dhy
         CCIBqEO+hqQXRDbq09P21zR+w032BSVy6pc60Fi/83R/u9Gw7X8+OVPIyMVx8/00EE
         ZLC/yIqgUkhVZrjGQEDO63+2n6T36Y9F5NU7uLtRvpVsErgIJGmwaFNRm/eblYid38
         DidExo0uWA0VhzDqhyaNa1wHMrUmf3DN3CLypJsbAuadSZr2JEPUaabccAANLE8XVp
         qmcTr+hcuecAg==
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
Subject: [PATCH v7 04/17] media: uapi: HEVC: Add missing fields in HEVC controls
Date:   Tue, 14 Jun 2022 09:49:34 +0200
Message-Id: <20220614074947.160316-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220614074947.160316-1-benjamin.gaignard@collabora.com>
References: <20220614074947.160316-1-benjamin.gaignard@collabora.com>
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
---
version 6:
- Add short_term_ref_pic_set_size and long_term_ref_pic_set_size
  in v4l2_ctrl_hevc_decode_params structure.

 .../media/v4l/ext-ctrls-codec.rst             | 32 +++++++++++++++++++
 include/media/hevc-ctrls.h                    |  8 ++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 6183f43f4d73..aa7556e200c9 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2683,6 +2683,16 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     :stub-columns: 0
     :widths:       1 1 2
 
+    * - __u8
+      - ``video_parameter_set_id``
+      - Specifies the value of the vps_video_parameter_set_id of the active VPS
+        as descibed in section "7.4.3.2.1 General sequence parameter set RBSP semantics"
+        of H.265 specifications.
+    * - __u8
+      - ``seq_parameter_set_id``
+      - Provides an identifier for the SPS for reference by other syntax elements
+        as descibed in section "7.4.3.2.1 General sequence parameter set RBSP semantics"
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

