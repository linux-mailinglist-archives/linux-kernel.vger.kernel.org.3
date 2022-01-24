Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20FD49A9B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1321241AbiAYD04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1321309AbiAYDR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:17:59 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E9FC0604C2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:23:44 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 192so14144076pfz.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUy1cq/aLQFwACsA66qUZgeTjdc6W6p6YIU+kLy4RXI=;
        b=HMmVLm5Gk4xktbBAU6t3jLyp2yP/6L4jJnClTexhgIce1axDLwVbmNb9kclYALf+x2
         0eOP9jYiB5WoTm+5qhwtBJz55pfhYca49Ml8+KCXSU5yP+mC++U9lcHxQUOWDgskC1MN
         2wN/3QGEDEHBI9JYcXZGv9+GYD1bA3s9SGxz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUy1cq/aLQFwACsA66qUZgeTjdc6W6p6YIU+kLy4RXI=;
        b=3Az2jDqLMt4Z1Wu5CuzrRTofqOdzaTOg0y4Awj4e0EX2zHVdTEIo7sIbtv5Swq5M6v
         x+HOsBOypI5Q0+KoI9p2MzEfCypH5JNxNNy/yOdENB/KuiiQniDcNoMeY8l0L7JlYKUf
         6sAqiSjjw2vk1CB/wF/f7jlPm3jxQstuF3TZuAt7KkVp0vf0kfpGvYKee9xPCWhKLkrl
         1hqp10NImHsPqzulbXMaNk3V9axSjoVrhYMKOeeMj0+czqgZ2UstXjrtdsXHA5HPT8t/
         Xts7t4WaUs6ej1YWlA4Qam0RGl1SccMvlV9AIklQLlQ1nCqoiy3GGnNuSJYsJad6jnIQ
         20tw==
X-Gm-Message-State: AOAM532We4JYp6gPHiRMAF/fhsvCcKcO3fbrygjo+RfpH/udJdGQtEMd
        TEvTHq2fmg1GipYpVtXAyKkgIg==
X-Google-Smtp-Source: ABdhPJzJq/ZflgOy7noX+l1C7fkXGtfuvMQKoRWncNP/9c4/r0pI+i3lo/9e35lzQWKaf5+WOauong==
X-Received: by 2002:a63:2b01:: with SMTP id r1mr6103116pgr.182.1643066624239;
        Mon, 24 Jan 2022 15:23:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b4sm17120790pfl.106.2022.01.24.15.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 15:23:44 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] test_overflow: Regularize test reporting output
Date:   Mon, 24 Jan 2022 15:23:41 -0800
Message-Id: <20220124232342.3113350-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124232342.3113350-1-keescook@chromium.org>
References: <20220124232342.3113350-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5607; h=from:subject; bh=J3Wsxeg4JzBB1opD2cR25s34lPwyOQCvqPa3Egl9H+E=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh7zT96q6+BfVriBVKq/ZNrGoNFi9S0asAOL9Kgk/1 VRdFiCeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYe80/QAKCRCJcvTf3G3AJrzNEA CaRpSkCzT5WizfZbk+asSaEUEu4QhmQO7+JkP1dJubjfRmx4SgGUcq3ibh0ZLFAS2PqF2O6kb5vWaS g+kPJWdYWXDGhicKtiDgIc6266pep3/W5XRYgtoaI8vdzstVWNF3LEmw9YtTq04g9PEJ4kHyqJ5xii 3vhCip9Be/SY4UgfDtu9mSFrWTav91Z6qoNOYqmp/RiVsq9xP5ymUteR8aUfzIe/KPO6QNO+zGPh7i BWZckReajeP1l2Ffc83s8Ao7rSdOXERPxjbXxGkE7EDChDPzA2D16pQFGY4acKFJ/STYwnoVs+e5oG LhTCJf+zODcSDrXRPtFY0PVEiWhI0IMKXhhE2uw9Tw2xidIMRxhSzQUWwIXdJ2dYqOgPUSwWx1Yfqe Ezfjl9nXwUgas7bhyy+9dX6orfJx0Y+YVo/f64TpEpWBBlk6Ly9HMhSMoqeXHjwwHS1CZQm6lk49Qc w9Vrms1Z8uyqa6PEeWN2i3qzKvmvG7UBtCf/ML8Sf2Ue+H4uPCMcr4mxmr+r92ZDuaGsSYceEOlSwq Nhle/GEVIXy7HIOBEkHL/67h6FT9dp0tiRSIAlfVAjeEKwNu+Zw3zCuGqVgd/0RBmwd/vQCKA5Tsrk 7pj0u3jxpaN2caO4M/xN65lxaAJs1xG3xJFDl3VY8NUTd5sR+ykFgk0iSN0w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report test run summaries more regularly, so it's easier to understand
the output:
- Remove noisy "ok" reports for shift and allocator tests.
- Reorganize per-type output to the end of each type's tests.
- Replace redundant vmalloc tests with __vmalloc so that __GFP_NO_WARN
  can be used to keep the expected failure warnings out of dmesg,
  similar to commit 8e060c21ae2c ("lib/test_overflow.c: avoid tainting
  the kernel and fix wrap size")

Resulting output:

  test_overflow: 18 u8 arithmetic tests finished
  test_overflow: 19 s8 arithmetic tests finished
  test_overflow: 17 u16 arithmetic tests finished
  test_overflow: 17 s16 arithmetic tests finished
  test_overflow: 17 u32 arithmetic tests finished
  test_overflow: 17 s32 arithmetic tests finished
  test_overflow: 17 u64 arithmetic tests finished
  test_overflow: 21 s64 arithmetic tests finished
  test_overflow: 113 shift tests finished
  test_overflow: 17 overflow size helper tests finished
  test_overflow: 11 allocation overflow tests finished
  test_overflow: all tests passed

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Link: https://lore.kernel.org/all/eb6d02ae-e2ed-e7bd-c700-8a6d004d84ce@rasmusvillemoes.dk/
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/all/CAKwvOdnYYa+72VhtJ4ug=SJVFn7w+n7Th+hKYE87BRDt4hvqOg@mail.gmail.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_overflow.c | 54 +++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index 7a4b6f6c5473..cea37ae82615 100644
--- a/lib/test_overflow.c
+++ b/lib/test_overflow.c
@@ -252,10 +252,10 @@ static int __init test_ ## t ## _overflow(void) {			\
 	int err = 0;							\
 	unsigned i;							\
 									\
-	pr_info("%-3s: %zu arithmetic tests\n", #t,			\
-		ARRAY_SIZE(t ## _tests));				\
 	for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)			\
 		err |= do_test_ ## t(&t ## _tests[i]);			\
+	pr_info("%zu %s arithmetic tests finished\n",			\
+		ARRAY_SIZE(t ## _tests), #t);				\
 	return err;							\
 }
 
@@ -291,6 +291,7 @@ static int __init test_overflow_calculation(void)
 static int __init test_overflow_shift(void)
 {
 	int err = 0;
+	int count = 0;
 
 /* Args are: value, shift, type, expected result, overflow expected */
 #define TEST_ONE_SHIFT(a, s, t, expect, of) ({				\
@@ -313,9 +314,7 @@ static int __init test_overflow_shift(void)
 			pr_warn("got %llu\n", (u64)__d);		\
 		__failed = 1;						\
 	}								\
-	if (!__failed)							\
-		pr_info("ok: (%s)(%s << %s) == %s\n", #t, #a, #s,	\
-			of ? "overflow" : #expect);			\
+	count++;							\
 	__failed;							\
 })
 
@@ -479,6 +478,10 @@ static int __init test_overflow_shift(void)
 	err |= TEST_ONE_SHIFT(0, 31, s32, 0, false);
 	err |= TEST_ONE_SHIFT(0, 63, s64, 0, false);
 
+	pr_info("%d shift tests finished\n", count);
+
+#undef TEST_ONE_SHIFT
+
 	return err;
 }
 
@@ -530,7 +533,6 @@ static int __init test_ ## func (void *arg)				\
 		free ## want_arg (free_func, arg, ptr);			\
 		return 1;						\
 	}								\
-	pr_info(#func " detected saturation\n");			\
 	return 0;							\
 }
 
@@ -544,10 +546,7 @@ DEFINE_TEST_ALLOC(kmalloc,	 kfree,	     0, 1, 0);
 DEFINE_TEST_ALLOC(kmalloc_node,	 kfree,	     0, 1, 1);
 DEFINE_TEST_ALLOC(kzalloc,	 kfree,	     0, 1, 0);
 DEFINE_TEST_ALLOC(kzalloc_node,  kfree,	     0, 1, 1);
-DEFINE_TEST_ALLOC(vmalloc,	 vfree,	     0, 0, 0);
-DEFINE_TEST_ALLOC(vmalloc_node,  vfree,	     0, 0, 1);
-DEFINE_TEST_ALLOC(vzalloc,	 vfree,	     0, 0, 0);
-DEFINE_TEST_ALLOC(vzalloc_node,  vfree,	     0, 0, 1);
+DEFINE_TEST_ALLOC(__vmalloc,	 vfree,	     0, 1, 0);
 DEFINE_TEST_ALLOC(kvmalloc,	 kvfree,     0, 1, 0);
 DEFINE_TEST_ALLOC(kvmalloc_node, kvfree,     0, 1, 1);
 DEFINE_TEST_ALLOC(kvzalloc,	 kvfree,     0, 1, 0);
@@ -559,8 +558,14 @@ static int __init test_overflow_allocation(void)
 {
 	const char device_name[] = "overflow-test";
 	struct device *dev;
+	int count = 0;
 	int err = 0;
 
+#define check_allocation_overflow(alloc)	({	\
+	count++;					\
+	test_ ## alloc(dev);				\
+})
+
 	/* Create dummy device for devm_kmalloc()-family tests. */
 	dev = root_device_register(device_name);
 	if (IS_ERR(dev)) {
@@ -568,23 +573,24 @@ static int __init test_overflow_allocation(void)
 		return 1;
 	}
 
-	err |= test_kmalloc(NULL);
-	err |= test_kmalloc_node(NULL);
-	err |= test_kzalloc(NULL);
-	err |= test_kzalloc_node(NULL);
-	err |= test_kvmalloc(NULL);
-	err |= test_kvmalloc_node(NULL);
-	err |= test_kvzalloc(NULL);
-	err |= test_kvzalloc_node(NULL);
-	err |= test_vmalloc(NULL);
-	err |= test_vmalloc_node(NULL);
-	err |= test_vzalloc(NULL);
-	err |= test_vzalloc_node(NULL);
-	err |= test_devm_kmalloc(dev);
-	err |= test_devm_kzalloc(dev);
+	err |= check_allocation_overflow(kmalloc);
+	err |= check_allocation_overflow(kmalloc_node);
+	err |= check_allocation_overflow(kzalloc);
+	err |= check_allocation_overflow(kzalloc_node);
+	err |= check_allocation_overflow(__vmalloc);
+	err |= check_allocation_overflow(kvmalloc);
+	err |= check_allocation_overflow(kvmalloc_node);
+	err |= check_allocation_overflow(kvzalloc);
+	err |= check_allocation_overflow(kvzalloc_node);
+	err |= check_allocation_overflow(devm_kmalloc);
+	err |= check_allocation_overflow(devm_kzalloc);
 
 	device_unregister(dev);
 
+	pr_info("%d allocation overflow tests finished\n", count);
+
+#undef check_allocation_overflow
+
 	return err;
 }
 
-- 
2.30.2

