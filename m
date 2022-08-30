Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE4D5A58D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiH3BGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH3BGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:06:12 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BB77EFE9;
        Mon, 29 Aug 2022 18:06:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VNhytaX_1661821564;
Received: from 30.97.48.45(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VNhytaX_1661821564)
          by smtp.aliyun-inc.com;
          Tue, 30 Aug 2022 09:06:05 +0800
Message-ID: <57c8f032-e48a-bacb-7922-3e2cc10dc0d2@linux.alibaba.com>
Date:   Tue, 30 Aug 2022 09:06:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, inuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220829234053.159158-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 8/30/2022 7:40 AM, Mike Kravetz wrote:
> During discussions of this series [1], it was suggested that hugetlb
> handling code in follow_page_mask could be simplified.  At the beginning
> of follow_page_mask, there currently is a call to follow_huge_addr which
> 'may' handle hugetlb pages.  ia64 is the only architecture which provides
> a follow_huge_addr routine that does not return error.  Instead, at each
> level of the page table a check is made for a hugetlb entry.  If a hugetlb
> entry is found, a call to a routine associated with that entry is made.
> 
> Currently, there are two checks for hugetlb entries at each page table
> level.  The first check is of the form:
> 	if (p?d_huge())
> 		page = follow_huge_p?d();
> the second check is of the form:
> 	if (is_hugepd())
> 		page = follow_huge_pd().
> 
> We can replace these checks, as well as the special handling routines
> such as follow_huge_p?d() and follow_huge_pd() with a single routine to
> handle hugetlb vmas.
> 
> A new routine hugetlb_follow_page_mask is called for hugetlb vmas at the
> beginning of follow_page_mask.  hugetlb_follow_page_mask will use the
> existing routine huge_pte_offset to walk page tables looking for hugetlb
> entries.  huge_pte_offset can be overwritten by architectures, and already
> handles special cases such as hugepd entries.

Could you also mention that this patch will fix the lock issue for 
CONT-PTE/PMD hugetlb by changing to use huge_pte_lock()? which will help 
people to understand the issue.

Otherwise the changes look good to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> 
> [1] https://lore.kernel.org/linux-mm/cover.1661240170.git.baolin.wang@linux.alibaba.com/
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   arch/ia64/mm/hugetlbpage.c    |  15 ---
>   arch/powerpc/mm/hugetlbpage.c |  37 --------
>   include/linux/hugetlb.h       |  51 ++--------
>   mm/gup.c                      |  65 ++-----------
>   mm/hugetlb.c                  | 173 +++++++++++-----------------------
>   5 files changed, 74 insertions(+), 267 deletions(-)
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
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index bc84a594ca62..b0e037c75c12 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -506,43 +506,6 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
>   	} while (addr = next, addr != end);
>   }
>   
> -struct page *follow_huge_pd(struct vm_area_struct *vma,
> -			    unsigned long address, hugepd_t hpd,
> -			    int flags, int pdshift)
> -{
> -	pte_t *ptep;
> -	spinlock_t *ptl;
> -	struct page *page = NULL;
> -	unsigned long mask;
> -	int shift = hugepd_shift(hpd);
> -	struct mm_struct *mm = vma->vm_mm;
> -
> -retry:
> -	/*
> -	 * hugepage directory entries are protected by mm->page_table_lock
> -	 * Use this instead of huge_pte_lockptr
> -	 */
> -	ptl = &mm->page_table_lock;
> -	spin_lock(ptl);
> -
> -	ptep = hugepte_offset(hpd, address, pdshift);
> -	if (pte_present(*ptep)) {
> -		mask = (1UL << shift) - 1;
> -		page = pte_page(*ptep);
> -		page += ((address & mask) >> PAGE_SHIFT);
> -		if (flags & FOLL_GET)
> -			get_page(page);
> -	} else {
> -		if (is_hugetlb_entry_migration(*ptep)) {
> -			spin_unlock(ptl);
> -			__migration_entry_wait(mm, ptep, ptl);
> -			goto retry;
> -		}
> -	}
> -	spin_unlock(ptl);
> -	return page;
> -}
> -
>   bool __init arch_hugetlb_valid_size(unsigned long size)
>   {
>   	int shift = __ffs(size);
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 852f911d676e..8ea3e5e726e4 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -142,6 +142,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>   			     unsigned long len);
>   int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
>   			    struct vm_area_struct *, struct vm_area_struct *);
> +struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> +				unsigned long address, unsigned int flags);
>   long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
>   			 struct page **, struct vm_area_struct **,
>   			 unsigned long *, unsigned long *, long, unsigned int,
> @@ -202,17 +204,6 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>   				unsigned long addr, pte_t *ptep);
>   void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>   				unsigned long *start, unsigned long *end);
> -struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
> -			      int write);
> -struct page *follow_huge_pd(struct vm_area_struct *vma,
> -			    unsigned long address, hugepd_t hpd,
> -			    int flags, int pdshift);
> -struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
> -				pmd_t *pmd, int flags);
> -struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
> -				pud_t *pud, int flags);
> -struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
> -			     pgd_t *pgd, int flags);
>   
>   void hugetlb_vma_lock_read(struct vm_area_struct *vma);
>   void hugetlb_vma_unlock_read(struct vm_area_struct *vma);
> @@ -264,6 +255,13 @@ static inline void adjust_range_if_pmd_sharing_possible(
>   {
>   }
>   
> +static struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> +				unsigned long address, unsigned int flags)
> +{
> +	/* should never happen, but do not want to BUG */
> +	return ERR_PTR(-EINVAL);
> +}
> +
>   static inline long follow_hugetlb_page(struct mm_struct *mm,
>   			struct vm_area_struct *vma, struct page **pages,
>   			struct vm_area_struct **vmas, unsigned long *position,
> @@ -274,12 +272,6 @@ static inline long follow_hugetlb_page(struct mm_struct *mm,
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
> @@ -312,31 +304,6 @@ static inline void hugetlb_show_meminfo_node(int nid)
>   {
>   }
>   
> -static inline struct page *follow_huge_pd(struct vm_area_struct *vma,
> -				unsigned long address, hugepd_t hpd, int flags,
> -				int pdshift)
> -{
> -	return NULL;
> -}
> -
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
> index 66d8619e02ad..80ce04a5bae5 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -661,20 +661,6 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>   	pmdval = READ_ONCE(*pmd);
>   	if (pmd_none(pmdval))
>   		return no_page_table(vma, flags);
> -	if (pmd_huge(pmdval) && is_vm_hugetlb_page(vma)) {
> -		page = follow_huge_pmd(mm, address, pmd, flags);
> -		if (page)
> -			return page;
> -		return no_page_table(vma, flags);
> -	}
> -	if (is_hugepd(__hugepd(pmd_val(pmdval)))) {
> -		page = follow_huge_pd(vma, address,
> -				      __hugepd(pmd_val(pmdval)), flags,
> -				      PMD_SHIFT);
> -		if (page)
> -			return page;
> -		return no_page_table(vma, flags);
> -	}
>   retry:
>   	if (!pmd_present(pmdval)) {
>   		/*
> @@ -764,20 +750,6 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
>   	pud = pud_offset(p4dp, address);
>   	if (pud_none(*pud))
>   		return no_page_table(vma, flags);
> -	if (pud_huge(*pud) && is_vm_hugetlb_page(vma)) {
> -		page = follow_huge_pud(mm, address, pud, flags);
> -		if (page)
> -			return page;
> -		return no_page_table(vma, flags);
> -	}
> -	if (is_hugepd(__hugepd(pud_val(*pud)))) {
> -		page = follow_huge_pd(vma, address,
> -				      __hugepd(pud_val(*pud)), flags,
> -				      PUD_SHIFT);
> -		if (page)
> -			return page;
> -		return no_page_table(vma, flags);
> -	}
>   	if (pud_devmap(*pud)) {
>   		ptl = pud_lock(mm, pud);
>   		page = follow_devmap_pud(vma, address, pud, flags, &ctx->pgmap);
> @@ -797,7 +769,6 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
>   				    struct follow_page_context *ctx)
>   {
>   	p4d_t *p4d;
> -	struct page *page;
>   
>   	p4d = p4d_offset(pgdp, address);
>   	if (p4d_none(*p4d))
> @@ -806,14 +777,6 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
>   	if (unlikely(p4d_bad(*p4d)))
>   		return no_page_table(vma, flags);
>   
> -	if (is_hugepd(__hugepd(p4d_val(*p4d)))) {
> -		page = follow_huge_pd(vma, address,
> -				      __hugepd(p4d_val(*p4d)), flags,
> -				      P4D_SHIFT);
> -		if (page)
> -			return page;
> -		return no_page_table(vma, flags);
> -	}
>   	return follow_pud_mask(vma, address, p4d, flags, ctx);
>   }
>   
> @@ -851,10 +814,15 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
>   
>   	ctx->page_mask = 0;
>   
> -	/* make this handle hugepd */
> -	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
> -	if (!IS_ERR(page)) {
> -		WARN_ON_ONCE(flags & (FOLL_GET | FOLL_PIN));
> +	/*
> +	 * Call hugetlb_follow_page_mask for hugetlb vmas as it will use
> +	 * special hugetlb page table walking code.  This eliminates the
> +	 * need to check for hugetlb entries in the general walking code.
> +	 */
> +	if (is_vm_hugetlb_page(vma)) {
> +		page = hugetlb_follow_page_mask(vma, address, flags);
> +		if (!page)
> +			page = no_page_table(vma, flags);
>   		return page;
>   	}
>   
> @@ -863,21 +831,6 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
>   	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
>   		return no_page_table(vma, flags);
>   
> -	if (pgd_huge(*pgd)) {
> -		page = follow_huge_pgd(mm, address, pgd, flags);
> -		if (page)
> -			return page;
> -		return no_page_table(vma, flags);
> -	}
> -	if (is_hugepd(__hugepd(pgd_val(*pgd)))) {
> -		page = follow_huge_pd(vma, address,
> -				      __hugepd(pgd_val(*pgd)), flags,
> -				      PGDIR_SHIFT);
> -		if (page)
> -			return page;
> -		return no_page_table(vma, flags);
> -	}
> -
>   	return follow_p4d_mask(vma, address, pgd, flags, ctx);
>   }
>   
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d0617d64d718..b3da421ba5be 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6190,6 +6190,62 @@ static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
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
> +		page = pte_page(entry) +
> +				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> +		/*
> +		 * Note that page may be a sub-page, and with vmemmap
> +		 * optimizations the page struct may be read only.
> +		 * try_grab_page() will increase the ref count on the
> +		 * head page, so this will be OK.
> +		 *
> +		 * try_grab_page() should always succeed here, because we hold
> +		 * the ptl lock and have verified pte_present().
> +		 */
> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
> +			page = NULL;
> +			goto out;
> +		}
> +	} else {
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
> @@ -7140,123 +7196,6 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
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
> -struct page * __weak
> -follow_huge_pd(struct vm_area_struct *vma,
> -	       unsigned long address, hugepd_t hpd, int flags, int pdshift)
> -{
> -	WARN(1, "hugepd follow called with no support for hugepage directory format\n");
> -	return NULL;
> -}
> -
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
