Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983CE50701D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353218AbiDSOXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353224AbiDSOW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:22:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D981A05E;
        Tue, 19 Apr 2022 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650377982; x=1681913982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lubtMG0hVM3ZxlYnPXyxs8uWuEZI28b2FYE4ZGmmLF4=;
  b=aSZbqBNfNdb6/ymp0+m+X+36cI+/744u9etI2f63ih4Iz+NAHf0QTTwm
   wbMLCTuZpLCbG7Ggoe2tGzY+qW6Y2U7vJbvzPtltoXInCYSn4Ma0gXfHf
   BiA5VwEQapUzrKvxCGXqqsQoqWAmjSTJ0GPXVJ6mjko4w4j8EvN+Obsoj
   f/frxc2MmKkJOWH08pMG2D19sOlYWpJyCryRX7/qodqGZHXrx2Bz3yZu9
   YxbYYhAsGmHRi5I9sHg1CHaoI01dmM121KTloK2B45iXtDuvCPII7WThz
   buxmtSrYW4/+OX4PCHz0v7BQvApQ7B5nc/2GzKqD0TCroLWQmowIzhbil
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245666876"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="245666876"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:19:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="554747335"
Received: from chferrer-mobl.amr.corp.intel.com (HELO [10.209.37.31]) ([10.209.37.31])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:19:41 -0700
Message-ID: <4875ea9c-593a-e669-889a-1e809a50a570@linux.intel.com>
Date:   Tue, 19 Apr 2022 07:19:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@intel.com>,
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
 <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <bd83067542a3519ee4c91f9d50e9bd4fac27e4bb.camel@intel.com>
 <975b5050-2108-9ace-cc71-46f17db0a731@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <975b5050-2108-9ace-cc71-46f17db0a731@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/22 7:13 AM, Dave Hansen wrote:
>> >From this perspective, I am not sure what's the value of having a dedicated
>> INTEL_TDX_ATTESTATION Kconfig.  The attestation support code should be turned on
>> unconditionally when CONFIG_INTEL_TDX_GUEST is on.  The code can also be just
>> under arch/x86/coco/tdx/ I guess?
> How much code are we talking about?  What's the difference in the size
> of the binaries with this compiled in?

Current driver size is ~300 lines. It adds ~500 bytes to the kernel
binary if it is built-in.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
