Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303545AAC56
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiIBKZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiIBKZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:25:41 -0400
Received: from outbound-smtp26.blacknight.com (outbound-smtp26.blacknight.com [81.17.249.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B094B4B0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 03:25:38 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 5071ACAE9E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:25:37 +0100 (IST)
Received: (qmail 22239 invoked from network); 2 Sep 2022 10:25:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Sep 2022 10:25:37 -0000
Date:   Fri, 2 Sep 2022 11:25:28 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Message-ID: <20220902102528.keooutttg3hq3sy5@techsingularity.net>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
 <20220829130831.odhemmcmuecqxkbz@techsingularity.net>
 <51009414-5ffb-b6ec-a501-7b2514a0f3cc@bytedance.com>
 <20220829145621.7cxrywgxow5ov7ki@techsingularity.net>
 <0ffb0903-431f-88fe-3a56-150b283f5304@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <0ffb0903-431f-88fe-3a56-150b283f5304@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 12:12:31PM +0800, Abel Wu wrote:
> On 8/29/22 10:56 PM, Mel Gorman Wrote:
> > On Mon, Aug 29, 2022 at 10:11:39PM +0800, Abel Wu wrote:
> > > Hi Mel, thanks for reviewing!
> > > 
> > 
> > No problem, sorry it took so long.
> > 
> > > > So, first suggestion is to move this patch to the end of the series as
> > > > the other patches are relatively harmless. They could even be merged in
> > > > isolation as a cleanup.
> > > > 
> > > > Second, using the other patches as your baseline, include in the
> > > > changelog what you tested that showed a benefit, what type of machine
> > > > it was and in particular include the number of cores, nodes and the
> > > > span of the LLC.  If you measured any regressions, include that as well
> > > > and make a call on whether you think the patch wins more than it loses.
> > > > The reason to include that information is because the worst corner case
> > > > (all CPUs scanned uselessly) costs more the larger the span of LLC is.
> > > > If all the testing was done on a 2-core SMT-2 machine, the overhead of the
> > > > patch would be negligible but very different if the LLC span is 20 cores.
> > > > While the patch is not obviously wrong, it definitely needs better data,
> > > > Even if you do not have a large test machine available, it's still helpful
> > > > to have it in the changelog because a reviewer like me can decide "this
> > > > needs testing on a larger machine".
> > > 
> > > Thanks for your detailed suggestions. I will attach benchmark results
> > > along with some analysis next time when posting performance related
> > > patches.
> > > 
> > 
> > Thanks, include this in the changelog. While I had different figures for
> > hackbench, the figures are still fine. I had similar figures for netperf
> > (~3-4% regression on some machines but not universal). The tbench figures
> > are interesting because for you, it was mostly neutral but I did test
> > it with a CascadeLake machine and had worse results and that machine is
> > smaller in terms of core counts than yours.
> > 
> > > > 
> > > > I did queue this up the entire series for testing and while it sometimes
> > > > benefitted, there were large counter-examples. tbench4 on Zen3 showed some
> > > > large regressions (e.g. 41% loss on 64 clients with a massive increase in
> > > > variability) which has multiple small L3 caches per node. tbench4 (slightly
> > > > modified in mmtests to produce a usable metric) in general showed issues
> > > > across multiple x86-64 machines both AMD and Intel, multiple generations
> > > > with a noticable increase in system CPU usage when the client counts reach
> > > > the stage where the machine is close to saturated. perfpipe for some
> > > > weird reason showed a large regression apparent regresion on Broadwell
> > > > but the variability was also crazy so probably can be ignored. hackbench
> > > > overall looked ok so it's possible I'm wrong about the idle_cores hint
> > > > being often wrong on that workload and I should double check that. It's
> > > > possible the hint is wrong some of the times but right often enough to
> > > > either benefit from using an idle core or by finding an idle sibling which
> > > > may be preferable to stacking tasks on the same CPU.
> > > 
> > > I attached my test result in one of my replies[1]: netperf showed ~3.5%
> > > regression, hackbench improved a lot, and tbench4 drew. I tested several
> > > times and the results didn't seem vary much.
> > > 
> > > > 
> > > > The lack of data and the lack of a note on the potential downside is the
> > > > main reason why I'm not acking patch. tbench4 was a particular concern on
> > > > my own tests and it's possible a better patch would be a hybrid approach
> > > > where a limited search of two cores (excluding target) is allowed even if
> > > > SIS_UTIL indicates overload but has_idle_cores is true.
> > > > 
> > > 
> > > Agreed. And the reason I will exclude this part in v2 is that I plan to
> > > make it part of another feature, SIS filter [2]. The latest version of
> > > SIS filter (not posted yet but soon) will contain all the idle cpus so
> > > we don't need a full scan when has_idle_core. Scanning the filter then
> > > is enough. While it may still cost too much if too many false positive
> > > bits in the filter. Does this direction make sense to you?
> > > 
> > > [1] https://lore.kernel.org/lkml/eaa543fa-421d-2194-be94-6a5e24a33b37@bytedance.com/
> > > [2]
> > > https://lore.kernel.org/lkml/20220619120451.95251-1-wuyun.abel@bytedance.com/
> > > 
> > 
> > The filter idea is tricky, it will always struggle with "accurate
> > information" vs "cost of cpumask update" and what you link indicates that
> > it's updated on the tick boundary. That will be relatively cheap but could
> > mean that searches near the point of saturation or overload will have
> > false positives and negatives which you are already aware of given the
> > older series. It does not kill the idea but I would strongly suggest that
> > you do the simple thing first. That would yield potentially 3-4 patches
> > at the end of the series
> > 
> > 1. Full scan for cores (this patch effectively)
> > 2. Limited scan of 2 cores when SIS_UTIL cuts off but has_idle_cores is true
> >     (Compare 1 vs 2 in the changelog, not expected to be a universal win but
> >      should have better "worst case" behaviour to be worth merging)
> 
> I am afraid I had a hard time on this part, and it would be nice if you
> can shed some light on this..
> 
> Currently the mainline behavior when has_idle_core:
> 
> 	nr_idle_scan	0	1	2	...
> 	nr		0	max	max	...
> 
> while this patch makes:
> 
> 	nr_idle_scan	0	1	2	...
> 	nr		max	max	max	...
> 
> and if limit scan:
> 
> 	nr_idle_scan	0	1	2	...
> 	nr		2	2	max	...
> 
> anyway, the scan depth for has_idle_core case is not well aligned to
> the load. And honestly I'm not sure whether the depth should align to
> the load or not, since lower depth can easily put sds->has_idle_core
> in vain. Thoughts?
> 

For the simple case, I was expecting the static depth to *not* match load
because it's unclear what the scaling should be for load or if it had a
benefit. If investigating scaling the scan depth to load, it would still
make sense to compare it to a static depth. The depth of 2 cores was to
partially match the old SIS_PROP behaviour of the minimum depth to scan.

                if (span_avg > 4*avg_cost)
                        nr = div_u64(span_avg, avg_cost);
                else
                        nr = 4;

nr is not proportional to cores although it could be
https://lore.kernel.org/all/20210726102247.21437-7-mgorman@techsingularity.net/

This is not tested or properly checked for correctness but for
illustrative purposes something like this should conduct a limited scan when
overloaded. It has a side-effect that the has_idle_cores hint gets cleared
for a partial scan for idle cores but the hint is probably wrong anyway.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6089251a4720..59b27a2ef465 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6427,21 +6427,36 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		if (sd_share) {
 			/* because !--nr is the condition to stop scan */
 			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
-			/* overloaded LLC is unlikely to have idle cpu/core */
-			if (nr == 1)
-				return -1;
+
+			/*
+			 * Non-overloaded case: Scan full domain if there is
+			 * 	an idle core. Otherwise, scan for an idle
+			 * 	CPU based on nr_idle_scan
+			 * Overloaded case: Unlikely to have an idle CPU but
+			 * 	conduct a limited scan if there is potentially
+			 * 	an idle core.
+			 */
+			if (nr > 1) {
+				if (has_idle_core)
+					nr = sd->span_weight;
+			} else {
+				if (!has_idle_core)
+					return -1;
+				nr = 2;
+			}
 		}
 	}
 
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
+		if (!--nr)
+			break;
+
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 
 		} else {
-			if (!--nr)
-				return -1;
 			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
 				break;
