Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B605E5691A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiGFSXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiGFSXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:23:05 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DFD28E33
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:23:05 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z7so11662139qko.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6QLssyCPgTwVHYtmN9nUGGfabZPbS3KXlULG75HB9Jo=;
        b=mL8HIkzYN4g3cRiyyVzzxpeuOXI14Sqnatn1QJ4dEH0JuXJ43HOa8gWZoFdveOyrLO
         u+t3prHckc0JBC/F06XNPlzZdsW4uaNbV3tYA+Ah2tcRIhGkk+/MRUldytBdfQVAr1C4
         QlqcE3lQkJ8aaSfaZnGSYel3GmBmCBCbO2BQThR4T3b8CJWEhZald0/2lqPVx77aaNeo
         cToqpxyRpy5h8oVP4K4weqGMpHOfZHjPp3hfUQXzODg40BfLjYrBG2b8/KEjTt9bmf7t
         bTFUzJD9r2uIo7rtLkfDvkun+AU3ycreyX3BqqOBNcy8wpNjCJjKoolgRKiH7hPg89f4
         g95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6QLssyCPgTwVHYtmN9nUGGfabZPbS3KXlULG75HB9Jo=;
        b=LfbY+O1eSQVNQqXuX51TTVwM1WD0hbRVhTt+xRazw3Mx7l44BVe/QcYEWjv4N4choK
         jTVyYRPG5qfts2MKVT50EvUq2ed8cpiUK7UEdqOZNnOou2w30IKoSuTjL98z9dtg0CSi
         V1AUITFmQd3c4ATCkBlFYkzHHlF6OxLsMnlUTbD//ySsmarFfPJNnoyhu9WqSKJZFa6/
         0niT8khdyWStMp5eEf490NBwk+zp6TWiI9+mTfgEwhzlPctqyVS0NKOIg6D0hV4fe5du
         sD+0vr661FdJ6+q0JvFTKjYzcAoyTbyQ6xtFGFuvdl8hgWLFsJFY7Qn12f7kSxwKkkUm
         Guxw==
X-Gm-Message-State: AJIora+EhXxvA7OajBD7nt8pd94K5u42YR7jURmJb1P9v3fGRW+cuzNh
        Oj4JNqYb9Oj0I4LNlUs4SUyj3drbgavdfA==
X-Google-Smtp-Source: AGRyM1sgGM1He2HakssDW7NQLjfHwUcwTLNmAlSSIKkpO6F4atqLGRBjELlHqmuSKtZjWzrHPNGfPA==
X-Received: by 2002:a05:620a:1710:b0:6b2:583b:c0ce with SMTP id az16-20020a05620a171000b006b2583bc0cemr19966884qkb.471.1657131784116;
        Wed, 06 Jul 2022 11:23:04 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.fl.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id r18-20020ac87ef2000000b00304e33f21f7sm24192517qtc.68.2022.07.06.11.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:23:03 -0700 (PDT)
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
Date:   Wed,  6 Jul 2022 11:22:57 -0700
Message-Id: <20220706182300.70862-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706182300.70862-1-yury.norov@gmail.com>
References: <20220706182300.70862-1-yury.norov@gmail.com>
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
index db904b57d4b8..aad769c6ca84 100644
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
+	for (n = 1; n <= w; n++) {
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
index d5923a640457..b4b53d8c66ae 100644
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
+	expect_eq_uint(10,  find_nth_bit(bmap, 64 * 3, 1));
+	expect_eq_uint(20,  find_nth_bit(bmap, 64 * 3, 2));
+	expect_eq_uint(30,  find_nth_bit(bmap, 64 * 3, 3));
+	expect_eq_uint(40,  find_nth_bit(bmap, 64 * 3, 4));
+	expect_eq_uint(50,  find_nth_bit(bmap, 64 * 3, 5));
+	expect_eq_uint(60,  find_nth_bit(bmap, 64 * 3, 6));
+	expect_eq_uint(80,  find_nth_bit(bmap, 64 * 3, 7));
+	expect_eq_uint(123, find_nth_bit(bmap, 64 * 3, 8));
+
+	for_each_set_bit(bit, exp1, EXP1_IN_BITS) {
+		b = find_nth_bit(exp1, EXP1_IN_BITS, ++cnt);
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
@@ -884,6 +914,8 @@ static void __init selftest(void)
 	test_for_each_set_clump8();
 	test_bitmap_cut();
 	test_bitmap_print_buf();
+
+	test_find_nth_bit();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.34.1

