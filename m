Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9879346E4A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhLII7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:59:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53798 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbhLII7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:59:03 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D96FA210FE;
        Thu,  9 Dec 2021 08:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639040129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bNRBNxibij0BqhT+a2ad9uxqy3v5UnEfD1KuJlm212A=;
        b=LwV8vONzCWy6fixsm6yJhD63ZKwQ4SCRUpTFoZyyY/w2hwfpAlkRltwgUxtdO+6G+RwBs5
        Ev8MGMneFW4f1dwuOMGVuCDnIjT++y3Ymt+zKFP6v+qla03TO0MRxKgtereIn1FN2JKKHP
        9XhOQ9YUTxlZIlvRO94IdnPyA/cEN/w=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 628A0A3B81;
        Thu,  9 Dec 2021 08:55:29 +0000 (UTC)
Date:   Thu, 9 Dec 2021 09:55:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 1/3] mm: protect free_pgtables with mmap_lock write
 lock in exit_mmap
Message-ID: <YbHEgLi1g1XtsOgh@dhcp22.suse.cz>
References: <20211208212211.2860249-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208212211.2860249-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-12-21 13:22:09, Suren Baghdasaryan wrote:
> oom-reaper and process_mrelease system call should protect against
> races with exit_mmap which can destroy page tables while they
> walk the VMA tree. oom-reaper protects from that race by setting
> MMF_OOM_VICTIM and by relying on exit_mmap to set MMF_OOM_SKIP
> before taking and releasing mmap_write_lock. process_mrelease has
> to elevate mm->mm_users to prevent such race. Both oom-reaper and
> process_mrelease hold mmap_read_lock when walking the VMA tree.
> The locking rules and mechanisms could be simpler if exit_mmap takes
> mmap_write_lock while executing destructive operations such as
> free_pgtables.
> Change exit_mmap to hold the mmap_write_lock when calling
> free_pgtables and remove_vma. Operations like unmap_vmas and
> unlock_range are not destructive and could run under mmap_read_lock
> but for simplicity we take one mmap_write_lock during almost the entire
> operation.

unlock_range is not safe to be called under read lock. See 27ae357fa82b
("mm, oom: fix concurrent munlock and oom reaper unmap, v3").

> Note also that because oom-reaper checks VM_LOCKED flag,
> unlock_range() should not be allowed to race with it.
> Before this patch, remove_vma used to be called with no locks held,
> however with fput being executed asynchronously and vm_ops->close
> not being allowed to hold mmap_lock (it is called from __split_vma
> with mmap_sem held for write), changing that should be fine.
> In most cases this lock should be uncontended. Previously, Kirill
> reported ~4% regression caused by a similar change [1]. We reran the
> same test and although the individual results are quite noisy, the
> percentiles show lower regression with 1.6% being the worst case [2].
> The change allows oom-reaper and process_mrelease to execute safely
> under mmap_read_lock without worries that exit_mmap might destroy page
> tables from under them.
> 
> [1] https://lore.kernel.org/all/20170725141723.ivukwhddk2voyhuc@node.shutemov.name/
> [2] https://lore.kernel.org/all/CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com/
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

The patch looks good otherwise. Btw. when I was trying to do something
similar in the past Hugh has noted that we can get rid of the same 
lock&&unlock trick in ksm. Maybe you want to have a look at that as well
;)

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> changes in v4
> - Separated comments describing vm_operations_struct::close locking
> requirements into a separate patch, per Matthew Wilcox
> 
>  mm/mmap.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index bfb0ea164a90..f4e09d390a07 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3142,25 +3142,27 @@ void exit_mmap(struct mm_struct *mm)
>  		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
>  		 * __oom_reap_task_mm() will not block.
>  		 *
> -		 * This needs to be done before calling munlock_vma_pages_all(),
> +		 * This needs to be done before calling unlock_range(),
>  		 * which clears VM_LOCKED, otherwise the oom reaper cannot
>  		 * reliably test it.
>  		 */
>  		(void)__oom_reap_task_mm(mm);
>  
>  		set_bit(MMF_OOM_SKIP, &mm->flags);
> -		mmap_write_lock(mm);
> -		mmap_write_unlock(mm);
>  	}
>  
> +	mmap_write_lock(mm);
>  	if (mm->locked_vm)
>  		unlock_range(mm->mmap, ULONG_MAX);
>  
>  	arch_exit_mmap(mm);
>  
>  	vma = mm->mmap;
> -	if (!vma)	/* Can happen if dup_mmap() received an OOM */
> +	if (!vma) {
> +		/* Can happen if dup_mmap() received an OOM */
> +		mmap_write_unlock(mm);
>  		return;
> +	}
>  
>  	lru_add_drain();
>  	flush_cache_mm(mm);
> @@ -3171,16 +3173,14 @@ void exit_mmap(struct mm_struct *mm)
>  	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
>  	tlb_finish_mmu(&tlb);
>  
> -	/*
> -	 * Walk the list again, actually closing and freeing it,
> -	 * with preemption enabled, without holding any MM locks.
> -	 */
> +	/* Walk the list again, actually closing and freeing it. */
>  	while (vma) {
>  		if (vma->vm_flags & VM_ACCOUNT)
>  			nr_accounted += vma_pages(vma);
>  		vma = remove_vma(vma);
>  		cond_resched();
>  	}
> +	mmap_write_unlock(mm);
>  	vm_unacct_memory(nr_accounted);
>  }
>  
> -- 
> 2.34.1.400.ga245620fadb-goog

-- 
Michal Hocko
SUSE Labs
