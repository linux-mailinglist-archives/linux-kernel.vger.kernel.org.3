Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC905606D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiF2RB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiF2RBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:01:24 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7095038D8E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:01:23 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-fe023ab520so22221073fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ef+4apwtIbdICqme2rXmW1mvBhsERAVWQJprylUXtXY=;
        b=G42CbUs4Vmmb5Q0Gf4h3i/fhOzvaIMiB+WCejp/2bnJofeKf1EfIqxUApo/q2dgKeR
         FMZj76Va5WB5JQFQ46dBJAytWdFbzf3cKrStbdLyi6oOCeLD8LWmvST9yfxYJvoYy4u4
         SJNqKHr680iZHcDDoDpmsMUrT4HIuDGigN6phqAcN69BYWAE7WCIvQ6E3qRyYGolHNDI
         p1v/MtUSyGwHMonO4Bly0xu7aeI8ZQTrm7a6UW9dtUSIK0QMbncHNx9iHXQMqtVvbKg4
         3kK1Ze4ArGkUJ75NIufIag4ruRCAKvgP0g+i4VBgPRIzNP0jDjtW0zJqr6XSyDVdqA/L
         ZBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ef+4apwtIbdICqme2rXmW1mvBhsERAVWQJprylUXtXY=;
        b=u2c/+ETgWj2jFrEm+vWXCG4VClROvqj2Vtuo58g5Tcrz1PSfR8xPqjLIBmRxBN/Ncg
         gWQrSvNn/g9/mIiAstgvmLZOQG0qhQ3kCcMmz7eKfYei77AM0gvH2yALxbQhel2LjPdb
         2U8VN0SiZotNuRfcvFvsHA9vel+25O5+qxxG7he4v7E6BMm+JXwGNiEvqfwZvnXcKHtP
         NbS5bIn3+7n3LOi0+LM7HWjxD1NTIu/G5/0Btw8CgvVEA3YaBqusXaFuzecZuXhQBJpt
         dq48rpj1ysSxpEkYg0wxp2uLQaei0KDIAAAq11OHmC+GCjdBTLsRqr320u+FgjzRbcGn
         fgdw==
X-Gm-Message-State: AJIora/GUWtkvOa2hgr1jSYpCs4fK3VTLwksiYcTunjPx7QXIP4Ew7iR
        FX39+jhPrxH0mQBizf8C9pcQpw==
X-Google-Smtp-Source: AGRyM1uBXuRoIHaCMNvjM0X3TXsEmHfLKz9mV46S0kVY8b8/1/jTKZ6c1VetCC5svwotT9hmzFHoKA==
X-Received: by 2002:a05:6870:45a1:b0:10b:8ee3:b3bd with SMTP id y33-20020a05687045a100b0010b8ee3b3bdmr1351076oao.9.1656522082649;
        Wed, 29 Jun 2022 10:01:22 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id go13-20020a056870da0d00b00101f143d537sm11419179oab.26.2022.06.29.10.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 10:01:21 -0700 (PDT)
Date:   Wed, 29 Jun 2022 14:01:16 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, benjamin.gaignard@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/7] media: hantro: postproc: Fix buffer size
 calculation
Message-ID: <YryFXLQvxEizaVah@eze-laptop>
References: <20220616202513.351039-1-jernej.skrabec@gmail.com>
 <20220616202513.351039-4-jernej.skrabec@gmail.com>
 <YrskKxCDwSulaGJ5@eze-laptop>
 <3180111.44csPzL39Z@jernej-laptop>
 <5af02115c95f96116b161464d3be8a210dad9d97.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5af02115c95f96116b161464d3be8a210dad9d97.camel@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas, Jernej,

On Tue, Jun 28, 2022 at 04:06:13PM -0400, Nicolas Dufresne wrote:
> Le mardi 28 juin 2022 à 18:13 +0200, Jernej Škrabec a écrit :
> > Dne torek, 28. junij 2022 ob 17:54:19 CEST je Ezequiel Garcia napisal(a):
> > > Hi Jernej,
> > > 
> > > On Thu, Jun 16, 2022 at 10:25:09PM +0200, Jernej Skrabec wrote:
> > > > When allocating aux buffers for postprocessing, it's assumed that base
> > > > buffer size is the same as that of output. Coincidentally, that's true
> > > > most of the time, but not always. 10-bit source also needs aux buffer
> > > > size which is appropriate for 10-bit native format, even if the output
> > > > format is 8-bit. Similarly, mv sizes and other extra buffer size also
> > > > depends on source width/height, not destination.
> > > > 
> > > > Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > > 
> > > I took a new look at this patch.
> > > 
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > > ---
> > > > 
> > > >  .../staging/media/hantro/hantro_postproc.c    | 24 +++++++++++++------
> > > >  drivers/staging/media/hantro/hantro_v4l2.c    |  2 +-
> > > >  drivers/staging/media/hantro/hantro_v4l2.h    |  2 ++
> > > >  3 files changed, 20 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/media/hantro/hantro_postproc.c
> > > > b/drivers/staging/media/hantro/hantro_postproc.c index
> > > > ab168c1c0d28..b77cc55e43ea 100644
> > > > --- a/drivers/staging/media/hantro/hantro_postproc.c
> > > > +++ b/drivers/staging/media/hantro/hantro_postproc.c
> > > > @@ -12,6 +12,7 @@
> > > > 
> > > >  #include "hantro_hw.h"
> > > >  #include "hantro_g1_regs.h"
> > > >  #include "hantro_g2_regs.h"
> > > > 
> > > > +#include "hantro_v4l2.h"
> > > > 
> > > >  #define HANTRO_PP_REG_WRITE(vpu, reg_name, val) \
> > > >  { \
> > > > 
> > > > @@ -174,18 +175,27 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
> > > > 
> > > >  	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
> > > >  	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
> > > >  	unsigned int num_buffers = cap_queue->num_buffers;
> > > > 
> > > > +	struct v4l2_pix_format_mplane pix_mp;
> > > > +	const struct hantro_fmt *fmt;
> > > > 
> > > >  	unsigned int i, buf_size;
> > > > 
> > > > -	buf_size = ctx->dst_fmt.plane_fmt[0].sizeimage;
> > > > +	/* this should always pick native format */
> > > > +	fmt = hantro_get_default_fmt(ctx, false);
> > > 
> > > Clearly this is correct.
> > > 
> > > When the driver enables the post-processor it decodes a coded format (H264,
> > > etc.) to a native format (NV12_4L4 or P010_4L4) and feeds this into the
> > > postprocessor engine to produce some other format (YUYV, NV12, etc.).
> > > 
> > > The buffers allocated here should be taken from the native format,
> > > so it's correct to use hantro_get_default_fmt().
> > > 
> > > > +	if (!fmt)
> > > > +		return -EINVAL;
> > > > +	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
> > > > +			    ctx->src_fmt.height);
> > > 
> > > The issue comes at this point, where we negotiate the buffer size based on
> > > the source size (OUTPUT queue size), instead of negotiating based
> > > on the Native size.
> > > 
> > >   Coded -> [ Decoder ] -> Native -> [ Post-processor ] -> Decoded
> > 
> > I'm not sure what is the difference between source and native size? You mean 
> > one coded in controls and one set via output format? IMO they should always be 
> > the same, otherwise it can be considered a bug in userspace application.
> 
> Indeed the src_fmt should use coded width/height (as per spec). The driver will
> then adapt to its own requirement resulting into the "native" width height being
> returned. Notice that s_ctrl() should fail in case of miss-match (this is CODEC
> specific), or streamon() should fail if the codec specific control have never
> been set (as we always initialise this, it will fail due to default being an
> invalid value anyway).
> 
> As a side effect, when userland read the default format (G_FMT(CAPTURE), the
> width/height should match the src_dst for this driver. This is the native size.
> The optional path that this driver enables is enumeration of CAPTURE format and
> frame sizes, combined with to select from these. The driver will create a
> secondary set of buffers in the case.
> 

OK, the patch looks good then.

Thanks,
Ezequiel

> Nicolas
> 
> > 
> > Best regards,
> > Jernej
> > 
> > > 
> > > So, while the patch is surely improving things, I wonder if it won't
> > > cause other issues.
> > > 
> > > This reminds me we are still lacking a more complete test-suite for this
> > > driver, so that we can validate changes and ensure there are no
> > > regressions.
> > > 
> > > Perhaps we could hack Fluster to not only test the conformance,
> > > but also test the post-processor?
> > > 
> > > Thanks,
> > > Ezequiel
> > > 
> > > > +
> > > > +	buf_size = pix_mp.plane_fmt[0].sizeimage;
> > > > 
> > > >  	if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_H264_SLICE)
> > > > 
> > > > -		buf_size += hantro_h264_mv_size(ctx->dst_fmt.width,
> > > > -						ctx-
> > > dst_fmt.height);
> > > > +		buf_size += hantro_h264_mv_size(pix_mp.width,
> > > > +						
> > pix_mp.height);
> > > > 
> > > >  	else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_VP9_FRAME)
> > > > 
> > > > -		buf_size += hantro_vp9_mv_size(ctx->dst_fmt.width,
> > > > -					       ctx-
> > > dst_fmt.height);
> > > > +		buf_size += hantro_vp9_mv_size(pix_mp.width,
> > > > +					       pix_mp.height);
> > > > 
> > > >  	else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_HEVC_SLICE)
> > > > 
> > > > -		buf_size += hantro_hevc_mv_size(ctx->dst_fmt.width,
> > > > -						ctx-
> > > dst_fmt.height);
> > > > +		buf_size += hantro_hevc_mv_size(pix_mp.width,
> > > > +						
> > pix_mp.height);
> > > > 
> > > >  	for (i = 0; i < num_buffers; ++i) {
> > > >  	
> > > >  		struct hantro_aux_buf *priv = &ctx->postproc.dec_q[i];
> > > > 
> > > > diff --git a/drivers/staging/media/hantro/hantro_v4l2.c
> > > > b/drivers/staging/media/hantro/hantro_v4l2.c index
> > > > 334f18a4120d..2c7a805289e7 100644
> > > > --- a/drivers/staging/media/hantro/hantro_v4l2.c
> > > > +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> > > > @@ -118,7 +118,7 @@ hantro_find_format(const struct hantro_ctx *ctx, u32
> > > > fourcc)> 
> > > >  	return NULL;
> > > >  
> > > >  }
> > > > 
> > > > -static const struct hantro_fmt *
> > > > +const struct hantro_fmt *
> > > > 
> > > >  hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
> > > >  {
> > > >  
> > > >  	const struct hantro_fmt *formats;
> > > > 
> > > > diff --git a/drivers/staging/media/hantro/hantro_v4l2.h
> > > > b/drivers/staging/media/hantro/hantro_v4l2.h index
> > > > b17e84c82582..64f6f57e9d7a 100644
> > > > --- a/drivers/staging/media/hantro/hantro_v4l2.h
> > > > +++ b/drivers/staging/media/hantro/hantro_v4l2.h
> > > > @@ -23,5 +23,7 @@ extern const struct vb2_ops hantro_queue_ops;
> > > > 
> > > >  void hantro_reset_fmts(struct hantro_ctx *ctx);
> > > >  int hantro_get_format_depth(u32 fourcc);
> > > > 
> > > > +const struct hantro_fmt *
> > > > +hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream);
> > > > 
> > > >  #endif /* HANTRO_V4L2_H_ */
> > 
> > 
> > 
> > 
> 
