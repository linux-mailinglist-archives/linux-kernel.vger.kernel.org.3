Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450534C981C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 23:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiCAWEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 17:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbiCAWEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 17:04:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AC5403D9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 14:03:25 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id p4so8763360edi.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 14:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4g38lO84UEtzS1FMCpfYGL1X2pOxy5GyUBDE0k9I5bU=;
        b=g3YkwGFhbNdKjyR0fFhLMMbf1kNDXQtjEFJZ6TJ0CZjmncWLXYuxpSn8ZngEIbLzDt
         Xbw9oWxk9uw85L3P7TsyLIIbnhgs779zzaWNaUDS3esO3WjHcJe3M7FfIxKQsacEqpwO
         7EdKZIYT2PqSrpwsaYl7VxttgzZJhXMgy0gxg6earvDtLTSAhRtoZb6XDfdiCV0d91oy
         qF9Aa7UkV+/Jb3YuBk1K0oSRhpybtqzjrQ/b/H5fM4spJIFHsd0RO0VDbLLnJVVc0ZBD
         4Noxbl35v8SHxRwCcup9zOjvWzQSFrmqaJAubdGOHnPSSRrYbWoAhkWYCCoD4iI9eQT0
         fHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4g38lO84UEtzS1FMCpfYGL1X2pOxy5GyUBDE0k9I5bU=;
        b=B18+En3m9xDG1TBIXugSmrCyndu4upXTDaRNEqteMNSx+TL8Y/fg0yxkudN1q+KZ4I
         FMf3yChMdRKclMUE42a6ucVyjdt3v1DmisKB8doVaop6BO9SOjbYbMSx+NEaiX8JBYPP
         ZhPec/xIL97Fo6/BkCEgNLmcZ5YYW/iYd/XCvRz2OQV+LFufQi012KZG3bgU3WeTWVeA
         VOAVY3UGZb+rN1vMngTWXfIMCSky0zU1KXLkxTouhv8A3cxHSrG323Raj1LUsa2Zyvqx
         QDkGsrIGQOkF5Wg6OedBvO2WhCXf6rgtvjLt1REIOFtQZqRe0BVu2eHApgC1rp4BRD8H
         un0A==
X-Gm-Message-State: AOAM530YVtVE9OlZCRzs5/k4iYf3hWmE0C50bloT6JAxFqOsD0vwZyjZ
        xiOmaFFeIHuT1kVOgDAnOVTdaE0gKqLb+gdCyYw=
X-Google-Smtp-Source: ABdhPJwGQCophlEQDew2HaHEJrwNCfFiJgIQPLhDBroTh81nlt7REEbtOfxnqEhGAJw1pYUzTsY8WY0OfZ3XxE9sug4=
X-Received: by 2002:aa7:ca5a:0:b0:410:9259:2e6f with SMTP id
 j26-20020aa7ca5a000000b0041092592e6fmr26313239edt.105.1646172204498; Tue, 01
 Mar 2022 14:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20220301085329.3210428-1-ying.huang@intel.com> <20220301085329.3210428-4-ying.huang@intel.com>
In-Reply-To: <20220301085329.3210428-4-ying.huang@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 1 Mar 2022 14:03:11 -0800
Message-ID: <CAHbLzkoKrnGmw6QRruMbM12KNRaYTTxg-sri81zXH8QDsJgSfw@mail.gmail.com>
Subject: Re: [PATCH -V14 3/3] memory tiering: skip to scan fast memory
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 12:54 AM Huang Ying <ying.huang@intel.com> wrote:
>
> If the NUMA balancing isn't used to optimize the page placement among
> sockets but only among memory types, the hot pages in the fast memory
> node couldn't be migrated (promoted) to anywhere.  So it's unnecessary
> to scan the pages in the fast memory node via changing their PTE/PMD
> mapping to be PROT_NONE.  So that the page faults could be avoided
> too.
>
> In the test, if only the memory tiering NUMA balancing mode is enabled, the
> number of the NUMA balancing hint faults for the DRAM node is reduced to
> almost 0 with the patch.  While the benchmark score doesn't change
> visibly.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  mm/huge_memory.c | 30 +++++++++++++++++++++---------
>  mm/mprotect.c    | 13 ++++++++++++-
>  2 files changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 406a3c28c026..9ce126cb0cfd 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -34,6 +34,7 @@
>  #include <linux/oom.h>
>  #include <linux/numa.h>
>  #include <linux/page_owner.h>
> +#include <linux/sched/sysctl.h>
>
>  #include <asm/tlb.h>
>  #include <asm/pgalloc.h>
> @@ -1766,17 +1767,28 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>         }
>  #endif
>
> -       /*
> -        * Avoid trapping faults against the zero page. The read-only
> -        * data is likely to be read-cached on the local CPU and
> -        * local/remote hits to the zero page are not interesting.
> -        */
> -       if (prot_numa && is_huge_zero_pmd(*pmd))
> -               goto unlock;
> +       if (prot_numa) {
> +               struct page *page;
> +               /*
> +                * Avoid trapping faults against the zero page. The read-only
> +                * data is likely to be read-cached on the local CPU and
> +                * local/remote hits to the zero page are not interesting.
> +                */
> +               if (is_huge_zero_pmd(*pmd))
> +                       goto unlock;
>
> -       if (prot_numa && pmd_protnone(*pmd))
> -               goto unlock;
> +               if (pmd_protnone(*pmd))
> +                       goto unlock;
>
> +               page = pmd_page(*pmd);
> +               /*
> +                * Skip scanning top tier node if normal numa
> +                * balancing is disabled
> +                */
> +               if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
> +                   node_is_toptier(page_to_nid(page)))
> +                       goto unlock;
> +       }
>         /*
>          * In case prot_numa, we are under mmap_read_lock(mm). It's critical
>          * to not clear pmd intermittently to avoid race with MADV_DONTNEED
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 0138dfcdb1d8..2fe03e695c81 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -29,6 +29,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/mm_inline.h>
>  #include <linux/pgtable.h>
> +#include <linux/sched/sysctl.h>
>  #include <asm/cacheflush.h>
>  #include <asm/mmu_context.h>
>  #include <asm/tlbflush.h>
> @@ -83,6 +84,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>                          */
>                         if (prot_numa) {
>                                 struct page *page;
> +                               int nid;
>
>                                 /* Avoid TLB flush if possible */
>                                 if (pte_protnone(oldpte))
> @@ -109,7 +111,16 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>                                  * Don't mess with PTEs if page is already on the node
>                                  * a single-threaded process is running on.
>                                  */
> -                               if (target_node == page_to_nid(page))
> +                               nid = page_to_nid(page);
> +                               if (target_node == nid)
> +                                       continue;
> +
> +                               /*
> +                                * Skip scanning top tier node if normal numa
> +                                * balancing is disabled
> +                                */
> +                               if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
> +                                   node_is_toptier(nid))
>                                         continue;
>                         }
>
> --
> 2.30.2
>
