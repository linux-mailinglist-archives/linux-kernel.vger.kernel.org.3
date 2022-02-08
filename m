Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F61F4AE572
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbiBHXcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiBHXcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:32:08 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A782CC06174F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:32:07 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n32so1101730pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 15:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IETubKdu8FYYZpgZa+JnP1hCgCdKxtvhTUairj3+pTY=;
        b=RsfZCPgONza6vfN7cXMXsl1oVFD1tu/9PLBtQNZ+71/UPgt9K5lFKNnI2JCVTb5Apa
         uCDs549iv7+DaY4dp35dNE4jW57xt8H7TtROLLe1m5nKqjMSXRMVT2Vpaf2WSTYNgGSc
         m1fZH6vB11+YOnJjrA6aRFrGUyL2da3okKMGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IETubKdu8FYYZpgZa+JnP1hCgCdKxtvhTUairj3+pTY=;
        b=FbRuqtkTgze+G733ize/Y/On7BbrpY0vu1z7B4Afniy8lhi9ZKeeAt7HDhx0jFJ7mJ
         vrhgMlSLYshsthug5WKT+vP5vVYFkui74DmcD5FL/UIRd2DYxgKPkUj1x0FqFow06ssa
         awpcDU8YUAswn9MJz1l6Tgwk22jipUhmbTheln1EAt13/MQJcKNMhYmMKxy7/Yp1hYv0
         sr3RqhyMk1w5e+bgh/BLPbkCzrDLtiEa+nj13XXp4z0meW13W+Luzm7vuFlzkd1a93XT
         QTlZ9sGfnUCR6W1WJZjf5F/5FCU4d/Lb7EgqpSfQp0JV+Zzdgc59idu9smDnYLJcA1Ub
         hvxA==
X-Gm-Message-State: AOAM532tlbhDwqk2VG4v/t9HvB4Gy0LyyU4C53LBm6VIjqH4uZHiX5tL
        tbnanlxfw5kg218uij8ktJXWqw==
X-Google-Smtp-Source: ABdhPJw92fvU2r9uSJdd3/u3L3L8mhXAZb+9H1YDMh0DHxX9z4XNLGqQUDHej60K5HYNFwyk05kOyQ==
X-Received: by 2002:a05:6a00:1acd:: with SMTP id f13mr6578099pfv.75.1644363127189;
        Tue, 08 Feb 2022 15:32:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nl7sm4029976pjb.5.2022.02.08.15.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 15:32:06 -0800 (PST)
Date:   Tue, 8 Feb 2022 15:32:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com
Subject: Re: [RFC][PATCH 2/6] x86: Base IBT bits
Message-ID: <202202081527.A65F1176F@keescook>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.088195171@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122170805.088195171@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 06:03:03PM +0100, Peter Zijlstra wrote:
> Add Kconfig, Makefile and basic instruction support for x86 IBT.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/Kconfig           |   10 ++++++++++
>  arch/x86/Makefile          |    5 ++++-
>  arch/x86/include/asm/ibt.h |   40 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+), 1 deletion(-)
> 
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1848,6 +1848,16 @@ config X86_UMIP
>  	  specific cases in protected and virtual-8086 modes. Emulated
>  	  results are dummy.
>  
> +config CC_HAS_IBT
> +	def_bool $(cc-option, -fcf-protection=branch)
> +
> +config X86_IBT
> +	prompt "Indirect Branch Tracking"
> +	bool
> +	depends on X86_64 && CC_HAS_IBT
> +	help
> +	  Increase kernel text size for giggles

How about:

	  For systems that support CET, enable Indirect Branch Tracking,
	  which blocks all JOP and indirect call pointer attacks that
	  are not pointing at function entry points (i.e. marked with
	  ENDBR). This also eliminates the use of all of the "misaligned"
	  gadgets that might be reachable in the middle of instructions.

> +
>  config X86_INTEL_MEMORY_PROTECTION_KEYS
>  	prompt "Memory Protection Keys"
>  	def_bool y
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -50,8 +50,11 @@ export BITS
>  #
>  KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
>  
> -# Intel CET isn't enabled in the kernel
> +ifeq ($(CONFIG_X86_IBT),y)
> +KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch)
> +else
>  KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
> +endif
>  
>  ifeq ($(CONFIG_X86_32),y)
>          BITS := 32
> --- /dev/null
> +++ b/arch/x86/include/asm/ibt.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_IBT_H
> +#define _ASM_X86_IBT_H
> +
> +#ifdef CONFIG_X86_IBT
> +
> +#ifndef __ASSEMBLY__
> +
> +// XXX note about GAS version required
> +
> +#ifdef CONFIG_X86_64
> +#define ASM_ENDBR	".byte 0xf3, 0x0f, 0x1e, 0xfa\n\t"
> +#else
> +#define ASM_ENDBR	".byte 0xf3, 0x0f, 0x1e, 0xfb\n\t"
> +#endif
> +
> +#else /* __ASSEMBLY__ */
> +
> +#ifdef CONFIG_X86_64
> +#define ENDBR	.byte 0xf3, 0x0f, 0x1e, 0xfa
> +#else
> +#define ENDBR	.byte 0xf3, 0x0f, 0x1e, 0xfb
> +#endif
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#else /* !IBT */
> +
> +#ifndef __ASSEMBLY__
> +
> +#define ASM_ENDBR
> +
> +#else /* __ASSEMBLY__ */
> +
> +#define ENDBR
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* CONFIG_X86_IBT */
> +#endif /* _ASM_X86_IBT_H */
> 
> 

-- 
Kees Cook
