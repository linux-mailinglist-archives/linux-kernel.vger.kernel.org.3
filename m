Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B6D54D5FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244148AbiFPARd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344660AbiFPAR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:17:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029E43F32A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:17:24 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id z14so8709612pgh.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wSmEvwjod79/RP9lUYdq87XgvxgWBT4rqBLlHoWJF/Y=;
        b=m/b5PopkNA+RqYCzLTquiWNjQ+UynFOXWoj+jFYV4B2i12EKUfMLDJGZG36CsGxyCX
         ceQnR/AXTTFx4oJ/NFfxsxJF1BwQheLDAfe9LI/TtYcN1YuovNx8HmCuLNeChs+qCBte
         rFk3TddVHP0rrcqdrQjnMA8NW7eyuPSHz0hxN8U1gymgm/n+J+5NQHMcqSkVVkZM6jbi
         SmnOJ9Fq+cOqlbOvfiUN0jge2+sAXEQI6T+31jBM6C1kOviI3K0z0JMnsqG4UV4lXpJM
         C1mRgmhy5uBKDPQf1JU/p4fbCAChVq8Ve4eRobBr8I3bGySM67anHACo37auYev9fN7F
         qWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wSmEvwjod79/RP9lUYdq87XgvxgWBT4rqBLlHoWJF/Y=;
        b=UCcZ95TLQHA0N8Irhc3N6az0HTpmPgtf9hHuKjIkFe2uSWww39agBoam59HB/3tU5V
         osSnK7/oG+1WeEkpfRTM6cg9tzW5CFiqVqXv9Vdrti60K/ULkEhlOzXSPB6hVDwvUUjw
         hemdRwJoalWssJYP2cyiu34lVklcaaWxWAwpsGrRiDsTz/QGyalb6orqnbfUd2dqXrpN
         UJhXPmNmQVI7Jt+bf/F7F4wEWmolmmbMIXCEb6C18TLIXDOcKGGZg6DNNL1m+k8ftYbO
         6q/GtRVV0DXf1sFgJQ0YHWxsMwGOfEZqKMAk9xILnE+/K+ezW4Jyx531nNHQO/j0dnhw
         NsDA==
X-Gm-Message-State: AJIora/RdYVVE5tApJsj+XO4wlOXm52hJiaRD4FKBzHOucJzsCcslEk3
        Zuf7SCD4Zraeu6/vnOOx4N+CVQ==
X-Google-Smtp-Source: AGRyM1uaCFBSiBDO5r8IywSJVa4aAd3+tDbvSM1PAErWYT15eLlmNZsb7OQrJrd4qR/Yh+FUV8AkcA==
X-Received: by 2002:a65:6499:0:b0:3fc:dcaa:ad62 with SMTP id e25-20020a656499000000b003fcdcaaad62mr2075421pgv.63.1655338644016;
        Wed, 15 Jun 2022 17:17:24 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id c9-20020a63a409000000b003faf4acac63sm191097pgf.13.2022.06.15.17.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:17:23 -0700 (PDT)
Date:   Wed, 15 Jun 2022 17:17:19 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 4/7] mm: thp: kill transparent_hugepage_active()
Message-ID: <Yqp2j6sf7m3wmwou@google.com>
References: <20220615172926.546974-1-shy828301@gmail.com>
 <20220615172926.546974-5-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615172926.546974-5-shy828301@gmail.com>
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
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  fs/proc/task_mmu.c         |  2 +-
>  include/linux/huge_mm.h    | 11 ++++++++-
>  include/linux/khugepaged.h |  2 --
>  mm/huge_memory.c           | 50 +++++++++++++++++++++++++++++++-------
>  mm/khugepaged.c            | 48 +++---------------------------------
>  5 files changed, 56 insertions(+), 57 deletions(-)
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
> index 8a5a8bfce0f5..aeb13119ee28 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -202,7 +202,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
>  	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
>  }
>  
> -bool transparent_hugepage_active(struct vm_area_struct *vma);

Like v3, I think this also needs to be deleted from !CONFIG_TRANSPARENT_HUGEPAGE

Otherwise can add

Reviewed-by: Zach O'Keefe <zokeefe@google.com>

> +bool hugepage_vma_check(struct vm_area_struct *vma,
> +			unsigned long vm_flags,
> +			bool smaps);
>  
>  #define transparent_hugepage_use_zero_page()				\
>  	(transparent_hugepage_flags &					\
> @@ -368,6 +370,13 @@ static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
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
