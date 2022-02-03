Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8454A833E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350290AbiBCLe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:34:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36304 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbiBCLe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:34:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 506936165B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7BFC340E4;
        Thu,  3 Feb 2022 11:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643888095;
        bh=7keyY+IJy3RcFl5R8fQkbTOYl6e3YcZLJhUH+euqScA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rdKZ3Kxatocr3+jRIAgDzrN3zUB7EDa1zLk+ItzxO65+eG9ugd78qADd5LzMfbMX3
         B/kf1UkkIOwSi2kJUCZnUqo1ULlEk3IgITSuiaoCCLw16ZnAN+IbY8Z+iEyvfIB6MU
         2sPrDiz9R9bjrWdJtsYiZp9MvOG6BhLCBhBxJhLbCJthwWjy1R9RjHoYsEoK2H7W+7
         eoWPgRaO4WC6U4CMBHyBjyKHVyLRqRKxn3XPKV3G/rjRqrTL+nBQu1AE7h1kKU/gXh
         dZFcAbhjOLKOY+yitkMqsv+B4sZEj84nQtTPlTI/Ld7PaM4ZGd922I81aewjuuEJ6B
         GrvFgPjhwYXRg==
Date:   Thu, 3 Feb 2022 12:34:53 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        catalin.marinas@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH 5/6] sched/preempt: add PREEMPT_DYNAMIC using static keys
Message-ID: <20220203113453.GA471778@lothringen>
References: <20211109172408.49641-1-mark.rutland@arm.com>
 <20211109172408.49641-6-mark.rutland@arm.com>
 <20220202232145.GA461279@lothringen>
 <YfulsiWkphburRNX@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfulsiWkphburRNX@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 09:51:46AM +0000, Mark Rutland wrote:
> On Thu, Feb 03, 2022 at 12:21:45AM +0100, Frederic Weisbecker wrote:
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 78c351e35fec..7710b6593c72 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -2008,7 +2008,7 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
> > >  #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
> > >  extern int __cond_resched(void);
> > >  
> > > -#ifdef CONFIG_PREEMPT_DYNAMIC
> > > +#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
> > >  
> > >  DECLARE_STATIC_CALL(cond_resched, __cond_resched);
> > >  
> > > @@ -2017,6 +2017,14 @@ static __always_inline int _cond_resched(void)
> > >  	return static_call_mod(cond_resched)();
> > >  }
> > >  
> > > +#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> > > +extern int dynamic_cond_resched(void);
> > > +
> > > +static __always_inline int _cond_resched(void)
> > > +{
> > > +	return dynamic_cond_resched();
> > 
> > So in the end this is creating an indirect call for every preemption entrypoint.
> 
> Huh? "indirect call" usually means a branch to a function pointer, and I don't
> think that's what you mean here. Do you just mean that we add a (direct)
> call+return?

Right, basic terminology and me...

> 
> This gets inlined, and will be just a direct call to dynamic_cond_resched().
> e,g. on arm64 this will be a single instruction:
> 
> 	bl	dynamic_cond_resched
> 
> ... and (as the commit message desribes) then the implementation of
> dynamic_cond_resched will be the same as the regular __cond_resched *but* the
> static key trampoline is inlined at the start, e.g.
> 
> | <dynamic_cond_resched>:
> |        bti     c
> |        b       <dynamic_cond_resched+0x10>
> |        mov     w0, #0x0                        // #0
> |        ret
> |        mrs     x0, sp_el0
> |        ldr     x0, [x0, #8]
> |        cbnz    x0, <dynamic_cond_resched+0x8>
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mov     x29, sp
> |        bl      <preempt_schedule_common>
> |        mov     w0, #0x1                        // #1
> |        ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> 
> ... compared to the regular form of the function:
> 
> | <__cond_resched>:
> |        bti     c
> |        mrs     x0, sp_el0
> |        ldr     x1, [x0, #8]
> |        cbz     x1, <__cond_resched+0x18>
> |        mov     w0, #0x0                        // #0
> |        ret
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mov     x29, sp
> |        bl      <preempt_schedule_common>
> |        mov     w0, #0x1                        // #1
> |        ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret

Who reads changelogs anyway? ;-)

Ok I didn't know about that. Is this a guaranteed behaviour everywhere?
Perhaps put a big fat comment below HAVE_PREEMPT_DYNAMIC_KEY help to tell
about this expectation as I guess it depends on arch/compiler?

Thanks.
