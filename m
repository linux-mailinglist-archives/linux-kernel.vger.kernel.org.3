Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C5358A4F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 05:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiHEDRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 23:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiHEDRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 23:17:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC6517E24
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 20:17:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c22so811856wmr.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 20:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aVq+Uw9OUo5rWBIpSnIUxD2I4qDruCnKm/4q8SLPLo8=;
        b=cXPzqD2NWfwMvPn4tU93oeAvP/AtuIexAm9jv0cF+4slV62YNPfLKCakAr1V+gxJcf
         d7pkgIN8mzRKu96wOsIaqXHc20NKdyo3hZXKlt3EckDs3kmz/ayECV3m/J8VjGdifcGN
         FoZv2npkhc/2EvChm3YCJM6Wg5hv54MA5+anCy/XQwbHvr7BBHSXq5U16aKO0A720ppN
         e7cgaycT+hOvyzf59rc1atXuoYQZya89PiNS5a3JMBrUWMOB4ki9O1kSdC0hv6x+v7iS
         U5n8Z/6szTT4Wm2/vTEIdxqJAiy/W3kCdkABbmuzUVjQwfSMRczSHZEHO04ztAEBtjsa
         1ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aVq+Uw9OUo5rWBIpSnIUxD2I4qDruCnKm/4q8SLPLo8=;
        b=1XFPBN86fPRBLqT76LDf9Ou6kfT4RCUGHK3cWsM9IJTU6e1uuODBeqkTYWjzBAFGX8
         Y+RZ+gvctgo30gPNyqzc8q5Pi8o85XTOvDEEu7W2+i3slL6qbAa/h+auXo6z06IRALi8
         XUp5+nSM/fg7iOjfkGmEQOVeRyaUWxir9neT0BKLs5l4wQXROgOla9VhGPAEhtxzHUsx
         bRnEL+F58gNHRfKSFd6DitDelxE9GioTOp/WQf4mKf9S1XzW0dsRdA3Y4gwBr54oKytn
         qIsdUwz8bMY3PFBHRxUbfhBlMuJPd2Sf8poy+KYcMKHpFJJtX++GZht6FqMZjtfIgvMy
         kdKA==
X-Gm-Message-State: ACgBeo1iQbVPQOFNfBM18GEMxMzU1pC5NHECrotU7YdSj3E0MM+9btcR
        P230+KS6ITzRjn6DPO7nN45RR7X3v5mEPGtWI84=
X-Google-Smtp-Source: AA6agR5nimbOsbid32haBcyOYMU4oW9XIH7kxAGaSk7tziugp+czop2z1O8XHR1kDGhWugy50FUvt5VXNctyr+FhXq0=
X-Received: by 2002:a05:600c:3847:b0:3a3:5333:8bcd with SMTP id
 s7-20020a05600c384700b003a353338bcdmr3161807wmr.36.1659669430975; Thu, 04 Aug
 2022 20:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220802084146.3922640-1-vschneid@redhat.com> <20220802084146.3922640-3-vschneid@redhat.com>
In-Reply-To: <20220802084146.3922640-3-vschneid@redhat.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 5 Aug 2022 11:16:59 +0800
Message-ID: <CAJhGHyAzoa5Mb7cHd8oxbWOfgsGEt-8afTTVdjOWY8sgHY0Mcg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/3] workqueue: Unbind workers before sending them
 to exit()
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 4:42 PM Valentin Schneider <vschneid@redhat.com> wrote:
>
> It has been reported that isolated CPUs can suffer from interference due to
> per-CPU kworkers waking up just to die.
>
> A surge of workqueue activity during initial setup of a latency-sensitive
> application (refresh_vm_stats() being one of the culprits) can cause extra
> per-CPU kworkers to be spawned. Then, said latency-sensitive task can be
> running merrily on an isolated CPU only to be interrupted sometime later by
> a kworker marked for death (cf. IDLE_WORKER_TIMEOUT, 5 minutes after last
> kworker activity).
>
> Prevent this by affining kworkers to the wq_unbound_cpumask (which doesn't
> contain isolated CPUs, cf. HK_TYPE_WQ) before waking them up after marking
> them with WORKER_DIE.
>
> Changing the affinity does require a sleepable context, so get rid of the
> pool->idle_timer and use a delayed_work instead. Ensure kworkers do not
> free their resources before the new kworker reaper has handled them by
> introducing a new struct worker.reaper field - this new field fills in a 4
> byte hole in the second cacheline of struct worker.
>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/workqueue.c          | 155 +++++++++++++++++++++++++++++-------
>  kernel/workqueue_internal.h |   1 +
>  2 files changed, 126 insertions(+), 30 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 97cc41430a76..28cd58c684ee 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -167,9 +167,9 @@ struct worker_pool {
>         int                     nr_workers;     /* L: total number of workers */
>         int                     nr_idle;        /* L: currently idle workers */
>
> -       struct list_head        idle_list;      /* L: list of idle workers */
> -       struct timer_list       idle_timer;     /* L: worker idle timeout */
> -       struct timer_list       mayday_timer;   /* L: SOS timer for workers */
> +       struct list_head        idle_list;        /* L: list of idle workers */
> +       struct delayed_work     idle_reaper_work; /* L: worker idle timeout */
> +       struct timer_list       mayday_timer;     /* L: SOS timer for workers */
>
>         /* a workers is either on busy_hash or idle_list, or the manager */
>         DECLARE_HASHTABLE(busy_hash, BUSY_WORKER_HASH_ORDER);
> @@ -1806,8 +1806,10 @@ static void worker_enter_idle(struct worker *worker)
>         /* idle_list is LIFO */
>         list_add(&worker->entry, &pool->idle_list);
>
> -       if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
> -               mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
> +       if (too_many_workers(pool) && !delayed_work_pending(&pool->idle_reaper_work))
> +               mod_delayed_work(system_unbound_wq,
> +                                &pool->idle_reaper_work,
> +                                IDLE_WORKER_TIMEOUT);
>
>         /* Sanity check nr_running. */
>         WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && pool->nr_running);
> @@ -1972,9 +1974,72 @@ static struct worker *create_worker(struct worker_pool *pool)
>         return NULL;
>  }
>
> +static void unbind_worker(struct worker *worker)
> +{
> +       lockdep_assert_held(&wq_pool_mutex);
> +
> +       kthread_set_per_cpu(worker->task, -1);
> +       if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
> +               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
> +       else
> +               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
> +}
> +
> +static void rebind_worker(struct worker *worker, struct worker_pool *pool)
> +{
> +       kthread_set_per_cpu(worker->task, pool->cpu);
> +       WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
> +}
> +
> +static void reap_workers(struct list_head *reaplist)
> +{
> +       struct worker *worker, *tmp;
> +
> +       list_for_each_entry_safe(worker, tmp, reaplist, entry) {
> +               list_del_init(&worker->entry);
> +               unbind_worker(worker);
> +
> +               /*
> +                * If the worker was somehow already running, then it had to be
> +                * in pool->idle_list when destroy_worker() happened or we
> +                * wouldn't have gotten here.
> +                *
> +                * Thus, the worker must either have observed the WORKER_DIE
> +                * flag, or have set its state to TASK_IDLE. Either way, the
> +                * below will be observed by the worker and is safe to do
> +                * outside of pool->lock.
> +                */
> +               WRITE_ONCE(worker->reaped, true);
> +               wake_up_process(worker->task);
> +       }
> +}
> +
> +/*
> + * Unlikely as it may be, a worker could wake after destroy_worker() has
> + * happened but before reap_workers(). WORKER_DIE would be set in worker->flags,
> + * so it would be able to kfree(worker) and head out to do_exit().
> + *
> + * Rather than make the reaper wait for each to-be-reaped kworker to exit and
> + * kfree(worker) itself, make the kworkers (which have nothing to do but go
> + * do_exit() anyway) wait for the reaper to be done with them.
> + */
> +static void worker_wait_reaped(struct worker *worker)
> +{
> +       WARN_ON_ONCE(current != worker->task);
> +
> +       for (;;) {
> +               set_current_state(TASK_INTERRUPTIBLE);
> +               if (READ_ONCE(worker->reaped))
> +                       break;
> +               schedule();
> +       }
> +       __set_current_state(TASK_RUNNING);
> +}


It is not a good idea to add this scheduler-ist code here.

Using wq_pool_attach_mutex to protects the whole body of idle_reaper_fn()
can stop the worker from freeing itself since the worker has to
get the mutex before exiting.

And I don't think batching destruction is a good idea since
it is not a hot path.

> +
>  /**
>   * destroy_worker - destroy a workqueue worker
>   * @worker: worker to be destroyed
> + * @list: transfer worker away from its pool->idle_list and into list
>   *
>   * Destroy @worker and adjust @pool stats accordingly.  The worker should
>   * be idle.
> @@ -1982,7 +2047,7 @@ static struct worker *create_worker(struct worker_pool *pool)
>   * CONTEXT:
>   * raw_spin_lock_irq(pool->lock).
>   */
> -static void destroy_worker(struct worker *worker)
> +static void destroy_worker(struct worker *worker, struct list_head *list)
>  {
>         struct worker_pool *pool = worker->pool;
>
> @@ -1997,34 +2062,64 @@ static void destroy_worker(struct worker *worker)
>         pool->nr_workers--;
>         pool->nr_idle--;
>
> -       list_del_init(&worker->entry);
>         worker->flags |= WORKER_DIE;
> -       wake_up_process(worker->task);
> +
> +       list_move(&worker->entry, list);
>  }
>
> -static void idle_worker_timeout(struct timer_list *t)
> +/**
> + * idle_reaper_fn - reap workers that have been idle for too long.
> + *
> + * Unbinding marked-for-destruction workers requires a sleepable context, as
> + * changing a task's affinity is not an atomic operation, and we don't want
> + * to disturb isolated CPUs IDLE_WORKER_TIMEOUT in the future just for a kworker
> + * to do_exit().
> + *
> + * Percpu kworkers should meet the conditions for the affinity change to not
> + * block (not migration-disabled and not running), but there is no *hard*
> + * guarantee that they are not running when we get here.
> + *
> + * The delayed_work is only ever modified under raw_spin_lock_irq(pool->lock).
> + */
> +static void idle_reaper_fn(struct work_struct *work)
>  {
> -       struct worker_pool *pool = from_timer(pool, t, idle_timer);
> +       struct delayed_work *dwork = to_delayed_work(work);
> +       struct worker_pool *pool = container_of(dwork, struct worker_pool, idle_reaper_work);
> +       struct list_head reaplist;
> +       struct worker *worker;
> +
> +       INIT_LIST_HEAD(&reaplist);
>
>         raw_spin_lock_irq(&pool->lock);
>
>         while (too_many_workers(pool)) {
> -               struct worker *worker;
>                 unsigned long expires;
> +               unsigned long now = jiffies;
>
>                 /* idle_list is kept in LIFO order, check the last one */
>                 worker = list_entry(pool->idle_list.prev, struct worker, entry);
>                 expires = worker->last_active + IDLE_WORKER_TIMEOUT;
>
> -               if (time_before(jiffies, expires)) {
> -                       mod_timer(&pool->idle_timer, expires);
> +               /*
> +                * Careful: queueing a work item from here can and will cause a
> +                * self-deadlock when dealing with an unbound pool. However,
> +                * here the delay *cannot* be zero and *has* to be in the
> +                * future, which works.
> +                */
> +               if (time_before(now, expires)) {

IMHO, using raw_spin_unlock_irq(&pool->lock) here is better than
violating locking rules *overtly* and documenting that it can not be
really violated. But It would bring a "goto" statement.

> +                       mod_delayed_work(system_unbound_wq,
> +                                        &pool->idle_reaper_work,
> +                                        expires - now);
>                         break;
>                 }
>
> -               destroy_worker(worker);
> +               destroy_worker(worker, &reaplist);
>         }
> -
>         raw_spin_unlock_irq(&pool->lock);
> +
> +       mutex_lock(&wq_pool_mutex);
> +       reap_workers(&reaplist);
> +       mutex_unlock(&wq_pool_mutex);
>  }
>
>  static void send_mayday(struct work_struct *work)
> @@ -2388,6 +2483,9 @@ static int worker_thread(void *__worker)
>         /* am I supposed to die? */
>         if (unlikely(worker->flags & WORKER_DIE)) {
>                 raw_spin_unlock_irq(&pool->lock);
> +
> +               worker_wait_reaped(worker);
> +
>                 WARN_ON_ONCE(!list_empty(&worker->entry));
>                 set_pf_worker(false);
>
> @@ -3454,7 +3552,7 @@ static int init_worker_pool(struct worker_pool *pool)
>         INIT_LIST_HEAD(&pool->idle_list);
>         hash_init(pool->busy_hash);
>
> -       timer_setup(&pool->idle_timer, idle_worker_timeout, TIMER_DEFERRABLE);
> +       INIT_DEFERRABLE_WORK(&pool->idle_reaper_work, idle_reaper_fn);
>
>         timer_setup(&pool->mayday_timer, pool_mayday_timeout, 0);
>
> @@ -3559,8 +3657,11 @@ static bool wq_manager_inactive(struct worker_pool *pool)
>  static void put_unbound_pool(struct worker_pool *pool)
>  {
>         DECLARE_COMPLETION_ONSTACK(detach_completion);
> +       struct list_head reaplist;
>         struct worker *worker;
>
> +       INIT_LIST_HEAD(&reaplist);
> +
>         lockdep_assert_held(&wq_pool_mutex);
>
>         if (--pool->refcnt)
> @@ -3588,10 +3689,12 @@ static void put_unbound_pool(struct worker_pool *pool)
>         pool->flags |= POOL_MANAGER_ACTIVE;
>
>         while ((worker = first_idle_worker(pool)))
> -               destroy_worker(worker);
> +               destroy_worker(worker, &reaplist);
>         WARN_ON(pool->nr_workers || pool->nr_idle);
>         raw_spin_unlock_irq(&pool->lock);
>
> +       reap_workers(&reaplist);
> +
>         mutex_lock(&wq_pool_attach_mutex);
>         if (!list_empty(&pool->workers))
>                 pool->detach_completion = &detach_completion;
> @@ -3601,7 +3704,7 @@ static void put_unbound_pool(struct worker_pool *pool)
>                 wait_for_completion(pool->detach_completion);
>
>         /* shut down the timers */
> -       del_timer_sync(&pool->idle_timer);
> +       cancel_delayed_work_sync(&pool->idle_reaper_work);
>         del_timer_sync(&pool->mayday_timer);
>
>         /* RCU protected to allow dereferences from get_work_pool() */
> @@ -4999,13 +5102,8 @@ static void unbind_workers(int cpu)
>
>                 raw_spin_unlock_irq(&pool->lock);
>
> -               for_each_pool_worker(worker, pool) {
> -                       kthread_set_per_cpu(worker->task, -1);
> -                       if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
> -                               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
> -                       else
> -                               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
> -               }
> +               for_each_pool_worker(worker, pool)
> +                       unbind_worker(worker);
>
>                 mutex_unlock(&wq_pool_attach_mutex);
>         }
> @@ -5030,11 +5128,8 @@ static void rebind_workers(struct worker_pool *pool)
>          * of all workers first and then clear UNBOUND.  As we're called
>          * from CPU_ONLINE, the following shouldn't fail.
>          */
> -       for_each_pool_worker(worker, pool) {
> -               kthread_set_per_cpu(worker->task, pool->cpu);
> -               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
> -                                                 pool->attrs->cpumask) < 0);
> -       }
> +       for_each_pool_worker(worker, pool)
> +               rebind_worker(worker, pool);


It is better to skip the workers which are WORKER_DIE.
Or just detach the worker when reaping it.

>
>         raw_spin_lock_irq(&pool->lock);
>
> diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
> index e00b1204a8e9..a3d60e10a76f 100644
> --- a/kernel/workqueue_internal.h
> +++ b/kernel/workqueue_internal.h
> @@ -46,6 +46,7 @@ struct worker {
>         unsigned int            flags;          /* X: flags */
>         int                     id;             /* I: worker id */
>         int                     sleeping;       /* None */
> +       int                     reaped;         /* None */
>
>         /*
>          * Opaque string set with work_set_desc().  Printed out with task
> --
> 2.31.1
>
