Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E179498026
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiAXM66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:58:58 -0500
Received: from foss.arm.com ([217.140.110.172]:33200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239714AbiAXM6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:58:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D65C113E;
        Mon, 24 Jan 2022 04:58:47 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 181AD3F774;
        Mon, 24 Jan 2022 04:58:43 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Simek <monstr@monstr.eu>
Subject: [RFC V1 24/31] microblaze/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 24 Jan 2022 18:27:01 +0530
Message-Id: <1643029028-12710-25-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed.

Cc: Michal Simek <monstr@monstr.eu>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/microblaze/Kconfig               |  1 +
 arch/microblaze/include/asm/pgtable.h | 17 -----------
 arch/microblaze/mm/init.c             | 41 +++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 59798e43cdb0..f2c25ba8621e 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -7,6 +7,7 @@ config MICROBLAZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index c136a01e467e..6df373077ff2 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -204,23 +204,6 @@ extern pte_t *va_to_pte(unsigned long address);
  * We consider execute permission the same as read.
  * Also, write permissions imply read permissions.
  */
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY_X
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY_X
-#define __P100	PAGE_READONLY
-#define __P101	PAGE_READONLY_X
-#define __P110	PAGE_COPY
-#define __P111	PAGE_COPY_X
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY_X
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED_X
-#define __S100	PAGE_READONLY
-#define __S101	PAGE_READONLY_X
-#define __S110	PAGE_SHARED
-#define __S111	PAGE_SHARED_X
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 952f35b335b2..40bc28f86144 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -280,3 +280,44 @@ void * __ref zalloc_maybe_bootmem(size_t size, gfp_t mask)
 
 	return p;
 }
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return PAGE_NONE;
+	case VM_READ:
+		return PAGE_READONLY_X;
+	case VM_WRITE:
+		return PAGE_COPY;
+	case VM_READ | VM_WRITE:
+		return PAGE_COPY_X;
+	case VM_EXEC:
+		return PAGE_READONLY;
+	case VM_EXEC | VM_READ:
+		return PAGE_READONLY_X;
+	case VM_EXEC | VM_WRITE:
+		return PAGE_COPY;
+	case VM_EXEC | VM_READ | VM_WRITE:
+		return PAGE_COPY_X;
+	case VM_SHARED:
+		return PAGE_NONE;
+	case VM_SHARED | VM_READ:
+		return PAGE_READONLY_X;
+	case VM_SHARED | VM_WRITE:
+		return PAGE_SHARED;
+	case VM_SHARED | VM_READ | VM_WRITE:
+		return PAGE_SHARED_X;
+	case VM_SHARED | VM_EXEC:
+		return PAGE_READONLY;
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return PAGE_READONLY_X;
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+		return PAGE_SHARED;
+	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
+		return PAGE_SHARED_X;
+	default:
+		BUILD_BUG();
+	}
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1

