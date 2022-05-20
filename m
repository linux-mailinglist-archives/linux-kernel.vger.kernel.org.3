Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EC952E9C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348082AbiETKSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238821AbiETKSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:18:18 -0400
Received: from outbound-smtp46.blacknight.com (outbound-smtp46.blacknight.com [46.22.136.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91D8EAD1D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:18:16 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 3D0ECFA964
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:18:15 +0100 (IST)
Received: (qmail 13443 invoked from network); 20 May 2022 10:18:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 May 2022 10:18:15 -0000
Date:   Fri, 20 May 2022 11:18:12 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Mitigate inconsistent NUMA imbalance behaviour
Message-ID: <20220520101812.GW3441@techsingularity.net>
References: <20220511143038.4620-1-mgorman@techsingularity.net>
 <f6b2eba0-2c28-b41b-3900-8834abbd6575@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <f6b2eba0-2c28-b41b-3900-8834abbd6575@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 10:28:02AM +0530, K Prateek Nayak wrote:
> Hello Mel,
> 
> We tested the patch series on a our systems.
> 
> tl;dr
> 
> Results of testing:
> - Benefits short running Stream tasks in NPS2 and NPS4 mode.
> - Benefits seen for tbench in NPS1 mode for 8-128 worker count.
> - Regression in Hackbench with 16 groups in NPS1 mode. A rerun for
>   same data point suggested run to run variation on patched kernel.
> - Regression in case of tbench with 32 and 64 workers in NPS2 mode.
>   Patched kernel however seems to report more stable value for 64
>   worker count compared to tip.
> - Slight regression in schbench in NPS2 and NPS4 mode for large
>   worker count but we did spot some run to run variation with
>   both tip and patched kernel.
> 
> Below are all the detailed numbers for the benchmarks.
> 

Thanks!

I looked through the results but I do not see anything that is very
alarming. Some notes.

o Hackbench with 16 groups on NPS1, that would likely be 640 tasks
  communicating unless other paramters are used. I expect it to be
  variable and it's a heavily overloaded scenario. Initial placement is
  not necessarily critical as migrations are likely to be very high.
  On NPS1, there is going to be random luck given that the latency
  to individual CPUs and the physical topology is hidden.

o NPS2 with 128 workers. That's at the threshold where load is
  potentially evenly split between the two sockets but not perfectly
  split due to migrate-on-wakeup being a little unpredictable. Might
  be worth checking the variability there.

o Same observations for tbench. I looked at my own results for NPS1
  on Zen3 and what I see is that there is a small blip there but
  the mpstat heat map indicates that the nodes are being more evenly
  used than without the patch which is expected.

o STREAM is interesting in that there are large differences between
  10 runs and 100 hundred runs. In indicates that without pinning that
  STREAM can be a bit variable. The problem might be similar to NAS
  as reported in the leader mail with the variability due to commit
  c6f886546cb8 for unknown reasons.

> > 
> >  kernel/sched/fair.c     | 59 ++++++++++++++++++++++++++---------------
> >  kernel/sched/topology.c | 23 ++++++++++------
> >  2 files changed, 53 insertions(+), 29 deletions(-)
> > 
> 
> Please let me know if you would like me to get some additional
> data on the test system.

Other than checking variability, the min, max and range, I don't need
additional data. I suspect in some cases like what I observed with NAS
that there is wide variability for reasons independent of this series.

I'm of the opinion though that your results are not a barrier for
merging. Do you agree?

-- 
Mel Gorman
SUSE Labs
