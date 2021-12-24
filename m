Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E617C47EE46
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 11:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352452AbhLXKeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 05:34:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:42918 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343932AbhLXKeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 05:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640342060; x=1671878060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fP3b2t2Pjntt0Wdr6XjS+C58Cbsr3y9eDyRba8+g9ik=;
  b=W+8daErbtT873oDbEuRdIPbTnrSAgSZobzVdKS3XDRVip1IhX5L2e0UF
   tQWK6pmKDysrnwm9EeDHsilRoSXToPqxZRJe1qi24eU0AUzNvYzLnQeJG
   3b14czCRk+J2R4o47KIw1VjdhPYw6+kDOpfVYqDb+5PNf7f61Cd//O8Kv
   ODxEu6Yt/R4eE6Lfyl83/dssPsnbHjT7+41w+lQ1I1+nCIKs3KCLU8rkT
   BoKodgxvPuhdlo4wFCORk+N7RpRckQvbGmYs1Hzju1UnHtVJiwo88iz52
   ntczzZF5MGQTq5j8L2kffZP/qvq6jUTujbIlB/cOIqifoRaRSA6umJFe0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="239749131"
X-IronPort-AV: E=Sophos;i="5.88,232,1635231600"; 
   d="scan'208";a="239749131"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 02:34:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,232,1635231600"; 
   d="scan'208";a="468812954"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 24 Dec 2021 02:34:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 19F3F11E; Fri, 24 Dec 2021 12:34:11 +0200 (EET)
Date:   Fri, 24 Dec 2021 13:34:10 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/26] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <20211224103410.okuku7njt2cnk6mz@black.fi.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-4-kirill.shutemov@linux.intel.com>
 <YcIm8fngUsVulUoI@zn.tnic>
 <20211223165548.xr57h25g4diixivp@black.fi.intel.com>
 <f67229d5-c92e-5953-5f77-1dee2c7643b3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f67229d5-c92e-5953-5f77-1dee2c7643b3@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 10:16:16AM +0100, Paolo Bonzini wrote:
> On 12/23/21 17:55, Kirill A. Shutemov wrote:
> > 	In a TDX based VM, since the VMM is an untrusted entity, an intermediary
> > 	layer -- TDX module -- facilitates secure communication between the host
> > 	and the guest. TDX module is loaded like a firmware into a special CPU
> > 	mode called SEAM. TDX guests communicate with the TDX module using the
> > 	TDCALL instruction.
> > 
> > Does it look fine?
> 
> Looks good but I wouldn't say "like a firmware".  The TDX module is the
> "real" hypervisor, it's not firmware.

We are talking about the way it gets loaded, not about its functionality.
> 
> Paolo
> 

-- 
 Kirill A. Shutemov
