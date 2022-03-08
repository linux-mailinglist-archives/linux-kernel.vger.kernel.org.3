Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E6B4D1680
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346606AbiCHLod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346664AbiCHLoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:44:06 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58C531DC8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:42:59 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w4so6455487ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUPv+czHu+ddxgZ8oS0ewjwH+jitPnbHg1+sr8pOpYg=;
        b=G85/TCA5cJn/gdgyKVVMiRrVQa4IJvnrVAVddno0iqZqfKkxMScN5MUN/1r3QDUj5l
         oQqQ/O1DMYPRqam5/slZ3iu7wI1+aOk6ThNdibALhfW+keQXjrQzbw0LgsbYvzbbKA3s
         qQboPhxljlWY6DAYBxiBol1vIBTDS4o20gBPVEhbMhRLr6o5hwseTHDYL+DPeKz9TzGl
         cH+O8IUmk+geLIImbcNI57rSJzfEYEnXu6a+6Che/9Hmu/fqqS8iQc/VmuL2XTXWpY/T
         jfk50yhnx0HqcyKtOrTm7ribD8/BA7OGE7kAR4x0Y3nnmQRe0zWTvXiLI8VO9sGUHX8b
         SsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUPv+czHu+ddxgZ8oS0ewjwH+jitPnbHg1+sr8pOpYg=;
        b=7Q6jSD2UTnAUKkIWLaPuhKxLbhQ/7zOQweNU7GLQYX4lg0dAd8P325gYlDJtJZJ3+r
         mfJmnsK7QjVdh/PKoC1Q3ygaJIilwDIOskLjhTtvOJlExPZ7BLnjLyHdYvWMOckH+VvL
         K9bptUK2GyTMu+4kiGhcYQbPaI3dDURloBMN3vWN4JbWPI5ws7kFbDRiyFzf9Su+Pfx3
         eoiQ90N5GUOjGoFivSCAa6TaOf60hl0pxbsj5G5xSscMkuE4OiBsbG7pAbK4wVoztUyX
         wnbdbjd87qNAg51gXvBpSgViUlT7qIavsFlH5u8RctVhUSMJBRKIsXYxYJnQFVR9YP1M
         zVGw==
X-Gm-Message-State: AOAM530pISjIKsYUotEKItxpA0H8XL2XlfRL0ckdtXMQOiU3mTOMib+l
        SsXo5lMVY3dvNUSI4Gmy1Yc=
X-Google-Smtp-Source: ABdhPJwpAmeD5MxtpUNKumLB7VVq1hmeVGqwhjbe/E/SlKyFascMG1F61KAp6t4bp87BqLUVr36lUQ==
X-Received: by 2002:a17:90a:74c7:b0:1bf:5532:3ae8 with SMTP id p7-20020a17090a74c700b001bf55323ae8mr4124308pjl.120.1646739778875;
        Tue, 08 Mar 2022 03:42:58 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:42:58 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, 42.hyeyoo@gmail.com
Subject: [RFC PATCH v1 13/15] mm/sl[au]b: remove kmem_cache_alloc_node_trace()
Date:   Tue,  8 Mar 2022 11:41:40 +0000
Message-Id: <20220308114142.1744229-14-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
References: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
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

kmem_cache_alloc_node_trace() was introduced by commit 4a92379bdfb4
("slub tracing: move trace calls out of always inlined functions to reduce
kernel code size") to avoid inlining tracepoints for inlined kmalloc
function calls.

Now that we use same tracepoint in kmalloc and normal caches,
kmem_cache_alloc_node_trace() can be replaced with
__kmem_cache_alloc_node() and kasan_kmalloc().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 6b632137f799..8da8beff712f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -497,10 +497,6 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-extern void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
-					 int node, size_t size) __assume_slab_alignment
-								__alloc_size(4);
-
 extern void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 				__assume_page_alignment __alloc_size(1);
 
@@ -512,6 +508,9 @@ static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
 #ifndef CONFIG_SLOB
 static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
+	struct kmem_cache *s;
+	void *objp;
+
 	if (__builtin_constant_p(size)) {
 		unsigned int index;
 
@@ -523,9 +522,11 @@ static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t fla
 		if (!index)
 			return ZERO_SIZE_PTR;
 
-		return kmem_cache_alloc_node_trace(
-				kmalloc_caches[kmalloc_type(flags)][index],
-						flags, node, size);
+		s = kmalloc_caches[kmalloc_type(flags)][index];
+
+		objp = __kmem_cache_alloc_node(s, flags, node, _RET_IP_);
+		objp = kasan_kmalloc(s, objp, size, flags);
+		return objp;
 	}
 	return __kmalloc_node(size, flags, node);
 }
-- 
2.33.1

