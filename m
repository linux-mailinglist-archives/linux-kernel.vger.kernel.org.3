Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382B05085D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377635AbiDTK1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348560AbiDTK1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:27:16 -0400
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F153F32A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:24:29 -0700 (PDT)
Received: (qmail 15638 invoked by uid 989); 20 Apr 2022 10:24:27 -0000
Authentication-Results: euporie.uberspace.de;
        auth=pass (plain)
From:   Florian Fischer <florian.fischer@muhq.space>
To:     linux-perf-users@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Florian Fischer <florian.fischer@muhq.space>
Subject: [PATCH v4 1/3] perf stat: introduce stats for the user and system rusage times
Date:   Wed, 20 Apr 2022 12:23:52 +0200
Message-Id: <20220420102354.468173-2-florian.fischer@muhq.space>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220420102354.468173-1-florian.fischer@muhq.space>
References: <20220420102354.468173-1-florian.fischer@muhq.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) REPLY(-4) MID_CONTAINS_FROM(1) BAYES_HAM(-2.999999)
X-Rspamd-Score: -5.599999
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Wed, 20 Apr 2022 12:24:27 +0200
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FROM_SUSPICIOUS_NTLD,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preparation for exporting rusage values as tool events.

Add new global stats tracking the values obtained via rusage.
For now only ru_utime and ru_stime are part of the tracked stats.
Both are stored as nanoseconds to be consistent with 'duration_time',
although the finest resolution the struct timeval data in rusage
provides are microseconds.

Signed-off-by: Florian Fischer <florian.fischer@muhq.space>
---
 tools/perf/builtin-stat.c     |  5 ++++-
 tools/perf/util/stat-shadow.c |  2 ++
 tools/perf/util/stat.h        | 21 +++++++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a96f106dc93a..61faffb535f5 100644
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
@@ -1010,8 +1011,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
index 335d19cc3063..e31c94d952e9 100644
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
@@ -177,6 +183,20 @@ static inline void init_stats(struct stats *stats)
 	stats->max  = 0;
 }
 
+static inline void init_rusage_stats(struct rusage_stats *ru_stats) {
+	init_stats(&ru_stats->ru_utime_usec_stat);
+	init_stats(&ru_stats->ru_stime_usec_stat);
+}
+
+static inline void update_rusage_stats(struct rusage_stats *ru_stats, struct rusage* rusage) {
+	const u64 us_to_ns = 1000;
+	const u64 s_to_ns = 1000000000;
+	update_stats(&ru_stats->ru_utime_usec_stat,
+	             (rusage->ru_utime.tv_usec * us_to_ns + rusage->ru_utime.tv_sec * s_to_ns));
+	update_stats(&ru_stats->ru_stime_usec_stat,
+	             (rusage->ru_stime.tv_usec * us_to_ns + rusage->ru_stime.tv_sec * s_to_ns));
+}
+
 struct evsel;
 struct evlist;
 
@@ -196,6 +216,7 @@ bool __perf_stat_evsel__is(struct evsel *evsel, enum perf_stat_evsel_id id);
 
 extern struct runtime_stat rt_stat;
 extern struct stats walltime_nsecs_stats;
+extern struct rusage_stats ru_stats;
 
 typedef void (*print_metric_t)(struct perf_stat_config *config,
 			       void *ctx, const char *color, const char *unit,
-- 
2.36.0

