Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C39584CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiG2Hoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiG2HoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:21 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E877CB68
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:20 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c21-20020a624e15000000b0052abf43401fso1639838pfb.14
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3yOwoFZ3Wf3i4mCbDyBSkX0NefzV6upIW3aFDzVLgcY=;
        b=XWlzqABpM6mfUKHqdgs03Q1OMATyLjTsT+obDuGtUoYQ2Suf2CieHkfRGSuBk1qCQK
         Z46IBmlwp0snGR8PF6G3rEx+eyM/ooZGwfJW5c9kwfQJu5Nt70RO1H+DIQB6skalORNq
         bGzIvYaFCAXGHbNgsrUYxVgjSz8OLHmNtmkOoe+6A5YrHwEqFHyi8we11fObjVt6S/C8
         6Zg/qKT7coGx4Fp2xCxAN/Odl7C6L6nOkddiN3Xaju1DvmFhrwnqaPxprBUpOdECobUe
         M3+xJVc0ROzH332G6SyXz+AQhsv9Ulan8vnh/pb3n7tS8CIQ/JGH1gZra1+1IRThykpB
         cauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3yOwoFZ3Wf3i4mCbDyBSkX0NefzV6upIW3aFDzVLgcY=;
        b=NugwnXSxYeXqWd1u2Rxev0cTvXPlLWYPzRF9+OcbZHLF+EBlbmrbnic0dmu/i7Yi6z
         l16+3U7D3EjSiZI434ZHk4QAH+1IrJpDI0h5b5F88HqAlVVzB3qY2pxr79cL75iN6yik
         h1NkqYymGDfOA2hKkd7HJIPMLE0iqTweyre8Cy8o1xDrBIJbWQUhPZfBMosmEWZbGb0d
         pbf0aPcQK4rn/Rm1nhoVW4vghZouIDQu+X53Xw11OEyZ4PAbiXHfgwKrIqnRPIj5fVfn
         /E+b9YA45Y7GZ8+2JhTLi1wJ0c1W2dJQDD4wL87JOYLO7g4Lf2bDu42203Ttp91pFr6n
         omCA==
X-Gm-Message-State: ACgBeo05kw1E4hi2b0DYKY58yivJ7CiM14A4oAwnLhV80BHPUOxJ9t3d
        sVI6xT2Ek5IsS9MUpt8mR57DAYR6ooKl
X-Google-Smtp-Source: AA6agR4X2OdUFG3Qzn8PCM8EFybFzGARwPe8r1WhL3LwDYzR0P8x9tl8f4DrUGUCiSqSNOhjh2ZjnCQFRyF6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a17:90a:94c2:b0:1f3:2590:8693 with SMTP id
 j2-20020a17090a94c200b001f325908693mr3400234pjw.153.1659080659864; Fri, 29
 Jul 2022 00:44:19 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:41 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-8-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 07/17] perf jevents: Sort json files entries
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

Sort the json files entries on conversion to C. The sort order tries to
replicated cmp_sevent from pmu.c so that the input there is already
sorted except for sysfs events.

Add the topic to JsonEvent on reading to simplify. Remove an unnecessary
lambda in the json reading.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 48 +++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 12d2daf3570c..30e0e792221a 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -18,6 +18,8 @@ _sys_event_tables = []
 _arch_std_events = {}
 # Track whether an events table is currently being defined and needs closing.
 _close_table = False
+# Events to write out when the table is closed
+_pending_events = []
 
 
 def removesuffix(s: str, suffix: str) -> str:
@@ -127,6 +129,7 @@ class JsonEvent:
       eventcode |= int(jd['ExtSel']) << 8
     configcode = int(jd['ConfigCode'], 0) if 'ConfigCode' in jd else None
     self.name = jd['EventName'].lower() if 'EventName' in jd else None
+    self.topic = ''
     self.compat = jd.get('Compat')
     self.desc = fixdesc(jd.get('BriefDescription'))
     self.long_desc = fixdesc(jd.get('PublicDescription'))
@@ -199,7 +202,7 @@ class JsonEvent:
         s += f'\t{attr} = {value},\n'
     return s + '}'
 
-  def to_c_string(self, topic_local: str) -> str:
+  def to_c_string(self) -> str:
     """Representation of the event as a C struct initializer."""
 
     def attr_string(attr: str, value: str) -> str:
@@ -211,25 +214,27 @@ class JsonEvent:
       return attr_string(attr, getattr(self, attr))
 
     s = '{\n'
-    s += f'\t.topic = "{topic_local}",\n'
     for attr in [
         'aggr_mode', 'compat', 'deprecated', 'desc', 'event', 'long_desc',
         'metric_constraint', 'metric_expr', 'metric_group', 'metric_name',
-        'name', 'perpkg', 'pmu', 'unit'
+        'name', 'perpkg', 'pmu', 'topic', 'unit'
     ]:
       s += str_if_present(self, attr)
     s += '},\n'
     return s
 
 
-def read_json_events(path: str) -> Sequence[JsonEvent]:
+def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
   """Read json events from the specified file."""
 
   try:
-    return json.load(open(path), object_hook=lambda d: JsonEvent(d))
+    result = json.load(open(path), object_hook=JsonEvent)
   except BaseException as err:
     print(f"Exception processing {path}")
     raise
+  for event in result:
+    event.topic = topic
+  return result
 
 
 def preprocess_arch_std_files(archpath: str) -> None:
@@ -237,7 +242,7 @@ def preprocess_arch_std_files(archpath: str) -> None:
   global _arch_std_events
   for item in os.scandir(archpath):
     if item.is_file() and item.name.endswith('.json'):
-      for event in read_json_events(item.path):
+      for event in read_json_events(item.path, topic=''):
         if event.name:
           _arch_std_events[event.name.lower()] = event
 
@@ -251,19 +256,36 @@ def print_events_table_prefix(tblname: str) -> None:
   _close_table = True
 
 
-def print_events_table_entries(item: os.DirEntry, topic: str) -> None:
-  """Create contents of an events table."""
+def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
+  """Add contents of file to _pending_events table."""
   if not _close_table:
     raise IOError('Table entries missing prefix')
-  for event in read_json_events(item.path):
-    _args.output_file.write(event.to_c_string(topic))
+  for e in read_json_events(item.path, topic):
+    _pending_events.append(e)
 
 
 def print_events_table_suffix() -> None:
   """Optionally close events table."""
+
+  def event_cmp_key(j: JsonEvent):
+    def fix_none(s: str):
+      if s is None:
+        return ''
+      return s
+
+    return (not j.desc is None, fix_none(j.topic), fix_none(j.name), fix_none(j.pmu),
+            fix_none(j.metric_name))
+
   global _close_table
-  if _close_table:
-    _args.output_file.write("""{
+  if not _close_table:
+    return
+
+  global _pending_events
+  for event in sorted(_pending_events, key=event_cmp_key):
+    _args.output_file.write(event.to_c_string())
+    _pending_events = []
+
+  _args.output_file.write("""{
 \t.name = 0,
 \t.event = 0,
 \t.desc = 0,
@@ -306,7 +328,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if not item.is_file() or not item.name.endswith('.json'):
     return
 
-  print_events_table_entries(item, get_topic(item.name))
+  add_events_table_entries(item, get_topic(item.name))
 
 
 def print_mapping_table(archs: Sequence[str]) -> None:
-- 
2.37.1.455.g008518b4e5-goog

