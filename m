Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6016F5A3416
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 04:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242581AbiH0C7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 22:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiH0C7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 22:59:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311E9B63
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:59:48 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MF1YS2hGVzkWLD;
        Sat, 27 Aug 2022 10:56:12 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 10:59:45 +0800
Subject: Re: [PATCH 2/8] hugetlbfs: revert use i_mmap_rwsem for more pmd
 sharing synchronization
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-3-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a53564f7-31b4-f6c6-0ef7-ff46df00ab37@huawei.com>
Date:   Sat, 27 Aug 2022 10:59:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220824175757.20590-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/25 1:57, Mike Kravetz wrote:
> Commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
> synchronization") added code to take i_mmap_rwsem in read mode for the
> duration of fault processing.  However, this has been shown to cause
> performance/scaling issues.  Revert the code and go back to only taking
> the semaphore in huge_pmd_share during the fault path.
> 
> Keep the code that takes i_mmap_rwsem in write mode before calling
> try_to_unmap as this is required if huge_pmd_unshare is called.
> 
> NOTE: Reverting this code does expose the following race condition.
> 
> Faulting thread                                 Unsharing thread
> ...                                                  ...
> ptep = huge_pte_offset()
>       or
> ptep = huge_pte_alloc()
> ...
>                                                 i_mmap_lock_write
>                                                 lock page table
> ptep invalid   <------------------------        huge_pmd_unshare()
> Could be in a previously                        unlock_page_table
> sharing process or worse			i_mmap_unlock_write
> ...
> ptl = huge_pte_lock(ptep)
> get/update pte
> set_pte_at(pte, ptep)
> 
> It is unknown if the above race was ever experienced by a user.  It was
> discovered via code inspection when initially addressed.
> 
> In subsequent patches, a new synchronization mechanism will be added to
> coordinate pmd sharing and eliminate this race.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin

> ---
>  fs/hugetlbfs/inode.c |  2 --
>  mm/hugetlb.c         | 77 +++++++-------------------------------------
>  mm/rmap.c            |  8 +----
>  mm/userfaultfd.c     | 11 ++-----
>  4 files changed, 15 insertions(+), 83 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index a32031e751d1..dfb735a91bbb 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -467,9 +467,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>  			if (unlikely(folio_mapped(folio))) {
>  				BUG_ON(truncate_op);
>  
> -				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  				i_mmap_lock_write(mapping);
> -				mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  				hugetlb_vmdelete_list(&mapping->i_mmap,
>  					index * pages_per_huge_page(h),
>  					(index + 1) * pages_per_huge_page(h),
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 70bc7f867bc0..95c6f9a5bbf0 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4770,7 +4770,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  	struct hstate *h = hstate_vma(src_vma);
>  	unsigned long sz = huge_page_size(h);
>  	unsigned long npages = pages_per_huge_page(h);
> -	struct address_space *mapping = src_vma->vm_file->f_mapping;
>  	struct mmu_notifier_range range;
>  	unsigned long last_addr_mask;
>  	int ret = 0;
> @@ -4782,14 +4781,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  		mmu_notifier_invalidate_range_start(&range);
>  		mmap_assert_write_locked(src);
>  		raw_write_seqcount_begin(&src->write_protect_seq);
> -	} else {
> -		/*
> -		 * For shared mappings i_mmap_rwsem must be held to call
> -		 * huge_pte_alloc, otherwise the returned ptep could go
> -		 * away if part of a shared pmd and another thread calls
> -		 * huge_pmd_unshare.
> -		 */
> -		i_mmap_lock_read(mapping);
>  	}
>  
>  	last_addr_mask = hugetlb_mask_last_page(h);
> @@ -4937,8 +4928,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  	if (cow) {
>  		raw_write_seqcount_end(&src->write_protect_seq);
>  		mmu_notifier_invalidate_range_end(&range);
> -	} else {
> -		i_mmap_unlock_read(mapping);
>  	}
>  
>  	return ret;
> @@ -5347,30 +5336,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>  		 * may get SIGKILLed if it later faults.
>  		 */
>  		if (outside_reserve) {
> -			struct address_space *mapping = vma->vm_file->f_mapping;
> -			pgoff_t idx;
> -			u32 hash;
> -
>  			put_page(old_page);
>  			BUG_ON(huge_pte_none(pte));
> -			/*
> -			 * Drop hugetlb_fault_mutex and i_mmap_rwsem before
> -			 * unmapping.  unmapping needs to hold i_mmap_rwsem
> -			 * in write mode.  Dropping i_mmap_rwsem in read mode
> -			 * here is OK as COW mappings do not interact with
> -			 * PMD sharing.
> -			 *
> -			 * Reacquire both after unmap operation.
> -			 */
> -			idx = vma_hugecache_offset(h, vma, haddr);
> -			hash = hugetlb_fault_mutex_hash(mapping, idx);
> -			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> -			i_mmap_unlock_read(mapping);
> -
>  			unmap_ref_private(mm, vma, old_page, haddr);
> -
> -			i_mmap_lock_read(mapping);
> -			mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  			spin_lock(ptl);
>  			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
>  			if (likely(ptep &&
> @@ -5538,9 +5506,7 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
>  	 */
>  	hash = hugetlb_fault_mutex_hash(mapping, idx);
>  	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> -	i_mmap_unlock_read(mapping);
>  	ret = handle_userfault(&vmf, reason);
> -	i_mmap_lock_read(mapping);
>  	mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  
>  	return ret;
> @@ -5772,11 +5738,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
>  	if (ptep) {
> -		/*
> -		 * Since we hold no locks, ptep could be stale.  That is
> -		 * OK as we are only making decisions based on content and
> -		 * not actually modifying content here.
> -		 */
>  		entry = huge_ptep_get(ptep);
>  		if (unlikely(is_hugetlb_entry_migration(entry))) {
>  			migration_entry_wait_huge(vma, ptep);
> @@ -5784,31 +5745,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
>  			return VM_FAULT_HWPOISON_LARGE |
>  				VM_FAULT_SET_HINDEX(hstate_index(h));
> +	} else {
> +		ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
> +		if (!ptep)
> +			return VM_FAULT_OOM;
>  	}
>  
> -	/*
> -	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
> -	 * until finished with ptep.  This prevents huge_pmd_unshare from
> -	 * being called elsewhere and making the ptep no longer valid.
> -	 *
> -	 * ptep could have already be assigned via huge_pte_offset.  That
> -	 * is OK, as huge_pte_alloc will return the same value unless
> -	 * something has changed.
> -	 */
>  	mapping = vma->vm_file->f_mapping;
> -	i_mmap_lock_read(mapping);
> -	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
> -	if (!ptep) {
> -		i_mmap_unlock_read(mapping);
> -		return VM_FAULT_OOM;
> -	}
> +	idx = vma_hugecache_offset(h, vma, haddr);
>  
>  	/*
>  	 * Serialize hugepage allocation and instantiation, so that we don't
>  	 * get spurious allocation failures if two CPUs race to instantiate
>  	 * the same page in the page cache.
>  	 */
> -	idx = vma_hugecache_offset(h, vma, haddr);
>  	hash = hugetlb_fault_mutex_hash(mapping, idx);
>  	mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  
> @@ -5873,7 +5823,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  			put_page(pagecache_page);
>  		}
>  		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> -		i_mmap_unlock_read(mapping);
>  		return handle_userfault(&vmf, VM_UFFD_WP);
>  	}
>  
> @@ -5917,7 +5866,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	}
>  out_mutex:
>  	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> -	i_mmap_unlock_read(mapping);
>  	/*
>  	 * Generally it's safe to hold refcount during waiting page lock. But
>  	 * here we just wait to defer the next page fault to avoid busy loop and
> @@ -6758,12 +6706,10 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>   * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
>   * and returns the corresponding pte. While this is not necessary for the
>   * !shared pmd case because we can allocate the pmd later as well, it makes the
> - * code much cleaner.
> - *
> - * This routine must be called with i_mmap_rwsem held in at least read mode if
> - * sharing is possible.  For hugetlbfs, this prevents removal of any page
> - * table entries associated with the address space.  This is important as we
> - * are setting up sharing based on existing page table entries (mappings).
> + * code much cleaner. pmd allocation is essential for the shared case because
> + * pud has to be populated inside the same i_mmap_rwsem section - otherwise
> + * racing tasks could either miss the sharing (see huge_pte_offset) or select a
> + * bad pmd for sharing.
>   */
>  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  		      unsigned long addr, pud_t *pud)
> @@ -6777,7 +6723,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  	pte_t *pte;
>  	spinlock_t *ptl;
>  
> -	i_mmap_assert_locked(mapping);
> +	i_mmap_lock_read(mapping);
>  	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
>  		if (svma == vma)
>  			continue;
> @@ -6807,6 +6753,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  	spin_unlock(ptl);
>  out:
>  	pte = (pte_t *)pmd_alloc(mm, pud, addr);
> +	i_mmap_unlock_read(mapping);
>  	return pte;
>  }
>  
> @@ -6817,7 +6764,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>   * indicated by page_count > 1, unmap is achieved by clearing pud and
>   * decrementing the ref count. If count == 1, the pte page is not shared.
>   *
> - * Called with page table lock held and i_mmap_rwsem held in write mode.
> + * Called with page table lock held.
>   *
>   * returns: 1 successfully unmapped a shared pte page
>   *	    0 the underlying pte page is not shared, or it is the last user
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 7dc6d77ae865..ad9c97c6445c 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -23,10 +23,9 @@
>   * inode->i_rwsem	(while writing or truncating, not reading or faulting)
>   *   mm->mmap_lock
>   *     mapping->invalidate_lock (in filemap_fault)
> - *       page->flags PG_locked (lock_page)   * (see hugetlbfs below)
> + *       page->flags PG_locked (lock_page)
>   *         hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
>   *           mapping->i_mmap_rwsem
> - *             hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
>   *             anon_vma->rwsem
>   *               mm->page_table_lock or pte_lock
>   *                 swap_lock (in swap_duplicate, swap_info_get)
> @@ -45,11 +44,6 @@
>   * anon_vma->rwsem,mapping->i_mmap_rwsem   (memory_failure, collect_procs_anon)
>   *   ->tasklist_lock
>   *     pte map lock
> - *
> - * * hugetlbfs PageHuge() pages take locks in this order:
> - *         mapping->i_mmap_rwsem
> - *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
> - *             page->flags PG_locked (lock_page)
>   */
>  
>  #include <linux/mm.h>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 7327b2573f7c..7707f2664adb 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -377,14 +377,10 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  		BUG_ON(dst_addr >= dst_start + len);
>  
>  		/*
> -		 * Serialize via i_mmap_rwsem and hugetlb_fault_mutex.
> -		 * i_mmap_rwsem ensures the dst_pte remains valid even
> -		 * in the case of shared pmds.  fault mutex prevents
> -		 * races with other faulting threads.
> +		 * Serialize via hugetlb_fault_mutex.
>  		 */
> -		mapping = dst_vma->vm_file->f_mapping;
> -		i_mmap_lock_read(mapping);
>  		idx = linear_page_index(dst_vma, dst_addr);
> +		mapping = dst_vma->vm_file->f_mapping;
>  		hash = hugetlb_fault_mutex_hash(mapping, idx);
>  		mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  
> @@ -392,7 +388,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
>  		if (!dst_pte) {
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> -			i_mmap_unlock_read(mapping);
>  			goto out_unlock;
>  		}
>  
> @@ -400,7 +395,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
>  			err = -EEXIST;
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> -			i_mmap_unlock_read(mapping);
>  			goto out_unlock;
>  		}
>  
> @@ -409,7 +403,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  					       wp_copy);
>  
>  		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> -		i_mmap_unlock_read(mapping);
>  
>  		cond_resched();
>  
> 

