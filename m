Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5265A5906
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiH3Bvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiH3BvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:51:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0287C32F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661824282; x=1693360282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OHdeZU3zCE5Y6OYgb7a7NyVSc9y1tganA4G2YOsk2Ec=;
  b=AGGoIj3suGhDeQu+hQAiJRSFyloEffLBntv2IBubFt/2wjfDimD6vchW
   2Dj+CqlL9kkM5z4/aVtuKKxpVW3i8OAEs0aU4MME7yuHw6upxP33YGzvW
   +wpA3Hi3qfRBLlPBg3ymNMtQUlH6lV1i0InbPS7AAFyVFIPvy5dKkxrKH
   AZ7JmGmgHrKk2bsbDnR0OerQuU3Y6KHtbNBkjWIhdEPpfqDd+FngOsA8p
   paTlFuxTB84vr+pY9Y9Zqw6xlr+3MGcF/A/Ff1w3SWlkfCOT1VnY3Kd+f
   yKjpiyilPmdnBbNKwokfSvZqWYvwx3AQMFg9qpG5SCOXDAP26yGtU+Fxv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="296330181"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="296330181"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:51:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="641167057"
Received: from q.bj.intel.com ([10.238.154.102])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2022 18:51:10 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] memblock test: Add test to memblock_add() 129th region
Date:   Tue, 30 Aug 2022 09:49:17 +0800
Message-Id: <20220830014925.162718-2-shaoqin.huang@intel.com>
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

Add 129th region into the memblock, and this will trigger the
memblock_double_array() function, this needs valid memory regions. So
using dummy_physical_memory_init() to allocate a valid memory region, and
fake the other memory region, so it make sure the memblock_double_array()
will always choose the valid memory region that is allocated by the
dummy_physical_memory_init(). So memblock_double_array() must success.

Another thing should be done is to restore the memory.regions after
memblock_double_array(), due to now the memory.regions is pointing to a
memory region allocated by dummy_physical_memory_init(). And it will
affect the subsequent tests if we don't restore the memory region. So
simply record the origin region, and restore it after the test.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
 tools/testing/memblock/tests/basic_api.c | 82 ++++++++++++++++++++++++
 tools/testing/memblock/tests/common.c    |  7 +-
 tools/testing/memblock/tests/common.h    |  3 +
 3 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 66f46f261e66..c8e201156cdc 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -326,6 +326,87 @@ static int memblock_add_twice_check(void)
 	return 0;
 }
 
+/*
+ * A test that tries to add the 129th memory block.
+ * Expect to trigger memblock_double_array() to double the
+ * memblock.memory.max, find a new valid memory as
+ * memory.regions.
+ */
+static int memblock_add_many_check(void)
+{
+	int i;
+	void *orig_region;
+	struct region r = {
+		.base = SZ_16K,
+		.size = MEM_SIZE,
+	};
+	phys_addr_t memory_base = SZ_128K;
+
+	PREFIX_PUSH();
+
+	reset_memblock_regions();
+	memblock_allow_resize();
+
+	/*
+	 * Add one valid memory region, this will be choosed to be the memory
+	 * that new memory.regions occupied.
+	 */
+	dummy_physical_memory_init();
+	memblock_add((phys_addr_t)get_memory_block_base(), MEM_SIZE);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, MEM_SIZE);
+
+	for (i = 1; i < INIT_MEMBLOCK_REGIONS; i++) {
+		/* Add some fakes memory region to fulfill the memblock. */
+		memblock_add(memory_base, MEM_SIZE);
+
+		ASSERT_EQ(memblock.memory.cnt, i + 1);
+		ASSERT_EQ(memblock.memory.total_size, (i + 1) * MEM_SIZE);
+
+		/* Keep the gap so these memory region will not be merged. */
+		memory_base += MEM_SIZE * 2;
+	}
+
+	orig_region = memblock.memory.regions;
+
+	/* This adds the 129 memory_region, and makes it double array. */
+	memblock_add((phys_addr_t)memory_base, MEM_SIZE);
+
+	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 1);
+	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE);
+	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	/* This is the size used by new memory.regions. Check it. */
+	ASSERT_EQ(memblock.reserved.total_size, PAGE_ALIGN(INIT_MEMBLOCK_REGIONS * 2 *
+						sizeof(struct memblock_region)));
+
+	/* The base is very small, so it should be insert to the first region. */
+	memblock_add(r.base, r.size);
+	ASSERT_EQ(memblock.memory.regions[0].base, r.base);
+	ASSERT_EQ(memblock.memory.regions[0].size, r.size);
+
+	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 2);
+	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE);
+	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
+
+	dummy_physical_memory_cleanup();
+
+	/*
+	 * The current memory.regions is occupying a range of memory that
+	 * allocated from dummy_physical_memory_init(). After free the memory,
+	 * we must not use it. So restore the origin memory region to make sure
+	 * the tests can run as normal and not affected by the double array.
+	 */
+	memblock.memory.regions = orig_region;
+	memblock.memory.cnt = INIT_MEMBLOCK_REGIONS;
+
+	test_pass_pop();
+
+	return 0;
+}
+
 static int memblock_add_checks(void)
 {
 	prefix_reset();
@@ -339,6 +420,7 @@ static int memblock_add_checks(void)
 	memblock_add_overlap_bottom_check();
 	memblock_add_within_check();
 	memblock_add_twice_check();
+	memblock_add_many_check();
 
 	prefix_pop();
 
diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index 76a8ad818f3a..96fabd96ff31 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -5,8 +5,6 @@
 #include <linux/memory_hotplug.h>
 #include <linux/build_bug.h>
 
-#define INIT_MEMBLOCK_REGIONS			128
-#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
 #define PREFIXES_MAX				15
 #define DELIM					": "
 
@@ -77,6 +75,11 @@ void dummy_physical_memory_cleanup(void)
 	free(memory_block.base);
 }
 
+void *get_memory_block_base(void)
+{
+	return memory_block.base;
+}
+
 static void usage(const char *prog)
 {
 	BUILD_BUG_ON(ARRAY_SIZE(help_opts) != ARRAY_SIZE(long_opts) - 1);
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index d396e5423a8e..d56af621c543 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -11,6 +11,8 @@
 #include <../selftests/kselftest.h>
 
 #define MEM_SIZE SZ_16K
+#define INIT_MEMBLOCK_REGIONS			128
+#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
 
 /**
  * ASSERT_EQ():
@@ -73,6 +75,7 @@ void reset_memblock_attributes(void);
 void setup_memblock(void);
 void dummy_physical_memory_init(void);
 void dummy_physical_memory_cleanup(void);
+void *get_memory_block_base(void);
 void parse_args(int argc, char **argv);
 
 void test_fail(void);
-- 
2.34.1

