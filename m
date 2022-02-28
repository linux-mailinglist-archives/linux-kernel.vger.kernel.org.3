Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F0D4C6FED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbiB1OsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiB1OsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:48:03 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1161864D9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:24 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id o6so17723595ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KPIcapYMAPLUekCZ8tupcTqg03NA1STBAuLjc0LJSyM=;
        b=Yjk+uCLdN0d5cgLZMOvaLiSrtYcFa+EDMH7fqwAAASv/fp1PNe8jAMXcwuL56//vhQ
         jfHu7zxJMXtnpHWGzlbyHCprAgFNeocsw/Xrh66+VW2Lm/v+3I/XAxXjxakJCP4Wz2uA
         hwbFAJAJm3RRN2h9aiAAwCLfb64KuznAy2AQJ+evtw9qpjeYwQ6cWIN6M4iEiJN81idz
         Q4VHSCCj1wBl6BlkJVvsNHeNly+6mKv1X82qe97uhwtHCawKoTYiM+hxT2Jt4wnEWleN
         NWhJWTntY5mD2jYeNmkoLcQgYilw0aW/H7h23tX3XcU0tPGkllMjK8eUp4bItEIFzKiz
         FhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPIcapYMAPLUekCZ8tupcTqg03NA1STBAuLjc0LJSyM=;
        b=g5yhCUwJsZ821uFlgtCn98CsC8+1txH7pZji5PRSyZAkeyx1rel/yuj9wsAouailZV
         NZ9k/KHsPh7ql8IAFAayx9FRbIgGr/v6GQ5DLcfUr3M+Tvla0oANWhnCu/p2vr4HpiNA
         t4gZHLcuFb3uoKZgS/Dpm2BduwOcxhL6XDGVnfYwmaybywKnk/EAfXEoKcKfKa/sajJa
         E8FeOVnNag5gbhvvO35Bzh7Gp4JFKlJQ/cgQruSEodCTW4V8gcZxRfIyxWa0s05zr7XH
         nWovYH4EVfwxvJw1EIx34+tmYC7AQ78FRFbAs9EFBZeQeP5yqg8ndAwwmZM9zt+r3dtR
         Y62Q==
X-Gm-Message-State: AOAM531Nrma0PZs54W+h2xzKql4zjSWGAQxtlAKY3KJevLUQJnzqG+bB
        Y0EPHJbCScoqVDFSWG7b7n9v1utyKSw=
X-Google-Smtp-Source: ABdhPJzw3BFUm+PtXKHvrKgM6McVl8+kl/0lzmSYPLaE3k3tApKRavKaY3+zz77lcDKHrQN3a/goNg==
X-Received: by 2002:a2e:8256:0:b0:246:3e95:77e8 with SMTP id j22-20020a2e8256000000b002463e9577e8mr14271116ljh.493.1646059642388;
        Mon, 28 Feb 2022 06:47:22 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-165-244.toya.net.pl. [31.183.165.244])
        by smtp.gmail.com with ESMTPSA id r14-20020ac252ae000000b00443f3cbc03asm993996lfm.6.2022.02.28.06.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:47:22 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     rppt@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 4/9] memblock tests: Add memblock_alloc tests for bottom up
Date:   Mon, 28 Feb 2022 15:46:46 +0100
Message-Id: <426674eee20d99dca49caf1ee0142a83dccbc98d.1646055639.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1646055639.git.karolinadrobnik@gmail.com>
References: <cover.1646055639.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add checks for memblock_alloc for bottom up allocation direction.
The tested scenarios are:
  - Region can be allocated on the first fit (with and without
    region merging)
  - Region can be allocated on the second fit (with and without
    region merging)

Add test case wrappers to test both directions in the same context.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/testing/memblock/tests/alloc_api.c | 322 ++++++++++++++++++++++-
 1 file changed, 318 insertions(+), 4 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
index 22ba9a2b4eaf..5d8acf4255d7 100644
--- a/tools/testing/memblock/tests/alloc_api.c
+++ b/tools/testing/memblock/tests/alloc_api.c
@@ -405,23 +405,337 @@ static int alloc_no_memory_generic_check(void)
 	return 0;
 }
 
-int memblock_alloc_checks(void)
+/*
+ * A simple test that tries to allocate a small memory region.
+ * Expect to allocate an aligned region at the beginning of the available
+ * memory.
+ */
+static int alloc_bottom_up_simple_check(void)
 {
-	reset_memblock_attributes();
-	dummy_physical_memory_init();
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+
+	setup_memblock();
+
+	allocated_ptr = memblock_alloc(SZ_2, SMP_CACHE_BYTES);
+
+	assert(allocated_ptr);
+	assert(rgn->size == SZ_2);
+	assert(rgn->base == memblock_start_of_DRAM());
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == SZ_2);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory next to a reserved region that starts at
+ * the misaligned address. Expect to create two separate entries, with the new
+ * entry aligned to the provided alignment:
+ *
+ *                      +
+ *  |    +----------+   +----------+     |
+ *  |    |   rgn1   |   |   rgn2   |     |
+ *  +----+----------+---+----------+-----+
+ *                      ^
+ *                      |
+ *                      Aligned address boundary
+ *
+ * The allocation direction is bottom-up, so the new region will be the second
+ * entry in memory.reserved array. The previously reserved region does not get
+ * modified. Region counter and total size get updated.
+ */
+static int alloc_bottom_up_disjoint_check(void)
+{
+	struct memblock_region *rgn1 = &memblock.reserved.regions[0];
+	struct memblock_region *rgn2 = &memblock.reserved.regions[1];
+	struct region r1;
+	void *allocated_ptr = NULL;
+
+	phys_addr_t r2_size = SZ_16;
+	/* Use custom alignment */
+	phys_addr_t alignment = SMP_CACHE_BYTES * 2;
+	phys_addr_t total_size;
+	phys_addr_t expected_start;
+
+	setup_memblock();
+
+	r1.base = memblock_start_of_DRAM() + SZ_2;
+	r1.size = SZ_2;
+
+	total_size = r1.size + r2_size;
+	expected_start = memblock_start_of_DRAM() + alignment;
+
+	memblock_reserve(r1.base, r1.size);
+
+	allocated_ptr = memblock_alloc(r2_size, alignment);
+
+	assert(allocated_ptr);
+
+	assert(rgn1->size == r1.size);
+	assert(rgn1->base == r1.base);
+
+	assert(rgn2->size == r2_size);
+	assert(rgn2->base == expected_start);
+
+	assert(memblock.reserved.cnt == 2);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory when there is enough space at
+ * the beginning of the previously reserved block (i.e. first fit):
+ *
+ *  |------------------+--------+         |
+ *  |        r1        |   r2   |         |
+ *  +------------------+--------+---------+
+ *
+ * Expect a merge of both regions. Only the region size gets updated.
+ */
+static int alloc_bottom_up_before_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
 
+	phys_addr_t r1_size = SZ_512;
+	phys_addr_t r2_size = SZ_128;
+	phys_addr_t total_size = r1_size + r2_size;
+
+	setup_memblock();
+
+	memblock_reserve(memblock_start_of_DRAM() + r1_size, r2_size);
+
+	allocated_ptr = memblock_alloc(r1_size, SMP_CACHE_BYTES);
+
+	assert(allocated_ptr);
+	assert(rgn->size == total_size);
+	assert(rgn->base == memblock_start_of_DRAM());
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory when there is not enough space at
+ * the beginning of the previously reserved block (i.e. second fit):
+ *
+ *  |    +--------+--------------+         |
+ *  |    |   r1   |      r2      |         |
+ *  +----+--------+--------------+---------+
+ *
+ * Expect a merge of both regions. Only the region size gets updated.
+ */
+static int alloc_bottom_up_after_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	struct region r1;
+	void *allocated_ptr = NULL;
+
+	phys_addr_t r2_size = SZ_512;
+	phys_addr_t total_size;
+
+	setup_memblock();
+
+	/* The first region starts at the aligned address to test region merging */
+	r1.base = memblock_start_of_DRAM() + SMP_CACHE_BYTES;
+	r1.size = SZ_64;
+
+	total_size = r1.size + r2_size;
+
+	memblock_reserve(r1.base, r1.size);
+
+	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
+
+	assert(allocated_ptr);
+	assert(rgn->size == total_size);
+	assert(rgn->base == r1.base);
+
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory when there are two reserved regions, the
+ * first one starting at the beginning of the available memory, with a gap too
+ * small to fit the new region:
+ *
+ *  |------------+     +--------+--------+  |
+ *  |     r1     |     |   r2   |   r3   |  |
+ *  +------------+-----+--------+--------+--+
+ *
+ * Expect to allocate after the second region, which starts at the higher
+ * address, and merge them into one. The region counter and total size fields
+ * get updated.
+ */
+static int alloc_bottom_up_second_fit_check(void)
+{
+	struct memblock_region *rgn  = &memblock.reserved.regions[1];
+	struct region r1, r2;
+	void *allocated_ptr = NULL;
+
+	phys_addr_t r3_size = SZ_1K;
+	phys_addr_t total_size;
+
+	setup_memblock();
+
+	r1.base = memblock_start_of_DRAM();
+	r1.size = SZ_512;
+
+	r2.base = r1.base + r1.size + SZ_512;
+	r2.size = SZ_256;
+
+	total_size = r1.size + r2.size + r3_size;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
+
+	assert(allocated_ptr);
+	assert(rgn->size == r2.size + r3_size);
+	assert(rgn->base == r2.base);
+
+	assert(memblock.reserved.cnt == 2);
+	assert(memblock.reserved.total_size == total_size);
+
+	return 0;
+}
+
+/* Test case wrappers */
+static int alloc_simple_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_top_down_simple_check();
+	memblock_set_bottom_up(true);
+	alloc_bottom_up_simple_check();
+
+	return 0;
+}
+
+static int alloc_disjoint_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_top_down_disjoint_check();
+	memblock_set_bottom_up(true);
+	alloc_bottom_up_disjoint_check();
+
+	return 0;
+}
+
+static int alloc_before_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_top_down_before_check();
+	memblock_set_bottom_up(true);
+	alloc_bottom_up_before_check();
+
+	return 0;
+}
+
+static int alloc_after_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_top_down_after_check();
-	alloc_top_down_second_fit_check();
+	memblock_set_bottom_up(true);
+	alloc_bottom_up_after_check();
+
+	return 0;
+}
+
+static int alloc_in_between_check(void)
+{
+	memblock_set_bottom_up(false);
+	alloc_in_between_generic_check();
+	memblock_set_bottom_up(true);
 	alloc_in_between_generic_check();
+
+	return 0;
+}
+
+static int alloc_second_fit_check(void)
+{
+	memblock_set_bottom_up(false);
+	alloc_top_down_second_fit_check();
+	memblock_set_bottom_up(true);
+	alloc_bottom_up_second_fit_check();
+
+	return 0;
+}
+
+static int alloc_small_gaps_check(void)
+{
+	memblock_set_bottom_up(false);
+	alloc_small_gaps_generic_check();
+	memblock_set_bottom_up(true);
 	alloc_small_gaps_generic_check();
+
+	return 0;
+}
+
+static int alloc_all_reserved_check(void)
+{
+	memblock_set_bottom_up(false);
+	alloc_all_reserved_generic_check();
+	memblock_set_bottom_up(true);
 	alloc_all_reserved_generic_check();
+
+	return 0;
+}
+
+static int alloc_no_space_check(void)
+{
+	memblock_set_bottom_up(false);
+	alloc_no_space_generic_check();
+	memblock_set_bottom_up(true);
 	alloc_no_space_generic_check();
+
+	return 0;
+}
+
+static int alloc_limited_space_check(void)
+{
+	memblock_set_bottom_up(false);
 	alloc_limited_space_generic_check();
+	memblock_set_bottom_up(true);
+	alloc_limited_space_generic_check();
+
+	return 0;
+}
+
+static int alloc_no_memory_check(void)
+{
+	memblock_set_bottom_up(false);
+	alloc_no_memory_generic_check();
+	memblock_set_bottom_up(true);
 	alloc_no_memory_generic_check();
 
+	return 0;
+}
+
+int memblock_alloc_checks(void)
+{
+	reset_memblock_attributes();
+	dummy_physical_memory_init();
+
+	alloc_simple_check();
+	alloc_disjoint_check();
+	alloc_before_check();
+	alloc_after_check();
+	alloc_second_fit_check();
+	alloc_small_gaps_check();
+	alloc_in_between_check();
+	alloc_all_reserved_check();
+	alloc_no_space_check();
+	alloc_limited_space_check();
+	alloc_no_memory_check();
+
 	dummy_physical_memory_cleanup();
 
 	return 0;
-- 
2.30.2

