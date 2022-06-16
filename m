Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1254E908
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbiFPSEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiFPSEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:04:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062B342A1A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:04:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v191-20020a25c5c8000000b00663d6d41f5aso1687122ybe.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=B7y5xFQUO2XPKfD+iGXVJQVQoOaGKsydlG5wYQRqLQs=;
        b=NorBcaKNIoiN+30Lxx94m93i9h5FRuCPKvN42nKIAI4gMZ582tiAiUUbRI3/PobwUt
         of2BUPTpu3KYMnL6fTS56mP80kWfX5Q1wc+c5iSgZgydj3VdPfw7K5GtJhecWaxdwOlq
         hCAmBs/YJ3OV3leBUerBaiUQPXSXrFMOW985EjsqqrB/z1CDP0F/cC6KF5y98O0TqFWd
         OWWYLSaEZCb49QYtE66gHuGY0YpwbXYNwkhecn+0voo4eivp4L4yka12zIe/BrGmB3II
         UkTh49LOkN+UfuycDhrQ8z3OMuSIMfESYAX/lixzZA/nIJNa2q4JUd0aXu/ATd7kW65q
         Kc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=B7y5xFQUO2XPKfD+iGXVJQVQoOaGKsydlG5wYQRqLQs=;
        b=X2GFcm+NVZ4ihjM4W2eixuPky3JCVEOosEqhXLKnGMjcca3o/qj7dEVSaxFGHKGAYl
         4JzRjCCoolrmCJKgSLsVLREwZsPkoOb+vsB/hXpVoWzINx1i0/DCD3JMf/bvfLbJZnva
         ++9F+Q0SeIC3KCPJhH0tTy8XnoCAT1eK3Z02Dco+wEAncG5rkAihg5vV+2jokm9RUi4L
         isWIuqSZ2pkOf70ktb5eXdPEFrE/8hVs+HUjZrbp+8a1n33OkiOMLcHRnkWj/a73ZtvQ
         hSEVMbN/5HMEYv+6xr4ivS5v25B7smLLp1OKNtH4GmlRsptH+8xygEmYnj0JaC+QIF77
         eVVw==
X-Gm-Message-State: AJIora/OZdk2/dXkHwGl42d8CRe7BEl0LeMePk69NHzZ1/aerfflPHfl
        NW3UTx1nG0s8w2NEjmwhcXp6fbS93Qim/Q==
X-Google-Smtp-Source: AGRyM1tOj+PeW31Dofykg82yAp+/y8XMa/ajAUlPhnMweGdgT2aohSnXqHPGAao40zUTkNbkO79xUZYG/zfXAw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:fe25:49b5:6fff:bf1a])
 (user=dlatypov job=sendgmr) by 2002:a81:2fd8:0:b0:314:eaa:bbc1 with SMTP id
 v207-20020a812fd8000000b003140eaabbc1mr7151094ywv.141.1655402677220; Thu, 16
 Jun 2022 11:04:37 -0700 (PDT)
Date:   Thu, 16 Jun 2022 11:04:30 -0700
Message-Id: <20220616180430.930721-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH] lib/atomic64_test.c: convert to use KUnit
From:   Daniel Latypov <dlatypov@google.com>
To:     mark.rutland@arm.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        peterz@infradead.org, Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test currently is a bunch of checks (implemented using BUG_ON())
that can be built into the kernel or as a module.

Convert it to a KUnit test, which can also run in both modes.
From a user's perspective, this change adds a CONFIG_KUNIT=3Dy dep and
changes the output format of the test [1] and makes it less destructive
on failure. The test itself is the same.

This hopefully makes the test easier to run and more consistent with
similar tests in lib/.
Since it has no dependencies, it can be run without explicitly setting
up a .kunitconfig via
$ ./tools/testing/kunit/kunit.py run atomic
...
[13:53:44] Starting KUnit Kernel (1/1)...
[13:53:44] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[13:53:47] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D atomic=
 (2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[13:53:47] [PASSED] test_atomic
[13:53:47] [PASSED] test_atomic64
[13:53:47] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
[PASSED] atomic =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
[13:53:47] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[13:53:47] Testing complete. Passed: 2, Failed: 0, Crashed: 0, Skipped: 0, =
Errors: 0
[13:53:47] Elapsed time: 13.902s total, 1.629s configuring, 9.331s building=
, 2.852s running

It can be run on ARCH=3Dx86_64 (and others) via:
$ ./tools/testing/kunit/kunit.py run --arch=3Dx86_64 atomic

The message about which platform the test ran on won't show up in
kunit.py, but still gets printed out in dmesg, e.g.
> TAP version 14
> 1..1
>     # Subtest: atomic
>     1..2
>     ok 1 - test_atomic
>     ok 2 - test_atomic64
>     # atomic: ran on x86-64 platform with CX8 and with SSE
> # atomic: pass:2 fail:0 skip:0 total:2
> # Totals: pass:2 fail:0 skip:0 total:2
> ok 1 - atomic

[1] https://www.kernel.org/doc/html/latest/dev-tools/ktap.html

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
---
Meta: this is a resend of https://lore.kernel.org/linux-kselftest/202205021=
92327.81153-1-dlatypov@google.com/
Michael kindly pointed me to the right MAINTAINERS entry (this test file
isn't covered by it, and it slipped my mind to check the non-test code).

I've waited until 5.19-rc1 so that the relevant KUnit patches this
depended on have been merged.
Rebasing and tweaking the commit message a bit are the only changes.
---
 lib/Kconfig.debug   |   4 +-
 lib/atomic64_test.c | 107 +++++++++++++++++++++-----------------------
 2 files changed, 55 insertions(+), 56 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2e24db4bff19..4cf1ce8910f6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2147,7 +2147,9 @@ config PERCPU_TEST
 	  If unsure, say N.
=20
 config ATOMIC64_SELFTEST
-	tristate "Perform an atomic64_t self-test"
+	tristate "Perform an atomic64_t self-test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  Enable this option to test the atomic64_t functions at boot or
 	  at module load time.
diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index d9d170238165..46cb0130f8d0 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -5,13 +5,9 @@
  * Copyright =C2=A9 2010  Luca Barbieri
  */
=20
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <kunit/test.h>
=20
-#include <linux/init.h>
-#include <linux/bug.h>
-#include <linux/kernel.h>
 #include <linux/atomic.h>
-#include <linux/module.h>
=20
 #ifdef CONFIG_X86
 #include <asm/cpufeature.h>	/* for boot_cpu_has below */
@@ -23,9 +19,7 @@ do {								\
 	r =3D v0;							\
 	atomic##bit##_##op(val, &v);				\
 	r c_op val;						\
-	WARN(atomic##bit##_read(&v) !=3D r, "%Lx !=3D %Lx\n",	\
-		(unsigned long long)atomic##bit##_read(&v),	\
-		(unsigned long long)r);				\
+	KUNIT_ASSERT_EQ(test, atomic##bit##_read(&v), r);	\
 } while (0)
=20
 /*
@@ -46,8 +40,8 @@ do {								\
 	atomic##bit##_set(&v, v0);				\
 	r =3D v0;							\
 	r c_op val;						\
-	BUG_ON(atomic##bit##_##op(val, &v) !=3D r);		\
-	BUG_ON(atomic##bit##_read(&v) !=3D r);			\
+	KUNIT_ASSERT_EQ(test, atomic##bit##_##op(val, &v), r);	\
+	KUNIT_ASSERT_EQ(test, atomic##bit##_read(&v), r);	\
 } while (0)
=20
 #define TEST_FETCH(bit, op, c_op, val)				\
@@ -55,8 +49,8 @@ do {								\
 	atomic##bit##_set(&v, v0);				\
 	r =3D v0;							\
 	r c_op val;						\
-	BUG_ON(atomic##bit##_##op(val, &v) !=3D v0);		\
-	BUG_ON(atomic##bit##_read(&v) !=3D r);			\
+	KUNIT_ASSERT_EQ(test, atomic##bit##_##op(val, &v), v0);	\
+	KUNIT_ASSERT_EQ(test, atomic##bit##_read(&v), r);	\
 } while (0)
=20
 #define RETURN_FAMILY_TEST(bit, op, c_op, val)			\
@@ -72,8 +66,8 @@ do {								\
 #define TEST_ARGS(bit, op, init, ret, expect, args...)		\
 do {								\
 	atomic##bit##_set(&v, init);				\
-	BUG_ON(atomic##bit##_##op(&v, ##args) !=3D ret);		\
-	BUG_ON(atomic##bit##_read(&v) !=3D expect);		\
+	KUNIT_ASSERT_EQ(test, atomic##bit##_##op(&v, ##args), ret);\
+	KUNIT_ASSERT_EQ(test, atomic##bit##_read(&v), expect);	\
 } while (0)
=20
 #define XCHG_FAMILY_TEST(bit, init, new)				\
@@ -101,7 +95,7 @@ do {							\
 			i, (i) - one, (i) - one);	\
 } while (0)
=20
-static __init void test_atomic(void)
+static void test_atomic(struct kunit *test)
 {
 	int v0 =3D 0xaaa31337;
 	int v1 =3D 0xdeadbeef;
@@ -144,7 +138,7 @@ static __init void test_atomic(void)
 }
=20
 #define INIT(c) do { atomic64_set(&v, c); r =3D c; } while (0)
-static __init void test_atomic64(void)
+static void test_atomic64(struct kunit *test)
 {
 	long long v0 =3D 0xaaa31337c001d00dLL;
 	long long v1 =3D 0xdeadbeefdeafcafeLL;
@@ -156,12 +150,12 @@ static __init void test_atomic64(void)
=20
 	atomic64_t v =3D ATOMIC64_INIT(v0);
 	long long r =3D v0;
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	atomic64_set(&v, v1);
 	r =3D v1;
-	BUG_ON(v.counter !=3D r);
-	BUG_ON(atomic64_read(&v) !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
+	KUNIT_ASSERT_EQ(test, atomic64_read(&v), r);
=20
 	TEST(64, add, +=3D, onestwos);
 	TEST(64, add, +=3D, -one);
@@ -190,12 +184,12 @@ static __init void test_atomic64(void)
 	INIT(v0);
 	atomic64_inc(&v);
 	r +=3D one;
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(v0);
 	atomic64_dec(&v);
 	r -=3D one;
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INC_RETURN_FAMILY_TEST(64, v0);
 	DEC_RETURN_FAMILY_TEST(64, v0);
@@ -204,73 +198,76 @@ static __init void test_atomic64(void)
 	CMPXCHG_FAMILY_TEST(64, v0, v1, v2);
=20
 	INIT(v0);
-	BUG_ON(atomic64_add_unless(&v, one, v0));
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_FALSE(test, atomic64_add_unless(&v, one, v0));
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(v0);
-	BUG_ON(!atomic64_add_unless(&v, one, v1));
+	KUNIT_ASSERT_TRUE(test, atomic64_add_unless(&v, one, v1));
 	r +=3D one;
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(onestwos);
-	BUG_ON(atomic64_dec_if_positive(&v) !=3D (onestwos - 1));
+	KUNIT_ASSERT_EQ(test, atomic64_dec_if_positive(&v), (onestwos - 1));
 	r -=3D one;
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(0);
-	BUG_ON(atomic64_dec_if_positive(&v) !=3D -one);
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, atomic64_dec_if_positive(&v), -one);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(-one);
-	BUG_ON(atomic64_dec_if_positive(&v) !=3D (-one - one));
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, atomic64_dec_if_positive(&v), (-one - one));
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(onestwos);
-	BUG_ON(!atomic64_inc_not_zero(&v));
+	KUNIT_ASSERT_TRUE(test, atomic64_inc_not_zero(&v));
 	r +=3D one;
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(0);
-	BUG_ON(atomic64_inc_not_zero(&v));
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_FALSE(test, atomic64_inc_not_zero(&v));
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(-one);
-	BUG_ON(!atomic64_inc_not_zero(&v));
+	KUNIT_ASSERT_TRUE(test, atomic64_inc_not_zero(&v));
 	r +=3D one;
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	/* Confirm the return value fits in an int, even if the value doesn't */
 	INIT(v3);
+
 	r_int =3D atomic64_inc_not_zero(&v);
-	BUG_ON(!r_int);
+	KUNIT_ASSERT_NE(test, r_int, 0);
 }
=20
-static __init int test_atomics_init(void)
-{
-	test_atomic();
-	test_atomic64();
+static struct kunit_case atomic_test_cases[] =3D {
+	KUNIT_CASE(test_atomic),
+	KUNIT_CASE(test_atomic64),
+	{},
+};
=20
+static void atomic_suite_exit(struct kunit_suite *suite)
+{
 #ifdef CONFIG_X86
-	pr_info("passed for %s platform %s CX8 and %s SSE\n",
+	kunit_info(suite, "ran on %s platform %s CX8 and %s SSE\n",
 #ifdef CONFIG_X86_64
-		"x86-64",
+		   "x86-64",
 #elif defined(CONFIG_X86_CMPXCHG64)
-		"i586+",
+		   "i586+",
 #else
-		"i386+",
+		   "i386+",
 #endif
-	       boot_cpu_has(X86_FEATURE_CX8) ? "with" : "without",
-	       boot_cpu_has(X86_FEATURE_XMM) ? "with" : "without");
-#else
-	pr_info("passed\n");
+		   boot_cpu_has(X86_FEATURE_CX8) ? "with" : "without",
+		   boot_cpu_has(X86_FEATURE_XMM) ? "with" : "without");
 #endif
-
-	return 0;
 }
=20
-static __exit void test_atomics_exit(void) {}
+static struct kunit_suite atomic_test_suite =3D {
+	.name =3D "atomic",
+	.test_cases =3D atomic_test_cases,
+	.suite_exit =3D atomic_suite_exit,
+};
=20
-module_init(test_atomics_init);
-module_exit(test_atomics_exit);
+kunit_test_suites(&atomic_test_suite);
=20
 MODULE_LICENSE("GPL");

base-commit: 8ab2afa23bd197df47819a87f0265c0ac95c5b6a
--=20
2.36.1.476.g0c4daa206d-goog

