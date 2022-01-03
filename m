Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A26482FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiACJuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiACJuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:50:50 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B27C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 01:50:50 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b13so133734588edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 01:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=glHDbRAfQ2rWjG1rklFOPeGp0Df2FguJaQkq2LO7OfI=;
        b=5t+34L7U7Tu1JBDFrp9LGR1M9FHGtjeKJgpZDTUpolYJPyPbaBv9n2ysUAcIlV3yh0
         aMbKyGfS834ruFVZpL70mVwtCHPDJZOTSiggGd428KfMPQMdL8f5SyhMfWf+beAgE6Ci
         2cp6PKjtLxhJbIUbMPumjDF2ytaD/r6BoD3VRzTB5g/Gs2jjcMCj1/2oj88DflyIWzlf
         7n6ezIHCxDWxaZSLbWmpkrr3062Qv1P9HVPI/EfxF05zZeGVAIAIJrH7B4Fe6Rb/3hMP
         Kp8cENGNPF0A+i2ouMiJKcIQ8aRSfvQCqOAa08TgxzRcnX4kNbGDKqcbYzwuo8NSjlV7
         FA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glHDbRAfQ2rWjG1rklFOPeGp0Df2FguJaQkq2LO7OfI=;
        b=eY/mo9SmxfCCIMJR8n2Yt1NHvBGUOsSreJ4SeJh8J3LjBkieT3u1Do102R1AifTw29
         1PD+yt7dcCHXmQlYkI4HJ2j8viCLPY4+JxJ3FHeVgseiUDdJW07CUp8cVYSoXvfQuHPA
         4j6xvEwURtoEAks3SVfgJpT3eXYNTnD0fpdUWZgU4bt1DQf/dG9/ymLMP5yrDmzajXnf
         Bx0J6LHU5tuYC9FgH5gEzhGdKdhZ//++DfX8OZ4yg4BJHN7OzMwp+WfbE8TwIKXq/JZY
         Rsw3sH5kzXYGpRG24LydDnGdMS7Wr9KtwCPKPxbLv7t03pxsSFHG5I+Ttnjocz0O1kpv
         EQ0w==
X-Gm-Message-State: AOAM530srD9hY2xOMLqtjKcODRrpFjJJ+xbs6ij3hkhsVpLYnsUqfBJZ
        +R8oK0wZrtX+PKtjD6MIffWijRNb49fCdaK9WoFWEA==
X-Google-Smtp-Source: ABdhPJwGxzpdSFJDk/tcI94f8WJ6YG2uYjdkrRAo9XjIF9wkF8LCVv6c2K+zndyohDFv96C6YiCL5WIwP+3d+8dsSKc=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr34869918ejj.636.1641203449046;
 Mon, 03 Jan 2022 01:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20211214040239.8977-1-steven_lee@aspeedtech.com>
 <20211214040239.8977-2-steven_lee@aspeedtech.com> <CAMRc=MdAgK7zKuJ=7cA2T-mSTJD3tWSW2aEB6G=0Tz4X+iHcZQ@mail.gmail.com>
In-Reply-To: <CAMRc=MdAgK7zKuJ=7cA2T-mSTJD3tWSW2aEB6G=0Tz4X+iHcZQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 3 Jan 2022 10:50:38 +0100
Message-ID: <CAMRc=McjZZTMjR+riwjj6SLEh=fYq0yjBQYNgzGXHok6=OTz_w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: gpio-aspeed-sgpio: Fix wrong hwirq base in
 irq handler
To:     Steven Lee <steven_lee@aspeedtech.com>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>, ryan_chen@aspeedtech.com,
        billy_tsai@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:18 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Tue, Dec 14, 2021 at 5:03 AM Steven Lee <steven_lee@aspeedtech.com> wrote:
> >
> > Each aspeed sgpio bank has 64 gpio pins(32 input pins and 32 output pins).
> > The hwirq base for each sgpio bank should be multiples of 64 rather than
> > multiples of 32.
> >
> > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > ---
> >  drivers/gpio/gpio-aspeed-sgpio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
> > index 3d6ef37a7702..b3a9b8488f11 100644
> > --- a/drivers/gpio/gpio-aspeed-sgpio.c
> > +++ b/drivers/gpio/gpio-aspeed-sgpio.c
> > @@ -395,7 +395,7 @@ static void aspeed_sgpio_irq_handler(struct irq_desc *desc)
> >                 reg = ioread32(bank_reg(data, bank, reg_irq_status));
> >
> >                 for_each_set_bit(p, &reg, 32)
> > -                       generic_handle_domain_irq(gc->irq.domain, i * 32 + p * 2);
> > +                       generic_handle_domain_irq(gc->irq.domain, (i * 32 + p) * 2);
> >         }
> >
> >         chained_irq_exit(ic, desc);
> > --
> > 2.17.1
> >
>
> Joel, Andrew: any comments on this? I'd like to send it upstream tomorrow.
>
> Bart

I don't want to delay it anymore, it looks good so I queued it for fixes.

Bart
