Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7256654BFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345933AbiFODFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345870AbiFODE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:04:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCE64B844;
        Tue, 14 Jun 2022 20:04:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso812238pjl.3;
        Tue, 14 Jun 2022 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nGWqh4jT6yXmFipoGgtv9i6ITGpJz6AdQ+6uVxthCNE=;
        b=jZxqZaw3RbgI7LbD/MBkFAeUs3TOA74radc4QkVIjgb4TccIV4hIL5tJbNCpekm+h3
         LWYj5OOaeiuRaxDlN2JAf/6BzeFw0EYtrmZKe4BZCQmXjO3bOhnMeCU8yuEykshetST1
         gPP0SaEftWyySFZVdi5mPkSVYwylD4lLkvj+RIPIEyldXl1+ZBEpLkuf6U91cmSz5Cue
         hGPrN8G8g4YFs+7laHvkAko0oJcm6CwGVueu5mkmvBUBeUnJFnYMz6OHfafwgh34WZwt
         DYVfBVtT3AiK6P3uB8aNrrAtSDkpKFsfHnR793VM67Wos/HTHMfeaa4GS6tt0Quz0kf8
         Fu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nGWqh4jT6yXmFipoGgtv9i6ITGpJz6AdQ+6uVxthCNE=;
        b=aIgjEQl7jx9BJS59jCvcbPDXwtX7ZIdLwiNQ2gwxWE0o8JA2WDOarHT22UeoKEEUFA
         +MfESsWt05clh/CU9nip4uyefnGRs2nFnTVOp8+liYzVQqby31rORbeEmHjjjQ+z/VAt
         W9rObMeLixxVlj6M8c5fM4+CWyVpwzvYUhRUVhV3A8nnzoxUC4vi2ajgyEMvXee76Ya3
         EzPUzKQcS60BwjUJZ4Gr64WOq8QyC4SbAaSW/q6f1zFGLghKXmCymIZDXQNKzj/38VOw
         hYeothGA/ZCJL/kZbSyEe+Y9N3IEf6V7m5W7tbiQZQbGoXiieN0D811u0Bm4ChlgDJY7
         A36w==
X-Gm-Message-State: AOAM532PeK/qPNfJpJttA4LT3XJd7UOoEawJkFLzx33dBXB2gwmF+8c2
        SfG2lGZyySktViRr7I4MNLc=
X-Google-Smtp-Source: AGRyM1tHtG1G32tD7HO9dUdUDFwhr0soJZiZiEwRNAwgYWq2kEbXJmRlgmvQIOC4T7beRHg01M52Tw==
X-Received: by 2002:a17:902:d707:b0:168:9a6a:936d with SMTP id w7-20020a170902d70700b001689a6a936dmr7227279ply.92.1655262296039;
        Tue, 14 Jun 2022 20:04:56 -0700 (PDT)
Received: from rpi400.lan (c-73-70-190-118.hsd1.ca.comcast.net. [73.70.190.118])
        by smtp.gmail.com with ESMTPSA id e6-20020a63aa06000000b003fbfd5e4ddcsm8757615pgf.75.2022.06.14.20.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 20:04:51 -0700 (PDT)
From:   Ian Rogers <rogers.email@gmail.com>
X-Google-Original-From: Ian Rogers <irogers@google.com>
Received: by rpi400.lan (Postfix, from userid 1001)
        id D77C52FC699; Tue, 14 Jun 2022 20:04:48 -0700 (PDT)
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v4 2/4] perf jevents: Add python converter script
Date:   Tue, 14 Jun 2022 20:04:36 -0700
Message-Id: <20220615030438.51477-3-irogers@google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220615030438.51477-1-irogers@google.com>
References: <20220615030438.51477-1-irogers@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jevents.c is large, has a dependency on an old forked version of jsmn,
and is challenging to work upon. A lot of jevents.c's complexity comes
from needing to write json and csv parsing from first principles. In
contrast python has this functionality in standard libraries and is
already a build pre-requisite for tools like asciidoc (that builds all
of the perf man pages).

Introduce jevents.py that produces identical output to jevents.c. Add a
test that runs both converter tools and validates there are no output
differences. The test can be invoked with a phony build target like:

make -C tools/perf jevents-py-test

The python code deliberately tries to replicate the behavior of
jevents.c so that the output matches and transitioning tools shouldn't
introduce regressions. In some cases the code isn't as elegant as hoped,
but fixing this can be done as follow up.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf              |   6 +
 tools/perf/pmu-events/jevents-test.sh |  33 +++
 tools/perf/pmu-events/jevents.py      | 394 ++++++++++++++++++++++++++
 3 files changed, 433 insertions(+)
 create mode 100755 tools/perf/pmu-events/jevents-test.sh
 create mode 100755 tools/perf/pmu-events/jevents.py

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 8f738e11356d..1e29c8936f71 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -669,6 +669,12 @@ $(JEVENTS_IN): FORCE
 $(JEVENTS): $(JEVENTS_IN)
 	$(QUIET_LINK)$(HOSTCC) $(JEVENTS_IN) -o $@
 
+JEVENTS_PY	:=  pmu-events/jevents.py
+JEVENTS_PY_TEST	:=  pmu-events/jevents-test.sh
+.PHONY: jevents-py-test
+jevents-py-test: $(JEVENTS)
+	$(Q)$(call echo-cmd,gen)$(JEVENTS_PY_TEST) $(JEVENTS) $(JEVENTS_PY) pmu-events/arch
+
 $(PMU_EVENTS_IN): $(JEVENTS) FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
diff --git a/tools/perf/pmu-events/jevents-test.sh b/tools/perf/pmu-events/jevents-test.sh
new file mode 100755
index 000000000000..9ae852292576
--- /dev/null
+++ b/tools/perf/pmu-events/jevents-test.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+# Validate that the legacy jevents and jevents.py produce identical output.
+set -e
+
+JEVENTS="$1"
+JEVENTS_PY="$2"
+ARCH_PATH="$3"
+JEVENTS_C_GENERATED=$(mktemp /tmp/jevents_c.XXXXX.c)
+JEVENTS_PY_GENERATED=$(mktemp /tmp/jevents_py.XXXXX.c)
+
+cleanup() {
+  rm "$JEVENTS_C_GENERATED" "$JEVENTS_PY_GENERATED"
+  trap - exit term int
+}
+trap cleanup exit term int
+
+for path in "$ARCH_PATH"/*
+do
+  arch=$(basename $path)
+  if [ "$arch" = "test" ]
+  then
+    continue
+  fi
+  echo "Checking architecture: $arch"
+  echo "Generating using jevents.c"
+  "$JEVENTS" "$arch" "$ARCH_PATH" "$JEVENTS_C_GENERATED"
+  echo "Generating using jevents.py"
+  "$JEVENTS_PY" "$arch" "$ARCH_PATH" "$JEVENTS_PY_GENERATED"
+  echo "Diffing"
+  diff -u "$JEVENTS_C_GENERATED" "$JEVENTS_PY_GENERATED"
+done
+cleanup
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
new file mode 100755
index 000000000000..658eb2696f9a
--- /dev/null
+++ b/tools/perf/pmu-events/jevents.py
@@ -0,0 +1,394 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+"""Convert directories of JSON events to C code."""
+import argparse
+import csv
+import json
+import os
+import sys
+from typing import Callable
+
+# Global command line arguments.
+args = None
+# List of event tables generated from "/sys" directories.
+sys_event_tables = []
+# Map from an event name to an architecture standard
+# JsonEvent. Architecture standard events are in json files in the top
+# f'{args.starting_dir}/{args.arch}' directory.
+arch_std_events = dict()
+# Track whether an events table is currently being defined and needs closing.
+close_table = False
+
+
+def file_name_to_table_name(parents: list[str], dirname: str) -> str:
+  """Generate a C table name from directory names."""
+  tblname = 'pme'
+  for p in parents:
+    tblname += '_' + p
+  tblname += '_' + dirname
+  return tblname.replace('-', '_')
+
+
+class JsonEvent:
+  """Representation of an event loaded from a json file dictionary."""
+
+  def __init__(self, dict):
+    """Constructor passed the dictionary of parsed json values."""
+
+    def llx(x: int) -> str:
+      """Convert an int to a string similar to a printf modifier of %#llx."""
+      return '0' if x == 0 else hex(x)
+
+    def fixdesc(s: str) -> str:
+      """Fix formatting issue for the desc string."""
+      if s is None:
+        return None
+      return s.removesuffix('.  ').removesuffix('. ').removesuffix('.').replace(
+          '\n', '\\n').replace('\"', '\\"').replace('\r', '\\r')
+
+    def convert_aggr_mode(aggr_mode: str) -> str:
+      """Returns the aggr_mode_class enum value associated with the JSON string."""
+      if not aggr_mode:
+        return None
+      aggr_mode_to_enum = {
+          'PerChip': '1',
+          'PerCore': '2',
+      }
+      return aggr_mode_to_enum[aggr_mode]
+
+    def lookup_msr(num: str) -> str:
+      """Converts the msr number, or first in a list to the appropriate event field."""
+      if not num:
+        return None
+      msrmap = {
+          0x3F6: 'ldlat=',
+          0x1A6: 'offcore_rsp=',
+          0x1A7: 'offcore_rsp=',
+          0x3F7: 'frontend=',
+      }
+      return msrmap[int(num.split(',', 1)[0], 0)]
+
+    def real_event(name: str, event: str) -> str:
+      """Convert well known event names to an event string otherwise use the event argument."""
+      fixed = {
+          'inst_retired.any': 'event=0xc0,period=2000003',
+          'inst_retired.any_p': 'event=0xc0,period=2000003',
+          'cpu_clk_unhalted.ref': 'event=0x0,umask=0x03,period=2000003',
+          'cpu_clk_unhalted.thread': 'event=0x3c,period=2000003',
+          'cpu_clk_unhalted.core': 'event=0x3c,period=2000003',
+          'cpu_clk_unhalted.thread_any': 'event=0x3c,any=1,period=2000003',
+      }
+      if not name:
+        return None
+      if name.lower() in fixed:
+        return fixed[name.lower()]
+      return event
+
+    def unit_to_pmu(unit: str) -> str:
+      """Convert a JSON Unit to Linux PMU name."""
+      if not unit:
+        return None
+      # Comment brought over from jevents.c:
+      # it's not realistic to keep adding these, we need something more scalable ...
+      table = {
+          'CBO': 'uncore_cbox',
+          'QPI LL': 'uncore_qpi',
+          'SBO': 'uncore_sbox',
+          'iMPH-U': 'uncore_arb',
+          'CPU-M-CF': 'cpum_cf',
+          'CPU-M-SF': 'cpum_sf',
+          'UPI LL': 'uncore_upi',
+          'hisi_sicl,cpa': 'hisi_sicl,cpa',
+          'hisi_sccl,ddrc': 'hisi_sccl,ddrc',
+          'hisi_sccl,hha': 'hisi_sccl,hha',
+          'hisi_sccl,l3c': 'hisi_sccl,l3c',
+          'imx8_ddr': 'imx8_ddr',
+          'L3PMC': 'amd_l3',
+          'DFPMC': 'amd_df',
+          'cpu_core': 'cpu_core',
+          'cpu_atom': 'cpu_atom',
+      }
+      return table[unit] if unit in table else f'uncore_{unit.lower()}'
+
+    eventcode = 0
+    if 'EventCode' in dict:
+      eventcode = int(dict['EventCode'].split(',', 1)[0], 0)
+    if 'ExtSel' in dict:
+      eventcode |= int(dict['ExtSel']) << 8
+    configcode = int(dict['ConfigCode'], 0) if 'ConfigCode' in dict else None
+    self.name = dict['EventName'].lower() if 'EventName' in dict else None
+    self.compat = dict.get('Compat')
+    self.desc = fixdesc(dict.get('BriefDescription'))
+    self.long_desc = fixdesc(dict.get('PublicDescription'))
+    precise = dict.get('PEBS')
+    msr = lookup_msr(dict.get('MSRIndex'))
+    msrval = dict.get('MSRValue')
+    extra_desc = ''
+    if 'Data_LA' in dict:
+      extra_desc += '  Supports address when precise'
+      if 'Errata' in dict:
+        extra_desc += '.'
+    if 'Errata' in dict:
+      extra_desc += '  Spec update: ' + dict['Errata']
+    self.pmu = unit_to_pmu(dict.get('Unit'))
+    filter = dict.get('Filter')
+    self.unit = dict.get('ScaleUnit')
+    self.perpkg = dict.get('PerPkg')
+    self.aggr_mode = convert_aggr_mode(dict.get('AggregationMode'))
+    self.deprecated = dict.get('Deprecated')
+    self.metric_name = dict.get('MetricName')
+    self.metric_group = dict.get('MetricGroup')
+    self.metric_constraint = dict.get('MetricConstraint')
+    self.metric_expr = dict.get('MetricExpr')
+    if self.metric_expr:
+      self.metric_expr = self.metric_expr.replace('\\', '\\\\')
+    arch_std = dict.get('ArchStdEvent')
+    if precise and self.desc and not '(Precise Event)' in self.desc:
+      extra_desc += ' (Must be precise)' if precise == '2' else (' (Precise '
+                                                                 'event)')
+    event = f'config={llx(configcode)}' if configcode is not None else f'event={llx(eventcode)}'
+    event_fields = [
+        ('AnyThread', 'any='),
+        ('PortMask', 'ch_mask='),
+        ('CounterMask', 'cmask='),
+        ('EdgeDetect', 'edge='),
+        ('FCMask', 'fc_mask='),
+        ('Invert', 'inv='),
+        ('SampleAfterValue', 'period='),
+        ('UMask', 'umask='),
+    ]
+    for key, value in event_fields:
+      if key in dict and dict[key] != '0':
+        event += ',' + value + dict[key]
+    if filter:
+      event += f',{filter}'
+    if msr:
+      event += f',{msr}{msrval}'
+    if self.desc and extra_desc:
+      self.desc += extra_desc
+    if self.long_desc and extra_desc:
+      self.long_desc += extra_desc
+    if self.pmu:
+      if self.desc and not self.desc.endswith('. '):
+        self.desc += '. '
+      self.desc = (self.desc if self.desc else '') + ('Unit: ' + self.pmu + ' ')
+    if arch_std and arch_std.lower() in arch_std_events:
+      event = arch_std_events[arch_std.lower()].event
+      # Copy from the architecture standard event to self for undefined fields.
+      for attr, value in arch_std_events[arch_std.lower()].__dict__.items():
+        if hasattr(self, attr) and not getattr(self, attr):
+          setattr(self, attr, value)
+
+    self.event = real_event(self.name, event)
+
+  def __repr__(self) -> str:
+    """String representation primarily for debugging."""
+    s = '{\n'
+    for attr, value in self.__dict__.items():
+      if value:
+        s += f'\t{attr} = {value},\n'
+    return s + '}'
+
+  def ToCString(self, topic_local: str) -> str:
+    """Representation of the event as a C struct initializer."""
+
+    def AttrString(attr: str, value: str) -> str:
+      return '\t.%s = \"%s\",\n' % (attr, value)
+
+    def StrIfPresent(self, attr: str) -> str:
+      if not getattr(self, attr):
+        return ''
+      return AttrString(attr, getattr(self, attr))
+
+    s = '{\n'
+    for attr in ['name', 'event']:
+      s += StrIfPresent(self, attr)
+    if self.desc is not None:
+      s += AttrString('desc', self.desc)
+    else:
+      s += AttrString('desc', '(null)')
+    s += StrIfPresent(self, 'compat')
+    s += f'\t.topic = "{topic_local}",\n'
+    for attr in [
+        'long_desc', 'pmu', 'unit', 'perpkg', 'aggr_mode', 'metric_expr',
+        'metric_name', 'metric_group', 'deprecated', 'metric_constraint'
+    ]:
+      s += StrIfPresent(self, attr)
+    s += '},\n'
+    return s
+
+
+def read_json_events(path: str) -> list[JsonEvent]:
+  """Read json events from the specified file."""
+  return json.load(open(path), object_hook=lambda d: JsonEvent(d))
+
+def preprocess_arch_std_files(archpath: str) -> None:
+  """Read in all architecture standard events."""
+  global arch_std_events
+  for item in os.scandir(archpath):
+    if item.is_file() and item.name.endswith('.json'):
+      for event in read_json_events(item.path):
+        if event.name:
+          arch_std_events[event.name.lower()] = event
+
+
+def print_events_table_prefix(tblname: str) -> None:
+  """Called when a new events table is started."""
+  global close_table
+  if close_table:
+    raise IOError('Printing table prefix but last table has no suffix')
+  args.output_file.write('static const struct pmu_event %s[] = {\n' % tblname)
+  close_table = True
+
+
+def print_events_table_entries(item: os.DirEntry, topic: str) -> None:
+  """Create contents of an events table."""
+  if not close_table:
+    raise IOError('Table entries missing prefix')
+  for event in read_json_events(item.path):
+    args.output_file.write(event.ToCString(topic))
+
+def print_events_table_suffix() -> None:
+  """Optionally close events table."""
+  global close_table
+  if close_table:
+    args.output_file.write("""{
+\t.name = 0,
+\t.event = 0,
+\t.desc = 0,
+},
+};
+""")
+  close_table = False
+
+def process_one_file(parents: list[str], item: os.DirEntry) -> None:
+  """Process a JSON file during the main walk."""
+  global sys_event_tables
+
+  def get_topic(topic: str) -> str:
+    return topic.removesuffix('.json').replace('-', ' ')
+
+  def is_leaf_dir(path: str) -> bool:
+    for item in os.scandir(path):
+      if item.is_dir():
+        return False
+    return True
+
+  # model directory, reset topic
+  if item.is_dir() and is_leaf_dir(item.path):
+    print_events_table_suffix()
+
+    tblname = file_name_to_table_name(parents, item.name)
+    if item.name == 'sys':
+      sys_event_tables.append(tblname)
+    print_events_table_prefix(tblname)
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
+  print_events_table_entries(item, get_topic(item.name))
+
+
+def print_mapping_table() -> None:
+  """Read the mapfile and generate the struct from cpuid string to event table."""
+  table = csv.reader(open(f'{args.starting_dir}/{args.arch}/mapfile.csv'))
+  args.output_file.write('const struct pmu_events_map pmu_events_map[] = {\n')
+  first = True
+  for row in table:
+    # Skip the first row or any row beginning with #.
+    if not first and len(row) > 0 and not row[0].startswith('#'):
+      tblname = file_name_to_table_name([], row[2].replace('/', '_'))
+      args.output_file.write("""{
+\t.cpuid = \"%s\",
+\t.version = \"%s\",
+\t.type = \"%s\",
+\t.table = %s
+},
+""" % (row[0].replace('\\', '\\\\'), row[1], row[3], tblname))
+    first = False
+
+  args.output_file.write("""{
+\t.cpuid = "testcpu",
+\t.version = "v1",
+\t.type = "core",
+\t.table = pme_test_soc_cpu,
+},
+{
+\t.cpuid = 0,
+\t.version = 0,
+\t.type = 0,
+\t.table = 0,
+},
+};
+""")
+
+
+def print_system_mapping_table() -> None:
+  """C struct mapping table array for tables from /sys directories."""
+  args.output_file.write(
+      '\nconst struct pmu_sys_events pmu_sys_event_tables[] = {\n')
+  for tblname in sys_event_tables:
+    args.output_file.write("""\t{
+\t\t.table = %s,
+\t\t.name = \"%s\",
+\t},
+""" % (tblname, tblname))
+  args.output_file.write("""\t{
+\t\t.table = 0
+\t},
+};
+""")
+
+
+def main() -> None:
+  global args
+
+  def dir_path(path: str) -> str:
+    """Validate path is a directory for argparse."""
+    if os.path.isdir(path):
+      return path
+    else:
+      raise argparse.ArgumentTypeError(f'\'{path}\' is not a valid directory')
+
+  def ftw(path: str, parents: list[str],
+          action: Callable[[list[str], os.DirEntry], None]) -> None:
+    """Replicate the directory/file walking behavior of C's file tree walk."""
+    for item in os.scandir(path):
+      action(parents, item)
+      if item.is_dir():
+        ftw(item.path, parents + [item.name], action)
+
+  ap = argparse.ArgumentParser()
+  ap.add_argument('arch', help='Architecture name like x86')
+  ap.add_argument(
+      'starting_dir',
+      type=dir_path,
+      help='Root of tree containing architecture directories containing json files'
+  )
+  ap.add_argument(
+      'output_file', type=argparse.FileType('w'), nargs='?', default=sys.stdout)
+  args = ap.parse_args()
+
+  args.output_file.write("#include \"pmu-events/pmu-events.h\"\n")
+  for path in [args.arch, 'test']:
+    arch_path = f'{args.starting_dir}/{path}'
+    if not os.path.isdir(arch_path):
+      raise IOError(f'Missing architecture directory in \'{arch_path}\'')
+    preprocess_arch_std_files(arch_path)
+    ftw(arch_path, [], process_one_file)
+    print_events_table_suffix()
+
+  print_mapping_table()
+  print_system_mapping_table()
+
+
+if __name__ == '__main__':
+  main()
-- 
2.34.1

