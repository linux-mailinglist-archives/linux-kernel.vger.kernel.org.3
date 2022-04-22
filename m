Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089FE50C114
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiDVVYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiDVVYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:24:48 -0400
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1F2257441
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:20:43 -0700 (PDT)
Received: by mail-yb1-f201.google.com with SMTP id p22-20020a254216000000b0064588c45fbaso2873921yba.16
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eMAERF62YTPWtGAsO2YVmQloDH5oUr4o6LySCLx0+Cc=;
        b=F83iESBWnyy6uOnOgeXvhunYpfwEIKcvbOdsfG8Cp6juORqTB5/nyhOk7YWhV15WRD
         mj/4LWY3xVAfwCdPVkSCNFayj1T36VLUNCxX90pH1FGwsgJKnEql6zrzfIjrQcGdVqLO
         yw7SVLcseqko8s7na0HZRF6ZmLyDMnO92X2a/jpzJ0ZxcdbuEr0jyUfppc0XxYFFkMZi
         OlDE09MJDkJ8B4l+ofc7oi+3/oizqB0UL2V0Qctf6ujyteRiJdRTU/qWsbiBdom3DsPT
         l7G/2dY47aoouvl5TMBEVo7BKXknk054vhzlwt3Y5foEZctZ65TFJ9m3Y+EEbkBK8EhX
         +vCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eMAERF62YTPWtGAsO2YVmQloDH5oUr4o6LySCLx0+Cc=;
        b=jL9TZ8UTIbSUKONgG673UDvVAsc8Uye/FZ4E3zDgW+KalReX7XYpBHaWEXndKsHOBY
         eTwIAIOE3qGNqg0PGXxo7mjsqhJ+LSXjHT9HMlGxDAlGfUjlGGEOHqvheb/F0FkFpo9l
         A+vFckq5NAB00mB+Qfk0iUieyeh6U9qjHiKTR7AUtu30x9tNf8mWGHZtrO6yE5meDAxn
         3X0kUmzNgGCaFZxsiF39EyHU8vbyozinCuMLWr4gHxQWDCAA9msqoxzSyM6MG/lm4A2+
         wqds2E7oEsRri79tX7TKiaBaculwsXZFSVUpxREB2MCWiI6u0McXrG52T4JjHBqA7u4K
         CvEg==
X-Gm-Message-State: AOAM533z2qhYAhL/X4HsAISJ2LZwGkad3TIEubSgpdthOV9P5LiiTfRn
        kGhPwtnMW3atjU6U4lFfoLefifM=
X-Google-Smtp-Source: ABdhPJzs3wUmGnm/6gjGMkcBDBSkTa9dTxn95pedDMqZb3BCTfFfhpQ/gQ6c3EzTP1AHdexsjK2ZhLU=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:b874:60b4:62b:9c7a])
 (user=pcc job=sendgmr) by 2002:a81:2654:0:b0:2f7:c5f4:a486 with SMTP id
 m81-20020a812654000000b002f7c5f4a486mr265675ywm.141.1650658720646; Fri, 22
 Apr 2022 13:18:40 -0700 (PDT)
Date:   Fri, 22 Apr 2022 13:18:30 -0700
Message-Id: <20220422201830.288018-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3] mm: make minimum slab alignment a runtime property
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
---
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
2.36.0.rc2.479.g8af0fa9b8e-goog

