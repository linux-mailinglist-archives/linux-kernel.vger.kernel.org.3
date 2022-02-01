Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DE84A6027
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbiBAPaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:30:16 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:39566 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiBAPaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:30:14 -0500
Received: by mail-pg1-f177.google.com with SMTP id j10so15634622pgc.6;
        Tue, 01 Feb 2022 07:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/NI5/5cwcQQunIPAZVQCMWs9N9hH37FdlDTNKGxYQ7E=;
        b=czGicOYjyzjexnLsimliwumlykAb8e3USmaeRjoflReW4k2qDZxjNz9d0obk2Gnebv
         Z4Iozt/EKNnVANnHAH8+omAl2gKzzvIboQZOEBdm9ro1Uz4g8LP1uiwH4s6a8wqzkWlK
         oTr8h8HfKb+5SpR9vUKYqx3j48Jpya0H4IEgQEDms2Mrf+2Gux2s7b75RZaveHT4vVtk
         0lKxT2i1AfKi2Knz6hgREMcP04qc4AOf+OAt6vB9h2U0oSk+Uks9k8iwK3m7Xxg1bcmL
         hy+baL52Pv4GsJ8udwg/PzCOlD1VFE6oVu8IJLeuuhFuvcEx0q3nVj6ErfaSBhhXZBWM
         Zb9w==
X-Gm-Message-State: AOAM530HbJSb0t6JFgsMiKeCYwKc9kVw1tosQr/aygy23Zkx1IzGG1h2
        1F0OaBeDnSgksn2xnMmxcIU8LDCOSUwqbG6KhQM=
X-Google-Smtp-Source: ABdhPJwZNq0IinMera7zRuVK7Muwvrp92NYs2qCGjwudmM11k2zeBJdEaahQlwH16dsk6UqlFGc0aAuF4CaTORjd4vE=
X-Received: by 2002:a63:904c:: with SMTP id a73mr21118692pge.449.1643729414082;
 Tue, 01 Feb 2022 07:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20220201120310.878267-1-maz@kernel.org> <20220201120310.878267-12-maz@kernel.org>
 <CANBLGcxCmeaXXFWi6GFSHN=RhjUp5BVRYTMXHQihsLJCocD1xg@mail.gmail.com>
In-Reply-To: <CANBLGcxCmeaXXFWi6GFSHN=RhjUp5BVRYTMXHQihsLJCocD1xg@mail.gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Tue, 1 Feb 2022 16:30:02 +0100
Message-ID: <CANBLGcy_zEY7qkMe96v+tpsxbp9CDJh14utug5wseCfBhOSvdA@mail.gmail.com>
Subject: Re: [PATCH 11/12] pinctrl: starfive: Move PM device over to irq domain
To:     Marc Zyngier <maz@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2022 at 16:16, Emil Renner Berthing <kernel@esmil.dk> wrote:
> On Tue, 1 Feb 2022 at 13:19, Marc Zyngier <maz@kernel.org> wrote:
> >
> > Move the reference to the device over to the irq domain.
> >
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/pinctrl/pinctrl-starfive.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pinctrl/pinctrl-starfive.c b/drivers/pinctrl/pinctrl-starfive.c
> > index 0b912152a405..5be9866c2b3c 100644
> > --- a/drivers/pinctrl/pinctrl-starfive.c
> > +++ b/drivers/pinctrl/pinctrl-starfive.c
> > @@ -1307,7 +1307,6 @@ static int starfive_probe(struct platform_device *pdev)
> >         sfp->gc.base = -1;
> >         sfp->gc.ngpio = NR_GPIOS;
> >
> > -       starfive_irq_chip.parent_device = dev;
> >         starfive_irq_chip.name = sfp->gc.label;
> >
> >         sfp->gc.irq.chip = &starfive_irq_chip;
> > @@ -1330,6 +1329,8 @@ static int starfive_probe(struct platform_device *pdev)
> >         if (ret)
> >                 return dev_err_probe(dev, ret, "could not register gpiochip\n");
> >
> > +       irq_domain_set_pm_device(sfp->gc.irq.domain, dev);
> > +
>
> The gpio framework uses the irq_domain at sfp->gc.irq.domain, so
> shouldn't this be set before registering the gpio_chip with
> devm_gpiochip_add_data above?

Ah, no. sfp->gc.irq.domain is a pointer to an irq_domain that is
initialised when adding the gpio_chip.

Reviewed-by: Emil Renner Berthing <kernel@esmil.dk>
