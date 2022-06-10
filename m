Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820E7546F84
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 00:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348285AbiFJWEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 18:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348049AbiFJWEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 18:04:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B471275589
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 15:04:06 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a10so591418pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 15:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/rGGdkS7QIkZ/YCjLiLrVaJUh/NYGf+CirgaHxRAw1o=;
        b=bx0/jpmm8PwMlHjxJtJzWg1ppwMuBsDHCEaaLOM8ybI967KGbvPJa/caI3MUEQIzBm
         /ceuFce/3lGa2eY0688qj1ACzdER9XJ6+pw8sZGwa+1qd+7Plu7oNF5FerOq+3QkEOy6
         wsBlBiRIf/qpoBYeN96GS45AntsJTbZanKztZZ8MXSQJaTie6YdpTqlVVTMrMu9z+8C1
         e/LHMdznxOcsaZuTj45gvPTxir9HxG17harU+KN4CsklbShthHkPH+tIQI4fnCQbGwHg
         +DclOcQqguTf79ELAgN0vgZc1BDnuYuobpX9Mr4ZJje1yiqkCK6S2gaEzCYsvprgYhJ6
         pdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/rGGdkS7QIkZ/YCjLiLrVaJUh/NYGf+CirgaHxRAw1o=;
        b=4Z1IfUhcag5d4K72+5OJr5r8CDmm0vju5L0tpc98HP0qD2RCQzUJo8RlIgwBQ3Sg3P
         tdmbhWoqjssdUKsVgNHWjng75R9ApRhZD6R1lPFJaUPSSommIWNwawMWunDdXpv5uJDI
         frija2ws42wWQchZCumy+C3IdZ3Kf+ti/R13yTLpL78AbIPLrsoC/mqBNa06RX0Aftyv
         Vtx12w+rJEd1X6ecPYM3ur/f2qb3bkXRvr2Cour1RN40unmJKcgvnQk9fjLl6ILlqCI8
         QwIPrLmpL8B9Beio0z0wIUFL89ONz/uvdzzFetvzMXQCYDIChzNO1a13NdFbeaZoyRYp
         zR/A==
X-Gm-Message-State: AOAM531xQIh2lldQJGgfZpEKInVWz6bRdhm2ESfK7b0TbhdG9xO2bhKG
        A4uvaY03dlrL3j/OEimdUD88vxEy1Q/78sNQHUY=
X-Google-Smtp-Source: ABdhPJwfb0XwCdX/7UY7AbXIY2nJKHZ9uPELcxWmuyWrsGuTEEOLeMFehW8z4Q0bEWaNcq3HCwhxixZLBrk52oW1Qxo=
X-Received: by 2002:a17:90a:de15:b0:1df:63dd:9cfc with SMTP id
 m21-20020a17090ade1500b001df63dd9cfcmr1848430pjv.200.1654898645517; Fri, 10
 Jun 2022 15:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-5-shy828301@gmail.com>
 <CAAa6QmSCk+7HLtLOzbTYev7dAM0aff-f4USV3AXAQdSKu7_6HA@mail.gmail.com> <CAHbLzkpJWSiBX0fYWXjagA-19mJb6hwXZ=_Sk-qJHxMD_3sdYw@mail.gmail.com>
In-Reply-To: <CAHbLzkpJWSiBX0fYWXjagA-19mJb6hwXZ=_Sk-qJHxMD_3sdYw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 10 Jun 2022 15:03:53 -0700
Message-ID: <CAHbLzkpOQrshbBDfHjGVDbpcfdV7hgiwav6TyaZTzm_cq4PeDw@mail.gmail.com>
Subject: Re: [v3 PATCH 4/7] mm: khugepaged: use transhuge_vma_suitable replace open-code
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

On Fri, Jun 10, 2022 at 9:59 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Jun 9, 2022 at 6:52 PM Zach O'Keefe <zokeefe@google.com> wrote:
> >
> > On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > The hugepage_vma_revalidate() needs to check if the address is still in
> > > the aligned HPAGE_PMD_SIZE area of the vma when reacquiring mmap_lock,
> > > but it was open-coded, use transhuge_vma_suitable() to do the job.  And
> > > add proper comments for transhuge_vma_suitable().
> > >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  include/linux/huge_mm.h | 6 ++++++
> > >  mm/khugepaged.c         | 5 +----
> > >  2 files changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > index a8f61db47f2a..79d5919beb83 100644
> > > --- a/include/linux/huge_mm.h
> > > +++ b/include/linux/huge_mm.h
> > > @@ -128,6 +128,12 @@ static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> > >         return false;
> > >  }
> > >
> > > +/*
> > > + * Do the below checks:
> > > + *   - For non-anon vma, check if the vm_pgoff is HPAGE_PMD_NR aligned.
> > > + *   - For all vmas, check if the haddr is in an aligned HPAGE_PMD_SIZE
> > > + *     area.
> > > + */
> >
> > AFAIK we aren't checking if vm_pgoff is HPAGE_PMD_NR aligned, but
> > rather that linear_page_index(vma, round_up(vma->vm_start,
> > HPAGE_PMD_SIZE)) is HPAGE_PMD_NR aligned within vma->vm_file. I was
>
> Yeah, you are right.
>
> > pretty confused about this (hopefully I have it right now - if not -
> > case and point :) ), so it might be a good opportunity to add some
> > extra commentary to help future travelers understand why this
> > constraint exists.
>
> I'm not fully sure I understand this 100%. I think this is related to
> how page cache is structured. I will try to add more comments.

How's about "The underlying THP is always properly aligned in page
cache, but it may be across the boundary of VMA if the VMA is
misaligned, so the THP can't be PMD mapped for this case."

>
> >
> > Also I wonder while we're at it if we can rename this to
> > transhuge_addr_aligned() or transhuge_addr_suitable() or something.
>
> I think it is still actually used to check vma.
>
> >
> > Otherwise I think the change is a nice cleanup.
> >
> > >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > >                 unsigned long addr)
> > >  {
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 7a5d1c1a1833..ca1754d3a827 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -951,7 +951,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> > >                 struct vm_area_struct **vmap)
> > >  {
> > >         struct vm_area_struct *vma;
> > > -       unsigned long hstart, hend;
> > >
> > >         if (unlikely(khugepaged_test_exit(mm)))
> > >                 return SCAN_ANY_PROCESS;
> > > @@ -960,9 +959,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> > >         if (!vma)
> > >                 return SCAN_VMA_NULL;
> > >
> > > -       hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> > > -       hend = vma->vm_end & HPAGE_PMD_MASK;
> > > -       if (address < hstart || address + HPAGE_PMD_SIZE > hend)
> > > +       if (!transhuge_vma_suitable(vma, address))
> > >                 return SCAN_ADDRESS_RANGE;
> > >         if (!hugepage_vma_check(vma, vma->vm_flags))
> > >                 return SCAN_VMA_CHECK;
> > > --
> > > 2.26.3
> > >
> > >
