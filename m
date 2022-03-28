Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EC74EA107
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344262AbiC1UDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344184AbiC1UCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:02:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D2F5C858;
        Mon, 28 Mar 2022 13:00:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 3FA4D1F438C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648497625;
        bh=8ZY/TY5wUQG0UMY3VQ/LrDrnewxXRhJm8xn75yuBk5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LSDm5ErzEA5Fbw1ws4czjOsu3fDm4pT7JTICNQb9Fxicx6vsUkjVibEJRKm5wdL1O
         RBQz0zvf0GFTHerfTot93aA7pF8puNqK0jfkRs9hc6KNv9c0YQ/snt2M+kxyvVWs+S
         3EBf7R+5vYaeovxq0AC+6izjekHkVTooXRWLjT7GU7RtNgNCmzqDnta4gia2cQ1DoH
         TG4bC9yYVGWQsG3EzJrtji98AFV+6ZbCgyA0PWPcYOHg/UAQfX/9jawDNdU2juVia5
         Ft73gjEr8k+CaHrjhTKr7JNAoe8Ku9MUs/j0HW1rub/lD3a9+Xd9eIlAtko1TX8l1T
         9C9nhjLJIUDBA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v1 23/24] media: hantro: Add H.264 field decoding support
Date:   Mon, 28 Mar 2022 15:59:35 -0400
Message-Id: <20220328195936.82552-24-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
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

This adds the required code to support field decoding. While most of
the code is derived from Rockchip and VSI reference code, the
reduction of the reference list to 16 entries has been found by
trial and errors. The list consist of all the references with the
opposite field parity.

The strategy being to deduplicate the reference picture that points
to the same storage (same index). The choice of opposite parity has
been made to keep the other field or a field pair to be kept in the
list. This method may not be robust if a field was lost.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/hantro/hantro_h264.c | 107 ++++++++++++++++++---
 drivers/staging/media/hantro/hantro_hw.h   |   1 +
 2 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/staging/media/hantro/hantro_h264.c
index 7377fc26f780..f6fc939aa726 100644
--- a/drivers/staging/media/hantro/hantro_h264.c
+++ b/drivers/staging/media/hantro/hantro_h264.c
@@ -22,6 +22,11 @@
 #define POC_BUFFER_SIZE			34
 #define SCALING_LIST_SIZE		(6 * 16 + 2 * 64)
 
+/* For valid and long term reference marking, index are reversed, so bit 31
+ * indicates the status of the picture 0.
+ */
+#define REF_BIT(i)			BIT(32 - 1 - (i))
+
 /* Data structure describing auxiliary buffer format. */
 struct hantro_h264_dec_priv_tbl {
 	u32 cabac_table[CABAC_INIT_BUFFER_SIZE];
@@ -227,6 +232,7 @@ static void prepare_table(struct hantro_ctx *ctx)
 {
 	const struct hantro_h264_dec_ctrls *ctrls = &ctx->h264_dec.ctrls;
 	const struct v4l2_ctrl_h264_decode_params *dec_param = ctrls->decode;
+	const struct v4l2_ctrl_h264_sps *sps = ctrls->sps;
 	struct hantro_h264_dec_priv_tbl *tbl = ctx->h264_dec.priv.cpu;
 	const struct v4l2_h264_dpb_entry *dpb = ctx->h264_dec.dpb;
 	u32 dpb_longterm = 0;
@@ -237,20 +243,45 @@ static void prepare_table(struct hantro_ctx *ctx)
 		tbl->poc[i * 2] = dpb[i].top_field_order_cnt;
 		tbl->poc[i * 2 + 1] = dpb[i].bottom_field_order_cnt;
 
+		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
+			continue;
+
 		/*
 		 * Set up bit maps of valid and long term DPBs.
-		 * NOTE: The bits are reversed, i.e. MSb is DPB 0.
+		 * NOTE: The bits are reversed, i.e. MSb is DPB 0. For frame
+		 * decoding, bit 31 to 15 are used, while for field decoding,
+		 * all bits are used, with bit 31 being a top field, 30 a bottom
+		 * field and so on.
 		 */
-		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
-			dpb_valid |= BIT(HANTRO_H264_DPB_SIZE - 1 - i);
-		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
-			dpb_longterm |= BIT(HANTRO_H264_DPB_SIZE - 1 - i);
+		if (dec_param->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC) {
+			if (dpb[i].fields & V4L2_H264_TOP_FIELD_REF)
+				dpb_valid |= REF_BIT(i * 2);
+
+			if (dpb[i].fields & V4L2_H264_BOTTOM_FIELD_REF)
+				dpb_valid |= REF_BIT(i * 2 + 1);
+
+			if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM) {
+				dpb_longterm |= REF_BIT(i * 2);
+				dpb_longterm |= REF_BIT(i * 2 + 1);
+			}
+		} else {
+			dpb_valid |= REF_BIT(i);
+
+			if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
+				dpb_longterm |= REF_BIT(i);
+		}
+	}
+	ctx->h264_dec.dpb_valid = dpb_valid;
+	ctx->h264_dec.dpb_longterm = dpb_longterm;
+
+	if ((dec_param->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC) ||
+	    !(sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD)) {
+		tbl->poc[32] = ctx->h264_dec.cur_poc;
+		tbl->poc[33] = 0;
+	} else {
+		tbl->poc[32] = dec_param->top_field_order_cnt;
+		tbl->poc[33] = dec_param->bottom_field_order_cnt;
 	}
-	ctx->h264_dec.dpb_valid = dpb_valid << 16;
-	ctx->h264_dec.dpb_longterm = dpb_longterm << 16;
-
-	tbl->poc[32] = dec_param->top_field_order_cnt;
-	tbl->poc[33] = dec_param->bottom_field_order_cnt;
 
 	assemble_scaling_list(ctx);
 }
@@ -326,6 +357,8 @@ dma_addr_t hantro_h264_get_ref_buf(struct hantro_ctx *ctx,
 {
 	struct v4l2_h264_dpb_entry *dpb = ctx->h264_dec.dpb;
 	dma_addr_t dma_addr = 0;
+	s32 cur_poc = ctx->h264_dec.cur_poc;
+	u32 flags;
 
 	if (dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
 		dma_addr = hantro_get_ref(ctx, dpb[dpb_idx].reference_ts);
@@ -343,7 +376,12 @@ dma_addr_t hantro_h264_get_ref_buf(struct hantro_ctx *ctx,
 		dma_addr = hantro_get_dec_buf_addr(ctx, buf);
 	}
 
-	return dma_addr;
+	flags = dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_FIELD ? 0x2 : 0;
+	flags |= abs(dpb[dpb_idx].top_field_order_cnt - cur_poc) <
+		 abs(dpb[dpb_idx].bottom_field_order_cnt - cur_poc) ?
+		 0x1 : 0;
+
+	return dma_addr | flags;
 }
 
 u16 hantro_h264_get_ref_nbr(struct hantro_ctx *ctx, unsigned int dpb_idx)
@@ -355,6 +393,34 @@ u16 hantro_h264_get_ref_nbr(struct hantro_ctx *ctx, unsigned int dpb_idx)
 	return dpb->frame_num;
 }
 
+static void deduplicate_reflist(struct v4l2_h264_reflist_builder *b,
+				struct v4l2_h264_reference *reflist)
+{
+	int write_idx = 0;
+	int i;
+
+	if (b->cur_pic_fields == V4L2_H264_FRAME_REF) {
+		write_idx = b->num_valid;
+		goto done;
+	}
+
+	for (i = 0; i < b->num_valid; i++) {
+		if (!(b->cur_pic_fields == reflist[i].fields)) {
+			reflist[write_idx++] = reflist[i];
+			continue;
+		}
+	}
+
+done:
+	/* Should not happen unless we have a bug in the reflist builder. */
+	if (WARN_ON(write_idx > 16))
+		write_idx = 16;
+
+	/* Clear the remaining, some streams fails otherwise */
+	for (; write_idx < 16; write_idx++)
+		reflist[write_idx].index = 15;
+}
+
 int hantro_h264_dec_prepare_run(struct hantro_ctx *ctx)
 {
 	struct hantro_h264_dec_hw_ctx *h264_ctx = &ctx->h264_dec;
@@ -386,15 +452,28 @@ int hantro_h264_dec_prepare_run(struct hantro_ctx *ctx)
 	/* Update the DPB with new refs. */
 	update_dpb(ctx);
 
-	/* Prepare data in memory. */
-	prepare_table(ctx);
-
 	/* Build the P/B{0,1} ref lists. */
 	v4l2_h264_init_reflist_builder(&reflist_builder, ctrls->decode,
 				       ctrls->sps, ctx->h264_dec.dpb);
+	h264_ctx->cur_poc = reflist_builder.cur_pic_order_count;
+
+	/* Prepare data in memory. */
+	prepare_table(ctx);
+
 	v4l2_h264_build_p_ref_list(&reflist_builder, h264_ctx->reflists.p);
 	v4l2_h264_build_b_ref_lists(&reflist_builder, h264_ctx->reflists.b0,
 				    h264_ctx->reflists.b1);
+
+	/* Reduce ref lists to at most 16 entries, Hantro hardware will deduce
+	 * the actual picture lists in field through the dpb_valid,
+	 * dpb_longterm bitmap along with the current frame parity.
+	 */
+	if (reflist_builder.cur_pic_fields != V4L2_H264_FRAME_REF) {
+		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.p);
+		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.b0);
+		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.b1);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index 292aaaabaf24..fd869369fb97 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -91,6 +91,7 @@ struct hantro_h264_dec_hw_ctx {
 	struct hantro_h264_dec_ctrls ctrls;
 	u32 dpb_longterm;
 	u32 dpb_valid;
+	s32 cur_poc;
 };
 
 /**
-- 
2.34.1

