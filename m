Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF7F4A63C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiBAS0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:26:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:60474 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230476AbiBAS0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643739982; x=1675275982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vp2eV6YupVRo21s7LFcoDcoJ6iwIdXT9XTTytuTk23M=;
  b=Tep9xvkBpXhC+qDRcS5o0ycTkEio0GSflZH3O3jRXf4FRkOYnnaWLZN/
   G5W/zxnNVlWUHcvjjyRhSRF36U8wzhW4EwtQvJcn88Um+Y7iE2MPR6QUk
   VgyJJxQbitsYZBvipzvy9XUlm+sLK7aezZsEbII9OGV/pZj/TbYN1ehzt
   0BEV0CKL7m+d9jT2Joa19mi2ByyHbJP9M7faMaNvw3mGqqgjGyDb7M0t1
   dhArRR1dsIhgUuIVqxxJLk89aO1UqqBJUaBDv0zKyzbebM5Oz8IzBWGvv
   9c2SrsuVEgIK+fwnFQ3yHGNXHxQKXZaAeddHE7iHwAUMLKdFS394QsUB6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247527596"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="247527596"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 10:26:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="565681655"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga001.jf.intel.com with ESMTP; 01 Feb 2022 10:26:13 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/3] perf/x86/intel: Increase max number of the fixed counters
Date:   Tue,  1 Feb 2022 13:23:23 -0800
Message-Id: <1643750603-100733-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643750603-100733-1-git-send-email-kan.liang@linux.intel.com>
References: <1643750603-100733-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The new PEBS format 5 implies that the number of the fixed counters can
be up to 16. The current INTEL_PMC_MAX_FIXED is still 4. If the current
kernel runs on a future platform which has more than 4 fixed counters,
a warning will be triggered. The number of the fixed counters will be
clipped to 4. Users have to upgrade the kernel to access the new fixed
counters.

Add a new default constraint for PerfMon v5 and up, which can support
up to 16 fixed counters. The pseudo-encoding is applied for the fixed
counters 4 and later. The user can have generic support for the new
fixed counters on the future platfroms without updating the kernel.

Increase the INTEL_PMC_MAX_FIXED to 16.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 40 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/include/asm/perf_event.h |  2 +-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 46ac451..24a4a75 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -181,6 +181,27 @@ static struct event_constraint intel_gen_event_constraints[] __read_mostly =
 	EVENT_CONSTRAINT_END
 };
 
+static struct event_constraint intel_v5_gen_event_constraints[] __read_mostly =
+{
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x0400, 3), /* SLOTS */
+	FIXED_EVENT_CONSTRAINT(0x0500, 4),
+	FIXED_EVENT_CONSTRAINT(0x0600, 5),
+	FIXED_EVENT_CONSTRAINT(0x0700, 6),
+	FIXED_EVENT_CONSTRAINT(0x0800, 7),
+	FIXED_EVENT_CONSTRAINT(0x0900, 8),
+	FIXED_EVENT_CONSTRAINT(0x0a00, 9),
+	FIXED_EVENT_CONSTRAINT(0x0b00, 10),
+	FIXED_EVENT_CONSTRAINT(0x0c00, 11),
+	FIXED_EVENT_CONSTRAINT(0x0d00, 12),
+	FIXED_EVENT_CONSTRAINT(0x0e00, 13),
+	FIXED_EVENT_CONSTRAINT(0x0f00, 14),
+	FIXED_EVENT_CONSTRAINT(0x1000, 15),
+	EVENT_CONSTRAINT_END
+};
+
 static struct event_constraint intel_slm_event_constraints[] __read_mostly =
 {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
@@ -6296,7 +6317,9 @@ __init int intel_pmu_init(void)
 			pr_cont("generic architected perfmon v1, ");
 			name = "generic_arch_v1";
 			break;
-		default:
+		case 2:
+		case 3:
+		case 4:
 			/*
 			 * default constraints for v2 and up
 			 */
@@ -6304,6 +6327,21 @@ __init int intel_pmu_init(void)
 			pr_cont("generic architected perfmon, ");
 			name = "generic_arch_v2+";
 			break;
+		default:
+			/*
+			 * The default constraints for v5 and up can support up to
+			 * 16 fixed counters. For the fixed counters 4 and later,
+			 * the pseudo-encoding is applied.
+			 * The constraints may be cut according to the CPUID enumeration
+			 * by inserting the EVENT_CONSTRAINT_END.
+			 */
+			if (x86_pmu.num_counters_fixed > INTEL_PMC_MAX_FIXED)
+				x86_pmu.num_counters_fixed = INTEL_PMC_MAX_FIXED;
+			intel_v5_gen_event_constraints[x86_pmu.num_counters_fixed].weight = -1;
+			x86_pmu.event_constraints = intel_v5_gen_event_constraints;
+			pr_cont("generic architected perfmon, ");
+			name = "generic_arch_v5+";
+			break;
 		}
 	}
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc1b50..58d9e4b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -7,7 +7,7 @@
  */
 
 #define INTEL_PMC_MAX_GENERIC				       32
-#define INTEL_PMC_MAX_FIXED					4
+#define INTEL_PMC_MAX_FIXED				       16
 #define INTEL_PMC_IDX_FIXED				       32
 
 #define X86_PMC_IDX_MAX					       64
-- 
2.7.4

