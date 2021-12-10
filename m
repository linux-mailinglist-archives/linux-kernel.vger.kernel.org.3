Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072E04705AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhLJQcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbhLJQcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:32:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B633C061746;
        Fri, 10 Dec 2021 08:28:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E54A3B828B8;
        Fri, 10 Dec 2021 16:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E221FC00446;
        Fri, 10 Dec 2021 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639153720;
        bh=sMNGU927vudYGJzIYYtQc0msMmVDR0wpjI6vd6p/LWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucwC74Ybebwdk4wWrqCtbwSiYJ9Ryzj9QymWc0Y1vGrgqCqOdm9PpCHLW7bi+JJLr
         x37PLcNsAcShoQDaEsm3bpQEBswWb17BaiNM4V0Od0VilUPp7srsLufWyOP0Hv2JvN
         Sn+uk9bVld2yWViJ8pRcqg+zRdomFp97mFFuVe/4Z/7E/qtygV9wlve4Pk27/1RZuV
         ETMoXP22/FJRynGUFONB/trxK2D+qFOvH6LQp/qHu49PJecqzLYHGZi56ud+MJIjfd
         bLUEZo6wqGZDJrmKDdrn7SKKccRRXvH6gc/uxqU3S5/pq6XGXYHODTTQqYOCMIzERT
         xSYno9rNgYLPA==
Date:   Fri, 10 Dec 2021 09:28:36 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Kconfig.debug: Make DEBUG_INFO selectable from a choice
Message-ID: <YbOANJLMlllo6B7e@archlinux-ax161>
References: <20211210000910.3597609-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210000910.3597609-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 04:09:10PM -0800, Kees Cook wrote:
> Currently it's not possible to enable DEBUG_INFO for an all*config
> build, since it is marked as "depends on !COMPILE_TEST". This generally
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
> making it weird to navigate menuconfig.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

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
> +	bool "Kernel debugging"
> +	help
> +	  Say Y here if you are developing drivers or trying to debug and
> +	  identify kernel problems.
> +
> +config DEBUG_MISC
> +	bool "Miscellaneous debug code"
> +	default DEBUG_KERNEL
> +	depends on DEBUG_KERNEL
> +	help
> +	  Say Y here if you need to enable miscellaneous debug code that should
> +	  be under a more specific debug option but isn't.
> +
>  menu "Compile-time checks and compiler options"
>  
>  config DEBUG_INFO
> -	bool "Compile the kernel with debug info"
> -	depends on DEBUG_KERNEL && !COMPILE_TEST
> +	bool
>  	help
> -	  If you say Y here the resulting kernel image will include
> -	  debugging info resulting in a larger kernel image.
> +	  A kernel debug info option other than "None" has been selected
> +	  in the "Debug information" choice below, indicating that debug
> +	  information will be generated for build targets.
> +
> +choice
> +	prompt "Debug information"
> +	depends on DEBUG_KERNEL
> +	default DEBUG_INFO_NONE if COMPILE_TEST
> +	default DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT if DEBUG_KERNEL
> +	help
> +	  Selecting something other than "None" results in a kernel image
> +	  that will include debugging info resulting in a larger kernel image.
>  	  This adds debug symbols to the kernel and modules (gcc -g), and
>  	  is needed if you intend to use kernel crashdump or binary object
>  	  tools like crash, kgdb, LKCD, gdb, etc on the kernel.
> -	  Say Y here only if you plan to debug the kernel.
>  
> -	  If unsure, say N.
> +	  Choose which version of DWARF debug info to emit. If unsure,
> +	  select "Toolchain default".
> +
> +config DEBUG_INFO_NONE
> +	bool "Disable debug information"
> +	help
> +	  Do not build the kernel with debugging information, which will
> +	  result in a faster and smaller build.
> +
> +config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> +	bool "Rely on the toolchain's implicit default DWARF version"
> +	select DEBUG_INFO
> +	help
> +	  The implicit default version of DWARF debug info produced by a
> +	  toolchain changes over time.
> +
> +	  This can break consumers of the debug info that haven't upgraded to
> +	  support newer revisions, and prevent testing newer versions, but
> +	  those should be less common scenarios.
> +
> +config DEBUG_INFO_DWARF4
> +	bool "Generate DWARF Version 4 debuginfo"
> +	select DEBUG_INFO
> +	help
> +	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
> +
> +	  If you have consumers of DWARF debug info that are not ready for
> +	  newer revisions of DWARF, you may wish to choose this or have your
> +	  config select this.
> +
> +config DEBUG_INFO_DWARF5
> +	bool "Generate DWARF Version 5 debuginfo"
> +	select DEBUG_INFO
> +	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> +	help
> +	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
> +	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> +	  draft features until 7.0), and gdb 8.0+.
> +
> +	  Changes to the structure of debug info in Version 5 allow for around
> +	  15-18% savings in resulting image and debug info section sizes as
> +	  compared to DWARF Version 4. DWARF Version 5 standardizes previous
> +	  extensions such as accelerators for symbol indexing and the format
> +	  for fission (.dwo/.dwp) files. Users may not want to select this
> +	  config if they rely on tooling that has not yet been updated to
> +	  support DWARF Version 5.
> +
> +endchoice # "Debug information"
>  
>  if DEBUG_INFO
>  
> @@ -267,55 +336,11 @@ config DEBUG_INFO_SPLIT
>  	  to know about the .dwo files and include them.
>  	  Incompatible with older versions of ccache.
>  
> -choice
> -	prompt "DWARF version"
> -	help
> -	  Which version of DWARF debug info to emit.
> -
> -config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> -	bool "Rely on the toolchain's implicit default DWARF version"
> -	help
> -	  The implicit default version of DWARF debug info produced by a
> -	  toolchain changes over time.
> -
> -	  This can break consumers of the debug info that haven't upgraded to
> -	  support newer revisions, and prevent testing newer versions, but
> -	  those should be less common scenarios.
> -
> -	  If unsure, say Y.
> -
> -config DEBUG_INFO_DWARF4
> -	bool "Generate DWARF Version 4 debuginfo"
> -	help
> -	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
> -
> -	  If you have consumers of DWARF debug info that are not ready for
> -	  newer revisions of DWARF, you may wish to choose this or have your
> -	  config select this.
> -
> -config DEBUG_INFO_DWARF5
> -	bool "Generate DWARF Version 5 debuginfo"
> -	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> -	depends on !DEBUG_INFO_BTF
> -	help
> -	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
> -	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> -	  draft features until 7.0), and gdb 8.0+.
> -
> -	  Changes to the structure of debug info in Version 5 allow for around
> -	  15-18% savings in resulting image and debug info section sizes as
> -	  compared to DWARF Version 4. DWARF Version 5 standardizes previous
> -	  extensions such as accelerators for symbol indexing and the format
> -	  for fission (.dwo/.dwp) files. Users may not want to select this
> -	  config if they rely on tooling that has not yet been updated to
> -	  support DWARF Version 5.
> -
> -endchoice # "DWARF version"
> -
>  config DEBUG_INFO_BTF
>  	bool "Generate BTF typeinfo"
>  	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>  	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
> +	depends on !DEBUG_INFO_DWARF5
>  	help
>  	  Generate deduplicated BTF type information from DWARF debug info.
>  	  Turning this on expects presence of pahole tool, which will convert
> @@ -584,21 +609,6 @@ source "lib/Kconfig.kcsan"
>  
>  endmenu
>  
> -config DEBUG_KERNEL
> -	bool "Kernel debugging"
> -	help
> -	  Say Y here if you are developing drivers or trying to debug and
> -	  identify kernel problems.
> -
> -config DEBUG_MISC
> -	bool "Miscellaneous debug code"
> -	default DEBUG_KERNEL
> -	depends on DEBUG_KERNEL
> -	help
> -	  Say Y here if you need to enable miscellaneous debug code that should
> -	  be under a more specific debug option but isn't.
> -
> -
>  menu "Memory Debugging"
>  
>  source "mm/Kconfig.debug"
> -- 
> 2.30.2
> 
