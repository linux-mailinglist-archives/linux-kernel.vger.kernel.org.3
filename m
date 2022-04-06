Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BEC4F5606
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 08:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392105AbiDFFyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 01:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2360919AbiDFDoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 23:44:03 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA4182706FD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:11:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2EABE10E56C3;
        Wed,  6 Apr 2022 10:11:07 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nbtGM-00EFWW-5v; Wed, 06 Apr 2022 10:11:06 +1000
Date:   Wed, 6 Apr 2022 10:11:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Yang Shi <shy828301@gmail.com>, Hillf Danton <hdanton@sina.com>,
        MM <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
Message-ID: <20220406001106.GA1609613@dread.disaster.area>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
 <20220404010948.GV1609613@dread.disaster.area>
 <YktCKVbChtC+YjOk@carbon.dhcp.thefacebook.com>
 <20220405051710.GW1609613@dread.disaster.area>
 <Ykxv1j9dxlz1BS5N@carbon.dhcp.thefacebook.com>
 <CAHbLzko=bjLhhJXjcs0Uh-g3x9vV1gQZjEU2JqxVehqSb1UGkQ@mail.gmail.com>
 <Yky1FgLrlIOfpCZ+@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yky1FgLrlIOfpCZ+@carbon.dhcp.thefacebook.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=624cda9d
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=Fe5XsLPeW7db1_PS-6wA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 02:31:02PM -0700, Roman Gushchin wrote:
> On Tue, Apr 05, 2022 at 01:58:59PM -0700, Yang Shi wrote:
> > On Tue, Apr 5, 2022 at 9:36 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > On Tue, Apr 05, 2022 at 03:17:10PM +1000, Dave Chinner wrote:
> > > > On Mon, Apr 04, 2022 at 12:08:25PM -0700, Roman Gushchin wrote:
> > > > > On Mon, Apr 04, 2022 at 11:09:48AM +1000, Dave Chinner wrote:
> > IMHO
> > the number of really freed pages should be returned (I do understand
> > it is not that easy for now), and returning 0 should be fine.
> 
> It's doable, there is already a mechanism in place which hooks into
> the slub/slab/slob release path and stops the slab reclaim as a whole
> if enough memory was freed.

The reclaim state that accounts for slab pages freed really
needs to be first class shrinker state that is aggregated at the
do_shrink_slab() level and passed back to the vmscan code. The
shrinker infrastructure itself should be aware of the progress each
shrinker is making - not just objects reclaimed but also pages
reclaimed - so it can make better decisions about how much work
should be done by each shrinker.

e.g. lots of objects in cache, lots of objects reclaimed, no pages
reclaimed is indicative of a fragmented slab cache. If this keeps
happening, we should be trying to apply extra pressure to this
specific cache because the only method we have for correcting a
fragmented cache to return some memory is to reclaim lots more
objects from it. 

> > The
> > current logic (returning the number of objects) may feed up something
> > over-optimistic. I, at least, experienced once or twice that a
> > significant amount of slab caches were shrunk, but actually 0 pages
> > were freed actually. TBH the new slab controller may make it worse
> > since the page may be pinned by the objects from other memcgs.
> 
> Of course, the more dense the placement of objects is, the harder is to get
> the physical pages back. But usually it pays off by having a dramatically
> lower total number of slab pages.

Unless you have tens of millions of objects in the cache. The dentry
cache is a prime example of this "lots of tiny cached objects" where
we have tens of objects per slab page and so can suffer badly from
internal fragmentation....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
