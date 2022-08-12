Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B077591790
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 01:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbiHLXLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 19:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbiHLXKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 19:10:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4A29FA8D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:10:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f3959ba41so18542527b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=L3NCVkU6UmNGTi4r6GGCKSqgXuvU9SIfIoFGeABj8Ww=;
        b=ETDW742cZj1CKv1exNN5guZhFRahQN+33+PQtwGgWD77JQRz2kNEAmbFHjsldbmUVb
         cspBkUR580GPTInNtvfyMx9nfUEtmT6qKsZztyst8hshsLJJq/t9G3JZucnHCsh8Q69C
         CHXtWV4Olnhnkb3m0a05Vqd96jaN/ORPOsw1lX87XU2aAE286EjU7ITcRmkdvzhjxARe
         o9y2DbRdPyLOmONtnoj1ttioVfFa5quKMKSXbt6VchqScpT/ElBOYoCYSUaeRY59AFf6
         ePkHfm0LPKyt6gHD07a0vCmEXgvwL0uccQj1BtFISYkveMFgVHLR20Q+5qSgc9r/OMBt
         o39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=L3NCVkU6UmNGTi4r6GGCKSqgXuvU9SIfIoFGeABj8Ww=;
        b=h0oPNAcR/4OFzUQc+fXstwzP5K21V7DcsU1tIHjoDNzKZJue5Uace6qRAhIKCIq3Sq
         pXdnuhOFI58GB+tNvKO0uWhb/xYQs7R85OafW8o+E75bRObBBrZklB27G6KhCHfWmYfZ
         PL57l9NkJtC6Yzdwqr24KJFEobKwjgN474gp/LUD1Ub4oLMaKq+GhQrRaXhyCT0dt03z
         Oys79d1bbRPFwcUu4/EKJ5eGquevzZZvspPSY6eu6frRGszA/kLTyqgNDQMp78goEV0f
         +C9T1KUwSTDh+TaYJd7knckFtl0E6vLJ+oIMXHTRwmJMhNewTWt2EF7INpSAlUwr/x9j
         Au9A==
X-Gm-Message-State: ACgBeo2xQtWM/tzB+fgnvW8Mt9nwj8rxXsuKOmaTO3Uglh8yU/+JiHYu
        UypeT8yW9dxifnsVrpMpR1H5R9vEJXy+
X-Google-Smtp-Source: AA6agR6QSimwWeQzK/xHxfqJZ7SfTKWtl9RSmsfbBpCCuL3WiqcKFutPaGotbF3pR/Bpi/XjkzIr9332cAYb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d668:2937:8218:c5ec])
 (user=irogers job=sendgmr) by 2002:a25:55c5:0:b0:670:96cb:a295 with SMTP id
 j188-20020a2555c5000000b0067096cba295mr4680145ybb.449.1660345826657; Fri, 12
 Aug 2022 16:10:26 -0700 (PDT)
Date:   Fri, 12 Aug 2022 16:09:47 -0700
In-Reply-To: <20220812230949.683239-1-irogers@google.com>
Message-Id: <20220812230949.683239-13-irogers@google.com>
Mime-Version: 1.0
References: <20220812230949.683239-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v5 12/14] perf metrics: Copy entire pmu_event in find metric
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index 42a5c8ae915e..464475fd6b9a 100644
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
2.37.1.595.g718a3a8f04-goog

