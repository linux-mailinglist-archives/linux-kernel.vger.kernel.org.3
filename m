Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A90E49802B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242986AbiAXM7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:59:14 -0500
Received: from foss.arm.com ([217.140.110.172]:33250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242878AbiAXM67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:58:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF1D7113E;
        Mon, 24 Jan 2022 04:58:58 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D46AE3F774;
        Mon, 24 Jan 2022 04:58:55 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Nick Hu <nickhu@andestech.com>
Subject: [RFC V1 27/31] nds32/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 24 Jan 2022 18:27:04 +0530
Message-Id: <1643029028-12710-28-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed.

Cc: Nick Hu <nickhu@andestech.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/nds32/Kconfig               |  1 +
 arch/nds32/include/asm/pgtable.h | 17 -------------
 arch/nds32/mm/mmap.c             | 41 ++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 4d1421b18734..576e05479925 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -10,6 +10,7 @@ config NDS32
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_WANT_FRAME_POINTERS if FTRACE
 	select CLKSRC_MMIO
 	select CLONE_BACKWARDS
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index 419f984eef70..79f64ed734cb 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -152,23 +152,6 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 #endif /* __ASSEMBLY__ */
 
 /*         xwr */
-#define __P000  (PAGE_NONE | _PAGE_CACHE_SHRD)
-#define __P001  (PAGE_READ | _PAGE_CACHE_SHRD)
-#define __P010  (PAGE_COPY | _PAGE_CACHE_SHRD)
-#define __P011  (PAGE_COPY | _PAGE_CACHE_SHRD)
-#define __P100  (PAGE_EXEC | _PAGE_CACHE_SHRD)
-#define __P101  (PAGE_READ | _PAGE_E | _PAGE_CACHE_SHRD)
-#define __P110  (PAGE_COPY | _PAGE_E | _PAGE_CACHE_SHRD)
-#define __P111  (PAGE_COPY | _PAGE_E | _PAGE_CACHE_SHRD)
-
-#define __S000  (PAGE_NONE | _PAGE_CACHE_SHRD)
-#define __S001  (PAGE_READ | _PAGE_CACHE_SHRD)
-#define __S010  (PAGE_RDWR | _PAGE_CACHE_SHRD)
-#define __S011  (PAGE_RDWR | _PAGE_CACHE_SHRD)
-#define __S100  (PAGE_EXEC | _PAGE_CACHE_SHRD)
-#define __S101  (PAGE_READ | _PAGE_E | _PAGE_CACHE_SHRD)
-#define __S110  (PAGE_RDWR | _PAGE_E | _PAGE_CACHE_SHRD)
-#define __S111  (PAGE_RDWR | _PAGE_E | _PAGE_CACHE_SHRD)
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/nds32/mm/mmap.c b/arch/nds32/mm/mmap.c
index 1bdf5e7d1b43..bfb3929d634a 100644
--- a/arch/nds32/mm/mmap.c
+++ b/arch/nds32/mm/mmap.c
@@ -71,3 +71,44 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
 }
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return (PAGE_NONE | _PAGE_CACHE_SHRD);
+	case VM_READ:
+		return (PAGE_READ | _PAGE_CACHE_SHRD);
+	case VM_WRITE:
+		return (PAGE_COPY | _PAGE_CACHE_SHRD);
+	case VM_READ | VM_WRITE:
+		return (PAGE_COPY | _PAGE_CACHE_SHRD);
+	case VM_EXEC:
+		return (PAGE_EXEC | _PAGE_CACHE_SHRD);
+	case VM_EXEC | VM_READ:
+		return (PAGE_READ | _PAGE_E | _PAGE_CACHE_SHRD);
+	case VM_EXEC | VM_WRITE:
+		return (PAGE_COPY | _PAGE_E | _PAGE_CACHE_SHRD);
+	case VM_EXEC | VM_READ | VM_WRITE:
+		return (PAGE_COPY | _PAGE_E | _PAGE_CACHE_SHRD);
+	case VM_SHARED:
+		return (PAGE_NONE | _PAGE_CACHE_SHRD);
+	case VM_SHARED | VM_READ:
+		return (PAGE_READ | _PAGE_CACHE_SHRD);
+	case VM_SHARED | VM_WRITE:
+		return (PAGE_RDWR | _PAGE_CACHE_SHRD);
+	case VM_SHARED | VM_READ | VM_WRITE:
+		return (PAGE_RDWR | _PAGE_CACHE_SHRD);
+	case VM_SHARED | VM_EXEC:
+		return (PAGE_EXEC | _PAGE_CACHE_SHRD);
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return (PAGE_READ | _PAGE_E | _PAGE_CACHE_SHRD);
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+		return (PAGE_RDWR | _PAGE_E | _PAGE_CACHE_SHRD);
+	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
+		return (PAGE_RDWR | _PAGE_E | _PAGE_CACHE_SHRD);
+	default:
+		BUILD_BUG();
+	}
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1

