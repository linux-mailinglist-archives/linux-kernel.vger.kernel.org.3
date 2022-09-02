Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255E65AA5FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 04:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiIBCkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 22:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiIBCkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 22:40:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6F63ECE2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 19:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662086435; x=1693622435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9+eSi8Hxu1LFuWwtAasTXPoXRyEnjBB+MaAWnot9iI4=;
  b=RUC+bYh82ckiO0HGKA8d0WhZkLrMVxMJVdc4+xlNL7izzFB/OKEkNUZ2
   e1RBPAcriOGbjqhtm/8jW4OLRSBO80KKyea6B+d3QX/m9xRoIbWTuE048
   NI1qbJn4ovuJVnRd2ssJpelhtuF7bggb0aIFehtoU6j4E5I7P1A0a/qpi
   GZuN72x8EDoujRCur3ju2FopsaN6E+HOEYv6xeYVYXMXHodY1QkVEvUnY
   Jk6X2o+YsgN9Y+O9u2B1XJiCw+QqTLOila3DbVo+qL3ogPvMQ3AeSQHLQ
   55v2GmdZZ8JPG1qVSRlH7OcgT/puImp8gN6IxE/V7wpGsi4tyC3D9HDDG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="359835283"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="359835283"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 19:40:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="589841468"
Received: from q.bj.intel.com ([10.238.154.102])
  by orsmga006.jf.intel.com with ESMTP; 01 Sep 2022 19:40:32 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] memblock test: Add test to memblock_reserve() 129th region
Date:   Fri,  2 Sep 2022 10:40:00 +0800
Message-Id: <20220902024007.58041-3-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902024007.58041-1-shaoqin.huang@intel.com>
References: <20220902024007.58041-1-shaoqin.huang@intel.com>
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
 tools/testing/memblock/tests/basic_api.c | 96 ++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index b9877344d3a1..0b23a656c145 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -890,6 +890,101 @@ static int memblock_reserve_near_max_check(void)
 	return 0;
 }
 
+/*
+ * A test that trying to reserve the 129th memory block.
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
+	/*
+	 * Add a valid memory region used by double_array(). Now MEM_SIZE is
+	 * 16K, which is enough. The new array will only occupy 8K.
+	 */
+	dummy_physical_memory_init();
+	memblock_add(dummy_physical_memory_base(), MEM_SIZE);
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
+	ASSERT_EQ(memblock.reserved.cnt, INIT_MEMBLOCK_REGIONS + 2);
+	ASSERT_EQ(memblock.reserved.total_size, (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE +
+						new_reserved_regions_size);
+	ASSERT_EQ(memblock.reserved.max, INIT_MEMBLOCK_REGIONS * 2);
+
+	/*
+	 * After double array, we want to make sure the memblock.reserved.regions
+	 * is actually on a valid memory, so we try to reserve a memory region which
+	 * the base is very small, it should be insert to the first region. And
+	 * the reserved.cnt and reserved.total_size will both be changed.
+	 * Let's check it.
+	 */
+	memblock_reserve(r.base, r.size);
+	ASSERT_EQ(memblock.reserved.regions[0].base, r.base);
+	ASSERT_EQ(memblock.reserved.regions[0].size, r.size);
+
+	ASSERT_EQ(memblock.reserved.cnt, INIT_MEMBLOCK_REGIONS + 3);
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
@@ -904,6 +999,7 @@ static int memblock_reserve_checks(void)
 	memblock_reserve_twice_check();
 	memblock_reserve_between_check();
 	memblock_reserve_near_max_check();
+	memblock_reserve_many_check();
 
 	prefix_pop();
 
-- 
2.34.1

