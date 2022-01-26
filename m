Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E780B49C1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiAZDRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiAZDRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:17:09 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3892C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 19:17:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c23so7620114wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 19:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBMdlXBwnvmmPNUewfDMh0H5M/2d+zAT6/3Iwl0rMhQ=;
        b=2hkCjLJXNAlhQ1LUkJt6pNjDvtjs2OnmxqENbtatgOTh31p8z+9Mqv0niYVwX/l8pk
         ClUB570vDbOr8k+Hx/Wv50Q3w8GihVLYUXdu+K/erHBbDgrId+MwHePcdsI5oxQelBYk
         f3QyqP/p8SIgane+7W7yUZJB5V5R28ZWAhfXrR5CihS0gmQIaBEZguge6Rb9RNaQpxbK
         eS8k3FKGThIhtR0JXPdSDOPVmHz6h+XMI8NOQQ5bhcn4hJBRxbTQOMTN/P0aGOFl500p
         3hEq88NaviARy1N5+PY122QI+rKZ+PVwRH/cospStOzCn0Itee/z7g6P6Emn2HpJbfR+
         fkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBMdlXBwnvmmPNUewfDMh0H5M/2d+zAT6/3Iwl0rMhQ=;
        b=mBsQom3HLdXRpDtZov0XZ66CERwvPCgSrIxk6YmZjNxltuJSDD/3oY3kbmgxILO1Qw
         XxC0sFB+StKAPlLLgsDB1S4ONEq2PNlArtmOmr2Q2EUiDjujje0d4bJuOmUc/rZqKYW5
         VySVetUrC66Z48kSTOdom9FS8G7Ovbgwm3aPqJVhLhRLmN9BqAOVMM+7nIF+v1xuffOs
         aZGmv+OlVLnNTPh619c+vmSiXDbwe64NSpLuC8XKunZc4An1WhfXgSDu2eBip14rqoLM
         DxkXEgRzVCqd+4hZI98nQmM3EhdCdicYo8HKD9Fh14uaXj9fVS8rY06AOHfcpmgfJzjK
         UW4w==
X-Gm-Message-State: AOAM530QApDDUdsPcEZ8kw1Hlnvaqwqghj/7yRqYf1KeCMCt+eqPYNyP
        DJ29DIgSvMz/gclHH9hfKx3PMfbzrB8Fq8YiHM14mQ==
X-Google-Smtp-Source: ABdhPJxdxO1ha84zyG2XFtqED0Da/EibQF9M6ja/rcn0/bthKWmiRfAlC1qUAPC1GknjblLeVACVRH+7+qe5Q7KXvVE=
X-Received: by 2002:a5d:584e:: with SMTP id i14mr20897127wrf.690.1643167027245;
 Tue, 25 Jan 2022 19:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20220125054217.383482-1-apatel@ventanamicro.com>
 <20220125054217.383482-3-apatel@ventanamicro.com> <87lez37k8h.wl-maz@kernel.org>
In-Reply-To: <87lez37k8h.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 26 Jan 2022 08:46:55 +0530
Message-ID: <CAAhSdy0NrB4Q-mYtMH_HCtbfm5OXi-cxXhiu1AxKdCkTv4cskQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] irqchip/riscv-intc: Set intc domain as the default host
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
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

On Tue, Jan 25, 2022 at 11:47 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 25 Jan 2022 05:42:13 +0000,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > We have quite a few RISC-V drivers (such as RISC-V SBI IPI driver,
> > RISC-V timer driver, RISC-V PMU driver, etc) which do not have a
> > dedicated DT/ACPI fwnode. This patch makes intc domain as the default
> > host so that these drivers can directly create local interrupt mapping
> > using standardized local interrupt numbers
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/clocksource/timer-riscv.c | 17 +----------------
> >  drivers/irqchip/irq-riscv-intc.c  |  9 +++++++++
> >  2 files changed, 10 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> > index 1767f8bf2013..dd6916ae6365 100644
> > --- a/drivers/clocksource/timer-riscv.c
> > +++ b/drivers/clocksource/timer-riscv.c
> > @@ -102,8 +102,6 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
> >  static int __init riscv_timer_init_dt(struct device_node *n)
> >  {
> >       int cpuid, hartid, error;
> > -     struct device_node *child;
> > -     struct irq_domain *domain;
> >
> >       hartid = riscv_of_processor_hartid(n);
> >       if (hartid < 0) {
> > @@ -121,20 +119,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
> >       if (cpuid != smp_processor_id())
> >               return 0;
> >
> > -     domain = NULL;
> > -     child = of_get_compatible_child(n, "riscv,cpu-intc");
> > -     if (!child) {
> > -             pr_err("Failed to find INTC node [%pOF]\n", n);
> > -             return -ENODEV;
> > -     }
> > -     domain = irq_find_host(child);
> > -     of_node_put(child);
> > -     if (!domain) {
> > -             pr_err("Failed to find IRQ domain for node [%pOF]\n", n);
> > -             return -ENODEV;
> > -     }
> > -
> > -     riscv_clock_event_irq = irq_create_mapping(domain, RV_IRQ_TIMER);
> > +     riscv_clock_event_irq = irq_create_mapping(NULL, RV_IRQ_TIMER);
> >       if (!riscv_clock_event_irq) {
> >               pr_err("Failed to map timer interrupt for node [%pOF]\n", n);
> >               return -ENODEV;
> > diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> > index b65bd8878d4f..9f0a7a8a5c4d 100644
> > --- a/drivers/irqchip/irq-riscv-intc.c
> > +++ b/drivers/irqchip/irq-riscv-intc.c
> > @@ -125,6 +125,15 @@ static int __init riscv_intc_init(struct device_node *node,
> >               return rc;
> >       }
> >
> > +     /*
> > +      * Make INTC as the default domain which will allow drivers
> > +      * not having dedicated DT/ACPI fwnode (such as RISC-V SBI IPI
> > +      * driver, RISC-V timer driver, RISC-V PMU driver, etc) can
> > +      * directly create local interrupt mapping using standardized
> > +      * local interrupt numbers.
> > +      */
> > +     irq_set_default_host(intc_domain);
>
> No, please. This really is a bad idea. This sort of catch-all have
> constantly proven to be a nuisance, because they discard all the
> topology information. Eventually, you realise that you need to know
> where this is coming from, but it really is too late.
>
> I'd rather you *synthesise* a fwnode (like ACPI does) rather then do
> this.

In absence of INTC as the default domain, currently we have various
drivers looking up INTC irq_domain from DT (or ACPI). This is quite a
bit of duplicate code across various drivers.

How about having a irq_domain lookup routine (riscv_intc_find_irq_domain())
exported by the RISC-V INTC driver or arch/riscv ?
OR
Do you have an alternative suggestion ?

Regards,
Anup

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
