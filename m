Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4377B47C3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbhLUQgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbhLUQgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:36:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027A0C06173F;
        Tue, 21 Dec 2021 08:36:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A101861660;
        Tue, 21 Dec 2021 16:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31437C36AFC;
        Tue, 21 Dec 2021 16:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640104575;
        bh=P1KXPJVc0uF2McVIgYSbKY226nQDQV6xLJ8uZLP12bI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvRwFBKj3auRlx0iE8ICGY/OVB+2bgk2t9YAsnSYjaIzrKXLHkaYoY/pIRJpsD0nh
         bsJlB5c+vXbAlK8qzfdrIqxTibubgaIxUExYfekObkEKDTqqHhbE/w3wTWTLLzzai1
         /8wCw1F4h5GE78DRC7X5zUD+Ix1dopEoamsT8pDyxDCvhRDKCc1Lf+qaIm6yjB6loD
         vu1PZGzGBQlNTMhqjcMlLzxRwXGD9ZwcDcuhBppO6DA5BoMHQsxeIBnydEF72nD6hA
         QllFYYGTxrzSycp9hqIu+78ZlsACiwaMYCMvGke6rvzpSOPQAgvMTYvSsecc5f3W9p
         wG4PQtpD0oqoQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup.patel@wdc.com, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 07/13] riscv: compat: Add elf.h implementation
Date:   Wed, 22 Dec 2021 00:35:26 +0800
Message-Id: <20211221163532.2636028-8-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221163532.2636028-1-guoren@kernel.org>
References: <20211221163532.2636028-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Implement necessary type and macro for compat elf. See the code
comment for detail.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/include/asm/elf.h | 42 +++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index f53c40026c7a..48c116f3c12d 100644
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
 
@@ -31,6 +35,8 @@
  */
 #define elf_check_arch(x) ((x)->e_machine == EM_RISCV)
 
+#define compat_elf_check_arch(x) ((x)->e_machine == EM_RISCV)
+
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	(PAGE_SIZE)
 
@@ -43,8 +49,14 @@
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
@@ -60,11 +72,19 @@ extern unsigned long elf_hwcap;
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
@@ -90,4 +110,24 @@ do {							\
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

