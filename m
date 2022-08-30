Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3995A5905
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiH3Bv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiH3BvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:51:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC49790833
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661824282; x=1693360282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QVIKac2TXXwtCKl68qr2q3XupTvP7bG4gHMbUWl00rA=;
  b=m4yUZf2CX9iBIlvyUrHG4NgPaL/RjEj2K4ZSeThdWb5vAnJ4N9LEbitC
   4Y6qYAUH5Nq4Gle8adGGmgm29XMpZ3uZx1FN15Qk2W1L3TbSw/ZrwDmqh
   HO7Qcit92k0HMynmrT+W1JBP0z9lM8vwZhUgz3IJ8oBCuqw2kebcq4rL5
   HRpq3NlKWCKqvbPIvJ8pcpnm7VYLHqqVdcjRuUOu562dslHM6kRwF4Ruh
   nQ0/ce7mXFffp3+AuA2nVEBJDxwD4mMiPic12K22KlIoLnRHP5CJI0crO
   6nZQF0vN8xnhoO0a0alD85cGJpbugtUcesKfW/N+nPjvi92i/4zxCZ3rh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="296330190"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="296330190"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="641167067"
Received: from q.bj.intel.com ([10.238.154.102])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2022 18:51:14 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] memblock test: Add test to memblock_reserve() 129th region
Date:   Tue, 30 Aug 2022 09:49:18 +0800
Message-Id: <20220830014925.162718-3-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220830014925.162718-1-shaoqin.huang@intel.com>
References: <20220830014925.162718-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaoqin Huang <shaoqin.huang@intel.com>

Reserve 129th region in the memblock, and this will trigger the
memblock_double_array() function, this needs valid memory regions. So
using dummy_physical_memory_init() to allocate a valid memory region.
At the same time, reserve 128 faked memory region, and make sure these
reserved region not intersect with the valid memory region. So
memblock_double_array() will choose the valid memory region, and it will
success.

Also need to restore the reserved.regions after memblock_double_array(),
to make sure the subsequent tests can run as normal.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
 tools/testing/memblock/tests/basic_api.c | 87 ++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index c8e201156cdc..d8defc9866cb 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -686,6 +686,92 @@ static int memblock_reserve_twice_check(void)
 	return 0;
 }
 
+/*
+ * A test that tries to reserve the 129th memory block.
+ * Expect to trigger memblock_double_array() to double the
+ * memblock.memory.max, find a new valid memory as
+ * reserved.regions.
+ */
+static int memblock_reserve_many_check(void)
+{
+	int i;
+	void *orig_region;
+	struct region r = {
+		.base = SZ_16K,
+		.size = MEM_SIZE,
+	};
+	phys_addr_t memory_base = SZ_128K;
+	phys_addr_t new_reserved_regions_size;
+
+	PREFIX_PUSH();
+
+	reset_memblock_regions();
+	memblock_allow_resize();
+
+	/* Add a valid memory region used by double_array(). */
+	dummy_physical_memory_init();
+	memblock_add((phys_addr_t)get_memory_block_base(), MEM_SIZE);
+
+	for (i = 0; i < INIT_MEMBLOCK_REGIONS; i++) {
+		/* Reserve some fakes memory region to fulfill the memblock. */
+		memblock_reserve(memory_base, MEM_SIZE);
+
+		ASSERT_EQ(memblock.reserved.cnt, i + 1);
+		ASSERT_EQ(memblock.reserved.total_size, (i + 1) * MEM_SIZE);
+
+		/* Keep the gap so these memory region will not be merged. */
+		memory_base += MEM_SIZE * 2;
+	}
+
+	orig_region = memblock.reserved.regions;
+
+	/* This reserve the 129 memory_region, and makes it double array. */
+	memblock_reserve(memory_base, MEM_SIZE);
+
+	/*
+	 * This is the memory region size used by the doubled reserved.regions,
+	 * and it has been reserved due to it has been used. The size is used to
+	 * calculate the total_size that the memblock.reserved have now.
+	 */
+	new_reserved_regions_size = PAGE_ALIGN((INIT_MEMBLOCK_REGIONS * 2) *
+					sizeof(struct memblock_region));
+	/*
+	 * The double_array() will find a free memory region as the new
+	 * reserved.regions, and the used memory region will be reserved, so
+	 * there will be one more region exist in the reserved memblock. And the
+	 * one more reserved region's size is new_reserved_regions_size.
+	 */
+	ASSERT_EQ(memblock.reserved.cnt, INIT_MEMBLOCK_REGIONS + 1 + 1);
+	ASSERT_EQ(memblock.reserved.total_size, (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE +
+						new_reserved_regions_size);
+	ASSERT_EQ(memblock.reserved.max, INIT_MEMBLOCK_REGIONS * 2);
+
+	/* The base is very small, so it should be insert to the first region. */
+	memblock_reserve(r.base, r.size);
+	ASSERT_EQ(memblock.reserved.regions[0].base, r.base);
+	ASSERT_EQ(memblock.reserved.regions[0].size, r.size);
+
+	ASSERT_EQ(memblock.reserved.cnt, INIT_MEMBLOCK_REGIONS + 2 + 1);
+	ASSERT_EQ(memblock.reserved.total_size, (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE +
+						new_reserved_regions_size);
+	ASSERT_EQ(memblock.reserved.max, INIT_MEMBLOCK_REGIONS * 2);
+
+	dummy_physical_memory_cleanup();
+
+	/*
+	 * The current reserved.regions is occupying a range of memory that
+	 * allocated from dummy_physical_memory_init(). After free the memory,
+	 * we must not use it. So restore the origin memory region to make sure
+	 * the tests can run as normal and not affected by the double array.
+	 */
+	memblock.reserved.regions = orig_region;
+	memblock.reserved.cnt = INIT_MEMBLOCK_REGIONS;
+
+	test_pass_pop();
+
+	return 0;
+}
+
 static int memblock_reserve_checks(void)
 {
 	prefix_reset();
@@ -698,6 +784,7 @@ static int memblock_reserve_checks(void)
 	memblock_reserve_overlap_bottom_check();
 	memblock_reserve_within_check();
 	memblock_reserve_twice_check();
+	memblock_reserve_many_check();
 
 	prefix_pop();
 
-- 
2.34.1

