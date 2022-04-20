Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F63508E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380951AbiDTRPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380918AbiDTRPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:15:41 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A014578A;
        Wed, 20 Apr 2022 10:12:54 -0700 (PDT)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 23KHCZ77026093;
        Thu, 21 Apr 2022 02:12:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 23KHCZ77026093
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650474755;
        bh=Fk2/b3chLadxxWYR7TJuggZMmEaTZ15R1Bl8NCeoLQw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ARgD5/tIAHSdmMMtb7NUu93xkSGxzvvKSvM6ViAIAMDlTiFJnxXLs1DOTnQjHuYQ4
         f2pYiIjxiVXwOySQOeVtE+zncDSKUFsk3I3F66Zsa+BzeuCamPFN7AeieGCiyMvX91
         75NlsPxWTWMcdTAUwnmV7SbTCasLzoFUiyNfso33DDFqes00T3OG5gNQQzZDFenB8R
         4JgCnT4NYjgT31bkdl5EVR5gGCzUWaZXuh2hsGc4s6budcsleuEacb8butjFUhogic
         kDflNYr1obyVpohbCZr1y9tMbNqiebeN+XWiqJx0P0yVjagyG39ldjKCUvjQ2TBX8s
         fBaumduZXZM6A==
X-Nifty-SrcIP: [209.85.215.174]
Received: by mail-pg1-f174.google.com with SMTP id bg9so2168690pgb.9;
        Wed, 20 Apr 2022 10:12:35 -0700 (PDT)
X-Gm-Message-State: AOAM532DcY9CgbnpVonKz/gecx+RbuQQxmZZVw2lrS0PcEb2ZgpG3d8U
        dPRK6beYefLhYS8jG0sGam8z8uk7Ilovw8AnUr0=
X-Google-Smtp-Source: ABdhPJxOQtBOOzOzHz6j7UNKrhcW2BGLKttRmgmlW//TR+NzqtbsEr8i0spqFRmnkBFUS4Q6boqKGjMOv67/TlpIZao=
X-Received: by 2002:a63:5212:0:b0:3a9:fb93:462b with SMTP id
 g18-20020a635212000000b003a9fb93462bmr14310900pgb.126.1650474754505; Wed, 20
 Apr 2022 10:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220413144748.84106-1-songmuchun@bytedance.com> <20220413144748.84106-2-songmuchun@bytedance.com>
In-Reply-To: <20220413144748.84106-2-songmuchun@bytedance.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 21 Apr 2022 02:11:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNARNyYNMMYcEwU-pVFb-b21cKN+K_jwseLTtoOfscS2Ggw@mail.gmail.com>
Message-ID: <CAK7LNARNyYNMMYcEwU-pVFb-b21cKN+K_jwseLTtoOfscS2Ggw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] mm: hugetlb_vmemmap: introduce CONFIG_HUGETLB_PAGE_HAS_OPTIMIZE_VMEMMAP
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 11:48 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> If the size of "struct page" is not the power of two but with the feature
> of minimizing overhead of struct page associated with each HugeTLB is
> enabled, then the vmemmap pages of HugeTLB will be corrupted after
> remapping (panic is about to happen in theory).  But this only exists when
> !CONFIG_MEMCG && !CONFIG_SLUB on x86_64.  However, it is not a conventional
> configuration nowadays.  So it is not a real word issue, just the result
> of a code review.  But we have to prevent anyone from configuring that
> combined configurations.  In order to avoid many checks like "is_power_of_2
> (sizeof(struct page))" through mm/hugetlb_vmemmap.c.  Introduce a new macro
> CONFIG_HUGETLB_PAGE_HAS_OPTIMIZE_VMEMMAP to represent the size of struct
> page is power of two and CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is
> configured.  Then make the codes of this feature depends on this new macro.
> Then we could prevent anyone do any unexpected configurations.  A new
> autoconf_ext.h is introduced as well, which serves as an extension for
> autoconf.h since those special configurations (e.g.
> CONFIG_HUGETLB_PAGE_HAS_OPTIMIZE_VMEMMAP here) are rely on the autoconf.h
> (generated from Kconfig), so we cannot embed those configurations into
> Kconfig.  After this change, it would be easy if someone want to do the
> similar thing (add a new CONFIG) in the future.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  Kbuild                     | 19 +++++++++++++++++++
>  arch/x86/mm/init_64.c      |  2 +-
>  include/linux/hugetlb.h    |  2 +-
>  include/linux/kconfig.h    |  4 ++++
>  include/linux/mm.h         |  2 +-
>  include/linux/page-flags.h |  2 +-
>  kernel/autoconf_ext.c      | 26 ++++++++++++++++++++++++++
>  mm/hugetlb_vmemmap.c       |  8 ++------
>  mm/hugetlb_vmemmap.h       |  4 ++--
>  mm/sparse-vmemmap.c        |  4 ++--
>  scripts/mod/Makefile       |  2 ++
>  11 files changed, 61 insertions(+), 14 deletions(-)
>  create mode 100644 kernel/autoconf_ext.c
>
> diff --git a/Kbuild b/Kbuild
> index fa441b98c9f6..83c0d5a418d1 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -2,6 +2,12 @@
>  #
>  # Kbuild for top-level directory of the kernel
>
> +# autoconf_ext.h is generated last since it depends on other generated headers,
> +# however those other generated headers may include autoconf_ext.h. Use the
> +# following macro to avoid circular dependency.
> +
> +KBUILD_CFLAGS_KERNEL += -D__EXCLUDE_AUTOCONF_EXT_H
> +
>  #####
>  # Generate bounds.h
>
> @@ -37,6 +43,19 @@ $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
>         $(call filechk,offsets,__ASM_OFFSETS_H__)
>
>  #####
> +# Generate autoconf_ext.h.
> +
> +autoconf_ext-file := include/generated/autoconf_ext.h
> +
> +always-y += $(autoconf_ext-file)
> +targets += kernel/autoconf_ext.s
> +
> +kernel/autoconf_ext.s: $(bounds-file) $(timeconst-file) $(offsets-file)
> +
> +$(autoconf_ext-file): kernel/autoconf_ext.s FORCE
> +       $(call filechk,offsets,__LINUX_AUTOCONF_EXT_H__)
> +
> +#####
>  # Check for missing system calls
>
>  always-y += missing-syscalls
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 4b9e0012bbbf..9b8dfa6e4da8 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1268,7 +1268,7 @@ static struct kcore_list kcore_vsyscall;
>
>  static void __init register_page_bootmem_info(void)
>  {
> -#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP)
> +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_HAS_OPTIMIZE_VMEMMAP)
>         int i;
>
>         for_each_online_node(i)
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ac2ece9e9c79..d42de8abd2b6 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -623,7 +623,7 @@ struct hstate {
>         unsigned int nr_huge_pages_node[MAX_NUMNODES];
>         unsigned int free_huge_pages_node[MAX_NUMNODES];
>         unsigned int surplus_huge_pages_node[MAX_NUMNODES];
> -#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +#ifdef CONFIG_HUGETLB_PAGE_HAS_OPTIMIZE_VMEMMAP
>         unsigned int optimize_vmemmap_pages;
>  #endif
>  #ifdef CONFIG_CGROUP_HUGETLB
> diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
> index 20d1079e92b4..00796794f177 100644
> --- a/include/linux/kconfig.h
> +++ b/include/linux/kconfig.h
> @@ -4,6 +4,10 @@
>
>  #include <generated/autoconf.h>
>
> +#if defined(__KERNEL__) && !defined(__EXCLUDE_AUTOCONF_EXT_H)
> +#include <generated/autoconf_ext.h>
> +#endif
> +


Please do not do this either.

When autoconf_ext.h is updated, the kernel tree
would be rebuilt entirely.





-- 
Best Regards
Masahiro Yamada
