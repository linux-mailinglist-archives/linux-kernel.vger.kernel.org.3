Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A23847AFFD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbhLTPXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:23:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:58453 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238378AbhLTPWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:22:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="237732815"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="237732815"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 07:16:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="484086887"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 20 Dec 2021 07:16:04 -0800
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
Subject: [PATCH v2 0/7] Thermal: Introduce the Hardware Feedback Interface for thermal and performance management
Date:   Mon, 20 Dec 2021 07:14:31 -0800
Message-Id: <20211220151438.1196-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v2 of this patchset after having incorporated the feedback from
reviewers. Please find v1 here [1].

The Intel Hardware Feedback Interface (HFI) [2] provides information about
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
[2]. https://www.intel.com/sdm

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
  x86: Add definitions for the Intel Hardware Feedback Interface
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
 drivers/thermal/intel/intel_hfi.c   | 533 ++++++++++++++++++++++++++++
 drivers/thermal/intel/intel_hfi.h   |  17 +
 drivers/thermal/intel/therm_throt.c |  21 ++
 drivers/thermal/thermal_netlink.c   |  55 +++
 drivers/thermal/thermal_netlink.h   |  13 +
 include/uapi/linux/thermal.h        |   6 +-
 12 files changed, 738 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/x86/intel-hfi.rst
 create mode 100644 drivers/thermal/intel/intel_hfi.c
 create mode 100644 drivers/thermal/intel/intel_hfi.h

-- 
2.17.1

