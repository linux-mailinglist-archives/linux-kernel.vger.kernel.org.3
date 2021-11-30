Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12303464111
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344713AbhK3WNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:13:55 -0500
Received: from out1.migadu.com ([91.121.223.63]:58273 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344582AbhK3WLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:11:20 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638310079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kpH+33k/GfROSS5YE3KBLshkOEFVObuKhNsDDFbF7nk=;
        b=EI9KMQ0FE2Lga3NDzFUbaaJ4h/QgEzQUWHGYegJ9U1GdIRaVRw6aRTZkgZC9HJreyXnPis
        44n3p7Z+73FtjBBI40KCmU/QGO5IR2KeRiV4AhMD/4sMp//KWNEUuYQN4V5AEhoJumX3cd
        qswX90tNF0TxfaZ5a+vJUDUwuoIlXcg=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 24/31] kasan, vmalloc, arm64: mark vmalloc mappings as pgprot_tagged
Date:   Tue, 30 Nov 2021 23:07:56 +0100
Message-Id: <8557e32739e38d3cdf409789c2b3e1b405c743f4.1638308023.git.andreyknvl@google.com>
In-Reply-To: <cover.1638308023.git.andreyknvl@google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
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

This change adds proper protection bits to vmalloc() allocations.
These allocations are always backed by page_alloc pages, so the tags
will actually be getting set on the corresponding physical memory.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/vmalloc.h | 10 ++++++++++
 include/linux/vmalloc.h          |  7 +++++++
 mm/vmalloc.c                     |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index b9185503feae..3d35adf365bf 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -25,4 +25,14 @@ static inline bool arch_vmap_pmd_supported(pgprot_t prot)
 
 #endif
 
+#define arch_vmalloc_pgprot_modify arch_vmalloc_pgprot_modify
+static inline pgprot_t arch_vmalloc_pgprot_modify(pgprot_t prot)
+{
+	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&
+			(pgprot_val(prot) == pgprot_val(PAGE_KERNEL)))
+		prot = pgprot_tagged(prot);
+
+	return prot;
+}
+
 #endif /* _ASM_ARM64_VMALLOC_H */
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index b22369f540eb..965c4bf475f1 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -108,6 +108,13 @@ static inline int arch_vmap_pte_supported_shift(unsigned long size)
 }
 #endif
 
+#ifndef arch_vmalloc_pgprot_modify
+static inline pgprot_t arch_vmalloc_pgprot_modify(pgprot_t prot)
+{
+	return prot;
+}
+#endif
+
 /*
  *	Highlevel APIs for driver use
  */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7be18b292679..f37d0ed99bf9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3033,6 +3033,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		return NULL;
 	}
 
+	prot = arch_vmalloc_pgprot_modify(prot);
+
 	if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP)) {
 		unsigned long size_per_node;
 
-- 
2.25.1

