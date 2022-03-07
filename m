Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBE04D0B29
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiCGWel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343770AbiCGWeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:34:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D83C4F458
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 14:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646692422; x=1678228422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wA16yBwlwF+DWTbp4910PgdT1LOf5Q0v33N301bxq8A=;
  b=ME77HN0iP5fPfXjp6f0r6uQ7F4fG/GEmCXNUiljYOdAyt6AaGzqUuHSv
   5De64iUbOb5kjzBi7iVeifgYN7A2P/FRBv6RWxOHBx3gvJhot1crzWrO/
   rLVGAgBLM2EkdiSdhwj3ygpoukL/0Kos/eU5u8fufA0cKxhgLPLMUcYHy
   KEDMWtvUkntYmMK6zPjLx82Ywyb1uaI4XMFusVOz6IXdVkX76jSFeIgb+
   avSLrw+AWO6x2CQt6nZ+kJGrP+0MpqIJuKqDmzCHLhN1aw/aDolIjD2w/
   Gnyc2hAW9KrXNp0GCu9A4VHIgpyUYkOJlapkvZsR4ym7RyFyXTrtD4whl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254253007"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="254253007"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 14:33:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="687704236"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2022 14:33:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 682041D6; Tue,  8 Mar 2022 00:33:53 +0200 (EET)
Date:   Tue, 8 Mar 2022 01:33:53 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 23/30] x86/boot: Avoid #VE during boot for TDX platforms
Message-ID: <20220307223353.f7cqzqispfeltvb2@black.fi.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-24-kirill.shutemov@linux.intel.com>
 <e8452e86-4063-c85b-5e21-c7cd6ce51423@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8452e86-4063-c85b-5e21-c7cd6ce51423@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 05:29:27PM +0800, Xiaoyao Li wrote:
> On 3/2/2022 10:27 PM, Kirill A. Shutemov wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > There are a few MSRs and control register bits that the kernel
> > normally needs to modify during boot. But, TDX disallows
> > modification of these registers to help provide consistent security
> > guarantees. Fortunately, TDX ensures that these are all in the correct
> > state before the kernel loads, which means the kernel does not need to
> > modify them.
> > 
> > The conditions to avoid are:
> > 
> >   * Any writes to the EFER MSR
> >   * Clearing CR3.MCE
> 
> typo. CR4.MCE

Thanks, will send updated patch.

> BTW, I remember there was a patch to clear X86_FEATURE_MCE for TDX guest.
> Why does that get dropped?

It is not dropped. It is just not part of the initial submission. It will
come later.

> Even though CPUID reports MCE is supported, all the access to MCE related
> MSRs causes #VE. If they are accessed via mce_rdmsrl(), the #VE will be
> fixed up and goes to ex_handler_msr_mce(). Finally lead to panic().

It is not panic, but warning. Like this:

	unchecked MSR access error: RDMSR from 0x179 at rIP: 0xffffffff810df1e9 (__mcheck_cpu_cap_init+0x9/0x130)
	Call Trace:
	 <TASK>
	 mcheck_cpu_init+0x3d/0x2c0
	 identify_cpu+0x85a/0x910
	 identify_boot_cpu+0xc/0x98
	 check_bugs+0x6/0xa7
	 start_kernel+0x363/0x3d1
	 secondary_startup_64_no_verify+0xe5/0xeb
	 </TASK>

It is annoying, but not fatal. The patchset is big enough as it is.
I tried to keep patch number under control.

-- 
 Kirill A. Shutemov
