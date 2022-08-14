Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21226591E90
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbiHNFyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiHNFyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:54:19 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3170A5C9C9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:17 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id f18so682188ilj.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=V683Hnn2q0/vCvNg5zACgDjgDcSCcwjZhitBaRpwDvQ=;
        b=hnWrx7hgdfuaDxo41+rNai87UZ1mbRQkGGgRRxtjaRx95RoWQnwhHaXgGRgcTms63Q
         BF/AO/Usat8RLcHyoQJvdLTeWFLqwPKwpSpzomTfvzOV1A7URE5UFFZ8HqyZqBfIh5+p
         gp2AIfKUcILS4U3oDcVry3aUf+eMmQHLsWOhtVa+oH4lbik4aQq1mu6gMiWk0Vf391u7
         nSea5LTM1C0r4m2a6zKsBV0a0PrbcyXAW4C2+ZjdIjhc4AsaBmpwszqaUA46agtzRoz+
         Z8eOQ9uUSfUdwfXTJ7rFrLYO5LZs4Yt2vNp2QMJIE2JUSWRXtNtf0VH3H/ciACP/k8tJ
         3LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=V683Hnn2q0/vCvNg5zACgDjgDcSCcwjZhitBaRpwDvQ=;
        b=BH168y97x763oA9gV0T5QjBHgCHm3k6qvVwcsSGwNNK6qmZW6BFjm51leRW0jSmE9u
         8/tGHJUF+U5ugKpB5lshutdeN+js+RADnZzTyso1gi0ER4DSL1+KCWBV+93C0zBEHTUj
         Gn4ldhEp7RN4Kiv+pdmVzGIt8grKgj+WiyoP3PQlMe+BNmN5ivS9IWF/TxarVYp0MluJ
         aqCKZ4q/JmYr+pY/xwdlC/xiD7vufPpY6qNpJXc5KdHrs7U7dLrjifQPobiYKfI0W0gC
         G8XhdcUS31CHoEE5b25LHVjROZX5rlbnS41i/vt7R1Il6K7EYaRxrFunLPyLCE2Lww1F
         R2Nw==
X-Gm-Message-State: ACgBeo1vzUVb2kMT8cHLMN+CKggTPmC4quDchTwxnGva7ck7WljxjbHG
        ha43yQ6qsIIztFjQvDnGMC4=
X-Google-Smtp-Source: AA6agR79YY8+gdKUXDqfn42+zgcWVGin9Yh5/pTBmwNLQkvPUawNp1uaP2GpYjnodEDq8gC7iQxOIA==
X-Received: by 2002:a05:6e02:160c:b0:2df:6eaa:1239 with SMTP id t12-20020a056e02160c00b002df6eaa1239mr4557398ilu.171.1660456456695;
        Sat, 13 Aug 2022 22:54:16 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id h8-20020a05660208c800b006882a3bd03fsm432704ioz.16.2022.08.13.22.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 22:54:16 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 5/8] memblock tests: update alloc_api to test memblock_alloc_raw
Date:   Sun, 14 Aug 2022 00:53:57 -0500
Message-Id: <a08c2b7c529017dfd436ca6b7a9ef05dc8f933a3.1660454730.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660454730.git.remckee0@gmail.com>
References: <cover.1660454730.git.remckee0@gmail.com>
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
 tools/testing/memblock/tests/alloc_api.c | 106 ++++++++++++++++-------
 tools/testing/memblock/tests/common.h    |  17 ++++
 2 files changed, 90 insertions(+), 33 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
index fe1ee3b2e851..e3c0dc2174e9 100644
--- a/tools/testing/memblock/tests/alloc_api.c
+++ b/tools/testing/memblock/tests/alloc_api.c
@@ -1,6 +1,37 @@
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
+static inline void verify_mem_content(void *mem, int size)
+{
+	if (alloc_test_flags & TEST_RAW)
+		ASSERT_MEM_NE((char *)mem, 0, size);
+	else
+		ASSERT_MEM_EQ((char *)mem, 0, size);
+}
+
 /*
  * A simple test that tries to allocate a small memory region.
  * Expect to allocate an aligned region near the end of the available memory.
@@ -19,10 +50,10 @@ static int alloc_top_down_simple_check(void)
 
 	expected_start = memblock_end_of_DRAM() - SMP_CACHE_BYTES;
 
-	allocated_ptr = memblock_alloc(size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, expected_start);
@@ -79,10 +110,10 @@ static int alloc_top_down_disjoint_check(void)
 
 	memblock_reserve(r1.base, r1.size);
 
-	allocated_ptr = memblock_alloc(r2_size, alignment);
+	allocated_ptr = run_memblock_alloc(r2_size, alignment);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+	verify_mem_content(allocated_ptr, r2_size);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
@@ -126,10 +157,10 @@ static int alloc_top_down_before_check(void)
 
 	memblock_reserve(memblock_end_of_DRAM() - total_size, r1_size);
 
-	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+	verify_mem_content(allocated_ptr, r2_size);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - total_size);
@@ -176,10 +207,10 @@ static int alloc_top_down_after_check(void)
 
 	memblock_reserve(r1.base, r1.size);
 
-	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+	verify_mem_content(allocated_ptr, r2_size);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base - r2_size);
@@ -228,10 +259,10 @@ static int alloc_top_down_second_fit_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+	verify_mem_content(allocated_ptr, r3_size);
 
 	ASSERT_EQ(rgn->size, r2.size + r3_size);
 	ASSERT_EQ(rgn->base, r2.base - r3_size);
@@ -284,10 +315,10 @@ static int alloc_in_between_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+	verify_mem_content(allocated_ptr, r3_size);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base - r2.size - r3_size);
@@ -332,7 +363,7 @@ static int alloc_small_gaps_generic_check(void)
 		region_end += gap_size + region_size;
 	}
 
-	allocated_ptr = memblock_alloc(region_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(region_size, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -356,7 +387,7 @@ static int alloc_all_reserved_generic_check(void)
 	/* Simulate full memory */
 	memblock_reserve(memblock_start_of_DRAM(), MEM_SIZE);
 
-	allocated_ptr = memblock_alloc(SZ_256, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(SZ_256, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -392,7 +423,7 @@ static int alloc_no_space_generic_check(void)
 	/* Simulate almost-full memory */
 	memblock_reserve(memblock_start_of_DRAM(), reserved_size);
 
-	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -427,10 +458,10 @@ static int alloc_limited_space_generic_check(void)
 	/* Simulate almost-full memory */
 	memblock_reserve(memblock_start_of_DRAM(), reserved_size);
 
-	allocated_ptr = memblock_alloc(available_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(available_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, available_size);
+	verify_mem_content(allocated_ptr, available_size);
 
 	ASSERT_EQ(rgn->size, MEM_SIZE);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -458,7 +489,7 @@ static int alloc_no_memory_generic_check(void)
 	reset_memblock_regions();
 	fill_memblock();
 
-	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 	ASSERT_EQ(rgn->size, 0);
@@ -492,7 +523,7 @@ static int alloc_too_large_generic_check(void)
 
 	setup_memblock();
 
-	allocated_ptr = memblock_alloc(MEM_SIZE + SZ_2, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(MEM_SIZE + SZ_2, SMP_CACHE_BYTES);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 	ASSERT_EQ(rgn->size, 0);
@@ -518,10 +549,10 @@ static int alloc_bottom_up_simple_check(void)
 
 	setup_memblock();
 
-	allocated_ptr = memblock_alloc(SZ_2, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(SZ_2, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, SZ_2);
+	verify_mem_content(allocated_ptr, SZ_2);
 
 	ASSERT_EQ(rgn->size, SZ_2);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -576,10 +607,10 @@ static int alloc_bottom_up_disjoint_check(void)
 
 	memblock_reserve(r1.base, r1.size);
 
-	allocated_ptr = memblock_alloc(r2_size, alignment);
+	allocated_ptr = run_memblock_alloc(r2_size, alignment);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+	verify_mem_content(allocated_ptr, r2_size);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
@@ -620,10 +651,10 @@ static int alloc_bottom_up_before_check(void)
 
 	memblock_reserve(memblock_start_of_DRAM() + r1_size, r2_size);
 
-	allocated_ptr = memblock_alloc(r1_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r1_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r1_size);
+	verify_mem_content(allocated_ptr, r1_size);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -669,10 +700,10 @@ static int alloc_bottom_up_after_check(void)
 
 	memblock_reserve(r1.base, r1.size);
 
-	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+	verify_mem_content(allocated_ptr, r2_size);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r1.base);
@@ -722,10 +753,10 @@ static int alloc_bottom_up_second_fit_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
+	allocated_ptr = run_memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+	verify_mem_content(allocated_ptr, r3_size);
 
 	ASSERT_EQ(rgn->size, r2.size + r3_size);
 	ASSERT_EQ(rgn->base, r2.base);
@@ -857,13 +888,14 @@ static int alloc_too_large_check(void)
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
@@ -887,3 +919,11 @@ int memblock_alloc_checks(void)
 
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
index e0dd5b410099..a0594f1e4fe3 100644
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
-- 
2.25.1

