Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB851E473
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445637AbiEGFiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445646AbiEGFiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:38:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2F61AF2B
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 22:34:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7c5767f0fso81648797b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 22:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bC1QHjSh76vc80FlT0i5N7y28Ax7j34T16/yRj6HA+0=;
        b=oWrrJYfi4mSyNnigslp/Ljzj5jwsZOXef5S2Xitv76+Yg4pNuRBkjeHnBnRYrzOiRj
         olpfao1Dj1bvWXUUb+Rb5ZD/dxl5QMZiDdY9s3nbgdaYMCXD1kvEsSgg9EL9hUaATDr9
         LaAgNz6aCcSUD4jhpvLCHibTz833BzVq50KeRbJphbEoarx0hnAuPxIa4qd3Zld9o1yc
         EOfr2lEj5hS3ZaPjsfKSp+FZkXXZ9Xl6K7f4R7pOFq6jdD9lMT3cZ0IZi/21X7vNqA9y
         gwJ3it3T6hdGx7tECRS+elHiRkg9Cz6gjMc7fTGR+wFoa4bBmB+MH/tdNxsgEPD0sBBU
         9usQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bC1QHjSh76vc80FlT0i5N7y28Ax7j34T16/yRj6HA+0=;
        b=HHi3NHCmRvNtx6mVewZs3t1wgDySYxAomifbPdUTwSw6Aqi35nBA9V0bvAOgK+v3z+
         zur57QH5qpPsGW55w0qtGlTuWrPqYuowjN80XOlt6AwZeefdfaH62Ji3TT2MojiJzoi9
         9zK+ZOWewOsVp0goWlUMyiHd+cqpp9aCD/eG9s8W2yh29asKiV/uQgels8sy0tvVrVHg
         YUMO2NYp/Eu+7ApylDbfwrllx3tlcFXd1NxaxzmlI3rY7VM0GQSuVA2zj+W1MXKfs8+j
         RoQH39rOh9g3SIF3ttJx8N4oJigrgScsuNVJSrZCqtu4EJBr+BqjS/iAh4Soj/DjsJN5
         pmLQ==
X-Gm-Message-State: AOAM530hDMRdzUwjAKHfVUDOYL0XcU2FnY/u3l+/A1kAXEt69q9el8Wm
        2Wh2llNzI0UfnnfAxEpqYzjSF1fV3KBJ
X-Google-Smtp-Source: ABdhPJwO7GsLd8OXvckEIq11DT8kc48Y/O5PqTlQpGkNGjd49wNqJ814A7t8+kvYK0vJusFrrAlr0gi4e/LQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:bf2a:2f64:a273:3573])
 (user=irogers job=sendgmr) by 2002:a81:4754:0:b0:2f9:1974:5fa7 with SMTP id
 u81-20020a814754000000b002f919745fa7mr5517646ywa.513.1651901661720; Fri, 06
 May 2022 22:34:21 -0700 (PDT)
Date:   Fri,  6 May 2022 22:34:08 -0700
In-Reply-To: <20220507053410.3798748-1-irogers@google.com>
Message-Id: <20220507053410.3798748-4-irogers@google.com>
Mime-Version: 1.0
References: <20220507053410.3798748-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 3/5] perf evsel: Add tool event helpers
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

Convert to and from a string. Fix evsel__tool_name as array is off-by-1.
Support more than just duration_time as a metric-id.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 41 +++++++++++++++++++++++++++++++----------
 tools/perf/util/evsel.h | 11 +++++++++++
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index cdeace24d9be..5fd7924f8eb3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -59,6 +59,33 @@ struct perf_missing_features perf_missing_features;
 
 static clockid_t clockid;
 
+static const char *const perf_tool_event__tool_names[PERF_TOOL_MAX] = {
+	NULL,
+	"duration_time",
+	"user_time",
+	"system_time",
+};
+
+const char *perf_tool_event__to_str(enum perf_tool_event ev)
+{
+	if (ev > PERF_TOOL_NONE && ev < PERF_TOOL_MAX)
+		return perf_tool_event__tool_names[ev];
+
+	return NULL;
+}
+
+enum perf_tool_event perf_tool_event__from_str(const char *str)
+{
+	int i;
+
+	perf_tool_event__for_each_event(i) {
+		if (!strcmp(str, perf_tool_event__tool_names[i]))
+			return i;
+	}
+	return PERF_TOOL_NONE;
+}
+
+
 static int evsel__no_extra_init(struct evsel *evsel __maybe_unused)
 {
 	return 0;
@@ -597,15 +624,9 @@ static int evsel__sw_name(struct evsel *evsel, char *bf, size_t size)
 	return r + evsel__add_modifiers(evsel, bf + r, size - r);
 }
 
-static const char *const evsel__tool_names[PERF_TOOL_MAX] = {
-	"duration_time",
-	"user_time",
-	"system_time",
-};
-
 static int evsel__tool_name(enum perf_tool_event ev, char *bf, size_t size)
 {
-	return scnprintf(bf, size, "%s", evsel__tool_names[ev]);
+	return scnprintf(bf, size, "%s", perf_tool_event__to_str(ev));
 }
 
 static int __evsel__bp_name(char *bf, size_t size, u64 addr, u64 type)
@@ -758,7 +779,7 @@ const char *evsel__name(struct evsel *evsel)
 		break;
 
 	case PERF_TYPE_SOFTWARE:
-		if (evsel->tool_event)
+		if (evsel__is_tool(evsel))
 			evsel__tool_name(evsel->tool_event, bf, sizeof(bf));
 		else
 			evsel__sw_name(evsel, bf, sizeof(bf));
@@ -791,8 +812,8 @@ const char *evsel__metric_id(const struct evsel *evsel)
 	if (evsel->metric_id)
 		return evsel->metric_id;
 
-	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE && evsel->tool_event)
-		return "duration_time";
+	if (evsel__is_tool(evsel))
+		return perf_tool_event__to_str(evsel->tool_event);
 
 	return "unknown";
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a017781cdd47..d4b04537ce6d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -36,6 +36,12 @@ enum perf_tool_event {
 	PERF_TOOL_MAX,
 };
 
+const char *perf_tool_event__to_str(enum perf_tool_event ev);
+enum perf_tool_event perf_tool_event__from_str(const char *str);
+
+#define perf_tool_event__for_each_event(ev)		\
+	for ((ev) = PERF_TOOL_DURATION_TIME; (ev) < PERF_TOOL_MAX; ev++)
+
 /** struct evsel - event selector
  *
  * @evlist - evlist this evsel is in, if it is in one.
@@ -269,6 +275,11 @@ int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size
 const char *evsel__name(struct evsel *evsel);
 const char *evsel__metric_id(const struct evsel *evsel);
 
+static inline bool evsel__is_tool(const struct evsel *evsel)
+{
+	return evsel->tool_event != PERF_TOOL_NONE;
+}
+
 const char *evsel__group_name(struct evsel *evsel);
 int evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
 
-- 
2.36.0.512.ge40c2bad7a-goog

