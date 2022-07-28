Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80855583902
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiG1Gv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiG1Gvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:51:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B61B558FF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:51:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lth913qdDzmVKx;
        Thu, 28 Jul 2022 14:49:57 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 14:51:47 +0800
Subject: Re: [RFC PATCH v4 8/8] hugetlb: use new vma_lock for pmd sharing
 synchronization
To:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
 <20220706202347.95150-9-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ddab06a9-ab81-5ebd-9273-c50744f6da60@huawei.com>
Date:   Thu, 28 Jul 2022 14:51:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220706202347.95150-9-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/7 4:23, Mike Kravetz wrote:
> The new hugetlb vma lock (rw semaphore) is used to address this race:
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
> sharing process or worse                        i_mmap_unlock_write
> ...

Duplicated commit log here

>                                                 i_mmap_lock_write
>                                                 lock page table
> ptep invalid   <------------------------        huge_pmd_unshare()
> Could be in a previously                        unlock_page_table
> sharing process or worse                        i_mmap_unlock_write
> ...

vs here?

> ptl = huge_pte_lock(ptep)
> get/update pte
> set_pte_at(pte, ptep)
> 
> The vma_lock is used as follows:
> - During fault processing. the lock is acquired in read mode before
>   doing a page table lock and allocation (huge_pte_alloc).  The lock is
>   held until code is finished with the page table entry (ptep).
> - The lock must be held in write mode whenever huge_pmd_unshare is
>   called.
> 
> Lock ordering issues come into play when unmapping a page from all
> vmas mapping the page.  The i_mmap_rwsem must be held to search for the
> vmas, and the vma lock must be held before calling unmap which will
> call huge_pmd_unshare.  This is done today in:
> - try_to_migrate_one and try_to_unmap_ for page migration and memory
>   error handling.  In these routines we 'try' to obtain the vma lock and
>   fail to unmap if unsuccessful.  Calling routines already deal with the
>   failure of unmapping.
> - hugetlb_vmdelete_list for truncation and hole punch.  This routine
>   also tries to acquire the vma lock.  If it fails, it skips the
>   unmapping.  However, we can not have file truncation or hole punch
>   fail because of contention.  After hugetlb_vmdelete_list, truncation
>   and hole punch call remove_inode_hugepages.  remove_inode_hugepages
>   check for mapped pages and call hugetlb_unmap_file_page to unmap them.
>   hugetlb_unmap_file_page is designed to drop locks and reacquire in the
>   correct order to guarantee unmap success.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c | 45 ++++++++++++++++++++
>  mm/hugetlb.c         | 76 ++++++++++++++++++++++++++++++----
>  mm/memory.c          |  2 +
>  mm/rmap.c            | 99 ++++++++++++++++++++++++++++----------------
>  mm/userfaultfd.c     |  9 +++-
>  5 files changed, 186 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 0eac0ea2a245..be0a5073766f 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -459,6 +459,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>  					struct folio *folio, pgoff_t index)
>  {
>  	struct rb_root_cached *root = &mapping->i_mmap;
> +	unsigned long skipped_vm_start;
> +	struct mm_struct *skipped_mm;
>  	struct page *page = &folio->page;
>  	struct vm_area_struct *vma;
>  	unsigned long v_start;
> @@ -469,6 +471,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>  	end = ((index + 1) * pages_per_huge_page(h));
>  
>  	i_mmap_lock_write(mapping);
> +retry:
> +	skipped_mm = NULL;
>  
>  	vma_interval_tree_foreach(vma, root, start, end - 1) {
>  		v_start = vma_offset_start(vma, start);
> @@ -477,11 +481,48 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>  		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
>  			continue;
>  
> +		if (!hugetlb_vma_trylock_write(vma)) {
> +			/*
> +			 * If we can not get vma lock, we need to drop
> +			 * immap_sema and take locks in order.
> +			 */
> +			skipped_vm_start = vma->vm_start;
> +			skipped_mm = vma->vm_mm;
> +			/* grab mm-struct as we will be dropping i_mmap_sema */
> +			mmgrab(skipped_mm);
> +			break;
> +		}
> +
>  		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
>  				NULL, ZAP_FLAG_DROP_MARKER);
> +		hugetlb_vma_unlock_write(vma);
>  	}
>  
>  	i_mmap_unlock_write(mapping);
> +
> +	if (skipped_mm) {
> +		mmap_read_lock(skipped_mm);
> +		mmdrop(skipped_mm);

Do we need to check &mm->mm_users == 0 here in case the address_space of corresponding process
has exited? In this case, mmdrop will drop the last reference and free the skipped_mm. So we will
use skipped_mm below after it's freed?

> +		vma = find_vma(skipped_mm, skipped_vm_start);
> +		if (!vma || vma->vm_file->f_mapping != mapping ||

If skipped_vm_start is unmapped and remapped as a anon vma before we taking the mmap_read_lock,
vma->vm_file will be NULL?

> +					vma->vm_start != skipped_vm_start ||
> +					!is_vm_hugetlb_page(vma)) {
> +			mmap_read_unlock(skipped_mm);
> +			goto retry;
> +		}
> +
> +		hugetlb_vma_lock_write(vma);
> +		i_mmap_lock_write(mapping);
> +		mmap_read_unlock(skipped_mm);
> +
> +		v_start = vma_offset_start(vma, start);
> +		v_end = vma_offset_end(vma, end);
> +		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
> +				NULL, ZAP_FLAG_DROP_MARKER);
> +		hugetlb_vma_unlock_write(vma);
> +
> +		goto retry;
> +	}
>  }
>  
>  static void
> @@ -499,11 +540,15 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>  		unsigned long v_start;
>  		unsigned long v_end;
>  
> +		if (!hugetlb_vma_trylock_write(vma))
> +			continue;
> +
>  		v_start = vma_offset_start(vma, start);
>  		v_end = vma_offset_end(vma, end);
>  
>  		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
>  				     NULL, zap_flags);
> +		hugetlb_vma_unlock_write(vma);
>  	}
>  }
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 2eca89bb08ab..8369db31df13 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4848,6 +4848,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  		mmu_notifier_invalidate_range_start(&range);
>  		mmap_assert_write_locked(src);
>  		raw_write_seqcount_begin(&src->write_protect_seq);
> +	} else {
> +		/*
> +		 * For shared mappings the vma lock must be held before
> +		 * calling huge_pte_offset in the src vma. Otherwise, the
> +		 * returned ptep could go away if part of a shared pmd and
> +		 * another thread calls huge_pmd_unshare.
> +		 */
> +		hugetlb_vma_lock_read(src_vma);
>  	}
>  
>  	last_addr_mask = hugetlb_mask_last_page(h);
> @@ -4999,6 +5007,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  	if (cow) {
>  		raw_write_seqcount_end(&src->write_protect_seq);
>  		mmu_notifier_invalidate_range_end(&range);
> +	} else {
> +		hugetlb_vma_unlock_read(src_vma);
>  	}
>  
>  	return ret;
> @@ -5057,6 +5067,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  	mmu_notifier_invalidate_range_start(&range);
>  	last_addr_mask = hugetlb_mask_last_page(h);
>  	/* Prevent race with file truncation */
> +	hugetlb_vma_lock_write(vma);
>  	i_mmap_lock_write(mapping);
>  	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
>  		src_pte = huge_pte_offset(mm, old_addr, sz);
> @@ -5088,6 +5099,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  		flush_tlb_range(vma, old_end - len, old_end);
>  	mmu_notifier_invalidate_range_end(&range);
>  	i_mmap_unlock_write(mapping);
> +	hugetlb_vma_unlock_write(vma);
>  
>  	return len + old_addr - old_end;
>  }
> @@ -5392,9 +5404,30 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>  		 * may get SIGKILLed if it later faults.
>  		 */
>  		if (outside_reserve) {
> +			struct address_space *mapping = vma->vm_file->f_mapping;
> +			pgoff_t idx;
> +			u32 hash;
> +
>  			put_page(old_page);
>  			BUG_ON(huge_pte_none(pte));
> +			/*
> +			 * Drop hugetlb_fault_mutex and vma_lock before
> +			 * unmapping.  unmapping needs to hold vma_lock
> +			 * in write mode.  Dropping vma_lock in read mode
> +			 * here is OK as COW mappings do not interact with
> +			 * PMD sharing.
> +			 *
> +			 * Reacquire both after unmap operation.
> +			 */
> +			idx = vma_hugecache_offset(h, vma, haddr);
> +			hash = hugetlb_fault_mutex_hash(mapping, idx);
> +			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +			hugetlb_vma_unlock_read(vma);
> +
>  			unmap_ref_private(mm, vma, old_page, haddr);
> +
> +			hugetlb_vma_lock_read(vma);
> +			mutex_lock(&hugetlb_fault_mutex_table[hash]);

We should respect the below lock order here?

hugetlb_fault_mutex
 * hugetlbfs PageHuge() take locks in this order:
 *   hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
     ^^^^
 *     vma_lock (hugetlb specific lock for pmd_sharing)
       ^^^^
 *       mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
 *         page->flags PG_locked (lock_page)

>  			spin_lock(ptl);
>  			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
>  			if (likely(ptep &&
> @@ -5563,14 +5596,16 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
>  	};
>  
>  	/*
> -	 * hugetlb_fault_mutex and i_mmap_rwsem must be
> +	 * vma_lock and hugetlb_fault_mutex must be
>  	 * dropped before handling userfault.  Reacquire
>  	 * after handling fault to make calling code simpler.
>  	 */
> +	hugetlb_vma_unlock_read(vma);
>  	hash = hugetlb_fault_mutex_hash(mapping, idx);
>  	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  	ret = handle_userfault(&vmf, reason);
>  	mutex_lock(&hugetlb_fault_mutex_table[hash]);
> +	hugetlb_vma_lock_read(vma);
>  
>  	return ret;
>  }
> @@ -5821,6 +5856,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
>  	if (ptep) {
> +		/*
> +		 * Since we hold no locks, ptep could be stale.  That is
> +		 * OK as we are only making decisions based on content and
> +		 * not actually modifying content here.
> +		 */
>  		entry = huge_ptep_get(ptep);
>  		if (unlikely(is_hugetlb_entry_migration(entry))) {
>  			migration_entry_wait_huge(vma, ptep);
> @@ -5828,23 +5868,35 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
>  			return VM_FAULT_HWPOISON_LARGE |
>  				VM_FAULT_SET_HINDEX(hstate_index(h));
> -	} else {
> -		ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
> -		if (!ptep)
> -			return VM_FAULT_OOM;
>  	}
>  
> -	mapping = vma->vm_file->f_mapping;
> -	idx = vma_hugecache_offset(h, vma, haddr);
> -
>  	/*
>  	 * Serialize hugepage allocation and instantiation, so that we don't
>  	 * get spurious allocation failures if two CPUs race to instantiate
>  	 * the same page in the page cache.
>  	 */
> +	mapping = vma->vm_file->f_mapping;
> +	idx = vma_hugecache_offset(h, vma, haddr);
>  	hash = hugetlb_fault_mutex_hash(mapping, idx);
>  	mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  
> +	/*
> +	 * Acquire vma lock before calling huge_pte_alloc and hold
> +	 * until finished with ptep.  This prevents huge_pmd_unshare from
> +	 * being called elsewhere and making the ptep no longer valid.
> +	 *
> +	 * ptep could have already be assigned via huge_pte_offset.  That
> +	 * is OK, as huge_pte_alloc will return the same value unless
> +	 * something has changed.
> +	 */
> +	hugetlb_vma_lock_read(vma);
> +	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
> +	if (!ptep) {
> +		hugetlb_vma_unlock_read(vma);
> +		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +		return VM_FAULT_OOM;
> +	}
> +
>  	entry = huge_ptep_get(ptep);
>  	/* PTE markers should be handled the same way as none pte */
>  	if (huge_pte_none_mostly(entry)) {
> @@ -5908,6 +5960,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unlock_page(pagecache_page);
>  			put_page(pagecache_page);
>  		}
> +		hugetlb_vma_unlock_read(vma);
>  		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  		return handle_userfault(&vmf, VM_UFFD_WP);
>  	}
> @@ -5951,6 +6004,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  		put_page(pagecache_page);
>  	}
>  out_mutex:
> +	hugetlb_vma_unlock_read(vma);
>  	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  	/*
>  	 * Generally it's safe to hold refcount during waiting page lock. But
> @@ -6413,8 +6467,9 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>  	flush_cache_range(vma, range.start, range.end);
>  
>  	mmu_notifier_invalidate_range_start(&range);
> -	last_addr_mask = hugetlb_mask_last_page(h);
> +	hugetlb_vma_lock_write(vma);
>  	i_mmap_lock_write(vma->vm_file->f_mapping);
> +	last_addr_mask = hugetlb_mask_last_page(h);
>  	for (; address < end; address += psize) {
>  		spinlock_t *ptl;
>  		ptep = huge_pte_offset(mm, address, psize);
> @@ -6513,6 +6568,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>  	 * See Documentation/mm/mmu_notifier.rst
>  	 */
>  	i_mmap_unlock_write(vma->vm_file->f_mapping);
> +	hugetlb_vma_assert_locked(vma);

s/hugetlb_vma_assert_locked/hugetlb_vma_unlock_write/ ?

>  	mmu_notifier_invalidate_range_end(&range);
>  
>  	return pages << h->order;
> @@ -6890,6 +6946,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  	pud_t *pud = pud_offset(p4d, addr);
>  
>  	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
> +	hugetlb_vma_assert_locked(vma);
>  	BUG_ON(page_count(virt_to_page(ptep)) == 0);
>  	if (page_count(virt_to_page(ptep)) == 1)
>  		return 0;
> @@ -7271,6 +7328,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
>  				start, end);
>  	mmu_notifier_invalidate_range_start(&range);
> +	hugetlb_vma_lock_write(vma);

hugetlb_vma_unlock_write is missed in hugetlb_unshare_all_pmds?

>  	i_mmap_lock_write(vma->vm_file->f_mapping);
>  	for (address = start; address < end; address += PUD_SIZE) {
>  		ptep = huge_pte_offset(mm, address, sz);
> diff --git a/mm/memory.c b/mm/memory.c
> index 8917bea2f0bc..3131766f9c7d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1693,10 +1693,12 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>  			if (vma->vm_file) {
>  				zap_flags_t zap_flags = details ?
>  				    details->zap_flags : 0;
> +				hugetlb_vma_lock_write(vma);
>  				i_mmap_lock_write(vma->vm_file->f_mapping);
>  				__unmap_hugepage_range_final(tlb, vma, start, end,
>  							     NULL, zap_flags);
>  				i_mmap_unlock_write(vma->vm_file->f_mapping);
> +				hugetlb_vma_unlock_write(vma);
>  			}
>  		} else
>  			unmap_page_range(tlb, vma, start, end, details);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 64076c2a49c1..e1c19d86cea6 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1557,24 +1557,38 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			 * To call huge_pmd_unshare, i_mmap_rwsem must be
>  			 * held in write mode.  Caller needs to explicitly
>  			 * do this outside rmap routines.
> +			 *
> +			 * We also must hold hugetlb vma_lock in write mode.
> +			 * Lock order dictates acquiring vma_lock BEFORE
> +			 * i_mmap_rwsem.  We can only try lock here and fail
> +			 * if unsuccessful.
>  			 */
> -			VM_BUG_ON(!anon && !(flags & TTU_RMAP_LOCKED));
> -			if (!anon && huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
> -				flush_tlb_range(vma, range.start, range.end);
> -				mmu_notifier_invalidate_range(mm, range.start,
> -							      range.end);
> -
> -				/*
> -				 * The ref count of the PMD page was dropped
> -				 * which is part of the way map counting
> -				 * is done for shared PMDs.  Return 'true'
> -				 * here.  When there is no other sharing,
> -				 * huge_pmd_unshare returns false and we will
> -				 * unmap the actual page and drop map count
> -				 * to zero.
> -				 */
> -				page_vma_mapped_walk_done(&pvmw);
> -				break;
> +			if (!anon) {
> +				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> +				if (!hugetlb_vma_trylock_write(vma)) {
> +					page_vma_mapped_walk_done(&pvmw);
> +					ret = false;

We should break here?

Thanks.
