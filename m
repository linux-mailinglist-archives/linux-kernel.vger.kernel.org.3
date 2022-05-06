Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C2F51DFD6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392053AbiEFT5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352249AbiEFT5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:57:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB481E3C0
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 12:53:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651866834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPigNHr8wXW4Jsp9L+zcdiLLC2xp5wKYQoiAjHdLkb0=;
        b=Xc8Vtd935tKSHJ4TItbPhom70GX4iR+XaOHyoZEbq2TCP4h9WjKpN0MVzmsUbMnujiBgnV
        WXGzehvrucSX1BoXOdNpoMb3s0YNBoPdGbKtAB3wDRyptT25vNwG7QcC7LwRl3B15XR6VM
        FhGG5jK12XCNGha0igmSaWXXc2p4A3H1NRfSABcL1Z3IwAXCO4O3qpx16YQ/THdTjg92ya
        In409B3HY2BR55Mv7J/T3Np4Rdy7VMWpG58IDPN5+hY6NlLD7uyzePgQU6EvXGIFGFCODZ
        3pB/pK2v3RdJoDZ1aaYSIcYs0qALgfVW7BGlvJCXH5N/7ExJVtGCxVmBC9jnxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651866834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPigNHr8wXW4Jsp9L+zcdiLLC2xp5wKYQoiAjHdLkb0=;
        b=/4l7akvaVCpYSimscxE6emXgo2DDhYqJsbAjKJILCBQFs5NLOHNmvvAauEvq153gAwkORH
        f5cYHMQqOtGE5zCA==
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v6 02/29] x86/apic: Add irq_cfg::delivery_mode
In-Reply-To: <20220506000008.30892-3-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-3-ricardo.neri-calderon@linux.intel.com>
Date:   Fri, 06 May 2022 21:53:54 +0200
Message-ID: <875ymih1yl.ffs@tglx>
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

On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> Currently, the delivery mode of all interrupts is set to the mode of the
> APIC driver in use. There are no restrictions in hardware to configure the
> delivery mode of each interrupt individually. Also, certain IRQs need
> to be

s/IRQ/interrupt/ Changelogs can do without acronyms.

> configured with a specific delivery mode (e.g., NMI).
>
> Add a new member, delivery_mode, to struct irq_cfg. Subsequent changesets
> will update every irq_domain to set the delivery mode of each IRQ to that
> specified in its irq_cfg data.
>
> To keep the current behavior, when allocating an IRQ in the root
> domain

The root domain does not allocate an interrupt. The root domain
allocates a vector for an interrupt. There is a very clear and technical
destinction. Can you please be more careful about the wording?

> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -567,6 +567,7 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
>  		irqd->chip_data = apicd;
>  		irqd->hwirq = virq + i;
>  		irqd_set_single_target(irqd);
> +

Stray newline.

>  		/*
>  		 * Prevent that any of these interrupts is invoked in
>  		 * non interrupt context via e.g. generic_handle_irq()
> @@ -577,6 +578,14 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
>  		/* Don't invoke affinity setter on deactivated interrupts */
>  		irqd_set_affinity_on_activate(irqd);
>  
> +		/*
> +		 * Initialize the delivery mode of this irq to match the

s/irq/interrupt/

> +		 * default delivery mode of the APIC. Children irq domains
> +		 * may take the delivery mode from the individual irq
> +		 * configuration rather than from the APIC driver.
> +		 */
> +		apicd->hw_irq_cfg.delivery_mode = apic->delivery_mode;
> +
>  		/*
>  		 * Legacy vectors are already assigned when the IOAPIC
>  		 * takes them over. They stay on the same vector. This is
