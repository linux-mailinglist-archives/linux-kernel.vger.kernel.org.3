Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C359052B170
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiEREUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiEREUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:20:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D99621277
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i17-20020a259d11000000b0064cd3084085so902543ybp.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y38KhyrUQduygK/6m8o41nq8hRxktYPzYp+6Ci4BGNw=;
        b=TpddIbIN7gqaeMZgnNcQVm4CEyupQQTIb3Stzc/l/sAfWrKi3wWYHHHnRKx93bqifx
         AfBXieoluKZYrXmEJNfrVOapq9PkgU5HcvKFh35RuWkAH1DeeDTFW6i0UOVdgzB8BhIA
         FZLAD8pImRG4aX2/wz6xRNNWO8cCtldYi/CWEz+dLINAdObqbG1Q3BkhJmascIm13vIV
         c4F+B9Of1oeWTC2t0QA1SnDP4DXbEVpRdfcuIlN97qyhLQanKxBv3du1fmwQICvhqKoU
         dign3evoPIY+ENjBpJzTL1KgyCp5e+z6NxBZXVhRZKYeuhYB7wNGmgaBZQzkwREjlHxE
         5dPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y38KhyrUQduygK/6m8o41nq8hRxktYPzYp+6Ci4BGNw=;
        b=EYB8xlF342wv+83ykicDDkxpstUHDlD3vNPvezQjey9QDVf6tN+oWKZ41DT9Tqs22j
         2/H9QXkq/wP2PSx0TOrDhmHSAnBxtvcI2YKVhProvu+e8MeJi45sBkVxwVzEbIKzSUnW
         RktpQ03TLD93Z2uqAwLBffN8x4HNuoAoVKp7Qozv9VynPNqmPeTkBJ2p94k/T4C81uO0
         rNvE84yFXaXtCXFPxxECiGPtPUYUwOyDGyg0f1R2gP+VND7cHFMTH7wmOkoGpMw3hBVt
         6K8wYCtq9z9hW6QvKw6yBDLSNnoTM0nyWlsYsB/ALsJovNlG7kz5oB6vLSsJy3OU38Oo
         3JXw==
X-Gm-Message-State: AOAM531W+ch+bmPd0MPxq8VsLFUjUXFNZnq/ump++qiLULHrDKDnuFtD
        XFbETlIEF9F0g/rxznQWul5ksJqr/gq8
X-Google-Smtp-Source: ABdhPJy8VOPVmejo54U8ul9PvBKvNnuOhOiD9VhmDwDPVhx55pUpqe/7X3lHJjTvY2ykkIkVD+OO3ij3RWLm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a25:ab0c:0:b0:64d:a92b:3135 with SMTP id
 u12-20020a25ab0c000000b0064da92b3135mr13324412ybi.552.1652847640317; Tue, 17
 May 2022 21:20:40 -0700 (PDT)
Date:   Tue, 17 May 2022 21:20:22 -0700
In-Reply-To: <20220518042027.836799-1-irogers@google.com>
Message-Id: <20220518042027.836799-4-irogers@google.com>
Mime-Version: 1.0
References: <20220518042027.836799-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 3/8] perf test: Use skip in openat syscall
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Failures to open the tracepoint cause this test to fail, however,
typically such failures are permission related. Lower the failure to
just skipping the test in those cases and add a skip reason.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/openat-syscall-all-cpus.c | 23 +++++++++++++++++-----
 tools/perf/tests/openat-syscall.c          | 20 +++++++++++++++----
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 1ab362323d25..90828ae03ef5 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -22,7 +22,7 @@
 static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __maybe_unused,
 						  int subtest __maybe_unused)
 {
-	int err = -1, fd, idx;
+	int err = TEST_FAIL, fd, idx;
 	struct perf_cpu cpu;
 	struct perf_cpu_map *cpus;
 	struct evsel *evsel;
@@ -49,6 +49,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 	if (IS_ERR(evsel)) {
 		tracing_path__strerror_open_tp(errno, errbuf, sizeof(errbuf), "syscalls", "sys_enter_openat");
 		pr_debug("%s\n", errbuf);
+		err = TEST_SKIP;
 		goto out_cpu_map_delete;
 	}
 
@@ -56,6 +57,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 		pr_debug("failed to open counter: %s, "
 			 "tweak /proc/sys/kernel/perf_event_paranoid?\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		err = TEST_SKIP;
 		goto out_evsel_delete;
 	}
 
@@ -88,7 +90,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 
 	evsel->core.cpus = perf_cpu_map__get(cpus);
 
-	err = 0;
+	err = TEST_OK;
 
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 		unsigned int expected;
@@ -98,7 +100,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 
 		if (evsel__read_on_cpu(evsel, idx, 0) < 0) {
 			pr_debug("evsel__read_on_cpu\n");
-			err = -1;
+			err = TEST_FAIL;
 			break;
 		}
 
@@ -106,7 +108,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 		if (perf_counts(evsel->counts, idx, 0)->val != expected) {
 			pr_debug("evsel__read_on_cpu: expected to intercept %d calls on cpu %d, got %" PRIu64 "\n",
 				 expected, cpu.cpu, perf_counts(evsel->counts, idx, 0)->val);
-			err = -1;
+			err = TEST_FAIL;
 		}
 	}
 
@@ -122,4 +124,15 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 	return err;
 }
 
-DEFINE_SUITE("Detect openat syscall event on all cpus", openat_syscall_event_on_all_cpus);
+
+static struct test_case tests__openat_syscall_event_on_all_cpus[] = {
+	TEST_CASE_REASON("Detect openat syscall event on all cpus",
+			 openat_syscall_event_on_all_cpus,
+			 "permissions"),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__openat_syscall_event_on_all_cpus = {
+	.desc = "Detect openat syscall event on all cpus",
+	.test_cases = tests__openat_syscall_event_on_all_cpus,
+};
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 7f4c13c4b14d..7e05b8b5cc95 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -16,7 +16,7 @@
 static int test__openat_syscall_event(struct test_suite *test __maybe_unused,
 				      int subtest __maybe_unused)
 {
-	int err = -1, fd;
+	int err = TEST_FAIL, fd;
 	struct evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
 	struct perf_thread_map *threads = thread_map__new(-1, getpid(), UINT_MAX);
@@ -25,13 +25,14 @@ static int test__openat_syscall_event(struct test_suite *test __maybe_unused,
 
 	if (threads == NULL) {
 		pr_debug("thread_map__new\n");
-		return -1;
+		return TEST_FAIL;
 	}
 
 	evsel = evsel__newtp("syscalls", "sys_enter_openat");
 	if (IS_ERR(evsel)) {
 		tracing_path__strerror_open_tp(errno, errbuf, sizeof(errbuf), "syscalls", "sys_enter_openat");
 		pr_debug("%s\n", errbuf);
+		err = TEST_SKIP;
 		goto out_thread_map_delete;
 	}
 
@@ -39,6 +40,7 @@ static int test__openat_syscall_event(struct test_suite *test __maybe_unused,
 		pr_debug("failed to open counter: %s, "
 			 "tweak /proc/sys/kernel/perf_event_paranoid?\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		err = TEST_SKIP;
 		goto out_evsel_delete;
 	}
 
@@ -58,7 +60,7 @@ static int test__openat_syscall_event(struct test_suite *test __maybe_unused,
 		goto out_close_fd;
 	}
 
-	err = 0;
+	err = TEST_OK;
 out_close_fd:
 	perf_evsel__close_fd(&evsel->core);
 out_evsel_delete:
@@ -68,4 +70,14 @@ static int test__openat_syscall_event(struct test_suite *test __maybe_unused,
 	return err;
 }
 
-DEFINE_SUITE("Detect openat syscall event", openat_syscall_event);
+static struct test_case tests__openat_syscall_event[] = {
+	TEST_CASE_REASON("Detect openat syscall event",
+			 openat_syscall_event,
+			 "permissions"),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__openat_syscall_event = {
+	.desc = "Detect openat syscall event",
+	.test_cases = tests__openat_syscall_event,
+};
-- 
2.36.0.550.gb090851708-goog

