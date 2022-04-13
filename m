Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05A94FF35B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiDMJZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiDMJZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:25:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153AA532F5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:23:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so5700637pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wRXirUEKSPI6ru648JuWYPXw/sXNZVfeivfow6gXxCU=;
        b=NSQWSk7KTjgR1R43JsBYQ1pozNWfaSSFh31fwZQJRY/JP0eqmDA4oV+tGsAdykD2UZ
         uOhRQMH6sGK7PYixM4yd9JfnUZlo/Fvhe4Kc40ApShO3t4147mY0e28258Jvb1QRyrkf
         XRWBeAQfIitmvcJGeRhFHMfaJQbQy5QvBslX0upT5e/VM2JcnHtDMCipGIG7g4PBxd1k
         aM95mmBKUp+K6Y1ygBJTrdluHuatVEtlYJB7WNHlrv80hht0ytKkjUoXfbRcFL19/zu6
         d//4NBZ+dPv7IBQrIRDAIKpmdAN+UY3N5N52oejxrZ4V7nShq6noho/95AFQtyDKYiUw
         WqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wRXirUEKSPI6ru648JuWYPXw/sXNZVfeivfow6gXxCU=;
        b=CXLNEBkGe1U3RN0A+mi3B53Y/LzjwKOoQbXWwd59eUWIjTP4yv8C30th1fl0ye1G1A
         S5ndkdb6yeBz/qa3HxAUWjy7e9Vijd3OWhpsLiWbvH3i7/zEjmJHtFXYIsok1HjNX6Mc
         2UfTPLkPltWw+A7DFWk8LY2A46sLQEZJWGkJG9H/ZRpVBw69yFWm1llcvLKZJB8QSI/1
         rYv0BzM1r5hXDvZUklZ5h4+jLaVL1bsVcjH73Xi7YKBw8GWL80WgL+wk5/GhQovH8W7A
         Vw4+w1Xwpg1kGgzsLer1ijh/rnnkMbd6AYM01eWkwU4uHP6gnY6uEc+rLTfEZDIFJ6Wh
         ycew==
X-Gm-Message-State: AOAM530Cl73sOXDBt3nkdm3ouMFSld/lAxh51KtC/NL6uVb+TPieUVMb
        R2juG3k6rT9OVik5QW1VslUYDg==
X-Google-Smtp-Source: ABdhPJyZnbZbZZKVFPTF/SFu5yucL9hFbgSI04LlY+Sq49nPD/NAIJHwFuLlpA9dtv6xAvAk52XDFQ==
X-Received: by 2002:a17:90b:1c88:b0:1b8:a77e:c9cb with SMTP id oo8-20020a17090b1c8800b001b8a77ec9cbmr9622873pjb.205.1649841809256;
        Wed, 13 Apr 2022 02:23:29 -0700 (PDT)
Received: from localhost.localdomain (111-250-44-108.dynamic-ip.hinet.net. [111.250.44.108])
        by smtp.gmail.com with ESMTPSA id k62-20020a17090a4cc400b001c7ea7f487asm2363144pjh.39.2022.04.13.02.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:23:28 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2] perf report: Set PERF_SAMPLE_DATA_SRC bit for Arm SPE event
Date:   Wed, 13 Apr 2022 17:23:17 +0800
Message-Id: <20220413092317.756022-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bb30acae4c4d ("perf report: Bail out --mem-mode if mem info
is not available") "perf mem report" and "perf report --mem-mode"
don't report result if the PERF_SAMPLE_DATA_SRC bit is missed in sample
type.

The commit ffab48705205 ("perf: arm-spe: Fix perf report --mem-mode")
partially fixes the issue.  It adds PERF_SAMPLE_DATA_SRC bit for Arm SPE
event, this allows the perf data file generated by kernel v5.18-rc1 or
later version can be reported properly.

On the other hand, perf tool still fails to be backward compatibility
for a data file recorded by an older version's perf which contains Arm
SPE trace data.  This patch is a workaround in reporting phase, when
detects ARM SPE PMU event and without PERF_SAMPLE_DATA_SRC bit, it will
force to set the bit in the sample type and give a warning info.

Fixes: bb30acae4c4d ("perf report: Bail out --mem-mode if mem info is not available")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: German Gomez <german.gomez@arm.com>
---
v2: Change event name from "arm_spe_" to "arm_spe";
    Add German's test tag.

 tools/perf/builtin-report.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1ad75c7ba074..acb07a4a9b67 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -353,6 +353,7 @@ static int report__setup_sample_type(struct report *rep)
 	struct perf_session *session = rep->session;
 	u64 sample_type = evlist__combined_sample_type(session->evlist);
 	bool is_pipe = perf_data__is_pipe(session->data);
+	struct evsel *evsel;
 
 	if (session->itrace_synth_opts->callchain ||
 	    session->itrace_synth_opts->add_callchain ||
@@ -407,6 +408,21 @@ static int report__setup_sample_type(struct report *rep)
 	}
 
 	if (sort__mode == SORT_MODE__MEMORY) {
+		/*
+		 * FIXUP: prior to kernel 5.18, Arm SPE missed to set
+		 * PERF_SAMPLE_DATA_SRC bit in sample type.  For backward
+		 * compatibility, set the bit if it's an old perf data file.
+		 */
+		evlist__for_each_entry(session->evlist, evsel) {
+			if (strstr(evsel->name, "arm_spe") &&
+				!(sample_type & PERF_SAMPLE_DATA_SRC)) {
+				ui__warning("PERF_SAMPLE_DATA_SRC bit is not set "
+					    "for Arm SPE event.\n");
+				evsel->core.attr.sample_type |= PERF_SAMPLE_DATA_SRC;
+				sample_type |= PERF_SAMPLE_DATA_SRC;
+			}
+		}
+
 		if (!is_pipe && !(sample_type & PERF_SAMPLE_DATA_SRC)) {
 			ui__error("Selected --mem-mode but no mem data. "
 				  "Did you call perf record without -d?\n");
-- 
2.25.1

