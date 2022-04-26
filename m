Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5577450F098
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243283AbiDZGFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242364AbiDZGFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BDF7762A1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650952951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2xKSX3BQlzuXx64E125yvVVh3IA1WtVTF6M+FT63WyU=;
        b=Fng6oRO+DXOWi7RA9rVCVYmSPKROR6LZzGpLjIN1+sqBXjRMTWrJiTR9Tog/VoGcDuYwiJ
        Eb/kkMG6Hk7fxe5ADfNaw95OnRMeYZJrwnMBY8oEslqCyYmxkq/otuciyvk3CM543BLnKV
        iZkbh5Oi274lh7xqrLqoXk5VkV9vyCk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-kuDowMhgN3iAJyXfyMefdA-1; Tue, 26 Apr 2022 02:02:28 -0400
X-MC-Unique: kuDowMhgN3iAJyXfyMefdA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B44E86B8B0;
        Tue, 26 Apr 2022 06:02:28 +0000 (UTC)
Received: from rh (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EC4748FB01;
        Tue, 26 Apr 2022 06:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dchinner@redhat.com>)
        id 1njEHF-00DBwY-0X; Tue, 26 Apr 2022 16:02:21 +1000
Date:   Tue, 26 Apr 2022 16:02:19 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v2 0/7] mm: introduce shrinker debugfs interface
Message-ID: <YmeK6/eZYaMo2Ltm@rh>
References: <20220422202644.799732-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422202644.799732-1-roman.gushchin@linux.dev>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:26:37PM -0700, Roman Gushchin wrote:
> There are 50+ different shrinkers in the kernel, many with their own bells and
> whistles. Under the memory pressure the kernel applies some pressure on each of
> them in the order of which they were created/registered in the system. Some
> of them can contain only few objects, some can be quite large. Some can be
> effective at reclaiming memory, some not.
> 
> The only existing debugging mechanism is a couple of tracepoints in
> do_shrink_slab(): mm_shrink_slab_start and mm_shrink_slab_end. They aren't
> covering everything though: shrinkers which report 0 objects will never show up,
> there is no support for memcg-aware shrinkers. Shrinkers are identified by their
> scan function, which is not always enough (e.g. hard to guess which super
> block's shrinker it is having only "super_cache_scan").

In general, I've had no trouble identifying individual shrinker
instances because I'm always looking at individual subsystem
shrinker tracepoints, too.  Hence I've almost always got the
identification information in the traces I need to trace just the
individual shrinker tracepoints and a bit of sed/grep/awk and I've
got something I can feed to gnuplot or a python script to graph...

> They are a passive
> mechanism: there is no way to call into counting and scanning of an individual
> shrinker and profile it.

IDGI. profiling shrinkers iunder ideal conditions when there isn't
memory pressure is largely a useless exercise because execution
patterns under memory pressure are vastly different.

All the problems with shrinkers show up when progress cannot be made
as fast as memory reclaim wants memory to be reclaimed. How do you
trigger priority windup causing large amounts of deferred processing
because shrinkers are running in GFP_NOFS/GFP_NOIO context? How do
you simulate objects getting dirtied in memory so they can't be
immediately reclaimed so the shrinker can't make any progress at all
until IO completes? How do you simulate the unbound concurrency that
direct reclaim can drive into the shrinkers that causes massive lock
contention on shared structures and locks that need to be accessed
to free objects?

IOWs, if all you want to do is profile shrinkers running in the
absence of memory pressure, then you can do that perfectly well with
the existing 'echo 2 > /proc/sys/vm/drop_caches' mechanism. We don't
need some complex debugfs API just to profile the shrinker
behaviour.

So why do we need any of the complexity and potential for abuse that
comes from exposing control of shrinkers directly to userspace like
these patches do?

> To provide a better visibility and debug options for memory shrinkers
> this patchset introduces a /sys/kernel/debug/shrinker interface, to some extent
> similar to /sys/kernel/slab.

/sys/kernel/slab contains read-only usage information - it is
analagous for visibility arguments, but it is not equivalent for
the rest of the "active" functionality you want to add here....

> For each shrinker registered in the system a directory is created. The directory
> contains "count" and "scan" files, which allow to trigger count_objects()
> and scan_objects() callbacks. For memcg-aware and numa-aware shrinkers
> count_memcg, scan_memcg, count_node, scan_node, count_memcg_node
> and scan_memcg_node are additionally provided. They allow to get per-memcg
> and/or per-node object count and shrink only a specific memcg/node.

Great, but why does the shrinker introspection interface need active
scan control functions like these?

> To make debugging more pleasant, the patchset also names all shrinkers,
> so that debugfs entries can have more meaningful names.
> 
> Usage examples:
> 
> 1) List registered shrinkers:
>   $ cd /sys/kernel/debug/shrinker/
>   $ ls
>     dqcache-16          sb-cgroup2-30    sb-hugetlbfs-33  sb-proc-41       sb-selinuxfs-22  sb-tmpfs-40    sb-zsmalloc-19
>     kfree_rcu-0         sb-configfs-23   sb-iomem-12      sb-proc-44       sb-sockfs-8      sb-tmpfs-42    shadow-18
>     sb-aio-20           sb-dax-11        sb-mqueue-21     sb-proc-45       sb-sysfs-26      sb-tmpfs-43    thp_deferred_split-10
>     sb-anon_inodefs-15  sb-debugfs-7     sb-nsfs-4        sb-proc-47       sb-tmpfs-1       sb-tmpfs-46    thp_zero-9
>     sb-bdev-3           sb-devpts-28     sb-pipefs-14     sb-pstore-31     sb-tmpfs-27      sb-tmpfs-49    xfs_buf-37
>     sb-bpf-32           sb-devtmpfs-5    sb-proc-25       sb-rootfs-2      sb-tmpfs-29      sb-tracefs-13  xfs_inodegc-38
>     sb-btrfs-24         sb-hugetlbfs-17  sb-proc-39       sb-securityfs-6  sb-tmpfs-35      sb-xfs-36      zspool-34

Ouch. That's not going to be useful for humans debugging a system as
there's no way to cross reference a "superblock" with an actual
filesystem mount point. Nor is there any way to reallly know that
all the shrinkers in one filesystem are related.

We normally solve this by ensuring that the fs related object has
the short bdev name appended to them. e.g:

$ pgrep xfs
1 I root          36       2  0  60 -20 -     0 -      Apr19 ?        00:00:10 [kworker/0:1H-xfs-log/dm-3]
1 I root         679       2  0  60 -20 -     0 -      Apr19 ?        00:00:00 [xfsalloc]
1 I root         680       2  0  60 -20 -     0 -      Apr19 ?        00:00:00 [xfs_mru_cache]
1 I root         681       2  0  60 -20 -     0 -      Apr19 ?        00:00:00 [xfs-buf/dm-1]
.....

Here we have a kworker process running log IO completion work on
dm-3, two global workqueue rescuer tasks (alloc, mru) and a rescuer
task for xfs-buf workqueue on dm-1.

We need the same name discrimination for shrinker information here,
too - just saying "this is an XFS superblock shrinker" is just not
sufficient when there are hundreds of XFS mount points with a
handful of shrinkers each.

> 2) Get information about a specific shrinker:
>   $ cd sb-btrfs-24/
>   $ ls
>     count  count_memcg  count_memcg_node  count_node  scan  scan_memcg  scan_memcg_node  scan_node
> 
> 3) Count objects on the system/root cgroup level
>   $ cat count
>     212
> 
> 4) Count objects on the system/root cgroup level per numa node (on a 2-node machine)
>   $ cat count_node
>     209 3

So a single space separated line with a number per node?

When you have a few hundred nodes and hundreds of thousands of objects per
node, we overrun the 4kB page size with a single line. What then?

> 5) Count objects for each memcg (output format: cgroup inode, count)
>   $ cat count_memcg
>     1 212
>     20 96
>     53 817
>     2297 2
>     218 13
>     581 30
>     911 124
>     <CUT>

What does "<CUT>" mean?

Also, this now iterates separate memcg per line. A parser now needs
to know the difference between count/count_node and
count_memcg/count_memcg_node because they are subtly different file
formats.  These files should have the same format, otherwise it just
creates needless complexity.

Indeed, why do we even need count/count_node? They are just the
"index 1" memcg output, so are totally redundant.

> 6) Same but with a per-node output
>   $ cat count_memcg_node
>     1 209 3
>     20 96 0
>     53 810 7
>     2297 2 0
>     218 13 0
>     581 30 0
>     911 124 0
>     <CUT>

So now we have a hundred nodes in the machine and thousands of
memcgs. And the information we want is in the numerically largest
memcg that is last in the list. ANd we want to graph it's behaviour
over time at high resolution (say 1Hz). Now we burn huge amounts
of CPU counting memcgs that we don't care about and then throwing
away most of the information. That's highly in-efficient and really
doesn't scale.

[snap active scan interface]

This just seems like a solution looking for a problem to solve.
Can you please describe the problem this infrastructure is going
to solve?

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com

