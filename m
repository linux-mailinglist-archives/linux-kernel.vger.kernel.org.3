Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB285A33F2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 04:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbiH0Cux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 22:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiH0Cuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 22:50:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC98EA158
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:50:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MF1NT0hv8znTnZ;
        Sat, 27 Aug 2022 10:48:25 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 10:50:46 +0800
Subject: Re: [PATCH 1/8] hugetlbfs: revert use i_mmap_rwsem to address page
 fault/truncate race
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
 <20220824175757.20590-2-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <db35e31e-4c96-d90c-fe77-3c8dc12458cf@huawei.com>
Date:   Sat, 27 Aug 2022 10:50:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220824175757.20590-2-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
> duration of fault processing.  The use of i_mmap_rwsem to prevent
> fault/truncate races depends on this.  However, this has been shown to
> cause performance/scaling issues.  As a result, that code will be
> reverted.  Since the use i_mmap_rwsem to address page fault/truncate races
> depends on this, it must also be reverted.
> 
> In a subsequent patch, code will be added to detect the fault/truncate
> race and back out operations as required.

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin

> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c | 30 +++++++++---------------------
>  mm/hugetlb.c         | 23 ++++++++++++-----------
>  2 files changed, 21 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index f7a5b5124d8a..a32031e751d1 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -419,9 +419,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>   *	In this case, we first scan the range and release found pages.
>   *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserve
>   *	maps and global counts.  Page faults can not race with truncation
> - *	in this routine.  hugetlb_no_page() holds i_mmap_rwsem and prevents
> - *	page faults in the truncated range by checking i_size.  i_size is
> - *	modified while holding i_mmap_rwsem.
> + *	in this routine.  hugetlb_no_page() prevents page faults in the
> + *	truncated range.  It checks i_size before allocation, and again after
> + *	with the page table lock for the page held.  The same lock must be
> + *	acquired to unmap a page.
>   * hole punch is indicated if end is not LLONG_MAX
>   *	In the hole punch case we scan the range and release found pages.
>   *	Only when releasing a page is the associated region/reserve map
> @@ -451,16 +452,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>  			u32 hash = 0;
>  
>  			index = folio->index;
> -			if (!truncate_op) {
> -				/*
> -				 * Only need to hold the fault mutex in the
> -				 * hole punch case.  This prevents races with
> -				 * page faults.  Races are not possible in the
> -				 * case of truncation.
> -				 */
> -				hash = hugetlb_fault_mutex_hash(mapping, index);
> -				mutex_lock(&hugetlb_fault_mutex_table[hash]);
> -			}
> +			hash = hugetlb_fault_mutex_hash(mapping, index);
> +			mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  
>  			/*
>  			 * If folio is mapped, it was faulted in after being
> @@ -504,8 +497,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>  			}
>  
>  			folio_unlock(folio);
> -			if (!truncate_op)
> -				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  		}
>  		folio_batch_release(&fbatch);
>  		cond_resched();
> @@ -543,8 +535,8 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
>  	BUG_ON(offset & ~huge_page_mask(h));
>  	pgoff = offset >> PAGE_SHIFT;
>  
> -	i_mmap_lock_write(mapping);
>  	i_size_write(inode, offset);
> +	i_mmap_lock_write(mapping);
>  	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
>  		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
>  				      ZAP_FLAG_DROP_MARKER);
> @@ -703,11 +695,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  		/* addr is the offset within the file (zero based) */
>  		addr = index * hpage_size;
>  
> -		/*
> -		 * fault mutex taken here, protects against fault path
> -		 * and hole punch.  inode_lock previously taken protects
> -		 * against truncation.
> -		 */
> +		/* mutex taken here, fault path and hole punch */
>  		hash = hugetlb_fault_mutex_hash(mapping, index);
>  		mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9a72499486c1..70bc7f867bc0 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5575,18 +5575,17 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  	}
>  
>  	/*
> -	 * We can not race with truncation due to holding i_mmap_rwsem.
> -	 * i_size is modified when holding i_mmap_rwsem, so check here
> -	 * once for faults beyond end of file.
> +	 * Use page lock to guard against racing truncation
> +	 * before we get page_table_lock.
>  	 */
> -	size = i_size_read(mapping->host) >> huge_page_shift(h);
> -	if (idx >= size)
> -		goto out;
> -
>  retry:
>  	new_page = false;
>  	page = find_lock_page(mapping, idx);
>  	if (!page) {
> +		size = i_size_read(mapping->host) >> huge_page_shift(h);
> +		if (idx >= size)
> +			goto out;
> +
>  		/* Check for page in userfault range */
>  		if (userfaultfd_missing(vma)) {
>  			ret = hugetlb_handle_userfault(vma, mapping, idx,
> @@ -5677,6 +5676,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  	}
>  
>  	ptl = huge_pte_lock(h, mm, ptep);
> +	size = i_size_read(mapping->host) >> huge_page_shift(h);
> +	if (idx >= size)
> +		goto backout;
> +
>  	ret = 0;
>  	/* If pte changed from under us, retry */
>  	if (!pte_same(huge_ptep_get(ptep), old_pte))
> @@ -5785,10 +5788,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  	/*
>  	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
> -	 * until finished with ptep.  This serves two purposes:
> -	 * 1) It prevents huge_pmd_unshare from being called elsewhere
> -	 *    and making the ptep no longer valid.
> -	 * 2) It synchronizes us with i_size modifications during truncation.
> +	 * until finished with ptep.  This prevents huge_pmd_unshare from
> +	 * being called elsewhere and making the ptep no longer valid.
>  	 *
>  	 * ptep could have already be assigned via huge_pte_offset.  That
>  	 * is OK, as huge_pte_alloc will return the same value unless
> 

