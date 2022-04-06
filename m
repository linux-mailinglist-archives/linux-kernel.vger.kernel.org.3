Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AE44F610F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbiDFOMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbiDFOMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:12:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E372121A0DF;
        Wed,  6 Apr 2022 03:06:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p17so1511926plo.9;
        Wed, 06 Apr 2022 03:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57yP5txyEZyDXpbo8tIP1sloT8BEAgWzSMNPoATwlDg=;
        b=ehDrXAaW3pMqUfx6zSCSo3ez2chyhCErGyezUVm9LK1/D0javYpCUbJcZIXfHfMvkN
         8UIV/uwH0bb7zEJGYOseWq2ar1EmtgBpi8Gox+OQasCWLVzzBsysSGCPqZ7csA3+Td3B
         dMru2IP9psWuiXdD27GLpcl1xK5YaKi5o5RfzDNfKouCSPisF0u0YDTQo/TtmxlmCNvR
         I1PevTkDTfKigc4tGc7Gz67Yxo+M40RoOJfqCyycumlnyj3FL1bsLJ1kHzeIttwSzOLM
         x9jMos0U8Pf4TpTu1/pxpqYsBWguWjQU56tBLryyJgVZR0EKx8yvXdBvYVnRMBKD41/W
         UImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57yP5txyEZyDXpbo8tIP1sloT8BEAgWzSMNPoATwlDg=;
        b=xA0DVpVJc7hrUhXdpCOlA/I6D0KEC/Y3ycaCU7ZiI36BrH7ZBJ6+wRBN1tKkMRMlQi
         5KrheRv0/1b1I6ReksHd+OsH+vRhAPzh1gTkYFP4iUfzrEEtbfPBj5MxB/RROHuexlZR
         c0eN6EbnogRSjhZrRoVApVzqXm4G08JBKYnh+Kas1f3AecO75BsD+uDIve8ym14iE6Fn
         975twtJZNgEC8D5MwsHuL+rHZWG8dMQh1/b4MtAjUxq12JwCk1T5Sl0hWfotrJxBbAg4
         JUbN6zhnml25FPrTgvCCyApH4jzgVbyt3EYopWInTZNbnPz7m1+DJNrba5NB94OOOe1b
         y2DA==
X-Gm-Message-State: AOAM533GIPrBITZBla72tDW7D/wuxvIctMjpsTDsVzpPN+/d3XwT7T9i
        odc+UyJFJDK1eVXWl3FNqTk=
X-Google-Smtp-Source: ABdhPJylhVZbCyCHSeSScbZqHALx+bT8I3PFeWGu4VLRdO069nloeoxBtQ1mNZowYRE80cEQdXbpCg==
X-Received: by 2002:a17:90b:4c92:b0:1c7:a9a3:6274 with SMTP id my18-20020a17090b4c9200b001c7a9a36274mr8943122pjb.148.1649239587542;
        Wed, 06 Apr 2022 03:06:27 -0700 (PDT)
Received: from CHENGDONGLI-MB0.localdomain ([203.205.141.115])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090ad99000b001bcbc4247a0sm5144868pjv.57.2022.04.06.03.06.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Apr 2022 03:06:26 -0700 (PDT)
From:   Chengdong Li <brytonlee01@gmail.com>
X-Google-Original-From: Chengdong Li <chengdongli@tencent.com>
Received: by CHENGDONGLI-MB0.localdomain (Postfix, from userid 501)
        id 2E2286C7A19C; Wed,  6 Apr 2022 18:06:22 +0800 (CST)
To:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     ak@linux.intel.com, likexu@tencent.com, chengdongli@tencent.com
Subject: [PATCH v2] perf test tsc: Fix error message report when not supported.
Date:   Wed,  6 Apr 2022 18:06:09 +0800
Message-Id: <20220406100609.65239-1-chengdongli@tencent.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default `perf test tsc` does not return the error message
when child process detected kernel does not support. Instead, child
process print error message to stderr, unfortunately the stderr is
redirected to /dev/null when verbose <= 0.

This patch did three things:
- returns TEST_SKIP to parent process instead of TEST_OK when
  perf_read_tsc_conversion() is not supported.
- add a new subtest of testing if TSC is supported on current
  architecture by moving exist code to a separate function.
- extended test suite definition to contain above two subtests.

Changes since v1 (thanks for the feedback from Adrian Hunter):
- rebase commit to current source.

Signed-off-by: Chengdong Li <chengdongli@tencent.com>
---
 tools/perf/tests/perf-time-to-tsc.c | 36 +++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index d12d0ad81801..fc7c380af5a0 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -47,6 +47,17 @@
 	}					\
 }
 
+static int test__tsc_is_supported(struct test_suite *test __maybe_unused,
+				  int subtest __maybe_unused)
+{
+	if (!TSC_IS_SUPPORTED) {
+		pr_debug("Test not supported on this architecture");
+		return TEST_SKIP;
+	}
+
+	return TEST_OK;
+}
+
 /**
  * test__perf_time_to_tsc - test converting perf time to TSC.
  *
@@ -70,7 +81,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 	struct perf_cpu_map *cpus = NULL;
 	struct evlist *evlist = NULL;
 	struct evsel *evsel = NULL;
-	int err = -1, ret, i;
+	int err = TEST_FAIL, ret, i;
 	const char *comm1, *comm2;
 	struct perf_tsc_conversion tc;
 	struct perf_event_mmap_page *pc;
@@ -79,10 +90,6 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 	u64 test_time, comm1_time = 0, comm2_time = 0;
 	struct mmap *md;
 
-	if (!TSC_IS_SUPPORTED) {
-		pr_debug("Test not supported on this architecture");
-		return TEST_SKIP;
-	}
 
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	CHECK_NOT_NULL__(threads);
@@ -124,8 +131,8 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 	ret = perf_read_tsc_conversion(pc, &tc);
 	if (ret) {
 		if (ret == -EOPNOTSUPP) {
-			fprintf(stderr, " (not supported)");
-			return 0;
+			pr_debug("perf_read_tsc_conversion is not supported in current kernel");
+			err = TEST_SKIP;
 		}
 		goto out_err;
 	}
@@ -191,7 +198,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 	    test_tsc >= comm2_tsc)
 		goto out_err;
 
-	err = 0;
+	err = TEST_OK;
 
 out_err:
 	evlist__delete(evlist);
@@ -200,4 +207,15 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 	return err;
 }
 
-DEFINE_SUITE("Convert perf time to TSC", perf_time_to_tsc);
+static struct test_case time_to_tsc_tests[] = {
+	TEST_CASE_REASON("TSC support", tsc_is_supported,
+			 "This architecture does not support"),
+	TEST_CASE_REASON("Perf time to TSC", perf_time_to_tsc,
+			 "perf_read_tsc_conversion is not supported"),
+	{ .name = NULL, }
+};
+
+struct test_suite suite__perf_time_to_tsc = {
+	.desc = "Convert perf time to TSC",
+	.test_cases = time_to_tsc_tests,
+};
-- 
2.27.0

