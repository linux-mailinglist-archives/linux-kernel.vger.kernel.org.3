Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5054F2051
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiDDXi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiDDXi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:38:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4365F4E0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649115415; x=1680651415;
  h=message-id:subject:from:to:cc:in-reply-to:references:
   mime-version:date:content-transfer-encoding;
  bh=DPU95H2DKWoSP7VPSRVpTSI4950WpQfYUoUy2BB/Up0=;
  b=iSl8n8Q51Ck9WLVXs43bSAM40ZcjrrEBYiMgFBNmm+dUkbgOTz6FF9Sb
   36BXksBQIy7VZWzMGni4ZeOh8Aam2kwuBuOlO/Ml3bdNrj077ZY7V5RSb
   YopC4IDWnhDHut8Ji2oGwA0qxh9r8s526kEnm/3CHLm1w2cYv87ovTDTB
   cJhCpQKYYv2QyvQV0tK6a1tUCc1y+c7vGDidVE53ic9HDrcZfxPfSTJdC
   SNHx1rhRMEXfqQniFDhjx6Oj/tL5gMbONC6ADmopJPQ5bjtU4sdL1l96M
   ljcxIqU9seGNFgqQpTkgwkkzqelf9pott2K/3V4/ihsdhcKaKRuor5uPB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="248145731"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="248145731"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 16:36:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="505080145"
Received: from cwebber-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.54.91])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 16:36:48 -0700
Message-ID: <2fcd12bb42c7d30f0e7bd09a7f66d76122493b32.camel@intel.com>
Subject: Re: [PATCHv7.1 02/30] x86/tdx: Provide common base for SEAMCALL
 and TDCALL C wrappers
From:   Kai Huang <kai.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        bp@alien8.de
Cc:     aarcange@redhat.com, ak@linux.intel.com, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
In-Reply-To: <dd5c52ad-9c61-54c3-6654-7a30c56b1917@intel.com>
References: <YjXtK4awY6utz3wE@zn.tnic>
         <20220321160245.42886-1-kirill.shutemov@linux.intel.com>
         <9f8f57fdbbf76e70471541dc42b04f8a89be4a56.camel@intel.com>
         <dd5c52ad-9c61-54c3-6654-7a30c56b1917@intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 05 Apr 2022 11:35:39 +1200
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-04 at 06:51 -0700, Dave Hansen wrote:
> On 4/3/22 20:19, Kai Huang wrote:
> > Btw, I previous suggested perhaps we can just use -1ULL instead of above value
> > for TDX_SEAMCALL_VMFAILINVALID, but didn't get response.  The reason is this
> > value will only be used when detecting P-SEAMLDR using P-SEAMLDR's SEAMLDR.INFO
> > SEAMCALL.  Note your above SW-defined error codes is based on error code
> > definition for TDX module, but actually P-SEAMLDR has different error code
> > definition:
> 
> I suggested moving away from the -1 because it didn't really carry any
> additional information.  For folks that have the spec open day in and
> day out, it's easy for you to go look up what the components of that -1
> _mean_.
> 
> It sounds like there's a bug here (mixing up the P-SEAMLDR and TDX
> module error ABIs), but that doesn't mean that moving to -1 is the right
> answer.

I think it doesn't need to carry any additional information.  The error code is
used to represent VMfailInvalid, which happens before any P-SEAMLDR and TDX
module internal functionality is reached.  We just need a value which will
*never* conflict with actual error code returned by P-SEAMLDR and TDX module to
represent this case.

Both error code formats defined by P-SEAMLDR and TDX module has some reserved
bits which will never be set to 1.  I think we can just add a simple comment
explaining that and choose a value which has 1 set for those reserved bits (even
doesn't have to be -1). For example:

	/*
	 * Use -1ULL which will never conflict with any actual error code
	 * returned by both the P-SEAMLDR and the TDX module to represent
	 * VMfailInvalid.  Both error code definitions defined by the
	 * P-SEAMLDR and the TDX module have some reserved bits which will
	 * never be set to 1.
	 */
	#define TDX_SEAMCALL_VMFAILINVALID	GENMASK_ULL(63, 0)

> 
> Please just build up an error value the same way it was done for the
> software-defined TDX module error codes.

In this way the assembly code will need to set different value based on whether
%rax is a P-SEAMLDR leaf function and TDX module leaf function.  I think it's
unnecessary.  As I said above, I think this error doesn't need to have any
additional information.  We just need a value which will never conflict with any
actual error code from P-SEAMLDR and TDX module.

-- 
Thanks,
-Kai


