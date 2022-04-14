Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8112E50090A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbiDNJAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbiDNJA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:00:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24A168982
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id n22so3941966pfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K7ZmOmH1IbMc+vnlcJBZfbxN3MEcHeLW2ET7s3Wh5sM=;
        b=I70WfUKgVpQ6q+asH3FAmRn1WWiOAy6zd0FZbkAq6a02yN2z6/+ljmprknkpE2cMGP
         b4fjuvaH99F1aAEhWhnan9EeGlHqrNslTlrjI4++n/eXgw1TU26x9LyLn7zzYY7G8I5H
         k+Me9mMeCsC6PFp93hM/rk+BLLAkGkljpvOBs/M9dmFGcEAxWhAOIEZbIEa6HSBsTTR/
         gGDOtgcz78mbZNfs+WMW7SVniVtfBKOzZjoUJOB74VvgPmFiGz4yVUfDdsGyyDfDMEYI
         /7LrxWRqv+J5fTU5AIfm6CDGouRBJSKF5fdrjc8qplsLME+iRSJfjU0b9+2f2fdEOGPX
         9LJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7ZmOmH1IbMc+vnlcJBZfbxN3MEcHeLW2ET7s3Wh5sM=;
        b=2Agu6DZauGZ9tsIxp1KpguAneP4rxMqjyBiaGsW9fPUmL8xIBK0FCuKisz0RbL019F
         7OnhCPcokySOhBV5W+n0mTk9G72eTkhZmV+hAGJOry0ebmvMwcgy0b5On561cNkdpIQ9
         qRHehQbAPOKeRnrd8rTuVLjQ7/etvKqT4vheVXPYPgvn0ilbWpYaDeiBIbe3ceZtDBYN
         MmIufFTsgj72VIvJHKXa6P40rQjHHcLdooUV7IZSu5G20+34xqkc2dHapZNPJH/qFqpK
         T2GZHFvRwrW76zb3WNygvWCSeB5nLLO0XJdvTIvnfru6Mpk6bffrXvi4dVJpiKuN2yBn
         t9IQ==
X-Gm-Message-State: AOAM532FYzxZYafcpJPuwxUG6ObIUPZaNJF8FWmWESlxqb+St3GNVj1J
        ybqhNAH7gGpu06kGrrE3LCo=
X-Google-Smtp-Source: ABdhPJwjedRUJ62C/VUVzRlP7p+Lh/lKMZPqawWi7OpyiXjnkb9bEleKPusTPvxIUdrOkQXNBlkZtg==
X-Received: by 2002:aa7:88ce:0:b0:505:6a0b:c965 with SMTP id k14-20020aa788ce000000b005056a0bc965mr14021729pff.67.1649926683254;
        Thu, 14 Apr 2022 01:58:03 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:58:01 -0700 (PDT)
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
Subject: [PATCH v2 04/23] mm/slab_common: cleanup kmalloc_track_caller()
Date:   Thu, 14 Apr 2022 17:57:08 +0900
Message-Id: <20220414085727.643099-5-42.hyeyoo@gmail.com>
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

Make kmalloc_track_caller() wrapper of kmalloc_node_track_caller().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 17 ++++++++---------
 mm/slab.c            |  6 ------
 mm/slob.c            |  6 ------
 mm/slub.c            | 22 ----------------------
 4 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index a3b9d4c20d7e..acdb4b7428f9 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -639,6 +639,12 @@ static inline __alloc_size(1, 2) void *kcalloc(size_t n, size_t size, gfp_t flag
 	return kmalloc_array(n, size, flags | __GFP_ZERO);
 }
 
+extern void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
+					 unsigned long caller) __alloc_size(1);
+#define kmalloc_node_track_caller(size, flags, node) \
+	__kmalloc_node_track_caller(size, flags, node, \
+				    _RET_IP_)
+
 /*
  * kmalloc_track_caller is a special version of kmalloc that records the
  * calling function of the routine calling it for slab leak tracking instead
@@ -647,9 +653,9 @@ static inline __alloc_size(1, 2) void *kcalloc(size_t n, size_t size, gfp_t flag
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
@@ -668,13 +674,6 @@ static inline __alloc_size(1, 2) void *kcalloc_node(size_t n, size_t size, gfp_t
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
index 5ad55ca96ab6..5f20efc7a330 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3675,12 +3675,6 @@ void *__kmalloc(size_t size, gfp_t flags)
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
index c8c3b5662edf..6d0fc6ad1413 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -528,12 +528,6 @@ void *__kmalloc(size_t size, gfp_t gfp)
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
index e36c148e5069..e425c5c372de 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4903,28 +4903,6 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
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
-	trace_kmalloc(caller, ret, size, s->size, gfpflags);
-
-	return ret;
-}
-EXPORT_SYMBOL(__kmalloc_track_caller);
-
 void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 					int node, unsigned long caller)
 {
-- 
2.32.0

