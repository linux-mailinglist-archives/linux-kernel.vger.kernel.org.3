Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB7646D61A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhLHOyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:54:06 -0500
Received: from mx1.didiglobal.com ([36.110.17.22]:30657 "HELO
        mailgate02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S235471AbhLHOyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:54:05 -0500
Received: from mail.didiglobal.com (unknown [172.20.15.13])
        by mailgate02.didichuxing.com (Maildata Gateway V2.8) with ESMTP id 1D2186006D20B;
        Wed,  8 Dec 2021 22:50:31 +0800 (CST)
Received: from BJSGEXMBX12.didichuxing.com (172.20.15.142) by
 BJSGEXMBX04.didichuxing.com (172.20.15.134) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Dec 2021 22:50:30 +0800
Received: from localhost.localdomain (172.20.16.101) by
 BJSGEXMBX12.didichuxing.com (172.20.15.142) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Dec 2021 22:50:30 +0800
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 172.20.15.13
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
Subject: [PATCH v2 1/3] sched/fair: avoid burst statistic if it's not set
Date:   Wed, 8 Dec 2021 22:50:18 +0800
Message-ID: <20211208145018.64657-1-wanghonglei@didichuxing.com>
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

It's not necessary to do burst associated statistic and calculation for
runtime if the burst feature is not set at all. Just return at the very
start point if so.

Signed-off-by: Honglei Wang <wanghonglei@didichuxing.com>
---
 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e476f6d9435..2cd626c22912 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4640,6 +4640,11 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 	if (unlikely(cfs_b->quota == RUNTIME_INF))
 		return;
 
+	if (cfs_b->burst == 0 && cfs_b->runtime_snap == cfs_b->quota) {
+		cfs_b->runtime = cfs_b->quota;
+		return;
+	}
+
 	cfs_b->runtime += cfs_b->quota;
 	runtime = cfs_b->runtime_snap - cfs_b->runtime;
 	if (runtime > 0) {
-- 
2.14.1

