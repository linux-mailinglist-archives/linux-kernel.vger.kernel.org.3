Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870AE4C6FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbiB1OsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiB1OsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:48:02 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CD233E2D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:22 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i11so21798088lfu.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzfSYgDZmcLeTAJSdBrD8HdMLVfupA/uWZ0BQLISLR0=;
        b=dqj69tyhozNfuLUxXstfRi2s4MOmnG9bazMi/B6UdY0PNjYSV2vqOBHoV+HqcxX1mK
         82Fzi1Ja+ts6f53QLz0F2B+jiXy3pu4ghMEM81dbzr+aF3uulXB/MrE2kBR5ujeoCy0H
         7roSD3VP+yBcJpCssAM1Z2Bt2kZ6X/Dv85HL+90/e7TRsxU3BbicHfrTLh0iQ7nDzwfe
         lpLwAcEykQOFieJ7fhD/nMlV5rk7vXWLB67x6KuxCbanaV/84KxGiz0q207/91x6mSj3
         LX/0KEJpyCNpsiUc6ipU/4D7eARtZ/rdgl07dZZEYqCQwr+Sq1vW/a3cWPYBf7wqfijQ
         BH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzfSYgDZmcLeTAJSdBrD8HdMLVfupA/uWZ0BQLISLR0=;
        b=ZPmlRDmyki9w/FhmctllS7AUHenwspGoJwp4Z5S5ucIVjhuaZBrR12ed7U1EgbmMPJ
         nZ235QZDCgAGt7ZbQUrnqgDOaG2cx4wAxvsGzzr05WIDnxIWZN07vsuXM6lanoh3xpMQ
         kNy2qxzyFoRQsNITk/5mUq1mofMB8u0Fc7uShyHJKGh+KD1Dnpfxw2TyF8WXazwBNZN5
         I0dLQ9oFsKVKW24LRQpSCW/fgsY0JF3bs1DkJH2iEug6fFphAmfOJhyfiygK2WmDFau0
         hLxMe9JTnAWp1KVlpU+2QwIDI8XLZclqO5LaWJjH9+GJU1HymdhH2/dcgU6dSHt3iAvP
         wKWw==
X-Gm-Message-State: AOAM533lpDAXeMCx22o9rAbjOtqA2YW3La+Y/sFONWibUi5N0VQd60UD
        FJ+NBCBF16RHGwV27Af8fxk=
X-Google-Smtp-Source: ABdhPJyXYAjS6kWzrQ9btsFG3XYiC61Xd5kmGREFGnRjGySFBqwYVVWxebHYFFqFkz9w3/xDTJJWGQ==
X-Received: by 2002:ac2:5cc8:0:b0:443:770f:a7 with SMTP id f8-20020ac25cc8000000b00443770f00a7mr12427748lfq.18.1646059640785;
        Mon, 28 Feb 2022 06:47:20 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-165-244.toya.net.pl. [31.183.165.244])
        by smtp.gmail.com with ESMTPSA id r14-20020ac252ae000000b00443f3cbc03asm993996lfm.6.2022.02.28.06.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:47:20 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     rppt@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 3/9] memblock tests: Add memblock_alloc tests for top down
Date:   Mon, 28 Feb 2022 15:46:45 +0100
Message-Id: <26ccf409b8ff0394559d38d792b2afb24b55887c.1646055639.git.karolinadrobnik@gmail.com>
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

Add checks for memblock_alloc for top down allocation direction.
The tested scenarios are:
  - Region can be allocated on the first fit (with and without
    region merging)
  - Region can be allocated on the second fit (with and without
    region merging)

Add checks for both allocation directions:
  - Region can be allocated between two already existing entries
  - Limited memory available
  - All memory is reserved
  - No available memory registered with memblock

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/testing/memblock/Makefile          |   2 +-
 tools/testing/memblock/main.c            |   3 +
 tools/testing/memblock/tests/alloc_api.c | 428 +++++++++++++++++++++++
 tools/testing/memblock/tests/alloc_api.h |   9 +
 4 files changed, 441 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/memblock/tests/alloc_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_api.h

diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
index 29715327a2d3..5b01cfd808d0 100644
--- a/tools/testing/memblock/Makefile
+++ b/tools/testing/memblock/Makefile
@@ -6,7 +6,7 @@ CFLAGS += -I. -I../../include -Wall -O2 -fsanitize=address \
 	  -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT
 LDFLAGS += -fsanitize=address -fsanitize=undefined
 TARGETS = main
-TEST_OFILES = tests/basic_api.o tests/common.o
+TEST_OFILES = tests/alloc_api.o tests/basic_api.o tests/common.o
 DEP_OFILES = memblock.o lib/slab.o mmzone.o slab.o
 OFILES = main.o $(DEP_OFILES) $(TEST_OFILES)
 EXTR_SRC = ../../../mm/memblock.c
diff --git a/tools/testing/memblock/main.c b/tools/testing/memblock/main.c
index da65b0adee91..e7cc45dc06d4 100644
--- a/tools/testing/memblock/main.c
+++ b/tools/testing/memblock/main.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include "tests/basic_api.h"
+#include "tests/alloc_api.h"
 
 int main(int argc, char **argv)
 {
 	memblock_basic_checks();
+	memblock_alloc_checks();
+
 	return 0;
 }
diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
new file mode 100644
index 000000000000..22ba9a2b4eaf
--- /dev/null
+++ b/tools/testing/memblock/tests/alloc_api.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "alloc_api.h"
+
+/*
+ * A simple test that tries to allocate a small memory region.
+ * Expect to allocate an aligned region near the end of the available memory.
+ */
+static int alloc_top_down_simple_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+
+	phys_addr_t size = SZ_2;
+	phys_addr_t expected_start;
+
+	setup_memblock();
+
+	expected_start = memblock_end_of_DRAM() - SMP_CACHE_BYTES;
+
+	allocated_ptr = memblock_alloc(size, SMP_CACHE_BYTES);
+
+	assert(allocated_ptr);
+	assert(rgn->size == size);
+	assert(rgn->base == expected_start);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory next to a reserved region that starts at
+ * the misaligned address. Expect to create two separate entries, with the new
+ * entry aligned to the provided alignment:
+ *
+ *              +
+ * |            +--------+         +--------|
+ * |            |  rgn2  |         |  rgn1  |
+ * +------------+--------+---------+--------+
+ *              ^
+ *              |
+ *              Aligned address boundary
+ *
+ * The allocation direction is top-down and region arrays are sorted from lower
+ * to higher addresses, so the new region will be the first entry in
+ * memory.reserved array. The previously reserved region does not get modified.
+ * Region counter and total size get updated.
+ */
+static int alloc_top_down_disjoint_check(void)
+{
+	/* After allocation, this will point to the "old" region */
+	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
+	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
+	struct region r1;
+	void *allocated_ptr = NULL;
+
+	phys_addr_t r2_size = SZ_16;
+	/* Use custom alignment */
+	phys_addr_t alignment = SMP_CACHE_BYTES * 2;
+	phys_addr_t total_size;
+	phys_addr_t expected_start;
+
+	setup_memblock();
+
+	r1.base = memblock_end_of_DRAM() - SZ_2;
+	r1.size = SZ_2;
+
+	total_size = r1.size + r2_size;
+	expected_start = memblock_end_of_DRAM() - alignment;
+
+	memblock_reserve(r1.base, r1.size);
+
+	allocated_ptr = memblock_alloc(r2_size, alignment);
+
+	assert(allocated_ptr);
+	assert(rgn1->size == r1.size);
+	assert(rgn1->base == r1.base);
+
+	assert(rgn2->size == r2_size);
+	assert(rgn2->base == expected_start);
+
+	assert(memblock.reserved.cnt == 2);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory when there is enough space at the end
+ * of the previously reserved block (i.e. first fit):
+ *
+ *  |              +--------+--------------|
+ *  |              |   r1   |      r2      |
+ *  +--------------+--------+--------------+
+ *
+ * Expect a merge of both regions. Only the region size gets updated.
+ */
+static int alloc_top_down_before_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+
+	/* The first region ends at the aligned address to test region merging */
+	phys_addr_t r1_size = SMP_CACHE_BYTES;
+	phys_addr_t r2_size = SZ_512;
+	phys_addr_t total_size = r1_size + r2_size;
+
+	setup_memblock();
+
+	memblock_reserve(memblock_end_of_DRAM() - total_size, r1_size);
+
+	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
+
+	assert(allocated_ptr);
+	assert(rgn->size == total_size);
+	assert(rgn->base == memblock_end_of_DRAM() - total_size);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory when there is not enough space at the
+ * end of the previously reserved block (i.e. second fit):
+ *
+ *  |            +-----------+------+     |
+ *  |            |     r2    |  r1  |     |
+ *  +------------+-----------+------+-----+
+ *
+ * Expect a merge of both regions. Both the base address and size of the region
+ * get updated.
+ */
+static int alloc_top_down_after_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	struct region r1;
+	void *allocated_ptr = NULL;
+
+	phys_addr_t r2_size = SZ_512;
+	phys_addr_t total_size;
+
+	setup_memblock();
+
+	/* The first region starts at the aligned address to test region merging */
+	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES;
+	r1.size = SZ_8;
+
+	total_size = r1.size + r2_size;
+
+	memblock_reserve(r1.base, r1.size);
+
+	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
+
+	assert(allocated_ptr);
+	assert(rgn->size == total_size);
+	assert(rgn->base == r1.base - r2_size);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory when there are two reserved regions with
+ * a gap too small to fit the new region:
+ *
+ *  |       +--------+----------+   +------|
+ *  |       |   r3   |    r2    |   |  r1  |
+ *  +-------+--------+----------+---+------+
+ *
+ * Expect to allocate a region before the one that starts at the lower address,
+ * and merge them into one. The region counter and total size fields get
+ * updated.
+ */
+static int alloc_top_down_second_fit_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	struct region r1, r2;
+	void *allocated_ptr = NULL;
+
+	phys_addr_t r3_size = SZ_1K;
+	phys_addr_t total_size;
+
+	setup_memblock();
+
+	r1.base = memblock_end_of_DRAM() - SZ_512;
+	r1.size = SZ_512;
+
+	r2.base = r1.base - SZ_512;
+	r2.size = SZ_256;
+
+	total_size = r1.size + r2.size + r3_size;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
+
+	assert(allocated_ptr);
+	assert(rgn->size == r2.size + r3_size);
+	assert(rgn->base == r2.base - r3_size);
+
+	assert(memblock.reserved.cnt == 2);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory when there are two reserved regions with
+ * a gap big enough to accommodate the new region:
+ *
+ *  |     +--------+--------+--------+     |
+ *  |     |   r2   |   r3   |   r1   |     |
+ *  +-----+--------+--------+--------+-----+
+ *
+ * Expect to merge all of them, creating one big entry in memblock.reserved
+ * array. The region counter and total size fields get updated.
+ */
+static int alloc_in_between_generic_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	struct region r1, r2;
+	void *allocated_ptr = NULL;
+
+	phys_addr_t gap_size = SMP_CACHE_BYTES;
+	phys_addr_t r3_size = SZ_64;
+	/* Calculate regions size so there's just enough space for the new entry */
+	phys_addr_t rgn_size = (MEM_SIZE - (2 * gap_size + r3_size)) / 2;
+	phys_addr_t total_size;
+
+	setup_memblock();
+
+	r1.size = rgn_size;
+	r1.base = memblock_end_of_DRAM() - (gap_size + rgn_size);
+
+	r2.size = rgn_size;
+	r2.base = memblock_start_of_DRAM() + gap_size;
+
+	total_size = r1.size + r2.size + r3_size;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
+
+	assert(allocated_ptr);
+	assert(rgn->size == total_size);
+	assert(rgn->base == r1.base - r2.size - r3_size);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory when the memory is filled with reserved
+ * regions with memory gaps too small to fit the new region:
+ *
+ * +-------+
+ * |  new  |
+ * +--+----+
+ *    |    +-----+    +-----+    +-----+    |
+ *    |    | res |    | res |    | res |    |
+ *    +----+-----+----+-----+----+-----+----+
+ *
+ * Expect no allocation to happen.
+ */
+static int alloc_small_gaps_generic_check(void)
+{
+	void *allocated_ptr = NULL;
+
+	phys_addr_t region_size = SZ_1K;
+	phys_addr_t gap_size = SZ_256;
+	phys_addr_t region_end;
+
+	setup_memblock();
+
+	region_end = memblock_start_of_DRAM();
+
+	while (region_end < memblock_end_of_DRAM()) {
+		memblock_reserve(region_end + gap_size, region_size);
+		region_end += gap_size + region_size;
+	}
+
+	allocated_ptr = memblock_alloc(region_size, SMP_CACHE_BYTES);
+
+	assert(!allocated_ptr);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory when all memory is reserved.
+ * Expect no allocation to happen.
+ */
+static int alloc_all_reserved_generic_check(void)
+{
+	void *allocated_ptr = NULL;
+
+	setup_memblock();
+
+	/* Simulate full memory */
+	memblock_reserve(memblock_start_of_DRAM(), MEM_SIZE);
+
+	allocated_ptr = memblock_alloc(SZ_256, SMP_CACHE_BYTES);
+
+	assert(!allocated_ptr);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory when the memory is almost full,
+ * with not enough space left for the new region:
+ *
+ *                                +-------+
+ *                                |  new  |
+ *                                +-------+
+ *  |-----------------------------+   |
+ *  |          reserved           |   |
+ *  +-----------------------------+---+
+ *
+ * Expect no allocation to happen.
+ */
+static int alloc_no_space_generic_check(void)
+{
+	void *allocated_ptr = NULL;
+
+	setup_memblock();
+
+	phys_addr_t available_size = SZ_256;
+	phys_addr_t reserved_size = MEM_SIZE - available_size;
+
+	/* Simulate almost-full memory */
+	memblock_reserve(memblock_start_of_DRAM(), reserved_size);
+
+	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
+
+	assert(!allocated_ptr);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory when the memory is almost full,
+ * but there is just enough space left:
+ *
+ *  |---------------------------+---------|
+ *  |          reserved         |   new   |
+ *  +---------------------------+---------+
+ *
+ * Expect to allocate memory and merge all the regions. The total size field
+ * gets updated.
+ */
+static int alloc_limited_space_generic_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+
+	phys_addr_t available_size = SZ_256;
+	phys_addr_t reserved_size = MEM_SIZE - available_size;
+
+	setup_memblock();
+
+	/* Simulate almost-full memory */
+	memblock_reserve(memblock_start_of_DRAM(), reserved_size);
+
+	allocated_ptr = memblock_alloc(available_size, SMP_CACHE_BYTES);
+
+	assert(allocated_ptr);
+	assert(rgn->size == MEM_SIZE);
+	assert(rgn->base == memblock_start_of_DRAM());
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == MEM_SIZE);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory when there is no available memory
+ * registered (i.e. memblock.memory has only a dummy entry).
+ * Expect no allocation to happen.
+ */
+static int alloc_no_memory_generic_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+
+	reset_memblock_regions();
+
+	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
+
+	assert(!allocated_ptr);
+	assert(rgn->size == 0);
+	assert(rgn->base == 0);
+	assert(memblock.reserved.total_size == 0);
+
+	return 0;
+}
+
+int memblock_alloc_checks(void)
+{
+	reset_memblock_attributes();
+	dummy_physical_memory_init();
+
+	alloc_top_down_simple_check();
+	alloc_top_down_disjoint_check();
+	alloc_top_down_before_check();
+	alloc_top_down_after_check();
+	alloc_top_down_second_fit_check();
+	alloc_in_between_generic_check();
+	alloc_small_gaps_generic_check();
+	alloc_all_reserved_generic_check();
+	alloc_no_space_generic_check();
+	alloc_limited_space_generic_check();
+	alloc_no_memory_generic_check();
+
+	dummy_physical_memory_cleanup();
+
+	return 0;
+}
diff --git a/tools/testing/memblock/tests/alloc_api.h b/tools/testing/memblock/tests/alloc_api.h
new file mode 100644
index 000000000000..585b085baf21
--- /dev/null
+++ b/tools/testing/memblock/tests/alloc_api.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _MEMBLOCK_ALLOCS_H
+#define _MEMBLOCK_ALLOCS_H
+
+#include "common.h"
+
+int memblock_alloc_checks(void);
+
+#endif
-- 
2.30.2

