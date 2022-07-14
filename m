Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE4F5756D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbiGNVZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240467AbiGNVZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:25:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352CC54C8F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8BE6B82943
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 21:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C873FC34114;
        Thu, 14 Jul 2022 21:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657833898;
        bh=WvpnAxKxsj54Q5vNQwYzZo/IQOstcntEKXe0TpyNz8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGGgGGFTBXsnNpfLZqeLZBpxrfs0pGGhOWXuWtu1oy1ohhMvPtLtolqO3ILQmMBSR
         4BBBUeQJ9bF/2j7HPR3PnA1ej+sVppXFT1ruIoAX0K7NiOMsD7cNueLI6GdcaN4v6g
         cwYfx1Yn95feVNT+2/0ccwUW1WN4362rfhELcCc5XIqdt3gjo90gQAMF6upuYAvldS
         n+xXRFZvH2UyHOX7wQ3PZ55JAhKEfhT3livOPWs7EFNl0hd4n8o+g9a9ePMz/BW8u2
         9ThFsr+JfS5nC0XZ7GVvF8EU3mXB78QoRQmUu8qf19wxUwHJ9aAsS5/Q0asGOM9MrT
         lEri2W4cMKlcA==
Date:   Thu, 14 Jul 2022 14:24:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Rix <trix@redhat.com>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ubsan: disable UBSAN_DIV_ZERO for clang
Message-ID: <YtCJqK2axavXWny8@dev-arch.thelio-3990X>
References: <20220714205646.4023495-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714205646.4023495-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 01:56:43PM -0700, Nick Desaulniers wrote:
> Building with UBSAN_DIV_ZERO with clang produces numerous fallthrough
> warnings from objtool.
> 
> In the case of uncheck division, UBSAN_DIV_ZERO may introduce new
> control flow to check for division by zero. Because the result of the
> division is undefined, LLVM may optimize the control flow such that
> after the call to __ubsan_handle_divrem_overflow doesn't matter. If
> panic_on_warn was set, __ubsan_handle_divrem_overflow would panic. The
> problem is is that panic_on_warn is run time configurable. If it's
> disabled, then we cannot guarantee that we will be able to recover
> safely.  Disable this config for clang until we can come up with a
> solution in LLVM.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1657
> Link: https://github.com/llvm/llvm-project/issues/56289
> Link: https://lore.kernel.org/lkml/CAHk-=wj1qhf7y3VNACEexyp5EbkNpdcu_542k-xZpzmYLOjiCg@mail.gmail.com/
> Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Acked-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Linus,
> I still think we should add explicit checks to gaurd against divide by
> zero.
> 
>  lib/Kconfig.ubsan | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index a9f7eb047768..fd15230a703b 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -84,6 +84,9 @@ config UBSAN_SHIFT
>  config UBSAN_DIV_ZERO
>  	bool "Perform checking for integer divide-by-zero"
>  	depends on $(cc-option,-fsanitize=integer-divide-by-zero)
> +	# https://github.com/ClangBuiltLinux/linux/issues/1657
> +	# https://github.com/llvm/llvm-project/issues/56289
> +	depends on !CC_IS_CLANG
>  	help
>  	  This option enables -fsanitize=integer-divide-by-zero which checks
>  	  for integer division by zero. This is effectively redundant with the
> -- 
> 2.37.0.170.g444d1eabd0-goog
> 
> 
