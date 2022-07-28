Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE9058483E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 00:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiG1W3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 18:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiG1W3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 18:29:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFA67A519
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:28:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s6-20020a25c206000000b0066ebb148de6so2536263ybf.15
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6RGVI4+L1YSOoMKzsQCuDbeJhpK6KXCncEJhv9rjmw0=;
        b=igyHFloWjfYYgFfXDCg+xsnWfj46mW6TQ4bSzDcrK6IC2eoIuRt7UMlRlZRhHypfcX
         EyOGzmLpUiAPRiqiRUD+V0xC90V6XDSg99w4EugGFc14wgK+dSMpQmt4b9KSfQr5Ee4J
         G0MVGdGE+NqjYxuXVBXs0Evgufv2w7KXvkMbDEIB9SqKLWOEyGVpCXRr2f2MIfQ6nMEN
         9LIQWCvnI1ickirRdcI8/QHcZdmyeLjK6wnEMKXqc1AGMYrKCLU2+OxOHtrXzU3XHKBo
         f0iLro8tO2t2tsHU69a8RjPMWV29Qzwfw9vBdktCgKfwbxG8ke/fX696CNnXcrkpavHB
         DEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6RGVI4+L1YSOoMKzsQCuDbeJhpK6KXCncEJhv9rjmw0=;
        b=nJeNV0mlqydQI/ejRsfnh57LPCRWDntGzQ8M1+QDJKs+MvN2u88dgeOFqmPONnGi7v
         IwHBVD8tOzRXh7jJ9DNsd8Qhhx8vWrOKRtJHFA35uFccjzshyNGHmEbKbsSZIs+Jloki
         KewKSFKEKzav6C/lNYn7V4aGqq1kGeNVjLljYyDmB4/FDffMQLVQtnRePJLkgbrPFnwI
         0jSYiX1e5QL0b6r/XAB8UHdb7nHpV/mI6MLynlYwc2mrIwK5MLSvM+Rl1qYsGF5eK4VX
         tef/n4+yPS8NS+rhI69x9YUfJNdH2K0OkPdlJUMzY9zhNaJW1AXYiB5bJxc0644Z9gbD
         C0ww==
X-Gm-Message-State: ACgBeo0kdBWKbwaCaUi9StOkk7aNiUpnLvhh12AcPmDRhrvOd6rUcC0L
        3z6m4JAvULwO9PemuU0bCrdgxW5IiTcP
X-Google-Smtp-Source: AA6agR4Tt9CZRhWR6vWG3CmnhnWvaRvYTrqEsoE7Jrnx2cAJUIXLT/H2CEox5Tsl8MkKk8PKi9x6dK2tnvNJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fd09:96c3:28af:b08f])
 (user=irogers job=sendgmr) by 2002:a5b:2c8:0:b0:671:7cc8:219c with SMTP id
 h8-20020a5b02c8000000b006717cc8219cmr629068ybp.325.1659047337956; Thu, 28 Jul
 2022 15:28:57 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:28:26 -0700
In-Reply-To: <20220728222835.3254224-1-irogers@google.com>
Message-Id: <20220728222835.3254224-8-irogers@google.com>
Mime-Version: 1.0
References: <20220728222835.3254224-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v2 07/16] perf pmu-events: Hide pmu_sys_event_tables
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
index 34b686d27cef..432ecb5a33f5 100755
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
2.37.1.455.g008518b4e5-goog

