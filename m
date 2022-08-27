Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90715A341C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 05:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbiH0DIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 23:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiH0DIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 23:08:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5D283BF7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 20:08:04 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MF1lJ2stNzlVq5;
        Sat, 27 Aug 2022 11:04:44 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 11:08:01 +0800
Subject: Re: [PATCH 3/8] hugetlb: rename remove_huge_page to
 hugetlb_delete_from_page_cache
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
 <20220824175757.20590-4-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e1a2ec0a-ff9c-04c4-96e1-2067db2d695a@huawei.com>
Date:   Sat, 27 Aug 2022 11:08:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220824175757.20590-4-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
> remove_huge_page removes a hugetlb page from the page cache.  Change
> to hugetlb_delete_from_page_cache as it is a more descriptive name.
> huge_add_to_page_cache is global in scope, but only deals with hugetlb
> pages.  For consistency and clarity, rename to hugetlb_add_to_page_cache.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

LGTM with one nit below. Thanks.

> ---
>  fs/hugetlbfs/inode.c    | 21 ++++++++++-----------
>  include/linux/hugetlb.h |  2 +-
>  mm/hugetlb.c            |  8 ++++----
>  3 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index dfb735a91bbb..d98c6edbd1a4 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -364,7 +364,7 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
>  	return -EINVAL;
>  }
>  
> -static void remove_huge_page(struct page *page)
> +static void hugetlb_delete_from_page_cache(struct page *page)
>  {
>  	ClearPageDirty(page);
>  	ClearPageUptodate(page);
> @@ -478,15 +478,14 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>  			folio_lock(folio);
>  			/*
>  			 * We must free the huge page and remove from page
> -			 * cache (remove_huge_page) BEFORE removing the
> -			 * region/reserve map (hugetlb_unreserve_pages).  In
> -			 * rare out of memory conditions, removal of the
> -			 * region/reserve map could fail. Correspondingly,
> -			 * the subpool and global reserve usage count can need
> -			 * to be adjusted.
> +			 * cache BEFORE removing the * region/reserve map

s/the * region/the region/, i.e. remove extra "*".

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin

> +			 * (hugetlb_unreserve_pages).  In rare out of memory
> +			 * conditions, removal of the region/reserve map could
> +			 * fail. Correspondingly, the subpool and global
> +			 * reserve usage count can need to be adjusted.
>  			 */
>  			VM_BUG_ON(HPageRestoreReserve(&folio->page));
> -			remove_huge_page(&folio->page);
> +			hugetlb_delete_from_page_cache(&folio->page);
>  			freed++;
>  			if (!truncate_op) {
>  				if (unlikely(hugetlb_unreserve_pages(inode,
> @@ -723,7 +722,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  		}
>  		clear_huge_page(page, addr, pages_per_huge_page(h));
>  		__SetPageUptodate(page);
> -		error = huge_add_to_page_cache(page, mapping, index);
> +		error = hugetlb_add_to_page_cache(page, mapping, index);
>  		if (unlikely(error)) {
>  			restore_reserve_on_error(h, &pseudo_vma, addr, page);
>  			put_page(page);
> @@ -735,7 +734,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  
>  		SetHPageMigratable(page);
>  		/*
> -		 * unlock_page because locked by huge_add_to_page_cache()
> +		 * unlock_page because locked by hugetlb_add_to_page_cache()
>  		 * put_page() due to reference from alloc_huge_page()
>  		 */
>  		unlock_page(page);
> @@ -980,7 +979,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
>  	struct inode *inode = mapping->host;
>  	pgoff_t index = page->index;
>  
> -	remove_huge_page(page);
> +	hugetlb_delete_from_page_cache(page);
>  	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
>  		hugetlb_fix_reserve_counts(inode);
>  
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 3ec981a0d8b3..acace1a25226 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -665,7 +665,7 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
>  				nodemask_t *nmask, gfp_t gfp_mask);
>  struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>  				unsigned long address);
> -int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
> +int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
>  			pgoff_t idx);
>  void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
>  				unsigned long address, struct page *page);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 95c6f9a5bbf0..11c02513588c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5445,7 +5445,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
>  	return page != NULL;
>  }
>  
> -int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
> +int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
>  			   pgoff_t idx)
>  {
>  	struct folio *folio = page_folio(page);
> @@ -5586,7 +5586,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  		new_page = true;
>  
>  		if (vma->vm_flags & VM_MAYSHARE) {
> -			int err = huge_add_to_page_cache(page, mapping, idx);
> +			int err = hugetlb_add_to_page_cache(page, mapping, idx);
>  			if (err) {
>  				restore_reserve_on_error(h, vma, haddr, page);
>  				put_page(page);
> @@ -5993,11 +5993,11 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  
>  		/*
>  		 * Serialization between remove_inode_hugepages() and
> -		 * huge_add_to_page_cache() below happens through the
> +		 * hugetlb_add_to_page_cache() below happens through the
>  		 * hugetlb_fault_mutex_table that here must be hold by
>  		 * the caller.
>  		 */
> -		ret = huge_add_to_page_cache(page, mapping, idx);
> +		ret = hugetlb_add_to_page_cache(page, mapping, idx);
>  		if (ret)
>  			goto out_release_nounlock;
>  		page_in_pagecache = true;
> 

