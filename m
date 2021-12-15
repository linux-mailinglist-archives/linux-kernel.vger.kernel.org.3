Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF043475C26
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244109AbhLOPrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:47:13 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:15578 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244103AbhLOPrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639583230; x=1671119230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5qdNyYy/u82NrJL4zXN50Jkwe+xtr/LrwhlU2vpvAtM=;
  b=YAhjFDAgnNEKJWNVgaTvswTTc8V2HKlX7d8JNSHwKqm8BztipY8ajL2a
   tndDFU3ivjAj9tWqhBQLz0zAitdFoBknPY86ffjjMjytf9J40sigO5WBJ
   HvQrBTqPb6rpPKqaBh6li7rT2ibqVQ2dQvR+x+2AypdHWJ/XZbNd5sGBn
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Dec 2021 07:47:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 07:47:08 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 15 Dec 2021 07:47:07 -0800
Received: from fixkernel.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 15 Dec
 2021 07:47:06 -0800
Date:   Wed, 15 Dec 2021 10:47:04 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Joel Savitz <jsavitz@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Waiman Long <longman@redhat.com>,
        <linux-mm@kvack.org>, Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] mm/oom_kill: wake futex waiters before annihilating
 victim shared mutex
Message-ID: <YboN+O3QuJw1Px+7@fixkernel.com>
References: <20211208181714.880312-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211208181714.880312-1-jsavitz@redhat.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 01:17:14PM -0500, Joel Savitz wrote:
> In the case that two or more processes share a futex located within
> a shared mmaped region, such as a process that shares a lock between
> itself and a number of child processes, we have observed that when
> a process holding the lock is oom killed, at least one waiter is never
> alerted to this new development and simply continues to wait.
> 
> This is visible via pthreads by checking the __owner field of the
> pthread_mutex_t structure within a waiting process, perhaps with gdb.
> 
> We identify reproduction of this issue by checking a waiting process of
> a test program and viewing the contents of the pthread_mutex_t, taking note
> of the value in the owner field, and then checking dmesg to see if the
> owner has already been killed.
> 
> This issue can be tricky to reproduce, but with the modifications of
> this small patch, I have found it to be impossible to reproduce. There
> may be additional considerations that I have not taken into account in
> this patch and I welcome any comments and criticism.
> 
> Changes from v1:
> - add comments before calls to futex_exit_release()
> 
> Co-developed-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>

I am afraid we can't call futex_exit_release() under rcu_read_lock()
because it might sleep.

 BUG: sleeping function called from invalid context at kernel/locking/mutex.c:577
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1509, name: lsbug
 preempt_count: 1, expected: 0
 3 locks held by lsbug/1509:
  #0: ffff00004de99c98 (&mm->mmap_lock){++++}-{3:3}, at: do_page_fault
  #1: ffff800010fd8308 (oom_lock){+.+.}-{3:3}, at: __alloc_pages_slowpath.constprop.0
  __alloc_pages_may_oom at /usr/src/linux-next/mm/page_alloc.c:4278
  (inlined by) __alloc_pages_slowpath at /usr/src/linux-next/mm/page_alloc.c:5058
  #2: ffff000867b3b0c0 (&p->alloc_lock){+.+.}-{2:2}, at: find_lock_task_mm
  find_lock_task_mm at /usr/src/linux-next/mm/oom_kill.c:145
 CPU: 5 PID: 1509 Comm: lsbug Not tainted 5.16.0-rc5-next-20211214+ #172
 Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  dump_stack
  __might_resched
  __might_sleep
  __mutex_lock
  mutex_lock_nested
  futex_cleanup_begin
  futex_cleanup_begin at /usr/src/linux-next/kernel/futex/core.c:1071
  futex_exit_release
  __oom_kill_process
  oom_kill_process
  out_of_memory
  __alloc_pages_slowpath.constprop.0
  __alloc_pages
  alloc_pages_vma
  alloc_zeroed_user_highpage_movable
  do_anonymous_page
  __handle_mm_fault
  handle_mm_fault
  do_page_fault
  do_translation_fault
  do_mem_abort
  el0_da
  el0t_64_sync_handler
  el0t_64_sync
 =============================
 [ BUG: Invalid wait context ]
 5.16.0-rc5-next-20211214+ #172 Tainted: G        W
 -----------------------------
 lsbug/1509 is trying to lock:
 ffff000867b3ba98 (&tsk->futex_exit_mutex){+.+.}-{3:3}, at: futex_cleanup_begin
 other info that might help us debug this:
 context-{4:4}
 3 locks held by lsbug/1509:
  #0: ffff00004de99c98 (&mm->mmap_lock){++++}-{3:3}, at: do_page_fault
  #1: ffff800010fd8308 (oom_lock){+.+.}-{3:3}, at: __alloc_pages_slowpath.constprop.0
  #2: ffff000867b3b0c0 (&p->alloc_lock){+.+.}-{2:2}, at: find_lock_task_mm
 stack backtrace:
 CPU: 5 PID: 1509 Comm: lsbug Tainted: G        W         5.16.0-rc5-next-20211214+ #172
 Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  dump_stack
  __lock_acquire
  lock_acquire
  __mutex_lock
  mutex_lock_nested
  futex_cleanup_begin
  futex_exit_release
  __oom_kill_process
  oom_kill_process
  out_of_memory
  __alloc_pages_slowpath.constprop.0
  __alloc_pages
  alloc_pages_vma
  alloc_zeroed_user_highpage_movable
  do_anonymous_page
  __handle_mm_fault
  handle_mm_fault
  do_page_fault
  do_translation_fault
  do_mem_abort
  el0_da
  el0t_64_sync_handler
  el0t_64_sync

> ---
>  mm/oom_kill.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 1ddabefcfb5a..884a5f15fd06 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -44,6 +44,7 @@
>  #include <linux/kthread.h>
>  #include <linux/init.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/futex.h>
>  
>  #include <asm/tlb.h>
>  #include "internal.h"
> @@ -885,6 +886,11 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  	count_vm_event(OOM_KILL);
>  	memcg_memory_event_mm(mm, MEMCG_OOM_KILL);
>  
> +	/*
> +	 * We call futex_exit_release() on the victim task to ensure any waiters on any
> +	 * process-shared futexes held by the victim task are woken up.
> +	 */
> +	futex_exit_release(victim);
>  	/*
>  	 * We should send SIGKILL before granting access to memory reserves
>  	 * in order to prevent the OOM victim from depleting the memory
> @@ -930,6 +936,12 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  		 */
>  		if (unlikely(p->flags & PF_KTHREAD))
>  			continue;
> +		/*
> +		 * We call futex_exit_release() on any task p sharing the
> +		 * victim->mm to ensure any waiters on any
> +		 * process-shared futexes held by task p are woken up.
> +		 */
> +		futex_exit_release(p);
>  		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
>  	}
>  	rcu_read_unlock();
> -- 
> 2.27.0
> 
