Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5725AF40C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIFTCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIFTBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:01:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446138B2EC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:01:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c2so12210742plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=AZu8Usw5qGBv2bCC+wGyzG/1jgo5UGZVkgClI5nAtmY=;
        b=jldjQaSzVBJgrETu/whlKsfKw96xbVi+rWmVCTjfuP86WuGBAmjqV5OzhTwp9Mt22e
         a7NK/CEXb+za4jthYO2k1p0jVyue+3A8zL5eNyUfzaaywchWmGHn8xT/3lHE1ESPwHJV
         zcRchhRgpzpu2K2k0Ssvv7TcGEa6VKB2Qk840pzhdc6VP+VqzMgDi4EGzwK5GIrNcolj
         gaBCDGB9BQLo1NLPZDic+Q2UgECrSlwCUlU3a8KUKn2Ft8p7zupQLT3uSBQ3wGF/Zpfm
         VaYJNFaxAA47sLm5wIKQwnbuNZJopF7t7JVlyFKruY8UREgX/A7piwIW1d4bH+Tt5Xo/
         3t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AZu8Usw5qGBv2bCC+wGyzG/1jgo5UGZVkgClI5nAtmY=;
        b=GTAlbjJvcfH5BLlzvW+HImbebR+1Cl0Tninp60soaIDub6Aa29eYsVwX8NfHeMRrEF
         ZRqTJVCTmmNadEHrvv/fUIOIIIigo4OUyokciDKNNMZmDksstEzsPsxCB28gr8TzMoPd
         NUkHDxnLaF4mEXUXylCwUrkTU/zkbBoYVO6Ey4CVooRSnAgdRDJNOgtZjGTK0N6pbGHA
         mxqkW4WhZxzK4q04eeEUWwym+6IYIP1mQlUXTt/cOxGdZFIPvOmQWjzPUqdu8s1eYSbn
         Fu4GIIBkqo3S2ysNw5q1nTZSA5mqf5evUtIEoKPO1UIITCmpL//K2Enaj7S69IzabhUP
         iflA==
X-Gm-Message-State: ACgBeo1IovIBrGWjbDyanKbCQmhYFMBDs8Hk+m0MxUuEd3qPkmJWq9II
        J59S1H1krkBodX9kgex51oy2y+26DISFI+I1/Ao=
X-Google-Smtp-Source: AA6agR5O5m4bkA66nDVs0wlihn8Tn+UVeUFnkjlLNTilBW3AnZeEG7oVg0s3bWwf0/1IQQvPDr4JzZ3c1xTQx2duBuc=
X-Received: by 2002:a17:902:be03:b0:175:6397:9425 with SMTP id
 r3-20020a170902be0300b0017563979425mr25636541pls.26.1662490909335; Tue, 06
 Sep 2022 12:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220901222707.477402-1-shy828301@gmail.com> <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
 <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
In-Reply-To: <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 6 Sep 2022 12:01:36 -0700
Message-ID: <CAHbLzkq+BKxCyPNgCXhhqeS=12ww+W3XMMSOr5GaQedb_pPLtA@mail.gmail.com>
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
To:     David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, peterx@redhat.com,
        kirill.shutemov@linux.intel.com, jgg@nvidia.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Mon, Sep 5, 2022 at 12:59 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 05.09.22 00:29, John Hubbard wrote:
> > On 9/1/22 15:27, Yang Shi wrote:
> >> Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
> >> introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
> >> sufficient to handle concurrent GUP-fast in all cases, it only handles
> >> traditional IPI-based GUP-fast correctly.  On architectures that send
> >> an IPI broadcast on TLB flush, it works as expected.  But on the
> >> architectures that do not use IPI to broadcast TLB flush, it may have
> >> the below race:
> >>
> >>     CPU A                                          CPU B
> >> THP collapse                                     fast GUP
> >>                                                gup_pmd_range() <-- see valid pmd
> >>                                                    gup_pte_range() <-- work on pte
> >> pmdp_collapse_flush() <-- clear pmd and flush
> >> __collapse_huge_page_isolate()
> >>      check page pinned <-- before GUP bump refcount
> >>                                                        pin the page
> >>                                                        check PTE <-- no change
> >> __collapse_huge_page_copy()
> >>      copy data to huge page
> >>      ptep_clear()
> >> install huge pmd for the huge page
> >>                                                        return the stale page
> >> discard the stale page
> >
> > Hi Yang,
> >
> > Thanks for taking the trouble to write down these notes. I always
> > forget which race we are dealing with, and this is a great help. :)
> >
> > More...
> >
> >>
> >> The race could be fixed by checking whether PMD is changed or not after
> >> taking the page pin in fast GUP, just like what it does for PTE.  If the
> >> PMD is changed it means there may be parallel THP collapse, so GUP
> >> should back off.
> >>
> >> Also update the stale comment about serializing against fast GUP in
> >> khugepaged.
> >>
> >> Fixes: 2667f50e8b81 ("mm: introduce a general RCU get_user_pages_fast()")
> >> Signed-off-by: Yang Shi <shy828301@gmail.com>
> >> ---
> >>   mm/gup.c        | 30 ++++++++++++++++++++++++------
> >>   mm/khugepaged.c | 10 ++++++----
> >>   2 files changed, 30 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/mm/gup.c b/mm/gup.c
> >> index f3fc1f08d90c..4365b2811269 100644
> >> --- a/mm/gup.c
> >> +++ b/mm/gup.c
> >> @@ -2380,8 +2380,9 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
> >>   }
> >>
> >>   #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
> >> -static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> >> -                     unsigned int flags, struct page **pages, int *nr)
> >> +static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
> >> +                     unsigned long end, unsigned int flags,
> >> +                     struct page **pages, int *nr)
> >>   {
> >>      struct dev_pagemap *pgmap = NULL;
> >>      int nr_start = *nr, ret = 0;
> >> @@ -2423,7 +2424,23 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> >>                      goto pte_unmap;
> >>              }
> >>
> >> -            if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> >> +            /*
> >> +             * THP collapse conceptually does:
> >> +             *   1. Clear and flush PMD
> >> +             *   2. Check the base page refcount
> >> +             *   3. Copy data to huge page
> >> +             *   4. Clear PTE
> >> +             *   5. Discard the base page
> >> +             *
> >> +             * So fast GUP may race with THP collapse then pin and
> >> +             * return an old page since TLB flush is no longer sufficient
> >> +             * to serialize against fast GUP.
> >> +             *
> >> +             * Check PMD, if it is changed just back off since it
> >> +             * means there may be parallel THP collapse.
> >> +             */
> >
> > As I mentioned in the other thread, it would be a nice touch to move
> > such discussion into the comment header.
> >
> >> +            if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
> >> +                unlikely(pte_val(pte) != pte_val(*ptep))) {
> >
> >
> > That should be READ_ONCE() for the *pmdp and *ptep reads. Because this
> > whole lockless house of cards may fall apart if we try reading the
> > page table values without READ_ONCE().
>
> I came to the conclusion that the implicit memory barrier when grabbing
> a reference on the page is sufficient such that we don't need READ_ONCE
> here.
>
> If we still intend to change that code, we should fixup all GUP-fast
> functions in a similar way. But again, I don't think we need a change here.
>
>
> >> -     * After this gup_fast can't run anymore. This also removes
> >> -     * any huge TLB entry from the CPU so we won't allow
> >> -     * huge and small TLB entries for the same virtual address
> >> -     * to avoid the risk of CPU bugs in that area.
> >> +     * This removes any huge TLB entry from the CPU so we won't allow
> >> +     * huge and small TLB entries for the same virtual address to
> >> +     * avoid the risk of CPU bugs in that area.
> >> +     *
> >> +     * Parallel fast GUP is fine since fast GUP will back off when
> >> +     * it detects PMD is changed.
> >>       */
> >>      _pmd = pmdp_collapse_flush(vma, address, pmd);
> >
> > To follow up on David Hildenbrand's note about this in the nearby thread...
> > I'm also not sure if pmdp_collapse_flush() implies a memory barrier on
> > all arches. It definitely does do an atomic op with a return value on x86,
> > but that's just one arch.
> >
>
> I think a ptep/pmdp clear + TLB flush really has to imply a memory
> barrier, otherwise TLB flushing code might easily mess up with
> surrounding code. But we should better double-check.
>
> s390x executes an IDTE instruction, which performs serialization (->
> memory barrier). arm64 seems to use DSB instructions to enforce memory
> ordering.

IIUC we just need to care about the architectures which support both
THP and fast-GUP, right? If so I got the below list:

Loongarch - I didn't see explicit memory barrier, but it does IPI
MIPS - as same as Loongarch
PowerPC - has memory barrier
x86 - atomic operations imply memory barrier
Arm - I didn't see explicit memory barrier, not sure if ARM's tlb
flush instructions imply memory barrier or not, but it does IPI
Arm64 - uses DSB as David mentioned
s390 - executes IDTE as David mentioned

So I think the questionable architectures are Loongarch, MIPS and ARM.
And IPI is not called if the PMD entry is not present on a remote CPU.
So they may have race against fast GUP IIUC. But we'd better double
check with the maintainers.

>
> --
> Thanks,
>
> David / dhildenb
>
