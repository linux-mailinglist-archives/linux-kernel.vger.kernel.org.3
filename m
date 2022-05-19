Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B2D52DDD0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244264AbiEST3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbiEST3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:29:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22CE9AE76
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D4CCB827DC
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7AAC385AA;
        Thu, 19 May 2022 19:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652988546;
        bh=Wy0k1G9DGc+wxkyhVsSyhj459xUlDUnaL7YJvODMrBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c/pA7sIXyFDJEUJMlNDcv/stjXiE7At+srEf9vZKnB6MJXfFspfIUlBGsxOJf9F6m
         U4K1BzdJe9T1+DZL9QwpZGkb4ZUp1XTCNiaQJsfNun69x9nvcEbkXCOOMUGbO3HIa9
         RfrFSamcLikUF0Q+m4IpbOtVY/uBGdObd+/kvYSk=
Date:   Thu, 19 May 2022 12:29:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, peterx@redhat.com,
        jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH v2 1/2] mm: drop oom code from exit_mmap
Message-Id: <20220519122904.5aef389360ee2cba42d7b4ca@linux-foundation.org>
In-Reply-To: <20220516075619.1277152-1-surenb@google.com>
References: <20220516075619.1277152-1-surenb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 00:56:18 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> The primary reason to invoke the oom reaper from the exit_mmap path used
> to be a prevention of an excessive oom killing if the oom victim exit
> races with the oom reaper (see [1] for more details). The invocation has
> moved around since then because of the interaction with the munlock
> logic but the underlying reason has remained the same (see [2]).
> 
> Munlock code is no longer a problem since [3] and there shouldn't be
> any blocking operation before the memory is unmapped by exit_mmap so
> the oom reaper invocation can be dropped. The unmapping part can be done
> with the non-exclusive mmap_sem and the exclusive one is only required
> when page tables are freed.
> 
> Remove the oom_reaper from exit_mmap which will make the code easier to
> read. This is really unlikely to make any observable difference although
> some microbenchmarks could benefit from one less branch that needs to be
> evaluated even though it almost never is true.
> 

Liam, this mucks "mm: start tracking VMAs with maple tree" somewhat.

> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -106,8 +106,6 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
>  	return 0;
>  }
>  
> -bool __oom_reap_task_mm(struct mm_struct *mm);
> -
>  long oom_badness(struct task_struct *p,
>  		unsigned long totalpages);
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 313b57d55a63..ded42150e706 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3105,30 +3105,13 @@ void exit_mmap(struct mm_struct *mm)
>  	/* mm's last user has gone, and its about to be pulled down */
>  	mmu_notifier_release(mm);
>  
> -	if (unlikely(mm_is_oom_victim(mm))) {
> -		/*
> -		 * Manually reap the mm to free as much memory as possible.
> -		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
> -		 * this mm from further consideration.  Taking mm->mmap_lock for
> -		 * write after setting MMF_OOM_SKIP will guarantee that the oom
> -		 * reaper will not run on this mm again after mmap_lock is
> -		 * dropped.
> -		 *
> -		 * Nothing can be holding mm->mmap_lock here and the above call
> -		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
> -		 * __oom_reap_task_mm() will not block.
> -		 */
> -		(void)__oom_reap_task_mm(mm);
> -		set_bit(MMF_OOM_SKIP, &mm->flags);
> -	}
> -
> -	mmap_write_lock(mm);
> +	mmap_read_lock(mm);
>  	arch_exit_mmap(mm);
>  
>  	vma = mm->mmap;
>  	if (!vma) {
>  		/* Can happen if dup_mmap() received an OOM */
> -		mmap_write_unlock(mm);
> +		mmap_read_unlock(mm);
>  		return;
>  	}
>  
> @@ -3138,6 +3121,16 @@ void exit_mmap(struct mm_struct *mm)
>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
>  	/* Use -1 here to ensure all VMAs in the mm are unmapped */
>  	unmap_vmas(&tlb, vma, 0, -1);
> +	mmap_read_unlock(mm);
> +
> +	/*
> +	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> +	 * because the memory has been already freed. Do not bother checking
> +	 * mm_is_oom_victim because setting a bit unconditionally is cheaper.
> +	 */
> +	set_bit(MMF_OOM_SKIP, &mm->flags);
> +
> +	mmap_write_lock(mm);
>  	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
>  	tlb_finish_mmu(&tlb);
>  

I ended up with the below rework of "mm: start tracking VMAs with maple
tree".  Please triple check?

void exit_mmap(struct mm_struct *mm)
{
	struct mmu_gather tlb;
	struct vm_area_struct *vma;
	unsigned long nr_accounted = 0;

	/* mm's last user has gone, and its about to be pulled down */
	mmu_notifier_release(mm);

	mmap_write_lock(mm);
	arch_exit_mmap(mm);
	vma = mm->mmap;
	if (!vma) {
		/* Can happen if dup_mmap() received an OOM */
		mmap_write_unlock(mm);
		return;
	}

	lru_add_drain();
	flush_cache_mm(mm);
	tlb_gather_mmu_fullmm(&tlb, mm);
	/* update_hiwater_rss(mm) here? but nobody should be looking */
	/* Use -1 here to ensure all VMAs in the mm are unmapped */
	unmap_vmas(&tlb, vma, 0, -1);

	/*
	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
	 * because the memory has been already freed. Do not bother checking
	 * mm_is_oom_victim because setting a bit unconditionally is cheaper.
	 */
	set_bit(MMF_OOM_SKIP, &mm->flags);

	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
	tlb_finish_mmu(&tlb);

	/* Walk the list again, actually closing and freeing it. */
	while (vma) {
		if (vma->vm_flags & VM_ACCOUNT)
			nr_accounted += vma_pages(vma);
		vma = remove_vma(vma);
		cond_resched();
	}

	trace_exit_mmap(mm);
	__mt_destroy(&mm->mm_mt);
	mmap_write_unlock(mm);
	vm_unacct_memory(nr_accounted);
}


And "mm: remove the vma linked list" needed further reworking.  I ended
up with

void exit_mmap(struct mm_struct *mm)
{
	struct mmu_gather tlb;
	struct vm_area_struct *vma;
	unsigned long nr_accounted = 0;
	MA_STATE(mas, &mm->mm_mt, 0, 0);
	int count = 0;

	/* mm's last user has gone, and its about to be pulled down */
	mmu_notifier_release(mm);

	mmap_write_lock(mm);
	arch_exit_mmap(mm);
	vma = mas_find(&mas, ULONG_MAX);
	if (!vma) {
		/* Can happen if dup_mmap() received an OOM */
		mmap_write_unlock(mm);
		return;
	}

	lru_add_drain();
	flush_cache_mm(mm);
	tlb_gather_mmu_fullmm(&tlb, mm);
	/* update_hiwater_rss(mm) here? but nobody should be looking */
	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
	unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);

	/*
	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
	 * because the memory has been already freed. Do not bother checking
	 * mm_is_oom_victim because setting a bit unconditionally is cheaper.
	 */
	set_bit(MMF_OOM_SKIP, &mm->flags);

	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
	tlb_finish_mmu(&tlb);

	/*
	 * Walk the list again, actually closing and freeing it, with preemption
	 * enabled, without holding any MM locks besides the unreachable
	 * mmap_write_lock.
	 */
	do {
		if (vma->vm_flags & VM_ACCOUNT)
			nr_accounted += vma_pages(vma);
		remove_vma(vma);
		count++;
		cond_resched();
	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);

	BUG_ON(count != mm->map_count);

	trace_exit_mmap(mm);
	__mt_destroy(&mm->mm_mt);
	mmap_write_unlock(mm);
	vm_unacct_memory(nr_accounted);
}


The mapletree patches remain hidden from mm.git until, I expect, next week.

Thanks.


