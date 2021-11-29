Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BAF4613FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhK2Lk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:40:59 -0500
Received: from outbound-smtp45.blacknight.com ([46.22.136.57]:48627 "EHLO
        outbound-smtp45.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233650AbhK2Li7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:38:59 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id D6E32FACFF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 11:35:40 +0000 (GMT)
Received: (qmail 19674 invoked from network); 29 Nov 2021 11:35:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Nov 2021 11:35:40 -0000
Date:   Mon, 29 Nov 2021 11:35:38 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        guobing.chen@intel.com, ming.a.chen@intel.com, frank.du@intel.com,
        Shuhua.Fan@intel.com, wangyang.guo@intel.com,
        Wenhuan.Huang@intel.com, jessica.ji@intel.com, shan.kang@intel.com,
        guangli.li@intel.com, tiejun.li@intel.com, yu.ma@intel.com,
        dapeng1.mi@intel.com, jiebin.sun@intel.com, gengxin.xie@intel.com,
        fan.zhao@intel.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        yu.c.chen@intel.com
Subject: Re: [sched/fair]  b4d95a034c:
 phoronix-test-suite.tiobench.RandomWrite.64MB.8.mb_s -26.3% regression
Message-ID: <20211129113538.GN3366@techsingularity.net>
References: <20211125151941.8710-3-mgorman@techsingularity.net>
 <20211128150658.GC5295@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211128150658.GC5295@xsang-OptiPlex-9020>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 11:06:58PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -26.3% regression of phoronix-test-suite.tiobench.RandomWrite.64MB.8.mb_s due to commit:
> 
> 
> commit: b4d95a034cffb1e4424874645549d3cac2de5c02 ("[PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCs")
> url: https://github.com/0day-ci/linux/commits/Mel-Gorman/Adjust-NUMA-imbalance-for-multiple-LLCs/20211125-232336
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 8c92606ab81086db00cbb73347d124b4eb169b7e
> 
> in testcase: phoronix-test-suite
> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 128G memory
> with following parameters:
> 
> 	test: tiobench-1.3.1
> 	option_a: Random Write
> 	option_b: 64MB
> 	option_c: 8
> 	cpufreq_governor: performance
> 	ucode: 0x5003006
> 
> test-description: The Phoronix Test Suite is the most comprehensive testing and benchmarking platform available that provides an extensible framework for which new tests can be easily added.
> test-url: http://www.phoronix-test-suite.com/
> 

Ok, while I'm surprised there is a difference with tiobench, there
definitely is a problem with the patch and a v3 is needed. Am queueing
up a test of v3 but the diff is

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9adeaa89ccb4..fee2930745ab 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2244,25 +2244,21 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 
 	/* Calculate allowed NUMA imbalance */
 	for_each_cpu(i, cpu_map) {
+		int imb_numa_nr = 0;
+
 		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
 			struct sched_domain *child = sd->child;
 
-			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) &&
+			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
 			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
-				struct sched_domain *sd_numa = sd;
-				int imb_numa_nr, nr_groups;
+				int nr_groups;
 
 				nr_groups = sd->span_weight / child->span_weight;
-				imb_numa_nr = nr_groups / num_online_nodes();
-
-				while (sd_numa) {
-					if (sd_numa->flags & SD_NUMA) {
-						sd_numa->imb_numa_nr = imb_numa_nr;
-						break;
-					}
-					sd_numa = sd_numa->parent;
-				}
+				imb_numa_nr = max(1U, ((child->span_weight) >> 1) /
+						(nr_groups * num_online_nodes()));
 			}
+
+			sd->imb_numa_nr = imb_numa_nr;
 		}
 	}
 
