Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB994B7122
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbiBOPnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:43:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbiBOPmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:42:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1398D2040;
        Tue, 15 Feb 2022 07:37:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55582B8185B;
        Tue, 15 Feb 2022 15:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819DCC340EB;
        Tue, 15 Feb 2022 15:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644939439;
        bh=TeR5xH8P329XvkDZu4avsJVXyHq0d1jVWjx4RDc8sRU=;
        h=From:To:Cc:Subject:Date:From;
        b=jKcWbNt2FCs2NwwDNK6LW15Wk25UyUzIcQ9KMmoXKZZqLb584v4MfMK2Q4fJi7HJf
         46yy4lLCFelEmNYvEWfF3VUwriqJWZKRiNxjRN+ZoXwf9ixSDrK6aJixUORoKKoxn6
         LFGC/EFtTkXOipiVqAIeYmPs9qltXZuSowspm9xp/GM0EKidVG6jtVZi2cv8DqpTtY
         toY+Bob2PJZaVbl5afUM2LBoszCM9svukYXnBhpiXadk/u08eGluriFYeie5d1SvnS
         eYiQYfW0hYBmZ1AgKLt3YbWkajvTwN5h/e2+mw2b6qyoY9XOqR+1/aDquBIj1nqVkU
         YHj2EzIFFCj2A==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] libperf: Fix perf_cpu_map__for_each_cpu macro
Date:   Tue, 15 Feb 2022 16:37:13 +0100
Message-Id: <20220215153713.31395-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tzvetomir Stoyanov reported an issue with using macro
perf_cpu_map__for_each_cpu using private perf_cpu object.

The issue is caused by recent change that wrapped cpu in struct
perf_cpu to distinguish it from cpu indexes. We need to make
struct perf_cpu public.

Adding simple test for using perf_cpu_map__for_each_cpu
macro.

Fixes: 6d18804b963b ("perf cpumap: Give CPUs their own type")
Reported-by: Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/cpumap.h |  6 +-----
 tools/lib/perf/include/perf/cpumap.h     |  5 +++++
 tools/lib/perf/libperf.map               |  1 +
 tools/lib/perf/tests/test-cpumap.c       | 11 +++++++++++
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 581f9ffb4237..1973a18c096b 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -3,11 +3,7 @@
 #define __LIBPERF_INTERNAL_CPUMAP_H
 
 #include <linux/refcount.h>
-
-/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
-struct perf_cpu {
-	int cpu;
-};
+#include <perf/cpumap.h>
 
 /**
  * A sized, reference counted, sorted array of integers representing CPU
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 15b8faafd615..4a2edbdb5e2b 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -7,6 +7,11 @@
 #include <stdio.h>
 #include <stdbool.h>
 
+/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
+struct perf_cpu {
+	int cpu;
+};
+
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 93696affda2e..6fa0d651576b 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -2,6 +2,7 @@ LIBPERF_0.0.1 {
 	global:
 		libperf_init;
 		perf_cpu_map__dummy_new;
+		perf_cpu_map__default_new;
 		perf_cpu_map__get;
 		perf_cpu_map__put;
 		perf_cpu_map__new;
diff --git a/tools/lib/perf/tests/test-cpumap.c b/tools/lib/perf/tests/test-cpumap.c
index d39378eaf897..87b0510a556f 100644
--- a/tools/lib/perf/tests/test-cpumap.c
+++ b/tools/lib/perf/tests/test-cpumap.c
@@ -14,6 +14,8 @@ static int libperf_print(enum libperf_print_level level,
 int test_cpumap(int argc, char **argv)
 {
 	struct perf_cpu_map *cpus;
+	struct perf_cpu cpu;
+	int idx;
 
 	__T_START;
 
@@ -27,6 +29,15 @@ int test_cpumap(int argc, char **argv)
 	perf_cpu_map__put(cpus);
 	perf_cpu_map__put(cpus);
 
+	cpus = perf_cpu_map__default_new();
+	if (!cpus)
+		return -1;
+
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus)
+		__T("wrong cpu number", cpu.cpu != -1);
+
+	perf_cpu_map__put(cpus);
+
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
 }
-- 
2.35.1

