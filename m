Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591585A34EF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbiH0Fxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345149AbiH0Fxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:53:31 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9120BD12E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:53:26 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v4so3189360pgi.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fwrRJVHS+jIAQuL3mwmRg4Sw0FE9ZLO/V/b5qAlXAlQ=;
        b=XQz0Ln5DzOirwI54rhOr9YAjtmg9HIBam3bDAFW9HLhw6VR5lHPkNFSM/56rkKP/Nb
         Fucw3OqcU5jtVR49HZfuUM46nP69a8BknzGYZtO+7VUAXWqI5FiZtQ30Ect2nAPw99D1
         a61If/tkwfOG/CV9Kke2qppKTaKcIFj/jhUExC/cRTFCViSmBXWPX2BVcO21qVjpGhZ3
         tjXYJ0VFFuVtmNDbOpX3ZzWGtqqiMUpEC4VqkSKEr9WnfeKgY+n+I2ZlkmOfghTeZzOH
         enCYwXFKsFjh1x2Kg+y20kxmVFoK0b6vuB2HHv3B82Xt67RiZWC1jFjTb6UmTa8Unke4
         E5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fwrRJVHS+jIAQuL3mwmRg4Sw0FE9ZLO/V/b5qAlXAlQ=;
        b=F6kNPuoaOaiDG21K3m2FdBfML/GvL7Z0XFDXPZbhMe0c4rSha5GS51DLckr/0CMljD
         ZFW44d/AyYmTLYWXukjDakyRdukrntnjw5kXANMTP3cREca/0L2AQ1Cf7x+utvL/opM1
         f2kGSa7uoDtL4AuWsd+YBHV/ReFTGnnxsPkCyOKImL6EiIsjKAhiDMyAl+A7a1LeBQy1
         M7wLqWyRDb9dnZRVEXe0hCYZo/ZNNxmI+B8QbGBj5L21n7fbahbLUUkIncuB7crFENUB
         Hp/JmQ9DF2ixGA3xQiACXEAjdNFtdWY9td08B4eIjX6F78Wml3SuS2cdz5lxO+Blne63
         tkRw==
X-Gm-Message-State: ACgBeo11V+t+EHg82MllQbDHoFxxlHlN4gO02Dgw7IF0PA4OfCFbpKC8
        hHR6kLuYS7OyI23A2EbQdNxol/TgTjE=
X-Google-Smtp-Source: AA6agR7rKARl7x9GjN+l2k7QrM/b9nW7o32o/xIh6ncoAu+zQwGxv5ssEGgG22Szf7iALyNV2jyJ/A==
X-Received: by 2002:a05:6a00:1956:b0:537:1bb2:845c with SMTP id s22-20020a056a00195600b005371bb2845cmr7071383pfk.17.1661579605861;
        Fri, 26 Aug 2022 22:53:25 -0700 (PDT)
Received: from sophie ([89.46.114.37])
        by smtp.gmail.com with ESMTPSA id u22-20020a62d456000000b00536aa488062sm2803003pfl.163.2022.08.26.22.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 22:53:25 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 4/4] memblock tests: add generic NUMA tests for memblock_alloc_try_nid*
Date:   Sat, 27 Aug 2022 00:53:02 -0500
Message-Id: <fec497aa697813c28e563c64ebcb263d1f40612e.1661578435.git.remckee0@gmail.com>
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
Additionally, two of these tests set nid != NUMA_NO_NODE. All tests are
run for both top-down and bottom-up allocation directions.

The tested scenarios are:

Range unrestricted:
- region cannot be allocated:
      + none of the nodes have enough memory to allocate the region

Range restricted:
- region can be allocated in the specific node requested without dropping
  min_addr:
      + the range fully overlaps with the node, and there are adjacent
        reserved regions
- region cannot be allocated:
      + nid is set to NUMA_NO_NODE and the total range can fit the region,
        but the range is split between two nodes and everything else is
        reserved

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_nid_api.c | 203 +++++++++++++++++++
 1 file changed, 203 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 2ffb6a38ee76..0ba59cc5a8f0 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -2376,6 +2376,179 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_high_check(void)
 	return 0;
 }
 
+/*
+ * A test that tries to allocate a memory region in a specific NUMA node that
+ * does not have enough memory to allocate a region of the requested size.
+ * Additionally, none of the nodes have enough memory to allocate the region:
+ *
+ * +-----------------------------------+
+ * |                new                |
+ * +-----------------------------------+
+ *     |-------+-------+-------+-------+-------+-------+-------+-------|
+ *     | node0 | node1 | node2 | node3 | node4 | node5 | node6 | node7 |
+ *     +-------+-------+-------+-------+-------+-------+-------+-------+
+ *
+ * Expect no allocation to happen.
+ */
+static int alloc_try_nid_numa_large_region_generic_check(void)
+{
+	int nid_req = 3;
+	void *allocated_ptr = NULL;
+
+	PREFIX_PUSH();
+
+	phys_addr_t size = SZ_8K * MEM_FACTOR;
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
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory within min_addr and max_addr range when
+ * there are two reserved regions at the borders. The requested node starts at
+ * min_addr and ends at max_addr and is the same size as the region to be
+ * allocated:
+ *
+ *                     min_addr
+ *                     |                       max_addr
+ *                     |                       |
+ *                     v                       v
+ *  |      +-----------+-----------------------+-----------------------|
+ *  |      |   node5   |       requested       |         node7         |
+ *  +------+-----------+-----------------------+-----------------------+
+ *                     +                       +
+ *  |             +----+-----------------------+----+                  |
+ *  |             | r2 |          new          | r1 |                  |
+ *  +-------------+----+-----------------------+----+------------------+
+ *
+ * Expect to merge all of the regions into one. The region counter and total
+ * size fields get updated.
+ */
+static int alloc_try_nid_numa_reserved_full_merge_generic_check(void)
+{
+	int nid_req = 6;
+	int nid_next = nid_req + 1;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	struct memblock_region *next_node = &memblock.memory.regions[nid_next];
+	void *allocated_ptr = NULL;
+	struct region r1, r2;
+
+	PREFIX_PUSH();
+
+	phys_addr_t size = req_node->size;
+	phys_addr_t total_size;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	setup_numa_memblock();
+
+	r1.base = next_node->base;
+	r1.size = SZ_128;
+
+	r2.size = SZ_128;
+	r2.base = r1.base - (size + r2.size);
+
+	total_size = r1.size + r2.size + size;
+	min_addr = r2.base + r2.size;
+	max_addr = r1.base;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
+
+	ASSERT_EQ(new_rgn->size, total_size);
+	ASSERT_EQ(new_rgn->base, r2.base);
+
+	ASSERT_LE(new_rgn->base, req_node->base);
+	ASSERT_LE(region_end(req_node), region_end(new_rgn));
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
+ * A test that tries to allocate memory within min_addr and max_add range,
+ * where the total range can fit the region, but it is split between two nodes
+ * and everything else is reserved. Additionally, nid is set to NUMA_NO_NODE
+ * instead of requesting a specific node:
+ *
+ *                         +-----------+
+ *                         |    new    |
+ *                         +-----------+
+ *  |      +---------------------+-----------|
+ *  |      |      prev node      | next node |
+ *  +------+---------------------+-----------+
+ *                         +           +
+ *  |----------------------+           +-----|
+ *  |          r1          |           |  r2 |
+ *  +----------------------+-----------+-----+
+ *                         ^           ^
+ *                         |           |
+ *                         |           max_addr
+ *                         |
+ *                         min_addr
+ *
+ * Expect no allocation to happen.
+ */
+static int alloc_try_nid_numa_split_all_reserved_generic_check(void)
+{
+	void *allocated_ptr = NULL;
+	struct memblock_region *next_node = &memblock.memory.regions[7];
+	struct region r1, r2;
+
+	PREFIX_PUSH();
+
+	phys_addr_t size = SZ_256;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	setup_numa_memblock();
+
+	r2.base = next_node->base + SZ_128;
+	r2.size = memblock_end_of_DRAM() - r2.base;
+
+	r1.size = MEM_SIZE - (r2.size + size);
+	r1.base = memblock_start_of_DRAM();
+
+	min_addr = r1.base + r1.size;
+	max_addr = r2.base;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
+
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
+
+	return 0;
+}
+
 /* Test case wrappers for NUMA tests */
 static int alloc_try_nid_numa_simple_check(void)
 {
@@ -2487,6 +2660,33 @@ static int alloc_try_nid_numa_no_overlap_high_check(void)
 	return 0;
 }
 
+static int alloc_try_nid_numa_large_region_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_try_nid_numa_large_region_generic_check);
+	run_bottom_up(alloc_try_nid_numa_large_region_generic_check);
+
+	return 0;
+}
+
+static int alloc_try_nid_numa_reserved_full_merge_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_try_nid_numa_reserved_full_merge_generic_check);
+	run_bottom_up(alloc_try_nid_numa_reserved_full_merge_generic_check);
+
+	return 0;
+}
+
+static int alloc_try_nid_numa_split_all_reserved_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_try_nid_numa_split_all_reserved_generic_check);
+	run_bottom_up(alloc_try_nid_numa_split_all_reserved_generic_check);
+
+	return 0;
+}
+
 int __memblock_alloc_nid_numa_checks(void)
 {
 	test_print("Running %s NUMA tests...\n",
@@ -2503,6 +2703,9 @@ int __memblock_alloc_nid_numa_checks(void)
 	alloc_try_nid_numa_no_overlap_split_check();
 	alloc_try_nid_numa_no_overlap_low_check();
 	alloc_try_nid_numa_no_overlap_high_check();
+	alloc_try_nid_numa_large_region_check();
+	alloc_try_nid_numa_reserved_full_merge_check();
+	alloc_try_nid_numa_split_all_reserved_check();
 
 	return 0;
 }
-- 
2.25.1

