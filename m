Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007C0585335
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbiG2QNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbiG2QNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:13:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5EEC8052F;
        Fri, 29 Jul 2022 09:13:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F1571063;
        Fri, 29 Jul 2022 09:13:17 -0700 (PDT)
Received: from localhost.localdomain (H2XD2X12VG.cambridge.arm.com [10.1.36.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF6F13F73B;
        Fri, 29 Jul 2022 09:13:14 -0700 (PDT)
From:   =?UTF-8?q?Adri=C3=A1n=20Herrera=20Arcila?= <adrian.herrera@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, leo.yan@linaro.org, songliubraving@fb.com,
        james.clark@arm.com,
        =?UTF-8?q?Adri=C3=A1n=20Herrera=20Arcila?= <adrian.herrera@arm.com>
Subject: [PATCH 1/2] perf stat: refactor __run_perf_stat common code
Date:   Fri, 29 Jul 2022 16:12:43 +0000
Message-Id: <20220729161244.10522-1-adrian.herrera@arm.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extracts common code from the branches of the forks if-then-else.
enable_counters(), which was at the beginning of both branches of the
conditional, is now unconditional; evlist__start_workload is extracted
to a different if, which enables making the common clocking code
unconditional.

Signed-off-by: Adrián Herrera Arcila <adrian.herrera@arm.com>
---
 tools/perf/builtin-stat.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d2ecd4d29624..318ffd119dad 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -966,18 +966,18 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			return err;
 	}
 
-	/*
-	 * Enable counters and exec the command:
-	 */
-	if (forks) {
-		err = enable_counters();
-		if (err)
-			return -1;
+	err = enable_counters();
+	if (err)
+		return -1;
+
+	/* Exec the command, if any */
+	if (forks)
 		evlist__start_workload(evsel_list);
 
-		t0 = rdclock();
-		clock_gettime(CLOCK_MONOTONIC, &ref_time);
+	t0 = rdclock();
+	clock_gettime(CLOCK_MONOTONIC, &ref_time);
 
+	if (forks) {
 		if (interval || timeout || evlist__ctlfd_initialized(evsel_list))
 			status = dispatch_events(forks, timeout, interval, &times);
 		if (child_pid != -1) {
@@ -995,13 +995,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (WIFSIGNALED(status))
 			psignal(WTERMSIG(status), argv[0]);
 	} else {
-		err = enable_counters();
-		if (err)
-			return -1;
-
-		t0 = rdclock();
-		clock_gettime(CLOCK_MONOTONIC, &ref_time);
-
 		status = dispatch_events(forks, timeout, interval, &times);
 	}
 
-- 
2.36.1

