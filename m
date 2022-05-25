Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BE7533681
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244054AbiEYFik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244035AbiEYFi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:38:29 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DC06F4B5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:38:28 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id w83-20020a627b56000000b005182702c297so8766222pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NAVfZWpG8Q+tRmL5Yk4KGv9foVwAGiUt0byCTLoh0Qs=;
        b=mL72ipqwaDSH3H6EU6884wgdwdEXmr9gOlfcpP+Z4OCGlSBavhqxeul9ccA/S1S1/v
         Vj7s0NsIdlY9xcYnDolsRIWDzKJglmuXBf6D+fXEMOTPPGivP7QXDU9NJXJhPDj6t9eV
         WF7PC2AWuiSS3oUaAj0gtFpESIQRc4/p3lK5zEXtu27+aPCxL9hXVIiM7NZ4dfPhSKFq
         k4h0YtfLMeyE4XY8wDYb5FwhzkZdHvQUC330GFlf7sX0MF7hlO/oz0qTkqsQjLX2Gvse
         qNLngAt6pbNy4UrGxMsdgLA44FRNnYaVaFRzfzetY6UO63svMy1eWft8Eur0xqQn9fMT
         9FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NAVfZWpG8Q+tRmL5Yk4KGv9foVwAGiUt0byCTLoh0Qs=;
        b=qeQLWsqQUsA8nFDh63ROTTtkrs2GF1P+nBmgC4ch4pkmUs6ixzJhAH0Zuh7tCTcNHE
         FDBjoPx/2jQ/y21OQhvF8WMpUZm5/06lnRfazO+i2QwpkRySbYN2BzXeogiU2bBSkczm
         89H8yCmBNXiYKdYFLyQTzMiFRaftXp25VH21Gzq/7xW+jbfeTZQGfKk/3+W3BN0n2K5V
         SsuMGPkmvl7sVxm8zoMmTEsGS6WL1SFSYGdqEt/xnkQKM3gEbUVDCSC6XLJNDC7hWISz
         B4YVyrdWV6R4f8Mip4ehj4orE8UsZiHaxm4Rlm4VtKxNncK4uJ2h1zO870V6K7n0mQH5
         Cjow==
X-Gm-Message-State: AOAM532bkQLr88MOb+wl05ZwhT5ZC8g8ojy1OO9qz9vsjICk6kJ0J9P4
        g9g2OssU8LkMFFhBqIgpUKRG4rUc5rQ9
X-Google-Smtp-Source: ABdhPJyra9MQ1rj4iVIZVM4NumdbENhv0uLRNNRVoaI72bbkeTdcwnpdqlidShiveinndnFZlpymNl2E9bri
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1ab1:de5:7b7f:3844])
 (user=irogers job=sendgmr) by 2002:a63:7c4e:0:b0:380:8ae9:c975 with SMTP id
 l14-20020a637c4e000000b003808ae9c975mr27908754pgn.25.1653457107713; Tue, 24
 May 2022 22:38:27 -0700 (PDT)
Date:   Tue, 24 May 2022 22:38:14 -0700
In-Reply-To: <20220525053814.3265216-1-irogers@google.com>
Message-Id: <20220525053814.3265216-4-irogers@google.com>
Mime-Version: 1.0
References: <20220525053814.3265216-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v4 3/3] perf test: Json format checking
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
Cc:     Stephane Eranian <eranian@google.com>
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
---
 .../tests/shell/lib/perf_json_output_lint.py  |  94 +++++++++++
 tools/perf/tests/shell/stat+json_output.sh    | 147 ++++++++++++++++++
 2 files changed, 241 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+json_output.sh

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
new file mode 100644
index 000000000000..19477a5f1558
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -0,0 +1,94 @@
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
+        if count != expected_items and count == 1 and 'metric-value' in line:
+          # Events that generate >1 metric may have isolated metric values.
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
index 000000000000..7748b677f2f9
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
+		echo "[Skip] parnoia and not root"
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
+		echo "[Skip] parnoia and not root"
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
+		echo "[Skip] parnoia and not root"
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
+		echo "[Skip] parnoia and not root"
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
+		echo "[Skip] parnoia and not root"
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
+		echo "[Skip] parnoia and not root"
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
+		echo "[Skip] parnoia and not root"
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

