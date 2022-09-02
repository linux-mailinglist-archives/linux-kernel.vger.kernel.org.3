Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3A95AA5FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 04:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbiIBCkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 22:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiIBCkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 22:40:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F91B399CF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 19:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662086431; x=1693622431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ny/y1hZDFYuQPszb6Kum3XCCLsOPtt+6PTZh2kmTlZc=;
  b=NjFAjvKNvSvqdDgfNrJocGJbsYpJj5FCLN1lC1DdVdd1bFEH3JVV/1K9
   L1J3gw0Wj73GTWtKewfAcu9rHBT+O+ChBSZj0QCqKHXegZZw4jfuXmcww
   kVwpqTsgqTFXsi9HMjNAhjOaJ02WRCOjNcV0gJPvMrTWv+Vm45htLS9T6
   TjGqXVPhJ+ViTDRn3boyP2JidnJsPlV3l72nCMbF5WmASRhFFdFKkGIOs
   r2J40OYn5UyEQV36hDNo1HeLeCONSkav5xl5Zl70SkAdIW22q0csSA4QH
   Z11CDX9WrcmYO8bmUQ6E4rlb7vv2IqMSfRZJIS1bwelDszT7afmLinEFW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="359835276"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="359835276"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 19:40:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="589841450"
Received: from q.bj.intel.com ([10.238.154.102])
  by orsmga006.jf.intel.com with ESMTP; 01 Sep 2022 19:40:28 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] memblock test: Add test to memblock_add() 129th region
Date:   Fri,  2 Sep 2022 10:39:59 +0800
Message-Id: <20220902024007.58041-2-shaoqin.huang@intel.com>
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

Add 129th region into the memblock, and this will trigger the
memblock_double_array() function, this needs valid memory regions. So
using dummy_physical_memory_init() to allocate some valid memory region,
and add it into the memblock. It make sure the memblock_double_array()
will always choose the valid memory region that is allocated by the
dummy_physical_memory_init(). So memblock_double_array() must success.

Another thing should be done is to restore the memory.regions after
memblock_double_array(), due to now the memory.regions is pointing to a
memory region allocated by dummy_physical_memory_init(). And it will
affect the subsequent tests if we don't restore the memory region. So
simply record the origin region, and restore it after the test.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
 tools/testing/memblock/tests/basic_api.c | 91 ++++++++++++++++++++++++
 tools/testing/memblock/tests/common.c    | 15 +++-
 tools/testing/memblock/tests/common.h    |  4 ++
 3 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index a13a57ba0815..b9877344d3a1 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -423,6 +423,96 @@ static int memblock_add_near_max_check(void)
 	return 0;
 }
 
+/*
+ * A test that trying to add the 129th memory block.
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
+	/* Record these allocated memory, they will be free at the end. */
+	phys_addr_t base[INIT_MEMBLOCK_REGIONS + 1];
+
+	PREFIX_PUSH();
+
+	reset_memblock_regions();
+	memblock_allow_resize();
+
+	for (i = 0; i < INIT_MEMBLOCK_REGIONS; i++) {
+		/* Add some memory region to fulfill the memblock. */
+		dummy_physical_memory_init();
+		base[i] = dummy_physical_memory_base();
+		memblock_add(base[i], MEM_SIZE);
+
+		ASSERT_EQ(memblock.memory.cnt, i + 1);
+		ASSERT_EQ(memblock.memory.total_size, (i + 1) * MEM_SIZE);
+	}
+
+	orig_region = memblock.memory.regions;
+
+	/*
+	 * This adds the 129 memory_region, and makes it double array. Now
+	 * MEM_SIZE is 16K, which is enough, the doubled array will occupy 8K
+	 * memory region, so it must success.
+	 */
+	dummy_physical_memory_init();
+	base[i] = dummy_physical_memory_base();
+	memblock_add(base[i], MEM_SIZE);
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
+	/*
+	 * After double array, we want to make sure the memblock.memory.regions
+	 * is actually on a valid memory, so we try to add a memory region which
+	 * the base is very small, it should be insert to the first region. And
+	 * the memory.cnt and memory.total_size will both be changed.
+	 * Let's check it.
+	 */
+	memblock_add(r.base, r.size);
+	ASSERT_EQ(memblock.memory.regions[0].base, r.base);
+	ASSERT_EQ(memblock.memory.regions[0].size, r.size);
+
+	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 2);
+	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE);
+	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
+
+	/*
+	 * Due to we dummy_physical_memory_init() many memory region in this
+	 * test, we need to free it. Instead of expose the memory_block and
+	 * directly modify it's base, we pass an array which record all the
+	 * memory base that we allocated to this function, and let it to do the
+	 * clean job.
+	 */
+	dummy_physical_memory_cleanup_many(base, INIT_MEMBLOCK_REGIONS + 1);
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
@@ -438,6 +528,7 @@ static int memblock_add_checks(void)
 	memblock_add_twice_check();
 	memblock_add_between_check();
 	memblock_add_near_max_check();
+	memblock_add_many_check();
 
 	prefix_pop();
 
diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index eec6901081af..1fb347c5c099 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -5,8 +5,6 @@
 #include <linux/memory_hotplug.h>
 #include <linux/build_bug.h>
 
-#define INIT_MEMBLOCK_REGIONS			128
-#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
 #define PREFIXES_MAX				15
 #define DELIM					": "
 
@@ -84,6 +82,19 @@ void dummy_physical_memory_cleanup(void)
 	free(memory_block.base);
 }
 
+void dummy_physical_memory_cleanup_many(phys_addr_t *base, int cnt)
+{
+	for (int i = 0; i < cnt; i++) {
+		memory_block.base = (void *)base[i];
+		dummy_physical_memory_cleanup();
+	}
+}
+
+phys_addr_t dummy_physical_memory_base(void)
+{
+	return (phys_addr_t)memory_block.base;
+}
+
 static void usage(const char *prog)
 {
 	BUILD_BUG_ON(ARRAY_SIZE(help_opts) != ARRAY_SIZE(long_opts) - 1);
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 78128e109a95..310f0be2b2a2 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -11,6 +11,8 @@
 #include <../selftests/kselftest.h>
 
 #define MEM_SIZE SZ_16K
+#define INIT_MEMBLOCK_REGIONS			128
+#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
 
 enum test_flags {
 	/* No special request. */
@@ -104,6 +106,8 @@ void reset_memblock_attributes(void);
 void setup_memblock(void);
 void dummy_physical_memory_init(void);
 void dummy_physical_memory_cleanup(void);
+void dummy_physical_memory_cleanup_many(phys_addr_t *base, int cnt);
+phys_addr_t dummy_physical_memory_base(void);
 void parse_args(int argc, char **argv);
 
 void test_fail(void);
-- 
2.34.1

