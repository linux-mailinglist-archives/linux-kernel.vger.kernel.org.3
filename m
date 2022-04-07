Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09AE4F8573
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbiDGREO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiDGREM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:04:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072581C9469
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:02:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p15so10726608lfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4JoFgaKGIZUP7KITjsD6hBXU6fdMuUm3RdP1CdyCDI=;
        b=OVFCZOWIp5y7/AJi9Et7KmPBLKPHMI36qDMx5PqDxixFE7nKxAFB4GSkDvapVcKwGH
         hShmwrmClVvsoJYj+aqXjS6WHYq2lAvRR5bEboyWL6hSdQJSsAB+KOoAjgIi3nB2qHia
         6tawm+6J/soBtpu0v0pGCB7uzMjqWRG0XLO3MyYn03zz1YGGFDHmvQayo952zlNCCStr
         VkAHZrpMYryTpsRSpfaJqvthwMPf+SNbYWs6OIKZ8haYg/CiABHZ8Yrg5i3YN7LSnibd
         ft1X7aZ1nxm8gfF5nNruiegzqRvvl5pnUDObIXjdV4uzRHVvlQWihHVPrpMG1/IIwaUv
         WEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4JoFgaKGIZUP7KITjsD6hBXU6fdMuUm3RdP1CdyCDI=;
        b=j7UtMO1ssfm+WvRVC/1t5OOfxjCnTZeioUkjM98LNz3sReWUGufgesj0d1X/2Afvnd
         KTvf0Lv60VPQd744I4zBBn76w3zpaPK08hJKPDYQ1b1/b2b94DZ1JKdKceVCH+UwBBWd
         5qXUcW7lHLfMfxybxNOEC7gDMT3eQSKURcvJVVR5xSluDAw8OLlicko+ztGbVBk1eFIV
         zdoDQVThATFIuQKo2OgtH1siJj4Vcvjbekem0VfVB1+M1lQLhA5dz7CUqX5yaNiGC51O
         kmNZGaAz8z0bY1kn5yvku8c0qpJInfRlYVLpQki0c64eRxHr6kGKodARvj+68wDkOi+C
         ywvA==
X-Gm-Message-State: AOAM531YiZb2Yg2rmt2UvcpuCfe/Zuqe64fLBq0pDZ0ikm+G+bzifIvY
        4xeP0tqKR9Di0t0uJbCgb+LOjif2OqVcZXIqZc3xYmw1+DuT2w==
X-Google-Smtp-Source: ABdhPJz5Gl+jcfh45pqIcsLd1pUzNDfnV5X1gA02I46jcuJRZaLI6bp0IsMOb1+4qK0VYSbp88a6e+tw52az3MO8Pb8=
X-Received: by 2002:a05:6512:3092:b0:44a:e7bb:e961 with SMTP id
 z18-20020a056512309200b0044ae7bbe961mr10059124lfd.190.1649350904021; Thu, 07
 Apr 2022 10:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200817220212.338670-5-ndesaulniers@google.com> <164934565464.389.2546833245037255032.tip-bot2@tip-bot2>
In-Reply-To: <164934565464.389.2546833245037255032.tip-bot2@tip-bot2>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Apr 2022 10:01:32 -0700
Message-ID: <CAKwvOdkQeSx3uy25KaTrX=ywc26wDEefXHbCB_ifGot+yXGvHQ@mail.gmail.com>
Subject: Re: [tip: x86/build] x86/build: Don't build CONFIG_X86_32 as -ffreestanding
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>, x86@kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 8:34 AM tip-bot2 for Nick Desaulniers
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/build branch of tip:
>
> Commit-ID:     9b2687f29bc1a050ffd63b425129aa9db987e4f3
> Gitweb:        https://git.kernel.org/tip/9b2687f29bc1a050ffd63b425129aa9db987e4f3
> Author:        Nick Desaulniers <ndesaulniers@google.com>
> AuthorDate:    Thu, 03 Feb 2022 12:40:25 -08:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Thu, 07 Apr 2022 11:55:42 +02:00
>
> x86/build: Don't build CONFIG_X86_32 as -ffreestanding
>
> -ffreestanding typically inhibits "libcall optimizations" where calls to
> certain library functions can be replaced by the compiler in certain
> cases to calls to other library functions that may be more efficient.
> This can be problematic for embedded targets that don't provide full
> libc implementations.
>
> -ffreestanding inhibits all such optimizations, which is the safe
> choice, but generally we want the optimizations that are performed. The
> Linux kernel does implement a fair amount of libc routines. Instead of
> -ffreestanding (which makes more sense in smaller images like kexec's
> purgatory image), prefer -fno-builtin-* flags to disable the compiler
> from emitting calls to functions which may not be defined.
>
> If you see a linkage failure due to a missing symbol that's typically
> defined in a libc, and not explicitly called from the source code, then
> the compiler may have done such a transform. You can either implement
> such a function (i.e. in lib/string.c) or disable the transform outright
> via -fno-builtin-* flag (where * is the name of the library routine,
> i.e. -fno-builtin-bcmp).
>
> i386_defconfig build+boot tested with GCC and Clang. Removes a pretty
> old TODO from the code base.
>
> [kees: These libcall optimizations are specifically needed to allow Clang
> to correctly optimize the string functions under CONFIG_FORTIFY_SOURCE.]

Right, but...
I think we found that doing so leads to a boot regression for i386
when built w/ clang because:
https://github.com/ClangBuiltLinux/linux/issues/1583
https://github.com/llvm/llvm-project/issues/53645
TL;DR
In doing such libcall optimizations, LLVM drops the -mregparm=3
calling convention...on the caller's side and not the callee's.

Boris, Can I send you a patch to replace this one (with a guard for
clang) or a patch on top? i.e. what base would you prefer me to use.

Using mainline:

```
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 63d50f65b828..c94de779e334 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -100,8 +100,13 @@ ifeq ($(CONFIG_X86_32),y)
         include $(srctree)/arch/x86/Makefile_32.cpu
         KBUILD_CFLAGS += $(cflags-y)

-        # temporary until string.h is fixed
+        # LLVM is dropping -mregparm=3 from callers when doing libcall
+        # optimization.
+        # https://github.com/ClangBuiltLinux/linux/issues/1583
+        # https://github.com/llvm/llvm-project/issues/53645
+        ifndef CONFIG_CC_IS_CLANG
         KBUILD_CFLAGS += -ffreestanding
+        endif

        ifeq ($(CONFIG_STACKPROTECTOR),y)
                ifeq ($(CONFIG_SMP),y)
```

but happy to rebase onto whichever and put a commit message on that.
We'll bump up the priority on getting that fixed.

>
> Fixes: 6edfba1b33c7 ("[PATCH] x86_64: Don't define string functions to builtin")
> Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Reviewed-by: Fangrui Song <maskray@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Link: https://lore.kernel.org/r/20200817220212.338670-5-ndesaulniers@google.com
> Link: https://lore.kernel.org/r/20220203204025.1153397-1-keescook@chromium.org
> ---
>  arch/x86/Makefile | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 1abd7cc..670fe40 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -100,9 +100,6 @@ ifeq ($(CONFIG_X86_32),y)
>          include $(srctree)/arch/x86/Makefile_32.cpu
>          KBUILD_CFLAGS += $(cflags-y)
>
> -        # temporary until string.h is fixed
> -        KBUILD_CFLAGS += -ffreestanding
> -
>         ifeq ($(CONFIG_STACKPROTECTOR),y)
>                 ifeq ($(CONFIG_SMP),y)
>                         KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard



-- 
Thanks,
~Nick Desaulniers
