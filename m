Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC47570CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiGKVep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGKVeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:34:44 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E52626AD5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:34:43 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s128so8250644oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M0jwb/p2RAjR9mwxwcrAtJW8BXE8d9G9r+svEfZ26d8=;
        b=4WsKIAa/37niWt1aZb9gLoOfQ1A+lUfSrOoHC05lYfsW9GliaMN4d+mTYivHcHvs0j
         68NkopX5mQg7OP69uU5R1pZhozixQ9BikiS/2shm7IRreIyNwEt9zK3d3aO9gyh3ti+Q
         xzxt6S2V3RN/1xhCHVtfQw0lMuY1VIZPCZLTR6kwiKEGYE2lj+qa+a6UOjq2T6aToydz
         3ezr3N+gBzZgLPbBcq15hd5lrQQ+KLY+CWKldhlFnUJDvAjeNfTaLvA78EIOPLqmKRm4
         zRb8GrAuEvsFnZ0Xivs2/hdk0df3+GfvV+OlxXPYTHkVkzYn/GIDTOIKXH4RrL5oLs6Y
         5V/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M0jwb/p2RAjR9mwxwcrAtJW8BXE8d9G9r+svEfZ26d8=;
        b=8PlSl+eggAxu+d5cVk44wEcaOG29CME6pjZZ/WXri4LyRorrYFIsVMFTro8MEAOMCM
         pMTdb8L6KMcD0wgOK36L+q63mk2IIbxQnNmICReWpvThgwRpDqBsg9T4+IhW7hR9mPXl
         cjoJgndozGysqsdloV/M5Q0Umnqk/x7gB0xLn1NqgE1iWOPeKcDAXY5VMe331vnQwpRX
         9HQN53uK093mG7k+SXlzfApQTpQvHivbFQ5YxHwmHw8VOT1nQOgmvfeev3cTvjLOYf2J
         KuZR+TCbFC3NKYTqEqKKKYSbZ565VatII+WH++ZqxBMPYVrry3D558lwM1usdYm+MuEU
         SjFA==
X-Gm-Message-State: AJIora/PsUs870WrDj6GTfGcMsQGoBBvjSpmMBIZcArKt3L/NOkbZn6R
        nC5B7XAgyukdmde3EFQB8Sjdw9DZ0yCnqSv8Xvw=
X-Google-Smtp-Source: AGRyM1tg0bd8EcGx54PRUcM8qcljgq6tyj9FLRsThf2aZZtqrEDQy56Sc8YRFmF/OfaUFai4N7ZMDQ==
X-Received: by 2002:a05:6808:23d4:b0:337:e764:90eb with SMTP id bq20-20020a05680823d400b00337e76490ebmr237596oib.205.1657575282626;
        Mon, 11 Jul 2022 14:34:42 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id d1-20020a0568301b6100b0061c4b17c0b7sm1760490ote.43.2022.07.11.14.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:34:41 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:34:36 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org, mchehab@kernel.org,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] media: cedrus: h265: Implement support for tiles
Message-ID: <YsyXbPEk+uawvaPu@eze-laptop>
References: <20220620175517.648767-1-jernej.skrabec@gmail.com>
 <20220620175517.648767-8-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620175517.648767-8-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 07:55:17PM +0200, Jernej Skrabec wrote:
> Tiles are last remaining unimplemented functionality for HEVC. Implement
> it.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Looks good.

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c   |  10 ++
>  drivers/staging/media/sunxi/cedrus/cedrus.h   |   4 +
>  .../staging/media/sunxi/cedrus/cedrus_dec.c   |   4 +
>  .../staging/media/sunxi/cedrus/cedrus_h265.c  | 108 +++++++++++++++++-
>  4 files changed, 120 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
> index b855e608885c..960a0130cd62 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -189,6 +189,16 @@ static const struct cedrus_control cedrus_controls[] = {
>  		},
>  		.codec		= CEDRUS_CODEC_H265,
>  	},
> +	{
> +		.cfg = {
> +			.id	= V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS,
> +			/* maximum 256 entry point offsets per slice */
> +			.dims	= { 256 },
> +			.max = 0xffffffff,
> +			.step = 1,
> +		},
> +		.codec		= CEDRUS_CODEC_H265,
> +	},
>  	{
>  		.cfg = {
>  			.id	= V4L2_CID_STATELESS_HEVC_DECODE_MODE,
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
> index 15a1bdbf6a1f..084193019350 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> @@ -81,6 +81,8 @@ struct cedrus_h265_run {
>  	const struct v4l2_ctrl_hevc_slice_params	*slice_params;
>  	const struct v4l2_ctrl_hevc_decode_params	*decode_params;
>  	const struct v4l2_ctrl_hevc_scaling_matrix	*scaling_matrix;
> +	const u32					*entry_points;
> +	u32						entry_points_count;
>  };
>  
>  struct cedrus_vp8_run {
> @@ -146,6 +148,8 @@ struct cedrus_ctx {
>  			ssize_t		mv_col_buf_unit_size;
>  			void		*neighbor_info_buf;
>  			dma_addr_t	neighbor_info_buf_addr;
> +			void		*entry_points_buf;
> +			dma_addr_t	entry_points_buf_addr;
>  		} h265;
>  		struct {
>  			unsigned int	last_frame_p_type;
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> index b0944abaacbd..3b6aa78a2985 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> @@ -75,6 +75,10 @@ void cedrus_device_run(void *priv)
>  			V4L2_CID_STATELESS_HEVC_DECODE_PARAMS);
>  		run.h265.scaling_matrix = cedrus_find_control_data(ctx,
>  			V4L2_CID_STATELESS_HEVC_SCALING_MATRIX);
> +		run.h265.entry_points = cedrus_find_control_data(ctx,
> +			V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS);
> +		run.h265.entry_points_count = cedrus_get_num_of_controls(ctx,
> +			V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS);
>  		break;
>  
>  	case V4L2_PIX_FMT_VP8_FRAME:
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> index 99020b9f9ff8..275fff1ab3a4 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> @@ -326,6 +326,65 @@ static int cedrus_h265_is_low_delay(struct cedrus_run *run)
>  	return 0;
>  }
>  
> +static void cedrus_h265_write_tiles(struct cedrus_ctx *ctx,
> +				    struct cedrus_run *run,
> +				    unsigned int ctb_addr_x,
> +				    unsigned int ctb_addr_y)
> +{
> +	const struct v4l2_ctrl_hevc_slice_params *slice_params;
> +	const struct v4l2_ctrl_hevc_pps *pps;
> +	struct cedrus_dev *dev = ctx->dev;
> +	const u32 *entry_points;
> +	u32 *entry_points_buf;
> +	int i, x, tx, y, ty;
> +
> +	pps = run->h265.pps;
> +	slice_params = run->h265.slice_params;
> +	entry_points = run->h265.entry_points;
> +	entry_points_buf = ctx->codec.h265.entry_points_buf;
> +
> +	for (x = 0, tx = 0; tx < pps->num_tile_columns_minus1 + 1; tx++) {
> +		if (x + pps->column_width_minus1[tx] + 1 > ctb_addr_x)
> +			break;
> +
> +		x += pps->column_width_minus1[tx] + 1;
> +	}
> +
> +	for (y = 0, ty = 0; ty < pps->num_tile_rows_minus1 + 1; ty++) {
> +		if (y + pps->row_height_minus1[ty] + 1 > ctb_addr_y)
> +			break;
> +
> +		y += pps->row_height_minus1[ty] + 1;
> +	}
> +
> +	cedrus_write(dev, VE_DEC_H265_TILE_START_CTB, (y << 16) | (x << 0));
> +	cedrus_write(dev, VE_DEC_H265_TILE_END_CTB,
> +		     ((y + pps->row_height_minus1[ty]) << 16) |
> +		     ((x + pps->column_width_minus1[tx]) << 0));
> +
> +	if (pps->flags & V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED) {
> +		for (i = 0; i < slice_params->num_entry_point_offsets; i++)
> +			entry_points_buf[i] = entry_points[i];
> +	} else {
> +		for (i = 0; i < slice_params->num_entry_point_offsets; i++) {
> +			if (tx + 1 >= pps->num_tile_columns_minus1 + 1) {
> +				x = 0;
> +				tx = 0;
> +				y += pps->row_height_minus1[ty++] + 1;
> +			} else {
> +				x += pps->column_width_minus1[tx++] + 1;
> +			}
> +
> +			entry_points_buf[i * 4 + 0] = entry_points[i];
> +			entry_points_buf[i * 4 + 1] = 0x0;
> +			entry_points_buf[i * 4 + 2] = (y << 16) | (x << 0);
> +			entry_points_buf[i * 4 + 3] =
> +				((y + pps->row_height_minus1[ty]) << 16) |
> +				((x + pps->column_width_minus1[tx]) << 0);
> +		}
> +	}
> +}
> +
>  static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  {
>  	struct cedrus_dev *dev = ctx->dev;
> @@ -336,9 +395,11 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  	const struct v4l2_hevc_pred_weight_table *pred_weight_table;
>  	unsigned int width_in_ctb_luma, ctb_size_luma;
>  	unsigned int log2_max_luma_coding_block_size;
> +	unsigned int ctb_addr_x, ctb_addr_y;
>  	dma_addr_t src_buf_addr;
>  	dma_addr_t src_buf_end_addr;
>  	u32 chroma_log2_weight_denom;
> +	u32 num_entry_point_offsets;
>  	u32 output_pic_list_index;
>  	u32 pic_order_cnt[2];
>  	u8 *padding;
> @@ -350,6 +411,15 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  	slice_params = run->h265.slice_params;
>  	decode_params = run->h265.decode_params;
>  	pred_weight_table = &slice_params->pred_weight_table;
> +	num_entry_point_offsets = slice_params->num_entry_point_offsets;
> +
> +	/*
> +	 * If entry points offsets are present, we should get them
> +	 * exactly the right amount.
> +	 */
> +	if (num_entry_point_offsets &&
> +	    num_entry_point_offsets != run->h265.entry_points_count)
> +		return -ERANGE;
>  
>  	log2_max_luma_coding_block_size =
>  		sps->log2_min_luma_coding_block_size_minus3 + 3 +
> @@ -416,12 +486,19 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  	cedrus_write(dev, VE_DEC_H265_BITS_END_ADDR, reg);
>  
>  	/* Coding tree block address */
> -	reg = VE_DEC_H265_DEC_CTB_ADDR_X(slice_params->slice_segment_addr % width_in_ctb_luma);
> -	reg |= VE_DEC_H265_DEC_CTB_ADDR_Y(slice_params->slice_segment_addr / width_in_ctb_luma);
> +	ctb_addr_x = slice_params->slice_segment_addr % width_in_ctb_luma;
> +	ctb_addr_y = slice_params->slice_segment_addr / width_in_ctb_luma;
> +	reg = VE_DEC_H265_DEC_CTB_ADDR_X(ctb_addr_x);
> +	reg |= VE_DEC_H265_DEC_CTB_ADDR_Y(ctb_addr_y);
>  	cedrus_write(dev, VE_DEC_H265_DEC_CTB_ADDR, reg);
>  
> -	cedrus_write(dev, VE_DEC_H265_TILE_START_CTB, 0);
> -	cedrus_write(dev, VE_DEC_H265_TILE_END_CTB, 0);
> +	if ((pps->flags & V4L2_HEVC_PPS_FLAG_TILES_ENABLED) ||
> +	    (pps->flags & V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED)) {
> +		cedrus_h265_write_tiles(ctx, run, ctb_addr_x, ctb_addr_y);
> +	} else {
> +		cedrus_write(dev, VE_DEC_H265_TILE_START_CTB, 0);
> +		cedrus_write(dev, VE_DEC_H265_TILE_END_CTB, 0);
> +	}
>  
>  	/* Clear the number of correctly-decoded coding tree blocks. */
>  	if (ctx->fh.m2m_ctx->new_frame)
> @@ -548,7 +625,9 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  				V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED,
>  				pps->flags);
>  
> -	/* TODO: VE_DEC_H265_DEC_PPS_CTRL1_FLAG_TILES_ENABLED */
> +	reg |= VE_DEC_H265_FLAG(VE_DEC_H265_DEC_PPS_CTRL1_FLAG_TILES_ENABLED,
> +				V4L2_HEVC_PPS_FLAG_TILES_ENABLED,
> +				pps->flags);
>  
>  	reg |= VE_DEC_H265_FLAG(VE_DEC_H265_DEC_PPS_CTRL1_FLAG_TRANSQUANT_BYPASS_ENABLED,
>  				V4L2_HEVC_PPS_FLAG_TRANSQUANT_BYPASS_ENABLED,
> @@ -626,12 +705,14 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
>  
>  	chroma_log2_weight_denom = pred_weight_table->luma_log2_weight_denom +
>  				   pred_weight_table->delta_chroma_log2_weight_denom;
> -	reg = VE_DEC_H265_DEC_SLICE_HDR_INFO2_NUM_ENTRY_POINT_OFFSETS(0) |
> +	reg = VE_DEC_H265_DEC_SLICE_HDR_INFO2_NUM_ENTRY_POINT_OFFSETS(num_entry_point_offsets) |
>  	      VE_DEC_H265_DEC_SLICE_HDR_INFO2_CHROMA_LOG2_WEIGHT_DENOM(chroma_log2_weight_denom) |
>  	      VE_DEC_H265_DEC_SLICE_HDR_INFO2_LUMA_LOG2_WEIGHT_DENOM(pred_weight_table->luma_log2_weight_denom);
>  
>  	cedrus_write(dev, VE_DEC_H265_DEC_SLICE_HDR_INFO2, reg);
>  
> +	cedrus_write(dev, VE_DEC_H265_ENTRY_POINT_OFFSET_ADDR, ctx->codec.h265.entry_points_buf_addr >> 8);
> +
>  	/* Decoded picture size. */
>  
>  	reg = VE_DEC_H265_DEC_PIC_SIZE_WIDTH(ctx->src_fmt.width) |
> @@ -728,6 +809,18 @@ static int cedrus_h265_start(struct cedrus_ctx *ctx)
>  	if (!ctx->codec.h265.neighbor_info_buf)
>  		return -ENOMEM;
>  
> +	ctx->codec.h265.entry_points_buf =
> +		dma_alloc_coherent(dev->dev, CEDRUS_H265_ENTRY_POINTS_BUF_SIZE,
> +				   &ctx->codec.h265.entry_points_buf_addr,
> +				   GFP_KERNEL);
> +	if (!ctx->codec.h265.entry_points_buf) {
> +		dma_free_attrs(dev->dev, CEDRUS_H265_NEIGHBOR_INFO_BUF_SIZE,
> +			       ctx->codec.h265.neighbor_info_buf,
> +			       ctx->codec.h265.neighbor_info_buf_addr,
> +			       DMA_ATTR_NO_KERNEL_MAPPING);
> +		return -ENOMEM;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -748,6 +841,9 @@ static void cedrus_h265_stop(struct cedrus_ctx *ctx)
>  		       ctx->codec.h265.neighbor_info_buf,
>  		       ctx->codec.h265.neighbor_info_buf_addr,
>  		       DMA_ATTR_NO_KERNEL_MAPPING);
> +	dma_free_coherent(dev->dev, CEDRUS_H265_ENTRY_POINTS_BUF_SIZE,
> +			  ctx->codec.h265.entry_points_buf,
> +			  ctx->codec.h265.entry_points_buf_addr);
>  }
>  
>  static void cedrus_h265_trigger(struct cedrus_ctx *ctx)
> -- 
> 2.36.1
> 
