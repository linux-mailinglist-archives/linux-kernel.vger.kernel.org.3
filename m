Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A2056BF37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbiGHQWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239012AbiGHQWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:22:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EE433E1D;
        Fri,  8 Jul 2022 09:22:18 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:3cab:61a1:2b1f:896b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E51F66019F7;
        Fri,  8 Jul 2022 17:22:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657297337;
        bh=ljC78Z2JAx0jLGp/fyK/qXKVwEXo68jXKXsRWY1Kabo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhUk+pFFQtnCbNkJ15ZlPoDJsJjlfF+cwuH+deZ/jdTbKRTeGV3NYTAAf1WSPiELd
         69yM/g1x+iIS65Pmu6fJkNeQmjzaFEUyz4R+jqYPjuwjw2QCBIUPA9sDEBYjxcfg3d
         kVYsN27okKvw8SH8JwHFGELuEPWS4v0NYPMcWdTesqxTPMn+v9JmausoafPJShVVBN
         azvXOy/FptBLj+5+ML9zkO7WwPjDvkyQHsPUwd6nkikz/bCI4GOi4RWsk0VDYpYqD9
         kpb44y3MV/cPJ2XXTpCWJA7xf1CrijzgPa67BBdt3mHGUziqDGX/VhnqltM1WTeVLg
         4iX4z7D6qs+MA==
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
Subject: [PATCH v13 06/17] media: uapi: HEVC: Change pic_order_cnt definition in v4l2_hevc_dpb_entry
Date:   Fri,  8 Jul 2022 18:21:45 +0200
Message-Id: <20220708162156.815772-7-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220708162156.815772-1-benjamin.gaignard@collabora.com>
References: <20220708162156.815772-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HEVC specification describes the following:
"PicOrderCntVal is derived as follows:
PicOrderCntVal = PicOrderCntMsb + slice_pic_order_cnt_lsb
The value of PicOrderCntVal shall be in the range of −2^31 to 2^31 − 1, inclusive."

To match with these definitions change __u16 pic_order_cnt[2]
into __s32 pic_order_cnt_val.
Change v4l2_ctrl_hevc_slice_params->slice_pic_order_cnt to __s32 too.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 +-
 drivers/staging/media/hantro/hantro_g2_hevc_dec.c         | 7 +++----
 drivers/staging/media/hantro/hantro_hevc.c                | 2 +-
 drivers/staging/media/hantro/hantro_hw.h                  | 4 ++--
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c          | 4 ++--
 include/media/hevc-ctrls.h                                | 4 ++--
 6 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 868669ae6831..3dfb81a93935 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -3010,7 +3010,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     * - __u8
       - ``colour_plane_id``
       -
-    * - __u16
+    * - __s32
       - ``slice_pic_order_cnt``
       -
     * - __u8
diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
index 5df6f08e26f5..d28653d04d20 100644
--- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
+++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
@@ -390,11 +390,10 @@ static int set_ref(struct hantro_ctx *ctx)
 			 !!(pps->flags & V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED));
 
 	/*
-	 * Write POC count diff from current pic. For frame decoding only compute
-	 * pic_order_cnt[0] and ignore pic_order_cnt[1] used in field-coding.
+	 * Write POC count diff from current pic.
 	 */
 	for (i = 0; i < decode_params->num_active_dpb_entries && i < ARRAY_SIZE(cur_poc); i++) {
-		char poc_diff = decode_params->pic_order_cnt_val - dpb[i].pic_order_cnt[0];
+		char poc_diff = decode_params->pic_order_cnt_val - dpb[i].pic_order_cnt_val;
 
 		hantro_reg_write(vpu, &cur_poc[i], poc_diff);
 	}
@@ -421,7 +420,7 @@ static int set_ref(struct hantro_ctx *ctx)
 	dpb_longterm_e = 0;
 	for (i = 0; i < decode_params->num_active_dpb_entries &&
 	     i < (V4L2_HEVC_DPB_ENTRIES_NUM_MAX - 1); i++) {
-		luma_addr = hantro_hevc_get_ref_buf(ctx, dpb[i].pic_order_cnt[0]);
+		luma_addr = hantro_hevc_get_ref_buf(ctx, dpb[i].pic_order_cnt_val);
 		if (!luma_addr)
 			return -ENOMEM;
 
diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
index 1df87ca88ebf..5984c5fa6f83 100644
--- a/drivers/staging/media/hantro/hantro_hevc.c
+++ b/drivers/staging/media/hantro/hantro_hevc.c
@@ -33,7 +33,7 @@ void hantro_hevc_ref_init(struct hantro_ctx *ctx)
 }
 
 dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx,
-				   int poc)
+				   s32 poc)
 {
 	struct hantro_hevc_dec_hw_ctx *hevc_dec = &ctx->hevc_dec;
 	int i;
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index a2e0f0836281..33d156ccbfeb 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -145,7 +145,7 @@ struct hantro_hevc_dec_hw_ctx {
 	struct hantro_aux_buf tile_bsd;
 	struct hantro_aux_buf ref_bufs[NUM_REF_PICTURES];
 	struct hantro_aux_buf scaling_lists;
-	int ref_bufs_poc[NUM_REF_PICTURES];
+	s32 ref_bufs_poc[NUM_REF_PICTURES];
 	u32 ref_bufs_used;
 	struct hantro_hevc_dec_ctrls ctrls;
 	unsigned int num_tile_cols_allocated;
@@ -357,7 +357,7 @@ void hantro_hevc_dec_exit(struct hantro_ctx *ctx);
 int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx);
 int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx);
 void hantro_hevc_ref_init(struct hantro_ctx *ctx);
-dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, int poc);
+dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, s32 poc);
 int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr);
 int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps);
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 44f385be9f6c..411601975124 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -143,8 +143,8 @@ static void cedrus_h265_frame_info_write_dpb(struct cedrus_ctx *ctx,
 	for (i = 0; i < num_active_dpb_entries; i++) {
 		int buffer_index = vb2_find_timestamp(vq, dpb[i].timestamp, 0);
 		u32 pic_order_cnt[2] = {
-			dpb[i].pic_order_cnt[0],
-			dpb[i].pic_order_cnt[1]
+			dpb[i].pic_order_cnt_val,
+			dpb[i].pic_order_cnt_val
 		};
 
 		cedrus_h265_frame_info_write_single(ctx, i, dpb[i].field_pic,
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
index 45734bd8fdfc..01c1795c57a9 100644
--- a/include/media/hevc-ctrls.h
+++ b/include/media/hevc-ctrls.h
@@ -138,7 +138,7 @@ struct v4l2_hevc_dpb_entry {
 	__u64	timestamp;
 	__u8	flags;
 	__u8	field_pic;
-	__u16	pic_order_cnt[2];
+	__s32	pic_order_cnt_val;
 	__u8	padding[2];
 };
 
@@ -181,7 +181,7 @@ struct v4l2_ctrl_hevc_slice_params {
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
 	__u8	slice_type;
 	__u8	colour_plane_id;
-	__u16	slice_pic_order_cnt;
+	__s32	slice_pic_order_cnt;
 	__u8	num_ref_idx_l0_active_minus1;
 	__u8	num_ref_idx_l1_active_minus1;
 	__u8	collocated_ref_idx;
-- 
2.32.0

