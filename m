Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522D54A02A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbiA1V1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbiA1V1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:27:15 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8650EC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 13:27:15 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s6so1783252plg.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 13:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DzX7+47gjPs8ILgLf0J66KJIKgGaB7Dk6+HNeR2ERRE=;
        b=lrWPcI3AjQYaniz9ehthdWA2oNEMoH7brJ9Kwg3b3qps/fLP+rBtIQFYxJVScUxNTV
         pr8tQ3T0x2/OOVnHFWQ5hSyOpTmTWkgz4IxOSsyJ6bicNsRyAYvQNnBA4Z2qJcsEh2Ho
         bSR0gBzBM+h+T1yj771izIZY4k2GtJhthOmFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DzX7+47gjPs8ILgLf0J66KJIKgGaB7Dk6+HNeR2ERRE=;
        b=dRE9E0QEUkoDUWYJzYRto1LhCMh0XpRERuAb/K6S5VJNxWOVyt9WcimN5tXkhUEVFX
         y4yfjR5RxWyUfpyZJLxpUQM47oYkEzUbMIkubwDsTXErJ7MoVi7+XPM9LPoEHEMF/n1E
         GHJ5a1upJxRnENmzd5/+IdOSTJTla35I4R6N354kdHn9tHBTWCBs7g6LzQIGyZgqDti9
         ROxFqMI1ggSG9hjh1E3SBmoY4TYeKubrh2d8JpwTZ2INqR6ob9Sy72aiaxNTF45jecJ1
         evB4KQWN3TMBOJrKvSO2GTbrlhZtbfOpDQcOVyVLwoTLhNbsrVkrvX7h0rpajgKtnRA+
         tciw==
X-Gm-Message-State: AOAM532bU/G5kvRR2203ZKThJ6VCh5I1Xj3QfQqPJq+7JCi9G4cQPF+a
        sqqqQCj5brAYsz2fWxl2eHBcn+LAPheJJA==
X-Google-Smtp-Source: ABdhPJwlFwgizi4ArGzF8oDergTmTp0qC5/7Wj21LOUtIbEMhFJqIFbzDJA7GHDOyOhEjBJnelNJLA==
X-Received: by 2002:a17:903:2305:: with SMTP id d5mr10041599plh.122.1643405235026;
        Fri, 28 Jan 2022 13:27:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 8sm3250202pji.4.2022.01.28.13.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 13:27:14 -0800 (PST)
Date:   Fri, 28 Jan 2022 13:27:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Isabella Basso <isabbasso@riseup.net>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] Kconfig.debug: Make DEBUG_INFO selectable from a
 choice
Message-ID: <202201281326.8DABC3BE@keescook>
References: <20220125075126.891825-1-keescook@chromium.org>
 <YfRY6+CaQxX7O8vF@dev-arch.archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfRY6+CaQxX7O8vF@dev-arch.archlinux-ax161>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 01:58:19PM -0700, Nathan Chancellor wrote:
> Hi Kees,
> 
> On Mon, Jan 24, 2022 at 11:51:26PM -0800, Kees Cook wrote:
> > Currently it's not possible to enable DEBUG_INFO for an all*config build,
> > since it is marked as "depends on !COMPILE_TEST". This generally makes
> > sense because a debug build of an all*config target ends up taking much
> > longer and the output is much larger. Having this be "default off" makes
> > sense. However, there are cases where enabling DEBUG_INFO for such builds
> > is useful for doing treewide A/B comparisons of build options, etc.
> > 
> > Make DEBUG_INFO selectable from any of the DWARF version choice options,
> > with DEBUG_INFO_NONE being the default for COMPILE_TEST. The mutually
> > exclusive relationship between DWARF5 and BTF must be inverted, but the
> > result remains the same. Additionally moves DEBUG_KERNEL and DEBUG_MISC
> > up to the top of the menu because they were enabling features _above_
> > it, making it weird to navigate menuconfig.
> > 
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v1: https://lore.kernel.org/lkml/20211210000910.3597609-1-keescook@chromium.org
> > v2: https://lore.kernel.org/lkml/20220121001204.4023842-1-keescook@chromium.org
> > v3: - rebase to v5.17-rc1
> > ---
> >  lib/Kconfig.debug | 140 +++++++++++++++++++++++++---------------------
> >  1 file changed, 75 insertions(+), 65 deletions(-)
> > 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 14b89aa37c5c..1290e0906236 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -208,20 +208,88 @@ config DEBUG_BUGVERBOSE
> >  
> >  endmenu # "printk and dmesg options"
> >  
> > +config DEBUG_KERNEL
> > +	bool "Kernel debugging"
> > +	help
> > +	  Say Y here if you are developing drivers or trying to debug and
> > +	  identify kernel problems.
> > +
> > +config DEBUG_MISC
> > +	bool "Miscellaneous debug code"
> > +	default DEBUG_KERNEL
> > +	depends on DEBUG_KERNEL
> > +	help
> > +	  Say Y here if you need to enable miscellaneous debug code that should
> > +	  be under a more specific debug option but isn't.
> > +
> >  menu "Compile-time checks and compiler options"
> >  
> >  config DEBUG_INFO
> > -	bool "Compile the kernel with debug info"
> > -	depends on DEBUG_KERNEL && !COMPILE_TEST
> > +	bool
> >  	help
> > -	  If you say Y here the resulting kernel image will include
> > -	  debugging info resulting in a larger kernel image.
> > +	  A kernel debug info option other than "None" has been selected
> > +	  in the "Debug information" choice below, indicating that debug
> > +	  information will be generated for build targets.
> > +
> > +choice
> > +	prompt "Debug information"
> > +	depends on DEBUG_KERNEL
> > +	default DEBUG_INFO_NONE if COMPILE_TEST
> 
> I apologize for not bringing this up sooner in review (especially with
> my tag) but I wanted to make sure this change is intentional.
> 
> Prior to this commit, we would have to explicitly enable DEBUG_INFO
> after turning on DEBUG_KERNEL (i.e. DEBUG_KERNEL would not select
> DEBUG_INFO).
> 
> Now, DEBUG_INFO automatically gets turned on with DEBUG_KERNEL because
> of the depends plus the default for the choice. Is this intentional?

Oh, er, no. I think this was an oversight when I tried to adapt this to
Masahiro's suggestions. I will go fix this up.

> For example, with x86_64_defconfig:
> 
> mainline:
> 
> $ make mrproper defconfig && rg DEBUG_INFO .config
> 4571:# CONFIG_DEBUG_INFO is not set
> 
> next-20220128:
> 
> $ make mrproper defconfig && rg DEBUG_INFO .config
> 4573:CONFIG_DEBUG_INFO=y
> 4574:CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> 4575:# CONFIG_DEBUG_INFO_DWARF4 is not set
> 4576:# CONFIG_DEBUG_INFO_DWARF5 is not set
> 4577:# CONFIG_DEBUG_INFO_NONE is not set
> 4578:# CONFIG_DEBUG_INFO_REDUCED is not set
> 4579:# CONFIG_DEBUG_INFO_COMPRESSED is not set
> 4580:# CONFIG_DEBUG_INFO_SPLIT is not set
> 
> As far as I can tell, this will have a big impact on everyone's binary
> and modules size that either enables DEBUG_KERNEL or EXPERT (which
> selects DEBUG_KERNEL), which is a lot of configs.

Yes, agreed, it's a huge size difference! :)

-Kees

> 
> $ for file in $(rg -l "CONFIG_(DEBUG_KERNEL|EXPERT)" arch/*/configs); do rg DEBUG_INFO $file &>/dev/null || echo $file; done |& wc -l
> 170
> 
> If this change is intentional, then it probably warrants more of an
> explicit callout in the commit message. I only noticed this because the
> vmlinux for the multi_v7_defconfig kernel I build for my Raspberry Pi 3
> went from 32.44 MB to 262.75 MB.
> 
> Cheers,
> Nathan
> 
> > +	help
> > +	  Selecting something other than "None" results in a kernel image
> > +	  that will include debugging info resulting in a larger kernel image.
> >  	  This adds debug symbols to the kernel and modules (gcc -g), and
> >  	  is needed if you intend to use kernel crashdump or binary object
> >  	  tools like crash, kgdb, LKCD, gdb, etc on the kernel.
> > -	  Say Y here only if you plan to debug the kernel.
> >  
> > -	  If unsure, say N.
> > +	  Choose which version of DWARF debug info to emit. If unsure,
> > +	  select "Toolchain default".
> > +
> > +config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> > +	bool "Rely on the toolchain's implicit default DWARF version"
> > +	select DEBUG_INFO
> > +	help
> > +	  The implicit default version of DWARF debug info produced by a
> > +	  toolchain changes over time.
> > +
> > +	  This can break consumers of the debug info that haven't upgraded to
> > +	  support newer revisions, and prevent testing newer versions, but
> > +	  those should be less common scenarios.
> > +
> > +config DEBUG_INFO_DWARF4
> > +	bool "Generate DWARF Version 4 debuginfo"
> > +	select DEBUG_INFO
> > +	help
> > +	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
> > +
> > +	  If you have consumers of DWARF debug info that are not ready for
> > +	  newer revisions of DWARF, you may wish to choose this or have your
> > +	  config select this.
> > +
> > +config DEBUG_INFO_DWARF5
> > +	bool "Generate DWARF Version 5 debuginfo"
> > +	select DEBUG_INFO
> > +	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> > +	help
> > +	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
> > +	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> > +	  draft features until 7.0), and gdb 8.0+.
> > +
> > +	  Changes to the structure of debug info in Version 5 allow for around
> > +	  15-18% savings in resulting image and debug info section sizes as
> > +	  compared to DWARF Version 4. DWARF Version 5 standardizes previous
> > +	  extensions such as accelerators for symbol indexing and the format
> > +	  for fission (.dwo/.dwp) files. Users may not want to select this
> > +	  config if they rely on tooling that has not yet been updated to
> > +	  support DWARF Version 5.
> > +
> > +config DEBUG_INFO_NONE
> > +	bool "Disable debug information"
> > +	help
> > +	  Do not build the kernel with debugging information, which will
> > +	  result in a faster and smaller build.
> > +
> > +endchoice # "Debug information"
> >  
> >  if DEBUG_INFO
> >  
> > @@ -267,56 +335,12 @@ config DEBUG_INFO_SPLIT
> >  	  to know about the .dwo files and include them.
> >  	  Incompatible with older versions of ccache.
> >  
> > -choice
> > -	prompt "DWARF version"
> > -	help
> > -	  Which version of DWARF debug info to emit.
> > -
> > -config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> > -	bool "Rely on the toolchain's implicit default DWARF version"
> > -	help
> > -	  The implicit default version of DWARF debug info produced by a
> > -	  toolchain changes over time.
> > -
> > -	  This can break consumers of the debug info that haven't upgraded to
> > -	  support newer revisions, and prevent testing newer versions, but
> > -	  those should be less common scenarios.
> > -
> > -	  If unsure, say Y.
> > -
> > -config DEBUG_INFO_DWARF4
> > -	bool "Generate DWARF Version 4 debuginfo"
> > -	help
> > -	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
> > -
> > -	  If you have consumers of DWARF debug info that are not ready for
> > -	  newer revisions of DWARF, you may wish to choose this or have your
> > -	  config select this.
> > -
> > -config DEBUG_INFO_DWARF5
> > -	bool "Generate DWARF Version 5 debuginfo"
> > -	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> > -	depends on !DEBUG_INFO_BTF
> > -	help
> > -	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
> > -	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> > -	  draft features until 7.0), and gdb 8.0+.
> > -
> > -	  Changes to the structure of debug info in Version 5 allow for around
> > -	  15-18% savings in resulting image and debug info section sizes as
> > -	  compared to DWARF Version 4. DWARF Version 5 standardizes previous
> > -	  extensions such as accelerators for symbol indexing and the format
> > -	  for fission (.dwo/.dwp) files. Users may not want to select this
> > -	  config if they rely on tooling that has not yet been updated to
> > -	  support DWARF Version 5.
> > -
> > -endchoice # "DWARF version"
> > -
> >  config DEBUG_INFO_BTF
> >  	bool "Generate BTF typeinfo"
> >  	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
> >  	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
> >  	depends on BPF_SYSCALL
> > +	depends on !DEBUG_INFO_DWARF5
> >  	help
> >  	  Generate deduplicated BTF type information from DWARF debug info.
> >  	  Turning this on expects presence of pahole tool, which will convert
> > @@ -585,20 +609,6 @@ source "lib/Kconfig.kcsan"
> >  
> >  endmenu
> >  
> > -config DEBUG_KERNEL
> > -	bool "Kernel debugging"
> > -	help
> > -	  Say Y here if you are developing drivers or trying to debug and
> > -	  identify kernel problems.
> > -
> > -config DEBUG_MISC
> > -	bool "Miscellaneous debug code"
> > -	default DEBUG_KERNEL
> > -	depends on DEBUG_KERNEL
> > -	help
> > -	  Say Y here if you need to enable miscellaneous debug code that should
> > -	  be under a more specific debug option but isn't.
> > -
> >  menu "Networking Debugging"
> >  
> >  source "net/Kconfig.debug"
> > -- 
> > 2.30.2
> > 
> > 

-- 
Kees Cook
