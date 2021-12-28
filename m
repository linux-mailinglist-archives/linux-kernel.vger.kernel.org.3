Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F11480A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhL1Ol2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:41:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34078 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbhL1OlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:41:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7237A61233;
        Tue, 28 Dec 2021 14:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FF7C36AEC;
        Tue, 28 Dec 2021 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640702480;
        bh=pAM2VV1KoeyJSTd+zYJnE13XgIbh8liW6QCMXmFUYN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVPrGut/GWhCrA/UVphyi523hjcTOmqZdYHtYVs82d7ob7zogWsL6f0b9/A51Hs0N
         rAKgxrF3xtOYhKT5+FuP6RWke/QGeqiIW3c2i3rTOwYU+Z+PW8g+AKwy1bUevJnM16
         n+3pVNlWlokG8pZQQSyp0a97/IKIPzsPgPSDz97XJAdWO0kQGI0RILP/cSHQcn6kUc
         ssC7CWNfp0gw01hFoDEOrzcETPMkofoWdkhu68+x6hHpesOkMWBWGz4sPc+YdDhi/c
         PVgHOg3gNt5Hqnxy35ED/xkzzACWffSNjdXt9+KExa+cRvwuxohh/Q+yubjUEHONOH
         MUcoUnYj3wsQQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup.patel@wdc.com, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        inux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 11/17] riscv: compat: Add elf.h implementation
Date:   Tue, 28 Dec 2021 22:39:52 +0800
Message-Id: <20211228143958.3409187-12-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211228143958.3409187-1-guoren@kernel.org>
References: <20211228143958.3409187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Implement necessary type and macro for compat elf. See the code
comment for detail.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/include/asm/elf.h | 49 +++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index f53c40026c7a..91b372d4e13b 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -8,6 +8,8 @@
 #ifndef _ASM_RISCV_ELF_H
 #define _ASM_RISCV_ELF_H
 
+#include <uapi/linux/elf.h>
+#include <linux/compat.h>
 #include <uapi/asm/elf.h>
 #include <asm/auxvec.h>
 #include <asm/byteorder.h>
@@ -18,11 +20,13 @@
  */
 #define ELF_ARCH	EM_RISCV
 
+#ifndef ELF_CLASS
 #ifdef CONFIG_64BIT
 #define ELF_CLASS	ELFCLASS64
 #else
 #define ELF_CLASS	ELFCLASS32
 #endif
+#endif
 
 #define ELF_DATA	ELFDATA2LSB
 
@@ -31,6 +35,15 @@
  */
 #define elf_check_arch(x) ((x)->e_machine == EM_RISCV)
 
+#ifdef CONFIG_COMPAT
+/*
+ * Use the same code with elf_check_arch, because elf32_hdr &
+ * elf64_hdr e_machine's offset are different. The checker is
+ * a little bit simple compare to other architectures.
+ */
+#define compat_elf_check_arch(x) ((x)->e_machine == EM_RISCV)
+#endif
+
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	(PAGE_SIZE)
 
@@ -43,8 +56,14 @@
 #define ELF_ET_DYN_BASE		((TASK_SIZE / 3) * 2)
 
 #ifdef CONFIG_64BIT
+#ifdef CONFIG_COMPAT
+#define STACK_RND_MASK		(test_thread_flag(TIF_32BIT) ? \
+				 0x7ff >> (PAGE_SHIFT - 12) : \
+				 0x3ffff >> (PAGE_SHIFT - 12))
+#else
 #define STACK_RND_MASK		(0x3ffff >> (PAGE_SHIFT - 12))
 #endif
+#endif
 /*
  * This yields a mask that user programs can use to figure out what
  * instruction set this CPU supports.  This could be done in user space,
@@ -60,11 +79,19 @@ extern unsigned long elf_hwcap;
  */
 #define ELF_PLATFORM	(NULL)
 
+#define COMPAT_ELF_PLATFORM	(NULL)
+
 #ifdef CONFIG_MMU
 #define ARCH_DLINFO						\
 do {								\
+	/*							\
+	 * Note that we add ulong after elf_addr_t because	\
+	 * casting current->mm->context.vdso triggers a cast	\
+	 * warning of cast from pointer to integer for		\
+	 * COMPAT ELFCLASS32.					\
+	 */							\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
-		(elf_addr_t)current->mm->context.vdso);		\
+		(elf_addr_t)(ulong)current->mm->context.vdso);	\
 	NEW_AUX_ENT(AT_L1I_CACHESIZE,				\
 		get_cache_size(1, CACHE_TYPE_INST));		\
 	NEW_AUX_ENT(AT_L1I_CACHEGEOMETRY,			\
@@ -90,4 +117,24 @@ do {							\
 		*(struct user_regs_struct *)regs;	\
 } while (0);
 
+#ifdef CONFIG_COMPAT
+
+/*
+ * FIXME: not sure SET_PERSONALITY for compat process is right!
+ */
+#define SET_PERSONALITY(ex)						   \
+do {    if ((ex).e_ident[EI_CLASS] == ELFCLASS32)			   \
+		set_thread_flag(TIF_32BIT);				   \
+	else								   \
+		clear_thread_flag(TIF_32BIT);				   \
+	set_personality(PER_LINUX | (current->personality & (~PER_MASK))); \
+} while (0)
+
+#define COMPAT_ELF_ET_DYN_BASE		((TASK_SIZE_32 / 3) * 2)
+
+/* rv32 registers */
+typedef compat_ulong_t			compat_elf_greg_t;
+typedef compat_elf_greg_t		compat_elf_gregset_t[ELF_NGREG];
+
+#endif /* CONFIG_COMPAT */
 #endif /* _ASM_RISCV_ELF_H */
-- 
2.25.1

