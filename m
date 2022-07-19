Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFF357926C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiGSF0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiGSF0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:26:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A66613F60;
        Mon, 18 Jul 2022 22:26:39 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J5CxIF013821;
        Tue, 19 Jul 2022 05:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8H7WOwXqw+3wr9CerSM2hWVM0N01TwTjsRnLxOLOLV8=;
 b=j6ulJdd3t0qjZPqYD/Y+qmjFXKnQrbmjUouyEmFK4SzLpr64rB/6XpqroydpfvZ+jth7
 QRKcXsQI2G3PQG8yrYhBnfn73VjRzOOFC2gziP7cyigEHeVsipC2UXlx6RU+janPkdiF
 OPmPCTibiGZr3V492iug5vAQyPbOBkBMJqf3CBZPra5u3ahZK5tGMXqXQmEknRU5nXUv
 sW9GDKvrHOI8R/bjyR5JahweKLhET6yY8apSvC0pXOBhyTukasQzQ8VpVW1Ur52mp+ne
 cXzCCchbsgF2VeCou24bqcsRTNMpfk4ckuOJynczzhHoTfijZUDKYQyA8bPJn98bOo4W og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hdp93886m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 05:26:31 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26J5KpLJ004374;
        Tue, 19 Jul 2022 05:26:31 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hdp93886a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 05:26:31 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26J5KmiL024404;
        Tue, 19 Jul 2022 05:26:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3hbmy8uh82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 05:26:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26J5QQJn20906312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 05:26:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECB02A4060;
        Tue, 19 Jul 2022 05:26:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB9B5A4054;
        Tue, 19 Jul 2022 05:26:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Jul 2022 05:26:25 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 7F138E048E; Tue, 19 Jul 2022 07:16:36 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 2/4] s390/crash: move copy_to_user_real() to crash_dump.c
Date:   Tue, 19 Jul 2022 07:16:34 +0200
Message-Id: <e8de968d40202d87caa09aef12e9c67ec23a1c1a.1658206891.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658206891.git.agordeev@linux.ibm.com>
References: <cover.1658206891.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J7H0ETT66FQCGBIkZ6JRPzT_Hn2fINvZ
X-Proofpoint-GUID: pVKI15JBF9lXc3nlMSuVkdt8heUQeE-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=731 suspectscore=0
 clxscore=1015 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190019
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

