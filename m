Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A280544008
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbiFHXmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiFHXl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:41:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ECE1AF6CD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654731668; x=1686267668;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NST3C1XCoMC8qEgikymvqUPMZUKij4aUwSL5iFhJRgo=;
  b=OpVSoxy046VDb/7tQRrwS93WQA87q3MB9me2TB+kvPRmrx0zKqCdZZJK
   Il8OhlkNfX5xEeIL97mUF09bxskOKOz6NjhgdMBG927cV1p3/QEEPy+fn
   ZsWRp8LtQciF0UH6CvRKRgKh9qdOOGwzi0Jiip/r9/OOGzusq/tn7/sXt
   5vFcokm8vvh4uQkXg3+v+qlxbHH1AbdsCTTpTZFx6f2uUtLQvlIZDGqf1
   I37eJn/4ht3J3vVdU8B9SPQHD+ZGXFwzF28aMlGKIDUYqTGMaGP75gHN1
   1NJPYRFMY2eKgwg9eemw40wmka/JLYe3PXfGMDeKxqkiPAGDtBWx+oBwO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="265879285"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="265879285"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 16:40:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="566134480"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.124.119])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 16:40:53 -0700
Message-ID: <aabc9a7645ce50f706ac117e6e8fc0f15a967c6c.camel@linux.intel.com>
Subject: Re: [PATCH] mm: mempolicy: N:M interleave policy for tiered memory
 nodes
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Hao Wang <haowang3@fb.com>,
        Abhishek Dhanotia <abhishekd@fb.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Hasan Al Maruf <hasanalmaruf@fb.com>
Date:   Wed, 08 Jun 2022 16:40:53 -0700
In-Reply-To: <YqD0/tzFwXvJ1gK6@cmpxchg.org>
References: <20220607171949.85796-1-hannes@cmpxchg.org>
         <6096c96086187e51706898e58610fc0148b4ca23.camel@linux.intel.com>
         <YqD0/tzFwXvJ1gK6@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 15:14 -0400, Johannes Weiner wrote:
> Hi Tim,
> 
> On Wed, Jun 08, 2022 at 11:15:27AM -0700, Tim Chen wrote:
> > On Tue, 2022-06-07 at 13:19 -0400, Johannes Weiner wrote:
> > >  /* Do dynamic interleaving for a process */
> > >  static unsigned interleave_nodes(struct mempolicy *policy)
> > >  {
> > >  	unsigned next;
> > >  	struct task_struct *me = current;
> > >  
> > > -	next = next_node_in(me->il_prev, policy->nodes);
> > > +	if (numa_tier_interleave[0] > 1 || numa_tier_interleave[1] > 1) {
> > 
> > When we have three memory tiers, do we expect an N:M:K policy?
> > Like interleaving between DDR5, DDR4 and PMEM memory.
> > Or we expect an N:M policy still by interleaving between two specific tiers?
> 
> In the context of the proposed 'explicit tiers' interface, I think it
> would make sense to have a per-tier 'interleave_ratio knob. Because
> the ratio is configured based on hardware properties, it can be
> configured meaningfully for the entire tier hierarchy, even if
> individual tasks or vmas interleave over only a subset of nodes.

I think that makes sense.  So if have 3 tiers of memory whose bandwidth ratio are
4:2:1, then it makes sense to interleave according to this ratio, even if we choose
to interleave for a subset of nodes.  Say between tier 1 and tier 3, the
interleave ratio will be 4:1 as I can read 4 lines of data from tier 3 while
I got 1 line of data from tier 3.

> 
> > The other question is whether we will need multiple interleave policies depending
> > on cgroup?
> > One policy could be interleave between tier1, tier2, tier3.
> > Another could be interleave between tier1 and tier2.
> 
> This is a good question.
> 
> One thing that has defined cgroup development in recent years is the
> concept of "work conservation". Moving away from fixed limits and hard
> partitioning, cgroups are increasingly configured with weights,
> priorities, and guarantees (cpu.weight, io.latency/io.cost.qos,
> memory.low). These weights and priorities are enforced when cgroups
> are directly competing over a resource; but if there is no contention,
> any active cgroup, regardless of priority, has full access to the
> surplus (which could be the entire host if the main load is idle).
> 
> With that background, yes, we likely want some way of prioritizing
> tier access when multiple cgroups are competing. But we ALSO want the
> ability to say that if resources are NOT contended, a cgroup should
> interleave memory over all tiers according to optimal bandwidth.
> 
> That means that regardless of how the competitive cgroup rules for
> tier access end up looking like, it makes sense to have global
> interleaving weights based on hardware properties as proposed here.
> 
> The effective cgroup IL ratio for each tier could then be something
> like cgroup.tier_weight[tier] * tier/interleave_weight.

Thanks. I agree that a interleave ratio that's proportional to hardware
properties of each tier will suffice.

Tim

