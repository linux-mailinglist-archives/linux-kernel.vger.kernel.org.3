Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D758E4DBAAA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiCPWbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 18:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiCPWbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:31:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF3FF61
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:30:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso5983707pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kPlqUJrQWu0IAkzBC9W9JiD0zP1UEGLgfkVOoVLya6o=;
        b=lS3popOVLSYQ7vwrjTYrjAdiJcspI4KHS3LMtsOJaw1fvaSEHt/nkx+oiNWKhvweDy
         nYp8wvsz9uFdQvWWCZvt0kIgJYi+ooQybbLXjJUXCW9HshmXLMiDEW27LxCaCPyxVB3f
         XtnQvYQT3piH0s2om40BT6AkLum0NYtJd4XMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kPlqUJrQWu0IAkzBC9W9JiD0zP1UEGLgfkVOoVLya6o=;
        b=EOJTR5F0dQplGGlR4p3ngxlMsP8JOAns21M8j+zg3U/ytna48SJQUIUp9feR2B8bVj
         wKmqCGdjN8dz2F7Bjp9OneUgRUew1gaRFbHxfVS60aSoNeV3TbPmBofT0y+MSH2P/UL4
         nBx70tCOcuhw9JGIsb7ijWdflTyhSQxUeb+qAVwszir3UOFtRoPCQhDFfzCJ3i3Sd5NJ
         WSrVu9i24pHC49h7p3dg1fvYUcr4s2yiZqcmUKt/WR15WJOgMyhFy0tz+gAdMt0IykFu
         NmpOJXg9d4O//C3ywOVrhHRxwo06V1VL+5UHRr3jXCfMQYpWog8xSJ//OCWmvkHXeRmI
         JzbA==
X-Gm-Message-State: AOAM533dXu8bYExP6q5E0kDNlCRE/Do0mdNtfcYChM+EJO2kkVIMQD7m
        PpNkDbf1/Hnn6ipVI5Irk17Avg==
X-Google-Smtp-Source: ABdhPJypup/WCjhC/LYM1s6EjoMoVRNK3RGKzke3VAFYSpgY/dnT2wKiFCexetZnL9swKgfi84f/zw==
X-Received: by 2002:a17:902:e741:b0:151:ffbd:37ea with SMTP id p1-20020a170902e74100b00151ffbd37eamr2070996plf.100.1647469806247;
        Wed, 16 Mar 2022 15:30:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 63-20020a630942000000b00372a99c1821sm3445719pgj.21.2022.03.16.15.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 15:30:05 -0700 (PDT)
Date:   Wed, 16 Mar 2022 15:30:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Jones <linux@theinnocuous.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <202203161523.857B469@keescook>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
 <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com>
 <202203151150.1CDB1D8DA@keescook>
 <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
 <CAK8P3a28dpyEM2+vM+ePZzeFc539b7w_8FDEoRke-j+3AQVZAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a28dpyEM2+vM+ePZzeFc539b7w_8FDEoRke-j+3AQVZAA@mail.gmail.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:38:31PM +0100, Arnd Bergmann wrote:
> is in the end, but it's likely easier than a standalone a.out loader
> in user space, or a conversion to ELF format.

Yeah, the exec format is really simple. The only tricky bit was preparing
the stack and making sure everything landed in the right place for text
and data. James, can you try this? aln and mac run for me, but I'm not
actually exercising them beyond dumping argument lists, etc:

https://github.com/kees/kernel-tools/tree/trunk/a.out

$ make
cc -Wall -m32    aout.c   -o aout
$ ./aout aln --help
mmap: Operation not permitted
/proc/sys/vm/mmap_min_addr is set to 65536 but QMAGIC a.out binaries must be mapped at 4096.
To temporarily change this, run: sudo sysctl -w vm.mmap_min_addr=4096
$ sudo sysctl -w vm.mmap_min_addr=4096
vm.mmap_min_addr = 4096
$ ./aout aln --help
aln: unrecognized option `--help'
Usage: aln [-options] <files|-x file|-i[i] <fname> <label>>
Where options are:
?: print this
a <text> <data> <bss>: output absolute file
        hex value: segment address
        r: relocatable segment
        x: contiguous segment
...



/*
 * Execute a static QMAGIC ia32 a.out binary.
 * Copyright 2022 Kees Cook <keescook@chromium.org>
 * License: GPLv2
 */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <string.h>
#include <sys/time.h>
#include <sys/resource.h>

/* Locally define the stuff from a.out.h since that file may disappear. */
struct a_out
{
	unsigned int a_info;	/* machine type, magic, etc */
	unsigned int a_text;	/* text size */
	unsigned int a_data;	/* data size */
	unsigned int a_bss;	/* desired bss size */
	unsigned int a_syms;	/* symbol table size */
	unsigned int a_entry;	/* entry address */
	unsigned int a_trsize;	/* text relocation size */
	unsigned int a_drsize;	/* data relocation size */
};

#define Q_MAGIC_LOAD_ADDR	0x1000
#define MMAP_MIN_ADDR_PATH	"/proc/sys/vm/mmap_min_addr"

#define ALIGN(x, a)		ALIGN_MASK(x, (unsigned long)(a) - 1)
#define ALIGN_MASK(x, mask)	(typeof(x))(((unsigned long)(x) + (mask)) & ~(mask))

static void check_mmap_min_addr(void)
{
	unsigned long addr;
	char buf[128], *result;
	FILE *proc;

	proc = fopen(MMAP_MIN_ADDR_PATH, "r");
	if (!proc)
		return;
	result = fgets(buf, sizeof(buf), proc);
	fclose(proc);
	if (!result)
		return;

	addr = strtoul(result, NULL, 0);
	if (addr <= Q_MAGIC_LOAD_ADDR)
		return;

	fprintf(stderr, "%s is set to %lu but QMAGIC a.out binaries must be mapped at %u.\n",
		MMAP_MIN_ADDR_PATH, addr, Q_MAGIC_LOAD_ADDR);
	fprintf(stderr, "To temporarily change this, run: sudo sysctl -w vm.mmap_min_addr=%u\n",
		Q_MAGIC_LOAD_ADDR);
}

int main(int argc, char *argv[], char *envp[])
{
	const unsigned long qmagic = 0x006400cc;
	struct a_out *aout;
	struct stat info;
	unsigned char *image, *image_end, *bss, *bss_end, *stack, *stack_end;
	char **p;
	unsigned long *sp;
	struct rlimit rlim;
	int pagesize;
	int fd;
	int argc_copy, envc_copy;
	char **argv_copy, **envp_copy;

	if (sizeof(void *) != 4) {
		fprintf(stderr, "Eek: I was compiled in 64-bit mode. Please build with -m32.\n");
		return 1;
	}

	if (argc < 2) {
		fprintf(stderr, "Usage: %s a.out [arg ...]\n", argv[0]);
		return 1;
	}

	fd = open(argv[1], O_RDONLY);
	if (fd < 0) {
		perror(argv[1]);
		return 1;
	}

	if (fstat(fd, &info) < 0) {
		perror(argv[1]);
		return 1;
	}

	if (info.st_size < sizeof(*aout)) {
		fprintf(stderr, "%s: too small to read a.out header\n", argv[1]);
		return 1;
	}

	/* Load file into memory at Q_MAGIC_LOAD_ADDR. */
	pagesize = getpagesize();
	image = mmap((void *)Q_MAGIC_LOAD_ADDR, info.st_size, PROT_EXEC | PROT_READ | PROT_WRITE,
			MAP_FIXED | MAP_PRIVATE, fd, 0);
	if (image == MAP_FAILED) {
		perror("mmap");
		check_mmap_min_addr();
		return 1;
	}
	image_end = ALIGN(image + info.st_size, pagesize);

	aout = (struct a_out *)image;
	if (aout->a_info != qmagic) {
		fprintf(stderr, "%s: not ia32 QMAGIC a.out binary (header 0x%x != expected 0x%lx)\n",
			argv[1], aout->a_info, qmagic);
		return 1;
	}

	if (aout->a_syms != 0) {
		fprintf(stderr, "%s: a.out header a_syms must be 0.\n", argv[1]);
		return 1;
	}

	if (aout->a_trsize != 0) {
		fprintf(stderr, "%s: a.out header a_trsize must be 0.\n", argv[1]);
		return 1;
	}

	if (aout->a_drsize != 0) {
		fprintf(stderr, "%s: a.out header a_drsize must be 0.\n", argv[1]);
		return 1;
	}

	/* See if .bss needs to extend beyond end of the file mmap. */
	bss = image + aout->a_text + aout->a_data;
	bss_end = bss + aout->a_bss;
	if (bss_end > image_end) {
		bss = mmap(bss, aout->a_bss, PROT_READ | PROT_WRITE,
			   MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
		if (bss == MAP_FAILED) {
			perror("mmap bss");
			return 1;
		}
	}
	/* Zero out .bss. */
	memset(bss, 0, ALIGN(aout->a_bss, pagesize));

	/* Prepare stack, based on current stack. */
	if (getrlimit(RLIMIT_STACK, &rlim) < 0) {
		perror("getrlimit");
		return 1;
	}

	/* Default to 8MiB */
	if (rlim.rlim_cur == RLIM_INFINITY)
		rlim.rlim_cur = 8 * 1024 * 1024;

	stack = mmap(NULL, rlim.rlim_cur, PROT_EXEC | PROT_READ | PROT_WRITE,
			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
	if (stack == MAP_FAILED) {
		perror("mmap stack");
		return 1;
	}
	stack_end = ALIGN(stack + rlim.rlim_cur, pagesize);

	/* Fill top of stack with arg/env pointers. */
	sp = (unsigned long *)stack_end;
	sp--;

	/* do not include argv[0] */
	argc_copy = argc - 1;
	argv++;

	/* count envp */
	for (envc_copy = 0, p = envp; *p; envc_copy++, p++) ;

	/* make room for envp pointers */
	sp -= envc_copy + 1;
	envp_copy = (char **)sp;
	/* make room for argv pointers */
	sp -= argc_copy + 1;
	argv_copy = (char **)sp;

	/* store pointers and argc */
	*--sp = (unsigned long)envp_copy;
	*--sp = (unsigned long)argv_copy;
	*--sp = (unsigned long)argc_copy;

	/* copy argv pointer (contents can stay where they already are) */
	while (argc_copy--)
		*argv_copy++ = *argv++;
	*argv_copy = 0;

	/* copy envp (contents can stay where they already are) */
	while (envc_copy--)
		*envp_copy++ = *envp++;

	/* Aim sp at argc, and jump! */
	asm volatile ("movl %0, %%esp\njmp *%1\n" : : "rm" (sp), "r"(aout->a_entry) );

	/* This should be unreachable. */
	fprintf(stderr, "They found me. I don't how, but they found me.\n");
	return 2;
}

-- 
Kees Cook
