Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBE44F1DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353009AbiDDVom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380174AbiDDTKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:10:32 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDEFB93
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 12:08:33 -0700 (PDT)
Date:   Mon, 4 Apr 2022 12:08:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649099311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yHousyzC3FU6OH50zh8PHJ35RyiTGL+iOjn1Iy2qNF8=;
        b=kcZ1LoeeOmG16dUAKruhnFD/9tejvdhAa0KF6/6HUxRp4IOrzhWQEq5ISZAFobojmDY55n
        xk84eo1lk0mSPUprPiOJ2wXgV6To2ezWzMOQ2wAvQeOqJsJi5q0DHLq1xFRn6jxBw0/Ao8
        NmSb+ismXYw2QI7oPu0UA16Z4IZULeE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Hillf Danton <hdanton@sina.com>, MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
Message-ID: <YktCKVbChtC+YjOk@carbon.dhcp.thefacebook.com>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
 <20220404010948.GV1609613@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404010948.GV1609613@dread.disaster.area>
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

On Mon, Apr 04, 2022 at 11:09:48AM +1000, Dave Chinner wrote:
> On Sun, Apr 03, 2022 at 08:56:18AM +0800, Hillf Danton wrote:
> > On Sat, 2 Apr 2022 10:54:36 -0700 Roman Gushchin wrote:
> > > Hello Hillf!
> > > 
> > Hello Roman,
> > 
> > > Thank you for sharing it, really interesting! I=E2=80=99m actually working o=
> > > n the same problem.=20
> > 
> > Good to know you have some interest in it.
> > Feel free to let me know you would like to take it over to avoid
> > repeated works on both sides.
> > 
> > > 
> > > No code to share yet, but here are some of my thoughts:
> > > 1) If there is a =E2=80=9Cnatural=E2=80=9D memory pressure, no additional sl=
> > > ab scanning is needed.
> > 
> > Agree - the periodic shrinker can be canceled once kswapd wakes up.
> 
> I think we should be waking up per-node kswapd to do the periodic
> shrinking, not adding yet another way of executing (thousands of)
> shrinkers (across hundreds of nodes) from a single threaded context.

I'm on the same page here. Ideally we just need to set somewhere an
"extra" slab scanning target and wake kswapd.

> 
> Indeed, the problem of "no reclaim when there is no memory
> pressure" also affects the page cache, not just shrinkable caches
> and we really don't want periodic reclaim to have a compeltely
> different behaviour to general memory reclaim.

I agree. Slabs are a worse because they fragment the memory with unmovable
pages and are generally slower/more expensive to reclaim. But in general
it's the same problem.

> 
> i.e. the amount of work that shrinkers need to do in a periodic scan
> is largerly determined by the rate of shrinkable cache memory usage
> growth rather than memory reclaim priority as it is now. Hence there
> needs to be different high level "shrinker needs to do X amount of
> work" calculation for periodic reclaim than there is now.
> 
> e.g. we calculate a rolling average of the size of the cache and a
> rate of change over a series of polling operations (i.e. calling
> ->scan_count) and then when sustained growth is detected we start
> trying to shrink the cache to limit the rate of growth of the cache.
> 
> If the cache keeps growing, then it's objects are being repeatedly
> referenced and it *should* keep growing. If it's one-off objects
> that are causing the growth of the cache and so objects are being
> reclaimed by the shrinker, then matching the periodic shrink scan to
> the growth rate will substantially reduce the rate of growth of that
> cache.

A clever idea!

It seems like we need to add some stats to the list_lru API or maybe to
the shrinker API (and let list_lru to use it).
E.g. total/scanned/reclaimed, maybe with a time decay

I'm also thinking about:
1) adding a sysfs/debugfs interface to expose shrinkers current size and
   statistics, with an ability to call into the reclaim manually.
2) formalizing a reference bit/counter API on the shrinkers level, so that
   shrinker users can explicitly mark objects (re)-"activation".
3) _maybe_ we need to change the shrinkers API from a number of objects to
   bytes, so that releasing a small number of large objects can compete with
   a releasing on many small objects. But I'm not sure.
4) also some shrinkers (e.g. shadow nodes) lying about the total size of
   objects and I have an uneasy feeling about this approach.

Dave, what are your thoughts on these ideas/issues?

> 
> And if it's integrated into the existing do_shrink_slab
> calculations, the moment actual memory reclaim calls the shrinker
> the periodic scan calculations can be reset back to zero and it
> starts again...
> 
> > > 2) =46rom a power perspective it=E2=80=99s better to scan more at once, but l=
> > > ess often.
> > 
> > The shrinker proposed is a catapult on the vmscan side without knowing
> > where the cold slab objects are piling up in Dave's backyard but he is
> > free to take different actions than the regular shrinker - IOW this
> > shrinker alone does not make much sense wrt shooting six birds without
> > the stone on the slab owner side.
> > 
> > It is currently scanning *every* slab cache at an arbitrary frequency,
> > once 30 seconds - I am open to a minute or whatever.
> 
> Sorry, I don't understand what "Dave's backyard" is or why it would
> ever need to be special cased?

Me neither.

Also 30s seconds sound like a perfect way to drain the laptop's battery,
I'd say 1h is a more reasonable scale, but of course it's a pure speculation.

> 
> > > 3) Maybe we need a feedback loop with the slab allocator: e.g. if slabs are a=
> > > lmost full there is more sense to do a proactive scanning and free up some m=
> > > emory, otherwise we=E2=80=99ll end up allocating more slabs. But it=E2=80=99=
> > > s tricky.
> > 
> > There are 31 bits available in the periodic flag added to shrink control.
> > 
> > > 4) If the scanning is not resulting in any memory reclaim, maybe we should (=
> > > temporarily) exclude the corresponding shrinker from the scanning.
> > 
> > Given the periodic flag, Dave is free to ignore the scan request and the
> > scan result is currently dropped on the vmscan side because what is
> > considered is the cold slab objects that for instance have been inactive
> > for more than 30 seconds in every slab cache, rather than kswapd's cake.
> 
> I don't understand how passing a "periodic" flag to individual
> shrinkers is really useful here. How does the shrinker
> implementation use this to determine how much work it needs to do?
> 
> i.e. The amount of work a shrinker needs to perform is calculated by
> the high level slab scanning code based on relative cache size and
> reclaim priority.  If there's a periodic scanner, it should be
> calculating a specific amount of work for the shrinkers to do way up
> in do_shrink_slab() and then asking the shrinker to perform that
> work in exactly the way it does now - the shrinker itself doesn't
> need to know anything about whether it's a periodic memory reclaim
> scan or whether there's actual memory pressure - it just needs to
> scan the oldest objects in it's cache to try to reclaim them.

Again I'm on the same page here. We have a mechanism for a deferred work,
it or something similar can be reused to schedule an extra work.

Thanks!
