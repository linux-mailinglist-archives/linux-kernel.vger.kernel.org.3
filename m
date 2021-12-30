Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E50A481A50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbhL3HXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbhL3HWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59201C0613A1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 66-20020a251245000000b0060d05da9c4eso17522071ybs.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zv8Au8yEBbpBWPa207TVw47r1vENU76hbFmK75NTzaI=;
        b=cm5pC41StIJJ8ZTI6ni5rDmi8zqtUkXa6N2IC/yAHj5WHEzVKTdBu0wB8K3poeDkag
         QFnOLF4mucomBZ/iPBrTu5/Ng+0C1r7IhfcJA1yYG7aXw0QISw4BpF3cKCajx7mdSXwX
         5tifU2Wjrb/tvq2B1mqCm8BnEe8TT076JLDktKfUebxQnSbrVW4TYdKj7FngNVn0jIyP
         XPggI65FTzvFpqFmsUfZQ7MakRzid3dDp5D68fpgsA9/T+jufiDdRjeJl45r7D/WRcJG
         TmQDF8Z913vTmA/AZbcV/eFSCLyCm/fmA3PhICJCtRmuyYvFrrbP3BykqknShuMxSrW1
         BiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zv8Au8yEBbpBWPa207TVw47r1vENU76hbFmK75NTzaI=;
        b=jc4aJeKA2WX154eVTNG9P2elYxgidN0R+LRwRBVQz1vAE7a8GxfgiY/1BlhM4PdoO3
         n5/pA5FdCwtXHBD5xXTs8p8M+AE+SnIrA2IZ9UMfEtoFUrUh1vHZa/YMT/gxSGXMbB0/
         j4RTysiqlsnUNj0baBhIOIzfOB+Bv+O9kG5+xDhH2tQykyrk7lAf8NTXvPemSexZ6FCh
         gVjEPCLeDP5ORevtlmFtsxaBgbAY2pFUdE0pQ1g1CcyoCdwDxONTJNAFtW/Hgsgj09iF
         Zb6YoF90TbW6KYw6K/vYs/aZiLXUmPSuC7AQW5O8ElCMDxuemZb2sqHgOzayNJAuRjLr
         hqvA==
X-Gm-Message-State: AOAM531fYCYY4hPtpWfj5hOk3RKAyenKRmYfFPmz/9sdAZeNQ7sNG3Ht
        Ad848Iud4CDVHfc2iy6fja2jfV5p7Ylx
X-Google-Smtp-Source: ABdhPJw1Ll8Ncrw9J+MROnunrWaGDWAMTzviVpnbWMtVY0h4rw0YkaMGyM1QnS6GI4i7Sme5QRz3QetSYd3B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:2c89:: with SMTP id
 s131mr23705628ybs.504.1640848938565; Wed, 29 Dec 2021 23:22:18 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:22 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-42-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 40/48] perf test: Use perf_cpu_map__for_each_cpu
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up variable naming to make cpu and index clearer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/openat-syscall-all-cpus.c | 28 +++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 544db0839b3b..ca0a50e92839 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -22,7 +22,7 @@
 static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __maybe_unused,
 						  int subtest __maybe_unused)
 {
-	int err = -1, fd, cpu;
+	int err = -1, fd, idx, cpu;
 	struct perf_cpu_map *cpus;
 	struct evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
@@ -58,23 +58,23 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 		goto out_evsel_delete;
 	}
 
-	for (cpu = 0; cpu < cpus->nr; ++cpu) {
-		unsigned int ncalls = nr_openat_calls + cpu;
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		unsigned int ncalls = nr_openat_calls + idx;
 		/*
 		 * XXX eventually lift this restriction in a way that
 		 * keeps perf building on older glibc installations
 		 * without CPU_ALLOC. 1024 cpus in 2010 still seems
 		 * a reasonable upper limit tho :-)
 		 */
-		if (cpus->map[cpu] >= CPU_SETSIZE) {
-			pr_debug("Ignoring CPU %d\n", cpus->map[cpu]);
+		if (cpu >= CPU_SETSIZE) {
+			pr_debug("Ignoring CPU %d\n", cpu);
 			continue;
 		}
 
-		CPU_SET(cpus->map[cpu], &cpu_set);
+		CPU_SET(cpu, &cpu_set);
 		if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0) {
 			pr_debug("sched_setaffinity() failed on CPU %d: %s ",
-				 cpus->map[cpu],
+				 cpu,
 				 str_error_r(errno, sbuf, sizeof(sbuf)));
 			goto out_close_fd;
 		}
@@ -82,29 +82,29 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 			fd = openat(0, "/etc/passwd", O_RDONLY);
 			close(fd);
 		}
-		CPU_CLR(cpus->map[cpu], &cpu_set);
+		CPU_CLR(cpu, &cpu_set);
 	}
 
 	evsel->core.cpus = perf_cpu_map__get(cpus);
 
 	err = 0;
 
-	for (cpu = 0; cpu < cpus->nr; ++cpu) {
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 		unsigned int expected;
 
-		if (cpus->map[cpu] >= CPU_SETSIZE)
+		if (cpu >= CPU_SETSIZE)
 			continue;
 
-		if (evsel__read_on_cpu(evsel, cpu, 0) < 0) {
+		if (evsel__read_on_cpu(evsel, idx, 0) < 0) {
 			pr_debug("evsel__read_on_cpu\n");
 			err = -1;
 			break;
 		}
 
-		expected = nr_openat_calls + cpu;
-		if (perf_counts(evsel->counts, cpu, 0)->val != expected) {
+		expected = nr_openat_calls + idx;
+		if (perf_counts(evsel->counts, idx, 0)->val != expected) {
 			pr_debug("evsel__read_on_cpu: expected to intercept %d calls on cpu %d, got %" PRIu64 "\n",
-				 expected, cpus->map[cpu], perf_counts(evsel->counts, cpu, 0)->val);
+				 expected, cpu, perf_counts(evsel->counts, idx, 0)->val);
 			err = -1;
 		}
 	}
-- 
2.34.1.448.ga2b2bfdf31-goog

