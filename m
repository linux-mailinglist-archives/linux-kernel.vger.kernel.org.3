Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31F4C7C20
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiB1Vgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiB1Vgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:36:47 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1503F149951
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hs7WDIZJlPZyDdP2h5rMRPbPR3qYHuRMed6LHI5a8ss=; b=GlJ/SjVtqSwz7ZBzQBYfFjtI4t
        oKduZ6rdJMhhHYPXk/FZjjRGoyUt/m9bU2XeVvyo+7PCiQ9cHzKDSPwOeh7qlyVGB47tV88OBV6xP
        wPD0qCu1UmHg4H69wWBb9rfTxRLQUSriPQXHp/kQPe99mI160Zpif1cwZYRwB2H0a/q1+sK8MYSIW
        tqmGGFjp8MS8X0a6fl6Fef3718y1ebACIcP3Z2Fsw2KSmPBCs/XYZZiLEdZLUxKn3rrleMc1OoDtY
        mvOjrpgbnFsnkJhsareiajEoXsob4cDh4otmrEucLwKBfxVNtnjabWt1TJS1d1Ymrpa379Wa9cCEc
        c2FxUuCg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOngY-00E0nu-OX; Mon, 28 Feb 2022 21:36:03 +0000
Message-ID: <572ea830-b376-0e38-8f62-09dbd9ba9900@infradead.org>
Date:   Mon, 28 Feb 2022 13:35:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 01/10] x86/Kconfig: enable X86_X2APIC by default and
 improve help text
Content-Language: en-US
To:     =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>
References: <20220228212826.27080-1-mat.jonczyk@o2.pl>
 <20220228212826.27080-2-mat.jonczyk@o2.pl>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220228212826.27080-2-mat.jonczyk@o2.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 2/28/22 13:28, Mateusz Jończyk wrote:
> As many current platforms (most modern Intel CPUs and QEMU) have x2APIC
> present, enable CONFIG_X86_X2APIC by default as it gives performance
> and functionality benefits. Additionally, if the BIOS has already
> switched APIC to x2APIC mode, but CONFIG_X86_X2APIC is disabled, the
> kernel will panic in arch/x86/kernel/apic/apic.c .
> 
> Also improve the help text, which was confusing and really did not
> describe what the feature is about.
> 

> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
> ---
>  arch/x86/Kconfig | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9f5bd41bf660..64d760a2b81a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -437,15 +437,27 @@ config X86_FEATURE_NAMES
>  	  If in doubt, say Y.
>  
>  config X86_X2APIC
> -	bool "Support x2apic"
> +	bool "Support CPUs with x2APIC interrupt controllers"
>  	depends on X86_LOCAL_APIC && X86_64 && (IRQ_REMAP || HYPERVISOR_GUEST)
> +	default y
>  	help
> -	  This enables x2apic support on CPUs that have this feature.
> +	  x2APIC is an interrupt controller architecture, a component of which
> +	  (the local APIC) is present in the CPU. It allows faster access to
> +	  the local APIC and supports a larger number of CPUs in the system
> +	  then the predecessors.

	  than

>  
> -	  This allows 32-bit apic IDs (so it can support very large systems),
> -	  and accesses the local apic via MSRs not via mmio.
> +	  x2APIC was introduced in Intel CPUs around 2008 and in AMD EPYC CPUs
> +	  in 2019, but it can be disabled by the BIOS. It is also frequently
> +	  emulated in virtual machines, even when the host CPU does not support
> +	  it. Support in the CPU be checked by executing

	                     CPU can be checked by executing

> +		cat /proc/cpuinfo | grep x2apic
>  
> -	  If you don't know what to do here, say N.
> +	  If this configuration option is disabled, the kernel will not boot on
> +	  some platforms that have x2APIC enabled.
> +
> +	  Say N if you know that your platform does not have x2APIC.
> +
> +	  Otherwise, say Y.
>  
>  config X86_MPPARSE
>  	bool "Enable MPS table" if ACPI

-- 
~Randy
