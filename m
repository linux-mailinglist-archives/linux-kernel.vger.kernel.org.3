Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D998508132
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344839AbiDTGdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241754AbiDTGc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:32:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF7F11C0A;
        Tue, 19 Apr 2022 23:30:11 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K5gAtK020335;
        Wed, 20 Apr 2022 06:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=dwK7Jz5egacq4U7B1418c7gUMdrS3O8V298T2k9VQP4=;
 b=J2J0o+bvOeekQ8xyL1aXk6QUjgxUX1sfKcFY+I7D5txGRaHPr/+dqEKqhE8HvLe9Fwm8
 5/f3n1ycG7sIfR9VNJfAsIh4ecqBGEq7g1KVFalp3FxZSb8E4agdhcXKyY4h7VQi6vKu
 lKnNMTXyK1BDLnvmWgG3osMFUK9H2lr+rlyYTV6kIDhZ7Uku3T/QaqBq40XuYRg97Y8C
 RwP5jvEmUryGft+0S6whI4WUq1y25cT/qY6gtsyODufpaLKMM3ld2EiNUa2+6fQvfC/R
 djef0jTv7B2/J0qWH15cVLmFvxRCFUzbujWVakWnoomRJboR5B5lnbnZmOLYqr7dgssR rw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fg75r3hp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 06:29:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23K6HnUi024667;
        Wed, 20 Apr 2022 06:29:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3ffn2hwra2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 06:29:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23K6TVIN16318904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 06:29:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C8AC52059;
        Wed, 20 Apr 2022 06:29:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 41B495204F;
        Wed, 20 Apr 2022 06:29:31 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, chengdongli@tencent.com, adrian.hunter@intel.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/test: test case 71 fails on s390
Date:   Wed, 20 Apr 2022 08:29:21 +0200
Message-Id: <20220420062921.1211825-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WnTCLPGNRju_nnAMgMIKkS4pxJafbQ3X
X-Proofpoint-GUID: WnTCLPGNRju_nnAMgMIKkS4pxJafbQ3X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_08,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test case 71 'Convert perf time to TSC' is not supported on s390.
Subtest 71.1 is skipped with the correct message, but
subtest 71.2 is not skipped and fails.

The root cause is function evlist__open() called from
test__perf_time_to_tsc().  evlist__open() returns -ENOENT because the
event cycles:u is not supported by the selected PMU, for example 
platform s390 on z/VM or an x86_64 virtual machine.
The PMU driver returns -ENOENT in this case. This error is leads to
the failure.
Fix this by returning TEST_SKIP on -ENOENT.

Output before:
 71: Convert perf time to TSC:
 71.1: TSC support:             Skip (This architecture does not support)
 71.2: Perf time to TSC:        FAILED!

Output after:
 71: Convert perf time to TSC:
 71.1: TSC support:             Skip (This architecture does not support)
 71.2: Perf time to TSC:        Skip (perf_read_tsc_conversion is not supported)

This also happens on an x86_64 virtual machine:
   # uname -m
   x86_64
   $ ./perf test -F 71
    71: Convert perf time to TSC  :
    71.1: TSC support             : Ok
    71.2: Perf time to TSC        : FAILED!
   $ 

Fixes: 290fa68bdc45 ("perf test tsc: Fix error message when not supported")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 tools/perf/tests/perf-time-to-tsc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index cc6df49a65a1..4ad0dfbc8b21 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -123,6 +123,10 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 		evsel->core.attr.enable_on_exec = 0;
 	}
 
+	if (evlist__open(evlist) == -ENOENT) {
+		err = TEST_SKIP;
+		goto out_err;
+	}
 	CHECK__(evlist__open(evlist));
 
 	CHECK__(evlist__mmap(evlist, UINT_MAX));
-- 
2.35.1

