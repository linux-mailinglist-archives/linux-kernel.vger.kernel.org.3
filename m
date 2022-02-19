Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F084BC544
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 04:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241273AbiBSDjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 22:39:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiBSDjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 22:39:16 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C682450B38
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 19:38:57 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so7708739wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 19:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nedZE9CYo/O4rESVv1Nf5juJloXpQE/HOA07tzdjzh4=;
        b=Ybq8d9MVycFAHyQOoZAXdJHdp57iiyFesmQLye9XQO+8Tuzi92/XZNcHen3n2QEn7l
         dKSl6bBRcP6IjnUSCQtc6n3sUmxOLtb+d+C4jXkuphJuwW51jF1QSG7fIx1t+mCnPK2d
         swg1A+QvUIR8lPQ3MY+HVpejsoLRJOKxy4hz6pQA7N8+io9imHN762onltdMYUyGY4Rq
         TxIboGOG7wUM76Lt2is70XtAD6rtXzMVcS684QF7atMz/ajYdrPohUdnFPrXiU31R/cj
         58MEjctQZYr/HWa5mp9M1pab0LlWRuN14hZ9DDYMh26GVxGs4wS7ItdzyBLGmz0txrVP
         UVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nedZE9CYo/O4rESVv1Nf5juJloXpQE/HOA07tzdjzh4=;
        b=i6Tz5hBzFVyDwtICCMcaouhQAGpSHnUZnR7dLk1U9vmwDYYYaW6yxBED+TNdGfGm0n
         qf6HoqjMKmCTMX0BdtXiLuhuCFocnOcq6iddtaSq6HRyvVZunrMw5aBXRgmE9w1Vp0cc
         iiFWbqn85CY8+d707ocK1Dkn0jBmTFbOUY7HPDkzCkgAcw628BSKwDFeRu/rhiRV6lbX
         rsBb7rFzJnqt24ZRupiNcHkajn2KB28Cr7bekwG2F663Vv8B9tE6mkLc5iLDHnBp3tOt
         8gXGEXc/AO9yF0oAyVkdTS6d6wnzD3vl/urlpwkRg7fpehI+wcfA7iGoh/sRTbpDd9tf
         Gvvg==
X-Gm-Message-State: AOAM533RErH0loYy6NWy0OHscpqeFyFWJV+R7fweK6PFX1KWN3ZLa7Kt
        X5e/jUitEEmodmGNy++660+QEDKaY3Qx7ChYo9pvAg==
X-Google-Smtp-Source: ABdhPJyq7a82/Td7K9xNfLwQ93cynMMOkx1OHfvG+rIJx4EO/sDEkBchlMpwDmwye8MsQJqbyqHXc58HTLPqaidUkk0=
X-Received: by 2002:a7b:cb99:0:b0:34e:b056:91ed with SMTP id
 m25-20020a7bcb99000000b0034eb05691edmr9424307wmi.137.1645241936103; Fri, 18
 Feb 2022 19:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20220128052505.859518-1-apatel@ventanamicro.com>
 <20220128052505.859518-3-apatel@ventanamicro.com> <063b8a5636d6372f37029946b2c3e0f4@kernel.org>
In-Reply-To: <063b8a5636d6372f37029946b2c3e0f4@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 19 Feb 2022 09:08:43 +0530
Message-ID: <CAAhSdy387r314f=YjvXJCxqxkvjm5q-EBOVu420giFzaVr_NYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] irqchip/riscv-intc: Create domain using named fwnode
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

On Thu, Feb 17, 2022 at 8:42 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-01-28 05:25, Anup Patel wrote:
> > We should create INTC domain using a synthetic fwnode which will allow
> > drivers (such as RISC-V SBI IPI driver, RISC-V timer driver, RISC-V
> > PMU driver, etc) not having dedicated DT/ACPI node to directly create
> > interrupt mapping for standard local interrupt numbers defined by the
> > RISC-V privileged specification.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/irq.h      |  2 ++
> >  arch/riscv/kernel/irq.c           | 13 +++++++++++++
> >  drivers/clocksource/timer-clint.c | 13 +++++++------
> >  drivers/clocksource/timer-riscv.c | 11 ++---------
> >  drivers/irqchip/irq-riscv-intc.c  | 12 ++++++++++--
> >  drivers/irqchip/irq-sifive-plic.c | 19 +++++++++++--------
> >  6 files changed, 45 insertions(+), 25 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/irq.h
> > b/arch/riscv/include/asm/irq.h
> > index e4c435509983..f85ebaf07505 100644
> > --- a/arch/riscv/include/asm/irq.h
> > +++ b/arch/riscv/include/asm/irq.h
> > @@ -12,6 +12,8 @@
> >
> >  #include <asm-generic/irq.h>
> >
> > +extern struct fwnode_handle *riscv_intc_fwnode(void);
> > +
> >  extern void __init init_IRQ(void);
> >
> >  #endif /* _ASM_RISCV_IRQ_H */
> > diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> > index 7207fa08d78f..f2fed78ab659 100644
> > --- a/arch/riscv/kernel/irq.c
> > +++ b/arch/riscv/kernel/irq.c
> > @@ -7,9 +7,22 @@
> >
> >  #include <linux/interrupt.h>
> >  #include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/module.h>
> >  #include <linux/seq_file.h>
> >  #include <asm/smp.h>
> >
> > +static struct fwnode_handle *intc_fwnode;
> > +
> > +struct fwnode_handle *riscv_intc_fwnode(void)
> > +{
> > +     if (!intc_fwnode)
> > +             intc_fwnode = irq_domain_alloc_named_fwnode("RISCV-INTC");
> > +
> > +     return intc_fwnode;
> > +}
> > +EXPORT_SYMBOL_GPL(riscv_intc_fwnode);
>
> Why is this created outside of the root interrupt controller driver?
> Furthermore, why do you need to create a new fwnode the first place?
> As far as I can tell, the INTC does have a node, and what you don't
> have is the firmware linkage between PMU (an others) and the INTC.

Fair enough, I will update this patch to not create a synthetic fwnode.

The issue is not with INTC driver. We have other drivers and places
(such as SBI IPI driver, SBI PMU driver, and KVM RISC-V AIA support)
where we don't have a way to locate INTC fwnode.

>
> what you should have instead is something like:
>
> static struct fwnode_handle *(*__get_root_intc_node)(void);
> struct fwnode_handle *riscv_get_root_intc_hwnode(void)
> {
>          if (__get_root_intc_node)
>                  return __get_root_intc_node();
>
>          return NULL;
> }
>
> and the corresponding registration interface.

Thanks, I will follow this suggestion. This is a much better approach
and it will avoid touching existing drivers.

>
> But either way, something breaks: the INTC has one node per CPU, and
> expect one irqdomain per CPU. Having a single fwnode completely breaks
> the INTC driver (and probably the irqdomain list, as we don't check for
> duplicate entries).
>
> > diff --git a/drivers/irqchip/irq-riscv-intc.c
> > b/drivers/irqchip/irq-riscv-intc.c
> > index b65bd8878d4f..26ed62c11768 100644
> > --- a/drivers/irqchip/irq-riscv-intc.c
> > +++ b/drivers/irqchip/irq-riscv-intc.c
> > @@ -112,8 +112,16 @@ static int __init riscv_intc_init(struct
> > device_node *node,
> >       if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
> >               return 0;
> >
> > -     intc_domain = irq_domain_add_linear(node, BITS_PER_LONG,
> > -                                         &riscv_intc_domain_ops, NULL);
> > +     /*
> > +      * Create INTC domain using a synthetic fwnode which will allow
> > +      * drivers (such as RISC-V SBI IPI driver, RISC-V timer driver,
> > +      * RISC-V PMU driver, etc) not having dedicated DT/ACPI node to
> > +      * directly create interrupt mapping for standard local interrupt
> > +      * numbers defined by the RISC-V privileged specification.
> > +      */
> > +     intc_domain = irq_domain_create_linear(riscv_intc_fwnode(),
> > +                                            BITS_PER_LONG,
> > +                                            &riscv_intc_domain_ops, NULL);
>
> This is what I'm talking about. It is simply broken. So either you don't
> need a per-CPU node (and the DT was bad the first place), or you
> absolutely need
> one (and the whole 'well-known/default domain' doesn't work at all).
>
> Either way, this patch is plain wrong.

Okay, I will update this patch with the new approach which you suggested.

Regards,
Anup

>
>
>          M.
> --
> Jazz is not dead. It just smells funny...
