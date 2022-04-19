Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35276507554
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355424AbiDSQtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349998AbiDSQpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:45:21 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C0933E3A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:42:38 -0700 (PDT)
Date:   Tue, 19 Apr 2022 09:42:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650386556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BgIKdz66kPcyA341qp0ZDvtyQNkSL0ly49y8sDVGu0o=;
        b=Sef1m0iG1d4B3iQ18wyIK/tdzdNhUvFwVR4i52oZGdDUaUUm/8B5Y0mg2tchnjcLdkQ4t2
        Vzl+P/VZv4cKLNJNimLr6Q9eq/SzlrjcFppI13fiIcPXI2P8Mk4F+awJPlmV0GBOHomtAl
        /+5Rvql1mr/GXTF4nikqR5Z42XJNNrc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] mm: do not call add_nr_deferred() with zero deferred
Message-ID: <Yl7mdguNR3CabMAN@carbon>
References: <20220416004104.4089743-1-roman.gushchin@linux.dev>
 <59404249-de0c-c569-d04a-9da38ed14b0a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59404249-de0c-c569-d04a-9da38ed14b0a@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 02:56:06PM +0200, David Hildenbrand wrote:
> On 16.04.22 02:41, Roman Gushchin wrote:
> > add_nr_deferred() is often called with next_deferred equal to 0.
> > For instance, it's happening under low memory pressure for any
> > shrinkers with a low number of cached objects. A corresponding trace
> > looks like:
> >   <...>-619914 [005] .... 467456.345160: mm_shrink_slab_end: \
> >   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1	     \
> >   unused scan count 0 new scan count 0 total_scan 0	     \
> >   last shrinker return val 0
> > 
> >   <...>-619914 [005] .... 467456.345371: mm_shrink_slab_end: \
> >   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1	     \
> >   unused scan count 0 new scan count 0 total_scan 0	     \
> >   last shrinker return val 0
> > 
> >   <...>-619914 [005] .... 467456.345380: mm_shrink_slab_end: \
> >   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1 unused \
> >   scan count 0 new scan count 0 total_scan 0	             \
> >   last shrinker return val 0
> > 
> > This lead to unnecessary checks and atomic operations, which can be
> > avoided by checking next_deferred for not being zero before calling
> > add_nr_deferred(). In this case the mm_shrink_slab_end trace point
> > will get a potentially slightly outdated "new scan count" value, but
> > it's totally fine.
> 
> Sufficient improvement to justify added complexity for anybody reading
> that code?

I don't have any numbers and really doubt the difference is significant,
however the added complexity is also small: one "if" statement.
Anyway, if you feel strongly against this change, I'm fine with dropping it.

> 
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > ---
> >  mm/vmscan.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index d4a7d2bd276d..19d3d4fa1aad 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -808,7 +808,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >  	 * move the unused scan count back into the shrinker in a
> >  	 * manner that handles concurrent updates.
> >  	 */
> > -	new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
> > +	if (next_deferred)
> > +		new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
> > +	else
> > +		new_nr = nr;
> >  
> >  	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
> >  	return freed;
> 
> And if we still want to do this optimization, why not put it into
> add_nr_deferred()?

Because of the semantics of add_nr_deferred(), which returns the deferred value.
It's not used for anything except tracing, so maybe it's a place for another
change.

Thanks!
