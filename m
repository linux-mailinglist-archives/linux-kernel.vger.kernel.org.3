Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC1A5820D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiG0HMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiG0HMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:12:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52423DBEB;
        Wed, 27 Jul 2022 00:12:17 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R6lVbp025480;
        Wed, 27 Jul 2022 07:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jJT+gJ4f4CJHrMEHQIlyKWPRBz6eVbgfdj6JbgHJY6g=;
 b=bl5SfATS84EfewHgahXa/vujRig4WchqdXT7EYxeT0WGq0TX/ctzJP8U4MvQlcyLKO9G
 mcRWuGO6rUtUHnAgsa7tn+HhFm7sJjClQwhcipXfkspVO2yILV99yZwzq6QEFdZUdXMv
 QIFEYm5k9wTYoug1CyHCarSDsctmkVPj8W/8lWknJoICwEM4Vswk5+0KJH7KR1td1BeD
 iBX3V9vBPgI9kdK6UWCGzoq/JC9KH5mQiMj0YysFQoF8Yfb0Lae3whDscMgRMp3Wl8Hb
 sOEeZqcapMbkhdc7KDrDvIuDFXSkTXE3pfTQN9FXQR8HND76+BcqWzD848YlZydr7Kkw 8A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hk0dggmkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 07:12:12 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26R76M1A013901;
        Wed, 27 Jul 2022 07:12:10 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3hg94ebjdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 07:12:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26R7C7ie24904030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 07:12:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03B134203F;
        Wed, 27 Jul 2022 07:12:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F62242042;
        Wed, 27 Jul 2022 07:12:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jul 2022 07:12:06 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, german.gomez@arm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/tests: Fix test case 95 Check branch stack sampling on s390
Date:   Wed, 27 Jul 2022 09:11:59 +0200
Message-Id: <20220727071159.173360-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qCj-x0O97a5KzEyEU7wyY_SwIgRFWUe_
X-Proofpoint-ORIG-GUID: qCj-x0O97a5KzEyEU7wyY_SwIgRFWUe_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 priorityscore=1501 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On linux-next tree perf test 95 was added recently.
s390 does not support branch sampling at all. Therefore
omit this test on s390 platform.

Output before:
 # ./perf test -Fv 95
 95: Check branch stack sampling                                     :
 --- start ---
 Testing user branch stack sampling
 ---- end ----
 Check branch stack sampling: FAILED!
 #

Output after:
 # ./perf test -Fv 95
 95: Check branch stack sampling                                     :
 --- start ---
 ---- end ----
 Check branch stack sampling: Skip
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/test_brstack.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 113ccd17bf03..dedaf74164dc 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -4,6 +4,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # German Gomez <german.gomez@arm.com>, 2022
 
+# s390 does not support branch sampling, omit
+[ $(uname -m) = "s390" -o $(uname -m) = "s390x" ] && exit 2
+
 # we need a C compiler to build the test programs
 # so bail if none is found
 if ! [ -x "$(command -v cc)" ]; then
-- 
2.36.1

