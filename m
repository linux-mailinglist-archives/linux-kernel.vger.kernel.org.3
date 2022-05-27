Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85E453582B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 06:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbiE0EEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 00:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbiE0EEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 00:04:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED5FEBEB8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:04:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 123-20020a251181000000b0065a17184c2fso1342981ybr.22
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=j18U4kkoV3/OvD/NxmpbujJMFVrALYJLqrC/u8afB3Y=;
        b=rYOMuXfxQ0JMU55WylL/alxBXhjaeUWA5X7tZBAwe9tOtz2AOZ8KCHRjhZ705+9yQ2
         Y+P9oC528jBkB8vZ9rFzUMutNg8Bm1yGLd8zW0F28KxsbNb6ArmoFwQphF2i+SEMjpWB
         lTbAlyf6Oysye0qwhGrWi0W0NJEaFIBU150aTjyubMivPjBYzefYIZ+92QPbBbUm01jD
         w2sEMPIaiYQpejOqYrCQkH2cHeULS4Ieyp4gXI0NUjzwA0vBETe3VCPkQXIN0lpjrQWg
         Fg3gm8newNcfcniJ76t4WcX1SuDEQF4HefnhqXmiDpQuuiDqF6tk+a6uVU7xUM4LR2W/
         3OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=j18U4kkoV3/OvD/NxmpbujJMFVrALYJLqrC/u8afB3Y=;
        b=Bos6fGyPMnaHGdGXCHPYT6cLkGsSDUhElCDZTE2rgrfdN5D6JsHhjXSEZR7pvpKetW
         PPkm0wkI35Xw2F5FXKgUwK0nsYT9ToZFQdZhajx479JfX7okt5vqA2ptExN5NR83jh+I
         tMB6tQ01aovMiiKLhCJAsxxJ8gXfmLPp8bTDyqAzg0npB+n5/eGwtR2PhGGQ/VXNi8Ks
         CqIqP5ICc/cxgKd3USe0p9+2cFuuivaj/frn9iETqjqSfizn97OQDbTq01sLLHfJ5AVI
         sT9cMonBpklX+eIFVQ78e6e/g3iqPJIk80x/4V3bogubBUUAWnonmp+LMalkUIdBvLgx
         xUlw==
X-Gm-Message-State: AOAM531eccZ/aGEaTfiugsOg/lcPtCqqbdXWdiFemPbm1D+cdEwd1HIl
        nJ1cYwdBNOyTbLP6BN1bqRdoUlttspqC
X-Google-Smtp-Source: ABdhPJxiKaIsaMY5drcO/BtwaU7AIZX/u+pgXW+4vC6FrTrFesrwAr2lSAr2/eRT+aIiaTg2K6xJv/M3KFEl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4b39:e167:e698:7d4])
 (user=irogers job=sendgmr) by 2002:a0d:d003:0:b0:2eb:6441:d9a3 with SMTP id
 s3-20020a0dd003000000b002eb6441d9a3mr41096784ywd.273.1653624251555; Thu, 26
 May 2022 21:04:11 -0700 (PDT)
Date:   Thu, 26 May 2022 21:04:07 -0700
Message-Id: <20220527040407.4193232-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v2] perf metrics: Add literal for system TSC frequency
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

Such a literal is useful to calculate things like the average frequency
[1]. The TSC frequency isn't exposed by sysfs although some experimental
drivers look to add it [2]. This change computes the value using the
frequency in /proc/cpuinfo which is accurate at least on Intel
processors.

v2. Adds warnings to make clear if things have changed/broken on future
    Intel platforms. It also adds caching and an Intel specific that a
    value is computed.

[1] https://github.com/intel/perfmon-metrics/blob/5ad9ef7056f31075e8178b9f1fb732af183b2c8d/SKX/metrics/perf/skx_metric_perf.json#L11
[2] https://github.com/trailofbits/tsc_freq_khz

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 15 +++++++++++++
 tools/perf/util/expr.c  | 50 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 5c0032fe93ae..45afe4f24859 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/debug.h"
 #include "util/expr.h"
+#include "util/header.h"
 #include "util/smt.h"
 #include "tests.h"
+#include <math.h>
 #include <stdlib.h>
 #include <string.h>
 #include <linux/zalloc.h>
@@ -69,6 +71,11 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	double val, num_cpus, num_cores, num_dies, num_packages;
 	int ret;
 	struct expr_parse_ctx *ctx;
+	bool is_intel = false;
+	char buf[128];
+
+	if (!get_cpuid(buf, sizeof(buf)))
+		is_intel = strstr(buf, "Intel") != NULL;
 
 	TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
 
@@ -175,6 +182,14 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	if (num_dies) // Some platforms do not have CPU die support, for example s390
 		TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
 
+	if (is_intel) {
+		double system_tsc_freq;
+
+		TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&system_tsc_freq, ctx,
+								"#system_tsc_freq") == 0);
+		TEST_ASSERT_VAL("!isnan(#system_tsc_freq)", !isnan(system_tsc_freq));
+	}
+
 	/*
 	 * Source count returns the number of events aggregating in a leader
 	 * event including the leader. Check parsing yields an id.
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 675f318ce7c1..f33aeb1e6faa 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -402,6 +402,51 @@ double expr_id_data__source_count(const struct expr_id_data *data)
 	return data->val.source_count;
 }
 
+/*
+ * Derive the TSC frequency in Hz from the /proc/cpuinfo, for example:
+ * ...
+ * model name      : Intel(R) Xeon(R) Gold 6154 CPU @ 3.00GHz
+ * ...
+ * will return 3000000000.
+ */
+static double system_tsc_freq(void)
+{
+	static double result;
+	static bool computed;
+	FILE *cpuinfo;
+	char *line = NULL;
+	size_t len = 0;
+
+	if (computed)
+		return result;
+
+	computed = true;
+	result = NAN;
+	cpuinfo = fopen("/proc/cpuinfo", "r");
+	if (!cpuinfo) {
+		pr_err("Failed to read /proc/cpuinfo for TSC frequency");
+		return NAN;
+	}
+	while (getline(&line, &len, cpuinfo) > 0) {
+		if (!strncmp(line, "model name", 10)) {
+			char *pos = strstr(line + 11, " @ ");
+
+			if (pos && sscanf(pos, " @ %lfGHz", &result) == 1) {
+				result *= 1000000000;
+				goto out;
+			}
+		}
+	}
+
+out:
+	if (isnan(result))
+		pr_err("Failed to find TSC frequency in /proc/cpuinfo");
+
+	free(line);
+	fclose(cpuinfo);
+	return result;
+}
+
 double expr__get_literal(const char *literal)
 {
 	static struct cpu_topology *topology;
@@ -417,6 +462,11 @@ double expr__get_literal(const char *literal)
 		goto out;
 	}
 
+	if (!strcasecmp("#system_tsc_freq", literal)) {
+		result = system_tsc_freq();
+		goto out;
+	}
+
 	/*
 	 * Assume that topology strings are consistent, such as CPUs "0-1"
 	 * wouldn't be listed as "0,1", and so after deduplication the number of
-- 
2.36.1.124.g0e6072fb45-goog

