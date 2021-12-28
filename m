Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2A6480DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 00:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbhL1XbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 18:31:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:21765 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237777AbhL1XbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 18:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640734270; x=1672270270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W/XHj1/yTb5bECva73PtlVnMz2BBfVHtE2WPJySx3W0=;
  b=DGfjFI4wYiNVugPkthIh9D5Qf7pp6wafnGgNoRqFHLYfva+5FIvLhWNC
   JynUzcYCouq18ftGNLFKEPCBY3EB4shJY0QoNlKfhYGC+w325mQm/MPjT
   QPinxaxRTquf8Q0ZckjF/98CIys+OrqPIHMe8YUXOtNbBz+W8ClWmApJp
   tAv4Syo4flq1gHEQrG2Ui0bZm0kT26WJWQha4kK1aKm1LW8T9xrMTj06E
   nu38rNha3oVgXB/HW4P9mkFWvAKAhQI9b+PCjdOSqzfa0BHXSEOFW7QTF
   c8+RocVg324Q7Yn4VV7wCfQoPOwghtNBdEkZRSfxNBUpJtwXCx7FhUAuj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="228264597"
X-IronPort-AV: E=Sophos;i="5.88,243,1635231600"; 
   d="scan'208";a="228264597"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 15:31:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,243,1635231600"; 
   d="scan'208";a="615772676"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 28 Dec 2021 15:31:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D20A4120; Wed, 29 Dec 2021 01:31:12 +0200 (EET)
Date:   Wed, 29 Dec 2021 02:31:12 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 04/26] x86/traps: Add #VE support for TDX guest
Message-ID: <20211228233112.cpycmdv55edxhvbv@black.fi.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-5-kirill.shutemov@linux.intel.com>
 <YcTR5HnkHi7CjVyx@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcTR5HnkHi7CjVyx@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 08:45:40PM +0100, Borislav Petkov wrote:
> What happens if the NMI handler triggers a #VE after all? Or where is it
> enforced that TDX guests should set panic_on_oops?

Kernel will handle the #VE normally inside NMI handler. (We tested it once
again, just in case.)

The critical part is that #VE must not be triggered in NMI entry code,
before kernel is ready to handle nested NMIs. 

#VE cannot possibly happen there: no #VE-inducing instructions, code and
data are in guest private memory.

VMM can remove private memory from under us, but access to unaccepted (or
missing) private memory leads to VM termination, not to #VE.

The situation is similar to NMIs vs. breakpoints.

> > + * be handled.
> > + *
> > + * For dis-allowed or invalid #VE just return failure.
> > + *
> > + * Return True on success and False on failure.
> 
> You lost me here - function returns false unconditionally. And that
> bla about CPUID from user being a valid case doesn't really look like
> one when I look at the code. Especially since ve_raise_fault() sends a
> SIGSEGV for user #VEs.

tdx_virt_exception_user()/tdx_virt_exception_kernel() will be populated by
following patches. The patch adds generic infrastructure for #VE handling.

-- 
 Kirill A. Shutemov
