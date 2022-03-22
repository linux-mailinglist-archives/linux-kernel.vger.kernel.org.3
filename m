Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC64E4948
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbiCVWo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238183AbiCVWov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:44:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD775DA49
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:43:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647988999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JiesVq6IcwsewSPf9oFwMhZoa9eRiQyNKVJThYCN4hI=;
        b=CJIAzv0++gPb36W7qLRpMDIny0u5hh8WDg2Y7SU9wpCh0cZy6KSfrVMoAyGrH9T9IVzUxC
        eI4j9SKs6E827vjQFbCYGMRjPMjCEPso8DiT7x9eVoge/w6jsS+QzAO8eCJ7eobVsjD4/B
        NrFntu1RhWfUv1urKIsZwezuuQ5qDVBv73wnPi92qRPzpz60q7zfsnVFMsAp3ST/G51N3N
        6BUZ8rIxYa428h77Ok+3ok8hKGOWBq07fcFx9LPddfUWW2e7UmUnT3irngAFJy+Q5CLUXN
        sxRZMFtEJD6yFrjSFrrduuWylC9RkzKy75ulwfM6zAvRbt5S0fIxY0DIMZklGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647988999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JiesVq6IcwsewSPf9oFwMhZoa9eRiQyNKVJThYCN4hI=;
        b=2KyBMKpTYljwZYQ6Uqv4VriNPsf6SZJpUuzeo+CkWIrMqzkS5aDbQrjyQIqQPwh7yygnV3
        jJmJE6+xdGEPKCBQ==
To:     Michal Hocko <mhocko@suse.com>
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
In-Reply-To: <Yjn7FXoXtgGT977T@dhcp22.suse.cz>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz>
 <20220322004231.rwmnbjpq4ms6fnbi@offworld>
 <c8bb0b6d-981c-8591-d5b6-17414c934758@redhat.com>
 <20220322025724.j3japdo5qocwgchz@offworld>
 <YjmITBkkwsa2O4bg@dhcp22.suse.cz> <87bkxyaufi.ffs@tglx>
 <Yjn7FXoXtgGT977T@dhcp22.suse.cz>
Date:   Tue, 22 Mar 2022 23:43:18 +0100
Message-ID: <87zglha9rt.ffs@tglx>
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

Michal,

On Tue, Mar 22 2022 at 17:36, Michal Hocko wrote:
> On Tue 22-03-22 16:17:05, Thomas Gleixner wrote:
>> The task::robust_list pointer is set unconditionally by NPTL for every
>> thread of a process. It points to the 'list head' which is in the
>> TLS. But this does not tell whether the task holds a robust futex or
>> not. That's evaluated in the futex exit handling code.
>> 
>> So solution #1 will prevent oom reaping completely simply because the
>> pointer is set on every user space task.
>
> This is really what I was worried about.
>
>> Solutions #2 and #3 are incomplete and just awful hacks which cure one
>> particular case: A single threaded process. Why?
>> 
>> The chosen oom reaper victim is a process, so what does it help to check
>> or cleanup the robust list for _ONE_ thread? Nothing because the other
>> threads can hold robust futexes and then run into the same problem.
>> 
>> Aside of that you seem to believe that the robust list head in the TLS
>> is the only part which is relevant. That's wrong. The list head is
>> either NULL or points to the innermost pthread_mutex which is held by a
>> task. Now look at this example:
>> 
>>   TLS:robust_list -> mutex2 -> mutex1
>> 
>> mutex1 is the shared one which needs to be released so that other
>> processes can make progress. mutex2 is a process private one which
>> resides in a different VMA. So now if you filter the robust list and
>> refuse to reap the TLS VMA, what prevents the other VMA from being
>> reaped? If that's reaped then mutex1 is not reachable.
>> 
>> Now vs. cleaning up the robust list from the oom reaper context. That
>> should be doable with a lot of care, but the proposed patch is not even
>> close to a solution. It's simply broken.
>
> My knowledge about robust futexes and how they are implemented is close
> to zero. My thinking has been that the primary reason for the lockup
> reported initially is that the oom_reaper will corrupt the memory which
> is backing the list of locks to be woken up. So if we rule out the
> oom_reaper for that memory then the exit path can do its proper cleanup.
> Is that assumption completely off?

All the kernel knows is which VMA contains a robust list head. But it
does not know where the actual futexes/mutexes reside which might be
held by a task. Here is the lock chain example again:

      TLS:robust_list -> mutex2 -> mutex1
VMA   Known              Unknown   Shared

So if TLS and mutex2 sit in two different VMAs and the mutex2 VMA gets
reaped then mutex1 cannot be reached anymore, which in consequence means
that it cannot be cleaned up.

> I cannot really comment on the futex specific parts of your response but
> the deadlock on the mmap_lock has been already pointed out, thanks for
> confirming that.

It just occured to me that doing the cleanup from a kernel thread is
completely broken vs. PI futexes, which are also cleaned up by
futex_cleanup().

The PI exit cleanup code _cannot_ be handled by a foreign task at
all. It will nicely explode in the rtmutex code when it tries to release
the kernel side rtmutex which represents the held and contended user
space futex.

Cleaning up futexes from a kthread is not going to work at least not
without creating yet another pile of horrible hacks in the futex and
rtmutex code. We have enough of them already, so no.

Just for the case that someone thinks we make that a special case for
non-PI futexes: No, that's not going to happen.

> [...]
>
>> But the real questions here are:
>> 
>>    Why are we doing this remote reaping at all?
>
> Does aac453635549 ("mm, oom: introduce oom reaper") help? In short this
> is to guarantee that the system is able to make a forward progress under
> OOM. Sending SIGKILL to the oom victim is not sufficient, really. Tasks
> can be blocked inside kernel for indefinite amount of time. E.g. being
> blocked waiting on memory transitively over locks. Reclaiming the
> anonymous memory from the killed process will allow to free up some
> memory while the oom victim is blocked and allow to move forward and
> eventually die and do the proper cleanup. We are focusing on the
> anonymous memory because under assumption that such a memory is private
> to the process and the process is dead so the a freed memory is not
> really visible any more.

Which is correct. But then you have to bite the bullet and accept that
the futexes cannot be recovered.

>>    What is the condition that a task which is killed with a fatal signal
>>    does not reach do_exit() and cleans up itself?
>> 
>> If the answer is "because", then we should rather make sure that this
>> gets fixed.
>
> While some places can be handled by changing uninterruptible waiting to
> killable there are places which are not really fixable, e.g. lock
> chain dependency which leads to memory allocation.

I'm not following. Which lock chain dependency causes memory allocation?

Also aren't oom killed tasks allowed to allocate from emergency buffers
in order to clean themself up? That's at least what the comments in the
oom code claim.

Aside of that. Do you have call chains which show in which situation
such a stuck task is?

>> If there is a legitimate reason why a task cannot handle a fatal signal,
>> then yes the oom reaper might be necessary, but unleashing the oom
>> reaper unconditionally is simply a bad idea and results in the problem
>> which this is trying to paper over.
>> 
>> The oom reaper should be the last resort IMO and not racing against the
>> killed task in the first place. IOW, give the task some time to clean
>> itself up and if that fails and it is truly stuck and unable to do so,
>> then reap the mm. But that should be the rare case and then the stuck
>> futex should be the least of our worries.
>
> Yes, the oom_reaper is the last resort indeed. It is true that it can
> fire later but I do not see how this would solve this particular
> problem.

Well, it at least solves the problem which is described in the
changelog. Because that problem clearly is a race between the woken up
oom reaper and the task which killed itself in #PF due to OOM.

Of course it won't solve the problem of tasks which are stuck forever.

But right now the oom reaper thread is immediately woken after sending
SIGKILL and the same is true if the oom killer targets a process which
is already exiting.

IOW, the current implementation is enforcing the race of the oom reaper
vs. the exiting and/or killed process. With a quite high probability the
reaper is going to win.

You can easily validate that by doing:

wake_oom_reaper(task)
   task->reap_time = jiffies + HZ;
   queue_task(task);
   wakeup(reaper);

and then:

oom_reap_task(task)
    now = READ_ONCE(jiffies);
    if (time_before(now, task->reap_time)
        schedule_timeout_idle(task->reap_time - now);

before trying to actually reap the mm.

That will prevent the enforced race in most cases and allow the exiting
and/or killed processes to cleanup themself. Not pretty, but it should
reduce the chance of the reaper to win the race with the exiting and/or
killed process significantly.

It's not going to work when the problem is combined with a heavy VM
overload situation which keeps a guest (or one/some it's vCPUs) away
from being scheduled. See below for a discussion of guarantees.

If it failed to do so when the sleep returns, then you still can reap
it.

> It is fundamentally wrong to reap the memory which the exit path
> really need to do a proper clean up.

Depends on the guarantees you make. If you say preventing OOM starvation
at the end is more important than a stale futex, then it's fine as long
as it is properly documented.

That said, the robust list is no guarantee. It's a best effort approach
which works well most of the time at least for the "normal" issues where
a task holding a futex dies unexpectedly. But there is no guarantee that
it works under all circumstances, e.g. OOM.

Sorry Nico, but your understanding

>> On Mon, Mar 21 2022 at 21:09, Nico Pache wrote:
>> From my understanding, the whole point of the robust futex is to allow forward
>> progress in an application in which the lock holder CAN
>> crash/exit/oom.

is based on wishful thinking. There is absolutely no guarantee made by
robust futexes. Why?

Because the kernel can neither make a guarantee vs. user space
controlled content nor vs. dealing with user space stupidity, e.g. a
runaway memory hog.

This is _NOT_ what robust list is about. Robust list was introduced to
handle the unfortunate case where a task holding a futex dies
unexpectedly.

Extending this to OOM and expecting it to work under all circumstances
is really wishful thinking.

>> So semantically nothing is wrong with killing the futex holder... the
>> whole point of the robustness is to handle these cases.

Wrong. The whole point of robust lists is to handle the "normal" case
gracefully. A process being OOM killed is _NOT_ in the "normal"
category.

Neither is it "normal" that a VM is scheduled out long enough to miss a
1 second deadline. That might be considered normal by cloud folks, but
that's absolute not normal from an OS POV. Again, that's not a OS
problem, that's an operator/admin problem.

>> We just have a case were the oom killer is racing with said handling
>> of the futex, invalidating the memory before the exit path
>> (handle_futex_death) can awake one of the other waiters.

That case is just a symptom of the overall problem and no, we are not
curing symptoms. Especially not by introducing problems which did not
exist before the "cure".

If the kernel has only the choice of making no progress at all or
leaving a stale futex around occasionally, then the latter is an
unfortunate collateral damage, but not the end of the world.

The enforced race of the oom reaper is not a collateral damage, that's
simply stupid. And that's the root cause for the particular symptom.
which needs be addressed exactly there and nowhere else.

If that does not cover _all_ corner cases, then so be it. You _cannot_
solve that problem completely ever.

As I said above there is a final choice between not making progress at
all and a rare stale futex. It's not rocket science to pick the right
one.

> And just to be clear, this is clearly a bug in the oom_reaper per se.
> Originally I thought that relaxing the locking (using trylock and
> retry/bail out on failure) would help but as I've learned earlier this
> day this is not really possible because of #PF at least. The most self
> contained solution would be to skip over vmas which are backing the
> robust list which would allow the regular exit path to do the proper
> cleanup.

That's not sufficient because you have to guarantee that the relevant
shared futex is accessible. See the lock chain example above.

OTOH, in combination with delaying the reaper skipping the VMAs, which
contain a robust list head, might be good enough for the trivial
cases where the shared futex is the one to which the robust list head
points to.

Emphasis on VMAs. You need to evaluate every tasks robust list pointer
of the process not only the one of the task which gets queued for
reaping.

So let me summarize what I think needs to be done in priority order:

 #1 Delay the oom reaper so the normal case of a process being able to
    exit is not subject to a pointless race to death.

 #2 If #1 does not result in the desired outcome, reap the mm (which is
    what we have now).

 #3 If it's expected that #2 will allow the stuck process to make
    progress on the way towards cleanup, then do not reap any VMA
    containing a robust list head of a thread which belongs to the
    exiting and/or killed process.

The remaining cases, i.e. the lock chain example I pointed out above or
the stuck forever task are going to be rare and fall under the
collateral damage and no guarantee rule.

Thanks,

        tglx
---
P.S.: I so hoped that after my first encounter with the oom killer
      almost two decades ago I wouldn't have to deal with this horror
      again. Bah!
