Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FE54953C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiATR73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiATR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:59:28 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C9CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:59:28 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id r15so5649470ilj.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olKTK4E7rnzDOPyckSz6ZdRJXAxXk+8QKjsKEZMD6v0=;
        b=R8LOCl6YgjsAbk/+kw+5T5ZO3lEIw+yX+p/0/ORMMAzmDDP4Cn3UGfN4L9XHQjnGao
         Ah3a9AZTl8bzwhkmBNIu5OAcAKgdxCsg9JbkjpBorn7J4yrK8RZrVl9rZRcjleImuCcW
         JkVF0pyDqNQGPab0JxHwfdwK75D+Kr3PDZ/bPRkf+PQf5q4sF7G1Jg/uCbcFJ6tUOJOX
         G7YU+l8tsec+jokIXUxx9yVkoRfYsFDHNZO07DZ/2XiPrqVb5QvBBLNLDY891FlkmNAP
         qT5bAqODuEiX6x2GWUS1WW/eAijc4nUUTLQb5m2GozNXlhgjuM5y4rBgv0gHnqzIIGWb
         4U4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olKTK4E7rnzDOPyckSz6ZdRJXAxXk+8QKjsKEZMD6v0=;
        b=H3Tyv7Pd7yXLI/5Vbot6bZAYcpJSniQrkYoemnnu1GnKT4Ip8/2w2dpMAYeb7iD/vK
         KANGumpWe/b9qWaGdlQyD83icMaol9jlD7ncUNYzKk8mAJfK7+lGL4nG4N3WpR2tIqsN
         BvtOmyfPkWlYlYBsNhAWkAWwZwtUGpe+eYgnMsI0KPNErlrjsFIaNcciTMEHO3TpthZD
         q1PKMEyrDv6KkNgdOyoSzOUweQQX/NYoJGT+VPnudc1G0c9O3yvkiVVWrhAtl98qJP20
         kIQOqJYh+1jlL0ER7baKb2qwk+/bBlBAuFKK9hsdDOdy0aQQJVuXLLLjnT65X3913Nns
         UUog==
X-Gm-Message-State: AOAM532B41UmuOoqmkJz7m4mh+g3j0lsEaExofrSDyk0jD08kIbDHu8X
        HYBmsc1IUFy+/d4+Rx6eaP6IvwAeHRYiGmvveVIW5Q==
X-Google-Smtp-Source: ABdhPJz8KHebSjKljU5LAsR1iu6upkp/y2rltHrXVj5oLl8TePddpIs+lkK6zJdKMXxgJk7CBpHqy9FXvUZvRdkjtv4=
X-Received: by 2002:a05:6e02:17c5:: with SMTP id z5mr48740ilu.73.1642701567303;
 Thu, 20 Jan 2022 09:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20220120042513.1648831-1-pasha.tatashin@soleen.com> <20220120042513.1648831-3-pasha.tatashin@soleen.com>
In-Reply-To: <20220120042513.1648831-3-pasha.tatashin@soleen.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 20 Jan 2022 09:59:16 -0800
Message-ID: <CAAPL-u_kP5E5iOtyztsXLJG0YNFzganD3djr2nW0vTkUpv=A9Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/page_table_check: check entries at pud and pmd levels
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, Greg Thelen <gthelen@google.com>,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com,
        Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
        anshuman.khandual@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 8:25 PM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> syzbot detected a case where the page table counters were not properly
> updated.
>
> syzkaller login:  ------------[ cut here ]------------
> kernel BUG at mm/page_table_check.c:162!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 3099 Comm: pasha Not tainted 5.16.0+ #48
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO4
> RIP: 0010:__page_table_check_zero+0x159/0x1a0
> Code: 7d 3a b2 ff 45 39 f5 74 2a e8 43 38 b2 ff 4d 85 e4 01
> RSP: 0018:ffff888010667418 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000
> RDX: ffff88800cea8680 RSI: ffffffff81becaf9 RDI: 0000000003
> RBP: ffff888010667450 R08: 0000000000000001 R09: 0000000000
> R10: ffffffff81becaab R11: 0000000000000001 R12: ffff888008
> R13: 0000000000000001 R14: 0000000000000200 R15: dffffc0000
> FS:  0000000000000000(0000) GS:ffff888035e00000(0000) knlG0
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd875cad00 CR3: 00000000094ce000 CR4: 0000000000
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000
> Call Trace:
>  <TASK>
>  free_pcp_prepare+0x3be/0xaa0
>  free_unref_page+0x1c/0x650
>  ? trace_hardirqs_on+0x6a/0x1d0
>  free_compound_page+0xec/0x130
>  free_transhuge_page+0x1be/0x260
>  __put_compound_page+0x90/0xd0
>  release_pages+0x54c/0x1060
>  ? filemap_remove_folio+0x161/0x210
>  ? lock_downgrade+0x720/0x720
>  ? __put_page+0x150/0x150
>  ? filemap_free_folio+0x164/0x350
>  __pagevec_release+0x7c/0x110
>  shmem_undo_range+0x85e/0x1250
> ...
>
> The repro involved having a huge page that is split due to uprobe event
> temporarily replacing one of the pages in the huge page. Later the huge
> page was combined again, but the counters were off, as the PTE level
> was not properly updated.
>
> Make sure that not only huge page but also small pages are updated when
> a new entry is set or cleared.
>
> Fixes: df4e817b7108 ("mm: page table check")
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  mm/page_table_check.c | 52 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 7504e7caa2a1..2341ac382cd5 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -145,6 +145,40 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
>         }
>  }
>
> +static void pte_clear_level(struct mm_struct *mm, unsigned long addr,
> +                           pte_t *ptep)
> +{
> +       unsigned long i;
> +
> +       for (i = 0; i < PTRS_PER_PTE; i++) {
> +               __page_table_check_pte_clear(mm, addr, *ptep);
> +               addr += PAGE_SIZE;
> +               ptep++;
> +       }
> +}
> +
> +static void pmd_clear_level(struct mm_struct *mm, unsigned long addr,
> +                           pmd_t *pmdp)
> +{
> +       unsigned long i;
> +
> +       for (i = 0; i < PTRS_PER_PMD; i++) {
> +               pmd_t old_pmd = *pmdp;
> +
> +               if (pmd_user_accessible_page(old_pmd)) {
> +                       page_table_check_clear(mm, addr, pmd_pfn(old_pmd),
> +                                              PMD_PAGE_SIZE >> PAGE_SHIFT);
> +               } else if (!pmd_bad(old_pmd) && !pmd_leaf(old_pmd)) {
> +                       pte_t *ptep = pte_offset_map(&old_pmd, addr);
> +
> +                       pte_clear_level(mm, addr, ptep);
> +                       pte_unmap(ptep);
> +               }

You can call __page_table_check_pmd_clear(mm, addr, old_pmd, addr)
instead to share the new code.

>
> +               addr += PMD_PAGE_SIZE;
> +               pmdp++;
> +       }
> +}
> +
>  /*
>   * page is on free list, or is being allocated, verify that counters are zeroes
>   * crash if they are not.
> @@ -186,6 +220,11 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
>         if (pmd_user_accessible_page(pmd)) {
>                 page_table_check_clear(mm, addr, pmd_pfn(pmd),
>                                        PMD_PAGE_SIZE >> PAGE_SHIFT);
> +       } else if (!pmd_bad(pmd) && !pmd_leaf(pmd)) {
> +               pte_t *ptep = pte_offset_map(&pmd, addr);
> +
> +               pte_clear_level(mm, addr, ptep);
> +               pte_unmap(ptep);
>         }
>  }
>  EXPORT_SYMBOL(__page_table_check_pmd_clear);
> @@ -199,6 +238,10 @@ void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
>         if (pud_user_accessible_page(pud)) {
>                 page_table_check_clear(mm, addr, pud_pfn(pud),
>                                        PUD_PAGE_SIZE >> PAGE_SHIFT);
> +       } else if (!pud_bad(pud) && !pud_leaf(pud)) {
> +               pmd_t *pmdp = pmd_offset(&pud, addr);
> +
> +               pmd_clear_level(mm, addr, pmdp);
>         }
>  }
>  EXPORT_SYMBOL(__page_table_check_pud_clear);
> @@ -237,6 +280,11 @@ void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
>         if (pmd_user_accessible_page(old_pmd)) {
>                 page_table_check_clear(mm, addr, pmd_pfn(old_pmd),
>                                        PMD_PAGE_SIZE >> PAGE_SHIFT);
> +       } else if (!pmd_bad(old_pmd) && !pmd_leaf(old_pmd)) {
> +               pte_t *ptep = pte_offset_map(&old_pmd, addr);
> +
> +               pte_clear_level(mm, addr, ptep);
> +               pte_unmap(ptep);
>         }
>

How about replacing the above code with
__page_table_check_pmd_clear(mm, addr, old_pmd)?

>         if (pmd_user_accessible_page(pmd)) {
> @@ -259,6 +307,10 @@ void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
>         if (pud_user_accessible_page(old_pud)) {
>                 page_table_check_clear(mm, addr, pud_pfn(old_pud),
>                                        PUD_PAGE_SIZE >> PAGE_SHIFT);
> +       } else if (!pud_bad(old_pud) && !pud_leaf(old_pud)) {
> +               pmd_t *pmdp = pmd_offset(&old_pud, addr);
> +
> +               pmd_clear_level(mm, addr, pmdp);
>         }

Replacing with __page_table_check_pud_clear(mm, addr, old_pud)?
>
>
>
>         if (pud_user_accessible_page(pud)) {
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
