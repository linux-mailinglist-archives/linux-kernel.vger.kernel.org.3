Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B1B546B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349352AbiFJRDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbiFJRC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:02:56 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A093630A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:02:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e66so25311363pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GcznnB4VKkJTYiRqNbgfeKIquPOAmsAs+VLFGPS1x28=;
        b=fhnHi94hOu4GWkiox3fVtlAGNhnZpwJskhSzSJBP3gh1xKzEdQhCeesk4aq3Z0uwN1
         SOkk1uKIVG/Zwq2FYDmKATqoTw7jqAXmaDkoI+0AaiZUrzi7lsWJufduminYIuZ2KeZ3
         zVfzvcg0VGatysxBQXOVKTMyN4ocecXn2d449Hh/NUrs68oP5rg+o+d/SSLkWLfZTOKk
         PTmKB5ru8rxb94buYF1xTY6QoGAeibzV2Afc/Qx1pH02OoaPygYDR8p3af01sG+IJm8j
         t2RsbIH98t6QvAxEdGBank4OfI+s0Az4QF1PcBf/sC7sQXjVijJitPZWoakTIBAN2ne4
         GCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcznnB4VKkJTYiRqNbgfeKIquPOAmsAs+VLFGPS1x28=;
        b=WfCsM8up8JkJyOzxOxa7Up4RLXCo6d0tYwKVaKqBXWk/YZTHM8uYpDnH1Jo6g7mmiH
         CgUAQfZwBLPiR3s0e9eF2M1xk8W45wv5dzQ7DlgA8mQjPuERL0FShukH2BoQ9g+mWvAB
         PoDnbrdlmKcxD46Alltq75BSmtzmtn5z7UDRxxuD6KvYdvgcgF/Qggv/CrhmRq8CsJlb
         BeKmqEujs+j9kWwCtZuooRuUJ55rzzx+RY8Bfb7aIT0OyVu+nf9aihSp/apLIEG6U2tr
         5yGc+fOWf7DLt1aMLRoUqL4+7399A01A0ZEerxH/HlBq6VhFlCTH5U6zL3O1l9+RQ7/8
         zWAw==
X-Gm-Message-State: AOAM530lfAwCI03sUqcl6Q0v/DpC9ZVKIhzbirkrCq/Gq2OZlzwI2lj1
        eiwyGaYD75bKXRFnmlNHqAg4rUZReH6g3cKXWtk=
X-Google-Smtp-Source: ABdhPJyKgEScNDphniAgfGz1jSrvQ4MI/HwGU5gbDS5HUQgrOawbioL6lEp8FZc4yzGVDrSrcR9DAYZIovl3jwwjd6c=
X-Received: by 2002:a63:3183:0:b0:3fd:6797:70a8 with SMTP id
 x125-20020a633183000000b003fd679770a8mr29109893pgx.206.1654880571483; Fri, 10
 Jun 2022 10:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-6-shy828301@gmail.com>
 <CAAa6QmSE7U69JJ8SwNwBgdEYhyjHUWVw9tf8=sp1a6djYigLiA@mail.gmail.com>
In-Reply-To: <CAAa6QmSE7U69JJ8SwNwBgdEYhyjHUWVw9tf8=sp1a6djYigLiA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 10 Jun 2022 10:02:39 -0700
Message-ID: <CAHbLzkr96xwTWZ=fQPPi6BNyrhrzP=1g8Ucn7gahBpD9PUCSTw@mail.gmail.com>
Subject: Re: [v3 PATCH 5/7] mm: thp: kill transparent_hugepage_active()
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jun 9, 2022 at 6:03 PM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > The transparent_hugepage_active() was introduced to show THP eligibility
> > bit in smaps in proc, smaps is the only user.  But it actually does the
> > similar check as hugepage_vma_check() which is used by khugepaged.  We
> > definitely don't have to maintain two similar checks, so kill
> > transparent_hugepage_active().
>
> I never realized smaps was the only user! Great!
>
> > Also move hugepage_vma_check() to huge_memory.c and huge_mm.h since it
> > is not only for khugepaged anymore.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  fs/proc/task_mmu.c         |  2 +-
> >  include/linux/huge_mm.h    | 16 +++++++-----
> >  include/linux/khugepaged.h |  4 +--
> >  mm/huge_memory.c           | 50 ++++++++++++++++++++++++++++++++-----
> >  mm/khugepaged.c            | 51 +++-----------------------------------
> >  5 files changed, 60 insertions(+), 63 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 2dd8c8a66924..fd79566e204c 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -860,7 +860,7 @@ static int show_smap(struct seq_file *m, void *v)
> >         __show_smap(m, &mss, false);
> >
> >         seq_printf(m, "THPeligible:    %d\n",
> > -                  transparent_hugepage_active(vma));
> > +                  hugepage_vma_check(vma, vma->vm_flags, true));
> >
> >         if (arch_pkeys_enabled())
> >                 seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 79d5919beb83..f561c3e16def 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -209,7 +209,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
> >                !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
> >  }
> >
> > -bool transparent_hugepage_active(struct vm_area_struct *vma);
> > +bool hugepage_vma_check(struct vm_area_struct *vma,
> > +                       unsigned long vm_flags,
> > +                       bool smaps);
> >
> >  #define transparent_hugepage_use_zero_page()                           \
> >         (transparent_hugepage_flags &                                   \
> > @@ -358,11 +360,6 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> >         return false;
> >  }
> >
> > -static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
> > -{
> > -       return false;
> > -}
> > -
> >  static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> >  {
> >         return false;
> > @@ -380,6 +377,13 @@ static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> >         return false;
> >  }
> >
> > +static inline bool hugepage_vma_check(struct vm_area_struct *vma,
> > +                                      unsigned long vm_flags,
> > +                                      bool smaps)
> > +{
> > +       return false;
> > +}
> > +
> >  static inline void prep_transhuge_page(struct page *page) {}
> >
> >  #define transparent_hugepage_flags 0UL
> > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > index 392d34c3c59a..8a6452e089ca 100644
> > --- a/include/linux/khugepaged.h
> > +++ b/include/linux/khugepaged.h
> > @@ -10,8 +10,6 @@ extern struct attribute_group khugepaged_attr_group;
> >  extern int khugepaged_init(void);
> >  extern void khugepaged_destroy(void);
> >  extern int start_stop_khugepaged(void);
> > -extern bool hugepage_vma_check(struct vm_area_struct *vma,
> > -                              unsigned long vm_flags);
> >  extern void __khugepaged_enter(struct mm_struct *mm);
> >  extern void __khugepaged_exit(struct mm_struct *mm);
> >  extern void khugepaged_enter_vma(struct vm_area_struct *vma,
> > @@ -57,7 +55,7 @@ static inline void khugepaged_enter(struct vm_area_struct *vma,
> >  {
> >         if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> >             khugepaged_enabled()) {
> > -               if (hugepage_vma_check(vma, vm_flags))
> > +               if (hugepage_vma_check(vma, vm_flags, false))
> >                         __khugepaged_enter(vma->vm_mm);
> >         }
> >  }
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 36ada544e494..bc8370856e85 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -69,18 +69,56 @@ static atomic_t huge_zero_refcount;
> >  struct page *huge_zero_page __read_mostly;
> >  unsigned long huge_zero_pfn __read_mostly = ~0UL;
> >
> > -bool transparent_hugepage_active(struct vm_area_struct *vma)
> > +bool hugepage_vma_check(struct vm_area_struct *vma,
> > +                       unsigned long vm_flags,
> > +                       bool smaps)
> >  {
> > +       if (!transhuge_vma_enabled(vma, vm_flags))
> > +               return false;
> > +
> > +       if (vm_flags & VM_NO_KHUGEPAGED)
> > +               return false;
> > +
> > +       /* Don't run khugepaged against DAX vma */
> > +       if (vma_is_dax(vma))
> > +               return false;
> > +
> > +       if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
> > +                               vma->vm_pgoff, HPAGE_PMD_NR))
> > +               return false;
> > +
> >         if (!transhuge_vma_size_ok(vma))
> >                 return false;
> > -       if (vma_is_anonymous(vma))
> > -               return __transparent_hugepage_enabled(vma);
> > -       if (vma_is_shmem(vma))
> > +
> > +       /* Enabled via shmem mount options or sysfs settings. */
> > +       if (shmem_file(vma->vm_file))
> >                 return shmem_huge_enabled(vma);
> > -       if (transhuge_vma_enabled(vma, vma->vm_flags) && file_thp_enabled(vma))
> > +
> > +       if (!khugepaged_enabled())
> > +               return false;
> > +
> > +       /* THP settings require madvise. */
> > +       if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
> > +               return false;
> > +
> > +       /* Only regular file is valid */
> > +       if (file_thp_enabled(vma))
> >                 return true;
> >
> > -       return false;
> > +       if (!vma_is_anonymous(vma))
> > +               return false;
> > +
> > +       if (vma_is_temporary_stack(vma))
> > +               return false;
> > +
> > +       /*
> > +        * THPeligible bit of smaps should show 1 for proper VMAs even
> > +        * though anon_vma is not initialized yet.
> > +        */
> > +       if (!vma->anon_vma)
> > +               return smaps;
> > +
> > +       return true;
> >  }
>
> There are a few cases where the return value for smaps will be
> different from before. I presume this won't be an issue, and that any
> difference resulting from this change is actually a positive
> difference, given it more accurately reflects the thp eligibility of
> the vma? For example, a VM_NO_KHUGEPAGED-marked vma might now show 0
> where it otherwise showed 1.

Yes, returning 1 for VM_NO_KHUGEPAGED vmas is wrong. Actually TBH I
suspect very few people actually use this bit. Anyway I will elaborate
this in the commit log.

>
> >  static bool get_huge_zero_page(void)
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index ca1754d3a827..aa0769e3b0d9 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -437,49 +437,6 @@ static inline int khugepaged_test_exit(struct mm_struct *mm)
> >         return atomic_read(&mm->mm_users) == 0;
> >  }
> >
> > -bool hugepage_vma_check(struct vm_area_struct *vma,
> > -                       unsigned long vm_flags)
> > -{
> > -       if (!transhuge_vma_enabled(vma, vm_flags))
> > -               return false;
> > -
> > -       if (vm_flags & VM_NO_KHUGEPAGED)
> > -               return false;
> > -
> > -       /* Don't run khugepaged against DAX vma */
> > -       if (vma_is_dax(vma))
> > -               return false;
> > -
> > -       if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
> > -                               vma->vm_pgoff, HPAGE_PMD_NR))
> > -               return false;
> > -
> > -       if (!transhuge_vma_size_ok(vma))
> > -               return false;
> > -
> > -       /* Enabled via shmem mount options or sysfs settings. */
> > -       if (shmem_file(vma->vm_file))
> > -               return shmem_huge_enabled(vma);
> > -
> > -       if (!khugepaged_enabled())
> > -               return false;
> > -
> > -       /* THP settings require madvise. */
> > -       if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
> > -               return false;
> > -
> > -       /* Only regular file is valid */
> > -       if (file_thp_enabled(vma))
> > -               return true;
> > -
> > -       if (!vma->anon_vma || !vma_is_anonymous(vma))
> > -               return false;
> > -       if (vma_is_temporary_stack(vma))
> > -               return false;
> > -
> > -       return true;
> > -}
> > -
> >  void __khugepaged_enter(struct mm_struct *mm)
> >  {
> >         struct mm_slot *mm_slot;
> > @@ -516,7 +473,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
> >  {
> >         if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> >             khugepaged_enabled()) {
> > -               if (hugepage_vma_check(vma, vm_flags))
> > +               if (hugepage_vma_check(vma, vm_flags, false))
> >                         __khugepaged_enter(vma->vm_mm);
> >         }
> >  }
> > @@ -961,7 +918,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> >
> >         if (!transhuge_vma_suitable(vma, address))
> >                 return SCAN_ADDRESS_RANGE;
> > -       if (!hugepage_vma_check(vma, vma->vm_flags))
> > +       if (!hugepage_vma_check(vma, vma->vm_flags, false))
> >                 return SCAN_VMA_CHECK;
> >         return 0;
> >  }
> > @@ -1442,7 +1399,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
> >          * the valid THP. Add extra VM_HUGEPAGE so hugepage_vma_check()
> >          * will not fail the vma for missing VM_HUGEPAGE
> >          */
> > -       if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE))
> > +       if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false))
> >                 return;
> >
> >         /* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
> > @@ -2132,7 +2089,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
> >                         progress++;
> >                         break;
> >                 }
> > -               if (!hugepage_vma_check(vma, vma->vm_flags)) {
> > +               if (!hugepage_vma_check(vma, vma->vm_flags, false)) {
> >  skip:
> >                         progress++;
> >                         continue;
> > --
> > 2.26.3
> >
> >
