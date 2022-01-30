Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0704A3807
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 19:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347062AbiA3SWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 13:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242093AbiA3SWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 13:22:07 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754E5C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 10:22:07 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id h23so10096824pgk.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 10:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9PVzYdsV/ZU8fiIKSmfLj/ncDpgKSKegZvAIJD4IRTU=;
        b=RHwfcVTscX9mSKCAZNJxuEbySR6IIpPwOav5DxNT6Ruu8Sn4lap40LuS/ld3pl4Mug
         kU/73DT+6gsY2HcvmdQM4Fofj4wMJfukjvc6SsScOeyHyYb9knr5mapFQqSOK15Qem5s
         pYsRVOHQElzdlUWwWIOBu84XOD/uNfN5JmlqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9PVzYdsV/ZU8fiIKSmfLj/ncDpgKSKegZvAIJD4IRTU=;
        b=OhdfPKB5OAB5NKaMZOo/a9KR3miPUbtS/E1UAsF24EtfS27Shu4pYElD8MnVMZqIKP
         vbDvrilYbH/zuRT0ebUEUyz1KrwlgPECOm21XTNYm2iIMSg6Vc/CS4I+C6IYFIyS3TwH
         Qti3L71u10/FztvKerQAJHKyYz6mBApn1w+5bRAqIMKOLQTl6rYkIgnBzDZBuEzD9y1l
         TbohAMlOtRNP3+PW1+yY0CgAur1Lc5TNWfdB1X93/9LyRJ9GqU7Hm0PBYMvh6SAyodCe
         vdroRWY7KX/wLzthoj7w7V1xBFCtmSojTyCm0u2rYTDoOAapWzbxfcDhLfl1wWl48D2n
         GDsw==
X-Gm-Message-State: AOAM531GzVMaqU7C4Ie71lXyf5d9W+Kdt9xiZh3o/35+qtUhhupuT02J
        d+r4k7lq2wJ6+pX4cXlL6m6mhw==
X-Google-Smtp-Source: ABdhPJx/nz1hpX+KwT4a+CixzWeds6FA6VzOHsyN13JfjsHlJTEI/amk/8LSL/GmYUbs0f0lRVVE6g==
X-Received: by 2002:a62:7c42:: with SMTP id x63mr17198898pfc.31.1643566926798;
        Sun, 30 Jan 2022 10:22:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ce15sm8740458pjb.5.2022.01.30.10.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 10:22:06 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v4] fortify: Work around Clang inlining bugs
Date:   Sun, 30 Jan 2022 10:22:04 -0800
Message-Id: <20220130182204.420775-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11070; h=from:subject; bh=6vAGXlIIO6Q2SRY30rYXGjJ2KNcszQ9M3ZyRIOLQQgQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh9tdL0Qt/wpWp7mc3x8X/+ab6Jn+IZ5X813/bu3w0 s9TnWQ6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfbXSwAKCRCJcvTf3G3AJg51D/ 9eg2muCYIqqEaL/Djqbw5VnzCaAeblZtop3k3Z57565aDJpgamcPM5orCnADZLnRfWTz+SEXv3KwdW SFJ/TW0XBXa+MYKdSPcLLMs21hBr6/O5PgO1mlvtk3Uw+E3E5Eo1vF/CI/SAg345ZgMmKuvxjJf8+8 ecnJ3ebC5NVXWzTUiBV5XMNEYFAWfDRQyg7tyKVrwY4nkaNqvQ3OJjlH1Hs/ZuREwoCzp+8OWLtTHJ zY80XZIuoXTs75R39ZYF6qPRLxNN4gKWGV6FhtDfS8Uthz4t9vcGqhJCLafZapmmd17nmNgWRBnqJm 7YY/aNaiSiyhelqUOcYF4ITijZWK70jFwRMsMlQCgKOePuhYI0Ne5sVfnBoehsPGuSKhyy37Ad8sJN EArqvTSeZyvT4jXh9cTGeuTyDiiS34UdaFTFgaeMXziCZsJpvi6//G0Wff48rfmKVk6KcCVEffgt4g 4OgQZSFKgEykPO001q0RU/yICiUq+aW0fSd+MzElJK+BCQCB6yB/Tr0wssJbuIFcge1e7AD4hGRfBD iqyu8e32QDFavseEEKbCHT+iF1wU1Or1dhEuGDnwCxqBhopmnM1bfmm9sS2rB6jePF5mq3XbczFUCn BCB7bJnUNPj3Ui84o8HxRn7CfkzjYyqjLlwTYDrHXxKEwyiDTpm1QKf+K7vw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable FORTIFY_SOURCE support for Clang, the kernel must work around
a pair of bugs, related to Clang's inlining:

1) Change all the fortified string APIs into macros with different
inline names to bypass Clang's broken inline-of-a-builtin detection:
https://bugs.llvm.org/show_bug.cgi?id=50322

2) Lift all misbehaving __builtin_object_size() calls into the macros
to bypass Clang's broken __builtin_object_size() arguments-of-an-inline
visibility:
https://github.com/ClangBuiltLinux/linux/issues/1401

One behavioral difference needed to be handled due to 1): the real
strlen() function can be a constant expression (for use with static
initializers), and that compiler magic needed to be reproduced in
the macro.

The workaround in 2) means Clang only gains single-level visibility
for the FORTIFY protection: any additional layers of inlining will
obscure the detection. This limitation will go away once the Clang
bug is fixed.

And finally, working around these bugs exposed a third bug which had
no identifiable workaround: globally defined variables did not work
with __builtin_constant_p():
https://bugs.llvm.org/show_bug.cgi?id=41459
See commit a52f8a59aef4 ("fortify: Explicitly disable Clang support").
This was fixed in Clang 13, so only Clang 13 and later gain FORTIFY
coverage.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/linux-hardening/20210727205855.411487-61-keescook@chromium.org/
v2: https://lore.kernel.org/linux-hardening/20210818060533.3569517-64-keescook@chromium.org/
v3: https://lore.kernel.org/linux-hardening/20211213223331.135412-18-keescook@chromium.org/
v4:
 - make sure strlen() can still be used as a constant expression
 - improve commit message with more details
---
 include/linux/fortify-string.h | 97 +++++++++++++++++++++-------------
 security/Kconfig               |  2 +-
 2 files changed, 61 insertions(+), 38 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index c45159dbdaa1..d5184e4e3244 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_FORTIFY_STRING_H_
 #define _LINUX_FORTIFY_STRING_H_
 
+#include <linux/const.h>
+
 #define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
 #define __RENAME(x) __asm__(#x)
 
@@ -50,10 +52,10 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 #define __underlying_strncpy	__builtin_strncpy
 #endif
 
-__FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
+#define strncpy(p, q, s) __fortify_strncpy(p, q, s, __builtin_object_size(p, 1))
+__FORTIFY_INLINE char *__fortify_strncpy(char *p, const char *q,
+					 __kernel_size_t size, const size_t p_size)
 {
-	size_t p_size = __builtin_object_size(p, 1);
-
 	if (__builtin_constant_p(size) && p_size < size)
 		__write_overflow();
 	if (p_size < size)
@@ -61,10 +63,9 @@ __FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
 	return __underlying_strncpy(p, q, size);
 }
 
-__FORTIFY_INLINE char *strcat(char *p, const char *q)
+#define strcat(p, q) __fortify_strcat(p, q, __builtin_object_size(p, 1))
+__FORTIFY_INLINE char *__fortify_strcat(char *p, const char *q, const size_t p_size)
 {
-	size_t p_size = __builtin_object_size(p, 1);
-
 	if (p_size == (size_t)-1)
 		return __underlying_strcat(p, q);
 	if (strlcat(p, q, p_size) >= p_size)
@@ -73,9 +74,10 @@ __FORTIFY_INLINE char *strcat(char *p, const char *q)
 }
 
 extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
-__FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
+#define strnlen(p, s) __fortify_strnlen(p, s, __builtin_object_size(p, 1))
+__FORTIFY_INLINE __kernel_size_t __fortify_strnlen(const char *p, size_t maxlen,
+						   const size_t p_size)
 {
-	size_t p_size = __builtin_object_size(p, 1);
 	size_t p_len = __compiletime_strlen(p);
 	size_t ret;
 
@@ -93,11 +95,18 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
 	return ret;
 }
 
-/* defined after fortified strnlen to reuse it. */
-__FORTIFY_INLINE __kernel_size_t strlen(const char *p)
+/*
+ * Defined after fortified strnlen to reuse it. However, it must still be
+ * possible for strlen() to be used on compile-time strings for use in
+ * static initializers (i.e. as a constant expression).
+ */
+#define strlen(p)						   \
+	__builtin_choose_expr(__is_constexpr(__builtin_strlen(p)), \
+		__builtin_strlen(p),				   \
+		__fortify_strlen(p, __builtin_object_size(p, 1)))
+__FORTIFY_INLINE __kernel_size_t __fortify_strlen(const char *p, const size_t p_size)
 {
 	__kernel_size_t ret;
-	size_t p_size = __builtin_object_size(p, 1);
 
 	/* Give up if we don't know how large p is. */
 	if (p_size == (size_t)-1)
@@ -110,10 +119,14 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 
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
 
@@ -137,12 +150,15 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
 
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
@@ -183,11 +199,14 @@ __FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
 }
 
 /* defined after fortified strlen and strnlen to reuse them */
-__FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
+#define strncat(p, q, count)	__fortify_strncat(p, q, count, \
+						  __builtin_object_size(p, 1), \
+						  __builtin_object_size(q, 1))
+__FORTIFY_INLINE char *__fortify_strncat(char *p, const char *q, size_t count,
+					 const size_t p_size,
+					 const size_t q_size)
 {
 	size_t p_len, copy_len;
-	size_t p_size = __builtin_object_size(p, 1);
-	size_t q_size = __builtin_object_size(q, 1);
 
 	if (p_size == (size_t)-1 && q_size == (size_t)-1)
 		return __underlying_strncat(p, q, count);
@@ -354,10 +373,10 @@ __FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
 		memmove)
 
 extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
-__FORTIFY_INLINE void *memscan(void *p, int c, __kernel_size_t size)
+#define memscan(p, c, s) __fortify_memscan(p, c, s, __builtin_object_size(p, 0))
+__FORTIFY_INLINE void *__fortify_memscan(void *p, int c, __kernel_size_t size,
+					 const size_t p_size)
 {
-	size_t p_size = __builtin_object_size(p, 0);
-
 	if (__builtin_constant_p(size) && p_size < size)
 		__read_overflow();
 	if (p_size < size)
@@ -365,11 +384,12 @@ __FORTIFY_INLINE void *memscan(void *p, int c, __kernel_size_t size)
 	return __real_memscan(p, c, size);
 }
 
-__FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
+#define memcmp(p, q, s) __fortify_memcmp(p, q, s,			\
+					 __builtin_object_size(p, 0),	\
+					 __builtin_object_size(q, 0))
+__FORTIFY_INLINE int __fortify_memcmp(const void *p, const void *q, __kernel_size_t size,
+				      const size_t p_size, const size_t q_size)
 {
-	size_t p_size = __builtin_object_size(p, 0);
-	size_t q_size = __builtin_object_size(q, 0);
-
 	if (__builtin_constant_p(size)) {
 		if (p_size < size)
 			__read_overflow();
@@ -381,10 +401,10 @@ __FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
 	return __underlying_memcmp(p, q, size);
 }
 
-__FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
+#define memchr(p, c, s) __fortify_memchr(p, c, s, __builtin_object_size(p, 0))
+__FORTIFY_INLINE void *__fortify_memchr(const void *p, int c, __kernel_size_t size,
+					const size_t p_size)
 {
-	size_t p_size = __builtin_object_size(p, 0);
-
 	if (__builtin_constant_p(size) && p_size < size)
 		__read_overflow();
 	if (p_size < size)
@@ -393,10 +413,10 @@ __FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
 }
 
 void *__real_memchr_inv(const void *s, int c, size_t n) __RENAME(memchr_inv);
-__FORTIFY_INLINE void *memchr_inv(const void *p, int c, size_t size)
+#define memchr_inv(p, c, s) __fortify_memchr_inv(p, c, s, __builtin_object_size(p, 0))
+__FORTIFY_INLINE void *__fortify_memchr_inv(const void *p, int c, size_t size,
+					    const size_t p_size)
 {
-	size_t p_size = __builtin_object_size(p, 0);
-
 	if (__builtin_constant_p(size) && p_size < size)
 		__read_overflow();
 	if (p_size < size)
@@ -417,10 +437,13 @@ __FORTIFY_INLINE void *kmemdup(const void *p, size_t size, gfp_t gfp)
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

