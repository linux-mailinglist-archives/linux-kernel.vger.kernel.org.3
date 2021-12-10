Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DC1470B31
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243176AbhLJUBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhLJUBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:01:33 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50B5C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:57:57 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 207so15222943ljf.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B59/AzexAtKvyqO1ghE44AGXcmVWKwFHQ0aD1bD7Y2o=;
        b=R1dKquuKr6N8CIPw01onhLzAvIZ17D3jkt/VO3LFbEIVIrTAml0hwZM3yOpdjD3tBr
         tFKwPLIKszgXZOe0uQOtRJvgjmG2G8CXEK9BTvv17uplS+HguxxivM41VMYJvMDugvYG
         HgdICI2tzqyh/fzc9DOVKAJUeq/loihJMGcw22gBYiOKJQL6Y7c6puOJClq9ZbDLMr0n
         /CnEWsjEQoqMaMTjsveSzA63ifB5FaLCOyDRgK4GYZWmveT2TTrsIJxCMQBdOTvUMy/4
         9cAg45snKAyejgayJ+fXtBpKBSc76gthaIl6FJoIdPVdBdCBli0rMwrfF4tKukLlSRWD
         OzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B59/AzexAtKvyqO1ghE44AGXcmVWKwFHQ0aD1bD7Y2o=;
        b=QosWg7gUZTzgLUw1iyaC513QcRUUbNX8H6i6QJyycEI2dBbOYIdQM2LsG+fnW4lhFr
         19q6JSzYtlZYUY09Hy/flxCla0zfI+ab3IdLF/kV4BCklcqbFjsew/F2mAu8XPbZIWlD
         n9O3cSdH5XvWlNWizg6pCXZ1i1G0S4I0MrAKWBAI7dnToKps3tB77+4jeJAv3gNSHNHv
         cRa6LlDWZOtuSy6CDT57MvruynsyYf4rvuJKG86Ompt51pqug46x5zXNl4l581pkjnCM
         gzg041YvohoHVHUyYTCc5YkEow7XNarH0pGlJprdpByBk3RURAcWg6o/VWsCD/zdOWev
         gmrA==
X-Gm-Message-State: AOAM532wt4HifYAo6yeMZCtPFgLKRFNLBfN19X28D2qWEewLbbPbxJwK
        0rpze7PwF74XJ7gHUCcb3D0h8OeFys9nUsz9WN1Sjw==
X-Google-Smtp-Source: ABdhPJyybgYFdA9hyUxio4mrRGu/hyGUchX5BhoN7U0RvuUWR+eefn2vaFB1hFUnac2g7qVz/uV8m+hCuLw0oxq5f2g=
X-Received: by 2002:a2e:7a06:: with SMTP id v6mr14541846ljc.198.1639166275533;
 Fri, 10 Dec 2021 11:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20211210000910.3597609-1-keescook@chromium.org>
In-Reply-To: <20211210000910.3597609-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Dec 2021 11:57:44 -0800
Message-ID: <CAKwvOd=b_01FeUurgQRhfvrRtdWF2uFwmOJRGgTTcr6N=taaTw@mail.gmail.com>
Subject: Re: [PATCH] Kconfig.debug: Make DEBUG_INFO selectable from a choice
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 4:09 PM Kees Cook <keescook@chromium.org> wrote:
>
> Currently it's not possible to enable DEBUG_INFO for an all*config
> build, since it is marked as "depends on !COMPILE_TEST". This generally

Indeed.

> makes sense because a debug build of an all*config target ends up taking
> much longer and the output is much larger. Having this be "default off"
> makes sense. However, there are cases where enabling DEBUG_INFO for such
> builds is useful for doing treewide A/B comparisons of build options,
> etc.
>
> Make DEBUG_INFO selectable from any of the DWARF version choice options,
> with DEBUG_INFO_NONE being the default for COMPILE_TEST. The mutually
> exclusive relationship between DWARF5 and BTF must be inverted, but the
> result remains the same. Additionally moves DEBUG_KERNEL and DEBUG_MISC
> up to the top of the menu because was enabling features _above_ it,

s/was/they were/

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> making it weird to navigate menuconfig.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/Kconfig.debug | 142 +++++++++++++++++++++++++---------------------
>  1 file changed, 76 insertions(+), 66 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5c12bde10996..70ef47e92681 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -208,20 +208,89 @@ config DEBUG_BUGVERBOSE
>
>  endmenu # "printk and dmesg options"
>
> +config DEBUG_KERNEL
> +       bool "Kernel debugging"
> +       help
> +         Say Y here if you are developing drivers or trying to debug and
> +         identify kernel problems.
> +
> +config DEBUG_MISC
> +       bool "Miscellaneous debug code"
> +       default DEBUG_KERNEL
> +       depends on DEBUG_KERNEL
> +       help
> +         Say Y here if you need to enable miscellaneous debug code that should
> +         be under a more specific debug option but isn't.
> +
>  menu "Compile-time checks and compiler options"
>
>  config DEBUG_INFO
> -       bool "Compile the kernel with debug info"
> -       depends on DEBUG_KERNEL && !COMPILE_TEST
> +       bool
>         help
> -         If you say Y here the resulting kernel image will include
> -         debugging info resulting in a larger kernel image.
> +         A kernel debug info option other than "None" has been selected
> +         in the "Debug information" choice below, indicating that debug
> +         information will be generated for build targets.
> +
> +choice
> +       prompt "Debug information"
> +       depends on DEBUG_KERNEL
> +       default DEBUG_INFO_NONE if COMPILE_TEST
> +       default DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT if DEBUG_KERNEL
> +       help
> +         Selecting something other than "None" results in a kernel image
> +         that will include debugging info resulting in a larger kernel image.
>           This adds debug symbols to the kernel and modules (gcc -g), and
>           is needed if you intend to use kernel crashdump or binary object
>           tools like crash, kgdb, LKCD, gdb, etc on the kernel.
> -         Say Y here only if you plan to debug the kernel.
>
> -         If unsure, say N.
> +         Choose which version of DWARF debug info to emit. If unsure,
> +         select "Toolchain default".
> +
> +config DEBUG_INFO_NONE
> +       bool "Disable debug information"
> +       help
> +         Do not build the kernel with debugging information, which will
> +         result in a faster and smaller build.
> +
> +config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> +       bool "Rely on the toolchain's implicit default DWARF version"
> +       select DEBUG_INFO
> +       help
> +         The implicit default version of DWARF debug info produced by a
> +         toolchain changes over time.
> +
> +         This can break consumers of the debug info that haven't upgraded to
> +         support newer revisions, and prevent testing newer versions, but
> +         those should be less common scenarios.
> +
> +config DEBUG_INFO_DWARF4
> +       bool "Generate DWARF Version 4 debuginfo"
> +       select DEBUG_INFO
> +       help
> +         Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
> +
> +         If you have consumers of DWARF debug info that are not ready for
> +         newer revisions of DWARF, you may wish to choose this or have your
> +         config select this.
> +
> +config DEBUG_INFO_DWARF5
> +       bool "Generate DWARF Version 5 debuginfo"
> +       select DEBUG_INFO
> +       depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> +       help
> +         Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
> +         5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> +         draft features until 7.0), and gdb 8.0+.
> +
> +         Changes to the structure of debug info in Version 5 allow for around
> +         15-18% savings in resulting image and debug info section sizes as
> +         compared to DWARF Version 4. DWARF Version 5 standardizes previous
> +         extensions such as accelerators for symbol indexing and the format
> +         for fission (.dwo/.dwp) files. Users may not want to select this
> +         config if they rely on tooling that has not yet been updated to
> +         support DWARF Version 5.
> +
> +endchoice # "Debug information"
>
>  if DEBUG_INFO
>
> @@ -267,55 +336,11 @@ config DEBUG_INFO_SPLIT
>           to know about the .dwo files and include them.
>           Incompatible with older versions of ccache.
>
> -choice
> -       prompt "DWARF version"
> -       help
> -         Which version of DWARF debug info to emit.
> -
> -config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> -       bool "Rely on the toolchain's implicit default DWARF version"
> -       help
> -         The implicit default version of DWARF debug info produced by a
> -         toolchain changes over time.
> -
> -         This can break consumers of the debug info that haven't upgraded to
> -         support newer revisions, and prevent testing newer versions, but
> -         those should be less common scenarios.
> -
> -         If unsure, say Y.
> -
> -config DEBUG_INFO_DWARF4
> -       bool "Generate DWARF Version 4 debuginfo"
> -       help
> -         Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
> -
> -         If you have consumers of DWARF debug info that are not ready for
> -         newer revisions of DWARF, you may wish to choose this or have your
> -         config select this.
> -
> -config DEBUG_INFO_DWARF5
> -       bool "Generate DWARF Version 5 debuginfo"
> -       depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> -       depends on !DEBUG_INFO_BTF
> -       help
> -         Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
> -         5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> -         draft features until 7.0), and gdb 8.0+.
> -
> -         Changes to the structure of debug info in Version 5 allow for around
> -         15-18% savings in resulting image and debug info section sizes as
> -         compared to DWARF Version 4. DWARF Version 5 standardizes previous
> -         extensions such as accelerators for symbol indexing and the format
> -         for fission (.dwo/.dwp) files. Users may not want to select this
> -         config if they rely on tooling that has not yet been updated to
> -         support DWARF Version 5.
> -
> -endchoice # "DWARF version"
> -
>  config DEBUG_INFO_BTF
>         bool "Generate BTF typeinfo"
>         depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>         depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
> +       depends on !DEBUG_INFO_DWARF5

I did hit a trivial conflict applying this to mainline/next-20211208 against
d9847eb8be3d8 ("bpf: Make CONFIG_DEBUG_INFO_BTF depend upon CONFIG_BPF_SYSCALL")

>         help
>           Generate deduplicated BTF type information from DWARF debug info.
>           Turning this on expects presence of pahole tool, which will convert
> @@ -584,21 +609,6 @@ source "lib/Kconfig.kcsan"
>
>  endmenu
>
> -config DEBUG_KERNEL
> -       bool "Kernel debugging"
> -       help
> -         Say Y here if you are developing drivers or trying to debug and
> -         identify kernel problems.
> -
> -config DEBUG_MISC
> -       bool "Miscellaneous debug code"
> -       default DEBUG_KERNEL
> -       depends on DEBUG_KERNEL
> -       help
> -         Say Y here if you need to enable miscellaneous debug code that should
> -         be under a more specific debug option but isn't.
> -
> -
>  menu "Memory Debugging"
>
>  source "mm/Kconfig.debug"
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
