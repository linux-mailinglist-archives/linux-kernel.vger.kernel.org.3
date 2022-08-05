Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D3458AE3D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbiHEQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiHEQg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66FDC18342
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659717414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Tfx8xV8I3dUG2KlFo6XKUZmlUBS6xXBNsMNZTg5/+M=;
        b=fF4xoRrciAya4NNirWZlJqtDw7YtoxCmdWb+YF7z+YvpQT8aOLmpK6HHT0YHlS7n/58Xc0
        qCoM2wFMZT87Kwr7OS2MgVOpVFWV1ZnVubhjTm/lz6Bt+aFgJmYkk5rkPM2KMJ/cIG0O3z
        QsmXq8IMJYyLX0gVOKWQ4PoB1Khgor4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-ukUQI7VZPfK42IQQAXBPbQ-1; Fri, 05 Aug 2022 12:36:53 -0400
X-MC-Unique: ukUQI7VZPfK42IQQAXBPbQ-1
Received: by mail-qt1-f197.google.com with SMTP id bl15-20020a05622a244f00b0034218498b06so2262615qtb.14
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=8Tfx8xV8I3dUG2KlFo6XKUZmlUBS6xXBNsMNZTg5/+M=;
        b=RE/RHlLBCWGGXya7QnVA3D9zU3uxh79YdK64q77+tl7IcGgLpR6PEeFHhFaXi7E9i0
         T73Ar2Yq9GplwgomoW+Uox8yP1ZK5jUb9W2EZSkTnMM9LM/+O6ZmXimr+Nwrrg1Eb2TJ
         OEHrDLT5QlX+tYpmBz0aFnFiT14H+cvWEHDnCElsXGHfX4XOdEnD96SzS8MhCaEHYNd+
         6/UYiGw2pG/csi8dOtAz+FVT/CCLkIzZ4H5vD+8lXuTswsygwq93LNXI2xbqWxhtVTRb
         0o29Lua4SA13V3Pd/HbYyEsF+iFqxpBZpbtI1YE4lvChy+j4FvnIX9T8ACzitMCbEqtR
         lzjw==
X-Gm-Message-State: ACgBeo0zCXVTq/u8u9A4pP4a4992YrRpfBJtL7Gj52tq/F0NOsYhuX8U
        Hhhyi7Gfo94UFgtKgxrRTTyGobLWuK8pr7Xfnhz8GJ864XYSOB5Npy5QPYMOttvX3IYsI+OcK2i
        /TkFYxtrGrTajbKehX0qH1C59
X-Received: by 2002:a05:622a:174a:b0:31e:f68d:66c with SMTP id l10-20020a05622a174a00b0031ef68d066cmr6738127qtk.476.1659717413007;
        Fri, 05 Aug 2022 09:36:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4hT/jkBcfkO40XTgJXLXq45NwcY6dfXm4fsskstjmPEI2oo9ap8a75LXWY8jXj1QwbDVn7wQ==
X-Received: by 2002:a05:622a:174a:b0:31e:f68d:66c with SMTP id l10-20020a05622a174a00b0031ef68d066cmr6738086qtk.476.1659717412418;
        Fri, 05 Aug 2022 09:36:52 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id az38-20020a05620a172600b006b8619a67f4sm3050478qkb.34.2022.08.05.09.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:36:51 -0700 (PDT)
Date:   Fri, 5 Aug 2022 12:36:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 2/2] mm: Remember young/dirty bit for page migrations
Message-ID: <Yu1HIiWt9t1IE9RE@xz-m1.local>
References: <20220804203952.53665-1-peterx@redhat.com>
 <20220804203952.53665-3-peterx@redhat.com>
 <62d52657-12d2-8563-4ead-027480065d9f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62d52657-12d2-8563-4ead-027480065d9f@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 02:17:55PM +0200, David Hildenbrand wrote:
> On 04.08.22 22:39, Peter Xu wrote:
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
> >  include/linux/swapops.h | 91 +++++++++++++++++++++++++++++++++++++++++
> >  mm/huge_memory.c        | 26 +++++++++++-
> >  mm/migrate.c            |  6 ++-
> >  mm/migrate_device.c     |  4 ++
> >  mm/rmap.c               |  5 ++-
> >  5 files changed, 128 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > index 1d17e4bb3d2f..34aa448ac6ee 100644
> > --- a/include/linux/swapops.h
> > +++ b/include/linux/swapops.h
> > @@ -8,6 +8,8 @@
> >  
> >  #ifdef CONFIG_MMU
> >  
> > +#include <linux/swapfile.h>
> > +
> >  /*
> >   * swapcache pages are stored in the swapper_space radix tree.  We want to
> >   * get good packing density in that tree, so the index should be dense in
> > @@ -35,6 +37,24 @@
> >  #endif
> >  #define SWP_PFN_MASK			((1UL << SWP_PFN_BITS) - 1)
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
> > +
> >  static inline bool is_pfn_swap_entry(swp_entry_t entry);
> >  
> >  /* Clear all flags but only keep swp_entry_t related information */
> > @@ -265,6 +285,57 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
> >  	return swp_entry(SWP_MIGRATION_WRITE, offset);
> >  }
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
> > +#else
> > +	return false;
> > +#endif
> > +}
> 
> 
> This looks much cleaner to me. It might be helpful to draw an ascii
> picture where exatcly these bits reside isnide the offset.

Yes that'll be helpful especially when more bits are defined.  Not sure how
much it'll help for now but I can definitely do that.

> 
> > +
> > +static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
> > +{
> > +	if (migration_entry_supports_ad())
> 
> Do we maybe want to turn that into a static key and enable it once and
> for all? As Nadav says, the repeated max_swapfile_size() calls/checks
> might be worth optimizing out.

Since there're a few arch related issues to answer (as replied to Nadav -
both max_swapfile_size and SWP_MIG_TOTAL_BITS may not be constant), my
current plan is to first attach the const attribute, then leave the other
optimizations for later.

If this is a super hot path, I probably need to do this in reversed order,
but hopefully it's fine to this case.

Thanks,

-- 
Peter Xu

