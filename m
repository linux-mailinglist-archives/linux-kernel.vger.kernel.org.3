Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1AB5769F1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiGOWfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiGOWfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:35:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA26C108
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:35:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r16-20020a257610000000b0066f5239588eso4783833ybc.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Jr53tgo6pPtSm720C8wiHjlk7XjKJWW+YOa2HOTSwBk=;
        b=nxCFMMK7okp6PcYQszzFL7Pkq85ar+xehe9K+lNxnEcxIix+Fllvyo8hDDDJIv59m4
         0BrmBLRkkCD7gT8uFqKb1AJVaPdKCAgo9pAVHhdR400pdP24pyp08yCQtuQ6qbCOKNH0
         ok/DVKokk/sYzVJHYOecs+hV6Mob8ATctQpItggNN4rAoZHRFZ8ebRcd+uPl8blCtogd
         AJA3IH+2kSDDsHZkwboTb+XHMJhD9C2DHuDAI9bmVwPTkNUFk1N4owxnWN3lDmQlJC17
         JGfCOXLgtzenGEPy3jAvoMq3s8LZ2AkVktQ5Nvd/H4+P+14Jm9/l2pxpk/rUnMLP9Bj5
         BBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jr53tgo6pPtSm720C8wiHjlk7XjKJWW+YOa2HOTSwBk=;
        b=SgidoGQVxZvf0u/jMt9+upj5b/OWdMQBYeFta3Ep4x8RMV2l9IKGB3pdrxEBbpXh9o
         UunchiIzSRSNYeR1UHemrJq5Axpbsr8vdS2fZOxnlD9EG2zfIWisbM7q0aFr+hnONXPa
         cS+9sftmNWyi+57NtYU5qXlbAUXyuXOFc0aT5se5FwfIpr+B+sZUGy+ferlxyUMX+gGT
         uEaT+05XJzIx/GRFb/DTPC29H057bRj+/GEpvdNa06USAh3ZVyTOuo3gb9DLcD4h4i2z
         HzwmjgMDqP9lVGUaOLzRY4s/20w8N7vwJTmUxBv8UU31tcfic/16Z27yidp6aTsL/40K
         L/ew==
X-Gm-Message-State: AJIora82AsL4NG+KAbAcJL1aQtA/HsLrb+pSdr0cZA/wPhf+VXuYp85c
        RbMq3drp/YSsiKOtCVtMYKhi8tE9gb3g
X-Google-Smtp-Source: AGRyM1vgU8ro3WU7pMf71EqDWZhvbhbOjrSPyemVok5CitutWzRVlfFvrSr4djCS+u/ExEJUG7ZSOlBig+Qf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:72de:b499:63be:efe1])
 (user=irogers job=sendgmr) by 2002:a25:bdc6:0:b0:66e:3b23:55f6 with SMTP id
 g6-20020a25bdc6000000b0066e3b2355f6mr16485350ybk.230.1657924528660; Fri, 15
 Jul 2022 15:35:28 -0700 (PDT)
Date:   Fri, 15 Jul 2022 15:35:20 -0700
In-Reply-To: <20220715223521.3389971-1-irogers@google.com>
Message-Id: <20220715223521.3389971-2-irogers@google.com>
Mime-Version: 1.0
References: <20220715223521.3389971-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v3 1/2] perf metrics: Add literal for system TSC frequency
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Such a literal is useful to calculate things like the average frequency
[1]. The TSC frequency isn't exposed by sysfs although some experimental
drivers look to add it [2]. This change computes the value using the
frequency in /proc/cpuinfo which is accruate at least on Intel
processors.

[1] https://github.com/intel/perfmon-metrics/blob/5ad9ef7056f31075e8178b9f1fb732af183b2c8d/SKX/metrics/perf/skx_metric_perf.json#L11
[2] https://github.com/trailofbits/tsc_freq_khz

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 15 +++++++++++++
 tools/perf/util/expr.c  | 49 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

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
index 675f318ce7c1..4c81533e4b43 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -402,6 +402,50 @@ double expr_id_data__source_count(const struct expr_id_data *data)
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
@@ -417,6 +461,11 @@ double expr__get_literal(const char *literal)
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
2.37.0.170.g444d1eabd0-goog

