Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A366D4F5B84
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiDFKRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242017AbiDFKP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:15:58 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92F4B3D3577
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 20:52:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-233-190.pa.vic.optusnet.com.au [49.186.233.190])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 088995344EF;
        Wed,  6 Apr 2022 13:52:17 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nbwiN-00EJFz-MU; Wed, 06 Apr 2022 13:52:15 +1000
Date:   Wed, 6 Apr 2022 13:52:15 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
Message-ID: <20220406035215.GB1609613@dread.disaster.area>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
 <20220404010948.GV1609613@dread.disaster.area>
 <87ilrn5ttl.fsf@stepbren-lnx.us.oracle.com>
 <YkyyCcdJq69tO6ba@casper.infradead.org>
 <20220405235426.GY1609613@dread.disaster.area>
 <87fsmr58bl.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsmr58bl.fsf@stepbren-lnx.us.oracle.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=624d0e74
        a=bHAvQTfMiaNt/bo4vVGwyA==:117 a=bHAvQTfMiaNt/bo4vVGwyA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=OpGOEPv0gzfkW3j-gqIA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 06:06:38PM -0700, Stephen Brennan wrote:
> Dave Chinner <david@fromorbit.com> writes:
> > On Tue, Apr 05, 2022 at 10:18:01PM +0100, Matthew Wilcox wrote:
> >> On Tue, Apr 05, 2022 at 10:22:14AM -0700, Stephen Brennan wrote:
> >> > I can't speak for every slab cache, but I've been coming to the same
> >> > conclusion myself regarding the dentry cache. I think that the rate of
> >> > stepping through the LRU should be tied to the rate of allocations.
> >> > Truly in-use objects shouldn't be harmed by this, as they should get
> >> > referenced and rotated to the beginning of the LRU. But the one-offs
> >> > which are bloating the cache will be found and removed.
> >> 
> >> I agree with all this.
> >
> > Same here.
> >
> >> > I've implemented a version of this patch which just takes one step
> >> > through the LRU on each d_alloc. It's quite interesting to watch it
> >> > work. You can create 5 million negative dentries in directory /A via
> >> > stat(), and then create 5 million negative dentries in directory /B. The
> >> > total dentry slab size reaches 5 million but never goes past it, since
> >> > the old negative dentries from /A aren't really in use, and they get
> >> > pruned at the same rate as negative dentries from /B get created. On the
> >> > other hand, if you *continue* to stat() on the dentries of /A while you
> >> > create negative dentries in /B, then the cache grows to 10 million,
> >> > since the /A dentries are actually in use.
> >> > 
> >> > Maybe a solution could involve some generic list_lru machinery that can
> >> > let you do these sorts of incremental scans? Maybe batching them up so
> >> > instead of doing one every allocation, you do them every 100 or 1000?
> >> > It would still be up to the individual user to put this to good use in
> >> > the object allocation path.
> >> 
> >> I feel like we need to allow the list to both shrink and grow, depending
> >> on how useful the entries in it are.  So one counter per LRU, incremented
> >> on every add.  When that counter gets to 100, reset it to 0 and scan
> >> 110 entries.  Maybe 0 of them can be reclaimed; maybe 110 of them can be.
> >> But the list can shrink over time instead of being a "one in, one out"
> >> scenario.
> >
> > Yes, this is pretty much what I've been saying we should be using
> > the list-lru for since .... Well, let's just say it was one of the
> > things I wanted to be able to do when I first created the list-lru
> > infrastructure.
> >
> > But it is much more complex than this. One of the issues with purely
> > list-lru add-time accounting is that we cannot make reclaim
> > decisions from list-add context because the list-add can occur in
> > reclaim context.  e.g.  dentry reclaim will drop the last reference
> > to an inode, which then gets inserted into the the inode list-lru in
> > reclaim context.  The very next thing the superblock shrinker does
> > is scan the inode cache list-lru and remove a pre-calculated number
> > of objects from the list. Hence in reclaim context we can be both
> > increasing and decreasing the size of the list-lru by significant
> > percentages in a very short time window. This means it will be quite
> > challenging to make clear decisions based purely on lru list add
> > operations.
> 
> Plus, for the dcache, dentries are added to the LRU the first time their
> reference count drops to zero, but they're not removed if they gain a
> new reference. So at least for the dentry case, it's not clear that
> list_lru_add/del would be good indicators of free/in-use object counts.

Same for several other list-lru caches - the lazy removal trick is
used by (at least) the dentry, inode, XFS buffer and XFS dquot
caches. It's simply a way of reducing lock contention on the LRU
list - generally only memory reclaim or object freeing needs list
removal. So why remove it on every new reference to an object only
to have to put it back on the list a short time later?

> > Hence I think we want to connect more than just the unused entries
> > to periodic reclaim - we really need to know both the number of free
> > objects on the list-lru as well as the total number of objects
> > allocated that could be on the list_lru. This would give us some
> > comparitive measure of free objects vs active referenced objects
> > and that would allow better decisions to be made.
> 
> The dentry branch I have works purely based on total allocated objects:
> no differentiation between free and active referenced objects. I could
> hook into dput() where reference counts drop to zero for the other part
> of the equation, because like I said, list_lru_{add,del} aren't reliable
> for the dentry cache.

Right, but shrinkers work from the number of objects that are
potentially freeable in a cache, not from the number that are
currently allocated. i.e. it uses the number of objects on the LRU
as a proxy for size of the allocated cache.

My point is that we actually need both sets of stats to make decent
reclaim decisions - scanning large caches is not useful if there is
almost zero potentially reclaimable objects in the cache...

That, however, brings into focus another issue: we conflate "reclaim
scanning" with list rotation (removing referenced bits and giving an
object another pass through the list). This forces reclaim to try to
reclaim a significant portion of any cache regardless of whether
there is nothing we can free immediately. If we don't then we never
strip the referenced bits that will allows the objects to eventually
be reclaimed.that will allows the objects to eventually be
reclaimed...

> I have opinions about whether or not it would be helpful to add in the
> dput() signal, but I'd rather just try it and see. I'm learning that my
> opinion and intuition are not all that reliable when it comes to caching
> and LRU algorithms; trial and error is key.

*nod*

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
