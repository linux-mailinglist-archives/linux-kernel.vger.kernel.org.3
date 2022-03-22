Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC69F4E44BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbiCVRLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiCVRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:11:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB61F71EE6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:09:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 5so12719283lfp.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CU0h57ixsJaNn7CmDoDJ3QxhAmlE3j6WvVuArIM9L+Y=;
        b=YJqmenmhOu3dyz1TZSzdMTWBurYvNX5FVzJSgwpuQhtv/tRrlehFQS32BblNEEX/5s
         0ttFfA3+rc12taCLby6NEls81KI0LAOgd9Fj3z7cPD7yaEi+tybav9v3foweVEAjn4u7
         wJv6pJl3ggexklkDRHq/kLcHMXEUBEo+fDFken9EB99/sO7+vXfXh/vri4QWq+UdH3Cp
         ygdRclgFkERAo4houDtQrOrBpoyvJtX5Pbt8KrnZINiOiBLMhm6Wdh/r+AfPeay5BNXZ
         urWvvfqyyl8YeHrADXAlz16QNR+JGEzA4mYH6dMBnE5wv/irc1pPSFMzmfGMpqBVmIHg
         4EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CU0h57ixsJaNn7CmDoDJ3QxhAmlE3j6WvVuArIM9L+Y=;
        b=U4qTXqe2jUTdgoTqTapH+fta813FEcyAcgY7QdRgPMFVUMM6EpMSrQowvELZeWfVCB
         FOp2jz2YHVNU5Rua/rl74fvSKJIJ8/sF7GIsWEAHCsd95bdSAJFpPeIGxM5871RZwk5t
         t0LUK+oy3hq5z34n2Z+XHaasQpDxBoIN3o1PcnK68INc79deNR7W0P//BlWDc5195Ds+
         anlM2BHFEgHcQYgtWL2FpKvaByumpkzGztg10vQ8Khi2YnqrZ1cejSqcjVya9KU2MWNd
         iHMF1R3AbSdz4pokwwt1WIk2WCmkmGrqRkkWfOJfE5OHBCEgg7zfNJg+YVvM7HWmY9A5
         UM7w==
X-Gm-Message-State: AOAM532Y977wYjHXDreemxHXh2mgyF9eSEHCwzccqe8qFSX0uvNq0bHp
        FeNBtE791DDLMgypyVsOhZexVJqrZioyip3NDcHepSvx6+66Ag==
X-Google-Smtp-Source: ABdhPJwaDDLcbBydGEpc0aHpEu+biSIFTRbFf0a/cNU+963FH9m973Lokuwmwuo+LqUIes7nFCfessx4/wAXxIWtckw=
X-Received: by 2002:a05:6512:308e:b0:448:3826:6d68 with SMTP id
 z14-20020a056512308e00b0044838266d68mr19043569lfd.184.1647968970052; Tue, 22
 Mar 2022 10:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org> <20220322102115.186179-3-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220322102115.186179-3-ammarfaizi2@gnuweeb.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 22 Mar 2022 10:09:18 -0700
Message-ID: <CAKwvOdkEwkzT0uf9a5SokCScDTY4gbhNFZ+fLxsti9innaEZRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/8] tools/nolibc: Remove .global _start from the
 entry point code
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 3:21 AM Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
>
> Building with clang yields the following error:
> ```
>   <inline asm>:3:1: error: _start changed binding to STB_GLOBAL
>   .global _start
>   ^
>   1 error generated.
> ```
> Make sure only specify one between `.global _start` and `.weak _start`.
> Removing `.global _start`.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Yes, symbols should either be `.weak` or `.global`. The warning from
Clang's integrated assembler is meant to flush out funny business.

I assume there's a good reason _why_ _start is weak and not strong?
Then again, I'm not familiar with nolibc.

>
> Cc: llvm@lists.linux.dev
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
>
> @@ Changelog:
>
>    Link RFC v1: https://lore.kernel.org/llvm/20220320093750.159991-3-ammarfaizi2@gnuweeb.org
>    RFC v1 -> RFC v2:
>     - Remove all `.global _start` for all build (GCC and Clang) instead of
>       removing all `.weak _start` for clang build (Comment from Willy).
> ---
>  tools/include/nolibc/arch-aarch64.h | 1 -
>  tools/include/nolibc/arch-arm.h     | 1 -
>  tools/include/nolibc/arch-i386.h    | 1 -
>  tools/include/nolibc/arch-mips.h    | 1 -
>  tools/include/nolibc/arch-riscv.h   | 1 -
>  tools/include/nolibc/arch-x86_64.h  | 1 -
>  6 files changed, 6 deletions(-)
>
> diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
> index 87d9e434820c..2dbd80d633cb 100644
> --- a/tools/include/nolibc/arch-aarch64.h
> +++ b/tools/include/nolibc/arch-aarch64.h
> @@ -184,7 +184,6 @@ struct sys_stat_struct {
>  /* startup code */
>  asm(".section .text\n"
>      ".weak _start\n"
> -    ".global _start\n"
>      "_start:\n"
>      "ldr x0, [sp]\n"              // argc (x0) was in the stack
>      "add x1, sp, 8\n"             // argv (x1) = sp
> diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
> index 001a3c8c9ad5..1191395b5acd 100644
> --- a/tools/include/nolibc/arch-arm.h
> +++ b/tools/include/nolibc/arch-arm.h
> @@ -177,7 +177,6 @@ struct sys_stat_struct {
>  /* startup code */
>  asm(".section .text\n"
>      ".weak _start\n"
> -    ".global _start\n"
>      "_start:\n"
>  #if defined(__THUMBEB__) || defined(__THUMBEL__)
>      /* We enter here in 32-bit mode but if some previous functions were in
> diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
> index d7e4d53325a3..125a691fc631 100644
> --- a/tools/include/nolibc/arch-i386.h
> +++ b/tools/include/nolibc/arch-i386.h
> @@ -176,7 +176,6 @@ struct sys_stat_struct {
>   */
>  asm(".section .text\n"
>      ".weak _start\n"
> -    ".global _start\n"
>      "_start:\n"
>      "pop %eax\n"                // argc   (first arg, %eax)
>      "mov %esp, %ebx\n"          // argv[] (second arg, %ebx)
> diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
> index c9a6aac87c6d..1a124790c99f 100644
> --- a/tools/include/nolibc/arch-mips.h
> +++ b/tools/include/nolibc/arch-mips.h
> @@ -192,7 +192,6 @@ struct sys_stat_struct {
>  asm(".section .text\n"
>      ".weak __start\n"
>      ".set nomips16\n"
> -    ".global __start\n"
>      ".set    noreorder\n"
>      ".option pic0\n"
>      ".ent __start\n"
> diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
> index bc10b7b5706d..511d67fc534e 100644
> --- a/tools/include/nolibc/arch-riscv.h
> +++ b/tools/include/nolibc/arch-riscv.h
> @@ -185,7 +185,6 @@ struct sys_stat_struct {
>  /* startup code */
>  asm(".section .text\n"
>      ".weak _start\n"
> -    ".global _start\n"
>      "_start:\n"
>      ".option push\n"
>      ".option norelax\n"
> diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
> index a7b70ea51b68..84c174181425 100644
> --- a/tools/include/nolibc/arch-x86_64.h
> +++ b/tools/include/nolibc/arch-x86_64.h
> @@ -199,7 +199,6 @@ struct sys_stat_struct {
>   */
>  asm(".section .text\n"
>      ".weak _start\n"
> -    ".global _start\n"
>      "_start:\n"
>      "pop %rdi\n"                // argc   (first arg, %rdi)
>      "mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
> --
> Ammar Faizi
>


-- 
Thanks,
~Nick Desaulniers
