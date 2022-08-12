Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A66591787
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 01:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbiHLXKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 19:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbiHLXKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 19:10:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86D39C515
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:10:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-329dc6c0d21so18295337b3.16
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=vHc00R1etBBIHmVhT/J70GR1lgdExkJ5oc83QaUQWSc=;
        b=haQLiQ/QV0C7Rv0bIumzuWMIBSXjJVpYzLMonAWjASpxv8AO5rUFuyvFRAIeAxfdv8
         z8WrIwm4SCDuURjdYmFHGBZvttLO6KVNdS4cUIl7ETIoWMlDkl+7Jp+yZ3Vu610eSRDF
         jqwzNi3uI0Z/aUgBxqffFLUFA+jbZsgkP6/lo4mt0cSytUDnt23zo3RjHgWMAmNIZ8Ch
         wfFCKY1BB6y6lM0hHIr8brvxjIlr4MZaN4Pfc1lTRdZMo/FoiwtYinPF1dzPDaXbgnA1
         HvaVkjApIreWUdmCmMkWcNKPeosLuBU+VqG9+FG3b+2QCokdbmYHm3QWZNt87TjteZvS
         ux5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=vHc00R1etBBIHmVhT/J70GR1lgdExkJ5oc83QaUQWSc=;
        b=68s0+HoAOuMAjOCbO2PPn6HkEDeqvnWARwV6BkXc9vj1JGsR6zTAbc2PeJPQ+bEGDN
         1YGJegB8hR9HHnpiYMBGbqWh4B9Pw/qtc0aYAQS4NjljJrBQjFVtdffQeL6AVtr0YPFH
         4vBT6W7U28FVrS2pD9AwW5PdspsLTLupBShHTCcJMP5XxTL+RQKpz5/syWP5va4dTjNf
         F6Ff8jvEQz6cBQVZ46mIt3MmEbTz3ql5RfQARnXQo8QoKi+BNnXX0juBZx2qYNA4nlEJ
         g1Y3sH9v6O5T+n8X3WSHpFRTdHukqbGujwf/5rpXBnmaYofuUc85Tiwr+eF74HSXSNod
         n9KA==
X-Gm-Message-State: ACgBeo3a1YZumtGfDp/yYpCx0EjBkFQhcEDriCM0vcH68VkavG3qtgKz
        Q+1vsHgzkDuX5FaGxy7pufwzr5uOeDJ0
X-Google-Smtp-Source: AA6agR7++xwE1+x1j8sC9gzVFlLoULkq6LLbqYrd8eV+7tKPFcLGTxp0wBOLbYmWNiEAXkoKbduxpmXUVnUu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d668:2937:8218:c5ec])
 (user=irogers job=sendgmr) by 2002:a81:a10b:0:b0:31f:5960:4e8c with SMTP id
 y11-20020a81a10b000000b0031f59604e8cmr5503815ywg.67.1660345804767; Fri, 12
 Aug 2022 16:10:04 -0700 (PDT)
Date:   Fri, 12 Aug 2022 16:09:39 -0700
In-Reply-To: <20220812230949.683239-1-irogers@google.com>
Message-Id: <20220812230949.683239-5-irogers@google.com>
Mime-Version: 1.0
References: <20220812230949.683239-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v5 04/14] perf jevents: Sort json files entries
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

Sort the json files entries on conversion to C. The sort order tries to
replicated cmp_sevent from pmu.c so that the input there is already
sorted except for sysfs events. Specifically, the sort order is given by
the tuple:
(not j.desc is None, fix_none(j.topic), fix_none(j.name),
fix_none(j.pmu), fix_none(j.metric_name))
which is putting events with descriptions and topics before those
without, then sorting by name, then pmu and finally metric_name

Add the topic to JsonEvent on reading to simplify. Remove an unnecessary
lambda in the json reading.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 48 +++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 31936eafa9ff..84fbb0f384cc 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -18,6 +18,8 @@ _sys_event_tables = []
 _arch_std_events = {}
 # Track whether an events table is currently being defined and needs closing.
 _close_table = False
+# Events to write out when the table is closed
+_pending_events = []
 
 
 def removesuffix(s: str, suffix: str) -> str:
@@ -128,6 +130,7 @@ class JsonEvent:
       eventcode |= int(jd['ExtSel']) << 8
     configcode = int(jd['ConfigCode'], 0) if 'ConfigCode' in jd else None
     self.name = jd['EventName'].lower() if 'EventName' in jd else None
+    self.topic = ''
     self.compat = jd.get('Compat')
     self.desc = fixdesc(jd.get('BriefDescription'))
     self.long_desc = fixdesc(jd.get('PublicDescription'))
@@ -200,7 +203,7 @@ class JsonEvent:
         s += f'\t{attr} = {value},\n'
     return s + '}'
 
-  def to_c_string(self, topic_local: str) -> str:
+  def to_c_string(self) -> str:
     """Representation of the event as a C struct initializer."""
 
     def attr_string(attr: str, value: str) -> str:
@@ -212,25 +215,27 @@ class JsonEvent:
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
@@ -238,7 +243,7 @@ def preprocess_arch_std_files(archpath: str) -> None:
   global _arch_std_events
   for item in os.scandir(archpath):
     if item.is_file() and item.name.endswith('.json'):
-      for event in read_json_events(item.path):
+      for event in read_json_events(item.path, topic=''):
         if event.name:
           _arch_std_events[event.name.lower()] = event
 
@@ -252,19 +257,36 @@ def print_events_table_prefix(tblname: str) -> None:
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
@@ -307,7 +329,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if not item.is_file() or not item.name.endswith('.json'):
     return
 
-  print_events_table_entries(item, get_topic(item.name))
+  add_events_table_entries(item, get_topic(item.name))
 
 
 def print_mapping_table(archs: Sequence[str]) -> None:
-- 
2.37.1.595.g718a3a8f04-goog

