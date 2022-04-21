Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1722450AC91
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442958AbiDUX6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442970AbiDUX6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:58:38 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E84A4A935
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:55:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-115-138.pa.nsw.optusnet.com.au [49.181.115.138])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4CB9753473B;
        Fri, 22 Apr 2022 09:55:39 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nhgeA-002yEq-4d; Fri, 22 Apr 2022 09:55:38 +1000
Date:   Fri, 22 Apr 2022 09:55:38 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hillf Danton <hdanton@sina.com>, MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
Message-ID: <20220421235538.GS1609613@dread.disaster.area>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
 <20220404010948.GV1609613@dread.disaster.area>
 <YktCKVbChtC+YjOk@carbon.dhcp.thefacebook.com>
 <20220405051710.GW1609613@dread.disaster.area>
 <Ykxv1j9dxlz1BS5N@carbon.dhcp.thefacebook.com>
 <CAHbLzko=bjLhhJXjcs0Uh-g3x9vV1gQZjEU2JqxVehqSb1UGkQ@mail.gmail.com>
 <Ykyy8RfJgWDOGylv@casper.infradead.org>
 <20220406000130.GZ1609613@dread.disaster.area>
 <20220421190339.z2fxoywedhyibsgn@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421190339.z2fxoywedhyibsgn@moria.home.lan>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6261eefe
        a=/kVtbFzwtM2bJgxRVb+eeA==:117 a=/kVtbFzwtM2bJgxRVb+eeA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=-weUsO0AUHsLch9HhjwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 03:03:39PM -0400, Kent Overstreet wrote:
> On Wed, Apr 06, 2022 at 10:01:30AM +1000, Dave Chinner wrote:
> > On Tue, Apr 05, 2022 at 10:21:53PM +0100, Matthew Wilcox wrote:
> > > On Tue, Apr 05, 2022 at 01:58:59PM -0700, Yang Shi wrote:
> > > > Yeah, I agree it actually doesn't make too much sense to return the
> > > > number of reclaimed objects. Other part of vmscan returns the number
> > > > of base pages, the sizes of slab objects are varied, it may be much
> > > > smaller than a page, for example, dentry may be 192 bytes.
> > > 
> > > From the point of view of vmscan, it only cares about the number of pages
> > > freed because it's trying to free pages.  But from the point of view of
> > > trying to keep the number of non-useful objects in check, the number of
> > > objects freed is more important, and it doesn't matter whether we ended
> > > up freeing any pages because we made memory available for this slab cache.
> > 
> > Yes and no. If the memory pressure is being placed on this cache,
> > then freeing any number of objects is a win-win situation - reclaim
> > makes progress and new allocations don't need to wait for reclaim.
> > 
> > However, if there is no pressure on this slab cache, then freeing
> > objects but no actual memory pages is largely wasted reclaim effort.
> > Freeing those objects does nothing to alleviate the memory shortage,
> > and the memory freed is not going to be consumed any time soon so
> > all we've done is fragment the slab cache and require the subsystem
> > to spend more resources re-populating it. That's a lose-lose.
> > 
> > We want to select the shrinkers that will result in the former
> > occurring, not the latter.
> 
> Do we have any existing shrinkers that preferentially free from mostly empty
> slab pages though?

No, because shrinkers have no visbility into slab cache layout.

> And do we want them to?

There have been attempts in the past to do this, which started from
selecting partial slab pages and then trying free/reclaim the
objects on those pages.

The problems these direct defrag attempts face is that partial slabs
can be a mix of referenced (in use) and unreferenced (reclaimable)
objects. Freeing/relocating an in use object is largely impossible
because of all the (unknown) external references to the object would
need to be updated and that's an intractable problem.

Hence attempts to directly target partial slab pages for reclaim
have largely ended up not having very good results because partial
slab pages containing only unreferenced objects are much rarer than
partial slab pages....

> You're talking about memory fragmentation, and I'm not sure that should be the
> shrinker's concern (on the other hand, I'm not sure it shouldn't - just freeing
> the objects on mostly empty slab pages is pretty reasonable for cached objects).

Yeah, but as per above, having mostly empty slab pages does not mean
the remaining active objects on those pages can actually be
reclaimed...

> We could also plumb compaction down to the slab level, and just request the
> subsystem move those objects.

Been there, tried that, not feasible. How do you find all the
external active references to a dentry or inode at any given point
in time and then prevent all of them from being actively used while
you switch all the external pointers to the old object to the new
object?

> Might be easier than making that an additional
> responsibility of the shrinkers, which really should be more concerned with
> implementing cache replacement policy and whatnot - e.g. shrinkers were doing
> something more LFU-ish that would also help with the one-off object problem.

*nod*

I've said this many times in the past when people have wanted to
hack special cases into inode and dentry cache reference bit
management.  We need to make the list_lru rotation implementation
smarter, not hack special cases into individual shrinker algorithms

One of the original goals of the list_lru was to unify all the LRU
mechanisms used by shrinkable slab caches so we could then do
something smarter with the list_lru than a plain LRU + reference bit
and everything would benefit.  e.g. Being able to bias reclaim
priority of objects based on their known access patterns (which I
implemented for the xfs buffer cache via b_lru_ref so it holds onto
tree roots and nodes harder than it does leaves) or moving the list
ordering towards LFU or clock-pro style active/inactive lists page
reclaim uses to allow single use objects to stream through the cache
instead of turn it entirely over were all potential improvements I
as thinking of.

So, yes, we should be looking at improving the list_lru
implementation so taht it handles streaming single use objects a
whole lot better. Fix it once, fix it properly, and everyone who
uses list-lru and shrinkers benefits...

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
