Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78484AE50D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiBHWyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiBHWx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:53:57 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E272C06157A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:53:54 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id n32so969122pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 14:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9sVLGd3S3hpSXrZdoRFA0QjyWECsB9TYAsxBeYdirN0=;
        b=YqoIIyzseoGSPcv7FL6A6h01aqPwXRCsO84PlVeGmajFks963GlOJjVQ0/JGMWi47c
         VC86+pEokZY00s7D1fH3PuP00UcSxmGpIht5Ns7Dy/7zrIYGVLciyWsLX+xewbE3sBgd
         y4g1JKCvODDshLkNRuoI/BvyVt+c8NvCcPtPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9sVLGd3S3hpSXrZdoRFA0QjyWECsB9TYAsxBeYdirN0=;
        b=tif2Oi+Ky+jbUikg51TvdU3QPMVLdoXS6Md72i83CHkxeMU4KYN/NVDC37IC5OJYrh
         68z6ajtafVKO4Zr54X7MrIH54EXOwI5Lg1yPkqhu/+Lh1AijES3yjqljZSBK/TTMGcWQ
         JgGV0KjLYLjC/VzoD7olBCDlesJfhBNYDfE8clz8iztxy0BSu7TWZZjPlo7EI0Z4N/k4
         CTjm4K4CaKP5O7nnTU6qb/y22w03iYK0A7UrzdT4Le4q4RBjYloCBxK0tk2+CvhuoeYv
         y4DibdPem5DSAukKh2W3MPJ0h678325NN93rw/tVwdtzSK72KvfDEdJioWZWKl2qoykd
         ya5A==
X-Gm-Message-State: AOAM5335ilenmjhvubcN48ld/vnCtJDlG6sNP2D2WeKLd7M0ENBVzrUt
        79t5/HFG26VToJAmyBp638jdvQ==
X-Google-Smtp-Source: ABdhPJxEfKSmXhSY/48RY2PDraUGw/3L4r/JNoZQUDXTm9s2ZtSrysey8gycYfV/H8ugh2H8dkd8Yw==
X-Received: by 2002:a63:1d4a:: with SMTP id d10mr5304377pgm.92.1644360833859;
        Tue, 08 Feb 2022 14:53:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7sm11834105pgr.87.2022.02.08.14.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 14:53:53 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v7 8/8] fortify: Add Clang support
Date:   Tue,  8 Feb 2022 14:53:50 -0800
Message-Id: <20220208225350.1331628-9-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208225350.1331628-1-keescook@chromium.org>
References: <20220208225350.1331628-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8812; h=from:subject; bh=fIf6mUSCigQxrAs+E1mY8zvWz+tdZkkTQBiz3BhDWtA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiAvR9/eZjsKhDyevtWY2mDEJ+KjV5UgezsRwwfgdM M/64MMOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgL0fQAKCRCJcvTf3G3AJj0UD/ 4/SZy2w4IFtKkgrhXJK9Ifp0l9Sztc+AxHSe04qMIxeXVKLmt+es0pUnqFrhTh81ER1HUmiN8tZZFA AyahKMHDtUAO+wKa3JEE9GdiHU3CeI7wGsrY6wvDfhWBDhyY0kqgQIhfavxukKnsQdB7+55r7p64Tx DEdhl5cQR60gzKjwkOyMFLI1z4yZqyCxPm764ap+wWac2/uOWxwoyrtdUiyiK9XO8Ax1K89tW5mDvK j/Ut+i11Kq1NzLwKqwSAusj9QPZUrr4c6ugKk9VZAl2GGv5CJPdTLFnnmzOKSpjRRyIVOeK9H8qGLt NhpR7azMx76eNvT0BQAOIVeFhIJb7gBmjQMMxBaAuSFWU9DAbl60wGfnLmrl+pEQ3PiLKP+YdX050v ueaiHcOYLuS2CBt9a/9ZC6I55fg15ubAWvLw0dF3Hdn9/Q43MkoD6oC26/bv+Or2pji1f2YZIbtyvk msrTnckxiZ6IWvUxYU58+Lphg7R02O5DadwM5K/E/dUkXIBjfUTIKllAg2iQX3VToDwKPusPTmISTi jMAsEYmAuM14tVHhz5RaTHVYGdMFMh1+QRTSgO4soNQ+aJW2TaJAuQT0DoxuN6tNcMY84iar/tSTFl gDatIcAunlq6kLlzXr4So8GjlThxTKcSFMy19Di9SY3exXZ2SWA/31bxw1JA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable FORTIFY_SOURCE support for Clang:

Use the new __pass_object_size and __overloadable attributes so that
Clang will have appropriate visibility into argument sizes such that
__builtin_object_size(p, 1) will behave correctly. Additional details
available here:
    https://github.com/llvm/llvm-project/issues/53516
    https://github.com/ClangBuiltLinux/linux/issues/1401

A bug with __builtin_constant_p() of globally defined variables was
fixed in Clang 13 (and backported to 12.0.1), so FORTIFY support must
depend on that version or later. Additional details here:
    https://bugs.llvm.org/show_bug.cgi?id=41459
    commit a52f8a59aef4 ("fortify: Explicitly disable Clang support")

A bug with Clang's -mregparm=3 and -m32 makes some builtins unusable,
so removing -ffreestanding (to gain the needed libcall optimizations
with Clang) cannot be done. Without the libcall optimizations, Clang
cannot provide appropriate FORTIFY coverage, so it must be disabled
for CONFIG_X86_32. Additional details here;
    https://github.com/llvm/llvm-project/issues/53645

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: George Burgess IV <gbiv@google.com>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 40 ++++++++++++++++++++++------------
 security/Kconfig               |  5 +++--
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index f77cf22e2d60..295637a66c46 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -4,7 +4,7 @@
 
 #include <linux/const.h>
 
-#define __FORTIFY_INLINE extern __always_inline __gnu_inline
+#define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
 #define __RENAME(x) __asm__(#x)
 
 void fortify_panic(const char *name) __noreturn __cold;
@@ -52,8 +52,17 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 #define __underlying_strncpy	__builtin_strncpy
 #endif
 
+/*
+ * Clang's use of __builtin_object_size() within inlines needs hinting via
+ * __pass_object_size(). The preference is to only ever use type 1 (member
+ * size, rather than struct size), but there remain some stragglers using
+ * type 0 that will be converted in the future.
+ */
+#define POS	__pass_object_size(1)
+#define POS0	__pass_object_size(0)
+
 __FORTIFY_INLINE __diagnose_as(__builtin_strncpy, 1, 2, 3)
-char *strncpy(char * const p, const char *q, __kernel_size_t size)
+char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 
@@ -65,7 +74,7 @@ char *strncpy(char * const p, const char *q, __kernel_size_t size)
 }
 
 __FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
-char *strcat(char * const p, const char *q)
+char *strcat(char * const POS p, const char *q)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 
@@ -77,7 +86,7 @@ char *strcat(char * const p, const char *q)
 }
 
 extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
-__FORTIFY_INLINE __kernel_size_t strnlen(const char * const p, __kernel_size_t maxlen)
+__FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size_t maxlen)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t p_len = __compiletime_strlen(p);
@@ -106,7 +115,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const p, __kernel_size_t m
 	__builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),	\
 		__builtin_strlen(p), __fortify_strlen(p))
 __FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
-__kernel_size_t __fortify_strlen(const char * const p)
+__kernel_size_t __fortify_strlen(const char * const POS p)
 {
 	__kernel_size_t ret;
 	size_t p_size = __builtin_object_size(p, 1);
@@ -122,7 +131,7 @@ __kernel_size_t __fortify_strlen(const char * const p)
 
 /* defined after fortified strlen to reuse it */
 extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
-__FORTIFY_INLINE size_t strlcpy(char * const p, const char * const q, size_t size)
+__FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t q_size = __builtin_object_size(q, 1);
@@ -149,7 +158,7 @@ __FORTIFY_INLINE size_t strlcpy(char * const p, const char * const q, size_t siz
 
 /* defined after fortified strnlen to reuse it */
 extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
-__FORTIFY_INLINE ssize_t strscpy(char * const p, const char * const q, size_t size)
+__FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, size_t size)
 {
 	size_t len;
 	/* Use string size rather than possible enclosing struct size. */
@@ -196,7 +205,7 @@ __FORTIFY_INLINE ssize_t strscpy(char * const p, const char * const q, size_t si
 
 /* defined after fortified strlen and strnlen to reuse them */
 __FORTIFY_INLINE __diagnose_as(__builtin_strncat, 1, 2, 3)
-char *strncat(char * const p, const char * const q, __kernel_size_t count)
+char *strncat(char * const POS p, const char * const POS q, __kernel_size_t count)
 {
 	size_t p_len, copy_len;
 	size_t p_size = __builtin_object_size(p, 1);
@@ -367,7 +376,7 @@ __FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
 		memmove)
 
 extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
-__FORTIFY_INLINE void *memscan(void * const p, int c, __kernel_size_t size)
+__FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -379,7 +388,7 @@ __FORTIFY_INLINE void *memscan(void * const p, int c, __kernel_size_t size)
 }
 
 __FORTIFY_INLINE __diagnose_as(__builtin_memcmp, 1, 2, 3)
-int memcmp(const void * const p, const void * const q, __kernel_size_t size)
+int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 	size_t q_size = __builtin_object_size(q, 0);
@@ -396,7 +405,7 @@ int memcmp(const void * const p, const void * const q, __kernel_size_t size)
 }
 
 __FORTIFY_INLINE __diagnose_as(__builtin_memchr, 1, 2, 3)
-void *memchr(const void * const p, int c, __kernel_size_t size)
+void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -408,7 +417,7 @@ void *memchr(const void * const p, int c, __kernel_size_t size)
 }
 
 void *__real_memchr_inv(const void *s, int c, size_t n) __RENAME(memchr_inv);
-__FORTIFY_INLINE void *memchr_inv(const void * const p, int c, size_t size)
+__FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -420,7 +429,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const p, int c, size_t size)
 }
 
 extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup);
-__FORTIFY_INLINE void *kmemdup(const void * const p, size_t size, gfp_t gfp)
+__FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -433,7 +442,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const p, size_t size, gfp_t gfp)
 
 /* Defined after fortified strlen to reuse it. */
 __FORTIFY_INLINE __diagnose_as(__builtin_strcpy, 1, 2)
-char *strcpy(char * const p, const char * const q)
+char *strcpy(char * const POS p, const char * const POS q)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t q_size = __builtin_object_size(q, 1);
@@ -462,4 +471,7 @@ char *strcpy(char * const p, const char * const q)
 #undef __underlying_strncat
 #undef __underlying_strncpy
 
+#undef POS
+#undef POS0
+
 #endif /* _LINUX_FORTIFY_STRING_H_ */
diff --git a/security/Kconfig b/security/Kconfig
index 0b847f435beb..1d2d71cc1f36 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -177,9 +177,10 @@ config HARDENED_USERCOPY_PAGESPAN
 config FORTIFY_SOURCE
 	bool "Harden common str/mem functions against buffer overflows"
 	depends on ARCH_HAS_FORTIFY_SOURCE
-	# https://bugs.llvm.org/show_bug.cgi?id=50322
 	# https://bugs.llvm.org/show_bug.cgi?id=41459
-	depends on !CC_IS_CLANG
+	depends on !CC_IS_CLANG || CLANG_VERSION >= 120001
+	# https://github.com/llvm/llvm-project/issues/53645
+	depends on !CC_IS_CLANG || !X86_32
 	help
 	  Detect overflows of buffers in common string and memory functions
 	  where the compiler can determine and validate the buffer sizes.
-- 
2.30.2

