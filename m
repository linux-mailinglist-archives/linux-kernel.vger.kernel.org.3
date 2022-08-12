Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74858591791
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 01:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbiHLXLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 19:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbiHLXKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 19:10:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8633B9BB4B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:10:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-329a474c437so18285007b3.18
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=kEkkZgmgeGRAjvSLiOYPVSUDNqcN4cjGPRNtnVx0v4M=;
        b=mFy3hsjZsBMSPl4fQ5thvJ2IYF2OjBKv5eUqM3GPH3cd3LcVbcU65sYQct3Dquysyw
         iN2e7+mLVhrls6HOjMNSWXXAGyXfgS1LBnJodRuS5/Vg3630TQrPJ1BBch8wMsZCB1uX
         oNrs2kjydc3iaMTH7+BmY6DvaXqF714SVFQZSNZ/JLQfL+I31Fp1SFnQq3f+u07wo1tj
         LOmeagEKGQOXMYip/ZrnTYDRzEKB43rwkex0TVz40KUZmIh0io7M2a+2IUD1LLo18oaI
         ugk9D8+pDpKq24NdVaR/ttfqU2e4ft8Pg4PN+qHlofQ30ejWR4PVfSlJrIslT0vQlvwO
         8U5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=kEkkZgmgeGRAjvSLiOYPVSUDNqcN4cjGPRNtnVx0v4M=;
        b=kDMUT4Wk/BjpaSj4cKep5cnOABHCGza7OQ39E1ctv8deQfahVfQtNLl7tqyJn3xo9k
         nnEIugQVFvoVdtAG0fEs8EGQ1XdYG8l/n68rPCif+FVlTb2Iz5nqIlPS9IfC/58/4KW+
         YL2vgavHBZuAFyvOsdC3Ezik2bb2LLg0bgqCRLegflh9KVnpE3DITD/yYy9oPw6sIfsc
         b8lb3Qq0A44+6Wi2DvzGHn2Ds2nI6GPBoryZs9JrJs0PEe1JTccnHjQqnVhh2dRBPWdf
         7zg/ebWYekSFFel5mB0feXtXDdDa/EvbAF/KGeQ2h/pa534fAZxi+QTQKjj+VpyxW6Ab
         yQ2Q==
X-Gm-Message-State: ACgBeo1Vy/6Uz/5fgBQL2/s/v/RZ7sqRAH69jcwefm6bGaRhOekSqlNk
        iQJK/XjTcop22O+wCQWdC2/+QHLU0YGL
X-Google-Smtp-Source: AA6agR7VsEGB0MTyNO/1utqQTY9epjQ0PNwlz0WQfoXmdpFrfBJGV1roFM10Vs5SwI4j4VQRHi7f0W56MxyM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d668:2937:8218:c5ec])
 (user=irogers job=sendgmr) by 2002:a0d:d9cc:0:b0:329:848f:712d with SMTP id
 b195-20020a0dd9cc000000b00329848f712dmr5874078ywe.38.1660345829598; Fri, 12
 Aug 2022 16:10:29 -0700 (PDT)
Date:   Fri, 12 Aug 2022 16:09:48 -0700
In-Reply-To: <20220812230949.683239-1-irogers@google.com>
Message-Id: <20220812230949.683239-14-irogers@google.com>
Mime-Version: 1.0
References: <20220812230949.683239-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v5 13/14] perf jevents: Compress the pmu_events_table
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmu_events array requires 15 pointers per entry which in position
independent code need relocating. Change the array to be an array of
offsets within a big C string. Only the offset of the first variable is
required, subsequent variables are stored in order after the \0
terminator (requiring a byte per variable rather than 4 bytes per
offset).

The file size savings are:
no jevents - the same 19,788,464bytes
x86 jevents - ~16.7% file size saving 23,744,288bytes vs 28,502,632bytes
all jevents - ~19.5% file size saving 24,469,056bytes vs 30,379,920bytes
default build options plus NO_LIBBFD=1.

For example, the x86 build savings come from .rela.dyn and
.data.rel.ro becoming smaller by 3,157,032bytes and 3,042,016bytes
respectively. .rodata increases by 1,432,448bytes, giving an overall
4,766,600bytes saving.

To make metric strings more shareable, the topic is changed from say
'skx metrics' to just 'metrics'.

To try to help with the memory layout the pmu_events are ordered as used
by perf qsort comparator functions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 207 ++++++++++++++++++++++++-------
 1 file changed, 162 insertions(+), 45 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 4b7948ba57d6..d722fcba2d9f 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -6,7 +6,8 @@ import csv
 import json
 import os
 import sys
-from typing import (Callable, Optional, Sequence)
+from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
+import collections
 
 # Global command line arguments.
 _args = None
@@ -20,6 +21,19 @@ _arch_std_events = {}
 _close_table = False
 # Events to write out when the table is closed
 _pending_events = []
+# Global BigCString shared by all structures.
+_bcs = None
+# Order specific JsonEvent attributes will be visited.
+_json_event_attributes = [
+    # cmp_sevent related attributes.
+    'name', 'pmu', 'topic', 'desc', 'metric_name', 'metric_group',
+    # Seems useful, put it early.
+    'event',
+    # Short things in alphabetical order.
+    'aggr_mode', 'compat', 'deprecated', 'perpkg', 'unit',
+    # Longer things (the last won't be iterated over during decompress).
+    'metric_constraint', 'metric_expr', 'long_desc'
+]
 
 
 def removesuffix(s: str, suffix: str) -> str:
@@ -39,6 +53,66 @@ def file_name_to_table_name(parents: Sequence[str], dirname: str) -> str:
   tblname += '_' + dirname
   return tblname.replace('-', '_')
 
+def c_len(s: str) -> int:
+  """Return the length of s a C string
+
+  This doesn't handle all escape characters properly. It first assumes
+  all \ are for escaping, it then adjusts as it will have over counted
+  \\. The code uses \000 rather than \0 as a terminator as an adjacent
+  number would be folded into a string of \0 (ie. "\0" + "5" doesn't
+  equal a terminator followed by the number 5 but the escape of
+  \05). The code adjusts for \000 but not properly for all octal, hex
+  or unicode values.
+  """
+  try:
+    utf = s.encode(encoding='utf-8',errors='strict')
+  except:
+    print(f'broken string {s}')
+    raise
+  return len(utf) - utf.count(b'\\') + utf.count(b'\\\\') - (utf.count(b'\\000') * 2)
+
+class BigCString:
+  """A class to hold many strings concatenated together.
+
+  Generating a large number of stand-alone C strings creates a large
+  number of relocations in position independent code. The BigCString
+  is a helper for this case. It builds a single string which within it
+  are all the other C strings (to avoid memory issues the string
+  itself is held as a list of strings). The offsets within the big
+  string are recorded and when stored to disk these don't need
+  relocation.
+  """
+  strings: Set[str]
+  big_string: Sequence[str]
+  offsets: Dict[str, int]
+
+  def __init__(self):
+    self.strings = set()
+
+  def add(self, s: str) -> None:
+    """Called to add to the big string."""
+    self.strings.add(s)
+
+  def compute(self) -> None:
+    """Called once all strings are added to compute the string and offsets."""
+
+    # big_string_offset is the current location within the C string
+    # being appended to - comments, etc. don't count. big_string is
+    # the string contents represented as a list. Strings are immutable
+    # in Python and so appending to one causes memory issues, while
+    # lists are mutable.
+    big_string_offset = 0
+    self.big_string = []
+    self.offsets = {}
+    # Emit all strings in a sorted manner.
+    for s in sorted(self.strings):
+      self.offsets[s] = big_string_offset
+      self.big_string.append(f'/* offset={big_string_offset} */ "')
+      self.big_string.append(s)
+      self.big_string.append('"\n')
+      big_string_offset += c_len(s)
+
+_bcs = BigCString()
 
 class JsonEvent:
   """Representation of an event loaded from a json file dictionary."""
@@ -203,26 +277,18 @@ class JsonEvent:
         s += f'\t{attr} = {value},\n'
     return s + '}'
 
+  def build_c_string(self) -> str:
+    s = ''
+    for attr in _json_event_attributes:
+      x = getattr(self, attr)
+      s += f'{x}\\000' if x else '\\000'
+    return s
+
   def to_c_string(self) -> str:
     """Representation of the event as a C struct initializer."""
 
-    def attr_string(attr: str, value: str) -> str:
-      return f'\t.{attr} = \"{value}\",\n'
-
-    def str_if_present(self, attr: str) -> str:
-      if not getattr(self, attr):
-        return ''
-      return attr_string(attr, getattr(self, attr))
-
-    s = '{\n'
-    for attr in [
-        'aggr_mode', 'compat', 'deprecated', 'desc', 'event', 'long_desc',
-        'metric_constraint', 'metric_expr', 'metric_group', 'metric_name',
-        'name', 'perpkg', 'pmu', 'topic', 'unit'
-    ]:
-      s += str_if_present(self, attr)
-    s += '},\n'
-    return s
+    s = self.build_c_string()
+    return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
 
 
 def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
@@ -237,7 +303,6 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
     event.topic = topic
   return result
 
-
 def preprocess_arch_std_files(archpath: str) -> None:
   """Read in all architecture standard events."""
   global _arch_std_events
@@ -253,7 +318,7 @@ def print_events_table_prefix(tblname: str) -> None:
   global _close_table
   if _close_table:
     raise IOError('Printing table prefix but last table has no suffix')
-  _args.output_file.write(f'static const struct pmu_event {tblname}[] = {{\n')
+  _args.output_file.write(f'static const struct compact_pmu_event {tblname}[] = {{\n')
   _close_table = True
 
 
@@ -268,13 +333,13 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
 def print_events_table_suffix() -> None:
   """Optionally close events table."""
 
-  def event_cmp_key(j: JsonEvent):
-    def fix_none(s: str):
+  def event_cmp_key(j: JsonEvent) -> Tuple[bool, str, str, str, str]:
+    def fix_none(s: Optional[str]) -> str:
       if s is None:
         return ''
       return s
 
-    return (not j.desc is None, fix_none(j.topic), fix_none(j.name), fix_none(j.pmu),
+    return (j.desc is not None, fix_none(j.topic), fix_none(j.name), fix_none(j.pmu),
             fix_none(j.metric_name))
 
   global _close_table
@@ -286,23 +351,37 @@ def print_events_table_suffix() -> None:
     _args.output_file.write(event.to_c_string())
     _pending_events = []
 
-  _args.output_file.write("""{
-\t.name = 0,
-\t.event = 0,
-\t.desc = 0,
-},
-};
-""")
+  _args.output_file.write('};\n\n')
   _close_table = False
 
+def get_topic(topic: str) -> str:
+  if topic.endswith('metrics.json'):
+    return 'metrics'
+  return removesuffix(topic, '.json').replace('-', ' ')
+
+def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
+
+  if item.is_dir():
+    return
+
+  # base dir or too deep
+  level = len(parents)
+  if level == 0 or level > 4:
+    return
+
+  # Ignore other directories. If the file name does not have a .json
+  # extension, ignore it. It could be a readme.txt for instance.
+  if not item.is_file() or not item.name.endswith('.json'):
+    return
+
+  topic = get_topic(item.name)
+  for event in read_json_events(item.path, topic):
+    _bcs.add(event.build_c_string())
 
 def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   """Process a JSON file during the main walk."""
   global _sys_event_tables
 
-  def get_topic(topic: str) -> str:
-    return removesuffix(topic, '.json').replace('-', ' ')
-
   def is_leaf_dir(path: str) -> bool:
     for item in os.scandir(path):
       if item.is_dir():
@@ -337,7 +416,8 @@ def print_mapping_table(archs: Sequence[str]) -> None:
   _args.output_file.write("""
 /* Struct used to make the PMU event table implementation opaque to callers. */
 struct pmu_events_table {
-        const struct pmu_event *entries;
+        const struct compact_pmu_event *entries;
+        size_t length;
 };
 
 /*
@@ -365,7 +445,10 @@ const struct pmu_events_map pmu_events_map[] = {
       _args.output_file.write("""{
 \t.arch = "testarch",
 \t.cpuid = "testcpu",
-\t.table = { pme_test_soc_cpu },
+\t.table = {
+\t.entries = pme_test_soc_cpu,
+\t.length = ARRAY_SIZE(pme_test_soc_cpu),
+\t}
 },
 """)
     else:
@@ -380,7 +463,10 @@ const struct pmu_events_map pmu_events_map[] = {
             _args.output_file.write(f"""{{
 \t.arch = "{arch}",
 \t.cpuid = "{cpuid}",
-\t.table = {{ {tblname} }}
+\t.table = {{
+\t\t.entries = {tblname},
+\t\t.length = ARRAY_SIZE({tblname})
+\t}}
 }},
 """)
           first = False
@@ -388,7 +474,7 @@ const struct pmu_events_map pmu_events_map[] = {
   _args.output_file.write("""{
 \t.arch = 0,
 \t.cpuid = 0,
-\t.table = { 0 },
+\t.table = { 0, 0 },
 }
 };
 """)
@@ -406,23 +492,41 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 """)
   for tblname in _sys_event_tables:
     _args.output_file.write(f"""\t{{
-\t\t.table = {{ {tblname} }},
+\t\t.table = {{
+\t\t\t.entries = {tblname},
+\t\t\t.length = ARRAY_SIZE({tblname})
+\t\t}},
 \t\t.name = \"{tblname}\",
 \t}},
 """)
   _args.output_file.write("""\t{
-\t\t.table = { 0 }
+\t\t.table = { 0, 0 }
 \t},
 };
 
-int pmu_events_table_for_each_event(const struct pmu_events_table *table, pmu_event_iter_fn fn,
+static void decompress(int offset, struct pmu_event *pe)
+{
+\tconst char *p = &big_c_string[offset];
+""")
+  for attr in _json_event_attributes:
+    _args.output_file.write(f"""
+\tpe->{attr} = (*p == '\\0' ? NULL : p);
+""")
+    if attr == _json_event_attributes[-1]:
+      continue
+    _args.output_file.write('\twhile (*p++);')
+  _args.output_file.write("""}
+
+int pmu_events_table_for_each_event(const struct pmu_events_table *table,
+                                    pmu_event_iter_fn fn,
                                     void *data)
 {
-        for (const struct pmu_event *pe = &table->entries[0];
-             pe->name || pe->metric_group || pe->metric_name;
-             pe++) {
-                int ret = fn(pe, table, data);
+        for (size_t i = 0; i < table->length; i++) {
+                struct pmu_event pe;
+                int ret;
 
+                decompress(table->entries[i].offset, &pe);
+                ret = fn(&pe, table, data);
                 if (ret)
                         return ret;
         }
@@ -531,7 +635,7 @@ def main() -> None:
       help='Root of tree containing architecture directories containing json files'
   )
   ap.add_argument(
-      'output_file', type=argparse.FileType('w'), nargs='?', default=sys.stdout)
+      'output_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=sys.stdout)
   _args = ap.parse_args()
 
   _args.output_file.write("""
@@ -541,6 +645,10 @@ def main() -> None:
 #include <string.h>
 #include <stddef.h>
 
+struct compact_pmu_event {
+  int offset;
+};
+
 """)
   archs = []
   for item in os.scandir(_args.starting_dir):
@@ -556,6 +664,15 @@ def main() -> None:
   for arch in archs:
     arch_path = f'{_args.starting_dir}/{arch}'
     preprocess_arch_std_files(arch_path)
+    ftw(arch_path, [], preprocess_one_file)
+
+  _bcs.compute()
+  _args.output_file.write('static const char *const big_c_string =\n')
+  for s in _bcs.big_string:
+    _args.output_file.write(s)
+  _args.output_file.write(';\n\n')
+  for arch in archs:
+    arch_path = f'{_args.starting_dir}/{arch}'
     ftw(arch_path, [], process_one_file)
     print_events_table_suffix()
 
-- 
2.37.1.595.g718a3a8f04-goog

