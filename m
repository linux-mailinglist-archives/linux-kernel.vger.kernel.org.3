Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61794F5361
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiDFDdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1851020AbiDFDCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 23:02:00 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59F41EEA73
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:54:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 87B4F10E56AB;
        Wed,  6 Apr 2022 09:54:28 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nbt0E-00EF9b-H4; Wed, 06 Apr 2022 09:54:26 +1000
Date:   Wed, 6 Apr 2022 09:54:26 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Hillf Danton <hdanton@sina.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
Message-ID: <20220405235426.GY1609613@dread.disaster.area>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
 <20220404010948.GV1609613@dread.disaster.area>
 <87ilrn5ttl.fsf@stepbren-lnx.us.oracle.com>
 <YkyyCcdJq69tO6ba@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkyyCcdJq69tO6ba@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=624cd6b6
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=cW6uoDq8pwY6bZwKszYA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 10:18:01PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 05, 2022 at 10:22:14AM -0700, Stephen Brennan wrote:
> > I can't speak for every slab cache, but I've been coming to the same
> > conclusion myself regarding the dentry cache. I think that the rate of
> > stepping through the LRU should be tied to the rate of allocations.
> > Truly in-use objects shouldn't be harmed by this, as they should get
> > referenced and rotated to the beginning of the LRU. But the one-offs
> > which are bloating the cache will be found and removed.
> 
> I agree with all this.

Same here.

> > I've implemented a version of this patch which just takes one step
> > through the LRU on each d_alloc. It's quite interesting to watch it
> > work. You can create 5 million negative dentries in directory /A via
> > stat(), and then create 5 million negative dentries in directory /B. The
> > total dentry slab size reaches 5 million but never goes past it, since
> > the old negative dentries from /A aren't really in use, and they get
> > pruned at the same rate as negative dentries from /B get created. On the
> > other hand, if you *continue* to stat() on the dentries of /A while you
> > create negative dentries in /B, then the cache grows to 10 million,
> > since the /A dentries are actually in use.
> > 
> > Maybe a solution could involve some generic list_lru machinery that can
> > let you do these sorts of incremental scans? Maybe batching them up so
> > instead of doing one every allocation, you do them every 100 or 1000?
> > It would still be up to the individual user to put this to good use in
> > the object allocation path.
> 
> I feel like we need to allow the list to both shrink and grow, depending
> on how useful the entries in it are.  So one counter per LRU, incremented
> on every add.  When that counter gets to 100, reset it to 0 and scan
> 110 entries.  Maybe 0 of them can be reclaimed; maybe 110 of them can be.
> But the list can shrink over time instead of being a "one in, one out"
> scenario.

Yes, this is pretty much what I've been saying we should be using
the list-lru for since .... Well, let's just say it was one of the
things I wanted to be able to do when I first created the list-lru
infrastructure.

But it is much more complex than this. One of the issues with purely
list-lru add-time accounting is that we cannot make reclaim
decisions from list-add context because the list-add can occur in
reclaim context.  e.g.  dentry reclaim will drop the last reference
to an inode, which then gets inserted into the the inode list-lru in
reclaim context.  The very next thing the superblock shrinker does
is scan the inode cache list-lru and remove a pre-calculated number
of objects from the list. Hence in reclaim context we can be both
increasing and decreasing the size of the list-lru by significant
percentages in a very short time window. This means it will be quite
challenging to make clear decisions based purely on lru list add
operations.

Hence I think we want to connect more than just the unused entries
to periodic reclaim - we really need to know both the number of free
objects on the list-lru as well as the total number of objects
allocated that could be on the list_lru. This would give us some
comparitive measure of free objects vs active referenced objects
and that would allow better decisions to be made.

As it is, we've recently made a necessary connection between
allocation and the list-lru via kmem_cache_alloc_lru(). This was
done as part of the list-lru/memcg rework patchset I referenced
earlier in the thread.

This means that operations that slab objects that are kept
on list_lrus for caching are now supplied with the list_lru at
allocation time. We already use this API for inode caches (via
inode_alloc_sb()) and the dentry cache (via __d_alloc()), so we
already have the infrastructure in place to do per-allocation
list-lru accounting for inodes and dentries, not just "per list-lru
add/remove" accounting.

Extending that to other slab-based list-lru users should be pretty
easy, and in doing so would remove another difference between memcg
and non-memcg aware list-lrus....

> Clearly 110 is a magic number, but intuitively, attempting to shrink
> by 10% feels reasonable.  Need to strike a balance between shrinking
> quickly enough and giving the cache time to figure out which entries
> are actually useful.

Testing will teach us where the thresholds need to be pretty
quickly. :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
