Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B32510DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356650AbiD0BGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356597AbiD0BF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:05:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB8754A3F3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651021367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r8XIXCua6XMpuddJXBqkwZRJ8mNJ/vCZJPDOjmdzXLk=;
        b=Kd6x1V7lMJzAl+cF9cXJa24fI8JHHH7TtRSgwW03WwBpm/a3SRlZ0rX9lF5JHkrv8G7AOC
        eXr3YNEL3/A5+pMUOUqxkWszfN0bhAcKvgcMzERyW4LgEHuhVANHeOQWyPZ5wcNKsky58n
        RqMO5+30tALdqYbJ1z07jYyqi5dcQ6o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-TWbqhmDYPOSqrJjWO_QpqQ-1; Tue, 26 Apr 2022 21:02:42 -0400
X-MC-Unique: TWbqhmDYPOSqrJjWO_QpqQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B5B18001EA;
        Wed, 27 Apr 2022 01:02:42 +0000 (UTC)
Received: from rh (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC22A40314F;
        Wed, 27 Apr 2022 01:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dchinner@redhat.com>)
        id 1njW4j-006M1M-Op; Wed, 27 Apr 2022 11:02:37 +1000
Date:   Wed, 27 Apr 2022 11:02:35 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v2 0/7] mm: introduce shrinker debugfs interface
Message-ID: <YmiWK56bOHyrr64u@rh>
References: <20220422202644.799732-1-roman.gushchin@linux.dev>
 <YmeK6/eZYaMo2Ltm@rh>
 <YmhCepfMRp49PTtA@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmhCepfMRp49PTtA@carbon>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:05:30PM -0700, Roman Gushchin wrote:
> On Tue, Apr 26, 2022 at 04:02:19PM +1000, Dave Chinner wrote:
> > On Fri, Apr 22, 2022 at 01:26:37PM -0700, Roman Gushchin wrote:
> > > There are 50+ different shrinkers in the kernel, many with their own bells and
> > > whistles. Under the memory pressure the kernel applies some pressure on each of
> > > them in the order of which they were created/registered in the system. Some
> > > of them can contain only few objects, some can be quite large. Some can be
> > > effective at reclaiming memory, some not.
> > > 
> > > The only existing debugging mechanism is a couple of tracepoints in
> > > do_shrink_slab(): mm_shrink_slab_start and mm_shrink_slab_end. They aren't
> > > covering everything though: shrinkers which report 0 objects will never show up,
> > > there is no support for memcg-aware shrinkers. Shrinkers are identified by their
> > > scan function, which is not always enough (e.g. hard to guess which super
> > > block's shrinker it is having only "super_cache_scan").
> > 
> > In general, I've had no trouble identifying individual shrinker
> > instances because I'm always looking at individual subsystem
> > shrinker tracepoints, too.  Hence I've almost always got the
> > identification information in the traces I need to trace just the
> > individual shrinker tracepoints and a bit of sed/grep/awk and I've
> > got something I can feed to gnuplot or a python script to graph...
> 
> You spent a lot of time working on shrinkers in general and xfs-specific
> shrinkers in particular, no questions here. But imagine someone who's not
> a core-mm developer and is adding a new shrinker.

At which point, they add their own subsystem introspection to
understand what their shrinker implementation is doing.

You keep talking about shrinkers as if they exist in isolation
to the actual subsystems that implement shrinkers. I think that is a
fundamental mistake - you cannot understand how a shrinker is
actually working without understanding something about what the
subsystem that implements the shrinker actually does.

That is, the tracepoints in the shrinker code are largely
supplemental to the subsystem introspection that is really
determining the behaviour of the system.

The shrinker infrastructure is only providing a measure of memory
pressure - most shrinker implementations jsut don't care about what
happens in the shrinker infrastructure - they just count and scan
objects for reclaim, and mostly that just works for them.

> > > They are a passive
> > > mechanism: there is no way to call into counting and scanning of an individual
> > > shrinker and profile it.
> > 
> > IDGI. profiling shrinkers iunder ideal conditions when there isn't
> > memory pressure is largely a useless exercise because execution
> > patterns under memory pressure are vastly different.
> > 
> > All the problems with shrinkers show up when progress cannot be made
> > as fast as memory reclaim wants memory to be reclaimed. How do you
> > trigger priority windup causing large amounts of deferred processing
> > because shrinkers are running in GFP_NOFS/GFP_NOIO context? How do
> > you simulate objects getting dirtied in memory so they can't be
> > immediately reclaimed so the shrinker can't make any progress at all
> > until IO completes? How do you simulate the unbound concurrency that
> > direct reclaim can drive into the shrinkers that causes massive lock
> > contention on shared structures and locks that need to be accessed
> > to free objects?
> 
> These are valid points and I assume we can find ways to emulate some of
> these conditions, e.g. by allowing to run scanning using the GFP_NOFS context.
> I though about it but decided to left for further improvements.
> 
> > 
> > IOWs, if all you want to do is profile shrinkers running in the
> > absence of memory pressure, then you can do that perfectly well with
> > the existing 'echo 2 > /proc/sys/vm/drop_caches' mechanism. We don't
> > need some complex debugfs API just to profile the shrinker
> > behaviour.
> 
> And then we need somehow separate shrinkers in the result?

How do you profile a shrinker in the first place? You have to load
up the slab cache/LRU before you have something you can actually
profile. SO it's as simple as 'drop caches, load up cache to be
profiled, drop caches'. It's trivial to isolate the specific cache
that got loaded up from the tracepoints, and then with other
tracepoints and/or perf profiling, you can extract the profile of
the shrinker that is doing all the reclaim work.

Indeed, you can point perf at the specific task that drops the
caches, and that is all you'll get in the profile. If you can't
isolate the specific shrinker profile from the output of such a
simple test setup, then you should hand in your Kernel Developer
badge....

> > So why do we need any of the complexity and potential for abuse that
> > comes from exposing control of shrinkers directly to userspace like
> > these patches do?
> 
> I feel like the added complexity is minimal (unlike slab's sysfs, for
> example). If the config option is off (by default), there is no additional
> risk and overhead as well.

No. The argument that "if we turn it off there's no overhead" means
one of two things:

1. nobody turns it on and it never gets tested and so bitrots and is
useless, or
2. distro's all turn it on because some tool they ship or customer
they ship to wants it.

Either way, hiding it behind a config option is not an acceptible
solution for mering poorly thought out infrastructure.

> > > To provide a better visibility and debug options for memory shrinkers
> > > this patchset introduces a /sys/kernel/debug/shrinker interface, to some extent
> > > similar to /sys/kernel/slab.
> > 
> > /sys/kernel/slab contains read-only usage information - it is
> > analagous for visibility arguments, but it is not equivalent for
> > the rest of the "active" functionality you want to add here....
> > 
> > > For each shrinker registered in the system a directory is created. The directory
> > > contains "count" and "scan" files, which allow to trigger count_objects()
> > > and scan_objects() callbacks. For memcg-aware and numa-aware shrinkers
> > > count_memcg, scan_memcg, count_node, scan_node, count_memcg_node
> > > and scan_memcg_node are additionally provided. They allow to get per-memcg
> > > and/or per-node object count and shrink only a specific memcg/node.
> > 
> > Great, but why does the shrinker introspection interface need active
> > scan control functions like these?
> 
> It makes testing of (new) shrinkers easier, for example.
> For instance, shadow entries shrinker hides associated objects by returning
> 0 count most of the time (unless the total consumed memory is bigger than a
> certain amount of the total memory).
> echo 2 > /proc/sys/vm/drop_caches won't even trigger the scanning.

And that's exactly my point above: you cannot test shrinkers in
isolation of the subsystem that loads them up. In this case, you
*aren't testing the shrinker*, you are testing how the shadow entry
subsystem manages the working set. The shrinker is an integrated
part of that subsystem, so any test hooks needed to trigger the
reclaim of shadow entries belong in the ->count method of the
the shrinker implementation, such that it runs whenever the shrinker
is called rather than only when the memory usage threshold is
triggered.

At that point, drop_caches then does exactly what you need.

Shrinkers cannot be tested in isolation of the subsystem they act
on!

> > > 2) Get information about a specific shrinker:
> > >   $ cd sb-btrfs-24/
> > >   $ ls
> > >     count  count_memcg  count_memcg_node  count_node  scan  scan_memcg  scan_memcg_node  scan_node
> > > 
> > > 3) Count objects on the system/root cgroup level
> > >   $ cat count
> > >     212
> > > 
> > > 4) Count objects on the system/root cgroup level per numa node (on a 2-node machine)
> > >   $ cat count_node
> > >     209 3
> > 
> > So a single space separated line with a number per node?
> > 
> > When you have a few hundred nodes and hundreds of thousands of objects per
> > node, we overrun the 4kB page size with a single line. What then?
> 
> With seq_buf api we don't have 4kb limit, do we?

No idea. Never cared enough about sysfs to need to know.

But that doesn't avoid the issue: verbosity and overhead to
create/parse this information.


> > Also, this now iterates separate memcg per line. A parser now needs
> > to know the difference between count/count_node and
> > count_memcg/count_memcg_node because they are subtly different file
> > formats.  These files should have the same format, otherwise it just
> > creates needless complexity.
> > 
> > Indeed, why do we even need count/count_node? They are just the
> > "index 1" memcg output, so are totally redundant.
> 
> Ok, but then we need a flag to indicate that a shrinker is memcg-aware?
> But I got your point and I (partially) agree.
> But do you think we're fine with just one interface and don't need
> an aggregation over nodes? So just count_memcg_node?

/me puts on the broken record

Shrinker infrastructure needs to stop treating memcgs are something
special and off to the side. We need to integrate the code so there
is a single scan loop that simply treats the "no memcg" case as the
root memcg. Bleeding architectural/implementation deficiencies into
user visible APIs is even worse than just having to put up with them
in the implementation....

> > > 6) Same but with a per-node output
> > >   $ cat count_memcg_node
> > >     1 209 3
> > >     20 96 0
> > >     53 810 7
> > >     2297 2 0
> > >     218 13 0
> > >     581 30 0
> > >     911 124 0
> > >     <CUT>
> > 
> > So now we have a hundred nodes in the machine and thousands of
> > memcgs. And the information we want is in the numerically largest
> > memcg that is last in the list. ANd we want to graph it's behaviour
> > over time at high resolution (say 1Hz). Now we burn huge amounts
> > of CPU counting memcgs that we don't care about and then throwing
> > away most of the information. That's highly in-efficient and really
> > doesn't scale.
> 
> For this case we can provide an interface which allows to specify both
> node and memcg and get the count. Personally I don't have a machine
> with hundred nodes, so it's not on my radar.

Yup, but there are people how do have this sort of machine, which do
use memcgs (in their thousands) and do have many, many superblocks
(in their thousands). Just because you personally don't have such
machines it does not mean you don't have to design for such
machines. Saying "I don't care other people's requirements" is
exactly what Kent had a rant about in the other leg of this thread.

We know that we have these scalability issues in generic
infrastructure, and therefore generic infrastructure has to handle
these issues at a architecture and design level. We don't need the
initial implementation to work well at such levels of scalability,
but we sure as hell need the design, APIs and file formats to scale
out because if it doesn't scale there is no question that *we will
have to fix it*.

So, yeah, you need to think about how to do fine-grained access to
shrinker stats effectively. That might require a complete change of
presentation API. For example, changing the filesystem layout to
be memcg centric rather than shrinker instance centric would make an
awful lot of this file parsing problem go away.

e.g:

/sys/kernel/debug/mm/memcg/<memcg instance>/shrinker/<shrinker instance>/stats

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com

