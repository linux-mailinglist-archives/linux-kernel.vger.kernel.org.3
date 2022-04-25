Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B21A50E26F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiDYN4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242259AbiDYN4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:56:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3084D67D12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:53:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E40371FB;
        Mon, 25 Apr 2022 06:53:30 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.10.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A0453F774;
        Mon, 25 Apr 2022 06:53:29 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     sudeep.holla@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        lukasz.luba@arm.com
Subject: [PATCH v2] arch_topology: Trace the update thermal pressure
Date:   Mon, 25 Apr 2022 14:53:17 +0100
Message-Id: <20220425135317.5880-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trace event to capture the moment of the call for updating the thermal
pressure value. It's helpful to investigate how often those events occurs
in a system dealing with throttling. This trace event is needed since the
old 'cdev_update' might not be used by some drivers. Also, the new trace
event shows capacity value, not a cooling state.

We already have a trace point 'pelt_thermal_tp' which after a change to
trace event can be paired with this new 'thermal_pressure_update' and
derive more insight what is going on in the system under pressure
(and why).

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
Hi all,

This v2 solves the issue reported by build robot.
After experiments and checks I decided to not add the
EXPORT_TRACEPOINT_SYMBOL_GPL(thermal_pressure_update)
The trace event shouldn't be used by modules, since they use
the exported update function:
EXPORT_SYMBOL_GPL(topology_update_thermal_pressure)
which calls that trace event internally.
The code duplication for updating thermal pressure in a modules
is not recommended - that was the goal of introducing
topology_update_thermal_pressure().

Changes in v2:
- as suggested by Steve, I have swapped the fields
- a new trace header, so no conflicts with thermal.h
- added CREATE_TRACE_POINTS before header

The v1 and discussion can be found here at:
https://lore.kernel.org/lkml/20220419164801.29078-1-lukasz.luba@arm.com/

Regards,
Lukasz

 drivers/base/arch_topology.c            |  5 +++++
 include/trace/events/thermal_pressure.h | 29 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/trace/events/thermal_pressure.h

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1d6636ebaac5..20bdad18dccd 100644
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

