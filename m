Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6EB4BDE7A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355296AbiBUKjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:39:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355149AbiBUKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:39:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988894754C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:00:58 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m27so14262789wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7npSal4SAMLSZn16NnNEeHrBcHYcH9kBYIO1Ec8tAsc=;
        b=DRpO3yTE0tJVGaIevyQWmDT4RQw4sj581lnPgma9i9lP1rhY61Bq1uu/GvtgnD3uV7
         gIrwWki58uWVDY2GZ+5DlmBI7oqhldUaH+45qGF1HZZ1oLWNsLSFeoh3YsYnNHySFt9Y
         fBoBdQF5sMvBRH0jZoE5mCS5Fwd1kISVZAFaYFNAtXZXvVdzne2RoiNXh1my7ulWKySy
         wzLdcSVXjb0jU4+vCsciegp3jmfXInwK/FY5HHbt7mYZcoZeg2vqRTffm5XjM9RLpsUv
         vyBrQq9XwoOsptZ7IZrTTrW0SIflvV21Y+LFjiSBJEGkakiWaLNWjaqEQ8+Q0xUqiNZ5
         ryZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7npSal4SAMLSZn16NnNEeHrBcHYcH9kBYIO1Ec8tAsc=;
        b=ABxIXsNSSRyvYWkiN9Ml9cFwMoSfNY4a++qMHucVhgy3WReCVEUylMJHXsbmzSfWKG
         7tOMbtfV09i4AjiK8sQ9ODo8FLLxtYWXJLQlnBLE9k5jepd8jPxhwDv6S3mHredqNRi2
         3MfjuY2WR50AcPo6HiPkP67ozQcJetAcWNM2N0iuVS8qha+HYFP8Y29qtYf959F+XIA5
         UZSbeYwrUbc8PlyVReqkZktxQAVOE1QzuL8uoQSkGfZcpiauWI1BbyxF/9YEVsyGtAr9
         IIOnMBjttmIs8wWcwDUWHKh7FmISTDbYBiLxoB1MTmpyRGHxf619+6rOhqHv1W8Plikw
         xmuQ==
X-Gm-Message-State: AOAM533SVFN4ZSFDNLYOqHhdrA+Fk8jcazHpptR/ysDC+RFLeRpbu8pJ
        9fj6uXmExZfEyPduYGX7HnAc6+p6oMridAI3Uk0bYw==
X-Google-Smtp-Source: ABdhPJyirlkP3M5wFmhNEqfDBiCxvzzJb4WX23P3G7dkN1Z8LtUASSB2cPoUO5TP0OREOq8+oImfrKDuUqpRPFnu/s4=
X-Received: by 2002:a5d:6507:0:b0:1e5:eb6d:a851 with SMTP id
 x7-20020a5d6507000000b001e5eb6da851mr15148810wru.313.1645437656564; Mon, 21
 Feb 2022 02:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20220220050854.743420-1-apatel@ventanamicro.com>
 <20220220050854.743420-3-apatel@ventanamicro.com> <87czjg4kf4.wl-maz@kernel.org>
In-Reply-To: <87czjg4kf4.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 21 Feb 2022 15:30:44 +0530
Message-ID: <CAAhSdy1nKMySggjH83JBEDxiFnfFY46DdYyGH=ib1b0D6Qn7jg@mail.gmail.com>
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

Okay, I will drop the check on intc_domain since we are registering
callback after creating a single INTC domain common for all CPUs.

>
> And you have totally ignored my previous comments about the multitude
> of irq domains for the INTC. Either you get rid of all but one and you
> can register a single fwnode, or you stay with what you have today,
>
> You can't have it both ways.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Regards,
Anup
