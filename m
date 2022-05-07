Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3AC51E471
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445661AbiEGFiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238607AbiEGFiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:38:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F011AF2B
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 22:34:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f7ee6bc6ddso81927357b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 22:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uRh0OB02KtllfhwOU5rNTHuECFQjo2cJmquafVll4ec=;
        b=pVoNB23y4+g9luuKLXC4ta6e0auBYD5qdn/1MBw3kb77j11MMrluzqYTFaywGg/sNM
         LMP3PJ18B0K0+ol5tVmMt2+oCumV8oPmZGM/UFFul6WCCbsJl9xl8WTsNqi/eyAySCyr
         NhsA8j4mp82GyrR/nSDgHvjRDAFbOtFoQs6Zk602FIG+AGQViIMDBzH7aN5Pisd+MwSJ
         yGA2USLQfgy4Y04zIxapDexhC52fT74QocwtosFdE1ahCggAKP5kyxXLKFJcyRYx9xWU
         HX7ZiE9Sh5xz2BEtVZg+Q+75cWK0Tmfn48141m1lzPDYAcBssW3EASXrDQPlL8IATDb5
         bXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uRh0OB02KtllfhwOU5rNTHuECFQjo2cJmquafVll4ec=;
        b=P0aNXpaeRpvEdfWew7iBmHPjJBmOE9vbqyDyqF8LKl5eFH2CBbiVDvZeqifsLeRyVW
         aRoc3aqSLDGr2/06N76iega0CciL5lEqB2HTVD2ABH/8DUMbB1Lold05SJOhGDtw/aWy
         395UuxJ2vzqxeXWcSKEiEIhDi/MCpQxLMmjMIuQqTFSGqGKpQZawkfgwe5J/6lmjOHmL
         OfMEL4nqUTGxXfMDQBZ3JDADQMRRTNYnVF9j3blbfzAA4qzIVCrvmJhU3JDP3R6G4c46
         QWmx89m4OfOU2Hca74yyrrPW37vjjhz8E16Lnf0WPq2i0UX+UswjBI7GxTZb6Q11wZhG
         LCJw==
X-Gm-Message-State: AOAM531xzQw2f9w5/gxRnb53aPALtwcKFMpkW6bvJWpUx0+ugBBB0dpQ
        M6L+fRaudmccnFVKwAKzi6umWi0AbjHM
X-Google-Smtp-Source: ABdhPJxvl48EoT2c9kzdVHWoEtdZ2kR0mwbTeQ1roYREq5YMMgO7PckMiVZI20NEnzyV8HtexzEi0QP1EbCj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:bf2a:2f64:a273:3573])
 (user=irogers job=sendgmr) by 2002:a81:8102:0:b0:2f8:f5fb:b805 with SMTP id
 r2-20020a818102000000b002f8f5fbb805mr5725063ywf.128.1651901657117; Fri, 06
 May 2022 22:34:17 -0700 (PDT)
Date:   Fri,  6 May 2022 22:34:06 -0700
In-Reply-To: <20220507053410.3798748-1-irogers@google.com>
Message-Id: <20220507053410.3798748-2-irogers@google.com>
Mime-Version: 1.0
References: <20220507053410.3798748-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 1/5] Revert "perf stat: Support metrics with hybrid events"
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

This reverts commit 60344f1a9a597f2e0efcd57df5dad0b42da15e21.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c  | 263 +++------------------------------
 tools/perf/util/stat-display.c |   8 +-
 2 files changed, 22 insertions(+), 249 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 126a43a8917e..d8492e339521 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -141,11 +141,6 @@ struct metric {
 	 * output.
 	 */
 	const char *metric_unit;
-	/**
-	 * The name of the CPU such as "cpu_core" or "cpu_atom" in hybrid systems
-	 * and "NULL" in non-hybrid systems.
-	 */
-	const char *pmu_name;
 	/** Optional null terminated array of referenced metrics. */
 	struct metric_ref *metric_refs;
 	/**
@@ -220,7 +215,6 @@ static struct metric *metric__new(const struct pmu_event *pe,
 	}
 	m->metric_expr = pe->metric_expr;
 	m->metric_unit = pe->unit;
-	m->pmu_name = pe->pmu;
 	m->pctx->runtime = runtime;
 	m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
 	m->metric_refs = NULL;
@@ -256,12 +250,10 @@ static bool contains_metric_id(struct evsel **metric_events, int num_events,
  * @ids: the metric IDs to match.
  * @metric_evlist: the list of perf events.
  * @out_metric_events: holds the created metric events array.
- * @pmu_name: the name of the CPU.
  */
 static int setup_metric_events(struct hashmap *ids,
 			       struct evlist *metric_evlist,
-			       struct evsel ***out_metric_events,
-			       const char *pmu_name)
+			       struct evsel ***out_metric_events)
 {
 	struct evsel **metric_events;
 	const char *metric_id;
@@ -294,10 +286,6 @@ static int setup_metric_events(struct hashmap *ids,
 		 * about this event.
 		 */
 		if (hashmap__find(ids, metric_id, (void **)&val_ptr)) {
-			if (evsel__is_hybrid(ev) && pmu_name &&
-			    strcmp(pmu_name, ev->pmu_name)) {
-				continue;
-			}
 			metric_events[matched_events++] = ev;
 
 			if (matched_events >= ids_size)
@@ -736,8 +724,7 @@ static int decode_all_metric_ids(struct evlist *perf_evlist, const char *modifie
 static int metricgroup__build_event_string(struct strbuf *events,
 					   const struct expr_parse_ctx *ctx,
 					   const char *modifier,
-					   bool has_constraint,
-					   const char *pmu_name)
+					   bool has_constraint)
 {
 	struct hashmap_entry *cur;
 	size_t bkt;
@@ -819,18 +806,12 @@ static int metricgroup__build_event_string(struct strbuf *events,
 		if (no_group) {
 			/* Strange case of a metric of just duration_time. */
 			ret = strbuf_addf(events, "duration_time");
-		} else if (!has_constraint) {
-			ret = strbuf_addf(events, "}:W");
-			if (pmu_name)
-				ret = strbuf_addf(events, "#%s", pmu_name);
-			ret = strbuf_addf(events, ",duration_time");
-		} else
+		} else if (!has_constraint)
+			ret = strbuf_addf(events, "}:W,duration_time");
+		else
 			ret = strbuf_addf(events, ",duration_time");
-	} else if (!no_group && !has_constraint) {
+	} else if (!no_group && !has_constraint)
 		ret = strbuf_addf(events, "}:W");
-		if (pmu_name)
-			ret = strbuf_addf(events, "#%s", pmu_name);
-	}
 
 	return ret;
 #undef RETURN_IF_NON_ZERO
@@ -1169,13 +1150,11 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
  * @metric_list: The list that the metric or metric group are added to.
  * @map: The map that is searched for metrics, most commonly the table for the
  *       architecture perf is running upon.
- * @pmu_name: the name of the CPU.
  */
-static int metricgroup__add_metric(const char *metric_name,
-				   const char *modifier, bool metric_no_group,
+static int metricgroup__add_metric(const char *metric_name, const char *modifier,
+				   bool metric_no_group,
 				   struct list_head *metric_list,
-				   const struct pmu_events_map *map,
-				   const char *pmu_name)
+				   const struct pmu_events_map *map)
 {
 	const struct pmu_event *pe;
 	LIST_HEAD(list);
@@ -1188,8 +1167,6 @@ static int metricgroup__add_metric(const char *metric_name,
 	 */
 	map_for_each_metric(pe, i, map, metric_name) {
 		has_match = true;
-		if (pmu_name && pe->pmu && strcmp(pmu_name, pe->pmu))
-			continue;
 		ret = add_metric(&list, pe, modifier, metric_no_group,
 				 /*root_metric=*/NULL,
 				 /*visited_metrics=*/NULL, map);
@@ -1238,12 +1215,10 @@ static int metricgroup__add_metric(const char *metric_name,
  * @metric_list: The list that metrics are added to.
  * @map: The map that is searched for metrics, most commonly the table for the
  *       architecture perf is running upon.
- * @pmu_name: the name of the CPU.
  */
 static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 					struct list_head *metric_list,
-					const struct pmu_events_map *map,
-					const char *pmu_name)
+					const struct pmu_events_map *map)
 {
 	char *list_itr, *list_copy, *metric_name, *modifier;
 	int ret, count = 0;
@@ -1260,7 +1235,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 
 		ret = metricgroup__add_metric(metric_name, modifier,
 					      metric_no_group, metric_list,
-					      map, pmu_name);
+					      map);
 		if (ret == -EINVAL)
 			pr_err("Cannot find metric or group `%s'\n", metric_name);
 
@@ -1335,183 +1310,6 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 	return ret;
 }
 
-static char *get_metric_pmus(char *orig_str, struct strbuf *metric_pmus)
-{
-	char *llist, *nlist, *p1, *p2, *new_str = NULL;
-	int ret;
-	struct strbuf new_events;
-
-	if (!strchr(orig_str, '#')) {
-		/*
-		 * pmu name is added after '#'. If no '#' found,
-		 * don't need to process pmu.
-		 */
-		return strdup(orig_str);
-	}
-
-	nlist = strdup(orig_str);
-	if (!nlist)
-		return new_str;
-
-	ret = strbuf_init(&new_events, 100);
-	if (ret)
-		goto err_out;
-
-	ret = strbuf_grow(metric_pmus, 100);
-	if (ret)
-		goto err_out;
-
-	llist = nlist;
-	while ((p1 = strsep(&llist, ",")) != NULL) {
-		p2 = strchr(p1, '#');
-		if (p2) {
-			*p2 = 0;
-			ret = strbuf_addf(&new_events, "%s,", p1);
-			if (ret)
-				goto err_out;
-
-			ret = strbuf_addf(metric_pmus, "%s,", p2 + 1);
-			if (ret)
-				goto err_out;
-
-		} else {
-			ret = strbuf_addf(&new_events, "%s,", p1);
-			if (ret)
-				goto err_out;
-		}
-	}
-
-	new_str = strdup(new_events.buf);
-	if (new_str) {
-		/* Remove last ',' */
-		new_str[strlen(new_str) - 1] = 0;
-	}
-err_out:
-	free(nlist);
-	strbuf_release(&new_events);
-	return new_str;
-}
-
-static void set_pmu_unmatched_events(struct evlist *evlist, int group_idx,
-				     char *pmu_name,
-				     unsigned long *evlist_removed)
-{
-	struct evsel *evsel, *pos;
-	int i = 0, j = 0;
-
-	/*
-	 * Move to the first evsel of a given group
-	 */
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel__is_group_leader(evsel) &&
-		    evsel->core.nr_members >= 1) {
-			if (i < group_idx) {
-				j += evsel->core.nr_members;
-				i++;
-				continue;
-			}
-		}
-	}
-
-	i = 0;
-	evlist__for_each_entry(evlist, evsel) {
-		if (i < j) {
-			i++;
-			continue;
-		}
-
-		/*
-		 * Now we are at the first evsel in the group
-		 */
-		for_each_group_evsel(pos, evsel) {
-			if (evsel__is_hybrid(pos) &&
-			    strcmp(pos->pmu_name, pmu_name)) {
-				set_bit(pos->core.idx, evlist_removed);
-			}
-		}
-		break;
-	}
-}
-
-static void remove_pmu_umatched_events(struct evlist *evlist, char *metric_pmus)
-{
-	struct evsel *evsel, *tmp, *new_leader = NULL;
-	unsigned long *evlist_removed;
-	char *llist, *nlist, *p1;
-	bool need_new_leader = false;
-	int i = 0, new_nr_members = 0;
-
-	nlist = strdup(metric_pmus);
-	if (!nlist)
-		return;
-
-	evlist_removed = bitmap_zalloc(evlist->core.nr_entries);
-	if (!evlist_removed) {
-		free(nlist);
-		return;
-	}
-
-	llist = nlist;
-	while ((p1 = strsep(&llist, ",")) != NULL) {
-		if (strlen(p1) > 0) {
-			/*
-			 * p1 points to the string of pmu name, e.g. "cpu_atom".
-			 * The metric group string has pmu suffixes, e.g.
-			 * "{inst_retired.any,cpu_clk_unhalted.thread}:W#cpu_core,
-			 *  {cpu_clk_unhalted.core,inst_retired.any_p}:W#cpu_atom"
-			 * By counting the pmu name, we can know the index of
-			 * group.
-			 */
-			set_pmu_unmatched_events(evlist, i++, p1,
-						 evlist_removed);
-		}
-	}
-
-	evlist__for_each_entry_safe(evlist, tmp, evsel) {
-		if (test_bit(evsel->core.idx, evlist_removed)) {
-			if (!evsel__is_group_leader(evsel)) {
-				if (!need_new_leader) {
-					if (new_leader)
-						new_leader->core.leader->nr_members--;
-					else
-						evsel->core.leader->nr_members--;
-				} else
-					new_nr_members--;
-			} else {
-				/*
-				 * If group leader is to remove, we need to
-				 * prepare a new leader and adjust all group
-				 * members.
-				 */
-				need_new_leader = true;
-				new_nr_members =
-				    evsel->core.leader->nr_members - 1;
-			}
-
-			evlist__remove(evlist, evsel);
-			evsel__delete(evsel);
-		} else {
-			if (!evsel__is_group_leader(evsel)) {
-				if (need_new_leader) {
-					need_new_leader = false;
-					new_leader = evsel;
-					new_leader->core.leader =
-					    &new_leader->core;
-					new_leader->core.nr_members =
-					    new_nr_members;
-				} else if (new_leader)
-					evsel->core.leader = &new_leader->core;
-			} else {
-				need_new_leader = false;
-				new_leader = NULL;
-			}
-		}
-	}
-
-	bitmap_free(evlist_removed);
-	free(nlist);
-}
-
 /**
  * parse_ids - Build the event string for the ids and parse them creating an
  *             evlist. The encoded metric_ids are decoded.
@@ -1521,18 +1319,14 @@ static void remove_pmu_umatched_events(struct evlist *evlist, char *metric_pmus)
  * @modifier: any modifiers added to the events.
  * @has_constraint: false if events should be placed in a weak group.
  * @out_evlist: the created list of events.
- * @pmu_name: the name of the CPU.
  */
 static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 		     struct expr_parse_ctx *ids, const char *modifier,
-		     bool has_constraint, struct evlist **out_evlist,
-		     const char *pmu_name)
+		     bool has_constraint, struct evlist **out_evlist)
 {
 	struct parse_events_error parse_error;
 	struct evlist *parsed_evlist;
 	struct strbuf events = STRBUF_INIT;
-	struct strbuf metric_pmus = STRBUF_INIT;
-	char *nlist = NULL;
 	int ret;
 
 	*out_evlist = NULL;
@@ -1559,7 +1353,7 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 		ids__insert(ids->ids, tmp);
 	}
 	ret = metricgroup__build_event_string(&events, ids, modifier,
-					      has_constraint, pmu_name);
+					      has_constraint);
 	if (ret)
 		return ret;
 
@@ -1570,20 +1364,11 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 	}
 	pr_debug("Parsing metric events '%s'\n", events.buf);
 	parse_events_error__init(&parse_error);
-	nlist = get_metric_pmus(events.buf, &metric_pmus);
-	if (!nlist) {
-		ret = -ENOMEM;
-		goto err_out;
-	}
-	ret = __parse_events(parsed_evlist, nlist, &parse_error, fake_pmu);
+	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu);
 	if (ret) {
 		parse_events_error__print(&parse_error, events.buf);
 		goto err_out;
 	}
-
-	if (metric_pmus.alloc)
-		remove_pmu_umatched_events(parsed_evlist, metric_pmus.buf);
-
 	ret = decode_all_metric_ids(parsed_evlist, modifier);
 	if (ret)
 		goto err_out;
@@ -1591,12 +1376,9 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 	*out_evlist = parsed_evlist;
 	parsed_evlist = NULL;
 err_out:
-	if (nlist)
-		free(nlist);
 	parse_events_error__exit(&parse_error);
 	evlist__delete(parsed_evlist);
 	strbuf_release(&events);
-	strbuf_release(&metric_pmus);
 	return ret;
 }
 
@@ -1615,8 +1397,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 	if (metric_events_list->nr_entries == 0)
 		metricgroup__rblist_init(metric_events_list);
 	ret = metricgroup__add_metric_list(str, metric_no_group,
-					   &metric_list, map,
-					   perf_evlist->hybrid_pmu_name);
+					   &metric_list, map);
 	if (ret)
 		goto out;
 
@@ -1632,8 +1413,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 			ret = parse_ids(metric_no_merge, fake_pmu, combined,
 					/*modifier=*/NULL,
 					/*has_constraint=*/true,
-					&combined_evlist,
-					perf_evlist->hybrid_pmu_name);
+					&combined_evlist);
 		}
 		if (combined)
 			expr__ctx_free(combined);
@@ -1670,9 +1450,6 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 					continue;
 
 				if (expr__subset_of_ids(n->pctx, m->pctx)) {
-					if (m->pmu_name && n->pmu_name
-					    && strcmp(m->pmu_name, n->pmu_name))
-						continue;
 					pr_debug("Events in '%s' fully contained within '%s'\n",
 						 m->metric_name, n->metric_name);
 					metric_evlist = n->evlist;
@@ -1682,16 +1459,14 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 			}
 		}
 		if (!metric_evlist) {
-			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx,
-				      m->modifier, m->has_constraint,
-				      &m->evlist, m->pmu_name);
+			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
+					m->has_constraint, &m->evlist);
 			if (ret)
 				goto out;
 
 			metric_evlist = m->evlist;
 		}
-		ret = setup_metric_events(m->pctx->ids, metric_evlist,
-					  &metric_events, m->pmu_name);
+		ret = setup_metric_events(m->pctx->ids, metric_evlist, &metric_events);
 		if (ret) {
 			pr_debug("Cannot resolve IDs for %s: %s\n",
 				m->metric_name, m->metric_expr);
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 13f705737367..98669ca5a86b 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -539,8 +539,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 	}
 }
 
-static void uniquify_event_name(struct evsel *counter,
-				struct perf_stat_config *stat_config)
+static void uniquify_event_name(struct evsel *counter)
 {
 	char *new_name;
 	char *config;
@@ -559,8 +558,7 @@ static void uniquify_event_name(struct evsel *counter,
 			counter->name = new_name;
 		}
 	} else {
-		if (perf_pmu__has_hybrid() &&
-		    stat_config->metric_events.nr_entries == 0) {
+		if (perf_pmu__has_hybrid()) {
 			ret = asprintf(&new_name, "%s/%s/",
 				       counter->pmu_name, counter->name);
 		} else {
@@ -634,7 +632,7 @@ static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
 		return false;
 	cb(config, counter, data, true);
 	if (config->no_merge || hybrid_merge(counter, config, false))
-		uniquify_event_name(counter, config);
+		uniquify_event_name(counter);
 	else if (counter->auto_merge_stats || hybrid_merge(counter, config, true))
 		collect_all_aliases(config, counter, cb, data);
 	return true;
-- 
2.36.0.512.ge40c2bad7a-goog

