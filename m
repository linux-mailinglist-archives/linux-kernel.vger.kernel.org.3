Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFA34965A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiAUTdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiAUTdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:33:35 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2C6C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 11:33:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id s5so2795938ejx.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 11:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kS6EYgGy/3I1cUTBgFRPzOWERNl1GV0paz/NAxK1bQE=;
        b=V+n5qn6LQ8xyNvutmR9RJdimzOmxDJ8l6U8j+p8YwcRPQQMhaaXHMVIq3l0L23d63f
         2p3CH9pF6vDLQYZwb6Alc9yBqPVVqOAKM9Ku+SArUiscLATV+hECHw0KiitUMx9MHyD+
         FQSkLWWu8M2DP+/rbvwYL3b9TxP8Ee08YqrPhZZ9zRkAgX9kfe4xYdITf3OJXdwu19P9
         riO08gHfcLRBCb0t+Hn6MYImRPyfw5yqx5ZqtQFlL1xgvJGLKSnESGmkwd/JwNIUD/W4
         TX9xAlAZfLPtT/716EAW5CjYQ90N0qokfmfL6pumUVkFK7vtgyLDQyXfou3QUjWFwd+e
         Dclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kS6EYgGy/3I1cUTBgFRPzOWERNl1GV0paz/NAxK1bQE=;
        b=DZEcMeOs2ShVcY25YCe0RMhl8zoXQTlMoLI7CYninQmuUl9xzKdtrH1rEEmBEhQYmU
         8q9Wbvwj3Al+oCxP0GcXMB5zgiZFzWkSWCWF64KoKUT/0vuwnImttKQpE5te4ubU9Jr4
         UvFLMcXhY4Gpb32NuKP6TxdLE7pkU2jjt5Y3L2PRO9PYElPXzMxnPdQfDnlQusT0nWnC
         OeVr1c6I/oaoDiOV22BO1pYkKUanag33VTKnC5xOBixYWW3HkfZvNPMXTjS9VX5Cl3r/
         rVg0lpWTiLbutQfTJ0BYUH+ult483nm7RNhUCruGdZpm7rYmyRUEaPJHxdDU/8l6g88I
         eTxA==
X-Gm-Message-State: AOAM531rYmmUTZ/Bq9HvPmKRJjtyMVKcvIbiXld94wjTuOnI4Hq/jfuZ
        G1/Au4aPiUNkeR9LkYMwdZt3tzXdnFVBAKjXWIc6rX7b4vqL/w==
X-Google-Smtp-Source: ABdhPJxv+RaTJLyhiujXL1VosFUSKZAsw1Vv/Vk3dYsnegOsm46C3ExY9qXy2NAwMN9UCTqPyXZwqXS++s3nARjOAMg=
X-Received: by 2002:a17:907:7d8a:: with SMTP id oz10mr4501367ejc.320.1642793612909;
 Fri, 21 Jan 2022 11:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20220120191250.2671557-1-pasha.tatashin@soleen.com>
 <20220120191250.2671557-3-pasha.tatashin@soleen.com> <CAAPL-u96G2DUvJ=wzHjR3LJvu-p432QKoHsCP-GjzZJWpXLe2w@mail.gmail.com>
In-Reply-To: <CAAPL-u96G2DUvJ=wzHjR3LJvu-p432QKoHsCP-GjzZJWpXLe2w@mail.gmail.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 21 Jan 2022 14:32:56 -0500
Message-ID: <CA+CK2bAFGgHMr9gg_QhCmXbYT05KbxaYSd43uENfaQx342dzZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm/page_table_check: check entries at pud and pmd levels
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Xu <weixugc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Fusion Future <qydwhotmail@gmail.com>,
        Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 2:19 PM Wei Xu <weixugc@google.com> wrote:
>
> On Thu, Jan 20, 2022 at 11:12 AM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > syzbot detected a case where the page table counters were not properly
> > updated.
> >
> > syzkaller login:  ------------[ cut here ]------------
> > kernel BUG at mm/page_table_check.c:162!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 3099 Comm: pasha Not tainted 5.16.0+ #48
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO4
> > RIP: 0010:__page_table_check_zero+0x159/0x1a0
> > Code: 7d 3a b2 ff 45 39 f5 74 2a e8 43 38 b2 ff 4d 85 e4 01
> > RSP: 0018:ffff888010667418 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000
> > RDX: ffff88800cea8680 RSI: ffffffff81becaf9 RDI: 0000000003
> > RBP: ffff888010667450 R08: 0000000000000001 R09: 0000000000
> > R10: ffffffff81becaab R11: 0000000000000001 R12: ffff888008
> > R13: 0000000000000001 R14: 0000000000000200 R15: dffffc0000
> > FS:  0000000000000000(0000) GS:ffff888035e00000(0000) knlG0
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007ffd875cad00 CR3: 00000000094ce000 CR4: 0000000000
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000
> > Call Trace:
> >  <TASK>
> >  free_pcp_prepare+0x3be/0xaa0
> >  free_unref_page+0x1c/0x650
> >  ? trace_hardirqs_on+0x6a/0x1d0
> >  free_compound_page+0xec/0x130
> >  free_transhuge_page+0x1be/0x260
> >  __put_compound_page+0x90/0xd0
> >  release_pages+0x54c/0x1060
> >  ? filemap_remove_folio+0x161/0x210
> >  ? lock_downgrade+0x720/0x720
> >  ? __put_page+0x150/0x150
> >  ? filemap_free_folio+0x164/0x350
> >  __pagevec_release+0x7c/0x110
> >  shmem_undo_range+0x85e/0x1250
> > ...
> >
> > The repro involved having a huge page that is split due to uprobe event
> > temporarily replacing one of the pages in the huge page. Later the huge
> > page was combined again, but the counters were off, as the PTE level
> > was not properly updated.
> >
> > Make sure that not only huge page but also small pages are updated when
> > a new entry is set or cleared.
> >
> > Fixes: df4e817b7108 ("mm: page table check")
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  mm/page_table_check.c | 60 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 36 insertions(+), 24 deletions(-)
> >
> > diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> > index 7504e7caa2a1..877d967742bc 100644
> > --- a/mm/page_table_check.c
> > +++ b/mm/page_table_check.c
> > @@ -145,6 +145,30 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
> >         }
> >  }
> >
> > +static void pte_clear_level(struct mm_struct *mm, unsigned long addr,
> > +                           pte_t *ptep)
> > +{
> > +       unsigned long i;
> > +
> > +       for (i = 0; i < PTRS_PER_PTE; i++) {
> > +               __page_table_check_pte_clear(mm, addr, *ptep);
> > +               addr += PAGE_SIZE;
> > +               ptep++;
> > +       }
> > +}
> > +
> > +static void pmd_clear_level(struct mm_struct *mm, unsigned long addr,
> > +                           pmd_t *pmdp)
> > +{
> > +       unsigned long i;
> > +
> > +       for (i = 0; i < PTRS_PER_PMD; i++) {
> > +               __page_table_check_pmd_clear(mm, addr, *pmdp);
> > +               addr += PMD_PAGE_SIZE;
> > +               pmdp++;
> > +       }
> > +}
> > +
> >  /*
> >   * page is on free list, or is being allocated, verify that counters are zeroes
> >   * crash if they are not.
> > @@ -186,6 +210,11 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
> >         if (pmd_user_accessible_page(pmd)) {
> >                 page_table_check_clear(mm, addr, pmd_pfn(pmd),
> >                                        PMD_PAGE_SIZE >> PAGE_SHIFT);
> > +       } else if (!pmd_bad(pmd) && !pmd_leaf(pmd)) {
> > +               pte_t *ptep = pte_offset_map(&pmd, addr);
> > +
> > +               pte_clear_level(mm, addr, ptep);
> > +               pte_unmap(ptep);
> >         }
> >  }
> >  EXPORT_SYMBOL(__page_table_check_pmd_clear);
> > @@ -199,6 +228,10 @@ void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
> >         if (pud_user_accessible_page(pud)) {
> >                 page_table_check_clear(mm, addr, pud_pfn(pud),
> >                                        PUD_PAGE_SIZE >> PAGE_SHIFT);
> > +       } else if (!pud_bad(pud) && !pud_leaf(pud)) {
> > +               pmd_t *pmdp = pmd_offset(&pud, addr);
> > +
> > +               pmd_clear_level(mm, addr, pmdp);
> >         }
> >  }
> >  EXPORT_SYMBOL(__page_table_check_pud_clear);
> > @@ -206,17 +239,10 @@ EXPORT_SYMBOL(__page_table_check_pud_clear);
> >  void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
> >                                 pte_t *ptep, pte_t pte)
> >  {
> > -       pte_t old_pte;
> > -
> >         if (&init_mm == mm)
> >                 return;
> >
> > -       old_pte = *ptep;
> > -       if (pte_user_accessible_page(old_pte)) {
> > -               page_table_check_clear(mm, addr, pte_pfn(old_pte),
> > -                                      PAGE_SIZE >> PAGE_SHIFT);
> > -       }
> > -
> > +       __page_table_check_pte_clear(mm, addr, *ptep);
> >         if (pte_user_accessible_page(pte)) {
> >                 page_table_check_set(mm, addr, pte_pfn(pte),
> >                                      PAGE_SIZE >> PAGE_SHIFT,
> > @@ -228,17 +254,10 @@ EXPORT_SYMBOL(__page_table_check_pte_set);
> >  void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
> >                                 pmd_t *pmdp, pmd_t pmd)
> >  {
> > -       pmd_t old_pmd;
> > -
> >         if (&init_mm == mm)
> >                 return;
> >
> > -       old_pmd = *pmdp;
> > -       if (pmd_user_accessible_page(old_pmd)) {
> > -               page_table_check_clear(mm, addr, pmd_pfn(old_pmd),
> > -                                      PMD_PAGE_SIZE >> PAGE_SHIFT);
> > -       }
> > -
> > +       __page_table_check_pmd_clear(mm, addr, *pmdp);
> >         if (pmd_user_accessible_page(pmd)) {
> >                 page_table_check_set(mm, addr, pmd_pfn(pmd),
> >                                      PMD_PAGE_SIZE >> PAGE_SHIFT,
> > @@ -250,17 +269,10 @@ EXPORT_SYMBOL(__page_table_check_pmd_set);
> >  void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
> >                                 pud_t *pudp, pud_t pud)
> >  {
> > -       pud_t old_pud;
> > -
> >         if (&init_mm == mm)
> >                 return;
> >
> > -       old_pud = *pudp;
> > -       if (pud_user_accessible_page(old_pud)) {
> > -               page_table_check_clear(mm, addr, pud_pfn(old_pud),
> > -                                      PUD_PAGE_SIZE >> PAGE_SHIFT);
> > -       }
> > -
> > +       __page_table_check_pud_clear(mm, addr, *pudp);
> >         if (pud_user_accessible_page(pud)) {
> >                 page_table_check_set(mm, addr, pud_pfn(pud),
> >                                      PUD_PAGE_SIZE >> PAGE_SHIFT,
> > --
> > 2.34.1.703.g22d0c6ccf7-goog
> >
>
> Reviewed-by: Wei Xu <weixugc@google.com>

Andrew, please hold off on taking this patch. During testing, I have
found that the proposed fix does not work with khugepaged: we have
double clearing of PTE: first remove PMD entry and clear PTEs, but
later clear PTEs again in __collapse_huge_page_copy(). I am looking
for a more complete fix.

Thanks,
Pasha
