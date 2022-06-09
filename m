Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9C254574F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345623AbiFIWVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239191AbiFIWVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:21:44 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7595E4EA3E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 15:21:42 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id g25so27660090ljm.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 15:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XAbGvzvs5JyHtN+RCe7kogF0fQRuXabkc/jwZnOnp4=;
        b=jqQ8j3WFlwEOdf3SCe6ZcweH6ojSaSbE9VrXW4B3MbW0GMoSpy4stkcYl695HlmwKI
         F7bCUgy/rBQrQ0+BhAr86l59kOZxRs3G5JSaaIhT2tx9p8qfqPRL+CrIKxzxUJfGVopm
         aUixLZPmwZEtUqNHEjBb5/kad1uyqJQR1svclMmOur6tFPoEytLhd3Y9oml0D4dcc3+1
         PXi9H6WVuyIqsV5uSDKFTND0hiuHFrZtnzBCJS/9AYeiFN/YB1gcny0tKpzdusbYuFv3
         hhEKSnfBgjMBIAuYlIb0NFY36wHNjlDebznPxd7EYqjX62aUqqKWOUEBLjIEXQreI2XH
         liow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XAbGvzvs5JyHtN+RCe7kogF0fQRuXabkc/jwZnOnp4=;
        b=Xn2zdqw1WdnSD4vGGcLtkkmleZ/s5PElcbraB/TzC1EwbeUqeA7Dwd9EGJ4KJZQfKU
         AbAVr1K/SEtzIf2JZPsLTMjfCN5oUZ9TUvXBRE7nCfhrP4/99Xv2nTaLEcDNum9SjvDH
         1F4YuthDPr9u5pOiE0udovmXM7teYb8O94RWUvocQ5VA1x8eEJ7yRc3q5a306/ZjnozO
         eyTwhzWPJkLD3SIfjfJZYsj+lLW5NjQUCkObHhHF1Q9MmSpxU6JQdKNC2iI3lkugpQBa
         8VbHaaI51YPk/N+/bndeZZ+fbhgJcqdeZ8A06VMyGznIt2rJ/ywkF2pbxFhI7MBRws3s
         FG2w==
X-Gm-Message-State: AOAM532AOZ9jEE1B0KG2oICOvbIpO6UGMpMzvEyC57ESqH3X2IasLpQ4
        D5PImVt0iff3gVg1QZdU/R/Aam7rpagI+R4wPtxjMA==
X-Google-Smtp-Source: ABdhPJyLQDCXCJpTDAOne+nagR40Mtns6u31Vb0Y/80nZPshX8AbfMJumpJDu+moXo3G1ul+sCUgcRgoxMbBJ1/Cz28=
X-Received: by 2002:a2e:9183:0:b0:255:75b7:48ae with SMTP id
 f3-20020a2e9183000000b0025575b748aemr20855781ljg.466.1654813300470; Thu, 09
 Jun 2022 15:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-3-shy828301@gmail.com>
In-Reply-To: <20220606214414.736109-3-shy828301@gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 9 Jun 2022 15:21:04 -0700
Message-ID: <CAAa6QmTYZQVf_U3dBnFpYGh3E8Qc4w8CKctMUC7jV_t=naGURQ@mail.gmail.com>
Subject: Re: [v3 PATCH 2/7] mm: thp: introduce transhuge_vma_size_ok() helper
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
> There are couple of places that check whether the vma size is ok for
> THP or not, they are open coded and duplicate, introduce
> transhuge_vma_size_ok() helper to do the job.
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/huge_mm.h | 17 +++++++++++++++++
>  mm/huge_memory.c        |  5 +----
>  mm/khugepaged.c         | 12 ++++++------
>  3 files changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 648cb3ce7099..a8f61db47f2a 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -116,6 +116,18 @@ extern struct kobj_attribute shmem_enabled_attr;
>
>  extern unsigned long transparent_hugepage_flags;
>
> +/*
> + * The vma size has to be large enough to hold an aligned HPAGE_PMD_SIZE area.
> + */
> +static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> +{
> +       if (round_up(vma->vm_start, HPAGE_PMD_SIZE) <
> +           (vma->vm_end & HPAGE_PMD_MASK))
> +               return true;
> +
> +       return false;
> +}

First time coming across round_up() - thanks for that - but for
symmetry, maybe also use round_down() for the end? No strong opinion -
just a suggestion given I've just discovered it.

>  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>                 unsigned long addr)
>  {
> @@ -345,6 +357,11 @@ static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
>         return false;
>  }
>
> +static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> +{
> +       return false;
> +}
> +
>  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>                 unsigned long addr)
>  {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 48182c8fe151..36ada544e494 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -71,10 +71,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
>
>  bool transparent_hugepage_active(struct vm_area_struct *vma)
>  {
> -       /* The addr is used to check if the vma size fits */
> -       unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> -
> -       if (!transhuge_vma_suitable(vma, addr))
> +       if (!transhuge_vma_size_ok(vma))
>                 return false;
>         if (vma_is_anonymous(vma))
>                 return __transparent_hugepage_enabled(vma);

Do we need a check for vma->vm_pgoff alignment here, after
!vma_is_anonymous(), and now that we don't call
transhuge_vma_suitable()?

> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 84b9cf4b9be9..d0f8020164fc 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -454,6 +454,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>                                 vma->vm_pgoff, HPAGE_PMD_NR))
>                 return false;
>
> +       if (!transhuge_vma_size_ok(vma))
> +               return false;
> +
>         /* Enabled via shmem mount options or sysfs settings. */
>         if (shmem_file(vma->vm_file))
>                 return shmem_huge_enabled(vma);
> @@ -512,9 +515,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>                           unsigned long vm_flags)
>  {
>         if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> -           khugepaged_enabled() &&
> -           (((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
> -            (vma->vm_end & HPAGE_PMD_MASK))) {
> +           khugepaged_enabled()) {
>                 if (hugepage_vma_check(vma, vm_flags))
>                         __khugepaged_enter(vma->vm_mm);
>         }
> @@ -2142,10 +2143,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>                         progress++;
>                         continue;
>                 }
> -               hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> +
> +               hstart = round_up(vma->vm_start, HPAGE_PMD_SIZE);
>                 hend = vma->vm_end & HPAGE_PMD_MASK;
> -               if (hstart >= hend)
> -                       goto skip;
>                 if (khugepaged_scan.address > hend)
>                         goto skip;
>                 if (khugepaged_scan.address < hstart)

Likewise, could do round_down() here (just a suggestion)

> --
> 2.26.3
>
>
