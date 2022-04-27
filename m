Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2497F5112A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358929AbiD0Hj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358913AbiD0HjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:39:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C66C59AE65
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:36:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E8D4ED1;
        Wed, 27 Apr 2022 00:36:08 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.7.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 80B7F3F774;
        Wed, 27 Apr 2022 00:36:06 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     sudeep.holla@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        lukasz.luba@arm.com
Subject: [PATCH v3] arch_topology: Trace the update thermal pressure
Date:   Wed, 27 Apr 2022 08:35:51 +0100
Message-Id: <20220427073551.19032-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trace event to capture the moment of the call for updating the thermal
pressure value. It's helpful to investigate how often those events occur
in a system dealing with throttling. This trace event is needed since the
old 'cdev_update' might not be used by some drivers.

The old 'cdev_update' trace event only provides a cooling state
value: [0, n]. That state value then needs additional tools to translate
it: state -> freq -> capacity -> thermal pressure. This new trace event
just stores proper thermal pressure value in the trace buffer, no need
for additional logic. This is helpful for cooperation when someone can
simply sends to the list the trace buffer output from the platform (no
need from additional information from other subsystems).

There are also platforms which due to some design reasons don't use
cooling devices and thus don't trigger old 'cdev_update' trace event.
They are also important and measuring latency for the thermal signal
raising/decaying characteristics is in scope. This new trace event
would cover them as well.

We already have a trace point 'pelt_thermal_tp' which after a change to
trace event can be paired with this new 'thermal_pressure_update' and
derive more insight what is going on in the system under thermal pressure
(and why).

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---

Changes in v3:
- extended explanation in the changelog following Greg's comment

The v2 is here:
https://lore.kernel.org/lkml/20220425135317.5880-1-lukasz.luba@arm.com/

The v1 and discussion can be found here at:
https://lore.kernel.org/lkml/20220419164801.29078-1-lukasz.luba@arm.com/

Regards,
Lukasz


 drivers/base/arch_topology.c            |  5 +++++
 include/trace/events/thermal_pressure.h | 29 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/trace/events/thermal_pressure.h

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index f73b836047cf..579c851a2bd7 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -19,6 +19,9 @@
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/thermal_pressure.h>
+
 static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
 static bool scale_freq_invariant;
@@ -195,6 +198,8 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
 
 	th_pressure = max_capacity - capacity;
 
+	trace_thermal_pressure_update(cpu, th_pressure);
+
 	for_each_cpu(cpu, cpus)
 		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
 }
diff --git a/include/trace/events/thermal_pressure.h b/include/trace/events/thermal_pressure.h
new file mode 100644
index 000000000000..b68680201360
--- /dev/null
+++ b/include/trace/events/thermal_pressure.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM thermal_pressure
+
+#if !defined(_TRACE_THERMAL_PRESSURE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_THERMAL_PRESSURE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(thermal_pressure_update,
+	TP_PROTO(int cpu, unsigned long thermal_pressure),
+	TP_ARGS(cpu, thermal_pressure),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, thermal_pressure)
+		__field(int, cpu)
+	),
+
+	TP_fast_assign(
+		__entry->thermal_pressure = thermal_pressure;
+		__entry->cpu = cpu;
+	),
+
+	TP_printk("cpu=%d thermal_pressure=%lu", __entry->cpu, __entry->thermal_pressure)
+);
+#endif /* _TRACE_THERMAL_PRESSURE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1

