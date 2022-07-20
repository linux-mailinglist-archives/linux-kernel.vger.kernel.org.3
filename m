Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55B857B29D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbiGTIOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbiGTIOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:14:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C0B6C121
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:13:29 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LnpKw07sdzjXGM;
        Wed, 20 Jul 2022 16:10:44 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Jul 2022 16:13:27 +0800
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
        <shenyang39@huawei.com>, <kprateek.nayak@amd.com>,
        <yu.c.chen@intel.com>, <wuyun.abel@bytedance.com>
Subject: [RESEND PATCH v5 2/2] sched/fair: Scan cluster before scanning LLC in wake-up path
Date:   Wed, 20 Jul 2022 16:11:50 +0800
Message-ID: <20220720081150.22167-3-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220720081150.22167-1-yangyicong@hisilicon.com>
References: <20220720081150.22167-1-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
                           tip/core                 patched
Hmean     1        345.89 (   0.00%)      393.96 *  13.90%*
Hmean     2        697.77 (   0.00%)      786.04 *  12.65%*
Hmean     4       1392.51 (   0.00%)     1570.26 *  12.76%*
Hmean     8       2800.61 (   0.00%)     3083.98 *  10.12%*
Hmean     16      5514.27 (   0.00%)     6116.00 *  10.91%*
Hmean     32     10869.81 (   0.00%)    10782.98 *  -0.80%*
Hmean     64      8315.22 (   0.00%)     8519.84 *   2.46%*
Hmean     128     6324.47 (   0.00%)     7159.35 *  13.20%*

On numa 0-1:
                           tip/core                 patched
Hmean     1        348.68 (   0.00%)      387.91 *  11.25%*
Hmean     2        693.57 (   0.00%)      774.91 *  11.73%*
Hmean     4       1369.26 (   0.00%)     1475.48 *   7.76%*
Hmean     8       2772.99 (   0.00%)     2984.61 *   7.63%*
Hmean     16      4825.83 (   0.00%)     5873.13 *  21.70%*
Hmean     32     10250.32 (   0.00%)    11688.06 *  14.03%*
Hmean     64     16309.51 (   0.00%)    19889.48 *  21.95%*
Hmean     128    13022.32 (   0.00%)    16005.64 *  22.91%*
Hmean     256    11335.79 (   0.00%)    13821.74 *  21.93%*

Tested-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 914096c5b1ae..25d2900ae221 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6377,6 +6377,40 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 
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
+				return -1;
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
+static inline int scan_cluster(struct task_struct *p, struct cpumask *cpus,
+			       int target, int *nr)
+{
+	return -1;
+}
+#endif
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -6437,6 +6471,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
+	idle_cpu = scan_cluster(p, cpus, target, &nr);
+	if ((unsigned int)idle_cpu < nr_cpumask_bits)
+		return idle_cpu;
+
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
@@ -6444,7 +6482,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 				return i;
 
 		} else {
-			if (!--nr)
+			if (--nr <= 0)
 				return -1;
 			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
@@ -6543,7 +6581,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_cache(prev, target) &&
+	if (prev != target && cpus_share_lowest_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
 	    asym_fits_capacity(task_util, prev))
 		return prev;
@@ -6569,7 +6607,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	p->recent_used_cpu = prev;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
-	    cpus_share_cache(recent_used_cpu, target) &&
+	    cpus_share_lowest_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_capacity(task_util, recent_used_cpu)) {
-- 
2.24.0

