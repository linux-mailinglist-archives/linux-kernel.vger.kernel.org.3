Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3136459655D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbiHPWSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbiHPWRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:17:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5310901B9;
        Tue, 16 Aug 2022 15:17:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g18so1947298pju.0;
        Tue, 16 Aug 2022 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=aFH5O6viJ6NTA25wi2Aiw0FQRIeUfCBP+ZrmMXU/R8U=;
        b=IZh+6RGZ+6/V/QYTPdN/5U4FDgEYkPcMJDOUV2EmmEXgKPXLlVK2/5ujAB0BprUSAh
         kS3hmzJBEDhqPF1pDHPOROXRnWzB1etxHmCR0BX59Ams/S0reNxuw0s6gsRhYfwcoOEO
         Kvl+5oFOwSqtuzbd0vHKvJOYnd42utdtqiXarnNmh2Pyr6/Ka9aB0oNVlLn3mIf6L7L1
         UrMPxzrNb9ctol1tllzwNJBWyPPZIv545b/u95j0Mn11MZXj8iyScaQgAwyisSAbuNRu
         UoOzpmyQGT/Dga7jdhs+0kIlUpLwXHM4ixsFZQ7IK75E3crIq+EXdNfsK5lw930/pZ6P
         kwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=aFH5O6viJ6NTA25wi2Aiw0FQRIeUfCBP+ZrmMXU/R8U=;
        b=IGXy5owsAqtOrPBrZVS+uRkJ3gsD2z8D29kbpfwN1RfK/w5Q3dtzl+vssDAg3JNDXe
         UhcM6VRZ161myKFcGjdaHsu1S5PolQGTLNjRYOI6IChlzcWd+TbgMG4OBaGSG1NnR38L
         l7sa7ehYHMPYEOP3kPC1e8GbuYoDvLtKQ7pMWbqcI/h1Th3ThT0Sj1wRy0mHALl+Eomd
         DwVPF0U1/qtWhDlqBCd5KdH+eE7B7n6Dn4AFrXieKCl6lL73ZCiRjbTAW2BdfuIC9uiq
         R7SKFaCAZCIDGrq2q3MPpTGd0BfRyCfcHjaU8PfJNbL4/9hp3BapXXPpMk4q/FUKr4kY
         1pJA==
X-Gm-Message-State: ACgBeo2DGVTRNKZkYNzUFqqUq/0cLqkKPvuP4wXS4Cifvt1QVq5Ft616
        jO900FyvIoKnr+OT/diTEyw=
X-Google-Smtp-Source: AA6agR6xS9AmAxMz40IF10AMCHPiCXnkDEH1nJq+aTMlKqYSNTEjnotjcqx2/4z0zTC+1K/QwdMyMA==
X-Received: by 2002:a17:902:d48d:b0:16f:5ce:1d08 with SMTP id c13-20020a170902d48d00b0016f05ce1d08mr23525965plg.49.1660688273183;
        Tue, 16 Aug 2022 15:17:53 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:d539:e967:9fd8:5c81])
        by smtp.gmail.com with ESMTPSA id 3-20020a620603000000b0052b7f0ff197sm8965943pfg.49.2022.08.16.15.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 15:17:52 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/4] tools lib perf: Add a test case for read formats
Date:   Tue, 16 Aug 2022 15:17:46 -0700
Message-Id: <20220816221747.275828-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220816221747.275828-1-namhyung@kernel.org>
References: <20220816221747.275828-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It checks a various combination of the read format settings and verify
it return the value in a proper position.  The test uses task-clock
software events to guarantee it's always active and sets enabled/running
time.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/tests/test-evsel.c | 161 ++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index 89be89afb24d..a11fc51bfb68 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdarg.h>
 #include <stdio.h>
+#include <string.h>
 #include <linux/perf_event.h>
+#include <linux/kernel.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
 #include <perf/evsel.h>
+#include <internal/evsel.h>
 #include <internal/tests.h>
 #include "tests.h"
 
@@ -189,6 +192,163 @@ static int test_stat_user_read(int event)
 	return 0;
 }
 
+static int test_stat_read_format_single(struct perf_event_attr *attr, struct perf_thread_map *threads)
+{
+	struct perf_evsel *evsel;
+	struct perf_counts_values counts;
+	volatile int count = 0x100000;
+	int err;
+
+	evsel = perf_evsel__new(attr);
+	__T("failed to create evsel", evsel);
+
+	/* skip old kernels that don't support the format */
+	err = perf_evsel__open(evsel, NULL, threads);
+	if (err < 0)
+		return 0;
+
+	while (count--) ;
+
+	memset(&counts, -1, sizeof(counts));
+	perf_evsel__read(evsel, 0, 0, &counts);
+
+	__T("failed to read value", counts.val);
+	if (attr->read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		__T("failed to read TOTAL_TIME_ENABLED", counts.ena);
+	if (attr->read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		__T("failed to read TOTAL_TIME_RUNNING", counts.run);
+	if (attr->read_format & PERF_FORMAT_ID)
+		__T("failed to read ID", counts.id);
+	if (attr->read_format & PERF_FORMAT_LOST)
+		__T("failed to read LOST", counts.lost == 0);
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+	return 0;
+}
+
+static int test_stat_read_format_group(struct perf_event_attr *attr, struct perf_thread_map *threads)
+{
+	struct perf_evsel *leader, *member;
+	struct perf_counts_values counts;
+	volatile int count = 0x100000;
+	int err;
+
+	attr->read_format |= PERF_FORMAT_GROUP;
+	leader = perf_evsel__new(attr);
+	__T("failed to create leader", leader);
+
+	attr->read_format &= ~PERF_FORMAT_GROUP;
+	member = perf_evsel__new(attr);
+	__T("failed to create member", member);
+
+	member->leader = leader;
+	leader->nr_members = 2;
+
+	/* skip old kernels that don't support the format */
+	err = perf_evsel__open(leader, NULL, threads);
+	if (err < 0)
+		return 0;
+	err = perf_evsel__open(member, NULL, threads);
+	if (err < 0)
+		return 0;
+
+	while (count--) ;
+
+	memset(&counts, -1, sizeof(counts));
+	perf_evsel__read(leader, 0, 0, &counts);
+
+	__T("failed to read leader value", counts.val);
+	if (attr->read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		__T("failed to read leader TOTAL_TIME_ENABLED", counts.ena);
+	if (attr->read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		__T("failed to read leader TOTAL_TIME_RUNNING", counts.run);
+	if (attr->read_format & PERF_FORMAT_ID)
+		__T("failed to read leader ID", counts.id);
+	if (attr->read_format & PERF_FORMAT_LOST)
+		__T("failed to read leader LOST", counts.lost == 0);
+
+	memset(&counts, -1, sizeof(counts));
+	perf_evsel__read(member, 0, 0, &counts);
+
+	__T("failed to read member value", counts.val);
+	if (attr->read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		__T("failed to read member TOTAL_TIME_ENABLED", counts.ena);
+	if (attr->read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		__T("failed to read member TOTAL_TIME_RUNNING", counts.run);
+	if (attr->read_format & PERF_FORMAT_ID)
+		__T("failed to read member ID", counts.id);
+	if (attr->read_format & PERF_FORMAT_LOST)
+		__T("failed to read member LOST", counts.lost == 0);
+
+	perf_evsel__close(member);
+	perf_evsel__close(leader);
+	perf_evsel__delete(member);
+	perf_evsel__delete(leader);
+	return 0;
+}
+
+static int test_stat_read_format(void)
+{
+	struct perf_thread_map *threads;
+	struct perf_event_attr attr = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config	= PERF_COUNT_SW_TASK_CLOCK,
+	};
+	int err, i;
+
+#define FMT(_fmt)  PERF_FORMAT_ ## _fmt
+#define FMT_TIME  (FMT(TOTAL_TIME_ENABLED) | FMT(TOTAL_TIME_RUNNING))
+
+	uint64_t test_formats [] = {
+		0,
+		FMT_TIME,
+		FMT(ID),
+		FMT(LOST),
+		FMT_TIME | FMT(ID),
+		FMT_TIME | FMT(LOST),
+		FMT_TIME | FMT(ID) | FMT(LOST),
+		FMT(ID) | FMT(LOST),
+	};
+
+#undef FMT
+#undef FMT_TIME
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	for (i = 0; i < (int)ARRAY_SIZE(test_formats); i++) {
+		attr.read_format = test_formats[i];
+		__T_VERBOSE("testing single read with read_format: %lx\n",
+			    (unsigned long)test_formats[i]);
+
+		err = test_stat_read_format_single(&attr, threads);
+		__T("failed to read single format", err == 0);
+	}
+
+	perf_thread_map__put(threads);
+
+	threads = perf_thread_map__new_array(2, NULL);
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+	perf_thread_map__set_pid(threads, 1, 0);
+
+	for (i = 0; i < (int)ARRAY_SIZE(test_formats); i++) {
+		attr.read_format = test_formats[i];
+		__T_VERBOSE("testing group read with read_format: %lx\n",
+			    (unsigned long)test_formats[i]);
+
+		err = test_stat_read_format_group(&attr, threads);
+		__T("failed to read group format", err == 0);
+	}
+
+	perf_thread_map__put(threads);
+	return 0;
+}
+
 int test_evsel(int argc, char **argv)
 {
 	__T_START;
@@ -200,6 +360,7 @@ int test_evsel(int argc, char **argv)
 	test_stat_thread_enable();
 	test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS);
 	test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES);
+	test_stat_read_format();
 
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
-- 
2.37.1.595.g718a3a8f04-goog

