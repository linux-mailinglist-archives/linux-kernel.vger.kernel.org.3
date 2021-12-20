Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A79747B002
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbhLTPXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:23:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:58457 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238549AbhLTPWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:22:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="237732819"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="237732819"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 07:16:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="484086897"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 20 Dec 2021 07:16:05 -0800
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
Subject: [PATCH v2 2/7] x86: Add definitions for the Intel Hardware Feedback Interface
Date:   Mon, 20 Dec 2021 07:14:33 -0800
Message-Id: <20211220151438.1196-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220151438.1196-1-ricardo.neri-calderon@linux.intel.com>
References: <20211220151438.1196-1-ricardo.neri-calderon@linux.intel.com>
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
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v1:
  * Renamed X86_FEATURE_INTEL_HFI as X86_FEATURE_HFI. (Boris)
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/msr-index.h   | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d5b5f2ab87a0..1a31b3ef15f0 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -327,6 +327,7 @@
 #define X86_FEATURE_HWP_ACT_WINDOW	(14*32+ 9) /* HWP Activity Window */
 #define X86_FEATURE_HWP_EPP		(14*32+10) /* HWP Energy Perf. Preference */
 #define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* HWP Package Level Request */
+#define X86_FEATURE_HFI			(14*32+19) /* Hardware Feedback Interface */
 
 /* AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15 */
 #define X86_FEATURE_NPT			(15*32+ 0) /* Nested Page Table support */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 01e2650b9585..ad958a49b2bb 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -687,12 +687,14 @@
 
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
@@ -941,4 +943,8 @@
 #define MSR_VM_IGNNE                    0xc0010115
 #define MSR_VM_HSAVE_PA                 0xc0010117
 
+/* Hardware Feedback Interface */
+#define MSR_IA32_HW_FEEDBACK_PTR        0x17d0
+#define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
+
 #endif /* _ASM_X86_MSR_INDEX_H */
-- 
2.17.1

