Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2B058A332
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbiHDWU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbiHDWT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:19:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D5172EDF
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:19:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-328c683e73aso6850817b3.23
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=hKdXC3Dql13mKwUfJGBQkfcpnljE9PToPeTdbYeGres=;
        b=NDRI2Uda5JWymD6je14uVr3Oj4wbWv42Eh9kGopbOo78wrOR9Oky1i9ioN+9H1zn00
         dOC4UJ7VRmSvi3YjHZ5kzjze2CeL6EbBuDwQpkR0+tv/agAoM1F0f9HZuZZ+5RxMKPau
         HifNxlWUlMcadc5JZszNLd97aYlUMEt4VfXYen+3xCeahJiQgSICQNiLedF0cVTz0ZgQ
         S1KfQvP2C0JXUzZPzgZlQ2uBGilDfyUAU6pUIIjh+3wgRhRs7QnW+mSdoLZ4csitiVur
         h/8UsGxCykGIbAyGE8zvqPeOIAIvXTyoQsv4cmktpWORHT1XxnjaaQ9FyWKrovNNWCQv
         yv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=hKdXC3Dql13mKwUfJGBQkfcpnljE9PToPeTdbYeGres=;
        b=TeHmtyiKmgTohQyiyUf7AU7GrIC0peiFwVgy2QRIkfeengz5k/7jAjgVJuddd3xeLx
         u4okAAZiZ9GgM8HaqHk1TuCncSzJGuKa27NkdFHfpmpI9RcmtfFLMtXHm6W+CHnPPktx
         G+P3+GM92GxifET2Pc43qzTb+5ZGKs2Z2tNahO52LjIsenE4SBeIw46B0iR8agfReVMC
         +2VnkGrz/YYWnMoniPzATtBgePu3wghcwGdJo1z4Nbx8bBqxc1ChqEGGj+arCmjkhRgf
         IoYVMl1os+C/hdNClg/KoRkkZw5HiSTkhl5JGBcaizEVtozo1E7bAgiBYUPm17pLB9IL
         mq3w==
X-Gm-Message-State: ACgBeo2UPxG7RPANu13BIeI+aDfKVDKj9eGjc8otIX+jyVbmFuealKyA
        xcHEFHdSMBgTGjtrT3MMHDzERIimxGe7
X-Google-Smtp-Source: AA6agR6YILN9N5BqtIbXvPAjFAUAHzL2OQeguWlk9vwwJWB+OjVa+SHBovChrFea7YNP+B1FzQKcXEFzMDp4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a0d:ebc8:0:b0:31f:4f08:63aa with SMTP id
 u191-20020a0debc8000000b0031f4f0863aamr3495227ywe.145.1659651543035; Thu, 04
 Aug 2022 15:19:03 -0700 (PDT)
Date:   Thu,  4 Aug 2022 15:18:14 -0700
In-Reply-To: <20220804221816.1802790-1-irogers@google.com>
Message-Id: <20220804221816.1802790-16-irogers@google.com>
Mime-Version: 1.0
References: <20220804221816.1802790-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 15/17] perf metrics: Copy entire pmu_event in find metric
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmu_event passed to the pmu_events_table_for_each_event is invalid
after the loop. Copy the entire struct in metricgroup__find_metric.
Reduce the scope of this function to static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 33 ++++++++++++++++++---------------
 tools/perf/util/metricgroup.h |  2 --
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8ef44f4b5e9a..95f4b46dba09 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -879,6 +879,10 @@ struct metricgroup_add_iter_data {
 	const struct pmu_events_table *table;
 };
 
+static bool metricgroup__find_metric(const char *metric,
+				     const struct pmu_events_table *table,
+				     struct pmu_event *pe);
+
 static int add_metric(struct list_head *metric_list,
 		      const struct pmu_event *pe,
 		      const char *modifier,
@@ -914,7 +918,7 @@ static int resolve_metric(struct list_head *metric_list,
 	size_t bkt;
 	struct to_resolve {
 		/* The metric to resolve. */
-		const struct pmu_event *pe;
+		struct pmu_event pe;
 		/*
 		 * The key in the IDs map, this may differ from in case,
 		 * etc. from pe->metric_name.
@@ -928,16 +932,15 @@ static int resolve_metric(struct list_head *metric_list,
 	 * the pending array.
 	 */
 	hashmap__for_each_entry(root_metric->pctx->ids, cur, bkt) {
-		const struct pmu_event *pe;
+		struct pmu_event pe;
 
-		pe = metricgroup__find_metric(cur->key, table);
-		if (pe) {
+		if (metricgroup__find_metric(cur->key, table, &pe)) {
 			pending = realloc(pending,
 					(pending_cnt + 1) * sizeof(struct to_resolve));
 			if (!pending)
 				return -ENOMEM;
 
-			pending[pending_cnt].pe = pe;
+			memcpy(&pending[pending_cnt].pe, &pe, sizeof(pe));
 			pending[pending_cnt].key = cur->key;
 			pending_cnt++;
 		}
@@ -952,7 +955,7 @@ static int resolve_metric(struct list_head *metric_list,
 	 * context.
 	 */
 	for (i = 0; i < pending_cnt; i++) {
-		ret = add_metric(metric_list, pending[i].pe, modifier, metric_no_group,
+		ret = add_metric(metric_list, &pending[i].pe, modifier, metric_no_group,
 				root_metric, visited, table);
 		if (ret)
 			break;
@@ -1073,7 +1076,7 @@ static int __add_metric(struct list_head *metric_list,
 
 struct metricgroup__find_metric_data {
 	const char *metric;
-	const struct pmu_event *pe;
+	struct pmu_event *pe;
 };
 
 static int metricgroup__find_metric_callback(const struct pmu_event *pe,
@@ -1085,21 +1088,21 @@ static int metricgroup__find_metric_callback(const struct pmu_event *pe,
 	if (!match_metric(pe->metric_name, data->metric))
 		return 0;
 
-	data->pe = pe;
-	return -1;
+	memcpy(data->pe, pe, sizeof(*pe));
+	return 1;
 }
 
-const struct pmu_event *metricgroup__find_metric(const char *metric,
-						 const struct pmu_events_table *table)
+static bool metricgroup__find_metric(const char *metric,
+				     const struct pmu_events_table *table,
+				     struct pmu_event *pe)
 {
 	struct metricgroup__find_metric_data data = {
 		.metric = metric,
-		.pe = NULL,
+		.pe = pe,
 	};
 
-	pmu_events_table_for_each_event(table, metricgroup__find_metric_callback, &data);
-
-	return data.pe;
+	return pmu_events_table_for_each_event(table, metricgroup__find_metric_callback, &data)
+		? true : false;
 }
 
 static int add_metric(struct list_head *metric_list,
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index f54d170043e9..016b3b1a289a 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -69,8 +69,6 @@ int metricgroup__parse_groups(const struct option *opt,
 			      bool metric_no_group,
 			      bool metric_no_merge,
 			      struct rblist *metric_events);
-const struct pmu_event *metricgroup__find_metric(const char *metric,
-						 const struct pmu_events_table *table);
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const struct pmu_events_table *table,
 				   const char *str,
-- 
2.37.1.559.g78731f0fdb-goog

