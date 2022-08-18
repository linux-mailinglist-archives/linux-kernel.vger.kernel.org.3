Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE405597F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbiHRHtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiHRHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:49:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03AAAE22C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B0FOqbOjjD5Eu6hMGkx4/QaR7cvvJoyR6LldMiptjZA=; b=lAbemeTjjG7Zib6AJtOPKEYNsf
        uTj3+j1lm1WaMG3Dz2qNfFUxF5PX10h5Lg5dGz9GpMVCsuufeXp0I7106UGddGWKfz8PBbJJgvE7l
        q5xNYe6NFBmq3KguAH5zB37sUHkQPSmI9pYeaGt6Qt6oIXV6T/Uyt6JB9GT1p/ulDRP8BVO2v74jM
        KGbiQnvExQ1OmJIMLnFSfptlyTUDFhDgeFSgS/RSREY/8/rtTE+JhoMWtQO96aypVElR4K4/Bfld4
        LTgVsjlSN5CktdTCY1U2f/cfMlsJZT3RClH7MXmcq0HCGV7YpCKJQ70mRd57Ob8c2lp9kLxp6xMQ0
        3h0Lt9hA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOaH2-009U3g-9s; Thu, 18 Aug 2022 07:49:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DD9C980135; Thu, 18 Aug 2022 09:49:01 +0200 (CEST)
Date:   Thu, 18 Aug 2022 09:49:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] x86/build: Move '-mindirect-branch-cs-prefix' out of
 GCC-only block
Message-ID: <Yv3u7XobZs/uPf6n@worktop.programming.kicks-ass.net>
References: <20220817185410.1174782-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817185410.1174782-1-nathan@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:54:11AM -0700, Nathan Chancellor wrote:
> LLVM 16 will have support for this flag so move it out of the GCC-only
> block to allow LLVM builds to take advantage of it.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1665
> Link: https://github.com/llvm/llvm-project/commit/6f867f9102838ebe314c1f3661fdf95700386e5a
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
> 
> I was not sure if this information is relevant for the commit message
> but I can boot without any issues on my test machines (two Intel and one
> AMD).
> 
>  arch/x86/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 7854685c5f25..987da87c7778 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -14,13 +14,13 @@ endif
>  
>  ifdef CONFIG_CC_IS_GCC
>  RETPOLINE_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
> -RETPOLINE_CFLAGS	+= $(call cc-option,-mindirect-branch-cs-prefix)
>  RETPOLINE_VDSO_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-inline -mindirect-branch-register)
>  endif
>  ifdef CONFIG_CC_IS_CLANG
>  RETPOLINE_CFLAGS	:= -mretpoline-external-thunk
>  RETPOLINE_VDSO_CFLAGS	:= -mretpoline
>  endif
> +RETPOLINE_CFLAGS	+= $(call cc-option,-mindirect-branch-cs-prefix)

Thanks for using the same option!
