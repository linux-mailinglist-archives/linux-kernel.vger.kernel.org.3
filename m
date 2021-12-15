Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266BC475925
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhLOMzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:55:00 -0500
Received: from foss.arm.com ([217.140.110.172]:51196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242646AbhLOMy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:54:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA23CD6E;
        Wed, 15 Dec 2021 04:54:57 -0800 (PST)
Received: from e126387.extremechicken.org (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF35E3F774;
        Wed, 15 Dec 2021 04:54:56 -0800 (PST)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
Subject: [PATCH 03/12] perf test: Use 3 digits for test numbering now we can have more tests
Date:   Wed, 15 Dec 2021 12:54:00 +0000
Message-Id: <20211215125409.61488-3-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215125409.61488-1-carsten.haitzler@foss.arm.com>
References: <20211215125409.61488-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

This is in preparation for adding more tests that will need the test
number to be 3 digts so they align nicely in the output.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 tools/perf/tests/builtin-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 2f6a74d9f0bc..9091f7c74f8e 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -634,7 +634,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
 			continue;
 
 		st.file = ent->d_name;
-		pr_info("%2d: %-*s:", i, width, test.desc);
+		pr_info("%3d: %-*s:", i, width, test.desc);
 		test_and_print(&test, false, -1);
 	}
 
@@ -679,11 +679,11 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 		}
 
 		if (t->is_supported && !t->is_supported()) {
-			pr_debug("%2d: %-*s: Disabled\n", i, width, t->desc);
+			pr_debug("%3d: %-*s: Disabled\n", i, width, t->desc);
 			continue;
 		}
 
-		pr_info("%2d: %-*s:", i, width, t->desc);
+		pr_info("%3d: %-*s:", i, width, t->desc);
 
 		if (intlist__find(skiplist, i)) {
 			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
@@ -723,7 +723,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 				if (!perf_test__matches(t->subtest.get_desc(subi), curr, argc, argv))
 					continue;
 
-				pr_info("%2d.%1d: %-*s:", i, subi + 1, subw,
+				pr_info("%3d.%1d: %-*s:", i, subi + 1, subw,
 					t->subtest.get_desc(subi));
 				err = test_and_print(t, skip, subi);
 				if (err != TEST_OK && t->subtest.skip_if_fail)
@@ -759,7 +759,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
 		if (!perf_test__matches(t.desc, curr, argc, argv))
 			continue;
 
-		pr_info("%2d: %s\n", i, t.desc);
+		pr_info("%3d: %s\n", i, t.desc);
 	}
 
 	closedir(dir);
@@ -779,14 +779,14 @@ static int perf_test__list(int argc, const char **argv)
 		    (t->is_supported && !t->is_supported()))
 			continue;
 
-		pr_info("%2d: %s\n", i, t->desc);
+		pr_info("%3d: %s\n", i, t->desc);
 
 		if (t->subtest.get_nr) {
 			int subn = t->subtest.get_nr();
 			int subi;
 
 			for (subi = 0; subi < subn; subi++)
-				pr_info("%2d:%1d: %s\n", i, subi + 1,
+				pr_info("%3d:%1d: %s\n", i, subi + 1,
 					t->subtest.get_desc(subi));
 		}
 	}
-- 
2.32.0

