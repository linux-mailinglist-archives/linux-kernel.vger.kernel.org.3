Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8913F58483F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 00:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiG1W3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 18:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiG1W3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 18:29:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150CC7A50B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:28:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m11-20020a5b040b000000b0066fcc60d1a0so2518957ybp.19
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OOc1PTTRyXV6nXnjdcZNL1jmEOxL76grMp3e/IxF11o=;
        b=cMGT2szwkLG1WLq8uSlzkrwsv82ifTTOqIzGhb9CwQGXjIB4/YYcdfx0xCqiIbCkVS
         XRZTHrnxWD/lCbq2KoWke0bs8mdQIs3KlXBMTPSV1OzUytXJjevVZWLt4xbUypbQardZ
         cDlx5qJjcQ7X7HWzk2ks50+hJppQ0vrbkVC0fuQUxw/U/O3tXVzFRf6bV/2mJRg0gbjj
         ou4Pi8eviC+hVwwwHQxTIgaZWaiC+9ZPHlmPYMFV+WMAFXTj0ne8WKaW6pwyVxm81b7n
         tYnjBMPaBXNQE5uGlQpy2sIMbIkEXxiU+lzpCeliVLAKEOasDU2tk4qTFZALBBTtFIPo
         hvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OOc1PTTRyXV6nXnjdcZNL1jmEOxL76grMp3e/IxF11o=;
        b=UiPgcdMmdkfeQrF/7ym6yy5oH++L5bCyf/NEjX8G4aLjwES2dXEQLasaneEX/qNFMw
         XLSzlMo4+m1l+w1qei1A0vPwrs5HIPp3n7SXMFrn1JCw0Vm6Dj0ssUiHR1aN+5moFn6k
         mKQHqvHfa6GKAsYglCUSlo3FYWRKXOP6kuRFfdm/umE6hLVoBACpnDaH9zDDxuBM0GRq
         UPC45EiX9YRIDX5DaL1E44vXeC540JdZYfLNIXam1C8s9/MWZYK1m1Re9A5G69OOZrSq
         6URUFu+cPEsWLGyQ1TAbVEZBmrQxqsZzM4kl5c34vuejQobee+oYvdlh62Cj1MmmtCMO
         ROTw==
X-Gm-Message-State: ACgBeo2e8vHSR6dsGo3NGNmfDaGy/iO5P2Otu1jJKVRr6rzyQOkx5czp
        tPo+QEWHzt/V/pls/ZRVoGPioSZ1Slc6
X-Google-Smtp-Source: AA6agR7tHPSsVspEVJKzgRs0XldANZrB3rlbvYqZGs9vdf7WdES+TxfZPAHspC6eDIh5bf8FxjqLw/p6kP76
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fd09:96c3:28af:b08f])
 (user=irogers job=sendgmr) by 2002:a81:8396:0:b0:322:ed8f:9bdf with SMTP id
 t144-20020a818396000000b00322ed8f9bdfmr784805ywf.455.1659047335312; Thu, 28
 Jul 2022 15:28:55 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:28:25 -0700
In-Reply-To: <20220728222835.3254224-1-irogers@google.com>
Message-Id: <20220728222835.3254224-7-irogers@google.com>
Mime-Version: 1.0
References: <20220728222835.3254224-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v2 06/16] perf jevents: Sort json files entries
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
index 7d5110327468..34b686d27cef 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -19,6 +19,8 @@ _sys_event_tables = []
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
2.37.1.455.g008518b4e5-goog

