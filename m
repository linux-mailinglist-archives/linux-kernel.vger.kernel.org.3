Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906B44BDE00
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354834AbiBUKfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:35:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355095AbiBUKfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:35:19 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE85381BB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:55:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso13082185wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upbkN/V8cp2KI0ahaTu8tBZWU9b/chtGV7DC+f35CdY=;
        b=GS//m974QckaF3Of/zXAd7JQULr/ML9YdasdWH0NaXtNDJnOHKV2SXZYVG4M19tHOq
         hJmUX36bWgLhI8JvKY2PlIHM4uLDxh8yTN6amnE1lKQGvuGhlHdEyRpqjE6hsa+v3W2u
         TZakdaGd2vNZObRxQactg7oTZL+8n5Q4bbi+EzGBsBCgUBzboNsdJEP9OEojl0qsSsMB
         xcR2OnKNudh8FouXOjafeb61zW/AvHgnN6Wgs8dVb/SNBVNfj8/2daP4VqCCSQg9BzIe
         nJtVYrKxlZZY2oieZrGD2QQL8iIslsrMKHSRiBbzcveg4r/tTZK1IDrSZgu+8Hv2hmJV
         cfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upbkN/V8cp2KI0ahaTu8tBZWU9b/chtGV7DC+f35CdY=;
        b=tM4jouorKBPU+NYO7luk9y58VkSV1/GI6zy2ravOVV8wHLRYVMxBR9GKH74JYBdqZh
         b03lmIJdZDjt8YCHiZzHUAB1RqySr9qYKRXUv/xs2a8YgKo/iKwn47RPGiCvIha7/nk/
         SYLzbKIAU8ZCKLNtq6yFhOSbL5kf3W/n1zQFGDMyXqOs2cGzaW55/Jkqg6ZPcIoUFht2
         S2gzDnVCLiy7gGQIwky7UcOmnqADLcezIdNnJTmD+AUHlYK8igz8YvNr+wzivpJFh7IM
         zM/y6HWzrTAkz82PvyPb0SaDMSrZODDdFKzriy4bOfkNotaqLjW17tTooIaFhvbF28I1
         BXgg==
X-Gm-Message-State: AOAM530zHvYQzne35DozolvgkeLSmtozmZyyN+8iuDlK4UYCFsio+FPh
        Z+yFAdJCwLftefzLnHthVBCk0GlKhBk5P7XghwwYVg==
X-Google-Smtp-Source: ABdhPJyhZ16CI2TVFHhpSM7/eyLn3311gs2ig6GHEaHjYfa4Ne4UfzHF2h4fbFKVn1hsN8j+ljYfCQ9qjGGmxjJpf14=
X-Received: by 2002:a7b:cf16:0:b0:37b:c4c9:96c6 with SMTP id
 l22-20020a7bcf16000000b0037bc4c996c6mr17352485wmg.59.1645437316963; Mon, 21
 Feb 2022 01:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20220220050854.743420-1-apatel@ventanamicro.com>
 <20220220050854.743420-3-apatel@ventanamicro.com> <87czjg4kf4.wl-maz@kernel.org>
In-Reply-To: <87czjg4kf4.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 21 Feb 2022 15:25:05 +0530
Message-ID: <CAAhSdy2abxjz2GAF7dTbxDa32244wEJeYBCeuY2Ag84HK_FXow@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] irqchip/riscv-intc: Allow drivers to directly
 discover INTC hwnode
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

On Mon, Feb 21, 2022 at 3:21 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 20 Feb 2022 05:08:50 +0000,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > Various RISC-V drivers (such as SBI IPI, SBI Timer, SBI PMU, and
> > KVM RISC-V) don't have associated DT node but these drivers need
> > standard per-CPU (local) interrupts defined by the RISC-V privileged
> > specification.
> >
> > We add riscv_get_intc_hwnode() in arch/riscv which allows RISC-V
> > drivers not having DT node to discover INTC hwnode which in-turn
> > helps these drivers to map per-CPU (local) interrupts provided
> > by the INTC driver.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/irq.h     |  4 ++++
> >  arch/riscv/kernel/irq.c          | 19 +++++++++++++++++++
> >  drivers/irqchip/irq-riscv-intc.c |  7 +++++++
> >  3 files changed, 30 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
> > index e4c435509983..43b9ebfbd943 100644
> > --- a/arch/riscv/include/asm/irq.h
> > +++ b/arch/riscv/include/asm/irq.h
> > @@ -12,6 +12,10 @@
> >
> >  #include <asm-generic/irq.h>
> >
> > +void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
> > +
> > +struct fwnode_handle *riscv_get_intc_hwnode(void);
> > +
> >  extern void __init init_IRQ(void);
> >
> >  #endif /* _ASM_RISCV_IRQ_H */
> > diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> > index 7207fa08d78f..ead92432df8c 100644
> > --- a/arch/riscv/kernel/irq.c
> > +++ b/arch/riscv/kernel/irq.c
> > @@ -7,9 +7,28 @@
> >
> >  #include <linux/interrupt.h>
> >  #include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/module.h>
> >  #include <linux/seq_file.h>
> >  #include <asm/smp.h>
> >
> > +static struct fwnode_handle *(*__get_intc_node)(void);
> > +
> > +void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void))
> > +{
> > +     __get_intc_node = fn;
> > +}
> > +EXPORT_SYMBOL_GPL(riscv_set_intc_hwnode_fn);
>
> We're talking about the root interrupt controller here. How can this
> ever be implemented as a module?

Okay, I will drop the EXPORT() from here.

>
> > +
> > +struct fwnode_handle *riscv_get_intc_hwnode(void)
> > +{
> > +     if (__get_intc_node)
> > +             return __get_intc_node();
> > +
> > +     return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(riscv_get_intc_hwnode);
> > +
> >  int arch_show_interrupts(struct seq_file *p, int prec)
> >  {
> >       show_ipi_stats(p, prec);
> > diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> > index b65bd8878d4f..fa24ecd01d39 100644
> > --- a/drivers/irqchip/irq-riscv-intc.c
> > +++ b/drivers/irqchip/irq-riscv-intc.c
> > @@ -92,6 +92,11 @@ static const struct irq_domain_ops riscv_intc_domain_ops = {
> >       .xlate  = irq_domain_xlate_onecell,
> >  };
> >
> > +static struct fwnode_handle *riscv_intc_hwnode(void)
> > +{
> > +     return (intc_domain) ? intc_domain->fwnode : NULL;
> > +}
>
> This makes no sense. Either you have found the interrupt controller
> and allocated the domain, or you haven't. But you don't register a
> callback without having found it.

We are registering this callback after creating the INTC domain.

>
> And you have totally ignored my previous comments about the multitude
> of irq domains for the INTC. Either you get rid of all but one and you
> can register a single fwnode, or you stay with what you have today,

Only the INTC DT nodes are per-CPU but we are creating only one
INTC domain to manage per-CPU IRQs across all CPUs.

Regards,
Anup

>
> You can't have it both ways.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
