Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E794449B51B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577071AbiAYN2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:28:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1576611AbiAYNYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:24:06 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PCJuGu031081;
        Tue, 25 Jan 2022 13:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=jLrcOpzvI8VIHDSYkgypuSuYkQeYLnzarUN+jMDB9js=;
 b=c4NaJz8CYjlRw5dqRPLB6QO52gfpUZBtbUbxS0kTjNVu6YiJXBvwXiTJ9d3wIo8/466n
 S3NWDXFRctS7oYZMAz+/wRZxpO7z1xnpdBDoPJwL6uJq1qmJS2p7gxUynW/S1Ptl1tUr
 XpxwNY/kj9qB4yEy7ZVB8cdKOphyS2Mk/nbsUtXsAZGTkI+TNSWlCcTbH8KUnHggG5Ak
 Wj44StYdOM8Vou6cIreIcruTWe7t4FUfBFdXIkntXHBSKEV+u3q6/v1EsfDZ5qR4MzHw
 WCL6klwIWNblng+MOcBl+QoforSECiV77hL7NmWpNKKyaOQbaryo6otjb9T1xIC4Janw Pg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtevcccsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 13:24:01 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PDCuB8007836;
        Tue, 25 Jan 2022 13:23:58 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3dr9j9d2dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 13:23:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PDEH2X47120866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 13:14:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0398EA4065;
        Tue, 25 Jan 2022 13:23:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97044A405B;
        Tue, 25 Jan 2022 13:23:49 +0000 (GMT)
Received: from osiris (unknown [9.145.2.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Jan 2022 13:23:49 +0000 (GMT)
Date:   Tue, 25 Jan 2022 14:23:48 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [RFC PATCH] uaccess: Add mechanism for key checked access to
 user memory
Message-ID: <Ye/55AdsFzkpD7m7@osiris>
References: <YerCfDceDszqbdHU@osiris>
 <20220124103812.2340666-1-scgl@linux.ibm.com>
 <Ye7kuJ51QWFBGoJ4@osiris>
 <92c2d051-e25f-7b3a-c811-dd1ce85f1b9b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92c2d051-e25f-7b3a-c811-dd1ce85f1b9b@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rj3V75LjHc_qWF_vUoT2Zf4hRzw15sfr
X-Proofpoint-ORIG-GUID: Rj3V75LjHc_qWF_vUoT2Zf4hRzw15sfr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_02,2022-01-25_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Please make this _fully_ symmetrical to the existing copy_to/from_user()
> > implementations, like I tried to say several times. Maybe I wasn't clear
> > enough about this. Also the default implementation - that is if an
> > architecture makes use of copy_to_user_key() without providing a
> > raw_copy_from_user_key() implementation - should fallback to regular
> > copy_to_user() semantics, like I tried to outline with the ifndef example
> > of raw_copy_from_user_key() previously.
> 
> That does help. One thing I'm still confused about is the rational
> for the default implementation.

This is to avoid link errors, and potentially having something that
works everywhere without having to add ifdefs everywhere in case this
needs to be used in common code.

Again: this is just a proposal, nothing else.

> Are you suggesting that copy_from/to_user be implemented in terms of
> copy_from/to_user_with_key? I didn't think so, even tho you said something along
> those lines, because I assumed you were referring to the architecture specific
> implementations for copy_from/to_user, since we weren't talking about
> common code changes back then and Christian's suggestion didn't feature it either.
> 
> When you say "fully symmetrical" do you mean all functions that wrap architecture
> defined access to user space:
> __copy_from_user_inatomic
> __copy_from_user
> __copy_to_user_inatomic
> __copy_to_user
> _copy_from_user
> _copy_to_user
> copy_from_user
> copy_to_user
> __copy_from_user_inatomic_nocache
> copy_struct_from_user
> copy_from_user_nofault
> copy_to_user_nofault
> strncpy_from_user_nofault
> strnlen_user_nofault

I meant something like below - not even compile tested. It is missing
any comments, commit message and sanity checks. That's up to you.

Patch is on top of your patch, and of course needs to be splitted.

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index 35fda4251f47..422066d7c5e2 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -33,31 +33,33 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
 
 #define access_ok(addr, size) __access_ok(addr, size)
 
-#define raw_copy_from_user_with_key raw_copy_from_user_with_key
+#define raw_copy_from_user_key raw_copy_from_user_key
 unsigned long __must_check
-raw_copy_from_user_with_key(void *to, const void __user *from, unsigned long n,
-			    unsigned long key);
+raw_copy_from_user_key(void *to, const void __user *from, unsigned long n,
+		       unsigned long key);
 
-#define raw_copy_to_user_with_key raw_copy_to_user_with_key
+#define raw_copy_to_user_key raw_copy_to_user_key
 unsigned long __must_check
-raw_copy_to_user_with_key(void __user *to, const void *from, unsigned long n,
-			  unsigned long key);
+raw_copy_to_user_key(void __user *to, const void *from, unsigned long n,
+		     unsigned long key);
 
 static __always_inline unsigned long __must_check
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	return raw_copy_from_user_with_key(to, from, n, 0);
+	return raw_copy_from_user_key(to, from, n, 0);
 }
 
 static __always_inline unsigned long __must_check
 raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	return raw_copy_to_user_with_key(to, from, n, 0);
+	return raw_copy_to_user_key(to, from, n, 0);
 }
 
 #ifndef CONFIG_KASAN
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
+#define INLINE_COPY_FROM_USER_KEY
+#define INLINE_COPY_TO_USER_KEY
 #endif
 
 int __put_user_bad(void) __attribute__((noreturn));
diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index 2e4e55580185..689a5ab3121a 100644
--- a/arch/s390/lib/uaccess.c
+++ b/arch/s390/lib/uaccess.c
@@ -59,7 +59,7 @@ static inline int copy_with_mvcos(void)
 #endif
 
 static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr,
-						 unsigned long size, u8 key)
+						 unsigned long size, unsigned long key)
 {
 	unsigned long tmp1, tmp2;
 	union oac spec = {
@@ -96,7 +96,7 @@ static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr
 }
 
 static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
-						unsigned long size, u8 key)
+						unsigned long size, unsigned long key)
 {
 	unsigned long tmp1, tmp2;
 
@@ -130,17 +130,17 @@ static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
 	return size;
 }
 
-unsigned long raw_copy_from_user_with_key(void *to, const void __user *from,
-					  unsigned long n, unsigned long key)
+unsigned long raw_copy_from_user_key(void *to, const void __user *from,
+				     unsigned long n, unsigned long key)
 {
 	if (copy_with_mvcos())
-		return copy_from_user_mvcos(to, from, n, (u8)key);
-	return copy_from_user_mvcp(to, from, n, (u8)key);
+		return copy_from_user_mvcos(to, from, n, key);
+	return copy_from_user_mvcp(to, from, n, key);
 }
-EXPORT_SYMBOL(raw_copy_from_user_with_key);
+EXPORT_SYMBOL(raw_copy_from_user_key);
 
-inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
-					unsigned long size, u8 key)
+static inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
+					       unsigned long size, unsigned long key)
 {
 	unsigned long tmp1, tmp2;
 	union oac spec = {
@@ -177,7 +177,7 @@ inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
 }
 
 static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
-					      unsigned long size, u8 key)
+					      unsigned long size, unsigned long key)
 {
 	unsigned long tmp1, tmp2;
 
@@ -211,14 +211,14 @@ static inline unsigned long copy_to_user_mvcs(void __user *ptr, const void *x,
 	return size;
 }
 
-unsigned long raw_copy_to_user_with_key(void __user *to, const void *from,
-					unsigned long n, unsigned long key)
+unsigned long raw_copy_to_user_key(void __user *to, const void *from,
+				   unsigned long n, unsigned long key)
 {
 	if (copy_with_mvcos())
-		return copy_to_user_mvcos(to, from, n, (u8)key);
-	return copy_to_user_mvcs(to, from, n, (u8)key);
+		return copy_to_user_mvcos(to, from, n, key);
+	return copy_to_user_mvcs(to, from, n, key);
 }
-EXPORT_SYMBOL(raw_copy_to_user_with_key);
+EXPORT_SYMBOL(raw_copy_to_user_key);
 
 static inline unsigned long clear_user_mvcos(void __user *to, unsigned long size)
 {
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index adce966edb7a..644955b31958 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -114,20 +114,6 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
 	return raw_copy_from_user(to, from, n);
 }
 
-#ifdef raw_copy_from_user_with_key
-static __always_inline __must_check unsigned long
-__copy_from_user_with_key(void *to, const void __user *from, unsigned long n,
-			  unsigned long key)
-{
-	might_fault();
-	if (should_fail_usercopy())
-		return n;
-	instrument_copy_from_user(to, from, n);
-	check_object_size(to, n, false);
-	return raw_copy_from_user_with_key(to, from, n, key);
-}
-#endif /* raw_copy_from_user_with_key */
-
 /**
  * __copy_to_user_inatomic: - Copy a block of data into user space, with less checking.
  * @to:   Destination address, in user space.
@@ -162,20 +148,6 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
 	return raw_copy_to_user(to, from, n);
 }
 
-#ifdef raw_copy_to_user_with_key
-static __always_inline __must_check unsigned long
-__copy_to_user_with_key(void __user *to, const void *from, unsigned long n,
-			unsigned long key)
-{
-	might_fault();
-	if (should_fail_usercopy())
-		return n;
-	instrument_copy_to_user(to, from, n);
-	check_object_size(from, n, true);
-	return raw_copy_to_user_with_key(to, from, n, key);
-}
-#endif /* raw_copy_to_user_with_key */
-
 #ifdef INLINE_COPY_FROM_USER
 static inline __must_check unsigned long
 _copy_from_user(void *to, const void __user *from, unsigned long n)
@@ -229,6 +201,81 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
 	return n;
 }
 
+#ifndef raw_copy_from_user_key
+static __always_inline unsigned long __must_check
+raw_copy_from_user_key(void *to, const void __user *from, unsigned long n,
+		       unsigned long key)
+{
+	return raw_copy_from_user(to, from, n);
+}
+#endif
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
+#ifndef raw_copy_to_user
+static __always_inline unsigned long __must_check
+raw_copy_to_user_key(void __user *to, const void *from, unsigned long n,
+		     unsigned long key)
+{
+	return raw_copy_to_user(to, from, n);
+}
+#endif
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
