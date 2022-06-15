Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4370F54D592
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349921AbiFOXzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbiFOXzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:55:06 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AAD3EAB4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:55:05 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c196so24782pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iZy6zswn556RsJBMyXBXEcR40T62MxCZjeLRIYiXVfU=;
        b=jH55tVltomA7iDyU1ioitgG5CxIg3lPzI7PK6EqTjy5JQfT7K9Atd53eioU/8QNove
         YJODA5KhTYwHPgzIMQtKN0oHDw/PiuJrjDsT2kBUW2HVCWNPYavr1yIYq6eaQ1bkUIvK
         csUxTPcghji1ixH1a8afFUi2kxPCLb7bm7KsIq242i5+vsDJ4Fzxu/mpnpYTFShS737h
         MUvB5Kgjda6rg5pMKC8ux5vJd4yFfd2/3OjBu6ny3xU5TNXuXUwALhYprgU+2Vvk/p9p
         YngY0f9gG56OZmS0Xgw5w9RqRBcD7BGCqRDQoyo64Tx2ntYfLwLeYngXu3Qcs71vpw4m
         HZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iZy6zswn556RsJBMyXBXEcR40T62MxCZjeLRIYiXVfU=;
        b=7MAB854r838P/yGAI6kKIfGExptnx/ggKqrVmucnTmqOl6Gc4/fa+u2dMkcjurgkcc
         kz/5Ia0E67PDTdxqKBN1Q5/bC+iTxi0Ff6C+H7/35kYQBtOVyLlH6zBf1EqlvwbEljz8
         Fe/e8F0lMV5RsN4jG2Jz1+wVcTq3MjG+paLz+2aQvJIutIRUNLKk20rMo5m0vA4DRndG
         NgN7lNJKypOZuH1ndRKA0V2xaj77d7e6fDjGdSftDpozI/dR6NWtNTof52iGxneOFt/C
         qd723H0Pf1zv9jYdXwnum7+7M5WNNCOJGJWbi89a4LPyk5KLVJtsY3oxYs01ObgPXQPo
         XFRw==
X-Gm-Message-State: AJIora+myfmjVkE8hocXdG9hO2Z6woi0r3PE8XwWYXqhVBcGyKpca8SD
        xU1LSZOmkBSQbXVwG7AKA5yYdyw+zmWd3B22
X-Google-Smtp-Source: AGRyM1vxhF7S4iI7ic1v0EdPjwuZegM6Opo/IK96iSwpgmFg1VgLhQoIzWp+be28t669f4oJSb8Ofg==
X-Received: by 2002:a63:242:0:b0:401:b84a:6008 with SMTP id 63-20020a630242000000b00401b84a6008mr2004972pgc.100.1655337304620;
        Wed, 15 Jun 2022 16:55:04 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id bk7-20020a17090b080700b001e30a16c609sm158839pjb.21.2022.06.15.16.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:55:03 -0700 (PDT)
Date:   Wed, 15 Jun 2022 16:55:00 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 2/7] mm: thp: consolidate vma size check to
 transhuge_vma_suitable
Message-ID: <YqpxVAgLdDy34GEj@google.com>
References: <20220615172926.546974-1-shy828301@gmail.com>
 <20220615172926.546974-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615172926.546974-3-shy828301@gmail.com>
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
> There are couple of places that check whether the vma size is ok for
> THP or whether address fits, they are open coded and duplicate, use
> transhuge_vma_suitable() to do the job by passing in (vma->end -
> HPAGE_PMD_SIZE).
> 
> Move vma size check into hugepage_vma_check().  This will make
> khugepaged_enter() is as same as khugepaged_enter_vma().  There is just
> one caller for khugepaged_enter(), replace it to khugepaged_enter_vma()
> and remove khugepaged_enter().
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/huge_mm.h    | 11 +++++++++++
>  include/linux/khugepaged.h | 14 --------------
>  mm/huge_memory.c           |  2 +-
>  mm/khugepaged.c            | 19 ++++++-------------
>  4 files changed, 18 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 648cb3ce7099..8a5a8bfce0f5 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -116,6 +116,17 @@ extern struct kobj_attribute shmem_enabled_attr;
>  
>  extern unsigned long transparent_hugepage_flags;
>  
> +/*
> + * Do the below checks:
> + *   - For file vma, check if the linear page offset of vma is
> + *     HPAGE_PMD_NR aligned within the file.  The hugepage is
> + *     guaranteed to be hugepage-aligned within the file, but we must
> + *     check that the PMD-aligned addresses in the VMA map to
> + *     PMD-aligned offsets within the file, else the hugepage will
> + *     not be PMD-mappable.
> + *   - For all vmas, check if the haddr is in an aligned HPAGE_PMD_SIZE
> + *     area.
> + */
>  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>  		unsigned long addr)
>  {
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index 392d34c3c59a..31ca8a7f78f4 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -51,16 +51,6 @@ static inline void khugepaged_exit(struct mm_struct *mm)
>  	if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
>  		__khugepaged_exit(mm);
>  }
> -
> -static inline void khugepaged_enter(struct vm_area_struct *vma,
> -				   unsigned long vm_flags)
> -{
> -	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> -	    khugepaged_enabled()) {
> -		if (hugepage_vma_check(vma, vm_flags))
> -			__khugepaged_enter(vma->vm_mm);
> -	}
> -}
>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
> @@ -68,10 +58,6 @@ static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm
>  static inline void khugepaged_exit(struct mm_struct *mm)
>  {
>  }
> -static inline void khugepaged_enter(struct vm_area_struct *vma,
> -				    unsigned long vm_flags)
> -{
> -}
>  static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
>  					unsigned long vm_flags)
>  {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4f9bbb4eab23..b530462c4493 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -726,7 +726,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>  		return VM_FAULT_FALLBACK;
>  	if (unlikely(anon_vma_prepare(vma)))
>  		return VM_FAULT_OOM;
> -	khugepaged_enter(vma, vma->vm_flags);
> +	khugepaged_enter_vma(vma, vma->vm_flags);
>  
>  	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
>  			!mm_forbids_zeropage(vma->vm_mm) &&
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b1dab94c0f1e..db0b334a7d1f 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -450,8 +450,8 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>  	if (vma_is_dax(vma))
>  		return false;
>  
> -	if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
> -				vma->vm_pgoff, HPAGE_PMD_NR))
> +	/* Check alignment for file vma and size for both file and anon vma */
> +	if (!transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
>  		return false;
>  
>  	/* Enabled via shmem mount options or sysfs settings. */
> @@ -512,9 +512,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>  			  unsigned long vm_flags)
>  {
>  	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> -	    khugepaged_enabled() &&
> -	    (((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
> -	     (vma->vm_end & HPAGE_PMD_MASK))) {
> +	    khugepaged_enabled()) {
>  		if (hugepage_vma_check(vma, vm_flags))
>  			__khugepaged_enter(vma->vm_mm);
>  	}
> @@ -950,7 +948,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  		struct vm_area_struct **vmap)
>  {
>  	struct vm_area_struct *vma;
> -	unsigned long hstart, hend;
>  
>  	if (unlikely(khugepaged_test_exit(mm)))
>  		return SCAN_ANY_PROCESS;
> @@ -959,9 +956,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  	if (!vma)
>  		return SCAN_VMA_NULL;
>  
> -	hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> -	hend = vma->vm_end & HPAGE_PMD_MASK;
> -	if (address < hstart || address + HPAGE_PMD_SIZE > hend)
> +	if (!transhuge_vma_suitable(vma, address))
>  		return SCAN_ADDRESS_RANGE;
>  	if (!hugepage_vma_check(vma, vma->vm_flags))
>  		return SCAN_VMA_CHECK;
> @@ -2147,10 +2142,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>  			progress++;
>  			continue;
>  		}
> -		hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> -		hend = vma->vm_end & HPAGE_PMD_MASK;
> -		if (hstart >= hend)
> -			goto skip;
> +		hstart = round_up(vma->vm_start, HPAGE_PMD_SIZE);
> +		hend = round_down(vma->vm_end, HPAGE_PMD_SIZE);
>  		if (khugepaged_scan.address > hend)
>  			goto skip;
>  		if (khugepaged_scan.address < hstart)
> -- 
> 2.26.3
> 

Thanks for the patches, Yang.

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
