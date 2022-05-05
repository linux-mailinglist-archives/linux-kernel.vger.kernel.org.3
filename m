Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0867D51B524
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbiEEBSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiEEBSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:18:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E67515AD
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:14:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651713293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n17gGihYsOZ1CbJmH63jbnw4kqj3EjuV+qmxB3T5Ge8=;
        b=TlsZwi0uyF1NKkZHplRBpBaz//Z6mpYb/w41WUZ7NR5PBbb2kD6MbtA8H8J3hBd6ihWmYJ
        kVWzLZRrMilIWKwUE/N7L2dRFP1lsyZbMAYUN7VZC/PmgBKyD4WIKLsBJkqSJJl7eJMl5g
        Rby+GikSXrxli4EImKAm10RGKPsqz+8o+4iA3xvWmOA+H1tJ7T8Es32WQ6xnS956ilmrhJ
        c/i049M0vBbzgVoHIOwPu5O+tZRDhHWm7oZaygcEI28IXDQoFkCR0ts9hz6QSI3QLcBKol
        T/8mhplso+jUD4APEA/ROK/FuIFf4JzJh/GlBgkzry5eSeKGpDDCQ1glMH/pGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651713293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n17gGihYsOZ1CbJmH63jbnw4kqj3EjuV+qmxB3T5Ge8=;
        b=47Xv4gfd6yiM8vnmcngpfAz5X6za6e5419uh7iVLImO157Whj5mLkYSC6aLePokOZcqbEm
        HFLN8pxeB6MjnODQ==
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Wait for mutex to become unlocked
In-Reply-To: <YnMcdmx9ZwHcxTYe@casper.infradead.org>
References: <YnLzrGlBNCmCPLmS@casper.infradead.org> <87pmksj0ah.ffs@tglx>
 <YnMcdmx9ZwHcxTYe@casper.infradead.org>
Date:   Thu, 05 May 2022 03:14:53 +0200
Message-ID: <87k0b0ixv6.ffs@tglx>
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

On Thu, May 05 2022 at 01:38, Matthew Wilcox wrote:
> On Thu, May 05, 2022 at 02:22:30AM +0200, Thomas Gleixner wrote:
>> > That is, rwsem_wait_read() puts the thread on the rwsem's wait queue,
>> > and wakes it up without giving it the lock.  Now this thread will never
>> > be able to block any thread that tries to acquire mmap_sem for write.
>> 
>> Never?
>> 
>>  	if (down_read_trylock(&vma->sem)) {
>> 
>> ---> preemption by writer
>
> Ah!  This is a different semaphore.  Yes, it can be preempted while
> holding the VMA rwsem and block a thread which is trying to modify the
> VMA which will then block all threads from faulting _on that VMA_,
> but it won't affect page faults on any other VMA.

Ooops. Missed that detail. Too many semaphores here.

> It's only Better, not Best (the Best approach was proposed on Monday
> afternoon, and the other MM developers asked us to only go as far as
> Better and see if that was good enough).

:)

>> The information gathered from /proc/pid/smaps is unreliable at the point
>> where the lock is dropped already today. So it does not make a
>> difference whether the VMAs have a 'read me if you really think it's
>> useful' sideband information which gets updated when the VMA changes and
>> allows to do:
>
> Mmm.  I'm not sure that we want to maintain the smaps information on
> the off chance that somebody wants to query it.

Fair enough, but then the question is whether it's more reasonable to
document that if you want to read that nonsense, then you have to live
with the consequences. The problem with many of those interfaces is that
they have been added for whatever reasons, became ABI and people are
suddenly making performance claims which might not be justified at all.

We really have to make our mind up and make decisions whether we want to
solve every "I want a pony" complaint just because.

>> But looking at the stuff which gets recomputed and reevaluated in that
>> proc/smaps code this makes a lot of sense, because most if not all of
>> this information is already known at the point where the VMA is modified
>> while holding mmap_sem for useful reasons, no?
>
> I suspect the only way to know is to try to implement it, and then
> benchmark it.

Sure. There are other ways than having a RCU protected info, e.g. a
sequence count which ensures that the to be read information is
consistent.

Thanks,

        tglx
