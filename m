Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123594CCDE8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbiCDGge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238481AbiCDGgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:36:16 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77FE18E3E8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:34:50 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so7164480pjl.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 22:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kPOOk68I4eD0EZtqHYKQaSrGBjBqSrtM4mnuv4oRjyQ=;
        b=nDQzt1phNSGQYKWCNk0gp2OnBhDzbFsLtVoMQZYprv1JockjSyVxMyhajm1xm7lr7V
         AWmFM71q4nLmK+IbMdcN4MrfIWcWUSusSJ2Ak1sFRxCRVgo9+yRWwtHiBLiO5kN6l0Cf
         yLLWwtivZxP28j4U1PbUfMvuJgkWTHpSgrnltIZ0HxRydMzgP58+XIo8ze8XNWAnBf2r
         jxc5GN7nej6IJEd/CXES7lSAJZ89+/JWxuMRhSr1m6iMiAkoym1w3oFIxqXIbLz27+YQ
         I4aOWtlXWIArSgaMdhm6eVGUNNI2Nn3Ars/MW3LDXBiy2RoYV6zkphnKYaYNQ1rT3Fwa
         B46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kPOOk68I4eD0EZtqHYKQaSrGBjBqSrtM4mnuv4oRjyQ=;
        b=pXentCywoqSr30KC+dN7fPjSaIpW+wsbuf3xJWY4bN/79g1HTfOIpMzXKSyA5UhXnJ
         JVYSCOI6e/ay0FqX4EkbFxDneVXTJ+O+HHuRv1vrWFWg+0kYnuPcqykm6W6zn85Q7gH+
         rg5KzmB0OJM3w8eQIyrpL5WTJiGOWolvvcoH6d12ZaCde9vjcaQiW14aPBt0jDoo4Dz3
         TcA3MQNzl8Q7aLqFpN6JXEmeXy1UgpBn/wCumMmmyRoAy9GSO60VnGRaUxcR+9ajOW9n
         QF0gHnFH+K3Y5DsNUKuaSMra+Xrt3qromqQPGpl1XT+kMBERwmvpLY6dXnu/oIXsspzS
         UPjA==
X-Gm-Message-State: AOAM530dqYRpBVFjSjE9EqxbTkkU13hroxjZRNUBMnKCt+/i3d3uO6Kl
        kfKIbcRT6sTtVHFxiG75QAU=
X-Google-Smtp-Source: ABdhPJx6Xk2mOdK3KCJoE/feOSg8DDkvCzteGHm0Tcc9N7Tq32/YEHDYtA7ATrAkhbz8I8OkNz0/Dg==
X-Received: by 2002:a17:90a:eb07:b0:1be:f354:9404 with SMTP id j7-20020a17090aeb0700b001bef3549404mr9122314pjz.90.1646375689983;
        Thu, 03 Mar 2022 22:34:49 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id v10-20020a056a00148a00b004e0f420dd90sm4900007pfu.40.2022.03.03.22.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 22:34:49 -0800 (PST)
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
Subject: [PATCH v2 3/5] mm/sl[auo]b: move definition of __ksize() to mm/slab.h
Date:   Fri,  4 Mar 2022 06:34:25 +0000
Message-Id: <20220304063427.372145-4-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220304063427.372145-1-42.hyeyoo@gmail.com>
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
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
---
 include/linux/slab.h | 1 -
 mm/slab.h            | 2 ++
 mm/slab_common.c     | 9 +--------
 mm/slob.c            | 1 -
 4 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index e7b3330db4f3..d2b896553315 100644
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
index 31e98beb47a3..79b319d58504 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -685,6 +685,8 @@ static inline void free_large_kmalloc(struct folio *folio, void *object)
 }
 #endif /* CONFIG_SLOB */
 
+size_t __ksize(const void *objp);
+
 static inline size_t slab_ksize(const struct kmem_cache *s)
 {
 #ifndef CONFIG_SLUB
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1d2f92e871d2..b126fc7247b9 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1247,13 +1247,7 @@ EXPORT_SYMBOL(kfree_sensitive);
 
 #ifndef CONFIG_SLOB
 /**
- * __ksize -- Uninstrumented ksize.
- * @objp: pointer to the object
- *
- * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
- * safety checks as ksize() with KASAN instrumentation enabled.
- *
- * Return: size of the actual memory used by @objp in bytes
+ * __ksize -- Uninstrumented ksize. Only called by KASAN.
  */
 size_t __ksize(const void *object)
 {
@@ -1269,7 +1263,6 @@ size_t __ksize(const void *object)
 
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
-EXPORT_SYMBOL(__ksize);
 #endif
 
 /**
diff --git a/mm/slob.c b/mm/slob.c
index 60c5842215f1..d8af6c54f133 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -588,7 +588,6 @@ size_t __ksize(const void *block)
 	m = (unsigned int *)(block - align);
 	return SLOB_UNITS(*m) * SLOB_UNIT;
 }
-EXPORT_SYMBOL(__ksize);
 
 int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
 {
-- 
2.33.1

