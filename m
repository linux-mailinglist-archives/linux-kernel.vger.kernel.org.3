Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E03C5837C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiG1D6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiG1D6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:58:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C6C481FF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658980684; x=1690516684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rveEgmV9RWZSzZ8jsgQMx2q5Z94soNvnQgHkt+FOIVI=;
  b=kP1z3pwsAoEt9h8A7X/Uf0eId2jmxgUII7h4eQf2oTKlxEG9epS18wtl
   b8X6klidnn7dkYM6pO9S/CGnf8i7kdaZzdH5W3QpdNb19L2A55mcsVpl9
   wnf/iWk/3O3TQxHM38Gdc+rJYCyEJ06zs/3o61NaMT9WiJqwCn6ji21kG
   NJCuAHh6B6IiQala8LEqAaQjrxoR+Nn2FdPthVIjITBxBF0mqbLccLhJ6
   NxHTXExjpBP9qFwfBuS6D7erI4XkfbiWnyrjxAbW9AjGjqvaLD0SKMWEm
   0UFE5sPkdGhvLOcndIX4f4yRDQ4PDue/FWz6lxY6mkuj4wsuz5zG+iT5p
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="288425994"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="288425994"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 20:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="668640698"
Received: from q.bj.intel.com ([10.238.154.102])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2022 20:58:01 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memblock test: Add test to memblock_add() 129th region
Date:   Thu, 28 Jul 2022 13:00:47 -0600
Message-Id: <20220728190051.237437-1-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaoqin Huang <shaoqin.huang@intel.com>

Add 129th region into the memblock, and this will trigger the
memblock_double_array() function, this needs valid memory regions. So
using dummy_physical_memory_init() to allocate some valid memory, when
memblock_double_array() choose a new memory region from memory.regions,
it will always choose a valid memory region if we add all valid memory
region, so the memblock_double_array() must success.

Another thing should be done is to restore the memory.regions after
memblock_double_array(), due to now the memory.regions is pointing to a
memory region allocated by dummy_physical_memory_init(). And it will
affect the subsequent tests if we don't restore the memory region. So
Simply record the origin region, and restore it after the test.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
 tools/testing/memblock/tests/basic_api.c | 65 ++++++++++++++++++++++++
 tools/testing/memblock/tests/common.c    |  9 ++--
 tools/testing/memblock/tests/common.h    |  5 ++
 3 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 66f46f261e66..ded93f97d98e 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -326,6 +326,70 @@ static int memblock_add_twice_check(void)
 	return 0;
 }
 
+static int memblock_add_many_check(void)
+{
+	int i;
+	void *base[INIT_MEMBLOCK_REGIONS + 1];
+	void *orig_region;
+	struct region r = {
+		.base = SZ_16K,
+		.size = MEM_SIZE,
+	};
+
+	PREFIX_PUSH();
+
+	reset_memblock_regions();
+	memblock_allow_resize();
+
+	for (i = 0; i < INIT_MEMBLOCK_REGIONS; i++) {
+		dummy_physical_memory_init();
+		append_memblock();
+		base[i] = memory_block.base;
+
+		assert(memblock.memory.cnt == i + 1);
+		assert(memblock.memory.total_size == (i + 1) * MEM_SIZE);
+	}
+
+	orig_region = memblock.memory.regions;
+
+	/* This adds the 129 memory_region, and makes it double array. */
+	dummy_physical_memory_init();
+	append_memblock();
+	base[i] = memory_block.base;
+
+	assert(memblock.memory.cnt == INIT_MEMBLOCK_REGIONS + 1);
+	assert(memblock.memory.total_size == (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE);
+	assert(memblock.memory.max == INIT_MEMBLOCK_REGIONS * 2);
+
+	/* The base is very small, so it should be insert to the first region. */
+	memblock_add(r.base, r.size);
+	assert(memblock.memory.regions[0].base == r.base);
+	assert(memblock.memory.regions[0].size == r.size);
+
+	assert(memblock.memory.cnt == INIT_MEMBLOCK_REGIONS + 2);
+	assert(memblock.memory.total_size == (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE);
+	assert(memblock.memory.max == INIT_MEMBLOCK_REGIONS * 2);
+
+	/* Free these allocated memory. */
+	for (i = 0; i < INIT_MEMBLOCK_REGIONS + 1; i++) {
+		memory_block.base = base[i];
+		dummy_physical_memory_cleanup();
+	}
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
@@ -339,6 +403,7 @@ static int memblock_add_checks(void)
 	memblock_add_overlap_bottom_check();
 	memblock_add_within_check();
 	memblock_add_twice_check();
+	memblock_add_many_check();
 
 	prefix_pop();
 
diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index e43b2676af81..4741e860123a 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -5,12 +5,10 @@
 #include <linux/memory_hotplug.h>
 #include <linux/build_bug.h>
 
-#define INIT_MEMBLOCK_REGIONS			128
-#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
 #define PREFIXES_MAX				15
 #define DELIM					": "
 
-static struct test_memory memory_block;
+struct test_memory memory_block;
 static const char __maybe_unused *prefixes[PREFIXES_MAX];
 static int __maybe_unused nr_prefixes;
 
@@ -64,6 +62,11 @@ void setup_memblock(void)
 	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
 }
 
+void append_memblock(void)
+{
+	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
+}
+
 void dummy_physical_memory_init(void)
 {
 	memory_block.base = malloc(MEM_SIZE);
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 3e7f23d341d7..8946a3b77f24 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -11,6 +11,8 @@
 #include <../selftests/kselftest.h>
 
 #define MEM_SIZE SZ_16K
+#define INIT_MEMBLOCK_REGIONS			128
+#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
 
 /**
  * ASSERT_EQ():
@@ -65,9 +67,12 @@ struct region {
 	phys_addr_t size;
 };
 
+extern struct test_memory memory_block;
+
 void reset_memblock_regions(void);
 void reset_memblock_attributes(void);
 void setup_memblock(void);
+void append_memblock(void);
 void dummy_physical_memory_init(void);
 void dummy_physical_memory_cleanup(void);
 void parse_args(int argc, char **argv);
-- 
2.30.2

