Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7935B48BC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347455AbiALAx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343866AbiALAxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:53:25 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EBFC06173F;
        Tue, 11 Jan 2022 16:53:25 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id y17so1259843qtx.9;
        Tue, 11 Jan 2022 16:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bn6LXYkb5vJoSA2+wYUtLd/FTU4C6AaGfIXYzaQTkB4=;
        b=g+bG6qp7d16/Bm6fLmk9kal8e7Ni7EM3x9j7lmP2pd2eYVaNmm7hxjrEj0Ckp3yJi6
         3lsoB8UMz04gacJAEz0UAlEF7NK4vpKAAuh7WbS9HT+KiF4VgVHpRgpP01xiYbC53dE8
         o0lo6e1atdVhDXDcHAY7viUa+8O6LGpugkPUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bn6LXYkb5vJoSA2+wYUtLd/FTU4C6AaGfIXYzaQTkB4=;
        b=MIxchdvFX6OGlZBd3Lp08Z5gAFsdolyEou7oZSyVDAUCYaHtpXT8va1IygHnj4BgT+
         xv+/e2TZ6qH/GLQLYBPf8w692aUYymEhGeMHV9VA25qONoGbRkRXXFrh6NWxhaNblOEH
         ThzVNRmqE9SYeIf4uBVNEeVVpWiHYV19+b4RVRMQEa4EirU6P9ewbJfAhP5JS+FjeQRw
         gpcnkSaN2T+rxRh9bJFwpYzQx694sHJXkVS2klYgDEkNEYjkzDI68DKllmgF99C+u0gm
         lJDrZAZaTPmVzPnFuwIRkKpUbpBH/beOl9lTM8nRMWPxe0u5p/MVD/vdPnkBmkLbPFfF
         9nJw==
X-Gm-Message-State: AOAM533eCPTK2UDpB26BWtpCcR8qtaIDteacp0tbzKIM2MFIQaa/u1rk
        9HxGIsjbwg1TQ+JChX6ZGdtQQoRc0+fKhgf+dc4=
X-Google-Smtp-Source: ABdhPJxTg2vyG/RY3cEh3LvIQ5+6rj7Uz5GMFpvmPNspTJRCbdFJYoUg/3X4brah8OJSqaTk4qsHuqoJz1+zVF1gJUA=
X-Received: by 2002:ac8:5a0b:: with SMTP id n11mr5879929qta.625.1641948804856;
 Tue, 11 Jan 2022 16:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20211214040239.8977-1-steven_lee@aspeedtech.com>
 <20211214040239.8977-2-steven_lee@aspeedtech.com> <CAMRc=MdAgK7zKuJ=7cA2T-mSTJD3tWSW2aEB6G=0Tz4X+iHcZQ@mail.gmail.com>
 <CAMRc=McjZZTMjR+riwjj6SLEh=fYq0yjBQYNgzGXHok6=OTz_w@mail.gmail.com>
In-Reply-To: <CAMRc=McjZZTMjR+riwjj6SLEh=fYq0yjBQYNgzGXHok6=OTz_w@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 12 Jan 2022 00:53:12 +0000
Message-ID: <CACPK8XdXkrTfsMoZRDjQ_-MwOQ-no_B2yG3F79_SkQ0o6mGuQg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: gpio-aspeed-sgpio: Fix wrong hwirq base in
 irq handler
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Steven Lee <steven_lee@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022 at 09:50, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Wed, Dec 22, 2021 at 10:18 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Tue, Dec 14, 2021 at 5:03 AM Steven Lee <steven_lee@aspeedtech.com> wrote:
> > >
> > > Each aspeed sgpio bank has 64 gpio pins(32 input pins and 32 output pins).
> > > The hwirq base for each sgpio bank should be multiples of 64 rather than
> > > multiples of 32.
> > >
> > > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > > ---
> > >  drivers/gpio/gpio-aspeed-sgpio.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
> > > index 3d6ef37a7702..b3a9b8488f11 100644
> > > --- a/drivers/gpio/gpio-aspeed-sgpio.c
> > > +++ b/drivers/gpio/gpio-aspeed-sgpio.c
> > > @@ -395,7 +395,7 @@ static void aspeed_sgpio_irq_handler(struct irq_desc *desc)
> > >                 reg = ioread32(bank_reg(data, bank, reg_irq_status));
> > >
> > >                 for_each_set_bit(p, &reg, 32)
> > > -                       generic_handle_domain_irq(gc->irq.domain, i * 32 + p * 2);
> > > +                       generic_handle_domain_irq(gc->irq.domain, (i * 32 + p) * 2);
> > >         }
> > >
> > >         chained_irq_exit(ic, desc);
> > > --
> > > 2.17.1
> > >
> >
> > Joel, Andrew: any comments on this? I'd like to send it upstream tomorrow.
> >
> > Bart
>
> I don't want to delay it anymore, it looks good so I queued it for fixes.

Thanks for queuing. We were on leave over the holiday break, so no
time for reviewing kernel patches.

Cheers,

Joel
