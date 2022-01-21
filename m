Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2BB4967BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiAUWRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiAUWRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:17:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39C9C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:17:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B47BB82118
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 22:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FBBC340E1;
        Fri, 21 Jan 2022 22:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642803468;
        bh=ccD+lMyQ8So8ChcB4eTdVAeY5Os12SZbUYpwYMGaWWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ov00QIPB6CXyNqJOD0CHup0U8RSbnp3YrlV5/ZVRmTeJMJiPBMfftejEp0yKKy1Xh
         +J46P47akPJf58n7pJ2EDBtzhDu7AabnL2DB5zPQYdDI08fmu9zszVGsI1yX6JnGxv
         6JxXViPN1sLAuPJRiEKZnCLtOUcjmKehkZY2dqiLBCN1Khn8N+tbOEs3Yef9pLtNqv
         qKAv7ijO4PLq+bA659/ZnqOSWKcpLvoJoTfkFEqFotG/hY7/y/pbgUbpVjowJ1J8yA
         Myj04ssRyIwGlR+SOjae/Eb+7uAZhUpQhPPniGD0g1GEaS0RqLlT02WDAVP2gnfafR
         wJckrMeNOXfzQ==
Date:   Fri, 21 Jan 2022 15:17:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 13/14] ARM: use .arch directives instead of assembler
 command line flags
Message-ID: <YesxB6W3XsTWjVFY@archlinux-ax161>
References: <20210928154143.2106903-1-arnd@kernel.org>
 <20210928154143.2106903-14-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928154143.2106903-14-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Sep 28, 2021 at 05:41:42PM +0200, Arnd Bergmann wrote:
> From: Nick Desaulniers <ndesaulniers@google.com>
> 
> Similar to commit a6c30873ee4a ("ARM: 8989/1: use .fpu assembler
> directives instead of assembler arguments").
> 
> GCC and GNU binutils support setting the "sub arch" via -march=,
> -Wa,-march, target function attribute, and .arch assembler directive.
> 
> Clang's integrated assembler does not support -Wa,-march (and the logic
> to overrule one when multiple of the above are used), and this can
> cause annoying warnings such as:
> 
> clang: warning: argument unused during compilation: '-march=armv6k' [-Wunused-command-line-argument]
> clang: warning: argument unused during compilation: '-march=armv6k' [-Wunused-command-line-argument]
> clang: warning: argument unused during compilation: '-march=armv6k' [-Wunused-command-line-argument]
> 
> Since most assembler is non-conditionally assembled with one sub arch
> (modulo arch/arm/delay-loop.S which conditionally is assembled as armv4
> based on CONFIG_ARCH_RPC, and arch/arm/mach-at91/pm-suspend.S which is
> conditionally assembled as armv7-a based on CONFIG_CPU_V7), prefer the
> .arch assembler directive.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=48894
> Link: https://github.com/ClangBuiltLinux/linux/issues/1195
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> [arnd] add a few more instances found in compile testing
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Did anything ever come of this patch (or series)? I would like to add
-Werror=unused-command-line-argument to CLANG_FLAGS so that invalid
flags will not cause cascading cc-option failures but we cannot not do
that until this is resolved.

Cheers,
Nathan
