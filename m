Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED3E4C920F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbiCARmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiCARmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:42:04 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E7D5DA49
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:41:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e10so4133056wro.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TbCHuVmqy9ejDKDovkVAQAtLhIftuFnsSdJ7k3DvorU=;
        b=5h8NI3qctbPzhKzu32qgpvHeChc2A+YrdiQ9Pmmdje0KbmFbG+nQbOamxJr8iWCVr+
         1XXJJ/OUrfFiz1sBotGChTbCfgJ8SuBAzQpdwCdwesKQy+gyLrUcgYqjuY1pG31y+SwH
         o3hJuoBjyGeC++x0YgC1LAzo9YwHQF+Cm4eDjw5ueCsESmG18w3n/ga+A1kZHHVE3+Ng
         2dSn1s9g4mT/mckQTiom+pxUuLp1gItJQIfWMgKMM6kQu4K3WBLtWB3EGYttdd3qzMqi
         M2znxJtYVxNY3GZLQtM7oJqPC3uaQXZORx1zPZ96miW6sWBwCEEjzk81qgfDqkdzSedB
         0Vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbCHuVmqy9ejDKDovkVAQAtLhIftuFnsSdJ7k3DvorU=;
        b=UTqMuQFGDu2EVHyWtl0CbJw3Es4u6ghGZSjJ8csmy2fhSzNNQ8crY0jF2w0XZKmqNa
         vpyk7/C/0vOnW8mavM8TgFINSL+/xEqHveMf2r7GrhhBa77JKIordJ+LJSY7AesOmyUC
         cL8F6BjmKokuXmwkzltOknUp0aUAEZYUuMc0egrQ0CvSsDgVDQwECAba4P+urVRwPj+n
         TLOZveN4yrBm/a+PIMe15qi9K8dQ1DaSNdqBL0jInJMM9t0W6n6FwFpNIq5nnSz6JqUz
         d5KXN2+mkleLW5eGSrn9e3tjZFHW3ajX5srnlg2V0geY1wO330pQSXU0G7cF6c6YBvFR
         qYBg==
X-Gm-Message-State: AOAM533+W05woEME5j5R43+zQ0Ci5mInQZJe9TW9/GjOP41cGQMQV9ep
        ny8HP8uYIRizVzrbylkx33/v6Tk4+SdQY1ZvPF+GAQ==
X-Google-Smtp-Source: ABdhPJwRPAeQIInLELTljpHEGaBWucX3OR5lt5SAk5XQhBUEMJKOoVYmPW5GdePhHE4u409zWP7R2ui9b69/hd6V+xk=
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id
 r11-20020a5d6c6b000000b001ea77eadde8mr20626830wrz.690.1646156466938; Tue, 01
 Mar 2022 09:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20220301042722.401113-1-apatel@ventanamicro.com>
 <20220301042722.401113-4-apatel@ventanamicro.com> <87czj53fjq.wl-maz@kernel.org>
In-Reply-To: <87czj53fjq.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 1 Mar 2022 23:10:55 +0530
Message-ID: <CAAhSdy3ACa-447MrLs=5GLjSSWKiKyR585RFWP_ycM3RZ+RTQg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] RISC-V: Treat IPIs as normal Linux IRQs
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 8:07 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 01 Mar 2022 04:27:19 +0000,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > Currently, the RISC-V kernel provides arch specific hooks (i.e.
> > struct riscv_ipi_ops) to register IPI handling methods. The stats
> > gathering of IPIs is also arch specific in the RISC-V kernel.
> >
> > Other architectures (such as ARM, ARM64, and MIPS) have moved away
> > from custom arch specific IPI handling methods. Currently, these
> > architectures have Linux irqchip drivers providing a range of Linux
> > IRQ numbers to be used as IPIs and IPI triggering is done using
> > generic IPI APIs. This approach allows architectures to treat IPIs
> > as normal Linux IRQs and IPI stats gathering is done by the generic
> > Linux IRQ subsystem.
> >
> > We extend the RISC-V IPI handling as-per above approach so that arch
> > specific IPI handling methods (struct riscv_ipi_ops) can be removed
> > and the IPI handling is done through the Linux IRQ subsystem.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/Kconfig                |   1 +
> >  arch/riscv/include/asm/ipi-mux.h  |  43 ++++++
> >  arch/riscv/include/asm/sbi.h      |   2 +
> >  arch/riscv/include/asm/smp.h      |  35 +++--
> >  arch/riscv/kernel/Makefile        |   1 +
> >  arch/riscv/kernel/cpu-hotplug.c   |   3 +-
> >  arch/riscv/kernel/ipi-mux.c       | 222 ++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/irq.c           |   3 +-
> >  arch/riscv/kernel/sbi.c           |  13 +-
> >  arch/riscv/kernel/smp.c           | 153 ++++++++++----------
> >  arch/riscv/kernel/smpboot.c       |   5 +-
> >  drivers/clocksource/timer-clint.c |   8 +-
> >  drivers/irqchip/irq-riscv-intc.c  |  55 ++++----
> >  13 files changed, 405 insertions(+), 139 deletions(-)
>
> This patch is huge and touches way too many things to be reviewed as
> such. Please split arch-specific stuff from clocksource and irqchip,
> going through a transition phase.

Sure, I will split this patch into smaller patches.

>
> More below.
>
> >  create mode 100644 arch/riscv/include/asm/ipi-mux.h
> >  create mode 100644 arch/riscv/kernel/ipi-mux.c
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 5adcbd9b5e88..167681d6d3f8 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -54,6 +54,7 @@ config RISCV
> >       select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
> >       select GENERIC_IDLE_POLL_SETUP
> >       select GENERIC_IOREMAP if MMU
> > +     select GENERIC_IRQ_IPI
> >       select GENERIC_IRQ_MULTI_HANDLER
> >       select GENERIC_IRQ_SHOW
> >       select GENERIC_IRQ_SHOW_LEVEL
> > diff --git a/arch/riscv/include/asm/ipi-mux.h b/arch/riscv/include/asm/ipi-mux.h
> > new file mode 100644
> > index 000000000000..988e2bba372a
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/ipi-mux.h
> > @@ -0,0 +1,43 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#ifndef _ASM_RISCV_IPI_MUX_H
> > +#define _ASM_RISCV_IPI_MUX_H
> > +
> > +struct cpumask;
> > +
> > +#ifdef CONFIG_SMP
> > +
> > +/* Handle muxed IPIs */
> > +void riscv_ipi_mux_handle_irq(void);
> > +
> > +/* Create irq_domain for muxed IPIs */
> > +struct irq_domain *riscv_ipi_mux_create(bool use_soft_irq,
> > +                     void (*clear_ipi)(void),
> > +                     void (*send_ipi)(const struct cpumask *mask));
> > +
> > +/* Destroy irq_domain for muxed IPIs */
> > +void riscv_ipi_mux_destroy(struct irq_domain *d);
> > +
> > +#else
> > +
> > +static inline void riscv_ipi_mux_handle_irq(void)
> > +{
> > +}
> > +
> > +static inline struct irq_domain *riscv_ipi_mux_create(bool use_soft_irq,
> > +                     void (*clear_ipi)(void),
> > +                     void (*send_ipi)(const struct cpumask *mask))
> > +{
> > +     return NULL;
> > +}
> > +
> > +static inline void riscv_ipi_mux_destroy(struct irq_domain *d)
> > +{
> > +}
> > +
> > +#endif
> > +
> > +#endif /* _ASM_RISCV_IPI_MUX_H */
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > index 06133b4f8e20..edd2c3135b4a 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -133,6 +133,7 @@ struct sbiret {
> >  };
> >
> >  void sbi_init(void);
> > +void sbi_ipi_init(void);
> >  struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> >                       unsigned long arg1, unsigned long arg2,
> >                       unsigned long arg3, unsigned long arg4,
> > @@ -202,6 +203,7 @@ static inline unsigned long sbi_mk_version(unsigned long major,
> >  int sbi_err_map_linux_errno(int err);
> >  #else /* CONFIG_RISCV_SBI */
> >  static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1; }
> > +static inline void sbi_ipi_init(void) { }
> >  static inline void sbi_init(void) {}
> >  #endif /* CONFIG_RISCV_SBI */
> >  #endif /* _ASM_RISCV_SBI_H */
> > diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> > index 23170c933d73..178fe4ada592 100644
> > --- a/arch/riscv/include/asm/smp.h
> > +++ b/arch/riscv/include/asm/smp.h
> > @@ -15,11 +15,6 @@
> >  struct seq_file;
> >  extern unsigned long boot_cpu_hartid;
> >
> > -struct riscv_ipi_ops {
> > -     void (*ipi_inject)(const struct cpumask *target);
> > -     void (*ipi_clear)(void);
> > -};
> > -
> >  #ifdef CONFIG_SMP
> >  /*
> >   * Mapping between linux logical cpu index and hartid.
> > @@ -33,9 +28,6 @@ void show_ipi_stats(struct seq_file *p, int prec);
> >  /* SMP initialization hook for setup_arch */
> >  void __init setup_smp(void);
> >
> > -/* Called from C code, this handles an IPI. */
> > -void handle_IPI(struct pt_regs *regs);
> > -
> >  /* Hook for the generic smp_call_function_many() routine. */
> >  void arch_send_call_function_ipi_mask(struct cpumask *mask);
> >
> > @@ -44,11 +36,17 @@ void arch_send_call_function_single_ipi(int cpu);
> >
> >  int riscv_hartid_to_cpuid(int hartid);
> >
> > -/* Set custom IPI operations */
> > -void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
> > +/* Enable IPI for CPU hotplug */
> > +void riscv_ipi_enable(void);
> > +
> > +/* Disable IPI for CPU hotplug */
> > +void riscv_ipi_disable(void);
> >
> > -/* Clear IPI for current CPU */
> > -void riscv_clear_ipi(void);
> > +/* Check if IPI interrupt numbers are available */
> > +bool riscv_ipi_have_virq_range(void);
> > +
> > +/* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
> > +void riscv_ipi_set_virq_range(int virq, int nr_irqs);
> >
> >  /* Secondary hart entry */
> >  asmlinkage void smp_callin(void);
> > @@ -82,11 +80,20 @@ static inline unsigned long cpuid_to_hartid_map(int cpu)
> >       return boot_cpu_hartid;
> >  }
> >
> > -static inline void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
> > +static inline void riscv_ipi_enable(void)
> >  {
> >  }
> >
> > -static inline void riscv_clear_ipi(void)
> > +static inline void riscv_ipi_disable(void)
> > +{
> > +}
> > +
> > +static inline bool riscv_ipi_have_virq_range(void)
> > +{
> > +     return false;
> > +}
> > +
> > +static inline void riscv_ipi_set_virq_range(int virq, int nr)
> >  {
> >  }
> >
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index ffc87e76b1dd..5047723e5527 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -42,6 +42,7 @@ obj-$(CONFIG_RISCV_M_MODE)  += traps_misaligned.o
> >  obj-$(CONFIG_FPU)            += fpu.o
> >  obj-$(CONFIG_SMP)            += smpboot.o
> >  obj-$(CONFIG_SMP)            += smp.o
> > +obj-$(CONFIG_SMP)            += ipi-mux.o
> >  obj-$(CONFIG_SMP)            += cpu_ops.o
> >
> >  obj-$(CONFIG_RISCV_BOOT_SPINWAIT) += cpu_ops_spinwait.o
> > diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
> > index f7a832e3a1d1..39235cf50652 100644
> > --- a/arch/riscv/kernel/cpu-hotplug.c
> > +++ b/arch/riscv/kernel/cpu-hotplug.c
> > @@ -13,7 +13,7 @@
> >  #include <asm/irq.h>
> >  #include <asm/cpu_ops.h>
> >  #include <asm/numa.h>
> > -#include <asm/sbi.h>
> > +#include <asm/smp.h>
> >
> >  bool cpu_has_hotplug(unsigned int cpu)
> >  {
> > @@ -43,6 +43,7 @@ int __cpu_disable(void)
> >       remove_cpu_topology(cpu);
> >       numa_remove_cpu(cpu);
> >       set_cpu_online(cpu, false);
> > +     riscv_ipi_disable();
> >       irq_migrate_all_off_this_cpu();
> >
> >       return ret;
> > diff --git a/arch/riscv/kernel/ipi-mux.c b/arch/riscv/kernel/ipi-mux.c
> > new file mode 100644
> > index 000000000000..3a0405f0e0de
> > --- /dev/null
> > +++ b/arch/riscv/kernel/ipi-mux.c
> > @@ -0,0 +1,222 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Multiplex several IPIs over a single HW IPI.
> > + *
> > + * Copyright (c) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#define pr_fmt(fmt) "riscv-ipi-mux: " fmt
> > +#include <linux/cpu.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/init.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/smp.h>
> > +#include <asm/ipi-mux.h>
> > +
> > +struct ipi_mux {
> > +     struct irq_domain *domain;
> > +     int parent_virq;
> > +     void (*clear_ipi)(void);
> > +     void (*send_ipi)(const struct cpumask *mask);
> > +};
>
> Why do you need this in the arch code? It really looks like something
> that is irqchip specific (single IPI signal on which actual IPIs are
> overlayed). It is also something that other irqchips are already
> implementing, so there is potential for consolidation.

I agree we can share the IPI muxing among irqchip drivers.

I was not sure where to place this IPI muxing so I made it
RISC-V specific initially.

Can we place a simplified IPI muxing (with no RISC-V specific
stuff) under drivers/irqchip or kernel/irq ??

>
> > +
> > +static struct ipi_mux ipi_mux_priv;
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
> > +     if (ipi_mux_priv.send_ipi)
> > +             ipi_mux_priv.send_ipi(mask);
> > +}
> > +
> > +static struct irq_chip ipi_mux_chip = {
> > +     .name           = "RISC-V IPI Mux",
> > +     .irq_mask       = ipi_mux_dummy,
> > +     .irq_unmask     = ipi_mux_dummy,
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
> > +     int i, ret;
> > +     irq_hw_number_t hwirq;
> > +     unsigned int type = IRQ_TYPE_NONE;
> > +     struct irq_fwspec *fwspec = arg;
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
> > +     .alloc          = ipi_mux_domain_alloc,
> > +     .free           = irq_domain_free_irqs_top,
> > +};
> > +
> > +void riscv_ipi_mux_handle_irq(void)
> > +{
> > +     int err;
> > +     unsigned long irqs, *bits = this_cpu_ptr(&ipi_mux_bits);
> > +     irq_hw_number_t hwirq;
> > +
> > +     while (true) {
> > +             if (ipi_mux_priv.clear_ipi)
> > +                     ipi_mux_priv.clear_ipi();
> > +
> > +             /* Order bit clearing and data access. */
> > +             mb();
> > +
> > +             irqs = xchg(bits, 0);
> > +             if (!irqs)
> > +                     break;
> > +
> > +             for_each_set_bit(hwirq, &irqs, BITS_PER_LONG) {
> > +                     err = generic_handle_domain_irq(ipi_mux_priv.domain,
> > +                                                     hwirq);
> > +                     if (unlikely(err))
> > +                             pr_warn_ratelimited(
> > +                                     "can't find mapping for hwirq %lu\n",
> > +                                     hwirq);
> > +             }
> > +     }
> > +}
> > +
> > +static void ipi_mux_handle_irq(struct irq_desc *desc)
> > +{
> > +     struct irq_chip *chip = irq_desc_get_chip(desc);
> > +
> > +     chained_irq_enter(chip, desc);
> > +     riscv_ipi_mux_handle_irq();
> > +     chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int ipi_mux_dying_cpu(unsigned int cpu)
> > +{
> > +     if (ipi_mux_priv.parent_virq)
> > +             disable_percpu_irq(ipi_mux_priv.parent_virq);
> > +     return 0;
> > +}
> > +
> > +static int ipi_mux_starting_cpu(unsigned int cpu)
> > +{
> > +     if (ipi_mux_priv.parent_virq)
> > +             enable_percpu_irq(ipi_mux_priv.parent_virq,
> > +                     irq_get_trigger_type(ipi_mux_priv.parent_virq));
> > +     return 0;
> > +}
> > +
> > +struct irq_domain *riscv_ipi_mux_create(bool use_soft_irq,
> > +                     void (*clear_ipi)(void),
> > +                     void (*send_ipi)(const struct cpumask *mask))
> > +{
>
> There really shouldn't be a need for such a registration interface
> anyway (the current idiom is to allocate IPIs in the root irqchip, and
> pass them to the arch code).
>
> Why can't you model it after the existing architectures?

I ended up with a lot of duplicate code between SBI IPI driver and
SiFive CLINT driver so I factored out the IPI muxing as separate
sources. We also have RISC-V AIA drivers using the same IPI muxing.

If we simplify the IPI muxing and move it out of arch/riscv then
changes in this patch are straight forward to review.

>
> > +     int virq, parent_virq = 0;
> > +     struct irq_domain *domain;
> > +     struct irq_fwspec ipi;
> > +
> > +     if (ipi_mux_priv.domain || riscv_ipi_have_virq_range())
> > +             return NULL;
> > +
> > +     if (use_soft_irq) {
> > +             domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
> > +                                               DOMAIN_BUS_ANY);
> > +             if (!domain) {
> > +                     pr_err("unable to find INTC IRQ domain\n");
> > +                     return NULL;
> > +             }
> > +
> > +             parent_virq = irq_create_mapping(domain, RV_IRQ_SOFT);
> > +             if (!parent_virq) {
> > +                     pr_err("unable to create INTC IRQ mapping\n");
> > +                     return NULL;
> > +             }
> > +     }
> > +
> > +     domain = irq_domain_add_linear(NULL, BITS_PER_LONG,
> > +                                    &ipi_mux_domain_ops, NULL);
> > +     if (!domain) {
> > +             pr_err("unable to add IPI Mux domain\n");
> > +             goto fail_dispose_mapping;
> > +     }
> > +
> > +     ipi.fwnode = domain->fwnode;
> > +     ipi.param_count = 1;
> > +     ipi.param[0] = 0;
> > +     virq = __irq_domain_alloc_irqs(domain, -1, BITS_PER_LONG,
> > +                                    NUMA_NO_NODE, &ipi, false, NULL);
> > +     if (virq <= 0) {
> > +             pr_err("unable to alloc IRQs from IPI Mux domain\n");
> > +             goto fail_domain_remove;
> > +     }
> > +
> > +     ipi_mux_priv.domain = domain;
> > +     ipi_mux_priv.parent_virq = parent_virq;
> > +     ipi_mux_priv.clear_ipi = clear_ipi;
> > +     ipi_mux_priv.send_ipi = send_ipi;
> > +
> > +     if (parent_virq)
> > +             irq_set_chained_handler(parent_virq, ipi_mux_handle_irq);
> > +
> > +     cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +                       "irqchip/riscv/ipi-mux:starting",
> > +                       ipi_mux_starting_cpu, ipi_mux_dying_cpu);
> > +
> > +     riscv_ipi_set_virq_range(virq, BITS_PER_LONG);
> > +
> > +     return ipi_mux_priv.domain;
> > +
> > +fail_domain_remove:
> > +     irq_domain_remove(domain);
> > +fail_dispose_mapping:
> > +     if (parent_virq)
> > +             irq_dispose_mapping(parent_virq);
> > +     return NULL;
> > +}
> > +
> > +void riscv_ipi_mux_destroy(struct irq_domain *d)
> > +{
> > +     if (!d || ipi_mux_priv.domain != d)
> > +             return;
> > +
> > +     irq_domain_remove(ipi_mux_priv.domain);
> > +     if (ipi_mux_priv.parent_virq)
> > +             irq_dispose_mapping(ipi_mux_priv.parent_virq);
> > +     memset(&ipi_mux_priv, 0, sizeof(ipi_mux_priv));
> > +}
>
> Err... Under which circumstances do you destroy such an irqdomain?
> Once all the CPUs have been removed from the machine?

In case, there was a failure after creating an IPI muxing domain then
this function allows us to destroy the IPI muxing domain.

>
> I really think you should aim for a simpler abstraction. The arch code
> should deal with the interrupts themselves, and leave the
> *implementation* of the IPI to the driver code, potentially shared
> across irqchips. This would avoid creating more new interfaces that
> are specific to one architecture or another.

I agree.

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Regards,
Anup
