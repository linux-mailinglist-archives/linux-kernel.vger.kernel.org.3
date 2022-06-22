Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2351555465D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357420AbiFVJMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357373AbiFVJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:11:53 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4162526D5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:10:02 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h15-20020a9d600f000000b0060c02d737ecso12626213otj.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjEJw8V66v+QBo+QSP0shtQ8MR8Th49KB/OkiTXLCOw=;
        b=gQ9ZEIPgxP7Su+ih/WDr9qrSN0EGplakNKgAxVPAzClRzLEYEKnppQtw4PvrVxrk+w
         7VNjKlh56hC0HxMb3XoeO2TgPYe4c1XvOkPv2EJIncJH35qIKMntx8TDjIlOTLrcSyQ5
         eRfSVvbnmFdTD+SRgQe8ZnfsYRhVomO5jxMkai2AyraI4TRpMyx5R+tvi8ibAUu4fSNZ
         rcNe/R7a/hjuuXAbww4S5GPpanE9kjofsTraRfepcVUGVyBvarax11e9+8QAzyj4eKVb
         E47EjU9bmqUrxOGjaMqCFulgJa7QbYi1rHAhAn8QsVJ1/+rdCOybo6AXyjbmxG6t8ZtY
         P2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjEJw8V66v+QBo+QSP0shtQ8MR8Th49KB/OkiTXLCOw=;
        b=4udViVynoDBfjIzCBoEJUhf4/n4BLi4OBs8OnwcpdK7TCVfUz1n3BMA7IN5QSv66k3
         WuXHSlf709NQHtBcctQP5uLkmwPb8cpQX8KrdvryUKMcepUeCgXrX/Xd77zh4eIXT93e
         ehpyddM+bDRaeklWL/0oRwTgQO/dc/hFRDHPysH8BDy3XKPUeo5uYRTCMWiX4EHVHcFn
         ZZ83SLSdqnWE0zxNjK1V6BnzGSk8y/avtoAt0h6YFyAf0BUlE6ileNk4EKmYQJ0En2kc
         9tUgPk2bgIAxeCAtUzREuz662Q/TnlW5o/h5M+LvvZG9KBYBveNkMhbqr6S+8RWJ2jRn
         F21A==
X-Gm-Message-State: AJIora9zabrjaDNnYuI4I8D5iY6qIp8P1WLNWNC3UsJ4JnljI6VE4zMc
        E+6jrHDlDMAN2JdpCGO3lKg=
X-Google-Smtp-Source: AGRyM1u04qW/0qdue5BwUbxidEYgxqth9cK3bOMTUMIHmGaQCNddsljxU4LniqCd2+vwvRgnUijmTQ==
X-Received: by 2002:a05:6830:23a2:b0:60c:58d3:1c2d with SMTP id m2-20020a05683023a200b0060c58d31c2dmr1045701ots.245.1655889001080;
        Wed, 22 Jun 2022 02:10:01 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id v21-20020a056870e49500b00101f9e87b39sm4583893oag.11.2022.06.22.02.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:10:00 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 2/4] memblock tests: add verbose output to memblock tests
Date:   Wed, 22 Jun 2022 04:09:44 -0500
Message-Id: <61c33a100812a47e3449c1fe938d52284afbd691.1655887571.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655887571.git.remckee0@gmail.com>
References: <cover.1655887571.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and use functions for printing verbose testing output.

If the Memblock simulator was compiled with VERBOSE=1:
  prefix_push() appends the given string to a prefix string that will be
    printed in the test functions.
  prefix_pop() removes the last prefix from the prefix string.
  prefix_reset() clears the prefix string.
  test_fail() prints a message after a test fails containing the test
    number of the failing test and the prefix.
  test_pass() prints a message after a test passes containing its test
    number and the prefix.
  test_print() prints the given formatted output string.

If the Memblock simulator was not compiled with VERBOSE=1, these
functions do nothing.

Add the assert wrapper macros ASSERT_EQ(), ASSERT_NE(), and ASSERT_LT().
If the assert condition fails, these macros call test_fail() before
executing assert().

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_api.c      | 241 ++++++++----
 .../memblock/tests/alloc_helpers_api.c        | 135 +++++--
 tools/testing/memblock/tests/alloc_nid_api.c  | 371 ++++++++++++------
 tools/testing/memblock/tests/basic_api.c      | 365 ++++++++++++-----
 tools/testing/memblock/tests/common.c         |  58 +++
 tools/testing/memblock/tests/common.h         |  54 +++
 6 files changed, 880 insertions(+), 344 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
index d1aa7e15c18d..96df033d4300 100644
--- a/tools/testing/memblock/tests/alloc_api.c
+++ b/tools/testing/memblock/tests/alloc_api.c
@@ -10,6 +10,8 @@ static int alloc_top_down_simple_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_2;
 	phys_addr_t expected_start;
 
@@ -19,12 +21,15 @@ static int alloc_top_down_simple_check(void)
 
 	allocated_ptr = memblock_alloc(size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == size);
-	assert(rgn->base == expected_start);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, expected_start);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -55,6 +60,8 @@ static int alloc_top_down_disjoint_check(void)
 	struct region r1;
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t r2_size = SZ_16;
 	/* Use custom alignment */
 	phys_addr_t alignment = SMP_CACHE_BYTES * 2;
@@ -73,15 +80,18 @@ static int alloc_top_down_disjoint_check(void)
 
 	allocated_ptr = memblock_alloc(r2_size, alignment);
 
-	assert(allocated_ptr);
-	assert(rgn1->size == r1.size);
-	assert(rgn1->base == r1.base);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn1->size, r1.size);
+	ASSERT_EQ(rgn1->base, r1.base);
 
-	assert(rgn2->size == r2_size);
-	assert(rgn2->base == expected_start);
+	ASSERT_EQ(rgn2->size, r2_size);
+	ASSERT_EQ(rgn2->base, expected_start);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -101,6 +111,8 @@ static int alloc_top_down_before_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	/*
 	 * The first region ends at the aligned address to test region merging
 	 */
@@ -114,12 +126,15 @@ static int alloc_top_down_before_check(void)
 
 	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == total_size);
-	assert(rgn->base == memblock_end_of_DRAM() - total_size);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -141,6 +156,8 @@ static int alloc_top_down_after_check(void)
 	struct region r1;
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t r2_size = SZ_512;
 	phys_addr_t total_size;
 
@@ -158,12 +175,15 @@ static int alloc_top_down_after_check(void)
 
 	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == total_size);
-	assert(rgn->base == r1.base - r2_size);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, r1.base - r2_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -186,6 +206,8 @@ static int alloc_top_down_second_fit_check(void)
 	struct region r1, r2;
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t r3_size = SZ_1K;
 	phys_addr_t total_size;
 
@@ -204,12 +226,15 @@ static int alloc_top_down_second_fit_check(void)
 
 	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == r2.size + r3_size);
-	assert(rgn->base == r2.base - r3_size);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, r2.size + r3_size);
+	ASSERT_EQ(rgn->base, r2.base - r3_size);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -231,6 +256,8 @@ static int alloc_in_between_generic_check(void)
 	struct region r1, r2;
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t r3_size = SZ_64;
 	/*
@@ -254,12 +281,15 @@ static int alloc_in_between_generic_check(void)
 
 	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == total_size);
-	assert(rgn->base == r1.base - r2.size - r3_size);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, r1.base - r2.size - r3_size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -281,6 +311,8 @@ static int alloc_small_gaps_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t region_size = SZ_1K;
 	phys_addr_t gap_size = SZ_256;
 	phys_addr_t region_end;
@@ -296,7 +328,10 @@ static int alloc_small_gaps_generic_check(void)
 
 	allocated_ptr = memblock_alloc(region_size, SMP_CACHE_BYTES);
 
-	assert(!allocated_ptr);
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -309,6 +344,8 @@ static int alloc_all_reserved_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	setup_memblock();
 
 	/* Simulate full memory */
@@ -316,7 +353,10 @@ static int alloc_all_reserved_generic_check(void)
 
 	allocated_ptr = memblock_alloc(SZ_256, SMP_CACHE_BYTES);
 
-	assert(!allocated_ptr);
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -338,6 +378,8 @@ static int alloc_no_space_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	setup_memblock();
 
 	phys_addr_t available_size = SZ_256;
@@ -348,7 +390,10 @@ static int alloc_no_space_generic_check(void)
 
 	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
 
-	assert(!allocated_ptr);
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -369,6 +414,8 @@ static int alloc_limited_space_generic_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t available_size = SZ_256;
 	phys_addr_t reserved_size = MEM_SIZE - available_size;
 
@@ -379,12 +426,15 @@ static int alloc_limited_space_generic_check(void)
 
 	allocated_ptr = memblock_alloc(available_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == MEM_SIZE);
-	assert(rgn->base == memblock_start_of_DRAM());
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, MEM_SIZE);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, MEM_SIZE);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == MEM_SIZE);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -399,14 +449,19 @@ static int alloc_no_memory_generic_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	reset_memblock_regions();
 
 	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
 
-	assert(!allocated_ptr);
-	assert(rgn->size == 0);
-	assert(rgn->base == 0);
-	assert(memblock.reserved.total_size == 0);
+	ASSERT_EQ(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, 0);
+	ASSERT_EQ(rgn->base, 0);
+	ASSERT_EQ(memblock.reserved.total_size, 0);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -421,16 +476,21 @@ static int alloc_bottom_up_simple_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	setup_memblock();
 
 	allocated_ptr = memblock_alloc(SZ_2, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == SZ_2);
-	assert(rgn->base == memblock_start_of_DRAM());
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, SZ_2);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == SZ_2);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, SZ_2);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -459,6 +519,8 @@ static int alloc_bottom_up_disjoint_check(void)
 	struct region r1;
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t r2_size = SZ_16;
 	/* Use custom alignment */
 	phys_addr_t alignment = SMP_CACHE_BYTES * 2;
@@ -477,16 +539,19 @@ static int alloc_bottom_up_disjoint_check(void)
 
 	allocated_ptr = memblock_alloc(r2_size, alignment);
 
-	assert(allocated_ptr);
+	ASSERT_NE(allocated_ptr, NULL);
 
-	assert(rgn1->size == r1.size);
-	assert(rgn1->base == r1.base);
+	ASSERT_EQ(rgn1->size, r1.size);
+	ASSERT_EQ(rgn1->base, r1.base);
 
-	assert(rgn2->size == r2_size);
-	assert(rgn2->base == expected_start);
+	ASSERT_EQ(rgn2->size, r2_size);
+	ASSERT_EQ(rgn2->base, expected_start);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -506,6 +571,8 @@ static int alloc_bottom_up_before_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t r1_size = SZ_512;
 	phys_addr_t r2_size = SZ_128;
 	phys_addr_t total_size = r1_size + r2_size;
@@ -516,12 +583,15 @@ static int alloc_bottom_up_before_check(void)
 
 	allocated_ptr = memblock_alloc(r1_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == total_size);
-	assert(rgn->base == memblock_start_of_DRAM());
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -542,6 +612,8 @@ static int alloc_bottom_up_after_check(void)
 	struct region r1;
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t r2_size = SZ_512;
 	phys_addr_t total_size;
 
@@ -559,12 +631,15 @@ static int alloc_bottom_up_after_check(void)
 
 	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == total_size);
-	assert(rgn->base == r1.base);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, r1.base);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -588,6 +663,8 @@ static int alloc_bottom_up_second_fit_check(void)
 	struct region r1, r2;
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t r3_size = SZ_1K;
 	phys_addr_t total_size;
 
@@ -606,12 +683,15 @@ static int alloc_bottom_up_second_fit_check(void)
 
 	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == r2.size + r3_size);
-	assert(rgn->base == r2.base);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, r2.size + r3_size);
+	ASSERT_EQ(rgn->base, r2.base);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -619,6 +699,7 @@ static int alloc_bottom_up_second_fit_check(void)
 /* Test case wrappers */
 static int alloc_simple_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_top_down_simple_check();
 	memblock_set_bottom_up(true);
@@ -629,6 +710,7 @@ static int alloc_simple_check(void)
 
 static int alloc_disjoint_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_top_down_disjoint_check();
 	memblock_set_bottom_up(true);
@@ -639,6 +721,7 @@ static int alloc_disjoint_check(void)
 
 static int alloc_before_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_top_down_before_check();
 	memblock_set_bottom_up(true);
@@ -649,6 +732,7 @@ static int alloc_before_check(void)
 
 static int alloc_after_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_top_down_after_check();
 	memblock_set_bottom_up(true);
@@ -659,6 +743,7 @@ static int alloc_after_check(void)
 
 static int alloc_in_between_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_in_between_generic_check();
 	memblock_set_bottom_up(true);
@@ -669,6 +754,7 @@ static int alloc_in_between_check(void)
 
 static int alloc_second_fit_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_top_down_second_fit_check();
 	memblock_set_bottom_up(true);
@@ -679,6 +765,7 @@ static int alloc_second_fit_check(void)
 
 static int alloc_small_gaps_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_small_gaps_generic_check();
 	memblock_set_bottom_up(true);
@@ -689,6 +776,7 @@ static int alloc_small_gaps_check(void)
 
 static int alloc_all_reserved_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_all_reserved_generic_check();
 	memblock_set_bottom_up(true);
@@ -699,6 +787,7 @@ static int alloc_all_reserved_check(void)
 
 static int alloc_no_space_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_no_space_generic_check();
 	memblock_set_bottom_up(true);
@@ -709,6 +798,7 @@ static int alloc_no_space_check(void)
 
 static int alloc_limited_space_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_limited_space_generic_check();
 	memblock_set_bottom_up(true);
@@ -719,6 +809,7 @@ static int alloc_limited_space_check(void)
 
 static int alloc_no_memory_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_no_memory_generic_check();
 	memblock_set_bottom_up(true);
@@ -729,6 +820,12 @@ static int alloc_no_memory_check(void)
 
 int memblock_alloc_checks(void)
 {
+	static const char func_testing[] = "memblock_alloc";
+
+	prefix_reset();
+	prefix_push(func_testing);
+	test_print("Running %s tests...\n", func_testing);
+
 	reset_memblock_attributes();
 	dummy_physical_memory_init();
 
@@ -746,5 +843,7 @@ int memblock_alloc_checks(void)
 
 	dummy_physical_memory_cleanup();
 
+	prefix_pop();
+
 	return 0;
 }
diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
index 963a966db461..f6eaed540427 100644
--- a/tools/testing/memblock/tests/alloc_helpers_api.c
+++ b/tools/testing/memblock/tests/alloc_helpers_api.c
@@ -21,6 +21,8 @@ static int alloc_from_simple_generic_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_16;
 	phys_addr_t min_addr;
 
@@ -31,14 +33,17 @@ static int alloc_from_simple_generic_check(void)
 	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, min_addr);
 
-	assert(rgn->size == size);
-	assert(rgn->base == min_addr);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -64,6 +69,8 @@ static int alloc_from_misaligned_generic_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_32;
 	phys_addr_t min_addr;
 
@@ -75,14 +82,17 @@ static int alloc_from_misaligned_generic_check(void)
 	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
 
-	assert(rgn->size == size);
-	assert(rgn->base == memblock_end_of_DRAM() - SMP_CACHE_BYTES);
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - SMP_CACHE_BYTES);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -110,6 +120,8 @@ static int alloc_from_top_down_high_addr_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_32;
 	phys_addr_t min_addr;
 
@@ -120,12 +132,15 @@ static int alloc_from_top_down_high_addr_check(void)
 
 	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
 
-	assert(allocated_ptr);
-	assert(rgn->size == size);
-	assert(rgn->base == memblock_end_of_DRAM() - SMP_CACHE_BYTES);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - SMP_CACHE_BYTES);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -151,6 +166,8 @@ static int alloc_from_top_down_no_space_above_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t r2_size = SZ_2;
 	phys_addr_t total_size = r1_size + r2_size;
@@ -165,12 +182,15 @@ static int alloc_from_top_down_no_space_above_check(void)
 
 	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
 
-	assert(allocated_ptr);
-	assert(rgn->base == min_addr - r1_size);
-	assert(rgn->size == total_size);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->base, min_addr - r1_size);
+	ASSERT_EQ(rgn->size, total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -186,6 +206,8 @@ static int alloc_from_top_down_min_addr_cap_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t min_addr;
 	phys_addr_t start_addr;
@@ -199,12 +221,15 @@ static int alloc_from_top_down_min_addr_cap_check(void)
 
 	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
 
-	assert(allocated_ptr);
-	assert(rgn->base == start_addr);
-	assert(rgn->size == MEM_SIZE);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->base, start_addr);
+	ASSERT_EQ(rgn->size, MEM_SIZE);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == MEM_SIZE);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, MEM_SIZE);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -230,6 +255,8 @@ static int alloc_from_bottom_up_high_addr_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_32;
 	phys_addr_t min_addr;
 
@@ -240,12 +267,15 @@ static int alloc_from_bottom_up_high_addr_check(void)
 
 	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
 
-	assert(allocated_ptr);
-	assert(rgn->size == size);
-	assert(rgn->base == memblock_start_of_DRAM());
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -270,6 +300,8 @@ static int alloc_from_bottom_up_no_space_above_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t min_addr;
 	phys_addr_t r2_size;
@@ -284,12 +316,15 @@ static int alloc_from_bottom_up_no_space_above_check(void)
 
 	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
 
-	assert(allocated_ptr);
-	assert(rgn->base == memblock_start_of_DRAM());
-	assert(rgn->size == r1_size);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
+	ASSERT_EQ(rgn->size, r1_size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, r1_size + r2_size);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == r1_size + r2_size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -304,6 +339,8 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t min_addr;
 	phys_addr_t start_addr;
@@ -315,12 +352,15 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
 
 	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
 
-	assert(allocated_ptr);
-	assert(rgn->base == start_addr);
-	assert(rgn->size == r1_size);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->base, start_addr);
+	ASSERT_EQ(rgn->size, r1_size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, r1_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == r1_size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -328,6 +368,7 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
 /* Test case wrappers */
 static int alloc_from_simple_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_from_simple_generic_check();
 	memblock_set_bottom_up(true);
@@ -338,6 +379,7 @@ static int alloc_from_simple_check(void)
 
 static int alloc_from_misaligned_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_from_misaligned_generic_check();
 	memblock_set_bottom_up(true);
@@ -348,6 +390,7 @@ static int alloc_from_misaligned_check(void)
 
 static int alloc_from_high_addr_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_from_top_down_high_addr_check();
 	memblock_set_bottom_up(true);
@@ -358,6 +401,7 @@ static int alloc_from_high_addr_check(void)
 
 static int alloc_from_no_space_above_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_from_top_down_no_space_above_check();
 	memblock_set_bottom_up(true);
@@ -368,6 +412,7 @@ static int alloc_from_no_space_above_check(void)
 
 static int alloc_from_min_addr_cap_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_from_top_down_min_addr_cap_check();
 	memblock_set_bottom_up(true);
@@ -378,6 +423,12 @@ static int alloc_from_min_addr_cap_check(void)
 
 int memblock_alloc_helpers_checks(void)
 {
+	static const char func_testing[] = "memblock_alloc_from";
+
+	prefix_reset();
+	prefix_push(func_testing);
+	test_print("Running %s tests...\n", func_testing);
+
 	reset_memblock_attributes();
 	dummy_physical_memory_init();
 
diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 6390206e50e1..601f4a7ee30d 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -21,6 +21,8 @@ static int alloc_try_nid_top_down_simple_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_128;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -36,15 +38,18 @@ static int alloc_try_nid_top_down_simple_check(void)
 	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, max_addr - size);
+	ASSERT_EQ(rgn_end, max_addr);
 
-	assert(rgn->size == size);
-	assert(rgn->base == max_addr - size);
-	assert(rgn_end == max_addr);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -72,6 +77,8 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_128;
 	phys_addr_t misalign = SZ_2;
 	phys_addr_t min_addr;
@@ -88,15 +95,18 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
 	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
 
-	assert(rgn->size == size);
-	assert(rgn->base == max_addr - size - misalign);
-	assert(rgn_end < max_addr);
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, max_addr - size - misalign);
+	ASSERT_LT(rgn_end, max_addr);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -122,6 +132,8 @@ static int alloc_try_nid_exact_address_generic_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_1K;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -137,15 +149,18 @@ static int alloc_try_nid_exact_address_generic_check(void)
 	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, min_addr);
+	ASSERT_EQ(rgn_end, max_addr);
 
-	assert(rgn->size == size);
-	assert(rgn->base == min_addr);
-	assert(rgn_end == max_addr);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -173,6 +188,8 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_256;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -186,14 +203,17 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, max_addr - size);
 
-	assert(rgn->size == size);
-	assert(rgn->base == max_addr - size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -222,6 +242,8 @@ static int alloc_try_nid_low_max_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_1K;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -234,7 +256,10 @@ static int alloc_try_nid_low_max_generic_check(void)
 	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
 
-	assert(!allocated_ptr);
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -259,6 +284,8 @@ static int alloc_try_nid_min_reserved_generic_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t r1_size = SZ_128;
 	phys_addr_t r2_size = SZ_64;
 	phys_addr_t total_size = r1_size + r2_size;
@@ -278,14 +305,17 @@ static int alloc_try_nid_min_reserved_generic_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
 
-	assert(rgn->size == total_size);
-	assert(rgn->base == reserved_base);
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, reserved_base);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -310,6 +340,8 @@ static int alloc_try_nid_max_reserved_generic_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t r2_size = SZ_128;
 	phys_addr_t total_size = r1_size + r2_size;
@@ -327,14 +359,17 @@ static int alloc_try_nid_max_reserved_generic_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, min_addr);
 
-	assert(rgn->size == total_size);
-	assert(rgn->base == min_addr);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -364,6 +399,8 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
 	char *b;
 	struct region r1, r2;
 
+	prefix_push(__func__);
+
 	phys_addr_t r3_size = SZ_64;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t total_size;
@@ -389,17 +426,20 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn1->size, r1.size + r3_size);
+	ASSERT_EQ(rgn1->base, max_addr - r3_size);
 
-	assert(rgn1->size == r1.size + r3_size);
-	assert(rgn1->base == max_addr - r3_size);
+	ASSERT_EQ(rgn2->size, r2.size);
+	ASSERT_EQ(rgn2->base, r2.base);
 
-	assert(rgn2->size == r2.size);
-	assert(rgn2->base == r2.base);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -427,6 +467,8 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
 	char *b;
 	struct region r1, r2;
 
+	prefix_push(__func__);
+
 	phys_addr_t r3_size = SZ_64;
 	phys_addr_t total_size;
 	phys_addr_t max_addr;
@@ -451,14 +493,17 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
 
-	assert(rgn->size == total_size);
-	assert(rgn->base == r2.base);
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, r2.base);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -489,6 +534,8 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
 	char *b;
 	struct region r1, r2;
 
+	prefix_push(__func__);
+
 	phys_addr_t r3_size = SZ_256;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t total_size;
@@ -514,17 +561,20 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn1->size, r1.size);
+	ASSERT_EQ(rgn1->base, r1.base);
 
-	assert(rgn1->size == r1.size);
-	assert(rgn1->base == r1.base);
+	ASSERT_EQ(rgn2->size, r2.size + r3_size);
+	ASSERT_EQ(rgn2->base, r2.base - r3_size);
 
-	assert(rgn2->size == r2.size + r3_size);
-	assert(rgn2->base == r2.base - r3_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -554,6 +604,8 @@ static int alloc_try_nid_reserved_all_generic_check(void)
 	void *allocated_ptr = NULL;
 	struct region r1, r2;
 
+	prefix_push(__func__);
+
 	phys_addr_t r3_size = SZ_256;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t max_addr;
@@ -576,7 +628,10 @@ static int alloc_try_nid_reserved_all_generic_check(void)
 	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
 
-	assert(!allocated_ptr);
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -592,6 +647,8 @@ static int alloc_try_nid_top_down_cap_max_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_256;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -605,14 +662,17 @@ static int alloc_try_nid_top_down_cap_max_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
 
-	assert(rgn->size == size);
-	assert(rgn->base == memblock_end_of_DRAM() - size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -628,6 +688,8 @@ static int alloc_try_nid_top_down_cap_min_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_1K;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -641,14 +703,17 @@ static int alloc_try_nid_top_down_cap_min_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
 
-	assert(rgn->size == size);
-	assert(rgn->base == memblock_end_of_DRAM() - size);
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -673,6 +738,8 @@ static int alloc_try_nid_bottom_up_simple_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_128;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -689,15 +756,18 @@ static int alloc_try_nid_bottom_up_simple_check(void)
 	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, min_addr);
+	ASSERT_LT(rgn_end, max_addr);
 
-	assert(rgn->size == size);
-	assert(rgn->base == min_addr);
-	assert(rgn_end < max_addr);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -725,6 +795,8 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_128;
 	phys_addr_t misalign = SZ_2;
 	phys_addr_t min_addr;
@@ -742,15 +814,18 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
 	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, min_addr + (SMP_CACHE_BYTES - misalign));
+	ASSERT_LT(rgn_end, max_addr);
 
-	assert(rgn->size == size);
-	assert(rgn->base == min_addr + (SMP_CACHE_BYTES - misalign));
-	assert(rgn_end < max_addr);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -778,6 +853,8 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_256;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -792,14 +869,17 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
 					       NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
 
-	assert(rgn->size == size);
-	assert(rgn->base == memblock_start_of_DRAM());
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -829,6 +909,8 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
 	char *b;
 	struct region r1, r2;
 
+	prefix_push(__func__);
+
 	phys_addr_t r3_size = SZ_64;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t total_size;
@@ -855,17 +937,20 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
 					       NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
 
-	assert(rgn1->size == r1.size);
-	assert(rgn1->base == max_addr);
+	ASSERT_EQ(rgn1->size, r1.size);
+	ASSERT_EQ(rgn1->base, max_addr);
 
-	assert(rgn2->size == r2.size + r3_size);
-	assert(rgn2->base == r2.base);
+	ASSERT_EQ(rgn2->size, r2.size + r3_size);
+	ASSERT_EQ(rgn2->base, r2.base);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -899,6 +984,8 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
 	char *b;
 	struct region r1, r2;
 
+	prefix_push(__func__);
+
 	phys_addr_t r3_size = SZ_256;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t total_size;
@@ -925,20 +1012,23 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
 					       NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn3->size, r3_size);
+	ASSERT_EQ(rgn3->base, memblock_start_of_DRAM());
 
-	assert(rgn3->size == r3_size);
-	assert(rgn3->base == memblock_start_of_DRAM());
+	ASSERT_EQ(rgn2->size, r2.size);
+	ASSERT_EQ(rgn2->base, r2.base);
 
-	assert(rgn2->size == r2.size);
-	assert(rgn2->base == r2.base);
+	ASSERT_EQ(rgn1->size, r1.size);
+	ASSERT_EQ(rgn1->base, r1.base);
 
-	assert(rgn1->size == r1.size);
-	assert(rgn1->base == r1.base);
+	ASSERT_EQ(memblock.reserved.cnt, 3);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 3);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -954,6 +1044,8 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_256;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -968,14 +1060,17 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
 					       NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, min_addr);
 
-	assert(rgn->size == size);
-	assert(rgn->base == min_addr);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -991,6 +1086,8 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	prefix_push(__func__);
+
 	phys_addr_t size = SZ_1K;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -1005,14 +1102,17 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
 					       NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
-	assert(rgn->size == size);
-	assert(rgn->base == memblock_start_of_DRAM());
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -1020,6 +1120,7 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
 /* Test case wrappers */
 static int alloc_try_nid_simple_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_simple_check();
 	memblock_set_bottom_up(true);
@@ -1030,6 +1131,7 @@ static int alloc_try_nid_simple_check(void)
 
 static int alloc_try_nid_misaligned_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_end_misaligned_check();
 	memblock_set_bottom_up(true);
@@ -1040,6 +1142,7 @@ static int alloc_try_nid_misaligned_check(void)
 
 static int alloc_try_nid_narrow_range_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_narrow_range_check();
 	memblock_set_bottom_up(true);
@@ -1050,6 +1153,7 @@ static int alloc_try_nid_narrow_range_check(void)
 
 static int alloc_try_nid_reserved_with_space_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_reserved_with_space_check();
 	memblock_set_bottom_up(true);
@@ -1060,6 +1164,7 @@ static int alloc_try_nid_reserved_with_space_check(void)
 
 static int alloc_try_nid_reserved_no_space_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_reserved_no_space_check();
 	memblock_set_bottom_up(true);
@@ -1070,6 +1175,7 @@ static int alloc_try_nid_reserved_no_space_check(void)
 
 static int alloc_try_nid_cap_max_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_cap_max_check();
 	memblock_set_bottom_up(true);
@@ -1080,6 +1186,7 @@ static int alloc_try_nid_cap_max_check(void)
 
 static int alloc_try_nid_cap_min_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_cap_min_check();
 	memblock_set_bottom_up(true);
@@ -1090,6 +1197,7 @@ static int alloc_try_nid_cap_min_check(void)
 
 static int alloc_try_nid_min_reserved_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_min_reserved_generic_check();
 	memblock_set_bottom_up(true);
@@ -1100,6 +1208,7 @@ static int alloc_try_nid_min_reserved_check(void)
 
 static int alloc_try_nid_max_reserved_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_max_reserved_generic_check();
 	memblock_set_bottom_up(true);
@@ -1110,6 +1219,7 @@ static int alloc_try_nid_max_reserved_check(void)
 
 static int alloc_try_nid_exact_address_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_exact_address_generic_check();
 	memblock_set_bottom_up(true);
@@ -1120,6 +1230,7 @@ static int alloc_try_nid_exact_address_check(void)
 
 static int alloc_try_nid_reserved_full_merge_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_reserved_full_merge_generic_check();
 	memblock_set_bottom_up(true);
@@ -1130,6 +1241,7 @@ static int alloc_try_nid_reserved_full_merge_check(void)
 
 static int alloc_try_nid_reserved_all_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_reserved_all_generic_check();
 	memblock_set_bottom_up(true);
@@ -1140,6 +1252,7 @@ static int alloc_try_nid_reserved_all_check(void)
 
 static int alloc_try_nid_low_max_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_low_max_generic_check();
 	memblock_set_bottom_up(true);
@@ -1150,6 +1263,12 @@ static int alloc_try_nid_low_max_check(void)
 
 int memblock_alloc_nid_checks(void)
 {
+	static const char func_testing[] = "memblock_alloc_try_nid";
+
+	prefix_reset();
+	prefix_push(func_testing);
+	test_print("Running %s tests...\n", func_testing);
+
 	reset_memblock_attributes();
 	dummy_physical_memory_init();
 
@@ -1170,5 +1289,7 @@ int memblock_alloc_nid_checks(void)
 
 	dummy_physical_memory_cleanup();
 
+	prefix_pop();
+
 	return 0;
 }
diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index a7bc180316d6..f223a9a57be7 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -4,21 +4,30 @@
 #include "basic_api.h"
 
 #define EXPECTED_MEMBLOCK_REGIONS			128
+#define FUNC_ADD					"memblock_add"
+#define FUNC_RESERVE					"memblock_reserve"
+#define FUNC_REMOVE					"memblock_remove"
+#define FUNC_FREE					"memblock_free"
 
 static int memblock_initialization_check(void)
 {
-	assert(memblock.memory.regions);
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
-	assert(strcmp(memblock.memory.name, "memory") == 0);
+	prefix_push(__func__);
 
-	assert(memblock.reserved.regions);
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
-	assert(strcmp(memblock.reserved.name, "reserved") == 0);
+	ASSERT_NE(memblock.memory.regions, NULL);
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.max, EXPECTED_MEMBLOCK_REGIONS);
+	ASSERT_EQ(strcmp(memblock.memory.name, "memory"), 0);
 
-	assert(!memblock.bottom_up);
-	assert(memblock.current_limit == MEMBLOCK_ALLOC_ANYWHERE);
+	ASSERT_NE(memblock.reserved.regions, NULL);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.memory.max, EXPECTED_MEMBLOCK_REGIONS);
+	ASSERT_EQ(strcmp(memblock.reserved.name, "reserved"), 0);
+
+	ASSERT_EQ(memblock.bottom_up, false);
+	ASSERT_EQ(memblock.current_limit, MEMBLOCK_ALLOC_ANYWHERE);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -40,14 +49,19 @@ static int memblock_add_simple_check(void)
 		.size = SZ_4M
 	};
 
+	prefix_push(__func__);
+
 	reset_memblock_regions();
 	memblock_add(r.base, r.size);
 
-	assert(rgn->base == r.base);
-	assert(rgn->size == r.size);
+	ASSERT_EQ(rgn->base, r.base);
+	ASSERT_EQ(rgn->size, r.size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, r.size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == r.size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -69,18 +83,27 @@ static int memblock_add_node_simple_check(void)
 		.size = SZ_16M
 	};
 
+	prefix_pop();
+	prefix_push("memblock_add_node");
+	prefix_push(__func__);
+
 	reset_memblock_regions();
 	memblock_add_node(r.base, r.size, 1, MEMBLOCK_HOTPLUG);
 
-	assert(rgn->base == r.base);
-	assert(rgn->size == r.size);
+	ASSERT_EQ(rgn->base, r.base);
+	ASSERT_EQ(rgn->size, r.size);
 #ifdef CONFIG_NUMA
-	assert(rgn->nid == 1);
+	ASSERT_EQ(rgn->nid, 1);
 #endif
-	assert(rgn->flags == MEMBLOCK_HOTPLUG);
+	ASSERT_EQ(rgn->flags, MEMBLOCK_HOTPLUG);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, r.size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == r.size);
+	test_pass();
+	prefix_pop();
+	prefix_pop();
+	prefix_push(FUNC_ADD);
 
 	return 0;
 }
@@ -113,18 +136,23 @@ static int memblock_add_disjoint_check(void)
 		.size = SZ_8K
 	};
 
+	prefix_push(__func__);
+
 	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);
 
-	assert(rgn1->base == r1.base);
-	assert(rgn1->size == r1.size);
+	ASSERT_EQ(rgn1->base, r1.base);
+	ASSERT_EQ(rgn1->size, r1.size);
+
+	ASSERT_EQ(rgn2->base, r2.base);
+	ASSERT_EQ(rgn2->size, r2.size);
 
-	assert(rgn2->base == r2.base);
-	assert(rgn2->size == r2.size);
+	ASSERT_EQ(memblock.memory.cnt, 2);
+	ASSERT_EQ(memblock.memory.total_size, r1.size + r2.size);
 
-	assert(memblock.memory.cnt == 2);
-	assert(memblock.memory.total_size == r1.size + r2.size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -162,17 +190,22 @@ static int memblock_add_overlap_top_check(void)
 		.size = SZ_512M
 	};
 
+	prefix_push(__func__);
+
 	total_size = (r1.base - r2.base) + r1.size;
 
 	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);
 
-	assert(rgn->base == r2.base);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r2.base);
+	ASSERT_EQ(rgn->size, total_size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, total_size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == total_size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -210,17 +243,22 @@ static int memblock_add_overlap_bottom_check(void)
 		.size = SZ_1G
 	};
 
+	prefix_push(__func__);
+
 	total_size = (r2.base - r1.base) + r2.size;
 
 	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, total_size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, total_size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == total_size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -255,15 +293,20 @@ static int memblock_add_within_check(void)
 		.size = SZ_1M
 	};
 
+	prefix_push(__func__);
+
 	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == r1.size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, r1.size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, r1.size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == r1.size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -279,19 +322,28 @@ static int memblock_add_twice_check(void)
 		.size = SZ_2M
 	};
 
+	prefix_push(__func__);
+
 	reset_memblock_regions();
 
 	memblock_add(r.base, r.size);
 	memblock_add(r.base, r.size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == r.size);
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, r.size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
 
 static int memblock_add_checks(void)
 {
+	prefix_reset();
+	prefix_push(FUNC_ADD);
+	test_print("Running %s tests...\n", FUNC_ADD);
+
 	memblock_add_simple_check();
 	memblock_add_node_simple_check();
 	memblock_add_disjoint_check();
@@ -300,6 +352,8 @@ static int memblock_add_checks(void)
 	memblock_add_within_check();
 	memblock_add_twice_check();
 
+	prefix_pop();
+
 	return 0;
 }
 
@@ -320,11 +374,16 @@ static int memblock_reserve_simple_check(void)
 		.size = SZ_128M
 	};
 
+	prefix_push(__func__);
+
 	reset_memblock_regions();
 	memblock_reserve(r.base, r.size);
 
-	assert(rgn->base == r.base);
-	assert(rgn->size == r.size);
+	ASSERT_EQ(rgn->base, r.base);
+	ASSERT_EQ(rgn->size, r.size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -356,18 +415,23 @@ static int memblock_reserve_disjoint_check(void)
 		.size = SZ_512M
 	};
 
+	prefix_push(__func__);
+
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	assert(rgn1->base == r1.base);
-	assert(rgn1->size == r1.size);
+	ASSERT_EQ(rgn1->base, r1.base);
+	ASSERT_EQ(rgn1->size, r1.size);
+
+	ASSERT_EQ(rgn2->base, r2.base);
+	ASSERT_EQ(rgn2->size, r2.size);
 
-	assert(rgn2->base == r2.base);
-	assert(rgn2->size == r2.size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, r1.size + r2.size);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == r1.size + r2.size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -406,17 +470,22 @@ static int memblock_reserve_overlap_top_check(void)
 		.size = SZ_1G
 	};
 
+	prefix_push(__func__);
+
 	total_size = (r1.base - r2.base) + r1.size;
 
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	assert(rgn->base == r2.base);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r2.base);
+	ASSERT_EQ(rgn->size, total_size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -455,17 +524,22 @@ static int memblock_reserve_overlap_bottom_check(void)
 		.size = SZ_128K
 	};
 
+	prefix_push(__func__);
+
 	total_size = (r2.base - r1.base) + r2.size;
 
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, total_size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -502,15 +576,20 @@ static int memblock_reserve_within_check(void)
 		.size = SZ_64K
 	};
 
+	prefix_push(__func__);
+
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == r1.size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, r1.size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, r1.size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == r1.size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -527,19 +606,28 @@ static int memblock_reserve_twice_check(void)
 		.size = SZ_2M
 	};
 
+	prefix_push(__func__);
+
 	reset_memblock_regions();
 
 	memblock_reserve(r.base, r.size);
 	memblock_reserve(r.base, r.size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == r.size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, r.size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
 
 static int memblock_reserve_checks(void)
 {
+	prefix_reset();
+	prefix_push(FUNC_RESERVE);
+	test_print("Running %s tests...\n", FUNC_RESERVE);
+
 	memblock_reserve_simple_check();
 	memblock_reserve_disjoint_check();
 	memblock_reserve_overlap_top_check();
@@ -547,6 +635,8 @@ static int memblock_reserve_checks(void)
 	memblock_reserve_within_check();
 	memblock_reserve_twice_check();
 
+	prefix_pop();
+
 	return 0;
 }
 
@@ -581,16 +671,21 @@ static int memblock_remove_simple_check(void)
 		.size = SZ_4M
 	};
 
+	prefix_push(__func__);
+
 	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);
 	memblock_remove(r1.base, r1.size);
 
-	assert(rgn->base == r2.base);
-	assert(rgn->size == r2.size);
+	ASSERT_EQ(rgn->base, r2.base);
+	ASSERT_EQ(rgn->size, r2.size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == r2.size);
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, r2.size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -626,15 +721,20 @@ static int memblock_remove_absent_check(void)
 		.size = SZ_1G
 	};
 
+	prefix_push(__func__);
+
 	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_remove(r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == r1.size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, r1.size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, r1.size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == r1.size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -674,6 +774,8 @@ static int memblock_remove_overlap_top_check(void)
 		.size = SZ_32M
 	};
 
+	prefix_push(__func__);
+
 	r1_end = r1.base + r1.size;
 	r2_end = r2.base + r2.size;
 	total_size = r1_end - r2_end;
@@ -682,11 +784,14 @@ static int memblock_remove_overlap_top_check(void)
 	memblock_add(r1.base, r1.size);
 	memblock_remove(r2.base, r2.size);
 
-	assert(rgn->base == r1.base + r2.base);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r1.base + r2.base);
+	ASSERT_EQ(rgn->size, total_size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, total_size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == total_size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -724,17 +829,23 @@ static int memblock_remove_overlap_bottom_check(void)
 		.size = SZ_256M
 	};
 
+	prefix_push(__func__);
+
 	total_size = r2.base - r1.base;
 
 	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_remove(r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, total_size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == total_size);
 	return 0;
 }
 
@@ -774,6 +885,8 @@ static int memblock_remove_within_check(void)
 		.size = SZ_1M
 	};
 
+	prefix_push(__func__);
+
 	r1_size = r2.base - r1.base;
 	r2_size = (r1.base + r1.size) - (r2.base + r2.size);
 	total_size = r1_size + r2_size;
@@ -782,26 +895,35 @@ static int memblock_remove_within_check(void)
 	memblock_add(r1.base, r1.size);
 	memblock_remove(r2.base, r2.size);
 
-	assert(rgn1->base == r1.base);
-	assert(rgn1->size == r1_size);
+	ASSERT_EQ(rgn1->base, r1.base);
+	ASSERT_EQ(rgn1->size, r1_size);
+
+	ASSERT_EQ(rgn2->base, r2.base + r2.size);
+	ASSERT_EQ(rgn2->size, r2_size);
 
-	assert(rgn2->base == r2.base + r2.size);
-	assert(rgn2->size == r2_size);
+	ASSERT_EQ(memblock.memory.cnt, 2);
+	ASSERT_EQ(memblock.memory.total_size, total_size);
 
-	assert(memblock.memory.cnt == 2);
-	assert(memblock.memory.total_size == total_size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
 
 static int memblock_remove_checks(void)
 {
+	prefix_reset();
+	prefix_push(FUNC_REMOVE);
+	test_print("Running %s tests...\n", FUNC_REMOVE);
+
 	memblock_remove_simple_check();
 	memblock_remove_absent_check();
 	memblock_remove_overlap_top_check();
 	memblock_remove_overlap_bottom_check();
 	memblock_remove_within_check();
 
+	prefix_pop();
+
 	return 0;
 }
 
@@ -835,16 +957,21 @@ static int memblock_free_simple_check(void)
 		.size = SZ_1M
 	};
 
+	prefix_push(__func__);
+
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 	memblock_free((void *)r1.base, r1.size);
 
-	assert(rgn->base == r2.base);
-	assert(rgn->size == r2.size);
+	ASSERT_EQ(rgn->base, r2.base);
+	ASSERT_EQ(rgn->size, r2.size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, r2.size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == r2.size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -880,15 +1007,20 @@ static int memblock_free_absent_check(void)
 		.size = SZ_128M
 	};
 
+	prefix_push(__func__);
+
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_free((void *)r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == r1.size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, r1.size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, r1.size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == r1.size);
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -928,17 +1060,22 @@ static int memblock_free_overlap_top_check(void)
 		.size = SZ_8M
 	};
 
+	prefix_push(__func__);
+
 	total_size = (r1.size + r1.base) - (r2.base + r2.size);
 
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_free((void *)r2.base, r2.size);
 
-	assert(rgn->base == r2.base + r2.size);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r2.base + r2.size);
+	ASSERT_EQ(rgn->size, total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -973,17 +1110,22 @@ static int memblock_free_overlap_bottom_check(void)
 		.size = SZ_32M
 	};
 
+	prefix_push(__func__);
+
 	total_size = r2.base - r1.base;
 
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_free((void *)r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
@@ -1024,6 +1166,8 @@ static int memblock_free_within_check(void)
 		.size = SZ_1M
 	};
 
+	prefix_push(__func__);
+
 	r1_size = r2.base - r1.base;
 	r2_size = (r1.base + r1.size) - (r2.base + r2.size);
 	total_size = r1_size + r2_size;
@@ -1032,26 +1176,35 @@ static int memblock_free_within_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_free((void *)r2.base, r2.size);
 
-	assert(rgn1->base == r1.base);
-	assert(rgn1->size == r1_size);
+	ASSERT_EQ(rgn1->base, r1.base);
+	ASSERT_EQ(rgn1->size, r1_size);
 
-	assert(rgn2->base == r2.base + r2.size);
-	assert(rgn2->size == r2_size);
+	ASSERT_EQ(rgn2->base, r2.base + r2.size);
+	ASSERT_EQ(rgn2->size, r2_size);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass();
+	prefix_pop();
 
 	return 0;
 }
 
 static int memblock_free_checks(void)
 {
+	prefix_reset();
+	prefix_push(FUNC_FREE);
+	test_print("Running %s tests...\n", FUNC_FREE);
+
 	memblock_free_simple_check();
 	memblock_free_absent_check();
 	memblock_free_overlap_top_check();
 	memblock_free_overlap_bottom_check();
 	memblock_free_within_check();
 
+	prefix_pop();
+
 	return 0;
 }
 
diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index 62d3191f7c9a..e55b2a8bf0ff 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -4,8 +4,12 @@
 
 #define INIT_MEMBLOCK_REGIONS			128
 #define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
+#define PREFIXES_LEN_MAX			256
+#define DELIM					": "
+#define DELIM_LEN				strlen(DELIM)
 
 static struct test_memory memory_block;
+static char __maybe_unused prefixes[PREFIXES_LEN_MAX];
 
 void reset_memblock_regions(void)
 {
@@ -46,3 +50,57 @@ void dummy_physical_memory_cleanup(void)
 {
 	free(memory_block.base);
 }
+
+#ifdef VERBOSE
+void test_fail(void)
+{
+	ksft_test_result_fail(": %sfailed\n", prefixes);
+}
+
+void test_pass(void)
+{
+	ksft_test_result_pass(": %spassed\n", prefixes);
+}
+
+void test_print(const char *fmt, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	va_start(args, fmt);
+	errno = saved_errno;
+	vprintf(fmt, args);
+	va_end(args);
+}
+
+void prefix_reset(void)
+{
+	memset(prefixes, 0, PREFIXES_LEN_MAX);
+}
+
+void prefix_push(const char *prefix)
+{
+	int prefix_max = PREFIXES_LEN_MAX - strlen(prefixes) - DELIM_LEN - 1;
+
+	assert(strlen(prefix) <= prefix_max);
+	strncat(prefixes, prefix, prefix_max);
+	strncat(prefixes, DELIM, PREFIXES_LEN_MAX - strlen(prefixes) - 1);
+}
+
+void prefix_pop(void)
+{
+	char *ptr;
+
+	ptr = strrchr(prefixes, DELIM[0]);
+	if (!ptr)
+		prefixes[0] = 0;
+	else
+		*(ptr) = 0;
+
+	ptr = strrchr(prefixes, DELIM[0]);
+	if (!ptr)
+		prefixes[0] = 0;
+	else
+		*(ptr + DELIM_LEN) = 0;
+}
+#endif /* VERBOSE */
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 619054d03219..bdddb5f72871 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -7,9 +7,47 @@
 #include <linux/types.h>
 #include <linux/memblock.h>
 #include <linux/sizes.h>
+#include <linux/printk.h>
+#include <../selftests/kselftest.h>
 
 #define MEM_SIZE SZ_16K
 
+/**
+ * ASSERT_EQ():
+ * Check the condition
+ * @_expected == @_seen
+ * If false, print failed test message (if in VERBOSE mode) and then assert
+ */
+#define ASSERT_EQ(_expected, _seen) do { \
+	if ((_expected) != (_seen)) \
+		test_fail(); \
+	assert((_expected) == (_seen)); \
+} while (0)
+
+/**
+ * ASSERT_NE():
+ * Check the condition
+ * @_expected != @_seen
+ * If false, print failed test message (if in VERBOSE mode) and then assert
+ */
+#define ASSERT_NE(_expected, _seen) do { \
+	if ((_expected) == (_seen)) \
+		test_fail(); \
+	assert((_expected) != (_seen)); \
+} while (0)
+
+/**
+ * ASSERT_LT():
+ * Check the condition
+ * @_expected < @_seen
+ * If false, print failed test message (if in VERBOSE mode) and then assert
+ */
+#define ASSERT_LT(_expected, _seen) do { \
+	if ((_expected) >= (_seen)) \
+		test_fail(); \
+	assert((_expected) < (_seen)); \
+} while (0)
+
 /*
  * Available memory registered with memblock needs to be valid for allocs
  * test to run. This is a convenience wrapper for memory allocated in
@@ -31,4 +69,20 @@ void setup_memblock(void);
 void dummy_physical_memory_init(void);
 void dummy_physical_memory_cleanup(void);
 
+#ifdef VERBOSE
+void test_fail(void);
+void test_pass(void);
+void test_print(const char *fmt, ...);
+void prefix_reset(void);
+void prefix_push(const char *prefix);
+void prefix_pop(void);
+#else
+static inline void test_fail(void) {}
+static inline void test_pass(void) {}
+static inline void test_print(const char *fmt, ...) {}
+static inline void prefix_reset(void) {}
+static inline void prefix_push(const char *prefix) {}
+static inline void prefix_pop(void) {}
+#endif /* VERBOSE */
+
 #endif
-- 
2.34.1

