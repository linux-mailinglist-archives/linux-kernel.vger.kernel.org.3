Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31C5506CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352431AbiDSMvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346663AbiDSMvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:51:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5243700E;
        Tue, 19 Apr 2022 05:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650372538; x=1681908538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cu8ttrZTtozlzi95obzNrvmh7yZOlBdE43QZNQ1x4ME=;
  b=ZdX5EatRbFR3AZisA9pBT8Lv6NcGcNNf+BHgCIaBikV0bRt7rKmRWg9l
   AXC1J9dTlvswjM7g1oOanzEr7XesFj93/lpcYoI9coMID1aSvhlyhOTKq
   b8mREciWJ7IVbNpnxLeBZinvkkM25fsuxJulndqggyp4gWc/b9Ov2ZuSx
   2V/6eowtD48b6hsoHS56UfYlXgSAB0kOtyot+TCpP31edkChiASTbqElJ
   1n13+F5s8JRW80lwiN/SCwIEGYeyU9BF704DyEPV8dkxvhUsPqmhjapSW
   xux7YcogQQ+uBMQzZ7iL0BBX2qmF3W/uRHa0eFNfClxyn98eYuxifYzmc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="288852895"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="288852895"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 05:48:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="554713824"
Received: from chferrer-mobl.amr.corp.intel.com (HELO [10.209.37.31]) ([10.209.37.31])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 05:48:57 -0700
Message-ID: <9198cc36-67d6-9365-5d18-f23ba4075151@linux.intel.com>
Date:   Tue, 19 Apr 2022 05:48:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Kai Huang <kai.huang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <bd83067542a3519ee4c91f9d50e9bd4fac27e4bb.camel@intel.com>
 <Yl5vGIfUFp4TfTWk@zn.tnic>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Yl5vGIfUFp4TfTWk@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/22 1:13 AM, Borislav Petkov wrote:
> On Tue, Apr 19, 2022 at 07:47:33PM +1200, Kai Huang wrote:
>>  From this perspective, I am not sure what's the value of having a dedicated
>> INTEL_TDX_ATTESTATION Kconfig.  The attestation support code should be turned on
>> unconditionally when CONFIG_INTEL_TDX_GUEST is on.  The code can also be just
>> under arch/x86/coco/tdx/ I guess?
>>
>> But I'll leave this to maintainers.
> 
> Similar story with the unaccepted memory gunk. If it is not going to
> be used outside of encrypted guests, why are we polluting our already
> insanely humongous Kconfig space with more symbols?
> 

Make sense. We can just go with CONFIG_INTEL_TDX_ATTESTATION.

Boris, this is a simple platform driver which adds IOCTL interfaces to 
allow user space to get TDREPORT and TDQuote support.

So, would prefer to leave in platform/x86 or move it to arch/x86/coco/tdx/ ?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
