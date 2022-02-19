Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920DB4BC724
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 10:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbiBSJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 04:32:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241196AbiBSJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 04:32:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72AD44771
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 01:32:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F483B8013C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 09:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3359BC004E1;
        Sat, 19 Feb 2022 09:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645263149;
        bh=TFIg2O8K58C6QPwpMECrwYxaBkoGsAJ5vDjkcuHPduY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mmlsJ905oEd+SxRdBDfmSAVkT/7Vig0fjh1BJLgZUpqpv+2O/b6BMBNhtAR/7TFFC
         AewSDmrOPNYRpnIuFoHOHVUfS04wdiQYZ4Mt3zA+6TzCYGfFx5l7VO6AUrPUSdTeMz
         ld5ygaHIlRKqutVsWcsDZfxZjDpA5O9R6yQxNSkNtHeYhZEft3UcOGpxZSm+x75iv3
         r0nuDL19gSmJN0dI+MmGRhFV7Mqbp23qnmUcVTrR4SwS3axV06Dish6tENQaSxAxa0
         1XsE6HyHWO4OJT5nUeQwu6ocsmzjoqWT0/A8YTvJOxPoMwSFkhKGLgm5nP1hHqsk0C
         WcRJFuvXPs3jg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nLM6M-008xBa-MD; Sat, 19 Feb 2022 09:32:26 +0000
MIME-Version: 1.0
Date:   Sat, 19 Feb 2022 09:32:26 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] irqchip/riscv-intc: Create domain using named
 fwnode
In-Reply-To: <CAAhSdy387r314f=YjvXJCxqxkvjm5q-EBOVu420giFzaVr_NYw@mail.gmail.com>
References: <20220128052505.859518-1-apatel@ventanamicro.com>
 <20220128052505.859518-3-apatel@ventanamicro.com>
 <063b8a5636d6372f37029946b2c3e0f4@kernel.org>
 <CAAhSdy387r314f=YjvXJCxqxkvjm5q-EBOVu420giFzaVr_NYw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <31fea18e51a5021b79adb17973f9528e@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anup@brainfault.org, apatel@ventanamicro.com, palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de, daniel.lezcano@linaro.org, atishp@atishpatra.org, Alistair.Francis@wdc.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-19 03:38, Anup Patel wrote:
> On Thu, Feb 17, 2022 at 8:42 PM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On 2022-01-28 05:25, Anup Patel wrote:
>> > We should create INTC domain using a synthetic fwnode which will allow
>> > drivers (such as RISC-V SBI IPI driver, RISC-V timer driver, RISC-V
>> > PMU driver, etc) not having dedicated DT/ACPI node to directly create
>> > interrupt mapping for standard local interrupt numbers defined by the
>> > RISC-V privileged specification.
>> >
>> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>> > ---
>> >  arch/riscv/include/asm/irq.h      |  2 ++
>> >  arch/riscv/kernel/irq.c           | 13 +++++++++++++
>> >  drivers/clocksource/timer-clint.c | 13 +++++++------
>> >  drivers/clocksource/timer-riscv.c | 11 ++---------
>> >  drivers/irqchip/irq-riscv-intc.c  | 12 ++++++++++--
>> >  drivers/irqchip/irq-sifive-plic.c | 19 +++++++++++--------
>> >  6 files changed, 45 insertions(+), 25 deletions(-)
>> >
>> > diff --git a/arch/riscv/include/asm/irq.h
>> > b/arch/riscv/include/asm/irq.h
>> > index e4c435509983..f85ebaf07505 100644
>> > --- a/arch/riscv/include/asm/irq.h
>> > +++ b/arch/riscv/include/asm/irq.h
>> > @@ -12,6 +12,8 @@
>> >
>> >  #include <asm-generic/irq.h>
>> >
>> > +extern struct fwnode_handle *riscv_intc_fwnode(void);
>> > +
>> >  extern void __init init_IRQ(void);
>> >
>> >  #endif /* _ASM_RISCV_IRQ_H */
>> > diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
>> > index 7207fa08d78f..f2fed78ab659 100644
>> > --- a/arch/riscv/kernel/irq.c
>> > +++ b/arch/riscv/kernel/irq.c
>> > @@ -7,9 +7,22 @@
>> >
>> >  #include <linux/interrupt.h>
>> >  #include <linux/irqchip.h>
>> > +#include <linux/irqdomain.h>
>> > +#include <linux/module.h>
>> >  #include <linux/seq_file.h>
>> >  #include <asm/smp.h>
>> >
>> > +static struct fwnode_handle *intc_fwnode;
>> > +
>> > +struct fwnode_handle *riscv_intc_fwnode(void)
>> > +{
>> > +     if (!intc_fwnode)
>> > +             intc_fwnode = irq_domain_alloc_named_fwnode("RISCV-INTC");
>> > +
>> > +     return intc_fwnode;
>> > +}
>> > +EXPORT_SYMBOL_GPL(riscv_intc_fwnode);
>> 
>> Why is this created outside of the root interrupt controller driver?
>> Furthermore, why do you need to create a new fwnode the first place?
>> As far as I can tell, the INTC does have a node, and what you don't
>> have is the firmware linkage between PMU (an others) and the INTC.
> 
> Fair enough, I will update this patch to not create a synthetic fwnode.
> 
> The issue is not with INTC driver. We have other drivers and places
> (such as SBI IPI driver, SBI PMU driver, and KVM RISC-V AIA support)
> where we don't have a way to locate INTC fwnode.

And that's exactly what I am talking about: The INTC is OK (sort of),
but the firmware is too crap for words, and isn't even able to expose
where the various endpoints route their interrupts to.

Yes, this is probably fine today because you can describe the topology
of RISC-V systems on the surface of a post stamp. Once you get to the
complexity of a server-grade SoC (or worse, a mobile phone style SoC),
this *implicit topology* stuff doesn't fly, because there is no 
guarantee
that all endpoints will always all point to the same controller.

>> what you should have instead is something like:
>> 
>> static struct fwnode_handle *(*__get_root_intc_node)(void);
>> struct fwnode_handle *riscv_get_root_intc_hwnode(void)
>> {
>>          if (__get_root_intc_node)
>>                  return __get_root_intc_node();
>> 
>>          return NULL;
>> }
>> 
>> and the corresponding registration interface.
> 
> Thanks, I will follow this suggestion. This is a much better approach
> and it will avoid touching existing drivers.
> 
>> 
>> But either way, something breaks: the INTC has one node per CPU, and
>> expect one irqdomain per CPU. Having a single fwnode completely breaks
>> the INTC driver (and probably the irqdomain list, as we don't check 
>> for
>> duplicate entries).
>> 
>> > diff --git a/drivers/irqchip/irq-riscv-intc.c
>> > b/drivers/irqchip/irq-riscv-intc.c
>> > index b65bd8878d4f..26ed62c11768 100644
>> > --- a/drivers/irqchip/irq-riscv-intc.c
>> > +++ b/drivers/irqchip/irq-riscv-intc.c
>> > @@ -112,8 +112,16 @@ static int __init riscv_intc_init(struct
>> > device_node *node,
>> >       if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
>> >               return 0;
>> >
>> > -     intc_domain = irq_domain_add_linear(node, BITS_PER_LONG,
>> > -                                         &riscv_intc_domain_ops, NULL);
>> > +     /*
>> > +      * Create INTC domain using a synthetic fwnode which will allow
>> > +      * drivers (such as RISC-V SBI IPI driver, RISC-V timer driver,
>> > +      * RISC-V PMU driver, etc) not having dedicated DT/ACPI node to
>> > +      * directly create interrupt mapping for standard local interrupt
>> > +      * numbers defined by the RISC-V privileged specification.
>> > +      */
>> > +     intc_domain = irq_domain_create_linear(riscv_intc_fwnode(),
>> > +                                            BITS_PER_LONG,
>> > +                                            &riscv_intc_domain_ops, NULL);
>> 
>> This is what I'm talking about. It is simply broken. So either you 
>> don't
>> need a per-CPU node (and the DT was bad the first place), or you
>> absolutely need
>> one (and the whole 'well-known/default domain' doesn't work at all).
>> 
>> Either way, this patch is plain wrong.
> 
> Okay, I will update this patch with the new approach which you 
> suggested.

But how do you plan to work around the fact that everything is currently
build around having a node (and an irqdomain) per CPU? The PLIC, for 
example,
clearly has one parent per CPU, not one global parent.

I'm sure there was a good reason for this, and I suspect merging the 
domains
will simply end up breaking things.

         M.
-- 
Jazz is not dead. It just smells funny...
