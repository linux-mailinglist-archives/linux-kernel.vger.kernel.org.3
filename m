Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01438591784
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 01:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiHLXKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 19:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiHLXJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 19:09:58 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302589AFD6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:09:57 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o18-20020a17090aac1200b001f3252af009so4725779pjq.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=J1wu3JAsrpYRW3cgbnPcwLgMmGyi8dVAgV2C+sDvGds=;
        b=rh6LOBQevZLZ3vjlPMTRWPF8/x1oYFTBC1amlh3vdubakAly13tyvHIphCXpoE+ygF
         0ljVZrCvBBvQebqf12MCJjQJL+YcMz2oKz94qFTbXbtNBdQzcYwx+FyFxb+91HoKwYuv
         1ESQPPfv5y49rWj7Wg999xeK63dZmlwoCHY0gb3nGBOSKd/UG3v0edSUc77VQNYd+dd7
         2quwiVELU020RpXaVAIEGYSg1hQdUjBU3Hh9im/d4wTrSB0sweQPhEnwCPFuriLgv8xX
         Q8r1u4qHN5t9vlPh9CtL7GFTBdihryBcBRis127zMjKh/HQ7hRYA/JnC6BPMwkszLxmV
         zC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=J1wu3JAsrpYRW3cgbnPcwLgMmGyi8dVAgV2C+sDvGds=;
        b=JA1P9bwFC/33fF8wSdkCxMrNOgyWoS7C3IBtN0rcHG1oL9pAPgR8Qi1a3QtXNOeM8W
         QC9pKIPtcQ5FMQIrTVDxDgQgN6HpEJbq3dXmL+iFG7WYKAGUy/diX7RmCU0JJ6qlZ0PA
         k2Fm2IrvAMFIjI9iPNMadxsErBLECHiYls4IW9geQW0/vEV6ut9oDA/O8a9usX1gpOVm
         fS4iF1p1iSfqTZYZVPjpOyeSaQ2CxQ0RVSLcahYs7tLaYGj8oAosTF4bakGQ1xqxKYW/
         kFopDhOKwKJ/qLMQDz13uNGnqAWQJy/E7Lglu6meIoh3eURVRI+CMsCs9pXpRDcZRXCD
         X87w==
X-Gm-Message-State: ACgBeo344C9vqVoy1NhiLb/1MYfoW9WF62IQ36vsBjh9R22SBI9Qdb/N
        bvL05QKqQs3FxfctZG1Z25bojeSvbBIS
X-Google-Smtp-Source: AA6agR6Dv8jBtbUGYe76gOBJHziOxputlqFKuhWWu37vsoZ5E7Ol5MxYOQZVghCdEV3SbvNURAFq5YBBjJ7s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d668:2937:8218:c5ec])
 (user=irogers job=sendgmr) by 2002:a63:2bcc:0:b0:40c:95b5:46a4 with SMTP id
 r195-20020a632bcc000000b0040c95b546a4mr4861111pgr.535.1660345796625; Fri, 12
 Aug 2022 16:09:56 -0700 (PDT)
Date:   Fri, 12 Aug 2022 16:09:36 -0700
In-Reply-To: <20220812230949.683239-1-irogers@google.com>
Message-Id: <20220812230949.683239-2-irogers@google.com>
Mime-Version: 1.0
References: <20220812230949.683239-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v5 01/14] perf jevent: Add an 'all' architecture argument
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
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_SBL_A,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
 tools/perf/pmu-events/empty-pmu-events.c |  2 +
 tools/perf/pmu-events/jevents.py         | 70 +++++++++++++++---------
 tools/perf/pmu-events/pmu-events.h       |  1 +
 tools/perf/tests/pmu-events.c            |  3 +-
 4 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 77e655c6f116..d8cf9283e486 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -110,12 +110,14 @@ static const struct pmu_event pme_test_soc_cpu[] = {
 
 const struct pmu_events_map pmu_events_map[] = {
 	{
+		.arch = "testarch",
 		.cpuid = "testcpu",
 		.version = "v1",
 		.type = "core",
 		.table = pme_test_soc_cpu,
 	},
 	{
+		.arch = 0,
 		.cpuid = 0,
 		.version = 0,
 		.type = 0,
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index c5c9bb186abd..b49a0dd946b7 100755
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
2.37.1.595.g718a3a8f04-goog

