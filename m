Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B584F5D60
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiDFMAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiDFL6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:58:22 -0400
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F404C5282ED
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:29:22 -0700 (PDT)
Received: (qmail 8394 invoked by uid 989); 6 Apr 2022 07:29:21 -0000
Authentication-Results: euporie.uberspace.de;
        auth=pass (plain)
From:   Florian Fischer <florian.fischer@muhq.space>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Florian Schmaus <flow@cs.fau.de>,
        Florian Fischer <florian.fischer@muhq.space>
Subject: [PATCH v2 3/4] perf list: print all available tool events
Date:   Wed,  6 Apr 2022 09:28:38 +0200
Message-Id: <20220406072839.107519-4-florian.fischer@muhq.space>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406072839.107519-1-florian.fischer@muhq.space>
References: <YkybjsCKyWkDZGX+@kernel.org>
 <20220406072839.107519-1-florian.fischer@muhq.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) REPLY(-4) MID_CONTAINS_FROM(1) BAYES_HAM(-2.912096)
X-Rspamd-Score: -5.512096
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Wed, 06 Apr 2022 09:29:21 +0200
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FROM_SUSPICIOUS_NTLD,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce names and aliases for the new tool events 'rusage_user_time'
and 'rusage_system_time'.
---
 tools/perf/util/evsel.c        | 19 ++++++++++------
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c | 40 +++++++++++++++++++++++++++++-----
 3 files changed, 47 insertions(+), 13 deletions(-)

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
index e89b1224ae61..2adb97383952 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -261,6 +261,7 @@ extern const char *evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX][EVSEL__MAX_ALI
 extern const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX][EVSEL__MAX_ALIASES];
 extern const char *evsel__hw_names[PERF_COUNT_HW_MAX];
 extern const char *evsel__sw_names[PERF_COUNT_SW_MAX];
+extern const char *evsel__tool_names[PERF_TOOL_LAST];
 extern char *evsel__bpf_counter_events;
 bool evsel__match_bpf_counter_events(const char *name);
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 24997925ae00..5c84d5d43bff 100644
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
 
@@ -3055,21 +3070,34 @@ int print_hwcache_events(const char *event_glob, bool name_only)
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
-- 
2.35.1

