Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A57C4F885C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiDGUdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiDGUdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D96030F9CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9509E61EE5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA2FC385A4;
        Thu,  7 Apr 2022 20:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649362691;
        bh=ri7xT8MCx8mwYgjZZIPM9V0zwZwR3Rdo4TKvPfNTfd0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xBbKyofi0Z7kXY4nRilQftAnBHdLY0oC81M9HNli7qkV8OWhTGjAwIYx7MbeamNgc
         U4hlm0L+KpoOZ+kLyp6QUxBdL1unJTB0tlcYBqjkWc2FX6Y/WE1sr08kewZSq76gy5
         xj4iUIe4oPSivbqKNlQRaT7k3VoH5/OayM8eL/QA=
Date:   Thu, 7 Apr 2022 13:18:09 -0700
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
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v6] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Message-Id: <20220407131809.f2d256541e2c039c434c0d72@linux-foundation.org>
In-Reply-To: <20220407184254.3612387-1-npache@redhat.com>
References: <20220407184254.3612387-1-npache@redhat.com>
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

On Thu,  7 Apr 2022 14:42:54 -0400 Nico Pache <npache@redhat.com> wrote:

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

Should this fix be backported into -stable kernels?

> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -106,7 +106,8 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
>  	return 0;
>  }
>  
> -bool __oom_reap_task_mm(struct mm_struct *mm);
> +bool __oom_reap_task_mm(struct mm_struct *mm, struct robust_list_head
> +		__user *robust_list);

Should explicitly include futex.h

>  long oom_badness(struct task_struct *p,
>  		unsigned long totalpages);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3aa839f81e63..c14fe6f8e9a5 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3126,7 +3126,8 @@ void exit_mmap(struct mm_struct *mm)
>  		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
>  		 * __oom_reap_task_mm() will not block.
>  		 */
> -		(void)__oom_reap_task_mm(mm);
> +		(void)__oom_reap_task_mm(mm, current->robust_list);
> +
>  		set_bit(MMF_OOM_SKIP, &mm->flags);
>  	}
>  
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 7ec38194f8e1..727cfc3bd284 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -509,9 +509,11 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
>  static struct task_struct *oom_reaper_list;
>  static DEFINE_SPINLOCK(oom_reaper_lock);
>  
> -bool __oom_reap_task_mm(struct mm_struct *mm)
> +bool __oom_reap_task_mm(struct mm_struct *mm, struct robust_list_head
> +		__user *robust_list)
>  {

It's pretty sad to make such a low-level function aware of futex
internals.  How about making it a more general `void *skip_area'?

>  	struct vm_area_struct *vma;
> +	unsigned long head = (unsigned long) robust_list;
>  	bool ret = true;
>  
>  	/*
> @@ -526,6 +528,11 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
>  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
>  			continue;
>  
> +		if (vma->vm_start <= head && vma->vm_end > head) {

This check as you have it is making assumptions about the length of the
area at *robust_list and about that area's relation to the area
represented by the vma.

So if this is to be made more generic, we'd also need skip_area_len so
we can perform a full overlap check.

I dunno, maybe not worth it at this time, what do others think.

But the special-casing in here is pretty painful.

> +			pr_info("oom_reaper: skipping vma, contains robust_list");
> +			continue;
> +		}
> +
>  		/*
>  		 * Only anonymous pages have a good chance to be dropped
>  		 * without additional steps which we cannot afford as we
> @@ -587,7 +594,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>  	trace_start_task_reaping(tsk->pid);
>  
>  	/* failed to reap part of the address space. Try again later */
> -	ret = __oom_reap_task_mm(mm);
> +	ret = __oom_reap_task_mm(mm, tsk->robust_list);
>  	if (!ret)
>  		goto out_finish;
>  
> @@ -1190,7 +1197,8 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
>  	 * possible change in exit_mmap is seen
>  	 */
> -	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
> +	if (!test_bit(MMF_OOM_SKIP, &mm->flags) &&
> +			!__oom_reap_task_mm(mm, p->robust_list))
>  		ret = -EAGAIN;
>  	mmap_read_unlock(mm);
>  
> -- 
> 2.35.1
