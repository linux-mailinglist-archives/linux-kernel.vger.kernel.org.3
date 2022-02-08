Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EA14AE510
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiBHWyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiBHWyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:54:08 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E18C06129A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:53:54 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so463296pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 14:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQK1jTOQeOeDcMrxpcX0+jaJoRpqKy+sYVOtLLBiOEc=;
        b=OW45Bp7/57Xj4QE3G+D4x4B7Qw9XY/omgA2TlFYKKu0kM7x7ofKtEAv9M7almXEJP8
         W2Sbcv6tGP3DHiA8LDgKmY0xoApNDn/qGeZm1vlxdpIkjHyHijdLdpv+Utb1VIDCdogy
         Bf6yHvCfgxgqxe/MJ//T+ZdrpjisNxIe5XuUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQK1jTOQeOeDcMrxpcX0+jaJoRpqKy+sYVOtLLBiOEc=;
        b=khnxO0k8h+vKyFR/ZnPCVV++5d5/A++xKwJlCFRFveoE/m1JZ45/cRKn/W97gAZ4S9
         1bkQUA7rUDOU4AHazdLCjzrI76MPJd8OUxoDH6qbwQLCY+VhXwpUqPaukFH9T0+tPcpo
         9JYyaRHMSly9eYE5z2lydAlianrjihhfCIN+KiQoZf4QcoG5z7Bu7fCalE1yGPMwYeNa
         XR6jWl5i7q7TSGtjcIod7PqHSZ1Mf7D2sV31NXf/F3CXPGg8ZFOoT6gPbzOflfxxkUbB
         D3JhAdEYCz9SBzAOkf8KrZZAAxszpR1ADHAgwebNlZWOcjpDHG6JCWzh0+nUA+GST1Sj
         iScA==
X-Gm-Message-State: AOAM530zclK2h+aNBilzWSKGe8PSixgKYlMVlPjGOH0RhjwGVSkIrVZq
        Q6RARcgCEEL1ZvvxvI0QH+EdxQ==
X-Google-Smtp-Source: ABdhPJx1p4D2Bxr/ji1hESBsVRnga6FxSEcwByFRVuDBld5q/haJdK9158wD/igkogTvD7zHE/qhaw==
X-Received: by 2002:a17:902:7489:: with SMTP id h9mr2975864pll.8.1644360833718;
        Tue, 08 Feb 2022 14:53:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mt19sm2897100pjb.32.2022.02.08.14.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 14:53:53 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v7 5/8] fortify: Make pointer arguments const
Date:   Tue,  8 Feb 2022 14:53:47 -0800
Message-Id: <20220208225350.1331628-6-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208225350.1331628-1-keescook@chromium.org>
References: <20220208225350.1331628-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5862; h=from:subject; bh=FmB3l5mJpafh4mYa40exPNAPzxH5eZCFZy/j7r/nMO4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiAvR98vwC81Z1UhGFfsPpF8zbNSOyQNmoYEvWAHHp 0ru94CGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgL0fQAKCRCJcvTf3G3AJoFjD/ 97DFYpNRt49cgBB/AX3bY1ez5hVspIyqFHLarGzB6JZvGg3Nd2PuAUwARwVQtNukRTn2+69Y/WpU3I kNODZyUzXzrS1A4qO5TF4qG5gDt8Syt9V9Z9q3g2BA36TQJSfNEympocPEmZmxFg5gfPfOL9dj7QKN VMr14TQMHO8l9eVCjCG9hTCjA62Oq13N9I1VNSURRRW4oGTY4UnyfevsVEcRKcKC7o3a/P/k1gwQQq HTeWz3PKT4MoJwFZQWG3ZznSFPrZtvcztquj2DLwt8tpEwZ3K1yADZUTowSnP4IOPz4WCuol9ePOeB 0OW35wnIcGnlZ3o4GoKhw9+VdeaA6hFhueP77D11yIVi26PQRqeqV8to/HQQOQjsG2OKLAhiaSfxgp 8+MaWeRJddvZPwBWTGScrSt7DlPcCUqOGJ2eXvR0fuOENJSctGv0yBgKYatBeTk6kLPJ9MR1CDRpuC +gO7wsZu5aZwD297RP3ivDWLUxaEcNORw7JZR17KlSlPKrUOLWrEfPLFhbe3f5szv1HOaVKfT4T/np ZC/DBOBOPfAyQSvkNp+u+zAq8mkKz65ttpexcxQipAbwQgzL+R6WK9jI2fsTC/i9IRYns8qS3N07AS pRvZYDyPYBgexB9tizqttkePsnsKDr6s0y+nHavB03QcRQEeeWk+HL02dPUg==
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

In preparation for using Clang's __pass_object_size attribute, make all
the pointer arguments to the fortified string functions const. Nothing
was changing their values anyway, so this added requirement (needed by
__pass_object_size) requires no code changes and has no impact on
the binary instruction output.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 439aad24ab3b..f874ada4b9af 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -50,7 +50,7 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 #define __underlying_strncpy	__builtin_strncpy
 #endif
 
-__FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
+__FORTIFY_INLINE char *strncpy(char * const p, const char *q, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 
@@ -61,7 +61,7 @@ __FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
 	return __underlying_strncpy(p, q, size);
 }
 
-__FORTIFY_INLINE char *strcat(char *p, const char *q)
+__FORTIFY_INLINE char *strcat(char * const p, const char *q)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 
@@ -73,7 +73,7 @@ __FORTIFY_INLINE char *strcat(char *p, const char *q)
 }
 
 extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
-__FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
+__FORTIFY_INLINE __kernel_size_t strnlen(const char * const p, __kernel_size_t maxlen)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t p_len = __compiletime_strlen(p);
@@ -94,7 +94,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
 }
 
 /* defined after fortified strnlen to reuse it. */
-__FORTIFY_INLINE __kernel_size_t strlen(const char *p)
+__FORTIFY_INLINE __kernel_size_t strlen(const char * const p)
 {
 	__kernel_size_t ret;
 	size_t p_size = __builtin_object_size(p, 1);
@@ -110,7 +110,7 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 
 /* defined after fortified strlen to reuse it */
 extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
-__FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
+__FORTIFY_INLINE size_t strlcpy(char * const p, const char * const q, size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t q_size = __builtin_object_size(q, 1);
@@ -137,7 +137,7 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
 
 /* defined after fortified strnlen to reuse it */
 extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
-__FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
+__FORTIFY_INLINE ssize_t strscpy(char * const p, const char * const q, size_t size)
 {
 	size_t len;
 	/* Use string size rather than possible enclosing struct size. */
@@ -183,7 +183,7 @@ __FORTIFY_INLINE ssize_t strscpy(char *p, const char *q, size_t size)
 }
 
 /* defined after fortified strlen and strnlen to reuse them */
-__FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
+__FORTIFY_INLINE char *strncat(char * const p, const char * const q, __kernel_size_t count)
 {
 	size_t p_len, copy_len;
 	size_t p_size = __builtin_object_size(p, 1);
@@ -354,7 +354,7 @@ __FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
 		memmove)
 
 extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
-__FORTIFY_INLINE void *memscan(void *p, int c, __kernel_size_t size)
+__FORTIFY_INLINE void *memscan(void * const p, int c, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -365,7 +365,7 @@ __FORTIFY_INLINE void *memscan(void *p, int c, __kernel_size_t size)
 	return __real_memscan(p, c, size);
 }
 
-__FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
+__FORTIFY_INLINE int memcmp(const void * const p, const void * const q, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 	size_t q_size = __builtin_object_size(q, 0);
@@ -381,7 +381,7 @@ __FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
 	return __underlying_memcmp(p, q, size);
 }
 
-__FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
+__FORTIFY_INLINE void *memchr(const void * const p, int c, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -393,7 +393,7 @@ __FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
 }
 
 void *__real_memchr_inv(const void *s, int c, size_t n) __RENAME(memchr_inv);
-__FORTIFY_INLINE void *memchr_inv(const void *p, int c, size_t size)
+__FORTIFY_INLINE void *memchr_inv(const void * const p, int c, size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -405,7 +405,7 @@ __FORTIFY_INLINE void *memchr_inv(const void *p, int c, size_t size)
 }
 
 extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup);
-__FORTIFY_INLINE void *kmemdup(const void *p, size_t size, gfp_t gfp)
+__FORTIFY_INLINE void *kmemdup(const void * const p, size_t size, gfp_t gfp)
 {
 	size_t p_size = __builtin_object_size(p, 0);
 
@@ -417,7 +417,7 @@ __FORTIFY_INLINE void *kmemdup(const void *p, size_t size, gfp_t gfp)
 }
 
 /* Defined after fortified strlen to reuse it. */
-__FORTIFY_INLINE char *strcpy(char *p, const char *q)
+__FORTIFY_INLINE char *strcpy(char * const p, const char * const q)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t q_size = __builtin_object_size(q, 1);
-- 
2.30.2

