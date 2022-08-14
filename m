Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD9B591E8D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbiHNFye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbiHNFyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:54:21 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6655F99E
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:19 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c5so2490928ilh.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mrwOFT/FVIpeQilRUSDlN1UFE6zYPVjgWmD8J2V/Rvw=;
        b=kzOoUtnt+1ScgJ8esSYWaoJQNS0I+4PV9yigMOUggv6Un7yJZpa2YCTxfyI7pmNJCE
         OchlVt+bRFGASVbrBnqan+ICPglUQP1NW/JQu277PhGvNJDI2PXHFbHhOUR6BTdZhyNw
         Dicfa0soc5mWdHKIfA9Hhs+EGQRefyT94wFa369xpj1MDMIoBNtNf4u8HsOgogPBnLx5
         ppkIXLRVJum8M6IAVYXbkf75ABQzT4m4hrg15N+ORpppsqsrvELpnHhkXa990aij2VbK
         TOTW0HcwOvaVXqa0vPMppMRwUtfPJcPMf0NP+UOk+nOpovLeP2biej/Qzcq5um6ovfXm
         olxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mrwOFT/FVIpeQilRUSDlN1UFE6zYPVjgWmD8J2V/Rvw=;
        b=E/T3Itf1pI3T8mxNJRJDP5fjFNoBTACCyR2doQEKSRgDzt5iFb8cL0hXDqUy6XLUtM
         AEwSorPySZQBJ+xAKDXRJbspn2gT4XBxZtu1NVsijqaBXRx483mDNnMrMYBZPmHWqi6E
         nutRAe3+9AD/MKY3HAlYmSld6ttBKhJCI+4azPfVWCc03iNjFUCfPrD3NvtHNjzmxST4
         JkPYH4UJuAjZdXu/cOXvjEmDM2vNdSxajytcjIVFKJj4omELES0C+EIkl1/hsKPgjmM8
         zUKWWekU1WClCnVu+fMb7tIgJ8Gpb8YsPU2fU+3Ub+cjdVqoqaMt+ZagdqoNp+CcviQT
         uw6Q==
X-Gm-Message-State: ACgBeo11tCmIZAd66Fyv59vGBCK2tNtPCflkjxLN4XqO6gUPl5BVRm2L
        lQXe2jcHVTLnGaHkB76jUQ4=
X-Google-Smtp-Source: AA6agR5YE34UARRXt7XzwTzkmVuH340HkSDCAUvT5f59RLZ+kXqXbh02Efm57RVbCJnfAhEDb7bzZw==
X-Received: by 2002:a05:6e02:1caf:b0:2e0:cec1:9f17 with SMTP id x15-20020a056e021caf00b002e0cec19f17mr4801562ill.5.1660456458500;
        Sat, 13 Aug 2022 22:54:18 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id u7-20020a056e02110700b002dcafb975c6sm2603415ilk.82.2022.08.13.22.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 22:54:18 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 6/8] memblock tests: update alloc_nid_api to test memblock_alloc_try_nid_raw
Date:   Sun, 14 Aug 2022 00:53:58 -0500
Message-Id: <4c9b416480a5070f18c3933a1a03296f32c2091b.1660454730.git.remckee0@gmail.com>
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
 tools/testing/memblock/tests/alloc_nid_api.c | 196 ++++++++++++-------
 1 file changed, 127 insertions(+), 69 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 82fa8ea36320..e16106d8446b 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -1,6 +1,42 @@
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
+static inline void verify_mem_content(void *mem, int size)
+{
+	if (alloc_nid_test_flags & TEST_RAW)
+		ASSERT_MEM_NE((char *)mem, 0, size);
+	else
+		ASSERT_MEM_EQ((char *)mem, 0, size);
+}
+
 /*
  * A simple test that tries to allocate a memory region within min_addr and
  * max_addr range:
@@ -32,12 +68,13 @@ static int alloc_try_nid_top_down_simple_check(void)
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
+	verify_mem_content(allocated_ptr, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, max_addr - size);
@@ -86,12 +123,13 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
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
+	verify_mem_content(allocated_ptr, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, max_addr - size - misalign);
@@ -137,12 +175,13 @@ static int alloc_try_nid_exact_address_generic_check(void)
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
+	verify_mem_content(allocated_ptr, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -189,11 +228,12 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
 	min_addr = memblock_start_of_DRAM() + SZ_512;
 	max_addr = min_addr + SMP_CACHE_BYTES;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, max_addr - size);
@@ -241,8 +281,9 @@ static int alloc_try_nid_low_max_generic_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = min_addr + SMP_CACHE_BYTES;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -287,11 +328,12 @@ static int alloc_try_nid_min_reserved_generic_check(void)
 
 	memblock_reserve(reserved_base, r1_size);
 
-	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+	verify_mem_content(allocated_ptr, r2_size);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, reserved_base);
@@ -338,11 +380,12 @@ static int alloc_try_nid_max_reserved_generic_check(void)
 
 	memblock_reserve(max_addr, r1_size);
 
-	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
+	verify_mem_content(allocated_ptr, r2_size);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -402,11 +445,12 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+	verify_mem_content(allocated_ptr, r3_size);
 
 	ASSERT_EQ(rgn1->size, r1.size + r3_size);
 	ASSERT_EQ(rgn1->base, max_addr - r3_size);
@@ -466,11 +510,12 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+	verify_mem_content(allocated_ptr, r3_size);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r2.base);
@@ -531,11 +576,12 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
+	verify_mem_content(allocated_ptr, r3_size);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
@@ -597,8 +643,9 @@ static int alloc_try_nid_reserved_all_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -628,11 +675,12 @@ static int alloc_try_nid_top_down_cap_max_check(void)
 	min_addr = memblock_end_of_DRAM() - SZ_1K;
 	max_addr = memblock_end_of_DRAM() + SZ_256;
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
@@ -666,11 +714,12 @@ static int alloc_try_nid_top_down_cap_min_check(void)
 	min_addr = memblock_start_of_DRAM() - SZ_256;
 	max_addr = memblock_end_of_DRAM();
 
-	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-					       min_addr, max_addr, NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
+	verify_mem_content(allocated_ptr, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
@@ -714,13 +763,13 @@ static int alloc_try_nid_bottom_up_simple_check(void)
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
+	verify_mem_content(allocated_ptr, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -769,13 +818,13 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
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
+	verify_mem_content(allocated_ptr, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr + (SMP_CACHE_BYTES - misalign));
@@ -822,12 +871,12 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
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
+	verify_mem_content(allocated_ptr, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -887,12 +936,12 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
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
+	verify_mem_content(allocated_ptr, r3_size);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, max_addr);
@@ -959,12 +1008,12 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
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
+	verify_mem_content(allocated_ptr, r3_size);
 
 	ASSERT_EQ(rgn3->size, r3_size);
 	ASSERT_EQ(rgn3->base, memblock_start_of_DRAM());
@@ -1004,12 +1053,12 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
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
+	verify_mem_content(allocated_ptr, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -1043,12 +1092,12 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
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
+	verify_mem_content(allocated_ptr, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -1193,13 +1242,14 @@ static int alloc_try_nid_low_max_check(void)
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
@@ -1225,3 +1275,11 @@ int memblock_alloc_nid_checks(void)
 
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

