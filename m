Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645FA47CAB6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbhLVBWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbhLVBWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:22:49 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA367C061574;
        Tue, 21 Dec 2021 17:22:49 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z9so549847qtj.9;
        Tue, 21 Dec 2021 17:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNVgFuSkvXsOF4mMDEXYWlsVrY9TlgTecIPAVLkOuWs=;
        b=NTUsZ+hXhAodFI9Oan+WRQ3tF0KpKZnGm18/mkaitLP2Ggx9jiN3HG4WVR7UsgomM4
         LNeynEFuG7cIg8gIUZdiizlJ1815Kx+tG5yi0mXaU6NPdtJxOcHD99hO8I2VDtUKdp5/
         wgAmLauiM8/dqVp43ngZ1f9vLn+6DKkqIdHUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNVgFuSkvXsOF4mMDEXYWlsVrY9TlgTecIPAVLkOuWs=;
        b=gn+7HxzOfiSdPeLqmAO4vloMea1jV7S+uPfroneA+BVRtH4TWbtBJiERzJQ7ffv1q6
         W7v2tKWo4V564Ak5vU6eat056M6hVVEETlyjLtRELJerfxTZ0LtzHkXy4wYNd4G7HeJw
         ydFYLXiGuZr7b47Mk/HJ8JkI5ZFWFoPWHFNhJacu/1K11+zHkX6iHnAqg/m5xikNq4ay
         LIdIvq7x8ar51DulevmX0dO+nZApjPkTCkfUyDrIydaA+nBc9q0nlo2BuaznaJvWH7DU
         xcXgoTDRXzhLTgH3ShTAaDuebtegcwMGs24yiQBaRKRXhi5h0lC5x5kYX68YBvJ6RsmC
         ZL5w==
X-Gm-Message-State: AOAM532I/+LJnb1DwLi62eUXBX1JrHeI2urYpojnmlzpYqHC1JgWDh5t
        x/l2zkv+dS1oD6tDvzsEeolPOy25cxcbtLauBWg1Zwaw
X-Google-Smtp-Source: ABdhPJy3jDioVIMXa2v625o3reDXrAtyaAv6CujTMELAi6Yci7xqNtalhS1zaix51U3flPHoVs8qoyEnjyutV/e5lvg=
X-Received: by 2002:a05:622a:588:: with SMTP id c8mr699346qtb.108.1640136168852;
 Tue, 21 Dec 2021 17:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20211217095403.2618-1-jammy_huang@aspeedtech.com> <20211217095403.2618-5-jammy_huang@aspeedtech.com>
In-Reply-To: <20211217095403.2618-5-jammy_huang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 22 Dec 2021 01:22:36 +0000
Message-ID: <CACPK8Xf7rsjgCv=Honyf8gwDWbG67dPVjE+z_tXD4yEu1WaE5w@mail.gmail.com>
Subject: Re: [PATCH 4/4] media: aspeed: Fix timing polarity incorrect
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
> This is a workaround for polarity unstable.
> Sync value get by VR09C counts from sync's rising edge, which means
> sync's polarity is negative if sync value is bigger than total/2.
>
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  drivers/media/platform/aspeed-video.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 5ad3a20c5bac..f628f69bb7dd 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -989,6 +989,15 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>                 video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP,
>                                              src_tb_edge);
>                 det->vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
> +               /*
> +                * Workaround for polarity detection
> +                * Use sync(VR098) counts from sync's rising edge till falling
> +                * edge to tell sync polarity.
> +                */
> +               if (det->vsync > (FIELD_GET(VE_MODE_DETECT_V_LINES, mds) >> 1))

Are you right shifting as this is the value / 2? I think it's clearer
to write / 2 instead of >> 1.

Mention in the comment that this is a workaround for when the sync
value is larger than half.

> +                       det->polarities &= ~V4L2_DV_VSYNC_POS_POL;
> +               else
> +                       det->polarities |= V4L2_DV_VSYNC_POS_POL;
>                 if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
>                         det->vbackporch = video->frame_top - det->vsync;
>                         det->vfrontporch =
> @@ -1010,6 +1019,15 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>                 video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT,
>                                               src_lr_edge);
>                 det->hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
> +               /*
> +                * Workaround for polarity detection
> +                * Use sync(VR098) counts from sync's rising edge till falling
> +                * edge to tell sync polarity.
> +                */
> +               if (det->hsync > (htotal >> 1))
> +                       det->polarities &= ~V4L2_DV_HSYNC_POS_POL;
> +               else
> +                       det->polarities |= V4L2_DV_HSYNC_POS_POL;
>                 if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
>                         det->hbackporch = video->frame_left - det->hsync;
>                         det->hfrontporch = htotal - video->frame_right;
> --
> 2.25.1
>
