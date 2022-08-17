Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBC4596CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbiHQKUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239034AbiHQKUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:20:17 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F10975FFE
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 24so11604913pgr.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ru5NzUFWFY1mp//X6stEiyuQPjnMcLZ7ult0h/+qL8E=;
        b=YqBZ+mIsukwjNFm5uj1S+x8Wp0d/9vKvRmeFd9hIw3ZdJzV0rLL/Zmbnggn5OJciun
         9UgY/TPWTSYXcxq3xtTI7HAeHmaNStsepckVV8MkSvRWAfWqJIP4XYhCXx+jwx0i4yiN
         bDOIH+nLhf+U8CWc08sNAyxHmLQSsy5Cx5fVlJI/WKog3wjMJKqopoCY1lL1nV2rKqEP
         MJvm2+Ki7N/FCE2q6MsxhJDfWyPKkgM9Zd0qGEGxxKsD+tht0wnGOoErPE1d9WFBRlfm
         WZ8xpj3b/K6MAqYWvqfxR58XK7+JIc77qIu1Q+pijxc5z+kSq8bTsIh5WE9CfHIG0SYI
         oreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ru5NzUFWFY1mp//X6stEiyuQPjnMcLZ7ult0h/+qL8E=;
        b=ipmHf7MBxAGHCod/rFJz6fM/p0u+a2OiwsRdrjp5mnDaFPUhuDMK/NouuqFNr/G6Ha
         uCN3Kb7E48hDSgU6ZS9dK8P36MWe4a5GSmKgYdy0lDjSddZUw7fgTv0waIaRfbOtWrtu
         NADxNfypcJqnb5Or+FSiKCMf+/pndBaUA421lvB2xelZgMnZh5juBp/TApUiA/J9rYoW
         hHsR4GuTqnuo6XEcZQ6QmLJNNzOIEBCrEml5JhUpIiQPwbsSp1Td7Iflgh7aSpha0VOa
         21EJI2BiZXxlF+bfIlChessejk+cqJlT1YXEjPYw1wcz1vDh5WGe3pf6kfWfhhhDlvcQ
         y5uQ==
X-Gm-Message-State: ACgBeo3WCAIXan6xWFFH3AReY/OOXHngWaYfft5eMNuTD+Y9LkAJJ+UF
        jDxH0uBLBijkWBK9jXzzpR4=
X-Google-Smtp-Source: AA6agR6ifSZS508FUcNv8AUeG2x8oARm+JTo00bgXTAg+e0iyMO0y0O7vjS+8iYkahz8ahDH0g7Mmg==
X-Received: by 2002:a63:fd14:0:b0:41a:20e8:c1e2 with SMTP id d20-20020a63fd14000000b0041a20e8c1e2mr21017032pgh.286.1660731586184;
        Wed, 17 Aug 2022 03:19:46 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:19:45 -0700 (PDT)
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
Subject: [PATCH v4 16/17] mm/slab_common: move declaration of __ksize() to mm/slab.h
Date:   Wed, 17 Aug 2022 19:18:25 +0900
Message-Id: <20220817101826.236819-17-42.hyeyoo@gmail.com>
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

__ksize() is only called by KASAN. Remove export symbol and move
declaration to mm/slab.h as we don't want to grow its callers.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h |  1 -
 mm/slab.h            |  2 ++
 mm/slab_common.c     | 11 +----------
 mm/slob.c            |  1 -
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index c8e485ce8815..9b592e611cb1 100644
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
index 4d8330d57573..65023f000d42 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -668,6 +668,8 @@ void free_large_kmalloc(struct folio *folio, void *object);
 
 #endif /* CONFIG_SLOB */
 
+size_t __ksize(const void *objp);
+
 static inline size_t slab_ksize(const struct kmem_cache *s)
 {
 #ifndef CONFIG_SLUB
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e53016c9a6e9..9c273a5fb0d7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -974,15 +974,7 @@ void kfree(const void *object)
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
@@ -997,7 +989,6 @@ size_t __ksize(const void *object)
 
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
-EXPORT_SYMBOL(__ksize);
 
 #ifdef CONFIG_TRACING
 void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
diff --git a/mm/slob.c b/mm/slob.c
index 771af84576bf..45a061b8ba38 100644
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
2.32.0

