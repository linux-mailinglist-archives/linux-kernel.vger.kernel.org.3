Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA85A9E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiIARnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbiIARnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:43:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1769F8EC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:40:58 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id t129so18128264pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=b0H9B0FRwbPM5Cz+4QjPTjCFU3PLC04eS989QmgK6OY=;
        b=SLXbEaDl+m0WNW1mdPDM1JtgiXI2fq5Ahl2hAk+1/2KblOlCwZQ27c5OI3iOPG0aeV
         jC73JvdnF0WDCP0VTMr7X/+IkartYastE/3OjD4t5EyGGynnNHX5TQco0hAHHE6zk7/G
         7njhGCkfe6HH19n8JFQo2ce+Eg/V2GnSL9aEKHrN6du2K9QBSB16Hxx8esgENcDuGuxG
         ZJKJhsbWYspdEHAQIHKfo8D4Mtjmxd7CSz0Qtp5icSOBzjQRD1UxNka1xGvbZCQD2k1n
         8tS73TtJOA+1XWXPO3Dru+oORzI1CqlyMUyBAKCr6zNVRYwirwpv1Zs8XAMOs8leAGGl
         u8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=b0H9B0FRwbPM5Cz+4QjPTjCFU3PLC04eS989QmgK6OY=;
        b=nu4bh39eriiWOS1mHkEjZbK24n0W+phUwRPf3rx6f0Ihd53HPPBzhHaVxTy5Ros+M4
         BjazZ98iKeHpWgyvePDzBSpu+CCb4n8kED0yjpu4M59q85PBH4LAhAjmeoCCMLsS0/XU
         ezCRMwJUviKuTGvm4sasSjL2Vi/Wj6CtS/SuYlpkuzBJldZo05let4PeaMTtsTUnlOmE
         ZrF8tD96Ds5RbNOkTxY6TEZsYqb1P/IaxM7X7RvqrhDShV8SKtx8JaL7r3RXrrEE3GQC
         lVMKsI8EFJSW8L2ZzdNmxpnVM1bxzr7UiSHJSRFmRCIePA2UVT/n8oOo84tYHzYyiiJK
         rgVA==
X-Gm-Message-State: ACgBeo2qiQPqBgapux3cbnwoMDxMqETl897yfn0B41qXnLcoXk/6QNgb
        cv9yMq9xcmpAhRGALKD5NzGlZtKTwpeGMrOvyFU=
X-Google-Smtp-Source: AA6agR70Xdh8a0e1gFvCSjjLJRyRMUbqTHe5xl2eniat52M1jOZH+rSLT5JNyscu9FMW2Gi3BF+0eQ9CMccIMC7cVus=
X-Received: by 2002:a63:de01:0:b0:42b:31f7:b6ea with SMTP id
 f1-20020a63de01000000b0042b31f7b6eamr26540720pgg.587.1662054043593; Thu, 01
 Sep 2022 10:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220831083024.37138-1-david@redhat.com> <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
 <4845ae71-b7dd-1707-ebc3-2eb3521e7fa0@redhat.com> <CAHbLzkoMMWAgai2bvgu7y5EAcKOhhx3gK+OA4v2+kOHBW4cauw@mail.gmail.com>
 <ab41f458-eb0f-5edb-ccab-643bf00d5110@redhat.com> <CAHbLzkpFqSBTv3HVye4UCKj93NPW8VRqCGZO1p5hk_wfNA_GtQ@mail.gmail.com>
 <94c3217d-df73-2b6b-21f0-95baf117c584@redhat.com> <CAHbLzkp+HNmz7hGS5uDrfDDW0HpSj5Z+xmmkRbwvgn1qYk8Btg@mail.gmail.com>
 <CAHbLzkqM5qj7AZRpeCemsA56oKuHo2T51chTbh1pkGrr0wRFDQ@mail.gmail.com> <a5277667-1b41-dabe-837a-19afd0a68fd1@redhat.com>
In-Reply-To: <a5277667-1b41-dabe-837a-19afd0a68fd1@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 1 Sep 2022 10:40:30 -0700
Message-ID: <CAHbLzkrd5RZ3S88LmeyFoTURxd2=GGMXOjowVQVWW9W8+ncXRg@mail.gmail.com>
Subject: Re: [PATCH v1] mm/ksm: update stale comment in write_protect_page()
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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

On Wed, Aug 31, 2022 at 11:58 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 01.09.22 00:18, Yang Shi wrote:
> > On Wed, Aug 31, 2022 at 12:43 PM Yang Shi <shy828301@gmail.com> wrote:
> >>
> >> On Wed, Aug 31, 2022 at 12:36 PM David Hildenbrand <david@redhat.com> wrote:
> >>>
> >>> On 31.08.22 21:34, Yang Shi wrote:
> >>>> On Wed, Aug 31, 2022 at 12:15 PM David Hildenbrand <david@redhat.com> wrote:
> >>>>>
> >>>>> On 31.08.22 21:08, Yang Shi wrote:
> >>>>>> On Wed, Aug 31, 2022 at 11:29 AM David Hildenbrand <david@redhat.com> wrote:
> >>>>>>>
> >>>>>>> On 31.08.22 19:55, Yang Shi wrote:
> >>>>>>>> On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
> >>>>>>>>>
> >>>>>>>>> The comment is stale, because a TLB flush is no longer sufficient and
> >>>>>>>>> required to synchronize against concurrent GUP-fast. This used to be true
> >>>>>>>>> in the past, whereby a TLB flush would have implied an IPI on architectures
> >>>>>>>>> that support GUP-fast, resulting in GUP-fast that disables local interrupts
> >>>>>>>>> from completing before completing the flush.
> >>>>>>>>
> >>>>>>>> Hmm... it seems there might be problem for THP collapse IIUC. THP
> >>>>>>>> collapse clears and flushes pmd before doing anything on pte and
> >>>>>>>> relies on interrupt disable of fast GUP to serialize against fast GUP.
> >>>>>>>> But if TLB flush is no longer sufficient, then we may run into the
> >>>>>>>> below race IIUC:
> >>>>>>>>
> >>>>>>>>          CPU A                                                CPU B
> >>>>>>>> THP collapse                                             fast GUP
> >>>>>>>>
> >>>>>>>> gup_pmd_range() <-- see valid pmd
> >>>>>>>>
> >>>>>>>> gup_pte_range() <-- work on pte
> >>>>>>>> clear pmd and flush TLB
> >>>>>>>> __collapse_huge_page_isolate()
> >>>>>>>>     isolate page <-- before GUP bump refcount
> >>>>>>>>
> >>>>>>>>    pin the page
> >>>>>>>> __collapse_huge_page_copy()
> >>>>>>>>     copy data to huge page
> >>>>>>>>     clear pte (don't flush TLB)
> >>>>>>>> Install huge pmd for huge page
> >>>>>>>>
> >>>>>>>> return the obsolete page
> >>>>>>>
> >>>>>>> Hm, the is_refcount_suitable() check runs while the PTE hasn't been
> >>>>>>> cleared yet. And we don't check if the PMD changed once we're in
> >>>>>>> gup_pte_range().
> >>>>>>
> >>>>>> Yes
> >>>>>>
> >>>>>>>
> >>>>>>> The comment most certainly should be stale as well -- unless there is
> >>>>>>> some kind of an implicit IPI broadcast being done.
> >>>>>>>
> >>>>>>> 2667f50e8b81 mentions: "The RCU page table free logic coupled with an
> >>>>>>> IPI broadcast on THP split (which is a rare event), allows one to
> >>>>>>> protect a page table walker by merely disabling the interrupts during
> >>>>>>> the walk."
> >>>>>>>
> >>>>>>> I'm not able to quickly locate that IPI broadcast -- maybe there is one
> >>>>>>> being done here (in collapse) as well?
> >>>>>>
> >>>>>> The TLB flush may call IPI. I'm supposed it is arch dependent, right?
> >>>>>> Some do use IPI, some may not.
> >>>>>
> >>>>> Right, and the whole idea of the RCU GUP-fast was to support
> >>>>> architectures that don't do it. x86-64 does it. IIRC, powerpc doesn't do
> >>>>> it -- but maybe it does so for PMDs?
> >>>>
> >>>> It looks powerpc does issue IPI for pmd flush. But arm64 doesn't IIRC.
> >>>>
> >>>> So maybe we should implement pmdp_collapse_flush() for those arches to
> >>>> issue IPI.
> >>>
> >>> ... or find another way to detect and handle this in GUP-fast?
> >>>
> >>> Not sure if, for handling PMDs, it could be sufficient to propagate the
> >>> pmdp pointer + value and double check that the values didn't change.
> >>
> >> Should work too, right before pinning the page.
> >
> > I actually mean the same place for checking pte. So, something like:
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 5abdaf487460..2b0703403902 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2392,7 +2392,8 @@ static int gup_pte_range(pmd_t pmd, unsigned
> > long addr, unsigned long end,
> >                         goto pte_unmap;
> >                 }
> >
> > -               if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> > +               if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
> > +                   unlikely(pte_val(pte) != pte_val(*ptep))) {
> >                         gup_put_folio(folio, 1, flags);
> >                         goto pte_unmap;
> >                 }
> >
> > It doesn't build, just shows the idea.
>
> Exactly what I had in mind. We should add a comment spelling out that
> this is for handling huge PMD collapse.

Yeah, I will prepare a patch soon.

>
>
> --
> Thanks,
>
> David / dhildenb
>
