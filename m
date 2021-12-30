Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5B3481A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhL3HXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbhL3HWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9B2C061784
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s127-20020a252c85000000b0060be2b7b8e9so24395209ybs.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VldYUAKeuECWMwyFFC8E6bOGo9BFwwmAcr2cQniUPOk=;
        b=RKBK6w/QWeEpiShEYi3wM1bR05YaXAoeJOwJcKkaJ8720rXtnblpa+HocuNGx90zUr
         NwQKHQzdDBarnK8nXcDROdAAEszDSnzLF39SFSsdwhZcoGMgRTWMeHdJyNTKo0W609dI
         KpT8+E8udZ+BgiMEDIzKpS54D74uE9m3ThseumyGU2UgXrMn5oZuW3jxytP5AgMn2jc0
         xFb01pl5P0qrm/XGOZdOXttJCB70DM6DpU9Rf0Ka9HR3kVC3XlIvkhYPJKwtQNqP0Lpf
         7QuseeBOqaBqRbv8vy9qk8gQjuxaZi38r5A/8425DcHPGiS3gFxleBT85yw1povhyHSI
         NRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VldYUAKeuECWMwyFFC8E6bOGo9BFwwmAcr2cQniUPOk=;
        b=GnfMJynSDbqnFBe2hwAVyVGhGy5KGs4etgjeM4skKs/YVM8/kYfPZg+37c9a++W73s
         kv+rY3yxy2F9xwXDgDos1qUBeXCH7dEdUbUsMsT/nqv0OJxpojxkLgILHDxpo9MfNlgg
         bJykpL1/CQPfTjeWGC6q3NHhROWl46QuCFa+uNvl13zrExUlTGwJ7/OJFvyCO0n3Dqr2
         +jU1W7ll9Oxzd7cskCGm4zg5u5EOBdCV7lg7EP1W0yH1e3K4ksbeeNTOHh5ZtoDYeJak
         O5Wecq8TcSnJJFwXT7ZIMd1AVNcZD3zcR54ssWhGdD8eWRk/e3jcMpM+pkYx5rxygYuu
         hxOQ==
X-Gm-Message-State: AOAM530x3vmZGEPwkX3vSCNHV8YOwUGZUzTQYjZ1lH/Vt0nPQf8i4EdW
        HMIrdJYrHZvp8JWi8/yz+zdc448QtORL
X-Google-Smtp-Source: ABdhPJwPmt1KvsgrlWg0SA6rcAX61tFvgz7a7DWydQ0EyrMeFCRIsEOMnHqiiAY9VAD7FB4VwCUjJLdjjMuZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:3748:: with SMTP id
 e69mr30894951yba.378.1640848928536; Wed, 29 Dec 2021 23:22:08 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:18 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-38-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 36/48] perf stat: Correct variable name for read counter
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
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from cpu to cpu_map_idx to reduce confusion.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 24 ++++++++++++------------
 tools/perf/util/evsel.c   | 30 +++++++++++++++---------------
 tools/perf/util/evsel.h   | 16 ++++++++--------
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ec252579b587..68543bc7459f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -337,25 +337,25 @@ static int evsel__write_stat_event(struct evsel *counter, int cpu_map_idx, u32 t
 					   process_synthesized_event, NULL);
 }
 
-static int read_single_counter(struct evsel *counter, int cpu,
+static int read_single_counter(struct evsel *counter, int cpu_map_idx,
 			       int thread, struct timespec *rs)
 {
 	if (counter->tool_event == PERF_TOOL_DURATION_TIME) {
 		u64 val = rs->tv_nsec + rs->tv_sec*1000000000ULL;
 		struct perf_counts_values *count =
-			perf_counts(counter->counts, cpu, thread);
+			perf_counts(counter->counts, cpu_map_idx, thread);
 		count->ena = count->run = val;
 		count->val = val;
 		return 0;
 	}
-	return evsel__read_counter(counter, cpu, thread);
+	return evsel__read_counter(counter, cpu_map_idx, thread);
 }
 
 /*
  * Read out the results of a single counter:
  * do not aggregate counts across CPUs in system-wide mode
  */
-static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu)
+static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu_map_idx)
 {
 	int nthreads = perf_thread_map__nr(evsel_list->core.threads);
 	int thread;
@@ -369,24 +369,24 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu)
 	for (thread = 0; thread < nthreads; thread++) {
 		struct perf_counts_values *count;
 
-		count = perf_counts(counter->counts, cpu, thread);
+		count = perf_counts(counter->counts, cpu_map_idx, thread);
 
 		/*
 		 * The leader's group read loads data into its group members
 		 * (via evsel__read_counter()) and sets their count->loaded.
 		 */
-		if (!perf_counts__is_loaded(counter->counts, cpu, thread) &&
-		    read_single_counter(counter, cpu, thread, rs)) {
+		if (!perf_counts__is_loaded(counter->counts, cpu_map_idx, thread) &&
+		    read_single_counter(counter, cpu_map_idx, thread, rs)) {
 			counter->counts->scaled = -1;
-			perf_counts(counter->counts, cpu, thread)->ena = 0;
-			perf_counts(counter->counts, cpu, thread)->run = 0;
+			perf_counts(counter->counts, cpu_map_idx, thread)->ena = 0;
+			perf_counts(counter->counts, cpu_map_idx, thread)->run = 0;
 			return -1;
 		}
 
-		perf_counts__set_loaded(counter->counts, cpu, thread, false);
+		perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, false);
 
 		if (STAT_RECORD) {
-			if (evsel__write_stat_event(counter, cpu, thread, count)) {
+			if (evsel__write_stat_event(counter, cpu_map_idx, thread, count)) {
 				pr_err("failed to write stat event\n");
 				return -1;
 			}
@@ -396,7 +396,7 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu)
 			fprintf(stat_config.output,
 				"%s: %d: %" PRIu64 " %" PRIu64 " %" PRIu64 "\n",
 					evsel__name(counter),
-					cpu,
+					perf_cpu_map__cpu(evsel__cpus(counter), cpu_map_idx),
 					count->val, count->ena, count->run);
 		}
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6c9af21776e6..b4a2c5034cfe 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1476,11 +1476,11 @@ void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
 	count->run = count->run - tmp.run;
 }
 
-static int evsel__read_one(struct evsel *evsel, int cpu, int thread)
+static int evsel__read_one(struct evsel *evsel, int cpu_map_idx, int thread)
 {
-	struct perf_counts_values *count = perf_counts(evsel->counts, cpu, thread);
+	struct perf_counts_values *count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
-	return perf_evsel__read(&evsel->core, cpu, thread, count);
+	return perf_evsel__read(&evsel->core, cpu_map_idx, thread, count);
 }
 
 static void evsel__set_count(struct evsel *counter, int cpu, int thread, u64 val, u64 ena, u64 run)
@@ -1530,7 +1530,7 @@ static int evsel__process_group_data(struct evsel *leader, int cpu, int thread,
 	return 0;
 }
 
-static int evsel__read_group(struct evsel *leader, int cpu, int thread)
+static int evsel__read_group(struct evsel *leader, int cpu_map_idx, int thread)
 {
 	struct perf_stat_evsel *ps = leader->stats;
 	u64 read_format = leader->core.attr.read_format;
@@ -1551,42 +1551,42 @@ static int evsel__read_group(struct evsel *leader, int cpu, int thread)
 		ps->group_data = data;
 	}
 
-	if (FD(leader, cpu, thread) < 0)
+	if (FD(leader, cpu_map_idx, thread) < 0)
 		return -EINVAL;
 
-	if (readn(FD(leader, cpu, thread), data, size) <= 0)
+	if (readn(FD(leader, cpu_map_idx, thread), data, size) <= 0)
 		return -errno;
 
-	return evsel__process_group_data(leader, cpu, thread, data);
+	return evsel__process_group_data(leader, cpu_map_idx, thread, data);
 }
 
-int evsel__read_counter(struct evsel *evsel, int cpu, int thread)
+int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	u64 read_format = evsel->core.attr.read_format;
 
 	if (read_format & PERF_FORMAT_GROUP)
-		return evsel__read_group(evsel, cpu, thread);
+		return evsel__read_group(evsel, cpu_map_idx, thread);
 
-	return evsel__read_one(evsel, cpu, thread);
+	return evsel__read_one(evsel, cpu_map_idx, thread);
 }
 
-int __evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread, bool scale)
+int __evsel__read_on_cpu(struct evsel *evsel, int cpu_map_idx, int thread, bool scale)
 {
 	struct perf_counts_values count;
 	size_t nv = scale ? 3 : 1;
 
-	if (FD(evsel, cpu, thread) < 0)
+	if (FD(evsel, cpu_map_idx, thread) < 0)
 		return -EINVAL;
 
 	if (evsel->counts == NULL && evsel__alloc_counts(evsel) < 0)
 		return -ENOMEM;
 
-	if (readn(FD(evsel, cpu, thread), &count, nv * sizeof(u64)) <= 0)
+	if (readn(FD(evsel, cpu_map_idx, thread), &count, nv * sizeof(u64)) <= 0)
 		return -errno;
 
-	evsel__compute_deltas(evsel, cpu, thread, &count);
+	evsel__compute_deltas(evsel, cpu_map_idx, thread, &count);
 	perf_counts_values__scale(&count, scale, NULL);
-	*perf_counts(evsel->counts, cpu, thread) = count;
+	*perf_counts(evsel->counts, cpu_map_idx, thread) = count;
 	return 0;
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 7cb7c9c77ab0..c3db41282400 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -333,32 +333,32 @@ static inline bool evsel__match2(struct evsel *e1, struct evsel *e2)
 	       (e1->core.attr.config == e2->core.attr.config);
 }
 
-int evsel__read_counter(struct evsel *evsel, int cpu, int thread);
+int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread);
 
-int __evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread, bool scale);
+int __evsel__read_on_cpu(struct evsel *evsel, int cpu_map_idx, int thread, bool scale);
 
 /**
  * evsel__read_on_cpu - Read out the results on a CPU and thread
  *
  * @evsel - event selector to read value
- * @cpu - CPU of interest
+ * @cpu_map_idx - CPU of interest
  * @thread - thread of interest
  */
-static inline int evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread)
+static inline int evsel__read_on_cpu(struct evsel *evsel, int cpu_map_idx, int thread)
 {
-	return __evsel__read_on_cpu(evsel, cpu, thread, false);
+	return __evsel__read_on_cpu(evsel, cpu_map_idx, thread, false);
 }
 
 /**
  * evsel__read_on_cpu_scaled - Read out the results on a CPU and thread, scaled
  *
  * @evsel - event selector to read value
- * @cpu - CPU of interest
+ * @cpu_map_idx - CPU of interest
  * @thread - thread of interest
  */
-static inline int evsel__read_on_cpu_scaled(struct evsel *evsel, int cpu, int thread)
+static inline int evsel__read_on_cpu_scaled(struct evsel *evsel, int cpu_map_idx, int thread)
 {
-	return __evsel__read_on_cpu(evsel, cpu, thread, true);
+	return __evsel__read_on_cpu(evsel, cpu_map_idx, thread, true);
 }
 
 int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
-- 
2.34.1.448.ga2b2bfdf31-goog

