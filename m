Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5872C5A35C3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiH0ICw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 04:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243326AbiH0ICp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:02:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C0E647D7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 01:02:44 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MF8H01rR6zkWch;
        Sat, 27 Aug 2022 15:59:08 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 16:02:41 +0800
Subject: Re: [PATCH 4/8] hugetlb: handle truncate racing with page faults
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
 <20220824175757.20590-5-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b26db6af-ffde-788d-2148-2e0992f96229@huawei.com>
Date:   Sat, 27 Aug 2022 16:02:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220824175757.20590-5-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
> When page fault code needs to allocate and instantiate a new hugetlb
> page (huegtlb_no_page), it checks early to determine if the fault is
> beyond i_size.  When discovered early, it is easy to abort the fault and
> return an error.  However, it becomes much more difficult to handle when
> discovered later after allocating the page and consuming reservations
> and adding to the page cache.  Backing out changes in such instances
> becomes difficult and error prone.
> 
> Instead of trying to catch and backout all such races, use the hugetlb
> fault mutex to handle truncate racing with page faults.  The most
> significant change is modification of the routine remove_inode_hugepages
> such that it will take the fault mutex for EVERY index in the truncated
> range (or hole in the case of hole punch).  Since remove_inode_hugepages
> is called in the truncate path after updating i_size, we can experience
> races as follows.
> - truncate code updates i_size and takes fault mutex before a racing
>   fault.  After fault code takes mutex, it will notice fault beyond
>   i_size and abort early.
> - fault code obtains mutex, and truncate updates i_size after early
>   checks in fault code.  fault code will add page beyond i_size.
>   When truncate code takes mutex for page/index, it will remove the
>   page.
> - truncate updates i_size, but fault code obtains mutex first.  If
>   fault code sees updated i_size it will abort early.  If fault code
>   does not see updated i_size, it will add page beyond i_size and
>   truncate code will remove page when it obtains fault mutex.
> 
> Note, for performance reasons remove_inode_hugepages will still use
> filemap_get_folios for bulk folio lookups.  For indicies not returned in
> the bulk lookup, it will need to lookup individual folios to check for
> races with page fault.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c | 184 +++++++++++++++++++++++++++++++------------
>  mm/hugetlb.c         |  41 +++++-----
>  2 files changed, 152 insertions(+), 73 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index d98c6edbd1a4..e83fd31671b3 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -411,6 +411,95 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>  	}
>  }
>  
> +/*
> + * Called with hugetlb fault mutex held.
> + * Returns true if page was actually removed, false otherwise.
> + */
> +static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
> +					struct address_space *mapping,
> +					struct folio *folio, pgoff_t index,
> +					bool truncate_op)
> +{
> +	bool ret = false;
> +
> +	/*
> +	 * If folio is mapped, it was faulted in after being
> +	 * unmapped in caller.  Unmap (again) while holding
> +	 * the fault mutex.  The mutex will prevent faults
> +	 * until we finish removing the folio.
> +	 */
> +	if (unlikely(folio_mapped(folio))) {
> +		i_mmap_lock_write(mapping);
> +		hugetlb_vmdelete_list(&mapping->i_mmap,
> +					index * pages_per_huge_page(h),
> +					(index + 1) * pages_per_huge_page(h),
> +					ZAP_FLAG_DROP_MARKER);
> +		i_mmap_unlock_write(mapping);
> +	}
> +
> +	folio_lock(folio);
> +	/*
> +	 * After locking page, make sure mapping is the same.
> +	 * We could have raced with page fault populate and
> +	 * backout code.
> +	 */
> +	if (folio_mapping(folio) == mapping) {

Could you explain this more? IIUC, page fault won't remove the hugetlb page from page
cache anymore. So this check is unneeded? Or we should always check this in case future
code changing?

> +		/*
> +		 * We must remove the folio from page cache before removing
> +		 * the region/ reserve map (hugetlb_unreserve_pages).  In
> +		 * rare out of memory conditions, removal of the region/reserve
> +		 * map could fail.  Correspondingly, the subpool and global
> +		 * reserve usage count can need to be adjusted.
> +		 */
> +		VM_BUG_ON(HPageRestoreReserve(&folio->page));
> +		hugetlb_delete_from_page_cache(&folio->page);
> +		ret = true;
> +		if (!truncate_op) {
> +			if (unlikely(hugetlb_unreserve_pages(inode, index,
> +								index + 1, 1)))
> +				hugetlb_fix_reserve_counts(inode);
> +		}
> +	}
> +
> +	folio_unlock(folio);
> +	return ret;
> +}

<snip>
> @@ -5584,9 +5585,13 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  		clear_huge_page(page, address, pages_per_huge_page(h));
>  		__SetPageUptodate(page);
>  		new_page = true;
> +		if (HPageRestoreReserve(page))
> +			reserve_alloc = true;
>  
>  		if (vma->vm_flags & VM_MAYSHARE) {
> -			int err = hugetlb_add_to_page_cache(page, mapping, idx);
> +			int err;
> +
> +			err = hugetlb_add_to_page_cache(page, mapping, idx);
>  			if (err) {
>  				restore_reserve_on_error(h, vma, haddr, page);
>  				put_page(page);
> @@ -5642,10 +5647,6 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  	}
>  
>  	ptl = huge_pte_lock(h, mm, ptep);
> -	size = i_size_read(mapping->host) >> huge_page_shift(h);
> -	if (idx >= size)
> -		goto backout;
> -
>  	ret = 0;
>  	/* If pte changed from under us, retry */
>  	if (!pte_same(huge_ptep_get(ptep), old_pte))
> @@ -5689,10 +5690,18 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  backout:
>  	spin_unlock(ptl);
>  backout_unlocked:
> -	unlock_page(page);
> -	/* restore reserve for newly allocated pages not in page cache */
> -	if (new_page && !new_pagecache_page)
> +	if (new_page && !new_pagecache_page) {
> +		/*
> +		 * If reserve was consumed, make sure flag is set so that it
> +		 * will be restored in free_huge_page().
> +		 */
> +		if (reserve_alloc)
> +			SetHPageRestoreReserve(page);

If code reaches here, it should be a newly allocated page and it's not added to the hugetlb page cache.
Note that failing to add the page to hugetlb page cache should have returned already. So the page must be
anon? If so, HPageRestoreReserve isn't cleared yet as it's cleared right before set_huge_pte. Thus above
check can be removed?

Anyway, the patch looks good to me.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin

