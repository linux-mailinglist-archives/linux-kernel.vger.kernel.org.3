Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B8B564C58
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 06:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiGDEHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 00:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiGDEHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 00:07:18 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAA664E0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 21:07:15 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id q11so11553350oih.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 21:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pneehvQT3zpcYhuLvBZkR7wlhieswTz6ad4CjeEB0RU=;
        b=Z287PWf1/HZH/sBUfxBUcJ/gmyAzXMyIP1kSn8dxliAFlpWMZ+cZSYGKyifG3TB8Xg
         Nrbuv8z1yXzUHDDxIr3TvR74womsApQVE0jHz9t+KZX1baUfy/oBOamkuztUdIkwER80
         +CAktfvMnxtC5wX9kIp4xh+qcO0AjkGoJmqR4/NGCoPQJWc4p4LyRXwEaLKGE1oH2BIK
         uSyrhknFIf7hqv+cbV2Rz3FQHKxe+fwsJATB8jeb8iqZwRPUGKhsV9NhmgYw4xr9qvBT
         ddIHXFKssdRG39cvTLjMWzs6uBC80NOwVaelnN1DLBUCiBmpXziKEm2f/fCy5bvWjL9r
         Lb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pneehvQT3zpcYhuLvBZkR7wlhieswTz6ad4CjeEB0RU=;
        b=ZaEIKv9oF3KX3GbT9RuqpVNwqqjJ/TfKpuF8OHTl39WwXN3tgg1cGLuv3amq3z7Lsz
         SaLkTgKzkEoBme6IWzLvLsOjIbCE+l4njIgAJQemDRyQXvVisATGaUB7F0fsYZFUoIDZ
         PGBr1poZHn/21GQ89WJebL3BpnXtDcZ49QrQ072NygpdZfgmoCilkbD1aO4eMK9rurpG
         oRHBltnTLNbybPH1do2hXbj03DwS7c6dAqnlZxw46rqvILY086VaTK1Cl4otEq32lu8N
         aJRHeQOj19C7Muvg8ANbfK9TuzxgtxT/IUCCmoAVasz67pBY6iZt9leCgnNtlzGTk+TM
         bfWA==
X-Gm-Message-State: AJIora/+UPLGJl6RW3qO6IKhIwB4ZQPMVdSvWHirOKNTpj5w5KgT1FYP
        ulAIcowwqAuADZow7Tm2vRc=
X-Google-Smtp-Source: AGRyM1ssPtqxap7Ak75OtAItn88dfZEUMGzadOqGvnR3Cf5TrqBjMWezpZzVWPSBBmKIAm9kx2E0IQ==
X-Received: by 2002:a05:6808:1b0b:b0:335:b0e4:a7c8 with SMTP id bx11-20020a0568081b0b00b00335b0e4a7c8mr15238704oib.53.1656907634408;
        Sun, 03 Jul 2022 21:07:14 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id c16-20020a056870b29000b000fb46b45b8csm18799334oao.23.2022.07.03.21.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 21:07:14 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>
Subject: [PATCH v5 2/4] memblock tests: add verbose output to memblock tests
Date:   Sun,  3 Jul 2022 23:06:56 -0500
Message-Id: <f234d443fe154d5ae8d8aa07284aff69edfb6f61.1656907314.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1656907314.git.remckee0@gmail.com>
References: <cover.1656907314.git.remckee0@gmail.com>
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

Add and use functions and macros for printing verbose testing output.

If the Memblock simulator was compiled with VERBOSE=1:
- prefix_push(): appends the given string to a prefix string that will be
  printed in test_fail() and test_pass*().

- prefix_pop(): removes the last prefix from the prefix string.

- prefix_reset(): clears the prefix string.

- test_fail(): prints a message after a test fails containing the test
  number of the failing test and the prefix.

- test_pass(): prints a message after a test passes containing its test
  number and the prefix.

- test_print(): prints the given formatted output string.

- test_pass_pop(): runs test_pass() followed by prefix_pop().

- PREFIX_PUSH(): runs prefix_push(__func__).

If the Memblock simulator was not compiled with VERBOSE=1, these
functions/macros do nothing.

Add the assert wrapper macros ASSERT_EQ(), ASSERT_NE(), and ASSERT_LT().
If the assert condition fails, these macros call test_fail() before
executing assert().

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Shaoqin Huang <shaoqin.huang@intel.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_api.c      | 225 +++++++----
 .../memblock/tests/alloc_helpers_api.c        | 129 ++++---
 tools/testing/memblock/tests/alloc_nid_api.c  | 351 +++++++++++-------
 tools/testing/memblock/tests/basic_api.c      | 337 +++++++++++------
 tools/testing/memblock/tests/common.c         |  57 +++
 tools/testing/memblock/tests/common.h         |  62 ++++
 6 files changed, 817 insertions(+), 344 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
index d1aa7e15c18d..a14f38eb8a89 100644
--- a/tools/testing/memblock/tests/alloc_api.c
+++ b/tools/testing/memblock/tests/alloc_api.c
@@ -10,6 +10,8 @@ static int alloc_top_down_simple_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_2;
 	phys_addr_t expected_start;
 
@@ -19,12 +21,14 @@ static int alloc_top_down_simple_check(void)
 
 	allocated_ptr = memblock_alloc(size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == size);
-	assert(rgn->base == expected_start);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, expected_start);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -55,6 +59,8 @@ static int alloc_top_down_disjoint_check(void)
 	struct region r1;
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r2_size = SZ_16;
 	/* Use custom alignment */
 	phys_addr_t alignment = SMP_CACHE_BYTES * 2;
@@ -73,15 +79,17 @@ static int alloc_top_down_disjoint_check(void)
 
 	allocated_ptr = memblock_alloc(r2_size, alignment);
 
-	assert(allocated_ptr);
-	assert(rgn1->size == r1.size);
-	assert(rgn1->base == r1.base);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn1->size, r1.size);
+	ASSERT_EQ(rgn1->base, r1.base);
 
-	assert(rgn2->size == r2_size);
-	assert(rgn2->base == expected_start);
+	ASSERT_EQ(rgn2->size, r2_size);
+	ASSERT_EQ(rgn2->base, expected_start);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -101,6 +109,8 @@ static int alloc_top_down_before_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	/*
 	 * The first region ends at the aligned address to test region merging
 	 */
@@ -114,12 +124,14 @@ static int alloc_top_down_before_check(void)
 
 	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == total_size);
-	assert(rgn->base == memblock_end_of_DRAM() - total_size);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -141,6 +153,8 @@ static int alloc_top_down_after_check(void)
 	struct region r1;
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r2_size = SZ_512;
 	phys_addr_t total_size;
 
@@ -158,12 +172,14 @@ static int alloc_top_down_after_check(void)
 
 	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == total_size);
-	assert(rgn->base == r1.base - r2_size);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, r1.base - r2_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -186,6 +202,8 @@ static int alloc_top_down_second_fit_check(void)
 	struct region r1, r2;
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r3_size = SZ_1K;
 	phys_addr_t total_size;
 
@@ -204,12 +222,14 @@ static int alloc_top_down_second_fit_check(void)
 
 	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == r2.size + r3_size);
-	assert(rgn->base == r2.base - r3_size);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, r2.size + r3_size);
+	ASSERT_EQ(rgn->base, r2.base - r3_size);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -231,6 +251,8 @@ static int alloc_in_between_generic_check(void)
 	struct region r1, r2;
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t r3_size = SZ_64;
 	/*
@@ -254,12 +276,14 @@ static int alloc_in_between_generic_check(void)
 
 	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == total_size);
-	assert(rgn->base == r1.base - r2.size - r3_size);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, r1.base - r2.size - r3_size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -281,6 +305,8 @@ static int alloc_small_gaps_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t region_size = SZ_1K;
 	phys_addr_t gap_size = SZ_256;
 	phys_addr_t region_end;
@@ -296,7 +322,9 @@ static int alloc_small_gaps_generic_check(void)
 
 	allocated_ptr = memblock_alloc(region_size, SMP_CACHE_BYTES);
 
-	assert(!allocated_ptr);
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -309,6 +337,8 @@ static int alloc_all_reserved_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	setup_memblock();
 
 	/* Simulate full memory */
@@ -316,7 +346,9 @@ static int alloc_all_reserved_generic_check(void)
 
 	allocated_ptr = memblock_alloc(SZ_256, SMP_CACHE_BYTES);
 
-	assert(!allocated_ptr);
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -338,6 +370,8 @@ static int alloc_no_space_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	setup_memblock();
 
 	phys_addr_t available_size = SZ_256;
@@ -348,7 +382,9 @@ static int alloc_no_space_generic_check(void)
 
 	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
 
-	assert(!allocated_ptr);
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -369,6 +405,8 @@ static int alloc_limited_space_generic_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t available_size = SZ_256;
 	phys_addr_t reserved_size = MEM_SIZE - available_size;
 
@@ -379,12 +417,14 @@ static int alloc_limited_space_generic_check(void)
 
 	allocated_ptr = memblock_alloc(available_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == MEM_SIZE);
-	assert(rgn->base == memblock_start_of_DRAM());
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, MEM_SIZE);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, MEM_SIZE);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == MEM_SIZE);
+	test_pass_pop();
 
 	return 0;
 }
@@ -399,14 +439,18 @@ static int alloc_no_memory_generic_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	reset_memblock_regions();
 
 	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
 
-	assert(!allocated_ptr);
-	assert(rgn->size == 0);
-	assert(rgn->base == 0);
-	assert(memblock.reserved.total_size == 0);
+	ASSERT_EQ(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, 0);
+	ASSERT_EQ(rgn->base, 0);
+	ASSERT_EQ(memblock.reserved.total_size, 0);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -421,16 +465,20 @@ static int alloc_bottom_up_simple_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	setup_memblock();
 
 	allocated_ptr = memblock_alloc(SZ_2, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == SZ_2);
-	assert(rgn->base == memblock_start_of_DRAM());
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, SZ_2);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == SZ_2);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, SZ_2);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -459,6 +507,8 @@ static int alloc_bottom_up_disjoint_check(void)
 	struct region r1;
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r2_size = SZ_16;
 	/* Use custom alignment */
 	phys_addr_t alignment = SMP_CACHE_BYTES * 2;
@@ -477,16 +527,18 @@ static int alloc_bottom_up_disjoint_check(void)
 
 	allocated_ptr = memblock_alloc(r2_size, alignment);
 
-	assert(allocated_ptr);
+	ASSERT_NE(allocated_ptr, NULL);
 
-	assert(rgn1->size == r1.size);
-	assert(rgn1->base == r1.base);
+	ASSERT_EQ(rgn1->size, r1.size);
+	ASSERT_EQ(rgn1->base, r1.base);
 
-	assert(rgn2->size == r2_size);
-	assert(rgn2->base == expected_start);
+	ASSERT_EQ(rgn2->size, r2_size);
+	ASSERT_EQ(rgn2->base, expected_start);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -506,6 +558,8 @@ static int alloc_bottom_up_before_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r1_size = SZ_512;
 	phys_addr_t r2_size = SZ_128;
 	phys_addr_t total_size = r1_size + r2_size;
@@ -516,12 +570,14 @@ static int alloc_bottom_up_before_check(void)
 
 	allocated_ptr = memblock_alloc(r1_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == total_size);
-	assert(rgn->base == memblock_start_of_DRAM());
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -542,6 +598,8 @@ static int alloc_bottom_up_after_check(void)
 	struct region r1;
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r2_size = SZ_512;
 	phys_addr_t total_size;
 
@@ -559,12 +617,14 @@ static int alloc_bottom_up_after_check(void)
 
 	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == total_size);
-	assert(rgn->base == r1.base);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, r1.base);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -588,6 +648,8 @@ static int alloc_bottom_up_second_fit_check(void)
 	struct region r1, r2;
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r3_size = SZ_1K;
 	phys_addr_t total_size;
 
@@ -606,12 +668,14 @@ static int alloc_bottom_up_second_fit_check(void)
 
 	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
-	assert(allocated_ptr);
-	assert(rgn->size == r2.size + r3_size);
-	assert(rgn->base == r2.base);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, r2.size + r3_size);
+	ASSERT_EQ(rgn->base, r2.base);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -619,6 +683,7 @@ static int alloc_bottom_up_second_fit_check(void)
 /* Test case wrappers */
 static int alloc_simple_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_top_down_simple_check();
 	memblock_set_bottom_up(true);
@@ -629,6 +694,7 @@ static int alloc_simple_check(void)
 
 static int alloc_disjoint_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_top_down_disjoint_check();
 	memblock_set_bottom_up(true);
@@ -639,6 +705,7 @@ static int alloc_disjoint_check(void)
 
 static int alloc_before_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_top_down_before_check();
 	memblock_set_bottom_up(true);
@@ -649,6 +716,7 @@ static int alloc_before_check(void)
 
 static int alloc_after_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_top_down_after_check();
 	memblock_set_bottom_up(true);
@@ -659,6 +727,7 @@ static int alloc_after_check(void)
 
 static int alloc_in_between_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_in_between_generic_check();
 	memblock_set_bottom_up(true);
@@ -669,6 +738,7 @@ static int alloc_in_between_check(void)
 
 static int alloc_second_fit_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_top_down_second_fit_check();
 	memblock_set_bottom_up(true);
@@ -679,6 +749,7 @@ static int alloc_second_fit_check(void)
 
 static int alloc_small_gaps_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_small_gaps_generic_check();
 	memblock_set_bottom_up(true);
@@ -689,6 +760,7 @@ static int alloc_small_gaps_check(void)
 
 static int alloc_all_reserved_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_all_reserved_generic_check();
 	memblock_set_bottom_up(true);
@@ -699,6 +771,7 @@ static int alloc_all_reserved_check(void)
 
 static int alloc_no_space_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_no_space_generic_check();
 	memblock_set_bottom_up(true);
@@ -709,6 +782,7 @@ static int alloc_no_space_check(void)
 
 static int alloc_limited_space_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_limited_space_generic_check();
 	memblock_set_bottom_up(true);
@@ -719,6 +793,7 @@ static int alloc_limited_space_check(void)
 
 static int alloc_no_memory_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_no_memory_generic_check();
 	memblock_set_bottom_up(true);
@@ -729,6 +804,12 @@ static int alloc_no_memory_check(void)
 
 int memblock_alloc_checks(void)
 {
+	const char *func_testing = "memblock_alloc";
+
+	prefix_reset();
+	prefix_push(func_testing);
+	test_print("Running %s tests...\n", func_testing);
+
 	reset_memblock_attributes();
 	dummy_physical_memory_init();
 
@@ -746,5 +827,7 @@ int memblock_alloc_checks(void)
 
 	dummy_physical_memory_cleanup();
 
+	prefix_pop();
+
 	return 0;
 }
diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
index 963a966db461..1069b4bdd5fd 100644
--- a/tools/testing/memblock/tests/alloc_helpers_api.c
+++ b/tools/testing/memblock/tests/alloc_helpers_api.c
@@ -21,6 +21,8 @@ static int alloc_from_simple_generic_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_16;
 	phys_addr_t min_addr;
 
@@ -31,14 +33,16 @@ static int alloc_from_simple_generic_check(void)
 	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, min_addr);
 
-	assert(rgn->size == size);
-	assert(rgn->base == min_addr);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -64,6 +68,8 @@ static int alloc_from_misaligned_generic_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_32;
 	phys_addr_t min_addr;
 
@@ -75,14 +81,16 @@ static int alloc_from_misaligned_generic_check(void)
 	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
 
-	assert(rgn->size == size);
-	assert(rgn->base == memblock_end_of_DRAM() - SMP_CACHE_BYTES);
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - SMP_CACHE_BYTES);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -110,6 +118,8 @@ static int alloc_from_top_down_high_addr_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_32;
 	phys_addr_t min_addr;
 
@@ -120,12 +130,14 @@ static int alloc_from_top_down_high_addr_check(void)
 
 	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
 
-	assert(allocated_ptr);
-	assert(rgn->size == size);
-	assert(rgn->base == memblock_end_of_DRAM() - SMP_CACHE_BYTES);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - SMP_CACHE_BYTES);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -151,6 +163,8 @@ static int alloc_from_top_down_no_space_above_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t r2_size = SZ_2;
 	phys_addr_t total_size = r1_size + r2_size;
@@ -165,12 +179,14 @@ static int alloc_from_top_down_no_space_above_check(void)
 
 	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
 
-	assert(allocated_ptr);
-	assert(rgn->base == min_addr - r1_size);
-	assert(rgn->size == total_size);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->base, min_addr - r1_size);
+	ASSERT_EQ(rgn->size, total_size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -186,6 +202,8 @@ static int alloc_from_top_down_min_addr_cap_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t min_addr;
 	phys_addr_t start_addr;
@@ -199,12 +217,14 @@ static int alloc_from_top_down_min_addr_cap_check(void)
 
 	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
 
-	assert(allocated_ptr);
-	assert(rgn->base == start_addr);
-	assert(rgn->size == MEM_SIZE);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->base, start_addr);
+	ASSERT_EQ(rgn->size, MEM_SIZE);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, MEM_SIZE);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == MEM_SIZE);
+	test_pass_pop();
 
 	return 0;
 }
@@ -230,6 +250,8 @@ static int alloc_from_bottom_up_high_addr_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_32;
 	phys_addr_t min_addr;
 
@@ -240,12 +262,14 @@ static int alloc_from_bottom_up_high_addr_check(void)
 
 	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
 
-	assert(allocated_ptr);
-	assert(rgn->size == size);
-	assert(rgn->base == memblock_start_of_DRAM());
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -270,6 +294,8 @@ static int alloc_from_bottom_up_no_space_above_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t min_addr;
 	phys_addr_t r2_size;
@@ -284,12 +310,14 @@ static int alloc_from_bottom_up_no_space_above_check(void)
 
 	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
 
-	assert(allocated_ptr);
-	assert(rgn->base == memblock_start_of_DRAM());
-	assert(rgn->size == r1_size);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
+	ASSERT_EQ(rgn->size, r1_size);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == r1_size + r2_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, r1_size + r2_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -304,6 +332,8 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t min_addr;
 	phys_addr_t start_addr;
@@ -315,12 +345,14 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
 
 	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
 
-	assert(allocated_ptr);
-	assert(rgn->base == start_addr);
-	assert(rgn->size == r1_size);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(rgn->base, start_addr);
+	ASSERT_EQ(rgn->size, r1_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == r1_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, r1_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -328,6 +360,7 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
 /* Test case wrappers */
 static int alloc_from_simple_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_from_simple_generic_check();
 	memblock_set_bottom_up(true);
@@ -338,6 +371,7 @@ static int alloc_from_simple_check(void)
 
 static int alloc_from_misaligned_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_from_misaligned_generic_check();
 	memblock_set_bottom_up(true);
@@ -348,6 +382,7 @@ static int alloc_from_misaligned_check(void)
 
 static int alloc_from_high_addr_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_from_top_down_high_addr_check();
 	memblock_set_bottom_up(true);
@@ -358,6 +393,7 @@ static int alloc_from_high_addr_check(void)
 
 static int alloc_from_no_space_above_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_from_top_down_no_space_above_check();
 	memblock_set_bottom_up(true);
@@ -368,6 +404,7 @@ static int alloc_from_no_space_above_check(void)
 
 static int alloc_from_min_addr_cap_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_from_top_down_min_addr_cap_check();
 	memblock_set_bottom_up(true);
@@ -378,6 +415,12 @@ static int alloc_from_min_addr_cap_check(void)
 
 int memblock_alloc_helpers_checks(void)
 {
+	const char *func_testing = "memblock_alloc_from";
+
+	prefix_reset();
+	prefix_push(func_testing);
+	test_print("Running %s tests...\n", func_testing);
+
 	reset_memblock_attributes();
 	dummy_physical_memory_init();
 
@@ -389,5 +432,7 @@ int memblock_alloc_helpers_checks(void)
 
 	dummy_physical_memory_cleanup();
 
+	prefix_pop();
+
 	return 0;
 }
diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 6390206e50e1..255fd514e9f5 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -21,6 +21,8 @@ static int alloc_try_nid_top_down_simple_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_128;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -36,15 +38,17 @@ static int alloc_try_nid_top_down_simple_check(void)
 	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, max_addr - size);
+	ASSERT_EQ(rgn_end, max_addr);
 
-	assert(rgn->size == size);
-	assert(rgn->base == max_addr - size);
-	assert(rgn_end == max_addr);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -72,6 +76,8 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_128;
 	phys_addr_t misalign = SZ_2;
 	phys_addr_t min_addr;
@@ -88,15 +94,17 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
 	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
 
-	assert(rgn->size == size);
-	assert(rgn->base == max_addr - size - misalign);
-	assert(rgn_end < max_addr);
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, max_addr - size - misalign);
+	ASSERT_LT(rgn_end, max_addr);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -122,6 +130,8 @@ static int alloc_try_nid_exact_address_generic_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_1K;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -137,15 +147,17 @@ static int alloc_try_nid_exact_address_generic_check(void)
 	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, min_addr);
+	ASSERT_EQ(rgn_end, max_addr);
 
-	assert(rgn->size == size);
-	assert(rgn->base == min_addr);
-	assert(rgn_end == max_addr);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -173,6 +185,8 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_256;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -186,14 +200,16 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, max_addr - size);
 
-	assert(rgn->size == size);
-	assert(rgn->base == max_addr - size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -222,6 +238,8 @@ static int alloc_try_nid_low_max_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_1K;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -234,7 +252,9 @@ static int alloc_try_nid_low_max_generic_check(void)
 	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
 
-	assert(!allocated_ptr);
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -259,6 +279,8 @@ static int alloc_try_nid_min_reserved_generic_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r1_size = SZ_128;
 	phys_addr_t r2_size = SZ_64;
 	phys_addr_t total_size = r1_size + r2_size;
@@ -278,14 +300,16 @@ static int alloc_try_nid_min_reserved_generic_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
 
-	assert(rgn->size == total_size);
-	assert(rgn->base == reserved_base);
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, reserved_base);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -310,6 +334,8 @@ static int alloc_try_nid_max_reserved_generic_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t r2_size = SZ_128;
 	phys_addr_t total_size = r1_size + r2_size;
@@ -327,14 +353,16 @@ static int alloc_try_nid_max_reserved_generic_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, min_addr);
 
-	assert(rgn->size == total_size);
-	assert(rgn->base == min_addr);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -364,6 +392,8 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
 	char *b;
 	struct region r1, r2;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r3_size = SZ_64;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t total_size;
@@ -389,17 +419,19 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn1->size, r1.size + r3_size);
+	ASSERT_EQ(rgn1->base, max_addr - r3_size);
 
-	assert(rgn1->size == r1.size + r3_size);
-	assert(rgn1->base == max_addr - r3_size);
+	ASSERT_EQ(rgn2->size, r2.size);
+	ASSERT_EQ(rgn2->base, r2.base);
 
-	assert(rgn2->size == r2.size);
-	assert(rgn2->base == r2.base);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -427,6 +459,8 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
 	char *b;
 	struct region r1, r2;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r3_size = SZ_64;
 	phys_addr_t total_size;
 	phys_addr_t max_addr;
@@ -451,14 +485,16 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
 
-	assert(rgn->size == total_size);
-	assert(rgn->base == r2.base);
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, r2.base);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -489,6 +525,8 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
 	char *b;
 	struct region r1, r2;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r3_size = SZ_256;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t total_size;
@@ -514,17 +552,19 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn1->size, r1.size);
+	ASSERT_EQ(rgn1->base, r1.base);
 
-	assert(rgn1->size == r1.size);
-	assert(rgn1->base == r1.base);
+	ASSERT_EQ(rgn2->size, r2.size + r3_size);
+	ASSERT_EQ(rgn2->base, r2.base - r3_size);
 
-	assert(rgn2->size == r2.size + r3_size);
-	assert(rgn2->base == r2.base - r3_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -554,6 +594,8 @@ static int alloc_try_nid_reserved_all_generic_check(void)
 	void *allocated_ptr = NULL;
 	struct region r1, r2;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r3_size = SZ_256;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t max_addr;
@@ -576,7 +618,9 @@ static int alloc_try_nid_reserved_all_generic_check(void)
 	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
 
-	assert(!allocated_ptr);
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -592,6 +636,8 @@ static int alloc_try_nid_top_down_cap_max_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_256;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -605,14 +651,16 @@ static int alloc_try_nid_top_down_cap_max_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
 
-	assert(rgn->size == size);
-	assert(rgn->base == memblock_end_of_DRAM() - size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -628,6 +676,8 @@ static int alloc_try_nid_top_down_cap_min_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_1K;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -641,14 +691,16 @@ static int alloc_try_nid_top_down_cap_min_check(void)
 					       min_addr, max_addr, NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
 
-	assert(rgn->size == size);
-	assert(rgn->base == memblock_end_of_DRAM() - size);
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -673,6 +725,8 @@ static int alloc_try_nid_bottom_up_simple_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_128;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -689,15 +743,17 @@ static int alloc_try_nid_bottom_up_simple_check(void)
 	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, min_addr);
+	ASSERT_LT(rgn_end, max_addr);
 
-	assert(rgn->size == size);
-	assert(rgn->base == min_addr);
-	assert(rgn_end < max_addr);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -725,6 +781,8 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_128;
 	phys_addr_t misalign = SZ_2;
 	phys_addr_t min_addr;
@@ -742,15 +800,17 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
 	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, min_addr + (SMP_CACHE_BYTES - misalign));
+	ASSERT_LT(rgn_end, max_addr);
 
-	assert(rgn->size == size);
-	assert(rgn->base == min_addr + (SMP_CACHE_BYTES - misalign));
-	assert(rgn_end < max_addr);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -778,6 +838,8 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_256;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -792,14 +854,16 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
 					       NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
 
-	assert(rgn->size == size);
-	assert(rgn->base == memblock_start_of_DRAM());
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -829,6 +893,8 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
 	char *b;
 	struct region r1, r2;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r3_size = SZ_64;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t total_size;
@@ -855,17 +921,19 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
 					       NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
 
-	assert(rgn1->size == r1.size);
-	assert(rgn1->base == max_addr);
+	ASSERT_EQ(rgn1->size, r1.size);
+	ASSERT_EQ(rgn1->base, max_addr);
 
-	assert(rgn2->size == r2.size + r3_size);
-	assert(rgn2->base == r2.base);
+	ASSERT_EQ(rgn2->size, r2.size + r3_size);
+	ASSERT_EQ(rgn2->base, r2.base);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -899,6 +967,8 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
 	char *b;
 	struct region r1, r2;
 
+	PREFIX_PUSH();
+
 	phys_addr_t r3_size = SZ_256;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t total_size;
@@ -925,20 +995,22 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
 					       NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn3->size, r3_size);
+	ASSERT_EQ(rgn3->base, memblock_start_of_DRAM());
 
-	assert(rgn3->size == r3_size);
-	assert(rgn3->base == memblock_start_of_DRAM());
+	ASSERT_EQ(rgn2->size, r2.size);
+	ASSERT_EQ(rgn2->base, r2.base);
 
-	assert(rgn2->size == r2.size);
-	assert(rgn2->base == r2.base);
+	ASSERT_EQ(rgn1->size, r1.size);
+	ASSERT_EQ(rgn1->base, r1.base);
 
-	assert(rgn1->size == r1.size);
-	assert(rgn1->base == r1.base);
+	ASSERT_EQ(memblock.reserved.cnt, 3);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 3);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -954,6 +1026,8 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_256;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -968,14 +1042,16 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
 					       NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, min_addr);
 
-	assert(rgn->size == size);
-	assert(rgn->base == min_addr);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -991,6 +1067,8 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
 	void *allocated_ptr = NULL;
 	char *b;
 
+	PREFIX_PUSH();
+
 	phys_addr_t size = SZ_1K;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
@@ -1005,14 +1083,16 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
 					       NUMA_NO_NODE);
 	b = (char *)allocated_ptr;
 
-	assert(allocated_ptr);
-	assert(*b == 0);
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_EQ(*b, 0);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
 
-	assert(rgn->size == size);
-	assert(rgn->base == memblock_start_of_DRAM());
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -1020,6 +1100,7 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
 /* Test case wrappers */
 static int alloc_try_nid_simple_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_simple_check();
 	memblock_set_bottom_up(true);
@@ -1030,6 +1111,7 @@ static int alloc_try_nid_simple_check(void)
 
 static int alloc_try_nid_misaligned_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_end_misaligned_check();
 	memblock_set_bottom_up(true);
@@ -1040,6 +1122,7 @@ static int alloc_try_nid_misaligned_check(void)
 
 static int alloc_try_nid_narrow_range_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_narrow_range_check();
 	memblock_set_bottom_up(true);
@@ -1050,6 +1133,7 @@ static int alloc_try_nid_narrow_range_check(void)
 
 static int alloc_try_nid_reserved_with_space_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_reserved_with_space_check();
 	memblock_set_bottom_up(true);
@@ -1060,6 +1144,7 @@ static int alloc_try_nid_reserved_with_space_check(void)
 
 static int alloc_try_nid_reserved_no_space_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_reserved_no_space_check();
 	memblock_set_bottom_up(true);
@@ -1070,6 +1155,7 @@ static int alloc_try_nid_reserved_no_space_check(void)
 
 static int alloc_try_nid_cap_max_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_cap_max_check();
 	memblock_set_bottom_up(true);
@@ -1080,6 +1166,7 @@ static int alloc_try_nid_cap_max_check(void)
 
 static int alloc_try_nid_cap_min_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_top_down_cap_min_check();
 	memblock_set_bottom_up(true);
@@ -1090,6 +1177,7 @@ static int alloc_try_nid_cap_min_check(void)
 
 static int alloc_try_nid_min_reserved_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_min_reserved_generic_check();
 	memblock_set_bottom_up(true);
@@ -1100,6 +1188,7 @@ static int alloc_try_nid_min_reserved_check(void)
 
 static int alloc_try_nid_max_reserved_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_max_reserved_generic_check();
 	memblock_set_bottom_up(true);
@@ -1110,6 +1199,7 @@ static int alloc_try_nid_max_reserved_check(void)
 
 static int alloc_try_nid_exact_address_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_exact_address_generic_check();
 	memblock_set_bottom_up(true);
@@ -1120,6 +1210,7 @@ static int alloc_try_nid_exact_address_check(void)
 
 static int alloc_try_nid_reserved_full_merge_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_reserved_full_merge_generic_check();
 	memblock_set_bottom_up(true);
@@ -1130,6 +1221,7 @@ static int alloc_try_nid_reserved_full_merge_check(void)
 
 static int alloc_try_nid_reserved_all_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_reserved_all_generic_check();
 	memblock_set_bottom_up(true);
@@ -1140,6 +1232,7 @@ static int alloc_try_nid_reserved_all_check(void)
 
 static int alloc_try_nid_low_max_check(void)
 {
+	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_try_nid_low_max_generic_check();
 	memblock_set_bottom_up(true);
@@ -1150,6 +1243,12 @@ static int alloc_try_nid_low_max_check(void)
 
 int memblock_alloc_nid_checks(void)
 {
+	const char *func_testing = "memblock_alloc_try_nid";
+
+	prefix_reset();
+	prefix_push(func_testing);
+	test_print("Running %s tests...\n", func_testing);
+
 	reset_memblock_attributes();
 	dummy_physical_memory_init();
 
@@ -1170,5 +1269,7 @@ int memblock_alloc_nid_checks(void)
 
 	dummy_physical_memory_cleanup();
 
+	prefix_pop();
+
 	return 0;
 }
diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index a7bc180316d6..66f46f261e66 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -4,21 +4,29 @@
 #include "basic_api.h"
 
 #define EXPECTED_MEMBLOCK_REGIONS			128
+#define FUNC_ADD					"memblock_add"
+#define FUNC_RESERVE					"memblock_reserve"
+#define FUNC_REMOVE					"memblock_remove"
+#define FUNC_FREE					"memblock_free"
 
 static int memblock_initialization_check(void)
 {
-	assert(memblock.memory.regions);
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
-	assert(strcmp(memblock.memory.name, "memory") == 0);
+	PREFIX_PUSH();
 
-	assert(memblock.reserved.regions);
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
-	assert(strcmp(memblock.reserved.name, "reserved") == 0);
+	ASSERT_NE(memblock.memory.regions, NULL);
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.max, EXPECTED_MEMBLOCK_REGIONS);
+	ASSERT_EQ(strcmp(memblock.memory.name, "memory"), 0);
 
-	assert(!memblock.bottom_up);
-	assert(memblock.current_limit == MEMBLOCK_ALLOC_ANYWHERE);
+	ASSERT_NE(memblock.reserved.regions, NULL);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.memory.max, EXPECTED_MEMBLOCK_REGIONS);
+	ASSERT_EQ(strcmp(memblock.reserved.name, "reserved"), 0);
+
+	ASSERT_EQ(memblock.bottom_up, false);
+	ASSERT_EQ(memblock.current_limit, MEMBLOCK_ALLOC_ANYWHERE);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -40,14 +48,18 @@ static int memblock_add_simple_check(void)
 		.size = SZ_4M
 	};
 
+	PREFIX_PUSH();
+
 	reset_memblock_regions();
 	memblock_add(r.base, r.size);
 
-	assert(rgn->base == r.base);
-	assert(rgn->size == r.size);
+	ASSERT_EQ(rgn->base, r.base);
+	ASSERT_EQ(rgn->size, r.size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, r.size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == r.size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -69,18 +81,22 @@ static int memblock_add_node_simple_check(void)
 		.size = SZ_16M
 	};
 
+	PREFIX_PUSH();
+
 	reset_memblock_regions();
 	memblock_add_node(r.base, r.size, 1, MEMBLOCK_HOTPLUG);
 
-	assert(rgn->base == r.base);
-	assert(rgn->size == r.size);
+	ASSERT_EQ(rgn->base, r.base);
+	ASSERT_EQ(rgn->size, r.size);
 #ifdef CONFIG_NUMA
-	assert(rgn->nid == 1);
+	ASSERT_EQ(rgn->nid, 1);
 #endif
-	assert(rgn->flags == MEMBLOCK_HOTPLUG);
+	ASSERT_EQ(rgn->flags, MEMBLOCK_HOTPLUG);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, r.size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == r.size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -113,18 +129,22 @@ static int memblock_add_disjoint_check(void)
 		.size = SZ_8K
 	};
 
+	PREFIX_PUSH();
+
 	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);
 
-	assert(rgn1->base == r1.base);
-	assert(rgn1->size == r1.size);
+	ASSERT_EQ(rgn1->base, r1.base);
+	ASSERT_EQ(rgn1->size, r1.size);
+
+	ASSERT_EQ(rgn2->base, r2.base);
+	ASSERT_EQ(rgn2->size, r2.size);
 
-	assert(rgn2->base == r2.base);
-	assert(rgn2->size == r2.size);
+	ASSERT_EQ(memblock.memory.cnt, 2);
+	ASSERT_EQ(memblock.memory.total_size, r1.size + r2.size);
 
-	assert(memblock.memory.cnt == 2);
-	assert(memblock.memory.total_size == r1.size + r2.size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -162,17 +182,21 @@ static int memblock_add_overlap_top_check(void)
 		.size = SZ_512M
 	};
 
+	PREFIX_PUSH();
+
 	total_size = (r1.base - r2.base) + r1.size;
 
 	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);
 
-	assert(rgn->base == r2.base);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r2.base);
+	ASSERT_EQ(rgn->size, total_size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, total_size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == total_size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -210,17 +234,21 @@ static int memblock_add_overlap_bottom_check(void)
 		.size = SZ_1G
 	};
 
+	PREFIX_PUSH();
+
 	total_size = (r2.base - r1.base) + r2.size;
 
 	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, total_size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, total_size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == total_size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -255,15 +283,19 @@ static int memblock_add_within_check(void)
 		.size = SZ_1M
 	};
 
+	PREFIX_PUSH();
+
 	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == r1.size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, r1.size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, r1.size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == r1.size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -279,19 +311,27 @@ static int memblock_add_twice_check(void)
 		.size = SZ_2M
 	};
 
+	PREFIX_PUSH();
+
 	reset_memblock_regions();
 
 	memblock_add(r.base, r.size);
 	memblock_add(r.base, r.size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == r.size);
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, r.size);
+
+	test_pass_pop();
 
 	return 0;
 }
 
 static int memblock_add_checks(void)
 {
+	prefix_reset();
+	prefix_push(FUNC_ADD);
+	test_print("Running %s tests...\n", FUNC_ADD);
+
 	memblock_add_simple_check();
 	memblock_add_node_simple_check();
 	memblock_add_disjoint_check();
@@ -300,6 +340,8 @@ static int memblock_add_checks(void)
 	memblock_add_within_check();
 	memblock_add_twice_check();
 
+	prefix_pop();
+
 	return 0;
 }
 
@@ -320,11 +362,15 @@ static int memblock_reserve_simple_check(void)
 		.size = SZ_128M
 	};
 
+	PREFIX_PUSH();
+
 	reset_memblock_regions();
 	memblock_reserve(r.base, r.size);
 
-	assert(rgn->base == r.base);
-	assert(rgn->size == r.size);
+	ASSERT_EQ(rgn->base, r.base);
+	ASSERT_EQ(rgn->size, r.size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -356,18 +402,22 @@ static int memblock_reserve_disjoint_check(void)
 		.size = SZ_512M
 	};
 
+	PREFIX_PUSH();
+
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	assert(rgn1->base == r1.base);
-	assert(rgn1->size == r1.size);
+	ASSERT_EQ(rgn1->base, r1.base);
+	ASSERT_EQ(rgn1->size, r1.size);
+
+	ASSERT_EQ(rgn2->base, r2.base);
+	ASSERT_EQ(rgn2->size, r2.size);
 
-	assert(rgn2->base == r2.base);
-	assert(rgn2->size == r2.size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, r1.size + r2.size);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == r1.size + r2.size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -406,17 +456,21 @@ static int memblock_reserve_overlap_top_check(void)
 		.size = SZ_1G
 	};
 
+	PREFIX_PUSH();
+
 	total_size = (r1.base - r2.base) + r1.size;
 
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	assert(rgn->base == r2.base);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r2.base);
+	ASSERT_EQ(rgn->size, total_size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -455,17 +509,21 @@ static int memblock_reserve_overlap_bottom_check(void)
 		.size = SZ_128K
 	};
 
+	PREFIX_PUSH();
+
 	total_size = (r2.base - r1.base) + r2.size;
 
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, total_size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -502,15 +560,19 @@ static int memblock_reserve_within_check(void)
 		.size = SZ_64K
 	};
 
+	PREFIX_PUSH();
+
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == r1.size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, r1.size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, r1.size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == r1.size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -527,19 +589,27 @@ static int memblock_reserve_twice_check(void)
 		.size = SZ_2M
 	};
 
+	PREFIX_PUSH();
+
 	reset_memblock_regions();
 
 	memblock_reserve(r.base, r.size);
 	memblock_reserve(r.base, r.size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == r.size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, r.size);
+
+	test_pass_pop();
 
 	return 0;
 }
 
 static int memblock_reserve_checks(void)
 {
+	prefix_reset();
+	prefix_push(FUNC_RESERVE);
+	test_print("Running %s tests...\n", FUNC_RESERVE);
+
 	memblock_reserve_simple_check();
 	memblock_reserve_disjoint_check();
 	memblock_reserve_overlap_top_check();
@@ -547,6 +617,8 @@ static int memblock_reserve_checks(void)
 	memblock_reserve_within_check();
 	memblock_reserve_twice_check();
 
+	prefix_pop();
+
 	return 0;
 }
 
@@ -581,16 +653,20 @@ static int memblock_remove_simple_check(void)
 		.size = SZ_4M
 	};
 
+	PREFIX_PUSH();
+
 	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);
 	memblock_remove(r1.base, r1.size);
 
-	assert(rgn->base == r2.base);
-	assert(rgn->size == r2.size);
+	ASSERT_EQ(rgn->base, r2.base);
+	ASSERT_EQ(rgn->size, r2.size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == r2.size);
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, r2.size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -626,15 +702,19 @@ static int memblock_remove_absent_check(void)
 		.size = SZ_1G
 	};
 
+	PREFIX_PUSH();
+
 	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_remove(r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == r1.size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, r1.size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, r1.size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == r1.size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -674,6 +754,8 @@ static int memblock_remove_overlap_top_check(void)
 		.size = SZ_32M
 	};
 
+	PREFIX_PUSH();
+
 	r1_end = r1.base + r1.size;
 	r2_end = r2.base + r2.size;
 	total_size = r1_end - r2_end;
@@ -682,11 +764,13 @@ static int memblock_remove_overlap_top_check(void)
 	memblock_add(r1.base, r1.size);
 	memblock_remove(r2.base, r2.size);
 
-	assert(rgn->base == r1.base + r2.base);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r1.base + r2.base);
+	ASSERT_EQ(rgn->size, total_size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, total_size);
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == total_size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -724,17 +808,22 @@ static int memblock_remove_overlap_bottom_check(void)
 		.size = SZ_256M
 	};
 
+	PREFIX_PUSH();
+
 	total_size = r2.base - r1.base;
 
 	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_remove(r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, total_size);
+
+	ASSERT_EQ(memblock.memory.cnt, 1);
+	ASSERT_EQ(memblock.memory.total_size, total_size);
+
+	test_pass_pop();
 
-	assert(memblock.memory.cnt == 1);
-	assert(memblock.memory.total_size == total_size);
 	return 0;
 }
 
@@ -774,6 +863,8 @@ static int memblock_remove_within_check(void)
 		.size = SZ_1M
 	};
 
+	PREFIX_PUSH();
+
 	r1_size = r2.base - r1.base;
 	r2_size = (r1.base + r1.size) - (r2.base + r2.size);
 	total_size = r1_size + r2_size;
@@ -782,26 +873,34 @@ static int memblock_remove_within_check(void)
 	memblock_add(r1.base, r1.size);
 	memblock_remove(r2.base, r2.size);
 
-	assert(rgn1->base == r1.base);
-	assert(rgn1->size == r1_size);
+	ASSERT_EQ(rgn1->base, r1.base);
+	ASSERT_EQ(rgn1->size, r1_size);
+
+	ASSERT_EQ(rgn2->base, r2.base + r2.size);
+	ASSERT_EQ(rgn2->size, r2_size);
 
-	assert(rgn2->base == r2.base + r2.size);
-	assert(rgn2->size == r2_size);
+	ASSERT_EQ(memblock.memory.cnt, 2);
+	ASSERT_EQ(memblock.memory.total_size, total_size);
 
-	assert(memblock.memory.cnt == 2);
-	assert(memblock.memory.total_size == total_size);
+	test_pass_pop();
 
 	return 0;
 }
 
 static int memblock_remove_checks(void)
 {
+	prefix_reset();
+	prefix_push(FUNC_REMOVE);
+	test_print("Running %s tests...\n", FUNC_REMOVE);
+
 	memblock_remove_simple_check();
 	memblock_remove_absent_check();
 	memblock_remove_overlap_top_check();
 	memblock_remove_overlap_bottom_check();
 	memblock_remove_within_check();
 
+	prefix_pop();
+
 	return 0;
 }
 
@@ -835,16 +934,20 @@ static int memblock_free_simple_check(void)
 		.size = SZ_1M
 	};
 
+	PREFIX_PUSH();
+
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 	memblock_free((void *)r1.base, r1.size);
 
-	assert(rgn->base == r2.base);
-	assert(rgn->size == r2.size);
+	ASSERT_EQ(rgn->base, r2.base);
+	ASSERT_EQ(rgn->size, r2.size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, r2.size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == r2.size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -880,15 +983,19 @@ static int memblock_free_absent_check(void)
 		.size = SZ_128M
 	};
 
+	PREFIX_PUSH();
+
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_free((void *)r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == r1.size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, r1.size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, r1.size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == r1.size);
+	test_pass_pop();
 
 	return 0;
 }
@@ -928,17 +1035,21 @@ static int memblock_free_overlap_top_check(void)
 		.size = SZ_8M
 	};
 
+	PREFIX_PUSH();
+
 	total_size = (r1.size + r1.base) - (r2.base + r2.size);
 
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_free((void *)r2.base, r2.size);
 
-	assert(rgn->base == r2.base + r2.size);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r2.base + r2.size);
+	ASSERT_EQ(rgn->size, total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -973,17 +1084,21 @@ static int memblock_free_overlap_bottom_check(void)
 		.size = SZ_32M
 	};
 
+	PREFIX_PUSH();
+
 	total_size = r2.base - r1.base;
 
 	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_free((void *)r2.base, r2.size);
 
-	assert(rgn->base == r1.base);
-	assert(rgn->size == total_size);
+	ASSERT_EQ(rgn->base, r1.base);
+	ASSERT_EQ(rgn->size, total_size);
 
-	assert(memblock.reserved.cnt == 1);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
 
 	return 0;
 }
@@ -1024,6 +1139,8 @@ static int memblock_free_within_check(void)
 		.size = SZ_1M
 	};
 
+	PREFIX_PUSH();
+
 	r1_size = r2.base - r1.base;
 	r2_size = (r1.base + r1.size) - (r2.base + r2.size);
 	total_size = r1_size + r2_size;
@@ -1032,26 +1149,34 @@ static int memblock_free_within_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_free((void *)r2.base, r2.size);
 
-	assert(rgn1->base == r1.base);
-	assert(rgn1->size == r1_size);
+	ASSERT_EQ(rgn1->base, r1.base);
+	ASSERT_EQ(rgn1->size, r1_size);
 
-	assert(rgn2->base == r2.base + r2.size);
-	assert(rgn2->size == r2_size);
+	ASSERT_EQ(rgn2->base, r2.base + r2.size);
+	ASSERT_EQ(rgn2->size, r2_size);
 
-	assert(memblock.reserved.cnt == 2);
-	assert(memblock.reserved.total_size == total_size);
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
 
 	return 0;
 }
 
 static int memblock_free_checks(void)
 {
+	prefix_reset();
+	prefix_push(FUNC_FREE);
+	test_print("Running %s tests...\n", FUNC_FREE);
+
 	memblock_free_simple_check();
 	memblock_free_absent_check();
 	memblock_free_overlap_top_check();
 	memblock_free_overlap_bottom_check();
 	memblock_free_within_check();
 
+	prefix_pop();
+
 	return 0;
 }
 
diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index 62d3191f7c9a..ebc06b4c3255 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -4,8 +4,12 @@
 
 #define INIT_MEMBLOCK_REGIONS			128
 #define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
+#define PREFIXES_MAX				15
+#define DELIM					": "
 
 static struct test_memory memory_block;
+static const char __maybe_unused *prefixes[PREFIXES_MAX];
+static int __maybe_unused nr_prefixes;
 
 void reset_memblock_regions(void)
 {
@@ -46,3 +50,56 @@ void dummy_physical_memory_cleanup(void)
 {
 	free(memory_block.base);
 }
+
+#ifdef VERBOSE
+void print_prefixes(const char *postfix)
+{
+	for (int i = 0; i < nr_prefixes; i++)
+		test_print("%s%s", prefixes[i], DELIM);
+	test_print(postfix);
+}
+
+void test_fail(void)
+{
+	ksft_test_result_fail(": ");
+	print_prefixes("failed\n");
+}
+
+void test_pass(void)
+{
+	ksft_test_result_pass(": ");
+	print_prefixes("passed\n");
+}
+
+void test_print(const char *fmt, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	va_start(args, fmt);
+	errno = saved_errno;
+	vprintf(fmt, args);
+	va_end(args);
+}
+
+void prefix_reset(void)
+{
+	memset(prefixes, 0, PREFIXES_MAX * sizeof(char *));
+	nr_prefixes = 0;
+}
+
+void prefix_push(const char *prefix)
+{
+	assert(nr_prefixes < PREFIXES_MAX);
+	prefixes[nr_prefixes] = prefix;
+	nr_prefixes++;
+}
+
+void prefix_pop(void)
+{
+	if (nr_prefixes > 0) {
+		prefixes[nr_prefixes - 1] = 0;
+		nr_prefixes--;
+	}
+}
+#endif /* VERBOSE */
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 619054d03219..46de86a755f3 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -7,9 +7,49 @@
 #include <linux/types.h>
 #include <linux/memblock.h>
 #include <linux/sizes.h>
+#include <linux/printk.h>
+#include <../selftests/kselftest.h>
 
 #define MEM_SIZE SZ_16K
 
+/**
+ * ASSERT_EQ():
+ * Check the condition
+ * @_expected == @_seen
+ * If false, print failed test message (if in VERBOSE mode) and then assert
+ */
+#define ASSERT_EQ(_expected, _seen) do { \
+	if ((_expected) != (_seen)) \
+		test_fail(); \
+	assert((_expected) == (_seen)); \
+} while (0)
+
+/**
+ * ASSERT_NE():
+ * Check the condition
+ * @_expected != @_seen
+ * If false, print failed test message (if in VERBOSE mode) and then assert
+ */
+#define ASSERT_NE(_expected, _seen) do { \
+	if ((_expected) == (_seen)) \
+		test_fail(); \
+	assert((_expected) != (_seen)); \
+} while (0)
+
+/**
+ * ASSERT_LT():
+ * Check the condition
+ * @_expected < @_seen
+ * If false, print failed test message (if in VERBOSE mode) and then assert
+ */
+#define ASSERT_LT(_expected, _seen) do { \
+	if ((_expected) >= (_seen)) \
+		test_fail(); \
+	assert((_expected) < (_seen)); \
+} while (0)
+
+#define PREFIX_PUSH() prefix_push(__func__)
+
 /*
  * Available memory registered with memblock needs to be valid for allocs
  * test to run. This is a convenience wrapper for memory allocated in
@@ -31,4 +71,26 @@ void setup_memblock(void);
 void dummy_physical_memory_init(void);
 void dummy_physical_memory_cleanup(void);
 
+#ifdef VERBOSE
+void test_fail(void);
+void test_pass(void);
+void test_print(const char *fmt, ...);
+void prefix_reset(void);
+void prefix_push(const char *prefix);
+void prefix_pop(void);
+#else
+static inline void test_fail(void) {}
+static inline void test_pass(void) {}
+static inline void test_print(const char *fmt, ...) {}
+static inline void prefix_reset(void) {}
+static inline void prefix_push(const char *prefix) {}
+static inline void prefix_pop(void) {}
+#endif /* VERBOSE */
+
+static inline void test_pass_pop(void)
+{
+	test_pass();
+	prefix_pop();
+}
+
 #endif
-- 
2.34.1

