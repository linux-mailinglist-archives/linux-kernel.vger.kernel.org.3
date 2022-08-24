Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7982D59F13F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 04:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiHXCG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 22:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiHXCG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 22:06:26 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E876DF90
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:06:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VN57Dgm_1661306781;
Received: from 30.97.48.45(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VN57Dgm_1661306781)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 10:06:21 +0800
Message-ID: <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
Date:   Wed, 24 Aug 2022 10:06:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
 <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
 <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
 <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
 <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com> <YwVo7xSO+VebkIfQ@monkey>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YwVo7xSO+VebkIfQ@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2022 7:55 AM, Mike Kravetz wrote:
> On 08/23/22 12:23, David Hildenbrand wrote:
>> On 23.08.22 12:02, Baolin Wang wrote:
>>>
>>>
>>> On 8/23/2022 4:29 PM, David Hildenbrand wrote:
>>>> On 23.08.22 09:50, Baolin Wang wrote:
>>>>> On some architectures (like ARM64), it can support CONT-PTE/PMD size
>>>>> hugetlb, which means it can support not only PMD/PUD size hugetlb
>>>>> (2M and 1G), but also CONT-PTE/PMD size(64K and 32M) if a 4K page size
>>>>> specified.
>>>>>
>>>>> So when looking up a CONT-PTE size hugetlb page by follow_page(), it
>>>>> will use pte_offset_map_lock() to get the pte entry lock for the CONT-PTE
>>>>> size hugetlb in follow_page_pte(). However this pte entry lock is incorrect
>>>>> for the CONT-PTE size hugetlb, since we should use huge_pte_lock() to
>>>>> get the correct lock, which is mm->page_table_lock.
>>>>>
>>>>> That means the pte entry of the CONT-PTE size hugetlb under current
>>>>> pte lock is unstable in follow_page_pte(), we can continue to migrate
>>>>> or poison the pte entry of the CONT-PTE size hugetlb, which can cause
>>>>> some potential race issues, and following pte_xxx() validation is also
>>>>> unstable in follow_page_pte(), even though they are under the 'pte lock'.
>>>>>
>>>>> Moreover we should use huge_ptep_get() to get the pte entry value of
>>>>> the CONT-PTE size hugetlb, which already takes into account the subpages'
>>>>> dirty or young bits in case we missed the dirty or young state of the
>>>>> CONT-PTE size hugetlb.
>>>>>
>>>>> To fix above issues, introducing a new helper follow_huge_pte() to look
>>>>> up a CONT-PTE size hugetlb page, which uses huge_pte_lock() to get the
>>>>> correct pte entry lock to make the pte entry stable, as well as
>>>>> supporting non-present pte handling.
>>>>>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> ---
>>>>>    include/linux/hugetlb.h |  8 ++++++++
>>>>>    mm/gup.c                | 11 ++++++++++
>>>>>    mm/hugetlb.c            | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>    3 files changed, 72 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>>>> index 3ec981a..d491138 100644
>>>>> --- a/include/linux/hugetlb.h
>>>>> +++ b/include/linux/hugetlb.h
>>>>> @@ -207,6 +207,8 @@ struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
>>>>>    struct page *follow_huge_pd(struct vm_area_struct *vma,
>>>>>    			    unsigned long address, hugepd_t hpd,
>>>>>    			    int flags, int pdshift);
>>>>> +struct page *follow_huge_pte(struct vm_area_struct *vma, unsigned long address,
>>>>> +			     pmd_t *pmd, int flags);
>>>>>    struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>>>>>    				pmd_t *pmd, int flags);
>>>>>    struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
>>>>> @@ -312,6 +314,12 @@ static inline struct page *follow_huge_pd(struct vm_area_struct *vma,
>>>>>    	return NULL;
>>>>>    }
>>>>>    
>>>>> +static inline struct page *follow_huge_pte(struct vm_area_struct *vma,
>>>>> +				unsigned long address, pmd_t *pmd, int flags)
>>>>> +{
>>>>> +	return NULL;
>>>>> +}
>>>>> +
>>>>>    static inline struct page *follow_huge_pmd(struct mm_struct *mm,
>>>>>    				unsigned long address, pmd_t *pmd, int flags)
>>>>>    {
>>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>>> index 3b656b7..87a94f5 100644
>>>>> --- a/mm/gup.c
>>>>> +++ b/mm/gup.c
>>>>> @@ -534,6 +534,17 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>>>>>    	if (unlikely(pmd_bad(*pmd)))
>>>>>    		return no_page_table(vma, flags);
>>>>>    
>>>>> +	/*
>>>>> +	 * Considering PTE level hugetlb, like continuous-PTE hugetlb on
>>>>> +	 * ARM64 architecture.
>>>>> +	 */
>>>>> +	if (is_vm_hugetlb_page(vma)) {
>>>>> +		page = follow_huge_pte(vma, address, pmd, flags);
>>>>> +		if (page)
>>>>> +			return page;
>>>>> +		return no_page_table(vma, flags);
>>>>> +	}
>>>>> +
>>>>>    	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
>>>>>    	pte = *ptep;
>>>>>    	if (!pte_present(pte)) {
>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>> index 6c00ba1..cf742d1 100644
>>>>> --- a/mm/hugetlb.c
>>>>> +++ b/mm/hugetlb.c
>>>>> @@ -6981,6 +6981,59 @@ struct page * __weak
>>>>>    	return NULL;
>>>>>    }
>>>>>    
>>>>> +/* Support looking up a CONT-PTE size hugetlb page. */
>>>>> +struct page * __weak
>>>>> +follow_huge_pte(struct vm_area_struct *vma, unsigned long address,
>>>>> +		pmd_t *pmd, int flags)
>>>>> +{
>>>>> +	struct mm_struct *mm = vma->vm_mm;
>>>>> +	struct hstate *hstate = hstate_vma(vma);
>>>>> +	unsigned long size = huge_page_size(hstate);
>>>>> +	struct page *page = NULL;
>>>>> +	spinlock_t *ptl;
>>>>> +	pte_t *ptep, pte;
>>>>> +
>>>>> +	/*
>>>>> +	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
>>>>> +	 * follow_hugetlb_page().
>>>>> +	 */
>>>>> +	if (WARN_ON_ONCE(flags & FOLL_PIN))
>>>>> +		return NULL;
>>>>> +
>>>>> +	ptep = huge_pte_offset(mm, address, size);
>>>>> +	if (!ptep)
>>>>> +		return NULL;
>>>>> +
>>>>> +retry:
>>>>> +	ptl = huge_pte_lock(hstate, mm, ptep);
>>>>> +	pte = huge_ptep_get(ptep);
>>>>> +	if (pte_present(pte)) {
>>>>> +		page = pte_page(pte);
>>>>> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
>>>>> +			page = NULL;
>>>>> +			goto out;
>>>>> +		}
>>>>> +	} else {
>>>>> +		if (!(flags & FOLL_MIGRATION)) {
>>>>> +			page = NULL;
>>>>> +			goto out;
>>>>> +		}
>>>>> +
>>>>> +		if (is_hugetlb_entry_migration(pte)) {
>>>>> +			spin_unlock(ptl);
>>>>> +			__migration_entry_wait_huge(ptep, ptl);
>>>>> +			goto retry;
>>>>> +		}
>>>>> +		/*
>>>>> +		 * hwpoisoned entry is treated as no_page_table in
>>>>> +		 * follow_page_mask().
>>>>> +		 */
>>>>> +	}
>>>>> +out:
>>>>> +	spin_unlock(ptl);
>>>>> +	return page;
>>>>> +}
>>>>> +
>>>>>    struct page * __weak
>>>>>    follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>>>>>    		pmd_t *pmd, int flags)
>>>>
>>>>
>>>> Can someone explain why:
>>>> * follow_page() goes via follow_page_mask() for hugetlb
>>>> * __get_user_pages() goes via follow_hugetlb_page() and never via
>>>>     follow_page_mask() for hugetlb?
>>>>
>>>> IOW, why can't we make follow_page_mask() just not handle hugetlb and
>>>> route everything via follow_hugetlb_page() -- we primarily only have to
>>>> teach it to not trigger faults.
> 
> I have no idea how we got into this situation, and do agree that it
> makes little sense for both follow_page_mask and follow_hugetlb_page to
> do page table walking differently for hugetlb pages.
> 
> I think I have noted elsewhere that all those follow_huge_p*d rotines
> will look the same.  It seems they were just added as needed when the
> follow_page_mask page table walking code was fleshed out.  This also
> needs a cleanup.  If we eliminate hugetlb handling from follow_page_mask,
> perhaps we can get rid of all these?
> 
>>>
>>> IMHO, these follow_huge_xxx() functions are arch-specified at first and
>>> were moved into the common hugetlb.c by commit 9e5fc74c3025 ("mm:
>>> hugetlb: Copy general hugetlb code from x86 to mm"), and now there are
>>> still some arch-specified follow_huge_xxx() definition, for example:
>>> ia64: follow_huge_addr
>>> powerpc: follow_huge_pd
>>> s390: follow_huge_pud
>>>
>>> What I mean is that follow_hugetlb_page() is a common and
>>> not-arch-specified function, is it suitable to change it to be
>>> arch-specified?
>>> And thinking more, can we rename follow_hugetlb_page() as
>>> hugetlb_page_faultin() and simplify it to only handle the page faults of
>>> hugetlb like the faultin_page() for normal page? That means we can make
>>> sure only follow_page_mask() can handle hugetlb.
>>>
> 
> Something like that might work, but you still have two page table walkers
> for hugetlb.  I like David's idea (if I understand it correctly) of

What I mean is we may change the hugetlb handling like normal page:
1) use follow_page_mask() to look up a hugetlb firstly.
2) if can not get the hugetlb, then try to page fault by 
hugetlb_page_faultin().
3) if page fault successed, then retry to find hugetlb by 
follow_page_mask().

Just a rough thought, and I need more investigation for my idea and 
David's idea.

> using follow_hugetlb_page for both cases.  As noted, it will need to be
> taught how to not trigger faults in the follow_page_mask case.

Anyway, I also agree we need some cleanup, and firstly I think we should 
cleanup these arch-specified follow_huge_xxx() on some architectures 
which are similar with the common ones. I will look into these.

However, considering cleanup may need more investigation and 
refactoring, now I prefer to make these bug-fix patches of this patchset 
into mainline firstly, which are suitable to backport to old version to 
fix potential race issues. Mike and David, how do you think? Could you 
help to review these patches? Thanks.
