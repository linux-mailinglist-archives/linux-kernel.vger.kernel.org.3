Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9F5538596
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbiE3P44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbiE3PzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:55:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A353121B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:36:52 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i18so10842511pfk.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WWbn7EZI+ZfA1nS/AHKnyXPK2aRQ/fZAZ6wQKoRMdpc=;
        b=XQ1xT1dLseQvQ8a1kwNSiOBoWYJZKnwzjCvxN+MbdoO5fE372ROFc/lqlmply44nFC
         avWAhtJHDkH/hKW/RQJzHvyhfBHO4D5yR1sV7/CMSRCxA9cSWh2oB8FROicaorhXcIGf
         eiqinzoyPwI6jx9NYzwWFR6TdboS/Ce07AvourWIR6LDlrdM/m0v62O+usUa0XQud0/W
         1x/JA1FSviSiRB11bHBU445WWiEYJVjR6d/vAB43cCdGJWEMvCNkPwU8E5qDnEhM7FaY
         v5iGph+62ORqqF97GpEC6banPu4TJeN/Y5bCLApkb1Du9Aw+P4GTmR0xpdXw0aU49cAr
         KQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WWbn7EZI+ZfA1nS/AHKnyXPK2aRQ/fZAZ6wQKoRMdpc=;
        b=picHRUfUz9t/50pH1wKsuOLE71BjpJ9esdM5o9f+UKBcyiTnvHmJ76MaQMo7FaZdkN
         Ozm+ushPaHeVXBqzC8qRsKgl2YbOy5z6W/HZfgHdRkCZjilUk6GThZ7WmpYlg+RrJYAe
         7T8UWhcxWKtaDmEakkdXaq0gGR5pYAikzZzAo+CHleWLvD7ZhHRPw6OxBrdLe2sy70GV
         Q1Pov2VdGk0lHOKLVIBy0K3lgA8ge0euLmFGpLYRmfZhVmAcmtxb6eqdpIeRDmRqX0W4
         ZWLnI9ZFXtZO4iVv4E7Pud2XMBgLKpqE0G5NgpTnrB4ynDy7TLqlBCZNDDN7RDEV6ueG
         i3Xw==
X-Gm-Message-State: AOAM532dGEkOpci2gyyz/44XI+W/PUYdZZXzLlzql5ysbwLG7tGC6Sj5
        kLfKzbljDM3Dv48utGg+JTU2zw==
X-Google-Smtp-Source: ABdhPJyt+kChVq69cTd4d5ZYxvL1e82CvbT3ct3GVrYlR8RPkvYjqM/kyduXzhDb2iGTWIyFusP8dg==
X-Received: by 2002:a63:e443:0:b0:3f5:e5b3:437f with SMTP id i3-20020a63e443000000b003f5e5b3437fmr48914294pgk.423.1653925011956;
        Mon, 30 May 2022 08:36:51 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:2071:e13a:8aa:cacf])
        by smtp.gmail.com with ESMTPSA id g20-20020aa78754000000b00517c84fd24asm9239353pfo.172.2022.05.30.08.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 08:36:51 -0700 (PDT)
Date:   Mon, 30 May 2022 23:36:43 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/3] hugetlb: do not update address in
 huge_pmd_unshare
Message-ID: <YpTki4Tvv2muTeJu@FVFYT0MHHV2J.googleapis.com>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527225849.284839-3-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 03:58:48PM -0700, Mike Kravetz wrote:
> As an optimization for loops sequentially processing hugetlb address
> ranges, huge_pmd_unshare would update a passed address if it unshared a
> pmd.  Updating a loop control variable outside the loop like this is
> generally a bad idea.  These loops are now using hugetlb_mask_last_hp

Totally agree.

> to optimize scanning when non-present ptes are discovered.  The same
> can be done when huge_pmd_unshare returns 1 indicating a pmd was
> unshared.
> 
> Remove address update from huge_pmd_unshare.  Change the passed argument
> type and update all callers.  In loops sequentially processing addresses
> use hugetlb_mask_last_hp to update address if pmd is unshared.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Some nits below.

> ---
>  include/linux/hugetlb.h |  4 ++--
>  mm/hugetlb.c            | 46 ++++++++++++++++++-----------------------
>  mm/rmap.c               |  4 ++--
>  3 files changed, 24 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 25078a0ea1d8..307c8f6e6752 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -196,7 +196,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>  		       unsigned long addr, unsigned long sz);
>  unsigned long hugetlb_mask_last_hp(struct hstate *h);
>  int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> -				unsigned long *addr, pte_t *ptep);
> +				unsigned long addr, pte_t *ptep);
>  void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  				unsigned long *start, unsigned long *end);
>  struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
> @@ -243,7 +243,7 @@ static inline struct address_space *hugetlb_page_mapping_lock_write(
>  
>  static inline int huge_pmd_unshare(struct mm_struct *mm,
>  					struct vm_area_struct *vma,
> -					unsigned long *addr, pte_t *ptep)
> +					unsigned long addr, pte_t *ptep)
>  {
>  	return 0;
>  }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a2db878b2255..c7d3fbf3ec05 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4940,7 +4940,6 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  	struct mm_struct *mm = vma->vm_mm;
>  	unsigned long old_end = old_addr + len;
>  	unsigned long last_addr_mask;
> -	unsigned long old_addr_copy;
>  	pte_t *src_pte, *dst_pte;
>  	struct mmu_notifier_range range;
>  	bool shared_pmd = false;
> @@ -4968,14 +4967,10 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  		if (huge_pte_none(huge_ptep_get(src_pte)))
>  			continue;
>  
> -		/* old_addr arg to huge_pmd_unshare() is a pointer and so the
> -		 * arg may be modified. Pass a copy instead to preserve the
> -		 * value in old_addr.
> -		 */
> -		old_addr_copy = old_addr;
> -
> -		if (huge_pmd_unshare(mm, vma, &old_addr_copy, src_pte)) {
> +		if (huge_pmd_unshare(mm, vma, old_addr, src_pte)) {
>  			shared_pmd = true;
> +			old_addr |= last_addr_mask;
> +			new_addr |= last_addr_mask;
>  			continue;
>  		}
>  
> @@ -5040,10 +5035,11 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
>  		}
>  
>  		ptl = huge_pte_lock(h, mm, ptep);
> -		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
> +		if (huge_pmd_unshare(mm, vma, address, ptep)) {
>  			spin_unlock(ptl);
>  			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
>  			force_flush = true;
> +			address |= last_addr_mask;
>  			continue;
>  		}
>  
> @@ -6327,7 +6323,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>  			continue;
>  		}
>  		ptl = huge_pte_lock(h, mm, ptep);
> -		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
> +		if (huge_pmd_unshare(mm, vma, address, ptep)) {
>  			/*
>  			 * When uffd-wp is enabled on the vma, unshare
>  			 * shouldn't happen at all.  Warn about it if it
> @@ -6337,6 +6333,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>  			pages++;
>  			spin_unlock(ptl);
>  			shared_pmd = true;
> +			address |= last_addr_mask;
>  			continue;
>  		}
>  		pte = huge_ptep_get(ptep);
> @@ -6760,11 +6757,11 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>   *	    0 the underlying pte page is not shared, or it is the last user
>   */
>  int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> -					unsigned long *addr, pte_t *ptep)
> +					unsigned long addr, pte_t *ptep)
>  {
> -	pgd_t *pgd = pgd_offset(mm, *addr);
> -	p4d_t *p4d = p4d_offset(pgd, *addr);
> -	pud_t *pud = pud_offset(p4d, *addr);
> +	pgd_t *pgd = pgd_offset(mm, addr);
> +	p4d_t *p4d = p4d_offset(pgd, addr);
> +	pud_t *pud = pud_offset(p4d, addr);
>  
>  	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
>  	BUG_ON(page_count(virt_to_page(ptep)) == 0);
> @@ -6774,14 +6771,6 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  	pud_clear(pud);
>  	put_page(virt_to_page(ptep));
>  	mm_dec_nr_pmds(mm);
> -	/*
> -	 * This update of passed address optimizes loops sequentially
> -	 * processing addresses in increments of huge page size (PMD_SIZE
> -	 * in this case).  By clearing the pud, a PUD_SIZE area is unmapped.
> -	 * Update address to the 'last page' in the cleared area so that
> -	 * calling loop can move to first page past this area.
> -	 */
> -	*addr |= PUD_SIZE - PMD_SIZE;
>  	return 1;
>  }
>  
> @@ -6793,7 +6782,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  }
>  
>  int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> -				unsigned long *addr, pte_t *ptep)
> +				unsigned long addr, pte_t *ptep)
>  {
>  	return 0;
>  }
> @@ -6902,6 +6891,13 @@ unsigned long hugetlb_mask_last_hp(struct hstate *h)
>  /* See description above.  Architectures can provide their own version. */
>  __weak unsigned long hugetlb_mask_last_hp(struct hstate *h)
>  {
> +	unsigned long hp_size = huge_page_size(h);
> +
> +#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
> +	if (hp_size == PMD_SIZE)	/* required for pmd sharing */
> +		return PUD_SIZE - PMD_SIZE;
> +#endif
> +
>  	return ~(0);

Should be ~0UL (However, this should belong to the previous patch).

>  }
>  
> @@ -7128,14 +7124,12 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
>  	mmu_notifier_invalidate_range_start(&range);
>  	i_mmap_lock_write(vma->vm_file->f_mapping);
>  	for (address = start; address < end; address += PUD_SIZE) {
> -		unsigned long tmp = address;
> -
>  		ptep = huge_pte_offset(mm, address, sz);
>  		if (!ptep)
>  			continue;
>  		ptl = huge_pte_lock(h, mm, ptep);
>  		/* We don't want 'address' to be changed */

Dead comment, should be removed.

> -		huge_pmd_unshare(mm, vma, &tmp, ptep);
> +		huge_pmd_unshare(mm, vma, address, ptep);
>  		spin_unlock(ptl);
>  	}
>  	flush_hugetlb_tlb_range(vma, start, end);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 5bcb334cd6f2..45b04e2e83ab 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1559,7 +1559,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  				 */
>  				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>  
> -				if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
> +				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
>  					flush_tlb_range(vma, range.start, range.end);
>  					mmu_notifier_invalidate_range(mm, range.start,
>  								      range.end);
> @@ -1923,7 +1923,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  				 */
>  				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>  
> -				if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
> +				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
>  					flush_tlb_range(vma, range.start, range.end);
>  					mmu_notifier_invalidate_range(mm, range.start,
>  								      range.end);
> -- 
> 2.35.3
> 
> 
