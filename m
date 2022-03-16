Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27E34DBA98
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiCPWQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 18:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358272AbiCPWQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:16:48 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523E2F8;
        Wed, 16 Mar 2022 15:15:25 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id f38so7014907ybi.3;
        Wed, 16 Mar 2022 15:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fzy1q7yZxTsQqPTdZtzeZYFh+ifL58Ovi/YokXT2mF8=;
        b=ShVBfQQjJC7lfytQX/nrlKpzsp/2D5XSF8wTWdFmFhgJNoyk/LwGb/acBV+KKTBtWe
         MqGHo9wJmy5e+HtdYRP5icDbxW3pAaX/Z3CSNKWxMUAHmHFKXkuwgAbmOwb4R/F8UAKV
         oZxlPUn0Iq5YnfRohk6KxSpo75h5trFMAGU+AHIa9UBUvkZaRBdlw7zOECMQnF99KwOj
         7B2PizgWfvf/HoQlpSGMwzKmhsGlJWxJOW3pow6Nm3Rs7KUqHh6TJc0T3liGlBeCS3Ps
         17Ui7uVBymoILX1qq0GdZWy4bnM4UkBCvcp2OR7XJLwhFO8hDYJaiFwqT7rw/GqZvRzX
         yHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fzy1q7yZxTsQqPTdZtzeZYFh+ifL58Ovi/YokXT2mF8=;
        b=ESoWDTVZrgDQoPheJ71pc95uLvY28zpKxj/KABM04MjuNCaSEkH4s4Cd0VcvaE1deG
         Kw1bVJsrDLjD56mqIxvQ3euoBa7DWCUXT0tNSVjKfXvvzr6HIlQzEkYQjRenTFpWMDaq
         rAKdqO7/V5CGxmCxDaUDU/6EWJLzgUvWDUDfecncQkXkjiMcQ5y7tCXzdbg6V0qGP/8J
         aGjea1CMIiurVjFzEo5ODo5MP0MMIL+6Dls7UM+Y7JwSc1H80SQSl5IaTFvbCPr8f8v5
         ZJSeRUzHaiVyOdI7FfSofmzfAT68lGX5nUu0Q1xaw3iG6gQszCQpQySRpabE6AszR7Dd
         lqaw==
X-Gm-Message-State: AOAM530v9GGWli3QsB0bNOt+xbpa5d+1R1bCrij8MtEozfcYwpcqcxcH
        zBA6NGXpfiejq2WfZ9RcG9anY3xLFUm2/EzqFCQ=
X-Google-Smtp-Source: ABdhPJyFQMuz/0hw/ZkMi8DFHi/gflT4UxHsJLPA6TMY/fcwGpClrwi2RSsYQfr+aJ1+yNfj2mJqAUQrzPf9DXl3/Lg=
X-Received: by 2002:a25:c046:0:b0:633:7235:afda with SMTP id
 c67-20020a25c046000000b006337235afdamr2263706ybf.540.1647468925020; Wed, 16
 Mar 2022 15:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-3-yuzhao@google.com>
In-Reply-To: <20220309021230.721028-3-yuzhao@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 17 Mar 2022 11:15:11 +1300
Message-ID: <CAGsJ_4xjC6Shp6R0ZQA5A7f67hm1DVE8iZ5f4LUONuA7=CHOtQ@mail.gmail.com>
Subject: Re: [PATCH v9 02/14] mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 3:47 PM Yu Zhao <yuzhao@google.com> wrote:
>
> Some architectures support the accessed bit in non-leaf PMD entries,
> e.g., x86 sets the accessed bit in a non-leaf PMD entry when using it
> as part of linear address translation [1]. Page table walkers that
> clear the accessed bit may use this capability to reduce their search
> space.
>
> Note that:
> 1. Although an inline function is preferable, this capability is added
>    as a configuration option for consistency with the existing macros.
> 2. Due to the little interest in other varieties, this capability was
>    only tested on Intel and AMD CPUs.
>
> [1]: Intel 64 and IA-32 Architectures Software Developer's Manual
>      Volume 3 (June 2021), section 4.8
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Acked-by: Steven Barrett <steven@liquorix.net>
> Acked-by: Suleiman Souhlal <suleiman@google.com>
> Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> Tested-by: Donald Carr <d@chaos-reins.com>
> Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>

hard to read this patch by itself. but after reading the change in
walk_pmd_range(), it seems this patch becomes quite clear:
walk_pmd_range()
{
...
#ifdef CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
                if (get_cap(LRU_GEN_NONLEAF_YOUNG)) {
                        if (!pmd_young(val))
                                continue;

                        walk_pmd_range_locked(pud, addr, vma, walk, &pos);
                }
#endif
...
}
this gives us the chance to skip the scan of all ptes within the
pmd.
so i am not quite sure this should necessarily be a separate
patch, or should be put together with the change in
walk_pmd_range() to make readers understand its purpose.


>  arch/Kconfig                   | 9 +++++++++
>  arch/x86/Kconfig               | 1 +
>  arch/x86/include/asm/pgtable.h | 3 ++-
>  arch/x86/mm/pgtable.c          | 5 ++++-
>  include/linux/pgtable.h        | 4 ++--
>  5 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 678a80713b21..f9c59ecadbbb 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1322,6 +1322,15 @@ config DYNAMIC_SIGFRAME
>  config HAVE_ARCH_NODE_DEV_GROUP
>         bool
>
> +config ARCH_HAS_NONLEAF_PMD_YOUNG
> +       bool
> +       depends on PGTABLE_LEVELS > 2
> +       help
> +         Architectures that select this option are capable of setting th=
e
> +         accessed bit in non-leaf PMD entries when using them as part of=
 linear
> +         address translations. Page table walkers that clear the accesse=
d bit
> +         may use this capability to reduce their search space.
> +
>  source "kernel/gcov/Kconfig"
>
>  source "scripts/gcc-plugins/Kconfig"
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9f5bd41bf660..e787b7fc75be 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -85,6 +85,7 @@ config X86
>         select ARCH_HAS_PMEM_API                if X86_64
>         select ARCH_HAS_PTE_DEVMAP              if X86_64
>         select ARCH_HAS_PTE_SPECIAL
> +       select ARCH_HAS_NONLEAF_PMD_YOUNG
>         select ARCH_HAS_UACCESS_FLUSHCACHE      if X86_64
>         select ARCH_HAS_COPY_MC                 if X86_64
>         select ARCH_HAS_SET_MEMORY
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtabl=
e.h
> index 60b6ce45c2e3..f973788f6b21 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -819,7 +819,8 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>
>  static inline int pmd_bad(pmd_t pmd)
>  {
> -       return (pmd_flags(pmd) & ~_PAGE_USER) !=3D _KERNPG_TABLE;
> +       return (pmd_flags(pmd) & ~(_PAGE_USER | _PAGE_ACCESSED)) !=3D
> +              (_KERNPG_TABLE & ~_PAGE_ACCESSED);
>  }
>
>  static inline unsigned long pages_to_mb(unsigned long npg)
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 3481b35cb4ec..a224193d84bf 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -550,7 +550,7 @@ int ptep_test_and_clear_young(struct vm_area_struct *=
vma,
>         return ret;
>  }
>
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONL=
EAF_PMD_YOUNG)
>  int pmdp_test_and_clear_young(struct vm_area_struct *vma,
>                               unsigned long addr, pmd_t *pmdp)
>  {
> @@ -562,6 +562,9 @@ int pmdp_test_and_clear_young(struct vm_area_struct *=
vma,
>
>         return ret;
>  }
> +#endif
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  int pudp_test_and_clear_young(struct vm_area_struct *vma,
>                               unsigned long addr, pud_t *pudp)
>  {
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 79f64dcff07d..743e7fc4afda 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -212,7 +212,7 @@ static inline int ptep_test_and_clear_young(struct vm=
_area_struct *vma,
>  #endif
>
>  #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONL=
EAF_PMD_YOUNG)
>  static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
>                                             unsigned long address,
>                                             pmd_t *pmdp)
> @@ -233,7 +233,7 @@ static inline int pmdp_test_and_clear_young(struct vm=
_area_struct *vma,
>         BUILD_BUG();
>         return 0;
>  }
> -#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_ARCH_HAS_NONLEAF_PMD_YOU=
NG */
>  #endif
>
>  #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
> --
> 2.35.1.616.g0bdcbb4464-goog
>

Thanks
Barry
