Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D1247DFD3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347185AbhLWHsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239143AbhLWHrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B6FC061396
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d27-20020a25addb000000b005c2355d9052so8657113ybe.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KSXy9ATDOwcZ/rEbQw1i8r+s/0Z51P4OcVCvaux1vkY=;
        b=UlhpLZUuzZ8abEN/Gzuqndw3CpVJYzc/d08nP0X9kw5NGl+l8gKl9QAzM01hFWnuy8
         miKFHwR3Vxghj2irYRCdIcIIGUhOJr5Uu/FBnm+5TmpN6/MTZ9o9S+6DmI/qOp0wL1Xr
         0h7toeV0FPhc2eB9rwdh/t1SFHbKiPoIkFWod56tze/5f7+cESjGfAs/sgXBNLwaIZgO
         73wBokpaXYm2QwsmnsG7X3G7Dw1U1xRzMX+bFqaV7ulENC8FPIkgRX15g9nBIdHyg9Ta
         D6y3kIC8VKeN2iAHqEdlplMFEvl0htBaFoWJu+5kGiQ1mgSxokTwxXqgL55kLOfghj1Y
         9xmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KSXy9ATDOwcZ/rEbQw1i8r+s/0Z51P4OcVCvaux1vkY=;
        b=uXMABugO0dYulWjqAJMv8Unadec9/0yY4IY1DrRmgDRq51+FruO3bGtPe0wklsTOIN
         SgWhCl6b/iijSEDzgVVposwErR6fW117rTqiTaGc9PNrqGJCL/fYsUOb/Pb+vr9LoGU7
         9exupgURNA8Dn4tYGXLjKZ6VzHIeGPxyq2kC+q6tC78EMwIMwY1ouvSYzBa71mTIoVXw
         u8Nxsu+dcggO8HC89JYBKJqbu/W7WeBSABCzTXVcMqQpREukntqzXPSuFb1EF+taXarv
         JKNrcn52FM9OkrcwbtUkgx2ys+Gb4AR0rpnMcmHanpboax2b7v9s26z61546HZc4iTIg
         Ks2Q==
X-Gm-Message-State: AOAM530dK8D5NQr0GvQctoMwabHDZGON/fFEoOyPdSF639IrT7E8Ch7P
        dwgeCGRVdEiW3WxQCN3TvDDv852DwKo/
X-Google-Smtp-Source: ABdhPJxbsXOPk2WMCPKJLYjXolQiSaV0gMEvhHEdya7o+nFosvtmAS1pSHQIQT4QWQz4gdM5R6bgcMs/Wmi+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:ae12:: with SMTP id
 a18mr1754765ybj.286.1640245634152; Wed, 22 Dec 2021 23:47:14 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:19 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-27-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 26/48] perf evsel: Derive CPUs and threads in alloc_counts
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing the number of CPUs and threads allows for an evsel's counts to
be mismatched to its cpu map. To avoid this always derive the counts
size from the cpu map. Change openaat-syscall-all-cpus to set the cpus
to allow for this to work.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/openat-syscall-all-cpus.c | 10 +---------
 tools/perf/util/counts.c                   |  8 ++++++--
 tools/perf/util/counts.h                   |  2 +-
 tools/perf/util/evsel.c                    |  2 +-
 tools/perf/util/stat.c                     | 13 ++++++-------
 5 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index cd3dd463783f..544db0839b3b 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -85,15 +85,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 		CPU_CLR(cpus->map[cpu], &cpu_set);
 	}
 
-	/*
-	 * Here we need to explicitly preallocate the counts, as if
-	 * we use the auto allocation it will allocate just for 1 cpu,
-	 * as we start by cpu 0.
-	 */
-	if (evsel__alloc_counts(evsel, cpus->nr, 1) < 0) {
-		pr_debug("evsel__alloc_counts(ncpus=%d)\n", cpus->nr);
-		goto out_close_fd;
-	}
+	evsel->core.cpus = perf_cpu_map__get(cpus);
 
 	err = 0;
 
diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
index 582f3aeaf5e4..2b81707b9dba 100644
--- a/tools/perf/util/counts.c
+++ b/tools/perf/util/counts.c
@@ -4,6 +4,7 @@
 #include <string.h>
 #include "evsel.h"
 #include "counts.h"
+#include <perf/threadmap.h>
 #include <linux/zalloc.h>
 
 struct perf_counts *perf_counts__new(int ncpus, int nthreads)
@@ -55,9 +56,12 @@ void evsel__reset_counts(struct evsel *evsel)
 	perf_counts__reset(evsel->counts);
 }
 
-int evsel__alloc_counts(struct evsel *evsel, int ncpus, int nthreads)
+int evsel__alloc_counts(struct evsel *evsel)
 {
-	evsel->counts = perf_counts__new(ncpus, nthreads);
+	struct perf_cpu_map *cpus = evsel__cpus(evsel);
+	int nthreads = perf_thread_map__nr(evsel->core.threads);
+
+	evsel->counts = perf_counts__new(cpus ? cpus->nr : 1, nthreads);
 	return evsel->counts != NULL ? 0 : -ENOMEM;
 }
 
diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 7ff36bf6d644..3e275e9c60d1 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -40,7 +40,7 @@ void perf_counts__delete(struct perf_counts *counts);
 void perf_counts__reset(struct perf_counts *counts);
 
 void evsel__reset_counts(struct evsel *evsel);
-int evsel__alloc_counts(struct evsel *evsel, int ncpus, int nthreads);
+int evsel__alloc_counts(struct evsel *evsel);
 void evsel__free_counts(struct evsel *evsel);
 
 #endif /* __PERF_COUNTS_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 656c30b988ce..6c9af21776e6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1578,7 +1578,7 @@ int __evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread, bool scale)
 	if (FD(evsel, cpu, thread) < 0)
 		return -EINVAL;
 
-	if (evsel->counts == NULL && evsel__alloc_counts(evsel, cpu + 1, thread + 1) < 0)
+	if (evsel->counts == NULL && evsel__alloc_counts(evsel) < 0)
 		return -ENOMEM;
 
 	if (readn(FD(evsel, cpu, thread), &count, nv * sizeof(u64)) <= 0)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index c69b221f5e3e..995cb5003133 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -152,11 +152,13 @@ static void evsel__free_stat_priv(struct evsel *evsel)
 	zfree(&evsel->stats);
 }
 
-static int evsel__alloc_prev_raw_counts(struct evsel *evsel, int ncpus, int nthreads)
+static int evsel__alloc_prev_raw_counts(struct evsel *evsel)
 {
+	int cpu_map_nr = evsel__nr_cpus(evsel);
+	int nthreads = perf_thread_map__nr(evsel->core.threads);
 	struct perf_counts *counts;
 
-	counts = perf_counts__new(ncpus, nthreads);
+	counts = perf_counts__new(cpu_map_nr, nthreads);
 	if (counts)
 		evsel->prev_raw_counts = counts;
 
@@ -177,12 +179,9 @@ static void evsel__reset_prev_raw_counts(struct evsel *evsel)
 
 static int evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
 {
-	int ncpus = evsel__nr_cpus(evsel);
-	int nthreads = perf_thread_map__nr(evsel->core.threads);
-
 	if (evsel__alloc_stat_priv(evsel) < 0 ||
-	    evsel__alloc_counts(evsel, ncpus, nthreads) < 0 ||
-	    (alloc_raw && evsel__alloc_prev_raw_counts(evsel, ncpus, nthreads) < 0))
+	    evsel__alloc_counts(evsel) < 0 ||
+	    (alloc_raw && evsel__alloc_prev_raw_counts(evsel) < 0))
 		return -ENOMEM;
 
 	return 0;
-- 
2.34.1.307.g9b7440fafd-goog

