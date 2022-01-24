Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9174498021
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242793AbiAXM6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:58:45 -0500
Received: from foss.arm.com ([217.140.110.172]:33152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242855AbiAXM6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:58:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 949A0101E;
        Mon, 24 Jan 2022 04:58:35 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ACC1C3F774;
        Mon, 24 Jan 2022 04:58:31 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org
Subject: [RFC V1 21/31] parisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 24 Jan 2022 18:26:58 +0530
Message-Id: <1643029028-12710-22-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-parisc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/parisc/Kconfig               |  1 +
 arch/parisc/include/asm/pgtable.h | 20 ---------------
 arch/parisc/mm/init.c             | 41 +++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 43c1c880def6..de512f120b50 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -10,6 +10,7 @@ config PARISC
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_NO_SG_CHAIN
 	select ARCH_SUPPORTS_HUGETLBFS if PA20
 	select ARCH_SUPPORTS_MEMORY_FAILURE
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 3e7cf882639f..80d99b2b5913 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -269,26 +269,6 @@ extern void __update_cache(pte_t pte);
  * pages.
  */
 
-	 /*xwr*/
-#define __P000  PAGE_NONE
-#define __P001  PAGE_READONLY
-#define __P010  __P000 /* copy on write */
-#define __P011  __P001 /* copy on write */
-#define __P100  PAGE_EXECREAD
-#define __P101  PAGE_EXECREAD
-#define __P110  __P100 /* copy on write */
-#define __P111  __P101 /* copy on write */
-
-#define __S000  PAGE_NONE
-#define __S001  PAGE_READONLY
-#define __S010  PAGE_WRITEONLY
-#define __S011  PAGE_SHARED
-#define __S100  PAGE_EXECREAD
-#define __S101  PAGE_EXECREAD
-#define __S110  PAGE_RWX
-#define __S111  PAGE_RWX
-
-
 extern pgd_t swapper_pg_dir[]; /* declared in init_task.c */
 
 /* initial page tables for 0-8MB for kernel */
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 1ae31db9988f..c8316e97e1a2 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -866,3 +866,44 @@ void flush_tlb_all(void)
 	spin_unlock(&sid_lock);
 }
 #endif
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return PAGE_NONE;
+	case VM_READ:
+		return PAGE_READONLY;
+	case VM_WRITE:
+		return PAGE_NONE;
+	case VM_READ | VM_WRITE:
+		return PAGE_READONLY;
+	case VM_EXEC:
+		return PAGE_EXECREAD;
+	case VM_EXEC | VM_READ:
+		return PAGE_EXECREAD;
+	case VM_EXEC | VM_WRITE:
+		return PAGE_EXECREAD;
+	case VM_EXEC | VM_READ | VM_WRITE:
+		return PAGE_EXECREAD;
+	case VM_SHARED:
+		return PAGE_NONE;
+	case VM_SHARED | VM_READ:
+		return PAGE_READONLY;
+	case VM_SHARED | VM_WRITE:
+		return PAGE_WRITEONLY;
+	case VM_SHARED | VM_READ | VM_WRITE:
+		return PAGE_SHARED;
+	case VM_SHARED | VM_EXEC:
+		return PAGE_EXECREAD;
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return PAGE_EXECREAD;
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+		return PAGE_RWX;
+	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
+		return PAGE_RWX;
+	default:
+		BUILD_BUG();
+	}
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1

