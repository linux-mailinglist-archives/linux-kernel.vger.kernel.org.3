Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2F04A9782
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358198AbiBDKMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:12:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:43600 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbiBDKMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643969567; x=1675505567;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+9tOzU4GtOJXdJBZ54JUx7i36wRIZTfPtzp2LAmLDmA=;
  b=YqITRRKoycMrfTivnwc2Kpdx4f/nVQG+8mPIjiHJSqNMlcvpFStENJE8
   Oqqsqe4mKbhtEJeP+hIpmCijv2Y3FetJUZQtLuBtovF9eT4jmjDMkf9wQ
   fezAlX7waVXL/z16nQtnhOF9gDLxBlTwlf6igijcislxv74hc/I3pcVrj
   +aFTvJoqd6//D820RsLdAnvjK6+zVez5zgE9Z9CfrmGAUZqNE5D6sNQ+S
   O7Oca5GktYwoQ2YSR1DCDtMyJEGlA0BdQA9abn2IHHQMbh8+mtDOPChOy
   ImxY2lVAlgkVig2tfP0S8JPmBBxrvolWSfS0PllvZrNq3z0sVRNA+m3Rz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="334738678"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="334738678"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 02:12:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="539118357"
Received: from rkothand-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.255.86.47])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 02:12:41 -0800
Date:   Fri, 4 Feb 2022 23:12:39 +1300
From:   Kai Huang <kai.huang@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <aarcange@redhat.com>, <ak@linux.intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <hpa@zytor.com>,
        <jgross@suse.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <jpoimboe@redhat.com>, <knsathya@kernel.org>,
        <pbonzini@redhat.com>, <sdeep@vmware.com>, <seanjc@google.com>,
        <tony.luck@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 03/29] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-Id: <20220204231239.bff3626ec6c3c630371cbd4d@intel.com>
In-Reply-To: <20220204034312.43rotpihciik2gk6@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
        <20220124150215.36893-4-kirill.shutemov@linux.intel.com>
        <87a6faz7cs.ffs@tglx>
        <20220202025519.csymm7r23b3ltpia@black.fi.intel.com>
        <20220202235910.c512857813ea5b14aa73267f@intel.com>
        <20220203144403.ytyw5vcv4gshxyhn@black.fi.intel.com>
        <20220204034312.43rotpihciik2gk6@black.fi.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -8,6 +8,25 @@
>  #define TDX_CPUID_LEAF_ID	0x21
>  #define TDX_IDENT		"IntelTDX    "

Seems above two are not required by assembly file?  If so also move them to
within #ifndef __ASSEMBLY__?

>  
> +#define TDX_SEAMCALL_VMFAILINVALID     0x8000FF00FFFF0000ULL
> +
> +#ifndef __ASSEMBLY__
> +
> +/*
> + * Used to gather the output registers values of the TDCALL and SEAMCALL
> + * instructions when requesting services from the TDX module.
> + *
> + * This is a software only structure and not part of the TDX module/VMM ABI.
> + */
> +struct tdx_module_output {
> +	u64 rcx;
> +	u64 rdx;
> +	u64 r8;
> +	u64 r9;
> +	u64 r10;
> +	u64 r11;
> +};
> +

Is declaration of __tdx_module_call() outside of CONFIG_INTEL_TDX_GUEST?

>  #ifdef CONFIG_INTEL_TDX_GUEST
>  
>  void __init tdx_early_init(void);
> @@ -18,4 +37,5 @@ static inline void tdx_early_init(void) { };
>  
>  #endif /* CONFIG_INTEL_TDX_GUEST */
>  
> +#endif /* !__ASSEMBLY__ */
>  #endif /* _ASM_X86_TDX_H */
