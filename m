Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927455A8704
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiHaTxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiHaTxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:53:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E593FEE694;
        Wed, 31 Aug 2022 12:53:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D746B8229E;
        Wed, 31 Aug 2022 19:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D145C433C1;
        Wed, 31 Aug 2022 19:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661975621;
        bh=N5TjKLihYMVZTqpkJpU1DkSXGCpIGAfU9cCiHtsQBH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=He34/htdVOXIkyJME9bifggAm9VZzyhjNtrCgeAb8boy87iFI0PTZF8IerC+BI4ty
         Kyt7h0zZn4sbTfwnicU0VTMDr46ZWvBSt/Om29T2t8jNRCShwPn9xU8Lr4U3MGb/15
         wzbfhPTZaM5pV2az5o5vs8xp4+yzlyzpdvxxc+/0hMSSh2lZnRz1N1My6SrM0jRNsB
         YFnIB8phWnxpCS2MBGhY/5haDh30LXsyoE3JsROXrMZDNhsdVxw2y7+3aYP4MKsnYZ
         QlOiu8zoGjw5wcmcaU349yurKR3/N2owIzUEpb2twwk2TWl/CrKgxQmWQQLwu7yGWp
         Aq49H3BqYImZg==
Date:   Wed, 31 Aug 2022 12:53:38 -0700
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
Subject: Re: [PATCH v2 2/5] Makefile.compiler: Use KBUILD_AFLAGS for as-option
Message-ID: <Yw+8QgtSbB2/3Eiq@dev-arch.thelio-3990X>
References: <20220831184408.2778264-1-ndesaulniers@google.com>
 <20220831184408.2778264-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831184408.2778264-3-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:44:05AM -0700, Nick Desaulniers wrote:
> as-instr uses KBUILD_AFLAGS, but as-option uses KBUILD_CFLAGS.  This can
> cause as-option to fail unexpectedly because clang will emit
> -Werror,-Wunused-command-line-argument for various -m and -f flags for
> assembler sources.

Now that I am looking closer at it, where does that '-Werror' come from?
For cc-option, we add it to elevate clang's warnings about unused '-f',
'-m', and '-W' flags to errors so that we do not add those flags.
However, I do not see '-Werror' in as-option. I am going to assume it
came from CONFIG_WERROR, as I believe Android has that turned on by
default. I think that is the real problem: without '-Werror', the only
error that should come from as-option is when an option isn't supported
by the assembler, as clang will still warn but those will not be fatal
but with '-Werror', those warnings turn fatal, causing all subsequent
as-option calls to fail.

Do not get me wrong, I still believe this is the correct fix but I think
it would be good to describe exactly under which conditions this is a
real issue in case we ever have to revisit this.

> Callers of as-option (and as-instr) likely want to be adding flags to
> KBUILD_AFLAGS/aflags-y, not KBUILD_CFLAGS/cflags-y.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1699
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Regardless of changes to the commit message:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Changes v1 -> v2:
> * Split off changes to arch/x86/boot/compressed/Makefile into parent
>   patch, as per Masahiro.
> 
>  scripts/Makefile.compiler | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
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
