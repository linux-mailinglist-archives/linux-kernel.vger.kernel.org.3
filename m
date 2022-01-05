Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B3484FEB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbiAEJVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:21:05 -0500
Received: from foss.arm.com ([217.140.110.172]:42370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbiAEJVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:21:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75C621042;
        Wed,  5 Jan 2022 01:21:04 -0800 (PST)
Received: from [10.163.72.138] (unknown [10.163.72.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 964D13F774;
        Wed,  5 Jan 2022 01:21:02 -0800 (PST)
Subject: Re: [PATCH] arm64: fix build error when use rodata_enabled
To:     AliOS system security <alios_sys_security@linux.alibaba.com>,
        catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1641352075-25200-1-git-send-email-alios_sys_security@linux.alibaba.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0432f592-789b-7c92-8d7a-99191d7bc669@arm.com>
Date:   Wed, 5 Jan 2022 14:51:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1641352075-25200-1-git-send-email-alios_sys_security@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 1/5/22 8:37 AM, AliOS system security wrote:
> rodata_enabled should be used when CONFIG_STRICT_KERNEL_RWX
> or CONFIG_STRICT_MODULE_RWX is selected

Both these configs get selected invariably with CONFIG_ARM64 in the
platform config file (arch/arm64/Kconfig). I guess there can not be
any such situation, where both configs will be missing/not selected
given ARCH_OPTIONAL_KERNEL_RWX[or _DEFAULT] is not enabled on arm64.

config ARM64
        def_bool y
        select ACPI_CCA_REQUIRED if ACPI
	.....
        select ARCH_HAS_STRICT_KERNEL_RWX
        select ARCH_HAS_STRICT_MODULE_RWX
	.....

Hence for all practical purpose, rodata_enabled could be considered
always available. I am sure there other similar situations as well,
where code elements are not wrapped around if the config option is
always present.

> 
> Signed-off-by: AliOS system security <alios_sys_security@linux.alibaba.com>

Also please refer Documentation/process/submitting-patches.rst for
the rules regarding names, that can be used for a commit sign off.

------------------------------------------------------------------------
then you just add a line saying::

        Signed-off-by: Random J Developer <random@developer.example.org>

using your real name (sorry, no pseudonyms or anonymous contributions.)
------------------------------------------------------------------------

- Anshuman

> ---
>  arch/arm64/mm/mmu.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index acfae9b..47f8754 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -596,6 +596,7 @@ static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
>  	vm_area_add_early(vma);
>  }
>  
> +#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
>  static int __init parse_rodata(char *arg)
>  {
>  	int ret = strtobool(arg, &rodata_enabled);
> @@ -613,11 +614,16 @@ static int __init parse_rodata(char *arg)
>  	return 0;
>  }
>  early_param("rodata", parse_rodata);
> +#endif
>  
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  static int __init map_entry_trampoline(void)
>  {
> -	pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
> +	pgprot_t prot = PAGE_KERNEL_EXEC;
> +#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
> +	if (rodata_enabled)
> +		prot = PAGE_KERNEL_ROX;
> +#endif
>  	phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
>  
>  	/* The trampoline is always mapped and can therefore be global */
> @@ -672,7 +678,11 @@ static void __init map_kernel(pgd_t *pgdp)
>  	 * mapping to install SW breakpoints. Allow this (only) when
>  	 * explicitly requested with rodata=off.
>  	 */
> -	pgprot_t text_prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
> +	pgprot_t text_prot = PAGE_KERNEL_EXEC;
> +#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
> +	if (rodata_enabled)
> +		text_prot = PAGE_KERNEL_ROX;
> +#endif
>  
>  	/*
>  	 * If we have a CPU that supports BTI and a kernel built for
> 
