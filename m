Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282E24F9122
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbiDHIuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiDHIuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:50:06 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174C6B13;
        Fri,  8 Apr 2022 01:48:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id s11so7301233pla.8;
        Fri, 08 Apr 2022 01:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I46UWeD98++HQALI8PtJ0TTP79FrXlHlDLM23fJH0TE=;
        b=AMz/XhD4j+40NOgknVlsh0fHAwSm7KnOySa6l8Ft38KfLtGZOXWBTbIDEpOUbeAKHL
         jO8J6IpYhF0ufvMwfCHs2uB+61dM8oHqrS8xtcoJ5/wBoEUG1x4Wgr7ypBWaCutsTM9l
         kBCh7W1+eBVG84ibOFB0OgId55+DUJMx2itlnrW0lQgzhSjYIiHrsrnJdsx0eZZFNjo3
         u0lGhZZ09lcU4A6vPkmXaebedsNTDXBKzDmfd0LW1imuZXZXTUcC7n7tUqKHKpHjtN4m
         cUZmrTPh+RBB77t1ylPgxGvneFvThMP13CRyCgmBZRd1IgwbA1IMNNZdUSmI70PSg7zi
         k0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I46UWeD98++HQALI8PtJ0TTP79FrXlHlDLM23fJH0TE=;
        b=Bdk4WMIRG309ertNAJok5l8RDDKC+pCGcBbCNiAl2lt+Gf7FedMli63Dz31Y0NImrW
         vvrZx93YHhVWG41lWzQPaJIifvWNhtrweh1vzzKS9jkb87xYckRTd4p3ZXNeMsUvs+RY
         6cfE+sS0uAvS/nZDy6w3gq7FLTVmACnnNIVxmYaXjMjRs/TW19A+HWd31psxRrHTHrke
         TrrEFhyT+I5GrgkH+kU/Q/A/xSvGxZ0RqwsLhwakLv06Ofis5+KWeeJR4aF2wqfHgyIr
         6mgTMZhwhtZrGoRLO2H97YiLmTLYZSGJbiCqj+2SVNgyYjfboRGvmCPaxy7w8mchjuyj
         G3Ng==
X-Gm-Message-State: AOAM531qLVWusepjkN/1p3/CZWGHsQDGhnes+uU4WirZAP9RJuEP7FW7
        c8tdf47625WjwbcWPO3xvK0=
X-Google-Smtp-Source: ABdhPJzF0G8x7dcWJzCeZT6g4GPh+o/q1DLD1IO0VBU9rC9Kh1hcN6yMub0dhGcwbN7OC1+nNMxR+w==
X-Received: by 2002:a17:90a:9204:b0:1ca:8698:2470 with SMTP id m4-20020a17090a920400b001ca86982470mr20643616pjo.199.1649407683593;
        Fri, 08 Apr 2022 01:48:03 -0700 (PDT)
Received: from CHENGDONGLI-MB0.localdomain ([203.205.141.113])
        by smtp.gmail.com with ESMTPSA id cq25-20020a056a00331900b004faf3a0c89csm23531322pfb.91.2022.04.08.01.48.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Apr 2022 01:48:02 -0700 (PDT)
From:   Chengdong Li <brytonlee01@gmail.com>
X-Google-Original-From: Chengdong Li <chengdongli@tencent.com>
Received: by CHENGDONGLI-MB0.localdomain (Postfix, from userid 501)
        id 93A506D931DE; Fri,  8 Apr 2022 16:47:56 +0800 (CST)
To:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     ak@linux.intel.com, likexu@tencent.com, chengdongli@tencent.com
Subject: [PATCH v4] perf test tsc: Fix error message report when not supported.
Date:   Fri,  8 Apr 2022 16:47:48 +0800
Message-Id: <20220408084748.43707-1-chengdongli@tencent.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <CAC2pzGdMFmtV8YNR4DszoATjM80uYNwrnW5As6vgBsyXVcWueA@mail.gmail.com>
References: <CAC2pzGdMFmtV8YNR4DszoATjM80uYNwrnW5As6vgBsyXVcWueA@mail.gmail.com>
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

From: Chengdong Li <chengdongli@tencent.com>

By default `perf test tsc` does not return the error message
when the child process detected kernel does not support. Instead,
the child process print error message to stderr, unfortunately
the stderr is redirected to /dev/null when verbose <= 0.

This patch did three things:
- returns TEST_SKIP to the parent process instead of TEST_OK when
  perf_read_tsc_conversion() is not supported.
- add a new subtest of testing if TSC is supported on current
  architecture by moving exist code to a separate function.
  It avoids two places in test__perf_time_to_tsc() that return
  TEST_SKIP by doing this.
- extended test suite definition to contain above two subtests.
  Current test_suite and test_case structs do not support printing
  skip reason when the number of subtest less than 1. To print skip
  reason, it is necessary to extend current test suite definition.

Changes since v3:
- refine commit message again to make it clear. 

Changes since v2:
- refine error message format.
- refine commit log message according to Adrian's review comments.

Changes since v1 (thanks for the feedback from Adrian Hunter):
- rebase commit to current source.

Signed-off-by: Chengdong Li <chengdongli@tencent.com>
---
 tools/perf/tests/perf-time-to-tsc.c | 36 +++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index d12d0ad81801..cc6df49a65a1 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -47,6 +47,17 @@
 	}					\
 }
 
+static int test__tsc_is_supported(struct test_suite *test __maybe_unused,
+				  int subtest __maybe_unused)
+{
+	if (!TSC_IS_SUPPORTED) {
+		pr_debug("Test not supported on this architecture\n");
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
+			pr_debug("perf_read_tsc_conversion is not supported in current kernel\n");
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

