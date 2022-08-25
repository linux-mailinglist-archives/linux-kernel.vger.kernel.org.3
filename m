Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449DC5A1CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244115AbiHYWt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243799AbiHYWtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:49:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF66EC6CC8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661467782; x=1693003782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GkDXgCnuNRjnWESTDjDb3InPMKM7a1XvTOW385F9W9Q=;
  b=RlqfFRV48+YgCLi3VvMumNkY8iTCQ+ZgMOi9qBiRWJQPbHoq8dp3elKs
   cO4ZrsipTyb7Aze7C01EWhkyyKGKN3ymsclD4XTGj3yl+szdhV9MXOviP
   JErGdVvnIz3bR1LEt2mWZ0ct+MJwYPz5b1uaENwlXPfBURNyErllrjI5A
   ULF/1vD/z+RiReQBOQ4OcZzBVDblX5sCtn7pREX91EWlqsXeNJwomHqp8
   zG0QiSdgk7wt8XFqLuvo2x8w77etQsXepcyFu5c/JN2uzY5iOm5v6rDuk
   lSpik8kjAHerCkLSJzyoxuzW0N+yLTYLbU93JcT4AHh37xp0gTZIVnEUC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295153922"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="295153922"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 15:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="678642681"
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
Subject: [PATCH 3/4] sched/fair: Let lower-priority CPUs do active balancing
Date:   Thu, 25 Aug 2022 15:55:28 -0700
Message-Id: <20220825225529.26465-4-ricardo.neri-calderon@linux.intel.com>
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

When more than one SMT siblings of a physical core are busy, an idle CPU
of lower priority can help.

Indicate that the low priority CPU can do active balancing from the high-
priority CPU only if they belong to separate cores.

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
 kernel/sched/fair.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 810645eb58ed..9b608b31080f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9759,9 +9759,14 @@ asym_active_balance(struct lb_env *env)
 	 * ASYM_PACKING needs to force migrate tasks from busy but
 	 * lower priority CPUs in order to pack all tasks in the
 	 * highest priority CPUs.
+	 *
+	 * If the busy CPU has higher priority but is an SMT sibling
+	 * in which other SMT siblings are also busy, a lower-priority
+	 * CPU in a separate core can help.
 	 */
 	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
-	       sched_asym_prefer(env->dst_cpu, env->src_cpu);
+	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
+		!(env->sd->flags & SD_SHARE_CPUCAPACITY));
 }
 
 static inline bool
-- 
2.25.1

