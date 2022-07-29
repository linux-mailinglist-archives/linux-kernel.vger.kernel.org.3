Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F00584CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiG2Ho1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiG2HoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E258814BF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m123-20020a253f81000000b0066ff6484995so3298838yba.22
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EjcW2819bK3ME3rSbBlXh7xG57ULhBVjyEq6SCnJgHs=;
        b=Q+jaj+dVmVWsljBSPYTpmdqOXVicg9AGaWh1ve7iGaro2yUiFb9EbEpzlHcUumAh+I
         birhsTaWS7VUc7Ai6egLJUB6iZ9Y8q7Gw/NOCuivCXrSPl1guInU8wHgfLMyGyRcpJOU
         jiomfTWcm8zrpnK7X91SWa2YQa4i4XnHrXT4245hwxHM00pdOsQW+5RrBkEj02Os8EMS
         9ylCnAe2AzstfykP8LDN7qEGUb0Ir3430t2OU3y4nRGWOGq2mpK3G+p6AiPzKGTwlkSX
         cTdC1uG/nZ8rsBIG4s+DFbJMETYZ3xw7GQME93y0np2DMlSDFmpD890446EhAweaY4Ce
         NNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EjcW2819bK3ME3rSbBlXh7xG57ULhBVjyEq6SCnJgHs=;
        b=H83G6oJZdNW0wA4kMB8HXnF2bQtlzJuF/1d0JroNYtHRg09sB7K7Gad1UG18MOhG8R
         8Omwm4MSHlWVErPtJ7OsfqNu7uJ8bukJWMp8/qqTy3z5C8Q7YU4sqnv0nn/3cPbcBPs4
         4DsaQ2KiUn8sAgibt3IPy4PXqVkdFGq7n37W/LVS2ttYmbOm4XynVHhquCWPO7Bu91Tw
         k9y5eCGBmleJ/jN45v3CaPFwOYdQWZtN/s4b49nfWlN212XJK6nFTpDoMvcLZ4YshRSM
         tNMGk/Oj0RlO1hCbiToxj3eLkc9UfIC1mI6HSmnyfQ/AZJ9E0haem1MtJVyCsevJVEy4
         tU4Q==
X-Gm-Message-State: ACgBeo152Ne6LGYpzMIrUCWLzjkotzBCoP2hMJkK+iw/y2zI1QFmH9v6
        QGDTMOIjb4TUEb4VlxFK3RRqXk95mGdP
X-Google-Smtp-Source: AA6agR7FJFm/zePAwFdaLuEQB8H/PqGRX8IU3YjwZixunkmchzQY1GHOYMRcP36hjVCwrEMBWBNzE4eKg1XC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a25:19d5:0:b0:670:7c04:8593 with SMTP id
 204-20020a2519d5000000b006707c048593mr1551592ybz.95.1659080652160; Fri, 29
 Jul 2022 00:44:12 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:38 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-5-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 04/17] perf jevent: Add an 'all' architecture argument
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

When 'all' is passed as the architecture generate a mapping table for
all architectures. This simplifies testing. To identify the table for an
architecture add an arch variable to the pmu_events_map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py   | 70 ++++++++++++++++++------------
 tools/perf/pmu-events/pmu-events.h |  1 +
 tools/perf/tests/pmu-events.c      |  3 +-
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index cdfa4e0e7557..e6e6c42c3f8a 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -304,38 +304,45 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   print_events_table_entries(item, get_topic(item.name))
 
 
-def print_mapping_table() -> None:
+def print_mapping_table(archs: Sequence[str]) -> None:
   """Read the mapfile and generate the struct from cpuid string to event table."""
-  with open(f'{_args.starting_dir}/{_args.arch}/mapfile.csv') as csvfile:
-    table = csv.reader(csvfile)
-    _args.output_file.write(
-        'const struct pmu_events_map pmu_events_map[] = {\n')
-    first = True
-    for row in table:
-      # Skip the first row or any row beginning with #.
-      if not first and len(row) > 0 and not row[0].startswith('#'):
-        tblname = file_name_to_table_name([], row[2].replace('/', '_'))
-        _args.output_file.write("""{
-\t.cpuid = \"%s\",
-\t.version = \"%s\",
-\t.type = \"%s\",
-\t.table = %s
-},
-""" % (row[0].replace('\\', '\\\\'), row[1], row[3], tblname))
-      first = False
-
-  _args.output_file.write("""{
+  _args.output_file.write('const struct pmu_events_map pmu_events_map[] = {\n')
+  for arch in archs:
+    if arch == 'test':
+      _args.output_file.write("""{
+\t.arch = "testarch",
 \t.cpuid = "testcpu",
 \t.version = "v1",
 \t.type = "core",
 \t.table = pme_test_soc_cpu,
 },
-{
+""")
+    else:
+      with open(f'{_args.starting_dir}/{arch}/mapfile.csv') as csvfile:
+        table = csv.reader(csvfile)
+        first = True
+        for row in table:
+          # Skip the first row or any row beginning with #.
+          if not first and len(row) > 0 and not row[0].startswith('#'):
+            tblname = file_name_to_table_name([], row[2].replace('/', '_'))
+            cpuid = row[0].replace('\\', '\\\\')
+            _args.output_file.write(f"""{{
+\t.arch = "{arch}",
+\t.cpuid = "{cpuid}",
+\t.version = "{row[1]}",
+\t.type = "{row[3]}",
+\t.table = {tblname}
+}},
+""")
+          first = False
+
+  _args.output_file.write("""{
+\t.arch = 0,
 \t.cpuid = 0,
 \t.version = 0,
 \t.type = 0,
 \t.table = 0,
-},
+}
 };
 """)
 
@@ -386,15 +393,24 @@ def main() -> None:
   _args = ap.parse_args()
 
   _args.output_file.write("#include \"pmu-events/pmu-events.h\"\n")
-  for path in [_args.arch, 'test']:
-    arch_path = f'{_args.starting_dir}/{path}'
-    if not os.path.isdir(arch_path):
-      raise IOError(f'Missing architecture directory in \'{arch_path}\'')
+  archs = []
+  for item in os.scandir(_args.starting_dir):
+    if not item.is_dir():
+      continue
+    if item.name == _args.arch or _args.arch == 'all' or item.name == 'test':
+      archs.append(item.name)
+
+  if len(archs) < 2:
+    raise IOError(f'Missing architecture directory \'{_args.arch}\'')
+
+  archs.sort()
+  for arch in archs:
+    arch_path = f'{_args.starting_dir}/{arch}'
     preprocess_arch_std_files(arch_path)
     ftw(arch_path, [], process_one_file)
     print_events_table_suffix()
 
-  print_mapping_table()
+  print_mapping_table(archs)
   print_system_mapping_table()
 
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 6efe73976440..7a360792635f 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -38,6 +38,7 @@ struct pmu_event {
  * The  cpuid can contain any character other than the comma.
  */
 struct pmu_events_map {
+	const char *arch;
 	const char *cpuid;
 	const char *version;
 	const char *type;		/* core, uncore etc */
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 263cbb67c861..82192f1a7bf7 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -864,8 +864,7 @@ static void expr_failure(const char *msg,
 			 const struct pmu_events_map *map,
 			 const struct pmu_event *pe)
 {
-	pr_debug("%s for map %s %s %s\n",
-		msg, map->cpuid, map->version, map->type);
+	pr_debug("%s for map %s %s\n", msg, map->arch, map->cpuid);
 	pr_debug("On metric %s\n", pe->metric_name);
 	pr_debug("On expression %s\n", pe->metric_expr);
 }
-- 
2.37.1.455.g008518b4e5-goog

