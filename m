Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2874C7DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiB1WyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiB1WyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:54:06 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCD213C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646088806; x=1677624806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U6Y6vjD+jEf7iVMM5FIRS9mKmfnFW3TUifUtBoX4S/s=;
  b=V1HFLdG4JZf+5RLgA85yzO8iDOIQWJckK7nNLVk9YUK43yuXK6CBac20
   i6HZJRSlqRSM/pZ3FP5CIHfeifFHfARnCLkBtkHCw4Oo5+ehnw12cScOH
   XeK2lyO2ckxRWbXEROFWllU57hIgX3gcf6v576oAK9NALuP//TlnfmdW9
   Via+gCrOpjVu4xXlW1cvPuFDrlEJMYZlVHJBa0F4SQu6F94r/Tja7t9Rm
   K49/RAwu8X0EucqqmE5xB8ICgBSr1+CY4N6x2l32zYRFTVotfgUgyNgwM
   46V+2yS/bbexKv8WdUD428nRJrLpDJdb6Wp+MG36i/LUS1USnQqAZB9qh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316221811"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="316221811"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 14:53:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="641049548"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2022 14:53:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 3DAC4142; Tue,  1 Mar 2022 00:53:36 +0200 (EET)
Date:   Tue, 1 Mar 2022 01:53:36 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 10/30] x86/tdx: Handle CPUID via #VE
Message-ID: <20220228225336.k3lxk5qqm4vpaocv@black.fi.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-11-kirill.shutemov@linux.intel.com>
 <51b6613d-eabd-941d-19b2-95b33ec27e99@intel.com>
 <20220227010733.abapkmyaroglcafl@black.fi.intel.com>
 <7a8c4e5e-c0ba-ee8e-a912-c71f89b4d4f2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a8c4e5e-c0ba-ee8e-a912-c71f89b4d4f2@intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 08:41:38AM -0800, Dave Hansen wrote:
> > We realise that this is possible vector of attack and plan to implement
> > proper filtering. But it is beyon core enabling.
> > 
> >> Is this better than just returning 0's, for instance?
> > 
> > Plain 0 injection breaks the boot. More complicated solution is need.
> 
> OK, so we're leaving the kernel open to something that might be an
> attack vector: we know that we don't know how this might be bad.  It's a
> "known unknown"[1].

I looked deeper. The only CPUIDs that actually required are from the
hypervisor range (the range is reserved and never will be used by CPU, so
hypervisors adopt it for own use).

So this filtering makes kernel boot (I didn't test much beyond that).

	/*
	 * Only allow VMM to control range reserved for hypervisor
	 * communication.
	 *
	 * Return all-zeros for any CPUID outside the range.
	 */
	if (regs->ax < 0x40000000 || regs->ax > 0x4FFFFFFF) {
		regs->ax = regs->bx = regs->cx = regs->dx = 0;
		return true;
	}

We may tighten the range further (only few leafs from the range is
actually used during the boot), but this should be good enough for this
stage of enabling.

Comments?

-- 
 Kirill A. Shutemov
