Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985BA5AC8F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiIEDJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbiIEDJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:09:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1235BB7F8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:09:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MLYMp5CGkznV2F;
        Mon,  5 Sep 2022 11:07:02 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 11:08:59 +0800
Subject: Re: [PATCH 8/8] hugetlb: use new vma_lock for pmd sharing
 synchronization
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
 <20220824175757.20590-9-mike.kravetz@oracle.com>
 <08edc08e-08ab-0706-3c8d-804080f37bd7@huawei.com> <YxKMy3sDsWPEOMMJ@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1baff74d-d38f-6139-2548-19c0c8f87649@huawei.com>
Date:   Mon, 5 Sep 2022 11:08:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YxKMy3sDsWPEOMMJ@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/3 7:07, Mike Kravetz wrote:
> On 08/30/22 10:02, Miaohe Lin wrote:
>> On 2022/8/25 1:57, Mike Kravetz wrote:
>>> The new hugetlb vma lock (rw semaphore) is used to address this race:
>>>
>>> Faulting thread                                 Unsharing thread
>>> ...                                                  ...
>>> ptep = huge_pte_offset()
>>>       or
>>> ptep = huge_pte_alloc()
>>> ...
>>>                                                 i_mmap_lock_write
>>>                                                 lock page table
>>> ptep invalid   <------------------------        huge_pmd_unshare()
>>> Could be in a previously                        unlock_page_table
>>> sharing process or worse                        i_mmap_unlock_write
>>> ...
>>>
>>> The vma_lock is used as follows:
>>> - During fault processing. the lock is acquired in read mode before
>>>   doing a page table lock and allocation (huge_pte_alloc).  The lock is
>>>   held until code is finished with the page table entry (ptep).
>>> - The lock must be held in write mode whenever huge_pmd_unshare is
>>>   called.
>>>
>>> Lock ordering issues come into play when unmapping a page from all
>>> vmas mapping the page.  The i_mmap_rwsem must be held to search for the
>>> vmas, and the vma lock must be held before calling unmap which will
>>> call huge_pmd_unshare.  This is done today in:
>>> - try_to_migrate_one and try_to_unmap_ for page migration and memory
>>>   error handling.  In these routines we 'try' to obtain the vma lock and
>>>   fail to unmap if unsuccessful.  Calling routines already deal with the
>>>   failure of unmapping.
>>> - hugetlb_vmdelete_list for truncation and hole punch.  This routine
>>>   also tries to acquire the vma lock.  If it fails, it skips the
>>>   unmapping.  However, we can not have file truncation or hole punch
>>>   fail because of contention.  After hugetlb_vmdelete_list, truncation
>>>   and hole punch call remove_inode_hugepages.  remove_inode_hugepages
>>>   check for mapped pages and call hugetlb_unmap_file_page to unmap them.
>>>   hugetlb_unmap_file_page is designed to drop locks and reacquire in the
>>>   correct order to guarantee unmap success.
>>>
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>>  fs/hugetlbfs/inode.c |  46 +++++++++++++++++++
>>>  mm/hugetlb.c         | 102 +++++++++++++++++++++++++++++++++++++++----
>>>  mm/memory.c          |   2 +
>>>  mm/rmap.c            | 100 +++++++++++++++++++++++++++---------------
>>>  mm/userfaultfd.c     |   9 +++-
>>>  5 files changed, 214 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>>> index b93d131b0cb5..52d9b390389b 100644
>>> --- a/fs/hugetlbfs/inode.c
>>> +++ b/fs/hugetlbfs/inode.c
>>> @@ -434,6 +434,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>>>  					struct folio *folio, pgoff_t index)
>>>  {
>>>  	struct rb_root_cached *root = &mapping->i_mmap;
>>> +	unsigned long skipped_vm_start;
>>> +	struct mm_struct *skipped_mm;
>>>  	struct page *page = &folio->page;
>>>  	struct vm_area_struct *vma;
>>>  	unsigned long v_start;
>>> @@ -444,6 +446,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>>>  	end = ((index + 1) * pages_per_huge_page(h));
>>>  
>>>  	i_mmap_lock_write(mapping);
>>> +retry:
>>> +	skipped_mm = NULL;
>>>  
>>>  	vma_interval_tree_foreach(vma, root, start, end - 1) {
>>>  		v_start = vma_offset_start(vma, start);
>>> @@ -452,11 +456,49 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>>>  		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
>>>  			continue;
>>>  
>>> +		if (!hugetlb_vma_trylock_write(vma)) {
>>> +			/*
>>> +			 * If we can not get vma lock, we need to drop
>>> +			 * immap_sema and take locks in order.
>>> +			 */
>>> +			skipped_vm_start = vma->vm_start;
>>> +			skipped_mm = vma->vm_mm;
>>> +			/* grab mm-struct as we will be dropping i_mmap_sema */
>>> +			mmgrab(skipped_mm);
>>> +			break;
>>> +		}
>>> +
>>>  		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
>>>  				NULL, ZAP_FLAG_DROP_MARKER);
>>> +		hugetlb_vma_unlock_write(vma);
>>>  	}
>>>  
>>>  	i_mmap_unlock_write(mapping);
>>> +
>>> +	if (skipped_mm) {
>>> +		mmap_read_lock(skipped_mm);
>>> +		vma = find_vma(skipped_mm, skipped_vm_start);
>>> +		if (!vma || !is_vm_hugetlb_page(vma) ||
>>> +					vma->vm_file->f_mapping != mapping ||
>>> +					vma->vm_start != skipped_vm_start) {
>>
>> i_mmap_lock_write(mapping) is missing here? Retry logic will do i_mmap_unlock_write(mapping) anyway.
>>
> 
> Yes, that is missing.  I will add here.
> 
>>> +			mmap_read_unlock(skipped_mm);
>>> +			mmdrop(skipped_mm);
>>> +			goto retry;
>>> +		}
>>> +
>>
>> IMHO, above check is not enough. Think about the below scene:
>>
>> CPU 1					CPU 2
>> hugetlb_unmap_file_folio		exit_mmap
>>   mmap_read_lock(skipped_mm);		  mmap_read_lock(mm);
>>   check vma is wanted.
>>   					  unmap_vmas
>>   mmap_read_unlock(skipped_mm);		  mmap_read_unlock
>>   					  mmap_write_lock(mm);
>>   					  free_pgtables
>>   					  remove_vma
>> 					    hugetlb_vma_lock_free
>>   vma, hugetlb_vma_lock is still *used after free*
>>   					  mmap_write_unlock(mm);
>> So we should check mm->mm_users == 0 to fix the above issue. Or am I miss something?
> 
> In the retry case, we are OK because go back and look up the vma again.  Right?
> 
> After taking mmap_read_lock, vma can not go away until we mmap_read_unlock.
> Before that, we do the following:
> 
>>> +		hugetlb_vma_lock_write(vma);
>>> +		i_mmap_lock_write(mapping);
> 
> IIUC, vma can not go away while we hold i_mmap_lock_write.  So, after this we

I think you're right. free_pgtables() can't complete its work as unlink_file_vma() will be
blocked on i_mmap_rwsem of mapping. Sorry for reporting such nonexistent race.

> can.
> 
>>> +		mmap_read_unlock(skipped_mm);
>>> +		mmdrop(skipped_mm);
> 
> We continue to hold i_mmap_lock_write as we goto retry.
> 
> I could be missing something as well.  This was how I intended to keep
> vma valid while dropping and acquiring locks.

Thanks for your clarifying.

> 
>>> +
>>> +		v_start = vma_offset_start(vma, start);
>>> +		v_end = vma_offset_end(vma, end);
>>> +		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
>>> +				NULL, ZAP_FLAG_DROP_MARKER);
>>> +		hugetlb_vma_unlock_write(vma);
>>> +
>>> +		goto retry;
>>
>> Should here be one cond_resched() here in case this function will take a really long time?
>>
> 
> I think we will at most retry once.

I see. It should be acceptable.

> 
>>> +	}
>>>  }
>>>  
>>>  static void
>>> @@ -474,11 +516,15 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>>>  		unsigned long v_start;
>>>  		unsigned long v_end;
>>>  
>>> +		if (!hugetlb_vma_trylock_write(vma))
>>> +			continue;
>>> +
>>>  		v_start = vma_offset_start(vma, start);
>>>  		v_end = vma_offset_end(vma, end);
>>>  
>>>  		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
>>>  				     NULL, zap_flags);
>>> +		hugetlb_vma_unlock_write(vma);
>>>  	}
>>
>> unmap_hugepage_range is not called under hugetlb_vma_lock in unmap_ref_private since it's private vma?
>> Add a comment to avoid future confusion?
>>
>>>  }
> 
> Sure, will add a comment before hugetlb_vma_lock.
> 
>>>  
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 6fb0bff2c7ee..5912c2b97ddf 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -4801,6 +4801,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>>>  		mmu_notifier_invalidate_range_start(&range);
>>>  		mmap_assert_write_locked(src);
>>>  		raw_write_seqcount_begin(&src->write_protect_seq);
>>> +	} else {
>>> +		/*
>>> +		 * For shared mappings the vma lock must be held before
>>> +		 * calling huge_pte_offset in the src vma. Otherwise, the
>>
>> s/huge_pte_offset/huge_pte_alloc/, i.e. huge_pte_alloc could return shared pmd, not huge_pte_offset which
>> might lead to confusion. But this is really trivial...
> 
> Actually, it is huge_pte_offset.  While looking up ptes in the source vma, we
> do not want to race with other threads in the source process which could
> be doing a huge_pmd_unshare.  Otherwise, the returned pte could be invalid.
> 
> FYI - Most of this code is now 'dead' because of bcd51a3c679d "Lazy page table
> copies in fork()".  We will not copy shared mappigns at fork time.

Agree. Should these "dead" codes be removed later?

Thanks,
Miaohe Lin


> 
>>
>> Except from above comments, this patch looks good to me.
>>
> 
> Thank you! Thank you! Thank you!  For looking at this series and all
> your comments.  I hope to send out v2 next week.
> 

