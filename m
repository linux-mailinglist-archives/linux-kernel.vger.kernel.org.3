Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8A0560F95
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 05:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiF3DXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 23:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiF3DXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:23:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D1617E2D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 20:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656559400; x=1688095400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kt86ua8WgIQ6xNJV4KsVEmxVoqhINuYbDD56u/ebnzM=;
  b=JHpEcGJlB311+9c4kQ6uXGnP2vOiFxdmg9H3eyC9sD1kQAqlJJN21Vcx
   BdKCninGkafOE2NFENFx6+zEVgr3LVo7kqakfKB8xFjuBJmSd+ceBFNLK
   BXAycXAj4utaXPWroTA9+u1hGjVUfCxhrjxSFH6YhEw/3u5gKctr/8Po5
   1UfMR/KHZeHj6675HvpMBbsFoytHSESyPLCkgeJoFbrl0IHhQDWE1InZg
   AYh5iZ0E+9BX9GYni+FMbKJJ8TNr0Hk8FieHzN1JU5dXixtKWyAAoQlEV
   tCFM08LIrFD1nDrag/m/xPmGspSXt8BUPibdW+cza5PyDzZXGo/J55IOZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="343915558"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="343915558"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 20:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="647690885"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2022 20:23:16 -0700
Date:   Thu, 30 Jun 2022 11:23:15 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] mm/slub: enable debugging memory wasting of kmalloc
Message-ID: <20220630032315.GB4668@shbuild999.sh.intel.com>
References: <20220630014715.73330-1-feng.tang@intel.com>
 <20220629193006.77e9f071a5940e882c459cdd@linux-foundation.org>
 <20220630023844.GA4668@shbuild999.sh.intel.com>
 <20220629194747.62effc10a994f67e26fe96af@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629194747.62effc10a994f67e26fe96af@linux-foundation.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 07:47:47PM -0700, Andrew Morton wrote:
> On Thu, 30 Jun 2022 10:38:44 +0800 Feng Tang <feng.tang@intel.com> wrote:
> 
> > Hi Andrew,
> > 
> > Thanks for the review!
> > 
> > On Wed, Jun 29, 2022 at 07:30:06PM -0700, Andrew Morton wrote:
> > > On Thu, 30 Jun 2022 09:47:15 +0800 Feng Tang <feng.tang@intel.com> wrote:
> > > 
> > > > kmalloc's API family is critical for mm, with one shortcoming that
> > > > its object size is fixed to be power of 2. When user requests memory
> > > > for '2^n + 1' bytes, actually 2^(n+1) bytes will be allocated, so
> > > > in worst case, there is around 50% memory space waste.
> > > > 
> > > > We've met a kernel boot OOM panic, and from the dumped slab info:
> > > > 
> > > >     [   26.062145] kmalloc-2k            814056KB     814056KB
> > > > 
> > > > >From debug we found there are huge number of 'struct iova_magazine',
> > > > whose size is 1032 bytes (1024 + 8), so each allocation will waste
> > > > 1016 bytes. Though the issue is solved by giving the right(bigger)
> > > > size of RAM, it is still better to optimize the size (either use
> > > > a kmalloc friendly size or create a dedicated slab for it).
> > > 
> > > Well that's nice, and additional visibility is presumably a good thing.
> > > 
> > > But what the heck is going on with iova_magazine?  Is anyone looking at
> > > moderating its impact?
> > 
> > Yes, I have a very simple patch at hand
> > 
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -614,7 +614,7 @@ EXPORT_SYMBOL_GPL(reserve_iova);
> >   * dynamic size tuning described in the paper.
> >   */
> >  
> > -#define IOVA_MAG_SIZE 128
> > +#define IOVA_MAG_SIZE 127
> 
> Well OK.  Would benefit from a comment explaining the reasoning.
 
Sure, will try to give the full context.

> But we still have eleventy squillion of these things in flight.  Why?

I've checked the waste info right after boot for desktop/server, the
waste is not severe generally, and I didn't even find 'iova_magzine'
(could be due to it's virtulization related).  

When dockers are started to run workload, more kmalloc is invoked
and the waste increases accordingly.

Another case that can benefit is budget devices with limited memory,
which wants to squeeze the wasted memory.

Thanks,
Feng

> >  #define MAX_GLOBAL_MAGS 32	/* magazines per bin */
> >  
> >  struct iova_magazine {
> > 
> > I guess changing it from 128 to 127 will not hurt much, and plan to
> > send it out soon.
> 
