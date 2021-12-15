Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F402476698
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhLOXhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:37:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:14842 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232096AbhLOXhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:37:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="236899600"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="236899600"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 15:37:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="518990378"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 15 Dec 2021 15:36:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C783DD4; Thu, 16 Dec 2021 01:37:06 +0200 (EET)
Date:   Thu, 16 Dec 2021 02:37:06 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/26] x86/tdx: Handle in-kernel MMIO
Message-ID: <20211215233706.6zjqfvpbcx3omszp@black.fi.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-9-kirill.shutemov@linux.intel.com>
 <20211215233116.d2opfoei42viqdty@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215233116.d2opfoei42viqdty@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 03:31:16PM -0800, Josh Poimboeuf wrote:
> On Tue, Dec 14, 2021 at 06:02:46PM +0300, Kirill A. Shutemov wrote:
> > @@ -155,6 +157,108 @@ static bool tdx_handle_cpuid(struct pt_regs *regs)
> >  	return true;
> >  }
> >  
> > +static bool tdx_mmio(int size, bool write, unsigned long addr,
> > +		     unsigned long *val)
> > +{
> > +	struct tdx_hypercall_output out;
> > +	u64 err;
> > +
> > +	err = _tdx_hypercall(EXIT_REASON_EPT_VIOLATION, size, write,
> > +			     addr, *val, &out);
> > +	if (err)
> > +		return true;
> > +
> > +	*val = out.r11;
> > +	return false;
> > +}
> > +
> > +static bool tdx_mmio_read(int size, unsigned long addr, unsigned long *val)
> > +{
> > +	return tdx_mmio(size, false, addr, val);
> > +}
> > +
> > +static bool tdx_mmio_write(int size, unsigned long addr, unsigned long *val)
> > +{
> > +	return tdx_mmio(size, true, addr, val);
> > +}
> 
> These bool functions return false on success.  Conversely, other
> functions in this file return true on success.  That inconsistency is
> really confusing for the callers and is bound to introduce bugs
> eventually.
> 
> > +static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> 
> Similarly, tdx_handle_mmio() returns (int) 0 for success, while other
> tdx_handle_*() functions return (bool) true for success.  Also
> confusing.
> 
> The most robust option would be for all the functions to follow the
> typical kernel convention of returning (int) 0 on success.  It works for
> 99.99% of the kernel.  Why mess with success? (pun intended)
> 
> Otherwise it's just pointless added cognitive overhead, trying to keep
> track of what success means, for each individual function.

Okay, fair enough. I will make them consistent.

-- 
 Kirill A. Shutemov
