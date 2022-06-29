Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8A65604C3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiF2Phw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiF2Phv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:37:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7FA35DF1;
        Wed, 29 Jun 2022 08:37:50 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TFME8n018538;
        Wed, 29 Jun 2022 15:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=gCllJp/av1A6ZU7E969OL9N50tPZz7C4Q38xnV/jwn8=;
 b=MwWj9WcU5SbDBpfvMLlAniuKFJlKAv9D9zdfsCNM+YOt/CAHjChhsG6xP/ryTn9+gcQE
 JB0Ol2SY6lkn3V2qPxZ95oumbOa5c2xBO0FvvmPzUS6c0GWtpKl0qniT6z1wx/r2YMRS
 /XTJ9abOV4Zt44XSDOnBCfWFInuO3OD84jtvqVTyHk1vWtNnjElsr6cGmVe1SXohyHJe
 6f1Wxd48JhBdxqwUNZSRVVlP8Jva6TMi0rgGLYgh9IRPwY+hA8WdkMk3/2B+K+YbVPqH
 8LAd3dwa1+dbTw1T+y+U5BDqtaVco9Xft+7kgO84Y0kDKQkqa3DMd6Br6GP7OBEoISK0 Pg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0sarrmg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 15:37:48 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25TFaJct025865;
        Wed, 29 Jun 2022 15:37:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3gwt0951u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 15:37:46 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25TFbnF331064364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 15:37:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94EEB4C040;
        Wed, 29 Jun 2022 15:37:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3992C4C044;
        Wed, 29 Jun 2022 15:37:42 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Jun 2022 15:37:42 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     nrb@linux.ibm.com
Subject: [RFC PATCH] s390: Autoload uvdevice module based on CPU feature
Date:   Wed, 29 Jun 2022 17:37:41 +0200
Message-Id: <20220629153741.195789-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pJ64-rQTM0yw2XlnM4ICE4faMVNyowst
X-Proofpoint-GUID: pJ64-rQTM0yw2XlnM4ICE4faMVNyowst
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_17,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch the uvdevice will be automatically loaded when the
facility 158 is present. This is accomplished by using
``module_cpu_feature_match`` and adding HWCAP_UV
connected to to facility 158.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/elf.h  | 2 ++
 arch/s390/kernel/processor.c | 5 +++++
 drivers/s390/char/uvdevice.c | 5 ++---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 70a30ae258b7..3a5e89ce4fd0 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -115,6 +115,7 @@ enum {
 	HWCAP_NR_NNPA		= 20,
 	HWCAP_NR_PCI_MIO	= 21,
 	HWCAP_NR_SIE		= 22,
+	HWCAP_NR_UV		= 23,
 	HWCAP_NR_MAX
 };
 
@@ -142,6 +143,7 @@ enum {
 #define HWCAP_NNPA		BIT(HWCAP_NR_NNPA)
 #define HWCAP_PCI_MIO		BIT(HWCAP_NR_PCI_MIO)
 #define HWCAP_SIE		BIT(HWCAP_NR_SIE)
+#define HWCAP_UV		BIT(HWCAP_NR_UV)
 
 /*
  * These are used to set parameters in the core dumps.
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index aa0e0e7fc773..3ca528cb3819 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -141,6 +141,7 @@ static void show_cpu_summary(struct seq_file *m, void *v)
 		[HWCAP_NR_NNPA]		= "nnpa",
 		[HWCAP_NR_PCI_MIO]	= "pcimio",
 		[HWCAP_NR_SIE]		= "sie",
+		[HWCAP_NR_UV]		= "uv",
 	};
 	int i, cpu;
 
@@ -249,6 +250,10 @@ static int __init setup_hwcaps(void)
 	if (sclp.has_sief2)
 		elf_hwcap |= HWCAP_SIE;
 
+	/* IBM Secure Execution (Ultravisor) support */
+	if (test_facility(158)) {
+		elf_hwcap |= HWCAP_UV;
+
 	return 0;
 }
 arch_initcall(setup_hwcaps);
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index 66505d7166a6..fddbfc1e27a2 100644
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
+module_cpu_feature_match(UV, uvio_dev_init);
 module_exit(uvio_dev_exit);
 
 MODULE_AUTHOR("IBM Corporation");
-- 
2.35.3

