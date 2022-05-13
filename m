Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9DE525A81
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376966AbiEMEFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376937AbiEMEFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:05:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB22A29B01D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:05:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f7dbceab08so62002517b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y38KhyrUQduygK/6m8o41nq8hRxktYPzYp+6Ci4BGNw=;
        b=MMHzHE5AMRTEoZKQFFOfqBhipa0tAahXZSq1c17O/neM2QN1ModjUO/jbdK6Kw2kNY
         XAwaVpLcNBHz8ffWDBGML2zsdZh7hDjDxOM7IggAREf/9kYMdCr0iFv7L5Bc4nVocTwK
         GbLpnxkZDn2fI7Fyb/H42XKOIvz99ML+Q24efTp/FGRSpcQHW+ApbIMFeBDUXS5DMYPQ
         vofSGI4ADilMBy2jW2pqTKcx37E5SpBfKupJbhAb4F1kKD69URsN8mWn8nWSlYp7kM5Z
         2+eKrp2jQ230Q1m59eBshd7XHRquqbozN9lxSWtGS/kCYCadC3NGoSCNqm1G9wDret1b
         U1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y38KhyrUQduygK/6m8o41nq8hRxktYPzYp+6Ci4BGNw=;
        b=Q0ygbsN3TTkdTzIOB6m44GF8sIhVKc07bwNYs8Vwr5EHwwX2PgGNLyijxRaF1/GXjI
         UdJOHJ9hCpVxq7igoYCS/5L2IrBa+XSgUn+xsTu1fTlIcOPlZ283EzJjArt9d2eIyE6J
         WKcsmSzUWGvKGkNsu2+oZsQRIhtwp1kQnnP8Meu/XNOdnTmHKiKrYxR1m66akQjilEZk
         8399o0bEiMTxh9+xmrW2vnpZ83Ncy61Ogw12QhFkJ0Lr4mQS+wtucXJsJljNNk6+K0rC
         vpgj9CcgzljpqfkVqfWx4yFPHhSgaS7SSJuBUpKatQsrfvHK9nY2ZisRL1s4lB6N7PDs
         qT3Q==
X-Gm-Message-State: AOAM532MTwHvJvroV9BvfK8Ui6UHinqFfey+OZ5G5XprI7lyLrAx2tIp
        kRM/4khS8D29PLL+VjBYcI1cQhFwO60M
X-Google-Smtp-Source: ABdhPJxPLWUbZ2LL8m5tupWWnw1bCuSxMt1M1UDnB9MkClL6TMY0wMhL+HZqu1MVhozBcWXPsjPxUKELk+4r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9b61:c91f:ca29:ae54])
 (user=irogers job=sendgmr) by 2002:a25:d90c:0:b0:648:dbec:5391 with SMTP id
 q12-20020a25d90c000000b00648dbec5391mr3078089ybg.309.1652414731949; Thu, 12
 May 2022 21:05:31 -0700 (PDT)
Date:   Thu, 12 May 2022 21:05:15 -0700
In-Reply-To: <20220513040519.1499333-1-irogers@google.com>
Message-Id: <20220513040519.1499333-4-irogers@google.com>
Mime-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 3/7] perf test: Use skip in openat syscall
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

