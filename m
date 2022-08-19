Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7405997A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347280AbiHSImG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347270AbiHSIlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:41:53 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCED67452
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:41:49 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j17so2846119qtp.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PFs/qXz1irqoPW1RQONVSX/UZnoITe4BseRhR7exQIk=;
        b=nrxsZSFJATbxAFW+4G1nowH9Rxxfz5mTEm7/OLNuUQgdzB0FZqg/pgYxtzjg+3aQ1e
         f4LHPv0Jwbz1oaLLpIoIRUylpZodleb3ezEYJAndn55y/+U7gq1f0ibflvHX65c+d9Km
         r5vFgb4qvVAOC0IwKKnT5+XCgV30r8w3XeVc8SnlK+tZ+DsvOfcde/v+n9EH/e4TBHYy
         GciDGrcuINhxQSuRAh6IMGbQv5NW9NOVcivkEVAq+dK7OuLMwWFSOM6f8MykZtxG3krv
         T+Ich+K5cJkRLvsouVAbAsNlaCbKvgbcFkWC+z/c7tcC5pHjDDdBIcHc+LXAGa1jLWrt
         W4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PFs/qXz1irqoPW1RQONVSX/UZnoITe4BseRhR7exQIk=;
        b=ZP/apT1f/0j5hNZktdH1YejBih0+fdFHF9fvdtF9IQOgCRRbzZUZlj6LWg3XoVg91E
         A64pehGOEJmV8t54Auidr+vRDOKM1/RhMh0hCsdxfkbXRczRwqVuVLKJhmKH78UbRV6w
         OFe3pABhWhlcwY5Yi+rf9UvPz/rsYMJUK67E/y6gLe7AbyNl6EbOmvmzXDTB/2O1yCKk
         iHRvwXgqHAxdVZ0FWWyeTUUWKD2Ix0eGWXYnCDdFxxxKdsbhaKmnnwAaCsAMpFVHGcFj
         yAkRS1k9iYIGkN/TnjgzXa1nFYU35XgULZ2n49p/5qNmVK83eLeWyZx/I7XAt9VW93l0
         SB7A==
X-Gm-Message-State: ACgBeo0Ap+SNk2VlgIh9PoHZkRajzrXo7hPEAuYkmF6A+JNL7Qo2CixS
        gE+de/1GlRNHbr6HqTuhOYo=
X-Google-Smtp-Source: AA6agR5PPFo3Cz0k33UftdyYjQici7vLNI5MGZG1EJL7K9NXyiKQZPDMgfVlHXyOzi+jIF8ZvcabBg==
X-Received: by 2002:ac8:5f94:0:b0:344:55da:cee1 with SMTP id j20-20020ac85f94000000b0034455dacee1mr5590857qta.40.1660898508526;
        Fri, 19 Aug 2022 01:41:48 -0700 (PDT)
Received: from sophie ([89.46.62.64])
        by smtp.gmail.com with ESMTPSA id v9-20020a05622a014900b00342f8d4d0basm2868087qtw.43.2022.08.19.01.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:41:48 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>
Subject: [PATCH v2 2/8] memblock tests: update zeroed memory check for memblock_alloc_* tests
Date:   Fri, 19 Aug 2022 01:34:50 -0700
Message-Id: <d9386b49f0b8fe589829c518a6c43d845af2e27a.1660897732.git.remckee0@gmail.com>
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

Update the assert in memblock_alloc_try_nid() and memblock_alloc_from()
tests that checks whether the memory is cleared so that it checks the
entire chunk of allocated memory instead of just the first byte.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Shaoqin Huang <shaoqin.huang@intel.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 .../memblock/tests/alloc_helpers_api.c        |  8 +--
 tools/testing/memblock/tests/alloc_nid_api.c  | 72 +++++--------------
 2 files changed, 20 insertions(+), 60 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
index 1069b4bdd5fd..796527cf3bd2 100644
--- a/tools/testing/memblock/tests/alloc_helpers_api.c
+++ b/tools/testing/memblock/tests/alloc_helpers_api.c
@@ -19,7 +19,6 @@ static int alloc_from_simple_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -31,10 +30,9 @@ static int alloc_from_simple_generic_check(void)
 	min_addr = memblock_end_of_DRAM() - SMP_CACHE_BYTES;
 
 	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -66,7 +64,6 @@ static int alloc_from_misaligned_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -79,10 +76,9 @@ static int alloc_from_misaligned_generic_check(void)
 	min_addr = memblock_end_of_DRAM() - (SMP_CACHE_BYTES * 2 - 1);
 
 	allocated_ptr = memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - SMP_CACHE_BYTES);
diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 255fd514e9f5..71b7beb35526 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -19,7 +19,6 @@ static int alloc_try_nid_top_down_simple_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -35,11 +34,10 @@ static int alloc_try_nid_top_down_simple_check(void)
 
 	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, max_addr - size);
@@ -74,7 +72,6 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -91,11 +88,10 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
 
 	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, max_addr - size - misalign);
@@ -128,7 +124,6 @@ static int alloc_try_nid_exact_address_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -144,11 +139,10 @@ static int alloc_try_nid_exact_address_generic_check(void)
 
 	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -183,7 +177,6 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -198,10 +191,9 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
 
 	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, max_addr - size);
@@ -277,7 +269,6 @@ static int alloc_try_nid_min_reserved_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -298,10 +289,9 @@ static int alloc_try_nid_min_reserved_generic_check(void)
 
 	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, reserved_base);
@@ -332,7 +322,6 @@ static int alloc_try_nid_max_reserved_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -351,10 +340,9 @@ static int alloc_try_nid_max_reserved_generic_check(void)
 
 	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -389,7 +377,6 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
 	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
 	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 	struct region r1, r2;
 
 	PREFIX_PUSH();
@@ -417,10 +404,9 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
 
 	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
 
 	ASSERT_EQ(rgn1->size, r1.size + r3_size);
 	ASSERT_EQ(rgn1->base, max_addr - r3_size);
@@ -456,7 +442,6 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 	struct region r1, r2;
 
 	PREFIX_PUSH();
@@ -483,10 +468,9 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
 
 	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
 
 	ASSERT_EQ(rgn->size, total_size);
 	ASSERT_EQ(rgn->base, r2.base);
@@ -522,7 +506,6 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
 	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
 	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 	struct region r1, r2;
 
 	PREFIX_PUSH();
@@ -550,10 +533,9 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
 
 	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, r1.base);
@@ -634,7 +616,6 @@ static int alloc_try_nid_top_down_cap_max_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -649,10 +630,9 @@ static int alloc_try_nid_top_down_cap_max_check(void)
 
 	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
@@ -674,7 +654,6 @@ static int alloc_try_nid_top_down_cap_min_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -689,10 +668,9 @@ static int alloc_try_nid_top_down_cap_min_check(void)
 
 	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
 					       min_addr, max_addr, NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
@@ -723,7 +701,6 @@ static int alloc_try_nid_bottom_up_simple_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -740,11 +717,10 @@ static int alloc_try_nid_bottom_up_simple_check(void)
 	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
 					       min_addr, max_addr,
 					       NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -779,7 +755,6 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -797,11 +772,10 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
 	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
 					       min_addr, max_addr,
 					       NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr + (SMP_CACHE_BYTES - misalign));
@@ -836,7 +810,6 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -852,10 +825,9 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
 	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
 					       min_addr, max_addr,
 					       NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
@@ -890,7 +862,6 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
 	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
 	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 	struct region r1, r2;
 
 	PREFIX_PUSH();
@@ -919,10 +890,9 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
 	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr,
 					       NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
 
 	ASSERT_EQ(rgn1->size, r1.size);
 	ASSERT_EQ(rgn1->base, max_addr);
@@ -964,7 +934,6 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
 	struct memblock_region *rgn2 = &memblock.reserved.regions[1];
 	struct memblock_region *rgn3 = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 	struct region r1, r2;
 
 	PREFIX_PUSH();
@@ -993,10 +962,9 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
 	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr,
 					       NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
 
 	ASSERT_EQ(rgn3->size, r3_size);
 	ASSERT_EQ(rgn3->base, memblock_start_of_DRAM());
@@ -1024,7 +992,6 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -1040,10 +1007,9 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
 	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
 					       min_addr, max_addr,
 					       NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, min_addr);
@@ -1065,7 +1031,6 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
-	char *b;
 
 	PREFIX_PUSH();
 
@@ -1081,10 +1046,9 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
 	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
 					       min_addr, max_addr,
 					       NUMA_NO_NODE);
-	b = (char *)allocated_ptr;
 
 	ASSERT_NE(allocated_ptr, NULL);
-	ASSERT_EQ(*b, 0);
+	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
-- 
2.25.1

