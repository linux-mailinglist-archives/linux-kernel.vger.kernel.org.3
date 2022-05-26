Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A37A535623
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiEZWpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349302AbiEZWp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:45:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6723DC5D8C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:45:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m9-20020a056902004900b0064fb755258dso2721195ybh.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W0sWuy6oTQPVjB3fsY9LwhFU+wj+C4Fi95g+ekuZQ7c=;
        b=C7RV9ok6dY1AYybfe9s5PMS/59NC1X3IjevQKCRiN+NQlRjB4Tm06DoTkjbT2a3OeZ
         FXxnQ19pSb/ZVNLRV+APwvbQET8wxnxtiOyJ/wnWNSiO3HF3gRhquAF3UglD63dLOS8S
         Z9IzRHBl7LcAseQzano1oINnxxIjL5YZBS3HcHo35n6R32+I/TsSUjQpgmRMjmwmNenk
         aQyrU2r77wrgkNlQnYl9VuUD2FMscqa3kGCwX2t9lND/8/3Ffmp/5JFx3v+uWJa6gomV
         17kNTv/Rt04dYmZsNXvrqpLv0M5xGbr37tHHvc/kLcoRSSd8rZxjYA6Uk4x1/1OTSTm+
         P3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W0sWuy6oTQPVjB3fsY9LwhFU+wj+C4Fi95g+ekuZQ7c=;
        b=xUbTVI2qo4mRG+RC8qfeLdLbrKAguQvFlrPCuFxPWbBmLmVUXAlHbj+iou8cKQ/MRG
         5oqAX+BD0Pgfh9cyXXaOjGwy5SKAg8RjU1/teK0Z6WH0moEKrvx9rdFrDV9roM//ZpE+
         20JbSVeXL8sGfWK/+A55EsS3+bbA4Cv9Wsb7vfUpEwySXo4ShpV0D62Ud8CAOF/MrM+M
         SM5H0UHrgME92enPUOMm/+a1g+OGAiYJ5envOOJAFe/qexi6pkxrRyeKaIOiSpAtDzTZ
         uplmsuqeLJ1cR1Fg8UQdj/0sqSwEOmTHWl/nifC7VX6OFMTKT3Nz25uTWeV+yRwaKYM2
         sk9w==
X-Gm-Message-State: AOAM531xdnKz5K7cU1qYAkLPTqfWgJ3ECwaLl/FYnYB4iWf7YItZH9Bq
        1rNZ8L5TBifpqmgjjruzwNvtGuTM0IQr
X-Google-Smtp-Source: ABdhPJzJVxppI89ysg2ullf/UAcAYv3UIE1+AUTlJtIr5xVgb4JgOk9mU7egYfFt2Ycmwl91DPDomKqOnwDo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4b39:e167:e698:7d4])
 (user=irogers job=sendgmr) by 2002:a5b:642:0:b0:64f:f322:8827 with SMTP id
 o2-20020a5b0642000000b0064ff3228827mr20474054ybq.536.1653605123527; Thu, 26
 May 2022 15:45:23 -0700 (PDT)
Date:   Thu, 26 May 2022 15:45:15 -0700
In-Reply-To: <20220526224515.4088240-1-irogers@google.com>
Message-Id: <20220526224515.4088240-3-irogers@google.com>
Mime-Version: 1.0
References: <20220526224515.4088240-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v5 2/2] perf test: Json format checking
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>
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

From: Claire Jensen <cjense@google.com>

Add field checking tests for perf stat JSON output.
Sanity checks the expected number of fields are present, that the
expected keys are present and they have the correct values.

Signed-off-by: Claire Jensen <cjense@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/lib/perf_json_output_lint.py  |  95 +++++++++++
 tools/perf/tests/shell/stat+json_output.sh    | 147 ++++++++++++++++++
 2 files changed, 242 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+json_output.sh

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
new file mode 100644
index 000000000000..aaa4a8677b6c
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -0,0 +1,95 @@
+#!/usr/bin/python
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+# Basic sanity check of perf JSON output as specified in the man page.
+
+import argparse
+import sys
+import json
+
+ap = argparse.ArgumentParser()
+ap.add_argument('--no-args', action='store_true')
+ap.add_argument('--interval', action='store_true')
+ap.add_argument('--system-wide-no-aggr', action='store_true')
+ap.add_argument('--system-wide', action='store_true')
+ap.add_argument('--event', action='store_true')
+ap.add_argument('--per-core', action='store_true')
+ap.add_argument('--per-thread', action='store_true')
+ap.add_argument('--per-die', action='store_true')
+ap.add_argument('--per-node', action='store_true')
+ap.add_argument('--per-socket', action='store_true')
+args = ap.parse_args()
+
+Lines = sys.stdin.readlines()
+
+def isfloat(num):
+  try:
+    float(num)
+    return True
+  except ValueError:
+    return False
+
+
+def isint(num):
+  try:
+    int(num)
+    return True
+  except ValueError:
+    return False
+
+def is_counter_value(num):
+  return isfloat(num) or num == '<not counted>' or num == '<not supported>'
+
+def check_json_output(expected_items):
+  if expected_items != -1:
+    for line in Lines:
+      if 'failed' not in line:
+        count = 0
+        count = line.count(',')
+        if count != expected_items and (count == 1 or count == 2) and 'metric-value' in line:
+          # Events that generate >1 metric may have isolated metric
+          # values and possibly have an interval prefix.
+          continue
+        if count != expected_items:
+          raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
+                             f' in \'{line}\'')
+  checks = {
+      'aggregate-number': lambda x: isfloat(x),
+      'core': lambda x: True,
+      'counter-value': lambda x: is_counter_value(x),
+      'cgroup': lambda x: True,
+      'cpu': lambda x: isint(x),
+      'die': lambda x: True,
+      'event': lambda x: True,
+      'event-runtime': lambda x: isfloat(x),
+      'interval': lambda x: isfloat(x),
+      'metric-unit': lambda x: True,
+      'metric-value': lambda x: isfloat(x),
+      'node': lambda x: True,
+      'pcnt-running': lambda x: isfloat(x),
+      'socket': lambda x: True,
+      'thread': lambda x: True,
+      'unit': lambda x: True,
+  }
+  input = '[\n' + ','.join(Lines) + '\n]'
+  for item in json.loads(input):
+    for key, value in item.items():
+      if key not in checks:
+        raise RuntimeError(f'Unexpected key: key={key} value={value}')
+      if not checks[key](value):
+        raise RuntimeError(f'Check failed for: key={key} value={value}')
+
+
+try:
+  if args.no_args or args.system_wide or args.event:
+    expected_items = 6
+  elif args.interval or args.per_thread or args.system_wide_no_aggr:
+    expected_items = 7
+  elif args.per_core or args.per_socket or args.per_node or args.per_die:
+    expected_items = 8
+  else:
+    # If no option is specified, don't check the number of items.
+    expected_items = -1
+  check_json_output(expected_items)
+except:
+  print('Test failed for input:\n' + '\n'.join(Lines))
+  raise
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
new file mode 100755
index 000000000000..ea8714a36051
--- /dev/null
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -0,0 +1,147 @@
+#!/bin/bash
+# perf stat JSON output linter
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+# Checks various perf stat JSON output commands for the
+# correct number of fields.
+
+set -e
+
+pythonchecker=$(dirname $0)/lib/perf_json_output_lint.py
+if [ "x$PYTHON" == "x" ]
+then
+	if which python3 > /dev/null
+	then
+		PYTHON=python3
+	elif which python > /dev/null
+	then
+		PYTHON=python
+	else
+		echo Skipping test, python not detected please set environment variable PYTHON.
+		exit 2
+	fi
+fi
+
+# Return true if perf_event_paranoid is > $1 and not running as root.
+function ParanoidAndNotRoot()
+{
+	 [ $(id -u) != 0 ] && [ $(cat /proc/sys/kernel/perf_event_paranoid) -gt $1 ]
+}
+
+check_no_args()
+{
+	echo -n "Checking json output: no args "
+	perf stat -j true 2>&1 | $PYTHON $pythonchecker --no-args
+	echo "[Success]"
+}
+
+check_system_wide()
+{
+	echo -n "Checking json output: system wide "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoia and not root"
+		return
+	fi
+	perf stat -j -a true 2>&1 | $PYTHON $pythonchecker --system-wide
+	echo "[Success]"
+}
+
+check_system_wide_no_aggr()
+{
+	echo -n "Checking json output: system wide "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoia and not root"
+		return
+	fi
+	echo -n "Checking json output: system wide no aggregation "
+	perf stat -j -A -a --no-merge true 2>&1 | $PYTHON $pythonchecker --system-wide-no-aggr
+	echo "[Success]"
+}
+
+check_interval()
+{
+	echo -n "Checking json output: interval "
+	perf stat -j -I 1000 true 2>&1 | $PYTHON $pythonchecker --interval
+	echo "[Success]"
+}
+
+
+check_event()
+{
+	echo -n "Checking json output: event "
+	perf stat -j -e cpu-clock true 2>&1 | $PYTHON $pythonchecker --event
+	echo "[Success]"
+}
+
+check_per_core()
+{
+	echo -n "Checking json output: per core "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoia and not root"
+		return
+	fi
+	perf stat -j --per-core -a true 2>&1 | $PYTHON $pythonchecker --per-core
+	echo "[Success]"
+}
+
+check_per_thread()
+{
+	echo -n "Checking json output: per thread "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoia and not root"
+		return
+	fi
+	perf stat -j --per-thread -a true 2>&1 | $PYTHON $pythonchecker --per-thread
+	echo "[Success]"
+}
+
+check_per_die()
+{
+	echo -n "Checking json output: per die "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoia and not root"
+		return
+	fi
+	perf stat -j --per-die -a true 2>&1 | $PYTHON $pythonchecker --per-die
+	echo "[Success]"
+}
+
+check_per_node()
+{
+	echo -n "Checking json output: per node "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoia and not root"
+		return
+	fi
+	perf stat -j --per-node -a true 2>&1 | $PYTHON $pythonchecker --per-node
+	echo "[Success]"
+}
+
+check_per_socket()
+{
+	echo -n "Checking json output: per socket "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoia and not root"
+		return
+	fi
+	perf stat -j --per-socket -a true 2>&1 | $PYTHON $pythonchecker --per-socket
+	echo "[Success]"
+}
+
+check_no_args
+check_system_wide
+check_system_wide_no_aggr
+check_interval
+check_event
+check_per_core
+check_per_thread
+check_per_die
+check_per_node
+check_per_socket
+exit 0
-- 
2.36.1.124.g0e6072fb45-goog

