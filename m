Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AE2497835
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbiAXEcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:32:50 -0500
Received: from foss.arm.com ([217.140.110.172]:47274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241478AbiAXEcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:32:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11B57ED1;
        Sun, 23 Jan 2022 20:32:46 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.119.34.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C72773F73B;
        Sun, 23 Jan 2022 20:32:36 -0800 (PST)
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
Subject: [RFC V1 09/11] perf: Add more generic branch types
Date:   Mon, 24 Jan 2022 10:00:51 +0530
Message-Id: <1642998653-21377-10-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This expands generic branch type classification by adding some more entries
, that can still be represented with the existing 4 bit 'type' field. While
here this also updates the x86 implementation with these new branch types.

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
 arch/x86/events/intel/lbr.c           |  4 ++--
 drivers/perf/arm_pmu_brbe.c           | 11 +++++++----
 include/uapi/linux/perf_event.h       |  5 +++++
 tools/include/uapi/linux/perf_event.h |  5 +++++
 tools/perf/util/branch.c              |  7 ++++++-
 5 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8043213b75a5..9f86fac8c6a5 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1336,10 +1336,10 @@ static int branch_map[X86_BR_TYPE_MAP_MAX] = {
 	PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
 	PERF_BR_SYSRET,		/* X86_BR_SYSRET */
 	PERF_BR_UNKNOWN,	/* X86_BR_INT */
-	PERF_BR_UNKNOWN,	/* X86_BR_IRET */
+	PERF_BR_EXPT_RET,	/* X86_BR_IRET */
 	PERF_BR_COND,		/* X86_BR_JCC */
 	PERF_BR_UNCOND,		/* X86_BR_JMP */
-	PERF_BR_UNKNOWN,	/* X86_BR_IRQ */
+	PERF_BR_IRQ,		/* X86_BR_IRQ */
 	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
 	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
 	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
diff --git a/drivers/perf/arm_pmu_brbe.c b/drivers/perf/arm_pmu_brbe.c
index 8144514b9997..8d27ad868359 100644
--- a/drivers/perf/arm_pmu_brbe.c
+++ b/drivers/perf/arm_pmu_brbe.c
@@ -243,18 +243,21 @@ static int brbe_fetch_perf_type(u64 brbinf)
 	case BRBINF_TYPE_TRAP:
 		return PERF_BR_SYSCALL;
 	case BRBINF_TYPE_RET_EXCPT:
-		return PERF_BR_UNKNOWN;
+		return PERF_BR_EXPT_RET;
 	case BRBINF_TYPE_IRQ:
-		return PERF_BR_UNKNOWN;
+		return PERF_BR_IRQ;
+	case BRBINF_TYPE_FIQ:
+		return PERF_BR_FIQ;
 	case BRBINF_TYPE_DEBUG_HALT:
+		return PERF_BR_DEBUG_HALT;
+	case BRBINF_TYPE_DEBUG_EXIT:
+		return PERF_BR_DEBUG_EXIT;
 	case BRBINF_TYPE_SERROR:
 	case BRBINF_TYPE_INST_DEBUG:
 	case BRBINF_TYPE_DATA_DEBUG:
 	case BRBINF_TYPE_ALGN_FAULT:
 	case BRBINF_TYPE_INST_FAULT:
 	case BRBINF_TYPE_DATA_FAULT:
-	case BRBINF_TYPE_FIQ:
-	case BRBINF_TYPE_DEBUG_EXIT:
 		return PERF_BR_UNKNOWN;
 	default:
 		pr_warn("unknown branch type captured\n");
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 1b65042ab1db..b91d0f575d0c 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -251,6 +251,11 @@ enum {
 	PERF_BR_SYSRET		= 8,	/* syscall return */
 	PERF_BR_COND_CALL	= 9,	/* conditional function call */
 	PERF_BR_COND_RET	= 10,	/* conditional function return */
+	PERF_BR_EXPT_RET	= 11,	/* exception return */
+	PERF_BR_IRQ		= 12,	/* irq */
+	PERF_BR_FIQ		= 13,	/* fiq */
+	PERF_BR_DEBUG_HALT	= 14,	/* debug halt */
+	PERF_BR_DEBUG_EXIT	= 15,	/* debug exit */
 	PERF_BR_MAX,
 };
 
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 4cd39aaccbe7..1882054e8684 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -251,6 +251,11 @@ enum {
 	PERF_BR_SYSRET		= 8,	/* syscall return */
 	PERF_BR_COND_CALL	= 9,	/* conditional function call */
 	PERF_BR_COND_RET	= 10,	/* conditional function return */
+	PERF_BR_EXPT_RET	= 11,	/* exception return */
+	PERF_BR_IRQ		= 12,	/* irq */
+	PERF_BR_FIQ		= 13,	/* fiq */
+	PERF_BR_DEBUG_HALT	= 14,	/* debug halt */
+	PERF_BR_DEBUG_EXIT	= 15,	/* debug exit */
 	PERF_BR_MAX,
 };
 
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 2285b1eb3128..74e5e67b1779 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -49,7 +49,12 @@ const char *branch_type_name(int type)
 		"SYSCALL",
 		"SYSRET",
 		"COND_CALL",
-		"COND_RET"
+		"COND_RET",
+		"EXPT_RET",
+		"IRQ",
+		"FIQ",
+		"DEBUG_HALT",
+		"DEBUG_EXIT"
 	};
 
 	if (type >= 0 && type < PERF_BR_MAX)
-- 
2.25.1

