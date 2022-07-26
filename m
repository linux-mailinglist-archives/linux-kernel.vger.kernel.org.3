Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995F1581107
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbiGZKYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbiGZKYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:24:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CCCC32060;
        Tue, 26 Jul 2022 03:24:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC3621FB;
        Tue, 26 Jul 2022 03:24:29 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.72.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23C6C3F70D;
        Tue, 26 Jul 2022 03:24:26 -0700 (PDT)
Date:   Tue, 26 Jul 2022 11:24:04 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, kajetan.puchalski@arm.com
Subject: [PATCH] cpuidle: Add cpu_idle_miss trace event
Message-ID: <Yt/AxPFi88neW7W5@e126311.manchester.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a trace event for cpuidle to track missed (too deep or too shallow)
wakeups.

After each wakeup, CPUIdle already computes whether the entered state was
optimal, above or below the desired one and updates the relevant
counters. This patch makes it possible to trace those events in addition
to just reading the counters.

The patterns of types and percentages of misses across different
workloads appear to be very consistent. This makes the trace event very
useful for comparing the relative correctness of different CPUIdle
governors for different types of workloads, or for finding the
optimal governor for a given device.

Signed-off-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
---
 drivers/cpuidle/cpuidle.c    |  6 +++++-
 include/trace/events/power.h | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index ef2ea1b12cd8..bf57cab32456 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -8,6 +8,7 @@
  * This code is licenced under the GPL.
  */
 
+#include "linux/percpu-defs.h"
 #include <linux/clockchips.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
@@ -278,6 +279,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 
 				/* Shallower states are enabled, so update. */
 				dev->states_usage[entered_state].above++;
+				trace_cpu_idle_miss(dev->cpu, entered_state, false);
 				break;
 			}
 		} else if (diff > delay) {
@@ -289,8 +291,10 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 				 * Update if a deeper state would have been a
 				 * better match for the observed idle duration.
 				 */
-				if (diff - delay >= drv->states[i].target_residency_ns)
+				if (diff - delay >= drv->states[i].target_residency_ns) {
 					dev->states_usage[entered_state].below++;
+					trace_cpu_idle_miss(dev->cpu, entered_state, true);
+				}
 
 				break;
 			}
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index af5018aa9517..6539f23a5653 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -40,6 +40,28 @@ DEFINE_EVENT(cpu, cpu_idle,
 	TP_ARGS(state, cpu_id)
 );
 
+TRACE_EVENT(cpu_idle_miss,
+
+	TP_PROTO(unsigned int cpu_id, unsigned int state, bool below),
+
+	TP_ARGS(cpu_id, state, below),
+
+	TP_STRUCT__entry(
+		__field(u32,		cpu_id)
+		__field(u32,		state)
+		__field(bool,		below)
+	),
+
+	TP_fast_assign(
+		__entry->cpu_id = cpu_id;
+		__entry->state = state;
+		__entry->below = below;
+	),
+
+	TP_printk("cpu_id=%lu state=%lu type=%s", (unsigned long)__entry->cpu_id,
+		(unsigned long)__entry->state, (__entry->below)?"below":"above")
+);
+
 TRACE_EVENT(powernv_throttle,
 
  	TP_PROTO(int chip_id, const char *reason, int pmax),

base-commit: e0dccc3b76fb35bb257b4118367a883073d7390e
-- 
2.37.1

