Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00157545A05
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 04:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242684AbiFJCW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 22:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiFJCW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:22:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1653B23CCCF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 19:22:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i29so23960928lfp.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 19:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzFaFVUQcmct6X9pnbWhTtO5DLYxsZ1gYvl/sLjTEfg=;
        b=WDVgJysrkzANo5PiUDJaF0eHn2NmBJ2ivAgC73+R4bR+YXdVXmfLGVfN+t2gd0DqTm
         u8LJdTH5+m4LFR5YX1yeoPzxvT7Lpuiy67YSNedSDRXgKwQ9jBAbWiHm2MXIRMQA9nlp
         vUABxp2mAE0XkTY11/tmEo61kTT1Ys5ecvpSFk0k22w/aPvFUXzMxyNr7/NOQmLiSlFF
         KeDgbgi6uRJAadYo0PMtQAzphyXmIaOT8UA4jCvDfzXqlp0oJsuDRX16vmXEs01FjByC
         /YEBRTPKIdgcPhpJGN1r6MY7IrVJt1EphCjj6EkbQHM+V1ce0+PMWJvrHKpvl89HI9MW
         12Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzFaFVUQcmct6X9pnbWhTtO5DLYxsZ1gYvl/sLjTEfg=;
        b=T45PLQYrMdsM/NmMTSaW0CL6bgoCktWbwUIy8kGFa3+MCH8t3jvVAhrcAAiLYmL2qB
         aZiv3sFPHo1HYSg45Bt4uC3HDRR2opuz2Op01LdhJIEpLEpWn6p+l/eAAyxM0F8HyzTV
         7pCr3+PlqDFZTKaYpqV+bU/Y+2f1hh+k1+1G7bQKwCiH3I68TqSFAss0CML8tWDONTkl
         meyZEQ129O+t4lV3HHMot/n2wCCNNOcUI5Rku7wpgCqtgHz6lXC7nxDdXrWCj2py7QgP
         8hKNI6jI6iYCtG6gj05d34cMbzQaVcRnTNq8YnYhaJmQd1TbmBgT0cKBuRtPp5XVawDZ
         JFYw==
X-Gm-Message-State: AOAM5300bYdiLbmPFxQOAolnXljL6L7daSim/ybhjCiL2LllhI7Xq2IM
        f1BtzKewgSiFPEBqKAhiUPrWxFUpDLRr10aXRmFKOA==
X-Google-Smtp-Source: ABdhPJzEoUqpwtPtlHGcyA98wQQSKDW61s61Qv8hEmDa9lV7PI7aie0PYiS4nI5LF494UoRzpMiXHeCC1a6x7GPMEoA=
X-Received: by 2002:a05:6512:68e:b0:47d:ae64:fcf4 with SMTP id
 t14-20020a056512068e00b0047dae64fcf4mr1050817lfe.685.1654827772294; Thu, 09
 Jun 2022 19:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-7-shy828301@gmail.com>
In-Reply-To: <20220606214414.736109-7-shy828301@gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 9 Jun 2022 19:22:16 -0700
Message-ID: <CAAa6QmQ4DaFo9RFXRBZnvq=JbQcVOW9P2njCNXU_pjTxcg=3Sg@mail.gmail.com>
Subject: Re: [v3 PATCH 6/7] mm: thp: kill __transhuge_page_enabled()
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
>
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
>  fs/proc/task_mmu.c         |  2 +-
>  include/linux/huge_mm.h    | 57 ++------------------------------------
>  include/linux/khugepaged.h |  2 +-
>  mm/huge_memory.c           | 25 ++++++++++++-----
>  mm/khugepaged.c            |  8 +++---
>  mm/memory.c                |  7 +++--
>  6 files changed, 31 insertions(+), 70 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index fd79566e204c..a0850303baec 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -860,7 +860,7 @@ static int show_smap(struct seq_file *m, void *v)
>         __show_smap(m, &mss, false);
>
>         seq_printf(m, "THPeligible:    %d\n",
> -                  hugepage_vma_check(vma, vma->vm_flags, true));
> +                  hugepage_vma_check(vma, vma->vm_flags, true, false));
>
>         if (arch_pkeys_enabled())
>                 seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f561c3e16def..d478e8875023 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -153,48 +153,6 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>         return true;
>  }
>
> -static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> -                                         unsigned long vm_flags)
> -{
> -       /* Explicitly disabled through madvise. */
> -       if ((vm_flags & VM_NOHUGEPAGE) ||
> -           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> -               return false;
> -       return true;
> -}
> -
> -/*
> - * to be used on vmas which are known to support THP.
> - * Use transparent_hugepage_active otherwise
> - */
> -static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> -{
> -
> -       /*
> -        * If the hardware/firmware marked hugepage support disabled.
> -        */
> -       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
> -               return false;
> -
> -       if (!transhuge_vma_enabled(vma, vma->vm_flags))
> -               return false;
> -
> -       if (vma_is_temporary_stack(vma))
> -               return false;
> -
> -       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
> -               return true;
> -
> -       if (vma_is_dax(vma))
> -               return true;
> -
> -       if (transparent_hugepage_flags &
> -                               (1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
> -               return !!(vma->vm_flags & VM_HUGEPAGE);
> -
> -       return false;
> -}
> -
>  static inline bool file_thp_enabled(struct vm_area_struct *vma)
>  {
>         struct inode *inode;
> @@ -211,7 +169,7 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
>
>  bool hugepage_vma_check(struct vm_area_struct *vma,
>                         unsigned long vm_flags,
> -                       bool smaps);
> +                       bool smaps, bool in_pf);
>
>  #define transparent_hugepage_use_zero_page()                           \
>         (transparent_hugepage_flags &                                   \
> @@ -355,11 +313,6 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
>         return false;
>  }
>
> -static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> -{
> -       return false;
> -}
> -
>  static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
>  {
>         return false;
> @@ -371,15 +324,9 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>         return false;
>  }
>
> -static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> -                                         unsigned long vm_flags)
> -{
> -       return false;
> -}
> -
>  static inline bool hugepage_vma_check(struct vm_area_struct *vma,
>                                        unsigned long vm_flags,
> -                                      bool smaps)
> +                                      bool smaps, bool in_pf)
>  {
>         return false;
>  }
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index 8a6452e089ca..e047be601268 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -55,7 +55,7 @@ static inline void khugepaged_enter(struct vm_area_struct *vma,
>  {
>         if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
>             khugepaged_enabled()) {
> -               if (hugepage_vma_check(vma, vm_flags, false))
> +               if (hugepage_vma_check(vma, vm_flags, false, false))
>                         __khugepaged_enter(vma->vm_mm);
>         }
>  }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bc8370856e85..b95786ada466 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -71,17 +71,25 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
>
>  bool hugepage_vma_check(struct vm_area_struct *vma,
>                         unsigned long vm_flags,
> -                       bool smaps)
> +                       bool smaps, bool in_pf)
>  {
> -       if (!transhuge_vma_enabled(vma, vm_flags))
> +       /* Explicitly disabled through madvise or prctl. */

Or s390 kvm (not that this has to be exhaustively maintained).

> +       if ((vm_flags & VM_NOHUGEPAGE) ||
> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +               return false;
> +       /*
> +        * If the hardware/firmware marked hugepage support disabled.
> +        */
> +       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
>                 return false;

This introduces an extra check for khugepaged path. I don't know
enough about TRANSPARENT_HUGEPAGE_NEVER_DAX, but I assume this is ok?
What would have happened previously if khugepaged tried to collapse
this memory?

> +       /* Special VMA and hugetlb VMA */
>         if (vm_flags & VM_NO_KHUGEPAGED)
>                 return false;

This adds an extra check along the fault path. Is it also safe to add?

> -       /* Don't run khugepaged against DAX vma */
> +       /* khugepaged doesn't collapse DAX vma, but page fault is fine. */
>         if (vma_is_dax(vma))
> -               return false;
> +               return in_pf;

I assume vma_is_temporary_stack() and vma_is_dax() is mutually exclusive.

>         if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
>                                 vma->vm_pgoff, HPAGE_PMD_NR))
> @@ -91,7 +99,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>                 return false;
>
>         /* Enabled via shmem mount options or sysfs settings. */
> -       if (shmem_file(vma->vm_file))
> +       if (!in_pf && shmem_file(vma->vm_file))
>                 return shmem_huge_enabled(vma);

Will shmem_file() ever be true in the fault path? Or is this just an
optimization?

>         if (!khugepaged_enabled())
> @@ -102,7 +110,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>                 return false;
>
>         /* Only regular file is valid */
> -       if (file_thp_enabled(vma))
> +       if (!in_pf && file_thp_enabled(vma))
>                 return true;

Likewise for file_thp_enabled()

>         if (!vma_is_anonymous(vma))
> @@ -114,9 +122,12 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>         /*
>          * THPeligible bit of smaps should show 1 for proper VMAs even
>          * though anon_vma is not initialized yet.
> +        *
> +        * Allow page fault since anon_vma may be not initialized until
> +        * the first page fault.
>          */
>         if (!vma->anon_vma)
> -               return smaps;
> +               return (smaps || in_pf);
>
>         return true;
>  }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index aa0769e3b0d9..ab6183c5489f 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -473,7 +473,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>  {
>         if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
>             khugepaged_enabled()) {
> -               if (hugepage_vma_check(vma, vm_flags, false))
> +               if (hugepage_vma_check(vma, vm_flags, false, false))
>                         __khugepaged_enter(vma->vm_mm);
>         }
>  }
> @@ -918,7 +918,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>
>         if (!transhuge_vma_suitable(vma, address))
>                 return SCAN_ADDRESS_RANGE;
> -       if (!hugepage_vma_check(vma, vma->vm_flags, false))
> +       if (!hugepage_vma_check(vma, vma->vm_flags, false, false))
>                 return SCAN_VMA_CHECK;
>         return 0;
>  }
> @@ -1399,7 +1399,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>          * the valid THP. Add extra VM_HUGEPAGE so hugepage_vma_check()
>          * will not fail the vma for missing VM_HUGEPAGE
>          */
> -       if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false))
> +       if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false, false))
>                 return;
>
>         /* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
> @@ -2089,7 +2089,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>                         progress++;
>                         break;
>                 }
> -               if (!hugepage_vma_check(vma, vma->vm_flags, false)) {
> +               if (!hugepage_vma_check(vma, vma->vm_flags, false, false)) {
>  skip:
>                         progress++;
>                         continue;
> diff --git a/mm/memory.c b/mm/memory.c
> index bc5d40eec5d5..673f7561a30a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4962,6 +4962,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>                 .gfp_mask = __get_fault_gfp_mask(vma),
>         };
>         struct mm_struct *mm = vma->vm_mm;
> +       unsigned long vm_flags = vma->vm_flags;
>         pgd_t *pgd;
>         p4d_t *p4d;
>         vm_fault_t ret;
> @@ -4975,7 +4976,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>         if (!vmf.pud)
>                 return VM_FAULT_OOM;
>  retry_pud:
> -       if (pud_none(*vmf.pud) && __transparent_hugepage_enabled(vma)) {
> +       if (pud_none(*vmf.pud) &&
> +           hugepage_vma_check(vma, vm_flags, false, true)) {
>                 ret = create_huge_pud(&vmf);
>                 if (!(ret & VM_FAULT_FALLBACK))
>                         return ret;
> @@ -5008,7 +5010,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>         if (pud_trans_unstable(vmf.pud))
>                 goto retry_pud;
>
> -       if (pmd_none(*vmf.pmd) && __transparent_hugepage_enabled(vma)) {
> +       if (pmd_none(*vmf.pmd) &&
> +           hugepage_vma_check(vma, vm_flags, false, true)) {
>                 ret = create_huge_pmd(&vmf);
>                 if (!(ret & VM_FAULT_FALLBACK))
>                         return ret;
> --
> 2.26.3
>
>
