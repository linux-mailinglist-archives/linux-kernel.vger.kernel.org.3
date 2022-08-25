Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC84F5A0D91
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbiHYKMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241025AbiHYKMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:12:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABFEA9261
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:11:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y15so15265555pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aSHAnJbXt+emb9j4QTyZL0s3Z7FutteIJpqm4S4DPUM=;
        b=RbsrREZnLtUzH8gMFFYqbdaGcqZdakHJIv4jEVHZfBUUk3tWVyBDnamcGPs1WsJ92r
         XJP90JRC4AVQlJZ50k+SQY6YhJNMEXbO+pw56gstS/zmz9D27iUjvirTz/+n1TCIeIqv
         Otm0knF+sTO56iugjSfAESn7+Zs+O3BSqFcgoaMGi/Y1s3ZE/gxsk61nXNShGQaAgkw6
         T16FtOglAQKreSOxKFyKlyM69RkbmwiV69jFMM1ymowkokK5JY1s3UHXlEaOgDyC/wHz
         zi0Nrbo6R4Vx1XW5NoHASgr1T+r9Me0DG0TNIzP1G1c9yTqtjgzt3FeUuAV2M+8yAV6Y
         n8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aSHAnJbXt+emb9j4QTyZL0s3Z7FutteIJpqm4S4DPUM=;
        b=FQy54m83d0/iv5/a3lBG+KOJD9axsqcy6wn5684eIr/oeyCYCU+AYNdAYLrj9AuM6w
         frnmEB//YS7E4RkwvfYnttGGrb4o+9CP6zN/S5J5V3lZ22+JDu03D6BZrj77lIzl8Rc4
         H+dg2VqwBlVI5z/4e4clGon63BxiiOfYhG9qpvD+XMOM+A4dwbEQcWDSI4sPDkhWyrFE
         ZyPxY5dPTxVyYD7gyv/zNFPTI6U+mO9rgqLbm6hKULiev8Frn/gm08McH1SkrTuQUnOX
         hAcG2znkxICHBdRzQfw3Mzavu2opajeRfUwlYM+8YykdlubHUUA31DC3t6TaHskw01lM
         G4+Q==
X-Gm-Message-State: ACgBeo0QQG2PklvjnuER+u9Ap4gSN9sapYABO2z7haslCcgJDXVVl2HZ
        IsByeZMvu8qmfBnIoPdbjBTMaA==
X-Google-Smtp-Source: AA6agR5AzI0RX0KK63LNqUrxwhd2qQ24X4dqPnkbn1vY7sUvc+FjOJ1dzhvq9jKl7nzUl8UApJFrjg==
X-Received: by 2002:a05:6a00:1996:b0:52e:b0f7:8c83 with SMTP id d22-20020a056a00199600b0052eb0f78c83mr3235245pfl.59.1661422314575;
        Thu, 25 Aug 2022 03:11:54 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001714c36a6e7sm8477581plh.284.2022.08.25.03.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:11:54 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@redhat.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        jgg@nvidia.com, tglx@linutronix.de, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 4/7] mm: introduce pte_refcount for user PTE page table page
Date:   Thu, 25 Aug 2022 18:10:34 +0800
Message-Id: <20220825101037.96517-5-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
References: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the largest user PTE page table memory that
can be allocated by a single user process in a 32-bit and a
64-bit system (assuming 4K page size).

+---------------------------+--------+---------+
|                           | 32-bit | 64-bit  |
+===========================+========+=========+
| user PTE page table pages | 3 MiB  | 512 GiB |
+---------------------------+--------+---------+
| user PMD page table pages | 3 KiB  | 1 GiB   |
+---------------------------+--------+---------+
(for 32-bit, take 3G user address space as an example;
 for 64-bit, take 48-bit address width as an example.)

Today, 64-bit servers generally have only a few terabytes of
physical memory, and mapping these memory does not require as
many PTE page tables as above, but in some of the following
scenarios, it is still possible to cause huge page table memory
usage.

1. In order to pursue high performance, applications mostly use
   some high-performance user-mode memory allocators, such as
   jemalloc or tcmalloc. These memory allocators use
   madvise(MADV_DONTNEED or MADV_FREE) to release physical memory,
   but neither MADV_DONTNEED nor MADV_FREE will release page table
   memory, which may cause huge page table memory as follows:

		VIRT:  55t
        	RES:   590g
        	VmPTE: 110g

In this case, most of the page table entries are empty. For such
a PTE page where all entries are empty, we call it empty PTE page.

2. The shared zero page scenario mentioned by David Hildenbrand:

	Especially the shared zeropage is nasty, because there are
	sane use cases that can trigger it. Assume you have a VM
	(e.g., QEMU) that inflated the balloon to return free memory
	to the hypervisor.

	Simply migrating that VM will populate the shared zeropage to
	all inflated pages, because migration code ends up reading all
	VM memory. Similarly, the guest can just read that memory as
	well, for example, when the guest issues kdump itself.

In this case, most of the page table entries are mapped to the shared
zero page. For such a PTE page where all page table entries are mapped
to zero pages, we call it zero PTE page.

The page table entries for both types of PTE pages do not record
"meaningful" information, so we can try to free these PTE pages at
some point (such as when memory pressure is high) to reclaim more
memory.

To quickly identify these two types of pages, we have introduced a
pte_refcount for each PTE page. We put the mapped and zero PTE entry
counter into the pte_refcount of the PTE page. The bitmask has the
following meaning:

 - bits 0-9 are mapped PTE entry count
 - bits 10-19 are zero PTE entry count

Because the mapping and unmapping of PTE entries are under pte_lock,
there is no concurrent thread to modify pte_refcount, so pte_refcount
can be a non-atomic variable with little performance overhead.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h       |  2 ++
 include/linux/mm_types.h |  1 +
 include/linux/pte_ref.h  | 23 +++++++++++++
 mm/Makefile              |  2 +-
 mm/pte_ref.c             | 72 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/pte_ref.h
 create mode 100644 mm/pte_ref.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7898e29bcfb5..23e2f1e75b4b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -28,6 +28,7 @@
 #include <linux/sched.h>
 #include <linux/pgtable.h>
 #include <linux/kasan.h>
+#include <linux/pte_ref.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -2336,6 +2337,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
+	pte_ref_init(page);
 	return true;
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c29ab4c0cd5c..da2738f87737 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -153,6 +153,7 @@ struct page {
 			union {
 				struct mm_struct *pt_mm; /* x86 pgds only */
 				atomic_t pt_frag_refcount; /* powerpc */
+				unsigned long pte_refcount; /* only for PTE page */
 			};
 #if ALLOC_SPLIT_PTLOCKS
 			spinlock_t *ptl;
diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
new file mode 100644
index 000000000000..db14e03e1dff
--- /dev/null
+++ b/include/linux/pte_ref.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, ByteDance. All rights reserved.
+ *
+ * 	Author: Qi Zheng <zhengqi.arch@bytedance.com>
+ */
+
+#ifndef _LINUX_PTE_REF_H
+#define _LINUX_PTE_REF_H
+
+#ifdef CONFIG_FREE_USER_PTE
+
+void pte_ref_init(pgtable_t pte);
+
+#else /* !CONFIG_FREE_USER_PTE */
+
+static inline void pte_ref_init(pgtable_t pte)
+{
+}
+
+#endif /* CONFIG_FREE_USER_PTE */
+
+#endif /* _LINUX_PTE_REF_H */
diff --git a/mm/Makefile b/mm/Makefile
index 6f9ffa968a1a..f8fa5078a13d 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -54,7 +54,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o percpu.o slab_common.o \
 			   compaction.o vmacache.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o mmap_lock.o $(mmu-y)
+			   debug.o gup.o mmap_lock.o $(mmu-y) pte_ref.o
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
new file mode 100644
index 000000000000..12b27646e88c
--- /dev/null
+++ b/mm/pte_ref.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, ByteDance. All rights reserved.
+ *
+ * 	Author: Qi Zheng <zhengqi.arch@bytedance.com>
+ */
+#include <linux/pgtable.h>
+#include <linux/pte_ref.h>
+
+#ifdef CONFIG_FREE_USER_PTE
+
+/*
+ * For a PTE page where all entries are empty, we call it empty PTE page. For a
+ * PTE page where all page table entries are mapped to zero pages, we call it
+ * zero PTE page.
+ *
+ * The page table entries for both types of PTE pages do not record "meaningful"
+ * information, so we can try to free these PTE pages at some point (such as
+ * when memory pressure is high) to reclaim more memory.
+ *
+ * We put the mapped and zero PTE entry counter into the pte_refcount of the
+ * PTE page. The bitmask has the following meaning:
+ *
+ * - bits 0-9 are mapped PTE entry count
+ * - bits 10-19 are zero PTE entry count
+ *
+ * Because the mapping and unmapping of PTE entries are under pte_lock, there is
+ * no concurrent thread to modify pte_refcount, so pte_refcount can be a
+ * non-atomic variable with little performance overhead.
+ */
+#define PTE_MAPPED_BITS		10
+#define PTE_ZERO_BITS		10
+
+#define PTE_MAPPED_SHIFT		0
+#define PTE_ZERO_SHIFT		(PTE_MAPPED_SHIFT + PTE_MAPPED_BITS)
+
+#define __PTE_REF_MASK(x)	((1UL << (x))-1)
+
+#define PTE_MAPPED_MASK	(__PTE_REF_MASK(PTE_MAPPED_BITS) << PTE_MAPPED_SHIFT)
+#define PTE_ZERO_MASK	(__PTE_REF_MASK(PTE_ZERO_BITS) << PTE_ZERO_SHIFT)
+
+#define PTE_MAPPED_OFFSET	(1UL << PTE_MAPPED_SHIFT)
+#define PTE_ZERO_OFFSET		(1UL << PTE_ZERO_SHIFT)
+
+static inline unsigned long pte_refcount(pgtable_t pte)
+{
+	return pte->pte_refcount;
+}
+
+#define pte_mapped_count(pte) \
+	((pte_refcount(pte) & PTE_MAPPED_MASK) >> PTE_MAPPED_SHIFT)
+#define pte_zero_count(pte) \
+	((pte_refcount(pte) & PTE_ZERO_MASK) >> PTE_ZERO_SHIFT)
+
+static __always_inline void pte_refcount_add(struct mm_struct *mm,
+					     pgtable_t pte, int val)
+{
+	pte->pte_refcount += val;
+}
+
+static __always_inline void pte_refcount_sub(struct mm_struct *mm,
+					     pgtable_t pte, int val)
+{
+	pte->pte_refcount -= val;
+}
+
+void pte_ref_init(pgtable_t pte)
+{
+	pte->pte_refcount = 0;
+}
+
+#endif /* CONFIG_FREE_USER_PTE */
-- 
2.20.1

