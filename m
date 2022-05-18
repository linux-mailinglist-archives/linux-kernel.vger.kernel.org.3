Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CCA52C2BE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbiERSpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241552AbiERSp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:45:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A152420F4CE
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:45:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so2924281pjf.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3aLqFCIHlaNtUXWSW3P8CFFA9P/K5XYG2miYLAiW2do=;
        b=HVmMMT3XA+R82BVVebbL3V1VL1hVNV4JQjaKrHVXG2G/pqLeyfXZLvuP1YNX2AZ0UC
         R5z/1VtX4ldo8b8foPJUcuBbUwDszj/g46L4uZUUIZV1WFnF6EDscnXCVIlKYvwwhJ7E
         1CPNzSxfDKIDg0owcBKQB5j7ZUtVANv1hfO9FNN3D8veokgta/6g4i2rr3JONTBpeCIg
         Yz44NGLUtovLClODpFUBGm6RegbrczWncE2ugf8jx5l+TUmJc3fcIBIi8vpPJMkiHXIf
         HtC62oe5MDlN0IbvkhTqliYxEaxh/5mY9WgOpwv0evorU94zuv8au5vbiP9AkM5A/zVQ
         eVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aLqFCIHlaNtUXWSW3P8CFFA9P/K5XYG2miYLAiW2do=;
        b=7j0O3+aTY/RIipQLhGWd2xyA8JNWc3Q1rGfzBtVy2wgx673rZaFIhl5CPOBlSF2TOo
         bHRmSjPiKfLHIu0cOxr4p0Xgx3HrGdtq4TB8xdYRsy6Te9OsGD5k/1wNb709zBurTR7M
         iqnRsQKiFWjRMTj1tD3kluvvz+3IBKkT7HmqwxAUczT1PMkwV57XkTGdoe4yR1XaQaw1
         ELamndJQKcJsG/6xhCcMQifA7uZ0lXdEHeysI7PqsfNAVNRmfPQpP9xwNOU/GH4Ds0Ok
         x+oc0IyXU75d0jfMjquuSfPNFokOJEukj1yM0Jw3MQx0fpR4xRwwUKYpH+oIPS+NzRzN
         H8KA==
X-Gm-Message-State: AOAM532DTOAP2zl2Yg9oVijOHiY7yJtptgWD0t6m5/LRhPWLM/4MxjDL
        6KmdBAsSGc/mllcvFUbEvRbIbPUX69S2yAi192E=
X-Google-Smtp-Source: ABdhPJwZqBtopqsb1FdAQ1j8MWk0bfzi6/ffMW6kYKfUpos84fkjsZ2ZlxbQyQUbjLgCTmCSe4KgsxwjnmEYNL2ajmU=
X-Received: by 2002:a17:90a:de15:b0:1df:63dd:9cfc with SMTP id
 m21-20020a17090ade1500b001df63dd9cfcmr823429pjv.200.1652899526990; Wed, 18
 May 2022 11:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220513191705.457775-1-shy828301@gmail.com> <YoSEsa2zvqylYuZC@FVFYT0MHHV2J.usts.net>
In-Reply-To: <YoSEsa2zvqylYuZC@FVFYT0MHHV2J.usts.net>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 18 May 2022 11:45:14 -0700
Message-ID: <CAHbLzkrXvJn6FbCNUTMi3c85nnMvOda58V2DDSb9W7_9_YTjSg@mail.gmail.com>
Subject: Re: [v2 PATCH] mm: pvmw: check possible huge PMD map by transhuge_vma_suitable()
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
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

On Tue, May 17, 2022 at 10:31 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Fri, May 13, 2022 at 12:17:05PM -0700, Yang Shi wrote:
> > IIUC PVMW checks if the vma is possibly huge PMD mapped by
> > transparent_hugepage_active() and "pvmw->nr_pages >= HPAGE_PMD_NR".
> >
> > Actually pvmw->nr_pages is returned by compound_nr() or
> > folio_nr_pages(), so the page should be THP as long as "pvmw->nr_pages
> > >= HPAGE_PMD_NR".  And it is guaranteed THP is allocated for valid VMA
> > in the first place.  But it may be not PMD mapped if the VMA is file
> > VMA and it is not properly aligned.  The transhuge_vma_suitable()
> > is used to do such check, so replace transparent_hugepage_active() to
> > it, which is too heavy and overkilling.
> >
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Muchun Song <songmuchun@bytedance.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> > v2: * Fixed build error for !CONFIG_TRANSPARENT_HUGEPAGE
> >     * Removed fixes tag per Willy
> >
> >  include/linux/huge_mm.h | 8 ++++++--
> >  mm/page_vma_mapped.c    | 2 +-
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index fbf36bb1be22..c2826b1f4069 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -117,8 +117,10 @@ extern struct kobj_attribute shmem_enabled_attr;
> >  extern unsigned long transparent_hugepage_flags;
> >
> >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > -             unsigned long haddr)
> > +             unsigned long addr)
> >  {
> > +     unsigned long haddr;
> > +
> >       /* Don't have to check pgoff for anonymous vma */
> >       if (!vma_is_anonymous(vma)) {
> >               if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> > @@ -126,6 +128,8 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> >                       return false;
> >       }
> >
> > +     haddr = addr & HPAGE_PMD_MASK;
> > +
> >       if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
> >               return false;
> >       return true;
> > @@ -328,7 +332,7 @@ static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
> >  }
> >
> >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > -             unsigned long haddr)
> > +             unsigned long addr)
> >  {
> >       return false;
> >  }
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index c10f839fc410..e971a467fcdf 100644
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> > @@ -243,7 +243,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >                        * cleared *pmd but not decremented compound_mapcount().
> >                        */
> >                       if ((pvmw->flags & PVMW_SYNC) &&
> > -                         transparent_hugepage_active(vma) &&
> > +                         transhuge_vma_suitable(vma, pvmw->address) &&
>
> How about the following diff? Then we do not need to change
> transhuge_vma_suitable().  All the users of transhuge_vma_suitable()
> are already do the alignment by themselves.

Thanks for the suggestion. But TBH I don't think this is a better way.
I did think about this before proposing v2, but I don't prefer to
pollute the code with IS_ENABLED(CONFIG_xxx) since the definition of
transhuge_vma_suitable() is already protected by #ifdef. Rounding the
address in transhuge_vma_suitable() seems neater and more readable to
me IMHO.

Some callers of transhuge_vma_suitable() do round the address before
calling it, but the rounded address is used by other codes in the
callers too.

>
> Thanks.
>
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index c10f839fc410..0aed5ca60c67 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -243,7 +243,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>                          * cleared *pmd but not decremented compound_mapcount().
>                          */
>                         if ((pvmw->flags & PVMW_SYNC) &&
> -                           transparent_hugepage_active(vma) &&
> +                           IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> +                           transhuge_vma_suitable(vma, pvmw->address & HPAGE_PMD_MASK) &&
>                             (pvmw->nr_pages >= HPAGE_PMD_NR)) {
>                                 spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
>
> >                           (pvmw->nr_pages >= HPAGE_PMD_NR)) {
> >                               spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
> >
> > --
> > 2.26.3
> >
> >
