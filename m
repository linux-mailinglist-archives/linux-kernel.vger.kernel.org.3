Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E8A4EBD24
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244560AbiC3JFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbiC3JFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:05:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5B7BB6;
        Wed, 30 Mar 2022 02:03:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:d:7e3f:91e1:4be5:4001:fd80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9E6271F43F72;
        Wed, 30 Mar 2022 10:03:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648631029;
        bh=thl7w5H/Mz6OVUPKz9FOv3R7KrVbcm5LF6AXzXqidsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHyESjBbe18iqD6nzkiIOwqByEB/lHoMy4TlCriirvL38orqA+XYP1XFaNMqTQm/r
         bUxdvI8tum0PgAJwAWuBJi8Ojvt2sGFZN/J8yiJW/yzyFD6vjekKTGfRCZrcFsHb61
         eki4GaJoYxiePqLm23e8dG0bhCVFKAejNQCfJDbHXmOjdaj7KpoMzgiiTGs0p7Sq0s
         jACbjADR2x1lN48KppP6ru2RL67KJuMWwxtx0oF459xzc9wPIc1H/cspypHTS2jwSp
         JGyq7p3+tPxh5s3dCXB4xcizdiNJNMIkrmgNigEapOoJMzp+bQVNKSkoIUJWK/8gsI
         MDYOkeNt9QDUQ==
Date:   Wed, 30 Mar 2022 11:03:45 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 23/24] media: hantro: Add H.264 field decoding support
Message-ID: <20220330090345.pxx54emtalz6vgqt@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-24-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-24-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

On 28.03.2022 15:59, Nicolas Dufresne wrote:
>This adds the required code to support field decoding. While most of
>the code is derived from Rockchip and VSI reference code, the
>reduction of the reference list to 16 entries has been found by

s/has been/was/

>trial and errors. The list consist of all the references with the

s/consist/consists/

>opposite field parity.
>
>The strategy being to deduplicate the reference picture that points

s/strategy being to/strategy is to/

>to the same storage (same index). The choice of opposite parity has
>been made to keep the other field or a field pair to be kept in the

Do you mean?

s/keep the other field or a field pair to be kept/
   keep the other field of a field pair/

>list. This method may not be robust if a field was lost.
>
>Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>---
> drivers/staging/media/hantro/hantro_h264.c | 107 ++++++++++++++++++---
> drivers/staging/media/hantro/hantro_hw.h   |   1 +
> 2 files changed, 94 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/staging/media/hantro/hantro_h264.c
>index 7377fc26f780..f6fc939aa726 100644
>--- a/drivers/staging/media/hantro/hantro_h264.c
>+++ b/drivers/staging/media/hantro/hantro_h264.c
>@@ -22,6 +22,11 @@
> #define POC_BUFFER_SIZE			34
> #define SCALING_LIST_SIZE		(6 * 16 + 2 * 64)
>
>+/* For valid and long term reference marking, index are reversed, so bit 31

s/index/indeces/

>+ * indicates the status of the picture 0.
>+ */
>+#define REF_BIT(i)			BIT(32 - 1 - (i))
>+
> /* Data structure describing auxiliary buffer format. */
> struct hantro_h264_dec_priv_tbl {
> 	u32 cabac_table[CABAC_INIT_BUFFER_SIZE];
>@@ -227,6 +232,7 @@ static void prepare_table(struct hantro_ctx *ctx)
> {
> 	const struct hantro_h264_dec_ctrls *ctrls = &ctx->h264_dec.ctrls;
> 	const struct v4l2_ctrl_h264_decode_params *dec_param = ctrls->decode;
>+	const struct v4l2_ctrl_h264_sps *sps = ctrls->sps;
> 	struct hantro_h264_dec_priv_tbl *tbl = ctx->h264_dec.priv.cpu;
> 	const struct v4l2_h264_dpb_entry *dpb = ctx->h264_dec.dpb;
> 	u32 dpb_longterm = 0;
>@@ -237,20 +243,45 @@ static void prepare_table(struct hantro_ctx *ctx)
> 		tbl->poc[i * 2] = dpb[i].top_field_order_cnt;
> 		tbl->poc[i * 2 + 1] = dpb[i].bottom_field_order_cnt;
>
>+		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
>+			continue;
>+
> 		/*
> 		 * Set up bit maps of valid and long term DPBs.
>-		 * NOTE: The bits are reversed, i.e. MSb is DPB 0.
>+		 * NOTE: The bits are reversed, i.e. MSb is DPB 0. For frame
>+		 * decoding, bit 31 to 15 are used, while for field decoding,

s/bit 31/bits 31/

>+		 * all bits are used, with bit 31 being a top field, 30 a bottom
>+		 * field and so on.
> 		 */
>-		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
>-			dpb_valid |= BIT(HANTRO_H264_DPB_SIZE - 1 - i);
>-		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
>-			dpb_longterm |= BIT(HANTRO_H264_DPB_SIZE - 1 - i);
>+		if (dec_param->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC) {
>+			if (dpb[i].fields & V4L2_H264_TOP_FIELD_REF)
>+				dpb_valid |= REF_BIT(i * 2);
>+
>+			if (dpb[i].fields & V4L2_H264_BOTTOM_FIELD_REF)
>+				dpb_valid |= REF_BIT(i * 2 + 1);
>+
>+			if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM) {
>+				dpb_longterm |= REF_BIT(i * 2);
>+				dpb_longterm |= REF_BIT(i * 2 + 1);
>+			}
>+		} else {
>+			dpb_valid |= REF_BIT(i);
>+
>+			if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
>+				dpb_longterm |= REF_BIT(i);
>+		}
>+	}
>+	ctx->h264_dec.dpb_valid = dpb_valid;
>+	ctx->h264_dec.dpb_longterm = dpb_longterm;
>+
>+	if ((dec_param->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC) ||
>+	    !(sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD)) {
>+		tbl->poc[32] = ctx->h264_dec.cur_poc;
>+		tbl->poc[33] = 0;
>+	} else {
>+		tbl->poc[32] = dec_param->top_field_order_cnt;
>+		tbl->poc[33] = dec_param->bottom_field_order_cnt;
> 	}
>-	ctx->h264_dec.dpb_valid = dpb_valid << 16;
>-	ctx->h264_dec.dpb_longterm = dpb_longterm << 16;
>-
>-	tbl->poc[32] = dec_param->top_field_order_cnt;
>-	tbl->poc[33] = dec_param->bottom_field_order_cnt;
>
> 	assemble_scaling_list(ctx);
> }
>@@ -326,6 +357,8 @@ dma_addr_t hantro_h264_get_ref_buf(struct hantro_ctx *ctx,
> {
> 	struct v4l2_h264_dpb_entry *dpb = ctx->h264_dec.dpb;
> 	dma_addr_t dma_addr = 0;
>+	s32 cur_poc = ctx->h264_dec.cur_poc;
>+	u32 flags;
>
> 	if (dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> 		dma_addr = hantro_get_ref(ctx, dpb[dpb_idx].reference_ts);
>@@ -343,7 +376,12 @@ dma_addr_t hantro_h264_get_ref_buf(struct hantro_ctx *ctx,
> 		dma_addr = hantro_get_dec_buf_addr(ctx, buf);
> 	}
>
>-	return dma_addr;
>+	flags = dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_FIELD ? 0x2 : 0;

>+	flags |= abs(dpb[dpb_idx].top_field_order_cnt - cur_poc) <
>+		 abs(dpb[dpb_idx].bottom_field_order_cnt - cur_poc) ?
>+		 0x1 : 0;

You use the magic values `0x1` & `0x2` here, can you replace those with
macros?

It looks 0x2 indicates that we have a field and 0x1 indicates the
distance of the current picture to the bottom field is greater than
the distance of the current picture to the top field. (inidicating that
the order is correct?)

So maybe:
```
#define HANTRO_H264_FIELD_DMA_ADDR              0x1
#define HANTRO_H264_CORRECT_FIELD_ORDER         0x2
```


>+
>+	return dma_addr | flags;
> }
>
> u16 hantro_h264_get_ref_nbr(struct hantro_ctx *ctx, unsigned int dpb_idx)
>@@ -355,6 +393,34 @@ u16 hantro_h264_get_ref_nbr(struct hantro_ctx *ctx, unsigned int dpb_idx)
> 	return dpb->frame_num;
> }
>
>+static void deduplicate_reflist(struct v4l2_h264_reflist_builder *b,
>+				struct v4l2_h264_reference *reflist)

Can you add a comment describing why we need to deduplicate the
reference list? And maybe also why we get duplications in the first
place? Why must we limit the size to 16?
This would increase the readability of the code a lot.

>+{
>+	int write_idx = 0;
>+	int i;
>+
>+	if (b->cur_pic_fields == V4L2_H264_FRAME_REF) {
>+		write_idx = b->num_valid;
>+		goto done;
>+	}
>+
>+	for (i = 0; i < b->num_valid; i++) {
>+		if (!(b->cur_pic_fields == reflist[i].fields)) {
>+			reflist[write_idx++] = reflist[i];
>+			continue;
>+		}
>+	}
>+
>+done:
>+	/* Should not happen unless we have a bug in the reflist builder. */
>+	if (WARN_ON(write_idx > 16))
>+		write_idx = 16;
>+
>+	/* Clear the remaining, some streams fails otherwise */

s/the remaining/the remaining entries/
s/fails/fail/

>+	for (; write_idx < 16; write_idx++)
>+		reflist[write_idx].index = 15;
>+}
>+
> int hantro_h264_dec_prepare_run(struct hantro_ctx *ctx)
> {
> 	struct hantro_h264_dec_hw_ctx *h264_ctx = &ctx->h264_dec;
>@@ -386,15 +452,28 @@ int hantro_h264_dec_prepare_run(struct hantro_ctx *ctx)
> 	/* Update the DPB with new refs. */
> 	update_dpb(ctx);
>
>-	/* Prepare data in memory. */
>-	prepare_table(ctx);
>-
> 	/* Build the P/B{0,1} ref lists. */
> 	v4l2_h264_init_reflist_builder(&reflist_builder, ctrls->decode,
> 				       ctrls->sps, ctx->h264_dec.dpb);
>+	h264_ctx->cur_poc = reflist_builder.cur_pic_order_count;
>+
>+	/* Prepare data in memory. */
>+	prepare_table(ctx);
>+
> 	v4l2_h264_build_p_ref_list(&reflist_builder, h264_ctx->reflists.p);
> 	v4l2_h264_build_b_ref_lists(&reflist_builder, h264_ctx->reflists.b0,
> 				    h264_ctx->reflists.b1);
>+
>+	/* Reduce ref lists to at most 16 entries, Hantro hardware will deduce
>+	 * the actual picture lists in field through the dpb_valid,

s/in field/in a field/

>+	 * dpb_longterm bitmap along with the current frame parity.

s/bitmap/bitmaps/

Greetings,
Sebastian

>+	 */
>+	if (reflist_builder.cur_pic_fields != V4L2_H264_FRAME_REF) {
>+		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.p);
>+		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.b0);
>+		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.b1);
>+	}
>+
> 	return 0;
> }
>
>diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
>index 292aaaabaf24..fd869369fb97 100644
>--- a/drivers/staging/media/hantro/hantro_hw.h
>+++ b/drivers/staging/media/hantro/hantro_hw.h
>@@ -91,6 +91,7 @@ struct hantro_h264_dec_hw_ctx {
> 	struct hantro_h264_dec_ctrls ctrls;
> 	u32 dpb_longterm;
> 	u32 dpb_valid;
>+	s32 cur_poc;
> };
>
> /**
>-- 
>2.34.1
>
