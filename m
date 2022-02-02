Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A9B4A6941
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243471AbiBBAas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243371AbiBBAah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:30:37 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC703C061741
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:30:36 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id r137so1176986pgr.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 16:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VjrCPTgmmaKb3y/ZOM5Yq/YGquEY9NIxxYzo4REsL+A=;
        b=b/zacnqWCilFkrdeG/bENv7niD5ssPV4upXLdgRBbFvmZe+0O24r2k94ELOZM+7VQd
         EQO9R/Ieqn+kWjMdHGu/AKAR0R5yKArK3q/KbZzm0dPcpYk6Cn8hcru5R3bjeC4oukKN
         ea3ivYU0wuUD9zb6aj384J9Zf7+50z2ewR480=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VjrCPTgmmaKb3y/ZOM5Yq/YGquEY9NIxxYzo4REsL+A=;
        b=msvWAmJ9sxGtEpiJr5/03S6Sqo8PIpX+STtyyahawgcgmyNq8h+nJLfpv2ZhDM7mVK
         wAbNFzHl0HGkLfmjmC4Nq+4ccVGWEHvs1IclRGRdQgYfOW00rkue/dmwlMOUkleHw1xe
         hG4ur6ucmJWnJgo/l8Ki0xOR439LLj5jfh0kHwW1YWwjvZRUqztC5xupUxtv0oStFZo/
         zO2CmCutXOvphZaiYsQ0RBgLlk6o41eoULCF9eDXaHCINdPtEtIMsCcxvO0qL4c2szxI
         chdCTYWaq8biuFZEVD8xfZ5HaZjYS0kkYMFoGdLOlfhkoGyYl3QPgRYPCffYbb6+dFWk
         Zvgw==
X-Gm-Message-State: AOAM533evQbvF5OjpKfMycES9VgyXkaOGUDNqgucDJzYtu2VaN0G0VV3
        xIBgnF/zbnd4YHe1iKgi51nvWA==
X-Google-Smtp-Source: ABdhPJwKfMKHgtPbIeBl1AOuyxfFJBygOcjBsEYx4YMSRW95KxnHg/QjUq3OGwzIGJXkow4ZvokxdA==
X-Received: by 2002:aa7:9682:: with SMTP id f2mr27769999pfk.56.1643761836333;
        Tue, 01 Feb 2022 16:30:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id kb18sm4478710pjb.30.2022.02.01.16.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 16:30:35 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 4/4 v5] fortify: Add Clang support
Date:   Tue,  1 Feb 2022 16:30:33 -0800
Message-Id: <20220202003033.704951-5-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202003033.704951-1-keescook@chromium.org>
References: <20220202003033.704951-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8693; h=from:subject; bh=SqgzThQs8OQJdMsO9DeWzbUuEtfG/wphz7be5vg/zTA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh+dCoJxlB2ynAofG2ml7SHWgTF9x+jA4GWAP6eKea B1W0cvaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfnQqAAKCRCJcvTf3G3AJnYSD/ 9qfvmCRDs9vYWcHXT8jQlo5ViGbkrqp8D30tuRx3GwRHvXpdulxGExMnJaaehX3Q61rIGmgtF1t64O lZv7RoqJhfFZsiDnHAi1LhopRzSb6g3Svf3zGRJVNTQuLFfRTNaA1fne/XPa17VX8FFr2xJfmaXH+R l3vYqfN9OAos06btMuJ0iwAQ+m5hyzsDIxHYvpfZbxCnEqg6b45b2gd3iiSur0nANFHldvx+QZRrWr rjzxN8/puejVdkfM4cJdahxAR4KLp35znd5zVaabHb3cLKsbudphiENo2P/yiuTll6wWGapD0vb1xs ShNdM7FlK1junmA01KGeieaNTcix3fqUG9Hpo+dT7wrT8d+4WVMJyuJsYZGnQ/S1Jtec1rHRa90LN3 nZnTWxKdncW0/nhba4af35A4qbaq7+4qhTNPKuNbM8Oeej5cvUOiKV8ZqY9JovLML2z0lE05KvI3fj fPGHkoIhXDvUwaI8nFG8kxXXzSxM8J8H+ZUHIVbbG5Y/n1ZRw5AGQDEvjcWLPB29ETU/K1fj+HNeVi rFGxh4ITfN9OnUI8XJLIXUsOMFYMLh6QXdWWgnsDk0DV/O4cZSkW5nZMmMQFu331KzItYLI0fa228K kt2LuGtHbjGnVkj3wkoECUB7tMNkFeRRUlooV7BEY236CEeNzlWgBd106Tfg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable FORTIFY_SOURCE support for Clang:

Use the new __pass_object_size and __overloadable attributes so
that Clang will have appropriate visibility into argument types such
that __builtin_object_size(p, 1) will behave correctly. Additional
details here:
    https://github.com/llvm/llvm-project/issues/53516
    https://github.com/ClangBuiltLinux/linux/issues/1401

Use the new __diagnose_as attribute to make sure no compile-time
diagnostic warnings are lost due to the effectively renamed string
functions.

Redefine strlen() as a macro that tests for being a constant expression
so that strlen() can still be used in static initializers, which was
lost when adding __pass_object_size and __overloadable.

Finally, a bug with __builtin_constant_p() of globally defined variables
was fixed in Clang 13, so FORTIFY support must depend on that version or
later. Additional details here:
    https://bugs.llvm.org/show_bug.cgi?id=41459
    commit a52f8a59aef4 ("fortify: Explicitly disable Clang support")

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: George Burgess IV <gbiv@google.com>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 52 ++++++++++++++++++++++++----------
 security/Kconfig               |  2 +-
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index c45159dbdaa1..5482536d3197 100644
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
@@ -50,7 +52,11 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 #define __underlying_strncpy	__builtin_strncpy
 #endif
 
-__FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
+#define BOS	const __pass_object_size(1)
+#define BOS0	const __pass_object_size(0)
+
+__FORTIFY_INLINE __diagnose_as(__builtin_strncpy, 1, 2, 3)
+char *strncpy(char * BOS p, const char *q, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 
@@ -61,7 +67,8 @@ __FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
 	return __underlying_strncpy(p, q, size);
 }
 
-__FORTIFY_INLINE char *strcat(char *p, const char *q)
+__FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
+char *strcat(char * BOS p, const char *q)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 
@@ -73,7 +80,7 @@ __FORTIFY_INLINE char *strcat(char *p, const char *q)
 }
 
 extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
-__FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
+__FORTIFY_INLINE __kernel_size_t strnlen(const char * BOS p, __kernel_size_t maxlen)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t p_len = __compiletime_strlen(p);
@@ -93,8 +100,16 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
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
+__kernel_size_t __fortify_strlen(const char * BOS p)
 {
 	__kernel_size_t ret;
 	size_t p_size = __builtin_object_size(p, 1);
@@ -110,7 +125,7 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 
 /* defined after fortified strlen to reuse it */
 extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
-__FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
+__FORTIFY_INLINE size_t strlcpy(char * BOS p, const char * BOS q, size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t q_size = __builtin_object_size(q, 1);
@@ -137,7 +152,7 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
 
 /* defined after fortified strnlen to reuse it */
 extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
-__FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
+__FORTIFY_INLINE ssize_t strscpy(char * BOS p, const char * BOS q, size_t size)
 {
 	size_t len;
 	/* Use string size rather than possible enclosing struct size. */
@@ -183,7 +198,8 @@ __FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
 }
 
 /* defined after fortified strlen and strnlen to reuse them */
-__FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
+__FORTIFY_INLINE __diagnose_as(__builtin_strncat, 1, 2, 3)
+char *strncat(char * BOS p, const char * BOS q, __kernel_size_t count)
 {
 	size_t p_len, copy_len;
 	size_t p_size = __builtin_object_size(p, 1);
@@ -354,7 +370,7 @@ __FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
 		memmove)
 
 extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
-__FORTIFY_INLINE void *memscan(void *p, int c, __kernel_size_t size)
+__FORTIFY_INLINE void *memscan(void * BOS0 p, int c, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -365,7 +381,8 @@ __FORTIFY_INLINE void *memscan(void *p, int c, __kernel_size_t size)
 	return __real_memscan(p, c, size);
 }
 
-__FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
+__FORTIFY_INLINE __diagnose_as(__builtin_memcmp, 1, 2, 3)
+int memcmp(const void * BOS0 p, const void * BOS0 q, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 	size_t q_size = __builtin_object_size(q, 0);
@@ -381,7 +398,8 @@ __FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
 	return __underlying_memcmp(p, q, size);
 }
 
-__FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
+__FORTIFY_INLINE __diagnose_as(__builtin_memchr, 1, 2, 3)
+void *memchr(const void * BOS0 p, int c, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -393,7 +411,7 @@ __FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
 }
 
 void *__real_memchr_inv(const void *s, int c, size_t n) __RENAME(memchr_inv);
-__FORTIFY_INLINE void *memchr_inv(const void *p, int c, size_t size)
+__FORTIFY_INLINE void *memchr_inv(const void * BOS0 p, int c, size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -405,7 +423,7 @@ __FORTIFY_INLINE void *memchr_inv(const void *p, int c, size_t size)
 }
 
 extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup);
-__FORTIFY_INLINE void *kmemdup(const void *p, size_t size, gfp_t gfp)
+__FORTIFY_INLINE void *kmemdup(const void * BOS0 p, size_t size, gfp_t gfp)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -417,7 +435,8 @@ __FORTIFY_INLINE void *kmemdup(const void *p, size_t size, gfp_t gfp)
 }
 
 /* Defined after fortified strlen to reuse it. */
-__FORTIFY_INLINE char *strcpy(char *p, const char *q)
+__FORTIFY_INLINE __diagnose_as(__builtin_strcpy, 1, 2)
+char *strcpy(char * BOS p, const char * BOS q)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t q_size = __builtin_object_size(q, 1);
@@ -446,4 +465,7 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
 #undef __underlying_strncat
 #undef __underlying_strncpy
 
+#undef BOS0
+#undef BOS
+
 #endif /* _LINUX_FORTIFY_STRING_H_ */
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

