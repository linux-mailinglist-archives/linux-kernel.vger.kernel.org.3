Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2ECE488137
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 04:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiAHDqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 22:46:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:16918 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233510AbiAHDqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 22:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641613562; x=1673149562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=aU/BjcyEbIO6K8pJuuzIICGupr4Hi+9kNamlmvHbAow=;
  b=d2uFL2K+LbFEZ2etZbkz2L85t0ioYuIG/kkUg0eRXCujVEZlYNNyUTpY
   TQ5WtoNisZycz5GR+wgssdsGegconbbq9ialZUgjQCLOp8e83P7vaTKQm
   8uupUjfnkE2PoISsH7Efpwg+KncMMQNWVionPacBPEReb8k9w9ceouyy3
   xWewjmNwby+N3ATKKTjkuNa1JAclJS+IlpU4SbOdRWQvZC7zLTWhgBGOZ
   4K/jw1m2S1NJaIEnO8RL8bSxN7K5s9sCiYUI/SV/8O1OHOirwmjNiS5vi
   o+LbuGrhDpVWNiRqVLBJNZJau017qJgCA9oZsPTkS/90dA1OlLgf3LwB8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="242781004"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="242781004"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 19:46:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="514024477"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 07 Jan 2022 19:46:00 -0800
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
Subject: [PATCH v4 4/7] thermal: intel: hfi: Handle CPU hotplug events
Date:   Fri,  7 Jan 2022 19:47:39 -0800
Message-Id: <20220108034743.31277-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220108034743.31277-1-ricardo.neri-calderon@linux.intel.com>
References: <20220108034743.31277-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All CPUs in a package are represented in an HFI table. There exists an
HFI table per package. Thus, CPUs in a package need to coordinate to
initialize and access the table. Do such coordination during CPU hotplug.
Use the first CPU to come online in a package to initialize the HFI table
and the data structure representing it. Other CPUs in the same package need
only to register or unregister themselves in that data structure.

The HFI depends on both the package-level thermal management and the local
APIC thermal local vector. Thus, ensure that both are properly configured
before calling intel_hfi_online(). The CPU hotplug callbacks of the thermal
throttle events code already meet these conditions. Enable the HFI from
thermal_throttle_online().

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
  * Corrected bug when initializing a CPU's HFI instance in
    intel_hfi_online().

Changes since v2:
  * Removed hfi_instance::initialized. Instead, use hfi_instance::
    hdr to determine if the instance has been initialized. (Rafael)
  * Renamed hfi_lock as hfi_instance_lock to reflect the fact that it is
    used to protect accesses to HFI instances. (Rafael)
  * Removed unnecessary locking when linking a CPU to an HFI instance
    in intel_hfi_online(). (Rafael)
  * Improved locking in error paths in intel_hfi_online(). (Rafael)
  * Unconditionally link the hfi_instance of a package/die to CPUs in
    the same package in intel_hfi_online(). Initialization is taken care
    of separately.
  * Removed a pointless check for NULL when taking a pointer of an element
    of hfi_instances.
  * Added missing #include files.

Changes since v1:
  * Renamed X86_FEATURE_INTEL_HFI as X86_FEATURE_HFI. (Boris)
  * Relocated definitions of MSR bits from intel_hfi.h to intel_hfi.c.
  * Renamed HFI_PTR_VALID_BIT as HW_FEEDBACK_PTR_VALID_BIT for clarity.
  * Reworked init_hfi_cpu_index() to take a pointer of type struct
    hfi_cpu_info. This makes the function more concise. (Rafael)
  * In intel_hfi_online(), check for null hfi_instances and improve checks
    of the die_id. (Rafael)
  * Use a local cpumask_var_t to keep track of the CPUs of each
    hfi_instance. (Rafael)
  * Removed hfi_instance::die_id. It is not used anywhere.
  * Renamed hfi_instance::table_base as hfi_instance::local_table for
    clarity.
---
 drivers/thermal/intel/intel_hfi.c   | 204 ++++++++++++++++++++++++++++
 drivers/thermal/intel/intel_hfi.h   |   4 +
 drivers/thermal/intel/therm_throt.c |   8 ++
 3 files changed, 216 insertions(+)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 52e16d2bc957..37f979a9e833 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -23,14 +23,24 @@
 
 #include <linux/bitops.h>
 #include <linux/cpufeature.h>
+#include <linux/cpumask.h>
+#include <linux/gfp.h>
+#include <linux/io.h>
 #include <linux/math.h>
+#include <linux/mutex.h>
+#include <linux/percpu-defs.h>
 #include <linux/printk.h>
 #include <linux/processor.h>
 #include <linux/slab.h>
 #include <linux/topology.h>
 
+#include <asm/msr.h>
+
 #include "intel_hfi.h"
 
+/* Hardware Feedback Interface MSR configuration bits */
+#define HW_FEEDBACK_PTR_VALID_BIT		BIT(0)
+
 /* CPUID detection and enumeration definitions for HFI */
 
 #define CPUID_HFI_LEAF 6
@@ -86,6 +96,8 @@ struct hfi_hdr {
  *			Located at the base of the local table.
  * @hdr:		Base address of the local table header
  * @data:		Base address of the local table data
+ * @cpus:		CPUs represented in this HFI table instance
+ * @hw_table:		Pointer to the HFI table of this instance
  *
  * A set of parameters to parse and navigate a specific HFI table.
  */
@@ -96,6 +108,8 @@ struct hfi_instance {
 	};
 	void			*hdr;
 	void			*data;
+	cpumask_var_t		cpus;
+	void			*hw_table;
 };
 
 /**
@@ -113,10 +127,179 @@ struct hfi_features {
 	unsigned int	hdr_size;
 };
 
+/**
+ * struct hfi_cpu_info - Per-CPU attributes to consume HFI data
+ * @index:		Row of this CPU in its HFI table
+ * @hfi_instance:	Attributes of the HFI table to which this CPU belongs
+ *
+ * Parameters to link a logical processor to an HFI table and a row within it.
+ */
+struct hfi_cpu_info {
+	s16			index;
+	struct hfi_instance	*hfi_instance;
+};
+
+static DEFINE_PER_CPU(struct hfi_cpu_info, hfi_cpu_info) = { .index = -1 };
+
 static int max_hfi_instances;
 static struct hfi_instance *hfi_instances;
 
 static struct hfi_features hfi_features;
+static DEFINE_MUTEX(hfi_instance_lock);
+
+static void init_hfi_cpu_index(struct hfi_cpu_info *info)
+{
+	union cpuid6_edx edx;
+
+	/* Do not re-read @cpu's index if it has already been initialized. */
+	if (info->index > -1)
+		return;
+
+	edx.full = cpuid_edx(CPUID_HFI_LEAF);
+	info->index = edx.split.index;
+}
+
+/*
+ * The format of the HFI table depends on the number of capabilities that the
+ * hardware supports. Keep a data structure to navigate the table.
+ */
+static void init_hfi_instance(struct hfi_instance *hfi_instance)
+{
+	/* The HFI header is below the time-stamp. */
+	hfi_instance->hdr = hfi_instance->local_table +
+			    sizeof(*hfi_instance->timestamp);
+
+	/* The HFI data starts below the header. */
+	hfi_instance->data = hfi_instance->hdr + hfi_features.hdr_size;
+}
+
+/**
+ * intel_hfi_online() - Enable HFI on @cpu
+ * @cpu:	CPU in which the HFI will be enabled
+ *
+ * Enable the HFI to be used in @cpu. The HFI is enabled at the die/package
+ * level. The first CPU in the die/package to come online does the full HFI
+ * initialization. Subsequent CPUs will just link themselves to the HFI
+ * instance of their die/package.
+ */
+void intel_hfi_online(unsigned int cpu)
+{
+	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, cpu);
+	u16 die_id = topology_logical_die_id(cpu);
+	struct hfi_instance *hfi_instance;
+	phys_addr_t hw_table_pa;
+	u64 msr_val;
+
+	if (!boot_cpu_has(X86_FEATURE_HFI))
+		return;
+
+	/* Not much to do if hfi_instances are missing. */
+	if (!hfi_instances)
+		return;
+
+	/*
+	 * The HFI instance of this @cpu may exist already but they have not
+	 * been linked to @cpu.
+	 */
+	hfi_instance = info->hfi_instance;
+	if (!hfi_instance) {
+		if (die_id < 0 || die_id >= max_hfi_instances)
+			return;
+
+		/*
+		 * Link @cpu to the HFI instance of its package/die. It does
+		 * not matter whether the instance has been initialized.
+		 */
+		hfi_instance = &hfi_instances[die_id];
+		info->hfi_instance = hfi_instance;
+	}
+
+	init_hfi_cpu_index(info);
+
+	/*
+	 * Now check if the HFI instance of the package/die of @cpu has been
+	 * initialized (by checking its header). In such case, all we have to
+	 * do is to add @cpu to this instance's cpumask.
+	 */
+	mutex_lock(&hfi_instance_lock);
+	if (hfi_instance->hdr) {
+		cpumask_set_cpu(cpu, hfi_instance->cpus);
+		goto unlock;
+	}
+
+	/*
+	 * Hardware is programmed with the physical address of the first page
+	 * frame of the table. Hence, the allocated memory must be page-aligned.
+	 */
+	hfi_instance->hw_table = alloc_pages_exact(hfi_features.nr_table_pages,
+						   GFP_KERNEL | __GFP_ZERO);
+	if (!hfi_instance->hw_table)
+		goto unlock;
+
+	hw_table_pa = virt_to_phys(hfi_instance->hw_table);
+
+	/*
+	 * Allocate memory to keep a local copy of the table that
+	 * hardware generates.
+	 */
+	hfi_instance->local_table = kzalloc(hfi_features.nr_table_pages << PAGE_SHIFT,
+					    GFP_KERNEL);
+	if (!hfi_instance->local_table)
+		goto free_hw_table;
+
+	/*
+	 * Program the address of the feedback table of this die/package. On
+	 * some processors, hardware remembers the old address of the HFI table
+	 * even after having been reprogrammed and re-enabled. Thus, do not free
+	 * the pages allocated for the table or reprogram the hardware with a
+	 * new base address. Namely, program the hardware only once.
+	 */
+	msr_val = hw_table_pa | HW_FEEDBACK_PTR_VALID_BIT;
+	wrmsrl(MSR_IA32_HW_FEEDBACK_PTR, msr_val);
+
+	init_hfi_instance(hfi_instance);
+
+	cpumask_set_cpu(cpu, hfi_instance->cpus);
+
+unlock:
+	mutex_unlock(&hfi_instance_lock);
+	return;
+
+free_hw_table:
+	free_pages_exact(hfi_instance->hw_table, hfi_features.nr_table_pages);
+	goto unlock;
+}
+
+/**
+ * intel_hfi_offline() - Disable HFI on @cpu
+ * @cpu:	CPU in which the HFI will be disabled
+ *
+ * Remove @cpu from those covered by its HFI instance.
+ *
+ * On some processors, hardware remembers previous programming settings even
+ * after being reprogrammed. Thus, keep HFI enabled even if all CPUs in the
+ * die/package of @cpu are offline. See note in intel_hfi_online().
+ */
+void intel_hfi_offline(unsigned int cpu)
+{
+	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, cpu);
+	struct hfi_instance *hfi_instance;
+
+	if (!boot_cpu_has(X86_FEATURE_HFI))
+		return;
+
+	hfi_instance = info->hfi_instance;
+	if (!hfi_instance)
+		return;
+
+	/* A non-NULL header means this HFI instance has been initialized. */
+	if (!hfi_instance->hdr)
+		return;
+
+	mutex_lock(&hfi_instance_lock);
+	cpumask_clear_cpu(cpu, hfi_instance->cpus);
+	mutex_unlock(&hfi_instance_lock);
+}
 
 static __init int hfi_parse_features(void)
 {
@@ -165,6 +348,9 @@ static __init int hfi_parse_features(void)
 
 void __init intel_hfi_init(void)
 {
+	struct hfi_instance *hfi_instance;
+	int i;
+
 	if (hfi_parse_features())
 		return;
 
@@ -178,4 +364,22 @@ void __init intel_hfi_init(void)
 	 */
 	hfi_instances = kcalloc(max_hfi_instances, sizeof(*hfi_instances),
 				GFP_KERNEL);
+	if (!hfi_instances)
+		return;
+
+	for (i = 0; i < max_hfi_instances; i++) {
+		hfi_instance = &hfi_instances[i];
+		if (!zalloc_cpumask_var(&hfi_instance->cpus, GFP_KERNEL))
+			goto err_nomem;
+	}
+
+	return;
+
+err_nomem:
+	for (i = 0; i < max_hfi_instances; i++) {
+		hfi_instance = &hfi_instances[i];
+		free_cpumask_var(hfi_instance->cpus);
+	}
+
+	kfree(hfi_instances);
 }
diff --git a/drivers/thermal/intel/intel_hfi.h b/drivers/thermal/intel/intel_hfi.h
index 05f748b48a4e..56c6b2d75202 100644
--- a/drivers/thermal/intel/intel_hfi.h
+++ b/drivers/thermal/intel/intel_hfi.h
@@ -4,8 +4,12 @@
 
 #if defined(CONFIG_INTEL_HFI_THERMAL)
 void __init intel_hfi_init(void);
+void intel_hfi_online(unsigned int cpu);
+void intel_hfi_offline(unsigned int cpu);
 #else
 static inline void intel_hfi_init(void) { }
+static inline void intel_hfi_online(unsigned int cpu) { }
+static inline void intel_hfi_offline(unsigned int cpu) { }
 #endif /* CONFIG_INTEL_HFI_THERMAL */
 
 #endif /* _INTEL_HFI_H */
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index ac408714d52b..2a79598a7f7a 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -480,6 +480,12 @@ static int thermal_throttle_online(unsigned int cpu)
 	l = apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
 
+	/*
+	 * Enable the package-level HFI interrupt. By now the local APIC is
+	 * ready to get thermal interrupts.
+	 */
+	intel_hfi_online(cpu);
+
 	return thermal_throttle_add_dev(dev, cpu);
 }
 
@@ -489,6 +495,8 @@ static int thermal_throttle_offline(unsigned int cpu)
 	struct device *dev = get_cpu_device(cpu);
 	u32 l;
 
+	intel_hfi_offline(cpu);
+
 	/* Mask the thermal vector before draining evtl. pending work */
 	l = apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
-- 
2.17.1

