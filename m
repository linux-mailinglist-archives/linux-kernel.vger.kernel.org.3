Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9766C56D402
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiGKEr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiGKErS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:47:18 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2404C5FB6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:47:17 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id x17so3078130qkh.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lhvBjfQP4mIrveuhzJyEIDkKa/zzrboSQCfWcClOI6U=;
        b=A/8fxM2nCGbY7JBMHxvERs5r4l1RPJNkSK3jdC786MNoXyiR3sJGAtsDxdAdW+eMoX
         PUzTQh4qd9/YdDJfhi0ykQDOyqFDE+SwPAjaVrz0io+rJC9FEFBJVZ7I2kWA6fST40tL
         g6R0jLamktLvsk2XmgczwNqO5BL+lZc/6bYH/LXbfsPxN1HJDnKPtFOeAuj7ZQTYkVfc
         ZeZLT2U4Gb8KMdX5ZGkh9wR4SIzBPSa9sBiyDfl9kkhfVbMiWMB7heJCEzJCeljBEI9l
         +XcydROy6XBPS1FUb0srxxM2nv2vmKu8o/1hElsA0XXtJH80q0fNC+vt6zMW8fqBCIO7
         4aeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lhvBjfQP4mIrveuhzJyEIDkKa/zzrboSQCfWcClOI6U=;
        b=ORQTU1IG+KbU0EOzHtzcT/N+AXLNpnBaUTjmEhSJ2m73yLBuoM0ebmpZSJVW1pnuse
         Mf2AlldX8ikZwj3edrrLhEdrGnrBRvTNOKKjJnYhPDBfkg9TgDUzvELAS/+jWEPUgMKQ
         ZrX8n+7piSqxN4970KgLGawkfWpdvzCjfjV6+hMoUkGpaBvEYoDzPYES9fpmzp98oMgd
         fP28pkxG7apNF76zM7RzLzSuXHuxQ4dyVx9apDCt1th7yoPMmIkEHuab6DccMG7CZQp2
         vTtRHMURVUbXXYgWY7qHxQsGF6BWEaZQQcsi2atkIZzRPbQqva8ZNr3DCZoS5xDaGph7
         Ne3Q==
X-Gm-Message-State: AJIora/4Z868U+USDWGZoiYVVXRifJ2qz4pA4vdFxQ3O/cvD1sxKjq/T
        pEAGKuAUG0Rpa1uL9w0ELDzJs9mwfBEEaw==
X-Google-Smtp-Source: AGRyM1sTy72NmKAxhvRREqoybgvhQqJb8QIu1doICBGTbvFvCKX9nQ8JzgNgjE9M60R0WV/Piw+nwg==
X-Received: by 2002:a37:a003:0:b0:6b5:7c77:d937 with SMTP id j3-20020a37a003000000b006b57c77d937mr3460461qke.263.1657514836055;
        Sun, 10 Jul 2022 21:47:16 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:a22e:180:f963:1eff])
        by smtp.gmail.com with ESMTPSA id k8-20020ac84788000000b0031bf484079esm4482223qtq.18.2022.07.10.21.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 21:47:15 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/5] lib/bitmap: add tests for find_nth_bit()
Date:   Sun, 10 Jul 2022 21:47:08 -0700
Message-Id: <20220711044711.466822-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711044711.466822-1-yury.norov@gmail.com>
References: <20220711044711.466822-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functional and performance tests for find_nth_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/find_bit_benchmark.c | 17 +++++++++++++++++
 lib/test_bitmap.c        | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index db904b57d4b8..a17a0ad0f783 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -115,6 +115,22 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
 	return 0;
 }
 
+static int __init test_find_nth_bit(const unsigned long *bitmap, unsigned long len)
+{
+	unsigned long l, n, w = bitmap_weight(bitmap, len);
+	ktime_t time;
+
+	time = ktime_get();
+	for (n = 0; n < w; n++) {
+		l = find_nth_bit(bitmap, len, n);
+		WARN_ON(l >= len);
+	}
+	time = ktime_get() - time;
+	pr_err("find_nth_bit:       %18llu ns, %6ld iterations\n", time, w);
+
+	return 0;
+}
+
 static int __init test_find_next_and_bit(const void *bitmap,
 		const void *bitmap2, unsigned long len)
 {
@@ -142,6 +158,7 @@ static int __init find_bit_test(void)
 	test_find_next_bit(bitmap, BITMAP_LEN);
 	test_find_next_zero_bit(bitmap, BITMAP_LEN);
 	test_find_last_bit(bitmap, BITMAP_LEN);
+	test_find_nth_bit(bitmap, BITMAP_LEN/10);
 
 	/*
 	 * test_find_first_bit() may take some time, so
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 25967cfa4ab2..8ac8c1df818c 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -16,6 +16,8 @@
 
 #include "../tools/testing/selftests/kselftest_module.h"
 
+#define EXP1_IN_BITS	(sizeof(exp1) * 8)
+
 KSTM_MODULE_GLOBALS();
 
 static char pbl_buffer[PAGE_SIZE] __initdata;
@@ -219,6 +221,36 @@ static void __init test_zero_clear(void)
 	expect_eq_pbl("", bmap, 1024);
 }
 
+static void __init test_find_nth_bit(void)
+{
+	unsigned long b, bit, cnt = 0;
+	DECLARE_BITMAP(bmap, 64 * 3);
+
+	bitmap_zero(bmap, 64 * 3);
+	__set_bit(10, bmap);
+	__set_bit(20, bmap);
+	__set_bit(30, bmap);
+	__set_bit(40, bmap);
+	__set_bit(50, bmap);
+	__set_bit(60, bmap);
+	__set_bit(80, bmap);
+	__set_bit(123, bmap);
+
+	expect_eq_uint(10,  find_nth_bit(bmap, 64 * 3, 0));
+	expect_eq_uint(20,  find_nth_bit(bmap, 64 * 3, 1));
+	expect_eq_uint(30,  find_nth_bit(bmap, 64 * 3, 2));
+	expect_eq_uint(40,  find_nth_bit(bmap, 64 * 3, 3));
+	expect_eq_uint(50,  find_nth_bit(bmap, 64 * 3, 4));
+	expect_eq_uint(60,  find_nth_bit(bmap, 64 * 3, 5));
+	expect_eq_uint(80,  find_nth_bit(bmap, 64 * 3, 6));
+	expect_eq_uint(123, find_nth_bit(bmap, 64 * 3, 7));
+
+	for_each_set_bit(bit, exp1, EXP1_IN_BITS) {
+		b = find_nth_bit(exp1, EXP1_IN_BITS, cnt++);
+		expect_eq_uint(b, bit);
+	}
+}
+
 static void __init test_fill_set(void)
 {
 	DECLARE_BITMAP(bmap, 1024);
@@ -557,8 +589,6 @@ static void __init test_bitmap_parse(void)
 	}
 }
 
-#define EXP1_IN_BITS	(sizeof(exp1) * 8)
-
 static void __init test_bitmap_arr32(void)
 {
 	unsigned int nbits, next_bit;
@@ -946,6 +976,8 @@ static void __init selftest(void)
 	test_bitmap_cut();
 	test_bitmap_print_buf();
 	test_bitmap_const_eval();
+
+	test_find_nth_bit();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.34.1

