Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1746F575D75
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiGOI32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiGOI3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:29:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9BF5885E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657873764; x=1689409764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=unf53x4o1mo9OvqXE99tnKwyqyec5nc6m4hit56NSFw=;
  b=aI/jznXuEJS69AoPwM6KZthyPCjfLJWTBGKNbMXEVW3XK0qOS+hM+zn+
   chV1tDprRKWwjv1/pVzokmJKv9a9M5ydiRDpG/YEUqg8y76U1wqK/jjsy
   XVxsGLtTFGOchwK++WNf1cWbVBLgoZF6hG+4dHuDYe7SnIhTQ57yUql3q
   xqxiauLVS23d9Qx00TLmFc/V4nguC5xwu4ftXzydPvGohfnNRolk3+4N3
   yh8INaJTLYGi66mKFj+WY+qxf1lhDyKw47+AIR2TeuZrvKa/bCdtacUve
   ef4YDN9L/1O6DWRcQWFVlCxsW0ce4h5Bqx2KW7vqK6NfBY/l8mU/+ii+v
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="268760047"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="268760047"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 01:29:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="571438868"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by orsmga006.jf.intel.com with ESMTP; 15 Jul 2022 01:29:20 -0700
Date:   Fri, 15 Jul 2022 16:29:22 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v1] mm/slub: enable debugging memory wasting of kmalloc
Message-ID: <20220715082922.GA88035@shbuild999.sh.intel.com>
References: <20220701135954.45045-1-feng.tang@intel.com>
 <41763154-f923-ae99-55c0-0f3717636779@suse.cz>
 <20220713073642.GA69088@shbuild999.sh.intel.com>
 <45906408-34ce-4b79-fbe4-768335ffbf96@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45906408-34ce-4b79-fbe4-768335ffbf96@suse.cz>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 10:11:32PM +0200, Vlastimil Babka wrote:
> On 7/13/22 09:36, Feng Tang wrote:
> > Hi Vlastimil,
> > 
> > On Mon, Jul 11, 2022 at 10:15:21AM +0200, Vlastimil Babka wrote:
> >> On 7/1/22 15:59, Feng Tang wrote:
> >> > kmalloc's API family is critical for mm, with one shortcoming that
> >> > its object size is fixed to be power of 2. When user requests memory
> >> > for '2^n + 1' bytes, actually 2^(n+1) bytes will be allocated, so
> >> > in worst case, there is around 50% memory space waste.
> >> > 
> >> > We've met a kernel boot OOM panic (v5.10), and from the dumped slab info:
> >> > 
> >> >     [   26.062145] kmalloc-2k            814056KB     814056KB
> >> > 
> >> > From debug we found there are huge number of 'struct iova_magazine',
> >> > whose size is 1032 bytes (1024 + 8), so each allocation will waste
> >> > 1016 bytes. Though the issue was solved by giving the right (bigger)
> >> > size of RAM, it is still nice to optimize the size (either use a
> >> > kmalloc friendly size or create a dedicated slab for it).
> > [...]
> >> 
> >> Hi and thanks.
> >> I would suggest some improvements to consider:
> >> 
> >> - don't use the struct track to store orig_size, although it's an obvious
> >> first choice. It's unused waste for the free_track, and also for any
> >> non-kmalloc caches. I'd carve out an extra int next to the struct tracks.
> >> Only for kmalloc caches (probably a new kmem cache flag set on creation will
> >> be needed to easily distinguish them).
> >> Besides the saved space, you can then set the field from ___slab_alloc()
> >> directly and not need to pass the orig_size also to alloc_debug_processing()
> >> etc.
> >  
> > Here is a draft patch fowlling your suggestion, please check if I missed
> > anything? (Quick test showed it achived similar effect as v1 patch). Thanks!
> 
> Thanks, overal it looks at first glance!

Thanks!

> > ---
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 0fefdf528e0d..d3dacb0f013f 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -29,6 +29,8 @@
> >  #define SLAB_RED_ZONE		((slab_flags_t __force)0x00000400U)
> >  /* DEBUG: Poison objects */
> >  #define SLAB_POISON		((slab_flags_t __force)0x00000800U)
> > +/* Indicate a slab of kmalloc */
> 
> "Indicate a kmalloc cache" would be more precise.
 
Will use this in next version.

> > +#define SLAB_KMALLOC		((slab_flags_t __force)0x00001000U)
> >  /* Align objs on cache lines */
> >  #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
> >  /* Use GFP_DMA memory */
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 26b00951aad1..3b0f80927817 100644
> 
> <snip>
> 
> > 
> >> - the knowledge of actual size could be used to improve poisoning checks as
> >> well, detect cases when there's buffer overrun over the orig_size but not
> >> cache's size. e.g. if you kmalloc(48) and overrun up to 64 we won't detect
> >> it now, but with orig_size stored we could?
> > 
> > The above patch doesn't touch this. As I have a question, for the
> > [orib_size, object_size) area, shall we fill it with POISON_XXX no matter
> > REDZONE flag is set or not?
> 
> Ah, looks like we use redzoning, not poisoning, for padding from
> s->object_size to word boundary. So it would be more consistent to use the
> redzone pattern (RED_ACTIVE) and check with the dynamic orig_size. Probably
> no change for RED_INACTIVE handling is needed though.

Thanks for clarifying, will go this way and do more test. Also I'd 
make it a separate patch, as it is logically different from the space
wastage.

Thanks,
Feng
