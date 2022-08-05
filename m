Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A0A58B0AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241493AbiHEUBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241363AbiHEUBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:01:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804AD11A1C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:01:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-32851d0f8beso29060947b3.22
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=ha9AD4Sj+hwkiJ3LZTNTfKrp4WGHbc/BqXCKSvNaYpQ=;
        b=B1hn6NxEJwKhZ1y8v6wcsYv5OAhMgoPF1X7sBQp1zn/zhwxJ9v3UT+oYd8CF6XuPLD
         nnaR68gWVZm+QUpliphguKJ0VhvLNtsdAbLPPmBLpT7z/ni05Cngqwufj1cKQuLjLRRZ
         s4yoa3x9013utzi8WqmloQGiUAGcToryptixS8l6+C4Qkd2BqMDCQT8zoJW8C971ubpC
         2mn5d1ATcUsEgwm/mBiVh3s5Zf2bOpBgOS1kaDhIbMd4eJBltEDGkAPCs8EA92B5gu63
         JyrQlQLieyTddsanpcdtAkZK12BoZPbOXJFSkPprkEd/W0m7Q41d9EBhk/QpWbhdkiro
         uf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ha9AD4Sj+hwkiJ3LZTNTfKrp4WGHbc/BqXCKSvNaYpQ=;
        b=N7971kz/9aCiLXA4R8LZyz7gUa5YS7DuHEFm7dW4wl7yiaiAkmoftqWzdcyAkUqq61
         VY59HlcgftG+iKbDn3PHkxGfRxMpoWx2gFLV5UbLP9yrzBluWua3UCd6pVBu9V0No+Bp
         jlmZpAtwrn2GLgoEd4Fi1fUW9z8KqptBCHsEUM1JiEWovTb1u+SN+jLrj6tZ7kVjHIfM
         XNyZ2oJ/TsLEBY9NXcyT8fNsv6r8dulhp/X4/E0XP5Tnp2jJ2KChLjQHqaje/w5DI0Ps
         d/8Tm7F9uYe+Y4ZveSQvQEBfuLlsI0/zoODnPP1NCeP3koqL8/t/a8jB7E6Rb7Qt+1TU
         RR6w==
X-Gm-Message-State: ACgBeo2OycSrVFg6zNbtMR4MMmRQKuo/EWO1ZdBYpogLJerAkvPVT/Hf
        uubAUeyLNLkIAPiIC9R3S9f/09EVGvCD
X-Google-Smtp-Source: AA6agR5ju/xKakaL3jFGX9yKp9awnqabU23NtmPCyvaZVpb5r10aHOzlqS8M1bOtMXWsHMg3sW02NQiajQ5+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7470:b814:73a6:b6b9])
 (user=irogers job=sendgmr) by 2002:a25:58f:0:b0:672:52cf:5948 with SMTP id
 137-20020a25058f000000b0067252cf5948mr6327035ybf.574.1659729676801; Fri, 05
 Aug 2022 13:01:16 -0700 (PDT)
Date:   Fri,  5 Aug 2022 13:01:05 -0700
In-Reply-To: <20220805200105.2020995-1-irogers@google.com>
Message-Id: <20220805200105.2020995-3-irogers@google.com>
Mime-Version: 1.0
References: <20220805200105.2020995-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v7 2/2] perf test: Json format checking
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 tools/perf/Makefile.perf                      |   3 +-
 .../tests/shell/lib/perf_json_output_lint.py  |  96 ++++++++++++
 tools/perf/tests/shell/stat+json_output.sh    | 147 ++++++++++++++++++
 3 files changed, 245 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+json_output.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5053b563bf9c..b4c5160d3e85 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1005,7 +1005,8 @@ install-tests: all install-gtk
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
 		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
-		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
+		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib' \
+		$(INSTALL) tests/shell/lib/*.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
 
 install-bin: install-tools install-tests install-traceevent-plugins
 
diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
new file mode 100644
index 000000000000..d90f8d102eb9
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -0,0 +1,96 @@
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
+        if count != expected_items and count >= 1 and count <= 3 and 'metric-value' in line:
+          # Events that generate >1 metric may have isolated metric
+          # values and possibly other prefixes like interval, core and
+          # aggregate-number.
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
2.37.1.559.g78731f0fdb-goog

