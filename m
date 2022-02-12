Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E014B32C1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 03:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiBLCre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 21:47:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiBLCrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 21:47:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6953632065
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 18:47:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4AF3B82C89
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 02:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C43C340E9;
        Sat, 12 Feb 2022 02:47:24 +0000 (UTC)
Date:   Fri, 11 Feb 2022 21:47:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH kernel] trace: Make FTRACE_MCOUNT_USE_RECORDMCOUNT
 configurable
Message-ID: <20220211214722.4373ca83@rorschach.local.home>
In-Reply-To: <20220211014313.1790140-1-aik@ozlabs.ru>
References: <20220211014313.1790140-1-aik@ozlabs.ru>
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

On Fri, 11 Feb 2022 12:43:13 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> For whatever reason LLVM does not allow LTO (Link Time Optimization) if
> FTRACE_MCOUNT_USE_RECORDMCOUNT is enabled.
> 
> This allows disabling just this option instead of disabling all FTRACE
> options.

What FTRACE options are you talking about?

> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> Or disabling FTRACE is the right thing to do if HAS_LTO_CLANG=y?
> 
> Came from arch/Kconfig:
> 
> config HAS_LTO_CLANG
>         def_bool y
>         depends on CC_IS_CLANG && LD_IS_LLD && AS_IS_LLVM
>         depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
>         depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
>         depends on ARCH_SUPPORTS_LTO_CLANG
>         depends on !FTRACE_MCOUNT_USE_RECORDMCOUNT  <======
>         depends on !KASAN || KASAN_HW_TAGS
>         depends on !GCOV_KERNEL
> 
> 
> ---
>  kernel/trace/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index a5eb5e7fd624..87d82d2b0b0b 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -704,7 +704,8 @@ config FTRACE_MCOUNT_USE_OBJTOOL
>  	depends on FTRACE_MCOUNT_RECORD
>  
>  config FTRACE_MCOUNT_USE_RECORDMCOUNT
> -	def_bool y
> +	bool "Enable FTRACE_MCOUNT_USE_RECORDMCOUNT"
> +	default y

I don't think this does what you think it does.

This is not something that should be user selectable. What exactly are
you trying to accomplish here?

-- Steve


>  	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
>  	depends on !FTRACE_MCOUNT_USE_CC
>  	depends on !FTRACE_MCOUNT_USE_OBJTOOL

