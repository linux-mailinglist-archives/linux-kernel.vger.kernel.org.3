Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C039E574040
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiGMX4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiGMX4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:56:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF1D25C68;
        Wed, 13 Jul 2022 16:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B77061B9F;
        Wed, 13 Jul 2022 23:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B93C34114;
        Wed, 13 Jul 2022 23:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657756567;
        bh=w9QDpjFt83SVkoNzE3l0IoLYZGIJ/X2ZtHlBTIBu8Z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRi9OIcKQZDIv4bg9ROG7Gk+uipvkviz+N2F5AeEN6E7sWSiLVn0m122+TL2jL66C
         9js1R0g/eFgVsIlOCFCtFunJW+52xs3cXL7yKUT4bIUWi8zoXV3mUGSyTycRsfflRS
         OMsvHO8RSZiEzq3++c7SOq1YTAXykY4FsJSFQDc12IVNvFR/Jppbb9Jji90fOwEYEv
         iPVfg3QUorhkaiw4LWmRgXndKqM/qtAyisTa6M9VgWUG91jAyDQMUm3DhPsu1ecxnd
         WZHDJljmQW87pJmoPI8A3cJA0pd3rZi4pmTUwEagzBmcTCk60hzuXMcxNuMHE+yHMm
         WUMljUgRL1utQ==
Date:   Wed, 13 Jul 2022 16:56:05 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/alternative: Report missing return thunk details
Message-ID: <20220713235605.k5gblq46okdyl6eg@treble>
References: <20220713213819.460771-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220713213819.460771-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 02:38:19PM -0700, Kees Cook wrote:
> Debugging missing return thunks is easier if we can see where they're
> happening.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/lkml/Ys66hwtFcGbYmoiZ@hirez.programming.kicks-ass.net/
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: x86@kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/kernel/alternative.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index d6858533e6e5..62f6b8b7c4a5 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -555,7 +555,9 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
>  			dest = addr + insn.length + insn.immediate.value;
>  
>  		if (__static_call_fixup(addr, op, dest) ||
> -		    WARN_ON_ONCE(dest != &__x86_return_thunk))
> +		    WARN_ONCE(dest != &__x86_return_thunk,
> +			      "missing return thunk: %pS-%pS: %*ph",
> +			      addr, dest, 5, addr))

String needs a newline?

-- 
Josh
