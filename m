Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226E6500920
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbiDNJCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241471AbiDNJB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:01:57 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8C36E540
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so8684347pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgrMWHzF8KTmL9m2nlEJVQvsLaOWu876E+Hsc/ZOTns=;
        b=eVN9EceUKSMr6S3Dx3WSG3+9RqV3tUi12cCXVc+p3TamUxX3IVV/OiGL12wf+uzrtM
         bLCfrPExxg+uIJ8cAf6E3lS2stPyY2CvbRMzA7f4G6+1ieA41AjTW9T9LCHmAq3CkC9e
         NeThT2oo9wah/fTkl0y3/ke9NAsRgUCGibv48DPHIvLZtOw/LiYAD1xVDF8Tg+4YAsSd
         EUTJTAAugQWgdf7WekUhtVCtHeW4bmLZGjmfcw41siVYZgYfguTUhDgYAF/KrEsuuoPm
         /VPvwPamPNs2ny/K7qrsoS5YM990ITJ+Ng14TwhM3kQAjAs3uRonECxyb8khqi8TqYZB
         1BNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgrMWHzF8KTmL9m2nlEJVQvsLaOWu876E+Hsc/ZOTns=;
        b=xA/OLgs11LIVV7QC/DMeo2Dty648ZJy4tASXtgMRdLa/pddJHs/fMeyS5ejEV6waMB
         OZaCMIlVGOAD4HzTh4K2dMYcm3modJT2FKVYKm0iF9HWYqNDN9eM/en6w4Nr4QNnwo6k
         ybVbn8WDztr3Y0GvOFvzhgBHc7gzI4594wRIJ+BG0kMb3Ka/SuIOyzjufK9swEPDpWUr
         w3I3+esLFsYYxsIa+SR5b6hWmFW/zIJuFRGfdSaq8PxtUWJuf3jRnpN/5rX/D7apV3Qs
         JSUEzo23Kpt1TleFdefHIIjFa+DfwlDKytBZpL+Y0By8WjJ5pDbiKTBRdo1CTg/rDwqH
         c/OA==
X-Gm-Message-State: AOAM530X70aRkURtxm5Aaxd9i4i07386ZgBFXMXvCKp7MoF7RX693Pfa
        zVdPDmoBt3SLvW0bsWPuzPeTjAVpzUs=
X-Google-Smtp-Source: ABdhPJwZQkFFpM6qRwxrzIAePqZY2pqNaF46syQsAZdIkRUvqJY7Cm8E08BpythhpVh93GkFpAoCag==
X-Received: by 2002:a17:903:c2:b0:158:5842:2b3a with SMTP id x2-20020a17090300c200b0015858422b3amr20520315plc.126.1649926765109;
        Thu, 14 Apr 2022 01:59:25 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:59:23 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/23] mm/slab_common: implement __kmem_cache_free()
Date:   Thu, 14 Apr 2022 17:57:21 +0900
Message-Id: <20220414085727.643099-18-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220414085727.643099-1-42.hyeyoo@gmail.com>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
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

To generalize kfree in later patch, implement __kmem_cache_free() that
takes caller address and make kmem_cache_free() wrapper of it.

Now that kmem_cache_free() is inline function, we should
use _THIS_IP_ instead of _RET_IP_ for consistency.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 16 +++++++++++++++-
 mm/slab.c            | 17 +++++------------
 mm/slob.c            | 13 +++++++------
 mm/slub.c            |  9 +++++----
 4 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index c8c82087c3f9..0630c37ee630 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -462,7 +462,21 @@ void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru, gfp_t gfp
 	return __kmem_cache_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, _THIS_IP_);
 }
 
-void kmem_cache_free(struct kmem_cache *s, void *objp);
+void __kmem_cache_free(struct kmem_cache *s, void *objp, unsigned long caller __maybe_unused);
+
+/**
+ * kmem_cache_free - Deallocate an object
+ * @s: The cache the allocation was from.
+ * @objp: The previously allocated object.
+ *
+ * Free an object which was previously allocated from this
+ * cache.
+ */
+static __always_inline void kmem_cache_free(struct kmem_cache *s, void *objp)
+{
+	__kmem_cache_free(s, objp, _THIS_IP_);
+}
+
 
 /*
  * Bulk allocation and freeing operations. These are accelerated in an
diff --git a/mm/slab.c b/mm/slab.c
index 424168b96790..d35873da5572 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3579,30 +3579,23 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 }
 #endif
 
-/**
- * kmem_cache_free - Deallocate an object
- * @cachep: The cache the allocation was from.
- * @objp: The previously allocated object.
- *
- * Free an object which was previously allocated from this
- * cache.
- */
-void kmem_cache_free(struct kmem_cache *cachep, void *objp)
+void __kmem_cache_free(struct kmem_cache *cachep, void *objp,
+		       unsigned long caller __maybe_unused)
 {
 	unsigned long flags;
 	cachep = cache_from_obj(cachep, objp);
 	if (!cachep)
 		return;
 
-	trace_kmem_cache_free(cachep->name, _RET_IP_, objp);
+	trace_kmem_cache_free(cachep->name, caller, objp);
 	local_irq_save(flags);
 	debug_check_no_locks_freed(objp, cachep->object_size);
 	if (!(cachep->flags & SLAB_DEBUG_OBJECTS))
 		debug_check_no_obj_freed(objp, cachep->object_size);
-	__cache_free(cachep, objp, _RET_IP_);
+	__cache_free(cachep, objp, caller);
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(kmem_cache_free);
+EXPORT_SYMBOL(__kmem_cache_free);
 
 void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
 {
diff --git a/mm/slob.c b/mm/slob.c
index 1bb4c577b908..e893d182d471 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -631,7 +631,7 @@ void *__kmem_cache_alloc_node(struct kmem_cache *cachep, struct list_lru *lru __
 }
 EXPORT_SYMBOL(__kmem_cache_alloc_node);
 
-static void __kmem_cache_free(void *b, int size)
+static void ____kmem_cache_free(void *b, int size)
 {
 	if (size < PAGE_SIZE)
 		slob_free(b, size);
@@ -644,23 +644,24 @@ static void kmem_rcu_free(struct rcu_head *head)
 	struct slob_rcu *slob_rcu = (struct slob_rcu *)head;
 	void *b = (void *)slob_rcu - (slob_rcu->size - sizeof(struct slob_rcu));
 
-	__kmem_cache_free(b, slob_rcu->size);
+	____kmem_cache_free(b, slob_rcu->size);
 }
 
-void kmem_cache_free(struct kmem_cache *c, void *b)
+void __kmem_cache_free(struct kmem_cache *c, void *b,
+		       unsigned long caller __maybe_unused)
 {
 	kmemleak_free_recursive(b, c->flags);
-	trace_kmem_cache_free(c->name, _RET_IP_, b);
+	trace_kmem_cache_free(c->name, caller, b);
 	if (unlikely(c->flags & SLAB_TYPESAFE_BY_RCU)) {
 		struct slob_rcu *slob_rcu;
 		slob_rcu = b + (c->size - sizeof(struct slob_rcu));
 		slob_rcu->size = c->size;
 		call_rcu(&slob_rcu->head, kmem_rcu_free);
 	} else {
-		__kmem_cache_free(b, c->size);
+		____kmem_cache_free(b, c->size);
 	}
 }
-EXPORT_SYMBOL(kmem_cache_free);
+EXPORT_SYMBOL(__kmem_cache_free);
 
 void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 {
diff --git a/mm/slub.c b/mm/slub.c
index a088d4fa1062..a72a2d08e793 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3466,15 +3466,16 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
 }
 #endif
 
-void kmem_cache_free(struct kmem_cache *s, void *x)
+void __kmem_cache_free(struct kmem_cache *s, void *x,
+		       unsigned long caller __maybe_unused)
 {
 	s = cache_from_obj(s, x);
 	if (!s)
 		return;
-	trace_kmem_cache_free(s->name, _RET_IP_, x);
-	slab_free(s, virt_to_slab(x), x, NULL, 1, _RET_IP_);
+	trace_kmem_cache_free(s->name, caller, x);
+	slab_free(s, virt_to_slab(x), x, NULL, 1, caller);
 }
-EXPORT_SYMBOL(kmem_cache_free);
+EXPORT_SYMBOL(__kmem_cache_free);
 
 struct detached_freelist {
 	struct slab *slab;
-- 
2.32.0

