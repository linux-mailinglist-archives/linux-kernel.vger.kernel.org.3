Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87EB47CA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbhLVBAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhLVBAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:00:12 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F1DC061574;
        Tue, 21 Dec 2021 17:00:12 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id a9so857449qvd.12;
        Tue, 21 Dec 2021 17:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKvHA40MElrX93jDS+MnFfwzXO7n7dGjS2ojGYwXai4=;
        b=Gi3j/UTXIWZzylZ3QkdRnufKIADVVwnkFqbNZJCtFl0nhmYlkuLU4pi6BJ2cnHpTt/
         ziwIuSswzs0NDdxGbx54Hs2AbIWAjnPh/zSCzCjVqzy4OzLhGtOCVx7Exjnpde851WoF
         +L3VHPYHBPC+Mrc8aeqv0J7TwyFnKjlGWj/FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKvHA40MElrX93jDS+MnFfwzXO7n7dGjS2ojGYwXai4=;
        b=uS7n+5aHadMmgf7McfuMhTIVS5xNgY1eQGx4zdvkEbLDMuc08r+YH8FW51+67WA8tr
         /ge3LNz3FAHD7I80m/Sl6U+aCKcTOzz8JGzHa+4atE4FIXeesPJ5OHpUQBXPslr+Rs9u
         DouVrynxD6qH+tgGyLxnGX5B4FxUZplzjHPsE7HdYmVaGqrQcosyO8EdUZG+zmPzSeLT
         k/tjW2oF5UU/hbFBxiFMXvACekE7OfjdoHu2AkOTJcQlzlgTcrWyLwjLSKA61cA18BW8
         Lz2Q/iLAsYE4EzwAxEwOZezAdoTi2/G9fkR8MR0aVYtkwR8/t2KgP7VlZ5hLFuyJiEBb
         ICLQ==
X-Gm-Message-State: AOAM532/E55LK2K2RGPTLSRArPIS8k0eT1vVPj5sZaBdwdgO7wxjWfWO
        fqPcObTccH/nB6qqLuoo6ATVNZjZhZb2Yp09UUY=
X-Google-Smtp-Source: ABdhPJxJqlQU6wjR7AqfqAIfm+g5QOBnhT8O+VmMIGj5tnMG/mtLZmwwYNW1b8yLylfxlofFXh6AQpoiqUfz4Dvfc+Q=
X-Received: by 2002:a05:6214:e63:: with SMTP id jz3mr748923qvb.65.1640134811727;
 Tue, 21 Dec 2021 17:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20211217095403.2618-1-jammy_huang@aspeedtech.com> <20211217095403.2618-3-jammy_huang@aspeedtech.com>
In-Reply-To: <20211217095403.2618-3-jammy_huang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 22 Dec 2021 00:59:58 +0000
Message-ID: <CACPK8XcmcP=vu8pWVKdiQVokPyh39Tuy0mfmgPSzb0wb0tcJuA@mail.gmail.com>
Subject: Re: [PATCH 2/4] media: aspeed: Use FIELD_GET to improve readability
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

On Fri, 17 Dec 2021 at 09:53, Jammy Huang <jammy_huang@aspeedtech.com> wrote:
>
> Use the bitfield macro FIELD_GET, and GENMASK to do the shift and mask in
> one go for reg values.
>
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  drivers/media/platform/aspeed-video.c | 35 ++++++++++++---------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index d5f77b205175..581a4261f9b7 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -156,26 +156,22 @@
>  #define  VE_SRC_LR_EDGE_DET_NO_H       BIT(13)
>  #define  VE_SRC_LR_EDGE_DET_NO_DISP    BIT(14)
>  #define  VE_SRC_LR_EDGE_DET_NO_CLK     BIT(15)
> -#define  VE_SRC_LR_EDGE_DET_RT_SHF     16
> -#define  VE_SRC_LR_EDGE_DET_RT         GENMASK(27, VE_SRC_LR_EDGE_DET_RT_SHF)
> +#define  VE_SRC_LR_EDGE_DET_RT         GENMASK(27, 16)
>  #define  VE_SRC_LR_EDGE_DET_INTERLACE  BIT(31)
>
>  #define VE_SRC_TB_EDGE_DET             0x094
>  #define  VE_SRC_TB_EDGE_DET_TOP                GENMASK(12, 0)
> -#define  VE_SRC_TB_EDGE_DET_BOT_SHF    16
> -#define  VE_SRC_TB_EDGE_DET_BOT                GENMASK(28, VE_SRC_TB_EDGE_DET_BOT_SHF)
> +#define  VE_SRC_TB_EDGE_DET_BOT                GENMASK(28, 16)
>
>  #define VE_MODE_DETECT_STATUS          0x098
>  #define  VE_MODE_DETECT_H_PERIOD       GENMASK(11, 0)
> -#define  VE_MODE_DETECT_V_LINES_SHF    16
> -#define  VE_MODE_DETECT_V_LINES                GENMASK(27, VE_MODE_DETECT_V_LINES_SHF)
> +#define  VE_MODE_DETECT_V_LINES                GENMASK(27, 16)
>  #define  VE_MODE_DETECT_STATUS_VSYNC   BIT(28)
>  #define  VE_MODE_DETECT_STATUS_HSYNC   BIT(29)
>
>  #define VE_SYNC_STATUS                 0x09c
>  #define  VE_SYNC_STATUS_HSYNC          GENMASK(11, 0)
> -#define  VE_SYNC_STATUS_VSYNC_SHF      16
> -#define  VE_SYNC_STATUS_VSYNC          GENMASK(27, VE_SYNC_STATUS_VSYNC_SHF)
> +#define  VE_SYNC_STATUS_VSYNC          GENMASK(27, 16)
>
>  #define VE_H_TOTAL_PIXELS              0x0A0
>
> @@ -988,23 +984,24 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>                 sync = aspeed_video_read(video, VE_SYNC_STATUS);
>                 htotal = aspeed_video_read(video, VE_H_TOTAL_PIXELS);
>
> -               video->frame_bottom = (src_tb_edge & VE_SRC_TB_EDGE_DET_BOT) >>
> -                       VE_SRC_TB_EDGE_DET_BOT_SHF;
> -               video->frame_top = src_tb_edge & VE_SRC_TB_EDGE_DET_TOP;
> +               video->frame_bottom = FIELD_GET(VE_SRC_TB_EDGE_DET_BOT,
> +                                               src_tb_edge);
> +               video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP,
> +                                            src_tb_edge);
>                 det->vfrontporch = video->frame_top;
> -               det->vbackporch = ((mds & VE_MODE_DETECT_V_LINES) >>
> -                       VE_MODE_DETECT_V_LINES_SHF) - video->frame_bottom;
> -               det->vsync = (sync & VE_SYNC_STATUS_VSYNC) >>
> -                       VE_SYNC_STATUS_VSYNC_SHF;
> +               det->vbackporch = FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
> +                       video->frame_bottom;
> +               det->vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
>                 if (video->frame_top > video->frame_bottom)
>                         continue;
>
> -               video->frame_right = (src_lr_edge & VE_SRC_LR_EDGE_DET_RT) >>
> -                       VE_SRC_LR_EDGE_DET_RT_SHF;
> -               video->frame_left = src_lr_edge & VE_SRC_LR_EDGE_DET_LEFT;
> +               video->frame_right = FIELD_GET(VE_SRC_LR_EDGE_DET_RT,
> +                                              src_lr_edge);
> +               video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT,
> +                                             src_lr_edge);

I suggest putting these on one line to further improve readability:

               video->frame_right = FIELD_GET(VE_SRC_LR_EDGE_DET_RT,
src_lr_edge);
               video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT,
src_lr_edge);

The same for the other lines you've changed above.

And then add:

Reviewed-by: Joel Stanley <joel@jms.id.au>

>                 det->hfrontporch = video->frame_left;
>                 det->hbackporch = htotal - video->frame_right;
> -               det->hsync = sync & VE_SYNC_STATUS_HSYNC;
> +               det->hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
>                 if (video->frame_left > video->frame_right)
>                         continue;
>
> --
> 2.25.1
>
