Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7CC5AC257
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiIDEYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiIDEYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:24:18 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A70C4DB05
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 21:24:16 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-11e9a7135easo14564420fac.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 21:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=GfcbyZijaXqemBql9JbVcFguwRU1k9i39hT5KMCovS0=;
        b=HLfBsnaqXlGx6Z5AQ/y2AHaTSt3dAk19FNdq931svL893zZga+jvC7AZFxEhbfzSyr
         l+aiZT3F0Ze1hsHbdcbY8c7JzBaqlWkSSjEuHftanc2MDVH+10K2cn8r/UBtgVxkLaiO
         x1lTkyvIJ/gfhsIQN0wDeHF1hdOjGO6MVyeD4HQlJ+HVS7496ZpLwo19qieG31x8qEvS
         L1ijI3gl25rc//jwdw1e9xoKxtufrD9eS1GitNZHMrTbEc0S1aBLVEXqdGt4LWIhepUi
         mdnCUpURsTPrSlhhII1fSJS+fm5i/WxYQHKAhO/cw0nnCfEa+Xup+px7aGx0dLUgiDYd
         lRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=GfcbyZijaXqemBql9JbVcFguwRU1k9i39hT5KMCovS0=;
        b=yDvll8JEffg5NyJqde6Uy8QRZFv92hd4h0MUmmjQel+4/n7Hk+svMgT8VXzz/mbTom
         aqHpJMjhjJXf1IOmJCeFhmvt6triHjsodm/svS++3WnRrF+W3QZOu9t+Lyk/0h/ibbgO
         TshyKxszCKqDaju/zUspf74x7KakIM8196IqIo3yTEIlucUyWpq7nEI35FXJBHFJH7pI
         69SHuPytl9bHmF40mp3qBUdfvBjGZZ8gE4+0RiwJOJIwXzzTfajctC1STgD2AlOcnQE0
         uJlFoydJEMiAqY8eYyuzKuIzrKlXPbKBNsgVzThCafs/JYfIE9JUS4Q88lxS+5bnVagY
         aqtA==
X-Gm-Message-State: ACgBeo3Xeq5Cuzj6CKiqf64OxtvilGqEzWcfivJAPmqBJ7hfqrbifTBl
        J6RMwRWJk8kEvjTXAk96FPOoTbrwdr4=
X-Google-Smtp-Source: AA6agR6QBqkostyIGwf5SihAKe4+49drJpicVjlizf1WCJussETwWz0h262P6gIZXaiixfNU7k2HyA==
X-Received: by 2002:a05:6870:d1c9:b0:127:2df9:b459 with SMTP id b9-20020a056870d1c900b001272df9b459mr593764oac.168.1662265454311;
        Sat, 03 Sep 2022 21:24:14 -0700 (PDT)
Received: from sophie (static-198-54-128-109.cust.tzulo.com. [198.54.128.109])
        by smtp.gmail.com with ESMTPSA id g20-20020a9d6194000000b00616dfd2c859sm2939724otk.59.2022.09.03.21.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 21:24:14 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH] memblock_tests: move variable declarations to single block
Date:   Sat,  3 Sep 2022 23:24:06 -0500
Message-Id: <e61431e73977f305fdd027bca99d1dc119e96d84.1662264355.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Move variable declarations to a single block at the beginning of each
testing function.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_api.c      | 57 ++++---------
 .../memblock/tests/alloc_helpers_api.c        | 32 ++------
 tools/testing/memblock/tests/alloc_nid_api.c  | 80 +++++--------------
 3 files changed, 42 insertions(+), 127 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
index 36dd7e254cce..68f1a75cd72c 100644
--- a/tools/testing/memblock/tests/alloc_api.c
+++ b/tools/testing/memblock/tests/alloc_api.c
@@ -25,12 +25,10 @@ static int alloc_top_down_simple_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_2;
 	phys_addr_t expected_start;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	expected_start = memblock_end_of_DRAM() - SMP_CACHE_BYTES;
@@ -76,15 +74,13 @@ static int alloc_top_down_disjoint_check(void)
 	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
 	struct region r1;
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r2_size = SZ_16;
 	/* Use custom alignment */
 	phys_addr_t alignment = SMP_CACHE_BYTES * 2;
 	phys_addr_t total_size;
 	phys_addr_t expected_start;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	r1.base = memblock_end_of_DRAM() - SZ_2;
@@ -128,9 +124,6 @@ static int alloc_top_down_before_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	/*
 	 * The first region ends at the aligned address to test region merging
 	 */
@@ -138,6 +131,7 @@ static int alloc_top_down_before_check(void)
 	phys_addr_t r2_size = SZ_512;
 	phys_addr_t total_size = r1_size + r2_size;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	memblock_reserve(memblock_end_of_DRAM() - total_size, r1_size);
@@ -174,12 +168,10 @@ static int alloc_top_down_after_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	struct region r1;
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r2_size = SZ_512;
 	phys_addr_t total_size;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	/*
@@ -225,12 +217,10 @@ static int alloc_top_down_second_fit_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	struct region r1, r2;
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r3_size = SZ_1K;
 	phys_addr_t total_size;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	r1.base = memblock_end_of_DRAM() - SZ_512;
@@ -276,9 +266,6 @@ static int alloc_in_between_generic_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	struct region r1, r2;
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t r3_size = SZ_64;
 	/*
@@ -287,6 +274,7 @@ static int alloc_in_between_generic_check(void)
 	phys_addr_t rgn_size = (MEM_SIZE - (2 * gap_size + r3_size)) / 2;
 	phys_addr_t total_size;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	r1.size = rgn_size;
@@ -332,13 +320,11 @@ static int alloc_in_between_generic_check(void)
 static int alloc_small_gaps_generic_check(void)
 {
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t region_size = SZ_1K;
 	phys_addr_t gap_size = SZ_256;
 	phys_addr_t region_end;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	region_end = memblock_start_of_DRAM();
@@ -366,7 +352,6 @@ static int alloc_all_reserved_generic_check(void)
 	void *allocated_ptr = NULL;
 
 	PREFIX_PUSH();
-
 	setup_memblock();
 
 	/* Simulate full memory */
@@ -397,14 +382,12 @@ static int alloc_all_reserved_generic_check(void)
 static int alloc_no_space_generic_check(void)
 {
 	void *allocated_ptr = NULL;
+	phys_addr_t available_size = SZ_256;
+	phys_addr_t reserved_size = MEM_SIZE - available_size;
 
 	PREFIX_PUSH();
-
 	setup_memblock();
 
-	phys_addr_t available_size = SZ_256;
-	phys_addr_t reserved_size = MEM_SIZE - available_size;
-
 	/* Simulate almost-full memory */
 	memblock_reserve(memblock_start_of_DRAM(), reserved_size);
 
@@ -432,12 +415,10 @@ static int alloc_limited_space_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t available_size = SZ_256;
 	phys_addr_t reserved_size = MEM_SIZE - available_size;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	/* Simulate almost-full memory */
@@ -504,7 +485,6 @@ static int alloc_too_large_generic_check(void)
 	void *allocated_ptr = NULL;
 
 	PREFIX_PUSH();
-
 	setup_memblock();
 
 	allocated_ptr = run_memblock_alloc(MEM_SIZE + SZ_2, SMP_CACHE_BYTES);
@@ -530,7 +510,6 @@ static int alloc_bottom_up_simple_check(void)
 	void *allocated_ptr = NULL;
 
 	PREFIX_PUSH();
-
 	setup_memblock();
 
 	allocated_ptr = run_memblock_alloc(SZ_2, SMP_CACHE_BYTES);
@@ -572,15 +551,13 @@ static int alloc_bottom_up_disjoint_check(void)
 	struct memblock_region *rgn2 = &memblock.reserved.regions[1];
 	struct region r1;
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r2_size = SZ_16;
 	/* Use custom alignment */
 	phys_addr_t alignment = SMP_CACHE_BYTES * 2;
 	phys_addr_t total_size;
 	phys_addr_t expected_start;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	r1.base = memblock_start_of_DRAM() + SZ_2;
@@ -624,13 +601,11 @@ static int alloc_bottom_up_before_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r1_size = SZ_512;
 	phys_addr_t r2_size = SZ_128;
 	phys_addr_t total_size = r1_size + r2_size;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	memblock_reserve(memblock_start_of_DRAM() + r1_size, r2_size);
@@ -666,12 +641,10 @@ static int alloc_bottom_up_after_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	struct region r1;
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r2_size = SZ_512;
 	phys_addr_t total_size;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	/*
@@ -718,12 +691,10 @@ static int alloc_bottom_up_second_fit_check(void)
 	struct memblock_region *rgn  = &memblock.reserved.regions[1];
 	struct region r1, r2;
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r3_size = SZ_1K;
 	phys_addr_t total_size;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	r1.base = memblock_start_of_DRAM();
diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
index 06577bd0e349..3ef9486da8a0 100644
--- a/tools/testing/memblock/tests/alloc_helpers_api.c
+++ b/tools/testing/memblock/tests/alloc_helpers_api.c
@@ -19,12 +19,10 @@ static int alloc_from_simple_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_16;
 	phys_addr_t min_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_end_of_DRAM() - SMP_CACHE_BYTES;
@@ -64,12 +62,10 @@ static int alloc_from_misaligned_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_32;
 	phys_addr_t min_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	/* A misaligned address */
@@ -113,12 +109,10 @@ static int alloc_from_top_down_high_addr_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_32;
 	phys_addr_t min_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	/* The address is too close to the end of the memory */
@@ -158,14 +152,12 @@ static int alloc_from_top_down_no_space_above_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t r2_size = SZ_2;
 	phys_addr_t total_size = r1_size + r2_size;
 	phys_addr_t min_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
@@ -197,13 +189,11 @@ static int alloc_from_top_down_min_addr_cap_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t min_addr;
 	phys_addr_t start_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	start_addr = (phys_addr_t)memblock_start_of_DRAM();
@@ -245,12 +235,10 @@ static int alloc_from_bottom_up_high_addr_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_32;
 	phys_addr_t min_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	/* The address is too close to the end of the memory */
@@ -289,13 +277,11 @@ static int alloc_from_bottom_up_no_space_above_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t min_addr;
 	phys_addr_t r2_size;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_start_of_DRAM() + SZ_128;
@@ -327,13 +313,11 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t min_addr;
 	phys_addr_t start_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	start_addr = (phys_addr_t)memblock_start_of_DRAM();
diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 77f83f31c835..5789379ad9da 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -47,14 +47,12 @@ static int alloc_try_nid_top_down_simple_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_128;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
 	phys_addr_t rgn_end;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
@@ -101,15 +99,13 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_128;
 	phys_addr_t misalign = SZ_2;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
 	phys_addr_t rgn_end;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
@@ -154,14 +150,12 @@ static int alloc_try_nid_exact_address_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_1K;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
 	phys_addr_t rgn_end;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES;
@@ -208,13 +202,11 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_256;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_start_of_DRAM() + SZ_512;
@@ -261,13 +253,11 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
 static int alloc_try_nid_low_max_generic_check(void)
 {
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_1K;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_start_of_DRAM();
@@ -302,9 +292,6 @@ static int alloc_try_nid_min_reserved_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r1_size = SZ_128;
 	phys_addr_t r2_size = SZ_64;
 	phys_addr_t total_size = r1_size + r2_size;
@@ -312,6 +299,7 @@ static int alloc_try_nid_min_reserved_generic_check(void)
 	phys_addr_t max_addr;
 	phys_addr_t reserved_base;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	max_addr = memblock_end_of_DRAM();
@@ -356,15 +344,13 @@ static int alloc_try_nid_max_reserved_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r1_size = SZ_64;
 	phys_addr_t r2_size = SZ_128;
 	phys_addr_t total_size = r1_size + r2_size;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	max_addr = memblock_end_of_DRAM() - r1_size;
@@ -413,15 +399,13 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
 	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 	struct region r1, r2;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r3_size = SZ_64;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t total_size;
 	phys_addr_t max_addr;
 	phys_addr_t min_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
@@ -479,14 +463,12 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 	struct region r1, r2;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r3_size = SZ_64;
 	phys_addr_t total_size;
 	phys_addr_t max_addr;
 	phys_addr_t min_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
@@ -544,15 +526,13 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
 	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 	struct region r1, r2;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r3_size = SZ_256;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t total_size;
 	phys_addr_t max_addr;
 	phys_addr_t min_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
@@ -613,14 +593,12 @@ static int alloc_try_nid_reserved_all_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 	struct region r1, r2;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r3_size = SZ_256;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t max_addr;
 	phys_addr_t min_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES;
@@ -655,13 +633,11 @@ static int alloc_try_nid_top_down_cap_max_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_256;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_end_of_DRAM() - SZ_1K;
@@ -694,13 +670,11 @@ static int alloc_try_nid_top_down_cap_min_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_1K;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_start_of_DRAM() - SZ_256;
@@ -742,14 +716,12 @@ static int alloc_try_nid_bottom_up_simple_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_128;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
 	phys_addr_t rgn_end;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
@@ -796,15 +768,13 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_128;
 	phys_addr_t misalign = SZ_2;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
 	phys_addr_t rgn_end;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_start_of_DRAM() + misalign;
@@ -851,13 +821,11 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_256;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_start_of_DRAM() + SZ_512;
@@ -904,15 +872,13 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
 	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 	struct region r1, r2;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r3_size = SZ_64;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t total_size;
 	phys_addr_t max_addr;
 	phys_addr_t min_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
@@ -976,15 +942,13 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
 	struct memblock_region *rgn3 = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
 	struct region r1, r2;
-
-	PREFIX_PUSH();
-
 	phys_addr_t r3_size = SZ_256;
 	phys_addr_t gap_size = SMP_CACHE_BYTES;
 	phys_addr_t total_size;
 	phys_addr_t max_addr;
 	phys_addr_t min_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
@@ -1033,13 +997,11 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_256;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_start_of_DRAM() + SZ_1K;
@@ -1072,13 +1034,11 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-
-	PREFIX_PUSH();
-
 	phys_addr_t size = SZ_1K;
 	phys_addr_t min_addr;
 	phys_addr_t max_addr;
 
+	PREFIX_PUSH();
 	setup_memblock();
 
 	min_addr = memblock_start_of_DRAM();
-- 
2.25.1

