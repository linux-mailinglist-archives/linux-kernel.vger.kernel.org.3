Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6B356A709
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiGGPfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiGGPfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:35:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B161C2613D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 08:35:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dc7bdd666fso128220077b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2pfQgMjQXWxR5Q+I2zaSRMdI5V/K7SCuur/y1TvgGAk=;
        b=nh6ghsSCER/zF4Q2zRtjOfSQevq/9s5A8fdvE5OPnGYgOJfBAjtmvuewkhoaU3ukSs
         fkjvCwFBieHF7rpfsTyEEDD4OuXVt0YhvBVgKvVMtTNFV9Xcz9lvWjAgWMsjk4QLrazT
         H9v9mNZeLKboEbJnTe41WMYH65E41jbqQ7rY3oqUQuRtio5FosN6MtO1peCipgbM+Yv8
         WyuPQaPsJumD/7F1Hq3TlxSeIDTkeOl5unzMQqd03wNPBzWz+fWvouEwdXkUGgyVwfUs
         5eYTmnW4LMhl+FMirgttukfLCSFDoRj8un/iqwK0KGDNp3GhZiQc6Vm6MMOWaV7TzLtu
         jsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2pfQgMjQXWxR5Q+I2zaSRMdI5V/K7SCuur/y1TvgGAk=;
        b=kTObAM9iug5Yn6AWQ9UjY1eK/kw5HoRb6AINxQPF4M3yqmVM+3Td6vSUskIq2ovB3q
         w4TQX6nF3e9PFRjkNJHsuRJrKrXigVO5WLFuT28CgdAEuyqPCo4ma6orBc/CoTPrK2bE
         gENeyfoEIBiqvugKEAAMS5mR012sdImPJzJkbFDBlq3NlvJhRYWkGk93mFxK38uHsze8
         r5HF/WeC/HWpFDtMRhDkmGNl9yn7N2rY3zc8zJ0yNdmUaN+loSSLyruirEgT/XZ+E9KF
         t5++KgTjhMgLSv04o2YNaWoCxVafsmF4fL03Pp2EMctWMGXG+fdPZVtqI+By2aXZxzYm
         /InQ==
X-Gm-Message-State: AJIora9ZxE8wG4GXNT018tkIEUtvs9nUFs9xffGt62brKSZ144tproqS
        6MbLV/lCrc4URh9j2DbeRYe3xhT6p6nY
X-Google-Smtp-Source: AGRyM1tcexmMO+FQuFPJIvUGUzT4HeF/cVd7lZ/beAgPUZlUM0s2l2z5r/pTRFj+Srfol0fUeBrGQNl9ysVF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf75:f79:d509:a8d1])
 (user=irogers job=sendgmr) by 2002:a25:eb08:0:b0:664:3fbd:f9c9 with SMTP id
 d8-20020a25eb08000000b006643fbdf9c9mr49303932ybs.88.1657208100017; Thu, 07
 Jul 2022 08:35:00 -0700 (PDT)
Date:   Thu,  7 Jul 2022 08:34:49 -0700
In-Reply-To: <20220707153449.202409-1-irogers@google.com>
Message-Id: <20220707153449.202409-2-irogers@google.com>
Mime-Version: 1.0
References: <20220707153449.202409-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH 2/2] perf test: Make all metrics test more tolerant
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Metric names are truncated so don't try to match all of one.
Allow AMX metrics to skip as floating point ones do.
Metrics for optane memory can also skip rather than fail.
Add a system wide check for uncore metrics.
Restructure code to avoid extensive nesting.

Some impetus for this in:
https://lore.kernel.org/lkml/d32376b5-5538-ff00-6620-e74ad4b4abf2@huawei.com/
Suggested-by: John Garry <john.garry@huawei.com>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 47 ++++++++++++++--------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index e7c59e5a7a98..6e79349e42be 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -1,26 +1,41 @@
-#!/bin/sh
+#!/bin/bash
 # perf all metrics test
 # SPDX-License-Identifier: GPL-2.0
 
-set -e
-
 err=0
 for m in $(perf list --raw-dump metrics); do
   echo "Testing $m"
   result=$(perf stat -M "$m" true 2>&1)
-  if [[ ! "$result" =~ "$m" ]] && [[ ! "$result" =~ "<not supported>" ]]; then
-    # We failed to see the metric and the events are support. Possibly the
-    # workload was too small so retry with something longer.
-    result=$(perf stat -M "$m" perf bench internals synthesize 2>&1)
-    if [[ ! "$result" =~ "$m" ]]; then
-      echo "Metric '$m' not printed in:"
-      echo "$result"
-      if [[ "$result" =~ "FP_ARITH" && "$err" != "1" ]]; then
-        echo "Skip, not fail, for FP issues"
-        err=2
-      else
-        err=1
-      fi
+  if [[ "$result" =~ "${m:0:50}" ]] || [[ "$result" =~ "<not supported>" ]]
+  then
+    continue
+  fi
+  # Failed so try system wide.
+  result=$(perf stat -M "$m" -a true 2>&1)
+  if [[ "$result" =~ "${m:0:50}" ]]
+  then
+    continue
+  fi
+  # Failed again, possibly the workload was too small so retry with something
+  # longer.
+  result=$(perf stat -M "$m" perf bench internals synthesize 2>&1)
+  if [[ "$result" =~ "${m:0:50}" ]]
+  then
+    continue
+  fi
+  echo "Metric '$m' not printed in:"
+  echo "$result"
+  if [[ "$err" != "1" ]]
+  then
+    err=2
+    if [[ "$result" =~ "FP_ARITH" || "$result" =~ "AMX" ]]
+    then
+      echo "Skip, not fail, for FP issues"
+    elif [[ "$result" =~ "PMM" ]]
+    then
+      echo "Skip, not fail, for Optane memory issues"
+    else
+      err=1
     fi
   fi
 done
-- 
2.37.0.rc0.161.g10f37bed90-goog

