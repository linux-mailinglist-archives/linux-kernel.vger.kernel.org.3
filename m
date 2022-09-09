Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549035B2DBB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 06:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiIIEsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 00:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiIIErj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:47:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25CDF9FA8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 21:47:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t3so731573ply.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZsiuNri5W3BJ7Uv/jUOYZeHSLnVKfBg6dVskWyZ3pbM=;
        b=GEp4VOoWbS1Dy/ql7r970HY4pSv4VSUAf/pfzAVk7SCK0pNMc7PeroV16I7gjeB3Uf
         6IEfR8hNxw1J7HEnz4+9b3ytKsMI/+ouNgmcDuH4U0wjZpez+NRstUlDSV5NEqbkBs4z
         L4GQGaxQflRPexb5YViofMkB17XY1mY+xsO6eL8yfPJ3R3zDBqz9xSsz7v8gw0qjWXay
         Or2tTrbLXPNxwxGG2wfIIP39wlitGI1kZkIG+6my1/WdtdAtEWmEH1JUdVwOmVVZyJ55
         4LpVD9Pp9VTB97myApUn7CAC1zaTzXB+11d+64yGVeSwCNViE4ogCOynrovEkh0A8Pbk
         RX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZsiuNri5W3BJ7Uv/jUOYZeHSLnVKfBg6dVskWyZ3pbM=;
        b=ZN/XnmQcjjDXcWGMZWpkEjRTJxjiA/Mi6B7OaM6+3eo8psUqUagAb3DhL2QnPQbnQ+
         5wzxX8ATjeOp7ipk1Cn/GC9kpg+Xc43wrwWwap2iDukATdndi+uSwRJIqS3J7HqvPBDZ
         vPccTog4ucPrndywbpDGDusXVDq8BEq1lgkqR3r+zrpATO7cABX88C1IUzr6nktCH95y
         m/ladr1AjFeovYUzZbu/jhhfANA1h0mo6YeMuTBIWNESA+ukVy/yJRm4miIxkvRwC1ba
         eji/1y4oDpCq/drjboDb+TcpCvlXqQv1kVI8xGk3X3wTLNFWPQPVKgekekEHr3yQf8Bh
         YIFA==
X-Gm-Message-State: ACgBeo3Y/MYR5mMog4yiJnOWsrvmt9YdbaJ4k5dOrKKy0s/x2TFwtJGq
        tHFCC6uFIDQouu5LIQ+As6k=
X-Google-Smtp-Source: AA6agR4626JuzjTdNxz9n56kPQ2VxS2AIifwaTd3hXZf0fVtzKQeK4Ez67kDI2EBve1yCm6dOJ7JTQ==
X-Received: by 2002:a17:90a:6d62:b0:200:579f:e4ea with SMTP id z89-20020a17090a6d6200b00200579fe4eamr7820891pjj.244.1662698858458;
        Thu, 08 Sep 2022 21:47:38 -0700 (PDT)
Received: from sophie ([89.46.114.153])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b0016a7b9558f7sm387055pln.136.2022.09.08.21.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 21:47:38 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v5 4/4] memblock tests: add generic NUMA tests for memblock_alloc_try_nid*
Date:   Thu,  8 Sep 2022 23:46:45 -0500
Message-Id: <7af520ea8aeb7464f65335daf77bc134c3606c03.1662698159.git.remckee0@gmail.com>
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

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_nid_api.c | 197 +++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 691b715689ec..f4f8b1d080aa 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -2316,6 +2316,173 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_high_check(void)
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
+	phys_addr_t size = MEM_SIZE / SZ_2;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
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
+	phys_addr_t size = req_node->size;
+	phys_addr_t total_size;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
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
+	phys_addr_t size = SZ_256;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
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
@@ -2427,6 +2594,33 @@ static int alloc_try_nid_numa_no_overlap_high_check(void)
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
@@ -2443,6 +2637,9 @@ int __memblock_alloc_nid_numa_checks(void)
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

