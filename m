Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00755459AE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiFJBwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240849AbiFJBwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:52:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8254220E03
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 18:52:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w20so18978207lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 18:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yu2uAtXe8nBXbsN8E9JnIvbhth+ppm+OC8YckFrwJFU=;
        b=HCmGBSWPgP45n6XdrVXY5CMCAvRbHmyVdErIA9T37zYysJlb1nAi4d87VcQDcCL3UE
         OCvomgdYmu3oMA+X8xc758db16srvSYw3C2hUYoAEFXE2XhuvzaDmvXyxj/X9+6aFbCt
         d4VaV/MVp1HqBN3rh9hu4AKhxieZG2qkfo0dXhQ0RTmgHob4P9hb8Ub2T62yHCZ05imI
         3PeehoARpYywYujtybHMF40k+Nbkbp6ZmxNID3ELad4x9yGgEGv4hIlZMqACPiI9Dv70
         vTiLCP6Q9tnH1vqV798z+sr+jWX774U8pUT4zfOQqUKQjFb1gtEQUbqPP0RIB5LgZw88
         p3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yu2uAtXe8nBXbsN8E9JnIvbhth+ppm+OC8YckFrwJFU=;
        b=p/y+yOhvZNTln1xTUMwiIwHYaB9MB7a1dFLfqJdZdTMCGTu5rumzHUsM7GEQ3Xqi3M
         RE5vwZKKcl34nYSCv/UBKKHJ/1vvb+znGlXMa+Eg547mfgftN/LBD6ag5DWjtulPDU2m
         5McidKYHijQeFfT4xWAHOgRSsKRyTsAqGKU/otqBAIlukldeyl5nzlT8bq+lnxYEaY06
         iAEOLV27b/uht645hCiMMBPGdEj74wSU34Fr9M83AG5y2VS0uw86XAyDvYC+IrbnNQxT
         kWrxQXuSLvvljQ2oPCwn7CvNOVVjQJxje9F1bZbwuQKmBK4wdJyhcrPFHiekgI3qj0xe
         UFzQ==
X-Gm-Message-State: AOAM5306gDWP1afPQIfkWRv06q2+P2+1FnaWrX/iJjaSgs4l9zLAbJr7
        CwK1qhuw7c/DFCjVeFRqUznx/aPswYJq4O6FGunqzA==
X-Google-Smtp-Source: ABdhPJz1iXApa41h6OoT4S9/ePZLU3tkr4a/jxLcacMUaS85w5vB+iDnMMfBeJfGgqDvngCXhzvDk5evr/E/+ti81h4=
X-Received: by 2002:a05:6512:249:b0:479:a3c:de with SMTP id
 b9-20020a056512024900b004790a3c00demr26777518lfo.128.1654825927907; Thu, 09
 Jun 2022 18:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-5-shy828301@gmail.com>
In-Reply-To: <20220606214414.736109-5-shy828301@gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 9 Jun 2022 18:51:31 -0700
Message-ID: <CAAa6QmSCk+7HLtLOzbTYev7dAM0aff-f4USV3AXAQdSKu7_6HA@mail.gmail.com>
Subject: Re: [v3 PATCH 4/7] mm: khugepaged: use transhuge_vma_suitable replace open-code
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
> The hugepage_vma_revalidate() needs to check if the address is still in
> the aligned HPAGE_PMD_SIZE area of the vma when reacquiring mmap_lock,
> but it was open-coded, use transhuge_vma_suitable() to do the job.  And
> add proper comments for transhuge_vma_suitable().
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/huge_mm.h | 6 ++++++
>  mm/khugepaged.c         | 5 +----
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index a8f61db47f2a..79d5919beb83 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -128,6 +128,12 @@ static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
>         return false;
>  }
>
> +/*
> + * Do the below checks:
> + *   - For non-anon vma, check if the vm_pgoff is HPAGE_PMD_NR aligned.
> + *   - For all vmas, check if the haddr is in an aligned HPAGE_PMD_SIZE
> + *     area.
> + */

AFAIK we aren't checking if vm_pgoff is HPAGE_PMD_NR aligned, but
rather that linear_page_index(vma, round_up(vma->vm_start,
HPAGE_PMD_SIZE)) is HPAGE_PMD_NR aligned within vma->vm_file. I was
pretty confused about this (hopefully I have it right now - if not -
case and point :) ), so it might be a good opportunity to add some
extra commentary to help future travelers understand why this
constraint exists.

Also I wonder while we're at it if we can rename this to
transhuge_addr_aligned() or transhuge_addr_suitable() or something.

Otherwise I think the change is a nice cleanup.

>  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>                 unsigned long addr)
>  {
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 7a5d1c1a1833..ca1754d3a827 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -951,7 +951,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>                 struct vm_area_struct **vmap)
>  {
>         struct vm_area_struct *vma;
> -       unsigned long hstart, hend;
>
>         if (unlikely(khugepaged_test_exit(mm)))
>                 return SCAN_ANY_PROCESS;
> @@ -960,9 +959,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>         if (!vma)
>                 return SCAN_VMA_NULL;
>
> -       hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> -       hend = vma->vm_end & HPAGE_PMD_MASK;
> -       if (address < hstart || address + HPAGE_PMD_SIZE > hend)
> +       if (!transhuge_vma_suitable(vma, address))
>                 return SCAN_ADDRESS_RANGE;
>         if (!hugepage_vma_check(vma, vma->vm_flags))
>                 return SCAN_VMA_CHECK;
> --
> 2.26.3
>
>
