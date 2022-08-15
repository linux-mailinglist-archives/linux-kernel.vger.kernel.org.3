Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80008593B13
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347395AbiHOUbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243000AbiHOUW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:22:29 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9A04B4AA;
        Mon, 15 Aug 2022 12:02:46 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d71so7228630pgc.13;
        Mon, 15 Aug 2022 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=aFH5O6viJ6NTA25wi2Aiw0FQRIeUfCBP+ZrmMXU/R8U=;
        b=fAg5GvhC9b+uSX4XfLoHrTm5t4cfjluFZpstnDR2BqZ5sCf56CjAqed44UFm7y7wiX
         qJrtG+PIYnh1PeATPzDnrbmqumlB+SK7UM9LN7CNz3XSd9HNKUgPpgHY2tWKLD9J96cV
         AF+2lzINY4HTQW9LpP2TPSwinit/dLpR0/GRokt0QupZghmB3V77w5ozAC8pDbSsPL86
         2BA17TbR6AcQrQKowa7GYIVVp1bOvxC5kG1d7nnxCAFvCipvPn/rF6EV/VIZPGlvxtSi
         g9T3easUzlitoITO3fGfz3uBG2Aem/LyvyMnS4MvQKD3KyDUB+ZYOKNuy03nzRdzWtqb
         cW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=aFH5O6viJ6NTA25wi2Aiw0FQRIeUfCBP+ZrmMXU/R8U=;
        b=pzkMLpm6f9elhZElyLpzDdc+Urq4dL/MYCvBpSjYcay39xzNuIrIa2rGoIfYi5OCV8
         huAeuiZFg2lQzylveXUIVwCanqQ4e7PJ+i8UAPNUio1GWd24gv7fZJ9Sf1Y1VpsJpd9X
         P5lV9DQQ25Ik+V0kh2coMtgNGHF86txOQWX8K5oi9FRul9tNwsG2D+2oB7pID7JaBffH
         JXmuJIA3uRxKQ0vMvb1txNDO19hXU93Shq2+CtNjl956KotJ+KgOnjR9yVsS3gWZ12XK
         ldLkB/hwlk43WiTOy5/xet4Qece9iBbOHdBU6uU40EX7zV8Az1l8N6yNJJVkWbVOYZBz
         p9Mg==
X-Gm-Message-State: ACgBeo38YUHYJ+OqtwWR2wR2XwnLNrtvbR6NHndGxTrJrkgvWo3hVJMY
        wMA9BqabeXToqQYRbGEw2egcCqJ3K1+Hyw==
X-Google-Smtp-Source: AA6agR68bfyFcPtOh9vOrp8v/SUJJPQ60t8CE7KEgOseSTZNnkHGZ4D3OXVcrP2kTTf1bI1kHq7aAg==
X-Received: by 2002:a63:8bc8:0:b0:41c:6800:d4e9 with SMTP id j191-20020a638bc8000000b0041c6800d4e9mr14484480pge.45.1660590165321;
        Mon, 15 Aug 2022 12:02:45 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:df3e:22e0:b905:822b])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902a3cd00b0016a4db13429sm7266926plb.192.2022.08.15.12.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 12:02:43 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/4] tools lib perf: Add a test case for read formats
Date:   Mon, 15 Aug 2022 12:01:05 -0700
Message-Id: <20220815190106.1293082-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220815190106.1293082-1-namhyung@kernel.org>
References: <20220815190106.1293082-1-namhyung@kernel.org>
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

