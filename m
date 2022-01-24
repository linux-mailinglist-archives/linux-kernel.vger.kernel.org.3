Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9033497D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiAXKig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:38:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233316AbiAXKi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:38:27 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20OA5fKw012984;
        Mon, 24 Jan 2022 10:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IrIKd3mc18KlLQgzELWZMji0Eu1rtnHgu27OQ8PuOEY=;
 b=nzwiLoFPqwHDq5G/PMiolW7NCiBu4eo1yjGMW34wIBvadctNFLtieaXRcDNBg8mhB1l6
 TX68SfHE/PQF1UzRIa0hhGdWexkO8DHuo3B9vbfO7AmGu0nwxbNeqkTaZNrzhmHnN1HG
 YhTbnJW1gWSasP6bpAl+vWjAhhgIq5TXIsp3TJlx6V7lFHOf8QxVrFC2grU/7We+yvZe
 SeCuFXTwoZNjQo5Y2531cNZ4v94K1Q12hvzcNHWNqt07UkDx/gclD1zWI7cmrUjn8LMH
 xi1l8tIJwVDOHHgeilN4LVloab4hp1EP7w8Tvv7A7XdGFB/yO5Q7dQLZnjNY6PA5/RCU 2g== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dsch64dvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 10:38:26 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20OAb9TG002685;
        Mon, 24 Jan 2022 10:38:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3dr96j2hkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 10:38:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20OAcISk39715170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 10:38:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADF804C059;
        Mon, 24 Jan 2022 10:38:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E2024C075;
        Mon, 24 Jan 2022 10:38:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Jan 2022 10:38:18 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] uaccess: Add mechanism for key checked access to user memory
Date:   Mon, 24 Jan 2022 11:38:12 +0100
Message-Id: <20220124103812.2340666-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YerCfDceDszqbdHU@osiris>
References: <YerCfDceDszqbdHU@osiris>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s8zWW6cHG1guuX7D7REfUN8n00xElKxm
X-Proofpoint-GUID: s8zWW6cHG1guuX7D7REfUN8n00xElKxm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_06,2022-01-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM on s390 needs a mechanism to do accesses to guest memory
that honors storage key protection.
__copy_from/to_user_with_key is implemented by introducing
raw_copy_from/to_user_with_key.
Since the existing uaccess implementation on s390 makes use of move
instructions that support having an additional access key supplied,
we can implement raw_copy_from/to_user_with_key by enhancing the
existing implementation.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---

This works for us and compiles on other architectures (tested x86).
The patch only implements __copy_from/to_user_with_key, since those
are the ones we actually need. On other architectures those functions
don't exists, but they aren't used either, so it's not a problem.

Should we also implement single and no underscore variants? Why?
Completeness?

 arch/s390/include/asm/uaccess.h | 20 +++++++++++--
 arch/s390/lib/uaccess.c         | 50 +++++++++++++++++++--------------
 include/linux/uaccess.h         | 28 ++++++++++++++++++
 3 files changed, 75 insertions(+), 23 deletions(-)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index 02b467461163..fc8477b5e98c 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -33,11 +33,27 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
 
 #define access_ok(addr, size) __access_ok(addr, size)
 
+#define raw_copy_from_user_with_key raw_copy_from_user_with_key
 unsigned long __must_check
-raw_copy_from_user(void *to, const void __user *from, unsigned long n);
+raw_copy_from_user_with_key(void *to, const void __user *from, unsigned long n,
+			    unsigned long key);
 
+#define raw_copy_to_user_with_key raw_copy_to_user_with_key
 unsigned long __must_check
-raw_copy_to_user(void __user *to, const void *from, unsigned long n);
+raw_copy_to_user_with_key(void __user *to, const void *from, unsigned long n,
+			  unsigned long key);
+
+static __always_inline unsigned long __must_check
+raw_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	return raw_copy_from_user_with_key(to, from, n, 0);
+}
+
+static __always_inline unsigned long __must_check
+raw_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	return raw_copy_to_user_with_key(to, from, n, 0);
+}
 
 #ifndef CONFIG_KASAN
 #define INLINE_COPY_FROM_USER
diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index d3a700385875..63845dd82691 100644
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
@@ -123,24 +125,28 @@ static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
 		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,6b)
 		EX_TABLE(7b,3b) EX_TABLE(8b,3b) EX_TABLE(9b,6b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
-		: : "cc", "memory");
+		: [key] "d" (key << 4)
+		: "cc", "memory");
 	return size;
 }
 
-unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n)
+unsigned long raw_copy_from_user_with_key(void *to, const void __user *from,
+					  unsigned long n, unsigned long key)
 {
 	if (copy_with_mvcos())
-		return copy_from_user_mvcos(to, from, n);
-	return copy_from_user_mvcp(to, from, n);
+		return copy_from_user_mvcos(to, from, n, (u8)key);
+	return copy_from_user_mvcp(to, from, n, (u8)key);
 }
-EXPORT_SYMBOL(raw_copy_from_user);
+EXPORT_SYMBOL(raw_copy_from_user_with_key);
 
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
 
@@ -171,19 +177,19 @@ static inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
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
@@ -192,7 +198,7 @@ static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
 		"   slgr  %4,%1\n"
 		"   clgr  %0,%4\n"	/* copy crosses next page boundary? */
 		"   jnh   6f\n"
-		"4: mvcs  0(%4,%1),0(%2),%3\n"
+		"4: mvcs  0(%4,%1),0(%2),%[key]\n"
 		"9: slgr  %0,%4\n"
 		"   j     6f\n"
 		"5: slgr  %0,%0\n"
@@ -200,17 +206,19 @@ static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
 		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,6b)
 		EX_TABLE(7b,3b) EX_TABLE(8b,3b) EX_TABLE(9b,6b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
-		: : "cc", "memory");
+		: [key] "d" (key << 4)
+		: "cc", "memory");
 	return size;
 }
 
-unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n)
+unsigned long raw_copy_to_user_with_key(void __user *to, const void *from,
+					unsigned long n, unsigned long key)
 {
 	if (copy_with_mvcos())
-		return copy_to_user_mvcos(to, from, n);
-	return copy_to_user_mvcs(to, from, n);
+		return copy_to_user_mvcos(to, from, n, (u8)key);
+	return copy_to_user_mvcs(to, from, n, (u8)key);
 }
-EXPORT_SYMBOL(raw_copy_to_user);
+EXPORT_SYMBOL(raw_copy_to_user_with_key);
 
 static inline unsigned long clear_user_mvcos(void __user *to, unsigned long size)
 {
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac0394087f7d..adce966edb7a 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -114,6 +114,20 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
 	return raw_copy_from_user(to, from, n);
 }
 
+#ifdef raw_copy_from_user_with_key
+static __always_inline __must_check unsigned long
+__copy_from_user_with_key(void *to, const void __user *from, unsigned long n,
+			  unsigned long key)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	instrument_copy_from_user(to, from, n);
+	check_object_size(to, n, false);
+	return raw_copy_from_user_with_key(to, from, n, key);
+}
+#endif /* raw_copy_from_user_with_key */
+
 /**
  * __copy_to_user_inatomic: - Copy a block of data into user space, with less checking.
  * @to:   Destination address, in user space.
@@ -148,6 +162,20 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
 	return raw_copy_to_user(to, from, n);
 }
 
+#ifdef raw_copy_to_user_with_key
+static __always_inline __must_check unsigned long
+__copy_to_user_with_key(void __user *to, const void *from, unsigned long n,
+			unsigned long key)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	instrument_copy_to_user(to, from, n);
+	check_object_size(from, n, true);
+	return raw_copy_to_user_with_key(to, from, n, key);
+}
+#endif /* raw_copy_to_user_with_key */
+
 #ifdef INLINE_COPY_FROM_USER
 static inline __must_check unsigned long
 _copy_from_user(void *to, const void __user *from, unsigned long n)

base-commit: bad13799e0305deb258372b7298a86be4c78aaba
prerequisite-patch-id: 5f8ae41bde2fa5717a775e17c08239ed1ddbcc83
-- 
2.32.0

