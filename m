Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCDD5A86E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiHaTlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiHaTlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8315A28;
        Wed, 31 Aug 2022 12:41:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5527D618A9;
        Wed, 31 Aug 2022 19:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF367C433C1;
        Wed, 31 Aug 2022 19:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661974909;
        bh=HRWavCzgmnCOxdEIVx7+y9IkB5Wmqi/7g7aSXe2NXRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8WqCtVSCuFCRKcfQAMJUyol59M3aBLEHSL2tIw1elWim4H3JyXMGYXSKYCoHbx4r
         O+k2i5O2EwomK9Z95rPnWw+MabuJm/4nNj052nudaa2rNIXBFWR407H80wiXT6G7Bm
         sBCLi3QFc0sjnM6vNIOYoRDC9UfCrmWVLMCEaDQvZ5DPBcKl4N6RV1gBk1mb6qZ0tJ
         jxsL4niMedp4Sphn17x8lXYv7lFGXLJyjrXUo6KwBPQRHLx0u3R8CDAsvz4TgvwpKj
         E0ygwGRMoeQXWrNNv4lQWQHKPOYkC8T2Qusj4crWm+/el6vMJwrNhOW7A6wOraIx1j
         KIoei8qyd0UXw==
Date:   Wed, 31 Aug 2022 12:41:47 -0700
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
        Greg Thelen <gthelen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 1/5] x86/boot/compressed: prefer cc-option for CFLAGS
 additions
Message-ID: <Yw+5e0lpJsZS3eWD@dev-arch.thelio-3990X>
References: <20220831184408.2778264-1-ndesaulniers@google.com>
 <20220831184408.2778264-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831184408.2778264-2-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:44:04AM -0700, Nick Desaulniers wrote:
> We have an issue where as-option is testing new options with accumulated
> CFLAGS. This makes it so that we can't use as-option to update AFLAGS
> since many CFLAGS aren't valid AFLAGS. This is being fixed in a follow
> up patch. Before doing so, move the assembler test for
> -Wa,-mrelax-relocations=no from using as-option to cc-option.

I think the first couple of sentences might sound clearer without the
"we". Maybe something like the following?

"as-option tests new options using KBUILD_CFLAGS, which causes problems
when using as-option to update KBUILD_AFLAGS because many compiler
options are not valid assembler options."

> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: x86@kernel.org
> Link: https://lore.kernel.org/llvm/CAK7LNATcHt7GcXZ=jMszyH=+M_LC9Qr6yeAGRCBbE6xriLxtUQ@mail.gmail.com/
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Regardless of the commit message:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Additionally, I did verify that '-Wa,-mrelax-relocations=no' still shows
up in arch/x86/boot/compressed so:

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Changes v1 -> v2:
> * Split off of v1 [1/3].
> * Use cc-option to update CFLAGS, as per Masahiro.
> * Add Masahiro's Suggested-by, Cc Arvind.
> 
>  arch/x86/boot/compressed/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 35ce1a64068b..85934204d905 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -49,7 +49,7 @@ KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>  KBUILD_CFLAGS += -D__DISABLE_EXPORTS
>  # Disable relocation relaxation in case the link is not PIE.
> -KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
> +KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
>  KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
>  
>  # sev.c indirectly inludes inat-table.h which is generated during
> -- 
> 2.37.2.672.g94769d06f0-goog
> 
