Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1D485300
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiAEMsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:48:39 -0500
Received: from foss.arm.com ([217.140.110.172]:44346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbiAEMsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:48:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE27A2B;
        Wed,  5 Jan 2022 04:48:35 -0800 (PST)
Received: from [10.163.72.138] (unknown [10.163.72.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1ABD03F5A1;
        Wed,  5 Jan 2022 04:48:33 -0800 (PST)
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8mltQQVRDSF0gYXJtNjQ6IGZpeCBidWlsZCBlcnJv?=
 =?UTF-8?Q?r_when_use_rodata=5fenabled?=
To:     AliOS system security <alios_sys_security@linux.alibaba.com>,
        "catalin.marinas" <catalin.marinas@arm.com>, will <will@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1641352075-25200-1-git-send-email-alios_sys_security@linux.alibaba.com>
 <0432f592-789b-7c92-8d7a-99191d7bc669@arm.com>
 <6f37012b-b082-457f-9aee-2315a461c031.alios_sys_security@linux.alibaba.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0380f75f-ac8f-5f0f-93e7-20ed07a0d549@arm.com>
Date:   Wed, 5 Jan 2022 18:18:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6f37012b-b082-457f-9aee-2315a461c031.alios_sys_security@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/22 6:07 PM, AliOS system security wrote:
> Hello,
> When I commen out these configs like below to disable rodata function for debug purpose

Then it's a modified custom kernel, not mainline anymore.

> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3bb0b67..40fbd85 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -36,8 +36,8 @@ config ARM64
>         select ARCH_HAS_SET_DIRECT_MAP
>         select ARCH_HAS_SET_MEMORY
>         select ARCH_STACKWALK
> -       select ARCH_HAS_STRICT_KERNEL_RWX
> -       select ARCH_HAS_STRICT_MODULE_RWX
> +#      select ARCH_HAS_STRICT_KERNEL_RWX
> +#      select ARCH_HAS_STRICT_MODULE_RWX
>         select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> 
> then build failed with below log:
> arch/arm64/mm/mmu.c: In function ‘parse_rodata’:
> arch/arm64/mm/mmu.c:601:28: error: ‘rodata_enabled’ undeclared (first use in this function); did you mean ‘kasan_enabled’?
>   int ret = strtobool(arg, &rodata_enabled);
>                             ^~~~~~~~~~~~~~
>                             kasan_enabled
> arch/arm64/mm/mmu.c:601:28: note: each undeclared identifier is reported only once for each function it appears in
>   CC      net/core/skbuff.o
> arch/arm64/mm/mmu.c: In function ‘map_entry_trampoline’:
> arch/arm64/mm/mmu.c:620:18: error: ‘rodata_enabled’ undeclared (first use in this function); did you mean ‘kasan_enabled’?
>   pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;

These build errors are caused on a modified kernel, not mainline.

> 
> I hope these configs can be used at least for function test.
> And wrap around variable when it is defined within macro should be better. 

If the config options are not user selectable (which is the case here), they
should not be used for testing. Because there might be already assumptions in
the kernel, around its availability.

> 
> Thanks!
> 
>     ------------------------------------------------------------------
>     发件人：Anshuman Khandual <anshuman.khandual@arm.com>
>     发送时间：2022年1月5日(星期三) 17:21
>     收件人：AliOS system security <alios_sys_security@linux.alibaba.com>; catalin.marinas <catalin.marinas@arm.com>; will <will@kernel.org>
>     抄　送：linux-arm-kernel <linux-arm-kernel@lists.infradead.org>; linux-kernel <linux-kernel@vger.kernel.org>
>     主　题：Re: [PATCH] arm64: fix build error when use rodata_enabled
> 
>     Hello,
> 
>     On 1/5/22 8:37 AM, AliOS system security wrote:
>     > rodata_enabled should be used when CONFIG_STRICT_KERNEL_RWX
>     > or CONFIG_STRICT_MODULE_RWX is selected
> 
>     Both these configs get selected invariably with CONFIG_ARM64 in the
>     platform config file (arch/arm64/Kconfig). I guess there can not be
>     any such situation, where both configs will be missing/not selected
>     given ARCH_OPTIONAL_KERNEL_RWX[or _DEFAULT] is not enabled on arm64.
> 
>     config ARM64
>             def_bool y
>             select ACPI_CCA_REQUIRED if ACPI
>      .....
>             select ARCH_HAS_STRICT_KERNEL_RWX
>             select ARCH_HAS_STRICT_MODULE_RWX
>      .....
> 
>     Hence for all practical purpose, rodata_enabled could be considered
>     always available. I am sure there other similar situations as well,
>     where code elements are not wrapped around if the config option is
>     always present.
> 
>     > 
>     > Signed-off-by: AliOS system security <alios_sys_security@linux.alibaba.com>
> 
>     Also please refer Documentation/process/submitting-patches.rst for
>     the rules regarding names, that can be used for a commit sign off.
> 
>     ------------------------------------------------------------------------
>     then you just add a line saying::
> 
>             Signed-off-by: Random J Developer <random@developer.example.org>
> 
>     using your real name (sorry, no pseudonyms or anonymous contributions.)
>     ------------------------------------------------------------------------
> 
>     - Anshuman
> 
>     > ---
>     >  arch/arm64/mm/mmu.c | 14 ++++++++++++--
>     >  1 file changed, 12 insertions(+), 2 deletions(-)
>     > 
>     > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>     > index acfae9b..47f8754 100644
>     > --- a/arch/arm64/mm/mmu.c
>     > +++ b/arch/arm64/mm/mmu.c
>     > @@ -596,6 +596,7 @@ static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
>     >   vm_area_add_early(vma);
>     >  }
>     >  
>     > +#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
>     >  static int __init parse_rodata(char *arg)
>     >  {
>     >   int ret = strtobool(arg, &rodata_enabled);
>     > @@ -613,11 +614,16 @@ static int __init parse_rodata(char *arg)
>     >   return 0;
>     >  }
>     >  early_param("rodata", parse_rodata);
>     > +#endif
>     >  
>     >  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>     >  static int __init map_entry_trampoline(void)
>     >  {
>     > - pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>     > + pgprot_t prot = PAGE_KERNEL_EXEC;
>     > +#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
>     > + if (rodata_enabled)
>     > +  prot = PAGE_KERNEL_ROX;
>     > +#endif
>     >   phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
>     >  
>     >   /* The trampoline is always mapped and can therefore be global */
>     > @@ -672,7 +678,11 @@ static void __init map_kernel(pgd_t *pgdp)
>     >    * mapping to install SW breakpoints. Allow this (only) when
>     >    * explicitly requested with rodata=off.
>     >    */
>     > - pgprot_t text_prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>     > + pgprot_t text_prot = PAGE_KERNEL_EXEC;
>     > +#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
>     > + if (rodata_enabled)
>     > +  text_prot = PAGE_KERNEL_ROX;
>     > +#endif
>     >  
>     >   /*
>     >    * If we have a CPU that supports BTI and a kernel built for
>     > 
> 
> 
