Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA87B490956
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbiAQNTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiAQNTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:19:20 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D832C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 05:19:19 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b13so65685473edn.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 05:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WA6O0qeBhGhPwH/1DXGtARWpn1Ethl8enza48mvpDME=;
        b=7vC2x24eRoH0fBUdpLVkefTTwvqFXA2+RACJcTNHHK4vyWpYsNvPMQgCeHaxeph6ql
         Q+HlL2qY5gFdX8CpBwNpkV0g+PoXcD5y80UKqWJm5vey19fnOYUCsk4Yv5vk6CUkauW6
         Kwsbb6PJRF6JeWTDco1QGyjYouyO4WwFMFpiqiNJwBnL4FJAGYxe96kkIbLAq2E8J+YR
         5CPfURHfsApId5+ZmRQ8uwevuu3LzKu3gOna8Js9qJMMOeicJ+5pK4gc43xYYCq16Ta8
         nmDSeh0z9Q1YOvFhh57OzG3ZyKSztXIecIdaPYbrDZ6mSAMmzIWc6sE16/rE1Ia6yIqg
         st4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WA6O0qeBhGhPwH/1DXGtARWpn1Ethl8enza48mvpDME=;
        b=u6MEORn9aIYCv00DW6Tvr63ujsaQpEEKcvbiksSRTx06c+r5R8eOIOv2bk8au7dRh4
         9YrC9MHM5dO0DZlDk6mmCWVM8/EI6WOPRHEVjMLiFMuiznvJ2JSUROOQ3oDtIBHxgN/C
         VCX04zrqd5tfvN63hA2s5W6pEe9xufDcSzsbdsixhZwOW/p5qnMV/cBC6AAFK48It0MJ
         cPgr9D1t8nMrVPHVwAtdQXM6UwiKT3QJ4KYzltjEeJdf81sQ09p8+oQSWIVqVLERf8+z
         AlXicxdl0PfjJ/FLZ2FcdfJYkTha76hFQitCw4eF7fSSVq+wiIvmz4KrOo3rl8Ta03yJ
         v1uw==
X-Gm-Message-State: AOAM5317fZ4FTE9DJ1llig59ZR6LcMb8Q4Yy6ygVCgJ+zwqal2dXJPVv
        rGv4x3Yom9uEgvOO+fglhw8e3UlZiglSPKUGuewNqg==
X-Google-Smtp-Source: ABdhPJwKeAG7GJeyJiPIuuiKwQjuKRUqemslYzsrPGDH9sdNKvixEeCA0L2AWM5kfq2h+f9Z+OQTjino+HtnnYR6140=
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr6273843ejb.286.1642425557886;
 Mon, 17 Jan 2022 05:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20220114064821.20200-1-linmq006@gmail.com>
In-Reply-To: <20220114064821.20200-1-linmq006@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 17 Jan 2022 14:19:07 +0100
Message-ID: <CAMRc=Mcfoi+yRK7-AZehEPtT68_GPMmn1J7Kt4TzTTAMvL_u7Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: mpc8xxx: Fix IRQ check in mpc8xxx_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ran Wang <ran.wang_1@nxp.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 7:48 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> platform_get_irq() returns negative error number instead 0 on failure.
> And the doc of platform_get_irq() provides a usage example:
>
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
>
> Fix the check of return value to catch errors correctly.
>
> Fixes: 76c47d1449fc ("gpio: mpc8xxx: Add ACPI support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/gpio/gpio-mpc8xxx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
> index 70d6ae20b1da..01634c8d27b3 100644
> --- a/drivers/gpio/gpio-mpc8xxx.c
> +++ b/drivers/gpio/gpio-mpc8xxx.c
> @@ -388,8 +388,8 @@ static int mpc8xxx_probe(struct platform_device *pdev)
>         }
>
>         mpc8xxx_gc->irqn = platform_get_irq(pdev, 0);
> -       if (!mpc8xxx_gc->irqn)
> -               return 0;
> +       if (mpc8xxx_gc->irqn < 0)
> +               return mpc8xxx_gc->irqn;
>
>         mpc8xxx_gc->irq = irq_domain_create_linear(fwnode,
>                                                    MPC8XXX_GPIO_PINS,
> --
> 2.17.1
>

Queued for fixes, thanks!

Bart
