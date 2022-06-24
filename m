Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277585590C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiFXEsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiFXErm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:47:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F39BA6B8DE;
        Thu, 23 Jun 2022 21:46:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B8F7175A;
        Thu, 23 Jun 2022 21:46:55 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF58B3F66F;
        Thu, 23 Jun 2022 21:46:47 -0700 (PDT)
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
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH V4 22/26] arc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Fri, 24 Jun 2022 10:13:35 +0530
Message-Id: <20220624044339.1533882-23-anshuman.khandual@arm.com>
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

Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arc/Kconfig                          |  1 +
 arch/arc/include/asm/pgtable-bits-arcv2.h | 18 ------------------
 arch/arc/mm/mmap.c                        | 20 ++++++++++++++++++++
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 9e3653253ef2..8be56a5d8a9b 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -13,6 +13,7 @@ config ARC
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
 	select ARCH_32BIT_OFF_T
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/asm/pgtable-bits-arcv2.h
index 183d23bc1e00..b23be557403e 100644
--- a/arch/arc/include/asm/pgtable-bits-arcv2.h
+++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
@@ -72,24 +72,6 @@
  *     This is to enable COW mechanism
  */
 	/* xwr */
-#define __P000  PAGE_U_NONE
-#define __P001  PAGE_U_R
-#define __P010  PAGE_U_R	/* Pvt-W => !W */
-#define __P011  PAGE_U_R	/* Pvt-W => !W */
-#define __P100  PAGE_U_X_R	/* X => R */
-#define __P101  PAGE_U_X_R
-#define __P110  PAGE_U_X_R	/* Pvt-W => !W and X => R */
-#define __P111  PAGE_U_X_R	/* Pvt-W => !W */
-
-#define __S000  PAGE_U_NONE
-#define __S001  PAGE_U_R
-#define __S010  PAGE_U_W_R	/* W => R */
-#define __S011  PAGE_U_W_R
-#define __S100  PAGE_U_X_R	/* X => R */
-#define __S101  PAGE_U_X_R
-#define __S110  PAGE_U_X_W_R	/* X => R */
-#define __S111  PAGE_U_X_W_R
-
 #ifndef __ASSEMBLY__
 
 #define pte_write(pte)		(pte_val(pte) & _PAGE_WRITE)
diff --git a/arch/arc/mm/mmap.c b/arch/arc/mm/mmap.c
index 722d26b94307..7dd50b66f266 100644
--- a/arch/arc/mm/mmap.c
+++ b/arch/arc/mm/mmap.c
@@ -74,3 +74,23 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
 }
+
+static pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_U_NONE,
+	[VM_READ]					= PAGE_U_R,
+	[VM_WRITE]					= PAGE_U_R,
+	[VM_WRITE | VM_READ]				= PAGE_U_R,
+	[VM_EXEC]					= PAGE_U_X_R,
+	[VM_EXEC | VM_READ]				= PAGE_U_X_R,
+	[VM_EXEC | VM_WRITE]				= PAGE_U_X_R,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_U_X_R,
+	[VM_SHARED]					= PAGE_U_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_U_R,
+	[VM_SHARED | VM_WRITE]				= PAGE_U_W_R,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_U_W_R,
+	[VM_SHARED | VM_EXEC]				= PAGE_U_X_R,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_U_X_R,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_U_X_W_R,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_U_X_W_R
+};
+DECLARE_VM_GET_PAGE_PROT
-- 
2.25.1

