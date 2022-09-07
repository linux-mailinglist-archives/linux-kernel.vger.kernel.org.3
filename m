Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB005B0035
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiIGJUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiIGJT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:19:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 851EB1A393;
        Wed,  7 Sep 2022 02:19:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B759D6E;
        Wed,  7 Sep 2022 02:19:59 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE44E3F73D;
        Wed,  7 Sep 2022 02:20:16 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH V3 4/4] x86/perf: Assert all platform event flags are within PERF_EVENT_FLAG_ARCH
Date:   Wed,  7 Sep 2022 14:49:24 +0530
Message-Id: <20220907091924.439193-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907091924.439193-1-anshuman.khandual@arm.com>
References: <20220907091924.439193-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure all platform specific event flags are within PERF_EVENT_FLAG_ARCH.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/x86/events/perf_event.h       | 34 ++++++++++++++----------------
 arch/x86/events/perf_event_flags.h | 22 +++++++++++++++++++
 2 files changed, 38 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/events/perf_event_flags.h

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ba3d24a6a4ec..60cf8132e1e1 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -64,27 +64,25 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 	return ((ecode & c->cmask) - c->code) <= (u64)c->size;
 }
 
+#define PERF_ARCH(name, val)	\
+	PERF_X86_EVENT_##name = val,
+
 /*
  * struct hw_perf_event.flags flags
  */
-#define PERF_X86_EVENT_PEBS_LDLAT	0x00001 /* ld+ldlat data address sampling */
-#define PERF_X86_EVENT_PEBS_ST		0x00002 /* st data address sampling */
-#define PERF_X86_EVENT_PEBS_ST_HSW	0x00004 /* haswell style datala, store */
-#define PERF_X86_EVENT_PEBS_LD_HSW	0x00008 /* haswell style datala, load */
-#define PERF_X86_EVENT_PEBS_NA_HSW	0x00010 /* haswell style datala, unknown */
-#define PERF_X86_EVENT_EXCL		0x00020 /* HT exclusivity on counter */
-#define PERF_X86_EVENT_DYNAMIC		0x00040 /* dynamic alloc'd constraint */
-
-#define PERF_X86_EVENT_EXCL_ACCT	0x00100 /* accounted EXCL event */
-#define PERF_X86_EVENT_AUTO_RELOAD	0x00200 /* use PEBS auto-reload */
-#define PERF_X86_EVENT_LARGE_PEBS	0x00400 /* use large PEBS */
-#define PERF_X86_EVENT_PEBS_VIA_PT	0x00800 /* use PT buffer for PEBS */
-#define PERF_X86_EVENT_PAIR		0x01000 /* Large Increment per Cycle */
-#define PERF_X86_EVENT_LBR_SELECT	0x02000 /* Save/Restore MSR_LBR_SELECT */
-#define PERF_X86_EVENT_TOPDOWN		0x04000 /* Count Topdown slots/metrics events */
-#define PERF_X86_EVENT_PEBS_STLAT	0x08000 /* st+stlat data address sampling */
-#define PERF_X86_EVENT_AMD_BRS		0x10000 /* AMD Branch Sampling */
-#define PERF_X86_EVENT_PEBS_LAT_HYBRID	0x20000 /* ld and st lat for hybrid */
+enum {
+#include "perf_event_flags.h"
+};
+
+#undef PERF_ARCH
+
+#define PERF_ARCH(name, val)						\
+	static_assert((PERF_X86_EVENT_##name & PERF_EVENT_FLAG_ARCH) ==	\
+		      PERF_X86_EVENT_##name);
+
+#include "perf_event_flags.h"
+
+#undef PERF_ARCH
 
 static inline bool is_topdown_count(struct perf_event *event)
 {
diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
new file mode 100644
index 000000000000..1dc19b9b4426
--- /dev/null
+++ b/arch/x86/events/perf_event_flags.h
@@ -0,0 +1,22 @@
+
+/*
+ * struct hw_perf_event.flags flags
+ */
+PERF_ARCH(PEBS_LDLAT,		0x00001) /* ld+ldlat data address sampling */
+PERF_ARCH(PEBS_ST,		0x00002) /* st data address sampling */
+PERF_ARCH(PEBS_ST_HSW,		0x00004) /* haswell style datala, store */
+PERF_ARCH(PEBS_LD_HSW,		0x00008) /* haswell style datala, load */
+PERF_ARCH(PEBS_NA_HSW,		0x00010) /* haswell style datala, unknown */
+PERF_ARCH(EXCL,			0x00020) /* HT exclusivity on counter */
+PERF_ARCH(DYNAMIC,		0x00040) /* dynamic alloc'd constraint */
+			/*	0x00080	*/
+PERF_ARCH(EXCL_ACCT,		0x00100) /* accounted EXCL event */
+PERF_ARCH(AUTO_RELOAD,		0x00200) /* use PEBS auto-reload */
+PERF_ARCH(LARGE_PEBS,		0x00400) /* use large PEBS */
+PERF_ARCH(PEBS_VIA_PT,		0x00800) /* use PT buffer for PEBS */
+PERF_ARCH(PAIR,			0x01000) /* Large Increment per Cycle */
+PERF_ARCH(LBR_SELECT,		0x02000) /* Save/Restore MSR_LBR_SELECT */
+PERF_ARCH(TOPDOWN,		0x04000) /* Count Topdown slots/metrics events */
+PERF_ARCH(PEBS_STLAT,		0x08000) /* st+stlat data address sampling */
+PERF_ARCH(AMD_BRS,		0x10000) /* AMD Branch Sampling */
+PERF_ARCH(PEBS_LAT_HYBRID,	0x20000) /* ld and st lat for hybrid */
-- 
2.25.1

