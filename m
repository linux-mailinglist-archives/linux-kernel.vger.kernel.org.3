Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345C1477585
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbhLPPPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:15:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238360AbhLPPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:15:16 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGEDKOd015755;
        Thu, 16 Dec 2021 15:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=hKNKycRym3x9GHWCfz5lPHDwoZeaptYTWMEuVKi0io0=;
 b=X1zfZ2A1zak2cBZeKz4w10dF8KH3xFIXZDGAj06SgZrkdjGEVUyPMgPS1FAeLD5iSycJ
 92G/LgMaZBJxYCn3CUVaXe7HLZ/vlX6lWqKNCiDoU2FyF++Sjk0Og2g/bqsxlhwz12w4
 KE2fxoGektgxETYXm8oa85TommdItC1d2hf7o21ZW4468+tlGOef3hAfq/McDWnjV6aR
 OI0OOU7LE3WPwrtjBmedx8ekxm6hW+uZxK6R6fs06KJq3DTp8o7scLlVsN+glEnDYVzV
 4Fas4MTYkd3NO6u2AI3u4PMVvXIOLu6Y+chzkDg6u0F6AQFak04VHKLBJA4S77wNSiLK eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyfdprxue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 15:15:14 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BGEfiSJ017181;
        Thu, 16 Dec 2021 15:15:14 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyfdprxth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 15:15:14 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BGFDO9j030426;
        Thu, 16 Dec 2021 15:15:12 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3cy77pfrdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 15:15:11 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BGFF89f44433800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 15:15:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59A81A405B;
        Thu, 16 Dec 2021 15:15:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09736A4067;
        Thu, 16 Dec 2021 15:15:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 15:15:07 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, elver@google.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Test 73 Sig_trap fails on s390
Date:   Thu, 16 Dec 2021 16:14:54 +0100
Message-Id: <20211216151454.752066-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SfazHpssHIBWLqbeXf5A0qrVQZ8GLHQl
X-Proofpoint-ORIG-GUID: g43JBdnIIbzwi1s_H2pnMktZt41VATPJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_05,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Linux next kernel
Commit 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
introduced the new test which uses breakpoint events.
These events are not supported on s390 and PowerPC and always fail:

 # perf test -F 73
 73: Sigtrap                                                         : FAILED!
 #

Fix it the same way as in the breakpoint tests in file
tests/bp_account.c where these type of tests are skipped on
s390 and PowerPC platforms.

With this patch skip this test on both platforms.

Output after:
 # ./perf test -F 73
 73: Sigtrap

Fixes: 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")

Cc: Marco Elver <elver@google.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/sigtrap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
index 1004bf0e7cc9..1f147fe6595f 100644
--- a/tools/perf/tests/sigtrap.c
+++ b/tools/perf/tests/sigtrap.c
@@ -22,6 +22,19 @@
 #include "tests.h"
 #include "../perf-sys.h"
 
+/*
+ * PowerPC and S390 do not support creation of instruction breakpoints using the
+ * perf_event interface.
+ *
+ * Just disable the test for these architectures until these issues are
+ * resolved.
+ */
+#if defined(__powerpc__) || defined(__s390x__)
+#define BP_ACCOUNT_IS_SUPPORTED 0
+#else
+#define BP_ACCOUNT_IS_SUPPORTED 1
+#endif
+
 #define NUM_THREADS 5
 
 static struct {
@@ -122,6 +135,11 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
 	char sbuf[STRERR_BUFSIZE];
 	int i, fd, ret = TEST_FAIL;
 
+	if (!BP_ACCOUNT_IS_SUPPORTED) {
+		pr_debug("Test not supported on this architecture");
+		return TEST_SKIP;
+	}
+
 	pthread_barrier_init(&barrier, NULL, NUM_THREADS + 1);
 
 	action.sa_flags = SA_SIGINFO | SA_NODEFER;
-- 
2.33.1

