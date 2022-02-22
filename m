Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CE24BF3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiBVIqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiBVIqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:46:04 -0500
Received: from outbound-smtp26.blacknight.com (outbound-smtp26.blacknight.com [81.17.249.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35A71592A9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:45:38 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 64983CAB68
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:45:37 +0000 (GMT)
Received: (qmail 30157 invoked from network); 22 Feb 2022 08:45:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Feb 2022 08:45:37 -0000
Date:   Tue, 22 Feb 2022 08:45:35 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v4] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Message-ID: <20220222084535.GB4423@techsingularity.net>
References: <20220217055408.28151-1-kprateek.nayak@amd.com>
 <20220217100523.GV3366@techsingularity.net>
 <a57dbac2-1b8e-ea5c-8b6c-3a97ac186ad9@amd.com>
 <20220217131512.GW3366@techsingularity.net>
 <fed30e08-e6a3-4c20-175e-50b3af02af3e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <fed30e08-e6a3-4c20-175e-50b3af02af3e@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 11:30:48AM +0530, K Prateek Nayak wrote:
> Hello Mel,
> 
> On 2/17/2022 6:45 PM, Mel Gorman wrote:
> > I don't object to the change but I would wonder if it's measurable for
> > anything other than a fork-intensive microbenchmark given it's one branch
> > in a relatively heavy operation.
> 
> I used stress-ng to see if we get any measurable difference from the
> optimizations in a fork intensive scenario. I'm measuring time in ns
> between the events sched_process_fork and sched_wakeup_new for the
> stress-ng processes.
> 
> Following are the results from testing:
> 
> - Un-affined runs:
>   Command: stress-ng -t 30s --exec <Worker>
> 
>   Kernel versions:
>   - balance-wake - This patch
>   - branch - This patch + Mel's suggested branch
>   - branch-unlikely - This patch + Mel's suggested branch + unlikely
> 
>   Result format: Amean in ns [Co-eff of Var] (% Improvement)
> 
>   Workers balance-wake            	  branch          		  branch-unlikely
>   1       18613.20 [0.01] (0.00 pct)      18348.00 [0.04] (1.42 pct)      18299.20 [0.02] (1.69 pct)
>   2       18634.40 [0.03] (0.00 pct)      18163.80 [0.04] (2.53 pct)      19037.80 [0.05] (-2.16 pct)
>   4       20997.40 [0.02] (0.00 pct)      20980.80 [0.02] (0.08 pct)      21527.40 [0.02] (-2.52 pct)
>   8       20890.20 [0.01] (0.00 pct)      19714.60 [0.07] (5.63 pct)      20021.40 [0.05] (4.16 pct)
>   16      21200.20 [0.02] (0.00 pct)      20564.40 [0.00] (3.00 pct)      20676.00 [0.01] (2.47 pct)
>   32      21301.80 [0.02] (0.00 pct)      20767.40 [0.02] (2.51 pct)      20945.00 [0.01] (1.67 pct)
>   64      22772.40 [0.01] (0.00 pct)      22505.00 [0.01] (1.17 pct)      22629.40 [0.00] (0.63 pct)
>   128     25843.00 [0.01] (0.00 pct)      25124.80 [0.00] (2.78 pct)      25377.40 [0.00] (1.80 pct)
>   256     18691.00 [0.02] (0.00 pct)      19086.40 [0.05] (-2.12 pct)     18013.00 [0.04] (3.63 pct)
>   512     19658.40 [0.03] (0.00 pct)      19568.80 [0.01] (0.46 pct)      18972.00 [0.02] (3.49 pct)
>   1024    19126.80 [0.04] (0.00 pct)      18762.80 [0.02] (1.90 pct)      18878.20 [0.04] (1.30 pct)
> 

Co-eff of variance looks low but for the lower counts before the machine
is saturated (>=256?) it does not look like it helps and if anything,
it hurts.  A branch mispredict profile might reveal more but I doubt
it's worth the effort at this point.

> - Affined runs:
>   Command: taskset -c 0-254 stress-ng -t 30s --exec <Worker>
> 
>   Kernel versions:
>   - balance-wake-affine - This patch + affined run
>   - branch-affine - This patch + Mel's suggested branch + affined run
>   - branch-unlikely-affine - This patch + Mel's suggested branch + unlikely + affined run
> 
>   Result format: Amean in ns [Co-eff of Var] (% Improvement)
> 
>   Workers balance-wake-affine             branch-affine           	  branch-unlikely-affine
>   1       18515.00 [0.01] (0.00 pct)      18538.00 [0.02] (-0.12 pct)     18568.40 [0.01] (-0.29 pct)
>   2       17882.80 [0.01] (0.00 pct)      19627.80 [0.09] (-9.76 pct)     18790.40 [0.01] (-5.08 pct)
>   4       21204.20 [0.01] (0.00 pct)      21410.60 [0.04] (-0.97 pct)     21715.20 [0.03] (-2.41 pct)
>   8       20840.20 [0.01] (0.00 pct)      19684.60 [0.07] (5.55 pct)      21074.20 [0.02] (-1.12 pct)
>   16      21115.20 [0.02] (0.00 pct)      20823.00 [0.01] (1.38 pct)      20719.80 [0.00] (1.87 pct)
>   32      21159.00 [0.02] (0.00 pct)      21371.20 [0.01] (-1.00 pct)     21253.20 [0.01] (-0.45 pct)
>   64      22768.20 [0.01] (0.00 pct)      22816.80 [0.00] (-0.21 pct)     22662.00 [0.00] (0.47 pct)
>   128     25671.80 [0.00] (0.00 pct)      25528.20 [0.00] (0.56 pct)      25404.00 [0.00] (1.04 pct)
>   256     27209.00 [0.01] (0.00 pct)      26751.00 [0.01] (1.68 pct)      26733.20 [0.00] (1.75 pct)
>   512     20241.00 [0.03] (0.00 pct)      19378.60 [0.03] (4.26 pct)      19671.40 [0.00] (2.81 pct)
>   1024    19380.80 [0.05] (0.00 pct)      18940.40 [0.02] (2.27 pct)      19071.80 [0.00] (1.59 pct)

Same here, the cpumask check obviously hurts but it does not look like
the unlikely helps.

> With or without the unlikely, adding the check before doing the
> cpumask operation benefits most cases of un-affined tasks.
> 

I think repost the patch with the num_online_cpus check added in. Yes,
it hurts a bit for the pure fork case when the cpus_ptr is contrained by
a scheduler policy but at least it makes sense.

-- 
Mel Gorman
SUSE Labs
