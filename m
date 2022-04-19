Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29BB5076E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344216AbiDSSB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356158AbiDSSBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:01:23 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8610613D61
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:58:40 -0700 (PDT)
Date:   Tue, 19 Apr 2022 10:58:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650391118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LwMEsoXiVBDMMlTnWr1tF9A5/2DsUEfBfNSdTUYTpLQ=;
        b=GSeP4KlZhPpf+uMxHvjav5FPXp0dJ579TdtR8KLfaXlePkdpBE1fC+WWHOtb/f2Y2ujT0C
        wGB6njWc6l5pB8jXYw9Nrrp5C0Rgiq2pRexIanJAIBeZm7haDbH/jW8fuz7j7gtkze/8yP
        JULqwDoS/c8b/+WlglVpvr6YOWVyYJU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-ID: <Yl74SeTY68zs8ziL@carbon>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
 <Yl0vCDE44VeU8qxC@kernel.org>
 <Yl2fhgcW5pL66nPK@carbon>
 <Yl5XzCjqKbKYdvrC@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl5XzCjqKbKYdvrC@kernel.org>
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

On Tue, Apr 19, 2022 at 09:33:48AM +0300, Mike Rapoport wrote:
> On Mon, Apr 18, 2022 at 10:27:34AM -0700, Roman Gushchin wrote:
> > On Mon, Apr 18, 2022 at 12:27:36PM +0300, Mike Rapoport wrote:
> > > On Fri, Apr 15, 2022 at 05:27:51PM -0700, Roman Gushchin wrote:
> > > > There are 50+ different shrinkers in the kernel, many with their own bells and
> > > > whistles. Under the memory pressure the kernel applies some pressure on each of
> > > > them in the order of which they were created/registered in the system. Some
> > > > of them can contain only few objects, some can be quite large. Some can be
> > > > effective at reclaiming memory, some not.
> > > > 
> > > > The only existing debugging mechanism is a couple of tracepoints in
> > > > do_shrink_slab(): mm_shrink_slab_start and mm_shrink_slab_end. They aren't
> > > > covering everything though: shrinkers which report 0 objects will never show up,
> > > > there is no support for memcg-aware shrinkers. Shrinkers are identified by their
> > > > scan function, which is not always enough (e.g. hard to guess which super
> > > > block's shrinker it is having only "super_cache_scan"). They are a passive
> > > > mechanism: there is no way to call into counting and scanning of an individual
> > > > shrinker and profile it.
> > > > 
> > > > To provide a better visibility and debug options for memory shrinkers
> > > > this patchset introduces a /sys/kernel/shrinker interface, to some extent
> > > > similar to /sys/kernel/slab.
> > > 
> > > Wouldn't debugfs better fit the purpose of shrinker debugging?
> > 
> > I think sysfs fits better, but not a very strong opinion.
> > 
> > Even though the interface is likely not very useful for the general
> > public, big cloud instances might wanna enable it to gather statistics
> > (and it's certainly what we gonna do at Facebook) and to provide
> > additional data when something is off.  They might not have debugfs
> > mounted. And it's really similar to /sys/kernel/slab.
> 
> And there is also similar /proc/vmallocinfo so why not /proc/shrinker? ;-)
> 
> I suspect slab ended up in sysfs because nobody suggested to use debugfs
> back then. I've been able to track the transition from /proc/slabinfo to
> /proc/slubinfo to /sys/kernel/slab, but could not find why Christoph chose
> sysfs in the end.
>
> > Are there any reasons why debugfs is preferable?
> 
> debugfs is more flexible because it's not stable kernel ABI so if there
> will be need/desire to change the layout and content of the files with
> debugfs it can be done more easily.
> 
> Is this a real problem for Facebook to mount debugfs? ;-)

Fair enough, switching to debugfs in the next version.

Thanks!
