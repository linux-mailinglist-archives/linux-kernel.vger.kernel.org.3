Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EF746B838
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhLGKBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:01:35 -0500
Received: from foss.arm.com ([217.140.110.172]:55714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234601AbhLGKBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:01:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 496561042;
        Tue,  7 Dec 2021 01:58:04 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.83.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3AEAE3F73B;
        Tue,  7 Dec 2021 01:58:03 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v3] sched/fair: cleanup task_util and capacity type
Date:   Tue,  7 Dec 2021 09:57:55 +0000
Message-Id: <20211207095755.859972-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_util and capacity are comparable unsigned long values. There is no
need for an intermidiate implicit signed cast.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

---
v2 -> v3:
  * Drop "Fixes" tags. 
  * Merge changes in one.

v1 -> v2:
  * Add task_fits_capacity missing unsigned
---

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 945d987246c5..26a88975f68a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4070,7 +4070,8 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_se_tp(&p->se);
 }
 
-static inline int task_fits_capacity(struct task_struct *p, long capacity)
+static inline int task_fits_capacity(struct task_struct *p,
+				     unsigned long capacity)
 {
 	return fits_capacity(uclamp_task_util(p), capacity);
 }
@@ -6346,7 +6347,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	return best_cpu;
 }
 
-static inline bool asym_fits_capacity(int task_util, int cpu)
+static inline bool asym_fits_capacity(unsigned long task_util, int cpu)
 {
 	if (static_branch_unlikely(&sched_asym_cpucapacity))
 		return fits_capacity(task_util, capacity_of(cpu));
-- 
2.25.1

