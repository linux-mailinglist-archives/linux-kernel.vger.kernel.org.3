Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC10546ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349447AbiFJQsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349844AbiFJQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:48:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262B4B2EB6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:48:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x4so15746213pfj.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vFyBrdxSbkI+mfhKuuYNpkHpuCxKZS4GtlQHUPNgHw=;
        b=KMiA0J2I/vzgsnbe9ot1ANdEAoLdqlcKhBXmL++rYc3bBaizGMuqjJ19IQ/+G2sUis
         kkY8drJvJC0FpP69oNtGTR+hbX/ZxE47a3/wmuTUzB3W4T2z3Ud4t4aZKZcWN9KnXj1f
         04AN1IOWAxPxMXbRzC5dfe8LR8axbXznLnC3vpQ0Q9uMAsd8mEeiDFbl8d7/Srdv01I1
         MQQQJ30dm8nK/kGGONxOLJ+9Dx48+QyFsg3ckpHg0JfXhw3YiCT44kGWOoISjgE06fDH
         pSPzu8sHlpfIlMlS+mECMTy7Lfk9rfTUPd4FFucKwLqVxe5WU49dsBXtG6H+VdtKC+FL
         QVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vFyBrdxSbkI+mfhKuuYNpkHpuCxKZS4GtlQHUPNgHw=;
        b=3bTByzJb+QMQDNhjen4e3Cqemjc7DvoF7VqDz+28FETb3BeDi/0alw/Qb/svsa2AYp
         ihx7FzNA1ycNnrb45CYzPI4u0blcmKQrw5PN8vsJpv2OXjr27AfNHzRkdG3ijUUseHk+
         Xbx6ssu8xjU5lfSReq+6L1pr0Yvj+wjDVYSreHyV1JWXdR0eEhQwVoL6OdYJCh6OUHZX
         tr915Ttvh6pvOXcr54ZGCvJ26lKALsqoIlf/Y1QLK+Wk+/iyd1xvOiLo0eBq+QJsGzVJ
         4FhGdRGOc9YSpNspQVefI+f2qXBZuTQ0PhWPRvWNSdOklH/nYXd6BkpTqfRcondKgBdW
         dCJQ==
X-Gm-Message-State: AOAM530WcWlC3GcwKEGGyFfNdTge0ft38uOA1yx+3uMEKCuHigIZHlrk
        tLOfDrcHNOuimC2/aVTrMyMea4tdGrkAX2KB1uo=
X-Google-Smtp-Source: ABdhPJy7BMJPOVUSEhhWXJXOrQPJJMTAm54bVzXOOhDzOedG/6evZ3PbNk2seLRSXaruNMI5Tb+dEQ1xhFl9/fmlnbA=
X-Received: by 2002:a05:6a02:184:b0:3fc:3b43:e5da with SMTP id
 bj4-20020a056a02018400b003fc3b43e5damr39448807pgb.587.1654879686708; Fri, 10
 Jun 2022 09:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-3-shy828301@gmail.com>
 <8ba0f470-af80-1087-4361-eacbcbc52d90@huawei.com>
In-Reply-To: <8ba0f470-af80-1087-4361-eacbcbc52d90@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 10 Jun 2022 09:47:54 -0700
Message-ID: <CAHbLzkrnqd2KwZtC3Q-bO=wfpR0qGyQoiaey5o6dsD8qyeSovw@mail.gmail.com>
Subject: Re: [v3 PATCH 2/7] mm: thp: introduce transhuge_vma_size_ok() helper
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Fri, Jun 10, 2022 at 12:20 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/6/7 5:44, Yang Shi wrote:
> > There are couple of places that check whether the vma size is ok for
> > THP or not, they are open coded and duplicate, introduce
> > transhuge_vma_size_ok() helper to do the job.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/huge_mm.h | 17 +++++++++++++++++
> >  mm/huge_memory.c        |  5 +----
> >  mm/khugepaged.c         | 12 ++++++------
> >  3 files changed, 24 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 648cb3ce7099..a8f61db47f2a 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -116,6 +116,18 @@ extern struct kobj_attribute shmem_enabled_attr;
> >
> >  extern unsigned long transparent_hugepage_flags;
> >
> > +/*
> > + * The vma size has to be large enough to hold an aligned HPAGE_PMD_SIZE area.
> > + */
> > +static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> > +{
> > +     if (round_up(vma->vm_start, HPAGE_PMD_SIZE) <
> > +         (vma->vm_end & HPAGE_PMD_MASK))
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> >               unsigned long addr)
> >  {
> > @@ -345,6 +357,11 @@ static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
> >       return false;
> >  }
> >
> > +static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> > +{
> > +     return false;
> > +}
> > +
> >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> >               unsigned long addr)
> >  {
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 48182c8fe151..36ada544e494 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -71,10 +71,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
> >
> >  bool transparent_hugepage_active(struct vm_area_struct *vma)
> >  {
> > -     /* The addr is used to check if the vma size fits */
> > -     unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> > -
> > -     if (!transhuge_vma_suitable(vma, addr))
>
> There is also pgoff check for file page in transhuge_vma_suitable. Is it ignored
> deliberately?

This has been discussed in the previous threads. The following removal
of transparent_hugepage_active() will restore the behavior.

>
> > +     if (!transhuge_vma_size_ok(vma))
> >               return false;
> >       if (vma_is_anonymous(vma))
> >               return __transparent_hugepage_enabled(vma);
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 84b9cf4b9be9..d0f8020164fc 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -454,6 +454,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
> >                               vma->vm_pgoff, HPAGE_PMD_NR))
> >               return false;
> >
> > +     if (!transhuge_vma_size_ok(vma))
> > +             return false;
> > +
> >       /* Enabled via shmem mount options or sysfs settings. */
> >       if (shmem_file(vma->vm_file))
> >               return shmem_huge_enabled(vma);
> > @@ -512,9 +515,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
> >                         unsigned long vm_flags)
> >  {
> >       if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> > -         khugepaged_enabled() &&
> > -         (((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
> > -          (vma->vm_end & HPAGE_PMD_MASK))) {
> > +         khugepaged_enabled()) {
> >               if (hugepage_vma_check(vma, vm_flags))
> >                       __khugepaged_enter(vma->vm_mm);
> >       }
>
> After this change, khugepaged_enter_vma is identical to khugepaged_enter. Should one of
> them be removed?

Thanks for catching this. Although the later patch will make them
slightly different (khugepaged_enter() won't check hugepage flag
anymore), but the only user of khugepaged_enter() is page fault, and
it seems not worth keeping both. Will remove khugepaged_enter() in the
next version.

>
> Thanks!
>
> > @@ -2142,10 +2143,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
> >                       progress++;
> >                       continue;
> >               }
> > -             hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> > +
> > +             hstart = round_up(vma->vm_start, HPAGE_PMD_SIZE);
> >               hend = vma->vm_end & HPAGE_PMD_MASK;
> > -             if (hstart >= hend)
> > -                     goto skip;
> >               if (khugepaged_scan.address > hend)
> >                       goto skip;
> >               if (khugepaged_scan.address < hstart)
> >
>
