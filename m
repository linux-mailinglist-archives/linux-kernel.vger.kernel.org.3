Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2667D57C9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiGULof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiGULoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:44:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FD281B0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:44:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso3127835wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrCeN+nzRGg2rvQxRdS5jlsIxIfurmlBViQkcpLilHk=;
        b=lIlW1HmPQvNAOAgb1o5z8ypceqFfrRuVqRJvXlV2TBs9IX3NdWig6yO07BcUoj2hrM
         Qas1IlhXCBk5cY2MqS1D0ml0RGPRVI4JPA+u9MsCtOAa3E7yiR9tmigvGU2JCve6DERd
         yuthuU5+lYPki2SSjBZklY8kPw3K6mJUtZ/ia3pEEnuF49dHav9vsquKjE81N4g8R6rD
         FkGHT9MOgKqKpzmJuZMrbsIOD7rb2b1j3c1fkX8L16DyA4I5kCaG2bbDzj9TcKqosUpv
         2XggM68QwK4e+uj/d3UrMr9DzmvaiX0YdRwC/XIsTB9RASHaBo2KZsp2lmOjau/Xb2Qz
         QxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrCeN+nzRGg2rvQxRdS5jlsIxIfurmlBViQkcpLilHk=;
        b=mex3uJqd4olXvRQjOI/XsNlZZSs/u4dQlvzP+A6Qfa741gE4Fcuyw7rSLGMhzBnD4N
         UNHhHLODfHdcrf0D6vIxP23ND8DIiYYX0Hljp+oUckzDVsXHH2UYA0vWbA4yCR/zGEao
         bj9dM6O28RJ0LLNUociHkiV1b8TuNRpZ6I/cJe63z1Uxq6ng/wf8JMxOFm3JgX61qlxR
         umdizcccVJZ2Kd4fqGrnGCH93dVhTZ2CNcQy1ZTjwby/Ml6qgjhzM33U5/E/QMENzlQl
         EPGcV2KS5UlDmGwhnUfh0rVq4pCpOgrsh3ortxR+VlLU02nal3FLLm/X2nBdjEWKtsJR
         7rFA==
X-Gm-Message-State: AJIora+xSxfQYEbUz3aI3K+blkdW3+VbUo964gjB59vFRERc+vX4DQpg
        tYKKLifftepfwE5PCHl6F08i4JhrsM7BCAH/+oR6SQ==
X-Google-Smtp-Source: AGRyM1vl0hST0xMLzrJ49XHyA3ScQ8zXKZHED18CyYa6DW87skalJMnbbaq1G23Q3uR8zkdkYFncQ3laPrOdJOsUqDQ=
X-Received: by 2002:a1c:f314:0:b0:3a2:fee4:91d4 with SMTP id
 q20-20020a1cf314000000b003a2fee491d4mr7601376wmq.108.1658403869682; Thu, 21
 Jul 2022 04:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220720152348.2889109-1-apatel@ventanamicro.com>
 <20220720152348.2889109-4-apatel@ventanamicro.com> <8735euzq60.wl-maz@kernel.org>
In-Reply-To: <8735euzq60.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 21 Jul 2022 17:14:16 +0530
Message-ID: <CAAhSdy0MsPViOc83rGmDe8FPmUH-cgqf2oz2VoaESRTfd7Ez-g@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] genirq: Add mechanism to multiplex a single HW IPI
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 4:30 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 20 Jul 2022 16:23:44 +0100,
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
> >  include/linux/irq.h  |  16 ++++
> >  kernel/irq/Kconfig   |   4 +
> >  kernel/irq/Makefile  |   1 +
> >  kernel/irq/ipi-mux.c | 199 +++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 220 insertions(+)
> >  create mode 100644 kernel/irq/ipi-mux.c
> >
> > diff --git a/include/linux/irq.h b/include/linux/irq.h
> > index 505308253d23..a97bf13a8965 100644
> > --- a/include/linux/irq.h
> > +++ b/include/linux/irq.h
> > @@ -1249,6 +1249,22 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
> >  int ipi_send_single(unsigned int virq, unsigned int cpu);
> >  int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
> >
> > +/**
> > + * struct ipi_mux_ops - IPI multiplex operations
> > + *
> > + * @ipi_mux_clear:   Optional function to clear parent IPI
> > + * @ipi_mux_send:    Trigger parent IPI on target CPUs
> > + */
> > +struct ipi_mux_ops {
> > +     void (*ipi_mux_clear)(unsigned int parent_virq);
> > +     void (*ipi_mux_send)(unsigned int parent_virq,
> > +                          const struct cpumask *mask);
> > +};
> > +
> > +void ipi_mux_process(void);
> > +int ipi_mux_create(unsigned int parent_virq, unsigned int nr_ipi,
> > +                const struct ipi_mux_ops *ops);
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
> > index 000000000000..bd6b31ca588b
> > --- /dev/null
> > +++ b/kernel/irq/ipi-mux.c
> > @@ -0,0 +1,199 @@
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
> > +static unsigned int ipi_mux_nr;
> > +static unsigned int ipi_mux_parent_virq;
> > +static struct irq_domain *ipi_mux_domain;
> > +static const struct  ipi_mux_ops *ipi_mux_ops;
> > +static DEFINE_PER_CPU(unsigned long, ipi_mux_bits);
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
> > +static const struct irq_chip ipi_mux_chip = {
> > +     .name           = "IPI Mux",
> > +     .ipi_send_mask  = ipi_mux_send_mask,
>
> I've given this a bit more though, and I came to the conclusion that
> we really should have the full masking semantics here, even if Linux
> currently doesn't really use it.
>
> It makes the handling a bit more complex, and unmasking a pending IPI
> must be handled gracefully, but we already have implemented most of
> that code in the irq-apple-aic driver.
>
> And if we go down this road, such a driver should be very easy to move
> over this infrastructure, making the change a lot more palatable.

Sounds good.

I will send v8 of ipi-mux which can be easily adapted for irq-apple-aic driver
and it will have masking semantics as well.

Thanks,
Anup

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
