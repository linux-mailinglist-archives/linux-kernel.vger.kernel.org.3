Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA78509AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386693AbiDUIf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386678AbiDUIfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:35:24 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCEE15719
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:32:35 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2ebf3746f87so44265027b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGszuoyUKcV/26LdEmlz+vZwnErCeORcuh3rKZYQNyo=;
        b=d8dy+oZ6J9MZRGaOdECgwYu+kET33Kw130HsO9Dm93hx07PniIpJmRbq7rQ/R45cEv
         Jpwym/bwtST/PoXjhZY39GTlh6quIavugWoNphKd4qb5ftTXAVd0hdWm7BIa80QrYB5c
         qOJY3T3fXkHD780BuUnFBn7H12IOKX8QDDca2AwOzT7v7eQcfQ/X2K977tK/EmF837ue
         84kJahlKbXqkYSGkTXWPyGpCUVqKmqFJPOWsYJIy9e/6ya8VB5fUwfchQA+/qXO9DABf
         nkc7CBVLCgkpgHxLEcu4byMwCFD5B9PwCkU9FRyyHh/X/mI1zgQDX5vFbHKfRxXqyr7C
         w/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGszuoyUKcV/26LdEmlz+vZwnErCeORcuh3rKZYQNyo=;
        b=1JAx/TIpIyhfllQ0AWPtjof0naufyx/EFCuIhSRa2QVRXwH+XMC57H0wAK8vCl0L8x
         qO4DqdKiRw9WPUut4a/biG/KQADAStyAs7SE8DLxE+ZHndtRFaZKvHvIJvR5qRy1BjKE
         gFYYUnYB35VIu73xiAzhA1ISLlPID7KM1+LI2VkzZ88ZCjlo3t3TJwD6XV2BcmYR4pL+
         9vMu6CRcFSDFAmJYyXG/tyxAeqp0M3pvxNHFOpRRKA2TE9mRFNzl41HYkVshQ8AjjCkP
         /xS6YAlTjBLPnsTJDU+fcjYUdYYrsmMwpi8dVCExsGg6/C0jh6x7TlA1OvD8SlYY0voa
         91+w==
X-Gm-Message-State: AOAM530k4VNxx+gwGhCGISTXhJSh95G8BTn/oF/y/OCR+Yy/Yi1tuvbj
        zQoUDiR2uFDR9XUhqb8ucSJ/Ke4r122SnvK4rifCZw==
X-Google-Smtp-Source: ABdhPJyxAo6/sVV8cW4pTMf6ncHqiDbTtutoVLfCBc/OugMHYex0y+kUiKbRJvZVto3pDm7JktDop/av91EJnV3kFAU=
X-Received: by 2002:a81:6dc7:0:b0:2f1:c5bf:8f64 with SMTP id
 i190-20020a816dc7000000b002f1c5bf8f64mr13740708ywc.120.1650529954805; Thu, 21
 Apr 2022 01:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220421015728.86912-1-nathan@nathanrossi.com> <87mtgfgx7d.wl-maz@kernel.org>
In-Reply-To: <87mtgfgx7d.wl-maz@kernel.org>
From:   Nathan Rossi <nathan@nathanrossi.com>
Date:   Thu, 21 Apr 2022 18:32:23 +1000
Message-ID: <CA+aJhH026fR5p6-JBaoQikZwC1F-iLBQWrqAvagauKjQoOqykQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/armada-370-xp: Enable MSI affinity configuration
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 at 16:54, Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Nathan,
>
> On Thu, 21 Apr 2022 02:57:28 +0100,
> Nathan Rossi <nathan@nathanrossi.com> wrote:
> >
> > From: Nathan Rossi <nathan.rossi@digi.com>
> >
> > With multiple devices attached via PCIe to an Armada 385 it is possible
> > to overwhelm a single CPU with MSI interrupts. Under certain scenarios
> > configuring the interrupts to be handled by more than one CPU would
> > prevent the system from being overwhelmed. However the
> > irqchip-aramada-370-xp driver is configured to only handle MSIs on the
> > boot CPU, and provides no affinity configuration.
> >
> > This change adds support to the armada-370-xp driver to allow for
> > configuring the affinity of specific MSI irqs and to generate the
> > interrupts on secondary CPUs. This is done by enabling the private
> > doorbell for all online CPUs and configures all CPUs to unmask MSI
> > specific private doorbell bits. The CPU affinity selection of the
> > interrupt is handled by the target list of the software triggered
> > interrupt value, which is provided as the MSI message. The message has
> > the associated CPU bit set for the target CPU. For private doorbell
> > interrupts only one bit can be set otherwise all CPUs will receive the
> > interrupt, so the lowest CPU in the affinity mask is used. This means
> > that by default the first CPU will handle all the interrupts as was the
> > case before.
> >
> > Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> > ---
> >  drivers/irqchip/irq-armada-370-xp.c | 34 ++++++++++++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
> > index 5b8d571c04..42c257f576 100644
> > --- a/drivers/irqchip/irq-armada-370-xp.c
> > +++ b/drivers/irqchip/irq-armada-370-xp.c
> > @@ -209,15 +209,37 @@ static struct msi_domain_info armada_370_xp_msi_domain_info = {
> >
> >  static void armada_370_xp_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> >  {
> > +#ifdef CONFIG_SMP
> > +     unsigned int cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
> > +
> > +     msg->data = (1 << (cpu + 8)) | (data->hwirq + PCI_MSI_DOORBELL_START);
>
> BIT(cpu + 8) | ...
>
> > +#else
> > +     msg->data = 0xf00 | (data->hwirq + PCI_MSI_DOORBELL_START);
>
> This paints the existing code a bit differently. This seems to target
> all 4 CPUs. Why is that? I'd expect only bit 8 to be set, and the
> whole #ifdefery to go away.

I am not sure why this is targeting 4 CPUs, it will be masked by the
percpu doorbell mask register and is effectively BIT(8). At least
based on the documentation I have (only for armada 370/38x), which is
why I left it as an #ifdef. I was also not able to find any specifics
as to why it is targeting all 4 CPUs in git history. However this
value was added with the initial driver implementation when only
armada 370 was available in the kernel, so it is perhaps an
inconsistent value that was never an issue due to the bits being
reserved. I will remove the #ifdef in a v2 patch that addresses your
other comments.

>
> > +#endif
> >       msg->address_lo = lower_32_bits(msi_doorbell_addr);
> >       msg->address_hi = upper_32_bits(msi_doorbell_addr);
> > -     msg->data = 0xf00 | (data->hwirq + PCI_MSI_DOORBELL_START);
> >  }
> >
> >  static int armada_370_xp_msi_set_affinity(struct irq_data *irq_data,
> >                                         const struct cpumask *mask, bool force)
> >  {
> > -      return -EINVAL;
> > +#ifdef CONFIG_SMP
> > +     unsigned int cpu;
> > +
> > +     if (!force)
> > +             cpu = cpumask_any_and(mask, cpu_online_mask);
> > +     else
> > +             cpu = cpumask_first(mask);
> > +
> > +     if (cpu >= nr_cpu_ids)
> > +             return -EINVAL;
> > +
> > +     irq_data_update_effective_affinity(irq_data, cpumask_of(cpu));
> > +
> > +     return IRQ_SET_MASK_OK;
> > +#else
> > +     return -EINVAL;
> > +#endif
> >  }
> >
> >  static struct irq_chip armada_370_xp_msi_bottom_irq_chip = {
> > @@ -482,6 +504,7 @@ static void armada_xp_mpic_smp_cpu_init(void)
> >  static void armada_xp_mpic_reenable_percpu(void)
> >  {
> >       unsigned int irq;
> > +     u32 reg;
> >
> >       /* Re-enable per-CPU interrupts that were enabled before suspend */
> >       for (irq = 0; irq < ARMADA_370_XP_MAX_PER_CPU_IRQS; irq++) {
> > @@ -501,6 +524,13 @@ static void armada_xp_mpic_reenable_percpu(void)
> >       }
> >
> >       ipi_resume();
> > +
> > +     /* Enable MSI doorbell mask and combined cpu local interrupt */
> > +     reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS)
> > +             | PCI_MSI_DOORBELL_MASK;
> > +     writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
> > +     /* Unmask local doorbell interrupt */
> > +     writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
>
> This is a duplicate of what is already in armada_370_xp_msi_init().
> Please refactor it so that this doesn't happen twice on the first CPU.

It is duplicated, however armada_xp_mpic_reenable_percpu is not called
on the boot cpu as the setup is called with cpuhp_setup_state_nocalls.

Thanks,
Nathan


>
> This otherwise seem like a valuable improvement on the current
> behaviour,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
