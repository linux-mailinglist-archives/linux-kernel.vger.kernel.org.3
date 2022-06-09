Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E958544317
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiFIFYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238313AbiFIFYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:24:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23383BFB0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:24:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e5-20020a255005000000b0065cb3669fe9so19451357ybb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 22:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lb9q5Yv/NRSmWQ/bYz01a/1C1DKx+kQvVtIfEuSv0m8=;
        b=qaF4ArVQ5Ijgk1R5sedAyMQtN/PHxBZPjddPKT5shPniD6r9GsaYHQBs41nCGkkNuL
         SHeGn0BJokgDCtz1HiabL50GLDN9M66oSLJ0Cptw0pKhtcRozR9pcq5NlwCaipB6PQI1
         BN3aPtREHhon32R+AKAjbVOY6MyuHU2QlgePTzJa43GC3ZOxSSF5w7soyhEImLmWxlKz
         4vgCgVz7oVxq9kWTqcZKuaiSB9E22ifRjJjq/ES84kRBpS47/mCKRN1f+F8kKz+ef/r2
         H5/m76I5fY5vbtPh82w0aCnWJ2wfsWWIoSzIa+do4QPri0HuWJK4ky021voryleXLPTP
         xEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lb9q5Yv/NRSmWQ/bYz01a/1C1DKx+kQvVtIfEuSv0m8=;
        b=ZSGeDqYoPoqESQgCJn+PnsqyLZaYObiduhyTUeISnsib/p05K7cS5jSJPMOHtnlKf1
         ujALF422VirE0NmXDet8id375bM3jubAAqCdwGbNJDStRGgOBWpvZVviCiNg1V775BNt
         TTqE8ZARwmnltTngv2BkloNJj0cdIc2K3u52BzAolwV66btKPEGNzr+bqprUQpUHDGzO
         XittliH+wBBk4e2LeM5Dx2Y2g8u05LDaONnwKj9MVWRZ0unmDBbmwuMU9lOtJkzLzsYp
         IqjpyDJmR2Xwo5hOpiRxndA+Fh9Qr5dUFyM3HW9A04kJu2Un3zb5uACBxzXuw8MzzX+6
         ZeFA==
X-Gm-Message-State: AOAM532Osr2am1ifETPZ/coL/G5GYyu7eb8kHSion+h6IbXmzVs87Cnx
        LUvncrywG3DCVFPEMqA6Spuy+IUuWcsA
X-Google-Smtp-Source: ABdhPJyAqMlhCuxzMnoqvzbXCEIxUYUC+UEZoPwaqzgyUw3HKZqt3ckccIlBiudFoF39cskbid5mabc+fva+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ae20:7578:fb21:976b])
 (user=irogers job=sendgmr) by 2002:a0d:f443:0:b0:300:4795:fc0f with SMTP id
 d64-20020a0df443000000b003004795fc0fmr40154662ywf.354.1654752251112; Wed, 08
 Jun 2022 22:24:11 -0700 (PDT)
Date:   Wed,  8 Jun 2022 22:23:55 -0700
In-Reply-To: <20220609052355.1300162-1-irogers@google.com>
Message-Id: <20220609052355.1300162-5-irogers@google.com>
Mime-Version: 1.0
References: <20220609052355.1300162-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 4/4] perf test: Add user space counter reading tests
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These tests are based on test_stat_user_read in
tools/lib/perf/tests/test-evsel.c. The tests are modified to skip if
perf_event_open fails or rdpmc isn't supported.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/mmap-basic.c | 127 +++++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 30bbe144648a..dfb6173b2a82 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -170,14 +170,139 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 	return err;
 }
 
+static int test_stat_user_read(int event)
+{
+	struct perf_counts_values counts = { .val = 0 };
+	struct perf_thread_map *threads;
+	struct perf_evsel *evsel;
+	struct perf_event_mmap_page *pc;
+	struct perf_event_attr attr = {
+		.type	= PERF_TYPE_HARDWARE,
+		.config	= event,
+#ifdef __aarch64__
+		.config1 = 0x2,		/* Request user access */
+#endif
+	};
+	int err, i, ret = TEST_FAIL;
+	bool opened = false, mapped = false;
+
+	threads = perf_thread_map__new_dummy();
+	TEST_ASSERT_VAL("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evsel = perf_evsel__new(&attr);
+	TEST_ASSERT_VAL("failed to create evsel", evsel);
+
+	err = perf_evsel__open(evsel, NULL, threads);
+	if (err) {
+		pr_err("failed to open evsel: %s\n", strerror(-err));
+		ret = TEST_SKIP;
+		goto out;
+	}
+	opened = true;
+
+	err = perf_evsel__mmap(evsel, 0);
+	if (err) {
+		pr_err("failed to mmap evsel: %s\n", strerror(-err));
+		goto out;
+	}
+	mapped = true;
+
+	pc = perf_evsel__mmap_base(evsel, 0, 0);
+	if (!pc) {
+		pr_err("failed to get mmapped address\n");
+		goto out;
+	}
+
+	if (!pc->cap_user_rdpmc || !pc->index) {
+		pr_err("userspace counter access not %s\n",
+			!pc->cap_user_rdpmc ? "supported" : "enabled");
+		ret = TEST_SKIP;
+		goto out;
+	}
+	if (pc->pmc_width < 32) {
+		pr_err("userspace counter width not set (%d)\n", pc->pmc_width);
+		goto out;
+	}
+
+	perf_evsel__read(evsel, 0, 0, &counts);
+	if (counts.val == 0) {
+		pr_err("failed to read value for evsel\n");
+		goto out;
+	}
+
+	for (i = 0; i < 5; i++) {
+		volatile int count = 0x10000 << i;
+		__u64 start, end, last = 0;
+
+		pr_debug("\tloop = %u, ", count);
+
+		perf_evsel__read(evsel, 0, 0, &counts);
+		start = counts.val;
+
+		while (count--) ;
+
+		perf_evsel__read(evsel, 0, 0, &counts);
+		end = counts.val;
+
+		if ((end - start) < last) {
+			pr_err("invalid counter data: end=%llu start=%llu last= %llu\n",
+				end, start, last);
+			goto out;
+		}
+		last = end - start;
+		pr_debug("count = %llu\n", end - start);
+	}
+	ret = TEST_OK;
+
+out:
+	if (mapped)
+		perf_evsel__munmap(evsel);
+	if (opened)
+		perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+
+	perf_thread_map__put(threads);
+	return ret;
+}
+
+static int test__mmap_user_read_instr(struct test_suite *test __maybe_unused,
+				      int subtest __maybe_unused)
+{
+	return test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS);
+}
+
+static int test__mmap_user_read_cycles(struct test_suite *test __maybe_unused,
+				       int subtest __maybe_unused)
+{
+	return test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES);
+}
+
 static struct test_case tests__basic_mmap[] = {
 	TEST_CASE_REASON("Read samples using the mmap interface",
 			 basic_mmap,
 			 "permissions"),
+	TEST_CASE_REASON("User space counter reading of instructions",
+			 mmap_user_read_instr,
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+			 "permissions"
+#else
+			 "unsupported"
+#endif
+		),
+	TEST_CASE_REASON("User space counter reading of cycles",
+			 mmap_user_read_cycles,
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+			 "permissions"
+#else
+			 "unsupported"
+#endif
+		),
 	{	.name = NULL, }
 };
 
 struct test_suite suite__basic_mmap = {
-	.desc = "Read samples using the mmap interface",
+	.desc = "mmap interface tests",
 	.test_cases = tests__basic_mmap,
 };
-- 
2.36.1.255.ge46751e96f-goog

