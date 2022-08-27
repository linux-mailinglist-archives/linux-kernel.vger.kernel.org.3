Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0585A34E2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiH0FnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH0FnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:43:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366A98FD77
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q63so3174276pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=kJnjSM5uWw/+OasymE1XdtncV4A8NK3Tz+3gG/EYX3w=;
        b=M72DVYCcc5djJMXn7hxsxjmJDCoIK9NOh1rNH/KStqc1P3GvkBCJQgTCF50cE1Sj6c
         r3iSuL639VjHTRsYuRtUr9rxXkg5UyeDk/6vwgoSMS48R9QpsCLPst3MUwMwYbsNIiyF
         fcp3hYgy8elV8apVPMa+kpHl5f8OUcMJ4pccq9zX+G/QFkEEM33r93hRcf2QglFMA35B
         f/dqdmhgHhppS6BNtKle5FJnPaT8FuKP/1L3CtERCyt5kQVtfMfGzcHDixGe4qLB9mke
         ESBYY8BoQtWj1TIqlySmmhEXZ2WsrtK7LZMzuae99HXAWoMXojJ+8AMvUfeJ37VO8sck
         pvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kJnjSM5uWw/+OasymE1XdtncV4A8NK3Tz+3gG/EYX3w=;
        b=Dx6rULNuVNQTudHA7xJqw8ss/HFBz7bZ194D2XZpbvpNYAgn8znWizIMKpp95uCNuC
         gdk5rfjc9fdSk9UYt8xbJPIZ8WeJUfHkm9vcycERX++W4Ig+5BvfeRrNgtXBqZte1873
         xKasfgADAeQzYRU3rvmXRIaHQHKr9+Zq5mqi0oUSF1bM5aOz7AUGNi9uMvqXp8Xm80kJ
         Eyojgd+x8IHB55aF9fpP6jX1A+uCtdvNO0eNfhVGkrj/cK6tvgxjKhwxRo21ImEPci0m
         RBHzpS1TKeN6N+10lU12XmBxEGYeic659hY2wfqbrdiEmEWyJfiBzgW75w2st+19gi37
         pXBw==
X-Gm-Message-State: ACgBeo0Ly3skC7G384q1+Np3apdxDVrcq/HxEZdsK3a7pHzF6GLEJoa/
        lGlJwgxoVO57TXOBAEAIFI8=
X-Google-Smtp-Source: AA6agR6GB9Kx0LkE3cpSmIAtqXp1TqnPLrdyn6WpFtisGXOQXMbxfU7VeQ+bHhg/LKYgr9wNhwJPqQ==
X-Received: by 2002:a65:6a83:0:b0:42b:344a:3546 with SMTP id q3-20020a656a83000000b0042b344a3546mr6033091pgu.612.1661578988596;
        Fri, 26 Aug 2022 22:43:08 -0700 (PDT)
Received: from sophie ([89.46.114.37])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090a3b0800b001fb0a363c18sm2586726pjc.52.2022.08.26.22.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 22:43:08 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>
Subject: [PATCH v3 2/8] memblock tests: update zeroed memory check for memblock_alloc_* tests
Date:   Sat, 27 Aug 2022 00:42:44 -0500
Message-Id: <24b3271751756100142e65b75284d43b4d30c9b7.1661578349.git.remckee0@gmail.com>
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
index 1069b4bdd5fd..f1c7d6f170b6 100644
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - SMP_CACHE_BYTES);
diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 255fd514e9f5..a069534c459e 100644
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, r2_size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, r2_size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, r3_size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, size);
 
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
+	ASSERT_MEM_EQ(allocated_ptr, 0, size);
 
 	ASSERT_EQ(rgn->size, size);
 	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
-- 
2.25.1

