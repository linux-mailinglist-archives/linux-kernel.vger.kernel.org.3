Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0330C498016
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242818AbiAXM60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:58:26 -0500
Received: from foss.arm.com ([217.140.110.172]:33084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242832AbiAXM6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:58:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C05D101E;
        Mon, 24 Jan 2022 04:58:18 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 666CB3F7F5;
        Mon, 24 Jan 2022 04:58:14 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [RFC V1 17/31] sh/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 24 Jan 2022 18:26:54 +0530
Message-Id: <1643029028-12710-18-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/sh/Kconfig               |  1 +
 arch/sh/include/asm/pgtable.h | 17 --------------
 arch/sh/mm/mmap.c             | 43 +++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 2474a04ceac4..f3fcd1c5e002 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -11,6 +11,7 @@ config SUPERH
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
index d7ddb1ec86a0..6fb9ec54cf9b 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -89,23 +89,6 @@ static inline unsigned long phys_addr_mask(void)
  * completely separate permission bits for user and kernel space.
  */
 	 /*xwr*/
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
-#define __P100	PAGE_EXECREAD
-#define __P101	PAGE_EXECREAD
-#define __P110	PAGE_COPY
-#define __P111	PAGE_COPY
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_WRITEONLY
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_EXECREAD
-#define __S101	PAGE_EXECREAD
-#define __S110	PAGE_RWX
-#define __S111	PAGE_RWX
 
 typedef pte_t *pte_addr_t;
 
diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index 6a1a1297baae..21b3fae77a4e 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -162,3 +162,46 @@ int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 {
 	return 1;
 }
+
+#ifdef CONFIG_MMU
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return PAGE_NONE;
+	case VM_READ:
+		return PAGE_READONLY;
+	case VM_WRITE:
+		return PAGE_COPY;
+	case VM_READ | VM_WRITE:
+		return PAGE_COPY;
+	case VM_EXEC:
+		return PAGE_EXECREAD;
+	case VM_EXEC | VM_READ:
+		return PAGE_EXECREAD;
+	case VM_EXEC | VM_WRITE:
+		return PAGE_COPY;
+	case VM_EXEC | VM_READ | VM_WRITE:
+		return PAGE_COPY;
+	case VM_SHARED:
+		return PAGE_COPY;
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
+#endif
-- 
2.25.1

