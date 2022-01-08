Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A0848812E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 04:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiAHDqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 22:46:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:16918 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233436AbiAHDqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 22:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641613560; x=1673149560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=pJ/6du5kb0IMlov8I+rUH04a7uj8MeGhutZVL9o6qbI=;
  b=fg642PYu3Zva4Z0zw0io8c7RxdBd9mRAgDGCtgP5RtB/oG/P4CPfjw4K
   4Fke8vD9mhQIpmAAQGUE1UY9Lh2vITCpxDs7qBqS9OA05NcBaHrIql0QW
   cNfhCgCAthydxWpRWbhxb/RYX+ZdgRvCXZPBXBcD8VMyT/jcDFulns3uW
   OYmAKdUEk+BAJgz6JQEFAEytOLUyAkWbdfhI+cdt1F+BKhUn2c/EBUzam
   PfDrDLVKLFb3RvW6J18hNwQeDzVXBLV3F4URhCHDFDS0x4VIT+1InFpzr
   hnRqHrTzp6f3GH3DOAfV7Y2Bv+zVhfcVE9BywXyFEXBDtB9I2Uzck5Hqg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="242780997"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="242780997"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 19:45:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="514024466"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 07 Jan 2022 19:45:59 -0800
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
Subject: [PATCH v4 1/7] x86/Documentation: Describe the Intel Hardware Feedback Interface
Date:   Fri,  7 Jan 2022 19:47:36 -0800
Message-Id: <20220108034743.31277-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220108034743.31277-1-ricardo.neri-calderon@linux.intel.com>
References: <20220108034743.31277-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start a documentation file to describe the purpose and operation of Intel's
Hardware Feedback Interface. Describe how this interface is used in Linux
to relay performance and energy efficiency updates to userspace.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
  * None

Changes since v2:
  * None

Changes since v1:
  * Clarified that HFI capabilities are independent. (Daniel)
  * Provided examples on changes reflected in the HFI table. (Daniel)
---
 Documentation/x86/index.rst     |  1 +
 Documentation/x86/intel-hfi.rst | 72 +++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/x86/intel-hfi.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index f498f1d36cd3..982c8af853b9 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -21,6 +21,7 @@ x86-specific Documentation
    tlb
    mtrr
    pat
+   intel-hfi
    intel-iommu
    intel_txt
    amd-memory-encryption
diff --git a/Documentation/x86/intel-hfi.rst b/Documentation/x86/intel-hfi.rst
new file mode 100644
index 000000000000..49dea58ea4fb
--- /dev/null
+++ b/Documentation/x86/intel-hfi.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================================
+Hardware-Feedback Interface for scheduling on Intel Hardware
+============================================================
+
+Overview
+--------
+
+Intel has described the Hardware Feedback Interface (HFI) in the Intel 64 and
+IA-32 Architectures Software Developer's Manual (Intel SDM) Volume 3 Section
+14.6 [1]_.
+
+The HFI gives the operating system a performance and energy efficiency
+capability data for each CPU in the system. Linux can use the information from
+the HFI to influence task placement decisions.
+
+The Hardware Feedback Interface
+-------------------------------
+
+The Hardware Feedback Interface provides to the operating system information
+about the performance and energy efficiency of each CPU in the system. Each
+capability is given as a unit-less quantity in the range [0-255]. Higher values
+indicate higher capability. Energy efficiency and performance are reported in
+separate capabilities. Even though on some systems these two metrics may be
+related, they are specified as independent capabilities in the Intel SDM.
+
+These capabilities may change at runtime as a result of changes in the
+operating conditions of the system or the action of external factors. The rate
+at which these capabilities are updated is specific to each processor model. On
+some models, capabilities are set at boot time and never change. On others,
+capabilities may change every tens of milliseconds. For instance, a remote
+mechanism may be used to lower Thermal Design Power. Such change can be
+reflected in the HFI. Likewise, if the system needs to be throttled due to
+excessive heat, the HFI may reflect reduced performance on specific CPUs.
+
+The kernel or a userspace policy daemon can use these capabilities to modify
+task placement decisions. For instance, if either the performance or energy
+capabilities of a given logical processor becomes zero, it is an indication that
+the hardware recommends to the operating system to not schedule any tasks on
+that processor for performance or energy efficiency reasons, respectively.
+
+Implementation details for Linux
+--------------------------------
+
+The infrastructure to handle thermal event interrupts has two parts. In the
+Local Vector Table of a CPU's local APIC, there exists a register for the
+Thermal Monitor Register. This register controls how interrupts are delivered
+to a CPU when the thermal monitor generates and interrupt. Further details
+can be found in the Intel SDM Vol. 3 Section 10.5 [1]_.
+
+The thermal monitor may generate interrupts per CPU or per package. The HFI
+generates package-level interrupts. This monitor is configured and initialized
+via a set of machine-specific registers. Specifically, the HFI interrupt and
+status are controlled via designated bits in the IA32_PACKAGE_THERM_INTERRUPT
+and IA32_PACKAGE_THERM_STATUS registers, respectively. There exists one HFI
+table per package. Further details can be found in the Intel SDM Vol. 3
+Section 14.9 [1]_.
+
+The hardware issues an HFI interrupt after updating the HFI table and is ready
+for the operating system to consume it. CPUs receive such interrupt via the
+thermal entry in the Local APIC's Local Vector Table.
+
+When servicing such interrupt, the HFI driver parses the updated table and
+relays the update to userspace using the thermal notification framework. Given
+that there may be many HFI updates every second, the updates relayed to
+userspace are throttled at a rate of CONFIG_HZ jiffies.
+
+References
+----------
+
+.. [1] https://www.intel.com/sdm
-- 
2.17.1

