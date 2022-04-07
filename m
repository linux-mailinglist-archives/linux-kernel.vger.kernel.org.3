Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9B44F83E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbiDGPq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345029AbiDGPqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:46:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF26C31DD;
        Thu,  7 Apr 2022 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649346251; x=1680882251;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pNOhE9/kv8vrHZD2BZf+FPGAZBIr/4yQ5tgZOcRzFbg=;
  b=OyWlzofPCp/B/M+veNTK4V9IJcJBRfIfk1h8wUxa0a2trquQKUp9SqbA
   L1EFZfCKhUN4CmoOaAFDj6UV19Kre5sWmgDQnkzrkJCvVwxyZTez4Wesx
   89KfwQwHEqsx49iQNZ6rLQ9ziJ4y5BP5JMx64rhfv7R0WTwajftR3YlF9
   yElErfMvrIRthAEhADrYVj8jnMKODJLzk0DqTrRnt4fLcdicT+VQtpRVK
   FIn5p4r89uMrj5Tux1AzhewR5QbqGqfoDe/Okc92Rf0aQCVz4/1re3za7
   34GcnBpGRs2WoipBuhb5qmYeT0FYcbIXfJQ+aMrMP1Kmy7T/axCne65Gm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261051683"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="261051683"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 08:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="550114073"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2022 08:43:51 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Handle no_turbo in frequency invariance
Date:   Fri,  8 Apr 2022 07:42:58 +0800
Message-Id: <20220407234258.569681-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem statement:
Once the user has disabled turbo frequency by
echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo,
the cfs_rq's util_avg becomes quite small when compared with
CPU capacity.

Step to reproduce:

echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo

./x86_cpuload --count 1 --start 3 --timeout 100 --busy 99
would launch 1 thread and bind it to CPU3, lasting for 100 seconds,
with a CPU utilization of 99%. [1]

top result:
%Cpu3  : 98.4 us,  0.0 sy,  0.0 ni,  1.6 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st

check util_avg:
cat /sys/kernel/debug/sched/debug | grep "cfs_rq\[3\]" -A 20 | grep util_avg
  .util_avg                      : 611

So the util_avg/cpu capacity is 611/1024, which is much smaller than
98.4% shown in the top result.

This might impact some logic in the scheduler. For example, group_is_overloaded()
would compare the group_capacity and group_util in the sched group, to
check if this sched group is overloaded or not. With this gap, even
when there is a nearly 100% workload, the sched group will not be regarded
as overloaded. Besides group_is_overloaded(), there are also other victims.
There is a ongoing work that aims to optimize the task wakeup in a LLC domain.
The main idea is to stop searching idle CPUs if the sched domain is overloaded[2].
This proposal also relies on the util_avg/CPU capacity to decide whether the LLC
domain is overloaded.

Analysis:
CPU frequency invariance has caused this difference. In summary,
the util_sum of cfs rq would decay quite fast when the CPU is in
idle, when the CPU frequency invariance is enabled.

The detail is as followed:

As depicted in update_rq_clock_pelt(), when the frequency invariance
is enabled, there would be two clock variables on each rq, clock_task
and clock_pelt:

   The clock_pelt scales the time to reflect the effective amount of
   computation done during the running delta time but then syncs back to
   clock_task when rq is idle.

   absolute time    | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16
   @ max frequency  ------******---------------******---------------
   @ half frequency ------************---------************---------
   clock pelt       | 1| 2|    3|    4| 7| 8| 9|   10|   11|14|15|16

The fast decay of util_sum during idle is due to:
1. rq->clock_pelt is always behind rq->clock_task
2. rq->last_update is updated to rq->clock_pelt' after invoking ___update_load_sum()
3. Then the CPU becomes idle, the rq->clock_pelt' would be suddenly increased
   a lot to rq->clock_task
4. Enters ___update_load_sum() again, the idle period is calculated by
   rq->clock_task - rq->last_update, AKA, rq->clock_task - rq->clock_pelt'.
   The lower the CPU frequency is, the larger the delta =
   rq->clock_task - rq->clock_pelt' will be. Since the idle period will be
   used to decay the util_sum only, the util_sum drops significantly during
   idle period.

Proposal:
This symptom is not only caused by disabling turbo frequency, but it
would also appear if the user limits the max frequency at runtime. Because
if the frequency is always lower than the max frequency,
CPU frequency invariance would decay the util_sum quite fast during idle.

As some end users would disable turbo after boot up, this patch aims to
present this symptom and deals with turbo scenarios for now. It might
be ideal if CPU frequency invariance is aware of the max CPU frequency
(user specified) at runtime in the future.

[Previous patch seems to be lost on LKML, this is a resend, sorry for any
inconvenience]

Link: https://github.com/yu-chen-surf/x86_cpuload.git #1
Link: https://lore.kernel.org/lkml/20220310005228.11737-1-yu.c.chen@intel.com/ #2
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 846bb3a78788..2216b24b6f84 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1322,6 +1322,7 @@ static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 	mutex_unlock(&intel_pstate_limits_lock);
 
 	intel_pstate_update_policies();
+	arch_set_max_freq_ratio(global.no_turbo);
 
 	mutex_unlock(&intel_pstate_driver_lock);
 
-- 
2.25.1

