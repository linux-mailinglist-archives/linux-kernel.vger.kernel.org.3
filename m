Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26DD4737B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbhLMWjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243652AbhLMWjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:39:05 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03211C061751
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:39:05 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r5so15795277pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AA279o1BLd1IPMvrElk1qRQp3NwWnxyLqgW1QfH2RSA=;
        b=CisEAwRc7YBWG4xLa3phyPxxBAXkceqQrDqmiiNUoGG9uT3iGaIcQW/MWHHULH3+Qa
         Q/EyHNAn+tC9WnDly31FLv4ZoNg3A/Ww4sejWBMGcaabTVSbBlnSu+0jbunK4/ptp2pg
         SkF0PoCsoWMmnj6MDZE8uVSWO378opDUA1kr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AA279o1BLd1IPMvrElk1qRQp3NwWnxyLqgW1QfH2RSA=;
        b=YGaYEQdQEqX2giUnf3rTzQHPIJiDF+f/JK/BCDWG3CrjyrixY8utop/HIKHd3t+goe
         +CJZVHZzQXSIMsMDeRZ0sXN5dm0/9iNA2AMOHndVO+2O9uptgy42V3RNhIWGUz5yeGuO
         2KFvL4+zJAZDgbcGkA/I2waXUjjHIGRq5VNSJEGzKvziMPFMpfd196QHXQHw76RR7hXM
         uWnzUhgNUFSEhcvRRiud6709H4ak0dJ0spmdgUYNWqUqfwacm11ixtXTnOJASgsnXQI6
         PbwL2Edldln/bsYHhURifgmvaGNHbYhUQMiXodL2jfoT3Ia6ZLdtj+XpLemm7anVzDmU
         Txyg==
X-Gm-Message-State: AOAM5300FIfEhDa+TnyZBOf1BEiN36Dp+F5AbfMwCmXKI6hVbas0V6hx
        Q9kbnimwTAfHGSMwc8mzNKyq8VXENgdKzw==
X-Google-Smtp-Source: ABdhPJyqYBM9zQd5T7wkCm0WBCdXKJbo+rqvd4vfTzrQwvZhGfZWPDfpu/dFPiIuFk7Tk3eG2caZjA==
X-Received: by 2002:a63:5754:: with SMTP id h20mr1019576pgm.475.1639435144385;
        Mon, 13 Dec 2021 14:39:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a12sm11205193pgg.28.2021.12.13.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:39:03 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] fortify: Work around Clang inlining bugs
Date:   Mon, 13 Dec 2021 14:33:31 -0800
Message-Id: <20211213223331.135412-18-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9699; h=from:subject; bh=jXLxaUJlSk/ETX1ZNQLV/wX5VA7T09i8avo3sLZcDF4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBht8o6A6CMjd4NskEB5NElq3z8H/O+hUvqKNBNdXHZ XMlSjuqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbfKOgAKCRCJcvTf3G3AJsa5D/ 0Sq1OFk+3IOsTieRd5IS/E7SMhJEUUNfrRstkjkpW7WL7hqcfqVtgIACnTRje6pZhtzMs5Ymbt+N1o hDZiXe7aWAOq5DITmYLxyZ/j23uW07cwgLwk4fMtmMyHi2anA3PoVGmFSRWNAeLVbiw3RrvzBaWI8O qmoMEGml1WJSMSZbaDsSv1OgbNm3ZLQerbiTaXMz6MGs21hmk6m3t4jXww0d5g97zgTC1p4pmeisg9 sd2ZLjLho3AkIS1gtxxJOr9m1NNOybA750DhngDUDMncNuftaNkqvtkfU4CDnJYMR05KkWkk4vRMpJ PY93xDjW8w2gxNwbrXI8/5GlbND0UT9UdCmoQSRxluki71bFQcOlQEF3TpDed5e6W1y3li6be4+KS7 LBMo0mPGbyxotzA3Ig2CgQb8VB8dCfE4cgLRGLQiqoWBJstpvnzA2AHrczKt6wf29WNII+eWTjjDWj 8xJgVa5sraKmKyoucmmI6Kn6OD6upZm2CXGVyjkanle+Q6YOiHDbTae9ypdkiS49z2anhApIALPSjD TkNbnIQm+mjydW7hjiuuYhuSqc+3gW3Nix653wxS4YnG3pvHUyCyohJvIp/YBzB7/V9Lsoi0nmbBmo o67i3Ns4bexzjkurRfEWMEs5GtK73Irq2IbMM5w+HVPGqlL+AujM5mTxQLRA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable FORTIFY_SOURCE support for Clang, the kernel must work around
a pair of bugs, related to Clang's inlining.

Change all the fortified APIs into macros with different inline names to
bypass Clang's broken inline-of-a-builtin detection:
https://bugs.llvm.org/show_bug.cgi?id=50322

Lift all misbehaving __builtin_object_size() calls into the macros to
bypass Clang's broken __builtin_object_size() arguments-of-an-inline
visibility:
https://github.com/ClangBuiltLinux/linux/issues/1401

Thankfully, due to how the inlining already behaves in GCC, this change
has no effect on GCC builds, but allows Clang to finally gain full
FORTIFY coverage.

However, because of a third bug which had no work-arounds, FORTIFY_SOURCE
will only work with Clang version 13 and later. Update the Kconfig to
reflect the new requirements.

Clang 14 introduced compiletime_assert() support, so also adjust the
compile-time warning test to catch Clang's variant of the warning text.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 65 +++++++++++++++++++++-------------
 scripts/test_fortify.sh        |  8 +++--
 security/Kconfig               |  2 +-
 3 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index c45159dbdaa1..04bcf8307f16 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -50,10 +50,10 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 #define __underlying_strncpy	__builtin_strncpy
 #endif
 
-__FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
+#define strncpy(p, q, s) __fortify_strncpy(p, q, s, __builtin_object_size(p, 1))
+__FORTIFY_INLINE char *__fortify_strncpy(char *p, const char *q,
+					 __kernel_size_t size, size_t p_size)
 {
-	size_t p_size = __builtin_object_size(p, 1);
-
 	if (__builtin_constant_p(size) && p_size < size)
 		__write_overflow();
 	if (p_size < size)
@@ -73,9 +73,10 @@ __FORTIFY_INLINE char *strcat(char *p, const char *q)
 }
 
 extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
-__FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
+#define strnlen(p, s) __fortify_strnlen(p, s, __builtin_object_size(p, 1))
+__FORTIFY_INLINE __kernel_size_t __fortify_strnlen(const char *p, size_t maxlen,
+						   size_t p_size)
 {
-	size_t p_size = __builtin_object_size(p, 1);
 	size_t p_len = __compiletime_strlen(p);
 	size_t ret;
 
@@ -94,10 +95,10 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
 }
 
 /* defined after fortified strnlen to reuse it. */
-__FORTIFY_INLINE __kernel_size_t strlen(const char *p)
+#define strlen(p) __fortify_strlen(p, __builtin_object_size(p, 1))
+__FORTIFY_INLINE __kernel_size_t __fortify_strlen(const char *p, const size_t p_size)
 {
 	__kernel_size_t ret;
-	size_t p_size = __builtin_object_size(p, 1);
 
 	/* Give up if we don't know how large p is. */
 	if (p_size == (size_t)-1)
@@ -110,10 +111,14 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 
 /* defined after fortified strlen to reuse it */
 extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
-__FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
+#define strlcpy(p, q, s) __fortify_strlcpy(p, q, s,			\
+					   __builtin_object_size(p, 1),	\
+					   __builtin_object_size(q, 1))
+__FORTIFY_INLINE size_t __fortify_strlcpy(char *p, const char *q,
+					  size_t size,
+					  const size_t p_size,
+					  const size_t q_size)
 {
-	size_t p_size = __builtin_object_size(p, 1);
-	size_t q_size = __builtin_object_size(q, 1);
 	size_t q_len;	/* Full count of source string length. */
 	size_t len;	/* Count of characters going into destination. */
 
@@ -137,12 +142,15 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
 
 /* defined after fortified strnlen to reuse it */
 extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
-__FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
+#define strscpy(p, q, s) __fortify_strscpy(p, q, s,			\
+					   __builtin_object_size(p, 1),	\
+					   __builtin_object_size(q, 1))
+__FORTIFY_INLINE ssize_t __fortify_strscpy(char *p, const char *q,
+					   size_t size,
+					   const size_t p_size,
+					   const size_t q_size)
 {
 	size_t len;
-	/* Use string size rather than possible enclosing struct size. */
-	size_t p_size = __builtin_object_size(p, 1);
-	size_t q_size = __builtin_object_size(q, 1);
 
 	/* If we cannot get size of p and q default to call strscpy. */
 	if (p_size == (size_t) -1 && q_size == (size_t) -1)
@@ -183,11 +191,13 @@ __FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
 }
 
 /* defined after fortified strlen and strnlen to reuse them */
-__FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
+#define strncat(p, q, count)	__fortify_strncat(p, q, count, \
+						  __builtin_object_size(p, 1), \
+						  __builtin_object_size(q, 1))
+__FORTIFY_INLINE char *__fortify_strncat(char *p, const char *q, size_t count,
+					 size_t p_size, size_t q_size)
 {
 	size_t p_len, copy_len;
-	size_t p_size = __builtin_object_size(p, 1);
-	size_t q_size = __builtin_object_size(q, 1);
 
 	if (p_size == (size_t)-1 && q_size == (size_t)-1)
 		return __underlying_strncat(p, q, count);
@@ -354,7 +364,8 @@ __FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
 		memmove)
 
 extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
-__FORTIFY_INLINE void *memscan(void *p, int c, __kernel_size_t size)
+#define memscan(p, c, s) __fortify_memscan(p, c, s)
+__FORTIFY_INLINE void *__fortify_memscan(void *p, int c, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -365,7 +376,8 @@ __FORTIFY_INLINE void *memscan(void *p, int c, __kernel_size_t size)
 	return __real_memscan(p, c, size);
 }
 
-__FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
+#define memcmp(p, q, s) __fortify_memcmp(p, q, s)
+__FORTIFY_INLINE int __fortify_memcmp(const void *p, const void *q, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 	size_t q_size = __builtin_object_size(q, 0);
@@ -381,7 +393,8 @@ __FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
 	return __underlying_memcmp(p, q, size);
 }
 
-__FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
+#define memchr(p, c, s) __fortify_memchr(p, c, s)
+__FORTIFY_INLINE void *__fortify_memchr(const void *p, int c, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -393,7 +406,8 @@ __FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
 }
 
 void *__real_memchr_inv(const void *s, int c, size_t n) __RENAME(memchr_inv);
-__FORTIFY_INLINE void *memchr_inv(const void *p, int c, size_t size)
+#define memchr_inv(p, c, s) __fortify_memchr_inv(p, c, s)
+__FORTIFY_INLINE void *__fortify_memchr_inv(const void *p, int c, size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -417,10 +431,13 @@ __FORTIFY_INLINE void *kmemdup(const void *p, size_t size, gfp_t gfp)
 }
 
 /* Defined after fortified strlen to reuse it. */
-__FORTIFY_INLINE char *strcpy(char *p, const char *q)
+#define strcpy(p, q) __fortify_strcpy(p, q,				\
+				      __builtin_object_size(p, 1),	\
+				      __builtin_object_size(q, 1))
+__FORTIFY_INLINE char *__fortify_strcpy(char *p, const char *q,
+					const size_t p_size,
+					const size_t q_size)
 {
-	size_t p_size = __builtin_object_size(p, 1);
-	size_t q_size = __builtin_object_size(q, 1);
 	size_t size;
 
 	/* If neither buffer size is known, immediately give up. */
diff --git a/scripts/test_fortify.sh b/scripts/test_fortify.sh
index a4da365508f0..c2688ab8281d 100644
--- a/scripts/test_fortify.sh
+++ b/scripts/test_fortify.sh
@@ -46,8 +46,12 @@ if "$@" -Werror -c "$IN" -o "$OUT".o 2> "$TMP" ; then
 		status="warning: unsafe ${FUNC}() usage lacked '$WANT' symbol in $IN"
 	fi
 else
-	# If the build failed, check for the warning in the stderr (gcc).
-	if ! grep -q -m1 "error: call to .\b${WANT}\b." "$TMP" ; then
+	# If the build failed, check for the warning in the stderr.
+	# GCC:
+	# ./include/linux/fortify-string.h:316:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
+	# Clang 14:
+	# ./include/linux/fortify-string.h:316:4: error: call to __write_overflow_field declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
+	if ! grep -Eq -m1 "error: call to .?\b${WANT}\b.?" "$TMP" ; then
 		status="warning: unsafe ${FUNC}() usage lacked '$WANT' warning in $IN"
 	fi
 fi
diff --git a/security/Kconfig b/security/Kconfig
index 0b847f435beb..1a25a567965f 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -179,7 +179,7 @@ config FORTIFY_SOURCE
 	depends on ARCH_HAS_FORTIFY_SOURCE
 	# https://bugs.llvm.org/show_bug.cgi?id=50322
 	# https://bugs.llvm.org/show_bug.cgi?id=41459
-	depends on !CC_IS_CLANG
+	depends on !CC_IS_CLANG || CLANG_VERSION >= 130000
 	help
 	  Detect overflows of buffers in common string and memory functions
 	  where the compiler can determine and validate the buffer sizes.
-- 
2.30.2

