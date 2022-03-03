Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452A54CBBCC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiCCK4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiCCK4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:56:08 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5B217BC40
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:55:22 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5EB7668AFE; Thu,  3 Mar 2022 11:55:20 +0100 (CET)
Date:   Thu, 3 Mar 2022 11:55:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] task_work: simplify the task_work_add() interface
Message-ID: <20220303105520.GB14991@lst.de>
References: <20220223072754.616027-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223072754.616027-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments?

On Wed, Feb 23, 2022 at 08:27:54AM +0100, Christoph Hellwig wrote:
> Provide a low-level task_work_add_nonotify interface that just adds
> the work to the list and open code the TWA_SIGNAL and TWA_NONE callers
> using it.  task_work_add() itself now only handles the common TWA_RESUME
> case and can drop the notify argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/kernel/cpu/mce/core.c |  2 +-
>  arch/x86/mm/tlb.c              |  2 +-
>  drivers/acpi/apei/ghes.c       |  3 +-
>  drivers/android/binder.c       |  2 +-
>  fs/file_table.c                |  2 +-
>  fs/io-wq.c                     |  3 +-
>  fs/io_uring.c                  | 16 +++++-----
>  fs/namespace.c                 |  2 +-
>  include/linux/task_work.h      | 11 ++-----
>  include/linux/tracehook.h      |  2 +-
>  kernel/events/uprobes.c        |  2 +-
>  kernel/irq/manage.c            |  2 +-
>  kernel/sched/fair.c            |  2 +-
>  kernel/task_work.c             | 56 ++++++++++++++++++----------------
>  kernel/time/posix-cpu-timers.c |  2 +-
>  security/keys/keyctl.c         |  2 +-
>  security/yama/yama_lsm.c       |  2 +-
>  17 files changed, 55 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 5818b837fd4d4..a9da9a968163c 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1349,7 +1349,7 @@ static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callba
>  	if (count > 1)
>  		return;
>  
> -	task_work_add(current, &current->mce_kill_me, TWA_RESUME);
> +	task_work_add(current, &current->mce_kill_me);
>  }
>  
>  /* Handle unconfigured int18 (should never happen) */
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index a6cf56a149393..8db8f4f7001f8 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -355,7 +355,7 @@ static void l1d_flush_evaluate(unsigned long prev_mm, unsigned long next_mm,
>  	if (this_cpu_read(cpu_info.smt_active)) {
>  		clear_ti_thread_flag(&next->thread_info, TIF_SPEC_L1D_FLUSH);
>  		next->l1d_flush_kill.func = l1d_flush_force_sigbus;
> -		task_work_add(next, &next->l1d_flush_kill, TWA_RESUME);
> +		task_work_add(next, &next->l1d_flush_kill);
>  	}
>  }
>  
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0c5c9acc6254e..12bd63b9af308 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -988,8 +988,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>  		if (task_work_pending && current->mm != &init_mm) {
>  			estatus_node->task_work.func = ghes_kick_task_work;
>  			estatus_node->task_work_cpu = smp_processor_id();
> -			ret = task_work_add(current, &estatus_node->task_work,
> -					    TWA_RESUME);
> +			ret = task_work_add(current, &estatus_node->task_work);
>  			if (ret)
>  				estatus_node->task_work.func = NULL;
>  		}
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 8351c5638880b..eeef8dfde606b 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1858,7 +1858,7 @@ static void binder_deferred_fd_close(int fd)
>  	close_fd_get_file(fd, &twcb->file);
>  	if (twcb->file) {
>  		filp_close(twcb->file, current->files);
> -		task_work_add(current, &twcb->twork, TWA_RESUME);
> +		task_work_add(current, &twcb->twork);
>  	} else {
>  		kfree(twcb);
>  	}
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 7d2e692b66a94..3c329359c18f8 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -375,7 +375,7 @@ void fput_many(struct file *file, unsigned int refs)
>  
>  		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
>  			init_task_work(&file->f_u.fu_rcuhead, ____fput);
> -			if (!task_work_add(task, &file->f_u.fu_rcuhead, TWA_RESUME))
> +			if (!task_work_add(task, &file->f_u.fu_rcuhead))
>  				return;
>  			/*
>  			 * After this task has run exit_task_work(),
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index bb7f161bb19cd..23d628b591a7b 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -362,7 +362,8 @@ static bool io_queue_worker_create(struct io_worker *worker,
>  	atomic_inc(&wq->worker_refs);
>  	init_task_work(&worker->create_work, func);
>  	worker->create_index = acct->index;
> -	if (!task_work_add(wq->task, &worker->create_work, TWA_SIGNAL)) {
> +	if (!task_work_add_nonotify(wq->task, &worker->create_work)) {
> +		set_notify_signal(wq->task);
>  		/*
>  		 * EXIT may have been set after checking it above, check after
>  		 * adding the task_work and remove any creation item if it is
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 77b9c7e4793bf..94116a102dc61 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2374,7 +2374,6 @@ static void io_req_task_work_add(struct io_kiocb *req, bool priority)
>  {
>  	struct task_struct *tsk = req->task;
>  	struct io_uring_task *tctx = tsk->io_uring;
> -	enum task_work_notify_mode notify;
>  	struct io_wq_work_node *node;
>  	unsigned long flags;
>  	bool running;
> @@ -2397,14 +2396,15 @@ static void io_req_task_work_add(struct io_kiocb *req, bool priority)
>  
>  	/*
>  	 * SQPOLL kernel thread doesn't need notification, just a wakeup. For
> -	 * all other cases, use TWA_SIGNAL unconditionally to ensure we're
> -	 * processing task_work. There's no reliable way to tell if TWA_RESUME
> -	 * will do the job.
> +	 * all other cases, use set_notify_signal unconditionally to ensure
> +	 * we're processing the task_work. There's no reliable way to tell if
> +	 * task_work_add will do the job.
>  	 */
> -	notify = (req->ctx->flags & IORING_SETUP_SQPOLL) ? TWA_NONE : TWA_SIGNAL;
> -	if (likely(!task_work_add(tsk, &tctx->task_work, notify))) {
> -		if (notify == TWA_NONE)
> +	if (likely(!task_work_add_nonotify(tsk, &tctx->task_work))) {
> +		if (req->ctx->flags & IORING_SETUP_SQPOLL)
>  			wake_up_process(tsk);
> +		else
> +			set_notify_signal(tsk);
>  		return;
>  	}
>  
> @@ -9606,7 +9606,7 @@ static __cold void io_ring_exit_work(struct work_struct *work)
>  					ctx_node);
>  		/* don't spin on a single task if cancellation failed */
>  		list_rotate_left(&ctx->tctx_list);
> -		ret = task_work_add(node->task, &exit.task_work, TWA_SIGNAL);
> +		ret = task_work_add_nonotify(node->task, &exit.task_work);
>  		if (WARN_ON_ONCE(ret))
>  			continue;
>  
> diff --git a/fs/namespace.c b/fs/namespace.c
> index de6fae84f1a1a..a482b41621866 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1249,7 +1249,7 @@ static void mntput_no_expire(struct mount *mnt)
>  		struct task_struct *task = current;
>  		if (likely(!(task->flags & PF_KTHREAD))) {
>  			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
> -			if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
> +			if (!task_work_add(task, &mnt->mnt_rcu))
>  				return;
>  		}
>  		if (llist_add(&mnt->mnt_llist, &delayed_mntput_list))
> diff --git a/include/linux/task_work.h b/include/linux/task_work.h
> index 5b8a93f288bb4..af27deee1a559 100644
> --- a/include/linux/task_work.h
> +++ b/include/linux/task_work.h
> @@ -13,14 +13,9 @@ init_task_work(struct callback_head *twork, task_work_func_t func)
>  	twork->func = func;
>  }
>  
> -enum task_work_notify_mode {
> -	TWA_NONE,
> -	TWA_RESUME,
> -	TWA_SIGNAL,
> -};
> -
> -int task_work_add(struct task_struct *task, struct callback_head *twork,
> -			enum task_work_notify_mode mode);
> +int task_work_add(struct task_struct *task, struct callback_head *twork);
> +int task_work_add_nonotify(struct task_struct *task,
> +		struct callback_head *twork);
>  
>  struct callback_head *task_work_cancel_match(struct task_struct *task,
>  	bool (*match)(struct callback_head *, void *data), void *data);
> diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
> index 88c007ab5ebc7..910fd2d6467e7 100644
> --- a/include/linux/tracehook.h
> +++ b/include/linux/tracehook.h
> @@ -202,7 +202,7 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
>  
>  /*
>   * called by exit_to_user_mode_loop() if ti_work & _TIF_NOTIFY_SIGNAL. This
> - * is currently used by TWA_SIGNAL based task_work, which requires breaking
> + * is currently used by signal based task_work, which requires breaking
>   * wait loops to ensure that task_work is noticed and run.
>   */
>  static inline void tracehook_notify_signal(void)
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 6357c3580d07b..6c12d9f0dc647 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1823,7 +1823,7 @@ void uprobe_copy_process(struct task_struct *t, unsigned long flags)
>  
>  	t->utask->dup_xol_addr = area->vaddr;
>  	init_task_work(&t->utask->dup_xol_work, dup_xol_work);
> -	task_work_add(t, &t->utask->dup_xol_work, TWA_RESUME);
> +	task_work_add(t, &t->utask->dup_xol_work);
>  }
>  
>  /*
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index f23ffd30385b1..4557319303374 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1268,7 +1268,7 @@ static int irq_thread(void *data)
>  		handler_fn = irq_thread_fn;
>  
>  	init_task_work(&on_exit_work, irq_thread_dtor);
> -	task_work_add(current, &on_exit_work, TWA_NONE);
> +	task_work_add_nonotify(current, &on_exit_work);
>  
>  	irq_thread_check_affinity(desc, action);
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5146163bfabb9..616626719c5f5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2880,7 +2880,7 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
>  		curr->node_stamp += period;
>  
>  		if (!time_before(jiffies, curr->mm->numa_next_scan))
> -			task_work_add(curr, work, TWA_RESUME);
> +			task_work_add(curr, work);
>  	}
>  }
>  
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 1698fbe6f0e13..4a547d80d6493 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -6,22 +6,16 @@
>  static struct callback_head work_exited; /* all we need is ->next == NULL */
>  
>  /**
> - * task_work_add - ask the @task to execute @work->func()
> + * task_work_add_nonotify - ask the @task to execute @work->func()
>   * @task: the task which should run the callback
>   * @work: the callback to run
>   * @notify: how to notify the targeted task
>   *
> - * Queue @work for task_work_run() below and notify the @task if @notify
> - * is @TWA_RESUME or @TWA_SIGNAL. @TWA_SIGNAL works like signals, in that the
> - * it will interrupt the targeted task and run the task_work. @TWA_RESUME
> - * work is run only when the task exits the kernel and returns to user mode,
> - * or before entering guest mode. Fails if the @task is exiting/exited and thus
> - * it can't process this @work. Otherwise @work->func() will be called when the
> - * @task goes through one of the aforementioned transitions, or exits.
> + * Queue @work for task_work_run() below.  If the targeted task is exiting, then
> + * an error is returned and the work item is not queued. It's up to the caller
> + * to arrange for an alternative mechanism in that case.
>   *
> - * If the targeted task is exiting, then an error is returned and the work item
> - * is not queued. It's up to the caller to arrange for an alternative mechanism
> - * in that case.
> + * The caller needs to notify @task to make sure @work is actually run.
>   *
>   * Note: there is no ordering guarantee on works queued here. The task_work
>   * list is LIFO.
> @@ -29,8 +23,7 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
>   * RETURNS:
>   * 0 if succeeds or -ESRCH.
>   */
> -int task_work_add(struct task_struct *task, struct callback_head *work,
> -		  enum task_work_notify_mode notify)
> +int task_work_add_nonotify(struct task_struct *task, struct callback_head *work)
>  {
>  	struct callback_head *head;
>  
> @@ -44,23 +37,32 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>  		work->next = head;
>  	} while (cmpxchg(&task->task_works, head, work) != head);
>  
> -	switch (notify) {
> -	case TWA_NONE:
> -		break;
> -	case TWA_RESUME:
> -		set_notify_resume(task);
> -		break;
> -	case TWA_SIGNAL:
> -		set_notify_signal(task);
> -		break;
> -	default:
> -		WARN_ON_ONCE(1);
> -		break;
> -	}
> -
>  	return 0;
>  }
>  
> +/**
> + * task_work_add - ask the @task to execute @work->func()
> + * @task: the task which should run the callback
> + * @work: the callback to run
> + * @notify: how to notify the targeted task
> + *
> + * Queue @work using task_work_add_nonotify() and notify the task to actually
> + * run it when the task exits the kernel and returns to user mode, or before
> + * entering guest mode.
> + *
> + * RETURNS:
> + * 0 if succeeds or -ESRCH.
> + */
> +int task_work_add(struct task_struct *task, struct callback_head *work)
> +{
> +	int ret;
> +
> +	ret = task_work_add_nonotify(task, work);
> +	if (!ret)
> +		set_notify_resume(task);
> +	return ret;
> +}
> +
>  /**
>   * task_work_cancel_match - cancel a pending work added by task_work_add()
>   * @task: the task which should execute the work
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index 96b4e78104266..c8808b32dc144 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -1201,7 +1201,7 @@ static inline void __run_posix_cpu_timers(struct task_struct *tsk)
>  
>  	/* Schedule task work to actually expire the timers */
>  	tsk->posix_cputimers_work.scheduled = true;
> -	task_work_add(tsk, &tsk->posix_cputimers_work.work, TWA_RESUME);
> +	task_work_add(tsk, &tsk->posix_cputimers_work.work);
>  }
>  
>  static inline bool posix_cpu_timers_enable_work(struct task_struct *tsk,
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index 96a92a645216d..331a825ff6616 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1693,7 +1693,7 @@ long keyctl_session_to_parent(void)
>  
>  	/* the replacement session keyring is applied just prior to userspace
>  	 * restarting */
> -	ret = task_work_add(parent, newwork, TWA_RESUME);
> +	ret = task_work_add(parent, newwork);
>  	if (!ret)
>  		newwork = NULL;
>  unlock:
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 06e226166aab3..2af248939dd46 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -99,7 +99,7 @@ static void report_access(const char *access, struct task_struct *target,
>  	info->access = access;
>  	info->target = target;
>  	info->agent = agent;
> -	if (task_work_add(current, &info->work, TWA_RESUME) == 0)
> +	if (task_work_add(current, &info->work) == 0)
>  		return; /* success */
>  
>  	WARN(1, "report_access called from exiting task");
> -- 
> 2.30.2
---end quoted text---
