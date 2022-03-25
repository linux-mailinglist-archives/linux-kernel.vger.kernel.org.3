Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F034E6F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354595AbiCYHpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiCYHpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:45:00 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289D43CFC0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:43:27 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id z8so12618381ybh.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Am0L9ligemASqtUdJYFc236DAhyGFKoE3Ccf35F1C6w=;
        b=Uq+OITyfpzuTELkA8wF9pc0m+o/xFTC70oLMbh2xskCEGMyjFzdzgbvr7sKJ3B8ZKs
         rE9Aizm4O6kZBa9okUHVY0gwnMA1KMqNMb0fSOYdCSqJDKfO4c5wPPyNsGF6W82/oCUj
         XM5aUtbGSNGo7XTF5SkMIftNT2rxMvW4bF1/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Am0L9ligemASqtUdJYFc236DAhyGFKoE3Ccf35F1C6w=;
        b=cw3qHhoCndOxR7WYc4PEYDTIvMdVsCDZuJsy6pnVDCxEVCGtZDjax476nKDE6C7zBD
         f6vmjWhnDQFbsp/1nwdKB17kaVjMmwfzlecYCOOukDT+wF9N2KWt05ph0m+AiRgRUO2F
         cCCx/ioGQ30FhlfZkTRlVSRY00a7KKxyTzlsz/WDKaPPdNK+NbYvR/24BbN694Fy3Sc7
         +rFF+BSF+wQfRQay5qUKgVZ3YbrBClZ2mMFDrmynjIgt1KzOdvnPoSPM7M8Mc50+5QDt
         GtMO52093tZ8aS+zoQLE6VLVIiQYhY/zN9gd3M/TTdFlK3YZOvorRtobxGndFfGmHEgt
         Zo2A==
X-Gm-Message-State: AOAM530EeCcKGCQdByVdPfKZGbyWof0TErcMq80C+hJYSAAUnlYU0mZE
        zjjgP0UI7ZFUz3RAteoI1pndaV1hYzUuaR77Fcc+pA==
X-Google-Smtp-Source: ABdhPJyqOgFRVDd45FmufhY5GTrXj9stUYT0oewf28eZCCtvQS4mIdD0SmV9zTIJliXbUngg1JdOfaMLh+zCKvLMa4E=
X-Received: by 2002:a05:6902:724:b0:635:1972:616f with SMTP id
 l4-20020a056902072400b006351972616fmr8984769ybt.453.1648194206434; Fri, 25
 Mar 2022 00:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220322063555.1422042-1-stevensd@google.com> <BN9PR11MB52761E41CAD28CFCB935688C8C1A9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <MW5PR11MB58814148CD05C8284C3BCB23891A9@MW5PR11MB5881.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB58814148CD05C8284C3BCB23891A9@MW5PR11MB5881.namprd11.prod.outlook.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Fri, 25 Mar 2022 16:43:16 +0900
Message-ID: <CAD=HUj5dPb9jsUyh5REm=dX0HJaqW807LxnAouQ9rspMHB7vuw@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
To:     "Zhang, Tina" <tina.zhang@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 4:15 PM Zhang, Tina <tina.zhang@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: iommu <iommu-bounces@lists.linux-foundation.org> On Behalf Of
> > Tian, Kevin
> > Sent: Friday, March 25, 2022 2:14 PM
> > To: David Stevens <stevensd@chromium.org>; Lu Baolu
> > <baolu.lu@linux.intel.com>
> > Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
> >
> > > From: David Stevens
> > > Sent: Tuesday, March 22, 2022 2:36 PM
> > >
> > > From: David Stevens <stevensd@chromium.org>
> > >
> > > Calculate the appropriate mask for non-size-aligned page selective
> > > invalidation. Since psi uses the mask value to mask out the lower
> > > order bits of the target address, properly flushing the iotlb requires
> > > using a mask value such that [pfn, pfn+pages) all lie within the
> > > flushed size-aligned region.  This is not normally an issue because
> > > iova.c always allocates iovas that are aligned to their size. However,
> > > iovas which come from other sources (e.g. userspace via VFIO) may not
> > > be aligned.
> > >
> > > Signed-off-by: David Stevens <stevensd@chromium.org>
> > > ---
> > > v1 -> v2:
> > >  - Calculate an appropriate mask for non-size-aligned iovas instead
> > >    of falling back to domain selective flush.
> > >
> > >  drivers/iommu/intel/iommu.c | 27 ++++++++++++++++++++++++---
> > >  1 file changed, 24 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > > index 5b196cfe9ed2..ab2273300346 100644
> > > --- a/drivers/iommu/intel/iommu.c
> > > +++ b/drivers/iommu/intel/iommu.c
> > > @@ -1717,7 +1717,8 @@ static void iommu_flush_iotlb_psi(struct
> > > intel_iommu *iommu,
> > >                               unsigned long pfn, unsigned int pages,
> > >                               int ih, int map)
> > >  {
> > > -   unsigned int mask = ilog2(__roundup_pow_of_two(pages));
> > > +   unsigned int aligned_pages = __roundup_pow_of_two(pages);
> > > +   unsigned int mask = ilog2(aligned_pages);
> > >     uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
> > >     u16 did = domain->iommu_did[iommu->seq_id];
> > >
> > > @@ -1729,10 +1730,30 @@ static void iommu_flush_iotlb_psi(struct
> > > intel_iommu *iommu,
> > >     if (domain_use_first_level(domain)) {
> > >             domain_flush_piotlb(iommu, domain, addr, pages, ih);
> > >     } else {
> > > +           unsigned long bitmask = aligned_pages - 1;
> > > +
> > > +           /*
> > > +            * PSI masks the low order bits of the base address. If the
> > > +            * address isn't aligned to the mask, then compute a mask
> > > value
> > > +            * needed to ensure the target range is flushed.
> > > +            */
> > > +           if (unlikely(bitmask & pfn)) {
> > > +                   unsigned long end_pfn = pfn + pages - 1, shared_bits;
> > > +
> > > +                   /*
> > > +                    * Since end_pfn <= pfn + bitmask, the only way bits
> > > +                    * higher than bitmask can differ in pfn and end_pfn
> > > is
> > > +                    * by carrying. This means after masking out bitmask,
> > > +                    * high bits starting with the first set bit in
> > > +                    * shared_bits are all equal in both pfn and end_pfn.
> > > +                    */
> > > +                   shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
> > > +                   mask = shared_bits ? __ffs(shared_bits) :
> > > BITS_PER_LONG;
> > > +           }
> >
> > While it works I wonder whether below is simpler regarding to readability:
> >
> >       } else {
> > +             /*
> > +              * PSI masks the low order bits of the base address. If the
> > +              * address isn't aligned to the mask and [pfn, pfn+pages)
> > +              * don't all lie within the flushed size-aligned region,
> > +              * simply increment the mask by one to cover the trailing
> > pages.
> > +              */
> > +             if (unlikely((pfn & (aligned_pages - 1)) &&
> > +                          (pfn + pages - 1 >= ALIGN(pfn, aligned_pages))))
> > +                     mask++;
>
> According to the vt-d spec, increasing mask means more bits of the pfn would be masked out. So simply increasing the mask number might not be correct.
> This second version does give more consideration on that.
>

Right, this is what the more complicated code handles. For a concrete
example, if pfn=0x17f and pages=2, just doing mask+1 would only flush
[0x17c, 0x17f], which still misses 0x180. To ensure 0x180 is flushed,
mask needs to be 8.

-David


-David
