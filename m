Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBDE55E95B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347188AbiF1Pyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiF1Py2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:54:28 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9462735875
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:54:26 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id h65so17723210oia.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9s0QaBc92dvqSy7LvwRSQHvJrBbfVuzRUIGci4bIuy8=;
        b=EEw+yeY16nQIMGhNOYTbmNvlvpmQkfqixMGy0PlQNnAFNKdadyUdZ3JU0CCEnfhBb+
         5/gtv7MXT4uGm0nLmx9CPi3CHtNawEYWF3kPGtT4sQQtSi3cd//iF1I2thGM2hfzTvj0
         +O/PqdVYwPOtzWCipAbxesPEEOMQP8u/+96NKk0rBQyZ3sv02qw+sfIr7rkPvQrCYupI
         pYEO5/EvmV5teZE7MD01OBVsLE5SVpoHzp4VLDny+JvedIvDl94sLZYYuGRIPDz4a17W
         x150Wruii5psW/Dd+9oRiTR7Q0MSB6n3Z6W1V2ZezTJN+ZEdkTk6cY3kDBKUZznjd+K0
         vlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9s0QaBc92dvqSy7LvwRSQHvJrBbfVuzRUIGci4bIuy8=;
        b=jp3Wm+2pyGufiDuX8AA2CFSemtCOqVgjTFjgHwYAUCzttc+wapzqtFwUDyTqCAD5Kl
         xIEZdEFu3gdIa3+2Usnu3rVC0tGspZFHWdtfHSbepfJsQQtJ0rs8y85nC3Nh96+0FTZ7
         neHMy8bx0R6FzLHeDd0DNky1Itw0/+73at5CqGvfOegmesyFibctW2y1x5CdGP78/H+r
         vldLCJnj3uIVfunJYM96yt577J69PcKS5HlJxLEcQ+wy0Nz6o9thoSqCtu6n/0KysNuR
         smY2yavqc5KWNbpSSRvL/ct/aW7iR5KS+Uns3yVue707RK9kncfdUxPsAxB4yvwS+LOE
         gqtA==
X-Gm-Message-State: AJIora+SKNXH6v978jsQzBnP1TPIIsKHwD1epR5Tj8FAJp5Nb/vd1CL+
        oPiHn6OGiVMupiYMsbkJh1mY4Q==
X-Google-Smtp-Source: AGRyM1teDI6cOFjKi7FCrOwX7B8iLc85sr8XBKPl0Vu4QHVwVIZdUlaxtJx+9/MyOXACv4ZuIJYf2w==
X-Received: by 2002:a05:6808:2099:b0:335:1606:2504 with SMTP id s25-20020a056808209900b0033516062504mr209210oiw.110.1656431665945;
        Tue, 28 Jun 2022 08:54:25 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id l14-20020a4ae2ce000000b00425b69ca19asm1302270oot.48.2022.06.28.08.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 08:54:24 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:54:19 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, benjamin.gaignard@collabora.com,
        nicolas.dufresne@collabora.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/7] media: hantro: postproc: Fix buffer size
 calculation
Message-ID: <YrskKxCDwSulaGJ5@eze-laptop>
References: <20220616202513.351039-1-jernej.skrabec@gmail.com>
 <20220616202513.351039-4-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616202513.351039-4-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On Thu, Jun 16, 2022 at 10:25:09PM +0200, Jernej Skrabec wrote:
> When allocating aux buffers for postprocessing, it's assumed that base
> buffer size is the same as that of output. Coincidentally, that's true
> most of the time, but not always. 10-bit source also needs aux buffer
> size which is appropriate for 10-bit native format, even if the output
> format is 8-bit. Similarly, mv sizes and other extra buffer size also
> depends on source width/height, not destination.
> 
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

I took a new look at this patch.

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  .../staging/media/hantro/hantro_postproc.c    | 24 +++++++++++++------
>  drivers/staging/media/hantro/hantro_v4l2.c    |  2 +-
>  drivers/staging/media/hantro/hantro_v4l2.h    |  2 ++
>  3 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_postproc.c b/drivers/staging/media/hantro/hantro_postproc.c
> index ab168c1c0d28..b77cc55e43ea 100644
> --- a/drivers/staging/media/hantro/hantro_postproc.c
> +++ b/drivers/staging/media/hantro/hantro_postproc.c
> @@ -12,6 +12,7 @@
>  #include "hantro_hw.h"
>  #include "hantro_g1_regs.h"
>  #include "hantro_g2_regs.h"
> +#include "hantro_v4l2.h"
>  
>  #define HANTRO_PP_REG_WRITE(vpu, reg_name, val) \
>  { \
> @@ -174,18 +175,27 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
>  	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
>  	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
>  	unsigned int num_buffers = cap_queue->num_buffers;
> +	struct v4l2_pix_format_mplane pix_mp;
> +	const struct hantro_fmt *fmt;
>  	unsigned int i, buf_size;
>  
> -	buf_size = ctx->dst_fmt.plane_fmt[0].sizeimage;
> +	/* this should always pick native format */
> +	fmt = hantro_get_default_fmt(ctx, false);

Clearly this is correct.

When the driver enables the post-processor it decodes a coded format (H264, etc.)
to a native format (NV12_4L4 or P010_4L4) and feeds this into the postprocessor
engine to produce some other format (YUYV, NV12, etc.).

The buffers allocated here should be taken from the native format,
so it's correct to use hantro_get_default_fmt().

> +	if (!fmt)
> +		return -EINVAL;
> +	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
> +			    ctx->src_fmt.height);

The issue comes at this point, where we negotiate the buffer size based on the
source size (OUTPUT queue size), instead of negotiating based
on the Native size.

  Coded -> [ Decoder ] -> Native -> [ Post-processor ] -> Decoded

So, while the patch is surely improving things, I wonder if it won't
cause other issues.

This reminds me we are still lacking a more complete test-suite for this
driver, so that we can validate changes and ensure there are no
regressions.

Perhaps we could hack Fluster to not only test the conformance,
but also test the post-processor?

Thanks,
Ezequiel


> +
> +	buf_size = pix_mp.plane_fmt[0].sizeimage;
>  	if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_H264_SLICE)
> -		buf_size += hantro_h264_mv_size(ctx->dst_fmt.width,
> -						ctx->dst_fmt.height);
> +		buf_size += hantro_h264_mv_size(pix_mp.width,
> +						pix_mp.height);
>  	else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_VP9_FRAME)
> -		buf_size += hantro_vp9_mv_size(ctx->dst_fmt.width,
> -					       ctx->dst_fmt.height);
> +		buf_size += hantro_vp9_mv_size(pix_mp.width,
> +					       pix_mp.height);
>  	else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_HEVC_SLICE)
> -		buf_size += hantro_hevc_mv_size(ctx->dst_fmt.width,
> -						ctx->dst_fmt.height);
> +		buf_size += hantro_hevc_mv_size(pix_mp.width,
> +						pix_mp.height);
>  
>  	for (i = 0; i < num_buffers; ++i) {
>  		struct hantro_aux_buf *priv = &ctx->postproc.dec_q[i];
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
> index 334f18a4120d..2c7a805289e7 100644
> --- a/drivers/staging/media/hantro/hantro_v4l2.c
> +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> @@ -118,7 +118,7 @@ hantro_find_format(const struct hantro_ctx *ctx, u32 fourcc)
>  	return NULL;
>  }
>  
> -static const struct hantro_fmt *
> +const struct hantro_fmt *
>  hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
>  {
>  	const struct hantro_fmt *formats;
> diff --git a/drivers/staging/media/hantro/hantro_v4l2.h b/drivers/staging/media/hantro/hantro_v4l2.h
> index b17e84c82582..64f6f57e9d7a 100644
> --- a/drivers/staging/media/hantro/hantro_v4l2.h
> +++ b/drivers/staging/media/hantro/hantro_v4l2.h
> @@ -23,5 +23,7 @@ extern const struct vb2_ops hantro_queue_ops;
>  
>  void hantro_reset_fmts(struct hantro_ctx *ctx);
>  int hantro_get_format_depth(u32 fourcc);
> +const struct hantro_fmt *
> +hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream);
>  
>  #endif /* HANTRO_V4L2_H_ */
> -- 
> 2.36.1
> 
