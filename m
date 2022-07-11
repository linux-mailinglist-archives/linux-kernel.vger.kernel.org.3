Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF83056D548
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiGKHGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiGKHGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:06:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 645A81A39B;
        Mon, 11 Jul 2022 00:06:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82AB2150C;
        Mon, 11 Jul 2022 00:06:36 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.45.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4EB43F70D;
        Mon, 11 Jul 2022 00:06:28 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     hch@infradead.org, christophe.leroy@csgroup.eu,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org, openrisc@lists.librecores.org,
        linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V7 02/26] mm/mmap: Define DECLARE_VM_GET_PAGE_PROT
Date:   Mon, 11 Jul 2022 12:35:36 +0530
Message-Id: <20220711070600.2378316-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711070600.2378316-1-anshuman.khandual@arm.com>
References: <20220711070600.2378316-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This just converts the generic vm_get_page_prot() implementation into a new
macro i.e DECLARE_VM_GET_PAGE_PROT which later can be used across platforms
when enabling them with ARCH_HAS_VM_GET_PAGE_PROT. This does not create any
functional change.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/pgtable.h | 28 ++++++++++++++++++++++++++++
 mm/mmap.c               | 26 +-------------------------
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 3cdc16cfd867..014ee8f0fbaa 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1689,4 +1689,32 @@ typedef unsigned int pgtbl_mod_mask;
 #define MAX_PTRS_PER_P4D PTRS_PER_P4D
 #endif
 
+/* description of effects of mapping type and prot in current implementation.
+ * this is due to the limited x86 page protection hardware.  The expected
+ * behavior is in parens:
+ *
+ * map_type	prot
+ *		PROT_NONE	PROT_READ	PROT_WRITE	PROT_EXEC
+ * MAP_SHARED	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
+ *		w: (no) no	w: (no) no	w: (yes) yes	w: (no) no
+ *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
+ *
+ * MAP_PRIVATE	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
+ *		w: (no) no	w: (no) no	w: (copy) copy	w: (no) no
+ *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
+ *
+ * On arm64, PROT_EXEC has the following behaviour for both MAP_SHARED and
+ * MAP_PRIVATE (with Enhanced PAN supported):
+ *								r: (no) no
+ *								w: (no) no
+ *								x: (yes) yes
+ */
+#define DECLARE_VM_GET_PAGE_PROT					\
+pgprot_t vm_get_page_prot(unsigned long vm_flags)			\
+{									\
+		return protection_map[vm_flags &			\
+			(VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)];	\
+}									\
+EXPORT_SYMBOL(vm_get_page_prot);
+
 #endif /* _LINUX_PGTABLE_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index b01f0280bda2..b46d5e931bb3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -81,26 +81,6 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end);
 
-/* description of effects of mapping type and prot in current implementation.
- * this is due to the limited x86 page protection hardware.  The expected
- * behavior is in parens:
- *
- * map_type	prot
- *		PROT_NONE	PROT_READ	PROT_WRITE	PROT_EXEC
- * MAP_SHARED	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
- *		w: (no) no	w: (no) no	w: (yes) yes	w: (no) no
- *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
- *
- * MAP_PRIVATE	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
- *		w: (no) no	w: (no) no	w: (copy) copy	w: (no) no
- *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
- *
- * On arm64, PROT_EXEC has the following behaviour for both MAP_SHARED and
- * MAP_PRIVATE (with Enhanced PAN supported):
- *								r: (no) no
- *								w: (no) no
- *								x: (yes) yes
- */
 #ifdef __P000
 pgprot_t protection_map[16] __ro_after_init = {
 	[VM_NONE]					= __P000,
@@ -123,11 +103,7 @@ pgprot_t protection_map[16] __ro_after_init = {
 #endif
 
 #ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
-pgprot_t vm_get_page_prot(unsigned long vm_flags)
-{
-	return protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
-}
-EXPORT_SYMBOL(vm_get_page_prot);
+DECLARE_VM_GET_PAGE_PROT
 #endif	/* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
 
 static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
-- 
2.25.1

