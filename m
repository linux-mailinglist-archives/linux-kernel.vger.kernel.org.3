Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9F74D44F4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbiCJKtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241381AbiCJKtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:49:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369A013F03
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:48:05 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AAKiDm023317;
        Thu, 10 Mar 2022 10:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UV+X5J1OdcME8oyPlGRp8HVP5l/DmgVHImLcf3K+ddA=;
 b=V3E3pm1HKox0XeP6J4y7aBWnSEfXjRGMOTafSk/D7UFDVQNluP/M46KYqO9gnuE77GMz
 3jg4/bu3sPT/GM9F7nCf+aBNQlmQqV31Xp8sQLOsNCyMNfHYV58nF/SmWQaxYjcPHNw5
 vVPQH4E+PXBW5V1whG01XIdbxfnZPmIEVb/evAUJtUPzBuVoXCvwttC68dPWe58Lgrbk
 61r5o0mTX4KrPiICKsHJULaYGAndmZrXv6sCbuxpzqGyak0fCN+5dKdFAr/W4keArMoE
 tiarAttFoB4tRPUMXX9xuCAQ17BF1dKo0CgA7DrDbtKN6tbWPF5CumqytyKJBLcN3ri9 0w== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep0sdqpte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 10:47:55 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22AAch5n005626;
        Thu, 10 Mar 2022 10:47:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3enpk2x3em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 10:47:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22AAloKj37945642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 10:47:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2E965204E;
        Thu, 10 Mar 2022 10:47:50 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.68.168])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 61ABE5204F;
        Thu, 10 Mar 2022 10:47:49 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, cclaudio@linux.ibm.com
Subject: [PATCH] perf trace: Fix SIGSEGV when processing augmented args
Date:   Thu, 10 Mar 2022 16:17:41 +0530
Message-Id: <20220310104741.209834-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DEridyfWJVYNaC7c7f8xYhyhbuXJ_RTN
X-Proofpoint-GUID: DEridyfWJVYNaC7c7f8xYhyhbuXJ_RTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_03,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On powerpc, 'perf trace' is crashing with a SIGSEGV when trying to
process a perf data file created with 'perf trace record -p':

  #0  0x00000001225b8988 in syscall_arg__scnprintf_augmented_string <snip> at builtin-trace.c:1492
  #1  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1492
  #2  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1486
  #3  0x00000001225bdd9c in syscall_arg_fmt__scnprintf_val <snip> at builtin-trace.c:1973
  #4  syscall__scnprintf_args <snip> at builtin-trace.c:2041
  #5  0x00000001225bff04 in trace__sys_enter <snip> at builtin-trace.c:2319

The size captured in the augmented arg looks corrupt, resulting in the
augmented arg pointer being adjusted incorrectly. Fix this by checking
that the size is reasonable.

Reported-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
While this resolves the 'perf trace' crash, I'm not yet sure why the
size for the augmented arg is corrupt. This looks to be happening when
processing the sample for 'read' syscall. Any pointers?

Thanks,
- Naveen


 tools/perf/builtin-trace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 52b137a184a66a..150c9cbe3316b8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1487,10 +1487,12 @@ static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, c
 	 * So that the next arg with a payload can consume its augmented arg, i.e. for rename* syscalls
 	 * we would have two strings, each prefixed by its size.
 	 */
-	int consumed = sizeof(*augmented_arg) + augmented_arg->size;
+	int consumed = sizeof(*augmented_arg) + (unsigned int)augmented_arg->size;
 
-	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
-	arg->augmented.size -= consumed;
+	if (consumed < arg->augmented.size) {
+		arg->augmented.args = ((void *)arg->augmented.args) + consumed;
+		arg->augmented.size -= consumed;
+	}
 
 	return printed;
 }

base-commit: e314fe9c2ad65adcb62fa98376a5f35502e4f4dd
-- 
2.35.1

