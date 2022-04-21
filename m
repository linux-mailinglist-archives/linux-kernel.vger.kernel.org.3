Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB9950951F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 04:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383794AbiDUCpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 22:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDUCo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 22:44:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35F3B3E;
        Wed, 20 Apr 2022 19:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650508930; x=1682044930;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QvTMlm8zkmv6XEevm736zdXwgrbOlcTEqT+gBwIB7y4=;
  b=caKcb+/QUTyH4FNxoZQxr+8dwFpzmMnRMR/C0971aMoF+8dyRUlM2UYD
   kH2ZbPVQQI5v9ezlgqD7nlugtMf2favJunhWHJXrmjBGh+GeSATZ61ZNg
   5shjaKRjQ60q3hA+K8niJB/kBXD29IBNGMM8Md2wpHyvID8dFozEey5eD
   Zsp3roEB80MGp8zgyIWdwXf5hOjuZ8HdLsvuZ1hGysJRJ59paaDVQvLYv
   XYQjSV1RNSkcjwpxr6Z+SqHvX8ePLzxTfXLWgiczwjskIcuNkzNAuVzPB
   t00DH0IYd7BtK0I8l3kE09IEZ3VgGtbh0h6hhMEwro0YGpPaJKe05l5ht
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244798148"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="244798148"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 19:42:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="555520403"
Received: from dmertma-mobl4.amr.corp.intel.com (HELO [10.209.83.57]) ([10.209.83.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 19:42:09 -0700
Message-ID: <1e184b44-8024-b8ae-98a8-cf2b6f78df61@linux.intel.com>
Date:   Wed, 20 Apr 2022 19:42:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
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
        platform-driver-x86@vger.kernel.org, isaku.yamahata@gmail.com
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <b209ee09b74394ab7aed85e0244e2191ee3d4171.camel@intel.com>
 <e0e2e399-2cac-cf75-2a64-9d017e6d7189@linux.intel.com>
 <420a4d689f73f9f7dc1ef71c61da75b7c9777a3f.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <420a4d689f73f9f7dc1ef71c61da75b7c9777a3f.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/22 5:11 PM, Kai Huang wrote:
> On Wed, 2022-04-20 at 16:45 -0700, Sathyanarayanan Kuppuswamy wrote:
>> If we want to support multiple GetQuote requests in parallel, then we
>> need some way to uniquely identify the GetQuote requests. So that when
>> we get completion notification, we can understand which request is
>> completed. This part is not mentioned/discussed in ABI spec. So we want
>> to serialize the requests for now.
>>
> 
> Yes it's unfortunate that this part (whether concurrent GetQuote requests are
> supported by TDX architecture) is not explicitly mentioned in GHCI spec.  I am
> fine with only supporting GetQuote requests one by one.  AFAICT there's no
> request to support concurrent GetQuote requests anyway.  What concerns me is
> exactly how explain this.
> 
> As I said, we have GET_QUOTE_IN_FLIGHT flag now.  Theoretically, you can queue
> multiple GetQuote requests, and when you receive the interrupt, you check which
> buffer has GET_QUOTE_IN_FLIGHT cleared.  That buffer is the one with Quote
> ready.  However I am not 100% sure whether above will always work.  Interrupt
> can get lost when there are multiple Quotes ready in multiple buffer in very
> short time period, etc?  Perhaps Isaku can provide more input here.

Either supported or not, it should be mentioned in the GHCI spec. 
Currently, there are no details related to it. If it is supported, the 
specification should include the protocol to use.

I will check with Isaku about it.

> 
> Anyway, how about explaining in this way:
> 
> "The GHCI spec doesn't clearly say whether TDX can support or how to support
> multiple GetQuote requests in parallel.  Attestation request is not supposed to
> be frequent and should not be in performance critical path.  Only support
> GetQuote requests in serialized way for now."

It seems good enough. I will use it.

> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
