Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898B858483C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 00:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiG1W26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 18:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiG1W2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 18:28:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2245879EE7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:28:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f5960500bso27296857b3.14
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PAMYE5nA6x/0rM4fcpKEc44VpXtkeHXLPztYWQSShps=;
        b=q7GyLPMQg08wMiGOvxfosdUGgOzBaCMvKsPXzf6wuMTNM/5qIo45oFwR0Rcs0OeF7v
         PehNR9fwBji2AybRece8ziGLURVbjIr7Z8rejoJIMA6T3Nq5PqdRf8ZwGWj7pmdbNhsM
         bX9dvnWfO5im6u4OeSbaG4FfGHJQ7YIhl8W+ZHA8ZANfx3L29NgUQzDQsHqES6zuOwbA
         OxgBBFC2Q3XjiOADPHif20mL42ImAygV43tb4oSYcE7KWD2IY5sj87qwOUSN3UMM8++T
         zbfJXAOumJr2CGpj8Ma0jihKtn1Et0UMPHLExBW/FNE3LBnBjB5AdR7vSxzR/KxIa0y7
         EI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PAMYE5nA6x/0rM4fcpKEc44VpXtkeHXLPztYWQSShps=;
        b=zZIg/QLfWLnwLitZZpjGMBGNpRVe19jdyHb4HnYEHgByzcOVd6KF8QIKjaG2M4SF0g
         xG9cCk6StlF3n1EseyQ/TQtyn5Rre3G2FrUJOXqH9hMAzKLD91wojpgQS2zLp0wQ/xFn
         kixx+h0GOfAfyXo8MQFETbBDZbqPfbwbesJGDZUV5Z68OAFc7AmDDDwHtdEiE3xLAb/H
         BWfgqOv4Q5FmsYPXLl1Wu8+ietdIQLl15XA1Qf9zwFrOcZdQY9QFOomagoA5lIz4jXzD
         bZrl/7oby7TpLsN6oux/2npurKj2PSisGudhdE0cXLH1ZsgyZYL417AKQFMuz5gk/B2s
         o+/w==
X-Gm-Message-State: ACgBeo1JtYh4O1Z8NJgKfO46CPzp60AtAqNErenElC1zsIYOiMHjHThd
        02U1LC+gYh59TefC7VjuCRBypB6ZzA8W
X-Google-Smtp-Source: AA6agR7n1AM/sEDK2WOQ5AYm51RX7umbHFqJMTPU2Yss9M5FDQkRVwxvAreZ3zvNVfgW9qwR1gcFmdpH9ZMN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fd09:96c3:28af:b08f])
 (user=irogers job=sendgmr) by 2002:a25:d00d:0:b0:671:8a46:b00b with SMTP id
 h13-20020a25d00d000000b006718a46b00bmr639021ybg.173.1659047327341; Thu, 28
 Jul 2022 15:28:47 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:28:22 -0700
In-Reply-To: <20220728222835.3254224-1-irogers@google.com>
Message-Id: <20220728222835.3254224-4-irogers@google.com>
Mime-Version: 1.0
References: <20220728222835.3254224-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v2 03/16] perf jevent: Add an 'all' architecture argument
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

