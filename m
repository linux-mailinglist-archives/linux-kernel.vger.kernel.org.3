Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D635A1CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbiHYWtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242873AbiHYWtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:49:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350FDC6B7F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661467782; x=1693003782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=uERfAGHp3TTaFrF5iQh0zJNtv2ZvWZibf7w/wSu3E2k=;
  b=DpeM3rDY+Ymr+SvuVjrZslht4gn5qR2bYQTrNYrBm8pWM2mhS/ZLGAjC
   Kx/CisuFScc8M9PtH4UNxU2n/JEceJgVD2Y0tQE389Vwv3+re2XLSmeRW
   0YlcH3xlzgEkGPUFkgnIMxuEPRO4pkgaDb8OpLslnuzQJP6RjPpZRfzSs
   UstV4tVaYTdliUvCq4gVtOxe80ycosA2hbso4PnmLk/2Get+LXG6Eny5q
   rY+EEI+rqfNzJfsw11tO9rhJTKlbnVpmNt3BVGZVFFXsYwdUpqEfGpPUR
   oaLVrqrGiCB3lTWvw64JT+4br7zDDPYz5L+H9P4cEqK/oFG7Z2dMvTKVp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295153919"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="295153919"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 15:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="678642677"
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
Subject: [PATCH 2/4] sched/fair: Do not disqualify either runqueues of SMT sched groups
Date:   Thu, 25 Aug 2022 15:55:27 -0700
Message-Id: <20220825225529.26465-3-ricardo.neri-calderon@linux.intel.com>
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

We may be here because the busiest group is composed of SMT siblings and
more than one is busy.

An idle CPU with lower priority can help the higher-priority busiest
scheduling group by pulling tasks from it. The tasks that remain in the
busiest group will run with higher performance.

This scenario is observed, for instance, on Intel hybrid processors. PCores
have two SMT siblings and have higher priority than the ECores, which do
not have SMT siblings.

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
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>>
---
 kernel/sched/fair.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 91f271ea02d2..810645eb58ed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9662,10 +9662,14 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		    nr_running == 1)
 			continue;
 
-		/* Make sure we only pull tasks from a CPU of lower priority */
+		/*
+		 * Make sure we only pull tasks from a CPU of lower priority.
+		 * Except for scheduling groups composed of SMT siblings.
+		 */
 		if ((env->sd->flags & SD_ASYM_PACKING) &&
 		    sched_asym_prefer(i, env->dst_cpu) &&
-		    nr_running == 1)
+		    nr_running == 1 &&
+		    !(group->flags & SD_SHARE_CPUCAPACITY))
 			continue;
 
 		switch (env->migration_type) {
-- 
2.25.1

