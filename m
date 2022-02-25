Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A86B4C3A68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiBYAg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBYAg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:36:26 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8384527DF2D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:35:53 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z4so3153990pgh.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t9WDGudgTxtENWYDPYTPFz27xdCIdzpF9PzSXLCu+HE=;
        b=nSdm1jF9UdfebBvADyqxpuC4Jir5BHroQmt0KoeK0N4eBfTFJPgN8sIu0y5MLvLMVL
         TXKslUxZATYNHDr8g2iO63sCb1WQ0ZSzkWcQQX7j0nm3NtaWT65aF/iWLwtrl2Xi6OZa
         94XZqUC4HyZarX0oc8WH5ZJBC7aG27LxapJ2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t9WDGudgTxtENWYDPYTPFz27xdCIdzpF9PzSXLCu+HE=;
        b=vlV7k9WsIxO/kasWog3bh3/4h2ffaud8L3p+Nsn3/9ZI3YcGRNG7qgSY0W1fBCuCZI
         cwgIyZwtMaXvnv0TrRDhDXvqif2LfQxWHqT9v5ZsBK0mAqqy8+v6/fZ8z4wwKSPaHMrj
         hds7ceLGbMbdHZ85hO08kKRzwSYth8TDtX9CIwZm8Ocn4FcKv4Q5SOz6Voo8T9+dUssA
         38am1MZNMJp41rTPQe71WKSK8z6+9CyZ63lpCM3UZVsWtk/IPYcRks401hclxPR2fFuP
         4M77ouJ+fHeanindpkYPHeq6lGORksqIBax3Pv6TJif7WwRWV1+DPc3rE0bgCcsdOXn+
         6GoA==
X-Gm-Message-State: AOAM532sqHkXkU3xyn8ir+mvibONBfHMLbwToiwJk94ejN6A8rk0lMAw
        52syEA35vpj3AKjexVy6vCy6bQ==
X-Google-Smtp-Source: ABdhPJzXjEWUx16LXa9vXAwYPTcx43KbIK8MVynbRR4B/TS5XnP5S84RYYzkGq04XuMpnFhct0w0kQ==
X-Received: by 2002:a63:dd17:0:b0:36c:33aa:6d5f with SMTP id t23-20020a63dd17000000b0036c33aa6d5fmr4136992pgg.300.1645749353010;
        Thu, 24 Feb 2022 16:35:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a15-20020a637f0f000000b00372e075b2efsm622127pgd.30.2022.02.24.16.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:35:52 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:35:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 05/39] x86: Base IBT bits
Message-ID: <202202241627.EEF3D5D2@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.307406918@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151322.307406918@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:43PM +0100, Peter Zijlstra wrote:
> Add Kconfig, Makefile and basic instruction support for x86 IBT.
> 
> XXX clang is not playing ball, probably lld being 'funny', I'm having
> problems with .plt entries appearing all over after linking.

I'll try to look into this; I know you've been chatting with Nathan
about it. Is there an open bug for it? (And any kind of reproducer
smaller than a 39 patch series we can show the linker folks?) :)

> [...]
> +config X86_KERNEL_IBT
> +	prompt "Indirect Branch Tracking"
> +	bool
> +	depends on X86_64 && CC_HAS_IBT
> +	help
> +	  Build the kernel with support for Indirect Branch Tracking, a
> +	  hardware supported CFI scheme. Any indirect call must land on

	  hardware support course-grain forward-edge Control Flow Integrity
	  protection. It enforces that all indirect calls must land on

> +	  an ENDBR instruction, as such, the compiler will litter the
> +	  code with them to make this happen.

"litter the code" -> "instrument the machine code".


> +
>  config X86_INTEL_MEMORY_PROTECTION_KEYS
>  	prompt "Memory Protection Keys"
>  	def_bool y
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -36,7 +36,7 @@ endif
>  
>  # How to compile the 16-bit code.  Note we always compile for -march=i386;
>  # that way we can complain to the user if the CPU is insufficient.
> -REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING \
> +REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
>  		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
>  		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
>  		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)

This change seems important separately from this patch, yes? (Or at
least a specific call-out in the commit log.)

Otherwise, looks good.

-- 
Kees Cook
