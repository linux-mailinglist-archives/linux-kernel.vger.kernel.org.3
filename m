Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44FE4C6EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbiB1OJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiB1OJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:09:29 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0208253B6F;
        Mon, 28 Feb 2022 06:08:50 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:82d4:230a:70ff:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3BBCF1F43A81;
        Mon, 28 Feb 2022 14:08:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646057328;
        bh=8BMMvTMYNC+33Pe6AxkM36ZYEvGxAmnHaN5Utn2mP/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aGVf1og0gN2lTe8KZ6A+XyzJy/ip3ympMqUJF6Wv17heULnLYQeFxRmljEsLvHBBe
         Lf18AvC9z9XdKp2J8iOznLyPlubcpJD7R2majUyiFBjfg9abaD1PrMv2ppS7+Zwd3o
         3f27idxMCi20AdQbnaWsi1O+7mKHGuVZ5bjd2+yBhNUO4Uctfn7Ye9G+enK+amL/2k
         5dVktf0gsM52OpjzW69OF686R3LPscUJjVYutd9d64vxMW4es0/nzbiq2A+QTeh/z5
         2Jro2iHLRxQoAXgNCGhyVT39b9s80Ysb0sTq5WWyqEUzXskjW4KJlb+sEMEJdVP2nh
         2GjGk/VT9KhhA==
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
Subject: [PATCH v4 04/15] media: uapi: HEVC: Add missing fields in HEVC controls
Date:   Mon, 28 Feb 2022 15:08:27 +0100
Message-Id: <20220228140838.622021-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
References: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
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

Complete the HEVC controls with missing fields from H.265 specifications.
Even if these fields aren't used by the current mainlined drivers
they will be need for (at least) rkvdec driver.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/v4l/ext-ctrls-codec.rst             | 22 +++++++++++++++++++
 include/media/hevc-ctrls.h                    |  6 ++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 4cd7c541fc30..d096cb75993a 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2661,6 +2661,16 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
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
@@ -2800,6 +2810,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     :stub-columns: 0
     :widths:       1 1 2
 
+    * - __u8
+      - ``pic_parameter_set_id``
+      - Identifies the PPS for reference by other syntax elements.
     * - __u8
       - ``num_extra_slice_header_bits``
       -
@@ -3026,6 +3039,15 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     * - __u8
       - ``ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
       - The list of L1 reference elements as indices in the DPB.
+    * - __u16
+      - ``short_term_ref_pic_set_size``
+      - Specifies the number of st_ref_pic_set( ) syntax structures included in the SPS.
+        The value of num_short_term_ref_pic_sets shall be in the range of 0 to 64, inclusive.
+    * - __u16
+      - ``long_term_ref_pic_set_size``
+      - Specifies the number of candidate long-term reference pictures that are specified
+        in the SPS. The value of num_long_term_ref_pics_sps shall be in the range
+        of 0 to 32, inclusive.
     * - __u8
       - ``padding``
       - Applications and drivers must set this to zero.
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
index 01ccda48d8c5..a329e086a89a 100644
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
-- 
2.32.0

