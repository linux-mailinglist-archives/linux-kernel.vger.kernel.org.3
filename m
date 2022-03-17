Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322984DCA92
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiCQPzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiCQPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:55:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06D51BE0FC;
        Thu, 17 Mar 2022 08:54:11 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HF7LmE038086;
        Thu, 17 Mar 2022 15:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=S+lDeG0ajurXSUSr/Pz+jBGyskQ6ZVNdxBLgTQMn2gE=;
 b=Ms41hvsTzuyHKglbfNwCj3lz1rEcmh9QCeTB8rjwZCarqaXYQycPSwftIAR4SghxlY0/
 om8EhOJkjefFIPI2xWOpqzCZEKNv/kjUkeVndDtCBOZr97VQxdYMN9thC7rwSJtqYWoy
 nkzgMTRq3q5VDZYz3cilqO5Z6aPo3jJjAPt/9IV13269yWrVa4E8eFQrOgg0P5/xfN33
 Ek4os0izJwceKHGaIRuP2/2d89rFKpKnYP6M/qMkVQmgjLqnam4Qe3jUQvrN3omcI+EO
 Sb6A59dOCQcMnsyWVzHLOQYS1cCvsL60friGcPfQx5ZMuiFz4NWIVxHUQb2i7ds0OI8s aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev074205m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 15:54:08 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22HFjl7J025718;
        Thu, 17 Mar 2022 15:54:07 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev0742052-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 15:54:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22HFWsuV011967;
        Thu, 17 Mar 2022 15:54:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3erk593q3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 15:54:05 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22HFs2sZ27656640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 15:54:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C72A4204D;
        Thu, 17 Mar 2022 15:54:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3EA942047;
        Thu, 17 Mar 2022 15:54:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Mar 2022 15:54:01 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org, gor@linux.ibm.com,
        acme@redhat.com
Cc:     svens@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/stat: Fix perf stat for forked applications
Date:   Thu, 17 Mar 2022 16:53:46 +0100
Message-Id: <20220317155346.577384-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PrRuTHxADO7btN5CNCExNzB6RMxe_QQG
X-Proofpoint-ORIG-GUID: 14acJSIwoUTpjh9_IHFPn2BNeASx9ofa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_06,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have run into the following issue:

 # perf stat -a -e new_pmu/INSTRUCTION_7/ --  mytest -c1 7

 Performance counter stats for 'system wide':

                 0      new_pmu/INSTRUCTION_7/

       0.000366428 seconds time elapsed
 #

The new PMU for s390 counts the execution of certain CPU instructions.
The root cause is the extremely small run time of the
mytest program. It just executes some assembly instructions
and then exits. In above invocation the instruction is executed
exactly one time (-c1 option). The PMU is expected to report this one
time execution by a counter value of one, but fails to do so
in some cases, not all.

Debugging reveals the invocation of the child process is done
*before* the counter events are installed and enabled. Tracing
reveals that sometimes the child process starts and exits before
the event is installed on all CPUs. The more CPUs the machine has,
the more often this miscount happens.

Fix this by reversing the start of the work load after the events
have been installed on the specified CPUs. Now the comment also
matches the code.

Output after:
 # perf stat -a -e new_pmu/INSTRUCTION_7/ --  mytest -c1 7

 Performance counter stats for 'system wide':

                 1      new_pmu/INSTRUCTION_7/

       0.000366428 seconds time elapsed
 #

Now the correct result is reported rock solid all the time regardless
how many CPUs are online.

Fixes:  acf2892270dc ("perf stat: Use perf_evlist__prepare/start_workload())

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3f98689dd687..60baa3dadc4b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -955,10 +955,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	 * Enable counters and exec the command:
 	 */
 	if (forks) {
-		evlist__start_workload(evsel_list);
 		err = enable_counters();
 		if (err)
 			return -1;
+		evlist__start_workload(evsel_list);
 
 		t0 = rdclock();
 		clock_gettime(CLOCK_MONOTONIC, &ref_time);
-- 
2.35.1

