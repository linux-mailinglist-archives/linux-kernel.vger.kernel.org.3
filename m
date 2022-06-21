Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE6F5539E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351510AbiFUS6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiFUS6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:58:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45EBEBA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:58:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 128so6912412pfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=42vsJg2fPvcjlY+3cTeVot4f6HOKgMA3yaicXV9Nn9g=;
        b=lRmo2M0V3X+srp+q8k3qHV7v8tnvG2gYUSUyDyTFXlg4pbFtrIbS5376EUqxDEfa5U
         qTGbKVYBt2cFmsC5AMtMcMTOLr3qGurROGwU6yY3xc0kDOpxHMYhux837IG3codlUihw
         YregjUU12tV+lYdY287rJmGZRmJPyWAWSGhjh0u4Bvna/3Gl8b4awozZNUcaIVvqvTWw
         uzacSvuPniXeuyRGXhxM6FBMihrtgtktl7MBsnq50xpihZHBD4gdtwzbkqbfXV75kvZp
         Upgr5HSfJXhp0+uU+sl2hrlPhIwgiK7SP7RSUqfauw470lHVb03uf5xi1x8ttFx9b9hd
         KDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=42vsJg2fPvcjlY+3cTeVot4f6HOKgMA3yaicXV9Nn9g=;
        b=4kJrdfmV4bvlhYdyBiEYG+mj5qOE+RmEF71d7dqWay5wrEEg08S8AQ2fFptKy8EtfU
         A2xC39i6//sPt7Pc01UzdSCY66M89X4A16AxoWwkDN3XvEw/yWoiCqqFA2ktK95GVcfR
         aqm7rpi07e64zZtwTQkgC2gagvM/UFrUGlgLCMSx1mcdzS0GsogK033We16eUJFmy8GY
         HfnQ2m3nQfpX731TtPJty7e/EftNn4GJ7Fm/+g3/Uku0XjetuSZWCBsmvBw9Qp+edYKL
         WOejkMrI+ZdmeKVy/FOKAdPrtBmUrlkR2OpQo9D6CTEk576spaPMf958lwTbfj+BVPaM
         phAQ==
X-Gm-Message-State: AJIora9yVUgg1lRxHdz9SMw9Y0tzPm14l8Jcuy6gC4KHYM+lVPurEqGV
        dwVWTX9XqcZbb+eFXHLcTiGJzg==
X-Google-Smtp-Source: AGRyM1tfUIGHG8qYUiIPVrO7RNjl0RDSnZYt3eQ1Z5gR6nlXeI5UqLs3c0i49v7UZF2etkKHkUxZmA==
X-Received: by 2002:a05:6a00:893:b0:51e:77ab:8874 with SMTP id q19-20020a056a00089300b0051e77ab8874mr31091513pfj.21.1655837918759;
        Tue, 21 Jun 2022 11:58:38 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id w4-20020a63b744000000b003fd4831e6fesm11324352pgt.70.2022.06.21.11.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 11:58:37 -0700 (PDT)
Date:   Tue, 21 Jun 2022 11:58:34 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH 4/7] mm: thp: kill transparent_hugepage_active()
Message-ID: <YrIU2iP0H5LQbV7R@google.com>
References: <20220616174840.1202070-1-shy828301@gmail.com>
 <20220616174840.1202070-5-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616174840.1202070-5-shy828301@gmail.com>
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

On 16 Jun 10:48, Yang Shi wrote:
> The transparent_hugepage_active() was introduced to show THP eligibility
> bit in smaps in proc, smaps is the only user.  But it actually does the
> similar check as hugepage_vma_check() which is used by khugepaged.  We
> definitely don't have to maintain two similar checks, so kill
> transparent_hugepage_active().
> 
> This patch also fixed the wrong behavior for VM_NO_KHUGEPAGED vmas.
> 
> Also move hugepage_vma_check() to huge_memory.c and huge_mm.h since it
> is not only for khugepaged anymore.
> 
> Reviewed-by: Zach O'Keefe <zokeefe@google.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  fs/proc/task_mmu.c         |  2 +-
>  include/linux/huge_mm.h    | 16 +++++++-----
>  include/linux/khugepaged.h |  2 --
>  mm/huge_memory.c           | 50 +++++++++++++++++++++++++++++++-------
>  mm/khugepaged.c            | 48 +++---------------------------------
>  5 files changed, 56 insertions(+), 62 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 37ccb5c9f4f8..39a40ec181e7 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -863,7 +863,7 @@ static int show_smap(struct seq_file *m, void *v)
>  	__show_smap(m, &mss, false);
>  
>  	seq_printf(m, "THPeligible:    %d\n",
> -		   transparent_hugepage_active(vma));
> +		   hugepage_vma_check(vma, vma->vm_flags, true));
>  
>  	if (arch_pkeys_enabled())
>  		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 8a5a8bfce0f5..64487bcd0c7b 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -202,7 +202,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
>  	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
>  }
>  
> -bool transparent_hugepage_active(struct vm_area_struct *vma);
> +bool hugepage_vma_check(struct vm_area_struct *vma,
> +			unsigned long vm_flags,
> +			bool smaps);
>  
>  #define transparent_hugepage_use_zero_page()				\
>  	(transparent_hugepage_flags &					\
> @@ -351,11 +353,6 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>  	return false;
>  }
>  
> -static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
> -{
> -	return false;
> -}
> -
>  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>  		unsigned long addr)
>  {
> @@ -368,6 +365,13 @@ static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
>  	return false;
>  }
>  
> +static inline bool hugepage_vma_check(struct vm_area_struct *vma,
> +				       unsigned long vm_flags,
> +				       bool smaps)
> +{
> +	return false;
> +}
> +
>  static inline void prep_transhuge_page(struct page *page) {}
>  
>  #define transparent_hugepage_flags 0UL
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index 31ca8a7f78f4..ea5fd4c398f7 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -10,8 +10,6 @@ extern struct attribute_group khugepaged_attr_group;
>  extern int khugepaged_init(void);
>  extern void khugepaged_destroy(void);
>  extern int start_stop_khugepaged(void);
> -extern bool hugepage_vma_check(struct vm_area_struct *vma,
> -			       unsigned long vm_flags);
>  extern void __khugepaged_enter(struct mm_struct *mm);
>  extern void __khugepaged_exit(struct mm_struct *mm);
>  extern void khugepaged_enter_vma(struct vm_area_struct *vma,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b530462c4493..a28c6100b491 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -69,21 +69,53 @@ static atomic_t huge_zero_refcount;
>  struct page *huge_zero_page __read_mostly;
>  unsigned long huge_zero_pfn __read_mostly = ~0UL;
>  
> -bool transparent_hugepage_active(struct vm_area_struct *vma)
> +bool hugepage_vma_check(struct vm_area_struct *vma,
> +			unsigned long vm_flags,
> +			bool smaps)
>  {
> -	/* The addr is used to check if the vma size fits */
> -	unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> +	if (!transhuge_vma_enabled(vma, vm_flags))
> +		return false;
> +

During testing my work on top this patch, I found a small bug here.

Namely, transhuge_vma_enabled() will check vma->vm_mm->flags (to see if
MMF_DISABLE_THP is set); however, for vDSO vmas, vma->vm_mm is NULL.

Previously, transparent_hugepage_active() in smaps path would check
transhuge_vma_suitable() before checking these flags, which would fail for vDSO
vma since we'd take the !vma_is_anonymous() branch and find the vma (most
likely) wasn't suitably aligned (by chance ?).

Anyways, I think we need to check vma->vm_mm.

> +	if (vm_flags & VM_NO_KHUGEPAGED)
> +		return false;
> +
> +	/* Don't run khugepaged against DAX vma */
> +	if (vma_is_dax(vma))
> +		return false;
>  
> -	if (!transhuge_vma_suitable(vma, addr))
> +	/* Check alignment for file vma and size for both file and anon vma */
> +	if (!transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
>  		return false;
> -	if (vma_is_anonymous(vma))
> -		return __transparent_hugepage_enabled(vma);
> -	if (vma_is_shmem(vma))
> +
> +	/* Enabled via shmem mount options or sysfs settings. */
> +	if (shmem_file(vma->vm_file))
>  		return shmem_huge_enabled(vma);
> -	if (transhuge_vma_enabled(vma, vma->vm_flags) && file_thp_enabled(vma))
> +
> +	if (!khugepaged_enabled())
> +		return false;
> +
> +	/* THP settings require madvise. */
> +	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
> +		return false;
> +
> +	/* Only regular file is valid */
> +	if (file_thp_enabled(vma))
>  		return true;
>  
> -	return false;
> +	if (!vma_is_anonymous(vma))
> +		return false;
> +
> +	if (vma_is_temporary_stack(vma))
> +		return false;
> +
> +	/*
> +	 * THPeligible bit of smaps should show 1 for proper VMAs even
> +	 * though anon_vma is not initialized yet.
> +	 */
> +	if (!vma->anon_vma)
> +		return smaps;
> +
> +	return true;
>  }
>  
>  static bool get_huge_zero_page(void)
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 5baa394e34c8..3afd87f8c0b1 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -437,46 +437,6 @@ static inline int khugepaged_test_exit(struct mm_struct *mm)
>  	return atomic_read(&mm->mm_users) == 0;
>  }
>  
> -bool hugepage_vma_check(struct vm_area_struct *vma,
> -			unsigned long vm_flags)
> -{
> -	if (!transhuge_vma_enabled(vma, vm_flags))
> -		return false;
> -
> -	if (vm_flags & VM_NO_KHUGEPAGED)
> -		return false;
> -
> -	/* Don't run khugepaged against DAX vma */
> -	if (vma_is_dax(vma))
> -		return false;
> -
> -	/* Check alignment for file vma and size for both file and anon vma */
> -	if (!transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
> -		return false;
> -
> -	/* Enabled via shmem mount options or sysfs settings. */
> -	if (shmem_file(vma->vm_file))
> -		return shmem_huge_enabled(vma);
> -
> -	if (!khugepaged_enabled())
> -		return false;
> -
> -	/* THP settings require madvise. */
> -	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
> -		return false;
> -
> -	/* Only regular file is valid */
> -	if (file_thp_enabled(vma))
> -		return true;
> -
> -	if (!vma->anon_vma || !vma_is_anonymous(vma))
> -		return false;
> -	if (vma_is_temporary_stack(vma))
> -		return false;
> -
> -	return true;
> -}
> -
>  void __khugepaged_enter(struct mm_struct *mm)
>  {
>  	struct mm_slot *mm_slot;
> @@ -513,7 +473,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>  {
>  	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
>  	    khugepaged_enabled()) {
> -		if (hugepage_vma_check(vma, vm_flags))
> +		if (hugepage_vma_check(vma, vm_flags, false))
>  			__khugepaged_enter(vma->vm_mm);
>  	}
>  }
> @@ -958,7 +918,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  
>  	if (!transhuge_vma_suitable(vma, address))
>  		return SCAN_ADDRESS_RANGE;
> -	if (!hugepage_vma_check(vma, vma->vm_flags))
> +	if (!hugepage_vma_check(vma, vma->vm_flags, false))
>  		return SCAN_VMA_CHECK;
>  	/*
>  	 * Anon VMA expected, the address may be unmapped then
> @@ -1448,7 +1408,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>  	 * the valid THP. Add extra VM_HUGEPAGE so hugepage_vma_check()
>  	 * will not fail the vma for missing VM_HUGEPAGE
>  	 */
> -	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE))
> +	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false))
>  		return;
>  
>  	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
> @@ -2143,7 +2103,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>  			progress++;
>  			break;
>  		}
> -		if (!hugepage_vma_check(vma, vma->vm_flags)) {
> +		if (!hugepage_vma_check(vma, vma->vm_flags, false)) {
>  skip:
>  			progress++;
>  			continue;
> -- 
> 2.26.3
> 
