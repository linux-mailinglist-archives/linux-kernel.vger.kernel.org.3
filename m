Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB52949EB20
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245735AbiA0TdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:33:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:40872 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245576AbiA0TdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643311988; x=1674847988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=xnRbqa6BTbe8guUhq0yIR4wviwt5NP1PbDC58oVK8CA=;
  b=cPr6VT8tA0v/OUgCnPqcuWHS+ppv85kEljmLje9+7tV5K+p63pD3clXt
   UepmducfWS4M2o+8+8Wdten/oiaUE2/HPQ4Zj0VpwCpmflRrXA9LSLrYv
   TzjcFnzkBSTOwycYJsGUsBpQiMCudx7mZTvMgyX88tMFZY3beMBnFTUJQ
   Kmv648Z24h3o3iFb4c2ZmpxVhVSidDU5v2Z3X9t9D4yYWzF66xA14T0cy
   jsIJ/n3c5yTm2EBvYIVi17guNUjGHNCFH0XID1HGf/B/9gJqF7pKVQILY
   3hPC0xkDKhw+MYZUJ1klGHHIdBQAcpN9ZuCUY90NvIwtR0OWNx4N00/ZQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230522679"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="230522679"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 11:33:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="495844934"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2022 11:33:06 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/7] thermal: intel: hfi: Notify user space for HFI events
Date:   Thu, 27 Jan 2022 11:34:54 -0800
Message-Id: <20220127193454.12814-8-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220127193454.12814-1-ricardo.neri-calderon@linux.intel.com>
References: <20220127193454.12814-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When the hardware issues an HFI event, relay a notification to user space.
This allows user space to respond by reading performance and efficiency of
each CPU and take appropriate action.

For example, when the performance and efficiency of a CPU is 0, user space
can either offline the CPU or inject idle. Also, if user space notices a
downward trend in performance, it may proactively adjust power limits to
avoid future situations in which performance drops to 0.

To avoid excessive notifications, the rate is limited by one HZ per event.
To limit the netlink message size, send parameters for up to 16 CPUs in a
single message. If there are more than 16 CPUs, issue as many messages as
needed to notify the status of all CPUs.

In the HFI specification, both performance and efficiency capabilities are
defined in the [0, 255] range. The existing implementations of HFI hardware
do not scale the maximum values to 255. Since userspace cares about
capability values that are either 0 or show a downward/upward trend, this
fact does not matter much. Relative changes in capabilities are enough. To
comply with the thermal netlink ABI, scale both performance and efficiency
capabilities to the [0, 1023] interval.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Changes since v4:
  * Reworked parsing of HFI capabilities into chunks of
    HFI_MAX_THERM_NOTIFY_COUNT CPUs at a time to reduce the time
    we spend with interrupts disabled. (Srinivas)
  * Protected hfi_instance::cpus when iterating over them. (Rafael)

Changes since v3:
  * None

Changes since v2:
  * None

Changes since v1:
  * Made get_one_hfi_cap() return void. Removed unnecessary checks.
    (Rafael)
  * Replaced raw_spin_[un]lock_irq[restore|save]() with raw_spin_
    [un]lock_irq() in get_one_hfi_cap(). This function is only called from
    a workqueue and there is no need to save and restore irq flags.
  * Scaled performance and energy efficiency values to a [0, 1023] interval
    when reporting values to user space via thermal netlink notifications.
    (Lucasz).
  * Reworded commit message to comment on the scaling of HFI capabilities
    to comply with the proposed thermal netlink ABI.
---
 drivers/thermal/intel/Kconfig     |  1 +
 drivers/thermal/intel/intel_hfi.c | 75 ++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index e9d2925227d4..6cf3fe36a4ae 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -104,6 +104,7 @@ config INTEL_HFI_THERMAL
 	bool "Intel Hardware Feedback Interface"
 	depends on CPU_SUP_INTEL
 	depends on X86_THERMAL_VECTOR
+	select THERMAL_NETLINK
 	help
 	  Select this option to enable the Hardware Feedback Interface. If
 	  selected, hardware provides guidance to the operating system on
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 7a2b750eecc4..730fd121df6e 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -40,6 +40,7 @@
 
 #include <asm/msr.h>
 
+#include "../thermal_core.h"
 #include "intel_hfi.h"
 
 #define THERM_STATUS_CLEAR_PKG_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | \
@@ -163,6 +164,78 @@ static DEFINE_MUTEX(hfi_instance_lock);
 
 static struct workqueue_struct *hfi_updates_wq;
 #define HFI_UPDATE_INTERVAL		HZ
+#define HFI_MAX_THERM_NOTIFY_COUNT	16
+
+static void get_hfi_caps(struct hfi_instance *hfi_instance,
+			 struct thermal_genl_cpu_caps *cpu_caps)
+{
+	int cpu, i = 0;
+
+	raw_spin_lock_irq(&hfi_instance->table_lock);
+	for_each_cpu(cpu, hfi_instance->cpus) {
+		struct hfi_cpu_data *caps;
+		s16 index;
+
+		index = per_cpu(hfi_cpu_info, cpu).index;
+		caps = hfi_instance->data + index * hfi_features.cpu_stride;
+		cpu_caps[i].cpu = cpu;
+
+		/*
+		 * Scale performance and energy efficiency to
+		 * the [0, 1023] interval that thermal netlink uses.
+		 */
+		cpu_caps[i].performance = caps->perf_cap << 2;
+		cpu_caps[i].efficiency = caps->ee_cap << 2;
+
+		++i;
+	}
+	raw_spin_unlock_irq(&hfi_instance->table_lock);
+}
+
+/*
+ * Call update_capabilities() when there are changes in the HFI table.
+ */
+static void update_capabilities(struct hfi_instance *hfi_instance)
+{
+	struct thermal_genl_cpu_caps *cpu_caps;
+	int i = 0, cpu_count;
+
+	/* CPUs may come online/offline while processing an HFI update. */
+	mutex_lock(&hfi_instance_lock);
+
+	cpu_count = cpumask_weight(hfi_instance->cpus);
+
+	/* No CPUs to report in this hfi_instance. */
+	if (!cpu_count)
+		goto out;
+
+	cpu_caps = kcalloc(cpu_count, sizeof(*cpu_caps), GFP_KERNEL);
+	if (!cpu_caps)
+		goto out;
+
+	get_hfi_caps(hfi_instance, cpu_caps);
+
+	if (cpu_count < HFI_MAX_THERM_NOTIFY_COUNT)
+		goto last_cmd;
+
+	/* Process complete chunks of HFI_MAX_THERM_NOTIFY_COUNT capabilities. */
+	for (i = 0;
+	     (i + HFI_MAX_THERM_NOTIFY_COUNT) <= cpu_count;
+	     i += HFI_MAX_THERM_NOTIFY_COUNT)
+		thermal_genl_cpu_capability_event(HFI_MAX_THERM_NOTIFY_COUNT,
+						  &cpu_caps[i]);
+
+	cpu_count = cpu_count - i;
+
+last_cmd:
+	/* Process the remaining capabilities if any. */
+	if (cpu_count)
+		thermal_genl_cpu_capability_event(cpu_count, &cpu_caps[i]);
+
+	kfree(cpu_caps);
+out:
+	mutex_unlock(&hfi_instance_lock);
+}
 
 static void hfi_update_work_fn(struct work_struct *work)
 {
@@ -173,7 +246,7 @@ static void hfi_update_work_fn(struct work_struct *work)
 	if (!hfi_instance)
 		return;
 
-	/* TODO: Consume update here. */
+	update_capabilities(hfi_instance);
 }
 
 void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
-- 
2.17.1

