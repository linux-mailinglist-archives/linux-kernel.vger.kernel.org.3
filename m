Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2875A84BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiHaRux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiHaRuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:50:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF0127CF7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:50:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33f8988daecso200851377b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=O7x06VUny1WCJ5jSjqCJ7MNg10Zy7tcLBLmPAud8Uz8=;
        b=bBL/aY/COX7dr13JZAVO91/L9R2cA2sjMumCJH6SupSkJP/jUSXfqvu5Gr6Sv3xXkP
         V5XVzEHUUlO1jybAxfUnBpSchByqH6igaEA2vPn746d0MautUJVZZt+Dlx2viM773IKS
         kve7eukSwj9QuAvvHKohMH7uo6y3fWD26gFufwuV1HWUhbeYfX6De6ttrAg04j2T/11A
         3HINdOWhlt8ae4E8jNLQHRy0uR48PNvh2esmDt1o7vE84aQc0CaeBdJRU58MknFguEeW
         XWbuIxRdKuaMb4nnUx8VdrWtcJpEq8OOOSqzLrwNgcqsFMOIFmMxN615tJVFQAAgD94j
         neZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=O7x06VUny1WCJ5jSjqCJ7MNg10Zy7tcLBLmPAud8Uz8=;
        b=OuOZQDVDjrIiBp3u3HFMuA47ZEb+pACjxnvcz8SzlTmYDIOdHKTcXOyLZyLXIWc7lJ
         A9GVTR7u9/KxdbCD4r4SOgc/0lzv5hyQzBlxgK5yQh6o2YLgXxBRmDIqjAPiVsVzmQvo
         TpahKMbvLwmr9HD4xh8R+8jkBnR87HpAahbH+PTLbSovU0xyQEEH5TLJI7Y8kF2sCSs+
         LuuWroVl+rO4czq2nMmYFtOSny2nno+omXpqwf6I+aL1fFq3LTerl3xlVJDtWEG2mjWg
         xGDOD+p6n2EXDBxJmTRZBfyapqGkZW16SyW1ZbazJFZ93xhhe5TXfCvKTFAElea1iuqd
         nO3Q==
X-Gm-Message-State: ACgBeo01zUJrFHcXg+Vk9/DxgE/yF8Mg76RvT5WPn+rzMmJ/OtXW8uoJ
        mcPhxixoxhF9H1yf9WTFys4PLKvlikSG
X-Google-Smtp-Source: AA6agR7Reb+rz8coWZuWhV5Z/psyQzkhB6djteex6853ySMfywnmw+Q5549aUw1c+GhCV/Ct/1EyjWPpsYSe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8e4:a3e5:9d09:d3d4])
 (user=irogers job=sendgmr) by 2002:a81:ad06:0:b0:33f:77cf:523f with SMTP id
 l6-20020a81ad06000000b0033f77cf523fmr19164824ywh.173.1661968221618; Wed, 31
 Aug 2022 10:50:21 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:49:24 -0700
In-Reply-To: <20220831174926.579643-1-irogers@google.com>
Message-Id: <20220831174926.579643-6-irogers@google.com>
Mime-Version: 1.0
References: <20220831174926.579643-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v2 5/7] perf stat: Delay metric parsing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, ahmad.yasin@intel.com
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

Having metric parsing as part of argument processing causes issues as
flags like metric-no-group may be specified later. It also denies the
opportunity to optimize the events on SMT systems where fewer events
may be possible if we know the target is system-wide. Move metric
parsing to after command line option parsing. Because of how stat runs
this moves the parsing after record/report which fail to work with
metrics currently anyway.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 52 +++++++++++++++++++++++++----------
 tools/perf/util/metricgroup.c |  3 +-
 tools/perf/util/metricgroup.h |  2 +-
 3 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 54cd29d07ca8..a59c23f4ffd2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -191,6 +191,7 @@ static bool			append_file;
 static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
+static char			*metrics;
 
 struct perf_stat {
 	bool			 record;
@@ -1148,14 +1149,23 @@ static int enable_metric_only(const struct option *opt __maybe_unused,
 	return 0;
 }
 
-static int parse_metric_groups(const struct option *opt,
+static int append_metric_groups(const struct option *opt __maybe_unused,
 			       const char *str,
 			       int unset __maybe_unused)
 {
-	return metricgroup__parse_groups(opt, str,
-					 stat_config.metric_no_group,
-					 stat_config.metric_no_merge,
-					 &stat_config.metric_events);
+	if (metrics) {
+		char *tmp;
+
+		if (asprintf(&tmp, "%s,%s", metrics, str) < 0)
+			return -ENOMEM;
+		free(metrics);
+		metrics = tmp;
+	} else {
+		metrics = strdup(str);
+		if (!metrics)
+			return -ENOMEM;
+	}
+	return 0;
 }
 
 static int parse_control_option(const struct option *opt,
@@ -1299,7 +1309,7 @@ static struct option stat_options[] = {
 			"measure SMI cost"),
 	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
 		     "monitor specified metrics or metric groups (separated by ,)",
-		     parse_metric_groups),
+		     append_metric_groups),
 	OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
 			 "Configure all used events to run in kernel space.",
 			 PARSE_OPT_EXCLUSIVE),
@@ -1792,11 +1802,9 @@ static int add_default_attributes(void)
 		 * on an architecture test for such a metric name.
 		 */
 		if (metricgroup__has_metric("transaction")) {
-			struct option opt = { .value = &evsel_list };
-
-			return metricgroup__parse_groups(&opt, "transaction",
+			return metricgroup__parse_groups(evsel_list, "transaction",
 							 stat_config.metric_no_group,
-							stat_config.metric_no_merge,
+							 stat_config.metric_no_merge,
 							 &stat_config.metric_events);
 		}
 
@@ -2182,6 +2190,8 @@ static int __cmd_report(int argc, const char **argv)
 			input_name = "perf.data";
 	}
 
+	perf_stat__init_shadow_stats();
+
 	perf_stat.data.path = input_name;
 	perf_stat.data.mode = PERF_DATA_MODE_READ;
 
@@ -2261,8 +2271,6 @@ int cmd_stat(int argc, const char **argv)
 	argc = parse_options_subcommand(argc, argv, stat_options, stat_subcommands,
 					(const char **) stat_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
-	perf_stat__collect_metric_expr(evsel_list);
-	perf_stat__init_shadow_stats();
 
 	if (stat_config.csv_sep) {
 		stat_config.csv_output = true;
@@ -2429,6 +2437,23 @@ int cmd_stat(int argc, const char **argv)
 			target.system_wide = true;
 	}
 
+	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
+		target.per_thread = true;
+
+	/*
+	 * Metric parsing needs to be delayed as metrics may optimize events
+	 * knowing the target is system-wide.
+	 */
+	if (metrics) {
+		metricgroup__parse_groups(evsel_list, metrics,
+					stat_config.metric_no_group,
+					stat_config.metric_no_merge,
+					&stat_config.metric_events);
+		zfree(&metrics);
+	}
+	perf_stat__collect_metric_expr(evsel_list);
+	perf_stat__init_shadow_stats();
+
 	if (add_default_attributes())
 		goto out;
 
@@ -2448,9 +2473,6 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
-	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
-		target.per_thread = true;
-
 	if (evlist__fix_hybrid_cpus(evsel_list, target.cpu_list)) {
 		pr_err("failed to use cpu list %s\n", target.cpu_list);
 		goto out;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b144c3e35264..9151346a16ab 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1646,13 +1646,12 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 	return ret;
 }
 
-int metricgroup__parse_groups(const struct option *opt,
+int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      const char *str,
 			      bool metric_no_group,
 			      bool metric_no_merge,
 			      struct rblist *metric_events)
 {
-	struct evlist *perf_evlist = *(struct evlist **)opt->value;
 	const struct pmu_events_table *table = pmu_events_table__find();
 
 	if (!table)
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 016b3b1a289a..af9ceadaec0f 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -64,7 +64,7 @@ struct metric_expr {
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
 					 bool create);
-int metricgroup__parse_groups(const struct option *opt,
+int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      const char *str,
 			      bool metric_no_group,
 			      bool metric_no_merge,
-- 
2.37.2.672.g94769d06f0-goog

