Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333114AC2AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443092AbiBGPKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376968AbiBGO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:57:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6410C0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:57:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2901361035
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01309C340EF;
        Mon,  7 Feb 2022 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644245841;
        bh=kzb5Aw0aPnUl4WNXBuhTG37J8Ce6ZRlVv0R/YerwJD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R8bez1N9rfVAexNhrOfhQOt86r1tpO+oSDvKpM+RSh7rYNMjSohLEJjMXkzsViwUH
         8pAOqaSFFR9H3sb6yFtDRLV0QUh+pKODVXvYQ9KofqMMMS1PedNHDs6ibZJH0PdwMH
         RiXdEzS6nvQ5WElqoPe+lQA4L5k9l2M/2umonMFFTiArKBlJ/mrNhq42FKxX/rmB4c
         nbeAtirB/qOES66NQdnYJmiDGAJKVJgOrmskqtjXwxAVniTyW1mbNeyQGeStyvN/co
         vUR9ZBQ6mLpGID11nYqBFsRtpDG10Yr4ed2zuigK5sJtoMY2ZBhQGltfxcZsqeVaVP
         pztSZalrrRqiw==
Date:   Mon, 7 Feb 2022 15:57:18 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v11 05/13] task isolation: sync vmstats on return to
 userspace
Message-ID: <20220207145718.GA523931@lothringen>
References: <20220204173537.429902988@fedora.localdomain>
 <20220204173554.676117258@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204173554.676117258@fedora.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 02:35:42PM -0300, Marcelo Tosatti wrote:
> The logic to disable vmstat worker thread, when entering
> nohz full, does not cover all scenarios. For example, it is possible
> for the following to happen:
> 
> 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> 2) app runs mlock, which increases counters for mlock'ed pages.
> 3) start -RT loop
> 
> Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> the mlock, vmstat shepherd can restart vmstat worker thread on
> the CPU in question.
> 
> To fix this, use the task isolation prctl interface to quiesce 
> deferred actions when returning to userspace.
> 
> This patch adds hooks to fork and exit code paths.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> v11: fold patch to add task_isol_exit hooks (Frederic)
>      Use _TIF_TASK_ISOL bit on thread flags (Frederic)
>      
> v6: modify exit_to_user_mode_loop to cover exceptions and interrupts
> v5: no changes
> v4: add oneshot mode support
> 
>  include/linux/task_isolation.h |   16 ++++++++++++++++
>  include/linux/vmstat.h         |    8 ++++++++
>  kernel/entry/common.c          |   15 +++++++++++----
>  kernel/task_isolation.c        |   21 +++++++++++++++++++++
>  mm/vmstat.c                    |   21 +++++++++++++++++++++
>  5 files changed, 77 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6/include/linux/task_isolation.h
> ===================================================================
> --- linux-2.6.orig/include/linux/task_isolation.h
> +++ linux-2.6/include/linux/task_isolation.h
> @@ -27,6 +27,13 @@ static inline void task_isol_free(struct
>  		__task_isol_free(tsk);
>  }
>  
> +void __task_isol_exit(struct task_struct *tsk);
> +static inline void task_isol_exit(struct task_struct *tsk)
> +{
> +	if (tsk->task_isol_info)
> +		__task_isol_exit(tsk);
> +}
> +
>  int prctl_task_isol_feat_get(unsigned long arg2, unsigned long arg3,
>  			     unsigned long arg4, unsigned long arg5);
>  int prctl_task_isol_cfg_get(unsigned long arg2, unsigned long arg3,
> @@ -40,12 +47,22 @@ int prctl_task_isol_activate_set(unsigne
>  
>  int __copy_task_isol(struct task_struct *tsk);
>  
> +void task_isol_exit_to_user_mode(void);
> +
>  #else
>  
> +static inline void task_isol_exit_to_user_mode(void)
> +{
> +}
> +
>  static inline void task_isol_free(struct task_struct *tsk)
>  {
>  }
>  
> +static inline void task_isol_exit(struct task_struct *tsk)
> +{
> +}
> +
>  static inline int prctl_task_isol_feat_get(unsigned long arg2,
>  					   unsigned long arg3,
>  					   unsigned long arg4,
> Index: linux-2.6/include/linux/vmstat.h
> ===================================================================
> --- linux-2.6.orig/include/linux/vmstat.h
> +++ linux-2.6/include/linux/vmstat.h
> @@ -21,6 +21,14 @@ int sysctl_vm_numa_stat_handler(struct c
>  		void *buffer, size_t *length, loff_t *ppos);
>  #endif
>  
> +#if defined(CONFIG_SMP) && defined(CONFIG_TASK_ISOLATION)
> +void sync_vmstat(void);
> +#else
> +static inline void sync_vmstat(void)
> +{
> +}
> +#endif
> +
>  struct reclaim_stat {
>  	unsigned nr_dirty;
>  	unsigned nr_unqueued_dirty;
> Index: linux-2.6/kernel/entry/common.c
> ===================================================================
> --- linux-2.6.orig/kernel/entry/common.c
> +++ linux-2.6/kernel/entry/common.c
> @@ -6,6 +6,7 @@
>  #include <linux/livepatch.h>
>  #include <linux/audit.h>
>  #include <linux/tick.h>
> +#include <linux/task_isolation.h>
>  
>  #include "common.h"
>  
> @@ -174,6 +175,9 @@ static unsigned long exit_to_user_mode_l
>  		if (ti_work & _TIF_NOTIFY_RESUME)
>  			tracehook_notify_resume(regs);
>  
> +		if (ti_work & _TIF_TASK_ISOL)
> +			task_isol_exit_to_user_mode();
> +
>  		/* Architecture specific TIF work */
>  		arch_exit_to_user_mode_work(regs, ti_work);
>  
> Index: linux-2.6/kernel/task_isolation.c
> ===================================================================
> --- linux-2.6.orig/kernel/task_isolation.c
> +++ linux-2.6/kernel/task_isolation.c
> @@ -18,6 +18,12 @@
>  #include <linux/sysfs.h>
>  #include <linux/init.h>
>  #include <linux/sched/task.h>
> +#include <linux/mm.h>
> +#include <linux/vmstat.h>
> +
> +void __task_isol_exit(struct task_struct *tsk)
> +{
> +}
>  
>  void __task_isol_free(struct task_struct *tsk)
>  {
> @@ -251,6 +257,9 @@ static int cfg_feat_quiesce_set(unsigned
>  	task_isol_info->quiesce_mask = i_qctrl->quiesce_mask;
>  	task_isol_info->oneshot_mask = i_qctrl->quiesce_oneshot_mask;
>  	task_isol_info->conf_mask |= ISOL_F_QUIESCE;
> +	if (task_isol_info->quiesce_mask & ISOL_F_QUIESCE_VMSTATS)
> +		set_thread_flag(TIF_TASK_ISOL);

Should you check if (i->active_mask == ISOL_F_QUIESCE) before setting the
flag?

> +
>  	ret = 0;
>  
>  out_free:
> @@ -303,6 +312,7 @@ int __copy_task_isol(struct task_struct
>  		new_info->active_mask = info->active_mask;
>  
>  	tsk->task_isol_info = new_info;
> +	set_ti_thread_flag(task_thread_info(tsk), TIF_TASK_ISOL);

Same here?

>  
>  	return 0;

Thanks.
