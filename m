Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3A55A68C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiH3Qtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiH3Qto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:49:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F32B6D08
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:49:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n16-20020a258d10000000b0068df1e297c0so171834ybl.15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=UUVPQFoHB4SWNXVjnYdqps9D8vjoKXb+eUEK4kYsPDY=;
        b=COs46NUpjp4Yte74wDg1/odWFzJUV7jAt3zpJRCqIY02yX9ausfsQfvjUlbGQl3f02
         ItysQbeKJ0jGa1lQ62ak1VCH0ToVtRnVX2LXkSLPxGaV33UCDj3znT5TGIOMCvb7ETre
         ONrbfUylCSA5fU5v3NkZuF/GyNbBkz+bAmFHoDeHrZLyxrBwDIinQefO6c+lWHWtZs9X
         n+cvC6dwpeZMPIBNsYS/jwefRZJ64a2FMSpGJElTmJRPxwNONiJCx17oIrNcGgVjChd4
         a5t/85hiHyjUQHCmkt5K2OSlLAM50mke+1aSHuVsfwSvxpNVpzDdWvlJSHxDY2BJjYO+
         6I2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=UUVPQFoHB4SWNXVjnYdqps9D8vjoKXb+eUEK4kYsPDY=;
        b=LrqLcA2GRP2kk3ppx0Hnz7e2LYnA9476M+OhLkH0DuNFi+qIOwF3yC/vckFeLVrxOj
         cjGB9pvl9j4ZBNCq1nIMcZlFbvnEdSj0zeIW41fUo39IytoBZpnEZA/cKd5UIE4RLC8x
         TgkwjO6cvo3rZBNhc2wrx0RHPf2tz50nNaiV//YTqSSZhcvhV3bp1XdwucffQRVGQok1
         F0tzDt9X3GAGrH7u+RiEEWizkMPcIHhQfpMjaOD+lgIH1xK2P/YkcUcJSqRug8TztU3x
         koArbVJFwgy94lv7fDuN7n9XradFvSqji1gM5Dts89wiMXEoAfhLQpFEcIEp/mChejLs
         uaJw==
X-Gm-Message-State: ACgBeo2UODh6/4l3eMbCJVI8De3Gu0oDb43FJlVVtkfkw2epbNIMkMma
        WdksIYYsnrsVwim3dVySVqOlRUZsdiZm
X-Google-Smtp-Source: AA6agR6ejKKMnALfMTb+Uq2QIuTOe4fgEpnF47oNN5AqXYHOwcaTrWguvq9WPjPtJsSUOSMxFYrVkkAFwSfv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:902c:b0fa:dec9:8767])
 (user=irogers job=sendgmr) by 2002:a0d:c681:0:b0:33c:2e21:4756 with SMTP id
 i123-20020a0dc681000000b0033c2e214756mr14585065ywd.467.1661878163051; Tue, 30
 Aug 2022 09:49:23 -0700 (PDT)
Date:   Tue, 30 Aug 2022 09:48:42 -0700
In-Reply-To: <20220830164846.401143-1-irogers@google.com>
Message-Id: <20220830164846.401143-5-irogers@google.com>
Mime-Version: 1.0
References: <20220830164846.401143-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v1 4/8] perf smt: Compute SMT from topology
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The topology records sibling threads. Rather than computing SMT using
siblings in sysfs, reuse the values in topology. This only applies
when the file smt/active isn't available.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c   | 24 ++++++----
 tools/perf/util/cputopo.c | 15 +++++++
 tools/perf/util/cputopo.h |  2 +
 tools/perf/util/expr.c    |  9 ++--
 tools/perf/util/smt.c     | 95 ++++-----------------------------------
 tools/perf/util/smt.h     |  5 ++-
 6 files changed, 49 insertions(+), 101 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 7ca5e37de560..db736ed49556 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "util/cputopo.h"
 #include "util/debug.h"
 #include "util/expr.h"
 #include "util/header.h"
@@ -154,15 +155,20 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 						    (void **)&val_ptr));
 
 	/* Only EVENT1 or EVENT2 need be measured depending on the value of smt_on. */
-	expr__ctx_clear(ctx);
-	TEST_ASSERT_VAL("find ids",
-			expr__find_ids("EVENT1 if #smt_on else EVENT2",
-				NULL, ctx) == 0);
-	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
-						  smt_on() ? "EVENT1" : "EVENT2",
-						  (void **)&val_ptr));
-
+	{
+		struct cpu_topology *topology = cpu_topology__new();
+		bool smton = smt_on(topology);
+
+		cpu_topology__delete(topology);
+		expr__ctx_clear(ctx);
+		TEST_ASSERT_VAL("find ids",
+				expr__find_ids("EVENT1 if #smt_on else EVENT2",
+					NULL, ctx) == 0);
+		TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+		TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
+							  smton ? "EVENT1" : "EVENT2",
+							  (void **)&val_ptr));
+	}
 	/* The expression is a constant 1.0 without needing to evaluate EVENT1. */
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index d275d843c155..511002e52714 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -157,6 +157,21 @@ void cpu_topology__delete(struct cpu_topology *tp)
 	free(tp);
 }
 
+bool cpu_topology__smt_on(const struct cpu_topology *topology)
+{
+	for (u32 i = 0; i < topology->core_cpus_lists; i++) {
+		const char *cpu_list = topology->core_cpus_list[i];
+
+		/*
+		 * If there is a need to separate siblings in a core then SMT is
+		 * enabled.
+		 */
+		if (strchr(cpu_list, ',') || strchr(cpu_list, '-'))
+			return true;
+	}
+	return false;
+}
+
 static bool has_die_topology(void)
 {
 	char filename[MAXPATHLEN];
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index 854e18f9041e..469db775a13c 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -58,6 +58,8 @@ struct hybrid_topology {
 
 struct cpu_topology *cpu_topology__new(void);
 void cpu_topology__delete(struct cpu_topology *tp);
+/* Determine from the core list whether SMT was enabled. */
+bool cpu_topology__smt_on(const struct cpu_topology *topology);
 
 struct numa_topology *numa_topology__new(void);
 void numa_topology__delete(struct numa_topology *tp);
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 00bde682e743..8aa7dafa18b3 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -412,11 +412,6 @@ double expr__get_literal(const char *literal)
 	static struct cpu_topology *topology;
 	double result = NAN;
 
-	if (!strcasecmp("#smt_on", literal)) {
-		result = smt_on() > 0 ? 1.0 : 0.0;
-		goto out;
-	}
-
 	if (!strcmp("#num_cpus", literal)) {
 		result = cpu__max_present_cpu().cpu;
 		goto out;
@@ -440,6 +435,10 @@ double expr__get_literal(const char *literal)
 			goto out;
 		}
 	}
+	if (!strcasecmp("#smt_on", literal)) {
+		result = smt_on(topology) ? 1.0 : 0.0;
+		goto out;
+	}
 	if (!strcmp("#num_packages", literal)) {
 		result = topology->package_cpus_lists;
 		goto out;
diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 8fed03283c85..ce90c4ee4138 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -1,100 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <linux/bitops.h>
+#include <string.h>
 #include "api/fs/fs.h"
+#include "cputopo.h"
 #include "smt.h"
 
-/**
- * hweight_str - Returns the number of bits set in str. Stops at first non-hex
- *	       or ',' character.
- */
-static int hweight_str(char *str)
-{
-	int result = 0;
-
-	while (*str) {
-		switch (*str++) {
-		case '0':
-		case ',':
-			break;
-		case '1':
-		case '2':
-		case '4':
-		case '8':
-			result++;
-			break;
-		case '3':
-		case '5':
-		case '6':
-		case '9':
-		case 'a':
-		case 'A':
-		case 'c':
-		case 'C':
-			result += 2;
-			break;
-		case '7':
-		case 'b':
-		case 'B':
-		case 'd':
-		case 'D':
-		case 'e':
-		case 'E':
-			result += 3;
-			break;
-		case 'f':
-		case 'F':
-			result += 4;
-			break;
-		default:
-			goto done;
-		}
-	}
-done:
-	return result;
-}
-
-int smt_on(void)
+bool smt_on(const struct cpu_topology *topology)
 {
 	static bool cached;
-	static int cached_result;
-	int cpu;
-	int ncpu;
+	static bool cached_result;
+	int fs_value;
 
 	if (cached)
 		return cached_result;
 
-	if (sysfs__read_int("devices/system/cpu/smt/active", &cached_result) >= 0) {
-		cached = true;
-		return cached_result;
-	}
-
-	cached_result = 0;
-	ncpu = sysconf(_SC_NPROCESSORS_CONF);
-	for (cpu = 0; cpu < ncpu; cpu++) {
-		unsigned long long siblings;
-		char *str;
-		size_t strlen;
-		char fn[256];
+	if (sysfs__read_int("devices/system/cpu/smt/active", &fs_value) >= 0)
+		cached_result = (fs_value == 1);
+	else
+		cached_result = cpu_topology__smt_on(topology);
 
-		snprintf(fn, sizeof fn,
-			"devices/system/cpu/cpu%d/topology/thread_siblings", cpu);
-		if (sysfs__read_str(fn, &str, &strlen) < 0) {
-			snprintf(fn, sizeof fn,
-				"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
-			if (sysfs__read_str(fn, &str, &strlen) < 0)
-				continue;
-		}
-		/* Entry is hex, but does not have 0x, so need custom parser */
-		siblings = hweight_str(str);
-		free(str);
-		if (siblings > 1) {
-			cached_result = 1;
-			break;
-		}
-	}
 	cached = true;
 	return cached_result;
 }
diff --git a/tools/perf/util/smt.h b/tools/perf/util/smt.h
index a98d65808f6a..e26999c6b8d4 100644
--- a/tools/perf/util/smt.h
+++ b/tools/perf/util/smt.h
@@ -2,6 +2,9 @@
 #ifndef __SMT_H
 #define __SMT_H 1
 
-int smt_on(void);
+struct cpu_topology;
+
+/* Returns true if SMT (aka hyperthreading) is enabled. */
+bool smt_on(const struct cpu_topology *topology);
 
 #endif /* __SMT_H */
-- 
2.37.2.672.g94769d06f0-goog

