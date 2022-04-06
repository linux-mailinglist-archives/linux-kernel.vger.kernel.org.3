Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239CF4F5ED8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiDFMxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiDFMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:51:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12314E0D3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:54:36 -0700 (PDT)
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KYJGR422hz1HBWw;
        Wed,  6 Apr 2022 16:54:07 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 16:54:33 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 16:54:32 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [RFC PATCH -next V2 6/7] arm64: add cow to machine check safe
Date:   Wed, 6 Apr 2022 09:13:10 +0000
Message-ID: <20220406091311.3354723-7-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220406091311.3354723-1-tongtiangen@huawei.com>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the cow(copy on write) processing, the data of the user process is
copied, when machine check error is encountered during copy, killing
the user process and isolate the user page with hardware memory errors
is a more reasonable choice than kernel panic.

The copy_page_mc() in copy_page_mc.S is largely borrows from
copy_page() in copy_page.S and the main difference is copy_page_mc()
add the extable entry to support machine check safe.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/include/asm/page.h | 10 ++++
 arch/arm64/lib/Makefile       |  2 +
 arch/arm64/lib/copy_page_mc.S | 98 +++++++++++++++++++++++++++++++++++
 arch/arm64/mm/copypage.c      | 36 ++++++++++---
 include/linux/highmem.h       |  8 +++
 mm/memory.c                   |  2 +-
 6 files changed, 149 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/lib/copy_page_mc.S

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 993a27ea6f54..832571a7dddb 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -29,6 +29,16 @@ void copy_user_highpage(struct page *to, struct page *from,
 void copy_highpage(struct page *to, struct page *from);
 #define __HAVE_ARCH_COPY_HIGHPAGE
 
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+extern void copy_page_mc(void *to, const void *from);
+void copy_highpage_mc(struct page *to, struct page *from);
+#define __HAVE_ARCH_COPY_HIGHPAGE_MC
+
+void copy_user_highpage_mc(struct page *to, struct page *from,
+		unsigned long vaddr, struct vm_area_struct *vma);
+#define __HAVE_ARCH_COPY_USER_HIGHPAGE_MC
+#endif
+
 struct page *alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
 						unsigned long vaddr);
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE_MOVABLE
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 29490be2546b..29c578414b12 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -22,3 +22,5 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 obj-$(CONFIG_ARM64_MTE) += mte.o
 
 obj-$(CONFIG_KASAN_SW_TAGS) += kasan_sw_tags.o
+
+obj-$(CONFIG_ARCH_HAS_CPY_MC) += copy_page_mc.o
diff --git a/arch/arm64/lib/copy_page_mc.S b/arch/arm64/lib/copy_page_mc.S
new file mode 100644
index 000000000000..cbf56e661efe
--- /dev/null
+++ b/arch/arm64/lib/copy_page_mc.S
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#include <linux/linkage.h>
+#include <linux/const.h>
+#include <asm/assembler.h>
+#include <asm/page.h>
+#include <asm/cpufeature.h>
+#include <asm/alternative.h>
+
+/*
+ * Copy a page from src to dest (both are page aligned) with machine check
+ *
+ * Parameters:
+ *	x0 - dest
+ *	x1 - src
+ */
+SYM_FUNC_START(__pi_copy_page_mc)
+alternative_if ARM64_HAS_NO_HW_PREFETCH
+	// Prefetch three cache lines ahead.
+	prfm	pldl1strm, [x1, #128]
+	prfm	pldl1strm, [x1, #256]
+	prfm	pldl1strm, [x1, #384]
+alternative_else_nop_endif
+
+100:	ldp	x2, x3, [x1]
+101:	ldp	x4, x5, [x1, #16]
+102:	ldp	x6, x7, [x1, #32]
+103:	ldp	x8, x9, [x1, #48]
+104:	ldp	x10, x11, [x1, #64]
+105:	ldp	x12, x13, [x1, #80]
+106:	ldp	x14, x15, [x1, #96]
+107:	ldp	x16, x17, [x1, #112]
+
+	add	x0, x0, #256
+	add	x1, x1, #128
+1:
+	tst	x0, #(PAGE_SIZE - 1)
+
+alternative_if ARM64_HAS_NO_HW_PREFETCH
+	prfm	pldl1strm, [x1, #384]
+alternative_else_nop_endif
+
+	stnp	x2, x3, [x0, #-256]
+200:	ldp	x2, x3, [x1]
+	stnp	x4, x5, [x0, #16 - 256]
+201:	ldp	x4, x5, [x1, #16]
+	stnp	x6, x7, [x0, #32 - 256]
+202:	ldp	x6, x7, [x1, #32]
+	stnp	x8, x9, [x0, #48 - 256]
+203:	ldp	x8, x9, [x1, #48]
+	stnp	x10, x11, [x0, #64 - 256]
+204:	ldp	x10, x11, [x1, #64]
+	stnp	x12, x13, [x0, #80 - 256]
+205:	ldp	x12, x13, [x1, #80]
+	stnp	x14, x15, [x0, #96 - 256]
+206:	ldp	x14, x15, [x1, #96]
+	stnp	x16, x17, [x0, #112 - 256]
+207:	ldp	x16, x17, [x1, #112]
+
+	add	x0, x0, #128
+	add	x1, x1, #128
+
+	b.ne	1b
+
+	stnp	x2, x3, [x0, #-256]
+	stnp	x4, x5, [x0, #16 - 256]
+	stnp	x6, x7, [x0, #32 - 256]
+	stnp	x8, x9, [x0, #48 - 256]
+	stnp	x10, x11, [x0, #64 - 256]
+	stnp	x12, x13, [x0, #80 - 256]
+	stnp	x14, x15, [x0, #96 - 256]
+	stnp	x16, x17, [x0, #112 - 256]
+
+300:	ret
+
+_asm_extable_mc 100b, 300b
+_asm_extable_mc 101b, 300b
+_asm_extable_mc 102b, 300b
+_asm_extable_mc 103b, 300b
+_asm_extable_mc 104b, 300b
+_asm_extable_mc 105b, 300b
+_asm_extable_mc 106b, 300b
+_asm_extable_mc 107b, 300b
+_asm_extable_mc 200b, 300b
+_asm_extable_mc 201b, 300b
+_asm_extable_mc 202b, 300b
+_asm_extable_mc 203b, 300b
+_asm_extable_mc 204b, 300b
+_asm_extable_mc 205b, 300b
+_asm_extable_mc 206b, 300b
+_asm_extable_mc 207b, 300b
+
+SYM_FUNC_END(__pi_copy_page_mc)
+SYM_FUNC_ALIAS(copy_page_mc, __pi_copy_page_mc)
+EXPORT_SYMBOL(copy_page_mc)
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 0dea80bf6de4..0f28edfcb234 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -14,13 +14,8 @@
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
 
-void copy_highpage(struct page *to, struct page *from)
+static void do_mte(struct page *to, struct page *from, void *kto, void *kfrom)
 {
-	void *kto = page_address(to);
-	void *kfrom = page_address(from);
-
-	copy_page(kto, kfrom);
-
 	if (system_supports_mte() && test_bit(PG_mte_tagged, &from->flags)) {
 		set_bit(PG_mte_tagged, &to->flags);
 		page_kasan_tag_reset(to);
@@ -35,6 +30,15 @@ void copy_highpage(struct page *to, struct page *from)
 		mte_copy_page_tags(kto, kfrom);
 	}
 }
+
+void copy_highpage(struct page *to, struct page *from)
+{
+	void *kto = page_address(to);
+	void *kfrom = page_address(from);
+
+	copy_page(kto, kfrom);
+	do_mte(to, from, kto, kfrom);
+}
 EXPORT_SYMBOL(copy_highpage);
 
 void copy_user_highpage(struct page *to, struct page *from,
@@ -44,3 +48,23 @@ void copy_user_highpage(struct page *to, struct page *from,
 	flush_dcache_page(to);
 }
 EXPORT_SYMBOL_GPL(copy_user_highpage);
+
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+void copy_highpage_mc(struct page *to, struct page *from)
+{
+	void *kto = page_address(to);
+	void *kfrom = page_address(from);
+
+	copy_page_mc(kto, kfrom);
+	do_mte(to, from, kto, kfrom);
+}
+EXPORT_SYMBOL(copy_highpage_mc);
+
+void copy_user_highpage_mc(struct page *to, struct page *from,
+			unsigned long vaddr, struct vm_area_struct *vma)
+{
+	copy_highpage_mc(to, from);
+	flush_dcache_page(to);
+}
+EXPORT_SYMBOL_GPL(copy_user_highpage_mc);
+#endif
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 39bb9b47fa9c..a9dbf331b038 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -283,6 +283,10 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
 
 #endif
 
+#ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE_MC
+#define copy_user_highpage_mc copy_user_highpage
+#endif
+
 #ifndef __HAVE_ARCH_COPY_HIGHPAGE
 
 static inline void copy_highpage(struct page *to, struct page *from)
@@ -298,6 +302,10 @@ static inline void copy_highpage(struct page *to, struct page *from)
 
 #endif
 
+#ifndef __HAVE_ARCH_COPY_HIGHPAGE_MC
+#define cop_highpage_mc copy_highpage
+#endif
+
 static inline void memcpy_page(struct page *dst_page, size_t dst_off,
 			       struct page *src_page, size_t src_off,
 			       size_t len)
diff --git a/mm/memory.c b/mm/memory.c
index 76e3af9639d9..d5f62234152d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2767,7 +2767,7 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 	unsigned long addr = vmf->address;
 
 	if (likely(src)) {
-		copy_user_highpage(dst, src, addr, vma);
+		copy_user_highpage_mc(dst, src, addr, vma);
 		return true;
 	}
 
-- 
2.18.0.huawei.25

