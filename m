Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261F451089E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350846AbiDZTLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354175AbiDZTJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:09:00 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D9B1088
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:05:37 -0700 (PDT)
Date:   Tue, 26 Apr 2022 12:05:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650999935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UNl6KfdClUOvksdUnG0TFAL3a54F/WW49n7oekISVow=;
        b=R9zgmWaqx5gPdL3Iu0JXRPvmKp9u9RO7+eWGUg2UaJ6SamSrwDjWDYBeJn2sx5bESeiYr8
        ral0UPP6ylOmpODnWscYoUlr31HibnXokllKtjfJ7Hnn4C8RRdKxF0fEWpyPFJ4Wayyh4w
        eKxWQYmDhTM7Mmx4j6WAeox2HlbgQr4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v2 0/7] mm: introduce shrinker debugfs interface
Message-ID: <YmhCepfMRp49PTtA@carbon>
References: <20220422202644.799732-1-roman.gushchin@linux.dev>
 <YmeK6/eZYaMo2Ltm@rh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmeK6/eZYaMo2Ltm@rh>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 04:02:19PM +1000, Dave Chinner wrote:
> On Fri, Apr 22, 2022 at 01:26:37PM -0700, Roman Gushchin wrote:
> > There are 50+ different shrinkers in the kernel, many with their own bells and
> > whistles. Under the memory pressure the kernel applies some pressure on each of
> > them in the order of which they were created/registered in the system. Some
> > of them can contain only few objects, some can be quite large. Some can be
> > effective at reclaiming memory, some not.
> > 
> > The only existing debugging mechanism is a couple of tracepoints in
> > do_shrink_slab(): mm_shrink_slab_start and mm_shrink_slab_end. They aren't
> > covering everything though: shrinkers which report 0 objects will never show up,
> > there is no support for memcg-aware shrinkers. Shrinkers are identified by their
> > scan function, which is not always enough (e.g. hard to guess which super
> > block's shrinker it is having only "super_cache_scan").
> 
> In general, I've had no trouble identifying individual shrinker
> instances because I'm always looking at individual subsystem
> shrinker tracepoints, too.  Hence I've almost always got the
> identification information in the traces I need to trace just the
> individual shrinker tracepoints and a bit of sed/grep/awk and I've
> got something I can feed to gnuplot or a python script to graph...

You spent a lot of time working on shrinkers in general and xfs-specific
shrinkers in particular, no questions here. But imagine someone who's not
a core-mm developer and is adding a new shrinker.

> 
> > They are a passive
> > mechanism: there is no way to call into counting and scanning of an individual
> > shrinker and profile it.
> 
> IDGI. profiling shrinkers iunder ideal conditions when there isn't
> memory pressure is largely a useless exercise because execution
> patterns under memory pressure are vastly different.
> 
> All the problems with shrinkers show up when progress cannot be made
> as fast as memory reclaim wants memory to be reclaimed. How do you
> trigger priority windup causing large amounts of deferred processing
> because shrinkers are running in GFP_NOFS/GFP_NOIO context? How do
> you simulate objects getting dirtied in memory so they can't be
> immediately reclaimed so the shrinker can't make any progress at all
> until IO completes? How do you simulate the unbound concurrency that
> direct reclaim can drive into the shrinkers that causes massive lock
> contention on shared structures and locks that need to be accessed
> to free objects?

These are valid points and I assume we can find ways to emulate some of
these conditions, e.g. by allowing to run scanning using the GFP_NOFS context.
I though about it but decided to left for further improvements.

> 
> IOWs, if all you want to do is profile shrinkers running in the
> absence of memory pressure, then you can do that perfectly well with
> the existing 'echo 2 > /proc/sys/vm/drop_caches' mechanism. We don't
> need some complex debugfs API just to profile the shrinker
> behaviour.

And then we need somehow separate shrinkers in the result?

> 
> So why do we need any of the complexity and potential for abuse that
> comes from exposing control of shrinkers directly to userspace like
> these patches do?

I feel like the added complexity is minimal (unlike slab's sysfs, for
example). If the config option is off (by default), there is no additional
risk and overhead as well.

> 
> > To provide a better visibility and debug options for memory shrinkers
> > this patchset introduces a /sys/kernel/debug/shrinker interface, to some extent
> > similar to /sys/kernel/slab.
> 
> /sys/kernel/slab contains read-only usage information - it is
> analagous for visibility arguments, but it is not equivalent for
> the rest of the "active" functionality you want to add here....
> 
> > For each shrinker registered in the system a directory is created. The directory
> > contains "count" and "scan" files, which allow to trigger count_objects()
> > and scan_objects() callbacks. For memcg-aware and numa-aware shrinkers
> > count_memcg, scan_memcg, count_node, scan_node, count_memcg_node
> > and scan_memcg_node are additionally provided. They allow to get per-memcg
> > and/or per-node object count and shrink only a specific memcg/node.
> 
> Great, but why does the shrinker introspection interface need active
> scan control functions like these?

It makes testing of (new) shrinkers easier, for example.
For instance, shadow entries shrinker hides associated objects by returning
0 count most of the time (unless the total consumed memory is bigger than a
certain amount of the total memory).
echo 2 > /proc/sys/vm/drop_caches won't even trigger the scanning.

> 
> > To make debugging more pleasant, the patchset also names all shrinkers,
> > so that debugfs entries can have more meaningful names.
> > 
> > Usage examples:
> > 
> > 1) List registered shrinkers:
> >   $ cd /sys/kernel/debug/shrinker/
> >   $ ls
> >     dqcache-16          sb-cgroup2-30    sb-hugetlbfs-33  sb-proc-41       sb-selinuxfs-22  sb-tmpfs-40    sb-zsmalloc-19
> >     kfree_rcu-0         sb-configfs-23   sb-iomem-12      sb-proc-44       sb-sockfs-8      sb-tmpfs-42    shadow-18
> >     sb-aio-20           sb-dax-11        sb-mqueue-21     sb-proc-45       sb-sysfs-26      sb-tmpfs-43    thp_deferred_split-10
> >     sb-anon_inodefs-15  sb-debugfs-7     sb-nsfs-4        sb-proc-47       sb-tmpfs-1       sb-tmpfs-46    thp_zero-9
> >     sb-bdev-3           sb-devpts-28     sb-pipefs-14     sb-pstore-31     sb-tmpfs-27      sb-tmpfs-49    xfs_buf-37
> >     sb-bpf-32           sb-devtmpfs-5    sb-proc-25       sb-rootfs-2      sb-tmpfs-29      sb-tracefs-13  xfs_inodegc-38
> >     sb-btrfs-24         sb-hugetlbfs-17  sb-proc-39       sb-securityfs-6  sb-tmpfs-35      sb-xfs-36      zspool-34
> 
> Ouch. That's not going to be useful for humans debugging a system as
> there's no way to cross reference a "superblock" with an actual
> filesystem mount point. Nor is there any way to reallly know that
> all the shrinkers in one filesystem are related.
> 
> We normally solve this by ensuring that the fs related object has
> the short bdev name appended to them. e.g:
> 
> $ pgrep xfs
> 1 I root          36       2  0  60 -20 -     0 -      Apr19 ?        00:00:10 [kworker/0:1H-xfs-log/dm-3]
> 1 I root         679       2  0  60 -20 -     0 -      Apr19 ?        00:00:00 [xfsalloc]
> 1 I root         680       2  0  60 -20 -     0 -      Apr19 ?        00:00:00 [xfs_mru_cache]
> 1 I root         681       2  0  60 -20 -     0 -      Apr19 ?        00:00:00 [xfs-buf/dm-1]
> .....
> 
> Here we have a kworker process running log IO completion work on
> dm-3, two global workqueue rescuer tasks (alloc, mru) and a rescuer
> task for xfs-buf workqueue on dm-1.
> 
> We need the same name discrimination for shrinker information here,
> too - just saying "this is an XFS superblock shrinker" is just not
> sufficient when there are hundreds of XFS mount points with a
> handful of shrinkers each.

Good point, I think it's doable, and I really like it.

> 
> > 2) Get information about a specific shrinker:
> >   $ cd sb-btrfs-24/
> >   $ ls
> >     count  count_memcg  count_memcg_node  count_node  scan  scan_memcg  scan_memcg_node  scan_node
> > 
> > 3) Count objects on the system/root cgroup level
> >   $ cat count
> >     212
> > 
> > 4) Count objects on the system/root cgroup level per numa node (on a 2-node machine)
> >   $ cat count_node
> >     209 3
> 
> So a single space separated line with a number per node?
> 
> When you have a few hundred nodes and hundreds of thousands of objects per
> node, we overrun the 4kB page size with a single line. What then?

With seq_buf api we don't have 4kb limit, do we?

> 
> > 5) Count objects for each memcg (output format: cgroup inode, count)
> >   $ cat count_memcg
> >     1 212
> >     20 96
> >     53 817
> >     2297 2
> >     218 13
> >     581 30
> >     911 124
> >     <CUT>
> 
> What does "<CUT>" mean?

I've just shortened the lengthy output, not a part of the original output.

> 
> Also, this now iterates separate memcg per line. A parser now needs
> to know the difference between count/count_node and
> count_memcg/count_memcg_node because they are subtly different file
> formats.  These files should have the same format, otherwise it just
> creates needless complexity.
> 
> Indeed, why do we even need count/count_node? They are just the
> "index 1" memcg output, so are totally redundant.

Ok, but then we need a flag to indicate that a shrinker is memcg-aware?
But I got your point and I (partially) agree.
But do you think we're fine with just one interface and don't need
an aggregation over nodes? So just count_memcg_node?


> 
> > 6) Same but with a per-node output
> >   $ cat count_memcg_node
> >     1 209 3
> >     20 96 0
> >     53 810 7
> >     2297 2 0
> >     218 13 0
> >     581 30 0
> >     911 124 0
> >     <CUT>
> 
> So now we have a hundred nodes in the machine and thousands of
> memcgs. And the information we want is in the numerically largest
> memcg that is last in the list. ANd we want to graph it's behaviour
> over time at high resolution (say 1Hz). Now we burn huge amounts
> of CPU counting memcgs that we don't care about and then throwing
> away most of the information. That's highly in-efficient and really
> doesn't scale.

For this case we can provide an interface which allows to specify both
node and memcg and get the count. Personally I don't have a machine
with hundred nodes, so it's not on my radar.
If you find it useful, happy to add.

Thanks!

Roman
