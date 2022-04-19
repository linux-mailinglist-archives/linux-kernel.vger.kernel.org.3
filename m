Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36385076D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356114AbiDSRzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347104AbiDSRzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:55:40 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EBE14001
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:52:53 -0700 (PDT)
Date:   Tue, 19 Apr 2022 10:52:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650390771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SfBMtVC6cxlmXGMToYn3RMPEkBD2wA2UrUn7gz2EpD4=;
        b=MKGt11/w2TI36Xksr0+rW60dJ5ACZhCfEYRS0MEOv2Y17zLsKbl2o8akhrix6EDF4trW2+
        2hyCgIf469yGs1B4SeoQd7ucfmG98He0OLUv6h1exKc/SWavAVevtkpz5MlDuI14Xv5MK5
        nuiLn4iJXEo/yZ91QpW16ZsI3bukD90=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-ID: <Yl727M1Dxm+vC/R1@carbon>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
 <20220418212709.42f2ba15e00999bb57086b27@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418212709.42f2ba15e00999bb57086b27@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 09:27:09PM -0700, Andrew Morton wrote:
> On Fri, 15 Apr 2022 17:27:51 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:
> 
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
> > block's shrinker it is having only "super_cache_scan"). They are a passive
> > mechanism: there is no way to call into counting and scanning of an individual
> > shrinker and profile it.
> > 
> > To provide a better visibility and debug options for memory shrinkers
> > this patchset introduces a /sys/kernel/shrinker interface, to some extent
> > similar to /sys/kernel/slab.
> > 
> > For each shrinker registered in the system a folder is created.
> 
> Please, "directory".

Of course, sorry :)

> 
> > The folder
> > contains "count" and "scan" files, which allow to trigger count_objects()
> > and scan_objects() callbacks. For memcg-aware and numa-aware shrinkers
> > count_memcg, scan_memcg, count_node, scan_node, count_memcg_node
> > and scan_memcg_node are additionally provided. They allow to get per-memcg
> > and/or per-node object count and shrink only a specific memcg/node.
> > 
> > To make debugging more pleasant, the patchset also names all shrinkers,
> > so that sysfs entries can have more meaningful names.
> 
> I also was wondering "why not debugfs".

Fair enough, moving to debugfs in v1.

> 
> > Usage examples:
> > 
> > ...
> >
> > If the output doesn't fit into a single page, "...\n" is printed at the end of
> > output.
> 
> Unclear.  At the end of what output?

This is how it looks like when the output is too long:

[root@eth50-1 sb-btrfs-24]# cat count_memcg
1 226
20 96
53 811
2429 2
218 13
581 29
911 124
1010 3
1043 1
1076 1
1241 60
1274 7
1307 39
1340 3
1406 14
1439 63
1472 54
1505 8
1538 1
1571 6
1604 39
1637 9
1670 8
1703 4
1736 1094
1802 2
1868 2
1901 52
1934 592
1967 32
			< CUT >
18797 1
18830 1
18863 1
18896 1
18929 1
18962 1
18995 1
19028 1
19061 1
19094 1
19127 1
19160 1
19193 1
...

I'll try to make it more obvious from the description.

> 
> > 
> > Roman Gushchin (5):
> >   mm: introduce sysfs interface for debugging kernel shrinker
> >   mm: memcontrol: introduce mem_cgroup_ino() and
> >     mem_cgroup_get_from_ino()
> >   mm: introduce memcg interfaces for shrinker sysfs
> >   mm: introduce numa interfaces for shrinker sysfs
> >   mm: provide shrinkers with names
> > 
> >  arch/x86/kvm/mmu/mmu.c                        |   2 +-
> >  ...
> >
> 
> Nothing under Documentation/!

I planned to add it after the rfc version. Will do.

Thank you for taking a look!
