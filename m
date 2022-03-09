Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C0C4D3C99
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbiCIWHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbiCIWHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:07:35 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D90011EF36
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:06:36 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n15so3185193plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4umDXsTj1CldyJcysNP+Nnq3pVu2iPQxmtjAZsmbWQc=;
        b=fonhPV0Eq1KKbf2UvQA+KGAibGPw26KwBtm0dM70xCxj6ATohjtHnwM9d6UdiJ4pES
         TtwRiVhwuqVmD1pMJN1AjZmG+ufDLj8RIalRJKwWBNl6MUbtTzyxogX/ltfosrYrsK1W
         ukbHTdoheSpC4mi3+swuWKJMWUMvllUxyoHhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4umDXsTj1CldyJcysNP+Nnq3pVu2iPQxmtjAZsmbWQc=;
        b=N+7A8zY++23bqquJ9iiS33rmLRyRsJ7k+UsE91wGWqleYuVHs1TDsDuCcqRMI1cZqq
         2Mee29vxEXtCa9Fc5mgCXhi4MjBMf2IZkBbRFjrZJuokXwPp5xnndisTDcce64vANltN
         /xwrW9pX44Xvajr5F4Sd0qnH4t7YHa0KFpNcgbnritn2kJtKBb+syulmbUptdLwQ5irK
         OniwRiCMciqu2C6QRQ/ex4r9nHdO72dFp1GFVw2+S/gbZ6y4dyjgCbb14YxJpfuhLR0t
         l8frVX/hGEwFuoEFRRK6knv4gtZKvcawRnZdxQZd4zkltDfHCOMVlmV2SZZ2i5Rl90Qf
         lALQ==
X-Gm-Message-State: AOAM531RZJMbQr0zlipbR08f6vjbUO8gdiur/zJzYeOjZwtvZQK0krOr
        iTWu3T4VJGYXmoAO5UVXQzocYA==
X-Google-Smtp-Source: ABdhPJzGofjm+FGYBG97TRW7gxvFjqmZFdCBX6uEyrkbYPtSeUo2O0Yh6GCX+Sushx4dJa23puvXbA==
X-Received: by 2002:a17:902:7404:b0:151:c3f9:e43a with SMTP id g4-20020a170902740400b00151c3f9e43amr1839188pll.12.1646863595999;
        Wed, 09 Mar 2022 14:06:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u8-20020a056a00098800b004f702473553sm4134935pfg.6.2022.03.09.14.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:06:35 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:06:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Yanteng Si <siyanteng01@gmail.com>, linux-mips@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MIPS: Only use current_stack_pointer on GCC
Message-ID: <202203091406.E94510FD@keescook>
References: <20220309204537.390428-1-keescook@chromium.org>
 <YikTQRql+il3HbrK@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YikTQRql+il3HbrK@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 01:51:13PM -0700, Nathan Chancellor wrote:
> Nit: I think the subject needs to be updated (I assume this was written
> before Nick's fix?).
> 
> On Wed, Mar 09, 2022 at 12:45:37PM -0800, Kees Cook wrote:
> > Unfortunately, Clang did not have support for "sp" as a global register
> > definition, and was crashing after the addition of current_stack_pointer.
> > This has been fixed in Clang 15, but earlier Clang versions need to
> > avoid this code, so add a versioned test and revert back to the
> > open-coded asm instances. Fixes Clang build error:
> > 
> > fatal error: error in backend: Invalid register name global variable
> > 
> > Fixes: 200ed341b864 ("mips: Implement "current_stack_pointer"")
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Yanteng Si <siyanteng01@gmail.com>
> > Cc: linux-mips@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Thanks for sending this!
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> > ---
> >  arch/mips/Kconfig                   | 2 +-
> >  arch/mips/include/asm/thread_info.h | 2 ++
> >  arch/mips/kernel/irq.c              | 3 ++-
> >  arch/mips/lib/uncached.c            | 4 +++-
> >  4 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 3f58b45fc953..15769013f46e 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -4,7 +4,7 @@ config MIPS
> >  	default y
> >  	select ARCH_32BIT_OFF_T if !64BIT
> >  	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
> > -	select ARCH_HAS_CURRENT_STACK_POINTER
> > +	select ARCH_HAS_CURRENT_STACK_POINTER if !CC_IS_CLANG || CLANG_VERSION >= 150000
> 
> Nit: This can be 140000, as release/14.x has received the fix:
> 
> https://github.com/llvm/llvm-project/commit/0826716786cd4a8c7cbcb8c01e4d9fac46b7a17a

Oh! Excellent. Thanks; I missed that it made the branch. I'll send a v2.

-- 
Kees Cook
