Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860805A55C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiH2Uri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiH2Urg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:47:36 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EED71984
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:47:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t5so9215398pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=S7cQYEpj0+Wy/0rxU7sQpe7ziCh6bG0rF+PkNoZ9kig=;
        b=msb9HLjqZCX3GNCYA+ZBf0iuuY/+eKlxQQYpoWQPIjHj49gdYFZFDZILWrvHgj/PqB
         T+UhKG9QTKqeEtJNmFl+GpA4AFswhmc4aE2Z0Zq/gizQN5yh0wGdu0NLxhJHozujRvXh
         jHja7U4ZbA4FBLqlAf5Z/e46cB/DcZTa0kwC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=S7cQYEpj0+Wy/0rxU7sQpe7ziCh6bG0rF+PkNoZ9kig=;
        b=WEE0/az7N+2IAj/CqcISQFnz5z9Dz8T3yQUXfdYLV0uIlcDMGdPfFMP2NRSZxsaCaV
         BfX3CD/ir/1WnRmuj5zgb5dBmxYn0W2NJ+u+IUtZSV7WvYW6AdZlS7nk5P9BFpBRDo5V
         IaeTsF3iAiee1hiZObDcrzKZNv73V8OI6H/oGNHCq/M7oP73WQFSuANmrflUKsYkDot1
         J3pGjfZsI8Tpu6lRmgWjmcSwRlUzYL7nSbbNE2Zb8hzOhCSQjrShAwXFWI2BE0/r9hGW
         qW5pU53U2rGyt3/fhfO+oQ2URHVSXRlyzpsH3UwOXckRP1m4tmWpd06mgDRg+NM6wrEO
         /33w==
X-Gm-Message-State: ACgBeo0MopNAoTruD+fTiobi6xXNtBcwe+2J3nOukvjMJ+N5Ik4qYPIF
        XPpuwqe/nUp4ON92pp47OikuhQ==
X-Google-Smtp-Source: AA6agR5jNCxTeK380ecflHe3U18zodV1fMnLRM1sW4GLBxwCkF/xsxVO9llNAfQ+ATlOO+6W98OVDQ==
X-Received: by 2002:a17:90a:4e0d:b0:1fb:bd1b:624a with SMTP id n13-20020a17090a4e0d00b001fbbd1b624amr20253532pjh.228.1661806054206;
        Mon, 29 Aug 2022 13:47:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z1-20020a170903018100b0017515e598c5sm146599plg.40.2022.08.29.13.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 13:47:32 -0700 (PDT)
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
Subject: [PATCH] overflow: Allow mixed type arguments
Date:   Mon, 29 Aug 2022 13:47:29 -0700
Message-Id: <20220829204729.3409270-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6556; h=from:subject; bh=1wrrZrTK9sGT31xuzroB1VFkTRAy5po/e9xK7KFUjD8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjDSXgxTbCiSvFKhYmgEBHMwDvvrZb89J1ZzDdh/sp 2QzExJeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYw0l4AAKCRCJcvTf3G3AJnKDEA CbTVf4QLO7t4eeUc/CkQO9lNX65jvt7NmKNe5Kd2wdXaA6kujATEO79IXdNQ6QocI8UpbQVlajOlaF guPRxOyA2gvvvOokjfVlmDy2DdFOqIavUP0kH2ukyqDgo1bvYSTM3R0/c3ZJCKtG2vYnqQMtZqigBF CiSg47Bl0IesbmsTEG/rd9NpTpbJns016wF7Aal+dPzt9Pl1JESkfQ4hPjCWVVMoFrB0ywfEqJcql7 XI6vreexRC41ZsBEFsgoOCb1CjHQlf8K+OjvnEUs71BZo1oAOD+LO3CAiOPAti4Y2k09Ww55o+qu5O hB8hEx+CRFyPAiEwEos4xKzm1TQ2DdcKVuhKdr5YNeJOkEvB9yvrKC7gdRyhYToNk8wkaJC1yvpdiT KLU//SG8k+Ojdbt7KQiFzd1SYkFk7uwuZbj2jiPrVCf1ZHucYKzuJznEtHqP7aZFhqpsxFgkByomEr 95egllrKUACepOCdMn6DfUUs31dGuXt2ZPCfs8loXfblRuw7TuM2HSqRMw4o5JCAtTBux1rB0EoftW FR1bfr8a+FXdDiRfnSWG/JOCiYeQ1bse0a04GK+ZjAAR3A/GfxNMxgiQN/hWb+CbhXUkY/Hs4F7u8p RJSW94sL5S0AOyYiMwsv78TnmGG2dCt6F0/XSX+loH0PWIqs+pNV8gKOboUQ==
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
index 7e3e43679b73..ac771fe7e276 100644
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
+#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)		\
+	static const struct test_ ## t1 ## t2 ## t {	\
+		t1 a;					\
+		t2 b;					\
+		t sum, diff, prod;			\
+		bool s_of, d_of, p_of;			\
+	} t1 ## t2 ## t ## _tests[]
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
+	DEFINE_TEST_FUNC_TYPED(t ## t ## t, t, fmt)
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
+DEFINE_TEST_FUNC_TYPED(u32u32u8, u8, "%d");
+
+DEFINE_TEST_ARRAY_TYPED(u32, u32, int) = {
+	{0, 0, 0, 0, 0, false, false, false},
+	{U32_MAX, 0, -1, -1, 0, true, true, false},
+};
+DEFINE_TEST_FUNC_TYPED(u32u32int, int, "%d");
+
+DEFINE_TEST_ARRAY_TYPED(u8, u8, int) = {
+	{0, 0, 0, 0, 0, false, false, false},
+	{U8_MAX, U8_MAX, 2 * U8_MAX, 0, U8_MAX * U8_MAX, false, false, false},
+	{1, 2, 3, -1, 2, false, false, false},
+};
+DEFINE_TEST_FUNC_TYPED(u8u8int, int, "%d");
+
+DEFINE_TEST_ARRAY_TYPED(int, int, u8) = {
+	{0, 0, 0, 0, 0, false, false, false},
+	{1, 2, 3, U8_MAX, 2, false, true, false},
+	{-1, 0, U8_MAX, U8_MAX, 0, true, true, false},
+};
+DEFINE_TEST_FUNC_TYPED(intintu8, u8, "%d");
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
+	KUNIT_CASE(u8u8u8_overflow_test),
+	KUNIT_CASE(s8s8s8_overflow_test),
+	KUNIT_CASE(u16u16u16_overflow_test),
+	KUNIT_CASE(s16s16s16_overflow_test),
+	KUNIT_CASE(u32u32u32_overflow_test),
+	KUNIT_CASE(s32s32s32_overflow_test),
 /* Clang 13 and earlier generate unwanted libcalls on 32-bit. */
 #if BITS_PER_LONG == 64
-	KUNIT_CASE(u64_overflow_test),
-	KUNIT_CASE(s64_overflow_test),
+	KUNIT_CASE(u64u64u64_overflow_test),
+	KUNIT_CASE(s64s64s64_overflow_test),
 #endif
+	KUNIT_CASE(u32u32u8_overflow_test),
+	KUNIT_CASE(u32u32int_overflow_test),
+	KUNIT_CASE(u8u8int_overflow_test),
+	KUNIT_CASE(intintu8_overflow_test),
 	KUNIT_CASE(overflow_shift_test),
 	KUNIT_CASE(overflow_allocation_test),
 	KUNIT_CASE(overflow_size_helpers_test),
-- 
2.34.1

