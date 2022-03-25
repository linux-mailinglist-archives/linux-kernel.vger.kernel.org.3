Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B49F4E6D89
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358327AbiCYFMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 01:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbiCYFMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:12:50 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242D2C4E28;
        Thu, 24 Mar 2022 22:11:17 -0700 (PDT)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 22P5Aeie023414;
        Fri, 25 Mar 2022 14:10:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 22P5Aeie023414
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648185041;
        bh=EA2McNg9gBsMb+VOM3ot+UljuCXwcwnlphFiuTV1jjU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MaddDudIA8vuwBix+QMg/9YdmndNaQxESYOxmvTEDSFy+qJc5LbKWI8+tnkvuyOfR
         mFd/bVrEVdRxwnRY0W/FKS9MEQdXzOoR3Ye8OAb0dmlwhjX3W2OP6TAHyT6HYpKdUO
         GXcrDSckU4/f0sZK9AIoP4up99sC3Kbpgga7cerFTvab3bFzN/itR1VEW5t6bjrUuC
         XPLp4FQUDYZbpesN76t5RkzUxkexkLb5iDf2eLKWb8votdSYaYB8A5Zigg1gocZ6Ob
         fBEa/dADskqlU4k4fmrA7d//YUxhwvuC95DNpO3CYKbjYGH7ZNz+cTf8PpCxOvnFrC
         QfehRGsbCokkw==
X-Nifty-SrcIP: [209.85.215.177]
Received: by mail-pg1-f177.google.com with SMTP id t13so4329436pgn.8;
        Thu, 24 Mar 2022 22:10:41 -0700 (PDT)
X-Gm-Message-State: AOAM530EkA7H2qGZW9B3zmDCzdqxqfW6nG/0Psoo3XkS5b7vayMtc4HY
        f/mAT44h1FCQr5RylGVeMNAUevQMuUJa+WoF/AQ=
X-Google-Smtp-Source: ABdhPJxKZT6yQRHnzoGuq+8NKh/4hkyGmyT4Ys5s6GgNl/clct4EpyjeYlyui7D+0wKE2eEZKDEtAyzXZoQG3Ny0K7g=
X-Received: by 2002:a05:6a00:234f:b0:4fa:f52b:46a1 with SMTP id
 j15-20020a056a00234f00b004faf52b46a1mr5328380pfj.32.1648185040175; Thu, 24
 Mar 2022 22:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220323125523.79254-1-songmuchun@bytedance.com> <20220323125523.79254-2-songmuchun@bytedance.com>
In-Reply-To: <20220323125523.79254-2-songmuchun@bytedance.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 25 Mar 2022 14:09:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQoRfo_L0xa+rCBNWcYYSjV-HSTOQcQ-q0BUs9daKH94g@mail.gmail.com>
Message-ID: <CAK7LNAQoRfo_L0xa+rCBNWcYYSjV-HSTOQcQ-q0BUs9daKH94g@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] mm: hugetlb_vmemmap: introduce STRUCT_PAGE_SIZE_IS_POWER_OF_2
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, mike.kravetz@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 9:57 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> If the size of "struct page" is not the power of two and this
> feature is enabled, then the vmemmap pages of HugeTLB will be
> corrupted after remapping (panic is about to happen in theory).
> But this only exists when !CONFIG_MEMCG && !CONFIG_SLUB on
> x86_64.  However, it is not a conventional configuration nowadays.
> So it is not a real word issue, just the result of a code review.
> But we have to prevent anyone from configuring that combined
> configuration.  In order to avoid many checks like "is_power_of_2
> (sizeof(struct page))" through mm/hugetlb_vmemmap.c.  Introduce
> STRUCT_PAGE_SIZE_IS_POWER_OF_2 to detect if the size of struct
> page is power of 2 and make this feature depends on this new
> config.  Then we could prevent anyone do any unexpected
> configuration.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  Kbuild                           | 14 ++++++++++++++
>  fs/Kconfig                       |  1 +
>  include/linux/mm_types.h         |  2 ++
>  mm/Kconfig                       |  3 +++
>  mm/hugetlb_vmemmap.c             |  6 ------
>  mm/struct_page_size.c            | 19 +++++++++++++++++++
>  scripts/check_struct_page_po2.sh |  9 +++++++++
>  7 files changed, 48 insertions(+), 6 deletions(-)
>  create mode 100644 mm/struct_page_size.c
>  create mode 100755 scripts/check_struct_page_po2.sh
>
> diff --git a/Kbuild b/Kbuild
> index fa441b98c9f6..21415c3b2728 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -37,6 +37,20 @@ $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
>         $(call filechk,offsets,__ASM_OFFSETS_H__)
>
>  #####
> +# Generate struct_page_size.h.
> +
> +struct_page_size-file := include/generated/struct_page_size.h
> +
> +always-y := $(struct_page_size-file)
> +targets := mm/struct_page_size.s
> +
> +mm/struct_page_size.s: $(timeconst-file) $(bounds-file)
> +
> +$(struct_page_size-file): mm/struct_page_size.s FORCE
> +       $(call filechk,offsets,__LINUX_STRUCT_PAGE_SIZE_H__)
> +       $(Q)$(MAKE) -f $(srctree)/Makefile syncconfig


No, please do not do this.
It is terrible to feed back this to Kconfig again.

If you know this happens on !CONFIG_MEMCG && !CONFIG_SLUB on x86_64,
why don't you add this dependency directly?


If you want to avoid the run-time check,
why don't you use  BUILD_BUG_ON() ?






> +
> +#####
>  # Check for missing system calls
>
>  always-y += missing-syscalls
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 7f2455e8e18a..856d2e9f5aef 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -249,6 +249,7 @@ config HUGETLB_PAGE_FREE_VMEMMAP
>         def_bool HUGETLB_PAGE
>         depends on X86_64
>         depends on SPARSEMEM_VMEMMAP
> +       depends on STRUCT_PAGE_SIZE_IS_POWER_OF_2
>
>  config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
>         bool "Default freeing vmemmap pages of HugeTLB to on"
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 8834e38c06a4..5fbff44a4310 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -223,6 +223,7 @@ struct page {
>  #endif
>  } _struct_page_alignment;
>
> +#ifndef __GENERATING_STRUCT_PAGE_SIZE_IS_POWER_OF_2_H
>  /**
>   * struct folio - Represents a contiguous set of bytes.
>   * @flags: Identical to the page flags.
> @@ -844,5 +845,6 @@ enum fault_flag {
>         FAULT_FLAG_INSTRUCTION =        1 << 8,
>         FAULT_FLAG_INTERRUPTIBLE =      1 << 9,
>  };
> +#endif /* !__GENERATING_STRUCT_PAGE_SIZE_IS_POWER_OF_2_H */
>
>  #endif /* _LINUX_MM_TYPES_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 034d87953600..9314bd34f49e 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -2,6 +2,9 @@
>
>  menu "Memory Management options"
>
> +config STRUCT_PAGE_SIZE_IS_POWER_OF_2
> +       def_bool $(success,test "$(shell, $(srctree)/scripts/check_struct_page_po2.sh)" = 1)
> +
>  config SELECT_MEMORY_MODEL
>         def_bool y
>         depends on ARCH_SELECT_MEMORY_MODEL
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 791626983c2e..33ecb77c2b2a 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -194,12 +194,6 @@ EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled_key);
>
>  static int __init early_hugetlb_free_vmemmap_param(char *buf)
>  {
> -       /* We cannot optimize if a "struct page" crosses page boundaries. */
> -       if (!is_power_of_2(sizeof(struct page))) {
> -               pr_warn("cannot free vmemmap pages because \"struct page\" crosses page boundaries\n");
> -               return 0;
> -       }
> -
>         if (!buf)
>                 return -EINVAL;
>
> diff --git a/mm/struct_page_size.c b/mm/struct_page_size.c
> new file mode 100644
> index 000000000000..5749609aa1b3
> --- /dev/null
> +++ b/mm/struct_page_size.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generate definitions needed by the preprocessor.
> + * This code generates raw asm output which is post-processed
> + * to extract and format the required data.
> + */
> +
> +#define __GENERATING_STRUCT_PAGE_SIZE_IS_POWER_OF_2_H
> +/* Include headers that define the enum constants of interest */
> +#include <linux/mm_types.h>
> +#include <linux/kbuild.h>
> +#include <linux/log2.h>
> +
> +int main(void)
> +{
> +       DEFINE(STRUCT_PAGE_SIZE_IS_POWER_OF_2, is_power_of_2(sizeof(struct page)));
> +
> +       return 0;
> +}
> diff --git a/scripts/check_struct_page_po2.sh b/scripts/check_struct_page_po2.sh
> new file mode 100755
> index 000000000000..1764ef9a4f1d
> --- /dev/null
> +++ b/scripts/check_struct_page_po2.sh
> @@ -0,0 +1,9 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Check if the size of "struct page" is power of 2
> +
> +file="include/generated/struct_page_size.h"
> +if [ -f "$file" ]; then
> +       grep STRUCT_PAGE_SIZE_IS_POWER_OF_2 "$file" | cut -d' ' -f3
> +fi
> --
> 2.11.0
>


-- 
Best Regards
Masahiro Yamada
