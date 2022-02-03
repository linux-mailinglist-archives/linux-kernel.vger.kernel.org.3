Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98AE4A7D40
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348764AbiBCBIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348761AbiBCBH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:07:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43282C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 17:07:58 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b2-20020a252e42000000b00619593ff8ddso2786385ybn.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 17:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WTSM/Ey8czEzcwGcL51YHkWEcToZ/GKdI9Mm0emyAmc=;
        b=V2vKILSsWMvJ2qw/+k4HIkIrxtEnW+re9aBErBDOdPH+M9Z1/P+/XTVyfbnk+QAlvs
         gPXT5qlGN8V91uIwlJgQIKvrrq6RZwrIMbVodE2Fw4AukWtaqQUXGxa9/PJtn9Sa/sO+
         O6VYchWGl1lBrFEYKfC4zXTi0jkI2o6DUQiiTNVz0Q0MM1c4oaKKNcv2u4dArGaS3QDx
         M+WL0R4iDd6YdDV6GeucvB5jETdQ03sMcdfX1JxD4O/kKzFJ5DgHkmmQgSQNKToeF8Gf
         b54ce+2HjwPokDuylzA4/xO4N3UHJBT9jll1PxPihnDfiChcwmnXlxHvc5hWsA020rTw
         +4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WTSM/Ey8czEzcwGcL51YHkWEcToZ/GKdI9Mm0emyAmc=;
        b=hpdUx2hoWBilnyh8OaGmQxv/OB29PdaAH1S0kWeHPQKCHIS7WM8cjaH5bpkQVkKALc
         IwRRrX4k/RoKaWZzHcCSCEXyj/Tpfb3liBPwO5+NkrIj81qUcuEJgvsM2oxtLFKs6kGv
         BNVpaUUNvPq36Hxdd/1iWPqUx/aiFv7R1gZhtJUftE9FeZFOtN5FsVYGqVjUHqzt9NWi
         DqqdsHHk9EHbvBDs0eUFu3iNxXpVLGWS0tTx+DUz1nGqAylr122p84ersMxoc0fP7T7z
         VbYaE4wkPlhgDQPtPoQ2RPyUXGwm6NPuHzi0+KfF4iq7eQw8ktL15n3CyqMsqzFSjbem
         TQMQ==
X-Gm-Message-State: AOAM532E75sF/+Kr4pgWCMedft0NQGuZwWCX+PdF89nuMwdCqkk9kynh
        yDdEfnouc6ijmuiQEgHnhpw33yIAIRUt
X-Google-Smtp-Source: ABdhPJxksByH6JrfNz5aNFppOFUEclCDmfrNryMqeH5lKtX5axXHHiWG5QnrHZMjzBMj+CZMLiVaQ9cbnoGr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:adf2:a985:b1bf:dcb8])
 (user=irogers job=sendgmr) by 2002:a81:18c2:: with SMTP id
 185mr2720805ywy.150.1643850477407; Wed, 02 Feb 2022 17:07:57 -0800 (PST)
Date:   Wed,  2 Feb 2022 17:07:46 -0800
Message-Id: <20220203010746.610494-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH] perf metrics: Add literal for system TSC frequency
From:   Ian Rogers <irogers@google.com>
To:     vineet.singh@intel.com, perry.taylor@intel.com,
        caleb.biggers@intel.com, asaf.yaffe@intel.com,
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
 tools/perf/util/expr.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 675f318ce7c1..7ad01ed57025 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -402,6 +402,43 @@ double expr_id_data__source_count(const struct expr_id_data *data)
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
+	double result = NAN;
+	FILE *cpuinfo;
+	char *line = NULL;
+	size_t len = 0;
+
+	cpuinfo = fopen("/proc/cpuinfo", "r");
+	if (!cpuinfo)
+		return NAN;
+
+	while (getline(&line, &len, cpuinfo) > 0) {
+		if (!strncmp(line, "model name", 10)) {
+			char *pos = line + 11;
+
+			while (*pos != '@')
+				pos++;
+			if (sscanf(pos, " %lfGHz", &result) == 1) {
+				result *= 1000000000;
+				goto out;
+			}
+		}
+	}
+
+out:
+	free(line);
+	fclose(cpuinfo);
+	return result;
+}
+
 double expr__get_literal(const char *literal)
 {
 	static struct cpu_topology *topology;
@@ -417,6 +454,11 @@ double expr__get_literal(const char *literal)
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
2.35.0.rc2.247.g8bbb082509-goog

