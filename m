Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BB55998A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348072AbiHSJQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347431AbiHSJQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:16:43 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB68F2D51
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:16:42 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j1so2937190qvv.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4z/7rQZurTl+mnXCfAAXxrfDTIcIQthn9O8WhytR9hA=;
        b=VE1uy9wuhN/nqQWUIX/L4SV6jCjUfHlpTXidQXcA3Fhex79TIraZbAgNWXam9nTOKG
         v0/3SO+c7sgMCYiSEF5b4V3OqU3WbLAFScKgZWEEtpdHPrrkz7Ua62dXKovcTcDB+mMq
         rMuqm/RGiKJjyTHtPN/9TuQ/E9YVQ3JdpCDlQadKfaFCPgyiHafKzjFJPXv+/fLoGpwg
         8QNLP7uEPOG+3m2+gNwvib4PSCPK3DfHQv6ax4F2rcx1MoCYiNHLRcGwzTiixDPxaCw8
         Isy3xE+pgta+ZfyA6skJVF5swRToq4xLNq+VcLDffs7jFAY7gVagQX6W5J2W+DsvJ0ai
         XBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4z/7rQZurTl+mnXCfAAXxrfDTIcIQthn9O8WhytR9hA=;
        b=6rdFrliZyEW7YPcAsJoc+q9ruum2AS3HkACnLATcCjTb6X9RIiCI/WpaWNEidwRt38
         JTq0qVJD+xaGp6xz0rrfl/8TMoj4Ym7C3uo7ik8a1dx7PEwZNQwaPARB4rbv/Ok/1O8d
         H4wQtVk9CL3wjJk7+H+IDllRUACVCS3zX+Uog/EYBpUgF6o3TMw9COcK/Y72b4M/bkhR
         WBTYNNFFWXtqYPq6MqYPkVdPh8g/VFjum8S/8qrKCYRJsSpXgQgFWsaAhKT+nX8qtBXy
         wEcnII3u/eYuP7NSiA9nTKPkjdfHIgNC38uhMVgAEn3ghcH+08yYlfF5W5rLmL/PvMSY
         LInQ==
X-Gm-Message-State: ACgBeo2HxlHyMubh4+wTDUYH8w8ZSxUXWKIiXkBEAx5oag6zZMMIUWbe
        d815O8SyLjOWlwgGhqV/DaM=
X-Google-Smtp-Source: AA6agR6HNVvFQ6ExpeShHhc/NZBKc4hfibcgDnFc0Sgz0oZBsSltJwdYUQfHJ7mhy+hjw1K/UHvR7w==
X-Received: by 2002:a0c:e482:0:b0:496:c63a:a3a3 with SMTP id n2-20020a0ce482000000b00496c63aa3a3mr1230278qvl.28.1660900601656;
        Fri, 19 Aug 2022 02:16:41 -0700 (PDT)
Received: from sophie ([89.46.62.64])
        by smtp.gmail.com with ESMTPSA id j5-20020a05620a410500b006b640efe6dasm3723318qko.132.2022.08.19.02.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 02:16:41 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 4/4] memblock tests: add generic NUMA tests for memblock_alloc_try_nid*
Date:   Fri, 19 Aug 2022 02:05:34 -0700
Message-Id: <16b7fc2d5cee8590c9f255b0fd3c69c443431c0b.1660897864.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660897864.git.remckee0@gmail.com>
References: <cover.1660897864.git.remckee0@gmail.com>
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
index 0a7a7494a157..c11c467cece3 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -2382,6 +2382,179 @@ static int alloc_try_nid_numa_bottom_up_no_overlap_high_check(void)
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
+	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
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
@@ -2493,6 +2666,33 @@ static int alloc_try_nid_numa_no_overlap_high_check(void)
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
@@ -2509,6 +2709,9 @@ int __memblock_alloc_nid_numa_checks(void)
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

