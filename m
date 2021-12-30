Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50E5481A43
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbhL3HWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237889AbhL3HWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:02 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD893C06137E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s83-20020a255e56000000b0060c46cc1890so21975329ybb.16
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cJxFT+Wieuw1JhmOKv6vMYAg7VBOnu+0BYOqRINi2fw=;
        b=AaHv8eORAJsQxS3I6J+wspo278XHNMt6cWHmkPeINdeVvH11+NxswWMDsad4x7P5iU
         wFWnpYfbaMzXhlXauKb2YPOklu8N4eAssGnSq3SpBE1EXifP/WJc40XmzDKnA8d15Fau
         +i4mG9wvHLxQChrj2VP/FX8/FaBAWkCtukNHvtnCP05sy913IDR9iB4lW7pYSaNbjPyP
         lNYvx7oPqTukT1sc0ZtP25ItEUr9cAINncuZy+9dA1z7aGpk7y/JncbOgnrLiJhgXaLM
         wSu2ozmiPMQzAyX7ov7N+rNVvThkH8FyKO1rJra4k+4vcaRMPYXd5iAnDC8NQzaERA4b
         Kk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cJxFT+Wieuw1JhmOKv6vMYAg7VBOnu+0BYOqRINi2fw=;
        b=HUB6ak3JXvmFLuSe5WvWzjljys0Qzdg6lpQIzefw0V1i+0gmU8J7cvhednIjnMx0BZ
         YMwrB7Fs7wRntkCCzhocY4q/rfqAYRglYdc/imKIxBO94bkbbaEWKMUiTrDHNYSMLcve
         lRsv3SxtV1TjMkVijy+4gCRPB3gE7qrDjXwgrmg7noMxwwjbMQ2dP/7q89tKLC3EbtiA
         WJQxUiS99qwrvMTWdZj2IJX4EuW3I4VYd74EHZiLz0EanmQU8tFBLQqZ5TV1gvH6Oa1O
         OIGNLW0X1tzQcI0Uxd4wt1UwMBe0ffiVFQ0p/v9OdT0KkWz/My6I5V0gAHIANxh2HVjT
         Raqg==
X-Gm-Message-State: AOAM531zDCXalGpJT3wMlXDrGlzcWEK+MbsT8MjVKTQYsEtU8txunxxw
        m+By2ZdcvWXPckscqfooUGpNTwFf1kRj
X-Google-Smtp-Source: ABdhPJytWKabroUG8HjyhF2QFoTqO1zK7EFRJ5h2dMTVhrWEAu4oyvBpIf//FFwcyF9lGBO1qvzQX2ZJ23s2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a5b:743:: with SMTP id s3mr22066829ybq.209.1640848916024;
 Wed, 29 Dec 2021 23:21:56 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:13 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-33-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 31/48] perf stat: Use perf_cpu_map__for_each_cpu
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct in print_counter where an index was being used as a cpu.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 7e933a8fee68..0f192360b6c6 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -4,6 +4,7 @@
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <math.h>
+#include <perf/cpumap.h>
 #include "color.h"
 #include "counts.h"
 #include "evlist.h"
@@ -732,7 +733,7 @@ static void print_aggr(struct perf_stat_config *config,
 		evlist__for_each_entry(evlist, counter) {
 			print_counter_aggrdata(config, counter, s,
 					       prefix, metric_only,
-					       &first, -1);
+					       &first, /*cpu=*/-1);
 		}
 		if (metric_only)
 			fputc('\n', output);
@@ -893,11 +894,11 @@ static void print_counter(struct perf_stat_config *config,
 	FILE *output = config->output;
 	u64 ena, run, val;
 	double uval;
-	int cpu;
+	int idx, cpu;
 	struct aggr_cpu_id id;
 
-	for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
-		struct aggr_data ad = { .cpu_map_idx = cpu };
+	perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
+		struct aggr_data ad = { .cpu_map_idx = idx };
 
 		if (!collect_data(config, counter, counter_cb, &ad))
 			return;
@@ -1248,7 +1249,7 @@ static void print_percore(struct perf_stat_config *config,
 
 		print_counter_aggrdata(config, counter, s,
 				       prefix, metric_only,
-				       &first, -1);
+				       &first, /*cpu=*/-1);
 	}
 
 	if (metric_only)
-- 
2.34.1.448.ga2b2bfdf31-goog

