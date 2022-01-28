Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3FB49F31F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346209AbiA1Fog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:44:36 -0500
Received: from foss.arm.com ([217.140.110.172]:49560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233798AbiA1Fob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:44:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25BED12FC;
        Thu, 27 Jan 2022 21:44:31 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.44.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7BE3D3F766;
        Thu, 27 Jan 2022 21:44:25 -0800 (PST)
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
Subject: [PATCH 2/2] perf: Expand perf_branch_entry.type
Date:   Fri, 28 Jan 2022 11:14:13 +0530
Message-Id: <1643348653-24367-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643348653-24367-1-git-send-email-anshuman.khandual@arm.com>
References: <1643348653-24367-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current perf_branch_entry.type is a 4 bits field just enough to accommodate
16 generic branch types. This is insufficient to accommodate platforms like
arm64 which has much more branch types. Lets just expands this field into a
6 bits one, which can now hold 64 generic branch types. This also adds more
generic branch types.

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
 include/uapi/linux/perf_event.h       | 10 ++++++++--
 tools/include/uapi/linux/perf_event.h | 10 ++++++++--
 tools/perf/util/branch.c              |  8 +++++++-
 tools/perf/util/branch.h              |  4 ++--
 4 files changed, 25 insertions(+), 7 deletions(-)

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
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 17b2ccc61094..875d99abdc36 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -23,8 +23,8 @@ struct branch_flags {
 			u64 in_tx:1;
 			u64 abort:1;
 			u64 cycles:16;
-			u64 type:4;
-			u64 reserved:40;
+			u64 type:6;
+			u64 reserved:38;
 		};
 	};
 };
-- 
2.25.1

