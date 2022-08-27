Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B105A3377
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 03:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbiH0B3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 21:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiH0B3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:29:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61495E68E3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:29:30 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MDzYH125fz1N7Rv;
        Sat, 27 Aug 2022 09:25:55 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 09:29:28 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 27 Aug
 2022 09:29:27 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH -next] sched/deadline: Save processing meaningless ops in dl_task_offline_migration
Date:   Sat, 27 Aug 2022 10:04:30 +0800
Message-ID: <20220827020430.29415-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Task's bw will be sub from old rd, and add to new rd, even though
find_lock_later_rq returns a new rq that belong to the same rd with old
rq. Save ops for moving task's bw if rd is not changed.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 kernel/sched/deadline.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3bf4b12ec5b7..58ca9aaa9c44 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -714,20 +714,22 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 		add_rq_bw(&p->dl, &later_rq->dl);
 	}
 
-	/*
-	 * And we finally need to fixup root_domain(s) bandwidth accounting,
-	 * since p is still hanging out in the old (now moved to default) root
-	 * domain.
-	 */
-	dl_b = &rq->rd->dl_bw;
-	raw_spin_lock(&dl_b->lock);
-	__dl_sub(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
-	raw_spin_unlock(&dl_b->lock);
+	if (&rq->rd != &later_rq->rd) {
+		/*
+		 * And we finally need to fixup root_domain(s) bandwidth accounting,
+		 * since p is still hanging out in the old (now moved to default) root
+		 * domain.
+		 */
+		dl_b = &rq->rd->dl_bw;
+		raw_spin_lock(&dl_b->lock);
+		__dl_sub(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
+		raw_spin_unlock(&dl_b->lock);
 
-	dl_b = &later_rq->rd->dl_bw;
-	raw_spin_lock(&dl_b->lock);
-	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(later_rq->rd->span));
-	raw_spin_unlock(&dl_b->lock);
+		dl_b = &later_rq->rd->dl_bw;
+		raw_spin_lock(&dl_b->lock);
+		__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(later_rq->rd->span));
+		raw_spin_unlock(&dl_b->lock);
+	}
 
 	set_task_cpu(p, later_rq->cpu);
 	double_unlock_balance(later_rq, rq);
-- 
2.17.1

