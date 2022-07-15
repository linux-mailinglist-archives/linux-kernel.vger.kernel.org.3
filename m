Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0535F575BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiGOGhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiGOGhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:37:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48DE39BA8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31c8a5d51adso33928187b3.14
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L4iowk5wYqRaAGjNPtLjJJhNjdR47ELfV75N84bSpCk=;
        b=N9ncQpK7YRAq8GE173zVLt1JksQ3A31a5rUJgBmzZiCVx3bNads+WIg1XnimaaZZ9f
         T8eLBus1gQR5WBc70JH+c47e2E//tC3NMb5C8QA2Gw0yNASZzPcjlIp8H76modkRyF8h
         ZH2roRndB1fIcyjjKMtrvqjuA/uvaaMmoGVT2onoc3+ReW/6bZWLXQcmk0YCH8pGmfkb
         S6ktJ7Oo/4CpoGO20G8eN13XAFt7weHAsvbXAQrxjwHwo9+CWN7FzMQPDmbTBdzOGwEh
         E5mXxUY7KoHgpH4cESq3cVTBgBRL3WzUEgk2f+N9Jxnngg66fQsVyXO7i+M8Ah9gVXzV
         XVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L4iowk5wYqRaAGjNPtLjJJhNjdR47ELfV75N84bSpCk=;
        b=RvQRZdQ9pJK6bi7B2eD/RoUWlhbNjwM6lR5vhmqeTHfD7MMVolW4xc+DyRGma8bcVh
         AtjRHOtqCH7SzaYQLuHVTH3JEILEiIsPmLz+O592i+/Htv6xm/f3Rc/P5Bit1pji8wxx
         oKJqT4W3nrSRIRMGXRb/PmxIFOBYXeYfSGO/XB9VUDggdIz58QMO0jySccMa44Q0Lt7H
         bFJ9D3axJ3HiZtF2SO3TKPUDOlzO+eQetouaLgBR4P2sao3rGqK6bvrnp6Za8F92YCOM
         ltDzHugf/Ik0lgZ1A4Llbm8Lm20XQMBt6e0FZ9TZdRKG1saio/Ikl4UK+gB8niwPrqfn
         TrXA==
X-Gm-Message-State: AJIora8jzniHx/+cPgUAoP1e+EoOVfH5jx0RRxMk1xZR6x4GcZGIa0ZL
        76zckBLp6cxqvHrV/0jqSqO807pNSRsi
X-Google-Smtp-Source: AGRyM1swL9lZ/OFGz/mUSm+HvcI5O3CXjv9RYoofejL5lzQ3Q9NAc5Rk0Xz7/w9goTjhFM3nrLEtFueMWzic
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e8fe:2a8e:e0f6:318d])
 (user=irogers job=sendgmr) by 2002:a5b:9c5:0:b0:66e:cbbf:2904 with SMTP id
 y5-20020a5b09c5000000b0066ecbbf2904mr11861191ybq.220.1657867041212; Thu, 14
 Jul 2022 23:37:21 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:36:41 -0700
In-Reply-To: <20220715063653.3203761-1-irogers@google.com>
Message-Id: <20220715063653.3203761-4-irogers@google.com>
Mime-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v1 03/15] perf jevent: Add an 'all' architecture argument
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
index 4a170f23bd67..2a9a1a086dee 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -305,38 +305,45 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
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
 
@@ -387,15 +394,24 @@ def main() -> None:
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
index 478b33825790..0c9439cf77e1 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -855,8 +855,7 @@ static void expr_failure(const char *msg,
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
2.37.0.170.g444d1eabd0-goog

