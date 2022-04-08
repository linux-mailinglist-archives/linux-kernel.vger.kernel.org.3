Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210FC4F8C76
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiDHDO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiDHDOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF16E12C265
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:12:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A02C61D8E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4FBC385A0;
        Fri,  8 Apr 2022 03:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649387571;
        bh=VR4GkFsdiJLCU9pHSAAHShct/B5o5RMhDlBrwSXdtwQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mDD5pR9abkTBdJqkGcNdPvkCM8JN4ND5jFNg895JITDmTXCElYReflCJ1r23y0UlR
         +vSorZvGdpAwSquuE7CzgJqXShlXeVaGII92UZQV+eA2ppgXwDyXz4zdwlLtt+yhq4
         i0weznBnRWPXRJJYK9prGoyqh5AKjpLcD1QZ+Gqc=
Date:   Thu, 7 Apr 2022 20:12:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: Re: [PATCH v7] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Message-Id: <20220407201250.b4ebaae0cb327cad7b2eb3cf@linux-foundation.org>
In-Reply-To: <20220408030137.3693195-1-npache@redhat.com>
References: <20220408030137.3693195-1-npache@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Apr 2022 23:01:37 -0400 Nico Pache <npache@redhat.com> wrote:

> The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
> be targeted by the oom reaper. This mapping is used to store the futex
> robust list head; the kernel does not keep a copy of the robust list and
> instead references a userspace address to maintain the robustness during
> a process death. A race can occur between exit_mm and the oom reaper that
> allows the oom reaper to free the memory of the futex robust list before
> the exit path has handled the futex death:
> 
>     CPU1                               CPU2
> ------------------------------------------------------------------------
>     page_fault
>     do_exit "signal"
>     wake_oom_reaper
>                                         oom_reaper
>                                         oom_reap_task_mm (invalidates mm)
>     exit_mm
>     exit_mm_release
>     futex_exit_release
>     futex_cleanup
>     exit_robust_list
>     get_user (EFAULT- can't access memory)
> 
> If the get_user EFAULT's, the kernel will be unable to recover the
> waiters on the robust_list, leaving userspace mutexes hung indefinitely.
> 
> Use the robust_list address stored in the kernel to skip the VMA that holds
> it, allowing a successful futex_cleanup.
> 
> Theoretically a failure can still occur if there are locks mapped as
> PRIVATE|ANON; however, the robust futexes are a best-effort approach.
> This patch only strengthens that best-effort.
> 
> The following case can still fail:
> robust head (skipped) -> private lock (reaped) -> shared lock (skipped)
> 
> Reproducer: https://gitlab.com/jsavitz/oom_futex_reproducer
> 
> [1] https://elixir.bootlin.com/glibc/latest/source/nptl/allocatestack.c#L370
> 
> ...
>
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -106,7 +106,7 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
>  	return 0;
>  }
>  
> -bool __oom_reap_task_mm(struct mm_struct *mm);
> +bool __oom_reap_task_mm(struct mm_struct *mm, void *robust_list);
>  
>  long oom_badness(struct task_struct *p,
>  		unsigned long totalpages);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3aa839f81e63..d5af1b83cbb2 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3109,6 +3109,11 @@ void exit_mmap(struct mm_struct *mm)
>  	struct mmu_gather tlb;
>  	struct vm_area_struct *vma;
>  	unsigned long nr_accounted = 0;
> +	void *robust_list;
> +
> +#ifdef CONFIG_FUTEX
> +	robust_list = current->robust_list;
> +#endif
>  
>  	/* mm's last user has gone, and its about to be pulled down */
>  	mmu_notifier_release(mm);
> @@ -3126,7 +3131,8 @@ void exit_mmap(struct mm_struct *mm)
>  		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
>  		 * __oom_reap_task_mm() will not block.
>  		 */
> -		(void)__oom_reap_task_mm(mm);
> +		(void)__oom_reap_task_mm(mm, robust_list);

uninitialized var warning when CONFIG_FUTEX=n?

> +
>  		set_bit(MMF_OOM_SKIP, &mm->flags);
>  	}
>  
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -509,9 +509,10 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
>  static struct task_struct *oom_reaper_list;
>  static DEFINE_SPINLOCK(oom_reaper_lock);
>  
> -bool __oom_reap_task_mm(struct mm_struct *mm)
> +bool __oom_reap_task_mm(struct mm_struct *mm, void *robust_list)

Well, this is no longer necessarily a robust_list*.  It's just an
address to skip and the name should reflect that?

>  {
>  	struct vm_area_struct *vma;
> +	unsigned long skip_vma = (unsigned long) robust_list;
>  	bool ret = true;
>  
>  	/*
> @@ -526,6 +527,20 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
>  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
>  			continue;
>  
> +#ifdef CONFIG_FUTEX
> +		/*
> +		 * The OOM reaper runs concurrently with do_exit.
> +		 * The robust_list_head is stored in userspace and is required
> +		 * by the exit path to recover the robust futex waiters.
> +		 * Skip the VMA that contains the robust_list to allow for
> +		 * proper cleanup.
> +		 */
> +		if (vma->vm_start <= skip_vma && vma->vm_end > skip_vma) {
> +			pr_info("oom_reaper: skipping vma, contains robust_list");
> +			continue;
> +		}
> +#endif
> +
>  		/*
>  		 * Only anonymous pages have a good chance to be dropped
>  		 * without additional steps which we cannot afford as we
> @@ -567,6 +582,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
>  static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>  {
>  	bool ret = true;
> +	void *robust_list;
>  
>  	if (!mmap_read_trylock(mm)) {
>  		trace_skip_task_reaping(tsk->pid);
> @@ -586,8 +602,11 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>  
>  	trace_start_task_reaping(tsk->pid);
>  
> +#ifdef CONFIG_FUTEX
> +	robust_list = tsk->robust_list;
> +#endif
>  	/* failed to reap part of the address space. Try again later */
> -	ret = __oom_reap_task_mm(mm);
> +	ret = __oom_reap_task_mm(mm, robust_list);

unintialized var when CONFIG_FUTEX=n?

>  	if (!ret)
>  		goto out_finish;
>  
> @@ -1149,6 +1168,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  	unsigned int f_flags;
>  	bool reap = false;
>  	long ret = 0;
> +	void *robust_list;
>  
>  	if (flags)
>  		return -EINVAL;
> @@ -1186,11 +1206,16 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  		ret = -EINTR;
>  		goto drop_mm;
>  	}
> +
> +#ifdef CONFIG_FUTEX
> +	robust_list = p->robust_list;
> +#endif
>  	/*
>  	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
>  	 * possible change in exit_mmap is seen
>  	 */
> -	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
> +	if (!test_bit(MMF_OOM_SKIP, &mm->flags) &&
> +			!__oom_reap_task_mm(mm, robust_list))

again

>  		ret = -EAGAIN;
>  	mmap_read_unlock(mm);

