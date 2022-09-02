Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288D35AA885
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiIBHHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiIBHG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:06:58 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA59632AA0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:06:55 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:36230.1646632855
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 17AC31002F3;
        Fri,  2 Sep 2022 15:06:50 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-84fc4d489d-ngzxf with ESMTP id eaf4a5f2bc3445ba8b7b6c9d2ffe168f for karolinadrobnik@gmail.com;
        Fri, 02 Sep 2022 15:06:54 CST
X-Transaction-ID: eaf4a5f2bc3445ba8b7b6c9d2ffe168f
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     karolinadrobnik@gmail.com, rppt@kernel.org, david@redhat.com,
        remckee0@gmail.com, shaoqin.huang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Song Chen <chensong_2000@189.cn>
Subject: [PATCH] tools/testing/memblock: add double array test
Date:   Fri,  2 Sep 2022 15:10:45 +0800
Message-Id: <1662102645-8272-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, there are 128 memblock_regions in memblock.memory.regions.
This test is trying to add the 129th region by calling memblock_add,
expects to trigger memblock_double_array.

The test will pass if
    memblock.memory.cnt == 129 and
    memblock.memory.max == 256

Below is the output:

./main -v
Running memblock_double_array tests...
memblock_add: [0x7fffdccdf0a0a-0x7fffdccdf080a] 0x5616cca50dc4S
.....
memblock_add: [0x7fffdccdf0a0a-0x7fffdccdf080a] 0x5616cca50de4S
memblock: memory is doubled to 256 at [0x7fffdccdeeb0a-0x7fffdccdeed0a]
ok 25 : memblock_double_array: passed

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 tools/testing/memblock/tests/basic_api.c | 42 ++++++++++++++++++++++++
 tools/testing/memblock/tests/common.c    |  5 ---
 tools/testing/memblock/tests/common.h    |  4 +++
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 66f46f261e66..e668ceff2f10 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -8,6 +8,7 @@
 #define FUNC_RESERVE					"memblock_reserve"
 #define FUNC_REMOVE					"memblock_remove"
 #define FUNC_FREE					"memblock_free"
+#define FUNC_DOUBLE_ARRAY			"memblock_double_array"
 
 static int memblock_initialization_check(void)
 {
@@ -1180,6 +1181,46 @@ static int memblock_free_checks(void)
 	return 0;
 }
 
+/*
+ * A simple test that adds to 129 memory blocks.
+ * Expect the region max doubled.
+ */
+static int memblock_double_array_check(void)
+{
+	int i;
+	struct memblock_region *regions = memblock.memory.regions;
+	struct region r = {
+		.base = 0,
+		.size = SZ_512,
+	};
+
+	prefix_reset();
+	prefix_push(FUNC_DOUBLE_ARRAY);
+	test_print("Running %s tests...\n", FUNC_DOUBLE_ARRAY);
+
+	dummy_physical_memory_init();
+	reset_memblock_attributes();
+	setup_memblock();
+	memblock_allow_resize();
+
+	for (i = 0; i < INIT_MEMBLOCK_REGIONS; i++) {
+		r.base += SZ_1K;
+		memblock_add(r.base, r.size);
+	}
+
+	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 1);
+	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
+
+	memblock.memory.regions = regions;
+	memblock.memory.cnt = INIT_MEMBLOCK_REGIONS;
+	dummy_physical_memory_cleanup();
+
+	test_pass_pop();
+
+	return 0;
+}
+
+
 int memblock_basic_checks(void)
 {
 	memblock_initialization_check();
@@ -1187,6 +1228,7 @@ int memblock_basic_checks(void)
 	memblock_reserve_checks();
 	memblock_remove_checks();
 	memblock_free_checks();
+	memblock_double_array_check();
 
 	return 0;
 }
diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index e43b2676af81..1d295a71ad44 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -5,11 +5,6 @@
 #include <linux/memory_hotplug.h>
 #include <linux/build_bug.h>
 
-#define INIT_MEMBLOCK_REGIONS			128
-#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
-#define PREFIXES_MAX				15
-#define DELIM					": "
-
 static struct test_memory memory_block;
 static const char __maybe_unused *prefixes[PREFIXES_MAX];
 static int __maybe_unused nr_prefixes;
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 3e7f23d341d7..13559825ddca 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -11,6 +11,10 @@
 #include <../selftests/kselftest.h>
 
 #define MEM_SIZE SZ_16K
+#define INIT_MEMBLOCK_REGIONS			128
+#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
+#define PREFIXES_MAX				15
+#define DELIM					": "
 
 /**
  * ASSERT_EQ():
-- 
2.25.1

