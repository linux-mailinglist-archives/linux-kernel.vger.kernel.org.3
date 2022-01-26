Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37F949D0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243765AbiAZReN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:34:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236277AbiAZReM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:34:12 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QGNfD0014051;
        Wed, 26 Jan 2022 17:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TNutkjKt05QrzMxf5xsvaBWAyQPwSMA0xRdgArqQR6k=;
 b=s/0NSMeS7NTcKMxRpf8y5E7P/kXFniTF0WdlW+wZCkulHdLg0SYogL2tu7Cj5MWSiQGo
 qJIGKDgUB526uHCihSvymlGY+6XIJTjL9J92rnjitzI5rYCOIDh08WJ0E4NHqO7K8cp3
 viXSgzIFDbZhlCzaUZBwgsashLrwJSf0A/5adC5M21QVuM+e6Q6UMj4WYWj+ICHYpR0C
 V4ykA0m2tZko3XfrT6NDXGvYwIDX38+kqtdUTlDIyGsL/cdedd63h/N9H4Okr2j6sVCd
 r/tnhIu+ES0sy1Hz1GCB637RkZGOaaRvvVhxioYXlu15ys1+9UthfrsnrQWTIMD2QOEq gw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3du6ybnw2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 17:34:09 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20QHXxKu029398;
        Wed, 26 Jan 2022 17:34:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3dr9j9g7dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 17:34:07 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20QHY2e933882450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 17:34:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25EC242049;
        Wed, 26 Jan 2022 17:34:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDE5542045;
        Wed, 26 Jan 2022 17:34:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jan 2022 17:34:01 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] uaccess: Add mechanism for key checked access to user memory
Date:   Wed, 26 Jan 2022 18:33:57 +0100
Message-Id: <20220126173358.2951879-2-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220126173358.2951879-1-scgl@linux.ibm.com>
References: <20220126173358.2951879-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZI8NChSrKPVFfCkFq6yW6nC7X7DyEwV4
X-Proofpoint-GUID: ZI8NChSrKPVFfCkFq6yW6nC7X7DyEwV4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_06,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM on s390 needs a mechanism to do accesses to guest memory
that honors storage key protection.

On s390 each physical page is associated with 4 access control bits.
On access, these are compared with an access key, which is either
provided by the instruction or taken from the CPU state.
Based on that comparison, the access either succeeds or is prevented.

KVM on s390 needs to be able emulate this behavior, for example during
instruction emulation, when it makes accesses on behalf of the guest.
Introduce ...copy_{from,to}_user_key functions KVM can use to achieve
this. These differ from their non key counterparts by having an
additional key argument, and delegating to raw_copy_from/to_user_key
instead of raw_copy_{from,to}_user. Otherwise they are the same.
If they were to be maintained in architecture specific code they would
be prone to going out of sync with their non key counterparts.
To prevent this, add them to include/linux/uaccess.h.
In order to allow use of ...copy_{from,to}_user_key from common code,
the key argument is ignored on architectures that do not provide
raw_copy_{from,to}_user_key and the functions become functionally
identical to ...copy_{from,to}_user.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 include/linux/uaccess.h | 107 ++++++++++++++++++++++++++++++++++++++++
 lib/usercopy.c          |  33 +++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac0394087f7d..cba64cd23193 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -93,6 +93,11 @@ static inline void force_uaccess_end(mm_segment_t oldfs)
  * Biarch ones should also provide raw_copy_in_user() - similar to the above,
  * but both source and destination are __user pointers (affected by set_fs()
  * as usual) and both source and destination can trigger faults.
+ *
+ * Architectures can also provide raw_copy_{from,to}_user_key variants that take
+ * an additional key argument that can be used for additional memory protection
+ * checks. If these variants are not provided, ...copy_{from,to}_user_key are
+ * identical to their non key counterparts.
  */
 
 static __always_inline __must_check unsigned long
@@ -201,6 +206,108 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
 	return n;
 }
 
+/*
+ * ...copy_{from,to}_user_key variants
+ * must be kept in sync with their non key counterparts.
+ */
+#ifndef raw_copy_from_user_key
+static __always_inline unsigned long __must_check
+raw_copy_from_user_key(void *to, const void __user *from, unsigned long n,
+		       unsigned long key)
+{
+	return raw_copy_from_user(to, from, n);
+}
+#endif
+static __always_inline __must_check unsigned long
+__copy_from_user_key(void *to, const void __user *from, unsigned long n,
+		     unsigned long key)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	instrument_copy_from_user(to, from, n);
+	check_object_size(to, n, false);
+	return raw_copy_from_user_key(to, from, n, key);
+}
+
+#ifdef INLINE_COPY_FROM_USER_KEY
+static inline __must_check unsigned long
+_copy_from_user_key(void *to, const void __user *from, unsigned long n,
+		    unsigned long key)
+{
+	unsigned long res = n;
+	might_fault();
+	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
+		instrument_copy_from_user(to, from, n);
+		res = raw_copy_from_user_key(to, from, n, key);
+	}
+	if (unlikely(res))
+		memset(to + (n - res), 0, res);
+	return res;
+}
+#else
+extern __must_check unsigned long
+_copy_from_user_key(void *, const void __user *, unsigned long, unsigned long);
+#endif
+
+#ifndef raw_copy_to_user_key
+static __always_inline unsigned long __must_check
+raw_copy_to_user_key(void __user *to, const void *from, unsigned long n,
+		     unsigned long key)
+{
+	return raw_copy_to_user(to, from, n);
+}
+#endif
+
+static __always_inline __must_check unsigned long
+__copy_to_user_key(void __user *to, const void *from, unsigned long n,
+		   unsigned long key)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	instrument_copy_to_user(to, from, n);
+	check_object_size(from, n, true);
+	return raw_copy_to_user_key(to, from, n, key);
+}
+
+#ifdef INLINE_COPY_TO_USER_KEY
+static inline __must_check unsigned long
+_copy_to_user_key(void __user *to, const void *from, unsigned long n,
+		  unsigned long key)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	if (access_ok(to, n)) {
+		instrument_copy_to_user(to, from, n);
+		n = raw_copy_to_user_key(to, from, n, key);
+	}
+	return n;
+}
+#else
+extern __must_check unsigned long
+_copy_to_user_key(void __user *, const void *, unsigned long, unsigned long);
+#endif
+
+static __always_inline unsigned long __must_check
+copy_from_user_key(void *to, const void __user *from, unsigned long n,
+		   unsigned long key)
+{
+	if (likely(check_copy_size(to, n, false)))
+		n = _copy_from_user(to, from, n);
+	return n;
+}
+
+static __always_inline unsigned long __must_check
+copy_to_user_key(void __user *to, const void *from, unsigned long n,
+		 unsigned long key)
+{
+	if (likely(check_copy_size(from, n, true)))
+		n = _copy_to_user(to, from, n);
+	return n;
+}
+
 #ifndef copy_mc_to_kernel
 /*
  * Without arch opt-in this generic copy_mc_to_kernel() will not handle
diff --git a/lib/usercopy.c b/lib/usercopy.c
index 7413dd300516..c13394d0f306 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -37,6 +37,39 @@ unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 EXPORT_SYMBOL(_copy_to_user);
 #endif
 
+#ifndef INLINE_COPY_FROM_USER_KEY
+unsigned long _copy_from_user_key(void *to, const void __user *from,
+				  unsigned long n, unsigned long key)
+{
+	unsigned long res = n;
+	might_fault();
+	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
+		instrument_copy_from_user(to, from, n);
+		res = raw_copy_from_user_key(to, from, n, key);
+	}
+	if (unlikely(res))
+		memset(to + (n - res), 0, res);
+	return res;
+}
+EXPORT_SYMBOL(_copy_from_user_key);
+#endif
+
+#ifndef INLINE_COPY_TO_USER_KEY
+unsigned long _copy_to_user_key(void __user *to, const void *from,
+				unsigned long n, unsigned long key)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	if (likely(access_ok(to, n))) {
+		instrument_copy_to_user(to, from, n);
+		n = raw_copy_to_user_key(to, from, n, key);
+	}
+	return n;
+}
+EXPORT_SYMBOL(_copy_to_user_key);
+#endif
+
 /**
  * check_zeroed_user: check if a userspace buffer only contains zero bytes
  * @from: Source address, in userspace.
-- 
2.32.0

