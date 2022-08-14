Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34E9591EA1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbiHNGHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240182AbiHNGHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:07:13 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B395A8A5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:07:07 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x2so2492575ilp.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fGLf4alj+ilP9AiAsRyxj4qI01biyk8divJu7uSJukY=;
        b=MH3NnAQ+409j15U33mXtwd2kHEVZMvpJoH4odqwAa9C/Vn0JcrLz1mTYhgLAuz8o20
         YyibqUeyzEBvjWdSAoAyjAKyatZHrBvTakDVY9crmeL0JJ9DVXqOXX/1SFgtapJLQBfC
         OYv4RsKwyh8DUoD5SiY8rK7cVPbQun8r7cWmoYPrgoQYK3mdXFvtwJTcJhV4LVFLbHUD
         HQTU9Ucg4VibCVAaH9MFyZNaRUb3WZQIp33oXGh3xmrABA8JyBo46P6crmc+LEr53FXt
         43iaWcu2PYI2d7HZqOcOP+w2qqHPkRM8ERXRMvDk9gQq1So7Z3WOa25ZaPExw9yVH2we
         oA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fGLf4alj+ilP9AiAsRyxj4qI01biyk8divJu7uSJukY=;
        b=haXVLCEBYPEHTsbU5dOT3V1DIDlvciZ/m8c1voXv8X1NBQgxI1/rUTTeYFTjBG9KEx
         OT7fTS+8kLTaGwx+k9Ib2wu7a7UTVKDdvoB1rw5D8WLQ5kynz5uR9krzDWWnpTmrxz1D
         JSOKoSPz4hvZ3e79O5Zp40Wxuktq/SRsv+uts9TrPBDzM9rEI2DTVy69hVK5H8fL3Qxw
         oc61lD5zEGS+pkpfRthlUMNGpW/9XUEWfWTtmHKHd1CO+3VOC830GRrw5iAAY9Tx5VCL
         L1p/FQIXFXOha/5bnYEeYjs8Zl6J6plZoGTd26b0o74HfuX54A3g6TL9SbWXgaSGvgKo
         0MUQ==
X-Gm-Message-State: ACgBeo32uwWCbqfIhJvhRDV2xZHNCv6uENi8VBBJbeEyLJWwJopRUlqR
        W5IfvVVYtgH8mJIyh4Fmmnk=
X-Google-Smtp-Source: AA6agR5A2ATrg1D1U3EnY5ED49xXyDO4RMKiRm6Y64P7qOvp0xoa3qlT4+//1H3nmLZAMqYz/IDR+w==
X-Received: by 2002:a05:6e02:1647:b0:2df:b870:a518 with SMTP id v7-20020a056e02164700b002dfb870a518mr4788773ilu.24.1660457226384;
        Sat, 13 Aug 2022 23:07:06 -0700 (PDT)
Received: from sophie ([68.235.43.126])
        by smtp.gmail.com with ESMTPSA id w15-20020a92c88f000000b002de87995de8sm2615859ilo.84.2022.08.13.23.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:07:06 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 3/4] memblock tests: add bottom-up NUMA tests for memblock_alloc_try_nid*
Date:   Sun, 14 Aug 2022 01:06:17 -0500
Message-Id: <86e4808d21ace6608e0c3a5d26117ab8ccb4d065.1660454970.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660454970.git.remckee0@gmail.com>
References: <cover.1660454970.git.remckee0@gmail.com>
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
 tools/testing/memblock/tests/alloc_nid_api.c | 584 +++++++++++++++++++
 1 file changed, 584 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 3ffd042298f1..112cd8018d7c 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -1826,12 +1826,578 @@ static int alloc_try_nid_numa_top_down_no_overlap_high_check(void)
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
+	verify_mem_content(allocated_ptr, size);
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
+	phys_addr_t size = SZ_2K * MEM_FACTOR;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	setup_numa_memblock();
+
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM();
+
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	verify_mem_content(allocated_ptr, size);
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
+	phys_addr_t size = SZ_2K * MEM_FACTOR;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	setup_numa_memblock();
+
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM();
+
+	memblock_reserve(req_node->base, req_node->size);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	verify_mem_content(allocated_ptr, size);
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
+	verify_mem_content(allocated_ptr, size);
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
+	verify_mem_content(allocated_ptr, size);
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
+	verify_mem_content(allocated_ptr, size);
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
+	verify_mem_content(allocated_ptr, size);
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
+	verify_mem_content(allocated_ptr, size);
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
+static int alloc_try_nid_numa_bottom_up_no_overlap_low_check(void)
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
+	verify_mem_content(allocated_ptr, size);
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
+static int alloc_try_nid_numa_bottom_up_no_overlap_high_check(void)
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
+	verify_mem_content(allocated_ptr, size);
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
@@ -1841,6 +2407,8 @@ static int alloc_try_nid_numa_small_node_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_small_node_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_small_node_check();
 
 	return 0;
 }
@@ -1850,6 +2418,8 @@ static int alloc_try_nid_numa_node_reserved_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_node_reserved_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_node_reserved_check();
 
 	return 0;
 }
@@ -1859,6 +2429,8 @@ static int alloc_try_nid_numa_part_reserved_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_part_reserved_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_part_reserved_check();
 
 	return 0;
 }
@@ -1868,6 +2440,8 @@ static int alloc_try_nid_numa_part_reserved_fallback_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_part_reserved_fallback_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_part_reserved_fallback_check();
 
 	return 0;
 }
@@ -1877,6 +2451,8 @@ static int alloc_try_nid_numa_split_range_low_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_split_range_low_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_split_range_low_check();
 
 	return 0;
 }
@@ -1886,6 +2462,8 @@ static int alloc_try_nid_numa_split_range_high_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_split_range_high_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_split_range_high_check();
 
 	return 0;
 }
@@ -1895,6 +2473,8 @@ static int alloc_try_nid_numa_no_overlap_split_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_numa_no_overlap_split_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_bottom_up_numa_no_overlap_split_check();
 
 	return 0;
 }
@@ -1904,6 +2484,8 @@ static int alloc_try_nid_numa_no_overlap_low_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_numa_top_down_no_overlap_low_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_numa_bottom_up_no_overlap_low_check();
 
 	return 0;
 }
@@ -1913,6 +2495,8 @@ static int alloc_try_nid_numa_no_overlap_high_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_numa_top_down_no_overlap_high_check();
+	memblock_set_bottom_up(true);
+	alloc_try_nid_numa_bottom_up_no_overlap_high_check();
 
 	return 0;
 }
-- 
2.25.1

