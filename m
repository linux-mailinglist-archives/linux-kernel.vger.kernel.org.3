Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B3A51B49D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiEEA0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 20:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiEEA0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 20:26:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83755418F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 17:22:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651710151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQX/yGqOrNtAiv8c6VVWkhD3MpwFQE6ubjan3C8pBjA=;
        b=qE9sI66f07H+FJHWJUq89EnPFvjktmbfFHlqnDmfKoQYlyY6Xru63QyKRQj/zDGCNQ2Cja
        wHNhAxFZwkk7fVS1KPnEmAS/gGzYLpXs3tjLVt9TEjNtC25gDNVd0KN0o0rL65PFpFYVu/
        NdN0HFjSW3lNhCXSXS38Rubp00QvR7LW0AVC8SnoTNIC3NdpGw33E3RK3XNKgGZ+bu4Z6T
        PaQCFyYaykuDAI6X3/S1/ecL2Vviey08T4vayDmm47Tse6ZoD1Rs4OF6RdkIbIRkhBQtBc
        zphAFEhc5XhsC8LkZ5wO70amLoEpy3Hf5fyS6BX7UA33BfluY+gPX6R1XsP9aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651710151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQX/yGqOrNtAiv8c6VVWkhD3MpwFQE6ubjan3C8pBjA=;
        b=HdqMIHAFqpNh4x48lnYKsQm758zUPyXBLExVqtHifcxGWhWSK5i/JW/8r1BkVjhiVwPvTp
        9q29YAeybp7qnHDw==
To:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Wait for mutex to become unlocked
In-Reply-To: <YnLzrGlBNCmCPLmS@casper.infradead.org>
References: <YnLzrGlBNCmCPLmS@casper.infradead.org>
Date:   Thu, 05 May 2022 02:22:30 +0200
Message-ID: <87pmksj0ah.ffs@tglx>
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

On Wed, May 04 2022 at 22:44, Matthew Wilcox wrote:
> The customer has a low priority task which wants to read /proc/pid/smaps
> of a higher priority task.  Today, everything is awful; smaps acquires
> mmap_sem read-only, is preempted, then the high-pri task calls mmap()
> and the down_write(mmap_sem) blocks on the low-pri task.  Then all the
> other threads in the high-pri task block on the mmap_sem as they take
> page faults because we don't want writers to starve.

Welcome to the wonderful world of priority inversion.

> So this is Good.  For the vast majority of cases, we avoid taking the
> mmap read lock and the problem will appear much less often.  But we can
> do Better with a new API.  You see, for this case, we don't actually
> want to acquire the mmap_sem; we're happy to spin a bit, but there's no
> point in spinning waiting for the writer to finish when we can sleep.
> I'd like to write this code:
>
> again:
> 	rcu_read_lock();
> 	vma = vma_lookup();
> 	if (down_read_trylock(&vma->sem)) {
> 		rcu_read_unlock();
> 	} else {
> 		rcu_read_unlock();
> 		rwsem_wait_read(&mm->mmap_sem);
> 		goto again;
> 	}
>
> That is, rwsem_wait_read() puts the thread on the rwsem's wait queue,
> and wakes it up without giving it the lock.  Now this thread will never
> be able to block any thread that tries to acquire mmap_sem for write.

Never?

 	if (down_read_trylock(&vma->sem)) {

---> preemption by writer

The writer will still block and depending on the rest of the runnable
threads it can take quite a while until the low prio reader comes back
on a CPU.

I grant you that the propability will decrease, but 'never' is just
wishful thinking.

> Similarly, it may make sense to add rwsem_wait_write() and mutex_wait().
> Perhaps also mutex_wait_killable() and mutex_wait_interruptible()
> (the combinatoric explosion is a bit messy; I don't know that it makes
> sense to do the _nested, _io variants).
>
> Does any of this make sense?

TBH, no.

If we start opening this can of worms, then we'll see tons of "customer
want's a pony" problems being solved by half baken "solutions" which
will exactly cause the combinatoric explosion you are worried about.

If there is a legitimate requirement to retrieve such information, then
we are better off thinking about a general approach of introspection,
which makes such information available as unreliable snapshots
retrievable with RCU protection.

The information gathered from /proc/pid/smaps is unreliable at the point
where the lock is dropped already today. So it does not make a
difference whether the VMAs have a 'read me if you really think it's
useful' sideband information which gets updated when the VMA changes and
allows to do:

 	rcu_read_lock();
 	vma = vma_lookup();
        if (vma)
                dump(vma->info);
        rcu_read_unlock();

You still need to decide, whether you want to provide that information
or not for a particular interface, but that's way more sane than the
'make locking more complex for questionable value' approach.

But looking at the stuff which gets recomputed and reevaluated in that
proc/smaps code this makes a lot of sense, because most if not all of
this information is already known at the point where the VMA is modified
while holding mmap_sem for useful reasons, no?

So no, we don't want to add more magic locking functions which pretend
to solve unsolvable problems. We rather go and make use of information
which is already available by providing a less archaic access mechanism.

What you are trying to do here is just adding to technical debt IMNSHO.

Thanks,

        tglx
