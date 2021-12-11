Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0038247132E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 10:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhLKJsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 04:48:15 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:52576 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229762AbhLKJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 04:48:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V-Ef21u_1639216088;
Received: from localhost(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0V-Ef21u_1639216088)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Dec 2021 17:48:08 +0800
From:   Yihao Wu <wuyihao@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Shanpei Chen <shanpeic@linux.alibaba.com>,
        =?UTF-8?q?=E7=8E=8B=E8=B4=87?= <yun.wang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Again ignore percpu threads for imbalance pulls
Date:   Sat, 11 Dec 2021 17:48:08 +0800
Message-Id: <20211211094808.109295-1-wuyihao@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.604.gb1f3e1269
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 2f5f4cce496e ("sched/fair: Ignore percpu threads for imbalance
pulls") was meant to fix a performance issue, when load balance tries to
migrate pinned kernel threads at MC domain level. This was destined to
fail. After it fails, it further makes wakeup balance at NUMA domain level
messed up. The most severe case that I noticed and frequently occurs:
    |sum_nr_running(node1) - sum_nr_running(node2)| > 100

However the original bugfix failed, because it covers only case 1) below.
  1) Created by create_kthread
  2) Created by kernel_thread
No kthread is assigned to task_struct in case 2 (Please refer to comments
in free_kthread_struct) so it simply won't work.

The easist way to cover both cases is to check nr_cpus_allowed, just as
discussed in the mailing list of the v1 version of the original fix.

* lmbench3.lat_proc -P 104 fork (2 NUMA, and 26 cores, 2 threads)

                         w/out patch                 w/ patch
fork+exit latency            1660 ms                  1520 ms (   8.4%)

Fixes: 2f5f4cce496e ("sched/fair: Ignore percpu threads for imbalance pulls")
Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
---
 kernel/kthread.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 4a4d7092a2d8..cb05d3ff2de4 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -543,11 +543,7 @@ void kthread_set_per_cpu(struct task_struct *k, int cpu)
 
 bool kthread_is_per_cpu(struct task_struct *p)
 {
-	struct kthread *kthread = __to_kthread(p);
-	if (!kthread)
-		return false;
-
-	return test_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
+	return (p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1;
 }
 
 /**
-- 
2.32.0.604.gb1f3e1269

