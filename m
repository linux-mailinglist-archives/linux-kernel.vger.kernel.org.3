Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405E44FAAA3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiDIULD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiDIULA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:11:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF6F1E532A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:08:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649534928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ePu+BNLNCkBdEe6g7SLLA68lLVuHXGvD/Y9XEmQw0X0=;
        b=KJ4ljAmExspZSHOsoSy8WizLdL8RHpW5RqiXigg4sSVry7lGk2vubfCAiORAS8brGTUbSL
        gyPSdEQHbijsberfRKNjm4bFRyiljC4Fmq6grAfNWi0650tR4xVDYtqLkHQ4QenglgzySA
        qZyG/4hBnOBRZop/IHcvxX/zH//Xu9CFEqeJmkC+9MFA20COWFysL5zx1qW68YVEzQIqud
        hwiHBhVFHO2jBVYqr5InTdeSeEaBCNAlSkKgFj5qL+TrF65QtVGKcCKx+uQsRKFqRvvnDV
        UfXW2OEpRSmnDd+xdAqFHnQWdwcFe4KX36BMxHs8ZtnFJG3Sv30X2zDzVoY4PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649534928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ePu+BNLNCkBdEe6g7SLLA68lLVuHXGvD/Y9XEmQw0X0=;
        b=DnyrRnS6pNeYTMtsuKX1LryUzrjmBFTjIPV7G7MkA6XDi7MZR6myQL6lxaTmU99DbE5lhq
        uu1+amLEsp9WYIDg==
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: x86 multi-msi w/o iommu
In-Reply-To: <6410d0d5-bd88-64d5-6ae7-cca33746b302@quicinc.com>
References: <6410d0d5-bd88-64d5-6ae7-cca33746b302@quicinc.com>
Date:   Sat, 09 Apr 2022 22:08:48 +0200
Message-ID: <877d7yhve7.ffs@tglx>
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

Jeffrey!

On Fri, Apr 08 2022 at 11:34, Jeffrey Hugo wrote:
> I'd like to get multi-MSI without IOMMU working on x86. I'm hoping you
> could help me understand the current state of things, and if there is
> a path toward enabling this.

Hope is definitely required here, but you did not explain yet WHY you
want that to work. Making it work just because is not really a good
starting point.

> This is an overly simplistic assessment, but this reportedly works in 
> other OSes, so it looks like Linux is broken in comparison.
>
> In my investigation so far, the failure stems from
> x86_vector_alloc_irqs() in arch/x86/kernel/apic/vector.c [1].

The failure? That's not a failure, that's a deliberate decision.

Side note: Please spare us the links to random code sites and git web
interfaces. A function name and a commit id is good enough.

> If we need a contiguous allocation of more than one irq, the
> allocation immediately fails:
>
> 	/* Currently vector allocator can't guarantee contiguous allocations */
> 	if ((info->flags & X86_IRQ_ALLOC_CONTIGUOUS_VECTORS) && nr_irqs > 1)
> 		return -ENOSYS;
>
> As I'm sure you are aware, this only impacts MSI without IOMMU as both 
> MSI-X and MSI with IOMMU can handle a discontinuous allocation (the flag 
> is not set for either of those cases).
>
> That check was added back in 2015 with [2].

X86 never supported multi-MSI in Linux. See:

    commit 1c8d7b0a562d ("PCI MSI: Add support for multiple MSI")

> In 2017, it looks like you refactored the allocator to the irq_matrix
> component [3].  However, the limitation remains to today.

For very good reasons.

> Digging a bit further, it looks like the internal function 
> matrix_alloc_area() [4] is capable of doing a contiguous allocation, but 
> all the callers of that via the public api hardcode num to 1.  I 
> wouldn't say it would be trivial to refactor the irq_matrix public api 
> to do a contigious range allocation, and refactor 
> x86_vector_alloc_irqs() to do that based on 
> X86_IRQ_ALLOC_CONTIGUOUS_VECTORS, but since it seems like that hasn't 
> been tackled in 5-7 years (depending on how you look at the history), I 
> suspect I'm missing something.

There are two fundamental issues with multi-MSI:

   1) General

      a) Multi-MSI is a single MSI message. The device sets the vector
         offset in the lower bits of message data.

      b) As a consequence the Multi-MSI interrupts of a given device are
         all affine to a single target and you cannot set affinity for
         them separately, which limits the usefulness very much.

   2) x86

      a) Due to #1a this requires N consecutive vectors on one CPU and
         these vectors have to be aligned so that the device can set the
         vector offset into the lower bits of message data. The
         alignment requirement depends on the number of vectors and is
         always power of 2 in the range (2, 4, 8, 16, 32).

         Easy to do in theory. But in practice there is the limited
         vector space on x86 (~200) for device interrupts per CPU.

         That creates a problem for allocations in general and for CPU
         hotplug. On hotplug all active interrupts are moved away from
         the outgoing CPU. Due to the alignment requirement this is
         pretty much a guarantee for vector exhaustion.

      b) Changing interrupt affinity for MSI w/o IOMMU is an interesting
         exercise on X86 when the interrupt is not maskable, which is
         unfortunately the case in the majority of MSI hardware
         implementations.

         In that case while the new vectors are installed interrupts can
         be issued by the device. So you need to be very careful _not_
         to lose an interrupt in the case that both the message address
         (the target APIC) and the message data (the vector) are
         changed. You can find the gory details in:

                  arch/x86/kerne/apic/msi.c::msi_set_affinity()

         and the related change logs espescially:
         6f1a4891a592 ("x86/apic/msi: Plug non-maskable MSI affinity race")

         Due to #1b changing interrupt affinity has to move _all_
         vectors associated to the device at once, which makes this
         excercise even more interesting.

         This code is already horrible as hell and the thought alone to
         expand it for multi MSI makes me shudder.

Now with interrupt remapping all of the above goes away:

    - The alignment problem and consecutive space issue moves into
      the remap tables which have plenty of space.

    - Each interrupts affinity can be individually controlled because
      the affinity setting happens in the remap table and does not
      require the horrors of the non remapped case.

That means in Multi-MSI can be implemented on x86 w/o remapping, but is
it worth the trouble? From looking at the problem space and under
consideration that the advantage of multi-MSI is very limited the
decision was made to not support it. That's not broken as you claim,
that's a very reasonable technical decision.

From experimentation I know that multi-MSI w/o remapping has a very
limited benefit because it cannot provide scalability through
parallelism obviously. The only benefit is a clear separation of
interrupt functionality which spares a MMIO read to get the pending bits
and a few conditionals. Here is a trivial experiment to demonstrate the
benefit or the lack of it:

    Use a system with interrupt remapping and add a module parameter to
    your driver which allows you to select ONE or MANY MSIs. Then run
    performance tests with both setups.
    
The result might not be what you expect depending on the device and the
resulting interrupt patterns.

The problems of MSI are known since two decades, but hardware folks
still insist on it. MSI-X exists for a reason, but sure it makes the
chips $0.01 more expensive and lots of hardware people still work under
the assumption that whatever they get wrong can be fixed in software,
which is unfortunately wishful thinking.

I hope this clarifies it for you.

Thanks,

        tglx
