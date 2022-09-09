Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7935B2DB8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 06:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiIIErz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 00:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiIIEri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:47:38 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518EF115CEB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 21:47:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so4256926pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 21:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ev1xzw7dkJDQpMBb5onwfvtlVzcFyKc/xSJBEGWrj0k=;
        b=hnUGGrJ6A+uZHNrF8IxS4YSXk9QLAAVezhPSxjX6mgqIgUkZf/slGZpkyJn8aV3Yz8
         YFIgLCB8wbIzNgK0UF8VCMe4PnG/OSoqrvhVIPK0lEM9YWZmHMn+u4iZhc6hufogqWip
         sJ8RUI372oXTR2NXkV8YvWfQtLsEMY10LUp7I3F9/Lt7iTC4COgf3+/OGdWuZUZ8XWVo
         k+98qkfnLacxT1UK5kxG57WtroPsV1thtqqPSeolmwt13ZNC3A5pqQaZATM7QJ4UAWJk
         i2OZIKMVI1xQ7KQRkkeR/qM5/dWLDAFZIkQKEI0l1cdnZHnLsseUhKcv21JfFsEdmi9Z
         dWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ev1xzw7dkJDQpMBb5onwfvtlVzcFyKc/xSJBEGWrj0k=;
        b=2rNLZdELQX1zv0s+9oX5XEaV9PBKgCwr+adS96wL/8Opu22fV3wEewkbLcM9CiNqyf
         hqnfxwH22Q9LavhRl6ubMXxew8sySoqIF1oPw/NbpBypyMaGmmVU6Z3HfWbKVMLhLShd
         BXmhwq6cIH2r9GytQK+KP7PSX1btcfU7Pom7gNLhkbd76nJbaOckq38efQTmk2Jlp7qR
         sVH2KwAPWcebhgNXdBWkTA+Lo6nN+es655VbwGcZItTZaQ2DeTSLR6SAepC7kv3hGBp6
         d/zfbgSg+LNXpTlpjkpM/WIhSn/CL78C2MZouZKl+AR05SU7JlWtyiVd6t7qkFoepHjS
         bBOw==
X-Gm-Message-State: ACgBeo02iQh4316RD/KWPkBj/hOww1D6DMtjLPvhjl9QsU7kf7pholP/
        GlrG1dydn8r+HJ+ecIn2W5c=
X-Google-Smtp-Source: AA6agR7GTIq81Ey1K2IyV7SQLBWSSJYcWNa0bP7f0PsYjhky6oEDk1BLthuzA2WK6xXfwiRPEoFv3w==
X-Received: by 2002:a17:903:514:b0:172:dab0:b228 with SMTP id jn20-20020a170903051400b00172dab0b228mr11862304plb.170.1662698855682;
        Thu, 08 Sep 2022 21:47:35 -0700 (PDT)
Received: from sophie ([89.46.114.153])
        by smtp.gmail.com with ESMTPSA id ix19-20020a170902f81300b00176c37f513dsm388393plb.130.2022.09.08.21.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 21:47:34 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v5 3/4] memblock tests: add bottom-up NUMA tests for memblock_alloc_try_nid*
Date:   Thu,  8 Sep 2022 23:46:44 -0500
Message-Id: <a3d8bc4643dcfab4a575eb16c85e6256d063d3e5.1662698159.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662698159.git.remckee0@gmail.com>
References: <cover.1662698159.git.remckee0@gmail.com>
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

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_nid_api.c | 568 +++++++++++++++++++
 1 file changed, 568 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 10483f3a3025..691b715689ec 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -1768,12 +1768,562 @@ static int alloc_try_nid_top_down_numa_no_overlap_high_check(void)
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
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
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
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	struct memblock_region *exp_node = &memblock.memory.regions[nid_exp];
+	void *allocated_ptr = NULL;
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	size = SZ_2 * req_node->size;
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
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	size = req_node->size;
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
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t total_size;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	ASSERT_LE(SZ_8, req_node->size);
+	r1.base = req_node->base;
+	r1.size = req_node->size / SZ_2;
+	size = r1.size / SZ_4;
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
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	ASSERT_LE(SZ_4, req_node->size);
+	size = req_node->size / SZ_2;
+	r1.base = req_node->base + (size / SZ_2);
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
+ * Expect to drop the lower limit and allocate a memory region at the beginning
+ * of the requested node.
+ */
+static int alloc_try_nid_bottom_up_numa_split_range_low_check(void)
+{
+	int nid_req = 2;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_512;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t req_node_end;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
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
+ * Expect to drop the lower limit and allocate a memory region at the beginning
+ * of the first node that has enough memory.
+ */
+static int alloc_try_nid_bottom_up_numa_split_range_high_check(void)
+{
+	int nid_req = 3;
+	int nid_exp = 0;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	struct memblock_region *exp_node = &memblock.memory.regions[nid_exp];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_512;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t exp_node_end;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
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
+ * Expect to drop the lower limit and allocate a memory region that starts at
+ * the beginning of the requested node.
+ */
+static int alloc_try_nid_bottom_up_numa_no_overlap_split_check(void)
+{
+	int nid_req = 2;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	struct memblock_region *node2 = &memblock.memory.regions[6];
+	void *allocated_ptr = NULL;
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
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
+ * Expect to allocate a memory region at the beginning of the first node
+ * in the range after falling back to NUMA_NO_NODE.
+ */
+static int alloc_try_nid_bottom_up_numa_no_overlap_low_check(void)
+{
+	int nid_req = 0;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *min_node = &memblock.memory.regions[2];
+	struct memblock_region *max_node = &memblock.memory.regions[5];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_64;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
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
+ * Expect to allocate a memory region at the beginning of the first node
+ * in the range after falling back to NUMA_NO_NODE.
+ */
+static int alloc_try_nid_bottom_up_numa_no_overlap_high_check(void)
+{
+	int nid_req = 7;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *min_node = &memblock.memory.regions[2];
+	struct memblock_region *max_node = &memblock.memory.regions[5];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_64;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
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
@@ -1783,6 +2333,8 @@ static int alloc_try_nid_numa_small_node_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_small_node_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_small_node_check();
 
 	return 0;
 }
@@ -1792,6 +2344,8 @@ static int alloc_try_nid_numa_node_reserved_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_node_reserved_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_node_reserved_check();
 
 	return 0;
 }
@@ -1801,6 +2355,8 @@ static int alloc_try_nid_numa_part_reserved_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_part_reserved_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_part_reserved_check();
 
 	return 0;
 }
@@ -1810,6 +2366,8 @@ static int alloc_try_nid_numa_part_reserved_fallback_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_part_reserved_fallback_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_part_reserved_fallback_check();
 
 	return 0;
 }
@@ -1819,6 +2377,8 @@ static int alloc_try_nid_numa_split_range_low_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_split_range_low_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_split_range_low_check();
 
 	return 0;
 }
@@ -1828,6 +2388,8 @@ static int alloc_try_nid_numa_split_range_high_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_split_range_high_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_split_range_high_check();
 
 	return 0;
 }
@@ -1837,6 +2399,8 @@ static int alloc_try_nid_numa_no_overlap_split_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_no_overlap_split_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_no_overlap_split_check();
 
 	return 0;
 }
@@ -1846,6 +2410,8 @@ static int alloc_try_nid_numa_no_overlap_low_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_no_overlap_low_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_no_overlap_low_check();
 
 	return 0;
 }
@@ -1855,6 +2421,8 @@ static int alloc_try_nid_numa_no_overlap_high_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_no_overlap_high_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_no_overlap_high_check();
 
 	return 0;
 }
-- 
2.25.1

