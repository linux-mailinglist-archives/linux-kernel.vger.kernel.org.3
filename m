Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78244F3F55
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354305AbiDEUPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573048AbiDERt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:49:29 -0400
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F339D1113
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:47:26 -0700 (PDT)
Received: (qmail 18715 invoked by uid 989); 5 Apr 2022 17:40:45 -0000
Authentication-Results: euporie.uberspace.de;
        auth=pass (plain)
From:   Florian Fischer <florian.fischer@muhq.space>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Florian Schmaus <flow@cs.fau.de>,
        Florian Fischer <florian.fischer@muhq.space>
Subject: [PATCH] perf stat: add rusage utime and stime events
Date:   Tue,  5 Apr 2022 19:40:28 +0200
Message-Id: <20220405174028.1675025-2-florian.fischer@muhq.space>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405174028.1675025-1-florian.fischer@muhq.space>
References: <20220405174028.1675025-1-florian.fischer@muhq.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) REPLY(-4) MID_CONTAINS_FROM(1) BAYES_HAM(-2.999958)
X-Rspamd-Score: -5.599958
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Tue, 05 Apr 2022 19:40:45 +0200
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FROM_SUSPICIOUS_NTLD,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It bothered me that during benchmarking using perf stat (to collect
for example CPU cache events) I could not simultaneously retrieve the
times spend in user or kernel mode in a machine readable format.

When running perf stat the output for humans contains the times
reported by rusage and wait4.

$ perf stat -e cache-misses:u -- true

 Performance counter stats for 'true':

             4,206      cache-misses:u

       0.001113619 seconds time elapsed

       0.001175000 seconds user
       0.000000000 seconds sys

But using perf stats' machine-readable format does not provide this
information.

$ perf stat -x, -e cache-misses:u -- true
4282,,cache-misses:u,492859,100.00,,

I found no way to retrieve this information using the available events
while using machine-readable output.

To solve this I added two new tool internal events 'rusage_user_time'
and 'rusage_system_time' as well as their aliases 'ru_utime' and
'ru_stime', similarly to the already present 'duration_time' event.

Both events use the already collected rusage information obtained by wait4.

Examples presenting cache-misses and rusage information in both human and
machine-readable form:

$ ./perf stat -e duration_time,ru_utime,ru_stime,cache-misses -- grep -q -r duration_time .

 Performance counter stats for 'grep -q -r duration_time .':

        67,422,542 ns   duration_time:u
            50,517 us   ru_utime:u
            16,839 us   ru_stime:u
            30,937      cache-misses:u

       0.067422542 seconds time elapsed

       0.050517000 seconds user
       0.016839000 seconds sys

$ ./perf stat -x, -e duration_time,ru_utime,ru_stime,cache-misses -- grep -q -r duration_time .
72134524,ns,duration_time:u,72134524,100.00,,
65225,us,ru_utime:u,65225,100.00,,
6865,us,ru_stime:u,6865,100.00,,
38705,,cache-misses:u,71189328,100.00,,

Signed-off-by: Florian Fischer <florian.fischer@muhq.space>
---
 tools/perf/builtin-stat.c      | 41 ++++++++++++++++++++++++-------
 tools/perf/util/evsel.c        | 19 +++++++++------
 tools/perf/util/evsel.h        |  4 ++++
 tools/perf/util/parse-events.c | 44 +++++++++++++++++++++++++++++-----
 tools/perf/util/parse-events.l |  2 ++
 tools/perf/util/stat-shadow.c  |  2 ++
 tools/perf/util/stat.h         | 19 +++++++++++++++
 7 files changed, 109 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a96f106dc93a..c73afc8f6da5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -216,6 +216,7 @@ static struct perf_stat_config stat_config = {
 	.run_count		= 1,
 	.metric_only_len	= METRIC_ONLY_LEN,
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
+	.ru_stats		= &ru_stats,
 	.big_num		= true,
 	.ctl_fd			= -1,
 	.ctl_fd_ack		= -1,
@@ -341,15 +342,35 @@ static int evsel__write_stat_event(struct evsel *counter, int cpu_map_idx, u32 t
 static int read_single_counter(struct evsel *counter, int cpu_map_idx,
 			       int thread, struct timespec *rs)
 {
-	if (counter->tool_event == PERF_TOOL_DURATION_TIME) {
-		u64 val = rs->tv_nsec + rs->tv_sec*1000000000ULL;
-		struct perf_counts_values *count =
-			perf_counts(counter->counts, cpu_map_idx, thread);
-		count->ena = count->run = val;
-		count->val = val;
-		return 0;
+	switch(counter->tool_event) {
+		case PERF_TOOL_DURATION_TIME: {
+			u64 val = rs->tv_nsec + rs->tv_sec*1000000000ULL;
+			struct perf_counts_values *count =
+				perf_counts(counter->counts, cpu_map_idx, thread);
+			count->ena = count->run = val;
+			count->val = val;
+			return 0;
+		}
+		case PERF_TOOL_RU_UTIME:
+		case PERF_TOOL_RU_STIME: {
+			u64 val;
+			struct perf_counts_values *count =
+				perf_counts(counter->counts, cpu_map_idx, thread);
+			if (counter->tool_event == PERF_TOOL_RU_UTIME)
+				val = ru_stats.ru_utime_usec_stat.mean;
+			else
+				val = ru_stats.ru_stime_usec_stat.mean;
+			count->ena = count->run = val;
+			count->val = val;
+			return 0;
+		}
+		default:
+		case PERF_TOOL_NONE:
+			return evsel__read_counter(counter, cpu_map_idx, thread);
+		case PERF_TOOL_LAST:
+			/* this case should never be reached */
+			return 0;
 	}
-	return evsel__read_counter(counter, cpu_map_idx, thread);
 }
 
 /*
@@ -1010,8 +1031,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		evlist__reset_prev_raw_counts(evsel_list);
 		runtime_stat_reset(&stat_config);
 		perf_stat__reset_shadow_per_stat(&rt_stat);
-	} else
+	} else {
 		update_stats(&walltime_nsecs_stats, t1 - t0);
+		update_rusage_stats(&ru_stats, &stat_config.ru_data);
+	}
 
 	/*
 	 * Closing a group leader splits the group, and as we only disable
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2a1729e7aee4..26cf7e76698b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -597,6 +597,17 @@ static int evsel__sw_name(struct evsel *evsel, char *bf, size_t size)
 	return r + evsel__add_modifiers(evsel, bf + r, size - r);
 }
 
+const char *evsel__tool_names[PERF_TOOL_LAST] = {
+	"duration_time",
+	"rusage_user_time",
+	"rusage_system_time",
+};
+
+static int evsel__tool_name(enum perf_tool_event ev, char *bf, size_t size)
+{
+	return scnprintf(bf, size, "%s", evsel__tool_names[ev]);
+}
+
 static int __evsel__bp_name(char *bf, size_t size, u64 addr, u64 type)
 {
 	int r;
@@ -723,12 +734,6 @@ static int evsel__raw_name(struct evsel *evsel, char *bf, size_t size)
 	return ret + evsel__add_modifiers(evsel, bf + ret, size - ret);
 }
 
-static int evsel__tool_name(char *bf, size_t size)
-{
-	int ret = scnprintf(bf, size, "duration_time");
-	return ret;
-}
-
 const char *evsel__name(struct evsel *evsel)
 {
 	char bf[128];
@@ -754,7 +759,7 @@ const char *evsel__name(struct evsel *evsel)
 
 	case PERF_TYPE_SOFTWARE:
 		if (evsel->tool_event)
-			evsel__tool_name(bf, sizeof(bf));
+			evsel__tool_name(evsel->tool_event, bf, sizeof(bf));
 		else
 			evsel__sw_name(evsel, bf, sizeof(bf));
 		break;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 041b42d33bf5..2adb97383952 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -30,6 +30,9 @@ typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 enum perf_tool_event {
 	PERF_TOOL_NONE		= 0,
 	PERF_TOOL_DURATION_TIME = 1,
+	PERF_TOOL_RU_UTIME = 2,
+	PERF_TOOL_RU_STIME = 3,
+	PERF_TOOL_LAST
 };
 
 /** struct evsel - event selector
@@ -258,6 +261,7 @@ extern const char *evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX][EVSEL__MAX_ALI
 extern const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX][EVSEL__MAX_ALIASES];
 extern const char *evsel__hw_names[PERF_COUNT_HW_MAX];
 extern const char *evsel__sw_names[PERF_COUNT_SW_MAX];
+extern const char *evsel__tool_names[PERF_TOOL_LAST];
 extern char *evsel__bpf_counter_events;
 bool evsel__match_bpf_counter_events(const char *name);
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 24997925ae00..13db69b71187 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -154,6 +154,21 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 	},
 };
 
+struct event_symbol event_symbols_tool[PERF_TOOL_LAST] = {
+	[PERF_TOOL_DURATION_TIME] = {
+		.symbol = "duration_time",
+		.alias  = "",
+	},
+	[PERF_TOOL_RU_UTIME] = {
+		.symbol = "rusage_user_time",
+		.alias  = "ru_utime",
+	},
+	[PERF_TOOL_RU_STIME] = {
+		.symbol = "rusage_system_time",
+		.alias  = "ru_stime",
+	},
+};
+
 #define __PERF_EVENT_FIELD(config, name) \
 	((config & PERF_EVENT_##name##_MASK) >> PERF_EVENT_##name##_SHIFT)
 
@@ -406,6 +421,10 @@ static int add_event_tool(struct list_head *list, int *idx,
 		free((char *)evsel->unit);
 		evsel->unit = strdup("ns");
 	}
+	else if (tool_event == PERF_TOOL_RU_UTIME || tool_event == PERF_TOOL_RU_STIME) {
+		free((char *)evsel->unit);
+		evsel->unit = strdup("us");
+	}
 	return 0;
 }
 
@@ -3055,21 +3074,34 @@ int print_hwcache_events(const char *event_glob, bool name_only)
 	return evt_num;
 }
 
-static void print_tool_event(const char *name, const char *event_glob,
+static void print_tool_event(const struct event_symbol *syms, const char *event_glob,
 			     bool name_only)
 {
-	if (event_glob && !strglobmatch(name, event_glob))
+	if (syms->symbol == NULL)
+		return;
+
+	if (event_glob && !(strglobmatch(syms->symbol, event_glob) ||
+	      (syms->alias && strglobmatch(syms->alias, event_glob))))
 		return;
+
 	if (name_only)
-		printf("%s ", name);
-	else
+		printf("%s ", syms->symbol);
+	else {
+		char name[MAX_NAME_LEN];
+		if (syms->alias)
+			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
+		else
+			strlcpy(name, syms->symbol, MAX_NAME_LEN);
 		printf("  %-50s [%s]\n", name, "Tool event");
-
+	}
 }
 
 void print_tool_events(const char *event_glob, bool name_only)
 {
-	print_tool_event("duration_time", event_glob, name_only);
+	// Start at 1 because the first enum entry symbols no tool event
+	for (int i = 0; i < PERF_TOOL_LAST; ++i) {
+		print_tool_event(event_symbols_tool + i, event_glob, name_only);
+	}
 	if (pager_in_use())
 		printf("\n");
 }
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 5b6e4b5249cf..3c7227b8035c 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -353,6 +353,8 @@ alignment-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_AL
 emulation-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
 dummy						{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
 duration_time					{ return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
+rusage_user_time|ru_utime	{ return tool(yyscanner, PERF_TOOL_RU_UTIME); }
+rusage_system_time|ru_stime	{ return tool(yyscanner, PERF_TOOL_RU_STIME); }
 bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
 cgroup-switches					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 10af7804e482..ea4c35e4f1da 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -26,6 +26,7 @@
 
 struct runtime_stat rt_stat;
 struct stats walltime_nsecs_stats;
+struct rusage_stats ru_stats;
 
 struct saved_value {
 	struct rb_node rb_node;
@@ -199,6 +200,7 @@ void perf_stat__reset_shadow_stats(void)
 {
 	reset_stat(&rt_stat);
 	memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
+	memset(&ru_stats, 0, sizeof(ru_stats));
 }
 
 void perf_stat__reset_shadow_per_stat(struct runtime_stat *st)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 335d19cc3063..b14a45d8af63 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -108,6 +108,11 @@ struct runtime_stat {
 	struct rblist value_list;
 };
 
+struct rusage_stats {
+	struct stats ru_utime_usec_stat;
+	struct stats ru_stime_usec_stat;
+};
+
 typedef struct aggr_cpu_id (*aggr_get_id_t)(struct perf_stat_config *config, struct perf_cpu cpu);
 
 struct perf_stat_config {
@@ -148,6 +153,7 @@ struct perf_stat_config {
 	const char		*csv_sep;
 	struct stats		*walltime_nsecs_stats;
 	struct rusage		 ru_data;
+	struct rusage_stats		 *ru_stats;
 	struct cpu_aggr_map	*aggr_map;
 	aggr_get_id_t		 aggr_get_id;
 	struct cpu_aggr_map	*cpus_aggr_map;
@@ -177,6 +183,18 @@ static inline void init_stats(struct stats *stats)
 	stats->max  = 0;
 }
 
+static inline void init_rusage_stats(struct rusage_stats *ru_stats) {
+	init_stats(&ru_stats->ru_utime_usec_stat);
+	init_stats(&ru_stats->ru_stime_usec_stat);
+}
+
+static inline void update_rusage_stats(struct rusage_stats *ru_stats, struct rusage* rusage) {
+	update_stats(&ru_stats->ru_utime_usec_stat,
+	             (rusage->ru_utime.tv_usec + rusage->ru_utime.tv_sec * 1000000ULL));
+	update_stats(&ru_stats->ru_stime_usec_stat,
+	             (rusage->ru_stime.tv_usec + rusage->ru_stime.tv_sec * 1000000ULL));
+}
+
 struct evsel;
 struct evlist;
 
@@ -196,6 +214,7 @@ bool __perf_stat_evsel__is(struct evsel *evsel, enum perf_stat_evsel_id id);
 
 extern struct runtime_stat rt_stat;
 extern struct stats walltime_nsecs_stats;
+extern struct rusage_stats ru_stats;
 
 typedef void (*print_metric_t)(struct perf_stat_config *config,
 			       void *ctx, const char *color, const char *unit,
-- 
2.35.1

