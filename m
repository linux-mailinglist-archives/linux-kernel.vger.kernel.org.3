Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F44649F31E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346194AbiA1Fo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:44:26 -0500
Received: from foss.arm.com ([217.140.110.172]:49540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346216AbiA1FoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:44:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABEEE113E;
        Thu, 27 Jan 2022 21:44:24 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.44.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D8D83F766;
        Thu, 27 Jan 2022 21:44:18 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 1/2] perf: Add more generic branch types
Date:   Fri, 28 Jan 2022 11:14:12 +0530
Message-Id: <1643348653-24367-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643348653-24367-1-git-send-email-anshuman.khandual@arm.com>
References: <1643348653-24367-1-git-send-email-anshuman.khandual@arm.com>
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
 arch/x86/events/intel/lbr.c           | 4 ++--
 include/uapi/linux/perf_event.h       | 5 +++++
 tools/include/uapi/linux/perf_event.h | 5 +++++
 tools/perf/util/branch.c              | 7 ++++++-
 4 files changed, 18 insertions(+), 3 deletions(-)

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

