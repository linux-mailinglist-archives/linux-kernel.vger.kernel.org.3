Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37D94613D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242616AbhK2L3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:29:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239790AbhK2L1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:27:15 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATBFdog001856;
        Mon, 29 Nov 2021 11:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=uWELD1rP4wP6QD8zFTScewoO15gPNuOlLH+WwV0bYUY=;
 b=gPkdgBb01CJhiSyYm7coWr4C9DnIzXYI24kXKvh661XHQiL3+MSUhuL//FwZ4U2NI/bC
 Ag4k+/EAt2NamyyMxFQm2JJgsbPpeqrXAfqLbybEjliYpK/1V07ZDo1sT0IKMpiztDI9
 IjeFCsSItZhXAWVJjQMK+RBQxoYROsQzlWIqhsyLD29gtaqcQlp+0+UAuUBArDN4ruVY
 M+59gQVHVwzwwSdfAYm153Yi7+LriEjSLmdE0507096lUxaEGeQVNizbnWzorjsWm42C
 S8VWF5kpuZzzohpqZLyNysXRURTzYwePrXrzitd9BbR4ZYySfmF1akuxxKvqfRjOL2h9 zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmwu5069c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 11:23:56 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATBNtaG002395;
        Mon, 29 Nov 2021 11:23:55 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmwu5067p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 11:23:55 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATBIaTJ020969;
        Mon, 29 Nov 2021 11:23:53 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3ckbxjb7u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 11:23:53 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATBNn6n15073716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 11:23:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D06BFAE053;
        Mon, 29 Nov 2021 11:23:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8448DAE056;
        Mon, 29 Nov 2021 11:23:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 11:23:49 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] tools/perf: Fix perf test 7 Simple expression parser
Date:   Mon, 29 Nov 2021 12:23:39 +0100
Message-Id: <20211129112339.3003036-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o9Y9fGPS_2BhgaQ672o4IikBai3RT85c
X-Proofpoint-GUID: nSwQyw7UN6rvdD1YYqVc00FPaidY2HBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms do not have CPU die support, for example s390.
Commit fdf1e29b6118 ("perf expr: Add metric literals for topology.")
fails on s390:
 # ./perf test -Fv 7
   ...
 # FAILED tests/expr.c:173 #num_dies >= #num_packages
   ---- end ----
   Simple expression parser: FAILED!
 #

Investigating this issue leads to these functions:
 build_cpu_topology()
   +--> has_die_topology(void)
        {
           struct utsname uts;

           if (uname(&uts) < 0)
                  return false;
           if (strncmp(uts.machine, "x86_64", 6))
                  return false;
           ....
        }

which always returns false on s390. The caller build_cpu_topology()
checks has_die_topology() return value. On false the
the struct cpu_topology::die_cpu_list is not contructed and has zero
entries. This leads to the failing comparison: #num_dies >= #num_packages.
s390 of course has a positive number of packages.

Fix this and check if the function build_cpu_topology() did build up
a die_cpus_list. The number of entries in this list should be larger
than 0. If the number of list element is zero, the die_cpus_list has
not been created and the check in function test__expr()
    TEST_ASSERT_VAL("#num_dies >= #num_packages", \
		    num_dies >= num_packages)
always fails.

Output after:
 # ./perf test -Fv 7
  7: Simple expression parser                                        :
  --- start ---
  division by zero
  syntax error
  ---- end ----
  Simple expression parser: Ok
 #
Cc: Ian Rogers <irogers@google.com>
Fixes: fdf1e29b6118 ("perf expr: Add metric literals for topology.")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index c895de481fe1..9356d90bf8db 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -169,7 +169,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	TEST_ASSERT_VAL("#num_dies", expr__parse(&num_dies, ctx, "#num_dies") == 0);
 	TEST_ASSERT_VAL("#num_cores >= #num_dies", num_cores >= num_dies);
 	TEST_ASSERT_VAL("#num_packages", expr__parse(&num_packages, ctx, "#num_packages") == 0);
-	TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
+	if (num_dies)
+		TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
 
 	/*
 	 * Source count returns the number of events aggregating in a leader
-- 
2.31.1

