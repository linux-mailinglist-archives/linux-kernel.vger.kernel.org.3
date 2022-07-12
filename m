Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A857179E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiGLKwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiGLKwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:52:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BFEAE397;
        Tue, 12 Jul 2022 03:52:29 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CAhmfp013021;
        Tue, 12 Jul 2022 10:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=J2qnig8Gw6JMhiv1+zcuwBOemTwC4BF1Iyens8utySo=;
 b=VnJp5h9et4TVbW7kIhix1qquqVt5NIfT1HTYd1NRjTmuDucNWoAEEg1UQLB8tJQDcsrQ
 v8q1mHkqMaK0CAONolKoimJvVNvDYUJAxyS3zc4kNLPdPYalSyNbZUZC0AyfjDpguvn3
 FoYQwFNc35z76rLM+1u2bGJtyr51sCU3eyFD53J6cqCj5+xqHUrCWTk3N9xl8xfiVavn
 tppxClaFa24JIDtr7B2z9hFGZ324iAAVfwAa7QvA6Tuw5vuRVFQ+vt7ZmZC5kTD/HII5
 3eiNpmJkM5iel5fEWUoBXnD83DlaQvVep8uOqMDSm68Gtlx0/aqMlEH7Aq8LJIFl3wSI Kw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h96jysfsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 10:52:27 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CAqPe5003414;
        Tue, 12 Jul 2022 10:52:25 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3h70xhv2rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 10:52:25 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CAqMKZ25297306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 10:52:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D1C111C04A;
        Tue, 12 Jul 2022 10:52:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2445611C04C;
        Tue, 12 Jul 2022 10:52:22 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 10:52:22 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     nrb@linux.ibm.com
Subject: [PATCH 3/3] s390/uvdevice: autoload module based on CPU facility
Date:   Tue, 12 Jul 2022 12:52:20 +0200
Message-Id: <20220712105220.325010-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712105220.325010-1-seiden@linux.ibm.com>
References: <20220712105220.325010-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mdNDKtarlkAZ5t4gVuuQ1YCoMOv1elk9
X-Proofpoint-ORIG-GUID: mdNDKtarlkAZ5t4gVuuQ1YCoMOv1elk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_05,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207120039
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
---
 arch/s390/include/asm/cpufeature.h | 1 +
 arch/s390/kernel/cpufeature.c      | 1 +
 drivers/s390/char/uvdevice.c       | 5 ++---
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/cpufeature.h b/arch/s390/include/asm/cpufeature.h
index aa8081dad411..4b17f876ab54 100644
--- a/arch/s390/include/asm/cpufeature.h
+++ b/arch/s390/include/asm/cpufeature.h
@@ -33,6 +33,7 @@ enum {
 	S390_CPU_FEATURE_NNPA,
 	S390_CPU_FEATURE_PCI_MIO,
 	S390_CPU_FEATURE_SIE,
+	S390_CPU_FEATURE_UV,
 	MAX_CPU_FEATURES
 };
 
diff --git a/arch/s390/kernel/cpufeature.c b/arch/s390/kernel/cpufeature.c
index e70b29804db4..0b854d37edcb 100644
--- a/arch/s390/kernel/cpufeature.c
+++ b/arch/s390/kernel/cpufeature.c
@@ -42,6 +42,7 @@ static struct s390_cpu_feature s390_cpu_features[MAX_CPU_FEATURES] = {
 	[S390_CPU_FEATURE_NNPA]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_NNPA},
 	[S390_CPU_FEATURE_PCI_MIO]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_PCI_MIO},
 	[S390_CPU_FEATURE_SIE]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_SIE},
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

