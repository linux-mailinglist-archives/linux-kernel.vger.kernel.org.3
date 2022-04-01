Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756614EEA2C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbiDAJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243987AbiDAJPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:15:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF732662CB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:13:47 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KVDrg4p0XzBrrp;
        Fri,  1 Apr 2022 17:09:39 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 17:13:44 +0800
Received: from huawei.com (7.220.126.23) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 1 Apr
 2022 17:13:44 +0800
From:   zhangsong <zhangsong34@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>, zhangsong <zhangsong34@gmail.com>
Subject: [PATCH] sched/fair: Allow non-idle task to preempt idle task directly
Date:   Fri, 1 Apr 2022 17:11:27 +0800
Message-ID: <20220401091127.3234638-1-zhangsong34@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.220.126.23]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangsong <zhangsong34@gmail.com>

In check_preempt_tick(), the sched idle task may exectue at least
`sysctl_sched_min_granularity` time but any other cfs tasks cannot
preempt it. So it is nessesary to ignore the `sysctl_sched_min_granularity`
resctriction for sched idle task preemption.

Signed-off-by: zhangsong <zhangsong34@gmail.com>
---
 kernel/sched/fair.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d6..edcb33440 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4477,6 +4477,15 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	struct sched_entity *se;
 	s64 delta;
 
+	se = __pick_first_entity(cfs_rq);
+
+	if ((cfs_rq->last && se_is_idle(cfs_rq->last) - se_is_idle(curr) < 0) ||
+	    (cfs_rq->next && se_is_idle(cfs_rq->last) - se_is_idle(curr) < 0) ||
+	    se_is_idle(se) - se_is_idle(curr) < 0) {
+		resched_curr(rq_of(cfs_rq));
+		return;
+	}
+
 	ideal_runtime = sched_slice(cfs_rq, curr);
 	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
 	if (delta_exec > ideal_runtime) {
@@ -4497,7 +4506,6 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	if (delta_exec < sysctl_sched_min_granularity)
 		return;
 
-	se = __pick_first_entity(cfs_rq);
 	delta = curr->vruntime - se->vruntime;
 
 	if (delta < 0)
-- 
2.27.0

