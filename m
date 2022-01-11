Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D0B48AAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348238AbiAKKAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:00:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3778 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237046AbiAKKAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:00:22 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B7aPlQ015796;
        Tue, 11 Jan 2022 10:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=c9SdVrdxP+DbC5FpmnE055EG7CVEZXz93kVVeEWEeOA=;
 b=k1nmfwjQ+2STyo4uccbDONZZFNvAr+QKDJpsf7caH6dQYalib+Up7Up7h+ZZL76nfNV5
 zxvHPAJ7jeCH5I1T0UC/dqp3LJJRC7UooncVvNECdgZL0SwdAdvbSgqNNMr3VLCcjwjH
 w0PMqHuKhyQpYtj1kZ6rfu5RsiXI4n3fkPABhlQilPxn1gwmOSl5v63fTpB7OKiIFMiu
 LoC0WZA7GhCXm/Ji/GTT2Mk+1r6qQ02ejcelKM2VIdqHdlTLS/LALEOmFFwV0PekdKDE
 0waqiCu0UFzuKLNAiA5X9xkEpbA2uvh7Gk/v+Kpw7oaowgsfd+/hGYpt14qzq62afahz qg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfm8k8mjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 10:00:21 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20B9wXlu011653;
        Tue, 11 Jan 2022 10:00:19 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3df1vjbyby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 10:00:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20BA0Gjl43712852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 10:00:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1195242052;
        Tue, 11 Jan 2022 10:00:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADA3E4204D;
        Tue, 11 Jan 2022 10:00:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jan 2022 10:00:15 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Subject: [PATCH] s390/uaccess: introduce bit field for OAC specifier
Date:   Tue, 11 Jan 2022 11:00:03 +0100
Message-Id: <20220111100003.743116-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aq3xNdY2ndN_A8V4m9s1v4p1Mv94bX9p
X-Proofpoint-GUID: aq3xNdY2ndN_A8V4m9s1v4p1Mv94bX9p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_03,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nico Boehr <nrb@linux.ibm.com>

Previously, we've used  magic values to specify the OAC
(operand-access control) for mvcos.

Instead we introduce a bit field for it.

When using a bit field, we cannot use an immediate value with K
constraint anymore, since GCC older than 10 doesn't recognize
the bit field union as a compile time constant.
To make things work with older compilers,
load the OAC value through a register.

Bloat-o-meter reports a slight increase in kernel size with this change:
Total: Before=15692135, After=15693015, chg +0.01%

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
Co-developed-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 arch/s390/include/asm/uaccess.h | 120 ++++++++++++++++++++------------
 arch/s390/lib/uaccess.c         |  24 +++++--
 2 files changed, 95 insertions(+), 49 deletions(-)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index ce550d06abc3..02b467461163 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -49,51 +49,85 @@ int __get_user_bad(void) __attribute__((noreturn));
 
 #ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
 
+union oac {
+	unsigned int val;
+	struct {
+		struct {
+			unsigned short key : 4;
+			unsigned short     : 4;
+			unsigned short as  : 2;
+			unsigned short     : 4;
+			unsigned short k   : 1;
+			unsigned short a   : 1;
+		} oac1;
+		struct {
+			unsigned short key : 4;
+			unsigned short     : 4;
+			unsigned short as  : 2;
+			unsigned short     : 4;
+			unsigned short k   : 1;
+			unsigned short a   : 1;
+		} oac2;
+	};
+};
+
-#define __put_get_user_asm(to, from, size, insn)		\
-({								\
-	int __rc;						\
-								\
-	asm volatile(						\
-		insn "		0,%[spec]\n"			\
-		"0:	mvcos	%[_to],%[_from],%[_size]\n"	\
-		"1:	xr	%[rc],%[rc]\n"			\
-		"2:\n"						\
-		".pushsection .fixup, \"ax\"\n"			\
-		"3:	lhi	%[rc],%[retval]\n"		\
-		"	jg	2b\n"				\
-		".popsection\n"					\
-		EX_TABLE(0b,3b) EX_TABLE(1b,3b)			\
-		: [rc] "=&d" (__rc), [_to] "+Q" (*(to))		\
-		: [_size] "d" (size), [_from] "Q" (*(from)),	\
-		  [retval] "K" (-EFAULT), [spec] "K" (0x81UL)	\
-		: "cc", "0");					\
-	__rc;							\
+#define __put_get_user_asm(to, from, size, oac_spec)			\
+({									\
+	int __rc;							\
+									\
+	asm volatile(							\
+		"lr	0,%[spec]\n"					\
+		"0:	mvcos	%[_to],%[_from],%[_size]\n"		\
+		"1:	xr	%[rc],%[rc]\n"				\
+		"2:\n"							\
+		".pushsection .fixup, \"ax\"\n"				\
+		"3:	lhi	%[rc],%[retval]\n"			\
+		"	jg	2b\n"					\
+		".popsection\n"						\
+		EX_TABLE(0b,3b) EX_TABLE(1b,3b)				\
+		: [rc] "=&d" (__rc), [_to] "+Q" (*(to))			\
+		: [_size] "d" (size), [_from] "Q" (*(from)),		\
+		  [retval] "K" (-EFAULT), [spec] "d" (oac_spec.val)	\
+		: "cc", "0");						\
+	__rc;								\
 })
 
+#define __put_user_asm(to, from, size)				\
+	__put_get_user_asm(to, from, size, ((union oac) {	\
+		.oac1.as = PSW_BITS_AS_SECONDARY,		\
+		.oac1.a = 1					\
+	}))
+
+#define __get_user_asm(to, from, size)				\
+	__put_get_user_asm(to, from, size, ((union oac) {	\
+		.oac2.as = PSW_BITS_AS_SECONDARY,		\
+		.oac2.a = 1					\
+	}))							\
+
 static __always_inline int __put_user_fn(void *x, void __user *ptr, unsigned long size)
 {
 	int rc;
 
 	switch (size) {
 	case 1:
-		rc = __put_get_user_asm((unsigned char __user *)ptr,
-					(unsigned char *)x,
-					size, "llilh");
+		rc = __put_user_asm((unsigned char __user *)ptr,
+				    (unsigned char *)x,
+				    size);
 		break;
 	case 2:
-		rc = __put_get_user_asm((unsigned short __user *)ptr,
-					(unsigned short *)x,
-					size, "llilh");
+		rc = __put_user_asm((unsigned short __user *)ptr,
+				    (unsigned short *)x,
+				    size);
 		break;
 	case 4:
-		rc = __put_get_user_asm((unsigned int __user *)ptr,
-					(unsigned int *)x,
-					size, "llilh");
+		rc = __put_user_asm((unsigned int __user *)ptr,
+				    (unsigned int *)x,
+				    size);
 		break;
 	case 8:
-		rc = __put_get_user_asm((unsigned long __user *)ptr,
-					(unsigned long *)x,
-					size, "llilh");
+		rc = __put_user_asm((unsigned long __user *)ptr,
+				    (unsigned long *)x,
+				    size);
 		break;
 	default:
 		__put_user_bad();
@@ -108,24 +142,24 @@ static __always_inline int __get_user_fn(void *x, const void __user *ptr, unsign
 
 	switch (size) {
 	case 1:
-		rc = __put_get_user_asm((unsigned char *)x,
-					(unsigned char __user *)ptr,
-					size, "lghi");
+		rc = __get_user_asm((unsigned char *)x,
+				    (unsigned char __user *)ptr,
+				    size);
 		break;
 	case 2:
-		rc = __put_get_user_asm((unsigned short *)x,
-					(unsigned short __user *)ptr,
-					size, "lghi");
+		rc = __get_user_asm((unsigned short *)x,
+				    (unsigned short __user *)ptr,
+				    size);
 		break;
 	case 4:
-		rc = __put_get_user_asm((unsigned int *)x,
-					(unsigned int __user *)ptr,
-					size, "lghi");
+		rc = __get_user_asm((unsigned int *)x,
+				    (unsigned int __user *)ptr,
+				    size);
 		break;
 	case 8:
-		rc = __put_get_user_asm((unsigned long *)x,
-					(unsigned long __user *)ptr,
-					size, "lghi");
+		rc = __get_user_asm((unsigned long *)x,
+				    (unsigned long __user *)ptr,
+				    size);
 		break;
 	default:
 		__get_user_bad();
diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index a596e69d3c47..d3a700385875 100644
--- a/arch/s390/lib/uaccess.c
+++ b/arch/s390/lib/uaccess.c
@@ -62,10 +62,14 @@ static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr
 						 unsigned long size)
 {
 	unsigned long tmp1, tmp2;
+	union oac spec = {
+		.oac2.as = PSW_BITS_AS_SECONDARY,
+		.oac2.a = 1,
+	};
 
 	tmp1 = -4096UL;
 	asm volatile(
-		"   lghi  0,%[spec]\n"
+		"   lr   0,%[spec]\n"
 		"0: .insn ss,0xc80000000000,0(%0,%2),0(%1),0\n"
 		"6: jz    4f\n"
 		"1: algr  %0,%3\n"
@@ -84,7 +88,7 @@ static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr
 		"5:\n"
 		EX_TABLE(0b,2b) EX_TABLE(3b,5b) EX_TABLE(6b,2b) EX_TABLE(7b,5b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
-		: [spec] "K" (0x81UL)
+		: [spec] "d" (spec.val)
 		: "cc", "memory", "0");
 	return size;
 }
@@ -135,10 +139,14 @@ static inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
 					       unsigned long size)
 {
 	unsigned long tmp1, tmp2;
+	union oac spec = {
+		.oac1.as = PSW_BITS_AS_SECONDARY,
+		.oac1.a = 1,
+	};
 
 	tmp1 = -4096UL;
 	asm volatile(
-		"   llilh 0,%[spec]\n"
+		"   lr 0,%[spec]\n"
 		"0: .insn ss,0xc80000000000,0(%0,%1),0(%2),0\n"
 		"6: jz    4f\n"
 		"1: algr  %0,%3\n"
@@ -157,7 +165,7 @@ static inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
 		"5:\n"
 		EX_TABLE(0b,2b) EX_TABLE(3b,5b) EX_TABLE(6b,2b) EX_TABLE(7b,5b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
-		: [spec] "K" (0x81UL)
+		: [spec] "d" (spec.val)
 		: "cc", "memory", "0");
 	return size;
 }
@@ -207,10 +215,14 @@ EXPORT_SYMBOL(raw_copy_to_user);
 static inline unsigned long clear_user_mvcos(void __user *to, unsigned long size)
 {
 	unsigned long tmp1, tmp2;
+	union oac spec = {
+		.oac1.as = PSW_BITS_AS_SECONDARY,
+		.oac1.a = 1,
+	};
 
 	tmp1 = -4096UL;
 	asm volatile(
-		"   llilh 0,%[spec]\n"
+		"   lr 0,%[spec]\n"
 		"0: .insn ss,0xc80000000000,0(%0,%1),0(%4),0\n"
 		"   jz	  4f\n"
 		"1: algr  %0,%2\n"
@@ -228,7 +240,7 @@ static inline unsigned long clear_user_mvcos(void __user *to, unsigned long size
 		"5:\n"
 		EX_TABLE(0b,2b) EX_TABLE(3b,5b)
 		: "+a" (size), "+a" (to), "+a" (tmp1), "=a" (tmp2)
-		: "a" (empty_zero_page), [spec] "K" (0x81UL)
+		: "a" (empty_zero_page), [spec] "d" (spec.val)
 		: "cc", "memory", "0");
 	return size;
 }
-- 
2.32.0

