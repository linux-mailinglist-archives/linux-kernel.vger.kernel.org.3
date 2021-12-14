Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7994474AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbhLNSST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:18:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43318 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231978AbhLNSSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:18:17 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 677D61EC018B;
        Tue, 14 Dec 2021 19:18:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639505892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KQOeM0BVMkTTqkj9QupJIyjDYdV6VnlGg5t0GAYnm24=;
        b=YlxtIVvkrAbezDi3JUUrVILyyqx6zx6FJ8hHwBNBChzXd68vuI4vDsEfvB6ljEj/Qt67kw
        wuJPOCBkoOkS9VBhGRy2SRqziEFxabUVBQjo8uJwcOuF/zZnrqXVkXVeBu5DMDjAyZnsll
        55NJhAscvRqZ0ZEXSN4bhM3QhRWhYg4=
Date:   Tue, 14 Dec 2021 19:18:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/26] x86/tdx: Detect running as a TDX guest in early
 boot
Message-ID: <Ybjf5g66cFHpUKMH@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214150304.62613-2-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:02:39PM +0300, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> cc_platform_has() API is used in the kernel to enable confidential
> computing features. Since TDX guest is a confidential computing
> platform, it also needs to use this API.
> 
> In preparation of extending cc_platform_has() API to support TDX guest,
> use CPUID instruction to detect for TDX guests support in the early

" ... to detect support for TDX guests... "

> boot code (via tdx_early_init()). Since copy_bootdata() is the first
> user of cc_platform_has() API, detect the TDX guest status before it.

...

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 793e9b42ace0..a61ac6f8821a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -872,6 +872,19 @@ config ACRN_GUEST
>  	  IOT with small footprint and real-time features. More details can be
>  	  found in https://projectacrn.org/.
>  
> +# TDX guest uses X2APIC for interrupt management.

For whom is that comment and who's going to see it? Is that comment
supposed to explain the "depends on X86_X2APIC" below?

> +config INTEL_TDX_GUEST
> +	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
> +	depends on X86_64 && CPU_SUP_INTEL
> +	depends on X86_X2APIC
> +	help
> +	  Support running as a guest under Intel TDX.  Without this support,
> +	  the guest kernel can not boot or run under TDX.
> +	  TDX includes memory encryption and integrity capabilities
> +	  which protect the confidentiality and integrity of guest
> +	  memory contents and CPU state. TDX guests are protected from
> +	  potential attacks from the VMM.
> +

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
