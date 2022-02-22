Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089234C02D7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiBVUIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiBVUIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:08:31 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D02F4629
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:08:04 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 049B41EC053C;
        Tue, 22 Feb 2022 21:07:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645560479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x9SgovmG8b0LJ5OXt5gAodu8VwpoC+S25KIyfpr4uZ8=;
        b=mR5x0zpEPUftfOFLRiwtx3DFy7GfYGFOx7t7+RiOJN+0NcYzZDzDLTodTfmVdzqM2m5zF+
        p/NjE4MByvvM2qHbSHC4wID+NgUWjELAo6H4UkYndHCPHmyzd0rA77AP9IYczGtBP4Co4o
        VOvORaZYbPqeysohkNtQy6mO9d6sKM4=
Date:   Tue, 22 Feb 2022 21:08:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jmattson@google.com, seanjc@google.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCH 1/4] x86/hyperv: Add missing ARCH_HAS_CC_PLATFORM
 dependency
Message-ID: <YhVCoveTwsDZXE5G@zn.tnic>
References: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
 <20220222185740.26228-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220222185740.26228-2-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 09:57:37PM +0300, Kirill A. Shutemov wrote:
> On x86, cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) supposes to return
> true for HyperV if isolation is supported. But it only does it if the
> kernel is compiled with AMD_MEM_ENCRYPT enabled.
> 
> It happens due to missed ARCH_HAS_CC_PLATFORM dependency. Without
> ARCH_HAS_CC_PLATFORM enabled, cc_platform_has() always returns false.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/hv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 0747a8f1fcee..424d3f0751dc 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -8,6 +8,7 @@ config HYPERV
>  		|| (ARM64 && !CPU_BIG_ENDIAN))
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR if X86
> +	select ARCH_HAS_CC_PLATFORM if x86
>  	select VMAP_PFN
>  	help
>  	  Select this option to run Linux as a Hyper-V client operating
> -- 

Good catch.

I'm guessing this needs

Fixes: c789b90a6904 ("x86/hyper-v: Add hyperv Isolation VM check in the cc_platform_has()")

which added hyperv_cc_platform_has() and which needs to go to Linus now,
as an urgent fix for 5.17 as that patch came into 5.17-rc1.

Wei?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
