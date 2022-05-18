Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F85A52B165
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiEREVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiEREUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:20:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFF931348
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o7-20020a256b47000000b0064ddc3bea70so914457ybm.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F54usjAFz5vOzrdA7Nd+K5d7QeUNwuqGITpxppLDKa4=;
        b=odPp4kgnmwQQ4SnUxewUSNzh7Dh53hxIxND74XLjXNwxaMW6gbbyVeSe1iEVcTfhw/
         gdRROBnW9p+t26XhT22/g841ITPy+0BPI8sfjEFukBAfzKrmBzm4PHFUgwyye5rtoMx4
         IMnx9Is8HLb/QtX/TINqByoHEXUgM6cpj9NLOsrcq1pTPp65uEMRxRe5q35gP+7TyvAk
         x7L2R46t79gUKSANkJqswtei1kJot9yOb7JEt9fCF7Cb9bsOOkwFjUldR/z/m45c5mBV
         oz7uXJ3bhzc8lj1UxNuDsgAbuWVFSHirHYQYH03VLyrO/rXxRfUxvr/eUuFk//hqdktF
         OSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F54usjAFz5vOzrdA7Nd+K5d7QeUNwuqGITpxppLDKa4=;
        b=B2p8HQkxzJvmEWFwpCxL2F/UQFi4mOzooCA9CRV4mYgrBK5PxsdlYnL88AlCfNVuha
         gRyf+Wuh5MmTKSZA2MIkwgLFYcEHmOg1ifEUI/gRIz605GI/IKYd00U8AvheMjCzWM5+
         +JVslDsy8ksULooLxssLBxwfVJDk5otzoKZAo9tQ6EgryoTbGqub7kOzcAS+cfJAW7qn
         Yg9vJJJAd74s8zsrWkYJxVRLOOJA8P1H4jSORKY5Z9iZAEROab2wdTEsLtFSPPoNgaBi
         fLKvtxuS7wDS6sddiNBdgGC2xTalHiz1eF41NfmJPnNW09FHu7vcmfnKM+TR4GjSJcq7
         k8+g==
X-Gm-Message-State: AOAM530LvLH/klyrXi0g2oIHKV8KiZ31pHh03Q41WmmQbZiIepSkNWUX
        Xm7u8pWWEQ17e9KEp+gO1A5pcZVHSqON
X-Google-Smtp-Source: ABdhPJwQ53tXTg5XaTmNssXKWoqOg3S4q5z8eU/sC74qfnuNnYk4Faqsne7ja1QXmppCXBuoWCipFyFCZKZ2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a25:9081:0:b0:64d:d424:a811 with SMTP id
 t1-20020a259081000000b0064dd424a811mr9891525ybl.298.1652847648872; Tue, 17
 May 2022 21:20:48 -0700 (PDT)
Date:   Tue, 17 May 2022 21:20:26 -0700
In-Reply-To: <20220518042027.836799-1-irogers@google.com>
Message-Id: <20220518042027.836799-8-irogers@google.com>
Mime-Version: 1.0
References: <20220518042027.836799-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 7/8] perf test: Parse events break apart tests
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
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

Break multiple tests in the main test into individual test cases. Make
better use of skip and add reasons. Skip also for parse event permission
issues (detected by searching the error string). Rather than break out
of tests on the first failure, keep going and logging to pr_debug.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 311 ++++++++++++++++++--------------
 1 file changed, 177 insertions(+), 134 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 0d65770bd686..459afdb256a1 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -56,7 +56,7 @@ static int test__checkevent_tracepoint(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong sample_type",
 		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
 	TEST_ASSERT_VAL("wrong sample_period", 1 == evsel->core.attr.sample_period);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_tracepoint_multi(struct evlist *evlist)
@@ -74,7 +74,7 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong sample_period",
 			1 == evsel->core.attr.sample_period);
 	}
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_raw(struct evlist *evlist)
@@ -84,7 +84,7 @@ static int test__checkevent_raw(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_numeric(struct evlist *evlist)
@@ -94,7 +94,7 @@ static int test__checkevent_numeric(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_symbolic_name(struct evlist *evlist)
@@ -105,7 +105,7 @@ static int test__checkevent_symbolic_name(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_symbolic_name_config(struct evlist *evlist)
@@ -126,7 +126,7 @@ static int test__checkevent_symbolic_name_config(struct evlist *evlist)
 			0 == evsel->core.attr.config1);
 	TEST_ASSERT_VAL("wrong config2",
 			1 == evsel->core.attr.config2);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_symbolic_alias(struct evlist *evlist)
@@ -137,7 +137,7 @@ static int test__checkevent_symbolic_alias(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_SW_PAGE_FAULTS == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_genhw(struct evlist *evlist)
@@ -147,7 +147,7 @@ static int test__checkevent_genhw(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", (1 << 16) == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_breakpoint(struct evlist *evlist)
@@ -161,7 +161,7 @@ static int test__checkevent_breakpoint(struct evlist *evlist)
 					 evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_4 ==
 					evsel->core.attr.bp_len);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_breakpoint_x(struct evlist *evlist)
@@ -174,7 +174,7 @@ static int test__checkevent_breakpoint_x(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong bp_type",
 			HW_BREAKPOINT_X == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len", sizeof(long) == evsel->core.attr.bp_len);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_breakpoint_r(struct evlist *evlist)
@@ -189,7 +189,7 @@ static int test__checkevent_breakpoint_r(struct evlist *evlist)
 			HW_BREAKPOINT_R == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
 			HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_breakpoint_w(struct evlist *evlist)
@@ -204,7 +204,7 @@ static int test__checkevent_breakpoint_w(struct evlist *evlist)
 			HW_BREAKPOINT_W == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
 			HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_breakpoint_rw(struct evlist *evlist)
@@ -219,7 +219,7 @@ static int test__checkevent_breakpoint_rw(struct evlist *evlist)
 		(HW_BREAKPOINT_R|HW_BREAKPOINT_W) == evsel->core.attr.bp_type);
 	TEST_ASSERT_VAL("wrong bp_len",
 			HW_BREAKPOINT_LEN_4 == evsel->core.attr.bp_len);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_tracepoint_modifier(struct evlist *evlist)
@@ -450,7 +450,7 @@ static int test__checkevent_pmu(struct evlist *evlist)
 	 */
 	TEST_ASSERT_VAL("wrong period",     0 == evsel->core.attr.sample_period);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_list(struct evlist *evlist)
@@ -489,7 +489,7 @@ static int test__checkevent_list(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_pmu_name(struct evlist *evlist)
@@ -510,7 +510,7 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong name",
 			!strcmp(evsel__name(evsel), "cpu/config=2/u"));
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
@@ -541,7 +541,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong callgraph",  !evsel__has_callchain(evsel));
 	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->core.attr.sample_type));
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_pmu_events(struct evlist *evlist)
@@ -559,7 +559,7 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 
-	return 0;
+	return TEST_OK;
 }
 
 
@@ -591,7 +591,7 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.pinned);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkterms_simple(struct list_head *terms)
@@ -662,7 +662,7 @@ static int test__checkterms_simple(struct list_head *terms)
 			term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
 	TEST_ASSERT_VAL("wrong val", term->val.num == 0xead);
 	TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config"));
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group1(struct evlist *evlist)
@@ -704,7 +704,7 @@ static int test__group1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group2(struct evlist *evlist)
@@ -759,7 +759,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group3(struct evlist *evlist __maybe_unused)
@@ -851,7 +851,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group4(struct evlist *evlist __maybe_unused)
@@ -895,7 +895,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group5(struct evlist *evlist __maybe_unused)
@@ -981,7 +981,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group_gh1(struct evlist *evlist)
@@ -1021,7 +1021,7 @@ static int test__group_gh1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group_gh2(struct evlist *evlist)
@@ -1061,7 +1061,7 @@ static int test__group_gh2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group_gh3(struct evlist *evlist)
@@ -1101,7 +1101,7 @@ static int test__group_gh3(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__group_gh4(struct evlist *evlist)
@@ -1141,7 +1141,7 @@ static int test__group_gh4(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__leader_sample1(struct evlist *evlist)
@@ -1194,7 +1194,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__leader_sample2(struct evlist *evlist __maybe_unused)
@@ -1233,7 +1233,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_pinned_modifier(struct evlist *evlist)
@@ -1277,7 +1277,7 @@ static int test__pinned_group(struct evlist *evlist)
 			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_exclusive_modifier(struct evlist *evlist)
@@ -1321,7 +1321,7 @@ static int test__exclusive_group(struct evlist *evlist)
 			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 
-	return 0;
+	return TEST_OK;
 }
 static int test__checkevent_breakpoint_len(struct evlist *evlist)
 {
@@ -1335,7 +1335,7 @@ static int test__checkevent_breakpoint_len(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_1 ==
 					evsel->core.attr.bp_len);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
@@ -1350,7 +1350,7 @@ static int test__checkevent_breakpoint_len_w(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong bp_len", HW_BREAKPOINT_LEN_2 ==
 					evsel->core.attr.bp_len);
 
-	return 0;
+	return TEST_OK;
 }
 
 static int
@@ -1374,7 +1374,7 @@ static int test__checkevent_precise_max_modifier(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_SW_TASK_CLOCK == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_config_symbol(struct evlist *evlist)
@@ -1382,7 +1382,7 @@ static int test__checkevent_config_symbol(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "insn") == 0);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_config_raw(struct evlist *evlist)
@@ -1390,7 +1390,7 @@ static int test__checkevent_config_raw(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "rawpmu") == 0);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_config_num(struct evlist *evlist)
@@ -1398,7 +1398,7 @@ static int test__checkevent_config_num(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "numpmu") == 0);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_config_cache(struct evlist *evlist)
@@ -1406,7 +1406,7 @@ static int test__checkevent_config_cache(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "cachepmu") == 0);
-	return 0;
+	return TEST_OK;
 }
 
 static bool test__intel_pt_valid(void)
@@ -1419,7 +1419,7 @@ static int test__intel_pt(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "intel_pt//u") == 0);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_complex_name(struct evlist *evlist)
@@ -1427,7 +1427,7 @@ static int test__checkevent_complex_name(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong complex name parsing", strcmp(evsel->name, "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks") == 0);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__checkevent_raw_pmu(struct evlist *evlist)
@@ -1437,7 +1437,7 @@ static int test__checkevent_raw_pmu(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__sym_event_slash(struct evlist *evlist)
@@ -1447,7 +1447,7 @@ static int test__sym_event_slash(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
 	TEST_ASSERT_VAL("wrong config", evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__sym_event_dc(struct evlist *evlist)
@@ -1457,7 +1457,7 @@ static int test__sym_event_dc(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
 	TEST_ASSERT_VAL("wrong config", evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES);
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	return 0;
+	return TEST_OK;
 }
 
 static int count_tracepoints(void)
@@ -1521,7 +1521,7 @@ static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__hybrid_hw_group_event(struct evlist *evlist)
@@ -1538,7 +1538,7 @@ static int test__hybrid_hw_group_event(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0xc0 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	return 0;
+	return TEST_OK;
 }
 
 static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
@@ -1554,7 +1554,7 @@ static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	return 0;
+	return TEST_OK;
 }
 
 static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
@@ -1570,7 +1570,7 @@ static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	return 0;
+	return TEST_OK;
 }
 
 static int test__hybrid_group_modifier1(struct evlist *evlist)
@@ -1591,7 +1591,7 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__hybrid_raw1(struct evlist *evlist)
@@ -1602,7 +1602,7 @@ static int test__hybrid_raw1(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 		TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
-		return 0;
+		return TEST_OK;
 	}
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
@@ -1612,7 +1612,7 @@ static int test__hybrid_raw1(struct evlist *evlist)
 	/* The type of second event is randome value */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__hybrid_raw2(struct evlist *evlist)
@@ -1622,7 +1622,7 @@ static int test__hybrid_raw2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
 static int test__hybrid_cache_event(struct evlist *evlist)
@@ -1632,7 +1632,7 @@ static int test__hybrid_cache_event(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x2 == (evsel->core.attr.config & 0xffffffff));
-	return 0;
+	return TEST_OK;
 }
 
 struct evlist_test {
@@ -2043,20 +2043,24 @@ static int test_event(const struct evlist_test *e)
 	int ret;
 
 	if (e->valid && !e->valid()) {
-		pr_debug("... SKIP");
-		return 0;
+		pr_debug("... SKIP\n");
+		return TEST_OK;
 	}
 
 	evlist = evlist__new();
-	if (evlist == NULL)
-		return -ENOMEM;
-
+	if (evlist == NULL) {
+		pr_err("Failed allocation");
+		return TEST_FAIL;
+	}
 	parse_events_error__init(&err);
 	ret = parse_events(evlist, e->name, &err);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
 			 e->name, ret, err.str);
 		parse_events_error__print(&err, e->name);
+		ret = TEST_FAIL;
+		if (strstr(err.str, "can't access trace events"))
+			ret = TEST_SKIP;
 	} else {
 		ret = e->check(evlist);
 	}
@@ -2091,21 +2095,37 @@ static int test_event_fake_pmu(const char *str)
 	return ret;
 }
 
+static int combine_test_results(int existing, int latest)
+{
+	if (existing == TEST_FAIL)
+		return TEST_FAIL;
+	if (existing == TEST_SKIP)
+		return latest == TEST_OK ? TEST_SKIP : latest;
+	return latest;
+}
+
 static int test_events(const struct evlist_test *events, int cnt)
 {
-	int ret1, ret2 = 0;
+	int ret = TEST_OK;
 
 	for (int i = 0; i < cnt; i++) {
 		const struct evlist_test *e = &events[i];
+		int test_ret;
 
-		pr_debug("running test %d '%s'", i, e->name);
-		ret1 = test_event(e);
-		if (ret1)
-			ret2 = ret1;
-		pr_debug("\n");
+		pr_debug("running test %d '%s'\n", i, e->name);
+		test_ret = test_event(e);
+		if (test_ret != TEST_OK) {
+			pr_debug("Event test failure: test %d '%s'", i, e->name);
+			ret = combine_test_results(ret, test_ret);
+		}
 	}
 
-	return ret2;
+	return ret;
+}
+
+static int test__events2(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	return test_events(test__events, ARRAY_SIZE(test__events));
 }
 
 static int test_term(const struct terms_test *t)
@@ -2151,6 +2171,11 @@ static int test_terms(const struct terms_test *terms, int cnt)
 	return ret;
 }
 
+static int test__terms2(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	return test_terms(test__terms, ARRAY_SIZE(test__terms));
+}
+
 static int test_pmu(void)
 {
 	struct stat st;
@@ -2166,7 +2191,7 @@ static int test_pmu(void)
 	return !ret;
 }
 
-static int test_pmu_events(void)
+static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct stat st;
 	char path[PATH_MAX];
@@ -2174,24 +2199,29 @@ static int test_pmu_events(void)
 	DIR *dir;
 	int ret;
 
+	if (!test_pmu())
+		return TEST_SKIP;
+
 	snprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu/events/",
 		 sysfs__mountpoint());
 
 	ret = stat(path, &st);
 	if (ret) {
-		pr_debug("omitting PMU cpu events tests\n");
-		return 0;
+		pr_debug("omitting PMU cpu events tests: %s\n", path);
+		return TEST_OK;
 	}
 
 	dir = opendir(path);
 	if (!dir) {
-		pr_debug("can't open pmu event dir");
-		return -1;
+		pr_debug("can't open pmu event dir: %s\n", path);
+		return TEST_FAIL;
 	}
 
-	while (!ret && (ent = readdir(dir))) {
+	ret = TEST_OK;
+	while ((ent = readdir(dir))) {
 		struct evlist_test e = { .name = NULL, };
 		char name[2 * NAME_MAX + 1 + 12 + 3];
+		int test_ret;
 
 		/* Names containing . are special and cannot be used directly */
 		if (strchr(ent->d_name, '.'))
@@ -2202,19 +2232,33 @@ static int test_pmu_events(void)
 		e.name  = name;
 		e.check = test__checkevent_pmu_events;
 
-		ret = test_event(&e);
-		if (ret)
-			break;
+		test_ret = test_event(&e);
+		if (test_ret != TEST_OK) {
+			pr_debug("Test PMU event failed for '%s'", name);
+			ret = combine_test_results(ret, test_ret);
+		}
 		snprintf(name, sizeof(name), "%s:u,cpu/event=%s/u", ent->d_name, ent->d_name);
 		e.name  = name;
 		e.check = test__checkevent_pmu_events_mix;
-		ret = test_event(&e);
+		test_ret = test_event(&e);
+		if (test_ret != TEST_OK) {
+			pr_debug("Test PMU event failed for '%s'", name);
+			ret = combine_test_results(ret, test_ret);
+		}
 	}
 
 	closedir(dir);
 	return ret;
 }
 
+static int test__pmu_events2(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	if (!test_pmu())
+		return TEST_SKIP;
+
+	return test_events(test__events_pmu, ARRAY_SIZE(test__events_pmu));
+}
+
 static bool test_alias(char **event, char **alias)
 {
 	char path[PATH_MAX];
@@ -2273,6 +2317,14 @@ static bool test_alias(char **event, char **alias)
 	return false;
 }
 
+static int test__hybrid(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	if (!perf_pmu__has_hybrid())
+		return TEST_SKIP;
+
+	return test_events(test__hybrid_events, ARRAY_SIZE(test__hybrid_events));
+}
+
 static int test__checkevent_pmu_events_alias(struct evlist *evlist)
 {
 	struct evsel *evsel1 = evlist__first(evlist);
@@ -2280,10 +2332,10 @@ static int test__checkevent_pmu_events_alias(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong type", evsel1->core.attr.type == evsel2->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", evsel1->core.attr.config == evsel2->core.attr.config);
-	return 0;
+	return TEST_OK;
 }
 
-static int test_pmu_events_alias(char *event, char *alias)
+static int test__pmu_events_alias(char *event, char *alias)
 {
 	struct evlist_test e = { .name = NULL, };
 	char name[2 * NAME_MAX + 20];
@@ -2296,72 +2348,63 @@ static int test_pmu_events_alias(char *event, char *alias)
 	return test_event(&e);
 }
 
-static int test_pmu_events_alias2(void)
+static int test__alias(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	static const char events[][30] = {
-			"event-hyphen",
-			"event-two-hyph",
-	};
-	unsigned long i;
-	int ret = 0;
+	char *event, *alias;
+	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(events); i++) {
-		ret = test_event_fake_pmu(&events[i][0]);
-		if (ret) {
-			pr_err("check_parse_fake %s failed\n", &events[i][0]);
-			break;
-		}
-	}
+	if (!test_alias(&event, &alias))
+		return TEST_SKIP;
 
+	ret = test__pmu_events_alias(event, alias);
+
+	free(event);
+	free(alias);
 	return ret;
 }
 
-static int test__parse_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+static int test__pmu_events_alias2(struct test_suite *test __maybe_unused,
+				   int subtest __maybe_unused)
 {
-	int ret1, ret2 = 0;
-	char *event, *alias;
-
-#define TEST_EVENTS(tests)				\
-do {							\
-	ret1 = test_events(tests, ARRAY_SIZE(tests));	\
-	if (!ret2)					\
-		ret2 = ret1;				\
-} while (0)
-
-	if (perf_pmu__has_hybrid()) {
-		TEST_EVENTS(test__hybrid_events);
-		return ret2;
-	}
-
-	TEST_EVENTS(test__events);
-
-	if (test_pmu())
-		TEST_EVENTS(test__events_pmu);
-
-	if (test_pmu()) {
-		int ret = test_pmu_events();
-		if (ret)
-			return ret;
-	}
+	static const char events[][30] = {
+			"event-hyphen",
+			"event-two-hyph",
+	};
+	int ret = TEST_OK;
 
-	if (test_alias(&event, &alias)) {
-		int ret = test_pmu_events_alias(event, alias);
+	for (unsigned int i = 0; i < ARRAY_SIZE(events); i++) {
+		int test_ret = test_event_fake_pmu(&events[i][0]);
 
-		free(event);
-		free(alias);
-		if (ret)
-			return ret;
+		if (test_ret != TEST_OK) {
+			pr_debug("check_parse_fake %s failed\n", &events[i][0]);
+			ret = combine_test_results(ret, test_ret);
+		}
 	}
 
-	ret1 = test_pmu_events_alias2();
-	if (!ret2)
-		ret2 = ret1;
-
-	ret1 = test_terms(test__terms, ARRAY_SIZE(test__terms));
-	if (!ret2)
-		ret2 = ret1;
-
-	return ret2;
+	return ret;
 }
 
-DEFINE_SUITE("Parse event definition strings", parse_events);
+static struct test_case tests__parse_events[] = {
+	TEST_CASE_REASON("Test event parsing",
+			 events2,
+			 "permissions"),
+	TEST_CASE_REASON("Test parsing of \"hybrid\" CPU events",
+			 hybrid,
+			"not hybrid"),
+	TEST_CASE_REASON("Parsing of all PMU events from sysfs",
+			 pmu_events,
+			 "permissions"),
+	TEST_CASE_REASON("Parsing of given PMU events from sysfs",
+			 pmu_events2,
+			 "permissions"),
+	TEST_CASE_REASON("Parsing of aliased events from sysfs", alias,
+			 "no aliases in sysfs"),
+	TEST_CASE("Parsing of aliased events", pmu_events_alias2),
+	TEST_CASE("Parsing of terms (event modifiers)", terms2),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__parse_events = {
+	.desc = "Parse event definition strings",
+	.test_cases = tests__parse_events,
+};
-- 
2.36.0.550.gb090851708-goog

