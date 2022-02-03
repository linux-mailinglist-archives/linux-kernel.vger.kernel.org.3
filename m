Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B244A8B43
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353275AbiBCSMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:12:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232240AbiBCSL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:11:56 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213HXh1r003113;
        Thu, 3 Feb 2022 18:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HWB+U3RDOqKbXuykLxFCRkaOT1/jEZlEB+EBNvNUW88=;
 b=H3VWSaR21twmMz6USB0aemHO6qOYV5bsQ/Ye4i7jinpXvDMi89lBeLyUXE0fOgJlBDBU
 wudfquNF+4otm6ZaeBKPO2XZvZUttESFa/65pEFdX7hY6KO7bNHKPBLn4Aysa3sRL2TI
 gZur+a0yXdkhEJTwyKF5gg7EZZDtMzAo56KfbKs0+YJv2evu4wBqmwCN5zzKCDnjpTjA
 m0ql9oYgFlKho1cZTXiRq8zUV2tb6XK7HxT66Th1bpNSKoM2KoJ0fJMge8N9bp3m9iKR
 BI50xfz4zbI9tc1S/pyKdyVn7EWrTHSre7QKiqYGSI+XMeG5vcaMdJEhanILGoUYsBv9 8Q== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyvcmx4md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:11:49 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 213I2jLS002657;
        Thu, 3 Feb 2022 18:11:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3dvw7a6u5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:11:47 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 213I1oCb49283456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Feb 2022 18:01:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10D7252050;
        Thu,  3 Feb 2022 18:11:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BFCD15205F;
        Thu,  3 Feb 2022 18:11:43 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     scgl@linux.ibm.com
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        borntraeger@linux.ibm.com, hca@linux.ibm.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [RFC PATCH 2/2] s390/uaccess: Provide raw_copy_from/to_user_opaque
Date:   Thu,  3 Feb 2022 19:11:41 +0100
Message-Id: <20220203181141.2682997-3-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203181141.2682997-1-scgl@linux.ibm.com>
References: <20220126173358.2951879-1-scgl@linux.ibm.com>
 <20220203181141.2682997-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jQp_CpsAu1cDYiYSu5_7N7y_xf8TKo5F
X-Proofpoint-ORIG-GUID: jQp_CpsAu1cDYiYSu5_7N7y_xf8TKo5F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 mlxlogscore=939
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables KVM to perform key checked guest accesses by passing the
access key via the opaque argument of __copy_from/to_user_opaque.
Since the existing uaccess implementation on s390 makes use of move
instructions that support having an additional access key supplied,
we can implement raw_copy_from/to_user_opaque by enhancing the
existing implementation.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 arch/s390/include/asm/uaccess.h | 27 ++++++++++++++--
 arch/s390/lib/uaccess.c         | 56 ++++++++++++++++++++-------------
 2 files changed, 60 insertions(+), 23 deletions(-)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index 02b467461163..1a324bc3ae0b 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -33,11 +33,34 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
 
 #define access_ok(addr, size) __access_ok(addr, size)
 
+#define uaccess_opaque uaccess_opaque
+struct uaccess_opaque {
+	u8 key;
+};
+
 unsigned long __must_check
-raw_copy_from_user(void *to, const void __user *from, unsigned long n);
+raw_copy_from_user_opaque(void *to, const void __user *from, unsigned long n,
+			  struct uaccess_opaque opaque);
 
 unsigned long __must_check
-raw_copy_to_user(void __user *to, const void *from, unsigned long n);
+raw_copy_to_user_opaque(void __user *to, const void *from, unsigned long n,
+			struct uaccess_opaque opaque);
+
+static __always_inline unsigned long __must_check
+raw_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	struct uaccess_opaque opaque = { .key = 0};
+
+	return raw_copy_from_user_opaque(to, from, n, opaque);
+}
+
+static __always_inline unsigned long __must_check
+raw_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	struct uaccess_opaque opaque = { .key = 0};
+
+	return raw_copy_to_user_opaque(to, from, n, opaque);
+}
 
 #ifndef CONFIG_KASAN
 #define INLINE_COPY_FROM_USER
diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index d3a700385875..6446634c3b75 100644
--- a/arch/s390/lib/uaccess.c
+++ b/arch/s390/lib/uaccess.c
@@ -59,11 +59,13 @@ static inline int copy_with_mvcos(void)
 #endif
 
 static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr,
-						 unsigned long size)
+						 unsigned long size, u8 key)
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
+						unsigned long size, u8 key)
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
@@ -123,24 +125,31 @@ static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
 		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,6b)
 		EX_TABLE(7b,3b) EX_TABLE(8b,3b) EX_TABLE(9b,6b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
-		: : "cc", "memory");
+		: [key] "d" (key << 4)
+		: "cc", "memory");
 	return size;
 }
 
-unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n)
+unsigned long raw_copy_from_user_opaque(void *to, const void __user *from,
+					unsigned long n,
+					struct uaccess_opaque opaque)
 {
+	u8 key = opaque.key;
+
 	if (copy_with_mvcos())
-		return copy_from_user_mvcos(to, from, n);
-	return copy_from_user_mvcp(to, from, n);
+		return copy_from_user_mvcos(to, from, n, key);
+	return copy_from_user_mvcp(to, from, n, key);
 }
-EXPORT_SYMBOL(raw_copy_from_user);
+EXPORT_SYMBOL(raw_copy_from_user_opaque);
 
-static inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
-					       unsigned long size)
+inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
+					unsigned long size, u8 key)
 {
 	unsigned long tmp1, tmp2;
 	union oac spec = {
+		.oac1.key = key,
 		.oac1.as = PSW_BITS_AS_SECONDARY,
+		.oac1.k = 1,
 		.oac1.a = 1,
 	};
 
@@ -171,19 +180,19 @@ static inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
 }
 
 static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
-					      unsigned long size)
+					      unsigned long size, u8 key)
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
@@ -192,7 +201,7 @@ static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
 		"   slgr  %4,%1\n"
 		"   clgr  %0,%4\n"	/* copy crosses next page boundary? */
 		"   jnh   6f\n"
-		"4: mvcs  0(%4,%1),0(%2),%3\n"
+		"4: mvcs  0(%4,%1),0(%2),%[key]\n"
 		"9: slgr  %0,%4\n"
 		"   j     6f\n"
 		"5: slgr  %0,%0\n"
@@ -200,17 +209,22 @@ static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
 		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,6b)
 		EX_TABLE(7b,3b) EX_TABLE(8b,3b) EX_TABLE(9b,6b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
-		: : "cc", "memory");
+		: [key] "d" (key << 4)
+		: "cc", "memory");
 	return size;
 }
 
-unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n)
+unsigned long raw_copy_to_user_opaque(void __user *to, const void *from,
+				      unsigned long n,
+				      struct uaccess_opaque opaque)
 {
+	u8 key = opaque.key;
+
 	if (copy_with_mvcos())
-		return copy_to_user_mvcos(to, from, n);
-	return copy_to_user_mvcs(to, from, n);
+		return copy_to_user_mvcos(to, from, n, key);
+	return copy_to_user_mvcs(to, from, n, key);
 }
-EXPORT_SYMBOL(raw_copy_to_user);
+EXPORT_SYMBOL(raw_copy_to_user_opaque);
 
 static inline unsigned long clear_user_mvcos(void __user *to, unsigned long size)
 {
-- 
2.32.0

