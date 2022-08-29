Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A615A5667
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiH2VqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiH2Vpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:45:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF0B83BC7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:45:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 142so9471199pfu.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=tgKYtfz0+ofnlQt/cZyykhEDIvh/VtIWYc9S2+pj5U4=;
        b=erjj39SJbcZuI0rUrYdxRWRiEhiW6uDDIbI+5yUkTs4Ye0aG9zLhrtpCw+UcOYr1Cy
         vRaqIxXIpFuTQVq0QoY5QCxJ5xQuXmwI5w8HQ1EBnD4w2caR7ecH86lHzapU4LHONvGt
         4AKSoq41YcH+7NLzNtuugwjTAcS7sRQqbjFMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=tgKYtfz0+ofnlQt/cZyykhEDIvh/VtIWYc9S2+pj5U4=;
        b=BVg0HiQmmFlvv4cGyveczya1eQn5/8vHdkHNDIPw0U4pJhJlWK/Yenm33mESnljSAg
         t7R9c+IpbqreXQwdOUcIWAcqZUpAm4walzbheOuqR2qqszAowFW6C+CDJWf/223PsHyK
         G1BuSHpvC30wo/Yj3xWGhecbH/5cfSIdaV9SfrKLMzdU6ojsracqvs7bFBFMDTVdWVXN
         F8rfTbht2fJrWLrLF87BIQ/nuOoh3MmKqVHtYwTBLg53QtTl4XLXtf+/yQu22OGvQKCc
         XiIv5IZhXF7eiW3MfhvwHH/95YdWgP+0bWY1hHTbh8+98avOkhrK6C+nQtrw9UNKoe7m
         Ktcg==
X-Gm-Message-State: ACgBeo3CKVuasES34tnmpuF41kM3aA9neXTi5wVe/SNTVg69b+L+6dpP
        265om6kEsO4kDQnEe3tGPqSBag==
X-Google-Smtp-Source: AA6agR65Rc91JEACAIyXI+j68xCPS+LehxFNkcGstqVz+PXE7jMRwQtOgdHXzNIX2faY+l7ee7DArg==
X-Received: by 2002:a63:83c7:0:b0:42b:b618:31b4 with SMTP id h190-20020a6383c7000000b0042bb61831b4mr9282955pge.607.1661809553335;
        Mon, 29 Aug 2022 14:45:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090332d200b001713af9e85dsm2253676plr.180.2022.08.29.14.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 14:45:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] overflow: Allow mixed type arguments
Date:   Mon, 29 Aug 2022 14:45:50 -0700
Message-Id: <20220829214550.3443472-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6808; h=from:subject; bh=89NoQjK5rnJbPOjuozbXjNye+3cgLGAMQ5ZaTyQE0Ew=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjDTOOMf5Mphca1BC83eAFpjtkrGV8OjGx8s0Ij7vl c4kXJiGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYw0zjgAKCRCJcvTf3G3AJgKAD/ wIQFXDBP5M1a15Nc5ihtagcUClCq0FSHiM8WwKvTr2qgiGQkndwkSXWDsD1N4RdxCtFoe6SRtyZZvn 1HOowwijiPY1GX3jBU30JV4AwC0HVnnVTZ2ARZsYJowhTgKta4I5SUaHBZJw9mYFq46SH5zgbMIDGO vEjhq1bkX3GVCB94UrfH/D+J3AMTCeose9FW6m4W4ffO/MrK3nzDr3ehsPPjj6192rMkHnC6eShJqb k7iM4y4ae6qmwfGNgaiZwBMWu0daYmy4i+HItq+RrWIDh3mZceOUFBXerqaDRSrZhqRSyfZVKwsUe3 g0LW9ad0LzFXXPOLyGI4kCD8N8tSZCR0FuB+LGOD+CfP4e9Zi9GUYl87592ZOsaCEjLSl5MN7AzaoV EkoTRjHespOY6etWgGzx29yqCyCKrVQZ/wvoC+J2LZMVhzkP2OiV3w9XXMUSxhweDLjwk0NTHIPzS/ g0kBqzwWDGT5gZXuyUM6t8gJB4e1CT6wIB7+klw97RlVg+DX1FIsJjaAjCvpqs+Du4iq97V/cVNaSH lO0496sOCThudOLONocDsbybcVhcXFQCWhew+CY1uWLIPGZC5eFkJuMZRW8flQCADOtD9FQcxWgAkh Sxh2PEes/XyBovkIkDnZAeKOtaui/ahtPKPzEig/wWExb7TM2RERwhooraPQ==
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

When the check_[op]_overflow() helpers were introduced, all arguments were
required to be the same type to make the fallback macros simpler. However,
once the fallback macros were removed[1], it is fine to allow mixed
types, which makes using the helpers much more useful, as they can be
used to test for type-based overflows (e.g. adding two large ints but
storing into a u8), as would be handy in the drm core[2].

Remove the restriction, and add additional self-tests that exercise some
of the mixed-type overflow cases.

[1] https://git.kernel.org/linus/4eb6bd55cfb22ffc20652732340c4962f3ac9a91
[2] https://lore.kernel.org/lkml/20220824084514.2261614-2-gwan-gyeong.mun@intel.com

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: change names to "type1_type2__output-type" for better readability (Rasmus)
v1: https://lore.kernel.org/lkml/20220829204729.3409270-1-keescook@chromium.org
---
 include/linux/overflow.h |  6 ----
 lib/overflow_kunit.c     | 77 +++++++++++++++++++++++++++++-----------
 2 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 0eb3b192f07a..ad692fb11bf3 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -63,8 +63,6 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	typeof(a) __a = (a);			\
 	typeof(b) __b = (b);			\
 	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
 	__builtin_add_overflow(__a, __b, __d);	\
 }))
 
@@ -72,8 +70,6 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	typeof(a) __a = (a);			\
 	typeof(b) __b = (b);			\
 	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
 	__builtin_sub_overflow(__a, __b, __d);	\
 }))
 
@@ -81,8 +77,6 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	typeof(a) __a = (a);			\
 	typeof(b) __b = (b);			\
 	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
 	__builtin_mul_overflow(__a, __b, __d);	\
 }))
 
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 7e3e43679b73..5e1b51d42e93 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -16,12 +16,15 @@
 #include <linux/types.h>
 #include <linux/vmalloc.h>
 
-#define DEFINE_TEST_ARRAY(t)			\
-	static const struct test_ ## t {	\
-		t a, b;				\
-		t sum, diff, prod;		\
-		bool s_of, d_of, p_of;		\
-	} t ## _tests[]
+#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)			\
+	static const struct test_ ## t1 ## _ ## t2 ## __ ## t {	\
+		t1 a;						\
+		t2 b;						\
+		t sum, diff, prod;				\
+		bool s_of, d_of, p_of;				\
+	} t1 ## _ ## t2 ## __ ## t ## _tests[]
+
+#define DEFINE_TEST_ARRAY(t)	DEFINE_TEST_ARRAY_TYPED(t, t, t)
 
 DEFINE_TEST_ARRAY(u8) = {
 	{0, 0, 0, 0, 0, false, false, false},
@@ -235,8 +238,8 @@ DEFINE_TEST_ARRAY(s64) = {
 		a, b, r, _r, #t);				\
 } while (0)
 
-#define DEFINE_TEST_FUNC(t, fmt)					\
-static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p) \
+#define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
+static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
 {							   		\
 	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
 	check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	\
@@ -245,15 +248,18 @@ static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p) \
 	check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	\
 }									\
 									\
-static void t ## _overflow_test(struct kunit *test) {			\
+static void n ## _overflow_test(struct kunit *test) {			\
 	unsigned i;							\
 									\
-	for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)			\
-		do_test_ ## t(test, &t ## _tests[i]);			\
+	for (i = 0; i < ARRAY_SIZE(n ## _tests); ++i)			\
+		do_test_ ## n(test, &n ## _tests[i]);			\
 	kunit_info(test, "%zu %s arithmetic tests finished\n",		\
-		ARRAY_SIZE(t ## _tests), #t);				\
+		ARRAY_SIZE(n ## _tests), #n);				\
 }
 
+#define DEFINE_TEST_FUNC(t, fmt)					\
+	DEFINE_TEST_FUNC_TYPED(t ## _ ## t ## __ ## t, t, fmt)
+
 DEFINE_TEST_FUNC(u8, "%d");
 DEFINE_TEST_FUNC(s8, "%d");
 DEFINE_TEST_FUNC(u16, "%d");
@@ -265,6 +271,33 @@ DEFINE_TEST_FUNC(u64, "%llu");
 DEFINE_TEST_FUNC(s64, "%lld");
 #endif
 
+DEFINE_TEST_ARRAY_TYPED(u32, u32, u8) = {
+	{0, 0, 0, 0, 0, false, false, false},
+	{U8_MAX, 2, 1, U8_MAX - 2, U8_MAX - 1, true, false, true},
+	{U8_MAX + 1, 0, 0, 0, 0, true, true, false},
+};
+DEFINE_TEST_FUNC_TYPED(u32_u32__u8, u8, "%d");
+
+DEFINE_TEST_ARRAY_TYPED(u32, u32, int) = {
+	{0, 0, 0, 0, 0, false, false, false},
+	{U32_MAX, 0, -1, -1, 0, true, true, false},
+};
+DEFINE_TEST_FUNC_TYPED(u32_u32__int, int, "%d");
+
+DEFINE_TEST_ARRAY_TYPED(u8, u8, int) = {
+	{0, 0, 0, 0, 0, false, false, false},
+	{U8_MAX, U8_MAX, 2 * U8_MAX, 0, U8_MAX * U8_MAX, false, false, false},
+	{1, 2, 3, -1, 2, false, false, false},
+};
+DEFINE_TEST_FUNC_TYPED(u8_u8__int, int, "%d");
+
+DEFINE_TEST_ARRAY_TYPED(int, int, u8) = {
+	{0, 0, 0, 0, 0, false, false, false},
+	{1, 2, 3, U8_MAX, 2, false, true, false},
+	{-1, 0, U8_MAX, U8_MAX, 0, true, true, false},
+};
+DEFINE_TEST_FUNC_TYPED(int_int__u8, u8, "%d");
+
 static void overflow_shift_test(struct kunit *test)
 {
 	int count = 0;
@@ -649,17 +682,21 @@ static void overflow_size_helpers_test(struct kunit *test)
 }
 
 static struct kunit_case overflow_test_cases[] = {
-	KUNIT_CASE(u8_overflow_test),
-	KUNIT_CASE(s8_overflow_test),
-	KUNIT_CASE(u16_overflow_test),
-	KUNIT_CASE(s16_overflow_test),
-	KUNIT_CASE(u32_overflow_test),
-	KUNIT_CASE(s32_overflow_test),
+	KUNIT_CASE(u8_u8__u8_overflow_test),
+	KUNIT_CASE(s8_s8__s8_overflow_test),
+	KUNIT_CASE(u16_u16__u16_overflow_test),
+	KUNIT_CASE(s16_s16__s16_overflow_test),
+	KUNIT_CASE(u32_u32__u32_overflow_test),
+	KUNIT_CASE(s32_s32__s32_overflow_test),
 /* Clang 13 and earlier generate unwanted libcalls on 32-bit. */
 #if BITS_PER_LONG == 64
-	KUNIT_CASE(u64_overflow_test),
-	KUNIT_CASE(s64_overflow_test),
+	KUNIT_CASE(u64_u64__u64_overflow_test),
+	KUNIT_CASE(s64_s64__s64_overflow_test),
 #endif
+	KUNIT_CASE(u32_u32__u8_overflow_test),
+	KUNIT_CASE(u32_u32__int_overflow_test),
+	KUNIT_CASE(u8_u8__int_overflow_test),
+	KUNIT_CASE(int_int__u8_overflow_test),
 	KUNIT_CASE(overflow_shift_test),
 	KUNIT_CASE(overflow_allocation_test),
 	KUNIT_CASE(overflow_size_helpers_test),
-- 
2.34.1

