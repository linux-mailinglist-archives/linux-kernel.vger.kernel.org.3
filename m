Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B0E5AF433
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIFTIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIFTH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:07:59 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229BA94113
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:07:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q15so12308525pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+LExFB3WXp3T7gCoJCydAHNw4AB8S5PeyGA7mfZmRbE=;
        b=lTAA0fuW7g/gwWENQo+zDCGieAHeVZbiouutXKWJr8M5fjde5M3tbQX0btS7OhMtgX
         jRHPI5czBdH/BaylZMG33nsfU9syxYiziF5mWABnGjaQ+12s6ld1/XFSat+Qe/1GqqZu
         IzK6oMt3tvOfKC9eMJq9U8yClKnS0CJy3pUxR07H9EfWdyiertQ7fVd7XRAolF+XYikz
         YdFAOO47HeJzD4PoMUBXSlN0aRyCb+iyfUkWgeOxnNhN35BiMhmDggIonJpqT5N2f8Tr
         sKhHl9X0tS1rak3/oDWKPGOgWxKf52/wI3wspMPgZaZ3UIiiNswMGm+gRiUDTr9HotlI
         gstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+LExFB3WXp3T7gCoJCydAHNw4AB8S5PeyGA7mfZmRbE=;
        b=xeGxiEb7d3De7UG8ccXN2lD1LTHq8y8YrSHe0oJBS4aPYmsTPlpqohju7r23VGKdla
         TGQeBv3entIEbDRBeGwQ9uLwuJQkrtqlvLFiNW3HY0wu7qcX7CBb3UjDfXhqgEdht//f
         CQkAlO4596eLewPsF+Bb2AKCgJOhmGgMyRkCzZC1da/xk9fWUBOi09IAGmVscXP2qQqz
         kVWZbVR+xTmD3wp+xaDJ4Cs+oMAAgRgQuZv+trPJop1zlYkZxtPU+x0saTjO7wuivuvH
         GBJGFIztebyYe5ts1wjcaf5fgFw9LG47ya8Tm2uwG8lu+Cco4shH67PyyUjsCaf//m8N
         qLsQ==
X-Gm-Message-State: ACgBeo14shP2rRQs+NiizhIDdzUgyn45W+UPUaYnW8tOCrokVt6QKKM8
        LKYJ02qI90ZRJCTnRxfahUx57eraNx6UQXU4zgYTAwzWrA4=
X-Google-Smtp-Source: AA6agR7Jny9YtUnb/OOL40e4uvXY8tR6Se1dWL4hNRVsKo2jSEkqYOHqb3RgU5uRdTMbCnabdRkl+Ma6QcrfL+TQJ/A=
X-Received: by 2002:a63:91c7:0:b0:42b:9e30:580f with SMTP id
 l190-20020a6391c7000000b0042b9e30580fmr96674pge.206.1662491277642; Tue, 06
 Sep 2022 12:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220901222707.477402-1-shy828301@gmail.com> <YxE/vuQlWJCJMuG2@xz-m1.local>
 <CAHbLzkqjZ_UhUbJ_f9Br7WCAgQvjrm5bMPRsKYvaFc2bzSuzrw@mail.gmail.com>
 <YxIofPiI8jvGzcjC@xz-m1.local> <CAHbLzkqGdnwY4P8jKQR0ojm6QV6b3dBi5pwrC1UJ4dqi3EqS4w@mail.gmail.com>
 <87ilm2jj4t.fsf@linux.ibm.com>
In-Reply-To: <87ilm2jj4t.fsf@linux.ibm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 6 Sep 2022 12:07:44 -0700
Message-ID: <CAHbLzkohKvOFyfsVr=ry8Goi6kgxh9ig84FX0+pY4qzL4i0xWg@mail.gmail.com>
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Peter Xu <peterx@redhat.com>, david@redhat.com,
        kirill.shutemov@linux.intel.com, jhubbard@nvidia.com,
        jgg@nvidia.com, hughd@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Mon, Sep 5, 2022 at 1:56 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> >
> > On Fri, Sep 2, 2022 at 9:00 AM Peter Xu <peterx@redhat.com> wrote:
> >>
> >> On Thu, Sep 01, 2022 at 04:50:45PM -0700, Yang Shi wrote:
> >> > On Thu, Sep 1, 2022 at 4:26 PM Peter Xu <peterx@redhat.com> wrote:
> >> > >
> >> > > Hi, Yang,
> >> > >
> >> > > On Thu, Sep 01, 2022 at 03:27:07PM -0700, Yang Shi wrote:
> >> > > > Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
> >> > > > introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
> >> > > > sufficient to handle concurrent GUP-fast in all cases, it only handles
> >> > > > traditional IPI-based GUP-fast correctly.
> >> > >
> >> > > If TLB flush (or, IPI broadcasts) used to work to protect against gup-fast,
> >> > > I'm kind of confused why it's not sufficient even if with RCU gup?  Isn't
> >> > > that'll keep working as long as interrupt disabled (which current fast-gup
> >> > > will still do)?
> >> >
> >> > Actually the wording was copied from David's commit log for his
> >> > PageAnonExclusive fix. My understanding is the IPI broadcast still
> >> > works, but it may not be supported by all architectures and not
> >> > preferred anymore. So we should avoid depending on IPI broadcast IIUC.
> >> >
> >> > >
> >> > > IIUC the issue is you suspect not all archs correctly implemented
> >> > > pmdp_collapse_flush(), or am I wrong?
> >> >
> >> > This is a possible fix, please see below for details.
> >> >
> >> > >
> >> > > > On architectures that send
> >> > > > an IPI broadcast on TLB flush, it works as expected.  But on the
> >> > > > architectures that do not use IPI to broadcast TLB flush, it may have
> >> > > > the below race:
> >> > > >
> >> > > >    CPU A                                          CPU B
> >> > > > THP collapse                                     fast GUP
> >> > > >                                               gup_pmd_range() <-- see valid pmd
> >> > > >                                                   gup_pte_range() <-- work on pte
> >> > > > pmdp_collapse_flush() <-- clear pmd and flush
> >> > > > __collapse_huge_page_isolate()
> >> > > >     check page pinned <-- before GUP bump refcount
> >> > > >                                                       pin the page
> >> > > >                                                       check PTE <-- no change
> >> > > > __collapse_huge_page_copy()
> >> > > >     copy data to huge page
> >> > > >     ptep_clear()
> >> > > > install huge pmd for the huge page
> >> > > >                                                       return the stale page
> >> > > > discard the stale page
> >> > > >
> >> > > > The race could be fixed by checking whether PMD is changed or not after
> >> > > > taking the page pin in fast GUP, just like what it does for PTE.  If the
> >> > > > PMD is changed it means there may be parallel THP collapse, so GUP
> >> > > > should back off.
> >> > >
> >> > > Could the race also be fixed by impl pmdp_collapse_flush() correctly for
> >> > > the archs that are missing? Do you know which arch(s) is broken with it?
> >> >
> >> > Yes, and this was suggested by me in the first place, but per the
> >> > suggestion from John and David, this is not the preferred way. I think
> >> > it is because:
> >> >
> >> > Firstly, using IPI to serialize against fast GUP is not recommended
> >> > anymore since fast GUP does check PTE then back off so we should avoid
> >> > it.
> >> > Secondly, if checking PMD then backing off could solve the problem,
> >> > why do we still need broadcast IPI? It doesn't sound performant.
> >> >
> >> > >
> >> > > It's just not clear to me whether this patch is an optimization or a fix,
> >> > > if it's a fix whether the IPI broadcast in ppc pmdp_collapse_flush() would
> >> > > still be needed.
> >> >
> >> > It is a fix and the fix will make IPI broadcast not useful anymore.
> >>
> >> How about another patch to remove the ppc impl too?  Then it can be a two
> >> patches series.
> >
> > BTW, I don't think we could remove the ppc implementation since it is
> > different from the generic pmdp_collapse_flush(), particularly for the
> > hash part IIUC.
> >
> > The generic version calls flush_tlb_range() -> hash__flush_tlb_range()
> > for hash, but the hash call is actually no-op. The ppc version calls
> > hash__pmdp_collapse_flush() -> flush_tlb_pmd_range(), which does
> > something useful.
> >
>
> We should actually rename flush_tlb_pmd_range(). It actually flush the
> hash page table entries.
>
> I will do the below patch for ppc64 to clarify this better

Thanks, Aneesh. It looks more readable. A follow-up question, I think
we could remove serialize_against_pte_lookup(), which just issues IPI
broadcast to run a dummy function. This IPI should not be needed
anymore with my patch. Of course, we need to keep the memory barrier.

>
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> index 8b762f282190..fd30fa20c392 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> @@ -112,13 +112,12 @@ static inline void hash__flush_tlb_kernel_range(unsigned long start,
>
>  struct mmu_gather;
>  extern void hash__tlb_flush(struct mmu_gather *tlb);
> -void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr);
>
>  #ifdef CONFIG_PPC_64S_HASH_MMU
>  /* Private function for use by PCI IO mapping code */
>  extern void __flush_hash_table_range(unsigned long start, unsigned long end);
> -extern void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd,
> -                               unsigned long addr);
> +extern void flush_hash_table_pmd_range(struct mm_struct *mm, pmd_t *pmd,
> +                                      unsigned long addr);
>  #else
>  static inline void __flush_hash_table_range(unsigned long start, unsigned long end) { }
>  #endif
> diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
> index ae008b9df0e6..f30131933a01 100644
> --- a/arch/powerpc/mm/book3s64/hash_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
> @@ -256,7 +256,7 @@ pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addres
>          * the __collapse_huge_page_copy can result in copying
>          * the old content.
>          */
> -       flush_tlb_pmd_range(vma->vm_mm, &pmd, address);
> +       flush_hash_table_pmd_range(vma->vm_mm, &pmd, address);
>         return pmd;
>  }
>
> diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
> index eb0bccaf221e..a64ea0a7ef96 100644
> --- a/arch/powerpc/mm/book3s64/hash_tlb.c
> +++ b/arch/powerpc/mm/book3s64/hash_tlb.c
> @@ -221,7 +221,7 @@ void __flush_hash_table_range(unsigned long start, unsigned long end)
>         local_irq_restore(flags);
>  }
>
> -void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
> +void flush_hash_table_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
>  {
>         pte_t *pte;
>         pte_t *start_pte;
>
