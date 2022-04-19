Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF3B506493
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348867AbiDSGgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiDSGgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:36:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA042C64A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4AD6B81186
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB14C385A5;
        Tue, 19 Apr 2022 06:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650350036;
        bh=4/35g5b4ZPqhbhpRVje281c0PbxC2UdS5Qu7e3PjXDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UuI5vRWx9SIIgxgR49VZO41fWcEu/6+vg7zcF43WXML0/Dfp4hhvIrCoUtscu7j4c
         6vdOBRuKqH6RQ+16CdG5HWRuX4obTn1x5iNxxNBzVtH97c/RrYd5GNKKGQZ4AHStku
         hj+0G4NmXx5vzTIBu+Q8hGyALhuPv8RSHBK0tAqnZs+rwL/JZckpBjXHG6XSMu+BBF
         D29OEOurKDKtGwLHiLKPEaZDl4yhRnhFBOXNBsOsRMZ8SHxbNVWQ/aXIFrJLzamo8k
         omevuMhJxmq8P2YDqePLhx0fWFVmLXSPhW6l4DeMK3Dwocyg3f3JxOEZsoUHWY5SK6
         V17w6KG6EJ0pQ==
Date:   Tue, 19 Apr 2022 09:33:48 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-ID: <Yl5XzCjqKbKYdvrC@kernel.org>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
 <Yl0vCDE44VeU8qxC@kernel.org>
 <Yl2fhgcW5pL66nPK@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl2fhgcW5pL66nPK@carbon>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 10:27:34AM -0700, Roman Gushchin wrote:
> On Mon, Apr 18, 2022 at 12:27:36PM +0300, Mike Rapoport wrote:
> > On Fri, Apr 15, 2022 at 05:27:51PM -0700, Roman Gushchin wrote:
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
> > > block's shrinker it is having only "super_cache_scan"). They are a passive
> > > mechanism: there is no way to call into counting and scanning of an individual
> > > shrinker and profile it.
> > > 
> > > To provide a better visibility and debug options for memory shrinkers
> > > this patchset introduces a /sys/kernel/shrinker interface, to some extent
> > > similar to /sys/kernel/slab.
> > 
> > Wouldn't debugfs better fit the purpose of shrinker debugging?
> 
> I think sysfs fits better, but not a very strong opinion.
> 
> Even though the interface is likely not very useful for the general
> public, big cloud instances might wanna enable it to gather statistics
> (and it's certainly what we gonna do at Facebook) and to provide
> additional data when something is off.  They might not have debugfs
> mounted. And it's really similar to /sys/kernel/slab.

And there is also similar /proc/vmallocinfo so why not /proc/shrinker? ;-)

I suspect slab ended up in sysfs because nobody suggested to use debugfs
back then. I've been able to track the transition from /proc/slabinfo to
/proc/slubinfo to /sys/kernel/slab, but could not find why Christoph chose
sysfs in the end.

> Are there any reasons why debugfs is preferable?

debugfs is more flexible because it's not stable kernel ABI so if there
will be need/desire to change the layout and content of the files with
debugfs it can be done more easily.

Is this a real problem for Facebook to mount debugfs? ;-)
 
> Thanks!

-- 
Sincerely yours,
Mike.
