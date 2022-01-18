Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A28492323
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiARJwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:52:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234265AbiARJw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:52:26 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20I8b8b3031631;
        Tue, 18 Jan 2022 09:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iLPfG/0ey//iHt3OUUFh9h4nxNifafMbGm4x1cO3F84=;
 b=LVTTiIYKSZTvawujEMc33aVoD/Nn7h/ifxcqjsfKM/qIR2rzZKe2VXTOWXif5SPfP8JJ
 E03pRcikgoMvakHusAWFX3hvPDwE73DUV4s5mu+7LDBa2jeqlb5vI+jRpaej2AszhN6J
 VNQqLID18MN3HcUen7TLZgWV/g3XtT7PBA510mqZ1e/nIOnxWAzgpkvEajWq0FQSF+B6
 i8K/8X9Yl5BXR6lAbLfdAWW/ZK0quDTt0wDZ+NFhfdjXEfEVOMMF2cgpKDu8pFJPjxxU
 cLVW8VS5TZvHFrnJdhOCu2YBOgD+t8khysjoe6egTxaiRkrCFC2LbVIaxFekpJNwoBQy iw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dnq02e6ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 09:52:25 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20I9lESY028621;
        Tue, 18 Jan 2022 09:52:23 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3dnm6r2hnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 09:52:23 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20I9qHMm38797640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 09:52:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A54F1A4051;
        Tue, 18 Jan 2022 09:52:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59778A4057;
        Tue, 18 Jan 2022 09:52:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jan 2022 09:52:17 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 01/10] s390/uaccess: Add storage key checked access to user memory
Date:   Tue, 18 Jan 2022 10:52:01 +0100
Message-Id: <20220118095210.1651483-2-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220118095210.1651483-1-scgl@linux.ibm.com>
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kZilrPbufwDMeJE1GP6RQyuRpsn-JDwo
X-Proofpoint-GUID: kZilrPbufwDMeJE1GP6RQyuRpsn-JDwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_02,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201180057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM needs a mechanism to do accesses to guest memory that honor
storage key protection.
Since the copy_to/from_user implementation makes use of move
instructions that support having an additional access key supplied,
we can implement __copy_from/to_user_with_key by enhancing the
existing implementation.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 arch/s390/include/asm/uaccess.h | 32 ++++++++++++++++++
 arch/s390/lib/uaccess.c         | 57 +++++++++++++++++++++++----------
 2 files changed, 72 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index 02b467461163..5138040348cc 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -33,6 +33,38 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
 
 #define access_ok(addr, size) __access_ok(addr, size)
 
+unsigned long __must_check
+raw_copy_from_user_with_key(void *to, const void __user *from, unsigned long n,
+			    char key);
+
+unsigned long __must_check
+raw_copy_to_user_with_key(void __user *to, const void *from, unsigned long n,
+			  char key);
+
+static __always_inline __must_check unsigned long
+__copy_from_user_with_key(void *to, const void __user *from, unsigned long n,
+			  char key)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	instrument_copy_from_user(to, from, n);
+	check_object_size(to, n, false);
+	return raw_copy_from_user_with_key(to, from, n, key);
+}
+
+static __always_inline __must_check unsigned long
+__copy_to_user_with_key(void __user *to, const void *from, unsigned long n,
+			char key)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	instrument_copy_to_user(to, from, n);
+	check_object_size(from, n, true);
+	return raw_copy_to_user_with_key(to, from, n, key);
+}
+
 unsigned long __must_check
 raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 
diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index d3a700385875..ce7a150dd93a 100644
--- a/arch/s390/lib/uaccess.c
+++ b/arch/s390/lib/uaccess.c
@@ -59,11 +59,13 @@ static inline int copy_with_mvcos(void)
 #endif
 
 static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr,
-						 unsigned long size)
+						 unsigned long size, char key)
 {
 	unsigned long tmp1, tmp2;
 	union oac spec = {
+		.oac2.key = key,
 		.oac2.as = PSW_BITS_AS_SECONDARY,
+		.oac2.k = 1,
 		.oac2.a = 1,
 	};
 
@@ -94,19 +96,19 @@ static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr
 }
 
 static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
-						unsigned long size)
+						unsigned long size, char key)
 {
 	unsigned long tmp1, tmp2;
 
 	tmp1 = -256UL;
 	asm volatile(
 		"   sacf  0\n"
-		"0: mvcp  0(%0,%2),0(%1),%3\n"
+		"0: mvcp  0(%0,%2),0(%1),%[key]\n"
 		"7: jz    5f\n"
 		"1: algr  %0,%3\n"
 		"   la    %1,256(%1)\n"
 		"   la    %2,256(%2)\n"
-		"2: mvcp  0(%0,%2),0(%1),%3\n"
+		"2: mvcp  0(%0,%2),0(%1),%[key]\n"
 		"8: jnz   1b\n"
 		"   j     5f\n"
 		"3: la    %4,255(%1)\n"	/* %4 = ptr + 255 */
@@ -115,7 +117,7 @@ static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
 		"   slgr  %4,%1\n"
 		"   clgr  %0,%4\n"	/* copy crosses next page boundary? */
 		"   jnh   6f\n"
-		"4: mvcp  0(%4,%2),0(%1),%3\n"
+		"4: mvcp  0(%4,%2),0(%1),%[key]\n"
 		"9: slgr  %0,%4\n"
 		"   j     6f\n"
 		"5: slgr  %0,%0\n"
@@ -123,24 +125,36 @@ static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
 		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,6b)
 		EX_TABLE(7b,3b) EX_TABLE(8b,3b) EX_TABLE(9b,6b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
-		: : "cc", "memory");
+		: [key] "d" (key << 4)
+		: "cc", "memory");
 	return size;
 }
 
 unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	if (copy_with_mvcos())
-		return copy_from_user_mvcos(to, from, n);
-	return copy_from_user_mvcp(to, from, n);
+		return copy_from_user_mvcos(to, from, n, 0);
+	return copy_from_user_mvcp(to, from, n, 0);
 }
 EXPORT_SYMBOL(raw_copy_from_user);
 
-static inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
-					       unsigned long size)
+unsigned long raw_copy_from_user_with_key(void *to, const void __user *from,
+					  unsigned long n, char key)
+{
+	if (copy_with_mvcos())
+		return copy_from_user_mvcos(to, from, n, key);
+	return copy_from_user_mvcp(to, from, n, key);
+}
+EXPORT_SYMBOL(raw_copy_from_user_with_key);
+
+inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
+					unsigned long size, char key)
 {
 	unsigned long tmp1, tmp2;
 	union oac spec = {
+		.oac1.key = key,
 		.oac1.as = PSW_BITS_AS_SECONDARY,
+		.oac1.k = 1,
 		.oac1.a = 1,
 	};
 
@@ -171,19 +185,19 @@ static inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
 }
 
 static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
-					      unsigned long size)
+					      unsigned long size, char key)
 {
 	unsigned long tmp1, tmp2;
 
 	tmp1 = -256UL;
 	asm volatile(
 		"   sacf  0\n"
-		"0: mvcs  0(%0,%1),0(%2),%3\n"
+		"0: mvcs  0(%0,%1),0(%2),%[key]\n"
 		"7: jz    5f\n"
 		"1: algr  %0,%3\n"
 		"   la    %1,256(%1)\n"
 		"   la    %2,256(%2)\n"
-		"2: mvcs  0(%0,%1),0(%2),%3\n"
+		"2: mvcs  0(%0,%1),0(%2),%[key]\n"
 		"8: jnz   1b\n"
 		"   j     5f\n"
 		"3: la    %4,255(%1)\n" /* %4 = ptr + 255 */
@@ -192,7 +206,7 @@ static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
 		"   slgr  %4,%1\n"
 		"   clgr  %0,%4\n"	/* copy crosses next page boundary? */
 		"   jnh   6f\n"
-		"4: mvcs  0(%4,%1),0(%2),%3\n"
+		"4: mvcs  0(%4,%1),0(%2),%[key]\n"
 		"9: slgr  %0,%4\n"
 		"   j     6f\n"
 		"5: slgr  %0,%0\n"
@@ -200,17 +214,26 @@ static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
 		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,6b)
 		EX_TABLE(7b,3b) EX_TABLE(8b,3b) EX_TABLE(9b,6b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
-		: : "cc", "memory");
+		: [key] "d" (key << 4)
+		: "cc", "memory");
 	return size;
 }
 
 unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	if (copy_with_mvcos())
-		return copy_to_user_mvcos(to, from, n);
-	return copy_to_user_mvcs(to, from, n);
+		return copy_to_user_mvcos(to, from, n, 0);
+	return copy_to_user_mvcs(to, from, n, 0);
 }
 EXPORT_SYMBOL(raw_copy_to_user);
+unsigned long raw_copy_to_user_with_key(void __user *to, const void *from,
+					unsigned long n, char key)
+{
+	if (copy_with_mvcos())
+		return copy_to_user_mvcos(to, from, n, key);
+	return copy_to_user_mvcs(to, from, n, key);
+}
+EXPORT_SYMBOL(raw_copy_to_user_with_key);
 
 static inline unsigned long clear_user_mvcos(void __user *to, unsigned long size)
 {
-- 
2.32.0

