Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6411450883B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378596AbiDTMec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378680AbiDTMcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:32:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0791B3F881;
        Wed, 20 Apr 2022 05:29:43 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:20a1:8b3:e6a6:ce93] (unknown [IPv6:2a01:e0a:120:3210:20a1:8b3:e6a6:ce93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 25DA91F43982;
        Wed, 20 Apr 2022 13:29:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650457782;
        bh=H+PP79rknT2OvgWP2ipJfTN1cp/CyBPl0VFlV8Lwtz4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nyPRjHOafQHOrvRso9wQ5FBs6M5Xk6zrVK3yMb1uQvFQPehy4ky2MjrmFyZcSIr5G
         powHReFZRtLmXJfVplO5OCCzFrnD5azhA/azOVoyz0259DMx9LnjYH5qSJXM62ooJB
         mYje8VWSpPaea4VgF/9b1TGrKRtpBbR3axYbPgrtZAPyyxDcDCIVGGneOcAlR18f8a
         il7YOfnEurKT+6MXF6jCktR9NgxW5FF6FzDY/bulAig99ctDxBTOJDpCXB6oIHTiB7
         +oZPCQTLLCUXLHzySgh2AiCW9pkGc38ZG+PPsVLXm1kMVf2gAa7tEOmwgaXKTj4cOf
         fsEAK62thMlPQ==
Message-ID: <e7a8f62f-5c72-55ed-8b5f-b3603fc14712@collabora.com>
Date:   Wed, 20 Apr 2022 14:29:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: hantro: Use post processor scaling capacities
Content-Language: en-US
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220404140819.733931-1-benjamin.gaignard@collabora.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20220404140819.733931-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 04/04/2022 à 16:08, Benjamin Gaignard a écrit :
> Hantro G2 post processor is able to down scale decoded frames
> by 2, 4, or 8 factor.
> Add enum_framesizes() ops to postproc_ops structure to enumerate the
> possible output sizes for a given input resolution.
> For G2 post-processor use fsize->index (from 0 to 3) has power of 2
> diviser. As describe in v4l2 documentation return -EINVAL when scaling
> down isn't possible.

Gentle ping for this patch.

Thanks,
Benjamin

>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> Fluster score with this patch is 77/147 like before.
>
>   drivers/staging/media/hantro/hantro.h         |  2 +
>   drivers/staging/media/hantro/hantro_g2_regs.h |  6 +++
>   drivers/staging/media/hantro/hantro_hw.h      |  8 ++-
>   .../staging/media/hantro/hantro_postproc.c    | 53 ++++++++++++++++++-
>   drivers/staging/media/hantro/hantro_v4l2.c    | 15 +++---
>   5 files changed, 72 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
> index 357f83b86809..26308bb29adc 100644
> --- a/drivers/staging/media/hantro/hantro.h
> +++ b/drivers/staging/media/hantro/hantro.h
> @@ -475,5 +475,7 @@ void hantro_postproc_disable(struct hantro_ctx *ctx);
>   void hantro_postproc_enable(struct hantro_ctx *ctx);
>   void hantro_postproc_free(struct hantro_ctx *ctx);
>   int hantro_postproc_alloc(struct hantro_ctx *ctx);
> +int hanto_postproc_enum_framesizes(struct hantro_ctx *ctx,
> +				   struct v4l2_frmsizeenum *fsize);
>   
>   #endif /* HANTRO_H_ */
> diff --git a/drivers/staging/media/hantro/hantro_g2_regs.h b/drivers/staging/media/hantro/hantro_g2_regs.h
> index b7c6f9877b9d..877d663a8181 100644
> --- a/drivers/staging/media/hantro/hantro_g2_regs.h
> +++ b/drivers/staging/media/hantro/hantro_g2_regs.h
> @@ -290,6 +290,10 @@
>   #define g2_buswidth		G2_DEC_REG(58, 8,  0x7)
>   #define g2_max_burst		G2_DEC_REG(58, 0,  0xff)
>   
> +#define g2_down_scale_e		G2_DEC_REG(184, 7, 0x1)
> +#define g2_down_scale_y		G2_DEC_REG(184, 2, 0x3)
> +#define g2_down_scale_x		G2_DEC_REG(184, 0, 0x3)
> +
>   #define G2_REG_CONFIG				G2_SWREG(58)
>   #define G2_REG_CONFIG_DEC_CLK_GATE_E		BIT(16)
>   #define G2_REG_CONFIG_DEC_CLK_GATE_IDLE_E	BIT(17)
> @@ -312,6 +316,8 @@
>   #define G2_TILE_FILTER_ADDR		(G2_SWREG(179))
>   #define G2_TILE_SAO_ADDR		(G2_SWREG(181))
>   #define G2_TILE_BSD_ADDR		(G2_SWREG(183))
> +#define G2_DS_DST			(G2_SWREG(186))
> +#define G2_DS_DST_CHR			(G2_SWREG(188))
>   
>   #define g2_strm_buffer_len	G2_DEC_REG(258, 0, 0xffffffff)
>   #define g2_strm_start_offset	G2_DEC_REG(259, 0, 0xffffffff)
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> index ed018e293ba0..09f17a3ceb95 100644
> --- a/drivers/staging/media/hantro/hantro_hw.h
> +++ b/drivers/staging/media/hantro/hantro_hw.h
> @@ -245,12 +245,16 @@ struct hantro_postproc_ctx {
>   /**
>    * struct hantro_postproc_ops - post-processor operations
>    *
> - * @enable:	Enable the post-processor block. Optional.
> - * @disable:	Disable the post-processor block. Optional.
> + * @enable:		Enable the post-processor block. Optional.
> + * @disable:		Disable the post-processor block. Optional.
> + * @enum_framesizes:	Enumerate possible scaled output formats.
> + *			Returns zero if OK, a negative value in error cases.
> + *			Optional.
>    */
>   struct hantro_postproc_ops {
>   	void (*enable)(struct hantro_ctx *ctx);
>   	void (*disable)(struct hantro_ctx *ctx);
> +	int (*enum_framesizes)(struct hantro_ctx *ctx, struct v4l2_frmsizeenum *fsize);
>   };
>   
>   /**
> diff --git a/drivers/staging/media/hantro/hantro_postproc.c b/drivers/staging/media/hantro/hantro_postproc.c
> index 248abe5423f0..ab168c1c0d28 100644
> --- a/drivers/staging/media/hantro/hantro_postproc.c
> +++ b/drivers/staging/media/hantro/hantro_postproc.c
> @@ -100,21 +100,58 @@ static void hantro_postproc_g1_enable(struct hantro_ctx *ctx)
>   	HANTRO_PP_REG_WRITE(vpu, display_width, ctx->dst_fmt.width);
>   }
>   
> +static int down_scale_factor(struct hantro_ctx *ctx)
> +{
> +	if (ctx->src_fmt.width == ctx->dst_fmt.width)
> +		return 0;
> +
> +	return DIV_ROUND_CLOSEST(ctx->src_fmt.width, ctx->dst_fmt.width);
> +}
> +
>   static void hantro_postproc_g2_enable(struct hantro_ctx *ctx)
>   {
>   	struct hantro_dev *vpu = ctx->dev;
>   	struct vb2_v4l2_buffer *dst_buf;
>   	size_t chroma_offset = ctx->dst_fmt.width * ctx->dst_fmt.height;
> +	int down_scale = down_scale_factor(ctx);
>   	dma_addr_t dst_dma;
>   
>   	dst_buf = hantro_get_dst_buf(ctx);
>   	dst_dma = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
>   
> -	hantro_write_addr(vpu, G2_RS_OUT_LUMA_ADDR, dst_dma);
> -	hantro_write_addr(vpu, G2_RS_OUT_CHROMA_ADDR, dst_dma + chroma_offset);
> +	if (down_scale) {
> +		hantro_reg_write(vpu, &g2_down_scale_e, 1);
> +		hantro_reg_write(vpu, &g2_down_scale_y, down_scale >> 2);
> +		hantro_reg_write(vpu, &g2_down_scale_x, down_scale >> 2);
> +		hantro_write_addr(vpu, G2_DS_DST, dst_dma);
> +		hantro_write_addr(vpu, G2_DS_DST_CHR, dst_dma + (chroma_offset >> down_scale));
> +	} else {
> +		hantro_write_addr(vpu, G2_RS_OUT_LUMA_ADDR, dst_dma);
> +		hantro_write_addr(vpu, G2_RS_OUT_CHROMA_ADDR, dst_dma + chroma_offset);
> +	}
>   	hantro_reg_write(vpu, &g2_out_rs_e, 1);
>   }
>   
> +static int hantro_postproc_g2_enum_framesizes(struct hantro_ctx *ctx,
> +					      struct v4l2_frmsizeenum *fsize)
> +{
> +	/**
> +	 * G2 scaler can scale down by 0, 2, 4 or 8
> +	 * use fsize->index has power of 2 diviser
> +	 **/
> +	if (fsize->index > 3)
> +		return -EINVAL;
> +
> +	if (!ctx->src_fmt.width || !ctx->src_fmt.height)
> +		return -EINVAL;
> +
> +	fsize->type = V4L2_FRMSIZE_TYPE_DISCRETE;
> +	fsize->discrete.width = ctx->src_fmt.width >> fsize->index;
> +	fsize->discrete.height = ctx->src_fmt.height >> fsize->index;
> +
> +	return 0;
> +}
> +
>   void hantro_postproc_free(struct hantro_ctx *ctx)
>   {
>   	struct hantro_dev *vpu = ctx->dev;
> @@ -197,6 +234,17 @@ void hantro_postproc_enable(struct hantro_ctx *ctx)
>   		vpu->variant->postproc_ops->enable(ctx);
>   }
>   
> +int hanto_postproc_enum_framesizes(struct hantro_ctx *ctx,
> +				   struct v4l2_frmsizeenum *fsize)
> +{
> +	struct hantro_dev *vpu = ctx->dev;
> +
> +	if (vpu->variant->postproc_ops && vpu->variant->postproc_ops->enum_framesizes)
> +		return vpu->variant->postproc_ops->enum_framesizes(ctx, fsize);
> +
> +	return -EINVAL;
> +}
> +
>   const struct hantro_postproc_ops hantro_g1_postproc_ops = {
>   	.enable = hantro_postproc_g1_enable,
>   	.disable = hantro_postproc_g1_disable,
> @@ -205,4 +253,5 @@ const struct hantro_postproc_ops hantro_g1_postproc_ops = {
>   const struct hantro_postproc_ops hantro_g2_postproc_ops = {
>   	.enable = hantro_postproc_g2_enable,
>   	.disable = hantro_postproc_g2_disable,
> +	.enum_framesizes = hantro_postproc_g2_enum_framesizes,
>   };
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
> index 67148ba346f5..8314a2efd4c8 100644
> --- a/drivers/staging/media/hantro/hantro_v4l2.c
> +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> @@ -116,12 +116,6 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
>   	struct hantro_ctx *ctx = fh_to_ctx(priv);
>   	const struct hantro_fmt *fmt;
>   
> -	if (fsize->index != 0) {
> -		vpu_debug(0, "invalid frame size index (expected 0, got %d)\n",
> -			  fsize->index);
> -		return -EINVAL;
> -	}
> -
>   	fmt = hantro_find_format(ctx, fsize->pixel_format);
>   	if (!fmt) {
>   		vpu_debug(0, "unsupported bitstream format (%08x)\n",
> @@ -129,9 +123,14 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
>   		return -EINVAL;
>   	}
>   
> -	/* This only makes sense for coded formats */
> -	if (fmt->codec_mode == HANTRO_MODE_NONE)
> +	/* For non-coded formats check if postprocessing scaling is possible */
> +	if (fmt->codec_mode == HANTRO_MODE_NONE && hantro_needs_postproc(ctx, fmt)) {
> +		return hanto_postproc_enum_framesizes(ctx, fsize);
> +	} else if (fsize->index != 0) {
> +		vpu_debug(0, "invalid frame size index (expected 0, got %d)\n",
> +			  fsize->index);
>   		return -EINVAL;
> +	}
>   
>   	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
>   	fsize->stepwise = fmt->frmsize;
