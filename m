Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7CA4DC80F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiCQN7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiCQN7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:59:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D8A1DFDDD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647525488; x=1679061488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4gcn2ldCMV07X+IFsDeXqQ8hvxzCSSfBLQpzfWx9RZU=;
  b=lgkFHxiemJE6xUWMSNAdliVmRJmBM2SwFtQeXlbh3E/MphrwcB/Dcxoz
   Bkk0kYTuWLxzxy+YVFr4sGN9sGANSxNKDl92NhMIgbMa6+Vx/TYNTkrXY
   AH3vRZ9yuXkIl2VcuzCQ9aoUiXPYiHnIOkjKRfAnkE0njxhYVUpiun3kQ
   vQt3AWnouCojiC0Yuwe+XnxprY1TQcB6bk6j2bZT9NJTApd8pRiFuVSPa
   monLhhh7+3km/6X1bICSN+AudZoKGAxGQOTCL8Xfst3XVxMuBzM0EzWt9
   3LTTJ66khJU/NNJdXE3xx5ViVBRdsuqaMK0C1pOXB8HqWzCZoYtbGONjQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256821691"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256821691"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 06:58:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="821491621"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 17 Mar 2022 06:58:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1F6F5150; Thu, 17 Mar 2022 15:58:20 +0200 (EET)
Date:   Thu, 17 Mar 2022 16:58:20 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 05/30] x86/tdx: Exclude shared bit from __PHYSICAL_MASK
Message-ID: <20220317135820.frdppktft4flzhha@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-6-kirill.shutemov@linux.intel.com>
 <87czil303j.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czil303j.ffs@tglx>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:16:00AM +0100, Thomas Gleixner wrote:
> On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> > @@ -82,6 +82,14 @@ void __init tdx_early_init(void)
> >  
> >  	cc_set_vendor(CC_VENDOR_INTEL);
> >  
> > +	/*
> > +	 * All bits above GPA width are reserved and kernel treats shared bit
> > +	 * as flag, not as part of physical address.
> > +	 *
> > +	 * Adjust physical mask to only cover valid GPA bits.
> > +	 */
> > +	physical_mask &= GENMASK_ULL(gpa_width - 2, 0);
> > +
> 
> Hrm. I forgot about the second use case for gpa_width, but my comment
> about ordering still stands. OTOH:
> 
>          GENMASK_ULL(gpa_width - 2, 0) == BIT_UL(gpa_width - 1) - 1
> 
> right? So you really can consolidate on the fact that cc_mask is a
> single bit which is above the guests physical address space boundary.
> 
> I.e. make the code tell the story instead of adding lengthy comments
> explaining the obfuscation.

So it will looks something like this:


	cc_set_vendor(CC_VENDOR_INTEL);
	cc_mask = get_cc_mask();
	cc_set_mask(cc_mask);

	/*
	 * All bits above GPA width are reserved and kernel treats shared bit
	 * as flag, not as part of physical address.
	 *
	 * Adjust physical mask to only cover valid GPA bits.
	 */
	physical_mask &= cc_mask - 1;

I still think these comments are useful. I hided comment for cc_mask
calclulation inside get_cc_mask().

Does it look fine to you?

-- 
 Kirill A. Shutemov
