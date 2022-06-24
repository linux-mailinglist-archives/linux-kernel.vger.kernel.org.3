Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4565590F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiFXErC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiFXEpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:45:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 273626927C;
        Thu, 23 Jun 2022 21:45:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19E091692;
        Thu, 23 Jun 2022 21:45:34 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 525BF3F66F;
        Thu, 23 Jun 2022 21:45:26 -0700 (PDT)
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
        Brian Cain <bcain@codeaurora.org>
Subject: [PATCH V4 12/26] hexagon/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Fri, 24 Jun 2022 10:13:25 +0530
Message-Id: <20220624044339.1533882-13-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624044339.1533882-1-anshuman.khandual@arm.com>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables ARCH_HAS_VM_GET_PAGE_PROT on the platform and exports standard
vm_get_page_prot() implementation via DECLARE_VM_GET_PAGE_PROT, which looks
up a private and static protection_map[] array. Subsequently all __SXXX and
__PXXX macros can be dropped which are no longer needed.

Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/hexagon/Kconfig               |  1 +
 arch/hexagon/include/asm/pgtable.h | 27 -------------------
 arch/hexagon/mm/init.c             | 42 ++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 54eadf265178..bc4ceecd0588 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -6,6 +6,7 @@ config HEXAGON
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_NO_PREEMPT
 	select DMA_GLOBAL_POOL
 	# Other pending projects/to-do items.
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 0610724d6a28..f7048c18b6f9 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -126,33 +126,6 @@ extern unsigned long _dflt_cache_att;
  */
 #define CACHEDEF	(CACHE_DEFAULT << 6)
 
-/* Private (copy-on-write) page protections. */
-#define __P000 __pgprot(_PAGE_PRESENT | _PAGE_USER | CACHEDEF)
-#define __P001 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_READ | CACHEDEF)
-#define __P010 __P000	/* Write-only copy-on-write */
-#define __P011 __P001	/* Read/Write copy-on-write */
-#define __P100 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_EXECUTE | CACHEDEF)
-#define __P101 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_EXECUTE | \
-			_PAGE_READ | CACHEDEF)
-#define __P110 __P100	/* Write/execute copy-on-write */
-#define __P111 __P101	/* Read/Write/Execute, copy-on-write */
-
-/* Shared page protections. */
-#define __S000 __P000
-#define __S001 __P001
-#define __S010 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_WRITE | CACHEDEF)
-#define __S011 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_READ | \
-			_PAGE_WRITE | CACHEDEF)
-#define __S100 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_EXECUTE | CACHEDEF)
-#define __S101 __P101
-#define __S110 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_EXECUTE | _PAGE_WRITE | CACHEDEF)
-#define __S111 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_READ | \
-			_PAGE_EXECUTE | _PAGE_WRITE | CACHEDEF)
-
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];  /* located in head.S */
 
 /*  HUGETLB not working currently  */
diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index 3167a3b5c97b..5d4a44a48ad0 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -234,3 +234,45 @@ void __init setup_arch_memory(void)
 	 *  which is called by start_kernel() later on in the process
 	 */
 }
+
+static pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   CACHEDEF),
+	[VM_READ]					= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_READ | CACHEDEF),
+	[VM_WRITE]					= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   CACHEDEF),
+	[VM_WRITE | VM_READ]				= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_READ | CACHEDEF),
+	[VM_EXEC]					= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_EXECUTE | CACHEDEF),
+	[VM_EXEC | VM_READ]				= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_EXECUTE | _PAGE_READ |
+								   CACHEDEF),
+	[VM_EXEC | VM_WRITE]				= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_EXECUTE | CACHEDEF),
+	[VM_EXEC | VM_WRITE | VM_READ]			= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_EXECUTE | _PAGE_READ |
+								   CACHEDEF),
+	[VM_SHARED]                                     = __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   CACHEDEF),
+	[VM_SHARED | VM_READ]				= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_READ | CACHEDEF),
+	[VM_SHARED | VM_WRITE]				= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_WRITE | CACHEDEF),
+	[VM_SHARED | VM_WRITE | VM_READ]		= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_READ | _PAGE_WRITE |
+								   CACHEDEF),
+	[VM_SHARED | VM_EXEC]				= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_EXECUTE | CACHEDEF),
+	[VM_SHARED | VM_EXEC | VM_READ]			= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_EXECUTE | _PAGE_READ |
+								   CACHEDEF),
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_EXECUTE | _PAGE_WRITE |
+								   CACHEDEF),
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_READ | _PAGE_EXECUTE |
+								   _PAGE_WRITE | CACHEDEF)
+};
+DECLARE_VM_GET_PAGE_PROT
-- 
2.25.1

