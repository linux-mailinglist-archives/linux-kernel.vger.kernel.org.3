Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B574BB5C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiBRJjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:39:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiBRJjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:39:17 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FA21FA74;
        Fri, 18 Feb 2022 01:39:00 -0800 (PST)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K0RTH49hlz67b2s;
        Fri, 18 Feb 2022 17:38:27 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 18 Feb 2022 10:38:58 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 09:38:54 +0000
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <elver@google.com>, <leo.yan@linaro.org>, <dvyukov@google.com>,
        <will@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux@armlinux.org.uk>,
        <tmricht@linux.ibm.com>, <irogers@google.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2] perf test: Skip Sigtrap test for arm+aarch64
Date:   Fri, 18 Feb 2022 17:33:33 +0800
Message-ID: <1645176813-202756-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip the Sigtrap test for arm + arm64, same as was done for s390 in
commit a840974e96fd ("perf test: Test 73 Sig_trap fails on s390"). For
this, reuse BP_SIGNAL_IS_SUPPORTED - meaning that the arch can use BP to
generate signals - instead of BP_ACCOUNT_IS_SUPPORTED, which is
appropriate.

As described by Will at [0], in the test we get stuck in a loop of handling
the HW breakpoint exception and never making progress. GDB handles this
by stepping over the faulting instruction, but with perf the kernel is
expected to handle the step (which it doesn't for arm).

Dmitry made an attempt to get this work, also mentioned in the same thread
as [0], which was appreciated. But the best thing to do is skip the test
for now.

[0] https://lore.kernel.org/linux-perf-users/20220118124343.GC98966@leoy-ThinkPad-X240s/T/#m13b06c39d2a5100d340f009435df6f4d8ee57b5a

Fixes: Fixes: 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
index 1f147fe6595f..e32ece90e164 100644
--- a/tools/perf/tests/sigtrap.c
+++ b/tools/perf/tests/sigtrap.c
@@ -22,19 +22,6 @@
 #include "tests.h"
 #include "../perf-sys.h"
 
-/*
- * PowerPC and S390 do not support creation of instruction breakpoints using the
- * perf_event interface.
- *
- * Just disable the test for these architectures until these issues are
- * resolved.
- */
-#if defined(__powerpc__) || defined(__s390x__)
-#define BP_ACCOUNT_IS_SUPPORTED 0
-#else
-#define BP_ACCOUNT_IS_SUPPORTED 1
-#endif
-
 #define NUM_THREADS 5
 
 static struct {
@@ -135,7 +122,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
 	char sbuf[STRERR_BUFSIZE];
 	int i, fd, ret = TEST_FAIL;
 
-	if (!BP_ACCOUNT_IS_SUPPORTED) {
+	if (!BP_SIGNAL_IS_SUPPORTED) {
 		pr_debug("Test not supported on this architecture");
 		return TEST_SKIP;
 	}
-- 
2.26.2

