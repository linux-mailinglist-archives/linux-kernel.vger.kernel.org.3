Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A656349800D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242790AbiAXM6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:58:00 -0500
Received: from foss.arm.com ([217.140.110.172]:32994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242240AbiAXM5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:57:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DECD101E;
        Mon, 24 Jan 2022 04:57:54 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A56F13F774;
        Mon, 24 Jan 2022 04:57:51 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V1 11/31] mm/mmap: Drop protection_map[]
Date:   Mon, 24 Jan 2022 18:26:48 +0530
Message-Id: <1643029028-12710-12-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no other users for protection_map[]. Hence just drop this array
construct and instead define __vm_get_page_prot() which will provide page
protection map based on vm_flags combination switch.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mm.h |  6 -----
 mm/mmap.c          | 61 +++++++++++++++++++++++++++++++---------------
 2 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e1a84b1e6787..6c0844b99b3e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -418,12 +418,6 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
 
-/*
- * mapping from the currently active vm_flags protection bits (the
- * low four bits) to a page protection mask..
- */
-extern pgprot_t protection_map[16];
-
 /*
  * The default fault flags that should be used by most of the
  * arch-specific page fault handlers.
diff --git a/mm/mmap.c b/mm/mmap.c
index ec403de32dcb..f61f74a61f62 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -102,24 +102,6 @@ static void unmap_region(struct mm_struct *mm,
  *								w: (no) no
  *								x: (yes) yes
  */
-pgprot_t protection_map[16] __ro_after_init = {
-	[VM_NONE]				= __P000,
-	[VM_READ]				= __P001,
-	[VM_WRITE]				= __P010,
-	[VM_READ|VM_WRITE]			= __P011,
-	[VM_EXEC]				= __P100,
-	[VM_EXEC|VM_READ]			= __P101,
-	[VM_EXEC|VM_WRITE]			= __P110,
-	[VM_EXEC|VM_READ|VM_WRITE]		= __P111,
-	[VM_SHARED]				= __S000,
-	[VM_SHARED|VM_READ]			= __S001,
-	[VM_SHARED|VM_WRITE]			= __S010,
-	[VM_SHARED|VM_READ|VM_WRITE]		= __S011,
-	[VM_SHARED|VM_EXEC]			= __S100,
-	[VM_SHARED|VM_READ|VM_EXEC]		= __S101,
-	[VM_SHARED|VM_WRITE|VM_EXEC]		= __S110,
-	[VM_SHARED|VM_READ|VM_WRITE|VM_EXEC]	= __S111
-};
 
 #ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
 static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
@@ -128,10 +110,49 @@ static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
 }
 #endif
 
+static inline pgprot_t __vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return __P000;
+	case VM_READ:
+		return __P001;
+	case VM_WRITE:
+		return __P010;
+	case VM_READ | VM_WRITE:
+		return __P011;
+	case VM_EXEC:
+		return __P100;
+	case VM_EXEC | VM_READ:
+		return __P101;
+	case VM_EXEC | VM_WRITE:
+		return __P110;
+	case VM_EXEC | VM_READ | VM_WRITE:
+		return __P111;
+	case VM_SHARED:
+		return __S000;
+	case VM_SHARED | VM_READ:
+		return __S001;
+	case VM_SHARED | VM_WRITE:
+		return __S010;
+	case VM_SHARED | VM_READ | VM_WRITE:
+		return __S011;
+	case VM_SHARED | VM_EXEC:
+		return __S100;
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return __S101;
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+		return __S110;
+	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
+		return __S111;
+	default:
+		BUILD_BUG();
+	}
+}
+
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
-	pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
-				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
+	pgprot_t ret = __pgprot(pgprot_val(__vm_get_page_prot(vm_flags)) |
 			pgprot_val(arch_vm_get_page_prot(vm_flags)));
 
 	return arch_filter_pgprot(ret);
-- 
2.25.1

