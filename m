Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1B04B10BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243131AbiBJOqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:46:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiBJOqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:46:32 -0500
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADD9C4C;
        Thu, 10 Feb 2022 06:46:32 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id l19so4817657pfu.2;
        Thu, 10 Feb 2022 06:46:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCmIvMlR/ZlfeXsNsYCs46xpUmqAdMgLfmRLO/lpunQ=;
        b=ISydJ1XSlj2gVHwlamSHZw4AVh+wBfRtNP9uBhN15Hh97PhAbupc3RavH8zhC2V5F8
         i0kQDeKDVE7mMd4/enNsio0rqYOY0sERUulpKY99rTlogDEP8HqNTddnKf7Jbg0NgFvi
         rD2E0f4WIVfmU1FeaFCF9SsNk24OD+mnWfvNfTWMJLOmahBF5dBDGQqDOoxx1/hajSOh
         ioyHNoVR0Nfme4z/vVM4LYuZs8kfSI229n+jhj9s6rimg0N7nzfPwl9SKsEMUIk7yh++
         R5nZU5i5obC4bDOk8CnruPKghtFuSXZ5t/5JawHJKGVSYpIw1PBVCq8QwUOAA5einY/0
         0S4A==
X-Gm-Message-State: AOAM531n+e31GcZOI/HdDSPQZPE/avUkL0pJUksL6fj1mHqXf8nny4+P
        k2uYokXnPXfrfD5iC9HOjv3egUeuiRshhcVktVI=
X-Google-Smtp-Source: ABdhPJzB/awCQxjhxJpQKAIcXS73LtyrxfoD04nH0F56ARwV+mk/TmnMPhasUcggGx2xt4MJflyugG5AHyM2Pi11s0U=
X-Received: by 2002:a05:6a00:22c9:: with SMTP id f9mr7766834pfj.79.1644504392469;
 Thu, 10 Feb 2022 06:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20220209162607.1118325-1-maz@kernel.org> <20220209162607.1118325-11-maz@kernel.org>
 <CANBLGcwKeLn7Q1Ra8pCw=cXy=kJeEFRmBjOxjds10+k70LvzXA@mail.gmail.com>
 <87zgmz3xbf.wl-maz@kernel.org> <CANBLGcwwrqkYS2cxX5dYAaoWdj5pRp9c+qBDAMb3=0D5oBD+Zg@mail.gmail.com>
 <87v8xm4zkm.wl-maz@kernel.org> <CANBLGcyvMVdTnndMSWDFnN6207Nareps=AdzVvt0OaMdeAXEHg@mail.gmail.com>
 <87tud64yqa.wl-maz@kernel.org> <CANBLGcxg0qKWw4aifr+dHWge1aXE66e4wZzDwwpJjSad3xaeTQ@mail.gmail.com>
 <87pmnu4wpt.wl-maz@kernel.org>
In-Reply-To: <87pmnu4wpt.wl-maz@kernel.org>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Thu, 10 Feb 2022 15:46:21 +0100
Message-ID: <CANBLGcwMmK+caG03B9NXGDvqyyijKLcOj90A3_+AN09iRzbeNw@mail.gmail.com>
Subject: Re: [PATCH 10/10] pinctrl: starfive: Switch to dynamic chip name output
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 at 15:34, Marc Zyngier <maz@kernel.org> wrote:
>
> [resending, as I managed to royally screw up my initial email]
>
> On Thu, 10 Feb 2022 14:14:19 +0000,
> Emil Renner Berthing <kernel@esmil.dk> wrote:
> >
> > On Thu, 10 Feb 2022 at 14:50, Marc Zyngier <maz@kernel.org> wrote:
> > > On Thu, 10 Feb 2022 13:44:12 +0000,
> > > Emil Renner Berthing <kernel@esmil.dk> wrote:
> > > >
> > > > Gotcha. The SoC has been out in very few numbers for less than a year
> > > > and the driver only entered mainline in 5.17-rc1, so I doubt anyone
> > > > has had time to write scripts that check for this, but I'll let it be
> > > > up to you.
> > >
> > > Ah, I should have checked that. In which case, would you be OK if I
> > > simply pushed the removal of this label as a fix for 5.17, and just
> > > have it to say "Star5 GPIO", for example, without any indication of
> > > the device (which appears in debugfs anyway as part of the irqdomain)?
> >
> > I'm fine with it although I'd prefer "StarFive GPIO". I haven't seen
> > star5 used anywhere.
>
> Fair enough.
>
> > But shouldn't changes like this normally go through Linus Walleij's
> > tree?
>
> Either way, I don't mind. For the record, see below what I'm
> suggesting we take in before 5.17-final.

Looks good to me. I don't mind which tree it goes through, just wanted
to make sure everyone's happy.

> Linus?
>
> Thanks,
>
>         M.
>
> From a84b83c32048de2ba72e5d05645eabc95ffabe49 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Thu, 10 Feb 2022 14:13:36 +0000
> Subject: [PATCH] pinctrl: starfive: Use a static name for the GPIO irq_chip
>
> Drop the device name used for the GPIO irq_chip and replace it
> with something static. The information is still available from
> debugfs and carried as part of the irqdomain.
>
> Suggested-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pinctrl/pinctrl-starfive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-starfive.c b/drivers/pinctrl/pinctrl-starfive.c
> index 0b912152a405..266da41a6162 100644
> --- a/drivers/pinctrl/pinctrl-starfive.c
> +++ b/drivers/pinctrl/pinctrl-starfive.c
> @@ -1164,6 +1164,7 @@ static int starfive_irq_set_type(struct irq_data *d, unsigned int trigger)
>  }
>
>  static struct irq_chip starfive_irq_chip = {
> +       .name = "StarFive GPIO",
>         .irq_ack = starfive_irq_ack,
>         .irq_mask = starfive_irq_mask,
>         .irq_mask_ack = starfive_irq_mask_ack,
> @@ -1308,7 +1309,6 @@ static int starfive_probe(struct platform_device *pdev)
>         sfp->gc.ngpio = NR_GPIOS;
>
>         starfive_irq_chip.parent_device = dev;
> -       starfive_irq_chip.name = sfp->gc.label;
>
>         sfp->gc.irq.chip = &starfive_irq_chip;
>         sfp->gc.irq.parent_handler = starfive_gpio_irq_handler;
> --
> 2.34.1
>
>
> --
> Without deviation from the norm, progress is not possible.
>
> --
> Without deviation from the norm, progress is not possible.
