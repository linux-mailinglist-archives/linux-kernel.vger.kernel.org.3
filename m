Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA1655DFE2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243500AbiF1H5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343783AbiF1H5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:57:37 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4689C1B786
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:57:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VHgOW0s_1656403052;
Received: from rt2b04371.sqa.tbc.tbsite.net(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VHgOW0s_1656403052)
          by smtp.aliyun-inc.com;
          Tue, 28 Jun 2022 15:57:33 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sched/core: Fix the bug that task won't enqueue into core tree when update cookie
Date:   Tue, 28 Jun 2022 15:57:23 +0800
Message-Id: <1656403045-100840-2-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
References: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function sched_core_update_cookie(), a task will enqueue into the
core tree only when it enqueued before, that is, if an uncookied task
is cookied, it will not enqueue into the core tree until it enqueue
again, which will result in unnecessary force idle.

Here follows the scenario:
  CPU x and CPU y are a pair of SMT siblings.
  1. Start task a running on CPU x without sleeping, and task b and
     task c running on CPU y without sleeping.
  2. We create a cookie and share it to task a and task b, and then
     we create another cookie and share it to task c.
  3. Simpling core_forceidle_sum of task a and b from /proc/PID/sched

And we will find out that core_forceidle_sum of task a takes 30%
time of the sampling period, which shouldn't happen as task a and b
have the same cookie.

Then we migrate task a to CPU x', migrate task b and c to CPU y', where
CPU x' and CPU y' are a pair of SMT siblings, and sampling again, we
will found out that core_forceidle_sum of task a and b are almost zero.

To solve this problem, we enqueue the task into the core tree if it's
on rq.

Fixes: 6e33cad0af49("sched: Trivial core scheduling cookie management")
Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 kernel/sched/core_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 38a2cec..ba2466c 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -75,7 +75,7 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
 	old_cookie = p->core_cookie;
 	p->core_cookie = cookie;
 
-	if (enqueued)
+	if (task_on_rq_queued(p))
 		sched_core_enqueue(rq, p);
 
 	/*
-- 
1.8.3.1

