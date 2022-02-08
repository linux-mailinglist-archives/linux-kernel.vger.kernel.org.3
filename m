Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D7C4AE169
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385469AbiBHSsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385455AbiBHSsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:48:15 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F117C0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:48:14 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644346090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gcjgT1JGS5YXvEC8btLC0N+cld9EBSbr9pVNw5PdFDA=;
        b=YwjFDHDpUVOWsxMQhjaqg62TIJEVJAMmMjMpcWMzPmWPvhtEXTN4RpsoFoe8geQvMHhHUA
        vFTns2xWRjh/j2TG5fSJymx5r0Pyd5DICtZ2YqaS0YbWKMD7kyCmMVwfCtDslI/6KVwGJ6
        nsJGiy/HAP6IZS+hEIWcWF9qLQ82RHA=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2] kasan: test: prevent cache merging in kmem_cache_double_destroy
Date:   Tue,  8 Feb 2022 19:48:08 +0100
Message-Id: <b597bd434c49591d8af00ee3993a42c609dc9a59.1644346040.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

With HW_TAGS KASAN and kasan.stacktrace=off, the cache created in the
kmem_cache_double_destroy() test might get merged with an existing one.
Thus, the first kmem_cache_destroy() call won't actually destroy it
but will only decrease the refcount. This causes the test to fail.

Provide an empty constructor for the created cache to prevent the cache
from getting merged.

Fixes: f98f966cd750 ("kasan: test: add test case for double-kmem_cache_destroy()")
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 26a5c9007653..3b413f8c8a71 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -869,11 +869,14 @@ static void kmem_cache_invalid_free(struct kunit *test)
 	kmem_cache_destroy(cache);
 }
 
+static void empty_cache_ctor(void *object) { }
+
 static void kmem_cache_double_destroy(struct kunit *test)
 {
 	struct kmem_cache *cache;
 
-	cache = kmem_cache_create("test_cache", 200, 0, 0, NULL);
+	/* Provide a constructor to prevent cache merging. */
+	cache = kmem_cache_create("test_cache", 200, 0, 0, empty_cache_ctor);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
 	kmem_cache_destroy(cache);
 	KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_destroy(cache));
-- 
2.25.1

