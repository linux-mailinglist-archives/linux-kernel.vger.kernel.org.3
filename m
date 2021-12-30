Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30035481A40
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbhL3HWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbhL3HVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49942C0613B4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:41 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i65-20020a252244000000b0060b2e5fd54cso27648266ybi.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MyX41obsfTbklj5mP7URo6KOdoHhcEiYJDRkMl7AGdI=;
        b=LObQmT9LTPmbnq9p8gFeTKDRdvi+Xxhm9mKW2yrrqr1LRU3ZF6WGa7V0yeYNIS4Zry
         NUTNYXdHzrCU3oIbpmoNuJHFNr8Ng0dX7xOg93LGT7MCK6h/96Cb/j9IY+PIU9aRHKqG
         Vd4GwDaAeVv5FiPnEQdwhSoi6xjxrVFv8uMNcl8/J7FTXqfpE5FmcRHU8FN5OHHDM+4P
         G7UD8KHB8IRx7wC/Yfq+TYH84JU57Qn7AuwtwCkL0ZGonCLpbr3xAHaLNus6twfEffHk
         7tADUxWwhCVTT2OFimaZSXicJDYt8hRNHsXofd8Bv5vB7CCTcsobzpPmZ5N4uwLbrsZF
         sP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MyX41obsfTbklj5mP7URo6KOdoHhcEiYJDRkMl7AGdI=;
        b=F6mBUBYcaGo7YGh7VSRA511lSicnpJSzxdbN5BhuwvvJBVqCuuNtmR0HLz7YvTy80M
         KfC6oSJ6l9a9xlEcV99YBTPcOFoiJyS2lRXIqAOSD/dAkOpxXcHI/IMY1MQ4nwrH8nmo
         0FWzSRC26/ZCw4RQoB+bv/lbrzrikdM5av+wmK2Lf3MurHV2jIFAYN6SV7uL75T9mX0j
         +0OhUO8+d4/Iiy64nlQ1ShMxccxU73SRBnpZkE0934qu0wx4mjd8ykdqSIooRu/ZvFui
         5y1ugv4iFHh9w9nF9dOiDgZ7m0RwLbgpwMfZE/iryhKjeaZARsrLJ8GLpetMuFc/gvzX
         EYow==
X-Gm-Message-State: AOAM531X5TZ+PruFgHqh5EyIWwLWvGiHBRvKmtxM97S18N9xULFp9Z/i
        ee3uV1JJV7+HNwf5igvLtsnFQ3Z2Z+QP
X-Google-Smtp-Source: ABdhPJxRg4qJJebeV7CpE9vROn1liGtbz9yh2zMu7YKeoig64yqoc+FZQDgbYrhwZMJdAyp1bR9sXlKR/2Ee
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:7dc2:: with SMTP id
 y185mr35577232ybc.352.1640848900528; Wed, 29 Dec 2021 23:21:40 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:07 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-27-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 25/48] perf stat-display: Avoid use of core for CPU.
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

Correct use of cpumap index in print_no_aggr_metric.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 45 +++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 870b1db71fbc..f48d1678861c 100644
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
 
@@ -924,29 +921,31 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 				 struct evlist *evlist,
 				 char *prefix)
 {
-	int cpu;
-	int nrcpus = 0;
-	struct evsel *counter;
-	u64 ena, run, val;
-	double uval;
-	struct aggr_cpu_id id;
+	int all_idx, cpu;
 
-	nrcpus = evlist->core.cpus->nr;
-	for (cpu = 0; cpu < nrcpus; cpu++) {
+	perf_cpu_map__for_each_cpu(cpu, all_idx, evlist->core.cpus) {
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
+			int counter_idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
+
+			if (counter_idx < 0)
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
+			val = perf_counts(counter->counts, counter_idx, 0)->val;
+			ena = perf_counts(counter->counts, counter_idx, 0)->ena;
+			run = perf_counts(counter->counts, counter_idx, 0)->run;
 
 			uval = val * counter->scale;
 			printout(config, id, 0, counter, uval, prefix,
-- 
2.34.1.448.ga2b2bfdf31-goog

