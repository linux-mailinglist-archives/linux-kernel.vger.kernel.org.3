Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF86515AC9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382234AbiD3G1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382172AbiD3G1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:27:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E08CCFE59
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:23:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f7ee6bc6ddso93965557b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qZYkK0QiKq2QKPszwBBc5ZNarCxrPY8dG8RgsS3qw5I=;
        b=fRsyW6GbkMphhji6HkWrwSTwBAXGNvOlpnZsEL3PdGLSZJ1r7S1xYRjtrLOozK6mWl
         3qX3nxKGG2OnhVNIR+ZBXx1evctirZeziZih4gSH/j41Wikg/rbabyFZNsS/NSiOeJyy
         3ELoH1FKtB09fYuffeKdXu387tSyafRzaWMlEDjNWA8W6e+zvA7Hum8uO5Ejk0ayaTI5
         9NJQk9nM9n7AIYvrQKhRVbp7rzsc0+0lRzwekIYGw03prwRWy7pQqVxyVg/EWQkMWh88
         bmnnuvX4EC5Rfnr4firZh3dLp30gU8kumxP8KLeKzbd1R7U2Spu/q8Q2ZbG9CoqheSgA
         XO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qZYkK0QiKq2QKPszwBBc5ZNarCxrPY8dG8RgsS3qw5I=;
        b=lFwVKV4TA6rWVDsn1pD+DoV06jUJ/3LE2QAdA27YVxNmWyd4l+Rfe2pBO+/yDWK5h8
         E9vLokTzAbVc/PjI+kYDadQguXqqqW5M71xFFU6kZkTorEO6XlcJ2y5jgrNZdnDo2W5X
         y9DBJGcjcmxIR65wSIBYpYYgVk0EuHleqoPugEHv9nfC4lgqdlUCLLCsJWmPkSQ/dJwD
         fd31aHBJZDC2rF9qIScBJIoX4+pxYyrhNVCgUHuvcUkV1vkynVU25AoVelnPqzxHHS7Y
         cHm+ItznYAO2nwxV8XBI2LmJJBmo/nB+PIu3cNrLVgk4KnKNb/xfSplWQeTwlwi0nMup
         rVOA==
X-Gm-Message-State: AOAM531afzu3YbQLZV+aUn0WYkdBy3pOVJ1Kb8tkrXj3q/fX4hvh2qdU
        9ZKRaBjB5Px6vL6CmdtOLsdoqos+N2PQ
X-Google-Smtp-Source: ABdhPJxSNfQpR1Zv3c0Oz3hL/CjnVXqYxzCUyoTub6sZuefdc82ZfacJXBoI0or/vNiIC4+++3Egz2cSgZ1n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2481:caab:4fd5:232b])
 (user=irogers job=sendgmr) by 2002:a25:4944:0:b0:648:a796:a2 with SMTP id
 w65-20020a254944000000b00648a79600a2mr2761055yba.123.1651299820173; Fri, 29
 Apr 2022 23:23:40 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:23:22 -0700
In-Reply-To: <20220430062324.1565215-1-irogers@google.com>
Message-Id: <20220430062324.1565215-5-irogers@google.com>
Mime-Version: 1.0
References: <20220430062324.1565215-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 4/6] perf cpumap: Handle dummy maps as empty in subset
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_cpu_map__empty is true for empty and dummy maps. Make is_subset
respect that.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c   |  4 ++--
 tools/perf/tests/cpumap.c | 10 +++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 384d5e076ee4..9c83675788c2 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -322,9 +322,9 @@ struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
 /** Is 'b' a subset of 'a'. */
 bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b)
 {
-	if (a == b || !b)
+	if (a == b || perf_cpu_map__empty(b))
 		return true;
-	if (!a || b->nr > a->nr)
+	if (perf_cpu_map__empty(a) || b->nr > a->nr)
 		return false;
 
 	for (int i = 0, j = 0; i < a->nr; i++) {
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index f94929ebb54b..d52b58395385 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -128,13 +128,21 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
 	struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
 	struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
 	struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
+	struct perf_cpu_map *d = perf_cpu_map__dummy_new();
+	struct perf_cpu_map *e = perf_cpu_map__merge(b, d);
 	char buf[100];
 
 	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
 	cpu_map__snprint(c, buf, sizeof(buf));
 	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
-	perf_cpu_map__put(b);
+
+	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(e) == 3);
+	cpu_map__snprint(e, buf, sizeof(buf));
+	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "4-5,7"));
+
 	perf_cpu_map__put(c);
+	perf_cpu_map__put(d);
+	perf_cpu_map__put(e);
 	return 0;
 }
 
-- 
2.36.0.464.gb9c8b46e94-goog

