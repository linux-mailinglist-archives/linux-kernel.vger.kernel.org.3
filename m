Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51264509286
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbiDTWOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382763AbiDTWMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:12:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C156C34;
        Wed, 20 Apr 2022 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650492587; x=1682028587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H4xfv6xnEOb5EM82ED0+xKFwfPsnVvkv6xR9nOQGtlc=;
  b=M3jCrsdDEfVtUcXaoG4N6812XIXYShiknl+o03cXxYPjiris0pJA8CaL
   oG37lpjyP5+Ee+fZn5y8YAr8PCF/O/GBHDK9btf47foKuGwAuVefSpga0
   1j3b8MYZirhZS83Un7BHi4hlhzkoH9Wx9cD+bp7Z3UfCCf9CpSFMQy59Q
   BaVzVXEc63r4tQe5VkpxQBiGK5/PlrwYLPweJOYMaFn4+kbl1PkuZNW5j
   9tJ8pBZ24uCrSn4r88iBLzERAsnKGyJB8lAaXsPZwn2owiNzIOC6hg8z5
   zFLi1m0ss45mLurKymK636w80W4Kx24IJ2JXzpxiCWxsIjGXbq7T4WD5a
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="251472015"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="251472015"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 15:09:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="593355840"
Received: from dmertma-mobl4.amr.corp.intel.com (HELO [10.209.83.57]) ([10.209.83.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 15:09:44 -0700
Message-ID: <088a3cbc-5d83-ca47-f544-087f0d59e331@linux.intel.com>
Date:   Wed, 20 Apr 2022 15:09:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
 <9198cc36-67d6-9365-5d18-f23ba4075151@linux.intel.com>
 <YmCCdtF10dYZOQ2a@zn.tnic>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <YmCCdtF10dYZOQ2a@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 4/20/22 3:00 PM, Borislav Petkov wrote:
> On Tue, Apr 19, 2022 at 05:48:57AM -0700, Sathyanarayanan Kuppuswamy wrote:
>> Make sense. We can just go with CONFIG_INTEL_TDX_ATTESTATION.
> 
> Sounds like you didn't read my mail. Kai was questioning the need for a
> Kconfig symbol at all. And me too.
> 
> If this thing is not going to be used by anything else besides TDX
> guests, why does it need a Kconfig option at all?!

Sorry, it is a typo. I meant we can just compile it with
TDX guest config (CONFIG_INTEL_TDX_GUEST).

> 
>> Boris, this is a simple platform driver which adds IOCTL interfaces to allow
>> user space to get TDREPORT and TDQuote support.
>>
>> So, would prefer to leave in platform/x86 or move it to arch/x86/coco/tdx/ ?
> 
> See above.

I agree with dropping the new CONFIG option. But regarding driver
location, which is preferred (platform/x86/intel/tdx or arch/x86/coco/tdx/)?

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
