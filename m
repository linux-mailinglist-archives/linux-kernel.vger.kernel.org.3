Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D95855AE59
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 05:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbiFZCx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 22:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiFZCxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 22:53:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50965120BC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 19:53:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g26so12215355ejb.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 19:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slObHazg0D55B5zgHVSk+V2DhERWYrcDXPm8e+t3nZ4=;
        b=fXI+f48Qe88+PgAc5VxHZg4+V6ato4XCva+ABOxSY0cIjDyEdngX5rU98KiGjGhsnc
         vATuLmFoRiJ3KFd9nDbzQgsNn0nTKJI3TDuxG7rP93+of0baNqr3lVxS1wBqC21OQxhI
         0O8uz/p1DTd1OWF5Tl/EsaDOhdCkbwoNBgE8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slObHazg0D55B5zgHVSk+V2DhERWYrcDXPm8e+t3nZ4=;
        b=PYDRCHx2KnKxYgaXf4xYNc3jpDxRIAqQxTeGuFZe5l8JTz7QBGDGxRchYa5TKl4s7J
         6wJuk+Jcyd1PgHbYlqCz5ZUXi14KnDYdDXT+FzVYcItff6RN86NWA89YBHZRj0SMv//b
         k6KA96D3eqYPu57wyD3fpJsY0fGSU4qb5TuuLfpIePz8Cbc1kpsQAcSVLQOIisCZP0HG
         lbXIB//iGsnwkhLT7f/yh1+aXqqdSD/9c0lV2pHJavswOQkhi3L4YTIjVljRx0UHvChV
         POxeepf3pr+VS5budFXsn0IqE2OW4uWYZOaRDqKdtNYMjKJ41xKJkhu1WT3Ma00oNoQd
         J9hg==
X-Gm-Message-State: AJIora99l+M9UCDGGD8L4vjuhS51pjViC2xIQSR44dNuEpBPbF6TFkSK
        LxVyM7prgtdJWvYgEtDCtOsuAx/P+evEOvMG
X-Google-Smtp-Source: AGRyM1ui1AifI/NwHrx0MeT+9hJHtRp4aYT4GdPgjbZ/9+VqIXoWlBP8jRnBwXh22RM19H7Ri57b0g==
X-Received: by 2002:a17:907:a088:b0:70b:a1c5:b807 with SMTP id hu8-20020a170907a08800b0070ba1c5b807mr6310170ejc.6.1656212032433;
        Sat, 25 Jun 2022 19:53:52 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id y1-20020aa7c241000000b004355dc75066sm5030978edo.86.2022.06.25.19.53.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 19:53:51 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so3590262wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 19:53:51 -0700 (PDT)
X-Received: by 2002:a05:600c:354c:b0:39c:7e86:6ff5 with SMTP id
 i12-20020a05600c354c00b0039c7e866ff5mr11744806wmq.145.1656212031078; Sat, 25
 Jun 2022 19:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220622140853.31383-1-pmladek@suse.com> <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com> <Yre9LO2nj+Hbr67V@mtj.duckdns.org>
In-Reply-To: <Yre9LO2nj+Hbr67V@mtj.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Jun 2022 19:53:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmWUSdK7-LLjpUrH_TX78emb3ajxZ1ueT2HU0_FVJQfA@mail.gmail.com>
Message-ID: <CAHk-=wjmWUSdK7-LLjpUrH_TX78emb3ajxZ1ueT2HU0_FVJQfA@mail.gmail.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
To:     Tejun Heo <tj@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 6:58 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > They aren't "really" spurious, they are just asynchronous enough (and
> > thus unexpected) that you basically should never have a "sleep on
> > wait-queue" without then looping and re-testing the condition.
>
> Can you elaborate on this a bit? At least for the standard
> wait_event-ish wait blocks, the waiter always does finish_wait()
> before leavig a wait.

Correct.

As long as *all* you ever use is a standard wait_event thing, you are
always serialized by the spinlock on the wait queue.

However.

Very few processes only use standard wait_event things. There are a
number of places that use "wake_up_process()" which doesn't use a
wait-queue, but a wake-up directed right at a particular task.

Is that the _common_ pattern? It's not *uncommon*. It's maybe not the
strictly normal wait-queue one, but if you grep for
"wake_up_process()" you will find quite a lot of them.

And yes, many of those uses too will use strictly serialized locking:
in that both the waker and the sleeper (ie the target of the
wake_up_process()) will have serialized the target thread pointer with
some lock, exactly like the normal wait-queues serialize using the
wait-queue lock.

But several do *not* use locking, and instead rely on the
thread_struct being RCU-free'd.

In fact, I think kthread_create() itself is such an example, with that

        wake_up_process(kthreadd_task);

just doing a blind directed wakeup with no locking what-so-ever, just
a straight wake_up.

And the important thing to notice that if you have even just *one*
such user, that kthreadd_task will basically get randomyl "spuriously"
woken up while it is waiting for something else.

Now, the kthreadd_task task is kind of specialized, and that
particular wake_up_process() doesn't affect anybody else, so think of
that just as an example.

But now imagine any of the other unlocked directed wake_up_process()
users. Imagine them targeting regular user processes that may be doing
regular system calls.  Imagine that wake_up_process() being just done
under a RCU read lock, and maybe the process had already woken up
*AND* had already gone on to do entirely other things!

IOW, maybe you are now a thread that does a perfectly normal locked
wait_queue thing - but because the *previous* system call did
something that did less strictly locked things, there may be another
CPU that is still in the process of waking you up from that previous
system call. So now your "strictly locked" waitqueue usage sees a
"spurious" wakeup, because a previous not-so-stictly-locked usage had
been delayed by interrupts on another CPU.

And yes, those "wake up process under RCU read lock" really do exist.
There are literally things that take a reference to a task struct, add
it to some RCU-safe list, and then do the wakeup without locking.

> I'm probably missing sometihng. Is it about bespoke wait mechanisms?
> Can you give a concrete example of an async wakeup scenario?

Grep for wake_up_process() and just look for them/

Side note: signals end up doing effectively the same thing if you're
doing interruptible waits, of course, but people are probably more
*aware* of signals when they use TASK_INTERRUPTIBLE. But these
RCU-delayed wakeups can wake up even TASK_UNINTERRUPTIBLE calls.

Anyway, it's easy enough to deal with: use the "event" macros, and
you'll never have to worry about it.

But if you use explicit wait-queues and manual scheduling (rather than
wait_event() and friends), you need to be aware that when you go to
sleep, the fact that you woke up is *not* a guarantee that the wakeup
came from the wait queue.

So you need to always do that in a loop. The wait_event code will do
that loop for you, but if you do manual wait-queues you are required
to do the looping yourself.

> So, the deferred wakeups from earlier waits are one. Can you give some
> other examples? This is something which has always bothered me and I
> couldn't find explanations which aren't hand-wavy on my own. It'd be
> really great to have clarity.

There's a second class of "spurious" waits that aren't really spurious
at all, and aren't even deferred, and are simply due to "there were
multiple things you waited for, but you didn't even *think* about it".

The obvious one is for poll/select, but there people are aware of it.

The less obvious one is for taking a page fault or being put to sleep
and being woken up again while actively *inside* a wait loop, and
already with a wait-queue entry added.

For a historical example of *both* of those kinds of situations, take
a look at n_tty_read() in drivers/tty/n_tty.c, and in particular,
notice how the wait-loop looks something like this:

        add_wait_queue(&tty->read_wait, &wait);
        while (nr) {
                ..
        }
        ...
        remove_wait_queue(&tty->read_wait, &wait);

and *inside* the loop, you have both

 (a) locking:

                        down_read(&tty->termios_rwsem);

 (b) historically (but not any more) user space accesses

and both of those kinds mean that you actually have overlapping
lifetimes of wait-queues for the same process.

That's very much how wait-queues were always designed to work - it
solves a lot of race conditions (ie the traditional "sleep_on()" model
is broken garbage), but it means that each individual user doesn't
necessarily understand that other active wait-queues can wake up a
process *while* the code thinks about another wait-queue entirely.

IOW, when you are in the page fault code, and you are waiting for the
filesystem IO to complete, you may *also* be on that kind of
"tty->read_wait" waitqueue, and a character coming in on that tty will
wake you up.

The *filesyustem* code doesn't care about the tty wakeup, so it's very
much an example of a "spurious" wake event as far as the filesystem
code is concerned.

Similarly, when you are locking a semaphote, the only wait-queue
activity you care about at the time of the lock is the ones coming
from the unlockers, but you may get "spurious" wakeups from other
things that the process is *also* interested in.

Again, none of these are *really* spurious. They are real wakeup
events. It's just that within the *local* code they look spurious,
because the locking code, the disk IO code, whatever the code is
doesn't know or care about all the other things that process is
involved in.

And once again, it's not that different from "hey, signals can wake
you up at pretty much any time", but people *think* that because they
are doing a non-interruptible wait it is somehow "exclusive", and
don't think about all the other things that that process has been
involved in

> * If there are no true spurious wakeups, where did the racing wakeup
>   come from? The task just got created w/ TASK_NEW and woken up once
>   with wake_up_new_task(). It hasn't been on any wait queue or
>   advertised itself to anything.

I don't think it was ever a spurious wakeup at all.

The create_worker() code does:

        worker->task = kthread_create_on_node(..
        ..
        worker_attach_to_pool(worker, pool);
        ..
        wake_up_process(worker->task);

and thinks that the wake_up_process() happens after the worker_attach_to_pool().

But I don't see that at all.

The reality seems to be that the wake_up_process() is a complete
no-op, because the task was already woken up by
kthread_create_on_node().

But I dunno. I think the whole argument of

  Any kthread is supposed to stay in TASK_UNINTERRUPTIBLE sleep
  until it is explicitly woken.

was completely broken to begin with, and then the belief that there's
some spurious wakeup came from that.

But hey, that "wake_up_process(worker->task)" itself does seem spurious.

Anyway, I think this whole "spurious wakeup" is a complete red
herring. They don't "really" exist, but any code that expects some
exclusive wakeup tends to be broken code and that kind of thinking is
dangerous.

So you should *ALWAYS* write your code as if things can get random
spurious wakeups at any time. Because with various CPU hotplug events
etc, it really might happen.

But I don't think that's what's going on here. I think the workqueue
code is just confused, and should have initielized "worker->pool" much
earlier.  Because as things are now, when worker_thread() starts
running, and does that

  static int worker_thread(void *__worker)
  {
        struct worker *worker = __worker;
        struct worker_pool *pool = worker->pool;

thing, that can happen *immediately* after that

   kthread_create_on_node(worker_thread, worker,

happens. It just so happens that *normally* the create_worker() code
ends up finishing setup before the new worker has actually finished
scheduling..

No?

               Linus
