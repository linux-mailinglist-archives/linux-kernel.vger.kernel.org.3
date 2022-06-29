Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB12560A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiF2TOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiF2TOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:14:14 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900D93B3DF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:14:12 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id e131so22891295oif.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gsQHUW3cWs2ueLnrGdQ0Nv0XzCOV6whneenQWRvHie4=;
        b=ZlOhcKNpZ9zQiwt3xlFdWeqTwZWp0lQSlaFoaAPZXxdNWv71svHTsiqzsYC4Drbhpq
         Wc0HZNB8kAo2kZ3Nt624HdRHc0HL+MJk5jXtIXirtn/n4lsu5j206dUblyNN61/3hrml
         WAmlBApCXfnVnewdkJRMOIYxioCT60h8dyMf1dBJREVU4xJLEsLQn2Ckw0O1ug2xtCaJ
         7aaN1kMiHCaNa4pCL4KNDOEP9FrPREavCL4LrIlC+VPF21Phit+Q22Ejmt3QkJaDGYgG
         lb/rNVoKBdLawYDkC7u11COo0vpcz2ZjNBXDr9bjtoWo6O0pnef+YUT+S5y80qRZrFGJ
         Mhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gsQHUW3cWs2ueLnrGdQ0Nv0XzCOV6whneenQWRvHie4=;
        b=xWXoGq3+WIAr3QiRDzlOFTFqbzn69trfyVzWMuqxVsl9dXl1aBNaJNI+Rj6t0SKaoe
         5OHP+u+8DdrAIhtbUQ2t5I2R/dtEqmgeW85hsXX0N4Ll6Y0HnYOxsACGLPRmcGtv6a2d
         eTVNG90mVpUmSg7fqVmhjhmyhe1XPMR7AaF70rmKvtuf9WZuMH93rujNrE7XmRYDVi91
         ds38e1/tY99GQvJGhNHA99o+2D81OLlU71IrhlWG+7OBvRoZZn41uvRRyIHt4LjsVnoJ
         t2E61KuRvwWn1TMwaGINCluJ9jNIQ1tmohMg9fgDtVI1A68aRcnnF9ojuPBUoE6MFdLr
         zjWg==
X-Gm-Message-State: AJIora+P+FQIygi37E7QjE2atASaQ2HOpg7Ao7UtfijMJinNqjvzdQT7
        cZwr2JQUIh6qGos1eccy6O0dng==
X-Google-Smtp-Source: AGRyM1s3/6EZgU1A7RZ9zY9AkMLlI/H8FJYfZ6VvfW+D2DdP5k29qnFiyb2lgpv7W6hB0hZO8JiGKA==
X-Received: by 2002:aca:3090:0:b0:335:b264:8bd7 with SMTP id w138-20020aca3090000000b00335b2648bd7mr2295348oiw.194.1656530051503;
        Wed, 29 Jun 2022 12:14:11 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id b11-20020a9d60cb000000b00616dfd2c859sm3676390otk.59.2022.06.29.12.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:14:10 -0700 (PDT)
Date:   Wed, 29 Jun 2022 16:14:05 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, benjamin.gaignard@collabora.com,
        nicolas.dufresne@collabora.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/7] media: hantro: Support format filtering by depth
Message-ID: <YrykfXBR9x9du2mP@eze-laptop>
References: <20220616202513.351039-1-jernej.skrabec@gmail.com>
 <20220616202513.351039-3-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616202513.351039-3-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On Thu, Jun 16, 2022 at 10:25:08PM +0200, Jernej Skrabec wrote:
> In preparation for supporting 10-bit formats, add mechanism which will
> filter formats based on pixel depth.
> 
> Hantro G2 supports only one decoding format natively and that is based
> on bit depth of current video frame. Additionally, it makes no sense to
> upconvert bitness, so filter those out too.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks,
Ezequiel

> ---
>  drivers/staging/media/hantro/hantro.h      |  4 ++
>  drivers/staging/media/hantro/hantro_v4l2.c | 48 ++++++++++++++++++++--
>  drivers/staging/media/hantro/hantro_v4l2.h |  1 +
>  3 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
> index 26308bb29adc..2989ebc631cc 100644
> --- a/drivers/staging/media/hantro/hantro.h
> +++ b/drivers/staging/media/hantro/hantro.h
> @@ -227,6 +227,7 @@ struct hantro_dev {
>   *
>   * @ctrl_handler:	Control handler used to register controls.
>   * @jpeg_quality:	User-specified JPEG compression quality.
> + * @bit_depth:		Bit depth of current frame
>   *
>   * @codec_ops:		Set of operations related to codec mode.
>   * @postproc:		Post-processing context.
> @@ -252,6 +253,7 @@ struct hantro_ctx {
>  
>  	struct v4l2_ctrl_handler ctrl_handler;
>  	int jpeg_quality;
> +	int bit_depth;
>  
>  	const struct hantro_codec_ops *codec_ops;
>  	struct hantro_postproc_ctx postproc;
> @@ -277,6 +279,7 @@ struct hantro_ctx {
>   * @enc_fmt:	Format identifier for encoder registers.
>   * @frmsize:	Supported range of frame sizes (only for bitstream formats).
>   * @postprocessed: Indicates if this format needs the post-processor.
> + * @match_depth: Indicates if format bit depth must match video bit depth
>   */
>  struct hantro_fmt {
>  	char *name;
> @@ -287,6 +290,7 @@ struct hantro_fmt {
>  	enum hantro_enc_fmt enc_fmt;
>  	struct v4l2_frmsize_stepwise frmsize;
>  	bool postprocessed;
> +	bool match_depth;
>  };
>  
>  struct hantro_reg {
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
> index 29cc61d53b71..334f18a4120d 100644
> --- a/drivers/staging/media/hantro/hantro_v4l2.c
> +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> @@ -64,6 +64,42 @@ hantro_get_postproc_formats(const struct hantro_ctx *ctx,
>  	return ctx->dev->variant->postproc_fmts;
>  }
>  
> +int hantro_get_format_depth(u32 fourcc)
> +{
> +	switch (fourcc) {
> +	case V4L2_PIX_FMT_P010:
> +	case V4L2_PIX_FMT_P010_4L4:
> +		return 10;
> +	default:
> +		return 8;
> +	}
> +}
> +
> +static bool
> +hantro_check_depth_match(const struct hantro_ctx *ctx,
> +			 const struct hantro_fmt *fmt)
> +{
> +	int fmt_depth, ctx_depth = 8;
> +
> +	if (!fmt->match_depth && !fmt->postprocessed)
> +		return true;
> +
> +	/* 0 means default depth, which is 8 */
> +	if (ctx->bit_depth)
> +		ctx_depth = ctx->bit_depth;
> +
> +	fmt_depth = hantro_get_format_depth(fmt->fourcc);
> +
> +	/*
> +	 * Allow only downconversion for postproc formats for now.
> +	 * It may be possible to relax that on some HW.
> +	 */
> +	if (!fmt->match_depth)
> +		return fmt_depth <= ctx_depth;
> +
> +	return fmt_depth == ctx_depth;
> +}
> +
>  static const struct hantro_fmt *
>  hantro_find_format(const struct hantro_ctx *ctx, u32 fourcc)
>  {
> @@ -91,7 +127,8 @@ hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
>  	formats = hantro_get_formats(ctx, &num_fmts);
>  	for (i = 0; i < num_fmts; i++) {
>  		if (bitstream == (formats[i].codec_mode !=
> -				  HANTRO_MODE_NONE))
> +				  HANTRO_MODE_NONE) &&
> +		    hantro_check_depth_match(ctx, &formats[i]))
>  			return &formats[i];
>  	}
>  	return NULL;
> @@ -162,11 +199,13 @@ static int vidioc_enum_fmt(struct file *file, void *priv,
>  	formats = hantro_get_formats(ctx, &num_fmts);
>  	for (i = 0; i < num_fmts; i++) {
>  		bool mode_none = formats[i].codec_mode == HANTRO_MODE_NONE;
> +		fmt = &formats[i];
>  
>  		if (skip_mode_none == mode_none)
>  			continue;
> +		if (!hantro_check_depth_match(ctx, fmt))
> +			continue;
>  		if (j == f->index) {
> -			fmt = &formats[i];
>  			f->pixelformat = fmt->fourcc;
>  			return 0;
>  		}
> @@ -182,8 +221,11 @@ static int vidioc_enum_fmt(struct file *file, void *priv,
>  		return -EINVAL;
>  	formats = hantro_get_postproc_formats(ctx, &num_fmts);
>  	for (i = 0; i < num_fmts; i++) {
> +		fmt = &formats[i];
> +
> +		if (!hantro_check_depth_match(ctx, fmt))
> +			continue;
>  		if (j == f->index) {
> -			fmt = &formats[i];
>  			f->pixelformat = fmt->fourcc;
>  			return 0;
>  		}
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.h b/drivers/staging/media/hantro/hantro_v4l2.h
> index 18bc682c8556..b17e84c82582 100644
> --- a/drivers/staging/media/hantro/hantro_v4l2.h
> +++ b/drivers/staging/media/hantro/hantro_v4l2.h
> @@ -22,5 +22,6 @@ extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
>  extern const struct vb2_ops hantro_queue_ops;
>  
>  void hantro_reset_fmts(struct hantro_ctx *ctx);
> +int hantro_get_format_depth(u32 fourcc);
>  
>  #endif /* HANTRO_V4L2_H_ */
> -- 
> 2.36.1
> 
