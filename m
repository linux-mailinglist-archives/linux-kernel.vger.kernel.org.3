Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A023C57BF17
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiGTUNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGTUNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:13:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57E24D148
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:13:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id z3so3622069plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mef0C0CUj0VJK5j5PUIMZgeU5xcjeqN+yRq5IFsDKfo=;
        b=oO8IRBzpUM2DfUm+JNOFFxc6ALnBm0mhSWnEs4Rl7ulus/P2YWFWBey3Imp58vl8Eo
         sC9AcWWU/2YIIa+385oS4QX3pRjNMMi3do82fLk43Q/kG1zgGEst1sfrZhaZDg88RWGh
         caKbb+ZpytAeyGdrNISUT4JuMhRWUEvjGmETs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mef0C0CUj0VJK5j5PUIMZgeU5xcjeqN+yRq5IFsDKfo=;
        b=mCs4wkuAdE3g0n4iZwv/JKz77J9Ejqxee1Gs8TsMZ9FC0zTeJPyZ0eyZPFHYdkDBZe
         39l/CMbh7eSRM66R8x/wSJwglRfaOdig9LErxWokaQWHKaJODMZcvvQk40hPRRRyS20Q
         yeLufJQ6juDpgXTbAi77qIDcqFSXVECKCc2WUtpy2vixS7CyElMe7m80tlJ48gYxvZY3
         KvBV+m3IIWXpiSbddsiNxxfHmyhLLkFRq0OqD3QF20aSQyVufqNdWwOF2ByrVtsWKCYZ
         33EK5nJWcghaP5YvKp7O28xdXImD0O3KlLiK7gMwDO350y+qA5FZsVFU+rV9rvPLLgy/
         6h4w==
X-Gm-Message-State: AJIora9+r0VBlSmpDL8YYsK80fOrsfAwEFem1gXzwxR1FaO6DCrdzQVE
        MkXWZEWym6LAE5oL+q2vYAQMhMntgbCAFw==
X-Google-Smtp-Source: AGRyM1tlzC1RJIiVdjPgbZ/cqVYyjfpbdvYCsdUabpQv0LSFTuT0P5KRkgbGscPlYuDRbWC4z2rE5g==
X-Received: by 2002:a17:90a:9709:b0:1f2:84a:cc7d with SMTP id x9-20020a17090a970900b001f2084acc7dmr7189724pjo.180.1658347986284;
        Wed, 20 Jul 2022 13:13:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b0016c42929f70sm14401509plx.87.2022.07.20.13.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 13:13:05 -0700 (PDT)
Date:   Wed, 20 Jul 2022 13:13:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] lkdtm: Keep the rodata test from causing retbleed
 WARNINGS
Message-ID: <202207201311.775CB068@keescook>
References: <20220720155507.4f904a58@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720155507.4f904a58@gandalf.local.home>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 03:55:07PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The rodata test checks if executable code in the .rodata section will not
> execute. But this also means that fix ups that the return hook code does
> will not be able to change this code at boot up, and this causes a
> warning.
> 
> By removing the RETHOOK_CFLAGS from the compilation of the rodata function
> makes it hidden from objtool and it will not add its return hook into the
> .returns section. This keeps the fix up code from trying and failing on
> modifying the rodata return call.
> 
> Link: https://lore.kernel.org/all/20220720125736.48164a14@gandalf.local.home/
> 
> Fixes: ee88d363d1561 ("x86,static_call: Use alternative RET encoding")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Yeah, this matches a portion of what was suggested:
https://lore.kernel.org/lkml/20220713213133.455599-1-keescook@chromium.org/

But it still needed objtool fixes:
https://lore.kernel.org/lkml/20220715032333.neywlazczbb35w3b@treble/

Perhaps objtool has already had patches landed for this? (Otherwise the
patch you suggested would fail to build on x86 with rethunk support.)

-Kees

> ---
> 
>  [ Note, my tests are still running with this, but it passed the test that
>    caused the failure, so I decided to post this now. ]
> 
>  arch/x86/Makefile           | 1 +
>  drivers/misc/lkdtm/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 1f40dad30d50..2dd61d8594f4 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -25,6 +25,7 @@ endif
>  ifdef CONFIG_RETHUNK
>  RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
>  RETPOLINE_CFLAGS	+= $(RETHUNK_CFLAGS)
> +export RETHUNK_CFLAGS
>  endif
>  
>  export RETPOLINE_CFLAGS
> diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
> index 2e0aa74ac185..fd96ac1617f7 100644
> --- a/drivers/misc/lkdtm/Makefile
> +++ b/drivers/misc/lkdtm/Makefile
> @@ -16,7 +16,7 @@ lkdtm-$(CONFIG_PPC_64S_HASH_MMU)	+= powerpc.o
>  KASAN_SANITIZE_rodata.o		:= n
>  KASAN_SANITIZE_stackleak.o	:= n
>  KCOV_INSTRUMENT_rodata.o	:= n
> -CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
> +CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO) $(RETHUNK_CFLAGS)
>  
>  OBJCOPYFLAGS :=
>  OBJCOPYFLAGS_rodata_objcopy.o	:= \
> -- 
> 2.35.1
> 

-- 
Kees Cook
