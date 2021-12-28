Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7227A480D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhL1VHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:07:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56552 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236284AbhL1VHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:07:10 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF01B1EC0104;
        Tue, 28 Dec 2021 22:07:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640725625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SSoecSeOBeLEcRndhcE8vKfS9mB7fcaK7jiuRgl3J4=;
        b=HYnaBOm1sqQuVjw/VDzSpSDDg6Cd0lLkRJnSm8gWzoNFNFc0b/5NqcbklPJiZZsnl7H6AH
        Wwat+tylgWk8MTkZiWzdsGLK5LnTRVRyu4PmXeoubybXTv1tRGHAQ7zTQgdAOzRv6lNnA9
        oyIso3w3VRo11H5bKq+keyp8xKYvoZQ=
Date:   Tue, 28 Dec 2021 22:07:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next 1/2] x86: Use rdmsrl instead of rdmsr
Message-ID: <Yct8e5Z4M6YzAdCU@zn.tnic>
References: <20211210032208.28240-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211210032208.28240-1-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 11:22:07AM +0800, Yang Li wrote:
> From: Li Yang <yang.lee@linux.alibaba.com>
> 
> In the current scenario, variable 'hi' set but not used,
> rdmsrl() does not change the function, but it is more concise.
> 
> Eliminate the following clang warnings:
> arch/x86/kernel/process.c:889:10: warning: variable 'hi' set but not
> used [-Wunused-but-set-variable]
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Li Yang <yang.lee@linux.alibaba.com>
> ---
>  arch/x86/kernel/process.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 5d481038fe0b..b415f30278d1 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -886,7 +886,7 @@ void amd_e400_c1e_apic_setup(void)
>  
>  void __init arch_post_acpi_subsys_init(void)
>  {
> -	u32 lo, hi;
> +	u32 lo;
>  
>  	if (!boot_cpu_has_bug(X86_BUG_AMD_E400))
>  		return;
> @@ -896,7 +896,7 @@ void __init arch_post_acpi_subsys_init(void)
>  	 * the machine is affected K8_INTP_C1E_ACTIVE_MASK bits are set in
>  	 * MSR_K8_INT_PENDING_MSG.
>  	 */
> -	rdmsr(MSR_K8_INT_PENDING_MSG, lo, hi);
> +	rdmsrl(MSR_K8_INT_PENDING_MSG, lo);
>  	if (!(lo & K8_INTP_C1E_ACTIVE_MASK))
>  		return;
>  
> -- 

I believe you folks have been warned a bunch of times to think first
before acting upon a warning your silly bot catches.

Because your "fix" shows that you didn't even look at rdmsrl()'s
definition and what the second variable width is.

gcc explains it this way:

arch/x86/kernel/process.c: In function ‘arch_post_acpi_subsys_init’:
./arch/x86/include/asm/msr.h:277:11: warning: conversion from ‘long long unsigned int’ to ‘u32’ {aka ‘unsigned int’} may change value [-Wconversion]
  277 |  ((val) = native_read_msr((msr)))
      |           ^~~~~~~~~~~~~~~
arch/x86/kernel/process.c:899:2: note: in expansion of macro ‘rdmsrl’
  899 |  rdmsrl(MSR_K8_INT_PENDING_MSG, lo);
      |  ^~~~~~

so I'm ignoring all submissions from you from now on.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
