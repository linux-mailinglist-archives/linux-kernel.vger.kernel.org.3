Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5084A5051
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377191AbiAaUjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359828AbiAaUjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:39:37 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AEBC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:39:36 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y84so18639637iof.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I09kGZuDXY6ULArH1WErvvJyPT9tJZxecehDHIw37pM=;
        b=AC8riDxOuyYPxSt26pzwpo13BBUYyTVl9ElYZWBYoZacyPGLEe1QU2aS7MfKW+h+v6
         y+RHs+LwePtLtHvevtffBQuj+oiQ3k9ZNkORMEkqZlvLn33vO1X46AOoUFre4YAYT6Bh
         mhWRkllIj33LO9EjNF0JfB46eqqzfFDPpMPPlSO57M6b8qVVarpK+42OpRsyfLfLVc9i
         q/RFZwPMe4D5tMt81hHAnhKmy3r9FgIlgkado77rMRI1Flh3+gBxl/dq+MhkXN07sF4+
         SeMu9KLaiWgmFr+V7wslbabNvXdOWeKT2pX7xxIHGSNmNYqeFP5g6tf5ehoWzy79agXn
         orfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I09kGZuDXY6ULArH1WErvvJyPT9tJZxecehDHIw37pM=;
        b=KKidC/7lf9eW4LebnKy9gTXxYRg3ILzHcbEfKhMNCg82UsY5t95TV1RwRePab6PGef
         dznkI5NxodFDn+9UlFN3RGsuIlc6m0Ivuh1K1KvYO/ijTCJu6MdLq9ywBTP372aq/Deb
         4GJ0tggyFHYziuWJ8xlhRitoXpLhHmQOAzTI87HICv+GTth4Rk4q4uwpqvPAZyKIhDy8
         Lo/jOtra4sD6IXnHirLtdhgpCe1Hw+hjqWxKZbiAk4oQ4Eis6BY/wY7P0XftURug3O+s
         3OgFOTEV+rHup7E2gR+FSnSPSetsSH0PBEbV+7LS+/JX/rRcQqloZ4Bs+xyzIty3fADu
         N2nw==
X-Gm-Message-State: AOAM530nWrwQwvgYQGK2XpTTI/Yu7wilm41Bwv0jJK8dfbKciv65/nEO
        cZKwukmc1lAXz1L775Hdi8CFVyTMqMZMuE1O4Nfwkw==
X-Google-Smtp-Source: ABdhPJz5XaZnN3j1SV4Y2mhnYtaYB52OKcTs962yH3S2Gw/cNz1vdOvTVAnKNI9Aab1C4VYmkb6XzzkQEXvy0iIkH4A=
X-Received: by 2002:a05:6638:134a:: with SMTP id u10mr3504891jad.264.1643661576144;
 Mon, 31 Jan 2022 12:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20220131203249.2832273-1-pasha.tatashin@soleen.com> <20220131203249.2832273-5-pasha.tatashin@soleen.com>
In-Reply-To: <20220131203249.2832273-5-pasha.tatashin@soleen.com>
From:   Wei Xu <weixugc@google.com>
Date:   Mon, 31 Jan 2022 12:39:25 -0800
Message-ID: <CAAPL-u-hgQ6iKKi3VG4iz22B_VDWQEF5YaRabKdJa3187LfjSw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm/page_table_check: check entries at pmd levels
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

On Mon, Jan 31, 2022 at 12:33 PM Pasha Tatashin
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
> Acked-by: David Rientjes <rientjes@google.com>
> ---
>  include/linux/page_table_check.h | 19 +++++++++++++++++++
>  mm/khugepaged.c                  |  3 +++
>  mm/page_table_check.c            | 20 ++++++++++++++++++++
>  3 files changed, 42 insertions(+)
>
> diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
> index 38cace1da7b6..01e16c7696ec 100644
> --- a/include/linux/page_table_check.h
> +++ b/include/linux/page_table_check.h
> @@ -26,6 +26,9 @@ void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
>                                 pmd_t *pmdp, pmd_t pmd);
>  void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
>                                 pud_t *pudp, pud_t pud);
> +void __page_table_check_pte_clear_range(struct mm_struct *mm,
> +                                       unsigned long addr,
> +                                       pmd_t pmd);
>
>  static inline void page_table_check_alloc(struct page *page, unsigned int order)
>  {
> @@ -100,6 +103,16 @@ static inline void page_table_check_pud_set(struct mm_struct *mm,
>         __page_table_check_pud_set(mm, addr, pudp, pud);
>  }
>
> +static inline void page_table_check_pte_clear_range(struct mm_struct *mm,
> +                                                   unsigned long addr,
> +                                                   pmd_t pmd)
> +{
> +       if (static_branch_likely(&page_table_check_disabled))
> +               return;
> +
> +       __page_table_check_pte_clear_range(mm, addr, pmd);
> +}
> +
>  #else
>
>  static inline void page_table_check_alloc(struct page *page, unsigned int order)
> @@ -143,5 +156,11 @@ static inline void page_table_check_pud_set(struct mm_struct *mm,
>  {
>  }
>
> +static inline void page_table_check_pte_clear_range(struct mm_struct *mm,
> +                                                   unsigned long addr,
> +                                                   pmd_t pmd)
> +{
> +}
> +
>  #endif /* CONFIG_PAGE_TABLE_CHECK */
>  #endif /* __LINUX_PAGE_TABLE_CHECK_H */
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 30e59e4af272..131492fd1148 100644
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
> +       page_table_check_pte_clear_range(mm, addr, pmd);
>         pte_free(mm, pmd_pgtable(pmd));
>  }
>
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index c61d7ebe13b1..3763bd077861 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -247,3 +247,23 @@ void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
>         }
>  }
>  EXPORT_SYMBOL(__page_table_check_pud_set);
> +
> +void __page_table_check_pte_clear_range(struct mm_struct *mm,
> +                                       unsigned long addr,
> +                                       pmd_t pmd)
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
> +       }
> +}

Reviewed-by: Wei Xu <weixugc@google.com>

> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
