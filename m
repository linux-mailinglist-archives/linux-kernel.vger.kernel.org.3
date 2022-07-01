Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4545630E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiGAKCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiGAKCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:02:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B573916;
        Fri,  1 Jul 2022 03:02:20 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2619k8df030154;
        Fri, 1 Jul 2022 10:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=G2k7CkRhM4+bJHIwrEHXUCSfbTcAi9U5SGI1kEbWwv8=;
 b=iRIo6+tjWNPnCxEH4T9xFky+AR+20GdKytIn8RmporNrmjZdnLwC6kmr4Vjw+0SQBtCs
 sCSitwZQsaMEkrEuDdOswRkD659PReTnRMmvmnIMiIGTbJe7u2NqwjdNbiYMVlDWjMsB
 TU/ryzX+8g+bypahyAF30SRDUelJMZiU8kbxPS6IhjbvG6UZXfaIyrBBusPARstZqG0b
 cED72jCU9nsrHhTtOVihlI3SFOrLLQQCnQ4wYpWSO4I3oAvmB5IjZ81I+rUiH1Fl13Yo
 pAfTHjwD2HQ1EWRlJD7nU0I5Lvaqg6jmCo4X/eSTV2rMjvt/5ynpaKJhyBGe86VFQ5fV zg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1xk68cbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 10:02:18 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2619pPJN003780;
        Fri, 1 Jul 2022 10:02:16 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3gwsmj9j1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 10:02:16 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 261A2DoA21299496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Jul 2022 10:02:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36716AE051;
        Fri,  1 Jul 2022 10:02:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65036AE04D;
        Fri,  1 Jul 2022 10:02:12 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Jul 2022 10:02:12 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     nrb@linux.ibm.com
Subject: [PATCH 1/2] s390/hwcaps: Add HWCAP_UV
Date:   Fri,  1 Jul 2022 12:02:09 +0200
Message-Id: <20220701100210.5482-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220701100210.5482-1-seiden@linux.ibm.com>
References: <20220701100210.5482-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fmjAmGq8XuR83ncT_rG7F7RUoS35Nhoq
X-Proofpoint-GUID: fmjAmGq8XuR83ncT_rG7F7RUoS35Nhoq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=962 mlxscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a hardware capability for the Ultravisor.
This capability will be present if facility 158 is enabled.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/elf.h  | 2 ++
 arch/s390/kernel/processor.c | 5 +++++
 2 files changed, 7 insertions(+)

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
index aa0e0e7fc773..80ccd57a2b00 100644
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
 
+	/* ultravisor-call (secure execution) */
+	if (test_facility(158))
+		elf_hwcap |= HWCAP_UV;
+
 	return 0;
 }
 arch_initcall(setup_hwcaps);
-- 
2.35.3

