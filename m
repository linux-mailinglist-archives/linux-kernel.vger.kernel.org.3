Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E916E4A8659
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351356AbiBCOdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351255AbiBCOdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1009C06173D;
        Thu,  3 Feb 2022 06:33:28 -0800 (PST)
Date:   Thu, 03 Feb 2022 14:33:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HT14HuhGCyRztC/jLqSJDtWvRkIQmRDoajpEtKu27yA=;
        b=Nw245KOI2KOsm56VYgaBg8ryGObxi/7Ph9QWBHGMMXCHi7q8MsnW468ybUVPrxTZT1z4Nz
        dASIdP8XUYrdYuWRHexLq9V+gelESWMSsEL8fhttV/LA8SdGp47s0mOkuercbaLPkUjrw9
        WKtIfyx8KY1hCVVfXRzBRa65rOgfj3bgmL/gU1+VRV2lzlvVcaGa5y97fqiVsCNiND/Rqg
        g4UbPb37ooAgjGC+0jmyPZ9H+mD0bJOtDFQ1Ry3w6nkTyw38dnXRdX/B5Nofyk7/HYHpka
        WcoBleo7719JtwvFsOc6Tb40BGwEDbhyWKPGb2gA0Rrp/yvPp2ZRhCuI3mAECA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HT14HuhGCyRztC/jLqSJDtWvRkIQmRDoajpEtKu27yA=;
        b=kZj76hgSukAiQgD8bsnCy+itgFrO7kfiFalO24otzNH5+Vao5QBTqAMxotKfRy5Beltkb2
        5LTdZvgUHwvcp5CA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Increase max number of the fixed counters
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1643750603-100733-3-git-send-email-kan.liang@linux.intel.com>
References: <1643750603-100733-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164389880492.16921.3490541855090565957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ee28855a54493ce83bc2a3fbe30210be61b57bc7
Gitweb:        https://git.kernel.org/tip/ee28855a54493ce83bc2a3fbe30210be61b57bc7
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 01 Feb 2022 13:23:23 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:44 +01:00

perf/x86/intel: Increase max number of the fixed counters

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

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1643750603-100733-3-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c      | 40 +++++++++++++++++++++++++++++-
 arch/x86/include/asm/perf_event.h |  2 +-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c914340..88dcfb4 100644
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
@@ -6295,7 +6316,9 @@ __init int intel_pmu_init(void)
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
@@ -6303,6 +6326,21 @@ __init int intel_pmu_init(void)
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
