Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A8E5736BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbiGMM5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiGMM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:56:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD6A7436F;
        Wed, 13 Jul 2022 05:56:53 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DCR2xR016034;
        Wed, 13 Jul 2022 12:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HcTnAKVtvZ+4Z50bhM2SkI8yE39Mlq0zg6GRn5DhjJI=;
 b=bse9GI4zmc3EaKW0+iTiPCKlfhDBRkhcZrzuBpQlEL+FQpuzArZmW+8+dbRDKiS7XnOw
 g8+mdaY4mjJRZiNNkoOLnM1G5SXrSZm1MESby4ENBsgxi7Io1GxdaxXfGkr/4uoUhCd8
 vWhL2k9ekIMSeuOk1MlizOs+hG8TjCMdpzhcLBKZ5IhvIRKY/Eq57ahmoXPMHA+Y0Og2
 i1NGvbTmNwjT3tUVU62CXeJgAy+xDyz85Bk0egpuGSZlMfGh9GqbRD4u7raYYoNHTF5Q
 nwZWj+YAnKdShroayYvWszPjUHeQIYstyWvZ5w3d2Bui+aVvyKjFi78n2++m74UEKLi6 uQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9x2n0upx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 12:56:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26DCo5q2010324;
        Wed, 13 Jul 2022 12:56:49 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3h8rrn2kpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 12:56:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26DCuuKN23724346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 12:56:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE412A4054;
        Wed, 13 Jul 2022 12:56:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B7CEA405C;
        Wed, 13 Jul 2022 12:56:45 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jul 2022 12:56:45 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     nrb@linux.ibm.com
Subject: [PATCH v2 3/3] s390/uvdevice: autoload module based on CPU facility
Date:   Wed, 13 Jul 2022 14:56:44 +0200
Message-Id: <20220713125644.16121-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220713125644.16121-1-seiden@linux.ibm.com>
References: <20220713125644.16121-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _4uEH6_S2yyggBRIYf2E7KPkjyDpuvhO
X-Proofpoint-ORIG-GUID: _4uEH6_S2yyggBRIYf2E7KPkjyDpuvhO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_01,2022-07-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the uvdevice driver will be automatically loaded when
facility 158 is available.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/include/asm/cpufeature.h | 1 +
 arch/s390/kernel/cpufeature.c      | 1 +
 drivers/s390/char/uvdevice.c       | 5 ++---
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/cpufeature.h b/arch/s390/include/asm/cpufeature.h
index 771caf5281e5..931204613753 100644
--- a/arch/s390/include/asm/cpufeature.h
+++ b/arch/s390/include/asm/cpufeature.h
@@ -12,6 +12,7 @@
 enum {
 	S390_CPU_FEATURE_MSA,
 	S390_CPU_FEATURE_VXRS,
+	S390_CPU_FEATURE_UV,
 	MAX_CPU_FEATURES
 };
 
diff --git a/arch/s390/kernel/cpufeature.c b/arch/s390/kernel/cpufeature.c
index 170894730fcc..5c69be58a057 100644
--- a/arch/s390/kernel/cpufeature.c
+++ b/arch/s390/kernel/cpufeature.c
@@ -19,6 +19,7 @@ struct s390_cpu_feature {
 static struct s390_cpu_feature s390_cpu_features[MAX_CPU_FEATURES] = {
 	[S390_CPU_FEATURE_MSA]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_MSA},
 	[S390_CPU_FEATURE_VXRS]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_VXRS},
+	[S390_CPU_FEATURE_UV]		= {.type = TYPE_FACILITY, .num = 158},
 };
 
 /*
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index 66505d7166a6..1d40457c7b10 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -27,6 +27,7 @@
 #include <linux/stddef.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <linux/cpufeature.h>
 
 #include <asm/uvdevice.h>
 #include <asm/uv.h>
@@ -244,12 +245,10 @@ static void __exit uvio_dev_exit(void)
 
 static int __init uvio_dev_init(void)
 {
-	if (!test_facility(158))
-		return -ENXIO;
 	return misc_register(&uvio_dev_miscdev);
 }
 
-module_init(uvio_dev_init);
+module_cpu_feature_match(S390_CPU_FEATURE_UV, uvio_dev_init);
 module_exit(uvio_dev_exit);
 
 MODULE_AUTHOR("IBM Corporation");
-- 
2.35.3

