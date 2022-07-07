Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23069569E4C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiGGJJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiGGJJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:09:36 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A30425C57
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:09:35 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2678DoTt017294;
        Thu, 7 Jul 2022 09:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xrriXOd8MXHikzW4mDV3911Ou00ihCVJD4NXqNVvj2k=;
 b=R9Qll9q6+ZLuK81k6J97Pnu0u1VqdwLD6Qf5YylAODQ764EOIZE5lGc9QH57ype07bIp
 mP62IdmvOi5lGYn12fzOZ0VL1MbvJXyihSeTksqzb72RCU1fLOwsaAALosThhWTkO9Rk
 8QNi/l/8dKvhdK/VNug/Loc9clrAp5r+jFsUx6UbK312kT0X/+YP/Kuql56qxX6ZK5gm
 eV+4qa+Xa3BlaU6m9Zoswp431nP9+ABcwKYO2NtI7Beu5PYvPwquVSb+GiGJBb9vuN8v
 4S/Gs+Y9BPAMSKBI/787CcIFdZgQuKoIRQkXpqSNa0qa+7wlDRHqVJPlcYJMSjUOBS/S Bg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5smc4yj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 09:09:31 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26795n0t027290;
        Thu, 7 Jul 2022 09:09:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3h4v4jtaqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 09:09:29 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26799QJr24314346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 09:09:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93776A4040;
        Thu,  7 Jul 2022 09:09:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1981A4053;
        Thu,  7 Jul 2022 09:09:24 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.78.163])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 09:09:24 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     cclaudio@linux.ibm.com, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] perf trace: Fix SIGSEGV when processing syscall args
Date:   Thu,  7 Jul 2022 14:39:00 +0530
Message-Id: <20220707090900.572584-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V_NH2Sk65YjV5iUmjpQYEKFq1Dw0p4C4
X-Proofpoint-ORIG-GUID: V_NH2Sk65YjV5iUmjpQYEKFq1Dw0p4C4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On powerpc, 'perf trace' is crashing with a SIGSEGV when trying to
process a perf.data file created with 'perf trace record -p':

  #0  0x00000001225b8988 in syscall_arg__scnprintf_augmented_string <snip> at builtin-trace.c:1492
  #1  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1492
  #2  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1486
  #3  0x00000001225bdd9c in syscall_arg_fmt__scnprintf_val <snip> at builtin-trace.c:1973
  #4  syscall__scnprintf_args <snip> at builtin-trace.c:2041
  #5  0x00000001225bff04 in trace__sys_enter <snip> at builtin-trace.c:2319

That points to the below code in tools/perf/builtin-trace.c:
	/*
	 * If this is raw_syscalls.sys_enter, then it always comes with the 6 possible
	 * arguments, even if the syscall being handled, say "openat", uses only 4 arguments
	 * this breaks syscall__augmented_args() check for augmented args, as we calculate
	 * syscall->args_size using each syscalls:sys_enter_NAME tracefs format file,
	 * so when handling, say the openat syscall, we end up getting 6 args for the
	 * raw_syscalls:sys_enter event, when we expected just 4, we end up mistakenly
	 * thinking that the extra 2 u64 args are the augmented filename, so just check
	 * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
	 */
	if (evsel != trace->syscalls.events.sys_enter)
		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);

As the comment points out, we should not be trying to augment the args
for raw_syscalls. However, when processing a perf.data file, we are not
initializing those properly. Fix the same.

Reported-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/builtin-trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 897fc504918b91..f075cf37a65ef8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4280,6 +4280,7 @@ static int trace__replay(struct trace *trace)
 		goto out;
 
 	evsel = evlist__find_tracepoint_by_name(session->evlist, "raw_syscalls:sys_enter");
+	trace->syscalls.events.sys_enter = evsel;
 	/* older kernels have syscalls tp versus raw_syscalls */
 	if (evsel == NULL)
 		evsel = evlist__find_tracepoint_by_name(session->evlist, "syscalls:sys_enter");
@@ -4292,6 +4293,7 @@ static int trace__replay(struct trace *trace)
 	}
 
 	evsel = evlist__find_tracepoint_by_name(session->evlist, "raw_syscalls:sys_exit");
+	trace->syscalls.events.sys_exit = evsel;
 	if (evsel == NULL)
 		evsel = evlist__find_tracepoint_by_name(session->evlist, "syscalls:sys_exit");
 	if (evsel &&

base-commit: 52f28b7bac75da9b8508f17438c9a8d83ab48e5d
-- 
2.36.1

