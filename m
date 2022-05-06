Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E7F51E0DF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444376AbiEFVQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbiEFVQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:16:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C627C6F4A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:12:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651871541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OR1pmM4x5cpd2mA4k9e/aWIlSPAQ7vdjsY8tgTejLzI=;
        b=oyF7PEmPteS/Ij/pjSpG2vUJ+F9MWnjT60Q7Em5LJxgEcgdV2Keo97S3wPx7/J5E+txgUk
        JCojiqTYydfRy2QOfNub+Z6GCtf5iqJ95IrYyVrXU94wRA891K8qGTKu4kMrONDEj3t2xI
        wCxkleNZMeXe1/LgpV4XvplOoKFaZn2h2Dl1FzoVtMKW2jBHJlfhIWbjQPIGNfO2Pi7uAj
        DKSr6s0Xz47aEJt6wfPtWXi8IsfQLaSxpHv37/gGewZf4jpFxR8Ho2GkHDTqeBU4A8ImgG
        SYlksuHxEF3mZZSNUbvq7CwBHaeStS+M10UHzWT6KuBuUylRXxV8qYgVGLXNuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651871541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OR1pmM4x5cpd2mA4k9e/aWIlSPAQ7vdjsY8tgTejLzI=;
        b=9ITl2ylmsUv+bZnup01fSsbtCNbIJHb2Vl+xV5ebZckGAGMVOE04FOZX36z7AudwqlokLy
        CoePs/joVdcnuxDw==
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
Subject: Re: [PATCH v6 05/29] x86/apic/vector: Do not allocate vectors for NMIs
In-Reply-To: <20220506000008.30892-6-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-6-ricardo.neri-calderon@linux.intel.com>
Date:   Fri, 06 May 2022 23:12:20 +0200
Message-ID: <87zgjufjrf.ffs@tglx>
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
> Vectors are meaningless when allocating IRQs with NMI as the delivery
> mode.

Vectors are not meaningless. NMI has a fixed vector.

The point is that for a fixed vector there is no vector management
required.

Can you spot the difference?

> In such case, skip the reservation of IRQ vectors. Do it in the lowest-
> level functions where the actual IRQ reservation takes place.
>
> Since NMIs target specific CPUs, keep the functionality to find the best
> CPU.

Again. What for?
  
> +	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI) {
> +		cpu = irq_matrix_find_best_cpu(vector_matrix, dest);
> +		apicd->cpu = cpu;
> +		vector = 0;
> +		goto no_vector;
> +	}

Why would a NMI ever end up in this code? There is no vector management
required and this find cpu exercise is pointless.

>  	vector = irq_matrix_alloc(vector_matrix, dest, resvd, &cpu);
>  	trace_vector_alloc(irqd->irq, vector, resvd, vector);
>  	if (vector < 0)
>  		return vector;
>  	apic_update_vector(irqd, vector, cpu);
> +
> +no_vector:
>  	apic_update_irq_cfg(irqd, vector, cpu);
>  
>  	return 0;
> @@ -321,12 +330,22 @@ assign_managed_vector(struct irq_data *irqd, const struct cpumask *dest)
>  	/* set_affinity might call here for nothing */
>  	if (apicd->vector && cpumask_test_cpu(apicd->cpu, vector_searchmask))
>  		return 0;
> +
> +	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI) {
> +		cpu = irq_matrix_find_best_cpu_managed(vector_matrix, dest);
> +		apicd->cpu = cpu;
> +		vector = 0;
> +		goto no_vector;
> +	}

This code can never be reached for a NMI delivery. If so, then it's a
bug.

This all is special purpose for that particular HPET NMI watchdog use
case and we are not exposing this to anything else at all.

So why are you sprinkling this NMI nonsense all over the place? Just
because? There are well defined entry points to all of this where this
can be fenced off.

If at some day the hardware people get their act together and provide a
proper vector space for NMIs then we have to revisit that, but then
there will be a separate NMI vector management too.

What you want is the below which also covers the next patch. Please keep
an eye on the comments I added/modified.

Thanks,

        tglx
---
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -42,6 +42,7 @@ EXPORT_SYMBOL_GPL(x86_vector_domain);
 static DEFINE_RAW_SPINLOCK(vector_lock);
 static cpumask_var_t vector_searchmask;
 static struct irq_chip lapic_controller;
+static struct irq_chip lapic_nmi_controller;
 static struct irq_matrix *vector_matrix;
 #ifdef CONFIG_SMP
 static DEFINE_PER_CPU(struct hlist_head, cleanup_list);
@@ -451,6 +452,10 @@ static int x86_vector_activate(struct ir
 	trace_vector_activate(irqd->irq, apicd->is_managed,
 			      apicd->can_reserve, reserve);
 
+	/* NMI has a fixed vector. No vector management required */
+	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI)
+		return 0;
+
 	raw_spin_lock_irqsave(&vector_lock, flags);
 	if (!apicd->can_reserve && !apicd->is_managed)
 		assign_irq_vector_any_locked(irqd);
@@ -472,6 +477,10 @@ static void vector_free_reserved_and_man
 	trace_vector_teardown(irqd->irq, apicd->is_managed,
 			      apicd->has_reserved);
 
+	/* NMI has a fixed vector. No vector management required */
+	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI)
+		return;
+
 	if (apicd->has_reserved)
 		irq_matrix_remove_reserved(vector_matrix);
 	if (apicd->is_managed)
@@ -568,6 +577,24 @@ static int x86_vector_alloc_irqs(struct
 		irqd->hwirq = virq + i;
 		irqd_set_single_target(irqd);
 
+		if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
+			/*
+			 * NMIs have a fixed vector and need their own
+			 * interrupt chip so nothing can end up in the
+			 * regular local APIC management code except the
+			 * MSI message composing callback.
+			 */
+			irqd->chip = &lapic_nmi_controller;
+			/*
+			 * Don't allow affinity setting attempts for NMIs.
+			 * This cannot work with the regular affinity
+			 * mechanisms and for the intended HPET NMI
+			 * watchdog use case it's not required.
+			 */
+			irqd_set_no_balance(irqd);
+			continue;
+		}
+
 		/*
 		 * Prevent that any of these interrupts is invoked in
 		 * non interrupt context via e.g. generic_handle_irq()
@@ -921,6 +948,11 @@ static struct irq_chip lapic_controller
 	.irq_retrigger		= apic_retrigger_irq,
 };
 
+static struct irq_chip lapic_nmi_controller = {
+	.name			= "APIC-NMI",
+	.irq_compose_msi_msg	= x86_vector_msi_compose_msg,
+};
+
 #ifdef CONFIG_SMP
 
 static void free_moved_vector(struct apic_chip_data *apicd)
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -261,6 +261,11 @@ static inline bool irqd_is_per_cpu(struc
 	return __irqd_to_state(d) & IRQD_PER_CPU;
 }
 
+static inline void irqd_set_no_balance(struct irq_data *d)
+{
+	__irqd_to_state(d) |= IRQD_NO_BALANCING;
+}
+
 static inline bool irqd_can_balance(struct irq_data *d)
 {
 	return !(__irqd_to_state(d) & (IRQD_PER_CPU | IRQD_NO_BALANCING));
