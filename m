Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C0F512482
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiD0VaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbiD0V3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:29:55 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1901F33
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:26:42 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id k12so5329839lfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+9BgCLXHbeWpmBOpdfCxNpyEHK2KyPfJRn/+PbO09g=;
        b=0/9eFLMTnzPeh07nzfzeQ4Ny8tJHi1SQnWexNoZyyad8CMIFjDtEPu0CcOGYWM2/no
         ynhTLRwZ2sccEVBNfn5MlO+9huMmQM81KoyfIxMme4ejWxtK8NL3RpxyYNxF+NZOt2D+
         DazuCHGqbQAfn9xVQgd6OBEudJesuT+oRN8jqW2u3XyRHJmsOhDBDcwy/XTnUSeUVsrT
         Rss0m4stzFn3DMkGCw9lHYXcsGFQqFvPynVr0BS09aEQOPbgfWaTYKsDzuhms8vdpqQC
         WbTz5KeYaxvqgjXlXm8C9xI4MK3qIB/rB1qTWGJbdqDos5/UO3UdEKmfj/1og92vqapU
         FpGg==
X-Gm-Message-State: AOAM531cSOYggq3KGZfFA8TllkQadojLDubJexZ020N6JXlzOUTdoKOV
        QYffs7RhPROLZIwTImWH3TYUiWsz+EeqqmQHGms=
X-Google-Smtp-Source: ABdhPJz9BxsWaar/c7rbtNapHExukLF22U20zxQE+Ob9Bd20W+1SU4zTghfDeuoTXOTrw+UhZOsMwZrk3EDTi0C6z10=
X-Received: by 2002:a19:c511:0:b0:471:fc54:8a5 with SMTP id
 w17-20020a19c511000000b00471fc5408a5mr16224229lfe.454.1651094800875; Wed, 27
 Apr 2022 14:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220427155241.26410-1-dave@stgolabs.net>
In-Reply-To: <20220427155241.26410-1-dave@stgolabs.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Apr 2022 14:26:29 -0700
Message-ID: <CAM9d7ciQnUcefR-hLBHSDhu6zZovxXvGYW-CdSBiub_GAOfAiA@mail.gmail.com>
Subject: Re: [PATCH] locking/rwsem: Teach contention tracing about optimistic spinning
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

On Wed, Apr 27, 2022 at 9:04 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> Similar to the mutex counterpart, we can further distinguish the
> types of contention. Similarly this patch also introduces potentially
> various _begin() tracepoints with a single respective _end().

Thanks for doing this.  I was thinking about it as well.

>
> - The original _begin() for down_write() is moved further up,
> right after we know optimistic spinning is bust.
>
> - For the scenario that spins after setting the hand-off bit and
> failing to grab the lock the code is change to duplicate the
> rwsem_try_write_lock() upon a OWNER_NULL, which minimizes the
> amounts of _begin() in the wait-loop - but also gets rid of a
> goto label and the logic is pretty encapsulated in the branch.
> In such cases the common case will be to acquire the lock,
> but if it is stolen in that window, this path won't see the
> signal_pending() now in the iteration and block. This should
> be benign as the check will come in after waking if the lock
> can still not be taken.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> rtmutexes' top waiter will also do optimitic spinning, but
> I don't think it is worth adding tracepoints here as it
> is quite minimal, unlike the osq stuff.
>
>  include/trace/events/lock.h |  4 +++-
>  kernel/locking/rwsem.c      | 29 +++++++++++++++++++++--------
>  2 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
> index 9ebd081e057e..0f68a3e69a9f 100644
> --- a/include/trace/events/lock.h
> +++ b/include/trace/events/lock.h
> @@ -15,6 +15,7 @@
>  #define LCB_F_RT       (1U << 3)
>  #define LCB_F_PERCPU   (1U << 4)
>  #define LCB_F_MUTEX    (1U << 5)
> +#define LCB_F_RWSEM    (1U << 6)
>
>
>  #ifdef CONFIG_LOCKDEP
> @@ -115,7 +116,8 @@ TRACE_EVENT(contention_begin,
>                                 { LCB_F_WRITE,          "WRITE" },
>                                 { LCB_F_RT,             "RT" },
>                                 { LCB_F_PERCPU,         "PERCPU" },
> -                               { LCB_F_MUTEX,          "MUTEX" }
> +                               { LCB_F_MUTEX,          "MUTEX" },
> +                               { LCB_F_RWSEM,          "RWSEM" }
>                           ))
>  );

Well I'm ok with this but it'd be better if we can do this
without adding a new flag.  Originally a mutex can be
identified with 0, and a rwsem with either of READ or WRITE.

The MUTEX flag was added to note optimistic spins
on mutex and now we need something similar for
rwsem.  Then can we change the MUTEX to OPTIMISTIC
if it's not too late?

>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 9d1db4a54d34..c38f990cacea 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1057,7 +1057,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>         if (!wake_q_empty(&wake_q))
>                 wake_up_q(&wake_q);
>
> -       trace_contention_begin(sem, LCB_F_READ);
> +       trace_contention_begin(sem, LCB_F_RWSEM | LCB_F_READ);
>
>         /* wait to be given the lock */
>         for (;;) {
> @@ -1101,9 +1101,14 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>         DEFINE_WAKE_Q(wake_q);
>
>         /* do optimistic spinning and steal lock if possible */
> -       if (rwsem_can_spin_on_owner(sem) && rwsem_optimistic_spin(sem)) {
> -               /* rwsem_optimistic_spin() implies ACQUIRE on success */
> -               return sem;
> +       if (rwsem_can_spin_on_owner(sem)) {
> +               trace_contention_begin(sem,
> +                                      LCB_F_RWSEM | LCB_F_WRITE | LCB_F_SPIN);
> +               if (rwsem_optimistic_spin(sem)) {
> +                       /* rwsem_optimistic_spin() implies ACQUIRE on success */
> +                       trace_contention_end(sem, 0);
> +                       return sem;
> +               }
>         }
>
>         /*
> @@ -1115,6 +1120,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>         waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
>         waiter.handoff_set = false;
>
> +       trace_contention_begin(sem, LCB_F_RWSEM | LCB_F_WRITE);
> +
>         raw_spin_lock_irq(&sem->wait_lock);
>         rwsem_add_waiter(sem, &waiter);
>
> @@ -1137,7 +1144,6 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>
>         /* wait until we successfully acquire the lock */
>         set_current_state(state);
> -       trace_contention_begin(sem, LCB_F_WRITE);
>
>         for (;;) {
>                 if (rwsem_try_write_lock(sem, &waiter)) {
> @@ -1161,18 +1167,25 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>                 if (waiter.handoff_set) {
>                         enum owner_state owner_state;
>
> +                       trace_contention_begin(sem, LCB_F_RWSEM |
> +                                              LCB_F_WRITE | LCB_F_SPIN);
>                         preempt_disable();
>                         owner_state = rwsem_spin_on_owner(sem);
>                         preempt_enable();
>
> -                       if (owner_state == OWNER_NULL)
> -                               goto trylock_again;
> +                       if (owner_state == OWNER_NULL) {
> +                               raw_spin_lock_irq(&sem->wait_lock);
> +                               if (rwsem_try_write_lock(sem, &waiter))
> +                                       break;
> +                               raw_spin_unlock_irq(&sem->wait_lock);
> +                       }
> +
> +                       trace_contention_begin(sem, LCB_F_RWSEM | LCB_F_WRITE);

I'm afraid that it'd generate many contention_begin
trace events for a single lock acquisition.

Thanks,
Namhyung

>                 }
>
>                 schedule();
>                 lockevent_inc(rwsem_sleep_writer);
>                 set_current_state(state);
> -trylock_again:
>                 raw_spin_lock_irq(&sem->wait_lock);
>         }
>         __set_current_state(TASK_RUNNING);
> --
> 2.36.0
>
