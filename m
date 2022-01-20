Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950E9495375
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiATRlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:41:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49328 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiATRlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:41:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0463921923;
        Thu, 20 Jan 2022 17:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642700490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7OIZ39Y2cwW5dn4G3sndiX17P1OawheIBBoy4ckQtE=;
        b=u+OkvcfcFlwcUvEjOwqoI8xVjY5BVE22U16Pw0iVpWTmTyWq0s7keTox+GMdq+JbzeO/RG
        W1qvVjsIULxMCglqrpylPxGMQMevwzFS4L1Ln3bKBFK7spOUSxCc9fWwHHDQB6zh7846Ce
        Ypty0+9xcTTFENDz0VmzrNYjCXnlSU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642700490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7OIZ39Y2cwW5dn4G3sndiX17P1OawheIBBoy4ckQtE=;
        b=Iz6U8z4GA6m2KuFpNGImCuKNCizM8ofOTtRc8XVeD3pJsPyEtlb9CMSTxJLKt3ZWIvkZxe
        97wYdD5r1/e8E1AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1A2C13E8A;
        Thu, 20 Jan 2022 17:41:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wwGgKsme6WGfegAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 20 Jan 2022 17:41:29 +0000
Message-ID: <5a83c2ad-82d7-9c56-89cf-5a2184386adc@suse.cz>
Date:   Thu, 20 Jan 2022 18:41:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-66-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 65/66] mm: Remove the vma linked list
In-Reply-To: <20211201142918.921493-66-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:30, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Replace any vm_next use with vma_find().
> 
> Update free_pgtables(), unmap_vmas(), and zap_page_range() to use the
> maple tree.

> Use the new free_pgtables() and unmap_vmas() in do_mas_align_munmap().
> At the same time, alter the loop to be more compact.
> 
> Now that free_pgtables() and unmap_vmas() take a maple tree as an
> argument, rearrange do_mas_align_munmap() to use the new table to hold
> the lock

table or tree?

> Remove __vma_link_list() and __vma_unlink_list() as they are exclusively
> used to update the linked list
> 
> Rework validation of tree as it was depending on the linked list.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

git grep shows that some usages of 'vm_next' and 'vm_prev' remain after this
patch, including some exotic arch code.

> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -398,12 +398,21 @@ void free_pgd_range(struct mmu_gather *tlb,
>  	} while (pgd++, addr = next, addr != end);
>  }
>  
> -void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
> -		unsigned long floor, unsigned long ceiling)
> +void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
> +		   struct vm_area_struct *vma, unsigned long floor,
> +		   unsigned long ceiling)
>  {
> -	while (vma) {
> -		struct vm_area_struct *next = vma->vm_next;
> +	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
> +
> +	do {
>  		unsigned long addr = vma->vm_start;
> +		struct vm_area_struct *next;
> +
> +		/*
> +		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
> +		 * be 0.  This will underflow and is okay.
> +		 */
> +		next = mas_find(&mas, ceiling - 1);
>  
>  		/*
>  		 * Hide vma from rmap and truncate_pagecache before freeing
> @@ -422,7 +431,7 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
>  			       && !is_vm_hugetlb_page(next)) {
>  				vma = next;
> -				next = vma->vm_next;
> +				next = mas_find(&mas, ceiling - 1);
>  				unlink_anon_vmas(vma);
>  				unlink_file_vma(vma);
>  			}
> @@ -430,7 +439,7 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  				floor, next ? next->vm_start : ceiling);
>  		}
>  		vma = next;
> -	}
> +	} while (vma);
>  }
>  
>  void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
> @@ -1602,17 +1611,19 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>   * ensure that any thus-far unmapped pages are flushed before unmap_vmas()
>   * drops the lock and schedules.
>   */
> -void unmap_vmas(struct mmu_gather *tlb,
> +void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
>  		struct vm_area_struct *vma, unsigned long start_addr,
>  		unsigned long end_addr)
>  {
>  	struct mmu_notifier_range range;
> +	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
>  
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
>  				start_addr, end_addr);
>  	mmu_notifier_invalidate_range_start(&range);
> -	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
> +	do {
>  		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
> +	} while ((vma = mas_find(&mas, end_addr - 1)) != NULL);
>  	mmu_notifier_invalidate_range_end(&range);
>  }
>  
> @@ -1627,8 +1638,11 @@ void unmap_vmas(struct mmu_gather *tlb,
>  void zap_page_range(struct vm_area_struct *vma, unsigned long start,
>  		unsigned long size)
>  {
> +	struct maple_tree *mt = &vma->vm_mm->mm_mt;

Well looks like that's also an option to avoid a new parameter :)

> +	unsigned long end = start + size;
>  	struct mmu_notifier_range range;
>  	struct mmu_gather tlb;
> +	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
>  
>  	lru_add_drain();
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
> @@ -1636,8 +1650,9 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
>  	tlb_gather_mmu(&tlb, vma->vm_mm);
>  	update_hiwater_rss(vma->vm_mm);
>  	mmu_notifier_invalidate_range_start(&range);
> -	for ( ; vma && vma->vm_start < range.end; vma = vma->vm_next)
> +	do {
>  		unmap_single_vma(&tlb, vma, start, range.end, NULL);
> +	} while ((vma = mas_find(&mas, end - 1)) != NULL);
>  	mmu_notifier_invalidate_range_end(&range);
>  	tlb_finish_mmu(&tlb);
>  }
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dde74e0b195d..e13c6ef76697 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -74,9 +74,10 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
>  static bool ignore_rlimit_data;
>  core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
>  
> -static void unmap_region(struct mm_struct *mm,
> +static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
>  		struct vm_area_struct *vma, struct vm_area_struct *prev,
> -		unsigned long start, unsigned long end);
> +		struct vm_area_struct *next, unsigned long start,
> +		unsigned long end);
>  
>  /* description of effects of mapping type and prot in current implementation.
>   * this is due to the limited x86 page protection hardware.  The expected
> @@ -173,10 +174,8 @@ void unlink_file_vma(struct vm_area_struct *vma)
>  /*
>   * Close a vm structure and free it, returning the next.

No longer returning the next.

>   */
> -static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
> +static void remove_vma(struct vm_area_struct *vma)
>  {
> -	struct vm_area_struct *next = vma->vm_next;
> -
>  	might_sleep();
>  	if (vma->vm_ops && vma->vm_ops->close)
>  		vma->vm_ops->close(vma);

<snip>

>   */
>  struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
>  {
> +	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_end, vma->vm_end);
>  	struct anon_vma *anon_vma = NULL;
> +	struct vm_area_struct *prev, *next;
>  
>  	/* Try next first. */
> -	if (vma->vm_next) {
> -		anon_vma = reusable_anon_vma(vma->vm_next, vma, vma->vm_next);
> +	next = mas_walk(&mas);
> +	if (next) {
> +		anon_vma = reusable_anon_vma(next, vma, next);
>  		if (anon_vma)
>  			return anon_vma;
>  	}
>  
> +	prev = mas_prev(&mas, 0);
> +	VM_BUG_ON_VMA(prev != vma, vma);
> +	prev = mas_prev(&mas, 0);
>  	/* Try prev next. */
> -	if (vma->vm_prev)
> -		anon_vma = reusable_anon_vma(vma->vm_prev, vma->vm_prev, vma);
> +	if (prev)
> +		anon_vma = reusable_anon_vma(prev, prev, vma);
>  
>  	/*
>  	 * We might reach here with anon_vma == NULL if we can't find
> @@ -1906,10 +1825,10 @@ struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
>  					     unsigned long start_addr,
>  					     unsigned long end_addr)
>  {
> -	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
> +	unsigned long index = start_addr;
>  
>  	mmap_assert_locked(mm);
> -	return mas_find(&mas, end_addr - 1);
> +	return mt_find(&mm->mm_mt, &index, end_addr - 1);

Why is this now changed again?

>  }
>  EXPORT_SYMBOL(find_vma_intersection);
>  
> @@ -1923,8 +1842,10 @@ EXPORT_SYMBOL(find_vma_intersection);
>   */
>  inline struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  {
> -	// Note find_vma_intersection will decrease 0 to underflow to ULONG_MAX
> -	return find_vma_intersection(mm, addr, 0);
> +	unsigned long index = addr;
> +
> +	mmap_assert_locked(mm);
> +	return mt_find(&mm->mm_mt, &index, ULONG_MAX);

And here.

>  }
>  EXPORT_SYMBOL(find_vma);
>  
> @@ -2026,7 +1947,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  	if (gap_addr < address || gap_addr > TASK_SIZE)
>  		gap_addr = TASK_SIZE;
>  
> -	next = vma->vm_next;
> +	next = vma_find(mm, vma->vm_end);
>  	if (next && next->vm_start < gap_addr && vma_is_accessible(next)) {
>  		if (!(next->vm_flags & VM_GROWSUP))
>  			return -ENOMEM;
> @@ -2072,8 +1993,6 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  				vma->vm_end = address;
>  				vma_store(mm, vma);
>  				anon_vma_interval_tree_post_update_vma(vma);
> -				if (!vma->vm_next)
> -					mm->highest_vm_end = vm_end_gap(vma);
>  				spin_unlock(&mm->page_table_lock);
>  
>  				perf_event_mmap(vma);
> @@ -2100,7 +2019,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>  		return -EPERM;
>  
>  	/* Enforce stack_guard_gap */
> -	prev = vma->vm_prev;
> +	find_vma_prev(mm, vma->vm_start, &prev);
>  	/* Check that both stack segments have the same anon_vma? */
>  	if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
>  			vma_is_accessible(prev)) {
> @@ -2235,20 +2154,22 @@ EXPORT_SYMBOL_GPL(find_extend_vma);
>   *
>   * Called with the mm semaphore held.

Above this, the comment talks about vma list, update?

>   */
> -static void remove_vma_list(struct mm_struct *mm, struct vm_area_struct *vma)
> +static inline void remove_mt(struct mm_struct *mm, struct maple_tree *detached)
>  {
>  	unsigned long nr_accounted = 0;
> +	unsigned long index = 0;
> +	struct vm_area_struct *vma;
>  
>  	/* Update high watermark before we lower total_vm */
>  	update_hiwater_vm(mm);
> -	do {
> +	mt_for_each(detached, vma, index, ULONG_MAX) {
>  		long nrpages = vma_pages(vma);
>  
>  		if (vma->vm_flags & VM_ACCOUNT)
>  			nr_accounted += nrpages;
>  		vm_stat_account(mm, vma->vm_flags, -nrpages);
> -		vma = remove_vma(vma);
> -	} while (vma);
> +		remove_vma(vma);
> +	}
>  	vm_unacct_memory(nr_accounted);
>  	validate_mm(mm);
>  }
