Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3DA481A44
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbhL3HWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbhL3HWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:04 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D17C061746
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:04 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s84-20020a254557000000b0060ac37f4bb1so29561811yba.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UCK9l+BEdrLTJQZ+dx/4MkTNovKCui/i9rUWPLtd3/I=;
        b=hyPeUhSX+mOQf1Pa92viBpsjCorgfh51S4CF3pHPFejByXsxu1POCQKmci9yxECaLf
         rzfYRQ6d9TGGfWKY2zYtdp7yRsG/1fu7aSuf/NxBcFuHwx/c1f1COfT0YAxcXL7HbHxa
         GcBk9xEOOqtXKCIwsNE9JFtPy35s8pnt6E69FDSLr/KUxzQ+WzK7w2DtBDF1z895tM5M
         9YOWYY6KaoOCZoh/lv2/dSVaK0xFLYMJlg3NasLFl+rf3/LZmVkPD572aJ1E2NlvTpF/
         iihhDK6BUGrx4UIHob3c56JG/9UjtNQxJ6JM3GidTtqE7Llf3VqVBKeK2ebiu9hVDIfc
         gvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UCK9l+BEdrLTJQZ+dx/4MkTNovKCui/i9rUWPLtd3/I=;
        b=XQnbQk3EHu8XGS77EBCs0kHrSSW7cZ4BvvyPOSmnyxOou6ry1nUCDudllC2RwRQiVR
         YsbJRXhEsqgV2Qy7xhDRW+5Xt11xqRMYhO6C40i+8a+uM3UAnfGsqahdHowk27qpjY8W
         rYPTjmw3exs4Pbb4hj3LOxdzdl/JyRC15R47hwV4vHLNCB1rKoLmH7HnfDYlHrsqgovQ
         1ThSXxz3adoGdXgrNEZIMownl5SHvHM27kYyEw8fd6PA3+4IlHx+BKB3sBQKIQA2ni/Y
         MOXQLG18X2HT7R1b409PrClzCovCC7qHDnJX139FNC+HyYOc5ISYFiNYMVud3xV9C36q
         BrOg==
X-Gm-Message-State: AOAM531DuzqsvUT5IMVLxh0/bQvLfOmcuHJkhrm6xJgHD5+hmwzjD1av
        LipSwA5o6pjZwltPWgM7kUS6vISqUSZ7
X-Google-Smtp-Source: ABdhPJxQrarTUR0IdpNIzrDZkRW/JcESVEeiAJsdgukr29vFWv20oMaxq1jVI+53gpI8UMI8CDqQMjCrulzC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:b907:: with SMTP id
 x7mr38358550ybj.566.1640848923425; Wed, 29 Dec 2021 23:22:03 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:16 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-36-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 34/48] perf evlist: Refactor evlist__for_each_cpu.
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

Previously evlist__for_each_cpu needed to iterate over the evlist in an
inner loop and call "skip" routines. Refactor this so that the iteratr
is smarter and the next function can update both the current CPU and
evsel.

By using a cpu map index, fix apparent off-by-1 in __run_perf_stat's
call to perf_evsel__close_cpu.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 179 ++++++++++++++++++--------------------
 tools/perf/util/evlist.c  | 146 +++++++++++++++++--------------
 tools/perf/util/evlist.h  |  50 +++++++++--
 tools/perf/util/evsel.h   |   1 -
 4 files changed, 210 insertions(+), 166 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 98f80c217279..f31bc34bd4cc 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -405,36 +405,33 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu)
 
 static int read_affinity_counters(struct timespec *rs)
 {
-	struct evsel *counter;
-	struct affinity affinity;
-	int i, ncpus, cpu;
+	struct evlist_cpu_iterator evlist_cpu_itr;
+	struct affinity saved_affinity, *affinity;
 
 	if (all_counters_use_bpf)
 		return 0;
 
-	if (affinity__setup(&affinity) < 0)
+	if (!target__has_cpu(&target) || target__has_per_thread(&target))
+		affinity = NULL;
+	else if (affinity__setup(&saved_affinity) < 0)
 		return -1;
+	else
+		affinity = &saved_affinity;
 
-	ncpus = perf_cpu_map__nr(evsel_list->core.all_cpus);
-	if (!target__has_cpu(&target) || target__has_per_thread(&target))
-		ncpus = 1;
-	evlist__for_each_cpu(evsel_list, i, cpu) {
-		if (i >= ncpus)
-			break;
-		affinity__set(&affinity, cpu);
+	evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
+		struct evsel *counter = evlist_cpu_itr.evsel;
 
-		evlist__for_each_entry(evsel_list, counter) {
-			if (evsel__cpu_iter_skip(counter, cpu))
-				continue;
-			if (evsel__is_bpf(counter))
-				continue;
-			if (!counter->err) {
-				counter->err = read_counter_cpu(counter, rs,
-								counter->cpu_iter - 1);
-			}
+		if (evsel__is_bpf(counter))
+			continue;
+
+		if (!counter->err) {
+			counter->err = read_counter_cpu(counter, rs,
+							evlist_cpu_itr.cpu_map_idx);
 		}
 	}
-	affinity__cleanup(&affinity);
+	if (affinity)
+		affinity__cleanup(&saved_affinity);
+
 	return 0;
 }
 
@@ -788,8 +785,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int status = 0;
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
+	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity affinity;
-	int i, cpu, err;
+	int err;
 	bool second_pass = false;
 
 	if (forks) {
@@ -813,102 +811,97 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			all_counters_use_bpf = false;
 	}
 
-	evlist__for_each_cpu (evsel_list, i, cpu) {
+	evlist__for_each_cpu(evlist_cpu_itr, evsel_list, &affinity) {
+		counter = evlist_cpu_itr.evsel;
+
 		/*
 		 * bperf calls evsel__open_per_cpu() in bperf__load(), so
 		 * no need to call it again here.
 		 */
 		if (target.use_bpf)
 			break;
-		affinity__set(&affinity, cpu);
 
-		evlist__for_each_entry(evsel_list, counter) {
-			if (evsel__cpu_iter_skip(counter, cpu))
+		if (counter->reset_group || counter->errored)
+			continue;
+		if (evsel__is_bpf(counter))
+			continue;
+try_again:
+		if (create_perf_stat_counter(counter, &stat_config, &target,
+					     evlist_cpu_itr.cpu_map_idx) < 0) {
+
+			/*
+			 * Weak group failed. We cannot just undo this here
+			 * because earlier CPUs might be in group mode, and the kernel
+			 * doesn't support mixing group and non group reads. Defer
+			 * it to later.
+			 * Don't close here because we're in the wrong affinity.
+			 */
+			if ((errno == EINVAL || errno == EBADF) &&
+				evsel__leader(counter) != counter &&
+				counter->weak_group) {
+				evlist__reset_weak_group(evsel_list, counter, false);
+				assert(counter->reset_group);
+				second_pass = true;
 				continue;
-			if (counter->reset_group || counter->errored)
+			}
+
+			switch (stat_handle_error(counter)) {
+			case COUNTER_FATAL:
+				return -1;
+			case COUNTER_RETRY:
+				goto try_again;
+			case COUNTER_SKIP:
 				continue;
-			if (evsel__is_bpf(counter))
+			default:
+				break;
+			}
+
+		}
+		counter->supported = true;
+	}
+
+	if (second_pass) {
+		/*
+		 * Now redo all the weak group after closing them,
+		 * and also close errored counters.
+		 */
+
+		/* First close errored or weak retry */
+		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, &affinity) {
+			counter = evlist_cpu_itr.evsel;
+
+			if (!counter->reset_group && !counter->errored)
 				continue;
-try_again:
+
+			perf_evsel__close_cpu(&counter->core, evlist_cpu_itr.cpu_map_idx);
+		}
+		/* Now reopen weak */
+		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, &affinity) {
+			counter = evlist_cpu_itr.evsel;
+
+			if (!counter->reset_group && !counter->errored)
+				continue;
+			if (!counter->reset_group)
+				continue;
+try_again_reset:
+			pr_debug2("reopening weak %s\n", evsel__name(counter));
 			if (create_perf_stat_counter(counter, &stat_config, &target,
-						     counter->cpu_iter - 1) < 0) {
-
-				/*
-				 * Weak group failed. We cannot just undo this here
-				 * because earlier CPUs might be in group mode, and the kernel
-				 * doesn't support mixing group and non group reads. Defer
-				 * it to later.
-				 * Don't close here because we're in the wrong affinity.
-				 */
-				if ((errno == EINVAL || errno == EBADF) &&
-				    evsel__leader(counter) != counter &&
-				    counter->weak_group) {
-					evlist__reset_weak_group(evsel_list, counter, false);
-					assert(counter->reset_group);
-					second_pass = true;
-					continue;
-				}
+						     evlist_cpu_itr.cpu_map_idx) < 0) {
 
 				switch (stat_handle_error(counter)) {
 				case COUNTER_FATAL:
 					return -1;
 				case COUNTER_RETRY:
-					goto try_again;
+					goto try_again_reset;
 				case COUNTER_SKIP:
 					continue;
 				default:
 					break;
 				}
-
 			}
 			counter->supported = true;
 		}
 	}
-
-	if (second_pass) {
-		/*
-		 * Now redo all the weak group after closing them,
-		 * and also close errored counters.
-		 */
-
-		evlist__for_each_cpu(evsel_list, i, cpu) {
-			affinity__set(&affinity, cpu);
-			/* First close errored or weak retry */
-			evlist__for_each_entry(evsel_list, counter) {
-				if (!counter->reset_group && !counter->errored)
-					continue;
-				if (evsel__cpu_iter_skip_no_inc(counter, cpu))
-					continue;
-				perf_evsel__close_cpu(&counter->core, counter->cpu_iter);
-			}
-			/* Now reopen weak */
-			evlist__for_each_entry(evsel_list, counter) {
-				if (!counter->reset_group && !counter->errored)
-					continue;
-				if (evsel__cpu_iter_skip(counter, cpu))
-					continue;
-				if (!counter->reset_group)
-					continue;
-try_again_reset:
-				pr_debug2("reopening weak %s\n", evsel__name(counter));
-				if (create_perf_stat_counter(counter, &stat_config, &target,
-							     counter->cpu_iter - 1) < 0) {
-
-					switch (stat_handle_error(counter)) {
-					case COUNTER_FATAL:
-						return -1;
-					case COUNTER_RETRY:
-						goto try_again_reset;
-					case COUNTER_SKIP:
-						continue;
-					default:
-						break;
-					}
-				}
-				counter->supported = true;
-			}
-		}
-	}
 	affinity__cleanup(&affinity);
 
 	evlist__for_each_entry(evsel_list, counter) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5f92319ce258..39d294f6c321 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -342,36 +342,65 @@ static int evlist__nr_threads(struct evlist *evlist, struct evsel *evsel)
 		return perf_thread_map__nr(evlist->core.threads);
 }
 
-void evlist__cpu_iter_start(struct evlist *evlist)
-{
-	struct evsel *pos;
-
-	/*
-	 * Reset the per evsel cpu_iter. This is needed because
-	 * each evsel's cpumap may have a different index space,
-	 * and some operations need the index to modify
-	 * the FD xyarray (e.g. open, close)
-	 */
-	evlist__for_each_entry(evlist, pos)
-		pos->cpu_iter = 0;
-}
+struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affinity *affinity)
+{
+	struct evlist_cpu_iterator itr = {
+		.container = evlist,
+		.evsel = evlist__first(evlist),
+		.cpu_map_idx = 0,
+		.evlist_cpu_map_idx = 0,
+		.evlist_cpu_map_nr = perf_cpu_map__nr(evlist->core.all_cpus),
+		.cpu = -1,
+		.affinity = affinity,
+	};
 
-bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu)
-{
-	if (ev->cpu_iter >= ev->core.cpus->nr)
-		return true;
-	if (cpu >= 0 && ev->core.cpus->map[ev->cpu_iter] != cpu)
-		return true;
-	return false;
+	if (itr.affinity) {
+		itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
+		affinity__set(itr.affinity, itr.cpu);
+		itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
+		/*
+		 * If this CPU isn't in the evsel's cpu map then advance through
+		 * the list.
+		 */
+		if (itr.cpu_map_idx == -1)
+			evlist_cpu_iterator__next(&itr);
+	}
+	return itr;
+}
+
+void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr)
+{
+	while (evlist_cpu_itr->evsel != evlist__last(evlist_cpu_itr->container)) {
+		evlist_cpu_itr->evsel = evsel__next(evlist_cpu_itr->evsel);
+		evlist_cpu_itr->cpu_map_idx =
+			perf_cpu_map__idx(evlist_cpu_itr->evsel->core.cpus,
+					  evlist_cpu_itr->cpu);
+		if (evlist_cpu_itr->cpu_map_idx != -1)
+			return;
+	}
+	evlist_cpu_itr->evlist_cpu_map_idx++;
+	if (evlist_cpu_itr->evlist_cpu_map_idx < evlist_cpu_itr->evlist_cpu_map_nr) {
+		evlist_cpu_itr->evsel = evlist__first(evlist_cpu_itr->container);
+		evlist_cpu_itr->cpu =
+			perf_cpu_map__cpu(evlist_cpu_itr->container->core.all_cpus,
+					  evlist_cpu_itr->evlist_cpu_map_idx);
+		if (evlist_cpu_itr->affinity)
+			affinity__set(evlist_cpu_itr->affinity, evlist_cpu_itr->cpu);
+		evlist_cpu_itr->cpu_map_idx =
+			perf_cpu_map__idx(evlist_cpu_itr->evsel->core.cpus,
+					  evlist_cpu_itr->cpu);
+		/*
+		 * If this CPU isn't in the evsel's cpu map then advance through
+		 * the list.
+		 */
+		if (evlist_cpu_itr->cpu_map_idx == -1)
+			evlist_cpu_iterator__next(evlist_cpu_itr);
+	}
 }
 
-bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
+bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr)
 {
-	if (!evsel__cpu_iter_skip_no_inc(ev, cpu)) {
-		ev->cpu_iter++;
-		return false;
-	}
-	return true;
+	return evlist_cpu_itr->evlist_cpu_map_idx >= evlist_cpu_itr->evlist_cpu_map_nr;
 }
 
 static int evsel__strcmp(struct evsel *pos, char *evsel_name)
@@ -400,31 +429,26 @@ static int evlist__is_enabled(struct evlist *evlist)
 static void __evlist__disable(struct evlist *evlist, char *evsel_name)
 {
 	struct evsel *pos;
+	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity affinity;
-	int cpu, i, imm = 0;
 	bool has_imm = false;
 
 	if (affinity__setup(&affinity) < 0)
 		return;
 
 	/* Disable 'immediate' events last */
-	for (imm = 0; imm <= 1; imm++) {
-		evlist__for_each_cpu(evlist, i, cpu) {
-			affinity__set(&affinity, cpu);
-
-			evlist__for_each_entry(evlist, pos) {
-				if (evsel__strcmp(pos, evsel_name))
-					continue;
-				if (evsel__cpu_iter_skip(pos, cpu))
-					continue;
-				if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
-					continue;
-				if (pos->immediate)
-					has_imm = true;
-				if (pos->immediate != imm)
-					continue;
-				evsel__disable_cpu(pos, pos->cpu_iter - 1);
-			}
+	for (int imm = 0; imm <= 1; imm++) {
+		evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+			pos = evlist_cpu_itr.evsel;
+			if (evsel__strcmp(pos, evsel_name))
+				continue;
+			if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
+				continue;
+			if (pos->immediate)
+				has_imm = true;
+			if (pos->immediate != imm)
+				continue;
+			evsel__disable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
 		}
 		if (!has_imm)
 			break;
@@ -462,24 +486,19 @@ void evlist__disable_evsel(struct evlist *evlist, char *evsel_name)
 static void __evlist__enable(struct evlist *evlist, char *evsel_name)
 {
 	struct evsel *pos;
+	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity affinity;
-	int cpu, i;
 
 	if (affinity__setup(&affinity) < 0)
 		return;
 
-	evlist__for_each_cpu(evlist, i, cpu) {
-		affinity__set(&affinity, cpu);
-
-		evlist__for_each_entry(evlist, pos) {
-			if (evsel__strcmp(pos, evsel_name))
-				continue;
-			if (evsel__cpu_iter_skip(pos, cpu))
-				continue;
-			if (!evsel__is_group_leader(pos) || !pos->core.fd)
-				continue;
-			evsel__enable_cpu(pos, pos->cpu_iter - 1);
-		}
+	evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+		pos = evlist_cpu_itr.evsel;
+		if (evsel__strcmp(pos, evsel_name))
+			continue;
+		if (!evsel__is_group_leader(pos) || !pos->core.fd)
+			continue;
+		evsel__enable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
 	}
 	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
@@ -1264,8 +1283,8 @@ void evlist__set_selected(struct evlist *evlist, struct evsel *evsel)
 void evlist__close(struct evlist *evlist)
 {
 	struct evsel *evsel;
+	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity affinity;
-	int cpu, i;
 
 	/*
 	 * With perf record core.cpus is usually NULL.
@@ -1279,15 +1298,12 @@ void evlist__close(struct evlist *evlist)
 
 	if (affinity__setup(&affinity) < 0)
 		return;
-	evlist__for_each_cpu(evlist, i, cpu) {
-		affinity__set(&affinity, cpu);
 
-		evlist__for_each_entry_reverse(evlist, evsel) {
-			if (evsel__cpu_iter_skip(evsel, cpu))
-			    continue;
-			perf_evsel__close_cpu(&evsel->core, evsel->cpu_iter - 1);
-		}
+	evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+		perf_evsel__close_cpu(&evlist_cpu_itr.evsel->core,
+				      evlist_cpu_itr.cpu_map_idx);
 	}
+
 	affinity__cleanup(&affinity);
 	evlist__for_each_entry_reverse(evlist, evsel) {
 		perf_evsel__free_fd(&evsel->core);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 27594900a052..57828ebfcb61 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -327,17 +327,53 @@ void evlist__to_front(struct evlist *evlist, struct evsel *move_evsel);
 #define evlist__for_each_entry_safe(evlist, tmp, evsel) \
 	__evlist__for_each_entry_safe(&(evlist)->core.entries, tmp, evsel)
 
-#define evlist__for_each_cpu(evlist, index, cpu)	\
-	evlist__cpu_iter_start(evlist);			\
-	perf_cpu_map__for_each_cpu (cpu, index, (evlist)->core.all_cpus)
+/** Iterator state for evlist__for_each_cpu */
+struct evlist_cpu_iterator {
+	/** The list being iterated through. */
+	struct evlist *container;
+	/** The current evsel of the iterator. */
+	struct evsel *evsel;
+	/** The CPU map index corresponding to the evsel->core.cpus for the current CPU. */
+	int cpu_map_idx;
+	/**
+	 * The CPU map index corresponding to evlist->core.all_cpus for the
+	 * current CPU.  Distinct from cpu_map_idx as the evsel's cpu map may
+	 * contain fewer entries.
+	 */
+	int evlist_cpu_map_idx;
+	/** The number of CPU map entries in evlist->core.all_cpus. */
+	int evlist_cpu_map_nr;
+	/** The current CPU of the iterator. */
+	int cpu;
+	/** If present, used to set the affinity when switching between CPUs. */
+	struct affinity *affinity;
+};
+
+/**
+ * evlist__for_each_cpu - without affinity, iterate over the evlist. With
+ *                        affinity, iterate over all CPUs and then the evlist
+ *                        for each evsel on that CPU. When switching between
+ *                        CPUs the affinity is set to the CPU to avoid IPIs
+ *                        during syscalls.
+ * @evlist_cpu_itr: the iterator instance.
+ * @evlist: evlist instance to iterate.
+ * @affinity: NULL or used to set the affinity to the current CPU.
+ */
+#define evlist__for_each_cpu(evlist_cpu_itr, evlist, affinity)		\
+	for ((evlist_cpu_itr) = evlist__cpu_begin(evlist, affinity);	\
+	     !evlist_cpu_iterator__end(&evlist_cpu_itr);		\
+	     evlist_cpu_iterator__next(&evlist_cpu_itr))
+
+/** Returns an iterator set to the first CPU/evsel of evlist. */
+struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affinity *affinity);
+/** Move to next element in iterator, updating CPU, evsel and the affinity. */
+void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr);
+/** Returns true when iterator is at the end of the CPUs and evlist. */
+bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr);
 
 struct evsel *evlist__get_tracking_event(struct evlist *evlist);
 void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_evsel);
 
-void evlist__cpu_iter_start(struct evlist *evlist);
-bool evsel__cpu_iter_skip(struct evsel *ev, int cpu);
-bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu);
-
 struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
 
 struct evsel *evlist__event2evsel(struct evlist *evlist, union perf_event *event);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 99aa3363def7..7cb7c9c77ab0 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -121,7 +121,6 @@ struct evsel {
 	bool			errored;
 	struct hashmap		*per_pkg_mask;
 	int			err;
-	int			cpu_iter;
 	struct {
 		evsel__sb_cb_t	*cb;
 		void		*data;
-- 
2.34.1.448.ga2b2bfdf31-goog

