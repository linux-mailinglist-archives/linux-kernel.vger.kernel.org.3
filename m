Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3744F507C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1842122AbiDFB1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457587AbiDEQLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:11:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACA2E0C4;
        Tue,  5 Apr 2022 09:09:08 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:cf29:3f0:be4d:7211] (unknown [IPv6:2a01:e0a:120:3210:cf29:3f0:be4d:7211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2DFB51F43F0D;
        Tue,  5 Apr 2022 17:09:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649174946;
        bh=eeySzn5IBf+PbYNi+kPSgsYzcuDGcdY6haFj9xgGbTc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bquGS9tF62KHpCx6KOlVue0u3BUHutbpdUkIswCR9dFWpqBqt9KTIZhdbkOkIg6S0
         5n2xd1750ecQX63Vs8TOqs39NgYYpYhtRV1t6PM4HIs72OOS+5VQxoFH+nMl/jbwmM
         MoMH95usmnc6FzA9zfnGsEhCZRd2dgBhftcFXzdzHxiElFBGm7MmpAFJrpct6Bj7ry
         EUCsInrPWwVbscgnQHQbTPVSxraI7RLgCevVwI6GjR3tRDPDX639GJsAt8wId1HaOc
         014r4nTSexAxfPlT6inGkQbKlLgmE1NOk4DqvEuLjCqTDgUGGP8Cy9z12GsYnUzX/k
         ERkD9KOJMHJgQ==
Message-ID: <7972feba-221c-9960-68d0-ee15ad2a4f1a@collabora.com>
Date:   Tue, 5 Apr 2022 18:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 3/8] media: hantro: Support format filtering by depth
Content-Language: en-US
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, nicolas@ndufresne.ca, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
 <20220227144926.3006585-4-jernej.skrabec@gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20220227144926.3006585-4-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 27/02/2022 à 15:49, Jernej Skrabec a écrit :
> In preparation for supporting 10-bit formats, add mechanism which will
> filter formats based on pixel depth.
>
> Hantro G2 supports only one decoding format natively and that is based
> on bit depth of current video frame. Additionally, it makes no sense to
> upconvert bitness, so filter those out too.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>   drivers/staging/media/hantro/hantro.h      |  4 ++
>   drivers/staging/media/hantro/hantro_v4l2.c | 48 ++++++++++++++++++++--
>   drivers/staging/media/hantro/hantro_v4l2.h |  1 +
>   3 files changed, 50 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
> index 06d0f3597694..c6525ee8d89a 100644
> --- a/drivers/staging/media/hantro/hantro.h
> +++ b/drivers/staging/media/hantro/hantro.h
> @@ -227,6 +227,7 @@ struct hantro_dev {
>    *
>    * @ctrl_handler:	Control handler used to register controls.
>    * @jpeg_quality:	User-specified JPEG compression quality.
> + * @bit_depth:		Bit depth of current frame
>    *
>    * @codec_ops:		Set of operations related to codec mode.
>    * @postproc:		Post-processing context.
> @@ -252,6 +253,7 @@ struct hantro_ctx {
>   
>   	struct v4l2_ctrl_handler ctrl_handler;
>   	int jpeg_quality;
> +	int bit_depth;
>   
>   	const struct hantro_codec_ops *codec_ops;
>   	struct hantro_postproc_ctx postproc;
> @@ -278,6 +280,7 @@ struct hantro_ctx {
>    * @enc_fmt:	Format identifier for encoder registers.
>    * @frmsize:	Supported range of frame sizes (only for bitstream formats).
>    * @postprocessed: Indicates if this format needs the post-processor.
> + * @match_depth: Indicates if format bit depth must match video bit depth
>    */
>   struct hantro_fmt {
>   	char *name;
> @@ -288,6 +291,7 @@ struct hantro_fmt {
>   	enum hantro_enc_fmt enc_fmt;
>   	struct v4l2_frmsize_stepwise frmsize;
>   	bool postprocessed;
> +	bool match_depth;
>   };
>   
>   struct hantro_reg {
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
> index e595905b3bd7..1214fa2f64ae 100644
> --- a/drivers/staging/media/hantro/hantro_v4l2.c
> +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> @@ -64,6 +64,42 @@ hantro_get_postproc_formats(const struct hantro_ctx *ctx,
>   	return ctx->dev->variant->postproc_fmts;
>   }
>   
> +int hantro_get_formath_depth(u32 fourcc)

Just a typo here:

s/hantro_get_formath_depth -> hantro_get_format_depth

regards
Benjamin

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
> +	fmt_depth = hantro_get_formath_depth(fmt->fourcc);
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
>   static const struct hantro_fmt *
>   hantro_find_format(const struct hantro_ctx *ctx, u32 fourcc)
>   {
> @@ -91,7 +127,8 @@ hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
>   	formats = hantro_get_formats(ctx, &num_fmts);
>   	for (i = 0; i < num_fmts; i++) {
>   		if (bitstream == (formats[i].codec_mode !=
> -				  HANTRO_MODE_NONE))
> +				  HANTRO_MODE_NONE) &&
> +		    hantro_check_depth_match(ctx, &formats[i]))
>   			return &formats[i];
>   	}
>   	return NULL;
> @@ -163,11 +200,13 @@ static int vidioc_enum_fmt(struct file *file, void *priv,
>   	formats = hantro_get_formats(ctx, &num_fmts);
>   	for (i = 0; i < num_fmts; i++) {
>   		bool mode_none = formats[i].codec_mode == HANTRO_MODE_NONE;
> +		fmt = &formats[i];
>   
>   		if (skip_mode_none == mode_none)
>   			continue;
> +		if (!hantro_check_depth_match(ctx, fmt))
> +			continue;
>   		if (j == f->index) {
> -			fmt = &formats[i];
>   			f->pixelformat = fmt->fourcc;
>   			return 0;
>   		}
> @@ -183,8 +222,11 @@ static int vidioc_enum_fmt(struct file *file, void *priv,
>   		return -EINVAL;
>   	formats = hantro_get_postproc_formats(ctx, &num_fmts);
>   	for (i = 0; i < num_fmts; i++) {
> +		fmt = &formats[i];
> +
> +		if (!hantro_check_depth_match(ctx, fmt))
> +			continue;
>   		if (j == f->index) {
> -			fmt = &formats[i];
>   			f->pixelformat = fmt->fourcc;
>   			return 0;
>   		}
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.h b/drivers/staging/media/hantro/hantro_v4l2.h
> index 18bc682c8556..f4a5905ed518 100644
> --- a/drivers/staging/media/hantro/hantro_v4l2.h
> +++ b/drivers/staging/media/hantro/hantro_v4l2.h
> @@ -22,5 +22,6 @@ extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
>   extern const struct vb2_ops hantro_queue_ops;
>   
>   void hantro_reset_fmts(struct hantro_ctx *ctx);
> +int hantro_get_formath_depth(u32 fourcc);
>   
>   #endif /* HANTRO_V4L2_H_ */
