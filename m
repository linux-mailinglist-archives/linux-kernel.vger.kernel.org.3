Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6859178F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 01:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiHLXLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 19:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbiHLXK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 19:10:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3239D117
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:10:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a05690212cb00b006454988d225so1828556ybu.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=zprLe3z6GS8nmW2T+04nxrIBRrafJR/G9iUpcioBWxI=;
        b=dcZEL3cR1Azc7uP1/qAFxYhtku9U3I9OhhFGefft2NxD/BvtOD103q0GDjD+OdVDgj
         hZ0U0ZfmEbmjmB6iL6gmGIwYTABoSn7sUfUWLVaQ3Jn+NlIr9spbGiyqiHYnf9sO0RSp
         g4cn2carsPAlgE1615xTsq8qeq8mFDOlobxylV9rhTCieBbsZqL5WJykzFvS0HYokT+8
         +y8ltmfO2lxEufCbtMaVhzdWjsO0fkeryU2YhJWKLa944Xc7azCjq+fykab02i5Xp/7Q
         t9/rKHQaURmjwQj8rjtUwCp4r2MfEGy4JOpumK+v/B9iPH2+bqeVG5F3sU01zCMpkFUQ
         aYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=zprLe3z6GS8nmW2T+04nxrIBRrafJR/G9iUpcioBWxI=;
        b=Yld7/DsxiOsC8w9h9IjrSiTyimvkiUSWoM0HBwoh7k+82QJdJ0lqZPFlkl7CiQmbHE
         5D9kHTqZBx99drKz+V3/ph8G1h9fprn+6c5bxdy/x//xx5BcD2nh8oRZkRFi7blf0JKa
         qWto0IIyHsTDp541x4+2lVRlYgYV61JU42w92i9E43UwJuKlr+hfqDRPf+l6P3bTsYUi
         nd2ym0cERnBw2U9DmJj491Ezt/mYexRpAquyyaQfIXvb3cyXAVAO3dxca+WaWKteq/Mh
         gHsx/yqy+IKGXXk8W+sm3MnaNlzhuuAbzo54Zq0u84ipkOhVSPnLQkb+JPDKZvijp7eh
         lNCw==
X-Gm-Message-State: ACgBeo1tL1bmK2pWf9OANYcM/U+3+maTb/qu5+DnuXxM+1HlIxrBNDwU
        HFvCrEPKEPce6lS1zjId6Fs8+4wr+aR0
X-Google-Smtp-Source: AA6agR5oPW2xGQeIidUC15wyzZ/XWPatNKTsSkkTJML7GOSytjJ3utI07u2Ae+Til81DVLjpiKaWIWw+tZKA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d668:2937:8218:c5ec])
 (user=irogers job=sendgmr) by 2002:a25:9306:0:b0:683:75e4:e03f with SMTP id
 f6-20020a259306000000b0068375e4e03fmr3237759ybo.172.1660345824061; Fri, 12
 Aug 2022 16:10:24 -0700 (PDT)
Date:   Fri, 12 Aug 2022 16:09:46 -0700
In-Reply-To: <20220812230949.683239-1-irogers@google.com>
Message-Id: <20220812230949.683239-12-irogers@google.com>
Mime-Version: 1.0
References: <20220812230949.683239-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v5 11/14] perf pmu-events: Hide the pmu_events
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

Hide that the pmu_event structs are an array with a new wrapper struct.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/pmu.c         |  2 +-
 tools/perf/pmu-events/empty-pmu-events.c | 44 ++++++++++++----------
 tools/perf/pmu-events/jevents.py         | 47 +++++++++++++-----------
 tools/perf/pmu-events/pmu-events.h       | 12 +++---
 tools/perf/tests/expand-cgroup.c         |  2 +-
 tools/perf/tests/parse-metric.c          |  2 +-
 tools/perf/tests/pmu-events.c            | 16 ++++----
 tools/perf/util/metricgroup.c            | 42 ++++++++++-----------
 tools/perf/util/metricgroup.h            |  5 +--
 tools/perf/util/pmu.c                    | 10 ++---
 tools/perf/util/pmu.h                    |  4 +-
 tools/perf/util/s390-sample-raw.c        |  6 +--
 12 files changed, 101 insertions(+), 91 deletions(-)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 92d774647f6e..f849b1e88d43 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -3,7 +3,7 @@
 #include "../../../util/cpumap.h"
 #include "../../../util/pmu.h"
 
-const struct pmu_event *pmu_events_table__find(void)
+const struct pmu_events_table *pmu_events_table__find(void)
 {
 	struct perf_pmu *pmu = NULL;
 
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index bee1967baa2b..5ed8c0aa4817 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -176,6 +176,10 @@ static const struct pmu_event pme_test_soc_cpu[] = {
 	},
 };
 
+/* Struct used to make the PMU event table implementation opaque to callers. */
+struct pmu_events_table {
+	const struct pmu_event *entries;
+};
 
 /*
  * Map a CPU to its table of PMU events. The CPU is identified by the
@@ -188,7 +192,7 @@ static const struct pmu_event pme_test_soc_cpu[] = {
 struct pmu_events_map {
 	const char *arch;
 	const char *cpuid;
-	const struct pmu_event *table;
+	const struct pmu_events_table table;
 };
 
 /*
@@ -199,12 +203,12 @@ static const struct pmu_events_map pmu_events_map[] = {
 	{
 		.arch = "testarch",
 		.cpuid = "testcpu",
-		.table = pme_test_soc_cpu,
+		.table = { pme_test_soc_cpu },
 	},
 	{
 		.arch = 0,
 		.cpuid = 0,
-		.table = 0,
+		.table = { 0 },
 	},
 };
 
@@ -234,23 +238,23 @@ static const struct pmu_event pme_test_soc_sys[] = {
 
 struct pmu_sys_events {
 	const char *name;
-	const struct pmu_event *table;
+	const struct pmu_events_table table;
 };
 
 static const struct pmu_sys_events pmu_sys_event_tables[] = {
 	{
-		.table = pme_test_soc_sys,
+		.table = { pme_test_soc_sys },
 		.name = "pme_test_soc_sys",
 	},
 	{
-		.table = 0
+		.table = { 0 }
 	},
 };
 
-int pmu_events_table_for_each_event(const struct pmu_event *table, pmu_event_iter_fn fn,
+int pmu_events_table_for_each_event(const struct pmu_events_table *table, pmu_event_iter_fn fn,
 				    void *data)
 {
-	for (const struct pmu_event *pe = &table[0];
+	for (const struct pmu_event *pe = &table->entries[0];
 	     pe->name || pe->metric_group || pe->metric_name;
 	     pe++) {
 		int ret = fn(pe, table, data);
@@ -261,9 +265,9 @@ int pmu_events_table_for_each_event(const struct pmu_event *table, pmu_event_ite
 	return 0;
 }
 
-const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
+const struct pmu_events_table *perf_pmu__find_table(struct perf_pmu *pmu)
 {
-	const struct pmu_event *table = NULL;
+	const struct pmu_events_table *table = NULL;
 	char *cpuid = perf_pmu__getcpuid(pmu);
 	int i;
 
@@ -277,11 +281,11 @@ const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
 	for (;;) {
 		const struct pmu_events_map *map = &pmu_events_map[i++];
 
-		if (!map->table)
+		if (!map->cpuid)
 			break;
 
 		if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
-			table = map->table;
+			table = &map->table;
 			break;
 		}
 	}
@@ -289,13 +293,13 @@ const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
 	return table;
 }
 
-const struct pmu_event *find_core_events_table(const char *arch, const char *cpuid)
+const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
 {
 	for (const struct pmu_events_map *tables = &pmu_events_map[0];
-	     tables->table;
+	     tables->arch;
 	     tables++) {
 		if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
-			return tables->table;
+			return &tables->table;
 	}
 	return NULL;
 }
@@ -303,9 +307,9 @@ const struct pmu_event *find_core_events_table(const char *arch, const char *cpu
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
 {
 	for (const struct pmu_events_map *tables = &pmu_events_map[0];
-	     tables->table;
+	     tables->arch;
 	     tables++) {
-		int ret = pmu_events_table_for_each_event(tables->table, fn, data);
+		int ret = pmu_events_table_for_each_event(&tables->table, fn, data);
 
 		if (ret)
 			return ret;
@@ -313,13 +317,13 @@ int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
 	return 0;
 }
 
-const struct pmu_event *find_sys_events_table(const char *name)
+const struct pmu_events_table *find_sys_events_table(const char *name)
 {
 	for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
 	     tables->name;
 	     tables++) {
 		if (!strcmp(tables->name, name))
-			return tables->table;
+			return &tables->table;
 	}
 	return NULL;
 }
@@ -329,7 +333,7 @@ int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
 	for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
 	     tables->name;
 	     tables++) {
-		int ret = pmu_events_table_for_each_event(tables->table, fn, data);
+		int ret = pmu_events_table_for_each_event(&tables->table, fn, data);
 
 		if (ret)
 			return ret;
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 977f2061a990..4b7948ba57d6 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -335,6 +335,11 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 def print_mapping_table(archs: Sequence[str]) -> None:
   """Read the mapfile and generate the struct from cpuid string to event table."""
   _args.output_file.write("""
+/* Struct used to make the PMU event table implementation opaque to callers. */
+struct pmu_events_table {
+        const struct pmu_event *entries;
+};
+
 /*
  * Map a CPU to its table of PMU events. The CPU is identified by the
  * cpuid field, which is an arch-specific identifier for the CPU.
@@ -346,7 +351,7 @@ def print_mapping_table(archs: Sequence[str]) -> None:
 struct pmu_events_map {
         const char *arch;
         const char *cpuid;
-        const struct pmu_event *table;
+        struct pmu_events_table table;
 };
 
 /*
@@ -360,7 +365,7 @@ const struct pmu_events_map pmu_events_map[] = {
       _args.output_file.write("""{
 \t.arch = "testarch",
 \t.cpuid = "testcpu",
-\t.table = pme_test_soc_cpu,
+\t.table = { pme_test_soc_cpu },
 },
 """)
     else:
@@ -375,7 +380,7 @@ const struct pmu_events_map pmu_events_map[] = {
             _args.output_file.write(f"""{{
 \t.arch = "{arch}",
 \t.cpuid = "{cpuid}",
-\t.table = {tblname}
+\t.table = {{ {tblname} }}
 }},
 """)
           first = False
@@ -383,7 +388,7 @@ const struct pmu_events_map pmu_events_map[] = {
   _args.output_file.write("""{
 \t.arch = 0,
 \t.cpuid = 0,
-\t.table = 0,
+\t.table = { 0 },
 }
 };
 """)
@@ -394,26 +399,26 @@ def print_system_mapping_table() -> None:
   _args.output_file.write("""
 struct pmu_sys_events {
 \tconst char *name;
-\tconst struct pmu_event *table;
+\tstruct pmu_events_table table;
 };
 
 static const struct pmu_sys_events pmu_sys_event_tables[] = {
 """)
   for tblname in _sys_event_tables:
     _args.output_file.write(f"""\t{{
-\t\t.table = {tblname},
+\t\t.table = {{ {tblname} }},
 \t\t.name = \"{tblname}\",
 \t}},
 """)
   _args.output_file.write("""\t{
-\t\t.table = 0
+\t\t.table = { 0 }
 \t},
 };
 
-int pmu_events_table_for_each_event(const struct pmu_event *table, pmu_event_iter_fn fn,
+int pmu_events_table_for_each_event(const struct pmu_events_table *table, pmu_event_iter_fn fn,
                                     void *data)
 {
-        for (const struct pmu_event *pe = &table[0];
+        for (const struct pmu_event *pe = &table->entries[0];
              pe->name || pe->metric_group || pe->metric_name;
              pe++) {
                 int ret = fn(pe, table, data);
@@ -424,9 +429,9 @@ int pmu_events_table_for_each_event(const struct pmu_event *table, pmu_event_ite
         return 0;
 }
 
-const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
+const struct pmu_events_table *perf_pmu__find_table(struct perf_pmu *pmu)
 {
-        const struct pmu_event *table = NULL;
+        const struct pmu_events_table *table = NULL;
         char *cpuid = perf_pmu__getcpuid(pmu);
         int i;
 
@@ -439,11 +444,11 @@ const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
         i = 0;
         for (;;) {
                 const struct pmu_events_map *map = &pmu_events_map[i++];
-                if (!map->table)
+                if (!map->arch)
                         break;
 
                 if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
-                        table = map->table;
+                        table = &map->table;
                         break;
                 }
         }
@@ -451,13 +456,13 @@ const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
         return table;
 }
 
-const struct pmu_event *find_core_events_table(const char *arch, const char *cpuid)
+const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
 {
         for (const struct pmu_events_map *tables = &pmu_events_map[0];
-             tables->table;
+             tables->arch;
              tables++) {
                 if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
-                        return tables->table;
+                        return &tables->table;
         }
         return NULL;
 }
@@ -465,9 +470,9 @@ const struct pmu_event *find_core_events_table(const char *arch, const char *cpu
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
 {
         for (const struct pmu_events_map *tables = &pmu_events_map[0];
-             tables->table;
+             tables->arch;
              tables++) {
-                int ret = pmu_events_table_for_each_event(tables->table, fn, data);
+                int ret = pmu_events_table_for_each_event(&tables->table, fn, data);
 
                 if (ret)
                         return ret;
@@ -475,13 +480,13 @@ int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
         return 0;
 }
 
-const struct pmu_event *find_sys_events_table(const char *name)
+const struct pmu_events_table *find_sys_events_table(const char *name)
 {
         for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
              tables->name;
              tables++) {
                 if (!strcmp(tables->name, name))
-                        return tables->table;
+                        return &tables->table;
         }
         return NULL;
 }
@@ -491,7 +496,7 @@ int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
         for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
              tables->name;
              tables++) {
-                int ret = pmu_events_table_for_each_event(tables->table, fn, data);
+                int ret = pmu_events_table_for_each_event(&tables->table, fn, data);
 
                 if (ret)
                         return ret;
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 70672842f77f..fe343c4d8016 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -30,18 +30,20 @@ struct pmu_event {
 	const char *metric_constraint;
 };
 
+struct pmu_events_table;
+
 typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe,
-				 const struct pmu_event *table,
+				 const struct pmu_events_table *table,
 				 void *data);
 
-int pmu_events_table_for_each_event(const struct pmu_event *table, pmu_event_iter_fn fn,
+int pmu_events_table_for_each_event(const struct pmu_events_table *table, pmu_event_iter_fn fn,
 				    void *data);
 
-const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu);
-const struct pmu_event *find_core_events_table(const char *arch, const char *cpuid);
+const struct pmu_events_table *perf_pmu__find_table(struct perf_pmu *pmu);
+const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid);
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
 
-const struct pmu_event *find_sys_events_table(const char *name);
+const struct pmu_events_table *find_sys_events_table(const char *name);
 int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data);
 
 #endif
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index e79ee8621a90..51fb5f34c1dd 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -180,7 +180,7 @@ static int expand_metric_events(void)
 	struct evlist *evlist;
 	struct rblist metric_events;
 	const char metric_str[] = "CPI";
-	const struct pmu_event *pme_test;
+	const struct pmu_events_table *pme_test;
 
 	evlist = evlist__new();
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 30c7091857b8..68f5a2a03242 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -72,7 +72,7 @@ static int __compute_metric(const char *name, struct value *vals,
 	struct rblist metric_events = {
 		.nr_entries = 0,
 	};
-	const struct pmu_event *pme_test;
+	const struct pmu_events_table *pme_test;
 	struct perf_cpu_map *cpus;
 	struct runtime_stat st;
 	struct evlist *evlist;
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index e308d480f0fb..097e05c796ab 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -424,7 +424,7 @@ static int compare_alias_to_test_event(struct perf_pmu_alias *alias,
 }
 
 static int test__pmu_event_table_core_callback(const struct pmu_event *pe,
-					       const struct pmu_event *table __maybe_unused,
+					       const struct pmu_events_table *table __maybe_unused,
 					       void *data)
 {
 	int *map_events = data;
@@ -461,7 +461,7 @@ static int test__pmu_event_table_core_callback(const struct pmu_event *pe,
 }
 
 static int test__pmu_event_table_sys_callback(const struct pmu_event *pe,
-					      const struct pmu_event *table __maybe_unused,
+					      const struct pmu_events_table *table __maybe_unused,
 					      void *data)
 {
 	int *map_events = data;
@@ -495,8 +495,8 @@ static int test__pmu_event_table_sys_callback(const struct pmu_event *pe,
 static int test__pmu_event_table(struct test_suite *test __maybe_unused,
 				 int subtest __maybe_unused)
 {
-	const struct pmu_event *sys_event_table = find_sys_events_table("pme_test_soc_sys");
-	const struct pmu_event *table = find_core_events_table("testarch", "testcpu");
+	const struct pmu_events_table *sys_event_table = find_sys_events_table("pme_test_soc_sys");
+	const struct pmu_events_table *table = find_core_events_table("testarch", "testcpu");
 	int map_events = 0, expected_events, err;
 
 	/* ignore 3x sentinels */
@@ -544,7 +544,7 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
 	struct perf_pmu *pmu;
 	LIST_HEAD(aliases);
 	int res = 0;
-	const struct pmu_event *table = find_core_events_table("testarch", "testcpu");
+	const struct pmu_events_table *table = find_core_events_table("testarch", "testcpu");
 	struct perf_pmu_alias *a, *tmp;
 
 	if (!table)
@@ -597,7 +597,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 	struct perf_pmu *pmu = &test_pmu->pmu;
 	const char *pmu_name = pmu->name;
 	struct perf_pmu_alias *a, *tmp, *alias;
-	const struct pmu_event *events_table;
+	const struct pmu_events_table *events_table;
 	LIST_HEAD(aliases);
 	int res = 0;
 
@@ -839,7 +839,7 @@ struct metric {
 	struct metric_ref metric_ref;
 };
 
-static int test__parsing_callback(const struct pmu_event *pe, const struct pmu_event *table,
+static int test__parsing_callback(const struct pmu_event *pe, const struct pmu_events_table *table,
 				  void *data)
 {
 	int *failures = data;
@@ -1016,7 +1016,7 @@ static int metric_parse_fake(const char *str)
 }
 
 static int test__parsing_fake_callback(const struct pmu_event *pe,
-				       const struct pmu_event *table __maybe_unused,
+				       const struct pmu_events_table *table __maybe_unused,
 				       void *data __maybe_unused)
 {
 	if (!pe->metric_expr)
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index cae97b6dc5bc..42a5c8ae915e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -508,7 +508,7 @@ struct metricgroup_iter_data {
 };
 
 static int metricgroup__sys_event_iter(const struct pmu_event *pe,
-				       const struct pmu_event *table __maybe_unused,
+				       const struct pmu_events_table *table,
 				       void *data)
 {
 	struct metricgroup_iter_data *d = data;
@@ -529,7 +529,7 @@ static int metricgroup__sys_event_iter(const struct pmu_event *pe,
 }
 
 static int metricgroup__print_sys_event_iter(const struct pmu_event *pe,
-					     const struct pmu_event *table __maybe_unused,
+					     const struct pmu_events_table *table __maybe_unused,
 					     void *data)
 {
 	struct metricgroup_print_sys_idata *d = data;
@@ -549,7 +549,7 @@ struct metricgroup_print_data {
 };
 
 static int metricgroup__print_callback(const struct pmu_event *pe,
-				       const struct pmu_event *table __maybe_unused,
+				       const struct pmu_events_table *table __maybe_unused,
 				       void *vdata)
 {
 	struct metricgroup_print_data *data = vdata;
@@ -571,7 +571,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	struct rblist groups;
 	struct rb_node *node, *next;
 	struct strlist *metriclist = NULL;
-	const struct pmu_event *table;
+	const struct pmu_events_table *table;
 
 	if (!metricgroups) {
 		metriclist = strlist__new(NULL, NULL);
@@ -876,7 +876,7 @@ struct metricgroup_add_iter_data {
 	bool metric_no_group;
 	struct metric *root_metric;
 	const struct visited_metric *visited;
-	const struct pmu_event *table;
+	const struct pmu_events_table *table;
 };
 
 static int add_metric(struct list_head *metric_list,
@@ -885,7 +885,7 @@ static int add_metric(struct list_head *metric_list,
 		      bool metric_no_group,
 		      struct metric *root_metric,
 		      const struct visited_metric *visited,
-		      const struct pmu_event *table);
+		      const struct pmu_events_table *table);
 
 /**
  * resolve_metric - Locate metrics within the root metric and recursively add
@@ -908,7 +908,7 @@ static int resolve_metric(struct list_head *metric_list,
 			  bool metric_no_group,
 			  struct metric *root_metric,
 			  const struct visited_metric *visited,
-			  const struct pmu_event *table)
+			  const struct pmu_events_table *table)
 {
 	struct hashmap_entry *cur;
 	size_t bkt;
@@ -986,7 +986,7 @@ static int __add_metric(struct list_head *metric_list,
 			int runtime,
 			struct metric *root_metric,
 			const struct visited_metric *visited,
-			const struct pmu_event *table)
+			const struct pmu_events_table *table)
 {
 	const struct visited_metric *vm;
 	int ret;
@@ -1077,7 +1077,7 @@ struct metricgroup__find_metric_data {
 };
 
 static int metricgroup__find_metric_callback(const struct pmu_event *pe,
-					     const struct pmu_event *table  __maybe_unused,
+					     const struct pmu_events_table *table  __maybe_unused,
 					     void *vdata)
 {
 	struct metricgroup__find_metric_data *data = vdata;
@@ -1090,7 +1090,7 @@ static int metricgroup__find_metric_callback(const struct pmu_event *pe,
 }
 
 const struct pmu_event *metricgroup__find_metric(const char *metric,
-						 const struct pmu_event *table)
+						 const struct pmu_events_table *table)
 {
 	struct metricgroup__find_metric_data data = {
 		.metric = metric,
@@ -1108,7 +1108,7 @@ static int add_metric(struct list_head *metric_list,
 		      bool metric_no_group,
 		      struct metric *root_metric,
 		      const struct visited_metric *visited,
-		      const struct pmu_event *table)
+		      const struct pmu_events_table *table)
 {
 	int ret = 0;
 
@@ -1136,8 +1136,8 @@ static int add_metric(struct list_head *metric_list,
 }
 
 static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
-						  const struct pmu_event *table __maybe_unused,
-						  void *data)
+						const struct pmu_events_table *table __maybe_unused,
+						void *data)
 {
 	struct metricgroup_add_iter_data *d = data;
 	int ret;
@@ -1193,7 +1193,7 @@ struct metricgroup__add_metric_data {
 };
 
 static int metricgroup__add_metric_callback(const struct pmu_event *pe,
-					    const struct pmu_event *table,
+					    const struct pmu_events_table *table,
 					    void *vdata)
 {
 	struct metricgroup__add_metric_data *data = vdata;
@@ -1227,7 +1227,7 @@ static int metricgroup__add_metric_callback(const struct pmu_event *pe,
 static int metricgroup__add_metric(const char *metric_name, const char *modifier,
 				   bool metric_no_group,
 				   struct list_head *metric_list,
-				   const struct pmu_event *table)
+				   const struct pmu_events_table *table)
 {
 	LIST_HEAD(list);
 	int ret;
@@ -1296,7 +1296,7 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
  */
 static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 					struct list_head *metric_list,
-					const struct pmu_event *table)
+					const struct pmu_events_table *table)
 {
 	char *list_itr, *list_copy, *metric_name, *modifier;
 	int ret, count = 0;
@@ -1504,7 +1504,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 			bool metric_no_merge,
 			struct perf_pmu *fake_pmu,
 			struct rblist *metric_events_list,
-			const struct pmu_event *table)
+			const struct pmu_events_table *table)
 {
 	struct evlist *combined_evlist = NULL;
 	LIST_HEAD(metric_list);
@@ -1650,14 +1650,14 @@ int metricgroup__parse_groups(const struct option *opt,
 			      struct rblist *metric_events)
 {
 	struct evlist *perf_evlist = *(struct evlist **)opt->value;
-	const struct pmu_event *table = pmu_events_table__find();
+	const struct pmu_events_table *table = pmu_events_table__find();
 
 	return parse_groups(perf_evlist, str, metric_no_group,
 			    metric_no_merge, NULL, metric_events, table);
 }
 
 int metricgroup__parse_groups_test(struct evlist *evlist,
-				   const struct pmu_event *table,
+				   const struct pmu_events_table *table,
 				   const char *str,
 				   bool metric_no_group,
 				   bool metric_no_merge,
@@ -1668,7 +1668,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 }
 
 static int metricgroup__has_metric_callback(const struct pmu_event *pe,
-					    const struct pmu_event *table __maybe_unused,
+					    const struct pmu_events_table *table __maybe_unused,
 					    void *vdata)
 {
 	const char *metric = vdata;
@@ -1684,7 +1684,7 @@ static int metricgroup__has_metric_callback(const struct pmu_event *pe,
 
 bool metricgroup__has_metric(const char *metric)
 {
-	const struct pmu_event *table = pmu_events_table__find();
+	const struct pmu_events_table *table = pmu_events_table__find();
 
 	if (!table)
 		return false;
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 5a1390e73d25..f54d170043e9 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -11,7 +11,6 @@ struct evlist;
 struct evsel;
 struct option;
 struct rblist;
-struct pmu_events_map;
 struct cgroup;
 
 /**
@@ -71,9 +70,9 @@ int metricgroup__parse_groups(const struct option *opt,
 			      bool metric_no_merge,
 			      struct rblist *metric_events);
 const struct pmu_event *metricgroup__find_metric(const char *metric,
-						 const struct pmu_event *table);
+						 const struct pmu_events_table *table);
 int metricgroup__parse_groups_test(struct evlist *evlist,
-				   const struct pmu_event *table,
+				   const struct pmu_events_table *table,
 				   const char *str,
 				   bool metric_no_group,
 				   bool metric_no_merge,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index dd1e171d7480..89655d53117a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -710,7 +710,7 @@ char *perf_pmu__getcpuid(struct perf_pmu *pmu)
 	return cpuid;
 }
 
-__weak const struct pmu_event *pmu_events_table__find(void)
+__weak const struct pmu_events_table *pmu_events_table__find(void)
 {
 	return perf_pmu__find_table(NULL);
 }
@@ -799,7 +799,7 @@ struct pmu_add_cpu_aliases_map_data {
 };
 
 static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
-					const struct pmu_event *table __maybe_unused,
+					const struct pmu_events_table *table __maybe_unused,
 					void *vdata)
 {
 	struct pmu_add_cpu_aliases_map_data *data = vdata;
@@ -827,7 +827,7 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
  * as aliases.
  */
 void pmu_add_cpu_aliases_table(struct list_head *head, struct perf_pmu *pmu,
-			       const struct pmu_event *table)
+			       const struct pmu_events_table *table)
 {
 	struct pmu_add_cpu_aliases_map_data data = {
 		.head = head,
@@ -841,7 +841,7 @@ void pmu_add_cpu_aliases_table(struct list_head *head, struct perf_pmu *pmu,
 
 static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 {
-	const struct pmu_event *table;
+	const struct pmu_events_table *table;
 
 	table = perf_pmu__find_table(pmu);
 	if (!table)
@@ -856,7 +856,7 @@ struct pmu_sys_event_iter_data {
 };
 
 static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
-				       const struct pmu_event *table __maybe_unused,
+				       const struct pmu_events_table *table __maybe_unused,
 				       void *data)
 {
 	struct pmu_sys_event_iter_data *idata = data;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index f0aba1e462fa..a7b0f9507510 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -126,10 +126,10 @@ int perf_pmu__test(void);
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
 void pmu_add_cpu_aliases_table(struct list_head *head, struct perf_pmu *pmu,
-			       const struct pmu_event *table);
+			       const struct pmu_events_table *table);
 
 char *perf_pmu__getcpuid(struct perf_pmu *pmu);
-const struct pmu_event *pmu_events_table__find(void);
+const struct pmu_events_table *pmu_events_table__find(void);
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 void perf_pmu_free_alias(struct perf_pmu_alias *alias);
 
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 235319d45d02..9a631d97471c 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -135,7 +135,7 @@ struct get_counter_name_data {
 };
 
 static int get_counter_name_callback(const struct pmu_event *evp,
-				     const struct pmu_event *table __maybe_unused,
+				     const struct pmu_events_table *table __maybe_unused,
 				     void *vdata)
 {
 	struct get_counter_name_data *data = vdata;
@@ -157,7 +157,7 @@ static int get_counter_name_callback(const struct pmu_event *evp,
  * the name of this counter.
  * If no match is found a NULL pointer is returned.
  */
-static const char *get_counter_name(int set, int nr, const struct pmu_event *table)
+static const char *get_counter_name(int set, int nr, const struct pmu_events_table *table)
 {
 	struct get_counter_name_data data = {
 		.wanted = get_counterset_start(set) + nr,
@@ -177,7 +177,7 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
 	unsigned char *buf = sample->raw_data;
 	const char *color = PERF_COLOR_BLUE;
 	struct cf_ctrset_entry *cep, ce;
-	const struct pmu_event *table;
+	const struct pmu_events_table *table;
 	u64 *p;
 
 	table = pmu_events_table__find();
-- 
2.37.1.595.g718a3a8f04-goog

