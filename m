Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3CF507985
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350736AbiDSTAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349562AbiDSTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:00:52 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4CF3EF08
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:58:07 -0700 (PDT)
Date:   Tue, 19 Apr 2022 11:58:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650394686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aHP1fr3pFCglhUt6wslEJqCTPQEvCI12BCqK6uc3qpE=;
        b=gnhLIOha4Zr8ErfXIK162pTJfscSXT9fDJM6MJH7Df5HlbvUDZ2PwsBxD8idBgSHTR6Yi+
        PuheUtLEu2Xge91pGBxcIz4PW4NnBj8sDVUFnKGYlJ0Sml0iP33rIdgScf0G5KNVQICfuD
        ckx16d5O1MfYiOOoQPTCVk5QCrZD5dg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-ID: <Yl8GOJd/iUHkTEL3@carbon>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
 <20220419182030.idqqmtim4slhbked@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419182030.idqqmtim4slhbked@moria.home.lan>
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

On Tue, Apr 19, 2022 at 02:20:30PM -0400, Kent Overstreet wrote:
> On Fri, Apr 15, 2022 at 05:27:51PM -0700, Roman Gushchin wrote:
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
> > For each shrinker registered in the system a folder is created. The folder
> > contains "count" and "scan" files, which allow to trigger count_objects()
> > and scan_objects() callbacks. For memcg-aware and numa-aware shrinkers
> > count_memcg, scan_memcg, count_node, scan_node, count_memcg_node
> > and scan_memcg_node are additionally provided. They allow to get per-memcg
> > and/or per-node object count and shrink only a specific memcg/node.
> 
> Cool!
> 
> I've been starting to sketch out some shrinker improvements of my own, perhaps
> we could combine efforts.

Thanks! Absolutely!

> The issue I've been targeting is that when we hit an
> OOM, we currently don't get a lot of useful information - shrinkers ought to be
> included, and we really want information on shrinker's internal state (e.g.
> object dirtyness) if we're to have a chance at understanding why memory isn't
> getting reclaimed.
> 
> https://evilpiepirate.org/git/bcachefs.git/log/?h=shrinker_to_text
> 
> This adds a .to_text() method - a pretty-printer - that shrinkers can
> implement, and then on OOM we report on the top 10 shrinkers by memory usage, in
> sorted order.

We must be really careful with describing what's allowed and not allowed
by these callbacks. In-kernel OOM is the last-resort mechanism and it should
be able to make forward progress in really nasty circumstances. So there are
significant (and not very well described) limitations on what can be done
from the oom context.

> 
> Another thing I'd like to do is have shrinkers report usage not just in object
> counts but in bytes; I think it should be obvious why that's desirable.

I totally agree, it's actually on my short-term todo list.

> 
> Maybe we could have a memory-reporting-and-shrinker-improvements session at LSF?
> I'd love to do some collective brainstorming and get some real momementum going
> in this area.

Would be really nice! I'm planning to work on improving shrinkers and gather ideas
and problems, so having a discussion would be really great.

Thanks!
