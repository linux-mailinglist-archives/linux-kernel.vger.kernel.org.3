Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE884C6FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbiB1Osa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbiB1OsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:48:10 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6598D6166
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:29 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b11so21734306lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ST1/OP+C0iudIb8MOv4eV/34xIzCZ2XuyTNfiyg3dsQ=;
        b=QswDV6jB0oVEORqsWnscNDqbP7/QMVkhfjGwksu0whm/1ZdXmrz0KYg/Ru5tA/iJXv
         JWeKBUhKrXgobIbdsTQjQHWuxPK/zJt45wZzJgX9NZ8Wq201T3rsqSl9FizmXBKtWG2U
         2XhyP2UHUTdHyjdy06R73nZg8OWEqbY6zRA6HcGQX7sdvlRFUc9bKwQyaxfH+P3S51t+
         4ZwYS22q1uDqGy8DOLOO8DQI4gpjl/1eT/NRK/FElOhlBt9RcoDsG0B7UMu/xm7oap4F
         ZMmJIy1E4LAymcZm/Pnj42HiCKtRxkRxPKu4JhW8Zrb59Ft43OKwAOTdGt+WrIh+YECD
         flFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ST1/OP+C0iudIb8MOv4eV/34xIzCZ2XuyTNfiyg3dsQ=;
        b=uYTEgsGe7sG4kMqAHKWYlhye9xsSa0Kuuq9RDoh4Q3INeB55BwZv4ujgRAoK5qieN1
         fYwiGlztWV1Ukynp3m5xVtGhbzhXbIfilYcYcximnez7X0WFcAzgzzOTDT8ru4EJHBAI
         MVYHbp5JD/dTV0DAzoat+teKglBnlrlxajtCSL+1PWmJbTuiVwDWtyvRrcY3qBQg1NVe
         sNTplVsN8mkonl4T9C0dE/XQPwPDLDcvFuXzxYUAF3kcFVCsYCerw+BHX6+FcdEpYGlK
         qAjOfE0JBNZW+YXhX6MuPE7WHpdSP80Q8FB4wVQQCkVWPFVzMOp6JQUn2R/4erYHe1bD
         Wb+g==
X-Gm-Message-State: AOAM531KnPkucQwZpspx1GjrPT7CWJpOa8wY/59b/gh/86JyjqTClnRv
        /C7i2irbtGaubDs3Z9soHEw=
X-Google-Smtp-Source: ABdhPJwQqAw9b1tqmS3LPX7GEWNoVhO+4bNS1GvxBn8zDhE+Ev3uTo8O3kFx57tti0Mhjhw/k+LikQ==
X-Received: by 2002:ac2:44d1:0:b0:443:157e:7bc3 with SMTP id d17-20020ac244d1000000b00443157e7bc3mr12736366lfm.426.1646059647610;
        Mon, 28 Feb 2022 06:47:27 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-165-244.toya.net.pl. [31.183.165.244])
        by smtp.gmail.com with ESMTPSA id r14-20020ac252ae000000b00443f3cbc03asm993996lfm.6.2022.02.28.06.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:47:27 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     rppt@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 7/9] memblock tests: Add memblock_alloc_try_nid tests for top down
Date:   Mon, 28 Feb 2022 15:46:49 +0100
Message-Id: <d6c282e0f9f62c15bf74c216214604764232d637.1646055639.git.karolinadrobnik@gmail.com>
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

Add tests for memblock_alloc_try_nid for top down allocation direction.
As the definition of this function is pretty close to the core
memblock_alloc_range_nid, the test cases implemented here cover most of
the code paths related to the memory allocations.

The tested scenarios are:
  - Region can be allocated within the requested range (both with aligned
    and misaligned boundaries)
  - Region can be allocated between two already existing entries
  - Not enough space between already reserved regions
  - Memory range is too narrow but memory can be allocated before
    the maximum address
  - Edge cases:
      + Minimum address is below memblock_start_of_DRAM()
      + Maximum address is above memblock_end_of_DRAM()

Add checks for both allocation directions:
  - Region starts at the min_addr and ends at max_addr
  - Maximum address is too close to the beginning of the available
    memory
  - Memory at the range boundaries is reserved but there is enough space
    to allocate a new region

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/testing/memblock/Makefile              |   4 +-
 tools/testing/memblock/main.c                |   2 +
 tools/testing/memblock/tests/alloc_nid_api.c | 679 +++++++++++++++++++
 tools/testing/memblock/tests/alloc_nid_api.h |   9 +
 4 files changed, 692 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/memblock/tests/alloc_nid_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_nid_api.h

diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
index 89e374470009..a698e24b35e7 100644
--- a/tools/testing/memblock/Makefile
+++ b/tools/testing/memblock/Makefile
@@ -6,8 +6,8 @@ CFLAGS += -I. -I../../include -Wall -O2 -fsanitize=address \
 	  -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT
 LDFLAGS += -fsanitize=address -fsanitize=undefined
 TARGETS = main
-TEST_OFILES = tests/alloc_helpers_api.o tests/alloc_api.o tests/basic_api.o \
-	      tests/common.o
+TEST_OFILES = tests/alloc_nid_api.o tests/alloc_helpers_api.o tests/alloc_api.o \
+		  tests/basic_api.o tests/common.o
 DEP_OFILES = memblock.o lib/slab.o mmzone.o slab.o
 OFILES = main.o $(DEP_OFILES) $(TEST_OFILES)
 EXTR_SRC = ../../../mm/memblock.c
diff --git a/tools/testing/memblock/main.c b/tools/testing/memblock/main.c
index b63150ee554f..fb183c9e76d1 100644
--- a/tools/testing/memblock/main.c
+++ b/tools/testing/memblock/main.c
@@ -2,12 +2,14 @@
 #include "tests/basic_api.h"
 #include "tests/alloc_api.h"
 #include "tests/alloc_helpers_api.h"
+#include "tests/alloc_nid_api.h"

 int main(int argc, char **argv)
 {
 	memblock_basic_checks();
 	memblock_alloc_checks();
 	memblock_alloc_helpers_checks();
+	memblock_alloc_nid_checks();

 	return 0;
 }
diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
new file mode 100644
index 000000000000..75cfca47c703
--- /dev/null
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -0,0 +1,679 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "alloc_nid_api.h"
+
+/*
+ * A simple test that tries to allocate a memory region within min_addr and
+ * max_addr range:
+ *
+ *        +                   +
+ *   |    +       +-----------+      |
+ *   |    |       |    rgn    |      |
+ *   +----+-------+-----------+------+
+ *        ^                   ^
+ *        |                   |
+ *        min_addr           max_addr
+ *
+ * Expect to allocate a cleared region that ends at max_addr.
+ */
+static int alloc_try_nid_top_down_simple_check(void)
+{
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
+	assert(rgn->base == max_addr - size);
+	assert(rgn_end == max_addr);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}
+
+/*
+ * A simple test that tries to allocate a memory region within min_addr and
+ * max_addr range, where the end address is misaligned:
+ *
+ *         +       +            +
+ *  |      +       +---------+  +    |
+ *  |      |       |   rgn   |  |    |
+ *  +------+-------+---------+--+----+
+ *         ^       ^            ^
+ *         |       |            |
+ *       min_add   |            max_addr
+ *                 |
+ *                 Aligned address
+ *                 boundary
+ *
+ * Expect to allocate a cleared, aligned region that ends before max_addr.
+ */
+static int alloc_try_nid_top_down_end_misaligned_check(void)
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
+	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
+	max_addr = min_addr + SZ_512 + misalign;
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
+	assert(rgn->base == max_addr - size - misalign);
+	assert(rgn_end < max_addr);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}
+
+/*
+ * A simple test that tries to allocate a memory region, which spans over the
+ * min_addr and max_addr range:
+ *
+ *         +               +
+ *  |      +---------------+       |
+ *  |      |      rgn      |       |
+ *  +------+---------------+-------+
+ *         ^               ^
+ *         |               |
+ *         min_addr        max_addr
+ *
+ * Expect to allocate a cleared region that starts at min_addr and ends at
+ * max_addr, given that min_addr is aligned.
+ */
+static int alloc_try_nid_exact_address_generic_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	char *b;
+
+	phys_addr_t size = SZ_1K;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t rgn_end;
+
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES;
+	max_addr = min_addr + size;
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
+	assert(rgn_end == max_addr);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region, which can't fit into
+ * min_addr and max_addr range:
+ *
+ *           +          +     +
+ *  |        +----------+-----+    |
+ *  |        |   rgn    +     |    |
+ *  +--------+----------+-----+----+
+ *           ^          ^     ^
+ *           |          |     |
+ *           Aligned    |    max_addr
+ *           address    |
+ *           boundary   min_add
+ *
+ * Expect to drop the lower limit and allocate a cleared memory region which
+ * ends at max_addr (if the address is aligned).
+ */
+static int alloc_try_nid_top_down_narrow_range_check(void)
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
+	assert(rgn->base == max_addr - size);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region, which can't fit into
+ * min_addr and max_addr range, with the latter being too close to the beginning
+ * of the available memory:
+ *
+ *   +-------------+
+ *   |     new     |
+ *   +-------------+
+ *         +       +
+ *         |       +              |
+ *         |       |              |
+ *         +-------+--------------+
+ *         ^       ^
+ *         |       |
+ *         |       max_addr
+ *         |
+ *         min_addr
+ *
+ * Expect no allocation to happen.
+ */
+static int alloc_try_nid_low_max_generic_check(void)
+{
+	void *allocated_ptr = NULL;
+
+	phys_addr_t size = SZ_1K;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM();
+	max_addr = min_addr + SMP_CACHE_BYTES;
+
+	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, NUMA_NO_NODE);
+
+	assert(!allocated_ptr);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region within min_addr min_addr range,
+ * with min_addr being so close that it's next to an allocated region:
+ *
+ *          +                        +
+ *  |       +--------+---------------|
+ *  |       |   r1   |      rgn      |
+ *  +-------+--------+---------------+
+ *          ^                        ^
+ *          |                        |
+ *          min_addr                 max_addr
+ *
+ * Expect a merge of both regions. Only the region size gets updated.
+ */
+static int alloc_try_nid_min_reserved_generic_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	char *b;
+
+	phys_addr_t r1_size = SZ_128;
+	phys_addr_t r2_size = SZ_64;
+	phys_addr_t total_size = r1_size + r2_size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t reserved_base;
+
+	setup_memblock();
+
+	max_addr = memblock_end_of_DRAM();
+	min_addr = max_addr - r2_size;
+	reserved_base = min_addr - r1_size;
+
+	memblock_reserve(reserved_base, r1_size);
+
+	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, NUMA_NO_NODE);
+	b = (char *)allocated_ptr;
+
+	assert(allocated_ptr);
+	assert(*b == 0);
+
+	assert(rgn->size == total_size);
+	assert(rgn->base == reserved_base);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region within min_addr and max_addr,
+ * with max_addr being so close that it's next to an allocated region:
+ *
+ *             +             +
+ *  |          +-------------+--------|
+ *  |          |     rgn     |   r1   |
+ *  +----------+-------------+--------+
+ *             ^             ^
+ *             |             |
+ *             min_addr      max_addr
+ *
+ * Expect a merge of regions. Only the region size gets updated.
+ */
+static int alloc_try_nid_max_reserved_generic_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	char *b;
+
+	phys_addr_t r1_size = SZ_64;
+	phys_addr_t r2_size = SZ_128;
+	phys_addr_t total_size = r1_size + r2_size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	setup_memblock();
+
+	max_addr = memblock_end_of_DRAM() - r1_size;
+	min_addr = max_addr - r2_size;
+
+	memblock_reserve(max_addr, r1_size);
+
+	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, NUMA_NO_NODE);
+	b = (char *)allocated_ptr;
+
+	assert(allocated_ptr);
+	assert(*b == 0);
+
+	assert(rgn->size == total_size);
+	assert(rgn->base == min_addr);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == total_size);
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
+ *  |    +--------+   +-------+------+  |
+ *  |    |   r2   |   |  rgn  |  r1  |  |
+ *  +----+--------+---+-------+------+--+
+ *                ^           ^
+ *                |           |
+ *                min_addr    max_addr
+ *
+ * Expect to merge the new region with r1. The second region does not get
+ * updated. The total size field gets updated.
+ */
+
+static int alloc_try_nid_top_down_reserved_with_space_check(void)
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
+	assert(rgn1->size == r1.size + r3_size);
+	assert(rgn1->base == max_addr - r3_size);
+
+	assert(rgn2->size == r2.size);
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
+ *                 +        +
+ *  |     +--------+--------+--------+     |
+ *  |     |   r2   |   r3   |   r1   |     |
+ *  +-----+--------+--------+--------+-----+
+ *                 ^        ^
+ *                 |        |
+ *                 min_addr max_addr
+ *
+ * Expect to merge all of the regions into one. The region counter and total
+ * size fields get updated.
+ */
+static int alloc_try_nid_reserved_full_merge_generic_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	char *b;
+	struct region r1, r2;
+
+	phys_addr_t r3_size = SZ_64;
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
+	r2.base = r1.base - (r3_size + r2.size);
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
+	assert(rgn->size == total_size);
+	assert(rgn->base == r2.base);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory within min_addr and max_add range, when
+ * there are two reserved regions at the borders, with a gap that can't fit
+ * a new region:
+ *
+ *                       +    +
+ *  |  +----------+------+    +------+   |
+ *  |  |    r3    |  r2  |    |  r1  |   |
+ *  +--+----------+------+----+------+---+
+ *                       ^    ^
+ *                       |    |
+ *                       |    max_addr
+ *                       |
+ *                       min_addr
+ *
+ * Expect to merge the new region with r2. The second region does not get
+ * updated. The total size counter gets updated.
+ */
+static int alloc_try_nid_top_down_reserved_no_space_check(void)
+{
+	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
+	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
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
+	assert(rgn1->size == r1.size);
+	assert(rgn1->base == r1.base);
+
+	assert(rgn2->size == r2.size + r3_size);
+	assert(rgn2->base == r2.base - r3_size);
+
+	assert(memblock.reserved.cnt == 2);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory within min_addr and max_add range, but
+ * it's too narrow and everything else is reserved:
+ *
+ *            +-----------+
+ *            |    new    |
+ *            +-----------+
+ *                 +      +
+ *  |--------------+      +----------|
+ *  |      r2      |      |    r1    |
+ *  +--------------+------+----------+
+ *                 ^      ^
+ *                 |      |
+ *                 |      max_addr
+ *                 |
+ *                 min_addr
+ *
+ * Expect no allocation to happen.
+ */
+
+static int alloc_try_nid_reserved_all_generic_check(void)
+{
+	void *allocated_ptr = NULL;
+	struct region r1, r2;
+
+	phys_addr_t r3_size = SZ_256;
+	phys_addr_t gap_size = SMP_CACHE_BYTES;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	setup_memblock();
+
+	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES;
+	r1.size = SMP_CACHE_BYTES;
+
+	r2.size = MEM_SIZE - (r1.size + gap_size);
+	r2.base = memblock_start_of_DRAM();
+
+	min_addr = r2.base + r2.size;
+	max_addr = r1.base;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, NUMA_NO_NODE);
+
+	assert(!allocated_ptr);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region, where max_addr is
+ * bigger than the end address of the available memory. Expect to allocate
+ * a cleared region that ends before the end of the memory.
+ */
+static int alloc_try_nid_top_down_cap_max_check(void)
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
+	min_addr = memblock_end_of_DRAM() - SZ_1K;
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
+	assert(rgn->base == memblock_end_of_DRAM() - size);
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
+ * a cleared region that ends before the end of the memory.
+ */
+static int alloc_try_nid_top_down_cap_min_check(void)
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
+	min_addr = memblock_start_of_DRAM() - SZ_256;
+	max_addr = memblock_end_of_DRAM();
+
+	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, NUMA_NO_NODE);
+	b = (char *)allocated_ptr;
+
+	assert(allocated_ptr);
+	assert(*b == 0);
+
+	assert(rgn->size == size);
+	assert(rgn->base == memblock_end_of_DRAM() - size);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == size);
+
+	return 0;
+}
+
+int memblock_alloc_nid_checks(void)
+{
+	reset_memblock_attributes();
+	dummy_physical_memory_init();
+
+	alloc_try_nid_top_down_simple_check();
+	alloc_try_nid_top_down_end_misaligned_check();
+	alloc_try_nid_top_down_narrow_range_check();
+	alloc_try_nid_top_down_reserved_with_space_check();
+	alloc_try_nid_top_down_reserved_no_space_check();
+	alloc_try_nid_top_down_cap_min_check();
+	alloc_try_nid_top_down_cap_max_check();
+
+	alloc_try_nid_min_reserved_generic_check();
+	alloc_try_nid_max_reserved_generic_check();
+	alloc_try_nid_exact_address_generic_check();
+	alloc_try_nid_reserved_full_merge_generic_check();
+	alloc_try_nid_reserved_all_generic_check();
+	alloc_try_nid_low_max_generic_check();
+
+	dummy_physical_memory_cleanup();
+
+	return 0;
+}
diff --git a/tools/testing/memblock/tests/alloc_nid_api.h b/tools/testing/memblock/tests/alloc_nid_api.h
new file mode 100644
index 000000000000..b35cf3c3f489
--- /dev/null
+++ b/tools/testing/memblock/tests/alloc_nid_api.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _MEMBLOCK_ALLOC_NID_H
+#define _MEMBLOCK_ALLOC_NID_H
+
+#include "common.h"
+
+int memblock_alloc_nid_checks(void);
+
+#endif
--
2.30.2

