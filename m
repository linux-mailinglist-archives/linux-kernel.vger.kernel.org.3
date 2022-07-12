Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E4B571B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiGLNk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiGLNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:40:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EBFB7D65
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so11428262pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+t2TYQyUd3MLoRrZFHRafgKosCtEfHks/X4I7bodFI=;
        b=lC9cVXM2npScD2ZYw8CT4kj9R7jq2JvDLs1QphPos+o7fmVpE0703VFXwBBoaSuZhj
         do6IQnZW/TV5vv8kqxIIgodC+sQz51op1rKKgohqWHwuj/MqEorzrMTj1co42+Ld/j0A
         CkDaf/7TID8mjapFQN4v6YVew41uT2Qd2o/kEPHo4zGlAW23FoGiiqYbRHKFBF7po/7L
         dsZEsN55SNfbFLL8fiY6CjOtiLvKP3rmoxVQhYK4YjZG59ppQ3+RlG0SrqRNd0hNO2s1
         ilfwlaRg0ZSeaTuaEFpKYY1OvIh2/w7uQVwN3N3iXaEbVGBCCx9YE4c1oTG3TaIq8NmH
         l9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+t2TYQyUd3MLoRrZFHRafgKosCtEfHks/X4I7bodFI=;
        b=FORgWDRvaMe5IslZeePneLZ7TNkawMVr09Va+DRej3bkwMsMZoXAD3jUlWe+ToPzw1
         uG3WE26ITS9nzlcH5Q8d8KbcET7fFGGxzWyhGiucy4UtIrTu7u+sESBJE9+eEJoN04Sh
         M0/eSj6hRi430EFCgBZBXRKn0uqv2xxSICzITnO6OsGixqrG5sE3K+Dd8xg3+QWykrFV
         LcjopCLqSJf7kz8jchlmSB0CiiPveeyRMdbtVi5K87z6yiM9QZHKoMx2Rkxwiv/JI7hE
         VGI8L/yhJ1B7a1hUOpfsUXZ2IcgFnbsWbey8raYTZ3VY7G/24pngt41qfOPjp6zyvMHl
         rFWg==
X-Gm-Message-State: AJIora9Rb4UC5KDJRrQupM4YqY83QKnEZi5KJTfaK3d0x3bz/X8x19LS
        P1SKL/R40tj3rEjo5QchrGs=
X-Google-Smtp-Source: AGRyM1tF4nj/+intWIHCMQ8XyAHzk+7R0O55XlDFiY10p+ezbHjlYwpSeqsyseQ0P6NtV2q1y+hqLg==
X-Received: by 2002:a17:90b:1c0e:b0:1ef:f82c:1746 with SMTP id oc14-20020a17090b1c0e00b001eff82c1746mr4371155pjb.124.1657633206339;
        Tue, 12 Jul 2022 06:40:06 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:40:05 -0700 (PDT)
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
Subject: [PATCH v3 04/15] mm/slab_common: cleanup kmalloc_track_caller()
Date:   Tue, 12 Jul 2022 13:39:34 +0000
Message-Id: <20220712133946.307181-5-42.hyeyoo@gmail.com>
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

Make kmalloc_track_caller() wrapper of kmalloc_node_track_caller().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 17 ++++++++---------
 mm/slab.c            |  6 ------
 mm/slob.c            |  6 ------
 mm/slub.c            | 22 ----------------------
 4 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 4754c834b0e3..a0e57df3d5a4 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -651,6 +651,12 @@ static inline __alloc_size(1, 2) void *kcalloc(size_t n, size_t size, gfp_t flag
 	return kmalloc_array(n, size, flags | __GFP_ZERO);
 }
 
+void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
+				  unsigned long caller) __alloc_size(1);
+#define kmalloc_node_track_caller(size, flags, node) \
+	__kmalloc_node_track_caller(size, flags, node, \
+				    _RET_IP_)
+
 /*
  * kmalloc_track_caller is a special version of kmalloc that records the
  * calling function of the routine calling it for slab leak tracking instead
@@ -659,9 +665,9 @@ static inline __alloc_size(1, 2) void *kcalloc(size_t n, size_t size, gfp_t flag
  * allocator where we care about the real place the memory allocation
  * request comes from.
  */
-extern void *__kmalloc_track_caller(size_t size, gfp_t flags, unsigned long caller);
 #define kmalloc_track_caller(size, flags) \
-	__kmalloc_track_caller(size, flags, _RET_IP_)
+	__kmalloc_node_track_caller(size, flags, \
+				    NUMA_NO_NODE, _RET_IP_)
 
 static inline __alloc_size(1, 2) void *kmalloc_array_node(size_t n, size_t size, gfp_t flags,
 							  int node)
@@ -680,13 +686,6 @@ static inline __alloc_size(1, 2) void *kcalloc_node(size_t n, size_t size, gfp_t
 	return kmalloc_array_node(n, size, flags | __GFP_ZERO, node);
 }
 
-
-extern void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
-					 unsigned long caller) __alloc_size(1);
-#define kmalloc_node_track_caller(size, flags, node) \
-	__kmalloc_node_track_caller(size, flags, node, \
-			_RET_IP_)
-
 /*
  * Shortcuts
  */
diff --git a/mm/slab.c b/mm/slab.c
index 81804921c538..da2f6a5dd8fa 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3665,12 +3665,6 @@ void *__kmalloc(size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(__kmalloc);
 
-void *__kmalloc_track_caller(size_t size, gfp_t flags, unsigned long caller)
-{
-	return __do_kmalloc(size, flags, caller);
-}
-EXPORT_SYMBOL(__kmalloc_track_caller);
-
 /**
  * kmem_cache_free - Deallocate an object
  * @cachep: The cache the allocation was from.
diff --git a/mm/slob.c b/mm/slob.c
index c54aad6b106c..80cdbe4f0d67 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -530,12 +530,6 @@ void *__kmalloc(size_t size, gfp_t gfp)
 }
 EXPORT_SYMBOL(__kmalloc);
 
-void *__kmalloc_track_caller(size_t size, gfp_t gfp, unsigned long caller)
-{
-	return __do_kmalloc_node(size, gfp, NUMA_NO_NODE, caller);
-}
-EXPORT_SYMBOL(__kmalloc_track_caller);
-
 void *__kmalloc_node_track_caller(size_t size, gfp_t gfp,
 					int node, unsigned long caller)
 {
diff --git a/mm/slub.c b/mm/slub.c
index a5b3a4484263..7c284535a62b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4904,28 +4904,6 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 	return 0;
 }
 
-void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
-{
-	struct kmem_cache *s;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return kmalloc_large(size, gfpflags);
-
-	s = kmalloc_slab(size, gfpflags);
-
-	if (unlikely(ZERO_OR_NULL_PTR(s)))
-		return s;
-
-	ret = slab_alloc(s, NULL, gfpflags, caller, size);
-
-	/* Honor the call site pointer we received. */
-	trace_kmalloc(caller, ret, s, size, s->size, gfpflags);
-
-	return ret;
-}
-EXPORT_SYMBOL(__kmalloc_track_caller);
-
 void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 					int node, unsigned long caller)
 {
-- 
2.34.1

