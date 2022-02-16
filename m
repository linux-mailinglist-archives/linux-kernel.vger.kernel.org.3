Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117484B7CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245620AbiBPBrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:47:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244841AbiBPBrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:47:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABC22B262
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:47:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6149EB81DB2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F12EC340EB;
        Wed, 16 Feb 2022 01:46:58 +0000 (UTC)
Date:   Tue, 15 Feb 2022 20:46:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [RFC PATCH kernel] trace: Make FTRACE_MCOUNT_USE_RECORDMCOUNT
 configurable
Message-ID: <20220215204657.4a7e4784@gandalf.local.home>
In-Reply-To: <8b1d0d57-0bf7-8ca5-8b08-cd5a12f7666f@ozlabs.ru>
References: <20220211014313.1790140-1-aik@ozlabs.ru>
        <20220211214722.4373ca83@rorschach.local.home>
        <8b1d0d57-0bf7-8ca5-8b08-cd5a12f7666f@ozlabs.ru>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 12:19:14 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 2/12/22 13:47, Steven Rostedt wrote:
> > On Fri, 11 Feb 2022 12:43:13 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >   
> >> For whatever reason LLVM does not allow LTO (Link Time Optimization) if
> >> FTRACE_MCOUNT_USE_RECORDMCOUNT is enabled.
> >>
> >> This allows disabling just this option instead of disabling all FTRACE
> >> options.  
> > 
> > What FTRACE options are you talking about?  
> 
> LTO_CLANG_THIN => HAS_LTO_CLANG => !FTRACE_MCOUNT_USE_RECORDMCOUNT =>
> 
> FTRACE [=y] && !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY [=n] && 
> !FTRACE_MCOUNT_USE_CC [=n] && !FTRACE_MCOUNT_USE_OBJTOOL [=n] && 
> FTRACE_MCOUNT_RECORD [=y]

So basically, turn off FUNCTION_TRACER and STACK_TRACER.

> 
> A bunch.
> 
> 
> >   
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>
> >> Or disabling FTRACE is the right thing to do if HAS_LTO_CLANG=y?
> >>
> >> Came from arch/Kconfig:
> >>
> >> config HAS_LTO_CLANG
> >>          def_bool y
> >>          depends on CC_IS_CLANG && LD_IS_LLD && AS_IS_LLVM
> >>          depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
> >>          depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
> >>          depends on ARCH_SUPPORTS_LTO_CLANG
> >>          depends on !FTRACE_MCOUNT_USE_RECORDMCOUNT  <======
> >>          depends on !KASAN || KASAN_HW_TAGS
> >>          depends on !GCOV_KERNEL
> >>
> >>
> >> ---
> >>   kernel/trace/Kconfig | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> >> index a5eb5e7fd624..87d82d2b0b0b 100644
> >> --- a/kernel/trace/Kconfig
> >> +++ b/kernel/trace/Kconfig
> >> @@ -704,7 +704,8 @@ config FTRACE_MCOUNT_USE_OBJTOOL
> >>   	depends on FTRACE_MCOUNT_RECORD
> >>   
> >>   config FTRACE_MCOUNT_USE_RECORDMCOUNT
> >> -	def_bool y
> >> +	bool "Enable FTRACE_MCOUNT_USE_RECORDMCOUNT"
> >> +	default y  
> > 
> > I don't think this does what you think it does.  
> 
> Sounds like it.
> 
> > This is not something that should be user selectable. What exactly are
> > you trying to accomplish here?  
> 
> I am trying to
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index b779603978e1..91c122224f83 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -153,6 +153,8 @@ config PPC
>          select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>          select ARCH_WANT_LD_ORPHAN_WARN
>          select ARCH_WEAK_RELEASE_ACQUIRE
> +       select ARCH_SUPPORTS_LTO_CLANG          if PPC64
> +       select ARCH_SUPPORTS_LTO_CLANG_THIN     if PPC64
> 
> 
> to get LTO working on powerpc64le with minimal change to 
> ppc64le_defconfig which has all these FTRACE_xxx enabled.

Well, you can add a dependency against FUNCTION_TRACER. As that's what
turns on the RECORD_MCOUNT, as RECORD_MCOUNT is needed by it.

-- Steve

