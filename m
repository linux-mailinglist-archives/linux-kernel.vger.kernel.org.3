Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E16C5ADAD1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbiIEVMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbiIEVLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:11:54 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01AA389F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:11:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662412282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TrkbSYuQGAnlXN7bh4mnqFPtjr4fL87+nLp2f5EX6NA=;
        b=hFYsB+FzPJ+FMrutd8rfqpTd1/qyrIHDsk10pkOlOch0JdxywpM+FON5VmXfk94r6IrdeN
        2KcXHltXuShi44sD2apcKfLPXWzkG+tZROT87p4SyY5zw97cgHWRkxAWVLWNNRMPYrZrft
        YKn/EmvzNmY4bEmebCNuwgrpxR4lM1c=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v3 34/34] kasan: add another use-after-free test
Date:   Mon,  5 Sep 2022 23:05:49 +0200
Message-Id: <0659cfa15809dd38faa02bc0a59d0b5dbbd81211.1662411800.git.andreyknvl@google.com>
In-Reply-To: <cover.1662411799.git.andreyknvl@google.com>
References: <cover.1662411799.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Add a new use-after-free test that checks that KASAN detects use-after-free
when another object was allocated in the same slot.

This test is mainly relevant for the tag-based modes, which do not use
quarantine.

Once [1] is resolved, this test can be extended to check that the stack
traces in the report point to the proper kmalloc/kfree calls.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=212203

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v2->v3:
- This is a new patch.
---
 lib/test_kasan.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 58c1b01ccfe2..505f77ffad27 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -612,6 +612,29 @@ static void kmalloc_uaf2(struct kunit *test)
 	kfree(ptr2);
 }
 
+/*
+ * Check that KASAN detects use-after-free when another object was allocated in
+ * the same slot. Relevant for the tag-based modes, which do not use quarantine.
+ */
+static void kmalloc_uaf3(struct kunit *test)
+{
+	char *ptr1, *ptr2;
+	size_t size = 100;
+
+	/* This test is specifically crafted for tag-based modes. */
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_GENERIC);
+
+	ptr1 = kmalloc(size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
+	kfree(ptr1);
+
+	ptr2 = kmalloc(size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
+	kfree(ptr2);
+
+	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr1)[8]);
+}
+
 static void kfree_via_page(struct kunit *test)
 {
 	char *ptr;
@@ -1382,6 +1405,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_uaf),
 	KUNIT_CASE(kmalloc_uaf_memset),
 	KUNIT_CASE(kmalloc_uaf2),
+	KUNIT_CASE(kmalloc_uaf3),
 	KUNIT_CASE(kfree_via_page),
 	KUNIT_CASE(kfree_via_phys),
 	KUNIT_CASE(kmem_cache_oob),
-- 
2.25.1

