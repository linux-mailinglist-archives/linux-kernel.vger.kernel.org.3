Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930B251E474
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445727AbiEGFi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445612AbiEGFiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:38:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277B2408A
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 22:34:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 9-20020a250909000000b006484b89c979so7826655ybj.21
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 22:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7BccLGFbnzxgEz6sHuW6w+xF3bfVrTq5a9IERbkhU7Q=;
        b=RkL0pa87fsjXuMFKkX4QrTiVPsgv3eVh3ignPmfTAqCB4NGjec3442fQ9T7slD2j28
         zTWog8mY+oEByKHjcDyzKCs3NL/AqstetnUe2NVPiS/0YwgMtElYPYULCAAY886Zd+oT
         XDJrPS1YeSBMp8ScLBQGJ3o7HW3U9vngEwXbhXJhKP65F7wq+WybP2MyCczffaXuj07v
         JGLhWFYSFFttYWTAhzCJgiYQxAi/zs3WF37aMVOccmnR3Te3lhOpSSJ8CpZ5oTCqFgAy
         rBH0V+yE8mXwzDdDxdqPn0fjrsnukboahKOKWuOO1E52lg4Yo5aKgMYnzYqro+qUnvMo
         dLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7BccLGFbnzxgEz6sHuW6w+xF3bfVrTq5a9IERbkhU7Q=;
        b=8N6UrPcbm+nH+K7mUttSt/DdnCXATBIpZW0JDMfD4ZJjsz8xK9iOu4hjN6HimcFf9L
         Hyv/4XiAgaTYklg6WsOPNorVbiJKFREMocHQ+zPP0k2EeQKGDnOJkBDqynUMSin4Q27+
         LtAJRLDz2CHWSpqn2xj+DKwZx2oGp0IeyVwSmz0KWT1AybfQrcgwvHztshD+Q70Xj6nv
         xlxaPHB/+HjMx2YtZktx4bF1u+yDv4PkOnMehNgIEyjLf+ESYnAIoGfzPZTc73sCePSA
         aN0+c510A51zd44IyHWh4xz2oyh8vwv0x9wnXPze2KA8UhKfvEkgvXs8bjCSEpl8Skf9
         Tejg==
X-Gm-Message-State: AOAM532ktdI6BDwGlashwnGGaAwCA03LH1fVkC+vKEP1TFMLqoZdyXGZ
        FumSa9SrZc4sdwpElDX0jnX7HstSzUwz
X-Google-Smtp-Source: ABdhPJwHS2vHsogko5eYvlKiFMT2M+HKgGmnh026VsFjlc0DEeLQohnX5ZX/K1VEx7OwEJkQoUUg0+gjBcPk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:bf2a:2f64:a273:3573])
 (user=irogers job=sendgmr) by 2002:a25:ba07:0:b0:64a:1a32:6ef6 with SMTP id
 t7-20020a25ba07000000b0064a1a326ef6mr4915646ybg.308.1651901664027; Fri, 06
 May 2022 22:34:24 -0700 (PDT)
Date:   Fri,  6 May 2022 22:34:09 -0700
In-Reply-To: <20220507053410.3798748-1-irogers@google.com>
Message-Id: <20220507053410.3798748-5-irogers@google.com>
Mime-Version: 1.0
References: <20220507053410.3798748-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 4/5] perf metrics: Support all tool events
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously duration_time was hard coded, which was ok until
commit b03b89b35003 ("perf stat: Add user_time and system_time events")
added additional tool events. Do for all tool events what was previously
done just for duration_time.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 87 ++++++++++++++++++++---------------
 tools/perf/util/stat-shadow.c | 27 +++++++++--
 2 files changed, 75 insertions(+), 39 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index d8492e339521..7a5f488aef02 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -728,22 +728,23 @@ static int metricgroup__build_event_string(struct strbuf *events,
 {
 	struct hashmap_entry *cur;
 	size_t bkt;
-	bool no_group = true, has_duration = false;
+	bool no_group = true, has_tool_events = false;
+	bool tool_events[PERF_TOOL_MAX] = {false};
 	int ret = 0;
 
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
 
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *sep, *rsep, *id = cur->key;
+		enum perf_tool_event ev;
 
 		pr_debug("found event %s\n", id);
-		/*
-		 * Duration time maps to a software event and can make
-		 * groups not count. Always use it outside a
-		 * group.
-		 */
-		if (!strcmp(id, "duration_time")) {
-			has_duration = true;
+
+		/* Always move tool events outside of the group. */
+		ev = perf_tool_event__from_str(id);
+		if (ev != PERF_TOOL_NONE) {
+			has_tool_events = true;
+			tool_events[ev] = true;
 			continue;
 		}
 		/* Separate events with commas and open the group if necessary. */
@@ -802,16 +803,25 @@ static int metricgroup__build_event_string(struct strbuf *events,
 			RETURN_IF_NON_ZERO(ret);
 		}
 	}
-	if (has_duration) {
-		if (no_group) {
-			/* Strange case of a metric of just duration_time. */
-			ret = strbuf_addf(events, "duration_time");
-		} else if (!has_constraint)
-			ret = strbuf_addf(events, "}:W,duration_time");
-		else
-			ret = strbuf_addf(events, ",duration_time");
-	} else if (!no_group && !has_constraint)
+	if (!no_group && !has_constraint) {
 		ret = strbuf_addf(events, "}:W");
+		RETURN_IF_NON_ZERO(ret);
+	}
+	if (has_tool_events) {
+		int i;
+
+		perf_tool_event__for_each_event(i) {
+			if (tool_events[i]) {
+				if (!no_group) {
+					ret = strbuf_addch(events, ',');
+					RETURN_IF_NON_ZERO(ret);
+				}
+				no_group = false;
+				ret = strbuf_addstr(events, perf_tool_event__to_str(i));
+				RETURN_IF_NON_ZERO(ret);
+			}
+		}
+	}
 
 	return ret;
 #undef RETURN_IF_NON_ZERO
@@ -1117,7 +1127,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
 
 /**
  * metric_list_cmp - list_sort comparator that sorts metrics with more events to
- *                   the front. duration_time is excluded from the count.
+ *                   the front. tool events are excluded from the count.
  */
 static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
 			   const struct list_head *r)
@@ -1125,15 +1135,19 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
 	const struct metric *left = container_of(l, struct metric, nd);
 	const struct metric *right = container_of(r, struct metric, nd);
 	struct expr_id_data *data;
-	int left_count, right_count;
+	int i, left_count, right_count;
 
 	left_count = hashmap__size(left->pctx->ids);
-	if (!expr__get_id(left->pctx, "duration_time", &data))
-		left_count--;
+	perf_tool_event__for_each_event(i) {
+		if (!expr__get_id(left->pctx, perf_tool_event__to_str(i), &data))
+			left_count--;
+	}
 
 	right_count = hashmap__size(right->pctx->ids);
-	if (!expr__get_id(right->pctx, "duration_time", &data))
-		right_count--;
+	perf_tool_event__for_each_event(i) {
+		if (!expr__get_id(right->pctx, perf_tool_event__to_str(i), &data))
+			right_count--;
+	}
 
 	return right_count - left_count;
 }
@@ -1331,26 +1345,27 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 
 	*out_evlist = NULL;
 	if (!metric_no_merge || hashmap__size(ids->ids) == 0) {
-		char *tmp;
+		int i;
 		/*
-		 * We may fail to share events between metrics because
-		 * duration_time isn't present in one metric. For example, a
-		 * ratio of cache misses doesn't need duration_time but the same
-		 * events may be used for a misses per second. Events without
-		 * sharing implies multiplexing, that is best avoided, so place
-		 * duration_time in every group.
+		 * We may fail to share events between metrics because a tool
+		 * event isn't present in one metric. For example, a ratio of
+		 * cache misses doesn't need duration_time but the same events
+		 * may be used for a misses per second. Events without sharing
+		 * implies multiplexing, that is best avoided, so place
+		 * all tool events in every group.
 		 *
 		 * Also, there may be no ids/events in the expression parsing
 		 * context because of constant evaluation, e.g.:
 		 *    event1 if #smt_on else 0
-		 * Add a duration_time event to avoid a parse error on an empty
-		 * string.
+		 * Add a tool event to avoid a parse error on an empty string.
 		 */
-		tmp = strdup("duration_time");
-		if (!tmp)
-			return -ENOMEM;
+		perf_tool_event__for_each_event(i) {
+			char *tmp = strdup(perf_tool_event__to_str(i));
 
-		ids__insert(ids->ids, tmp);
+			if (!tmp)
+				return -ENOMEM;
+			ids__insert(ids->ids, tmp);
+		}
 	}
 	ret = metricgroup__build_event_string(&events, ids, modifier,
 					      has_constraint);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index ea4c35e4f1da..979c8cb918f7 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -833,10 +833,31 @@ static int prepare_metric(struct evsel **metric_events,
 		u64 metric_total = 0;
 		int source_count;
 
-		if (!strcmp(metric_events[i]->name, "duration_time")) {
-			stats = &walltime_nsecs_stats;
-			scale = 1e-9;
+		if (evsel__is_tool(metric_events[i])) {
 			source_count = 1;
+			switch (metric_events[i]->tool_event) {
+			case PERF_TOOL_DURATION_TIME:
+				stats = &walltime_nsecs_stats;
+				scale = 1e-9;
+				break;
+			case PERF_TOOL_USER_TIME:
+				stats = &ru_stats.ru_utime_usec_stat;
+				scale = 1e-6;
+				break;
+			case PERF_TOOL_SYSTEM_TIME:
+				stats = &ru_stats.ru_stime_usec_stat;
+				scale = 1e-6;
+				break;
+			case PERF_TOOL_NONE:
+				pr_err("Invalid tool event 'none'");
+				abort();
+			case PERF_TOOL_MAX:
+				pr_err("Invalid tool event 'max'");
+				abort();
+			default:
+				pr_err("Unknown tool event '%s'", evsel__name(metric_events[i]));
+				abort();
+			}
 		} else {
 			v = saved_value_lookup(metric_events[i], cpu_map_idx, false,
 					       STAT_NONE, 0, st,
-- 
2.36.0.512.ge40c2bad7a-goog

