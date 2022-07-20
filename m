Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD43E57B689
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbiGTMel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240392AbiGTMeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:34:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922774D80E;
        Wed, 20 Jul 2022 05:34:34 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KCCMs2007142;
        Wed, 20 Jul 2022 12:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=vhtEJn21eo8aYWBOVpeGrs5Xb93mVfeDzHtVpcJ/6A4=;
 b=s7dkmRUHx0RBy/CbFm0Vy8iyPbv6x8FGs6e/QQVTng3SyVouAvkElGqosK6tgIerTwFZ
 nkpLIbPTgwfFWiXYgWs5ccpP15nzfPrk9lnflSlHWYSQseyjqycSt+3zIeZt9Cc7d+Gi
 9NPZ+pPHV98Tr7od+LKPK7db3nXaB3rw5dJchN8YcpVxsmb8wbXeg4qI8IusJZ3Faivw
 fp4apyBwpIW2d+yCxTYQpyjkftfZdXgfldS4rfnNariQCsdWlThogZtZHZem6giPq6NY
 5H/kAH6LG+OPSBTpn/BvFAWVJBicGYY66500cDjkxqewBOdDpd+ZMUaIN0i46VZYB6u0 IQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hehggrnh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 12:34:32 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26KCL5qo019597;
        Wed, 20 Jul 2022 12:34:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3hbmy8m8hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 12:34:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26KCYQYX18481644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 12:34:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ACD0A405B;
        Wed, 20 Jul 2022 12:34:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39268A4054;
        Wed, 20 Jul 2022 12:34:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jul 2022 12:34:26 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/tests: Fix test case 83 on s390
Date:   Wed, 20 Jul 2022 14:34:19 +0200
Message-Id: <20220720123419.220953-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: avLJUI8fbXOMuwMSFkUrFMUIyqPNlBDX
X-Proofpoint-ORIG-GUID: avLJUI8fbXOMuwMSFkUrFMUIyqPNlBDX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_05,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf test case 83: perf stat CSV output linter might fail
on s390.
The reason for this is the output of the command

 ./perf stat -x, -A -a --no-merge true

which depends on a .config file setting. When CONFIG_SCHED_TOPOLOGY
is set, the output of above perf command is

   CPU0,1.50,msec,cpu-clock,1502781,100.00,1.052,CPUs utilized

When CONFIG_SCHED_TOPOLOGY is *NOT* set the output of above perf
command is

   0.95,msec,cpu-clock,949800,100.00,1.060,CPUs utilized

Fix the test case to accept both output formats.

Output before:
 # perf test 83
 83: perf stat CSV output linter       : FAILED!
 #

Output after:
 # ./perf test 83
 83: perf stat CSV output linter       : Ok
 #

Fixes: ec906102e5b7 ("perf test: Fix "perf stat CSV output linter" test on s390")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 tools/perf/tests/shell/stat+csv_output.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index 38c26f3ef4c1..eb5196f58190 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -8,7 +8,8 @@ set -e
 
 function commachecker()
 {
-	local -i cnt=0 exp=0
+	local -i cnt=0
+	local exp=0
 
 	case "$1"
 	in "--no-args")		exp=6
@@ -17,7 +18,7 @@ function commachecker()
 	;; "--interval")	exp=7
 	;; "--per-thread")	exp=7
 	;; "--system-wide-no-aggr")	exp=7
-				[ $(uname -m) = "s390x" ] && exp=6
+				[ $(uname -m) = "s390x" ] && exp='^[6-7]$'
 	;; "--per-core")	exp=8
 	;; "--per-socket")	exp=8
 	;; "--per-node")	exp=8
@@ -34,7 +35,7 @@ function commachecker()
 		x=$(echo $line | tr -d -c ',')
 		cnt="${#x}"
 		# echo $line $cnt
-		[ "$cnt" -ne "$exp" ] && {
+		[[ ! "$cnt" =~ $exp ]] && {
 			echo "wrong number of fields. expected $exp in $line" 1>&2
 			exit 1;
 		}
-- 
2.36.1

