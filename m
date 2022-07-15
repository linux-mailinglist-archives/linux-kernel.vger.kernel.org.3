Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B30575BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiGOGhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiGOGh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:37:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91367459A5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31d17879672so33994647b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iTECb6Mg2TpLhaSw4nsYf3B3pkIu1Oc8fpNqlu+eD8g=;
        b=EG3JmQlm7C4iHUe9v6uHAbu+lKQCnHxibfDJGoXHrJ++HtVCsacBt+Lcd4mKW45BxF
         2MkrPG2NZSlexuGFwkKoL2Ax8zodlRAP7WQQTujWZcHJS2tNn5KimMkkRIz9vo+MAl8t
         a6OXUdic+gZwgjuyx8raYNLJM1GYNeLqt+XkuDrw/gKiD25KSEHRXkMmV6ZsGGVgCjfp
         QKeidEDD5+T6eWqO+pnuUeAxBu2RTjmL0isTMW6urRJ65yXbGGCfYefiDBxMIwCR0+/u
         l0ywPiq3Cb1W2Ac8uazzJWq4/60oyCQWGOgpxpvjemC2rvMG1FZQ940LDMlSYvAtEAX4
         ww5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iTECb6Mg2TpLhaSw4nsYf3B3pkIu1Oc8fpNqlu+eD8g=;
        b=yxtTZXKnJVyaO5F6tO4pg5Lnza6+dsI5Jip/S+GnnPS/yNxLFG0ZQQtfUi2qijxg3v
         7aIy/ubBM9AoO5+26ZNCglXNo/HPYfVy/AKHg8QdS6jcWldcHT6bi6iSJF5UBtnSCNU4
         /YpWOz/4dOamlBQRPVsAJH9VcAzZ8YUWKskk6O2Nlub2zLSpUfbbDzEO6yo3fUtYArSv
         eqBiISi1qIWYDN5pBXNwkorQ3ylwpJYoJUuVROKmY3MgxylIsc253YCwsP0+j5+cjWRu
         ct5fhi7P4ZqOguDQ9Py5XGxniiE/4zx1B+JucGkyM1IbxG/XOLr+pw9zMlV7POagrCa0
         /nQA==
X-Gm-Message-State: AJIora81GT7QW666cFoaRg8TLIw2U1B9p13y6ZNMogPq71O55PoJ1XTA
        z1ehOgJRAfugaaWST69pjMveaD+cI6DW
X-Google-Smtp-Source: AGRyM1skxuFPbwf3y0CFyGreJp4mNzxjKkWHySbqDDCcd4FomQaZiqj9KHEgZcuOEpz/0oYUPjMgXACGAwZz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e8fe:2a8e:e0f6:318d])
 (user=irogers job=sendgmr) by 2002:a5b:24a:0:b0:66f:939c:a643 with SMTP id
 g10-20020a5b024a000000b0066f939ca643mr12579689ybp.415.1657867043840; Thu, 14
 Jul 2022 23:37:23 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:36:42 -0700
In-Reply-To: <20220715063653.3203761-1-irogers@google.com>
Message-Id: <20220715063653.3203761-5-irogers@google.com>
Mime-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v1 04/15] perf jevents: Remove the type/version variables
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
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

pmu_events_map has a type variable that is always initialized to "core"
and a version variable that is never read. Remove these from the API as
it is straightforward to add them back when necessary.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 6 ++----
 tools/perf/pmu-events/jevents.py         | 6 ------
 tools/perf/pmu-events/pmu-events.h       | 2 --
 tools/perf/tests/expand-cgroup.c         | 2 --
 tools/perf/tests/parse-metric.c          | 2 --
 5 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 77e655c6f116..4182a986f505 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -110,15 +110,13 @@ static const struct pmu_event pme_test_soc_cpu[] = {
 
 const struct pmu_events_map pmu_events_map[] = {
 	{
+		.arch = "testarch",
 		.cpuid = "testcpu",
-		.version = "v1",
-		.type = "core",
 		.table = pme_test_soc_cpu,
 	},
 	{
+		.arch = 0,
 		.cpuid = 0,
-		.version = 0,
-		.type = 0,
 		.table = 0,
 	},
 };
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 2a9a1a086dee..c53c744da56b 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -313,8 +313,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
       _args.output_file.write("""{
 \t.arch = "testarch",
 \t.cpuid = "testcpu",
-\t.version = "v1",
-\t.type = "core",
 \t.table = pme_test_soc_cpu,
 },
 """)
@@ -330,8 +328,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
             _args.output_file.write(f"""{{
 \t.arch = "{arch}",
 \t.cpuid = "{cpuid}",
-\t.version = "{row[1]}",
-\t.type = "{row[3]}",
 \t.table = {tblname}
 }},
 """)
@@ -340,8 +336,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
   _args.output_file.write("""{
 \t.arch = 0,
 \t.cpuid = 0,
-\t.version = 0,
-\t.type = 0,
 \t.table = 0,
 }
 };
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 7a360792635f..a491b117c8ac 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -40,8 +40,6 @@ struct pmu_event {
 struct pmu_events_map {
 	const char *arch;
 	const char *cpuid;
-	const char *version;
-	const char *type;		/* core, uncore etc */
 	const struct pmu_event *table;
 };
 
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index dfefe5b60eb2..dc4038f997d7 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -197,8 +197,6 @@ static int expand_metric_events(void)
 	};
 	const struct pmu_events_map ev_map = {
 		.cpuid		= "test",
-		.version	= "1",
-		.type		= "core",
 		.table		= pme_test,
 	};
 
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 07b6f4ec024f..1b811a26f4ee 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -81,8 +81,6 @@ static struct pmu_event pme_test[] = {
 
 static const struct pmu_events_map map = {
 	.cpuid		= "test",
-	.version	= "1",
-	.type		= "core",
 	.table		= pme_test,
 };
 
-- 
2.37.0.170.g444d1eabd0-goog

