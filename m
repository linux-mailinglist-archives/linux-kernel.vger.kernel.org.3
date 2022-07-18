Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4CE5783F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiGRNmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiGRNl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:41:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474601DA42;
        Mon, 18 Jul 2022 06:41:57 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IDblG7003341;
        Mon, 18 Jul 2022 13:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8H7WOwXqw+3wr9CerSM2hWVM0N01TwTjsRnLxOLOLV8=;
 b=D7rAJh3DRL9rhEbOLrKQgqp1jKGZSvtFuG97P0igZmA2zgGJBsG5dedA9ZCNz5FFpZvj
 AiPgVezEz1g143J3l3SJExi4xFGSzyQexlQcD7IkZv9B7/51DBtp+DY8FiRF7nYtO28u
 3PkAm7Ogye2mclFU2raLTgv1SnjQT9pWJn3m/Hs6wzniZSuF+av8dPin4kze0gNqCx4Q
 D7sLf+RD0G5o9gkvkEO7/NUj3ujs8e1pCoekjUkOEGoe0A8XLDeDuvUqz6yInrawwifD
 WgiYDjqZPhgvwvu3JsS5C2DfedPQIFuY1oxsWsidRYN2+Vi1dSqWeSe3tjC5Sj946nS/ Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hd8cnre3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 13:41:49 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26IDcDmX007785;
        Mon, 18 Jul 2022 13:41:39 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hd8cnrdg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 13:41:38 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26IDLCxX018737;
        Mon, 18 Jul 2022 13:41:26 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3hbmy8t1fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 13:41:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26IDfZZL31326584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:41:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B5E44C04A;
        Mon, 18 Jul 2022 13:41:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 892F34C046;
        Mon, 18 Jul 2022 13:41:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jul 2022 13:41:23 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 6F8FBE020A; Mon, 18 Jul 2022 15:32:41 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 1/3] s390/crash: move copy_to_user_real() to crash_dump.c
Date:   Mon, 18 Jul 2022 15:32:39 +0200
Message-Id: <274a7b18b253574d0aa9ef09d3a9a8e5330c0a83.1658148067.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658148067.git.agordeev@linux.ibm.com>
References: <cover.1658148067.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vg82ghc6JwCVmzxg05GZpo39pQjQ8NJo
X-Proofpoint-ORIG-GUID: C0nyLCSRPFDh8MYzYF2FFXK9auMoGslm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_12,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=704 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207180058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function copy_to_user_real() does not really belong to maccess.c.
It is only used for copying oldmem to user space, so let's move
it to the friends.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/include/asm/uaccess.h |  1 -
 arch/s390/kernel/crash_dump.c   | 26 ++++++++++++++++++++++++++
 arch/s390/mm/maccess.c          | 26 --------------------------
 3 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index f4511e21d646..2a067315fe59 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -285,7 +285,6 @@ static inline unsigned long __must_check clear_user(void __user *to, unsigned lo
 	return __clear_user(to, n);
 }
 
-int copy_to_user_real(void __user *dest, unsigned long src, unsigned long count);
 void *s390_kernel_write(void *dst, const void *src, size_t size);
 
 int __noreturn __put_kernel_bad(void);
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 0efee5c49b1e..8d7332d4444c 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -173,6 +173,32 @@ int copy_oldmem_kernel(void *dst, unsigned long src, size_t count)
 	return 0;
 }
 
+/*
+ * Copy memory from kernel (real) to user (virtual)
+ */
+static int copy_to_user_real(void __user *dest, unsigned long src, unsigned long count)
+{
+	int offs = 0, size, rc;
+	char *buf;
+
+	buf = (char *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	rc = -EFAULT;
+	while (offs < count) {
+		size = min(PAGE_SIZE, count - offs);
+		if (memcpy_real(buf, src + offs, size))
+			goto out;
+		if (copy_to_user(dest + offs, buf, size))
+			goto out;
+		offs += size;
+	}
+	rc = 0;
+out:
+	free_page((unsigned long)buf);
+	return rc;
+}
+
 /*
  * Copy memory of the old, dumped system to a user space virtual address
  */
diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
index 421efa46946b..d6d84e02f35a 100644
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -171,32 +171,6 @@ void memcpy_absolute(void *dest, void *src, size_t count)
 	arch_local_irq_restore(flags);
 }
 
-/*
- * Copy memory from kernel (real) to user (virtual)
- */
-int copy_to_user_real(void __user *dest, unsigned long src, unsigned long count)
-{
-	int offs = 0, size, rc;
-	char *buf;
-
-	buf = (char *) __get_free_page(GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-	rc = -EFAULT;
-	while (offs < count) {
-		size = min(PAGE_SIZE, count - offs);
-		if (memcpy_real(buf, src + offs, size))
-			goto out;
-		if (copy_to_user(dest + offs, buf, size))
-			goto out;
-		offs += size;
-	}
-	rc = 0;
-out:
-	free_page((unsigned long) buf);
-	return rc;
-}
-
 /*
  * Check if physical address is within prefix or zero page
  */
-- 
2.34.1

