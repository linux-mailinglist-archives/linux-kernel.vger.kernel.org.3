Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460A954BE81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiFNXzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiFNXzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:55:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFAB47392
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:55:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e24so9823232pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4crJYaIFvXTOY+NZXtRQJ/9iwjhk6ww66wDhvddjqxk=;
        b=ifUw9cbTQgFJWeemY58+kvVX6459QxYo9mcBDotUoFnbBhP6h9Tk9CUJ1QdVSuoYTx
         huaZLmcN/0VQtjykd7c6buIOtwx1RRhSD0hWpxw2EknK1pOtXP+/+Owktn6CCrUOdvBB
         oZ1EaxMA06S8fU9Kw3NQthhWG5hISHP2goSk137SEWCkf6NCFuAU6KnkIu7as0RvKlT8
         4flVp01wh9ZMoJr+waSJXonKO2XsRypgvE0U05XbRdsvYivXuyTAXjzlPnNLNgy+OIDE
         QF17rjIiaFVmFQwzoIeFpvq69+05+6sPzFBq9SFtuA4vMY7ZJkl4Um05m+129C0SkNfK
         FhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4crJYaIFvXTOY+NZXtRQJ/9iwjhk6ww66wDhvddjqxk=;
        b=uqwUaMkZkXD0NXk/riPhgs+UmfmT+qjYgb+m1yD6nq6k+2jLITKEuxiTq/OXA+BIMW
         oOK3ARWCKOkjU+EpHeFCqE5rUiX9VLfTmDwDpj7/7u6pdkSoQTuL9VRdIr4qFlUpbJY9
         BHaUA3OAXVEQSBorW7q7tsac+VNIgAR9noHH2kWuzCzGpLxxgbnvfm6UJ7G+bH5Eba9o
         taH7my43nAx4H49/ySrcybzyWnzHBCeEka0l5qLgvVXe0++wOhTUzPsDAU7hOYb30/t1
         z2TsLyIzEJxu8iGswIKSNzHIESTDI+7H0kL0rVllGIf7ZktWbmi+07qPfMW0pEIgKItk
         rt6Q==
X-Gm-Message-State: AJIora+KBLVDi/+x9APhIE7ga7UAS8pOyMSs9U1QCJ91PaAwK2LeGLCV
        KTg6m89Z2Z8p+84YB18x2WFn1w==
X-Google-Smtp-Source: AGRyM1u02q7Ign/r35z3rnvYQmme6DtHtlG3Nmu3FBfkYzSdtP6FyVNsSVExiKiWOsXxxzk9DyRd0Q==
X-Received: by 2002:a17:902:b592:b0:168:b8ee:8166 with SMTP id a18-20020a170902b59200b00168b8ee8166mr6467202pls.156.1655250937535;
        Tue, 14 Jun 2022 16:55:37 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id j1-20020a170903028100b00168f08d0d12sm1689638plr.89.2022.06.14.16.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 16:55:36 -0700 (PDT)
Date:   Tue, 14 Jun 2022 16:55:33 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 6/7] mm: thp: kill __transhuge_page_enabled()
Message-ID: <Yqkf9Sa1aRINwUiv@google.com>
References: <20220606214414.736109-1-shy828301@gmail.com>
 <20220606214414.736109-7-shy828301@gmail.com>
 <CAAa6QmQ4DaFo9RFXRBZnvq=JbQcVOW9P2njCNXU_pjTxcg=3Sg@mail.gmail.com>
 <CAHbLzkpQJu16gKXTTk0QpeQUHhXqqt8SnVHjrKQw=F4Ra+xZ5A@mail.gmail.com>
 <CAHbLzkrpE1NiEkAJhuOsYQBk7uoLymohpCpZHbnpUzmGRFLtrQ@mail.gmail.com>
 <YqdPmitColnzlXJ0@google.com>
 <CAHbLzkonujXJ98kKPH8-Ac-9o31SHM+jb4RWxz9qRwFq3uOTLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkonujXJ98kKPH8-Ac-9o31SHM+jb4RWxz9qRwFq3uOTLQ@mail.gmail.com>
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

On 14 Jun 11:51, Yang Shi wrote:
> On Mon, Jun 13, 2022 at 7:54 AM Zach O'Keefe <zokeefe@google.com> wrote:
> >
> > On 10 Jun 14:07, Yang Shi wrote:
> > > On Fri, Jun 10, 2022 at 10:24 AM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > On Thu, Jun 9, 2022 at 7:22 PM Zach O'Keefe <zokeefe@google.com> wrote:
> > > > >
> > > > > On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
> > > > > >
> > > > > > The page fault path checks THP eligibility with
> > > > > > __transhuge_page_enabled() which does the similar thing as
> > > > > > hugepage_vma_check(), so use hugepage_vma_check() instead.
> > > > > >
> > > > > > However page fault allows DAX and !anon_vma cases, so added a new flag,
> > > > > > in_pf, to hugepage_vma_check() to make page fault work correctly.
> > > > > >
> > > > > > The in_pf flag is also used to skip shmem and file THP for page fault
> > > > > > since shmem handles THP in its own shmem_fault() and file THP allocation
> > > > > > on fault is not supported yet.
> > > > > >
> > > > > > Also remove hugepage_vma_enabled() since hugepage_vma_check() is the
> > > > > > only caller now, it is not necessary to have a helper function.
> > > > > >
> > > > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > > > ---
> > > > > >  fs/proc/task_mmu.c         |  2 +-
> > > > > >  include/linux/huge_mm.h    | 57 ++------------------------------------
> > > > > >  include/linux/khugepaged.h |  2 +-
> > > > > >  mm/huge_memory.c           | 25 ++++++++++++-----
> > > > > >  mm/khugepaged.c            |  8 +++---
> > > > > >  mm/memory.c                |  7 +++--
> > > > > >  6 files changed, 31 insertions(+), 70 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > > index fd79566e204c..a0850303baec 100644
> > > > > > --- a/fs/proc/task_mmu.c
> > > > > > +++ b/fs/proc/task_mmu.c
> > > > > > @@ -860,7 +860,7 @@ static int show_smap(struct seq_file *m, void *v)
> > > > > >         __show_smap(m, &mss, false);
> > > > > >
> > > > > >         seq_printf(m, "THPeligible:    %d\n",
> > > > > > -                  hugepage_vma_check(vma, vma->vm_flags, true));
> > > > > > +                  hugepage_vma_check(vma, vma->vm_flags, true, false));
> > > > > >
> > > > > >         if (arch_pkeys_enabled())
> > > > > >                 seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> > > > > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > > > > index f561c3e16def..d478e8875023 100644
> > > > > > --- a/include/linux/huge_mm.h
> > > > > > +++ b/include/linux/huge_mm.h
> > > > > > @@ -153,48 +153,6 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > > > > >         return true;
> > > > > >  }
> > > > > >
> > > > > > -static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> > > > > > -                                         unsigned long vm_flags)
> > > > > > -{
> > > > > > -       /* Explicitly disabled through madvise. */
> > > > > > -       if ((vm_flags & VM_NOHUGEPAGE) ||
> > > > > > -           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> > > > > > -               return false;
> > > > > > -       return true;
> > > > > > -}
> > > > > > -
> > > > > > -/*
> > > > > > - * to be used on vmas which are known to support THP.
> > > > > > - * Use transparent_hugepage_active otherwise
> > > > > > - */
> > > > > > -static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> > > > > > -{
> > > > > > -
> > > > > > -       /*
> > > > > > -        * If the hardware/firmware marked hugepage support disabled.
> > > > > > -        */
> > > > > > -       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
> > > > > > -               return false;
> > > > > > -
> > > > > > -       if (!transhuge_vma_enabled(vma, vma->vm_flags))
> > > > > > -               return false;
> > > > > > -
> > > > > > -       if (vma_is_temporary_stack(vma))
> > > > > > -               return false;
> > > > > > -
> > > > > > -       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
> > > > > > -               return true;
> > > > > > -
> > > > > > -       if (vma_is_dax(vma))
> > > > > > -               return true;
> > > > > > -
> > > > > > -       if (transparent_hugepage_flags &
> > > > > > -                               (1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
> > > > > > -               return !!(vma->vm_flags & VM_HUGEPAGE);
> > > > > > -
> > > > > > -       return false;
> > > > > > -}
> > > > > > -
> > > > > >  static inline bool file_thp_enabled(struct vm_area_struct *vma)
> > > > > >  {
> > > > > >         struct inode *inode;
> > > > > > @@ -211,7 +169,7 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
> > > > > >
> > > > > >  bool hugepage_vma_check(struct vm_area_struct *vma,
> > > > > >                         unsigned long vm_flags,
> > > > > > -                       bool smaps);
> > > > > > +                       bool smaps, bool in_pf);
> > > > > >
> > > > > >  #define transparent_hugepage_use_zero_page()                           \
> > > > > >         (transparent_hugepage_flags &                                   \
> > > > > > @@ -355,11 +313,6 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
> > > > > >         return false;
> > > > > >  }
> > > > > >
> > > > > > -static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> > > > > > -{
> > > > > > -       return false;
> > > > > > -}
> > > > > > -
> > > > > >  static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> > > > > >  {
> > > > > >         return false;
> > > > > > @@ -371,15 +324,9 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > > > > >         return false;
> > > > > >  }
> > > > > >
> > > > > > -static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> > > > > > -                                         unsigned long vm_flags)
> > > > > > -{
> > > > > > -       return false;
> > > > > > -}
> > > > > > -
> > > > > >  static inline bool hugepage_vma_check(struct vm_area_struct *vma,
> > > > > >                                        unsigned long vm_flags,
> > > > > > -                                      bool smaps)
> > > > > > +                                      bool smaps, bool in_pf)
> > > > > >  {
> > > > > >         return false;
> > > > > >  }
> > > > > > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > > > > > index 8a6452e089ca..e047be601268 100644
> > > > > > --- a/include/linux/khugepaged.h
> > > > > > +++ b/include/linux/khugepaged.h
> > > > > > @@ -55,7 +55,7 @@ static inline void khugepaged_enter(struct vm_area_struct *vma,
> > > > > >  {
> > > > > >         if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> > > > > >             khugepaged_enabled()) {
> > > > > > -               if (hugepage_vma_check(vma, vm_flags, false))
> > > > > > +               if (hugepage_vma_check(vma, vm_flags, false, false))
> > > > > >                         __khugepaged_enter(vma->vm_mm);
> > > > > >         }
> > > > > >  }
> > > > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > > > index bc8370856e85..b95786ada466 100644
> > > > > > --- a/mm/huge_memory.c
> > > > > > +++ b/mm/huge_memory.c
> > > > > > @@ -71,17 +71,25 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
> > > > > >
> > > > > >  bool hugepage_vma_check(struct vm_area_struct *vma,
> > > > > >                         unsigned long vm_flags,
> > > > > > -                       bool smaps)
> > > > > > +                       bool smaps, bool in_pf)
> > > > > >  {
> > > > > > -       if (!transhuge_vma_enabled(vma, vm_flags))
> > > > > > +       /* Explicitly disabled through madvise or prctl. */
> > > > >
> > > > > Or s390 kvm (not that this has to be exhaustively maintained).
> > > > >
> > > > > > +       if ((vm_flags & VM_NOHUGEPAGE) ||
> > > > > > +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> > > > > > +               return false;
> > > > > > +       /*
> > > > > > +        * If the hardware/firmware marked hugepage support disabled.
> > > > > > +        */
> > > > > > +       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
> > > > > >                 return false;
> > > > >
> > > > > This introduces an extra check for khugepaged path. I don't know
> > > > > enough about TRANSPARENT_HUGEPAGE_NEVER_DAX, but I assume this is ok?
> > > > > What would have happened previously if khugepaged tried to collapse
> > > > > this memory?
> > > >
> > > > Please refer to commit bae849538157 ("mm/pmem: avoid inserting
> > > > hugepage PTE entry with fsdax if hugepage support is disabled") for
> > > > why this flag was introduced.
> > > >
> > > > It is set if hardware doesn't support hugepages, and khugepaged
> > > > doesn't collapse since khugepaged won't be started at all.
> > > >
> > > > But this flag needs to be checked in the page fault path.
> > > >
> >
> > Thanks for the ref to the commit. I'm not sure I understand it in its entirety,
> > but at least I can tell khugepaged won't be started :)
> >
> > > > >
> > > > > > +       /* Special VMA and hugetlb VMA */
> > > > > >         if (vm_flags & VM_NO_KHUGEPAGED)
> > > > > >                 return false;
> > > > >
> > > > > This adds an extra check along the fault path. Is it also safe to add?
> > > >
> > > > I think it is safe since hugepage_vma_check() is just used by THP.
> > > > Hugetlb has its own page fault handler.
> > >
> > > I just found one exception. The fuse dax has VM_MIXEDMAP set for its
> > > vmas, so this check should be moved after vma_is_dax() check.
> > >
> > > AFAICT, only dax supports huge_fault() and dax vmas don't have any
> > > VM_SPECIAL flags set other than fuse.
> > >
> >
> > Ordering wrt VM_NO_KHUGEPAGED check seems fine. We could always use in_pf to opt
> > out of this check, but I think itemizing where collapse and fault paths are
> > different would be good.
> 
> Maybe using "in_pf" is easier to follow? Depending on the order of
> check seems subtle although we already did so for shmem (shmem check
> must be done before hugepage flags check).

Ya, I think the subtleties wrt ordering is getting tricky. I'm OK either way -
but we should document some of these ordering subtleties less someone
inadvertently changes something in the future and has to rediscover e.g. that
particular VM_MIXEDMAP case.

> >
> > > >
> > > > >
> > > > > > -       /* Don't run khugepaged against DAX vma */
> > > > > > +       /* khugepaged doesn't collapse DAX vma, but page fault is fine. */
> > > > > >         if (vma_is_dax(vma))
> > > > > > -               return false;
> > > > > > +               return in_pf;
> > > > >
> > > > > I assume vma_is_temporary_stack() and vma_is_dax() is mutually exclusive.
> > > >
> > > > I think so.
> > > >
> > > > >
> > > > > >         if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
> > > > > >                                 vma->vm_pgoff, HPAGE_PMD_NR))
> > > > > > @@ -91,7 +99,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
> > > > > >                 return false;
> > > > > >
> > > > > >         /* Enabled via shmem mount options or sysfs settings. */
> > > > > > -       if (shmem_file(vma->vm_file))
> > > > > > +       if (!in_pf && shmem_file(vma->vm_file))
> > > > > >                 return shmem_huge_enabled(vma);
> > > > >
> > > > > Will shmem_file() ever be true in the fault path? Or is this just an
> > > > > optimization?
> > > >
> > > > It could be true. But shmem has its own implementation for huge page
> > > > fault and doesn't implement huge_fault() in its vm_operations, so it
> > > > will fallback even though "in_pf" is not checked.
> > > >
> > > > But xfs does have huge_fault() implemented, so it may try to allocate
> > > > THP for non-DAX xfs files. So the "in_pf" flag is introduced to handle
> > > > this. Since we need this flag anyway, why not use it to return earlier
> > > > for shmem instead of relying on fallback.
> > > >
> > > > Anyway this is all because __transparent_huge_enabled() is replaced by
> > > > hugepage_vma_check().
> > > >
> >
> > Thanks for the explanation. Admittedly I don't fully understand the involvement
> > of xfs in the shmem case, but general "fail early" logic seems fine to me.
> > > > > >         if (!khugepaged_enabled())
> > > > > > @@ -102,7 +110,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
> > > > > >                 return false;
> > > > > >
> > > > > >         /* Only regular file is valid */
> > > > > > -       if (file_thp_enabled(vma))
> > > > > > +       if (!in_pf && file_thp_enabled(vma))
> > > > > >                 return true;
> > > > >
> > > > > Likewise for file_thp_enabled()
> > > >
> > > > Yes, same as the above.
> >
> > Ditto.
> >
> > > > >
> > > > > >         if (!vma_is_anonymous(vma))
> > > > > > @@ -114,9 +122,12 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
> > > > > >         /*
> > > > > >          * THPeligible bit of smaps should show 1 for proper VMAs even
> > > > > >          * though anon_vma is not initialized yet.
> > > > > > +        *
> > > > > > +        * Allow page fault since anon_vma may be not initialized until
> > > > > > +        * the first page fault.
> > > > > >          */
> > > > > >         if (!vma->anon_vma)
> > > > > > -               return smaps;
> > > > > > +               return (smaps || in_pf);
> > > > > >
> > > > > >         return true;
> > > > > >  }
> > > > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > > > index aa0769e3b0d9..ab6183c5489f 100644
> > > > > > --- a/mm/khugepaged.c
> > > > > > +++ b/mm/khugepaged.c
> > > > > > @@ -473,7 +473,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
> > > > > >  {
> > > > > >         if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> > > > > >             khugepaged_enabled()) {
> > > > > > -               if (hugepage_vma_check(vma, vm_flags, false))
> > > > > > +               if (hugepage_vma_check(vma, vm_flags, false, false))
> > > > > >                         __khugepaged_enter(vma->vm_mm);
> > > > > >         }
> > > > > >  }
> > > > > > @@ -918,7 +918,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> > > > > >
> > > > > >         if (!transhuge_vma_suitable(vma, address))
> > > > > >                 return SCAN_ADDRESS_RANGE;
> > > > > > -       if (!hugepage_vma_check(vma, vma->vm_flags, false))
> > > > > > +       if (!hugepage_vma_check(vma, vma->vm_flags, false, false))
> > > > > >                 return SCAN_VMA_CHECK;
> > > > > >         return 0;
> > > > > >  }
> > > > > > @@ -1399,7 +1399,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
> > > > > >          * the valid THP. Add extra VM_HUGEPAGE so hugepage_vma_check()
> > > > > >          * will not fail the vma for missing VM_HUGEPAGE
> > > > > >          */
> > > > > > -       if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false))
> > > > > > +       if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false, false))
> > > > > >                 return;
> > > > > >
> > > > > >         /* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
> > > > > > @@ -2089,7 +2089,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
> > > > > >                         progress++;
> > > > > >                         break;
> > > > > >                 }
> > > > > > -               if (!hugepage_vma_check(vma, vma->vm_flags, false)) {
> > > > > > +               if (!hugepage_vma_check(vma, vma->vm_flags, false, false)) {
> > > > > >  skip:
> > > > > >                         progress++;
> > > > > >                         continue;
> > > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > > index bc5d40eec5d5..673f7561a30a 100644
> > > > > > --- a/mm/memory.c
> > > > > > +++ b/mm/memory.c
> > > > > > @@ -4962,6 +4962,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
> > > > > >                 .gfp_mask = __get_fault_gfp_mask(vma),
> > > > > >         };
> > > > > >         struct mm_struct *mm = vma->vm_mm;
> > > > > > +       unsigned long vm_flags = vma->vm_flags;
> > > > > >         pgd_t *pgd;
> > > > > >         p4d_t *p4d;
> > > > > >         vm_fault_t ret;
> > > > > > @@ -4975,7 +4976,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
> > > > > >         if (!vmf.pud)
> > > > > >                 return VM_FAULT_OOM;
> > > > > >  retry_pud:
> > > > > > -       if (pud_none(*vmf.pud) && __transparent_hugepage_enabled(vma)) {
> > > > > > +       if (pud_none(*vmf.pud) &&
> > > > > > +           hugepage_vma_check(vma, vm_flags, false, true)) {
> > > > > >                 ret = create_huge_pud(&vmf);
> > > > > >                 if (!(ret & VM_FAULT_FALLBACK))
> > > > > >                         return ret;
> > > > > > @@ -5008,7 +5010,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
> > > > > >         if (pud_trans_unstable(vmf.pud))
> > > > > >                 goto retry_pud;
> > > > > >
> > > > > > -       if (pmd_none(*vmf.pmd) && __transparent_hugepage_enabled(vma)) {
> > > > > > +       if (pmd_none(*vmf.pmd) &&
> > > > > > +           hugepage_vma_check(vma, vm_flags, false, true)) {
> > > > > >                 ret = create_huge_pmd(&vmf);
> > > > > >                 if (!(ret & VM_FAULT_FALLBACK))
> > > > > >                         return ret;
> > > > > > --
> > > > > > 2.26.3
> > > > > >
> > > > > >
