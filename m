Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57670470F19
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243634AbhLKACB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 19:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhLKACA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 19:02:00 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38586C061714
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:58:24 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m27so20763686lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hzc2OyYJAt2lbZSJwz1fgJGR2irEsqg8E6s4GPhN/s=;
        b=lUxwP25da865wyB1KJXJ7hqqrmEfTOCexv9Of9pFwVMmWik99VDGSNeHLa4mi6MKNz
         1p5LIPPTttE6ci0tgPo4h689vNxJewq6udCUlYWihJqa6MD2wEDEhH3DQrRHAFF6SrIv
         /1fu1oJvemNe8s0UUK/C6gVcLFwuA3BBQdJw6Is8ptalbxgB0eegZAy6Prz3gMieJWBm
         Bqqkc1ihaf+np24CKwtzbZlr6pL61p6ybpdKHVdOAZ+tkQRCICmVqKo9/og+HFY1fSzk
         ZMnKZY/c84OrUxvfx+gAYDdRZiT9BLxZEs3Q2IdhLD5cZZY8hFhVHP1laMOXHAB0t/Db
         gu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hzc2OyYJAt2lbZSJwz1fgJGR2irEsqg8E6s4GPhN/s=;
        b=omvAUSuh7NztcMZBoKSOEWOMwo5AQTC47VqNGknN8oqOf1XAUnn0uah3I+DQJr7r3i
         i7D/t7xGK0gPgAsX+Z8pGUGDDagxd3/pQV+lZgHyVly1l5B8EOkt3qoOWU75MZUpl+fE
         bNvh+1sI3TZ8OIozAlEKpM+cSQi74CaNmijHTgm4irLdGt7pTgkIxFM60Qj7JkaKDTX9
         lRjbLm0qeKvsIfeE+xjI4+NCZg2mTQgS4V+8AC1UxUvROD6EXuxdZDCxbRbacGUh0qod
         PNHk+d8lGUzDxQpLDk3CvRIkAXIqSRxqIRsHUI0sZx7InxFBrzcY3EmizcSpkMKoIc9y
         IFew==
X-Gm-Message-State: AOAM533TPI5dtW4tEUEr+aGOmi74lneEBE4Is2E3XwjT/ijZdLDUT8Wr
        1d8VxR1I3Q9Z+MGWkSDMPSLl3IoH2Lt8MUR3BtKrPQqEBfA=
X-Google-Smtp-Source: ABdhPJxEO+xivz1gsAbgHBoEXkmjQ0NtWOpTFS6QrGfOYgaLPVgUnLA/oDfzsI0IEnL9xEcMUh9cvyWj+UkwcSQNoVY=
X-Received: by 2002:a05:6512:3d16:: with SMTP id d22mr14831625lfv.523.1639180702228;
 Fri, 10 Dec 2021 15:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20211210234953.3420108-1-nathan@kernel.org>
In-Reply-To: <20211210234953.3420108-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Dec 2021 15:58:10 -0800
Message-ID: <CAKwvOdk_iKGo2qBaq4j6m-sUR6Erff8gOneFBP=-=qWYOm9WtA@mail.gmail.com>
Subject: Re: [PATCH] x86/extable: Fix extable_type_reg macro with Clang LTO
To:     Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 3:51 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> When building x86_64_defconfig + CONFIG_LTO_CLANG_FULL=y after
> commit a90a845d94b4 ("x86/extable: Extend extable functionality"), the
> build fails during linking:
>
> ld.lld: error: <inline asm>:64:2: macro 'extable_type_reg' is already defined
>         .macro extable_type_reg type:req reg:req
>         ^
>
> The build failures happens because the definition of extable_type_reg
> happens in every source file that includes asm.h, which all get combined
> together during LTO.
>
> Commit be604c616ca7 ("arm64: sysreg: Make mrs_s and msr_s macros work
> with Clang and LTO") ran into a similar issue and the solution was to
> define, use, then undefine the macro within each inline asm block it was
> needed in.
>
> Break apart the inline asm macro definition into two macros
> ({,UN}DEFINE_EXTABLE_TYPE_REG) and use them in _ASM_EXTABLE_TYPE so
> there is no more error with LTO.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1513
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for coming up with a fix.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> I expect this to be squashed into commit a90a845d94b4 ("x86/extable:
> Extend extable functionality") in Peter's x86/wip.extable branch to
> avoid bisect issues. The description and link are there for archaeology.

SGTM; feel free to carry over my tested by tag in that case.

>
>  arch/x86/include/asm/asm.h | 52 ++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 24 deletions(-)
>
> diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
> index 95bb23082b87..c878fed3056f 100644
> --- a/arch/x86/include/asm/asm.h
> +++ b/arch/x86/include/asm/asm.h
> @@ -152,30 +152,32 @@
>
>  #else /* ! __ASSEMBLY__ */
>
> -asm(
> -"      .macro extable_type_reg type:req reg:req\n"
> -"      .set found, 0\n"
> -"      .set regnr, 0\n"
> -"      .irp rs,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15\n"
> -"      .ifc \\reg, %\\rs\n"
> -"      .set found, found+1\n"
> -"      .long \\type + (regnr << 8)\n"
> -"      .endif\n"
> -"      .set regnr, regnr+1\n"
> -"      .endr\n"
> -"      .set regnr, 0\n"
> -"      .irp rs,eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d\n"
> -"      .ifc \\reg, %\\rs\n"
> -"      .set found, found+1\n"
> -"      .long \\type + (regnr << 8)\n"
> -"      .endif\n"
> -"      .set regnr, regnr+1\n"
> -"      .endr\n"
> -"      .if (found != 1)\n"
> -"      .error \"extable_type_reg: bad register argument\"\n"
> -"      .endif\n"
> -"      .endm\n"
> -);
> +# define DEFINE_EXTABLE_TYPE_REG \
> +       ".macro extable_type_reg type:req reg:req\n"                                            \
> +       ".set found, 0\n"                                                                       \
> +       ".set regnr, 0\n"                                                                       \
> +       ".irp rs,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15\n"               \
> +       ".ifc \\reg, %%\\rs\n"                                                                  \
> +       ".set found, found+1\n"                                                                 \
> +       ".long \\type + (regnr << 8)\n"                                                         \
> +       ".endif\n"                                                                              \
> +       ".set regnr, regnr+1\n"                                                                 \
> +       ".endr\n"                                                                               \
> +       ".set regnr, 0\n"                                                                       \
> +       ".irp rs,eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d\n"       \
> +       ".ifc \\reg, %%\\rs\n"                                                                  \
> +       ".set found, found+1\n"                                                                 \
> +       ".long \\type + (regnr << 8)\n"                                                         \
> +       ".endif\n"                                                                              \
> +       ".set regnr, regnr+1\n"                                                                 \
> +       ".endr\n"                                                                               \
> +       ".if (found != 1)\n"                                                                    \
> +       ".error \"extable_type_reg: bad register argument\"\n"                                  \
> +       ".endif\n"                                                                              \
> +       ".endm\n"
> +
> +# define UNDEFINE_EXTABLE_TYPE_REG \
> +       ".purgem extable_type_reg\n"
>
>  # define _ASM_EXTABLE_TYPE(from, to, type)                     \
>         " .pushsection \"__ex_table\",\"a\"\n"                  \
> @@ -190,7 +192,9 @@ asm(
>         " .balign 4\n"                                                          \
>         " .long (" #from ") - .\n"                                              \
>         " .long (" #to ") - .\n"                                                \
> +       DEFINE_EXTABLE_TYPE_REG                                                 \
>         "extable_type_reg reg=" __stringify(reg) ", type=" __stringify(type) " \n"\
> +       UNDEFINE_EXTABLE_TYPE_REG                                               \
>         " .popsection\n"
>
>  /* For C file, we already have NOKPROBE_SYMBOL macro */
>
> base-commit: fa04e38818aeac177f730cfeadfbdb6f7c25f5b4
> --
> 2.34.1
>
>


-- 
Thanks,
~Nick Desaulniers
