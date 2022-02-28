Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C7F4C6FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiB1Osh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbiB1OsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:48:14 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE9D1167
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:33 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id s25so17731620lji.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvrX1Yzor98efrQLyBGeybuWVwz7FwGBsCyPsnCvWmA=;
        b=Tq/MYYfTkMwkcfJLEDuM0ogDeq1m7qkW8Wk4roFxQ4cdTu7/Yr3QjgkA7/d/mGFR0V
         zU6XfLBCYpBymzmM/lgdkIFXuJaEpFq2K6Hfl/sHj8TrQ4bu588OXfnUxd5taqvroPCr
         WvdFFup4T2Oo+6DJ78ODJOM0mXvpVK84KYtvmdQVnovRin6sO1uzpo3wXNRo0OUuveE+
         xEXLwPrEzgmwlgGSMLnAuiAOJS/lXlxefAr81Uya2p6tOafTUyEogbJOee8LIHbxKb5Q
         0jc7nu6zLkwEE1VTVxUvbdXb0X/aUKo4cNQsysxjbtgJEYDnSnLuDER5oiADAtqdR+0l
         HAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvrX1Yzor98efrQLyBGeybuWVwz7FwGBsCyPsnCvWmA=;
        b=49PKfChF+qY25RR5awkheCsVZzJJyuPiri263Gisc5JGGUpOiu9cTUsk/3Gyc4LsBG
         nEoyjGKM6cnWxo0EXsYYnDvx1witAEmunKuOY9P+ZS68ZFHu2bgV7z8l+HTOAjswXQy9
         1RDFOw+ICtezs//NsEmX/5xQV2q+1/QhpGuuNxLLxOS4HkCL4+kt0XVpsTuTijQ3GEnz
         eVZJaMdUV+vr1pdhZWxF/GteakDy/E3scJaLdzU+6hil1hdmyAOsua9J3NZBa95d9qhR
         VzU4HKgeEX8J+2WlavFA3IemHlAYTbGnI9EZw490dy7oCjA9dSE9EIqEm5feS4g//+B7
         VRgA==
X-Gm-Message-State: AOAM533+qko1PxfV8pCnlW1XitXDI5mGtOrTA81PDo7pysThqpaCCd6m
        8llek+95DBrgeMY4crn4+/Rcr5Ts5is=
X-Google-Smtp-Source: ABdhPJzMQrzC03X+iY35s/ad0q+kVFv1+bEIoBaf0G9KfdX5RqaN/G0rXj+5YgmfZSFW03117E+t6Q==
X-Received: by 2002:a05:651c:1a09:b0:246:885c:846f with SMTP id by9-20020a05651c1a0900b00246885c846fmr4904177ljb.170.1646059652164;
        Mon, 28 Feb 2022 06:47:32 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-165-244.toya.net.pl. [31.183.165.244])
        by smtp.gmail.com with ESMTPSA id r14-20020ac252ae000000b00443f3cbc03asm993996lfm.6.2022.02.28.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:47:31 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     rppt@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 8/9] memblock tests: Add memblock_alloc_try_nid tests for bottom up
Date:   Mon, 28 Feb 2022 15:46:50 +0100
Message-Id: <1c0ba11b8da5dc8f71ad45175c536fa4be720984.1646055639.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1646055639.git.karolinadrobnik@gmail.com>
References: <cover.1646055639.git.karolinadrobnik@gmail.com>
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

Add checks for memblock_alloc_try_nid for bottom up allocation direction.
As the definition of this function is pretty close to the core
memblock_alloc_range_nid, the test cases implemented here cover most of
the code paths related to the memory allocations.

The tested scenarios are:
  - Region can be allocated within the requested range (both with aligned
    and misaligned boundaries)
  - Region can be allocated between two already existing entries
  - Not enough space between already reserved regions
  - Memory at the range boundaries is reserved but there is enough space
    to allocate a new region
  - The memory range is too narrow but memory can be allocated before
    the maximum address
  - Edge cases:
      + Minimum address is below memblock_start_of_DRAM()
      + Maximum address is above memblock_end_of_DRAM()

Add test case wrappers to test both directions in the same context.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/testing/memblock/tests/alloc_nid_api.c | 496 ++++++++++++++++++-
 1 file changed, 492 insertions(+), 4 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 75cfca47c703..03216efe3488 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -653,26 +653,514 @@ static int alloc_try_nid_top_down_cap_min_check(void)
 	return 0;
 }
 
-int memblock_alloc_nid_checks(void)
+/*
+ * A simple test that tries to allocate a memory region within min_addr and
+ * max_addr range:
+ *
+ *        +                       +
+ *   |    +-----------+           |      |
+ *   |    |    rgn    |           |      |
+ *   +----+-----------+-----------+------+
+ *        ^                       ^
+ *        |                       |
+ *        min_addr                max_addr
+ *
+ * Expect to allocate a cleared region that ends before max_addr.
+ */
+static int alloc_try_nid_bottom_up_simple_check(void)
 {
-	reset_memblock_attributes();
-	dummy_physical_memory_init();
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	char *b;
+
+	phys_addr_t size = SZ_128;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t rgn_end;
+
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
+	max_addr = min_addr + SZ_512;
+
+	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, NUMA_NO_NODE);
+	b = (char *)allocated_ptr;
+	rgn_end = rgn->base + rgn->size;
+
+	assert(allocated_ptr);
+	assert(*b == 0);
+
+	assert(rgn->size == size);
+	assert(rgn->base == min_addr);
+	assert(rgn_end < max_addr);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}
+
+/*
+ * A simple test that tries to allocate a memory region within min_addr and
+ * max_addr range, where the start address is misaligned:
+ *
+ *        +                     +
+ *  |     +   +-----------+     +     |
+ *  |     |   |    rgn    |     |     |
+ *  +-----+---+-----------+-----+-----+
+ *        ^   ^----.            ^
+ *        |        |            |
+ *     min_add     |            max_addr
+ *                 |
+ *                 Aligned address
+ *                 boundary
+ *
+ * Expect to allocate a cleared, aligned region that ends before max_addr.
+ */
+static int alloc_try_nid_bottom_up_start_misaligned_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	char *b;
+
+	phys_addr_t size = SZ_128;
+	phys_addr_t misalign = SZ_2;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t rgn_end;
+
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() + misalign;
+	max_addr = min_addr + SZ_512;
+
+	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, NUMA_NO_NODE);
+	b = (char *)allocated_ptr;
+	rgn_end = rgn->base + rgn->size;
+
+	assert(allocated_ptr);
+	assert(*b == 0);
+
+	assert(rgn->size == size);
+	assert(rgn->base == min_addr + (SMP_CACHE_BYTES - misalign));
+	assert(rgn_end < max_addr);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region, which can't fit into min_addr
+ * and max_addr range:
+ *
+ *                      +    +
+ *  |---------+         +    +      |
+ *  |   rgn   |         |    |      |
+ *  +---------+---------+----+------+
+ *                      ^    ^
+ *                      |    |
+ *                      |    max_addr
+ *                      |
+ *                      min_add
+ *
+ * Expect to drop the lower limit and allocate a cleared memory region which
+ * starts at the beginning of the available memory.
+ */
+static int alloc_try_nid_bottom_up_narrow_range_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	char *b;
+
+	phys_addr_t size = SZ_256;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() + SZ_512;
+	max_addr = min_addr + SMP_CACHE_BYTES;
+
+	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, NUMA_NO_NODE);
+	b = (char *)allocated_ptr;
+
+	assert(allocated_ptr);
+	assert(*b == 0);
+
+	assert(rgn->size == size);
+	assert(rgn->base == memblock_start_of_DRAM());
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory within min_addr and max_add range, when
+ * there are two reserved regions at the borders, with a gap big enough to fit
+ * a new region:
+ *
+ *                +           +
+ *  |    +--------+-------+   +------+  |
+ *  |    |   r2   |  rgn  |   |  r1  |  |
+ *  +----+--------+-------+---+------+--+
+ *                ^           ^
+ *                |           |
+ *                min_addr    max_addr
+ *
+ * Expect to merge the new region with r2. The second region does not get
+ * updated. The total size field gets updated.
+ */
+
+static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
+{
+	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
+	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	char *b;
+	struct region r1, r2;
+
+	phys_addr_t r3_size = SZ_64;
+	phys_addr_t gap_size = SMP_CACHE_BYTES;
+	phys_addr_t total_size;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	setup_memblock();
+
+	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
+	r1.size = SMP_CACHE_BYTES;
+
+	r2.size = SZ_128;
+	r2.base = r1.base - (r3_size + gap_size + r2.size);
+
+	total_size = r1.size + r2.size + r3_size;
+	min_addr = r2.base + r2.size;
+	max_addr = r1.base;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, NUMA_NO_NODE);
+	b = (char *)allocated_ptr;
+
+	assert(allocated_ptr);
+	assert(*b == 0);
+
+	assert(rgn1->size == r1.size);
+	assert(rgn1->base == max_addr);
+
+	assert(rgn2->size == r2.size + r3_size);
+	assert(rgn2->base == r2.base);
+
+	assert(memblock.reserved.cnt == 2);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory within min_addr and max_add range, when
+ * there are two reserved regions at the borders, with a gap of a size equal to
+ * the size of the new region:
+ *
+ *                         +   +
+ *  |----------+    +------+   +----+  |
+ *  |    r3    |    |  r2  |   | r1 |  |
+ *  +----------+----+------+---+----+--+
+ *                         ^   ^
+ *                         |   |
+ *                         |  max_addr
+ *                         |
+ *                         min_addr
+ *
+ * Expect to drop the lower limit and allocate memory at the beginning of the
+ * available memory. The region counter and total size fields get updated.
+ * Other regions are not modified.
+ */
+
+static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
+{
+	struct memblock_region *rgn1 = &memblock.reserved.regions[2];
+	struct memblock_region *rgn2 = &memblock.reserved.regions[1];
+	struct memblock_region *rgn3 = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	char *b;
+	struct region r1, r2;
+
+	phys_addr_t r3_size = SZ_256;
+	phys_addr_t gap_size = SMP_CACHE_BYTES;
+	phys_addr_t total_size;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	setup_memblock();
+
+	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
+	r1.size = SMP_CACHE_BYTES;
+
+	r2.size = SZ_128;
+	r2.base = r1.base - (r2.size + gap_size);
+
+	total_size = r1.size + r2.size + r3_size;
+	min_addr = r2.base + r2.size;
+	max_addr = r1.base;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, NUMA_NO_NODE);
+	b = (char *)allocated_ptr;
+
+	assert(allocated_ptr);
+	assert(*b == 0);
+
+	assert(rgn3->size == r3_size);
+	assert(rgn3->base == memblock_start_of_DRAM());
+
+	assert(rgn2->size == r2.size);
+	assert(rgn2->base == r2.base);
+
+	assert(rgn1->size == r1.size);
+	assert(rgn1->base == r1.base);
+
+	assert(memblock.reserved.cnt == 3);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region, where max_addr is
+ * bigger than the end address of the available memory. Expect to allocate
+ * a cleared region that starts at the min_addr
+ */
+static int alloc_try_nid_bottom_up_cap_max_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	char *b;
+
+	phys_addr_t size = SZ_256;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() + SZ_1K;
+	max_addr = memblock_end_of_DRAM() + SZ_256;
+
+	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, NUMA_NO_NODE);
+	b = (char *)allocated_ptr;
+
+	assert(allocated_ptr);
+	assert(*b == 0);
+
+	assert(rgn->size == size);
+	assert(rgn->base == min_addr);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region, where min_addr is
+ * smaller than the start address of the available memory. Expect to allocate
+ * a cleared region at the beginning of the available memory.
+ */
+static int alloc_try_nid_bottom_up_cap_min_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	char *b;
+
+	phys_addr_t size = SZ_1K;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM() - SZ_256;
 
+	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, NUMA_NO_NODE);
+	b = (char *)allocated_ptr;
+
+	assert(allocated_ptr);
+	assert(*b == 0);
+
+	assert(rgn->size == size);
+	assert(rgn->base == memblock_start_of_DRAM());
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}
+
+/* Test case wrappers */
+static int alloc_try_nid_simple_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_simple_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_simple_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_misaligned_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_end_misaligned_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_start_misaligned_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_narrow_range_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_narrow_range_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_narrow_range_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_reserved_with_space_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_reserved_with_space_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_reserved_with_space_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_reserved_no_space_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_reserved_no_space_check();
-	alloc_try_nid_top_down_cap_min_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_reserved_no_space_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_cap_max_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_cap_max_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_cap_max_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_cap_min_check(void)
+{
+	memblock_set_bottom_up(false);
+	alloc_try_nid_top_down_cap_min_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_cap_min_check();
+
+	return 0;
+}
 
+static int alloc_try_nid_min_reserved_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_try_nid_min_reserved_generic_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_min_reserved_generic_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_max_reserved_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_try_nid_max_reserved_generic_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_max_reserved_generic_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_exact_address_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_try_nid_exact_address_generic_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_exact_address_generic_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_reserved_full_merge_check(void)
+{
+	memblock_set_bottom_up(false);
+	alloc_try_nid_reserved_full_merge_generic_check();
+	memblock_set_bottom_up(true);
 	alloc_try_nid_reserved_full_merge_generic_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_reserved_all_check(void)
+{
+	memblock_set_bottom_up(false);
+	alloc_try_nid_reserved_all_generic_check();
+	memblock_set_bottom_up(true);
 	alloc_try_nid_reserved_all_generic_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_low_max_check(void)
+{
+	memblock_set_bottom_up(false);
+	alloc_try_nid_low_max_generic_check();
+	memblock_set_bottom_up(true);
 	alloc_try_nid_low_max_generic_check();
 
+	return 0;
+}
+
+int memblock_alloc_nid_checks(void)
+{
+	reset_memblock_attributes();
+	dummy_physical_memory_init();
+
+	alloc_try_nid_simple_check();
+	alloc_try_nid_misaligned_check();
+	alloc_try_nid_narrow_range_check();
+	alloc_try_nid_reserved_with_space_check();
+	alloc_try_nid_reserved_no_space_check();
+	alloc_try_nid_cap_max_check();
+	alloc_try_nid_cap_min_check();
+
+	alloc_try_nid_min_reserved_check();
+	alloc_try_nid_max_reserved_check();
+	alloc_try_nid_exact_address_check();
+	alloc_try_nid_reserved_full_merge_check();
+	alloc_try_nid_reserved_all_check();
+	alloc_try_nid_low_max_check();
+
 	dummy_physical_memory_cleanup();
 
 	return 0;
-- 
2.30.2

