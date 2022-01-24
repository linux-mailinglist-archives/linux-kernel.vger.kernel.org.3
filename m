Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADC3497836
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbiAXEdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:33:00 -0500
Received: from foss.arm.com ([217.140.110.172]:47302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241457AbiAXEcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:32:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A557113E;
        Sun, 23 Jan 2022 20:32:55 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.119.34.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B40C23F73B;
        Sun, 23 Jan 2022 20:32:46 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC V1 10/11] perf: Expand perf_branch_entry.type
Date:   Mon, 24 Jan 2022 10:00:52 +0530
Message-Id: <1642998653-21377-11-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current perf_branch_entry.type is a 4 bits field just enough to accommodate
16 generic branch types. This is insufficient to accommodate platforms like
arm64 which has much more branch types. Lets just expands this field into a
6 bits one, which can now hold 64 generic branch types. This also adds more
generic branch types and updates the BRBE driver as required.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_pmu_brbe.c           |  7 ++++++-
 include/uapi/linux/perf_event.h       | 10 ++++++++--
 tools/include/uapi/linux/perf_event.h | 10 ++++++++--
 tools/perf/util/branch.c              |  8 +++++++-
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_pmu_brbe.c b/drivers/perf/arm_pmu_brbe.c
index 8d27ad868359..7cd1208c6c58 100644
--- a/drivers/perf/arm_pmu_brbe.c
+++ b/drivers/perf/arm_pmu_brbe.c
@@ -253,12 +253,17 @@ static int brbe_fetch_perf_type(u64 brbinf)
 	case BRBINF_TYPE_DEBUG_EXIT:
 		return PERF_BR_DEBUG_EXIT;
 	case BRBINF_TYPE_SERROR:
+		return PERF_BR_SERROR;
 	case BRBINF_TYPE_INST_DEBUG:
+		return PERF_BR_DEBUG_INST;
 	case BRBINF_TYPE_DATA_DEBUG:
+		return PERF_BR_DEBUG_DATA;
 	case BRBINF_TYPE_ALGN_FAULT:
+		return PERF_BR_FAULT_ALGN;
 	case BRBINF_TYPE_INST_FAULT:
+		return PERF_BR_FAULT_INST;
 	case BRBINF_TYPE_DATA_FAULT:
-		return PERF_BR_UNKNOWN;
+		return PERF_BR_FAULT_DATA;
 	default:
 		pr_warn("unknown branch type captured\n");
 		return PERF_BR_UNKNOWN;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b91d0f575d0c..361fdc6b87a0 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -256,6 +256,12 @@ enum {
 	PERF_BR_FIQ		= 13,	/* fiq */
 	PERF_BR_DEBUG_HALT	= 14,	/* debug halt */
 	PERF_BR_DEBUG_EXIT	= 15,	/* debug exit */
+	PERF_BR_DEBUG_INST	= 16,	/* instruciton debug */
+	PERF_BR_DEBUG_DATA	= 17,	/* data debug */
+	PERF_BR_FAULT_ALGN	= 18,	/* alignment fault */
+	PERF_BR_FAULT_DATA	= 19,	/* data fault */
+	PERF_BR_FAULT_INST	= 20,	/* instruction fault */
+	PERF_BR_SERROR		= 21,	/* system error */
 	PERF_BR_MAX,
 };
 
@@ -1370,8 +1376,8 @@ struct perf_branch_entry {
 		in_tx:1,    /* in transaction */
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
-		type:4,     /* branch type */
-		reserved:40;
+		type:6,     /* branch type */
+		reserved:38;
 };
 
 union perf_sample_weight {
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 1882054e8684..9a82b8aaed93 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -256,6 +256,12 @@ enum {
 	PERF_BR_FIQ		= 13,	/* fiq */
 	PERF_BR_DEBUG_HALT	= 14,	/* debug halt */
 	PERF_BR_DEBUG_EXIT	= 15,	/* debug exit */
+	PERF_BR_DEBUG_INST	= 16,	/* instruciton debug */
+	PERF_BR_DEBUG_DATA	= 17,	/* data debug */
+	PERF_BR_FAULT_ALGN	= 18,	/* alignment fault */
+	PERF_BR_FAULT_DATA	= 19,	/* data fault */
+	PERF_BR_FAULT_INST	= 20,	/* instruction fault */
+	PERF_BR_SERROR		= 21,	/* system error */
 	PERF_BR_MAX,
 };
 
@@ -1370,8 +1376,8 @@ struct perf_branch_entry {
 		in_tx:1,    /* in transaction */
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
-		type:4,     /* branch type */
-		reserved:40;
+		type:6,     /* branch type */
+		reserved:38;
 };
 
 union perf_sample_weight {
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 74e5e67b1779..1e216ea2e2a8 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -54,7 +54,13 @@ const char *branch_type_name(int type)
 		"IRQ",
 		"FIQ",
 		"DEBUG_HALT",
-		"DEBUG_EXIT"
+		"DEBUG_EXIT",
+		"DEBUG_INST",
+		"DEBUG_DATA",
+		"FAULT_ALGN",
+		"FAULT_DATA",
+		"FAULT_INST",
+		"SERROR"
 	};
 
 	if (type >= 0 && type < PERF_BR_MAX)
-- 
2.25.1

