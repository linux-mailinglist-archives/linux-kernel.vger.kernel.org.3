Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E1646D64A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhLHPCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:02:32 -0500
Received: from mx1.didiglobal.com ([36.110.17.22]:32076 "HELO
        mailgate01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S233020AbhLHPCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:02:30 -0500
Received: from mail.didiglobal.com (unknown [172.20.36.31])
        by mailgate01.didichuxing.com (Maildata Gateway V2.8) with ESMTP id 6ACD4D81F0427;
        Wed,  8 Dec 2021 22:50:50 +0800 (CST)
Received: from BJSGEXMBX12.didichuxing.com (172.20.15.142) by
 BJSGEXMBX10.didichuxing.com (172.20.15.140) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Dec 2021 22:50:50 +0800
Received: from localhost.localdomain (172.20.16.101) by
 BJSGEXMBX12.didichuxing.com (172.20.15.142) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Dec 2021 22:50:49 +0800
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 172.20.36.31
From:   Honglei Wang <wanghonglei@didichuxing.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Honglei Wang <jameshongleiwang@126.com>
Subject: [PATCH v2 2/3] sched/fair: prevent cpu burst too many periods
Date:   Wed, 8 Dec 2021 22:50:38 +0800
Message-ID: <20211208145038.64738-1-wanghonglei@didichuxing.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.20.16.101]
X-ClientProxiedBy: BJEXCAS04.didichuxing.com (172.20.36.192) To
 BJSGEXMBX12.didichuxing.com (172.20.15.142)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasks might get more cpu than quota in persistent periods due to the
cpu burst introduced by commit f4183717b370 ("sched/fair: Introduce the
burstable CFS controller"). For example, one task group whose quota is
100ms per period and can get 100ms burst, and its avg utilization is
around 105ms per period. Once this group gets a free period which
leaves enough runtime, it has a chance to get computting power more
than its quota for 10 periods or more in common bandwidth configuration
(say, 100ms as period). It means tasks can 'steal' the bursted power to
do daily jobs because all tasks could be scheduled out or sleep to help
the group get free periods.

I believe the purpose of cpu burst is to help handling bursty worklod.
But if one task group can get computting power more than its quota for
persistent periods even there is no bursty workload, it's kinda broke.

This patch limits the burst to 2 periods so that it won't break the
quota limit for long. Permitting 2 periods can help on the scenario that
periods refresh lands in the middle of a burst workload. With this, we
can give task group more cpu burst power to handle the real burst
workload and don't worry about the 'stealing'.

Signed-off-by: Honglei Wang <wanghonglei@didichuxing.com>
---
 kernel/sched/fair.c  | 13 ++++++++++---
 kernel/sched/sched.h |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2cd626c22912..4e04cb4269ba 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4645,14 +4645,21 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 		return;
 	}
 
-	cfs_b->runtime += cfs_b->quota;
-	runtime = cfs_b->runtime_snap - cfs_b->runtime;
+	runtime = cfs_b->runtime_snap - cfs_b->runtime - cfs_b->quota;
 	if (runtime > 0) {
 		cfs_b->burst_time += runtime;
 		cfs_b->nr_burst++;
+		cfs_b->burst_periods++;
+	}
+
+	if (cfs_b->burst_periods > 1) {
+		cfs_b->runtime = cfs_b->quota;
+		cfs_b->burst_periods = 0;
+	} else {
+		cfs_b->runtime += cfs_b->quota;
+		cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
 	}
 
-	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
 	cfs_b->runtime_snap = cfs_b->runtime;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0e66749486e7..f42280bca3b2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -370,6 +370,7 @@ struct cfs_bandwidth {
 	u64			burst;
 	u64			runtime_snap;
 	s64			hierarchical_quota;
+	u8                      burst_periods;
 
 	u8			idle;
 	u8			period_active;
-- 
2.14.1

