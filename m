Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA1475CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244413AbhLOQEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:04:21 -0500
Received: from foss.arm.com ([217.140.110.172]:55970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244407AbhLOQET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:04:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A23ED1477;
        Wed, 15 Dec 2021 08:04:18 -0800 (PST)
Received: from e126387.extremechicken.org (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E4503F5A1;
        Wed, 15 Dec 2021 08:04:17 -0800 (PST)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, inux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH 03/12] perf test: Use 3 digits for test numbering now we can have more tests
Date:   Wed, 15 Dec 2021 16:03:54 +0000
Message-Id: <20211215160403.69264-3-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
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
 tools/perf/tests/builtin-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 849737ead9fd..8652dcc4912c 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -435,7 +435,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
 			continue;
 
 		st.file = ent->d_name;
-		pr_info("%2d: %-*s:", i, width, test_suite.desc);
+		pr_info("%3d: %-*s:", i, width, test_suite.desc);
 
 		if (intlist__find(skiplist, i)) {
 			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
@@ -485,7 +485,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 				continue;
 		}
 
-		pr_info("%2d: %-*s:", i, width, test_description(t, -1));
+		pr_info("%3d: %-*s:", i, width, test_description(t, -1));
 
 		if (intlist__find(skiplist, i)) {
 			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
@@ -525,7 +525,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 							curr, argc, argv))
 					continue;
 
-				pr_info("%2d.%1d: %-*s:", i, subi + 1, subw,
+				pr_info("%3d.%1d: %-*s:", i, subi + 1, subw,
 					test_description(t, subi));
 				test_and_print(t, subi);
 			}
@@ -560,7 +560,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
 		if (!perf_test__matches(t.desc, curr, argc, argv))
 			continue;
 
-		pr_info("%2d: %s\n", i, t.desc);
+		pr_info("%3d: %s\n", i, t.desc);
 
 	}
 
@@ -582,14 +582,14 @@ static int perf_test__list(int argc, const char **argv)
 		if (!perf_test__matches(test_description(t, -1), curr, argc, argv))
 			continue;
 
-		pr_info("%2d: %s\n", i, test_description(t, -1));
+		pr_info("%3d: %s\n", i, test_description(t, -1));
 
 		if (has_subtests(t)) {
 			int subn = num_subtests(t);
 			int subi;
 
 			for (subi = 0; subi < subn; subi++)
-				pr_info("%2d:%1d: %s\n", i, subi + 1,
+				pr_info("%3d:%1d: %s\n", i, subi + 1,
 					test_description(t, subi));
 		}
 	}
-- 
2.32.0

