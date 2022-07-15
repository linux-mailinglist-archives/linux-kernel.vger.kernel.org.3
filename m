Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C72575BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiGOGjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiGOGiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:38:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63D339BA8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31cdce3ed04so34248887b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=beKV48gy99vIAwtgAeGtaSuKZ54r5ACAI0HyC9yoOg8=;
        b=A/v6fiMJrcGC08KOVhEOEeV0kEpa0YZRkzC69081qaFQ4mHBxhCxhgPIiKj3WpIryD
         gzt0ipqMPjlwi1ySAlQPAkiDj/2wOaHaMTXEXeq/lMhaOrZbiga6Y69MKiJR2zLBpvGG
         jDA0STw/ftyogFYMTV+7uUDkQm6ckWZAvRqmSkW6ijyQGXIS7BtENAd87rsnE9QhOJwB
         90dWfjwTOCcWeYgbD3yHMjVDFVL3ceB74AigawOBSfrTvxgCS+uvoBWUNm5Y0bFIepwa
         GhAfLuZ/+VNeIGgfoqI92qdOyDVztO7jhCTofTrL6p8XROtFoW0sl2txKRf1FHo0F8bR
         Zp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=beKV48gy99vIAwtgAeGtaSuKZ54r5ACAI0HyC9yoOg8=;
        b=rC8GZJjse/caWEu61NOIIPOUHHMhmcdWW5DSjpumlEiLT595F5jAkD57X8ZTudX5bB
         8/75iW61CI7HvV3+A2+VK1VV1GKiE7cK0S8TgwFBfhj1M9CxtUkQKTCYRZ9T/mbYtav8
         U/2mxvzXdptRphCCk/xlSkbH6CUZ2m3GZxulcdHhCgKOz4DfFtLwdIQr/dVVXjZU+8hx
         +LqBPPkCrJ5u4s/SFC9huxx2h0YLYz3W0+iRJ3koNhjVuIgLaT/L/7DS/hWggzazhG8D
         FZmZLv9sPsaFSBaIwsS2KSHXBAoGBx/9HA+2VKMvEugl9WoEcoY0DTE+5xY7cwIb3ScO
         3L3g==
X-Gm-Message-State: AJIora+kTTFj/Qpz6VVYxCfjMTCCUr6uB5gHc5w7c3db+OBDxCNP+Abt
        NyGAO70ge3r5iGWDaRdL5vmjCQZuASU8
X-Google-Smtp-Source: AGRyM1uSn12IaxfKgrkafNp/45Xlxh6eQ05Z3qPqMRHLh4liPu9tvulwtacZnOv4SZcCsVjWtY7UdSH99GjP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e8fe:2a8e:e0f6:318d])
 (user=irogers job=sendgmr) by 2002:a05:6902:102f:b0:66f:1145:af6e with SMTP
 id x15-20020a056902102f00b0066f1145af6emr12321111ybt.509.1657867071409; Thu,
 14 Jul 2022 23:37:51 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:36:53 -0700
In-Reply-To: <20220715063653.3203761-1-irogers@google.com>
Message-Id: <20220715063653.3203761-16-irogers@google.com>
Mime-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v1 15/15] perf jevents: Compress the pmu_events_table
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

The pmu_events array requires 15 pointers per entry which in position
independent code need relocating. Change the array to be an array of
offsets within a big C string. Only the offset of the first variable is
required, subsequent variables are stored in order after the \0
terminator (requiring a byte per variable rather than 4 bytes per
offset).

The file size savings are:
no jevents - the same 19,579,104bytes
x86 jevents - ~12.5% file size saving 22,088,944bytes vs 25,235,048bytes
all jevents - ~15.8% file size saving 22,821,896bytes vs 27,106,648bytes
default build options plus NO_LIBBFD=1.

For example, the x86 build savings come from .rela.dyn and
.data.rel.ro becoming smaller by 1,911,072bytes and 2,022,656bytes
respectively. .rodata increases by 789,600bytes, giving an overall
3,146,104bytes saving.

To make metric strings more shareable, the topic is changed from say
'skx metrics' to just 'metrics'.

To try to help with the memory layout the pmu_events are ordered as used
by perf qsort comparator functions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 236 +++++++++++++++++++++++++------
 1 file changed, 193 insertions(+), 43 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index d7e03864ca6a..b5bc25790695 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -6,8 +6,8 @@ import csv
 import json
 import os
 import sys
-from typing import Callable
-from typing import Sequence
+from typing import (Callable, Dict, Sequence, Set)
+import collections
 
 # Global command line arguments.
 _args = None
@@ -21,6 +21,19 @@ _arch_std_events = {}
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
@@ -40,6 +53,100 @@ def file_name_to_table_name(parents: Sequence[str], dirname: str) -> str:
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
+  relocation. To reduce the size of the string further, identical
+  strings are merged. If a longer string ends-with the same value as a
+  shorter string, these entries are also merged.
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
+    folded_strings = {}
+    # Determine if two strings can be folded, ie. let 1 string use the
+    # end of another. First reverse all strings and sort them.
+    sorted_reversed_strings = sorted([x[::-1] for x in self.strings])
+    # Strings 'xyz' and 'yz' will now be [ 'zy', 'zyx' ]. Scan forward
+    # for each string to see if there is a better candidate to fold it
+    # into, in the example rather than using 'yz' we can use'xyz' at
+    # an offset of 1.
+    for pos,s in enumerate(sorted_reversed_strings):
+      best_pos = pos
+      for check_pos in range(pos + 1, len(sorted_reversed_strings)):
+        if sorted_reversed_strings[check_pos].startswith(s):
+          best_pos = check_pos
+        else:
+          break
+      if pos != best_pos:
+        folded_strings[s[::-1]] = sorted_reversed_strings[best_pos][::-1]
+    # Compute reverse mappings for debugging.
+    fold_into_strings = collections.defaultdict(set)
+    for key, val in folded_strings.items():
+      if key != val:
+        fold_into_strings[val].add(key)
+    # big_string_offset is the current location within the C string
+    # being appended to - comments, etc. don't count. big_string is
+    # the string contents represented as a list. Strings are immutable
+    # in Python and so appending to one causes memory issues, while
+    # lists are mutable.
+    big_string_offset = 0
+    self.big_string = []
+    self.offsets = {}
+    # Emit all strings that aren't folded in a sorted manner.
+    for s in sorted(self.strings):
+      if s not in folded_strings:
+        self.offsets[s] = big_string_offset
+        self.big_string.append(f'/* offset={big_string_offset} */ "')
+        self.big_string.append(s)
+        self.big_string.append('"')
+        if s in fold_into_strings:
+          self.big_string.append(' /* also: ' + ', '.join(fold_into_strings[s]) + ' */')
+        self.big_string.append('\n')
+        big_string_offset += c_len(s)
+        continue
+    # Compute the offsets of the folded strings.
+    for s in folded_strings.keys():
+      assert s not in self.offsets
+      folded_s = folded_strings[s]
+      self.offsets[s] = self.offsets[folded_s] + c_len(folded_s) - c_len(s)
+
+_bcs = BigCString()
 
 class JsonEvent:
   """Representation of an event loaded from a json file dictionary."""
@@ -203,26 +310,18 @@ class JsonEvent:
         s += f'\t{attr} = {value},\n'
     return s + '}'
 
+  def build_c_string(self):
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
@@ -237,7 +336,6 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
     event.topic = topic
   return result
 
-
 def preprocess_arch_std_files(archpath: str) -> None:
   """Read in all architecture standard events."""
   global _arch_std_events
@@ -253,7 +351,7 @@ def print_events_table_prefix(tblname: str) -> None:
   global _close_table
   if _close_table:
     raise IOError('Printing table prefix but last table has no suffix')
-  _args.output_file.write(f'static const struct pmu_event {tblname}[] = {{\n')
+  _args.output_file.write(f'static const struct compact_pmu_event {tblname}[] = {{\n')
   _close_table = True
 
 
@@ -286,23 +384,37 @@ def print_events_table_suffix() -> None:
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
@@ -337,7 +449,8 @@ def print_mapping_table(archs: Sequence[str]) -> None:
   _args.output_file.write("""
 /* Struct used to make the PMU event table implementation opaque to callers. */
 struct pmu_events_table {
-        const struct pmu_event *entries;
+        const struct compact_pmu_event *entries;
+        size_t length;
 };
 
 /*
@@ -365,7 +478,10 @@ const struct pmu_events_map pmu_events_map[] = {
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
@@ -380,7 +496,10 @@ const struct pmu_events_map pmu_events_map[] = {
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
@@ -388,7 +507,7 @@ const struct pmu_events_map pmu_events_map[] = {
   _args.output_file.write("""{
 \t.arch = 0,
 \t.cpuid = 0,
-\t.table = { 0 },
+\t.table = { 0, 0 },
 }
 };
 """)
@@ -406,23 +525,41 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
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
@@ -531,7 +668,7 @@ def main() -> None:
       help='Root of tree containing architecture directories containing json files'
   )
   ap.add_argument(
-      'output_file', type=argparse.FileType('w'), nargs='?', default=sys.stdout)
+      'output_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=sys.stdout)
   _args = ap.parse_args()
 
   _args.output_file.write("""
@@ -541,6 +678,10 @@ def main() -> None:
 #include <string.h>
 #include <stddef.h>
 
+struct compact_pmu_event {
+  int offset;
+};
+
 """)
   archs = []
   for item in os.scandir(_args.starting_dir):
@@ -556,6 +697,15 @@ def main() -> None:
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
2.37.0.170.g444d1eabd0-goog

