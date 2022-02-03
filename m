Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9221D4A8A28
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352908AbiBCRdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352892AbiBCRdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:33:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC83C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:33:10 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h12so3061375pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 09:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ohgfedv3LwtwNETDhjR036lLD285TgXCIf8rd9WVcis=;
        b=ZKq/5ytew9BK9Lh8BB4tSBlllMmYkfCVq5RReDz80vC9xYkeb3gxlImeo5sP73aszU
         F1MX8UeliIKOo/X5QSMKjUFuwKb28nVnSQAWRmp48ijuMAczEhWp4WqT/MG0VnEhqTui
         iSVNGj5LfRVfMyc5xznalktQhS8S8ELpgLlXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ohgfedv3LwtwNETDhjR036lLD285TgXCIf8rd9WVcis=;
        b=Zz73vr1edSjBxWlr7eRCW/eZp1jx/YPlYyxjfnDYmQ5HxdfOXeQ7moxt9RquCPxnSO
         5T6D94c2+LDIihw7Raa4ccID+irdPcqVZGOpKDUCYHwIOaFUqYmvUJ7VRUfJtAR4TRyy
         COSu+IzEg4HYGHdTpo7+q6+GUvq/mc94Moi8u1lExsF1FmwlrQOFAiLkzqzZq51t//DM
         D9gWpfSZkUdQQUQGTTmdlgACF4bXGCd8n8okIUu/3wVLHSCXElcXr1/5XPt/DH/Zywws
         ZocIjDOzib9mVeq1YcQEr23gUVem0UUScCiw+gQpIUNOC8yD7sN3E88PZfVOFE6RhmkK
         Zwgg==
X-Gm-Message-State: AOAM530A2QUkNYxDC5Xhr9gMPQ1ueT0hbrwLs2/INuB1tizf43tOq66g
        4vDvoB10UwkjeigtE6w2VIM7Jw==
X-Google-Smtp-Source: ABdhPJzsNyxzMdJajlX2kferYLJukTQwYeGriE8c/jigKo0VPiMicgW8v4YjlKseMqZjxCAnoRl9yQ==
X-Received: by 2002:a17:902:e74c:: with SMTP id p12mr24215988plf.115.1643909589981;
        Thu, 03 Feb 2022 09:33:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a3sm29194310pfk.73.2022.02.03.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:33:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v6 4/4] fortify: Add Clang support
Date:   Thu,  3 Feb 2022 09:33:07 -0800
Message-Id: <20220203173307.1033257-5-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203173307.1033257-1-keescook@chromium.org>
References: <20220203173307.1033257-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9118; h=from:subject; bh=uLvObXCa+adv21+oycDwxFQbsQPVkjm/KcsEJAaVL24=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh/BHSRAe50TfqZrZ5b0CNzhS6YwX2RSr5uLu8PnaW 83nmD7uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfwR0gAKCRCJcvTf3G3AJmFOD/ 9dEzcmHLz8Z5AvIisKzABHSI10XiJsEDXvPZaL+ApPvNb3rXZvruQSSk4mD5ey2wzLvhhhscHzI9/a 8Qkn/Qn0MeGULVHxs4ELBiuLaU5Bqgj5ktVPfOw/frDALuyuELU7D5U3fSI9m8hSbOsqRweqSnWeVB TweDP4g472HILclqF44oZ57W2UDFTC8NE1c9HuCsNilCPZ08l/v/QHVPcHpnZY4FruGBAy0uV099F+ KVDpSzmMiv6ErQQM3hqderKgG/2BsnE5HkSLC2dArLdmge686MF+ivACiQp7fM7C5SujNfxTRw4Iqt mJJ/UBr7OoEHBPRLw9Gy0/qgkioHPKCX7cZQP3Nh1UB+kxzAejQDrorU0zmdgJ06GgVWbrv9++h6MX 9pYPK2nxGlwzxo3fBJmYosDkQrRVhM/LL+/2C8vjLeW03Ey0CjFjO76nxW0tuL8X49xtR7zJpKaZ6Y nmNPYJ6UgU8uGwGQJFjYOVnzHTq9ASCFoSlMSKZPFS8Y028G7HaIXJpdGi5yCfQgluHGgbHtHXIzbm 9+/24plGAJOCRBE6SyELvJ5pUiBmsmYnli6yajJKL0lAUjeONI+5gnfxMZR6xFQc4HKcYlU97EPasa FSiiBpm1jDK3c5uzIrWv/NiwigQ6mWUHPWHHnYTOPHNo5vj5oDB/JqOpuQ0g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable FORTIFY_SOURCE support for Clang:

Use the new __pass_object_size and __overloadable attributes so
that Clang will have appropriate visibility into argument sizes such
that __builtin_object_size(p, 1) will behave correctly. Additional
details here:
    https://github.com/llvm/llvm-project/issues/53516
    https://github.com/ClangBuiltLinux/linux/issues/1401

When available, use the new __diagnose_as attribute to make sure no
compile-time diagnostic warnings are lost due to the effectively renamed
string functions.

Redefine strlen() as a macro that tests for being a constant expression
so that strlen() can still be used in static initializers, which was
lost when adding __pass_object_size and __overloadable.

Finally, a bug with __builtin_constant_p() of globally defined variables
was fixed in Clang 13 (and backported to 12.0.1), so FORTIFY support
must depend on that version or later. Additional details here:
    https://bugs.llvm.org/show_bug.cgi?id=41459
    commit a52f8a59aef4 ("fortify: Explicitly disable Clang support")

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: George Burgess IV <gbiv@google.com>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 58 +++++++++++++++++++++++++---------
 security/Kconfig               |  3 +-
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index c45159dbdaa1..2ffe4f2f79eb 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -2,7 +2,9 @@
 #ifndef _LINUX_FORTIFY_STRING_H_
 #define _LINUX_FORTIFY_STRING_H_
 
-#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
+#include <linux/const.h>
+
+#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline)) __overloadable
 #define __RENAME(x) __asm__(#x)
 
 void fortify_panic(const char *name) __noreturn __cold;
@@ -50,7 +52,17 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 #define __underlying_strncpy	__builtin_strncpy
 #endif
 
-__FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
+/*
+ * Clang's use of __builtin_object_size() within inlines needs hinting via
+ * __pass_object_size(). The preference is to only ever use type 1 (member
+ * size, rather than struct size), but there remain some stragglers using
+ * type 0 that will be converted in the future.
+ */
+#define POS	__pass_object_size(1)
+#define POS0	__pass_object_size(0)
+
+__FORTIFY_INLINE __diagnose_as(__builtin_strncpy, 1, 2, 3)
+char *strncpy(char * POS p, const char *q, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 
@@ -61,7 +73,8 @@ __FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
 	return __underlying_strncpy(p, q, size);
 }
 
-__FORTIFY_INLINE char *strcat(char *p, const char *q)
+__FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
+char *strcat(char * POS p, const char *q)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 
@@ -73,7 +86,7 @@ __FORTIFY_INLINE char *strcat(char *p, const char *q)
 }
 
 extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
-__FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
+__FORTIFY_INLINE __kernel_size_t strnlen(const char * POS p, __kernel_size_t maxlen)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t p_len = __compiletime_strlen(p);
@@ -93,8 +106,16 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
 	return ret;
 }
 
-/* defined after fortified strnlen to reuse it. */
-__FORTIFY_INLINE __kernel_size_t strlen(const char *p)
+/*
+ * Defined after fortified strnlen to reuse it. However, it must still be
+ * possible for strlen() to be used on compile-time strings for use in
+ * static initializers (i.e. as a constant expression).
+ */
+#define strlen(p)							\
+	__builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),	\
+		__builtin_strlen(p), __fortify_strlen(p))
+__FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
+__kernel_size_t __fortify_strlen(const char * POS p)
 {
 	__kernel_size_t ret;
 	size_t p_size = __builtin_object_size(p, 1);
@@ -110,7 +131,7 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 
 /* defined after fortified strlen to reuse it */
 extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
-__FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
+__FORTIFY_INLINE size_t strlcpy(char * POS p, const char * POS q, size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t q_size = __builtin_object_size(q, 1);
@@ -137,7 +158,7 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
 
 /* defined after fortified strnlen to reuse it */
 extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
-__FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
+__FORTIFY_INLINE ssize_t strscpy(char * POS p, const char * POS q, size_t size)
 {
 	size_t len;
 	/* Use string size rather than possible enclosing struct size. */
@@ -183,7 +204,8 @@ __FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
 }
 
 /* defined after fortified strlen and strnlen to reuse them */
-__FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
+__FORTIFY_INLINE __diagnose_as(__builtin_strncat, 1, 2, 3)
+char *strncat(char * POS p, const char * POS q, __kernel_size_t count)
 {
 	size_t p_len, copy_len;
 	size_t p_size = __builtin_object_size(p, 1);
@@ -354,7 +376,7 @@ __FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
 		memmove)
 
 extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
-__FORTIFY_INLINE void *memscan(void *p, int c, __kernel_size_t size)
+__FORTIFY_INLINE void *memscan(void * POS0 p, int c, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -365,7 +387,8 @@ __FORTIFY_INLINE void *memscan(void *p, int c, __kernel_size_t size)
 	return __real_memscan(p, c, size);
 }
 
-__FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
+__FORTIFY_INLINE __diagnose_as(__builtin_memcmp, 1, 2, 3)
+int memcmp(const void * POS0 p, const void * POS0 q, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 	size_t q_size = __builtin_object_size(q, 0);
@@ -381,7 +404,8 @@ __FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
 	return __underlying_memcmp(p, q, size);
 }
 
-__FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
+__FORTIFY_INLINE __diagnose_as(__builtin_memchr, 1, 2, 3)
+void *memchr(const void * POS0 p, int c, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -393,7 +417,7 @@ __FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
 }
 
 void *__real_memchr_inv(const void *s, int c, size_t n) __RENAME(memchr_inv);
-__FORTIFY_INLINE void *memchr_inv(const void *p, int c, size_t size)
+__FORTIFY_INLINE void *memchr_inv(const void * POS0 p, int c, size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -405,7 +429,7 @@ __FORTIFY_INLINE void *memchr_inv(const void *p, int c, size_t size)
 }
 
 extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup);
-__FORTIFY_INLINE void *kmemdup(const void *p, size_t size, gfp_t gfp)
+__FORTIFY_INLINE void *kmemdup(const void * POS0 p, size_t size, gfp_t gfp)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -417,7 +441,8 @@ __FORTIFY_INLINE void *kmemdup(const void *p, size_t size, gfp_t gfp)
 }
 
 /* Defined after fortified strlen to reuse it. */
-__FORTIFY_INLINE char *strcpy(char *p, const char *q)
+__FORTIFY_INLINE __diagnose_as(__builtin_strcpy, 1, 2)
+char *strcpy(char * POS p, const char * POS q)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t q_size = __builtin_object_size(q, 1);
@@ -446,4 +471,7 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
 #undef __underlying_strncat
 #undef __underlying_strncpy
 
+#undef POS0
+#undef POS
+
 #endif /* _LINUX_FORTIFY_STRING_H_ */
diff --git a/security/Kconfig b/security/Kconfig
index 0b847f435beb..c125026ed088 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -177,9 +177,8 @@ config HARDENED_USERCOPY_PAGESPAN
 config FORTIFY_SOURCE
 	bool "Harden common str/mem functions against buffer overflows"
 	depends on ARCH_HAS_FORTIFY_SOURCE
-	# https://bugs.llvm.org/show_bug.cgi?id=50322
 	# https://bugs.llvm.org/show_bug.cgi?id=41459
-	depends on !CC_IS_CLANG
+	depends on !CC_IS_CLANG || CLANG_VERSION >= 120001
 	help
 	  Detect overflows of buffers in common string and memory functions
 	  where the compiler can determine and validate the buffer sizes.
-- 
2.30.2

