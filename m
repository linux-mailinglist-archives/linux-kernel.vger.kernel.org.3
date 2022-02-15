Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2804B767A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbiBOSjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:39:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiBOSjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:39:53 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CEFDAAEF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:39:42 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644950380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pwV+5NwZYvQrQ1JgfEXwuJfZqiKqAoxKp8Wr6tUObj4=;
        b=tWXktW8oDUS1MhFseJtb3CLIKZuWLrPDlv2sQlq+eyNkoNG1e/ZPG6PDlwMn2tYaAx5EW6
        9UtA67ZGSmseXId+wLFPydBzmgeXSAb/AdIjZo9BxnBvVkt5eJSjVaeN/RrpBRQIffZ97l
        +19DsKFp5Hnxmwaped+jsGsDYi/30LE=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm] fix for "kasan: improve vmalloc tests"
Date:   Tue, 15 Feb 2022 19:39:38 +0100
Message-Id: <865c91ba49b90623ab50c7526b79ccb955f544f0.1644950160.git.andreyknvl@google.com>
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

vmap_tags() and vm_map_ram_tags() pass invalid page array size to
vm_map_ram() and vm_unmap_ram(). It's supposed to be 1, but it's
1 << order == 2 currently.

Remove order variable (it can only be 0 with the current code)
and hardcode the number of pages in these tests.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 491a82006f06..8416161d5177 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -1149,7 +1149,6 @@ static void vmap_tags(struct kunit *test)
 {
 	char *p_ptr, *v_ptr;
 	struct page *p_page, *v_page;
-	size_t order = 1;
 
 	/*
 	 * This test is specifically crafted for the software tag-based mode,
@@ -1159,12 +1158,12 @@ static void vmap_tags(struct kunit *test)
 
 	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_VMALLOC);
 
-	p_page = alloc_pages(GFP_KERNEL, order);
+	p_page = alloc_pages(GFP_KERNEL, 1);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p_page);
 	p_ptr = page_address(p_page);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p_ptr);
 
-	v_ptr = vmap(&p_page, 1 << order, VM_MAP, PAGE_KERNEL);
+	v_ptr = vmap(&p_page, 1, VM_MAP, PAGE_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, v_ptr);
 
 	/*
@@ -1186,14 +1185,13 @@ static void vmap_tags(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, p_page, v_page);
 
 	vunmap(v_ptr);
-	free_pages((unsigned long)p_ptr, order);
+	free_pages((unsigned long)p_ptr, 1);
 }
 
 static void vm_map_ram_tags(struct kunit *test)
 {
 	char *p_ptr, *v_ptr;
 	struct page *page;
-	size_t order = 1;
 
 	/*
 	 * This test is specifically crafted for the software tag-based mode,
@@ -1201,12 +1199,12 @@ static void vm_map_ram_tags(struct kunit *test)
 	 */
 	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_SW_TAGS);
 
-	page = alloc_pages(GFP_KERNEL, order);
+	page = alloc_pages(GFP_KERNEL, 1);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, page);
 	p_ptr = page_address(page);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p_ptr);
 
-	v_ptr = vm_map_ram(&page, 1 << order, -1);
+	v_ptr = vm_map_ram(&page, 1, -1);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, v_ptr);
 
 	KUNIT_EXPECT_GE(test, (u8)get_tag(v_ptr), (u8)KASAN_TAG_MIN);
@@ -1216,8 +1214,8 @@ static void vm_map_ram_tags(struct kunit *test)
 	*p_ptr = 0;
 	*v_ptr = 0;
 
-	vm_unmap_ram(v_ptr, 1 << order);
-	free_pages((unsigned long)p_ptr, order);
+	vm_unmap_ram(v_ptr, 1);
+	free_pages((unsigned long)p_ptr, 1);
 }
 
 static void vmalloc_percpu(struct kunit *test)
-- 
2.25.1

