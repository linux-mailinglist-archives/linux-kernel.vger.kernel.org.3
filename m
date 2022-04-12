Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69D74FCCC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343671AbiDLC6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbiDLC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:58:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B6B15FD1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:55:45 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KcqxC29znzBsGf;
        Tue, 12 Apr 2022 10:51:27 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 10:55:43 +0800
Subject: Re: [PATCH 4/4] mm/migration: fix potential pte_unmap on an not
 mapped pte
To:     David Hildenbrand <david@redhat.com>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ying.huang@intel.com>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <dave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <jhubbard@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <osalvador@suse.de>, <sfr@canb.auug.org.au>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220409073846.22286-1-linmiaohe@huawei.com>
 <20220409073846.22286-5-linmiaohe@huawei.com>
 <a190e78f-d833-780b-6fbe-b129c2505deb@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3dc955b1-43c9-487a-b1e6-f0f128da7722@huawei.com>
Date:   Tue, 12 Apr 2022 10:55:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a190e78f-d833-780b-6fbe-b129c2505deb@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/11 19:41, David Hildenbrand wrote:
> On 09.04.22 09:38, Miaohe Lin wrote:
>> __migration_entry_wait and migration_entry_wait_on_locked assume pte is
>> always mapped from caller. But this is not the case when it's called from
>> migration_entry_wait_huge and follow_huge_pmd. And a parameter unmap to
>> indicate whether pte needs to be unmapped to fix this issue.
> 
> Hm.
> 
> 
> migration_entry_wait_on_locked documents
> 
> "@ptep: mapped pte pointer. Will return with the ptep unmapped. Only
> required for pte entries, pass NULL for pmd entries."
> 
> Setting ptep implies that we have a *mapped pte* pointer that requires unmap.
> If some code sets that although that's not guaranteed, that calling code
> is wrong and needs to be fixed to not pass a ptep.
> 
> 
> hugetlbfs never requires a map/unmap. I really don't see we there is need to
> adjust migration_entry_wait_on_locked(): just don't pass a ptep as documented.
> 
> What's really nasty here is that hugetlbfs actually mostly works on PMD/PUD,
> but we call it PTEs. One corner case might be CONT PTEs, but they are also
> accessed without a map+unmap.
> 
> Regarding __migration_entry_wait(), I think we should just stop using it for
> hugetlbfs and have a proper hugetlbfs variant that calls
> hugetlb_migration_entry_wait(ptep == NULL), and knows that although we're
> handling ptes, we're usually not actually holding ptes in our hands
> that need a map+unmap.
> 
> 
> Something like (including some cleanups mm parameter):

This really helps! Many thanks! Will try to do this in next version. :)

> 
> 
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 32d517a28969..898c407ad8f7 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -234,8 +234,8 @@ extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>  					spinlock_t *ptl);
>  extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  					unsigned long address);
> -extern void migration_entry_wait_huge(struct vm_area_struct *vma,
> -		struct mm_struct *mm, pte_t *pte);
> +extern void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl);
> +extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
>  #else
>  static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
>  {
> @@ -261,8 +261,9 @@ static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>  					spinlock_t *ptl) { }
>  static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  					 unsigned long address) { }
> +static inline void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl) { }
>  static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
> -		struct mm_struct *mm, pte_t *pte) { }
> +					     pte_t *pte) { }
>  static inline int is_writable_migration_entry(swp_entry_t entry)
>  {
>  	return 0;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 48740e6c3476..2b38eaaa2e60 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5622,7 +5622,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  		 */
>  		entry = huge_ptep_get(ptep);
>  		if (unlikely(is_hugetlb_entry_migration(entry))) {
> -			migration_entry_wait_huge(vma, mm, ptep);
> +			migration_entry_wait_huge(vma, ptep);
>  			return 0;
>  		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
>  			return VM_FAULT_HWPOISON_LARGE |
> @@ -6770,7 +6770,7 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>  	} else {
>  		if (is_hugetlb_entry_migration(pte)) {
>  			spin_unlock(ptl);
> -			__migration_entry_wait(mm, (pte_t *)pmd, ptl);
> +			__migration_entry_wait_huge((pte_t *)pmd, ptl);
>  			goto retry;
>  		}
>  		/*
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 231907e89b93..84b685a235fe 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -315,11 +315,26 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  	__migration_entry_wait(mm, ptep, ptl);
>  }
>  
> +void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl)
> +{
> +	swp_entry_t entry;
> +	pte_t pte;
> +
> +	spin_lock(ptl);
> +	pte = huge_ptep_get(ptep);
> +
> +	if (unlikely(!is_hugetlb_entry_migration(pte)))
> +		spin_unlock(ptl);
> +	else
> +		migration_entry_wait_on_locked(pte_to_swp_entry(pte), NULL, ptl);
> +}
> +
>  void migration_entry_wait_huge(struct vm_area_struct *vma,
>  		struct mm_struct *mm, pte_t *pte)
>  {
> -	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), mm, pte);
> -	__migration_entry_wait(mm, pte, ptl);
> +	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->mm, pte);
> +
> +	__migration_entry_wait_huge(pte, ptl);
>  }
>  
>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> 

