Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB554F508C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451342AbiDFB3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443721AbiDEPkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D99018500E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:58:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5C4661926
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A697C385A7;
        Tue,  5 Apr 2022 13:58:24 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] mm/slab: Simplify create_kmalloc_cache() args and make it static
Date:   Tue,  5 Apr 2022 14:57:57 +0100
Message-Id: <20220405135758.774016-10-catalin.marinas@arm.com>
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

create_kmalloc_cache() is now only called from new_kmalloc_cache() in
the same file, so make it static. In addition, the useroffset argument
is always 0 while usersize is the same as size. Remove them.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/slab.h        | 3 ---
 mm/slab_common.c | 9 ++++-----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index e9238406602a..d334b5e6d7aa 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -280,9 +280,6 @@ gfp_t kmalloc_fix_flags(gfp_t flags);
 /* Functions provided by the slab allocators */
 int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
 
-struct kmem_cache *create_kmalloc_cache(const char *name, unsigned int size,
-			slab_flags_t flags, unsigned int useroffset,
-			unsigned int usersize);
 void __init new_kmalloc_cache(int idx, enum kmalloc_cache_type type,
 			      slab_flags_t flags);
 extern void create_boot_cache(struct kmem_cache *, const char *name,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 594d8a8a68d0..3a9f7a1e6490 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -655,16 +655,15 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
 	s->refcount = -1;	/* Exempt from merging for now */
 }
 
-struct kmem_cache *__init create_kmalloc_cache(const char *name,
-		unsigned int size, slab_flags_t flags,
-		unsigned int useroffset, unsigned int usersize)
+static struct kmem_cache *__init create_kmalloc_cache(const char *name,
+		unsigned int size, slab_flags_t flags)
 {
 	struct kmem_cache *s = kmem_cache_zalloc(kmem_cache, GFP_NOWAIT);
 
 	if (!s)
 		panic("Out of memory when creating slab %s\n", name);
 
-	create_boot_cache(s, name, size, flags, useroffset, usersize);
+	create_boot_cache(s, name, size, flags, 0, size);
 	kasan_cache_create_kmalloc(s);
 	list_add(&s->list, &slab_caches);
 	s->refcount = 1;
@@ -868,7 +867,7 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 	if (!kmalloc_caches[type][aligned_idx])
 		kmalloc_caches[type][aligned_idx] = create_kmalloc_cache(
 					kmalloc_info[aligned_idx].name[type],
-					aligned_size, flags, 0, aligned_size);
+					aligned_size, flags);
 	if (idx != aligned_idx)
 		kmalloc_caches[type][idx] = kmalloc_caches[type][aligned_idx];
 
