Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1470A56D665
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiGKHNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiGKHMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:12:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38C8E1AF29;
        Mon, 11 Jul 2022 00:09:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59DD91763;
        Mon, 11 Jul 2022 00:09:41 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.45.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40F943F70D;
        Mon, 11 Jul 2022 00:09:32 -0700 (PDT)
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
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>
Subject: [PATCH V7 24/26] um/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 11 Jul 2022 12:35:58 +0530
Message-Id: <20220711070600.2378316-25-anshuman.khandual@arm.com>
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

This enables ARCH_HAS_VM_GET_PAGE_PROT on the platform and exports standard
vm_get_page_prot() implementation via DECLARE_VM_GET_PAGE_PROT, which looks
up a private and static protection_map[] array. Subsequently all __SXXX and
__PXXX macros can be dropped which are no longer needed.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/um/Kconfig               |  1 +
 arch/um/include/asm/pgtable.h | 17 -----------------
 arch/um/kernel/mem.c          | 20 ++++++++++++++++++++
 arch/x86/um/mem_32.c          |  2 +-
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 4ec22e156a2e..7fb43654e5b5 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -10,6 +10,7 @@ config UML
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 167e236d9bb8..66bc3f99d9be 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -68,23 +68,6 @@ extern unsigned long end_iomem;
  * Also, write permissions imply read permissions. This is the closest we can
  * get..
  */
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
-#define __P100	PAGE_READONLY
-#define __P101	PAGE_READONLY
-#define __P110	PAGE_COPY
-#define __P111	PAGE_COPY
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY
-#define __S101	PAGE_READONLY
-#define __S110	PAGE_SHARED
-#define __S111	PAGE_SHARED
 
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 15295c3237a0..5b259f0a1f94 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -197,3 +197,23 @@ void *uml_kmalloc(int size, int flags)
 {
 	return kmalloc(size, flags);
 }
+
+static const pgprot_t protection_map[16] = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READONLY,
+	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE | VM_READ]				= PAGE_COPY,
+	[VM_EXEC]					= PAGE_READONLY,
+	[VM_EXEC | VM_READ]				= PAGE_READONLY,
+	[VM_EXEC | VM_WRITE]				= PAGE_COPY,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READONLY,
+	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC]				= PAGE_READONLY,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED
+};
+DECLARE_VM_GET_PAGE_PROT
diff --git a/arch/x86/um/mem_32.c b/arch/x86/um/mem_32.c
index 19c5dbd46770..cafd01f730da 100644
--- a/arch/x86/um/mem_32.c
+++ b/arch/x86/um/mem_32.c
@@ -17,7 +17,7 @@ static int __init gate_vma_init(void)
 	gate_vma.vm_start = FIXADDR_USER_START;
 	gate_vma.vm_end = FIXADDR_USER_END;
 	gate_vma.vm_flags = VM_READ | VM_MAYREAD | VM_EXEC | VM_MAYEXEC;
-	gate_vma.vm_page_prot = __P101;
+	gate_vma.vm_page_prot = PAGE_READONLY;
 
 	return 0;
 }
-- 
2.25.1

