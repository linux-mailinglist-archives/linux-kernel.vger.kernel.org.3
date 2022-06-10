Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AB2546B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiFJRAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350052AbiFJRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:00:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1073C35DCD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:59:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id bo5so24348259pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6oCcDIZ6NGhYZEWuS6OCQMXStNToq7DhXXPf8Kj6NnM=;
        b=lqwHwachZToOTY0r4VOrPBCa9KDksfoApvbwKgbLY+suB80QAt8umn8vGvW+QEukSW
         LblDrLCNzXMd2b1CmCs3yz/dI1aaF4NrVPFp6PcRQ8AQE/XZTRgMno2XEHZxphYoRg8T
         1JlmC8VcEMX4XDOPH+H96h4sNCwEs+4176TqWTU9s2SPjma9fU66Zz+Wl/PBja3Uyd5P
         WJ7oD/oj3AmaLxt1hb006hoT0zOoTZDE8sF+zIoh0/PVGNPQINGFXw1srlaWU5JxJEOJ
         baUNTtfO6Yib7Nb3sPt0mJqpDFK5h9XisT9dhxgTNKUNXcdI1TRUqXnG+jEDDFu3Nz70
         //lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6oCcDIZ6NGhYZEWuS6OCQMXStNToq7DhXXPf8Kj6NnM=;
        b=LWztMgUhNj+CfqSjvfuTmmBc2L3fUQscmEWGrt0FPA6JuAR7rPg1ICzAz89NyytbMu
         QUQ+cJOl02+jm4n5u2J2OxVj7aWB8M98X4aRe4pBWbxUJoXEWsMsGN7pu+Ccqx5cPCkP
         DZdcaT1BiRVtPMZMB43nQsg++j8t+IhW7F0/iLu1T5xHG4tNEb1UdA00RRfxO/7rhO7d
         EDXXYg7EfDt+1ogEYoqnDYdC6OkNgF9nUbUGohNP1JiSYSQbA+G0Pe3WwaXunPTWMGLx
         w7EuVstenkIX/k1GOe0/Vao+v3DfzpzFnsSXVSdhu4R2+6FLIPgHloadFPWc9zbktQar
         qGQg==
X-Gm-Message-State: AOAM532+hH/Vmg46bxk3fghzpFrMtKANBKTmIWZpyRZdVn0w+TV+1YJ7
        82rxbM/ZAj4b+0xcpvi+Ky7thvIBp4T7hrrSeAI=
X-Google-Smtp-Source: ABdhPJzMBiEm8zrvGbTlX9qa+i0h9sXKsCpBKTDzTQuKy07ZPreksZEXuIWBSZq77t+mJL9tWSnnejTLC3B+jUhTrJs=
X-Received: by 2002:a05:6a02:184:b0:3fc:3b43:e5da with SMTP id
 bj4-20020a056a02018400b003fc3b43e5damr39487679pgb.587.1654880394631; Fri, 10
 Jun 2022 09:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-5-shy828301@gmail.com>
 <CAAa6QmSCk+7HLtLOzbTYev7dAM0aff-f4USV3AXAQdSKu7_6HA@mail.gmail.com>
In-Reply-To: <CAAa6QmSCk+7HLtLOzbTYev7dAM0aff-f4USV3AXAQdSKu7_6HA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 10 Jun 2022 09:59:41 -0700
Message-ID: <CAHbLzkpJWSiBX0fYWXjagA-19mJb6hwXZ=_Sk-qJHxMD_3sdYw@mail.gmail.com>
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

On Thu, Jun 9, 2022 at 6:52 PM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > The hugepage_vma_revalidate() needs to check if the address is still in
> > the aligned HPAGE_PMD_SIZE area of the vma when reacquiring mmap_lock,
> > but it was open-coded, use transhuge_vma_suitable() to do the job.  And
> > add proper comments for transhuge_vma_suitable().
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/huge_mm.h | 6 ++++++
> >  mm/khugepaged.c         | 5 +----
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index a8f61db47f2a..79d5919beb83 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -128,6 +128,12 @@ static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> >         return false;
> >  }
> >
> > +/*
> > + * Do the below checks:
> > + *   - For non-anon vma, check if the vm_pgoff is HPAGE_PMD_NR aligned.
> > + *   - For all vmas, check if the haddr is in an aligned HPAGE_PMD_SIZE
> > + *     area.
> > + */
>
> AFAIK we aren't checking if vm_pgoff is HPAGE_PMD_NR aligned, but
> rather that linear_page_index(vma, round_up(vma->vm_start,
> HPAGE_PMD_SIZE)) is HPAGE_PMD_NR aligned within vma->vm_file. I was

Yeah, you are right.

> pretty confused about this (hopefully I have it right now - if not -
> case and point :) ), so it might be a good opportunity to add some
> extra commentary to help future travelers understand why this
> constraint exists.

I'm not fully sure I understand this 100%. I think this is related to
how page cache is structured. I will try to add more comments.

>
> Also I wonder while we're at it if we can rename this to
> transhuge_addr_aligned() or transhuge_addr_suitable() or something.

I think it is still actually used to check vma.

>
> Otherwise I think the change is a nice cleanup.
>
> >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> >                 unsigned long addr)
> >  {
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 7a5d1c1a1833..ca1754d3a827 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -951,7 +951,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> >                 struct vm_area_struct **vmap)
> >  {
> >         struct vm_area_struct *vma;
> > -       unsigned long hstart, hend;
> >
> >         if (unlikely(khugepaged_test_exit(mm)))
> >                 return SCAN_ANY_PROCESS;
> > @@ -960,9 +959,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> >         if (!vma)
> >                 return SCAN_VMA_NULL;
> >
> > -       hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> > -       hend = vma->vm_end & HPAGE_PMD_MASK;
> > -       if (address < hstart || address + HPAGE_PMD_SIZE > hend)
> > +       if (!transhuge_vma_suitable(vma, address))
> >                 return SCAN_ADDRESS_RANGE;
> >         if (!hugepage_vma_check(vma, vma->vm_flags))
> >                 return SCAN_VMA_CHECK;
> > --
> > 2.26.3
> >
> >
