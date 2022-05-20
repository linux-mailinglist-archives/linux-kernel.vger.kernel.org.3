Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418D752E703
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243407AbiETIMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241875AbiETIMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:12:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5824ED790;
        Fri, 20 May 2022 01:12:13 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K4QUeh000310;
        Fri, 20 May 2022 08:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=FhTqy8GufFhhuU9nuGr3TIMYf8rq3SU3NZu8orqFmEU=;
 b=QBxqVfbmp6IRb1DS0m13NyL6UJef6GMfBgqD5RfxoDpYed361o4D3NdAvoTSMhsDLr/j
 XGRQHtkQbZxlW1cUBBzh2GxriPrdnSEEfoARAMcFPTA317l9zi55/D/CA7Di3ddXhOWb
 NOVm5PjIGtx+a7WZGrQ4He0XxADpWMkFnQJ7l2LxlvKXPAdMRn5CFRTfMS43M8h2cRHp
 kYbw7hz1W0JOvLLXusfJlgUpFSMMqaaDIH5mw1PNsaa6kPMpFRcbPeRVcmiJAmKajzAU
 y3wUicuny+wPkJ/ZE97SxQz54gzI/YfNCqO4TndCWQFgEWoFm1ccg2kx5AjeGef33/O/ Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5ye4qwnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 08:12:10 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24K89nwW012174;
        Fri, 20 May 2022 08:12:10 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5ye4qwn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 08:12:09 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24K88wgs003119;
        Fri, 20 May 2022 08:12:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3g2428xve3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 08:12:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24K8C4qJ38994194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 08:12:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D643B11C052;
        Fri, 20 May 2022 08:12:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A72A11C04C;
        Fri, 20 May 2022 08:12:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 May 2022 08:12:04 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Namhyung Kim <namhyung@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf/s390: Compiler error on s390 for bench/numa.c
Date:   Fri, 20 May 2022 10:11:58 +0200
Message-Id: <20220520081158.2990006-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G-hqh_xU9Av7_Y095NhEWLP5iMfeXb1N
X-Proofpoint-ORIG-GUID: sn581ht0DmnfQNOnJq-vQ7BicDUkSqlq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_02,2022-05-19_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compilation on s390 results in this error:

 # make DEBUG=y bench/numa.o
 ...
 bench/numa.c: In function ‘__bench_numa’:
 bench/numa.c:1749:81: error: ‘%d’ directive output may be truncated
             writing between 1 and 11 bytes into a region of size between
             10 and 20 [-Werror=format-truncation=]
 1749 |        snprintf(tname, sizeof(tname), "process%d:thread%d", p, t);
                                                               ^~
 ...
 bench/numa.c:1749:64: note: directive argument in the range
                [-2147483647, 2147483646]
 ...
 #

The maximum length of the %d replacement is 11 characters because
of the negative sign.  Therefore extend the array by two more
characters.

Output after:
 # make  DEBUG=y bench/numa.o > /dev/null 2>&1; ll bench/numa.o
 -rw-r--r-- 1 root root 418320 May 19 09:11 bench/numa.o
 #

Fixes: 3aff8ba0a4c9c ("perf bench numa: Avoid possible truncation when using snprintf()")
Suggested-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/bench/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index d5289fa58a4f..20eed1e53f80 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -1740,7 +1740,7 @@ static int __bench_numa(const char *name)
 		"GB/sec,", "total-speed",	"GB/sec total speed");
 
 	if (g->p.show_details >= 2) {
-		char tname[14 + 2 * 10 + 1];
+		char tname[14 + 2 * 11 + 1];
 		struct thread_data *td;
 		for (p = 0; p < g->p.nr_proc; p++) {
 			for (t = 0; t < g->p.nr_threads; t++) {
-- 
2.36.1

