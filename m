Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA354F5239
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849708AbiDFCjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiDEWlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:41:05 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6E121803
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:31:12 -0700 (PDT)
Date:   Tue, 5 Apr 2022 14:31:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649194270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5t9coCtrHLZaRLvVCW23S/dnkHR8+CSFeJXYtePJSP0=;
        b=aX8QYH82/o+HKCK3eCPUmXu2ElVCc7r3dR6Y4bX5Y2FNjUVoDvwJ2ePeRJJ2bKLg2GtlKm
        xg4QZlzuDeRdsBnqbQaFrHBGzckwqHwElEWKe6llBpIKqoCsTjl4TwA4uALVo1pcoExHdZ
        Gp1Vt0ayxUj1Ja52jbHaKNEXLHfsnaE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Hillf Danton <hdanton@sina.com>, MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
Message-ID: <Yky1FgLrlIOfpCZ+@carbon.dhcp.thefacebook.com>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
 <20220404010948.GV1609613@dread.disaster.area>
 <YktCKVbChtC+YjOk@carbon.dhcp.thefacebook.com>
 <20220405051710.GW1609613@dread.disaster.area>
 <Ykxv1j9dxlz1BS5N@carbon.dhcp.thefacebook.com>
 <CAHbLzko=bjLhhJXjcs0Uh-g3x9vV1gQZjEU2JqxVehqSb1UGkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzko=bjLhhJXjcs0Uh-g3x9vV1gQZjEU2JqxVehqSb1UGkQ@mail.gmail.com>
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

On Tue, Apr 05, 2022 at 01:58:59PM -0700, Yang Shi wrote:
> On Tue, Apr 5, 2022 at 9:36 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Tue, Apr 05, 2022 at 03:17:10PM +1000, Dave Chinner wrote:
> > > On Mon, Apr 04, 2022 at 12:08:25PM -0700, Roman Gushchin wrote:
> > > > On Mon, Apr 04, 2022 at 11:09:48AM +1000, Dave Chinner wrote:
> > > > > i.e. the amount of work that shrinkers need to do in a periodic scan
> > > > > is largerly determined by the rate of shrinkable cache memory usage
> > > > > growth rather than memory reclaim priority as it is now. Hence there
> > > > > needs to be different high level "shrinker needs to do X amount of
> > > > > work" calculation for periodic reclaim than there is now.
> > > > >
> > > > > e.g. we calculate a rolling average of the size of the cache and a
> > > > > rate of change over a series of polling operations (i.e. calling
> > > > > ->scan_count) and then when sustained growth is detected we start
> > > > > trying to shrink the cache to limit the rate of growth of the cache.
> > > > >
> > > > > If the cache keeps growing, then it's objects are being repeatedly
> > > > > referenced and it *should* keep growing. If it's one-off objects
> > > > > that are causing the growth of the cache and so objects are being
> > > > > reclaimed by the shrinker, then matching the periodic shrink scan to
> > > > > the growth rate will substantially reduce the rate of growth of that
> > > > > cache.
> > > >
> > > > A clever idea!
> > > >
> > > > It seems like we need to add some stats to the list_lru API or maybe to
> > > > the shrinker API (and let list_lru to use it).
> > > > E.g. total/scanned/reclaimed, maybe with a time decay
> > > >
> > > > I'm also thinking about:
> > > > 1) adding a sysfs/debugfs interface to expose shrinkers current size and
> > > >    statistics, with an ability to call into the reclaim manually.
> > >
> > > I've thought about it, too, and can see where it could be useful.
> > > However, when I consider the list_lru memcg integration, I suspect
> > > it becomes a "can't see the forest for the trees" problem. We're
> > > going to end up with millions of sysfs objects with no obvious way
> > > to navigate, iterate or search them if we just take the naive "sysfs
> > > object + stats per list_lru instance" approach.
> >
> > Ok, I'll try to master something and share patches. I assume it would be useful
> > to have statistics and be able to trigger a reclaim of a particular shrinker
> > without creating a real memory pressure. I anticipate many interesting
> > findings in the implementation of individual shrinkers...
> >
> > >
> > > Also, if you look at commit 6a6b7b77cc0f mm: ("list_lru: transpose the
> > > array of per-node per-memcg lru lists") that went into 5.18-rc1,
> > > you'll get an idea of the amount of memory overhead just tracking
> > > the list_lru x memcg infrastructure consumes at scale:
> > >
> > >     I had done a easy test to show the optimization.  I create 10k memory
> > >     cgroups and mount 10k filesystems in the systems.  We use free command to
> > >     show how many memory does the systems comsumes after this operation (There
> > >     are 2 numa nodes in the system).
> > >
> > >             +-----------------------+------------------------+
> > >             |      condition        |   memory consumption   |
> > >             +-----------------------+------------------------+
> > >             | without this patchset |        24464 MB        |
> > >             +-----------------------+------------------------+
> > >             |     after patch 1     |        21957 MB        | <--------+
> > >             +-----------------------+------------------------+          |
> > >             |     after patch 10    |         6895 MB        |          |
> > >             +-----------------------+------------------------+          |
> > >             |     after patch 12    |         4367 MB        |          |
> > >             +-----------------------+------------------------+          |
> > >                                                                         |
> > >             The more the number of nodes, the more obvious the effect---+
> >
> > Yes, I know, I've reviewed this patchset. However, 10k cgroups _and_ 10k
> > mounts look a bit artificial. It's hard to believe that there are 100M
> > LRUs containing hot objects. If most of them are cold, it's actually
> > a question how to efficiently reclaim them and free the wasted memory.
> >
> > >
> > > If we now add sysfs objects and stats arrays to each of the
> > > list_lrus that we initiate even now on 5.18-rc1, we're going to
> > > massively blow out the memory footprint again.
> >
> > sysfs can be a config option, it doesn't have to be enabled in prod.
> > But I agree, because of memory constraints we're very limited in the size
> > of statistics which can be used for reclaim decisions.
> >
> > >
> > > So, nice idea, but I'm not sure we can make it useful and not
> > > consume huge amounts of memory....
> > >
> > > What might be more useful is a way of getting the kernel to tell us
> > > what the, say, 20 biggest slab caches are in the system and then
> > > provide a way to selectively shrink them. We generally don't really
> > > care about tiny caches, just the ones consuming all the memory. This
> > > isn't my idea - Kent has been looking at this because of how useless
> > > OOM kill output is for debugging slab cache based OOM triggers. See
> > > this branch for an example:
> > >
> > > https://evilpiepirate.org/git/bcachefs.git/log/?h=shrinker_to_text
> > >
> > > Even a sysfs entry that you echo a number into and it returns
> > > the "top N" largest LRU lists. echo -1 into it and it returns every
> > > single one if you want all the information.
> > >
> > > The whole "one sysfs file, one value" architecture falls completely
> > > apart when we might have to indexing *millions* of internal
> > > structures with many parameters per structure...
> >
> > It's a good point, I need to think what can we do here.
> >
> > Actually, if it's so hard and inefficient for a sysfs interface,
> > it also means it's inefficient for the reclaim path. So if we have
> > an ability to quickly find beefy LRU lists worth shrinking, it might
> > improve the reclaim efficiency too.
> >
> > Actually, thinking of reducing the memory footprint, it would be great
> > to combine LRU's belonging to different superblocks (of the same type).
> > Pagecache analogy: we have an LRU for all pagecache pages, it's not
> > per-file or per-sb. Not sure how easy/viable it is.
> >
> > >
> > > > 2) formalizing a reference bit/counter API on the shrinkers level, so that
> > > >    shrinker users can explicitly mark objects (re)-"activation".
> > >
> > > Not 100% certain what you are refering to here - something to do
> > > with active object rotation? Or an active/inactive list split with period
> > > demotion like we have for the page LRUs? Or workingset refault
> > > detection? Can you explain in more detail?
> >
> > It's a vague thinking at this point, but you got me right, I was thinking about
> > all the listed ideas above. In general I'm trying to understand whether
> > the existing model is sufficient for a more or less effective management
> > of hot/cold objects and if we can improve it borrowing some ideas from
> > the page reclaim code.
> > Shadow entries would be great but likely not possible because of the memory
> > footprint.
> >
> > >
> > > > 3) _maybe_ we need to change the shrinkers API from a number of objects to
> > > >    bytes, so that releasing a small number of large objects can compete with
> > > >    a releasing on many small objects. But I'm not sure.
> > >
> > > I think I suggested something similar a long time ago. We have
> > > shrinkers that track things other than slab objects. e.g. IIRC the
> > > ttm graphics allocator shrinker tracks sets of pages and frees
> > > pages, not slab objects. The XFS buffer cache tracks variable sized
> > > objects, from 512 bytes to 64KB in length, so the amount of memory
> > > it frees is variable even if the number of handles it scans and
> > > reclaims is fixed and consistent. Other subsystems have different
> > > "non object" shrinker needs as well.
> >
> > It's true for many objects, because it's not unusual for kernel objects
> > to have attached kmallocs or pin other objects in the memory. Unlikely
> > we can be 100% accurate, but we might improve the "smoothness" of the
> > reclaim process.
> >
> > >
> > > The long and short of it is that two shrinkers might have the same
> > > object count, but one might free 10x the amount of memory than the
> > > other for the same amount of shrinking work. Being able to focus
> > > reclaim work on caches that can free a lot of memory much more
> > > quickly would be a great idea.
> >
> > Right. It's also about "bytes freed/seeks" ratio. Why would we reclaim
> > expensive small objects if there are big and cheap.
> >
> > >
> > > It also means that a shrinker that scans a fragmented slab can keep
> > > going until a set number of slab pages have been freed, rather than
> > > a set number of slab objects. We can push reclaim of fragmented slab
> > > caches much harder when necessary if we are reclaiming by freed byte
> > > counts...
> >
> > I thought about it, but it's tricky. If all slabs are almost full (fragmentation
> > is low), we want to shrink aggressively, otherwise we end up allocating
> > more slabs and fragmenting more memory. If slabs are almost empty (fragmentation
> > is very high), we also want to shrink more aggressively with a hope to release
> > physical memory, as you said. But setting a target in pages is dangerous: slab caches
> > can be merged or slab pages can be pinned by objects belonging to a different
> > memory cgroup, so it might be not possible to reclaim pages no matter how hard
> > we're trying.
> 
> Yeah, I agree it actually doesn't make too much sense to return the
> number of reclaimed objects. Other part of vmscan returns the number
> of base pages, the sizes of slab objects are varied, it may be much
> smaller than a page, for example, dentry may be 192 bytes.
> 
> Another problem which doesn't help the feedback loop is even though
> bytes is returned instead of the number of objects, it doesn't mean
> that much memory is actually freed and available for allocation.

It might be not available for non-slab allocations, but at least new
slab objects can be allocated without polluting more pages. So it
might not be completely useless even if 0 pages were reclaimed.

> IMHO
> the number of really freed pages should be returned (I do understand
> it is not that easy for now), and returning 0 should be fine.

It's doable, there is already a mechanism in place which hooks into
the slub/slab/slob release path and stops the slab reclaim as a whole
if enough memory was freed.

> The
> current logic (returning the number of objects) may feed up something
> over-optimistic. I, at least, experienced once or twice that a
> significant amount of slab caches were shrunk, but actually 0 pages
> were freed actually. TBH the new slab controller may make it worse
> since the page may be pinned by the objects from other memcgs.

Of course, the more dense the placement of objects is, the harder is to get
the physical pages back. But usually it pays off by having a dramatically
lower total number of slab pages.

If the total size of slab memory is not very high and more or less constant,
we don't have to move large number of pages back and forth between slab- and
non-slab users. So if we can satisfy new allocations using "old" pages, it's
totally fine.
