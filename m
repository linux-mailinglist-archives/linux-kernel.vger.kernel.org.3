Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED24D4B2340
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348965AbiBKKej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:34:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348943AbiBKKe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:34:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A3EB1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 2-20020a251302000000b006118f867dadso17901181ybt.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zZqjerFyUzn9J1iLxHpLoHFf7aGVnScfvGTlvzc2WOA=;
        b=kZbSx2/JG2RC+HrevtaSHlt+chqBCEgACB3vxiIuRd8ty5sIjcAakIpIdDs2A7fZM7
         fG9q8IRjuhPtWmnte6QNtaoki3X87mjjo51QAsIFmUW9CAJY+zdB0syIWQ4bxTdLbIrH
         W5gyqVXceGN+I7V3c4dgPvu5MGDk6/0gSH3mg5eOZcPJ8BLZHWkwMGGnaLeziiw8ZnGi
         0hPYMmyZv0XhufzooHJC4L7R7ppAIoLfhBdK47TFJs+N1tOoV7m0I+OVQVODEqF5q0k8
         dmyHczuH5c9T3LeGTA4Uh4SlOggn6wf8yXNmuXEGDMM27jEEwuAKMkGyUH63Bp1vjXcM
         5eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zZqjerFyUzn9J1iLxHpLoHFf7aGVnScfvGTlvzc2WOA=;
        b=XennwPy0eg68AjP6GqpEguleK0TFa936vTHBJFvY3xGvijDPm5P3VCfV3ZWA1HsDMW
         oAjF6de1sC9MlYi0XE6vEsxDkZ4FLoawYkW844sdv3/mTIzbCuOWZzw+mv6k6uIwSf8c
         A1SlYh6LLxnLxde83dx44jAC3xZerV5kIdn3apVLdKEhfXUbyfw+V7xpF3uBZeZ7im/K
         OHQbMq+kgDVdNg77ZQZsYn8YT0nIwo3VBbk9Lj0Yxjm8LW4Xm6Ex2Ro8watI3gp+wBha
         1IBWAko4C73CG4j2L1CykIxZn2QLgkjM82OTQ7AXJ1MIyhkPGCSWe+uSxmTfZgeDWnxF
         sCwQ==
X-Gm-Message-State: AOAM533sbziWytZyK9fI6+7cBDGsGLQsDJd7U/DlyUSupvI/pKGG8k8W
        Mo3GVN3zO4u6d0toWOv810f7WyH1rPJw
X-Google-Smtp-Source: ABdhPJzVflHjs1qka6WQPmyROhtJTQf9pViBPc/+f9TWgA1LiYueSSAE/42s1WoomHEliWcXiN2OuPqCw/Mt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a81:a403:: with SMTP id
 b3mr903675ywh.310.1644575665364; Fri, 11 Feb 2022 02:34:25 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:33:55 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-3-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 02/22] perf cpumap: Use for each loop
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

Improve readability in perf_pmu__cpus_match by using
perf_cpu_map__for_each_cpu.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8dfbba15aeb8..9a1c7e63e663 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1998,7 +1998,8 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
 {
 	struct perf_cpu_map *pmu_cpus = pmu->cpus;
 	struct perf_cpu_map *matched_cpus, *unmatched_cpus;
-	int matched_nr = 0, unmatched_nr = 0;
+	struct perf_cpu cpu;
+	int i, matched_nr = 0, unmatched_nr = 0;
 
 	matched_cpus = perf_cpu_map__default_new();
 	if (!matched_cpus)
@@ -2010,14 +2011,11 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
 		return -1;
 	}
 
-	for (int i = 0; i < cpus->nr; i++) {
-		int cpu;
-
-		cpu = perf_cpu_map__idx(pmu_cpus, cpus->map[i]);
-		if (cpu == -1)
-			unmatched_cpus->map[unmatched_nr++] = cpus->map[i];
+	perf_cpu_map__for_each_cpu(cpu, i, cpus) {
+		if (!perf_cpu_map__has(pmu_cpus, cpu))
+			unmatched_cpus->map[unmatched_nr++] = cpu;
 		else
-			matched_cpus->map[matched_nr++] = cpus->map[i];
+			matched_cpus->map[matched_nr++] = cpu;
 	}
 
 	unmatched_cpus->nr = unmatched_nr;
-- 
2.35.1.265.g69c8d7142f-goog

