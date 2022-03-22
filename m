Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E5C4E42A1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbiCVPSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238338AbiCVPSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:18:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6968E88783
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:17:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647962226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B/RmtZo0sH60eCI4ygULBePvlGpEDMgKt94DgB9c9WE=;
        b=3oD0gFoRRJzNjDA09/ReGYAAXCQt+sduYoez1TPZa0oZ7Zq5yN4NuQwt+jHOPRElWg/M+G
        V1q6yyVVo10oRBJfaJelHNKtM/xeVOFPsv83AZEQnPXvrbPTBex5tfXOgdY9FkXFf1c/0v
        2yMLEmKxFtY0TdUH01m9SriWu+bOJYu3vO9pBtXyF5yF+LmHzXpeomwANGOwgfIB++MjVs
        Shwmh6ZefH4599WGihwt7dYENhHwBtMGFVcz/hhGefWr48E+WPRTHwjzbRMAVc10peBi5p
        2q5iz1P9atTo+0ZiSBC9txmTJnZUKjCMukcxVuixC9r4YpmSWt30L5t41jJ4WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647962226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B/RmtZo0sH60eCI4ygULBePvlGpEDMgKt94DgB9c9WE=;
        b=BDxJauYsqGAPm0DSLwFz/MQcQriHp2QHqnpePMHMZvrbl3zV2JrkAUTB6BqMnQuWziSUpc
        SKvHh3XxIPJKKuCw==
To:     Michal Hocko <mhocko@suse.com>, Davidlohr Bueso <dave@stgolabs.net>
Cc:     Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
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
In-Reply-To: <YjmITBkkwsa2O4bg@dhcp22.suse.cz>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz>
 <20220322004231.rwmnbjpq4ms6fnbi@offworld>
 <c8bb0b6d-981c-8591-d5b6-17414c934758@redhat.com>
 <20220322025724.j3japdo5qocwgchz@offworld>
 <YjmITBkkwsa2O4bg@dhcp22.suse.cz>
Date:   Tue, 22 Mar 2022 16:17:05 +0100
Message-ID: <87bkxyaufi.ffs@tglx>
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

On Tue, Mar 22 2022 at 09:26, Michal Hocko wrote:
> On Mon 21-03-22 19:57:24, Davidlohr Bueso wrote:
>> On Mon, 21 Mar 2022, Nico Pache wrote:
>> 
>> > We could proceed with the V3 approach; however if we are able to find a complete
>> > solution that keeps both functionalities (Concurrent OOM Reaping & Robust Futex)
>> > working, I dont see why we wouldnt go for it.

See below.

>> Because semantically killing the process is, imo, the wrong thing to do.
>
> I am not sure I follow. The task has been killed by the oom killer. All
> we are discussing here is how to preserve the robust list metadata
> stored in the memory which is normally unmapped by the oom_reaper to
> guarantee a further progress. 
>
> I can see we have 4 potential solutions:
> 1) do not oom_reap oom victims with robust futex metadata in anonymous
>    memory. Easy enough but it could lead to excessive oom killing in
>    case the victim gets stuck in the kernel and cannot terminate.
> 2) clean up robust list from the oom_reaper context. Seems tricky due to
>    #PF handling from the oom_reaper context which would need to be
>    non-blocking
> 3) filter vmas which contain robust list. Simple check for the vma
>    range
> 4) internally mark vmas which have to preserve the state during
>    oom_reaping. Futex code would somehow have to mark those mappings.
>    While more generic solution. I am not sure this is a practical
>    approach. 

And all of that is based on wishful thinking, really. Let me explain.

The task::robust_list pointer is set unconditionally by NPTL for every
thread of a process. It points to the 'list head' which is in the
TLS. But this does not tell whether the task holds a robust futex or
not. That's evaluated in the futex exit handling code.

So solution #1 will prevent oom reaping completely simply because the
pointer is set on every user space task.

Solutions #2 and #3 are incomplete and just awful hacks which cure one
particular case: A single threaded process. Why?

The chosen oom reaper victim is a process, so what does it help to check
or cleanup the robust list for _ONE_ thread? Nothing because the other
threads can hold robust futexes and then run into the same problem.

Aside of that you seem to believe that the robust list head in the TLS
is the only part which is relevant. That's wrong. The list head is
either NULL or points to the innermost pthread_mutex which is held by a
task. Now look at this example:

  TLS:robust_list -> mutex2 -> mutex1

mutex1 is the shared one which needs to be released so that other
processes can make progress. mutex2 is a process private one which
resides in a different VMA. So now if you filter the robust list and
refuse to reap the TLS VMA, what prevents the other VMA from being
reaped? If that's reaped then mutex1 is not reachable.

Now vs. cleaning up the robust list from the oom reaper context. That
should be doable with a lot of care, but the proposed patch is not even
close to a solution. It's simply broken.

> -static void futex_cleanup_begin(struct task_struct *tsk)
> +static bool futex_cleanup_begin(struct task_struct *tsk, bool try)
>  {
>  	/*
>  	 * Prevent various race issues against a concurrent incoming waiter
> @@ -1055,7 +1056,12 @@ static void futex_cleanup_begin(struct task_struct *tsk)
>  	 * tsk->futex_exit_mutex when it observes FUTEX_STATE_EXITING in
>  	 * attach_to_pi_owner().
>  	 */
> -	mutex_lock(&tsk->futex_exit_mutex);
> +	if (try) {
> +		if (!mutex_trylock(&tsk->futex_exit_mutex))
> +			return false;
> +	} else {
> +		mutex_lock(&tsk->futex_exit_mutex);
> +	}

That conditional locking is disgusting.
  
>  void futex_exit_release(struct task_struct *tsk)
>  {
> -	futex_cleanup_begin(tsk);
> +	futex_cleanup_begin(tsk, false);

If the task already cleaned up the robust list then this will roll back
tsk->futex_state from FUTEX_STATE_DEAD to FUTEX_STATE_EXITING. Sigh...

> +	futex_cleanup(tsk);
> +	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
> +}
> +
> +/* Try to perform the futex_cleanup and return true if successful.

This is not a proper multi line comment.

     /*
      * Multi line comments look like this:
      *
      * Properly formatted.
      *
      * Don't try to use the network comment style
      * on anything outside of networking.
      */

> + * Designed to be called from the context of the OOM Reaper.

Let's talk about design later.

> + */
> +bool try_futex_exit_release(struct task_struct *tsk)
> +{
> +	if (!futex_cleanup_begin(tsk, true))
> +		return false;
> +
> +	/* We are calling this from the context of a kthread. We need to
> +	 * instruct the kthread to use the address space of the given mm
> +	 * so the get_user won't return -EFAULT.

How is this preventing get_user() or any other operation on the tasks
user memory to return -EFAULT? Not at all. Any user access can fail and
return -EFAULT. Comments are there to explain things not to create
confusion.

> +	 */
> +	kthread_use_mm(tsk->mm);
>  	futex_cleanup(tsk);

But aside of that. How is this supposed to work correctly?

oom_reaper()
  oom_reap_task()
    oom_reap_task_mm()
      mmap_read_trylock(mm) <- Succeeds
        try_futex_exit_release()
          use_mm()
          futex_cleanup()
            get_user() -> #PF

#PF
  if (!mmap_read_trylock(mm)) {

So here the problem starts. The trylock can succeed or not, depending
on the contention state of mm::mmap_lock.

So in case the trylock fails because there is a writer waiting, then it
runs into this:

     if (!user_mode(regs) && !search_exception_tables(regs->ip)) {
        ....
        return;
     }

This condition evaluates to false because get_user() has an
exception table entry. So this proceeds and does:
     
     mmap_read_lock(mm);

which is a full dead lock.

But even if the trylock succeeds then this runs into the full fault
path, which is not correct either for pretty obvious reasons.

I assume that's all part of the design, right?

But the real questions here are:

   Why are we doing this remote reaping at all?

   What is the condition that a task which is killed with a fatal signal
   does not reach do_exit() and cleans up itself?

If the answer is "because", then we should rather make sure that this
gets fixed.

If there is a legitimate reason why a task cannot handle a fatal signal,
then yes the oom reaper might be necessary, but unleashing the oom
reaper unconditionally is simply a bad idea and results in the problem
which this is trying to paper over.

The oom reaper should be the last resort IMO and not racing against the
killed task in the first place. IOW, give the task some time to clean
itself up and if that fails and it is truly stuck and unable to do so,
then reap the mm. But that should be the rare case and then the stuck
futex should be the least of our worries.

Thanks,

        tglx
