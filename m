Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3477497837
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiAXEdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:33:06 -0500
Received: from foss.arm.com ([217.140.110.172]:47326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbiAXEdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:33:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6859711B3;
        Sun, 23 Jan 2022 20:33:04 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.119.34.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 168A93F73B;
        Sun, 23 Jan 2022 20:32:55 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC V1 11/11] perf: Capture branch privilege information
Date:   Mon, 24 Jan 2022 10:00:53 +0530
Message-Id: <1642998653-21377-12-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platforms like arm64 could capture privilege level information for all the
branch records. Hence this adds a new element in the struct branch_entry to
record the privilege level information, which could be requested through a
new event.attr.branch_sample_type flag PERF_SAMPLE_BRANCH_PRIV_SAVE. While
here, update the BRBE driver as required.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_pmu_brbe.c              | 28 ++++++++++++++++++++++++
 include/linux/perf_event.h               |  5 +++++
 include/uapi/linux/perf_event.h          | 13 ++++++++++-
 tools/include/uapi/linux/perf_event.h    | 13 ++++++++++-
 tools/perf/Documentation/perf-record.txt |  1 +
 tools/perf/util/parse-branch-options.c   |  1 +
 6 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmu_brbe.c b/drivers/perf/arm_pmu_brbe.c
index 7cd1208c6c58..d4cbea74c148 100644
--- a/drivers/perf/arm_pmu_brbe.c
+++ b/drivers/perf/arm_pmu_brbe.c
@@ -270,6 +270,25 @@ static int brbe_fetch_perf_type(u64 brbinf)
 	}
 }
 
+static int brbe_fetch_perf_priv(u64 brbinf)
+{
+	int brbe_el = brbe_fetch_el(brbinf);
+
+	switch (brbe_el) {
+	case BRBINF_EL_EL0:
+		return PERF_BR_USER;
+	case BRBINF_EL_EL1:
+		return PERF_BR_KERNEL;
+	case BRBINF_EL_EL2:
+		if (is_kernel_in_hyp_mode())
+			return PERF_BR_KERNEL;
+		return PERF_BR_HV;
+	default:
+		pr_warn("unknown branch privilege captured\n");
+		return -1;
+	}
+}
+
 static void capture_brbe_flags(struct pmu_hw_events *cpuc, struct perf_event *event,
 			       u64 brbinf, int idx)
 {
@@ -302,6 +321,15 @@ static void capture_brbe_flags(struct pmu_hw_events *cpuc, struct perf_event *ev
 			cpuc->brbe_entries[idx].in_tx = brbinf & BRBINF_TX;
 		}
 	}
+
+	if (branch_sample_priv(event)) {
+		/*
+		 * All these information (i.e branch privilege level) are not
+		 * available for source only branch records.
+		 */
+		if (type != BRBINF_VALID_SOURCE)
+			cpuc->brbe_entries[idx].priv = brbe_fetch_perf_priv(brbinf);
+	}
 }
 
 /*
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 916ce5102b33..8021b6a30d86 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1688,4 +1688,9 @@ static inline bool branch_sample_hw_index(const struct perf_event *event)
 {
 	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
 }
+
+static inline bool branch_sample_priv(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;
+}
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 361fdc6b87a0..4d77710f7a4e 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -204,6 +204,8 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT	= 17, /* save low level index of raw branch records */
 
+	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privillege mode */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -233,6 +235,8 @@ enum perf_branch_sample_type {
 
 	PERF_SAMPLE_BRANCH_HW_INDEX	= 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
 
+	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
@@ -265,6 +269,12 @@ enum {
 	PERF_BR_MAX,
 };
 
+enum {
+	PERF_BR_USER	= 0,
+	PERF_BR_KERNEL	= 1,
+	PERF_BR_HV	= 2,
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -1377,7 +1387,8 @@ struct perf_branch_entry {
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
 		type:6,     /* branch type */
-		reserved:38;
+		priv:2,     /* privilege level */
+		reserved:36;
 };
 
 union perf_sample_weight {
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 9a82b8aaed93..a2208400b0b9 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -204,6 +204,8 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT	= 17, /* save low level index of raw branch records */
 
+	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privillege mode */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -233,6 +235,8 @@ enum perf_branch_sample_type {
 
 	PERF_SAMPLE_BRANCH_HW_INDEX	= 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
 
+	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
@@ -265,6 +269,12 @@ enum {
 	PERF_BR_MAX,
 };
 
+enum {
+	PERF_BR_USER    = 0,
+	PERF_BR_KERNEL  = 1,
+	PERF_BR_HV      = 2,
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -1377,7 +1387,8 @@ struct perf_branch_entry {
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
 		type:6,     /* branch type */
-		reserved:38;
+		priv:2,     /* privilege level */
+		reserved:36;
 };
 
 union perf_sample_weight {
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 9ccc75935bc5..3e33686977a1 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -387,6 +387,7 @@ following filters are defined:
 	- abort_tx: only when the target is a hardware transaction abort
 	- cond: conditional branches
 	- save_type: save branch type during sampling in case binary is not available later
+	- priv: save privilege state during sampling in case binary is not available later
 
 +
 The option requires at least one branch type among any, any_call, any_ret, ind_call, cond.
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index bb4aa88c50a8..00588b9db474 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -32,6 +32,7 @@ static const struct branch_mode branch_modes[] = {
 	BRANCH_OPT("call", PERF_SAMPLE_BRANCH_CALL),
 	BRANCH_OPT("save_type", PERF_SAMPLE_BRANCH_TYPE_SAVE),
 	BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
+	BRANCH_OPT("priv", PERF_SAMPLE_BRANCH_PRIV_SAVE),
 	BRANCH_END
 };
 
-- 
2.25.1

