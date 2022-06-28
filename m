Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136AE55E703
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiF1QWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiF1QWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:22:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6629E37AB6;
        Tue, 28 Jun 2022 09:13:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fi2so26768216ejb.9;
        Tue, 28 Jun 2022 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Lx7tM7FvIRfnZKu78o7ZdG3s890VbwgJIMpBDQ1SB8=;
        b=VWAFcug2fFdI2e8F8vBX6YDg0MzYOgFQTojwHJWJ8Jr/LwsxBu2ry4BIYLQNn/DbRD
         IawwZNF/NMwS25ujAFZZbbdtB5MRhCmyJRnrrY7ONIAe9dtloYM4ctvGRv4L80xrj/P9
         JjvO5VGg8TfMfjl0u69r2fWoT25FadBtqQtwMNZJZmanyDjNQDgZLPoFKFM5nGkeiw4W
         s/1g+gD7LXQ/5Ut1e0a7dyvUXvz2VbmUXsvSng1J708ae0OEbXLAADwnUCFTUpMHxEZq
         GYbhu8rC+xSYmRInlEKW7eTekO2xkOHI08O6aO0nPLse2EnNqESI2Buip6b0qEWCsdpK
         JaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Lx7tM7FvIRfnZKu78o7ZdG3s890VbwgJIMpBDQ1SB8=;
        b=Ei6zdNh4ZAa0aehEELQLV1UZ1Zy+EBEtLOjPTD9V4R/3ji1eAwkWjS7k+LV8QWAksP
         NP2fpz0VYBbEgUjqTTrXx/pHtGNKIToScZd7MS/CrWyW19qzyNBS/1Cbl+0KQOhUZSEP
         3XvGtd6jIx2K9MmHTk1Nf7N14cvuWu9FUAeSFfiqpWg5fpHtCcdArAoSYN6IgSpAuZA2
         dn10WLoG0ovuYAnemwhi54jrricUMMv5IOHqE/91FET3nupx+MVO7RNWkm/g4L+B8KQV
         UqrjogVzXnYEPIyAGcyUi5Rs9kD9dwO+i1ZEjYKqeWQXHL1U9I/LDkoYuwTxuW7GUMO8
         DsHQ==
X-Gm-Message-State: AJIora/1kmkgpI8UoqceJpfPYt5nZJDdT1JDBohYPGx/spHRWgmhvRiG
        9rHLrIedPdVXFGVam+kMiNs=
X-Google-Smtp-Source: AGRyM1txh7PKe9jl713q+VzwJ2SumfGwKEpOgKcIAHEzirk7F73v58L8m9Qb7NNtanEUImj71zQq3A==
X-Received: by 2002:a17:907:7285:b0:722:e371:72d5 with SMTP id dt5-20020a170907728500b00722e37172d5mr18921148ejc.731.1656432818741;
        Tue, 28 Jun 2022 09:13:38 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id ci3-20020a170906c34300b00722ea7a7aeesm6593654ejb.51.2022.06.28.09.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:13:37 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, benjamin.gaignard@collabora.com,
        nicolas.dufresne@collabora.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/7] media: hantro: postproc: Fix buffer size calculation
Date:   Tue, 28 Jun 2022 18:13:35 +0200
Message-ID: <3180111.44csPzL39Z@jernej-laptop>
In-Reply-To: <YrskKxCDwSulaGJ5@eze-laptop>
References: <20220616202513.351039-1-jernej.skrabec@gmail.com> <20220616202513.351039-4-jernej.skrabec@gmail.com> <YrskKxCDwSulaGJ5@eze-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 28. junij 2022 ob 17:54:19 CEST je Ezequiel Garcia napisal(a):
> Hi Jernej,
> 
> On Thu, Jun 16, 2022 at 10:25:09PM +0200, Jernej Skrabec wrote:
> > When allocating aux buffers for postprocessing, it's assumed that base
> > buffer size is the same as that of output. Coincidentally, that's true
> > most of the time, but not always. 10-bit source also needs aux buffer
> > size which is appropriate for 10-bit native format, even if the output
> > format is 8-bit. Similarly, mv sizes and other extra buffer size also
> > depends on source width/height, not destination.
> > 
> > Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> 
> I took a new look at this patch.
> 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> > 
> >  .../staging/media/hantro/hantro_postproc.c    | 24 +++++++++++++------
> >  drivers/staging/media/hantro/hantro_v4l2.c    |  2 +-
> >  drivers/staging/media/hantro/hantro_v4l2.h    |  2 ++
> >  3 files changed, 20 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/staging/media/hantro/hantro_postproc.c
> > b/drivers/staging/media/hantro/hantro_postproc.c index
> > ab168c1c0d28..b77cc55e43ea 100644
> > --- a/drivers/staging/media/hantro/hantro_postproc.c
> > +++ b/drivers/staging/media/hantro/hantro_postproc.c
> > @@ -12,6 +12,7 @@
> > 
> >  #include "hantro_hw.h"
> >  #include "hantro_g1_regs.h"
> >  #include "hantro_g2_regs.h"
> > 
> > +#include "hantro_v4l2.h"
> > 
> >  #define HANTRO_PP_REG_WRITE(vpu, reg_name, val) \
> >  { \
> > 
> > @@ -174,18 +175,27 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
> > 
> >  	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
> >  	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
> >  	unsigned int num_buffers = cap_queue->num_buffers;
> > 
> > +	struct v4l2_pix_format_mplane pix_mp;
> > +	const struct hantro_fmt *fmt;
> > 
> >  	unsigned int i, buf_size;
> > 
> > -	buf_size = ctx->dst_fmt.plane_fmt[0].sizeimage;
> > +	/* this should always pick native format */
> > +	fmt = hantro_get_default_fmt(ctx, false);
> 
> Clearly this is correct.
> 
> When the driver enables the post-processor it decodes a coded format (H264,
> etc.) to a native format (NV12_4L4 or P010_4L4) and feeds this into the
> postprocessor engine to produce some other format (YUYV, NV12, etc.).
> 
> The buffers allocated here should be taken from the native format,
> so it's correct to use hantro_get_default_fmt().
> 
> > +	if (!fmt)
> > +		return -EINVAL;
> > +	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
> > +			    ctx->src_fmt.height);
> 
> The issue comes at this point, where we negotiate the buffer size based on
> the source size (OUTPUT queue size), instead of negotiating based
> on the Native size.
> 
>   Coded -> [ Decoder ] -> Native -> [ Post-processor ] -> Decoded

I'm not sure what is the difference between source and native size? You mean 
one coded in controls and one set via output format? IMO they should always be 
the same, otherwise it can be considered a bug in userspace application.

Best regards,
Jernej

> 
> So, while the patch is surely improving things, I wonder if it won't
> cause other issues.
> 
> This reminds me we are still lacking a more complete test-suite for this
> driver, so that we can validate changes and ensure there are no
> regressions.
> 
> Perhaps we could hack Fluster to not only test the conformance,
> but also test the post-processor?
> 
> Thanks,
> Ezequiel
> 
> > +
> > +	buf_size = pix_mp.plane_fmt[0].sizeimage;
> > 
> >  	if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_H264_SLICE)
> > 
> > -		buf_size += hantro_h264_mv_size(ctx->dst_fmt.width,
> > -						ctx-
>dst_fmt.height);
> > +		buf_size += hantro_h264_mv_size(pix_mp.width,
> > +						
pix_mp.height);
> > 
> >  	else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_VP9_FRAME)
> > 
> > -		buf_size += hantro_vp9_mv_size(ctx->dst_fmt.width,
> > -					       ctx-
>dst_fmt.height);
> > +		buf_size += hantro_vp9_mv_size(pix_mp.width,
> > +					       pix_mp.height);
> > 
> >  	else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_HEVC_SLICE)
> > 
> > -		buf_size += hantro_hevc_mv_size(ctx->dst_fmt.width,
> > -						ctx-
>dst_fmt.height);
> > +		buf_size += hantro_hevc_mv_size(pix_mp.width,
> > +						
pix_mp.height);
> > 
> >  	for (i = 0; i < num_buffers; ++i) {
> >  	
> >  		struct hantro_aux_buf *priv = &ctx->postproc.dec_q[i];
> > 
> > diff --git a/drivers/staging/media/hantro/hantro_v4l2.c
> > b/drivers/staging/media/hantro/hantro_v4l2.c index
> > 334f18a4120d..2c7a805289e7 100644
> > --- a/drivers/staging/media/hantro/hantro_v4l2.c
> > +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> > @@ -118,7 +118,7 @@ hantro_find_format(const struct hantro_ctx *ctx, u32
> > fourcc)> 
> >  	return NULL;
> >  
> >  }
> > 
> > -static const struct hantro_fmt *
> > +const struct hantro_fmt *
> > 
> >  hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
> >  {
> >  
> >  	const struct hantro_fmt *formats;
> > 
> > diff --git a/drivers/staging/media/hantro/hantro_v4l2.h
> > b/drivers/staging/media/hantro/hantro_v4l2.h index
> > b17e84c82582..64f6f57e9d7a 100644
> > --- a/drivers/staging/media/hantro/hantro_v4l2.h
> > +++ b/drivers/staging/media/hantro/hantro_v4l2.h
> > @@ -23,5 +23,7 @@ extern const struct vb2_ops hantro_queue_ops;
> > 
> >  void hantro_reset_fmts(struct hantro_ctx *ctx);
> >  int hantro_get_format_depth(u32 fourcc);
> > 
> > +const struct hantro_fmt *
> > +hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream);
> > 
> >  #endif /* HANTRO_V4L2_H_ */




