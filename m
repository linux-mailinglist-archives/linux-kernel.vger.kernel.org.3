Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FCC533682
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244034AbiEYFi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244022AbiEYFiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:38:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925236F4AC
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:38:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n3-20020a257203000000b0064f867fcfc0so9721073ybc.15
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=isI4nyYDFbXZPYAS8w0X87BD31WJqA2RdcFDLWELfC0=;
        b=AyQCf7IdpOnQGQgbhwRURQ3HE/cMTqT4F6udtnwL4j4ZlhNNMN21T1qEVCQfu1xu/m
         2vZGQETCHeZPbUU29g66A3fu31P5d78O3/xj0Y97Re8dKLJjpuRpNWc+u0wEAw/K0jDW
         5b2rU9xjKi292AtLf46V7Ab75w4l4k2jtbmww+fzXD8LHvSQxlCop6Di5XtDIYmZ3eft
         Fq1jJQ4eOFMtia/JAKiu3+WnOwdzyybTqt54OkNJPA1kfATyZl5qfJVPYtc8xeAzXVPe
         5wEKv6Fq1Ib0mfd2d89IHAGn4aUGRdmJM33ivZ9ffnCIiz96dfWifEXpuu1XRvb+Yhph
         S5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=isI4nyYDFbXZPYAS8w0X87BD31WJqA2RdcFDLWELfC0=;
        b=rjPz9wayMyZyw5ZtoC9b9LbytzAwr0LRCW/np5mtgLdppMwneR3mnecQpAZS0N3hpu
         RdYdUBNWfsmp9UbMLa8WRO+jx1E23pioOZhACHSv0ox//yAGZYOtjrNbi40kkCde5uyc
         BRFqFBthZMpfW0mvXOs1pvK2arWkEkZppM8pcoWb87KOmPRl4SYprqN5TzdJcdHFtSA8
         4gcKyHA6hMKpgE40XXsw79+a67feFS8w+vcKjM72yTkgrJRqrg6/J1FgxfuBmo2QyuSn
         UBYrI3P+WZzSVOKk729EnNYzGEvsQVulbtbfE5yiCFbFNy9D9UdYfLXXg5SrD88rUS0S
         lNsA==
X-Gm-Message-State: AOAM5326poxd25uGaeJBv+zw1Uz4/PonrilJFD22zyXl6qPmHc1//yPO
        jEjpTidZUfkqg8j3ZeJQV6XEdLlwyudu
X-Google-Smtp-Source: ABdhPJyGThEjPUwawkJwDr8a2Frn7p3pyKAu7/bmgte8v8Hpqf7oVLFCo1/SU5Szhn1jEwi0vjHqQnQ0rBs1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1ab1:de5:7b7f:3844])
 (user=irogers job=sendgmr) by 2002:a5b:e8d:0:b0:64f:b792:4b5a with SMTP id
 z13-20020a5b0e8d000000b0064fb7924b5amr15294459ybr.184.1653457102822; Tue, 24
 May 2022 22:38:22 -0700 (PDT)
Date:   Tue, 24 May 2022 22:38:12 -0700
In-Reply-To: <20220525053814.3265216-1-irogers@google.com>
Message-Id: <20220525053814.3265216-2-irogers@google.com>
Mime-Version: 1.0
References: <20220525053814.3265216-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v4 1/3] perf test: Add checking for perf stat CSV output.
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claire Jensen <cjense@google.com>

Counts expected fields for various commands. No testing added for
summary mode since it is broken.

An example of the summary output is:

         summary,263831,,instructions:u,1435072,100.0,0.46,insn per cycle
,,,,,1.37,stalled cycles per insn

This should be:

         summary,263831,,instructions:u,1435072,100.0,0.46,insn per cycle
         summary,,,,,,1.37,stalled cycles per insn

The output has 7 fields when it should have 8. Additionally, the newline
spacing is wrong, so it was excluded from testing until a fix is made.

Signed-off-by: Claire Jensen <cjense@google.com>
---
 .../tests/shell/lib/perf_csv_output_lint.py   |  48 ++++++
 tools/perf/tests/shell/stat+csv_output.sh     | 147 ++++++++++++++++++
 2 files changed, 195 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/perf_csv_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+csv_output.sh

diff --git a/tools/perf/tests/shell/lib/perf_csv_output_lint.py b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
new file mode 100644
index 000000000000..714f283cfb1b
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_csv_output_lint.py
@@ -0,0 +1,48 @@
+#!/usr/bin/python
+# SPDX-License-Identifier: GPL-2.0
+
+import argparse
+import sys
+
+# Basic sanity check of perf CSV output as specified in the man page.
+# Currently just checks the number of fields per line in output.
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
+ap.add_argument('--separator', default=',', nargs='?')
+args = ap.parse_args()
+
+Lines = sys.stdin.readlines()
+
+def check_csv_output(exp):
+  for line in Lines:
+    if 'failed' not in line:
+      count = line.count(args.separator)
+      if count != exp:
+        sys.stdout.write(''.join(Lines))
+        raise RuntimeError(f'wrong number of fields. expected {exp} in {line}')
+
+try:
+  if args.no_args or args.system_wide or args.event:
+    expected_items = 6
+  elif args.interval or args.per_thread or args.system_wide_no_aggr:
+    expected_items = 7
+  elif args.per_core or args.per_socket or args.per_node or args.per_die:
+    expected_items = 8
+  else:
+    ap.print_help()
+    raise RuntimeError('No checking option specified')
+  check_csv_output(expected_items)
+
+except:
+  sys.stdout.write('Test failed for input: ' + ''.join(Lines))
+  raise
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
new file mode 100755
index 000000000000..82c25e9c7f21
--- /dev/null
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -0,0 +1,147 @@
+#!/bin/bash
+# perf stat CSV output linter
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+# Tests various perf stat CSV output commands for the
+# correct number of fields and the CSV separator set to ','.
+
+set -e
+
+pythonchecker=$(dirname $0)/lib/perf_csv_output_lint.py
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
+	echo -n "Checking CSV output: no args "
+	perf stat -x, true 2>&1 | $PYTHON $pythonchecker --no-args
+	echo "[Success]"
+}
+
+check_system_wide()
+{
+	echo -n "Checking CSV output: system wide "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -x, -a true 2>&1 | $PYTHON $pythonchecker --system-wide
+	echo "[Success]"
+}
+
+check_system_wide_no_aggr()
+{
+	echo -n "Checking CSV output: system wide "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	echo -n "Checking CSV output: system wide no aggregation "
+	perf stat -x, -A -a --no-merge true 2>&1 | $PYTHON $pythonchecker --system-wide-no-aggr
+	echo "[Success]"
+}
+
+check_interval()
+{
+	echo -n "Checking CSV output: interval "
+	perf stat -x, -I 1000 true 2>&1 | $PYTHON $pythonchecker --interval
+	echo "[Success]"
+}
+
+
+check_event()
+{
+	echo -n "Checking CSV output: event "
+	perf stat -x, -e cpu-clock true 2>&1 | $PYTHON $pythonchecker --event
+	echo "[Success]"
+}
+
+check_per_core()
+{
+	echo -n "Checking CSV output: per core "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -x, --per-core -a true 2>&1 | $PYTHON $pythonchecker --per-core
+	echo "[Success]"
+}
+
+check_per_thread()
+{
+	echo -n "Checking CSV output: per thread "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -x, --per-thread -a true 2>&1 | $PYTHON $pythonchecker --per-thread
+	echo "[Success]"
+}
+
+check_per_die()
+{
+	echo -n "Checking CSV output: per die "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -x, --per-die -a true 2>&1 | $PYTHON $pythonchecker --per-die
+	echo "[Success]"
+}
+
+check_per_node()
+{
+	echo -n "Checking CSV output: per node "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -x, --per-node -a true 2>&1 | $PYTHON $pythonchecker --per-node
+	echo "[Success]"
+}
+
+check_per_socket()
+{
+	echo -n "Checking CSV output: per socket "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] parnoia and not root"
+		return
+	fi
+	perf stat -x, --per-socket -a true 2>&1 | $PYTHON $pythonchecker --per-socket
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

