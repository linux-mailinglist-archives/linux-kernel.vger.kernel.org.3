Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7999C48BC08
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347422AbiALAwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343866AbiALAwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:52:07 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD304C06173F;
        Tue, 11 Jan 2022 16:52:06 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id t7so1284239qvj.0;
        Tue, 11 Jan 2022 16:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+BgWpZzbxCgBoKpAYDSuqEtaMBxXySjsMaStwtkHZLg=;
        b=OB80mjKifIvc9EHx5zG+SkcH7yRMZSrRQfy3eaWc/DKzOeWK4e5uBMsZJIbVO0f/Cl
         i+w7LX3TWzIbpkY+IWG4ncOGaxh0UkPRtJfoB4B5ybQtzvpgkKu15LlSR3n8tl2Q8N3b
         mEvoTmZxcExs8mBAlxOFbFFwDWYaZ/bzYvD/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BgWpZzbxCgBoKpAYDSuqEtaMBxXySjsMaStwtkHZLg=;
        b=tM1N17+mIhL8GjNUcKN23UE5u3fCSsBNzXmZgZOsrIEwiL5u1U2Jrfar96htBpNLuc
         XxlA/pcysIpvdKiICAfficvl4+6ycXtbVBaIQ9cppJD7CszPbQwKpZzLc4fMQyR8fl5x
         kxDJGm+epFOrD0oR8L70lInbEokEE/YuoZIn8qDhSuSn5UtEKvrVox/iuM9YvnfqDPB2
         1cop/Oa2PCca+Ty8yPxW6QnHhz1BKS5GGJSG9/fbIqr3WfJeJp4tu8lO+HSPTKhPeTFu
         cIxpR+dxUJW2AaU+VKy/Ty1KAJBAkDLA1ulAt6NTqJhq4K3NYJOmlTotJWJN2Q7Hw0pj
         Ftug==
X-Gm-Message-State: AOAM5330TB1OeZQ7bn7jDfSrHkKnwX2CTypUvnjRreLFkN3cB+ou/icb
        9o8gaenz60MIutSB3JI/3RgVxBM7nlsp+p93IAqWIIzXGoE=
X-Google-Smtp-Source: ABdhPJzJOUMABjpc3ziYwOsfvzN8V0NbNaMl+QXw963PVYPbHL58cyH5UiA1U0TR38v7QS3biobyspuPT3SSX4zmMi0=
X-Received: by 2002:ad4:5dce:: with SMTP id m14mr5680680qvh.130.1641948725803;
 Tue, 11 Jan 2022 16:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20211214045348.13702-1-jammy_huang@aspeedtech.com>
In-Reply-To: <20211214045348.13702-1-jammy_huang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 12 Jan 2022 00:51:53 +0000
Message-ID: <CACPK8XfkXi6M=gzfkYcuoga6WxnzSm2+mspBt4gjop7Ytm+VCA@mail.gmail.com>
Subject: Re: [PATCH] media: aspeed: Fix no complete irq for non-64-aligned width
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

On Tue, 14 Dec 2021 at 04:53, Jammy Huang <jammy_huang@aspeedtech.com> wrote:
>
> In ast2500, engine will stop occasionally for 1360x768.
>
> This is a bug which has been addressed, but the workaround is specific
> for 1680 only. Here we make it more complete.
>
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  drivers/media/platform/aspeed-video.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 793b2adaa0f5..4d3e6b105d44 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -1055,18 +1055,20 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
>         /* Set capture/compression frame sizes */
>         aspeed_video_calc_compressed_size(video, size);
>
> -       if (video->active_timings.width == 1680) {
> +       if (!IS_ALIGNED(act->width, 64)) {
>                 /*
>                  * This is a workaround to fix a silicon bug on A1 and A2

Please add:  "a AST2500 silicon bug" so we know which A1/A2 this is
referring to.

With that added, you can add:

 Reviewed-by: Joel Stanley <joel@jms.id.au>

>                  * revisions. Since it doesn't break capturing operation of
>                  * other revisions, use it for all revisions without checking
> -                * the revision ID. It picked 1728 which is a very next
> -                * 64-pixels aligned value to 1680 to minimize memory bandwidth
> +                * the revision ID. It picked new width which is a very next
> +                * 64-pixels aligned value to minimize memory bandwidth
>                  * and to get better access speed from video engine.
>                  */
> +               u32 width = ALIGN(act->width, 64);
> +
>                 aspeed_video_write(video, VE_CAP_WINDOW,
> -                                  1728 << 16 | act->height);
> -               size += (1728 - 1680) * video->active_timings.height;
> +                                  width << 16 | act->height);
> +               size = width * act->height;

You could make it clearer by putting the write on one line:

                aspeed_video_write(video, VE_CAP_WINDOW, width << 16 |
act->height);
