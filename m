Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2679C59EBC5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiHWTFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiHWTFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:05:23 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBA012AC20;
        Tue, 23 Aug 2022 10:41:06 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3378303138bso358365717b3.9;
        Tue, 23 Aug 2022 10:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YDO+BeTliFPfCNhI7Dfx4zJNj9CsFoNKyKsKiin1/xE=;
        b=HJuBTqYm+sUjXhsIN2ciK71Sv8ap7sS0NQAD9I5YMIgmjIbiUpy4WrCe4drplLlZhI
         cWypBC5epEAt3F6yyebfDzUW2OUJClyDEPTO328M6kNs+MORtWrkmF/8BIGsQsKSR1dE
         D3tUIcVhVX8b7G4AYbNvf/YBJlt0q8/+tDtp1/caD7LHYuuytRm68xMGCGX789mF9szD
         ZTtwP3EUVTHqrpH51iZ4WA9qqDF7nhkapJv+1pUQZEXjN6RMKnNpyAI9PDv4h9Tyl8qi
         6LseRvxRBYNhSdsWmCnAS4yzqDfLz1uMdOHN+CXKwqMGWYcJCuEXtjWdjPAnZ35BlZy7
         bCYw==
X-Gm-Message-State: ACgBeo2wP79IPSThZdDMFC9nNCtdiofsnvtArVLoQcPYD9N58Nh+2a2B
        nP/bIxTi9PtlqAsdNzvkDX1uMLuVrtD5r/B4EYo=
X-Google-Smtp-Source: AA6agR6LKUi9PVee7u4UzB2whSJvEc+wGZPanKVp6KrFjD6pA7apwZTqd2lt2IKh/J6TFvl280w4E6YQ4IYEEEhWzxQ=
X-Received: by 2002:a25:c204:0:b0:692:72b9:a778 with SMTP id
 s4-20020a25c204000000b0069272b9a778mr25361353ybf.81.1661276195272; Tue, 23
 Aug 2022 10:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220822111816.760285417@infradead.org> <20220822114649.055452969@infradead.org>
In-Reply-To: <20220822114649.055452969@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 19:36:23 +0200
Message-ID: <CAJZ5v0h=VpW3Y-eWuPnbmOCRKmX7T-dbdSktegMaqfrjuYM_Ww@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 1:48 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Rewrite the core freezer to behave better wrt thawing and be simpler
> in general.
>
> By replacing PF_FROZEN with TASK_FROZEN, a special block state, it is
> ensured frozen tasks stay frozen until thawed and don't randomly wake
> up early, as is currently possible.
>
> As such, it does away with PF_FROZEN and PF_FREEZER_SKIP, freeing up
> two PF_flags (yay!).
>
> Specifically; the current scheme works a little like:
>
>         freezer_do_not_count();
>         schedule();
>         freezer_count();
>
> And either the task is blocked, or it lands in try_to_freezer()
> through freezer_count(). Now, when it is blocked, the freezer
> considers it frozen and continues.
>
> However, on thawing, once pm_freezing is cleared, freezer_count()
> stops working, and any random/spurious wakeup will let a task run
> before its time.
>
> That is, thawing tries to thaw things in explicit order; kernel
> threads and workqueues before doing bringing SMP back before userspace
> etc.. However due to the above mentioned races it is entirely possible
> for userspace tasks to thaw (by accident) before SMP is back.
>
> This can be a fatal problem in asymmetric ISA architectures (eg ARMv9)
> where the userspace task requires a special CPU to run.
>
> As said; replace this with a special task state TASK_FROZEN and add
> the following state transitions:
>
>         TASK_FREEZABLE  -> TASK_FROZEN
>         __TASK_STOPPED  -> TASK_FROZEN
>         __TASK_TRACED   -> TASK_FROZEN
>
> The new TASK_FREEZABLE can be set on any state part of TASK_NORMAL
> (IOW. TASK_INTERRUPTIBLE and TASK_UNINTERRUPTIBLE) -- any such state
> is already required to deal with spurious wakeups and the freezer
> causes one such when thawing the task (since the original state is
> lost).
>
> The special __TASK_{STOPPED,TRACED} states *can* be restored since
> their canonical state is in ->jobctl.
>
> With this, frozen tasks need an explicit TASK_FROZEN wakeup and are
> free of undue (early / spurious) wakeups.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/android/binder.c       |    4
>  drivers/media/pci/pt3/pt3.c    |    4
>  fs/cifs/inode.c                |    4
>  fs/cifs/transport.c            |    5
>  fs/coredump.c                  |    5
>  fs/nfs/file.c                  |    3
>  fs/nfs/inode.c                 |   12 --
>  fs/nfs/nfs3proc.c              |    3
>  fs/nfs/nfs4proc.c              |   14 +-
>  fs/nfs/nfs4state.c             |    3
>  fs/nfs/pnfs.c                  |    4
>  fs/xfs/xfs_trans_ail.c         |    8 -
>  include/linux/freezer.h        |  245 +----------------------------------------
>  include/linux/sched.h          |   41 +++---
>  include/linux/sunrpc/sched.h   |    7 -
>  include/linux/wait.h           |   12 +-
>  kernel/cgroup/legacy_freezer.c |   23 +--
>  kernel/exit.c                  |    4
>  kernel/fork.c                  |    5
>  kernel/freezer.c               |  133 ++++++++++++++++------
>  kernel/futex/waitwake.c        |    8 -
>  kernel/hung_task.c             |    4
>  kernel/power/main.c            |    6 -
>  kernel/power/process.c         |   10 -
>  kernel/ptrace.c                |    2
>  kernel/sched/core.c            |    2
>  kernel/signal.c                |   14 +-
>  kernel/time/hrtimer.c          |    4
>  kernel/umh.c                   |   20 +--
>  mm/khugepaged.c                |    4
>  net/sunrpc/sched.c             |   12 --
>  net/unix/af_unix.c             |    8 -
>  32 files changed, 224 insertions(+), 409 deletions(-)
>
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4247,10 +4247,9 @@ static int binder_wait_for_work(struct b
>         struct binder_proc *proc = thread->proc;
>         int ret = 0;
>
> -       freezer_do_not_count();
>         binder_inner_proc_lock(proc);
>         for (;;) {
> -               prepare_to_wait(&thread->wait, &wait, TASK_INTERRUPTIBLE);
> +               prepare_to_wait(&thread->wait, &wait, TASK_INTERRUPTIBLE|TASK_FREEZABLE);
>                 if (binder_has_work_ilocked(thread, do_proc_work))
>                         break;
>                 if (do_proc_work)
> @@ -4267,7 +4266,6 @@ static int binder_wait_for_work(struct b
>         }
>         finish_wait(&thread->wait, &wait);
>         binder_inner_proc_unlock(proc);
> -       freezer_count();
>
>         return ret;
>  }
> --- a/drivers/media/pci/pt3/pt3.c
> +++ b/drivers/media/pci/pt3/pt3.c
> @@ -445,8 +445,8 @@ static int pt3_fetch_thread(void *data)
>                 pt3_proc_dma(adap);
>
>                 delay = ktime_set(0, PT3_FETCH_DELAY * NSEC_PER_MSEC);
> -               set_current_state(TASK_UNINTERRUPTIBLE);
> -               freezable_schedule_hrtimeout_range(&delay,
> +               set_current_state(TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
> +               schedule_hrtimeout_range(&delay,
>                                         PT3_FETCH_DELAY_DELTA * NSEC_PER_MSEC,
>                                         HRTIMER_MODE_REL);
>         }
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@ -2327,7 +2327,7 @@ cifs_invalidate_mapping(struct inode *in
>  static int
>  cifs_wait_bit_killable(struct wait_bit_key *key, int mode)
>  {
> -       freezable_schedule_unsafe();
> +       schedule();
>         if (signal_pending_state(mode, current))
>                 return -ERESTARTSYS;
>         return 0;
> @@ -2345,7 +2345,7 @@ cifs_revalidate_mapping(struct inode *in
>                 return 0;
>
>         rc = wait_on_bit_lock_action(flags, CIFS_INO_LOCK, cifs_wait_bit_killable,
> -                                    TASK_KILLABLE);
> +                                    TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
>         if (rc)
>                 return rc;
>
> --- a/fs/cifs/transport.c
> +++ b/fs/cifs/transport.c
> @@ -757,8 +757,9 @@ wait_for_response(struct TCP_Server_Info
>  {
>         int error;
>
> -       error = wait_event_freezekillable_unsafe(server->response_q,
> -                                   midQ->mid_state != MID_REQUEST_SUBMITTED);
> +       error = wait_event_state(server->response_q,
> +                                midQ->mid_state != MID_REQUEST_SUBMITTED,
> +                                (TASK_KILLABLE|TASK_FREEZABLE_UNSAFE));
>         if (error < 0)
>                 return -ERESTARTSYS;
>
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -402,9 +402,8 @@ static int coredump_wait(int exit_code,
>         if (core_waiters > 0) {
>                 struct core_thread *ptr;
>
> -               freezer_do_not_count();
> -               wait_for_completion(&core_state->startup);
> -               freezer_count();
> +               wait_for_completion_state(&core_state->startup,
> +                                         TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
>                 /*
>                  * Wait for all the threads to become inactive, so that
>                  * all the thread context (extended register state, like
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -570,7 +570,8 @@ static vm_fault_t nfs_vm_page_mkwrite(st
>         }
>
>         wait_on_bit_action(&NFS_I(inode)->flags, NFS_INO_INVALIDATING,
> -                       nfs_wait_bit_killable, TASK_KILLABLE);
> +                          nfs_wait_bit_killable,
> +                          TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
>
>         lock_page(page);
>         mapping = page_file_mapping(page);
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -72,18 +72,13 @@ nfs_fattr_to_ino_t(struct nfs_fattr *fat
>         return nfs_fileid_to_ino_t(fattr->fileid);
>  }
>
> -static int nfs_wait_killable(int mode)
> +int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
>  {
> -       freezable_schedule_unsafe();
> +       schedule();
>         if (signal_pending_state(mode, current))
>                 return -ERESTARTSYS;
>         return 0;
>  }
> -
> -int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
> -{
> -       return nfs_wait_killable(mode);
> -}
>  EXPORT_SYMBOL_GPL(nfs_wait_bit_killable);
>
>  /**
> @@ -1331,7 +1326,8 @@ int nfs_clear_invalid_mapping(struct add
>          */
>         for (;;) {
>                 ret = wait_on_bit_action(bitlock, NFS_INO_INVALIDATING,
> -                                        nfs_wait_bit_killable, TASK_KILLABLE);
> +                                        nfs_wait_bit_killable,
> +                                        TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
>                 if (ret)
>                         goto out;
>                 spin_lock(&inode->i_lock);
> --- a/fs/nfs/nfs3proc.c
> +++ b/fs/nfs/nfs3proc.c
> @@ -36,7 +36,8 @@ nfs3_rpc_wrapper(struct rpc_clnt *clnt,
>                 res = rpc_call_sync(clnt, msg, flags);
>                 if (res != -EJUKEBOX)
>                         break;
> -               freezable_schedule_timeout_killable_unsafe(NFS_JUKEBOX_RETRY_TIME);
> +               __set_current_state(TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
> +               schedule_timeout(NFS_JUKEBOX_RETRY_TIME);
>                 res = -ERESTARTSYS;
>         } while (!fatal_signal_pending(current));
>         return res;
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -416,8 +416,8 @@ static int nfs4_delay_killable(long *tim
>  {
>         might_sleep();
>
> -       freezable_schedule_timeout_killable_unsafe(
> -               nfs4_update_delay(timeout));
> +       __set_current_state(TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
> +       schedule_timeout(nfs4_update_delay(timeout));
>         if (!__fatal_signal_pending(current))
>                 return 0;
>         return -EINTR;
> @@ -427,7 +427,8 @@ static int nfs4_delay_interruptible(long
>  {
>         might_sleep();
>
> -       freezable_schedule_timeout_interruptible_unsafe(nfs4_update_delay(timeout));
> +       __set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE_UNSAFE);
> +       schedule_timeout(nfs4_update_delay(timeout));
>         if (!signal_pending(current))
>                 return 0;
>         return __fatal_signal_pending(current) ? -EINTR :-ERESTARTSYS;
> @@ -7406,7 +7407,8 @@ nfs4_retry_setlk_simple(struct nfs4_stat
>                 status = nfs4_proc_setlk(state, cmd, request);
>                 if ((status != -EAGAIN) || IS_SETLK(cmd))
>                         break;
> -               freezable_schedule_timeout_interruptible(timeout);
> +               __set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
> +               schedule_timeout(timeout);
>                 timeout *= 2;
>                 timeout = min_t(unsigned long, NFS4_LOCK_MAXTIMEOUT, timeout);
>                 status = -ERESTARTSYS;
> @@ -7474,10 +7476,8 @@ nfs4_retry_setlk(struct nfs4_state *stat
>                         break;
>
>                 status = -ERESTARTSYS;
> -               freezer_do_not_count();
> -               wait_woken(&waiter.wait, TASK_INTERRUPTIBLE,
> +               wait_woken(&waiter.wait, TASK_INTERRUPTIBLE|TASK_FREEZABLE,
>                            NFS4_LOCK_MAXTIMEOUT);
> -               freezer_count();
>         } while (!signalled());
>
>         remove_wait_queue(q, &waiter.wait);
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1314,7 +1314,8 @@ int nfs4_wait_clnt_recover(struct nfs_cl
>
>         refcount_inc(&clp->cl_count);
>         res = wait_on_bit_action(&clp->cl_state, NFS4CLNT_MANAGER_RUNNING,
> -                                nfs_wait_bit_killable, TASK_KILLABLE);
> +                                nfs_wait_bit_killable,
> +                                TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
>         if (res)
>                 goto out;
>         if (clp->cl_cons_state < 0)
> --- a/fs/nfs/pnfs.c
> +++ b/fs/nfs/pnfs.c
> @@ -1908,7 +1908,7 @@ static int pnfs_prepare_to_retry_layoutg
>         pnfs_layoutcommit_inode(lo->plh_inode, false);
>         return wait_on_bit_action(&lo->plh_flags, NFS_LAYOUT_RETURN,
>                                    nfs_wait_bit_killable,
> -                                  TASK_KILLABLE);
> +                                  TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
>  }
>
>  static void nfs_layoutget_begin(struct pnfs_layout_hdr *lo)
> @@ -3193,7 +3193,7 @@ pnfs_layoutcommit_inode(struct inode *in
>                 status = wait_on_bit_lock_action(&nfsi->flags,
>                                 NFS_INO_LAYOUTCOMMITTING,
>                                 nfs_wait_bit_killable,
> -                               TASK_KILLABLE);
> +                               TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
>                 if (status)
>                         goto out;
>         }
> --- a/fs/xfs/xfs_trans_ail.c
> +++ b/fs/xfs/xfs_trans_ail.c
> @@ -602,9 +602,9 @@ xfsaild(
>
>         while (1) {
>                 if (tout && tout <= 20)
> -                       set_current_state(TASK_KILLABLE);
> +                       set_current_state(TASK_KILLABLE|TASK_FREEZABLE);
>                 else
> -                       set_current_state(TASK_INTERRUPTIBLE);
> +                       set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
>
>                 /*
>                  * Check kthread_should_stop() after we set the task state to
> @@ -653,14 +653,14 @@ xfsaild(
>                     ailp->ail_target == ailp->ail_target_prev &&
>                     list_empty(&ailp->ail_buf_list)) {
>                         spin_unlock(&ailp->ail_lock);
> -                       freezable_schedule();
> +                       schedule();
>                         tout = 0;
>                         continue;
>                 }
>                 spin_unlock(&ailp->ail_lock);
>
>                 if (tout)
> -                       freezable_schedule_timeout(msecs_to_jiffies(tout));
> +                       schedule_timeout(msecs_to_jiffies(tout));
>
>                 __set_current_state(TASK_RUNNING);
>
> --- a/include/linux/freezer.h
> +++ b/include/linux/freezer.h
> @@ -8,9 +8,11 @@
>  #include <linux/sched.h>
>  #include <linux/wait.h>
>  #include <linux/atomic.h>
> +#include <linux/jump_label.h>
>
>  #ifdef CONFIG_FREEZER
> -extern atomic_t system_freezing_cnt;   /* nr of freezing conds in effect */
> +DECLARE_STATIC_KEY_FALSE(freezer_active);
> +
>  extern bool pm_freezing;               /* PM freezing in effect */
>  extern bool pm_nosig_freezing;         /* PM nosig freezing in effect */
>
> @@ -22,10 +24,7 @@ extern unsigned int freeze_timeout_msecs
>  /*
>   * Check if a process has been frozen
>   */
> -static inline bool frozen(struct task_struct *p)
> -{
> -       return p->flags & PF_FROZEN;
> -}
> +extern bool frozen(struct task_struct *p);
>
>  extern bool freezing_slow_path(struct task_struct *p);
>
> @@ -34,9 +33,10 @@ extern bool freezing_slow_path(struct ta
>   */
>  static inline bool freezing(struct task_struct *p)
>  {
> -       if (likely(!atomic_read(&system_freezing_cnt)))
> -               return false;
> -       return freezing_slow_path(p);
> +       if (static_branch_unlikely(&freezer_active))
> +               return freezing_slow_path(p);
> +
> +       return false;
>  }
>
>  /* Takes and releases task alloc lock using task_lock() */
> @@ -48,23 +48,14 @@ extern int freeze_kernel_threads(void);
>  extern void thaw_processes(void);
>  extern void thaw_kernel_threads(void);
>
> -/*
> - * DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION
> - * If try_to_freeze causes a lockdep warning it means the caller may deadlock
> - */
> -static inline bool try_to_freeze_unsafe(void)
> +static inline bool try_to_freeze(void)
>  {
>         might_sleep();
>         if (likely(!freezing(current)))
>                 return false;
> -       return __refrigerator(false);
> -}
> -
> -static inline bool try_to_freeze(void)
> -{
>         if (!(current->flags & PF_NOFREEZE))
>                 debug_check_no_locks_held();
> -       return try_to_freeze_unsafe();
> +       return __refrigerator(false);
>  }
>
>  extern bool freeze_task(struct task_struct *p);
> @@ -79,195 +70,6 @@ static inline bool cgroup_freezing(struc
>  }
>  #endif /* !CONFIG_CGROUP_FREEZER */
>
> -/*
> - * The PF_FREEZER_SKIP flag should be set by a vfork parent right before it
> - * calls wait_for_completion(&vfork) and reset right after it returns from this
> - * function.  Next, the parent should call try_to_freeze() to freeze itself
> - * appropriately in case the child has exited before the freezing of tasks is
> - * complete.  However, we don't want kernel threads to be frozen in unexpected
> - * places, so we allow them to block freeze_processes() instead or to set
> - * PF_NOFREEZE if needed. Fortunately, in the ____call_usermodehelper() case the
> - * parent won't really block freeze_processes(), since ____call_usermodehelper()
> - * (the child) does a little before exec/exit and it can't be frozen before
> - * waking up the parent.
> - */
> -
> -
> -/**
> - * freezer_do_not_count - tell freezer to ignore %current
> - *
> - * Tell freezers to ignore the current task when determining whether the
> - * target frozen state is reached.  IOW, the current task will be
> - * considered frozen enough by freezers.
> - *
> - * The caller shouldn't do anything which isn't allowed for a frozen task
> - * until freezer_cont() is called.  Usually, freezer[_do_not]_count() pair
> - * wrap a scheduling operation and nothing much else.
> - */
> -static inline void freezer_do_not_count(void)
> -{
> -       current->flags |= PF_FREEZER_SKIP;
> -}
> -
> -/**
> - * freezer_count - tell freezer to stop ignoring %current
> - *
> - * Undo freezer_do_not_count().  It tells freezers that %current should be
> - * considered again and tries to freeze if freezing condition is already in
> - * effect.
> - */
> -static inline void freezer_count(void)
> -{
> -       current->flags &= ~PF_FREEZER_SKIP;
> -       /*
> -        * If freezing is in progress, the following paired with smp_mb()
> -        * in freezer_should_skip() ensures that either we see %true
> -        * freezing() or freezer_should_skip() sees !PF_FREEZER_SKIP.
> -        */
> -       smp_mb();
> -       try_to_freeze();
> -}
> -
> -/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
> -static inline void freezer_count_unsafe(void)
> -{
> -       current->flags &= ~PF_FREEZER_SKIP;
> -       smp_mb();
> -       try_to_freeze_unsafe();
> -}
> -
> -/**
> - * freezer_should_skip - whether to skip a task when determining frozen
> - *                      state is reached
> - * @p: task in quesion
> - *
> - * This function is used by freezers after establishing %true freezing() to
> - * test whether a task should be skipped when determining the target frozen
> - * state is reached.  IOW, if this function returns %true, @p is considered
> - * frozen enough.
> - */
> -static inline bool freezer_should_skip(struct task_struct *p)
> -{
> -       /*
> -        * The following smp_mb() paired with the one in freezer_count()
> -        * ensures that either freezer_count() sees %true freezing() or we
> -        * see cleared %PF_FREEZER_SKIP and return %false.  This makes it
> -        * impossible for a task to slip frozen state testing after
> -        * clearing %PF_FREEZER_SKIP.
> -        */
> -       smp_mb();
> -       return p->flags & PF_FREEZER_SKIP;
> -}
> -
> -/*
> - * These functions are intended to be used whenever you want allow a sleeping
> - * task to be frozen. Note that neither return any clear indication of
> - * whether a freeze event happened while in this function.
> - */
> -
> -/* Like schedule(), but should not block the freezer. */
> -static inline void freezable_schedule(void)
> -{
> -       freezer_do_not_count();
> -       schedule();
> -       freezer_count();
> -}
> -
> -/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
> -static inline void freezable_schedule_unsafe(void)
> -{
> -       freezer_do_not_count();
> -       schedule();
> -       freezer_count_unsafe();
> -}
> -
> -/*
> - * Like schedule_timeout(), but should not block the freezer.  Do not
> - * call this with locks held.
> - */
> -static inline long freezable_schedule_timeout(long timeout)
> -{
> -       long __retval;
> -       freezer_do_not_count();
> -       __retval = schedule_timeout(timeout);
> -       freezer_count();
> -       return __retval;
> -}
> -
> -/*
> - * Like schedule_timeout_interruptible(), but should not block the freezer.  Do not
> - * call this with locks held.
> - */
> -static inline long freezable_schedule_timeout_interruptible(long timeout)
> -{
> -       long __retval;
> -       freezer_do_not_count();
> -       __retval = schedule_timeout_interruptible(timeout);
> -       freezer_count();
> -       return __retval;
> -}
> -
> -/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
> -static inline long freezable_schedule_timeout_interruptible_unsafe(long timeout)
> -{
> -       long __retval;
> -
> -       freezer_do_not_count();
> -       __retval = schedule_timeout_interruptible(timeout);
> -       freezer_count_unsafe();
> -       return __retval;
> -}
> -
> -/* Like schedule_timeout_killable(), but should not block the freezer. */
> -static inline long freezable_schedule_timeout_killable(long timeout)
> -{
> -       long __retval;
> -       freezer_do_not_count();
> -       __retval = schedule_timeout_killable(timeout);
> -       freezer_count();
> -       return __retval;
> -}
> -
> -/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
> -static inline long freezable_schedule_timeout_killable_unsafe(long timeout)
> -{
> -       long __retval;
> -       freezer_do_not_count();
> -       __retval = schedule_timeout_killable(timeout);
> -       freezer_count_unsafe();
> -       return __retval;
> -}
> -
> -/*
> - * Like schedule_hrtimeout_range(), but should not block the freezer.  Do not
> - * call this with locks held.
> - */
> -static inline int freezable_schedule_hrtimeout_range(ktime_t *expires,
> -               u64 delta, const enum hrtimer_mode mode)
> -{
> -       int __retval;
> -       freezer_do_not_count();
> -       __retval = schedule_hrtimeout_range(expires, delta, mode);
> -       freezer_count();
> -       return __retval;
> -}
> -
> -/*
> - * Freezer-friendly wrappers around wait_event_interruptible(),
> - * wait_event_killable() and wait_event_interruptible_timeout(), originally
> - * defined in <linux/wait.h>
> - */
> -
> -/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
> -#define wait_event_freezekillable_unsafe(wq, condition)                        \
> -({                                                                     \
> -       int __retval;                                                   \
> -       freezer_do_not_count();                                         \
> -       __retval = wait_event_killable(wq, (condition));                \
> -       freezer_count_unsafe();                                         \
> -       __retval;                                                       \
> -})
> -
>  #else /* !CONFIG_FREEZER */
>  static inline bool frozen(struct task_struct *p) { return false; }
>  static inline bool freezing(struct task_struct *p) { return false; }
> @@ -281,35 +83,8 @@ static inline void thaw_kernel_threads(v
>
>  static inline bool try_to_freeze(void) { return false; }
>
> -static inline void freezer_do_not_count(void) {}
> -static inline void freezer_count(void) {}
> -static inline int freezer_should_skip(struct task_struct *p) { return 0; }
>  static inline void set_freezable(void) {}
>
> -#define freezable_schedule()  schedule()
> -
> -#define freezable_schedule_unsafe()  schedule()
> -
> -#define freezable_schedule_timeout(timeout)  schedule_timeout(timeout)
> -
> -#define freezable_schedule_timeout_interruptible(timeout)              \
> -       schedule_timeout_interruptible(timeout)
> -
> -#define freezable_schedule_timeout_interruptible_unsafe(timeout)       \
> -       schedule_timeout_interruptible(timeout)
> -
> -#define freezable_schedule_timeout_killable(timeout)                   \
> -       schedule_timeout_killable(timeout)
> -
> -#define freezable_schedule_timeout_killable_unsafe(timeout)            \
> -       schedule_timeout_killable(timeout)
> -
> -#define freezable_schedule_hrtimeout_range(expires, delta, mode)       \
> -       schedule_hrtimeout_range(expires, delta, mode)
> -
> -#define wait_event_freezekillable_unsafe(wq, condition)                        \
> -               wait_event_killable(wq, condition)
> -
>  #endif /* !CONFIG_FREEZER */
>
>  #endif /* FREEZER_H_INCLUDED */
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -81,25 +81,32 @@ struct task_group;
>   */
>
>  /* Used in tsk->state: */
> -#define TASK_RUNNING                   0x0000
> -#define TASK_INTERRUPTIBLE             0x0001
> -#define TASK_UNINTERRUPTIBLE           0x0002
> -#define __TASK_STOPPED                 0x0004
> -#define __TASK_TRACED                  0x0008
> +#define TASK_RUNNING                   0x000000
> +#define TASK_INTERRUPTIBLE             0x000001
> +#define TASK_UNINTERRUPTIBLE           0x000002
> +#define __TASK_STOPPED                 0x000004
> +#define __TASK_TRACED                  0x000008
>  /* Used in tsk->exit_state: */
> -#define EXIT_DEAD                      0x0010
> -#define EXIT_ZOMBIE                    0x0020
> +#define EXIT_DEAD                      0x000010
> +#define EXIT_ZOMBIE                    0x000020
>  #define EXIT_TRACE                     (EXIT_ZOMBIE | EXIT_DEAD)
>  /* Used in tsk->state again: */
> -#define TASK_PARKED                    0x0040
> -#define TASK_DEAD                      0x0080
> -#define TASK_WAKEKILL                  0x0100
> -#define TASK_WAKING                    0x0200
> -#define TASK_NOLOAD                    0x0400
> -#define TASK_NEW                       0x0800
> -/* RT specific auxilliary flag to mark RT lock waiters */
> -#define TASK_RTLOCK_WAIT               0x1000
> -#define TASK_STATE_MAX                 0x2000
> +#define TASK_PARKED                    0x000040
> +#define TASK_DEAD                      0x000080
> +#define TASK_WAKEKILL                  0x000100
> +#define TASK_WAKING                    0x000200
> +#define TASK_NOLOAD                    0x000400
> +#define TASK_NEW                       0x000800
> +#define TASK_FREEZABLE                 0x001000
> +#define __TASK_FREEZABLE_UNSAFE               (0x002000 * IS_ENABLED(CONFIG_LOCKDEP))
> +#define TASK_FROZEN                    0x004000
> +#define TASK_RTLOCK_WAIT               0x008000
> +#define TASK_STATE_MAX                 0x010000
> +
> +/*
> + * DO NOT ADD ANY NEW USERS !
> + */
> +#define TASK_FREEZABLE_UNSAFE          (TASK_FREEZABLE | __TASK_FREEZABLE_UNSAFE)
>
>  /* Convenience macros for the sake of set_current_state: */
>  #define TASK_KILLABLE                  (TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
> @@ -1714,7 +1721,6 @@ extern struct pid *cad_pid;
>  #define PF_NPROC_EXCEEDED      0x00001000      /* set_user() noticed that RLIMIT_NPROC was exceeded */
>  #define PF_USED_MATH           0x00002000      /* If unset the fpu must be initialized before use */
>  #define PF_NOFREEZE            0x00008000      /* This thread should not be frozen */
> -#define PF_FROZEN              0x00010000      /* Frozen for system suspend */
>  #define PF_KSWAPD              0x00020000      /* I am kswapd */
>  #define PF_MEMALLOC_NOFS       0x00040000      /* All allocation requests will inherit GFP_NOFS */
>  #define PF_MEMALLOC_NOIO       0x00080000      /* All allocation requests will inherit GFP_NOIO */
> @@ -1725,7 +1731,6 @@ extern struct pid *cad_pid;
>  #define PF_NO_SETAFFINITY      0x04000000      /* Userland is not allowed to meddle with cpus_mask */
>  #define PF_MCE_EARLY           0x08000000      /* Early kill for mce process policy */
>  #define PF_MEMALLOC_PIN                0x10000000      /* Allocation context constrained to zones which allow long term pinning. */
> -#define PF_FREEZER_SKIP                0x40000000      /* Freezer should not count it as freezable */
>  #define PF_SUSPEND_TASK                0x80000000      /* This thread called freeze_processes() and should not be frozen */
>
>  /*
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -252,7 +252,7 @@ int         rpc_malloc(struct rpc_task *);
>  void           rpc_free(struct rpc_task *);
>  int            rpciod_up(void);
>  void           rpciod_down(void);
> -int            __rpc_wait_for_completion_task(struct rpc_task *task, wait_bit_action_f *);
> +int            rpc_wait_for_completion_task(struct rpc_task *task);
>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>  struct net;
>  void           rpc_show_tasks(struct net *);
> @@ -264,11 +264,6 @@ extern struct workqueue_struct *xprtiod_
>  void           rpc_prepare_task(struct rpc_task *task);
>  gfp_t          rpc_task_gfp_mask(void);
>
> -static inline int rpc_wait_for_completion_task(struct rpc_task *task)
> -{
> -       return __rpc_wait_for_completion_task(task, NULL);
> -}
> -
>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
>  static inline const char * rpc_qname(const struct rpc_wait_queue *q)
>  {
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -361,8 +361,8 @@ do {                                                                                \
>  } while (0)
>
>  #define __wait_event_freezable(wq_head, condition)                             \
> -       ___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0,             \
> -                           freezable_schedule())
> +       ___wait_event(wq_head, condition, (TASK_INTERRUPTIBLE|TASK_FREEZABLE),  \
> +                       0, 0, schedule())
>
>  /**
>   * wait_event_freezable - sleep (or freeze) until a condition gets true
> @@ -420,8 +420,8 @@ do {                                                                                \
>
>  #define __wait_event_freezable_timeout(wq_head, condition, timeout)            \
>         ___wait_event(wq_head, ___wait_cond_timeout(condition),                 \
> -                     TASK_INTERRUPTIBLE, 0, timeout,                           \
> -                     __ret = freezable_schedule_timeout(__ret))
> +                     (TASK_INTERRUPTIBLE|TASK_FREEZABLE), 0, timeout,          \
> +                     __ret = schedule_timeout(__ret))
>
>  /*
>   * like wait_event_timeout() -- except it uses TASK_INTERRUPTIBLE to avoid
> @@ -642,8 +642,8 @@ do {                                                                                \
>
>
>  #define __wait_event_freezable_exclusive(wq, condition)                                \
> -       ___wait_event(wq, condition, TASK_INTERRUPTIBLE, 1, 0,                  \
> -                       freezable_schedule())
> +       ___wait_event(wq, condition, (TASK_INTERRUPTIBLE|TASK_FREEZABLE), 1, 0,\
> +                       schedule())
>
>  #define wait_event_freezable_exclusive(wq, condition)                          \
>  ({                                                                             \
> --- a/kernel/cgroup/legacy_freezer.c
> +++ b/kernel/cgroup/legacy_freezer.c
> @@ -113,7 +113,7 @@ static int freezer_css_online(struct cgr
>
>         if (parent && (parent->state & CGROUP_FREEZING)) {
>                 freezer->state |= CGROUP_FREEZING_PARENT | CGROUP_FROZEN;
> -               atomic_inc(&system_freezing_cnt);
> +               static_branch_inc(&freezer_active);
>         }
>
>         mutex_unlock(&freezer_mutex);
> @@ -134,7 +134,7 @@ static void freezer_css_offline(struct c
>         mutex_lock(&freezer_mutex);
>
>         if (freezer->state & CGROUP_FREEZING)
> -               atomic_dec(&system_freezing_cnt);
> +               static_branch_dec(&freezer_active);
>
>         freezer->state = 0;
>
> @@ -179,6 +179,7 @@ static void freezer_attach(struct cgroup
>                         __thaw_task(task);
>                 } else {
>                         freeze_task(task);
> +
>                         /* clear FROZEN and propagate upwards */
>                         while (freezer && (freezer->state & CGROUP_FROZEN)) {
>                                 freezer->state &= ~CGROUP_FROZEN;
> @@ -271,16 +272,8 @@ static void update_if_frozen(struct cgro
>         css_task_iter_start(css, 0, &it);
>
>         while ((task = css_task_iter_next(&it))) {
> -               if (freezing(task)) {
> -                       /*
> -                        * freezer_should_skip() indicates that the task
> -                        * should be skipped when determining freezing
> -                        * completion.  Consider it frozen in addition to
> -                        * the usual frozen condition.
> -                        */
> -                       if (!frozen(task) && !freezer_should_skip(task))
> -                               goto out_iter_end;
> -               }
> +               if (freezing(task) && !frozen(task))
> +                       goto out_iter_end;
>         }
>
>         freezer->state |= CGROUP_FROZEN;
> @@ -357,7 +350,7 @@ static void freezer_apply_state(struct f
>
>         if (freeze) {
>                 if (!(freezer->state & CGROUP_FREEZING))
> -                       atomic_inc(&system_freezing_cnt);
> +                       static_branch_inc(&freezer_active);
>                 freezer->state |= state;
>                 freeze_cgroup(freezer);
>         } else {
> @@ -366,9 +359,9 @@ static void freezer_apply_state(struct f
>                 freezer->state &= ~state;
>
>                 if (!(freezer->state & CGROUP_FREEZING)) {
> -                       if (was_freezing)
> -                               atomic_dec(&system_freezing_cnt);
>                         freezer->state &= ~CGROUP_FROZEN;
> +                       if (was_freezing)
> +                               static_branch_dec(&freezer_active);
>                         unfreeze_cgroup(freezer);
>                 }
>         }
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -374,10 +374,10 @@ static void coredump_task_exit(struct ta
>                         complete(&core_state->startup);
>
>                 for (;;) {
> -                       set_current_state(TASK_UNINTERRUPTIBLE);
> +                       set_current_state(TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
>                         if (!self.task) /* see coredump_finish() */
>                                 break;
> -                       freezable_schedule();
> +                       schedule();
>                 }
>                 __set_current_state(TASK_RUNNING);
>         }
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1420,13 +1420,12 @@ static void complete_vfork_done(struct t
>  static int wait_for_vfork_done(struct task_struct *child,
>                                 struct completion *vfork)
>  {
> +       unsigned int state = TASK_UNINTERRUPTIBLE|TASK_KILLABLE|TASK_FREEZABLE;
>         int killed;
>
> -       freezer_do_not_count();
>         cgroup_enter_frozen();
> -       killed = wait_for_completion_killable(vfork);
> +       killed = wait_for_completion_state(vfork, state);
>         cgroup_leave_frozen(false);
> -       freezer_count();
>
>         if (killed) {
>                 task_lock(child);
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -13,10 +13,11 @@
>  #include <linux/kthread.h>
>
>  /* total number of freezing conditions in effect */
> -atomic_t system_freezing_cnt = ATOMIC_INIT(0);
> -EXPORT_SYMBOL(system_freezing_cnt);
> +DEFINE_STATIC_KEY_FALSE(freezer_active);
> +EXPORT_SYMBOL(freezer_active);
>
> -/* indicate whether PM freezing is in effect, protected by
> +/*
> + * indicate whether PM freezing is in effect, protected by
>   * system_transition_mutex
>   */
>  bool pm_freezing;
> @@ -29,7 +30,7 @@ static DEFINE_SPINLOCK(freezer_lock);
>   * freezing_slow_path - slow path for testing whether a task needs to be frozen
>   * @p: task to be tested
>   *
> - * This function is called by freezing() if system_freezing_cnt isn't zero
> + * This function is called by freezing() if freezer_active isn't zero
>   * and tests whether @p needs to enter and stay in frozen state.  Can be
>   * called under any context.  The freezers are responsible for ensuring the
>   * target tasks see the updated state.
> @@ -52,41 +53,40 @@ bool freezing_slow_path(struct task_stru
>  }
>  EXPORT_SYMBOL(freezing_slow_path);
>
> +bool frozen(struct task_struct *p)
> +{
> +       return READ_ONCE(p->__state) & TASK_FROZEN;
> +}
> +
>  /* Refrigerator is place where frozen processes are stored :-). */
>  bool __refrigerator(bool check_kthr_stop)
>  {
> -       /* Hmm, should we be allowed to suspend when there are realtime
> -          processes around? */
> +       unsigned int state = get_current_state();
>         bool was_frozen = false;
> -       unsigned int save = get_current_state();
>
>         pr_debug("%s entered refrigerator\n", current->comm);
>
> +       WARN_ON_ONCE(state && !(state & TASK_NORMAL));
> +
>         for (;;) {
> -               set_current_state(TASK_UNINTERRUPTIBLE);
> +               bool freeze;
> +
> +               set_current_state(TASK_FROZEN);
>
>                 spin_lock_irq(&freezer_lock);
> -               current->flags |= PF_FROZEN;
> -               if (!freezing(current) ||
> -                   (check_kthr_stop && kthread_should_stop()))
> -                       current->flags &= ~PF_FROZEN;
> +               freeze = freezing(current) && !(check_kthr_stop && kthread_should_stop());
>                 spin_unlock_irq(&freezer_lock);
>
> -               if (!(current->flags & PF_FROZEN))
> +               if (!freeze)
>                         break;
> +
>                 was_frozen = true;
>                 schedule();
>         }
> +       __set_current_state(TASK_RUNNING);
>
>         pr_debug("%s left refrigerator\n", current->comm);
>
> -       /*
> -        * Restore saved task state before returning.  The mb'd version
> -        * needs to be used; otherwise, it might silently break
> -        * synchronization which depends on ordered task state change.
> -        */
> -       set_current_state(save);
> -
>         return was_frozen;
>  }
>  EXPORT_SYMBOL(__refrigerator);
> @@ -101,6 +101,44 @@ static void fake_signal_wake_up(struct t
>         }
>  }
>
> +static int __set_task_frozen(struct task_struct *p, void *arg)
> +{
> +       unsigned int state = READ_ONCE(p->__state);
> +
> +       if (p->on_rq)
> +               return 0;
> +
> +       if (p != current && task_curr(p))
> +               return 0;
> +
> +       if (!(state & (TASK_FREEZABLE | __TASK_STOPPED | __TASK_TRACED)))
> +               return 0;
> +
> +       /*
> +        * Only TASK_NORMAL can be augmented with TASK_FREEZABLE, since they
> +        * can suffer spurious wakeups.
> +        */
> +       if (state & TASK_FREEZABLE)
> +               WARN_ON_ONCE(!(state & TASK_NORMAL));
> +
> +#ifdef CONFIG_LOCKDEP
> +       /*
> +        * It's dangerous to freeze with locks held; there be dragons there.
> +        */
> +       if (!(state & __TASK_FREEZABLE_UNSAFE))
> +               WARN_ON_ONCE(debug_locks && p->lockdep_depth);
> +#endif
> +
> +       WRITE_ONCE(p->__state, TASK_FROZEN);
> +       return TASK_FROZEN;
> +}
> +
> +static bool __freeze_task(struct task_struct *p)
> +{
> +       /* TASK_FREEZABLE|TASK_STOPPED|TASK_TRACED -> TASK_FROZEN */
> +       return task_call_func(p, __set_task_frozen, NULL);
> +}
> +
>  /**
>   * freeze_task - send a freeze request to given task
>   * @p: task to send the request to
> @@ -116,20 +154,8 @@ bool freeze_task(struct task_struct *p)
>  {
>         unsigned long flags;
>
> -       /*
> -        * This check can race with freezer_do_not_count, but worst case that
> -        * will result in an extra wakeup being sent to the task.  It does not
> -        * race with freezer_count(), the barriers in freezer_count() and
> -        * freezer_should_skip() ensure that either freezer_count() sees
> -        * freezing == true in try_to_freeze() and freezes, or
> -        * freezer_should_skip() sees !PF_FREEZE_SKIP and freezes the task
> -        * normally.
> -        */
> -       if (freezer_should_skip(p))
> -               return false;
> -
>         spin_lock_irqsave(&freezer_lock, flags);
> -       if (!freezing(p) || frozen(p)) {
> +       if (!freezing(p) || frozen(p) || __freeze_task(p)) {
>                 spin_unlock_irqrestore(&freezer_lock, flags);
>                 return false;
>         }
> @@ -137,19 +163,52 @@ bool freeze_task(struct task_struct *p)
>         if (!(p->flags & PF_KTHREAD))
>                 fake_signal_wake_up(p);
>         else
> -               wake_up_state(p, TASK_INTERRUPTIBLE);
> +               wake_up_state(p, TASK_NORMAL);
>
>         spin_unlock_irqrestore(&freezer_lock, flags);
>         return true;
>  }
>
> +/*
> + * The special task states (TASK_STOPPED, TASK_TRACED) keep their canonical
> + * state in p->jobctl. If either of them got a wakeup that was missed because
> + * TASK_FROZEN, then their canonical state reflects that and the below will
> + * refuse to restore the special state and instead issue the wakeup.
> + */
> +static int __set_task_special(struct task_struct *p, void *arg)
> +{
> +       unsigned int state = 0;
> +
> +       if (p->jobctl & JOBCTL_TRACED)
> +               state = TASK_TRACED;
> +
> +       else if (p->jobctl & JOBCTL_STOPPED)
> +               state = TASK_STOPPED;
> +
> +       if (state)
> +               WRITE_ONCE(p->__state, state);
> +
> +       return state;
> +}
> +
>  void __thaw_task(struct task_struct *p)
>  {
> -       unsigned long flags;
> +       unsigned long flags, flags2;
>
>         spin_lock_irqsave(&freezer_lock, flags);
> -       if (frozen(p))
> -               wake_up_process(p);
> +       if (WARN_ON_ONCE(freezing(p)))
> +               goto unlock;
> +
> +       if (lock_task_sighand(p, &flags2)) {
> +               /* TASK_FROZEN -> TASK_{STOPPED,TRACED} */
> +               bool ret = task_call_func(p, __set_task_special, NULL);
> +               unlock_task_sighand(p, &flags2);
> +               if (ret)
> +                       goto unlock;
> +       }
> +
> +       wake_up_state(p, TASK_FROZEN);
> +unlock:
>         spin_unlock_irqrestore(&freezer_lock, flags);
>  }
>
> --- a/kernel/futex/waitwake.c
> +++ b/kernel/futex/waitwake.c
> @@ -334,7 +334,7 @@ void futex_wait_queue(struct futex_hash_
>          * futex_queue() calls spin_unlock() upon completion, both serializing
>          * access to the hash list and forcing another memory barrier.
>          */
> -       set_current_state(TASK_INTERRUPTIBLE);
> +       set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
>         futex_queue(q, hb);
>
>         /* Arm the timer */
> @@ -352,7 +352,7 @@ void futex_wait_queue(struct futex_hash_
>                  * is no timeout, or if it has yet to expire.
>                  */
>                 if (!timeout || timeout->task)
> -                       freezable_schedule();
> +                       schedule();
>         }
>         __set_current_state(TASK_RUNNING);
>  }
> @@ -430,7 +430,7 @@ static int futex_wait_multiple_setup(str
>                         return ret;
>         }
>
> -       set_current_state(TASK_INTERRUPTIBLE);
> +       set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
>
>         for (i = 0; i < count; i++) {
>                 u32 __user *uaddr = (u32 __user *)(unsigned long)vs[i].w.uaddr;
> @@ -504,7 +504,7 @@ static void futex_sleep_multiple(struct
>                         return;
>         }
>
> -       freezable_schedule();
> +       schedule();
>  }
>
>  /**
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -95,8 +95,8 @@ static void check_hung_task(struct task_
>          * Ensure the task is not frozen.
>          * Also, skip vfork and any other user process that freezer should skip.
>          */
> -       if (unlikely(t->flags & (PF_FROZEN | PF_FREEZER_SKIP)))
> -           return;
> +       if (unlikely(READ_ONCE(t->__state) & (TASK_FREEZABLE | TASK_FROZEN)))
> +               return;
>
>         /*
>          * When a freshly created task is scheduled once, changes its state to
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -24,7 +24,7 @@
>  unsigned int lock_system_sleep(void)
>  {
>         unsigned int flags = current->flags;
> -       current->flags |= PF_FREEZER_SKIP;
> +       current->flags |= PF_NOFREEZE;
>         mutex_lock(&system_transition_mutex);
>         return flags;
>  }
> @@ -48,8 +48,8 @@ void unlock_system_sleep(unsigned int fl
>          * Which means, if we use try_to_freeze() here, it would make them
>          * enter the refrigerator, thus causing hibernation to lockup.
>          */
> -       if (!(flags & PF_FREEZER_SKIP))
> -               current->flags &= ~PF_FREEZER_SKIP;
> +       if (!(flags & PF_NOFREEZE))
> +               current->flags &= ~PF_NOFREEZE;
>         mutex_unlock(&system_transition_mutex);
>  }
>  EXPORT_SYMBOL_GPL(unlock_system_sleep);
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -50,8 +50,7 @@ static int try_to_freeze_tasks(bool user
>                         if (p == current || !freeze_task(p))
>                                 continue;
>
> -                       if (!freezer_should_skip(p))
> -                               todo++;
> +                       todo++;
>                 }
>                 read_unlock(&tasklist_lock);
>
> @@ -96,8 +95,7 @@ static int try_to_freeze_tasks(bool user
>                 if (!wakeup || pm_debug_messages_on) {
>                         read_lock(&tasklist_lock);
>                         for_each_process_thread(g, p) {
> -                               if (p != current && !freezer_should_skip(p)
> -                                   && freezing(p) && !frozen(p))
> +                               if (p != current && freezing(p) && !frozen(p))
>                                         sched_show_task(p);
>                         }
>                         read_unlock(&tasklist_lock);
> @@ -129,7 +127,7 @@ int freeze_processes(void)
>         current->flags |= PF_SUSPEND_TASK;
>
>         if (!pm_freezing)
> -               atomic_inc(&system_freezing_cnt);
> +               static_branch_inc(&freezer_active);
>
>         pm_wakeup_clear(0);
>         pr_info("Freezing user space processes ... ");
> @@ -190,7 +188,7 @@ void thaw_processes(void)
>
>         trace_suspend_resume(TPS("thaw_processes"), 0, true);
>         if (pm_freezing)
> -               atomic_dec(&system_freezing_cnt);
> +               static_branch_dec(&freezer_active);
>         pm_freezing = false;
>         pm_nosig_freezing = false;
>
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -269,7 +269,7 @@ static int ptrace_check_attach(struct ta
>         read_unlock(&tasklist_lock);
>
>         if (!ret && !ignore_state &&
> -           WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
> +           WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED|TASK_FROZEN)))
>                 ret = -ESRCH;
>
>         return ret;
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6429,7 +6429,7 @@ static void __sched notrace __schedule(u
>                         prev->sched_contributes_to_load =
>                                 (prev_state & TASK_UNINTERRUPTIBLE) &&
>                                 !(prev_state & TASK_NOLOAD) &&
> -                               !(prev->flags & PF_FROZEN);
> +                               !(prev_state & TASK_FROZEN);
>
>                         if (prev->sched_contributes_to_load)
>                                 rq->nr_uninterruptible++;
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2304,7 +2304,7 @@ static int ptrace_stop(int exit_code, in
>         read_unlock(&tasklist_lock);
>         cgroup_enter_frozen();
>         preempt_enable_no_resched();
> -       freezable_schedule();
> +       schedule();
>         cgroup_leave_frozen(true);
>
>         /*
> @@ -2473,7 +2473,7 @@ static bool do_signal_stop(int signr)
>
>                 /* Now we don't run again until woken by SIGCONT or SIGKILL */
>                 cgroup_enter_frozen();
> -               freezable_schedule();
> +               schedule();
>                 return true;
>         } else {
>                 /*
> @@ -2548,11 +2548,11 @@ static void do_freezer_trap(void)
>          * immediately (if there is a non-fatal signal pending), and
>          * put the task into sleep.
>          */
> -       __set_current_state(TASK_INTERRUPTIBLE);
> +       __set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
>         clear_thread_flag(TIF_SIGPENDING);
>         spin_unlock_irq(&current->sighand->siglock);
>         cgroup_enter_frozen();
> -       freezable_schedule();
> +       schedule();
>  }
>
>  static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
> @@ -3600,9 +3600,9 @@ static int do_sigtimedwait(const sigset_
>                 recalc_sigpending();
>                 spin_unlock_irq(&tsk->sighand->siglock);
>
> -               __set_current_state(TASK_INTERRUPTIBLE);
> -               ret = freezable_schedule_hrtimeout_range(to, tsk->timer_slack_ns,
> -                                                        HRTIMER_MODE_REL);
> +               __set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
> +               ret = schedule_hrtimeout_range(to, tsk->timer_slack_ns,
> +                                              HRTIMER_MODE_REL);
>                 spin_lock_irq(&tsk->sighand->siglock);
>                 __set_task_blocked(tsk, &tsk->real_blocked);
>                 sigemptyset(&tsk->real_blocked);
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -2037,11 +2037,11 @@ static int __sched do_nanosleep(struct h
>         struct restart_block *restart;
>
>         do {
> -               set_current_state(TASK_INTERRUPTIBLE);
> +               set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
>                 hrtimer_sleeper_start_expires(t, mode);
>
>                 if (likely(t->task))
> -                       freezable_schedule();
> +                       schedule();
>
>                 hrtimer_cancel(&t->timer);
>                 mode = HRTIMER_MODE_ABS;
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -404,6 +404,7 @@ EXPORT_SYMBOL(call_usermodehelper_setup)
>   */
>  int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>  {
> +       unsigned int state = TASK_UNINTERRUPTIBLE;
>         DECLARE_COMPLETION_ONSTACK(done);
>         int retval = 0;
>
> @@ -437,25 +438,22 @@ int call_usermodehelper_exec(struct subp
>         if (wait == UMH_NO_WAIT)        /* task has freed sub_info */
>                 goto unlock;
>
> +       if (wait & UMH_KILLABLE)
> +               state |= TASK_KILLABLE;
> +
>         if (wait & UMH_FREEZABLE)
> -               freezer_do_not_count();
> +               state |= TASK_FREEZABLE;
>
> -       if (wait & UMH_KILLABLE) {
> -               retval = wait_for_completion_killable(&done);
> -               if (!retval)
> -                       goto wait_done;
> +       retval = wait_for_completion_state(&done, state);
> +       if (!retval)
> +               goto wait_done;
>
> +       if (wait & UMH_KILLABLE) {
>                 /* umh_complete() will see NULL and free sub_info */
>                 if (xchg(&sub_info->complete, NULL))
>                         goto unlock;
> -               /* fallthrough, umh_complete() was already called */
>         }
>
> -       wait_for_completion(&done);
> -
> -       if (wait & UMH_FREEZABLE)
> -               freezer_count();
> -
>  wait_done:
>         retval = sub_info->retval;
>  out:
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -730,8 +730,8 @@ static void khugepaged_alloc_sleep(void)
>         DEFINE_WAIT(wait);
>
>         add_wait_queue(&khugepaged_wait, &wait);
> -       freezable_schedule_timeout_interruptible(
> -               msecs_to_jiffies(khugepaged_alloc_sleep_millisecs));
> +       __set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
> +       schedule_timeout(msecs_to_jiffies(khugepaged_alloc_sleep_millisecs));
>         remove_wait_queue(&khugepaged_wait, &wait);
>  }
>
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -269,7 +269,7 @@ EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue
>
>  static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
>  {
> -       freezable_schedule_unsafe();
> +       schedule();
>         if (signal_pending_state(mode, current))
>                 return -ERESTARTSYS;
>         return 0;
> @@ -333,14 +333,12 @@ static int rpc_complete_task(struct rpc_
>   * to enforce taking of the wq->lock and hence avoid races with
>   * rpc_complete_task().
>   */
> -int __rpc_wait_for_completion_task(struct rpc_task *task, wait_bit_action_f *action)
> +int rpc_wait_for_completion_task(struct rpc_task *task)
>  {
> -       if (action == NULL)
> -               action = rpc_wait_bit_killable;
>         return out_of_line_wait_on_bit(&task->tk_runstate, RPC_TASK_ACTIVE,
> -                       action, TASK_KILLABLE);
> +                       rpc_wait_bit_killable, TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
>  }
> -EXPORT_SYMBOL_GPL(__rpc_wait_for_completion_task);
> +EXPORT_SYMBOL_GPL(rpc_wait_for_completion_task);
>
>  /*
>   * Make an RPC task runnable.
> @@ -964,7 +962,7 @@ static void __rpc_execute(struct rpc_tas
>                 trace_rpc_task_sync_sleep(task, task->tk_action);
>                 status = out_of_line_wait_on_bit(&task->tk_runstate,
>                                 RPC_TASK_QUEUED, rpc_wait_bit_killable,
> -                               TASK_KILLABLE);
> +                               TASK_KILLABLE|TASK_FREEZABLE);
>                 if (status < 0) {
>                         /*
>                          * When a sync task receives a signal, it exits with
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2543,13 +2543,14 @@ static long unix_stream_data_wait(struct
>                                   struct sk_buff *last, unsigned int last_len,
>                                   bool freezable)
>  {
> +       unsigned int state = TASK_INTERRUPTIBLE | freezable * TASK_FREEZABLE;
>         struct sk_buff *tail;
>         DEFINE_WAIT(wait);
>
>         unix_state_lock(sk);
>
>         for (;;) {
> -               prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
> +               prepare_to_wait(sk_sleep(sk), &wait, state);
>
>                 tail = skb_peek_tail(&sk->sk_receive_queue);
>                 if (tail != last ||
> @@ -2562,10 +2563,7 @@ static long unix_stream_data_wait(struct
>
>                 sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>                 unix_state_unlock(sk);
> -               if (freezable)
> -                       timeo = freezable_schedule_timeout(timeo);
> -               else
> -                       timeo = schedule_timeout(timeo);
> +               timeo = schedule_timeout(timeo);
>                 unix_state_lock(sk);
>
>                 if (sock_flag(sk, SOCK_DEAD))
>
>
