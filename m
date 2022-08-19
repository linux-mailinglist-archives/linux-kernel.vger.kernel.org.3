Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76A75997DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347786AbiHSIsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347247AbiHSIs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:48:28 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D68612763
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:48:27 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f4so2841267qkl.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+/tTAaq4SyXDvjqiXYJq06J1xw9p6xExTRiWwAt7voA=;
        b=DFdItZppJaZJQ9kqYVnBQ6dJfDBGTlMfooej5MSwHPt16M90RUgs8zg2tNp08HNqjr
         /QLq1dLD39hmKk0Cm0e35TFuiYaESdvFAqvTNxtAc8nlSKkbb/08kfLO15nlb9OdRXY6
         BHM/AsiMKiLPjSV6fU9UCLAVTIVUk6kAWOEEZTZsKeBrLV2iMqCZ19lJ0ay1jc411jki
         949rgKL/wjvX6t6bec7eu7bs1MSWsrc5k6uycExfVpjVzDYrQ8MlgYrDbaoco6vw0dQF
         vWpNKUkCX/1DjXbuOGJbj7voq8TEZ3VutBOj7ZrQgxsNAKAhkUtzuwl1ZWRE84Kwf4tX
         mrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+/tTAaq4SyXDvjqiXYJq06J1xw9p6xExTRiWwAt7voA=;
        b=feQURnGeX82jSH/gnJ7IOIIn4U3mAoFKy7x4aNz+bTjBdl0GgKtpULHaqMxjxQLeOP
         u6z7svnV8Pg12wa+MccFRSqeCSg6BLQNfHQ2HAxesknbCdVh1dgN42C8V24i8OzND7Hj
         8sDmeiMpIPDqniYerTUISKhnl821B6Um3l76aXrWLVrlIjPkG0rvTZiDleKe2JSxcBqT
         DNTtYOJSwzHjE3yah8OYf6MUOV2dCEjKb16X9RnTQBKg3RRWqVZe35Q3jkOmXGDQcCEq
         eeY4Ads/IY+HjWEmWlfnUiuL6FWN06EEzRFDG78jd7yO4AJvj9t9PWUCk4ownZYLa7E6
         43dg==
X-Gm-Message-State: ACgBeo1qeZc5CyK2zuqgpOP/u1Hg2X5uIF0/e7JWmfVcpcS7cerFc/G7
        zC+OEVVQkRThI6rRb64BIWWVAHhNjsc=
X-Google-Smtp-Source: AA6agR7TjKL8xHf6BW8HnKHJ07wIticslY4KZRtI8Ea6UPq4gNnGmDqI8zs50WPEXkoWP/uQ5BayTQ==
X-Received: by 2002:a05:620a:2584:b0:6ab:91fd:15dd with SMTP id x4-20020a05620a258400b006ab91fd15ddmr4640097qko.287.1660898905949;
        Fri, 19 Aug 2022 01:48:25 -0700 (PDT)
Received: from sophie ([89.46.62.64])
        by smtp.gmail.com with ESMTPSA id bl18-20020a05620a1a9200b006b8e63dfffbsm2954513qkb.58.2022.08.19.01.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:48:25 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 5/8] memblock tests: update alloc_api to test memblock_alloc_raw
Date:   Fri, 19 Aug 2022 01:34:53 -0700
Message-Id: <48cfb01ba417895f28ce7ef9b99d1ce0854bfd5e.1660897732.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660897732.git.remckee0@gmail.com>
References: <cover.1660897732.git.remckee0@gmail.com>
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

Update memblock_alloc() tests so that they test either memblock_alloc()
or memblock_alloc_raw() depending on the value of alloc_test_flags. Run
through all the existing tests in memblock_alloc_api twice: once for
memblock_alloc() and once for memblock_alloc_raw().

When the tests run memblock_alloc(), they test that the entire memory
region is zero. When the tests run memblock_alloc_raw(), they test that
the entire memory region is nonzero.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_api.c | 98 ++++++++++++++++--------
 tools/testing/memblock/tests/common.h    | 25 ++++++
 2 files changed, 90 insertions(+), 33 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
index 65bff77dd55b..cf67687ae044 100644
--- a/tools/testing/memblock/tests/alloc_api.c
+++ b/tools/testing/memblock/tests/alloc_api.c
@@ -1,6 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include "alloc_api.h"
 
+static const char * const func_testing[] = {
+	"memblock_alloc",
+	"memblock_alloc_raw"
+};
+
+static int alloc_test_flags = TEST_ZEROED;
+
+static inline const char * const get_func_testing(int flags)
+{
+	if (flags & TEST_RAW)
+		return func_testing[1];
+	else
+		return func_testing[0];
+}
+
+static inline void *run_memblock_alloc(phys_addr_t size, phys_addr_t align)
+{
+	if (alloc_test_flags & TEST_RAW)
+		return memblock_alloc_raw(size, align);
+	else
+		return memblock_alloc(size, align);
+}
+
 /*
  * A simple test that tries to allocate a small memory region.
  * Expect to allocate an aligned region near the end of the available memory.
@@ -19,10 +42,10 @@ static int alloc_top_down_simple_check(void)
 
 	expected_start = memblock_end_of_DRAM() - SMP_CACHE_BYTES;
 
-	allocated_ptr = memblock_alloc(size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, expected_start);
@@ -79,10 +102,10 @@ static int alloc_top_down_disjoint_check(void)
 
 	memblock_reserve(r1.base, r1.size);
 
-	allocated_ptr = memblock_alloc(r2_size, alignment);
+	allocated_ptr = run_memblock_alloc(r2_size, alignment);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+	verify_mem_content(allocated_ptr, r2_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
@@ -126,10 +149,10 @@ static int alloc_top_down_before_check(void)
 
 	memblock_reserve(memblock_end_of_DRAM() - total_size, r1_size);
 
-	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+	verify_mem_content(allocated_ptr, r2_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - total_size);
@@ -176,10 +199,10 @@ static int alloc_top_down_after_check(void)
 
 	memblock_reserve(r1.base, r1.size);
 
-	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+	verify_mem_content(allocated_ptr, r2_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base - r2_size);
@@ -228,10 +251,10 @@ static int alloc_top_down_second_fit_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+	verify_mem_content(allocated_ptr, r3_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, r2.size + r3_size);
 	ASSERT_EQ(rgn->base, r2.base - r3_size);
@@ -284,10 +307,10 @@ static int alloc_in_between_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+	verify_mem_content(allocated_ptr, r3_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base - r2.size - r3_size);
@@ -332,7 +355,7 @@ static int alloc_small_gaps_generic_check(void)
 		region_end += gap_size + region_size;
 	}
 
-	allocated_ptr = memblock_alloc(region_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(region_size, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -356,7 +379,7 @@ static int alloc_all_reserved_generic_check(void)
 	/* Simulate full memory */
 	memblock_reserve(memblock_start_of_DRAM(), MEM_SIZE);
 
-	allocated_ptr = memblock_alloc(SZ_256, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(SZ_256, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -392,7 +415,7 @@ static int alloc_no_space_generic_check(void)
 	/* Simulate almost-full memory */
 	memblock_reserve(memblock_start_of_DRAM(), reserved_size);
 
-	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -427,10 +450,10 @@ static int alloc_limited_space_generic_check(void)
 	/* Simulate almost-full memory */
 	memblock_reserve(memblock_start_of_DRAM(), reserved_size);
 
-	allocated_ptr = memblock_alloc(available_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(available_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, available_size);
+	verify_mem_content(allocated_ptr, available_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, MEM_SIZE);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -457,7 +480,7 @@ static int alloc_no_memory_generic_check(void)
 
 	reset_memblock_regions();
 
-	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 	ASSERT_EQ(rgn->size, 0);
@@ -491,7 +514,7 @@ static int alloc_too_large_generic_check(void)
 
 	setup_memblock();
 
-	allocated_ptr = memblock_alloc(MEM_SIZE + SZ_2, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(MEM_SIZE + SZ_2, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 	ASSERT_EQ(rgn->size, 0);
@@ -517,10 +540,10 @@ static int alloc_bottom_up_simple_check(void)
 
 	setup_memblock();
 
-	allocated_ptr = memblock_alloc(SZ_2, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(SZ_2, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, SZ_2);
+	verify_mem_content(allocated_ptr, SZ_2, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, SZ_2);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -575,10 +598,10 @@ static int alloc_bottom_up_disjoint_check(void)
 
 	memblock_reserve(r1.base, r1.size);
 
-	allocated_ptr = memblock_alloc(r2_size, alignment);
+	allocated_ptr = run_memblock_alloc(r2_size, alignment);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+	verify_mem_content(allocated_ptr, r2_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
@@ -619,10 +642,10 @@ static int alloc_bottom_up_before_check(void)
 
 	memblock_reserve(memblock_start_of_DRAM() + r1_size, r2_size);
 
-	allocated_ptr = memblock_alloc(r1_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r1_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r1_size);
+	verify_mem_content(allocated_ptr, r1_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -668,10 +691,10 @@ static int alloc_bottom_up_after_check(void)
 
 	memblock_reserve(r1.base, r1.size);
 
-	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+	verify_mem_content(allocated_ptr, r2_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base);
@@ -721,10 +744,10 @@ static int alloc_bottom_up_second_fit_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+	verify_mem_content(allocated_ptr, r3_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, r2.size + r3_size);
 	ASSERT_EQ(rgn->base, r2.base);
@@ -856,13 +879,14 @@ static int alloc_too_large_check(void)
 	return 0;
 }
 
-int memblock_alloc_checks(void)
+static int memblock_alloc_checks_internal(int flags)
 {
-	const char *func_testing = "memblock_alloc";
+	const char *func = get_func_testing(flags);
 
+	alloc_test_flags = flags;
 	prefix_reset();
-	prefix_push(func_testing);
-	test_print("Running %s tests...\n", func_testing);
+	prefix_push(func);
+	test_print("Running %s tests...\n", func);
 
 	reset_memblock_attributes();
 	dummy_physical_memory_init();
@@ -886,3 +910,11 @@ int memblock_alloc_checks(void)
 
 	return 0;
 }
+
+int memblock_alloc_checks(void)
+{
+	memblock_alloc_checks_internal(TEST_ZEROED);
+	memblock_alloc_checks_internal(TEST_RAW);
+
+	return 0;
+}
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 58f84bf2c9ae..4fd3534ff955 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -12,6 +12,11 @@
 
 #define MEM_SIZE SZ_16K
 
+enum test_flags {
+	TEST_ZEROED = 0x0,
+	TEST_RAW = 0x1
+};
+
 /**
  * ASSERT_EQ():
  * Check the condition
@@ -63,6 +68,18 @@
 	} \
 } while (0)
 
+/**
+ * ASSERT_MEM_NE():
+ * Check that none of the first @_size bytes of @_seen are equal to @_expected.
+ * If false, print failed test message (if running with --verbose) and then
+ * assert.
+ */
+#define ASSERT_MEM_NE(_seen, _expected, _size) do { \
+	for (int _i = 0; _i < (_size); _i++) { \
+		ASSERT_NE((_seen)[_i], (_expected)); \
+	} \
+} while (0)
+
 #define PREFIX_PUSH() prefix_push(__func__)
 
 /*
@@ -116,4 +133,12 @@ static inline void run_bottom_up(int (*func)())
 	prefix_pop();
 }
 
+static inline void verify_mem_content(void *mem, int size, int flags)
+{
+	if (flags & TEST_RAW)
+		ASSERT_MEM_NE((char *)mem, 0, size);
+	else
+		ASSERT_MEM_EQ((char *)mem, 0, size);
+}
+
 #endif
-- 
2.25.1

