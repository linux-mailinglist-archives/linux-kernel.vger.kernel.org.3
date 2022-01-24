Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E26A498011
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242829AbiAXM6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:58:09 -0500
Received: from foss.arm.com ([217.140.110.172]:33032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242794AbiAXM6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:58:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73214101E;
        Mon, 24 Jan 2022 04:58:05 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93EF23F774;
        Mon, 24 Jan 2022 04:58:01 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [RFC V1 14/31] s390/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 24 Jan 2022 18:26:51 +0530
Message-Id: <1643029028-12710-15-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/s390/Kconfig               |  1 +
 arch/s390/include/asm/pgtable.h | 17 --------------
 arch/s390/mm/mmap.c             | 41 +++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9750f92380f5..83d1e0e3c762 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -78,6 +78,7 @@ config S390
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_VDSO_DATA
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK
 	select ARCH_INLINE_READ_LOCK_BH
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 008a6c856fa4..3893ef64b439 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -422,23 +422,6 @@ static inline int is_module_addr(void *addr)
  * implies read permission.
  */
          /*xwr*/
-#define __P000	PAGE_NONE
-#define __P001	PAGE_RO
-#define __P010	PAGE_RO
-#define __P011	PAGE_RO
-#define __P100	PAGE_RX
-#define __P101	PAGE_RX
-#define __P110	PAGE_RX
-#define __P111	PAGE_RX
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_RO
-#define __S010	PAGE_RW
-#define __S011	PAGE_RW
-#define __S100	PAGE_RX
-#define __S101	PAGE_RX
-#define __S110	PAGE_RWX
-#define __S111	PAGE_RWX
 
 /*
  * Segment entry (large page) protection definitions.
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index e54f928503c5..5b15469eef7a 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -188,3 +188,44 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 	}
 }
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return PAGE_NONE;
+	case VM_READ:
+		return PAGE_RO;
+	case VM_WRITE:
+		return PAGE_RO;
+	case VM_READ | VM_WRITE:
+		return PAGE_RO;
+	case VM_EXEC:
+		return PAGE_RX;
+	case VM_EXEC | VM_READ:
+		return PAGE_RX;
+	case VM_EXEC | VM_WRITE:
+		return PAGE_RX;
+	case VM_EXEC | VM_READ | VM_WRITE:
+		return PAGE_RX;
+	case VM_SHARED:
+		return PAGE_NONE;
+	case VM_SHARED | VM_READ:
+		return PAGE_RO;
+	case VM_SHARED | VM_WRITE:
+		return PAGE_RW;
+	case VM_SHARED | VM_READ | VM_WRITE:
+		return PAGE_RW;
+	case VM_SHARED | VM_EXEC:
+		return PAGE_RX;
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return PAGE_RX;
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

