Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6445278ED
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 19:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbiEORga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 13:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbiEORgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 13:36:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE07EA4
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 10:36:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f8398e99dcso112828797b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hr4Kx7vz6eiJv03wCUlPh5MzpIVWGg8R+A3dGgGPS38=;
        b=n1oZmt9vKhZ8MrXqiGCfgmEA3X+7wZPRYgN9YaF9GdfrgTGY7Nji56ByYWFgdk01tX
         H9PJQ+pqIuGglmMdmBEBm7BeUEwD9j0e0FCHsBVsdfCWVcirLGQLo+40Neb7+K4y3Pm+
         /0UMaI1JNRAz7LbqlnvbATxrr59G0NqAaaBhn7yqIl4uKHQvAxp3abvEpMXRvpGxQIt2
         4oErSPhvy+LQTV6FW2EIgZR+Mr45HLUn/juap6CxoKEbPS0CUw/AaEomPi+c3EeP++ei
         cnexEhaIzRNCwbpbmwTI97mMh3RH/zht93vODrKYlkUAW2s1SJoJVDFWvNaVJ8UW+qe6
         a9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hr4Kx7vz6eiJv03wCUlPh5MzpIVWGg8R+A3dGgGPS38=;
        b=ixfAXWmsY+izx3/+Glm4IL98JuobpnPmbBHswqvmjlpMkz61L42SnO+gzOORLYp5ZB
         eBuEqOVQvKA4wTGbkUJtR/WK9v6X/hjEUy+pR6bGb/mJWGjVHnMVzRzLnsvLrHBR6+Hc
         j3n6WItTthSUHKQGRMDoT5MjsGsr45TFWrgJXQDuRo6NfABpohgbsDUHm1q91nQl6cOD
         TQE8ZrXFefBm5gnSTY/1OVFhDdgZpZBCG5Neib8UDYBKmNLuk2pVasLDivAWfExOwDSB
         0X7uEZ87XTm9LGTKMobbps7mYh08/5TWXtlemDcjPcSVgeqcbzuCroxrhUTOViYs20Po
         q7wQ==
X-Gm-Message-State: AOAM533AiCJVyacw9w2nmBUZMvwnYEhC/Ybs+MsrjTmF0/xYne+HxyHh
        cudzT9dYbC5BAZvhtfqHKSM0z71N29G7
X-Google-Smtp-Source: ABdhPJzlF5oeN3nVNL66T/oTY6hSRCPBKV0NYuUXA57xITSz3XQIZD0GmeMksj2Gx4v90cBlM9KP/TOKpOwv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2a5e:db66:d206:cbaf])
 (user=irogers job=sendgmr) by 2002:a25:da84:0:b0:648:423e:57b0 with SMTP id
 n126-20020a25da84000000b00648423e57b0mr13984604ybf.137.1652636168440; Sun, 15
 May 2022 10:36:08 -0700 (PDT)
Date:   Sun, 15 May 2022 10:35:57 -0700
In-Reply-To: <20220515173558.2289702-1-irogers@google.com>
Message-Id: <20220515173558.2289702-2-irogers@google.com>
Mime-Version: 1.0
References: <20220515173558.2289702-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 1/2] perf stat: Add JSON output option
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>
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

From: Claire Jensen <cjense@google.com>

CSV output is tricky to format and column layout changes are susceptible
to breaking parsers. New JSON-formatted output has variable names to
identify fields that are consistent and informative, making
the output parseable.

CSV output example:

1.20,msec,task-clock:u,1204272,100.00,0.697,CPUs utilized
0,,context-switches:u,1204272,100.00,0.000,/sec
0,,cpu-migrations:u,1204272,100.00,0.000,/sec
70,,page-faults:u,1204272,100.00,58.126,K/sec

JSON output example:

{"counter-value" : "3805.723968", "unit" : "msec", "event" :
"cpu-clock", "event-runtime" : 3805731510100.00, "pcnt-running"
: 100.00, "metric-value" : 4.007571, "metric-unit" : "CPUs utilized"}
{"counter-value" : "6166.000000", "unit" : "", "event" :
"context-switches", "event-runtime" : 3805723045100.00, "pcnt-running"
: 100.00, "metric-value" : 1.620191, "metric-unit" : "K/sec"}
{"counter-value" : "466.000000", "unit" : "", "event" :
"cpu-migrations", "event-runtime" : 3805727613100.00, "pcnt-running"
: 100.00, "metric-value" : 122.447136, "metric-unit" : "/sec"}
{"counter-value" : "208.000000", "unit" : "", "event" :
"page-faults", "event-runtime" : 3805726799100.00, "pcnt-running"
: 100.00, "metric-value" : 54.654516, "metric-unit" : "/sec"}

Also added documentation for JSON option.

Signed-off-by: Claire Jensen <cjense@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-stat.txt |  21 ++
 tools/perf/builtin-stat.c              |   2 +
 tools/perf/util/stat-display.c         | 365 +++++++++++++++++++------
 tools/perf/util/stat.h                 |   1 +
 4 files changed, 303 insertions(+), 86 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 8d1cde00b8d6..f9cdfd912b05 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -570,6 +570,27 @@ Additional metrics may be printed with all earlier fields being empty.
 
 include::intel-hybrid.txt[]
 
+JSON FORMAT
+-----------
+
+With -j, perf stat is able to print out a JSON format output
+that can be used for parsing.
+
+- timestamp : optional usec time stamp in fractions of second (with -I)
+- optional aggregate options:
+		- core : core identifier (with --per-core)
+		- die : die identifier (with --per-die)
+		- socket : socket identifier (with --per-socket)
+		- node : node identifier (with --per-node)
+		- thread : thread identifier (with --per-thread)
+- counter-value : counter value
+- unit : unit of the counter value or empty
+- event : event name
+- variance : optional variance if multiple values are collected (with -r)
+- runtime : run time of counter
+- metric-value : optional metric value
+- metric-unit : optional unit of metric
+
 SEE ALSO
 --------
 linkperf:perf-top[1], linkperf:perf-list[1]
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1b96636df01e..0855f763d17d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1262,6 +1262,8 @@ static struct option stat_options[] = {
 		    "Merge identical named hybrid events"),
 	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
 		   "print counts with custom separator"),
+	OPT_BOOLEAN('j', "json-output", &stat_config.json_output,
+		   "print counts in JSON format"),
 	OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
 		     "monitor event in cgroup name only", parse_stat_cgroups),
 	OPT_STRING(0, "for-each-cgroup", &stat_config.cgroup_list, "name",
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 98669ca5a86b..1e93094146cd 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -28,15 +28,21 @@
 static void print_running(struct perf_stat_config *config,
 			  u64 run, u64 ena)
 {
-	if (config->csv_output) {
-		fprintf(config->output, "%s%" PRIu64 "%s%.2f",
-					config->csv_sep,
-					run,
-					config->csv_sep,
-					ena ? 100.0 * run / ena : 100.0);
-	} else if (run != ena) {
+
+	double enabled_percent = 100;
+
+	if (run != ena)
+		enabled_percent = 100 * run / ena;
+	if (config->json_output)
+		fprintf(config->output,
+			"\"event-runtime\" : %lu, \"pcnt-running\" : %.2f, ",
+			run, enabled_percent);
+	else if (config->csv_output)
+		fprintf(config->output,
+			"%s%" PRIu64 "%s%.2f", config->csv_sep,
+			run, config->csv_sep, enabled_percent);
+	else if (run != ena)
 		fprintf(config->output, "  (%.2f%%)", 100.0 * run / ena);
-	}
 }
 
 static void print_noise_pct(struct perf_stat_config *config,
@@ -44,7 +50,9 @@ static void print_noise_pct(struct perf_stat_config *config,
 {
 	double pct = rel_stddev_stats(total, avg);
 
-	if (config->csv_output)
+	if (config->json_output)
+		fprintf(config->output, "\"variance\" : %.2f, ", pct);
+	else if (config->csv_output)
 		fprintf(config->output, "%s%.2f%%", config->csv_sep, pct);
 	else if (pct)
 		fprintf(config->output, "  ( +-%6.2f%% )", pct);
@@ -66,7 +74,11 @@ static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
 {
 	if (nr_cgroups) {
 		const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
-		fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
+
+		if (config->json_output)
+			fprintf(config->output, "\"cgroup\" : \"%s\", ", cgrp_name);
+		else
+			fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
 	}
 }
 
@@ -74,66 +86,119 @@ static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
 static void aggr_printout(struct perf_stat_config *config,
 			  struct evsel *evsel, struct aggr_cpu_id id, int nr)
 {
+
+
+	if (config->json_output && !config->interval)
+		fprintf(config->output, "{");
+
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
-		fprintf(config->output, "S%d-D%d-C%*d%s%*d%s",
-			id.socket,
-			id.die,
-			config->csv_output ? 0 : -8,
-			id.core,
-			config->csv_sep,
-			config->csv_output ? 0 : 4,
-			nr,
-			config->csv_sep);
+		if (config->json_output) {
+			fprintf(config->output,
+				"\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
+				id.socket,
+				id.die,
+				id.core,
+				nr);
+		} else {
+			fprintf(config->output, "S%d-D%d-C%*d%s%*d%s",
+				id.socket,
+				id.die,
+				config->csv_output ? 0 : -8,
+				id.core,
+				config->csv_sep,
+				config->csv_output ? 0 : 4,
+				nr,
+				config->csv_sep);
+		}
 		break;
 	case AGGR_DIE:
-		fprintf(config->output, "S%d-D%*d%s%*d%s",
-			id.socket,
-			config->csv_output ? 0 : -8,
-			id.die,
-			config->csv_sep,
-			config->csv_output ? 0 : 4,
-			nr,
-			config->csv_sep);
+		if (config->json_output) {
+			fprintf(config->output,
+				"\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d, ",
+				id.socket,
+				id.die,
+				nr);
+		} else {
+			fprintf(config->output, "S%d-D%*d%s%*d%s",
+				id.socket,
+				config->csv_output ? 0 : -8,
+				id.die,
+				config->csv_sep,
+				config->csv_output ? 0 : 4,
+				nr,
+				config->csv_sep);
+		}
 		break;
 	case AGGR_SOCKET:
-		fprintf(config->output, "S%*d%s%*d%s",
-			config->csv_output ? 0 : -5,
-			id.socket,
-			config->csv_sep,
-			config->csv_output ? 0 : 4,
-			nr,
-			config->csv_sep);
-			break;
+		if (config->json_output) {
+			fprintf(config->output,
+				"\"socket\" : \"S%d\", \"aggregate-number\" : %d, ",
+				id.socket,
+				nr);
+		} else {
+			fprintf(config->output, "S%*d%s%*d%s",
+				config->csv_output ? 0 : -5,
+				id.socket,
+				config->csv_sep,
+				config->csv_output ? 0 : 4,
+				nr,
+				config->csv_sep);
+		}
+		break;
 	case AGGR_NODE:
-		fprintf(config->output, "N%*d%s%*d%s",
-			config->csv_output ? 0 : -5,
-			id.node,
-			config->csv_sep,
-			config->csv_output ? 0 : 4,
-			nr,
-			config->csv_sep);
-			break;
+		if (config->json_output) {
+			fprintf(config->output, "\"node\" : \"N%d\", \"aggregate-number\" : %d, ",
+				id.node,
+				nr);
+		} else {
+			fprintf(config->output, "N%*d%s%*d%s",
+				config->csv_output ? 0 : -5,
+				id.node,
+				config->csv_sep,
+				config->csv_output ? 0 : 4,
+				nr,
+				config->csv_sep);
+		}
+		break;
 	case AGGR_NONE:
-		if (evsel->percore && !config->percore_show_thread) {
-			fprintf(config->output, "S%d-D%d-C%*d%s",
-				id.socket,
-				id.die,
-				config->csv_output ? 0 : -3,
-				id.core, config->csv_sep);
-		} else if (id.cpu.cpu > -1) {
-			fprintf(config->output, "CPU%*d%s",
-				config->csv_output ? 0 : -7,
-				id.cpu.cpu, config->csv_sep);
+		if (config->json_output) {
+			if (evsel->percore && !config->percore_show_thread) {
+				fprintf(config->output, "\"core\" : \"S%d-D%d-C%d\"",
+					id.socket,
+					id.die,
+					id.core);
+			} else if (id.core > -1) {
+				fprintf(config->output, "\"cpu\" : \"%d\", ",
+					id.cpu.cpu);
+			}
+		} else {
+			if (evsel->percore && !config->percore_show_thread) {
+				fprintf(config->output, "S%d-D%d-C%*d%s",
+					id.socket,
+					id.die,
+					config->csv_output ? 0 : -3,
+					id.core, config->csv_sep);
+			} else if (id.core > -1) {
+				fprintf(config->output, "CPU%*d%s",
+					config->csv_output ? 0 : -7,
+					id.cpu.cpu, config->csv_sep);
+			}
 		}
 		break;
 	case AGGR_THREAD:
-		fprintf(config->output, "%*s-%*d%s",
-			config->csv_output ? 0 : 16,
-			perf_thread_map__comm(evsel->core.threads, id.thread),
-			config->csv_output ? 0 : -8,
-			perf_thread_map__pid(evsel->core.threads, id.thread),
-			config->csv_sep);
+		if (config->json_output) {
+			fprintf(config->output, "\"thread\" : \"%s-%d\", ",
+				perf_thread_map__comm(evsel->core.threads, id.thread),
+				perf_thread_map__pid(evsel->core.threads, id.thread));
+		} else {
+			fprintf(config->output, "%*s-%*d%s",
+				config->csv_output ? 0 : 16,
+				perf_thread_map__comm(evsel->core.threads, id.thread),
+				config->csv_output ? 0 : -8,
+				perf_thread_map__pid(evsel->core.threads, id.thread),
+				config->csv_sep);
+		}
 		break;
 	case AGGR_GLOBAL:
 	case AGGR_UNSET:
@@ -234,6 +299,31 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
 	fprintf(out, "%s%s%s%s", config->csv_sep, vals, config->csv_sep, skip_spaces(unit));
 }
 
+static void print_metric_json(struct perf_stat_config *config __maybe_unused,
+			     void *ctx,
+			     const char *color __maybe_unused,
+			     const char *fmt __maybe_unused,
+			     const char *unit, double val)
+{
+	struct outstate *os = ctx;
+	FILE *out = os->fh;
+
+	fprintf(out, "\"metric-value\" : %f, ", val);
+	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
+	if (!config->metric_only)
+		fprintf(out, "}");
+}
+
+static void new_line_json(struct perf_stat_config *config, void *ctx)
+{
+	struct outstate *os = ctx;
+
+	fputc('\n', os->fh);
+	if (os->prefix)
+		fprintf(os->fh, "%s", os->prefix);
+	aggr_printout(config, os->evsel, os->id, os->nr);
+}
+
 /* Filter out some columns that don't work well in metrics only mode */
 
 static bool valid_only_metric(const char *unit)
@@ -300,6 +390,27 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
 	fprintf(out, "%s%s", vals, config->csv_sep);
 }
 
+static void print_metric_only_json(struct perf_stat_config *config __maybe_unused,
+				  void *ctx, const char *color __maybe_unused,
+				  const char *fmt,
+				  const char *unit, double val)
+{
+	struct outstate *os = ctx;
+	FILE *out = os->fh;
+	char buf[64], *vals, *ends;
+	char tbuf[1024];
+
+	if (!valid_only_metric(unit))
+		return;
+	unit = fixunit(tbuf, os->evsel, unit);
+	snprintf(buf, sizeof(buf), fmt, val);
+	ends = vals = skip_spaces(buf);
+	while (isdigit(*ends) || *ends == '.')
+		ends++;
+	*ends = 0;
+	fprintf(out, "{\"metric-value\" : \"%s\"}", vals);
+}
+
 static void new_line_metric(struct perf_stat_config *config __maybe_unused,
 			    void *ctx __maybe_unused)
 {
@@ -318,10 +429,13 @@ static void print_metric_header(struct perf_stat_config *config,
 	    os->evsel->priv != os->evsel->evlist->selected->priv)
 		return;
 
-	if (!valid_only_metric(unit))
+	if (!valid_only_metric(unit) && !config->json_output)
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
-	if (config->csv_output)
+
+	if (config->json_output)
+		fprintf(os->fh, "\"unit\" : \"%s\"", unit);
+	else if (config->csv_output)
 		fprintf(os->fh, "%s%s", unit, config->csv_sep);
 	else
 		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
@@ -367,14 +481,28 @@ static void abs_printout(struct perf_stat_config *config,
 
 	aggr_printout(config, evsel, id, nr);
 
-	fprintf(output, fmt, avg, config->csv_sep);
+	if (config->json_output)
+		fprintf(output, "\"counter-value\" : \"%f\", ", avg);
+	else
+		fprintf(output, fmt, avg, config->csv_sep);
+
+	if (config->json_output) {
+		if (evsel->unit) {
+			fprintf(output, "\"unit\" : \"%s\", ",
+				evsel->unit);
+		}
+	} else {
+		if (evsel->unit)
+			fprintf(output, "%-*s%s",
+				config->csv_output ? 0 : config->unit_width,
+				evsel->unit, config->csv_sep);
+	}
 
-	if (evsel->unit)
-		fprintf(output, "%-*s%s",
-			config->csv_output ? 0 : config->unit_width,
-			evsel->unit, config->csv_sep);
 
-	fprintf(output, "%-*s", config->csv_output ? 0 : 25, evsel__name(evsel));
+	if (config->json_output)
+		fprintf(output, "\"event\" : \"%s\", ", evsel__name(evsel));
+	else
+		fprintf(output, "%-*s", config->csv_output ? 0 : 25, evsel__name(evsel));
 
 	print_cgroup(config, evsel);
 }
@@ -423,6 +551,8 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 		nl = new_line_metric;
 		if (config->csv_output)
 			pm = print_metric_only_csv;
+		else if (config->json_output)
+			pm = print_metric_only_json;
 		else
 			pm = print_metric_only;
 	} else
@@ -446,6 +576,24 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 			os.nfields++;
 	}
 
+	if (config->json_output && !config->metric_only) {
+		static const int aggr_fields[] = {
+			[AGGR_GLOBAL] = 0,
+			[AGGR_THREAD] = 1,
+			[AGGR_NONE] = 1,
+			[AGGR_SOCKET] = 2,
+			[AGGR_DIE] = 2,
+			[AGGR_CORE] = 2,
+		};
+
+		pm = print_metric_json;
+		nl = new_line_json;
+		os.nfields = 3;
+		os.nfields += aggr_fields[config->aggr_mode];
+		if (counter->cgrp)
+			os.nfields++;
+	}
+
 	if (!config->no_csv_summary && config->csv_output &&
 	    config->summary && !config->interval) {
 		fprintf(config->output, "%16s%s", "summary", config->csv_sep);
@@ -458,10 +606,15 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 		}
 		aggr_printout(config, counter, id, nr);
 
-		fprintf(config->output, "%*s%s",
-			config->csv_output ? 0 : 18,
-			counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED,
-			config->csv_sep);
+		if (config->json_output) {
+			fprintf(config->output, "\"counter-value\" : \"%s\", ",
+					counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED);
+		} else {
+			fprintf(config->output, "%*s%s",
+				config->csv_output ? 0 : 18,
+				counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED,
+				config->csv_sep);
+		}
 
 		if (counter->supported) {
 			if (!evlist__has_hybrid(counter->evlist)) {
@@ -471,21 +624,32 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 			}
 		}
 
-		fprintf(config->output, "%-*s%s",
-			config->csv_output ? 0 : config->unit_width,
-			counter->unit, config->csv_sep);
+		if (config->json_output) {
+			fprintf(config->output, "\"unit\" : \"%s\", ", counter->unit);
+		} else {
+			fprintf(config->output, "%-*s%s",
+				config->csv_output ? 0 : config->unit_width,
+				counter->unit, config->csv_sep);
+		}
 
-		fprintf(config->output, "%*s",
-			config->csv_output ? 0 : -25, evsel__name(counter));
+		if (config->json_output) {
+			fprintf(config->output, "\"event\" : \"%s\", ",
+				evsel__name(counter));
+		} else {
+			fprintf(config->output, "%*s",
+				 config->csv_output ? 0 : -25, evsel__name(counter));
+		}
 
 		print_cgroup(config, counter);
 
-		if (!config->csv_output)
+		if (!config->csv_output && !config->json_output)
 			pm(config, &os, NULL, NULL, "", 0);
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
 		if (config->csv_output)
 			pm(config, &os, NULL, NULL, "", 0);
+		else if (config->json_output)
+			pm(config, &os, NULL, NULL, "", 0);
 		return;
 	}
 
@@ -500,12 +664,15 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 	if (config->csv_output && !config->metric_only) {
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
+	} else if (config->json_output && !config->metric_only) {
+		print_noise(config, counter, noise);
+		print_running(config, run, ena);
 	}
 
 	perf_stat__print_shadow_stats(config, counter, uval,
 				first_shadow_cpu_map_idx(config, counter, &id),
 				&out, &config->metric_events, st);
-	if (!config->csv_output && !config->metric_only) {
+	if (!config->csv_output && !config->metric_only && !config->json_output) {
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
 	}
@@ -1002,8 +1169,12 @@ static void print_metric_headers(struct perf_stat_config *config,
 	struct outstate os = {
 		.fh = config->output
 	};
+	bool first = true;
 
-	if (prefix)
+		if (config->json_output && !config->interval)
+			fprintf(config->output, "{");
+
+	if (prefix && !config->json_output)
 		fprintf(config->output, "%s", prefix);
 
 	if (!config->csv_output && !no_indent)
@@ -1023,6 +1194,9 @@ static void print_metric_headers(struct perf_stat_config *config,
 		os.evsel = counter;
 		out.ctx = &os;
 		out.print_metric = print_metric_header;
+		if (!first && config->json_output)
+			fprintf(config->output, ", ");
+		first = false;
 		out.new_line = new_line_metric;
 		out.force_header = true;
 		perf_stat__print_shadow_stats(config, counter, 0,
@@ -1031,6 +1205,8 @@ static void print_metric_headers(struct perf_stat_config *config,
 					      &config->metric_events,
 					      &rt_stat);
 	}
+	if (config->json_output)
+		fprintf(config->output, "}");
 	fputc('\n', config->output);
 }
 
@@ -1046,10 +1222,18 @@ static void print_interval(struct perf_stat_config *config,
 	if (config->interval_clear)
 		puts(CONSOLE_CLEAR);
 
-	if (!config->iostat_run)
-		sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
-
-	if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
+	if (!config->iostat_run && !config->json_output)
+		sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec,
+				 ts->tv_nsec, config->csv_sep);
+	if (!config->iostat_run && config->json_output && !config->metric_only)
+		sprintf(prefix, "{\"interval\" : %lu.%09lu, ", (unsigned long)
+				 ts->tv_sec, ts->tv_nsec);
+	if (!config->iostat_run && config->json_output && config->metric_only)
+		sprintf(prefix, "{\"interval\" : %lu.%09lu}", (unsigned long)
+				 ts->tv_sec, ts->tv_nsec);
+
+	if ((num_print_interval == 0 && !config->csv_output && !config->json_output)
+			 || config->interval_clear) {
 		switch (config->aggr_mode) {
 		case AGGR_NODE:
 			fprintf(output, "#           time node   cpus");
@@ -1093,8 +1277,14 @@ static void print_interval(struct perf_stat_config *config,
 		}
 	}
 
-	if ((num_print_interval == 0 || config->interval_clear) && metric_only)
+	if ((num_print_interval == 0 || config->interval_clear)
+			 && metric_only && !config->json_output)
 		print_metric_headers(config, evlist, " ", true);
+	if ((num_print_interval == 0 || config->interval_clear)
+			 && metric_only && config->json_output) {
+		fprintf(output, "{");
+		print_metric_headers(config, evlist, " ", true);
+	}
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
 }
@@ -1108,7 +1298,7 @@ static void print_header(struct perf_stat_config *config,
 
 	fflush(stdout);
 
-	if (!config->csv_output) {
+	if (!config->csv_output && !config->json_output) {
 		fprintf(output, "\n");
 		fprintf(output, " Performance counter stats for ");
 		if (_target->bpf_str)
@@ -1301,6 +1491,9 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 			num_print_iv = 0;
 		if (config->aggr_mode == AGGR_GLOBAL && prefix && !config->iostat_run)
 			fprintf(config->output, "%s", prefix);
+
+		if (config->json_output && !config->metric_only)
+			fprintf(config->output, "}");
 	}
 
 	switch (config->aggr_mode) {
@@ -1344,7 +1537,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		break;
 	}
 
-	if (!interval && !config->csv_output)
+	if (!interval && !config->csv_output && !config->json_output)
 		print_footer(config);
 
 	fflush(config->output);
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b5aeb8e6d34b..09120337cdba 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -121,6 +121,7 @@ struct perf_stat_config {
 	bool			 no_inherit;
 	bool			 identifier;
 	bool			 csv_output;
+	bool			 json_output;
 	bool			 interval_clear;
 	bool			 metric_only;
 	bool			 null_run;
-- 
2.36.0.550.gb090851708-goog

