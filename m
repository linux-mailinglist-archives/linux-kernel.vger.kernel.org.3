Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CE24F520F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiDFCen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447769AbiDEWXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:23:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFD9BABB9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7d4jHN3hEVC7czPTgRhPRNegosioytKGOnpN+jNlS3I=; b=A62E7PMTsau07ViNlj8KL+QG3d
        raIeADbj0mqUWjK39CpcCv3kTB3mlGZxV4RMhqen7LQ9O5+SmC9BLqJ3lzT7iJxXZN0LJhJyis/V+
        cSiIAAKBylGreUeWo50FEhGx/xQUXwU0TYercKUbCUI/9uZrH5/Jkf/UgdXQy/0z0Ec/l81NBI7eG
        eABiiRFdDmkrq3aoYO2c8lfiubAVqzVnnhM/FZ4r8tLE83MrO/6Ih5OEVcsUHmJbXhn31xaKeeK8i
        ceJUFE3StPeb3Vc+Nsz9RxW6UEOaY2LTzAs5Eu+u1BagGMbd+2dvAzSievhz69Ysb68dRzF+1M2/J
        cantghkg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbqYr-0073yK-Kv; Tue, 05 Apr 2022 21:18:01 +0000
Date:   Tue, 5 Apr 2022 22:18:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Hillf Danton <hdanton@sina.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
Message-ID: <YkyyCcdJq69tO6ba@casper.infradead.org>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
 <20220404010948.GV1609613@dread.disaster.area>
 <87ilrn5ttl.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilrn5ttl.fsf@stepbren-lnx.us.oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 10:22:14AM -0700, Stephen Brennan wrote:
> I can't speak for every slab cache, but I've been coming to the same
> conclusion myself regarding the dentry cache. I think that the rate of
> stepping through the LRU should be tied to the rate of allocations.
> Truly in-use objects shouldn't be harmed by this, as they should get
> referenced and rotated to the beginning of the LRU. But the one-offs
> which are bloating the cache will be found and removed.

I agree with all this.

> I've implemented a version of this patch which just takes one step
> through the LRU on each d_alloc. It's quite interesting to watch it
> work. You can create 5 million negative dentries in directory /A via
> stat(), and then create 5 million negative dentries in directory /B. The
> total dentry slab size reaches 5 million but never goes past it, since
> the old negative dentries from /A aren't really in use, and they get
> pruned at the same rate as negative dentries from /B get created. On the
> other hand, if you *continue* to stat() on the dentries of /A while you
> create negative dentries in /B, then the cache grows to 10 million,
> since the /A dentries are actually in use.
> 
> Maybe a solution could involve some generic list_lru machinery that can
> let you do these sorts of incremental scans? Maybe batching them up so
> instead of doing one every allocation, you do them every 100 or 1000?
> It would still be up to the individual user to put this to good use in
> the object allocation path.

I feel like we need to allow the list to both shrink and grow, depending
on how useful the entries in it are.  So one counter per LRU, incremented
on every add.  When that counter gets to 100, reset it to 0 and scan
110 entries.  Maybe 0 of them can be reclaimed; maybe 110 of them can be.
But the list can shrink over time instead of being a "one in, one out"
scenario.

Clearly 110 is a magic number, but intuitively, attempting to shrink
by 10% feels reasonable.  Need to strike a balance between shrinking
quickly enough and giving the cache time to figure out which entries
are actually useful.
