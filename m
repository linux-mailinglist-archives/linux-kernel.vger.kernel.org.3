Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF7461BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346173AbhK2Qlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 11:41:42 -0500
Received: from mx1.didiglobal.com ([36.110.17.22]:29698 "HELO
        mailgate01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S1346267AbhK2Qjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:39:41 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2021 11:39:40 EST
Received: from mail.didiglobal.com (unknown [172.20.36.95])
        by mailgate01.didichuxing.com (Maildata Gateway V2.8) with ESMTP id A1D77D81AD00B;
        Tue, 30 Nov 2021 00:28:15 +0800 (CST)
Received: from BJSGEXMBX12.didichuxing.com (172.20.15.142) by
 BJSGEXMBX11.didichuxing.com (172.20.15.141) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 30 Nov 2021 00:28:15 +0800
Received: from localhost.localdomain (172.31.3.254) by
 BJSGEXMBX12.didichuxing.com (172.20.15.142) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 30 Nov 2021 00:28:15 +0800
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 172.20.36.95
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
CC:     <jameshongleiwang@126.com>
Subject: [PATCH] sched/fair: prevent cpu burst too many periods
Date:   Tue, 30 Nov 2021 00:28:07 +0800
Message-ID: <20211129162807.21966-1-wanghonglei@didichuxing.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.3.254]
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

This patch limits the burst to one period so that it won't break the
quota limit for long. With this, we can give task group more cpu burst
power to handle the real bursty workload and don't worry about the
'stealing'.

Signed-off-by: Honglei Wang <wanghonglei@didichuxing.com>
---
 kernel/sched/fair.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e476f6d9435..cc2c4567fc81 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4640,14 +4640,17 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 	if (unlikely(cfs_b->quota == RUNTIME_INF))
 		return;
 
-	cfs_b->runtime += cfs_b->quota;
-	runtime = cfs_b->runtime_snap - cfs_b->runtime;
+	runtime = cfs_b->runtime_snap - cfs_b->quota - cfs_b->runtime;
+
 	if (runtime > 0) {
 		cfs_b->burst_time += runtime;
 		cfs_b->nr_burst++;
+		cfs_b->runtime = cfs_b->quota;
+	} else {
+		cfs_b->runtime += cfs_b->quota;
+		cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
 	}
 
-	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
 	cfs_b->runtime_snap = cfs_b->runtime;
 }
 
-- 
2.14.1

