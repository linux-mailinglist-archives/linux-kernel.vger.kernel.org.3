Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9059A4B2342
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbiBKKed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:34:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348908AbiBKKeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:34:24 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF92EAC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:23 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id u4-20020a170902a60400b0014dca32c59eso3069973plq.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1YSpc4YhDXxIYWJh2wErJ5BF47S0XjlsN9o5D+uT5lY=;
        b=qjOS6ucEdNfpe12GLjFydEh+KaauVgdEMR12xLgo/OfWmDK3MIQExMB9DsIv5BWR6h
         wqipmB9VfR0BmTqqsSIUxFIrdNX0NzzJAyaTodNiN3bTwGnIHLaB+ptKKr+GHFEGZitm
         RL6V1nCsqRlggO9hjae2jzEHWU3j7Uh+Bp7ffQdK95NWzxOCBOQI+FIuWtXScaQJ2JjC
         RXSI8C5nx9WAuUwZTCb8uCleWtfRoq6GPa6QNQ1TkJ3bfCCAVCnOHs6JDhtKHW5sHv3Z
         7WuDaMFLfwGTGZhO9kUEyyiFk2/SmjM5ZOf1pwOKB1h63ltAk+nrhEFc/97cz6chTOrZ
         mG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1YSpc4YhDXxIYWJh2wErJ5BF47S0XjlsN9o5D+uT5lY=;
        b=SkomXhOnwR1QqtNBJhG4Fon+SyODnuV0K+SZKFuN9uW+8u5ZStRHSM/97O5fRQ8wZS
         mYJzDxZ7WtG/qdttfJIKyr1+u1dlEodcZGaWglwgAkdEdypulbqo2eNOphl/i+3Xtl+X
         bHWLlN0vsr+uAlVf3/zTMykwlkv0i5Ja/s6Uxr1notY35hSw8N/iNhYdteVKPkF/WhPH
         YjDPVOZ8xxG2MsnqJxczdDD7CpIuN2V1eJ1rnMDgoSnXEIPApfmtIshB1JYt7pwA9S5V
         tfLs6Ukx/fIBpmUJr0Swt51uBZt/k/F67+N2bRQDeODX5D6aKmQLtoKTiaxEmE5x++iU
         FTQA==
X-Gm-Message-State: AOAM5305XuMw7UF+j57S8H8CyRHG4xENaa/Bno0fI+44WDWhTC/y7pnI
        wrRfPgZQ9bMZTeo1L5C8uLarZvQFaRQg
X-Google-Smtp-Source: ABdhPJxTBfqOigPoEX9wGXapHTWuWWdOfcfUfGvkcZ6xKfNyYTb8dRNrdEdRh10mUl2WeAdvVlh3jaavjK6G
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a05:6a00:1682:: with SMTP id
 k2mr1067116pfc.69.1644575662878; Fri, 11 Feb 2022 02:34:22 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:33:54 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-2-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 01/22] perf cpumap: Migrate to libperf cpumap api
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from directly accessing the perf_cpu_map to using the appropriate
libperf API when possible. Using the API simplifies the job of
refactoring use of perf_cpu_map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/cpumap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 84e87e31f119..f94929ebb54b 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -35,10 +35,10 @@ static int process_event_mask(struct perf_tool *tool __maybe_unused,
 	}
 
 	map = cpu_map__new_data(data);
-	TEST_ASSERT_VAL("wrong nr",  map->nr == 20);
+	TEST_ASSERT_VAL("wrong nr",  perf_cpu_map__nr(map) == 20);
 
 	for (i = 0; i < 20; i++) {
-		TEST_ASSERT_VAL("wrong cpu", map->map[i].cpu == i);
+		TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, i).cpu == i);
 	}
 
 	perf_cpu_map__put(map);
@@ -66,9 +66,9 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong cpu",  cpus->cpu[1] == 256);
 
 	map = cpu_map__new_data(data);
-	TEST_ASSERT_VAL("wrong nr",  map->nr == 2);
-	TEST_ASSERT_VAL("wrong cpu", map->map[0].cpu == 1);
-	TEST_ASSERT_VAL("wrong cpu", map->map[1].cpu == 256);
+	TEST_ASSERT_VAL("wrong nr",  perf_cpu_map__nr(map) == 2);
+	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 0).cpu == 1);
+	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 1).cpu == 256);
 	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
 	perf_cpu_map__put(map);
 	return 0;
@@ -130,7 +130,7 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
 	struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
 	char buf[100];
 
-	TEST_ASSERT_VAL("failed to merge map: bad nr", c->nr == 5);
+	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
 	cpu_map__snprint(c, buf, sizeof(buf));
 	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
 	perf_cpu_map__put(b);
-- 
2.35.1.265.g69c8d7142f-goog

