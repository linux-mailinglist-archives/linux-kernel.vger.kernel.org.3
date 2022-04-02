Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E134F0139
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbiDBLoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbiDBLoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:44:30 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7291AC434;
        Sat,  2 Apr 2022 04:42:39 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u12so2366972plg.10;
        Sat, 02 Apr 2022 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMCH8+k8mi8CVOq2Z6XfO7zpnKBOVIxcMzw+MudraPw=;
        b=qGNoG1aDXoQE/0DDlzz4WZ4UxisAHslQvBfhiOgKhbl/xbx0BRcxIyvcH7zx3hSalB
         15o+VSVrJd0Lfim3YCYbBxTXRFMLYXIlS/BkKm8/KBou6zj+n+B/MGBCeoCw8LxLVsPX
         jhlT7N1xTHZl9d1G3uUVaQ++DLPoNnBhru3odXwr/tlgXg7Xcbnto4VP7jw2gw6JSRva
         MKFBcpXSlj4PwR/bS2yoRNBdQn28Z8MDV3GyIDcfqyQQgbRo0N8Yxg9otmimZD4ZYryK
         Jtq5TbiDsQrcaggeEOAvRLvAm9MrO3TngeNP+DlNVsElS+kZFhtqeYCXE3FT7B/8bQTZ
         FuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMCH8+k8mi8CVOq2Z6XfO7zpnKBOVIxcMzw+MudraPw=;
        b=wbyYkx8QeoL9wnpouBhsYy6Dxy7S+V8kSDtxAIMKuvXAxDl1upC5fZXCbXr6KPbxq0
         Kt8I9OkCE2X+L7TnTSsrPfXrQGiVnFuFGSJJSysnU6+PDPp7QO6EQYjiPhdSbFQ1Lu+7
         RCPHbyprEjgtzD39s8Ao98LP2j2eWfGVOMsfjSsPa3T5WFQzcOWt+bM5aCg++ZvgmPB/
         Cqp4pyUN1nyAdz82NVKWObfDEDhLK8uHGWyuUBKy1T1VtVtaU6Uu6mHEemynyovBnBRy
         JBv7Mx0TCMWUMa1J1//NA8z7DbAxh8p49gnFOuFC3cCIbXDKon28c8suSEf4/4pONjBS
         fHgA==
X-Gm-Message-State: AOAM530R1nyidnjC+05D4wMrT0BISVhLO5lSvY+5MN6yVyNlPFpBQtHR
        3BXeTSwuBTZVtXyffYy2dWg=
X-Google-Smtp-Source: ABdhPJyGE/PvhIYSQnp1GtxLqjsmb2YXxXtjIY5muGVs06bAyeJHLbF21gtTyl7pjMfIbK4+aj/nPw==
X-Received: by 2002:a17:90a:182:b0:1ca:626f:1a73 with SMTP id 2-20020a17090a018200b001ca626f1a73mr1923393pjc.235.1648899758712;
        Sat, 02 Apr 2022 04:42:38 -0700 (PDT)
Received: from CHENGDONGLI-MB0.localdomain ([203.205.141.111])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm15589829pjl.39.2022.04.02.04.42.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Apr 2022 04:42:37 -0700 (PDT)
From:   Chengdong Li <brytonlee01@gmail.com>
X-Google-Original-From: Chengdong Li <chengdongli@tencent.com>
Received: by CHENGDONGLI-MB0.localdomain (Postfix, from userid 501)
        id 607716AC1376; Sat,  2 Apr 2022 19:42:33 +0800 (CST)
To:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     ak@linux.intel.com, likexu@tencent.com, chengdongli@tencent.com
Subject: [PATCH] perf test tsc: Fix error message report when not supported.
Date:   Sat,  2 Apr 2022 19:42:18 +0800
Message-Id: <20220402114218.14131-1-chengdongli@tencent.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default `perf test tsc` does not return the error message
when child process detected kernel does not support. Instead, child
process print error message to stderr, unfortunately the stderr is
redirected to /dev/null when verbose <= 0.
This patch add a helper function test__perf_test_tsc_skip_reason() to
help parent process to get the appropriate error message and force child
process returns TEST_SKIP instead of TEST_OK.

Signed-off-by: Chengdong Li <chengdongli@tencent.com>
---
 tools/perf/tests/builtin-test.c     |  3 +++
 tools/perf/tests/perf-time-to-tsc.c | 17 +++++++++++------
 tools/perf/tests/tests.h            |  1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index da7dc5e45d0c..d3359ed2f3df 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -359,6 +359,9 @@ static struct test generic_tests[] = {
 		.desc = "Convert perf time to TSC",
 		.func = test__perf_time_to_tsc,
 		.is_supported = test__tsc_is_supported,
+		.subtest = {
+			.skip_reason = test__perf_time_to_tsc_skip_reason,
+		},
 	},
 	{
 		.desc = "dlfilter C API",
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 7c56bc1f4cff..4e7da132ca47 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -37,6 +37,13 @@
 	}					\
 }
 
+static const char *notsupported = "not supported";
+
+const char *test__perf_time_to_tsc_skip_reason(int subtest __maybe_unused)
+{
+	return notsupported;
+}
+
 /**
  * test__perf_time_to_tsc - test converting perf time to TSC.
  *
@@ -60,7 +67,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	struct perf_cpu_map *cpus = NULL;
 	struct evlist *evlist = NULL;
 	struct evsel *evsel = NULL;
-	int err = -1, ret, i;
+	int err = TEST_FAIL, ret, i;
 	const char *comm1, *comm2;
 	struct perf_tsc_conversion tc;
 	struct perf_event_mmap_page *pc;
@@ -108,10 +115,8 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	pc = evlist->mmap[0].core.base;
 	ret = perf_read_tsc_conversion(pc, &tc);
 	if (ret) {
-		if (ret == -EOPNOTSUPP) {
-			fprintf(stderr, " (not supported)");
-			return 0;
-		}
+		if (ret == -EOPNOTSUPP)
+			err = TEST_SKIP;
 		goto out_err;
 	}
 
@@ -176,7 +181,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	    test_tsc >= comm2_tsc)
 		goto out_err;
 
-	err = 0;
+	err = TEST_OK;
 
 out_err:
 	evlist__delete(evlist);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index fe1306f58495..2ba0f260d3ea 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -127,6 +127,7 @@ int test__parse_metric(struct test *test, int subtest);
 int test__pe_file_parsing(struct test *test, int subtest);
 int test__expand_cgroup_events(struct test *test, int subtest);
 int test__perf_time_to_tsc(struct test *test, int subtest);
+const char *test__perf_time_to_tsc_skip_reason(int subtest);
 int test__dlfilter(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
-- 
2.27.0

