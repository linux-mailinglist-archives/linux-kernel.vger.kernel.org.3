Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B820A571B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiGLNl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiGLNlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:41:09 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3252B7D49
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id o12so7504222pfp.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v0Ra2mCmkhs97lju56wkWDygUYxf+qFMbjtuR/xcWUM=;
        b=Va1EalHaI3VhS6se/mZId8N5nQGeKy3Rq1mFP+/nbgL2p5eorhQfrJo2xH1goELwTW
         bSgXKk5F4dpIAzZSCMZdKKBME6hVbFHbWFF+hBaYb0JIUWadGWnYBEbwZXjMaV4164Nf
         eVcahALSse4SL0m3uvkn+8tSvLOth1FJp8f16qG/nNgxonLO7u9v0xYZ5Q//sHtWHUye
         /2uvjrD3bxUF3r37JsNzxwA6GknccDJ3xdD7OpoBCk/+4PgR/5/rZ8qLZJ2gv9eQp1O7
         e/ERHYiIRDrHIHiKR30VM0ssW6gIz7BK9sTsrdFvd0lOLgomJEE8wrEJWoTkJxvtSbHn
         eQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0Ra2mCmkhs97lju56wkWDygUYxf+qFMbjtuR/xcWUM=;
        b=GPPPKKrDZ1ec19aBgPmtvkCiGVRWCMK0gwaXIX+hm7aE9ke3OQGMKb+5N9dlxF+i6r
         zJqzvxtGg6XvoNfcPlUdLahu8BpWWLvu6bT/gug9DeH8Nv8jroe73mETRBTrB/d9ZyNK
         EWRYFj4WaHxAeYrVD5uKk4rhnjXbk4uTc3r0r94PeeVxbJw/XLoSqUVwgbghoszHHObP
         QWJfs0U8vpyyj8x5sOSqn3sC6H6C04yN7LpHmWO/flJIOxjc2clcLAmV2832AJa0zrDj
         /t8NSaEMhS90GoiUUVCx1PiY7gTBzh+Tqbthzh9E5kKcHlZ4CyYP2N1a5h4Qcro5ym7u
         dyiQ==
X-Gm-Message-State: AJIora+tvNc4yHHewN+2fjlN+YqW+VBvnFE1q/THe8jKH/7knwxgM2jF
        jdaLAWLMn/vTmXfCYLSm6f8=
X-Google-Smtp-Source: AGRyM1v3kohd9u7MCQ5n7GErcuU6Ao04BiPJQrX6vF2MBJLKb1sbj/DBi312niR5XFKEbIYrLHI69A==
X-Received: by 2002:a63:6984:0:b0:40d:9ebe:5733 with SMTP id e126-20020a636984000000b0040d9ebe5733mr20810644pgc.170.1657633244244;
        Tue, 12 Jul 2022 06:40:44 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:40:43 -0700 (PDT)
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
Subject: [PATCH 15/16] mm/slab_common: move definition of __ksize() to mm/slab.h
Date:   Tue, 12 Jul 2022 13:39:45 +0000
Message-Id: <20220712133946.307181-16-42.hyeyoo@gmail.com>
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

__ksize() is only called by KASAN. Remove export symbol and move
definition to mm/slab.h as we don't want to grow its callers.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h |  1 -
 mm/slab.h            |  2 ++
 mm/slab_common.c     | 11 +----------
 mm/slob.c            |  1 -
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 4ee5b2fed164..701fe538650f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -187,7 +187,6 @@ int kmem_cache_shrink(struct kmem_cache *s);
 void * __must_check krealloc(const void *objp, size_t new_size, gfp_t flags) __alloc_size(2);
 void kfree(const void *objp);
 void kfree_sensitive(const void *objp);
-size_t __ksize(const void *objp);
 size_t ksize(const void *objp);
 #ifdef CONFIG_PRINTK
 bool kmem_valid_obj(void *object);
diff --git a/mm/slab.h b/mm/slab.h
index 9193e9c1f040..ad634e02b3cb 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -678,6 +678,8 @@ void free_large_kmalloc(struct folio *folio, void *object);
 
 #endif /* CONFIG_SLOB */
 
+size_t __ksize(const void *objp);
+
 static inline size_t slab_ksize(const struct kmem_cache *s)
 {
 #ifndef CONFIG_SLUB
diff --git a/mm/slab_common.c b/mm/slab_common.c
index c01c6b8f0d34..1f8db7959366 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1003,15 +1003,7 @@ void kfree(const void *object)
 }
 EXPORT_SYMBOL(kfree);
 
-/**
- * __ksize -- Uninstrumented ksize.
- * @objp: pointer to the object
- *
- * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
- * safety checks as ksize() with KASAN instrumentation enabled.
- *
- * Return: size of the actual memory used by @objp in bytes
- */
+/* Uninstrumented ksize. Only called by KASAN. */
 size_t __ksize(const void *object)
 {
 	struct folio *folio;
@@ -1026,7 +1018,6 @@ size_t __ksize(const void *object)
 
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
-EXPORT_SYMBOL(__ksize);
 #endif /* !CONFIG_SLOB */
 
 gfp_t kmalloc_fix_flags(gfp_t flags)
diff --git a/mm/slob.c b/mm/slob.c
index 97a4d2407f96..91d6e2b19929 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -584,7 +584,6 @@ size_t __ksize(const void *block)
 	m = (unsigned int *)(block - align);
 	return SLOB_UNITS(*m) * SLOB_UNIT;
 }
-EXPORT_SYMBOL(__ksize);
 
 int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
 {
-- 
2.34.1

