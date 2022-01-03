Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578CC482EBA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 08:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiACHah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 02:30:37 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:23042 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiACHag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:30:36 -0500
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2037U8rC002866;
        Mon, 3 Jan 2022 16:30:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2037U8rC002866
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1641195009;
        bh=Q4N4pyt3k5xc5akbM1fMeGbDBN+5P/qoHX4LoFCURZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dcZizZ8p+8OxgL28/fZcq505gsbf1u/7e8Ka+6OerXdRHFurGX3adX5YMOGCEWzf8
         tmomwybOn8Ry38TGkU7ha3Ri65P1ppq+d03br8tHWcfHwEWsRywrnT287+tHcrFenJ
         LyV6aPK+YDQmoL5A+PHMS76WrXVq8yfMlerUFq2YMnNVp0b1786d8C1QQN5chsBzcD
         l1mjAe1x8IeZSBgE6PjRdxcWfLoc25XT/Vj8Hw1UOmgGfz6AtvzCbHRxMs+MsR//j/
         mEMq5xJqULrsdGS5tDIgsbsAscIAge2N3y+7D/7K6MmuFKhIsTeRiTYNZcnbv/lWTO
         n44mnXZ+4WRAw==
X-Nifty-SrcIP: [209.85.210.176]
Received: by mail-pf1-f176.google.com with SMTP id t187so15225687pfb.11;
        Sun, 02 Jan 2022 23:30:08 -0800 (PST)
X-Gm-Message-State: AOAM532X9Cb7PfOuDvEepT7kvOd2rR0o2vE+1FIGVyDSWzRXj0viZLIJ
        RXTjTZ+jmr5GI2skcigfd+W9c9SSsezDWmJJnTU=
X-Google-Smtp-Source: ABdhPJyQeq2KyC8k1IjK4sk+CNmFy3cPWLH/65C3uwwjeVfRHRqNFBVMinDmiwdvtujwUsnpZZkAgtXxv2AA/sGRLv8=
X-Received: by 2002:a62:83c3:0:b0:4ba:bb14:4bf7 with SMTP id
 h186-20020a6283c3000000b004babb144bf7mr44853082pfe.32.1641195007963; Sun, 02
 Jan 2022 23:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20211231075551.589515-1-xu.xin16@zte.com.cn>
In-Reply-To: <20211231075551.589515-1-xu.xin16@zte.com.cn>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 3 Jan 2022 16:29:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARBGWP4pj4t2XStG326BB3XFnJwKOMQqR7RXd5nDCPmWA@mail.gmail.com>
Message-ID: <CAK7LNARBGWP4pj4t2XStG326BB3XFnJwKOMQqR7RXd5nDCPmWA@mail.gmail.com>
Subject: Re: [PATCH] Fix compilation errors when using special directory
To:     cgel.zte@gmail.com
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xu xin <xu.xin16@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 4:56 PM <cgel.zte@gmail.com> wrote:
>
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
>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>


This depends on what shell you are using.


If you use a modern shell like bash,
~ is expanded into the home directory path
on the shell side.

So, Make will see the absolute path.
In contrast, dash does not expand ~.


[Test code]
$(warning CROSS_COMPILE is $(CROSS_COMPILE))
all:
        @:



[Result]
masahiro@grover:/tmp$ bash
masahiro@grover:/tmp$ make
CROSS_COMPILE=~/x86_64_gcc9.2.0_glibc2.31.0/bin/x86_64-pc-linux-gnu-
all
Makefile:1: CROSS_COMPILE is
/home/masahiro/x86_64_gcc9.2.0_glibc2.31.0/bin/x86_64-pc-linux-gnu-
masahiro@grover:/tmp$ dash
$ make CROSS_COMPILE=~/x86_64_gcc9.2.0_glibc2.31.0/bin/x86_64-pc-linux-gnu- all
Makefile:1: CROSS_COMPILE is
~/x86_64_gcc9.2.0_glibc2.31.0/bin/x86_64-pc-linux-gnu-





Moreover, your patch does not work at all because
the $(realpath ) built-in function does not expand ~.

~ is a shell's special character (and only some shells recognize it).
GNU Make is completely agnostic about such a character.



If you are using such a shell that does not understand ~,
as Nathan suggested, you can use $HOME.



> ---
>  Makefile | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index fe5a4d8e4ac5..cdbb747787ac 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -459,14 +459,14 @@ OBJDUMP           = llvm-objdump
>  READELF                = llvm-readelf
>  STRIP          = llvm-strip
>  else
> -CC             = $(CROSS_COMPILE)gcc
> -LD             = $(CROSS_COMPILE)ld
> -AR             = $(CROSS_COMPILE)ar
> -NM             = $(CROSS_COMPILE)nm
> -OBJCOPY                = $(CROSS_COMPILE)objcopy
> -OBJDUMP                = $(CROSS_COMPILE)objdump
> -READELF                = $(CROSS_COMPILE)readelf
> -STRIP          = $(CROSS_COMPILE)strip
> +CC             = $(realpath $(CROSS_COMPILE))gcc
> +LD             = $(realpath $(CROSS_COMPILE))ld
> +AR             = $(realpath $(CROSS_COMPILE))ar
> +NM             = $(realpath $(CROSS_COMPILE))nm
> +OBJCOPY                = $(realpath $(CROSS_COMPILE))objcopy
> +OBJDUMP                = $(realpath $(CROSS_COMPILE))objdump
> +READELF                = $(realpath $(CROSS_COMPILE))readelf
> +STRIP          = $(realpath $(CROSS_COMPILE))strip
>  endif
>  RUSTC          = rustc
>  RUSTDOC                = rustdoc
> --
> 2.25.1
>


--
Best Regards
Masahiro Yamada
