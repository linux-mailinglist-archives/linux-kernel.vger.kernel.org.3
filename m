Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C454B6A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiBOLBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:01:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbiBOLB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:01:27 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE866F956C;
        Tue, 15 Feb 2022 03:01:17 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:6d7b:ae43:289b:7e7c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 239561F444E4;
        Tue, 15 Feb 2022 11:01:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644922876;
        bh=RIHgRR/y4Gj0Ju5HMmg8MeO2eKGIydoWDH9lUH21XZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+xc9sPG288GPLGKGCVNRbUtzEFNdiXHK8+VyTMJGmDl9s3r6PKCkwKj0Xau1gmn2
         oYZ7owMH62DIVVrkoaEAcxrnEUsCpWJ50kMXjrZ18fqSFpA0NpCdXLBlnSf7lFSOA+
         XMgVHix02uA8aPPfEn+6sFtRzcQVf027wK3BE3zpKkLE2AX57ggPytvxfrPF7xumQ5
         /4rjkuWA7GcR9782mFxcAaFzPZY0OZiZgchQVr0dVv48lJCrw+/Qoa9WvPv32tivvW
         p5N3lhaCeoEw6GMTXK3XuAkCEDo9k+bUy64DPZ0KauqNsxU7EBSdYdDSb4qwOPYoQA
         Rws1u/T8BBLog==
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
Subject: [RFC v2 6/8] media: uapi: Remove bit_size field from v4l2_ctrl_hevc_slice_params
Date:   Tue, 15 Feb 2022 12:01:01 +0100
Message-Id: <20220215110103.241297-7-benjamin.gaignard@collabora.com>
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

The bit size of the slice could be deduced from the buffer payload
so remove bit_size field to avoid duplicated the information.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../userspace-api/media/v4l/ext-ctrls-codec.rst       |  3 ---
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c      | 11 ++++-------
 include/uapi/linux/v4l2-controls.h                    |  3 +--
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 3296ac3b9fca..c3ae97657fa7 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2965,9 +2965,6 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     :stub-columns: 0
     :widths:       1 1 2
 
-    * - __u32
-      - ``bit_size``
-      - Size (in bits) of the current slice data.
     * - __u32
       - ``data_bit_offset``
       - Offset (in bits) to the video data in the current slice data.
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 8ab2d9c6f048..db8c7475eeb8 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -312,8 +312,8 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
 	const struct v4l2_hevc_pred_weight_table *pred_weight_table;
 	unsigned int width_in_ctb_luma, ctb_size_luma;
 	unsigned int log2_max_luma_coding_block_size;
+	size_t slice_bytes;
 	dma_addr_t src_buf_addr;
-	dma_addr_t src_buf_end_addr;
 	u32 chroma_log2_weight_denom;
 	u32 output_pic_list_index;
 	u32 pic_order_cnt[2];
@@ -370,8 +370,8 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
 
 	cedrus_write(dev, VE_DEC_H265_BITS_OFFSET, 0);
 
-	reg = slice_params->bit_size;
-	cedrus_write(dev, VE_DEC_H265_BITS_LEN, reg);
+	slice_bytes = vb2_get_plane_payload(&run->src->vb2_buf, 0);
+	cedrus_write(dev, VE_DEC_H265_BITS_LEN, slice_bytes);
 
 	/* Source beginning and end addresses. */
 
@@ -384,10 +384,7 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
 
 	cedrus_write(dev, VE_DEC_H265_BITS_ADDR, reg);
 
-	src_buf_end_addr = src_buf_addr +
-			   DIV_ROUND_UP(slice_params->bit_size, 8);
-
-	reg = VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_end_addr);
+	reg = VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_addr + slice_bytes);
 	cedrus_write(dev, VE_DEC_H265_BITS_END_ADDR, reg);
 
 	/* Coding tree block address */
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index b1a3dc05f02f..27f5d272dc43 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -2457,7 +2457,6 @@ struct v4l2_hevc_pred_weight_table {
 #define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	(1ULL << 9)
 
 struct v4l2_ctrl_hevc_slice_params {
-	__u32	bit_size;
 	__u32	data_bit_offset;
 
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
@@ -2484,7 +2483,7 @@ struct v4l2_ctrl_hevc_slice_params {
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture timing SEI message */
 	__u8	pic_struct;
 
-	__u8	reserved;
+	__u8	reserved[5];
 
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
 	__u32	slice_segment_addr;
-- 
2.32.0

