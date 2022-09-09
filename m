Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543575B2E50
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiIIFxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiIIFxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:53:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323B6B729A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 22:53:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u22so797663plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 22:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+r5nNsG65J6aS0cU2hfLJE0PMfgzERfyIajReZZQRVw=;
        b=FsyqRXp0eSc6UzCw20YxafbiS/uTNwEkSQQbJc01xpwNcDCPvumYUJxxWx0nO4m35y
         Yiafeq83k+1xsnmLctIzBTQIiERDACOADiX9i/dI7vprFfwSCGOacEWmmX74zqK7E/MZ
         uJyaOA5P79A+CPaKOuCYypUcT8qcHmiCXg8wr5R3lD90fQ27Mk4gWAuQmGNVAeujYJ39
         v0GHmMWoeq6IhTc3bI6ioTvi9emhwavi/tjWndwFMG9c6lPWLqlZVq/be4duUgdUdFjM
         SrG6c6UV8XQrn376waJHYaeO/04OJRm4ltxfraZDMf4CarduT0cC7vRXcgG6w/IhOrpt
         vc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+r5nNsG65J6aS0cU2hfLJE0PMfgzERfyIajReZZQRVw=;
        b=RFlUaCPJsE3gF9pTQ4vdpkuQwoqoxSRr1UrzL2APIpras+8rLDvHHXrgfanc1IeZsI
         ipdYD6+J5nmUum7yNulDbEb7xu5m4DHL2nFoorhXC/sew2aKf7gcM/xPejvUTB1tWp2s
         YJKT1JSFeCGyJp4oygcBTeDud/7meRddhYkrz6A8m+FkySpeAQpWb96XMxlyxdbIxUcs
         C/V5K8ovtjT+cYPmaoMQRGwNX8Is7893yH3o+PYJFux9rYAZdo9/ezR0DE+R6o8gtSMd
         ZxIaGb/RsTUSlq4FMIDDLlVWgcwhfMw85Nwtn5JNZQ6YU5nNuOwi/vHznjlIq9M4aBn6
         3WcQ==
X-Gm-Message-State: ACgBeo0zu4xA4f0WMeR+uQ/G3nfdmfvh9haSbU8T0D70zrUnkmFYW8rn
        5dnFwdqCmS/pMto+NkilplB4RA==
X-Google-Smtp-Source: AA6agR4TRtvG9G8Gs+R7dq088SKcm9kI30k6MTgh4v2X0rW8HiPbI9kQ32uQe/Sg5TmFF4QJFd54aQ==
X-Received: by 2002:a17:903:1ce:b0:16f:1c1f:50e5 with SMTP id e14-20020a17090301ce00b0016f1c1f50e5mr12930647plh.132.1662702802633;
        Thu, 08 Sep 2022 22:53:22 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id y66-20020a636445000000b00421841943dfsm464380pgb.12.2022.09.08.22.53.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2022 22:53:22 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v5 1/5] sched/fair: Ignore SIS_UTIL when has idle core
Date:   Fri,  9 Sep 2022 13:53:00 +0800
Message-Id: <20220909055304.25171-2-wuyun.abel@bytedance.com>
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

When SIS_UTIL is enabled, SIS domain scan will be skipped if the
LLC is overloaded even the has_idle_core hint is true. Since idle
load balancing is triggered at tick boundary, the idle cores can
stay cold for the whole tick period wasting time meanwhile some
of other cpus might be overloaded.

Give it a chance to scan for idle cores if the hint implies a
worthy effort.

Benchmark
=========

Tests are done in a dual socket (2 x 24C/48T) machine modeled Intel
Xeon(R) Platinum 8260, with SNC configuration:

	SNC on:  4 NUMA nodes each of which has 12C/24T
	SNC off: 2 NUMA nodes each of which has 24C/48T

All of the benchmarks are done inside a normal cpu cgroup in a clean
environment with cpu turbo disabled.

Based on tip sched/core 0fba527e959d (v5.19.0).

Results
=======

hackbench-process-pipes
                         vanilla		patched
(SNC on)
Amean     1        0.4480 (   0.00%)      0.4470 (   0.22%)
Amean     4        0.6137 (   0.00%)      0.5947 (   3.10%)
Amean     7        0.7530 (   0.00%)      0.7450 (   1.06%)
Amean     12       1.1230 (   0.00%)      1.1053 (   1.57%)
Amean     21       2.0567 (   0.00%)      1.9420 (   5.58%)
Amean     30       3.0847 (   0.00%)      2.9267 *   5.12%*
Amean     48       5.9043 (   0.00%)      4.7027 *  20.35%*
Amean     79       9.3477 (   0.00%)      7.7097 *  17.52%*
Amean     110     11.0647 (   0.00%)     10.0680 *   9.01%*
Amean     141     13.3297 (   0.00%)     12.5450 *   5.89%*
Amean     172     15.2210 (   0.00%)     15.0297 (   1.26%)
Amean     203     17.8510 (   0.00%)     16.8827 *   5.42%*
Amean     234     19.9263 (   0.00%)     19.1183 (   4.05%)
Amean     265     21.9117 (   0.00%)     20.9893 *   4.21%*
Amean     296     23.7683 (   0.00%)     23.3920 (   1.58%)
(SNC off)
Amean     1        0.2963 (   0.00%)      0.2717 (   8.32%)
Amean     4        0.6093 (   0.00%)      0.6257 (  -2.68%)
Amean     7        0.7837 (   0.00%)      0.7740 (   1.23%)
Amean     12       1.2703 (   0.00%)      1.2410 (   2.31%)
Amean     21       2.6260 (   0.00%)      2.6410 (  -0.57%)
Amean     30       4.3483 (   0.00%)      3.7620 (  13.48%)
Amean     48       7.9753 (   0.00%)      6.7757 (  15.04%)
Amean     79       9.6540 (   0.00%)      8.8827 *   7.99%*
Amean     110     11.2597 (   0.00%)     11.0583 (   1.79%)
Amean     141     13.8077 (   0.00%)     13.3387 (   3.40%)
Amean     172     16.3513 (   0.00%)     15.9583 *   2.40%*
Amean     203     19.0880 (   0.00%)     17.8757 *   6.35%*
Amean     234     21.7660 (   0.00%)     20.0543 *   7.86%*
Amean     265     23.0447 (   0.00%)     22.6643 *   1.65%*
Amean     296     25.4660 (   0.00%)     25.6677 (  -0.79%)

The more overloaded the system is, the more benefit can be seen due
to exploiting the cpu resources by more actively kicking idle cores
working, e.g. 21~48 groups. But once more workload are applied (79+
groups), the free cpu capacity that can be exploited becoming less,
thus improvement comes down to ~5%.

On the other hand when the load is relatively low (<12 groups), not
much benefit can be seen because in such case it's not hard to find
an idle cpu, so the benefit is picking up an idle core rather than
an idle cpu, but the cost of full scans will indeed negate lots of
benefit it brings.

The downside of full scan is that the cost gets bigger in larger
LLCs, but the test result seems still positive. One possible reason
is due to the low SIS success rate (~3.5%), so the cost doesn't
negate the benefit.

tbench4 Throughput
                         vanilla		patched
(SNC on)
Hmean     1        284.44 (   0.00%)      287.90 *   1.22%*
Hmean     2        564.10 (   0.00%)      575.52 *   2.02%*
Hmean     4       1120.93 (   0.00%)     1137.94 *   1.52%*
Hmean     8       2248.94 (   0.00%)     2250.42 *   0.07%*
Hmean     16      4360.10 (   0.00%)     4363.41 (   0.08%)
Hmean     32      7300.52 (   0.00%)     7338.06 *   0.51%*
Hmean     64      8912.37 (   0.00%)     8914.66 (   0.03%)
Hmean     128    19874.16 (   0.00%)    19978.59 *   0.53%*
Hmean     256    19759.42 (   0.00%)    20057.49 *   1.51%*
Hmean     384    19502.40 (   0.00%)    19846.74 *   1.77%*
(SNC off)
Hmean     1        300.70 (   0.00%)      309.43 *   2.90%*
Hmean     2        597.53 (   0.00%)      613.92 *   2.74%*
Hmean     4       1188.34 (   0.00%)     1227.84 *   3.32%*
Hmean     8       2336.22 (   0.00%)     2379.04 *   1.83%*
Hmean     16      4459.17 (   0.00%)     4634.66 *   3.94%*
Hmean     32      7606.69 (   0.00%)     7592.12 *  -0.19%*
Hmean     64      9009.48 (   0.00%)     9241.11 *   2.57%*
Hmean     128    19456.88 (   0.00%)    17870.37 *  -8.15%*
Hmean     256    19771.10 (   0.00%)    19370.92 *  -2.02%*
Hmean     384    20118.74 (   0.00%)    19413.92 *  -3.50%*

netperf-udp
                         vanilla		patched
(SNC on)
Hmean     send-64         209.06 (   0.00%)      211.69 *   1.26%*
Hmean     send-128        416.70 (   0.00%)      417.00 (   0.07%)
Hmean     send-256        819.65 (   0.00%)      827.61 *   0.97%*
Hmean     send-1024      3163.12 (   0.00%)     3191.16 *   0.89%*
Hmean     send-2048      5958.21 (   0.00%)     6045.20 *   1.46%*
Hmean     send-3312      9168.81 (   0.00%)     9282.21 *   1.24%*
Hmean     send-4096     11039.27 (   0.00%)    11130.55 (   0.83%)
Hmean     send-8192     17804.42 (   0.00%)    17816.25 (   0.07%)
Hmean     send-16384    28529.57 (   0.00%)    28812.09 (   0.99%)
Hmean     recv-64         209.06 (   0.00%)      211.69 *   1.26%*
Hmean     recv-128        416.70 (   0.00%)      417.00 (   0.07%)
Hmean     recv-256        819.65 (   0.00%)      827.61 *   0.97%*
Hmean     recv-1024      3163.12 (   0.00%)     3191.16 *   0.89%*
Hmean     recv-2048      5958.21 (   0.00%)     6045.18 *   1.46%*
Hmean     recv-3312      9168.81 (   0.00%)     9282.21 *   1.24%*
Hmean     recv-4096     11039.27 (   0.00%)    11130.55 (   0.83%)
Hmean     recv-8192     17804.32 (   0.00%)    17816.23 (   0.07%)
Hmean     recv-16384    28529.38 (   0.00%)    28812.04 (   0.99%)
(SNC off)
Hmean     send-64         211.39 (   0.00%)      213.24 (   0.87%)
Hmean     send-128        415.25 (   0.00%)      426.45 *   2.70%*
Hmean     send-256        814.75 (   0.00%)      835.33 *   2.53%*
Hmean     send-1024      3171.61 (   0.00%)     3173.84 (   0.07%)
Hmean     send-2048      6015.92 (   0.00%)     6046.41 (   0.51%)
Hmean     send-3312      9210.17 (   0.00%)     9309.65 (   1.08%)
Hmean     send-4096     11084.55 (   0.00%)    11250.86 *   1.50%*
Hmean     send-8192     17769.83 (   0.00%)    18101.50 *   1.87%*
Hmean     send-16384    27718.62 (   0.00%)    28152.58 *   1.57%*
Hmean     recv-64         211.39 (   0.00%)      213.24 (   0.87%)
Hmean     recv-128        415.25 (   0.00%)      426.45 *   2.70%*
Hmean     recv-256        814.75 (   0.00%)      835.32 *   2.53%*
Hmean     recv-1024      3171.61 (   0.00%)     3173.84 (   0.07%)
Hmean     recv-2048      6015.92 (   0.00%)     6046.41 (   0.51%)
Hmean     recv-3312      9210.17 (   0.00%)     9309.65 (   1.08%)
Hmean     recv-4096     11084.55 (   0.00%)    11250.86 *   1.50%*
Hmean     recv-8192     17769.76 (   0.00%)    18101.32 *   1.87%*
Hmean     recv-16384    27718.62 (   0.00%)    28152.46 *   1.57%*

netperf-tcp
                         vanilla		patched
(SNC on)
Hmean     64        1192.41 (   0.00%)     1253.72 *   5.14%*
Hmean     128       2354.50 (   0.00%)     2375.97 (   0.91%)
Hmean     256       4371.10 (   0.00%)     4412.90 (   0.96%)
Hmean     1024     13813.84 (   0.00%)    13987.31 (   1.26%)
Hmean     2048     21518.91 (   0.00%)    21677.74 (   0.74%)
Hmean     3312     25585.77 (   0.00%)    25943.95 *   1.40%*
Hmean     4096     27402.77 (   0.00%)    27700.88 *   1.09%*
Hmean     8192     31766.67 (   0.00%)    32187.68 *   1.33%*
Hmean     16384    36227.30 (   0.00%)    36542.97 (   0.87%)
(SNC off)
Hmean     64        1182.09 (   0.00%)     1219.15 *   3.14%*
Hmean     128       2316.35 (   0.00%)     2361.89 *   1.97%*
Hmean     256       4231.05 (   0.00%)     4314.53 *   1.97%*
Hmean     1024     13461.44 (   0.00%)    13543.85 (   0.61%)
Hmean     2048     21016.51 (   0.00%)    21270.62 *   1.21%*
Hmean     3312     24834.03 (   0.00%)    24960.05 (   0.51%)
Hmean     4096     26700.53 (   0.00%)    26959.99 (   0.97%)
Hmean     8192     31094.10 (   0.00%)    30989.89 (  -0.34%)
Hmean     16384    34953.23 (   0.00%)    35310.35 (   1.02%)

The netperf and tbench4 both have high SIS success rate, that is
~100% and ~50% respectively. So the effort paid for full scan for
idle cores is not very beneficial compared to its cost. This is
actually the case similar to the aforementioned <12 groups case
in hackbench.

Conclusion
==========

Taking a full scan for idle cores is generally good for making
better use of the cpu resources, yet there is still room for
improvement under certain circumstances.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index efceb670e755..5af9bf246274 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6437,7 +6437,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		time = cpu_clock(this);
 	}
 
-	if (sched_feat(SIS_UTIL)) {
+	if (sched_feat(SIS_UTIL) && !has_idle_core) {
 		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
 		if (sd_share) {
 			/* because !--nr is the condition to stop scan */
-- 
2.37.3

