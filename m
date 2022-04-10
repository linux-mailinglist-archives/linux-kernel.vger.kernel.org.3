Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F054FB005
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbiDJUNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiDJUNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:13:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426904B1CC
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 13:11:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649621461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CFZiyRoAkzbPk9Xvd26+tVM4kSwgrt9e2TSeylQenK4=;
        b=qRv5q4FMwx8M4ExgvLlNWs5Qm8N3vPR7Ygnmrx2ov+/OqkpaI0A0ecU01kxDfCmcS8fYLl
        DEx3wul4edO+FhL2wjWKS4gpGXCzY+BwD3P1uFPMOC92cMj4UvBw9tFWyQljWhnmhMVJkX
        9A3MPK3zttKpW/lNI+NW0zDDPklavVUPGXN8prMGhT98k/Aglbv7294K7FGYv4uze1pEk/
        k+7y2SVzlV07pZb1GGY2xNiZtU2KYAlgidkHYIE2jKKJr0qtQo3+lDWujhiYsJKoV247A7
        jBaeu9DceUZrX6QWrwWZKnVwJ4GttHYot4ckrcgY+RTw8BsXXzHLCkF/bVbXzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649621461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CFZiyRoAkzbPk9Xvd26+tVM4kSwgrt9e2TSeylQenK4=;
        b=pyNbIVhNc1r6Uv7vn9aefZj+wTHPs26UmgzeP3aRxEYpceoMrD9ydhW1eAh+cZB2DTbji8
        OBWcQheUTykh5hBg==
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH v5 3/7] genirq: Add mechanism to multiplex a single HW IPI
In-Reply-To: <20220324151258.943896-4-apatel@ventanamicro.com>
References: <20220324151258.943896-1-apatel@ventanamicro.com>
 <20220324151258.943896-4-apatel@ventanamicro.com>
Date:   Sun, 10 Apr 2022 22:11:01 +0200
Message-ID: <87a6cshf6y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anup,

On Thu, Mar 24 2022 at 20:42, Anup Patel wrote:
> All RISC-V platforms have a single HW IPI provided by the INTC local
> interrupt controller. The HW method to trigger INTC IPI can be through
> external irqchip (e.g. RISC-V AIA), through platform specific device
> (e.g. SiFive CLINT timer), or through firmware (e.g. SBI IPI call).
>
> To support multiple IPIs on RISC-V, we need a generic mechanism to
> create multiple per-CPU vIRQs using a single HW IPI hence this patch.

git grep 'This patch' Documentation/process

> The generic IPI multiplex mechanism added by this patch can also be
> useful to other architectures.

Which ones? Sane architectures have more than one IPI.

> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 848e1e12c5c6..cdce7eae2f37 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -1248,6 +1248,34 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
>  int ipi_send_single(unsigned int virq, unsigned int cpu);
>  int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
>  
> +#define IPI_MUX_NR_IRQS		BITS_PER_LONG
> +struct ipi_mux_ops {

This is unreadable. Newlines exist for a reason.

> +	void (*ipi_mux_clear)(unsigned int parent_virq);
> +	void (*ipi_mux_send)(unsigned int parent_virq,
> +			     const struct cpumask *mask);
> +};
> +
> +/* Process multiplexed IPIs */
> +void ipi_mux_process(void);
> +
> +/*
> + * Create multiple IPIs (total IPI_MUX_NR_IRQS) multiplexed on top of a
> + * single parent IPI.
> + *
> + * If the parent IPI > 0 then ipi_mux_process() will be automatically
> + * called via chained handler.
> + *
> + * If the parent IPI <= 0 then it is responsiblity of irqchip drivers
> + * to explicitly call ipi_mux_process() for processing muxed
> + * IPIs.
> + *
> + * Returns first virq of the muxed IPIs upon success or <=0 upon failure
> + */
> +int ipi_mux_create(unsigned int parent_virq, const struct ipi_mux_ops *ops);

While it is kinda sensible to have the documentation near the
declaration, I prefer it to be near the code because thats where it
matters and also has a higher chance to be updated when the code
changes.

Please use proper kernel doc while at it.

> +static unsigned int ipi_mux_parent_virq;
> +static struct irq_domain *ipi_mux_domain;
> +static const struct  ipi_mux_ops *ipi_mux_ops;
> +static DEFINE_PER_CPU(unsigned long, ipi_mux_bits);
> +
> +static void ipi_mux_dummy(struct irq_data *d)
> +{
> +}
> +
> +static void ipi_mux_send_mask(struct irq_data *d, const struct cpumask *mask)
> +{
> +	int cpu;
> +
> +	/* Barrier before doing atomic bit update to IPI bits */
> +	smp_mb__before_atomic();
> +
> +	for_each_cpu(cpu, mask)
> +		set_bit(d->hwirq, per_cpu_ptr(&ipi_mux_bits, cpu));
> +
> +	/* Barrier after doing atomic bit update to IPI bits */
> +	smp_mb__after_atomic();
> +
> +	/* Trigger the parent IPI */
> +	ipi_mux_ops->ipi_mux_send(ipi_mux_parent_virq, mask);
> +}
> +
> +static struct irq_chip ipi_mux_chip = {
> +	.name		= "RISC-V IPI Mux",

RISC-V IPI Mux is a truly generic name :)

> +	.irq_mask	= ipi_mux_dummy,
> +	.irq_unmask	= ipi_mux_dummy,
> +	.ipi_send_mask	= ipi_mux_send_mask,
> +};
> +
> +static int ipi_mux_domain_map(struct irq_domain *d, unsigned int irq,
> +			      irq_hw_number_t hwirq)
> +{
> +	irq_set_percpu_devid(irq);
> +	irq_domain_set_info(d, irq, hwirq, &ipi_mux_chip, d->host_data,
> +			    handle_percpu_devid_irq, NULL, NULL);
> +
> +	return 0;
> +}
> +
> +static int ipi_mux_domain_alloc(struct irq_domain *d, unsigned int virq,
> +				unsigned int nr_irqs, void *arg)
> +{
> +	int i, ret;
> +	irq_hw_number_t hwirq;
> +	unsigned int type = IRQ_TYPE_NONE;
> +	struct irq_fwspec *fwspec = arg;

  Documentation/process/maintainer-tip.rst #coding-style-notes

> +	ret = irq_domain_translate_onecell(d, fwspec, &hwirq, &type);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		ret = ipi_mux_domain_map(d, virq + i, hwirq + i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops ipi_mux_domain_ops = {
> +	.translate	= irq_domain_translate_onecell,
> +	.alloc		= ipi_mux_domain_alloc,
> +	.free		= irq_domain_free_irqs_top,
> +};
> +
> +void ipi_mux_process(void)
> +{
> +	int err;
> +	unsigned long irqs, *bits = this_cpu_ptr(&ipi_mux_bits);
> +	irq_hw_number_t hwirq;
> +
> +	while (true) {
> +		/* Clear the parent IPI */
> +		ipi_mux_ops->ipi_mux_clear(ipi_mux_parent_virq);

This being in a loop smells fishy at least without a comment. And the
more I read all of this the less I'm convinced that this code can be
used by anything else than RISCV.

> +		/* Order bit clearing and data access. */
> +		mb();

This mb() pairs with what? Memory barriers have a counterpart and it's
mandatory to document that in the comment.

> +		irqs = xchg(bits, 0);
> +		if (!irqs)
> +			break;
> +
> +		for_each_set_bit(hwirq, &irqs, IPI_MUX_NR_IRQS) {
> +			err = generic_handle_domain_irq(ipi_mux_domain,
> +							hwirq);
> +			if (unlikely(err))
> +				pr_warn_ratelimited(
> +					"can't find mapping for hwirq %lu\n",
> +					hwirq);
> +		}
> +	}
> +}
> +
> +
> +void ipi_mux_destroy(void)

Seriously? You provide a function to rip the IPI mechanism out in a
running system? What's that for?

> +{
> +	if (!ipi_mux_domain)
> +		return;
> +
> +	irq_domain_remove(ipi_mux_domain);
> +	ipi_mux_domain = NULL;
> +	ipi_mux_parent_virq = 0;

If it would be useful, then this would leak the hotplug callbacks, but
the good news is that after tearing down the IPI domain hotplug does not
work anymore :)

Thanks,

        tglx
