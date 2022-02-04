Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47AF4A99CF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353689AbiBDNSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:18:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:18124 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237118AbiBDNSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643980698; x=1675516698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xgVIOdG2yhzTFMloQew7TW9ttMwJ/W3Ha0wtHJKNnd8=;
  b=RTEh6R2qIMLRxpty9pekFnHYBKjddCfC/dJzUg0dVjXL2/0t3WK7FQ3i
   6YGm/07rsOHXGi9WlfyC83KVt1aTsEEUWSTcxIDSF00EaGw8ymxMfLMbF
   z7+Kw9psehWNXsAoyt8BmJh95sxxtLqCDlYZAFdpLD0s6X0Cud+FyJbj3
   GUZs44oVmVxh2IS/EWhCnUKDypQr5KtL+IYWZgO1PdagVh7bZYE4KwDML
   805UcKEvB7Fi6FRDIeE9o4tHYlOkLCXRk8RhtbziZjuJB0CKab9b89VA4
   FlL2tp3sjdMeOgWN7P2m6yoJjvzICd8VWn9dlUvwMeVeMZnOpDj/8yY8x
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="334760224"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="334760224"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 05:18:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="769955071"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 04 Feb 2022 05:18:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9CD044BC; Fri,  4 Feb 2022 15:18:26 +0200 (EET)
Date:   Fri, 4 Feb 2022 16:18:26 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 03/29] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <20220204131826.x57bgwn46kvkm2yw@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-4-kirill.shutemov@linux.intel.com>
 <87a6faz7cs.ffs@tglx>
 <20220202025519.csymm7r23b3ltpia@black.fi.intel.com>
 <20220202235910.c512857813ea5b14aa73267f@intel.com>
 <20220203144403.ytyw5vcv4gshxyhn@black.fi.intel.com>
 <20220204034312.43rotpihciik2gk6@black.fi.intel.com>
 <20220204231239.bff3626ec6c3c630371cbd4d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204231239.bff3626ec6c3c630371cbd4d@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 11:12:39PM +1300, Kai Huang wrote:
> 
> > --- a/arch/x86/include/asm/tdx.h
> > +++ b/arch/x86/include/asm/tdx.h
> > @@ -8,6 +8,25 @@
> >  #define TDX_CPUID_LEAF_ID	0x21
> >  #define TDX_IDENT		"IntelTDX    "
> 
> Seems above two are not required by assembly file?  If so also move them to
> within #ifndef __ASSEMBLY__?

Why? It is harmless.

> >  
> > +#define TDX_SEAMCALL_VMFAILINVALID     0x8000FF00FFFF0000ULL
> > +
> > +#ifndef __ASSEMBLY__
> > +
> > +/*
> > + * Used to gather the output registers values of the TDCALL and SEAMCALL
> > + * instructions when requesting services from the TDX module.
> > + *
> > + * This is a software only structure and not part of the TDX module/VMM ABI.
> > + */
> > +struct tdx_module_output {
> > +	u64 rcx;
> > +	u64 rdx;
> > +	u64 r8;
> > +	u64 r9;
> > +	u64 r10;
> > +	u64 r11;
> > +};
> > +
> 
> Is declaration of __tdx_module_call() outside of CONFIG_INTEL_TDX_GUEST?

No, it is defined within CONFIG_INTEL_TDX_GUEST. Why? Host side has to
build their helper anyway.

> >  #ifdef CONFIG_INTEL_TDX_GUEST
> >  
> >  void __init tdx_early_init(void);
> > @@ -18,4 +37,5 @@ static inline void tdx_early_init(void) { };
> >  
> >  #endif /* CONFIG_INTEL_TDX_GUEST */
> >  
> > +#endif /* !__ASSEMBLY__ */
> >  #endif /* _ASM_X86_TDX_H */

-- 
 Kirill A. Shutemov
