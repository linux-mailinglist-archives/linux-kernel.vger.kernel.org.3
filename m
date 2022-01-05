Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC1E484E3B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiAEGQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbiAEGPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:51 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F484C061B38
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a9-20020a251a09000000b0060b2c94d515so56598717yba.20
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zv8Au8yEBbpBWPa207TVw47r1vENU76hbFmK75NTzaI=;
        b=nj53JweT0o8JQE1cXVShURIFeG81f8GT634PDEs5PiNjUEUVlHpEzMIZWm5JK1JX8N
         cqW0XBg8wnke9NXMSPW0r2Gt1l+/lY8eqI/qJMxWru5Rv38Vm19ihzDDdALPDhny9svb
         WkGWnmHw4BjCjqWzSnNGIzmiXADnhBEu09MhAZiedW6JGmXnp/kAyMIHjm+Tcxayjto4
         pCgpJ9JYs7Yv587QqUWCw+17omhs5IIPXM+Yv4+TWrivcaQdxYfh4l7p2k7YONp/Ow0y
         vOomDE7a3mFKzS+6oZQ/IPdvhMiZDFFp1zkwyZ6ttHGvgvlUMcAOSe/6oaSL8afCPFPN
         O6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zv8Au8yEBbpBWPa207TVw47r1vENU76hbFmK75NTzaI=;
        b=ombuXZ2qt9x8lCxbzcYWSkhu4QXMfRD95Mtpj/yq/jzv3QgXDn9ZsL8oAQlYyiTOQl
         R+Nkl2BAmPvexN9r3bvohHi0fktcM73WIW0zTm3nA6EHzHtWRxShl5PkZGuI0r/lf5pH
         lXidMKyCKKDQyq5hvTaxiK8FVRkS0w4jUT4cFm8Rra1eCvuCmgpzHIUxLHeVFKfWUUeW
         K21x7oNb3XxtdUJ6mXZA5SN4kGSZi9pqITTtAKUBaByenHL8vmmSI4gdkISuaOTMAiBI
         Js3cxGvtz59HTbpH1snhRChE51Clsw5T8LCzE2xs7e4kf/LzOSZRtWSJNLGdpRKAJPUg
         BRrQ==
X-Gm-Message-State: AOAM532/I3OfmGJwO5lxk6MAQdkiiXHQW511f/PWSi6OC+suHaRTaIW8
        jHMhHx8nTo24RzNB1pBpYJmqAPxvCtL2
X-Google-Smtp-Source: ABdhPJyUFsTyra2KgSOrWWX4yAUZr3w074njqYa35mD36sCTPkOultYBLd/U+dkYJgXrSuS7Lty4CK+NBh/W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a5b:881:: with SMTP id e1mr52376656ybq.602.1641363337450;
 Tue, 04 Jan 2022 22:15:37 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:43 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-41-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 40/48] perf test: Use perf_cpu_map__for_each_cpu
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

