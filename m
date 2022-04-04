Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365D54F0D55
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 03:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348602AbiDDBL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 21:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbiDDBLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 21:11:51 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9100032EEF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 18:09:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 30D0A10E562F;
        Mon,  4 Apr 2022 11:09:49 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nbBE4-00DTdp-CR; Mon, 04 Apr 2022 11:09:48 +1000
Date:   Mon, 4 Apr 2022 11:09:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
Message-ID: <20220404010948.GV1609613@dread.disaster.area>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403005618.5263-1-hdanton@sina.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=624a4560
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=xEwM7xfV6nKN0_kzd_YA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 08:56:18AM +0800, Hillf Danton wrote:
> On Sat, 2 Apr 2022 10:54:36 -0700 Roman Gushchin wrote:
> > Hello Hillf!
> > 
> Hello Roman,
> 
> > Thank you for sharing it, really interesting! I=E2=80=99m actually working o=
> > n the same problem.=20
> 
> Good to know you have some interest in it.
> Feel free to let me know you would like to take it over to avoid
> repeated works on both sides.
> 
> > 
> > No code to share yet, but here are some of my thoughts:
> > 1) If there is a =E2=80=9Cnatural=E2=80=9D memory pressure, no additional sl=
> > ab scanning is needed.
> 
> Agree - the periodic shrinker can be canceled once kswapd wakes up.

I think we should be waking up per-node kswapd to do the periodic
shrinking, not adding yet another way of executing (thousands of)
shrinkers (across hundreds of nodes) from a single threaded context.

Indeed, the problem of "no reclaim when there is no memory
pressure" also affects the page cache, not just shrinkable caches
and we really don't want periodic reclaim to have a compeltely
different behaviour to general memory reclaim.

i.e. the amount of work that shrinkers need to do in a periodic scan
is largerly determined by the rate of shrinkable cache memory usage
growth rather than memory reclaim priority as it is now. Hence there
needs to be different high level "shrinker needs to do X amount of
work" calculation for periodic reclaim than there is now.

e.g. we calculate a rolling average of the size of the cache and a
rate of change over a series of polling operations (i.e. calling
->scan_count) and then when sustained growth is detected we start
trying to shrink the cache to limit the rate of growth of the cache.

If the cache keeps growing, then it's objects are being repeatedly
referenced and it *should* keep growing. If it's one-off objects
that are causing the growth of the cache and so objects are being
reclaimed by the shrinker, then matching the periodic shrink scan to
the growth rate will substantially reduce the rate of growth of that
cache.

And if it's integrated into the existing do_shrink_slab
calculations, the moment actual memory reclaim calls the shrinker
the periodic scan calculations can be reset back to zero and it
starts again...

> > 2) =46rom a power perspective it=E2=80=99s better to scan more at once, but l=
> > ess often.
> 
> The shrinker proposed is a catapult on the vmscan side without knowing
> where the cold slab objects are piling up in Dave's backyard but he is
> free to take different actions than the regular shrinker - IOW this
> shrinker alone does not make much sense wrt shooting six birds without
> the stone on the slab owner side.
> 
> It is currently scanning *every* slab cache at an arbitrary frequency,
> once 30 seconds - I am open to a minute or whatever.

Sorry, I don't understand what "Dave's backyard" is or why it would
ever need to be special cased?

> > 3) Maybe we need a feedback loop with the slab allocator: e.g. if slabs are a=
> > lmost full there is more sense to do a proactive scanning and free up some m=
> > emory, otherwise we=E2=80=99ll end up allocating more slabs. But it=E2=80=99=
> > s tricky.
> 
> There are 31 bits available in the periodic flag added to shrink control.
> 
> > 4) If the scanning is not resulting in any memory reclaim, maybe we should (=
> > temporarily) exclude the corresponding shrinker from the scanning.
> 
> Given the periodic flag, Dave is free to ignore the scan request and the
> scan result is currently dropped on the vmscan side because what is
> considered is the cold slab objects that for instance have been inactive
> for more than 30 seconds in every slab cache, rather than kswapd's cake.

I don't understand how passing a "periodic" flag to individual
shrinkers is really useful here. How does the shrinker
implementation use this to determine how much work it needs to do?

i.e. The amount of work a shrinker needs to perform is calculated by
the high level slab scanning code based on relative cache size and
reclaim priority.  If there's a periodic scanner, it should be
calculating a specific amount of work for the shrinkers to do way up
in do_shrink_slab() and then asking the shrinker to perform that
work in exactly the way it does now - the shrinker itself doesn't
need to know anything about whether it's a periodic memory reclaim
scan or whether there's actual memory pressure - it just needs to
scan the oldest objects in it's cache to try to reclaim them.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
