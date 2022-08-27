Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27005A34E3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbiH0Fne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240872AbiH0FnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:43:23 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAEC9753E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:19 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f12so3136486plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bIYHfqktNh/eqEb6V5tq+qHzRjZARC98d3iyP3Svfn4=;
        b=iFpKejPcFJZCI22k05uYM44mQSRCGsBfHaSvShpsPY9fwkTooUqtXOQGyy3FnIUyaq
         2f7lVofSq6YyuqRWfwcSXqm76zsW7P5Y6yoAlc49NM/VvZZLZAOEIiR+V9a0RSA2CLZZ
         dimPnoi8zOp9d2yA2JRyRIOFIZaO7xXZtNjJyBy+RWpzTYu2vofBjvefTqkiZqmUP9Dh
         InuxE2d1NwdEt9kyC/s1NOfHXbQUmfQSRSaKWXqCqeyf2b8YDsAtcCzrX0tgdQpxeNP8
         OwA783dCfrR0UTC5MbYmkIP7VPqKt1bpSJzFiq3OB3CJNkOhxg5txNSXeq9hfNFEyIjj
         Jcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bIYHfqktNh/eqEb6V5tq+qHzRjZARC98d3iyP3Svfn4=;
        b=6XpWQ3zhwf+wFcXarE8c0tPp9CgI/Eog/Box/XrOw8jwIahzSkK6Z8pdw6c84Pjett
         G7CDlLZBq/DOEh6X1ctz5kL+qcB9r8sArxCkWm1RHWdwAl+L/xkLTSlwF+NYUoqjKCFp
         kz7/bfqVVjdgs5NhZfQW/zxK3i3gXDJT88MYXqZP/oB+LZYwKxIifiPrnhvSf2jrWkfP
         2KKmmBRWUGLcK93DbNZpAqyFvfPUKzknpWsHs02q5aOmPtkEZTVNZHMCqH/EjIDjQyVx
         5WNtwx8Jqxq0lRwPd9FnvdYy0dHwcUU/7UpEccsulgM5KPCdNyB350B6ZbPWCctoauZw
         lWJw==
X-Gm-Message-State: ACgBeo0/2Uq49FusyNoIzPf/+m7riPjiAo6fTKnj27DJrgbYZxnmsG/1
        Vs5bamVAYbks4Pvys8HS1U0=
X-Google-Smtp-Source: AA6agR4jMDFkUNkk4X8ZWC+l7U/F7VDhoXMuQWpDiQEoUT0ipkAwnFu6sfic/v8ixoGJpv6DURuF6Q==
X-Received: by 2002:a17:90b:3b81:b0:1fd:7249:6a80 with SMTP id pc1-20020a17090b3b8100b001fd72496a80mr4518665pjb.205.1661578999163;
        Fri, 26 Aug 2022 22:43:19 -0700 (PDT)
Received: from sophie ([89.46.114.37])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902ea0c00b0016bcc35000asm2607270plg.302.2022.08.26.22.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 22:43:18 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 5/8] memblock tests: update alloc_api to test memblock_alloc_raw
Date:   Sat, 27 Aug 2022 00:42:47 -0500
Message-Id: <5a7cfb2f807ee2cb53ee77f9f5c910107b253d6e.1661578349.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661578349.git.remckee0@gmail.com>
References: <cover.1661578349.git.remckee0@gmail.com>
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
the entire memory region is nonzero. The content of the memory region is
initialized to nonzero, and we expect it to remain unchanged if running
memblock_alloc_raw().

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_api.c | 91 +++++++++++++++---------
 tools/testing/memblock/tests/common.h    | 27 +++++++
 2 files changed, 85 insertions(+), 33 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
index e20e326d636f..36dd7e254cce 100644
--- a/tools/testing/memblock/tests/alloc_api.c
+++ b/tools/testing/memblock/tests/alloc_api.c
@@ -1,6 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include "alloc_api.h"
 
+static int alloc_test_flags = TEST_F_NONE;
+
+static inline const char * const get_memblock_alloc_name(int flags)
+{
+	if (flags & TEST_F_RAW)
+		return "memblock_alloc_raw";
+	return "memblock_alloc";
+}
+
+static inline void *run_memblock_alloc(phys_addr_t size, phys_addr_t align)
+{
+	if (alloc_test_flags & TEST_F_RAW)
+		return memblock_alloc_raw(size, align);
+	return memblock_alloc(size, align);
+}
+
 /*
  * A simple test that tries to allocate a small memory region.
  * Expect to allocate an aligned region near the end of the available memory.
@@ -19,10 +35,10 @@ static int alloc_top_down_simple_check(void)
 
 	expected_start = memblock_end_of_DRAM() - SMP_CACHE_BYTES;
 
-	allocated_ptr = memblock_alloc(size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, size);
+	assert_mem_content(allocated_ptr, size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, expected_start);
@@ -79,10 +95,10 @@ static int alloc_top_down_disjoint_check(void)
 
 	memblock_reserve(r1.base, r1.size);
 
-	allocated_ptr = memblock_alloc(r2_size, alignment);
+	allocated_ptr = run_memblock_alloc(r2_size, alignment);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r2_size);
+	assert_mem_content(allocated_ptr, r2_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
@@ -126,10 +142,10 @@ static int alloc_top_down_before_check(void)
 
 	memblock_reserve(memblock_end_of_DRAM() - total_size, r1_size);
 
-	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r2_size);
+	assert_mem_content(allocated_ptr, r2_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - total_size);
@@ -176,10 +192,10 @@ static int alloc_top_down_after_check(void)
 
 	memblock_reserve(r1.base, r1.size);
 
-	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r2_size);
+	assert_mem_content(allocated_ptr, r2_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base - r2_size);
@@ -228,10 +244,10 @@ static int alloc_top_down_second_fit_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
+	assert_mem_content(allocated_ptr, r3_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, r2.size + r3_size);
 	ASSERT_EQ(rgn->base, r2.base - r3_size);
@@ -284,10 +300,10 @@ static int alloc_in_between_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
+	assert_mem_content(allocated_ptr, r3_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base - r2.size - r3_size);
@@ -332,7 +348,7 @@ static int alloc_small_gaps_generic_check(void)
 		region_end += gap_size + region_size;
 	}
 
-	allocated_ptr = memblock_alloc(region_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(region_size, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -356,7 +372,7 @@ static int alloc_all_reserved_generic_check(void)
 	/* Simulate full memory */
 	memblock_reserve(memblock_start_of_DRAM(), MEM_SIZE);
 
-	allocated_ptr = memblock_alloc(SZ_256, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(SZ_256, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -392,7 +408,7 @@ static int alloc_no_space_generic_check(void)
 	/* Simulate almost-full memory */
 	memblock_reserve(memblock_start_of_DRAM(), reserved_size);
 
-	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -427,10 +443,10 @@ static int alloc_limited_space_generic_check(void)
 	/* Simulate almost-full memory */
 	memblock_reserve(memblock_start_of_DRAM(), reserved_size);
 
-	allocated_ptr = memblock_alloc(available_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(available_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, available_size);
+	assert_mem_content(allocated_ptr, available_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, MEM_SIZE);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -457,7 +473,7 @@ static int alloc_no_memory_generic_check(void)
 
 	reset_memblock_regions();
 
-	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 	ASSERT_EQ(rgn->size, 0);
@@ -491,7 +507,7 @@ static int alloc_too_large_generic_check(void)
 
 	setup_memblock();
 
-	allocated_ptr = memblock_alloc(MEM_SIZE + SZ_2, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(MEM_SIZE + SZ_2, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 	ASSERT_EQ(rgn->size, 0);
@@ -517,10 +533,10 @@ static int alloc_bottom_up_simple_check(void)
 
 	setup_memblock();
 
-	allocated_ptr = memblock_alloc(SZ_2, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(SZ_2, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, SZ_2);
+	assert_mem_content(allocated_ptr, SZ_2, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, SZ_2);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -575,10 +591,10 @@ static int alloc_bottom_up_disjoint_check(void)
 
 	memblock_reserve(r1.base, r1.size);
 
-	allocated_ptr = memblock_alloc(r2_size, alignment);
+	allocated_ptr = run_memblock_alloc(r2_size, alignment);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r2_size);
+	assert_mem_content(allocated_ptr, r2_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
@@ -619,10 +635,10 @@ static int alloc_bottom_up_before_check(void)
 
 	memblock_reserve(memblock_start_of_DRAM() + r1_size, r2_size);
 
-	allocated_ptr = memblock_alloc(r1_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r1_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r1_size);
+	assert_mem_content(allocated_ptr, r1_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -668,10 +684,10 @@ static int alloc_bottom_up_after_check(void)
 
 	memblock_reserve(r1.base, r1.size);
 
-	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r2_size);
+	assert_mem_content(allocated_ptr, r2_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base);
@@ -721,10 +737,10 @@ static int alloc_bottom_up_second_fit_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
+	assert_mem_content(allocated_ptr, r3_size, alloc_test_flags);
 
 	ASSERT_EQ(rgn->size, r2.size + r3_size);
 	ASSERT_EQ(rgn->base, r2.base);
@@ -856,13 +872,14 @@ static int alloc_too_large_check(void)
 	return 0;
 }
 
-int memblock_alloc_checks(void)
+static int memblock_alloc_checks_internal(int flags)
 {
-	const char *func_testing = "memblock_alloc";
+	const char *func = get_memblock_alloc_name(flags);
 
+	alloc_test_flags = flags;
 	prefix_reset();
-	prefix_push(func_testing);
-	test_print("Running %s tests...\n", func_testing);
+	prefix_push(func);
+	test_print("Running %s tests...\n", func);
 
 	reset_memblock_attributes();
 	dummy_physical_memory_init();
@@ -886,3 +903,11 @@ int memblock_alloc_checks(void)
 
 	return 0;
 }
+
+int memblock_alloc_checks(void)
+{
+	memblock_alloc_checks_internal(TEST_F_NONE);
+	memblock_alloc_checks_internal(TEST_F_RAW);
+
+	return 0;
+}
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index c53f9c365714..78128e109a95 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -12,6 +12,13 @@
 
 #define MEM_SIZE SZ_16K
 
+enum test_flags {
+	/* No special request. */
+	TEST_F_NONE = 0x0,
+	/* Perform raw allocations (no zeroing of memory). */
+	TEST_F_RAW = 0x1,
+};
+
 /**
  * ASSERT_EQ():
  * Check the condition
@@ -63,6 +70,18 @@
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
+		ASSERT_NE(((char *)_seen)[_i], (_expected)); \
+	} \
+} while (0)
+
 #define PREFIX_PUSH() prefix_push(__func__)
 
 /*
@@ -116,4 +135,12 @@ static inline void run_bottom_up(int (*func)())
 	prefix_pop();
 }
 
+static inline void assert_mem_content(void *mem, int size, int flags)
+{
+	if (flags & TEST_F_RAW)
+		ASSERT_MEM_NE(mem, 0, size);
+	else
+		ASSERT_MEM_EQ(mem, 0, size);
+}
+
 #endif
-- 
2.25.1

