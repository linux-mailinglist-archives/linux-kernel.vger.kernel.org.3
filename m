Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5720E471360
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 11:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhLKKna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 05:43:30 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29123 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhLKKn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 05:43:29 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JB46n1ZBgz1DJqy;
        Sat, 11 Dec 2021 18:40:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.103) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 18:43:27 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <mgorman@techsingularity.net>, <linux-kernel@vger.kernel.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>
Subject: [PATCH] sched/fair: Track target domain's avg_scan_cost in select_idle_cpu
Date:   Sat, 11 Dec 2021 18:43:24 +0800
Message-ID: <20211211104324.95957-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.103]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We regulate the LLC domain scan in select_idle_cpu() by comparing
the average scan cost of this_sd against the average idle time of
this_rq. This is correct when the domain to scan is the LLC domain
of this cpu. But when the domain to scan is different from this
LLC domain, we'll have an inaccurate estimation of the scan cost
on the target domain as this_sd->avg_scan_cost contains contributions
of scanning other domains besides the target domain.

Track the avg_scan_cost of the target domain to make the estimation
more accurate.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e476f6d9435..6301740d98cb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6267,7 +6267,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 
 		avg_idle = this_rq->wake_avg_idle;
-		avg_cost = this_sd->avg_scan_cost + 1;
+		avg_cost = sd->avg_scan_cost + 1;
 
 		span_avg = sd->span_weight * avg_idle;
 		if (span_avg > 4*avg_cost)
@@ -6305,7 +6305,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		 */
 		this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
 
-		update_avg(&this_sd->avg_scan_cost, time);
+		update_avg(&sd->avg_scan_cost, time);
 	}
 
 	return idle_cpu;
-- 
2.33.0

