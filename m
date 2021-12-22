Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C14F47CA97
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbhLVAy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhLVAy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:54:27 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1602AC061574;
        Tue, 21 Dec 2021 16:54:27 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id h5so870595qvh.8;
        Tue, 21 Dec 2021 16:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJjp5YMAMRD++/FKZ6hhLRZiHYEXKQMmjSr0lGSiXEY=;
        b=Pidswvaubov6mS0KQ4ft+ylEcNwiHnJIpkWOHL3DShMeWV3W+DWPcDPYaSTRxpACgX
         j5gQJz1favORDNFmJ0LrYV+0Q56hfKYhaayPfJQutC875/Kn5VCODSbKVt/s6JmDJv+C
         Z6mGYLKHhH7V5qon1UOPu6a1BEWPLp9Exmj2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJjp5YMAMRD++/FKZ6hhLRZiHYEXKQMmjSr0lGSiXEY=;
        b=qPDRx0Lg9Tlc7iER9IuCWriknJxZOYBthsprP3aL+lD4uYjZjq+gZzOFOurbDBXCDo
         fdIb90ZpwRKebzQpgoLfIN0BaTrjpHUul1ZciFZGBC4CwmGzOrqWO+sA4kbO0bxFD0If
         jDWqEuXRv432bwHEKrFMEZJgIW7DWO9oBScCptT6wQuz0OtIGsAUF3WNERjB6Y+IB2yF
         RCmVsrp3gY7eCfnPIujnQlRNOjMWKu/gbj9bwJszzEQe1V8tR5u34e+TGlP9GIv4Qta8
         f7K7vzXm5f0WXdhKXiMqTig3CuKx8Br+D1NxTVfrepnKLA8RbtbTk5+Ls13YVs3sGLZu
         /yKQ==
X-Gm-Message-State: AOAM5324PmFvAEy/kHvc27/iJXZTMkcx03BT8fTizh54PexbQHetGMIv
        SmUPSpAuKIM5FusNXcVa6C+59ghxqHEnulxxp7fsJrEQPSA=
X-Google-Smtp-Source: ABdhPJxGYfoA9EpJMot757NvA6aGpaIieF4ECLe/jAqe+CU75Xnsm8uzivICqIa4KhBVKpQ91ERTBIBtdaAXGrJopuA=
X-Received: by 2002:a05:6214:e63:: with SMTP id jz3mr735408qvb.65.1640134465924;
 Tue, 21 Dec 2021 16:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20211217095403.2618-1-jammy_huang@aspeedtech.com> <20211217095403.2618-2-jammy_huang@aspeedtech.com>
In-Reply-To: <20211217095403.2618-2-jammy_huang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 22 Dec 2021 00:54:09 +0000
Message-ID: <CACPK8XfTme51V3uB=7T9=1pzQVZnamP+7nL9h1jOiqiD66=MNw@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: aspeed: Correct value for h-total-pixels
To:     Jammy Huang <jammy_huang@aspeedtech.com>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-media@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 at 09:54, Jammy Huang <jammy_huang@aspeedtech.com> wrote:
>
> Previous reg-field, 0x98[11:0], stands for the period of the detected
> hsync signal.
> Use the correct reg, 0xa0, to get h-total in pixels.
>
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/media/platform/aspeed-video.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index b388bc56ce81..d5f77b205175 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -166,7 +166,7 @@
>  #define  VE_SRC_TB_EDGE_DET_BOT                GENMASK(28, VE_SRC_TB_EDGE_DET_BOT_SHF)
>
>  #define VE_MODE_DETECT_STATUS          0x098
> -#define  VE_MODE_DETECT_H_PIXELS       GENMASK(11, 0)
> +#define  VE_MODE_DETECT_H_PERIOD       GENMASK(11, 0)
>  #define  VE_MODE_DETECT_V_LINES_SHF    16
>  #define  VE_MODE_DETECT_V_LINES                GENMASK(27, VE_MODE_DETECT_V_LINES_SHF)
>  #define  VE_MODE_DETECT_STATUS_VSYNC   BIT(28)
> @@ -177,6 +177,8 @@
>  #define  VE_SYNC_STATUS_VSYNC_SHF      16
>  #define  VE_SYNC_STATUS_VSYNC          GENMASK(27, VE_SYNC_STATUS_VSYNC_SHF)
>
> +#define VE_H_TOTAL_PIXELS              0x0A0
> +
>  #define VE_INTERRUPT_CTRL              0x304
>  #define VE_INTERRUPT_STATUS            0x308
>  #define  VE_INTERRUPT_MODE_DETECT_WD   BIT(0)
> @@ -938,6 +940,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>         u32 src_lr_edge;
>         u32 src_tb_edge;
>         u32 sync;
> +       u32 htotal;
>         struct v4l2_bt_timings *det = &video->detected_timings;
>
>         det->width = MIN_WIDTH;
> @@ -983,6 +986,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>                 src_tb_edge = aspeed_video_read(video, VE_SRC_TB_EDGE_DET);
>                 mds = aspeed_video_read(video, VE_MODE_DETECT_STATUS);
>                 sync = aspeed_video_read(video, VE_SYNC_STATUS);
> +               htotal = aspeed_video_read(video, VE_H_TOTAL_PIXELS);
>
>                 video->frame_bottom = (src_tb_edge & VE_SRC_TB_EDGE_DET_BOT) >>
>                         VE_SRC_TB_EDGE_DET_BOT_SHF;
> @@ -999,8 +1003,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>                         VE_SRC_LR_EDGE_DET_RT_SHF;
>                 video->frame_left = src_lr_edge & VE_SRC_LR_EDGE_DET_LEFT;
>                 det->hfrontporch = video->frame_left;
> -               det->hbackporch = (mds & VE_MODE_DETECT_H_PIXELS) -
> -                       video->frame_right;
> +               det->hbackporch = htotal - video->frame_right;
>                 det->hsync = sync & VE_SYNC_STATUS_HSYNC;
>                 if (video->frame_left > video->frame_right)
>                         continue;
> --
> 2.25.1
>
