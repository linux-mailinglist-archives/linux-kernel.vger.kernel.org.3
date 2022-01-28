Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CCF4A044B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351771AbiA1XkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiA1Xj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:39:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9826DC061714;
        Fri, 28 Jan 2022 15:39:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53A66B82722;
        Fri, 28 Jan 2022 23:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12791C340E7;
        Fri, 28 Jan 2022 23:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643413194;
        bh=dbo13IaVnDONaIM/h10XQiZJNrjWSPXPYq8sfpbm3og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZDXtal+sMueHz/5BxJqZ4+b+pWx1r5OCD6YdTC3VdDH+3fGa0l+xx9bIr/xxuBCj
         lzDgNVh6trcQLS0i0zdycX4fil9dtqr/rM2DGhdbKqhAnoT9ZLX94vXDKHEmnJnUt1
         nLYItAP3Njnuf2WAKaF6qZbl/ZSvVgYsGsx4fn5oCV0u7mMsGWUEfXLoxG/ehuvVgt
         eys1CPxBxFzrc+KtPqgs/AeFqOYl/quID4VM0kFckcHZOLHqr4D79JK41WrR1KXhTL
         9VkvnDVMRSwn7nA8qm4psiH1deabhXh7M8zLe4ijhG31IYPaDDk6WC7ciMUE2VJJiJ
         zsHxYeXH7KOSw==
Date:   Fri, 28 Jan 2022 16:39:49 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Isabella Basso <isabbasso@riseup.net>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Kconfig.debug: Make DEBUG_INFO always default=n
Message-ID: <YfR+xXcTYvHooTc0@dev-arch.archlinux-ax161>
References: <20220128214131.580131-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128214131.580131-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 01:41:31PM -0800, Kees Cook wrote:
> While trying to make sure CONFIG_DEBUG_INFO wasn't set for COMPILE_TEST,
> I ordered the choices incorrectly to retain the prior default=n state.
> Move DEBUG_INFO_NONE to the top so that the default choice is disabled,
> and remove the "if COMPILE_TEST" as it is now redundant.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/lkml/YfRY6+CaQxX7O8vF@dev-arch.archlinux-ax161
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Another fallout of the original change is that defconfigs that do enable
CONFIG_DEBUG_INFO without any of the DWARF version configs will not have
debug info anymore.

Mainline:

$ make -sj$(nproc) ARCH=arm64 LLVM=1 mrproper defconfig && rg DEBUG_INFO .config
9296:CONFIG_DEBUG_INFO=y
9297:CONFIG_DEBUG_INFO_REDUCED=y
9298:# CONFIG_DEBUG_INFO_COMPRESSED is not set
9299:# CONFIG_DEBUG_INFO_SPLIT is not set
9300:CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
9301:# CONFIG_DEBUG_INFO_DWARF4 is not set
9302:# CONFIG_DEBUG_INFO_DWARF5 is not set

next-20220128:

$ make -sj$(nproc) ARCH=arm64 LLVM=1 mrproper defconfig && rg DEBUG_INFO .config
9299:CONFIG_DEBUG_INFO=y
9300:CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
9301:# CONFIG_DEBUG_INFO_DWARF4 is not set
9302:# CONFIG_DEBUG_INFO_DWARF5 is not set
9303:# CONFIG_DEBUG_INFO_NONE is not set
9304:CONFIG_DEBUG_INFO_REDUCED=y
9305:# CONFIG_DEBUG_INFO_COMPRESSED is not set
9306:# CONFIG_DEBUG_INFO_SPLIT is not set

next-20220128 + this patch:

$ make -sj$(nproc) ARCH=arm64 LLVM=1 mrproper defconfig && rg DEBUG_INFO .config
9299:CONFIG_DEBUG_INFO_NONE=y
9300:# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
9301:# CONFIG_DEBUG_INFO_DWARF4 is not set
9302:# CONFIG_DEBUG_INFO_DWARF5 is not set

I guess there is not really a way around that other than having people
regenerate their defconfigs (which should really be done each release
anyways) since DEBUG_INFO is no longer a user selectable symbol and it
is probably better to have this choice default to no debug info rather
than debug info. Is there any precedent to updating defconfigs due to a
change like this or some other way to let people know about it?

Cheers,
Nathan

> ---
> Andrew, this is a fix for kconfigdebug-make-debug_info-selectable-from-a-choice.patch
> ---
>  lib/Kconfig.debug | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a7b657d67318..a1262358d55a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -234,7 +234,6 @@ config DEBUG_INFO
>  choice
>  	prompt "Debug information"
>  	depends on DEBUG_KERNEL
> -	default DEBUG_INFO_NONE if COMPILE_TEST
>  	help
>  	  Selecting something other than "None" results in a kernel image
>  	  that will include debugging info resulting in a larger kernel image.
> @@ -245,6 +244,12 @@ choice
>  	  Choose which version of DWARF debug info to emit. If unsure,
>  	  select "Toolchain default".
>  
> +config DEBUG_INFO_NONE
> +	bool "Disable debug information"
> +	help
> +	  Do not build the kernel with debugging information, which will
> +	  result in a faster and smaller build.
> +
>  config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
>  	bool "Rely on the toolchain's implicit default DWARF version"
>  	select DEBUG_INFO
> @@ -283,12 +288,6 @@ config DEBUG_INFO_DWARF5
>  	  config if they rely on tooling that has not yet been updated to
>  	  support DWARF Version 5.
>  
> -config DEBUG_INFO_NONE
> -	bool "Disable debug information"
> -	help
> -	  Do not build the kernel with debugging information, which will
> -	  result in a faster and smaller build.
> -
>  endchoice # "Debug information"
>  
>  if DEBUG_INFO
> -- 
> 2.30.2
> 
