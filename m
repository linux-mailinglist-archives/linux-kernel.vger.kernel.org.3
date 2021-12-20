Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357AD47B5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhLTWCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:02:21 -0500
Received: from out1.migadu.com ([91.121.223.63]:42512 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230422AbhLTWCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:02:19 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640037737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ho5qbW7O219QsLiwx5Xou5YZAD5IzYuW6GA8zK8d5vQ=;
        b=tto1+4+sUargP6o1mB5OnI2qfI1eCAbqKLOFIcX4yZIloI4P6kXUdFvsBmO0kVtf4pR5jt
        s5CyDKL4PInrZENvK5/444aQPsERa0SrGX5b/vEt/ephbUHHVtUTKrxsXFu7udiwUIo67R
        Z3UPtlhMIjJrktFIPTyJXZghqUDdz9w=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v4 25/39] kasan, vmalloc, arm64: mark vmalloc mappings as pgprot_tagged
Date:   Mon, 20 Dec 2021 23:01:57 +0100
Message-Id: <606f72fd9b51eb790d11cb2d0dc4ee4eeac864b2.1640036051.git.andreyknvl@google.com>
In-Reply-To: <cover.1640036051.git.andreyknvl@google.com>
References: <cover.1640036051.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

HW_TAGS KASAN relies on ARM Memory Tagging Extension (MTE). With MTE,
a memory region must be mapped as MT_NORMAL_TAGGED to allow setting
memory tags via MTE-specific instructions.

Add proper protection bits to vmalloc() allocations. These allocations
are always backed by page_alloc pages, so the tags will actually be
getting set on the corresponding physical memory.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

---

Changes v3->v4:
- Rename arch_vmalloc_pgprot_modify() to arch_vmap_pgprot_tagged()
  to be consistent with other arch vmalloc hooks.
- Move checks from arch_vmap_pgprot_tagged() to __vmalloc_node_range()
  as the same condition is used for other things in subsequent patches.

Changes v2->v3:
- Update patch description.
---
 arch/arm64/include/asm/vmalloc.h | 6 ++++++
 include/linux/vmalloc.h          | 7 +++++++
 mm/vmalloc.c                     | 9 +++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index b9185503feae..38fafffe699f 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -25,4 +25,10 @@ static inline bool arch_vmap_pmd_supported(pgprot_t prot)
 
 #endif
 
+#define arch_vmap_pgprot_tagged arch_vmap_pgprot_tagged
+static inline pgprot_t arch_vmap_pgprot_tagged(pgprot_t prot)
+{
+	return pgprot_tagged(prot);
+}
+
 #endif /* _ASM_ARM64_VMALLOC_H */
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 34ac66a656d4..0dc02a688207 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -115,6 +115,13 @@ static inline int arch_vmap_pte_supported_shift(unsigned long size)
 }
 #endif
 
+#ifndef arch_vmap_pgprot_tagged
+static inline pgprot_t arch_vmap_pgprot_tagged(pgprot_t prot)
+{
+	return prot;
+}
+#endif
+
 /*
  *	Highlevel APIs for driver use
  */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c0985f74c0c1..388a17c01376 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3102,6 +3102,15 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		goto fail;
 	}
 
+	/*
+	 * Modify protection bits to allow tagging.
+	 * This must be done before mapping by __vmalloc_area_node().
+	 */
+	if (kasan_hw_tags_enabled() &&
+	    pgprot_val(prot) == pgprot_val(PAGE_KERNEL))
+		prot = arch_vmap_pgprot_tagged(prot);
+
+	/* Allocate physical pages and map them into vmalloc space. */
 	addr = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
 	if (!addr)
 		goto fail;
-- 
2.25.1

