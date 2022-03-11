Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121A64D63EA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349494AbiCKOmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346218AbiCKOm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:42:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7E41CDDF7;
        Fri, 11 Mar 2022 06:40:56 -0800 (PST)
Date:   Fri, 11 Mar 2022 14:40:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647009654;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCDX+LAsf6hfbMql66ERUc6He6ieYXqZquCOViN7QIw=;
        b=dz9rk6FhbpsICgQXUrPHtK436jQUK9CKaQrUOK8im5z0nEUV+cHbvrv0PsobM8L3xS5Iih
        1MlfpUNMPF3qZoxp0Rhtm36/MAKGUkKwdO+35eZeCAS8QYgGFg4XBZz4sqvpTU8ktrJh3x
        8jezoC9h1Bi1Z/vZ29DwCJb5Ju8fcZe69wg6Lk16al/p+ALS72QGnkQYbKrjj5u+SNziz0
        Ij52hFRGDwd9CQmU56C/9Wn6dfFEjCdlzbIKAzY8OeCXWENVUcihuLKeBeP3CNeuUsrCs7
        rqLA6BlVpnGlJy4GPMcm9ZMYPu9PMJEzy7u1EFAHreUAGTqQR2XB2YI4KtfNkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647009654;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCDX+LAsf6hfbMql66ERUc6He6ieYXqZquCOViN7QIw=;
        b=SckUKS8AQHDzc10UFeApbKVLjcKbLhmcUSeilhg/CJS6DZLjezwBnPzicg4P6yp901Jz2L
        IckNlzKk5z2lUhDA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Remove a.out support
Cc:     Borislav Petkov <bp@suse.de>, Kees Cook <keescook@chromium.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220113160115.5375-1-bp@alien8.de>
References: <20220113160115.5375-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <164700965337.16921.6180551457700051656.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     f9444ea5e20847d1dd4a98d4dff4cc97655834bb
Gitweb:        https://git.kernel.org/tip/f9444ea5e20847d1dd4a98d4dff4cc97655834bb
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 13 Jan 2022 14:26:10 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 11 Mar 2022 11:06:32 +01:00

x86: Remove a.out support

Commit

  eac616557050 ("x86: Deprecate a.out support")

deprecated a.out support with the promise to remove it a couple of
releases later. That commit landed in v5.1.

Now it is more than a couple of releases later, no one has complained so
remove it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220113160115.5375-1-bp@alien8.de
---
 arch/x86/Kconfig          |   7 +-
 arch/x86/ia32/Makefile    |   2 +-
 arch/x86/ia32/ia32_aout.c | 325 +-------------------------------------
 3 files changed, 334 deletions(-)
 delete mode 100644 arch/x86/ia32/ia32_aout.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41..b6563d6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2827,13 +2827,6 @@ config IA32_EMULATION
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
index 8e4d039..e481056 100644
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
index 9bd1524..0000000
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
