Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360D051E476
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445678AbiEGFiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445612AbiEGFiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:38:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F18DAE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 22:34:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so7927008ybp.19
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 22:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X0A48L0REIgxolXCeCwJBynKB3Io0hAXROJKBMA9IuU=;
        b=aqUn+PVzh65+R5Qpx9MvkBp1exKVHZMeHzuMLx5HUe+JchuFz1Pg0Xuvju6snBsdr3
         hT3LmX4kgUggfCB7eqBJm5N5QFU61wvahiVjvoziweJHPQAY0j82w3JKl18NNjWCyWFg
         rxAP6BZwJ/2Ho9woQz4hTTwOhzEM4FrCBaQHHvy5+ZegwDOue/9y/bWVFDlHgT1bLn14
         iw3sWf4C99DleXzmhSPQmgQyHnhh6FcY4JenjUzvpHWU/0RslkJQIeRN+f4chOWTw+0+
         zGqCkKwddPUBqeWqkwrIDMQ7mtztpadekc+wWgnCtPAlZVUzkuhPG7bDC/JtIInj3xLs
         /+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X0A48L0REIgxolXCeCwJBynKB3Io0hAXROJKBMA9IuU=;
        b=WtcPEYLFpJ4EjyXGenBNMhNZBd3VjIgRRsEHf9ogB/u0P60u12wA+1Zy/BXP/JMpl0
         sokqtdk3fCIxWCRpArKqlOwEX99jFaPhHqp3+NdawDfH60OxGm9bURCLttNybe+XEWE2
         mbfFHGeuVJiK4SImsOajdZvPjAFrHkZOYW1O2/rAhB9q7RJsSMeHaqJ2tsjydHRTNRPn
         /kYrHRKlY48mGNgfuul0D88o+30oD4DlWfmkoUDzFqx7kWGe0G1qMSldS/28c8CSbpOe
         DWdq9jTDGuHD9pQcRZ+BpZZpUZ86nJxANEL7yEq1PhS51Cqh5Z6OJ8VfbbD4yz4YR2kA
         +ovQ==
X-Gm-Message-State: AOAM532HVlqs2C/z6AitSVPj9QcQxncB4ZAgkD/BhVNS5eeIuOl/+UnD
        K4oBUgSQPH8d8uYQzd/jZnlNdY4SMjPh
X-Google-Smtp-Source: ABdhPJwPy24ZCHaXbuLNgP6AHb1xL58dIzYVg9Q0+xV4il+Ytzc0T3cj4NVTJpsEBfbp2IRMVZawJza4S5Bs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:bf2a:2f64:a273:3573])
 (user=irogers job=sendgmr) by 2002:a81:1196:0:b0:2f8:ccab:8807 with SMTP id
 144-20020a811196000000b002f8ccab8807mr5576891ywr.58.1651901659386; Fri, 06
 May 2022 22:34:19 -0700 (PDT)
Date:   Fri,  6 May 2022 22:34:07 -0700
In-Reply-To: <20220507053410.3798748-1-irogers@google.com>
Message-Id: <20220507053410.3798748-3-irogers@google.com>
Mime-Version: 1.0
References: <20220507053410.3798748-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 2/5] perf evsel: Constify a few arrays
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

Remove public definition of evsel__tool_names.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/evsel-roundtrip-name.c |  2 +-
 tools/perf/util/evsel.c                 | 14 +++++++-------
 tools/perf/util/evsel.h                 | 11 +++++------
 tools/perf/util/parse-events.c          |  2 +-
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index fdbf17642e45..9d3c64974f77 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -64,7 +64,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 	return ret;
 }
 
-static int __perf_evsel__name_array_test(const char *names[], int nr_names,
+static int __perf_evsel__name_array_test(const char *const names[], int nr_names,
 					 int distance)
 {
 	int i, err;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d38722560e80..cdeace24d9be 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -486,7 +486,7 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
 	return ERR_PTR(err);
 }
 
-const char *evsel__hw_names[PERF_COUNT_HW_MAX] = {
+const char *const evsel__hw_names[PERF_COUNT_HW_MAX] = {
 	"cycles",
 	"instructions",
 	"cache-references",
@@ -571,7 +571,7 @@ static int evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
 	return r + evsel__add_modifiers(evsel, bf + r, size - r);
 }
 
-const char *evsel__sw_names[PERF_COUNT_SW_MAX] = {
+const char *const evsel__sw_names[PERF_COUNT_SW_MAX] = {
 	"cpu-clock",
 	"task-clock",
 	"page-faults",
@@ -597,7 +597,7 @@ static int evsel__sw_name(struct evsel *evsel, char *bf, size_t size)
 	return r + evsel__add_modifiers(evsel, bf + r, size - r);
 }
 
-const char *evsel__tool_names[PERF_TOOL_MAX] = {
+static const char *const evsel__tool_names[PERF_TOOL_MAX] = {
 	"duration_time",
 	"user_time",
 	"system_time",
@@ -633,7 +633,7 @@ static int evsel__bp_name(struct evsel *evsel, char *bf, size_t size)
 	return r + evsel__add_modifiers(evsel, bf + r, size - r);
 }
 
-const char *evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX][EVSEL__MAX_ALIASES] = {
+const char *const evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX][EVSEL__MAX_ALIASES] = {
  { "L1-dcache",	"l1-d",		"l1d",		"L1-data",		},
  { "L1-icache",	"l1-i",		"l1i",		"L1-instruction",	},
  { "LLC",	"L2",							},
@@ -643,13 +643,13 @@ const char *evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX][EVSEL__MAX_ALIASES] = {
  { "node",								},
 };
 
-const char *evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX][EVSEL__MAX_ALIASES] = {
+const char *const evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX][EVSEL__MAX_ALIASES] = {
  { "load",	"loads",	"read",					},
  { "store",	"stores",	"write",				},
  { "prefetch",	"prefetches",	"speculative-read", "speculative-load",	},
 };
 
-const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX][EVSEL__MAX_ALIASES] = {
+const char *const evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX][EVSEL__MAX_ALIASES] = {
  { "refs",	"Reference",	"ops",		"access",		},
  { "misses",	"miss",							},
 };
@@ -665,7 +665,7 @@ const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX][EVSEL__MAX_AL
  * L1I : Read and prefetch only
  * ITLB and BPU : Read-only
  */
-static unsigned long evsel__hw_cache_stat[C(MAX)] = {
+static const unsigned long evsel__hw_cache_stat[C(MAX)] = {
  [C(L1D)]	= (CACHE_READ | CACHE_WRITE | CACHE_PREFETCH),
  [C(L1I)]	= (CACHE_READ | CACHE_PREFETCH),
  [C(LL)]	= (CACHE_READ | CACHE_WRITE | CACHE_PREFETCH),
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 45d674812239..a017781cdd47 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -257,12 +257,11 @@ static inline bool evsel__is_bpf(struct evsel *evsel)
 
 #define EVSEL__MAX_ALIASES 8
 
-extern const char *evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX][EVSEL__MAX_ALIASES];
-extern const char *evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX][EVSEL__MAX_ALIASES];
-extern const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX][EVSEL__MAX_ALIASES];
-extern const char *evsel__hw_names[PERF_COUNT_HW_MAX];
-extern const char *evsel__sw_names[PERF_COUNT_SW_MAX];
-extern const char *evsel__tool_names[PERF_TOOL_MAX];
+extern const char *const evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX][EVSEL__MAX_ALIASES];
+extern const char *const evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX][EVSEL__MAX_ALIASES];
+extern const char *const evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX][EVSEL__MAX_ALIASES];
+extern const char *const evsel__hw_names[PERF_COUNT_HW_MAX];
+extern const char *const evsel__sw_names[PERF_COUNT_SW_MAX];
 extern char *evsel__bpf_counter_events;
 bool evsel__match_bpf_counter_events(const char *name);
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 937f6c9434a2..30a9d915853d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -426,7 +426,7 @@ static int add_event_tool(struct list_head *list, int *idx,
 	return 0;
 }
 
-static int parse_aliases(char *str, const char *names[][EVSEL__MAX_ALIASES], int size)
+static int parse_aliases(char *str, const char *const names[][EVSEL__MAX_ALIASES], int size)
 {
 	int i, j;
 	int n, longest = -1;
-- 
2.36.0.512.ge40c2bad7a-goog

