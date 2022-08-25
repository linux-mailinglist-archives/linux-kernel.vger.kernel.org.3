Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4B75A06FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 03:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiHYBxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 21:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbiHYBww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:52:52 -0400
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9438DA2DB2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 18:46:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VNAxLYu_1661391784;
Received: from 30.97.48.44(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VNAxLYu_1661391784)
          by smtp.aliyun-inc.com;
          Thu, 25 Aug 2022 09:43:04 +0800
Message-ID: <f3ee3581-5d0b-f564-7016-783a0d91fea2@linux.alibaba.com>
Date:   Thu, 25 Aug 2022 09:43:14 +0800
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
 <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
 <7ee73879-e402-9175-eae8-41471d80d59e@redhat.com>
 <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
 <Ywa1jp/6naTmUh42@monkey>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Ywa1jp/6naTmUh42@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/2022 7:34 AM, Mike Kravetz wrote:
> On 08/24/22 17:41, Baolin Wang wrote:
>>
>>
>> On 8/24/2022 3:31 PM, David Hildenbrand wrote:
>>>>>>>
>>>>>>> IMHO, these follow_huge_xxx() functions are arch-specified at first and
>>>>>>> were moved into the common hugetlb.c by commit 9e5fc74c3025 ("mm:
>>>>>>> hugetlb: Copy general hugetlb code from x86 to mm"), and now there are
>>>>>>> still some arch-specified follow_huge_xxx() definition, for example:
>>>>>>> ia64: follow_huge_addr
>>>>>>> powerpc: follow_huge_pd
>>>>>>> s390: follow_huge_pud
>>>>>>>
>>>>>>> What I mean is that follow_hugetlb_page() is a common and
>>>>>>> not-arch-specified function, is it suitable to change it to be
>>>>>>> arch-specified?
>>>>>>> And thinking more, can we rename follow_hugetlb_page() as
>>>>>>> hugetlb_page_faultin() and simplify it to only handle the page faults of
>>>>>>> hugetlb like the faultin_page() for normal page? That means we can make
>>>>>>> sure only follow_page_mask() can handle hugetlb.
>>>>>>>
>>>>>
>>>>> Something like that might work, but you still have two page table walkers
>>>>> for hugetlb.  I like David's idea (if I understand it correctly) of
>>>>
>>>> What I mean is we may change the hugetlb handling like normal page:
>>>> 1) use follow_page_mask() to look up a hugetlb firstly.
>>>> 2) if can not get the hugetlb, then try to page fault by
>>>> hugetlb_page_faultin().
>>>> 3) if page fault successed, then retry to find hugetlb by
>>>> follow_page_mask().
>>>
>>> That implies putting more hugetlbfs special code into generic GUP,
>>> turning it even more complicated. But of course, it depends on how the
>>> end result looks like. My gut feeling was that hugetlb is better handled
>>> in follow_hugetlb_page() separately (just like we do with a lot of other
>>> page table walkers).
>>
>> OK, fair enough.
>>
>>>>
>>>> Just a rough thought, and I need more investigation for my idea and
>>>> David's idea.
>>>>
>>>>> using follow_hugetlb_page for both cases.  As noted, it will need to be
>>>>> taught how to not trigger faults in the follow_page_mask case.
>>>>
>>>> Anyway, I also agree we need some cleanup, and firstly I think we should
>>>> cleanup these arch-specified follow_huge_xxx() on some architectures
>>>> which are similar with the common ones. I will look into these.
>>>
>>> There was a recent discussion on that, e.g.:
>>>
>>> https://lkml.kernel.org/r/20220818135717.609eef8a@thinkpad
>>
>> Thanks.
>>
>>>
>>>>
>>>> However, considering cleanup may need more investigation and
>>>> refactoring, now I prefer to make these bug-fix patches of this patchset
>>>> into mainline firstly, which are suitable to backport to old version to
>>>> fix potential race issues. Mike and David, how do you think? Could you
>>>> help to review these patches? Thanks.
>>>
>>> Patch #1 certainly add more special code just to handle another hugetlb
>>> corner case (CONT pages), and maybe just making it all use
>>> follow_hugetlb_page() would be even cleaner and less error prone.
>>>
>>> I agree that locking is shaky, but I'm not sure if we really want to
>>> backport this to stable trees:
>>>
>>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>>
>>> "It must fix a real bug that bothers people (not a, “This could be a
>>> problem...” type thing)."
>>>
>>>
>>> Do we actually have any instance of this being a real (and not a
>>> theoretical) problem? If not, I'd rather clean it all up right away.
>>
>> I think this is a real problem (not theoretical), and easy to write some
>> code to show the issue. For example, suppose thread A is trying to look up a
>> CONT-PTE size hugetlb page under the lock, however antoher thread B can
>> migrate the CONT-PTE hugetlb page at the same time, which will cause thread
>> A to get an incorrect page, if thread A want to do something for this
>> incorrect page, error occurs.
> 
> Is the primary concern the locking?  If so, I am not sure we have an issue.

Yes.

> As mentioned in your commit message, current code will use
> pte_offset_map_lock().  pte_offset_map_lock uses pte_lockptr, and pte_lockptr
> will either be the mm wide lock or pmd_page lock.  To me, it seems that

The ALLOC_SPLIT_PTLOCKS can be always true on my machine, that means the 
pte_lockptr() will always use the PTE page lock, however huge_pte_lock() 
will use the mm wide lock.

> either would provide correct synchronization for CONT-PTE entries.  Am I
> missing something or misreading the code?
> 
> I started looking at code cleanup suggested by David.  Here is a quick
> patch (not tested and likely containing errors) to see if this is a step
> in the right direction.
> 
> I like it because we get rid of/combine all those follow_huge_p*d
> routines.

Great, this looks straight forward to me (some nits as below).
David, how do you think?

> 
>  From 35d117a707c1567ddf350554298697d40eace0d7 Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Wed, 24 Aug 2022 15:59:15 -0700
> Subject: [PATCH] hugetlb: call hugetlb_follow_page_mask for hugetlb pages in
>   follow_page_mask
> 
> At the beginning of follow_page_mask, there currently is a call to
> follow_huge_addr which 'may' handle hugetlb pages.  ia64 is the only
> architecture which (incorrectly) provides a follow_huge_addr routine
> that does not return error.  Instead, at each level of the page table a
> check is made for a hugetlb entry.  If a hugetlb entry is found, a call
> to a routine associated with that page table level such as
> follow_huge_pmd is made.
> 
> All the follow_huge_p*d routines are basically the same.  In addition
> huge page size can be derived from the vma, so we know where in the page
> table a huge page would reside.  So, replace follow_huge_addr with a
> new architecture independent routine which will provide the same
> functionality as the follow_huge_p*d routines.  We can then eliminate
> the p*d_huge checks in follow_page_mask page table walking as well as
> the follow_huge_p*d routines themselves.
> 
> follow_page_mask still has is_hugepd hugetlb checks during page table
> walking.  This is due to these checks and follow_huge_pd being
> architecture specific.  These can be eliminated if
> hugetlb_follow_page_mask can be overwritten by architectures (powerpc)
> that need to do follow_huge_pd processing.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   arch/ia64/mm/hugetlbpage.c |  15 ----
>   arch/s390/mm/hugetlbpage.c |  10 ---
>   include/linux/hugetlb.h    |  41 +++-------
>   mm/gup.c                   |  27 +------
>   mm/hugetlb.c               | 159 ++++++++++++-------------------------
>   5 files changed, 62 insertions(+), 190 deletions(-)
> 
> diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
> index f993cb36c062..380d2f3966c9 100644
> --- a/arch/ia64/mm/hugetlbpage.c
> +++ b/arch/ia64/mm/hugetlbpage.c
> @@ -91,21 +91,6 @@ int prepare_hugepage_range(struct file *file,
>   	return 0;
>   }
>   
> -struct page *follow_huge_addr(struct mm_struct *mm, unsigned long addr, int write)
> -{
> -	struct page *page;
> -	pte_t *ptep;
> -
> -	if (REGION_NUMBER(addr) != RGN_HPAGE)
> -		return ERR_PTR(-EINVAL);
> -
> -	ptep = huge_pte_offset(mm, addr, HPAGE_SIZE);
> -	if (!ptep || pte_none(*ptep))
> -		return NULL;
> -	page = pte_page(*ptep);
> -	page += ((addr & ~HPAGE_MASK) >> PAGE_SHIFT);
> -	return page;
> -}
>   int pmd_huge(pmd_t pmd)
>   {
>   	return 0;
> diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
> index 10e51ef9c79a..c299a18273ff 100644
> --- a/arch/s390/mm/hugetlbpage.c
> +++ b/arch/s390/mm/hugetlbpage.c
> @@ -237,16 +237,6 @@ int pud_huge(pud_t pud)
>   	return pud_large(pud);
>   }
>   
> -struct page *
> -follow_huge_pud(struct mm_struct *mm, unsigned long address,
> -		pud_t *pud, int flags)
> -{
> -	if (flags & FOLL_GET)
> -		return NULL;
> -
> -	return pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
> -}
> -
>   bool __init arch_hugetlb_valid_size(unsigned long size)
>   {
>   	if (MACHINE_HAS_EDAT1 && size == PMD_SIZE)
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 3ec981a0d8b3..0c19d200c851 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -142,6 +142,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>   			     unsigned long len);
>   int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
>   			    struct vm_area_struct *, struct vm_area_struct *);
> +struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> +                              unsigned long address, unsigned int flags);
>   long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
>   			 struct page **, struct vm_area_struct **,
>   			 unsigned long *, unsigned long *, long, unsigned int,
> @@ -202,17 +204,9 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>   				unsigned long addr, pte_t *ptep);
>   void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>   				unsigned long *start, unsigned long *end);
> -struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
> -			      int write);
>   struct page *follow_huge_pd(struct vm_area_struct *vma,
>   			    unsigned long address, hugepd_t hpd,
>   			    int flags, int pdshift);
> -struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
> -				pmd_t *pmd, int flags);
> -struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
> -				pud_t *pud, int flags);
> -struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
> -			     pgd_t *pgd, int flags);
>   
>   int pmd_huge(pmd_t pmd);
>   int pud_huge(pud_t pud);
> @@ -257,6 +251,13 @@ static inline void adjust_range_if_pmd_sharing_possible(
>   {
>   }
>   
> +static inline struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> +                              unsigned long address, unsigned int flags)
> +{
> +	/* should never happen, but do not want to BUG */
> +	return ERR_PTR(-EINVAL);
> +}
> +
>   static inline long follow_hugetlb_page(struct mm_struct *mm,
>   			struct vm_area_struct *vma, struct page **pages,
>   			struct vm_area_struct **vmas, unsigned long *position,
> @@ -267,12 +268,6 @@ static inline long follow_hugetlb_page(struct mm_struct *mm,
>   	return 0;
>   }
>   
> -static inline struct page *follow_huge_addr(struct mm_struct *mm,
> -					unsigned long address, int write)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
>   static inline int copy_hugetlb_page_range(struct mm_struct *dst,
>   					  struct mm_struct *src,
>   					  struct vm_area_struct *dst_vma,
> @@ -312,24 +307,6 @@ static inline struct page *follow_huge_pd(struct vm_area_struct *vma,
>   	return NULL;
>   }
>   
> -static inline struct page *follow_huge_pmd(struct mm_struct *mm,
> -				unsigned long address, pmd_t *pmd, int flags)
> -{
> -	return NULL;
> -}
> -
> -static inline struct page *follow_huge_pud(struct mm_struct *mm,
> -				unsigned long address, pud_t *pud, int flags)
> -{
> -	return NULL;
> -}
> -
> -static inline struct page *follow_huge_pgd(struct mm_struct *mm,
> -				unsigned long address, pgd_t *pgd, int flags)
> -{
> -	return NULL;
> -}
> -
>   static inline int prepare_hugepage_range(struct file *file,
>   				unsigned long addr, unsigned long len)
>   {
> diff --git a/mm/gup.c b/mm/gup.c
> index 3b656b7e8a3c..a93c04437faa 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -661,12 +661,6 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>   	pmdval = READ_ONCE(*pmd);
>   	if (pmd_none(pmdval))
>   		return no_page_table(vma, flags);
> -	if (pmd_huge(pmdval) && is_vm_hugetlb_page(vma)) {
> -		page = follow_huge_pmd(mm, address, pmd, flags);
> -		if (page)
> -			return page;
> -		return no_page_table(vma, flags);
> -	}
>   	if (is_hugepd(__hugepd(pmd_val(pmdval)))) {
>   		page = follow_huge_pd(vma, address,
>   				      __hugepd(pmd_val(pmdval)), flags,
> @@ -764,12 +758,6 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
>   	pud = pud_offset(p4dp, address);
>   	if (pud_none(*pud))
>   		return no_page_table(vma, flags);
> -	if (pud_huge(*pud) && is_vm_hugetlb_page(vma)) {
> -		page = follow_huge_pud(mm, address, pud, flags);
> -		if (page)
> -			return page;
> -		return no_page_table(vma, flags);
> -	}
>   	if (is_hugepd(__hugepd(pud_val(*pud)))) {
>   		page = follow_huge_pd(vma, address,
>   				      __hugepd(pud_val(*pud)), flags,
> @@ -851,24 +839,15 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
>   
>   	ctx->page_mask = 0;
>   
> -	/* make this handle hugepd */
> -	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
> -	if (!IS_ERR(page)) {
> -		WARN_ON_ONCE(flags & (FOLL_GET | FOLL_PIN));
> -		return page;
> -	}
> +	/* hugetlb is special */
> +	if (is_vm_hugetlb_page(vma))
> +		return hugetlb_follow_page_mask(vma, address, flags);
>   
>   	pgd = pgd_offset(mm, address);
>   
>   	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
>   		return no_page_table(vma, flags);
>   
> -	if (pgd_huge(*pgd)) {
> -		page = follow_huge_pgd(mm, address, pgd, flags);
> -		if (page)
> -			return page;
> -		return no_page_table(vma, flags);
> -	}
>   	if (is_hugepd(__hugepd(pgd_val(*pgd)))) {
>   		page = follow_huge_pd(vma, address,
>   				      __hugepd(pgd_val(*pgd)), flags,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6c00ba1dde32..947401df8190 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6168,6 +6168,56 @@ static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
>   	return false;
>   }
>   
> +struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> +				unsigned long address, unsigned int flags)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long haddr = address & huge_page_mask(h);
> +	struct page *page = NULL;
> +	spinlock_t *ptl;
> +	pte_t *pte, entry;
> +
> +	/*
> +	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> +	 * follow_hugetlb_page().
> +	 */
> +	if (WARN_ON_ONCE(flags & FOLL_PIN))
> +		return NULL;
> +
> +	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
> +	if (!pte)
> +		return NULL;
> +
> +retry:
> +	ptl = huge_pte_lock(h, mm, pte);
> +	entry = huge_ptep_get(pte);
> +	if (pte_present(entry)) {
> +		page = pte_page(entry);

Should follow previous logic?
page = pte_page(entry) + ((address & ~huge_page_mask(h)) >> PAGE_SHIFT);

> +		/*
> +		 * try_grab_page() should always succeed here, because we hold
> +		 * the ptl lock and have verified pte_present().
> +		 */
> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
> +			page = NULL;
> +			goto out;
> +		}
> +	} else {

Should add FOLL_MIGRATION validation before waiting a migration entry.

> +		if (is_hugetlb_entry_migration(entry)) {
> +			spin_unlock(ptl);
> +			__migration_entry_wait_huge(pte, ptl);
> +			goto retry;
> +		}
> +		/*
> +		 * hwpoisoned entry is treated as no_page_table in
> +		 * follow_page_mask().
> +		 */
> +	}
> +out:
> +	spin_unlock(ptl);
> +	return page;
> +}
> +
>   long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   			 struct page **pages, struct vm_area_struct **vmas,
>   			 unsigned long *position, unsigned long *nr_pages,
> @@ -6966,13 +7016,6 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
>    * These functions are overwritable if your architecture needs its own
>    * behavior.
>    */
> -struct page * __weak
> -follow_huge_addr(struct mm_struct *mm, unsigned long address,
> -			      int write)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
>   struct page * __weak
>   follow_huge_pd(struct vm_area_struct *vma,
>   	       unsigned long address, hugepd_t hpd, int flags, int pdshift)
> @@ -6981,108 +7024,6 @@ follow_huge_pd(struct vm_area_struct *vma,
>   	return NULL;
>   }
>   
> -struct page * __weak
> -follow_huge_pmd(struct mm_struct *mm, unsigned long address,
> -		pmd_t *pmd, int flags)
> -{
> -	struct page *page = NULL;
> -	spinlock_t *ptl;
> -	pte_t pte;
> -
> -	/*
> -	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
> -	 * follow_hugetlb_page().
> -	 */
> -	if (WARN_ON_ONCE(flags & FOLL_PIN))
> -		return NULL;
> -
> -retry:
> -	ptl = pmd_lockptr(mm, pmd);
> -	spin_lock(ptl);
> -	/*
> -	 * make sure that the address range covered by this pmd is not
> -	 * unmapped from other threads.
> -	 */
> -	if (!pmd_huge(*pmd))
> -		goto out;
> -	pte = huge_ptep_get((pte_t *)pmd);
> -	if (pte_present(pte)) {
> -		page = pmd_page(*pmd) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
> -		/*
> -		 * try_grab_page() should always succeed here, because: a) we
> -		 * hold the pmd (ptl) lock, and b) we've just checked that the
> -		 * huge pmd (head) page is present in the page tables. The ptl
> -		 * prevents the head page and tail pages from being rearranged
> -		 * in any way. So this page must be available at this point,
> -		 * unless the page refcount overflowed:
> -		 */
> -		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
> -			page = NULL;
> -			goto out;
> -		}
> -	} else {
> -		if (is_hugetlb_entry_migration(pte)) {
> -			spin_unlock(ptl);
> -			__migration_entry_wait_huge((pte_t *)pmd, ptl);
> -			goto retry;
> -		}
> -		/*
> -		 * hwpoisoned entry is treated as no_page_table in
> -		 * follow_page_mask().
> -		 */
> -	}
> -out:
> -	spin_unlock(ptl);
> -	return page;
> -}
> -
> -struct page * __weak
> -follow_huge_pud(struct mm_struct *mm, unsigned long address,
> -		pud_t *pud, int flags)
> -{
> -	struct page *page = NULL;
> -	spinlock_t *ptl;
> -	pte_t pte;
> -
> -	if (WARN_ON_ONCE(flags & FOLL_PIN))
> -		return NULL;
> -
> -retry:
> -	ptl = huge_pte_lock(hstate_sizelog(PUD_SHIFT), mm, (pte_t *)pud);
> -	if (!pud_huge(*pud))
> -		goto out;
> -	pte = huge_ptep_get((pte_t *)pud);
> -	if (pte_present(pte)) {
> -		page = pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
> -		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
> -			page = NULL;
> -			goto out;
> -		}
> -	} else {
> -		if (is_hugetlb_entry_migration(pte)) {
> -			spin_unlock(ptl);
> -			__migration_entry_wait(mm, (pte_t *)pud, ptl);
> -			goto retry;
> -		}
> -		/*
> -		 * hwpoisoned entry is treated as no_page_table in
> -		 * follow_page_mask().
> -		 */
> -	}
> -out:
> -	spin_unlock(ptl);
> -	return page;
> -}
> -
> -struct page * __weak
> -follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int flags)
> -{
> -	if (flags & (FOLL_GET | FOLL_PIN))
> -		return NULL;
> -
> -	return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
> -}
> -
>   int isolate_hugetlb(struct page *page, struct list_head *list)
>   {
>   	int ret = 0;
