Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559D6542CD7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbiFHKOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbiFHKNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:13:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EE920EEAA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:59:07 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LJ2hD4zv2z1K9Ww;
        Wed,  8 Jun 2022 17:57:16 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 17:59:05 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <tim.c.chen@linux.intel.com>, <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <guodong.xu@linaro.org>,
        <hesham.almatary@huawei.com>, <john.garry@huawei.com>,
        <shenyang39@huawei.com>
Subject: [PATCH v3 2/2] sched/fair: Scan cluster before scanning LLC in wake-up path
Date:   Wed, 8 Jun 2022 17:57:58 +0800
Message-ID: <20220608095758.60504-3-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220608095758.60504-1-yangyicong@hisilicon.com>
References: <20220608095758.60504-1-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

For platforms having clusters like Kunpeng920, CPUs within the same cluster
have lower latency when synchronizing and accessing shared resources like
cache. Thus, this patch tries to find an idle cpu within the cluster of the
target CPU before scanning the whole LLC to gain lower latency.

Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so this patch
doesn't consider SMT for this moment.

Testing has been done on Kunpeng920 by pinning tasks to one numa and two
numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.

With this patch, We noticed enhancement on tbench within one numa or cross
two numa.

On numa 0:
                            5.19-rc1                patched
Hmean     1        350.27 (   0.00%)      406.88 *  16.16%*
Hmean     2        702.01 (   0.00%)      808.22 *  15.13%*
Hmean     4       1405.14 (   0.00%)     1614.34 *  14.89%*
Hmean     8       2830.53 (   0.00%)     3169.02 *  11.96%*
Hmean     16      5597.95 (   0.00%)     6224.20 *  11.19%*
Hmean     32     10537.38 (   0.00%)    10524.97 *  -0.12%*
Hmean     64      8366.04 (   0.00%)     8437.41 *   0.85%*
Hmean     128     7060.87 (   0.00%)     7150.25 *   1.27%*

On numa 0-1:
                            5.19-rc1                patched
Hmean     1        346.11 (   0.00%)      408.47 *  18.02%*
Hmean     2        693.34 (   0.00%)      805.78 *  16.22%*
Hmean     4       1384.96 (   0.00%)     1602.49 *  15.71%*
Hmean     8       2699.45 (   0.00%)     3069.98 *  13.73%*
Hmean     16      5327.11 (   0.00%)     5688.19 *   6.78%*
Hmean     32     10019.10 (   0.00%)    11862.56 *  18.40%*
Hmean     64     13850.57 (   0.00%)    17748.54 *  28.14%*
Hmean     128    12498.25 (   0.00%)    15541.59 *  24.35%*
Hmean     256    11195.77 (   0.00%)    13854.06 *  23.74%*

Tested-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 kernel/sched/fair.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9326..f0496b93449c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6327,6 +6327,39 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 
 #endif /* CONFIG_SCHED_SMT */
 
+#ifdef CONFIG_SCHED_CLUSTER
+/*
+ * Scan the cluster domain for idle CPUs and clear cluster cpumask after scanning
+ */
+static inline int scan_cluster(struct task_struct *p, struct cpumask *cpus,
+			       int target, int *nr)
+{
+	struct sched_domain *sd = rcu_dereference(per_cpu(sd_cluster, target));
+	int cpu, idle_cpu;
+
+	/* TODO: Support SMT system with cluster topology */
+	if (!sched_smt_active() && sd) {
+		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
+			if (!--*nr)
+				break;
+
+			idle_cpu = __select_idle_cpu(cpu, p);
+			if ((unsigned int)idle_cpu < nr_cpumask_bits)
+				return idle_cpu;
+		}
+
+		cpumask_andnot(cpus, cpus, sched_domain_span(sd));
+	}
+
+	return -1;
+}
+#else
+static inline int scan_cluster(struct task_struct *p, int prev_cpu, int target, int *nr)
+{
+	return -1;
+}
+#endif
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -6375,6 +6408,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		time = cpu_clock(this);
 	}
 
+	idle_cpu = scan_cluster(p, cpus, target, &nr);
+	if ((unsigned int)idle_cpu < nr_cpumask_bits)
+		return idle_cpu;
+
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
@@ -6382,7 +6419,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 				return i;
 
 		} else {
-			if (!--nr)
+			if (--nr <= 0)
 				return -1;
 			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
@@ -6481,7 +6518,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_cache(prev, target) &&
+	if (prev != target && cpus_share_resources(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
 	    asym_fits_capacity(task_util, prev))
 		return prev;
@@ -6507,7 +6544,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	p->recent_used_cpu = prev;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
-	    cpus_share_cache(recent_used_cpu, target) &&
+	    cpus_share_resources(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_capacity(task_util, recent_used_cpu)) {
-- 
2.24.0

