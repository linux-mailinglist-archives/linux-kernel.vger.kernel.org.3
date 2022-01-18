Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47024492D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347923AbiARSTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbiARSTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:19:35 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E735AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:19:34 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso7956275wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymA96POx7OAMmW1ydSmB8m63CErrci0k2daMxmKxHLw=;
        b=opiJT9YotMmWMjh0/nlFBblGocf0iSIc/SpEzsthxCGN+lAKizExQvm/lcaLi2Vcup
         VOAxpFdrfjWhuZX3RY51AXSFho+Y6HJCCU0KwkDqDeVQAMWQfMx6puOrrBJbQOCp5rTd
         FwAc2wIh+qEOFJkIKb8CeZCOyPOP/YQfY7pJjNbXDgYo6ONo9eD5wQu8HFzmYsph9YR0
         D5r/Fm92M7gBedDsFHKNYElWL8iC/xq4HaY3AeAJl9PWFd2V6R4cYUg9ECA/FOcp7r5D
         KDIdy155Qi7Ly5MpeoMe3ASzDDqxmfdrjLZfFL3c0bJynqo0koONJg1F5RwXDULnNUgv
         CnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymA96POx7OAMmW1ydSmB8m63CErrci0k2daMxmKxHLw=;
        b=TlUOW9DFNTYIr6vnyvNbOQR1x7f5WEL1HYU0sgJaDVfHY7e7RfdRZxBSnIgcuo4RqX
         71OQOlpuo+YnwAUnQdNRHRbBhadxVN/UMnOJKu7RbYuY9CkByQs3erITKOwZ3QQXsgpX
         qcltS5s7xM1AXh9a3ax1x4baYw3xdQXrUppMLjRIMDRqdWI2xTW4JPJNKECLoCQevbSo
         TTYA7qkNb4AvjnhirCvqGXCX7qhnMqzcKppEFKVNgW91qj23ybhVM/c2IO2/NPnotoZ+
         a3KsBsijwbfGklvx1j/CD13Azj1dOzpbKCvi/4bYFGw4LfF4C8tX3nEMWCoxZp7yg3eo
         mBUw==
X-Gm-Message-State: AOAM530MWO+ayCp6x1oHVU2d33qPt7rT3/YlQr+to/cuypEkBiTBevMs
        RrD8SqccGpQ2mlQZtOxRCjBEhThIOGyax47Tg1vWKQ==
X-Google-Smtp-Source: ABdhPJwYObsKEXcS6tbwGdn6fFMoy5RjNlLSnajzPCDzzsax/GqZnWXZjQO3dYtvj0E/XwuQ4TkkKQoiSHUghcz2SW0=
X-Received: by 2002:a05:600c:22da:: with SMTP id 26mr33853966wmg.121.1642529973194;
 Tue, 18 Jan 2022 10:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20211214204445.665580974@infradead.org> <20211214205358.701701555@infradead.org>
 <20211221171900.GA580323@dev-hv> <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
 <YeaRx9oDp08ABvyU@hirez.programming.kicks-ass.net>
In-Reply-To: <YeaRx9oDp08ABvyU@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 18 Jan 2022 10:19:21 -0800
Message-ID: <CAPNVh5cdGiDqut90kUo-HXyya6Nbz_CjuUObYXfprgDhQHnUmg@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@posk.io>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 2:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 14, 2022 at 03:09:55PM +0100, Peter Zijlstra wrote:
> > On Tue, Dec 21, 2021 at 05:19:00PM +0000, Peter Oskolkov wrote:
>
> > > What does worry me is that in this wakeup the server calls sys_umcg_wait()
> > > with another worker in next_tid, so now the server will have two
> > > workers running: the current kernel API seems to allow this to happen.
> > > In my patchset the invariant that no more than one worker running
> > > per server was enforced by the kernel.
> >
> > So one of the things I've started, but didn't finished, is to forward
> > port the Proxy-Execution patches to a current kernel and play with the
> > PE+UMCG interaction.
> >
> > Thinking about that interaction I've ran into that exact problem.
> >
> > The 'nice' solution is to actually block the worker, but that's also the
> > slow solution :/
> >
> > The other solution seems to be to keep kernel state; track the current
> > worker associated with the server. I haven't (so far) done that due to
> > my futex trauma.
> >
> > So yes, the current API can be used to do the wrong thing, but the
> > kernel doesn't care and you get to keep the pieces in userspace. And I
> > much prefer user pieces over kernel pieces.
>
> So I think I came up with a 3rd option; since the TID range is 30 bits
> (per FUTEX_TID_MASK) we have those same two top bits to play with.
>
> So we write into server::next_tid the tid of the worker we want to wake;
> and we currently have it cleared such that we can distinguish between
> the case where sys_umcg_wait() returned an error before or after waking
> it.
>
> However; we can use one of the 2 remaining bits to indicate the worker
> is woken, let's say bit 31. This then has server::next_tid always
> containing the current tid, even when the server has a 'spurious' wakeup
> for other things.
>
> Then all we need to do is modify the state check when the bit is set to
> ensure we don't wake the worker again if we race sys_umcg_wait() with a
> worker blocking.
>
> A bit like this, I suppose... (incompete patch in that it relies on a
> whole pile of local changes that might or might not live).
>
> --- a/include/uapi/linux/umcg.h
> +++ b/include/uapi/linux/umcg.h
> @@ -94,6 +94,8 @@ struct umcg_task {
>          */
>         __u32   state;                          /* r/w */
>
> +#define UMCG_TID_RUNNING       0x80000000U
> +#define UMCG_TID_MASK          0x3fffffffU
>         /**
>          * @next_tid: the TID of the UMCG task that should be context-switched
>          *            into in sys_umcg_wait(). Can be zero, in which case
> --- a/kernel/sched/umcg.c
> +++ b/kernel/sched/umcg.c
> @@ -20,7 +20,7 @@ static struct task_struct *umcg_get_task
>
>         if (tid) {
>                 rcu_read_lock();
> -               tsk = find_task_by_vpid(tid);
> +               tsk = find_task_by_vpid(tid & UMCG_TID_MASK);
>                 if (tsk && current->mm == tsk->mm && tsk->umcg_task)
>                         get_task_struct(tsk);
>                 else
> @@ -289,27 +291,6 @@ static int umcg_wake_task(struct task_st
>         return 0;
>  }
>
> -static int umcg_wake_next(struct task_struct *tsk)
> -{
> -       int ret = umcg_wake_task(tsk->umcg_next, tsk->umcg_next_task);
> -       if (ret)
> -               return ret;
> -
> -       /*
> -        * If userspace sets umcg_task::next_tid, it needs to remove
> -        * that task from the ready-queue to avoid another server
> -        * selecting it. However, that also means it needs to put it
> -        * back in case it went unused.
> -        *
> -        * By clearing the field on use, userspace can detect this case
> -        * and DTRT.
> -        */
> -       if (put_user(0u, &tsk->umcg_task->next_tid))
> -               return -EFAULT;
> -
> -       return 0;
> -}
> -
>  static int umcg_wake_server(struct task_struct *tsk)
>  {
>         int ret = umcg_wake_task(tsk->umcg_server, tsk->umcg_server_task);
> @@ -637,6 +599,48 @@ SYSCALL_DEFINE2(umcg_kick, u32, flags, p
>         return 0;
>  }
>
> +static int umcg_wake_next(struct task_struct *tsk, struct umcg_task __user *self)
> +{
> +       struct umcg_task __user *next_task;
> +       struct task_struct *next;
> +       u32 next_tid, state;
> +       int ret;
> +
> +       if (get_user(next_tid, &self->next_tid))
> +               return -EFAULT;
> +
> +       next = umcg_get_task(next_tid);
> +       if (!next)
> +               return -ESRCH;
> +
> +       next_task = READ_ONCE(next->umcg_task);
> +
> +       if (next_tid & UMCG_TID_RUNNING) {
> +               ret = -EFAULT;
> +               if (get_user(state, &next_task->state))
> +                       goto put_next;
> +
> +               ret = 0;
> +               if ((state & UMCG_TASK_MASK) != UMCG_TASK_RUNNING)
> +                       ret = -EAGAIN;
> +
> +       } else {
> +               ret = umcg_wake_task(next, next_task);
> +               if (ret)
> +                       goto put_next;
> +
> +               ret = -EFAULT;
> +               if (put_user(next_tid | UMCG_TID_RUNNING, &self->next_tid))
> +                       goto put_next;
> +
> +               ret = 0;
> +       }
> +
> +put_next:
> +       put_task_struct(next);
> +       return ret;
> +}
> +
>  /**
>   * sys_umcg_wait: transfer running context
>   *
>
>
> And once we have this, we can add sanity checks that server::next_tid is
> what it should be for ever worker moving away from RUNNING state (which
> depends on the assumption that all threads are in the same PID
> namespace).
>
>
> Does this make sense?

This is a long reply, touching several active discussion topics:

- cooperative userspace scheduling
- next_tid in workers
- worker timeouts
- signals and the general approach

=========== cooperative userspace scheduling

I think an important question to clear is about having worker timeouts
and worker-to-worker context switches (next_tid in workers). These are
actually fundamental, core features of cooperative user-space
scheduling. Yes, if UMCG is viewed simply as enabling what currently
exists in the kernel to be done in the userspace, then yes, worker
timeouts and worker.next_tid seem unneeded, and a runqueue per server,
with a single RUNNING worker per runqueue, makes the most natural
approach, the one that is taken in this new and improved patchset.

However, our experience of running many production workloads with
inprocess userspace scheduling over the last ~8 years indicate that
cooperative userspace scheduling features, built on top of
worker-to-worker context switches (with timeouts), are equally
important in driving performance gains and adoption.

============= worker-to-worker context switches

One example: absl::Mutex (https://abseil.io/about/design/mutex) has
google-internal extensions that are "fiber aware". More specifically,
consider this situation:

- worker W1 acqured the mutex and is doing its work
- worker W2 calls mutex::lock()
  mutex::lock(), being aware of workers, understands that W2 is going to sleep;
  so instead of just doing so, waking the server, and letting
  the server figure out what to run in place of the sleeping worker,
mutex::lock()
  calls into the userspace scheduler in the context of W2 running, and the
  userspace scheduler then picks W3 to run and does W2->W3 context switch.

The optimization above replaces W2->Server and Server->W3 context switches
with a single W2->W3 context switch, which is a material performance gain.

In addition, when W1 calls mutex::unlock(), the scheduling code determines
that W2 is waiting on the mutex, and thus calls W2::wake() from the context of
running W1 (you asked earlier why do we need "WAKE_ONLY").

There are several other similar "cooperative" worker-to-worker context switches
used in "handcrafted" userspace synchronization primitives, the most obvious
is a producer-consumer queue: the producer (W1) prepares an item or several,
and context-switches to the consumer (W2) for the latter to consume the items.

If the producer has more items to produce, it will call W2::wake() instead of
context-switching into it.

I hope the above discussion explains why worker-to-worker context switches,
as well as workers waking another workers, are useful/needed.

================ worker timeouts

Timeouts now are easy to explain: mutex::lock() and condvar::wait() have
timeouts, so workers waiting on these primitives naturally wait with timeouts;
if sys_umcg_wait() supports worker timeouts, this is it, all is simple; if
it does not, the userspace now has to implement the whole timeout machinery,
in order to wake these sleeping workers when their timeouts expire.

=========== signals and the general approach

My version of the patchset has all of these things working. What it
does not have,
compared to the new approach we are discussing here, is runqueues per server
and proper signal handling (and potential integration with proxy execution).

Runqueues per server, in the LAZY mode, are easy to emulate in my patchset:
nothing prevents the userspace to partition workers among servers, and have
servers that "own" their workers to be pointed at by idle_server_tid_ptr.

The only thing that is missing is proper treating of signals. But my patchset
does ensure a single running worker per server, had pagefaults and preemptions
sorted out, etc. Basically, everything works except signals. This patchet
has issues with pagefaults, worker timeouts, worker-to-worker context
switches (do workers move runqueues when they context switch?), etc.

And my patchset now actually looks smaller and simpler, on the kernel side,
that what this patchset is shaping up to be.

What if I fix signals in my patchset? I think the way you deal with signals
will work in my approach equally well; I'll also use umcg_kick() to preempt
workers instead of sending them a signal.

What do you think? If signals work in my patchset, why this new approach has
that my version does not?

Thanks,
Peter
