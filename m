Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1300C559188
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiFXEqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiFXEpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:45:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61C3C699BF;
        Thu, 23 Jun 2022 21:45:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54F0E1688;
        Thu, 23 Jun 2022 21:45:10 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A3603F66F;
        Thu, 23 Jun 2022 21:45:01 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     hch@infradead.org, christophe.leroy@csgroup.eu,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org, openrisc@lists.librecores.org,
        linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH V4 09/26] loongarch/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Fri, 24 Jun 2022 10:13:22 +0530
Message-Id: <20220624044339.1533882-10-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624044339.1533882-1-anshuman.khandual@arm.com>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables ARCH_HAS_VM_GET_PAGE_PROT on the platform and exports standard
vm_get_page_prot() implementation via DECLARE_VM_GET_PAGE_PROT, which looks
up a private and static protection_map[] array. Subsequently all __SXXX and
__PXXX macros can be dropped which are no longer needed.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/loongarch/Kconfig                    |  1 +
 arch/loongarch/include/asm/pgtable-bits.h | 19 ----------
 arch/loongarch/mm/cache.c                 | 46 +++++++++++++++++++++++
 3 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 1920d52653b4..fd07b8e760ee 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -9,6 +9,7 @@ config LOONGARCH
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
index 3badd112d9ab..9ca147a29bab 100644
--- a/arch/loongarch/include/asm/pgtable-bits.h
+++ b/arch/loongarch/include/asm/pgtable-bits.h
@@ -83,25 +83,6 @@
 				 _PAGE_GLOBAL | _PAGE_KERN |  _CACHE_SUC)
 #define PAGE_KERNEL_WUC __pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 				 _PAGE_GLOBAL | _PAGE_KERN |  _CACHE_WUC)
-
-#define __P000 __pgprot(_CACHE_CC | _PAGE_USER | _PAGE_PROTNONE | _PAGE_NO_EXEC | _PAGE_NO_READ)
-#define __P001 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC)
-#define __P010 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC)
-#define __P011 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC)
-#define __P100 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT)
-#define __P101 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT)
-#define __P110 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT)
-#define __P111 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT)
-
-#define __S000 __pgprot(_CACHE_CC | _PAGE_USER | _PAGE_PROTNONE | _PAGE_NO_EXEC | _PAGE_NO_READ)
-#define __S001 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC)
-#define __S010 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE)
-#define __S011 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE)
-#define __S100 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT)
-#define __S101 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT)
-#define __S110 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_WRITE)
-#define __S111 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_WRITE)
-
 #ifndef __ASSEMBLY__
 
 #define pgprot_noncached pgprot_noncached
diff --git a/arch/loongarch/mm/cache.c b/arch/loongarch/mm/cache.c
index 9e5ce5aa73f7..aa4ea357ea44 100644
--- a/arch/loongarch/mm/cache.c
+++ b/arch/loongarch/mm/cache.c
@@ -139,3 +139,49 @@ void cpu_cache_init(void)
 
 	shm_align_mask = PAGE_SIZE - 1;
 }
+
+static pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= __pgprot(_CACHE_CC | _PAGE_USER |
+								   _PAGE_PROTNONE | _PAGE_NO_EXEC |
+								   _PAGE_NO_READ),
+	[VM_READ]					= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_NO_EXEC),
+	[VM_WRITE]					= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_NO_EXEC),
+	[VM_WRITE | VM_READ]				= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_NO_EXEC),
+	[VM_EXEC]					= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT),
+	[VM_EXEC | VM_READ]				= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT),
+	[VM_EXEC | VM_WRITE]				= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT),
+	[VM_EXEC | VM_WRITE | VM_READ]			= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT),
+	[VM_SHARED]					= __pgprot(_CACHE_CC | _PAGE_USER |
+								   _PAGE_PROTNONE | _PAGE_NO_EXEC |
+								   _PAGE_NO_READ),
+	[VM_SHARED | VM_READ]				= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_NO_EXEC),
+	[VM_SHARED | VM_WRITE]				= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_NO_EXEC | _PAGE_WRITE),
+	[VM_SHARED | VM_WRITE | VM_READ]		= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_NO_EXEC | _PAGE_WRITE),
+	[VM_SHARED | VM_EXEC]				= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT),
+	[VM_SHARED | VM_EXEC | VM_READ]			= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT),
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_WRITE),
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_WRITE)
+};
+DECLARE_VM_GET_PAGE_PROT
-- 
2.25.1

