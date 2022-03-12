Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7354D703E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 18:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiCLRzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 12:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiCLRzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 12:55:48 -0500
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03882E0B3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 09:54:42 -0800 (PST)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 4KG9Rh6Q5nz4xJYt
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 17:54:40 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (2048-bit key) header.d=theinnocuous.com header.i=@theinnocuous.com header.b="7i3+FrPN"
Date:   Sat, 12 Mar 2022 17:54:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theinnocuous.com;
        s=protonmail; t=1647107675;
        bh=T/Xlv1PqzX7fBk6cYYvzy7oIpeGk9OUU/LoAGlzNFBo=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=7i3+FrPNdMs+LHKikbojEfHIwrJMFW9+D/zU4SPcdVSdjGkdHO/R+ho/ulr8PZtCr
         BECgtYZhtVKd5hm7/nwiZIR7Ha11Vrj5oULD4H5DizE5Q75IZC86KjJTQrK/cxC490
         yvlfY+ivDZ5K3IRK/iyCloaxU+qWMTQww7Db0TI5I8nyYqoh7b5EAhWcLZcFc00+7w
         yIlOobXRsQLZqFtD8TqzO4odPdH7FuncEi7X3Yq2tfL353x7Xq4znuPoHKvQ3Wd7Wj
         relRTUN8v5kGkRsD/tmFDGKMM8iD5AHS4mmNOkbw9+tHPjfdKyejPjFYqATvAaGVCl
         mEebOCSV7Z5vA==
To:     linux-kernel@vger.kernel.org, bp@alien8.de, keescook@chromium.org
From:   James Jones <linux@theinnocuous.com>
Cc:     x86@vger.kernel.org
Reply-To: James Jones <linux@theinnocuous.com>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Borislav Petkov <bp@suse.de>
>
> Commit
>
>   eac616557050 ("x86: Deprecate a.out support")
>
> deprecated a.out support with the promise to remove it a couple of
> releases later. That commit landed in v5.1.
>
> Now it is more than a couple of releases later, no one has complained so
> remove it.

Sorry for taking so long to complain, but I have been meaning to note
that I and a few others are still using a.out. I saw it go by in my
morning Google news skim that this went in, and figured it was now or
never. The use case is running an old set of tools to build programs for
the Atari Jaguar. Namely, Atari's assembler (mac) and linker (aln). The
alternative is running windows versions in dosbox, or using some
replacements that have been developed based on an even older,
less-featureful version of the source code for mac and aln, but which
still haven't managed to add back in all the features needed to build
some programs or use the Atari debugging tools (Also available in a.out
only).

I've been running with a few local patches to fix the a.out build and
add the Kconfig options back for the last year or so to enable this on a
few of my machines, and it's been working fine. I know of at least one
other person doing this. If the code itself and supporting
syscalls/other code go away though, it'll probably become impractical.
If others are open to it, I can share my small local patches along with
a revert of this change. I'd also like to ask whether much is gained by
deleting this code as far as reducing maintenance burden. It has
survived nearly untouched since the deprecation notice and still works
modulo a broken preprocessor macro in fs/exec.c.

For the curious, or if anyone wants proof I'm not making this up and
really do spend time on these things, my amalgamation of Jaguar tools &
docs, including copies of the old mac and aln a.out binaries, is
available here:

https://github.com/cubanismo/jaguar-sdk

Thanks,
-James

> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/Kconfig          |   7 -
>  arch/x86/ia32/Makefile    |   2 -
>  arch/x86/ia32/ia32_aout.c | 325 --------------------------------------
>  3 files changed, 334 deletions(-)
>  delete mode 100644 arch/x86/ia32/ia32_aout.c
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 976dd6b532bf..6f3d63dbbddf 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2835,13 +2835,6 @@ config IA32_EMULATION
>  =09  64-bit kernel. You should likely turn this on, unless you're
>  =09  100% sure that you don't have any 32-bit programs left.
>
> -config IA32_AOUT
> -=09tristate "IA32 a.out support"
> -=09depends on IA32_EMULATION
> -=09depends on BROKEN
> -=09help
> -=09  Support old a.out binaries in the 32bit emulation.
> -
>  config X86_X32
>  =09bool "x32 ABI for 64-bit mode"
>  =09depends on X86_64
> diff --git a/arch/x86/ia32/Makefile b/arch/x86/ia32/Makefile
> index 8e4d0391ff6c..e481056698de 100644
> --- a/arch/x86/ia32/Makefile
> +++ b/arch/x86/ia32/Makefile
> @@ -5,7 +5,5 @@
>
>  obj-$(CONFIG_IA32_EMULATION) :=3D ia32_signal.o
>
> -obj-$(CONFIG_IA32_AOUT) +=3D ia32_aout.o
> -
>  audit-class-$(CONFIG_AUDIT) :=3D audit.o
>  obj-$(CONFIG_IA32_EMULATION) +=3D $(audit-class-y)
> diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
> deleted file mode 100644
> index 9bd15241fadb..000000000000
> --- a/arch/x86/ia32/ia32_aout.c
> +++ /dev/null
> @@ -1,325 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *  a.out loader for x86-64
> - *
> - *  Copyright (C) 1991, 1992, 1996  Linus Torvalds
> - *  Hacked together by Andi Kleen
> - */
> -
> -#include <linux/module.h>
> -
> -#include <linux/time.h>
> -#include <linux/kernel.h>
> -#include <linux/mm.h>
> -#include <linux/mman.h>
> -#include <linux/a.out.h>
> -#include <linux/errno.h>
> -#include <linux/signal.h>
> -#include <linux/string.h>
> -#include <linux/fs.h>
> -#include <linux/file.h>
> -#include <linux/stat.h>
> -#include <linux/fcntl.h>
> -#include <linux/ptrace.h>
> -#include <linux/user.h>
> -#include <linux/binfmts.h>
> -#include <linux/personality.h>
> -#include <linux/init.h>
> -#include <linux/jiffies.h>
> -#include <linux/perf_event.h>
> -#include <linux/sched/task_stack.h>
> -
> -#include <linux/uaccess.h>
> -#include <asm/cacheflush.h>
> -#include <asm/user32.h>
> -#include <asm/ia32.h>
> -
> -#undef WARN_OLD
> -
> -static int load_aout_binary(struct linux_binprm *);
> -static int load_aout_library(struct file *);
> -
> -static struct linux_binfmt aout_format =3D {
> -=09.module=09=09=3D THIS_MODULE,
> -=09.load_binary=09=3D load_aout_binary,
> -=09.load_shlib=09=3D load_aout_library,
> -};
> -
> -static int set_brk(unsigned long start, unsigned long end)
> -{
> -=09start =3D PAGE_ALIGN(start);
> -=09end =3D PAGE_ALIGN(end);
> -=09if (end <=3D start)
> -=09=09return 0;
> -=09return vm_brk(start, end - start);
> -}
> -
> -
> -/*
> - * create_aout_tables() parses the env- and arg-strings in new user
> - * memory and creates the pointer tables from them, and puts their
> - * addresses on the "stack", returning the new stack pointer value.
> - */
> -static u32 __user *create_aout_tables(char __user *p, struct linux_binpr=
m *bprm)
> -{
> -=09u32 __user *argv, *envp, *sp;
> -=09int argc =3D bprm->argc, envc =3D bprm->envc;
> -
> -=09sp =3D (u32 __user *) ((-(unsigned long)sizeof(u32)) & (unsigned long=
) p);
> -=09sp -=3D envc+1;
> -=09envp =3D sp;
> -=09sp -=3D argc+1;
> -=09argv =3D sp;
> -=09put_user((unsigned long) envp, --sp);
> -=09put_user((unsigned long) argv, --sp);
> -=09put_user(argc, --sp);
> -=09current->mm->arg_start =3D (unsigned long) p;
> -=09while (argc-- > 0) {
> -=09=09char c;
> -
> -=09=09put_user((u32)(unsigned long)p, argv++);
> -=09=09do {
> -=09=09=09get_user(c, p++);
> -=09=09} while (c);
> -=09}
> -=09put_user(0, argv);
> -=09current->mm->arg_end =3D current->mm->env_start =3D (unsigned long) p=
;
> -=09while (envc-- > 0) {
> -=09=09char c;
> -
> -=09=09put_user((u32)(unsigned long)p, envp++);
> -=09=09do {
> -=09=09=09get_user(c, p++);
> -=09=09} while (c);
> -=09}
> -=09put_user(0, envp);
> -=09current->mm->env_end =3D (unsigned long) p;
> -=09return sp;
> -}
> -
> -/*
> - * These are the functions used to load a.out style executables and shar=
ed
> - * libraries.  There is no binary dependent code anywhere else.
> - */
> -static int load_aout_binary(struct linux_binprm *bprm)
> -{
> -=09unsigned long error, fd_offset, rlim;
> -=09struct pt_regs *regs =3D current_pt_regs();
> -=09struct exec ex;
> -=09int retval;
> -
> -=09ex =3D *((struct exec *) bprm->buf);=09=09/* exec-header */
> -=09if ((N_MAGIC(ex) !=3D ZMAGIC && N_MAGIC(ex) !=3D OMAGIC &&
> -=09     N_MAGIC(ex) !=3D QMAGIC && N_MAGIC(ex) !=3D NMAGIC) ||
> -=09    N_TRSIZE(ex) || N_DRSIZE(ex) ||
> -=09    i_size_read(file_inode(bprm->file)) <
> -=09    ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
> -=09=09return -ENOEXEC;
> -=09}
> -
> -=09fd_offset =3D N_TXTOFF(ex);
> -
> -=09/* Check initial limits. This avoids letting people circumvent
> -=09 * size limits imposed on them by creating programs with large
> -=09 * arrays in the data or bss.
> -=09 */
> -=09rlim =3D rlimit(RLIMIT_DATA);
> -=09if (rlim >=3D RLIM_INFINITY)
> -=09=09rlim =3D ~0;
> -=09if (ex.a_data + ex.a_bss > rlim)
> -=09=09return -ENOMEM;
> -
> -=09/* Flush all traces of the currently running executable */
> -=09retval =3D begin_new_exec(bprm);
> -=09if (retval)
> -=09=09return retval;
> -
> -=09/* OK, This is the point of no return */
> -=09set_personality(PER_LINUX);
> -=09set_personality_ia32(false);
> -
> -=09setup_new_exec(bprm);
> -
> -=09regs->cs =3D __USER32_CS;
> -=09regs->r8 =3D regs->r9 =3D regs->r10 =3D regs->r11 =3D regs->r12 =3D
> -=09=09regs->r13 =3D regs->r14 =3D regs->r15 =3D 0;
> -
> -=09current->mm->end_code =3D ex.a_text +
> -=09=09(current->mm->start_code =3D N_TXTADDR(ex));
> -=09current->mm->end_data =3D ex.a_data +
> -=09=09(current->mm->start_data =3D N_DATADDR(ex));
> -=09current->mm->brk =3D ex.a_bss +
> -=09=09(current->mm->start_brk =3D N_BSSADDR(ex));
> -
> -=09retval =3D setup_arg_pages(bprm, IA32_STACK_TOP, EXSTACK_DEFAULT);
> -=09if (retval < 0)
> -=09=09return retval;
> -
> -=09if (N_MAGIC(ex) =3D=3D OMAGIC) {
> -=09=09unsigned long text_addr, map_size;
> -
> -=09=09text_addr =3D N_TXTADDR(ex);
> -=09=09map_size =3D ex.a_text+ex.a_data;
> -
> -=09=09error =3D vm_brk(text_addr & PAGE_MASK, map_size);
> -
> -=09=09if (error)
> -=09=09=09return error;
> -
> -=09=09error =3D read_code(bprm->file, text_addr, 32,
> -=09=09=09=09  ex.a_text + ex.a_data);
> -=09=09if ((signed long)error < 0)
> -=09=09=09return error;
> -=09} else {
> -#ifdef WARN_OLD
> -=09=09static unsigned long error_time, error_time2;
> -=09=09if ((ex.a_text & 0xfff || ex.a_data & 0xfff) &&
> -=09=09    (N_MAGIC(ex) !=3D NMAGIC) &&
> -=09=09=09=09time_after(jiffies, error_time2 + 5*HZ)) {
> -=09=09=09printk(KERN_NOTICE "executable not page aligned\n");
> -=09=09=09error_time2 =3D jiffies;
> -=09=09}
> -
> -=09=09if ((fd_offset & ~PAGE_MASK) !=3D 0 &&
> -=09=09=09    time_after(jiffies, error_time + 5*HZ)) {
> -=09=09=09printk(KERN_WARNING
> -=09=09=09       "fd_offset is not page aligned. Please convert "
> -=09=09=09       "program: %pD\n",
> -=09=09=09       bprm->file);
> -=09=09=09error_time =3D jiffies;
> -=09=09}
> -#endif
> -
> -=09=09if (!bprm->file->f_op->mmap || (fd_offset & ~PAGE_MASK) !=3D 0) {
> -=09=09=09error =3D vm_brk(N_TXTADDR(ex), ex.a_text+ex.a_data);
> -=09=09=09if (error)
> -=09=09=09=09return error;
> -
> -=09=09=09read_code(bprm->file, N_TXTADDR(ex), fd_offset,
> -=09=09=09=09=09ex.a_text+ex.a_data);
> -=09=09=09goto beyond_if;
> -=09=09}
> -
> -=09=09error =3D vm_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
> -=09=09=09=09PROT_READ | PROT_EXEC,
> -=09=09=09=09MAP_FIXED | MAP_PRIVATE | MAP_32BIT,
> -=09=09=09=09fd_offset);
> -
> -=09=09if (error !=3D N_TXTADDR(ex))
> -=09=09=09return error;
> -
> -=09=09error =3D vm_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
> -=09=09=09=09PROT_READ | PROT_WRITE | PROT_EXEC,
> -=09=09=09=09MAP_FIXED | MAP_PRIVATE | MAP_32BIT,
> -=09=09=09=09fd_offset + ex.a_text);
> -=09=09if (error !=3D N_DATADDR(ex))
> -=09=09=09return error;
> -=09}
> -
> -beyond_if:
> -=09error =3D set_brk(current->mm->start_brk, current->mm->brk);
> -=09if (error)
> -=09=09return error;
> -
> -=09set_binfmt(&aout_format);
> -
> -=09current->mm->start_stack =3D
> -=09=09(unsigned long)create_aout_tables((char __user *)bprm->p, bprm);
> -=09/* start thread */
> -=09loadsegment(fs, 0);
> -=09loadsegment(ds, __USER32_DS);
> -=09loadsegment(es, __USER32_DS);
> -=09load_gs_index(0);
> -=09(regs)->ip =3D ex.a_entry;
> -=09(regs)->sp =3D current->mm->start_stack;
> -=09(regs)->flags =3D 0x200;
> -=09(regs)->cs =3D __USER32_CS;
> -=09(regs)->ss =3D __USER32_DS;
> -=09regs->r8 =3D regs->r9 =3D regs->r10 =3D regs->r11 =3D
> -=09regs->r12 =3D regs->r13 =3D regs->r14 =3D regs->r15 =3D 0;
> -=09return 0;
> -}
> -
> -static int load_aout_library(struct file *file)
> -{
> -=09unsigned long bss, start_addr, len, error;
> -=09int retval;
> -=09struct exec ex;
> -=09loff_t pos =3D 0;
> -
> -=09retval =3D -ENOEXEC;
> -=09error =3D kernel_read(file, &ex, sizeof(ex), &pos);
> -=09if (error !=3D sizeof(ex))
> -=09=09goto out;
> -
> -=09/* We come in here for the regular a.out style of shared libraries */
> -=09if ((N_MAGIC(ex) !=3D ZMAGIC && N_MAGIC(ex) !=3D QMAGIC) || N_TRSIZE(=
ex) ||
> -=09    N_DRSIZE(ex) || ((ex.a_entry & 0xfff) && N_MAGIC(ex) =3D=3D ZMAGI=
C) ||
> -=09    i_size_read(file_inode(file)) <
> -=09    ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
> -=09=09goto out;
> -=09}
> -
> -=09if (N_FLAGS(ex))
> -=09=09goto out;
> -
> -=09/* For  QMAGIC, the starting address is 0x20 into the page.  We mask
> -=09   this off to get the starting address for the page */
> -
> -=09start_addr =3D  ex.a_entry & 0xfffff000;
> -
> -=09if ((N_TXTOFF(ex) & ~PAGE_MASK) !=3D 0) {
> -#ifdef WARN_OLD
> -=09=09static unsigned long error_time;
> -=09=09if (time_after(jiffies, error_time + 5*HZ)) {
> -=09=09=09printk(KERN_WARNING
> -=09=09=09       "N_TXTOFF is not page aligned. Please convert "
> -=09=09=09       "library: %pD\n",
> -=09=09=09       file);
> -=09=09=09error_time =3D jiffies;
> -=09=09}
> -#endif
> -=09=09retval =3D vm_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss);
> -=09=09if (retval)
> -=09=09=09goto out;
> -
> -=09=09read_code(file, start_addr, N_TXTOFF(ex),
> -=09=09=09  ex.a_text + ex.a_data);
> -=09=09retval =3D 0;
> -=09=09goto out;
> -=09}
> -=09/* Now use mmap to map the library into memory. */
> -=09error =3D vm_mmap(file, start_addr, ex.a_text + ex.a_data,
> -=09=09=09PROT_READ | PROT_WRITE | PROT_EXEC,
> -=09=09=09MAP_FIXED | MAP_PRIVATE | MAP_32BIT,
> -=09=09=09N_TXTOFF(ex));
> -=09retval =3D error;
> -=09if (error !=3D start_addr)
> -=09=09goto out;
> -
> -=09len =3D PAGE_ALIGN(ex.a_text + ex.a_data);
> -=09bss =3D ex.a_text + ex.a_data + ex.a_bss;
> -=09if (bss > len) {
> -=09=09retval =3D vm_brk(start_addr + len, bss - len);
> -=09=09if (retval)
> -=09=09=09goto out;
> -=09}
> -=09retval =3D 0;
> -out:
> -=09return retval;
> -}
> -
> -static int __init init_aout_binfmt(void)
> -{
> -=09register_binfmt(&aout_format);
> -=09return 0;
> -}
> -
> -static void __exit exit_aout_binfmt(void)
> -{
> -=09unregister_binfmt(&aout_format);
> -}
> -
> -module_init(init_aout_binfmt);
> -module_exit(exit_aout_binfmt);
> -MODULE_LICENSE("GPL");
> --
> 2.29.2

