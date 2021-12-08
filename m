Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FB346C892
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhLHAZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:25:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56568 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhLHAZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:25:22 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638922909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aLdiApW+GaG42NuzzomeApp22JBbkuPEiFKoVfsDnI4=;
        b=pqOFF07MHi/v2aQo6Z2UUb/770QJ/kCg5WKttoQSixYKpoPR+08GRYBoPkR1ZLtj0fMEEI
        NZQSJgpwLMQLXDUpXivtlFzLbu/9ZtzOpv0tkJTpE5XPcqfyeabov3r3IoNB1m1Paa/G+J
        S064E9e7l23FMJGoeldTDWxZ9I8D7+b+PZpyp2T/yGDH6T13ubCNo1VgXdcXB3Ff33QU/h
        pNDcdN2O60VtwTkBywXIwChqxHL7YQAn6vW5ct/fbJMs4t+YcCmcStmepUUhGX8S5xFMnV
        lJXQge7G2EIcUsQ+SCAgK1rwVC2k4yej5T10VNUFisk6JIWDbMRfGwiEuKnJAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638922909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aLdiApW+GaG42NuzzomeApp22JBbkuPEiFKoVfsDnI4=;
        b=ndhwQOKdBamHaYfKmK/p7kX7OL0Q/TozTBbdlJvy8J9gpP7z1wSRnLRVTl29ujpjKPAi8u
        kMDNi3kL1kdCeZBw==
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH V7 08/18] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <20211207015423.GA4012679@iweiny-DESK2.sc.intel.com>
References: <20210804043231.2655537-1-ira.weiny@intel.com>
 <20210804043231.2655537-9-ira.weiny@intel.com> <87r1b4l3xc.ffs@tglx>
 <20211207015423.GA4012679@iweiny-DESK2.sc.intel.com>
Date:   Wed, 08 Dec 2021 01:21:48 +0100
Message-ID: <87wnkg0wv7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira,

On Mon, Dec 06 2021 at 17:54, Ira Weiny wrote:
> On Thu, Nov 25, 2021 at 03:12:47PM +0100, Thomas Gleixner wrote:
>> > +.macro __call_ext_ptregs cfunc annotate_retpoline_safe:req
>> > +#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
>> > +	/* add space for extended_pt_regs */
>> > +	subq    $EXTENDED_PT_REGS_SIZE, %rsp
>> > +#endif
>> > +	.if \annotate_retpoline_safe == 1
>> > +		ANNOTATE_RETPOLINE_SAFE
>> > +	.endif
>> 
>> This annotation is new and nowhere mentioned why it is part of this
>> patch.
>
> I don't understand.  ANNOTATE_RETPOLINE_SAFE has been around since:
>
> 9e0e3c5130e9 x86/speculation, objtool: Annotate indirect calls/jumps
> for objtool

Sorry, I misread that macro maze. It's conditional obviously.

> I can split it if you prefer.  How about a patch with just the x86 extended
> pt_regs stuff but that would leave a zero size for the extended stuff?  Then
> followed by the pks bits?

Whatever makes sense and does one thing per patch.

>> I really have to ask the question whether this #ifdeffery has any value
>> at all. 8 bytes extra stack usage is not going to be the end of the
>> world and distro kernels will enable that config anyway.
>
> My goal with this has always been 0 overhead if turned off.  So this seemed
> like a logical addition.  Furthermore, ARCH_ENABLE_SUPERVISOR_PKEYS is
> predicated on ARCH_HAS_SUPERVISOR_PKEYS which is only available with x86_64.
> This removes the space for x86 when not needed.

The question is not about 64 vs. 32bit. The question is whether the
conditional makes sense for 64bit in the first place. Whether this
matters for 32bit has to be determined. It makes some sense, but less
#ifdeffery and less obfuscation makes sense too.

>> If we really want to save the space then certainly not by sprinkling
>> CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS all over the place and hiding the
>> extra sized ptregs in the pkrs header.
>> 
>> You are changing generic architecture code so you better think about
>> making such a change generic and extensible.
>
> I agree.  And I tried to do so.  The generic entry code is modified only by the
> addition of pkrs_[save|restore]_irq().  These are only defined if the arch
> defines ARCH_HAS_SUPERVISOR_PKEYS and furthermore, if something triggers
> enabling ARCH_ENABLE_SUPERVISOR_PKEYS.

I'm talking about generic _architecture_ code, i.e. the code in
arch/x86/ which affects all vendors and systems.

> ARCH_HAS_SUPERVISOR_PKEYS is restricted to x86_64 at the moment.  All other
> arch's including x86 should not see any changes in the generic code.

That was not the question and I'm well aware of that.

>> If the next feature comes around which needs to save something in that
>> extended area then we are going to change the world again, right?
>
> I'm not sure what you mean by 'change the world'.  I would anticipate the entry
> code to be modified with something similar to pks_[save|restore]_irq() and let
> the arch deal with the specifics.

If on X86 the next X86 specific feature comes around which needs extra
reg space then someone has to change world in arch/x86 again, replace
all the ARCH_ENABLE_SUPERVISOR_PKEYS #ifdefs with something else, right?

Instead of adding a new field to pt_regs_aux and be done with it.

> Also in [1] I thought Peter and Andy agreed that placing additional generic
> state in the extended pt_regs was not needed and does not buy us anything.  I
> specifically asked if that was something we wanted to do in.[2]

This was about a generic representation which affects the common entry
code in kernel/entry/... Can you spot the difference?

What I suggested is _solely_ x86 specific and does not trickle into
anything outside of arch/x86.

>> See? No magic hardcoded constant, no build time error checking for that
>> constant. Nothing, it just works.
>
> Yes agreed definitely an improvement.

It's the right thing to do.

>> That's one part, but let me come back to this:
>> 
>> > +#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
>> > +	/* add space for extended_pt_regs */
>> > +	subq    $EXTENDED_PT_REGS_SIZE, %rsp
>> 
>> What guarantees that RSP points to pt_regs at this point?  Nothing at
>> all. It's just pure luck and a question of time until this explodes in
>> hard to diagnose ways.
>
> It took me a bit to wrap my head around what I think you mean.  My initial
> response was that rsp should be the stack pointer for __call_ext_ptregs() just
> like it was for call.  But I think I see that it is better to open code this
> since others may want to play the same trick without using this code and
> therefore we may not be getting the extended pt_regs structure on the stack
> like we think.  For example if someone did...
>
> 	movq	%rsp, %rdi
> 	RSP_ADD_OTHER_STACK_STUFF
> 	__call_ext_ptregs	...
> 	RSP_REMOVE_OTHER_STACK_STUFF
>
> ... it would be broken.
>
> My assumption was that would be illegal after this patch.  But indeed there is
> no way to easily see that in the future.

There is no law which forbids to put code there. Aside of that software
developmemnt is strictly not based on assumptions by definition.

>> Because between
>> 
>>         movq	%rsp, %rdi
>> and
>>         call    ....
>> 
>> can legitimately be other code which causes the stack pointer to
>> change. It's not the case today, but nothing prevents this in the
>> future.
>> 
>> The correct thing to do is:
>> 
>>         movq	%rsp, %rdi
>>         RSP_MAKE_PT_REGS_AUX_SPACE
>>         call	...
>>         RSP_REMOVE_PT_REGS_AUX_SPACE
>> 
>> The few extra macro lines in the actual code are way better as they make
>> it completely obvious what's going on and any misuse can be spotted
>> easily.
>
> Sure FWIW this is what I had originally but thought it would be cleaner to wrap
> the 'call'.  I will convert it back.  Also this removes the
> annotate_retpoline_safe stuff above.

It makes the whole ifdeffery more palatable. Hiding everything in
hideous macros in not an improvement at all.

>> > +#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
>> > +/*
>> > + * PKRS is a per-logical-processor MSR which overlays additional protection for
>> > + * pages which have been mapped with a protection key.
>> > + *
>> > + * Context switches save the MSR in the task struct thus taking that value to
>> > + * other processors if necessary.
>> > + *
>> > + * To protect against exceptions having access to this memory save the current
>> > + * thread value and set the PKRS value to be used during the exception.
>> > + */
>> > +void pkrs_save_irq(struct pt_regs *regs)
>> 
>> That's a misnomer as this is invoked for _any_ exception not just
>> interrupts.
>
> I'm confused by the naming in kernel/entry/common.c then.  I'm more than
> willing to change the name.  But I only see irq* for almost everything in that
> file.  And I was trying to follow that convention.

Do you see anything named irq* in the NMI parts?

>> >  #ifdef CONFIG_XEN_PV
>> >  #ifndef CONFIG_PREEMPTION
>> >  /*
>> > @@ -309,6 +361,8 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
>> >  
>> >  	inhcall = get_and_clear_inhcall();
>> >  	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
>> > +		/* Normally called by irqentry_exit, restore pkrs here */
>> > +		pkrs_restore_irq(regs);
>> > 		irqentry_exit_cond_resched();
>> 
>> Sigh. Consistency is overrated....
>
> I'm not that familiar with the xen code so perhaps I missed something?

Yes, taste. And that has nothing to do with being familiar with XEN code.

>> > +		/* Normally called by irqentry_exit, restore pkrs here */
>> > +		pkrs_restore_irq(regs);
>> > 		irqentry_exit_cond_resched();

Your comment says: Normally called by irqentry_exit

Alone writing this comment should have made you look into the invoked
function below:

 		irqentry_exit_cond_resched();

And because the generic entry code is pretty consequent about naming
conventions it's not a surprise that you can find an invocation of
irqentry_exit_cond_resched() in irqentry_exit(), right?

So instead of writing 'Normally' which is completely confusing you could
have done a proper analysis and figured out what I suggested:

>> Though, if you look at the xen_pv_evtchn_do_upcall() part where you
>> added this extra invocation you might figure out that adding
>> pkrs_restore_irq() to irqentry_exit_cond_resched() and explicitely to
>> the 'else' path in irqentry_exit() makes it magically consistent for
>> both use cases.

But because your preference seems to be have random naming conventions,
i.e. chosing the prefix of the day, I'm not that surprised.

> Thank you, yes good catch.  However, I think I need at least 1 more
> call in the !regs_irqs_disabled() && state.exit_rcu case right?

I take this as a rethorical question.

>> > +done:
>> > +	pkrs_save_irq(regs);
>> 
>> This still calls out into instrumentable code. I explained you before
>> why this is wrong. Also objtool emits warnings to that effect if you do a
>> proper verified build.
>
> I was not sure what a 'proper verified build' was and objtool was not throwing
> any warnings for me even if I ran it directly.
...
> After asking around and digging quite a bit I found CONFIG_DEBUG_ENTRY which
> enabled the check and the error.

May I ask the obvious question why you did not ask around when I told
you the same thing several month ago?

Seriously, you are changing code which has very obviously placed
'noinstr' annotations on functions and a boat load of very obvious
instrumentation_begin()/end() pairs in it along with a gazillion of
comments and you just go and add your stuff as you can see fit?

Even _after_ I told you that this is wrong?

The word "engineering" has a meaning. Engineering is based on math and
science. Both mandate structured and diligent problem analyis.

Can you pretty please explain me how ignoring these annotations in the
first place and then ignoring the related review comments is related to
that?

> [But only during a build and not with the above command???  Shouldn't
> the above command work too?]

Did you even try to figure out what CONFIG_DEBUG_ENTRY does?

# git grep -l CONFIG_DEBUG_ENTRY

and looking at the resulting output which has one very obvious named
file in it:

     include/linux/instrumentation.h

might have told you the answer. Also

# git log ...
# git blame ...
# your_favourite_browser https://duckduckgo.com/?q=objtool+noinstr
# your_favourite_browser https://duckduckgo.com/?q=objtool+CONFIG_DEBUG_ENTRY

aside of asking colleagues or replying to my previous review comment
with a sensible question would have solved that, right?

Asking does not make you look stupid. Not asking and making uninformed
assumptions will make you look stupid for sure.

But asking just to avoid homework is not in the book either. The
community does not have the capacity to deal with that.

> Regardless, reading more about noinstr and looking at the code more carefully I
> realize I _completely_ misunderstood what you meant before in [3].  I should
> have asked for clarification.

Bingo!

> Yes this was originally marked noinstr because it was called from a noinstr
> function.  I see now, or at least I think I see, that you were taking exception
> to my blindly marking pkrs_save_irq() noinstr without a good reason.
>
> When you said 'there is absolutely no reason to have this marked noinstr.'  I
> thought that meant we could simply remove it from noinstr.  But what I think
> you meant is that there is no reason to have it _be_ noinstr _and_ I should
> also make it called from the instrumentable sections of the irqentry_*() calls.
>
> So something like this patch on top of this series?  [With an equivalent change
> for pkrs_restore_irq().]

No comment. Why?

   1) This is not an basic enginering course

   2) Because I refuse to comment on hastily cobbled together crap which still
      gets it wrong. Hint:

      I did not even look at the result of this patch applied.  I just
      did a mental inventory based on the patch hunks you provided.
      They simply do not sum up.

      Don't dare to ask me why.

Thanks,

        tglx




