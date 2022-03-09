Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F4B4D2AE4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiCIItn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiCIItm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:49:42 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D3125CA6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:48:42 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KD5MX00yyz1GCG9;
        Wed,  9 Mar 2022 16:43:51 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 16:48:39 +0800
Subject: Re: [PATCH 16/16] mm/migration: fix potential pte_unmap on an not
 mapped pte
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <shy828301@gmail.com>, <willy@infradead.org>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-17-linmiaohe@huawei.com>
 <871qze5nmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <9c6873ae-7614-1178-8c9f-6e933a12e35b@huawei.com>
 <877d94gczc.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <56baf172-4a0f-676e-86ef-61e2fef87520@huawei.com>
Date:   Wed, 9 Mar 2022 16:48:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <877d94gczc.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/9 8:56, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> On 2022/3/7 13:37, Huang, Ying wrote:
>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>
>>>> __migration_entry_wait and migration_entry_wait_on_locked assume pte is
>>>> always mapped from caller. But this is not the case when it's called from
>>>> migration_entry_wait_huge and follow_huge_pmd. And a parameter unmap to
>>>> indicate whether pte needs to be unmapped to fix this issue.
>>>
>>> This seems a possible issue.
>>>
>>> Have you tested it?  It appears that it's possible to trigger the
>>> issue.  If so, you can paste the error log here.
>>
>> This might happen iff on x86 machine with HIGHMEM enabled which is uncommon
>> now (at least in my work environment).
> 
> Yes.  32-bit isn't popular now.  But you can always test it via virtual
> machine.
> 

Good idea.

>> So I can't paste the err log. And The
>> issues from this series mainly come from the code investigating with some tests.
> 
> If not too complex, I still think it's better to test your code and
> verify the problem.

Sure! :)
Many thanks.

> 
> Best Regards,
> Huang, Ying
> 
>> Thanks. :)
>>
>>>
>>> BTW: have you tested the other functionality issues in your patchset?
>>>
>>> Best Regards,
>>> Huang, Ying
>>>
>>>> Fixes: 30dad30922cc ("mm: migration: add migrate_entry_wait_huge()")
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  include/linux/migrate.h |  2 +-
>>>>  include/linux/swapops.h |  4 ++--
>>>>  mm/filemap.c            | 10 +++++-----
>>>>  mm/hugetlb.c            |  2 +-
>>>>  mm/migrate.c            | 14 ++++++++------
>>>>  5 files changed, 17 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>>>> index 66a34eae8cb6..3ef4ff699bef 100644
>>>> --- a/include/linux/migrate.h
>>>> +++ b/include/linux/migrate.h
>>>> @@ -41,7 +41,7 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
>>>>  extern int migrate_page_move_mapping(struct address_space *mapping,
>>>>  		struct page *newpage, struct page *page, int extra_count);
>>>>  void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
>>>> -				spinlock_t *ptl);
>>>> +				spinlock_t *ptl, bool unmap);
>>>>  void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
>>>>  void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
>>>>  int folio_migrate_mapping(struct address_space *mapping,
>>>> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
>>>> index d356ab4047f7..d66556875d7d 100644
>>>> --- a/include/linux/swapops.h
>>>> +++ b/include/linux/swapops.h
>>>> @@ -213,7 +213,7 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
>>>>  }
>>>>  
>>>>  extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>>>> -					spinlock_t *ptl);
>>>> +					spinlock_t *ptl, bool unmap);
>>>>  extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>>>>  					unsigned long address);
>>>>  extern void migration_entry_wait_huge(struct vm_area_struct *vma,
>>>> @@ -235,7 +235,7 @@ static inline int is_migration_entry(swp_entry_t swp)
>>>>  }
>>>>  
>>>>  static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>>>> -					spinlock_t *ptl) { }
>>>> +					spinlock_t *ptl, bool unmap) { }
>>>>  static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>>>>  					 unsigned long address) { }
>>>>  static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>> index 8f7e6088ee2a..18c353d52aae 100644
>>>> --- a/mm/filemap.c
>>>> +++ b/mm/filemap.c
>>>> @@ -1389,6 +1389,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>>>>   * @ptep: mapped pte pointer. Will return with the ptep unmapped. Only required
>>>>   *        for pte entries, pass NULL for pmd entries.
>>>>   * @ptl: already locked ptl. This function will drop the lock.
>>>> + * @unmap: indicating whether ptep need to be unmapped.
>>>>   *
>>>>   * Wait for a migration entry referencing the given page to be removed. This is
>>>>   * equivalent to put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE) except
>>>> @@ -1402,7 +1403,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>>>>   * there.
>>>>   */
>>>>  void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
>>>> -				spinlock_t *ptl)
>>>> +				spinlock_t *ptl, bool unmap)
>>>>  {
>>>>  	struct wait_page_queue wait_page;
>>>>  	wait_queue_entry_t *wait = &wait_page.wait;
>>>> @@ -1439,10 +1440,9 @@ void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
>>>>  	 * a valid reference to the page, and it must take the ptl to remove the
>>>>  	 * migration entry. So the page is valid until the ptl is dropped.
>>>>  	 */
>>>> -	if (ptep)
>>>> -		pte_unmap_unlock(ptep, ptl);
>>>> -	else
>>>> -		spin_unlock(ptl);
>>>> +	spin_unlock(ptl);
>>>> +	if (unmap && ptep)
>>>> +		pte_unmap(ptep);
>>>>  
>>>>  	for (;;) {
>>>>  		unsigned int flags;
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index 07668781c246..8088128c25db 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -6713,7 +6713,7 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>>>>  	} else {
>>>>  		if (is_hugetlb_entry_migration(pte)) {
>>>>  			spin_unlock(ptl);
>>>> -			__migration_entry_wait(mm, (pte_t *)pmd, ptl);
>>>> +			__migration_entry_wait(mm, (pte_t *)pmd, ptl, false);
>>>>  			goto retry;
>>>>  		}
>>>>  		/*
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 98a968e6f465..5519261f54fe 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -281,7 +281,7 @@ void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked)
>>>>   * When we return from this function the fault will be retried.
>>>>   */
>>>>  void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>>>> -				spinlock_t *ptl)
>>>> +				spinlock_t *ptl, bool unmap)
>>>>  {
>>>>  	pte_t pte;
>>>>  	swp_entry_t entry;
>>>> @@ -295,10 +295,12 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>>>>  	if (!is_migration_entry(entry))
>>>>  		goto out;
>>>>  
>>>> -	migration_entry_wait_on_locked(entry, ptep, ptl);
>>>> +	migration_entry_wait_on_locked(entry, ptep, ptl, unmap);
>>>>  	return;
>>>>  out:
>>>> -	pte_unmap_unlock(ptep, ptl);
>>>> +	spin_unlock(ptl);
>>>> +	if (unmap)
>>>> +		pte_unmap(ptep);
>>>>  }
>>>>  
>>>>  void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>>>> @@ -306,14 +308,14 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>>>>  {
>>>>  	spinlock_t *ptl = pte_lockptr(mm, pmd);
>>>>  	pte_t *ptep = pte_offset_map(pmd, address);
>>>> -	__migration_entry_wait(mm, ptep, ptl);
>>>> +	__migration_entry_wait(mm, ptep, ptl, true);
>>>>  }
>>>>  
>>>>  void migration_entry_wait_huge(struct vm_area_struct *vma,
>>>>  		struct mm_struct *mm, pte_t *pte)
>>>>  {
>>>>  	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), mm, pte);
>>>> -	__migration_entry_wait(mm, pte, ptl);
>>>> +	__migration_entry_wait(mm, pte, ptl, false);
>>>>  }
>>>>  
>>>>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>>> @@ -324,7 +326,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
>>>>  	ptl = pmd_lock(mm, pmd);
>>>>  	if (!is_pmd_migration_entry(*pmd))
>>>>  		goto unlock;
>>>> -	migration_entry_wait_on_locked(pmd_to_swp_entry(*pmd), NULL, ptl);
>>>> +	migration_entry_wait_on_locked(pmd_to_swp_entry(*pmd), NULL, ptl, false);
>>>>  	return;
>>>>  unlock:
>>>>  	spin_unlock(ptl);
>>> .
>>>
> .
> 

