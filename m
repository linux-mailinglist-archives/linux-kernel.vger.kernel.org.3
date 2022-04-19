Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595CB5063E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiDSFbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiDSFbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:31:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4FF27CDE;
        Mon, 18 Apr 2022 22:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650346137; x=1681882137;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i7jy1BHGwW1LviHA0ZQU8zpC85/NRJNY+VQXXa8Akao=;
  b=EE9bABQ+rbjE4fYG7ABqRCK+LWK44BxW3tZNp3xMBdHjFvGhxFlykGII
   MaUL+2qquOAytHQA/f8NvZEZ1XaY2eqz8sWp4QernmDUKsp5rvxLSafLE
   KE3s5ypul+mFMK9FEOAFw4ESkVLSWrMxPUJSVMiG9+2i2N+hooh9m7qZW
   sIq6vEnOAu7UGGvAyrfgrqhcJ0oyeHPcu0v32RsdP5VNfPpTTE8L7Fwoz
   29Z1zhWI5cuGvbkGOjHaXg+753d5CSCmrXSzPRel24sCQPBIXLOhGJKl4
   XL9yA8KlIy6I5g0pxBLo8ro1s8FRUitiX3D/48uq6egWcWz2I1ZKR4jp0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="324121075"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="324121075"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 22:28:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="657507667"
Received: from chferrer-mobl.amr.corp.intel.com (HELO [10.209.37.31]) ([10.209.37.31])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 22:28:53 -0700
Message-ID: <67eda184-6823-7b23-85d2-9ff22bc0d215@linux.intel.com>
Date:   Mon, 18 Apr 2022 22:28:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/4] x86/tdx: Add tdx_hcall_get_quote() API support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <4ad97e6118688faf35e96ade46690c84f6c729f4.camel@intel.com>
 <0a49a4f1-637a-fa92-555f-485b529e6811@linux.intel.com>
 <7f6f73aeb37aeb4339059ad9a139a0d24458affc.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <7f6f73aeb37aeb4339059ad9a139a0d24458affc.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/22 9:40 PM, Kai Huang wrote:
>> Please check the latest 1.0 specification (updated on Feb 2022). It has
>> details about R13 register.
> Thanks.  So it seems GHCI 1.0 has also been updated and it is consistent with
> GHCI 1.5 now.  In this case, why do we still assume 8K shared memory?  Are you
> going to update the driver?
> 

Since the GetQuote spec only requires memory in 4K alignment, we just
went with 8k constant allocation. Since existing users does not
require more than 8k, it works. But I agree that this needs to be
changed.

In next version, I will change the driver to choose the allocation size
based on user space request. Since this change would require us to do
the memory allocation in IOCTL routine (instead of init code), it will
make it slower. But I think this is negligible compared to time it takes
for Quote request. So it should be fine.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
