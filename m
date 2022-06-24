Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7DF559047
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 06:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiFXEpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiFXEoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:44:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE24868C52;
        Thu, 23 Jun 2022 21:44:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6DE71596;
        Thu, 23 Jun 2022 21:44:37 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 153163F66F;
        Thu, 23 Jun 2022 21:44:28 -0700 (PDT)
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH V4 05/26] arm64/mm: Move protection_map[] inside the platform
Date:   Fri, 24 Jun 2022 10:13:18 +0530
Message-Id: <20220624044339.1533882-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624044339.1533882-1-anshuman.khandual@arm.com>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
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

This moves protection_map[] inside the platform and makes it a static.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h | 18 ------------------
 arch/arm64/mm/mmap.c                  | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 62e0ebeed720..9b165117a454 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -89,24 +89,6 @@ extern bool arm64_use_ng_mappings;
 #define PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN)
 #define PAGE_EXECONLY		__pgprot(_PAGE_DEFAULT | PTE_RDONLY | PTE_NG | PTE_PXN)
 
-#define __P000  PAGE_NONE
-#define __P001  PAGE_READONLY
-#define __P010  PAGE_READONLY
-#define __P011  PAGE_READONLY
-#define __P100  PAGE_READONLY_EXEC	/* PAGE_EXECONLY if Enhanced PAN */
-#define __P101  PAGE_READONLY_EXEC
-#define __P110  PAGE_READONLY_EXEC
-#define __P111  PAGE_READONLY_EXEC
-
-#define __S000  PAGE_NONE
-#define __S001  PAGE_READONLY
-#define __S010  PAGE_SHARED
-#define __S011  PAGE_SHARED
-#define __S100  PAGE_READONLY_EXEC	/* PAGE_EXECONLY if Enhanced PAN */
-#define __S101  PAGE_READONLY_EXEC
-#define __S110  PAGE_SHARED_EXEC
-#define __S111  PAGE_SHARED_EXEC
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_PROT_H */
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 78e9490f748d..8f5b7ce857ed 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -13,6 +13,27 @@
 #include <asm/cpufeature.h>
 #include <asm/page.h>
 
+static pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READONLY,
+	[VM_WRITE]					= PAGE_READONLY,
+	[VM_WRITE | VM_READ]				= PAGE_READONLY,
+	/* PAGE_EXECONLY if Enhanced PAN */
+	[VM_EXEC]					= PAGE_READONLY_EXEC,
+	[VM_EXEC | VM_READ]				= PAGE_READONLY_EXEC,
+	[VM_EXEC | VM_WRITE]				= PAGE_READONLY_EXEC,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_READONLY_EXEC,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READONLY,
+	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
+	/* PAGE_EXECONLY if Enhanced PAN */
+	[VM_SHARED | VM_EXEC]				= PAGE_READONLY_EXEC,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY_EXEC,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED_EXEC,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_EXEC
+};
+
 /*
  * You really shouldn't be using read() or write() on /dev/mem.  This might go
  * away in the future.
-- 
2.25.1

