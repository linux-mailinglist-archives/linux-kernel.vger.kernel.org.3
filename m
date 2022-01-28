Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B674A044A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350594AbiA1XjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiA1XjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:39:13 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29239C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 15:39:13 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id o10so6830732ilh.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 15:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSoeKVGmRxEg8tOZhtYJB1etT9XFRjTuGXZeWmf9w+0=;
        b=BrzznfTryT3w3P6cPNQ0V/uOTme8La+zktEYxT20NRFBO3X+DJr/13ALQCWj1Kjyhv
         kdYEazcEfZ2K80oPUrpsaOejDKXTyfJ/EQziUZMJ0UG8uQM2ZLk3jlHrpmyvku+M93P3
         RSu9mWImS4H9hkJx9QVC4Zlh2TfQunT92dYf2YZaS+7Ar8ydhtk4wagLlsyMG3itdzNL
         ELHTGA+1KaZN7AOxrPxSgVPWS9PDz2+xdYNdZCCfyFWmJbw6e3qwx257066LmAnxUIKM
         bbjKk6V4pV0y3ohZb7F5kD9l+gVXQKA9Qrsw3mWEUDPxN6s3mimOTDsm3ZRLSQwnNYT2
         Xxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSoeKVGmRxEg8tOZhtYJB1etT9XFRjTuGXZeWmf9w+0=;
        b=6xjIbwxOyeT3T0BNZJpHl6AEhMvcdV249Q8UtOMd7MxC6J/FAIEqhu8OGYnnMY/iSC
         89ySW/aKsycNX86XcIO5rcAnrGsoYOb7c6ArxGVhQcbBGsQ+T3zh8g4T54k7e6dOKwaP
         Jzjk71Wd4xlG5e3oalqiLjSNBdoheNaCNrn43rn+4Y7Iigpak6Pel4PL8qdUQpgH7jtE
         R/03DFydIZ/NlWa1vaZJlDfJaqaeOxk9TWxyret9GuURk14SYB97xLk0genHbU8O8r2j
         gH09DIy8l0hvwml5HLNW+yxgdUcWSHZEC9ROUle5YlIg/BT23dF9PvvO8euZqbnLZ+g/
         TTmQ==
X-Gm-Message-State: AOAM531nKSxoWQ0hceo5FOzDZCYhaBiMqgA4XiWjLwtxH19ByXyDI53C
        JLhj+aVr/cMsyWR6gz0omIwoP0NLQIDv/UNP54jG8Q==
X-Google-Smtp-Source: ABdhPJzG9F2/sgqDm1NImlbDTFl47M9Ma89dENPnxqzo/P9DxBAwz4qYv5vPd1DbQABP8qx/rII/w3+smiTQooixux8=
X-Received: by 2002:a05:6e02:19c5:: with SMTP id r5mr5209733ill.164.1643413152318;
 Fri, 28 Jan 2022 15:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20220126183637.1840960-1-pasha.tatashin@soleen.com> <20220126183637.1840960-5-pasha.tatashin@soleen.com>
In-Reply-To: <20220126183637.1840960-5-pasha.tatashin@soleen.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 28 Jan 2022 15:39:01 -0800
Message-ID: <CAAPL-u-yo4LuFdudYMEccUYTOMpvnqEjzMZRjOhUBkR4t=BSDw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm/page_table_check: check entries at pmd levels
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

On Wed, Jan 26, 2022 at 10:36 AM Pasha Tatashin
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
> Make sure that when PMD is cleared and prior to freeing the level the
> PTEs are updated.
>
> Fixes: df4e817b7108 ("mm: page table check")
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/page_table_check.h | 18 ++++++++++++++++++
>  mm/khugepaged.c                  |  3 +++
>  mm/page_table_check.c            | 21 +++++++++++++++++++++
>  3 files changed, 42 insertions(+)
>
> diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
> index 38cace1da7b6..e88bbe37727b 100644
> --- a/include/linux/page_table_check.h
> +++ b/include/linux/page_table_check.h
> @@ -26,6 +26,8 @@ void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
>                                 pmd_t *pmdp, pmd_t pmd);
>  void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
>                                 pud_t *pudp, pud_t pud);
> +void __page_table_check_pmd_clear_full(struct mm_struct *mm, unsigned long addr,
> +                                      pmd_t pmd);
>
>  static inline void page_table_check_alloc(struct page *page, unsigned int order)
>  {
> @@ -100,6 +102,16 @@ static inline void page_table_check_pud_set(struct mm_struct *mm,
>         __page_table_check_pud_set(mm, addr, pudp, pud);
>  }
>
> +static inline void page_table_check_pmd_clear_full(struct mm_struct *mm,
> +                                                  unsigned long addr,
> +                                                  pmd_t pmd)
> +{
> +       if (static_branch_likely(&page_table_check_disabled))
> +               return;
> +
> +       __page_table_check_pmd_clear_full(mm, addr, pmd);
> +}
> +
>  #else
>
>  static inline void page_table_check_alloc(struct page *page, unsigned int order)
> @@ -143,5 +155,11 @@ static inline void page_table_check_pud_set(struct mm_struct *mm,
>  {
>  }
>
> +static inline void page_table_check_pmd_clear_full(struct mm_struct *mm,
> +                                                  unsigned long addr,
> +                                                  pmd_t pmd)
> +{
> +}
> +
>  #endif /* CONFIG_PAGE_TABLE_CHECK */
>  #endif /* __LINUX_PAGE_TABLE_CHECK_H */
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 30e59e4af272..d84977c6dc0d 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -16,6 +16,7 @@
>  #include <linux/hashtable.h>
>  #include <linux/userfaultfd_k.h>
>  #include <linux/page_idle.h>
> +#include <linux/page_table_check.h>
>  #include <linux/swapops.h>
>  #include <linux/shmem_fs.h>
>
> @@ -1422,10 +1423,12 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
>         spinlock_t *ptl;
>         pmd_t pmd;
>
> +       mmap_assert_write_locked(mm);
>         ptl = pmd_lock(vma->vm_mm, pmdp);
>         pmd = pmdp_collapse_flush(vma, addr, pmdp);
>         spin_unlock(ptl);
>         mm_dec_nr_ptes(mm);
> +       page_table_check_pmd_clear_full(mm, addr, pmd);

pmdp_collapse_flush() already calls page_table_check_pmd_clear() via
pmdp_huge_get_and_clean().  Both pmdp_table_check_pmd_clear() and
page_table_check_pmd_clear_full() can call
__page_table_check_pmd_clear(). If that happens, then the page table
check counters can be messed up.  Certainly, there is no bug here
because the pmd is not huge and __page_table_check_pmd_clear() should
be skipped in both calls. But it would be better to avoid this
unnecessary subtlety by renaming page_table_check_pmd_clear_full() to
page_table_check_clear_pte_range() and not calling
__page_table_check_pmd_clear() there.  To make the code even more
clear, __page_table_check_pmd_clear() can also be renamed as
__page_table_check_huge_pmd_clear() (similar for its callers).

>         pte_free(mm, pmd_pgtable(pmd));
>  }
>
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index c61d7ebe13b1..251f95a808b4 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -247,3 +247,24 @@ void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
>         }
>  }
>  EXPORT_SYMBOL(__page_table_check_pud_set);
> +
> +void __page_table_check_pmd_clear_full(struct mm_struct *mm, unsigned long addr,
> +                                      pmd_t pmd)
> +{
> +       if (&init_mm == mm)
> +               return;
> +
> +       if (!pmd_bad(pmd) && !pmd_leaf(pmd)) {
> +               pte_t *ptep = pte_offset_map(&pmd, addr);
> +               unsigned long i;
> +
> +               pte_unmap(ptep);
> +               for (i = 0; i < PTRS_PER_PTE; i++) {
> +                       __page_table_check_pte_clear(mm, addr, *ptep);
> +                       addr += PAGE_SIZE;
> +                       ptep++;
> +               }
> +       } else {
> +               __page_table_check_pmd_clear(mm, addr, pmd);
> +       }
> +}
> --
> 2.35.0.rc0.227.g00780c9af4-goog
>
