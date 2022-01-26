Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE8B49C729
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbiAZKMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiAZKMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:12:39 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CB7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:12:38 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 23so69779096ybf.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xq4i7DaguI8skryThxdNyfbFk29T5RJk2Ad5MDxqB7I=;
        b=milU7saKVSeEnF8Dd701ScG1KT6mxQszuXSl/LP/kq5bhLWsfITbUDXTUxAJHrzKrK
         cgWMcSNz/HW3fUrikdI+A5l+P9z4SVf2GY7bQF6/h+yYibdr0PtfwbWS/odr0oBRq9iJ
         BcSOt6CdZAscRBAPKJG61k2Jd91eJ9Bq5f4cuJLuGxpYsd9nonrWE0PlhFQTwgxrSaSF
         Zdm8hU7F3iix02FigaL0oYpDOQd+xck9KlxciRQP1wZH4tZnlzOKzjKiRD7jpkuAU9MO
         j9GaNJ4LS3GKP8iLiw5ZjrT2AT93QtnZSGxncvk3uBeAKesugfh8/bV6JQdEuWy4qSEk
         71Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xq4i7DaguI8skryThxdNyfbFk29T5RJk2Ad5MDxqB7I=;
        b=sZ2+cCtbgmzTIeukHD/aBvzUXcLbPQbZMPXGZw0MthNWkM3i92mVwr2jfl8eXJGQhJ
         ORTERgzrPm5/vFJFAuWPlhxCw3nMg7R6czJVdLIH1+1bZUFapJyO2/kCk9mrtC6B5OZB
         lGIlnU3rEUN01ZphYQXftXJZ2Fe6kTQR7El7dcBBCfFr0QGqRtmgxB5gUiggzNqebKvJ
         HCcVK4t6cfyMMh3KsfK4TXLDoA/S0tRUJwClynugbIKHMm3j5w3LwBRGuc2V4VzWJ3jH
         4MHYkCnwryldaF7tR9I44ygxNptdjTBcXf12znaCqmOsBrwzEEIVUUds0yn+Lv2MGq8b
         lJ4A==
X-Gm-Message-State: AOAM532ptqWr1woD/aiae6lYV49Wz9Q7D+WWkk6LZeUpPfCPHXlC3Izh
        gnaSN9T1sUISUIGVbcFv/eM+OtWy/MEXO0fXe7IK0A==
X-Google-Smtp-Source: ABdhPJwpnc6SO6tCPSAKRYP+MV6zXZuvbpKX4oKp+OcsmFc1guIULcsDkZiW7TAtP876a1yd2Z1807UcrDNDnv0mU0E=
X-Received: by 2002:a25:cb47:: with SMTP id b68mr34928976ybg.397.1643191957973;
 Wed, 26 Jan 2022 02:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20220125054217.383482-1-apatel@ventanamicro.com>
 <20220125054217.383482-3-apatel@ventanamicro.com> <87lez37k8h.wl-maz@kernel.org>
 <CAAhSdy0NrB4Q-mYtMH_HCtbfm5OXi-cxXhiu1AxKdCkTv4cskQ@mail.gmail.com> <87ilu67tvw.wl-maz@kernel.org>
In-Reply-To: <87ilu67tvw.wl-maz@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 26 Jan 2022 15:42:25 +0530
Message-ID: <CAK9=C2Xi60XqzPxTOO+gT3B+-1v4i0QT-9nkhN7hLFX9SchQng@mail.gmail.com>
Subject: Re: [PATCH 2/6] irqchip/riscv-intc: Set intc domain as the default host
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 2:31 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 26 Jan 2022 03:16:55 +0000,
> Anup Patel <anup@brainfault.org> wrote:
> >
> > On Tue, Jan 25, 2022 at 11:47 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Tue, 25 Jan 2022 05:42:13 +0000,
> > > Anup Patel <apatel@ventanamicro.com> wrote:
> > > >
> > > > We have quite a few RISC-V drivers (such as RISC-V SBI IPI driver,
> > > > RISC-V timer driver, RISC-V PMU driver, etc) which do not have a
> > > > dedicated DT/ACPI fwnode. This patch makes intc domain as the default
> > > > host so that these drivers can directly create local interrupt mapping
> > > > using standardized local interrupt numbers
> > > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > ---
> > > >  drivers/clocksource/timer-riscv.c | 17 +----------------
> > > >  drivers/irqchip/irq-riscv-intc.c  |  9 +++++++++
> > > >  2 files changed, 10 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> > > > index 1767f8bf2013..dd6916ae6365 100644
> > > > --- a/drivers/clocksource/timer-riscv.c
> > > > +++ b/drivers/clocksource/timer-riscv.c
> > > > @@ -102,8 +102,6 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
> > > >  static int __init riscv_timer_init_dt(struct device_node *n)
> > > >  {
> > > >       int cpuid, hartid, error;
> > > > -     struct device_node *child;
> > > > -     struct irq_domain *domain;
> > > >
> > > >       hartid = riscv_of_processor_hartid(n);
> > > >       if (hartid < 0) {
> > > > @@ -121,20 +119,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
> > > >       if (cpuid != smp_processor_id())
> > > >               return 0;
> > > >
> > > > -     domain = NULL;
> > > > -     child = of_get_compatible_child(n, "riscv,cpu-intc");
> > > > -     if (!child) {
> > > > -             pr_err("Failed to find INTC node [%pOF]\n", n);
> > > > -             return -ENODEV;
> > > > -     }
> > > > -     domain = irq_find_host(child);
> > > > -     of_node_put(child);
> > > > -     if (!domain) {
> > > > -             pr_err("Failed to find IRQ domain for node [%pOF]\n", n);
> > > > -             return -ENODEV;
> > > > -     }
> > > > -
> > > > -     riscv_clock_event_irq = irq_create_mapping(domain, RV_IRQ_TIMER);
> > > > +     riscv_clock_event_irq = irq_create_mapping(NULL, RV_IRQ_TIMER);
> > > >       if (!riscv_clock_event_irq) {
> > > >               pr_err("Failed to map timer interrupt for node [%pOF]\n", n);
> > > >               return -ENODEV;
> > > > diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> > > > index b65bd8878d4f..9f0a7a8a5c4d 100644
> > > > --- a/drivers/irqchip/irq-riscv-intc.c
> > > > +++ b/drivers/irqchip/irq-riscv-intc.c
> > > > @@ -125,6 +125,15 @@ static int __init riscv_intc_init(struct device_node *node,
> > > >               return rc;
> > > >       }
> > > >
> > > > +     /*
> > > > +      * Make INTC as the default domain which will allow drivers
> > > > +      * not having dedicated DT/ACPI fwnode (such as RISC-V SBI IPI
> > > > +      * driver, RISC-V timer driver, RISC-V PMU driver, etc) can
> > > > +      * directly create local interrupt mapping using standardized
> > > > +      * local interrupt numbers.
> > > > +      */
> > > > +     irq_set_default_host(intc_domain);
> > >
> > > No, please. This really is a bad idea. This sort of catch-all have
> > > constantly proven to be a nuisance, because they discard all the
> > > topology information. Eventually, you realise that you need to know
> > > where this is coming from, but it really is too late.
> > >
> > > I'd rather you *synthesise* a fwnode (like ACPI does) rather then do
> > > this.
> >
> > In absence of INTC as the default domain, currently we have various
> > drivers looking up INTC irq_domain from DT (or ACPI). This is quite a
> > bit of duplicate code across various drivers.
> >
> > How about having a irq_domain lookup routine (riscv_intc_find_irq_domain())
> > exported by the RISC-V INTC driver or arch/riscv ?
> > OR
> > Do you have an alternative suggestion ?
>
> But *why* don't you provide an interrupt controller node for DT? I
> really don't think that's outlandish to require.

Historically, all RISC-V SBI related drivers never had any DT/ACPI
node because we can always query/discover the SBI functionality
at runtime.

The mechanism to query/discover SBI IPI, Timer and PMU is
through SBI base functions. Also, local interrupts used by these
drivers are specified by the RISC-V specification. This means having
a DT/ACPI node for these drivers doesn't provide any info.

We will be having KVM RISC-V AIA support in future which will not
have a DT/ACPI node as well because this can be discovered as a
CPU capability and the local interrupt to be used is specified by the
RISC-V hypervisor specification.

>
> For ACPI, we already have an interface that allows a fwnode to be
> registered (acpi_set_irq_model) and interrupts mapped
> (acpi_register_gsi).

The ACPI specification being proposed for RISC-V does not have
any details for SBI IPI, Timer, and PMU for the same reasons
mentioned above.

>
> You should already have all the required tools you need.

Are you okay if arch/riscv exports riscv_intc_find_irq_domain() ?
OR
Maybe export riscv_intc_find_irq_domain() from INTC driver ?

Regards,
Anup


>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
