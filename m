Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450715A877D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiHaUWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiHaUWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B367D87DF;
        Wed, 31 Aug 2022 13:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C40161946;
        Wed, 31 Aug 2022 20:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463CDC433C1;
        Wed, 31 Aug 2022 20:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661977328;
        bh=VWwpWtbs0bVVU2d8nghDcUxyB0ZgqCrW/45hwJMVcpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TkvI1Fm8dZZmEYVkRXkshckfcR2ez1MU6euo0846z4PmvbyoMFCsrvtVRqNQGgPgB
         JQ/SycAD50JZjoH36AuSC1+MkKmNpMsYSmflqrtskrCDUXR2fqzSG2isyt8uX2S8Kr
         LFDrrNXrhURCCs0IELNct5BNLhmC6J1/vZTij5c5fVmdnQfKJ4W3Lyjah1c57TQ7Ov
         f1Wu2s/jLRcFqaLgIKzVhNbvlMPgc3SU4GETEu/K7yLCM6M3p5S9PDLkCCmid5plJJ
         tpmUdZT1F0vwrsffsRCfMWt0cdVSMmYcsTtfO/adhmpZpME7r1/gPQTiNtXQS1DOnG
         CD0J3mUL43Kog==
Date:   Wed, 31 Aug 2022 13:22:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, x86@kernel.org,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH v2 4/5] Makefile.debug: re-enable debug info for .S files
Message-ID: <Yw/C7fYWP+KkVKk2@dev-arch.thelio-3990X>
References: <20220831184408.2778264-1-ndesaulniers@google.com>
 <20220831184408.2778264-5-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831184408.2778264-5-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:44:07AM -0700, Nick Desaulniers wrote:
> Alexey reported that the fraction of unknown filename instances in
> kallsyms grew from ~0.3% to ~10% recently; Bill and Greg tracked it down
> to assembler defined symbols, which regressed as a result of:
> 
> commit b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")
> 
> In that commit, I allude to restoring debug info for assembler defined
> symbols in a follow up patch, but it seems I forgot to do so in
> 
> commit a66049e2cf0e ("Kbuild: make DWARF version a choice")
> 
> This patch does a few things:
> 1. Add -g to KBUILD_AFLAGS. This will instruct the compiler to instruct
>    the assembler to emit debug info. But this can cause an issue for
>    folks using a newer compiler but older assembler, because the
>    implicit default DWARF version changed from v4 to v5 in gcc-11 and
>    clang-14.
> 2. If the user is using CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT, use a
>    version check to explicitly set -Wa,-gdwarf-<version> for the
>    assembler. There's another problem with this; GAS only gained support
>    for explicit DWARF versions 3-5 in the 2.36 GNU binutils release.
> 3. Wrap -Wa,-gdwarf-<version> in as-option call to test whether the
>    assembler supports that explicit DWARF version.
> 
> Link: https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
> Fixes: b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")
> Reported-by: Alexey Alexandrov <aalexand@google.com>
> Reported-by: Bill Wendling <morbo@google.com>
> Reported-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Changes v1 -> v2:
> * Use newly added compiler-specific macros, as per Bill.
> 
>  scripts/Makefile.debug | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index 9f39b0130551..46e88f0ca998 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -4,18 +4,32 @@ ifdef CONFIG_DEBUG_INFO_SPLIT
>  DEBUG_CFLAGS	+= -gsplit-dwarf
>  else
>  DEBUG_CFLAGS	+= -g
> +KBUILD_AFLAGS	+= -g
>  endif
>  
> -ifndef CONFIG_AS_IS_LLVM
> -KBUILD_AFLAGS	+= -Wa,-gdwarf-2
> +ifdef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> +# gcc-11+, clang-14+
> +ifeq ($(call cc-min-version, 110000, 140000),y)
> +dwarf-version-y := 5
> +else
> +dwarf-version-y := 4
>  endif
> -
> -ifndef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> +else # !CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
>  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
>  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
>  DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
>  endif
>  
> +# Binutils 2.35+ (or clang) required for -gdwarf-{4|5}.
> +# https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
> +ifneq ($(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y)),)
> +KBUILD_AFLAGS	+= -Wa,-gdwarf-$(dwarf-version-y)
> +else
> +ifndef CONFIG_AS_IS_LLVM
> +KBUILD_AFLAGS	+= -Wa,-gdwarf-2
> +endif
> +endif
> +
>  ifdef CONFIG_DEBUG_INFO_REDUCED
>  DEBUG_CFLAGS	+= -fno-var-tracking
>  ifdef CONFIG_CC_IS_GCC
> -- 
> 2.37.2.672.g94769d06f0-goog
> 
