Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372114A66BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbiBAU7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiBAU7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:59:48 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A68C061714;
        Tue,  1 Feb 2022 12:59:48 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id o12so58028528eju.13;
        Tue, 01 Feb 2022 12:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGx7EBxSb7IDUm+z7hlUIuBW5gm80SRoN1CR0+IVN6U=;
        b=PG+aNUZZf2B9D5GG8wTtKnX+q3LbKWzMroa/mXmUFckusWa/NpATh3MZCxGY3GHssN
         jKkrW14ardEHwPpydENxpqpODWr+4TCC+iljCFvb+MVGG1UGMPFgPzbAmz8iAJYVD+ZZ
         F8dPiBmijlIKMKMoOOFTcKMJ9TNnBQT5LuIy48J5A9vzKyfacREYoJwrSRVQ4ZWbRdG2
         hLQ/gFypnoNnfDE0VphhpvoC0Q5X62UUlhhFi0uNlo2HdIIaxl2CXjhtwjvhgJlFvSUD
         Gdg1gmtsXCamBVvHXkWkhy9P4ApBkpvzY1BxEY7de6UDoViyuqlSxwDOjOWYxbY+kPqX
         Mf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGx7EBxSb7IDUm+z7hlUIuBW5gm80SRoN1CR0+IVN6U=;
        b=NwVZt010jL9OgXqwbXi9RAHiEl1UdRk/rrKcYuPzE9a64XOkJPzZ8qga7Zoa8rs06M
         I65MF7wO1hc/3B4LQM3Ttl8kwKeH416ZVscT0f/JU1fnx6wrvYgLXv+dug0w8kF98FSn
         BZo0OvB64c7+/mTIxYPgF0Wt7dAE09r0zYbSgrophSC3ZXhjimAV2Xd1mOX41oDTJVam
         B4qkTT7cHV6YtylfG7dHwMGGV6z/HFSFrmmwu3L53PawG3K6OEiGF/9/MBdF4GNyuPme
         uh5LE5+eeSolyOmZg2gfk1v+FSq0ZOKKrkfIJDS4qfSTANMi0SuMtJ9Uyue74r+jgWmX
         Ru5Q==
X-Gm-Message-State: AOAM531uiLSlM3xjbg6IsYEssSfGv9b+KfOLAFY6i1Khxw/tMwtw/KOM
        Tl/0jyC0fvnTed/1P8y6A2l1r38XH2Xmj1Z/iTo=
X-Google-Smtp-Source: ABdhPJyBs6j7rayRkeF33MDCePZGEQaAf9X/tnXtfnHli4PRFmua9ltKdvOBiWPDEZiMzWisVZ9Aut1MWB7NonTYFog=
X-Received: by 2002:a17:906:99c5:: with SMTP id s5mr22830959ejn.497.1643749186681;
 Tue, 01 Feb 2022 12:59:46 -0800 (PST)
MIME-Version: 1.0
References: <6a62a531227cd4f20d77d50cdde60c7a18b9f052.1643625325.git.geert+renesas@glider.be>
 <CAHp75Vd68gsU-NWTGv4Y7Mo4-Vq7DBePa_yVxpDq=DAN5GLEBA@mail.gmail.com> <CAMuHMdUq3qZqVHH-QSVnwemVRyCp7b2Ldd-7Q2V8CXcj0+9aow@mail.gmail.com>
In-Reply-To: <CAMuHMdUq3qZqVHH-QSVnwemVRyCp7b2Ldd-7Q2V8CXcj0+9aow@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Feb 2022 22:58:10 +0200
Message-ID: <CAHp75VccHbfmmk7bEXRrQOcePYxCb28sEY-RV6GBCgXAo8A5Sw@mail.gmail.com>
Subject: Re: [PATCH] gpio: aggregator: Fix calling into sleeping GPIO controllers
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Mikko_Salom=C3=A4ki?= <ms@datarespons.se>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 10:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Feb 1, 2022 at 9:35 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Feb 1, 2022 at 10:09 PM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:

...

> > > +       return chip->can_sleep ? gpiod_get_value_cansleep(fwd->descs[offset])
> > > +                              : gpiod_get_value(fwd->descs[offset]);
> >
> > This indentation kills the perfectionist in me :-)
>
> Why? The above is aligned perfectly ("?" just above ":")?
>
> > What about:
> >
> >        return chip->can_sleep ?
> >                gpiod_get_value_cansleep(fwd->descs[offset]) :
> > gpiod_get_value(fwd->descs[offset]);
> >
> > ?
> >
> > Or as variant
> >
> >        struct gpio_desc *desc = fwd->descs[offset];
> >
> >        return chip->can_sleep ? gpiod_get_value_cansleep(desc) :
> > gpiod_get_value(desc);
> >
> > ?
>
> IMHO, those are ugly as hell ;-)

I have the same opinion about your initial variant. :-)

So, up to the maintainer(s) what to do.

-- 
With Best Regards,
Andy Shevchenko
