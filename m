Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87469517C62
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 06:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiECEWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 00:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiECEVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 00:21:43 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FF13CA74
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 21:18:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7ee6bc6ddso152082467b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 21:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qZYkK0QiKq2QKPszwBBc5ZNarCxrPY8dG8RgsS3qw5I=;
        b=fz9PewPyxjyTQCArVvRbymNYsWXATr1fj+gd6LaOOTRE5kG4bgI8Lf2sJ+gw0H38Wv
         /6tKf7w0KAU0cFq6Z8ZHgpfq57G0ENDBSTS2QnNY1FGoWVqNRKYiN2InHXvgYHuZmdXY
         R8+OtNyphACNsriRlxgKJJgY2acJJPQf7jlXveW8ycK1LfsjSBCtLM+pMBU7kS7mKu7x
         bmBf3wDsYFw+BVfNud9SoRSUH7GTOSFQg5MjRcLgpGA1psmuKLn/wiUdZwRmlLK+ap78
         KJrIc2WDt5JJBcBvk3n48RiFgW7vGkEpJml7ltCRl6tUOst4RJGtMTPnvHmLj62p2APD
         aa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qZYkK0QiKq2QKPszwBBc5ZNarCxrPY8dG8RgsS3qw5I=;
        b=iFZm+0ZGKQmKjMhFOsT6UPAns8LEE6Pueu6+Ntcq2YzThxGJf1ayfIeVINbBz61vQ1
         hrFyLwMKv3AX8qwg8RhmE0Ri3KQhg3T46gu3oMEfXiDxwQ4sct5zi2ocxq2To2RlRGaW
         z6SEyPQelibFR1DUyvHN5IEbcuKh5mAMQS1P/k1YOYiBcl+jffAAU7bx2AmALZUCIW9J
         c2dbCRawaeRhCTHtWG11mWL9MBc4rRcrR116SQ0q/fsuUqqhuRDN/b7HO0VpBXJ1IXsq
         iFMMPcia5M75nep0aD6v0X/QKoCQY8+Tnp/Bvc+Xk01qreQCpf6cXgsPjDQwIe1L4et2
         7+CA==
X-Gm-Message-State: AOAM530+6gCKA7izTz6lRSxl+vh0SxgVy+JsgKAp5DhwfnESxeGLUSsB
        NOjTRuu+njNH6YlGm5moQ4dFjcKNywJu
X-Google-Smtp-Source: ABdhPJx077Sx6pfDuCYkY9uKRPc4HO/I1fDmQkMxNFkxBO6TpMeXvcgzxUzF4eAREwfCmgFo6NmMk9+B9O/+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dd4b:52bb:771d:7bb4])
 (user=irogers job=sendgmr) by 2002:a81:1107:0:b0:2f7:cf9a:bd7 with SMTP id
 7-20020a811107000000b002f7cf9a0bd7mr13980584ywr.482.1651551491508; Mon, 02
 May 2022 21:18:11 -0700 (PDT)
Date:   Mon,  2 May 2022 21:17:55 -0700
In-Reply-To: <20220503041757.2365696-1-irogers@google.com>
Message-Id: <20220503041757.2365696-5-irogers@google.com>
Mime-Version: 1.0
References: <20220503041757.2365696-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v5 4/6] perf cpumap: Handle dummy maps as empty in subset
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

