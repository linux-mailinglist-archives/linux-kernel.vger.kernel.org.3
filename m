Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A423C5AB992
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 22:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiIBUoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 16:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiIBUn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:43:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82927FBA50
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 13:43:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 199so3034948pfz.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GpdR6dhKOYDIHWBT59g1Wvjno+duAayEnuXKzDvi7Ds=;
        b=h749UXyzLbcoxluZ9NcjTjAgLd1HqAnSuGDh0as6NFUu5+tf/+dIsD3GaQHzP85DCQ
         09TV1a6urYRynR0mKtclPQQbcxqeEKPmeDNKC4wGNBbIW07+epZ5tIBpNYrPTpzFC2TJ
         x48QAdCJADJFdnY5OKcR4y54nPl9qtoP2R10U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GpdR6dhKOYDIHWBT59g1Wvjno+duAayEnuXKzDvi7Ds=;
        b=0KeCuaVCFo5o4lov0WuviqyWpF/VXrHEW27JB57NOR0R51dxvOTR9T4/kHrHwJ9Tm3
         cf0nLXW4xj9Rcw7UZxG/gfx7/V6AsXcHf/5B3Ns1znSJlUJWzm9VDIUZuiOkkc0Muw5l
         EU8LKulUP6DDep0ZicpHyWUG08iHcxE5+aIYEg/SlthG4TWUhkPqSEEeMekI6eT8lj3G
         jxh20Qf1tw4JZ0yKR9uC7nvypWdu1mHNeoqA4beVcwkcDm7G/znMWYI2LHilcbx5A5aj
         f1q2meuI0tc+RAf54fKp90jfB87RzJkSBJ/vBU8PZmPxYqghQolHBqlxwKccDDaxE7zr
         vneg==
X-Gm-Message-State: ACgBeo17XirB2ZeCE+4TUX7ToyODwdOWKq8vh0AHjRjQD8EcsPVAnl7l
        fDol/eBm/o/eeqEBkH8DmQWLOA==
X-Google-Smtp-Source: AA6agR5IhZwbrCaOXKK1TWm9SsIGoXh0AjdQgm3ck3mlstEsQ9cd19CWxuvtbfxICBszMpFtEUiUXw==
X-Received: by 2002:a63:5616:0:b0:42b:689e:5166 with SMTP id k22-20020a635616000000b0042b689e5166mr31058897pgb.385.1662151436997;
        Fri, 02 Sep 2022 13:43:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k1-20020aa79981000000b005380bbac1ccsm2261188pfh.167.2022.09.02.13.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:43:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        David Gow <davidgow@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 3/3] fortify: Use SIZE_MAX instead of (size_t)-1
Date:   Fri,  2 Sep 2022 13:43:51 -0700
Message-Id: <20220902204351.2521805-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902204351.2521805-1-keescook@chromium.org>
References: <20220902204351.2521805-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4790; h=from:subject; bh=HV5Dy8SZEhq6+/rQqbYutEFxTR8zxek5M5kiisvIgH0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjEmsHLCqUbdwiDj2xEYoNTUzHnhPqUNltCgBybyug nZykpLGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxJrBwAKCRCJcvTf3G3AJuA8D/ 48wah7w3V7SEe1dfMKosk2R/dJEjm+HloADoGeQcgeJsYUmLb3VdRAyMxQO70fb3fFAy39o4tOwBoV 0jcF/qjB0kiiDz7rcaxgd4uo7AeRFLELhvjvuYAe9/EI/Tt4Ja8dqknh1xtALnbQuLUs1CGc3XSXGY DtcSIHoy+EJ13pdt3x8qfinqRE/my6F0B/x01+qpg6id8Gw7bLinKrzvwiwRfx+QcfwquTpp938j0W dYQma5DIva2bGK9lIrIIXTdXxYBQkKz4C86REXQPnFql+3Xa0JBpNORkKxxzCE9T6TuP/ZJeU4WYU4 NEM/NWTds28XCIZoqqFNQrtbuc368abzR7G5j2/+7wQD+3IbszmmfqVW0SO/UE5h2oFP46FrgtKDtL XNSXnlruH30OGg1cUunNluV62Oefkp0rydIRtoMsRTN359fgVum+FBDjr4kv///t4VVfhohKfEpH2F Pq0RZbO50IWdRvDtFjlRwzjLChWbaEkvz4ktp+Bx6AHOXcEYMPJDcuYmsZj9x51+D2MEoSqu4RrC0S Y1EsCJhMBsavWbzDQAKUN6oZLBWYh+ADgttRwT5s850pn2uDbc3iClEbXV1og9jRzPiKaTmsi3LuhA a2LaW66FJc3yiTixFJzeAP8YRfTsG4bTLFoV3i0cvAsHCqP0pBs6f34W49Xw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up uses of "(size_t)-1" in favor of SIZE_MAX.

Cc: linux-hardening@vger.kernel.org
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 07d5d1921eff..8f2b6b1cb848 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -17,9 +17,9 @@ void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("
 #define __compiletime_strlen(p)					\
 ({								\
 	unsigned char *__p = (unsigned char *)(p);		\
-	size_t __ret = (size_t)-1;				\
+	size_t __ret = SIZE_MAX;				\
 	size_t __p_size = __builtin_object_size(p, 1);		\
-	if (__p_size != (size_t)-1 &&				\
+	if (__p_size != SIZE_MAX &&				\
 	    __builtin_constant_p(*__p)) {			\
 		size_t __p_len = __p_size - 1;			\
 		if (__builtin_constant_p(__p[__p_len]) &&	\
@@ -125,7 +125,7 @@ char *strcat(char * const POS p, const char *q)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 
-	if (p_size == (size_t)-1)
+	if (p_size == SIZE_MAX)
 		return __underlying_strcat(p, q);
 	if (strlcat(p, q, p_size) >= p_size)
 		fortify_panic(__func__);
@@ -140,7 +140,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 	size_t ret;
 
 	/* We can take compile-time actions when maxlen is const. */
-	if (__builtin_constant_p(maxlen) && p_len != (size_t)-1) {
+	if (__builtin_constant_p(maxlen) && p_len != SIZE_MAX) {
 		/* If p is const, we can use its compile-time-known len. */
 		if (maxlen >= p_size)
 			return p_len;
@@ -168,7 +168,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 	size_t p_size = __builtin_object_size(p, 1);
 
 	/* Give up if we don't know how large p is. */
-	if (p_size == (size_t)-1)
+	if (p_size == SIZE_MAX)
 		return __underlying_strlen(p);
 	ret = strnlen(p, p_size);
 	if (p_size <= ret)
@@ -185,7 +185,7 @@ __FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, si
 	size_t q_len;	/* Full count of source string length. */
 	size_t len;	/* Count of characters going into destination. */
 
-	if (p_size == (size_t)-1 && q_size == (size_t)-1)
+	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
 		return __real_strlcpy(p, q, size);
 	q_len = strlen(q);
 	len = (q_len >= size) ? size - 1 : q_len;
@@ -213,7 +213,7 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 	size_t q_size = __builtin_object_size(q, 1);
 
 	/* If we cannot get size of p and q default to call strscpy. */
-	if (p_size == (size_t) -1 && q_size == (size_t) -1)
+	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
 		return __real_strscpy(p, q, size);
 
 	/*
@@ -258,7 +258,7 @@ char *strncat(char * const POS p, const char * const POS q, __kernel_size_t coun
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t q_size = __builtin_object_size(q, 1);
 
-	if (p_size == (size_t)-1 && q_size == (size_t)-1)
+	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
 		return __underlying_strncat(p, q, count);
 	p_len = strlen(p);
 	copy_len = strnlen(q, count);
@@ -299,10 +299,10 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
 	/*
 	 * Always stop accesses beyond the struct that contains the
 	 * field, when the buffer's remaining size is known.
-	 * (The -1 test is to optimize away checks where the buffer
+	 * (The SIZE_MAX test is to optimize away checks where the buffer
 	 * lengths are unknown.)
 	 */
-	if (p_size != (size_t)(-1) && p_size < size)
+	if (p_size != SIZE_MAX && p_size < size)
 		fortify_panic("memset");
 }
 
@@ -393,11 +393,11 @@ __FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
 	/*
 	 * Always stop accesses beyond the struct that contains the
 	 * field, when the buffer's remaining size is known.
-	 * (The -1 test is to optimize away checks where the buffer
+	 * (The SIZE_MAX test is to optimize away checks where the buffer
 	 * lengths are unknown.)
 	 */
-	if ((p_size != (size_t)(-1) && p_size < size) ||
-	    (q_size != (size_t)(-1) && q_size < size))
+	if ((p_size != SIZE_MAX && p_size < size) ||
+	    (q_size != SIZE_MAX && q_size < size))
 		fortify_panic(func);
 }
 
@@ -496,7 +496,7 @@ char *strcpy(char * const POS p, const char * const POS q)
 	size_t size;
 
 	/* If neither buffer size is known, immediately give up. */
-	if (p_size == (size_t)-1 && q_size == (size_t)-1)
+	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
 		return __underlying_strcpy(p, q);
 	size = strlen(q) + 1;
 	/* Compile-time check for const size overflow. */
-- 
2.34.1

