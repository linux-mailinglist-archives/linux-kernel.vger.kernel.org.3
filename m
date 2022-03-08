Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4364D167C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbiCHLoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346669AbiCHLoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:44:06 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD4A3BF92
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:43:03 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id q13so681945plk.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+Jsu4HCVJIvVBTQ9bsapoPPM3jCvdQzttLGL+ZzKMY=;
        b=jHF9PDv3hq3gkQfo5TFIFXhcA/79kEEdYCzpEA/d2mjRF6bc6Gwd1MihJqJmY1UNmc
         WiD5vCHHqS1j99+Db/d+9ztOYMQKy4/E09xga6rVJMW0cryzeV0Oacb4lz0dzG9DY3y5
         UbpZtTU8pIHuu+xWv3oNoF83r9h3ixhfPsNwwd2I44nGZotZrdp374+gbS3zQRmkvLxh
         8851L7qhzLv6A6szvy04sWjKSRVXp5clOMDLhTXnNIsUsSGod+X06uiJyFbfJr9faNj4
         ZgJwGgqYDx0I2vbjXmrtBo931m/EqAtoR7d+NwX5g0TKsoRQuZZvNu9cfjeeCWZxc3Bc
         rFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+Jsu4HCVJIvVBTQ9bsapoPPM3jCvdQzttLGL+ZzKMY=;
        b=cW1J23CH7D9oVJMIpyqZNyhwP3gfHFhkVn7frto5XwDj46WzuyO5ZxVPmvaKDbsjmh
         l599j1rJ/GP6T1IQ+j1dH7b0srehM2pOBZ3/EOoFrtFZV64cnlcWKx3564SLWuJmT5g5
         LNWMFJlk2RNk4ETzM92VgxmKwiSNU88Ch7/LOS5fW+DZOvYKwdc0AhzZwuDBDP4FsoMZ
         skuceBqTfudl62NDG31RYL9V7FsMI2LmLV+Xq8SH73WyWtvpnRpW/62rjeLI3hz8GXfp
         lfxq7nFYn+Gbe6t3oTGtx0DmE7H5P9EG6ZmDGfBDw8AkieskBGH/e9pCAjbqmGDBK4qh
         744Q==
X-Gm-Message-State: AOAM533a3sfN3hDIc6drI0tSmPr8qd1Xbbvn354dQTcv9LN7sVv5/8TS
        MBvwkWwg3Vhlv37EHmOYeFw=
X-Google-Smtp-Source: ABdhPJx4KwQ5pJZuufi0rCbWEqcdat0s5xevU2SvD3q7sL0/CrSOfOaXj/E7yf7qfpnShkF6fKTIlA==
X-Received: by 2002:a17:90b:1652:b0:1bf:32e9:6db3 with SMTP id il18-20020a17090b165200b001bf32e96db3mr4209347pjb.179.1646739782835;
        Tue, 08 Mar 2022 03:43:02 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:43:01 -0800 (PST)
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
Subject: [RFC PATCH v1 14/15] mm/sl[auo]b: move definition of __ksize() to mm/slab.h
Date:   Tue,  8 Mar 2022 11:41:41 +0000
Message-Id: <20220308114142.1744229-15-42.hyeyoo@gmail.com>
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

__ksize() is only called by KASAN. Remove export symbol and move
definition to mm/slab.h as we don't want to grow its callers.

[ willy@infradead.org: Move definition to mm/slab.h and reduce comments ]

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h |  1 -
 mm/slab.h            |  2 ++
 mm/slab_common.c     | 11 +----------
 mm/slob.c            |  1 -
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 8da8beff712f..a3f8a103f318 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -182,7 +182,6 @@ int kmem_cache_shrink(struct kmem_cache *s);
 void * __must_check krealloc(const void *objp, size_t new_size, gfp_t flags) __alloc_size(2);
 void kfree(const void *objp);
 void kfree_sensitive(const void *objp);
-size_t __ksize(const void *objp);
 size_t ksize(const void *objp);
 #ifdef CONFIG_PRINTK
 bool kmem_valid_obj(void *object);
diff --git a/mm/slab.h b/mm/slab.h
index bfedfe3900bb..4fd4bd7bb4d7 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -673,6 +673,8 @@ void free_large_kmalloc(struct folio *folio, void *object);
 
 #endif /* CONFIG_SLOB */
 
+size_t __ksize(const void *objp);
+
 static inline size_t slab_ksize(const struct kmem_cache *s)
 {
 #ifndef CONFIG_SLUB
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6533026b4a6b..07ed382ed5a9 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -976,15 +976,7 @@ void kfree(const void *x)
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
@@ -999,7 +991,6 @@ size_t __ksize(const void *object)
 
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
-EXPORT_SYMBOL(__ksize);
 #endif /* !CONFIG_SLOB */
 
 gfp_t kmalloc_fix_flags(gfp_t flags)
diff --git a/mm/slob.c b/mm/slob.c
index 836a7d1ae996..59ddf80e987c 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -576,7 +576,6 @@ size_t __ksize(const void *block)
 	m = (unsigned int *)(block - align);
 	return SLOB_UNITS(*m) * SLOB_UNIT;
 }
-EXPORT_SYMBOL(__ksize);
 
 int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
 {
-- 
2.33.1

