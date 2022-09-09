Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBDA5B2E54
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiIIFxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIIFxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:53:30 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363BCB7761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 22:53:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p18so816042plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 22:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=X2G3bBiuotGk1LyN1WvcUhVX6iwwDcHgvCQOf1/CeC8=;
        b=fgJWQ4pyh3nAipeR7TYkE2GeaNvGW5sYchO7kG5lPtEooUDK0ut8Xr37c7D5f0mZjc
         Zk7zhUtNkU5JBDpfZjs8NbkLXqr0WU85fRagvSUFZwBciO18qCKMCVgHKNuB7aMoWPBC
         KyTpaRSSV+POLLlbF/IP0H5Qqm9Pgt39trnpT88IXtgTwsSl5sJYWjJMHYbRq+34CdH5
         C92v0R8yHzRHrHOZhKiwZQO5ftluv7R6vrPOgcu74qDWJ/Hu58gngd1vGWrsH4PfL3TB
         gwDzOAo4eRkZGmOw9wd2Q6HuuuqNNcSLmDi/N7t8VCsaJtTDDGLt0Est3yBb5AsoP63k
         9kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X2G3bBiuotGk1LyN1WvcUhVX6iwwDcHgvCQOf1/CeC8=;
        b=lPxJ1jirEgizA3N7Ok3rwE6Smr0Tnn3pVz8DC4eHdgRwP3DAHZhoscvU12bNnF+M+E
         8vXYsaylhIpRj69ITASTfjWi231CsUkJBJfe0Jy20SmFqCA2cVo2m41MnC60l79hElIa
         l08S/kXe5WVoYD24UZWAxMhPXSCTl7ZWLJ4CUZp384w2YVqbIhZJqvzEWwgmaT8oNtbU
         t7/FeDmHVImV6m9X3UMvxoA8gTTZL54IKunAEcLgSY2yZgLMLYK1oKAe+1eKBhcAOx2Q
         4JyhKhNiaeN1kUgYFFWfu0ExkuzPV4JMQ28suXizlrXI5mDPL/iam+yCa1LDGAakpFv7
         vJFQ==
X-Gm-Message-State: ACgBeo1b1QqLrs9raj89gIRxThTd1MtybGw8cd6ZzmOKGeD8LcUBk8wj
        Dzk1tpjMYDNB3XByUu2zI91Wsw==
X-Google-Smtp-Source: AA6agR7wJhLbzxk6NhbWDIt1z/xErAkfcxSd1KIR2r9mTtSprlCYtPcv+Kc4scuwrmX0cW6dz16XBw==
X-Received: by 2002:a17:90b:1c8e:b0:1f7:5250:7b44 with SMTP id oo14-20020a17090b1c8e00b001f752507b44mr8038068pjb.212.1662702806974;
        Thu, 08 Sep 2022 22:53:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id y66-20020a636445000000b00421841943dfsm464380pgb.12.2022.09.08.22.53.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2022 22:53:26 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v5 2/5] sched/fair: Limited scan for idle cores when overloaded
Date:   Fri,  9 Sep 2022 13:53:01 +0800
Message-Id: <20220909055304.25171-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909055304.25171-1-wuyun.abel@bytedance.com>
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The has_idle_cores hint could be misleading due to some kind of
rapid idling workloads, especially when LLC is overloaded. If this
is the case, then there will be some full scan cost incurred that
often fails to find a core.

So limit the scan depth for idle cores in such case to make a
speculative inspection at a reasonable cost.

Benchmark
=========

Tests are done in a dual socket (2 x 24C/48T) machine modeled Intel
Xeon(R) Platinum 8260, with SNC configuration:

	SNC on:  4 NUMA nodes each of which has 12C/24T
	SNC off: 2 NUMA nodes each of which has 24C/48T

All of the benchmarks are done inside a normal cpu cgroup in a clean
environment with cpu turbo disabled.

Based on tip sched/core 0fba527e959d (v5.19.0) plus previous patches
of this series.

Results
=======

hackbench-process-pipes
                         unpatched		  patched
(SNC on)
Amean     1        0.4470 (   0.00%)      0.4557 (  -1.94%)
Amean     4        0.5947 (   0.00%)      0.6033 (  -1.46%)
Amean     7        0.7450 (   0.00%)      0.7627 (  -2.37%)
Amean     12       1.1053 (   0.00%)      1.0653 (   3.62%)
Amean     21       1.9420 (   0.00%)      2.0283 *  -4.45%*
Amean     30       2.9267 (   0.00%)      2.9670 (  -1.38%)
Amean     48       4.7027 (   0.00%)      4.6863 (   0.35%)
Amean     79       7.7097 (   0.00%)      7.9443 *  -3.04%*
Amean     110     10.0680 (   0.00%)     10.2393 (  -1.70%)
Amean     141     12.5450 (   0.00%)     12.6343 (  -0.71%)
Amean     172     15.0297 (   0.00%)     14.9957 (   0.23%)
Amean     203     16.8827 (   0.00%)     16.9133 (  -0.18%)
Amean     234     19.1183 (   0.00%)     19.2433 (  -0.65%)
Amean     265     20.9893 (   0.00%)     21.6917 (  -3.35%)
Amean     296     23.3920 (   0.00%)     23.8743 (  -2.06%)
(SNC off)
Amean     1        0.2717 (   0.00%)      0.3143 ( -15.71%)
Amean     4        0.6257 (   0.00%)      0.6070 (   2.98%)
Amean     7        0.7740 (   0.00%)      0.7960 (  -2.84%)
Amean     12       1.2410 (   0.00%)      1.1947 (   3.73%)
Amean     21       2.6410 (   0.00%)      2.4837 (   5.96%)
Amean     30       3.7620 (   0.00%)      3.4577 (   8.09%)
Amean     48       6.7757 (   0.00%)      5.5227 *  18.49%*
Amean     79       8.8827 (   0.00%)      9.2933 (  -4.62%)
Amean     110     11.0583 (   0.00%)     11.0443 (   0.13%)
Amean     141     13.3387 (   0.00%)     13.1360 (   1.52%)
Amean     172     15.9583 (   0.00%)     15.7770 (   1.14%)
Amean     203     17.8757 (   0.00%)     17.9557 (  -0.45%)
Amean     234     20.0543 (   0.00%)     20.4373 *  -1.91%*
Amean     265     22.6643 (   0.00%)     23.6053 *  -4.15%*
Amean     296     25.6677 (   0.00%)     25.6803 (  -0.05%)

Run to run variations is large in the 1 group test, so can be safely
ignored.

With limited scan for idle cores when the LLC is overloaded, a slight
regression can be seen on the smaller LLC machine. It is because the
cost of full scan on these LLCs is much smaller than the machines with
bigger LLCs. So when comes to the SNC off case, the limited scan can
provide obvious benefit especially when the frequency of such scan is
relatively high, e.g. <48 groups.

It's not a universal win, but considering the LLCs are getting bigger
nowadays, we should be careful on the scan depth and limited scan on
certain circumstance is indeed necessary.

tbench4 Throughput
                         unpatched		  patched
(SNC on)
Hmean     1        309.43 (   0.00%)      301.54 *  -2.55%*
Hmean     2        613.92 (   0.00%)      607.81 *  -0.99%*
Hmean     4       1227.84 (   0.00%)     1210.64 *  -1.40%*
Hmean     8       2379.04 (   0.00%)     2381.73 *   0.11%*
Hmean     16      4634.66 (   0.00%)     4601.21 *  -0.72%*
Hmean     32      7592.12 (   0.00%)     7626.84 *   0.46%*
Hmean     64      9241.11 (   0.00%)     9251.51 *   0.11%*
Hmean     128    17870.37 (   0.00%)    20620.98 *  15.39%*
Hmean     256    19370.92 (   0.00%)    20406.51 *   5.35%*
Hmean     384    19413.92 (   0.00%)    20312.97 *   4.63%*
(SNC off)
Hmean     1        287.90 (   0.00%)      292.37 *   1.55%*
Hmean     2        575.52 (   0.00%)      583.29 *   1.35%*
Hmean     4       1137.94 (   0.00%)     1155.83 *   1.57%*
Hmean     8       2250.42 (   0.00%)     2297.63 *   2.10%*
Hmean     16      4363.41 (   0.00%)     4562.44 *   4.56%*
Hmean     32      7338.06 (   0.00%)     7425.69 *   1.19%*
Hmean     64      8914.66 (   0.00%)     9021.77 *   1.20%*
Hmean     128    19978.59 (   0.00%)    20257.76 *   1.40%*
Hmean     256    20057.49 (   0.00%)    20043.54 *  -0.07%*
Hmean     384    19846.74 (   0.00%)    19528.03 *  -1.61%*

Conclusion
==========

Limited scan for idle cores when LLC is overloaded is almost neutral
compared to full scan given smaller LLCs, but is an obvious win at
the bigger ones which are future-oriented.

Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5af9bf246274..7abe188a1533 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6437,26 +6437,42 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		time = cpu_clock(this);
 	}
 
-	if (sched_feat(SIS_UTIL) && !has_idle_core) {
+	if (sched_feat(SIS_UTIL)) {
 		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
 		if (sd_share) {
 			/* because !--nr is the condition to stop scan */
 			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
-			/* overloaded LLC is unlikely to have idle cpu/core */
-			if (nr == 1)
+
+			/*
+			 * Overloaded LLC is unlikely to have idle cpus.
+			 * But if has_idle_core hint is true, a limited
+			 * speculative scan might help without incurring
+			 * much overhead.
+			 */
+			if (has_idle_core)
+				nr = nr > 1 ? INT_MAX : 3;
+			else if (nr == 1)
 				return -1;
 		}
 	}
 
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
+		/*
+		 * This might get the has_idle_cores hint cleared for a
+		 * partial scan for idle cores but the hint is probably
+		 * wrong anyway. What more important is that not clearing
+		 * the hint may result in excessive partial scan for idle
+		 * cores introducing innegligible overhead.
+		 */
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
-- 
2.37.3

