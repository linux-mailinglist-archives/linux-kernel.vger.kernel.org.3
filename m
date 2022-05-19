Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182D652CEC1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiESI4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiESIzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:55:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D4BDF4B;
        Thu, 19 May 2022 01:55:52 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J8CS1t020312;
        Thu, 19 May 2022 08:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=qPj3tCG2XC1z/JKo0fO7RystCI28s0gLivNl9vPh+U8=;
 b=Q2t67BbeclxQ+XSy0VFeGGzJRgfFGBEiIMkcQbdiPfMm2yN5byKsUZjFMVuUM5RZPnUP
 Ri8wXgwM6U/KIqZB0e1u07jMebUPCKMpQWcT6szMXfRL5DnOdKoOpyjEuStlNfKk7oJC
 lcrlZW1NNOLmOCT0+If1iP3y//UkJ+oSMYdjQyLm/hh8odzrogxohOmJpY0IowXieHOl
 UGS7drfzYwao4/jl5TIi1FXK1WqbUEPc+9Kl3d1JDA17kz4QoriXgZL3Eh7jZMmoPv0+
 swbKkUNIaom6xg9T1FrnSPjjw3wjVFIboGQvJcUkxVdKCuxgfvIbLfrO863mW7CwDHqY 8w== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5j67s0g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 08:55:45 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24J8niN6003443;
        Thu, 19 May 2022 08:55:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3g2428wn05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 08:55:42 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24J8td6n52298114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 08:55:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B37742042;
        Thu, 19 May 2022 08:55:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AD184203F;
        Thu, 19 May 2022 08:55:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 May 2022 08:55:39 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/s390: Compiler error on s390 for bench/numa.c
Date:   Thu, 19 May 2022 10:55:30 +0200
Message-Id: <20220519085530.999726-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wy7CXl0s37DVnK6BwpHpa8HCag4rUIU6
X-Proofpoint-GUID: Wy7CXl0s37DVnK6BwpHpa8HCag4rUIU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_01,2022-05-19_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190049
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
of the negative sign.  Therefore use %u as format conversion.

Output after:
 # make  DEBUG=y bench/numa.o > /dev/null 2>&1; ll bench/numa.o
 -rw-r--r-- 1 root root 418320 May 19 09:11 bench/numa.o
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/bench/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index d5289fa58a4f..ff0bfd87afbb 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -1746,7 +1746,7 @@ static int __bench_numa(const char *name)
 			for (t = 0; t < g->p.nr_threads; t++) {
 				memset(tname, 0, sizeof(tname));
 				td = g->threads + p*g->p.nr_threads + t;
-				snprintf(tname, sizeof(tname), "process%d:thread%d", p, t);
+				snprintf(tname, sizeof(tname), "process%u:thread%u", p, t);
 				print_res(tname, td->speed_gbs,
 					"GB/sec",	"thread-speed", "GB/sec/thread speed");
 				print_res(tname, td->system_time_ns / NSEC_PER_SEC,
-- 
2.36.1

