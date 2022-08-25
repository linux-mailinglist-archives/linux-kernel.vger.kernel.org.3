Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8920F5A1CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbiHYWtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiHYWtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:49:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D54C6CC0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661467782; x=1693003782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=iCf2JOGLKwSr4KxwYo6MVIoFBW1cHtkZPlptvpIfquk=;
  b=hNLtMQXxG0Mbwj5qf99IeCPpRzJC2m7L3I5dgzzS23GgyjEeWk9vup3c
   Y2v9tePc7bkX9HyzMY/m3G5ov2X2mdp+uCJa3qzBZRo4s+QyJskMseDWA
   02+77Sqb+vUO266UvDr+qAXDAodbaWJemizYXUmG48D+vibss24f8Ox6O
   WU1HR5YL/KiCnFGxZTDDyYTM1asCIi3vJyXvLy5AgkqCkh867Sa/uRK68
   xQguy7/9VZtl3Q+pHAdGfQL3bCl/2cbjTvWbNNBGREJLqo6d0KlQJ2TCQ
   DhnQjCzXm+U61lKdasqgbT/QzUBftpXmyGN9ThHldGMTfmUb/oySSQMRo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295153916"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="295153916"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 15:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="678642674"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2022 15:49:40 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH 1/4] sched/fair: Simplify asym_packing logic for SMT sched groups
Date:   Thu, 25 Aug 2022 15:55:26 -0700
Message-Id: <20220825225529.26465-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220825225529.26465-1-ricardo.neri-calderon@linux.intel.com>
References: <20220825225529.26465-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the destination CPU is an SMT sibling and idle, it can only help the
busiest group if all of its other SMT siblings are also idle. Otherwise,
there is not increase in throughput.

It does not matter whether the busiest group has SMT siblings. Simply
check if there are any tasks running on the local group before proceeding.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 kernel/sched/fair.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9326..91f271ea02d2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8603,12 +8603,10 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 				    struct sched_group *sg)
 {
 #ifdef CONFIG_SCHED_SMT
-	bool local_is_smt, sg_is_smt;
+	bool local_is_smt;
 	int sg_busy_cpus;
 
 	local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
-	sg_is_smt = sg->flags & SD_SHARE_CPUCAPACITY;
-
 	sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
 
 	if (!local_is_smt) {
@@ -8629,25 +8627,16 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
 	}
 
-	/* @dst_cpu has SMT siblings. */
-
-	if (sg_is_smt) {
-		int local_busy_cpus = sds->local->group_weight -
-				      sds->local_stat.idle_cpus;
-		int busy_cpus_delta = sg_busy_cpus - local_busy_cpus;
-
-		if (busy_cpus_delta == 1)
-			return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
-
-		return false;
-	}
-
 	/*
-	 * @sg does not have SMT siblings. Ensure that @sds::local does not end
-	 * up with more than one busy SMT sibling and only pull tasks if there
-	 * are not busy CPUs (i.e., no CPU has running tasks).
+	 * @dst_cpu has SMT siblings. When both @dst_cpu and the busiest core
+	 * have one or more busy siblings, moving tasks between them results
+	 * in the same throughput. Only if all the siblings of @dst_cpu are
+	 * idle throughput can increase.
+	 *
+	 * If the difference in the number of busy CPUs is two or more, let
+	 * find_busiest_group() take care of it.
 	 */
-	if (!sds->local_stat.sum_nr_running)
+	if (sg_busy_cpus == 1 && !sds->local_stat.sum_nr_running)
 		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
 
 	return false;
-- 
2.25.1

