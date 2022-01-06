Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46704866BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbiAFP3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240432AbiAFP3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:29:44 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12CBC061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 07:29:43 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u13so5633476lff.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 07:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xJ3PGeDOtwFyRNuc2YYiHuhFwO5TobupxcSgXPvySR4=;
        b=FQpmBk3/Wjt178RTWa5MjGIgWKLDgQo0V+DEZfsG0IqHrt4f6xv3pZYAt1Fr0vCbfW
         12r/0qmgz58W/sHhqL+RYLWZTfL//OcGPeBORdm/k8dlGMF+Gvc60OOvm0EisGI1AciA
         xMz/mrS8qY/Rc1A8fR3JqR7BmxJH8r4qcxbWg456/7/oPrvTqx+5iG7cS//N/OQBrPy1
         HymRyaNUghGwQHRVTuOlxftUvseBqg2KZNbkD4NjI/QgVPUCJr1xmmJLWq0Kb3W7YX66
         V++BIm9WLZH6AtQOtiSaZ5Q2y4+ZBU3TPQZsIfDi/XDsrdBPquYA8kGtrQ9kNs+d0tKB
         +hXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xJ3PGeDOtwFyRNuc2YYiHuhFwO5TobupxcSgXPvySR4=;
        b=byAOOlhVr8nNhVNib7JceamM+jAccX9r2wyMuWvqfxU719k4WtQzznVVi0PfTBa1AT
         ofA3Z0K6YoEfdt8iRIYwO3DoNILTsjB23CVUwvBsQhqhB1LklBRx+UDwBmFFQXOEOnP8
         Zn+rMaLz8DFUDj5zgBCj6QHw4AmSp7PSfuXvWBh6l9hTxL8wUB6Eipvh8ULEDCAKX4Yb
         V0Io6WZyJnzFYMKr+gQPJ96oeT5D+fRoC2l88q9A/rjTTqZu596YrPR680/711wFCRQ4
         SMOj2UNIwuZfaO/Rk2+CGIugOfXM8tQqbme9GohD7E2fspss0ZBa8LfjNY2mt85TtuhM
         gdZg==
X-Gm-Message-State: AOAM533FFgowLwaXYfN2C97b5O72hovUgOfJs5/jRtawL+ZpPQ7TP/48
        QKEw3aMXYEvlAQxf9FVS+6PuGw==
X-Google-Smtp-Source: ABdhPJxtF9WdGy7DlYSaV5Es8yw+TBdIOwAZoMFcrTbvlgCH8GoCsVYI3V85BEzchfIKyHoWGxpDuA==
X-Received: by 2002:ac2:4189:: with SMTP id z9mr22974027lfh.639.1641482982111;
        Thu, 06 Jan 2022 07:29:42 -0800 (PST)
Received: from localhost (h-85-24-188-65.A463.priv.bahnhof.se. [85.24.188.65])
        by smtp.gmail.com with ESMTPSA id l5sm198676lfc.190.2022.01.06.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 07:29:41 -0800 (PST)
Date:   Thu, 6 Jan 2022 16:29:41 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] thermal: rcar_thermal: Use
 platform_get_irq_optional() to get the interrupt
Message-ID: <YdcK5WWnEtEQk0Fp@oden.dyn.berto.se>
References: <20220104145212.4608-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YdXt2mDjZ0zikbt6@oden.dyn.berto.se>
 <CA+V-a8sGh0bCiDu_Eiz3EFgaDPmr-qyz95=dExwf+UvuyA21Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+V-a8sGh0bCiDu_Eiz3EFgaDPmr-qyz95=dExwf+UvuyA21Cg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

On 2022-01-05 19:25:25 +0000, Lad, Prabhakar wrote:
> Hi Niklas,
> 
> Thank you for the review.
> 
> On Wed, Jan 5, 2022 at 7:13 PM Niklas Söderlund
> <niklas.soderlund@ragnatech.se> wrote:
> >
> > Hi Lad,
> >
> > Thanks for your work.
> >
> > On 2022-01-04 14:52:11 +0000, Lad Prabhakar wrote:
> > > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > > allocation of IRQ resources in DT core code, this causes an issue
> > > when using hierarchical interrupt domains using "interrupts" property
> > > in the node as this bypasses the hierarchical setup and messes up the
> > > irq chaining.
> > >
> > > In preparation for removal of static setup of IRQ resource from DT core
> > > code use platform_get_irq_optional().
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > v2-v3:
> > > * Fixed review comment pointed by Andy
> > >
> > > v1->v2
> > > * Simplified checking error code
> > > * Break loop earlier if no interrupts are seen
> > >
> > > v1: https://lkml.org/lkml/2021/12/18/163
> > > ---
> > >  drivers/thermal/rcar_thermal.c | 17 ++++++++++++-----
> > >  1 file changed, 12 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> > > index b49f04daaf47..e480f7290ccf 100644
> > > --- a/drivers/thermal/rcar_thermal.c
> > > +++ b/drivers/thermal/rcar_thermal.c
> > > @@ -445,7 +445,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
> > >       struct rcar_thermal_common *common;
> > >       struct rcar_thermal_priv *priv;
> > >       struct device *dev = &pdev->dev;
> > > -     struct resource *res, *irq;
> > > +     struct resource *res;
> > >       const struct rcar_thermal_chip *chip = of_device_get_match_data(dev);
> > >       int mres = 0;
> > >       int i;
> > > @@ -467,9 +467,16 @@ static int rcar_thermal_probe(struct platform_device *pdev)
> > >       pm_runtime_get_sync(dev);
> > >
> > >       for (i = 0; i < chip->nirqs; i++) {
> > > -             irq = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> > > -             if (!irq)
> > > -                     continue;
> > > +             int irq;
> > > +
> > > +             irq = platform_get_irq_optional(pdev, i);
> > > +             if (irq < 0 && irq != -ENXIO) {
> > > +                     ret = irq;
> > > +                     goto error_unregister;
> > > +             }
> > > +             if (!irq || irq == -ENXIO)
> > > +                     break;
> >
> > This do not look correct and differs form v1.
> >
> > In the old code if we can't get an IRQ the loop is continued. This is
> > used to detect if interrupts are supported or not on the platform.  This
> > change will fail on all systems that don't describes interrupts in DT
> > while the driver can function without interrupts.
> >
> There are no non-DT users for this driver. Do you see this driver
> being used in a non-DT environment in near future?

No, maybe I was unclear sorry about that. What I intended to say was 
that this change will break platforms that that make use of this driver 
but do not describe interrupts in its DT description. As with this 
change not describing interrupts is consider an error.

For example checkout thermal@ffc48000 in arch/arm/boot/dts/r8a7779.dtsi.

> 
> > Is there a reason you wish to do this change in addition to the switch
> > to platform_get_irq_optional()? If so I think that should be done in a
> > separate patch.
> >
> No other reason, It was suggested by Gerrt too to use a break instead
> of continue in v1.

I think we need to keep the original behavior.

> 
> Cheers,
> Prabhakar

-- 
Kind Regards,
Niklas Söderlund
