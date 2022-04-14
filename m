Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05709500938
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241458AbiDNJFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241486AbiDNJCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:02:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F52922286
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so5056078pjk.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NORyvB92HhMuMei+Pomh8Oih3TxPvQvxBtXd7TKFrXs=;
        b=cYuAPq95v2bjnqMdfyAhTbn9wVgLymi4gKjixUDP+cO7CMfR4/fi7HonSlCYGSwsRC
         juz4svkPR8qlGI/1jbF6uq2yJWXSJ+XmzrgSEaXXO7WOG3oeUozWp50ZdbPfTLH863HW
         rE32U++MGWqz45csIVcjq1DdTRF2VuTW/xbEr5SkJWoclIRte41zD1rdFWJMivW++xfE
         gDfBcr8IwjMw8mfQAwFGkiUrPtkaV1PNyIvL3HDqe1HWHyjKWLQtHF+12x5afHVEYOHU
         lfd2lswe3lQ4L1IXLAN/Vc9XajD/XmsRzdwMGHVkWPCOFGJqp8Wiva+CavFuKgFuYHCZ
         5O+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NORyvB92HhMuMei+Pomh8Oih3TxPvQvxBtXd7TKFrXs=;
        b=utUzG1PjzTUC0R6WB/jGgMA7kvqRrObPLbqd8BwrHgoYJCjVphw1R9z6Fe1yyLxm1h
         0CeC2Yrph59UWumwg5BpaWtcYo6jKzgINuvxViBxmIInG2YwxMqeiiMwU1fOX0msIUkg
         H60+Nmm0aw584ZuE7Y51qbAPQtA/L08MZC559Sh2B2QDJFOSVQoDy6KhYimKPNajImpt
         E1dfaqYNJ9Nq5fjuHBtAW0MhiCa9DH7ZUnWWLVONsuNIUXqTLdtwz2DnTB/uofMblkWX
         wJ+oepynCdElxhbhFm5CVD1KA6vkp4BS5ZOkfuhHDZqVxsOIlOcYzDx/gNyDqtin9vgf
         D8Eg==
X-Gm-Message-State: AOAM531PCFSziQJtmLWzE9jAXPg+HQ7tCumCn1Ku/8YZiJ8ErGxfQluD
        XGVYg4T+hVQXsVRMHrGrdf0=
X-Google-Smtp-Source: ABdhPJyohnd8KppvDlxmWverlmJ9PEfUJInYQHrOa24aW7oR0ao4/RGtPXE31A73I2fqb5HQ5QEs3g==
X-Received: by 2002:a17:90b:4d01:b0:1cd:46e8:215a with SMTP id mw1-20020a17090b4d0100b001cd46e8215amr2640027pjb.73.1649926794713;
        Thu, 14 Apr 2022 01:59:54 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:59:53 -0700 (PDT)
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
Subject: [PATCH v2 22/23] mm/sl[auo]b: move definition of __ksize() to mm/slab.h
Date:   Thu, 14 Apr 2022 17:57:26 +0900
Message-Id: <20220414085727.643099-23-42.hyeyoo@gmail.com>
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
index c1aed9d97cf2..e30c0675d6b2 100644
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
index 45ddb19df319..5a500894317b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -690,6 +690,8 @@ void free_large_kmalloc(struct folio *folio, void *object);
 
 #endif /* CONFIG_SLOB */
 
+size_t __ksize(const void *objp);
+
 static inline size_t slab_ksize(const struct kmem_cache *s)
 {
 #ifndef CONFIG_SLUB
diff --git a/mm/slab_common.c b/mm/slab_common.c
index af563e64e8aa..8facade42bdd 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -984,15 +984,7 @@ void kfree(const void *x)
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
@@ -1007,7 +999,6 @@ size_t __ksize(const void *object)
 
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
-EXPORT_SYMBOL(__ksize);
 #endif /* !CONFIG_SLOB */
 
 gfp_t kmalloc_fix_flags(gfp_t flags)
diff --git a/mm/slob.c b/mm/slob.c
index e893d182d471..adf794d58eb5 100644
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
2.32.0

