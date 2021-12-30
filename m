Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE6E481FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbhL3TRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:17:24 -0500
Received: from out2.migadu.com ([188.165.223.204]:61434 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237430AbhL3TRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:17:20 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640891838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=boV4BKjs1buZcE6U9f3+9ZNSDpvsszrp49sK5MVcXV4=;
        b=kxIYlakHTGfZeiYghxwp3llrMUkVsSviJAA+b7YTUBxJ727F9e+URHIwRT1HGWSLTWL0GE
        U/tu+nRq9Lqt2ehrIzytWBm23XgK7G4Ib3y1Xwi+xRsrQ6ityOp6g5M1xTz/nLV7lZJ3N9
        Vm5c3DxVCyF+UhI2X6VHjq1U5fcDluM=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v5 39/39] kasan: improve vmalloc tests
Date:   Thu, 30 Dec 2021 20:17:14 +0100
Message-Id: <2355bbf7c4a3165c6114edd518bc5fe233ede537.1640891329.git.andreyknvl@google.com>
In-Reply-To: <cover.1640891329.git.andreyknvl@google.com>
References: <cover.1640891329.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Update the existing vmalloc_oob() test to account for the specifics
of the tag-based modes. Also add a few new checks and comments.

Add new vmalloc-related tests:

- vmalloc_helpers_tags() to check that exported vmalloc helpers can
  handle tagged pointers.
- vmap_tags() to check that SW_TAGS mode properly tags vmap() mappings.
- vm_map_ram_tags() to check that SW_TAGS mode properly tags
  vm_map_ram() mappings.
- vmalloc_percpu() to check that SW_TAGS mode tags regions allocated
  for __alloc_percpu(). The tagging of per-cpu mappings is best-effort;
  proper tagging is tracked in [1].

[1] https://bugzilla.kernel.org/show_bug.cgi?id=215019

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 189 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 6 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 847cdbefab46..ae7b2e703f1b 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -19,6 +19,7 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/vmalloc.h>
+#include <linux/set_memory.h>
 
 #include <asm/page.h>
 
@@ -1049,21 +1050,181 @@ static void kmalloc_double_kzfree(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, kfree_sensitive(ptr));
 }
 
+static void vmalloc_helpers_tags(struct kunit *test)
+{
+	void *ptr;
+	int rv;
+
+	/* This test is intended for tag-based modes. */
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_GENERIC);
+
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_VMALLOC);
+
+	ptr = vmalloc(PAGE_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+
+	/* Check that the returned pointer is tagged. */
+	KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_MIN);
+	KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
+
+	/* Make sure exported vmalloc helpers handle tagged pointers. */
+	KUNIT_ASSERT_TRUE(test, is_vmalloc_addr(ptr));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vmalloc_to_page(ptr));
+
+	/* Make sure vmalloc'ed memory permissions can be changed. */
+	rv = set_memory_ro((unsigned long)ptr, 1);
+	KUNIT_ASSERT_GE(test, rv, 0);
+	rv = set_memory_rw((unsigned long)ptr, 1);
+	KUNIT_ASSERT_GE(test, rv, 0);
+
+	vfree(ptr);
+}
+
 static void vmalloc_oob(struct kunit *test)
 {
-	void *area;
+	char *v_ptr, *p_ptr;
+	struct page *page;
+	size_t size = PAGE_SIZE / 2 - KASAN_GRANULE_SIZE - 5;
 
 	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_VMALLOC);
 
+	v_ptr = vmalloc(size);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, v_ptr);
+
 	/*
-	 * We have to be careful not to hit the guard page.
+	 * We have to be careful not to hit the guard page in vmalloc tests.
 	 * The MMU will catch that and crash us.
 	 */
-	area = vmalloc(3000);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, area);
 
-	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)area)[3100]);
-	vfree(area);
+	/* Make sure in-bounds accesses are valid. */
+	v_ptr[0] = 0;
+	v_ptr[size - 1] = 0;
+
+	/*
+	 * An unaligned access past the requested vmalloc size.
+	 * Only generic KASAN can precisely detect these.
+	 */
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
+		KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v_ptr)[size]);
+
+	/* An aligned access into the first out-of-bounds granule. */
+	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v_ptr)[size + 5]);
+
+	/* Check that in-bounds accesses to the physical page are valid. */
+	page = vmalloc_to_page(v_ptr);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, page);
+	p_ptr = page_address(page);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p_ptr);
+	p_ptr[0] = 0;
+
+	vfree(v_ptr);
+
+	/*
+	 * We can't check for use-after-unmap bugs in this nor in the following
+	 * vmalloc tests, as the page might be fully unmapped and accessing it
+	 * will crash the kernel.
+	 */
+}
+
+static void vmap_tags(struct kunit *test)
+{
+	char *p_ptr, *v_ptr;
+	struct page *p_page, *v_page;
+	size_t order = 1;
+
+	/*
+	 * This test is specifically crafted for the software tag-based mode,
+	 * the only tag-based mode that poisons vmap mappings.
+	 */
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_SW_TAGS);
+
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_VMALLOC);
+
+	p_page = alloc_pages(GFP_KERNEL, order);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p_page);
+	p_ptr = page_address(p_page);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p_ptr);
+
+	v_ptr = vmap(&p_page, 1 << order, VM_MAP, PAGE_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, v_ptr);
+
+	/*
+	 * We can't check for out-of-bounds bugs in this nor in the following
+	 * vmalloc tests, as allocations have page granularity and accessing
+	 * the guard page will crash the kernel.
+	 */
+
+	KUNIT_EXPECT_GE(test, (u8)get_tag(v_ptr), (u8)KASAN_TAG_MIN);
+	KUNIT_EXPECT_LT(test, (u8)get_tag(v_ptr), (u8)KASAN_TAG_KERNEL);
+
+	/* Make sure that in-bounds accesses through both pointers work. */
+	*p_ptr = 0;
+	*v_ptr = 0;
+
+	/* Make sure vmalloc_to_page() correctly recovers the page pointer. */
+	v_page = vmalloc_to_page(v_ptr);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, v_page);
+	KUNIT_EXPECT_PTR_EQ(test, p_page, v_page);
+
+	vunmap(v_ptr);
+	free_pages((unsigned long)p_ptr, order);
+}
+
+static void vm_map_ram_tags(struct kunit *test)
+{
+	char *p_ptr, *v_ptr;
+	struct page *page;
+	size_t order = 1;
+
+	/*
+	 * This test is specifically crafted for the software tag-based mode,
+	 * the only tag-based mode that poisons vm_map_ram mappings.
+	 */
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_SW_TAGS);
+
+	page = alloc_pages(GFP_KERNEL, order);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, page);
+	p_ptr = page_address(page);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p_ptr);
+
+	v_ptr = vm_map_ram(&page, 1 << order, -1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, v_ptr);
+
+	KUNIT_EXPECT_GE(test, (u8)get_tag(v_ptr), (u8)KASAN_TAG_MIN);
+	KUNIT_EXPECT_LT(test, (u8)get_tag(v_ptr), (u8)KASAN_TAG_KERNEL);
+
+	/* Make sure that in-bounds accesses through both pointers work. */
+	*p_ptr = 0;
+	*v_ptr = 0;
+
+	vm_unmap_ram(v_ptr, 1 << order);
+	free_pages((unsigned long)p_ptr, order);
+}
+
+static void vmalloc_percpu(struct kunit *test)
+{
+	char __percpu *ptr;
+	int cpu;
+
+	/*
+	 * This test is specifically crafted for the software tag-based mode,
+	 * the only tag-based mode that poisons percpu mappings.
+	 */
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_SW_TAGS);
+
+	ptr = __alloc_percpu(PAGE_SIZE, PAGE_SIZE);
+
+	for_each_possible_cpu(cpu) {
+		char *c_ptr = per_cpu_ptr(ptr, cpu);
+
+		KUNIT_EXPECT_GE(test, (u8)get_tag(c_ptr), (u8)KASAN_TAG_MIN);
+		KUNIT_EXPECT_LT(test, (u8)get_tag(c_ptr), (u8)KASAN_TAG_KERNEL);
+
+		/* Make sure that in-bounds accesses don't crash the kernel. */
+		*c_ptr = 0;
+	}
+
+	free_percpu(ptr);
 }
 
 /*
@@ -1097,6 +1258,18 @@ static void match_all_not_assigned(struct kunit *test)
 		KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
 		free_pages((unsigned long)ptr, order);
 	}
+
+	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC))
+		return;
+
+	for (i = 0; i < 256; i++) {
+		size = (get_random_int() % 1024) + 1;
+		ptr = vmalloc(size);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+		KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_MIN);
+		KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
+		vfree(ptr);
+	}
 }
 
 /* Check that 0xff works as a match-all pointer tag for tag-based modes. */
@@ -1202,7 +1375,11 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kasan_bitops_generic),
 	KUNIT_CASE(kasan_bitops_tags),
 	KUNIT_CASE(kmalloc_double_kzfree),
+	KUNIT_CASE(vmalloc_helpers_tags),
 	KUNIT_CASE(vmalloc_oob),
+	KUNIT_CASE(vmap_tags),
+	KUNIT_CASE(vm_map_ram_tags),
+	KUNIT_CASE(vmalloc_percpu),
 	KUNIT_CASE(match_all_not_assigned),
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
-- 
2.25.1

