Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5D64DBCD2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358422AbiCQCGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352830AbiCQCGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:06:10 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6FD1E3EE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:04:53 -0700 (PDT)
Date:   Thu, 17 Mar 2022 02:04:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theinnocuous.com;
        s=protonmail; t=1647482691;
        bh=g1vw4pgWe5qxlGdq8erecfh8s9xp7QSO6YFIB+9Qkh4=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=U4thnzlydYwy3meEiVrzkGjoJSjnKDAwJDe3NSoQUIXTeQCwry1+qgN1M3ZAngwz+
         E24jctkiiL70tEXWi6SbHwzev6GeEQ5ZuayLj4GjgZXLrvooUxbYXWFdOXNJD1xr1G
         DE4DgNqcLHKAj/v5z2M3rhXA03129ngaT36nwOUyHJo/pWSq2upktxqC9YFgPbTtHI
         6frlClVWEGZgkC1z9y9fmDHjHSjO6hKzcHyEDasZQ/71zbPFmPt2EK3GNF0ze/bOw7
         jnVsYQ4GQ4bi1cBcOZqdoVQ34APCemCIZFly5uom5hDB5wZvO1Dgsrv7og5Ry1fB+1
         Cc5erbLAfhp0w==
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>
From:   James Jones <linux@theinnocuous.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: James Jones <linux@theinnocuous.com>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <59fb3d14-423a-d39b-04cb-1e60ee67d3f1@theinnocuous.com>
In-Reply-To: <202203161523.857B469@keescook>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com> <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com> <202203151150.1CDB1D8DA@keescook> <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com> <CAK8P3a28dpyEM2+vM+ePZzeFc539b7w_8FDEoRke-j+3AQVZAA@mail.gmail.com> <202203161523.857B469@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/22 3:30 PM, Kees Cook wrote:
> On Wed, Mar 16, 2022 at 01:38:31PM +0100, Arnd Bergmann wrote:
>> is in the end, but it's likely easier than a standalone a.out loader
>> in user space, or a conversion to ELF format.
>
> Yeah, the exec format is really simple. The only tricky bit was preparing
> the stack and making sure everything landed in the right place for text
> and data. James, can you try this? aln and mac run for me, but I'm not
> actually exercising them beyond dumping argument lists, etc:
>
> https://github.com/kees/kernel-tools/tree/trunk/a.out

Yes, works perfectly, thank you. I like the idea of using this much
better than getting emailed every time someone wants to delete the a.out
code again. Consider my use case withdrawn. I've already pushed an
update to my jaguar-sdk project to use this tool instead.

-James

> $ make
> cc -Wall -m32    aout.c   -o aout
> $ ./aout aln --help
> mmap: Operation not permitted
> /proc/sys/vm/mmap_min_addr is set to 65536 but QMAGIC a.out binaries must=
 be mapped at 4096.
> To temporarily change this, run: sudo sysctl -w vm.mmap_min_addr=3D4096
> $ sudo sysctl -w vm.mmap_min_addr=3D4096
> vm.mmap_min_addr =3D 4096
> $ ./aout aln --help
> aln: unrecognized option `--help'
> Usage: aln [-options] <files|-x file|-i[i] <fname> <label>>
> Where options are:
> ?: print this
> a <text> <data> <bss>: output absolute file
>          hex value: segment address
>          r: relocatable segment
>          x: contiguous segment
> ...
>
>
>
> /*
>   * Execute a static QMAGIC ia32 a.out binary.
>   * Copyright 2022 Kees Cook <keescook@chromium.org>
>   * License: GPLv2
>   */
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <string.h>
> #include <sys/time.h>
> #include <sys/resource.h>
>
> /* Locally define the stuff from a.out.h since that file may disappear. *=
/
> struct a_out
> {
> =09unsigned int a_info;=09/* machine type, magic, etc */
> =09unsigned int a_text;=09/* text size */
> =09unsigned int a_data;=09/* data size */
> =09unsigned int a_bss;=09/* desired bss size */
> =09unsigned int a_syms;=09/* symbol table size */
> =09unsigned int a_entry;=09/* entry address */
> =09unsigned int a_trsize;=09/* text relocation size */
> =09unsigned int a_drsize;=09/* data relocation size */
> };
>
> #define Q_MAGIC_LOAD_ADDR=090x1000
> #define MMAP_MIN_ADDR_PATH=09"/proc/sys/vm/mmap_min_addr"
>
> #define ALIGN(x, a)=09=09ALIGN_MASK(x, (unsigned long)(a) - 1)
> #define ALIGN_MASK(x, mask)=09(typeof(x))(((unsigned long)(x) + (mask)) &=
 ~(mask))
>
> static void check_mmap_min_addr(void)
> {
> =09unsigned long addr;
> =09char buf[128], *result;
> =09FILE *proc;
>
> =09proc =3D fopen(MMAP_MIN_ADDR_PATH, "r");
> =09if (!proc)
> =09=09return;
> =09result =3D fgets(buf, sizeof(buf), proc);
> =09fclose(proc);
> =09if (!result)
> =09=09return;
>
> =09addr =3D strtoul(result, NULL, 0);
> =09if (addr <=3D Q_MAGIC_LOAD_ADDR)
> =09=09return;
>
> =09fprintf(stderr, "%s is set to %lu but QMAGIC a.out binaries must be ma=
pped at %u.\n",
> =09=09MMAP_MIN_ADDR_PATH, addr, Q_MAGIC_LOAD_ADDR);
> =09fprintf(stderr, "To temporarily change this, run: sudo sysctl -w vm.mm=
ap_min_addr=3D%u\n",
> =09=09Q_MAGIC_LOAD_ADDR);
> }
>
> int main(int argc, char *argv[], char *envp[])
> {
> =09const unsigned long qmagic =3D 0x006400cc;
> =09struct a_out *aout;
> =09struct stat info;
> =09unsigned char *image, *image_end, *bss, *bss_end, *stack, *stack_end;
> =09char **p;
> =09unsigned long *sp;
> =09struct rlimit rlim;
> =09int pagesize;
> =09int fd;
> =09int argc_copy, envc_copy;
> =09char **argv_copy, **envp_copy;
>
> =09if (sizeof(void *) !=3D 4) {
> =09=09fprintf(stderr, "Eek: I was compiled in 64-bit mode. Please build w=
ith -m32.\n");
> =09=09return 1;
> =09}
>
> =09if (argc < 2) {
> =09=09fprintf(stderr, "Usage: %s a.out [arg ...]\n", argv[0]);
> =09=09return 1;
> =09}
>
> =09fd =3D open(argv[1], O_RDONLY);
> =09if (fd < 0) {
> =09=09perror(argv[1]);
> =09=09return 1;
> =09}
>
> =09if (fstat(fd, &info) < 0) {
> =09=09perror(argv[1]);
> =09=09return 1;
> =09}
>
> =09if (info.st_size < sizeof(*aout)) {
> =09=09fprintf(stderr, "%s: too small to read a.out header\n", argv[1]);
> =09=09return 1;
> =09}
>
> =09/* Load file into memory at Q_MAGIC_LOAD_ADDR. */
> =09pagesize =3D getpagesize();
> =09image =3D mmap((void *)Q_MAGIC_LOAD_ADDR, info.st_size, PROT_EXEC | PR=
OT_READ | PROT_WRITE,
> =09=09=09MAP_FIXED | MAP_PRIVATE, fd, 0);
> =09if (image =3D=3D MAP_FAILED) {
> =09=09perror("mmap");
> =09=09check_mmap_min_addr();
> =09=09return 1;
> =09}
> =09image_end =3D ALIGN(image + info.st_size, pagesize);
>
> =09aout =3D (struct a_out *)image;
> =09if (aout->a_info !=3D qmagic) {
> =09=09fprintf(stderr, "%s: not ia32 QMAGIC a.out binary (header 0x%x !=3D=
 expected 0x%lx)\n",
> =09=09=09argv[1], aout->a_info, qmagic);
> =09=09return 1;
> =09}
>
> =09if (aout->a_syms !=3D 0) {
> =09=09fprintf(stderr, "%s: a.out header a_syms must be 0.\n", argv[1]);
> =09=09return 1;
> =09}
>
> =09if (aout->a_trsize !=3D 0) {
> =09=09fprintf(stderr, "%s: a.out header a_trsize must be 0.\n", argv[1]);
> =09=09return 1;
> =09}
>
> =09if (aout->a_drsize !=3D 0) {
> =09=09fprintf(stderr, "%s: a.out header a_drsize must be 0.\n", argv[1]);
> =09=09return 1;
> =09}
>
> =09/* See if .bss needs to extend beyond end of the file mmap. */
> =09bss =3D image + aout->a_text + aout->a_data;
> =09bss_end =3D bss + aout->a_bss;
> =09if (bss_end > image_end) {
> =09=09bss =3D mmap(bss, aout->a_bss, PROT_READ | PROT_WRITE,
> =09=09=09   MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> =09=09if (bss =3D=3D MAP_FAILED) {
> =09=09=09perror("mmap bss");
> =09=09=09return 1;
> =09=09}
> =09}
> =09/* Zero out .bss. */
> =09memset(bss, 0, ALIGN(aout->a_bss, pagesize));
>
> =09/* Prepare stack, based on current stack. */
> =09if (getrlimit(RLIMIT_STACK, &rlim) < 0) {
> =09=09perror("getrlimit");
> =09=09return 1;
> =09}
>
> =09/* Default to 8MiB */
> =09if (rlim.rlim_cur =3D=3D RLIM_INFINITY)
> =09=09rlim.rlim_cur =3D 8 * 1024 * 1024;
>
> =09stack =3D mmap(NULL, rlim.rlim_cur, PROT_EXEC | PROT_READ | PROT_WRITE=
,
> =09=09=09MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> =09if (stack =3D=3D MAP_FAILED) {
> =09=09perror("mmap stack");
> =09=09return 1;
> =09}
> =09stack_end =3D ALIGN(stack + rlim.rlim_cur, pagesize);
>
> =09/* Fill top of stack with arg/env pointers. */
> =09sp =3D (unsigned long *)stack_end;
> =09sp--;
>
> =09/* do not include argv[0] */
> =09argc_copy =3D argc - 1;
> =09argv++;
>
> =09/* count envp */
> =09for (envc_copy =3D 0, p =3D envp; *p; envc_copy++, p++) ;
>
> =09/* make room for envp pointers */
> =09sp -=3D envc_copy + 1;
> =09envp_copy =3D (char **)sp;
> =09/* make room for argv pointers */
> =09sp -=3D argc_copy + 1;
> =09argv_copy =3D (char **)sp;
>
> =09/* store pointers and argc */
> =09*--sp =3D (unsigned long)envp_copy;
> =09*--sp =3D (unsigned long)argv_copy;
> =09*--sp =3D (unsigned long)argc_copy;
>
> =09/* copy argv pointer (contents can stay where they already are) */
> =09while (argc_copy--)
> =09=09*argv_copy++ =3D *argv++;
> =09*argv_copy =3D 0;
>
> =09/* copy envp (contents can stay where they already are) */
> =09while (envc_copy--)
> =09=09*envp_copy++ =3D *envp++;
>
> =09/* Aim sp at argc, and jump! */
> =09asm volatile ("movl %0, %%esp\njmp *%1\n" : : "rm" (sp), "r"(aout->a_e=
ntry) );
>
> =09/* This should be unreachable. */
> =09fprintf(stderr, "They found me. I don't how, but they found me.\n");
> =09return 2;
> }
>
> --
> Kees Cook

