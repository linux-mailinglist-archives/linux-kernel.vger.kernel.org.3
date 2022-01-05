Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0D9484E13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbiAEGON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiAEGOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:08 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F39DC061799
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:14:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z188-20020a2565c5000000b0060be1f32877so53253968ybb.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g2nak5zfew4oiMxb3Bq8hR7F6MQXwULWW7e4c//RBpw=;
        b=Krf16YWaYcSanaA/PROYkDPiiFG8tGrhmHl/KNsG0RTcZerYqX3VMsPTX6QCCPzMFF
         gLotbNJG0vrtV8LaIPhbwA9oDqsnsYRVP/3CQuCmgoGqlKHjZRrKkM5ndl/sFjk/81TX
         Xykcp7uRPn4La+dgK74ciBm72L3fqM2OFRciTgPmJk3L/y7YpeJhl/cO3QkrJXSKOUkf
         WH/RSztimm3SHcFha6B1qsCCdJUNG2U7WHcp9I44zmLb1uJPT/ENI143rVuhliz4C76Q
         1DIDlMyrZkT9laS+sN6JrPh3xlez9HW2DVAcwZdB80HWG8tEcgOuvSfxuUGxzlMlNadu
         ZY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g2nak5zfew4oiMxb3Bq8hR7F6MQXwULWW7e4c//RBpw=;
        b=bgM3pOK0TBlwZRGf9AVnBIzwO/JHgjj/nXK6gr4iUcXAJuEaGYqxFxMpKf7pZbKESe
         erWa6/5miB+Psunk/mw5mKwrtAt5U21SVOhiprJm5vWy7iFR0s7kcGYVpA3mFHdKnOD5
         7LTqcux3lm4gf+14Gor5XeT3ziJEIp6YhwBbueAg5Z4fCuNgSgpN5zbZPJO+NT6AgESf
         xZaRbzkZT1xviaH6W7e7BjRv9/OYaruDQ4yBrE1A4pPiFvywA3pjn/pV865XzIZmiflP
         D+G4pRArBn/3xPwvHPd/Qm7zPrIzwEY7qjsr5y7vDWlfqdSZvQWaUMfkqkVkeIuKrWSx
         VK9g==
X-Gm-Message-State: AOAM5323PBpQQ6YuKVgr89iZygvzt2Pg6XvN3DiCNG85AIGnhp0Jl6ri
        GG4gSYOePDY9vKF6Ehk5jpmRMcfsUaJU
X-Google-Smtp-Source: ABdhPJxXqfiOTUNSgZ6Q5VfpTLFpcpFm0PqmPCGSFPgY5JWjQFXYGglf0yT+07lm5WN8+PJn7FsrSABqeZne
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:734f:: with SMTP id
 o76mr54271949ybc.412.1641363247314; Tue, 04 Jan 2022 22:14:07 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:07 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-5-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 04/48] perf stat: Switch aggregation to use for_each loop
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

Tidy up the use of cpu and index to hopefully make the code less error
prone. Avoid unused warnings with (void) which will be removed in a
later patch.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 48 +++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index b0fa81ffce61..efab39a759ff 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -330,8 +330,8 @@ static void print_metric_header(struct perf_stat_config *config,
 static int first_shadow_cpu(struct perf_stat_config *config,
 			    struct evsel *evsel, struct aggr_cpu_id id)
 {
-	struct evlist *evlist = evsel->evlist;
-	int i;
+	struct perf_cpu_map *cpus;
+	int cpu, idx;
 
 	if (config->aggr_mode == AGGR_NONE)
 		return id.core;
@@ -339,14 +339,11 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	if (!config->aggr_get_id)
 		return 0;
 
-	for (i = 0; i < evsel__nr_cpus(evsel); i++) {
-		int cpu2 = evsel__cpus(evsel)->map[i];
-
-		if (cpu_map__compare_aggr_cpu_id(
-					config->aggr_get_id(config, evlist->core.cpus, cpu2),
-					id)) {
-			return cpu2;
-		}
+	cpus = evsel__cpus(evsel);
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		if (cpu_map__compare_aggr_cpu_id(config->aggr_get_id(config, cpus, idx),
+						 id))
+			return cpu;
 	}
 	return 0;
 }
@@ -516,20 +513,23 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 static void aggr_update_shadow(struct perf_stat_config *config,
 			       struct evlist *evlist)
 {
-	int cpu, s;
+	int cpu, idx, s;
 	struct aggr_cpu_id s2, id;
 	u64 val;
 	struct evsel *counter;
+	struct perf_cpu_map *cpus;
 
 	for (s = 0; s < config->aggr_map->nr; s++) {
 		id = config->aggr_map->map[s];
 		evlist__for_each_entry(evlist, counter) {
+			cpus = evsel__cpus(counter);
 			val = 0;
-			for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
-				s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
+			perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+				(void)cpu;
+				s2 = config->aggr_get_id(config, cpus, idx);
 				if (!cpu_map__compare_aggr_cpu_id(s2, id))
 					continue;
-				val += perf_counts(counter->counts, cpu, 0)->val;
+				val += perf_counts(counter->counts, idx, 0)->val;
 			}
 			perf_stat__update_shadow_stats(counter, val,
 					first_shadow_cpu(config, counter, id),
@@ -634,18 +634,21 @@ static void aggr_cb(struct perf_stat_config *config,
 		    struct evsel *counter, void *data, bool first)
 {
 	struct aggr_data *ad = data;
-	int cpu;
+	int idx, cpu;
+	struct perf_cpu_map *cpus;
 	struct aggr_cpu_id s2;
 
-	for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
+	cpus = evsel__cpus(counter);
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 		struct perf_counts_values *counts;
 
-		s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
+		(void)cpu;
+		s2 = config->aggr_get_id(config, cpus, idx);
 		if (!cpu_map__compare_aggr_cpu_id(s2, ad->id))
 			continue;
 		if (first)
 			ad->nr++;
-		counts = perf_counts(counter->counts, cpu, 0);
+		counts = perf_counts(counter->counts, idx, 0);
 		/*
 		 * When any result is bad, make them all to give
 		 * consistent output in interval mode.
@@ -1208,10 +1211,13 @@ static void print_percore_thread(struct perf_stat_config *config,
 {
 	int s;
 	struct aggr_cpu_id s2, id;
+	struct perf_cpu_map *cpus;
 	bool first = true;
+	int idx, cpu;
 
-	for (int i = 0; i < evsel__nr_cpus(counter); i++) {
-		s2 = config->aggr_get_id(config, evsel__cpus(counter), i);
+	cpus = evsel__cpus(counter);
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		s2 = config->aggr_get_id(config, cpus, idx);
 		for (s = 0; s < config->aggr_map->nr; s++) {
 			id = config->aggr_map->map[s];
 			if (cpu_map__compare_aggr_cpu_id(s2, id))
@@ -1220,7 +1226,7 @@ static void print_percore_thread(struct perf_stat_config *config,
 
 		print_counter_aggrdata(config, counter, s,
 				       prefix, false,
-				       &first, i);
+				       &first, cpu);
 	}
 }
 
-- 
2.34.1.448.ga2b2bfdf31-goog

