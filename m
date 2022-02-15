Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADFC4B6A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiBOLBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:01:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiBOLB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:01:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C33FF9F84;
        Tue, 15 Feb 2022 03:01:17 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:6d7b:ae43:289b:7e7c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 73C541F444DF;
        Tue, 15 Feb 2022 11:01:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644922876;
        bh=lso4RA3n7iLwC6PwFUXxy6rDVaKVLSu3cwsoMhLh8VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7UBW5B5aVLXrLJLUT8UuVUfzyx6RhCgdFo5sOrUlyux158Mt12E3rb7Rikul2wze
         JBq4nJZng+/IK1xdtSr2UKm8JA72mJ3x1zLPCk9ysTuedFPc9rmbVCDrUAAOlT6sOt
         2318J9/5u8sEIX/RglVXCIfY1mQx6kXQxQBd+96jyu+E9XuQF3db4YmgXQyY0sKGzZ
         YLnUIlZjduxKkJszCbzpMLjdoWkzgLrmn8AnWIhmDSpFXI3lvLRSMlcBvIs2lC2Eop
         l4Y6iyVpBwouBGmOC1ZoUW77TekmEyH9sbz8cPjmSFI3FxkW5Q6hQIEdk5liUsAISh
         lQyWNRYvwvycw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl,
        jonas@kwiboo.se, nicolas@ndufresne.ca
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [RFC v2 5/8] media: uapi: Add fields needed for RKVDEC driver
Date:   Tue, 15 Feb 2022 12:01:00 +0100
Message-Id: <20220215110103.241297-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220215110103.241297-1-benjamin.gaignard@collabora.com>
References: <20220215110103.241297-1-benjamin.gaignard@collabora.com>
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

RKVDEC driver requires additional fields to perform HEVC decoding.
Even if the driver isn't mainlined yet WIP patches could be find here:
https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockchip/patches/linux/default/linux-2000-v4l2-wip-rkvdec-hevc.patch

This patch only include the change in HEVC uAPI.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../userspace-api/media/v4l/ext-ctrls-codec.rst  | 16 ++++++++++++++++
 include/uapi/linux/v4l2-controls.h               |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 4f3b3ba8319f..3296ac3b9fca 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2661,6 +2661,13 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     :stub-columns: 0
     :widths:       1 1 2
 
+    * - __u8
+      - ``video_parameter_set_id``
+      - Identifies the VPS for reference by other syntax elements.
+    * - __u8
+      - ``seq_parameter_set_id``
+      - Provides an identifier for the SPS for reference by other syntax
+        elements.
     * - __u16
       - ``pic_width_in_luma_samples``
       -
@@ -2800,6 +2807,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     :stub-columns: 0
     :widths:       1 1 2
 
+    * - __u8
+      - ``pic_parameter_set_id``
+      - Identifies the PPS for reference by other syntax elements.
     * - __u8
       - ``num_extra_slice_header_bits``
       -
@@ -3026,6 +3036,12 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     * - __u8
       - ``ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
       - The list of L1 reference elements as indices in the DPB.
+    * - __u16
+      - ``short_term_ref_pic_set_size``
+      -
+    * - __u16
+      - ``long_term_ref_pic_set_size``
+      -
     * - __u8
       - ``padding``
       - Applications and drivers must set this to zero.
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 0e0ec2c61b80..b1a3dc05f02f 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -2341,6 +2341,8 @@ enum v4l2_stateless_hevc_start_code {
 
 struct v4l2_ctrl_hevc_sps {
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Sequence parameter set */
+	__u8	video_parameter_set_id;
+	__u8	seq_parameter_set_id;
 	__u16	pic_width_in_luma_samples;
 	__u16	pic_height_in_luma_samples;
 	__u8	bit_depth_luma_minus8;
@@ -2393,6 +2395,7 @@ struct v4l2_ctrl_hevc_sps {
 
 struct v4l2_ctrl_hevc_pps {
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture parameter set */
+	__u8	pic_parameter_set_id;
 	__u8	num_extra_slice_header_bits;
 	__u8	num_ref_idx_l0_default_active_minus1;
 	__u8	num_ref_idx_l1_default_active_minus1;
@@ -2487,6 +2490,8 @@ struct v4l2_ctrl_hevc_slice_params {
 	__u32	slice_segment_addr;
 	__u8	ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
 	__u8	ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__u16	short_term_ref_pic_set_size;
+	__u16	long_term_ref_pic_set_size;
 
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Weighted prediction parameter */
 	struct v4l2_hevc_pred_weight_table pred_weight_table;
-- 
2.32.0

