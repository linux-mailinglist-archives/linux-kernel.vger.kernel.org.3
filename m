Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F714526BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379957AbiEMUuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356811AbiEMUuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:50:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5966554
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:50:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652475010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zEdz3PBK+OaYEz88/8/oMxcc8qsP3Ut2QqnQHlJZHqE=;
        b=IL5ps9Pi2NFB4qTc/+l9Q6Ywr61TAXtYWQaoSp7/YbaTcIvSE9C5eLi+t7xEHqEeYjETXy
        JmzdwkR1BjpqSKaC0i1aIRbhjFDiQDzAY0BCHdHh/4VpIInaO6SaQP3tcK+xed/cxdQc98
        EeugDl7hMWE7H4HfUhMdKa0BDk7UiwLoggjpg6a0mH4MB8CPpd8kuWCvK2t0KbLmFzAf58
        alHc5j1TQhITDFdCadertqBxYuofkeeTGIqgwJFHxxMd3hIwPbd+zCucmhhovYvvi35KA7
        wXRs36ZyRr73nbP/djYS0b302aslX8nO8TU0pWKtw2DfpZnQdl6w3lc/Jb2z7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652475010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zEdz3PBK+OaYEz88/8/oMxcc8qsP3Ut2QqnQHlJZHqE=;
        b=RyMi/A5Po6vaHS9i40z6IeKIq7BgJOWcZ6bfF5+HAQR7bK6hdxFiTaWa09d2O8EN+o2gLw
        QsH3uYNZXchYGcCw==
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/29] x86/apic/vector: Do not allocate vectors for NMIs
In-Reply-To: <20220513180320.GA22683@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-6-ricardo.neri-calderon@linux.intel.com>
 <87zgjufjrf.ffs@tglx> <20220513180320.GA22683@ranerica-svr.sc.intel.com>
Date:   Fri, 13 May 2022 22:50:09 +0200
Message-ID: <87v8u9rwce.ffs@tglx>
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

On Fri, May 13 2022 at 11:03, Ricardo Neri wrote:
> On Fri, May 06, 2022 at 11:12:20PM +0200, Thomas Gleixner wrote:
>> Why would a NMI ever end up in this code? There is no vector management
>> required and this find cpu exercise is pointless.
>
> But even if the NMI has a fixed vector, it is still necessary to determine
> which CPU will get the NMI. It is still necessary to determine what to
> write in the Destination ID field of the MSI message.
>
> irq_matrix_find_best_cpu() would find the CPU with the lowest number of
> managed vectors so that the NMI is directed to that CPU. 

What's the point to send it to the CPU with the lowest number of
interrupts. It's not that this NMI happens every 50 microseconds.
We pick one online CPU and are done.

> In today's code, an NMI would end up here because we rely on the existing
> interrupt management infrastructure... Unless, the check is done the entry
> points as you propose.

Correct. We don't want to call into functions which are not designed for
NMIs.
 
>> > +
>> > +	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI) {
>> > +		cpu = irq_matrix_find_best_cpu_managed(vector_matrix, dest);
>> > +		apicd->cpu = cpu;
>> > +		vector = 0;
>> > +		goto no_vector;
>> > +	}
>> 
>> This code can never be reached for a NMI delivery. If so, then it's a
>> bug.
>> 
>> This all is special purpose for that particular HPET NMI watchdog use
>> case and we are not exposing this to anything else at all.
>> 
>> So why are you sprinkling this NMI nonsense all over the place? Just
>> because? There are well defined entry points to all of this where this
>> can be fenced off.
>
> I put the NMI checks in these points because assign_vector_locked() and
> assign_managed_vector() are reached through multiple paths and these are
> the two places where the allocation of the vector is requested and the
> destination CPU is determined.
>
> I do observe this code being reached for an NMI, but that is because this
> code still does not know about NMIs... Unless the checks for NMI are put
> in the entry points as you pointed out.
>
> The intent was to refactor the code in a generic manner and not to focus
> only in the NMI watchdog. That would have looked hacky IMO.

We don't want to have more of this really. Supporting NMIs on x86 in a
broader way is simply not reasonable because there is only one NMI
vector and we have no sensible way to get to the cause of the NMI
without a massive overhead.

Even if we get multiple NMI vectors some shiny day, this will be
fundamentally different than regular interrupts and certainly not
exposed broadly. There will be 99.99% fixed vectors for simplicity sake.

>> +		if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
>> +			/*
>> +			 * NMIs have a fixed vector and need their own
>> +			 * interrupt chip so nothing can end up in the
>> +			 * regular local APIC management code except the
>> +			 * MSI message composing callback.
>> +			 */
>> +			irqd->chip = &lapic_nmi_controller;
>> +			/*
>> +			 * Don't allow affinity setting attempts for NMIs.
>> +			 * This cannot work with the regular affinity
>> +			 * mechanisms and for the intended HPET NMI
>> +			 * watchdog use case it's not required.
>
> But we do need the ability to set affinity, right? As stated above, we need
> to know what Destination ID to write in the MSI message or in the interrupt
> remapping table entry.
>
> It cannot be any CPU because only one specific CPU is supposed to handle the
> NMI from the HPET channel.
>
> We cannot hard-code a CPU for that because it may go offline (and ignore NMIs)
> or not be part of the monitored CPUs.
>
> Also, if lapic_nmi_controller.irq_set_affinity() is NULL, then irq_chips
> INTEL-IR, AMD-IR, those using msi_domain_set_affinity() need to check for NULL.
> They currently unconditionally call the parent irq_chip's irq_set_affinity().
> I see that there is a irq_chip_set_affinity_parent() function. Perhaps it can
> be used for this check?

Yes, this lacks obviously a NMI specific set_affinity callback and this
can be very trivial and does not have any of the complexity of interrupt
affinity assignment. First online CPU in the mask with a fallback to any
online CPU.

I did not claim that this is complete. This was for illustration.

>> +			 */
>> +			irqd_set_no_balance(irqd);
>
> This code does not set apicd->hw_irq_cfg.delivery_mode as NMI, right?
> I had to add that to make it work.

I assumed you can figure that out on your own :)

Thanks,

        tglx
