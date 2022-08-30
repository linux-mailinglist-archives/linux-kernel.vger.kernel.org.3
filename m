Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597C85A68C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiH3QuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiH3QuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:50:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8763B8F16
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:49:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s15-20020a5b044f000000b00680c4eb89f1so170325ybp.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=UaYLGnXSHOjhMWZ30heQH6ZXdh5cOP0FJqcTp4jtF4w=;
        b=oTN9KhHjcP0AfblEbs3Q7NbkeKAyOaKREksXavFwUQxmsgajHOMpG8RNoVjleKBAgM
         Ebs10bqWy1dYxrCQvDyivOwPcvK0DV6slhJSpIKoxwAWlQkcXCS3SPhlnR3Q58E3rjxy
         9LefxvaqfDh3W8r0VBvBnqIT7mfPHvR2uqwQXQR9aP5bx/06QW6MxhipI7jztgL2T9ra
         6TPP+Xa2mZEJzzUP8NTo1kC98RGLYfl+v9r26juXPkh4LduIGJtnqIaA7JWKMZNtsXc9
         TSmciWithtMWhS9Uyn5OqIV+pkoOLtUKzu2yFOiMVieu42u+26PQzW/jZEGz9LJDHR4S
         jLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=UaYLGnXSHOjhMWZ30heQH6ZXdh5cOP0FJqcTp4jtF4w=;
        b=mwRxAr3yLCZVtg/WNckorjZGObFq5yKmfpGaNoiiPPCLMsIUgn3D5Vdkp6AztsDB6+
         dbmc1Pd5aW+zi5JQIDJ3Q2Mzgvm4IZ/OYSpzG4MtEBIOpomnZJVy6zxLnXxLwfKWEkba
         r+YTcOUMJ23cSTUi92Oceodmqb0PQ1pAEMOE7bXIszM2u0dsb6K7rx7smNoGGo5V1KI+
         jTGLjgtuaseA8K/NURtLfsjRpds4oKOqfItvmoUQZMJlIqNHZ9IfoBYRmCts83pR0tc6
         6zXkoiSGyzp7YlSZFPiMyMmCOCmuqC+OjDFzAYtH0htsO7tG5jD0MmwIbR4kmrrqYj88
         nzRQ==
X-Gm-Message-State: ACgBeo39JoslByYeu2D3DASfk1AZsnJztxF4+c6kUjIpglwHaKvWLoN/
        PB87y0QwbUjeV3eoAr8VxE03B15UqL7q
X-Google-Smtp-Source: AA6agR6J1O+V+Nt9fLvS8RK117oZYQF/w6JmVykwj5TdihpD8bEuo6Mwfx2VdXnkW03hDBYVcuAqjfMvlXkv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:902c:b0fa:dec9:8767])
 (user=irogers job=sendgmr) by 2002:a5b:e8c:0:b0:696:4b76:3c with SMTP id
 z12-20020a5b0e8c000000b006964b76003cmr12540073ybr.168.1661878177917; Tue, 30
 Aug 2022 09:49:37 -0700 (PDT)
Date:   Tue, 30 Aug 2022 09:48:44 -0700
In-Reply-To: <20220830164846.401143-1-irogers@google.com>
Message-Id: <20220830164846.401143-7-irogers@google.com>
Mime-Version: 1.0
References: <20220830164846.401143-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v1 6/8] perf stat: Delay metric parsing
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
        kshipra.bopardikar@intel.com
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
 tools/perf/builtin-stat.c     | 48 ++++++++++++++++++++++++-----------
 tools/perf/util/metricgroup.c |  3 +--
 tools/perf/util/metricgroup.h |  2 +-
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7fb81a44672d..c813b1aa7d7c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -191,6 +191,7 @@ static bool			append_file;
 static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
+static char			*metrics;
 
 struct perf_stat {
 	bool			 record;
@@ -1147,14 +1148,21 @@ static int enable_metric_only(const struct option *opt __maybe_unused,
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
+	}
+	return 0;
 }
 
 static int parse_control_option(const struct option *opt,
@@ -1298,7 +1306,7 @@ static struct option stat_options[] = {
 			"measure SMI cost"),
 	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
 		     "monitor specified metrics or metric groups (separated by ,)",
-		     parse_metric_groups),
+		     append_metric_groups),
 	OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
 			 "Configure all used events to run in kernel space.",
 			 PARSE_OPT_EXCLUSIVE),
@@ -1791,11 +1799,9 @@ static int add_default_attributes(void)
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
 
@@ -2260,8 +2266,6 @@ int cmd_stat(int argc, const char **argv)
 	argc = parse_options_subcommand(argc, argv, stat_options, stat_subcommands,
 					(const char **) stat_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
-	perf_stat__collect_metric_expr(evsel_list);
-	perf_stat__init_shadow_stats();
 
 	if (stat_config.csv_sep) {
 		stat_config.csv_output = true;
@@ -2428,6 +2432,23 @@ int cmd_stat(int argc, const char **argv)
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
 
@@ -2447,9 +2468,6 @@ int cmd_stat(int argc, const char **argv)
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

