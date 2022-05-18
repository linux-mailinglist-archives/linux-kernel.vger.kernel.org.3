Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFBD52C037
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbiERRGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbiERRGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:06:31 -0400
Received: from outbound-smtp47.blacknight.com (outbound-smtp47.blacknight.com [46.22.136.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886DA3982A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:06:29 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id B42E2FA978
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 18:06:27 +0100 (IST)
Received: (qmail 17228 invoked from network); 18 May 2022 17:06:27 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 May 2022 17:06:27 -0000
Date:   Wed, 18 May 2022 18:06:25 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/numa: Adjust imb_numa_nr to a better
 approximation of memory channels
Message-ID: <20220518170625.GT3441@techsingularity.net>
References: <20220511143038.4620-1-mgorman@techsingularity.net>
 <20220511143038.4620-5-mgorman@techsingularity.net>
 <20220518094112.GE10117@worktop.programming.kicks-ass.net>
 <20220518111539.GP3441@techsingularity.net>
 <YoT9D0YGlWwHQMQi@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YoT9D0YGlWwHQMQi@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 04:05:03PM +0200, Peter Zijlstra wrote:
> On Wed, May 18, 2022 at 12:15:39PM +0100, Mel Gorman wrote:
> 
> > I'm not aware of how it can be done in-kernel on a cross architectural
> > basis. Reading through the arch manual, it states how many channels are
> > in a given processor family and it's available during memory check errors
> > (apparently via the EDAC driver). It's sometimes available via PMUs but
> > I couldn't find a place where it's generically available for topology.c
> > that would work on all x86-64 machines let alone every other architecture.
> 
> So provided it is something we want (below) we can always start an arch
> interface and fill it out where needed.
> 

It could start with a function with a fixed value that architectures
can override but it might be a deep rabbit hole to discover and wire
it all up.  The most straight-forward would be based on CPU family and
model but time consuming to maintain. It gets fuzzy if it's something
like PowerKVM where channel details are hidden. It could be a deep
rabbit hole.

> > It's not even clear if SMBIOS was parsed in early boot whether
> 
> We can always rebuild topology / update variables slightly later in
> boot.
> 
> > it's a
> > good idea. It could result in difference imbalance thresholds for each
> > NUMA domain or weird corner cases where assymetric NUMA node populations
> > would result in run-to-run variance that are difficult to analyse.
> 
> Yeah, maybe. OTOH having a magic value that's guestimated based on
> hardware of the day is something that'll go bad any moment as well.
> 
> I'm not too worried about run-to-run since people don't typically change
> DIMM population over a reboot, but yes, there's always going to be
> corner cases. Same with a fixed value though, that's also going to be
> wrong.
> 

By run-to-run, I mean just running the same workload in a loop and
not rebooting between runs. If there are differences in how nodes are
populated, there will be some run-to-run variance based purely on what
node the workload started on because they will have different "allowed
imbalance" thresholds.

I'm running the tests to recheck exactly how much impact this patch has
on the peak performance. It takes a few hours so I won't have anything
until tomorrow.

Initially "get peak performance" and "stabilise run-to-run variances"
were my objectives. This series only aimed at the peak performance for a
finish as allowed NUMA imbalance was not the sole cause of the problem.
I still haven't spent time figuring out why c6f886546cb8 ("sched/fair:
Trigger the update of blocked load on newly idle cpu") made such a big
difference to variability.

-- 
Mel Gorman
SUSE Labs
