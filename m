Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74B3591EA3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbiHNGHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240218AbiHNGHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:07:14 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FF55D0D1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:07:11 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id i18so1341425ila.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Y17OOl0b7CQD6Vt9597weZ/gJQko4O3Bqol78jXbBU8=;
        b=g6KBQDx7nImhHT+L3NFhQmH1Sa/REqOtGIGFp5sCwL2vICbQstkCaUDkDMTrCZSf/f
         3yedy95vHRFDu9hWm0G59ByGCass/byR1uscsrChQjKgya3s1Lomny3OwrNK9GkQAgwg
         eSyfy1mHj5etSD7ajwgMyqKsDAQA8XI4boCm4trTBkQX4pelkMJ/CwunZRwnUo+6Vg2Z
         faQH4VlPsTXES0s6Ta6YPGsoEWDujT83L9yMNy3iSRFAJuEZBoWhbdbpyU9nv8pwvwmi
         ShXQND6x6exEMSiBidGNuXRXTVb9JOR674vJd/vQNhxa6Q+J6WELwiNN2YYl6fEVt2a6
         m3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Y17OOl0b7CQD6Vt9597weZ/gJQko4O3Bqol78jXbBU8=;
        b=FIXd9txtiOC1VdmhpbY2uArqbdsEgrdAit3q6MMyPCu2ggeXx2WO927GAAR+8+/jFU
         VEBVh09GZU80ycjMdfLJDkqmLrAm3yPHtWcp0PJT0JI6ZX6ZoJI+7sb5Cxy1ZaLeh3lf
         RA+1zV/nSoWirvC+Ke2coTeh5uj9kmRHz8fHVh8WfPzIWmagCHPtkzOrtM4Y5thfXDTs
         q4OfBWgvJVlTNimfvqQBD4XBcCT7z7zblcOas3c/rIoCaaTLUT81CB8LJHe1qPvzko3m
         +hGP9Yw9qHL/34SCAsYtimsYMySlcTEkP3KfGL2TAF5tIuO4g9Qmv/LtHLP/HfQb5FwG
         2UfA==
X-Gm-Message-State: ACgBeo1zrOJwXyfMI/7b7/kPCGjiz3gZQ3uhA3wFOoiU1pwiYgnEu0Nc
        p47hLI66pdsAskaTevUVFAWblK2Gqy8=
X-Google-Smtp-Source: AA6agR4i28dUdKHGO68m/+VYuT0meUTZWYUmoraPj1FjhP+hWTB/83KeY27CYEOi7oIVNVCCwLrh7w==
X-Received: by 2002:a92:3652:0:b0:2df:4133:787 with SMTP id d18-20020a923652000000b002df41330787mr4872527ilf.39.1660457230804;
        Sat, 13 Aug 2022 23:07:10 -0700 (PDT)
Received: from sophie ([68.235.43.126])
        by smtp.gmail.com with ESMTPSA id ay21-20020a5d9d95000000b00684584f7354sm3194761iob.55.2022.08.13.23.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:07:10 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 4/4] memblock tests: add generic NUMA tests for memblock_alloc_try_nid*
Date:   Sun, 14 Aug 2022 01:06:18 -0500
Message-Id: <a4ea2e705512b63fcab0863502c7bb3c7b42f982.1660454970.git.remckee0@gmail.com>
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
index 112cd8018d7c..9cbc95ebe07d 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -2390,6 +2390,179 @@ static int alloc_try_nid_numa_bottom_up_no_overlap_high_check(void)
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
+static int alloc_try_nid_generic_numa_large_region_check(void)
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
+	verify_mem_content(allocated_ptr, size);
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
@@ -2501,6 +2674,33 @@ static int alloc_try_nid_numa_no_overlap_high_check(void)
 	return 0;
 }
 
+static int alloc_try_nid_numa_large_region_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_try_nid_generic_numa_large_region_check);
+	run_bottom_up(alloc_try_nid_generic_numa_large_region_check);
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
@@ -2517,6 +2717,9 @@ int __memblock_alloc_nid_numa_checks(void)
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

