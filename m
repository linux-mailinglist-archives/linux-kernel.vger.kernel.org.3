Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44895A34E6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345226AbiH0Fnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiH0Fnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:43:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AA39C2E0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o4so3367171pjp.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FB1yU1Z7Q4zBJLFmC1/OcLF4CfKBEUASoZDQ9O3qvjc=;
        b=RgXFVAf76xlXQhk+QzPGcbaBbA3Be3v12S+2lA5E+8UkjlLgAZIeVJhHhn0anahxa4
         I/HKN/DttSywX8LVVCDCljLKcnHlDvxW5guy3EMujW91iDVlvJZ8g3oLRDrqYIJ7oPQt
         p+8bG+hLuHHTEL17YEROQfal5ToyMdkirWpafue47/BZEc7PKIfBp4R/0qTI8W7zODEC
         unJGW2+GjgPGFVwqoxlGUNcsn1p+tTnAYUFgc8pUs1T8p4BVp5gL/7fjt30gGfbxHn7o
         x5zrobJ6KzeZEQKDAUJsHMHNF1FbgdlE4AqkKBZ1P2TSWjHG/4ipyhhDzP8Z4nIIXNt+
         s7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FB1yU1Z7Q4zBJLFmC1/OcLF4CfKBEUASoZDQ9O3qvjc=;
        b=N++tAcxeYwXWeZqqiW5RRXPChIBJBJj6iVp4kgjqy9gB27tFbWngy8/TgQzUVhRs7I
         gAOpGJCSbeVwhO9yHkQ90IfMV+mBnP4QpLGCjH85/AbDX2F/ZKA1yLUVzhvUeDXvWgnh
         mFsNEhAcrNXC7tHrWY4DDrhpCy1Zr3KXaCWzldOFtsQX7Xgq7e+lnZo9iQrFLgYauzEA
         72bEYs1pQfWE/ZO34rLECJc8ByfYt30sskmD69QXBpy16nFlTJ5XJ3WU8c4ADSkPXJaz
         /yu3JCtdcBfJ/2VEB2CnRxXGXyE0OXrnV/Qz8XsOo6JiyB15QDvcnvX6U+9XEI6Ny0P0
         bIyw==
X-Gm-Message-State: ACgBeo22K1gtSmdkZRpoi7LDIteoK6IrpaFQ4LXrmmeMzEkB0kIVNSuB
        IVRA71YZIWC3JMB9soq/WTY=
X-Google-Smtp-Source: AA6agR7yGDFsDttabS+S2RZ6caQvrgqaT2ZUAd95ARaK8SYxcp1qaeZzg79efyJN60lGWbZmgh8wZA==
X-Received: by 2002:a17:90a:c095:b0:1fd:5bee:8a17 with SMTP id o21-20020a17090ac09500b001fd5bee8a17mr7591393pjs.147.1661579001789;
        Fri, 26 Aug 2022 22:43:21 -0700 (PDT)
Received: from sophie ([89.46.114.37])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b0016909be39e5sm2629446plh.177.2022.08.26.22.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 22:43:21 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 6/8] memblock tests: update alloc_nid_api to test memblock_alloc_try_nid_raw
Date:   Sat, 27 Aug 2022 00:42:48 -0500
Message-Id: <6fa8938f67872841c10a00afb042947d1d280a04.1661578349.git.remckee0@gmail.com>
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

Update memblock_alloc_try_nid() tests so that they test either
memblock_alloc_try_nid() or memblock_alloc_try_nid_raw() depending on the
value of alloc_nid_test_flags. Run through all the existing tests in
alloc_nid_api twice: once for memblock_alloc_try_nid() and once for
memblock_alloc_try_nid_raw().

When the tests run memblock_alloc_try_nid(), they test that the entire
memory region is zero. When the tests run memblock_alloc_try_nid_raw(),
they test that the entire memory region is nonzero. The content of the
memory region is initialized to nonzero, and we expect it to remain
unchanged if running memblock_alloc_try_nid_raw().

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_nid_api.c | 180 ++++++++++++-------
 1 file changed, 111 insertions(+), 69 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 9324d706ee3a..32b3c1594fdd 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -1,6 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include "alloc_nid_api.h"
 
+static int alloc_nid_test_flags = TEST_F_NONE;
+
+static inline const char * const get_memblock_alloc_try_nid_name(int flags)
+{
+	if (flags & TEST_F_RAW)
+		return "memblock_alloc_try_nid_raw";
+	return "memblock_alloc_try_nid";
+}
+
+static inline void *run_memblock_alloc_try_nid(phys_addr_t size,
+					       phys_addr_t align,
+					       phys_addr_t min_addr,
+					       phys_addr_t max_addr, int nid)
+{
+	if (alloc_nid_test_flags & TEST_F_RAW)
+		return memblock_alloc_try_nid_raw(size, align, min_addr,
+						  max_addr, nid);
+	return memblock_alloc_try_nid(size, align, min_addr, max_addr, nid);
+}
+
 /*
  * A simple test that tries to allocate a memory region within min_addr and
  * max_addr range:
@@ -32,12 +52,13 @@ static int alloc_try_nid_top_down_simple_check(void)
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
 	max_addr = min_addr + SZ_512;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, size);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, max_addr - size);
@@ -86,12 +107,13 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
 	max_addr = min_addr + SZ_512 + misalign;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, size);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, max_addr - size - misalign);
@@ -137,12 +159,13 @@ static int alloc_try_nid_exact_address_generic_check(void)
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES;
 	max_addr = min_addr + size;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, size);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -189,11 +212,12 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
 	min_addr = memblock_start_of_DRAM() + SZ_512;
 	max_addr = min_addr + SMP_CACHE_BYTES;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, size);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, max_addr - size);
@@ -241,8 +265,9 @@ static int alloc_try_nid_low_max_generic_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = min_addr + SMP_CACHE_BYTES;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -287,11 +312,12 @@ static int alloc_try_nid_min_reserved_generic_check(void)
 
 	memblock_reserve(reserved_base, r1_size);
 
-	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r2_size);
+	assert_mem_content(allocated_ptr, r2_size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, reserved_base);
@@ -338,11 +364,12 @@ static int alloc_try_nid_max_reserved_generic_check(void)
 
 	memblock_reserve(max_addr, r1_size);
 
-	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r2_size);
+	assert_mem_content(allocated_ptr, r2_size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -402,11 +429,12 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
+	assert_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn1->size, r1.size + r3_size);
 	ASSERT_EQ(rgn1->base, max_addr - r3_size);
@@ -466,11 +494,12 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
+	assert_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r2.base);
@@ -531,11 +560,12 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
+	assert_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
@@ -597,8 +627,9 @@ static int alloc_try_nid_reserved_all_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -628,11 +659,12 @@ static int alloc_try_nid_top_down_cap_max_check(void)
 	min_addr = memblock_end_of_DRAM() - SZ_1K;
 	max_addr = memblock_end_of_DRAM() + SZ_256;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, size);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
@@ -666,11 +698,12 @@ static int alloc_try_nid_top_down_cap_min_check(void)
 	min_addr = memblock_start_of_DRAM() - SZ_256;
 	max_addr = memblock_end_of_DRAM();
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, size);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
@@ -714,13 +747,13 @@ static int alloc_try_nid_bottom_up_simple_check(void)
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
 	max_addr = min_addr + SZ_512;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr,
-					       NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, size);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -769,13 +802,13 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
 	min_addr = memblock_start_of_DRAM() + misalign;
 	max_addr = min_addr + SZ_512;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr,
-					       NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, size);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr + (SMP_CACHE_BYTES - misalign));
@@ -822,12 +855,12 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
 	min_addr = memblock_start_of_DRAM() + SZ_512;
 	max_addr = min_addr + SMP_CACHE_BYTES;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr,
-					       NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, size);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -887,12 +920,12 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr,
-					       NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
+	assert_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, max_addr);
@@ -959,12 +992,12 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr,
-					       NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
+	assert_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn3->size, r3_size);
 	ASSERT_EQ(rgn3->base, memblock_start_of_DRAM());
@@ -1004,12 +1037,12 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
 	min_addr = memblock_start_of_DRAM() + SZ_1K;
 	max_addr = memblock_end_of_DRAM() + SZ_256;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr,
-					       NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, size);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -1043,12 +1076,12 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = memblock_end_of_DRAM() - SZ_256;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr,
-					       NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ(allocated_ptr, 0, size);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -1193,13 +1226,14 @@ static int alloc_try_nid_low_max_check(void)
 	return 0;
 }
 
-int memblock_alloc_nid_checks(void)
+static int memblock_alloc_nid_checks_internal(int flags)
 {
-	const char *func_testing = "memblock_alloc_try_nid";
+	const char *func = get_memblock_alloc_try_nid_name(flags);
 
+	alloc_nid_test_flags = flags;
 	prefix_reset();
-	prefix_push(func_testing);
-	test_print("Running %s tests...\n", func_testing);
+	prefix_push(func);
+	test_print("Running %s tests...\n", func);
 
 	reset_memblock_attributes();
 	dummy_physical_memory_init();
@@ -1225,3 +1259,11 @@ int memblock_alloc_nid_checks(void)
 
 	return 0;
 }
+
+int memblock_alloc_nid_checks(void)
+{
+	memblock_alloc_nid_checks_internal(TEST_F_NONE);
+	memblock_alloc_nid_checks_internal(TEST_F_RAW);
+
+	return 0;
+}
-- 
2.25.1

