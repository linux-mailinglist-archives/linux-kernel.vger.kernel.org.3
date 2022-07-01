Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97049563258
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbiGALN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbiGALN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:13:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9CF1570A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656674006; x=1688210006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vlK/qQ4NX1QkT7AEWx80zOij+hlHTc4NLtDoQtrx+IQ=;
  b=Q2/c80ggi7cPmrWnrM6tqXVl7VzskwQYyjkA/oWkeay64oaIcUfrYxk6
   l8rpA0dDgKnM1lmjJEpjKGbr/2fn7NUILfpVfIY+Q3ChA8gObyVXzv2Xr
   1fs6Nv6e1Jy6i1+Alif9ExINPb2G7wYMrSkDlS0TZ698/wTmYSP38e5NB
   HCxDg6zZjmiuLD+ot0v2DcXBrUCnxadoEjlRFcEqurI0Ln7UO3rVcSf7o
   ikLKGlZQskoXjnRn7evORI8/yAC/PvVPYWoCCwkXSGU9OBluWlR+868oL
   aOwqwviZyqbmD3yLXkMbtHcSq38i4cTP21m7d6i7oKexE773XJNJB2MRu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="280178941"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="280178941"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 04:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="694478207"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jul 2022 04:13:23 -0700
Date:   Fri, 1 Jul 2022 19:13:22 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: Re: [RFC PATCH] mm/slub: enable debugging memory wasting of kmalloc
Message-ID: <20220701111322.GC14806@shbuild999.sh.intel.com>
References: <20220630014715.73330-1-feng.tang@intel.com>
 <Yr21Ymj5uZfFearE@hyeyoo>
 <20220701022330.GA14806@shbuild999.sh.intel.com>
 <Yr6+cHOmVnvcfFEa@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr6+cHOmVnvcfFEa@hyeyoo>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 06:29:20PM +0900, Hyeonggon Yoo wrote:
> On Fri, Jul 01, 2022 at 10:23:30AM +0800, Feng Tang wrote:
[snip]

> > 
> > > And then it has overhead of 'waste' field for every non-kmalloc objects
> > > because track is saved per object. Also the field is not used at free.
> > > (Maybe that would be okay as it's only for debugging, just noting.)
> >  
> > Yes, the field itself is a 'waste' for non-kmalloc objects :) I do
> > have another patch to add an option for this
> > 
> > 	+config SLUB_DEBUG_KMALLOC_WASTE
> > 	+	bool "Enable kmalloc memory waste debug"
> > 	+	depends on SLUB_DEBUG && DEBUG_FS
> > 	...	
> > 
> > And didn't post it due to the same debugging thought as you. And I can
> > add it back if it's really necessary.
> 
> Let's see how others think :)
> I'm okay with current patch.

Okay.

> > > >  mm/slub.c | 45 ++++++++++++++++++++++++++++++---------------
> > > >  1 file changed, 30 insertions(+), 15 deletions(-)
[snip]

> > > > 
> > > >  	l->min_pid = track->pid;
> > > >  	l->max_pid = track->pid;
> > > >  	l->handle = handle;
> > > > +	l->waste = track->waste;
> > > 
> > > I think this may be fooled when there are different wastes values
> > > from same caller (i.e. when a kmalloc_track_caller() is used.)
> > 
> > Yes, with the patch, we found quite some cases that the same caller
> > requests different sizes.
> > 
> > > because the array is sorted by caller address, but not sorted by waste.
> > 
> > In the patch we have in add_location():
> > 
> > +		if ((track->addr == caddr) && (handle == chandle) &&
> > +			(track->waste == l->waste)) {
> > 
> > Do you mean the following is missed? 
> > 
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -5176,6 +5176,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
> >  			end = pos;
> >  		else if (track->addr == caddr && handle < chandle)
> >  			end = pos;
> > +		else if (track->addr == caddr && handle == chandle && track->waste < l->waste)
> > +			end = pos;
> >  		else
> >  			start = pos;
> >
> 
> Yes. Exactly. :)
 
Great, will add it in the next version. Thanks for cathing the errors!

- Feng

> Thanks,
> Hyeonggon
