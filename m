Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB34B233D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349025AbiBKKfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:35:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348976AbiBKKfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:35:06 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A076DF09
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:35:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s133-20020a252c8b000000b0062112290d0bso2930924ybs.23
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G677aq/uRJQFlNf2MOfZhMeeR+Ww2WAIN6eR7wWAbxk=;
        b=bUSLQ0bmmnsf8LyD0oerPrqmx9F06nj76AZL+2Kohv4lJmWs35/U9aB8laEaprIYcO
         EFWciz9LYvzUTG6EvUzn0IGrHO9xkmo6R2u/dDtuqpYFdrp+59B0IOR7cV3oeQ319BmO
         MRaqcnPJuGzeJ33HD+hLT6edOfMx085pat4x7HJRqneh6FmCc678fNssBnmyUAKK5RIj
         1KXK9Ef939OQ0PY4yMyCbSkjksRjTLIib92HsYB//+3mcelcrOcNaNVXSoz0Wg4NKkIj
         Mvzhs2qoZZK0gmuFAyjRW715QTGakOanIKSSS340ZpcLN095CxgrmwiangOqERPdwds1
         LkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G677aq/uRJQFlNf2MOfZhMeeR+Ww2WAIN6eR7wWAbxk=;
        b=zXuTz9mv0c+H2dy4wPjoAmqcex/lPt1IRPCW5GLFJfLeT7/UMW0B4htHdYS+O0o8v/
         rKBWk8aO5gy6IVQ6r/2h6V2DXvxbocGyZhJ3QITAhvhVq7DFF+WxtWkIVZzHIPbJYeoz
         dP/RblJnBpOobj5smZp8LRwoWFkULWIjxb1wPRSvTwNwtCYeLhPnL4VpAjVRdhRz4UOv
         5rXdVHIIltBpeWUOyyj1LrI4HGHZ5rfs2x6f5KYxO2py1oT14O8i1QZXSb04jL+2Si31
         /aV0EkRR4ggBiMStn7WiZJ+yVs4/PCBImnhT4R4AwNdtdWdum1a6SFzIhXqEuQT4Fe8r
         GXKg==
X-Gm-Message-State: AOAM532l5ZkWPQi55eZfbtqojXjoNo3QK3pCd7ftW7hY2+WOhjknSKM+
        kQUiyTV5N8s3byR06fuU0+4WK8P1+dLD
X-Google-Smtp-Source: ABdhPJxghSrSMMpEZbAslxqwwvel4CRcbGbXVSy/h5IKRrBTgZcWz+X77CZE8W6GCJva3K6YdMGmuIS7lreQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a81:d00d:: with SMTP id
 v13mr908075ywi.179.1644575700833; Fri, 11 Feb 2022 02:35:00 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:34:09 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-17-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 16/22] perf test: Add extra diagnostics to maps test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dump the resultant and comparison maps on failure.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/maps.c | 51 +++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index a58274598587..38c1ec0074d1 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include "tests.h"
@@ -17,22 +18,42 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 {
 	struct map_rb_node *rb_node;
 	unsigned int i = 0;
-
-	maps__for_each_entry(maps, rb_node) {
-		struct map *map = rb_node->map;
-
-		if (i > 0)
-			TEST_ASSERT_VAL("less maps expected", (map && i < size) || (!map && i == size));
-
-		TEST_ASSERT_VAL("wrong map start",  map->start == merged[i].start);
-		TEST_ASSERT_VAL("wrong map end",    map->end == merged[i].end);
-		TEST_ASSERT_VAL("wrong map name",  !strcmp(map->dso->name, merged[i].name));
-		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 1);
-
-		i++;
+	bool failed = false;
+
+	if (maps__nr_maps(maps) != size) {
+		pr_debug("Expected %d maps, got %d", size, maps__nr_maps(maps));
+		failed = true;
+	} else {
+		maps__for_each_entry(maps, rb_node) {
+			struct map *map = rb_node->map;
+
+			if (map__start(map) != merged[i].start ||
+			    map__end(map) != merged[i].end ||
+			    strcmp(map__dso(map)->name, merged[i].name) ||
+			    refcount_read(&map->refcnt) != 1) {
+				failed = true;
+			}
+			i++;
+		}
 	}
-
-	return TEST_OK;
+	if (failed) {
+		pr_debug("Expected:\n");
+		for (i = 0; i < size; i++) {
+			pr_debug("\tstart: %" PRIu64 " end: %" PRIu64 " name: '%s' refcnt: 1\n",
+				merged[i].start, merged[i].end, merged[i].name);
+		}
+		pr_debug("Got:\n");
+		maps__for_each_entry(maps, rb_node) {
+			struct map *map = rb_node->map;
+
+			pr_debug("\tstart: %" PRIu64 " end: %" PRIu64 " name: '%s' refcnt: %d\n",
+				map__start(map),
+				map__end(map),
+				map__dso(map)->name,
+				refcount_read(&map->refcnt));
+		}
+	}
+	return failed ? TEST_FAIL : TEST_OK;
 }
 
 static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
-- 
2.35.1.265.g69c8d7142f-goog

