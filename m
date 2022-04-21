Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4974650954D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 05:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383904AbiDUDUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 23:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345657AbiDUDUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 23:20:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AFE1262A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:17:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2ec1914e315so32695767b3.23
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SbxX3iRYBfJsdKsirndlC6UWegb+qEqhjR3XzkrVSj0=;
        b=ZMN+jGeDKY3AvGi/KV82QDQCz3vMHbjL6Q+R2pWZbUXMI/lV8J5I6l0oy5dYae3dEk
         Mhb17aP8V6qcnNLKSYY8B8PLwV4+Lkjax59QF/HQ/AAo6ccsbjU7E2fmsF07CSjg1MNr
         yeJbgq1YMZJpO13LMbMuZTnmbjOMtxNj5oUb6QgaqcDmPjmiwV8cWvMUACOVc8wNVdq6
         QwHjdgnsNMU++S8dEseDi1frndz8cjHQ3pz8idpF58BV56kF09wE8QS8+mIktxqJ7/EE
         7ATJY3GzHUp+dr02vt2LVPSZr3XA1OtJQd8gN9COnd31sMVRw2edVWgUTTxIrDxis67O
         6K4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SbxX3iRYBfJsdKsirndlC6UWegb+qEqhjR3XzkrVSj0=;
        b=m9zLv3Td6EzQh6wEtuqFudoWrlyxvCI5MGGoCzMxjNrPodEeMjTmcWyWUcpDncieDS
         QRJ5OEo5e1r0MGm1tL3Wq1ltCJR39tQY1XRwLWhNq+do+afTpIH5vxkZ+ttf6B4OA/oH
         eiWSqxtsGITcnW2euPDuT/Ht6NItvwLmsR+viqIAE1gMzS3ZbiRrOJr2UYHyg/3GttUC
         ADJev8t6JsjSYDOZKDmTejPC65ADeQi/IIwwRn8roTaHmt9+zW0vM4YwNzxyuYx6UayZ
         vUg2YNRwluFo1IVBdF4mV95ZQ2e+Hj6EjT/IwLwJU/FWYj7fXFp4OGjf1sxqYNPgpMLr
         5TIQ==
X-Gm-Message-State: AOAM5307gnoKoxNa/PGAcvJszHZq9NwY/yxxGNi2IsLGW8dFgDuL7ixt
        OEENR1y5B/pxQZczJhGzQs8+I14=
X-Google-Smtp-Source: ABdhPJykcclttmnOtbgLTyZVBmJ1Wqu+sh1ix+zCl7mtpFORSWLvU2MlVo/BUQfI8ut/W/PeVdXbtY8=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:7bfa:bfc6:ac0d:67de])
 (user=pcc job=sendgmr) by 2002:a25:9a42:0:b0:622:4bed:4f4f with SMTP id
 r2-20020a259a42000000b006224bed4f4fmr24488782ybo.508.1650511074523; Wed, 20
 Apr 2022 20:17:54 -0700 (PDT)
Date:   Wed, 20 Apr 2022 20:17:38 -0700
Message-Id: <20220421031738.3168157-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH] mm: make minimum slab alignment a runtime property
From:   Peter Collingbourne <pcc@google.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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
---
 arch/arc/include/asm/cache.h        |  4 ++--
 arch/arm/include/asm/cache.h        |  2 +-
 arch/arm64/include/asm/cache.h      | 19 +++++++++++++------
 arch/microblaze/include/asm/page.h  |  2 +-
 arch/riscv/include/asm/cache.h      |  2 +-
 arch/sparc/include/asm/cache.h      |  2 +-
 arch/xtensa/include/asm/processor.h |  2 +-
 fs/binfmt_flat.c                    |  9 ++++++---
 include/crypto/hash.h               |  2 +-
 include/linux/slab.h                | 22 +++++++++++++++++-----
 mm/slab.c                           |  7 +++----
 mm/slab_common.c                    |  3 +--
 mm/slob.c                           |  6 +++---
 13 files changed, 51 insertions(+), 31 deletions(-)

diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
index f0f1fc5d62b6..b6a7763fd5d6 100644
--- a/arch/arc/include/asm/cache.h
+++ b/arch/arc/include/asm/cache.h
@@ -55,11 +55,11 @@
  * Make sure slab-allocated buffers are 64-bit aligned when atomic64_t uses
  * ARCv2 64-bit atomics (LLOCKD/SCONDD). This guarantess runtime 64-bit
  * alignment for any atomic64_t embedded in buffer.
- * Default ARCH_SLAB_MINALIGN is __alignof__(long long) which has a relaxed
+ * Default ARCH_SLAB_MIN_MINALIGN is __alignof__(long long) which has a relaxed
  * value of 4 (and not 8) in ARC ABI.
  */
 #if defined(CONFIG_ARC_HAS_LL64) && defined(CONFIG_ARC_HAS_LLSC)
-#define ARCH_SLAB_MINALIGN	8
+#define ARCH_SLAB_MIN_MINALIGN	8
 #endif
 
 extern int ioc_enable;
diff --git a/arch/arm/include/asm/cache.h b/arch/arm/include/asm/cache.h
index e3ea34558ada..3e1018bb9805 100644
--- a/arch/arm/include/asm/cache.h
+++ b/arch/arm/include/asm/cache.h
@@ -21,7 +21,7 @@
  * With EABI on ARMv5 and above we must have 64-bit aligned slab pointers.
  */
 #if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5)
-#define ARCH_SLAB_MINALIGN 8
+#define ARCH_SLAB_MIN_MINALIGN 8
 #endif
 
 #define __read_mostly __section(".data..read_mostly")
diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index a074459f8f2f..38f171591c3f 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -6,6 +6,7 @@
 #define __ASM_CACHE_H
 
 #include <asm/cputype.h>
+#include <asm/mte-def.h>
 
 #define CTR_L1IP_SHIFT		14
 #define CTR_L1IP_MASK		3
@@ -49,15 +50,21 @@
  */
 #define ARCH_DMA_MINALIGN	(128)
 
-#ifdef CONFIG_KASAN_SW_TAGS
-#define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
-#elif defined(CONFIG_KASAN_HW_TAGS)
-#define ARCH_SLAB_MINALIGN	MTE_GRANULE_SIZE
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
+#include <linux/kasan-enabled.h>
+
+#ifdef CONFIG_KASAN_SW_TAGS
+#define ARCH_SLAB_MIN_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
+#elif defined(CONFIG_KASAN_HW_TAGS)
+static inline size_t arch_slab_minalign(void)
+{
+	return kasan_hw_tags_enabled() ? MTE_GRANULE_SIZE :
+					 __alignof__(unsigned long long);
+}
+#define arch_slab_minalign() arch_slab_minalign()
+#endif
 
 #define ICACHEF_ALIASING	0
 #define ICACHEF_VPIPT		1
diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index 4b8b2fa78fc5..ccdbc1da3c3e 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -33,7 +33,7 @@
 /* MS be sure that SLAB allocates aligned objects */
 #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
 
-#define ARCH_SLAB_MINALIGN	L1_CACHE_BYTES
+#define ARCH_SLAB_MIN_MINALIGN	L1_CACHE_BYTES
 
 /*
  * PAGE_OFFSET -- the first address of the first page of memory. With MMU
diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
index 9b58b104559e..7beb3b5d27c7 100644
--- a/arch/riscv/include/asm/cache.h
+++ b/arch/riscv/include/asm/cache.h
@@ -16,7 +16,7 @@
  * the flat loader aligns it accordingly.
  */
 #ifndef CONFIG_MMU
-#define ARCH_SLAB_MINALIGN	16
+#define ARCH_SLAB_MIN_MINALIGN	16
 #endif
 
 #endif /* _ASM_RISCV_CACHE_H */
diff --git a/arch/sparc/include/asm/cache.h b/arch/sparc/include/asm/cache.h
index e62fd0e72606..9d8cb4687b7e 100644
--- a/arch/sparc/include/asm/cache.h
+++ b/arch/sparc/include/asm/cache.h
@@ -8,7 +8,7 @@
 #ifndef _SPARC_CACHE_H
 #define _SPARC_CACHE_H
 
-#define ARCH_SLAB_MINALIGN	__alignof__(unsigned long long)
+#define ARCH_SLAB_MIN_MINALIGN	__alignof__(unsigned long long)
 
 #define L1_CACHE_SHIFT 5
 #define L1_CACHE_BYTES 32
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 4489a27d527a..e3ea278e3fcf 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -18,7 +18,7 @@
 #include <asm/types.h>
 #include <asm/regs.h>
 
-#define ARCH_SLAB_MINALIGN XTENSA_STACK_ALIGNMENT
+#define ARCH_SLAB_MIN_MINALIGN XTENSA_STACK_ALIGNMENT
 
 /*
  * User space process size: 1 GB.
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 626898150011..8ff1bf7d1e87 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -64,7 +64,10 @@
  * Here we can be a bit looser than the data sections since this
  * needs to only meet arch ABI requirements.
  */
-#define FLAT_STACK_ALIGN	max_t(unsigned long, sizeof(void *), ARCH_SLAB_MINALIGN)
+static size_t flat_stack_align(void)
+{
+	return max_t(unsigned long, sizeof(void *), arch_slab_minalign());
+}
 
 #define RELOC_FAILED 0xff00ff01		/* Relocation incorrect somewhere */
 #define UNLOADED_LIB 0x7ff000ff		/* Placeholder for unused library */
@@ -148,7 +151,7 @@ static int create_flat_tables(struct linux_binprm *bprm, unsigned long arg_start
 		sp -= 2; /* argvp + envp */
 	sp -= 1;  /* &argc */
 
-	current->mm->start_stack = (unsigned long)sp & -FLAT_STACK_ALIGN;
+	current->mm->start_stack = (unsigned long)sp & -flat_stack_align();
 	sp = (unsigned long __user *)current->mm->start_stack;
 
 	if (put_user(bprm->argc, sp++))
@@ -966,7 +969,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
 #endif
 	stack_len += (bprm->argc + 1) * sizeof(char *);   /* the argv array */
 	stack_len += (bprm->envc + 1) * sizeof(char *);   /* the envp array */
-	stack_len = ALIGN(stack_len, FLAT_STACK_ALIGN);
+	stack_len = ALIGN(stack_len, flat_stack_align());
 
 	res = load_flat_file(bprm, &libinfo, 0, &stack_len);
 	if (res < 0)
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index f140e4643949..442c290f458c 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -149,7 +149,7 @@ struct ahash_alg {
 
 struct shash_desc {
 	struct crypto_shash *tfm;
-	void *__ctx[] __aligned(ARCH_SLAB_MINALIGN);
+	void *__ctx[] __aligned(ARCH_SLAB_MIN_MINALIGN);
 };
 
 #define HASH_MAX_DIGESTSIZE	 64
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 373b3ef99f4e..80e517593372 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -201,21 +201,33 @@ void kmem_dump_obj(void *object);
 #endif
 
 /*
- * Setting ARCH_SLAB_MINALIGN in arch headers allows a different alignment.
+ * Setting ARCH_SLAB_MIN_MINALIGN in arch headers allows a different alignment.
  * Intended for arches that get misalignment faults even for 64 bit integer
  * aligned buffers.
  */
-#ifndef ARCH_SLAB_MINALIGN
-#define ARCH_SLAB_MINALIGN __alignof__(unsigned long long)
+#ifndef ARCH_SLAB_MIN_MINALIGN
+#define ARCH_SLAB_MIN_MINALIGN __alignof__(unsigned long long)
+#endif
+
+/*
+ * Arches can define this function if they want to decide the minimum slab
+ * alignment at runtime. The value returned by the function must be
+ * >= ARCH_SLAB_MIN_MINALIGN.
+ */
+#ifndef arch_slab_minalign
+static inline size_t arch_slab_minalign(void)
+{
+	return ARCH_SLAB_MIN_MINALIGN;
+}
 #endif
 
 /*
  * kmalloc and friends return ARCH_KMALLOC_MINALIGN aligned
- * pointers. kmem_cache_alloc and friends return ARCH_SLAB_MINALIGN
+ * pointers. kmem_cache_alloc and friends return ARCH_SLAB_MIN_MINALIGN
  * aligned pointers.
  */
 #define __assume_kmalloc_alignment __assume_aligned(ARCH_KMALLOC_MINALIGN)
-#define __assume_slab_alignment __assume_aligned(ARCH_SLAB_MINALIGN)
+#define __assume_slab_alignment __assume_aligned(ARCH_SLAB_MIN_MINALIGN)
 #define __assume_page_alignment __assume_aligned(PAGE_SIZE)
 
 /*
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
2.36.0.rc0.470.gd361397f0d-goog

