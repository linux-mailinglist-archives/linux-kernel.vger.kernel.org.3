Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090535A2E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiHZSWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344659AbiHZSWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AB6E398C;
        Fri, 26 Aug 2022 11:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B0AC61D23;
        Fri, 26 Aug 2022 18:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9888C433C1;
        Fri, 26 Aug 2022 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661538105;
        bh=P+hcLIrD/F79al7x8aLPgb1+lPQ8gMRGke9HgDVnG/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3yHxCqi3J/rAwrRsJLFeT4icMMpxhb3OpvWJ9DJWaYvDvGzOL+TCnbC6/PgoVUUR
         XNdnqO731drISisd0y80CmEDHwyJVand2PAe3oPWitY9mWShrepAIMgWIWhJXXgNbR
         kKKlkizBFCHMEjaZGg8HuPrylFmSMtJM0ce+ORSfrUpoqjbDxevVp9TebNHvX/AKv9
         DQcmWDKBGCK144wO/AvrTXOLl1C5+rgX6/OzH7j2Sdc8y1t5zCewgTCWvae/9imSU6
         zov6lclxSgDpvuhAKX5LJgBCEIXC3ILbKJ7kbLCfCEjrfwFipx1L1Tcb7tyVZ7UOKx
         FCfN7vdTOPObg==
Date:   Fri, 26 Aug 2022 11:21:43 -0700
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
Subject: Re: [PATCH 1/3] Makefile.compiler: s/KBUILD_CFLAGS/KBUILD_AFLAGS/
 for as-option
Message-ID: <YwkPNyHvxR2dM+CQ@dev-arch.thelio-3990X>
References: <20220826181035.859042-1-ndesaulniers@google.com>
 <20220826181035.859042-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826181035.859042-2-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

I think the title would be a little more readable if it was:

Makefile.compiler: Use KBUILD_AFLAGS for as-option

On Fri, Aug 26, 2022 at 11:10:33AM -0700, Nick Desaulniers wrote:
> as-instr uses KBUILD_AFLAGS, but as-option uses KBUILD_CFLAGS.  This can
> cause as-option to fail unexpectedly because clang will emit
> -Werror,-Wunused-command-line-argument for various -m and -f flags for
> assembler sources.
> 
> Callers of as-option (and as-instr) likely want to be adding flags to
> KBUILD_AFLAGS/aflags-y, not KBUILD_CFLAGS/cflags-y.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1699
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/x86/boot/compressed/Makefile | 5 +++--
>  scripts/Makefile.compiler         | 6 +++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 35ce1a64068b..fb3db714a028 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -48,8 +48,6 @@ KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>  KBUILD_CFLAGS += -D__DISABLE_EXPORTS
> -# Disable relocation relaxation in case the link is not PIE.
> -KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
>  KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
>  
>  # sev.c indirectly inludes inat-table.h which is generated during
> @@ -58,6 +56,9 @@ KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
>  CFLAGS_sev.o += -I$(objtree)/arch/x86/lib/
>  
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
> +# Disable relocation relaxation in case the link is not PIE.
> +KBUILD_AFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
> +

Commit 09e43968db40 ("x86/boot/compressed: Disable relocation
relaxation") added this to address
https://github.com/ClangBuiltLinux/linux/issues/1121, is it correct to
move it to only being used for the .S files in arch/x86/boot/compressed?

>  GCOV_PROFILE := n
>  UBSAN_SANITIZE :=n
>  
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index 94d0d40cddb3..d1739f0d3ce3 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -29,13 +29,13 @@ try-run = $(shell set -e;		\
>  	fi)
>  
>  # as-option
> -# Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
> +# Usage: aflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
>  
>  as-option = $(call try-run,\
> -	$(CC) $(KBUILD_CFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
> +	$(CC) $(KBUILD_AFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
>  
>  # as-instr
> -# Usage: cflags-y += $(call as-instr,instr,option1,option2)
> +# Usage: aflags-y += $(call as-instr,instr,option1,option2)
>  
>  as-instr = $(call try-run,\
>  	printf "%b\n" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
> -- 
> 2.37.2.672.g94769d06f0-goog
> 
