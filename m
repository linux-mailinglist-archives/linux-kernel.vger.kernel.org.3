Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FF2485F01
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345049AbiAFCtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:49:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:57884 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344935AbiAFCtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641437364; x=1672973364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qC+ziCSyF18eYwH0V3W4CKYQnOQ6BTPljMZLFTAMwRY=;
  b=keN8yAaR/I+AzC0f9LwU+yr7og+huVB5Sj5fzDcREJnV8a/ASfeeMYv1
   Zt6+ESOJ/FDgSAWfGpIuL9QE1k2n4dHOCRuUFEKrsMdOROHFRVqkM2SRe
   AKwrDVpe0LllQxCmPEI9TD5rgB2G4pecmmdUX22ETyxBH+dQTg5r06+fI
   D0HREX87sGbs2MHXZDKagvEPIk0AAeE7bGxrvFG0uWBsRM1TFHIlWTRoO
   7S4AT7a6/OUahWOb13LwEjw/LpdbJppRGv7p8VEJr0pLny5lVk7wgV0o1
   6/omZ5T6Q/sCfz+4zqVYFsTN/pWcDZLnYv5F+0ZeMxcpqIgFsrCKwrb5T
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242534395"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="242534395"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 18:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="488796542"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 05 Jan 2022 18:49:22 -0800
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
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v3 5/7] thermal: intel: hfi: Enable notification interrupt
Date:   Wed,  5 Jan 2022 18:50:57 -0800
Message-Id: <20220106025059.25847-6-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220106025059.25847-1-ricardo.neri-calderon@linux.intel.com>
References: <20220106025059.25847-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hardware wants to inform the operating system about updates in the HFI
table, it issues a package-level thermal event interrupt. For this,
hardware has new interrupt and status bits in the IA32_PACKAGE_THERM_
INTERRUPT and IA32_PACKAGE_THERM_STATUS registers. The existing thermal
throttle driver already handles thermal event interrupts: it initializes
the thermal vector of the local APIC as well as per-CPU and package-level
interrupt reporting. It also provides routines to service such interrupts.
Extend its functionality to also handle HFI interrupts.

The frequency of the thermal HFI interrupt is specific to each processor
model. On some processors, a single interrupt happens as soon as the HFI is
enabled and hardware will never update HFI capabilities afterwards. On
other processors, thermal and power constraints may cause thermal HFI
interrupts every tens of milliseconds.

To not overwhelm consumers of the HFI data, use delayed work to throttle
the rate at which HFI updates are processed.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
  * Added missing #include files.

Changes since v1:
  * Renamed X86_FEATURE_INTEL_HFI as X86_FEATURE_HFI. (Boris)
  * Repurposed hfi_instance::event_lock to handle HFI interrupt
    events to avoid keeping CPUs spinning needlessly. Added a new
    hfi_instance::table_lock to serialize access to an HFI table.
    (PeterZ)
  * Replaced raw_spin_[un]lock[restore|save]() with raw_spin_[un]lock().
    intel_hfi_process_event() runs in interrupt context and hence there
    is no need to save interrupt flags.
  * Renamed HFI_CONFIG_ENABLE_BIT as HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT
    for clarity.
  * Reworked timestamp updates for readability. Removed redundant
    hfi_instance::timestamp.
  * Relaxed timestamp check to allow time wrap-around.
---
 drivers/thermal/intel/intel_hfi.c   | 103 ++++++++++++++++++++++++++++
 drivers/thermal/intel/intel_hfi.h   |   2 +
 drivers/thermal/intel/therm_throt.c |  10 +++
 3 files changed, 115 insertions(+)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index cf506ef1bfca..c76611bd9715 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -26,20 +26,28 @@
 #include <linux/cpumask.h>
 #include <linux/gfp.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/math.h>
 #include <linux/mutex.h>
 #include <linux/percpu-defs.h>
 #include <linux/printk.h>
 #include <linux/processor.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
 #include <linux/topology.h>
+#include <linux/workqueue.h>
 
 #include <asm/msr.h>
 
 #include "intel_hfi.h"
 
+#define THERM_STATUS_CLEAR_PKG_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | \
+				     BIT(9) | BIT(11) | BIT(26))
+
 /* Hardware Feedback Interface MSR configuration bits */
 #define HW_FEEDBACK_PTR_VALID_BIT		BIT(0)
+#define HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT	BIT(0)
 
 /* CPUID detection and enumeration definitions for HFI */
 
@@ -98,6 +106,9 @@ struct hfi_hdr {
  * @data:		Base address of the local table data
  * @cpus:		CPUs represented in this HFI table instance
  * @hw_table:		Pointer to the HFI table of this instance
+ * @update_work:	Delayed work to process HFI updates
+ * @table_lock:		Lock to protect acceses to the table of this instance
+ * @event_lock:		Lock to process HFI interrupts
  *
  * A set of parameters to parse and navigate a specific HFI table.
  */
@@ -110,6 +121,9 @@ struct hfi_instance {
 	void			*data;
 	cpumask_var_t		cpus;
 	void			*hw_table;
+	struct delayed_work	update_work;
+	raw_spinlock_t		table_lock;
+	raw_spinlock_t		event_lock;
 };
 
 /**
@@ -147,6 +161,83 @@ static struct hfi_instance *hfi_instances;
 static struct hfi_features hfi_features;
 static DEFINE_MUTEX(hfi_instance_lock);
 
+#define HFI_UPDATE_INTERVAL	HZ
+
+static void hfi_update_work_fn(struct work_struct *work)
+{
+	struct hfi_instance *hfi_instance;
+
+	hfi_instance = container_of(to_delayed_work(work), struct hfi_instance,
+				    update_work);
+	if (!hfi_instance)
+		return;
+
+	/* TODO: Consume update here. */
+}
+
+void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
+{
+	struct hfi_instance *hfi_instance;
+	int cpu = smp_processor_id();
+	struct hfi_cpu_info *info;
+	u64 new_timestamp;
+
+	if (!pkg_therm_status_msr_val)
+		return;
+
+	info = &per_cpu(hfi_cpu_info, cpu);
+	if (!info)
+		return;
+
+	/*
+	 * It is possible that we get an HFI thermal interrupt on this CPU
+	 * before its HFI instance is initialized. This is not a problem. The
+	 * CPU that enabled the interrupt for this package will also get the
+	 * interrupt and is fully initialized.
+	 */
+	hfi_instance = info->hfi_instance;
+	if (!hfi_instance)
+		return;
+
+	/*
+	 * On most systems, all CPUs in the package receive a package-level
+	 * thermal interrupt when there is an HFI update. It is sufficient to
+	 * let a single CPU to acknowledge the update and schedule work to
+	 * process it. The remaining CPUs can resume their work.
+	 */
+	if (!raw_spin_trylock(&hfi_instance->event_lock))
+		return;
+
+	/* Skip duplicated updates. */
+	new_timestamp = *(u64 *)hfi_instance->hw_table;
+	if (*hfi_instance->timestamp == new_timestamp) {
+		raw_spin_unlock(&hfi_instance->event_lock);
+		return;
+	}
+
+	raw_spin_lock(&hfi_instance->table_lock);
+
+	/*
+	 * Copy the updated table into our local copy. This includes the new
+	 * timestamp.
+	 */
+	memcpy(hfi_instance->local_table, hfi_instance->hw_table,
+	       hfi_features.nr_table_pages << PAGE_SHIFT);
+
+	raw_spin_unlock(&hfi_instance->table_lock);
+	raw_spin_unlock(&hfi_instance->event_lock);
+
+	/*
+	 * Let hardware know that we are done reading the HFI table and it is
+	 * free to update it again.
+	 */
+	pkg_therm_status_msr_val &= THERM_STATUS_CLEAR_PKG_MASK &
+				    ~PACKAGE_THERM_STATUS_HFI_UPDATED;
+	wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS, pkg_therm_status_msr_val);
+
+	schedule_delayed_work(&hfi_instance->update_work, HFI_UPDATE_INTERVAL);
+}
+
 static void init_hfi_cpu_index(struct hfi_cpu_info *info)
 {
 	union cpuid6_edx edx;
@@ -258,8 +349,20 @@ void intel_hfi_online(unsigned int cpu)
 
 	init_hfi_instance(hfi_instance);
 
+	INIT_DELAYED_WORK(&hfi_instance->update_work, hfi_update_work_fn);
+	raw_spin_lock_init(&hfi_instance->table_lock);
+	raw_spin_lock_init(&hfi_instance->event_lock);
+
 	cpumask_set_cpu(cpu, hfi_instance->cpus);
 
+	/*
+	 * Enable the hardware feedback interface and never disable it. See
+	 * comment on programming the address of the table.
+	 */
+	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+	msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
+	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+
 unlock:
 	mutex_unlock(&hfi_instance_lock);
 	return;
diff --git a/drivers/thermal/intel/intel_hfi.h b/drivers/thermal/intel/intel_hfi.h
index 56c6b2d75202..325aa78b745c 100644
--- a/drivers/thermal/intel/intel_hfi.h
+++ b/drivers/thermal/intel/intel_hfi.h
@@ -6,10 +6,12 @@
 void __init intel_hfi_init(void);
 void intel_hfi_online(unsigned int cpu);
 void intel_hfi_offline(unsigned int cpu);
+void intel_hfi_process_event(__u64 pkg_therm_status_msr_val);
 #else
 static inline void intel_hfi_init(void) { }
 static inline void intel_hfi_online(unsigned int cpu) { }
 static inline void intel_hfi_offline(unsigned int cpu) { }
+static inline void intel_hfi_process_event(__u64 pkg_therm_status_msr_val) { }
 #endif /* CONFIG_INTEL_HFI_THERMAL */
 
 #endif /* _INTEL_HFI_H */
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 2a79598a7f7a..930e19eeeac6 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -619,6 +619,10 @@ void intel_thermal_interrupt(void)
 					PACKAGE_THERM_STATUS_POWER_LIMIT,
 					POWER_LIMIT_EVENT,
 					PACKAGE_LEVEL);
+
+		if (this_cpu_has(X86_FEATURE_HFI))
+			intel_hfi_process_event(msr_val &
+						PACKAGE_THERM_STATUS_HFI_UPDATED);
 	}
 }
 
@@ -728,6 +732,12 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
 			      l | (PACKAGE_THERM_INT_LOW_ENABLE
 				| PACKAGE_THERM_INT_HIGH_ENABLE), h);
+
+		if (cpu_has(c, X86_FEATURE_HFI)) {
+			rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
+			      l | PACKAGE_THERM_INT_HFI_ENABLE, h);
+		}
 	}
 
 	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
-- 
2.17.1

