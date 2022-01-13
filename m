Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B45B48DB33
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiAMQBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:01:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41874 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236394AbiAMQBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:01:10 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C141E1EC05B0;
        Thu, 13 Jan 2022 17:01:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642089669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ZT1aO+Cr2tyrFs/O3EDwQCrobllElOSsZwZqGlea1Sc=;
        b=Jlt0J228OjSXQFbWNYs963xhe58ykvq8KIUgi3O6pcprO62i7AMNupiUqhoZmNiGAJfiTv
        wNX3kvs3Nxt+PwP8p5wb+0UqCqKf8fQHAAlWJiGyoFoa7vbiS9Lypz+b9cAUd//i+PCxyG
        pdnCw8bR/6XZCsH4jC7X2Azf/vJptcI=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86: Remove a.out support
Date:   Thu, 13 Jan 2022 17:01:15 +0100
Message-Id: <20220113160115.5375-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Commit

  eac616557050 ("x86: Deprecate a.out support")

deprecated a.out support with the promise to remove it a couple of
releases later. That commit landed in v5.1.

Now it is more than a couple of releases later, no one has complained so
remove it.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/Kconfig          |   7 -
 arch/x86/ia32/Makefile    |   2 -
 arch/x86/ia32/ia32_aout.c | 325 --------------------------------------
 3 files changed, 334 deletions(-)
 delete mode 100644 arch/x86/ia32/ia32_aout.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 976dd6b532bf..6f3d63dbbddf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2835,13 +2835,6 @@ config IA32_EMULATION
 	  64-bit kernel. You should likely turn this on, unless you're
 	  100% sure that you don't have any 32-bit programs left.
 
-config IA32_AOUT
-	tristate "IA32 a.out support"
-	depends on IA32_EMULATION
-	depends on BROKEN
-	help
-	  Support old a.out binaries in the 32bit emulation.
-
 config X86_X32
 	bool "x32 ABI for 64-bit mode"
 	depends on X86_64
diff --git a/arch/x86/ia32/Makefile b/arch/x86/ia32/Makefile
index 8e4d0391ff6c..e481056698de 100644
--- a/arch/x86/ia32/Makefile
+++ b/arch/x86/ia32/Makefile
@@ -5,7 +5,5 @@
 
 obj-$(CONFIG_IA32_EMULATION) := ia32_signal.o
 
-obj-$(CONFIG_IA32_AOUT) += ia32_aout.o
-
 audit-class-$(CONFIG_AUDIT) := audit.o
 obj-$(CONFIG_IA32_EMULATION) += $(audit-class-y)
diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
deleted file mode 100644
index 9bd15241fadb..000000000000
--- a/arch/x86/ia32/ia32_aout.c
+++ /dev/null
@@ -1,325 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  a.out loader for x86-64
- *
- *  Copyright (C) 1991, 1992, 1996  Linus Torvalds
- *  Hacked together by Andi Kleen
- */
-
-#include <linux/module.h>
-
-#include <linux/time.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/mman.h>
-#include <linux/a.out.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/string.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include <linux/stat.h>
-#include <linux/fcntl.h>
-#include <linux/ptrace.h>
-#include <linux/user.h>
-#include <linux/binfmts.h>
-#include <linux/personality.h>
-#include <linux/init.h>
-#include <linux/jiffies.h>
-#include <linux/perf_event.h>
-#include <linux/sched/task_stack.h>
-
-#include <linux/uaccess.h>
-#include <asm/cacheflush.h>
-#include <asm/user32.h>
-#include <asm/ia32.h>
-
-#undef WARN_OLD
-
-static int load_aout_binary(struct linux_binprm *);
-static int load_aout_library(struct file *);
-
-static struct linux_binfmt aout_format = {
-	.module		= THIS_MODULE,
-	.load_binary	= load_aout_binary,
-	.load_shlib	= load_aout_library,
-};
-
-static int set_brk(unsigned long start, unsigned long end)
-{
-	start = PAGE_ALIGN(start);
-	end = PAGE_ALIGN(end);
-	if (end <= start)
-		return 0;
-	return vm_brk(start, end - start);
-}
-
-
-/*
- * create_aout_tables() parses the env- and arg-strings in new user
- * memory and creates the pointer tables from them, and puts their
- * addresses on the "stack", returning the new stack pointer value.
- */
-static u32 __user *create_aout_tables(char __user *p, struct linux_binprm *bprm)
-{
-	u32 __user *argv, *envp, *sp;
-	int argc = bprm->argc, envc = bprm->envc;
-
-	sp = (u32 __user *) ((-(unsigned long)sizeof(u32)) & (unsigned long) p);
-	sp -= envc+1;
-	envp = sp;
-	sp -= argc+1;
-	argv = sp;
-	put_user((unsigned long) envp, --sp);
-	put_user((unsigned long) argv, --sp);
-	put_user(argc, --sp);
-	current->mm->arg_start = (unsigned long) p;
-	while (argc-- > 0) {
-		char c;
-
-		put_user((u32)(unsigned long)p, argv++);
-		do {
-			get_user(c, p++);
-		} while (c);
-	}
-	put_user(0, argv);
-	current->mm->arg_end = current->mm->env_start = (unsigned long) p;
-	while (envc-- > 0) {
-		char c;
-
-		put_user((u32)(unsigned long)p, envp++);
-		do {
-			get_user(c, p++);
-		} while (c);
-	}
-	put_user(0, envp);
-	current->mm->env_end = (unsigned long) p;
-	return sp;
-}
-
-/*
- * These are the functions used to load a.out style executables and shared
- * libraries.  There is no binary dependent code anywhere else.
- */
-static int load_aout_binary(struct linux_binprm *bprm)
-{
-	unsigned long error, fd_offset, rlim;
-	struct pt_regs *regs = current_pt_regs();
-	struct exec ex;
-	int retval;
-
-	ex = *((struct exec *) bprm->buf);		/* exec-header */
-	if ((N_MAGIC(ex) != ZMAGIC && N_MAGIC(ex) != OMAGIC &&
-	     N_MAGIC(ex) != QMAGIC && N_MAGIC(ex) != NMAGIC) ||
-	    N_TRSIZE(ex) || N_DRSIZE(ex) ||
-	    i_size_read(file_inode(bprm->file)) <
-	    ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
-		return -ENOEXEC;
-	}
-
-	fd_offset = N_TXTOFF(ex);
-
-	/* Check initial limits. This avoids letting people circumvent
-	 * size limits imposed on them by creating programs with large
-	 * arrays in the data or bss.
-	 */
-	rlim = rlimit(RLIMIT_DATA);
-	if (rlim >= RLIM_INFINITY)
-		rlim = ~0;
-	if (ex.a_data + ex.a_bss > rlim)
-		return -ENOMEM;
-
-	/* Flush all traces of the currently running executable */
-	retval = begin_new_exec(bprm);
-	if (retval)
-		return retval;
-
-	/* OK, This is the point of no return */
-	set_personality(PER_LINUX);
-	set_personality_ia32(false);
-
-	setup_new_exec(bprm);
-
-	regs->cs = __USER32_CS;
-	regs->r8 = regs->r9 = regs->r10 = regs->r11 = regs->r12 =
-		regs->r13 = regs->r14 = regs->r15 = 0;
-
-	current->mm->end_code = ex.a_text +
-		(current->mm->start_code = N_TXTADDR(ex));
-	current->mm->end_data = ex.a_data +
-		(current->mm->start_data = N_DATADDR(ex));
-	current->mm->brk = ex.a_bss +
-		(current->mm->start_brk = N_BSSADDR(ex));
-
-	retval = setup_arg_pages(bprm, IA32_STACK_TOP, EXSTACK_DEFAULT);
-	if (retval < 0)
-		return retval;
-
-	if (N_MAGIC(ex) == OMAGIC) {
-		unsigned long text_addr, map_size;
-
-		text_addr = N_TXTADDR(ex);
-		map_size = ex.a_text+ex.a_data;
-
-		error = vm_brk(text_addr & PAGE_MASK, map_size);
-
-		if (error)
-			return error;
-
-		error = read_code(bprm->file, text_addr, 32,
-				  ex.a_text + ex.a_data);
-		if ((signed long)error < 0)
-			return error;
-	} else {
-#ifdef WARN_OLD
-		static unsigned long error_time, error_time2;
-		if ((ex.a_text & 0xfff || ex.a_data & 0xfff) &&
-		    (N_MAGIC(ex) != NMAGIC) &&
-				time_after(jiffies, error_time2 + 5*HZ)) {
-			printk(KERN_NOTICE "executable not page aligned\n");
-			error_time2 = jiffies;
-		}
-
-		if ((fd_offset & ~PAGE_MASK) != 0 &&
-			    time_after(jiffies, error_time + 5*HZ)) {
-			printk(KERN_WARNING
-			       "fd_offset is not page aligned. Please convert "
-			       "program: %pD\n",
-			       bprm->file);
-			error_time = jiffies;
-		}
-#endif
-
-		if (!bprm->file->f_op->mmap || (fd_offset & ~PAGE_MASK) != 0) {
-			error = vm_brk(N_TXTADDR(ex), ex.a_text+ex.a_data);
-			if (error)
-				return error;
-
-			read_code(bprm->file, N_TXTADDR(ex), fd_offset,
-					ex.a_text+ex.a_data);
-			goto beyond_if;
-		}
-
-		error = vm_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
-				PROT_READ | PROT_EXEC,
-				MAP_FIXED | MAP_PRIVATE | MAP_32BIT,
-				fd_offset);
-
-		if (error != N_TXTADDR(ex))
-			return error;
-
-		error = vm_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
-				PROT_READ | PROT_WRITE | PROT_EXEC,
-				MAP_FIXED | MAP_PRIVATE | MAP_32BIT,
-				fd_offset + ex.a_text);
-		if (error != N_DATADDR(ex))
-			return error;
-	}
-
-beyond_if:
-	error = set_brk(current->mm->start_brk, current->mm->brk);
-	if (error)
-		return error;
-
-	set_binfmt(&aout_format);
-
-	current->mm->start_stack =
-		(unsigned long)create_aout_tables((char __user *)bprm->p, bprm);
-	/* start thread */
-	loadsegment(fs, 0);
-	loadsegment(ds, __USER32_DS);
-	loadsegment(es, __USER32_DS);
-	load_gs_index(0);
-	(regs)->ip = ex.a_entry;
-	(regs)->sp = current->mm->start_stack;
-	(regs)->flags = 0x200;
-	(regs)->cs = __USER32_CS;
-	(regs)->ss = __USER32_DS;
-	regs->r8 = regs->r9 = regs->r10 = regs->r11 =
-	regs->r12 = regs->r13 = regs->r14 = regs->r15 = 0;
-	return 0;
-}
-
-static int load_aout_library(struct file *file)
-{
-	unsigned long bss, start_addr, len, error;
-	int retval;
-	struct exec ex;
-	loff_t pos = 0;
-
-	retval = -ENOEXEC;
-	error = kernel_read(file, &ex, sizeof(ex), &pos);
-	if (error != sizeof(ex))
-		goto out;
-
-	/* We come in here for the regular a.out style of shared libraries */
-	if ((N_MAGIC(ex) != ZMAGIC && N_MAGIC(ex) != QMAGIC) || N_TRSIZE(ex) ||
-	    N_DRSIZE(ex) || ((ex.a_entry & 0xfff) && N_MAGIC(ex) == ZMAGIC) ||
-	    i_size_read(file_inode(file)) <
-	    ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
-		goto out;
-	}
-
-	if (N_FLAGS(ex))
-		goto out;
-
-	/* For  QMAGIC, the starting address is 0x20 into the page.  We mask
-	   this off to get the starting address for the page */
-
-	start_addr =  ex.a_entry & 0xfffff000;
-
-	if ((N_TXTOFF(ex) & ~PAGE_MASK) != 0) {
-#ifdef WARN_OLD
-		static unsigned long error_time;
-		if (time_after(jiffies, error_time + 5*HZ)) {
-			printk(KERN_WARNING
-			       "N_TXTOFF is not page aligned. Please convert "
-			       "library: %pD\n",
-			       file);
-			error_time = jiffies;
-		}
-#endif
-		retval = vm_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss);
-		if (retval)
-			goto out;
-
-		read_code(file, start_addr, N_TXTOFF(ex),
-			  ex.a_text + ex.a_data);
-		retval = 0;
-		goto out;
-	}
-	/* Now use mmap to map the library into memory. */
-	error = vm_mmap(file, start_addr, ex.a_text + ex.a_data,
-			PROT_READ | PROT_WRITE | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE | MAP_32BIT,
-			N_TXTOFF(ex));
-	retval = error;
-	if (error != start_addr)
-		goto out;
-
-	len = PAGE_ALIGN(ex.a_text + ex.a_data);
-	bss = ex.a_text + ex.a_data + ex.a_bss;
-	if (bss > len) {
-		retval = vm_brk(start_addr + len, bss - len);
-		if (retval)
-			goto out;
-	}
-	retval = 0;
-out:
-	return retval;
-}
-
-static int __init init_aout_binfmt(void)
-{
-	register_binfmt(&aout_format);
-	return 0;
-}
-
-static void __exit exit_aout_binfmt(void)
-{
-	unregister_binfmt(&aout_format);
-}
-
-module_init(init_aout_binfmt);
-module_exit(exit_aout_binfmt);
-MODULE_LICENSE("GPL");
-- 
2.29.2

