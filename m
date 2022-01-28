Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7999B4A042D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbiA1XSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:18:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:51008 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239722AbiA1XSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643411914; x=1674947914;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=r2T2n+ss+flnTA1SZnYKPHHw9dTVF1ihmv+a8CZs1vw=;
  b=Cx8LzqfhDjkHGN/d3ZjNsyrYFi9ySlcfAW65k63352ntEqGKfHq+zdCl
   m9D3oizVHp869fE81L/okMxWqLo0gZu3NVFj/aEyy9+LrFbMz2Vpz198x
   uyl+FpaYdmAj2WjZUjdL7EkuOFSraJrwovJ8icNE0GWltTapeZ84URG0V
   6CcJtuYaRpV4BBqkMPyFNqXsQWpffW5ONPYhsB0mHyJy8MpSkPQYjPS9D
   jU4jQgAsseM4v6xYtFfcs7bOThQ+Kvn+JM3xb1EA3itcu5ntp90uHG3h1
   4GL6NCE7K+/R5wjndir5W3TMH73P98EMKRKZGWk/5kqMSiINByRh6ZkMT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227192036"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="227192036"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:18:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697247335"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:18:33 -0800
Message-ID: <f9db9626-de92-65a4-57f1-cf94511dd137@intel.com>
Date:   Fri, 28 Jan 2022 15:18:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Content-Language: en-US
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-10-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 09/44] x86/pkeys: Enable PKS on cpus which support it
In-Reply-To: <20220127175505.851391-10-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
> Protection Keys for Supervisor pages (PKS) enables fast, hardware thread
> specific, manipulation of permission restrictions on supervisor page
> mappings.  It uses the same mechanism of Protection Keys as those on
> User mappings but applies that mechanism to supervisor mappings using a
> supervisor specific MSR.
> 
> Bit 24 of CR4 is used to enable the feature by software.  Define
> pks_setup() to be called when PKS is configured.

Again, no need to specify the bit numbers.  We have it in the code. :)
At most, just say something like:

	PKS is enabled by a new bit in a control register.
or
	PKS is enabled by a new bit in CR4.

> Initially, pks_setup() initializes the per-cpu MSR with 0 to enable all
> access on all pkeys.

Why not just make it restrictive to start out?  That's what we do for PKU.

> asm/pks.h is added as a new file to store new
> internal functions and structures such as pks_setup().

One writing nit: try to speak in active voice.

Passive: "Foo is added"
Active: "Add foo"

It actually makes thing shorter and easier to read:

	Add asm/pks.h to store new internal functions and structures
	such as pks_setup().

> diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
> index bcba3c643e63..191c574b2390 100644
> --- a/arch/x86/include/uapi/asm/processor-flags.h
> +++ b/arch/x86/include/uapi/asm/processor-flags.h
> @@ -130,6 +130,8 @@
>  #define X86_CR4_SMAP		_BITUL(X86_CR4_SMAP_BIT)
>  #define X86_CR4_PKE_BIT		22 /* enable Protection Keys support */
>  #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
> +#define X86_CR4_PKS_BIT		24 /* enable Protection Keys for Supervisor */
> +#define X86_CR4_PKS		_BITUL(X86_CR4_PKS_BIT)
>  
>  /*
>   * x86-64 Task Priority Register, CR8
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 7b8382c11788..83c1abce7d93 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -59,6 +59,7 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/uv/uv.h>
>  #include <asm/sigframe.h>
> +#include <asm/pks.h>
>  
>  #include "cpu.h"
>  
> @@ -1632,6 +1633,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  
>  	x86_init_rdrand(c);
>  	setup_pku(c);
> +	pks_setup();
>  
>  	/*
>  	 * Clear/Set all flags overridden by options, need do it
> diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> index cf12d8bf122b..02629219e683 100644
> --- a/arch/x86/mm/pkeys.c
> +++ b/arch/x86/mm/pkeys.c
> @@ -206,3 +206,19 @@ u32 pkey_update_pkval(u32 pkval, int pkey, u32 accessbits)
>  	pkval &= ~(PKEY_ACCESS_MASK << shift);
>  	return pkval | accessbits << shift;
>  }
> +
> +#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
> +
> +/*
> + * PKS is independent of PKU and either or both may be supported on a CPU.
> + */
> +void pks_setup(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> +		return;
> +
> +	wrmsrl(MSR_IA32_PKRS, 0);

This probably needs a one-line comment about what it's doing.  As a
general rule, I'd much rather have a one-sentence note in a code comment
than in the changelog.

> +	cr4_set_bits(X86_CR4_PKS);
> +}
> +
> +#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */

