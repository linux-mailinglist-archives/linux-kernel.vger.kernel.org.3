Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F6B48515E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiAEKrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:47:49 -0500
Received: from foss.arm.com ([217.140.110.172]:43224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235139AbiAEKrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:47:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 241401042;
        Wed,  5 Jan 2022 02:47:47 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.10.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF87B3F5A1;
        Wed,  5 Jan 2022 02:47:45 -0800 (PST)
Date:   Wed, 5 Jan 2022 10:47:35 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     AliOS system security <alios_sys_security@linux.alibaba.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: fix build error when use rodata_enabled
Message-ID: <YdV3RzQcGb2xFPhS@FVFF77S0Q05N>
References: <1641352075-25200-1-git-send-email-alios_sys_security@linux.alibaba.com>
 <0432f592-789b-7c92-8d7a-99191d7bc669@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0432f592-789b-7c92-8d7a-99191d7bc669@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 02:51:05PM +0530, Anshuman Khandual wrote:
> Hello,
> 
> On 1/5/22 8:37 AM, AliOS system security wrote:
> > rodata_enabled should be used when CONFIG_STRICT_KERNEL_RWX
> > or CONFIG_STRICT_MODULE_RWX is selected

Further to Anshuman's comments here, for a build issue, please include the
specific build error in the commit log, and describe the configuration where
this manifests.

For the reasons Anshuman gives below I do not see how this can be a problem in
mainline.

Thanks,
Mark.

> Both these configs get selected invariably with CONFIG_ARM64 in the
> platform config file (arch/arm64/Kconfig). I guess there can not be
> any such situation, where both configs will be missing/not selected
> given ARCH_OPTIONAL_KERNEL_RWX[or _DEFAULT] is not enabled on arm64.
> 
> config ARM64
>         def_bool y
>         select ACPI_CCA_REQUIRED if ACPI
> 	.....
>         select ARCH_HAS_STRICT_KERNEL_RWX
>         select ARCH_HAS_STRICT_MODULE_RWX
> 	.....
> 
> Hence for all practical purpose, rodata_enabled could be considered
> always available. I am sure there other similar situations as well,
> where code elements are not wrapped around if the config option is
> always present.
> 
> > 
> > Signed-off-by: AliOS system security <alios_sys_security@linux.alibaba.com>
> 
> Also please refer Documentation/process/submitting-patches.rst for
> the rules regarding names, that can be used for a commit sign off.
> 
> ------------------------------------------------------------------------
> then you just add a line saying::
> 
>         Signed-off-by: Random J Developer <random@developer.example.org>
> 
> using your real name (sorry, no pseudonyms or anonymous contributions.)
> ------------------------------------------------------------------------
> 
> - Anshuman
> 
> > ---
> >  arch/arm64/mm/mmu.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index acfae9b..47f8754 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -596,6 +596,7 @@ static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
> >  	vm_area_add_early(vma);
> >  }
> >  
> > +#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
> >  static int __init parse_rodata(char *arg)
> >  {
> >  	int ret = strtobool(arg, &rodata_enabled);
> > @@ -613,11 +614,16 @@ static int __init parse_rodata(char *arg)
> >  	return 0;
> >  }
> >  early_param("rodata", parse_rodata);
> > +#endif
> >  
> >  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> >  static int __init map_entry_trampoline(void)
> >  {
> > -	pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
> > +	pgprot_t prot = PAGE_KERNEL_EXEC;
> > +#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
> > +	if (rodata_enabled)
> > +		prot = PAGE_KERNEL_ROX;
> > +#endif
> >  	phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
> >  
> >  	/* The trampoline is always mapped and can therefore be global */
> > @@ -672,7 +678,11 @@ static void __init map_kernel(pgd_t *pgdp)
> >  	 * mapping to install SW breakpoints. Allow this (only) when
> >  	 * explicitly requested with rodata=off.
> >  	 */
> > -	pgprot_t text_prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
> > +	pgprot_t text_prot = PAGE_KERNEL_EXEC;
> > +#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
> > +	if (rodata_enabled)
> > +		text_prot = PAGE_KERNEL_ROX;
> > +#endif
> >  
> >  	/*
> >  	 * If we have a CPU that supports BTI and a kernel built for
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
