Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7187512F07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344798AbiD1Ixm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiD1Ixb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:53:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DD02DED;
        Thu, 28 Apr 2022 01:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 580FBB82919;
        Thu, 28 Apr 2022 08:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE94DC385A9;
        Thu, 28 Apr 2022 08:50:07 +0000 (UTC)
Message-ID: <5daa1dcd-a3a7-f508-e731-3a013ebc82ea@xs4all.nl>
Date:   Thu, 28 Apr 2022 10:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 23/24] media: hantro: Add H.264 field decoding support
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
 <20220426125751.108293-24-nicolas.dufresne@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220426125751.108293-24-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 14:57, Nicolas Dufresne wrote:
> This adds the required code to support field decoding. While most of
> the code is derived from Rockchip and VSI reference code, the
> reduction of the reference list to 16 entries was found by
> trial and errors. The list consists of all the references with the
> opposite field parity.
> 
> The strategy is to deduplicate the reference picture that points
> to the same storage (same index). The choice of opposite parity has
> been made to keep the other field of the current field pair in the
> list. This method may not be robust if a field was lost.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  drivers/staging/media/hantro/hantro_h264.c | 122 ++++++++++++++++++---
>  drivers/staging/media/hantro/hantro_hw.h   |   1 +
>  2 files changed, 109 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/staging/media/hantro/hantro_h264.c
> index 7377fc26f780..7502dddb324c 100644
> --- a/drivers/staging/media/hantro/hantro_h264.c
> +++ b/drivers/staging/media/hantro/hantro_h264.c
> @@ -22,6 +22,12 @@
>  #define POC_BUFFER_SIZE			34
>  #define SCALING_LIST_SIZE		(6 * 16 + 2 * 64)
>  
> +/*
> + * For valid and long term reference marking, index are reversed, so bit 31
> + * indicates the status of the picture 0.
> + */
> +#define REF_BIT(i)			BIT(32 - 1 - (i))
> +
>  /* Data structure describing auxiliary buffer format. */
>  struct hantro_h264_dec_priv_tbl {
>  	u32 cabac_table[CABAC_INIT_BUFFER_SIZE];
> @@ -227,6 +233,7 @@ static void prepare_table(struct hantro_ctx *ctx)
>  {
>  	const struct hantro_h264_dec_ctrls *ctrls = &ctx->h264_dec.ctrls;
>  	const struct v4l2_ctrl_h264_decode_params *dec_param = ctrls->decode;
> +	const struct v4l2_ctrl_h264_sps *sps = ctrls->sps;
>  	struct hantro_h264_dec_priv_tbl *tbl = ctx->h264_dec.priv.cpu;
>  	const struct v4l2_h264_dpb_entry *dpb = ctx->h264_dec.dpb;
>  	u32 dpb_longterm = 0;
> @@ -237,20 +244,45 @@ static void prepare_table(struct hantro_ctx *ctx)
>  		tbl->poc[i * 2] = dpb[i].top_field_order_cnt;
>  		tbl->poc[i * 2 + 1] = dpb[i].bottom_field_order_cnt;
>  
> +		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
> +			continue;
> +
>  		/*
>  		 * Set up bit maps of valid and long term DPBs.
> -		 * NOTE: The bits are reversed, i.e. MSb is DPB 0.
> +		 * NOTE: The bits are reversed, i.e. MSb is DPB 0. For frame
> +		 * decoding, bit 31 to 15 are used, while for field decoding,
> +		 * all bits are used, with bit 31 being a top field, 30 a bottom
> +		 * field and so on.
>  		 */
> -		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> -			dpb_valid |= BIT(HANTRO_H264_DPB_SIZE - 1 - i);
> -		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
> -			dpb_longterm |= BIT(HANTRO_H264_DPB_SIZE - 1 - i);
> +		if (dec_param->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC) {
> +			if (dpb[i].fields & V4L2_H264_TOP_FIELD_REF)
> +				dpb_valid |= REF_BIT(i * 2);
> +
> +			if (dpb[i].fields & V4L2_H264_BOTTOM_FIELD_REF)
> +				dpb_valid |= REF_BIT(i * 2 + 1);
> +
> +			if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM) {
> +				dpb_longterm |= REF_BIT(i * 2);
> +				dpb_longterm |= REF_BIT(i * 2 + 1);
> +			}
> +		} else {
> +			dpb_valid |= REF_BIT(i);
> +
> +			if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
> +				dpb_longterm |= REF_BIT(i);
> +		}
> +	}
> +	ctx->h264_dec.dpb_valid = dpb_valid;
> +	ctx->h264_dec.dpb_longterm = dpb_longterm;
> +
> +	if ((dec_param->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC) ||
> +	    !(sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD)) {
> +		tbl->poc[32] = ctx->h264_dec.cur_poc;
> +		tbl->poc[33] = 0;
> +	} else {
> +		tbl->poc[32] = dec_param->top_field_order_cnt;
> +		tbl->poc[33] = dec_param->bottom_field_order_cnt;
>  	}
> -	ctx->h264_dec.dpb_valid = dpb_valid << 16;
> -	ctx->h264_dec.dpb_longterm = dpb_longterm << 16;
> -
> -	tbl->poc[32] = dec_param->top_field_order_cnt;
> -	tbl->poc[33] = dec_param->bottom_field_order_cnt;
>  
>  	assemble_scaling_list(ctx);
>  }
> @@ -326,6 +358,8 @@ dma_addr_t hantro_h264_get_ref_buf(struct hantro_ctx *ctx,
>  {
>  	struct v4l2_h264_dpb_entry *dpb = ctx->h264_dec.dpb;
>  	dma_addr_t dma_addr = 0;
> +	s32 cur_poc = ctx->h264_dec.cur_poc;
> +	u32 flags;
>  
>  	if (dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
>  		dma_addr = hantro_get_ref(ctx, dpb[dpb_idx].reference_ts);
> @@ -343,7 +377,12 @@ dma_addr_t hantro_h264_get_ref_buf(struct hantro_ctx *ctx,
>  		dma_addr = hantro_get_dec_buf_addr(ctx, buf);
>  	}
>  
> -	return dma_addr;
> +	flags = dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_FIELD ? 0x2 : 0;
> +	flags |= abs(dpb[dpb_idx].top_field_order_cnt - cur_poc) <
> +		 abs(dpb[dpb_idx].bottom_field_order_cnt - cur_poc) ?
> +		 0x1 : 0;
> +
> +	return dma_addr | flags;
>  }
>  
>  u16 hantro_h264_get_ref_nbr(struct hantro_ctx *ctx, unsigned int dpb_idx)
> @@ -355,6 +394,47 @@ u16 hantro_h264_get_ref_nbr(struct hantro_ctx *ctx, unsigned int dpb_idx)
>  	return dpb->frame_num;
>  }
>  
> +/*
> + * Removes all references with he same parity as current picture from the
> + * reference list. The remaining list will have references with the opposite
> + * parity. This is effectively a deduplication of references since each buffer
> + * stores two fields. For this eason, each buffer are found twice in the
> + * reference list.
> + *
> + * This technique has been chosen through trial and error. This simple approach
> + * resulted in the highest conformance score. Note that this method may suffer
> + * worse quality in the case an opposite reference frame has been lost. If this
> + * becomes a problem in the future, it should be possible to add a preprocessing
> + * to identify un-paired fields and avoid removing them.
> + */
> +static void deduplicate_reflist(struct v4l2_h264_reflist_builder *b,
> +				struct v4l2_h264_reference *reflist)
> +{
> +	int write_idx = 0;
> +	int i;
> +
> +	if (b->cur_pic_fields == V4L2_H264_FRAME_REF) {
> +		write_idx = b->num_valid;
> +		goto done;
> +	}
> +
> +	for (i = 0; i < b->num_valid; i++) {
> +		if (!(b->cur_pic_fields == reflist[i].fields)) {
> +			reflist[write_idx++] = reflist[i];
> +			continue;
> +		}
> +	}
> +
> +done:
> +	/* Should not happen unless we have a bug in the reflist builder. */
> +	if (WARN_ON(write_idx > 16))
> +		write_idx = 16;
> +
> +	/* Clear the remaining, some streams fails otherwise */
> +	for (; write_idx < 16; write_idx++)
> +		reflist[write_idx].index = 15;
> +}
> +
>  int hantro_h264_dec_prepare_run(struct hantro_ctx *ctx)
>  {
>  	struct hantro_h264_dec_hw_ctx *h264_ctx = &ctx->h264_dec;
> @@ -386,15 +466,29 @@ int hantro_h264_dec_prepare_run(struct hantro_ctx *ctx)
>  	/* Update the DPB with new refs. */
>  	update_dpb(ctx);
>  
> -	/* Prepare data in memory. */
> -	prepare_table(ctx);
> -
>  	/* Build the P/B{0,1} ref lists. */
>  	v4l2_h264_init_reflist_builder(&reflist_builder, ctrls->decode,
>  				       ctrls->sps, ctx->h264_dec.dpb);
> +	h264_ctx->cur_poc = reflist_builder.cur_pic_order_count;
> +
> +	/* Prepare data in memory. */
> +	prepare_table(ctx);
> +
>  	v4l2_h264_build_p_ref_list(&reflist_builder, h264_ctx->reflists.p);
>  	v4l2_h264_build_b_ref_lists(&reflist_builder, h264_ctx->reflists.b0,
>  				    h264_ctx->reflists.b1);
> +
> +	/*
> +	 * Reduce ref lists to at most 16 entries, Hantro hardware will deduce
> +	 * the actual picture lists in field through the dpb_valid,
> +	 * dpb_longterm bitmap along with the current frame parity.
> +	 */
> +	if (reflist_builder.cur_pic_fields != V4L2_H264_FRAME_REF) {
> +		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.p);
> +		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.b0);
> +		deduplicate_reflist(&reflist_builder, h264_ctx->reflists.b1);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> index 292aaaabaf24..fd869369fb97 100644
> --- a/drivers/staging/media/hantro/hantro_hw.h
> +++ b/drivers/staging/media/hantro/hantro_hw.h
> @@ -91,6 +91,7 @@ struct hantro_h264_dec_hw_ctx {
>  	struct hantro_h264_dec_ctrls ctrls;
>  	u32 dpb_longterm;
>  	u32 dpb_valid;
> +	s32 cur_poc;

This field isn't documented in kerneldoc.

I've added this:

+ * @cur_poc:   Current picture order count

Is that a correct description? If not, let me know what it should be.

I'll update the patch manually, no need to repost.

Regards,

	Hans

>  };
>  
>  /**

