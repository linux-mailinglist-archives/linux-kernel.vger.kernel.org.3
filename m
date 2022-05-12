Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E92524E48
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354429AbiELNaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354427AbiELNaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:30:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CAD253ABD
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:30:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652362202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jh/jFbnSUA7IWAzYFoSb7APluz7HA7PKXomh5dcaByM=;
        b=fRsO4W3fk23MjEkXh9sd7FucAJARujP68JUxGf5kyNywn9isXTs1vCI2Pt+Y2qJXhLfogX
        13saEhEqvFrc2p0vyyWeHR0SlG8Vfx0RB193zm/hYKO2N8PZMhJ1iSV3Ep2Ff7HB3AsMHo
        5mtOlYk2NMXWa5dO735mzynKgt8LKxjl+eleD/ARq8oYA+/+BU6grmoJ6sD0YOLg20YgjX
        f9i854gOWGfg7ptRZFVfHbedvvEVkNN3606k1PE/5xUT9rnD691gQVNKtrKF+PHTfBY6vH
        6yQUdhd7QZ735zuBncutoBUasZ01LhB7xEsOgOE34G5Dya8ipXEIxo+2LsL27Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652362202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jh/jFbnSUA7IWAzYFoSb7APluz7HA7PKXomh5dcaByM=;
        b=T12LhOIo4k09ChfV17VLUuuDL26U+nTtwCeDRbjCSbJBnnw37TCkkByi2ts+5O89QuZmVD
        4XmUByyA7rdd+fAQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFCv2 07/10] x86/mm: Handle tagged memory accesses from kernel
 threads
In-Reply-To: <20220511022751.65540-9-kirill.shutemov@linux.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-9-kirill.shutemov@linux.intel.com>
Date:   Thu, 12 May 2022 15:30:01 +0200
Message-ID: <878rr6x4iu.ffs@tglx>
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

On Wed, May 11 2022 at 05:27, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index f9fe71d1f42c..b320556e1c22 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -185,6 +185,34 @@ static u8 gen_lam(struct task_struct *tsk, struct mm_struct *mm)
>  	if (!tsk)
>  		return LAM_NONE;
>  
> +	if (tsk->flags & PF_KTHREAD) {
> +		/*
> +		 * For kernel thread use the most permissive LAM
> +		 * used by the mm. It's required to handle kernel thread
> +		 * memory accesses on behalf of a process.
> +		 *
> +		 * Adjust thread flags accodringly, so untagged_addr() would
> +		 * work correctly.
> +		 */
> +
> +		tsk->thread.features &= ~(X86_THREAD_LAM_U48 |
> +					  X86_THREAD_LAM_U57);
> +
> +		switch (mm->context.lam) {
> +		case LAM_NONE:
> +			return LAM_NONE;
> +		case LAM_U57:
> +			tsk->thread.features |= X86_THREAD_LAM_U57;
> +			return LAM_U57;
> +		case LAM_U48:
> +			tsk->thread.features |= X86_THREAD_LAM_U48;
> +			return LAM_U48;

Pretending that LAM is configurable per thread and then having a magic
override in the per process mm when accessing that process' memory from
a kernel thread is inconsistent, a horrible hack and a recipe for
hard to diagnose problems.

LAM has to be enabled by the process _before_ creating threads and then
stay enabled until the whole thing dies. That's the only sensible use
case.

I understand that tsk->thread.features is conveniant for the untagging
mechanism, but the whole setup should be:

prctl(ENABLE, which)
     if (can_enable_lam(which)) {
     	mm->lam.c3_mask = CR3_LAM(which);
        mm->lam.untag_mask = UNTAG_LAM(which);
        current->thread.lam_untag_mask = mm->lam.untag_mask;
     }

and

can_enable_lam(which)
    if (current_is_multithreaded())
    	return -ETOOLATE;
    if (current->mm->lam_cr3_mask)
    	return -EBUSY;
    ....
    	

Now vs. kernel threads. Doing this like the above is just the wrong
place. If a kernel thread accesses user space memory of a process then
it has to invoke kthread_use_mm(), right? So the obvious point to cache
that setting is in kthread_use_mm() and kthread_unuse_mm() clears it:

kthread_use_mm()
     current->thread.lam_untag_mask = mm->lam.untag_mask;

kthread_unuse_mm()
     current->thread.lam_untag_mask = 0;

This makes all of the mechanics trivial because CR3 switch then simply
does:

     new_cr3 |= mm->lam.c3_mask;

No conditionals and evaluations, nothing. Just straight forward and
comprehensible code.

Thanks,

        tglx
