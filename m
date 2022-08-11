Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7E45906F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiHKT1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 15:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiHKT1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:27:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFC396FC7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:27:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d16so17727455pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xfhnVs3PaC5usAVNEu7i8rCmlaTeNScWKyrA8LXm5/8=;
        b=N4ZESQJUwri03sK+C6U+x9SiZS1kJoOtl9/XTee6ICwy7Xn9wRFIgIYCTy1jyXjHJ/
         gZC4Ht8Yf7BYRCKeWnlk6ufBf9mOJKddAHmFPKL956ZzlCz8OmF6QxQ5WBAEcxlMnmbP
         9mflQUy30A6HiDqOdajiROWD+4mWjbiRScXSeMnYbPQM2FMj8r96iOwwngbKTK87U671
         K1RKrHkAOYk79N/hjR+9d9EynSqbWEUvGngLA1a+quh6hZ+Lqd4pDCjUXPSi3jGZPaK1
         zTwj6ReDZVb+voDAEwuhMcAFvWbOokdC/3EaOr8T43oja3Qp2Kx4weHe812fLCWYq8fJ
         vicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xfhnVs3PaC5usAVNEu7i8rCmlaTeNScWKyrA8LXm5/8=;
        b=Pd2+MbsxDunMxXuPhnbVuDzZ0H1MHjjrYAA7ri7YdQhFuKK2gWB4MrRkyRrlfKnfV8
         4/Y0Dxvj47bThKGMDUAbshkXmcJPy5Tj4tiezmJek6+6viOAdsirNiGcksFDxJtIxlaJ
         DAGT3sYYFjVqKqCxTZcn3uvkQiZp/Br6TcdRnefuwXKk0/fxXVSUHQkRZXcARWajiiJN
         ldFYsE/RTkMSuPG/6T2KV/CYjd2gz7X4i76SvpTH/SCsBTiIUqpUHziCUDy+iK8GDM0H
         Zk6mh94czMWQAFn8hppRFHXWkWrZEvBX+cbksoEIyaM70lxEOlkLcrnNH8RAL0EH5I26
         lzdQ==
X-Gm-Message-State: ACgBeo2ZPu8beRdPGUqliM6k7djoqFcpgxVJHgQ8wvvXsXLd2ktVFdbG
        iQ0HrgDQ67B3IhzAJVDOAcV3pA==
X-Google-Smtp-Source: AA6agR5haPNlMfDQXIRE8V6B5qM0hdtv6Mlx+U/U4DRnQ91rBrM+TTT+HKDHGsFItmK4U3GIFSK4PA==
X-Received: by 2002:a17:902:7247:b0:16f:8361:ba26 with SMTP id c7-20020a170902724700b0016f8361ba26mr646092pll.83.1660246034033;
        Thu, 11 Aug 2022 12:27:14 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a199000b001f312e7665asm110165pji.47.2022.08.11.12.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 12:27:13 -0700 (PDT)
Date:   Thu, 11 Aug 2022 19:27:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Adam Dunlap <acdunlap@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Jacob Xu <jacobhxu@google.com>,
        Alper Gun <alpergun@google.com>, Marc Orr <marcorr@google.com>
Subject: Re: [PATCH] x86/asm: Force native_apic_mem_read to use mov
Message-ID: <YvVYDn1JODiu6hKK@google.com>
References: <20220811180010.3067457-1-acdunlap@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811180010.3067457-1-acdunlap@google.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022, Adam Dunlap wrote:
> Previously, when compiled with clang, native_apic_mem_read gets inlined
> into __xapic_wait_icr_idle and optimized to a testl instruction. When
> run in a VM with SEV-ES enabled, it attempts to emulate this
> instruction, but the emulator does not support it. Instead, use inline
> assembly to force native_apic_mem_read to use the mov instruction which
> is supported by the emulator.
> 
> Signed-off-by: Adam Dunlap <acdunlap@google.com>
> Reviewed-by: Marc Orr <marcorr@google.com>
> Reviewed-by: Jacob Xu <jacobhxu@google.com>
> ---
>  arch/x86/include/asm/apic.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index 3415321c8240..281db79e76a9 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -109,7 +109,18 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
>  
>  static inline u32 native_apic_mem_read(u32 reg)
>  {
> -	return *((volatile u32 *)(APIC_BASE + reg));
> +	volatile u32 *addr = (volatile u32 *)(APIC_BASE + reg);
> +	u32 out;
> +
> +	/*
> +	 * Functionally, what we want to do is simply return *addr. However,
> +	 * this accesses an MMIO which may need to be emulated in some cases.
> +	 * The emulator doesn't necessarily support all instructions, so we
> +	 * force the read from addr to use a mov instruction.
> +	 */
> +	asm_inline("movl %1, %0" : "=r"(out) : "m"(*addr));
> +
> +	return out;

Can't this just be:

	return readl((void __iomem *)(APIC_BASE + reg));
