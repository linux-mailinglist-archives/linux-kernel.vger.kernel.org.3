Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573B4591E8A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbiHNFyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiHNFyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:54:12 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE1354CBB
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:11 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id d4so2483441ilc.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZU3J1Tgpo6J2fZewTeU+O/Q6QDBwUbPH94LC1fh/cTI=;
        b=ZTQK81BjL0rTYjPjzhlMNhZqjGEeUb/a8pHwNO4L9XxiVuRU1lt3eEoRpM4E+YIu6J
         ol7NKSrjSOR3lPufYupFHo0DXwBf1PR6Rr7SyWQN0000u7Zc/d0anaF0Rbmw2099Fqr8
         TDPSGGh1AaAPQd0+n0LGTNGAm+HiZ4OD19pz/RQC7QISFniHwzhtojIRNYv5vID4kfJG
         VP2VPKdB9fFFwnJBt8uWamu+YfB/F6e0Jl8kOC+/5/fJcYxm8TbEuKnrzjCGpXaBmlDf
         KXuGxzgTlDJ3lCqh2dkMJ9Hm0yAHejlzgPuKQtp0TCvUEyyA7FmwqTo6ieT6aFDXzfxL
         jUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZU3J1Tgpo6J2fZewTeU+O/Q6QDBwUbPH94LC1fh/cTI=;
        b=4eOgWyY0kalizjYcS7AKxdQtfTQDJ3A+jjGY9PHhyHJQlRk6+aEadUPPclAF7TDPuG
         +IPR0jEc6l2MHTBvfuU7800NaZW8BFSet+qVeaPWiS9ckvaqMQY7BmB+C2NgguJ3d57e
         Ge4hh4YOv0An7K3I1spBqWKc0s/lRfCMEfIk7S2ROaktuqPsiuNP/j+RYZqtwRy0z7+0
         4HhiEttturm+rqSeyCfNMuhDVYxQDv2IZgikAXrgGx/NiCmOkdKnuIfPjFaROuG5tz4n
         8m4L5LJJTF0wspM9SwSEu/C9j4ks/9BIuc+JlECHS0KN+FplOMhEmp7KB1KrgBjHErmX
         BOaA==
X-Gm-Message-State: ACgBeo1m+BauRsvBhlInVDinmkR7acDX5rYh9dafnioXzndQ26Ts4dKe
        1LJoQpekVQvFiLI5Ndkb6U4=
X-Google-Smtp-Source: AA6agR5WfFQmTHge9k1tDwb/jo2aPSqw4CIIzup15qIOPU0NPYDnVjv7sL7bpKLE+1V6QYJVfgxFhg==
X-Received: by 2002:a92:c246:0:b0:2de:b25b:e75 with SMTP id k6-20020a92c246000000b002deb25b0e75mr4859094ilo.246.1660456450696;
        Sat, 13 Aug 2022 22:54:10 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id c2-20020a023302000000b003435a9369a3sm1803266jae.8.2022.08.13.22.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 22:54:10 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 2/8] memblock tests: update zeroed memory check for memblock_alloc_* tests
Date:   Sun, 14 Aug 2022 00:53:54 -0500
Message-Id: <02cad26bef7bc8c7271bba20deac0e5f0bf081c2.1660454730.git.remckee0@gmail.com>
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

Update the assert in memblock_alloc_try_nid() and memblock_alloc_from()
tests that checks whether the memory is cleared so that it checks the
entire chunk of allocated memory instead of just the first byte.

Reviewed-by: David Hildenbrand <david@redhat.com>
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

