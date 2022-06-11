Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA6B5477C1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 23:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiFKVnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 17:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiFKVnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 17:43:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8866B0B3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 14:43:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso2562577pjk.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 14:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DlWC0afQkPL/3yt1Hfspvlz/uMYSCScGBzo3WdZAJ+w=;
        b=lOpg0sqoYeNKdGSkXS37B2UfADpL0MCZ+bozvEFHG/5nxBIOiSCfttMoa3oVin25ZH
         oEljLGSqkfQIFjNMKE4pYzMobK7TyoNfhKEIc6JprR00Q53n3BEb67txbm1066c21a1N
         ZRGIaxJyw9wolN3ZslwhjNJ6DqG5Bz03ZVMcrRtsN5EWq4zS+4bE+7BjWBdt6HAR6U6L
         jlbsa2rMlnCqPgcjnylcMKD9Hb7W5zkcRcWA8oX+/cAmBTQedkuBkP7ZWKq8qFqMF6fQ
         kDxFbidptYyvaliJM6ZeFvpqK0e9sP9z/PuQv/lqsiwGWOu5YXMjmBqPKIvSE8mmIc73
         2u7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DlWC0afQkPL/3yt1Hfspvlz/uMYSCScGBzo3WdZAJ+w=;
        b=aizKG7n7dfN8rOPoVJiDsnWrid4Pujv7ymZssfydBPTU83DRsET5mjI9We6BV9hpdC
         kKJXVsvfkKhoXLd9uprG0Dm06fmsUugWIU/tUJ+O6bdtEaoilT9HBvyH9PmmTbuyKK0U
         3/jybjxUs7Zp0f7jCiqT+mOA1BH2QurRwzzqmN4sB0kSgpMwSGmLed3PSRnHBe9ln2L7
         ++4kJYqc5uGxik56q9Uu1O9kCL4p3YO4iHXI6Ohjbt58s9RWjkw4POPLvzYAAEO/iaHk
         gT/6DYyG2oK0jsJ/Jkwr1puhQze6+cn+k7M7o2ywZRwSu+V2hjgZ75AGgQI8qDMcefNK
         ySnQ==
X-Gm-Message-State: AOAM531d2jGsKWUFBUtC3ycfONU0YEaz0Mf4mK90WGnrmQHmHlpdg/KU
        8KPyKwGfrq7HvcKqgdw5qCy3OlEEF3cLWg==
X-Google-Smtp-Source: ABdhPJwqNaHsx81l0b0yfA1iTZl5qO5n7GtKGRo7EpJo9XBEQlTPwlPYqhYWYPtgwLu+GKjoNDTe+w==
X-Received: by 2002:a17:90a:e68a:b0:1e3:252f:24e0 with SMTP id s10-20020a17090ae68a00b001e3252f24e0mr6847288pjy.122.1654983822069;
        Sat, 11 Jun 2022 14:43:42 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b00163f35bd8f5sm1939942plk.289.2022.06.11.14.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 14:43:40 -0700 (PDT)
Date:   Sat, 11 Jun 2022 14:43:37 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 4/7] mm: khugepaged: use transhuge_vma_suitable
 replace open-code
Message-ID: <YqUMifZWjwKiKrlX@google.com>
References: <20220606214414.736109-1-shy828301@gmail.com>
 <20220606214414.736109-5-shy828301@gmail.com>
 <CAAa6QmSCk+7HLtLOzbTYev7dAM0aff-f4USV3AXAQdSKu7_6HA@mail.gmail.com>
 <CAHbLzkpJWSiBX0fYWXjagA-19mJb6hwXZ=_Sk-qJHxMD_3sdYw@mail.gmail.com>
 <CAHbLzkpOQrshbBDfHjGVDbpcfdV7hgiwav6TyaZTzm_cq4PeDw@mail.gmail.com>
 <CAAa6QmT4mvpLMdtRV+tJJsPBBbPGuWVzKs5eoFBahG0s_Mba0Q@mail.gmail.com>
 <CAHbLzkrebC-jug86B4w2gkSxiiEUWWjrxBwjevX9q2adG04nzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrebC-jug86B4w2gkSxiiEUWWjrxBwjevX9q2adG04nzQ@mail.gmail.com>
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

On 10 Jun 20:25, Yang Shi wrote:
> On Fri, Jun 10, 2022 at 5:28 PM Zach O'Keefe <zokeefe@google.com> wrote:
> >
> > On Fri, Jun 10, 2022 at 3:04 PM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > On Fri, Jun 10, 2022 at 9:59 AM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > On Thu, Jun 9, 2022 at 6:52 PM Zach O'Keefe <zokeefe@google.com> wrote:
> > > > >
> > > > > On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
> > > > > >
> > > > > > The hugepage_vma_revalidate() needs to check if the address is still in
> > > > > > the aligned HPAGE_PMD_SIZE area of the vma when reacquiring mmap_lock,
> > > > > > but it was open-coded, use transhuge_vma_suitable() to do the job.  And
> > > > > > add proper comments for transhuge_vma_suitable().
> > > > > >
> > > > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > > > ---
> > > > > >  include/linux/huge_mm.h | 6 ++++++
> > > > > >  mm/khugepaged.c         | 5 +----
> > > > > >  2 files changed, 7 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > > > > index a8f61db47f2a..79d5919beb83 100644
> > > > > > --- a/include/linux/huge_mm.h
> > > > > > +++ b/include/linux/huge_mm.h
> > > > > > @@ -128,6 +128,12 @@ static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> > > > > >         return false;
> > > > > >  }
> > > > > >
> > > > > > +/*
> > > > > > + * Do the below checks:
> > > > > > + *   - For non-anon vma, check if the vm_pgoff is HPAGE_PMD_NR aligned.
> > > > > > + *   - For all vmas, check if the haddr is in an aligned HPAGE_PMD_SIZE
> > > > > > + *     area.
> > > > > > + */
> > > > >
> > > > > AFAIK we aren't checking if vm_pgoff is HPAGE_PMD_NR aligned, but
> > > > > rather that linear_page_index(vma, round_up(vma->vm_start,
> > > > > HPAGE_PMD_SIZE)) is HPAGE_PMD_NR aligned within vma->vm_file. I was
> > > >
> > > > Yeah, you are right.
> > > >
> > > > > pretty confused about this (hopefully I have it right now - if not -
> > > > > case and point :) ), so it might be a good opportunity to add some
> > > > > extra commentary to help future travelers understand why this
> > > > > constraint exists.
> > > >
> > > > I'm not fully sure I understand this 100%. I think this is related to
> > > > how page cache is structured. I will try to add more comments.
> > >
> > > How's about "The underlying THP is always properly aligned in page
> > > cache, but it may be across the boundary of VMA if the VMA is
> > > misaligned, so the THP can't be PMD mapped for this case."
> >
> > I could certainly still be wrong / am learning here - but I *thought*
> > the reason for this check was to make sure that the hugepage
> > to-be-collapsed is naturally aligned within the file (since, AFAIK,
> > without this constraint, different mm's might have different ideas
> > about where hugepages in the file should be).
> 
> The hugepage is definitely naturally aligned within the file, this is
> guaranteed by how page cache is organized, you could find some example
> code from shmem fault, for example, the below code snippet:
> 
> hindex = round_down(index, folio_nr_pages(folio));
> error = shmem_add_to_page_cache(folio, mapping, hindex, NULL, gfp &
> GFP_RECLAIM_MASK, charge_mm);
> 
> The index is actually rounded down to HPAGE_PMD_NR aligned.

Thanks for the reference here.

> The check in hugepage_vma_check() is used to guarantee there is an PMD
> aligned area in the vma exactly overlapping with a PMD range in the
> page cache. For example, you have a vma starting from 0x1000 maps to
> the file's page offset of 0, even though you get THP for the file, it
> can not be PMD mapped to the vma. But if it maps to the file's page
> offset of 1, then starting from 0x200000 (assuming the vma is big
> enough) it can PMD map the second THP in the page cache. Does it make
> sense?
>

Yes, this makes sense - thanks for providing your insight. I think I was
basically thinking the same thing ; except your description is more accurate
(namely, that is *some* pmd-aligned range covered by the vma that maps to a
hugepage-aligned offset in the file (I mistakenly took this to be the *first*
pmd-aligned address >= vma->vm_start)).

Also, with this in mind, your previous suggested comment makes sense. If I had
to take a stab at it, I would say something like:

"The hugepage is guaranteed to be hugepage-aligned within the file, but we must
check that the PMD-aligned addresses in the VMA map to PMD-aligned offsets
within the file, else the hugepage will not be PMD-mappable".

WDYT?

> >
> > > >
> > > > >
> > > > > Also I wonder while we're at it if we can rename this to
> > > > > transhuge_addr_aligned() or transhuge_addr_suitable() or something.
> > > >
> > > > I think it is still actually used to check vma.
> > > >
> > > > >
> > > > > Otherwise I think the change is a nice cleanup.
> > > > >
> > > > > >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > > > > >                 unsigned long addr)
> > > > > >  {
> > > > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > > > index 7a5d1c1a1833..ca1754d3a827 100644
> > > > > > --- a/mm/khugepaged.c
> > > > > > +++ b/mm/khugepaged.c
> > > > > > @@ -951,7 +951,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> > > > > >                 struct vm_area_struct **vmap)
> > > > > >  {
> > > > > >         struct vm_area_struct *vma;
> > > > > > -       unsigned long hstart, hend;
> > > > > >
> > > > > >         if (unlikely(khugepaged_test_exit(mm)))
> > > > > >                 return SCAN_ANY_PROCESS;
> > > > > > @@ -960,9 +959,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> > > > > >         if (!vma)
> > > > > >                 return SCAN_VMA_NULL;
> > > > > >
> > > > > > -       hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> > > > > > -       hend = vma->vm_end & HPAGE_PMD_MASK;
> > > > > > -       if (address < hstart || address + HPAGE_PMD_SIZE > hend)
> > > > > > +       if (!transhuge_vma_suitable(vma, address))
> > > > > >                 return SCAN_ADDRESS_RANGE;
> > > > > >         if (!hugepage_vma_check(vma, vma->vm_flags))
> > > > > >                 return SCAN_VMA_CHECK;
> > > > > > --
> > > > > > 2.26.3
> > > > > >
> > > > > >
