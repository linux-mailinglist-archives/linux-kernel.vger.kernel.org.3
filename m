Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC04E498010
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242805AbiAXM6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:58:08 -0500
Received: from foss.arm.com ([217.140.110.172]:33018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242795AbiAXM6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:58:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1D2B101E;
        Mon, 24 Jan 2022 04:58:00 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F8F93F774;
        Mon, 24 Jan 2022 04:57:57 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V1 13/31] mm/mmap: Drop arch_vm_get_page_pgprot()
Date:   Mon, 24 Jan 2022 18:26:50 +0530
Message-Id: <1643029028-12710-14-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no platforms left which use arch_vm_get_page_prot(). Just drop
arch_vm_get_page_prot() construct and simplify remaining code.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mman.h |  4 ----
 mm/mmap.c            | 10 +---------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index b66e91b8176c..58b3abd457a3 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -93,10 +93,6 @@ static inline void vm_unacct_memory(long pages)
 #define arch_calc_vm_flag_bits(flags) 0
 #endif
 
-#ifndef arch_vm_get_page_prot
-#define arch_vm_get_page_prot(vm_flags) __pgprot(0)
-#endif
-
 #ifndef arch_validate_prot
 /*
  * This is called from mprotect().  PROT_GROWSDOWN and PROT_GROWSUP have
diff --git a/mm/mmap.c b/mm/mmap.c
index 70a75ea91e94..2fc597cf8b8d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -102,7 +102,7 @@ static void unmap_region(struct mm_struct *mm,
  *								w: (no) no
  *								x: (yes) yes
  */
-static inline pgprot_t __vm_get_page_prot(unsigned long vm_flags)
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
 	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
 	case VM_NONE:
@@ -141,14 +141,6 @@ static inline pgprot_t __vm_get_page_prot(unsigned long vm_flags)
 		BUILD_BUG();
 	}
 }
-
-pgprot_t vm_get_page_prot(unsigned long vm_flags)
-{
-	pgprot_t ret = __pgprot(pgprot_val(__vm_get_page_prot(vm_flags)) |
-			pgprot_val(arch_vm_get_page_prot(vm_flags)));
-
-	return ret;
-}
 EXPORT_SYMBOL(vm_get_page_prot);
 #endif	/* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
 
-- 
2.25.1

