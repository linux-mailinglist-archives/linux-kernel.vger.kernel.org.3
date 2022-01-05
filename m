Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93262484E36
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiAEGQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbiAEGPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE5DC06137F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b144-20020a253496000000b0060bddc72114so53308331yba.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VldYUAKeuECWMwyFFC8E6bOGo9BFwwmAcr2cQniUPOk=;
        b=KgLJmuTlBICxnNTmkTUGhTNgQw9OYHKvzG1LwG3Y//EeIgW/PR/M2XRV0FRd58xn/w
         /s1c5GigoFjg48SSU5PYOmkntcNxlQFK2r6uwWjVztpVuO5U1i/61hUcYH7APY0xmCft
         33wRLHds1ahKQA+mO+3TtfpmLB3yaNkwrhwmB7x0O2tirObY+xWg9GQ24yoNjj3KWsqA
         ya2I36i5ht1u7NgILSoAO9zkBJpn8XNaoPH4XGgtrfaM6OCrUd3j0CjWX9kZHhHChlr2
         lGmOK2FWcOYKBkqHfCR6/tPNhHE1ZJP7Fw0WoC6YgJREE6AInh0Ve47aU/ZkCq6qR4xS
         Uw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VldYUAKeuECWMwyFFC8E6bOGo9BFwwmAcr2cQniUPOk=;
        b=vfL0iaJLjOIG8MqCNGj5+tUSvTd4gym4yiZcdqBb9COI1VLszU0EON41PMev9M1H9N
         n1QNVtpk9w6ZOwGtU2TjhZeGef4qhrcvIpVTN9evoPNdOfT9hdDCQHx/E9wrxDnbRhwp
         RAh/7iBaq/Q3FKVrBjS4sdnPwuL7IQE/lZpjvXOOJ+B0HGVbaF+c2qsX9BO5A84I8rTP
         DV4K/FblfAyQFMwY+QKJnJiWZDd7OPtD4Q3K1N5qgJE7SqslEolMP31+/ZS5VOUsljud
         uT5EH5KjRCguRPBvBtWr8varsuIesm9RkRgT4z6twU6OThYvAa/wkCG1wFB3f1uVjH7A
         3DLg==
X-Gm-Message-State: AOAM533rOitxTVr0khymgRkxu86EK8oVM2rfr5W4dv295cxOt+wD+i1d
        bAcU2Y6RiLleSqwFNFNRoV3Jh3tXK9s1
X-Google-Smtp-Source: ABdhPJwblJTFelSqzqQYKbSUyi+vnrHr0A8gw8DaaoqdMx/TMeD0p6yEmYF6hlP3QvRhGuVErnXK86gTpjUC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:aacd:: with SMTP id
 t71mr49890558ybi.542.1641363327626; Tue, 04 Jan 2022 22:15:27 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:39 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-37-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 36/48] perf stat: Correct variable name for read counter
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

