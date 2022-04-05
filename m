Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995834F4C86
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578666AbiDEXY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443718AbiDEPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738814FB99
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5268C61910
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18DAC385A4;
        Tue,  5 Apr 2022 13:58:21 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] mm/slab: Allow dynamic kmalloc() minimum alignment
Date:   Tue,  5 Apr 2022 14:57:56 +0100
Message-Id: <20220405135758.774016-9-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405135758.774016-1-catalin.marinas@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_KMALLOC_MINALIGN represents the minimum guaranteed kmalloc()
alignment but an architecture may require a larger run-time alignment.
Do not create kmalloc caches smaller than arch_kmalloc_minalign().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/slab.h |  2 ++
 mm/slab.c            |  6 +-----
 mm/slab.h            |  2 ++
 mm/slab_common.c     | 33 +++++++++++++++++++++++----------
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index d58211bdeceb..2137dba85691 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -332,6 +332,8 @@ enum kmalloc_cache_type {
 extern struct kmem_cache *
 kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
 
+unsigned int arch_kmalloc_minalign(void);
+
 /*
  * Define gfp bits that should not be set for KMALLOC_NORMAL.
  */
diff --git a/mm/slab.c b/mm/slab.c
index b04e40078bdf..4aaeeb9c994d 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1256,11 +1256,7 @@ void __init kmem_cache_init(void)
 	 * Initialize the caches that provide memory for the  kmem_cache_node
 	 * structures first.  Without this, further allocations will bug.
 	 */
-	kmalloc_caches[KMALLOC_NORMAL][INDEX_NODE] = create_kmalloc_cache(
-				kmalloc_info[INDEX_NODE].name[KMALLOC_NORMAL],
-				kmalloc_info[INDEX_NODE].size,
-				ARCH_KMALLOC_FLAGS, 0,
-				kmalloc_info[INDEX_NODE].size);
+	new_kmalloc_cache(INDEX_NODE, KMALLOC_NORMAL, ARCH_KMALLOC_FLAGS);
 	slab_state = PARTIAL_NODE;
 	setup_kmalloc_cache_index_table();
 
diff --git a/mm/slab.h b/mm/slab.h
index fd7ae2024897..e9238406602a 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -283,6 +283,8 @@ int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
 struct kmem_cache *create_kmalloc_cache(const char *name, unsigned int size,
 			slab_flags_t flags, unsigned int useroffset,
 			unsigned int usersize);
+void __init new_kmalloc_cache(int idx, enum kmalloc_cache_type type,
+			      slab_flags_t flags);
 extern void create_boot_cache(struct kmem_cache *, const char *name,
 			unsigned int size, slab_flags_t flags,
 			unsigned int useroffset, unsigned int usersize);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6ee64d6208b3..594d8a8a68d0 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -838,9 +838,18 @@ void __init setup_kmalloc_cache_index_table(void)
 	}
 }
 
-static void __init
+unsigned int __weak arch_kmalloc_minalign(void)
+{
+	return ARCH_KMALLOC_MINALIGN;
+}
+
+void __init
 new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 {
+	unsigned int minalign = arch_kmalloc_minalign();
+	unsigned int aligned_size = kmalloc_info[idx].size;
+	int aligned_idx = idx;
+
 	if (type == KMALLOC_RECLAIM) {
 		flags |= SLAB_RECLAIM_ACCOUNT;
 	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
@@ -851,10 +860,17 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 		flags |= SLAB_ACCOUNT;
 	}
 
-	kmalloc_caches[type][idx] = create_kmalloc_cache(
-					kmalloc_info[idx].name[type],
-					kmalloc_info[idx].size, flags, 0,
-					kmalloc_info[idx].size);
+	if (minalign > ARCH_KMALLOC_MINALIGN) {
+		aligned_size = ALIGN(aligned_size, minalign);
+		aligned_idx = __kmalloc_index(aligned_size, false);
+	}
+
+	if (!kmalloc_caches[type][aligned_idx])
+		kmalloc_caches[type][aligned_idx] = create_kmalloc_cache(
+					kmalloc_info[aligned_idx].name[type],
+					aligned_size, flags, 0, aligned_size);
+	if (idx != aligned_idx)
+		kmalloc_caches[type][idx] = kmalloc_caches[type][aligned_idx];
 
 	/*
 	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
@@ -904,11 +920,8 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
 
 		if (s) {
-			kmalloc_caches[KMALLOC_DMA][i] = create_kmalloc_cache(
-				kmalloc_info[i].name[KMALLOC_DMA],
-				kmalloc_info[i].size,
-				SLAB_CACHE_DMA | flags, 0,
-				kmalloc_info[i].size);
+			new_kmalloc_cache(i, KMALLOC_DMA,
+					  SLAB_CACHE_DMA | flags);
 		}
 	}
 #endif
