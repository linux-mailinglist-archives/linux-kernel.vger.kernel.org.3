Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A31847CAC8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbhLVBbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhLVBbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:31:16 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA9C061574;
        Tue, 21 Dec 2021 17:31:15 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id e16so822473qkl.12;
        Tue, 21 Dec 2021 17:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BL4VTrxHuhNngkVjVPPyXcbNQ/vv2xvDhyVBuDNvoBE=;
        b=HGxs8jlV6uJBLy77VN0ld1Ch0KRpJ634KfWR9yIX8fJk3s2xAZEEuxCDpXgkg8n9Yo
         iOnOqRhsMKTh31pymyYvwtnt3keVbkK4uIiH7PR9wCr9iPjXQXz3CRRpxDAC+et0arj7
         SAtH7PDcshRL8CTuOEcpixfhsxwtrIIL5YMCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BL4VTrxHuhNngkVjVPPyXcbNQ/vv2xvDhyVBuDNvoBE=;
        b=rQUe6u+Rqt3tzhz9998b3klATZ3HB9NHVyvk196rMgLqCJc8bHRpqjP2NOib1esHzN
         F0i5jjjvUuyrofJXmX4KyCKODqMMvFR1S0Q/qgrVhABMaEpR+ndSnlJfw1FISgypp5ia
         ZFDXEPmY2xUiM/vmTAVLzB0Jd9eUcCX7gmdIBIo2xa4aeJfLRp9+tmPUrH1t/1+kPU2Q
         8kMluPWhSrW71BG8wasElMRmjdS32d2+W+N6Hd4TKJROi2BV/OFfeW957vV13XWFfUss
         4mlg+3qf2lDQlV9Etkq9J+cG+LFY8oWQVVB/mYE0hAwvzLhKA7arjDRpR5VBkwU8oCJe
         Sakg==
X-Gm-Message-State: AOAM532jpCuyhXwX3l4Z4D0it2Qj0Lni7L2WWGIAZWBzxr/GX2FDE2XW
        vICTOAPyEuVeFls3XiSECOdKBx08x9IvBpgoOcO8UWn0
X-Google-Smtp-Source: ABdhPJwYB/w9mWQ/fJ18cguaiEKzZSEf2jcz9l7mfEhP1ihTCU6+UEnF0DuWo1HpbZ9y0+2JAC3df9FcIneYpMNTd+k=
X-Received: by 2002:a37:4047:: with SMTP id n68mr734946qka.346.1640136674770;
 Tue, 21 Dec 2021 17:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20211217095403.2618-1-jammy_huang@aspeedtech.com> <20211217095403.2618-4-jammy_huang@aspeedtech.com>
In-Reply-To: <20211217095403.2618-4-jammy_huang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 22 Dec 2021 01:31:02 +0000
Message-ID: <CACPK8Xf_5wZXzfDSrdLLxs_B_jX7BVHc5o2Thw1DJvYix1AA8Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] media: aspeed: Correct values for detected timing
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
> Correct timing's fp/sync/bp value based on the information below.
> It should be noticed that the calculation formula should be changed
> per sync polarity.
>
> The sequence of signal: sync - backporch - video data - frontporch
>
> The following registers start counting from sync's rising edge:
> 1. VR090: frame edge's left and right
> 2. VR094: frame edge's top and bottom
> 3. VR09C: counting from sync's rising edge to falling edge
>
>             +--+     +-------------------+     +--+
>             |  |     |    v i d e o      |     |  |
>          +--+  +-----+                   +-----+  +---+
>
>         sync+--+
>     left/top+--------+
> right/bottom+----------------------------+
>
>                   +-------------------+
>                   |    v i d e o      |
>       +--+  +-----+                   +-----+  +---+
>          |  |                               |  |
>          +--+                               +--+
>         sync+-------------------------------+
>     left/top+-----+
> right/bottom+-------------------------+

This is a good explanation. Can you add detail that relates the names
you use here to to the variable names in your patch (or change them to
match)?

>
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  drivers/media/platform/aspeed-video.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 581a4261f9b7..5ad3a20c5bac 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -988,10 +988,20 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>                                                 src_tb_edge);
>                 video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP,
>                                              src_tb_edge);
> -               det->vfrontporch = video->frame_top;
> -               det->vbackporch = FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
> -                       video->frame_bottom;
>                 det->vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);


Would it be clearer if you structured the code like this?

 vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
 vlines = FIELD_GET(VE_MODE_DETECT_V_LINES, mds);

 if (det->polarities & V4L2_DV_VSYNC_POS_POL)) {
    det->vbackporch = video->frame_top - vsync;
    det->vfrontporch = vlines - video->frame_bottom;
    det->vsync = vsync;
 } else {
    det->vbackporch = video->frame_top;
    det->vfrontporch = vlines - video->frame_bottom - vsync;
    det->vsync = vlines - vsync;

}


> +               if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
> +                       det->vbackporch = video->frame_top - det->vsync;
> +                       det->vfrontporch =
> +                               FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
> +                               video->frame_bottom;
> +               } else {
> +                       det->vsync = FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
> +                                              det->vsync;
> +                       det->vbackporch = video->frame_top;
> +                       det->vfrontporch =
> +                               FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
> +                               video->frame_bottom - det->vsync;
> +               }
>                 if (video->frame_top > video->frame_bottom)
>                         continue;
>
> @@ -999,9 +1009,16 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>                                                src_lr_edge);
>                 video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT,
>                                               src_lr_edge);
> -               det->hfrontporch = video->frame_left;
> -               det->hbackporch = htotal - video->frame_right;
>                 det->hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
> +               if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
> +                       det->hbackporch = video->frame_left - det->hsync;
> +                       det->hfrontporch = htotal - video->frame_right;
> +               } else {
> +                       det->hsync = htotal - det->hsync;
> +                       det->hbackporch = video->frame_left;
> +                       det->hfrontporch = htotal - video->frame_right -
> +                                          det->hsync;
> +               }
>                 if (video->frame_left > video->frame_right)
>                         continue;
>
> --
> 2.25.1
>
