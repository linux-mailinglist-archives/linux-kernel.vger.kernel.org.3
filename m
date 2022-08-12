Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CE0591789
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 01:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbiHLXKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 19:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiHLXKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 19:10:17 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555079E2EA
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:10:08 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id e11-20020a17090a630b00b001f8b2deb88dso2615764pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=xhF50+QBseJSGKZ9VkfqAcGwnWmb4rSoqzbtULTujMs=;
        b=moww+6+YRdPWxALS1+wArTMDcAORPG2Ly4fs1LL27nT72D9ko4UjmzJ6kydm7YhsYT
         UUUCfzaMxCVpSnRYQDD8Lsv4+yokm+45xLFoTU9s0geyfg0Kc7rjcvuxiLs0skXaDJ8W
         R1CCZuHFOSgAvmoNMFe3AO+PkXOlCxmF/XtHfs80wsEK3G3l2JneefK5TR/zCisu2OW+
         8ZD3e0/b+D0z2EzUj2eMlQMBvG1+Lr2LWHub6PTtoqSG8mDpZJfbgNVYCGUiemq8tkM2
         +S+z3U0yjLRMWjAMsVNLG0rQJKhfZE5I9H/gk2OFMLHuUcPx+OWke6Dw82Y1EVRUJh1M
         n6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=xhF50+QBseJSGKZ9VkfqAcGwnWmb4rSoqzbtULTujMs=;
        b=KP+Ne1pVAsVGns6+VHgixlhdD9oQIVINJRsj6HsnyN+Os+/AgAtdCsbk5HsSmd9W09
         cIjCNNrdYNNfkVvCCslKrWE0l9qfY2JRT5DpuZ+wRFW3fmBr+QHHWgkvMvrpWiiU6mDa
         OdGHNCVhUSxbcFcrgSMsur3io0E1gAQg8IByB1g+bnrv92++vixgkUl3dKZv8Pty7or1
         dh8UWR5Q+abvg2/DkqgtgsStDXmChmqWBhsgl7CDulpyzsLOfJvxspu33rRnYVbwMKPP
         Htl1tlvgZITxF/+C4pfQO3vT4FH1XSHm2Asv1uhNPBokiIb6stwe0KKWJlbTW5L9x/QT
         IXNQ==
X-Gm-Message-State: ACgBeo0gL72hEww1uv5YrFzHlzyfPx2JomNHTI+Jz69U0Avvv/Qi/oK8
        qzD6N/esTYLG8jnyp1mb485WcjI33TTb
X-Google-Smtp-Source: AA6agR7onQEoCeXlmRdCyZVURXCYIcFg28AimeJhdEjnXZw7WG6VjQ/8pxgwmJ0SRNzHtyvoZit2wCHrq8wj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d668:2937:8218:c5ec])
 (user=irogers job=sendgmr) by 2002:a17:90b:1d0a:b0:1f5:76c0:f142 with SMTP id
 on10-20020a17090b1d0a00b001f576c0f142mr16061812pjb.192.1660345807513; Fri, 12
 Aug 2022 16:10:07 -0700 (PDT)
Date:   Fri, 12 Aug 2022 16:09:40 -0700
In-Reply-To: <20220812230949.683239-1-irogers@google.com>
Message-Id: <20220812230949.683239-6-irogers@google.com>
Mime-Version: 1.0
References: <20220812230949.683239-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v5 05/14] perf pmu-events: Hide pmu_sys_event_tables
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move usage of the table to pmu-events.c so it may be hidden. By
abstracting the table the implementation can later be changed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 37 ++++++++++++++++++-
 tools/perf/pmu-events/jevents.py         | 45 ++++++++++++++++++++++--
 tools/perf/pmu-events/pmu-events.h       | 11 +++---
 tools/perf/tests/pmu-events.c            | 14 +-------
 tools/perf/util/pmu.c                    | 27 --------------
 tools/perf/util/pmu.h                    |  2 --
 6 files changed, 84 insertions(+), 52 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 4182a986f505..216ea0482c37 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -6,6 +6,8 @@
  * The test cpu/soc is provided for testing.
  */
 #include "pmu-events/pmu-events.h"
+#include <string.h>
+#include <stddef.h>
 
 static const struct pmu_event pme_test_soc_cpu[] = {
 	{
@@ -145,7 +147,12 @@ static const struct pmu_event pme_test_soc_sys[] = {
 	},
 };
 
-const struct pmu_sys_events pmu_sys_event_tables[] = {
+struct pmu_sys_events {
+	const char *name;
+	const struct pmu_event *table;
+};
+
+static const struct pmu_sys_events pmu_sys_event_tables[] = {
 	{
 		.table = pme_test_soc_sys,
 		.name = "pme_test_soc_sys",
@@ -154,3 +161,31 @@ const struct pmu_sys_events pmu_sys_event_tables[] = {
 		.table = 0
 	},
 };
+
+const struct pmu_event *find_sys_events_table(const char *name)
+{
+	for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
+	     tables->name;
+	     tables++) {
+		if (!strcmp(tables->name, name))
+			return tables->table;
+	}
+	return NULL;
+}
+
+int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
+{
+	for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
+	     tables->name;
+	     tables++) {
+		for (const struct pmu_event *pe = &tables->table[0];
+		     pe->name || pe->metric_group || pe->metric_name;
+		     pe++) {
+			int ret = fn(pe, data);
+
+			if (ret)
+				return ret;
+		}
+	}
+	return 0;
+}
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 84fbb0f384cc..8f929dd3e065 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -371,8 +371,14 @@ def print_mapping_table(archs: Sequence[str]) -> None:
 
 def print_system_mapping_table() -> None:
   """C struct mapping table array for tables from /sys directories."""
-  _args.output_file.write(
-      '\nconst struct pmu_sys_events pmu_sys_event_tables[] = {\n')
+  _args.output_file.write("""
+struct pmu_sys_events {
+\tconst char *name;
+\tconst struct pmu_event *table;
+};
+
+static const struct pmu_sys_events pmu_sys_event_tables[] = {
+""")
   for tblname in _sys_event_tables:
     _args.output_file.write(f"""\t{{
 \t\t.table = {tblname},
@@ -383,6 +389,34 @@ def print_system_mapping_table() -> None:
 \t\t.table = 0
 \t},
 };
+
+const struct pmu_event *find_sys_events_table(const char *name)
+{
+        for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
+             tables->name;
+             tables++) {
+                if (!strcmp(tables->name, name))
+                        return tables->table;
+        }
+        return NULL;
+}
+
+int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
+{
+        for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
+             tables->name;
+             tables++) {
+                for (const struct pmu_event *pe = &tables->table[0];
+                     pe->name || pe->metric_group || pe->metric_name;
+                     pe++) {
+                        int ret = fn(pe, data);
+
+                        if (ret)
+                                return ret;
+                }
+        }
+        return 0;
+}
 """)
 
 
@@ -414,7 +448,12 @@ def main() -> None:
       'output_file', type=argparse.FileType('w'), nargs='?', default=sys.stdout)
   _args = ap.parse_args()
 
-  _args.output_file.write("#include \"pmu-events/pmu-events.h\"\n")
+  _args.output_file.write("""
+#include "pmu-events/pmu-events.h"
+#include <string.h>
+#include <stddef.h>
+
+""")
   archs = []
   for item in os.scandir(_args.starting_dir):
     if not item.is_dir():
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index a491b117c8ac..2386212b1df0 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -43,16 +43,15 @@ struct pmu_events_map {
 	const struct pmu_event *table;
 };
 
-struct pmu_sys_events {
-	const char *name;
-	const struct pmu_event *table;
-};
-
 /*
  * Global table mapping each known CPU for the architecture to its
  * table of PMU events.
  */
 extern const struct pmu_events_map pmu_events_map[];
-extern const struct pmu_sys_events pmu_sys_event_tables[];
+
+const struct pmu_event *find_sys_events_table(const char *name);
+
+typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe, void *data);
+int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data);
 
 #endif
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 82192f1a7bf7..a39a2c99ede6 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -286,18 +286,6 @@ static const struct pmu_events_map *__test_pmu_get_events_map(void)
 	return NULL;
 }
 
-static const struct pmu_event *__test_pmu_get_sys_events_table(void)
-{
-	const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
-
-	for ( ; tables->name; tables++) {
-		if (!strcmp("pme_test_soc_sys", tables->name))
-			return tables->table;
-	}
-
-	return NULL;
-}
-
 static int compare_pmu_events(const struct pmu_event *e1, const struct pmu_event *e2)
 {
 	if (!is_same(e1->name, e2->name)) {
@@ -451,7 +439,7 @@ static int compare_alias_to_test_event(struct perf_pmu_alias *alias,
 static int test__pmu_event_table(struct test_suite *test __maybe_unused,
 				 int subtest __maybe_unused)
 {
-	const struct pmu_event *sys_event_tables = __test_pmu_get_sys_events_table();
+	const struct pmu_event *sys_event_tables = find_sys_events_table("pme_test_soc_sys");
 	const struct pmu_events_map *map = __test_pmu_get_events_map();
 	const struct pmu_event *table;
 	int map_events = 0, expected_events;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0112e1c36418..d8717c4548a4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -868,33 +868,6 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 	pmu_add_cpu_aliases_map(head, pmu, map);
 }
 
-void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data)
-{
-	int i = 0;
-
-	while (1) {
-		const struct pmu_sys_events *event_table;
-		int j = 0;
-
-		event_table = &pmu_sys_event_tables[i++];
-
-		if (!event_table->table)
-			break;
-
-		while (1) {
-			const struct pmu_event *pe = &event_table->table[j++];
-			int ret;
-
-			if (!pe->name && !pe->metric_group && !pe->metric_name)
-				break;
-
-			ret = fn(pe, data);
-			if (ret)
-				break;
-		}
-	}
-}
-
 struct pmu_sys_event_iter_data {
 	struct list_head *head;
 	struct perf_pmu *pmu;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 4b45fd8da5a3..7e667eec2a01 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -133,8 +133,6 @@ const struct pmu_events_map *pmu_events_map__find(void);
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 void perf_pmu_free_alias(struct perf_pmu_alias *alias);
 
-typedef int (*pmu_sys_event_iter_fn)(const struct pmu_event *pe, void *data);
-void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data);
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
-- 
2.37.1.595.g718a3a8f04-goog

