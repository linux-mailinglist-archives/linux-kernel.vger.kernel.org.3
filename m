Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEBE5A34ED
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbiH0FxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiH0FxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:53:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20C1B2CCB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:53:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso715983pjd.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3wVHF4XABk/LRHlRiBbdtsYonCdPwgnu5TKpyIN1WwE=;
        b=GKXesN1eAvnBqRoTubVh5FG+CbQJ8OBKn3ceVm9Am1Vuk+RlhcheOF4EE4k8SIRvgq
         AcaYu5vUDvwdhsDMT5mBccg8Y0bP2D8GMcRVFoWqEJ8bnkGtNYDitfpfi+dzN2kfOU0V
         VqPjCEFyPtKHv/NhrmcAf5/da411gT6OHp7jkxEEzZJ68cW1WVobjQj9XUHONHWNozMw
         60cM2RW07SwlukG7T+fMpqojYnHXqK7TYaZ7ntmEc5Yf8pU2crTzzdKIopYBrAZ0ilmW
         Lfi59kbtgpKNNG26FjfV9NfVEuV3Q2eNh2RnUWxLFGmCfs1Xmc0OnPszeE8lYB8FTuBA
         /W6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3wVHF4XABk/LRHlRiBbdtsYonCdPwgnu5TKpyIN1WwE=;
        b=MQTk1+1w4S326s8RQoT3L7h9xFtOmIZKQzuXdatv5NS6NPHuOhQ+H/Rh4TlUPOiGqf
         njhEuNHIa9bu11NBRHUd2zNlBuHSNM6ndY5u61p3jJaI9v2toPIlGA1c3809d3YithhS
         BWMf6cyjIjrb35XdVrfTbYinZckTGK0BnGiuO5iwReWStBCYVThPHm/S/M7tWjyJLH2Z
         no+lmpr5AEboApSi2lG8R85SJOQJalbsmTSNj/uON4gYiF/lIVECVGzGPeZh1I+zCMdu
         aZYrFuDpGW3FMIrwBoEWWr7L+2Vs4AzK5qwVfZkTD28cohqOnIVz59eUE3jvc3T5QHLX
         bliA==
X-Gm-Message-State: ACgBeo1t6CVdw5kFLfTmXIxlJflHX27gE7pWvSkazXGqMuvvGxd5ehnS
        XxAPQZ9mDtYenwZcrpgfIRb4vKpUKbk=
X-Google-Smtp-Source: AA6agR7bLm5/zI0wxpuYu0B4OrL0Y4uqwNYKZT4g8vgn6Jy5JIv6GNikwzR5s5aFNRCIi47IQXk1kg==
X-Received: by 2002:a17:902:708b:b0:172:5267:ed95 with SMTP id z11-20020a170902708b00b001725267ed95mr6677921plk.3.1661579596132;
        Fri, 26 Aug 2022 22:53:16 -0700 (PDT)
Received: from sophie ([89.46.114.37])
        by smtp.gmail.com with ESMTPSA id k11-20020aa7972b000000b00535bf24008asm2777413pfg.207.2022.08.26.22.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 22:53:15 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 2/4] memblock tests: add top-down NUMA tests for memblock_alloc_try_nid*
Date:   Sat, 27 Aug 2022 00:53:00 -0500
Message-Id: <d46ba668a9f3ba369f3402f107730b9629c01417.1661578435.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661578435.git.remckee0@gmail.com>
References: <cover.1661578435.git.remckee0@gmail.com>
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

Add tests for memblock_alloc_try_nid() and memblock_alloc_try_nid_raw()
where the simulated physical memory is set up with multiple NUMA nodes.
Additionally, all of these tests set nid != NUMA_NO_NODE. These tests are
run with a top-down allocation direction.

The tested scenarios are:

Range unrestricted:
- region can be allocated in the specific node requested:
      + there are no previously reserved regions
      + the requested node is partially reserved but has enough space
- the specific node requested cannot accommodate the request, but the
  region can be allocated in a different node:
      + there are no previously reserved regions, but node is too small
      + the requested node is fully reserved
      + the requested node is partially reserved and does not have
        enough space

Range restricted:
- region can be allocated in the specific node requested after dropping
  min_addr:
      + range partially overlaps with two different nodes, where the first
        node is the requested node
      + range partially overlaps with two different nodes, where the
        requested node ends before min_addr
- region cannot be allocated in the specific node requested, but it can be
  allocated in the requested range:
      + range overlaps with multiple nodes along node boundaries, and the
        requested node ends before min_addr
      + range overlaps with multiple nodes along node boundaries, and the
        requested node starts after max_addr
- region cannot be allocated in the specific node requested, but it can be
  allocated after dropping min_addr:
      + range partially overlaps with two different nodes, where the
        second node is the requested node

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_nid_api.c | 702 ++++++++++++++++++-
 tools/testing/memblock/tests/alloc_nid_api.h |  16 +
 tools/testing/memblock/tests/common.h        |  18 +
 3 files changed, 725 insertions(+), 11 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 32b3c1594fdd..e5ef93ea1ce5 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -1094,7 +1094,7 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
 	return 0;
 }
 
-/* Test case wrappers */
+/* Test case wrappers for range tests */
 static int alloc_try_nid_simple_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
@@ -1226,17 +1226,10 @@ static int alloc_try_nid_low_max_check(void)
 	return 0;
 }
 
-static int memblock_alloc_nid_checks_internal(int flags)
+static int memblock_alloc_nid_range_checks(void)
 {
-	const char *func = get_memblock_alloc_try_nid_name(flags);
-
-	alloc_nid_test_flags = flags;
-	prefix_reset();
-	prefix_push(func);
-	test_print("Running %s tests...\n", func);
-
-	reset_memblock_attributes();
-	dummy_physical_memory_init();
+	test_print("Running %s range tests...\n",
+		   get_memblock_alloc_try_nid_name(alloc_nid_test_flags));
 
 	alloc_try_nid_simple_check();
 	alloc_try_nid_misaligned_check();
@@ -1253,6 +1246,693 @@ static int memblock_alloc_nid_checks_internal(int flags)
 	alloc_try_nid_reserved_all_check();
 	alloc_try_nid_low_max_check();
 
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region in a specific NUMA node that
+ * has enough memory to allocate a region of the requested size.
+ * Expect to allocate an aligned region at the end of the requested node.
+ */
+static int alloc_try_nid_top_down_numa_simple_check(void)
+{
+	int nid_req = 3;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	void *allocated_ptr = NULL;
+
+	PREFIX_PUSH();
+
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	setup_numa_memblock();
+
+	ASSERT_LE(SZ_4, req_node->size);
+	size = req_node->size / SZ_4;
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM();
+
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, region_end(req_node) - size);
+	ASSERT_LE(req_node->base, new_rgn->base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region in a specific NUMA node that
+ * does not have enough memory to allocate a region of the requested size:
+ *
+ *  |   +-----+          +------------------+     |
+ *  |   | req |          |     expected     |     |
+ *  +---+-----+----------+------------------+-----+
+ *
+ *  |                             +---------+     |
+ *  |                             |   rgn   |     |
+ *  +-----------------------------+---------+-----+
+ *
+ * Expect to allocate an aligned region at the end of the last node that has
+ * enough memory (in this case, nid = 6) after falling back to NUMA_NO_NODE.
+ */
+static int alloc_try_nid_top_down_numa_small_node_check(void)
+{
+	int nid_req = 1;
+	int nid_exp = 6;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *exp_node = &memblock.memory.regions[nid_exp];
+	void *allocated_ptr = NULL;
+
+	PREFIX_PUSH();
+
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	setup_numa_memblock();
+
+	size = SZ_2K * MEM_FACTOR;
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM();
+
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, region_end(exp_node) - size);
+	ASSERT_LE(exp_node->base, new_rgn->base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region in a specific NUMA node that
+ * is fully reserved:
+ *
+ *  |              +---------+            +------------------+     |
+ *  |              |requested|            |     expected     |     |
+ *  +--------------+---------+------------+------------------+-----+
+ *
+ *  |              +---------+                     +---------+     |
+ *  |              | reserved|                     |   new   |     |
+ *  +--------------+---------+---------------------+---------+-----+
+ *
+ * Expect to allocate an aligned region at the end of the last node that is
+ * large enough and has enough unreserved memory (in this case, nid = 6) after
+ * falling back to NUMA_NO_NODE. The region count and total size get updated.
+ */
+static int alloc_try_nid_top_down_numa_node_reserved_check(void)
+{
+	int nid_req = 2;
+	int nid_exp = 6;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[1];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	struct memblock_region *exp_node = &memblock.memory.regions[nid_exp];
+	void *allocated_ptr = NULL;
+
+	PREFIX_PUSH();
+
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	setup_numa_memblock();
+
+	size = SZ_2K * MEM_FACTOR;
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM();
+
+	memblock_reserve(req_node->base, req_node->size);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, region_end(exp_node) - size);
+	ASSERT_LE(exp_node->base, new_rgn->base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, size + req_node->size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region in a specific NUMA node that
+ * is partially reserved but has enough memory for the allocated region:
+ *
+ *  |           +---------------------------------------+          |
+ *  |           |               requested               |          |
+ *  +-----------+---------------------------------------+----------+
+ *
+ *  |           +------------------+              +-----+          |
+ *  |           |     reserved     |              | new |          |
+ *  +-----------+------------------+--------------+-----+----------+
+ *
+ * Expect to allocate an aligned region at the end of the requested node. The
+ * region count and total size get updated.
+ */
+static int alloc_try_nid_top_down_numa_part_reserved_check(void)
+{
+	int nid_req = 4;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[1];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	void *allocated_ptr = NULL;
+	struct region r1;
+
+	PREFIX_PUSH();
+
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	setup_numa_memblock();
+
+	r1.base = req_node->base;
+	r1.size = SZ_512 * MEM_FACTOR;
+	size = SZ_128 * MEM_FACTOR;
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM();
+
+	memblock_reserve(r1.base, r1.size);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, region_end(req_node) - size);
+	ASSERT_LE(req_node->base, new_rgn->base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, size + r1.size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region in a specific NUMA node that
+ * is partially reserved and does not have enough contiguous memory for the
+ * allocated region:
+ *
+ *  |           +-----------------------+         +----------------------|
+ *  |           |       requested       |         |       expected       |
+ *  +-----------+-----------------------+---------+----------------------+
+ *
+ *  |                 +----------+                           +-----------|
+ *  |                 | reserved |                           |    new    |
+ *  +-----------------+----------+---------------------------+-----------+
+ *
+ * Expect to allocate an aligned region at the end of the last node that is
+ * large enough and has enough unreserved memory (in this case,
+ * nid = NUMA_NODES - 1) after falling back to NUMA_NO_NODE. The region count
+ * and total size get updated.
+ */
+static int alloc_try_nid_top_down_numa_part_reserved_fallback_check(void)
+{
+	int nid_req = 4;
+	int nid_exp = NUMA_NODES - 1;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[1];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	struct memblock_region *exp_node = &memblock.memory.regions[nid_exp];
+	void *allocated_ptr = NULL;
+	struct region r1;
+
+	PREFIX_PUSH();
+
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	setup_numa_memblock();
+
+	size = SZ_512 * MEM_FACTOR;
+	r1.base = req_node->base + SZ_256 * MEM_FACTOR;
+	r1.size = size;
+
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM();
+
+	memblock_reserve(r1.base, r1.size);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, region_end(exp_node) - size);
+	ASSERT_LE(exp_node->base, new_rgn->base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, size + r1.size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region that spans over the min_addr
+ * and max_addr range and overlaps with two different nodes, where the first
+ * node is the requested node:
+ *
+ *                                min_addr
+ *                                |           max_addr
+ *                                |           |
+ *                                v           v
+ *  |           +-----------------------+-----------+              |
+ *  |           |       requested       |   node3   |              |
+ *  +-----------+-----------------------+-----------+--------------+
+ *                                +           +
+ *  |                       +-----------+                          |
+ *  |                       |    rgn    |                          |
+ *  +-----------------------+-----------+--------------------------+
+ *
+ * Expect to drop the lower limit and allocate a cleared memory region that
+ * ends at the end of the requested node.
+ */
+static int alloc_try_nid_top_down_numa_split_range_low_check(void)
+{
+	int nid_req = 2;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	void *allocated_ptr = NULL;
+
+	PREFIX_PUSH();
+
+	phys_addr_t size = SZ_512;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t req_node_end;
+
+	setup_numa_memblock();
+
+	req_node_end = region_end(req_node);
+	min_addr = req_node_end - SZ_256;
+	max_addr = min_addr + size;
+
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, req_node_end - size);
+	ASSERT_LE(req_node->base, new_rgn->base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region that spans over the min_addr
+ * and max_addr range and overlaps with two different nodes, where the second
+ * node is the requested node:
+ *
+ *                               min_addr
+ *                               |         max_addr
+ *                               |         |
+ *                               v         v
+ *  |      +--------------------------+---------+                |
+ *  |      |         expected         |requested|                |
+ *  +------+--------------------------+---------+----------------+
+ *                               +         +
+ *  |                       +---------+                          |
+ *  |                       |   rgn   |                          |
+ *  +-----------------------+---------+--------------------------+
+ *
+ * Expect to drop the lower limit and allocate a cleared memory region that
+ * ends at the end of the first node that overlaps with the range.
+ */
+static int alloc_try_nid_top_down_numa_split_range_high_check(void)
+{
+	int nid_req = 3;
+	int nid_exp = nid_req - 1;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *exp_node = &memblock.memory.regions[nid_exp];
+	void *allocated_ptr = NULL;
+
+	PREFIX_PUSH();
+
+	phys_addr_t size = SZ_512;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t exp_node_end;
+
+	setup_numa_memblock();
+
+	exp_node_end = region_end(exp_node);
+	min_addr = exp_node_end - SZ_256;
+	max_addr = min_addr + size;
+
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, exp_node_end - size);
+	ASSERT_LE(exp_node->base, new_rgn->base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region that spans over the min_addr
+ * and max_addr range and overlaps with two different nodes, where the requested
+ * node ends before min_addr:
+ *
+ *                                         min_addr
+ *                                         |         max_addr
+ *                                         |         |
+ *                                         v         v
+ *  |    +---------------+        +-------------+---------+          |
+ *  |    |   requested   |        |    node1    |  node2  |          |
+ *  +----+---------------+--------+-------------+---------+----------+
+ *                                         +         +
+ *  |          +---------+                                           |
+ *  |          |   rgn   |                                           |
+ *  +----------+---------+-------------------------------------------+
+ *
+ * Expect to drop the lower limit and allocate a cleared memory region that
+ * ends at the end of the requested node.
+ */
+static int alloc_try_nid_top_down_numa_no_overlap_split_check(void)
+{
+	int nid_req = 2;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	struct memblock_region *node2 = &memblock.memory.regions[6];
+	void *allocated_ptr = NULL;
+
+	PREFIX_PUSH();
+
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	setup_numa_memblock();
+
+	size = SZ_512;
+	min_addr = node2->base - SZ_256;
+	max_addr = min_addr + size;
+
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, region_end(req_node) - size);
+	ASSERT_LE(req_node->base, new_rgn->base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory within min_addr and max_add range when
+ * the requested node and the range do not overlap, and requested node ends
+ * before min_addr. The range overlaps with multiple nodes along node
+ * boundaries:
+ *
+ *                          min_addr
+ *                          |                                 max_addr
+ *                          |                                 |
+ *                          v                                 v
+ *  |-----------+           +----------+----...----+----------+      |
+ *  | requested |           | min node |    ...    | max node |      |
+ *  +-----------+-----------+----------+----...----+----------+------+
+ *                          +                                 +
+ *  |                                                   +-----+      |
+ *  |                                                   | rgn |      |
+ *  +---------------------------------------------------+-----+------+
+ *
+ * Expect to allocate a cleared memory region at the end of the final node in
+ * the range after falling back to NUMA_NO_NODE.
+ */
+static int alloc_try_nid_top_down_numa_no_overlap_low_check(void)
+{
+	int nid_req = 0;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *min_node = &memblock.memory.regions[2];
+	struct memblock_region *max_node = &memblock.memory.regions[5];
+	void *allocated_ptr = NULL;
+
+	PREFIX_PUSH();
+
+	phys_addr_t size = SZ_64;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	setup_numa_memblock();
+
+	min_addr = min_node->base;
+	max_addr = region_end(max_node);
+
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, max_addr - size);
+	ASSERT_LE(max_node->base, new_rgn->base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory within min_addr and max_add range when
+ * the requested node and the range do not overlap, and requested node starts
+ * after max_addr. The range overlaps with multiple nodes along node
+ * boundaries:
+ *
+ *        min_addr
+ *        |                                 max_addr
+ *        |                                 |
+ *        v                                 v
+ *  |     +----------+----...----+----------+        +-----------+   |
+ *  |     | min node |    ...    | max node |        | requested |   |
+ *  +-----+----------+----...----+----------+--------+-----------+---+
+ *        +                                 +
+ *  |                                 +-----+                        |
+ *  |                                 | rgn |                        |
+ *  +---------------------------------+-----+------------------------+
+ *
+ * Expect to allocate a cleared memory region at the end of the final node in
+ * the range after falling back to NUMA_NO_NODE.
+ */
+static int alloc_try_nid_top_down_numa_no_overlap_high_check(void)
+{
+	int nid_req = 7;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *min_node = &memblock.memory.regions[2];
+	struct memblock_region *max_node = &memblock.memory.regions[5];
+	void *allocated_ptr = NULL;
+
+	PREFIX_PUSH();
+
+	phys_addr_t size = SZ_64;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	setup_numa_memblock();
+
+	min_addr = min_node->base;
+	max_addr = region_end(max_node);
+
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, max_addr - size);
+	ASSERT_LE(max_node->base, new_rgn->base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/* Test case wrappers for NUMA tests */
+static int alloc_try_nid_numa_simple_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_try_nid_top_down_numa_simple_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_numa_small_node_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_try_nid_top_down_numa_small_node_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_numa_node_reserved_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_try_nid_top_down_numa_node_reserved_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_numa_part_reserved_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_try_nid_top_down_numa_part_reserved_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_numa_part_reserved_fallback_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_try_nid_top_down_numa_part_reserved_fallback_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_numa_split_range_low_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_try_nid_top_down_numa_split_range_low_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_numa_split_range_high_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_try_nid_top_down_numa_split_range_high_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_numa_no_overlap_split_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_try_nid_top_down_numa_no_overlap_split_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_numa_no_overlap_low_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_try_nid_top_down_numa_no_overlap_low_check();
+
+	return 0;
+}
+
+static int alloc_try_nid_numa_no_overlap_high_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_try_nid_top_down_numa_no_overlap_high_check();
+
+	return 0;
+}
+
+int __memblock_alloc_nid_numa_checks(void)
+{
+	test_print("Running %s NUMA tests...\n",
+		   get_memblock_alloc_try_nid_name(alloc_nid_test_flags));
+
+	alloc_try_nid_numa_simple_check();
+	alloc_try_nid_numa_small_node_check();
+	alloc_try_nid_numa_node_reserved_check();
+	alloc_try_nid_numa_part_reserved_check();
+	alloc_try_nid_numa_part_reserved_fallback_check();
+	alloc_try_nid_numa_split_range_low_check();
+	alloc_try_nid_numa_split_range_high_check();
+
+	alloc_try_nid_numa_no_overlap_split_check();
+	alloc_try_nid_numa_no_overlap_low_check();
+	alloc_try_nid_numa_no_overlap_high_check();
+
+	return 0;
+}
+
+static int memblock_alloc_nid_checks_internal(int flags)
+{
+	alloc_nid_test_flags = flags;
+	prefix_reset();
+	prefix_push(get_memblock_alloc_try_nid_name(flags));
+
+	reset_memblock_attributes();
+	dummy_physical_memory_init();
+
+	memblock_alloc_nid_range_checks();
+	memblock_alloc_nid_numa_checks();
+
 	dummy_physical_memory_cleanup();
 
 	prefix_pop();
diff --git a/tools/testing/memblock/tests/alloc_nid_api.h b/tools/testing/memblock/tests/alloc_nid_api.h
index b35cf3c3f489..92d07d230e18 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.h
+++ b/tools/testing/memblock/tests/alloc_nid_api.h
@@ -5,5 +5,21 @@
 #include "common.h"
 
 int memblock_alloc_nid_checks(void);
+int __memblock_alloc_nid_numa_checks(void);
+
+#ifdef CONFIG_NUMA
+static inline int memblock_alloc_nid_numa_checks(void)
+{
+	__memblock_alloc_nid_numa_checks();
+	return 0;
+}
+
+#else
+static inline int memblock_alloc_nid_numa_checks(void)
+{
+	return 0;
+}
+
+#endif /* CONFIG_NUMA */
 
 #endif
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 2a17453107dc..341fc07369e1 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -62,6 +62,19 @@ enum test_flags {
 	assert((_expected) < (_seen)); \
 } while (0)
 
+/**
+ * ASSERT_LE():
+ * Check the condition
+ * @_expected <= @_seen
+ * If false, print failed test message (if running with --verbose) and then
+ * assert.
+ */
+#define ASSERT_LE(_expected, _seen) do { \
+	if ((_expected) > (_seen)) \
+		test_fail(); \
+	assert((_expected) <= (_seen)); \
+} while (0)
+
 /**
  * ASSERT_MEM_EQ():
  * Check that the first @_size bytes of @_seen are all equal to @_expected.
@@ -103,6 +116,11 @@ struct region {
 	phys_addr_t size;
 };
 
+static inline phys_addr_t __maybe_unused region_end(struct memblock_region *rgn)
+{
+	return rgn->base + rgn->size;
+}
+
 void reset_memblock_regions(void);
 void reset_memblock_attributes(void);
 void setup_memblock(void);
-- 
2.25.1

