Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BDE481A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbhL3HXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbhL3HWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC86AC061398
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p140-20020a257492000000b0060dbb88d8abso11652175ybc.15
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rP8ip1untvKGcveI9MVlNiR5K/ovCndq9tVyyZVMRi8=;
        b=R4sOJhYmydPctklNw01MJ/rb+re5LguDPGbwngFXgxv2OAZbjNZGN+w0fR1zhyqiyn
         5SBC0kFK0Zfab8tsgcluaMnpovdgXFkIwEQ2bZrhjx4RmeW7hJoP2N7mbJdaorcigsG6
         7j1tU/+5b82zOJ4Z1ZC9d2CXgdcBy8L3fFmFuixE7eBrENCewYWVwpr7EIv5Dks4LG9K
         /lqeB3mbDl/bM7cT16tnYqanM6UbII/27YwFJlT+L4+Lo63E+Cen9WwyYo/fNK/3RFC0
         YOvhdRqy+joyxuRO8sLQkBd6nNMI5ca2YtGBhJufdD5rlVBSmbU/tOL4am0gd926vSJB
         ly5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rP8ip1untvKGcveI9MVlNiR5K/ovCndq9tVyyZVMRi8=;
        b=UlJ10qTJZU+crgRivkeGpxHGC1S2FYpWDyEBL/EMOBOoMwrpJfoh7sJOiT7q2s2lDj
         RXg6AK6gzhM4IAnE1r31snT0C8i8w4cXX7WBIp32KsVhj9W+rtmryY5HPWCCLa5lBRvh
         1rVG1TNt6qXsu5iJ9USH451Ml9YsDmhca/cPmi65f7s3m3+6iI7QuVuprpKQHR85Scfa
         D5NogYhVFnG4ygnOjpeD2mh8fYQjAnXjaDttNN84ufHFpo4jJBT6hH3f5qzmuWPi0Bv5
         s9fSnxHlMN3oiBDa5nA5OOC5e+igIp6AKOVHvOHCkvsb9dnpvGGnlUEYDlIVeJzGCghR
         pE6A==
X-Gm-Message-State: AOAM531pYe8Gr5WDk0RlatjHJyy0e7nTvILyLplb+kIgSOARgyn/3Ud6
        xmGN/IcoQizhiDNJxEKF9ySnUVbNQ9k5
X-Google-Smtp-Source: ABdhPJy24aCEeLl9lJG1uM9REA7mFF/LzdTIXcwJMPisp3xe/m0TsayLCWEL/ws9Erxc66hxifFuYV6zoiWI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a5b:d05:: with SMTP id y5mr25787400ybp.300.1640848935969;
 Wed, 29 Dec 2021 23:22:15 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:21 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-41-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 39/48] perf evsel: Rename variable cpu to index
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

Make naming less error prone.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 83 +++++++++++++++++++++--------------------
 tools/perf/util/evsel.h |  6 +--
 tools/perf/util/stat.c  |  4 +-
 tools/perf/util/stat.h  |  2 +-
 4 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8911ebde54d6..2b18b29a534f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1372,9 +1372,9 @@ int evsel__append_addr_filter(struct evsel *evsel, const char *filter)
 }
 
 /* Caller has to clear disabled after going through all CPUs. */
-int evsel__enable_cpu(struct evsel *evsel, int cpu)
+int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__enable_cpu(&evsel->core, cpu);
+	return perf_evsel__enable_cpu(&evsel->core, cpu_map_idx);
 }
 
 int evsel__enable(struct evsel *evsel)
@@ -1387,9 +1387,9 @@ int evsel__enable(struct evsel *evsel)
 }
 
 /* Caller has to set disabled after going through all CPUs. */
-int evsel__disable_cpu(struct evsel *evsel, int cpu)
+int evsel__disable_cpu(struct evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__disable_cpu(&evsel->core, cpu);
+	return perf_evsel__disable_cpu(&evsel->core, cpu_map_idx);
 }
 
 int evsel__disable(struct evsel *evsel)
@@ -1455,7 +1455,7 @@ void evsel__delete(struct evsel *evsel)
 	free(evsel);
 }
 
-void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
+void evsel__compute_deltas(struct evsel *evsel, int cpu_map_idx, int thread,
 			   struct perf_counts_values *count)
 {
 	struct perf_counts_values tmp;
@@ -1463,12 +1463,12 @@ void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
 	if (!evsel->prev_raw_counts)
 		return;
 
-	if (cpu == -1) {
+	if (cpu_map_idx == -1) {
 		tmp = evsel->prev_raw_counts->aggr;
 		evsel->prev_raw_counts->aggr = *count;
 	} else {
-		tmp = *perf_counts(evsel->prev_raw_counts, cpu, thread);
-		*perf_counts(evsel->prev_raw_counts, cpu, thread) = *count;
+		tmp = *perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
+		*perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread) = *count;
 	}
 
 	count->val = count->val - tmp.val;
@@ -1483,20 +1483,21 @@ static int evsel__read_one(struct evsel *evsel, int cpu_map_idx, int thread)
 	return perf_evsel__read(&evsel->core, cpu_map_idx, thread, count);
 }
 
-static void evsel__set_count(struct evsel *counter, int cpu, int thread, u64 val, u64 ena, u64 run)
+static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
+			     u64 val, u64 ena, u64 run)
 {
 	struct perf_counts_values *count;
 
-	count = perf_counts(counter->counts, cpu, thread);
+	count = perf_counts(counter->counts, cpu_map_idx, thread);
 
 	count->val    = val;
 	count->ena    = ena;
 	count->run    = run;
 
-	perf_counts__set_loaded(counter->counts, cpu, thread, true);
+	perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
 }
 
-static int evsel__process_group_data(struct evsel *leader, int cpu, int thread, u64 *data)
+static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int thread, u64 *data)
 {
 	u64 read_format = leader->core.attr.read_format;
 	struct sample_read_value *v;
@@ -1515,7 +1516,7 @@ static int evsel__process_group_data(struct evsel *leader, int cpu, int thread,
 
 	v = (struct sample_read_value *) data;
 
-	evsel__set_count(leader, cpu, thread, v[0].value, ena, run);
+	evsel__set_count(leader, cpu_map_idx, thread, v[0].value, ena, run);
 
 	for (i = 1; i < nr; i++) {
 		struct evsel *counter;
@@ -1524,7 +1525,7 @@ static int evsel__process_group_data(struct evsel *leader, int cpu, int thread,
 		if (!counter)
 			return -EINVAL;
 
-		evsel__set_count(counter, cpu, thread, v[i].value, ena, run);
+		evsel__set_count(counter, cpu_map_idx, thread, v[i].value, ena, run);
 	}
 
 	return 0;
@@ -1643,16 +1644,16 @@ static void evsel__remove_fd(struct evsel *pos, int nr_cpus, int nr_threads, int
 }
 
 static int update_fds(struct evsel *evsel,
-		      int nr_cpus, int cpu_idx,
+		      int nr_cpus, int cpu_map_idx,
 		      int nr_threads, int thread_idx)
 {
 	struct evsel *pos;
 
-	if (cpu_idx >= nr_cpus || thread_idx >= nr_threads)
+	if (cpu_map_idx >= nr_cpus || thread_idx >= nr_threads)
 		return -EINVAL;
 
 	evlist__for_each_entry(evsel->evlist, pos) {
-		nr_cpus = pos != evsel ? nr_cpus : cpu_idx;
+		nr_cpus = pos != evsel ? nr_cpus : cpu_map_idx;
 
 		evsel__remove_fd(pos, nr_cpus, nr_threads, thread_idx);
 
@@ -1667,7 +1668,7 @@ static int update_fds(struct evsel *evsel,
 }
 
 static bool evsel__ignore_missing_thread(struct evsel *evsel,
-					 int nr_cpus, int cpu,
+					 int nr_cpus, int cpu_map_idx,
 					 struct perf_thread_map *threads,
 					 int thread, int err)
 {
@@ -1692,7 +1693,7 @@ static bool evsel__ignore_missing_thread(struct evsel *evsel,
 	 * We should remove fd for missing_thread first
 	 * because thread_map__remove() will decrease threads->nr.
 	 */
-	if (update_fds(evsel, nr_cpus, cpu, threads->nr, thread))
+	if (update_fds(evsel, nr_cpus, cpu_map_idx, threads->nr, thread))
 		return false;
 
 	if (thread_map__remove(threads, thread))
@@ -1974,9 +1975,9 @@ bool evsel__increase_rlimit(enum rlimit_action *set_rlimit)
 
 static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads,
-		int start_cpu, int end_cpu)
+		int start_cpu_map_idx, int end_cpu_map_idx)
 {
-	int cpu, thread, nthreads;
+	int idx, thread, nthreads;
 	int pid = -1, err, old_errno;
 	enum rlimit_action set_rlimit = NO_CHANGE;
 
@@ -2003,7 +2004,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 	display_attr(&evsel->core.attr);
 
-	for (cpu = start_cpu; cpu < end_cpu; cpu++) {
+	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
 
 		for (thread = 0; thread < nthreads; thread++) {
 			int fd, group_fd;
@@ -2014,17 +2015,17 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			if (!evsel->cgrp && !evsel->core.system_wide)
 				pid = perf_thread_map__pid(threads, thread);
 
-			group_fd = get_group_fd(evsel, cpu, thread);
+			group_fd = get_group_fd(evsel, idx, thread);
 
 			test_attr__ready();
 
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
-				pid, cpus->map[cpu], group_fd, evsel->open_flags);
+				pid, cpus->map[idx], group_fd, evsel->open_flags);
 
-			fd = sys_perf_event_open(&evsel->core.attr, pid, cpus->map[cpu],
+			fd = sys_perf_event_open(&evsel->core.attr, pid, cpus->map[idx],
 						group_fd, evsel->open_flags);
 
-			FD(evsel, cpu, thread) = fd;
+			FD(evsel, idx, thread) = fd;
 
 			if (fd < 0) {
 				err = -errno;
@@ -2034,10 +2035,10 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 				goto try_fallback;
 			}
 
-			bpf_counter__install_pe(evsel, cpu, fd);
+			bpf_counter__install_pe(evsel, idx, fd);
 
 			if (unlikely(test_attr__enabled)) {
-				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
+				test_attr__open(&evsel->core.attr, pid, cpus->map[idx],
 						fd, group_fd, evsel->open_flags);
 			}
 
@@ -2078,7 +2079,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (evsel__precise_ip_fallback(evsel))
 		goto retry_open;
 
-	if (evsel__ignore_missing_thread(evsel, cpus->nr, cpu, threads, thread, err)) {
+	if (evsel__ignore_missing_thread(evsel, cpus->nr, idx, threads, thread, err)) {
 		/* We just removed 1 thread, so lower the upper nthreads limit. */
 		nthreads--;
 
@@ -2093,7 +2094,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (err == -EMFILE && evsel__increase_rlimit(&set_rlimit))
 		goto retry_open;
 
-	if (err != -EINVAL || cpu > 0 || thread > 0)
+	if (err != -EINVAL || idx > 0 || thread > 0)
 		goto out_close;
 
 	if (evsel__detect_missing_features(evsel))
@@ -2105,12 +2106,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	old_errno = errno;
 	do {
 		while (--thread >= 0) {
-			if (FD(evsel, cpu, thread) >= 0)
-				close(FD(evsel, cpu, thread));
-			FD(evsel, cpu, thread) = -1;
+			if (FD(evsel, idx, thread) >= 0)
+				close(FD(evsel, idx, thread));
+			FD(evsel, idx, thread) = -1;
 		}
 		thread = nthreads;
-	} while (--cpu >= 0);
+	} while (--idx >= 0);
 	errno = old_errno;
 	return err;
 }
@@ -2127,13 +2128,13 @@ void evsel__close(struct evsel *evsel)
 	perf_evsel__free_id(&evsel->core);
 }
 
-int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu)
+int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu_map_idx)
 {
-	if (cpu == -1)
+	if (cpu_map_idx == -1)
 		return evsel__open_cpu(evsel, cpus, NULL, 0,
 					cpus ? cpus->nr : 1);
 
-	return evsel__open_cpu(evsel, cpus, NULL, cpu, cpu + 1);
+	return evsel__open_cpu(evsel, cpus, NULL, cpu_map_idx, cpu_map_idx + 1);
 }
 
 int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
@@ -2954,15 +2955,15 @@ struct perf_env *evsel__env(struct evsel *evsel)
 
 static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 {
-	int cpu, thread;
+	int cpu_map_idx, thread;
 
-	for (cpu = 0; cpu < xyarray__max_x(evsel->core.fd); cpu++) {
+	for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->core.fd); cpu_map_idx++) {
 		for (thread = 0; thread < xyarray__max_y(evsel->core.fd);
 		     thread++) {
-			int fd = FD(evsel, cpu, thread);
+			int fd = FD(evsel, cpu_map_idx, thread);
 
 			if (perf_evlist__id_add_fd(&evlist->core, &evsel->core,
-						   cpu, thread, fd) < 0)
+						   cpu_map_idx, thread, fd) < 0)
 				return -1;
 		}
 	}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 84e597f6c395..5720ceebffac 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -284,12 +284,12 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr);
 int evsel__set_filter(struct evsel *evsel, const char *filter);
 int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
 int evsel__append_addr_filter(struct evsel *evsel, const char *filter);
-int evsel__enable_cpu(struct evsel *evsel, int cpu);
+int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx);
 int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
-int evsel__disable_cpu(struct evsel *evsel, int cpu);
+int evsel__disable_cpu(struct evsel *evsel, int cpu_map_idx);
 
-int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu);
+int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu_map_idx);
 int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads);
 int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 995cb5003133..f7f9757eba23 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -531,7 +531,7 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp)
 int create_perf_stat_counter(struct evsel *evsel,
 			     struct perf_stat_config *config,
 			     struct target *target,
-			     int cpu)
+			     int cpu_map_idx)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel *leader = evsel__leader(evsel);
@@ -585,7 +585,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	}
 
 	if (target__has_cpu(target) && !target__has_per_thread(target))
-		return evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu);
+		return evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu_map_idx);
 
 	return evsel__open_per_thread(evsel, evsel->core.threads);
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 32cf24186229..5e25d53e891b 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -248,7 +248,7 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp);
 int create_perf_stat_counter(struct evsel *evsel,
 			     struct perf_stat_config *config,
 			     struct target *target,
-			     int cpu);
+			     int cpu_map_idx);
 void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
 			    struct target *_target, struct timespec *ts, int argc, const char **argv);
 
-- 
2.34.1.448.ga2b2bfdf31-goog

