Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE624F2284
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiDEFTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiDEFTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:19:15 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DAB294
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 22:17:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D18F310E5639;
        Tue,  5 Apr 2022 15:17:12 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nbbZ0-00DwF0-DI; Tue, 05 Apr 2022 15:17:10 +1000
Date:   Tue, 5 Apr 2022 15:17:10 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hillf Danton <hdanton@sina.com>, MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
Message-ID: <20220405051710.GW1609613@dread.disaster.area>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
 <20220404010948.GV1609613@dread.disaster.area>
 <YktCKVbChtC+YjOk@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YktCKVbChtC+YjOk@carbon.dhcp.thefacebook.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=624bd0db
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=4ao_m9BdAAAA:8 a=7-415B0cAAAA:8
        a=RB2aauR-4WVBKZjbOhwA:9 a=CjuIK1q_8ugA:10 a=MsgbvsnFcLE8lbaOJhbn:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 12:08:25PM -0700, Roman Gushchin wrote:
> On Mon, Apr 04, 2022 at 11:09:48AM +1000, Dave Chinner wrote:
> > i.e. the amount of work that shrinkers need to do in a periodic scan
> > is largerly determined by the rate of shrinkable cache memory usage
> > growth rather than memory reclaim priority as it is now. Hence there
> > needs to be different high level "shrinker needs to do X amount of
> > work" calculation for periodic reclaim than there is now.
> > 
> > e.g. we calculate a rolling average of the size of the cache and a
> > rate of change over a series of polling operations (i.e. calling
> > ->scan_count) and then when sustained growth is detected we start
> > trying to shrink the cache to limit the rate of growth of the cache.
> > 
> > If the cache keeps growing, then it's objects are being repeatedly
> > referenced and it *should* keep growing. If it's one-off objects
> > that are causing the growth of the cache and so objects are being
> > reclaimed by the shrinker, then matching the periodic shrink scan to
> > the growth rate will substantially reduce the rate of growth of that
> > cache.
> 
> A clever idea!
> 
> It seems like we need to add some stats to the list_lru API or maybe to
> the shrinker API (and let list_lru to use it).
> E.g. total/scanned/reclaimed, maybe with a time decay
> 
> I'm also thinking about:
> 1) adding a sysfs/debugfs interface to expose shrinkers current size and
>    statistics, with an ability to call into the reclaim manually.

I've thought about it, too, and can see where it could be useful.
However, when I consider the list_lru memcg integration, I suspect
it becomes a "can't see the forest for the trees" problem. We're
going to end up with millions of sysfs objects with no obvious way
to navigate, iterate or search them if we just take the naive "sysfs
object + stats per list_lru instance" approach.

Also, if you look at commit 6a6b7b77cc0f mm: ("list_lru: transpose the
array of per-node per-memcg lru lists") that went into 5.18-rc1,
you'll get an idea of the amount of memory overhead just tracking
the list_lru x memcg infrastructure consumes at scale:

    I had done a easy test to show the optimization.  I create 10k memory
    cgroups and mount 10k filesystems in the systems.  We use free command to
    show how many memory does the systems comsumes after this operation (There
    are 2 numa nodes in the system).

            +-----------------------+------------------------+
            |      condition        |   memory consumption   |
            +-----------------------+------------------------+
            | without this patchset |        24464 MB        |
            +-----------------------+------------------------+
            |     after patch 1     |        21957 MB        | <--------+
            +-----------------------+------------------------+          |
            |     after patch 10    |         6895 MB        |          |
            +-----------------------+------------------------+          |
            |     after patch 12    |         4367 MB        |          |
            +-----------------------+------------------------+          |
                                                                        |
            The more the number of nodes, the more obvious the effect---+

If we now add sysfs objects and stats arrays to each of the
list_lrus that we initiate even now on 5.18-rc1, we're going to
massively blow out the memory footprint again. 

So, nice idea, but I'm not sure we can make it useful and not
consume huge amounts of memory....

What might be more useful is a way of getting the kernel to tell us
what the, say, 20 biggest slab caches are in the system and then
provide a way to selectively shrink them. We generally don't really
care about tiny caches, just the ones consuming all the memory. This
isn't my idea - Kent has been looking at this because of how useless
OOM kill output is for debugging slab cache based OOM triggers. See
this branch for an example:

https://evilpiepirate.org/git/bcachefs.git/log/?h=shrinker_to_text

Even a sysfs entry that you echo a number into and it returns
the "top N" largest LRU lists. echo -1 into it and it returns every
single one if you want all the information.

The whole "one sysfs file, one value" architecture falls completely
apart when we might have to indexing *millions* of internal
structures with many parameters per structure...

> 2) formalizing a reference bit/counter API on the shrinkers level, so that
>    shrinker users can explicitly mark objects (re)-"activation".

Not 100% certain what you are refering to here - something to do
with active object rotation? Or an active/inactive list split with period
demotion like we have for the page LRUs? Or workingset refault
detection? Can you explain in more detail?

> 3) _maybe_ we need to change the shrinkers API from a number of objects to
>    bytes, so that releasing a small number of large objects can compete with
>    a releasing on many small objects. But I'm not sure.

I think I suggested something similar a long time ago. We have
shrinkers that track things other than slab objects. e.g. IIRC the
ttm graphics allocator shrinker tracks sets of pages and frees
pages, not slab objects. The XFS buffer cache tracks variable sized
objects, from 512 bytes to 64KB in length, so the amount of memory
it frees is variable even if the number of handles it scans and
reclaims is fixed and consistent. Other subsystems have different
"non object" shrinker needs as well.

The long and short of it is that two shrinkers might have the same
object count, but one might free 10x the amount of memory than the
other for the same amount of shrinking work. Being able to focus
reclaim work on caches that can free a lot of memory much more
quickly would be a great idea.

It also means that a shrinker that scans a fragmented slab can keep
going until a set number of slab pages have been freed, rather than
a set number of slab objects. We can push reclaim of fragmented slab
caches much harder when necessary if we are reclaiming by freed byte
counts...

So, yeah, byte-count based reclaim definitely has merit compared to
what we currently do. It's more generic and more flexible...

> 4) also some shrinkers (e.g. shadow nodes) lying about the total size of
>    objects and I have an uneasy feeling about this approach.

Yeah, never been a fan about use cases like that, but IIRC it was really
the only option at the time to only trigger reclaim when the kernel
was absolutely desperate because we really need the working set
shadow nodes to do their job well when memory is very low...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
