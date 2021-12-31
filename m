Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980FB482541
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhLaRF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:05:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57870 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhLaRF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:05:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EBC0B81DA2;
        Fri, 31 Dec 2021 17:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2173C36AEB;
        Fri, 31 Dec 2021 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640970324;
        bh=zduF9AW9sjmtmk87LuFId0jVscQzWkyCrlV7snXQ7Pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=udRF+qkfLf4kfmmBvldb6PfeKZsjmZE+MbbRU/GldTVbQmHDPeia3/s42Gt274wdH
         1EjVHM/5bRDJlRWo4pWMhiSgYxAP1sCt3BY6pVVLhs0L2mFn7Cisc3K/Fihlbarjuy
         dVGVq3l+JV55wAEh0JLLYqyjNrPmtmya40WPq6B1ooXAMQKqpbPx5dSYaCtpWgRPFP
         D2NFyJyKcdUgHgfhbD66pRL+TyM9TdUJYKrAPi0xn4HVyuUE6ADmyjM7yOFiS32HK/
         ro0pgx+K6eo4kcWCahIhx5pcbGWmeaz+WMcs0GAkzrIByxRiyq/2+Hz4p1p4Dk8Fe3
         c5s0353uxJIHw==
Date:   Fri, 31 Dec 2021 10:05:20 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH] Fix compilation errors when using special directory
Message-ID: <Yc84UG6nwqyb37o2@archlinux-ax161>
References: <20211231075551.589515-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231075551.589515-1-xu.xin16@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 07:55:51AM +0000, cgel.zte@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> When we compile the kernel with cross compilers, if CROSS_COMPILE is
> specified by the path containing special directory like '~', some
> compilation error will occurs.
> 
> Here's an example:
> 
> $ make ARCH=x86_64
> CROSS_COMPILE=~/x86_64_gcc9.2.0_glibc2.31.0/bin/x86_64-pc-linux-gnu- all
> 
> error:./scripts/mkcompile_h: line 64:
> ~/x86_64_gcc9.2.0_glibc2.31.0/bin/x86_64-pc-linux-gnu-ld: No such file or
> directory
> 
> Since there are many other similar scripts using these variables, in
> order to solve the problem from the source, add realpath in makefile to
> turn these variables into absolute paths.

This is not going to work for the traditional approach of CROSS_COMPILE
being just a triple, rather than a full path plus a triple, because

$(realpath $(CROSS_COMPILE))

is going to evaluate to nothing in that case:

$ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig all
warning: ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum
ld: unrecognised emulation mode: aarch64linux
Supported emulations: elf_x86_64 elf32_x86_64 elf_i386 elf_iamcu elf_l1om elf_k1om i386pep i386pe
make[2]: *** [arch/arm64/kernel/vdso/Makefile:57: arch/arm64/kernel/vdso/vdso.so.dbg] Error 1
...

Why not just change '~' to '$HOME' in your build scripts so that it is
evaluated before the make command begins?

> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>  Makefile | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index fe5a4d8e4ac5..cdbb747787ac 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -459,14 +459,14 @@ OBJDUMP		= llvm-objdump
>  READELF		= llvm-readelf
>  STRIP		= llvm-strip
>  else
> -CC		= $(CROSS_COMPILE)gcc
> -LD		= $(CROSS_COMPILE)ld
> -AR		= $(CROSS_COMPILE)ar
> -NM		= $(CROSS_COMPILE)nm
> -OBJCOPY		= $(CROSS_COMPILE)objcopy
> -OBJDUMP		= $(CROSS_COMPILE)objdump
> -READELF		= $(CROSS_COMPILE)readelf
> -STRIP		= $(CROSS_COMPILE)strip
> +CC		= $(realpath $(CROSS_COMPILE))gcc
> +LD		= $(realpath $(CROSS_COMPILE))ld
> +AR		= $(realpath $(CROSS_COMPILE))ar
> +NM		= $(realpath $(CROSS_COMPILE))nm
> +OBJCOPY		= $(realpath $(CROSS_COMPILE))objcopy
> +OBJDUMP		= $(realpath $(CROSS_COMPILE))objdump
> +READELF		= $(realpath $(CROSS_COMPILE))readelf
> +STRIP		= $(realpath $(CROSS_COMPILE))strip
>  endif
>  RUSTC		= rustc
>  RUSTDOC		= rustdoc
> -- 
> 2.25.1
> 
