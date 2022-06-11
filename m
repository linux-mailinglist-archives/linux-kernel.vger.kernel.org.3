Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D6D547083
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 02:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbiFKA2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 20:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFKA2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 20:28:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94223A455
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 17:28:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w20so827747lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 17:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwlnuv7EIAz5vX1ar0mQBEL2DsqcUV9zFmlfRt4dEpQ=;
        b=HWkmG+GxSfTVVpNBHrzpod1cQ9Gfkz7mAnPjHA5tZA+I27Gp8SysZtcuaXql4fjZD7
         AZ9vSlsswLNqBAEpqBVRqcGbtDXuXPqkGT/DFb1wPtNldb+O1oDKEvurghO8FLzrhcTP
         UuHJ7KntEIfq7Dfb+duYuRHrsihqb9haG3KoFpLfZ3DrLg8eux5cnX0akA661ohemWfC
         vaenhEWIWKmm3jV3mDkb/MR8C4k331hwX3amypn48ZTWJRhTJXol2bEM5MZgcB/vrpg5
         sqchCnNrdi6FaM5Mn54HVMga6nR7JHBcAzPS8YVJG2uc336x+ux7hYYUfdvm/Tj98pPs
         Oe/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwlnuv7EIAz5vX1ar0mQBEL2DsqcUV9zFmlfRt4dEpQ=;
        b=mghxgxCf4+h2JwDc1CJ+ZteDgex7o+YHhMEeSKzLSmFkuPjMjRuH4Ph25m3pLzjDJN
         y/8xr76tCuQ5Tvb3/6Hjb4DNUJvJCLUGCSeXbszevCqYST2s+x5e8byZBZV4/Gjs6e0A
         LQraD3u+zTLXezMjZ39UmfvcRxNT1Pketyi/1PAksdEAi/vdMePoYQhJ+uFq1QHFUjGj
         CmpMWt3nxQln8BZIpCXObi5e+Rr9ZIV7Cx2O18OYGjZ+WA1M43ZeOZrxn/T72bQGWRFo
         5LMTAe89JxzqMxn1rMvJVlZ829oBDhwJGL/Bekd38MhRWYvuHmviNQANh0FgVSk6yWCC
         4SCw==
X-Gm-Message-State: AOAM532To7WZQReyZm3SnAgGwyUvGN+HZRumC3aDQzRBr4R/aO8z0aKT
        /NTFOTsTpKkSi7N0FlUcAgcaAQQV930v6QfLQSr7vg==
X-Google-Smtp-Source: ABdhPJxOfDAnHfVNyokmeSEifDSC/DsxsMpIf/vkKH2wLwgABKE5etARtTKUGen5GoZQVXp/xjsedj84B/MQZoCp7NA=
X-Received: by 2002:ac2:55b1:0:b0:478:ec0b:b784 with SMTP id
 y17-20020ac255b1000000b00478ec0bb784mr28751679lfg.60.1654907308511; Fri, 10
 Jun 2022 17:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-5-shy828301@gmail.com>
 <CAAa6QmSCk+7HLtLOzbTYev7dAM0aff-f4USV3AXAQdSKu7_6HA@mail.gmail.com>
 <CAHbLzkpJWSiBX0fYWXjagA-19mJb6hwXZ=_Sk-qJHxMD_3sdYw@mail.gmail.com> <CAHbLzkpOQrshbBDfHjGVDbpcfdV7hgiwav6TyaZTzm_cq4PeDw@mail.gmail.com>
In-Reply-To: <CAHbLzkpOQrshbBDfHjGVDbpcfdV7hgiwav6TyaZTzm_cq4PeDw@mail.gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Fri, 10 Jun 2022 17:27:51 -0700
Message-ID: <CAAa6QmT4mvpLMdtRV+tJJsPBBbPGuWVzKs5eoFBahG0s_Mba0Q@mail.gmail.com>
Subject: Re: [v3 PATCH 4/7] mm: khugepaged: use transhuge_vma_suitable replace open-code
To:     Yang Shi <shy828301@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Jun 10, 2022 at 3:04 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Fri, Jun 10, 2022 at 9:59 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Thu, Jun 9, 2022 at 6:52 PM Zach O'Keefe <zokeefe@google.com> wrote:
> > >
> > > On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > The hugepage_vma_revalidate() needs to check if the address is still in
> > > > the aligned HPAGE_PMD_SIZE area of the vma when reacquiring mmap_lock,
> > > > but it was open-coded, use transhuge_vma_suitable() to do the job.  And
> > > > add proper comments for transhuge_vma_suitable().
> > > >
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > ---
> > > >  include/linux/huge_mm.h | 6 ++++++
> > > >  mm/khugepaged.c         | 5 +----
> > > >  2 files changed, 7 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > > index a8f61db47f2a..79d5919beb83 100644
> > > > --- a/include/linux/huge_mm.h
> > > > +++ b/include/linux/huge_mm.h
> > > > @@ -128,6 +128,12 @@ static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> > > >         return false;
> > > >  }
> > > >
> > > > +/*
> > > > + * Do the below checks:
> > > > + *   - For non-anon vma, check if the vm_pgoff is HPAGE_PMD_NR aligned.
> > > > + *   - For all vmas, check if the haddr is in an aligned HPAGE_PMD_SIZE
> > > > + *     area.
> > > > + */
> > >
> > > AFAIK we aren't checking if vm_pgoff is HPAGE_PMD_NR aligned, but
> > > rather that linear_page_index(vma, round_up(vma->vm_start,
> > > HPAGE_PMD_SIZE)) is HPAGE_PMD_NR aligned within vma->vm_file. I was
> >
> > Yeah, you are right.
> >
> > > pretty confused about this (hopefully I have it right now - if not -
> > > case and point :) ), so it might be a good opportunity to add some
> > > extra commentary to help future travelers understand why this
> > > constraint exists.
> >
> > I'm not fully sure I understand this 100%. I think this is related to
> > how page cache is structured. I will try to add more comments.
>
> How's about "The underlying THP is always properly aligned in page
> cache, but it may be across the boundary of VMA if the VMA is
> misaligned, so the THP can't be PMD mapped for this case."

I could certainly still be wrong / am learning here - but I *thought*
the reason for this check was to make sure that the hugepage
to-be-collapsed is naturally aligned within the file (since, AFAIK,
without this constraint, different mm's might have different ideas
about where hugepages in the file should be).

> >
> > >
> > > Also I wonder while we're at it if we can rename this to
> > > transhuge_addr_aligned() or transhuge_addr_suitable() or something.
> >
> > I think it is still actually used to check vma.
> >
> > >
> > > Otherwise I think the change is a nice cleanup.
> > >
> > > >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > > >                 unsigned long addr)
> > > >  {
> > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > index 7a5d1c1a1833..ca1754d3a827 100644
> > > > --- a/mm/khugepaged.c
> > > > +++ b/mm/khugepaged.c
> > > > @@ -951,7 +951,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> > > >                 struct vm_area_struct **vmap)
> > > >  {
> > > >         struct vm_area_struct *vma;
> > > > -       unsigned long hstart, hend;
> > > >
> > > >         if (unlikely(khugepaged_test_exit(mm)))
> > > >                 return SCAN_ANY_PROCESS;
> > > > @@ -960,9 +959,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> > > >         if (!vma)
> > > >                 return SCAN_VMA_NULL;
> > > >
> > > > -       hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> > > > -       hend = vma->vm_end & HPAGE_PMD_MASK;
> > > > -       if (address < hstart || address + HPAGE_PMD_SIZE > hend)
> > > > +       if (!transhuge_vma_suitable(vma, address))
> > > >                 return SCAN_ADDRESS_RANGE;
> > > >         if (!hugepage_vma_check(vma, vma->vm_flags))
> > > >                 return SCAN_VMA_CHECK;
> > > > --
> > > > 2.26.3
> > > >
> > > >
