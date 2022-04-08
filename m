Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB7E4F8C57
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiDHCRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 22:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiDHCRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:17:12 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB94C268986;
        Thu,  7 Apr 2022 19:15:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n18so6676802plg.5;
        Thu, 07 Apr 2022 19:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eaTn1UD2941ACHdvLV5KXK7aQnz8AqsgTtEV29TgNb4=;
        b=gfVls0S5RExmb2wfxxa8AxWIfLg/2ToNLqQRGizg8/ZyQK4LRK7mx/JJKPuowsjWPt
         zaOCkoq69qZP5TyzLA57gha0z5qlcuqFL45g8sfVrpVcbDgtQOuF1pfiPr3rCmgKMb6H
         6i8jngKHecSmLOP6j8REwui4ESfGri2JM0FuYE8CftXEJkT58iqZir4ubApNV6TVsIOa
         pDaevCb934NI17jxM0fdyyHzquVIN8EQEeL1cu7vP5PBn0njbDcWHZm0O6b+N9myoKlN
         wcriA5kv3wLIC+wPNlAp8Yee80m/u7vp+VCDXZ5AYGsGAn2/jq7jik0en+HC54uiTMil
         eTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eaTn1UD2941ACHdvLV5KXK7aQnz8AqsgTtEV29TgNb4=;
        b=myqcazGgBPcKCt2rK+AGq/jQeU2oP1Nyz8TEck2+PiwVrfKpP5DxOZJ3xLuMlb6+He
         ZYVbjaq3YX4J7R6lCls5hX7bcAMiSp4syXnG+FsFBgYzrc1vDcZtI/49fkZFpn6onciC
         5lRJhoEaFyvyokTNYWcKAu4m0R3eXDqcgDGKLQ7ocf63d5ryVU0DHtThp75iiOfwlurO
         78tsHikQmp8JM9nM1TSlHOkDPXaIR4hky9YkJkr75P+JwbVA4+Ex5zCcUMWu1p1wiaYC
         Bp6zUGUsTQr84Hcy37R/b2zCCtyXa40xqyJbL369oq6G9JqICpESotC6EkCSuNjdyhRS
         uxhA==
X-Gm-Message-State: AOAM532iUghcmi7hVGBJt/DVY2XdIJHgVCpiiWGCufQbis0AjwoqyXUr
        ifUM/EATpF4fYdGRvIVBT3k=
X-Google-Smtp-Source: ABdhPJwhDNKvqQnN8Er5QxbqbkFYHfAdgsWhosx8jFAdhg85i/qHK6nlIdPaPCzTm5rd9fRcujpPfw==
X-Received: by 2002:a17:902:6acc:b0:149:8f60:a526 with SMTP id i12-20020a1709026acc00b001498f60a526mr16980935plt.25.1649384109413;
        Thu, 07 Apr 2022 19:15:09 -0700 (PDT)
Received: from CHENGDONGLI-MB0.localdomain ([203.205.141.113])
        by smtp.gmail.com with ESMTPSA id s10-20020a056a00178a00b004fda49fb25dsm24069652pfg.9.2022.04.07.19.15.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Apr 2022 19:15:08 -0700 (PDT)
From:   Chengdong Li <brytonlee01@gmail.com>
X-Google-Original-From: Chengdong Li <chengdongli@tencent.com>
Received: by CHENGDONGLI-MB0.localdomain (Postfix, from userid 501)
        id 8E1836D5C455; Fri,  8 Apr 2022 10:15:05 +0800 (CST)
To:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     ak@linux.intel.com, likexu@tencent.com, chengdongli@tencent.com
Subject: [PATCH v3] perf test tsc: Fix error message report when not supported.
Date:   Fri,  8 Apr 2022 10:14:28 +0800
Message-Id: <20220408021428.18009-1-chengdongli@tencent.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <676075ca-4d5d-7388-61ac-42a0b9f1ed50@intel.com>
References: <676075ca-4d5d-7388-61ac-42a0b9f1ed50@intel.com>
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

