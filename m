Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DD050ADD6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443427AbiDVCjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245153AbiDVCjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:39:43 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2239C4B438
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:36:52 -0700 (PDT)
Date:   Thu, 21 Apr 2022 19:36:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650595010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zo2fUmTVY98S/ssCWYYXtGvtMEnD9SsQzaQapZz/cs0=;
        b=SAFLUdVggf+g1vIuiTaQiZr3jWAW76MR5zoqV4rcAKalfTWS5qHymitEV5P9GaU9AmoZhc
        n/hZNQAW6s028uurJW0SQ7tUXc0oaQpRWi4YZVQCgZw49RDsqlE0gTU2qRlkEg233zCAWx
        vfI13w3z1v6nsWsNFucnN2jQb68vlTU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] mm: do not call add_nr_deferred() with zero deferred
Message-ID: <YmIUvdjSlRD6udQg@carbon>
References: <20220416004104.4089743-1-roman.gushchin@linux.dev>
 <59404249-de0c-c569-d04a-9da38ed14b0a@redhat.com>
 <Yl7mdguNR3CabMAN@carbon>
 <YmICiX2DFSveY17Z@rh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmICiX2DFSveY17Z@rh>
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

On Fri, Apr 22, 2022 at 11:19:05AM +1000, Dave Chinner wrote:
> On Tue, Apr 19, 2022 at 09:42:30AM -0700, Roman Gushchin wrote:
> > On Tue, Apr 19, 2022 at 02:56:06PM +0200, David Hildenbrand wrote:
> > > On 16.04.22 02:41, Roman Gushchin wrote:
> > > > add_nr_deferred() is often called with next_deferred equal to 0.
> > > > For instance, it's happening under low memory pressure for any
> > > > shrinkers with a low number of cached objects. A corresponding trace
> > > > looks like:
> > > >   <...>-619914 [005] .... 467456.345160: mm_shrink_slab_end: \
> > > >   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1	     \
> > > >   unused scan count 0 new scan count 0 total_scan 0	     \
> > > >   last shrinker return val 0
> > > > 
> > > >   <...>-619914 [005] .... 467456.345371: mm_shrink_slab_end: \
> > > >   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1	     \
> > > >   unused scan count 0 new scan count 0 total_scan 0	     \
> > > >   last shrinker return val 0
> > > > 
> > > >   <...>-619914 [005] .... 467456.345380: mm_shrink_slab_end: \
> > > >   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1 unused \
> > > >   scan count 0 new scan count 0 total_scan 0	             \
> > > >   last shrinker return val 0
> > > > 
> > > > This lead to unnecessary checks and atomic operations, which can be
> > > > avoided by checking next_deferred for not being zero before calling
> > > > add_nr_deferred(). In this case the mm_shrink_slab_end trace point
> > > > will get a potentially slightly outdated "new scan count" value, but
> > > > it's totally fine.
> > > 
> > > Sufficient improvement to justify added complexity for anybody reading
> > > that code?
> > 
> > I don't have any numbers and really doubt the difference is significant,
> 
> Never been able to measure it myself.
> 
> HwoeverI'd much prefer the tracepoint output stays accurate - I've had to
> post-process and/or graph the shrinker progress as reported by the
> start/end tracpoints to find problems in the algorithms in the past.
> That's why there is the additional complexity in the code to make
> sure the coutners are accurate in the first place.

Sure, no problems.

Andrew, can you, please, drop this patch?

Thanks!
