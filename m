Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEDE4C3A75
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiBYArk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBYAri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:47:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89508B0E86
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:47:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D9FE61D17
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC77C340E9;
        Fri, 25 Feb 2022 00:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645750025;
        bh=3m3SmJSHBHP3bsYWhgDTWGsAaPNj2eo5w38xwMsRoFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b2V6mW4bFEWJF/zmPajGlPodxWuvHTsutZdYoBuEaofy1svc7CjmnhNYqeZzT1Y9G
         0JczrKrsyIR4iR5rvR02dfA4m1TXhASQecCiLScbi21p0RbSF4Or08VZeQSLAf0peC
         8Kl7jdrU/Mfj0JUxETeV3lqcoqDgt5fO3d0O/M4uInbF2mPj1otdESRNaUuvuXJNtE
         YR4c23/V++1w/aFWdU+0wFs2kbpyqtml3T+wEHurwENGXChYZzPSYOnMKt9ELqEZYF
         fnoM0UPV6yBJKPH7CGj2b1we9Axb1xLBeTvAKMm8yGpLTU7Pt6jRDYX9E3JtMiA3FR
         aC6dkKHGbi6aA==
Date:   Thu, 24 Feb 2022 17:46:59 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com, llvm@lists.linux.dev
Subject: Re: [PATCH v2 05/39] x86: Base IBT bits
Message-ID: <YhgnA8O4Bp19hfse@dev-arch.archlinux-ax161>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.307406918@infradead.org>
 <202202241627.EEF3D5D2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202241627.EEF3D5D2@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 04:35:51PM -0800, Kees Cook wrote:
> On Thu, Feb 24, 2022 at 03:51:43PM +0100, Peter Zijlstra wrote:
> > Add Kconfig, Makefile and basic instruction support for x86 IBT.
> > 
> > XXX clang is not playing ball, probably lld being 'funny', I'm having
> > problems with .plt entries appearing all over after linking.
> 
> I'll try to look into this; I know you've been chatting with Nathan
> about it. Is there an open bug for it? (And any kind of reproducer
> smaller than a 39 patch series we can show the linker folks?) :)

I should be able to create a reproducer with cvise and file a bug on
GitHub around this tomorrow, I should have done it after Peter's
comments on IRC.

Cheers,
Nathan

> > [...]
> > +config X86_KERNEL_IBT
> > +	prompt "Indirect Branch Tracking"
> > +	bool
> > +	depends on X86_64 && CC_HAS_IBT
> > +	help
> > +	  Build the kernel with support for Indirect Branch Tracking, a
> > +	  hardware supported CFI scheme. Any indirect call must land on
> 
> 	  hardware support course-grain forward-edge Control Flow Integrity
> 	  protection. It enforces that all indirect calls must land on
> 
> > +	  an ENDBR instruction, as such, the compiler will litter the
> > +	  code with them to make this happen.
> 
> "litter the code" -> "instrument the machine code".
> 
> 
> > +
> >  config X86_INTEL_MEMORY_PROTECTION_KEYS
> >  	prompt "Memory Protection Keys"
> >  	def_bool y
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -36,7 +36,7 @@ endif
> >  
> >  # How to compile the 16-bit code.  Note we always compile for -march=i386;
> >  # that way we can complain to the user if the CPU is insufficient.
> > -REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING \
> > +REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
> >  		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
> >  		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
> >  		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)
> 
> This change seems important separately from this patch, yes? (Or at
> least a specific call-out in the commit log.)
> 
> Otherwise, looks good.
> 
> -- 
> Kees Cook
