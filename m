Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947934A99D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354352AbiBDNUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:20:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:26589 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349762AbiBDNUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643980816; x=1675516816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3lAPxAkmOv3RjR0JSI6de3JMHiVAAKEQq/os+GZL1N4=;
  b=g2zMfbsWvxYfpFMLIuUUAFfttF0x5lHNUDFNu5+o9CHAFRc3WTULUd+R
   uvi8drhwiDJpYlAInW9CjyBjk9MwJeKjt8f4ukoVb6dMQlK4fuMW4m+ee
   3ENyB+aGJkNpN9NJ1X32lSjsTwuoez92zB+WJdrlPVjJ2XHqUknMqPLWG
   8Llr9E50peBIz0vF/Rj9z5yFatuNrYv2T7cXZE8SIy4bLEUW729LSIaVH
   kAbXQx94O+hekMw9TwpbCnVtrQpNv1o1akU76RQ/E//fVtw/1MU+WhJGT
   2XDtR7PAHKdD8T6tsAthmo+AaliZdw6xljGa61q+f55T/HRMZ8RBsHpRH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="272866483"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="272866483"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 05:20:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="480838436"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 04 Feb 2022 05:20:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 17E144BC; Fri,  4 Feb 2022 15:20:24 +0200 (EET)
Date:   Fri, 4 Feb 2022 16:20:23 +0300
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
Message-ID: <20220204132023.myyom57i7p5hcq6o@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-4-kirill.shutemov@linux.intel.com>
 <87a6faz7cs.ffs@tglx>
 <20220202025519.csymm7r23b3ltpia@black.fi.intel.com>
 <20220202235910.c512857813ea5b14aa73267f@intel.com>
 <20220203144403.ytyw5vcv4gshxyhn@black.fi.intel.com>
 <20220204034312.43rotpihciik2gk6@black.fi.intel.com>
 <20220204225138.e76f6e98e0208d746606099d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204225138.e76f6e98e0208d746606099d@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 10:51:38PM +1300, Kai Huang wrote:
> > +	.if \host
> > +	seamcall
> > +	/*
> > +	 * SEAMCALL instruction is essentially a VMExit from VMX root
> > +	 * mode to SEAM VMX root mode.  VMfailInvalid (CF=1) indicates
> > +	 * that the targeted SEAM firmware is not loaded or disabled,
> > +	 * or P-SEAMLDR is busy with another SEAMCALL.  %rax is not
> > +	 * changed in this case.
> > +	 *
> > +	 * Set %rax to TDX_SEAMCALL_VMFAILINVALID for VMfailInvalid.
> > +	 * This value will never be used as actual SEAMCALL error code.
> > +	 */
> > +	jnc     .Lno_vmfailinvalid
> > +	mov     $TDX_SEAMCALL_VMFAILINVALID, %rax
> > +	jmp     .Lno_output_struct
> 
> If I read correctly, in case of VMfailInvalid, another "pop %r12" is needed
> before jmp to .Lno_output_struct, otherwise it doesn't match the stack (pushed
> twice).

Oopsie. Thanks for catching it.

> However, since "test %rax, %rax" will also catch TDX_SEAMCALL_VMFAILINVALID, it
> seems we can just delete above "jmp .Lno_output_struct"?

Good point. Will do it this way.

-- 
 Kirill A. Shutemov
