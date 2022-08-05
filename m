Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9343258AE33
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiHEQbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241420AbiHEQaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21460D75
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659717012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLBK3y06oewrdTqiS5Eur6v+Y+JKLw+q+kw7LKVARhI=;
        b=AAyG2pMcEbz9g6rcU7b57HgEOIFn46Pnli7Gw7XW8fhGB7BCMVztR/Vc+tOaUmZjMDwXRn
        LbpjcHNW84i6mz0bDiVTQ3TNokVkWsD2iuQ7Ag3vPfavlAzNfjnzRmnUNcS5r8NBvI+6o5
        EQnjyUTw0G97Ncj2T31TQ1sZx6b5UVw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-hRD-PeUzOI2XmI12Zoty9g-1; Fri, 05 Aug 2022 12:30:11 -0400
X-MC-Unique: hRD-PeUzOI2XmI12Zoty9g-1
Received: by mail-qk1-f198.google.com with SMTP id br36-20020a05620a462400b006b5fa8e5dd5so2347316qkb.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=QLBK3y06oewrdTqiS5Eur6v+Y+JKLw+q+kw7LKVARhI=;
        b=o6v5ya0Wcyd2KHlgDRS+if4y3cj0CTOve6PDjnNbdWVLhhTsy/C+JopqLtzlHLuId2
         b7/94fh6tDsvoZW2zjeWO8PjkQBIqZZsPAxQE8wTWgq/ja+T+bQLwiwIFNMxgE10p213
         0VsxbhsFyKGPNDpzr65mBrIlSGjslXzABa+QyZtEu2AcZZULGqu1hA3VyC2fPF1gywz8
         u+FqbboWPfWqcEyXYHQvgoAGy55XYx0X7rrAfrcw1bHhoIs1guwQF6FGLhTbu2W7Ui9N
         H6wficRn8B5CIwiIEWweHSA4UBIxEk3b92KUsIaKgy3UFoSN3d1bMMtxzgh9oKMILMKC
         xFRg==
X-Gm-Message-State: ACgBeo0izz/ukiGcsl+4cc5bfEypF0V6YaY49C7mstfJttdZwnig4QV3
        oqtj0ra7snfbhZytA323oANPi10A/t6voxD79eTbcp/tEyyViU7obDJEBkuF/95TL2z54xK0pKx
        c2ysnmLBEL7nLVRa9Pgcg7nhk
X-Received: by 2002:a05:620a:404d:b0:6a7:d3d:df9b with SMTP id i13-20020a05620a404d00b006a70d3ddf9bmr5539919qko.530.1659717010590;
        Fri, 05 Aug 2022 09:30:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zbYHH6346SGrZSYnDtUFlIw87LqOAw1abHdw2afxGDi1D819B+4fFErIVtH+D97Chhrs7Ag==
X-Received: by 2002:a05:620a:404d:b0:6a7:d3d:df9b with SMTP id i13-20020a05620a404d00b006a70d3ddf9bmr5539902qko.530.1659717010277;
        Fri, 05 Aug 2022 09:30:10 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a425000b006b60e1cf2c2sm2954502qko.0.2022.08.05.09.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:30:09 -0700 (PDT)
Date:   Fri, 5 Aug 2022 12:30:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 2/2] mm: Remember young/dirty bit for page migrations
Message-ID: <Yu1FkCkjJ00+H0sF@xz-m1.local>
References: <20220804203952.53665-1-peterx@redhat.com>
 <20220804203952.53665-3-peterx@redhat.com>
 <A84CB6A0-86C8-4CAB-A977-47495D877C31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A84CB6A0-86C8-4CAB-A977-47495D877C31@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 03:40:57PM -0700, Nadav Amit wrote:
> On Aug 4, 2022, at 1:39 PM, Peter Xu <peterx@redhat.com> wrote:
> 
> > When page migration happens, we always ignore the young/dirty bit settings
> > in the old pgtable, and marking the page as old in the new page table using
> > either pte_mkold() or pmd_mkold(), and keeping the pte clean.
> > 
> > That's fine from functional-wise, but that's not friendly to page reclaim
> > because the moving page can be actively accessed within the procedure.  Not
> > to mention hardware setting the young bit can bring quite some overhead on
> > some systems, e.g. x86_64 needs a few hundreds nanoseconds to set the bit.
> > The same slowdown problem to dirty bits when the memory is first written
> > after page migration happened.
> > 
> > Actually we can easily remember the A/D bit configuration and recover the
> > information after the page is migrated.  To achieve it, define a new set of
> > bits in the migration swap offset field to cache the A/D bits for old pte.
> > Then when removing/recovering the migration entry, we can recover the A/D
> > bits even if the page changed.
> > 
> > One thing to mention is that here we used max_swapfile_size() to detect how
> > many swp offset bits we have, and we'll only enable this feature if we know
> > the swp offset can be big enough to store both the PFN value and the young
> > bit.  Otherwise the A/D bits are dropped like before.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > include/linux/swapops.h | 91 +++++++++++++++++++++++++++++++++++++++++
> > mm/huge_memory.c        | 26 +++++++++++-
> > mm/migrate.c            |  6 ++-
> > mm/migrate_device.c     |  4 ++
> > mm/rmap.c               |  5 ++-
> > 5 files changed, 128 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > index 1d17e4bb3d2f..34aa448ac6ee 100644
> > --- a/include/linux/swapops.h
> > +++ b/include/linux/swapops.h
> > @@ -8,6 +8,8 @@
> > 
> > #ifdef CONFIG_MMU
> > 
> > +#include <linux/swapfile.h>
> 
> Shouldn’t the ifdef go into linux/swapfile.h if that’s the right thing to do
> to prevent others from mistakenly including it?

swapfile.h is for max_swapfile_size() that's referenced in the new code. If
!CONFIG_MMU then there shouldn't be a reference to max_swapfile_size() even
if swapops.h included, then logically it should be after CONFIG_MMU?

> 
> > +
> > /*
> >  * swapcache pages are stored in the swapper_space radix tree.  We want to
> >  * get good packing density in that tree, so the index should be dense in
> > @@ -35,6 +37,24 @@
> > #endif
> > #define SWP_PFN_MASK			((1UL << SWP_PFN_BITS) - 1)
> > 
> > +/**
> > + * Migration swap entry specific bitfield definitions.
> > + *
> > + * @SWP_MIG_YOUNG_BIT: Whether the page used to have young bit set
> > + * @SWP_MIG_DIRTY_BIT: Whether the page used to have dirty bit set
> > + *
> > + * Note: these bits will be stored in migration entries iff there're enough
> > + * free bits in arch specific swp offset.  By default we'll ignore A/D bits
> > + * when migrating a page.  Please refer to migration_entry_supports_ad()
> > + * for more information.
> > + */
> > +#define SWP_MIG_YOUNG_BIT		(SWP_PFN_BITS)
> > +#define SWP_MIG_DIRTY_BIT		(SWP_PFN_BITS + 1)
> > +#define SWP_MIG_TOTAL_BITS		(SWP_PFN_BITS + 2)
> > +
> > +#define SWP_MIG_YOUNG			(1UL << SWP_MIG_YOUNG_BIT)
> > +#define SWP_MIG_DIRTY			(1UL << SWP_MIG_DIRTY_BIT)
> 
> Any reason not to use BIT(x) ?

Yeh why not..

> 
> > +
> > static inline bool is_pfn_swap_entry(swp_entry_t entry);
> > 
> > /* Clear all flags but only keep swp_entry_t related information */
> > @@ -265,6 +285,57 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
> > 	return swp_entry(SWP_MIGRATION_WRITE, offset);
> > }
> > 
> > +/*
> > + * Returns whether the host has large enough swap offset field to support
> > + * carrying over pgtable A/D bits for page migrations.  The result is
> > + * pretty much arch specific.
> > + */
> > +static inline bool migration_entry_supports_ad(void)
> > +{
> > +	/*
> > +	 * max_swapfile_size() returns the max supported swp-offset plus 1.
> > +	 * We can support the migration A/D bits iff the pfn swap entry has
> > +	 * the offset large enough to cover all of them (PFN, A & D bits).
> > +	 */
> > +#ifdef CONFIG_SWAP
> > +	return max_swapfile_size() >= (1UL << SWP_MIG_TOTAL_BITS);
> 
> This is an actual a function call (unless LTO has some trick). A bit of a
> shame it cannot be at least memoized.
> 
> Or at least mark max_swapfile_size() as __attribute_const__ so it would not
> be called twice for make_migration_entry_young() and
> make_migration_entry_dirty().

I didn't take too much effort on this one since we're on swap path and I
assumed that's not a super hot path.  But __attribute_const__ sounds good
and easy to get, thanks.

Perhaps I should mark it on migration_entry_supports_ad() as a whole?  Note
that unfortunately SWP_MIG_TOTAL_BITS may not be a const either (see how
that define roots back to MAX_PHYSMEM_BITS, where on x86_64 it needs to
check 5-lvl).

> 
> > +#else
> > +	return false;
> > +#endif
> > +}
> > +
> > +static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
> > +{
> > +	if (migration_entry_supports_ad())
> > +		return swp_entry(swp_type(entry),
> > +				 swp_offset(entry) | SWP_MIG_YOUNG);
> > +	return entry;
> > +}
> > +
> > +static inline bool is_migration_entry_young(swp_entry_t entry)
> > +{
> > +	if (migration_entry_supports_ad())
> > +		return swp_offset(entry) & SWP_MIG_YOUNG;
> > +	/* Keep the old behavior of aging page after migration */
> > +	return false;
> > +}
> > +
> > +static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
> > +{
> > +	if (migration_entry_supports_ad())
> > +		return swp_entry(swp_type(entry),
> > +				 swp_offset(entry) | SWP_MIG_DIRTY);
> > +	return entry;
> > +}
> > +
> > +static inline bool is_migration_entry_dirty(swp_entry_t entry)
> > +{
> > +	if (migration_entry_supports_ad())
> > +		return swp_offset(entry) & SWP_MIG_YOUNG_BIT;
> 
> Shouldn’t it be SWP_MIG_DIRTY ?

Oops, yes.

> 
> > +	/* Keep the old behavior of clean page after migration */
> > +	return false;
> > +}
> > +
> > extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
> > 					spinlock_t *ptl);
> > extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
> > @@ -311,6 +382,26 @@ static inline int is_readable_migration_entry(swp_entry_t entry)
> > 	return 0;
> > }
> > 
> > +static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
> > +{
> > +	return entry;
> > +}
> > +
> > +static inline bool is_migration_entry_young(swp_entry_t entry)
> > +{
> > +	return false;
> > +}
> > +
> > +static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
> > +{
> > +	return entry;
> > +}
> > +
> > +static inline bool is_migration_entry_dirty(swp_entry_t entry)
> > +{
> > +	return false;
> > +}
> > +
> > #endif
> 
> While at it, can you change to:
> 
> #endif /* CONFIG_MIGRATION */
> 
> [ these ifdefs burn my eyes ]

Ok, but there're a bunch of "ifdef"s in this header that are missing those.
Maybe I'll add a separate patch for all of them just to do the commenting.

> 
> Other than that looks good.

Thanks,

-- 
Peter Xu

