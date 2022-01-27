Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8631149EB15
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245601AbiA0TdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:33:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:47245 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231221AbiA0TdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643311986; x=1674847986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=d6aKRtAzjDjmJM2+973h3G8biktTSCUUKJusK0j5rXI=;
  b=CEQdM5q3cLq+z7jwiMXOvBPyGHTKGzI07nMK7u2zBHNAIC/q51WaWCGo
   huwx765yC6W5CCLP4XG7D09m5IHlzFJXPpxxwt6uVnSX/ERfXcm8XPMYV
   2U3eB1aTMvj4X9Xg5v2+Vl0Dqx+VBGV5LVr6nnlPyk+QrUxQhlIny6Bmn
   wyE+4xlwFDja3E4+0vWJEsIBiO33mU30RQcbGkSyHlrhfak2v5dYYWpie
   CYpE7ILdHQmtXZqBeNaKj8isWQ8rKkjxUhmVfowmAP1d8wCXFKpcvpMuN
   xpRz+qKBwfQwjFFdkLJVY0x88p0hGwLMq5yq+xo7olDjMoGCu7WnSq1yJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245788383"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="245788383"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 11:33:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="495844896"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2022 11:33:02 -0800
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
Subject: [PATCH v5 2/7] x86/cpu: Add definitions for the Intel Hardware Feedback Interface
Date:   Thu, 27 Jan 2022 11:34:49 -0800
Message-Id: <20220127193454.12814-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220127193454.12814-1-ricardo.neri-calderon@linux.intel.com>
References: <20220127193454.12814-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CPUID feature bit and the model-specific registers needed to
identify and configure the Intel Hardware Feedback Interface.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
  * None

Changes since v3:
  * None

Changes since v2:
  * Replaced subject prefix to be "x86/cpu:". (Boris)

Changes since v1:
  * Renamed X86_FEATURE_INTEL_HFI as X86_FEATURE_HFI. (Boris)
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/msr-index.h   | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6db4e2932b3d..b39f510128f3 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -330,6 +330,7 @@
 #define X86_FEATURE_HWP_ACT_WINDOW	(14*32+ 9) /* HWP Activity Window */
 #define X86_FEATURE_HWP_EPP		(14*32+10) /* HWP Energy Perf. Preference */
 #define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* HWP Package Level Request */
+#define X86_FEATURE_HFI			(14*32+19) /* Hardware Feedback Interface */
 
 /* AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15 */
 #define X86_FEATURE_NPT			(15*32+ 0) /* Nested Page Table support */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3faf0f97edb1..89e0a1d5ee36 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -704,12 +704,14 @@
 
 #define PACKAGE_THERM_STATUS_PROCHOT		(1 << 0)
 #define PACKAGE_THERM_STATUS_POWER_LIMIT	(1 << 10)
+#define PACKAGE_THERM_STATUS_HFI_UPDATED	(1 << 26)
 
 #define MSR_IA32_PACKAGE_THERM_INTERRUPT	0x000001b2
 
 #define PACKAGE_THERM_INT_HIGH_ENABLE		(1 << 0)
 #define PACKAGE_THERM_INT_LOW_ENABLE		(1 << 1)
 #define PACKAGE_THERM_INT_PLN_ENABLE		(1 << 24)
+#define PACKAGE_THERM_INT_HFI_ENABLE		(1 << 25)
 
 /* Thermal Thresholds Support */
 #define THERM_INT_THRESHOLD0_ENABLE    (1 << 15)
@@ -958,4 +960,8 @@
 #define MSR_VM_IGNNE                    0xc0010115
 #define MSR_VM_HSAVE_PA                 0xc0010117
 
+/* Hardware Feedback Interface */
+#define MSR_IA32_HW_FEEDBACK_PTR        0x17d0
+#define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
+
 #endif /* _ASM_X86_MSR_INDEX_H */
-- 
2.17.1

