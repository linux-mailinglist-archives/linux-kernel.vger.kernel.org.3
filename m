Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A8B58A32A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240153AbiHDWTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbiHDWSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:18:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FEF71BE4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:18:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s186-20020a255ec3000000b0067162ed1bd3so607288ybb.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=16IOlO4jrn2MK9FURXqlyF6K1fZebhGz75A8J5qtD1g=;
        b=DtjWNSw2MjvlwjcuEAf0hYe9W4aMN2WxiogWBKB/oocccduWc9R6ai5MWQkNAbhfWH
         FaevJOoJ27DaVarlwEiz/sjb3Lg/L1eQtxv7IrV3LEE4PvL5mA8eszQgbRa9WWl0rf8m
         I4VNXmicsQ6X30wN2i6NM0KrtOJQ20X8gUVWZ4j7tWU/u0IrN6FF2kn1v3ijY/txrony
         z86HPf7C+kwMir0kwBkrwZROsbrmb1/YlSkPpXz5CObcVI7LCXWEX7vKifNGkrrc1ez9
         RWk0D0i+wLpt/2RUA3GfnSJK5qzp+043437I5AfTQgbuZj6MvBa83II22XkrrQ06d2kB
         n2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=16IOlO4jrn2MK9FURXqlyF6K1fZebhGz75A8J5qtD1g=;
        b=R9gNV4U5va2/ytOBGCVLtoa6bZimrfZlIwNB/ib6hk7yXQw62WMmY6/1QZvH0o85q9
         MtY5jIkzb+SGrKQxRDjUnRVPZ4UUBoWjMIl0CnCMRrJlC6K85SZo7KOOk0zM9+uRxchO
         d127dE+D4NcJnX2aola6G5WWIPa4WNuZven4x2MCu+IprbDmTN3YBpYVwZhpjdrFLud/
         Z/zI3w/YtDFVzDmkm2PyUyWMbZ6aFUkuZMoz8FoCw764I05by1aNwvrQ7Fy5Yb3ttvoB
         iTbKOgn5Ol6PmyAsK7TcfrOhoiBpln2fAWxnwY8G+imAvpFNd9HD25O1h+Y02/z2bK3x
         8NrQ==
X-Gm-Message-State: ACgBeo2j8INGiqmX0H01hOijWWXo3HXHrWFFW9JU4XrN+4fJDWsMNTPg
        xvbvjECV/GDKQBBXqxCvjn+FVQrt9RMI
X-Google-Smtp-Source: AA6agR6GlRMybjZShfr/ikrpTB9P0SKEPOm87GFuipgaepuutqAFf8huAl4sOIdCS2Nx7YsUiDmY2VyNaqH+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a25:2417:0:b0:675:a9b2:dad0 with SMTP id
 k23-20020a252417000000b00675a9b2dad0mr2996819ybk.489.1659651521521; Thu, 04
 Aug 2022 15:18:41 -0700 (PDT)
Date:   Thu,  4 Aug 2022 15:18:06 -0700
In-Reply-To: <20220804221816.1802790-1-irogers@google.com>
Message-Id: <20220804221816.1802790-8-irogers@google.com>
Mime-Version: 1.0
References: <20220804221816.1802790-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 07/17] perf jevents: Sort json files entries
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
2.37.1.559.g78731f0fdb-goog

