Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DE9494921
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359066AbiATIHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358941AbiATIHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:07:36 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FFEC061747
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 00:07:36 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m11so24987060edi.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 00:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r2XZPfE+X+hfRZcSuFUfhJvd23Su5g+pGJa/HHKyZuQ=;
        b=eFJOzSUIielGSlIJUysQPzbBLr72Ngcwl6nXaTd1kw51bKGXxkFEVOVpYz2okuQgQ5
         /hnMA2eDA+p6GCQk0szEJKPUVNtyUeOCr3j11VAkfwSn0cqG0x7yxc9OnU1TnROAu+sn
         pyCoYVbykWEX1Cms4j3GErPF9bUP8GZW2n7/MKQ9jGZ/zVEgjsIsBFLlvqEAZ8BqQ8Eg
         qTPtcG+4ICjtVgic/BMV69At0JdE5nXy6g/hsVBD1H+7kQVE+D6IUULBXq6uF2zfkzPf
         O6SE/IbZpIMT+gAvsLQKLMWlQr9OnqFiHw6ukH2NCshGaseHShelwdSq65gfkfJAN9Lw
         shgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2XZPfE+X+hfRZcSuFUfhJvd23Su5g+pGJa/HHKyZuQ=;
        b=NQbAMOulKF0qwq3Rml11IvQ0sbD4BUKRsw0vB5Xd5z/K5pN06CBgsYqFQtbv1ffV7C
         2oma3m5o0MlzKN1KbyYS5O9nmOdf2vbhh2iof2QhiIUJ40XLNbTdxAkAjxKh3TwLYNTj
         t1Opdx5b168ccZO9mziedfu+ff4gIfD8Eu+YHYgc507MpILVaPP/m6yqPV2tY6ci73+i
         BeGg+Egtf2J+UWbLP82E3A+Aib7HZ83mtkpdtTwvE9GHZL0BlZSUGOdpSx3W5l3Ac1ur
         mLwhajlkNrSPkEL7jjM0XQNE6Cc0BWbKUzkBB38qLqOBbo49wZb3WCmyFc65y2rubmaB
         Y4bg==
X-Gm-Message-State: AOAM530m0d9feUn2XFEIcWRhszYdV2T3coyphPfMiAhttyseh5B1tL4S
        ylm0qAbnXphO4pKfG9jP6fDCJQklMz21EWb+JFDkJg==
X-Google-Smtp-Source: ABdhPJxj24RqL5dkl9VgrR/mP6/nNez6vsq9SW2EPR71HCu5QH6hjBoh/hhPqGuVl6Wb2xGfnUiJo0HVvOlAN7vwuwM=
X-Received: by 2002:a17:907:968d:: with SMTP id hd13mr4665250ejc.101.1642666054566;
 Thu, 20 Jan 2022 00:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20220119010432.65493-1-yang.lee@linux.alibaba.com> <20220119010432.65493-2-yang.lee@linux.alibaba.com>
In-Reply-To: <20220119010432.65493-2-yang.lee@linux.alibaba.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Jan 2022 09:07:23 +0100
Message-ID: <CAMRc=MfX9=9jkBUmWcJG3fTQ9XQxHgXUo0_9w0qgDKatg_t04w@mail.gmail.com>
Subject: Re: [PATCH -next 2/2] gpio: mpc8xxx: Fix an ignored error return from platform_get_irq()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 2:04 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> The return from the call to platform_get_irq() is int, it can be
> a negative error code, however this is being assigned to an unsigned
> int variable 'irqn', so making 'irqn' an int.
>
> Eliminate the following coccicheck warning:
> ./drivers/gpio/gpio-mpc8xxx.c:391:5-21: WARNING: Unsigned expression
> compared with zero: mpc8xxx_gc -> irqn < 0
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 0b39536cc699 ("gpio: mpc8xxx: Fix IRQ check in mpc8xxx_probe")
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpio/gpio-mpc8xxx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
> index 01634c8d27b3..a964e25ea620 100644
> --- a/drivers/gpio/gpio-mpc8xxx.c
> +++ b/drivers/gpio/gpio-mpc8xxx.c
> @@ -47,7 +47,7 @@ struct mpc8xxx_gpio_chip {
>                                 unsigned offset, int value);
>
>         struct irq_domain *irq;
> -       unsigned int irqn;
> +       int irqn;
>  };
>
>  /*
> --
> 2.20.1.7.g153144c
>

Queued for fixes, thanks!

Bart
