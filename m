Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9B34E7D2C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiCYXxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 19:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiCYXxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 19:53:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108AF10BBDB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648252331; x=1679788331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jsVPk/AP3tfYmFM+PdRlupq5b+ybr1R0V4Pies6bYIo=;
  b=FG1JkPVl7+7oWcN0B9fqNhvzkXzMSoSiTmFkb/sqbf3TeTTHON5FeWV9
   Nz6yVl4t46gR2cAcoW8Ci0WYhTLu7bYVJF49NdYIpiJdquyJq0hdIr6j9
   V48kfAsfu0vWn7FA6DwspN8GzkYAlfAs7LC2I2z7g9P7/CXBtctDGHDRW
   8uTE0oxl+FvLVXQDqJIXvQa8OaifMeA+1mdAR1QHl2fekjEGpspQXm5CH
   1Hw1Ijt/xo253JvN6IczMZM6YXO0FvTClwTmJTN08a10OrajwI7SnAuKs
   VsVCkoOz+aKztp+PyLLJACv+nyvJK4vJkgMrLEXwzomgpC2Y5rdBdhBtt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="321930161"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="321930161"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 16:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="648425297"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2022 16:52:10 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@elte.hu>, Juri Lelli <juri.lelli@redhat.com>
Cc:     Yu Chen <yu.c.chen@intel.com>, Walter Mack <walter.mack@intel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH 2/2] sched/fair: Simple runqueue order on migrate
Date:   Fri, 25 Mar 2022 15:54:17 -0700
Message-Id: <f59f1dfeec4692e7a373cc810168912a2d2f8f3c.1648228023.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1648228023.git.tim.c.chen@linux.intel.com>
References: <cover.1648228023.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

From: Peter Zijlstra (Intel) <peterz@infradead.org>

There's a number of problems with SMP migration of fair tasks, but
basically it boils down to a task not receiving equal service on each
runqueue (consider the trivial 3 tasks 2 cpus infeasible weight
scenario).

Fully solving that with vruntime placement is 'hard', not least
because a task might be very under-services on a busy runqueue and
would need to be placed so far left on the new runqueue that it would
significantly impact latency on the existing tasks.

Instead do minimal / basic placement instead; when moving to a less
busy queue place at the front of the queue to receive time sooner.
When moving to a busier queue, place at the end of the queue to
receive time later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Walter Mack <walter.mack@intel.com>
---
 kernel/sched/fair.c     | 33 +++++++++++++++++++++++++++++----
 kernel/sched/features.h |  2 ++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2498e97804fd..c5d2cb3a8f42 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4223,6 +4223,27 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 	se->vruntime = max_vruntime(se->vruntime, vruntime);
 }
 
+static void place_entity_migrate(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if (!sched_feat(PLACE_MIGRATE))
+		return;
+
+	if (cfs_rq->nr_running < se->migrated) {
+		/*
+		 * Migrated to a shorter runqueue, go first because
+		 * we were under-served on the old runqueue.
+		 */
+		se->vruntime = cfs_rq->min_vruntime;
+		return;
+	}
+
+	/*
+	 * Migrated to a longer runqueue, go last because
+	 * we got over-served on the old runqueue.
+	 */
+	se->vruntime = cfs_rq->min_vruntime + sched_vslice(cfs_rq, se);
+}
+
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
 
 static inline bool cfs_bandwidth_used(void);
@@ -4296,6 +4317,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	if (flags & ENQUEUE_WAKEUP)
 		place_entity(cfs_rq, se, 0);
+	else if (se->migrated)
+		place_entity_migrate(cfs_rq, se);
 
 	check_schedstat_required();
 	update_stats_enqueue_fair(cfs_rq, se, flags);
@@ -6930,6 +6953,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
  */
 static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 {
+	struct sched_entity *se = &p->se;
 	/*
 	 * As blocked tasks retain absolute vruntime the migration needs to
 	 * deal with this by subtracting the old and adding the new
@@ -6962,7 +6986,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		 * rq->lock and can modify state directly.
 		 */
 		lockdep_assert_rq_held(task_rq(p));
-		detach_entity_cfs_rq(&p->se);
+		detach_entity_cfs_rq(se);
 
 	} else {
 		/*
@@ -6973,14 +6997,15 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		 * wakee task is less decayed, but giving the wakee more load
 		 * sounds not bad.
 		 */
-		remove_entity_load_avg(&p->se);
+		remove_entity_load_avg(se);
 	}
 
 	/* Tell new CPU we are migrated */
-	p->se.avg.last_update_time = 0;
+	se->avg.last_update_time = 0;
 
 	/* We have migrated, no longer consider this task hot */
-	p->se.migrated = 1;
+	for_each_sched_entity(se)
+		se->migrated = READ_ONCE(cfs_rq_of(se)->nr_running) + !se->on_rq;
 
 	update_scan_period(p, new_cpu);
 }
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 1cf435bbcd9c..681c84fd062c 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -100,3 +100,5 @@ SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
+
+SCHED_FEAT(PLACE_MIGRATE, true)
-- 
2.32.0

