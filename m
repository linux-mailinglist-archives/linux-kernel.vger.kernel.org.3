Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1747488128
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 04:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiAHDqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 22:46:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:16918 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230398AbiAHDqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 22:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641613560; x=1673149560;
  h=from:to:cc:subject:date:message-id;
  bh=mkOlSzeJ7+2yBRdjidaEaLPbDCRYlID8MXMhk0fjC6c=;
  b=JabsQRNySsihNM5+fqGRxQN7nJa+A7sbKxEhaFPLv+H+Dkp1LiNUyJZv
   vohtH2g1c2C3SupyRYlezOTE1rmtV2YyXhwav1aMqmBoaoxCqVc1CET3G
   3zegIcrJglpG7e+WkagS/V88rkLm5eADv0JTrefITcJPqQjivllIMw03a
   y4XJh02l1Jwa5mefnjNOqbKOY8pTjs+Lt+r2MVQkkytqt7Pyp7mktk0vd
   YzmX58k6gZqNilqzLo5ZPcUvk0VhkisUE39YsUNj/VmHPvzZhpvvtLw84
   XSj7BIfEZ0p/e+Kvb2H45Dwo0s3bXctPZ00hsh83AlueoBNPC0V6XOXxw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="242780995"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="242780995"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 19:45:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="514024463"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 07 Jan 2022 19:45:58 -0800
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
Subject: [PATCH v4 0/7] Thermal: Introduce the Hardware Feedback Interface for thermal and performance management 
Date:   Fri,  7 Jan 2022 19:47:35 -0800
Message-Id: <20220108034743.31277-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a very obvious bug in v3 after I posted it. Thus, I decided to post
a v4 fixing it. It only impacts Patch 4. Please see the change log for
details. You can find v1, v2, and v3 in [1], [2], and [3], respectively.

The Intel Hardware Feedback Interface (HFI) [4] provides information about
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
[4]. https://www.intel.com/sdm

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
 drivers/thermal/intel/intel_hfi.c   | 543 ++++++++++++++++++++++++++++
 drivers/thermal/intel/intel_hfi.h   |  17 +
 drivers/thermal/intel/therm_throt.c |  21 ++
 drivers/thermal/thermal_netlink.c   |  55 +++
 drivers/thermal/thermal_netlink.h   |  13 +
 include/uapi/linux/thermal.h        |   6 +-
 12 files changed, 748 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/x86/intel-hfi.rst
 create mode 100644 drivers/thermal/intel/intel_hfi.c
 create mode 100644 drivers/thermal/intel/intel_hfi.h

-- 
2.17.1

