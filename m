Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF85C5A34EE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345214AbiH0Fxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245153AbiH0Fxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:53:30 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE07B4414
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:53:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c16-20020a17090aa61000b001fb3286d9f7so8812356pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=UdG1FtyVlAn6RPpBGDFfYFnoNkZHT304ApoBEe/C4W0=;
        b=Jw1aCWY2h+3O5MHrSv+UIMNl8rfO+/4sy6y0jpKx0mRMttC02TgKpBLx/pSeOiZy/7
         foYum1JCewRKHhlZMeey7Qk2JFAo0Iabaz7sCuCQtUkc4xLfXaYxFg4X6LwoGaIgMdH+
         35ZBejAZd0d8MrMyWOdvSS2YcUbUKNKdtwuJknGUjCBbRw0UFm8rWgLl9riYTSC+I0Eh
         sSRDrA7O25KDetfFQ2HXPebTFBrdxSyxBqJ06d340b+qpxbWpPpfOkRcMN15PNyhSek+
         D8VUsIJ61STevHeOcyin1SaD+Gx1g0rM/w3WSoeZMc9szrh9icKnrwu2ofwk9TWN29yE
         m9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UdG1FtyVlAn6RPpBGDFfYFnoNkZHT304ApoBEe/C4W0=;
        b=w6kBrQJ6oDK+d/1mRXpvGlNG+pdtvydNZcFRgMoeMIOR77MNnweVJENOoh8qhg5AWo
         Lo+zRWJGsh66lF7Ez5Z316Ny1dL5XExmO5DqjEhO4PlCo8Mo1AsBAJBsz3hjILe2N6p/
         fJUH0ybp2qjAV2Uy/Ez6yfAa0TvDwtKdNkPu2WJCqMDK/mil8AC3eNrnbe7xTP1YhBtE
         H627qyf8FJr7WBr8tgt6hcobLS2h2n+kM+PfquBd95Rj/9lML6rNV/Iz3G1xKZZjq2yB
         x9JDXEDLFWvDAXIFUMzT4Jr6PzmZh9bDUBWZhqDzey5lJQ9arhXxDxiNxBX9/ZAnbCHO
         UvrA==
X-Gm-Message-State: ACgBeo3W2scLWpKetoGZi03w+PWZAHdcvg+dYE6bhlbeS+l8zlOP9WJD
        YQa/7H7POcbiO+odITk1tgI=
X-Google-Smtp-Source: AA6agR5FlMNpZYr4DQ1snzp1YdHlTTjiKq6kcx+XV7/TNLvn3EagF82Mtq8ZYTsCQgVu4rjNKZyE7A==
X-Received: by 2002:a17:90b:4b04:b0:1f5:2da0:b2f6 with SMTP id lx4-20020a17090b4b0400b001f52da0b2f6mr7617771pjb.195.1661579601861;
        Fri, 26 Aug 2022 22:53:21 -0700 (PDT)
Received: from sophie ([89.46.114.37])
        by smtp.gmail.com with ESMTPSA id x14-20020a1709027c0e00b0016c78f9f024sm2678954pll.104.2022.08.26.22.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 22:53:21 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 3/4] memblock tests: add bottom-up NUMA tests for memblock_alloc_try_nid*
Date:   Sat, 27 Aug 2022 00:53:01 -0500
Message-Id: <540268d5cb1a0c78391bd55f59e2740a16eb6010.1661578435.git.remckee0@gmail.com>
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
run with a bottom-up allocation direction.

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
 tools/testing/memblock/tests/alloc_nid_api.c | 586 +++++++++++++++++++
 1 file changed, 586 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index e5ef93ea1ce5..2ffb6a38ee76 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -1810,12 +1810,580 @@ static int alloc_try_nid_top_down_numa_no_overlap_high_check(void)
 	return 0;
 }
 
+/*
+ * A test that tries to allocate a memory region in a specific NUMA node that
+ * has enough memory to allocate a region of the requested size.
+ * Expect to allocate an aligned region at the beginning of the requested node.
+ */
+static int alloc_try_nid_bottom_up_numa_simple_check(void)
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
+	ASSERT_EQ(new_rgn->base, req_node->base);
+	ASSERT_LE(region_end(new_rgn), region_end(req_node));
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
+ *  |----------------------+-----+                |
+ *  |       expected       | req |                |
+ *  +----------------------+-----+----------------+
+ *
+ *  |---------+                                   |
+ *  |   rgn   |                                   |
+ *  +---------+-----------------------------------+
+ *
+ * Expect to allocate an aligned region at the beginning of the first node that
+ * has enough memory (in this case, nid = 0) after falling back to NUMA_NO_NODE.
+ */
+static int alloc_try_nid_bottom_up_numa_small_node_check(void)
+{
+	int nid_req = 1;
+	int nid_exp = 0;
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
+	ASSERT_EQ(new_rgn->base, exp_node->base);
+	ASSERT_LE(region_end(new_rgn), region_end(exp_node));
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
+ *  |----------------------+     +-----------+                    |
+ *  |       expected       |     | requested |                    |
+ *  +----------------------+-----+-----------+--------------------+
+ *
+ *  |-----------+                +-----------+                    |
+ *  |    new    |                |  reserved |                    |
+ *  +-----------+----------------+-----------+--------------------+
+ *
+ * Expect to allocate an aligned region at the beginning of the first node that
+ * is large enough and has enough unreserved memory (in this case, nid = 0)
+ * after falling back to NUMA_NO_NODE. The region count and total size get
+ * updated.
+ */
+static int alloc_try_nid_bottom_up_numa_node_reserved_check(void)
+{
+	int nid_req = 2;
+	int nid_exp = 0;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
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
+	ASSERT_EQ(new_rgn->base, exp_node->base);
+	ASSERT_LE(region_end(new_rgn), region_end(exp_node));
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
+ *  |           +---------------------------------------+         |
+ *  |           |               requested               |         |
+ *  +-----------+---------------------------------------+---------+
+ *
+ *  |           +------------------+-----+                        |
+ *  |           |     reserved     | new |                        |
+ *  +-----------+------------------+-----+------------------------+
+ *
+ * Expect to allocate an aligned region in the requested node that merges with
+ * the existing reserved region. The total size gets updated.
+ */
+static int alloc_try_nid_bottom_up_numa_part_reserved_check(void)
+{
+	int nid_req = 4;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	void *allocated_ptr = NULL;
+	struct region r1;
+
+	PREFIX_PUSH();
+
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t total_size;
+
+	setup_numa_memblock();
+
+	r1.base = req_node->base;
+	r1.size = SZ_512 * MEM_FACTOR;
+	size = SZ_128 * MEM_FACTOR;
+
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM();
+	total_size = size + r1.size;
+
+	memblock_reserve(r1.base, r1.size);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
+
+	ASSERT_EQ(new_rgn->size, total_size);
+	ASSERT_EQ(new_rgn->base, req_node->base);
+	ASSERT_LE(region_end(new_rgn), region_end(req_node));
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
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
+ *  |----------------------+       +-----------------------+         |
+ *  |       expected       |       |       requested       |         |
+ *  +----------------------+-------+-----------------------+---------+
+ *
+ *  |-----------+                        +----------+                |
+ *  |    new    |                        | reserved |                |
+ *  +-----------+------------------------+----------+----------------+
+ *
+ * Expect to allocate an aligned region at the beginning of the first
+ * node that is large enough and has enough unreserved memory (in this case,
+ * nid = 0) after falling back to NUMA_NO_NODE. The region count and total size
+ * get updated.
+ */
+static int alloc_try_nid_bottom_up_numa_part_reserved_fallback_check(void)
+{
+	int nid_req = 4;
+	int nid_exp = 0;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
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
+	ASSERT_EQ(new_rgn->base, exp_node->base);
+	ASSERT_LE(region_end(new_rgn), region_end(exp_node));
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
+ *  |           +-----------+                                      |
+ *  |           |    rgn    |                                      |
+ *  +-----------+-----------+--------------------------------------+
+ *
+ * Expect to drop the lower limit and allocate a cleared memory region at the
+ * beginning of the requested node.
+ */
+static int alloc_try_nid_bottom_up_numa_split_range_low_check(void)
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
+	ASSERT_EQ(new_rgn->base, req_node->base);
+	ASSERT_LE(region_end(new_rgn), req_node_end);
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
+ *                                                min_addr
+ *                                                |         max_addr
+ *                                                |         |
+ *                                                v         v
+ *  |------------------+        +----------------------+---------+      |
+ *  |     expected     |        |       previous       |requested|      |
+ *  +------------------+--------+----------------------+---------+------+
+ *                                                +         +
+ *  |---------+                                                         |
+ *  |   rgn   |                                                         |
+ *  +---------+---------------------------------------------------------+
+ *
+ * Expect to drop the lower limit and allocate a cleared memory region at the
+ * beginning of the first node that has enough memory.
+ */
+static int alloc_try_nid_bottom_up_numa_split_range_high_check(void)
+{
+	int nid_req = 3;
+	int nid_exp = 0;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
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
+	exp_node_end = region_end(req_node);
+	min_addr = req_node->base - SZ_256;
+	max_addr = min_addr + size;
+
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, exp_node->base);
+	ASSERT_LE(region_end(new_rgn), exp_node_end);
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
+ *                                          min_addr
+ *                                         |         max_addr
+ *                                         |         |
+ *                                         v         v
+ *  |    +---------------+        +-------------+---------+         |
+ *  |    |   requested   |        |    node1    |  node2  |         |
+ *  +----+---------------+--------+-------------+---------+---------+
+ *                                         +         +
+ *  |    +---------+                                                |
+ *  |    |   rgn   |                                                |
+ *  +----+---------+------------------------------------------------+
+ *
+ * Expect to drop the lower limit and allocate a cleared memory region that
+ * starts at the beginning of the requested node.
+ */
+static int alloc_try_nid_bottom_up_numa_no_overlap_split_check(void)
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
+	ASSERT_EQ(new_rgn->base, req_node->base);
+	ASSERT_LE(region_end(new_rgn), region_end(req_node));
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
+ *  |                       +-----+                                  |
+ *  |                       | rgn |                                  |
+ *  +-----------------------+-----+----------------------------------+
+ *
+ * Expect to allocate a cleared memory region at the beginning of the first node
+ * in the range after falling back to NUMA_NO_NODE.
+ */
+static int alloc_try_nid_bottom_up_numa_no_overlap_low_check(void)
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
+	ASSERT_EQ(new_rgn->base, min_addr);
+	ASSERT_LE(region_end(new_rgn), region_end(min_node));
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
+ *  |     +----------+----...----+----------+         +---------+   |
+ *  |     | min node |    ...    | max node |         |requested|   |
+ *  +-----+----------+----...----+----------+---------+---------+---+
+ *        +                                 +
+ *  |     +-----+                                                   |
+ *  |     | rgn |                                                   |
+ *  +-----+-----+---------------------------------------------------+
+ *
+ * Expect to allocate a cleared memory region at the beginning of the first node
+ * in the range after falling back to NUMA_NO_NODE.
+ */
+static int alloc_try_nid_bottom_up_numa_no_overlap_high_check(void)
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
+	ASSERT_EQ(new_rgn->base, min_addr);
+	ASSERT_LE(region_end(new_rgn), region_end(min_node));
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
 /* Test case wrappers for NUMA tests */
 static int alloc_try_nid_numa_simple_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_simple_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_simple_check();
 
 	return 0;
 }
@@ -1825,6 +2393,8 @@ static int alloc_try_nid_numa_small_node_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_small_node_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_small_node_check();
 
 	return 0;
 }
@@ -1834,6 +2404,8 @@ static int alloc_try_nid_numa_node_reserved_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_node_reserved_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_node_reserved_check();
 
 	return 0;
 }
@@ -1843,6 +2415,8 @@ static int alloc_try_nid_numa_part_reserved_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_part_reserved_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_part_reserved_check();
 
 	return 0;
 }
@@ -1852,6 +2426,8 @@ static int alloc_try_nid_numa_part_reserved_fallback_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_part_reserved_fallback_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_part_reserved_fallback_check();
 
 	return 0;
 }
@@ -1861,6 +2437,8 @@ static int alloc_try_nid_numa_split_range_low_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_split_range_low_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_split_range_low_check();
 
 	return 0;
 }
@@ -1870,6 +2448,8 @@ static int alloc_try_nid_numa_split_range_high_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_split_range_high_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_split_range_high_check();
 
 	return 0;
 }
@@ -1879,6 +2459,8 @@ static int alloc_try_nid_numa_no_overlap_split_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_no_overlap_split_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_no_overlap_split_check();
 
 	return 0;
 }
@@ -1888,6 +2470,8 @@ static int alloc_try_nid_numa_no_overlap_low_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_no_overlap_low_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_no_overlap_low_check();
 
 	return 0;
 }
@@ -1897,6 +2481,8 @@ static int alloc_try_nid_numa_no_overlap_high_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_no_overlap_high_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_no_overlap_high_check();
 
 	return 0;
 }
-- 
2.25.1

