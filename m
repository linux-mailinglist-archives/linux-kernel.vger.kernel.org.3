Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2DE498028
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbiAXM7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:59:04 -0500
Received: from foss.arm.com ([217.140.110.172]:33216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242838AbiAXM6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:58:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE5EB113E;
        Mon, 24 Jan 2022 04:58:50 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D882F3F774;
        Mon, 24 Jan 2022 04:58:47 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [RFC V1 25/31] nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 24 Jan 2022 18:27:02 +0530
Message-Id: <1643029028-12710-26-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed.

Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/nios2/Kconfig               |  1 +
 arch/nios2/include/asm/pgtable.h | 16 -------------
 arch/nios2/mm/init.c             | 41 ++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 33fd06f5fa41..85a58a357a3b 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -6,6 +6,7 @@ config NIOS2
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_DMA_SET_UNCACHED
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_NO_SWAP
 	select COMMON_CLK
 	select TIMER_OF
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index 4a995fa628ee..2678dad58a63 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -40,24 +40,8 @@ struct mm_struct;
  */
 
 /* Remove W bit on private pages for COW support */
-#define __P000	MKP(0, 0, 0)
-#define __P001	MKP(0, 0, 1)
-#define __P010	MKP(0, 0, 0)	/* COW */
-#define __P011	MKP(0, 0, 1)	/* COW */
-#define __P100	MKP(1, 0, 0)
-#define __P101	MKP(1, 0, 1)
-#define __P110	MKP(1, 0, 0)	/* COW */
-#define __P111	MKP(1, 0, 1)	/* COW */
 
 /* Shared pages can have exact HW mapping */
-#define __S000	MKP(0, 0, 0)
-#define __S001	MKP(0, 0, 1)
-#define __S010	MKP(0, 1, 0)
-#define __S011	MKP(0, 1, 1)
-#define __S100	MKP(1, 0, 0)
-#define __S101	MKP(1, 0, 1)
-#define __S110	MKP(1, 1, 0)
-#define __S111	MKP(1, 1, 1)
 
 /* Used all over the kernel */
 #define PAGE_KERNEL __pgprot(_PAGE_PRESENT | _PAGE_CACHED | _PAGE_READ | \
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index 613fcaa5988a..4f8251e62f31 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -124,3 +124,44 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 {
 	return (vma->vm_start == KUSER_BASE) ? "[kuser]" : NULL;
 }
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return MKP(0, 0, 0);
+	case VM_READ:
+		return MKP(0, 0, 1);
+	case VM_WRITE:
+		return MKP(0, 0, 0);
+	case VM_READ | VM_WRITE:
+		return MKP(0, 0, 1);
+	case VM_EXEC:
+		return MKP(1, 0, 0);
+	case VM_EXEC | VM_READ:
+		return MKP(1, 0, 1);
+	case VM_EXEC | VM_WRITE:
+		return MKP(1, 0, 0);
+	case VM_EXEC | VM_READ | VM_WRITE:
+		return MKP(1, 0, 1);
+	case VM_SHARED:
+		return MKP(0, 0, 0);
+	case VM_SHARED | VM_READ:
+		return MKP(0, 0, 1);
+	case VM_SHARED | VM_WRITE:
+		return MKP(0, 1, 0);
+	case VM_SHARED | VM_READ | VM_WRITE:
+		return MKP(0, 1, 1);
+	case VM_SHARED | VM_EXEC:
+		return MKP(1, 0, 0);
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return MKP(1, 0, 1);
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+		return MKP(1, 1, 0);
+	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
+		return MKP(1, 1, 1);
+	default:
+		BUILD_BUG();
+	}
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1

