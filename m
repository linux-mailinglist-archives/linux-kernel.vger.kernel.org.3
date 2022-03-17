Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F174DCF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiCQUQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCQUQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:16:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6211B18178A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647548135; x=1679084135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4IEXH+5e8WrDwBBE7fqvs3d479Wemz0Jxmrl5fa4VSk=;
  b=FHUcDv6iM3f9Nwk2qLlzxKJQv70DW/izgDoIPEW83dpcW7JgrgUdVuup
   VnFRnvUtOpfYJPT5JlrBrI4FtUetHQGB+QTsU+pBhuDr1roF3dxZlLqcQ
   ab33yMfbSoCIhQ3qPEKdskXXFgp6hQ3tD+NTPRgDgBqDgFRAf1LOps+/H
   BBpZDxeUcdI9tgEOKH/2+b/2ss3c6c6oRejpI1A2iaS8JPrQbDi10tBeL
   ZvTSGe2QER0h8hAyOJJc7r2ULCaP6qOy6ls0ZPiuU4HS3pfUHWUJUmeRL
   7U7PhEp/qpSp5wTwI8jDpdizmKreuWvIDwacD1ezN67GS8RVIJNDgraCM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="239136817"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="239136817"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:15:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="541524573"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2022 13:15:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C7B55107; Thu, 17 Mar 2022 22:15:47 +0200 (EET)
Date:   Thu, 17 Mar 2022 23:15:47 +0300
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
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 16/30] x86/boot: Port I/O: add decompression-time
 support for TDX
Message-ID: <20220317201547.haoyqy2iaid7lku3@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-17-kirill.shutemov@linux.intel.com>
 <87a6do22t6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6do22t6.ffs@tglx>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:15:01PM +0100, Thomas Gleixner wrote:
> On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> >  void early_tdx_detect(void)
> >  {
> >  	u32 eax, sig[3];
> > @@ -23,4 +94,12 @@ void early_tdx_detect(void)
> >  
> >  	/* Cache TDX guest feature status */
> >  	tdx_guest_detected = true;
> > +
> > +	/* Use hypercalls instead of I/O instructions */
> > +	inb = tdx_inb;
> 
> Eeew. What's wrong with writing this out?
> 
>         pio_ops.inb = tdx_inb;
> 
> So it becomes obvious what this is about?

This leads to preprocessor hell: "pio_ops.inb" is expanded to
"pio_ops.pio_ops.inb" :/

I can rename fields in struct port_io_ops to avoid conflicts, I donno.

-- 
 Kirill A. Shutemov
