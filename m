Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED8951E475
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351853AbiEGFib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445700AbiEGFiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:38:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CD62E9C9
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 22:34:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d22-20020a25add6000000b00645d796034fso7924622ybe.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 22:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gcYqxh5Opd0xAIFhaLkZah3tm02tWS5shPMbttMBo+g=;
        b=OnrkBF4dkwel0INnFUUcNVkb1EKQgMi0hW09jwwmgo7gvI6olx/BA6l1AI6K++mpdA
         DYmcc8BR+m+PzPqydc2PH/dNeYUrtqeF59dozpzYMjXLemLHEz20g44T5v4fVVJ6xlT+
         2qanIV7H5X/ebzeKqG0pbmOx0mW/X1I9JQVxucBNiuoA+Ae3YwByERX6W9Puwy2Ib3l7
         oZqjjXAzSb/dyIjAm9DiWXrbmLwm8xkeduwne8gpSd21D17SFAzfiAIMOy4vEoLm74+E
         7v/GiEVs1lRzthBjIF5ISeRvBQ+KjnyWhgXxY5CPeWwRpxI9uLg2gmfh2QshX0HRueMR
         n2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gcYqxh5Opd0xAIFhaLkZah3tm02tWS5shPMbttMBo+g=;
        b=iUCLPCiYLzIPebfIQc29L8QZ0QmFTX7oJEYfTKgCaNpaHfH7ETXU8i4PSdGvWn9Ui1
         4jVTVBoQBvYNH98W6j0coPFU1b+8IqKvJ3PdpXhvXMnuAFWBKnnG7bUHrSwEhxpkar3P
         33QuTd9oTtGc8OE7IkHefOleeDfzBEUBrHAnoIuSiuzZfE0Ri8yPB50CBKIvdts5/uBl
         Oq1gTDLM/u8SaVHl7ecUvBXH3rwZUEtFj7W8MUdU4XeU+b5svD/zJBle/KduxKaBtj9y
         S17hZrHZFGJa/pwBZbe7zSwRHxRtX+Z9S1vQMI+sXE+2bksN+27R1X6MghuLUfscsbel
         QSVQ==
X-Gm-Message-State: AOAM532OVYx2U7BQ6oE6JGs5PWh1pnB00ZDhMFOwDZfboomjhcVhNniq
        9Wwh+VRaj87uUk8SJLisGiWSELw7H6lC
X-Google-Smtp-Source: ABdhPJy+ol5pg1dvBrK0DPVgxRFflJxJDWSHXGQ63hSGPzT5cMTf0CHJZqkefT5JBX8KkSYr5hUeEYIGSCgn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:bf2a:2f64:a273:3573])
 (user=irogers job=sendgmr) by 2002:a5b:603:0:b0:648:507a:b9f8 with SMTP id
 d3-20020a5b0603000000b00648507ab9f8mr4905887ybq.497.1651901666173; Fri, 06
 May 2022 22:34:26 -0700 (PDT)
Date:   Fri,  6 May 2022 22:34:10 -0700
In-Reply-To: <20220507053410.3798748-1-irogers@google.com>
Message-Id: <20220507053410.3798748-6-irogers@google.com>
Mime-Version: 1.0
References: <20220507053410.3798748-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 5/5] perf metrics: Don't add all tool events for sharing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Tool events are added to the set of events for parsing so that having a
tool event in a metric doesn't inhibit event sharing of events between
metrics. All tool events were added but this meant unused tool events
would be counted. Reduce this set of tool events to just those present
in the overall metric list.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 45 ++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 7a5f488aef02..ee8fcfa115e5 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1283,6 +1283,30 @@ static void metricgroup__free_metrics(struct list_head *metric_list)
 	}
 }
 
+/**
+ * find_tool_events - Search for the pressence of tool events in metric_list.
+ * @metric_list: List to take metrics from.
+ * @tool_events: Array of false values, indices corresponding to tool events set
+ *               to true if tool event is found.
+ */
+static void find_tool_events(const struct list_head *metric_list,
+			     bool tool_events[PERF_TOOL_MAX])
+{
+	struct metric *m;
+
+	list_for_each_entry(m, metric_list, nd) {
+		int i;
+
+		perf_tool_event__for_each_event(i) {
+			struct expr_id_data *data;
+
+			if (!tool_events[i] &&
+			    !expr__get_id(m->pctx, perf_tool_event__to_str(i), &data))
+				tool_events[i] = true;
+		}
+	}
+}
+
 /**
  * build_combined_expr_ctx - Make an expr_parse_ctx with all has_constraint
  *                           metric IDs, as the IDs are held in a set,
@@ -1332,11 +1356,14 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
  * @ids: the event identifiers parsed from a metric.
  * @modifier: any modifiers added to the events.
  * @has_constraint: false if events should be placed in a weak group.
+ * @tool_events: entries set true if the tool event of index could be present in
+ *               the overall list of metrics.
  * @out_evlist: the created list of events.
  */
 static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 		     struct expr_parse_ctx *ids, const char *modifier,
-		     bool has_constraint, struct evlist **out_evlist)
+		     bool has_constraint, const bool tool_events[PERF_TOOL_MAX],
+		     struct evlist **out_evlist)
 {
 	struct parse_events_error parse_error;
 	struct evlist *parsed_evlist;
@@ -1360,11 +1387,13 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 		 * Add a tool event to avoid a parse error on an empty string.
 		 */
 		perf_tool_event__for_each_event(i) {
-			char *tmp = strdup(perf_tool_event__to_str(i));
+			if (tool_events[i]) {
+				char *tmp = strdup(perf_tool_event__to_str(i));
 
-			if (!tmp)
-				return -ENOMEM;
-			ids__insert(ids->ids, tmp);
+				if (!tmp)
+					return -ENOMEM;
+				ids__insert(ids->ids, tmp);
+			}
 		}
 	}
 	ret = metricgroup__build_event_string(&events, ids, modifier,
@@ -1407,6 +1436,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 	struct evlist *combined_evlist = NULL;
 	LIST_HEAD(metric_list);
 	struct metric *m;
+	bool tool_events[PERF_TOOL_MAX] = {false};
 	int ret;
 
 	if (metric_events_list->nr_entries == 0)
@@ -1422,12 +1452,15 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 	if (!metric_no_merge) {
 		struct expr_parse_ctx *combined = NULL;
 
+		find_tool_events(&metric_list, tool_events);
+
 		ret = build_combined_expr_ctx(&metric_list, &combined);
 
 		if (!ret && combined && hashmap__size(combined->ids)) {
 			ret = parse_ids(metric_no_merge, fake_pmu, combined,
 					/*modifier=*/NULL,
 					/*has_constraint=*/true,
+					tool_events,
 					&combined_evlist);
 		}
 		if (combined)
@@ -1475,7 +1508,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		}
 		if (!metric_evlist) {
 			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
-					m->has_constraint, &m->evlist);
+					m->has_constraint, tool_events, &m->evlist);
 			if (ret)
 				goto out;
 
-- 
2.36.0.512.ge40c2bad7a-goog

