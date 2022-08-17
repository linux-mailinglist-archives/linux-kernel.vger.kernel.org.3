Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656AE596CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbiHQKUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239017AbiHQKTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:19:46 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958668053F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u22so3362894plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Daa1VQEO90b1RAILID/2eNYhl4WJ1tJNJRwlSK6+APs=;
        b=W6PsCrjgbKrvxCBQCQHMSo2WhEZ8f/XuU5argCzxfQbBHYDA1W+hhpS31AosnPk6c3
         TElwq517lBeG71MGD7nDV2ZvRWe9isPvVlbvTEil+r7q/kjZ0aNeUrN1juLGdNQyuFJh
         uJj5MGga4wTp0NxUlS7V7NDJ9eL/w6uQjug0SXLFsnMRn8NhKiFmcu9NFlmAx4G0ntZj
         dYnxkRsZN1UIAQbOtXGrJpVZF7XG6XG72fY/9/4yvSnFY7NPplZJX6vHi2yNc2ekS7bw
         qDfKyvCT+s9isO3UuKeGikXmR15NMOykh6JOFOPYQKQS5imqPTpNszSyBQHc1X20QdVh
         eONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Daa1VQEO90b1RAILID/2eNYhl4WJ1tJNJRwlSK6+APs=;
        b=fz+kHeCaXKpcBPXYpIefEDnI9M7Rm+AjshDiNk1GvNCMZC4oiaKOOBo/q6qFpDW8KP
         c6wfmL+a42ezWIdNu0pOKJDGUtnLSLjO+HK/BVE5NYOf0soULonzi3bwO8Om7UxHYOLp
         EtpeN9iau1q90Yba8NqRAXzR/e3stOdSB1/81BKfwU/AVJ9y7NPll0VaO0sxw05+/J3K
         f0BM64I+hrV3VMzd+7Z1yJYsskSS7FpHUiy67yHJ3RpiayRu/elMtwuqG1yBPXkS457f
         xMkc9LLSAm3x4Qcirz8Rj+m0brTBBl3fnmYYo1uzs/F30usUo1HdwD+cyDgn3eNe4SGU
         VplQ==
X-Gm-Message-State: ACgBeo0zXXc4/0nXRm/kSwhT8UFn9zuVB06izwQN9cBRf+q2UriyxFDq
        dz0g5YlWW3y3aYwGNSQvA3E=
X-Google-Smtp-Source: AA6agR5NX3zrqI+s7B2wouE/rq8MdzR3qps4dt4XbqfqKpvrdEuq5/VqipgEphbdDE+OOpPjq7+FaQ==
X-Received: by 2002:a17:90b:3ecd:b0:1f5:6330:8295 with SMTP id rm13-20020a17090b3ecd00b001f563308295mr2966134pjb.174.1660731567045;
        Wed, 17 Aug 2022 03:19:27 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:19:26 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/17] mm/sl[au]b: introduce common alloc/free functions without tracepoint
Date:   Wed, 17 Aug 2022 19:18:20 +0900
Message-Id: <20220817101826.236819-12-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220817101826.236819-1-42.hyeyoo@gmail.com>
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To unify kmalloc functions in later patch, introduce common alloc/free
functions that does not have tracepoint.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.c | 36 +++++++++++++++++++++++++++++-------
 mm/slab.h |  4 ++++
 mm/slub.c | 13 +++++++++++++
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 10c9af904410..aa61851b0a07 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3560,6 +3560,14 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
+void *__kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
+			     int nodeid, size_t orig_size,
+			     unsigned long caller)
+{
+	return slab_alloc_node(cachep, NULL, flags, nodeid,
+			       orig_size, caller);
+}
+
 #ifdef CONFIG_TRACING
 void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 				  gfp_t flags,
@@ -3645,6 +3653,26 @@ void *__kmalloc(size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(__kmalloc);
 
+static __always_inline
+void __do_kmem_cache_free(struct kmem_cache *cachep, void *objp,
+			  unsigned long caller)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	debug_check_no_locks_freed(objp, cachep->object_size);
+	if (!(cachep->flags & SLAB_DEBUG_OBJECTS))
+		debug_check_no_obj_freed(objp, cachep->object_size);
+	__cache_free(cachep, objp, caller);
+	local_irq_restore(flags);
+}
+
+void __kmem_cache_free(struct kmem_cache *cachep, void *objp,
+		       unsigned long caller)
+{
+	__do_kmem_cache_free(cachep, objp, caller);
+}
+
 /**
  * kmem_cache_free - Deallocate an object
  * @cachep: The cache the allocation was from.
@@ -3655,18 +3683,12 @@ EXPORT_SYMBOL(__kmalloc);
  */
 void kmem_cache_free(struct kmem_cache *cachep, void *objp)
 {
-	unsigned long flags;
 	cachep = cache_from_obj(cachep, objp);
 	if (!cachep)
 		return;
 
 	trace_kmem_cache_free(_RET_IP_, objp, cachep->name);
-	local_irq_save(flags);
-	debug_check_no_locks_freed(objp, cachep->object_size);
-	if (!(cachep->flags & SLAB_DEBUG_OBJECTS))
-		debug_check_no_obj_freed(objp, cachep->object_size);
-	__cache_free(cachep, objp, _RET_IP_);
-	local_irq_restore(flags);
+	__do_kmem_cache_free(cachep, objp, _RET_IP_);
 }
 EXPORT_SYMBOL(kmem_cache_free);
 
diff --git a/mm/slab.h b/mm/slab.h
index 381ba3e6b2a1..4e90ed0ab635 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -275,6 +275,10 @@ void create_kmalloc_caches(slab_flags_t);
 struct kmem_cache *kmalloc_slab(size_t, gfp_t);
 
 void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node);
+void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
+			      int node, size_t orig_size,
+			      unsigned long caller);
+void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller);
 #endif
 
 gfp_t kmalloc_fix_flags(gfp_t flags);
diff --git a/mm/slub.c b/mm/slub.c
index a659874c5d44..a11f78c2647c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3262,6 +3262,14 @@ void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_lru);
 
+void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
+			      int node, size_t orig_size,
+			      unsigned long caller)
+{
+	return slab_alloc_node(s, NULL, gfpflags, node,
+			       caller, orig_size);
+}
+
 #ifdef CONFIG_TRACING
 void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
@@ -3526,6 +3534,11 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
 }
 #endif
 
+void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller)
+{
+	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, caller);
+}
+
 void kmem_cache_free(struct kmem_cache *s, void *x)
 {
 	s = cache_from_obj(s, x);
-- 
2.32.0

