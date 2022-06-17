Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5E554F131
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 08:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380311AbiFQGqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 02:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380312AbiFQGq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 02:46:27 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D305055377
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 23:46:24 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g186so3309096pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 23:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fQNGQ/zJse2gbHWfa6pF660SRacSRW0Fy9uu/huJD4Y=;
        b=JPLW1+w8/z8WGKViSxKlFYB1DJFO5f4d4rwynmLj7wx/0qK2bG0tNVGdJOrTjCJVPW
         d0ZiMJQDidl1w4ljJIZMpCkOlhOZkW6+5BzSe4i3dZhcyh+oDngZ/gJaVlL8+QGNmUTL
         nqKpdtg55DdMsoRsLoHIj2LgXDVZ6dwdIBG8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fQNGQ/zJse2gbHWfa6pF660SRacSRW0Fy9uu/huJD4Y=;
        b=ToITpjdybdEa2Oi364/QrvbFt0gXUfZ4RZRVjiizV/2+ydESegS16MZarCzzJ4mlTN
         7z4w73WTbN0sQVi1+A7M6MbviMZpVjRh8XQamOWY6oYhRoMfphL3HAmbUQIRUCxEUlyV
         uDnCitPff/YkFDqSSEpy/LCte8RxEpVSUFl7oqXuH/KdMwUhQaZsXLHShJKljNXsa4Wr
         XYuBYOWoxgA1ANLLian3oajPkHmrU3Dvf+ZTQLpz3NeqV7xEKXpZjc92FoAhZvvsfohd
         nN035wpBErJvJ2FRCWHPWp/UYzy/bb3jG/L92DuqckFmX/z/RORYJaN9VqcvEj/5+F+N
         wXnA==
X-Gm-Message-State: AJIora/KUgRhKlqc6gB1vm8qHkQiCkZVHWc+1oSp48ivhsLt+xi5SrJf
        jv25XP5eFk8e6Bw/3RR346SrnQ==
X-Google-Smtp-Source: AGRyM1uENT2OwXii6KksNBQ4MXQhZdrl+ulN/85OXID2dCsUxVB+lOZD0za0PfnLmxj1+jHPwjAROA==
X-Received: by 2002:a63:80c8:0:b0:405:186f:fa39 with SMTP id j191-20020a6380c8000000b00405186ffa39mr7960592pgd.84.1655448384322;
        Thu, 16 Jun 2022 23:46:24 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:e12:c024:d152:7ca])
        by smtp.gmail.com with ESMTPSA id fs20-20020a17090af29400b001ea75a02805sm4833237pjb.52.2022.06.16.23.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 23:46:23 -0700 (PDT)
Date:   Fri, 17 Jun 2022 14:46:18 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v7, 04/15] media: mtk-vcodec: Read max resolution from
 dec_capability
Message-ID: <YqwjOurt2DCV6snP@google.com>
References: <20220223034008.15781-1-yunfei.dong@mediatek.com>
 <20220223034008.15781-5-yunfei.dong@mediatek.com>
 <cb7cf296bc7df7334f55cc51ef11b671572559ac.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb7cf296bc7df7334f55cc51ef11b671572559ac.camel@ndufresne.ca>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 28, 2022 at 04:29:15PM -0500, Nicolas Dufresne wrote:
> Hi Yunfei,
> 
> this patch does not work unless userland calls enum_framesizes, which is
> completely optional. See comment and suggestion below.
> 
> Le mercredi 23 février 2022 à 11:39 +0800, Yunfei Dong a écrit :
> > Supported max resolution for different platforms are not the same: 2K
> > or 4K, getting it according to dec_capability.
> > 
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > Reviewed-by: Tzung-Bi Shih<tzungbi@google.com>
> > ---
> >  .../platform/mtk-vcodec/mtk_vcodec_dec.c      | 29 +++++++++++--------
> >  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  4 +++
> >  2 files changed, 21 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> > index 130ecef2e766..304f5afbd419 100644
> > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> > @@ -445,7 +447,7 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
> >  		return -EINVAL;
> >  
> >  	q_data->fmt = fmt;
> > -	vidioc_try_fmt(f, q_data->fmt);
> > +	vidioc_try_fmt(ctx, f, q_data->fmt);
> >  	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> >  		q_data->sizeimage[0] = pix_mp->plane_fmt[0].sizeimage;
> >  		q_data->coded_width = pix_mp->width;
> > @@ -545,6 +547,9 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
> >  				fsize->stepwise.min_height,
> >  				fsize->stepwise.max_height,
> >  				fsize->stepwise.step_height);
> > +
> > +		ctx->max_width = fsize->stepwise.max_width;
> > +		ctx->max_height = fsize->stepwise.max_height;
> 
> The spec does not require calling enum_fmt, so changing the maximum here is
> incorrect (and fail with GStreamer). If userland never enum the framesizes, the
> resolution get limited to 1080p.
> 
> As this only depends and the OUTPUT format and the device being open()
> (condition being dev_capability being set and OUTPUT format being known / not
> VP8), you could initialize the cxt max inside s_fmt(OUTPUT) instead, which is a
> mandatory call. I have tested this change to verify this:
> 
> 
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> index 044e3dfbdd8c..3e7c571526a4 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> @@ -484,6 +484,14 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
>  	if (fmt == NULL)
>  		return -EINVAL;
>  
> +	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE &&
> +	    !(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED) &&
> +	    fmt->fourcc != V4L2_PIX_FMT_VP8_FRAME) {
> +		mtk_v4l2_debug(3, "4K is enabled");
> +		ctx->max_width = VCODEC_DEC_4K_CODED_WIDTH;
> +		ctx->max_height = VCODEC_DEC_4K_CODED_HEIGHT;
> +	}
> +
>  	q_data->fmt = fmt;
>  	vidioc_try_fmt(ctx, f, q_data->fmt);
>  	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> @@ -574,15 +582,9 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
>  
>  		fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
>  		fsize->stepwise = dec_pdata->vdec_framesizes[i].stepwise;
> -		if (!(ctx->dev->dec_capability &
> -				VCODEC_CAPABILITY_4K_DISABLED) &&
> -				fsize->pixel_format != V4L2_PIX_FMT_VP8_FRAME) {
> -			mtk_v4l2_debug(3, "4K is enabled");
> -			fsize->stepwise.max_width =
> -					VCODEC_DEC_4K_CODED_WIDTH;
> -			fsize->stepwise.max_height =
> -					VCODEC_DEC_4K_CODED_HEIGHT;
> -		}
> +		fsize->stepwise.max_width = ctx->max_width;
> +		fsize->stepwise.max_height = ctx->max_height;
> +

Recent testing on ChromeOS suggests this doesn't work. The spec implies
that querying capabilities could happen before the output format is set.
And also, supported frame sizes are detected for each given format,
which may not be the one current set.

So the if block above has to be reintroduced in some form. I'll take a
look at this.


Regards
ChenYu

>  		mtk_v4l2_debug(1, "%x, %d %d %d %d %d %d",
>  				ctx->dev->dec_capability,
>  				fsize->stepwise.min_width,
> @@ -592,8 +594,6 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
>  				fsize->stepwise.max_height,
>  				fsize->stepwise.step_height);
>  
> -		ctx->max_width = fsize->stepwise.max_width;
> -		ctx->max_height = fsize->stepwise.max_height;
>  		return 0;
>  	}
>  
> 
> 
> >  		return 0;
> >  	}
> >  

[...]

