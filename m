Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC2A54B349
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbiFNOfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355787AbiFNOeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:34:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40ED3B3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:34:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30c1d90587dso26705277b3.14
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RhxA7eRgAfXCkykh9Mqke3rmlCOtyFU0Irt1epvp7hw=;
        b=GLjcD5Dx33HCbsoWEkqU+neIygwWnlhBDLV2vzAwLmDz8x5q82nfJom16BkE93u/PK
         hspUdyCTqgVsnGxFdzeO5+D4K6rzB3TOgcohdxOodk2l0hhBFzS3hSKzwR+uRNqflmP+
         w7qStg224/xe3rky8A1vFJ2as88HVYqhbgTuIJcGhoTpjcW0rTHT8xVaOLwraPFGxvFW
         NPJ7yLaBgPfavu3063eucMRS730PQ3OflSLL0j4EZhowwrnC48rqarnfIPxoRPaGoMHf
         ffxw+WkWbqF/XQXM86FoXasPo2as2buUgyNc2GyL1oUe+IWM36/8TJEw7C3JshxZ+Xu+
         i8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RhxA7eRgAfXCkykh9Mqke3rmlCOtyFU0Irt1epvp7hw=;
        b=AF/KFo7dn0wB/KVEiFisD5q7SUVRsHaZd+tK4poUrMtuvfOVVJ9FJC4pZIrJmHYy0L
         v2r1QxXl/xd8sOMMpdhryRkWahKjZknugPCTmh7FurWMrUWdzPoTqB/6F4I7Fd7VcktV
         Vz4cTZQyhIwinYLJ6IxACI+N9rILeWaHmWlTbxST7GQZxu8DyXs9+F8gzI5oikXGViYB
         BeHuWUwJEFy8GCv6OeLmSS5Fxyk8r37Vh3Zx6sA/7a4XPCFYa133mRZh7fY7O3kNyYgP
         ecyDZ/BHxl9iHN1RUUn1DM3OTHsFlKDp5NvyYSD/b6m1E/i8xCbWoWcsniy04+zZdlbM
         LPPw==
X-Gm-Message-State: AJIora+F6oZn3CcPl/hXeRitxYe+xaK3HDAf1s4atD04zqs3yfUrMr05
        IbjEy8POVJ9GAcO8zxEFUydaq/hCNMSL
X-Google-Smtp-Source: AGRyM1t1Ygr0jc8VIJfd7IOc2+oMNdhp6qPa2VuDhBtAwkK9kLSXnT7iPkQCmX1L3JPff2GK64cCWAczPWx4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b55a:aaa7:a:1b17])
 (user=irogers job=sendgmr) by 2002:a81:2d0b:0:b0:313:34ae:77b9 with SMTP id
 t11-20020a812d0b000000b0031334ae77b9mr6077081ywt.233.1655217251575; Tue, 14
 Jun 2022 07:34:11 -0700 (PDT)
Date:   Tue, 14 Jun 2022 07:33:52 -0700
In-Reply-To: <20220614143353.1559597-1-irogers@google.com>
Message-Id: <20220614143353.1559597-6-irogers@google.com>
Mime-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 5/6] perf events: Prefer union over variable length array
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

It is possible for casts to introduce alignment issues, prefer a union
for perf_record_event_update.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/perf/event.h | 11 ++++++++++-
 tools/perf/tests/event_update.c     | 14 ++++----------
 tools/perf/util/header.c            | 24 ++++++++----------------
 tools/perf/util/synthetic-events.c  | 12 +++++-------
 4 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index d2d32589758a..21170f5afb61 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -221,7 +221,16 @@ struct perf_record_event_update {
 	struct perf_event_header header;
 	__u64			 type;
 	__u64			 id;
-	char			 data[];
+	union {
+		/* Used when type == PERF_EVENT_UPDATE__SCALE. */
+		struct perf_record_event_update_scale scale;
+		/* Used when type == PERF_EVENT_UPDATE__UNIT. */
+		char unit[0];
+		/* Used when type == PERF_EVENT_UPDATE__NAME. */
+		char name[0];
+		/* Used when type == PERF_EVENT_UPDATE__CPUS. */
+		struct perf_record_event_update_cpus cpus;
+	};
 };
 
 #define MAX_EVENT_NAME 64
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 78db4d704e76..d093a9b878d1 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -21,7 +21,7 @@ static int process_event_unit(struct perf_tool *tool __maybe_unused,
 
 	TEST_ASSERT_VAL("wrong id", ev->id == 123);
 	TEST_ASSERT_VAL("wrong id", ev->type == PERF_EVENT_UPDATE__UNIT);
-	TEST_ASSERT_VAL("wrong unit", !strcmp(ev->data, "KRAVA"));
+	TEST_ASSERT_VAL("wrong unit", !strcmp(ev->unit, "KRAVA"));
 	return 0;
 }
 
@@ -31,13 +31,10 @@ static int process_event_scale(struct perf_tool *tool __maybe_unused,
 			       struct machine *machine __maybe_unused)
 {
 	struct perf_record_event_update *ev = (struct perf_record_event_update *)event;
-	struct perf_record_event_update_scale *ev_data;
-
-	ev_data = (struct perf_record_event_update_scale *)ev->data;
 
 	TEST_ASSERT_VAL("wrong id", ev->id == 123);
 	TEST_ASSERT_VAL("wrong id", ev->type == PERF_EVENT_UPDATE__SCALE);
-	TEST_ASSERT_VAL("wrong scale", ev_data->scale == 0.123);
+	TEST_ASSERT_VAL("wrong scale", ev->scale.scale == 0.123);
 	return 0;
 }
 
@@ -56,7 +53,7 @@ static int process_event_name(struct perf_tool *tool,
 
 	TEST_ASSERT_VAL("wrong id", ev->id == 123);
 	TEST_ASSERT_VAL("wrong id", ev->type == PERF_EVENT_UPDATE__NAME);
-	TEST_ASSERT_VAL("wrong name", !strcmp(ev->data, tmp->name));
+	TEST_ASSERT_VAL("wrong name", !strcmp(ev->name, tmp->name));
 	return 0;
 }
 
@@ -66,12 +63,9 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 			      struct machine *machine __maybe_unused)
 {
 	struct perf_record_event_update *ev = (struct perf_record_event_update *)event;
-	struct perf_record_event_update_cpus *ev_data;
 	struct perf_cpu_map *map;
 
-	ev_data = (struct perf_record_event_update_cpus *) ev->data;
-
-	map = cpu_map__new_data(&ev_data->cpus);
+	map = cpu_map__new_data(&ev->cpus.cpus);
 
 	TEST_ASSERT_VAL("wrong id", ev->id == 123);
 	TEST_ASSERT_VAL("wrong type", ev->type == PERF_EVENT_UPDATE__CPUS);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 53332da100e8..108c8da5d2e3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4264,8 +4264,6 @@ int perf_event__process_feature(struct perf_session *session,
 size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 {
 	struct perf_record_event_update *ev = &event->event_update;
-	struct perf_record_event_update_scale *ev_scale;
-	struct perf_record_event_update_cpus *ev_cpus;
 	struct perf_cpu_map *map;
 	size_t ret;
 
@@ -4273,20 +4271,18 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 
 	switch (ev->type) {
 	case PERF_EVENT_UPDATE__SCALE:
-		ev_scale = (struct perf_record_event_update_scale *)ev->data;
-		ret += fprintf(fp, "... scale: %f\n", ev_scale->scale);
+		ret += fprintf(fp, "... scale: %f\n", ev->scale.scale);
 		break;
 	case PERF_EVENT_UPDATE__UNIT:
-		ret += fprintf(fp, "... unit:  %s\n", ev->data);
+		ret += fprintf(fp, "... unit:  %s\n", ev->unit);
 		break;
 	case PERF_EVENT_UPDATE__NAME:
-		ret += fprintf(fp, "... name:  %s\n", ev->data);
+		ret += fprintf(fp, "... name:  %s\n", ev->name);
 		break;
 	case PERF_EVENT_UPDATE__CPUS:
-		ev_cpus = (struct perf_record_event_update_cpus *)ev->data;
 		ret += fprintf(fp, "... ");
 
-		map = cpu_map__new_data(&ev_cpus->cpus);
+		map = cpu_map__new_data(&ev->cpus.cpus);
 		if (map)
 			ret += cpu_map__fprintf(map, fp);
 		else
@@ -4343,8 +4339,6 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 				     struct evlist **pevlist)
 {
 	struct perf_record_event_update *ev = &event->event_update;
-	struct perf_record_event_update_scale *ev_scale;
-	struct perf_record_event_update_cpus *ev_cpus;
 	struct evlist *evlist;
 	struct evsel *evsel;
 	struct perf_cpu_map *map;
@@ -4361,19 +4355,17 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 	switch (ev->type) {
 	case PERF_EVENT_UPDATE__UNIT:
 		free((char *)evsel->unit);
-		evsel->unit = strdup(ev->data);
+		evsel->unit = strdup(ev->unit);
 		break;
 	case PERF_EVENT_UPDATE__NAME:
 		free(evsel->name);
-		evsel->name = strdup(ev->data);
+		evsel->name = strdup(ev->name);
 		break;
 	case PERF_EVENT_UPDATE__SCALE:
-		ev_scale = (struct perf_record_event_update_scale *)ev->data;
-		evsel->scale = ev_scale->scale;
+		evsel->scale = ev->scale.scale;
 		break;
 	case PERF_EVENT_UPDATE__CPUS:
-		ev_cpus = (struct perf_record_event_update_cpus *)ev->data;
-		map = cpu_map__new_data(&ev_cpus->cpus);
+		map = cpu_map__new_data(&ev->cpus.cpus);
 		if (map) {
 			perf_cpu_map__put(evsel->core.own_cpus);
 			evsel->core.own_cpus = map;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 4fa7d0d7dbcf..ec54ac1ed96f 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1848,7 +1848,7 @@ int perf_event__synthesize_event_update_unit(struct perf_tool *tool, struct evse
 	if (ev == NULL)
 		return -ENOMEM;
 
-	strlcpy(ev->data, evsel->unit, size + 1);
+	strlcpy(ev->unit, evsel->unit, size + 1);
 	err = process(tool, (union perf_event *)ev, NULL, NULL);
 	free(ev);
 	return err;
@@ -1865,8 +1865,7 @@ int perf_event__synthesize_event_update_scale(struct perf_tool *tool, struct evs
 	if (ev == NULL)
 		return -ENOMEM;
 
-	ev_data = (struct perf_record_event_update_scale *)ev->data;
-	ev_data->scale = evsel->scale;
+	ev->scale.scale = evsel->scale;
 	err = process(tool, (union perf_event *)ev, NULL, NULL);
 	free(ev);
 	return err;
@@ -1883,7 +1882,7 @@ int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evse
 	if (ev == NULL)
 		return -ENOMEM;
 
-	strlcpy(ev->data, evsel->name, len + 1);
+	strlcpy(ev->name, evsel->name, len + 1);
 	err = process(tool, (union perf_event *)ev, NULL, NULL);
 	free(ev);
 	return err;
@@ -1892,7 +1891,7 @@ int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evse
 int perf_event__synthesize_event_update_cpus(struct perf_tool *tool, struct evsel *evsel,
 					     perf_event__handler_t process)
 {
-	size_t size = sizeof(struct perf_record_event_update);
+	size_t size = sizeof(struct perf_event_header) + sizeof(u64) + sizeof(u64);
 	struct perf_record_event_update *ev;
 	int max, err;
 	u16 type;
@@ -1909,8 +1908,7 @@ int perf_event__synthesize_event_update_cpus(struct perf_tool *tool, struct evse
 	ev->type	= PERF_EVENT_UPDATE__CPUS;
 	ev->id		= evsel->core.id[0];
 
-	cpu_map_data__synthesize((struct perf_record_cpu_map_data *)ev->data,
-				 evsel->core.own_cpus, type, max);
+	cpu_map_data__synthesize(&ev->cpus.cpus, evsel->core.own_cpus, type, max);
 
 	err = process(tool, (union perf_event *)ev, NULL, NULL);
 	free(ev);
-- 
2.36.1.476.g0c4daa206d-goog

