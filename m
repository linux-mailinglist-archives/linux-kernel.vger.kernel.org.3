Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE05571B80
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiGLNkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiGLNkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:40:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70E1B7D52
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o15so7648633pjh.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RfZICKzfMt9jP521ltPO4rr38titj9GujPx2SBl9+NM=;
        b=Lg0N91mr0+CDOYu+efRU4fHCR7Qv3ssQqZ5FEFbYTsc//saKmmUTlEeXOMTauarXrT
         6lWX5v9SwRcnkS8qmBYYIwxTKQG7t4ihTTYZe22uPKe1RrVAvIIb23e41kXILNHh2zNU
         9z4wt2QwoiZ1XiACht3mok9xBmUUlqDwGv8gKgMHdFnFUltMkCqIHUCY6TrJ2+diPX4y
         81/PPs6VRwN63pMoo0OyfU1/DepI1eK6jVpYLrmDv0XlEKEp2nEU+W5QCJ40DcCrMUwi
         DlqxHINZEVrxBh82Wy6tgJZPVrMuMsZ830BIUtDkPBotOYLldgp+/ePgUJDazYKMHWew
         N+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RfZICKzfMt9jP521ltPO4rr38titj9GujPx2SBl9+NM=;
        b=ieA6qdiEiIZQlYNknO28XoHT6APCvbRyPNKl7EN0ZKf9JHdrxg1I865n56it+7lmvB
         g4293dNl1BU1GHhIEjEPgTQc+wlsmmL5hXuNo5sa9dvKuHhL+krF4fYZ+IeTZtZl+5Vz
         Y+VwpbA7R90A5i+33Ms6TazMu2Jd40LrkWUSTzxF0IcnrSTB1QJFUVt3dBoxWIEwBRqY
         P6J/qyL6A7j3XU6CloV3bwkME5R3L9T0t4Btq2QHNObzaFFw8HeCMi0WMV/8YpKjCUKE
         l/1eoaC3NIfxHbA5vCpoxx3eIvqTIwXe3jOJkWRh7fbBfml9xVgczwW+UUQKzioj6tGu
         VNWQ==
X-Gm-Message-State: AJIora8JnNduviXeGV6DCCnYLN08Spkm0MbeLoLdqsF40jw9z0EbuM0R
        TYs1FGJrrxJWO+l4WKCQyfY=
X-Google-Smtp-Source: AGRyM1vlXqHvvszhpDV2iSM8ks7jydXWE9ZU4N9umSMIWSjNT0JIA0n9gnMP/DPU6j56Ir4d5vWV9w==
X-Received: by 2002:a17:902:e746:b0:16c:4eb6:915d with SMTP id p6-20020a170902e74600b0016c4eb6915dmr9478865plf.106.1657633213063;
        Tue, 12 Jul 2022 06:40:13 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:40:12 -0700 (PDT)
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
Subject: [PATCH v3 06/15] mm/slab_common: fold kmalloc_order_trace() into kmalloc_large()
Date:   Tue, 12 Jul 2022 13:39:36 +0000
Message-Id: <20220712133946.307181-7-42.hyeyoo@gmail.com>
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

There is no caller of kmalloc_order_trace() except kmalloc_large().
Fold it into kmalloc_large() and remove kmalloc_order{,_trace}().

Also add tracepoint in kmalloc_large() that was previously
in kmalloc_order_trace().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 22 ++--------------------
 mm/slab_common.c     | 14 +++-----------
 2 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index a0e57df3d5a4..15a4c59da59e 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -489,26 +489,8 @@ static __always_inline void *kmem_cache_alloc_node_trace(struct kmem_cache *s, g
 }
 #endif /* CONFIG_TRACING */
 
-extern void *kmalloc_order(size_t size, gfp_t flags, unsigned int order) __assume_page_alignment
-									 __alloc_size(1);
-
-#ifdef CONFIG_TRACING
-extern void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
-				__assume_page_alignment __alloc_size(1);
-#else
-static __always_inline __alloc_size(1) void *kmalloc_order_trace(size_t size, gfp_t flags,
-								 unsigned int order)
-{
-	return kmalloc_order(size, flags, order);
-}
-#endif
-
-static __always_inline __alloc_size(1) void *kmalloc_large(size_t size, gfp_t flags)
-{
-	unsigned int order = get_order(size);
-	return kmalloc_order_trace(size, flags, order);
-}
-
+void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
+					      __alloc_size(1);
 /**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6c9aac5d8f4a..1f8af2106df0 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -932,10 +932,11 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
  * directly to the page allocator. We use __GFP_COMP, because we will need to
  * know the allocation order to free the pages properly in kfree.
  */
-void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
+void *kmalloc_large(size_t size, gfp_t flags)
 {
 	void *ret = NULL;
 	struct page *page;
+	unsigned int order = get_order(size);
 
 	if (unlikely(flags & GFP_SLAB_BUG_MASK))
 		flags = kmalloc_fix_flags(flags);
@@ -950,19 +951,10 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 	ret = kasan_kmalloc_large(ret, size, flags);
 	/* As ret might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ret, size, 1, flags);
-	return ret;
-}
-EXPORT_SYMBOL(kmalloc_order);
-
-#ifdef CONFIG_TRACING
-void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
-{
-	void *ret = kmalloc_order(size, flags, order);
 	trace_kmalloc(_RET_IP_, ret, NULL, size, PAGE_SIZE << order, flags);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_order_trace);
-#endif
+EXPORT_SYMBOL(kmalloc_large);
 
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 /* Randomize a generic freelist */
-- 
2.34.1

