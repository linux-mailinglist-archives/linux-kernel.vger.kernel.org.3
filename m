Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD7584CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiG2Hpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiG2Ho5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D29E81B03
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f46b4759bso36515287b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LRUf8d+uURXL8SFXLgyV3gEjVEvyagZOOmx5cGvuJJs=;
        b=Gm1u/Sc9Ujk0HD2StHcNwyJbN78keb1bm/Jz1Gi4C2ycVyK3Dlp5nQPpdoOKeAOZ4m
         Qh4yvrxF53P0gKQmrw8uSfCML/RDQOtisVTMTjH/SBD/10CxQyr4PhAQ1vDAo4aTWvby
         M5oA0BqwelZuR1cLrEnrTvNsTAJrQ2Z966j2ImqKWFbGey0aDOZfJj8guBTX0wHiJ+dJ
         /oWZWGGhDyY+L4A1axvbC/hRbA834iaQCRBHVVpTObXKWywlFiEmM5g+xr6PYz46XJcg
         Bhmb3Kp7tuB8GqRXjmOZDHcvCYivO6JdNJ5qX09+BV+uMg5/3rkDupGTxK0ZV25xvzIU
         AnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LRUf8d+uURXL8SFXLgyV3gEjVEvyagZOOmx5cGvuJJs=;
        b=oP92zOAQUam6FGpLDheYH8QKvHe0qGWC9hZwGadcDWdPHhIAETaz4OqBZ0H4l9Ppcg
         K0omRgl3uTW+DDjxtgGawtTMomW//7YFpkS/Ls7GjcdDk7MMXPG5dJfnoQRTPFi+IWuc
         R8JUa4rnHjt4RYoXDiGo3WRNGaYRWd7I1ZTz1VSFL++pGGWNOARH9TtwA2mS8BDzes9K
         EqcokX0AnEuXhJcM85OHQYm0B4/mgVpcW04woFEvBXa0nJ4hlF+sr6lts4fULK36hxXX
         NU/axNlTRMckQh6C4EIbHXiKpSz1rM0r6C7BkzSSE74Fsmdi+rGN7psQExMKGEOkfHim
         Jyuw==
X-Gm-Message-State: ACgBeo0svWHEscb2im5JuuTQexfXeejCYqkB6Dv9C6JyZSWJXDc+FoP/
        ZveJaOQZXzJqjHBTNKgqWRlwAlob3jTl
X-Google-Smtp-Source: AA6agR7iT1NwWyMqAJ1jxVyIPRgvozaMjfN1CoV84qYye7v1G98MN/uWPv1gSNoTb1YPCyqKZj3+NfniwJoH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a81:5a09:0:b0:31e:77a0:6f45 with SMTP id
 o9-20020a815a09000000b0031e77a06f45mr2069610ywb.59.1659080682920; Fri, 29 Jul
 2022 00:44:42 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:50 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-17-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 16/17] perf jevents: Compress the pmu_events_table
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
index aa8df649025a..a5e162558994 100755
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
@@ -202,26 +276,18 @@ class JsonEvent:
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
@@ -236,7 +302,6 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
     event.topic = topic
   return result
 
-
 def preprocess_arch_std_files(archpath: str) -> None:
   """Read in all architecture standard events."""
   global _arch_std_events
@@ -252,7 +317,7 @@ def print_events_table_prefix(tblname: str) -> None:
   global _close_table
   if _close_table:
     raise IOError('Printing table prefix but last table has no suffix')
-  _args.output_file.write(f'static const struct pmu_event {tblname}[] = {{\n')
+  _args.output_file.write(f'static const struct compact_pmu_event {tblname}[] = {{\n')
   _close_table = True
 
 
@@ -267,13 +332,13 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
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
@@ -285,23 +350,37 @@ def print_events_table_suffix() -> None:
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
@@ -336,7 +415,8 @@ def print_mapping_table(archs: Sequence[str]) -> None:
   _args.output_file.write("""
 /* Struct used to make the PMU event table implementation opaque to callers. */
 struct pmu_events_table {
-        const struct pmu_event *entries;
+        const struct compact_pmu_event *entries;
+        size_t length;
 };
 
 /*
@@ -364,7 +444,10 @@ const struct pmu_events_map pmu_events_map[] = {
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
@@ -379,7 +462,10 @@ const struct pmu_events_map pmu_events_map[] = {
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
@@ -387,7 +473,7 @@ const struct pmu_events_map pmu_events_map[] = {
   _args.output_file.write("""{
 \t.arch = 0,
 \t.cpuid = 0,
-\t.table = { 0 },
+\t.table = { 0, 0 },
 }
 };
 """)
@@ -405,23 +491,41 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
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
@@ -530,7 +634,7 @@ def main() -> None:
       help='Root of tree containing architecture directories containing json files'
   )
   ap.add_argument(
-      'output_file', type=argparse.FileType('w'), nargs='?', default=sys.stdout)
+      'output_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=sys.stdout)
   _args = ap.parse_args()
 
   _args.output_file.write("""
@@ -540,6 +644,10 @@ def main() -> None:
 #include <string.h>
 #include <stddef.h>
 
+struct compact_pmu_event {
+  int offset;
+};
+
 """)
   archs = []
   for item in os.scandir(_args.starting_dir):
@@ -555,6 +663,15 @@ def main() -> None:
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
2.37.1.455.g008518b4e5-goog

