Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0DD59982D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347868AbiHSIup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347848AbiHSIul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:50:41 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DACCCE2C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:50:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g21so2854566qka.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xSx7RYl5xzn5Nqy9fpVkhUaz0743H4TI5Je5gt/WTOg=;
        b=oRYB7iIvryx/XYDVDgT+hgAGJpIa+BEu6aoJSkSbD+z+M9lQXVnBmGZlC2vJw5zppI
         xAoLWsu9K2WfSCNOGACcHx27NbbCxp7YoVqTgBJ0ya2Ll8XVR2EIz7P+bnwK+Csqsc2K
         LpqbUCIiXPTJJFEKWnPQk+a88RXMP2yvWDt/Luzl9K893ttc1IPvomk2YdbL91khrMBU
         iPfwK1aVVULEnAdQBCashvho4ssZuHdDP9BXkc/u6tWuiHAWHmE396GO7uQC9u+pjuYu
         blhinv7UOdPzTJl+Vv/YotvmJjmvUYK36/6XHXStbMXoX0kzj0GtakntmxqzteJiNIQw
         EoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xSx7RYl5xzn5Nqy9fpVkhUaz0743H4TI5Je5gt/WTOg=;
        b=xhnLHNxDoQTEbKxRXxpABIomm/rjt8SMMM/cwgyFTX/ZahSScsW5XXoVPProYjOZf9
         YdL0zelWFX10vL7SNxv6AjDFywWaD97Aw8kh6wWebQT8mQt2t1GRNeQ0OXNv4WwfZl6H
         WwZt9PcxcHTtl8DwA1lMKjNOx//x+7g6nDLYqYkBHl4vnxICOz+K7l2BPlS2VJRGTDPz
         nMVWHl7MHn98g4XTC6NW80UVZUrnGqKu40bXhkSpKmJJR60kng23inIMshTkD7/4PXqu
         09RluTHa5GBy69JOnVUBceF6uSMpS+3lJqgWrIhwrb08AqymYJa6MwP19OT8mkrbVyAF
         G2jQ==
X-Gm-Message-State: ACgBeo16pGMguqGe7ZQ8TamCUtaSpDLyLC4ovSQskPr5a1P2ZhKSG2Sa
        Nej4v37cgTlV5o0Ls4tIj+w=
X-Google-Smtp-Source: AA6agR4VqPXl/ZiUHWT6AQz1NJP+/Ke6LW9rQJhBfMUV8k8iiUUkNijHITDUlW5Dguz3bt6e5QVyyg==
X-Received: by 2002:a05:620a:3198:b0:6bb:78dc:f10c with SMTP id bi24-20020a05620a319800b006bb78dcf10cmr4695987qkb.433.1660899038963;
        Fri, 19 Aug 2022 01:50:38 -0700 (PDT)
Received: from sophie ([89.46.62.64])
        by smtp.gmail.com with ESMTPSA id b17-20020ac84f11000000b0031e9ab4e4cesm2553325qte.26.2022.08.19.01.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:50:38 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 6/8] memblock tests: update alloc_nid_api to test memblock_alloc_try_nid_raw
Date:   Fri, 19 Aug 2022 01:34:54 -0700
Message-Id: <c8d86890f5b7168a162c9aee867e338b76e1cf0b.1660897732.git.remckee0@gmail.com>
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

Update memblock_alloc_try_nid() tests so that they test either
memblock_alloc_try_nid() or memblock_alloc_try_nid_raw() depending on the
value of alloc_nid_test_flags. Run through all the existing tests in
alloc_nid_api twice: once for memblock_alloc_try_nid() and once for
memblock_alloc_try_nid_raw().

When the tests run memblock_alloc_try_nid(), they test that the entire
memory region is zero. When the tests run memblock_alloc_try_nid_raw(),
they test that the entire memory region is nonzero.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_nid_api.c | 188 ++++++++++++-------
 1 file changed, 119 insertions(+), 69 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 82fa8ea36320..2c1d5035e057 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -1,6 +1,34 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include "alloc_nid_api.h"
 
+static const char * const func_testing[] = {
+	"memblock_alloc_try_nid",
+	"memblock_alloc_try_nid_raw"
+};
+
+static int alloc_nid_test_flags = TEST_ZEROED;
+
+static inline const char * const get_func_testing(int flags)
+{
+	if (flags & TEST_RAW)
+		return func_testing[1];
+	else
+		return func_testing[0];
+}
+
+static inline void *run_memblock_alloc_try_nid(phys_addr_t size,
+					       phys_addr_t align,
+					       phys_addr_t min_addr,
+					       phys_addr_t max_addr, int nid)
+{
+	if (alloc_nid_test_flags & TEST_RAW)
+		return memblock_alloc_try_nid_raw(size, align, min_addr,
+						  max_addr, nid);
+	else
+		return memblock_alloc_try_nid(size, align, min_addr,
+					      max_addr, nid);
+}
+
 /*
  * A simple test that tries to allocate a memory region within min_addr and
  * max_addr range:
@@ -32,12 +60,13 @@ static int alloc_try_nid_top_down_simple_check(void)
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
 	max_addr = min_addr + SZ_512;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, max_addr - size);
@@ -86,12 +115,13 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
 	max_addr = min_addr + SZ_512 + misalign;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, max_addr - size - misalign);
@@ -137,12 +167,13 @@ static int alloc_try_nid_exact_address_generic_check(void)
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES;
 	max_addr = min_addr + size;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -189,11 +220,12 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
 	min_addr = memblock_start_of_DRAM() + SZ_512;
 	max_addr = min_addr + SMP_CACHE_BYTES;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, max_addr - size);
@@ -241,8 +273,9 @@ static int alloc_try_nid_low_max_generic_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = min_addr + SMP_CACHE_BYTES;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -287,11 +320,12 @@ static int alloc_try_nid_min_reserved_generic_check(void)
 
 	memblock_reserve(reserved_base, r1_size);
 
-	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+	verify_mem_content(allocated_ptr, r2_size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, reserved_base);
@@ -338,11 +372,12 @@ static int alloc_try_nid_max_reserved_generic_check(void)
 
 	memblock_reserve(max_addr, r1_size);
 
-	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+	verify_mem_content(allocated_ptr, r2_size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -402,11 +437,12 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+	verify_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn1->size, r1.size + r3_size);
 	ASSERT_EQ(rgn1->base, max_addr - r3_size);
@@ -466,11 +502,12 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+	verify_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r2.base);
@@ -531,11 +568,12 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+	verify_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
@@ -597,8 +635,9 @@ static int alloc_try_nid_reserved_all_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -628,11 +667,12 @@ static int alloc_try_nid_top_down_cap_max_check(void)
 	min_addr = memblock_end_of_DRAM() - SZ_1K;
 	max_addr = memblock_end_of_DRAM() + SZ_256;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
@@ -666,11 +706,12 @@ static int alloc_try_nid_top_down_cap_min_check(void)
 	min_addr = memblock_start_of_DRAM() - SZ_256;
 	max_addr = memblock_end_of_DRAM();
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
@@ -714,13 +755,13 @@ static int alloc_try_nid_bottom_up_simple_check(void)
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
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -769,13 +810,13 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
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
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr + (SMP_CACHE_BYTES - misalign));
@@ -822,12 +863,12 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
 	min_addr = memblock_start_of_DRAM() + SZ_512;
 	max_addr = min_addr + SMP_CACHE_BYTES;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr,
-					       NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -887,12 +928,12 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr,
-					       NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+	verify_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, max_addr);
@@ -959,12 +1000,12 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr,
-					       NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+	verify_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn3->size, r3_size);
 	ASSERT_EQ(rgn3->base, memblock_start_of_DRAM());
@@ -1004,12 +1045,12 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
 	min_addr = memblock_start_of_DRAM() + SZ_1K;
 	max_addr = memblock_end_of_DRAM() + SZ_256;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr,
-					       NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -1043,12 +1084,12 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = memblock_end_of_DRAM() - SZ_256;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr,
-					       NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -1193,13 +1234,14 @@ static int alloc_try_nid_low_max_check(void)
 	return 0;
 }
 
-int memblock_alloc_nid_checks(void)
+static int memblock_alloc_nid_checks_internal(int flags)
 {
-	const char *func_testing = "memblock_alloc_try_nid";
+	const char *func = get_func_testing(flags);
 
+	alloc_nid_test_flags = flags;
 	prefix_reset();
-	prefix_push(func_testing);
-	test_print("Running %s tests...\n", func_testing);
+	prefix_push(func);
+	test_print("Running %s tests...\n", func);
 
 	reset_memblock_attributes();
 	dummy_physical_memory_init();
@@ -1225,3 +1267,11 @@ int memblock_alloc_nid_checks(void)
 
 	return 0;
 }
+
+int memblock_alloc_nid_checks(void)
+{
+	memblock_alloc_nid_checks_internal(TEST_ZEROED);
+	memblock_alloc_nid_checks_internal(TEST_RAW);
+
+	return 0;
+}
-- 
2.25.1

