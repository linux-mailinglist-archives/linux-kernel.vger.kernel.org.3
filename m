Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB365A6D03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiH3TV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiH3TVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:21:53 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55590796BC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:21:51 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 69so9878140pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=l9QH8VXO4FLTBbb20E5lkc3fQcvyenw83Y4yVZrwQ/E=;
        b=oCRvX77KFYi5/jKNQH99vi0L3/My1hTGsjdogKRj5CVc3mw/pL9O0oRXXS/jvKm93L
         RtziVFOmW62m2c227M4Oi+hIEmTXWdFQfplaoC4S7ow0+8NdgTMEI5wZeFcN2qIWtjnM
         ZZL3++Jz9HYs+c2XssiruhNzBWjbvPOlGP4Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=l9QH8VXO4FLTBbb20E5lkc3fQcvyenw83Y4yVZrwQ/E=;
        b=JfuyU2JlCz7iKjQ8Fv/+PzW6L+nl3hC8cvatseRgRf6XLp4H5tlwxd0bW7nGALAuyq
         mq0a9KZTi4Uc3IjhB+lzwan9QCIVDdVhHEQM4NAEh9NeHx044Gs5+A1jQm4VKC/UtjFD
         RI24Oocqfd5K1HrWVa3fINFHEBDWL6ON6THwSiRLCPsWi+4Slf9XHEHJZtUNqa3VUrYb
         VAHb17w81RYQlZVjaIlUANNfimjpIpVsGaZjrrwoXYalXnJ7CINppA4XaUgmq4bmXVl7
         Fr9RXsgQIg/p+3E1IJt9KaQfb0OKNz4Agba3Bg+lLDM0YjBDPQdCW0VnU1jR3HgAKQlZ
         jNig==
X-Gm-Message-State: ACgBeo0sid6BQz9tul+mtmnFN8UuIUCrFFMmyWnR5y00UvUjRcltrIqB
        H1xWCZANE8K+KmlxdxsZNdeMWw==
X-Google-Smtp-Source: AA6agR46dczYIeRMzzXabu0s6p46lJ5zduNpXFx4QQE5L2i2pagpwnM3xZ6um0xO0c4uabcL3LyQRA==
X-Received: by 2002:aa7:814d:0:b0:535:c875:dd4f with SMTP id d13-20020aa7814d000000b00535c875dd4fmr22537013pfn.4.1661887310758;
        Tue, 30 Aug 2022 12:21:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001729da53673sm10210798plh.14.2022.08.30.12.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 12:21:49 -0700 (PDT)
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
Subject: [PATCH v3] overflow: Allow mixed type arguments
Date:   Tue, 30 Aug 2022 12:21:47 -0700
Message-Id: <20220830192147.47069-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10115; h=from:subject; bh=UA9/4YxGhZIF0ne1wB0dTn/qHbGopPO+h81MIDOPKFk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjDmNLIJ7AgRjEKV6RZRLREKEOHr582HZ5JxPAn/7e 7wJ0woWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYw5jSwAKCRCJcvTf3G3AJqaREA CZXQefHp6gm1KRKBi+A37KHl3h7EkaUxo5FNCEb37aBrkN1+vItsCj+nGZ6d0/UICHDV8RaXOPutOg Hk3h00gv/mgKSfAhPiybH3JLVkLV8ch7gFCEA3lb6QLtjVbbe2MYJiGGRPKYEeSTVWGMqwYiv6DlRx VeYx20gh6AQJnr5OxsseL7kn0PUL/4N1p0sR/Pa7ckpvMWmFmbBJ/3ezABkZeN90DQD52PfDNQ8rkW m+GNJXn1wyDZRoFcIUGiHMpHnCQCZhC0rtusPRySQA+K4KRe+OtHN0fS8bqPx9Z3TKiC3mhdKS9zap AT/BeE0TQzR/Xxw2tPezYeZdHha3/Wzc6N9c6H0iAxmdt4mS8gtYSkfeogtOtdWabC3k6nj8JNdBNJ W4h4BxQHpBof2GzdW/8cjlvFpwWRexJC/byW41U4a8MmzUbelxsmCosJdZsc6ezo0UbtnOURAToFte xGnIQzj9FA1os7VLefHKc1lIjtZ3lPx2rhL2yNIoUqOzSyQqwQESg5as0nJgFumPqHEp6EQi3vShUe SGaheiOjybnuEFsocbN7PwZg1/YDQwV61KNHGl0LRibr04RgeBr9S3TWSga7hJenC8YJT6rwo8S0cU Qz158M+xxyT/ioL2r48rRdGd28+knsCTUAkGpgixgon6Qa2OBu8Agsucsiaw==
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

When the check_[op]_overflow() helpers were introduced, all arguments were
required to be the same type to make the fallback macros simpler. However,
now that the fallback macros have been removed[1], it is fine to allow
mixed types, which makes using the helpers much more useful, as they
can be used to test for type-based overflows (e.g. adding two large ints
but storing into a u8), as would be handy in the drm core[2].

Remove the restriction, and add additional self-tests that exercise some
of the mixed-type overflow cases, and double-check for accidental macro
side-effects.

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
v3: drop needless local variables (Andrzej)
v2: https://lore.kernel.org/lkml/20220829214550.3443472-1-keescook@chromium.org
v1: https://lore.kernel.org/lkml/20220829204729.3409270-1-keescook@chromium.org
---
 include/linux/overflow.h |  72 ++++++++++++++++------------
 lib/overflow_kunit.c     | 101 ++++++++++++++++++++++++++++-----------
 2 files changed, 113 insertions(+), 60 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 0eb3b192f07a..19dfdd74835e 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -51,40 +51,50 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	return unlikely(overflow);
 }
 
-/*
- * For simplicity and code hygiene, the fallback code below insists on
- * a, b and *d having the same type (similar to the min() and max()
- * macros), whereas gcc's type-generic overflow checkers accept
- * different types. Hence we don't just make check_add_overflow an
- * alias for __builtin_add_overflow, but add type checks similar to
- * below.
+/** check_add_overflow() - Calculate addition with overflow checking
+ *
+ * @a: first addend
+ * @b: second addend
+ * @d: pointer to store sum
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted addition, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * sum has overflowed or been truncated.
  */
-#define check_add_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_add_overflow(__a, __b, __d);	\
-}))
+#define check_add_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_add_overflow(a, b, d))
 
-#define check_sub_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_sub_overflow(__a, __b, __d);	\
-}))
+/** check_sub_overflow() - Calculate subtraction with overflow checking
+ *
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ * @d: pointer to store difference
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted subtraction, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * difference has underflowed or been truncated.
+ */
+#define check_sub_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_sub_overflow(a, b, d))
 
-#define check_mul_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_mul_overflow(__a, __b, __d);	\
-}))
+/** check_mul_overflow() - Calculate multiplication with overflow checking
+ *
+ * @a: first factor
+ * @b: second factor
+ * @d: pointer to store product
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted multiplication, but is not
+ * considered "safe for use" on a non-zero return value, which indicates
+ * that the product has overflowed or been truncated.
+ */
+#define check_mul_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_mul_overflow(a, b, d))
 
 /** check_shl_overflow() - Calculate a left-shifted value and check overflow
  *
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 7e3e43679b73..0d98c9bc75da 100644
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
@@ -222,21 +225,27 @@ DEFINE_TEST_ARRAY(s64) = {
 };
 #endif
 
-#define check_one_op(t, fmt, op, sym, a, b, r, of) do {		\
-	t _r;							\
-	bool _of;						\
-								\
-	_of = check_ ## op ## _overflow(a, b, &_r);		\
-	KUNIT_EXPECT_EQ_MSG(test, _of, of,			\
+#define check_one_op(t, fmt, op, sym, a, b, r, of) do {			\
+	int _a_orig = a, _a_bump = a + 1;				\
+	int _b_orig = b, _b_bump = b + 1;				\
+	bool _of;							\
+	t _r;								\
+									\
+	_of = check_ ## op ## _overflow(a, b, &_r);			\
+	KUNIT_EXPECT_EQ_MSG(test, _of, of,				\
 		"expected "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
-		a, b, of ? "" : " not", #t);			\
-	KUNIT_EXPECT_EQ_MSG(test, _r, r,			\
+		a, b, of ? "" : " not", #t);				\
+	KUNIT_EXPECT_EQ_MSG(test, _r, r,				\
 		"expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
-		a, b, r, _r, #t);				\
+		a, b, r, _r, #t);					\
+	/* Check for internal macro side-effects. */			\
+	_of = check_ ## op ## _overflow(_a_orig++, _b_orig++, &_r);	\
+	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump, "Unexpected " #op " macro side-effect!\n"); \
+	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump, "Unexpected " #op " macro side-effect!\n"); \
 } while (0)
 
-#define DEFINE_TEST_FUNC(t, fmt)					\
-static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p) \
+#define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
+static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
 {							   		\
 	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
 	check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	\
@@ -245,15 +254,18 @@ static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p) \
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
@@ -265,6 +277,33 @@ DEFINE_TEST_FUNC(u64, "%llu");
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
@@ -649,17 +688,21 @@ static void overflow_size_helpers_test(struct kunit *test)
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

