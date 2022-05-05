Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC2651B755
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 07:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243226AbiEEFIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 01:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiEEFIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 01:08:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D925F36174
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 22:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9470AB82B79
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2B8C385AC;
        Thu,  5 May 2022 05:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651727087;
        bh=JdN3zDO4dj3t7OPhPCs+YNC0AJuQ2IsUuVlmCRPStU4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iTcZRR1vooI5FXN7x9t09oy3eNbyztkSzg6Rg5zSMsP7TO6taaKQoF2bHEZ26qcEs
         +qq8qfy133ZkWgOCgEkYzg5HBW6fLiiCPDd4jkUWxXHabzEq+1b3mImZImnFqshsHP
         9prBoyW7YhIcmxRlwBl4LAYtgMLERi0cps6BIvGIc7ySiiDeXV2eUppUZeVxhUqqdE
         XKuIrS0/OLvM9NOGOW8BgxTmiz7BdPm1SPpTHYc3hv08hY2SijaKO2Jmct0nIvFO5v
         hEsDBAmy8G8B6/kaNCtXWK2VE1mTyZhRw34A7mX/eKJgPYmKbqF8Q2SDtxEjSlxc2H
         GGZOksrK11XqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F3AC15C038D; Wed,  4 May 2022 22:04:44 -0700 (PDT)
Date:   Wed, 4 May 2022 22:04:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Wait for mutex to become unlocked
Message-ID: <20220505050444.GA3738810@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YnLzrGlBNCmCPLmS@casper.infradead.org>
 <87pmksj0ah.ffs@tglx>
 <YnMcdmx9ZwHcxTYe@casper.infradead.org>
 <87k0b0ixv6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0b0ixv6.ffs@tglx>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 03:14:53AM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 01:38, Matthew Wilcox wrote:
> > On Thu, May 05, 2022 at 02:22:30AM +0200, Thomas Gleixner wrote:
> >> > That is, rwsem_wait_read() puts the thread on the rwsem's wait queue,
> >> > and wakes it up without giving it the lock.  Now this thread will never
> >> > be able to block any thread that tries to acquire mmap_sem for write.
> >> 
> >> Never?
> >> 
> >>  	if (down_read_trylock(&vma->sem)) {
> >> 
> >> ---> preemption by writer
> >
> > Ah!  This is a different semaphore.  Yes, it can be preempted while
> > holding the VMA rwsem and block a thread which is trying to modify the
> > VMA which will then block all threads from faulting _on that VMA_,
> > but it won't affect page faults on any other VMA.
> 
> Ooops. Missed that detail. Too many semaphores here.
> 
> > It's only Better, not Best (the Best approach was proposed on Monday
> > afternoon, and the other MM developers asked us to only go as far as
> > Better and see if that was good enough).
> 
> :)
> 
> >> The information gathered from /proc/pid/smaps is unreliable at the point
> >> where the lock is dropped already today. So it does not make a
> >> difference whether the VMAs have a 'read me if you really think it's
> >> useful' sideband information which gets updated when the VMA changes and
> >> allows to do:
> >
> > Mmm.  I'm not sure that we want to maintain the smaps information on
> > the off chance that somebody wants to query it.
> 
> Fair enough, but then the question is whether it's more reasonable to
> document that if you want to read that nonsense, then you have to live
> with the consequences. The problem with many of those interfaces is that
> they have been added for whatever reasons, became ABI and people are
> suddenly making performance claims which might not be justified at all.
> 
> We really have to make our mind up and make decisions whether we want to
> solve every "I want a pony" complaint just because.
> 
> >> But looking at the stuff which gets recomputed and reevaluated in that
> >> proc/smaps code this makes a lot of sense, because most if not all of
> >> this information is already known at the point where the VMA is modified
> >> while holding mmap_sem for useful reasons, no?
> >
> > I suspect the only way to know is to try to implement it, and then
> > benchmark it.
> 
> Sure. There are other ways than having a RCU protected info, e.g. a
> sequence count which ensures that the to be read information is
> consistent.

So the thought is to maintain the /proc/smaps information separately,
so that it can just be read out, correct?  If so...

As you say, sequence counts can check consistency, but something else
is required to protect any dereferences of pointers to data that might
be freed.  One approach is to place the /proc/smaps information somewhere
that cannot be freed during /proc/smaps scan.  The place that comes
immediately to mind is the mm_struct, but I suspect that the /proc/smaps
information will need to be variable length, especially on 64-bit systems.

Another approach is to allocate space for the /proc/smaps information
dynamically, using RCU to protect only reads of only that information.
But you seem to be thinking of something else.  Or maybe your point is
that the use of RCU can be restricted to this /proc/smaps information?

Yet another approach is to use reference counts, but of course the counts
need to live outside of the structure being protected.  If the summary
information is not to block expansion of the address space (which is
the asked-for pony), this gets tricky due to the need to quickly and
repeatedly enlarge the memory holding the /proc/smaps information.

Or am I missing a trick here?

							Thanx, Paul
