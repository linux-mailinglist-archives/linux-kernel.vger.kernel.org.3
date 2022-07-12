Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4939571B86
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiGLNlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiGLNki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:40:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B2DB851A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w22so726601ply.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9trx0bduPD2gKBrMHDX1mfzZZXG+Gw7lYAsCvpVcLo=;
        b=KGPEqotBNFGeitsFyFdQnj/ioV4T9439Ug3SDyKROEBkz8PCFdHO4XPZdNcc0TOFhd
         cjrj2c+PJYv0Eb8EqTY+O0hq4bZ/ZpLBNoDasWmtGEqAxn8bxcuxL6cSL8nlOjh6uLGT
         ic0l7sxWROpTXOPuLmlUszqvdqnZ5LwRZdO954bnV8Xct+3ADkq6OWoE9qgq4/kpiN/s
         SuSEdfpgplC8O+KIiLgRMy69oKTPxq2dWkDbl0KoiNrKal74bWT6e0FqARZXZaYXiAH5
         Aj/wtGTpxxi7lxqCecIdiH6Bc52lbLmZCIg/Iae+9BXhnGMICzn9SFoPBZB4I5G6Q9TC
         Vedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9trx0bduPD2gKBrMHDX1mfzZZXG+Gw7lYAsCvpVcLo=;
        b=ncbib2AYatmY23FknkBpQhZITDK0uDL22H6AtqgncJQK74ZKXCygsoVjNUf/e0o5ek
         I5VmMtrT7kdyyUOMffefUM/9q8BfppMNEypvycRzCIJKYxvxs3ggKZM2PTa0g6gOi70H
         0yhsgj5Gs668W7g9b5NVq8+mIH+FeD0Ljc6gPfm+YJf/QNLbAAJNSGpnWDpL6wsnDOBm
         LIMxrnbRwD473JzWFzlbsW1FMEgNACX56zABDrtfGU0xvZvuJcBRS8Kd03mrlWWwizfZ
         N6u8WwoyJQ7DEqcbZXPCH93SZdjc0+7gEp6qDpFlz9ZwWdPBAZmqJQEMraTD8IVLdNh6
         crvg==
X-Gm-Message-State: AJIora8kX76VK94QgYVdB1d9D21h4NuB8NbN/4DpQ3Xp+vz1axDw4RoP
        avymQTJHnif91v4k8tRm778=
X-Google-Smtp-Source: AGRyM1sMglOT9Btb/nAvMbQYf3DF9hAHMsrKiLzAo+9qCzA5jMlaMSXF/SyIG17UAHaDWKYeJ28Mtw==
X-Received: by 2002:a17:902:f792:b0:168:e97b:3c05 with SMTP id q18-20020a170902f79200b00168e97b3c05mr23581351pln.94.1657633230347;
        Tue, 12 Jul 2022 06:40:30 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:40:29 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 11/15] mm/sl[au]b: introduce common alloc/free functions without tracepoint
Date:   Tue, 12 Jul 2022 13:39:41 +0000
Message-Id: <20220712133946.307181-12-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220712133946.307181-1-42.hyeyoo@gmail.com>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
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
---

v3: 
   Tried to avoid affecting existing functions.

 mm/slab.c | 36 +++++++++++++++++++++++++++++-------
 mm/slab.h |  4 ++++
 mm/slub.c | 13 +++++++++++++
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index a2f43425a0ae..375e35c14430 100644
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
index c81c92d421f1..9193e9c1f040 100644
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
index 6cb7ca27f3b7..74eb78678c98 100644
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
2.34.1

