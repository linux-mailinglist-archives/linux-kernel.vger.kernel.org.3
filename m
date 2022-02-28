Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA244C6D21
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiB1Mtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiB1Mtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:49:35 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4ED6354
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:48:55 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id fc19so12198122qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+8I/V7LMKeEgdjfech8pVN3rLVcrkyoXC3NkYpHqx50=;
        b=UzEaMg7JeXuUGaFUzjzNTjWqymgIKqaEVBGX/ytQjyMN6OC9OOJ0/nKWUdYq5uxvI3
         /dra9cjZKvXzgDUebBGOWC5W7Vex1+dDK2vfDgq6DQqBF0xV3OAaHLTrixCGbjpTrelZ
         oKZ4YLNuUVKHI8QeYETFk0iXjog6Qe7igxM3RkkXzBUgb0EBNE3mMMQlLlQIEemz/1up
         y2yUjx+uzFN2xwsKNATwGf4tXX+27dJGIKH1fBmD8Ml/FNURZakDjIMB+01PmrrJ9Nh8
         VkFceIVqIYMtP9KCjfKcXhhAJeXp9s+7UxbIONneuk+b62r95b0yzSskFZltmHazBbRR
         26aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+8I/V7LMKeEgdjfech8pVN3rLVcrkyoXC3NkYpHqx50=;
        b=6tSa66VSnL0Yg76Snxy9tde6+ott6b4uIeYdqn10F4XuvgJwZ+aAadeSvLfClEDPKS
         Xp5j63CcO0HrKuBfqXShp7+WnmSPthUswACfxp5RrOZPl855tigGIMd55dEYwEvuljNH
         5hdKk/GJRR7bNDf3InjEcFjXpVHIhHK0zv3rDR91ONbGk9wv6xt574fC00XebRDfuKeg
         o/jZ5aVXEsDuAYEQihchdcMGLB3E0nEzHu+0umgFKn9AZNCdE6zCCY0C4hZi9Mm1rNUR
         +XG3iyg2glC+jTwgQeHy9F5WdiIWR4+/qFpce9vivBKT4K9MlQ+9L/HPn1hihs+En3H8
         gQgw==
X-Gm-Message-State: AOAM531Y325c8o/ZybLNeSJR84uFNrH0cs2tQghg7IzmyWEa25h/xno9
        +XfounDuFUqV4Z4ZFEkyVx3x9g==
X-Google-Smtp-Source: ABdhPJx3Zx++4poidmZxiaKiNp7huRBp+c07iQ/2xxhDNM88zR5W38PXzrrhlyBTtk2qm0T1kR/z9Q==
X-Received: by 2002:ac8:59c8:0:b0:2de:5f4:7e84 with SMTP id f8-20020ac859c8000000b002de05f47e84mr16487539qtf.97.1646052535083;
        Mon, 28 Feb 2022 04:48:55 -0800 (PST)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id y24-20020a05620a09d800b00648c8ba03c1sm4906437qky.107.2022.02.28.04.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:48:54 -0800 (PST)
Message-ID: <1b2ce01fb04f29cca58d40bd81d9f4cc46dcebf8.camel@ndufresne.ca>
Subject: Re: [RFC PATCH 2/8] media: Add P010 format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Date:   Mon, 28 Feb 2022 07:48:53 -0500
In-Reply-To: <20220227144926.3006585-3-jernej.skrabec@gmail.com>
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
         <20220227144926.3006585-3-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 27 février 2022 à 15:49 +0100, Jernej Skrabec a écrit :
> Add P010 format, which is commonly used for 10-bit videos.

There is a much more complete patch that was sent previously (with documentation
and all):

https://patchwork.kernel.org/project/linux-rockchip/patch/20210618131526.566762-5-benjamin.gaignard@collabora.com/

regards,
Nicolas

> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/media/v4l2-core/v4l2-common.c | 2 ++
>  drivers/media/v4l2-core/v4l2-ioctl.c  | 1 +
>  include/uapi/linux/videodev2.h        | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
> index 1db0020e08c0..4ede36546e9c 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -275,6 +275,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
>  		{ .format = V4L2_PIX_FMT_YUV422P, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 1 },
>  		{ .format = V4L2_PIX_FMT_GREY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 1, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
>  
> +		{ .format = V4L2_PIX_FMT_P010,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
> +
>  		/* Tiled YUV formats */
>  		{ .format = V4L2_PIX_FMT_NV12_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
>  		{ .format = V4L2_PIX_FMT_P010_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 048f326c57b9..a8d999e23e5b 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1295,6 +1295,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
>  	case V4L2_PIX_FMT_NV12:		descr = "Y/CbCr 4:2:0"; break;
>  	case V4L2_PIX_FMT_NV21:		descr = "Y/CrCb 4:2:0"; break;
> +	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CbCr 4:2:0"; break;
>  	case V4L2_PIX_FMT_NV16:		descr = "Y/CbCr 4:2:2"; break;
>  	case V4L2_PIX_FMT_NV61:		descr = "Y/CrCb 4:2:2"; break;
>  	case V4L2_PIX_FMT_NV24:		descr = "Y/CbCr 4:4:4"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 772dbadd1a24..211bc11a48cb 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -597,6 +597,7 @@ struct v4l2_pix_format {
>  /* two planes -- one Y, one Cr + Cb interleaved  */
>  #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr 4:2:0  */
>  #define V4L2_PIX_FMT_NV21    v4l2_fourcc('N', 'V', '2', '1') /* 12  Y/CrCb 4:2:0  */
> +#define V4L2_PIX_FMT_P010    v4l2_fourcc('P', '0', '1', '0') /* 24  Y/CbCr 4:2:0 10-bit */
>  #define V4L2_PIX_FMT_NV16    v4l2_fourcc('N', 'V', '1', '6') /* 16  Y/CbCr 4:2:2  */
>  #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/CrCb 4:2:2  */
>  #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */

