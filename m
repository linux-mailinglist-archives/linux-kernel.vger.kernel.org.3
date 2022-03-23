Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B636D4E4F08
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbiCWJTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiCWJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:18:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721C775C0A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:17:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1D1631F38C;
        Wed, 23 Mar 2022 09:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648027049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sTzm5k6PgsrzHTzlBHTIA19uuzGZi7HPfwlvgrmOapk=;
        b=ramhqc5lQ2Fss8m+WDQuwCuFBl5oYv+UMBildB/lTMj+lLBukGnFnDMIUBsmIRpv/+qmIV
        W69wsm1VleuxiOuD8CxkhoqptnA9KFlMlx73xI4+JimbVlx/e957eKjB+TAOc0ijGD+jIU
        jd6iYW/TJwNPuEfjz+zjYmznu6imQF4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B3EBAA3B83;
        Wed, 23 Mar 2022 09:17:28 +0000 (UTC)
Date:   Wed, 23 Mar 2022 10:17:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andre Almeida <andrealmeid@collabora.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit
 and the oom_reaper
Message-ID: <YjrlqAMyJg3GKZVs@dhcp22.suse.cz>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz>
 <20220322004231.rwmnbjpq4ms6fnbi@offworld>
 <c8bb0b6d-981c-8591-d5b6-17414c934758@redhat.com>
 <20220322025724.j3japdo5qocwgchz@offworld>
 <YjmITBkkwsa2O4bg@dhcp22.suse.cz>
 <87bkxyaufi.ffs@tglx>
 <Yjn7FXoXtgGT977T@dhcp22.suse.cz>
 <87zglha9rt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zglha9rt.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let me skip over futex part which I need to digest and only focus on the
oom side of the things for clarification.

On Tue 22-03-22 23:43:18, Thomas Gleixner wrote:
[...]
> > While some places can be handled by changing uninterruptible waiting to
> > killable there are places which are not really fixable, e.g. lock
> > chain dependency which leads to memory allocation.
> 
> I'm not following. Which lock chain dependency causes memory allocation?

Consider an oom victim is blocked on a lock or waiting for an event to
happen but the lock holder is stuck allocating or the wake up depends on
an allocation. Many sleeping locks are doing GFP_KERNEL allocations.
 
> Also aren't oom killed tasks allowed to allocate from emergency buffers
> in order to clean themself up? That's at least what the comments in the
> oom code claim.

Yes, this is the case. And this is a slightly easier scenario. A dip
into memory reserves could help to make a forward progress indeed. But
as mentioned above the victim can be doing something completely else.

> Aside of that. Do you have call chains which show in which situation
> such a stuck task is?

I do remember Tetsuo was really good at triggering those issues. It was
no rocket science. Essentially a memory stress test hammering FS code
and usually triggering dependencies of oom victims either on the lock or
wait queue which is stuck allocating.

I have managed to push details about specific locks or traces out of my
brain but just by a high level look and checking how many GFP_KERNEL
allocations are done from inside a mutex or semaphore which shared among
process the dependency chain is simply unavoidable.

[...]

> You can easily validate that by doing:
> 
> wake_oom_reaper(task)
>    task->reap_time = jiffies + HZ;
>    queue_task(task);
>    wakeup(reaper);
> 
> and then:
> 
> oom_reap_task(task)
>     now = READ_ONCE(jiffies);
>     if (time_before(now, task->reap_time)
>         schedule_timeout_idle(task->reap_time - now);
> 
> before trying to actually reap the mm.
> 
> That will prevent the enforced race in most cases and allow the exiting
> and/or killed processes to cleanup themself. Not pretty, but it should
> reduce the chance of the reaper to win the race with the exiting and/or
> killed process significantly.
> 
> It's not going to work when the problem is combined with a heavy VM
> overload situation which keeps a guest (or one/some it's vCPUs) away
> from being scheduled. See below for a discussion of guarantees.
> 
> If it failed to do so when the sleep returns, then you still can reap
> it.

Yes, this is certainly an option. Please note that the oom_reaper is not
the only way to trigger this. process_mrelease syscall performs the same
operation from the userspace. Arguably process_mrelease could be used
sanely/correctly because the userspace oom killer can do pro-cleanup
steps before going to final SIGKILL & process_mrelease. One way would be
to send SIGTERM in the first step and allow the victim to perform its
cleanup.

> > It is fundamentally wrong to reap the memory which the exit path
> > really need to do a proper clean up.
> 
> Depends on the guarantees you make. If you say preventing OOM starvation
> at the end is more important than a stale futex, then it's fine as long
> as it is properly documented.

Yes, this is the case we have made on process core dumps. They are
simply incomplete for oom victims. I thought that handling robust futex
lists requires some guarantees. More on that later

> That said, the robust list is no guarantee. It's a best effort approach
> which works well most of the time at least for the "normal" issues where
> a task holding a futex dies unexpectedly. But there is no guarantee that
> it works under all circumstances, e.g. OOM.

OK, so this is an important note. I am all fine by documenting this
restriction. It is not like oom victims couldn't cause other disruptions
by leaving inconsistent/stale state behind.
 
> Sorry Nico, but your understanding
> 
> >> On Mon, Mar 21 2022 at 21:09, Nico Pache wrote:
> >> From my understanding, the whole point of the robust futex is to allow forward
> >> progress in an application in which the lock holder CAN
> >> crash/exit/oom.
> 
> is based on wishful thinking. There is absolutely no guarantee made by
> robust futexes. Why?
> 
> Because the kernel can neither make a guarantee vs. user space
> controlled content nor vs. dealing with user space stupidity, e.g. a
> runaway memory hog.
> 
> This is _NOT_ what robust list is about. Robust list was introduced to
> handle the unfortunate case where a task holding a futex dies
> unexpectedly.
> 
> Extending this to OOM and expecting it to work under all circumstances
> is really wishful thinking.
> 
> >> So semantically nothing is wrong with killing the futex holder... the
> >> whole point of the robustness is to handle these cases.
> 
> Wrong. The whole point of robust lists is to handle the "normal" case
> gracefully. A process being OOM killed is _NOT_ in the "normal"
> category.
> 
> Neither is it "normal" that a VM is scheduled out long enough to miss a
> 1 second deadline. That might be considered normal by cloud folks, but
> that's absolute not normal from an OS POV. Again, that's not a OS
> problem, that's an operator/admin problem.

Thanks for this clarification. I would tend to agree. Following a
previous example that oom victims can leave inconsistent state behind
which can influence other processes. I am wondering what kind of
expectations about the lock protected state can we make when the holder
of the lock has been interrupted at any random place in the critical
section.

[...]
> > And just to be clear, this is clearly a bug in the oom_reaper per se.
> > Originally I thought that relaxing the locking (using trylock and
> > retry/bail out on failure) would help but as I've learned earlier this
> > day this is not really possible because of #PF at least. The most self
> > contained solution would be to skip over vmas which are backing the
> > robust list which would allow the regular exit path to do the proper
> > cleanup.
> 
> That's not sufficient because you have to guarantee that the relevant
> shared futex is accessible. See the lock chain example above.

Yeah, my previous understanding was that the whole linked list lives in
the single mapping and we can just look at their addresses.

> OTOH, in combination with delaying the reaper skipping the VMAs, which
> contain a robust list head, might be good enough for the trivial
> cases where the shared futex is the one to which the robust list head
> points to.
> 
> Emphasis on VMAs. You need to evaluate every tasks robust list pointer
> of the process not only the one of the task which gets queued for
> reaping.
> 
> So let me summarize what I think needs to be done in priority order:
> 
>  #1 Delay the oom reaper so the normal case of a process being able to
>     exit is not subject to a pointless race to death.
> 
>  #2 If #1 does not result in the desired outcome, reap the mm (which is
>     what we have now).
> 
>  #3 If it's expected that #2 will allow the stuck process to make
>     progress on the way towards cleanup, then do not reap any VMA
>     containing a robust list head of a thread which belongs to the
>     exiting and/or killed process.
> 
> The remaining cases, i.e. the lock chain example I pointed out above or
> the stuck forever task are going to be rare and fall under the
> collateral damage and no guarantee rule.

I do agree that delaying oom_reaper wake up is the simplest thing to do
at this stage and it could catch up most of the failures. We still have
process_mrelease syscall case but I guess we can document this as a
caveat into the man page.

Thanks!

> Thanks,
> 
>         tglx
> ---
> P.S.: I so hoped that after my first encounter with the oom killer
>       almost two decades ago I wouldn't have to deal with this horror
>       again. Bah!

heh, a nice place full of horrors and hard to see dependencies

-- 
Michal Hocko
SUSE Labs
