Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6085055ED8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiF1TFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiF1TFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:05:09 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E093BCBC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:05:08 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id r82so9790393oig.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W1UIqFTlInNMiky+uI28fdGpzcjitquJfb20l0+LlU8=;
        b=NrQGrqnbwzbhIyRzdo4unz7FYRp2nskiLvSmmkb4yarwZzomgFLeSx5Ec5F4/DliEc
         y5TH8OcNawJ+0OQIkYevtpgfojNpE8WkrJgbv4Cr/eV/c6uTfuOZECHBu1+PfMWS1NSY
         WrQU6OYpcG95kbDLkTSEkIbfIz5Gp3vE5Kaqn4x7s9qi8GYr/jWFNQPRWK0B50pLQSwK
         SBvt1hV1JUHjL8Hpv6GgBes8iC+6jV3pH01FA8WGF4g+Ygr/Qb/bvIDdYWXmuFjxaxzH
         LzIKSkspipD8M5Nd1B8YYti3H2P/Tg/u+LkRy5dVoFuSCkpZ7iNnIHVIqQn3US16/JTW
         1o5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W1UIqFTlInNMiky+uI28fdGpzcjitquJfb20l0+LlU8=;
        b=Vxoar1wmYAQHgd/r4tCNkSoeQprEh9vJ+l4uM/DJZxtj1/vrMVAlULZM4+RpiPL4YR
         quKlAP0VMLtFyNJJfzjeH7th0baQwmPhBm++pi65ACvA/5J5E2Gpx8JiHZxRpU6LbSfk
         bQrlPaclJBMrxxWQ+epx2VCHzYnK/QuEIIfVQxPCZvrtGPrf343es/vf6jNckj8NyRCh
         UPrvouVONAhf7yrAM07O6bq7/lYbCbZyJhStW7hbuvnHNaFU0mgEGOCi5oOs+Fnrm1lA
         PlD8ZiRCNIDgaY3tsnJfxNc4Lfib0yXc5T4UL4E3x3XCENvYDmcmklWEeHFJrgpA3GXL
         R/fw==
X-Gm-Message-State: AJIora8VIqfwyUEzvF4KlIJfLBgXyVo/AOwJpvkW37auEAEPUDubWrZg
        QqUflOZC2fv5Mu8NQmFW3Aeozg==
X-Google-Smtp-Source: AGRyM1vBnvXXHKQfLBKNriRwVeDZ8JKqFoDXG2qXIcwdge1wnrXP13gptGoFgCR+8DCzLOn6SlPKjA==
X-Received: by 2002:a05:6808:1a13:b0:335:870b:324e with SMTP id bk19-20020a0568081a1300b00335870b324emr697774oib.297.1656443107736;
        Tue, 28 Jun 2022 12:05:07 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id n17-20020a9d7111000000b0060b069325f2sm480492otj.63.2022.06.28.12.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 12:05:06 -0700 (PDT)
Date:   Tue, 28 Jun 2022 16:05:01 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, benjamin.gaignard@collabora.com,
        nicolas.dufresne@collabora.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/7] media: Add P010 tiled format
Message-ID: <YrtQ3QPEGfbbllCG@eze-laptop>
References: <20220616202513.351039-1-jernej.skrabec@gmail.com>
 <20220616202513.351039-2-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616202513.351039-2-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

Thanks for the patch.

On Thu, Jun 16, 2022 at 10:25:07PM +0200, Jernej Skrabec wrote:
> From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> 
> Add P010 tiled format
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> [rebased and updated pixel format name]
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/media/v4l2-core/v4l2-common.c | 1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c  | 1 +
>  include/uapi/linux/videodev2.h        | 1 +

We also need to add the documentation in
Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst.

See Benjamin's patch for reference:

commit 5374d8fb75f313294c7d97e85c22bead34d63f2b
Author: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Date:   Thu May 19 08:11:46 2022 +0100

    media: Add P010 video format

    P010 is a YUV format with 10-bits per component with interleaved UV.

>  3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
> index 1e38ad8906a2..e0fbe6ba4b6c 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -278,6 +278,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
>  
>  		/* Tiled YUV formats */
>  		{ .format = V4L2_PIX_FMT_NV12_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
> +		{ .format = V4L2_PIX_FMT_P010_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
>  
>  		/* YUV planar formats, non contiguous variant */
>  		{ .format = V4L2_PIX_FMT_YUV420M, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 3, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 2 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index e2526701294e..e24d38c0a178 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1310,6 +1310,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 Linear)"; break;
> +	case V4L2_PIX_FMT_P010_4L4:	descr = "P010 tiled"; break;

I would make this "10-bit Y/CbCr 4:2:0 (4x4 Linear)".

Thanks,
Ezequiel
