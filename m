Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B524F5DAF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiDFL74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiDFL6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:58:21 -0400
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217975282EA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:29:21 -0700 (PDT)
Received: (qmail 8348 invoked by uid 989); 6 Apr 2022 07:29:20 -0000
Authentication-Results: euporie.uberspace.de;
        auth=pass (plain)
From:   Florian Fischer <florian.fischer@muhq.space>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Florian Schmaus <flow@cs.fau.de>,
        Florian Fischer <florian.fischer@muhq.space>
Subject: [PATCH v2 2/4] perf stat: add rusage utime and stime events
Date:   Wed,  6 Apr 2022 09:28:37 +0200
Message-Id: <20220406072839.107519-3-florian.fischer@muhq.space>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406072839.107519-1-florian.fischer@muhq.space>
References: <YkybjsCKyWkDZGX+@kernel.org>
 <20220406072839.107519-1-florian.fischer@muhq.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) REPLY(-4) MID_CONTAINS_FROM(1) BAYES_HAM(-2.640885)
X-Rspamd-Score: -5.240885
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Wed, 06 Apr 2022 09:29:20 +0200
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

But perf stat's machine-readable format does not provide this information.

$ perf stat -x, -e cache-misses:u -- true
4282,,cache-misses:u,492859,100.00,,

I found no way to retrieve this information using the available events
while using machine-readable output.

This patch adds two new tool internal events 'rusage_user_time'
and 'rusage_system_time' as well as their aliases 'ru_utime' and
'ru_stime', similarly to the already present 'duration_time' event.

Both events use the already collected rusage information obtained by wait4
and tracked in the global ru_stats.

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
 tools/perf/builtin-stat.c      | 36 ++++++++++++++++++++++++++--------
 tools/perf/util/evsel.h        |  3 +++
 tools/perf/util/parse-events.l |  2 ++
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 61faffb535f5..c73afc8f6da5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -342,15 +342,35 @@ static int evsel__write_stat_event(struct evsel *counter, int cpu_map_idx, u32 t
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
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 041b42d33bf5..e89b1224ae61 100644
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
 
-- 
2.35.1

