Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7205085D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377684AbiDTK1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359472AbiDTK1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:27:17 -0400
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789753F885
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:24:31 -0700 (PDT)
Received: (qmail 15788 invoked by uid 989); 20 Apr 2022 10:24:29 -0000
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
Subject: [PATCH v4 3/3] perf list: print all available tool events
Date:   Wed, 20 Apr 2022 12:23:54 +0200
Message-Id: <20220420102354.468173-4-florian.fischer@muhq.space>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220420102354.468173-1-florian.fischer@muhq.space>
References: <20220420102354.468173-1-florian.fischer@muhq.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) REPLY(-4) MID_CONTAINS_FROM(1) BAYES_HAM(-2.968525)
X-Rspamd-Score: -5.568525
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Wed, 20 Apr 2022 12:24:29 +0200
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FROM_SUSPICIOUS_NTLD,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce names for the new tool events 'user_time' and 'system_time'.

Signed-off-by: Florian Fischer <florian.fischer@muhq.space>
---
 tools/perf/util/evsel.c        | 19 ++++++++++------
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c | 40 +++++++++++++++++++++++++++++-----
 3 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2a1729e7aee4..d38722560e80 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -597,6 +597,17 @@ static int evsel__sw_name(struct evsel *evsel, char *bf, size_t size)
 	return r + evsel__add_modifiers(evsel, bf + r, size - r);
 }
 
+const char *evsel__tool_names[PERF_TOOL_MAX] = {
+	"duration_time",
+	"user_time",
+	"system_time",
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
index 7e2209b47b39..45d674812239 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -262,6 +262,7 @@ extern const char *evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX][EVSEL__MAX_ALI
 extern const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX][EVSEL__MAX_ALIASES];
 extern const char *evsel__hw_names[PERF_COUNT_HW_MAX];
 extern const char *evsel__sw_names[PERF_COUNT_SW_MAX];
+extern const char *evsel__tool_names[PERF_TOOL_MAX];
 extern char *evsel__bpf_counter_events;
 bool evsel__match_bpf_counter_events(const char *name);
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 064ec368a90b..c0e88d3b3e3c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -154,6 +154,21 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 	},
 };
 
+struct event_symbol event_symbols_tool[PERF_TOOL_MAX] = {
+	[PERF_TOOL_DURATION_TIME] = {
+		.symbol = "duration_time",
+		.alias  = "",
+	},
+	[PERF_TOOL_USER_TIME] = {
+		.symbol = "user_time",
+		.alias  = "",
+	},
+	[PERF_TOOL_SYSTEM_TIME] = {
+		.symbol = "system_time",
+		.alias  = "",
+	},
+};
+
 #define __PERF_EVENT_FIELD(config, name) \
 	((config & PERF_EVENT_##name##_MASK) >> PERF_EVENT_##name##_SHIFT)
 
@@ -3058,21 +3073,34 @@ int print_hwcache_events(const char *event_glob, bool name_only)
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
+	for (int i = 1; i < PERF_TOOL_MAX; ++i) {
+		print_tool_event(event_symbols_tool + i, event_glob, name_only);
+	}
 	if (pager_in_use())
 		printf("\n");
 }
-- 
2.36.0

