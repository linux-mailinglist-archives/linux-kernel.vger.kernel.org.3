Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2104D2EC7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiCIMLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiCIMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:11:10 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5188B3C703
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:10:12 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id u61so3831437ybi.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 04:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cQLvcGskf9flSlq3jr8x/SzuljCHGLtYRtMn9KIcb0k=;
        b=Y4QGOQ/6gZ1wN+BlJhrW6wUPKAoZias17oNdcpoJWoxIJLC+iFhWtFn6D8LW8u5fSJ
         jvsztDkw8ZwUtTCUPH80/BRYh97f8dfU6M9FZGSH6q2RLl6Tm0NpGzs5JS3JAYihh8cq
         BtmaASX7TYZKx2uh/04/OCIYu+8m/WUw51vxxZ5NMr+oZ7PgJP6PPwauEBh2UhgV5hmH
         JNxWaK7l+w2GyxebZNw9ld8AgtUGa4g7E3vPGAjZ6HT8/XrVQ4mhRdWPp8IQnUHb6sfx
         QPSsbToua1NUGFKAZMbC1+nb5PHSnG9e6iQimeBWx2c/f6pRfZKBJfsdlHp+a3SJZ1or
         VeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cQLvcGskf9flSlq3jr8x/SzuljCHGLtYRtMn9KIcb0k=;
        b=ECVW4vdIWKtYHlrVVvMxlIojFcn5OHxQEm/8Tm0drqhd6GbGI2f2vRpevcvSJ3F5wy
         0rfUbswWZZVuvsriacW1+zaxFKNPIMi4VpixxS8iBxffhl9wJu2czTqt9jjauuciXaX9
         kSWXsmU+BHceK0JcbGMgS2QIHqlXUN6uCO6BgkjRYS/3zEWwClDxns0FAAh6/2qeFmVP
         rsc/hcFvyZIuledye95taooOijHfnq+Id9XA1qHOga53zIbpr1oufOiXiVM0IF8RgEj5
         cFXbpayYaRJPcYzKP6zATyOO7b5dOzQTSTC2F6Or9/poGxKGdK3bl2cU7PX1eAmccDpl
         Wgsw==
X-Gm-Message-State: AOAM530lGFLUZP172wlb9N3V/D/YTeM6SyWR7Rcz8wNxM+XBtaSq7Aqc
        uSYoiR8tIlCpuYLyrFjfu4qvmZOM72RyVWZQvls=
X-Google-Smtp-Source: ABdhPJzUt/vPIMAvKkMw9ZoQ1VV2XKJQz1l0qtx5xTgNbD+luDDCu86K2stqgGNGAEKdP9v2HRLn2nb8LvKQnWJwHRg=
X-Received: by 2002:a25:8289:0:b0:623:dc4d:28e5 with SMTP id
 r9-20020a258289000000b00623dc4d28e5mr15263229ybk.182.1646827811466; Wed, 09
 Mar 2022 04:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20211224161334.31123-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211224161334.31123-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211224161334.31123-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 9 Mar 2022 12:09:45 +0000
Message-ID: <CA+V-a8viRAW+YxhU=Krmc+zF3ixDOV8nL72PG7CP0iYU9onOhw@mail.gmail.com>
Subject: Re: [PATCH] platform: goldfish: pipe: Use platform_get_irq() to get
 the interrupt
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I'm not sure how I missed you to add in the to list.

On Fri, Dec 24, 2021 at 4:13 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi,
>
> Dropping usage of platform_get_resource() was agreed based on
> the discussion [0].
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
> ---
>  drivers/platform/goldfish/goldfish_pipe.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
Do you want me to resend this patch?

Cheers,
Prabhakar

> diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
> index b67539f9848c..7737d56191d7 100644
> --- a/drivers/platform/goldfish/goldfish_pipe.c
> +++ b/drivers/platform/goldfish/goldfish_pipe.c
> @@ -896,11 +896,9 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> -       r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -       if (!r)
> -               return -EINVAL;
> -
> -       dev->irq = r->start;
> +       dev->irq = platform_get_irq(pdev, 0);
> +       if (dev->irq < 0)
> +               return dev->irq;
>
>         /*
>          * Exchange the versions with the host device
> --
> 2.17.1
>
