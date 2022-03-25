Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CDC4E7B31
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiCYXxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 19:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiCYXxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 19:53:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEA14AE33
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648252329; x=1679788329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mHLNNSPQ4EYmrAFhqKFt7xJOVLotEnt4YlgX3orT5jE=;
  b=HEeKewEyJM9Ob/1FQBjkI6q0G23b/yOLq4Bwn9Ic5cQUX+iAWM/X3yPI
   o/BrI9tLU4kve7jzq4ZpKagWD1LVCnmyFDzGpCllENYKYJ+EH3V5ddicP
   9ORYR6U71wmoXn4sd2mVeyaflUEm2mqVCvEQ6hbpJnZdhxOvLOlPXKtmG
   xnhmYpEWNrLNDdU72y+4DtnZWwWVHvF81bE2LWESYvyt2quQub8iMNUGm
   iprWdRHQ5BOxuIaTs6Lv1cEQ9ncrrwqqTVOtL/l2BGbLyhDys+YUa9hed
   Pn3SoiXB54vpDaCHb0+AOWt194m90XPZ5Yq3W3mJTrB2cAKfsGgopAeJj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="321930148"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="321930148"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 16:52:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="648425294"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2022 16:52:08 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@elte.hu>, Juri Lelli <juri.lelli@redhat.com>
Cc:     Yu Chen <yu.c.chen@intel.com>, Walter Mack <walter.mack@intel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH 1/2] sched/fair: Don't rely on ->exec_start for migration
Date:   Fri, 25 Mar 2022 15:54:16 -0700
Message-Id: <68832dfbb60fda030540b5f4e39c5801942689b1.1648228023.git.tim.c.chen@linux.intel.com>
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

From: Peter Zijlstra <peterz@infradead.org>

From: Peter Zijlstra (Intel) <peterz@infradead.org>

Currently migrate_task_rq_fair() (ab)uses se->exec_start to make
task_hot() fail. In order to preserve ->exec_start, add a ->migrated
flag to sched_entity.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/sched.h | 1 +
 kernel/sched/fair.c   | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75ba8aa60248..0edf16b4d40a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -541,6 +541,7 @@ struct sched_entity {
 	struct rb_node			run_node;
 	struct list_head		group_node;
 	unsigned int			on_rq;
+	unsigned int			migrated;
 
 	u64				exec_start;
 	u64				sum_exec_runtime;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5146163bfabb..2498e97804fd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1004,6 +1004,7 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	/*
 	 * We are starting a new run period:
 	 */
+	se->migrated = 0;
 	se->exec_start = rq_clock_task(rq_of(cfs_rq));
 }
 
@@ -6979,7 +6980,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	p->se.avg.last_update_time = 0;
 
 	/* We have migrated, no longer consider this task hot */
-	p->se.exec_start = 0;
+	p->se.migrated = 1;
 
 	update_scan_period(p, new_cpu);
 }
@@ -7665,6 +7666,9 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 	if (sysctl_sched_migration_cost == 0)
 		return 0;
 
+	if (p->se.migrated)
+		return 0;
+
 	delta = rq_clock_task(env->src_rq) - p->se.exec_start;
 
 	return delta < (s64)sysctl_sched_migration_cost;
-- 
2.32.0

