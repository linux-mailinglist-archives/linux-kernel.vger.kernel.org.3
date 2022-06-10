Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FDB546F33
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350698AbiFJVYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiFJVYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:24:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6981E4BDC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:24:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t2so279457pld.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcHzsQVZ+PTFSV9X4stAy+tj1JmFLmJSZcQbEdxANTg=;
        b=ArwMa9bZf+r8xebzbmSfcJnbMlpoqRyzcSgvj7aIl8Q4FjIUw7aXaf38oXRlRSn7nR
         Jz898ErOjc0pJrCZEZMVBKGoR3C1AdzLDeXHhUZh86b24KW7czKHTssyDKE8LjkoujJU
         gaZxcgqe82On1qlRiuM4PNX+9W2XHJ/eIi3YMMoliaWGZXaLn8b6x4IhHMDyo+esBaNM
         l9XuoowBf0U8oJM+I0zVZGYfezI0mMNz3uT6LemGDhOZwVWLNVbH3Mm/cQs8kHcGJXtm
         V/HLKcHwguRzsTFMvHpaT4XobPXwc57PkkUzh8A88+pMeLItBkhOueNsP/exglZXyPQS
         IDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcHzsQVZ+PTFSV9X4stAy+tj1JmFLmJSZcQbEdxANTg=;
        b=6+o5kQZWEPRblNKz5U3ZCIjuVIk8pJR1h8ZXQVRjHLliQEuMvoKDv+1VqFNjWW/rpd
         Hxiilq3VdNc4Qm0z8mTwX967m6RmY50GQVhvTBkDu9MAiqaMiJ6JRWRSaU+bBxD/gDHi
         AJtbxuRIG370s0QX7bPMXerkar0CCXqtTk+Ct1uDg0xwQdo3AZ2bPDgUBW8pvIv0Eo1f
         t88kZOR+06FmImb/Viv3EcOzKl8qeQoEhUhhyy0PsUTSkCXlgs5BZoQJf4Y7HeLDRPet
         82JEm9UpXSeMfOj8YnAKPNgmIwW9uUNKVSJqDk1Ig/ZVgw70vJtn1GA6hTnN8KVK3HLZ
         zAjw==
X-Gm-Message-State: AOAM533H0qux4EwjaWtDSIY50ZZXkIn7e5vKFRm1ewb3p95tRSFmKP1l
        4E23b6bKg/CHqaVxCO9AMTgyc7YVXlkhTOlrokM=
X-Google-Smtp-Source: ABdhPJzzagpZPkwig2/NpWC77DWNNuvXz/zd67odgxEz2hdg1cuYtctz2IVGfqEqz7OatcqOxiO3RK25CjEEXEb6jqk=
X-Received: by 2002:a17:90a:de15:b0:1df:63dd:9cfc with SMTP id
 m21-20020a17090ade1500b001df63dd9cfcmr1703274pjv.200.1654896286440; Fri, 10
 Jun 2022 14:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-3-shy828301@gmail.com>
 <CAAa6QmTYZQVf_U3dBnFpYGh3E8Qc4w8CKctMUC7jV_t=naGURQ@mail.gmail.com>
 <CAHbLzkr42VJhwj5EELw4oOXxm8bHzB7AEUBa0JqWYpvNXw6oNg@mail.gmail.com>
 <CAAa6QmRThv3OMr_j9Z7i_Q4zL3EFYHJSJxdUhE5ebmOMD_+n7w@mail.gmail.com> <CAHbLzkq8Ko+KL1wnxLGjgL=z8k9Bz5cX6q9Y-cfaWo9T5iSXbg@mail.gmail.com>
In-Reply-To: <CAHbLzkq8Ko+KL1wnxLGjgL=z8k9Bz5cX6q9Y-cfaWo9T5iSXbg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 10 Jun 2022 14:24:34 -0700
Message-ID: <CAHbLzkqmS2RLAqTV6dC_W60FdwbOG2jZX0NU+zS0p2wuiK1t-Q@mail.gmail.com>
Subject: Re: [v3 PATCH 2/7] mm: thp: introduce transhuge_vma_size_ok() helper
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

On Fri, Jun 10, 2022 at 9:38 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Jun 9, 2022 at 5:52 PM Zach O'Keefe <zokeefe@google.com> wrote:
> >
> > On Thu, Jun 9, 2022 at 5:08 PM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > On Thu, Jun 9, 2022 at 3:21 PM Zach O'Keefe <zokeefe@google.com> wrote:
> > > >
> > > > On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
> > > > >
> > > > > There are couple of places that check whether the vma size is ok for
> > > > > THP or not, they are open coded and duplicate, introduce
> > > > > transhuge_vma_size_ok() helper to do the job.
> > > > >
> > > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > > ---
> > > > >  include/linux/huge_mm.h | 17 +++++++++++++++++
> > > > >  mm/huge_memory.c        |  5 +----
> > > > >  mm/khugepaged.c         | 12 ++++++------
> > > > >  3 files changed, 24 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > > > index 648cb3ce7099..a8f61db47f2a 100644
> > > > > --- a/include/linux/huge_mm.h
> > > > > +++ b/include/linux/huge_mm.h
> > > > > @@ -116,6 +116,18 @@ extern struct kobj_attribute shmem_enabled_attr;
> > > > >
> > > > >  extern unsigned long transparent_hugepage_flags;
> > > > >
> > > > > +/*
> > > > > + * The vma size has to be large enough to hold an aligned HPAGE_PMD_SIZE area.
> > > > > + */
> > > > > +static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> > > > > +{
> > > > > +       if (round_up(vma->vm_start, HPAGE_PMD_SIZE) <
> > > > > +           (vma->vm_end & HPAGE_PMD_MASK))
> > > > > +               return true;
> > > > > +
> > > > > +       return false;
> > > > > +}
> > > >
> > > > First time coming across round_up() - thanks for that - but for
> > > > symmetry, maybe also use round_down() for the end? No strong opinion -
> > > > just a suggestion given I've just discovered it.
> > >
> > > Yeah, round_down is fine too.
> > >
> > > >
> > > > >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > > > >                 unsigned long addr)
> > > > >  {
> > > > > @@ -345,6 +357,11 @@ static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
> > > > >         return false;
> > > > >  }
> > > > >
> > > > > +static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> > > > > +{
> > > > > +       return false;
> > > > > +}
> > > > > +
> > > > >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > > > >                 unsigned long addr)
> > > > >  {
> > > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > > index 48182c8fe151..36ada544e494 100644
> > > > > --- a/mm/huge_memory.c
> > > > > +++ b/mm/huge_memory.c
> > > > > @@ -71,10 +71,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
> > > > >
> > > > >  bool transparent_hugepage_active(struct vm_area_struct *vma)
> > > > >  {
> > > > > -       /* The addr is used to check if the vma size fits */
> > > > > -       unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> > > > > -
> > > > > -       if (!transhuge_vma_suitable(vma, addr))
> > > > > +       if (!transhuge_vma_size_ok(vma))
> > > > >                 return false;
> > > > >         if (vma_is_anonymous(vma))
> > > > >                 return __transparent_hugepage_enabled(vma);
> > > >
> > > > Do we need a check for vma->vm_pgoff alignment here, after
> > > > !vma_is_anonymous(), and now that we don't call
> > > > transhuge_vma_suitable()?
> > >
> > > Actually I was thinking about this too. But the THPeligible bit shown
> > > by smaps is a little bit ambiguous for file vma. The document says:
> > > "THPeligible" indicates whether the mapping is eligible for allocating
> > > THP pages - 1 if true, 0 otherwise.
> > >
> > > Even though it doesn't fulfill the alignment, it is still possible to
> > > get THP allocated, but just can't be PMD mapped. So the old behavior
> > > of THPeligible for file vma seems problematic, or at least doesn't
> > > match the document.
> >
> > I think the term "THP" is used ambiguously. Often, but not always, in
> > the code, folks will go out of their way to specify "hugepage-sized"
> > page vs "pmd-mapped hugepage" - but at least from my experience,
> > external documentation doesn't. Given that THP as a concept doesn't
> > make much sense without the possibility of pmd-mapping, I think
> > "THPeligible here means "pmd mappable". For example, AnonHugePages in
> > smaps means  pmd-mapped anon hugepages.
>
> Yeah, depends on the expectation.

The funny thing is I was the last one who touched the THPeligible. It
seems the document needs to be updated too to make "pmd mappable" more
explicitly.

>
> >
> > That all said - the following patches will delete
> > transparent_hugepage_active() anyways.
>
> Yes, how I could forget this :-( The following removal of
> transparent_hugepage_active() will restore the old behavior.
>
> >
> > > I should elaborate this in the commit log.
> > >
> > > >
> > > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > > index 84b9cf4b9be9..d0f8020164fc 100644
> > > > > --- a/mm/khugepaged.c
> > > > > +++ b/mm/khugepaged.c
> > > > > @@ -454,6 +454,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
> > > > >                                 vma->vm_pgoff, HPAGE_PMD_NR))
> > > > >                 return false;
> > > > >
> > > > > +       if (!transhuge_vma_size_ok(vma))
> > > > > +               return false;
> > > > > +
> > > > >         /* Enabled via shmem mount options or sysfs settings. */
> > > > >         if (shmem_file(vma->vm_file))
> > > > >                 return shmem_huge_enabled(vma);
> > > > > @@ -512,9 +515,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
> > > > >                           unsigned long vm_flags)
> > > > >  {
> > > > >         if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> > > > > -           khugepaged_enabled() &&
> > > > > -           (((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
> > > > > -            (vma->vm_end & HPAGE_PMD_MASK))) {
> > > > > +           khugepaged_enabled()) {
> > > > >                 if (hugepage_vma_check(vma, vm_flags))
> > > > >                         __khugepaged_enter(vma->vm_mm);
> > > > >         }
> > > > > @@ -2142,10 +2143,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
> > > > >                         progress++;
> > > > >                         continue;
> > > > >                 }
> > > > > -               hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> > > > > +
> > > > > +               hstart = round_up(vma->vm_start, HPAGE_PMD_SIZE);
> > > > >                 hend = vma->vm_end & HPAGE_PMD_MASK;
> > > > > -               if (hstart >= hend)
> > > > > -                       goto skip;
> > > > >                 if (khugepaged_scan.address > hend)
> > > > >                         goto skip;
> > > > >                 if (khugepaged_scan.address < hstart)
> > > >
> > > > Likewise, could do round_down() here (just a suggestion)
> > >
> > > Fine to me.
> > >
> > > >
> > > > > --
> > > > > 2.26.3
> > > > >
> > > > >
