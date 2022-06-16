Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1D54D6B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349277AbiFPA7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358655AbiFPA6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:58:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B525B3EA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:56:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso4550413pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mps1jo7ZIWOCTV4SZzuomyN/3FDPgNf9FGb45TIE2UQ=;
        b=kwUUpUAwVG2fYbOIIR1KGUTatn1km1vAj8CAe6BEFf3Oa1WLMn2peAPN5hQu5DQ7gJ
         yzMc4gdM9Mw6SnHwc3HO9DPw9sgH6vc1qng9tO0c2ASQhlZXaVTco4Gf+Sb3UP9OXhu8
         BREQItcNjZqtdgiu039Bpqd9PYA/02Mtc105pMbQfs9MtAjUyNFRR6mufp6NBcZYW1sg
         PxveMWCqAcj6eaGmL5r6JORrhffxBIbZucgFtWYgjx2v68rrgfx/Qztzx7Qz3oH2NiY7
         3jzP/YlGD5jI4nPklsHXL7BNT37EhENAdqbW1IFzd9qjFjR30/W/iTwaSUTzYgLBzYwi
         hreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mps1jo7ZIWOCTV4SZzuomyN/3FDPgNf9FGb45TIE2UQ=;
        b=UwtMrO06ogqhJWAnYnHbNDGscwwlKnsUREYcIzdp5KpfUbvSY0wR5M4mrySjuE6mQ/
         wW7euVa6RCaLndRiqMdRce4S8XIbhCxBZikaRXv6pe3ASTgpADHgPQrWCVvpeljoLhxu
         wt82rmjmwoPtrqe7LUlQAHdbm8/NkYWdS/XaJPcXdEwuuafzVvwZAtFXtqgpxJJCNn4P
         LYt/POPu6hmLem+QFdwKppFNh4IcK1NN1TaQPeSE6uSi8benOZ1DpdXe9Hi9LN9V5oj4
         QXHFp4Ds17fOP1U7SO9q9we7/TTMH0AtGNt3whpF2T9pF7p6PsEHdEBXxg/tzXkm5D7X
         Ab4g==
X-Gm-Message-State: AJIora8Nl3KpLheoLg6G4+M2IZB3uY+XTAYttYL7pgOSmRF8kS8ZUQmh
        gz9+9dq8lAC0RVIacWyasj//zw==
X-Google-Smtp-Source: AGRyM1vRgA5WXntWjp26tphYfloqNf0Os4YSWBEo2ZtDOzxZQKXa9svPZWTDsDB0T4nA6Qh4BlF8IA==
X-Received: by 2002:a17:90a:5104:b0:1ea:e86b:6aed with SMTP id t4-20020a17090a510400b001eae86b6aedmr1551984pjh.69.1655341002582;
        Wed, 15 Jun 2022 17:56:42 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id p44-20020a056a0026ec00b00522cae827f6sm235925pfw.197.2022.06.15.17.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:56:41 -0700 (PDT)
Date:   Wed, 15 Jun 2022 17:56:38 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 5/7] mm: thp: kill __transhuge_page_enabled()
Message-ID: <Yqp/xlMN57NHev1h@google.com>
References: <20220615172926.546974-1-shy828301@gmail.com>
 <20220615172926.546974-6-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615172926.546974-6-shy828301@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jun 10:29, Yang Shi wrote:
> The page fault path checks THP eligibility with
> __transhuge_page_enabled() which does the similar thing as
> hugepage_vma_check(), so use hugepage_vma_check() instead.
> 
> However page fault allows DAX and !anon_vma cases, so added a new flag,
> in_pf, to hugepage_vma_check() to make page fault work correctly.
> 
> The in_pf flag is also used to skip shmem and file THP for page fault
> since shmem handles THP in its own shmem_fault() and file THP allocation
> on fault is not supported yet.
> 
> Also remove hugepage_vma_enabled() since hugepage_vma_check() is the
> only caller now, it is not necessary to have a helper function.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  fs/proc/task_mmu.c      |  2 +-
>  include/linux/huge_mm.h | 57 ++---------------------------------------
>  mm/huge_memory.c        | 51 ++++++++++++++++++++++++++++--------
>  mm/khugepaged.c         |  8 +++---
>  mm/memory.c             |  7 +++--
>  5 files changed, 52 insertions(+), 73 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 39a40ec181e7..cef72e49acc5 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -863,7 +863,7 @@ static int show_smap(struct seq_file *m, void *v)
>  	__show_smap(m, &mss, false);
>  
>  	seq_printf(m, "THPeligible:    %d\n",
> -		   hugepage_vma_check(vma, vma->vm_flags, true));
> +		   hugepage_vma_check(vma, vma->vm_flags, true, false));
>  
>  	if (arch_pkeys_enabled())
>  		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index aeb13119ee28..9d97d7ee6234 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -146,48 +146,6 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>  	return true;
>  }
>  
> -static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> -					  unsigned long vm_flags)
> -{
> -	/* Explicitly disabled through madvise. */
> -	if ((vm_flags & VM_NOHUGEPAGE) ||
> -	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> -		return false;
> -	return true;
> -}
> -
> -/*
> - * to be used on vmas which are known to support THP.
> - * Use transparent_hugepage_active otherwise
> - */
> -static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> -{
> -
> -	/*
> -	 * If the hardware/firmware marked hugepage support disabled.
> -	 */
> -	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
> -		return false;
> -
> -	if (!transhuge_vma_enabled(vma, vma->vm_flags))
> -		return false;
> -
> -	if (vma_is_temporary_stack(vma))
> -		return false;
> -
> -	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
> -		return true;
> -
> -	if (vma_is_dax(vma))
> -		return true;
> -
> -	if (transparent_hugepage_flags &
> -				(1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
> -		return !!(vma->vm_flags & VM_HUGEPAGE);
> -
> -	return false;
> -}
> -
>  static inline bool file_thp_enabled(struct vm_area_struct *vma)
>  {
>  	struct inode *inode;
> @@ -204,7 +162,7 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
>  
>  bool hugepage_vma_check(struct vm_area_struct *vma,
>  			unsigned long vm_flags,
> -			bool smaps);
> +			bool smaps, bool in_pf);
>  
>  #define transparent_hugepage_use_zero_page()				\
>  	(transparent_hugepage_flags &					\
> @@ -348,11 +306,6 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
>  	return false;
>  }
>  
> -static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> -{
> -	return false;
> -}
> -
>  static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
>  {
>  	return false;
> @@ -364,15 +317,9 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>  	return false;
>  }
>  
> -static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> -					  unsigned long vm_flags)
> -{
> -	return false;
> -}
> -
>  static inline bool hugepage_vma_check(struct vm_area_struct *vma,
>  				       unsigned long vm_flags,
> -				       bool smaps)
> +				       bool smaps, bool in_pf)
>  {
>  	return false;
>  }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a28c6100b491..d0c37d99917b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -71,24 +71,50 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
>  
>  bool hugepage_vma_check(struct vm_area_struct *vma,
>  			unsigned long vm_flags,
> -			bool smaps)
> +			bool smaps, bool in_pf)
>  {
> -	if (!transhuge_vma_enabled(vma, vm_flags))
> +	/*
> +	 * Explicitly disabled through madvise or prctl, or some
> +	 * architectures may disable THP for some mappings, for
> +	 * example, s390 kvm.
> +	 * */
> +	if ((vm_flags & VM_NOHUGEPAGE) ||
> +	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>  		return false;
> -
> -	if (vm_flags & VM_NO_KHUGEPAGED)
> +	/*
> +	 * If the hardware/firmware marked hugepage support disabled.
> +	 */
> +	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
>  		return false;
>  
> -	/* Don't run khugepaged against DAX vma */
> +	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
>  	if (vma_is_dax(vma))
> +		return in_pf;
> +
> +	/*
> +	 * Special VMA and hugetlb VMA.
> +	 * Must be checked after dax since some dax mappings may have
> +	 * VM_MIXEDMAP set.
> +	 */
> +	if (vm_flags & VM_NO_KHUGEPAGED)
>  		return false;
>  
> -	/* Check alignment for file vma and size for both file and anon vma */
> -	if (!transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
> +	/*
> +	 * Check alignment for file vma and size for both file and anon vma.
> +	 *
> +	 * Skip the check for page fault. Huge fault does the check in fault
> +	 * handlers. And this check is not suitable for huge PUD fault.
> +	 */
> +	if (!in_pf &&
> +	    !transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
>  		return false;

Good catch.

>  
> -	/* Enabled via shmem mount options or sysfs settings. */
> -	if (shmem_file(vma->vm_file))
> +	/*
> +	 * Enabled via shmem mount options or sysfs settings.
> +	 * Must be done before hugepage flags check since shmem has its
> +	 * own flags.
> +	 */
> +	if (!in_pf && shmem_file(vma->vm_file))
>  		return shmem_huge_enabled(vma);
>  
>  	if (!khugepaged_enabled())
> @@ -99,7 +125,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>  		return false;
>  
>  	/* Only regular file is valid */
> -	if (file_thp_enabled(vma))
> +	if (!in_pf && file_thp_enabled(vma))
>  		return true;
>  
>  	if (!vma_is_anonymous(vma))
> @@ -111,9 +137,12 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>  	/*
>  	 * THPeligible bit of smaps should show 1 for proper VMAs even
>  	 * though anon_vma is not initialized yet.
> +	 *
> +	 * Allow page fault since anon_vma may be not initialized until
> +	 * the first page fault.
>  	 */
>  	if (!vma->anon_vma)
> -		return smaps;
> +		return (smaps || in_pf);
>  
>  	return true;
>  }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 3afd87f8c0b1..2a676f37c921 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -473,7 +473,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>  {
>  	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
>  	    khugepaged_enabled()) {
> -		if (hugepage_vma_check(vma, vm_flags, false))
> +		if (hugepage_vma_check(vma, vm_flags, false, false))
>  			__khugepaged_enter(vma->vm_mm);
>  	}
>  }
> @@ -918,7 +918,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  
>  	if (!transhuge_vma_suitable(vma, address))
>  		return SCAN_ADDRESS_RANGE;
> -	if (!hugepage_vma_check(vma, vma->vm_flags, false))
> +	if (!hugepage_vma_check(vma, vma->vm_flags, false, false))
>  		return SCAN_VMA_CHECK;
>  	/*
>  	 * Anon VMA expected, the address may be unmapped then
> @@ -1408,7 +1408,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>  	 * the valid THP. Add extra VM_HUGEPAGE so hugepage_vma_check()
>  	 * will not fail the vma for missing VM_HUGEPAGE
>  	 */
> -	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false))
> +	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false, false))
>  		return;
>  
>  	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
> @@ -2103,7 +2103,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>  			progress++;
>  			break;
>  		}
> -		if (!hugepage_vma_check(vma, vma->vm_flags, false)) {
> +		if (!hugepage_vma_check(vma, vma->vm_flags, false, false)) {
>  skip:
>  			progress++;
>  			continue;
> diff --git a/mm/memory.c b/mm/memory.c
> index be724238a9d3..fee2884481f2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4985,6 +4985,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  		.gfp_mask = __get_fault_gfp_mask(vma),
>  	};
>  	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long vm_flags = vma->vm_flags;
>  	pgd_t *pgd;
>  	p4d_t *p4d;
>  	vm_fault_t ret;
> @@ -4998,7 +4999,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  	if (!vmf.pud)
>  		return VM_FAULT_OOM;
>  retry_pud:
> -	if (pud_none(*vmf.pud) && __transparent_hugepage_enabled(vma)) {
> +	if (pud_none(*vmf.pud) &&
> +	    hugepage_vma_check(vma, vm_flags, false, true)) {
>  		ret = create_huge_pud(&vmf);
>  		if (!(ret & VM_FAULT_FALLBACK))
>  			return ret;
> @@ -5031,7 +5033,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  	if (pud_trans_unstable(vmf.pud))
>  		goto retry_pud;
>  
> -	if (pmd_none(*vmf.pmd) && __transparent_hugepage_enabled(vma)) {
> +	if (pmd_none(*vmf.pmd) &&
> +	    hugepage_vma_check(vma, vm_flags, false, true)) {
>  		ret = create_huge_pmd(&vmf);
>  		if (!(ret & VM_FAULT_FALLBACK))
>  			return ret;
> -- 
> 2.26.3
> 

Thanks for the updates / improvements!

Reviewed-by: Zach O'Keefe
