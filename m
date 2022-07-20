Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D9C57B8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbiGTOvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiGTOvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:51:18 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2C3BD2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:51:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id by8so17783980ljb.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVRQbOhE6XB1EW7hHnsX9K0NKGA6RXSKLaL5jZqCe6c=;
        b=LbEYyiLe5ZqK1UMM3OLzwYJoPn/rHr+mgeH9ZyHITD3tdAefU3ECQu5EqF9Iyn8dmM
         wn5PZzxbvAWsrQzVWfL56X28iiHLLQMxqeh6ApYBhYYqtwI3TR3A2zLFRPlce0t5B7SA
         NhJZ5UgOIiNSFGEFj318aAHJTo4rK95QnyM+St8WoDYo72w6vIX3tm5KYUnK7R4UiIJc
         wthvpx1VYdfB1aAFqJJ31Iwh/sTYoCivCyxl523lJQRRhdhlOZ6MRJfhzFo8JUIrt7bs
         T1/AIlQmPaGycdY8zVKRJ6Z2V4Aq4fbwOad2j9CAMWbB9XTg3hDXMWw58nVgEbGgt7m4
         Qv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVRQbOhE6XB1EW7hHnsX9K0NKGA6RXSKLaL5jZqCe6c=;
        b=bEQ0YyPxbaJCmXKMG3DtZmbgvXYLaOR2gnPEsMpjdBbLlAzf/Who59ntMnUrcRNj4y
         xTOzI8DyBEN7u5OA4EKaEAK/yf9ejiegz0PA8rvkGGSQlyGijN7MDmuSGlHyrTD3giNJ
         fYmTg1HultIzrhOifb7YCrO5oFQUXwp2Aj9ernCILuTc1sVw++XNGeSvEx/FxLk3n4AR
         UKoXfUwsH3Jc8UkXlqhiKzfZrzIwQAksIpToMD4QbeouTj9mI/o1xPVLHTvZv+nPW/z9
         ZMBLRWjj9XXMopPyS7ZApimQI3l+jdSERhkgtQXTuJipTuFDFICQoD2YrWTpsBBNhyD3
         cOKw==
X-Gm-Message-State: AJIora+vfan5uZdXPnOX5pDNeJVYC1ddzdC+bK4wvvid76pTtpYKU0sH
        9rMra9sXG8XUiaB8YcOG+YVzydTy0ZsTjguVa5ay561I3HwzmQ==
X-Google-Smtp-Source: AGRyM1vs0Jfc47H+moDSMVJNt400EsA6vj7j7OirOjA9rlu8ilu6vA+M2DUhNMX6xR7pFEtKZ+uqzOdtuaBXz3IgUp8=
X-Received: by 2002:a05:651c:1616:b0:25d:6f3f:44a7 with SMTP id
 f22-20020a05651c161600b0025d6f3f44a7mr16569237ljq.466.1658328674730; Wed, 20
 Jul 2022 07:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220418105305.1196665-1-apatel@ventanamicro.com>
 <20220418105305.1196665-4-apatel@ventanamicro.com> <87bktlyszw.wl-maz@kernel.org>
In-Reply-To: <87bktlyszw.wl-maz@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 20 Jul 2022 20:20:09 +0530
Message-ID: <CAK9=C2VyPJ8d0w26fLDp+manq8G1BS+Tuqc3OCX538_5yC6QOg@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] genirq: Add mechanism to multiplex a single HW IPI
To:     Marc Zyngier <maz@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 9:50 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 18 Apr 2022 11:53:01 +0100,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > All RISC-V platforms have a single HW IPI provided by the INTC local
> > interrupt controller. The HW method to trigger INTC IPI can be through
> > external irqchip (e.g. RISC-V AIA), through platform specific device
> > (e.g. SiFive CLINT timer), or through firmware (e.g. SBI IPI call).
> >
> > To support multiple IPIs on RISC-V, we add a generic IPI multiplexing
> > mechanism which help us create multiple virtual IPIs using a single
> > HW IPI. This generic IPI multiplexing is shared among various RISC-V
> > irqchip drivers.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  include/linux/irq.h  |  11 +++
> >  kernel/irq/Kconfig   |   4 +
> >  kernel/irq/Makefile  |   1 +
> >  kernel/irq/ipi-mux.c | 197 +++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 213 insertions(+)
> >  create mode 100644 kernel/irq/ipi-mux.c
> >
> > diff --git a/include/linux/irq.h b/include/linux/irq.h
> > index f92788ccdba2..5bb4e2db63d7 100644
> > --- a/include/linux/irq.h
> > +++ b/include/linux/irq.h
> > @@ -1247,6 +1247,17 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
> >  int ipi_send_single(unsigned int virq, unsigned int cpu);
> >  int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
> >
> > +#define IPI_MUX_NR_IRQS              BITS_PER_LONG
> > +
> > +struct ipi_mux_ops {
> > +     void (*ipi_mux_clear)(unsigned int parent_virq);
> > +     void (*ipi_mux_send)(unsigned int parent_virq,
> > +                          const struct cpumask *mask);
>
> You really cannot just dump this like this. This requires
> documentation so that architecture maintainers can move over to this.
> I appreciate that this area is pretty poorly documented, but we need
> to start somewhere.

Okay, I will add documentation.

>
> > +};
> > +
> > +void ipi_mux_process(void);
> > +int ipi_mux_create(unsigned int parent_virq, const struct ipi_mux_ops *ops);
> > +
> >  #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
> >  /*
> >   * Registers a generic IRQ handling function as the top-level IRQ handler in
> > diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> > index 10929eda9825..2388e7d40ed3 100644
> > --- a/kernel/irq/Kconfig
> > +++ b/kernel/irq/Kconfig
> > @@ -84,6 +84,10 @@ config GENERIC_IRQ_IPI
> >       bool
> >       select IRQ_DOMAIN_HIERARCHY
> >
> > +# Generic IRQ IPI Mux support
> > +config GENERIC_IRQ_IPI_MUX
> > +     bool
> > +
> >  # Generic MSI interrupt support
> >  config GENERIC_MSI_IRQ
> >       bool
> > diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
> > index b4f53717d143..f19d3080bf11 100644
> > --- a/kernel/irq/Makefile
> > +++ b/kernel/irq/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
> >  obj-$(CONFIG_PM_SLEEP) += pm.o
> >  obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
> >  obj-$(CONFIG_GENERIC_IRQ_IPI) += ipi.o
> > +obj-$(CONFIG_GENERIC_IRQ_IPI_MUX) += ipi-mux.o
> >  obj-$(CONFIG_SMP) += affinity.o
> >  obj-$(CONFIG_GENERIC_IRQ_DEBUGFS) += debugfs.o
> >  obj-$(CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR) += matrix.o
> > diff --git a/kernel/irq/ipi-mux.c b/kernel/irq/ipi-mux.c
> > new file mode 100644
> > index 000000000000..1a1fcfe3ac54
> > --- /dev/null
> > +++ b/kernel/irq/ipi-mux.c
> > @@ -0,0 +1,197 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Multiplex several virtual IPIs over a single HW IPI.
> > + *
> > + * Copyright (c) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#define pr_fmt(fmt) "ipi-mux: " fmt
> > +#include <linux/cpu.h>
> > +#include <linux/init.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/smp.h>
> > +
> > +static unsigned int ipi_mux_parent_virq;
> > +static struct irq_domain *ipi_mux_domain;
> > +static const struct  ipi_mux_ops *ipi_mux_ops;
> > +static DEFINE_PER_CPU(unsigned long, ipi_mux_bits);
> > +
> > +static void ipi_mux_dummy(struct irq_data *d)
> > +{
> > +}
> > +
> > +static void ipi_mux_send_mask(struct irq_data *d, const struct cpumask *mask)
> > +{
> > +     int cpu;
> > +
> > +     /* Barrier before doing atomic bit update to IPI bits */
> > +     smp_mb__before_atomic();
> > +
> > +     for_each_cpu(cpu, mask)
> > +             set_bit(d->hwirq, per_cpu_ptr(&ipi_mux_bits, cpu));
> > +
> > +     /* Barrier after doing atomic bit update to IPI bits */
> > +     smp_mb__after_atomic();
> > +
> > +     /* Trigger the parent IPI */
> > +     ipi_mux_ops->ipi_mux_send(ipi_mux_parent_virq, mask);
> > +}
> > +
> > +static struct irq_chip ipi_mux_chip = {
>
> const, please.

Okay, I will add const here.

>
> > +     .name           = "IPI Mux",
> > +     .irq_mask       = ipi_mux_dummy,
> > +     .irq_unmask     = ipi_mux_dummy,
>
> Maybe we should consider a flow that does not require this dummy
> callbacks.

These dummy irq_mask()/irq_unmask() were added to allow
irq_percpu_enable()/disable() for the muxed IPIs.

We are using handle_percpu_devid_irq() flow so we really
don't need these dummy irq_mask()/irq_unmask(). I will drop
these dummy calls in the next patch revision.

>
> > +     .ipi_send_mask  = ipi_mux_send_mask,
> > +};
> > +
> > +static int ipi_mux_domain_map(struct irq_domain *d, unsigned int irq,
> > +                           irq_hw_number_t hwirq)
> > +{
> > +     irq_set_percpu_devid(irq);
> > +     irq_domain_set_info(d, irq, hwirq, &ipi_mux_chip, d->host_data,
> > +                         handle_percpu_devid_irq, NULL, NULL);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ipi_mux_domain_alloc(struct irq_domain *d, unsigned int virq,
> > +                             unsigned int nr_irqs, void *arg)
> > +{
> > +     unsigned int type = IRQ_TYPE_NONE;
>
> Really, this should be EDGE.

Actually, the "type" initialization is redundant because the
irq_domain_translate_onecell() function will set it anyway.

I will drop the "type" initialization here.

>
> > +     struct irq_fwspec *fwspec = arg;
> > +     irq_hw_number_t hwirq;
> > +     int i, ret;
> > +
> > +     ret = irq_domain_translate_onecell(d, fwspec, &hwirq, &type);
> > +     if (ret)
> > +             return ret;
> > +
> > +     for (i = 0; i < nr_irqs; i++) {
> > +             ret = ipi_mux_domain_map(d, virq + i, hwirq + i);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct irq_domain_ops ipi_mux_domain_ops = {
> > +     .translate      = irq_domain_translate_onecell,
>
> What is the purpose of this callback? Firmware shouldn't be involved
> in IPIs at all, and since you only have one cell, you can use the
> default path. This is also a dependency on CONFIG_IRQ_DOMAIN_HIERARCHY.

It's not needed. I will drop it.

>
> > +     .alloc          = ipi_mux_domain_alloc,
> > +     .free           = irq_domain_free_irqs_top,
> > +};
> > +
> > +/**
> > + * ipi_mux_process - Process multiplexed virtual IPIs
> > + */
> > +void ipi_mux_process(void)
> > +{
> > +     unsigned long irqs, *bits = this_cpu_ptr(&ipi_mux_bits);
> > +     irq_hw_number_t hwirq;
> > +     int err;
> > +
> > +     /* Clear the parent IPI */
> > +     if (ipi_mux_ops->ipi_mux_clear)
> > +             ipi_mux_ops->ipi_mux_clear(ipi_mux_parent_virq);
> > +
> > +     /*
> > +      * Barrier for IPI bits paired with smp_mb__xyz_atomic()
>
> xyz???

Okay, I will update this comment.

>
> > +      * in ipi_mux_send_mask()
> > +      */
> > +     smp_mb();
> > +
> > +     irqs = xchg(bits, 0);
> > +     if (!irqs)
> > +             return;
> > +
> > +     for_each_set_bit(hwirq, &irqs, IPI_MUX_NR_IRQS) {
> > +             err = generic_handle_domain_irq(ipi_mux_domain,
> > +                                             hwirq);
> > +             if (unlikely(err))
> > +                     pr_warn_ratelimited(
> > +                             "can't find mapping for hwirq %lu\n",
> > +                             hwirq);
> > +     }
> > +}
> > +
> > +static void ipi_mux_handler(struct irq_desc *desc)
> > +{
> > +     struct irq_chip *chip = irq_desc_get_chip(desc);
> > +
> > +     chained_irq_enter(chip, desc);
> > +     ipi_mux_process();
> > +     chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int ipi_mux_dying_cpu(unsigned int cpu)
> > +{
> > +     disable_percpu_irq(ipi_mux_parent_virq);
> > +     return 0;
> > +}
> > +
> > +static int ipi_mux_starting_cpu(unsigned int cpu)
> > +{
> > +     enable_percpu_irq(ipi_mux_parent_virq,
> > +                       irq_get_trigger_type(ipi_mux_parent_virq));
> > +     return 0;
> > +}
> > +
> > +/**
> > + * ipi_mux_create - Create virtual IPIs (total IPI_MUX_NR_IRQS) multiplexed
> > + * on top of a single parent IPI.
> > + * @parent_virq:     virq of the parent IPI
> > + * @ops:             multiplexing operations for the parent IPI
> > + *
> > + * If the parent IPI > 0 then ipi_mux_process() will be automatically
> > + * called via chained handler.
> > + *
> > + * If the parent IPI <= 0 then it is responsiblity of irqchip drivers
> > + * to explicitly call ipi_mux_process() for processing muxed IPIs.
> > + *
> > + * Returns first virq of the newly created virutal IPIs upon success
> > + * or <=0 upon failure
> > + */
> > +int ipi_mux_create(unsigned int parent_virq, const struct ipi_mux_ops *ops)
> > +{
>
> Why should be parent_virq be unique? I also see nothing that checks
> that this is a per-CPU interrupt. If anything, this needs documenting.

Okay, I will add checks on parent_virq to ensure it is a percpu irq.

>
> > +     struct irq_domain *domain;
> > +     struct irq_fwspec ipi;
> > +     int virq;
> > +
> > +     if (ipi_mux_domain || !ops || !ops->ipi_mux_send)
> > +             return 0;
> > +
> > +     domain = irq_domain_add_linear(NULL, IPI_MUX_NR_IRQS,
>
> Urgh. For a start, please use the irq_domain_create_* version, as this
> shouldn't be DT specific. Then, don't use a NULL fwnode, as this
> results in a "default domain", which nobody sane should ever use
> anymore. Also, defaulting to BITS_PER_LONG is a lot of interrupts for
> not much (most archs use only a handful). You may want to consider
> this being a parameter, and cap it at BITS_PER_LONG.

Okay, I will use irq_domain_create_simple() here and also add a
parameter to ipi_mux_create() for the number of IPIs which will be
capped at BITS_PER_LONG.

>
> > +                                    &ipi_mux_domain_ops, NULL);
> > +     if (!domain) {
> > +             pr_err("unable to add IPI Mux domain\n");
> > +             return 0;
> > +     }
> > +
> > +     ipi.fwnode = domain->fwnode;
>
> Which is NULL (see above).
>
> > +     ipi.param_count = 1;
> > +     ipi.param[0] = 0;
> > +     virq = __irq_domain_alloc_irqs(domain, -1, IPI_MUX_NR_IRQS,
> > +                                    NUMA_NO_NODE, &ipi, false, NULL);
> > +     if (virq <= 0) {
> > +             pr_err("unable to alloc IRQs from IPI Mux domain\n");
> > +             irq_domain_remove(domain);
> > +             return virq;
> > +     }
> > +
> > +     ipi_mux_domain = domain;
> > +     ipi_mux_parent_virq = parent_virq;
> > +     ipi_mux_ops = ops;
> > +
> > +     if (parent_virq > 0) {
> > +             irq_set_chained_handler(parent_virq, ipi_mux_handler);
> > +
> > +             cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +                               "irqchip/ipi-mux:starting",
> > +                               ipi_mux_starting_cpu, ipi_mux_dying_cpu);
> > +     }
> > +
> > +     return virq;
> > +}
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Thanks Marc, I will send v7 patches soon.

Regards,
Anup
