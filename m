Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A830E5A8539
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiHaSOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiHaSN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08046DEB7C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:12:16 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x19so13349961pfr.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=+FPB2MKL9v7GjxeLAYremS8ZtsqDh2bdF2F8eQQvlHs=;
        b=CYlpSIKhg8hDCBcboi29/Tvqjb5Zm+ig8Gn4tZQB3FViqP9YJhm18fpJtHyMewumi8
         ZmMrFb8Ex7elICsdEpfFFP587DTF3CguVWX5J9nKZb3i/KeuMl78n53t4NUkiA8zge+o
         ZO5iXNYktQsIsVsidn6zw/2DR5J7zeZhMDRx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=+FPB2MKL9v7GjxeLAYremS8ZtsqDh2bdF2F8eQQvlHs=;
        b=o16LPWyX5BnBNOqgBPtSZARmlnFYKF1z0jNnl9DQrchutUbh/SAhoURspTwwZCzie/
         HP/LorYiD/ITjllZD8U8r9HvX8WgdqTNg9rviEa9PXhziNynOlBi3ulVkbbCkCot83zI
         yQmxKbM4KSxUYZDZsY9fELffRU+4j/punCsbHLQYUXPuBdI+EKDt9kHoT9xtLp2GAu2W
         cxeK/UJ2N5dlu/a48rRV0k7/uIYcN5bdELz05PGHzL5ArFMz4V0sHJkxvN/0y6wsCil5
         GX4lVbkXKBBc/VPDyLqlqTaTJojvtFichAP/C7PHVgxFtoUZbV9ooQn372vme16mfpwK
         Md4w==
X-Gm-Message-State: ACgBeo2kF+7o6qSpJQbiy+gA++jVY9FF4rdAhERKSrm8Du23BUX7Svre
        PWgAoj0jaqx6CKJbkCpD7s2hww==
X-Google-Smtp-Source: AA6agR7W4Dv7enr2z0bknULBTBjIm5oAx4DbBhIBhQBExJIPLPWpvbDYeUSUhnCIKTQRQakEiLNqeA==
X-Received: by 2002:aa7:8742:0:b0:537:ee75:601a with SMTP id g2-20020aa78742000000b00537ee75601amr21484748pfo.37.1661969503067;
        Wed, 31 Aug 2022 11:11:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902714f00b0017532e01e3fsm3216199plm.276.2022.08.31.11.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:11:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Latypov <dlatypov@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] overflow: Split up kunit tests for smaller stack frames
Date:   Wed, 31 Aug 2022 11:11:40 -0700
Message-Id: <20220831181140.842093-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5672; h=from:subject; bh=aj59+gqQXAf9s4qeTET5coAedgx0HGyX/RR0nO+aMCg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjD6Rchk49aYbAVzrBbHrkVerP3JFcTIXd/Ju/I8M5 krdGx5uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYw+kXAAKCRCJcvTf3G3AJhqbD/ 9PObfsj8WgoVsDigCEuZwwuNVZs46+b4s3foKgS53KwcT5KBkWAQp6Uj5QmgHNhme/QSRjWuDlwEmY Lsv107Je+2my3uzD1yiUht/1YU1e9C2hC0CdQ3vffy0PndLTtBb9Sp0r4Qfn+U96FNASYPESrRCDjc ro5P6tO/cXty84WWSodvIF2JSPWGnQ2JnSdDh40x+AxDMgFky00FLL6wl5y2QzCv0R+f0DemCZuMNg U7f2zU+m8rNjSI8AAL7NXFPnhrZHpcmMIVoaYkaE0p3jTOA8EjPfV/yp+FxAJNOAoVRn4AuvdMV4B5 3oXuoWcyTw6GMQ6pGYhcgIFt6fk1wAcXAeG6ZGWalUIbQ08ljadInIT/LbjHKHpbnHoWs+6SAvqu6l 5UDPGMNpV/bsEhSJ44Co0ZiYUvlJYnLz5eFdJJ8HhNuBQgT7H5BfFJD7Ex1lAM1o6ZSJBHPGgAztJu Ow4VKVFV87h7aJsNmZ55B8Lb4k4GqJNeKgM5pk0iqzOK7EeIC10unXnBV7gWiRbQZAO+fOloeYndzv TqUf9gdkmjl4AxEJKMuEaTbvU53e5y13LKUrI98Yg+ARNnhF7uQDul4O1PvsLCgRosYbX/2z07n2fj fU40fzWJNgaVVpjG6rL2V686sroIKdt7SpQSUBF6s6NVa3JY9moiSgVU5S0w==
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

Under some pathological 32-bit configs, the shift overflow KUnit tests
create huge stack frames. Split up the function to avoid this,
separating by rough shift overflow cases.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Daniel Latypov <dlatypov@google.com>
Cc: Vitor Massaru Iha <vitor@massaru.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202208301850.iuv9VwA8-lkp@intel.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/overflow_kunit.c | 78 +++++++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 27 deletions(-)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 0d98c9bc75da..f385ca652b74 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -304,10 +304,6 @@ DEFINE_TEST_ARRAY_TYPED(int, int, u8) = {
 };
 DEFINE_TEST_FUNC_TYPED(int_int__u8, u8, "%d");
 
-static void overflow_shift_test(struct kunit *test)
-{
-	int count = 0;
-
 /* Args are: value, shift, type, expected result, overflow expected */
 #define TEST_ONE_SHIFT(a, s, t, expect, of)	do {			\
 	typeof(a) __a = (a);						\
@@ -331,6 +327,10 @@ static void overflow_shift_test(struct kunit *test)
 	count++;							\
 } while (0)
 
+static void shift_sane_test(struct kunit *test)
+{
+	int count = 0;
+
 	/* Sane shifts. */
 	TEST_ONE_SHIFT(1, 0, u8, 1 << 0, false);
 	TEST_ONE_SHIFT(1, 4, u8, 1 << 4, false);
@@ -373,6 +373,13 @@ static void overflow_shift_test(struct kunit *test)
 	TEST_ONE_SHIFT(0, 30, s32, 0, false);
 	TEST_ONE_SHIFT(0, 62, s64, 0, false);
 
+	kunit_info(test, "%d sane shift tests finished\n", count);
+}
+
+static void shift_overflow_test(struct kunit *test)
+{
+	int count = 0;
+
 	/* Overflow: shifted the bit off the end. */
 	TEST_ONE_SHIFT(1, 8, u8, 0, true);
 	TEST_ONE_SHIFT(1, 16, u16, 0, true);
@@ -420,6 +427,13 @@ static void overflow_shift_test(struct kunit *test)
 	/* 0100000100001000001000000010000001000010000001000100010001001011 */
 	TEST_ONE_SHIFT(4686030735197619275LL, 2, s64, 0, true);
 
+	kunit_info(test, "%d overflow shift tests finished\n", count);
+}
+
+static void shift_truncate_test(struct kunit *test)
+{
+	int count = 0;
+
 	/* Overflow: values larger than destination type. */
 	TEST_ONE_SHIFT(0x100, 0, u8, 0, true);
 	TEST_ONE_SHIFT(0xFF, 0, s8, 0, true);
@@ -431,6 +445,33 @@ static void overflow_shift_test(struct kunit *test)
 	TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, int, 0, true);
 	TEST_ONE_SHIFT(0xFFFFFFFFFFFFFFFFULL, 0, s64, 0, true);
 
+	/* Overflow: shifted at or beyond entire type's bit width. */
+	TEST_ONE_SHIFT(0, 8, u8, 0, true);
+	TEST_ONE_SHIFT(0, 9, u8, 0, true);
+	TEST_ONE_SHIFT(0, 8, s8, 0, true);
+	TEST_ONE_SHIFT(0, 9, s8, 0, true);
+	TEST_ONE_SHIFT(0, 16, u16, 0, true);
+	TEST_ONE_SHIFT(0, 17, u16, 0, true);
+	TEST_ONE_SHIFT(0, 16, s16, 0, true);
+	TEST_ONE_SHIFT(0, 17, s16, 0, true);
+	TEST_ONE_SHIFT(0, 32, u32, 0, true);
+	TEST_ONE_SHIFT(0, 33, u32, 0, true);
+	TEST_ONE_SHIFT(0, 32, int, 0, true);
+	TEST_ONE_SHIFT(0, 33, int, 0, true);
+	TEST_ONE_SHIFT(0, 32, s32, 0, true);
+	TEST_ONE_SHIFT(0, 33, s32, 0, true);
+	TEST_ONE_SHIFT(0, 64, u64, 0, true);
+	TEST_ONE_SHIFT(0, 65, u64, 0, true);
+	TEST_ONE_SHIFT(0, 64, s64, 0, true);
+	TEST_ONE_SHIFT(0, 65, s64, 0, true);
+
+	kunit_info(test, "%d truncate shift tests finished\n", count);
+}
+
+static void shift_nonsense_test(struct kunit *test)
+{
+	int count = 0;
+
 	/* Nonsense: negative initial value. */
 	TEST_ONE_SHIFT(-1, 0, s8, 0, true);
 	TEST_ONE_SHIFT(-1, 0, u8, 0, true);
@@ -455,26 +496,6 @@ static void overflow_shift_test(struct kunit *test)
 	TEST_ONE_SHIFT(0, -30, s64, 0, true);
 	TEST_ONE_SHIFT(0, -30, u64, 0, true);
 
-	/* Overflow: shifted at or beyond entire type's bit width. */
-	TEST_ONE_SHIFT(0, 8, u8, 0, true);
-	TEST_ONE_SHIFT(0, 9, u8, 0, true);
-	TEST_ONE_SHIFT(0, 8, s8, 0, true);
-	TEST_ONE_SHIFT(0, 9, s8, 0, true);
-	TEST_ONE_SHIFT(0, 16, u16, 0, true);
-	TEST_ONE_SHIFT(0, 17, u16, 0, true);
-	TEST_ONE_SHIFT(0, 16, s16, 0, true);
-	TEST_ONE_SHIFT(0, 17, s16, 0, true);
-	TEST_ONE_SHIFT(0, 32, u32, 0, true);
-	TEST_ONE_SHIFT(0, 33, u32, 0, true);
-	TEST_ONE_SHIFT(0, 32, int, 0, true);
-	TEST_ONE_SHIFT(0, 33, int, 0, true);
-	TEST_ONE_SHIFT(0, 32, s32, 0, true);
-	TEST_ONE_SHIFT(0, 33, s32, 0, true);
-	TEST_ONE_SHIFT(0, 64, u64, 0, true);
-	TEST_ONE_SHIFT(0, 65, u64, 0, true);
-	TEST_ONE_SHIFT(0, 64, s64, 0, true);
-	TEST_ONE_SHIFT(0, 65, s64, 0, true);
-
 	/*
 	 * Corner case: for unsigned types, we fail when we've shifted
 	 * through the entire width of bits. For signed types, we might
@@ -490,9 +511,9 @@ static void overflow_shift_test(struct kunit *test)
 	TEST_ONE_SHIFT(0, 31, s32, 0, false);
 	TEST_ONE_SHIFT(0, 63, s64, 0, false);
 
-	kunit_info(test, "%d shift tests finished\n", count);
-#undef TEST_ONE_SHIFT
+	kunit_info(test, "%d nonsense shift tests finished\n", count);
 }
+#undef TEST_ONE_SHIFT
 
 /*
  * Deal with the various forms of allocator arguments. See comments above
@@ -703,7 +724,10 @@ static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(u32_u32__int_overflow_test),
 	KUNIT_CASE(u8_u8__int_overflow_test),
 	KUNIT_CASE(int_int__u8_overflow_test),
-	KUNIT_CASE(overflow_shift_test),
+	KUNIT_CASE(shift_sane_test),
+	KUNIT_CASE(shift_overflow_test),
+	KUNIT_CASE(shift_truncate_test),
+	KUNIT_CASE(shift_nonsense_test),
 	KUNIT_CASE(overflow_allocation_test),
 	KUNIT_CASE(overflow_size_helpers_test),
 	{}
-- 
2.34.1

