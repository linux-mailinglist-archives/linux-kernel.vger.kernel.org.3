Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4905D55A2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiFXUbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiFXUby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:31:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9627E00B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0BA6B82994
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 20:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F85C34114;
        Fri, 24 Jun 2022 20:31:49 +0000 (UTC)
Date:   Fri, 24 Jun 2022 16:31:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mintu Patel <mintupatel89@gmail.com>
Cc:     Chinmoy Ghosh <chinmoyghosh2001@gmail.com>,
        Vishal Badole <badolevishal1116@gmail.com>,
        Vimal Kumar <vimal.kumar32@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rt_spin_lock: To list the correct owner of rt_spin_lock
Message-ID: <20220624163147.52b6e426@rorschach.local.home>
In-Reply-To: <20220619142038.1274-1-mintupatel89@gmail.com>
References: <20220619142038.1274-1-mintupatel89@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2022 19:50:38 +0530
Mintu Patel <mintupatel89@gmail.com> wrote:

>    rt_spin_lock is actually mutex on RT Kernel so it goes for contention
>    for lock. Currently owners of rt_spin_lock are decided before actual
>    acquiring of lock. This patch would depict the correct owner of
>    rt_spin_lock. The patch would help in solving crashes and deadlock
>    due to race condition of lock
> 
> acquiring rt_spin_lock        acquired the lock       released the lock
>                     <-------->                <------->
>                     contention period         Held period
> 
> Thread1                             Thread2
> _try_to_take_rt_mutex+0x95c+0x74    enqueue_task_dl+0x8cc/0x8dc
> rt_spin_lock_slowlock_locked+0xac+2 rt_mutex_setprio+0x28c/0x574
> rt_spin_lock_slowlock+0x5c/0x90     task_blocks_rt_mutex+0x240/0x310
> rt_spin_lock+0x58/0x5c              rt_spin_lock_slowlock_locked+0xac/0x2
> driverA_acquire_lock+0x28/0x56      rt_spin_lock_slowlock+0x5c/0x90
> 				    rt_spin_lock+0x58/0x5c
>                                     driverB_acquire_lock+0x48/0x6c
> 
> As per above call traces sample, Thread1 acquired the rt_spin_lock and
> went to critical section on the other hand Thread2 kept trying to acquire
> the same rt_spin_lock held by Thread1 ie contention period is too high.
> Finally Thread2 entered to dl queue due to high held time of the lock by
> Thread1. The below patch would help us to know the correct owner of
> rt_spin_lock and point us the driver's critical section. Respective
> driver need to be debugged for longer held period of lock.
> 
>    ex: cat /sys/kernel/debug/tracing/trace
> 
>    kworker/u13:0-150   [003] .....11   202.761025: rt_spinlock_acquire:
> Process: kworker/u13:0 is acquiring lock: &kbdev->hwaccess_lock
>    kworker/u13:0-150   [003] .....11   202.761039: rt_spinlock_acquired:
> Process: kworker/u13:0 has acquired lock: &kbdev->hwaccess_lock
>    kworker/u13:0-150   [003] .....11   202.761042: rt_spinlock_released:
> Process: kworker/u13:0 has released lock: &kbdev->hwaccess_lock
> 
> Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
> ---
>  include/trace/events/lock.h | 59 +++++++++++++++++++++++++++++++++++++
>  kernel/locking/rtmutex.c    | 10 +++++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
> index d7512129a324..c250a83ed995 100644
> --- a/include/trace/events/lock.h
> +++ b/include/trace/events/lock.h
> @@ -35,6 +35,65 @@ TRACE_EVENT(lock_acquire,
>  		  (__entry->flags & 2) ? "read " : "",
>  		  __get_str(name))
>  );
> +TRACE_EVENT(rt_spinlock_acquire,
> +
> +	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
> +
> +	TP_ARGS(lock, pname),
> +
> +	TP_STRUCT__entry(
> +		__string(name, lock->name)
> +		__string(process_name, pname->comm)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, lock->name);
> +		__assign_str(process_name, pname->comm);
> +	),
> +
> +	TP_printk("Process: %s is acquiring lock: %s",  __get_str(process_name),
> +		__get_str(name))
> +);
> +
> +TRACE_EVENT(rt_spinlock_acquired,
> +
> +	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
> +
> +	TP_ARGS(lock, pname),
> +
> +	TP_STRUCT__entry(
> +		__string(name, lock->name)
> +		__string(process_name, pname->comm)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, lock->name);
> +		__assign_str(process_name, pname->comm);
> +	),
> +
> +	TP_printk("Process: %s has acquired lock: %s", __get_str(process_name),
> +		__get_str(name))
> +);
> +
> +TRACE_EVENT(rt_spinlock_released,
> +
> +	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
> +
> +	TP_ARGS(lock, pname),
> +
> +	TP_STRUCT__entry(
> +		__string(name, lock->name)
> +		__string(process_name, pname->comm)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, lock->name);
> +		__assign_str(process_name, pname->comm);
> +	),
> +
> +	TP_printk("Process: %s has released lock: %s", __get_str(process_name),
> +		__get_str(name))
> +);

The above three are the same except for the TP_printk() please convert it to:

DECLARE_EVENT_CLASS(rt_lock_class,

	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),

	TP_ARGS(lock, pname),

	TP_STRUCT__entry(
		__string(name, lock->name)
		__string(process_name, pname->comm)
	),

	TP_fast_assign(
		__assign_str(name, lock->name);
		__assign_str(process_name, pname->comm);
	),

	TP_printk("Process: %s is acquiring lock: %s",  __get_str(process_name),
		__get_str(name))
);

/* Uses the tp_printk of the class */
DEFINE_EVENT(rt_lock_class, rt_spinlock_acquire,
	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
	TP_ARGS(lock, pname));

DEFINE_EVENT_PRINT(rt_lock_class, rt_spinlock_acquired,
	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
	TP_ARGS(lock, pname),
	TP_printk("Process: %s has acquired lock: %s", __get_str(process_name),
		__get_str(name));

DEFINE_EVENT_PRINT(rt_lock_class, rt_spinlock_released,
	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
	TP_ARGS(lock, pname),
	TP_printk("Process: %s has released lock: %s", __get_str(process_name),
		__get_str(name));


>  
>  DECLARE_EVENT_CLASS(lock,
>  
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 602eb7821a1b..f7cba05fbe74 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -26,6 +26,7 @@
>  #include <linux/timer.h>
>  #include <linux/ww_mutex.h>
>  #include <linux/blkdev.h>
> +#include <trace/events/lock.h>
>  
>  #include "rtmutex_common.h"
>  
> @@ -1144,7 +1145,13 @@ void __lockfunc rt_spin_lock(spinlock_t *lock)
>  	rcu_read_lock();
>  	migrate_disable();
>  	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
> +#ifdef CONFIG_RT_SPIN_LOCK_TRACING
> +	trace_rt_spinlock_acquire(&lock->dep_map, current);
> +#endif
>  	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
> +#ifdef CONFIG_RT_SPIN_LOCK_TRACING
> +	trace_rt_spinlock_acquired(&lock->dep_map, current);
> +#endif

Can you make a wrapper above so the C functions are not messed up with
#ifdefs.

#ifdef CONFIG_RT_SPIN_LOCK_TRACING
# define do_trace_rt_spinlock_aquire(lock, task) trace_rt_spinlock_acquire(lock, task)
# define do_trace_rt_spinlock_aquired(lock, task) trace_rt_spinlock_acquired(lock, task)
# define do_trace_rt_spinlock_released(lock, task) trace_rt_spinlock_released(lock, task)
#else
# define do_trace_rt_spinlock_aquire(lock, task) do {} while(0)
# define do_trace_rt_spinlock_aquired(lock, task) do {} while(0)
# define do_trace_rt_spinlock_released(lock, task) do {} while(0)
#endif

Or perhaps just have (in the code):

	if (ENABLED(CONFIG_RT_SPIN_LOCK_TRACING))
		trace_rt_spinlock_acquire(...);

-- Steve

>  }
>  EXPORT_SYMBOL(rt_spin_lock);
>  
> @@ -1169,6 +1176,9 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
>  {
>  	/* NOTE: we always pass in '1' for nested, for simplicity */
>  	spin_release(&lock->dep_map, 1, _RET_IP_);
> +#ifdef CONFIG_RT_SPIN_LOCK_TRACING
> +	trace_rt_spinlock_released(&lock->dep_map, current);
> +#endif
>  	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
>  	migrate_enable();
>  	rcu_read_unlock();

