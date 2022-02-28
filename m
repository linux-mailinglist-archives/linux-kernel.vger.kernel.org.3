Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82964C6096
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 02:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiB1BRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 20:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiB1BRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 20:17:02 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF895C360
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 17:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646010985; x=1677546985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pU4UYG1Sg0Bb8afQagYjk5aFL2rpC6MZhJdzWE/DYN0=;
  b=El/ViBXTwvru0l/lW+ZkoZb0hStH8M+Z4XxrsYTxLjkaAdtqKHFmR/5W
   5SSymTtDcsgLsbKNyta4ybsUX77RFFxIrIyExV4xREqDm2UwJ8Ud2p8kO
   +kFRUCOTSUJWUIPt2c3zMyt/7jV4h00oDaSOOELaR6WZifOqiXwIgfZoj
   z5898SnVCt9Bjf33Por9Vhqgh2fCZZ0lVEsQyhb22Gu0NF5zRWl24QpRZ
   wHkhcKgwVDY3ACerlyV6OMJZq8p81pn3EQmF/DfTK7MgR+CcYDcB9x3fg
   2bdovvAwAXmwwAC3qf2+jIoOr/NrPM/a/nhSdDcvwPLAxvLUyRp/AgfVi
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="240187386"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="240187386"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 17:16:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="685179501"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2022 17:16:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 43C51142; Mon, 28 Feb 2022 03:16:27 +0200 (EET)
Date:   Mon, 28 Feb 2022 04:16:27 +0300
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
Subject: Re: [PATCHv4 17/30] x86/tdx: Add port I/O emulation
Message-ID: <20220228011627.63355pcbpn7tosiy@black.fi.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-18-kirill.shutemov@linux.intel.com>
 <dd370f1e-e9f9-0843-da24-83ad6f99ec76@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd370f1e-e9f9-0843-da24-83ad6f99ec76@intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 07:59:51PM -0800, Dave Hansen wrote:
> On 2/24/22 07:56, Kirill A. Shutemov wrote:
> > @@ -347,6 +399,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
> >  		return handle_cpuid(regs);
> >  	case EXIT_REASON_EPT_VIOLATION:
> >  		return handle_mmio(regs, ve);
> > +	case EXIT_REASON_IO_INSTRUCTION:
> > +		return handle_io(regs, ve->exit_qual);
> 
> Sorry to keep throwing random new things at this patch set.  Thanks for
> bearing with me.
> 
> Is there anything to keep these port I/O #VE's from occurring in
> userspace?  It's not how things are normally done, but is there
> something fundamental to keep ioperm() and friends from working in TDX
> guests?
> 
> As it stands with this set, userspace would probably
> 1. Succeed with the ioperm()
> 2. Do a port I/O instruction
> 3. Trigger a #VE
> 4. Get killed by the SIGSEGV that came from the #VE handler
> 
> That's not a horrible state of affairs.  But, if this *can* happen, it
> might be nice to just refuse the ioperm() in the first place.

Right, there's a way to get port I/O from userspace and we are not
intended to support it. And, yes, ioperm() is the right place to do this.

We considered to make it happen via security lockdown mechanism. It
already block port I/O (LOCKDOWN_IOPORT) and does more stuff that can be
considered useful for paranoid guest. I'm not sure it is the right way to
go. Will see.

Anyway, it is in our plans to sort it out, but it is not in scope of core
enabling. Let's make it functional first.

-- 
 Kirill A. Shutemov
