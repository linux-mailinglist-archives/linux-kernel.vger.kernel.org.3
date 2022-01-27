Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CEA49EB0B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245558AbiA0TdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:33:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:47240 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231221AbiA0TdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643311984; x=1674847984;
  h=from:to:cc:subject:date:message-id;
  bh=oTEGgTCbwBJGnCcOq0lVGD2d2O9/ahzQRNlHTLoZkPk=;
  b=S1lKIKc4SPnZpzKEEo+yGYAzhU4565rL1ZiNm36ctCvrQUmphHjIlOGa
   7z+NcuxK/8DRR9RQ2zorG1UIzu5KIE2RWyj9NZley9zD/DyZTenEUJdOu
   OXPS/JCPHvumO9P/LgxGa/oavN9BjNYgfYPeWt708dYC4h/wOfxMctjGL
   Y75iDVvofdnFl8w5/IsfdFXZFCzD7h0x51sjdMbYhNSvsee/t44y3j0A9
   +NmRUVVvOBaTZp4rX4eaxRVH7bbKF8fnM5VQBah7eChNsmXxTk9WV/aI2
   mrAA+ZKSjGgfuM+sYUbrGYD1JgylprNnifqZGLQ5aoIluNqObmFlUzHoC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245788378"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="245788378"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 11:33:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="495844865"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2022 11:33:00 -0800
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
Subject: [PATCH v5 0/7] Thermal: Introduce the Hardware Feedback Interface for thermal and performance management
Date:   Thu, 27 Jan 2022 11:34:47 -0800
Message-Id: <20220127193454.12814-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v5 of this patchset after having incorporated the feedback from
reviewers. Please find v1, v2, v3, and v4 in [1], [2], [3], and [4],
respectively.

The Intel Hardware Feedback Interface (HFI) [5] provides information about
the performance and energy efficiency of each CPU in the system. It uses a
table that is shared between hardware and the operating system. The
contents of the table may be updated as a result of changes in the
operating conditions of the system (e.g., reaching a thermal limit) or the
action of external factors (e.g., changes in the thermal design power).

The information that HFI provides are specified as numeric, unit-less
capabilities relative to other CPUs in the system. These capabilities have
a range of [0-255] where higher numbers represent higher capabilities.
Energy efficiency and performance are reported in separate capabilities.
If either the performance or energy capabilities efficiency of a CPU are 0,
the hardware recommends to not schedule any tasks on such CPU for
performance, energy efficiency or thermal reasons, respectively.

The kernel or user space may use the information from the HFI to modify
task placement and/or adjust power limits. This patchset focuses on the
user space. The thermal notification framework is extended to relay
updates of CPU capacity. Thus, a userspace daemon can affinitize workloads
to certain CPUs and/or offline CPUs whose capabilities are zero.

The frequency of HFI updates is specific to each processor model. On some
systems, there is just a single HFI update at boot. On other systems, there
may be updates every tens of milliseconds. In order to not overwhelm
userspace with too many updates, they are limited to one update every
CONFIG_HZ jiffies.

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/lkml/20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/lkml/20211220151438.1196-1-ricardo.neri-calderon@linux.intel.com/
[3]. https://lore.kernel.org/lkml/20220106025059.25847-8-ricardo.neri-calderon@linux.intel.com/
[4]. https://lore.kernel.org/lkml/20220108034743.31277-1-ricardo.neri-calderon@linux.intel.com/
[5]. https://www.intel.com/sdm

Changes since v4:
 ++ Unchanged patches: 1, 2.
 * Reworded description hfi_instance::hdr and hfi_instance::data.
   (Patch 3; Srinivas)
 * Call intel_hfi_online() before enabling the thermal vector at the
   local APIC is enabled. This makes sure that a CPU has an associated
   HFI instance when an HFI event happens. Reworded the commit message to
   reflect this change. (Patch 4; Srinivas)
 * Set hfi_instances to NULL if we fail to allocate memory for
   hfi_instance::cpus. (Patch 4; Srinivas)
 * Delayed initialization of local variables until after the check for a
   non-NULL hfi_instances in intel_hfi_online(). (Patch 4; Srinivas)
 * Optimized the error path in init_hfi_init() to not needlessly
   free the memory of cpumasks that have not been allocated. (Patch 4;
   Srinivas)
 * Removed pointless checks for X86_FEATURE_HFI in
   intel_hfi_[on|off]line(). It is sufficient to check for a non-NULL
   hfi_instances or a CPU's hfi_instance. (Patch 4)
 * Added a dedicated (i.e., not system_wq) workqueue to process HFI updates.
   Reworded commit message accordingly. (Patch 5; Rafael)
 * Repurposed comment on possibly receiving an HFI event with a NULL
   hfi_cpu_info::instance. Patch 4 fixed this potential issue. Instead,
   add a debug statement. (Patch 5; Srinivas)
 * Wrapped check for NULL hfi_cpu_info::instance in the unlikely macro.
   (Patch 5; Srinivas)
 * Renamed struct cpu_capability as struct thermal_genl_cpu_caps.
   (Patch 6; Rafael)
 * Removed automatic variable ret from
   thermal_genl_event_cpu_capability_change() and instead always return
   -EMSGSIZE on error. (Patch 6; Rafael)
 * Reworked parsing of HFI capabilities into chunks of
   HFI_MAX_THERM_NOTIFY_COUNT CPUs at a time to reduce the time
   we spend with interrupts disabled. (Patch7; Srinivas)
 * Protected hfi_instance::cpus when iterating over them. (Patch 7;
   Rafael)
 
Changes since v3:
 ++ Unchanged patches: 1, 2, 3, 5, 6, 7.
 * Corrected bug when initializing a CPU's HFI instance in
   intel_hfi_online(). (Patch 4)

Changes since v2:
 ++ Unchanged patches: 1, 6, 7.
 * Replaced subject prefix to be "x86/cpu:". (Patch 2; Boris)
 * Rename the INTEL_HFI Kconfig option as INTEL_HFI_THERMAL to reflect
   better the nature of the feature. (Patch 3; Rafael)
 * Removed hfi_instance::initialized. Instead, use hfi_instance::
   hdr to determine if the instance has been initialized. (Patch 4; Rafael)
 * Renamed hfi_lock as hfi_instance_lock to reflect the fact that it is
   used to protect accesses to HFI instances. (Patch 4; Rafael)
 * Removed unnecessary locking when linking a CPU to an HFI instance
   in intel_hfi_online(). (Patch 4; Rafael)
 * Unconditionally link the hfi_instance of a package/die to CPUs in
   the same package in intel_hfi_online(). Initialization is taken care
   of separately. (Patch 4)
 * Improved locking in error paths in intel_hfi_online(). (Patch 4; Rafael)
 * Removed a pointless check for NULL when taking a pointer of an element
   of hfi_instances. (Patch 4)
 * Added missing #include files. (Patches 3, 4, 5)

Changes since v1:
 ++ Unchanged patches: none
 * Clarified that HFI capabilities are independent. (Patch 1; Daniel)
 * Provided examples on changes reflected in the HFI table.
   (Patch 1; Daniel)
 * Renamed X86_FEATURE_INTEL_HFI as X86_FEATURE_HFI. (Patch 2, 3, 4, 5;
   Boris)
 * Reworked parsing of HFI features using bitfields instead of bitmasks.
   (Patch 3; PeterZ).
 * Removed hfi_instance::parsed. (Patch 3; Rafael)
 * Converted pr_err() to pr_debug(). (Patch 3; Srinivas, Rafael)
 * Removed unnecessary dependency on CONFIG_SCHED_MC. (Patch 3)
 * Renamed hfi_instance::ts_counter as hfi_instance::timestamp.
   (Patch 3)
 * Renamed hfi_instance::table_base as hfi_instance::local_table and
   relocated its definition to this patch. (Patch 3)
 * Wrapped hfi_instance::timestamp and hfi_instance:local_table in an
   anonymous union, since both point at the same location. (Patch 3)
 * Relocated definitions of MSR bits from intel_hfi.h to intel_hfi.c.
   (Patch 4)
 * Renamed HFI_PTR_VALID_BIT as HW_FEEDBACK_PTR_VALID_BIT for clarity.
   (Patch 4).
 * Reworked init_hfi_cpu_index() to take a pointer of type struct
   hfi_cpu_info. (Patch 4; Rafael)
 * In intel_hfi_online(), check for null hfi_instances and improve checks
   of the die_id. (Patch 4; Rafael)
 * Use a local cpumask_var_t to keep track of the CPUs of each
   hfi_instance. (Patch 4; Rafael)
 * Removed hfi_instance::die_id. It is not used anywhere. (Patch 4)
 * Renamed hfi_instance::table_base as hfi_instance::local_table for
   clarity. (Patch 4)
 * Repurposed hfi_instance::event_lock to handle HFI interrupt
   events to avoid keeping CPUs spinning needlessly. Added a new
   hfi_instance::table_lock to serialize access to an HFI table.
   (Patch 5; PeterZ)
 * Replaced raw_spin_[un]lock[restore|save]() with raw_spin_[un]lock().
   intel_hfi_process_event() runs in interrupt context and hence there
   is no need to save interrupt flags. (Patch 5)
 * Renamed HFI_CONFIG_ENABLE_BIT as HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT
   for clarity. (Patch 5)
 * Relaxed checks on timestamp to allow time wrap around. (Patch 5)
 * Reworded the members of struct cpu_capacity for clarity. (Patch 6;
   Lukasz)
 * Defined the CPU capability attributes to be scaled in the [0, 1023]
   interval. (Patch 6; Lukasz)
 * Made get_one_hfi_cap() return void. Removed unnecessary checks.
   (Patch 7; Rafael)
 * Replaced raw_spin_[un]lock_irq[restore|save]() with raw_spin_
   [un]lock_irq() in get_one_hfi_cap(). This function is only called from
   a workqueue and there is no need to save and restore irq flags.
 * Scaled performance and energy efficiency values to a [0, 1023] interval
   when reporting values to user space via thermal netlink notifications.
   (Patch 7; Lucasz).
 


Ricardo Neri (5):
  x86/Documentation: Describe the Intel Hardware Feedback Interface
  x86/cpu: Add definitions for the Intel Hardware Feedback Interface
  thermal: intel: hfi: Minimally initialize the Hardware Feedback
    Interface
  thermal: intel: hfi: Handle CPU hotplug events
  thermal: intel: hfi: Enable notification interrupt

Srinivas Pandruvada (2):
  thermal: netlink: Add a new event to notify CPU capabilities change
  thermal: intel: hfi: Notify user space for HFI events

 Documentation/x86/index.rst         |   1 +
 Documentation/x86/intel-hfi.rst     |  72 ++++
 arch/x86/include/asm/cpufeatures.h  |   1 +
 arch/x86/include/asm/msr-index.h    |   6 +
 drivers/thermal/intel/Kconfig       |  13 +
 drivers/thermal/intel/Makefile      |   1 +
 drivers/thermal/intel/intel_hfi.c   | 569 ++++++++++++++++++++++++++++
 drivers/thermal/intel/intel_hfi.h   |  17 +
 drivers/thermal/intel/therm_throt.c |  22 ++
 drivers/thermal/thermal_netlink.c   |  53 +++
 drivers/thermal/thermal_netlink.h   |  14 +
 include/uapi/linux/thermal.h        |   6 +-
 12 files changed, 774 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/x86/intel-hfi.rst
 create mode 100644 drivers/thermal/intel/intel_hfi.c
 create mode 100644 drivers/thermal/intel/intel_hfi.h

-- 
2.17.1

