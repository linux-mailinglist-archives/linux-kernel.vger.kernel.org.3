Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D3E49F3C6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346561AbiA1Gk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:40:29 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:32069 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiA1Gk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:40:27 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JlSR107Q5z1FCyK;
        Fri, 28 Jan 2022 14:36:29 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 14:40:25 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <mgorman@techsingularity.net>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <mgorman@suse.de>,
        <linux-kernel@vger.kernel.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>
Subject: [PATCH v2] sched/fair: Clear target from cpus to scan in select_idle_cpu
Date:   Fri, 28 Jan 2022 14:39:06 +0800
Message-ID: <20220128063906.1845-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 56498cfb045d noticed that "When select_idle_cpu starts scanning for
an idle CPU, it starts with a target CPU that has already been checked
by select_idle_sibling. This patch starts with the next CPU instead."
It only changed the scanning start cpu to target + 1 but still leave
the target in the scanning cpumask. The target still have a chance to be
checked in the last turn. Fix this by clear the target from the cpus
to scan.

Mel Gorman worries bit clear will introduce expensive cost so I
tested hackbench on a 2P Skylake server which shows no obvious
performance degradation.

hackbench-process-pipes
                           5.17-rc1                 patched
Amean     1        0.3332 (   0.00%)      0.3392 *  -1.80%*
Amean     4        0.9536 (   0.00%)      0.9192 *   3.61%*
Amean     7        1.3382 (   0.00%)      1.3226 *   1.17%*
Amean     12       2.1286 (   0.00%)      2.1132 *   0.72%*
Amean     21       3.9210 (   0.00%)      3.8996 *   0.55%*
Amean     30       6.9853 (   0.00%)      6.6562 *   4.71%*
Amean     48      12.5749 (   0.00%)     12.3100 *   2.11%*
Amean     79      17.2422 (   0.00%)     17.1231 *   0.69%*
Amean     110     21.8868 (   0.00%)     21.6772 *   0.96%*
Amean     141     26.9521 (   0.00%)     27.0702 *  -0.44%*
Amean     160     30.5096 (   0.00%)     30.3971 *   0.37%*

Fixes: 56498cfb045d ("sched/fair: Avoid a second scan of target in select_idle_cpu")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v1:
- add test in the commit
Link:https://lore.kernel.org/lkml/20211124085401.14411-1-yangyicong@hisilicon.com/

 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5146163bfabb..6b8bf86f5eff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6281,6 +6281,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		return -1;
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+	cpumask_clear_cpu(target, cpus);
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		u64 avg_cost, avg_idle, span_avg;
-- 
2.24.0

