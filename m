Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FD547DFD2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347180AbhLWHsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347076AbhLWHrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:22 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35243C061395
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:12 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p3-20020a170903248300b00143c00a5411so1038241plw.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KJHGDGEK7ssktfoLh0ZMvZi7f3goEvX8mnP7RB/juA8=;
        b=kwuscwT4Z11JCrxnzVtReakR7Qi6T/KJ++xKFKpUchUSmuvR3At8fY9vhOXU1TMJ5+
         A9Q9RRouOfStzn53XpqbaMbdIZLV1jE50LJYOQUQKvi18c1tiOQnICd6r++mkX3lIIi+
         RbpgrMnM4Amd//9TrWPlE/Mx5HYSGOKGtrqtUaqxNq45a9V3/ta9t5UWCevrY4BJ1xF2
         xlb6diMCZl/VeBHTKDnFRvaj7BI/VvOpx/CDtC3jAKphxJByDfAcO6iGB87jnDxK8xkf
         ceivX2wTFC+g3Cn1DIqiuiwOXKK1ti4Y6wYfxSGi9nJR1XJk3J9tFJ4ef3GebzAi8DH8
         TiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KJHGDGEK7ssktfoLh0ZMvZi7f3goEvX8mnP7RB/juA8=;
        b=MYB1QI+2WJQjn33mr8SMLS+IHGIqZAH66llX4aVrIoMu+2/QxT0/gdQY0JjMLJ5EvY
         f4MighuPLFglDltQnKzrYbWwLJyRx7e9Z1De/eeGj77+oB9xzvSquuAEGU4qQI6Duvrk
         9sAgsTKo4gGGjMybz5YaPDcEjO0+qhGyASaDQS9Q/vW631Y9ZdApdIxVEjygP6J+tu2H
         3l61cBh7AQovztYMCPxbDTzC1LgOyMSSzkaBe3LCi6h9oKzDjg7kZlqtkxq+zOcq5ojr
         ldbnLZOkd4j82oI5nzL3AtQ/FPdAWpcq8oDRcdZyZe2BHLo30lxVou8onIiFrUNQY5h7
         c+8Q==
X-Gm-Message-State: AOAM530NMl1Bon+VolZw3bN70PifaqYl8CojoX65VpEr3A7LYyl4Uxb/
        jKyI+b4MzUw/NvxqaQtoFKMVALLm3VL7
X-Google-Smtp-Source: ABdhPJyr4euc+sNZ4F0aifxo1nK40USp0OShKIjYuQaa0EnymHFQoqO8VSGW7LZeuS8F/RVn/weqXy1ga+oy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a17:90b:50e:: with SMTP id
 r14mr1458321pjz.175.1640245631645; Wed, 22 Dec 2021 23:47:11 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:18 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-26-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 25/48] perf stat-display: Avoid use of core for CPU.
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

Correct use of cpumap index in print_no_aggr_metric.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 870b1db71fbc..821511ba22cc 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -120,11 +120,10 @@ static void aggr_printout(struct perf_stat_config *config,
 				id.die,
 				config->csv_output ? 0 : -3,
 				id.core, config->csv_sep);
-		} else if (id.core > -1) {
+		} else if (id.cpu > -1) {
 			fprintf(config->output, "CPU%*d%s",
 				config->csv_output ? 0 : -7,
-				evsel__cpus(evsel)->map[id.core],
-				config->csv_sep);
+				id.cpu, config->csv_sep);
 		}
 		break;
 	case AGGR_THREAD:
@@ -334,7 +333,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	int cpu, idx;
 
 	if (config->aggr_mode == AGGR_NONE)
-		return id->core;
+		return id->cpu;
 
 	if (!config->aggr_get_id)
 		return 0;
@@ -697,10 +696,9 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 		fprintf(output, "%s", prefix);
 
 	uval = val * counter->scale;
-	if (cpu != -1) {
-		id = aggr_cpu_id__empty();
-		id.core = cpu;
-	}
+	if (cpu != -1)
+		id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
+
 	printout(config, id, nr, counter, uval,
 		 prefix, run, ena, 1.0, &rt_stat);
 	if (!metric_only)
@@ -911,8 +909,7 @@ static void print_counter(struct perf_stat_config *config,
 			fprintf(output, "%s", prefix);
 
 		uval = val * counter->scale;
-		id = aggr_cpu_id__empty();
-		id.core = cpu;
+		id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 		printout(config, id, 0, counter, uval, prefix,
 			 run, ena, 1.0, &rt_stat);
 
@@ -924,29 +921,32 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 				 struct evlist *evlist,
 				 char *prefix)
 {
-	int cpu;
-	int nrcpus = 0;
-	struct evsel *counter;
-	u64 ena, run, val;
-	double uval;
-	struct aggr_cpu_id id;
+	int cpu, nrcpus;
 
 	nrcpus = evlist->core.cpus->nr;
 	for (cpu = 0; cpu < nrcpus; cpu++) {
+		struct evsel *counter;
 		bool first = true;
 
 		if (prefix)
 			fputs(prefix, config->output);
 		evlist__for_each_entry(evlist, counter) {
-			id = aggr_cpu_id__empty();
-			id.core = cpu;
+			u64 ena, run, val;
+			double uval;
+			struct aggr_cpu_id id;
+			int idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
+
+			if (idx < 0)
+				continue;
+
+			id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 			if (first) {
 				aggr_printout(config, counter, id, 0);
 				first = false;
 			}
-			val = perf_counts(counter->counts, cpu, 0)->val;
-			ena = perf_counts(counter->counts, cpu, 0)->ena;
-			run = perf_counts(counter->counts, cpu, 0)->run;
+			val = perf_counts(counter->counts, idx, 0)->val;
+			ena = perf_counts(counter->counts, idx, 0)->ena;
+			run = perf_counts(counter->counts, idx, 0)->run;
 
 			uval = val * counter->scale;
 			printout(config, id, 0, counter, uval, prefix,
-- 
2.34.1.307.g9b7440fafd-goog

