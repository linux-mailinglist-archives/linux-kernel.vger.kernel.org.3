Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB0F512333
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiD0UBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiD0UBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:01:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24E517E19
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:58:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso2584470ybs.20
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KO6mnAXGVtsbAsRrqxqkdvUTskd4INz5fQ2/DuC94GY=;
        b=Ybb+mu0NOoj0QhqyLUfK8pV4RJ3NHdJML7DdD1cR9EV1ptUlbNyYiRFI/XT077lown
         MfQARo0OYRxUjw1C6UpM/ZdDAAbdDiUddgHc2e4MsusWl9yxZiniI1fl9UTzqwLCvepS
         b/jTz7jX/UryiMBvfHySA+Z7bXgtA7kZEm1gkuQAOE0sSPJ9slqS0OODoAoEEcC9+Cch
         tr529Szrs7vo6+6iI1JhQHGzNaGd9qua7N2tsk4PpLJcSgKIu/28Z3qZ/JbHNTvWO3qU
         Tv9w/5M+ql8CfOfBMBZaw4D7LfmnqVQiU+w5I1kLxm1cE+EeL8opw7Q7hF2eQE7kAqqA
         kqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KO6mnAXGVtsbAsRrqxqkdvUTskd4INz5fQ2/DuC94GY=;
        b=MxIQQITTe6eWKavzCRCHcW39amkP7+Pj1p2GJuz+mXT9hqiE6XOS5fdRKqSNVzmglw
         ev8kh0FAE4YmUZiVSMVLESetOd4O5D/TDegwqKb5hJCIEj97plg49f5uluz/8PEpJYKH
         qZycwjc+AnMqeCeaeqHBMYt/lPPptTyqIF1IFmfYNGX7UVL2b9ytKS50WAFxBXSByhi5
         wje/E8BntDpTQ7N9NrrgMAq8QV16rMF//9p3tY4mD7+IiCCG7A9TRj6CgdF6pqNKS1Fq
         7YZR0WdRzigJkVjHnHwM8cDQhmhf37a3t7ecdMmv3TcKNNpcEzJ5x5JOLLrJ/+c4VCMK
         VahA==
X-Gm-Message-State: AOAM5305h3NBwMzJyPpCen1k2QYu/J2WPOfG8vHVOlu0D6NFcLrcY6a4
        eUtkr0O/FIMUDRf/WmVGbAy6IwY=
X-Google-Smtp-Source: ABdhPJzCu524Ub8WtwbBuF6dltuVfGhjeugFC7wFIIsPODuI/eV7MSubuIdu+U7Bdpq7uVZ2FnFd6PE=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:7bf6:862b:86da:9ce1])
 (user=pcc job=sendgmr) by 2002:a25:7796:0:b0:645:7353:637a with SMTP id
 s144-20020a257796000000b006457353637amr26817851ybc.446.1651089507164; Wed, 27
 Apr 2022 12:58:27 -0700 (PDT)
Date:   Wed, 27 Apr 2022 12:58:20 -0700
In-Reply-To: <20220427195820.1716975-1-pcc@google.com>
Message-Id: <20220427195820.1716975-2-pcc@google.com>
Mime-Version: 1.0
References: <20220427195820.1716975-1-pcc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v5 2/2] mm: make minimum slab alignment a runtime property
From:   Peter Collingbourne <pcc@google.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        vbabka@suse.cz, penberg@kernel.org, roman.gushchin@linux.dev,
        iamjoonsoo.kim@lge.com, rientjes@google.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_KASAN_HW_TAGS is enabled we currently increase the minimum
slab alignment to 16. This happens even if MTE is not supported in
hardware or disabled via kasan=off, which creates an unnecessary
memory overhead in those cases. Eliminate this overhead by making
the minimum slab alignment a runtime property and only aligning to
16 if KASAN is enabled at runtime.

On a DragonBoard 845c (non-MTE hardware) with a kernel built with
CONFIG_KASAN_HW_TAGS, waiting for quiescence after a full Android
boot I see the following Slab measurements in /proc/meminfo (median
of 3 reboots):

Before: 169020 kB
After:  167304 kB

Link: https://linux-review.googlesource.com/id/I752e725179b43b144153f4b6f584ceb646473ead
Signed-off-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Acked-by: David Rientjes <rientjes@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
v4:
- add a dependent patch to fix the build with CONFIG_JUMP_LABEL disabled

v3:
- go back to ARCH_SLAB_MINALIGN
- revert changes to fs/binfmt_flat.c
- update arch_slab_minalign() comment to say that it must be a power of two

v2:
- use max instead of max_t in flat_stack_align()

 arch/arm64/include/asm/cache.h | 17 ++++++++++++-----
 include/linux/slab.h           | 12 ++++++++++++
 mm/slab.c                      |  7 +++----
 mm/slab_common.c               |  3 +--
 mm/slob.c                      |  6 +++---
 5 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index a074459f8f2f..22b22dc1b1b5 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -6,6 +6,7 @@
 #define __ASM_CACHE_H
 
 #include <asm/cputype.h>
+#include <asm/mte-def.h>
 
 #define CTR_L1IP_SHIFT		14
 #define CTR_L1IP_MASK		3
@@ -49,16 +50,22 @@
  */
 #define ARCH_DMA_MINALIGN	(128)
 
+#ifndef __ASSEMBLY__
+
+#include <linux/bitops.h>
+#include <linux/kasan-enabled.h>
+
 #ifdef CONFIG_KASAN_SW_TAGS
 #define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
 #elif defined(CONFIG_KASAN_HW_TAGS)
-#define ARCH_SLAB_MINALIGN	MTE_GRANULE_SIZE
+static inline size_t arch_slab_minalign(void)
+{
+	return kasan_hw_tags_enabled() ? MTE_GRANULE_SIZE :
+					 __alignof__(unsigned long long);
+}
+#define arch_slab_minalign() arch_slab_minalign()
 #endif
 
-#ifndef __ASSEMBLY__
-
-#include <linux/bitops.h>
-
 #define ICACHEF_ALIASING	0
 #define ICACHEF_VPIPT		1
 extern unsigned long __icache_flags;
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 373b3ef99f4e..2c7190db4cc0 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -209,6 +209,18 @@ void kmem_dump_obj(void *object);
 #define ARCH_SLAB_MINALIGN __alignof__(unsigned long long)
 #endif
 
+/*
+ * Arches can define this function if they want to decide the minimum slab
+ * alignment at runtime. The value returned by the function must be a power
+ * of two and >= ARCH_SLAB_MINALIGN.
+ */
+#ifndef arch_slab_minalign
+static inline size_t arch_slab_minalign(void)
+{
+	return ARCH_SLAB_MINALIGN;
+}
+#endif
+
 /*
  * kmalloc and friends return ARCH_KMALLOC_MINALIGN aligned
  * pointers. kmem_cache_alloc and friends return ARCH_SLAB_MINALIGN
diff --git a/mm/slab.c b/mm/slab.c
index 0edb474edef1..97b756976c8b 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3009,10 +3009,9 @@ static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep,
 	objp += obj_offset(cachep);
 	if (cachep->ctor && cachep->flags & SLAB_POISON)
 		cachep->ctor(objp);
-	if (ARCH_SLAB_MINALIGN &&
-	    ((unsigned long)objp & (ARCH_SLAB_MINALIGN-1))) {
-		pr_err("0x%px: not aligned to ARCH_SLAB_MINALIGN=%d\n",
-		       objp, (int)ARCH_SLAB_MINALIGN);
+	if ((unsigned long)objp & (arch_slab_minalign() - 1)) {
+		pr_err("0x%px: not aligned to arch_slab_minalign()=%d\n", objp,
+		       (int)arch_slab_minalign());
 	}
 	return objp;
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2b3206a2c3b5..33cc49810a54 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -154,8 +154,7 @@ static unsigned int calculate_alignment(slab_flags_t flags,
 		align = max(align, ralign);
 	}
 
-	if (align < ARCH_SLAB_MINALIGN)
-		align = ARCH_SLAB_MINALIGN;
+	align = max_t(size_t, align, arch_slab_minalign());
 
 	return ALIGN(align, sizeof(void *));
 }
diff --git a/mm/slob.c b/mm/slob.c
index 40ea6e2d4ccd..3bd2669bd690 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -478,7 +478,7 @@ static __always_inline void *
 __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 {
 	unsigned int *m;
-	int minalign = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
+	int minalign = max_t(size_t, ARCH_KMALLOC_MINALIGN, arch_slab_minalign());
 	void *ret;
 
 	gfp &= gfp_allowed_mask;
@@ -555,7 +555,7 @@ void kfree(const void *block)
 
 	sp = virt_to_folio(block);
 	if (folio_test_slab(sp)) {
-		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
+		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, arch_slab_minalign());
 		unsigned int *m = (unsigned int *)(block - align);
 		slob_free(m, *m + align);
 	} else {
@@ -584,7 +584,7 @@ size_t __ksize(const void *block)
 	if (unlikely(!folio_test_slab(folio)))
 		return folio_size(folio);
 
-	align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
+	align = max_t(size_t, ARCH_KMALLOC_MINALIGN, arch_slab_minalign());
 	m = (unsigned int *)(block - align);
 	return SLOB_UNITS(*m) * SLOB_UNIT;
 }
-- 
2.36.0.464.gb9c8b46e94-goog

